/// @description updates every frame
#region player input check
// easily add a new keybind
	//	if (keyboard_check(?) || 
	//		keyboard_check(ord("?")) || 
	//		gamepad_button_check_pressed(0, gp_?))
	//	{
	//		global.PRESSED_? = true; 
	//	} else global.PRESSED_? = false;
if (keyboard_check(vk_escape) || 
	keyboard_check(ord("Q")) || 
	gamepad_button_check_pressed(0, gp_start))
{
	global.PRESSED_M = true; 
} else global.PRESSED_M = false;

if (keyboard_check(vk_left) || 
	keyboard_check(ord("A")) || 
	gamepad_button_check_pressed(0, gp_padl))
{
	global.PRESSED_L = true; 
} else global.PRESSED_L = false;

if (keyboard_check(vk_right) || 
	keyboard_check(ord("D")) || 
	gamepad_button_check_pressed(0, gp_padr))
{
	global.PRESSED_R = true; 
} else global.PRESSED_R = false; 

if (keyboard_check(vk_space) || 
	keyboard_check(vk_up) || 
	keyboard_check(ord("W")) || 
	gamepad_button_check_pressed(0, gp_padu))
{
	global.PRESSED_J = true; 
} else global.PRESSED_J = false; 

#endregion

#region calculate horizontal movement

var move = global.PRESSED_R - global.PRESSED_L;
hsp = move * walkspd;

#endregion

#region calculate jumping

vsp = vsp + grv;

if (place_meeting(x, y + 1, o_platform) && global.PRESSED_J)
{
	vsp = -10;
	audio_play_sound(snd_jump, 1, false);
}

#endregion

#region horizontal collision

if (place_meeting(x + hsp, y, o_platform)) 
{
	while (!place_meeting(x + sign(hsp), y, o_platform))
	{
		x += sign(hsp);
	}
	hsp = 0;
}

x += hsp;

#endregion

#region vertical collision

if (place_meeting(x, y + vsp, o_platform)) 
{
	while (!place_meeting(x, y + sign(vsp), o_platform))
	{
		y += sign(vsp);
	}
	vsp = 0;
}

y += vsp;

#endregion

#region other controls (menu)

if (global.PRESSED_M)
{
	audio_play_sound(snd_menuselect, 1, false);
	room_goto(r_menu);
}

#endregion

#region animations

if (!place_meeting(x, y + 1, o_platform))
{
	sprite_index = s_player_jump;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = s_player_idle;
	}
	else
	{
		sprite_index = s_player_walk;
	}
}

if (hsp > 0) image_xscale = -1; else image_xscale = 1;

#endregion