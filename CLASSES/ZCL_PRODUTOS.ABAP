CLASS zcl_produtos DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
    METHODS constructor.
    METHODS get_produtos
      EXPORTING
        lt_produtos TYPE ztt_produto
        ls_result   TYPE zst_result.
    METHODS set_mock_produtos
      EXPORTING
        ls_result TYPE zst_result.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data.
    METHODS get_mock.
    DATA gv_id_produto TYPE zrla_produto-id_produto.
    DATA gs_produto TYPE zst_produto.
    DATA gt_produtos TYPE ztt_produto.
    DATA gt_mock_produtos TYPE TABLE OF zrla_produto.
    DATA gs_result TYPE zst_result.
    DATA gx_error TYPE REF TO cx_root.
ENDCLASS.

CLASS zcl_produtos IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "insere o mockdata na base de dados
    set_mock_produtos( ).

    out->write( |Código de Operação: { gs_result-rc }| ).
    out->write( |Mensagem: { gs_result-mensagem }| ).

  ENDMETHOD.

  METHOD constructor.

    get_data( ).

  ENDMETHOD.

  METHOD get_data.

    CLEAR gt_produtos.

    SELECT *
     FROM zrla_produto
     INTO CORRESPONDING FIELDS OF TABLE @gt_produtos.

  ENDMETHOD.

  METHOD get_produtos.

    TRY.
        "se não houver dados na base de dados
        IF gt_produtos IS INITIAL.
          gs_result-rc       = 1.
          gs_result-mensagem = | Não há dados de Categorias disponíveis |.
          RETURN.
        ENDIF.

        "se as operações correram sem problemas
        IF gs_result-rc NE 1.
          gs_result-rc       = 0.
          gs_result-mensagem = | OK |.
        ENDIF.

        lt_produtos = gt_produtos.
        ls_result     = gs_result.

      CATCH cx_root INTO gx_error.

        gs_result-rc       = 1.
        gs_result-mensagem = |Erro: { gx_error->get_text( ) }|.
        ls_result          = gs_result.
    ENDTRY.

  ENDMETHOD.

  METHOD get_mock.

    CLEAR gt_mock_produtos.

    "dados mock
    gt_mock_produtos = VALUE #(
       ( id_produto    = '0000000001' id_categoria = '0000000001' descricao = 'Desktop Lenovo ThinkCentre M90t' preco_unitario = '320000.00' estoque = 170 data_entrada = '20250310' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000002' id_categoria = '0000000002' descricao = 'Notebook Dell XPS 15' preco_unitario = '750000.00' estoque = 300 data_entrada = '20250312' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000003' id_categoria = '0000000003' descricao = 'Intel Core i9-13900K' preco_unitario = '420000.00' estoque = 1 data_entrada = '20250315' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000004' id_categoria = '0000000004' descricao = 'Asus ROG Strix Z690-E' preco_unitario = '150000.00' estoque = 170 data_entrada = '20250318' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000005' id_categoria = '0000000005' descricao = 'Corsair Vengeance LPX 32GB' preco_unitario = '80000.00' estoque = 200 data_entrada = '20250320' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000006' id_categoria = '0000000006' descricao = 'NVIDIA GeForce RTX 3080 Ti' preco_unitario = '300000.00' estoque = 80 data_entrada = '20250322' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000007' id_categoria = '0000000007' descricao = 'Corsair RM850x 850W' preco_unitario = '55000.00' estoque = 80 data_entrada = '20250325' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000008' id_categoria = '0000000008' descricao = 'Kingston NV2 1TB SSD' preco_unitario = '45000.00' estoque = 220 data_entrada = '20250328' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000009' id_categoria = '0000000009' descricao = 'Cooler Master Hyper 212 RGB' preco_unitario = '20000.00' estoque = 100 data_entrada = '20250401' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000010' id_categoria = '0000000010' descricao = 'Logitech G Pro Wireless' preco_unitario = '35000.00' estoque = 180 data_entrada = '20250405' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000011' id_categoria = '0000000011' descricao = 'Razer BlackWidow V3' preco_unitario = '70000.00' estoque = 160 data_entrada = '20250408' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000012' id_categoria = '0000000012' descricao = 'Acer Predator X34P' preco_unitario = '480000.00' estoque = 100 data_entrada = '20250412' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000013' id_categoria = '0000000001' descricao = 'Desktop HP EliteDesk' preco_unitario = '380000.00' estoque = 110 data_entrada = '20250310' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000014' id_categoria = '0000000002' descricao = 'Notebook Acer Aspire 5' preco_unitario = '450000.00' estoque = 70 data_entrada = '20250312' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000015' id_categoria = '0000000003' descricao = 'Processador AMD Ryzen 7 5800X' preco_unitario = '250000.00' estoque = 130 data_entrada = '20250315' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000016' id_categoria = '0000000004' descricao = 'Placa-Mãe Gigabyte B550 AORUS' preco_unitario = '90000.00' estoque = 90 data_entrada = '20250318' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000017' id_categoria = '0000000005' descricao = 'Memória RAM G.SKILL Ripjaws V 16GB' preco_unitario = '50000.00' estoque = 140 data_entrada = '20250320' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000018' id_categoria = '0000000006' descricao = 'Placa Gráfica ASUS TUF RTX 3060' preco_unitario = '350000.00' estoque = 50 data_entrada = '20250322' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000019' id_categoria = '0000000007' descricao = 'Fonte EVGA 750W' preco_unitario = '40000.00' estoque = 80 data_entrada = '20250325' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000020' id_categoria = '0000000008' descricao = 'Seagate Barracuda 2TB HDD' preco_unitario = '50000.00' estoque = 120 data_entrada = '20250328' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000021' id_categoria = '0000000009' descricao = 'Cooler NZXT Kraken X63' preco_unitario = '120000.00' estoque = 70 data_entrada = '20250401' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000022' id_categoria = '0000000010' descricao = 'Razer DeathAdder Elite' preco_unitario = '30000.00' estoque = 150 data_entrada = '20250405' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000023' id_categoria = '0000000011' descricao = 'Logitech G915 TKL' preco_unitario = '130000.00' estoque = 90 data_entrada = '20250408' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000024' id_categoria = '0000000012' descricao = 'LG UltraGear 27GN950' preco_unitario = '500000.00' estoque = 60 data_entrada = '20250412' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000025' id_categoria = '0000000001' descricao = 'Desktop Dell OptiPlex 3080' preco_unitario = '420000.00' estoque = 95 data_entrada = '20250310' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000026' id_categoria = '0000000002' descricao = 'Asus ZenBook 14' preco_unitario = '550000.00' estoque = 120 data_entrada = '20250312' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000027' id_categoria = '0000000003' descricao = 'Intel Core i7-12700K' preco_unitario = '300000.00' estoque = 200 data_entrada = '20250315' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000028' id_categoria = '0000000004' descricao = 'MSI MAG B550 TOMAHAWK' preco_unitario = '95000.00' estoque = 100 data_entrada = '20250318' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000029' id_categoria = '0000000005' descricao = 'Kingston HyperX Fury 32GB' preco_unitario = '85000.00' estoque = 150 data_entrada = '20250320' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000030' id_categoria = '0000000006' descricao = 'AMD Radeon RX 6800 XT' preco_unitario = '650000.00' estoque = 80 data_entrada = '20250322' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000031' id_categoria = '0000000007' descricao = 'Corsair RM750x 750W' preco_unitario = '60000.00' estoque = 110 data_entrada = '20250325' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000032' id_categoria = '0000000008' descricao = 'Samsung 970 Evo Plus 1TB' preco_unitario = '70000.00' estoque = 200 data_entrada = '20250328' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000033' id_categoria = '0000000009' descricao = 'be quiet! Dark Rock 4' preco_unitario = '85000.00' estoque = 50 data_entrada = '20250401' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000034' id_categoria = '0000000010' descricao = 'SteelSeries Rival 600' preco_unitario = '45000.00' estoque = 130 data_entrada = '20250405' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000035' id_categoria = '0000000011' descricao = 'Corsair K70 RGB MK.2' preco_unitario = '160000.00' estoque = 85 data_entrada = '20250408' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
       ( id_produto    = '0000000036' id_categoria = '0000000012' descricao = 'Samsung Odyssey G7 27"' preco_unitario = '320000.00' estoque = 70 data_entrada = '20250412' data_alteracao = '20250318' username = 'RALBUQUERQUE' )
     ).

  ENDMETHOD.

  METHOD set_mock_produtos.

    TRY.
        "preenche tabela interna com dados mock
        get_mock( ).

        "verifica se a tabela interna está populada
        IF gt_mock_produtos IS INITIAL.
          gs_result-rc       = 1.
          gs_result-mensagem = | Não há mockdata disponível |.
          ls_result          = gs_result.
          RETURN.
        ENDIF.

        "limpa a tabela na bse de dados
        DELETE FROM zrla_produto.

        "insere os dados na base de dados
        MODIFY zrla_produto FROM TABLE @gt_mock_produtos.

        "se as operações correram sem problemas
        IF gs_result-rc NE 1.
          gs_result-rc       = 0.
          gs_result-mensagem = | Mockdata de Produtos inserido com sucesso |.
        ENDIF.

      CATCH cx_root INTO gx_error.

        gs_result-rc       = 1.
        gs_result-mensagem = |Erro: { gx_error->get_text( ) }|.
        ls_result          = gs_result.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
