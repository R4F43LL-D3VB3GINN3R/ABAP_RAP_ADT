CLASS zcl_categoria DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
    METHODS constructor .
    METHODS set_mock_categoria
      EXPORTING
        ls_result TYPE zst_result.
    METHODS get_categorias
      EXPORTING
        lt_categorias TYPE ztt_categoria
        ls_result     TYPE zst_result.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data .
    METHODS get_mock .
    DATA: gs_categoria TYPE zst_categoria.
    DATA: gt_categorias TYPE ztt_categoria.
    DATA: gt_mock_categorias TYPE TABLE OF zrla_categoria.
    DATA: gs_result TYPE zst_result.
    DATA: gx_error TYPE REF TO cx_root.
ENDCLASS.

CLASS zcl_categoria IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "insere o mockdata na base de dados
    set_mock_categoria( ).

    out->write( |Código de Operação: { gs_result-rc }| ).
    out->write( |Mensagem: { gs_result-mensagem }| ).

  ENDMETHOD.

  METHOD constructor.

    get_data( ).

  ENDMETHOD.

  METHOD get_data.

    TRY.
        CLEAR gt_categorias.

        "busca os dados de categorias
        SELECT *
          FROM zrla_categoria
          INTO CORRESPONDING FIELDS OF TABLE @gt_categorias.

      CATCH cx_root INTO gx_error.

        gs_result-rc = 1.
        gs_result-mensagem = |Erro: { gx_error->get_text( ) }|.
    ENDTRY.

  ENDMETHOD.

  METHOD get_categorias.

    TRY.
        "se não houver dados na base de dados
        IF gt_categorias IS INITIAL.
          gs_result-rc = 1.
          gs_result-mensagem = | Não há dados de Categorias disponíveis |.
          RETURN.
        ENDIF.

        "se as operações correram sem problemas
        IF gs_result-rc NE 1.
          gs_result-rc = 0.
          gs_result-mensagem = | OK |.
        ENDIF.


        "envia os dados de categoria
        lt_categorias = gt_categorias.
        ls_result     = gs_result.

      CATCH cx_root INTO gx_error.

        gs_result-rc = 1.
        gs_result-mensagem = |Erro: { gx_error->get_text( ) }|.
    ENDTRY.

  ENDMETHOD.

  METHOD get_mock.

    CLEAR gt_mock_categorias.

    "dados mock
    gt_mock_categorias = VALUE #(
      ( id_categoria = '0000000001' descricao = 'Desktops' )
      ( id_categoria = '0000000002' descricao = 'Notebooks' )
      ( id_categoria = '0000000003' descricao = 'Processadores' )
      ( id_categoria = '0000000004' descricao = 'Placas-Mãe' )
      ( id_categoria = '0000000005' descricao = 'Memórias RAM' )
      ( id_categoria = '0000000006' descricao = 'Placas Gráficas' )
      ( id_categoria = '0000000007' descricao = 'Fontes de Alimentação' )
      ( id_categoria = '0000000008' descricao = 'SSDs e HDDs' )
      ( id_categoria = '0000000009' descricao = 'Coolers' )
      ( id_categoria = '0000000010' descricao = 'Ratos' )
      ( id_categoria = '0000000011' descricao = 'Teclados' )
      ( id_categoria = '0000000012' descricao = 'Monitores' )
    ).

  ENDMETHOD.

  METHOD set_mock_categoria.

    TRY.
        "preenche tabela interna com dados mock
        get_mock( ).

        "verifica se a tabela interna está populada
        IF gt_mock_categorias IS INITIAL.
          gs_result-rc = 1.
          gs_result-mensagem = | Não há mockdata disponível |.
          RETURN.
        ENDIF.

        "limpa a tabela na bse de dados
        DELETE FROM zrla_categoria.

        "insere os dados na base de dados
        MODIFY zrla_categoria FROM TABLE @gt_mock_categorias.

        "se as operações correram sem problemas
        IF gs_result-rc NE 1.
          gs_result-rc = 0.
          gs_result-mensagem = | Mockdata de Categorias inserido com sucesso |.
        ENDIF.

      CATCH cx_root INTO gx_error.

        gs_result-rc = 1.
        gs_result-mensagem = |Erro: { gx_error->get_text( ) }|.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
