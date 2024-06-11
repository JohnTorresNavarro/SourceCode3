000200000000/*____________________________________________________________________________*/
000300000000/*                                                                            */
000400000000/*  Description:  Update BLIXLSP via DFU +
000500000000/*                                                                            */
000600000000/*  (c)Copyright 2003 by Innovative Outsourcing, Inc.                     */
000700000000/*                                                                            */
000800000000/*    Created by:  JALLEN - October 07, 2003 +
000900000000/*____________________________________________________________________________*/
001000000000
001100031007             PGM        PARM(&PARM)
001200031007             DCL        VAR(&PARM) TYPE(*CHAR) LEN(1)
001300031007             IF COND(&PARM *EQ '1') THEN(DO)
001301031105             STRDFU     OPTION(1 1) DFUPGM(GBSMOD/XLSDFUC) +
001302031105                          FILE(GBSDTAT/BLIXLSL2)
001303031007             MONMSG     MSGID(CPF0000)
001400031007             ENDDO
001401031007             IF COND(&PARM *EQ '2') THEN(DO)
001402031007             STRDFU     OPTION(1 1) DFUPGM(GBSMOD/XLSDFUB) +
001403031007                          FILE(GBSDTAT/BLIXLSP)
001404031007             MONMSG     MSGID(CPF0000)
001405031007             ENDDO
001500000000
001600000000             ENDPGM
