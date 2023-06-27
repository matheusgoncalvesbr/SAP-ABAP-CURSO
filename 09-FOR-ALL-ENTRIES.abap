*&---------------------------------------------------------------------*
*& Report ZR014
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR014.
* Tabelas transparentes
TABLES: ZT005.
* Tabelas internas
DATA: T_ZT001 TYPE TABLE OF ZT001 WITH HEADER LINE,
 T_ZT005 TYPE TABLE OF ZT005 WITH HEADER LINE.
* Tela de seleÁ„o
SELECT-OPTIONS: S_TPMAT FOR ZT005-TPMAT,
 S_MATER FOR ZT005-MATER.
* Tela de processamento
START-OF-SELECTION.
PERFORM F_SELECIONA_DADOS.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_SELECIONA_DADOS .
 SELECT * FROM ZT005
 INTO TABLE T_ZT005
 WHERE MATER IN S_MATER
 AND TPMAT IN S_TPMATER.
 IF SY-SUBRC IS INITIAL.
 SELECT * FROM ZT001
 INTO TABLE T_ZT001
 FOR ALL ENTRIES IN T_ZT005
 WHERE TPMAT = T_ZT005-TPMAT.
 ENDIF.
 ELSE.
 MESSAGE TEXT-001 TYPE 'I'. "Nenhum registro encontrado para esse crieterio de seleÁ„o
 STOP.
ENDIF.
ENDFORM.
