/// @description Evento Create do obj_player

depth = -5;

// Status e Exaltação
invincible = false;
outline_timer = 0;
invincible_timer = 0;
invincible_timer_max = 600;
invincible_alpha_mult = 0;
esta_amaldicoado = false;

exalt_sys = exalt_init();

stats = {
    hp_max: 100,
    hp_atual: 100,
    hp_delay_ghost: 100,
    hp_ghost_delay_max: 30,
    hp_ghost_timer: 0,
    esta_vivo: true,
    
    aplicar_dano: function(_quantidade) {
        if (!self.esta_vivo) return;
        self.hp_atual = clamp(self.hp_atual - _quantidade, 0, self.hp_max);
        self.hp_ghost_timer = self.hp_ghost_delay_max;
        scr_spawn_float_text(other.x + irandom_range(-6, 6), other.y - 30, "-" + string(_quantidade), c_red);
        
        if (self.hp_atual <= 0) {
            self.morrer();
        }
    },
    
morrer: function() {
        self.esta_vivo = false;
        
        // Cria a transição de fade se ela ainda não existir
        if (!instance_exists(obj_fade_transition)) {
            var _fade = instance_create_depth(0, 0, -99999, obj_fade_transition);
            _fade.sala_destino = rm_death;
        }
    }
};

stats.aplicar_dano = method(stats, stats.aplicar_dano);
stats.morrer = method(stats, stats.morrer);

// Física
vel_h = 0;
vel_v = 0;
vel_max_h = 4;
aceleracao = 0.5;
atrito = 0.3;
gravidade = 0.4;
forca_pulo = -7;
vel_dive = 12;
esta_no_chao = false;
pulos_max = 2;
pulos_restantes = pulos_max;
max_slope = 4;

// Slide
vel_slide = 8;
tempo_slide_max = 18;
tempo_slide = 0;
dir_slide = 1;

// Combate
dano_base = 10;
dano_atual = dano_base;
inimigos_atingidos = ds_list_create();
parry_perfeito_ativo = false;

// Visual
escala_x = 1;
escala_y = 1;
olhando_para_direita = true;

spr_idle     = spr_player;
spr_run      = spr_player_run;
spr_attack   = spr_player_atack;
spr_dive     = spr_player_dive;
spr_jump     = spr_player_jump;
spr_defesa   = spr_parry;
spr_slide    = spr_player_slide;
spr_looking  = spr_player_looking;

hit_timer = 0;

enum ESTADO_PLAYER {
    IDLE,
    RUN,
    ATTACK,
    DIVE,
    JUMP,
    PARRY,
    SLIDE,
    CUTSCENE
}

estado = ESTADO_PLAYER.IDLE;