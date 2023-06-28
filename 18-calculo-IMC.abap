*&---------------------------------------------------------------------*
*& Report ZTREINO005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO005.
* Vari·vel
DATA V_IMC TYPE P DECIMALS 2.
* Entradas
PARAMETERS: P_PESO TYPE P DECIMALS 2,
 P_ALTURA TYPE P DECIMALS 2.
* Conta
V_IMC = P_PESO / ( P_ALTURA * P_ALTURA ).
* ValidaÁ„o
IF V_IMC < '17'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Muito abaixo do peso"'.
ELSEIF V_IMC >= '17.0' AND V_IMC < '18.5'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Abaixo do peso"'.
ELSEIF V_IMC >= '18.5' AND V_IMC < '25.0'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Peso normal"'.
ELSEIF V_IMC >= '25.0' AND V_IMC < '30.0'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Acima do peso"'.
ELSEIF V_IMC >= '30.0' AND V_IMC < '35.0'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Obesidade 1"'.
ELSEIF V_IMC >= '35.0' AND V_IMC < '40.0'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Obesidade 2 (severa)"'.
ELSEIF V_IMC >= '40.0'.
 WRITE: 'O IMC È',V_IMC,'e a situaÁ„o È "Obesidade 3 (mÛrbida)"'.
ENDIF.
