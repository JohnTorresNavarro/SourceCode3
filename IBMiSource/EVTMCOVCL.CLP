000100000000/*   CRTCLPGM                                                                 */
000200000000/*____________________________________________________________________________*/
000300000000/*                                                                            */
000400000000/*  Description:  write to MCOV/DCOV for ZOE's +
000500000000/*                                                                            */
000600000000/*  (c)Copyright 2019 by Innovative Outsourcing, Inc.                     */
000700000000/*                                                                            */
000800000000/*    Created by:  JALLEN - July 12, 2019 +
000900000000/*____________________________________________________________________________*/
001000000000
001100000000             PGM
001200000000
001300190715             OVRDBF     FILE(MCOVC) TOFILE(F.MCOVC) FRCRATIO(1)
001400190715             OVRDBF     FILE(DCOVC) TOFILE(F.DCOVC) FRCRATIO(1)
001500190722             CALL       PGM(EVTMCOVR)
001600000000
001700000000             ENDPGM
