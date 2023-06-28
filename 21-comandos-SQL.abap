*&---------------------------------------------------------------------*
*& Report ZTREINO09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO09.
* Tabelas transparentes
TABLES ZT001.
* Tela de soluÁ„o
PARAMETERS: P_TPMAT LIKE ZT001-TPMAT OBLIGATORY,
 P_DENOM LIKE ZT001-DENOM OBLIGATORY,
 P_INSERT RADIOBUTTON GROUP GR1,
 P_UPDATE RADIOBUTTON GROUP GR1,
 P_MODIFY RADIOBUTTON GROUP GR1,
 P_DELETE RADIOBUTTON GROUP GR1.
* Exemplo comando INSERT
IF P_INSERT = 'X'.
 CLEAR ZT001.
 ZT001-TPMAT = P_TPMAT.
 ZT001-DENOM = P_DENOM.
 INSERT ZT001.
 IF SY-SUBRC = 0.
 COMMIT WORK.
 MESSAGE 'Registro cadastrado com sucesso' TYPE 'S'.
 ELSE.
 ROLLBACK WORK.
 MESSAGE 'Erro no cadastramento' TYPE 'I'.
 ENDIF.
ELSEIF P_UPDATE = 'X'.
 UPDATE ZT001
 SET DENOM = P_DENOM
 WHERE TPMAT = P_TPMAT.
 IF SY-SUBRC = 0.
 COMMIT WORK.
 MESSAGE 'Registro atualizado com sucesso' TYPE 'S'.
 ELSE.
 ROLLBACK WORK.
 MESSAGE 'Erro na atualizaÁ„o' TYPE 'I'.
 ENDIF.
ELSEIF P_MODIFY = 'X'.
 CLEAR ZT001.
 ZT001-TPMAT = P_TPMAT.
 ZT001-DENOM = P_DENOM.
 MODIFY ZT001.
 IF SY-SUBRC = 0.
 COMMIT WORK.
 MESSAGE 'Processo realizado com sucesso' TYPE 'S'.
 ELSE.
 ROLLBACK WORK.
 MESSAGE 'Erro no processamento' TYPE 'I'.
 ENDIF.
ELSEIF P_DELETE = 'X'.
 DELETE FROM ZT001 WHERE TPMAT = P_TPMAT.
 IF SY-SUBRC = 0.
 COMMIT WORK.
 MESSAGE 'Registro eliminado' TYPE 'S'.
 ELSE.
 ROLLBACK WORK.
 MESSAGE 'Erro ao eliminar' TYPE 'I'.
 ENDIF.
ENDIF.
