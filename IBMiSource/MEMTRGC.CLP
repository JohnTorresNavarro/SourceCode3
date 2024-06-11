000100000000/*   CRTCLPGM                                                                 */
000200000000/*____________________________________________________________________________*/
000300000000/*                                                                            */
000400000000/*  Description:  ADDPFMTRG one-time +
000500000000/*                                                                            */
000600000000/*  (c)Copyright 2020 by Innovative Outsourcing, Inc.                     */
000700000000/*                                                                            */
000800000000/*    Created by:  JALLEN - September 02, 2020 +
000900000000/*____________________________________________________________________________*/
001000000000
001100000000             PGM
001200200902
001300200902
001400200902 AGAIN:      ADDPFTRG   FILE(QS36F/F.MEMBER) TRGTIME(*AFTER) +
001500200902                          TRGEVENT(*UPDATE) PGM(GBSPGM/MEMTRGR) +
001600200902                          TRGLIB(*FILE) TRGUPDCND(*CHANGE)
001700200902
001800200902             MONMSG     MSGID(CPF3202 CPF32C6) EXEC(DO)
001900200902             DLYJOB     DLY(300)
002000200902             GOTO       CMDLBL(AGAIN)
002100200902             ENDDO
002200000000
002300000000             ENDPGM
