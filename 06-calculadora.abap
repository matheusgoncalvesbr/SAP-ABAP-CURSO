*&---------------------------------------------------------------------*
*& Report ZR006
*&---------------------------------------------------------------------*
*& Calculadora
*&---------------------------------------------------------------------*
REPORT ZR006 MESSAGE-ID ZR001.
* DeclaraÁ„o de vari·veis
DATA: V_RESUL TYPE I.
* tela de exibiÁ„o
PARAMETERS: P_NUM1 TYPE I,
 P_NUM2 TYPE I,
 P_SOMA RADIOBUTTON GROUP GR1,
 P_SUBT RADIOBUTTON GROUP GR1,
 P_MULT RADIOBUTTON GROUP GR1,
 P_DIVI RADIOBUTTON GROUP GR1.
* Calculos
IF P_SOMA = 'X'.
 V_RESUL = P_NUM1 + P_NUM2.
ELSEIF P_SUBT = 'X'.
 V_RESUL = P_NUM1 - P_NUM2.
ELSEIF P_MULT = 'X'.
 V_RESUL = P_NUM1 * P_NUM2.
ELSEIF P_DIVI = 'X'.
 TRY.
 V_RESUL = P_NUM1 / P_NUM2.
 CATCH CX_SY_ZERODIVIDE.
*MESSAGE 'DIVIS√O POR ZERO N√O PERMITIDO' TYPE 'I'.
 MESSAGE I000.
 ENDTRY.
 STOP.
ENDIF.
* Imprimindo o resultado
WRITE: 'RESULTADO:', V_RESUL.
