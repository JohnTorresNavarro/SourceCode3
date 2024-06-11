000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300100902    ? *  Description:  KLEX11R  Determine if Active Kaiser Cov Exists  *
000400001003    ? *                                                                *
000500100902    ? *  (c)Copyright 2010 by GBS, Inc.                                *
000600051129    ? *  This document contains restricted materials of GBS,Inc.       *
000700001003    ? *                                                                *
000800051129    ? *  Written by:    S. Zien                                        *
000900100902    ? *  Date Written:   9/02/10                                       *
001000051207    ? *                                                                *
001100090730    ? *  Note:  "MAS " means Mid-Atlantic States                       *
001200090730    ? *                                                                *
001300051212    ? *  History:                                                      *
001400100902    ? *            Revised by -                                        *
001500100902    ? *            Date -                                              *
001600100902    ? *            Revision -                                          *
001700070821    ? *                                                                *
001800081017    ? *________________________________________________________________*    ____
002000100902     FMCOVC     IF   E           K Disk
002001100902     FDCOVC     IF   E           K Disk
002002100903     FPLNMSTN1  IF   E           K Disk
002800021004      *
002801100902     C                   Movel     SSN           KSSN
002802100902     C                   Movel     SEQ#          KSEQ#
002803100902     C                   Movel     TRST          KTRST
002804100902     C                   Movel     SUB#          KSUB#
002805110518     C****************** Movel     PLAN          KPLAN
002806100902     C                   Select
002807100902      * Member
002808100902     C                   When      SEQ# = *Zeros
004902100902     C                   Exsr      ProcessMbr
004903100902      * Dependent
004904100902     C                   When      SEQ# <> *Zeros
004905100902     C                   Exsr      ProcessDep
004906100902     C                   EndSl
004907100323      *
004910100323    ?C                   Move      *On           *InLR
004911100902     C                   Return
004912100323    ? *________________________________________________________________
004913100902    ?C     ProcessMbr    Begsr
004914100323      *
005500100902     C     CovKey        Setll     MCOVC
005800100902     C                   Dou       %Eof(MCOVC)
005801100902     C     CovKey        Reade     MCOVC
005900100902     C                   If        Not %Eof(MCOVC)
005901100902     C                   If        CANDT    =    *Zeros  OR
005902100902     C                             CANDT    >    Today
005904110518     C                   Movel     MCPLAN        KPLAN
005905100903     C     PlnKey        Chain     PLNMSTN1
005906100903     C                   If        %Found(PLNMSTN1)
005907100902     C                   Eval      ExportYN =    'N'
005908100902     C                   Leave
005909100903     C                   End
005910100902     C                   Else
005911100902     C                   Move      'Y'           ExportYN
005912100902     C                   End
005913100902     C                   Else
005914100902     C                   Move      'Y'           ExportYN
007300090805     C                   End
007500090805     C                   EndDo
007501100902    ? *
007502100902    ?C                   Endsr
007503100902    ? *________________________________________________________________
007504100902    ?C     ProcessDep    Begsr
007505100902      *
007506100902     C     CovKey        Setll     DCOVC
007507100902     C                   Dou       %Eof(DCOVC)
007508100902     C     CovKey        Reade     DCOVC
007509100902     C                   If        Not %Eof(DCOVC)
007510110518     C                   If        CCANDT   =    *Zeros  OR
007511110518     C                             CCANDT   >    Today
007512110518     C                   Movel     DVPLAN        KPLAN
007513110518     C     PlnKey        Chain     PLNMSTN1
007514110518     C                   If        %Found(PLNMSTN1)
007515100902     C                   Eval      ExportYN =    'N'
007516100902     C                   Leave
007517110518     C                   End
007518100902     C                   Else
007519100902     C                   Move      'Y'           ExportYN
007520100902     C                   End
007521100902     C                   Else
007522100902     C                   Move      'Y'           ExportYN
007523100902     C                   End
007524100902     C                   EndDo
007525100902    ? *
007526100902    ?C                   Endsr
062500051129    ? *________________________________________________________________
062600051129    ? * Key Lists
062700051129    ? *________________________________________________________________
062800051129    ?C     Klist         Begsr
063900090303    ? *
064000090729     C     CovKey        KLIST
064001100902     C                   Kfld                    KSSN              9 0
064002100902     C                   Kfld                    KSEQ#             2 0
064100100902     C                   Kfld                    KTRST             3 0
064200100902     C                   Kfld                    KSUB#             3 0
065700090303    ? *
065701100903     C     PlnKey        KLIST
065702100903     C                   Kfld                    CC
065704100903     C                   Kfld                    KTRST
065705100903     C                   Kfld                    KSUB#
065706100903     C                   Kfld                    KPLAN             4
065707100903    ? *
065800061121    ?C                   Endsr
065801100902    ? *___________________________________________________________________
065802100902    ? * Parameter list
065803100902    ? *___________________________________________________________________
065804100902    ?C     PLIST         Begsr
065805100902    ?C     *ENTRY        Plist
065806100902    ?C                   Parm                    SSN               9
065807100902     C                   Parm                    SEQ#              2
065808100902     C                   Parm                    TRST              3
065809100902     C                   Parm                    SUB#              3
065810100902     C                   Parm                    PLAN              4
065811100903     C                   Parm                    CC                3
065812100902    ?C                   Parm                    ExportYN          1
065813100902    ?C                   Endsr
065900020726    ? *________________________________________________________________
066000020726    ? * Initialization
066100020726    ? *________________________________________________________________
066200001003    ?C     *INZSR        Begsr
066400021007     C     *DATE         Mult      10000.0001    Today             8 0
066800001003    ?C                   Endsr
