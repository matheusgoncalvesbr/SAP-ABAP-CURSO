*&---------------------------------------------------------------------*
*& Report ZTREINO003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO003.
* Vari·vel
DATA V_PORCENT TYPE P DECIMALS 2.
* Entradas
PARAMETERS: P_VALOR TYPE P DECIMALS 2,
 P_PORCEN TYPE P DECIMALS 2.
* Conta
V_PORCENT = ( P_VALOR / 100 ) * P_PORCEN.
* Impress„o
WRITE:/ 'O valor percentual È:',V_PORCENT.
