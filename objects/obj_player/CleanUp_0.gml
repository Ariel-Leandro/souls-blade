/// @description Evento Clean Up do obj_player
if (ds_exists(inimigos_atingidos, ds_type_list)) {
    ds_list_destroy(inimigos_atingidos);
}