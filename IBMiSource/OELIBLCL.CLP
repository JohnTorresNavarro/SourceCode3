000100000000/*____________________________________________________________________________*/
000200000000/*                                                                            */
000300170505/*  Description:  SET OLE LIBL         +
000400000000/*                                                                            */
000500170505/*  (c)Copyright 2017 by GBS, Inc.                                        */
000600000000/*                                                                            */
000700170505/*    Created by:  JALLEN - May 05, 2017 +
000800000000/*____________________________________________________________________________*/
000900000000
001000110506             PGM        PARM(&DTA)
001100000000
001200170419             DCL        VAR(&DTA) TYPE(*CHAR) LEN(200)
001300170419             DCL        VAR(&RPGSP) TYPE(*CHAR) LEN(10)
001400170419
001500170419             RTVOBJD    OBJ(F.ACCMST) OBJTYPE(*FILE) RTNLIB(&RPGSP)
001600170419
001700170505             CALL       PGM(OELIBLR) PARM(&DTA &RPGSP)
001800170419
001900170419             RMVLIBLE   LIB(RPGSPPAYR)
002000170419             MONMSG     MSGID(CPF0000)
002100170419
002200170419             RMVLIBLE   LIB(RPGSPDASH)
002300170419             MONMSG     MSGID(CPF0000)
002400170419
002500170419             RMVLIBLE   LIB(RPGSPBETA)
002600170419             MONMSG     MSGID(CPF0000)
002700170419
002800170419             ADDLIBLE   LIB(&RPGSP) POSITION(*FIRST)
002900110506
003000110506             RCLRSC
003100000000
003200000000             ENDPGM
