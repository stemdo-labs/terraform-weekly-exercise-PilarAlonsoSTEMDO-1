
module "mi_modulo_remoto" {
 source                         = "git::https://github.com/stemdo-labs/terraforn-exercises-palonso.git//soluciones/soluciones_Pilar_Alonso/modulo_github/modules/mi_modulo_remoto"
existent_resource_group_nombre = var.existent_resource_group_name

}
