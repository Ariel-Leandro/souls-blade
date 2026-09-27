/// @description Evento Draw do obj_player

if (invincible) {
    shader_set(shd_outline); 
    var _texel_x = texture_get_texel_width(sprite_get_texture(sprite_index, image_index));
    var _texel_y = texture_get_texel_height(sprite_get_texture(sprite_index, image_index));
    var _u_texel = shader_get_uniform(shd_outline, "u_texel_size");
    var _u_alpha = shader_get_uniform(shd_outline, "u_alpha");
    
    shader_set_uniform_f(_u_texel, _texel_x, _texel_y);
    if (_u_alpha != -1) {
        shader_set_uniform_f(_u_alpha, (sin(current_time * 0.015) + 1) * 0.5);
    }
    draw_self();
    shader_reset();
}
else if (esta_amaldicoado) {
    // Desenha o Player apenas com o Shader de Contorno Roxo Claro
    shader_set(shd_cursed_katana);
    var _texel_x = texture_get_texel_width(sprite_get_texture(sprite_index, image_index));
    var _texel_y = texture_get_texel_height(sprite_get_texture(sprite_index, image_index));
    var _u_texel = shader_get_uniform(shd_cursed_katana, "u_texel_size");
    var _u_time  = shader_get_uniform(shd_cursed_katana, "u_time");
    
    shader_set_uniform_f(_u_texel, _texel_x, _texel_y);
    if (_u_time != -1) {
        shader_set_uniform_f(_u_time, current_time * 0.001);
    }
    draw_self();
    shader_reset();
}
else {
    draw_self();
}