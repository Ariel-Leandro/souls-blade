/// @description Evento Step do obj_cutscene_trigger

if (!cutscene_rodando) exit;
if (!instance_exists(player_ref)) exit;

switch (cena_passo) {
    
    case 0:
        player_ref.estado = ESTADO_PLAYER.CUTSCENE;
        player_ref.vel_h = 0;
        
        if (player_ref.esta_no_chao) {
            if (variable_instance_exists(player_ref, "spr_looking")) {
                player_ref.sprite_index = player_ref.spr_looking;
            } else {
                player_ref.sprite_index = player_ref.spr_idle;
            }
            player_ref.image_speed = 0.5;
            cena_passo = 1;
        }
    break;

    case 1:
        timer++;
        glitch_timer++;
        
        if (instance_exists(anjo_ref)) {
            if (glitch_timer % 3 == 0) {
                anjo_visivel = !anjo_visivel;
                anjo_ref.visible = anjo_visivel;
            }
        }
        
        if (glitch_timer % 2 == 0) {
            var _cores = [
                make_color_rgb(160, 15, 15),
                make_color_rgb(80, 5, 15),
                make_color_rgb(50, 5, 60),
                make_color_rgb(10, 10, 10),
                make_color_rgb(15, 60, 25)
            ];
            
            env_color = _cores[irandom(array_length(_cores) - 1)];
            env_alpha = random_range(0.4, 0.85);
        }

        if (timer >= 10) {
            if (!exibir_legenda) {
                exibir_legenda = true;
                locutor_texto = falas_anjo[fala_index];
                
                // Dispara o texto flutuante sobre o anjo (ou player se o anjo não existir)
                if (!fala_spawnada) {
                    var _spawn_x = (anjo_ref != noone) ? anjo_ref.x : player_ref.x;
                    var _spawn_y = (anjo_ref != noone) ? anjo_ref.y - 40 : player_ref.y - 40;
                    scr_spawn_float_text(_spawn_x, _spawn_y, locutor_texto, c_red);
                    fala_spawnada = true;
                }
            }
            
            if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
                fala_index++;
                exibir_legenda = false;
                fala_spawnada = false;
                
                if (fala_index >= array_length(falas_anjo)) {
                    timer = 0;
                    env_alpha = 0;
                    
                    if (instance_exists(anjo_ref)) {
                        anjo_ref.visible = true;
                    }
                    
                    cena_passo = 2;
                }
            }
        }
    break;

    case 2:
        player_ref.estado = ESTADO_PLAYER.IDLE;
		anjo_ref.visible = false;
        instance_destroy();
    break;
}