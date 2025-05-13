managed implementation in class zbp_dd_produto unique;
strict ( 1 );

define behavior for ZDD_PRODUTO alias Produto
persistent table zrla_produto
lock master
authorization master ( instance )
//etag master <field_name>
{
  create;
  update;
  delete;

  field ( readonly : update ) IdProduto, IdCategoria;

  mapping for zrla_produto corresponding
    {
      IdProduto     = id_produto;
      IdCategoria   = id_categoria;
      PrecoUnitario = preco_unitario;
      DataEntrada   = data_entrada;
      DataAlteracao = data_alteracao;
    }
}
