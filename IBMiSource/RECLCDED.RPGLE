000100060606     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200060525     H option(*SRCSTMT: *NODEBUGIO)
000300060525
000400000000      *_________________________________________________________________________
000500000000      *
000600101105      *  Description:  Recalculate the Payroll Deduction Amount
000700000000      *
000800101105      *  (c)Copyright 2010 by GBS, Inc.
000900000000      *
001000101105      *    Created by:  JALLEN - Nov 5, 2010
001100160120      *-------------------------------------------------------------------------
001200160120      * Modifications
001300160120      *
001400160120      * Date         Programmer    Mod      Description
001500160120      *-------------------------------------------------------------------------
001600160120      * 01/20/2016   B.Rees
001700160120      *   Set MCOV to be User Open (Was Causing Erros in PC2010R RPGPSDASH)
001800160120      *-------------------------------------------------------------------------
001900101105     Fwebpayded up   e           k disk
002000160120     Fmcov22    if   e           k disk    UsrOpn
002100060525
002200060525      * Prototypes
002300101105      /copy *libl/qmodsrc,#getdedpr
002400101105      /copy *libl/qmodsrc,#getclvlpr
002500101105      /copy *libl/qmodsrc,#chknhrpr
002600061122
002700101105     d pos             s              2s 0 inz
002800101105     d CovLevel        s             25a   inz
002900101105     d NewHire         s              1s 0 inz
003000101105     d wwcov           s             20a   inz
003100061122
003200101105     d Today           S               d   datfmt(*iso)
003300101105     d  wiso           s               d   datfmt(*iso)
003400101105     d w80date         s              8s 0 inz
003500101105     d wweff           s              8s 0 inz(*hival)
003600101105
003700101105     d payded        e ds                  extname(WEBPAYDS)
003800101105
003900101105      * If not transmitted
004000101112     C                   if        pqtdt = 0    and
004100101112     C                             pqstart > 0
004200061122
004300101105      * Check New Hire
004400160418     C                   eval      NewHire = #chknhr(pqtrs:pqsub:pqact:pqssn:'')
004500061128
004600160120     C                   open      mcov22
004700111129      * Get Plan Effective Date - skip on-demand time = 999999
004800111129     C                   Eval      w80date = *zeros
004900111129     C                   if        pqtim = 0
005000101105     C     covkeyHi      Setgt     mcov22
005100101105     C     covkeyEq      Readpe    mcov22
005200101105     C                   Dow       not %eof(mcov22)
005300101105     C                   Eval      w80date = enrldt
005400101105     C                   Leave
005500101105     C     covkeyEq      Readpe    mcov22
005600111129     C                   EndDo
005700111129     C                   End
005800160120     C                   close     mcov22
005900111129
006000111129      * Always zero out time - on-demand time = 999999
006100111129     C                   Eval      pqtim = 0
006200101105
006300101112      * reCalc using Start or Stop Date
006400101105      * Start
006500101105     C                   If        w80date = 0
006600101112
006700101112     C                   if        pqstart > 0
006800101112     C                   eval      w80date = pqstart
006900101112     C                   Else
007000101112     C                   eval      w80date = pqstop
007100101112     C                   End
007200101112
007300101105     C                   If        PQPCMT = 'P'
007400101112     C                   move      w80date       wiso
007500101105     C                   adddur    1:*M          wiso
007600101105     C     *iso          move      wiso          w80date
007700101105     C                   Else
007800101112     C                   move      w80date       wiso
007900101105     C     *iso          move      wiso          w80date
008000101105     C                   End
008100101105     C                   End
008200111214
008300111214      * If you want to hard code the rate date do it here, but let the start
008400111214      * start date entered into the On Demand flow through asthe start date.
008500120110     C************       eval      w80date = 20120101
008600061122
008700101105      * Get Coverage Level
008800101105     C                   Eval      CovLevel = #getclvl(pqtrs:pqsub:pqact:
008900101105     C                                        pqssn:pqpln:pqcat)
009000101105     C                   Eval      wwcov = %trim(CovLevel)
009100101105
009200101105      * Recalculate Deductions
009300101105     C                   Eval      PayDed = #getded(pqtrs:pqsub:pqact:
009400101105     C                                        pqssn:pqseq:pqpln:pqcat:
009500160418     C                                        wwcov:w80date:newhire:'')
009600101105
009700101105      * Update Deductions
009800101112     C                   Eval      pqdamt = dsdamt
009900101112     C                   Eval      pqpcmt = dspcmt
010000101112     C                   Eval      pqpdcd = dspdcd
010100101105     C                   Update    WEBPAYDDR
010200101105     C                   End
010300101105
010400061122      *--------------------------------------------------------------*
010500101105     C     *inzsr        Begsr
010600061122
010700101105     C     covkeyHi      Klist
010800101105     C                   Kfld                    pqtrs
010900101105     C                   Kfld                    pqsub
011000101105     C                   Kfld                    pqact
011100101105     C                   Kfld                    pqssn
011200101105     C                   Kfld                    pqpln
011300101105     C                   Kfld                    wweff
011400101105
011500101105     C     covkeyEq      Klist
011600101105     C                   Kfld                    pqtrs
011700101105     C                   Kfld                    pqsub
011800101105     C                   Kfld                    pqact
011900101105     C                   Kfld                    pqssn
012000101105     C                   Kfld                    pqpln
012100061122     C                   Endsr
