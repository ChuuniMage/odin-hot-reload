package main;

import "core:fmt"
import "core:log";


import sdl "vendor:sdl2";
import gl  "vendor:OpenGL";

import imgui "odin-imgui";
import imgl  "odin-imgui/impl/opengl";
import imsdl "odin-imgui/impl/sdl";
import hr "hot_reload"

enum_filename :: "enum.odin"
package_name :: "main"

DESIRED_GL_MAJOR_VERSION :: 4;
DESIRED_GL_MINOR_VERSION :: 5;

main :: proc() {
    logger_opts := log.Options {
        .Level,
        .Line,
        .Procedure,
    };
    context.logger = log.create_console_logger(opt = logger_opts);

    log.info("Starting SDL Example...");
    init_err := sdl.Init({.VIDEO});
    defer sdl.Quit();
    if init_err != 0 {
        log.debugf("Error during SDL init: (%d)%s", init_err, sdl.GetError());
        return
    }

    log.info("Setting up the window...");
    window := sdl.CreateWindow("odin-imgui SDL+OpenGL example", 100, 100, 1280, 720, { .OPENGL, .MOUSE_FOCUS, .SHOWN, .RESIZABLE});
    if window == nil {
        log.debugf("Error during window creation: %s", sdl.GetError());
        sdl.Quit();
        return;
    }
    defer sdl.DestroyWindow(window);

    log.info("Setting up the OpenGL...");
    sdl.GL_SetAttribute(.CONTEXT_MAJOR_VERSION, DESIRED_GL_MAJOR_VERSION);
    sdl.GL_SetAttribute(.CONTEXT_MINOR_VERSION, DESIRED_GL_MINOR_VERSION);
    sdl.GL_SetAttribute(.CONTEXT_PROFILE_MASK, i32(sdl.GLprofile.CORE));
    sdl.GL_SetAttribute(.DOUBLEBUFFER, 1);
    sdl.GL_SetAttribute(.DEPTH_SIZE, 24);
    sdl.GL_SetAttribute(.STENCIL_SIZE, 8);
    gl_ctx := sdl.GL_CreateContext(window);
    if gl_ctx == nil {
        log.debugf("Error during window creation: %s", sdl.GetError()); 
        return;
    }
    sdl.GL_MakeCurrent(window, gl_ctx);
    defer sdl.GL_DeleteContext(gl_ctx);
    if sdl.GL_SetSwapInterval(1) != 0 {
        log.debugf("Error during window creation: %s", sdl.GetError());
        return;
    }
    gl.load_up_to(DESIRED_GL_MAJOR_VERSION, DESIRED_GL_MINOR_VERSION, sdl.gl_set_proc_address);
    gl.ClearColor(0.25, 0.25, 0.25, 1);

    imgui_state := init_imgui_state(window);

    running := true;
    show_demo_window := false;
    e := sdl.Event{};
    using hr
    gs:GreetStruct
    hotlib_init(&gs, "greet")
    hotlib_load(&gs)
    hotlib_update(&gs)
    fmt.printf("GronkQWRQT!")
    for running {
        for sdl.PollEvent(&e) {
            imsdl.process_event(e, &imgui_state.sdl_state);
            #partial switch e.type {
                case .QUIT:
                    log.info("Got SDL_QUIT event!");
                    running = false;
                case .KEYDOWN: #partial switch e.key.keysym.sym {
                    case .ESCAPE: sdl.PushEvent(&sdl.Event{type = .QUIT});
                    case .TAB: if imgui.get_io().want_capture_keyboard == false do show_demo_window = true;
                }
            }
        }

        imgui_new_frame(window, &imgui_state);


            
        imgui.new_frame();
        
        info_overlay();

        if show_demo_window do imgui.show_demo_window(&show_demo_window);

        hot_reload_window(&gs)
        gs.greet()

        imgui.render();

        io := imgui.get_io();
        gl.Viewport(0, 0, i32(io.display_size.x), i32(io.display_size.y));
        gl.Scissor(0, 0, i32(io.display_size.x), i32(io.display_size.y));
        gl.Clear(gl.COLOR_BUFFER_BIT);
        imgl.imgui_render(imgui.get_draw_data(), imgui_state.opengl_state);
        sdl.GL_SwapWindow(window);
    }
    log.info("Shutting down...");

}

info_overlay :: proc() {
    imgui.set_next_window_pos(imgui.Vec2{10, 10});
    imgui.set_next_window_bg_alpha(0.2);
    overlay_flags: imgui.Window_Flags = .NoDecoration | 
                                        .AlwaysAutoResize | 
                                        .NoSavedSettings | 
                                        .NoFocusOnAppearing | 
                                        .NoNav | 
                                        .NoMove;
    imgui.begin("Info", nil, overlay_flags);
    imgui.text_unformatted("Press Esc to close the application");
    imgui.text_unformatted("Press Tab to show demo window");
    imgui.end();
}

Imgui_State :: struct {
    sdl_state: imsdl.SDL_State,
    opengl_state: imgl.OpenGL_State,
}

init_imgui_state :: proc(window: ^sdl.Window) -> Imgui_State {
    using res := Imgui_State{};

    imgui.create_context();
    imgui.style_colors_dark();

    imsdl.setup_state(&res.sdl_state);
    
    imgl.setup_state(&res.opengl_state);

    return res;
}

imgui_new_frame :: proc(window: ^sdl.Window, state: ^Imgui_State) {
    imsdl.update_display_size(window);
    imsdl.update_mouse(&state.sdl_state, window);
    imsdl.update_dt(&state.sdl_state);
}

hot_reload_window :: proc (gs:^hr.GreetStruct) {
    using hr
	imgui.begin("Reload the DLL");
    imgui.text("Honk")

	if imgui.button("Reload DLL!") {
        hotlib_unload(gs)
        hotlib_compile_dll(gs)
        hotlib_load(gs)
        hotlib_update(gs)
	}
	imgui.end()
}