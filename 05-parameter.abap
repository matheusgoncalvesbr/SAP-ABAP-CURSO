*&---------------------------------------------------------------------*
*& Report ZR005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR005 NO STANDARD PAGE HEADING.
*DeclaraÁ„o de par‚metos
PARAMETERS P_DATA TYPE D.
PARAMETERS: P_HORA TYPE T,
 P_NOME TYPE STRING.
* Impress„o de valores
WRITE:/ 'NOME:', P_NOME.
WRITE:/ 'DATA:', P_DATA DD/MM/YYYY.
WRITE:/ 'HORA:', P_HORA ENVIRONMENT TIME FORMAT.
