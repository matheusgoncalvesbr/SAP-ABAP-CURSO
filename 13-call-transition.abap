*&---------------------------------------------------------------------*
*& Report ZR018
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR019 MESSAGE-ID ZCM001.
* Tipos
TYPES: BEGIN OF TY_FILE,
 FORNE LIKE ZT003-FORNE,
 DENOM LIKE ZT003-DENOM,
 ENDER LIKE ZT003-ENDER,
 TELEF LIKE ZT003-TELEF,
 EMAIL LIKE ZT003-EMAIL,
 CNPJ LIKE ZT003-CNPJ,
END OF TY_FILE.
* Tabelas internas
DATA: T_FILE TYPE STANDARD TABLE OF TY_FILE.
DATA: T_BDCDATA TYPE STANDARD TABLE OF BDCDATA.
DATA: T_MESSAGE TYPE STANDARD TABLE OF BDCMSGCOLL.
* Work area
DATA: W_FILE TYPE TY_FILE.
DATA: W_BDCDATA TYPE BDCDATA.
DATA: W_MESSAGE TYPE BDCMSGCOLL.
* Tela de seleÁ„o
PARAMETERS: P_FILE TYPE LOCALFILE,
 P_MODE TYPE C DEFAULT 'A'.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.
 PERFORM F_SELECIONA_ARQUIVO.
START-OF-SELECTION.
 PERFORM F_UPLOAD_FILE.
 PERFORM F_MONTA_BDC.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_ARQUIVO
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_SELECIONA_ARQUIVO .
 CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
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
* EXCEPTIONS
* MASK_TOO_LONG = 1
* OTHERS = 2
 .
 IF SY-SUBRC <> 0.
* Implement suitable error handling here
 ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_UPLOAD_FILE
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_UPLOAD_FILE .
DATA: VL_FILE TYPE STRING.
VL_FILE = P_FILE.
CALL FUNCTION 'GUI_UPLOAD'
 EXPORTING
 FILENAME = VL_FILE
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
 DATA_TAB = T_FILE
* CHANGING
* ISSCANPERFORMED = ' '
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
MESSAGE I000.
ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_MONTA_BDC
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_MONTA_BDC .
LOOP AT T_FILE INTO W_FILE.
 PERFORM F_MONTA_TELA USING 'SAPLZTABELAS01' '0003'."Passando parametros
 PERFORM F_MONTA_DADOS USING 'BDC_CURSOR' 'ZT003-DENOM(01)'.
 PERFORM F_MONTA_DADOS USING 'BDC_OKCODE' '=NEWL'.
 PERFORM F_MONTA_TELA USING 'SAPLZTABELAS01' '0005'.
 PERFORM F_MONTA_DADOS USING 'BDC_CURSOR' 'ZT003-CNPJ'.
 PERFORM F_MONTA_DADOS USING 'BDC_OKCODE' '=SAVE'.
 PERFORM F_MONTA_DADOS USING 'ZT003-FORNE' W_FILE-FORNE.
 PERFORM F_MONTA_DADOS USING 'ZT003-DENOM' W_FILE-DENOM.
 PERFORM F_MONTA_DADOS USING 'ZT003-ENDER' W_FILE-ENDER.
 PERFORM F_MONTA_DADOS USING 'ZT003-TELEF' W_FILE-TELEF.
 PERFORM F_MONTA_DADOS USING 'ZT003-EMAIL' W_FILE-EMAIL.
 PERFORM F_MONTA_DADOS USING 'ZT003-CNPJ' W_FILE-CNPJ.
 PERFORM F_MONTA_TELA USING 'SAPLZTABELAS01' '0005'.
 PERFORM F_MONTA_DADOS USING 'BDC_CURSOR' 'ZT003-DENOM'.
 PERFORM F_MONTA_DADOS USING 'BDC_OKCODE' '=ENDE'.
CALL TRANSACTION 'ZCADD03'
USING T_BDCDATA "Usa dados armazenados na tabela T_BDCDATA
MODE P_MODE "OpÁaı MODE
UPDATE 'A' "Modo de atualizaÁ„o
MESSAGES INTO T_MESSAGE. "Onde ser· armazenada as mensagens
PERFORM F_IMPRIMI_MESSAGE.
CLEAR: T_BDCDATA[], W_BDCDATA, T_MESSAGE[].
ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_MONTA_TELA
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* -->P_0168 text
* -->P_0169 text
*----------------------------------------------------------------------*
FORM F_MONTA_TELA USING P_PROGRAM
 P_SCREEN.
 CLEAR W_BDCDATA.
 W_BDCDATA-PROGRAM = P_PROGRAM.
 W_BDCDATA-DYNPRO = P_SCREEN.
 W_BDCDATA-DYNBEGIN = 'X'.
 APPEND W_BDCDATA TO T_BDCDATA.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_MONTA_DADOS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* -->P_0184 text
* -->P_0185 text
*----------------------------------------------------------------------*
FORM F_MONTA_DADOS USING P_NAME
 P_VALUE.
 CLEAR W_BDCDATA.
 W_BDCDATA-FNAM = P_NAME.
 W_BDCDATA-FVAL = P_VALUE.
 APPEND W_BDCDATA TO T_BDCDATA.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_IMPRIMI_MESSAGE
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_IMPRIMI_MESSAGE .
DATA: VL_ID TYPE BAPIRET2-ID,
 VL_NUMBER TYPE BAPIRET2-NUMBER,
 VL_MESS1 TYPE BAPIRET2-MESSAGE_V1,
 VL_MESS2 TYPE BAPIRET2-MESSAGE_V2,
 VL_MESS3 TYPE BAPIRET2-MESSAGE_V3,
 VL_MESS4 TYPE BAPIRET2-MESSAGE_V4,
 VL_MESSAGE TYPE BAPIRET2-MESSAGE.
LOOP AT T_MESSAGE INTO W_MESSAGE WHERE MSGTYP = 'E' OR MSGTYP = 'S'.
 VL_ID = W_MESSAGE-MSGID.
 VL_NUMBER = W_MESSAGE-MSGNR.
 VL_MESS1 = W_MESSAGE-MSGV1.
 VL_MESS2 = W_MESSAGE-MSGV2.
 VL_MESS3 = W_MESSAGE-MSGV3.
 VL_MESS4 = W_MESSAGE-MSGV4.
CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
 EXPORTING
 ID = VL_ID
 NUMBER = VL_NUMBER
* LANGUAGE = SY-LANGU
 TEXTFORMAT = 'ASC'
* LINKPATTERN =
 MESSAGE_V1 = VL_MESS1
 MESSAGE_V2 = VL_MESS2
 MESSAGE_V3 = VL_MESS3
 MESSAGE_V4 = VL_MESS4
* LANGUAGE_ISO =
* LINE_SIZE =
IMPORTING
 MESSAGE = VL_MESSAGE.
 WRITE: VL_MESSAGE.
ENDLOOP.
ENDFORM.
