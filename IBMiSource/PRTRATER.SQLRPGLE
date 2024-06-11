000100140626     Hoption(*nodebugio) debug bnddir('ALLSRVPGMN':'RPGSPPAYR/GBSBDIR')
000200131114     Hdftactgrp(*no) actgrp(*caller)
000300131114      *-------------------------------------------------------------------------
000400131114      *    G R O U P   B E N E F I T   S E R V I C E S
000500131114      *-------------------------------------------------------------------------
000600140113      *  Program: Clone of FI036R
000700140114    ? *  Description: Print plan rates
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
002200150220      *  10/17/2014 bug fix on column 2 of report
002300150220      *  02/20/2015 bug fix on date ranges
002301171113      *  11/13/2017 dlk - add inserter mark (non-page 1) and reformat output
002303171113      *                   to email as pdf. Also remove smoker rate per
002304171113      *                   shelly.
002305171120      *  11/20/2017 dlk - Removed heading control, not needed since the
002306171120      *                   rate sheet is one page and headings are needed
002307171120      *                   on every page.
002400131105    ? *_________________________________________________________________________
002500140121    ?FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER') USROPN
002600140121    ?FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC') USROPN
002700131101     Fplnunique if   e           k disk
002800131104     Fplnauxp   if   e           k disk
002900131101     Fcarunique if   e           k disk
003000131107     Facmunique if   e           k disk
003100140114     Fprtratep  o    e             printer  OFLIND(*IN91)
003200131101
003300131104      *?Stand alone fields
003400140220     D Tic             S              1a   inz(x'7D')
003500131111     D inqtype         s              8
003600131106     D account         s                   like(pxacct)
003700131125     D nullind_array   s              4b 0 dim(16) inz
003800171120     D** head_printed    s              1    inz('N')
003900131114     D rates_loaded    s              1    inz('N')
004000131114     D benefit_loaded  s                   inz('N') like(rates_loaded)
004100131114     D no_rates_shown  s                   inz('N') like(rates_loaded)
004200140113     D renewal_month   s              2  0
004300140113     D ssn             s              9
004400140113     D w0ssn           s              9s 0 inz
004500140114     d  p_trst         s              3s 0
004600140114     d  p_sub#         s              3s 0
004700140114     d  p_plan         s              4a
004800140114     d  p_acc          s              4s 0
004900140121     d  p_ssn          s              9s 0
005000140121     d  p_seq          s              2s 0
005100160602     d  p_pct          s              2a
005200160602     d  p_eff          s              8a
005300140115     d  p_name         s             33a
005400140120     d  gbspct         s              2s 2
005500140120     d  gbsfee         s              7s 2
005600140114     d  errormsg       s            100a
005700140114     d  tsa            s             15a
005800140114     d  wpagerate      s              7a
005900140210     d  l              s              3s 0
006000150115     d  r              s              3s 0
006100150115     d  c              s              3s 0
006200150115     d  d              s              3s 0
006300140210     d  idx            s              3s 0
006400150220     d ISO#REQ         S               D   DATFMT(*ISO)
006500160602     d w80date         s              8s 0
006600160602     d ineff           s              8s 0
006601171113     d wpsmoker        s             10
006602171113     d wxsmoker        s             10
006700140210
006800140210     D leftds          ds
006900150115     D  aage                          7    dim(50) inz
007000150115     D  asmk                         10    dim(50) inz
007100150115     D  ansm                         10    dim(50) inz
007200140210
007300140210     D rightds         ds
007400150115     D  bage                          7    dim(50) inz
007500150115     D  bsmk                         10    dim(50) inz
007600150115     D  bnsm                         10    dim(50) inz
007700150115
007800150115     D leftds2         ds
007900150115     D  cage                          7    dim(50) inz
008000150115     D  csmk                         10    dim(50) inz
008100150115     D  cnsm                         10    dim(50) inz
008200150115
008300150115     D rightds2        ds
008400150115     D  dage                          7    dim(50) inz
008500150115     D  dsmk                         10    dim(50) inz
008600150115     D  dnsm                         10    dim(50) inz
008700131106
008800131104      *?Data structures
008900131113     D agerate       e ds                  inz
009000131107     D rateregion    e ds                  inz
009100131111     D c@de20p       e ds                  extname(code20p) inz
009200131101
009300131101      /copy qcpysrc,FKEYS_ILE
009400131104
009500131106      *?Prototypes
009600131106      /define copy_all_protos_and_fields
009700131108      /copy qcpysrc,zipsrvpgmp
009800131106      /undefine copy_all_protos_and_fields
009900131104
010000131106      /define copy_all_protos_and_fields
010100140626      /copy qcpysrc,acasrvpgmp
010200131106      /undefine copy_all_protos_and_fields
010300131106
010400131106      /define rtv_accaddr_return
010500131106      /define copy_all_protos_and_fields
010600131106      /copy qcpysrc,accsrvpgmp
010700131106      /undefine copy_all_protos_and_fields
010800131106      /undefine rtv_accaddr_return
010900131107
011000131107      /define copy_all_protos_and_fields
011100131107      /copy qcpysrc,c20srvpgmp
011200131107      /undefine copy_all_protos_and_fields
011300131106
011400131107      /copy qmodsrc,#fmttsapr
011500131107
011600131105     C     *entry        plist
011700140114     C                   parm                    p_trst
011800140114     C                   parm                    p_sub#
011900140114     C                   parm                    p_plan
012000140114     C                   parm                    p_acc
012100140121     C                   parm                    p_ssn
012200140121     C                   parm                    p_seq
012300140120     C                   parm                    p_pct
012400140114     C                   parm                    p_name
012500160602     C                   parm                    p_eff
012600160602     C                   move      p_eff         ineff
012700140114
012800140206    ?C                   Move      *off          *in91
012900140120     C                   move      p_pct         gbspct
013000140121 002 C                   Clear                   WDNAME
013100140121 002 C                   Clear                   p_name
013200150220     C                   eval      w80date = %int(%char(%date : *iso0))
013300150220     C                   move      w80date       ISO#REQ
013400140121
013500140121     C                   Open      MEMBER
013600140121 001 C     p_ssn         Chain     MEMBER
013700140121     C                   If        %found(MEMBER)
013800140121     C                   If        %trim(MMI) = *blanks
013900140121     C                   Eval      p_name = %trim(MFNAME) + ' ' +
014000140121     C                                      %trim(MLNAME)
014100140121E002 C                   Else
014200140121     C                   Eval      P_name = %trim(MFNAME) + ' ' +
014300140121     C                                      %trim(MMI)    + ' ' +
014400140121     C                                      %trim(MLNAME)
014500140121E002 C                   End
014600140121     C                   End
014700140220     C     tic:'_'       Xlate     p_name        p_name
014800140121     C                   Close     MEMBER
014900140121
015000140121     C                   If        p_seq <> 0
015100140121     C                   Open      DEPNDC
015200140121 001 C     DEPKEY        Chain     DEPNDC
015300140121     C                   If        %found(DEPNDC)
015400140121     C                   If        %trim(DMI) = *blanks
015500140121     C                   Eval      WDNAME = %trim(DFNAME) + ' ' +
015600140121     C                                      %trim(DLNAME)
015700140121E002 C                   Else
015800140121     C                   Eval      WDNAME = %trim(DFNAME) + ' ' +
015900140121     C                                      %trim(DMI)    + ' ' +
016000140121     C                                      %trim(DLNAME)
016100140121E002 C                   End
016200140121E002 C                   End
016300140220     C     tic:'_'       Xlate     wdname        wdname
016400140121     C                   Close     DEPNDC
016500140121E002 C                   End
016600140121
016700140121     C     DEPKEY        Klist
016800140121     C                   Kfld                    p_ssn
016900140121     C                   Kfld                    p_seq
017000131114
017100131101      * --------------------------------------------------------------------***
017200131101      * MAINLINE
017300131101      * --------------------------------------------------------------------***
017400131101      /free
017500131101
017600131125       exec sql set option datfmt = *iso ;
017700140114
017800140114       pltrst = p_trst ;
017900140114       plsub# = p_sub# ;
018000140114       account = p_acc ;
018100140114       plplan = p_plan ;
018200131125
018300131111       tsa = #fmttsa(%int(pltrst):%int(plsub#):%int(account)) ;
018400131111       exsr get_master_records ;
018500131111
018600131114       //?if error - terminate
018700131114       if errormsg <> *blanks ;
018800131114        exsr endpgm ;
018900131114       endif ;
019000131111
019100140114       //?load prtf fields
019200140114        exsr load_rate_prt ;
019300131111
019400131114       //?if error - terminate
019500131114       if errormsg <> *blanks ;
019600131114        exsr endpgm ;
019700131114       endif ;
019800131114
019900131114       exsr endpgm ;
020000131101
020100131104       //-------------------------------------------------------------------
020200131111       //?get_master_records:
020300131104       //-------------------------------------------------------------------
020400131111       begsr get_master_records ;
020500131105
020600131111        chain (pltrst:plsub#:account) acmunique ;
020700131111        chain (pltrst:plsub#:plplan) plnunique ;
020800131111        chain (pltrst:plsub#:plplan) plnauxp ;
020900131111        chain (pcarr) carunique ;
021000131111
021100131111        if not %found (plnunique) ;
021200131111         errormsg = 'Plan master record not found' ;
021300131111        elseif not %found(carunique) ;
021400131111         errormsg = 'Carrier master record not found' ;
021500131111        elseif not %found(acmunique) ;
021600131111         errormsg = 'Account master record not found' ;
021700131111        elseif not %found(plnauxp) ;
021800131111         errormsg = 'Plan Auxiliary record not found' ;
021900131113        else ;
022000131114         renewal_month = prenew ;
022100131113        rtcarrier =
022200131113         #get_exch_carrier(pltrst:plsub#:plplan:carrcd:cgrpcd) ;
022300131113         if rtcarrier = *blanks or rtcarrier = '* ERROR *' ;
022400131113          errormsg = 'Unable to retrieve Carrier x-ref' ;
022500131113         endif ;
022600131113
022700131111        endif ;
022800131108
022900131111       endsr ;
023000131104
023100131106       //-------------------------------------------------------------------
023200140114       //?load_rate_prt:
023300131106       //-------------------------------------------------------------------
023400140114       begsr load_rate_prt ;
023500140210
023600140210        l = 1 ;
023700150115        r = 1 ;
023800150115        c = 1 ;
023900150115        d = 1 ;
024000131106
024100131114        c@de20p = #rtv_code20('MONTH_TEXT':%editc(renewal_month:'X')) ;
024200131111        exsr get_rating_key_values ;
024300131111
024400131111        if errormsg <> *blanks ;
024500131111         leavesr ;
024600131111        endif ;
024700140114
024800140114        wpname = p_name ;
024900140206        wpacnm = %trim(acnam1) ;
025000140206        wpplan = %trim(pdescr) + ' (' + plplan + ')' ;
025100140206        // wpcarr = cname ;
025200140206        // wprreg = raa_state + ' ' + %trim(mdescr) ;
025300140114        wprenm = c20sdesc ;
025400131106
025500131113        exec sql declare a1 cursor for select * from agerate where
025600131106         rtcarrier = :rtcarrier and rtplnid = :pxcarpln and rteffmth =
025700131114         :prenew and rtregion = :mregion order by rtlowage, rthighage ;
025800131106
025900131106        exec sql open a1 ;
026000131106
026100131106        // Load
026200131106        dou sqlcod <> *zeros ;
026300131113         exec sql fetch a1 into :agerate:nullind_array ;
026400131106
026500131106         if sqlcod <> *zeros ;
026600131106          leave ;
026700131106         endif ;
026800131106
026900140206         // Print Header
027000171120         // if head_printed = 'N' ;
027100140206            // wpmetl = rtmetalvl ;
027101171113
027102171113      // Print inserter mark for non page 1 - this sheet will go with
027103171113      // the cobra letter at the end
027104171113            write insp2;
027105171113
027200140121         if p_seq = 0 ;
027300140206            write prthdr ;
027400140206            write prttext ;
027500140121         else ;
027600140121            write prthdrd ;
027700140206            write prttext ;
027800140121         endif ;
027801171120
027900171120          //  head_printed = 'Y' ;
028000171120         //   endif ;
028100140120
028200140120         // Add surcharge
028300140120        if gbspct > *zeros ;
028400140120        eval(h) gbsfee = rtsmoker * gbspct ;
028500140120        rtsmoker = rtsmoker + gbsfee ;
028600140120        eval(h) gbsfee = rtnsmkr * gbspct ;
028700140120        rtnsmkr = rtnsmkr + gbsfee ;
028800140120        endif ;
028900140114
029000150220        if ISO#REQ >= RTEFFDTE AND ISO#REQ <= RTTRMDTE ;
029100150220
029200150115         select ;
029300150115         when l < 26 ;
029400140210         aage(l) = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
029500140210         asmk(l) = '$' + %trim(%editc(rtsmoker:'J')) ;
029600140210         ansm(l) = '$' + %trim(%editc(rtnsmkr:'J')) ;
029700140210         l = l+1 ;
029800150115         when r < 26 ;
029900140210         bage(r) = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
030000140210         bsmk(r) = '$' + %trim(%editc(rtsmoker:'J')) ;
030100140210         bnsm(r) = '$' + %trim(%editc(rtnsmkr:'J')) ;
030200140210         r = r+1 ;
030300150115         when c < 26 ;
030400150115         cage(c) = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
030500150115         csmk(c) = '$' + %trim(%editc(rtsmoker:'J')) ;
030600150115         cnsm(c) = '$' + %trim(%editc(rtnsmkr:'J')) ;
030700150115         c = c+1 ;
030800150115         when d < 26 ;
030900150115         dage(d) = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
031000150115         dsmk(d) = '$' + %trim(%editc(rtsmoker:'J')) ;
031100150115         dnsm(d) = '$' + %trim(%editc(rtnsmkr:'J')) ;
031200150115         d = d+1 ;
031300150115         endsl ;
031400150220
031500150220        endif ;
031600131106
031700131106        enddo ;
031800131106
031900131111        exec sql close a1 ;
032000131114        rates_loaded = 'Y' ;
032100140210
032200140210          for idx = 1 to 25 ;
032300140210          wpagerate = aage(idx) ;
032400140210          wpsmoker  = asmk(idx) ;
032500141015          wpnsmkr   = ansm(idx) ;
032600140210          wxagerate = bage(idx) ;
032700140210          wxsmoker  = bsmk(idx) ;
032800141015          wxnsmkr   = bnsm(idx) ;
032900140210        write prtdtl ;
033000140210          endfor ;
033100150115
033200150115          if  c > 1 ;
033300150115          for idx = 1 to 25 ;
033400150115          wpagerate = cage(idx) ;
033500150115          wpsmoker  = csmk(idx) ;
033600150115          wpnsmkr   = cnsm(idx) ;
033700150115          wxagerate = dage(idx) ;
033800150115          wxsmoker  = dsmk(idx) ;
033900150115          wxnsmkr   = dnsm(idx) ;
034000150115        write prtdtl ;
034100150115          endfor ;
034200150115          endif  ;
034300140210
034400140210       endsr ;
034500131106
034600131111       //-------------------------------------------------------------------
034700131111       //?get_rating_key_values:
034800131111       //-------------------------------------------------------------------
034900131111       begsr get_rating_key_values ;
035000131111
035100131111        //?external functions to rtv physical addr, retrieve rating region,
035200131111        //?retrieve exchange carrier...
035300131111        ds@return = #rtv_accaddr(pltrst:plsub#:account) ;
035400160602
035500160602        //?test
035600160602         p_acct_region = #get_acct_region(pltrst:plsub#:account:'M':
035700160602                         ineff:cgrpcd) ;
035800160602         if p_region <> '*ERROR*' ;
035900160602        mregion = p_region ;
036000160602        raa_state = p_state ;
036100160602        else ;
036200160602        mregion = #get_rating_region(raa_state:raa_county) ;
036300160602        endif ;
036400160602
036500160602
036600131111        mdescr = #get_region_descr(raa_state:mregion) ;
036700131113        if mdescr = *blanks ;
036800131111         errormsg = 'Unable to determine rating region' ;
036900131111        endif ;
037000131111
037100131111       endsr ;
037200131114
037300131114       //?------------------------------------------------------------------
037400131114    ?  // endpgm:  terminate program normally
037500131114       //?------------------------------------------------------------------
037600131114       begsr endpgm ;
037700140121
037800140121         if p_seq <> 0 ;
037900140121            p_name = %trim(wdname) ;
038000140121         endif;
038100131114
038200131114        *inlr = *on ;
038300131114        return ;
038400131114
038500131114       endsr ;
038600131114
038700131101       //?------------------------------------------------------------------
038800131101    ?  // Initialization
038900131101       //?------------------------------------------------------------------
039000131108       begsr *inzsr ;
039100131125
039200131101
039300131108       endsr ;
039400131101       //?------------------------------------------------------------------
039500131101
039600131101      /end-free
