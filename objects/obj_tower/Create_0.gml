/// @description Evento Create do obj_tower

hp_max = 100;
hp = hp_max;

posso_tomar_dano = true;

fire_timer = 0;
fire_cooldown = 120;
attack_range = 300;
projectile_speed = 6;

aplicar_dano = function(_quantidade) {
    if (!self.posso_tomar_dano) return;
    
    self.hp -= _quantidade;
    self.posso_tomar_dano = false;
    alarm[0] = 15;
    
    // Instancia o texto de dano na torre
    if (object_exists(obj_float_text)) {
        var _txt = instance_create_depth(x + irandom_range(-8, 8), y - (sprite_height / 2), depth - 10, obj_float_text);
        if (variable_instance_exists(_txt, "texto")) _txt.texto = "-" + string(_quantidade);
        if (variable_instance_exists(_txt, "cor")) _txt.cor = c_red;
    }
    
    if (self.hp <= 0) {
        with (obj_projectile) {
            instance_destroy();
        }
        
        // Aciona a Cutscene 2 através do Cutscene Manager se ele existir na room
        if (instance_exists(obj_cutscene_manager)) {
            obj_cutscene_manager.iniciar_cutscene2();
        }
        
        instance_destroy();
    }
};

aplicar_dano = method(id, aplicar_dano);