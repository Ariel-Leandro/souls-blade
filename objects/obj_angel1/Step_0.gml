/// @description Comportamento de teleporte, flicker e inversão de cores
if (visible) {
    flicker_timer++;
    if (flicker_timer mod 3 == 0) {
        image_alpha = irandom(1); 
        x += irandom_range(-10, 10);
        y += irandom_range(-8, 8);
    }
}