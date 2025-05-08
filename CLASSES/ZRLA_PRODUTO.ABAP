CLASS zcl_produto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        id_produto TYPE zrla_produto-id_produto.
    METHODS get_produto
      EXPORTING
        ls_produto TYPE zst_produto
        ls_result  TYPE zst_result.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data.
    DATA gv_id_produto TYPE zrla_produto-id_produto.
    DATA gs_produto TYPE zst_produto.
    DATA gs_result TYPE zst_result.
    DATA gx_error TYPE REF TO cx_root.
ENDCLASS.

CLASS zcl_produto IMPLEMENTATION.

  METHOD constructor.
    
    "recebe o id como parametro
    gv_id_produto = id_produto.
    
    "consulta por produto
    get_data(  ).

  ENDMETHOD.

  METHOD get_data.
    
    "consulta por id do produto
    SELECT SINGLE *
      FROM zrla_produto
      WHERE id_produto EQ @gv_id_produto
      INTO CORRESPONDING FIELDS OF @gs_produto.

  ENDMETHOD.

  METHOD get_produto.
    
    "verifica se houveram dados retornados
    IF gs_produto IS INITIAL.
      gs_result-rc       = 1.
      gs_result-mensagem = | Não há produto disponível para o número { gv_id_produto }|.
      RETURN.
    ELSE.
      gs_result-rc = 0.
      ls_produto   = gs_produto.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
