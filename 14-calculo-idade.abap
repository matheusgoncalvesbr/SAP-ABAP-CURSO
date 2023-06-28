*&---------------------------------------------------------------------*
*& Report ZTREINO001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO001.
* Vari·vel
DATA V_IDADE(4) type c.
* Entradas
PARAMETERS: P_NOME(40) TYPE C,
 P_ANO(4) TYPE C.
* Conta
V_IDADE = SY-DATUM(4) - P_ANO.
* Impress„o
WRITE:/ 'O Sr.(a):',P_NOME,
 / 'Tem',V_IDADE,'anos'.
