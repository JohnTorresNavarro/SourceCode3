000100180927     h option(*noDebugIo)
000200001030      ******************************************************************
000300050314      * DW360           Dentaquest transmission                        *
000400001030      *                                                                *
000500050314      * 03/09/05 dlk - re-write from "dentfls",                        *
000600050314      *                conversion to new file format, prevent          *
000700050311      *                grate search prior to 5/1/05, use true effdt    *
000800050311      *                for grate search for future adds                *
000900050503      * 05/03/05 dlk - design change to correct dependent terms        *
001000050503      *                1. read all mcov, only process active mcov but  *
001100050503      *                #GETDEP routine will still check all active and *
001200050503      *                cancelled dependents.                           *
001300050503      *                2. use compare to previous method to capture    *
001400050503      *                dep cancellations instead of trnmit.            *
001500050510      * 05/10/05 dlk - need to remove extra dependent cancel rec caused*
001600050510      *                by multiple gbs plans with same group #. force
001700050510      *                all 9's in the cancel date for active dep plans *
001800050510      *                so dw363 can sort and remove the extra cancel   *
001900050510      *                rec.                                            *
002000050517      * 05/17/05 dlk - create DQDCANPV and DQDCANCU files to hold all
002100050517      *                dependent coverage cancels so this process can
002200050517      *                compare what was cancelled last run and decide
002300050517      *                what to send this run.
002400080314      * 03/14/08 dlk - do not send dep term when account is cancelled
002500110324      * 03/24/11 dlk - Add coverage type P2 to the xref so it is       *
002600110324      *                converted to the same DQ coverage as PC.        *
002700110324      *                This was a request by Carol F because Kelly     *
002800110324      *                Dixon sold something not available to DQ.       *
002900111228      * 12/28/11 dlk - consier a domestic partner a spouse             *
003000140326      * 03/26/14 dlk - DQ (Mark Brown) request throught Brandon S -    *
003100140326      *                stop sending dep term when coverage type changes*
003200140326      *                (lower). Since we do not exacty know a coverage *
003300140326      *                type changed we will have to try to assume it   *
003400140326      *                based on the current cov level and relation code*
003500140326      *                of the dep term rec.                            *
003600140703      * 06/11/14 dlk - fix handicap code
003700140613      * 06/13/14 dlk - request from Deborah Clark & Brandon - omit account
003800140613      *                591-7-359 group # 0260405401 from the file
003900170509      * 05/09/17 dlk - do not send dep cancel rec if there is a member
004000170509      *                term trnmit rec for this plan with a term code that
004100170509      *                should not be transmitted.
004200180921      *                                                                *
004300180921      * 09/21/18 B.Rees
004400180921      *   Request from Deborah Clark - Omit Account: 300-006-0145
004500180921      *   Mod ID: BR01
004600140326      *                                                                *
004700180925      * 09/25/18 J.Torres - Eliminated hardcoding of accounts not to send.
004800180925      *                     Please call program TROFFCL to add or remove
004900180925      *                     Accounts not to send.
005000180925
005100001030      ******************************************************************
005200050311     Fdw360j    ip   e           k DISK
005300990709     FMEMBER    IF   E           K DISK
005400990728     FDEPNDC    IF   E           K DISK
005500990728     FDCOV      IF   E           K DISK
005600011204     FGRATE     IF   E           K DISK
005700011204     FPCPL1     IF   E           K DISK
005800050517     Fdqdcanpv  if   E           K Disk    rename(dqdcr:dqdcrpv) prefix(p_)
005900080314     Faccmst    if   E           K Disk
006000170509     Ftrnmitl2  if   E           K Disk    prefix(t_)
0061001705090024 Fcodes     if   e           k disk    prefix(co_)
006200180924     ftransoff1 if   e           k disk    rename(transr:transFile)
006300180924
006400050517     Fdqdcancu  o  a E           K Disk
006500050311     Fdqmem     O    E           K DISK
006600050311     Fdqdep     O    E           K DISK
006700990709
0068000503150037 D workdt          S               d   datfmt(*iso)
0069000503160037 D workdt80        S              8  0
007000050125     D grpcod15        S             15
007100050311     D grpcod10        S             10
007200170509     D skipdep         S              1
007300050503     D active_grp      S                   like(dqmgrp)
007400050503     D active_sec      S                   like(dqmsec)
007500050503     D cancel_grp      S                   like(dqmgrp)
007600050503     D cancel_sec      S                   like(dqmsec)
007700140326     D dqmcov_hold     S                   like(dqmcov)
007800020220
007900011204     D                 DS
008000050311     D udate8ymd               1      8  0
008100011204     D  DYY                    1      4  0
008200011204     D  DMM                    5      6  0
008300011204     D  DDD                    7      8  0
008400011204
008500011204
008600011204     DPOS              S              2  0
008700050315     DSPCLTY           S              5    INZ('CDCDN')
008800011204     DSS#              S              9  0
008900020125     DSQ#              S              2  0 INZ(00)
009000050311     Dratedate         S              8  0
009100050311
0092000503110030 Idw360r
009300050311     I                                          mcssno        l1
009400050311     I                                          mcplan        l1
009500011204
009600050503     c                   if        *inl1
009700050503     c                   clear                   active_grp
009800050503     c                   clear                   active_sec
009900050503     c                   clear                   cancel_grp
010000050503     c                   clear                   cancel_sec
010100140326     c                   clear                   dqmcov_hold
010200050503     c                   end
010300050503
010400140703     c                   clear                   skipthismem       1
010500050311     C     MCSSNO        CHAIN     MEMBR
010600050311     C                   IF        not %found(member)
010700140703     c                   eval      skipthismem = 'Y'
010800050311     c                   goto      #end
010900050311     c                   end
011000140613
011100140613     ***********************************************
011200140613      * 6/13/14 - request by deb C and brandon - skip acct 591-7-359
011300180925     c****               if        mbtrst = 591 and mbsub# = 7 and mbacct = 359
011400180925     c****               eval      skipthismem = 'Y'
011500180925     c****               end
011600140613     ***********************************************
011700180921
011800180921Br01    //-------------------------------------
011900180921 |      // 09/21/2018 - Rquest by Deborah Clark
012000180921 |      //              Skip acct 300-6-145
012100180921 |      //-------------------------------------
012200180925 |      //if mbtrst = 300 and mbSub# = 6 and mbAcct = 145;
012300180925 |      //   skipthismem = 'Y';
012400180925br01    //endif;
012500180921
012600180925       exsr checkTransmission;
012700050311
012800050311     C                   MOVE      MCSSNO        dqmsubid
012900050311     C                   move      birth         dqmdob
013000050311     C                   EVAL      dqmsex    = SEX
013100050311     C                   EVAL      dqmlname  = MLNAME
013200050311     C                   EVAL      dqmfname  = MFNAME
013300050311     C                   EVAL      dqmmi     = MMI
013400050311     C                   EVAL      dqmaddr1  = ADDR1
013500050311     C                   EVAL      dqmaddr2  = ADDR2
013600050311     C                   EVAL      dqmcity   = CITY
013700050311     C                   EVAL      dqmst     = STATE
013800050311     C                   clear                   dqmzip
013900050311     C                   MOVEL     ZIP           zip5              5
014000050311     C                   MOVE      ZIP           zip4              4
014100050311     C                   MOVEL     ZIP5          dqmzip
014200050314     c                   if        zip4 <> '0000'
014300050311     c                   move      zip4          dqmzip
014400050311     c                   end
014500050311
014600050311     C                   move      enrldt        dqmeff
014700050315
014800050315     c                   clear                   workdt
014900050316     c                   clear                   workdt80
015000050315     c                   clear                   dqmcan
015100050311     c                   if        candt <> 0
015200050315     C                   move      candt         workdt
015300050315     c                   if        enrldt <> candt
015400050315     c                   exsr      #minus1day
015500050315     c                   end
015600050316     C                   move      workdt        workdt80
015700050316     C                   move      workdt80      dqmcan
015800050311     c                   end
015900050311
016000050311     C                   move      empdt         dqmdoh
016100050316     C                   move      '1'           dqmrel
016200050311
016300050311      * coverage type
016400110324      * 03/24/11 add P2 cov same as PC
016500990709     C                   SELECT
016600990709     C                   WHEN      MCOVTP = 'TIN'
016700050311     C                   EVAL      dqmcov = '1'
016800050316     C                   WHEN      MCOVTP = 'THW'
016900050311     C                   EVAL      dqmcov = '2'
017000110324     C                   WHEN      MCOVTP = 'TPC' or mcovtp = 'TP2'
017100050311     C                   EVAL      dqmcov = '3'
017200050316     C                   WHEN      MCOVTP = 'TFA'
017300050316     C                   EVAL      dqmcov = '4'
017400990709     C                   ENDSL
017500011217
017600050311      * get group number
017700050311     c                   exsr      #getgroup
017800011204
017900050311      * get PCP
018000050311     C                   clear                   dqmdenid
018100050311     C                   EVAL      SS# = MCSSNO
018200050311     C                   move      enrldt        effymd            8 0
018300050311     C                   move      candt         canymd            8 0
018400050311     c                   exsr      #pcp
018500050311     c                   movel     pcpfound      dqmdenid
018600040415
018700050311     c                   move      'X'           dqmfil1
018800050503
018900050503      * write member if active
019000050503      * save group / sec for later use in dependent
019100050503     c                   if        candt = 0
019200140703
019300140703      * 6/13/14 - skip some members per admin request
019400140703     c                   if        skipthismem = *blank
019500050311     C                   write     dqmemr
019600140703     c                   end
019700140703
019800050503     c                   move      dqmgrp        active_grp
019900050503     c                   move      dqmsec        active_sec
020000140326     c                   move      dqmcov        dqmcov_hold
020100050503     c                   else
020200050503     c                   move      dqmgrp        cancel_grp
020300050503     c                   move      dqmsec        cancel_sec
020400050503     c                   end
020500050503
020600050503     c                   clear                   dqmemr
020700050311
020800140703     c     #end          tag
020900140703
021000050311      * get dependents at end of ssn / plan
021100050311     cl1                 exsr      #getdep
021200050311
021300050311      *******************************************************************
021400050311      * get group #
021500050311      *******************************************************************
021600050311     c     #getgroup     begsr
021700050311
021800050311      * date for grate search. use cancel date if cancelled plan, else
021900050311      * use todays date unless the mcov is a future enroll, then use
022000050311      * the future enroll date.
022100050311
022200050311     C                   IF        CANDT > 0
022300050311     C                   EVAL      ratedate = CANDT
022400050311     C                   ELSE
022500050311     c                   if        enrldt < udate8ymd
022600050311     C                   EVAL      ratedate = udate8ymd
022700050311     c                   else
022800050311     C                   EVAL      ratedate = enrldt
022900050311     c                   end
023000050311     C                   ENDIF
023100050311
023200050311      * date override for 5/1/05 group number conversion. all rate searches
023300050311      * will use a date no earlier than 5/1/05.
023400050311
023500050311     c                   if        ratedate < 20050501
023600050311     c                   eval      ratedate = 20050501
023700050311     c                   end
023800050311
023900050311      * get group #
024000050311     c                   clear                   grpcod15
024100050311     c                   clear                   grpcod10
024200050311
024300050311     C     GRTKEY        SETLL     GRATER
024400050311     C     GRTKEY        READE     GRATER                                 97
024500050311     C                   DOW       *IN97 = *OFF
024600050311     C                   IF        ratedate >= FRMDAT and
024700050311     C                             ratedate <= TODAT
024800050311     C                   EVAL      GRPCOD15 = GROUP#
024900050311     C                   LEAVE
025000050311     C                   ENDIF
025100050311     C     GRTKEY        READE     GRATER                                 97
025200050311     C                   ENDDO
025300050311
025400050311      * if grate not found for effdt, use latest date range
025500050311
025600050311     C                   IF        GRPCOD15 = *BLANKS
025700050311     C     GRTKEY        SETGT     GRATER
025800050311     C     GRTKEY        READPE    GRATER                                 95
025900050311     C                   IF        *IN95 = *OFF
026000050311     C                   EVAL      GRPCOD15 = GROUP#
026100050311     C                   ENDIF
026200050311     C                   ENDIF
026300050311
026400050311      * remove dash from group # if one exists
026500050311
026600050311     c                   Eval      pos = %scan('-':grpcod15)
026700050311
026800050311     c                   if        pos = 0
026900050311     c                   eval      grpcod10 = %trim(grpcod15)
027000050311     c                   else
027100050311     C                   eval      grpcod10 = (%subst(grpcod15:1:pos-1)) +
027200050311     C                             (%subst(grpcod15:pos+1:15-pos))
027300050311     C                   end
027400050311
027500050311     C                   eval      dqmgrp = (%subst(grpcod10:1:6))
027600050311     C                   eval      dqmsec = (%subst(grpcod10:7:4))
027700050311
027800050311     c                   endsr
027900050311
028000050311      *******************************************************************
028100050311      * get dependents for this ssn / plan
028200050311      *******************************************************************
028300050311
028400050311     c     #getdep       begsr
028500080314
028600050311     C     MCSSNO        SETLL     DCOV
028700050311     C                   dou       %eof(dcov)
028800050311     C     MCSSNO        READE     DCOV
028900050503     C                   if        %eof(dcov) or dvplan <> mcplan
029000050311     c                   iter
029100050311     c                   end
029200050311
029300050311     C     SEQKEY        CHAIN     depndc
029400050311     C                   IF        not %found(depndc)
029500050311     c                   iter
029600050311     c                   end
029700050311
029800050311     C                   MOVE      DSSNO         dqdsubid
029900050317     C                   MOVE      Dpseq#        dqdseq
030000050311     C                   move      dbirth        dqddob
030100050311     C                   EVAL      dqdsex   = DSEX
030200050311
030300050311     C                   IF        DLNAME   = 'SAME'
030400050311     C                   EVAL      dqdlname = MLNAME
030500011207     C                   ELSE
030600050311     C                   EVAL      dqdlname = DLNAME
030700011207     C                   ENDIF
030800050311
030900050311     C                   EVAL      dqdfname = DFNAME
031000050311     C                   EVAL      dqdmi    = DMI
031100050316
031200050311     C                   move      denrdt        dqdeff
031300050316
031400050503     c* sub 1 from cancel day
031500050316     c                   clear                   workdt
031600050316     c                   clear                   workdt80
031700050316     c                   clear                   dqdcan
031800050316     c                   if        ccandt <> 0
031900050316     C                   move      ccandt        workdt
032000050316     c                   if        denrdt <> ccandt
032100050316     c                   exsr      #minus1day
032200050316     c                   end
032300050316     C                   move      workdt        workdt80
032400050316     C                   move      workdt80      dqdcan
032500050316     c                   end
032600050311
032700050311     c* relation code : 1=self 2=spouse, 3=child
032800120118     c* 12/28/11 - consider a RPA - Domestic partner a spouse.
032900011204     C                   IF        DRELCD = 'RHU' OR DRELCD = 'RWI'
033000120118     C                             OR DRELCD = 'RPA'
033100050311     C                   EVAL      dqdrel = '2'
033200011204     C                   ELSE
033300050311     C                   EVAL      dqdrel = '3'
033400011204     C                   ENDIF
033500050311
033600050503      * group number from member - use the active group if exists, else
033700050503      * use the last cancelled
033800050503     c                   if        active_grp <> *blanks
033900050503     c                   eval      dqdgrp = active_grp
034000050503     c                   eval      dqdsec = active_sec
034100050503     c                   else
034200050503     c                   eval      dqdgrp = cancel_grp
034300050503     c                   eval      dqdsec = cancel_sec
034400050503     c                   end
034500050311
034600050311     c                   eval      dqdstu = 'N'
034700050311     c                   if        dstudn = 'Y'
034800050311     c                   eval      dqdstu = 'Y'
034900050311     c                   end
035000050311
035100050311     c                   eval      dqdhcp = 'N'
035200140703     c                   if        dhndcp <> ' '
035300050311     c                   eval      dqdhcp = 'Y'
035400050311     c                   end
035500050311
035600050311     C                   EVAL      SS# = MCSSNO
035700050311     C                   move      denrdt        effymd            8 0
035800050311     C                   move      ccandt        canymd            8 0
035900050311     c                   exsr      #pcp
036000050311     c                   movel     pcpfound      dqddenid
036100050311
036200050517      * if active - write to current dependent file
036300050503     C                   if        ccandt = 0
036400050510     c                   eval      dqdcan = '99999999'
036500140703
036600140703      * 6/13/14 - skip some members per admin request
036700140703     c                   if        skipthismem = *blank
036800050311     C                   WRITE     dqdepr
036900140703     c                   end
037000050517
037100050503     c                   else
037200050503
037300080314      * if cancelled - write to current cancel hist file
037400050517     C                   movel     dqdsubid      dqdcsid
037500050517     C                   move      dqdseq        dqdcseq
037600050517     C                   move      dvplan        dqdcplan
037700050517     C                   move      dqdeff        dqdceff
037800050517     C                   move      dqdcan        dqdccan
037900050517     C                   write     dqdcr
038000050517
038100080314      * 3/14/08 if the account is cancelled, do not send term
038200080314     c     acckey        chain     accmst
038300080314     c                   if        not %found(accmst) or atrmdt <> 0
038400080314     c                   iter
038500080314     c                   end
038600170509
038700170509      * 5/09/17 if the member coverage was termed with a code that does not
038800170509      *         transmit then do not send dependent term either
038900080314
039000170509       clear skipdep;
039100170509       setll mcssno trnmitl2;
039200170509       dou %eof(trnmitl2);
039300170509       reade mcssno trnmitl2;
039400170509        if not %eof(trnmitl2) and t_actcod = 'MT' and t_plan# = dvplan and
039500170509        t_termin <> *blanks;
039600170509         chain ('D':t_termin) codes;
039700170509          if %found(codes);
039800170509           if co_action = 'N';
039900170509            skipdep = 'Y';
040000170509            else;
040100170509            skipdep = *blank;
040200170509           endif;
040300170509          endif;
040400170509        endif;
040500170509       enddo;
040600170509
040700170509       if skipdep = 'Y';
040800170509       iter;
040900170509       endif;
041000170509
041100170509
041200140326      * 3/26/14 DQ wants us to not send dep term if coverage type changed
041300140326      * since their system will automatically cancel the dependents.
041400140326      * since we do not know a coverage type changed the following logic
041500140326      * will try to assume it happend and skip sending the dep term in
041600140326      * most cases.
041700140326
041800140326     c                   select
041900140326      * in cov - do not send any dep terms
042000140326     c                   when      dqmcov_hold = '1'
042100140326     c                   iter
042200140326      * hw cov - do not send child term
042300140326     c                   when      dqmcov_hold = '2' and dqdrel = '3'
042400140326     c                   iter
042500140326      * pc cov - do not send spouse term
042600140326     c                   when      dqmcov_hold = '3' and dqdrel = '2'
042700140326     c                   iter
042800140326     c                   endsl
042900140326
043000140326
043100050517      * create key fields to check prev cancel file
043200080314      * if not found or cancelled with different cancel
043300080314      * date, add it to the DQ output file
043400050503     C                   movel     dqdsubid      dpksid
043500050517     C                   move      dqdseq        dpkseq
043600050517     C                   move      dvplan        dpkplan
043700050517     C                   move      dqdeff        dpkenr
043800050516
043900050517     c     dprvkey       chain     dqdcanpv
044000050517     c                   if        not %found(dqdcanpv) or
044100050517     c                             p_dqdccan <> dqdcan
044200140703
044300140703      * 6/13/14 - skip some members per admin request
044400140703     c                   if        skipthismem = *blank
044500140703     C                   WRITE     dqdepr
044600140703     c                   end
044700140703
044800050503     c                   end
044900050503
045000050517     c                   end
045100050503
045200050517
045300050311     C                   CLEAR                   dqdepr
045400050311
045500990728     C                   ENDDO
045600050311
045700050311     C                   endsr
0458000503110832
0459000503150819 C*******************************************************************
0460000503150820 C* subtract 1 day
0461000503150819 C*******************************************************************
0462000503150821 C     #minus1day    BEGSR
046300050315     c                   subdur    1:*d          workdt
0464000503150831 C                   ENDSR
0465000503151117
046600050311  77 C****************************************************************
0467000503111278 C*
0468000503111279 C*---------- GET PCP INFO --------------------------------------*
0469000503111280 C*
0470000503111281 C     #PCP          BEGSR
047100050311
047200050311     C                   clear                   pcpfound         20
047300050311
047400050311     C     PCPKEY        SETLL     PCPl1
047500050311     c                   dou       %eof(pcpl1)
047600050311     C     pcpkey        reade     PCPl1
047700050311
047800050311     c                   if        %eof(pcpl1) or (pceff = pccan) or
047900050311     c                             (canymd <> 0 and canymd <= pceff) or
048000050311     c                             (pccan <> 0 and effymd >= pccan)
048100050311     c                   iter
048200050311     c                   end
048300050311
048400050311     C                   MOVEl     PCID#         pcpfound
048500050311     C                   enddo
048600050311
048700050311     C                   ENDSR
048800050311
048900180924      //========================================================================
049000180924      // check for transmission
049100180924      //========================================================================
049200180924
049300180924       begsr checkTransmission;
049400180924
049500180924        chain (14 : mbtrst : mbsub# : mbacct) transFile;
049600180924        if %found;
049700180924         skipthismem = 'Y';
049800180924        endif;
049900180924
050000180924       endsr;
050100180924
050200180924      //========================================================================
050300011204     C     *INZSR        BEGSR
050400011204
050500050119     C     PLNKEY        KLIST
050600050119     C                   KFLD                    PLTRST
050700050119     C                   KFLD                    PLSUB#
050800050119     C                   KFLD                    PLPLAN
050900050119
051000050311     C     SEQKEY        KLIST
051100050311     C                   KFLD                    SSNO
051200050311     C                   KFLD                    DSEQ#
051300050119
051400050119     C     GRTKEY        KLIST
051500050119     C                   KFLD                    MCTRST
051600050119     C                   KFLD                    MCSUB#
051700050119     C                   KFLD                    MCPLAN
051800050119     C                   KFLD                    MCAGEB
051900050119     C                   KFLD                    MCOVTP
052000050119
052100050119     C     PCPKEY        KLIST
052200050119     C                   KFLD                    SS#
052300050119     C                   KFLD                    SQ#
052400050119     C                   KFLD                    SPCLTY
052500050119
052600050503     C     dprvkey       Klist
052700050503     C                   Kfld                    dpksid            9
052800050517     C                   Kfld                    dpkseq            2 0
052900050516     C                   Kfld                    dpkplan           4
053000050503     C                   Kfld                    dpkenr            8
053100050503
053200080314     C     acckey        KLIST
053300080314     C                   KFLD                    mbtrst
053400080314     C                   KFLD                    mbsub#
053500080314     C                   KFLD                    mbacct
053600080314
053700011204     C                   MOVE      *MONTH        DMM
053800050318     C                   MOVE      *day          DDD
053900011204     C                   MOVE      *YEAR         DYY
054000011204
054100011204     C                   ENDSR
