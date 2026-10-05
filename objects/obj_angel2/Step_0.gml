/// @description Spawn das frases e controle do timer

spawn_timer++;

if (spawn_timer >= spawn_cooldown) {
    spawn_timer = 0;
    
    var _frase = frases_angel[irandom(array_length(frases_angel) - 1)];
    var _spawn_x = x + irandom_range(-50, 50);
    var _spawn_y = y + irandom_range(20, 80); // Posições abaixo do anjo
    var _cor = choose(c_red, c_purple, c_white, c_yellow);

    if (object_exists(obj_float_text)) {
        var _txt = instance_create_depth(_spawn_x, _spawn_y, depth - 10, obj_float_text);
        if (variable_instance_exists(_txt, "texto")) _txt.texto = _frase;
        if (variable_instance_exists(_txt, "cor")) _txt.cor = _cor;
    }
    
    if (script_exists(asset_get_index("scr_spawn_float_text"))) {
        scr_spawn_float_text(_spawn_x, _spawn_y, _frase, _cor);
    }
}