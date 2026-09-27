// Verifica se o jogador existe na sala para não dar erro
if (instance_exists(alvo)) {
    // Posição de destino centrada no jogador
    var _x_alvo = alvo.x - (cam_largura / 2);
    var _y_alvo = alvo.y - (cam_altura / 2);
    
    // Posição atual da câmera
    var _x_atual = camera_get_view_x(view_camera[0]);
    var _y_atual = camera_get_view_y(view_camera[0]);
    
    // Suavização da posição usando LERP
    var _x_novo = lerp(_x_atual, _x_alvo, suavizacao);
    var _y_novo = lerp(_y_atual, _y_alvo, suavizacao);
    
    // Opcional: Limita a câmera para não mostrar além das bordas da Room
    _x_novo = clamp(_x_novo, 0, room_width - cam_largura);
    _y_novo = clamp(_y_novo, 0, room_height - cam_altura);
    
    // Aplica a nova posição na câmera
    camera_set_view_pos(view_camera[0], _x_novo, _y_novo);
}