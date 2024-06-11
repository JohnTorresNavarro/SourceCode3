000100130909     Hnomain option(*nodebugio) debug copyright('GBS - GroupBenefitServices')
000200130909
000300130909      *------------------------------------------------------------------
000400140731      * Module Name...CARSRVPGM
000500130909      * Written by...:Debora Bond
000600140731      * Date Written.:07/31/2014
000700140731      * Description..:Module within service program CARSRVPGM....functions
000800140731      *               related to CARMST
000900130909      * Called From..:Any program
001000140731      *
001100140731      *?Programmer note:  To reduce I/O this program only chains to CARMST
001200140731      *?if the carrier passed in differs from the last time the srvpgm was
001300140731      *?called (in other words....only if carrier code changed)
001400130909      *------------------------------------------------------------------
001500130909      * Modification History:
001600130909      *
001700130909      *    Date    Description                                       By
001800130909      *  --------  -----------------------------------------        ----
001900130909      *------------------------------------------------------------------
002000130909
002100140731     Fcarunique if   e           k disk    usropn
002200140801     Fhypercarr if   e           k disk    usropn
002300130909
002400140731      *?global stand alone fields
002500140731     D sv_carrcd       s                   like(carrcd)
002600140731
002700140731      *---------------------------------------------------------------------
002800140731      * Function to retrieve carrier name
002900140731      *---------------------------------------------------------------------
003000140731     P #get_carrier_record...
003100140731     P                 b
003200140731
003300140731      /define get_carrier_record_pi
003400140731      /define get_carrier_record_fields
003500140731      /copy qcpysrc,carsrvpgmp
003600140731      /undefine get_carrier_record_pi
003700140731      /undefine get_carrier_record_fields
003800140731
003900140731      /free
004000140731
004100140731        #car_openfiles('CARUNIQUE') ;
004200140801        #car_openfiles('HYPERCARR') ;
004300140731
004400140731        if p_carrcd <> sv_carrcd ;
004500140731         clear carmsr ; // clear format before chain
004600140801         clear rhc ; // clear format
004700140731         chain (p_carrcd) carunique ;
004800140801         if cgrpcd <> *blanks ;
004900140801          chain (cgrpcd) hypercarr ;
005000140801         endif ;
005100140731         sv_carrcd = p_carrcd ;
005200140731        endif ;
005300140731
005400140731      /end-free
005500140731
005600140731     P #get_carrier_record...
005700140731     P                 e
005800140731
005900140731      *---------------------------------------------------------------------
006000140731      * Function to retrieve carrier name
006100140731      *---------------------------------------------------------------------
006200140731     P #get_carrier_name...
006300140731     P                 b                   export
006400140731
006500140731      /define get_carrier_name_pi
006600140731      /define get_carrier_name_fields
006700140731      /copy qcpysrc,carsrvpgmp
006800140731      /undefine get_carrier_name_pi
006900140731      /undefine get_carrier_name_fields
007000140731
007100140731      /free
007200140731
007300140731        #get_carrier_record(p_carrcd) ;
007400140801        if %parms() >= 2 and p_hypercarr = 'Y' ;
007500140801         return hcname ;
007600140801        else ;
007700140801         return cname ;
007800140801        endif ;
007900140731
008000140731      /end-free
008100140731
008200140731     P #get_carrier_name...
008300140731     P                 e
008400140731
008500130909      *---------------------------------------------------------------------
008600140731      * Function to retrieve carrier grouper code
008700130909      *---------------------------------------------------------------------
008800140731     P #get_grouper    b                   export
008900130909
009000140731      /define get_grouper_pi
009100140731      /define get_grouper_fields
009200140731      /copy qcpysrc,carsrvpgmp
009300140731      /undefine get_grouper_fields
009400140731      /undefine get_grouper_pi
009500130909
009600130909      /free
009700130909
009800140731        #car_openfiles('CARUNIQUE') ;
009900140731        #get_carrier_record(p_carrcd) ;
010000130909
010100140731        return cgrpcd ;
010200130909
010300130909      /end-free
010400130909
010500140731     P #get_grouper    e
010600130909
010700140731      *---------------------------------------------------------------------
010800140731      * Function to retrieve carrier prorating rule
010900140731      *---------------------------------------------------------------------
011000140731     P #get_prorate_rule...
011100140731     P                 b                   export
011200140731
011300140731      /define get_prorate_rule_pi
011400140731      /define get_prorate_rule_fields
011500140731      /copy qcpysrc,carsrvpgmp
011600140731      /undefine get_prorate_rule_pi
011700140731      /undefine get_prorate_rule_fields
011800140731
011900140731      /free
012000140731
012100140731        #car_openfiles('CARUNIQUE') ;
012200140731        #get_carrier_record(p_carrcd) ;
012300140731
012400140731        return cprrul ;
012500140731
012600140731      /end-free
012700140731
012800140731     P #get_prorate_rule...
012900140731     P                 e
013000140731
013100130909      *---------------------------------------------------------------------
013200130909      *
013300130909      *---------------------------------------------------------------------
013400140731     P #car_openfiles  b
013500130909
013600140731     d #car_openfiles  pi
013700130909     D  file                         10    value
013800130909
013900130909      /free
014000130909
014100140731       if file = 'CARUNIQUE' ;
014200140731        if not %open(carunique) ;
014300140731         open carunique ;
014400130909        endif ;
014500140801       elseif file = 'HYPERCARR' ;
014600140801        if not %open(hypercarr) ;
014700140801         open hypercarr ;
014800140801        endif ;
014900130909       endif ;
015000130909
015100130909      /end-free
015200130909
015300140731     P #car_openfiles  e
015400130909      *---------------------------------------------------------------------
015500130909      *
015600130909      *---------------------------------------------------------------------
015700140731     P #car_closesrv   b                   export
015800130909
015900140731      /define car_closesrv_pi
016000140731      /copy qcpysrc,carsrvpgmp
016100140731      /undefine car_closesrv_pi
016200130909
016300130909      /free
016400130909
016500130909       close *all ;
016600130909
016700130909      /end-free
016800130909
016900140731     P #car_closesrv   e
017000140731      *---------------------------------------------------------------------
