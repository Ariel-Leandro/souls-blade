/// @function exalt_init()
function exalt_init() {
    return {
        max_exalt: 100,
        parry_gain: 25,
        decay_delay_max: 180,
        decay_rate: 0.3,
        efficiency_conversion: 1.0,
        value: 0,
        value_display: 0,
        decay_timer: 0,
        flash_intensity: 0.0,
        
        add_exalt: function(_amount = parry_gain) {
            value = clamp(value + _amount, 0, max_exalt);
            decay_timer = decay_delay_max;
            flash_intensity = 10.0;
        },
        
        reset: function() {
            value = 0;
            decay_timer = 0;
        },
        
        has_amount: function(_amount) {
            return (value >= _amount);
        },
        
        consume: function(_amount) {
            if (has_amount(_amount)) {
                value -= _amount;
                return true;
            }
            return false;
        },
        
        update_decay: function() {
            if (decay_timer > 0) {
                decay_timer -= 1;
            } else {
                if (value > 0) {
                    value = max(0, value - decay_rate);
                }
            }
            value_display = lerp(value_display, value, 0.15);
            flash_intensity = lerp(flash_intensity, 0, 0.1);
        }
    };
}

/// @function draw_stat_bar_gradient(_x, _y, _w, _h, _val, _max, _c_left, _c_right, _c_bg, _c_border)
function draw_stat_bar_gradient(_x, _y, _w, _h, _val, _max, _c_left, _c_right, _c_bg, _c_border) {
    var _percent = clamp(_val / _max, 0, 1);
    var _fill_w = _w * _percent;
    
    draw_sprite_ext(spr_hud_pixel, 0, _x, _y, _w, _h, 0, _c_bg, 1);
    
    if (_fill_w > 0) {
        draw_primitive_begin(pr_trianglestrip);
        draw_vertex_color(_x, _y, _c_left, 1);
        draw_vertex_color(_x + _fill_w, _y, _c_right, 1);
        draw_vertex_color(_x, _y + _h, _c_left, 1);
        draw_vertex_color(_x + _fill_w, _y + _h, _c_right, 1);
        draw_primitive_end();
    }
    
    draw_rectangle_color(_x, _y, _x + _w, _y + _h, _c_border, _c_border, _c_border, _c_border, true);
}