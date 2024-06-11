000100150710     H option(*nodebugio) debug
000200150710     H bnddir('ALLSRVPGMN':'GBSBIND')
000300150710     H dftactgrp(*no) actgrp(*caller) alwnull(*usrctl)
000400131114      *-------------------------------------------------------------------------
000500131114      *    G R O U P   B E N E F I T   S E R V I C E S
000600131114      *-------------------------------------------------------------------------
000700131114      *  Program: FI036R
000800131111    ? *  Description: Show plan rates or benefits based on *entry parm
000900131114    ? *  Written by:  Debora Bond
001000131114    ? *  Date Written:11/11/2013
001100131105    ? *
001200131105    ? *  (c)Copyright 2009 by GBS, Inc.
001300131105    ? *  This document contains restricted materials of GBS,Inc.
001400131105    ? *
001500131105    ? *_________________________________________________________________________
001600131105    ? *  Modifications:
001700140106      * 01/06/2014 dpb  Pull plan description from PLNUNIQUE
001800140228      * 02/28/2014 dpb  Use region from ACARGRP (via external function)
001900140303      *                 (also switched to use ACASRVPGM instead of HCRSRVPGM)
002000140401      * 04/01/2014 dpb  If no rates found for "today" allow user to specify
002100140401      *                 date to use
002200140521      * 05/21/2014 dpb  Allow user to select ACARGRP rcd via window sfl
002300140522      *                 (to see past, current or future rates)
002400140818      * 08/18/2014 dpb  Use new function #get_plan_benefit for plan benefits
002500150519      * 05/19/2015 JT   Fixed loading of rates after user selects ACARGRP rcd
002600150519      *                 via window sfl (as added by dpd on 05/21/2014 above).
002700150623      * 06/23/2015 B.Rees  Modified the SHPLNK File. Also changed the key.
002800150710      * 07/10/2015 B.Rees  Removed the SHPLNK File.
002900150710      * br03               Added GBSBIND Binding Directory.
003000150817      *                    New Function being used: #GETLINK  (RPGSPBETA)
003100150623      *
003200131105    ? *_________________________________________________________________________
003300131111     Ffi036d    cf   e             workstn infds(dspf_infds)
003400131106     F                                     sfile(sfl01:sfl_1_rrn)
003500140521     F                                     sfile(wdwsfl01:wsfl_1_rrn)
003600131101     Fplnunique if   e           k disk
003700131104     Fplnauxp   if   e           k disk
003800131101     Fcarunique if   e           k disk
003900131107     Facmunique if   e           k disk
004000140521     Facargrp   if   e           k disk
004100140521     Fageratel1 if   e           k disk
004200141117     Fexagerate if   e           k disk    rename(exagerate:exratef)
004300150330     Fcodes     if   e           k disk    ExtDesc('F.CODES')
004400150330     F                                     ExtFile(*extdesc)
004500150710br03 f* ShpLnk    if   e           k disk
004600150402
004700131104      *?Stand alone fields
004800131111     D inqtype         s              8
004900131106     D account         s                   like(pxacct)
005000131125     D nullind_array   s              4b 0 dim(16) inz
005100140819     D show_err_flag   s              1    inz('Y')
005200140401     D eff_date        s                   like(p_agrnwlfr)
005300131106
005400131104      *?Data structures
005500140521     D sfl_ds          ds                  inz
005600140521     D  sfl_1_rrn                          like(sfl_1_pos)
005700140521     D  wsfl_1_rrn                         like(sfl_1_pos)
005800140521     D  high_1_rrn                         like(sfl_1_pos)
005900140521     d  sfl_1_pos
006000140521
006100131107     D rateregion    e ds                  inz
006200131104
006300131104      *?DSPF infds
006400131101     D dspf_infds      ds
006500131105     D dspfname          *file
006600131101     d  function_key         369    369
006700131101
006800131101     D               esds                  extname(iopgmd)
006900150330     D @Type           s              1
007000150330     D @Code           s              2
007100150330     D
007200131101
007300150402      *?Procedure to call FI036C
007400150402     D FI036CL         PR                  ExtPgm('FI036CL')
007500150402     D                              255
007600150402
007700150710br03 d slLink          s            255
007800150402
007900131101      /copy qcpysrc,FKEYS_ILE
008000150710br03  /Copy RpgspBeta/qModSrc,#GetLinkpr
008100150710
008200131106      *?Prototypes
008300140304      /define get_region_descr_pr
008400140304      /define get_region_descr_fields
008500140304      /define zip_closesrv_pr
008600140304      /copy qcpysrc,zipsrvpgmp
008700140304      /undefine get_region_descr_pr
008800140304      /undefine get_region_descr_fields
008900140304      /undefine zip_closesrv_pr
009000140304
009100140303      /define get_plan_type_pr
009200140303      /define get_plan_type_fields
009300140304      /define pln_closesrv_pr
009400140818      /define get_plan_benefit_pr
009500140818      /define get_plan_benefit_fields
009600140818      /define get_plan_benefit_return
009700150330br01  /define get_shop_benefit_pr
009800150330br01  /define get_shop_benefit_fields
009900150330br01  /define get_shop_benefit_return
010000150330br02  /define get_shop_benefit_d_pr
010100150330br02  /define get_shop_benefit_d_fields
010200150330br02  /define get_shop_benefit_d_return
010300140819      /copy qcpysrc,plnsrvpgmp
010400140818      /undefine get_plan_benefit_return
010500140818      /undefine get_plan_benefit_pr
010600140818      /undefine get_plan_benefit_fields
010700140303      /undefine get_plan_type_pr
010800140303      /undefine get_plan_type_fields
010900140304      /undefine pln_closesrv_pr
011000150330br01  /undefine get_shop_benefit_return
011100150330br01  /undefine get_shop_benefit_pr
011200150330br01  /undefine get_shop_benefit_fields
011300150330br02  /undefine get_shop_benefit_d_return
011400150330br02  /undefine get_shop_benefit_d_pr
011500150330br02  /undefine get_shop_benefit_d_fields
011600131104
011700140303      /define get_exch_carrier_pr
011800140303      /define get_exch_carrier_fields
011900140228      /define get_acct_region_pr
012000140228      /define get_acct_region_fields
012100140228      /define get_acct_region_return
012200140401      /copy qcpysrc,acasrvpgmp
012300140228      /undefine get_acct_region_pr
012400140228      /undefine get_acct_region_fields
012500140228      /undefine get_acct_region_return
012600140303      /undefine get_exch_carrier_fields
012700140303      /undefine get_exch_carrier_pr
012800131106
012900131107      /copy qmodsrc,#fmttsapr
013000131107
013100131105     C     *entry        plist
013200131105     C                   parm                    pltrst
013300131105     C                   parm                    plsub#
013400131106     C                   parm                    plplan
013500131106     C                   parm                    account
013600131111     C                   parm                    inqtype
013700131114
013800131101      * --------------------------------------------------------------------***
013900131101      * MAINLINE
014000131101      * --------------------------------------------------------------------***
014100131125
014200131111       tsa = #fmttsa(%int(pltrst):%int(plsub#):%int(account)) ;
014300131111       exsr get_master_records ;
014400131111
014500131114       //?if error - terminate
014600131114       if errormsg <> *blanks ;
014700131114        exsr show_error ;
014800131114        exsr endpgm ;
014900131114       endif ;
015000131111
015100140818       exsr get_rating_key_values ;
015200140818
015300140818       //?if error - terminate
015400140818       if errormsg <> *blanks ;
015500140818        exsr show_error ;
015600140818        exsr endpgm ;
015700140818       endif ;
015800140818
015900131118       //?load dspf fields based on *entry parm "inqtype"
016000131114       if inqtype = 'RATES' ;
016100131114        exsr load_rate_sfl ;
016200131114       elseif inqtype = 'BENEFITS' ;
016300150326          if pxExChg = 'Y';
016400150330             // Medical / Dental
016500150330             if Action = 'M';
016600150330                exsr get_plan_benefits_shop;
016700150330             endif;
016800150330
016900150330             if Action = 'D';
017000150330                exsr get_plan_benefits_shop_D;
017100150330             EndIf;
017200150330          else;
017300150326             exsr get_plan_benefits ;
017400150326          endif;
017500131114       endif ;
017600131111
017700131114       //?if error - terminate
017800131114       if errormsg <> *blanks ;
017900131114        exsr show_error ;
018000131114        exsr endpgm ;
018100131114       endif ;
018200131114
018300131114       dow function_key <> #f3 ;
018400131114
018500131111        if inqtype = 'RATES' ;
018600140819         exsr load_rate_sfl ;
018700131114         exsr show_rate_sfl ;
018800131111        elseif inqtype = 'BENEFITS' ;
018900150330
019000150326          if pxExChg = 'Y';
019100150330             if Action = 'M';
019200150330                exsr get_plan_benefits_shop;
019300150330                exsr show_benefits_Shop ;
019400150330             endif;
019500150330
019600150330             if Action = 'D';
019700150330                exsr get_plan_benefits_shop_D;
019800150330                exsr show_benefits_Shop_D;
019900150330             endif;
020000150330
020100150326          else;
020200150326             exsr get_plan_benefits ;
020300150326             exsr show_benefits ;
020400150326          endif;
020500150326
020600131111        endif ;
020700131114
020800131114       enddo ;
020900131114
021000131114       exsr endpgm ;
021100131101
021200131104       //-------------------------------------------------------------------
021300131111       //?get_master_records:
021400131104       //-------------------------------------------------------------------
021500131111       begsr get_master_records ;
021600131105
021700131111        chain (pltrst:plsub#:account) acmunique ;
021800131111        chain (pltrst:plsub#:plplan) plnunique ;
021900131111        chain (pltrst:plsub#:plplan) plnauxp ;
022000131111        chain (pcarr) carunique ;
022100150330
022200150330        @Type = %Subst(PlnCat : 1 : 1);
022300150330        @Code = %Subst(PlnCat : 2 : 2);
022400150330        chain (@Type : @Code ) Codes;
022500150330
022600150330
022700131111        if not %found (plnunique) ;
022800131111         errormsg = 'Plan master record not found' ;
022900131111        elseif not %found(carunique) ;
023000131111         errormsg = 'Carrier master record not found' ;
023100131111        elseif not %found(acmunique) ;
023200131111         errormsg = 'Account master record not found' ;
023300131111        elseif not %found(plnauxp) ;
023400131111         errormsg = 'Plan Auxiliary record not found' ;
023500131113        else ;
023600140106         plandescr = pdescr ;
023700131113        rtcarrier =
023800131113         #get_exch_carrier(pltrst:plsub#:plplan:carrcd:cgrpcd) ;
023900131113         if rtcarrier = *blanks or rtcarrier = '* ERROR *' ;
024000131113          errormsg = 'Unable to retrieve Carrier x-ref' ;
024100131113         endif ;
024200131113
024300131111        endif ;
024400131108
024500131111       endsr ;
024600131104
024700131108       //-------------------------------------------------------------------
024800131108       //?show_rate_sfl:
024900131108       //-------------------------------------------------------------------
025000131108       begsr show_rate_sfl ;
025100131108
025200131114        if sfl_1_rrn= *zeros ;
025300140819         errormsg = 'No Rates found for rating period.' ;
025400131114        endif ;
025500131114
025600140819        reset show_err_flag ;
025700131114
025800131114        dow 1 = 1 ;
025900131108
026000131108         write cmdkey1 ;
026100140819         if sfl_1_rrn = *zeros and show_err_flag = 'Y' ;
026200131114          write sfc01 ;
026300131114          exfmt wdwerror ;
026400140819          show_err_flag = 'N' ;
026500131114         else ;
026600131114          exfmt sfc01 ;
026700131114         endif ;
026800131108
026900131108         select ;
027000131108          when function_key = #f3 ;
027100131108           leave ;
027200131114          when function_key = #f9 ;
027300131114           inqtype = 'BENEFITS' ;
027400131114           leave ;
027500140521          when function_key = #f10 ;
027600140521           exsr show_acargrp_records ;
027700140819           if select = '1' ;
027800140521            leave ;
027900140521           endif ;
028000131108          when function_key = #f17 ;
028100131108           sfl_1_pos = 1 ;
028200131108          when function_key = #f18 ;
028300131108           sfl_1_pos = high_1_rrn  ;
028400131108         endsl ;
028500131108
028600131108        enddo ;
028700131108
028800131108       endsr ;
028900131108
029000131106       //-------------------------------------------------------------------
029100131106       //?load_rate_sfl:
029200131106       //-------------------------------------------------------------------
029300131106       begsr load_rate_sfl ;
029400140228
029500140401        exsr init_subctl ;
029600140401
029700140521        // Load sfl with rates
029800141117        if pxexchg = 'Y' ;
029900141117         setll (rtcarrier:pxcarpln:p_region:rteffmth:rate_from) exagerate ;
030000141117        else ;
030100141117         setll (rtcarrier:pxcarpln:p_region:rteffmth:rate_from) ageratel1 ;
030200141117        endif ;
030300141117
030400141117        dou %eof ;
030500141117         if pxexchg = 'Y' ;
030600141117          reade (rtcarrier:pxcarpln:p_region:rteffmth) exagerate ;
030700141117         else ;
030800141117          reade (rtcarrier:pxcarpln:p_region:rteffmth) ageratel1 ;
030900141117         endif ;
031000140521
031100141117         if %eof ;
031200131106          leave ;
031300131106         endif ;
031400131106
031500140521         if rteffdte > rate_from or rttrmdte < rate_to ;
031600140521          iter ;
031700140521         endif ;
031800140521
031900131106         // Add to sfl then clear sfl format
032000131106         sfl_1_rrn += 1 ;
032100131106         ageband = %editc(rtlowage:'X') + '-' + %editc(rthighage:'X') ;
032200131106         metallevel = rtmetalvl ;
032300131106         write sfl01 ;
032400131106         clear sfl01 ;
032500131106
032600131106        enddo ;
032700131106
032800131111        // If sfl has records, turn on sfl control/dsp indicators
032900131111        if sfl_1_rrn > *zeros ;
033000131111         %subarr(*in:42:2) = *On ;
033100131106         sfl_1_pos = 1 ;
033200131107         high_1_rrn = sfl_1_rrn ;
033300131107         *in99 = *on ; // sflend indicator
033400131106        endif ;
033500131111
033600131106       endsr ;
033700131106
033800140401       //-------------------------------------------------------------------
033900140401       //?init_subctl:
034000140401       //-------------------------------------------------------------------
034100140401       begsr init_subctl ;
034200140401
034300140401        // Initialize subfile control record...
034400140401        *in40 = *On ; // sflclr keyword on control record
034500140401        write sfc01 ;
034600140401        *in40 = *Off ;
034700140401        *in41 = *On ;
034800140521        *in42 = *Off ;
034900140521        clear sfl_ds ;
035000140521        clear errormsg ;
035100140401
035200140401       endsr ;
035300140401
035400131111       //-------------------------------------------------------------------
035500131111       //?get_rating_key_values:
035600131111       //-------------------------------------------------------------------
035700131111       begsr get_rating_key_values ;
035800131111
035900140401        //?determine plan type                                              )
036000140228        agpdt = #get_plan_type(plncat) ; // plan type (medical, dental)
036100140401
036200140401        //?get region & plan renewal dates from ACARGRP (region renewal file)
036300140401        exsr get_rating_region ;
036400140401        if errormsg <> *blanks ;
036500140401         leavesr ;
036600140401        endif ;
036700140401
036800140401        mdescr = #get_region_descr(p_state:p_region) ;
036900140401        if mdescr = *blanks ;
037000140401         errormsg = 'Rating region of ' + p_region + ' is invalid.' ;
037100140401        else ;
037200140401         monitor ;
037300140401          rate_from = %date(p_agrnwlfr) ;
037400140401          rate_to = %date(p_agrnwlto) ;
037500140401          rteffmth = %subdt(rate_from:*m) ;
037600140401         on-error ;
037700140401          errormsg = 'Invalid ACARGRP renewal dates' ;
037800140401         endmon ;
037900140401        endif ;
038000140401
038100131111       endsr ;
038200131111
038300131111       //-------------------------------------------------------------------
038400131111       //?show_benefits:
038500131111       //-------------------------------------------------------------------
038600131111       begsr show_benefits ;
038700140819
038800140819        reset show_err_flag ;
038900131114
039000131114        dow 1 = 1 ;
039100140819         if errormsg <> *blanks and show_err_flag = 'Y' ;
039200140819          write screen02 ;
039300140819          exfmt wdwerror ;
039400140819          show_err_flag = 'N' ;
039500140819         else ;
039600140819          exfmt screen02 ;
039700140819         endif ;
039800131111
039900131114         select ;
040000131114          when function_key = #f3 ;
040100131114           leave ;
040200131114          when function_key = #f8 ;
040300131114           inqtype = 'RATES' ;
040400131114           leave ;
040500140819          when function_key = #f10 ;
040600140819           exsr show_acargrp_records ;
040700140819           if select = '1' ;
040800140819            leave ;
040900140819           endif ;
041000131114         endsl ;
041100131114
041200131111        enddo ;
041300131111
041400131111       endsr ;
041500140401
041600150326
041700150326       //-------------------------------------------------------------------
041800150326       //?show_benefits_Shop
041900150326       //-------------------------------------------------------------------
042000150326       begsr show_benefits_Shop ;
042100150326
042200150326        reset show_err_flag ;
042300150326
042400150326        dow 1 = 1 ;
042500150326         if errormsg <> *blanks and show_err_flag = 'Y' ;
042600150326          write screen03 ;
042700150326          exfmt wdwerror ;
042800150326          show_err_flag = 'N' ;
042900150326         else ;
043000150326          exfmt screen03 ;
043100150326         endif ;
043200150326
043300150326         select ;
043400150326          when function_key = #f3 ;
043500150326           leave ;
043600150326          when function_key = #f8 ;
043700150326           inqtype = 'RATES' ;
043800150326           leave ;
043900150326          when function_key = #f10 ;
044000150326           exsr show_acargrp_records ;
044100150326           if select = '1' ;
044200150326            leave ;
044300150326           endif ;
044400150402          when function_key = #f11 ;
044500150402            if *in70 = *on;
044600150710                 Fi036CL(s3Link);
044700150402            endif;
044800150402
044900150402
045000150326         endsl ;
045100150326
045200150326        enddo ;
045300150326
045400150326       endsr ;
045500150330
045600150330       //-------------------------------------------------------------------
045700150330       //?show_benefits_Shop - DENTAL
045800150330       //-------------------------------------------------------------------
045900150330       begsr show_benefits_Shop_D ;
046000150330
046100150330        reset show_err_flag ;
046200150330
046300150330        dow 1 = 1 ;
046400150330         if errormsg <> *blanks and show_err_flag = 'Y' ;
046500150330          write screen04 ;
046600150330          exfmt wdwerror ;
046700150330          show_err_flag = 'N' ;
046800150330         else ;
046900150330          exfmt screen04 ;
047000150330         endif ;
047100150330
047200150330         select ;
047300150330          when function_key = #f3 ;
047400150330           leave ;
047500150330          when function_key = #f8 ;
047600150330           inqtype = 'RATES' ;
047700150330           leave ;
047800150330          when function_key = #f10 ;
047900150330           exsr show_acargrp_records ;
048000150330           if select = '1' ;
048100150330            leave ;
048200150330           endif ;
048300150402          when function_key = #f11 ;
048400150402            if *in70 = *on;
048500150710               Fi036CL(s4Link);
048600150402            endif;
048700150330         endsl ;
048800150330
048900150330        enddo ;
049000150330
049100150330       endsr ;
049200150330
049300131111       //-------------------------------------------------------------------
049400131111       //?get_plan_benefits:
049500131111       //-------------------------------------------------------------------
049600131111       begsr get_plan_benefits ;
049700131111
049800140819        exsr init_screen02 ;
049900140818        p_planbenf = #get_plan_benefit(pltrst:plsub#:plplan:eff_date) ;
050000140818
050100140819        if pbplntype <> '*ERROR*' ;
050200131111         plantype = pbplntype ;
050300131111         plancopay = pbcopay ;
050400131111         rxdescr = pbrxcard ;
050500131111         evalr in_coins = pbcoinsin ;
050600131111         evalr out_coins = pbcoinsout ;
050700131111         evalr in_deduct = pbdedin ;
050800131111         evalr out_deduct = pbdedout ;
050900140819        else ;
051000140819         errormsg = 'No Benefit records found for rating period.' ;
051100140819        endif ;
051200140228
051300131111       endsr ;
051400131111
051500150326       //-------------------------------------------------------------------
051600150326       //?get_plan_benefits_Shop:
051700150326       //-------------------------------------------------------------------
051800150326       begsr get_plan_benefits_shop ;
051900150326
052000150326        exsr init_screen03 ;
052100150326
052200150326        p_ShpBenp = #get_shop_benefit(pltrst:plsub#:plplan:eff_date) ;
052300150326
052400150326        if sbPtyp <> '*ERROR*' ;
052500150326         plantype = sbptyp ;
052600150326         plancopay = pbcopay ;
052700150326         rxdescr = pbrxcard ;
052800150327
052900150327         s3Serf = sbsrfd;
053000150327         s3mhbe = sbmhbd;
053100150327         s3Metal = sbmlvl;
053200150327         s3pcin = sbpcin;
053300150327         s3scin = sbscin;
053400150327         s3rfrq = sbrfrq;
053500150327
053600150327         s3pddd = sbpddd;
053700150327         s3intm = sbintm;
053800150327
053900150327         evalr out_deduct = %trim(sbmdot) ;
054000150327         if sbmdot = 'NOTCOV';
054100150327            evalr out_deduct = 'NOT COVERED';
054200150327         EndIf;
054300150327
054400150327         evalr s3opco = %trim(sbopco);
054500150327         if sbopco = 'NOTCOV';
054600150327            evalr s3opco = 'NOT COVERED';
054700150327         EndIf;
054800150327
054900150327
055000150327         evalr in_coins  = %trim(sbcoadi);
055100150327         evalr out_coins = %trim(sbcoado) ;
055200150327         evalr in_deduct = %trim(sbmdin);
055300150327
055400150330         s3drci = %trim(sbdrci);
055500150330         s3drco = %trim(sbdrco);
055600150327         evalr s3opci = %trim(sbopci);
055700150327
055800150330         s3Pcp_Req = 'NO';
055900150330         if pcp_Req = 'Y';
056000150330            s3Pcp_Req = 'YES';
056100150330         endif;
056200150330
056300150402         //?Get WebSite
056400150402         *in70 = *off;
056500160417         slLink = #GetLink(plTrst : plSub# : plPlan : eff_date);
056600150710         if slLink > *Blanks;
056700160602          //   *in70 = *on;
056800160602         //    s3Link = slLink;
056900150710         endif;
057000150710
057100150402
057200150402
057300150326        else ;
057400150326         errormsg = 'No Benefit records found for rating period.' ;
057500150326        endif ;
057600150326
057700150326       endsr ;
057800150326
057900150330       //-------------------------------------------------------------------
058000150330       //?get_plan_benefits_Shop_D   DENTAL
058100150330       //-------------------------------------------------------------------
058200150330       begsr get_plan_benefits_shop_D ;
058300150330
058400150330        exsr init_screen04 ;
058500150330
058600150330        p_ShpDntlp = #get_shop_benefit_d(pltrst:plsub#:plplan:eff_date) ;
058700150330
058800150330        if sdptyp <> '*ERR' ;
058900150330         plantype = sdptyp ;
059000150330
059100150330         s4Serf = sdsrfd;
059200150330         s4mhbe = sdmhbd;
059300150330
059400150330         s4Clas1 = sdClas1;
059500150330         s4Clas2 = sdClas2;
059600150330         s4Clas3 = sdClas3;
059700150330         s4Clas4 = sdClas4;
059800150330         s4Clas5 = sdClas5;
059900150330
060000150330         s4indDed = sdIndDed;
060100150330         s4FamDed = sdFamDed;
060200150330         s4PlnPmt = sdPlnPmt;
060300150330
060400150402         //?Get WebSite
060500150402         *in70 = *off;
060600160417         slLink = #GetLink(plTrst : plSub# : plPlan : eff_date);
060700150710         if slLink > *Blanks;
060800160602           //  *in70 = *on;
060900160602           //  s4Link = slLink;
061000150710         endif;
061100150402
061200150402
061300150330        else ;
061400150330         errormsg = 'No Benefit records found for rating period.' ;
061500150330        endif ;
061600150330
061700150330       endsr ;
061800150330
061900140401       //-------------------------------------------------------------------
062000140401       //?get_rating_region: Get rating region record from ACARGRP.  If not
062100140401       //?found allow user to change the date used in retrieval.
062200140401       //-------------------------------------------------------------------
062300140401       begsr get_rating_region ;
062400140401
062500140401        dow 1 = 1 ;
062600140401         p_acct_region = #get_acct_region(pltrst:plsub#:account:agpdt:
062700140610                         eff_date:cgrpcd) ;
062800140401
062900140401         if p_region = '*ERROR*' ;
063000140401          rate_date = %date(eff_date:*iso) ;
063100140401          wdwerrmsg = 'Rating Region not found for ' + %char(rate_date:*usa)
063200140401                      + '.  Please enter new date.' ;
063300140401          exsr allow_date_change ;
063400140401          if errormsg <> *blanks ;
063500140401           leave ;
063600140401          endif ;
063700140401          eff_date = %int(%char(rate_date:*iso0)) ;
063800140401         else ;
063900140401          leave ;
064000140401         endif ;
064100140401
064200140401        enddo ;
064300140401
064400140401       endsr ;
064500140401
064600140401       //-------------------------------------------------------------------
064700140401       //?allow_date_change:
064800140401       //-------------------------------------------------------------------
064900140401       begsr allow_date_change ;
065000140401
065100140401        write cmdkey1 ;
065200140401        write sfc01 ;
065300140401        exfmt wdwdateprm ;
065400140401
065500140401        clear errormsg ;
065600140401
065700140401        if function_key = #f12 ;
065800140401         errormsg = 'Rating Region record not found for ' +
065900140401                    %char(rate_date:*usa) ;
066000140401        endif ;
066100140401
066200140401       endsr ;
066300140401
066400140521       //-------------------------------------------------------------------
066500140521       //?show_acargrp_records:
066600140521       //-------------------------------------------------------------------
066700140521       begsr show_acargrp_records ;
066800140521
066900140521        clear wsfl_1_rrn ;
067000140521        clear wdwsfl01 ;
067100140521        *in91 = *off ; // sflclr keyword indicator
067200140521        write wdwctl01 ;
067300140521        *in91 = *on ;
067400140521
067500140819        setll (pltrst:plsub#:account:agpdt:cgrpcd) acargrp ;
067600140521        dou %eof(acargrp) ;
067700140819         reade (pltrst:plsub#:account:agpdt:cgrpcd) acargrp ;
067800140521
067900140521         if %eof(acargrp) ;
068000140521          leave ;
068100140521         endif ;
068200140521
068300140521         // Add to window subfile
068400140521         date_from = %date(agrnwlfr:*iso) ;
068500140521         date_to = %date(agrnwlto:*iso) ;
068600140521         wsfl_1_rrn += 1 ;
068700140521         write wdwsfl01 ;
068800140521
068900140521        enddo ;
069000140521
069100140521        // If sfl has records, turn on sfl control/dsp indicators
069200140521        if wsfl_1_rrn > *zeros ;
069300140521         *in92 = *on ; // sflend & sfldsp indicator
069400140521        endif ;
069500140521
069600140521        //?show subfile....f12 = cancel...else READC until select = '1'
069700140521        write window ;
069800140521        exfmt wdwctl01 ;
069900140521
070000140521        if function_key = #f12 or wsfl_1_rrn = *zeros ;
070100140521         leavesr ;
070200140521        endif ;
070300140521
070400140521        dow 1 = 1 ;
070500140521         readc wdwsfl01 ;
070600140521
070700140521         if %eof or select = '1' ;
070800140521          if select = '1' ;
070900140521           eff_date = agrnwlfr ;
071000140819           rate_from = %date(agrnwlfr) ;
071100150519            rate_to = %date(agrnwlto) ;
071200150519            rteffmth = %subdt(rate_from:*m) ;
071300150519           p_region = agratrgn ;
071400140521          endif ;
071500140521          leave ;
071600140521         endif ;
071700140521
071800140521        enddo ;
071900140521
072000150519        exsr get_rating_key_values ;
072100150519        mdescr = #get_region_descr(p_state:p_region) ;
072200150519
072300140521       endsr ;
072400140521
072500131114       //?------------------------------------------------------------------
072600131114    ?  // show_error:  show error window
072700131114       //?------------------------------------------------------------------
072800131114       begsr show_error ;
072900131114
073000131114        if inqtype = 'RATES' ;
073100131114         *in41 = *On ; //sfldspctl *indicator
073200131114         write cmdkey1 ;
073300131114         write sfc01 ;
073400131114        else ;
073500131114         write screen02 ;
073600131114        endif ;
073700131114        exfmt wdwerror ;
073800131114
073900131114       endsr ;
074000131114
074100140819       //-------------------------------------------------------------------
074200140819       //?init_screen02:
074300140819       //-------------------------------------------------------------------
074400140819       begsr init_screen02 ;
074500140819
074600140819        clear plantype ;
074700140819        clear plancopay ;
074800140819        clear rxdescr ;
074900140819        clear in_coins ;
075000140819        clear out_coins ;
075100140819        clear in_deduct ;
075200140819        clear out_deduct ;
075300140819        clear errormsg ;
075400140819
075500140819       endsr ;
075600140819
075700150326       //-------------------------------------------------------------------
075800150326       //?init_screen03:
075900150326       //-------------------------------------------------------------------
076000150326       begsr init_screen03 ;
076100150326
076200150326        clear plantype ;
076300150326        clear plancopay ;
076400150326        clear errormsg ;
076500150326
076600150326       endsr ;
076700150330
076800150330       //-------------------------------------------------------------------
076900150330       //?init_screen04:
077000150330       //-------------------------------------------------------------------
077100150330       begsr init_screen04 ;
077200150330
077300150330        clear plantype ;
077400150330        clear plancopay ;
077500150330        clear errormsg ;
077600150330
077700150330       endsr ;
077800131114       //?------------------------------------------------------------------
077900131114    ?  // endpgm:  terminate program normally
078000131114       //?------------------------------------------------------------------
078100131114       begsr endpgm ;
078200131114
078300131114        *inlr = *on ;
078400131114        return ;
078500131114
078600131114       endsr ;
078700131114
078800131101       //?------------------------------------------------------------------
078900131101    ?  // Initialization
079000131101       //?------------------------------------------------------------------
079100131108       begsr *inzsr ;
079200131125
079300140401        eff_date = %int(%char(%date():*iso0)) ;
079400131101
079500131108       endsr ;
079600131101       //?------------------------------------------------------------------
079700131101
