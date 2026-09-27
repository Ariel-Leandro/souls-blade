/// @description Desenho da tela preta, sprite e texto em vermelho

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _centro_x = _gui_w / 2;
var _centro_y = _gui_h / 2;

draw_set_alpha(alpha_tela);

// Fundo Preto
draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);

// Sprite predefinida
if (sprite_exists(sprite_morte)) {
    draw_sprite_ext(sprite_morte, frame_index, _centro_x, _centro_y - 40, 1.5, 1.5, 0, c_white, alpha_tela);
}

// Texto em Vermelho
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_ext_color(
    _centro_x, 
    _centro_y + 60, 
    texto_morte, 
    32, 
    _gui_w - 100, 
    c_red, c_red, c_maroon, c_maroon, 
    alpha_tela
);

// Instrução para reiniciar
if (pode_reiniciar) {
    draw_set_color(c_gray);
    draw_text_transformed(_centro_x, _gui_h - 40, "Pressione ESPAÇO para tentar novamente", 0.6, 0.6, 0);
}

draw_set_alpha(1);