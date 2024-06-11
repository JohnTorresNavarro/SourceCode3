0001000210160015  ******************************************************************
000200021108      * dw300          Group Benefit Services, Inc.                    *
000300021016      *                                                                *
000400021016      *    WRITTEN BY - DAVID KETTERMAN                                *
000500021108      *    DATE       - 11/08/02                                       *
000600021016      *                                                                *
000700021108      * This program will produce the Delegated Billing PEAR file      *
000800021108      * to Care First.                                                 *
0009000211080015  *                                                                *
0010000212230015  * 12/23/02 dlk - change to "Bill to Bill comparison" - remove    *
0011000212230015  *                subscriber effdt and change file type to "B"    *
0012000310070015  * 10/07/03 dlk - add type selection                              *
0013000502160015  * 02/16/05 dlk - change type "B" file to get billed amount from  *
0014000502160015  *                INVDET instead of DBREC since DBREC does not    *
0015000502160015  *                contain future invoice date.                    *
0016000503280015  * 03/28/05 dlk - PEAR file changes - new fields                  *
0017000504190015  * 04/19/05 dlk - do not send family indicator for parallel groups
0018000504250015  * 04/22/05 dlk - this version will only process "B" & "E" files
0019000511070015  * 11/07/05 dlk - only send dependents with DBE coverage.         *
0020000601250015  * 01/24/06 dlk - correct cobra amounts to not include the 2%     *
0021000601270015  * 01/27/06 dlk - fix group # - send any active group# (all should*
0022000601270015  *                be the same per member)                         *
0023000711070015  * 11/07/07 dlk - do not include records without a group # (per   *
0024000711070015  *                Deb Chapman @ CF)                               *
0025000901220015  * 01/22/09 dlk - add MI and P2 coverage types.                   *
0026000901260015  *              - add error report when cov type "O" is used.     *
0027001002170015  * 02/17/10 dlk - exclude groups that have migrated to 4.5        *
0028001008020015  * 08/02/10 dlk - put back groups that have migrated to 4.5       *
0029001009010015  * 09/01/10 dlk - add option to select 4.3, 4.5 or both           *
0030001011300015  * 11/30/10 dlk - 4.5 groups need a different coverage level      *
0031001011300015  *                conversion than 4.3 groups. Request by          *
0032001011300015  *                Care First through Dave A.                      *
0033001403060015  * 03/06/14 dlk - all aca medical plans have RX also              *
0034001411180015  * 11/18/14 dlk - all aca individually rated medical and composite*
0035001411180015  *                rated medical plans have RX also.               *
0036001508280015  * 08/28/15 dlk - use longer name if we have one                  *
0037001605130015  * 05/13/16 dlk - add break for exchange/shop since shop plans    *
0038001605130015  *                have a different group # we need to send a      *
0039001605130015  *                seperate record.                                *
0040001606080015  * 06/08/16 dlk - group # was added to the DW300J file so this    *
0041001606080015  *                program can now break on group # and send       *
0042001606080015  *                seperate records for each group # the member    *
0043001606080015  *                has active.                                     *
0044001708030015  * 08/03/17 dlk - remove 834 field and option to run seperate,    *
0045001708030015  *                All groups are now on 4.5 platform.             *
0046001806270015  * 06/27/18 dlk - Make Medchi members send net amount instead     *
0047001806270015  *                of billed per Carol F.                          *
004701190305      * 03/05/19 dlk - Cobra transactions will now back out the
0047021903050035  *                2% admin fee from the billed amount instead of
0047031903050035  *                using the net rate since PSF plans have net <>
0047041903050035  *                billed and we want to send tha actual billed amount
0047051903050035  *                without the 2% cobra admin fee.
004706190315      * 03/15/19 dlk - COBRA transation change again - only use
004707190315      *                (billed - 2%) for PSF carriers and manual adj, others
0048001903150015  *                are still more accurate to use net since divorced
0048011903150015  *                members do NOT get charged the 2%.
0048021903150015  *                                                                *
0049000210160015  ******************************************************************
0050001606100017 Fdw300j    iP   E           k DISK
0051000210170016 FINVSUM    IF   E           K DISK
0052000211110016 fclass     IF   E           K DISK
0053000211120016 fmember    IF   E           K DISK
0054000211120016 fdepend    IF   E           K DISK
005500150828     Fcfs100p   IF   E           K DISK                                         long names
0056000211120016 fdcovc     IF   E           K DISK
0057001606090016 f*grate     IF   E           K DISK
0058000502160016 finvdetl1  IF   E           K DISK
005900050328     Fcodesl1   IF   E           K DISK
006000050419     Faccmst    IF   E           K DISK
006100160609     F*plnmst    IF   E           K DISK    prefix(p_)
006200160609     F*carmst    IF   E           K DISK    prefix(c_)
0063000211080030 Fdbpearh   O  A E             DISK
0064000211120030 Fdbpears   O  A E             DISK
0065000211120030 Fdbpeard   O  A E             DISK
0066000211120030 Fdbpeart   O  A E             DISK
0067000211120030 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
006800021017
0069000211110056 D tna             s              3    inz('TNA')
0070000211110056 D memclass        s                   like(clclass)
0071000503280056 D wkcovtp         s                   like(mcovtp)
0072000601250056 D premwork        s                   like(idtramb)
0073001508280056 D wkmlname        s             50
0074001508280056 D wkmfname        s             50
0075001508280056 D wkdlname        s             50
0076001508280056 D wkdfname        s             50
0077001508280056 D key_ssn         s                   like(cfssn)
0078001508280056 D key_seq         s                   like(cfseq)
0079000503280056 D covlevel        s              1
0080000503280056 D holdmedcov      s              1
0081000503280056 D holdrxcov       s              1
0082000503280056 D holddencov      s              1
0083000503280056 D holdviscov      s              1
0084000211120056 D deprel          s              1
0085000211110056 DKEB              s              3    inz('KEB')
0086000211110056 Dbilldate         s              8
0087000211120056 Ddlname8          s              8
0088000511070056 Ddcovdbe          s              1
0089000211130056 Dtotbil           s              8  2
0090000211130056 Dtotpay           s              8  2
0091000211120056 Dtotrec           s              7  0
0092000211120056 Dtotgrp           s              7  0
0093000504190056 Dparallel         s              1
0094001606090056 Dholdgrp          s                   like(psgrp)
0095001606090056 Dholdsg           s                   like(pssg)
009600160609     Dplan_array       s              4A   DIM(20)
0097001606090056 Dpos              s              2  0
009800021203
0099000503280055 D                 DS
0100001606080056 D  dw3group#              1     15
0101000503280056 D** groupid               1      8
0102001606080056 D   dw3group_sg           9     12
0103000212030055 D                 DS
0104000212030056 D  bcefymd                1      8  0
0105000212030056 D  bcefyy                 1      4  0
0106000212030056 D  bcefmm                 5      6  0
0107000212030056 D  bcefdd                 7      8  0
0108000212030055 D                UDS
0109000212030056 D  LEFFDT                85     92  0
0110000211110056 D  LEFmm                 85     86
0111000211110056 D  LEFyy                 89     92
0112000310070056 D  ltype                 93     93
0113000211120053 Idw300r
011400021111     I                                          mcTRST        L2
011500021111     I                                          mcSUB#        L2
011600021112     I                                          acc#          L2
011700021111     I                                          mcssno        L1
011800160608     I                                          dw3group#     L1
011900050419
0120000504190086 C* on acct change get invoiced date and parallel flag
012100021111     c                   if        *inl2
012200100217     c                   clear                   okacct            1
012300100217     c                   clear                   parallel
0124001002170088 C     acckey        chain     accmst
012500100802
0126001708030096 C                   if        %found(accmst)
012700100217     c                   move      'Y'           okacct
012800100217     c                   movel     aprefx        parallel
012900100217     c                   add       1             totgrp
013000021113     c                   clear                   billdate
0131000211110088 C     inkey         chain     invsum
0132000211120096 C                   if        %found(invsum)
013300021113     c                   move      invdte        @datin
013400021113     c                   exsr      #dat
013500021113     c                   move      @datou        billdate
013600021111     C                   END
013700100217     C                   END
013800021111     C                   END
013900021111
0140001606080086 C* on ssn change get member info
0141001606080086 C* 6/08/16 - add group # to break to guarentee we send seperate
0142001606080086 C*           records per group #
014300100217     c                   if        *inl1 and okacct = 'Y'
014400021113
014500021113     c                   clear                   holdmedcov
014600050328     c                   clear                   holdrxcov
014700050328     c                   clear                   holddencov
014800050328     c                   clear                   holdviscov
014900160609     c                   clear                   holdgrp
015000160609     c                   clear                   holdsg
015100160513     c                   clear                   totbil
015200160513     c                   clear                   totpay
015300160609     c                   clear                   plan_array
015400060126
015500160609      * group #
015600160609     c                   movel     dw3group#     holdgrp
015700160609     c                   movel     dw3group_sg   holdsg
015800160609
0159000211110088 C     mcssno        chain     member
0160000211110096 c                   if        not %found(member)
016100021112     c   of              except    head
016200021112     c                   except    err2
016300021112     c                   goto      #end
016400021111     C                   END
016500021113
016600150828      * member name work field
016700150828     c                   clear                   wkmlname
016800150828     c                   clear                   wkmfname
016900150828     c                   movel     mlname        wkmlname
017000150828     c                   movel     mfname        wkmfname
017100150828
017200150828      * longer name overrides what is in member file
017300150828     c                   move      mcssno        key_ssn
017400150828     c                   clear                   key_seq
017500150828     C     cfskey        chain     cfs100p
017600150828     C                   if        %found(cfs100p)
017700150828     C                   if        cfslst <> *blanks
017800150828     C                   clear                   wkmlname
017900150828     C                   movel     cfslst        wkmlname
018000150828     C                   end
018100150828     C                   if        cfsfst <> *blanks
018200150828     C                   clear                   wkmfname
018300150828     C                   movel     cfsfst        wkmfname
018400150828     C                   end
018500150828     C                   end
018600150828
018700160608     c* get class for this plan (all plans should have same class)
018800021113     c                   clear                   memclass
0189000211130088 C     clskey        chain     class
0190000211130096 c                   if        %found(class)
019100021113     c                   move      clclass       memclass
019200021113     C                   end
019300021113
019400021112     C                   END
019500160513
019600021113
019700100901      * skip if missing member or acct was not selected
0198001002170096 c                   if        not %found(member) or okacct <> 'Y'
019900021112     c                   goto      #end
020000021112     C                   END
020100160513
020200160608      * get billed amounts from invdet for this plan
020300160513     c                   exsr      #getinvdet
020400160609      * save all plans this member has under this group #
020500160609     c                   exsr      #storplan
020600021111
020700160608      * get Care First coverage level
020800050328     c     plncat        chain     codesl1
020900050328     c                   if        %found(codesl1)
021000050328     c                   move      mcovtp        wkcovtp
021100050328     c                   exsr      #covlevel
021200050328
021300050328     c                   select
021400050328     c                   when      action = 'M'
021500050328     c                   move      covlevel      holdmedcov
021600141118      * all aca individually rated and composite rated medical plans have rx
021700141118     c                   if        pxacar = 'Y' or pxacar = 'C'
021800140306     c                   move      covlevel      holdrxcov
021900140306     c                   end
022000160608
022100160608     c****               exsr      #getgrp
022200050328
022300050328     c                   when      action = 'R'
022400050328     c                   move      covlevel      holdrxcov
022500160609     c****               exsr      #getgrp
022600050328
022700050328     c                   when      action = 'D'
022800050328     c                   move      covlevel      holddencov
022900160609     c****               exsr      #getgrp
023000050328
023100050328     c                   when      action = 'V'
023200050328     c                   move      covlevel      holdviscov
023300160609     c****               exsr      #getgrp
023400050328     c                   endsl
023500050328     c                   end
023600021111
023700021112     c     #end          tag
023800021112
023900100217     cL1                 if        okacct = 'Y'
024000100217     cL1                 exsr      #L1
024100100217     cL1                 end
024200100217
024300021112     cLR                 exsr      #LR
024400021113
024500050328JGE01C*****************************************************
024600050328      * find coverage level for this coverage type
024700101130JGE01 *
024800101130JGE01 * 11/30/10 - 4.5 groups translate our P2 to "D" (cfs834 =  Y)
024900101130JGE01 *            4.3 groups translate our P2 to "A" (cfs834 <> Y)
025000170803JGE01 * 08/03/17 - all groups are 4.5 now, P2 = "D"
025100101130JGE01C*****************************************************
025200050328     c     #covlevel     begsr
025300050328
025400050328     c                   clear                   covlevel
025500050328     c                   select
025600170803     c                   when      wkcovtp = 'TFA'
025700050328     c                   move      'A'           covlevel
025800050328     c                   when      wkcovtp = 'THW'
025900050328     c                   move      'B'           covlevel
026000090122     c                   when      wkcovtp = 'TIN' or wkcovtp = 'TMI'
026100050328     c                   move      'C'           covlevel
026200101130     c                   when      wkcovtp = 'TPC' or
026300170803     c                             wkcovtp = 'TP2'                              4.5 groups
026400050328     c                   move      'D'           covlevel
026500050328     c                   other
026600050328     c                   move      'O'           covlevel
026700090126     c   of              except    head
026800090126     c                   except    err3
026900050328     c                   endsl
027000050328
027100050328     c                   endsr
027200050328
027300021111JGE01C*****************************************************
027400021111JGE01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY or      *
027500021111JGE01C*                 FROM mmddyyyy TO yyyymmdd         *
027600021111JGE01C*****************************************************
027700021111JGE01C     #DAT          BEGSR
027800021111JGE01C                   MOVE      @DATIN        @MD               4 0
027900021111JGE01C                   MOVEL     @DATIN        @Y                4 0
028000021111JGE01C                   MOVEL     @MD           @DATOU            8 0
028100021111JGE01C                   MOVE      @Y            @DATOU
028200021111JGE01C                   MOVE      *ZEROS        @DATIN            8 0
028300021111JGE01C                   ENDSR
028400021111
028500050216     C**************************************************************
028600160513     C*   get invoiced amt for this ssn/plan for the effective     *
028700160609     C*   date selected in invdet (all records for this member/plan*
028800160609     C*   including the dependent billed records)                  *
028900050216     C**************************************************************
029000050216     C     #getinvdet    BEGSR
029100050216
029200050216     c     invdkey       klist
029300050216     c                   kfld                    mcssno
029400050216     c                   kfld                    lefymd
029500050216
029600050216      * Get billed amounts from invdet. INVDETL1 has selection built into
029700050216      * the LF for IDVOID = ' ', IDRC = 'KCE' & 'CCE', IDBCCC = 'D'
029800060125
0299000601250429  * COBRA invoices:
0300001903150429  * the billed amount (IDTRAMB) holds the rate plus the 2% surcharge
0301001903150429  * (when it applies - not for divorced cobra members).
0301011903150429  * The net (IDTRAM) holds the actual net rate without the 2% but PSF
0301021903150429  * plans cannot use the net since they hold the billed - psf fee.
0302001903150429  * Different logic will be needed depending on the plan carrier.
0302011903150429  * This is not perfect, a change to invdet is probably needed to
0304001903150429  * seperate the cobra surcharge.
0304011903150429  *
030500050216
030600050216     c     invdkey       setll     invdetl1
030700050216     c                   dou       %eof(invdetl1)
030800050216     c     invdkey       reade     invdetl1
030900050216     c                   if        not %eof(invdetl1) and idcvdt = lefymd
031000160513     c                             and idplan = mcplan
031100060125     c* non-cobra
031200190315       if idcob <> 'C';
031400180627      * medchi uses net rate everyone else uses billed rate
031500190315        if idtrst >= 560 and idtrst <= 562;
031600190315         totbil += idtram;
031700190315         else;
031800190315         totbil += idtramB;
031900190315        endif;
032000190315       iter;
032100190315       endif;
032101190315
032200060125     c* cobra
032201190315     c* use billed less 2% for COBRA manual adjustments
032502190315     c* 3/5/19 PSF cobra transactions will back out the 2% admin fee from
032503190315     c* the billed amount and use that number as the billed.
032504190315     c* PSF plans use the net rate as billed w/o PSF and we need to send
032505190315     c* the entire billed about less COBRA surcharge so this is the only
032506190315     c* way to come up with this number at this time.
032507190315     c* All others are still safer using the net amount as this process
032508190315     c* has done for many years since it reflects the actual billed - 2%
032509190315     c* when appropriate (not for divorced cobra members).
032510190315     c*
032511190315     c                   clear                   premwork
032512190315     C                   if        idtramb <> 0
032513190315     c                   if        idrc  = 'CMA' or
032514190315     c                             (idcar = 'PSM' or idcar = 'PSX')
032700060125     c     idtramb       div(h)    1.02          premwork
032701190315     c                   else
032702190315     c                   move      idtram        premwork
033300060125     c                   end
033302190315     c                   add       premwork      totbil
033500060125     c                   end
033501190315
033502190315     c                   end
033600050216     c                   enddo
033700050216
033800050216JGE01C                   ENDSR
0339000211120069 C**************************************************************
034000021112JGE01C*   get group # from grate                                   *
0341000211120069 C**************************************************************
034200160609JGE01C*    #getgrp       BEGSR
034300060127      * if we alreay have the group# for this member, skip
034400160609     c*                  if        holdgrp  <> *blanks
034500160609     c*                  leavesr
034600160609     c*                  end
034700060127
034800160609     c*    grkey         setll     grate
034900160609     c*                  dou       %eof(grate)
035000160609     c*    grkey         reade     grate
035100160609     c*                  if        not %eof(grate) and (lefymd >= frmdat) and
035200160609     C*                            (lefymd <= todat)
035300160609     c*                  movel     group#        holdgrp
035400160609     c*                  movel     group_sg      holdsg
035500160609     c*                  leave
035600160609     c*                  end
035700160609     c*                  enddo
035800021112
035900160609JGE01C*                  ENDSR
0360000211120069 C**************************************************************
0361000211120069 C* get dependents                                             *
0362000211120069 C**************************************************************
036300021112JGE01C     #getdep       BEGSR
036400021112
036500021112     c     mcssno        setll     depend
036600021112
036700021112     c                   dou       %eof(depend)
036800021112     c     mcssno        reade     depend
036900021112     c                   if        not %eof(depend) and dpdltd = 'A'
037000021112
037100160609      * does this dependent have a plan active with this group #?
037200160609     c                   exsr      #getdcov
037300160609     c                   if        dcovdbe <> 'Y'
037400160609     c                   clear                   dbpeardr
037500160609     c                   iter
037600160609     c                   end
037700160609
037800150828      * check for depend long name
037900150828
038000150828      * depend name work field
038100150828     c                   clear                   wkdlname
038200150828     c                   clear                   wkdfname
038300150828     c                   movel     dlname        wkdlname
038400150828     c                   movel     dfname        wkdfname
038500150828
038600150828     c                   move      mcssno        key_ssn
038700150828     c                   move      dpseq#        key_seq
038800150828
038900150828      * longer name overrides what is in depend file
039000150828     C     cfskey        chain     cfs100p
039100150828     C                   if        %found(cfs100p)
039200150828     C                   if        cfslst <> *blanks
039300150828     C                   clear                   wkdlname
039400150828     C                   movel     cfslst        wkdlname
039500150828     C                   end
039600150828     C                   if        cfsfst <> *blanks
039700150828     C                   clear                   wkdfname
039800150828     C                   movel     cfsfst        wkdfname
039900150828     C                   end
040000150828     C                   end
040100150828
040200150828
040300021112     c                   eval      pdrtype = '03'
040400160609     c                   eval      pdgrp   = holdgrp
040500050328
040600050419      * do not send family indicator for parallel groups
040700050419
040800050419     c                   if        parallel = 'Y'
040900050419     c                   clear                   pdfim
041000050419     c                   clear                   pdfir
041100050419     c                   clear                   pdfid
041200050419     c                   clear                   pdfiv
041300050419     c                   else
041400050419     c                   eval      pdfim   = holdmedcov
041500050419     c                   eval      pdfir   = holdrxcov
041600050419     c                   eval      pdfid   = holddencov
041700050419     c                   eval      pdfiv   = holdviscov
041800050419     c                   end
041900050328
042000021112     c                   move      mcssno        pdsid
042100021112     c                   move      depss#        pddid
042200021112     c                   select
042300021112     c                   when      drelcd = 'RWI'
042400021112     c                   move      'W'           deprel
042500021112     c                   when      drelcd = 'RHU'
042600021112     c                   move      'H'           deprel
042700021112     c                   when      drelcd = 'RSO'
042800021112     c                   move      'S'           deprel
042900021112     c                   when      drelcd = 'RDA'
043000021112     c                   move      'D'           deprel
043100021112     c                   other
043200021112     c                   move      'O'           deprel
043300021112     c                   endsl
043400021112     c                   eval      pdrel   = deprel
043500021112
043600150828     c                   movel     wkdlname      dlname8
043700021112     c                   if        dlname8 = 'SAME    '
0438001508280415 C                   eval      pdlname = wkmlname
043900021112     c                   else
044000150828     c                   eval      pdlname = wkdlname
044100021112     c                   end
044200021112
044300150828     c                   eval      pdfname = wkdfname
044400021112     c                   eval      pdmi    = dmi
044500021112     c                   eval      pdsex   = dsex
044600021112
044700021112     c                   move      dbirth        @datin
044800021112     c                   exsr      #dat
044900021112     c                   move      @datou        pdbirdt
045000021112
045100021223     c                   clear                   pdeffdt
045200021112
045300050328     c                   eval      pdfill1 = *blanks
045400050328     c                   eval      pdfill2 = *blanks
045500050328     c                   eval      pdfill3 = *blanks
045600021112     c                   eval      pdhold  = 'X'
045700021112
045800021112     c                   write     dbpeardr
045900021112     c                   add       1             totrec
046000021113     c                   clear                   dbpeardr
046100021112
046200021112     c                   end
046300021112
046400021112     c                   enddo
046500021112
046600021112JGE01C                   ENDSR
046700051107
0468000211120069 C**************************************************************
0469001606090069 C* get dcov - is there a dcov active with one of the mcov plans
0470001606090069 C* that make up this group #?
0471000211120069 C**************************************************************
047200051107JGE01C     #getdcov      BEGSR
047300021112
047400051107     c                   clear                   dcovdbe
047500051107     c     depkey        setll     dcovc
047600021112
047700051107     c                   dou       %eof(dcovc)
047800051107     c     depkey        reade     dcovc
047900160613     c                   if        not %eof(dcovc) and
048000160613     c                             (ccandt = 0 or ccandt > lefymd)
048100160609     c                   Eval      pos = %lookup(DVPLAN:plan_array)
048200160609     c                   if        pos <> 0
048300160609     c                   eval      dcovdbe = 'Y'
048400051107     c                   leave
048500051107     c                   end
048600160609     c                   end
048700051107     c                   enddo
048800021112
048900051107JGE01C                   ENDSR
049000160609      **********************************
049100160609      * STORE plan
049200160609      **********************************
049300160609     C     #storplan     BEGSR
049400160609
0495001606090309 C                   Z-ADD     1             X                 2 0
049600160609     C                   dow       x < 20
049700160609      * new plan
049800160609     C                   if        plan_array(x) = *blanks
049900160609     C                   MOVE      mcplan        plan_array(X)
050000160609     C                   leave
050100160609     C                   ELSE
050200160609      * existing plan
050300160609     C                   if        plan_array(x) = mcplan
050400160609     C                   leave
050500160609     C                   ELSE
050600160609      * not found plan
050700160609     C                   eval      x = x + 1
050800160609     C                   END
050900160609     C                   END
051000160609     C                   enddo
051100160609
051200160609     c                   endsr
0513000211120069 C**************************************************************
0514000211120069 C* L1 routine                                                 *
0515000211120069 C**************************************************************
051600021112     c     #l1           begsr
051700021113
051800071107      * missing member or group # - skip
051900071107
0520000711070096 c                   if        not %found(member) or
052100160609     c                             holdgrp  = *blanks
052200021113     c                   leavesr
052300021113     C                   end
052400021113
052500060127      * create subscriber record
052600021113     c                   eval      psrtype = '02'
052700160609     c                   eval      psgrp   = holdgrp
052800160609     c                   eval      pssg    = holdsg
052900021113     c                   move      mcssno        pssid
053000021113     c                   eval      psfill1 = *blanks
053100150828     c                   eval      pslname = wkmlname
053200150828     c                   eval      psfname = wkmfname
053300021113     c                   eval      psmi    = mmi
053400021113     c                   eval      pssex   = sex
053500021113     c                   move      birth         @datin
053600021113     c                   exsr      #dat
053700021113     c                   move      @datou        psbirdt
053800021223     c                   clear                   pseffdt
053900021113
054000021113     c                   eval      psclass = memclass
054100050328     c                   eval      psfim   = holdmedcov
054200050328     c                   eval      psfir   = holdrxcov
054300050328     c                   eval      psfid   = holddencov
054400050328     c                   eval      psfiv   = holdviscov
054500021113     c                   eval      psbildt = billdate
054600021113     c                   move      leffdt        pscovdt
054700021113     c                   eval      psfill2 = *blanks
054800021113     c                   eval      pshold  = 'X'
054900021113
055000160513      * billed amounts from invdet
055100021113     c                   eval      psbill  = %editc(totbil : 'P')
055200021113     c                   if        totpay >= 0
055300021113     c                   eval      pspaid  = %editc(totpay * -1 : 'P')
055400021113     c                   else
055500021113     c                   eval      pspaid  = '.00'
055600021113     c   of              except    head
055700021113     c                   except    err1
055800021113     c                   end
055900021113
056000021112     c                   write     dbpearsr
056100021112     c                   add       1             totrec
056200021113     c                   clear                   dbpearsr
056300021113
056400021113      * dependent records
056500021113     c                   exsr      #getdep
056600021113
056700021112JGE01C                   ENDSR
0568000211120069 C**************************************************************
0569000211120069 C* LR routine                                                 *
0570000211120069 C**************************************************************
057100021112     c     #LR           begsr
057200021112      * trailer rec
057300021112     c                   eval      ptrtype  = '04'
057400021112     c                   eval      ptfill   = *blanks
057500021112     c                   eval      pthold   = 'X'
057600021121     c**                 add       1             totrec
057700021112     c                   eval      pttotrec = %editc(totrec : '3')
057800021112     c                   eval      pttotgrp = %editc(totgrp : '3')
057900021112     c                   write     dbpeartr
058000021112
058100021112JGE01C                   ENDSR
0582000211110069 C**************************************************************
0583000211110069 C* first time                                                 *
0584000211110069 C**************************************************************
058500021111     c     *inzsr        begsr
058600021111     C                   TIME                    HTIME             6 0
058700021113     c                   move      htime         fulltime         14 0
058800021113     C                   movel     *date         fulltime
058900021111     c* create batch id - YYMMDDHHMM
059000021112     C                   movel     htime         HTIMEhm           4 0
059100021112     C                   MOVE      *date         @DATIN
059200021112     C                   EXSR      #DAT
059300021112     C                   MOVE      @DATOU        ud8ymd            8 0
059400021111     c                   move      ud8ymd        ud6ymd            6 0
059500021111     c                   movel     ud6ymd        batchid          10
059600021111     c                   move      htimehm       batchid
0597000211110111 C*
059800021111     C                   EXCEPT    HEAD
0599000211110111 C*
060000021111     C                   MOVE      LEFFDT        @DATIN
060100021111     C                   EXSR      #DAT
060200021111     C                   MOVE      @DATOU        LEFYMD            8 0
060300021111
060400021111     C     INKEY         KLIST
060500021111     C                   KFLD                    mctrst
060600021111     C                   KFLD                    mcsub#
060700021112     C                   KFLD                    acc#
060800021111     C                   KFLD                    lefymd
060900021111     C                   KFLD                    KEB
061000050422
061100050419     C     acckey        KLIST
061200050419     C                   KFLD                    mctrst
061300050419     C                   KFLD                    mcsub#
061400050419     C                   KFLD                    acc#
061500050419
061600021112     C     depkey        KLIST
061700021112     C                   KFLD                    mcssno
061800021112     C                   KFLD                    dpseq#
061900150828
062000150828     C     cfskey        KLIST
062100150828     C                   KFLD                    key_ssn
062200150828     C                   KFLD                    key_seq
062300021112
062400160609     C*    plnkey        KLIST
062500160609     C*                  KFLD                    mctrst
062600160609     C*                  KFLD                    mcsub#
062700160609     C*                  KFLD                    mcplan
062800021112
062900160609     C*    grkey         KLIST
063000160609     C*                  KFLD                    mctrst
063100160609     C*                  KFLD                    mcsub#
063200160609     C*                  KFLD                    mcplan
063300160609     C*                  KFLD                    mcageb
063400160609     C*                  KFLD                    mcovtp
063500021112
063600021112     C     clskey        KLIST
063700021111     C                   KFLD                    mctrst
063800021111     C                   KFLD                    mcsub#
063900021111     C                   KFLD                    mcplan
064000021111     C                   KFLD                    tna
064100051107
064200160609     C*    depplnkey     KLIST
064300160609     C*                  KFLD                    mbtrst
064400160609     C*                  KFLD                    mbsub#
064500160609     C*                  KFLD                    dvplan
064600051107
064700021111
064800021111      * create header record
064900021111
065000021111     c                   eval      phrtype = '01'
065100021111     c                   eval      phver   = '001'
065200021112     c                   movel     fulltime      phcdt
065300021111     c                   eval      phdbid  = '521200892'
065400021111     c                   eval      phdbnm  = 'GBS, INC.'
065500021111     c                   eval      phbatch = batchid
065600021112     c                   eval      phbp    = lefmm + lefyy
065700031007     c                   eval      phtype  = ltype
065800021111     c                   eval      phfill  = *blanks
065900021111     c                   eval      phhold  = 'X'
066000021111     c                   write     dbpearhr
066100021121     c**                 add       1             totrec
066200021111
066300021111     c                   endsr
0664000211120237 Oqsysprt   E            head           2 03
0665000211120239 O                                           73 '** GROUP BENEFIT SERVICE'
0666000211120241 O                                           77 'S **'
0667000211120242 O          E            head           1
0668000211120244 O                                           78 'DB PEAR ERROR REPORT'
0669000211120242 O          E            head           1
0670000211120248 O                                           24 'PROGRAM NAME: DW300'
067100021112 244 O                                           65 'FOR :'
067200021112 244 O                       LEFmm               71
067300021112 244 O                                           72 '/'
067400021112 244 O                       LEFyy               76
067500031007 244 O                                           +3 'TYPE:'
067600031007 244 O                       ltype               +1
0677000211120249 O                                          122 'PAGE :'
0678000211120250 O                       PAGE          Z    131
0679000211120242 O          E            head           1
0680000211120253 O                                           14 'RUN DATE:'
0681000211120254 O                       UDATE         Y     25
0682000211120255 O                                          122 'TIME :'
0683000211120256 O                       HTIME              131 '  :  :  '
0684000211120242 O          E            head           1
0685000211120259 O                                           24 '------------------------'
0686000211120260 O                                           48 '------------------------'
0687000211120261 O                                           72 '------------------------'
0688000211120262 O                                           96 '------------------------'
0689000211120263 O                                          120 '------------------------'
0690000211120286 O                                          132 '------------'
0691000211120242 O          E            head           1
0692000211120267 O                                           11 'SSN'
0693000211120268 O                                           21 'DATA'
0694000901260268 O                                          111 'ERROR'
0695000211120242 O          E            head           2
0696000211120259 O                                           24 '------------------------'
0697000211120260 O                                           48 '------------------------'
0698000211120261 O                                           72 '------------------------'
0699000211120262 O                                           96 '------------------------'
0700000211120263 O                                          120 '------------------------'
0701000211120286 O                                          132 '------------'
0702000211120287 O          E            err1           1
0703000211120288 O                       mcssno              11 '   -  -    '
0704000211120288 O                       totpay        p     28
0705000211120288 O                                          132 'NEGATIVE PAID AMT         '
0706000211120287 O          E            err2           1
0707000211120288 O                       mcssno              11 '   -  -    '
0708000211120288 O                                          132 'MISSING MEMBER REC        '
0709000901260287 O          E            err3           1
0710000901260288 O                       mcssno              11 '   -  -    '
0711000901260288 O                                           21 'COV:'
0712000901260288 O                       wkcovtp             24
0713000901260288 O                                           22 ' '
0714000901260288 O                                           +5 'PLAN:'
0715000901260288 O                       mcplan              +1
0716000901260288 O                                          132 'COVERAGE TYPE "O" USED    '
