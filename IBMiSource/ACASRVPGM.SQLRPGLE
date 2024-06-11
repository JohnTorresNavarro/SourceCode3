000100140109     H nomain option(*nodebugio) debug Copyright('GBS - GROUPBENEFITSERVICES')
000200140123     H bnddir('ACASRVPGM') ALWNULL(*USRCTL)
000300140124   X*
000400140124   X* *------------------------------------------------------------------
000500140204   X* * Module Name..: ACASRVPGM
000600140204   X* * Written By...: Debora Bond
000700140204   X* * Date Written.: 01/20/2014
000800140204   X* * Description..: Service program of exported functions related to ACA NS
000900140204   X* * Called From..: Any program
001000140124   X* *------------------------------------------------------------------
001100140124   X* * MODIFICATION HISTORY:
001200140124   X* *
001300140124   X* *    DATE    DESCRIPTION                                       BY
001400140124   X* *  --------  -----------------------------------------        ----
001500140725      *  03/17/14  #chk_acct_aca_plan:  use PLNAUXP to              DPB
001600140725      *            determine if any ACA plans.  Also added
001700140402      *            5th (optional) parm to this function to allow
001800140402      *            caller to pass a 'Y' to check for un-invoiced
001900140402      *            trans for ACA plans.
002000140321      *  03/19/14  added "monitor" operation to age calc - trap     DPB
002100140321      *            error (overflow of numeric value)
002200140616      *  06/16/14  added optional parm p_oldacct to function        DPB
002300140616      *            #get_aca_premium:  if passed use MTRANS instead
002400140616      *            of MCOV/DCOV (for transferred members)
002500140725      *  07/21/14  #get_aca_premium:  if BOR effective date >       DPB
002600140725      *            covg_date return zeros to caller
002700140801      *  07/30/14  #get_aca_premium:  added 2 optional parms that   DPB
002800140725      *            indicate function was called from OLE.  For OLE
002900141111      *            there might not be MCOV/DCOV so bypass that logic.
003000141113      *  11/07/14  1) function #chk_aca_plan:  additional values    DPB
003100141113      *               field PXACAR that are ACA plans .
003200141110      *            2) function #get_aca_premiums:  if PXACAR = 'Y'  DPB
003300141110      *               only rate 3 oldest minors.  Otherwise all
003400141111      *               minors are rated.  (ex...BCBS member level dental)
003500141111      *            3) function #get_aca_premiums:  if PXACAR = 'C'  DPB
003600141113      *               (composite plan) AND plncat = PTO it's a
003700141113      *               tobacco surcharge plan - calc difference
003800141111      *               between smoker and non-smoker rates
003900151001      *  10/01/15  B.Rees  Fixed an ENDIF when calculating the Under_21_Cnt
004000140124   X* *------------------------------------------------------------------
004100140109     Fmember    if   e           k disk    usropn extfile('F.MEMBER')
004200140109     Fdepndc    if   e           k disk    usropn extfile('F.DEPNDC')
004300140109     Fplnunique if   e           k disk    usropn
004400140109     Fplnauxp   if   e           k disk    usropn
004500140109     Fageratel1 if   e           k disk    usropn
004600141117     Fexagerate if   e           k disk    usropn rename(exagerate:exratef)
004700140109     Fcarunique if   e           k disk    usropn
004800140113     Facargrp   if   e           k disk    usropn
004900140204     Facaratelogo    e             disk    block(*No) usropn
005000140115
005100140124      /define get_acct_region_pr
005200140124      /define get_acct_region_fields
005300140124      /define get_acct_region_return
005400140326      /copy qcpysrc,acasrvpgmp
005500140124      /undefine get_acct_region_pr
005600140124      /undefine get_acct_region_fields
005700140124      /undefine get_acct_region_return
005800140109
005900140220      *?global variables
006000140220     D  idx            s              2  0
006100140220
006200140220      *?ACALOG data area - indicates whether to log errors only
006300140220     D acalog          ds                  dtaara
006400140220
006500140124      *?program status information DS
006600140114     D iopgmd        esds
006700140115
006800140109      *---------------------------------------------------------------------
006900140212      *?Function to retrieve exchange carrier code
007000140109      *---------------------------------------------------------------------
007100140109     P #get_exch_carrier...
007200140109     P                 b                   export
007300140109
007400140212      *?local variables
007500140212     D c@de20p       e ds                  extname(code20p)
007600140212
007700140109      /define get_exch_carrier_pi
007800140109      /define get_exch_carrier_fields
007900140127      /copy qcpysrc,acasrvpgmp
008000140109      /undefine get_exch_carrier_pi
008100140109      /undefine get_exch_carrier_fields
008200140109
008300140212      /define RTV_CODE20_PR
008400140212      /define RTV_CODE20_fields
008500140212      /copy qcpysrc,c20srvpgmp
008600140212      /undefine RTV_CODE20_PR
008700140212      /undefine RTV_CODE20_fields
008800150204
008900140109      /free
009000140109
009100140109       //?check # of parms passed - last 2 parms are optional so we need
009200140109       //?to check which, if any, were passed
009300140115       clear pcarr ;
009400140115       clear cgrpcd ;
009500140120
009600140109       if %parms > 3 ;
009700140115        pcarr = p_carriercode ;
009800140109        if %parms > 4 ;
009900140109         cgrpcd = p_groupcode ;
010000140109        endif ;
010100140109       endif ;
010200140109
010300140109       //?if group code = *blanks or carrier code = *blanks, then parms not
010400140109       //?passed so we need to retrieve those values
010500140115       if cgrpcd = *blanks or pcarr = *blanks ;
010600140109
010700140109        //?Carrier not passed so chain to plan master to retrieve carrier
010800140115        if pcarr = *blanks ;
010900140123         #aca_openfiles('PLNUNIQUE') ;
011000140109         chain (p_trust:p_sub:p_plan) plnunique ;
011100140109        endif ;
011200140109
011300140109        //?now we need to get the carrier group code
011400140123        #aca_openfiles('CARUNIQUE') ;
011500140109        chain (pcarr) carunique ;
011600140109       endif ;
011700140109
011800140109       //?finally, chain to plan aux
011900140123       #aca_openfiles('PLNAUXP') ;
012000140109       clear pxcfsen ;
012100140109       chain (p_trust:p_sub:p_plan) plnauxp ;
012200140109
012300140109       //?at this point we have all the values we need to retrieve the
012400140204       //?carrier code
012500140109       c@de20p = #rtv_code20('RATE CARR':cgrpcd) ;
012600140115       if c20actn1 = *blanks ;
012700140115        return '* ERROR *' ;
012800140115       elseif c20actn1 <> 'ENTITY' ;
012900140109        return c20actn1 ;
013000140109       else ;
013100140109        select ;
013200140109         when pxcfsen  = 'A' ;
013300140109          return 'BLUEC' ;
013400140109         when pxcfsen  = 'B' ;
013500140109          return 'CFMI' ;
013600140109         when pxcfsen  = 'C' ;
013700140109          return 'GHMSI' ;
013800140109         other ;
013900140109          return '* ERROR *' ;
014000140109        endsl ;
014100140109       endif ;
014200140109
014300140109      /end-free
014400140109
014500140109     P #get_exch_carrier...
014600140109     P                 e
014700140109
014800140109      *---------------------------------------------------------------------
014900140109      *?Function to check if plan is an ACA plan
015000140109      *---------------------------------------------------------------------
015100140109     P #chk_ACA_plan   b                   export
015200140109
015300140109      /define chk_ACA_plan_pi
015400140109      /define chk_ACA_plan_fields
015500140127      /copy qcpysrc,acasrvpgmp
015600140109      /undefine chk_ACA_plan_pi
015700140109      /undefine chk_ACA_plan_fields
015800140109
015900140109      /free
016000140109
016100140109       //?chain to plan aux
016200140123       #aca_openfiles('PLNAUXP') ;
016300141113       #aca_openfiles('PLNUNIQUE') ;
016400140109
016500140109       clear *all plnauxr ;
016600141113       clear *all plnmsr ;
016700141113
016800140109       chain (p_trust:p_sub:p_plan) plnauxp ;
016900141113       chain (p_trust:p_sub:p_plan) plnunique ;
017000141113       if (pxacar = 'Y') or (pxacar = 'D')  or
017100141113          (pxacar = 'C' and plncat = 'PTO') ;
017200141113        return 'Y' ;
017300140109       else ;
017400141113        return 'N' ;
017500140109       endif ;
017600140109
017700140109      /end-free
017800140109
017900140109     P #chk_ACA_plan   e
018000140109
018100140109      *---------------------------------------------------------------------
018200140109      *?Function to check if Acct has ANY ACA plan
018300140109      *---------------------------------------------------------------------
018400140109     P #chk_acct_ACA_plan...
018500140109     P                 b                   export
018600140109
018700140109      /define chk_acct_ACA_plan_pi
018800140109      /define chk_acct_ACA_plan_fields
018900140326      /copy qcpysrc,acasrvpgmp
019000140109      /undefine chk_acct_ACA_plan_pi
019100140109      /undefine chk_acct_ACA_plan_fields
019200140109
019300140109      *?local variables
019400140109     D count           s              3  0
019500140109     D effdate         s                   like(p_effdate)
019600140109
019700140109      /free
019800140109
019900140220       mbtrst = p_trust ;
020000140220       mbsub# = p_sub ;
020100140220       mbacct = p_acct ;
020200140109       effdate = p_effdate;
020300140109
020400140114       //?using variables passed in...see if we have any active MCOV for ACA
020500140317       exec sql select count(*) into :count from "F.MCOV" inner join
020600140317        plnauxp on mctrst = pxtrst and mcsub# = pxsub# and mcplan = pxplan
020700140220        where (mctrst = :mbtrst and mcsub# = :mbsub# and acc# = :mbacct)
020800141111        and (enrldt <> candt) and (pxacar <> 'N') and
020900140124        ( substr(char(enrldt),1,6) <= substr(char(:effdate),1,6) )
021000140114        and (candt = 0 or candt > :effdate) ;
021100140110
021200140109       if count > *zeros  ;
021300140109        return 'Y' ;
021400140321
021500140321       elseif %parms() > 4 and p_chk_trans = 'Y' ;
021600140321        exec sql select count(*) into :count from histinvmbr inner join
021700140321         plnauxp on hstrst = pxtrst and hssub# = pxsub# and plan = pxplan
021800140321         where (hstrst = :mbtrst and hssub# = :mbsub# and hsacct = :mbacct)
021900141111         and (pxacar <> 'Y') ;
022000140321         if count > *zeros  ;
022100140321          return 'Y' ;
022200140321         else ;
022300140321          return 'N' ;
022400140321         endif ;
022500140321
022600140321       else ;
022700140109        return 'N' ;
022800140109       endif ;
022900140109
023000140109      /end-free
023100140109
023200140109     P #chk_acct_ACA_plan...
023300140109     P                 e
023400140109      *---------------------------------------------------------------------
023500140109      *?Function to return rates for member and dependents for an ACA plan
023600140109      *?This function will return a data structure array of 40 elements
023700140109      *---------------------------------------------------------------------
023800140109     P #get_ACA_premiums...
023900140109     P                 b                   export
024000140109
024100140109      /define get_ACA_premiums_pi
024200140109      /define get_ACA_premiums_fields
024300140124      /define get_ACA_premiums_return
024400140725      /copy qcpysrc,acasrvpgmp
024500140124      /undefine get_ACA_premiums_pi
024600140109      /undefine get_ACA_premiums_fields
024700140124      /undefine get_ACA_premiums_return
024800140114
024900140210      /define rtv_gbs_admindate_pr
025000140210      /define rtv_gbs_admindate_fields
025100140210      /copy qcpysrc,accsrvpgmp
025200140210      /undefine rtv_gbs_admindate_pr
025300140210      /undefine rtv_gbs_admindate_fields
025400140210
025500140124      /define verify_mcv_date_Pr
025600140124      /define verify_mcv_date_fields
025700140617      /define verify_mtr_date_Pr
025800140617      /define verify_mtr_date_fields
025900140123      /copy qcpysrc,mbrsrvpgmp
026000140124      /undefine verify_mcv_date_Pr
026100140124      /undefine verify_mcv_date_fields
026200140617      /undefine verify_mtr_date_Pr
026300140617      /undefine verify_mtr_date_fields
026400140123
026500140128      /define chk_tobacco_user_Pr
026600140128      /define chk_tobacco_user_fields
026700140128      /copy qcpysrc,tobsrvpgmp
026800140128      /undefine chk_tobacco_user_Pr
026900140128      /undefine chk_tobacco_user_fields
027000140128
027100140212      /define get_plan_type_pr
027200140212      /define get_plan_type_fields
027300140212      /copy qcpysrc,plnsrvpgmp
027400140212      /undefine get_plan_type_pr
027500140212      /undefine get_plan_type_fields
027600140212
027700140204      /define copy_prorate_pr
027800140204      /define copy_prorate_fields
027900140204      /define copy_rtv_prorate_return
028000140204      /copy qcpysrc,proratep
028100140204      /undefine copy_rtv_prorate_return
028200140204      /undefine copy_prorate_fields
028300140204      /undefine copy_prorate_pr
028400140204
028500140109      *?local variables
028600140124     D working_fields  ds
028700140124     D  effdate                            like(p_effdate)
028800140124     D  exchg_carrier                10
028900140124     D  result                       30
029000140124     D  x                                  like(idx)
029100140124     D  under_21_cnt                       like(idx)
029200140124     D  count                              like(idx)
029300140225     D  p_enrldt                           like(enrldt)
029400141104     D  ole_call                           like(p_ole_call)
029500140109
029600140616     D coverage_ds     ds                  occurs(10)
029700140616     D  enrolldate                         like(rlenrolldt)
029800140616     D  canceldate                         like(rlcanceldt)
029900140113
030000140616     D null_ind_array  ds                  occurs(10)
030100140616     D  null_ind                      4b 0 dim(2)
030200140214
030300140616      *?external data structure
030400140616     D mcov          e ds                  inz occurs(10)
030500140616     D dcov          e ds                  inz
030600140616
030700140109      /free
030800140109
030900140110       //?clear return array DS and internally used fields...
031000140124       clear working_fields ;
031100140124       clear p_mbrdeparry ;
031200140205       clear p_occur_count ;
031300140220       clear p_error ;
031400140401       clear idx ;
031500140220
031600140220       //?clear file formats of residual values...
031700140220       clear *all membr ;
031800140220       clear *all depenr ;
031900140220       clear *all acaratelor ;
032000140220       clear *all plnmsr ;
032100140220       clear *all plnauxr ;
032200140401
032300140616       clear coverage_ds ;
032400140110
032500140220       //?setup fields that can be loaded once....
032600140113       mctrst = p_trust ;
032700140220       rltrust = mctrst ;
032800140113       mcsub# = p_sub ;
032900140220       rlsub = mcsub# ;
033000140113       mcplan = p_plan ;
033100140220       rlplan = mcplan ;
033200140114       mcssno = p_member ;
033300140220       rlssn = mcssno ;
033400140113       effdate = p_effdate;
033500140220       rlreqdate = %date(effdate) ;
033600140725
033700140725       //?if function called from OLE set flag as we will bypass some logic
033800141104       clear ole_call ;
033900141104       if %parms() >= 9 and p_ole_call = 'Y' ;
034000141104        ole_call = 'Y' ;
034100140725       endif ;
034200140204
034300140204       //?BORAD external pgm requries alpha parms...convert to alpha
034400140124       getborad_tsp = %editc(p_trust:'X') + %editc(p_sub:'X') + p_plan ;
034500140124       getborad_mceff = %editc(effdate:'X') ;
034600140113
034700140123       #aca_openfiles('PLNUNIQUE') ;
034800140123       #aca_openfiles('PLNAUXP') ;
034900140123       #aca_openfiles('MEMBER') ;
035000140123       #aca_openfiles('DEPNDC') ;
035100140124       #aca_openfiles('AGERATEL1') ;
035200141117       #aca_openfiles('EXAGERATE') ;
035300140110
035400140110       //?master file chains and setup...if error found, return to caller
035500140110       chain (p_trust:p_sub:p_plan) plnunique ;
035600140110       if not %found (plnunique) ;
035700140110        p_error = 'Plan Master not found' ;
035800140110       else ;
035900140220        rlplancat = plncat ;
036000140110        chain (p_trust:p_sub:p_plan) plnauxp ;
036100140115        if not %found (plnauxp) ;
036200140110         p_error = 'Plan Aux not found' ;
036300140110        elseif pxcarpln = *blanks ;
036400140110         p_error = 'Plan Aux missing ACA Plan ID' ;
036500140110        else ;
036600140721         if pxborefd > *zeros and pxborefd > p_effdate ;
036700140721          return p_mbrdeparry ;
036800140721         endif ;
036900140220         rlcarplan = pxcarpln ;
037000140221         rlpxborefd = pxborefd ;
037100140221         rlpxborlrd = pxborlrd ;
037200140110         exchg_carrier = #get_exch_carrier(p_trust:p_sub:p_plan:pcarr)  ;
037300140110         if exchg_carrier = '* ERROR *' ;
037400140304          p_error = 'Error retrieving Exchange Carrier x-ref from CODE20P' ;
037500140220         else ;
037600140220          rlexchcarr = exchg_carrier ;
037700140110         endif ;
037800140110        endif ;
037900140110       endif ;
038000140110
038100140220       //?errors found - stop logic, log the error and return to caller now
038200140110       if p_error <> *blanks ;
038300140304        #write_aca_log(p_error:*zeros) ;
038400140124        return p_mbrdeparry ;
038500140110       endif ;
038600140110
038700140113       agpdt = #get_plan_type(plncat) ; // plan type (medical, dental)
038800140113
038900140228       //?get member record...we need the acct#
039000140110       chain (p_member) member ;
039100140228
039200140228       //?if invalid member stop now as we didn't get an acct #...
039300140228       if not %found(member) ;
039400140228        p_error = 'Member not found' ;
039500140228       else ;
039600140617        if %parms() >= 8 and p_oldacct > *zeros ;
039700140617         mbacct = p_oldacct ;
039800140617        endif ;
039900140613        rlacct = mbacct ;
040000140228        rlhiredate = empdt ;
040100140228        //?if p_effdate is before the GBS acct admin date, return error
040200140228        rlgbsadmin = #rtv_gbs_admindate(p_trust:p_sub:mbacct) ;
040300140228        if rlgbsadmin = *zeros ;
040400140228         p_error = 'Missing GBS Admin Date for acct' ;
040500140228        elseif p_effdate < rlgbsadmin ;
040600140304         p_error = 'Request Date prior to GBS Admin Date for acct' ;
040700140228        endif ;
040800140228       endif ;
040900140228
041000140228       //?errors found - stop logic, log the error and return to caller now
041100140228       if p_error <> *blanks ;
041200140304        #write_aca_log(p_error:*zeros) ;
041300140228        return p_mbrdeparry ;
041400140228       endif ;
041500140228
041600140228       //?get region & plan renewal dates from ACARGRP (region renewal file)
041700140228       p_acct_region = #get_acct_region(p_trust:p_sub:mbacct:agpdt:effdate:
041800140228                       cgrpcd) ;
041900140228       if p_region = '*ERROR*' ;
042000140304        p_error = 'Error retrieving acct rating region from ACARGRP' ;
042100140304        #write_aca_log(p_error:*zeros) ;
042200140228        return p_mbrdeparry ;
042300140228       else ;
042400140228        rlrenewrgn = p_region ;
042500140228        rlrenewfrm = p_agrnwlfr ;
042600140228        rlrenewto = p_agrnwlto ;
042700140228        if rlrenewfrm = *zeros or rlrenewto = *zeros ;
042800140228         p_error = 'Error with ACARGRP renewal dates' ;
042900140304         #write_aca_log(p_error:*zeros) ;
043000140228         return p_mbrdeparry ;
043100140228        endif ;
043200140228        rlrenewmth = %subdt(%date(p_agrnwlfr):*m) ;
043300140228       endif ;
043400140228
043500140708       //?Error free at this point - try & retrieve member's MCOV or MTRANS
043600141104       //?record for this plan if not called form OLE
043700141104       if ole_call = *blanks ;
043800140725        exsr do_mbr_cov_sql ;
043900140725        if p_error <> *blanks ; // error with SQL
044000140725         #write_aca_log(p_error:*zeros) ;
044100140725         return p_mbrdeparry ;
044200140725        endif ;
044300141104       else ; // called from OLE - clear sqlca since we didn't exec sql
044400140725        clear sqlca ;
044500140725       endif ;
044600140617
044700140616       //?Coverage found...load fields (we are sorting MCOV in descending
044800140616       //?enrldt sequence in above SQL so, in the event multiple mcov records
044900140616       //?were retrieved, we really only want the first occurence)
045000141104       if (sqlcod = *zeros and sqler3 > *zeros) or (ole_call = 'Y')  ;
045100140401        idx = 1 ; // set to first occurence of array DS for member covg
045200140616        %occur(coverage_ds) = 1 ;
045300140304
045400140304        //?call function to make sure we have the right MCOV enrldt (in case
045500140304        //?a qualifying event took place and changed enrldt)
045600140725        clear result ;
045700140617        if %parms() >= 8 and p_oldacct <> *zeros ;
045800140618         p_enrldt = #verify_mtr_date(result:mctrst:mcsub#:mbacct:mcplan:mcssno:
045900140725                    *zeros:effdate:p_agrnwlfr:p_agrnwlto) ;
046000141104        elseif ole_call = *blanks ;
046100141104         p_enrldt = #verify_mcv_date(result:mctrst:mcsub#:mbacct:mcplan:mcssno:
046200140725                    effdate:p_agrnwlfr:p_agrnwlto) ;
046300141104        elseif ole_call = 'Y' ;
046400140725         p_enrldt = effdate ;
046500140725        endif ;
046600140725
046700140304        if result = *blanks ;
046800140616         enrolldate = p_enrldt ;
046900140304        endif ;
047000140725
047100140616        p_mbrdeparry(idx).canceldate = canceldate ;
047200140616        p_mbrdeparry(idx).datetoage = %date(enrolldate) ;
047300140616        p_mbrdeparry(idx).enrolldate = enrolldate ;
047400140304
047500140304        //?load 1st element of array with member DOB...if bad date, error...
047600140304        test(de) birth ;
047700140304        if %error ;
047800140304         rlbirthdat = birth ;
047900140304         p_error = 'Member birthdate invalid' ;
048000140304         #write_aca_log(p_error:idx:p_mbrdeparry) ;
048100140616         return p_mbrdeparry ;
048200140304        endif ;
048300140304        p_mbrdeparry(idx).dob = %date(birth) ;
048400140304
048500140219       endif ;
048600140110
048700150204         //   if ole_call = *blanks ;  B.Rees
048800140725        if %parms() >= 8 and p_oldacct > *zeros ;
048900140725         exec sql close mtrans ;
049000140725        else ;
049100140725         exec sql close mcov ;
049200140725        endif ;
049300150204        //  endif ;   B.Rees
049400140228
049500140228       //?still error free at this point - retrieve dependents now
049600140110       //?load dependent data into same array as member data
049700140110       setll (p_member) depndc ;
049800140110       dou %eof (depndc) ;
049900140110        reade (p_member) depndc ;
050000140113
050100140110        if %eof (depndc) ;
050200140110         leave ;
050300140110        endif ;
050400150318
050500140616        //?need to use variable sql again to see if dependent has coverage
050600141104        //?for this plan...if called from OLE check if this dependent was
050700141104        //?to be included by checking inbound parm p_ole_depends
050800150318        if %parms() >= 10 ;
050900150318         if p_ole_depends(1) > *zeros and
051000150318            %lookup(dpseq#:p_ole_depends) > *zeros ; // OLE: check if this
051100140725          enrolldate = effdate ; // dependent was selected from OLE
051200140725          clear sqlcod ;
051300140725         else ;
051400140725          sqlcod = *hival ; // depend not selected...
051500140725         endif ;
051600140725        else ;
051700150318         exsr do_dep_cov_sql ;
051800150204        endif ;
051900140113
052000140618        if p_error <> *blanks ; // error with SQL
052100140618         #write_aca_log(p_error:*zeros) ;
052200140618         return p_mbrdeparry ;
052300140618        endif ;
052400140618
052500150204         if sqlcod = *zeros ; // dependent coverage found...
052600140304         idx += 1 ;
052700140304         p_mbrdeparry(idx).depseq = dpseq# ;
052800140304         if %subst(drelcd:2) = 'HU' or %subst(drelcd:2) = 'WI' or
052900140304            %subst(drelcd:2) = 'PA' ;
053000140304          p_mbrdeparry(idx).spouse = 'Y' ;
053100140304         else ;
053200140304          p_mbrdeparry(idx).spouse = 'N' ;
053300140304         endif ;
053400140616         p_mbrdeparry(idx).enrolldate = enrolldate ;
053500140616         p_mbrdeparry(idx).canceldate = canceldate ;
053600140616         p_mbrdeparry(idx).datetoage = %date(enrolldate) ;
053700140113         test(de) dbirth ;
053800140113         if %error ;
053900140304          rlbirthdat = dbirth ;
054000140113          p_error = 'Dependent ' + %char(dpseq#) + ' birthdate invalid' ;
054100140304          #write_aca_log(p_error:idx:p_mbrdeparry) ;
054200140124          return p_mbrdeparry ;
054300140113         endif ;
054400140114
054500140304         p_mbrdeparry(idx).dob = %date(dbirth) ;
054600140124
054700140113        endif ;
054800140618
054900141104        //?close cursors (if called from OLE no cursors were used)
055000141104        if ole_call = *blanks ;
055100141104         if %parms() >= 8 and p_oldacct > *zeros ;
055200141104          exec sql close dtrans ;
055300141104         else ;
055400141104          exec sql close dcov ;
055500141104         endif ;
055600141104        endif ;
055700150318
055800140113       enddo ;
055900140115
056000140124       //?array loaded with member and dependents...now calc their age
056100140127       //?and retrieve their ACA rate
056200140124       exsr calc_age_and_rate ;
056300140124
056400140124       //?if errors found in above subr...return to caller now
056500140124       if p_error <> *blanks ;
056600140124        return p_mbrdeparry ;
056700140124       endif ;
056800140124
056900141104       //?almost done!!!  the final step is to see how many minors (under
057000141104       //?age 21) are to be rated.  If PXACAR = 'Y' then we only rate the
057100141113       //?oldest 3 minors. (sort by dob descending first)   If PXACAR is
057200141113       //?any value other than 'Y' we rate all minors.
057300141104       if pxacar = 'Y' and under_21_cnt > 3 ;
057400140124        sorta %subarr(p_mbrdeparry(*).dob: 1 : idx) ;
057500140124
057600140124        for x = 1 to idx ;
057700140124         if p_mbrdeparry(x).age < 21 and p_mbrdeparry(x).depseq <> 0 and
057800140124            p_mbrdeparry(x).spouse <> 'Y' ;
057900140124          count += 1 ;
058000140124          if count > 3 ;
058100140124           clear p_mbrdeparry(x).acarate ;
058200140204           clear p_mbrdeparry(x).proacarate ;
058300140124          endif ;
058400140124         endif ;
058500140124        endfor ;
058600140124
058700140127        //?sort array again - put back to sequence order                    s
058800140124        sorta %subarr(p_mbrdeparry(*).depseq: 1 : idx) ;
058900140124       endif ;
059000140124
059100140127       p_occur_count = idx ;
059200140220
059300140220       //?check ACA log flag in *dtaara...write log if flag is 'Y'          s
059400140220       in acalog ;
059500140220       if acalog = 'Y' ;
059600140304        #write_aca_log(p_error:*zeros:p_mbrdeparry:idx) ;
059700140220       endif ;
059800140220
059900140124       return p_mbrdeparry ;
060000140109
060100140124       //--------------------------------------------------------------------
060200140124       // calc_age_and_rate:  for each person we have to calc their age BUT
060300140124       // before we can do that, we have to ensure we use the right date.
060400140124       // We start out with their enrollment date.  If the plans renewal
060500140124       // date is after the enrollment date, use plan renewal date. Finally
060600140124       // check if there is a BOR age date override.  Once we calc their age
060700140204       // we can retrieve their ACA rate.
060800140124       //--------------------------------------------------------------------
060900140124       begsr calc_age_and_rate ;
061000140124
061100140210        //?borad_empdt is always member's date of hire
061200140210        getborad_empdt = %editc(empdt:'X') ;
061300140210
061400140124        for x = 1 to idx ;
061500140124
061600140220         if p_mbrdeparry(x).enrolldate <> *zeros ;
061700140219
061800140219          //?if enrollment date prior to renewal date use renewal date to
061900140219          //?calculate age...else use enrollment date to calculate age
062000140219          if p_mbrdeparry(x).datetoage < %date(p_agrnwlfr) ;
062100140219           p_mbrdeparry(x).datetoage = %date(p_agrnwlfr) ;
062200140219          endif ;
062300140124
062400140219          //?If renewal based plan - see if BOR age date override...
062500140219          if pxborlrd <> *zeros and pxborefd <> *zeros ;
062600140219           getborad_mceff = %char(p_mbrdeparry(x).datetoage:*iso0) ;
062700140219           exsr getborad ;
062800140219           if getborad_error <> *blanks ;
062900140221            p_error = 'Error with BOR date on depseq ' +
063000140221             %editc(p_mbrdeparry(x).depseq:'X') ;
063100140304            #write_aca_log(p_error:x:p_mbrdeparry) ;
063200140219            leavesr ;
063300140219           else ;
063400140219            p_mbrdeparry(x).datetoage = %date(getborad_adr:*iso0) ;
063500140219           endif ;
063600140219          endif ;
063700140124
063800140324          if p_mbrdeparry(x).dob <= p_mbrdeparry(x).datetoage ;
063900140321           monitor ;
064000140321            p_mbrdeparry(x).age = %diff(p_mbrdeparry(x).datetoage:
064100140321                                        p_mbrdeparry(x).dob:*Y) ;
064200140124
064300140321           on-error ;
064400140321            p_error = 'Error calculating age for depseq ' +
064500140321             %editc(p_mbrdeparry(x).depseq:'X') ;
064600140321            #write_aca_log(p_error:x:p_mbrdeparry) ;
064700140321            leavesr ;
064800140321           endmon ;
064900140321
065000151001br01      endif ;
065100151001
065200151001         if p_mbrdeparry(x).age < 21 and p_mbrdeparry(x).spouse <> 'Y' ;
065300151001           under_21_cnt += 1 ;
065400151001         endif ;
065500140124
065600140124
065700140219          exsr retrieve_rate ;
065800140124
065900140219          if p_error <> *blanks ;
066000140219           leave ;
066100140219          endif ;
066200140124
066300140219         endif ;
066400140219
066500140124        endfor ;
066600140124
066700140124       endsr ;
066800140124
066900140124       //--------------------------------------------------------------------
067000140127       // retrieve_rate: we now have all of the pieces to retrieve the
067100141117       //                person's rate. First, see if the person is a smoker
067200141117       //                so we know which rate to grab.  Once we get their
067300141117       //                rate, prorate it into a separate amount field in
067400141117       //                case the caller needs the prorated amount.
067500140124       //--------------------------------------------------------------------
067600140124       begsr retrieve_rate ;
067700140128
067800140205        p_mbrdeparry(x).smoker = #chk_tobacco_user(p_member:
067900140205                                  p_mbrdeparry(x).depseq:p_effdate) ;
068000140205
068100141117        if pxexchg = 'Y' ;
068200141117         setll (exchg_carrier:pxcarpln:p_region:rlrenewmth) exagerate ;
068300141117        else ;
068400141117         setll (exchg_carrier:pxcarpln:p_region:rlrenewmth) ageratel1 ;
068500141117        endif ;
068600141117
068700141117        dou %eof ;
068800141117         if pxexchg = 'Y' ;
068900141117          reade (exchg_carrier:pxcarpln:p_region:rlrenewmth) exagerate ;
069000141117        else ;
069100141117          reade (exchg_carrier:pxcarpln:p_region:rlrenewmth) ageratel1 ;
069200141117        endif ;
069300140124
069400141117         if %eof ;
069500141117          p_error = 'Error:  Rate not found for depseq ' +
069600141117                     %editc(p_mbrdeparry(x).depseq:'X') ;
069700141117          #write_aca_log(p_error:x:p_mbrdeparry) ;
069800140124          leave ;
069900140124         endif ;
070000140124
070100140124         if p_mbrdeparry(x).datetoage >= rteffdte and
070200140124            p_mbrdeparry(x).datetoage <= rttrmdte and
070300140124            p_mbrdeparry(x).age >= rtlowage and
070400140124            p_mbrdeparry(x).age <= rthighage ;
070500140205
070600141111          //?determine which amount to return to caller:                    :
070700141113          //? - if plan is a tobacco surchg plan (plncat = PTO) AND the     :
070800141113          //?   person is a smoker return the diff between smoker/nonsmoker :
070900141113          //? - Else...not a tobacco surchg plan:  return rate based on     :
071000141113          //?   whether the person is a smoker or not.                      :
071100141113          if pxacar = 'C' and plncat = 'PTO' ;
071200141113           if p_mbrdeparry(x).smoker = 'Y' ;
071300141113             p_mbrdeparry(x).acarate = rtsmoker - rtnsmkr ;
071400141113           else ;
071500141113             p_mbrdeparry(x).acarate = *zeros ;
071600141113           endif ;
071700141113          else ;
071800141113           if p_mbrdeparry(x).smoker = 'Y' ;
071900141113            p_mbrdeparry(x).acarate = rtsmoker ;
072000141113           else ;
072100141113            p_mbrdeparry(x).acarate = rtnsmkr ;
072200141113           endif ;
072300141113          endif ;
072400140204
072500140616          //?call function to prorate...function returns a DS with 2 amounts:
072600140616          //?this function (#GET_ACA_PREMIUMS) will return both (full premium
072700140616          //?and prorated amount) to the caller
072800140205          p_ret_premiums = #get_prorate_premium(p_mbrdeparry(x).enrolldate:
072900140205                           p_mbrdeparry(x).canceldate: effdate: pcarr:
073000140205                           p_mbrdeparry(x).acarate:p_mbrdeparry(x).acarate) ;
073100140204
073200140205          //?move prorated amount back to Array DS
073300140205          p_mbrdeparry(x).proacarate = pro_prem_bill ;
073400140204
073500140124          leave ;
073600140124         endif ;
073700140124
073800140124        enddo ;
073900140124
074000140124       endsr ;
074100140205
074200140124      *---------------------------------------------------------------------
074300140124      * Subr to call GETBORAD - to determine if a diff date should be used
074400140124      * to calc person's age.....
074500140123      *---------------------------------------------------------------------
074600140123     C     getborad      begsr
074700140123     C                   CALL      'GETBORAD'
074800140123     C                   PARM                    GETBORAD_TSP     10
074900140123     C                   PARM                    GETBORAD_MCEFF    8
075000140123     C                   PARM                    GETBORAD_EMPDT    8
075100140123     C                   PARM      *blanks       GETBORAD_ADR      8
075200140123     C                   PARM      *blanks       GETBORAD_ADT      2
075300140123     C                   PARM      *blanks       GETBORAD_ERROR    1
075400140123     C                   endsr
075500140616       //-------------------------------------------------------------------
075600140617       //?do_mbr_cov_sql:  try and retrieve MCOV/MTRANS records for this
075700140616       //?member/plan.  Optional inbound parm p_oldacct determines
075800140616       //?whether we query MCOV or MTRANS.
075900140616       //-------------------------------------------------------------------
076000140617       begsr do_mbr_cov_sql ;
076100140616
076200140616        //?Ignore same day terms when querying MCOV...when comparing enrldt
076300140616        //?to p_effdate we only look at the yyyymm portion (ignore the day)
076400140616        //?- that's because coverage could have started anytime during the
076500140616        //?month....in which case the rate might be prorated.  Also, note
076600140616        //?the query is sorted DESCENDING on enrldt...so that we read the
076700140616        //?most recent record first.
076800140617        if %parms() >= 8 and p_oldacct <> *zeros ;
076900140617         exec sql declare mtrans cursor for
077000140617          select mtenrl, mtcan from "F.MTRANSL2" where
077100140617          (mttrst = :mctrst and mtsub# = :mcsub# and mtplan = :mcplan and
077200140617          mtssno = :mcssno and mtseq# = 0 and mtacc# = :mbacct) and
077300140617          (mtenrl <> mtcan) and
077400140617          ( substr(char(mtenrl),1,6) <= substr(char(:effdate),1,6) )
077500140617          and (mtcan = 0 or :effdate < mtcan) order by mtenrl desc
077600140617          for fetch only ;
077700140617         exec sql open mtrans ;
077800140617        else ;
077900140617         exec sql declare mcov cursor for
078000140617          select enrldt, candt from mcovapse where
078100140617          (mctrst = :mctrst and mcsub# = :mcsub# and mcplan = :mcplan and
078200140617          mcssno = :mcssno and acc# = :mbacct) and (enrldt <> candt) and
078300140617          ( substr(char(enrldt),1,6) <= substr(char(:effdate),1,6) )
078400140617          and (candt = 0 or :effdate < candt) order by enrldt desc
078500140617          for fetch only ;
078600140617         exec sql open mcov ;
078700140617        endif ;
078800140617
078900140617        //?if cursor failed to open...problem with sql stmt...record error
079000140617        if sqlcod <> *zeros ;
079100140617         p_error = 'MCOV/MTRANS SQL cursor error ' + %trim(sqlerm) ;
079200140618        else ;
079300140618         if %parms() >= 8 and p_oldacct <> *zeros ;
079400140618          exec sql fetch mtrans for 10 rows into
079500140618           :coverage_ds:null_ind_array ;
079600140618         else ;
079700140618          exec sql fetch mcov for 10 rows into
079800140618           :coverage_ds:null_ind_array ;
079900140618         endif ;
080000140618        endif ;
080100140618
080200140616       endsr ;
080300140123
080400140618       //-------------------------------------------------------------------
080500140618       //?do_dep_cov_sql:  try and retrieve DCOV/MTRANS records for this
080600140618       //?dependent/plan.  Optional inbound parm p_oldacct determines
080700140618       //?whether we query DCOV or MTRANS.
080800140618       //-------------------------------------------------------------------
080900140618       begsr do_dep_cov_sql ;
081000140616
081100140617        if %parms() >= 8 and p_oldacct <> *zeros ;
081200140618         exec sql declare dtrans cursor for
081300140618          select mtenrl, mtcan from "F.MTRANSL2" where
081400140618          (mttrst = :mctrst and mtsub# = :mcsub# and mtplan = :mcplan and
081500140618          mtssno = :mcssno and mtseq# = :dpseq# and mtacc# = :mbacct) and
081600140618          (mtenrl <> mtcan) and
081700140618          ( substr(char(mtenrl),1,6) <= substr(char(:effdate),1,6) )
081800140618          and (mtcan = 0 or :effdate < mtcan) order by mtenrl desc
081900140618          for fetch only ;
082000140618         exec sql open dtrans ;
082100140616        else ;
082200140618         exec sql declare dcov cursor for
082300140618          select denrdt, ccandt from "F.DCOV22" where
082400140618          (dvtrst = :mctrst and dvsub# = :mcsub# and dvplan = :mcplan and
082500140618          ssno = :mcssno and dseq# = :dpseq#) and (denrdt <> ccandt) and
082600140618          ( substr(char(denrdt),1,6) <= substr(char(:effdate),1,6) )
082700140618          and (ccandt = 0 or :effdate < ccandt) order by denrdt desc
082800140618          for fetch only ;
082900140618         exec sql open dcov ;
083000140616        endif ;
083100140616
083200140618        //?if cursor failed to open...problem with sql stmt...record error
083300140618        if sqlcod <> *zeros ;
083400140618         p_error = 'DCOV/MTRANS SQL cursor error ' + %trim(sqlerm) ;
083500140618        else ;
083600150204
083700150204
083800140618         if %parms() >= 8 and p_oldacct <> *zeros ;
083900140618          exec sql fetch dtrans for 10 rows into
084000140618           :coverage_ds:null_ind_array ;
084100140618         else ;
084200140618          exec sql fetch dcov for 10 rows into
084300140618           :coverage_ds:null_ind_array ;
084400140618         endif ;
084500140618        endif ;
084600140618
084700140616       endsr ;
084800140616
084900140109     P #get_ACA_premiums...
085000140109     P                 e
085100140113      *---------------------------------------------------------------------
085200140124      *?local (non-exported) function to retrieve account's rating region
085300140124      *?record from ACARGRP.
085400140113      *---------------------------------------------------------------------
085500140113     P #get_acct_region...
085600140304     P                 b                   export
085700140113
085800140113      /define get_acct_region_pi
085900140113      /define get_acct_region_fields
086000140124      /define get_acct_region_return
086100140326      /copy qcpysrc,acasrvpgmp
086200140113      /undefine get_acct_region_pi
086300140113      /undefine get_acct_region_fields
086400140124      /undefine get_acct_region_return
086500140113
086600140113      /free
086700140123       #aca_openfiles('ACARGRP') ;
086800140304       clear p_acct_region ;
086900140114
087000140221       setll (p_trust:p_sub:p_acct:p_prodtype:p_grouper) acargrp ;
087100140114       dou %eof (acargrp) ;
087200140221        reade (p_trust:p_sub:p_acct:p_prodtype:p_grouper) acargrp ;
087300140114
087400140114        //?if eof - leave...this will be an error since we found no match
087500140114        if %eof (acargrp) ;
087600140304         p_region = '*ERROR*' ;
087700140304         return p_acct_region ;
087800140114        endif ;
087900140113
088000140123        //?if *entry date falls within renewal range...return DS to caller
088100140114        if agrnwlfr <= p_effdate and agrnwlto >= p_effdate ;
088200140304         p_state = agstate ;
088300140124         p_region = agratrgn ;
088400140124         p_agrnwlfr = agrnwlfr ;
088500140124         p_agrnwlto = agrnwlto ;
088600140123         return p_acct_region ;
088700140114        endif ;
088800140114
088900140113       enddo ;
089000140113
089100140113      /end-free
089200140113
089300140113     P #get_acct_region...
089400140113     P                 e
089500140113
089600140114      *---------------------------------------------------------------------
089700140220      *?local (non-exported) function to write to ACARATELOG
089800140114      *---------------------------------------------------------------------
089900140220     P #write_aca_log  b
090000140114
090100140220      /define write_aca_log_pi
090200140220      /define write_aca_log_fields
090300140326      /copy qcpysrc,acasrvpgmp
090400140220      /undefine write_aca_log_fields
090500140220      /undefine write_aca_log_pi
090600140114
090700140220      /define get_ACA_premiums_return
090800140220      /copy qcpysrc,acasrvpgmp
090900140220      /undefine get_ACA_premiums_return
091000140220
091100140221      /Define Copy_rtvcaller_prototype
091200140221      /Define Copy_rtvcaller_fields
091300140221      /copy qcpysrc,utlsrvpgmp
091400140221      /unDefine Copy_rtvcaller_prototype
091500140221      /unDefine Copy_rtvcaller_fields
091600140221
091700140114      /free
091800140114
091900140127       #aca_openfiles('ACARATELOG') ;
092000140114
092100140220       //?load common fields
092200140220       rlerror = p_error ;
092300140114       rltimestmp = %timestamp() ;
092400140114       rluser = wqusrn ;
092500140114       rljobname = wqjobn ;
092600140114       rljobnbr = wqjob# ;
092700140221       rlpgm = wqpgmn ;
092800140221       rlcaller = #rtvcaller(wqpgmn) ;
092900140114
093000140220       //?if no errors - then function was called to log each premium...
093100140220       //?spin through each element of inbound array & write to ACARATELOG
093200140304       if p_error = *blanks ;
093300140220        for idx = 1 to p_occur_count ;
093400140220         rldepseq = p_array(idx).depseq ;
093500140220         rlspouse = p_array(idx).spouse ;
093600140220         rlsmoker = p_array(idx).smoker ;
093700140220         rlcalcage = p_array(idx).age ;
093800140220         rlacarate = p_array(idx).acarate ;
093900140220         rlproacart = p_array(idx).proacarate ;
094000140221         rlbirthdat = %int(%char(p_array(idx).dob:*iso0)) ;
094100140221         rlenrolldt = p_array(idx).enrolldate ;
094200140304         rlagedate = %int(%char(p_array(idx).datetoage:*iso0)) ;
094300140221         rlcanceldt = p_array(idx).canceldate ;
094400140220         write acaratelor ;
094500140220        endfor ;
094600140304
094700140304       //?else...if p_occurence = 0 then error occurred before member/depend
094800140304       //?logic....all fields already loaded so just write record
094900140304       elseif p_occurence = *zeros ;
095000140220        write acaratelor ;
095100140304
095200140304       //?else...error occurred on member or dependent...array index passed
095300140304       //?in loads fields from that index
095400140304       else ;
095500140304        rldepseq = p_array(p_occurence).depseq ;
095600140304        rlspouse = p_array(p_occurence).spouse ;
095700140304        rlsmoker = p_array(p_occurence).smoker ;
095800140304        rlcalcage = p_array(p_occurence).age ;
095900140304        rlacarate = p_array(p_occurence).acarate ;
096000140304        rlproacart = p_array(p_occurence).proacarate ;
096100140304        if rlbirthdat = *zeros ;
096200140304         rlbirthdat = %int(%char(p_array(p_occurence).dob:*iso0)) ;
096300140304        endif ;
096400140304        rlenrolldt = p_array(p_occurence).enrolldate ;
096500140304        rlagedate = %int(%char(p_array(p_occurence).datetoage:*iso0)) ;
096600140304        rlcanceldt = p_array(p_occurence).canceldate ;
096700140304        write acaratelor ;
096800140220       endif ;
096900140220
097000140114      /end-free
097100140114
097200140220     P #write_aca_log  e
097300140109      *---------------------------------------------------------------------
097400140109      *
097500140109      *---------------------------------------------------------------------
097600140123     P #aca_openfiles  b
097700140109
097800140123     d #aca_openfiles  pi
097900140109     D  file                         10    value
098000140109
098100140109      /free
098200140109
098300140109       if file = 'MEMBER' ;
098400140109        if not %open(member) ;
098500140109         open member ;
098600140109        endif ;
098700140214
098800141117       elseif file = 'DEPNDC' ;
098900140109        if not %open(depndc) ;
099000140109         open depndc ;
099100140109        endif ;
099200140109
099300141117       elseif file = 'PLNUNIQUE' ;
099400140109        if not %open(plnunique) ;
099500140109         open plnunique ;
099600140109        endif ;
099700140109
099800141117       elseif file = 'AGERATEL1' ;
099900140109        if not %open(ageratel1) ;
100000140109         open ageratel1 ;
100100140109        endif ;
100200140109
100300141117       elseif file = 'PLNAUXP' ;
100400140109        if not %open(plnauxp) ;
100500140109         open plnauxp ;
100600140109        endif ;
100700140109
100800141117       elseif file = 'CARUNIQUE' ;
100900140110        if not %open(carunique) ;
101000140110         open carunique ;
101100140110        endif ;
101200140110
101300141117       elseif file = 'ACARGRP' ;
101400140113        if not %open(acargrp) ;
101500140113         open acargrp ;
101600140113        endif ;
101700140113
101800141117       elseif file = 'ACARATELOG' ;
101900140127        if not %open(acaratelog) ;
102000140127         open acaratelog ;
102100140114        endif ;
102200141117
102300141117       elseif file = 'EXAGERATE' ;
102400141117        if not %open(exagerate) ;
102500141117         open exagerate ;
102600141117        endif ;
102700141117
102800140114       endif ;
102900140114
103000140109      /end-free
103100140109
103200140123     P #aca_openfiles  e
103300140109      *---------------------------------------------------------------------
103400140109      *
103500140109      *---------------------------------------------------------------------
103600140123     P #aca_closesrv   b                   export
103700140109
103800140123      /define aca_closesrv_pi
103900140127      /copy qcpysrc,acasrvpgmp
104000140123      /undefine aca_closesrv_pi
104100140109
104200140210      /define acc_closesrv_pr
104300140210      /copy qcpysrc,accsrvpgmp
104400140210      /undefine acc_closesrv_pr
104500140210
104600140128      /define mbr_closesrv_pr
104700140128      /copy qcpysrc,mbrsrvpgmp
104800140128      /undefine mbr_closesrv_pr
104900140128
105000140128      /define pln_closesrv_pr
105100140128      /copy qcpysrc,plnsrvpgmp
105200140128      /undefine pln_closesrv_pr
105300140128
105400140128      /define tob_closesrv_pr
105500140128      /copy qcpysrc,tobsrvpgmp
105600140128      /undefine tob_closesrv_pr
105700140128
105800140212      /define copy_pro_closesrv_pr
105900140212      /copy qcpysrc,proratep
106000140212      /undefine copy_pro_closesrv_pr
106100140212
106200140221      /define copy_utl_closesrv_prototype
106300140221      /copy qcpysrc,utlsrvpgmp
106400140221      /undefine copy_utl_closesrv_prototype
106500140221
106600140109      /free
106700140109
106800140109       close *all ;
106900140128
107000140128       //?force closure of all referenced service programs as well
107100140128       #pln_closesrv() ;
107200140128       #mbr_closesrv() ;
107300140128       #tob_closesrv() ;
107400140210       #acc_closesrv() ;
107500140212       #pro_closesrv() ;
107600140221       #utl_closesrv() ;
107700140109
107800140109      /end-free
107900140109
108000140123     P #aca_closesrv   e
