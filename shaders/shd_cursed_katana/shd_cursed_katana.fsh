varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel_size;
uniform float u_time;

void main() {
    vec4 main_color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    // Amostragem nos 4 lados para detectar as bordas do sprite
    float alpha_up    = texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, -u_texel_size.y)).a;
    float alpha_down  = texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, u_texel_size.y)).a;
    float alpha_left  = texture2D(gm_BaseTexture, v_vTexcoord + vec2(-u_texel_size.x, 0.0)).a;
    float alpha_right = texture2D(gm_BaseTexture, v_vTexcoord + vec2(u_texel_size.x, 0.0)).a;
    
    // Detecta se é borda externa
    float outline = max(max(alpha_up, alpha_down), max(alpha_left, alpha_right));
    
    // Roxo Claro / Lilás vibrante
    vec3 purple_light = vec3(0.75, 0.4, 1.0); 
    
    // Pulsação suave no brilho do contorno
    float pulse = (sin(u_time * 4.0) + 1.0) * 0.5;
    vec3 final_outline_color = purple_light * (0.8 + pulse * 0.4);
    
    if (main_color.a < 0.1 && outline > 0.1) {
        // Desenha o contorno roxo claro
        gl_FragColor = vec4(final_outline_color, 1.0) * v_vColour;
    } else {
        // Desenha a sprite normal por dentro
        gl_FragColor = main_color * v_vColour;
    }
}