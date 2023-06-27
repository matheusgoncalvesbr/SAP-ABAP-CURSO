*&---------------------------------------------------------------------*
*& Report ZR017
*&---------------------------------------------------------------------*
*& DOWNLOAD DE INFORMA«’ES
*&---------------------------------------------------------------------*
REPORT ZR017.
* Tabela interna
DATA: T_ZT001 TYPE TABLE OF ZT001 WITH HEADER LINE.
* Tela de seleÁ„o
PARAMETERS P_FILE TYPE LOCALFILE.
START-OF-SELECTION.
 PERFORM F_SELECIONA_DADOS.
 PERFORM F_DOWNLOAD.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_SELECIONA_DADOS .
SELECT * FROM ZT001 INTO TABLE T_ZT001.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_DOWNLOAD
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_DOWNLOAD .
 DATA: VL_FILENAME TYPE STRING.
 VL_FILENAME = P_FILE.
 CALL FUNCTION 'GUI_DOWNLOAD'
 EXPORTING
* BIN_FILESIZE =
 FILENAME = VL_FILENAME
 FILETYPE = 'ASC'
* APPEND = ' '
* WRITE_FIELD_SEPARATOR = ' '
* HEADER = '00'
* TRUNC_TRAILING_BLANKS = ' '
* WRITE_LF = 'X'
* COL_SELECT = ' '
* COL_SELECT_MASK = ' '
* DAT_MODE = ' '
* CONFIRM_OVERWRITE = ' '
* NO_AUTH_CHECK = ' '
* CODEPAGE = ' '
* IGNORE_CERR = ABAP_TRUE
* REPLACEMENT = '#'
* WRITE_BOM = ' '
* TRUNC_TRAILING_BLANKS_EOL = 'X'
* WK1_N_FORMAT = ' '
* WK1_N_SIZE = ' '
* WK1_T_FORMAT = ' '
* WK1_T_SIZE = ' '
* WRITE_LF_AFTER_LAST_LINE = ABAP_TRUE
* SHOW_TRANSFER_STATUS = ABAP_TRUE
* VIRUS_SCAN_PROFILE = '/SCET/GUI_DOWNLOAD'
* IMPORTING
* FILELENGTH =
 TABLES
 DATA_TAB = T_ZT001
* FIELDNAMES =
* EXCEPTIONS
* FILE_WRITE_ERROR = 1
* NO_BATCH = 2
* GUI_REFUSE_FILETRANSFER = 3
* INVALID_TYPE = 4
* NO_AUTHORITY = 5
* UNKNOWN_ERROR = 6
* HEADER_NOT_ALLOWED = 7
* SEPARATOR_NOT_ALLOWED = 8
* FILESIZE_NOT_ALLOWED = 9
* HEADER_TOO_LONG = 10
* DP_ERROR_CREATE = 11
* DP_ERROR_SEND = 12
* DP_ERROR_WRITE = 13
* UNKNOWN_DP_ERROR = 14
* ACCESS_DENIED = 15
* DP_OUT_OF_MEMORY = 16
* DISK_FULL = 17
* DP_TIMEOUT = 18
* FILE_NOT_FOUND = 19
* DATAPROVIDER_EXCEPTION = 20
* CONTROL_FLUSH_ERROR = 21
* OTHERS = 22
 .
 IF SY-SUBRC <> 0.
* Implement suitable error handling here
 ENDIF.
ENDFORM.
