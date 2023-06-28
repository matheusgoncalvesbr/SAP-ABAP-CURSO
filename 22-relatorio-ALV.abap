*&---------------------------------------------------------------------*
*& Report ZR020
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR020.
* Tabela transparente
TABLES: ZT005.
* Tabelas interna
DATA: T_ZT005 TYPE TABLE OF ZT005,
 T_ZT001 TYPE TABLE OF ZT001,
 T_SAIDA TYPE TABLE OF ZS001,
 T_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV, "Tipo de grupo
 T_SORT TYPE SLIS_T_SORTINFO_ALV,
 T_HEADER TYPE SLIS_T_LISTHEADER.
* Work area
DATA: W_ZT005 TYPE ZT005,
 W_ZT001 TYPE ZT001,
 W_SAIDA TYPE ZS001,
 W_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
 W_SORT TYPE SLIS_SORTINFO_ALV,
 W_LAYOUT TYPE SLIS_LAYOUT_ALV,
 W_HEADER TYPE SLIS_LISTHEADER,
 W_VARIANT TYPE DISVARIANT.
* Tela de seleÁ„o
SELECTION-SCREEN BEGIN OF BLOCK BC01 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: S_TPMAT FOR ZT005-TPMAT,
 S_MATER FOR ZT005-MATER.
SELECTION-SCREEN END OF BLOCK BC01.
SELECTION-SCREEN BEGIN OF BLOCK BC02 WITH FRAME TITLE TEXT-002.
PARAMETERS: P_VARIAN TYPE SLIS_VARI. "Gravar variante no relatÛrio ALV
SELECTION-SCREEN END OF BLOCK BC02.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_VARIAN.
 PERFORM F_VARIANT_F4 CHANGING P_VARIAN.
START-OF-SELECTION.
 PERFORM F_SELECIONA_DADOS. "Seleciona todos os dados
 PERFORM F_MONTA_TABELA_SAIDA. "Consolida tudo da tabela 5 e 1 na tabela SAIDA
 PERFORM F_MONTA_ALV.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_SELECIONA_DADOS .
 SELECT * FROM ZT005 INTO TABLE T_ZT005 "Seleciona tudo da tabela ZT005 e inseri na tabela interna T_ZT005
 WHERE TPMAT IN S_TPMAT "Onde TPMAT recebe S_TPMAT e MATER recebe S_MATER
 AND MATER IN S_MATER.
 IF SY-SUBRC IS INITIAL.
 SELECT * FROM ZT001 INTO TABLE T_ZT001
 FOR ALL ENTRIES IN T_ZT005 "JunÁ„o entre tabela transparente com tabela interna
 WHERE TPMAT = T_ZT005-TPMAT. "Onde TPMAT recebe T_ZT005-TPMAT
 ELSE.
 MESSAGE TEXT-003 TYPE 'I'."N„o foi encontrado nenhum registros com esses par‚metros
 STOP.
 ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_MONTA_TABELA_SAIDA
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_MONTA_TABELA_SAIDA .
 LOOP AT T_ZT005 INTO W_ZT005.
 CLEAR W_SAIDA.
 W_SAIDA-MATER = W_ZT005-MATER.
 W_SAIDA-DENOM = W_ZT005-DENOM.
 W_SAIDA-BRGEW = W_ZT005-BRGEW.
 W_SAIDA-NTGEW = W_ZT005-NTGEW.
 W_SAIDA-GEWEI = W_ZT005-GEWEI.
 W_SAIDA-STATUS = W_ZT005-STATUS.
 W_SAIDA-TPMAT = W_ZT005-TPMAT.
 READ TABLE T_ZT001 INTO W_ZT001 WITH KEY TPMAT = W_ZT005-TPMAT.
 IF SY-SUBRC IS INITIAL.
 W_SAIDA-DENOM_TP = W_ZT001-DENOM.
 ENDIF.
 APPEND W_SAIDA TO T_SAIDA.
 ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_MONTA_ALV
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_MONTA_ALV .
 PERFORM F_DEFINE_FIELDCAT. "Fielfcat define as caracteristicas das colunas
 PERFORM F_ORDENA. "CriaÁ„o de ordenaÁ„o no relatÛrio ALV
 PERFORM F_LAYOUT.
 PERFORM F_IMPRIMI_ALV.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_DEFINE_FIELDCAT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_DEFINE_FIELDCAT .
 CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
 EXPORTING
 I_PROGRAM_NAME = SY-REPID "Nome do programa
 I_INTERNAL_TABNAME = 'T_SAIDA' "Onde os dados estar„o armazenados
 I_STRUCTURE_NAME = 'ZS001' "Onde busca as informaÁıes da estrutura
* I_CLIENT_NEVER_DISPLAY = 'X'
* I_INCLNAME =
* I_BYPASSING_BUFFER =
* I_BUFFER_ACTIVE =
 CHANGING
 CT_FIELDCAT = T_FIELDCAT
 EXCEPTIONS
 INCONSISTENT_INTERFACE = 1
 PROGRAM_ERROR = 2
 OTHERS = 3.
 IF SY-SUBRC <> 0.
 MESSAGE TEXT-006 TYPE 'I'. "Erro na definiÁ„o da FIELDCAT
 STOP.
 ELSE.
 LOOP AT T_FIELDCAT INTO W_FIELDCAT. "Rotina para mudar o nome de BRGEW e NTGEW
 CASE W_FIELDCAT-FIELDNAME.
 WHEN 'BRGEW'.
 W_FIELDCAT-SELTEXT_S = W_FIELDCAT-SELTEXT_M = W_FIELDCAT-SELTEXT_L = W_FIELDCAT-REPTEXT_DDIC = TEXT-004.
 WHEN 'NTGEW'.
 W_FIELDCAT-SELTEXT_S = W_FIELDCAT-SELTEXT_M = W_FIELDCAT-SELTEXT_L = W_FIELDCAT-REPTEXT_DDIC = TEXT-005.
 WHEN 'MATER'.
 W_FIELDCAT-HOTSPOT = 'X'.
 ENDCASE.
 MODIFY T_FIELDCAT FROM W_FIELDCAT INDEX SY-TABIX TRANSPORTING SELTEXT_S SELTEXT_M SELTEXT_L REPTEXT_DDIC HOTSPOT.
 ENDLOOP.
 ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_ORDENA
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_ORDENA .
 CLEAR W_SORT. "Limpa a Work Area W_SORT
 W_SORT-SPOS = 1.
 W_SORT-FIELDNAME = 'MATER'.
 W_SORT-TABNAME = 'T_SAIDA'.
 W_SORT-UP = 'X'. "Coloque em ordem crescente
 APPEND W_SORT TO T_SORT.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_LAYOUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_LAYOUT .
 W_LAYOUT-ZEBRA = 'X'. "Deixa a linhas da tabela em azul e cinza
 W_LAYOUT-COLWIDTH_OPTIMIZE = 'X'. "Otimiza as colunas
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_IMPRIMI_ALV
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_IMPRIMI_ALV .
 CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
* I_INTERFACE_CHECK = ' '
* I_BYPASSING_BUFFER = ' '
* I_BUFFER_ACTIVE = ' '
 I_CALLBACK_PROGRAM = SY-REPID
* I_CALLBACK_PF_STATUS_SET = ' '
 I_CALLBACK_USER_COMMAND = 'USER_COMMAND'
 I_CALLBACK_TOP_OF_PAGE = 'F_CABECALHO'
* I_CALLBACK_HTML_TOP_OF_PAGE = ' '
* I_CALLBACK_HTML_END_OF_LIST = ' '
* I_STRUCTURE_NAME =
* I_BACKGROUND_ID = ' '
* I_GRID_TITLE =
* I_GRID_SETTINGS =
 IS_LAYOUT = W_LAYOUT
 IT_FIELDCAT = T_FIELDCAT
* IT_EXCLUDING =
* IT_SPECIAL_GROUPS =
 IT_SORT = T_SORT
* IT_FILTER =
* IS_SEL_HIDE =
* I_DEFAULT = 'X'
 I_SAVE = 'X'
 IS_VARIANT = W_VARIANT
* IT_EVENTS =
* IT_EVENT_EXIT =
* IS_PRINT =
* IS_REPREP_ID =
* I_SCREEN_START_COLUMN = 0
* I_SCREEN_START_LINE = 0
* I_SCREEN_END_COLUMN = 0
* I_SCREEN_END_LINE = 0
* I_HTML_HEIGHT_TOP = 0
* I_HTML_HEIGHT_END = 0
* IT_ALV_GRAPHICS =
* IT_HYPERLINK =
* IT_ADD_FIELDCAT =
* IT_EXCEPT_QINFO =
* IR_SALV_FULLSCREEN_ADAPTER =
* IMPORTING
* E_EXIT_CAUSED_BY_CALLER =
* ES_EXIT_CAUSED_BY_USER =
 TABLES
 T_OUTTAB = T_SAIDA
 EXCEPTIONS
 PROGRAM_ERROR = 1
 OTHERS = 2.
ENDFORM.
FORM F_CABECALHO.
 CLEAR W_HEADER.
 REFRESH T_HEADER.
 W_HEADER-TYP = 'H'. " Campo TYP -> Diferencia o tipo do texto, type 'h' È HEADER
 W_HEADER-INFO = TEXT-007. "RelatÛrio de materiais
 APPEND W_HEADER TO T_HEADER.
 W_HEADER-TYP = 'S'.
 W_HEADER-KEY = TEXT-008. "Data:
 WRITE SY-DATUM TO W_HEADER-INFO. " Data formato inglÍs convertida para br
 APPEND W_HEADER TO T_HEADER.
 W_HEADER-TYP = 'S'.
 W_HEADER-KEY = TEXT-009. "Hora:
 WRITE SY-UZEIT TO W_HEADER-INFO.
 APPEND W_HEADER TO T_HEADER.
 CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE' "
 EXPORTING
 IT_LIST_COMMENTARY = T_HEADER
 I_LOGO = 'ENJOYSAP_LOGO'
* I_END_OF_LIST_GRID =
* I_ALV_FORM =
 .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_VARIANT_F4
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* <--P_P_VARIAN text
*----------------------------------------------------------------------*
FORM F_VARIANT_F4 CHANGING P_P_VARIAN.
 DATA: VL_VARIANT TYPE DISVARIANT.
 VL_VARIANT-REPORT = SY-REPID.
 CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
 EXPORTING
 IS_VARIANT = VL_VARIANT
* I_TABNAME_HEADER =
* I_TABNAME_ITEM =
* IT_DEFAULT_FIELDCAT =
 I_SAVE = 'A'
* I_DISPLAY_VIA_GRID = ' '
 IMPORTING
* E_EXIT = VL_VARIANT
 ES_VARIANT = VL_VARIANT
 EXCEPTIONS
 NOT_FOUND = 1
 PROGRAM_ERROR = 2
 OTHERS = 3.
 IF SY-SUBRC = 0.
 P_P_VARIAN = VL_VARIANT-VARIANT.
 ENDIF.
ENDFORM.
FORM USER_COMMAND USING R_UCOMM LIKE SY-UCOMM "Variavel UCOMM armazena o nome do bot„o que foi clicado.
 RS_SELFIELD TYPE SLIS_SELFIELD. "As informaÁıes do campo que foi clicado
 DATA: TL_VIMSELLIST TYPE STANDARD TABLE OF VIMSELLIST,
 WL_VIMSELLIST TYPE VIMSELLIST.
 IF RS_SELFIELD-SEL_TAB_FIELD = 'T_SAIDA-MATER'. "Se clicar no material
 WL_VIMSELLIST-VIEWFIELD = 'MATER'.
 WL_VIMSELLIST-OPERATOR = 'EQ'.
 WL_VIMSELLIST-VALUE = RS_SELFIELD-VALUE.
 APPEND WL_VIMSELLIST TO TL_VIMSELLIST.
 CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
 EXPORTING
 ACTION = 'S' "S È para exibir
* CORR_NUMBER = ' '
* GENERATE_MAINT_TOOL_IF_MISSING = ' '
* SHOW_SELECTION_POPUP = ' '
 VIEW_NAME = 'ZT005' "Nome da manutenÁ„o de tabela
* NO_WARNING_FOR_CLIENTINDEP = ' '
* RFC_DESTINATION_FOR_UPGRADE = ' '
* CLIENT_FOR_UPGRADE = ' '
* VARIANT_FOR_SELECTION = ' '
* COMPLEX_SELCONDS_USED = ' '
* CHECK_DDIC_MAINFLAG = ' '
* SUPPRESS_WA_POPUP = ' '
 TABLES
 DBA_SELLIST = TL_VIMSELLIST "Determina os campos que eu quero que exiba
* EXCL_CUA_FUNCT =
 EXCEPTIONS
 CLIENT_REFERENCE = 1
 FOREIGN_LOCK = 2
 INVALID_ACTION = 3
 NO_CLIENTINDEPENDENT_AUTH = 4
 NO_DATABASE_FUNCTION = 5
 NO_EDITOR_FUNCTION = 6
 NO_SHOW_AUTH = 7
 NO_TVDIR_ENTRY = 8
 NO_UPD_AUTH = 9
 ONLY_SHOW_ALLOWED = 10
 SYSTEM_FAILURE = 11
 UNKNOWN_FIELD_IN_DBA_SELLIST = 12
 VIEW_NOT_FOUND = 13
 MAINTENANCE_PROHIBITED = 14
 OTHERS = 15.
 IF SY-SUBRC <> 0.
* Implement suitable error handling here
 ENDIF.
ENDIF.
ENDFORM.
