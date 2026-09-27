/// @description Evento Draw End do obj_cutscene_trigger

if (!cutscene_rodando || env_alpha <= 0) exit;

var _cam = view_camera[0];
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);
var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);

draw_set_color(env_color);
draw_set_alpha(env_alpha);
draw_rectangle(_cam_x, _cam_y, _cam_x + _cam_w, _cam_y + _cam_h, false);
draw_set_alpha(1.0);