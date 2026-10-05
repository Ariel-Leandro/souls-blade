/// @description Evento Create do obj_rules

// Shader Holy (Contorno Amarelo Pulsante)
u_time  = shader_get_uniform(shd_holy, "u_time");
u_texel = shader_get_uniform(shd_holy, "u_texel");
tempo_shader = 0;

// Configuração de Interação
distancia_interacao = 60;

mensagem_sophia_ativa = false;
exibir_legenda = false;
locutor_texto = "";

mensagem_sophia_ativa = false;
mensagem_sophia_finalizada = false;