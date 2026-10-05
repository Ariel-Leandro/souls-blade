/// @description Evento Create do obj_parallax

// Joga o fundo para camadas profundas para nunca encobrir o player ou projéteis
depth = 100;

// Guarda a posição inicial da câmera
camera_x_inicial = camera_get_view_x(view_camera[0]);

// Guarda as posições iniciais de cada objeto de fundo na room
ini_sky           = instance_exists(obj_sky)           ? obj_sky.x           : 0;
ini_sky_light     = instance_exists(obj_sky_lightened) ? obj_sky_lightened.x : 0;
ini_cloud_lonely  = instance_exists(obj_cloud_lonely)  ? obj_cloud_lonely.x  : 0;
ini_clouds_bg     = instance_exists(obj_clouds_bg)     ? obj_clouds_bg.x     : 0;
ini_mountains     = instance_exists(obj_glacial_mountains) ? obj_glacial_mountains.x : 0;
ini_mountains_l   = instance_exists(obj_glacial_mountains_lightened) ? obj_glacial_mountains_lightened.x : 0;
ini_mountains_l2  = instance_exists(obj_glacial_mountains_lightened) ? obj_glacial_mountains_lightened.x : 0; 
ini_mg1           = instance_exists(obj_clouds_mg_1)           ? obj_clouds_mg_1.x           : 0;
ini_mg1_l         = instance_exists(obj_clouds_mg_1_lightened) ? obj_clouds_mg_1_lightened.x : 0;
ini_mg2           = instance_exists(obj_clouds_mg_2)           ? obj_clouds_mg_2.x           : 0;
ini_mg3           = instance_exists(obj_clouds_mg_3)           ? obj_clouds_mg_3.x           : 0;