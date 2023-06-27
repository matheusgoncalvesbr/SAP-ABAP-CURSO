*&---------------------------------------------------------------------*
*& Report ZR012
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR012.
* DeclaraÁ„o de vari·veis
DATA: V_RESUL TYPE I.
* Tela de seleÁ„o
PARAMETERS: P_NUM1 TYPE I,
 P_NUM2 TYPE I,
 P_OPER TYPE C.
* Inicio do processamento
START-OF-SELECTION. "BLOCO PRINCIPAL DE EXECU«√O
 PERFORM F_EXECUTA_CALCULO.
 PERFORM F_IMPRIMI_RESULTADO.
*&---------------------------------------------------------------------*
*& Form F_EXECUTA_CALCULO
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_EXECUTA_CALCULO .
CALL FUNCTION 'Z_F0001'
 EXPORTING
 NUMERO1 = P_NUM1
 NUMERO2 = P_NUM2
 OPERACAO = P_OPER
IMPORTING
 RESULTADO = V_RESUL
EXCEPTIONS
 DIVI_ZERO = 1
 INV_OPERADOR = 2
 OTHERS = 3.
IF SY-SUBRC <> 0.
 IF SY-SUBRC = 1.
 MESSAGE TEXT-001 TYPE 'I'. "Operador inv·lido
 STOP.
 ELSEIF SY-SUBRC = 2.
 MESSAGE TEXT-002 TYPE 'I'. "Divis„o por zero
 STOP.
 ELSE.
 MESSAGE TEXT-003 TYPE 'I'. "Erro n„o identificado
 STOP.
 ENDIF.
ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_IMPRIMI_RESULTADO
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM F_IMPRIMI_RESULTADO .
WRITE: TEXT-004, V_RESUL. "RESULTADO: XX
ENDFORM.
