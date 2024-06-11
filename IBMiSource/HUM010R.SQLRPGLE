000100130826     Hoption(*nodebugio) debug dftactgrp(*no) actgrp(*caller)
000200130815    ? *_________________________________________________________________________
000300130815    ? *
000400130815      *  Program:      HUM010R
000500130815    ? *  Description:  Create export file for carrier Humana
000600130816    ? *  Written by:   Debora Bond
000700130820    ? *  Date Written: 08/20/2013
000800130815    ? *
000900130815    ? *  (c)Copyright 2009 by GBS, Inc.
001000130815    ? *  This document contains restricted materials of GBS,Inc.
001100130815    ? *
001200130815    ? *_________________________________________________________________________
001300130815    ? *  Modifications:
001400140218      * 02/18/2014 DPB  Per Humana email, term date should now be EOM
001500140218      *                 (except for same day terms)
001600160922
001700140320      * 03/20/2014 DPB  Per Humana email, federal Cobra field should be 'C'
001800160922
001900150521      * 05/21/2015 JT   Completed various things that were missing. Missing
002000150521      *                 things came on email from Humana.
002100160922
002200160922      * 09/22/2016 JT   Corrected term date issue.
002300170630
002400170630      * 06/30/2017 JT   Harcoded 'X' on ttranstype field.
002500200617
002600200617      * 06/17/2020 JT   Blanked out phone# when = 000-000-0000
002700230427
002800230602      * 04/27/2023 JA   Fix 111-11 SSN Logic - J111
002900230602      * 06/02/2023 JA   Fix dep SSN 0 logic.  Can not be 0 or blank.
003000230602      *                 If zero, then MBSSNO, even on depns
003100230710      * 07/10/2023 JA   Get cov type code at depen level (HUM011R)
003200230602
003300230602      * WARNING:  Issues may be caused by a missing MEMMEM record.
003400230602      *           Please check that first.   JA 06.02.2023
003500230602
003600230602      * WARNING:  Issues may be caused by a missing carplnp record.
003700230602      *           Or in this case the car plan id was entered on the
003800230602      *           wrong plan.
003900200617    ? *_________________________________________________________________________
004000130815
004100130820     fcarxptp   if   e           K disk
004200130820     fcaraccp   if   e           K disk
004300130820     fcarplnp   if   e           K disk
004400130816
004500130820     fcarunique if   e           K disk
004600130820     fplnunique if   e           K disk
004700130820     facmunique if   e           K disk
004800130820
004900230601     fmemac#1   if   e           K disk    extfile('QS36F/F.MEMAC#1')
005000230601     fdepndc    if   e           K disk    extfile('QS36F/F.DEPNDC')
005100230601     fdepend    if   e           K disk    extfile('QS36F/F.DEPEND') prefix(d_)
005200230427     f                                     rename(DEPENR:DEP111)
005300230427     fplnauxl   if   e           K disk
005400230427     fmemmem    if   e           K disk
005500230601     fmember    if   e           K disk    extfile('QS36F/F.MEMBER')
005600230531     f                                     rename(MEMBR:MEM111R)
005700230602
005800230602     fhumdetailfif   e           K disk    rename(humdetailr:humdr) prefix(h_)
005900130816
006000150701     Fhumplndiv1if   e           k disk
006100170508     Fhumana_trkuf a e           k disk
006200130821     fhumdetail o    e             disk
006300130821     fhumtrailr o    e             disk
006400130826     Fhum010wf  o    e             disk
006500130821
006600130826      *?External DS - for Humana layouts
006700130821     d humdetail_x   e ds                  extname(humdetail) inz
006800150604     d  volumeb             2801   2811
006900150603     d  volume              2812   2822
007000150604     d  voleffdat           2823   2832
007100150604     d  volenddat           2833   2842
007200150603
007300130821     d humtrailr_x   e ds                  extname(humtrailr) inz
007400130826
007500130826      *?External DS - for SQL fetch
007600130823     D mbr_coverage  e ds                  extname('F.MCOV') inz
007700130823     D dep_coverage  e ds                  extname('F.DCOV') inz
007800130821
007900130821      *?arrays - used for xlating our codes to Humana codes
008000130821     d gbs_cov_code    s                   like(mcovtp) dim(11) ctdata
008100130823     d hum_cov_code    s                   like(mcovtp) alt(gbs_cov_code)
008200130821     d                                     dim(%elem(gbs_cov_code))
008300130821
008400130821     d gbs_rel_code    s                   like(drelcd) dim(11) ctdata
008500130823     d hum_rel_code    s                   like(drelcd) alt(gbs_rel_code)
008600130821     d                                     dim(%elem(gbs_rel_code))
008700130823
008800130826      *?Below variables are used to process "like" coverage types together
008900130826     D grp_like_covg   ds                  inz
009000221206     D  dental_plans                       like(carplnp_ds) dim(9)
009100130826     D  vision_plans                       like(carplnp_ds)
009200130823     D                                     dim(%elem(dental_plans))
009300150513     D  life_plans                         like(carplnp_ds)
009400150513     D                                     dim(%elem(dental_plans))
009500150513     D  vlife_plans                        like(carplnp_ds)
009600150513     D                                     dim(%elem(dental_plans))
009700130826     D  dental_count                       like(x)
009800130826     D  vision_count                       like(x)
009900150513     D  life_count                         like(x)
010000150513     D  vlife_count                        like(x)
010100150513
010200130826     d carplnp_ds    e ds                  extname(carplnp)
010300130826     D variable_plan   s                   like(carplnp_ds) based(plan_ptr)
010400130823     D                                     dim(%elem(dental_plans))
010500130821
010600130822      *?stand-alone fields
010700130823     D no_covg_found   s               n   inz(*off)
010800130823     D sql_stmt        s            512
010900130823     D error_msg       s             90
011000130819     D valid_carrier   s               n   inz(*off)
011100150513     D cov_type_count  s              1  0 inz(4)
011200150513     D nbr_term_xmt    s              2  0 inz(2)
011300130823     D x               s              2  0
011400130823     D y               s                   like(x)
011500130823     D variable_count  s                   like(x)
011600130819     D valid_acct      s                   like(valid_carrier) inz(*off)
011700130819     D valid_plan      s                   like(valid_carrier) inz(*off)
011800130819     D got_mbr_rcd     s                   like(valid_carrier) inz(*off)
011900140218     D work_date       s               d
012000150521     D term_dt_limit   s               d
012100130823     D term_dt_limit2  s               d
012200150617     D term_dt_limit3  s               d
012300150521     D trx_dt          s               d   inz(D'2015-01-01')
012400150624     D hou_aut_date    s               d   inz(D'2013-11-01')
012500150715     D default_date    s               d   inz(D'2000-01-01')
012600150715     D cat_date        s               d   inz(D'2015-08-01')
012700150604     D volume11        s             11  0
012800150604     D volume112       s             11  2
012900150604     D volume112b      s             11  2
013000150604     D salary112       s             11  2
013100150701     D entrystate      s              2
013200160823     D diff_months     s              2  0
013300230531     D iterYN          s              1
013400230531     D Flg111          s              1
013500230531     D SSN111          s              9s 0
013600130815
013700130819     D carrier_ds      ds
013800130819     D  cxcaid1
013900130819     D  cxcaid2
014000130819     D  cxcaid3
014100130819     D  cxcaid4
014200130819     D  cxcaid5
014300130819     D  cxcaid6
014400130819     D  cxcaid7
014500130819     D  cxcaid8
014600130819     D  cxcaid9
014700130819     D  cxcaida
014800130819     D carrier_array                       like(cxcaid1) overlay(carrier_ds)
014900130819     D                                     dim(10)
015000130819
015100130826      *?Prototypes
015200130826     D get_plan_data   pr
015300130826     D  plan                               like(dvplan) const
015400130826
015500130826     D chk_term_file   pr              n
015600130826     D  cancel_date                        like(candt) const
015700130826     D  dseq#                              like(hseqnbr) const
015800130826     D  hlineofcov                         like(hlineofcov) const
015900130826
016000130826     C     *entry        plist
016100130826     C                   parm                    cxuniq
016200130826     C                   parm                    error_msg
016300140218
016400130815      /free
016500130815
016600130826       //?------------------------------------------------------------------
016700130826    ?  // Mainline routine
016800130826       //?------------------------------------------------------------------
016900130815
017000130819         exsr validate_export_setup ;
017100130819
017200130819    ?    // No errors found with setup data...continue...
017300130819         if error_msg = *blanks ;
017400130819          exsr process_export_id ;
017500130819         endif ;
017600130819
017700130820         exsr write_trailer ;
017800130819         exsr end_pgm ;
017900130815
018000130823       //?------------------------------------------------------------------
018100130819    ?  // validate_export_setup: Validate export ID, carriers and plans
018200130823       //?------------------------------------------------------------------
018300130819         begsr validate_export_setup ;
018400130819
018500130819    ?     // Export ID must exist in Export Control master file
018600130819          chain cxuniq carxptp ;
018700130819          if not %found (carxptp) ;
018800130819           error_msg = 'Control ID ' + %trim(cxuniq) + ' not found in +
018900130819            CARXPTP control file.  Job terminated abnormally.' ;
019000130819           leavesr ;
019100130819          endif ;
019200130819
019300130819    ?     // Validate each carrier ID from export control record
019400130819          for x = 1 to %elem(carrier_array) ;
019500130819           if carrier_array(x) <> *blanks ;
019600130819            setll carrier_array(x) carunique ;
019700130819            if not %equal(carunique) ;
019800130819             error_msg = 'Carrier ID ' + %trim(carrier_array(x)) + ' not +
019900130819             found.  Job terminated abnormally.' ;
020000130819             leavesr ;
020100130819            else ;
020200130819             if valid_carrier <> *on ; // we must have at least ONE valid
020300130819              valid_carrier = *on ;    // carrier...
020400130819             endif ;
020500130819            endif ;
020600130819           endif ;
020700130819          endfor ;
020800130819
020900130819    ?     // Validate each account from carrier export record
021000130819          setll (cxuniq) caraccp ;
021100130819          dou %eof (caraccp) ;
021200130819           reade cxuniq caraccp ;
021300130819
021400130819           if %eof(caraccp) ;
021500130819            leave ;
021600130819           endif ;
021700130819
021800130819           setll (catrst:casub#:caacct) acmunique ;
021900130819           if not %equal(acmunique) ;
022000130819            error_msg = 'Account ID ' + %editc(catrst:'X') + '-' +
022100130819            %editc(casub#:'X') + '-' + %editc(caacct:'X') + ' not found. +
022200130819              Job terminated abnormally.' ;
022300130819            leavesr ;
022400130819           else ;
022500130819            if valid_acct <> *on ; // we must have at least ONE valid
022600130819             valid_acct = *on ;    // account...
022700130819            endif ;
022800130819           endif ;
022900130819
023000130819          enddo ;
023100130819
023200130819    ?     // Validate plans from CARPLNP
023300130819          setll (cxuniq) carplnp ;
023400130819          dou %eof (carplnp) ;
023500130819           reade cxuniq carplnp ;
023600130819
023700130819           if %eof(carplnp) ;
023800130819            leave ;
023900130819           endif ;
024000130819
024100130819           setll (cptrst:cpsub#:cpplan) plnunique ;
024200130819           if not %equal(plnunique) ;
024300130819            error_msg = 'Account ID ' + %editc(cptrst:'X') + '-' +
024400130819            %editc(cpsub#:'X') + '-' + %editc(cpacct:'X') + ' plan ID ' +
024500130819            cpplan + ' not found.  Job terminated abnormally.' ;
024600130819            leavesr ;
024700130819           else ;
024800130819            if valid_plan <> *on ; // we must have at least ONE valid
024900130819             valid_plan = *on ;    // plan...
025000130819            endif ;
025100130819           endif ;
025200130819
025300130819          enddo ;
025400130819
025500130819    ?     // Nothing invalid yet - but let's see if we actually HAVE any
025600130819    ?     // carriers or accounts or plans attached to this export id.
025700130819          if valid_carrier = *off ;
025800130819           error_msg = 'This Export Control ID does not contain any +
025900130819            carriers; therefore, job terminated abnormally.' ;
026000130819          elseif valid_acct = *off ;
026100130819           error_msg = 'This Export Control ID does not contain any +
026200130819            accounts; therefore, job terminated abnormally.' ;
026300130819          elseif valid_plan = *off ;
026400130819           error_msg = 'This Export Control ID does not contain any +
026500130819            plans; therefore, job terminated abnormally.' ;
026600130819          endif ;
026700130819
026800130819         endsr ;
026900130819
027000130823       //?------------------------------------------------------------------
027100130819    ?  // process_export_id: Spin through each account that is part of this
027200130819    ?  //                    export ID and process all plans for that acct
027300130823       //?------------------------------------------------------------------
027400130819         begsr process_export_id ;
027500130819
027600130826          //?Process each account from carrier export record
027700130819          setll (cxuniq) caraccp ;
027800130819          dou %eof (caraccp) ;
027900130819           reade cxuniq caraccp ;
028000130819
028100130819           if %eof(caraccp) ;
028200130819            leave ;
028300130819           endif ;
028400130819
028500130826           //?If export flag not set - skip this account
028600171219           exsr checkStatus;
028700171219           if iterYN = 'Y';
028800130819            iter ;
028900130819           endif ;
029000130822
029100130826           //?soft-coded value = # of times carrier wants to receive terms
029200130822           monitor ;
029300130822            nbr_term_xmt = %int(cacid7) ;
029400130822           on-error ;
029500130822           endmon ;
029600130819
029700130826           //?Get account master record as we need various values from it
029800130819           chain (catrst:casub#:caacct) acmunique ;
029900130819
030000140212           //?set one-time values in Humana export file:  soft-coded values
030100130826           //?that are effectively header fields
030200130819           layoutname = cacid3 ;
030300130819           lineofbus = cacid4 ;
030400130819           adminnumbr = %int(cacid2) ;
030500130820           tadminnbr = adminnumbr ; // trailer field needs same value
030600130819           transtype = cacid5 ;  // header trans type
030700130819           groupid = cacid1 ;
030800130819
030900130826           //?Now process all plans for this trust/sub/acct
031000130819           exsr process_plan ;
031100130819
031200130819          enddo ;
031300130819
031400130819         endsr ;
031500130819
031600130823       //?------------------------------------------------------------------
031700130823    ?  // Process_plan: Process all plans for ONE account.  We need to group
031800130823    ?  //               plans by benefit category - in other words all dental
031900130823    ?  //               needs to be processed together, then vision, etc...
032000130826    ?  //               so I am loading arrays by benefit category.
032100130823       //?------------------------------------------------------------------
032200130819         begsr process_plan ;
032300130819
032400130826          reset grp_like_covg ; // reset DS and assoc work fields
032500130826
032600130819          setll (cxuniq:catrst:casub#:caacct) carplnp ;
032700130819          dou %eof (carplnp) ;
032800130819           reade (cxuniq:catrst:casub#:caacct) carplnp ;
032900130819
033000130819           if %eof(carplnp) ;
033100130819            leave ;
033200130819           endif ;
033300130819
033400130826           //?Using arrays - group "like" plans together (dental, vision)
033500130823           select ;
033600130823            when %subst(cpcid1:1:2) = '03' ; // dental
033700130823             dental_count += 1 ;
033800130823             dental_plans(dental_count) = carplnp_ds ;
033900130823            when %subst(cpcid1:1:2) = '60' ; // vision
034000130823             vision_count += 1 ;
034100130823             vision_plans(vision_count) = carplnp_ds ;
034200150513            when %subst(cpcid1:1:2) = '05' ; // life
034300150513             life_count += 1 ;
034400150513             life_plans(life_count) = carplnp_ds ;
034500150513            when %subst(cpcid1:1:2) = '11' ; // voluntary life
034600150513             vlife_count += 1 ;
034700150513             vlife_plans(vlife_count) = carplnp_ds ;
034800130823            endsl ;
034900130823
035000130823          enddo ;
035100130823
035200130826          //?process subscribers that are part of this account
035300130823          exsr process_subscriber ;
035400130819
035500130819         endsr ;
035600130819
035700130823       //?------------------------------------------------------------------
035800130821    ?  // Process_subscriber:
035900130823       //?------------------------------------------------------------------
036000130819         begsr process_subscriber ;
036100130823
036200130823          setll (catrst:casub#:caacct) memac#1 ;
036300130823          if not %equal(memac#1) ; // no subscribers for this trust/sub/acct
036400130823           leavesr ;
036500130823          endif ;
036600130819
036700130823          dou %eof (memac#1) ;
036800130823           reade (catrst:casub#:caacct) memac#1 ;
036900130819
037000130823           // no more subscribers for this trust/sub/acct...
037100130823           if %eof(memac#1) ;
037200130819            leave ;
037300130819           endif ;
037400230706
037500230710        //?TESTING - add SSN to skip all others...
037600230710        //  if mbssno <> 217982139 and mbssno <> 111112139;
037700230710        //  iter;
037800230710        //  endif ;
037900130823
038000130823           //?Currently we handle 2 types of coverage for Humana: vision &
038100130823           //?dental. Execute the below loop twice (once for each coverage).
038200130823           //?Use a pointer to set the address of array "variable_plan" to
038300130823           //?the respective value (vision or dental)...
038400130826           for y = 1 to cov_type_count ;
038500130823
038600150604            volume = ' ';
038700150604            volumeb = ' ';
038800150513            if y = 1 ;
038900130823             if dental_count = *zeros ;
039000130823              iter ;
039100130823             endif ;
039200130826             hlineofcov = '03' ;
039300130823             plan_ptr = %addr(dental_plans) ;
039400130823             variable_count = dental_count ;
039500150513            endif;
039600150513
039700150513            if y = 2 ;
039800150513             if vision_count = *zeros ;
039900150513              iter ;
040000150513             endif ;
040100150513             hlineofcov = '60' ;
040200150513             plan_ptr = %addr(vision_plans) ;
040300150513             variable_count = vision_count ;
040400150513            endif;
040500130823
040600150513            if y = 3 ;
040700150513             if life_count = *zeros ;
040800150513              iter ;
040900150513             endif ;
041000150513             hlineofcov = '05' ;
041100150604
041200150604             volume = ' ';
041300150604             volumeb = ' ';
041400150603              if benamt > 0;
041500150604               volume112 = benamt;
041600150604                volume = %editc(volume112:'X');
041700150604                volume112b = mcorgben;
041800150604               volumeb = %editc(volume112b:'X');
041900150603              endif;
042000150604
042100150604              monitor ;
042200150604               voleffdat = %char(%date(enrldt):*iso) ;
042300150604              on-error ;
042400150604               voleffdat = *blanks ;
042500150604              endmon ;
042600150604
042700150604              monitor ;
042800150604               volenddat = %char(%date(candt):*iso) ;
042900150604              on-error ;
043000150604               volenddat = *blanks ;
043100150604              endmon ;
043200150604
043300150513             plan_ptr = %addr(life_plans) ;
043400150513             variable_count = life_count ;
043500150513            endif;
043600150513
043700150513            if y = 4 ;
043800150513             if vlife_count = *zeros ;
043900150513              iter ;
044000150513             endif ;
044100150513             hlineofcov = '11' ;
044200150604
044300150604             //hsalary = ' ' ;
044400150604             //volume = ' ';
044500150604             //volumeb = ' ';
044600150604             // if benamt > 0;
044700150604             //  volume112 = benamt;
044800150604             //   volume = %editc(volume112:'X');
044900150604             //   volume112b = mcorgben;
045000150604             //  volumeb = %editc(volume112b:'X');
045100150604             // endif;
045200150604
045300150604             // monitor ;
045400150604             //  voleffdat = %char(%date(enrldt):*iso) ;
045500150604             // on-error ;
045600150604             //  voleffdat = *blanks ;
045700150604             // endmon ;
045800150604
045900150604             //monitor ;
046000150604             //  volenddat = %char(%date(candt):*iso) ;
046100150604             // on-error ;
046200150604             //  volenddat = *blanks ;
046300150604             // endmon ;
046400150604
046500150604              //if salary > 0 ;
046600150604              // salary112 = salary;
046700150604              // hsalary = %editc(salary112:'X');
046800150604              //endif ;
046900150604
047000150513             plan_ptr = %addr(vlife_plans) ;
047100150513             variable_count = vlife_count ;
047200150513            endif;
047300150513
047400130823            exsr prc_sqlstmt_for_mcov ;
047500130826            if no_covg_found = *on ; // no coverage for member
047600130823             iter ;
047700130823            endif ;
047800130823
047900130823            // if coverage cancelled - see if we have xmt'd already...
048000130823            if candt <> *zeros ;
048100130826             if chk_term_file(candt:*zeros:hlineofcov) = *off ;
048200130823              iter ;
048300130823             endif ;
048400130823            endif ;
048500130822
048600150521            //?Do not send member if coverage is waved (effective date = term date)...
048700150521            if termdt = enrldt ;
048800150521             iter ;
048900150521            endif ;
049000150521
049100130823            //?Do not send member if term date is greater than 60 days...
049200130823            monitor ;
049300130823             term_dt_limit2 = %date(candt) ;
049400130823             if term_dt_limit2 < (%date() - %days(60)) ;
049500130823              iter ;
049600130823             endif ;
049700130823            on-error ;
049800130823            endmon ;
049900130823
050000130823            //?Do not send member if term date was last year...
050100130823            monitor ;
050200150521             term_dt_limit = %date(termdt) ;
050300150521             if term_dt_limit < trx_dt ;
050400150521              iter ;
050500150521             endif ;
050600150521            on-error ;
050700150521            endmon ;
050800130823
050900130823            exsr set_subscriber_values ;
051000130821
051100150521            //?New Cobra field mandate...
051200150513            exsr check_if_cobra ;
051300150624
051400150624            //?Check dates for "Housing Authority"...
051500150624            exsr check_ha ;
051600150604
051700150701            //?Check account for division ;
051800150701            entrystate = state ;
051900150701            exsr check_account_div ;
052000150701
052100150715            //?Check to see account effective dates (forced)...
052200150715            exsr check_effective_date;
052300230602
052400230602            chain (subscriber:mbrid:mbrfirstnm:mbrdob:benefitid)  humdetailf;
052500230602            if not %found(humdetailf);
052600130823            write humdetailr ;
052700130823            outfield = humdetail_x ;
052800130826            write hum010wfr ;
052900130823            filercdcnt += 1 ;
053000230602            endif;
053100130819
053200130823           endfor ;
053300130823
053400130826           exsr process_dependents ;
053500130826
053600130819          enddo ;
053700130819
053800130819         endsr ;
053900130819
054000171219       //?------------------------------------------------------------------
054100171219    ?  // check status;
054200171219       //?------------------------------------------------------------------
054300171219         begsr checkStatus;
054400171219
054500171219          iterYN = 'N';
054600171219
054700190114          //castatus = 'N';
054800190114          //if catrst = 590 and casub# = 1 and caacct = 0024;
054900190114          // castatus = 'Y';
055000190114          //endif;
055100190110
055200181107          if castatus = 'N';
055300171219           iterYN = 'Y';
055400171219          endif;
055500171219
055600171219         endsr;
055700130823       //?------------------------------------------------------------------
055800130819    ?  // set_subscriber_values:
055900130823       //?------------------------------------------------------------------
056000130819         begsr set_subscriber_values ;
056100130819
056200130826          get_plan_data(mcplan) ;
056300130823
056400130819          subscriber = %editc(mbssno:'X') ;
056500130819          subscrissn = subscriber ;
056600130819          mbrid = subscriber ;
056700130819          mbrfirstnm = mfname ;
056800130819          mbrlastnam = mlname ;
056900130819          mbrmidname = mmi ;
057000130820          mbrssn = mbrid ;
057100230427
057200230531         //  J111
057300230531            if %subst(fill66:66:1) = 'Y';
057400230531            flg111 = %subst(fill66:66:1);
057500230531            SSN111 = mbssno;
057600230531            Check_Mem_111();
057700230531            mbssno = SSN111;
057800230531            else;
057900230531            flg111 = *blanks;
058000230531            endif;
058100130820
058200130819          monitor ;
058300130819           mbrdob = %char(%date(birth):*iso) ;
058400130819          on-error ;
058500130819           mbrdob = *blanks ;
058600130819          endmon ;
058700130820
058800130819          mbrhomephn = %editc(area:'X') + '-' + %subst(%editc(phone:'X'):1: 3) +
058900130819                       '-' + %subst(%editc(phone:'X'):4:4) ;
059000200617          if mbrhomephn = '000-000-0000';
059100200617           mbrhomephn = ' ';
059200200617          endif;
059300200617
059400130819          mbrhomadr1 = addr1 ;
059500130819          mbrhomadr2 = addr2 ;
059600130819          mbrhomcity = city ;
059700130819          mbrhomstat = state ;
059800130819          mbrhomzip = %subst(%editc(zip:'X'):1:5) ;
059900130819          mbrhomzip4 = %subst(%editc(zip:'X'):6:4) ;
060000130820
060100130819          if mardt <> *zeros ;
060200130819           mbrmarstat = 'M' ;
060300130819          else ;
060400130819           mbrmarstat = 'S' ;
060500130819          endif ;
060600130819          mbrgender = sex ;
060700130819
060800130819          monitor ;
060900130821           dateofelig = %char(%date(enrldt):*iso) ;
061000130819          on-error ;
061100130819           dateofelig = *blanks ;
061200130819          endmon ;
061300130819
061400140218          //?as of 10/17/13 Humana wants term date = last day of term month
061500150521          //?Humana now wants different term dates for different groups
061600130819          monitor ;
061700150603           work_date = %date(termdt) ;
061800150603           if termdt <> enrldt ;
061900150603            if %subdt(work_date:*d) = 01 ;
062000150603             work_date -= %days(1) ;
062100150603            else ;
062200150603             work_date = work_date - %days(%subdt(work_date:*days) - 1) +
062300150603                         %months(1) - %days(1) ;
062400150603            endif ;
062500150603           endif ;
062600150603           dateofterm = %char(work_date:*iso) ;
062700150603          on-error ;
062800150603           dateofterm = *blanks ;
062900150603          endmon ;
063000130820
063100130826          //?translate our coverage type codes to Humana's codes
063200130904          x = %lookup(mcovtp:gbs_cov_code) ;
063300130820          if x > *zeros ;
063400130820           covtypecod = hum_cov_code(x) ;
063500130820          else ;
063600130820           covtypecod = '01' ;
063700130820          endif ;
063800130819
063900130821          exsr set_cobra_fields ;
064000130821
064100130826          //?set relationship = '00' as this is the subscriber
064200130821          reltosubsr = '00' ;
064300130820
064400130826          //?subscriber date of hire (employment date)
064500130821          monitor ;
064600130821           dateofhire = %char(%date(empdt):*iso) ;
064700130821          on-error ;
064800130821           dateofhire = *blanks ;
064900130821          endmon ;
065000130823
065100130826          //?benefit effective date and benefit end date
065200130823          monitor ;
065300130823           beneffdate = %char(%date(enrldt):*iso) ;
065400130823          on-error ;
065500130823           beneffdate = *blanks ;
065600130823          endmon ;
065700150603
065800150603          monitor ;
065900150603          // bentrmdate = %char(%date(candt):*iso) ;
066000150603          //on-error ;
066100150603          // bentrmdate = *blanks ;
066200150603          //endmon ;
066300150603
066400150603           work_date = %date(candt) ;
066500150603           chain (mctrst:mcsub#:acc#:mcplan) plnauxl ;
066600150603            if %found ;
066700150617
066800150617             term_dt_limit3 = %date(candt) ;
066900150618             if term_dt_limit3 >= (%date() - %days(60)) ;
067000150603
067100150603             select ;
067200150603             when pxtrmc = 'TAD' ; // Day of term...
067300150603              bentrmdate = %char(work_date:*iso) ;
067400150603             when pxtrmc = 'TEM' ; /// End of month term...
067500160922              //work_date = work_date - %days(%subdt(work_date:*days) - 1) +
067600160922              //            %months(1) - %days(1) ;
067700160922              //work_date = work_date - %months(1) ;
067800160922              work_date = work_date - %days(1);
067900150603              bentrmdate = %char(work_date:*iso) ;
068000150603             endsl ;
068100150603
068200150617             endif ;
068300150603            endif ;
068400150603
068500150603          on-error ;
068600150603           bentrmdate = *blanks ;
068700150603          endmon ;
068800150603
068900150512          monitor ;
069000150512           cateffdate = %char(%date(denrdt):*iso) ;
069100150512          on-error ;
069200150512           cateffdate = *blanks ;
069300150512          endmon ;
069400130823          coveffdate = beneffdate ;
069500130823          covtrmdate = bentrmdate ;
069600150512          cateffdate = beneffdate ;
069700130821
069800130821          empstscode = 'FT' ;
069900130821
070000150604          //?Get additional values
070100150604          exsr get_additional ;
070200150604
070300130819         endsr ;
070400130819
070500130823       //?------------------------------------------------------------------
070600130826    ?  // Process_dependents:
070700130823       //?------------------------------------------------------------------
070800130826         begsr process_dependents ;
070900130821
071000130826          //?get all dependents for this subscriber...
071100130821          setll mbssno depndc ;
071200130821          dou %eof (depndc) ;
071300130821           reade mbssno depndc ;
071400130821
071500130821           if %eof(depndc) ;
071600130821            leave ;
071700130821           endif ;
071800130821
071900130826           //?Currently we handle 2 types of coverage for Humana: vision &
072000130826           //?dental. Execute the below loop twice (once for each coverage).
072100130826           //?Use a pointer to set the address of array "variable_plan" to
072200130826           //?the respective value (vision or dental)...
072300130826           for y = 1 to cov_type_count ;
072400130826
072500150604            volume = ' ';
072600150604            volumeb = ' ';
072700130826            if y = 1 ;
072800130826             if dental_count = *zeros ;
072900130826              iter ;
073000130826             endif ;
073100130826             hlineofcov = '03' ;
073200130826             plan_ptr = %addr(dental_plans) ;
073300130826             variable_count = dental_count ;
073400150513            endif;
073500150513
073600150513            if y = 2 ;
073700150513             if vision_count = *zeros ;
073800130826              iter ;
073900130826             endif ;
074000130826             hlineofcov = '60' ;
074100130826             plan_ptr = %addr(vision_plans) ;
074200130826             variable_count = vision_count ;
074300150513            endif;
074400130826
074500150513            if y = 3 ;
074600150513             if life_count = *zeros ;
074700150513              iter ;
074800150513             endif ;
074900150513             hlineofcov = '05' ;
075000150604
075100150604             volume = ' ';
075200150604             volumeb = ' ';
075300150604              if benamt > 0;
075400150604               volume112 = benamt;
075500150604               volume = %editc(volume112:'X');
075600150604                volume112b = mcorgben;
075700150604               volumeb = %editc(volume112b:'X');
075800150604              endif;
075900150604
076000150604              monitor ;
076100150604               voleffdat = %char(%date(enrldt):*iso) ;
076200150604              on-error ;
076300150604               voleffdat = *blanks ;
076400150604              endmon ;
076500150604
076600150604              monitor ;
076700150604               volenddat = %char(%date(candt):*iso) ;
076800150604              on-error ;
076900150604               volenddat = *blanks ;
077000150604              endmon ;
077100150604
077200150513             plan_ptr = %addr(life_plans) ;
077300150513             variable_count = life_count ;
077400150513            endif;
077500150513
077600150513            if y = 4 ;
077700150513             if vlife_count = *zeros ;
077800150513              iter ;
077900150513             endif ;
078000150513             hlineofcov = '11' ;
078100150604
078200150604             volume = ' ';
078300150604             volumeb = ' ';
078400150605              hsalary = ' ' ;
078500150604              if benamt > 0;
078600150604               volume112 = benamt;
078700150604               volume = %editc(volume112:'X');
078800150604                volume112b = mcorgben;
078900150604               volumeb = %editc(volume112b:'X');
079000150604              endif;
079100150604
079200150604              monitor ;
079300150604               voleffdat = %char(%date(enrldt):*iso) ;
079400150604              on-error ;
079500150604               voleffdat = *blanks ;
079600150604              endmon ;
079700150604
079800150604              monitor ;
079900150604               volenddat = %char(%date(candt):*iso) ;
080000150604              on-error ;
080100150604               volenddat = *blanks ;
080200150604              endmon ;
080300150604
080400150605              if salary > 0 ;
080500150605               salary112 = salary ;
080600150605                hsalary = %editc(salary112:'X') ;
080700150605               earnperiod = 'ANN' ;
080800150605              endif ;
080900150604
081000150513             plan_ptr = %addr(vlife_plans) ;
081100150513             variable_count = vlife_count ;
081200150513            endif;
081300150513
081400130826            exsr prc_sqlstmt_for_dcov ;
081500130826            if no_covg_found = *on ; // no coverage for dependent
081600130826             iter ;
081700130826            endif ;
081800130826
081900150623            //?If coverage cancelled > 60 daye don't transmit...
082000150623            if ccandt > 0 ;
082100150623             term_dt_limit3 = %date(ccandt) ;
082200150623             if term_dt_limit3 > (%date() - %days(60)) ;
082300150623              iter ;
082400150623             endif ;
082500150623            endif ;
082600150623
082700130826            //?If coverage cancelled - see if we have xmt'd already...
082800130826            if ccandt <> *zeros ;
082900130826             if chk_term_file(ccandt:dseq#:hlineofcov) = *off ;
083000130826              iter ;
083100130826             endif ;
083200130826            endif ;
083300150513
083400150513            //?If member is waving coverage (Ben Eff Date = Cov Term date)
083500150520            if beneffdate = covtrmdate ;
083600150513             iter ;
083700150513            endif ;
083800150513
083900130826            exsr set_dependent_values ;
084000150618
084100150623            //if ccandt > 0 ;
084200150623            // term_dt_limit3 = %date(ccandt) ;
084300150623            // if term_dt_limit3 > (%date() - %days(60)) ;
084400150623            //  iter ;
084500150623            // endif ;
084600150623            //endif ;
084700150624
084800150624            //?Check dates for "Housing Authority"...
084900150624            exsr check_ha ;
085000130826
085100150701            //?Check account for division ;
085200150701            entrystate = dstate ;
085300150701            exsr check_account_div ;
085400150701
085500150715            //?Check to see account effective dates (forced)...
085600150715            exsr check_effective_date;
085700230531
085800230602            chain (subscriber:mbrid:mbrfirstnm:mbrdob:benefitid)  humdetailf;
085900230602            if not %found(humdetailf);
086000130826            write humdetailr ;
086100130826            outfield = humdetail_x ;
086200130826            write hum010wfr ;
086300130826            filercdcnt += 1 ;
086400230602            endif;
086500130826
086600130826           endfor ;
086700130826
086800130826          enddo ;
086900130826
087000130819         endsr ;
087100130819
087200130823       //?------------------------------------------------------------------
087300130819    ?  // set_dependent_values:
087400130823       //?------------------------------------------------------------------
087500130819         begsr set_dependent_values ;
087600130819
087700130826          get_plan_data(dvplan) ;
087800130823
087900230602          if depss# > 0;
088000130819          mbrid = %editc(depss#:'X') ;
088100230602          mbrssn = mbrid ;
088200230602          else;
088300230602          mbrid = %editc(mbssno:'X') ;
088400230602          mbrssn = mbrid ;
088500230602          endif;
088600230602
088700130819          mbrfirstnm = dfname ;
088800130819          mbrlastnam = dlname ;
088900130819          mbrmidname = dmi ;
089000230427
089100230427         //  J111
089200230531           // if %subst(fill66:66:1) = 'Y';
089300230531            if flg111 = 'Y';
089400230531            Check_Dep_111();
089500230710            endif;
089600230710
089700230706          //?Retrive coverage type from MCOV for this plan
089800230710          w11trs = %editc(mbtrst:'X') ;
089900230710          w11sub = %editc(mbsub#:'X') ;
090000230710          w11acc = %editc(mbacct:'X') ;
090100230710          w11ssn = %editc(mbssno:'X') ;
090200230710     C                   call      'HUM011R'
090300230710     C                   parm                    w11trs            3
090400230710     C                   parm                    w11sub            3
090500230710     C                   parm                    w11acc            4
090600230710     C                   parm                    w11ssn            9
090700230710     C                   parm                    dvplan
090800230710     C                   parm                    mcovtp
090900230710
091000230706          //?translate our coverage type codes to Humana's codes
091100230706          x = %lookup(mcovtp:gbs_cov_code) ;
091200230706          if x > *zeros ;
091300230706           covtypecod = hum_cov_code(x) ;
091400230706          else ;
091500230706           covtypecod = '01' ;
091600230706          endif ;
091700130826
091800130819          monitor ;
091900130819           mbrdob = %char(%date(dbirth):*iso) ;
092000130819          on-error ;
092100130819           mbrdob = *blanks ;
092200130819          endmon ;
092300130826
092400130819          mbrhomephn = %editc(darea:'X') + '-' + %subst(%editc(dphone:'X'):1:3)
092500130819                       + '-' + %subst(%editc(dphone:'X'):4:4) ;
092600200617          if mbrhomephn = '000-000-0000';
092700200617           mbrhomephn = ' ';
092800200617          endif;
092900130819          mbrhomadr1 = daddr1 ;
093000130819          mbrhomadr2 = daddr2 ;
093100130819          mbrhomcity = dcity ;
093200130819          mbrhomstat = dstate ;
093300130819          mbrhomzip = %subst(%editc(dzip:'X'):1:5) ;
093400130819          mbrhomzip4 = %subst(%editc(dzip:'X'):6:4) ;
093500130826          clear mbrmarstat ;
093600130819          mbrgender = dsex ;
093700130826          clear dateofelig ;
093800130819
093900130826          //?x-ref our relationship codes to Humana's codes
094000130826          x = %lookup(drelcd:gbs_rel_code) ;
094100130821          if x > *zeros ;
094200130821           reltosubsr = hum_rel_code(x) ;
094300130821          else ;
094400130821           reltosubsr = '01' ;
094500130821          endif ;
094600130821
094700130821          clear dateofhire ;
094800130821          clear empstscode ;
094900130821
095000130826          //?if dependent has an enrollment date BEFORE the member - use the
095100130826          //?member enrollment date instead
095200130826          if ccandt = *zeros and denrdt < enrldt ;
095300130826           denrdt = enrldt ;
095400130826          endif ;
095500130826
095600130826          //?benefit effective date and benefit end date
095700130826          monitor ;
095800130826           beneffdate = %char(%date(denrdt):*iso) ;
095900130826          on-error ;
096000130826           beneffdate = *blanks ;
096100130826          endmon ;
096200130826          monitor ;
096300130826           bentrmdate = %char(%date(ccandt):*iso) ;
096400130826          on-error ;
096500130826           bentrmdate = *blanks ;
096600130826          endmon ;
096700150512          monitor ;
096800150512           cateffdate = %char(%date(denrdt):*iso) ;
096900150512          on-error ;
097000150512           cateffdate = *blanks ;
097100150512          endmon ;
097200130826          coveffdate = beneffdate ;
097300130826          covtrmdate = bentrmdate ;
097400150512          cateffdate = beneffdate ;
097500130826
097600130819         endsr ;
097700130822
097800130823       //?------------------------------------------------------------------
097900130816    ?  // Write_trailer:
098000130823       //?------------------------------------------------------------------
098100130816         begsr write_trailer ;
098200130816
098300170630          ttranstype = 'X';
098400130821          write humtrailrr ;
098500130821          outfield = humtrailr_x ;
098600130826          write hum010wfr ;
098700130816
098800130816         endsr ;
098900130816
099000130823       //?------------------------------------------------------------------
099100130821    ?  // set_cobra_fields:  clear then set various cobra related fields
099200130823       //?------------------------------------------------------------------
099300130821         begsr set_cobra_fields ;
099400130821
099500130821          // clear all related Cobra fields first...
099600130821          clear covcontcod ;
099700130821          clear covcontevt ;
099800130821          clear covcontdat ;
099900130821          clear losscovdat ;
100000150514          clear losselgdat ;
100100150513
100200150512          //cateffdate = cacid8 ;
100300150512          monitor ;
100400150512           cateffdate = %char(%date(denrdt):*iso) ;
100500150512          on-error ;
100600150512           cateffdate = *blanks ;
100700150512          endmon ;
100800130821
100900130821          // category end date - use member term date (regardless of cobra)
101000130821          monitor ;
101100130821           catenddate = %char(%date(termdt):*iso) ;
101200130821          on-error ;
101300130821           catenddate = *blanks ;
101400130821          endmon ;
101500130821
101600130821          // based on "empst" (Cobra or not) - set fields
101700130821          if empst = 'A' ;
101800150623           //categoryid = '001' ; // non-cobra
101900150623           categoryid = cpcid2 ;
102000130821
102100130821          else ;
102200130821           categoryid = '002' ; // cobra
102300130821
102400130821           if fcstfl = 'F' ;
102500140320            covcontcod = 'C' ; // federal cobra
102600130904            covcontevt = 'CBRB' ;
102700130821           elseif fcstfl = 'S' ;
102800130821            covcontcod = 'S' ; // state cobra (mini-cobra)
102900130821            covcontevt = 'STCN' ;
103000130821           endif ;
103100130821
103200151104          if cpcid5 > ' ' ;
103300151104           categoryid = cpcid5 ;
103400151104          endif ;
103500151104
103600130821           monitor ;
103700150514            //covcontdat = %char(%date(qedt):*iso) ;
103800150514            covcontdat = %char(%date(gbscdt):*iso) ;
103900150514            losscovdat = %char(%date((gbscdt)) - %days(1):*iso) ;
104000150514            losselgdat = %char(%date((gbscdt)) - %days(1):*iso) ;
104100130829            if covcontdat > cateffdate ;
104200130829             cateffdate = covcontdat ;
104300130829            endif ;
104400130821           on-error ;
104500130821           endmon ;
104600130821
104700160823           if covcontdat > ' ' ;
104800160823           diff_months = %diff(%date(gbscdt) : %date(cexpdt):*months  );
104900160823            if diff_months > 18;
105000160823             covcontevt = 'CBRA' ;
105100160823            endif;
105200160823           endif;
105300150514
105400130821          endif ;
105500130821
105600130821         endsr ;
105700130821
105800150513       //?------------------------------------------------------------------
105900150513    ?  // check_if_cobra:  check that cobra fields are populates properly
106000150513       //?------------------------------------------------------------------
106100150513         begsr check_if_cobra ;
106200150513
106300150513          if covcontevt = 'CBRB' ;
106400150513           beneffdate = covcontdat ;
106500150513           coveffdate = covcontdat ;
106600150513           empstscode = 'CO' ;
106700150513          endif ;
106800150513
106900150513         endsr ;
107000150513
107100150624       //?------------------------------------------------------------------
107200150624    ?  // check_ha:  check that dates for Housing Authority are no lees 11/01/2013
107300150624       //?------------------------------------------------------------------
107400150624         begsr check_ha ;
107500150624
107600150624          if cacid1 = '668088' ;
107700150624
107800150624           if dateofelig > ' ' and %date(dateofelig) < hou_aut_date ;
107900150624            dateofelig = %char(hou_aut_date) ;
108000150624           endif;
108100150624
108200150624           if cateffdate > ' ' and %date(cateffdate) < hou_aut_date ;
108300150624            cateffdate = %char(hou_aut_date) ;
108400150624           endif;
108500150624
108600150624           if beneffdate > ' ' and %date(beneffdate) < hou_aut_date ;
108700150624            beneffdate = %char(hou_aut_date) ;
108800150624           endif;
108900150624
109000150624           if coveffdate > ' ' and %date(coveffdate) < hou_aut_date ;
109100150624            coveffdate = %char(hou_aut_date) ;
109200150624           endif;
109300150624
109400150624          endif ;
109500150624
109600150624         endsr ;
109700150624
109800150715       //?------------------------------------------------------------------
109900150715    ?  // check_effective_date: check to see if date needs to be "forced"
110000150715       //?------------------------------------------------------------------
110100150715         begsr check_effective_date ;
110200150715
110300150715         if cacid8 > ' ' ;
110400150715
110500150715          if cateffdate >  ' ' ;
110600150715           default_date = %date(cateffdate) ;
110700150715
110800150715            if default_date < cat_date ;
110900150715             cateffdate = cacid8 ;
111000150715            endif ;
111100150715
111200150715          endif ;
111300150715
111400150715          if beneffdate >  ' ' ;
111500150715           default_date = %date(beneffdate) ;
111600150715
111700150715            if default_date < cat_date ;
111800150715             beneffdate = cacid8 ;
111900150715            endif ;
112000150715
112100150715          endif ;
112200150715
112300150715          if coveffdate >  ' ' ;
112400150715           default_date = %date(coveffdate) ;
112500150715
112600150715            if default_date < cat_date ;
112700150715             coveffdate = cacid8 ;
112800150715            endif ;
112900150715
113000150715          endif ;
113100150715
113200150715         endif ;
113300150715
113400150715         endsr ;
113500150715
113600150701       //?------------------------------------------------------------------
113700150701    ?  // check_account_div: check what division to send
113800150701       //?------------------------------------------------------------------
113900150701         begsr check_account_div ;
114000150701
114100150701          chain (catrst:casub#:caacct) humplndivr ;
114200150701          if %found ;
114300150701           chain (catrst:casub#:caacct:entrystate) humplndivr ;
114400150701
114500150701           if %found ;
114600150707            categoryid = pdivision ;
114700150701           else;
114800150707            categoryid = '001' ;
114900150701           endif ;
115000150701
115100150701          endif ;
115200150701
115300150701         endsr ;
115400150701
115500150604       //?------------------------------------------------------------------
115600150604    ?  // get_additional : get additional values...
115700150604       //?------------------------------------------------------------------
115800150604         begsr get_additional ;
115900150604
116000150604          if lineofcov =  '05' ;
116100150604             volume = ' ';
116200150604             volumeb = ' ';
116300150604              if benamt > 0;
116400150604               volume112 = benamt;
116500150604                volume = %editc(volume112:'X');
116600150604                volume112b = mcorgben;
116700150604               volumeb = %editc(volume112b:'X');
116800150604              endif;
116900150604
117000150604              monitor ;
117100150604               voleffdat = %char(%date(enrldt):*iso) ;
117200150604              on-error ;
117300150604               voleffdat = *blanks ;
117400150604              endmon ;
117500150604
117600150604              monitor ;
117700150604               volenddat = %char(%date(candt):*iso) ;
117800150604              on-error ;
117900150604               volenddat = *blanks ;
118000150604              endmon ;
118100150604          endif ;
118200150604
118300150604          if lineofcov =  '11' ;
118400150604             volume = ' ';
118500150604             volumeb = ' ';
118600150604              if benamt > 0;
118700150604               volume112 = benamt;
118800150604                volume = %editc(volume112:'X');
118900150604                volume112b = mcorgben;
119000150604               volumeb = %editc(volume112b:'X');
119100150604              endif;
119200150604
119300150604              monitor ;
119400150604               voleffdat = %char(%date(enrldt):*iso) ;
119500150604              on-error ;
119600150604               voleffdat = *blanks ;
119700150604              endmon ;
119800150604
119900150604              monitor ;
120000150604               volenddat = %char(%date(candt):*iso) ;
120100150604              on-error ;
120200150604               volenddat = *blanks ;
120300150604              endmon ;
120400150604
120500150604           hsalary = ' ';
120600150604            if salary > 0 ;
120700150604             salary112 = salary;
120800150605              hsalary = %editc(salary112:'X');
120900150605             earnperiod = 'ANN' ;
121000150604            endif ;
121100150604
121200150604           endif ;
121300150604
121400150604         endsr ;
121500150604
121600130823       //?------------------------------------------------------------------
121700130823       //?prc_sqlstmt_for_mcov:
121800130823       //?------------------------------------------------------------------
121900130823         begsr prc_sqlstmt_for_mcov ;
122000130823
122100130823          reset no_covg_found ; // reset flag
122200130823
122300130823          //?build variable sqlstmt - to include all common benefit types
122400130823          //?together into one select statement for this subscriber
122500150522          sql_stmt = 'select * from QS36F/"F.MCOVC" where mcplan in (' ;
122600130823
122700130823          for x = 1 to variable_count ;
122800130823           carplnp_ds = variable_plan(x) ;
122900130823           if x > 1 ;
123000130823            sql_stmt = %trim(sql_stmt) + ',' ; //insert comma for In clause
123100130823           endif ;
123200130823           sql_stmt = %trim(sql_stmt) + '''' + cpplan + '''' ;
123300130823          endfor ;
123400130823
123500130823          sql_stmt = %trim(sql_stmt) + ') and mcssno = ' + %editc(mbssno:'X')
123600130823                    + ' and mctrst = ' + %editc(catrst:'X') + ' and mcsub#  = '
123700130823                    + %editc(casub#:'X') + ' and acc# = '
123800130823                    + %editc(caacct:'X') ;
123900130823
124000130823          //?if subscriber (member) is terminated - sort by the highest
124100130823          //?cancellation date for this benefit type...else sort ascending
124200130823          if termdt <> *zeros ;
124300130823           sql_stmt = %trim(sql_stmt) + ' order by candt desc ' ;
124400130823          else ;
124500130823           sql_stmt = %trim(sql_stmt) + ' order by candt asc ' ;
124600130823          endif ;
124700130823
124800130823          sql_stmt = %trim(sql_stmt) + ' for fetch only ' ;
124900130823
125000130823          //?now prepare the variable sql stmt and open the cursor
125100130823          exec sql prepare mcov from :sql_stmt ;
125200130823          exec sql declare mcov_cursor cursor for mcov  ;
125300130823          exec sql open mcov_cursor ;
125400130823
125500130826          //?fetch first record:  if record not found - OR - the member
125600130823          //?is terminated - OR - cancellation date is zero LEAVE now
125700130823          exec sql fetch mcov_cursor into :mbr_coverage ;
125800130823          if sqlcod <> *zeros or termdt <> *zeros or candt = *zeros ;
125900130823           if sqlcod <> *zeros ;
126000130823            no_covg_found = *on ;
126100130823           endif ;
126200130823           exec sql close mcov_cursor ;
126300130823           leavesr ;
126400130823          endif ;
126500130823
126600130823          //?Can only get to this point IF active member with no active
126700130823          //?coverage of this type - so we need to get the latest cancel
126800130823          //?date.  Read until eof...
126900130823          dou sqlcod <> *zeros ;
127000130823           exec sql fetch mcov_cursor into :mbr_coverage ;
127100130823          enddo ;
127200130826          exec sql close mcov_cursor ;
127300130823
127400130823         endsr ;
127500130823
127600130826       //?------------------------------------------------------------------
127700130826       //?prc_sqlstmt_for_dcov:
127800130826       //?------------------------------------------------------------------
127900130826         begsr prc_sqlstmt_for_dcov ;
128000130826
128100130826          reset no_covg_found ; // reset flag
128200130826
128300130826          //?build variable sqlstmt - to include all common benefit types
128400130826          //?together into one select statement for this dependent
128500150522          sql_stmt = 'select * from QS36F/"F.DCOVC" where dvplan in (' ;
128600130826
128700130826          for x = 1 to variable_count ;
128800130826           carplnp_ds = variable_plan(x) ;
128900130826           if x > 1 ;
129000130826            sql_stmt = %trim(sql_stmt) + ',' ; //insert comma for In clause
129100130826           endif ;
129200130826           sql_stmt = %trim(sql_stmt) + '''' + cpplan + '''' ;
129300130826          endfor ;
129400130826
129500130826          sql_stmt = %trim(sql_stmt) + ') and ssno = ' + %editc(dssno:'X')
129600130826                    + ' and dseq# = ' + %editc(dpseq#:'X') + ' and dvtrst = '
129700130826                    + %editc(catrst:'X') + ' and dvsub# = '
129800130826                    + %editc(casub#:'X') ;
129900130826
130000130826          //?if subscriber (member) is terminated - sort by the highest
130100130826          //?cancellation date for this benefit type...else sort ascending
130200130826          if termdt <> *zeros ;
130300130826           sql_stmt = %trim(sql_stmt) + ' order by ccandt desc ' ;
130400130826          else ;
130500130826           sql_stmt = %trim(sql_stmt) + ' order by ccandt asc ' ;
130600130826          endif ;
130700130826
130800130826          sql_stmt = %trim(sql_stmt) + ' for fetch only ' ;
130900130826
131000130826          //?now prepare the variable sql stmt and open the cursor
131100130826          exec sql prepare dcov from :sql_stmt ;
131200130826          exec sql declare dcov_cursor cursor for dcov  ;
131300130826          exec sql open dcov_cursor ;
131400130826
131500130826          //?fetch first record:  if record not found - OR - the member
131600130826          //?is terminated - OR - cancellation date is zero LEAVE now
131700130826          exec sql fetch dcov_cursor into :dep_coverage ;
131800130826          if sqlcod <> *zeros or termdt <> *zeros or ccandt = *zeros ;
131900130826           if sqlcod <> *zeros ;
132000130826            no_covg_found = *on ;
132100130826           endif ;
132200130826           exec sql close dcov_cursor ;
132300130826           leavesr ;
132400130826          endif ;
132500130826
132600130826          //?Can only get to this point IF active member and dependent has
132700130826          //?no coverage of this type - so we need to get the latest cancel
132800130826          //?date.  Read until eof...
132900130826          dou sqlcod <> *zeros ;
133000130826           exec sql fetch dcov_cursor into :dep_coverage ;
133100130826          enddo ;
133200130826          exec sql close dcov_cursor ;
133300130826
133400130826         endsr ;
133500130826
133600130823       //?------------------------------------------------------------------
133700130819    ?  // end_pgm:
133800130823       //?------------------------------------------------------------------
133900130819         begsr end_pgm ;
134000130819
134100130819          *inlr = *on ;
134200130819          return ;
134300130819
134400130819         endsr ;
134500130819
134600130823       //?------------------------------------------------------------------
134700130819    ?  // Initialization
134800130823       //?------------------------------------------------------------------
134900130815         begsr *inzsr ;
135000130815
135100130819          error_msg = *blanks ;
135200130816          filecrtdat = %char(%date():*iso) ;
135300130816          filecrttim = %char(%time():*iso) ;
135400130816
135500130823    ?     // Humana wants a '-' as the time separator...
135600130816          filecrttim = %xlate('.':'-':filecrttim) ;
135700130816
135800130816    ?     // Set other date/time fields equal to file date/time values
135900130816          trancrtdat = filecrtdat ;
136000130816          trancrttim = filecrttim ;
136100130816          tfilcrtdat = filecrtdat ;
136200130816          tfilcrttim = filecrttim ;
136300130816
136400130815         endsr ;
136500130823       //?------------------------------------------------------------------
136600130815
136700130826      /end-free
136800130826
136900130826     ?*----------------------------------------------------------------
137000130826    ? * chk_term_file function:
137100130826     ?*----------------------------------------------------------------
137200130826     Pchk_term_file    b
137300130826
137400130826     D chk_term_file   pi              n
137500130826     D  cancel_date                        like(candt) const
137600130826     D  seqnbr                             like(hseqnbr) const
137700130826     D  lineofcov                          like(hlineofcov) const
137800130826
137900130826     D send_term_rcd   s               n   inz(*off)
138000130826
138100130826      /free
138200130826
138300130826        // remove residual values from term tracking file and reset flag
138400130826        reset *nokey humana_trr ;
138500130826
138600130826        monitor ;
138700130826         htermdate = %date(cancel_date:*iso) ;
138800130826        on-error ;
138900130826         htermdate = d'0001-01-01' ;
139000130826        endmon ;
139100130826
139200130826        // don't transmit same-day cancellations...
139300130826        if htermdate = %date() ;
139400130826         return send_term_rcd ;
139500130826        endif ;
139600130826
139700130826        chain (mbtrst:mbsub#:mbacct:mbssno:hseqnbr:htermdate:mcovtp:
139800130826                hlineofcov) humana_trk ;
139900130826        if not %found(humana_trk) or hxmtcount < nbr_term_xmt ;
140000130826         send_term_rcd = *on ;
140100130826         hlstxmtdat = hcurxmtdat ;
140200130826         hcurxmtdat = %date() ;
140300130826         hxmtcount += 1 ;
140400130826         if %found(humana_trk) ;
140500130826          update humana_trr ;
140600130826         else ;
140700130826          htrust = mbtrst ;
140800130826          hsub = mbsub# ;
140900130826          hacct = mbacct ;
141000130826          hssn = mbssno ;
141100130826          hcovtype = mcovtp ;
141200130826          hlstxmtdat = hcurxmtdat ;
141300130826          write humana_trr ;
141400130826         endif ;
141500130826        endif ;
141600130826
141700130826        return send_term_rcd ;
141800130826
141900130826      /end-free
142000130826
142100130826     Pchk_term_file    e
142200130826
142300130826     ?*----------------------------------------------------------------
142400130826    ? * get_plan_data: Get variables for Plan from CARPLNP and PLNMST
142500130826     ?*----------------------------------------------------------------
142600130826     Pget_plan_data    b
142700130826
142800130826     D get_plan_data   pi
142900130826     D  plan                               like(dvplan) const
143000130826
143100130826      /free
143200130826
143300130826    ?   // get plan master record...
143400130826        chain (catrst:casub#:plan) plnunique ;
143500130826
143600130826    ?   // set Plan level values in Humana export file - from CARPLNP
143700130826        chain (cxuniq:catrst:casub#:caacct:cpcctr:plan) carplnp ;
143800130826        lineofcov = cpcid1 ;
143900130826        benlinecov = lineofcov ;
144000130826        benefitid = %subst(cpcid1:%len(lineofcov) + 1) ;
144100130826
144200130826      /end-free
144300130826
144400130826     Pget_plan_data    e
144500130826     ?*----------------------------------------------------------------
144600230427       // ----------------------------------------------------------------
144700230427       dcl-proc Check_Mem_111;
144800230427
144900230427          chain (mbssno) memmem ;
145000230427          if %found ;
145100230427          subscriber = %editc(MMORSSN:'X') ;
145200230427          subscrissn = subscriber ;
145300230427          mbrid = subscriber ;
145400230427          mbrssn = mbrid ;
145500230531          chain (mmorssn) member ;
145600230427          endif;
145700230427
145800230427       end-proc;
145900230427       // ----------------------------------------------------------------
146000230427       dcl-proc Check_Dep_111;
146100230427
146200230427          chain (mbssno) memmem ;
146300230427          if %found ;
146400230427
146500230427          setll (MMORSSN) DEPEND ;
146600230427          reade (MMORSSN) DEPEND ;
146700230427          dow not %eof(DEPEND);
146800230427          if  %trim(DLNAME) = %trim(D_DLNAME) and
146900230427              %trim(DFNAME) = %trim(D_DFNAME) and
147000230427              %trim(DMI) = %trim(D_DMI)       and
147100230427              %trim(DSEX) = %trim(D_DSEX)     and
147200230427              %char(DBIRTH) = %char(D_DBIRTH);
147300230427
147400230530          if D_DEPSS# > 0;
147500230427          mbrid = %editc(D_DEPSS#:'X') ;
147600230427          mbrssn = mbrid ;
147700230427          Leave;
147800230530          else;
147900230530          mbrid = %editc(mbssno:'X') ;
148000230530          mbrssn = mbrid ;
148100230530          Leave;
148200230530          endif;
148300230427
148400230427          endif;
148500230427          reade (MMORSSN) DEPEND ;
148600230427          enddo;
148700230427
148800230602          else;
148900230602          mbrid = %editc(mbssno:'X') ;
149000230602          mbrssn = mbrid ;
149100230427
149200230427          endif;
149300230427
149400230427       end-proc;
149500130826
149600130820** GBS coverages type xlated to Humana type
149700130904TDB03
149800130820TFA04
149900130820TFM04
150000130903THW07
150100130820TIN01
150200130820TMF04
150300130820TMH03
150400130820TMI01
150500130904TMP03
150600130904TPC03
150700130820TP203
150800130829** GBS relationship codes xlated to Humana type
150900130821RA 01
151000130821RB 01
151100130821RC 01
151200130821RD 01
151300130821RDA01
151400130821RHU03
151500130821ROO01
151600130821RPA10
151700130821RSO01
151800130821RWI03
151900130821RXX01
