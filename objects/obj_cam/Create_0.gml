// Define o alvo da câmera
alvo = obj_player; // Substitua pelo nome exato do seu objeto do jogador

// Resolução original da câmera (Ajuste o zoom aqui!)
// Quanto MENOR o número, MAIS ZOOM você terá na tela.
cam_largura = 480; 
cam_altura = 270;  // Mantém a proporção 16:9 perfeita

// Velocidade da suavização (0.1 é bem suave, 0.2 é mais rápida)
suavizacao = 0.1;

// Configura a câmera na Viewport 0
view_enabled = true;
view_visible[0] = true;

camera_set_view_size(view_camera[0], cam_largura, cam_altura);