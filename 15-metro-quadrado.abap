*&---------------------------------------------------------------------*
*& Report ZTREINO002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO002.
* Vari·vel
DATA V_METRO TYPE P DECIMALS 2.
* Entradas
PARAMETERS: P_MED1 TYPE P DECIMALS 2,
 P_MED2 TYPE P DECIMALS 2.
* Conta
V_METRO = P_MED1 * P_MED2.
* Impress„o
WRITE:/ 'A metragem quadrada È:',V_METRO
