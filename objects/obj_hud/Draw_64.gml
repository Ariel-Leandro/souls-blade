if (!instance_exists(obj_player)) exit;

var _player = obj_player;
var _stats  = _player.stats;

// Cálculo das proporções
var _hp_actual_percent = clamp(_stats.hp_atual / _stats.hp_max, 0, 1);
var _hp_ghost_percent  = clamp(_stats.hp_delay_ghost / _stats.hp_max, 0, 1);

var _w_actual = bar_w * _hp_actual_percent;
var _w_ghost  = bar_w * _hp_ghost_percent;

// Cores
var _c_bg     = make_color_rgb(15, 15, 20);     // Fundo escuro
var _c_ghost  = make_color_rgb(180, 40, 40);    // Vermelho (Dano fantasma)
var _c_fill   = make_color_rgb(46, 204, 113);   // Verde (Vida atual)
var _c_border = make_color_rgb(200, 200, 200);  // Borda externa

// 1. Fundo Escuro
draw_rectangle_color(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, _c_bg, _c_bg, _c_bg, _c_bg, false);

// 2. Barra Fantasma (Dano caindo suavemente)
if (_w_ghost > 0) {
    draw_rectangle_color(bar_x, bar_y, bar_x + _w_ghost, bar_y + bar_h, _c_ghost, _c_ghost, _c_ghost, _c_ghost, false);
}

// 3. Barra de Vida Atual (Verde instantâneo)
if (_w_actual > 0) {
    draw_rectangle_color(bar_x, bar_y, bar_x + _w_actual, bar_y + bar_h, _c_fill, _c_fill, _c_fill, _c_fill, false);
}

// 4. Borda Externa da Caixa
draw_rectangle_color(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, _c_border, _c_border, _c_border, _c_border, true);