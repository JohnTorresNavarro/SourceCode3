000100131230     Hnomain option(*nodebugio) debug copyright('GBS - GroupBenefitServices')
000200131230      *------------------------------------------------------------------
000300131230      * Module Name...PRORATE
000400131230      * Written by...:Debora Bond
000500131230      * Date Written.:12/12/2013
000600131230      * Description..:Module within service program PRORATE....
000700131230      * Called From..:Any program
000800131230      *------------------------------------------------------------------
000900131230      * Modification History:
001000131230      *
001100131230      *    Date    Description                                       By
001200131230      *  --------  -----------------------------------------        ----
001300131230      *------------------------------------------------------------------
001400131212     Fcarunique if   e           k disk
001500131212
001600131212      *---------------------------------------------------------------------
001700140103      *?#get_prorate_premium:  this function prorates a premium and returns
001800140103      *?to the caller a DS with two amounts fields:  prorated billed premium
001900140103      *?and prorated net premium.  Look at the prototypes for the inbound
002000140103      *?parms...the caller is responsible for passing the proper enrollment
002100140103      *?and cancel date (member or dependent)
002200131212      *---------------------------------------------------------------------
002300131212     p #get_prorate_premium...
002400131212     P                 b                   export
002500131212
002600140106      /define copy_prorate_pi
002700140106      /define copy_prorate_fields
002800140102      /define copy_rtv_prorate_return
002900131231      /copy qcpysrc,proratep
003000140102      /undefine copy_rtv_prorate_return
003100140106      /undefine copy_prorate_pi
003200140106      /undefine copy_prorate_fields
003300131212
003400131212      *?local variables
003500131212     D prorate_method  s              4
003600131212     D daysinmonth     s              3  0
003700131212     D daystoadjust    s                   like(daysinmonth)
003800131212     D holddays        s                   like(daysinmonth)
003900131212
004000140102     D                 ds                  inz
004100140102     D enrolldate
004200131212     D  enroll_year                   4  0 overlay(enrolldate)
004300131212     D  enroll_month                  2  0 overlay(enrolldate:*next)
004400131212     D  enroll_day                    2  0 overlay(enrolldate:*next)
004500131212
004600140102     D canceldate
004700131212     D  cancel_year                        overlay(canceldate)
004800131212     D                                     like(enroll_year)
004900131212     D  cancel_month                       overlay(canceldate:*next)
005000131212     D                                     like(enroll_month)
005100131212     D  cancel_day                         overlay(canceldate:*next)
005200131212     D                                     like(enroll_day)
005300131212
005400140102     D rundate
005500131212     D  run_year                           overlay(rundate)
005600131212     D                                     like(enroll_year)
005700131212     D  run_month                          overlay(rundate:*next)
005800131212     D                                     like(enroll_month)
005900131212     D  run_day                            overlay(rundate:*next)
006000131212     D                                     like(enroll_day)
006100131212
006200131212      /free
006300131212
006400140102       //?default return premiums to inbound premiums (net and billed)
006500140102       pro_prem_bill = p_prembill ;
006600140102       pro_prem_net = p_premnet ;
006700131231
006800140102       #pro_openfiles('CARUNIQUE') ;
006900140102
007000131216       //?get the carrier record because we need their rule for prorating
007100140102       //?if carrier not found OR does not prorate return original premiums
007200131212       chain p_carrier carunique ;
007300131212       if cprrul = *blanks or not %found(carunique) ;
007400140102        return p_ret_premiums ;
007500131212       endif ;
007600131212
007700140102       //?move inbound parms (dates) to DS...then ensure run day is = 01
007800140102       enrolldate = %editc(p_enrolldate:'X') ;
007900140102       canceldate = %editc(p_canceldate:'X') ;
008000140102       rundate = %editc(p_rundate:'X') ;
008100140103
008200140102       if run_day <> 1 ;
008300140102        run_day = 1 ;
008400140102       endif ;
008500140102
008600131212       //?get total # of days in coverage_month
008700140102       daysinmonth = %subdt(%date(rundate:*ISO0) + %months(1) - %days(1) : *d) ;
008800131212
008900131212       //?now, logic to determine HOW to prorate
009000131212
009100131212       //?prorate enroll and cancel date (same month and year)
009200131212       if enroll_day > 01 and cancel_day > 01 and enroll_month = run_month
009300131212        and enroll_year = run_year and cancel_month = run_month and
009400131212        cancel_year = run_year ;
009500131212        holddays = cancel_day ;
009600131212        daystoadjust = cancel_day - enroll_day ;
009700131212        prorate_method = 'BOTH' ;
009800131212        exsr prorate_premium ;
009900140102        return p_ret_premiums ;
010000131212       endif ;
010100131212
010200131212       //?prorate cancel date only
010300131212       if cancel_day > 01 and cancel_month = run_month and cancel_year =
010400131212        run_year ;
010500131212        holddays = cancel_day ;
010600131212        daystoadjust = holddays - 1 ;
010700131212        prorate_method = 'CAN' ;
010800131212        exsr prorate_premium ;
010900140102        return p_ret_premiums ;
011000131212       endif ;
011100131212
011200131212       //?prorate enrollment date only
011300131212       if enroll_day > 01 and enroll_month = run_month and enroll_year =
011400131212        run_year ;
011500131212        holddays = enroll_day ;
011600131212        daystoadjust = daysinmonth - holddays + 1 ;
011700131212        prorate_method = 'ENR' ;
011800131212
011900131212        //?rule 02 requires full premium if enrolled <= 15th...so holddays
012000131212        //?will have to be faked out with hardcoded day so the full premium
012100131212        //?will be billed.  Conversely, if enrolled after the 15th no premium
012200131212        //?will be billed.
012300131212        if cprrul = '02' ;
012400131212         if holddays <= 15 ;
012500131212          holddays = 16 ;
012600131212         else ;
012700131212          holddays = 14 ;
012800131212         endif ;
012900131212        endif ;
013000131212
013100131212        exsr prorate_premium ;
013200140102        return p_ret_premiums ;
013300131212
013400131212       endif ;
013500131212
013600131212       //?if you get to this point you've not RETURNED to the caller yet...
013700131212       //?return original premium
013800140102       return p_ret_premiums ;
013900131212
014000131212       //-------------------------------------------------------------------
014100131212       //?prorate_premium:  this subr will do the actual proration - based
014200131212       //?on the following fields:
014300131212       //?-------------------------------------
014400131212       //?holddays       - effective day of adjustment
014500131212       //?cprrul         - pro rate rule from carrier
014600131212       //?premium        - full month premium
014700131212       //?dayrateb       - daily rate billed
014800131212       //?daysinmonth    - # of days in month of prorated amount
014900131212       //?daystoadjust   - # of days to adjust prorated amount
015000131212       //?prorate_method - what date are we prorating on?  (BOTH, ENR, CAN)
015100131212       //-------------------------------------------------------------------
015200131212       begsr prorate_premium ;
015300131212
015400131212        //?daily rule - prorate to the day
015500131212        if cprrul = '01' ;
015600140102         eval(h) pro_prem_bill = (p_prembill / daysinmonth) * daystoadjust ;
015700140102         eval(h) pro_prem_net = (p_premnet / daysinmonth) * daystoadjust ;
015800131212        endif ;
015900131212
016000131212        //?mid month rule - cancelled up to the 15th = no premium billed
016100131212        if cprrul = '02' and holddays <= 15 ;
016200140102         clear p_ret_premiums ;
016300131212        endif ;
016400131212
016500131212        //?full month rule - only charge for full FIRST month when day = 01
016600131212        //?                  always charge for full LAST month unless day
016700131212        //?                  = 01 (no coverage)
016800131212        if cprrul = '03' and ( (prorate_method = 'BOTH') or
016900131212           (prorate_method = 'ENR' and holddays <> 01) or
017000131216           (prorate_method = 'CAN' and holddays = 01) ) ;
017100140102         clear p_ret_premiums ;
017200131212        endif ;
017300131212
017400131212       endsr ;
017500131212
017600131212      /end-free
017700131212
017800131212     p #get_prorate_premium...
017900131212     p                 e
018000131231      *---------------------------------------------------------------------
018100131231      *
018200131231      *---------------------------------------------------------------------
018300131231     P #pro_openfiles  b
018400131231
018500131231     d #pro_openfiles  pi
018600131231     D  file                         10    value
018700131231
018800131231      /free
018900131231
019000131231       if file = 'CARUNIQUE' ;
019100131231        if not %open(carunique) ;
019200131231         open carunique ;
019300131231        endif ;
019400131231       endif ;
019500131231
019600131231      /end-free
019700131231
019800131231     P #pro_openfiles  e
019900131231      *---------------------------------------------------------------------
020000131231      *
020100131231      *---------------------------------------------------------------------
020200131231     P #pro_closesrv   b                   export
020300131231
020400131231      /define pro_closesrv_pi
020500131231      /copy qcpysrc,proratep
020600131231      /undefine pro_closesrv_pi
020700131231
020800131231      /free
020900131231
021000131231       close *all ;
021100131231
021200131231      /end-free
021300131231
021400131231     P #pro_closesrv   e
