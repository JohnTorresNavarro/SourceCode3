000100000000/*____________________________________________________________________________*/
000200000000/*                                                                            */
000300000000/*  Description:  run blixls +
000400000000/*                                                                            */
000500000000/*  (c)Copyright 2003 by Innovative Outsourcing, Inc.                     */
000600000000/*                                                                            */
000700000000/*    Created by:  JALLEN - October 07, 2003 +
000800000000/*____________________________________________________________________________*/
000900000000
001000000000             PGM
001100000000
001200060911             CLRPFM     FILE(BLIRPT)
001300060911
001400060911             OVRDBF     FILE(BLICON) TOFILE(BLICON) SHARE(*YES)
001500060911             OPNQRYF    FILE((BLICON)) QRYSLT('LCCARR *EQ "CF"') +
001600060911                          KEYFLD(*FILE)
001700060911
001800060911             OVRDBF     FILE(AGENCY) TOFILE(F.AGENCY)
001900060911             OVRDBF     FILE(SMAN) TOFILE(F.SMAN)
002000060911             OVRDBF     FILE(SUPRAGCY) TOFILE(F.SUPRAGCY)
002100060911             OVRDBF     FILE(SMANRLT) TOFILE(F.SMANRLT)
002200060911             OVRDBF     FILE(SPRAGXR2) TOFILE(F.SPRAGXR2)
002300060911             CALL       PGM(BLIREPORT)
002400060911
002500060911             CLOF       OPNID(BLICON)
002600000000
002700000000             ENDPGM
