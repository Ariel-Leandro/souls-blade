/// @function scr_spawn_float_text(_x, _y, _texto, _cor)
function scr_spawn_float_text(_x, _y, _texto, _cor) {
    // Usa depth negativo para garantir renderização sobre todos os elementos
    var _inst = instance_create_depth(_x, _y - 16, -100, obj_float_text);
    if (_inst != noone) {
        _inst.texto = string(_texto);
        _inst.cor = _cor;
    }
}