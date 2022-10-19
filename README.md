# odin-hot-reload
Simple solution for hot reloading a section of code as a DLL, with an example.

The method is just to compile two versions of the DLL, load one of them, and when the DLL is to be update it, recompile into the unused DLL, unload the current version, and load the new version. Simple as.

Just copy the `hot_reload` folder into your project, to use the `HotLib` struct and its helper functions in the project.

Init code used in `hot_reload_example` is right before `for running {` on line 78. Calling code is used in the `hot_reload_window` procedure in `hot_reload_example`.
