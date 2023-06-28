*&---------------------------------------------------------------------*
*& Report ZTREINO004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO004.
* Vari·veis
DATA: V_LITROS TYPE P DECIMALS 2,
 V_VALOR TYPE P DECIMALS 2.
* Entradas
PARAMETERS: P_DISTAN TYPE P DECIMALS 2,
 P_VL_LT TYPE P DECIMALS 2,
 P_KM_LT TYPE P DECIMALS 2.
* Contas
V_LITROS = P_DISTAN / P_KM_LT.
V_VALOR = V_LITROS * P_VL_LT.
* Impress„o
WRITE:/ 'Quantidade combustÌvel gasto:',V_LITROS,
 / 'Valor total gasto:',V_VALOR.
