package imgui;

//ImColor 
Color :: struct {
	value: Vec4,
}

//ImDrawChannel 
Draw_Channel :: struct {
	_cmd_buffer: Im_Vector(Draw_Cmd),
	_idx_buffer: Im_Vector(Draw_Idx),
}

//ImDrawCmd 
Draw_Cmd :: struct {
	clip_rect:          Vec4,
	texture_id:         Texture_ID,
	vtx_offset:         u32,
	idx_offset:         u32,
	elem_count:         u32,
	user_callback:      Draw_Callback,
	user_callback_data: rawptr,
}

//ImDrawCmdHeader 
Draw_Cmd_Header :: struct {
	clip_rect:  Vec4,
	texture_id: Texture_ID,
	vtx_offset: u32,
}

//ImDrawData 
Draw_Data :: struct {
	valid:             bool,
	cmd_lists_count:   i32,
	total_idx_count:   i32,
	total_vtx_count:   i32,
	cmd_lists:         ^^Draw_List,
	display_pos:       Vec2,
	display_size:      Vec2,
	framebuffer_scale: Vec2,
	owner_viewport:    ^Viewport,
}

//ImDrawList 
Draw_List :: struct {
	cmd_buffer:        Im_Vector(Draw_Cmd),
	idx_buffer:        Im_Vector(Draw_Idx),
	vtx_buffer:        Im_Vector(Draw_Vert),
	flags:             Draw_List_Flags,
	_vtx_current_idx:  u32,
	_data:             ^Draw_List_Shared_Data,
	_owner_name:       cstring,
	_vtx_write_ptr:    ^Draw_Vert,
	_idx_write_ptr:    ^Draw_Idx,
	_clip_rect_stack:  Im_Vector(Vec4),
	_texture_id_stack: Im_Vector(Texture_ID),
	_path:             Im_Vector(Vec2),
	_cmd_header:       Draw_Cmd_Header,
	_splitter:         Draw_List_Splitter,
	_fringe_scale:     f32,
}

//ImDrawListSplitter 
Draw_List_Splitter :: struct {
	_current:  i32,
	_count:    i32,
	_channels: Im_Vector(Draw_Channel),
}

//ImDrawVert 
Draw_Vert :: struct {
	pos: Vec2,
	uv:  Vec2,
	col: u32,
}

//ImFont 
ImFont :: struct {
	index_advance_x:       Im_Vector(f32),
	fallback_advance_x:    f32,
	font_size:             f32,
	index_lookup:          Im_Vector(Wchar),
	glyphs:                Im_Vector(Font_Glyph),
	fallback_glyph:        ^Font_Glyph,
	container_atlas:       ^Font_Atlas,
	config_data:           ^Font_Config,
	config_data_count:     i16,
	fallback_char:         Wchar,
	ellipsis_char:         Wchar,
	dot_char:              Wchar,
	dirty_lookup_tables:   bool,
	scale:                 f32,
	ascent:                f32,
	descent:               f32,
	metrics_total_surface: i32,
	used4k_pages_map:      [2]u8,
}

//ImFontAtlas 
Font_Atlas :: struct {
	flags:                 Font_Atlas_Flags,
	tex_id:                Texture_ID,
	tex_desired_width:     i32,
	tex_glyph_padding:     i32,
	locked:                bool,
	tex_ready:             bool,
	tex_pixels_use_colors: bool,
	tex_pixels_alpha8:     ^u8,
	tex_pixels_rgba32:     ^u32,
	tex_width:             i32,
	tex_height:            i32,
	tex_uv_scale:          Vec2,
	tex_uv_white_pixel:    Vec2,
	fonts:                 Im_Vector(^ImFont),
	custom_rects:          Im_Vector(Font_Atlas_Custom_Rect),
	config_data:           Im_Vector(Font_Config),
	tex_uv_lines:          [64]Vec4,
	font_builder_io:       ^Font_Builder_Io,
	font_builder_flags:    u32,
	pack_id_mouse_cursors: i32,
	pack_id_lines:         i32,
}

//ImFontAtlasCustomRect 
Font_Atlas_Custom_Rect :: struct {
	width:           u16,
	height:          u16,
	x:               u16,
	y:               u16,
	glyph_id:        u32,
	glyph_advance_x: f32,
	glyph_offset:    Vec2,
	font:            ^ImFont,
}

//ImFontConfig 
Font_Config :: struct {
	font_data:                rawptr,
	font_data_size:           i32,
	font_data_owned_by_atlas: bool,
	font_no:                  i32,
	size_pixels:              f32,
	oversample_h:             i32,
	oversample_v:             i32,
	pixel_snap_h:             bool,
	glyph_extra_spacing:      Vec2,
	glyph_offset:             Vec2,
	glyph_ranges:             ^Wchar,
	glyph_min_advance_x:      f32,
	glyph_max_advance_x:      f32,
	merge_mode:               bool,
	font_builder_flags:       u32,
	rasterizer_multiply:      f32,
	ellipsis_char:            Wchar,
	name:                     [40]i8,
	dst_font:                 ^ImFont,
}

//ImFontGlyph 
Font_Glyph :: struct {
	colored:   u32,
	visible:   u32,
	codepoint: u32,
	advance_x: f32,
	x0:        f32,
	y0:        f32,
	x1:        f32,
	y1:        f32,
	u0:        f32,
	v0:        f32,
	u1:        f32,
	v1:        f32,
}

//ImFontGlyphRangesBuilder 
Font_Glyph_Ranges_Builder :: struct {
	used_chars: Im_Vector(u32),
}

//ImGuiIO 
IO :: struct {
	config_flags:                            Config_Flags,
	backend_flags:                           Backend_Flags,
	display_size:                            Vec2,
	delta_time:                              f32,
	ini_saving_rate:                         f32,
	ini_filename:                            cstring,
	log_filename:                            cstring,
	mouse_double_click_time:                 f32,
	mouse_double_click_max_dist:             f32,
	mouse_drag_threshold:                    f32,
	key_repeat_delay:                        f32,
	key_repeat_rate:                         f32,
	user_data:                               rawptr,
	fonts:                                   ^Font_Atlas,
	font_global_scale:                       f32,
	font_allow_user_scaling:                 bool,
	font_default:                            ^ImFont,
	display_framebuffer_scale:               Vec2,
	config_docking_no_split:                 bool,
	config_docking_with_shift:               bool,
	config_docking_always_tab_bar:           bool,
	config_docking_transparent_payload:      bool,
	config_viewports_no_auto_merge:          bool,
	config_viewports_no_task_bar_icon:       bool,
	config_viewports_no_decoration:          bool,
	config_viewports_no_default_parent:      bool,
	mouse_draw_cursor:                       bool,
	config_mac_osx_behaviors:                bool,
	config_input_trickle_event_queue:        bool,
	config_input_text_cursor_blink:          bool,
	config_drag_click_to_input_text:         bool,
	config_windows_resize_from_edges:        bool,
	config_windows_move_from_title_bar_only: bool,
	config_memory_compact_timer:             f32,
	backend_platform_name:                   cstring,
	backend_renderer_name:                   cstring,
	backend_platform_user_data:              rawptr,
	backend_renderer_user_data:              rawptr,
	backend_language_user_data:              rawptr,
	get_clipboard_text_fn:                   proc "c"(user_data : rawptr) -> cstring,
	set_clipboard_text_fn:                   proc "c"(user_data : rawptr, text : cstring),
	clipboard_user_data:                     rawptr,
	set_platform_ime_data_fn:                proc "c"(viewport: ^Viewport, data: ^Platform_Ime_Data),
	_unused_padding:                         rawptr,
	want_capture_mouse:                      bool,
	want_capture_keyboard:                   bool,
	want_text_input:                         bool,
	want_set_mouse_pos:                      bool,
	want_save_ini_settings:                  bool,
	nav_active:                              bool,
	nav_visible:                             bool,
	framerate:                               f32,
	metrics_render_vertices:                 i32,
	metrics_render_indices:                  i32,
	metrics_render_windows:                  i32,
	metrics_active_windows:                  i32,
	metrics_active_allocations:              i32,
	mouse_delta:                             Vec2,
	key_map:                                 [645]i32,
	keys_down:                               [645]bool,
	mouse_pos:                               Vec2,
	mouse_down:                              [5]bool,
	mouse_wheel:                             f32,
	mouse_wheel_h:                           f32,
	mouse_hovered_viewport:                  ImID,
	key_ctrl:                                bool,
	key_shift:                               bool,
	key_alt:                                 bool,
	key_super:                               bool,
	nav_inputs:                              [20]f32,
	key_mods:                                Mod_Flags,
	keys_data:                               [645]Key_Data,
	want_capture_mouse_unless_popup_close:   bool,
	mouse_pos_prev:                          Vec2,
	mouse_clicked_pos:                       [5]Vec2,
	mouse_clicked_time:                      [5]f64,
	mouse_clicked:                           [5]bool,
	mouse_double_clicked:                    [5]bool,
	mouse_clicked_count:                     [5]u16,
	mouse_clicked_last_count:                [5]u16,
	mouse_released:                          [5]bool,
	mouse_down_owned:                        [5]bool,
	mouse_down_owned_unless_popup_close:     [5]bool,
	mouse_down_duration:                     [5]f32,
	mouse_down_duration_prev:                [5]f32,
	mouse_drag_max_distance_abs:             [5]Vec2,
	mouse_drag_max_distance_sqr:             [5]f32,
	nav_inputs_down_duration:                [20]f32,
	nav_inputs_down_duration_prev:           [20]f32,
	pen_pressure:                            f32,
	app_focus_lost:                          bool,
	app_accepting_events:                    bool,
	backend_using_legacy_key_arrays:         i8,
	backend_using_legacy_nav_input_array:    bool,
	input_queue_surrogate:                   Wchar16,
	input_queue_characters:                  Im_Vector(Wchar),
}

//ImGuiInputTextCallbackData 
Input_Text_Callback_Data :: struct {
	event_flag:      Input_Text_Flags,
	flags:           Input_Text_Flags,
	user_data:       rawptr,
	event_char:      Wchar,
	event_key:       Key,
	buf:             cstring,
	buf_text_len:    i32,
	buf_size:        i32,
	buf_dirty:       bool,
	cursor_pos:      i32,
	selection_start: i32,
	selection_end:   i32,
}

//ImGuiKeyData 
Key_Data :: struct {
	down:               bool,
	down_duration:      f32,
	down_duration_prev: f32,
	analog_value:       f32,
}

//ImGuiListClipper 
List_Clipper :: struct {
	display_start: i32,
	display_end:   i32,
	items_count:   i32,
	items_height:  f32,
	start_pos_y:   f32,
	temp_data:     rawptr,
}

//ImGuiOnceUponAFrame 
Once_Upon_A_Frame :: struct {
	ref_frame: i32,
}

//ImGuiPayload 
Payload :: struct {
	data:             rawptr,
	data_size:        i32,
	source_id:        ImID,
	source_parent_id: ImID,
	data_frame_count: i32,
	data_type:        [33]i8,
	preview:          bool,
	delivery:         bool,
}

//ImGuiPlatformIO 
Platform_Io :: struct {
	platform_create_window:        proc "c"(vp: ^Viewport),
	platform_destroy_window:       proc "c"(vp: ^Viewport),
	platform_show_window:          proc "c"(vp: ^Viewport),
	platform_set_window_pos:       proc "c"(vp: ^Viewport, pos: Vec2),
	platform_get_window_pos:       proc "c"(vp: ^Viewport) -> Vec2,
	platform_set_window_size:      proc "c"(vp: ^Viewport, size: Vec2),
	platform_get_window_size:      proc "c"(vp: ^Viewport) -> Vec2,
	platform_set_window_focus:     proc "c"(vp: ^Viewport),
	platform_get_window_focus:     proc "c"(vp: ^Viewport) -> bool,
	platform_get_window_minimized: proc "c"(vp: ^Viewport) -> bool,
	platform_set_window_title:     proc "c"(vp: ^Viewport, str: cstring),
	platform_set_window_alpha:     proc "c"(vp: ^Viewport, alpha: f32),
	platform_update_window:        proc "c"(vp: ^Viewport),
	platform_render_window:        proc "c"(vp: ^Viewport, render_arg: rawptr),
	platform_swap_buffers:         proc "c"(vp: ^Viewport, render_arg: rawptr),
	platform_get_window_dpi_scale: proc "c"(vp: ^Viewport) -> f32,
	platform_on_changed_viewport:  proc "c"(vp: ^Viewport),
	platform_create_vk_surface:    proc "c"(vp: ^Viewport, vk_inst: u64, vk_allocators: rawptr, out_vk_surface: ^u64) -> i32,
	renderer_create_window:        proc "c"(vp: ^Viewport),
	renderer_destroy_window:       proc "c"(vp: ^Viewport),
	renderer_set_window_size:      proc "c"(vp: ^Viewport, size: Vec2),
	renderer_render_window:        proc "c"(vp: ^Viewport, render_arg: rawptr),
	renderer_swap_buffers:         proc "c"(vp: ^Viewport, render_arg: rawptr),
	monitors:                      Platform_Monitor,
	viewports:                     Im_Vector(^Viewport),
}

//ImGuiPlatformImeData 
Platform_Ime_Data :: struct {
	want_visible:      bool,
	input_pos:         Vec2,
	input_line_height: f32,
}

//ImGuiPlatformMonitor 
Platform_Monitor :: struct {
	main_pos:  Vec2,
	main_size: Vec2,
	work_pos:  Vec2,
	work_size: Vec2,
	dpi_scale: f32,
}

//ImGuiSizeCallbackData 
Size_Callback_Data :: struct {
	user_data:    rawptr,
	pos:          Vec2,
	current_size: Vec2,
	desired_size: Vec2,
}

//ImGuiStorage 
Storage :: struct {
	data: Im_Vector(Storage_Pair),
}

Storage_Pair :: struct {
    key: ImID,
    using _: struct #raw_union { 
        val_i: i32, 
        val_f: f32, 
        val_p: rawptr,
    },
}


//ImGuiStyle 
Style :: struct {
	alpha:                          f32,
	disabled_alpha:                 f32,
	window_padding:                 Vec2,
	window_rounding:                f32,
	window_border_size:             f32,
	window_min_size:                Vec2,
	window_title_align:             Vec2,
	window_menu_button_position:    Dir,
	child_rounding:                 f32,
	child_border_size:              f32,
	popup_rounding:                 f32,
	popup_border_size:              f32,
	frame_padding:                  Vec2,
	frame_rounding:                 f32,
	frame_border_size:              f32,
	item_spacing:                   Vec2,
	item_inner_spacing:             Vec2,
	cell_padding:                   Vec2,
	touch_extra_padding:            Vec2,
	indent_spacing:                 f32,
	columns_min_spacing:            f32,
	scrollbar_size:                 f32,
	scrollbar_rounding:             f32,
	grab_min_size:                  f32,
	grab_rounding:                  f32,
	log_slider_deadzone:            f32,
	tab_rounding:                   f32,
	tab_border_size:                f32,
	tab_min_width_for_close_button: f32,
	color_button_position:          Dir,
	button_text_align:              Vec2,
	selectable_text_align:          Vec2,
	display_window_padding:         Vec2,
	display_safe_area_padding:      Vec2,
	mouse_cursor_scale:             f32,
	anti_aliased_lines:             bool,
	anti_aliased_lines_use_tex:     bool,
	anti_aliased_fill:              bool,
	curve_tessellation_tol:         f32,
	circle_tessellation_max_error:  f32,
	colors:                         [55]Vec4,
}

//ImGuiTableColumnSortSpecs 
Table_Column_Sort_Specs :: struct {
	column_user_id: ImID,
	column_index:   i16,
	sort_order:     i16,
	sort_direction: Sort_Direction,
}

//ImGuiTableSortSpecs 
Table_Sort_Specs :: struct {
	specs:       ^Table_Column_Sort_Specs,
	specs_count: i32,
	specs_dirty: bool,
}

//ImGuiTextBuffer 
Text_Buffer :: struct {
	buf: Im_Vector(u8),
}

//ImGuiTextFilter 
Text_Filter :: struct {
	input_buf:  [256]i8,
	filters:    Im_Vector(Text_Range),
	count_grep: i32,
}

//ImGuiTextRange 
Text_Range :: struct {
	b: cstring,
	e: cstring,
}

//ImGuiViewport 
Viewport :: struct {
	id:                      ImID,
	flags:                   Viewport_Flags,
	pos:                     Vec2,
	size:                    Vec2,
	work_pos:                Vec2,
	work_size:               Vec2,
	dpi_scale:               f32,
	parent_viewport_id:      ImID,
	draw_data:               ^Draw_Data,
	renderer_user_data:      rawptr,
	platform_user_data:      rawptr,
	platform_handle:         rawptr,
	platform_handle_raw:     rawptr,
	platform_request_move:   bool,
	platform_request_resize: bool,
	platform_request_close:  bool,
}

//ImGuiWindowClass 
Window_Class :: struct {
	class_id:                      ImID,
	parent_viewport_id:            ImID,
	viewport_flags_override_set:   Viewport_Flags,
	viewport_flags_override_clear: Viewport_Flags,
	tab_item_flags_override_set:   Tab_Item_Flags,
	dock_node_flags_override_set:  Dock_Node_Flags,
	docking_always_tab_bar:        bool,
	docking_allow_unclassed:       bool,
}

//ImVec2 
Vec2 :: struct {
	x: f32,
	y: f32,
}

//ImVec4 
Vec4 :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}

