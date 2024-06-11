000100130909     H bnddir('PLNSRVPGM') actgrp(*caller) dftactgrp(*no) option(*nodebugio)
000200130909     Hdebug
000300990630      *? ********************************************************************
000400020523      *
000500130523      *             GROUP BENIFIT SERVICES SOFTWARE           2013
000600060829      *
000700000118      *  Written by:    S. Zien
000800130523      *  Date Written:  5/23/13
000900130523      *  Description:   Determine whether age 19 should get a letter.
001000000118      *
001100000118      *
001200000118      *                R E V I S I O N    H I S T O R Y
001300000118      *  Date
001400000118      *  Revised   Initials    Revision
001500000118      *  --------  --------    ----------------------------------------------
001600130910      *  09/05/2013  DPB       Revise logic for 19/23/25 letter determination
001700130910      *                        - dependent must have vision or dental that
001800130910      *                        is NOT a CFS plan.
001900990630      *? *********************************************************************
002000130523     FDCOVC     IF   E           K Disk
002100130909     FPLNUNIQUE IF   E           K Disk
002200130910     Fcarmstl   IF   E           K Disk
002300130905
002400130909      /define copy_all_protos_and_fields
002500131008      /copy qcpysrc,plnsrvpgmp
002600130909      /undefine copy_all_protos_and_fields
002700130909
002800130523     D CF              S              2A   Inz('CF')
002900130524     D Error           S              1A   Inz('E')
003000130530     D Yes             S              1A   Inz('Y')
003100130530     D No              S              1A   Inz('N')
003200130909     D plan_type       s              1
003300130909
003400991230    ? * Program status data structure
003500130905    ?D               ESDS                  EXTNAME(IOPGMD)
003600010326
003700130909      *?Clear return parm...will be set based on below logic
003800130909     C                   clear                   writeletter
003900130909
004000130524     C                   Select
004100130905     C                   When      WAge = '19' Or WAge = '23' or WAge = '25'
004200130524     C                   Exsr      Nineteen2325
004300130905
004400130905     C                   When      WAge = '26' Or WAge = '65'
004500130524     C                   Exsr      TwentySix65
004600130905
004700130524     C                   Other
004800130905     C                   Eval      WriteLetter = Error
004900130905
005000130524     C                   EndSl
005100130524
005200130909     C                   callp     #pln_closesrv()
005300130524     C                   Eval      *InLR = *ON
005400130524     C                   Return
005500130905
005600130524    ? *___________________________________________________________________
005700130524     C     Nineteen2325  Begsr
005800130524    ? *___________________________________________________________________
005900130905
006000130523     C     DepKey        Setll     DCOVC
006100130529     C                   Dou       %Eof(DCOVC)
006200130905     C     DepKey        Reade     DCOVC
006300130523
006400130905     C                   If        %Eof(DCOVC)
006500130905     C                   leave
006600130905     C                   endif
006700130905
006800130905     C                   If        CCANDT = *Zeros or ccandt > today
006900130530
007000130910      *?Get plan info...we ONLY want (Dental or Vision) AND only if the plan
007100130910      *?is not Carefirst.
007200130909     C     PlnKey        Chain     plnunique
007300130909     C                   If        %Found(plnunique)
007400130909     C                   eval      plan_type = #get_plan_type(plncat)
007500130909     C                   if        plan_type = 'D' or plan_type = 'V'
007600130910     C     CarKey        Chain     carmstl
007700130910     C                   If        not %Found(carmstl)
007800130910     c                   eval      writeletter = yes
007900130910     C                   leave
008000130909     C                   endif
008100130909     C                   endif
008200130910     C                   endif
008300130905
008400130905     C                   Endif
008500130523
008600130523     C                   EndDo
008700130530
008800130910      *?If writeletter not yet set - return a No
008900130905     C                   if        writeletter = *blanks
009000130905     C                   Eval      WriteLetter = no
009100130905     C                   Endif
009200130905
009300130524    ?C                   Endsr
009400130524    ? *___________________________________________________________________
009500130524     C     TwentySix65   Begsr
009600130524    ? *___________________________________________________________________
009700130909
009800130524     C     DepKey        Setll     DCOVC
009900130524     C     DepKey        Reade     DCOVC
010000130524     C                   Dou       %Eof(DCOVC)
010100130524
010200130909     C                   If        CCANDT = *Zeros or ccandt > today
010300130909
010400130909     C     PlnKey        Chain     plnunique
010500130909     C                   If        %Found(plnunique)
010600130524     C                   If        PLNCAT = 'PMM'  Or
010700130524     C                             PLNCAT = 'PMS' Or
010800130524     C                             PLNCAT = 'PDN'  Or
010900130605     C                             PLNCAT = 'PVS'  Or
011000130605     C                             PLNCAT = 'PVR'
011100130524     C                   Eval      WriteLetter = 'Y'
011200130524     C                   Leave
011300130524     C                   End
011400130524
011500130909     C                   End
011600130529     C                   Else
011700130529     C                   Eval      WriteLetter = 'N'
011800130524     C                   End
011900130524
012000130524     C     DepKey        Reade     DCOVC
012100130524     C                   EndDo
012200130909
012300130524    ?C                   Endsr
012400130523    ? *___________________________________________________________________
012500130523    ? * Key lists
012600130523    ? *___________________________________________________________________
012700130523    ?C     Klist         Begsr                                                  KEY LISTS
012800130523
012900130523     C     DepKey        Klist
013000130523     C                   Kfld                    SSno
013100130523     C                   Kfld                    Seq#
013200130523
013300130523     C     PlnKey        Klist
013400130523     C                   Kfld                    TRUST
013500130523     C                   Kfld                    SUB
013600130523     C                   Kfld                    DVPLAN
013700130523
013800130523     C     CarKey        Klist
013900130523     C                   Kfld                    CF
014000130523     C                   Kfld                    PCARR
014100130523    ?C                   Endsr
014200130523
014300130523    ? *___________________________________________________________________
014400130523    ? * Parameter lists
014500130523    ? *___________________________________________________________________
014600130523    ?C     PLIST         Begsr
014700130523     C     *Entry        Plist
014800130524     C                   Parm                    WAge              2
014900130523     C                   Parm                    WSSno             9
015000130523     C                   Parm                    WSeq#             2
015100130523     C                   Parm                    WTrust            3
015200130523     C                   Parm                    WSub              3
015300130523     C                   Parm                    WriteLetter       1
015400130523    ?C                   Endsr
015500010412
015600130523      *---------------------------------------------------------------*
015700130523     C     *Inzsr        Begsr
015800130523      *---------------------------------------------------------------*
015900130523     C     *DATE         Mult      10000.0001    Today             8 0
016000130523     C                   Move      WSSno         SSno              9 0
016100130523     C                   Move      WSeq#         Seq#              2 0
016200130523     C                   Move      WTrust        TRUST             3 0
016300130523     C                   Move      WSub          SUB               3 0
016400130523     C                   Endsr
016500130523
016600010403     C/EJECT
