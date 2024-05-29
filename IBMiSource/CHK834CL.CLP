000100000000/********************************************************************/
000200000000/*                                                                  */
000300000000/* 5770SS1 V7R3M0 160422     RTVCLSRC Output     08/01/22 17:03:38  */
000400000000/*                                                                  */
000500000000/* Program name . . . . . . . . . . . . . . :   CHK834CL          PN*/
000600000000/* Library name . . . . . . . . . . . . . . :   GBSPGMT           PL*/
000700000000/* Original source file . . . . . . . . . . :   QSPSRC            SN*/
000800000000/* Library name . . . . . . . . . . . . . . :   GBSPGMT           SL*/
000900000000/* Original source member . . . . . . . . . :   CHK834CL          SM*/
001000000000/* Source file change                                               */
001100000000/*   date/time  . . . . . . . . . . . . . . :   07/21/22 14:09:04 SC*/
001200000000/* Patch option . . . . . . . . . . . . . . :   *NOPATCH          PO*/
001300000000/* User profile . . . . . . . . . . . . . . :   *USER             UP*/
001400000000/* Text . . . : Check DW311CL step 2 and notify user              TX*/
001500000000/* Owner  . . . . . . . . . . . . . . . . . :   JALLEN            OW*/
001600000000/* User mod flag  . . . . . . . . . . . . . :   *YES              UM*/
001700000000/* Retrieve included source . . . . . . . . :   *NO               RI*/
001800000000/*                                                                ED*/
001900000000/********************************************************************/
002000000000     PGM PARM(&OUTFLG)
002100000000     DCL VAR(&OUTFLG) TYPE(*CHAR) LEN(1)
002200000000     DCL VAR(&CHK834) TYPE(*CHAR) LEN(1)
002300000000     CHGLIBL LIBL(#LIBRARY QSSP QTEMP GBSPGMT GBSDTAT GBSMOD GBSPGM -
002400000000QGPL RPGSPBETA Y2KDDS QS36F MAILTOOL)
002500000000     RTVDTAARA DTAARA(RUN834CL *ALL) RTNVAR(&CHK834)
002600000000     MAILTOOL TOADDR(jon.allen@amwins.com oleg.kaplun@amwins.com -
002700000000susan.treusdell@amwins.com claire.lanoue@amwins.com -
002800000000kevin.chamberlin@amwins.com) FROMADDR(jon.allen@amwins.com) -
002900000000FROMNAME(CHK834CL) SUBJECT('Testing Stored Procedure call CHK834CL') -
003000000000MESSAGE('Testing call of stored procedure to check for option 42 -
003100000000completion')
003200000000     CHGVAR VAR(&OUTFLG) VALUE('N')
003300000000     IF COND(&CHK834 *EQ ' ') THEN(DO)
003400000000     CHGVAR VAR(&OUTFLG) VALUE('Y')
003500000000     ENDDO
003600000000     ENDPGM
