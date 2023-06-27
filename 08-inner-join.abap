*&---------------------------------------------------------------------*
*& Report ZR013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR013.
* Tabelas transparentes
TABLES: ZT005.
* TIPOS
TYPES: BEGIN OF TY_MATER,
 MATER LIKE ZT005-MATER,
 DENOM LIKE ZT005-DENOM,
 BRGEW LIKE ZT005-BRGEW,
 NTGEW LIKE ZT005-NTGEW,
 GEWEI LIKE ZT005-GEWEI,
 STATUS LIKE ZT005-STATUS,
 TPMAT LIKE ZT001-TPMAT,
 DENOM1 LIKE ZT001-DENOM,
END OF TY_MATER.
* WORK AREA
DATA W_MATER TYPE TY_MATER.
* TABELAS INTERNAS
DATA T_MATER TYPE TABLE OF TY_MATER.
* Tela de seleÁ„o
SELECTION-SCREEN BEGIN OF BLOCK B01 WITH FRAME TITLE TEXT-001.
 SELECT-OPTIONS: S_TPMAT FOR ZT005-TPMAT,
 S_MATER FOR ZT005-MATER.
SELECTION-SCREEN END OF BLOCK B01.
* Inicio do processamento
START-OF-SELECTION.
PERFORM F_SELECIONA_DADOS.
PERFORM F_IMPRIMI_DADOS.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_SELECIONA_DADOS .
SELECT ZT005~MATER ZT005~DENOM ZT005~BRGEW ZT005~NTGEW ZT005~GEWEI
 ZT005~STATUS ZT001~TPMAT ZT001~DENOM
 FROM ZT005
INNER JOIN ZT001
 ON ZT005~TPMAT = ZT001~TPMAT
INTO TABLE T_MATER
WHERE ZT005~TPMAT IN S_TPMAT
 AND ZT005~MATER IN S_MATER.
 IF SY-SUBRC <> 0.
 MESSAGE TEXT-002 TYPE 'I'. "N„o foi encontrado nenhum registro com esse par‚metros
 STOP.
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
LOOP AT T_MATER INTO W_MATER.
 WRITE:/ W_MATER-MATER, W_MATER-DENOM, W_MATER-BRGEW, W_MATER-NTGEW,
 W_MATER-GEWEI, W_MATER-STATUS, W_MATER-TPMAT, W_MATER-DENOM1.
ENDLOOP.
ENDFORM.
