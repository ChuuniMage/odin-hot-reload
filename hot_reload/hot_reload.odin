//PREREQUISITES:
//a `hotcode` directory, where your HotLib will be in
//... That's it.

package hot_reload;

import "core:c/libc"
import "core:dynlib"
import "core:fmt"
import "core:strings"

HotLib :: struct {
    name:string,
    rawptr:dynlib.Library,
    idx:int,
    dirs:[]string,
}

hotlib_init :: proc (hl:^HotLib, name:string) {
    hl.name = name
    hl.dirs = make([]string, 2)
    hl.dirs[0] = fmt.aprintf("%v%v.dll", name, "a")
    hl.dirs[1] = fmt.aprintf("%v%v.dll", name, "b")
    hotlib_compile_dll(hl)
    hl.idx = 1; defer hl.idx = 0
    hotlib_compile_dll(hl)
}

hotlib_compile_dll :: proc (hl:^HotLib) {
    compile_command := fmt.tprintf("odin build hotcode/%v.odin -build-mode:dll -out:hotcode/%v -file", hl.name, hl.dirs[hl.idx])
    cstr := strings.clone_to_cstring(compile_command, context.temp_allocator)    
    libc.system(cstr)
}

hotlib_load :: proc(lib:^HotLib) {
	ok: bool
	lib.rawptr, ok = dynlib.load_library(fmt.tprintf("./hotcode/%v",lib.dirs[lib.idx])) //Get the dynamic library from a string
	if !ok do fmt.panicf("can't load lib %v", lib.name)
}

hotlib_unload :: proc(lib: ^HotLib) {
    lib.idx = 1 - lib.idx
	if !dynlib.unload_library(lib.rawptr) do fmt.panicf("failed to unload lib %v", lib.name)
}

GreetStruct :: struct {
    using lib:HotLib,
    greet:proc(),
}


hotlib_update_greet :: proc (gs:^GreetStruct) {
    f, ok := dynlib.symbol_address(gs.lib.rawptr, "greet")
    if !ok do fmt.panicf("can't find sym")

    gs.greet = cast(type_of(gs.greet))f
}

hotlib_update :: proc{hotlib_update_greet}

