/// @description Evento Create do obj_death

sprite_morte = spr_player_looking; // Sprite predefinida no centro
frame_index = 0;

texto_morte = "Voce sucumbiu a lama conhecida como \"destino\"...";
fonte_morte = -1; // Usa a fonte padrão do GameMaker

alpha_tela = 0;
vel_fade = 0.003;

pode_reiniciar = false;
alarm[0] = 600; // Aguarda 1s antes de permitir reiniciar