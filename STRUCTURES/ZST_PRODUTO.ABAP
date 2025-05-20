@EndUserText.label : 'Estrutura para Produto'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define structure zst_produto {

  id_produto     : abap.char(10);
  id_categoria   : abap.char(10);
  descricao      : abap.char(50);
  preco_unitario : abap.dec(8,2);
  estoque        : int4;
  data_entrada   : abap.dats;
  data_alteracao : abap.dats;
  username       : abap.char(12);

}
