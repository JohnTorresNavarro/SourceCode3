000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Nightly Add Tracking records from conversion
000400000000      *
000500100209      *  (c)Copyright 2010 by GBS, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 09, 2010
000800000000      *_________________________________________________________________________
000900100209     FHISTAK    IP   E           K DISK
001000100209     FPLNMST    IF   E           K DISK
001100100209     FCARMST    IF   E           K DISK
001200100209     FDW311TRK  O  A E           K DISK
001300100209
001400100209     D PLAN#           S              4A
001500100209
001600100209     IHISTR         01
001700100209     I                                          HKEY          L2
001800100209     I                                          HDSEQ#        L2
001900100209     I                                          NOTE2         L2
002000100209
002100100209     C   L2              EXSR      PROCESS
002200100209      *___________________________________________________________________
002300100209      * Process
002400100209      *___________________________________________________________________
002500100209     C     PROCESS       BEGSR
002600100209      *
002700100209     C                   Eval      PLAN# = %trim(NOTE2)
002800100209      *
002900100209     C     PCATKY        KLIST
003000100209     C                   Kfld                    HSTRST
003100100209     C                   Kfld                    HSSUB#
003200100209     C                   Kfld                    PLAN#
003300100209      *
003400100209     C     PCATKY        CHAIN     PLNMST
003500100209     C                   IF        %FOUND(PLNMST)
003600100209     C     PCARR         CHAIN     CARMST
003700100209     C                   IF        %found(CARMST)
003800100209     C                   IF        CARBC = 'D'
003900100209     C                   EXSR      PlanTracking
004000100209     C                   END
004100100209     C                   END
004200100209     C                   END
004300100209      *
004400100209     C                   ENDSR
004500100209      *___________________________________________________________________
004600100209      * Plan Tracking
004700100209      *___________________________________________________________________
004800100209     C     PlanTracking  BEGSR
004900100209
005000100209     C                   Select
005100121023     C                   When      PLNCAT = 'PMM' or
005200121023     C                             PLNCAT = 'PCM'
005300100209     C                   Eval      DTCAT = 'M'
005400100209     C                   When      PLNCAT = 'PRX'
005500100209     C                   Eval      DTCAT = 'R'
005600110922     C                   When      PLNCAT = 'PDR' or
005700140917     C                             PLNCAT = 'PCD' or
005800130118     C                             PLNCAT = 'PDN' or
005900130118     C                             PLNCAT = 'PDE'
006000100209     C                   Eval      DTCAT = 'D'
006100110922     C                   When      PLNCAT = 'PVR' or
006200130725     C                             PLNCAT = 'PVS' or
006300130725     C                             PLNCAT = 'PCV'
006400100209     C                   Eval      DTCAT = 'V'
006500100209     C                   Other
006600100209     C                   Eval      DTCAT = ' '
006700100209     C                   Endsl
006800100209
006900100209     C                   Move      HKEY          DTSSN
007000100209     C                   Eval      DTSEQ = HDSEQ#
007100100209     C                   Eval      DTPLN = %trim(NOTE2)
007200100209     C                   Eval      DTFLG = 'A'
007300100209     C                   Movel     COVTDT        DTEFF
007400100209     C                   Eval      DTTRM  =  *Zeros
007500100209
007600100209     C     *Date         Mult      10000.0001    DTSNT
007700100209     C                   Write     DW311TR
007800100209
007900100209     C                   ENDSR
