/// @description Renderização do Texto do Anjo com efeito Glitch

if (instance_exists(obj_angel2)) {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _centro_x = _gui_w / 2;
    var _pos_y = _gui_h * 0.25;

    // Tremor de Glitch na Posição do Texto
    var _gx = irandom_range(-3, 3);
    var _gy = irandom_range(-3, 3);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Sombra Ciano desincronizada
    draw_text_color(_centro_x + _gx + 2, _pos_y + _gy, texto_fala, c_cyan, c_cyan, c_blue, c_blue, 0.7);
    
    // Sombra Vermelha desincronizada
    draw_text_color(_centro_x + _gx - 2, _pos_y + _gy, texto_fala, c_red, c_red, c_maroon, c_maroon, 0.7);

    // Texto Principal Branco
    draw_text_color(_centro_x + _gx, _pos_y + _gy, texto_fala, c_white, c_white, c_gray, c_gray, 1.0);
}