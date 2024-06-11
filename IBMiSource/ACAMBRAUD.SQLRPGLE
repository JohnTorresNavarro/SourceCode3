000100140129     H NOMAIN OPTION(*NODEBUGIO) DEBUG COPYRIGHT('GBS - GROUPBENEFITSERVICES')
000200140205     H BNDDIR('ACAMBRAUD')
000300000000      *_________________________________________________________________________
000400000000      *
000500000000      *  Description:  ACA Member Audit
000600000000      *
000700140129      *  (c)Copyright 2014 by GBS, Inc.
000800000000      *
000900000000      *    Created by:  JALLEN - January 29, 2014
001000000000      *_________________________________________________________________________
001100140129     FACCMST    if   e           k Disk    extfile('F.ACCMST') usropn
001200140129     FMEMBER    if   e           k Disk    extfile('F.MEMBER') usropn
001300140129     FPLNMST    if   e           k Disk    extfile('F.PLNMST') usropn
001400140131     FDEPEND    if   e           k Disk    extfile('F.DEPEND') usropn
001500140131     FDCOVC     if   e           k Disk    extfile('F.DCOVC') usropn
001600140129     FINVBILL   if   e           k Disk
001700140129
001800140129      /define aca_mbr_audit_pr
001900140129      /define aca_mbr_audit_fields
002000140129      /define aca_mbr_audit_return
002100140129      /copy qcpysrc,acambraudp
002200140129      /undefine aca_mbr_audit_pr
002300140129      /undefine aca_mbr_audit_fields
002400140129      /undefine aca_mbr_audit_return
002500140129
002600140129      /define copy_all_protos_and_fields
002700140205      /copy qcpysrc,acasrvpgmp
002800140129      /undefine copy_all_protos_and_fields
002900140129
003000140131     D d               s              2  0
003100140129     D px              s              2  0
003200140404     D seq             s              2  0
003300140404     D mbr             s              2  0
003400140129     D idx             s              2  0
003500140212     D prorated        s              1
003600140212     D prodate         s              8  0
003700140213     D manual          s              7  2
003800140129     D prem            s              7  2
003900140205     D prem_amt        s              7  2
004000140129     D prem_dif        s              7  2
004100140205     D prem_count      s              3  0
004200140205     D prem_error      s             50
004300140131
004400140206     D dep_array       s              2  0 dim(40) inz
004500140129
004600000000      * Program status data structure
004700000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
004800140129
004900140129      *_____________________________________________________________________
005000140129      *?Function to retrieve differences in premiums
005100140129      *_____________________________________________________________________
005200140129     P #aca_mbr_audit...
005300140129     P                 b                   export
005400140714
005500140714     D mtrans          s                   like(acacct)
005600140129
005700140129      /define aca_mbr_audit_pi
005800140129      /define aca_mbr_audit_fields
005900140129      /copy qcpysrc,acambraudp
006000140129      /undefine aca_mbr_audit_pi
006100140129      /undefine aca_mbr_audit_fields
006200140129
006300140129      /free
006400140129
006500140205         clear prem_count ;
006600140205         clear prem_error ;
006700140213         clear manual ;
006800140212         clear prorated ;
006900140212         clear prodate  ;
007000140129         clear p_audit ;
007100140129         clear px ;
007200140129
007300140129         if not %open(ACCMST) ;
007400140129          open ACCMST ;
007500140129         endif ;
007600140714
007700140714         //?Did caller send in an "old acct#" indicating we should use MTRANS
007800140714         if %parms() >= 9 and p_mtrans <> *zeros ;
007900140714          mtrans = p_mtrans ;
008000140714         else ;
008100140714          clear mtrans ;
008200140714         endif ;
008300140129
008400140131         //?Account must have run invoices before
008500140129         chain (p_trs:p_sub:p_acc) ACCMST ;
008600140129         if %found ;
008700140129            If  p_eff <= ACVTDT and LINV# <> *zeros ;
008800140129            exsr mainline ;
008900140129            endif ;
009000140129         endif ;
009100140129
009200140131         exsr  exit_pgm ;
009300140129
009400140129      /end-free
009500140129
009600140129      *___________________________________________________________________
009700140129      * mainline processing
009800140129      *___________________________________________________________________
009900140129     C     mainline      Begsr
010000140129
010100140129      /free
010200140129
010300140129         if not %open(MEMBER) ;
010400140129          open MEMBER ;
010500140129         endif ;
010600140129
010700140131         //?If COBRA, skip if active cobra unless paid by emp (exception)
010800140129         chain (p_ssn) MEMBER ;
010900140129         if %found ;
011000140129            if  CEXPDT <> 0 ;
011100140129                if  p_eff < GBSCDT or p_eff > CEXPDT ;
011200140129                exsr  Get_Premium ;
011300140129                else  ;
011400140129                exsr   cobra_except ;
011500140129                endif ;
011600140129            else  ;
011700140129                exsr  Get_Premium ;
011800140129            endif ;
011900140129         else  ;
012000140129         prem_count = *zeros ;
012100140131         exsr  exit_pgm ;
012200140129         endif ;
012300140129
012400140131         exsr  exit_pgm ;
012500140129
012600140129      /end-free
012700140129
012800140129     C                   Endsr
012900140129      *___________________________________________________________________
013000140129      * Get the Premiums and total for that SSN
013100140129      *___________________________________________________________________
013200140129     C     Get_Premium   Begsr
013300140129
013400140129      /free
013500140205
013600140205         p_mbrdeparry = #get_ACA_premiums(p_trs:p_sub:p_pln:p_ssn:
013700140714                        p_eff:prem_error:prem_count:mtrans) ;
013800140129
013900140129         if prem_count = *zeros ; // no ACA prem found - error!!
014000140219
014100140219         if    %trim(prem_error) <> *blanks ;
014200140219         exsr  error_report ;
014300140227         else  ;
014400140203         exsr  add_mbr ;
014500140227         endif ;
014600140129
014700140129         else ;
014800140404
014900140404         //?Check for missing member 00 seq; add the member to the end
015000140404           If p_mbrdeparry(1).depseq <> 00;
015100140404               mbr = prem_count + 1 ;
015200140404               p_mbrdeparry(mbr).depseq = 00 ;
015300140404               p_mbrdeparry(mbr).acarate = 0 ;
015400140404               p_mbrdeparry(mbr).proacarate = 0 ;
015500140404               prem_count = mbr ;
015600140404           endif ;
015700140129
015800140131         //?Include all dependents for reverse lookup from INVBILL
015900140131           exsr add_depn ;
016000140131
016100140131         //?For each rate check for a difference
016200140129          for idx = 1 to prem_count ;
016300140205
016400140206         //?Determine if prem was prorated
016500140408       //  If      p_mbrdeparry(idx).proacarate <> 0  and
016600140408           If      p_mbrdeparry(idx).proacarate <> p_mbrdeparry(idx).acarate ;
016700140212
016800140212           prorated = 'Y' ;
016900140212           If      p_mbrdeparry(idx).canceldate <> 0 ;
017000140212           prodate = p_mbrdeparry(idx).canceldate ;
017100140212           else  ;
017200140212           prodate = p_mbrdeparry(idx).enrolldate ;
017300140212           endif ;
017400140212
017500140206           else  ;
017600140212            prorated = 'N' ;
017700140212            prodate  = 0   ;
017800140206           endif ;
017900140206
018000140206         //?FIll premium amount
018100140206           prem_amt = *zeros ;
018200140205           select ;
018300140408           When    prorated = 'Y' ;
018400140408           prem_amt = p_mbrdeparry(idx).proacarate ;
018500140205           When    p_mbrdeparry(idx).proacarate <> 0 ;
018600140205           prem_amt = p_mbrdeparry(idx).proacarate ;
018700140205           When    p_mbrdeparry(idx).acarate <> 0 ;
018800140205           prem_amt = p_mbrdeparry(idx).acarate ;
018900140205           other ;
019000140205           prem_amt = 0 ;
019100140205           endsl ;
019200140205
019300140206         //?Check for difference
019400140205           seq = p_mbrdeparry(idx).depseq ;
019500140129           exsr check_diff ;
019600140129          endfor ;
019700140129
019800140129         endif ;
019900140129
020000140129      /end-free
020100140129
020200140129     C                   Endsr
020300000000      *___________________________________________________________________
020400140129      * Check for Difference
020500000000      *___________________________________________________________________
020600140129     C     check_diff    BEGSR
020700140129
020800140129      /free
020900140129
021000140129         if not %open(INVBILL) ;
021100140129          open INVBILL ;
021200140129         endif ;
021300140129
021400140429         prem_dif = *zeros ;
021500140429         manual   = *zeros ;
021600140129
021700140131         //?Find INVBILL record for selected date
021800140129         chain (p_eff:p_ssn:seq:p_trs:p_sub:p_acc:p_pln) INVBILL ;
021900140129         if %found ;
022000140130
022100140213         //?Compare for differnce
022200140501         // prem = AIRATE ;
022300140501         //    If  prem_amt <> prem ;
022400140501         //        prem_dif = prem_amt - prem ;
022500140501         // prem = AIRATE + AIMANRATE ;
022600140501         //    If  prem_amt = prem ;
022700140501         //        prem_dif = 0 ;
022800140501         //    else  ;
022900140501         // manual = AIMANRATE ;
023000140501         //    endif ;
023100140501         //    endif ;
023200140501
023300140501         //?Compare for differnce
023400140501            prem = AIRATE + AIMANRATE ;
023500140501               If  prem_amt <> prem ;
023600140501                   prem_dif = prem_amt - prem ;
023700140501                   manual = AIMANRATE ;
023800140501               else  ;
023900140501                   prem_dif = 0 ;
024000140501               endif ;
024100140213
024200140129         else  ;
024300140205                   prem_dif = prem_amt ;
024400140129         endif ;
024500140129
024600140131         //?If differnce found return the seq and difference
024700140129         if  prem_dif <> *zeros ;
024800140129             px = px + 1 ;
024900140129             p_audit(px).aseq = seq  ;
025000140129             p_audit(px).adif = prem_dif ;
025100140213             p_audit(px).aman = manual ;
025200140212             p_audit(px).apro = prorated ;
025300140212             p_audit(px).adat = prodate  ;
025400140129         endif ;
025500140129
025600140129      /end-free
025700000000     C                   ENDSR
025800140129      *___________________________________________________________________
025900140129      * Cobra Exception
026000140129      *___________________________________________________________________
026100140129     C     cobra_except  BEGSR
026200140129
026300140129      /free
026400140129
026500140129         if not %open(PLNMST) ;
026600140129          open PLNMST ;
026700140129         endif ;
026800140129
026900140131         // Check COBRA for employee paid
027000140129         chain (p_trs:p_sub:p_pln) PLNMST ;
027100140129         if %found ;
027200140129            if  %trim(SFADM) = 'Y' ;
027300140129                exsr  Get_Premium ;
027400140129            endif ;
027500140129         endif ;
027600140129
027700140129      /end-free
027800140129     C                   ENDSR
027900140203      *___________________________________________________________________
028000140203      * Add Member
028100140203      *___________________________________________________________________
028200140203     C     add_mbr       BEGSR
028300140203
028400140203      /free
028500140203
028600140203         //?Include member for reverse lookup from INVBILL
028700140203               idx = 1 ;
028800140205               p_mbrdeparry(idx).depseq = 00 ;
028900140205               p_mbrdeparry(idx).acarate = 0 ;
029000140205               p_mbrdeparry(idx).proacarate = 0 ;
029100140203               prem_count = idx ;
029200140203
029300140203         //?Include all dependents for reverse lookup from INVBILL
029400140203           exsr add_depn ;
029500140203
029600140203         //?For each rate check for a difference
029700140203          for idx = 1 to prem_count ;
029800140212           prorated = ' ' ;
029900140205           seq = p_mbrdeparry(idx).depseq ;
030000140207           prem_amt = *zeros ;
030100140203           exsr check_diff ;
030200140203          endfor ;
030300140203
030400140203      /end-free
030500140203     C                   ENDSR
030600140203
030700140131      *___________________________________________________________________
030800140131      * Add Missing Dependents
030900140131      *___________________________________________________________________
031000140131     C     add_depn      BEGSR
031100140131
031200140131      /free
031300140131
031400140131         clear   dep_array ;
031500140131         d = 0 ;
031600140131
031700140131         //?For each existing depn add to array
031800140131          for idx = 1 to prem_count ;
031900140205            If p_mbrdeparry(idx).depseq <> 0 ;
032000140131               d = d + 1 ;
032100140205               dep_array(d) = p_mbrdeparry(idx).depseq ;
032200140131            endif ;
032300140131          endfor ;
032400140131
032500140131         if not %open(DEPEND) ;
032600140131          open DEPEND ;
032700140131         endif ;
032800140131
032900140131         if not %open(DCOVC) ;
033000140131          open DCOVC ;
033100140131         endif ;
033200140131
033300140131         //?Fill prem array with missing dependents
033400140131              idx = prem_count ;
033500140131
033600140131         Setll (p_ssn) DEPEND ;
033700140131          reade (p_ssn) DEPEND ;
033800140131           dow not %eof ;
033900140131
034000140131          chain (p_ssn:dpseq#) DCOVC ;
034100140131           if %found ;
034200140131
034300140131              if %lookup(dpseq#:dep_array) = 0 ;
034400140131               idx = idx +1 ;
034500140205               p_mbrdeparry(idx).depseq = dpseq# ;
034600140205               p_mbrdeparry(idx).acarate = 0 ;
034700140205               p_mbrdeparry(idx).proacarate = 0 ;
034800140131              endif ;
034900140131
035000140131           endif ;
035100140131
035200140131          reade (p_ssn) DEPEND ;
035300140131           enddo ;
035400140131
035500140131        //?bump the prem count to match new size
035600140131       prem_count = idx ;
035700140131
035800140131      /end-free
035900140131
036000140131     C                   ENDSR
036100140219      *___________________________________________________________________
036200140219      * Error Report
036300140219      *___________________________________________________________________
036400140219     C     error_report  BEGSR
036500140219
036600140219      * If run interactive, submit audit error interactive
036700140306     C                   If        %trim(WQJOBN) <> 'ACA_AUDIT'   and
036800140306     C                             %trim(WQJOBN) <> 'RBACA_AUDI'
036900140219     C                   Call      'AUDERRSBMI'
037000140219     C                   Parm                    WQJOBN
037100140219     C                   Parm                    WQJOB#
037200140219     C                   End
037300140219
037400140219     C                   ENDSR
037500140131      *___________________________________________________________________
037600140131      * Close the files and return
037700140131      *___________________________________________________________________
037800140131     C     exit_pgm      BEGSR
037900140131
038000140131      /free
038100140131
038200140131         if %open(ACCMST) ;
038300140131          close ACCMST ;
038400140131         endif ;
038500140131
038600140131         if %open(MEMBER) ;
038700140131          close MEMBER ;
038800140131         endif ;
038900140131
039000140131         if %open(INVBILL) ;
039100140131          close INVBILL ;
039200140131         endif ;
039300140131
039400140131         if %open(PLNMST) ;
039500140131          close PLNMST ;
039600140131         endif ;
039700140131
039800140131         if %open(DEPEND) ;
039900140131          close DEPEND ;
040000140131         endif ;
040100140131
040200140131         if %open(DCOVC) ;
040300140131          close DCOVC ;
040400140131         endif ;
040500140218
040600140306         if %trim(WQJOBN) <> 'ACA_AUDIT'   and
040700140306            %trim(WQJOBN) <> 'RBACA_AUDI' ;
040800140218         #aca_closesrv() ;
040900140218         endif ;
041000140218
041100140218         prem_count = px ;
041200140218         return p_audit ;
041300140131
041400140131      /end-free
041500140131
041600140131     C                   ENDSR
041700140131      *___________________________________________________________________
041800140131
041900140129     P #aca_mbr_audit  e
