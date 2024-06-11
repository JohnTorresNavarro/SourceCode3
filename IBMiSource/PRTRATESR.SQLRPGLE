000100140611     Hoption(*nodebugio) debug bnddir('ALLSRVPGMN':'RPGSPPAYR/GBSBDIR')
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
001500140313    ? *          This program was cloned from FI036R it prints the
001600140313    ? *          rates for COBRA member term notices.
001700131105    ? *
001800131105    ? *_________________________________________________________________________
001900131105    ? *  Modifications:
002000140819      *  08/19/2014 DPB Removed ext DS planbenf...not used.....
002100141017      *  10/17/2014 bug fix on column 2 of report
002200150220      *  02/20/2015 bug fix on date ranges
002300150618      *  06/18/2015 B.Rees   Br01
002400150618      *   Issue when printing from the Cobra Reports. Cobra Members who had a
002500150618      *   current Plan AND a future Plan in F.MCOV.  The lastest date in F.MCOV
002600150618      *   would be listed in the COBRA report and entered into the PRTRATESP
002700150618      *   File.   I am Removing the check for the Effective Date from the
002800150618      *   load_rate_prt Subroutine.  The modification will skip printing a
002900150618      *   rate sheet if the Expiration date has passed, but will now print
003000150618      *   a future effective Date.
003100171109      *  11/09/2017 dlk - add inserter mark (non-page 1) and reformat output
003200171113      *                   to email as pdf. Also remove smoker rate per
003300171113      *                   shelly.
003400171116      *  11/16/2017 dlk - change design to print 1 rate sheet as this
003500171120      *                   program is now called from tr172 which includes it
003600171120      *                   in the shared open printer file tr172p2 as a page
003700171116      *                   of that spool file instead of a seperate spool
003800171120      *                   file.
003900171120      *                  - changed member file to memssn since member was
004000171120      *                   already open from the query selection and it
004100171120      *                   prevented the chain from working.
004200171120      *                  - Removed memssn file since it was only used for
004300171120      *                   the member name which is already in the work file
004400171120      *                  - Removed heading control, not needed since the
004500171120      *                    rate sheet is one page and headings are needed
004600171120      *                    on every page.
004700180927      *
004800180927      *    *** Important - must recompile tr172 and prtratesr whenever a
004900180927      *        change is made to tr172p2 since both use it.
005000180927      *
005100180927      *
005200180927      *
005300171113    ? *_________________________________________________________________________
005400171116     FPRTRATESP uf   e             disk
005500171120    ?**FMEMSSN    IF   E           K DISK    EXTFILE('F.MEMSSN')
005600140313    ?FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC')
005700131101     Fplnunique if   e           k disk
005800131104     Fplnauxp   if   e           k disk
005900131101     Fcarunique if   e           k disk
006000140313     Facmunique if   e           k disk
006100140313    ?FCONTRL    IF   E           K DISK    EXTFILE('F.CONTRL')
006200171116     Ftr172p2   o    e             printer OFLIND(*IN91)
006300131101
006400131104      *?Stand alone fields
006500140220     D Tic             S              1a   inz(x'7D')
006600131111     D inqtype         s              8
006700131106     D account         s                   like(pxacct)
006800131125     D nullind_array   s              4b 0 dim(16) inz
006900171120     D** head_printed    s              1    inz('N')
007000131114     D rates_loaded    s              1    inz('N')
007100131114     D benefit_loaded  s                   inz('N') like(rates_loaded)
007200131114     D no_rates_shown  s                   inz('N') like(rates_loaded)
007300140113     D renewal_month   s              2  0
007400140113     D ssn             s              9
007500140113     D w0ssn           s              9s 0 inz
007600140114     d  p_trst         s              3s 0
007700140114     d  p_sub#         s              3s 0
007800140114     d  p_plan         s              4a
007900140114     d  p_acc          s              4s 0
008000140121     d  p_ssn          s              9s 0
008100140121     d  p_seq          s              2s 0
008200140120     d  p_pct          s              2a
008300140115     d  p_name         s             33a
008400140120     d  gbspct         s              2s 2
008500140120     d  gbsfee         s              7s 2
008600140114     d  errormsg       s            100a
008700140114     d  tsa            s             15a
008800140114     d  wpagerate      s              7a
008900140210     d  l              s              3s 0
009000140210     d  r              s              3s 0
009100140210     d  idx            s              3s 0
009200150220     d ISO#REQ         S               D   DATFMT(*ISO)
009300150220     d w80date         s              8s 0
009400171113     d wpsmoker        s             10
009500171113     d wxsmoker        s             10
009600140210
009700150624     D leftds          ds
009800150624     D  aage                          7    dim(50) inz
009900150624     D  asmk                         10    dim(50) inz
010000150624     D  ansm                         10    dim(50) inz
010100140210
010200140210     D rightds         ds
010300150624     D  bage                          7    dim(50) inz
010400150624     D  bsmk                         10    dim(50) inz
010500150624     D  bnsm                         10    dim(50) inz
010600131106
010700131104      *?Data structures
010800131113     D agerate       e ds                  inz
010900131107     D rateregion    e ds                  inz
011000131111     D c@de20p       e ds                  extname(code20p) inz
011100131101
011200131101     D               esds                  extname(iopgmd)
011300131101
011400131101      /copy qcpysrc,FKEYS_ILE
011500131104
011600131106      *?Prototypes
011700131106      /define copy_all_protos_and_fields
011800131108      /copy qcpysrc,zipsrvpgmp
011900131106      /undefine copy_all_protos_and_fields
012000131104
012100131106      /define copy_all_protos_and_fields
012200140611      /copy qcpysrc,acasrvpgmp
012300131106      /undefine copy_all_protos_and_fields
012400131106
012500131106      /define rtv_accaddr_return
012600131106      /define copy_all_protos_and_fields
012700131106      /copy qcpysrc,accsrvpgmp
012800131106      /undefine copy_all_protos_and_fields
012900131106      /undefine rtv_accaddr_return
013000131107
013100131107      /define copy_all_protos_and_fields
013200131107      /copy qcpysrc,c20srvpgmp
013300131107      /undefine copy_all_protos_and_fields
013400131106
013500131107      /copy qmodsrc,#fmttsapr
013600140313
013700171116      * read the one record in the file
013800171116       read prtratesp;
013900171116       exsr mainline;
014000171116
014100171116      * remove rec from workfile
014200171116       delete prtratr;
014300171116
014400171116      * return without setting on lr so printer file stays open
014500171116       return;
014600171116       // exsr endpgm;
014700140313
014800140313      *-----------------------------------------------------------*
014900140313     C     mainline      Begsr
015000140313      *-----------------------------------------------------------*
015100140313
015200140313     C                   eval      p_trst  = prtrs
015300140313     C                   eval      p_sub#  = prsub
015400140313     C                   eval      p_plan  = prpln
015500140313     C                   eval      p_acc   = pracc
015600140313     C                   eval      p_ssn   = prssn
015700140313     C                   eval      p_seq   = prseq
015800140313     C                   eval      p_pct   = prpct
015900140313     C                   eval      p_name  = prnam
016000150220     C                   eval      w80date = %int(%char(%date : *iso0))
016100150220     C                   move      w80date       ISO#REQ
016200140313
016300140313      /free
016400140313        chain (p_trst:p_sub#:p_acc) acmunique ;
016500140313
016600171120      //  head_printed = 'N' ;
016700140313
016800140313      /end-free
016900140313
017000140313     C                   Select
017100140313     C                   When      FCSTFL = 'F'
017200140313     C                   eval      p_pct =  canflg + aiflg
017300140313     C                   When      FCSTFL = 'S'
017400140313     C                   eval      p_pct =  ciflg + prmflg
017500140313     C                   Endsl
017600140313
017700171116    ?C                   Move      *on           *in91
017800140120     C                   move      p_pct         gbspct
017900140121 002 C                   Clear                   WDNAME
018000140121 002 C                   Clear                   p_name
018100140121
018200171120      * change to use member name from work file, so member file is not
018300171120      * needed anymore
018400171120
018500171120       p_name = prnam;
018600171120
018700171120 001 C*    p_ssn         Chain     MEMSSN
018800171120     C*                  If        %found(MEMSSN)
018900171120     C*                  If        %trim(MMI) = *blanks
019000171120     C*                  Eval      p_name = %trim(MFNAME) + ' ' +
019100171120     C*                                     %trim(MLNAME)
019200171120E002 C*                  Else
019300171120     C*                  Eval      P_name = %trim(MFNAME) + ' ' +
019400171120     C*                                     %trim(MMI)    + ' ' +
019500171120     C*                                     %trim(MLNAME)
019600171120E002 C*                  End
019700171120     C*                  End
019800171120     C     tic:'_'       Xlate     p_name        p_name
019900140121
020000140121     C                   If        p_seq <> 0
020100140121 001 C     DEPKEY        Chain     DEPNDC
020200140121     C                   If        %found(DEPNDC)
020300140121     C                   If        %trim(DMI) = *blanks
020400140121     C                   Eval      WDNAME = %trim(DFNAME) + ' ' +
020500140121     C                                      %trim(DLNAME)
020600140121E002 C                   Else
020700140121     C                   Eval      WDNAME = %trim(DFNAME) + ' ' +
020800140121     C                                      %trim(DMI)    + ' ' +
020900140121     C                                      %trim(DLNAME)
021000140121E002 C                   End
021100140121E002 C                   End
021200140220     C     tic:'_'       Xlate     wdname        wdname
021300140121E002 C                   End
021400140121
021500140121     C     DEPKEY        Klist
021600140121     C                   Kfld                    p_ssn
021700140121     C                   Kfld                    p_seq
021800131114
021900131101      * --------------------------------------------------------------------***
022000131101      * MAINLINE
022100131101      * --------------------------------------------------------------------***
022200131101      /free
022300131101
022400131125       exec sql set option datfmt = *iso ;
022500140114
022600140114       pltrst = p_trst ;
022700140114       plsub# = p_sub# ;
022800140114       account = p_acc ;
022900140114       plplan = p_plan ;
023000131125
023100131111       tsa = #fmttsa(%int(pltrst):%int(plsub#):%int(account)) ;
023200131111       exsr get_master_records ;
023300131111
023400131114       //?if error - terminate
023500131114       if errormsg <> *blanks ;
023600140313        // leaveSR ;
023700131114       endif ;
023800131111
023900140114       //?load prtf fields
024000140114        exsr load_rate_prt ;
024100131111
024200131114       //?if error - terminate
024300131114       if errormsg <> *blanks ;
024400140313        // leaveSR ;
024500131114       endif ;
024600131114
024700140313       endsr ;
024800131101
024900131104       //-------------------------------------------------------------------
025000131111       //?get_master_records:
025100131104       //-------------------------------------------------------------------
025200131111       begsr get_master_records ;
025300131105
025400131111        chain (pltrst:plsub#:account) acmunique ;
025500131111        chain (pltrst:plsub#:plplan) plnunique ;
025600131111        chain (pltrst:plsub#:plplan) plnauxp ;
025700131111        chain (pcarr) carunique ;
025800131111
025900131111        if not %found (plnunique) ;
026000131111         errormsg = 'Plan master record not found' ;
026100131111        elseif not %found(carunique) ;
026200131111         errormsg = 'Carrier master record not found' ;
026300131111        elseif not %found(acmunique) ;
026400131111         errormsg = 'Account master record not found' ;
026500131111        elseif not %found(plnauxp) ;
026600131111         errormsg = 'Plan Auxiliary record not found' ;
026700131113        else ;
026800131114         renewal_month = prenew ;
026900131113        rtcarrier =
027000131113         #get_exch_carrier(pltrst:plsub#:plplan:carrcd:cgrpcd) ;
027100131113         if rtcarrier = *blanks or rtcarrier = '* ERROR *' ;
027200131113          errormsg = 'Unable to retrieve Carrier x-ref' ;
027300131113         endif ;
027400131113
027500131111        endif ;
027600131108
027700131111       endsr ;
027800131104
027900131106       //-------------------------------------------------------------------
028000140114       //?load_rate_prt:
028100131106       //-------------------------------------------------------------------
028200140114       begsr load_rate_prt ;
028300140210
028400140210        l = 1 ;
028500140210        r = 1 ;
028600131106
028700131114        c@de20p = #rtv_code20('MONTH_TEXT':%editc(renewal_month:'X')) ;
028800131111        exsr get_rating_key_values ;
028900131111
029000131111        if errormsg <> *blanks ;
029100140313         // leavesr ;
029200131111        endif ;
029300140114
029400140114        wpname = p_name ;
029500140206        wpacnm = %trim(acnam1) ;
029600140206        wpplan = %trim(pdescr) + ' (' + plplan + ')' ;
029700140206        // wpcarr = cname ;
029800140206        // wprreg = raa_state + ' ' + %trim(mdescr) ;
029900140114        wprenm = c20sdesc ;
030000131106
030100131113        exec sql declare a1 cursor for select * from agerate where
030200131106         rtcarrier = :rtcarrier and rtplnid = :pxcarpln and rteffmth =
030300131114         :prenew and rtregion = :mregion order by rtlowage, rthighage ;
030400131106
030500131106        exec sql open a1 ;
030600131106
030700131106        // Load
030800131106        dou sqlcod <> *zeros ;
030900131113         exec sql fetch a1 into :agerate:nullind_array ;
031000131106
031100131106         if sqlcod <> *zeros ;
031200131106          leave ;
031300131106         endif ;
031400140120
031500140120         // Add surcharge
031600140120        if gbspct > *zeros ;
031700140120        eval(h) gbsfee = rtsmoker * gbspct ;
031800140120        rtsmoker = rtsmoker + gbsfee ;
031900140120        eval(h) gbsfee = rtnsmkr * gbspct ;
032000140120        rtnsmkr = rtnsmkr + gbsfee ;
032100140120        endif ;
032200140114
032300150618         // Removed Br01   6/18/2015
032400150624         if ISO#REQ >= RTEFFDTE AND ISO#REQ <= RTTRMDTE ;
032500150624         //if Iso#Req <= rtTrmDte ;
032600150618
032700140210         if  l < 26 ;
032800140210         aage(l) = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
032900140210         asmk(l) = '$' + %trim(%editc(rtsmoker:'J')) ;
033000140210         ansm(l) = '$' + %trim(%editc(rtnsmkr:'J')) ;
033100140210         l = l+1 ;
033200140210         else  ;
033300140210         bage(r) = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
033400140210         bsmk(r) = '$' + %trim(%editc(rtsmoker:'J')) ;
033500140210         bnsm(r) = '$' + %trim(%editc(rtnsmkr:'J')) ;
033600140210         r = r+1 ;
033700140210         endif ;
033800150220
033900150220        endif ;
034000131106
034100131106        enddo ;
034200131106
034300131111        exec sql close a1 ;
034400131114        rates_loaded = 'Y' ;
034500140313
034600140313         // Print Header
034700171120         //  if head_printed = 'N' ;
034800140313            // wpmetl = rtmetalvl ;
034900171109
035000171109      // Print inserter mark for non page 1 - this sheet will go with
035100171109      // the cobra letter at the end
035200171109            write insp2;
035300171109
035400140313         if p_seq = 0 ;
035500171116            write acarhdr;
035600171116            write acartext ;
035700140313         else ;
035800171116            write acarhdrd ;
035900171116            write acartext ;
036000140313         endif ;
036100171120
036200171120         // head_printed = 'Y' ;
036300171120         // endif ;
036400140210
036500140210          for idx = 1 to 25 ;
036600140210          wpagerate = aage(idx) ;
036700140210          wpsmoker  = asmk(idx) ;
036800141015          wpnsmkr   = ansm(idx) ;
036900140210          wxagerate = bage(idx) ;
037000140210          wxsmoker  = bsmk(idx) ;
037100141015          wxnsmkr   = bnsm(idx) ;
037200171116        write acardtl ;
037300140210          endfor ;
037400171116
037500140210       endsr ;
037600131106
037700131111       //-------------------------------------------------------------------
037800131111       //?get_rating_key_values:
037900131111       //-------------------------------------------------------------------
038000131111       begsr get_rating_key_values ;
038100131111
038200131111        //?external functions to rtv physical addr, retrieve rating region,
038300131111        //?retrieve exchange carrier...
038400131111        ds@return = #rtv_accaddr(pltrst:plsub#:account) ;
038500160602
038600160602        //?test
038700160602         p_acct_region = #get_acct_region(pltrst:plsub#:account:'M':
038800160602                         w80date:cgrpcd) ;
038900160602         if p_region <> '*ERROR*' ;
039000160602        mregion = p_region ;
039100160602        raa_state = p_state ;
039200160602        else ;
039300160602        mregion = #get_rating_region(raa_state:raa_county) ;
039400160602        endif ;
039500160602
039600160602
039700131111        mdescr = #get_region_descr(raa_state:mregion) ;
039800131113        if mdescr = *blanks ;
039900131111         errormsg = 'Unable to determine rating region' ;
040000131111        endif ;
040100131111
040200131111       endsr ;
040300131114
040400131114       //?------------------------------------------------------------------
040500131114    ?  // endpgm:  terminate program normally
040600131114       //?------------------------------------------------------------------
040700131114       begsr endpgm ;
040800140313
040900140313         if %open(DEPNDC) ;
041000140313            close DEPNDC ;
041100140313         endif ;
041200140313
041300171120       //  if %open(MEMSSN) ;
041400171120       //     close MEMSSN ;
041500171120       //  endif ;
041600140313
041700140313         if %open(CONTRL) ;
041800140313            close CONTRL ;
041900140313         endif ;
042000140313
042100140121
042200140121         if p_seq <> 0 ;
042300140121            p_name = %trim(wdname) ;
042400140121         endif;
042500131114
042600131114        *inlr = *on ;
042700131114        return ;
042800131114
042900131114       endsr ;
043000131114
043100131101       //?------------------------------------------------------------------
043200131101    ?  // Initialization
043300131101       //?------------------------------------------------------------------
043400131108       begsr *inzsr ;
043500131125
043600140313         if not %open(DEPNDC) ;
043700140313            open DEPNDC ;
043800140313         endif ;
043900140313
044000171120       //  if not %open(MEMSSN) ;
044100171120       //     open MEMSSN ;
044200171120       //  endif ;
044300140313
044400140313         if not %open(CONTRL) ;
044500140313            open CONTRL ;
044600140313         endif ;
044700140313
044800140313       ctype = 'C' ;
044900140313       chain (ctype) contrl ;
045000140313
045100131108       endsr ;
045200131101       //?------------------------------------------------------------------
045300131101
045400131101      /end-free
