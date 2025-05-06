@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS para Produtos'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDD_PRODUTO 
  as select from zrla_produto
  association [0..1] to ZDD_CATEGORIA as _Categoria
    on zrla_produto.id_categoria = _Categoria.id_categoria
{
    @EndUserText.label: 'ID Produto'
    key id_produto,
    
    @EndUserText.label: 'ID Categoria'
    key id_categoria,
    
    @EndUserText.label: 'Descrição do Produto'
    descricao,

    @EndUserText.label: 'Preço Unitário'
    preco_unitario,

    @EndUserText.label: 'Estoque'
    estoque,

    @EndUserText.label: 'Data de Entrada'
    data_entrada,

    @EndUserText.label: 'Data de Alteração'
    data_alteracao,

    @EndUserText.label: 'Usuário'
    username,

    _Categoria // associação pública
}
