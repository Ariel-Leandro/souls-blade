/// @description Colisão, flutuação e pulsação orgânica
var _solids = [obj_floor, obj_wall, obj_plat, obj_ground, obj_ground1, obj_invi_plat];

if (place_meeting(x, y + vspeed, _solids)) {
    while (!place_meeting(x, y + sign(vspeed), _solids)) {
        y += sign(vspeed);
    }
    vspeed = 0;
    gravity = 0;
}

if (vspeed == 0) {
    y = initial_y + sin(current_time * 0.004) * float_amplitude;
} else {
    initial_y = y;
}

var _pulse = 1 + sin(current_time * 0.007) * 0.12;
image_xscale = _pulse;
image_yscale = _pulse;