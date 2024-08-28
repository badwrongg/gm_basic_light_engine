/// @description Render Lighting

// Get camera values and calculate x/y to draw surfaces at
var _cam		 = view_get_camera(view_current),
	_s_width     = surface_get_width(application_surface),
	_s_height    = surface_get_height(application_surface),
	_view_mat	 = camera_get_view_mat(_cam),
	_view_width  = camera_get_view_width(_cam) * 0.5,
	_view_height = camera_get_view_height(_cam) * 0.5,
	_xscale      = camera_get_view_width(_cam)/_s_width,
	_yscale      = camera_get_view_height(_cam)/_s_height,
	// Allows for rotated camera view
	_view_x      = camera_get_view_x(_cam) + _view_width  - _view_width  * _view_mat[0] - _view_height * _view_mat[1],
	_view_y      = camera_get_view_y(_cam) + _view_height + _view_width  * _view_mat[1] - _view_height * _view_mat[0],
	_angle		 = -camera_get_view_angle(_cam);

// Populate light array
var _count = instance_number(__light),
	_light_arr = array_create(_count * LIGHT_PROPERTIES + 1),
	_index = 1;
	
_light_arr[0] = _count;

with __light 
{
	_light_arr[_index++] = x;
	_light_arr[_index++] = y;
	_light_arr[_index++] = image_blend;
	_light_arr[_index++] = radius;
	// Add FOV, angle, intensity, falloff, etc.
}

// Render lighting to light_surface
if (!surface_exists(light_surface))
{
	light_surface = surface_create(_s_width, _s_height);
}

gpu_set_blendmode_ext(bm_one, bm_zero);
surface_set_target(light_surface);
	camera_apply(_cam);
	shader_set(shd_lighting);
	shader_set_uniform_f_array(u_lights, _light_arr);
	draw_surface_ext(application_surface, _view_x, _view_y, _xscale, _yscale, _angle, c_white, 1);
	shader_reset();
surface_reset_target();

// Draw light_surface back to the application surface
draw_surface_ext(light_surface, _view_x, _view_y, _xscale, _yscale, _angle, ambient_color, 1);
gpu_set_blendmode(bm_normal);