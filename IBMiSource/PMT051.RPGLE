000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Cash Receipts TRUST BUSTER
000500000000      *
000600000000      *  (c)Copyright 2008 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - February 18, 2008
000900000000      *_________________________________________________________________________
000901080218     FHIST      UF   E           K DISK
000902080218     FTRSMST    IF   E           K DISK
000903080218
000904080218     D KEY             S             10A   INZ
000905080218     D POS             S              3S 0 INZ
000906080218     D COD             S              1A   INZ
001000080218      *
001100080218     D WDTA          E DS                  EXTNAME(PMT050DS)
001101080218     D  CAT                   27     36A   DIM(10)
001200000000      *
001201080218     C     *ENTRY        PLIST
001300080218     C                   PARM                    WDTA
001301080624      *
001302080624     C                   MOVEA     CAT           TEST             10
001303080624      *
001304080624     C                   IF        PMTTRS = *BLANKS  and
001305080624     C                             TEST  <> *BLANKS
001306080218      *
001307080218     C     KEY           SETLL     HIST
001308080218     C                   READ      HIST
001309080218     C                   DOW       NOT %EOF
001310080218      *
001311080218     C     HSTRST        CHAIN     TRSMST
001312080218     C                   IF        %FOUND(TRSMST)
001313080218     C                   MOVE      TSCODE        COD
001314080218     C                   EVAL      POS = %LOOKUP(COD:CAT)
001315080218     C                   IF        POS = 0
001316080218     C                   DELETE    HISTR
001317080218     C                   END
001318080218     C                   ELSE
001319080218     C                   DELETE    HISTR
001320080218     C                   END
001321080218      *
001322080218     C                   READ      HIST
001323080218     C                   ENDDO
001324080624     C                   END
001325080218      *
001326080218     C                   EVAL      *INLR = *ON
001327080218     C                   RETURN
001400080218      *
