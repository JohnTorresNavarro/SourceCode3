000100140611     Hoption(*nodebugio) debug bnddir('ALLSRVPGMN':'RPGSPPAYR/GBSBDIR')
000200131114     Hdftactgrp(*no) actgrp(*caller)
000300131114      *-------------------------------------------------------------------------
000400131114      *    G R O U P   B E N E F I T   S E R V I C E S
000500131114      *-------------------------------------------------------------------------
000600140113      *  Program: Clone of FI036R
000700140113    ? *  Description: Show plan rates and print
000800131114    ? *  Written by:  Debora Bond
000900131114    ? *  Date Written:11/11/2013
001000131105    ? *
001100140113    ? *  (c)Copyright 2014 by GBS, Inc.
001200131105    ? *  This document contains restricted materials of GBS,Inc.
001300140113    ? *
001400140113    ? *  Notes:  JVA   01-13-2014
001500140113    ? *          This program was cloned from FI036R it displays the
001600140113    ? *          rates for a selected SSN/Plan with the option to email
001700140113    ? *          a PDF of the rates to the current user.
001800131105    ? *
001900131105    ? *_________________________________________________________________________
002000131105    ? *  Modifications:
002100140819      *  08/19/2014 DPB Removed ext DS planbenf...not used.....
002200131105    ? *_________________________________________________________________________
002300140113     FDSPRATED  cf   e             workstn infds(dspf_infds)
002400131106     F                                     sfile(sfl01:sfl_1_rrn)
002500131101     Fplnunique if   e           k disk
002600131104     Fplnauxp   if   e           k disk
002700131101     Fcarunique if   e           k disk
002800131107     Facmunique if   e           k disk
002900131101
003000131104      *?Stand alone fields
003100131111     D inqtype         s              8
003200131107     D sfl_1_rrn       s                   like(sfl_1_pos)
003300131107     D high_1_rrn      s                   like(sfl_1_pos)
003400131106     D account         s                   like(pxacct)
003500131125     D nullind_array   s              4b 0 dim(16) inz
003600140114     D rates_loaded    s              1    inz('N')
003700140114     D rates_printed   s              1    inz('N')
003800131114     D benefit_loaded  s                   inz('N') like(rates_loaded)
003900131114     D no_rates_shown  s                   inz('N') like(rates_loaded)
004000140113     D renewal_month   s              2  0
004100140121     D ssn             s              9
004200140121     D seq             s              2
004300140121     D w0ssn           s              9s 0 inz
004400140121     D w0seq           s              2s 0 inz
004500140114     d  p_trst         s              3s 0
004600140114     d  p_sub#         s              3s 0
004700140114     d  p_plan         s              4a
004800140114     d  p_acc          s              4s 0
004900140121     d  p_ssn          s              9s 0
005000140121     d  p_seq          s              2s 0
005100140115     d  p_name         s             33a
005200140120     d  p_pct          s              2
005300140120     d  gbspct         s              2s 2
005400140120     d  gbsfee         s              7s 2
005500131106
005600131104      *?Data structures
005700160509     D agerate       e ds                  inz
005800131107     D rateregion    e ds                  inz
005900131111     D c@de20p       e ds                  extname(code20p) inz
006000131104
006100131104      *?DSPF infds
006200131101     D dspf_infds      ds
006300131105     D dspfname          *file
006400131101     d  function_key         369    369
006500131101
006600131101     D               esds                  extname(iopgmd)
006700140114
006800140114      *?prototypes
006900140114      /define prtrater
007000140114     D prtratecl       pr                  extpgm('PRTRATECL')
007100140114     d  p_trst                        3s 0
007200140114     d  p_sub#                        3s 0
007300140114     d  p_plan                        4a
007400140114     d  p_acc                         4s 0
007500140121     d  p_ssn                         9s 0
007600140121     d  p_seq                         2s 0
007700140120     d  p_pct                         2
007800140115     d  p_name                       33a
007900131101
008000131101      /copy qcpysrc,FKEYS_ILE
008100131104
008200131106      *?Prototypes
008300131106      /define copy_all_protos_and_fields
008400131108      /copy qcpysrc,zipsrvpgmp
008500131106      /undefine copy_all_protos_and_fields
008600131104
008700131106      /define copy_all_protos_and_fields
008800140611      /copy qcpysrc,acasrvpgmp
008900131106      /undefine copy_all_protos_and_fields
009000131106
009100131106      /define rtv_accaddr_return
009200131106      /define copy_all_protos_and_fields
009300131106      /copy qcpysrc,accsrvpgmp
009400131106      /undefine copy_all_protos_and_fields
009500131106      /undefine rtv_accaddr_return
009600131107
009700131107      /define copy_all_protos_and_fields
009800131107      /copy qcpysrc,c20srvpgmp
009900131107      /undefine copy_all_protos_and_fields
010000131106
010100131107      /copy qmodsrc,#fmttsapr
010200131107
010300131105     C     *entry        plist
010400131105     C                   parm                    pltrst
010500131105     C                   parm                    plsub#
010600131106     C                   parm                    plplan
010700140113     C                   parm                    account
010800140121     C                   parm                    ssn
010900140121     C                   parm                    seq
011000140120     C                   parm                    p_pct
011100140120     C                   parm                    inqtype
011200140113     C                   parm                    winame
011300140113
011400140121     C                   move      ssn           w0ssn
011500140121     C                   move      seq           w0seq
011600140120     C                   move      p_pct         gbspct
011700131114
011800131101      * --------------------------------------------------------------------***
011900131101      * MAINLINE
012000131101      * --------------------------------------------------------------------***
012100131101      /free
012200131101
012300131125       exec sql set option datfmt = *iso ;
012400131125
012500131111       tsa = #fmttsa(%int(pltrst):%int(plsub#):%int(account)) ;
012600131111       exsr get_master_records ;
012700131111
012800131114       //?if error - terminate
012900131114       if errormsg <> *blanks ;
013000131114        exsr show_error ;
013100131114        exsr endpgm ;
013200131114       endif ;
013300131111
013400131118       //?load dspf fields based on *entry parm "inqtype"
013500131114       if inqtype = 'RATES' ;
013600131114        exsr load_rate_sfl ;
013700131114       endif ;
013800131111
013900131114       //?if error - terminate
014000131114       if errormsg <> *blanks ;
014100131114        exsr show_error ;
014200131114        exsr endpgm ;
014300131114       endif ;
014400131114
014500131114       dow function_key <> #f3 ;
014600131114
014700131111        if inqtype = 'RATES' ;
014800131114         if rates_loaded = 'N' ;
014900131114          exsr load_rate_sfl ;
015000131114         endif ;
015100131114         exsr show_rate_sfl ;
015200140113        elseif inqtype = 'EMAIL' ;
015300140114         if rates_printed = 'N' ;
015400140114         exsr print_rates ;
015500140114        endif ;
015600131111        endif ;
015700131114
015800131114       enddo ;
015900131114
016000131114       exsr endpgm ;
016100131101
016200131104       //-------------------------------------------------------------------
016300131111       //?get_master_records:
016400131104       //-------------------------------------------------------------------
016500131111       begsr get_master_records ;
016600131105
016700131111        chain (pltrst:plsub#:account) acmunique ;
016800131111        chain (pltrst:plsub#:plplan) plnunique ;
016900131111        chain (pltrst:plsub#:plplan) plnauxp ;
017000131111        chain (pcarr) carunique ;
017100131111
017200131111        if not %found (plnunique) ;
017300131111         errormsg = 'Plan master record not found' ;
017400131111        elseif not %found(carunique) ;
017500131111         errormsg = 'Carrier master record not found' ;
017600131111        elseif not %found(acmunique) ;
017700131111         errormsg = 'Account master record not found' ;
017800131111        elseif not %found(plnauxp) ;
017900131111         errormsg = 'Plan Auxiliary record not found' ;
018000131113        else ;
018100131114         renewal_month = prenew ;
018200131113        rtcarrier =
018300131113         #get_exch_carrier(pltrst:plsub#:plplan:carrcd:cgrpcd) ;
018400131113         if rtcarrier = *blanks or rtcarrier = '* ERROR *' ;
018500131113          errormsg = 'Unable to retrieve Carrier x-ref' ;
018600131113         endif ;
018700131113
018800131111        endif ;
018900131108
019000131111       endsr ;
019100131104
019200131108       //-------------------------------------------------------------------
019300131108       //?show_rate_sfl:
019400131108       //-------------------------------------------------------------------
019500131108       begsr show_rate_sfl ;
019600131108
019700131114        if sfl_1_rrn= *zeros ;
019800131114         errormsg = 'No Rates found' ;
019900131114        endif ;
020000131114
020100131114        reset no_rates_shown ;
020200131114
020300131114        dow 1 = 1 ;
020400131108
020500131108         write cmdkey1 ;
020600131114         if sfl_1_rrn = *zeros and no_rates_shown = 'N' ;
020700131114          write sfc01 ;
020800131114          exfmt wdwerror ;
020900131114          no_rates_shown = 'Y' ;
021000131114         else ;
021100131114          exfmt sfc01 ;
021200131114         endif ;
021300131108
021400131108         select ;
021500131108          when function_key = #f3 ;
021600131108           leave ;
021700131114          when function_key = #f9 ;
021800140113           inqtype = 'EMAIL' ;
021900131114           leave ;
022000131108          when function_key = #f17 ;
022100131108           sfl_1_pos = 1 ;
022200131108          when function_key = #f18 ;
022300131108           sfl_1_pos = high_1_rrn  ;
022400131108         endsl ;
022500131108
022600131108        enddo ;
022700131108
022800131108       endsr ;
022900131108
023000131106       //-------------------------------------------------------------------
023100131106       //?load_rate_sfl:
023200131106       //-------------------------------------------------------------------
023300131106       begsr load_rate_sfl ;
023400131106
023500131114        c@de20p = #rtv_code20('MONTH_TEXT':%editc(renewal_month:'X')) ;
023600131114        renewmonth = c20sdesc ;
023700131111        exsr get_rating_key_values ;
023800131111
023900131111        if errormsg <> *blanks ;
024000131111         leavesr ;
024100131111        endif ;
024200131111
024300131106        // Initialize subfile control record...
024400131106        *in40 = *On ; // sflclr keyword on control record
024500131106        write sfc01 ;
024600131106        *in40 = *Off ;
024700131111        *in41 = *On ;
024800131106        clear sfl_1_rrn ;
024900131106
025000160509        exec sql declare a1 cursor for select * from agerate where
025100160509         rtcarrier = :rtcarrier and rtplnid = :pxcarpln and rteffmth =
025200160509         :prenew and rtregion = :mregion order by rtlowage, rthighage ;
025300160509        exec sql open a1 ;
025400131106
025500131106
025600131106        // Load
025700131106        dou sqlcod <> *zeros ;
025800160509         exec sql fetch a1 into :agerate:nullind_array ;
025900131106
026000131106         if sqlcod <> *zeros ;
026100131106          leave ;
026200131106         endif ;
026300131106
026400131106         // Add to sfl then clear sfl format
026500131106         sfl_1_rrn += 1 ;
026600131106         ageband = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
026700131106         metallevel = rtmetalvl ;
026800140120
026900140120         // Add surcharge
027000140120        if gbspct > *zeros ;
027100140120        eval(h) gbsfee = rtsmoker * gbspct ;
027200140120        rtsmoker = rtsmoker + gbsfee ;
027300140120        eval(h) gbsfee = rtnsmkr * gbspct ;
027400140120        rtnsmkr = rtnsmkr + gbsfee ;
027500140120        endif ;
027600140120
027700131106         write sfl01 ;
027800131106         clear sfl01 ;
027900131106
028000131106        enddo ;
028100131106
028200131111        // If sfl has records, turn on sfl control/dsp indicators
028300131111        if sfl_1_rrn > *zeros ;
028400131111         %subarr(*in:42:2) = *On ;
028500131106         sfl_1_pos = 1 ;
028600131107         high_1_rrn = sfl_1_rrn ;
028700131107         *in99 = *on ; // sflend indicator
028800131107         plandescr = rtplnname ;
028900131106        endif ;
029000131106
029100160509        exec sql close a1 ;
029200140115        rates_loaded = 'Y' ;
029300140115        rates_printed = 'N' ;
029400131111
029500131106       endsr ;
029600131106
029700131111       //-------------------------------------------------------------------
029800131111       //?get_rating_key_values:
029900131111       //-------------------------------------------------------------------
030000131111       begsr get_rating_key_values ;
030100131111
030200131111        //?external functions to rtv physical addr, retrieve rating region,
030300131111        //?retrieve exchange carrier...
030400131111        ds@return = #rtv_accaddr(pltrst:plsub#:account) ;
030500131111        mregion = #get_rating_region(raa_state:raa_county) ;
030600131111        mdescr = #get_region_descr(raa_state:mregion) ;
030700131113        if mdescr = *blanks ;
030800131111         errormsg = 'Unable to determine rating region' ;
030900131111        endif ;
031000131111
031100131111       endsr ;
031200131111
031300131111       //-------------------------------------------------------------------
031400131111       //?show_benefits:
031500131111       //-------------------------------------------------------------------
031600140114       begsr print_rates ;
031700131114
031800140114       p_trst = pltrst ;
031900140114       p_sub# = plsub# ;
032000140114       p_plan = plplan ;
032100140114       p_acc  = account ;
032200140121       p_ssn  = w0ssn ;
032300140121       p_seq  = w0seq ;
032400140114       p_name = %trim(winame) ;
032500140114
032600140121         PRTRATECL (p_trst:p_sub#:p_plan:p_acc:p_ssn:p_seq:p_pct:p_name) ;
032700140114
032800140114         errormsg = 'Print Rates submitted for processing' ;
032900140114        exsr show_error ;
033000140114
033100140114       //?return to rates display
033200140114        inqtype = 'RATES' ;
033300140115        rates_printed = 'N' ;
033400140114        rates_loaded = 'N' ;
033500131111
033600131111       endsr ;
033700131111
033800131114       //?------------------------------------------------------------------
033900131114    ?  // show_error:  show error window
034000131114       //?------------------------------------------------------------------
034100131114       begsr show_error ;
034200131114
034300131114         *in41 = *On ; //sfldspctl *indicator
034400131114         write cmdkey1 ;
034500131114         write sfc01 ;
034600131114        exfmt wdwerror ;
034700131114
034800131114       endsr ;
034900131114
035000131114       //?------------------------------------------------------------------
035100131114    ?  // endpgm:  terminate program normally
035200131114       //?------------------------------------------------------------------
035300131114       begsr endpgm ;
035400131114
035500131114        *inlr = *on ;
035600131114        return ;
035700131114
035800131114       endsr ;
035900131114
036000131101       //?------------------------------------------------------------------
036100131101    ?  // Initialization
036200131101       //?------------------------------------------------------------------
036300131108       begsr *inzsr ;
036400131125
036500131101
036600131108       endsr ;
036700131101       //?------------------------------------------------------------------
036800131101
036900131101      /end-free
