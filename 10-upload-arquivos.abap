*&---------------------------------------------------------------------*
*& Report ZR016
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR016.
* Tipos
TYPES: BEGIN OF TY_TXT,
 CODIGO(10) TYPE C,
 NOME(30) TYPE C,
 TELEFONE(14) TYPE C,
END OF TY_TXT.
TYPES: BEGIN OF TY_CSV,
 LINE(100) TYPE C,
END OF TY_CSV.
* Tabelas internas
DATA: T_TXT TYPE TABLE OF TY_TXT.
DATA: T_CSV TYPE TABLE OF TY_CSV.
* WORK AREA
DATA: W_TXT TYPE TY_TXT.
DATA: W_CSV TYPE TY_CSV.
* Tela de selÁ„o
PARAMETERS: P_FILE TYPE LOCALFILE,
 P_CSV RADIOBUTTON GROUP GR1,
 P_TXT RADIOBUTTON GROUP GR1.
* Evento ser· ativado ao clicar no PAR¬METRO P_FILE
AT SELECTION-SCREEN on VALUE-REQUEST FOR P_FILE.
 PERFORM F_SELECIONA_ARQUIVO.
START-OF-SELECTION.
 PERFORM F_UPLOAD.
 PERFORM F_IMPRIMI_DADOS.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_ARQUIVO
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_SELECIONA_ARQUIVO .
CALL FUNCTION 'KD_GET_FILENAME_ON_F4' "SeleÁ„o de arquivos
EXPORTING
* PROGRAM_NAME = SYST-REPID
* DYNPRO_NUMBER = SYST-DYNNR
 FIELD_NAME = P_FILE
* STATIC = ' '
* MASK = ' '
* FILEOPERATION = 'R'
* PATH =
 CHANGING
 FILE_NAME = P_FILE
* LOCATION_FLAG = 'P'
EXCEPTIONS
 MASK_TOO_LONG = 1
 OTHERS = 2.
IF SY-SUBRC <> 0.
MESSAGE TEXT-001 TYPE 'I'. "Erro na seleÁ„o de arquivos
ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_UPLOAD
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_UPLOAD .
DATA VL_FILENAME TYPE STRING.
FIELD-SYMBOLS <TABELA> TYPE STANDARD TABLE.
* Consegue receber qualquer tipo de valor
VL_FILENAME = P_FILE.
IF P_TXT = 'X'.
 ASSIGN T_TXT TO <TABELA>. "Atribuo a estrutura da tabela interna para field symbols
ELSE.
 ASSIGN T_CSV TO <TABELA>.
ENDIF.
CALL FUNCTION 'GUI_UPLOAD'
 EXPORTING
 FILENAME = VL_FILENAME
 FILETYPE = 'ASC'
* HAS_FIELD_SEPARATOR = ' '
* HEADER_LENGTH = 0
* READ_BY_LINE = 'X'
* DAT_MODE = ' '
* CODEPAGE = ' '
* IGNORE_CERR = ABAP_TRUE
* REPLACEMENT = '#'
* CHECK_BOM = ' '
* VIRUS_SCAN_PROFILE =
* NO_AUTH_CHECK = ' '
* IMPORTING
* FILELENGTH =
* HEADER =
 TABLES
 DATA_TAB = <TABELA>
EXCEPTIONS
 FILE_OPEN_ERROR = 1
 FILE_READ_ERROR = 2
 NO_BATCH = 3
 GUI_REFUSE_FILETRANSFER = 4
 INVALID_TYPE = 5
 NO_AUTHORITY = 6
 UNKNOWN_ERROR = 7
 BAD_DATA_FORMAT = 8
 HEADER_NOT_ALLOWED = 9
 SEPARATOR_NOT_ALLOWED = 10
 HEADER_TOO_LONG = 11
 UNKNOWN_DP_ERROR = 12
 ACCESS_DENIED = 13
 DP_OUT_OF_MEMORY = 14
 DISK_FULL = 15
 DP_TIMEOUT = 16
 OTHERS = 17.
IF SY-SUBRC <> 0.
 MESSAGE TEXT-002 TYPE 'I'."Erro na abertura do arquivo
 STOP.
ENDIF.
IF P_CSV = 'X'.
 LOOP AT <TABELA> INTO W_CSV.
 SPLIT W_CSV AT ';' INTO W_TXT-CODIGO W_TXT-NOME W_TXT-TELEFONE.
 APPEND W_TXT TO T_TXT.
* Separe as informaÁıes da W_csv por ; e coloque no codigo, nome e telefone
 ENDLOOP.
ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_IMPRIMI_DADOS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_IMPRIMI_DADOS .
 LOOP AT T_TXT INTO W_TXT.
 WRITE:/ W_TXT-CODIGO, W_TXT-NOME, W_TXT-TELEFONE.
 ENDLOOP.
ENDFORM.
