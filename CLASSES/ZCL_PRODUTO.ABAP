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
    DATA go_produtos TYPE REF TO zcl_produtos.
ENDCLASS.

CLASS zcl_produto IMPLEMENTATION.

  METHOD constructor.

    "recebe o id como parametro
    gv_id_produto = id_produto.

    "inicia instância da classe de produtos
    go_produtos = NEW zcl_produtos(  ).

    "consulta por produto
    get_data(  ).

  ENDMETHOD.

  METHOD get_data.

    TRY.
        "recebe uma tabela interna de produtos
        go_produtos->get_produtos(
          IMPORTING
            lt_produtos = DATA(lt_produtos)
            ls_result   = gs_result
        ).

        FREE go_produtos.

        "procura o produto na tabela interna por id
        READ TABLE lt_produtos INTO DATA(ls_produto) WITH KEY id_produto = gv_id_produto.
        IF sy-subrc EQ 0.
          gs_produto = ls_produto.
        ENDIF.

      CATCH cx_root INTO gx_error.

        gs_result-rc       = 1.
        gs_result-mensagem = |Erro: { gx_error->get_text( ) }|.
    ENDTRY.

  ENDMETHOD.

  METHOD get_produto.

    "verifica se houveram dados retornados
    IF gs_produto IS INITIAL.
      gs_result-rc       = 1.
      gs_result-mensagem = | Não há produto disponível para o número { gv_id_produto }|.
      ls_result          = gs_result.
      RETURN.
    ELSE.
      gs_result-rc = 0.
      ls_produto   = gs_produto.
      ls_result    = gs_result.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
