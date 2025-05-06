@EndUserText.label : 'Tabela para Categoria de Produtos'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zrla_categoria {

  key mandt        : mandt not null;
  key id_categoria : abap.char(10) not null;
  descricao        : abap.char(50) not null;

}
