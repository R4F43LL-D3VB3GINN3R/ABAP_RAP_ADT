@EndUserText.label : 'Tabela para Produtos'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zrla_produto {

  key mandt        : mandt not null;
  key id_produto   : abap.char(10) not null;
  key id_categoria : abap.char(10) not null;
  descricao        : abap.char(50);
  preco_unitario   : abap.dec(8,2);
  estoque          : int4;
  data_entrada     : abap.dats;
  data_alteracao   : abap.dats;
  username         : abap.char(12);

}
