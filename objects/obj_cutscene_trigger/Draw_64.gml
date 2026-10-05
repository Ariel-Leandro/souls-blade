/// @description Evento Draw GUI do obj_cutscene_trigger

if (!cutscene_rodando || !exibir_legenda) exit;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _box_w = min(300, _gui_w - 40);
var _box_h = 45;

var _box_x1 = (_gui_w - _box_w) / 2;
var _box_y1 = (_gui_h - _box_h) / 2;
var _box_x2 = _box_x1 + _box_w;
var _box_y2 = _box_y1 + _box_h;

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(_box_x1, _box_y1, _box_x2, _box_y2, false);

draw_set_color(make_color_rgb(140, 20, 20));
draw_set_alpha(0.9);
draw_rectangle(_box_x1, _box_y1, _box_x2, _box_y2, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(1.0);

draw_text_ext(_box_x1 + (_box_w / 2), _box_y1 + (_box_h / 2), locutor_texto, 12, _box_w - 20);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1.0);