/// @description Renderização com efeito Glitch

var _offset_x = irandom_range(-glitch_intensidade, glitch_intensidade);
var _offset_y = irandom_range(-glitch_intensidade, glitch_intensidade);

draw_sprite_ext(
    sprite_index, 
    image_index, 
    x + _offset_x, 
    y + _offset_y, 
    image_xscale, 
    image_yscale, 
    image_angle, 
    c_white, 
    image_alpha
);