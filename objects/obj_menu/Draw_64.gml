draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Pega o centro real da janela do jogo
var _x_centro = display_get_gui_width() / 2;
var _y_centro = display_get_gui_height() / 2;

for (var i = 0; i < total_opcoes; i++) {
    var _espacamento_y = i * 40;
    var _offset_flutuacao = 0;
    
    if (i == opcao_selecionada) {
        _offset_flutuacao = sin(tempo_flutuacao) * 5;
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }
    
    draw_text(_x_centro, _y_centro + _espacamento_y + _offset_flutuacao, opcoes[i]);
}

// Reseta padrões
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);