*&---------------------------------------------------------------------*
*& Report ZR004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR004 NO STANDARD PAGE HEADING.
* DeclaraÁ„o de vari·veis
DATA: V_NOME TYPE STRING,
 V_DATA TYPE D,
 V_HORA TYPE T.
* Declaração de constantes
CONSTANTS C_ANO(4) TYPE C VALUE '2014'.
* Atribuindo valores as vari·veis
V_NOME = 'Matheus GonÁalves'.
V_DATA = '20140101'.
V_HORA = '120000'.
* Imprimindo as vari·veis
WRITE:/ 'NOME:', V_NOME.
WRITE:/ 'DATA:', V_DATA DD/MM/YYYY,
 / 'HORA:', V_HORA ENVIRONMENT TIME FORMAT,
 / 'ANO', C_ANO.
