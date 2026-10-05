// Fragment Shader de Contorno Pulsante
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel_size;
uniform float u_alpha;

void main() {
    vec4 alpha_check = texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (alpha_check.a < 0.1) {
        float alpha = 0.0;
        alpha += texture2D(gm_BaseTexture, v_vTexcoord + vec2(u_texel_size.x, 0.0)).a;
        alpha += texture2D(gm_BaseTexture, v_vTexcoord + vec2(-u_texel_size.x, 0.0)).a;
        alpha += texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, u_texel_size.y)).a;
        alpha += texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, -u_texel_size.y)).a;
        
        if (alpha > 0.0) {
            gl_FragColor = vec4(1.0, 0.5, 0.0, u_alpha);
        } else {
            gl_FragColor = vec4(0.0);
        }
    } else {
        gl_FragColor = v_vColour * alpha_check;
    }
}