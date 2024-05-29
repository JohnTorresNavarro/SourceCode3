000100000000/********************************************************************/
000200000000/*                                                                  */
000300000000/* 5770SS1 V7R2M0 140418     RTVCLSRC Output     09/30/16 11:13:58  */
000400000000/*                                                                  */
000500000000/* Program name . . . . . . . . . . . . . . :   MAILUSERCL        PN*/
000600000000/* Library name . . . . . . . . . . . . . . :   QGPL              PL*/
000700000000/* Original source file . . . . . . . . . . :   QCLSRC            SN*/
000800000000/* Library name . . . . . . . . . . . . . . :   QGPL              SL*/
000900000000/* Original source member . . . . . . . . . :   MAILUSERCL        SM*/
001000000000/* Source file change                                               */
001100000000/*   date/time  . . . . . . . . . . . . . . :   02/28/13 09:45:13 SC*/
001200000000/* Patch option . . . . . . . . . . . . . . :   *NOPATCH          PO*/
001300000000/* User profile . . . . . . . . . . . . . . :   *USER             UP*/
001400000000/* Text . . . : email report back to user                         TX*/
001500000000/* Owner  . . . . . . . . . . . . . . . . . :   DLK               OW*/
001600000000/* User mod flag  . . . . . . . . . . . . . :   *YES              UM*/
001700000000/* Retrieve included source . . . . . . . . :   *NO               RI*/
001800000000/*                                                                ED*/
001900000000/********************************************************************/
002000000000     PGM PARM(&OUTPUT &FILE &SUBJECT)
002100000000     DCL VAR(&JOB) TYPE(*CHAR) LEN(10)
002200000000     DCL VAR(&USER) TYPE(*CHAR) LEN(10)
002300000000     DCL VAR(&NBR) TYPE(*CHAR) LEN(6)
002400000000     DCL VAR(&OUTPUT) TYPE(*CHAR) LEN(1)
002500000000     DCL VAR(&FILE) TYPE(*CHAR) LEN(10)
002600000000     DCL VAR(&SUBJECT) TYPE(*CHAR) LEN(44)
002700000000     RTVJOBA JOB(&JOB) USER(&USER) NBR(&NBR)
002800000000     IF COND(&OUTPUT = 'E' *OR &OUTPUT = 'B') THEN(DO)
002900000000     ESPOOL FILE(&FILE) SUBJECT(&SUBJECT) JOB(&NBR/&USER/&JOB) -
003000000000SPLNBR(*LAST) TOFILE(REPORT) EXT('.TXT')
003100000000     MONMSG MSGID(CPF3300) EXEC(GOTO CMDLBL(END))
003200000000     MONMSG MSGID(CPF8A16)
003300000000     IF COND(&OUTPUT = 'E') THEN(DLTSPLF FILE(&FILE) -
003400000000JOB(&NBR/&USER/&JOB) SPLNBR(*LAST))
003500000000     ENDDO
003600000000     CALL PGM(MAILUSE) PARM(&USER &SUBJECT &OUTPUT)
003700000000END: +
003800000000     ENDPGM
