@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Categoria de Produtos'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDD_CATEGORIA as select from zrla_categoria
{   
    @EndUserText.label: 'ID Categoria'
    key id_categoria,
    @EndUserText.label: 'Descrição'
    descricao
}
