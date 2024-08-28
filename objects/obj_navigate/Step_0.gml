if (keyboard_check_pressed(vk_escape))
{
	game_end();	
}

if (keyboard_check_pressed(vk_f10))
{
	room_restart();	
}

var _x_axis = keyboard_check(ord("D")) - keyboard_check(ord("A")),
	_y_axis = keyboard_check(ord("S")) - keyboard_check(ord("W")),
	_rot = keyboard_check(ord("E")) - keyboard_check(ord("Q")),
	_zoom = mouse_wheel_down() - mouse_wheel_up();
	
if (_x_axis != 0 || _y_axis != 0)
{
	var _dir = point_direction(0, 0, _x_axis, _y_axis);
	x += lengthdir_x(move_speed, _dir);
	y += lengthdir_y(move_speed, _dir);
}

if (_rot != 0)
{
	get_game_camera(0).increment_angle(_rot * 5);
}

if (_zoom != 0)
{
	get_game_camera(0).increment_zoom(_zoom * 2);	
}

if (mouse_check_button_pressed(mb_right))
{
	var _light = instance_create_layer(mouse_x, mouse_y, "Lighting", obj_light_point, 
	{
		image_blend : make_color_rgb(irandom_range(50, 255), irandom_range(50, 255), irandom_range(50, 255)),
		image_xscale : random_range(1, 8),
		image_yscale : random_range(1, 8)
	});
	_light.radius = _light.sprite_width * 0.5;
}