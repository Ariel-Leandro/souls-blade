/// @description Inicialização do Gerenciador de Cutscenes
timer_cutscene3 = 0;
// --- VARIÁVEIS GLOBAIS DE LEGENDA ---
// Controlam a exibição da caixa de texto na GUI.
exibir_legenda = false;
locutor_texto   = ""; // O texto que será exibido.

// --- EFEITO DE CLARÃO BRANCO (FLASH) ---
// Controla a opacidade do clarão na tela.
flash_alpha = 0;
flash_speed = 0.05; // Velocidade com que o clarão desaparece (fade out).

// --- REFERÊNCIA AO JOGADOR ---
// Procura o jogador na room para controlar seu estado.
player_ref = instance_find(obj_player, 0);


// ==============================================================================
// --- DEFINE OS GATILHOS (MÉTODOS) PARA INICIAR AS CUTSCENES ---
// ==============================================================================

// --- Gatilho da Cutscene 1 (Caminhada Inicial) ---
// Esta cutscene roda automaticamente baseada na variável 'cena_passo'.
cena_passo = 0; // Passo atual da cutscene 1.
timer       = 0; // Timer genérico para passos de espera.

// Configuração da caminhada da cutscene 1.
distancia_caminhar = 100; // Pixels que o player vai andar.
pos_inicial_x      = 0;   // Definido no step.
ponto_alvo_x       = 0;   // Definido no step.


// --- Gatilho da Cutscene 2 (Anjo na Torre) ---
timer_cutscene = 0;
tempo_duracao  = 240; // Duração padrão (4 segundos a 60fps).
cutscene_ativa = false; // Flag para o step saber que esta rodando.

iniciar_cutscene2 = function() {
    // Bloqueia o jogador.
    if (instance_exists(obj_player)) {
        obj_player.estado = ESTADO_PLAYER.CUTSCENE;
        obj_player.vel_h = 0;
        obj_player.vel_v = 0;
        
        // Define sprite de 'olhando' se existir.
        var _spr_look = asset_get_index("spr_looking");
        if (_spr_look != -1) obj_player.sprite_index = _spr_look;
        
        obj_player.image_index = 0;
        obj_player.image_speed = 1;
    }

    // Cria o Anjo se não existir.
    if (!instance_exists(obj_angel2)) {
        var _spawn_x = x;
        var _spawn_y = y;
        
        if (instance_exists(obj_player)) {
            _spawn_x = obj_player.x + 80;
            _spawn_y = obj_player.y - 60;
        }
        instance_create_depth(_spawn_x, _spawn_y, -100, obj_angel2);
    }

    // Reseta parâmetros da cutscene.
    self.timer_cutscene = 0;
    self.tempo_duracao  = 240;
    self.cutscene_ativa = true;
};
// Vincula o método à instância para usar 'self' corretamente.
iniciar_cutscene2 = method(id, iniciar_cutscene2);

// Controle da mensagem sobre Sophia
mensagem_sophia_ativa = false;
// --- Gatilho da Cutscene 3 (Pedra de Regras -> Clarão -> Falled) ---
cutscene3_ativa = false; // Flag para o step saber que esta rodando.
cutscene3_passo = 0;     // Sub-passos desta cutscene.

iniciar_cutscene3 = function() {
    // Bloqueia o jogador na posição atual.
    if (instance_exists(obj_player)) {
        obj_player.estado = ESTADO_PLAYER.CUTSCENE;
        obj_player.vel_h = 0;
        obj_player.vel_v = 0;
        
        // Define sprite de 'olhando' se existir.
        var _spr_look = asset_get_index("spr_looking");
        if (_spr_look != -1) obj_player.sprite_index = _spr_look;
        
        obj_player.image_index = 0;
        obj_player.image_speed = 0.5;
    }
    
    // Inicia a lógica da cutscene 3 no step.
    self.cutscene3_ativa = true;
    self.cutscene3_passo = 0;
};
// Vincula o método à instância.
iniciar_cutscene3 = method(id, iniciar_cutscene3);

// ==============================================================================
// CONTROLE DAS CUTSCENES
// ==============================================================================

cutscene3_ativa = false;
cutscene3_passo = 0;

cutscene_ativa = false;

cena_passo = 0;


// ==============================================================================
// CONTROLE DA MENSAGEM SOBRE SOPHIA
// ==============================================================================

mensagem_sophia_ativa = false;


// ==============================================================================
// TEXTO
// ==============================================================================

exibir_legenda = false;
locutor_texto = "";


// ==============================================================================
// EFEITO DE CLARÃO
// ==============================================================================

flash_alpha = 0;