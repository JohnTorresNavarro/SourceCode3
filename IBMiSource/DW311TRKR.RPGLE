000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check Tracking File for previous Add
000400000000      *
000500000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - January 29, 2010
000800000000      *_________________________________________________________________________
000900100129     FDW311TRKLFIF   E           K DISK
001000100129
001100100129     D TODAY           s              8s 0
001200100129     D WWFLG           S              1    inz
001300100129
001400100129     D X_DTSSN         S              9A
001500100129     D X_DTSEQ         S              2A
001600100129     D X_DTCAT         S              1A
001700100129     D X_DTFLG         S              1A
001800100129
001900100129     D WDTA          E DS                  EXTNAME(DW311TRK) Prefix(P_)
002000100129
002100100129     C     *ENTRY        PLIST
002200100129     C                   PARM                    X_DTSSN
002300100129     C                   PARM                    X_DTSEQ
002400100129     C                   PARM                    X_DTCAT
002500100129     C                   PARM                    X_DTFLG
002600100129     C                   PARM                    WWRTN             1
002700100129
002800100129     C                   MOVE      X_DTSSN       P_DTSSN
002900100129     C                   MOVE      X_DTSEQ       P_DTSEQ
003000100129     C                   MOVE      X_DTCAT       P_DTCAT
003100100129     C                   MOVE      X_DTFLG       P_DTFLG
003200100129     C                   MOVE      *BLANKS       WWRTN
003300100129
003400100129     C     P_KEY         SETLL     DW311TRKLF
003500100129     C     P_KEY         READE     DW311TRKLF
003600100129     C                   DOW       not %eof(DW311TRKLF)
003700100129
003800100129     C                   IF        DTCAT = P_DTCAT and
003900100129     C                             DTSNT < Today
004000100129     C                   EVAL      WWFLG = DTFLG
004100100129     C                   END
004200100129
004300100129     C     P_KEY         READE     DW311TRKLF
004400100129     C                   ENDDO
004500100129
004600100129      * Add Already Sent? Possible Change in class
004700100205     C                   Select
004800100205     C                   When      WWFLG   = 'A' and
004900100129     C                             P_DTFLG = 'A'
005000100129     C                   EVAL      WWRTN   = 'C'
005100100205     C                   When      WWFLG   = 'T' and
005200100205     C                             P_DTFLG = 'C'
005300100205     C                   EVAL      WWRTN   = 'R'
005400100205     C                   ENDSL
005500100129
005600100129     C                   EVAL      *INLR = *ON
005700100129     C                   RETURN
005800000000      *___________________________________________________________________
005900000000      * Key Lists
006000000000      *___________________________________________________________________
006100000000     C     KLIST         BEGSR
006200100129     C     P_KEY         KLIST
006300100129     C                   KFLD                    P_DTSSN
006400100129     C                   KFLD                    P_DTSEQ
006500000000     C                   ENDSR
006600000000      *___________________________________________________________________
006700000000      * Program open
006800000000      *___________________________________________________________________
006900000000     C     *INZSR        BEGSR
007000100129     C     *Date         Mult      10000.0001    Today
007100000000     C                   ENDSR
