/// @description Evento Step do obj_tower

if (fire_timer > 0) {
    fire_timer--;
}

if (instance_exists(obj_player)) {
    var _offset_torre_y  = 32;
    var _offset_player_y = 24;
    
    var _spawn_x  = x;
    var _spawn_y  = y - _offset_torre_y;
    var _target_x = obj_player.x;
    var _target_y = obj_player.y - _offset_player_y;

    var _distance = point_distance(_spawn_x, _spawn_y, _target_x, _target_y);
    
    if (_distance <= attack_range && fire_timer <= 0) {
        var _direction = point_direction(_spawn_x, _spawn_y, _target_x, _target_y);
        
        var _projectile = instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_projectile);
        
        if (_projectile != noone) {
            with (_projectile) {
                speed = other.projectile_speed;
                direction = _direction;
                image_angle = _direction;
            }
        }
        
        fire_timer = fire_cooldown;
    }
}