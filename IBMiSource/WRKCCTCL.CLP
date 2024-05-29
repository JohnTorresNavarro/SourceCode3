000100180501             PGM        PARM(&TRST &SUB# &ACCT)
000200000000
000300000000/* Declare program variables  */
000400991201             DCL        VAR(&RQS) TYPE(*CHAR) LEN(8) VALUE(' ') /* +
000500991201                          request */
000600000707             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
000700991201             DCL        VAR(&RTNCOD) TYPE(*CHAR) LEN(8) VALUE(' ') +
000800991201                          /* return code */
000900991201             DCL        VAR(&LSTPGM) TYPE(*CHAR) LEN(10) VALUE(' ') +
001000991201                          /* last pgm dsp */
001100991201             DCL        VAR(&RCDDS) TYPE(*CHAR) LEN(2048) /* record +
001200991201                          DS */
001300991201             DCL        VAR(&VLDOPT) TYPE(*CHAR) LEN(60) VALUE(' ') +
001400991201                          /* valid opt */
001500991201             DCL        VAR(&VLDFKY) TYPE(*CHAR) LEN(60) VALUE(' ') +
001600991201                          /* valid fnc */
001700010219             DCL        VAR(&PFX241) TYPE(*CHAR) LEN(1) /* Data file +
001800010219                          Prefix */
001900180501             DCL        VAR(&TRST) TYPE(*CHAR) LEN(3)
002000180501             DCL        VAR(&SUB#) TYPE(*CHAR) LEN(3)
002100180501             DCL        VAR(&ACCT) TYPE(*CHAR) LEN(4)
002200180501             DCL        VAR(&P) TYPE(*CHAR) LEN(1)
002300180501             DCL        VAR(&CONAME) TYPE(*CHAR) LEN(40)
002400000000
002500180501             CALL       PGM(COMPNY)
002600180501             RTVDTAARA  DTAARA(*LDA (241 1)) RTNVAR(&P)
002700180501             RTVDTAARA  DTAARA(COMPANY (1 40)) RTNVAR(&CONAME)
002800180501
002900180501             CHGDTAARA  DTAARA(*LDA (201 40)) VALUE(&CONAME)
003000180501
003100180501             OVRDBF     FILE(ACCMST) TOFILE(F.ACCMST) OVRSCOPE(*JOB)
003200180501
003300991105             CRTDTAQ    DTAQ(QTEMP/MSGDTAQ) MAXLEN(80) TEXT('Program +
003400991105                          Message Que')
003500991105             MONMSG     MSGID(CPF0000)
003600181219
003700181219/* &VLDX - 'I XX' = INCLUDE, 'X XX' = EXCLUDE  */
003800010219
003900000707             CHGVAR     VAR(&RQS) VALUE('LOAD')
004000181219             CHGVAR     &VLDOPT   'I 0205'
004100181219             CHGVAR     &VLDFKY   'X 10'
004200000707
004300180501             CALL       PGM(WRKCCT) PARM(&RQS &RTNCOD &LSTPGM &RCDDS +
004400180501                          &VLDOPT &VLDFKY &TRST &SUB# &ACCT) /* +
004500180501                          valid functions  */
004600000127
004700000210 ENDPGM:     RCLRSC
004800991105             ENDPGM
