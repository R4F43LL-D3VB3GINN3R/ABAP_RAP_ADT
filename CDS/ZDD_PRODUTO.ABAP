@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Produtos'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDD_PRODUTO 
  as select from zrla_produto
  association [0..1] to ZDD_CATEGORIA as _Categoria
    on zrla_produto.id_categoria = _Categoria.id_categoria
{
    @EndUserText.label: 'ID Produto'
    key id_produto as IdProduto,
    
    @EndUserText.label: 'ID Categoria'
    key id_categoria as IdCategoria,
    
    @EndUserText.label: 'Descrição'
    descricao as Descricao,

    @EndUserText.label: 'Preço Unitário'
    preco_unitario as PrecoUnitario,

    @EndUserText.label: 'Estoque'
    estoque as Estoque,

    @EndUserText.label: 'Data de Entrada'
    data_entrada as DataEntrada,

    @EndUserText.label: 'Data de Alteração'
    data_alteracao as DataAlteracao,

    @EndUserText.label: 'User'
    username as Username,

    _Categoria // associação pública
}
