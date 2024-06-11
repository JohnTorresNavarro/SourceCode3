000100000327    ? *? COMPILE:
000200000407    ? *?   CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DFTACTGRP(*NO) DBGVIEW(*SOURCE)
000300000000    ? *?________________________________________________________________________
000400000000    ? *?
000500000410    ? *? Description:  Check AACODE file
000600000000    ? *?
000700000000    ? *? (c)Copyright 1999 by Inovative Outsourcing, Inc.
000800000000    ? *? This document contains restricted materials of IO, Inc.
000900000000    ? *?
001000000000    ? *? History:
001100000000    ? *?__________________________________________________________________
001200000127     FTMPREF    IF   E             DISK
001300000210    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)
001400000210    ?D WTM             S             80    DIM(32) CTDATA PERRCD(1)
001500000114     D ISO_DATE        S               D   DATFMT(*ISO)
001600000114     D USA_DATE        S               D   DATFMT(*USA)
001700000328    ?
001800000328      *?PROCEDURES______________________________________________________________
001900000328      /COPY QGPL/QRPGLESRC,SNDRPG_PR#
002000000328      /COPY QGPL/QRPGLESRC,SNDMSG_PR#
002100000328    ?
002200000328    ? *?Data structure
002300000410    ?D WDDATA        E DS                  EXTNAME(FM140W)
002400000000    ? *?
002500000000    ? *?Program status data structure
002600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002700000000    ? *?__________________________________________________________________
002800000000    ? *?Process check request
002900000210     C                   MOVE      *BLANKS       WORTN
003000000119     C                   SELECT
003100000210     C                   WHEN      WIRQS = 'EDIT'
003200000119     C                   EXSR      EDTRCD
003300000119
003400000210     C                   WHEN      WIRQS = 'EDTDLT'
003500000119     C                   EXSR      EDTDLT
003600000119
003700000210     C                   WHEN      WIRQS = 'DFTDTA'
003800000119     C                   EXSR      DFTDTA
003900000119
004000000119     C                   OTHER
004100000210     C                   EXSR      PRCERR
004200000210     C                   ENDSL
004300000216     C                   EVAL      *INLR = *ON
004400000210     C                   RETURN
004500000000    ? *?__________________________________________________________________
004600000000    ? *?Edit record
004700000000    ? *?__________________________________________________________________
004800000210     C     EDTRCD        BEGSR
004900000322      *?                 EXSR      DFTDTA
005000000322    ? *?EXAMPLE BELOW
005100991108    ? *?
005200000410      *?  61 AACODE ERROR
005300000114    ? *?
005400000410     C                   IF        ACODE  = *ZEROS
005500000327    ?C                   MOVE      WTM(1)        WWMSG
005600000327     C                   CALLP     SNDMSG
005700000327     C                   MOVEL     'ERROR'       WORTN
005800000327     C                   END
005900000327      *?  62 LAST NAME       ERROR
006000000327    ? *?
006100000410     C                   IF        ALNAM  = *BLANKS
006200000327    ?C                   MOVE      WTM(2)        WWMSG
006300000327     C                   CALLP     SNDMSG
006400000327    ?C                   MOVEL     'ERROR'       WORTN
006500000327     C                   END
006600000327      *?  63 FIRST NAME      ERROR
006700000327    ? *?
006800000410     C                   IF        AFNAM  = *BLANKS
006900000327    ?C                   MOVE      WTM(3)        WWMSG
007000000327     C                   CALLP     SNDMSG
007100000327    ?C                   MOVEL     'ERROR'       WORTN
007200000327     C                   END
007300000410      *?  64 EMAIL ADDRESS ERROR
007400000327    ? *?
007500000410     C                   IF        AEMLA  = *BLANKS
007600000327    ?C                   MOVE      WTM(4)        WWMSG
007700000327     C                   CALLP     SNDMSG
007800000327    ?C                   MOVEL     'ERROR'       WORTN
007900000327     C                   END
008000000210    ?
008100000327     C                   ENDSR
008200000000    ? *?__________________________________________________________________
008300000000    ? *?Edit delete request
008400000000    ? *?__________________________________________________________________
008500000327     C     EDTDLT        BEGSR
008600000327    ? *?Use this subroutine to validate a delete.                      ___
008700000327     C*?                 IF        XYZ    = *ZEROS
008800000327    ?C*?                 MOVE      WTMP(1)        WWMSG
008900000322     C*?                 CALLP     SNDMSG
009000000327    ?C*?                 MOVEL     'ERROR'       WORTN
009100000327     C*?                 END
009200000210     C                   ENDSR
009300000000    ? *?__________________________________________________________________
009400000000    ? *?Default data
009500000000    ? *?__________________________________________________________________
009600000210     C     DFTDTA        BEGSR
009700000410     C                   CLEAR                   ACODE
009800000210     C                   ENDSR
009900000000    ? *?__________________________________________________________________
010000000000    ? *?Process error
010100000000    ? *?__________________________________________________________________
010200000210     C     PRCERR        BEGSR
010300000210     C                   MOVE      'ERROR   '    WORTN
010400000210     C                   MOVE      WTMP(2)       WWMSG
010500000215     C                   CALLP     SNDMSG
010600000210     C                   ENDSR
010700000000    ? *?__________________________________________________________________
010800000000    ? *?Parameter list
010900000000    ? *?__________________________________________________________________
011000000210     C     PLIST         BEGSR
011100000210     C     *ENTRY        PLIST
011200000210     C                   PARM                    WIRQS
011300000210     C                   PARM                    WORTN
011400000327     C                   PARM                    WDDATA
011500000210     C                   ENDSR
011600000000    ? *?__________________________________________________________________
011700000000    ? *?__________________________________________________________________
011800000000    ? *?Program error handler
011900000000    ? *?__________________________________________________________________
012000000215     C     *PSSR         BEGSR
012100000215     C                   CALLP     SNDRPG
012200000215     C                   ENDSR     '*CANCL'
012300000000    ? *?__________________________________________________________________
012400000308      /COPY QGPL/QRPGLESRC,SNDRPG#
012500000308      /COPY QGPL/QRPGLESRC,SNDMSG#
012600000327** WTMP
01270000032700Record is not eligible for deletion.
01280000041000Request not supported by program FM143.
012900000327** WTM
01300000041061AACODE cannot be zero.
01310000032762Last Name cannot be Blank.
01320000032763First Name cannot be Blank.
01330000041064Email Address cannot be Blank.
