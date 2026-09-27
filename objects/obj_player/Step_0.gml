/// @description Evento Step do obj_player

if (!stats.esta_vivo) {
    exit;
}

exalt_sys.update_decay();

// Reset da maldição
esta_amaldicoado = false;

// Controle do raio de revelação das plataformas invisíveis
var _raio_revelacao = 250; 
var _player_x = x;
var _player_y = y;

with (obj_invi_plat) {
    var _px_perto = clamp(_player_x, bbox_left, bbox_right);
    var _py_perto = clamp(_player_y, bbox_top, bbox_bottom);
    var _dist = point_distance(_px_perto, _py_perto, _player_x, _player_y);
    
    if (_dist <= _raio_revelacao) {
        other.esta_amaldicoado = true;
        var _proximidade = 1 - (_dist / _raio_revelacao);
        image_alpha = lerp(image_alpha, _proximidade, 0.2);
    } else {
        image_alpha = lerp(image_alpha, 0, 0.2);
    }
}

// Timers de vida e invencibilidade
if (hit_timer > 0) hit_timer--;

if (invincible_timer > 0) {
    invincible_timer--;
    invincible_alpha_mult = invincible_timer / invincible_timer_max;
    if (invincible_timer <= 0) {
        invincible = false;
        invincible_alpha_mult = 0;
    }
}

if (stats.hp_ghost_timer > 0) {
    stats.hp_ghost_timer--;
} else {
    stats.hp_delay_ghost = lerp(stats.hp_delay_ghost, stats.hp_atual, 0.08);
}

if (stats.hp_delay_ghost < stats.hp_atual) {
    stats.hp_delay_ghost = stats.hp_atual;
}

// Inputs (bloqueados durante CUTSCENE)
var _key_right  = (estado != ESTADO_PLAYER.CUTSCENE) && (keyboard_check(vk_right) || keyboard_check(ord("D")));
var _key_left   = (estado != ESTADO_PLAYER.CUTSCENE) && (keyboard_check(vk_left)  || keyboard_check(ord("A")));
var _key_jump   = (estado != ESTADO_PLAYER.CUTSCENE) && (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W")));
var _key_attack = (estado != ESTADO_PLAYER.CUTSCENE) && mouse_check_button_pressed(mb_left);
var _key_parry  = (estado != ESTADO_PLAYER.CUTSCENE) && mouse_check_button_pressed(mb_right);
var _key_slide  = (estado != ESTADO_PLAYER.CUTSCENE) && keyboard_check_pressed(vk_shift);

// Array de colisão
var _solids = [obj_floor, obj_wall, obj_plat, obj_ground, obj_ground1, obj_invi_plat, obj_plat_cloud];

if (estado != ESTADO_PLAYER.DIVE && estado != ESTADO_PLAYER.SLIDE) {
    vel_v += gravidade;
}

esta_no_chao = place_meeting(x, y + 1, _solids);
if (esta_no_chao) pulos_restantes = pulos_max;

// Máquina de Estados
if (estado == ESTADO_PLAYER.CUTSCENE) {
    if (abs(vel_h) < 0.1) {
        if (sprite_index != spr_run) {
            sprite_index = spr_looking;
        }
    }
} else {
    switch (estado) {
        case ESTADO_PLAYER.IDLE:
        case ESTADO_PLAYER.RUN:
        case ESTADO_PLAYER.JUMP:
            var _dir_input = _key_right - _key_left;
            if (_dir_input != 0) {
                vel_h = lerp(vel_h, _dir_input * vel_max_h, aceleracao);
                olhando_para_direita = (_dir_input > 0);
            } else {
                vel_h = lerp(vel_h, 0, atrito);
            }

            if (_key_jump && pulos_restantes > 0) {
                vel_v = forca_pulo;
                pulos_restantes--;
                estado = ESTADO_PLAYER.JUMP;
                sprite_index = spr_jump;
                image_index = 0;
                image_speed = 1;
            }

            if (_key_slide && esta_no_chao) {
                estado = ESTADO_PLAYER.SLIDE;
                sprite_index = spr_slide;
                image_index = 0;
                image_speed = 1;
                tempo_slide = tempo_slide_max;
                dir_slide = olhando_para_direita ? 1 : -1;
                break;
            }

            if (!esta_no_chao) {
                estado = ESTADO_PLAYER.JUMP;
                sprite_index = spr_jump;
                image_speed = 1;
            } else if (abs(vel_h) > 0.2) {
                estado = ESTADO_PLAYER.RUN;
                sprite_index = spr_run;
                image_speed = 1;
            } else {
                estado = ESTADO_PLAYER.IDLE;
                if (sprite_index != spr_looking) sprite_index = spr_idle;
                image_speed = 1;
            }

            if (_key_attack) {
                ds_list_clear(inimigos_atingidos);
                if (!esta_no_chao) {
                    scr_spawn_float_text(x, y - 20, "DORYAA!", make_color_rgb(255, 60, 0));
                    estado = ESTADO_PLAYER.DIVE;
                    sprite_index = spr_dive;
                    vel_h = 0;
                    vel_v = vel_dive;
                    dano_atual = dano_base * 2;
                    image_speed = 1;
                    image_index = 0;
                } else {
                    scr_spawn_float_text(x, y - 20, "SEI!", make_color_rgb(255, 140, 0));
                    estado = ESTADO_PLAYER.ATTACK;
                    sprite_index = spr_attack;
                    vel_h = 0;
                    dano_atual = dano_base;
                    image_speed = 0.5; 
                    image_index = 0;
                }
            }

            if (_key_parry) {
                estado = ESTADO_PLAYER.PARRY;
                sprite_index = spr_defesa;
                image_index = 0;
                image_speed = 0.8;
                vel_h = 0;
                parry_perfeito_ativo = false;
            }
        break;

        case ESTADO_PLAYER.SLIDE:
            sprite_index = spr_slide;
            image_speed = 1;
            vel_h = dir_slide * vel_slide;
            tempo_slide--;
            if (tempo_slide <= 0 || !esta_no_chao) estado = ESTADO_PLAYER.IDLE;
        break;

        case ESTADO_PLAYER.ATTACK:
            image_speed = 0.5;
            if (esta_no_chao) vel_h = lerp(vel_h, 0, atrito);

            var _tower = instance_place(x, y, obj_tower);
            if (_tower != noone && ds_list_find_index(inimigos_atingidos, _tower) == -1) {
                ds_list_add(inimigos_atingidos, _tower);
                _tower.aplicar_dano(invincible ? _tower.hp : dano_atual);
            }

            if (image_index >= image_number - 1) {
                dano_atual = dano_base;
                estado = ESTADO_PLAYER.IDLE;
            }
        break;

        case ESTADO_PLAYER.DIVE:
            image_speed = 1;
            vel_h = 0;

            var _tower = instance_place(x, y, obj_tower);
            if (_tower != noone && ds_list_find_index(inimigos_atingidos, _tower) == -1) {
                ds_list_add(inimigos_atingidos, _tower);
                _tower.aplicar_dano(invincible ? _tower.hp : dano_atual);
            }

            if (esta_no_chao) {
                dano_atual = dano_base;
                estado = ESTADO_PLAYER.IDLE;
            }
        break;

        case ESTADO_PLAYER.PARRY:
            vel_h = lerp(vel_h, 0, atrito);
            sprite_index = spr_defesa;
            image_speed = 0.8;
            
            parry_perfeito_ativo = (image_index <= (image_number * 0.49));

            if (image_index >= image_number - 1) {
                parry_perfeito_ativo = false;
                estado = ESTADO_PLAYER.IDLE;
            }
        break;
    }
}

// Colisão e movimentação
if (place_meeting(x + vel_h, y, _solids)) {
    var _y_subir = 0;
    while (place_meeting(x + vel_h, y - _y_subir, _solids) && _y_subir <= max_slope) {
        _y_subir++;
    }

    if (!place_meeting(x + vel_h, y - _y_subir, _solids)) {
        y -= _y_subir;
    } else {
        while (!place_meeting(x + sign(vel_h), y, _solids)) {
            x += sign(vel_h);
        }
        vel_h = 0;
    }
}
x += vel_h;

if (place_meeting(x, y + vel_v, _solids)) {
    while (!place_meeting(x, y + sign(vel_v), _solids)) {
        y += sign(vel_v);
    }
    vel_v = 0;
}
y += vel_v;

// Queda no abismo (com transição de fade)
if (y > room_height + 100) {
    if (stats.esta_vivo) {
        stats.esta_vivo = false;
        if (!instance_exists(obj_fade_transition)) {
            var _fade = instance_create_depth(0, 0, -99999, obj_fade_transition);
            _fade.sala_destino = rm_death;
        }
    }
}

escala_x = olhando_para_direita ? 1 : -1;
image_xscale = escala_x;