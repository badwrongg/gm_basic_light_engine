switch (init_step++)
{
case e_init_step.camera:
	instance_create_depth(0, 0, 0, display_manager);
	break;
	
case e_init_step.last:
	room_goto(first_room);
	break;
}