// Verifica se está ativado e garante que acessa a variável do manager corretamente
if (ativado) {
    
    // Acessa o manager para verificar e iniciar a cutscene 3
    with (obj_cutscene_manager) {
        if (!cutscene3_ativa) {
            cutscene3_ativa = true;
            cutscene3_passo = 0;
            
            // Destroi o trigger (usando other para referenciar o gatilho da colisão)
            with (other) {
                instance_destroy();
            }
        }
    }
}