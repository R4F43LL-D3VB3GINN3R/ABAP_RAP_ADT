@EndUserText.label : 'Estrutura para Resultado de Operações'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
define structure zst_result {

  rc       : int2;
  mensagem : abap.char(255);

}
