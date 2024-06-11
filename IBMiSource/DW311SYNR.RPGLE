000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Delegated Billing Electronic Enrollment
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - October 24, 2002
000800190801      *
000900190930      *    09.30.2019  ADD1
001000190912      *    delete 99 record if no plans 221787782
001100190930      *
001200190930      *    09.30.2019  ADD2
001300190930      *    do not delete 99 records if run from special file.
001400191209      *
001500191209      *    12.09.2019  CTSA
001600191209      *    ADD SYNCTSA SUBR
001700200617      *
001800200617      *    06.17.2020  DT99
001900200617      *    fix dep coverage date issue
002000200619      *
002100200619      *    06.19.2020  CL99
002200200715      *    Sync Classes - turn off class now comes from Sync Group
002300201102      *
002400201102      *    11.02.2020  GR99
002500201102      *    Sync SGR*
002600210223      *    02.23.2021 added CFS and Date logic
002700201210      *
002800201210      *    12.10.2020  DT99
002900201210      *    Sync Dates fix
003000211207      *
003100211207      *    12.07.2021
003200211209      *    Dependents now have there own SR - SYNCDEPGRP
003300211208      *
003400211209      *    12.09.2021
003500211209      *    Created SYNCDEPGRPTRM for dependent terms
003600220705      *
003700220705      *    07.05.2022
003800220705      *    Fixed group number logic - E002
003900230113      *
004000230113      *    01.13.2023
004100230117      *    Added missing dependent field updates D3SGR1,2,3,4  - D001
004200230117      *    Combine MED and RX - D002
004300190930      *
004400000000      *_________________________________________________________________________
004500021024      *
004600130905     FDBEDTL834 UP   E             DISK
004700130905     FDBEDTL834LIF   E           K DISK       RENAME(DBEDTLR:DBEDEP)
004800130905     F                                        PREFIX(D_)
004900190802     FDEPNDC    IF   E           k DISK       extfile('QS36F/F.DEPNDC')
005000211209     FDCOVC     IF   E           k DISK       extfile('QS36F/F.DCOVC')
005100220203     FDCOV1     IF   E           k DISK       extfile('QS36F/F.DCOV1')
005200211209     F                                        rename(DCOVR:R1R)
005300210223     FPLNMST    IF   E           k DISK       extfile('QS36F/F.PLNMST')
005400210223     FCARMST    IF   E           k DISK       extfile('QS36F/F.CARMST')
005500190802     FMCOV      IF   E           k DISK       extfile('QS36F/F.MCOV')
005600190802     FCODESL1   IF   E           k DISK       extfile('QS36F/F.CODESL1')
005700220705E002 F**AT24    IF   E           k DISK       extfile('QS36F/F.GRAT24')
005800220705E002 FGRAT26    IF   E           k DISK       extfile('QS36F/F.GRAT26')
005900191209     FACCMST    IF   E           k DISK       extfile('QS36F/F.ACCMST')
006000200625     FMEMBER    IF   E           k DISK       extfile('QS36F/F.MEMBER')
006100200625     FCLASS     IF   E           k DISK    extfile('QS36F/F.CLASS') prefix(C_)
006200090320      *
006300120821     D WTODAY          s             10a
006400131213     D W80ADDS         s              8s 0
006500131213     D W80ADD41        s              8s 0
006600131213     D W80ADD42        s              8s 0
006700131213     D W80ADD43        s              8s 0
006800131213     D W80ADD44        s              8s 0
006900130905     D W80DATE         s              8s 0
007000130905     D W81DATE         s              8s 0
007100210223     D W82DATE         s              8s 0
007200210223     D Today           s              8s 0
007300141212     D W8ADATE         s             10a
007400141212     D REINDAT         s             10a
007500131216     D W8XDATE         s              8a
007600191209     D LEN2            S              2S 0 INZ
007700210303     D M1              s              1a
007800210303     D R1              s              1a
007900210303     D D1              s              1a
008000210303     D V1              s              1a
008100211208
008200211223     D W1              s              2s 0
008300211223     D X1              s              2s 0
008400211223     D Y1              s              2s 0
008500211223     D Z1              s              2s 0
008600190528
008700190528     D                 DS
008800190528     D TSACHAR                       10
008900190528     D W_T                            3S 0 OVERLAY(TSACHAR) inz
009000190528     D W_S                            3S 0 OVERLAY(TSACHAR:4) inz
009100190528     D W_A                            4S 0 OVERLAY(TSACHAR:7) inz
009200191209     D                 DS
009300191209     D TSAC                          10
009400191209     D W_TC                           3S 0 OVERLAY(TSAC) inz
009500191209     D W_SC                           3S 0 OVERLAY(TSAC:4) inz
009600191209     D W_AC                           4S 0 OVERLAY(TSAC:7) inz
009700030513
009800121126     IDBEDTLR       01
009900121126
010000140605     C   01              Exsr      cleanRX
010100191209     C   01              Exsr      SyncTSA
010200190912     C   01              Exsr      Syncgroups
010300220714     C   01              Exsr      SyncgroupsTRM
010400211208     C   01              Exsr      SyncDEPgrp
010500211208     C   01              Exsr      SyncDEPgrpTRM
010600200715CL99 C***01              Exsr      SyncClass
010700140527     C   01              Exsr      Syncplans
010800140520     C   01              Exsr      SyncACA
010900141212     C   01              Exsr      SyncRXterms
011000141212     C   01              Exsr      SyncTerms
011100141212     C   01              Exsr      SyncReins
011200140402     C***01              Exsr      SyncMRX
011300130905     C   01              Exsr      SyncDates
011400140214     C   01              Exsr      SyncDEPadd
011500140528     C   01              Exsr      SyncDemonly
011600190930
011700190930ADD2 C   01              if        spcflg = 'Y'
011800190930     C   01              Update    DBEDTLR
011900190930ADD2 C                   else
012000190930ADD1 C   01              If        D3SFX = '99'     and
012100190912     C                             D3GRP1 = *blanks and
012200190912     C                             D3GRP2 = *blanks and
012300190912     C                             D3GRP3 = *blanks and
012400190912     C                             D3GRP4 = *blanks
012500190930ADD1 C   01              delete    DBEDTLR
012600190930ADD2 C                   else
012700190930     C   01              Update    DBEDTLR
012800190930ADD2 C                   end
012900190930ADD2 C                   end
013000140605      *___________________________________________________________________
013100140605      * Clean RX - somewhere the RX indicator isn't being cleared
013200140605      *___________________________________________________________________
013300140605     C     CleanRX       BEGSR
013400140605
013500140605      /free
013600140605
013700140618       if %trim(D3SCEF2) = *blanks and %trim(D3SCAT2) = 'R' ;
013800140605
013900140605          D3SCAT2 = *blanks  ;
014000140605
014100140605       endif ;
014200200205
014300200205       if %trim(D3SCEF1) <> *blanks and %trim(D3SCAT1) = ' ' and D3FIL41 <> ' ';
014400200205
014500200205          D3SCAT1 = 'M'  ;
014600200205          D3FIL41 = 'SL'  ;
014700200205
014800200205       if %trim(D3SCEF2) = *blanks and %trim(D3SCAT2) = ' ' ;
014900200205
015000200205          D3SCAT2 = 'R'  ;
015100200205          D3FIL42 = 'SL'  ;
015200200205          D3SCEF2 = D3SCEF1  ;
015300200205          D3SEVT2 = D3SEVT1  ;
015400200205          D3SFAM2 = D3SFAM1  ;
015500200205
015600200205       endif ;
015700200205       endif ;
015800200205
015900140605
016000140605      /end-free
016100140605
016200191209     C                   Endsr
016300191209      *___________________________________________________________________
016400191209      * Sync TSA
016500191209      *___________________________________________________________________
016600191209     C     SyncTSA       Begsr
016700191209     C                   move      D3SUB         MCSSNO
016800191209     C     MCSSNO        chain     MEMBER
016900191209     C                   if        %found(MEMBER)
017000191209     C                   Eval      W_TC =  MBTRST
017100191209     C                   Eval      W_SC =  MBSUB#
017200191209     C                   Eval      W_AC =  MBACCT
017300191209     C                   Eval      D3TSA = TSAC
017400191209      * Account Name + TSA
017500191209     C                   Eval      D3TSA = TSAC
017600191209     C                   eval      tsachar = d3tsa
017700191209     C     WkAct         Chain     ACCMST
017800191209     C                   If        %Found(ACCMST)
017900191209     C                   Eval      D3TSANM = %trim(ACNAM1)
018000191209     C                   Eval      D3ADR3   =    *BLANKS
018100191209     C                   If        ACNAM2 <> *blanks
018200191209     C                   Eval      LEN2 = %LEN(ACNAM2)
018300191209     C                   If        LEN2 > 3
018400191209     C                   Select
018500191209     C                   When      %subst(ACNAM2:1:3) = 'C/O'
018600191209     C                   Eval      D3ADR3   =    *BLANKS
018700191209     C                   When      %subst(ACNAM2:1:3) = 'T/A'
018800191209     C                   Eval      D3ADR3   =    *BLANKS
018900191209     C                   When      %subst(ACNAM2:1:3) = 'DBA'
019000191209     C                   Eval      D3ADR3   =    *BLANKS
019100191209     C                   Other
019200191209      * What the heck was this for???
019300191209     C***********        Eval      D3ADR3   =    %trim(ACNAM2)
019400191209     C                   Endsl
019500191209     C                   End
019600191209     C                   End
019700191209     C                   Else
019800191209     C                   Eval      D3TSANM = *BLANKS
019900191209     C                   Eval      D3ADR3   =    *BLANKS
020000191209     C                   End
020100191209     C                   end
020200140605     C                   Endsr
020300141211      *___________________________________________________________________
020400141211      * Sync Class - they should be the same
020500141211      *___________________________________________________________________
020600200619CL99 C     SyncClass     Begsr
020700141211
020800141211     C                   If        D3CLS <> *blanks
020900141211
021000141211     C                   If        D3CLS1 <> D3CLS    AND
021100141211     C                             D3CLS1 <> *BLANKS
021200141211     C                   eval      D3CLS1 = D3CLS
021300141211     C                   eval      D3CLSE1 = D3CLSE
021400141211     C                   end
021500141211
021600141211     C                   If        D3CLS2 <> D3CLS    AND
021700141211     C                             D3CLS2 <> *BLANKS
021800141211     C                   eval      D3CLS2 = D3CLS
021900141211     C                   eval      D3CLSE2 = D3CLSE
022000141211     C                   end
022100141211
022200141211     C                   If        D3CLS3 <> D3CLS    AND
022300141211     C                             D3CLS3 <> *BLANKS
022400141211     C                   eval      D3CLS3 = D3CLS
022500141211     C                   eval      D3CLSE3 = D3CLSE
022600141211     C                   end
022700141211
022800141211     C                   If        D3CLS4 <> D3CLS    AND
022900141211     C                             D3CLS4 <> *BLANKS
023000141211     C                   eval      D3CLS4 = D3CLS
023100141211     C                   eval      D3CLSE4 = D3CLSE
023200141211     C                   end
023300141211
023400141211     C                   If        D3CLS5 <> D3CLS    AND
023500141211     C                             D3CLS5 <> *BLANKS
023600141211     C                   eval      D3CLS5 = D3CLS
023700141211     C                   eval      D3CLSE5 = D3CLSE
023800141211     C                   end
023900141211
024000141211     C                   If        D3CLS6 <> D3CLS    AND
024100141211     C                             D3CLS6 <> *BLANKS
024200141211     C                   eval      D3CLS6 = D3CLS
024300141211     C                   eval      D3CLSE6 = D3CLSE
024400141211     C                   end
024500141211
024600141211     C                   If        D3CLS7 <> D3CLS    AND
024700141211     C                             D3CLS7 <> *BLANKS
024800141211     C                   eval      D3CLS7 = D3CLS
024900141211     C                   eval      D3CLSE7 = D3CLSE
025000141211     C                   end
025100141211
025200141211     C                   If        D3CLS8 <> D3CLS    AND
025300141211     C                             D3CLS8 <> *BLANKS
025400141211     C                   eval      D3CLS8 = D3CLS
025500141211     C                   eval      D3CLSE8 = D3CLSE
025600141211     C                   end
025700141211
025800141211     C                   end
025900141211
026000141211     C                   Endsr
026100140626      *___________________________________________________________________
026200140626      * Sync groups - they should be the same
026300140626      *___________________________________________________________________
026400140626     C     Syncgroups    BEGSR
026500211207      *  Dependents now have there on SR
026600190801     C                   If        D3SFX = '99'
026700211207     C                   leaveSR
026800190801     C                   end
026900210303
027000210303     C                   eval      M1 = *blanks
027100210303     C                   eval      R1 = *blanks
027200210303     C                   eval      D1 = *blanks
027300210303     C                   eval      V1 = *blanks
027400190416
027500190416     C     MEMKEY        Klist
027600190416     C                   Kfld                    MCTRST
027700190416     C                   Kfld                    MCSUB#
027800190416     C                   Kfld                    MCPLAN
027900190416
028000190416     C                   move      D3SUB         MCSSNO
028100190416     C     MCSSNO        Setgt     MCOV
028200190416     C     MCSSNO        Readpe    MCOV
028300190416     C                   Dow       not %eof(MCOV)
028400210223GR99 C                   If        CANDT = 0  or
028500210223GR99 C                             Today >= ENRLDT and
028600210223GR99 C                             Today <= CANDT
028700190416     C     MEMKEY        Chain     PLNMST
028800190621     C                   If        %found(PLNMST) and
028900191230     C                             %trim(PLNCAT) <> 'PCM' and
029000191230     C                             %trim(PLNCAT) <> 'PHH'
029100210223GR99  * Carefirst only
029200210223GR99 C     PCARR         Chain     CARMST
029300210223GR99 C                   If        %found(CARMST) and
029400210223GR99 C                             CGRPCD = 'CF'
029500210223
029600190416     C     PLNCAT        Chain     CODESL1
029700190416     C                   If        %found(CODESL1)
029800190416     C                   select
029900190416     C                   when      action = 'M' and
030000210218     C                             D3CLS1 <> *blanks and
030100190722     C                             D3FIL41 <> 'T'
030200210303     C                   if        M1 = *blanks
030300200625     C                   exsr      getgroup
030400190416     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
030500190416     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
030600190416     C                   Eval      D3GRP1   =    %trim(%subst(GROUP#:1:8))
030700201102GR99 C                   Eval      D3SGR1   =    %trim(%subst(GROUP#:9:4))
030800200625     C                   exsr      getclass
030900210303     C                   eval      M1 = 'Y'
031000210303     C                   end
031100190416     C                   when      action = 'R' and
031200210218     C                             D3CLS2 <> *blanks and
031300190722     C                             D3FIL42 <> 'T'
031400210303     C                   if        R1 = *blanks
031500190416     C                   exsr      getgroup
031600190416     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
031700190416     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
031800190416     C                   Eval      D3GRP2   =    %trim(%subst(GROUP#:1:8))
031900201102GR99 C                   Eval      D3SGR2   =    %trim(%subst(GROUP#:9:4))
032000200625     C                   exsr      getclass
032100210303     C                   eval      R1 = 'Y'
032200210303     C                   end
032300190416     C                   when      action = 'D' and
032400210218     C                             D3CLS3 <> *blanks and
032500190722     C                             D3FIL43 <> 'T'
032600210303     C                   if        D1 = *blanks
032700190416     C                   exsr      getgroup
032800190416     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
032900190416     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
033000190416     C                   Eval      D3GRP3   =    %trim(%subst(GROUP#:1:8))
033100201102GR99 C                   Eval      D3SGR3   =    %trim(%subst(GROUP#:9:4))
033200200625     C                   exsr      getclass
033300210303     C                   eval      D1 = 'Y'
033400210303     C                   end
033500190416     C                   when      action = 'V' and
033600210218     C                             D3CLS4 <> *blanks and
033700190722     C                             D3FIL44 <> 'T'
033800210303     C                   if        V1 = *blanks
033900190416     C                   exsr      getgroup
034000190416     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
034100190416     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
034200190416     C                   Eval      D3GRP4   =    %trim(%subst(GROUP#:1:8))
034300201102GR99 C                   Eval      D3SGR4   =    %trim(%subst(GROUP#:9:4))
034400200625     C                   exsr      getclass
034500210303     C                   eval      V1 = 'Y'
034600210303     C                   end
034700190416     C                   endsl
034800210223     C                   end
034900190416     C                   end
035000190416     C                   end
035100190416     C                   end
035200190416     C     MCSSNO        Readpe    MCOV
035300190416     C                   Enddo
035400140626     C                   Endsr
035500220714      *___________________________________________________________________
035600220714      * Sync groups - Terms
035700220714      *___________________________________________________________________
035800220714     C     SyncgroupsTRM BEGSR
035900220714      *  Dependents now have there on SR
036000220714     C                   If        D3SFX = '99'
036100220714     C                   leaveSR
036200220714     C                   end
036300220714
036400220714     C                   eval      M1 = *blanks
036500220714     C                   eval      R1 = *blanks
036600220714     C                   eval      D1 = *blanks
036700220714     C                   eval      V1 = *blanks
036800220714
036900220714     C                   move      D3SUB         MCSSNO
037000230113     C     MCSSNO        Setgt     MCOV
037100230113     C     MCSSNO        Readpe    MCOV
037200220714     C                   Dow       not %eof(MCOV)
037300220714GR99 C                   If        CANDT <> 0
037400220714     C     MEMKEY        Chain     PLNMST
037500220714     C                   If        %found(PLNMST) and
037600220714     C                             %trim(PLNCAT) <> 'PCM' and
037700220714     C                             %trim(PLNCAT) <> 'PHH'
037800220714GR99  * Carefirst only
037900220714GR99 C     PCARR         Chain     CARMST
038000220714GR99 C                   If        %found(CARMST) and
038100220714GR99 C                             CGRPCD = 'CF'
038200220714
038300220714     C     PLNCAT        Chain     CODESL1
038400220714     C                   If        %found(CODESL1)
038500220714     C                   select
038600220714     C                   when      action = 'M' and
038700220714     C                             D3CLS1 <> *blanks and
038800220714     C                             D3FIL41 = 'T'
038900220714     C                   if        M1 = *blanks
039000220714     C                   exsr      getgroup
039100220714     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
039200220714     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
039300220714     C                   Eval      D3GRP1   =    %trim(%subst(GROUP#:1:8))
039400230113     C                   Eval      D3SGR1   =    %trim(%subst(GROUP#:9:4))
039500230117D002 C                   if        D3CLS2 <> *blanks and
039600230117 |   C                             D3FIL42 = 'T'
039700230117 |   C                   Eval      D3GRP2   =    %trim(%subst(GROUP#:1:8))
039800230117 |   C                   Eval      D3SGR2   =    %trim(%subst(GROUP#:9:4))
039900230117D002 C                   eval      R1 = 'Y'
040000230117     C                   end
040100220714     C                   exsr      getclass
040200220714     C                   eval      M1 = 'Y'
040300220714     C                   end
040400220714     C                   when      action = 'R' and
040500220714     C                             D3CLS2 <> *blanks and
040600220714     C                             D3FIL42 = 'T'
040700220714     C                   if        R1 = *blanks
040800220714     C                   exsr      getgroup
040900220714     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
041000220714     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
041100220714     C                   Eval      D3GRP2   =    %trim(%subst(GROUP#:1:8))
041200220714GR99 C                   Eval      D3SGR2   =    %trim(%subst(GROUP#:9:4))
041300220714     C                   exsr      getclass
041400220714     C                   eval      R1 = 'Y'
041500220714     C                   end
041600220714     C                   when      action = 'D' and
041700220714     C                             D3CLS3 <> *blanks and
041800220714     C                             D3FIL43 = 'T'
041900220714     C                   if        D1 = *blanks
042000220714     C                   exsr      getgroup
042100220714     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
042200220714     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
042300220714     C                   Eval      D3GRP3   =    %trim(%subst(GROUP#:1:8))
042400220714GR99 C                   Eval      D3SGR3   =    %trim(%subst(GROUP#:9:4))
042500220714     C                   exsr      getclass
042600220714     C                   eval      D1 = 'Y'
042700220714     C                   end
042800220714     C                   when      action = 'V' and
042900220714     C                             D3CLS4 <> *blanks and
043000220714     C                             D3FIL44 = 'T'
043100220714     C                   if        V1 = *blanks
043200220714     C                   exsr      getgroup
043300220714     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
043400220714     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
043500220714     C                   Eval      D3GRP4   =    %trim(%subst(GROUP#:1:8))
043600220714GR99 C                   Eval      D3SGR4   =    %trim(%subst(GROUP#:9:4))
043700220714     C                   exsr      getclass
043800220714     C                   eval      V1 = 'Y'
043900220714     C                   end
044000220714     C                   endsl
044100220714     C                   end
044200220714     C                   end
044300220714     C                   end
044400220714     C                   end
044500230113     C     MCSSNO        Readpe    MCOV
044600220714     C                   Enddo
044700220714     C                   Endsr
044800200625      *___________________________________________________________________
044900200625      * Get class record
045000200625      *___________________________________________________________________
045100200625     C     GetClass      BEGSR
045200200625     C                   Eval      D3CLS    =    *BLANKS
045300200625     C                   Eval      WWOVTP   =    'TNA'
045400200625     C     ClassKey      Chain     CLASS
045500200625     C                   If        %Found
045600200625     C                   Eval      D3CLS    =    C_CLCLASS
045700200625      *
045800200625     C                   If        D3CLSE        = *BLANKS
045900200625     C                   Movel     ENRLDT        Input_Date
046000200625     C                   Eval      Input_Format  = 'YYYYMMDD'
046100200625     C                   Eval      Output_Format = 'MM/DD/YYYY'
046200200625     C                   Exsr      FormatDateSR
046300200625     C                   Eval      D3CLSE        = %trim(Output_Date)
046400200625     C                   End
046500200625     C                   End
046600200715      *
046700200715CL99 C                   select
046800200715CL99 C                   when      action = 'M'
046900200715CL99 C                   eval      d3cls1 = D3CLS
047000200715CL99 C                   eval      d3clse1 = D3CLSE
047100210303CL99 C                   eval      d3cls2 = D3CLS
047200210303CL99 C                   eval      d3clse2 = D3CLSE
047300200715CL99 C                   when      action = 'R'
047400200715CL99 C                   eval      d3cls2 = D3CLS
047500200715CL99 C                   eval      d3clse2 = D3CLSE
047600200715CL99 C                   when      action = 'D'
047700200715CL99 C                   eval      d3cls3 = D3CLS
047800200715CL99 C                   eval      d3clse3 = D3CLSE
047900200715CL99 C                   when      action = 'V'
048000200715CL99 C                   eval      d3cls4 = D3CLS
048100200715CL99 C                   eval      d3clse4 = D3CLSE
048200200715CL99 C                   endsl
048300200625      *
048400200625     C     ClassKey      KLIST
048500200625     C                   KFLD                    MCTRST
048600200625     C                   KFLD                    MCSUB#
048700200625     C                   KFLD                    MCPLAN
048800200625     C                   KFLD                    WWOVTP            3
048900200625      *
049000200625     C                   ENDSR
049100200625      *___________________________________________________________________
049200200625      * Get class record
049300200625      *___________________________________________________________________
049400200625     C     GetClassDep   BEGSR
049500200625     C                   Eval      D3CLS    =    *BLANKS
049600200625     C                   Eval      WWOVTP   =    'TNA'
049700200625     C     ClassKeyD     Chain     CLASS
049800200625     C                   If        %Found
049900200625     C                   Eval      D3CLS    =    C_CLCLASS
050000200625      *
050100200625     C                   If        D3CLSE        = *BLANKS
050200200625     C                   Movel     DENRDT        Input_Date
050300200625     C                   Eval      Input_Format  = 'YYYYMMDD'
050400200625     C                   Eval      Output_Format = 'MM/DD/YYYY'
050500200625     C                   Exsr      FormatDateSR
050600200625     C                   Eval      D3CLSE        = %trim(Output_Date)
050700200625     C                   End
050800200625     C                   End
050900200625      *
051000200625     C     ClassKeyD     KLIST
051100200625     C                   KFLD                    DVTRST
051200200625     C                   KFLD                    DVSUB#
051300200625     C                   KFLD                    DVPLAN
051400200625     C                   KFLD                    WWOVTP            3
051500200625      *
051600200625     C                   ENDSR
051700190416      *___________________________________________________________________
051800190416      * get group
051900190416      *___________________________________________________________________
052000190416     C     getgroup      BEGSR
052100220705      *
052200220705E002 C     MCVKEY        Klist
052300220705 |   C                   Kfld                    MCTRST
052400220705 |   C                   Kfld                    MCSUB#
052500220705 |   C                   Kfld                    MCPLAN
052600220705 |   C                   Kfld                    MCOVTP
052700220705 |   C     MCVKey        chain     GRAT26
052800220705 |   C                   if        %found(GRAT26)
052900220705 |   C                   LeaveSR
053000220705E002 C                   end
053100190416      *
053200190416      * Get Plan Group
053300190416     C                   Eval      Group# = *blanks
053400220705E002 C     MEMKey        Setll     GRAT26
053500220705E002 C     MEMKey        Reade     GRAT26
053600220705     C                   Dow       not %eof(GRAT26)
053700190416      * GBS Date Logic
053800190416     C                   If        frmdat <> todat
053900190416      *
054000190416     C                   if        ENRLDT >= frmdat and
054100190416     C                             ENRLDT <= todat
054200190416      *
054300190416     C                   LeaveSR
054400190416      *
054500190416     C                   end
054600190416     C                   end
054700220705E002 C     MEMKey        Reade     GRAT26
054800190416     C                   Enddo
054900190416
055000190416     C                   Endsr
055100140214      *___________________________________________________________________
055200140527      * Sync Plans - Make sure blanks when no plan
055300140214      *___________________________________________________________________
055400140527     C     Syncplans     BEGSR
055500140214
055600140214      /free
055700140214
055800140527       if %trim(D3SCEF1) = *blanks ;
055900140527
056000140527          D3SCAT1 = *blanks  ;
056100140527          D3SCEF1 = *blanks  ;
056200140527          D3SEVT1 = *blanks  ;
056300140527          D3FIL41 = *blanks  ;
056400140527          D3SFAM1 = *blanks  ;
056500140226
056600140527          D3SCTR1 = *blanks  ;
056700140527          D3SLVL1 = *blanks  ;
056800140527          D3GRP1 = *blanks ;
056900140527          D3SGR1 = *blanks ;
057000140527          D3CLS1 = *blanks ;
057100140527          D3CLSE1 = *blanks  ;
057200140527
057300140527       endif ;
057400140527
057500140527       if %trim(D3SCEF2) = *blanks ;
057600140527
057700140527          D3SCAT2 = *blanks  ;
057800140527          D3SCEF2 = *blanks  ;
057900140527          D3SEVT2 = *blanks  ;
058000140527          D3FIL42 = *blanks  ;
058100140527          D3SFAM2 = *blanks  ;
058200140527
058300140527          D3SCTR2 = *blanks  ;
058400140527          D3SLVL2 = *blanks  ;
058500140527          D3GRP2 = *blanks ;
058600140527          D3SGR2 = *blanks ;
058700140527          D3CLS2 = *blanks ;
058800140527          D3CLSE2 = *blanks  ;
058900140527
059000140527       endif ;
059100140214
059200140527       if %trim(D3SCEF3) = *blanks ;
059300140527
059400140527          D3SCAT3 = *blanks  ;
059500140527          D3SCEF3 = *blanks  ;
059600140527          D3SEVT3 = *blanks  ;
059700140527          D3FIL43 = *blanks  ;
059800140527          D3SFAM3 = *blanks  ;
059900140527
060000140527          D3SCTR3 = *blanks  ;
060100140527          D3SLVL3 = *blanks  ;
060200140527          D3GRP3 = *blanks ;
060300140527          D3SGR3 = *blanks ;
060400140527          D3CLS3 = *blanks ;
060500140527          D3CLSE3 = *blanks  ;
060600140527
060700140527       endif ;
060800140527
060900140527       if %trim(D3SCEF4) = *blanks ;
061000140527
061100140527          D3SCAT4 = *blanks  ;
061200140527          D3SCEF4 = *blanks  ;
061300140527          D3SEVT4 = *blanks  ;
061400140527          D3FIL44 = *blanks  ;
061500140527          D3SFAM4 = *blanks  ;
061600140527
061700140527          D3SCTR4 = *blanks  ;
061800140527          D3SLVL4 = *blanks  ;
061900140527          D3GRP4 = *blanks ;
062000140527          D3SGR4 = *blanks ;
062100140527          D3CLS4 = *blanks ;
062200140527          D3CLSE4 = *blanks  ;
062300140527
062400140527       endif ;
062500140527
062600140214      /end-free
062700140214
062800140214     C                   ENDSR
062900140527      *___________________________________________________________________
063000140527      * Sync ACA Plans - Make sure RX is filled for ACA
063100140527      *___________________________________________________________________
063200140527     C     SyncACA       BEGSR
063300140527
063400140527      /free
063500140527
063600140527       if %trim(D3PRN) = 'Y' ;
063700140527
063800140703          if %trim(D3SCEF1) <> *blanks ;
063900140527          D3SCAT2 = 'R'      ;
064000140527          D3SCEF2 = D3SCEF1  ;
064100140527          D3SEVT2 = D3SEVT1  ;
064200140527          D3FIL42 = D3FIL41  ;
064300140527          D3SFAM2 = D3SFAM1  ;
064400140527
064500140527          D3SCTR2 = D3SCTR1  ;
064600140527          D3SLVL2 = D3SLVL1  ;
064700140527          D3GRP2 = D3GRP1  ;
064800140527          D3SGR2 = D3SGR1  ;
064900140527          D3CLS2 = D3CLS1  ;
065000140527          D3CLSE2 = D3CLSE1  ;
065100140527
065200140703          endif ;
065300140527       endif ;
065400140527
065500140527          D3PRN = *blanks ;
065600140527
065700140527      /end-free
065800140527
065900140527     C                   ENDSR
066000141212      *___________________________________________________________________
066100141212      * Sync Term Flags
066200141212      *___________________________________________________________________
066300141212     C     SyncTerms     BEGSR
066400141212
066500141212     C                   If        D3SEVT1 =  'TM' and
066600141212     C                             D3FIL41 =  'N'
066700141212     C                   eval      D3FIL41 = 'T'
066800141212     C                   end
066900141212
067000141212     C                   If        D3SEVT2 = 'TM' and
067100141212     C                             D3FIL42 =  'N'
067200141212     C                   eval      D3FIL42 = 'T'
067300141212     C                   end
067400141212
067500141212     C                   If        D3SEVT3 = 'TM' and
067600141212     C                             D3FIL43 =  'N'
067700141212     C                   eval      D3FIL43 = 'T'
067800141212     C                   end
067900141212
068000141212     C                   If        D3SEVT4 = 'TM' and
068100141212     C                             D3FIL44 =  'N'
068200141212     C                   eval      D3FIL44 = 'T'
068300141212     C                   end
068400141212
068500141212     C                   ENDSR
068600140520      *___________________________________________________________________
068700140520      * Sync Plans - Make sure RX is filled for MED
068800140520      *___________________________________________________________________
068900140520     C     SyncRXterms   BEGSR
069000140617
069100140617      * this account RX is not with CFS
069200141210     C** no longer       If        D3TSA = '5900070010'
069300141210     C**  per cindie     LeaveSR
069400141210     C**                 End
069500140520
069600140520      /free
069700140520
069800140520       if   D3FIL41 = 'T'  and D3SCEF1 <> ' ' and D3SCEF2 = ' ' ;
069900140520
070000140520          D3SCAT2 = 'R'      ;
070100140520          D3SCEF2 = D3SCEF1  ;
070200140520          D3SEVT2 = D3SEVT1  ;
070300140520          D3FIL42 = D3FIL41  ;
070400140520          D3SFAM2 = D3SFAM1  ;
070500140520
070600140520          D3SCTR2 = D3SCTR1  ;
070700140520          D3SLVL2 = D3SLVL1  ;
070800140520          D3GRP2 = D3GRP1  ;
070900140520          D3SGR2 = D3SGR1  ;
071000140520          D3CLS2 = D3CLS1  ;
071100140520          D3CLSE2 = D3CLSE1  ;
071200140520
071300140520       endif ;
071400141210
071500141210       if   D3FIL42 = 'T'  and D3SCEF2 <> ' ' and D3SCEF1 = ' ' ;
071600141210
071700141210          D3SCAT1 = 'M'      ;
071800141210          D3SCEF1 = D3SCEF2  ;
071900141210          D3SEVT1 = D3SEVT2  ;
072000141210          D3FIL41 = D3FIL42  ;
072100141210          D3SFAM1 = D3SFAM2  ;
072200141210
072300141210          D3SCTR1 = D3SCTR2  ;
072400141210          D3SLVL1 = D3SLVL2  ;
072500141210          D3GRP1 = D3GRP2  ;
072600141210          D3SGR1 = D3SGR2  ;
072700141210          D3CLS1 = D3CLS2  ;
072800141210          D3CLSE1 = D3CLSE2  ;
072900141210
073000141210       endif ;
073100140520
073200140520      /end-free
073300140520
073400140520     C                   ENDSR
073500141212      *___________________________________________________________________
073600141212      * Sync Reinstate Flags
073700141212      *___________________________________________________________________
073800141212     C     SyncReins     BEGSR
073900141212
074000141212     C                   If        D3MNTYP =  'R'
074100141212
074200141212     C                   If        D3SEVT1 =  'TM' and
074300141212     C                             D3FIL41 =  'R'
074400141212     C                   eval      D3SEVT1 = 'SL'
074500141212     C                   eval      D3FIL41 = 'R'
074600141212     C                   exsr      GetActiveSR
074700141212     C                   If        REINDAT <> *blanks
074800141212     C                   eval      D3SCEF1 = REINDAT
074900141212     C                   end
075000141212     C                   end
075100141212
075200141212     C                   If        D3SEVT2 =  'TM' and
075300141212     C                             D3FIL42 =  'R'
075400141212     C                   eval      D3SEVT2 = 'SL'
075500141212     C                   eval      D3FIL42 = 'R'
075600141212     C                   exsr      GetActiveSR
075700141212     C                   If        REINDAT <> *blanks
075800141212     C                   eval      D3SCEF2 = REINDAT
075900141212     C                   end
076000141212     C                   end
076100141212
076200141212     C                   If        D3SEVT3 =  'TM' and
076300141212     C                             D3FIL43 =  'R'
076400141212     C                   eval      D3SEVT3 = 'SL'
076500141212     C                   eval      D3FIL43 = 'R'
076600141212     C                   exsr      GetActiveSR
076700141212     C                   If        REINDAT <> *blanks
076800141212     C                   eval      D3SCEF3 = REINDAT
076900141212     C                   end
077000141212     C                   end
077100141212
077200141212     C                   If        D3SEVT4 =  'TM' and
077300141212     C                             D3FIL44 =  'R'
077400141212     C                   eval      D3SEVT4 = 'SL'
077500141212     C                   eval      D3FIL44 = 'R'
077600141212     C                   exsr      GetActiveSR
077700141212     C                   If        REINDAT <> *blanks
077800141212     C                   eval      D3SCEF4 = REINDAT
077900141212     C                   end
078000141212     C                   end
078100141212
078200141212     C                   end
078300141212
078400141212     C                   ENDSR
078500140214      *___________________________________________________________________
078600140214      * Sync MED/RX Plans - They should always be the same  RX=MED
078700140214      *___________________________________________________________________
078800140214     C     SyncMRX       BEGSR
078900140214
079000140214      /free
079100140214
079200140703        If  D3SCAT1 = 'M' and D3SCEF1 <> ' ' ;
079300140214          D3SCAT2 = 'R'      ;
079400140214          D3SCEF2 = D3SCEF1  ;
079500140214          D3SEVT2 = D3SEVT1  ;
079600140214          D3FIL42 = D3FIL41  ;
079700140214          D3SFAM2 = D3SFAM1  ;
079800140227
079900140227          D3SCTR2 = D3SCTR1  ;
080000140227          D3SLVL2 = D3SLVL1  ;
080100140227          D3GRP2 = D3GRP1  ;
080200140227          D3SGR2 = D3SGR1  ;
080300140227          D3CLS2 = D3CLS1  ;
080400140227          D3CLSE2 = D3CLSE1  ;
080500140214        endif ;
080600140214
080700140214      /end-free
080800140214     C                   ENDSR
080900140214      *___________________________________________________________________
081000140214      * Sync DEP Adds
081100140214      *___________________________________________________________________
081200140214     C     SyncDEPadd    BEGSR
081300140214
081400140214     C                   If        D3SFX = '99'   and
081500140214     C                             D3MNTYP = 'A'
081600140214
081700140214     C                   move      D3SUB         DSSNO
081800140214     C     DSSNO         Setgt     DEPNDC
081900140214     C     DSSNO         Readpe    DEPNDC
082000140214     C                   Dow       not %eof(DEPNDC)
082100140214
082200140214      * Find DEP SEQ
082300140214     C                   If        %trim(DLNAME) = %trim(D3LST) and
082400140214     C                             %trim(DFNAME) = %trim(D3FST) and
082500140214     C                             %trim(DMI)    = %trim(D3MID)
082600140214
082700140214      * Find active coverages
082800140214     C     DPNKEY        Setgt     DCOVC
082900140214     C     DPNKEY        Readpe    DCOVC
083000140214     C                   Dow       not %eof(DCOVC)
083100140214
083200140214     C                   If        CCANDT = 0
083300140214     C     PLNKEY        Chain     PLNMST
083400140214     C                   If        %found(PLNMST)
083500220203
083600220203GR99  * Carefirst only
083700220203GR99 C     PCARR         Chain     CARMST
083800220203GR99 C                   If        %found(CARMST) and
083900220203GR99 C                             CGRPCD = 'CF'
084000140214
084100140214      * Sync effective dates
084200140214     C                   Select
084300140214     C                   When      PLNCAT = 'PMM' or
084400140214     C                             PLNCAT = 'PMC'
084500140214     C                   If        D3SCEF1 <> *blanks
084600140214     C                   Movel     DENRDT        Input_Date
084700140214     C                   Eval      Input_Format = 'YYYYMMDD'
084800140214     C                   Eval      Output_Format  = 'MM/DD/YYYY'
084900140214     C                   Exsr      FormatDateSR
085000140214     C                   Eval      D3SCEF1 = %trim(Output_Date)
085100140214     C                   If        D3SCEF2 <> *blanks
085200140214     C                   Eval      D3SCEF2 = %trim(Output_Date)
085300140214     C                   End
085400140214     C                   End
085500140214     C                   When      PLNCAT = 'PDR' or
085600140917     C                             PLNCAT = 'PDN' or
085700140917     C                             PLNCAT = 'PCD' or
085800140917     C                             PLNCAT = 'PDE'
085900140214     C                   If        D3SCEF3 <> *blanks
086000140214     C                   Movel     DENRDT        Input_Date
086100140214     C                   Eval      Input_Format = 'YYYYMMDD'
086200140214     C                   Eval      Output_Format  = 'MM/DD/YYYY'
086300140214     C                   Exsr      FormatDateSR
086400140214     C                   Eval      D3SCEF3 = %trim(Output_Date)
086500140214     C                   End
086600140214     C                   When      PLNCAT = 'PVR' or
086700140214     C                             PLNCAT = 'PVS'
086800140214     C                   If        D3SCEF4 <> *blanks
086900140214     C                   Movel     DENRDT        Input_Date
087000140214     C                   Eval      Input_Format = 'YYYYMMDD'
087100140214     C                   Eval      Output_Format  = 'MM/DD/YYYY'
087200140214     C                   Exsr      FormatDateSR
087300140214     C                   Eval      D3SCEF4 = %trim(Output_Date)
087400140214     C                   End
087500140214     C                   Endsl
087600140214
087700140214     C                   End
087800220203     C                   End
087900140214     C                   End
088000140214
088100140214     C     DPNKEY        Readpe    DCOVC
088200140214     C                   Enddo
088300140214
088400140214     C                   End
088500140214
088600140214     C     DSSNO         Readpe    DEPNDC
088700140214     C                   Enddo
088800140214
088900140214     C                   End
089000140214
089100140214     C     DPNKEY        Klist
089200140214     C                   Kfld                    DSSNO
089300140214     C                   Kfld                    DPSEQ#
089400211209
089500211209     C     DPNKEY2       Klist
089600211209     C                   Kfld                    DSSNO
089700211209     C                   Kfld                    DPSEQ#
089800140214
089900140214     C     PLNKEY        Klist
090000140214     C                   Kfld                    DVTRST
090100140214     C                   Kfld                    DVSUB#
090200140214     C                   Kfld                    DVPLAN
090300140214
090400140214     C                   ENDSR
090500190801      *___________________________________________________________________
090600190801      * Sync DEP Grps
090700190801      *___________________________________________________________________
090800190801     C     SyncDEPgrp    BEGSR
090900190801
091000190801     C                   If        D3SFX = '99'
091100190801
091200190801     C                   move      D3SUB         DSSNO
091300190801     C     DSSNO         Setgt     DEPNDC
091400190801     C     DSSNO         Readpe    DEPNDC
091500190801     C                   Dow       not %eof(DEPNDC)
091600190801
091700190801      * Find DEP SEQ
091800190801     C                   If        %trim(DLNAME) = %trim(D3LST) and
091900190801     C                             %trim(DFNAME) = %trim(D3FST) and
092000190801     C                             %trim(DMI)    = %trim(D3MID)
092100190801
092200190801      * Find active coverages
092300190801     C     DPNKEY        Setgt     DCOVC
092400190801     C     DPNKEY        Readpe    DCOVC
092500190801     C                   Dow       not %eof(DCOVC)
092600190801
092700211208     C                   If        CCANDT = 0
092800190801     C     PLNKEY        Chain     PLNMST
092900190801     C                   If        %found(PLNMST) and
093000191230     C                             %trim(PLNCAT) <> 'PCM' and
093100191230     C                             %trim(PLNCAT) <> 'PHH'
093200220203
093300220203GR99  * Carefirst only
093400220203GR99 C     PCARR         Chain     CARMST
093500220203GR99 C                   If        %found(CARMST) and
093600220203GR99 C                             CGRPCD = 'CF'
093700220203
093800190801     C     PLNCAT        Chain     CODESL1
093900190801     C                   If        %found(CODESL1)
094000190802     C                   eval      MCTRST = DVTRST
094100190802     C                   eval      MCSUB# = DVSUB#
094200190802     C                   eval      MCPLAN = DVPLAN
094300220705E002 C                   Exsr      GETMCVT
094400220705     C                   eval      MCTRST = DVTRST
094500220705     C                   eval      MCSUB# = DVSUB#
094600220705     C                   eval      MCPLAN = DVPLAN
094700220705
094800190801     C                   select
094900190801     C                   when      action = 'M' and
095000190913     C                             D3GRP1 <> *blanks and
095100190913     C                             D3FIL41 <> 'T'
095200211214     C                   eval      ENRLDT = DENRDT
095300190801     C                   exsr      getgroup
095400190801     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
095500230113     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
095600230113D001 C                   Eval      D3SGR1   =    %trim(%subst(GROUP#:9:4))
095700190801     C                   Eval      D3GRP1   =    %trim(%subst(GROUP#:1:8))
095800200625     C                   exsr      getclassDep
095900200617
096000200617      ******* DT99
096100200617     C                   if        D3SCEF1 <> *blanks
096200200617     C                   Movel     D3SCEF1       Input_Date
096300200617     C                   exsr      w80dateSR
096400200617
096500200617     C                   if        w80date < denrdt
096600200617     C                   Movel     DENRDT        Input_Date
096700200617     C                   Eval      Input_Format = 'YYYYMMDD'
096800200617     C                   Eval      Output_Format  = 'MM/DD/YYYY'
096900200617     C                   Exsr      FormatDateSR
097000200617     C                   Eval      D3SCEF1 = %trim(Output_Date)
097100200617     C                   If        D3SCEF2 <> *blanks
097200200617     C                   Eval      D3SCEF2 = %trim(Output_Date)
097300200617     C                   End
097400200617     C                   end
097500200617     C                   end
097600200617      ******* DT99
097700200617
097800190801     C                   when      action = 'R' and
097900190913     C                             D3GRP2 <> *blanks  and
098000190913     C                             D3FIL42 <> 'T'
098100211214     C                   eval      ENRLDT = DENRDT
098200190801     C                   exsr      getgroup
098300190801     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
098400190801     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
098500230113D001 C                   Eval      D3SGR2   =    %trim(%subst(GROUP#:9:4))
098600190801     C                   Eval      D3GRP2   =    %trim(%subst(GROUP#:1:8))
098700200625     C                   exsr      getclassDep
098800200617
098900200617      ******* DT99
099000200617     C                   if        D3SCEF2 <> *blanks
099100200617     C                   Movel     D3SCEF2       Input_Date
099200200617     C                   exsr      w80dateSR
099300200617
099400200617     C                   if        w80date < denrdt
099500200617     C                   Movel     DENRDT        Input_Date
099600200617     C                   Eval      Input_Format = 'YYYYMMDD'
099700200617     C                   Eval      Output_Format  = 'MM/DD/YYYY'
099800200617     C                   Exsr      FormatDateSR
099900200617     C                   Eval      D3SCEF2 = %trim(Output_Date)
100000200617     C                   end
100100200617     C                   end
100200200617      ******* DT99
100300200617
100400190801     C                   when      action = 'D' and
100500190913     C                             D3GRP3 <> *blanks  and
100600190913     C                             D3FIL43 <> 'T'
100700211214     C                   eval      ENRLDT = DENRDT
100800190801     C                   exsr      getgroup
100900190801     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
101000190801     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
101100230113D001 C                   Eval      D3SGR3   =    %trim(%subst(GROUP#:9:4))
101200190801     C                   Eval      D3GRP3   =    %trim(%subst(GROUP#:1:8))
101300200625     C                   exsr      getclassDep
101400200617
101500200617      ******* DT99
101600200617     C                   if        D3SCEF3 <> *blanks
101700200617     C                   Movel     D3SCEF3       Input_Date
101800200617     C                   exsr      w80dateSR
101900200617
102000200617     C                   if        w80date < denrdt
102100200617     C                   Movel     DENRDT        Input_Date
102200200617     C                   Eval      Input_Format = 'YYYYMMDD'
102300200617     C                   Eval      Output_Format  = 'MM/DD/YYYY'
102400200617     C                   Exsr      FormatDateSR
102500200617     C                   Eval      D3SCEF3 = %trim(Output_Date)
102600200617     C                   end
102700200617     C                   end
102800200617      ******* DT99
102900200617
103000190801     C                   when      action = 'V' and
103100190913     C                             D3GRP4 <> *blanks  and
103200190913     C                             D3FIL44 <> 'T'
103300211214     C                   eval      ENRLDT = DENRDT
103400190801     C                   exsr      getgroup
103500190801     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
103600190801     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
103700230113D001 C                   Eval      D3SGR4   =    %trim(%subst(GROUP#:9:4))
103800190801     C                   Eval      D3GRP4   =    %trim(%subst(GROUP#:1:8))
103900200625     C                   exsr      getclassDep
104000200617
104100200617      ******* DT99
104200200617     C                   if        D3SCEF4 <> *blanks
104300200617     C                   Movel     D3SCEF4       Input_Date
104400200617     C                   exsr      w80dateSR
104500200617
104600200617     C                   if        w80date < denrdt
104700200617     C                   Movel     DENRDT        Input_Date
104800200617     C                   Eval      Input_Format = 'YYYYMMDD'
104900200617     C                   Eval      Output_Format  = 'MM/DD/YYYY'
105000200617     C                   Exsr      FormatDateSR
105100200617     C                   Eval      D3SCEF4 = %trim(Output_Date)
105200200617     C                   end
105300200617     C                   end
105400200617      ******* DT99
105500200617
105600190801     C                   endsl
105700190801     C                   end
105800190801
105900190801     C                   End
106000220203     C                   End
106100190801     C                   End
106200190801
106300190801     C     DPNKEY        Readpe    DCOVC
106400190801     C                   Enddo
106500190801
106600190801     C                   End
106700190801
106800190801     C     DSSNO         Readpe    DEPNDC
106900190801     C                   Enddo
107000190801
107100190801     C                   End
107200190801
107300190801     C                   ENDSR
107400211208      *___________________________________________________________________
107500211208      * Sync DEP Grps Terms
107600211208      *___________________________________________________________________
107700211208     C     SyncDEPgrpTRM BEGSR
107800211208
107900211208     C                   clear                   W1
108000211208     C                   clear                   X1
108100211208     C                   clear                   Y1
108200211208     C                   clear                   Z1
108300211208
108400211208     C                   If        D3SFX = '99'
108500211208
108600211208     C                   move      D3SUB         DSSNO
108700211208     C     DSSNO         Setgt     DEPNDC
108800211208     C     DSSNO         Readpe    DEPNDC
108900211208     C                   Dow       not %eof(DEPNDC)
109000211208
109100211208      * Find DEP SEQ
109200211208     C                   If        %trim(DLNAME) = %trim(D3LST) and
109300211208     C                             %trim(DFNAME) = %trim(D3FST) and
109400211208     C                             %trim(DMI)    = %trim(D3MID)
109500211208
109600211208      * Find active coverages
109700211209     C     DPNKEY2       Setll     DCOV1
109800211209     C     DPNKEY2       Reade     DCOV1
109900211209     C                   Dow       not %eof(DCOV1)
110000211208
110100211208     C                   If        CCANDT <> 0
110200211208     C     PLNKEY        Chain     PLNMST
110300211208     C                   If        %found(PLNMST) and
110400211208     C                             %trim(PLNCAT) <> 'PCM' and
110500211208     C                             %trim(PLNCAT) <> 'PHH'
110600220203
110700220203GR99  * Carefirst only
110800220203GR99 C     PCARR         Chain     CARMST
110900220203GR99 C                   If        %found(CARMST) and
111000220203GR99 C                             CGRPCD = 'CF'
111100220203
111200211208     C     PLNCAT        Chain     CODESL1
111300211208     C                   If        %found(CODESL1)
111400211208     C                   eval      MCTRST = DVTRST
111500211208     C                   eval      MCSUB# = DVSUB#
111600211208     C                   eval      MCPLAN = DVPLAN
111700220705E002 C                   Exsr      GETMCVT
111800220705     C                   eval      MCTRST = DVTRST
111900220705     C                   eval      MCSUB# = DVSUB#
112000220705     C                   eval      MCPLAN = DVPLAN
112100211208     C                   select
112200211208     C                   when      action = 'M' and
112300211208     C                             D3GRP1 <> *blanks and
112400211223     C                             %trim(D3FIL41) = 'T'  and
112500211223     C                             w1 = 0
112600211214     C                   eval      ENRLDT = DENRDT
112700211208     C                   exsr      getgroup
112800211208     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
112900230113     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
113000230113D001 C                   Eval      D3SGR1   =    %trim(%subst(GROUP#:9:4))
113100211208     C                   Eval      D3GRP1   =    %trim(%subst(GROUP#:1:8))
113200211208     C                   exsr      getclassDep
113300211208     C                   eval      w1 = w1 + 1
113400211208
113500211208      ******* DT99
113600211208     C                   if        D3SCEF1 <> *blanks
113700211208     C                   Movel     D3SCEF1       Input_Date
113800211208     C                   exsr      w80dateSR
113900211208
114000211208     C                   if        w80date < denrdt
114100211208     C                   Movel     DENRDT        Input_Date
114200211208     C                   Eval      Input_Format = 'YYYYMMDD'
114300211208     C                   Eval      Output_Format  = 'MM/DD/YYYY'
114400211208     C                   Exsr      FormatDateSR
114500211208     C                   Eval      D3SCEF1 = %trim(Output_Date)
114600211208     C                   If        D3SCEF2 <> *blanks
114700211208     C                   Eval      D3SCEF2 = %trim(Output_Date)
114800211208     C                   End
114900211208     C                   end
115000211208     C                   end
115100211208      ******* DT99
115200211208
115300211208     C                   when      action = 'R' and
115400211208     C                             D3GRP2 <> *blanks  and
115500211223     C                             %trim(D3FIL42) = 'T' and
115600211223     C                             x1 = 0
115700211214     C                   eval      ENRLDT = DENRDT
115800211208     C                   exsr      getgroup
115900211208     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
116000211208     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
116100230113D001 C                   Eval      D3SGR2   =    %trim(%subst(GROUP#:9:4))
116200211208     C                   Eval      D3GRP2   =    %trim(%subst(GROUP#:1:8))
116300211208     C                   exsr      getclassDep
116400211208     C                   eval      x1 = x1 + 1
116500211208
116600211208      ******* DT99
116700211208     C                   if        D3SCEF2 <> *blanks
116800211208     C                   Movel     D3SCEF2       Input_Date
116900211208     C                   exsr      w80dateSR
117000211208
117100211208     C                   if        w80date < denrdt
117200211208     C                   Movel     DENRDT        Input_Date
117300211208     C                   Eval      Input_Format = 'YYYYMMDD'
117400211208     C                   Eval      Output_Format  = 'MM/DD/YYYY'
117500211208     C                   Exsr      FormatDateSR
117600211208     C                   Eval      D3SCEF2 = %trim(Output_Date)
117700211208     C                   end
117800211208     C                   end
117900211208      ******* DT99
118000211208
118100211208     C                   when      action = 'D' and
118200211208     C                             D3GRP3 <> *blanks  and
118300211223     C                             %trim(D3FIL43) = 'T' and
118400211223     C                             y1 = 0
118500211214     C                   eval      ENRLDT = DENRDT
118600211208     C                   exsr      getgroup
118700211208     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
118800211208     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
118900230113D001 C                   Eval      D3SGR3   =    %trim(%subst(GROUP#:9:4))
119000211208     C                   Eval      D3GRP3   =    %trim(%subst(GROUP#:1:8))
119100211208     C                   exsr      getclassDep
119200211208     C                   eval      y1 = y1 + 1
119300211208
119400211208      ******* DT99
119500211208     C                   if        D3SCEF3 <> *blanks
119600211208     C                   Movel     D3SCEF3       Input_Date
119700211208     C                   exsr      w80dateSR
119800211208
119900211208     C                   if        w80date < denrdt
120000211208     C                   Movel     DENRDT        Input_Date
120100211208     C                   Eval      Input_Format = 'YYYYMMDD'
120200211208     C                   Eval      Output_Format  = 'MM/DD/YYYY'
120300211208     C                   Exsr      FormatDateSR
120400211208     C                   Eval      D3SCEF3 = %trim(Output_Date)
120500211208     C                   end
120600211208     C                   end
120700211208      ******* DT99
120800211208
120900211208     C                   when      action = 'V' and
121000211208     C                             D3GRP4 <> *blanks  and
121100211223     C                             %trim(D3FIL44) = 'T' and
121200211223     C                             z1 = 0
121300211214     C                   eval      ENRLDT = DENRDT
121400211208     C                   exsr      getgroup
121500211208     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
121600211208     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
121700230113D001 C                   Eval      D3SGR4   =    %trim(%subst(GROUP#:9:4))
121800211208     C                   Eval      D3GRP4   =    %trim(%subst(GROUP#:1:8))
121900211208     C                   exsr      getclassDep
122000211208     C                   eval      z1 = z1 + 1
122100211208
122200211208      ******* DT99
122300211208     C                   if        D3SCEF4 <> *blanks
122400211208     C                   Movel     D3SCEF4       Input_Date
122500211208     C                   exsr      w80dateSR
122600211208
122700211208     C                   if        w80date < denrdt
122800211208     C                   Movel     DENRDT        Input_Date
122900211208     C                   Eval      Input_Format = 'YYYYMMDD'
123000211208     C                   Eval      Output_Format  = 'MM/DD/YYYY'
123100211208     C                   Exsr      FormatDateSR
123200211208     C                   Eval      D3SCEF4 = %trim(Output_Date)
123300211208     C                   end
123400211208     C                   end
123500211208      ******* DT99
123600211208
123700211208     C                   endsl
123800211208     C                   end
123900211208
124000211208     C                   End
124100220203     C                   End
124200211208     C                   End
124300211208
124400211208     C                   select
124500211208      * M + R + D + V
124600211208     C                   When      W1 = 1 and
124700211208     C                             %trim(D3FIL41) = 'T'  and
124800211208     C                             x1 = 1 and
124900211208     C                             %trim(D3FIL42) = 'T'  and
125000211208     C                             y1 = 1 and
125100211208     C                             %trim(D3FIL43) = 'T'  and
125200211208     C                             z1 = 1 and
125300211208     C                             %trim(D3FIL44) = 'T'
125400211208     C                   Leave
125500211208      * M + R + D
125600211208     C                   When      W1 = 1 and
125700211208     C                             %trim(D3FIL41) = 'T'  and
125800211208     C                             x1 = 1 and
125900211208     C                             %trim(D3FIL42) = 'T'  and
126000211208     C                             y1 = 1 and
126100211208     C                             %trim(D3FIL43) = 'T'  and
126200211208     C                             %trim(D3FIL44) <> 'T'
126300211208     C                   Leave
126400211208      * M + R
126500211208     C                   When      W1 = 1 and
126600211208     C                             %trim(D3FIL41) = 'T'  and
126700211208     C                             x1 = 1 and
126800211208     C                             %trim(D3FIL42) = 'T'  and
126900211208     C                             %trim(D3FIL43) <> 'T'  and
127000211208     C                             %trim(D3FIL44) <> 'T'
127100211208     C                   Leave
127200211208      * D + V
127300211208     C                   When      y1 = 1 and
127400211208     C                             %trim(D3FIL43) = 'T'  and
127500211208     C                             z1 = 1 and
127600211208     C                             %trim(D3FIL44) = 'T'  and
127700211208     C                             %trim(D3FIL41) <> 'T'  and
127800211208     C                             %trim(D3FIL42) <> 'T'
127900211208     C                   Leave
128000211208      * D
128100211208     C                   When      y1 = 1 and
128200211208     C                             %trim(D3FIL43) = 'T'  and
128300211208     C                             %trim(D3FIL44) <> 'T'  and
128400211208     C                             %trim(D3FIL41) <> 'T'  and
128500211208     C                             %trim(D3FIL42) <> 'T'
128600211208     C                   Leave
128700211208      * V
128800211208     C                   When      z1 = 1 and
128900211208     C                             %trim(D3FIL44) = 'T'  and
129000211208     C                             %trim(D3FIL41) <> 'T'  and
129100211208     C                             %trim(D3FIL42) <> 'T'  and
129200211208     C                             %trim(D3FIL43) <> 'T'
129300211208     C                   Leave
129400211208      * M
129500211208     C                   When      W1 = 1 and
129600211208     C                             %trim(D3FIL41) = 'T'  and
129700211208     C                             %trim(D3FIL42) <> 'T'  and
129800211208     C                             %trim(D3FIL43) <> 'T'  and
129900211208     C                             %trim(D3FIL44) <> 'T'
130000211208     C                   Leave
130100211208      * None
130200211208     C                   When      %trim(D3FIL41) <> 'T'  and
130300211208     C                             %trim(D3FIL42) <> 'T'  and
130400211208     C                             %trim(D3FIL43) <> 'T'  and
130500211208     C                             %trim(D3FIL44) <> 'T'
130600211208     C                   Leave
130700211208     C                   endsl
130800211208
130900211209     C     DPNKEY2       Reade     DCOV1
131000211208     C                   Enddo
131100211208
131200211208     C                   End
131300211208
131400211209     C     DSSNO         Readpe    DEPNDC
131500211208     C                   Enddo
131600211208
131700211208     C                   End
131800211208
131900211208     C                   ENDSR
132000090320      *___________________________________________________________________
132100121126      * Sync Dates
132200090320      *___________________________________________________________________
132300121126     C     SyncDates     BEGSR
132400190528
132500190528     C     WKACT         KLIST
132600190528     C                   KFLD                    W_T
132700190528     C                   KFLD                    W_S
132800190528     C                   KFLD                    W_A
132900190528
133000190528     C                   eval      tsachar = d3tsa
133100190528     C     WkAct         Chain     ACCMST
133200190528     C                   If        %Found
133300121126
133400121126     C     *Date         Mult      10000.0001    w80date
133500121126     C                   Movel     w80date       Input_Date
133600120821     C                   Eval      Input_Format = 'YYYYMMDD'
133700120821     C                   Eval      Output_Format  = 'MM/DD/YYYY'
133800120821     C                   Exsr      FormatDateSR
133900120821     C                   Eval      WTODAY        = %trim(Output_Date)
134000121127
134100121127      * Frist, check for reinstate = today
134200121127     C                   If        %trim(D3FIL41) = 'R' and
134300121127     C                             D3SCEF1 = WTODAY
134400121127     C                   Eval      D3SCEF1 = D3SGRE
134500121127     C                   End
134600121127     C                   If        %trim(D3FIL42) = 'R' and
134700121127     C                             D3SCEF2 = WTODAY
134800121127     C                   Eval      D3SCEF2 = D3SGRE
134900121127     C                   End
135000121127     C                   If        %trim(D3FIL43) = 'R' and
135100121127     C                             D3SCEF3 = WTODAY
135200121127     C                   Eval      D3SCEF3 = D3SGRE
135300121127     C                   End
135400121127     C                   If        %trim(D3FIL44) = 'R' and
135500121127     C                             D3SCEF4 = WTODAY
135600121127     C                   Eval      D3SCEF4 = D3SGRE
135700121127     C                   End
135800130813      *
135900130813      * IF DEPENDT ADD, IF ORG = BIRTH, THEN NEW BORN
136000130813     C                   If        D3SFX = '99'   and
136100130813     C                             D3MNTYP = 'A'
136200130813     C                   If        D3ORGEF = D3BIRTH
136300130813     C                   If        D3FIL41 =  'A' and
136400130813     C                             D3SCEF1 <> *blanks
136500130813     C                   Eval      D3SCEF1 = D3BIRTH
136600130813     C                   End
136700130813     C                   If        D3FIL42 =  'A' and
136800130813     C                             D3SCEF2 <> *blanks
136900130813     C                   Eval      D3SCEF2 = D3BIRTH
137000130813     C                   End
137100130813     C                   If        D3FIL43 =  'A' and
137200130813     C                             D3SCEF3 <> *blanks
137300130813     C                   Eval      D3SCEF3 = D3BIRTH
137400130813     C                   End
137500130813     C                   If        D3FIL44 =  'A' and
137600130813     C                             D3SCEF4 <> *blanks
137700130813     C                   Eval      D3SCEF4 = D3BIRTH
137800130813     C                   End
137900130813     C                   End
138000130813     C                   End
138100130725      *
138200130905     C                   If        D3SFX = '00'
138300131213     C                   Exsr      ChkDepTerm
138400131213     C                   Exsr      ChkAdds
138500130905     C                   End
138600190528      *
138700190528      * overall CHANGE with NO CHANGE to any of the products,
138800190528      * you default the date to when GBS' relationship started
138900190528      * GBS Begin Date.
139000190528      *
139100190528     C                   If        %trim(D3MNTYP) = 'C' and
139200190528     C                             %trim(D3FIL41) = 'N' and
139300190528     C                             %trim(D3FIL42) = 'N' and
139400190528     C                             %trim(D3FIL43) = 'N' and
139500190528     C                             %trim(D3FIL44) = 'N'
139600190528     C                   Movel     D3SCEF1       Input_Date
139700190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
139800190528     C                   Eval      Output_Format = 'YYYYMMDD'
139900190528     C                   Exsr      FormatDateSR
140000190528     C                   movel     Output_Date   w80date
140100190528     C                   if        w80date < GBSBDT
140200190528     C                   Movel     GBSBDT        Input_Date
140300190528     C                   Eval      Input_Format = 'YYYYMMDD'
140400190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
140500190528     C                   Exsr      FormatDateSR
140600190528     C                   movel     Output_Date   D3SCEF1
140700190528     C                   movel     Output_Date   D3CLSE
140800190528     C                   movel     Output_Date   D3SGRE
140900190528     C                   movel     Output_Date   D3ORGEF
141000190528     C                   movel     Output_Date   D3CLSE1
141100190528     C                   movel     Output_Date   D3PRVEF1
141200190528     C                   End
141300190528     C                   Movel     D3SCEF2       Input_Date
141400190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
141500190528     C                   Eval      Output_Format = 'YYYYMMDD'
141600190528     C                   Exsr      FormatDateSR
141700190528     C                   movel     Output_Date   w80date
141800190528     C                   if        w80date < GBSBDT
141900190528     C                   Movel     GBSBDT        Input_Date
142000190528     C                   Eval      Input_Format = 'YYYYMMDD'
142100190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
142200190528     C                   Exsr      FormatDateSR
142300190528     C                   movel     Output_Date   D3SCEF2
142400190528     C                   movel     Output_Date   D3CLSE2
142500190528     C                   movel     Output_Date   D3PRVEF2
142600190528     C                   End
142700190528     C                   Movel     D3SCEF3       Input_Date
142800190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
142900190528     C                   Eval      Output_Format = 'YYYYMMDD'
143000190528     C                   Exsr      FormatDateSR
143100190528     C                   movel     Output_Date   w80date
143200190528     C                   if        w80date < GBSBDT
143300190528     C                   Movel     GBSBDT        Input_Date
143400190528     C                   Eval      Input_Format = 'YYYYMMDD'
143500190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
143600190528     C                   Exsr      FormatDateSR
143700190528     C                   movel     Output_Date   D3SCEF3
143800190528     C                   movel     Output_Date   D3CLSE3
143900190528     C                   End
144000190528     C                   Movel     D3SCEF4       Input_Date
144100190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
144200190528     C                   Eval      Output_Format = 'YYYYMMDD'
144300190528     C                   Exsr      FormatDateSR
144400190528     C                   movel     Output_Date   w80date
144500190528     C                   if        w80date < GBSBDT
144600190528     C                   Movel     GBSBDT        Input_Date
144700190528     C                   Eval      Input_Format = 'YYYYMMDD'
144800190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
144900190528     C                   Exsr      FormatDateSR
145000190528     C                   movel     Output_Date   D3SCEF4
145100190528     C                   movel     Output_Date   D3CLSE4
145200190528     C                   End
145300190528     C                   End
145400190528     C                   if        %trim(D3MNTYP) = 'C' and
145500190528     C                             %trim(D3FIL41) = 'N' and
145600190528     C                             %trim(D3FIL42) = 'N' and
145700190528     C                             %trim(D3FIL43) = 'N' and
145800190528     C                             %trim(D3FIL44) = ' '
145900190528     C                   Movel     D3SCEF1       Input_Date
146000190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
146100190528     C                   Eval      Output_Format = 'YYYYMMDD'
146200190528     C                   Exsr      FormatDateSR
146300190528     C                   movel     Output_Date   w80date
146400190528     C                   if        w80date < GBSBDT
146500190528     C                   Movel     GBSBDT        Input_Date
146600190528     C                   Eval      Input_Format = 'YYYYMMDD'
146700190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
146800190528     C                   Exsr      FormatDateSR
146900190528     C                   movel     Output_Date   D3SCEF1
147000190528     C                   movel     Output_Date   D3CLSE
147100190528     C                   movel     Output_Date   D3SGRE
147200190528     C                   movel     Output_Date   D3ORGEF
147300190528     C                   movel     Output_Date   D3CLSE1
147400190528     C                   movel     Output_Date   D3PRVEF1
147500190528     C                   End
147600190528     C                   Movel     D3SCEF2       Input_Date
147700190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
147800190528     C                   Eval      Output_Format = 'YYYYMMDD'
147900190528     C                   Exsr      FormatDateSR
148000190528     C                   movel     Output_Date   w80date
148100190528     C                   if        w80date < GBSBDT
148200190528     C                   Movel     GBSBDT        Input_Date
148300190528     C                   Eval      Input_Format = 'YYYYMMDD'
148400190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
148500190528     C                   Exsr      FormatDateSR
148600190528     C                   movel     Output_Date   D3SCEF2
148700190528     C                   movel     Output_Date   D3CLSE2
148800190528     C                   movel     Output_Date   D3PRVEF2
148900190528     C                   End
149000190528     C                   Movel     D3SCEF3       Input_Date
149100190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
149200190528     C                   Eval      Output_Format = 'YYYYMMDD'
149300190528     C                   Exsr      FormatDateSR
149400190528     C                   movel     Output_Date   w80date
149500190528     C                   if        w80date < GBSBDT
149600190528     C                   Movel     GBSBDT        Input_Date
149700190528     C                   Eval      Input_Format = 'YYYYMMDD'
149800190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
149900190528     C                   Exsr      FormatDateSR
150000190528     C                   movel     Output_Date   D3SCEF3
150100190528     C                   movel     Output_Date   D3CLSE3
150200190528     C                   End
150300190528     C                   End
150400201210     C                   if        %trim(D3MNTYP) = 'C' and
150500201210     C                             %trim(D3FIL41) = 'N' and
150600201210     C                             %trim(D3FIL42) = 'N' and
150700201210     C                             %trim(D3FIL43) = ' ' and
150800201210     C                             %trim(D3FIL44) = 'N'
150900201210     C                   Movel     D3SCEF1       Input_Date
151000201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
151100201210     C                   Eval      Output_Format = 'YYYYMMDD'
151200201210     C                   Exsr      FormatDateSR
151300201210     C                   movel     Output_Date   w80date
151400201210     C                   if        w80date < GBSBDT
151500201210     C                   Movel     GBSBDT        Input_Date
151600201210     C                   Eval      Input_Format = 'YYYYMMDD'
151700201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
151800201210     C                   Exsr      FormatDateSR
151900201210     C                   movel     Output_Date   D3SCEF1
152000201210     C                   movel     Output_Date   D3CLSE
152100201210     C                   movel     Output_Date   D3SGRE
152200201210     C                   movel     Output_Date   D3ORGEF
152300201210     C                   movel     Output_Date   D3CLSE1
152400201210     C                   movel     Output_Date   D3PRVEF1
152500201210     C                   End
152600201210     C                   Movel     D3SCEF2       Input_Date
152700201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
152800201210     C                   Eval      Output_Format = 'YYYYMMDD'
152900201210     C                   Exsr      FormatDateSR
153000201210     C                   movel     Output_Date   w80date
153100201210     C                   if        w80date < GBSBDT
153200201210     C                   Movel     GBSBDT        Input_Date
153300201210     C                   Eval      Input_Format = 'YYYYMMDD'
153400201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
153500201210     C                   Exsr      FormatDateSR
153600201210     C                   movel     Output_Date   D3SCEF2
153700201210     C                   movel     Output_Date   D3CLSE2
153800201210     C                   movel     Output_Date   D3PRVEF2
153900201210     C                   End
154000201210     C                   Movel     D3SCEF4       Input_Date
154100201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
154200201210     C                   Eval      Output_Format = 'YYYYMMDD'
154300201210     C                   Exsr      FormatDateSR
154400201210     C                   movel     Output_Date   w80date
154500201210     C                   if        w80date < GBSBDT
154600201210     C                   Movel     GBSBDT        Input_Date
154700201210     C                   Eval      Input_Format = 'YYYYMMDD'
154800201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
154900201210     C                   Exsr      FormatDateSR
155000201210     C                   movel     Output_Date   D3SCEF4
155100201210     C                   movel     Output_Date   D3CLSE4
155200201210     C                   End
155300201210     C                   End
155400190528     C                   if        %trim(D3MNTYP) = 'C' and
155500190528     C                             %trim(D3FIL41) = 'N' and
155600190528     C                             %trim(D3FIL42) = 'N' and
155700190528     C                             %trim(D3FIL43) = ' ' and
155800190528     C                             %trim(D3FIL44) = ' '
155900190528     C                   Movel     D3SCEF1       Input_Date
156000190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
156100190528     C                   Eval      Output_Format = 'YYYYMMDD'
156200190528     C                   Exsr      FormatDateSR
156300190528     C                   movel     Output_Date   w80date
156400190528     C                   if        w80date < GBSBDT
156500190528     C                   Movel     GBSBDT        Input_Date
156600190528     C                   Eval      Input_Format = 'YYYYMMDD'
156700190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
156800190528     C                   Exsr      FormatDateSR
156900190528     C                   movel     Output_Date   D3SCEF1
157000190528     C                   movel     Output_Date   D3CLSE
157100190528     C                   movel     Output_Date   D3SGRE
157200190528     C                   movel     Output_Date   D3ORGEF
157300190528     C                   movel     Output_Date   D3CLSE1
157400190528     C                   movel     Output_Date   D3PRVEF1
157500190528     C                   End
157600190528     C                   Movel     D3SCEF2       Input_Date
157700190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
157800190528     C                   Eval      Output_Format = 'YYYYMMDD'
157900190528     C                   Exsr      FormatDateSR
158000190528     C                   movel     Output_Date   w80date
158100190528     C                   if        w80date < GBSBDT
158200190528     C                   Movel     GBSBDT        Input_Date
158300190528     C                   Eval      Input_Format = 'YYYYMMDD'
158400190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
158500190528     C                   Exsr      FormatDateSR
158600190528     C                   movel     Output_Date   D3SCEF2
158700190528     C                   movel     Output_Date   D3CLSE2
158800190528     C                   movel     Output_Date   D3PRVEF2
158900190528     C                   End
159000190528     C                   End
159100201210     C                   if        %trim(D3MNTYP) = 'C' and
159200201210     C                             %trim(D3FIL41) = ' ' and
159300201210     C                             %trim(D3FIL42) = ' ' and
159400201210     C                             %trim(D3FIL43) = 'N' and
159500201210     C                             %trim(D3FIL44) = 'N'
159600201210     C                   Movel     D3SCEF1       Input_Date
159700201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
159800201210     C                   Eval      Output_Format = 'YYYYMMDD'
159900201210     C                   Exsr      FormatDateSR
160000201210     C                   movel     Output_Date   w80date
160100201210     C                   if        w80date < GBSBDT
160200201210     C                   Movel     GBSBDT        Input_Date
160300201210     C                   Eval      Input_Format = 'YYYYMMDD'
160400201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
160500201210     C                   Exsr      FormatDateSR
160600201210     C                   movel     Output_Date   D3SCEF3
160700201210     C                   movel     Output_Date   D3CLSE
160800201210     C                   movel     Output_Date   D3SGRE
160900201210     C                   movel     Output_Date   D3ORGEF
161000201210     C                   movel     Output_Date   D3CLSE3
161100201210     C                   End
161200201210     C                   Movel     D3SCEF4       Input_Date
161300201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
161400201210     C                   Eval      Output_Format = 'YYYYMMDD'
161500201210     C                   Exsr      FormatDateSR
161600201210     C                   movel     Output_Date   w80date
161700201210     C                   if        w80date < GBSBDT
161800201210     C                   Movel     GBSBDT        Input_Date
161900201210     C                   Eval      Input_Format = 'YYYYMMDD'
162000201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
162100201210     C                   Exsr      FormatDateSR
162200201210     C                   movel     Output_Date   D3SCEF4
162300201210     C                   movel     Output_Date   D3CLSE4
162400201210     C                   End
162500201210     C                   End
162600190528     C                   if        %trim(D3MNTYP) = 'C' and
162700190528     C                             %trim(D3FIL41) = 'N' and
162800190528     C                             %trim(D3FIL42) = ' ' and
162900190528     C                             %trim(D3FIL43) = ' ' and
163000190528     C                             %trim(D3FIL44) = ' '
163100190528     C                   Movel     D3SCEF1       Input_Date
163200190528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
163300190528     C                   Eval      Output_Format = 'YYYYMMDD'
163400190528     C                   Exsr      FormatDateSR
163500190528     C                   movel     Output_Date   w80date
163600190528     C                   if        w80date < GBSBDT
163700190528     C                   Movel     GBSBDT        Input_Date
163800190528     C                   Eval      Input_Format = 'YYYYMMDD'
163900190528     C                   Eval      Output_Format  = 'MM/DD/YYYY'
164000190528     C                   Exsr      FormatDateSR
164100190528     C                   movel     Output_Date   D3SCEF1
164200190528     C                   movel     Output_Date   D3CLSE
164300190528     C                   movel     Output_Date   D3SGRE
164400190528     C                   movel     Output_Date   D3ORGEF
164500190528     C                   movel     Output_Date   D3CLSE1
164600190528     C                   movel     Output_Date   D3PRVEF1
164700190528     C                   End
164800190528     C                   End
164900201210      * DT99
165000201210     C                   if        %trim(D3MNTYP) = 'C' and
165100201210     C                             %trim(D3FIL41) = ' ' and
165200201210     C                             %trim(D3FIL42) = ' ' and
165300201210     C                             %trim(D3FIL43) = 'N' and
165400201210     C                             %trim(D3FIL44) = ' '
165500201210     C                   Movel     D3SCEF3       Input_Date
165600201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
165700201210     C                   Eval      Output_Format = 'YYYYMMDD'
165800201210     C                   Exsr      FormatDateSR
165900201210     C                   movel     Output_Date   w80date
166000201210     C                   if        w80date < GBSBDT
166100201210     C                   Movel     GBSBDT        Input_Date
166200201210     C                   Eval      Input_Format = 'YYYYMMDD'
166300201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
166400201210     C                   Exsr      FormatDateSR
166500201210     C                   movel     Output_Date   D3SCEF3
166600201210     C                   movel     Output_Date   D3CLSE
166700201210     C                   movel     Output_Date   D3SGRE
166800201210     C                   movel     Output_Date   D3ORGEF
166900201210     C                   movel     Output_Date   D3CLSE3
167000201210     C                   End
167100201210     C                   End
167200201210      * DT99
167300201210     C                   if        %trim(D3MNTYP) = 'C' and
167400201210     C                             %trim(D3FIL41) = ' ' and
167500201210     C                             %trim(D3FIL42) = ' ' and
167600201210     C                             %trim(D3FIL43) = ' ' and
167700201210     C                             %trim(D3FIL44) = 'N'
167800201210     C                   Movel     D3SCEF4       Input_Date
167900201210     C                   Eval      Input_Format  = 'MM/DD/YYYY'
168000201210     C                   Eval      Output_Format = 'YYYYMMDD'
168100201210     C                   Exsr      FormatDateSR
168200201210     C                   movel     Output_Date   w80date
168300201210     C                   if        w80date < GBSBDT
168400201210     C                   Movel     GBSBDT        Input_Date
168500201210     C                   Eval      Input_Format = 'YYYYMMDD'
168600201210     C                   Eval      Output_Format  = 'MM/DD/YYYY'
168700201210     C                   Exsr      FormatDateSR
168800201210     C                   movel     Output_Date   D3SCEF4
168900201210     C                   movel     Output_Date   D3CLSE
169000201210     C                   movel     Output_Date   D3SGRE
169100201210     C                   movel     Output_Date   D3ORGEF
169200201210     C                   movel     Output_Date   D3CLSE4
169300201210     C                   End
169400201210     C                   End
169500190528      *
169600130905      *
169700130725     C                   LeaveSR
169800130725      *
169900190528     C                   End
170000190528      *
170100130725      * SKIP The below code, think it hurts more then helps.
170200130725      * SKIP The below code, think it hurts more then helps.
170300130725      * SKIP The below code, think it hurts more then helps.
170400121127      *
170500121126     C                   Eval      W8ADATE = *blanks
170600121126      *
170700121126      * First, find a date other than today's date
170800121126     C                   If        D3SCEF1 <> WTODAY  and
170900121126     C                             D3SCEF1 <> *blanks
171000121126     C                   Eval      W8ADATE = D3SCEF1
171100121126     C                   End
171200121126     C                   If        W8ADATE =  *blanks and
171300121126     C                             D3SCEF2 <> *blanks and
171400121126     C                             D3SCEF2 <> WTODAY
171500121126     C                   Eval      W8ADATE = D3SCEF2
171600121126     C                   End
171700121126     C                   If        W8ADATE =  *blanks and
171800121126     C                             D3SCEF3 <> *blanks and
171900121126     C                             D3SCEF3 <> WTODAY
172000121126     C                   Eval      W8ADATE = D3SCEF3
172100121126     C                   End
172200121126     C                   If        W8ADATE =  *blanks and
172300121126     C                             D3SCEF4 <> *blanks and
172400121126     C                             D3SCEF4 <> WTODAY
172500121126     C                   Eval      W8ADATE = D3SCEF4
172600121126     C                   End
172700121126
172800121126      * Next, all dates must be the same, so update with not-todays-date
172900121126     C                   If        W8ADATE <> *blanks
173000121126     C                   If        D3SCEF1 <> *blanks and
173100121126     C                             D3SCEF2 <> *blanks and
173200121126     C                             D3SCEF1 <> D3SCEF2
173300121126     C                   Eval      D3SCEF1 = W8ADATE
173400121126     C                   Eval      D3SCEF2 = W8ADATE
173500121126     C                   End
173600121126     C                   End
173700121126
173800121126     C                   If        W8ADATE <> *blanks
173900121126     C                   If        D3SCEF1 <> *blanks and
174000121126     C                             D3SCEF3 <> *blanks and
174100121126     C                             D3SCEF1 <> D3SCEF3
174200121126     C                   Eval      D3SCEF1 = W8ADATE
174300121126     C                   Eval      D3SCEF3 = W8ADATE
174400121126     C                   End
174500121126     C                   End
174600121126
174700121126     C                   If        W8ADATE <> *blanks
174800121126     C                   If        D3SCEF1 <> *blanks and
174900121126     C                             D3SCEF4 <> *blanks and
175000121126     C                             D3SCEF1 <> D3SCEF4
175100121126     C                   Eval      D3SCEF1 = W8ADATE
175200121126     C                   Eval      D3SCEF4 = W8ADATE
175300121126     C                   End
175400121126     C                   End
175500121126
175600121126     C                   If        W8ADATE <> *blanks
175700121126     C                   If        D3SCEF2 <> *blanks and
175800121126     C                             D3SCEF3 <> *blanks and
175900121126     C                             D3SCEF2 <> D3SCEF3
176000121126     C                   Eval      D3SCEF2 = W8ADATE
176100121126     C                   Eval      D3SCEF3 = W8ADATE
176200121126     C                   End
176300121126     C                   End
176400121126
176500121126     C                   If        W8ADATE <> *blanks
176600121126     C                   If        D3SCEF2 <> *blanks and
176700121126     C                             D3SCEF4 <> *blanks and
176800121126     C                             D3SCEF2 <> D3SCEF4
176900121126     C                   Eval      D3SCEF2 = W8ADATE
177000121126     C                   Eval      D3SCEF4 = W8ADATE
177100121126     C                   End
177200121126     C                   End
177300121126
177400121126     C                   If        W8ADATE <> *blanks
177500121126     C                   If        D3SCEF3 <> *blanks and
177600121126     C                             D3SCEF4 <> *blanks and
177700121126     C                             D3SCEF3 <> D3SCEF4
177800121126     C                   Eval      D3SCEF3 = W8ADATE
177900121126     C                   Eval      D3SCEF4 = W8ADATE
178000121126     C                   End
178100121126     C                   End
178200121126
178300121126     C                   Update    DBEDTLR
178400100121
178500100121     C                   ENDSR
178600140528
178700140528      *___________________________________________________________________
178800140528      * Sync Dem Only
178900140528      *___________________________________________________________________
179000140528     C     SyncDemonly   BEGSR
179100140528
179200140528      * Change only, followed by product no-change
179300140528     C                   If        %trim(D3MNTYP) <> 'C'
179400140528     C                   LeaveSR
179500140528     C                   End
179600140528
179700140528      * product no-change
179800140528     C                   If        (D3FIL41 = 'N' or D3FIL41 = ' ') and
179900140528     C                             (D3FIL42 = 'N' or D3FIL42 = ' ') and
180000140528     C                             (D3FIL43 = 'N' or D3FIL43 = ' ') and
180100140528     C                             (D3FIL44 = 'N' or D3FIL44 = ' ')
180200140528
180300140528      *
180400140528      * First, latest date
180500140528     C                   If        D3SCEF1 <> *blanks
180600140528     C                   Movel     D3SCEF1       Input_Date
180700140528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
180800140528     C                   Eval      Output_Format = 'YYYYMMDD'
180900140528     C                   Exsr      FormatDateSR
181000140528     C                   movel     Output_Date   w80date
181100140528     C                   End
181200140528
181300140528     C                   If        D3SCEF2 <> *blanks
181400140528     C                   Movel     D3SCEF2       Input_Date
181500140528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
181600140528     C                   Eval      Output_Format = 'YYYYMMDD'
181700140528     C                   Exsr      FormatDateSR
181800140528     C                   movel     Output_Date   w81date
181900140528     C                   End
182000140528
182100140528      * use the greater date unless equal just use 80date
182200140528     C                   If        w80date <> 0  and
182300140528     C                             w81date <> 0
182400140528     C                   if        w80date < w81date
182500140528     C                   eval      w80date = w81date
182600140528     C                   End
182700140528     C                   End
182800140528
182900140528     C                   If        D3SCEF3 <> *blanks
183000140528     C                   Movel     D3SCEF3       Input_Date
183100140528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
183200140528     C                   Eval      Output_Format = 'YYYYMMDD'
183300140528     C                   Exsr      FormatDateSR
183400140528     C                   movel     Output_Date   w81date
183500140528     C                   End
183600140528
183700140528      * use the greater date unless equal just use 80date
183800140528     C                   If        w80date <> 0  and
183900140528     C                             w81date <> 0
184000140528     C                   if        w80date < w81date
184100140528     C                   eval      w80date = w81date
184200140528     C                   End
184300140528     C                   End
184400140528
184500140528     C                   If        D3SCEF4 <> *blanks
184600140528     C                   Movel     D3SCEF4       Input_Date
184700140528     C                   Eval      Input_Format  = 'MM/DD/YYYY'
184800140528     C                   Eval      Output_Format = 'YYYYMMDD'
184900140528     C                   Exsr      FormatDateSR
185000140528     C                   movel     Output_Date   w81date
185100140528     C                   End
185200140528
185300140528      * use the greater date unless equal just use 80date
185400140528     C                   If        w80date <> 0  and
185500140528     C                             w81date <> 0
185600140528     C                   if        w80date < w81date
185700140528     C                   eval      w80date = w81date
185800140528     C                   End
185900140528     C                   End
186000140528
186100140528      * Format the date
186200140528     C                   If        w80date <> *zeros
186300140528     C                   Eval      W8ADATE = *blanks
186400140528
186500140528     C                   Movel     w80date       Input_Date
186600140528     C                   Eval      Input_Format  = 'YYYYMMDD'
186700140528     C                   Eval      Output_Format = 'MM/DD/YYYY'
186800140528     C                   Exsr      FormatDateSR
186900140528     C                   Eval      W8ADATE       = %trim(Output_Date)
187000140528
187100140528      * Next, all dates must be the same, so update with w80date
187200140528     C                   If        D3SCEF1 <> *blanks
187300140528     C                   Eval      D3SCEF1 = W8ADATE
187400140528     C                   End
187500140528
187600140528     C                   If        D3SCEF2 <> *blanks
187700140528     C                   Eval      D3SCEF2 = W8ADATE
187800140528     C                   End
187900140528
188000140528     C                   If        D3SCEF3 <> *blanks
188100140528     C                   Eval      D3SCEF3 = W8ADATE
188200140528     C                   End
188300140528
188400140528     C                   If        D3SCEF4 <> *blanks
188500140528     C                   Eval      D3SCEF4 = W8ADATE
188600140528     C                   End
188700140528
188800140528     C                   End
188900140528     C                   End
189000140528     C                   ENDSR
189100130905      *___________________________________________________________________
189200130905      * Check Dep Terms
189300130905      *___________________________________________________________________
189400130905     C     ChkDepTerm    BEGSR
189500130905     C     DEPKEY        Klist
189600130905     C                   Kfld                    D3SUB
189700130905     C                   Kfld                    D_D3SFX
189800130905     C                   Eval      D_D3SFX = '99'
189900130905
190000130905     C     DEPKEY        Setll     DBEDTL834L
190100130905     C     DEPKEY        Reade     DBEDTL834L
190200130905     C                   Dow       not %eof(DBEDTL834L)
190300130905
190400130905      * Member Change, and dependent Term, (TERM, REINSTATE) and the
190500130905      * member date is less than the depend date, use the dep date
190600130905      * Product 1
190700130905     C                   If        D3FIL41 = 'C'   and
190800130905     C                             D_D3FIL41 = 'S'
190900130905     C                   If        D3SCEF1   <> *blanks and
191000130905     C                             D_D3SCEF1 <> *blanks and
191100130905     C                             D3SCEF1   <> D_D3SCEF1
191200130905
191300130905     C                   Movel     D3SCEF1       Input_Date
191400130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
191500130905     C                   Eval      Output_Format  = 'YYYYMMDD'
191600130905     C                   Exsr      FormatDateSR
191700130905     C                   Eval      W8ADATE       = %trim(Output_Date)
191800130905     C                   Move      W8ADATE       W81DATE
191900130905
192000130905     C                   Movel     D_D3SCEF1     Input_Date
192100130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
192200130905     C                   Eval      Output_Format  = 'YYYYMMDD'
192300130905     C                   Exsr      FormatDateSR
192400130905     C                   Eval      W8ADATE       = %trim(Output_Date)
192500130905     C                   Move      W8ADATE       W82DATE
192600130905
192700130905     C                   If        W82DATE > W81DATE
192800130905     C                   Eval      D3SCEF1 = D_D3SCEF1
192900130905     C                   End
193000130905
193100130905     C                   End
193200130905     C                   End
193300130905      * Product 2
193400130905     C                   If        D3FIL42 = 'C'   and
193500130905     C                             D_D3FIL42 = 'S'
193600130905     C                   If        D3SCEF2   <> *blanks and
193700130905     C                             D_D3SCEF2 <> *blanks and
193800130905     C                             D3SCEF2   <> D_D3SCEF2
193900130905
194000130905     C                   Movel     D3SCEF2       Input_Date
194100130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
194200130905     C                   Eval      Output_Format  = 'YYYYMMDD'
194300130905     C                   Exsr      FormatDateSR
194400130905     C                   Eval      W8ADATE       = %trim(Output_Date)
194500130905     C                   Move      W8ADATE       W81DATE
194600130905
194700130905     C                   Movel     D_D3SCEF2     Input_Date
194800130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
194900130905     C                   Eval      Output_Format  = 'YYYYMMDD'
195000130905     C                   Exsr      FormatDateSR
195100130905     C                   Eval      W8ADATE       = %trim(Output_Date)
195200130905     C                   Move      W8ADATE       W82DATE
195300130905
195400130905     C                   If        W82DATE > W81DATE
195500130905     C                   Eval      D3SCEF2 = D_D3SCEF2
195600130905     C                   End
195700130905
195800130905     C                   End
195900130905     C                   End
196000130905      * Product 3
196100130905     C                   If        D3FIL43 = 'C'   and
196200130905     C                             D_D3FIL43 = 'S'
196300130905     C                   If        D3SCEF3   <> *blanks and
196400130905     C                             D_D3SCEF3 <> *blanks and
196500130905     C                             D3SCEF3   <> D_D3SCEF3
196600130905
196700130905     C                   Movel     D3SCEF3       Input_Date
196800130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
196900130905     C                   Eval      Output_Format  = 'YYYYMMDD'
197000130905     C                   Exsr      FormatDateSR
197100130905     C                   Eval      W8ADATE       = %trim(Output_Date)
197200130905     C                   Move      W8ADATE       W81DATE
197300130905
197400130905     C                   Movel     D_D3SCEF3     Input_Date
197500130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
197600130905     C                   Eval      Output_Format  = 'YYYYMMDD'
197700130905     C                   Exsr      FormatDateSR
197800130905     C                   Eval      W8ADATE       = %trim(Output_Date)
197900130905     C                   Move      W8ADATE       W82DATE
198000130905
198100130905     C                   If        W82DATE > W81DATE
198200130905     C                   Eval      D3SCEF3 = D_D3SCEF3
198300130905     C                   End
198400130905
198500130905     C                   End
198600130905     C                   End
198700130905      * Product 4
198800130905     C                   If        D3FIL44 = 'C'   and
198900130905     C                             D_D3FIL44 = 'S'
199000130905     C                   If        D3SCEF4   <> *blanks and
199100130905     C                             D_D3SCEF4 <> *blanks and
199200130905     C                             D3SCEF4   <> D_D3SCEF4
199300130905
199400130905     C                   Movel     D3SCEF4       Input_Date
199500130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
199600130905     C                   Eval      Output_Format  = 'YYYYMMDD'
199700130905     C                   Exsr      FormatDateSR
199800130905     C                   Eval      W8ADATE       = %trim(Output_Date)
199900130905     C                   Move      W8ADATE       W81DATE
200000130905
200100130905     C                   Movel     D_D3SCEF4     Input_Date
200200130905     C                   Eval      Input_Format = 'MM/DD/YYYY'
200300130905     C                   Eval      Output_Format  = 'YYYYMMDD'
200400130905     C                   Exsr      FormatDateSR
200500130905     C                   Eval      W8ADATE       = %trim(Output_Date)
200600130905     C                   Move      W8ADATE       W82DATE
200700130905
200800130905     C                   If        W82DATE > W81DATE
200900130905     C                   Eval      D3SCEF4 = D_D3SCEF4
201000130905     C                   End
201100130905
201200130905     C                   End
201300130905     C                   End
201400130905
201500130905     C     DEPKEY        Reade     DBEDTL834L
201600130905     C                   Enddo
201700130905
201800130905     C                   ENDSR
201900131213      *___________________________________________________________________
202000131213      * Check Adds
202100131213      *___________________________________________________________________
202200131213     C     ChkAdds       BEGSR
202300131213
202400131213     C                   Eval      w80adds  = 0
202500131213     C                   Eval      w80add41 = 0
202600131213     C                   Eval      w80add42 = 0
202700131213     C                   Eval      w80add43 = 0
202800131213     C                   Eval      w80add44 = 0
202900131213
203000131213     C                   If        D3FIL41 = 'A'    and
203100131213     C                             D3SCEF1   <> *blanks
203200131213
203300131213     C                   Movel     D3SCEF1       Input_Date
203400131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
203500131213     C                   Eval      Output_Format  = 'YYYYMMDD'
203600131213     C                   Exsr      FormatDateSR
203700131216     C                   Eval      w8xdate       = %trim(Output_Date)
203800131216     C                   Move      w8xdate       W80ADD41
203900131216     C                   Move      w8xdate       W80ADDS
204000131213     C                   End
204100131213
204200131213     C                   If        D3FIL42 = 'A'    and
204300131213     C                             D3SCEF2   <> *blanks
204400131213
204500131213     C                   Movel     D3SCEF2       Input_Date
204600131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
204700131213     C                   Eval      Output_Format  = 'YYYYMMDD'
204800131213     C                   Exsr      FormatDateSR
204900131216     C                   Eval      w8xdate       = %trim(Output_Date)
205000131216     C                   Move      w8xdate       W80ADD42
205100131213     C                   If        W80ADD42 > W80ADDS
205200131213     C                   Eval      W80ADDS = W80ADD42
205300131213     C                   End
205400131213     C                   End
205500131213
205600131213     C                   If        D3FIL43 = 'A'    and
205700131213     C                             D3SCEF3   <> *blanks
205800131213
205900131213     C                   Movel     D3SCEF3       Input_Date
206000131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
206100131213     C                   Eval      Output_Format  = 'YYYYMMDD'
206200131213     C                   Exsr      FormatDateSR
206300131216     C                   Eval      w8xdate       = %trim(Output_Date)
206400131216     C                   Move      w8xdate       W80ADD43
206500131213     C                   If        W80ADD43 > W80ADDS
206600131213     C                   Eval      W80ADDS = W80ADD43
206700131213     C                   End
206800131213     C                   End
206900131213
207000131213     C                   If        D3FIL44 = 'A'    and
207100131213     C                             D3SCEF4   <> *blanks
207200131213
207300131213     C                   Movel     D3SCEF4       Input_Date
207400131213     C                   Eval      Input_Format = 'MM/DD/YYYY'
207500131213     C                   Eval      Output_Format  = 'YYYYMMDD'
207600131213     C                   Exsr      FormatDateSR
207700131216     C                   Eval      w8xdate       = %trim(Output_Date)
207800131216     C                   Move      w8xdate       W80ADD44
207900131213     C                   If        W80ADD44 > W80ADDS
208000131213     C                   Eval      W80ADDS = W80ADD44
208100131213     C                   End
208200131213     C                   End
208300131213
208400131213     C                   If        W80ADDS  > 0
208500131213
208600131213     C                   If        D3FIL41 = 'A'    and
208700131213     C                             D3SCEF1   <> *blanks
208800131213     C                   Movel     W80ADDS       Input_Date
208900131213     C                   Eval      Input_Format  = 'YYYYMMDD'
209000131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
209100131213     C                   Exsr      FormatDateSR
209200131213     C                   Eval      D3SCEF1       = %trim(Output_Date)
209300131213     C                   End
209400131213
209500131213     C                   If        D3FIL42 = 'A'    and
209600131213     C                             D3SCEF2   <> *blanks
209700131213     C                   Movel     W80ADDS       Input_Date
209800131213     C                   Eval      Input_Format  = 'YYYYMMDD'
209900131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
210000131213     C                   Exsr      FormatDateSR
210100131213     C                   Eval      D3SCEF2       = %trim(Output_Date)
210200131213     C                   End
210300131213
210400131213     C                   If        D3FIL43 = 'A'    and
210500131213     C                             D3SCEF3   <> *blanks
210600131213     C                   Movel     W80ADDS       Input_Date
210700131213     C                   Eval      Input_Format  = 'YYYYMMDD'
210800131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
210900131213     C                   Exsr      FormatDateSR
211000131213     C                   Eval      D3SCEF3       = %trim(Output_Date)
211100131213     C                   End
211200131213
211300131213     C                   If        D3FIL44 = 'A'    and
211400131213     C                             D3SCEF4   <> *blanks
211500131213     C                   Movel     W80ADDS       Input_Date
211600131213     C                   Eval      Input_Format  = 'YYYYMMDD'
211700131213     C                   Eval      Output_Format = 'MM/DD/YYYY'
211800131213     C                   Exsr      FormatDateSR
211900131213     C                   Eval      D3SCEF4       = %trim(Output_Date)
212000131213     C                   End
212100131213
212200131213     C                   End
212300131213
212400131213     C                   ENDSR
212500141212      *___________________________________________________________________
212600141212      * Get Active Cov Date
212700141212      *___________________________________________________________________
212800141212     C     GetActiveSR   BEGSR
212900141212
213000141212     C                   Clear                   REINDAT
213100141212
213200141212     C     SSNO          Setgt     MCOV
213300141212     C     SSNO          Readpe    MCOV
213400141212     C                   Dow       not %eof(MCOV)
213500141212     C                   If        CANDT = 0
213600210223     C     MEMKEY        Chain     PLNMST
213700210223     C                   If        %found(PLNMST) and
213800210223     C                             %trim(PLNCAT) <> 'PCM' and
213900210223     C                             %trim(PLNCAT) <> 'PHH'
214000210223      * Carefirst only
214100210223     C     PCARR         Chain     CARMST
214200210223     C                   If        %found(CARMST) and
214300210223     C                             CGRPCD = 'CF'
214400210223
214500141212     C                   Movel     ENRLDT        Input_Date
214600141212     C                   Eval      Input_Format  = 'YYYYMMDD'
214700141212     C                   Eval      Output_Format = 'MM/DD/YYYY'
214800141212     C                   Exsr      FormatDateSR
214900141212     C                   Eval      REINDAT       = %trim(Output_Date)
215000141212     C                   Leave
215100210223     C                   end
215200210223     C                   end
215300141212     C                   end
215400141212     C     SSNO          Readpe    MCOV
215500141212     C                   Enddo
215600141212
215700141212     C                   ENDSR
215800121126      *___________________________________________________________________
215900121126      * Format Date
216000121126      *___________________________________________________________________
216100121126     C     FormatDateSR  BEGSR
216200121126     C                   Call      'FMTDATE'
216300121126     C                   Parm                    Input_Date       32
216400121126     C                   Parm                    Input_Format     32
216500121126     C                   Parm                    Output_Format    32
216600121126     C                   Parm                    Output_Date      32
216700121126     C                   Parm                    Output_Error     10
216800121126     C                   Eval      Input_Date   = *blanks
216900121126     C                   Eval      Input_Format = *blanks
217000121126     C                   Eval      OutPut_Format = *blanks
217100121126     C                   ENDSR
217200200617     C     w80dateSR     BEGSR
217300200617     C                   Eval      Input_Format  = 'MM/DD/YYYY'
217400200617     C                   Eval      Output_Format = 'YYYYMMDD'
217500200617     C                   Exsr      FormatDateSR
217600200617     C                   movel     Output_Date   w80date
217700200617     C                   ENDSR
217800220705      *___________________________________________________________________
217900220705E002  * Member Coverage Type
218000220705      *___________________________________________________________________
218100220705E002 C     GETMCVT       BEGSR
218200220705     C                   move      D3SUB         MCSSNO
218300220705     C     MCSSNO        Setgt     MCOV
218400220705     C     MCSSNO        Readpe    MCOV
218500220705     C                   Dow       not %eof(MCOV)
218600220705GR99 C                   If        CANDT = 0  or
218700220705GR99 C                             Today >= ENRLDT and
218800220705GR99 C                             Today <= CANDT
218900220705     C                   if        MCPLAN = DVPLAN
219000220705     C                   leavesr
219100220705     C                   end
219200220705     C                   end
219300220705     C     MCSSNO        Readpe    MCOV
219400220705     C                   enddo
219500220705E002 C                   ENDSR
219600190930      *___________________________________________________________________
219700190930      * Entry
219800190930      *___________________________________________________________________
219900190930     C     *inzsr        BEGSR
220000190930ADD2 C     *entry        plist
220100190930ADD2 C                   parm                    spcflg            1
220200210223     C     *Date         Mult      10000.0001    Today
220300190930     C                   ENDSR
