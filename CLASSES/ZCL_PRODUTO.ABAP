CLASS zcl_produto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS constructor
      IMPORTING
        id_produto TYPE zrla_produto-id_produto OPTIONAL.
    METHODS get_produto
      EXPORTING
        ls_produto TYPE zst_produto
        ls_result  TYPE zst_result.
    METHODS generate_mock_produto
      RETURNING
        VALUE(ls_produto) TYPE zst_produto.
    METHODS create_cds.
    METHODS read_cds
      IMPORTING
        id_produto TYPE zrla_produto-id_produto
      EXPORTING
        ls_result  TYPE zst_result.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data.
    METHODS get_next_key
      EXPORTING
        id_produto TYPE zrla_produto-id_produto
        ls_result  TYPE zst_result.

    DATA: go_produtos   TYPE REF TO zcl_produtos,
          go_produto    TYPE REF TO zcl_produto,
          go_categorias TYPE REF TO zcl_categoria.

    DATA: gt_produtos     TYPE ztt_produto,
          gt_produtos_cds TYPE TABLE FOR CREATE zdd_produto.

    DATA: gs_produto      TYPE zst_produto,
          gs_produto_cds  LIKE LINE OF gt_produtos_cds,
          gs_mock_produto TYPE zst_produto.

    DATA: gv_id_produto TYPE zrla_produto-id_produto,
          gv_next_key   TYPE zrla_produto-id_produto.

    DATA gs_result TYPE zst_result.
    DATA gx_error TYPE REF TO cx_root.

ENDCLASS.

CLASS zcl_produto IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    "----------------------------------------------------------
*    "          insere um produto na cds / base de dados
*    "----------------------------------------------------------
*    insert_row_cds( ).
*    out->write( |Id Produto: { gs_mock_produto-id_produto }| ).
*    out->write( |Id Categoria: { gs_mock_produto-id_categoria }| ).
*    out->write( |Descrição: { gs_mock_produto-descricao }| ).
*    out->write( |Estoque: { gs_mock_produto-estoque }| ).
*    out->write( |Preço Unitário: { gs_mock_produto-preco_unitario }| ).
*    out->write( |Data Entrada: { gs_mock_produto-data_entrada }| ).
*    out->write( |Data Alteração: { gs_mock_produto-data_alteracao }| ).
*    out->write( |Username: { gs_mock_produto-username }| ).
*    out->write( | | ).

    "----------------------------------------------------------
*    "                lê um dos produtos da CDS
*    "----------------------------------------------------------
*     read_cds(
*      id_produto = '0000000001'
*      ls_result  = gs_result
*     ).

    out->write( | | ).
    out->write( |Código de Operação: { gs_result-rc }| ).
    out->write( |Mensagem: { gs_result-mensagem }| ).

  ENDMETHOD.

  METHOD generate_mock_produto .

    CLEAR gs_produto.
    FREE go_categorias.

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
        RETURN.
    ENDTRY.

    "instancia a classe de categorias
    go_categorias = NEW zcl_categoria(  ).

    gs_produto-id_produto     = gv_next_key.
    gs_produto-id_categoria   = go_categorias->generate_key( ).
    gs_produto-descricao      = 'Dummy'.
    gs_produto-estoque        = 999.
    gs_produto-preco_unitario = '1'.
    gs_produto-data_entrada   = cl_abap_context_info=>get_system_date( ).
    gs_produto-data_alteracao = cl_abap_context_info=>get_system_date( ).
    gs_produto-username       = cl_abap_context_info=>get_user_technical_name( ).

    IF gs_result-rc NE 1.
      gs_result-rc       = 0.
      gs_result-mensagem = |Ok|.
    ENDIF.

    "atribui o novo produto
    ls_produto = gs_produto.

  ENDMETHOD.

  METHOD create_cds.

    CLEAR: gs_mock_produto,
           gs_produto_cds,
           gt_produtos_cds.

    "cria um produto default
    gs_mock_produto = generate_mock_produto( ).

    "estrutura da cds recebe o novo produto
    gs_produto_cds-IdProduto     = gs_mock_produto-id_produto.
    gs_produto_cds-IdCategoria   = gs_mock_produto-id_categoria.
    gs_produto_cds-Descricao     = gs_mock_produto-descricao.
    gs_produto_cds-Estoque       = gs_mock_produto-estoque.
    gs_produto_cds-PrecoUnitario = gs_mock_produto-preco_unitario.
    gs_produto_cds-DataEntrada   = gs_mock_produto-data_entrada.
    gs_produto_cds-DataAlteracao = gs_mock_produto-data_alteracao.
    gs_produto_cds-Username      = gs_mock_produto-username.

    gs_produto_cds-%cid                   = gs_mock_produto-id_produto.
    gs_produto_cds-%control-IdProduto     = if_abap_behv=>mk-on.
    gs_produto_cds-%control-IdCategoria   = if_abap_behv=>mk-on.
    gs_produto_cds-%control-Descricao     = if_abap_behv=>mk-on.
    gs_produto_cds-%control-Estoque       = if_abap_behv=>mk-on.
    gs_produto_cds-%control-PrecoUnitario = if_abap_behv=>mk-on.
    gs_produto_cds-%control-DataEntrada   = if_abap_behv=>mk-on.
    gs_produto_cds-%control-DataAlteracao = if_abap_behv=>mk-on.
    gs_produto_cds-%control-Username      = if_abap_behv=>mk-on.
    APPEND gs_produto_cds TO gt_produtos_cds.

    MODIFY ENTITIES OF zdd_produto
      ENTITY Produto
      CREATE FROM gt_produtos_cds
      FAILED DATA(ls_produto_failed)
      REPORTED DATA(ls_produto_reported)
      MAPPED DATA(ls_produto_mapped).

    "verifica retorno de erro
    IF ls_produto_failed IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      ROLLBACK ENTITIES.
    ENDIF.

  ENDMETHOD.

  METHOD read_cds.

    READ ENTITIES OF zdd_produto
     ENTITY Produto
     ALL FIELDS WITH VALUE #( ( %key-IdProduto = id_produto ) )
     RESULT DATA(lt_produto_cds).

    IF lt_produto_cds IS NOT INITIAL.
      ls_result-rc = 0.
      ls_result-mensagem = |Ok|.
    ENDIF.

  ENDMETHOD.

  METHOD get_next_key.

    CLEAR: gt_produtos,
           gs_result,
           gv_next_key,
           gs_produto.

    FREE: gx_error.

    TRY.
        "recebe tabela de produtos
        go_produtos->get_produtos(
          IMPORTING
            lt_produtos = gt_produtos
            ls_result   = gs_result
        ).

        "verifica se há dados na base de dados
        IF gt_produtos IS INITIAL.
          gs_result-rc       = 1.
          gs_result-mensagem = | Não há dados disponíveis para Produtos |.
          ls_result = gs_result.
          RETURN.
        ENDIF.

        "quantidade de linhas da tabela
        DATA(lv_last_index) = lines( gt_produtos ).

        "procura a ultima chave da tabela
        READ TABLE gt_produtos INTO gs_produto INDEX lv_last_index.

        "incrementa valor da chave
        IF sy-subrc EQ 0.
          gv_next_key = gs_produto-id_produto.
          gv_next_key = gv_next_key + 1.
        ENDIF.

        "ultima validacao
        IF gs_result-rc NE 1.
          gs_result-rc       = 0.
          gs_result-mensagem = |OK|.
        ENDIF.

        "output
        id_produto = gv_next_key.
        ls_result  = gs_result.

      CATCH cx_root INTO gx_error.

        gs_result-rc       = 1.
        gs_result-mensagem = | { gx_error->get_text( ) } |.
        ls_result          = gs_result.
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
