/// @description Evento Draw GUI do obj_cutscene_manager

// --- 1. DESENHO DA LEGENDA E CAIXA DE TEXTO ---
if (exibir_legenda && locutor_texto != "") {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // Configurações e dimensões da caixa
    var _box_w = _gui_w * 0.8;
    var _box_h = 100;
    var _box_x = (_gui_w - _box_w) / 2;
    var _box_y = _gui_h - _box_h - 20;
    
    // Fundo da caixa
    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);
    
    // Borda da caixa
    draw_set_color(c_white);
    draw_set_alpha(1.0);
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);
    
    // Texto do monólogo
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_ext(_box_x + _box_w / 2, _box_y + _box_h / 2, locutor_texto, 18, _box_w - 20);
    
    // Indicador de comando
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_color(c_yellow);
    draw_text(_box_x + _box_w - 10, _box_y + _box_h - 10, "[F/ESPAÇO] ▶");
    
    // Reseta alinhamentos e cores
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// --- 2. DESENHO DO CLARÃO BRANCO (SOBREPÕE A TELA TODA) ---
if (flash_alpha > 0) {
    draw_set_color(c_white);
    draw_set_alpha(flash_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1.0);
}