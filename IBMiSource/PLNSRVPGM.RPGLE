000100130909     Hnomain option(*nodebugio) debug copyright('GBS - GroupBenefitServices')
000200140818     Hbnddir('PLNSRVPGM') alwnull(*usrctl)
000300130909
000400130909      *------------------------------------------------------------------
000500130909      * Module Name...PLNSRVPGM
000600130909      * Written by...:Debora Bond
000700130909      * Date Written.:09/09/2013
000800130909      * Description..:Module within service program PLNSRVPGM....functions
000900130909      *               related to PLNMST
001000130909      * Called From..:Any program
001100130909      *
001200130909      *------------------------------------------------------------------
001300130909      * Modification History:
001400130909      *
001500130909      *    Date    Description                                       By
001600140801      *  --------  -----------------------------------------------  ----
001700140801      *  06/24/14  #get_plan_descr:  added optional parm so caller  DPB
001800140801      *            can ask for plan desc from OEPLAN...
001900140930      *  07/31/14  added #get_plan_benefit - used in OLE            dpb
002000140930      *  08/15/14  added #get_plan_carrier                          dpb
002100140930      *  08/15/14  added #get_ACA_planid                            dpb
002200140904      *  09/04/14  added #get_plan_sort:  get plan sort order used  DPB
002300140904      *            in invoicing.
002400130909      *------------------------------------------------------------------
002500130909
002600130909     Fplnunique if   e           k disk    usropn
002700140624     Foeplan    if   e           k disk    usropn
002800131219     Fplnauxp   if   e           k disk    usropn
002900130924     Fcodesl1   if   e           k disk    usropn extfile('F.CODESL1')
003000140912     Fpcseq     if   e           k disk    usropn
003100130909
003200140815     D plan_error      s              1
003300140916
003400140815      /define copy_all_protos_and_fields
003500140819      /copy qcpysrc,plnsrvpgmp
003600140815      /undefine copy_all_protos_and_fields
003700140815
003800130909      *---------------------------------------------------------------------
003900130909      * Function to retrieve plan category and return to caller
004000130909      *---------------------------------------------------------------------
004100130909     P #get_plan_cat   b                   export
004200130909
004300130909      /define get_plan_cat_pi
004400130909      /define get_plan_cat_fields
004500130924      /copy qcpysrc,plnsrvpgmp
004600130909      /undefine get_plan_cat_fields
004700130909      /undefine get_plan_cat_pi
004800130909
004900140815        plan_error = #get_plan_master(trust:sub:plan) ;
005000140815        if plan_error = *blanks ;
005100140815         return plncat ;
005200140815        else ;
005300140815         return *blanks ;
005400140815        endif ;
005500130909
005600130909     P #get_plan_cat   e
005700130909
005800130909      *---------------------------------------------------------------------
005900130909      * Function to retrieve plan "action" from the codes file
006000130909      *---------------------------------------------------------------------
006100130909     P #get_plan_type  b                   export
006200130909
006300130909      /define get_plan_type_pi
006400130909      /define get_plan_type_fields
006500130924      /copy qcpysrc,plnsrvpgmp
006600130909      /undefine get_plan_type_fields
006700130909      /undefine get_plan_type_pi
006800130909
006900130909        #pln_openfiles('CODESL1') ;
007000130909
007100130909        chain (plancat) codesl1 ;
007200130909        if not %found(codesl1) ;
007300130909         return *blanks ;
007400130909        else ;
007500130909         return action ;
007600130909        endif ;
007700130909
007800130909     P #get_plan_type  e
007900130909
008000130909      *---------------------------------------------------------------------
008100130909      *
008200130909      *---------------------------------------------------------------------
008300130909     P #pln_openfiles  b
008400130909
008500130909     d #pln_openfiles  pi
008600130909     D  file                         10    value
008700130909
008800130909       if file = 'PLNUNIQUE' ;
008900130909        if not %open(plnunique) ;
009000130909         open plnunique ;
009100130909        endif ;
009200130909
009300140815       elseif file = 'CODESL1' ;
009400130909        if not %open(codesl1) ;
009500130909         open codesl1 ;
009600130909        endif ;
009700130909
009800140815       elseif file = 'PLNAUXP' ;
009900131219        if not %open(plnauxp) ;
010000131219         open plnauxp ;
010100131219        endif ;
010200131219
010300140815       elseif file = 'OEPLAN' ;
010400140624        if not %open(oeplan) ;
010500140624         open oeplan ;
010600140624        endif ;
010700140905
010800140912       elseif file = 'PCSEQ' ;
010900140912        if not %open(pcseq) ;
011000140912         open pcseq ;
011100140905        endif ;
011200140815
011300140815       endif ;
011400140815
011500130909     P #pln_openfiles  e
011600130909      *---------------------------------------------------------------------
011700130909      *
011800130909      *---------------------------------------------------------------------
011900130909     P #pln_closesrv   b                   export
012000130909
012100130909      /define pln_closesrv_pi
012200130924      /copy qcpysrc,plnsrvpgmp
012300130909      /undefine pln_closesrv_pi
012400130909
012500130909       close *all ;
012600130909
012700130909     P #pln_closesrv   e
012800131219      *---------------------------------------------------------------------
012900131219      * Function to retrieve plan group from the codes file
013000131219      *---------------------------------------------------------------------
013100131219     P #get_plan_group...
013200131219     P                 b                   export
013300131219
013400131219      /define get_plan_group_pi
013500131219      /define get_plan_group_fields
013600131223      /copy qcpysrc,plnsrvpgmp
013700131219      /undefine get_plan_group_fields
013800131219      /undefine get_plan_group_pi
013900131219
014000140815        plan_error = #get_plan_master(trust:sub:plan) ;
014100140815        if plan_error = *blanks ;
014200140815         return pxgroup ;
014300140815        else ;
014400140815         return *blanks ;
014500140815        endif ;
014600131219
014700131219     P #get_plan_group...
014800131219     P                 e
014900131219
015000131220      *---------------------------------------------------------------------
015100131220      * Function to retrieve plan description from plnmst
015200131220      *---------------------------------------------------------------------
015300131220     P #get_plan_descr...
015400131220     P                 b                   export
015500131220
015600131220      /define get_plan_descr_pi
015700131220      /define get_plan_descr_fields
015800140801      /copy qcpysrc,plnsrvpgmp
015900131220      /undefine get_plan_descr_fields
016000131220      /undefine get_plan_descr_pi
016100131220
016200140815        plan_error = #get_plan_master(trust:sub:plan) ;
016300140815        if plan_error <> *blanks ;
016400140815         return *blanks ;
016500140815        endif ;
016600140801
016700140801        //?caller wants descr from OEPLAN if not blank....
016800140801        if %parms() >= 4 and ole_desc = 'Y' ;
016900140801         #pln_openfiles('OEPLAN') ;
017000140801         chain (trust:sub:plan) oeplan ;
017100140801         if %found(oeplan) and odesc <> *blanks ;
017200140801          return odesc ;
017300140801         endif ;
017400140801        endif ;
017500140801
017600140801        //?return descr from plnmst...
017700140801        return pdescr ;
017800131220
017900131220     P #get_plan_descr...
018000131220     P                 e
018100131220
018200140103      *---------------------------------------------------------------------
018300140103      * Function to retrieve plan carrier and return to caller
018400140103      *---------------------------------------------------------------------
018500140103     P #get_plan_carrier...
018600140103     P                 b                   export
018700140103
018800140103      /define get_plan_carrier_pi
018900140103      /define get_plan_carrier_fields
019000140103      /copy qcpysrc,plnsrvpgmp
019100140103      /undefine get_plan_carrier_fields
019200140103      /undefine get_plan_carrier_pi
019300140103
019400140815        plan_error = #get_plan_master(trust:sub:plan) ;
019500140815        if plan_error = *blanks ;
019600140815         return pcarr ;
019700140815        else ;
019800140815         return *blanks ;
019900140815        endif ;
020000140815
020100140103     P #get_plan_carrier...
020200140103     P                 e
020300140103
020400140731      *---------------------------------------------------------------------
020500140731      * Function to retrieve plan group from the codes file
020600140731      *---------------------------------------------------------------------
020700140731     P #get_ACA_planid...
020800140731     P                 b                   export
020900140731
021000140731      /define get_ACA_planid_pi
021100140731      /define get_ACA_planid_fields
021200140731      /copy qcpysrc,plnsrvpgmp
021300140731      /undefine get_ACA_planid_fields
021400140731      /undefine get_ACA_planid_pi
021500140731
021600140819        plan_error = #get_plan_master(p_trust:p_sub:p_plan) ;
021700140815        if plan_error = *blanks ;
021800140815         return pxcarpln ;
021900140815        else ;
022000140815         return *blanks ;
022100140815        endif ;
022200140731
022300140731     P #get_ACA_planid...
022400140731     p                 e
022500140731
022600140815      *---------------------------------------------------------------------
022700140815      * Function to retrieve master record - not exported
022800140815      *---------------------------------------------------------------------
022900140815     P #get_plan_master...
023000140815     P                 b
023100140815
023200140815      /define get_plan_master_pi
023300140815      /define get_plan_master_fields
023400140819      /copy qcpysrc,plnsrvpgmp
023500140815      /undefine get_plan_master_pi
023600140815      /undefine get_plan_master_fields
023700140815
023800140815        #pln_openfiles('PLNUNIQUE') ;
023900140815        #pln_openfiles('PLNAUXP') ;
024000140815
024100140815        clear *all plnmsr ;
024200140815        clear *all plnauxr ;
024300140815
024400140815        //?get plan master record
024500140815        chain (p_trust:p_sub:p_plan) plnunique ;
024600140815        if not %found(plnunique) ;
024700140815         return 'Y' ;
024800140815        endif ;
024900140815
025000140815        chain (p_trust:p_sub:p_plan) plnauxp ;
025100140815        if not %found(plnunique) ;
025200140815         return 'Y' ;
025300140815        endif ;
025400140815
025500140815        return *blanks ;
025600140815
025700140815     P #get_plan_master...
025800140815     p                 e
025900140815
026000140904      *---------------------------------------------------------------------
026100140904      * Function to retrieve plan sort order for invoices
026200140904      *---------------------------------------------------------------------
026300140904     P #get_plan_sort  b                   export
026400140904
026500140904      /define get_plan_sort_pi
026600140904      /define get_plan_sort_fields
026700140904      /copy qcpysrc,plnsrvpgmp
026800140904      /undefine get_plan_sort_fields
026900140904      /undefine get_plan_sort_pi
027000140904
027100140912        #pln_openfiles('PCSEQ') ;
027200140912        chain (p_plancat) pcseq ;
027300140912        if %found (pcseq) and pcsseq <> *zeros ;
027400140912         return pcsseq ;
027500140905        else ;
027600140905         return *hival ;
027700140905        endif ;
027800140904
027900140904     P #get_plan_sort  e
028000140904      *---------------------------------------------------------------------
