//
// Fragment Shader: shd_holy (Contorno Suave / Smooth Outline Glow)
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform vec2  u_texel; 

void main()
{
    // Cor original do pixel
    vec4 base_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    // Se for o corpo da sprite (pixel visível), desenha a sprite original intacta
    if (base_color.a > 0.8) {
        gl_FragColor = base_color;
        return;
    }

    // --- CÁLCULO DO CONTORNO EXTERNO ---
    float max_alpha = 0.0;
    float espessura = 1.5; // Espessura do contorno em pixels

    // Checa 8 direções ao redor do pixel (incluindo diagonais) para evitar falhas quadradas
    for (float x = -1.0; x <= 1.0; x += 1.0) {
        for (float y = -1.0; y <= 1.0; y += 1.0) {
            if (x == 0.0 && y == 0.0) continue;
            
            vec2 offset = vec2(x, y) * u_texel * espessura;
            float sample_alpha = texture2D(gm_BaseTexture, v_vTexcoord + offset).a;
            
            if (sample_alpha > max_alpha) {
                max_alpha = sample_alpha;
            }
        }
    }

    // Se encontrou a borda de um pixel visível
    if (max_alpha > 0.1) {
        // Pulso suave entre 0.7 e 1.3 de brilho
        float pulso = 0.7 + 0.3 * sin(u_time * 4.0);
        
        // Cor Amarelo Ouro Sagrado vibrante (RGB: 1.0, 0.9, 0.1)
        vec3 cor_amarela = vec3(1.0, 0.9, 0.1) * (1.2 + pulso);
        
        // Alpha suave proporcional ao pulso
        float alpha_final = (max_alpha - base_color.a) * pulso;
        
        gl_FragColor = vec4(cor_amarela, alpha_final);
    } else {
        gl_FragColor = base_color;
    }
}