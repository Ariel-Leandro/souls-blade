/// @description Evento Draw do obj_rules

tempo_shader += 0.05;

// --- 1. SHADER HOLY ---
shader_set(shd_holy);

if (u_time != -1) {
    shader_set_uniform_f(u_time, tempo_shader);
}

if (u_texel != -1) {
    var _tex = sprite_get_texture(sprite_index, image_index);
    var _tex_w = texture_get_texel_width(_tex);
    var _tex_h = texture_get_texel_height(_tex);
    shader_set_uniform_f(u_texel, _tex_w, _tex_h);
}

draw_self();

shader_reset();

// --- 2. LEGENDA DE INTERAÇÃO ("PRESSIONE F") ---
if (player_perto) {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    var _texto = "[F] INTERAGIR";
    var _tx = x;
    var _ty = bbox_top - 12;
    
    // Sombra do texto
    draw_set_color(c_black);
    draw_text(_tx + 1, _ty + 1, _texto);
    
    // Texto em amarelo
    draw_set_color(c_yellow);
    draw_text(_tx, _ty, _texto);
    
    // Reset de formatação
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}