CLASS zcl_produto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS constructor
      IMPORTING
        id_produto TYPE zrla_produto-id_produto.
    METHODS get_produto
      EXPORTING
        ls_produto TYPE zst_produto
        ls_result  TYPE zst_result.
    METHODS generate_mock_produto
      EXPORTING
        ls_produto TYPE zst_produto.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data.
    METHODS get_next_key
      EXPORTING
        id_produto TYPE zrla_produto-id_produto
        ls_result  TYPE zst_result.

    DATA gv_id_produto TYPE zrla_produto-id_produto.
    DATA gv_next_key TYPE zrla_produto-id_produto.
    DATA gs_produto TYPE zst_produto.
    DATA gs_result TYPE zst_result.
    DATA gx_error TYPE REF TO cx_root.
    DATA go_produtos TYPE REF TO zcl_produtos.
    DATA gt_produtos_cds TYPE TABLE FOR CREATE zdd_produto.
    DATA gt_produtos TYPE ztt_produto.
    DATA gs_produto_cds LIKE LINE OF gt_produtos_cds.
    DATA gs_mock_produto TYPE zst_produto.
ENDCLASS.

CLASS zcl_produto IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.



*    MODIFY ENTITIES OF zdd_produto
*        ENTITY Produto

  ENDMETHOD.

  METHOD generate_mock_produto.

    CLEAR: gs_produto.

    TRY.
        "recebe chave auto incrementada
        get_next_key(
          IMPORTING
            id_produto = gv_next_key
            ls_result  = gs_result
        ).
      CATCH cx_root INTO gx_error.
        gs_result-rc       = 1.
        gs_result-mensagem = | { gx_error->get_text( ) }|.
    ENDTRY.

    gs_produto-id_produto     = gv_next_key.
    gs_produto-id_categoria   = "metodo aqui".
    gs_produto-descricao      = 'Dummy'.
    gs_produto-estoque        = 999.
    gs_produto-preco_unitario = '1'.
    gs_produto-data_entrada   = cl_abap_context_info=>get_system_date( ).
    gs_produto-data_alteracao = cl_abap_context_info=>get_system_date( ).
    gs_produto-username       = cl_abap_context_info=>get_user_technical_name( ).


  ENDMETHOD.

  METHOD get_next_key.

    CLEAR: gt_produtos,
           gs_result,
           gv_next_key,
           gs_produto.

    TRY.
        "recebe tabela de produtos
        go_produtos->get_produtos(
          IMPORTING
            lt_produtos = gt_produtos
            ls_result   = gs_result
        ).

        "verifica se há dados na base de dados
        IF gt_produtos IS NOT INITIAL.
          gs_result-rc       = 1.
          gs_result-mensagem = | Não há dados disponíveis para Produtos |.
          ls_result = gs_result.
          RETURN.
        ENDIF.

        "quantidade de linhas da tabela
        DATA(lv_last_index) = lines( gt_produtos ).

        "procura a ultima chave da tabela
        READ TABLE gt_produtos INTO gs_produto INDEX lv_last_index.
        IF sy-subrc EQ 0.
          gv_next_key = gs_produto-id_produto.
          gv_next_key = gv_next_key + 1.
          id_produto  = gv_next_key.
          ls_result   = gs_result.
        ENDIF.

      CATCH cx_root INTO gx_error.

        gs_result-rc       = 1.
        gs_result-mensagem = | { gx_error->get_text( ) } |.
        ls_result = gs_result.
    ENDTRY.

  ENDMETHOD.

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
            lt_produtos = gt_produtos
            ls_result   = gs_result
        ).

        "procura o produto na tabela interna por id
        READ TABLE gt_produtos INTO DATA(ls_produto) WITH KEY id_produto = gv_id_produto.
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
