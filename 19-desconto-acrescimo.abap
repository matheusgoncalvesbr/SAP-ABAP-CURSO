*&---------------------------------------------------------------------*
*& Report ZTREINO006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTREINO006.
* Vari·vel
DATA: V_FINAL TYPE P DECIMALS 2,
 V_DES_ACRE TYPE P DECIMALS 2,
 V_PERCENTU TYPE P DECIMALS 2.
* Entradas
PARAMETERS: P_TOTAL TYPE P DECIMALS 2,
 P_QTDP TYPE I.
* VerificaÁ„o
IF P_TOTAL <= '100.00' AND P_QTDP = 1.
 V_PERCENTU = '-15'.
ELSEIF P_TOTAL > '100.00' AND P_QTDP = 1.
 V_PERCENTU = '-20'.
ELSEIF P_TOTAL <= '100.00' AND P_QTDP <= 3.
 V_PERCENTU = '-5'.
ELSEIF P_TOTAL <= '100.00' AND P_QTDP <= 3.
 V_PERCENTU = '-10'.
ELSEIF P_QTDP > 3.
 V_PERCENTU = '+10'.
ENDIF.
* Conta
V_DES_ACRE = ( P_TOTAL / 100 ) * V_PERCENTU.
V_FINAL = P_TOTAL + V_DES_ACRE.
* Impress„o
WRITE:/ 'Valor original:',P_TOTAL,
 / 'Qtd.parcela(s):',P_QTDP,
 / 'Percentual Desconto/AcrÈscimo:',V_PERCENTU,
 / 'Valor Desconto/AcrÈscimo:',V_DES_ACRE,
 / 'Valor final:',V_FINAL.
