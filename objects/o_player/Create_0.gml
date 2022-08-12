/// @description player create things
hsp = 0; // horizontal speed
vsp = 0; // vertical speed
grv = 0.3; // gravity
walkspd = 10;  // walk speed
hp = 100;
sp = 100;
lvl = 1

#region name/stats display

draw_set_color(c_black);
draw_set_alpha(1);
draw_text(1092, 4145, "name" + string(hp) + "  " + string(sp) + "  " + string(lvl));

#endregion

#region setup input variables

global.PRESSED_L = false; // left
global.PRESSED_R = false; // right
global.PRESSED_J = false; // jump
global.PRESSED_M = false; // menu

#endregion