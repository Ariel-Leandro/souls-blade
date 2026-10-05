/// @description Evento Step do obj_parallax

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);
var _movimento_cam = _cam_x - camera_x_inicial;
var _tempo = (get_timer() / 2000000); // Velocidade quase nula e suave

// Função de paralaxe, vento e looping infinito (wrap)
var _aplicar_parallax_loop = function(_obj, _ini_x, _fator, _vel_vento, _mov_cam, _w, _t) {
    if (!instance_exists(_obj)) return;
    
    var _largura = sprite_get_width(_obj.sprite_index);
    if (_largura <= 0) _largura = _w;
    
    var _pos_x = _ini_x + (_mov_cam * _fator) + (_t * _vel_vento);
    
    var _offset = (_pos_x - camera_get_view_x(view_camera[0])) mod _largura;
    if (_offset < 0) _offset += _largura;
    
    _obj.x = camera_get_view_x(view_camera[0]) + _offset;
};

// Execução para todas as camadas de background e nuvens
_aplicar_parallax_loop(obj_sky, ini_sky, 0.0, 0, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_sky_lightened, ini_sky_light, 0.0, 0, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_cloud_lonely, ini_cloud_lonely, 0.005, 0.05, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_clouds_bg, ini_clouds_bg, 0.01, 0.1, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_glacial_mountains, ini_mountains, 0.02, 0, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_glacial_mountains_lightened, ini_mountains_l, 0.025, 0, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_clouds_mg_1, ini_mg1, 0.04, 0.2, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_clouds_mg_1_lightened, ini_mg1_l, 0.045, 0.25, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_clouds_mg_2, ini_mg2, 0.06, 0.3, _movimento_cam, _cam_w, _tempo);
_aplicar_parallax_loop(obj_clouds_mg_3, ini_mg3, 0.08, 0.4, _movimento_cam, _cam_w, _tempo);