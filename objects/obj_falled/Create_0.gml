/// @description Inicialização do obj_falled

// --- VISIBILIDADE ---
// Garante que o objeto comece invisível na room ao iniciar o jogo.
visible = false;

// --- ANIMAÇÃO ---
// Velocidade da animação da sprite.
image_speed = 0.5;

// --- CONFIGURAÇÃO DE SPRITE (OPCIONAL/SEGURANÇA) ---
// Tenta procurar e aplicar a sprite de idle padrão ('spr_falled_idle').
// Usamos asset_get_index para evitar erro se a sprite não existir no projeto.
var _spr_idle = asset_get_index("spr_falled_idle");
if (_spr_idle != -1 && sprite_exists(_spr_idle)) {
    sprite_index = _spr_idle;
}