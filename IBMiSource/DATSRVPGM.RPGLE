000100000000     H option(*nodebugio) nomain debug
000200000000      *-------------------------------------------------------------------------
000300131015      *    G B S   S E R V I C E S
000400000000      *------------------------------------------------------------------ ------
000500000000      * Module Name...DATSRVPGM
000600000000      * Written by...:Debora Bond
000700131015      * Date Written.:10/15/2013
000800131015      * Description..:This module houses many of the commonly used DATE
000900131015      *               functions
001000000000      * Procedures...:
001100000000      *
001200000000      * Called From..:Any program
001300000000      * Bound Calls..:*None
001400000000      * Dynamic Calls:*None
001500000000      *------------------------------------------------------------------ ------
001600000000      * Modification History:
001700000000      *
001800131015      *    Date    Description                                  By
001900131015      *  --------  -----------------------------------------   ----
002000140403      *  04/03/14  Added function #get_gbs_eom                 DPB
002100000000      *
002200000000      *------------------------------------------------------------------ ------
002300131023     Fholidays  if   e           k disk    usropn
002400000000
002500000000      **********************************************************************************************
002600000000      * This procedure will receive a numeric date value (5/6/8-digit) and return a numeric date.
002700000000      * Format of the incoming date and the returned date are specified.
002800000000      *
002900000000      * It is intended to facilitate date manipulations in programs where date-format fields were
003000000000      * not originally coded, etc.
003100000000      *
003200000000      * If the incoming date is not valid for the format specified, a zero date is returned.
003300000000      *
003400000000      * Since the returned date is numeric, default punctuation is not a factor (i.e. if a Julian
003500000000      * date is requested, a 5 digit number will be returned which must be handled by the caller).
003600000000      **********************************************************************************************
003700000000
003800000000      *-------------------------------------------------------------------------
003900131022      * Begin the procedure.
004000000000      *-------------------------------------------------------------------------
004100000000     P#cvtdate         b                   export                               Begin procedure
004200000000
004300131022      * Interface definition
004400000000      /Define Copy_#cvtdate_interface
004500000000      /Define Copy_#cvtdate_Fields
004600131015      /copy qcpysrc,datsrvpgmp
004700000000      /UnDefine Copy_#cvtdate_Fields
004800000000      /Undefine Copy_#cvtdate_interface
004900000000
005000000000      * Define local variables.
005100000000     D result          s              8  0
005200131015     D int4            s              4  0
005300131015     D int6            s              6  0
005400000000     D d_mdy           s               d   datfmt(*mdy)                         mm/dd/yy
005500000000     D d_dmy           s               d   datfmt(*dmy)                         dd/mm/yy
005600000000     D d_ymd           s               d   datfmt(*ymd)                         yy/mm/dd
005700000000     D d_jul           s               d   datfmt(*jul)                         yy/ddd
005800000000     D d_iso           s               d   datfmt(*iso)                         yyyy-mm-dd
005900000000     D d_usa           s               d   datfmt(*usa)                         mm/dd/yyyy
006000000000     D d_eur           s               d   datfmt(*eur)                         dd.mm.yyyy
006100000000     D d_jis           s               d   datfmt(*jis)                         yyyy-mm-dd
006200000000     D p_o             s                   like(p_outfmt)
006300000000     D p_i             s                   like(p_infmt)
006400000000     D lo              c                   'abcdefghijklmnopqrstuvwxyz'
006500000000     D up              c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
006600000000
006700000000     C                   do
006800000000
006900000000     C* If incoming date is zero, force output to zero and exit immediately.
007000000000     C                   if        p_datin = 0
007100000000     C                   z-add     0             result
007200000000     C                   leave
007300000000     C                   endif
007400000000
007500000000     C* Convert incoming format ID's to uppercase.
007600000000     C     lo:up         xlate     p_outfmt      p_o
007700000000     C     lo:up         xlate     p_infmt       p_i
007800000000
007900000000     C* Force return variable to zero.  This is the 'error' condition.  If this procedure is
008000000000     C* successful, the variable will contain a date value upon return.  (Also, in most cases
008100000000     C* reviewed, preferred result of bad/null date condition is zero - for range testing, etc.
008200000000     C* If this is not the case in an application, test for zero and change the result within
008300000000     C* the application.)
008400000000     C                   z-add     0             result
008500000000
008600000000     C* Validate format codes.  If invalid, drop out.
008700000000     C                   if        p_o <> '*MDY' AND p_o <> '*DMY' AND
008800000000     C                             p_o <> '*YMD' AND p_o <> '*JUL' AND
008900000000     C                             p_o <> '*ISO' AND p_o <> '*USA' AND
009000000000     C                             p_o <> '*EUR' AND p_o <> '*JIS' AND
009100131015     C                             p_o <> '*YM ' AND p_o <> '*MY '
009200000000     C                   leave
009300000000     C                   endif
009400000000
009500000000     C                   if        p_i <> '*MDY' AND p_i <> '*DMY' AND
009600000000     C                             p_i <> '*YMD' AND p_i <> '*JUL' AND
009700000000     C                             p_i <> '*ISO' AND p_i <> '*USA' AND
009800000000     C                             p_i <> '*EUR' AND p_i <> '*JIS'
009900000000     C                   leave
010000000000     C                   endif
010100000000
010200000000     C* Validate that incoming date is valid in the specified format.  If not, drop out.
010300000000     C* (Arranged in order of anticipated frequency of use.)
010400000000     C                   select
010500000000     C                   when      p_i = '*MDY'
010600000000     C     *mdy          test(d)                 p_datin                90
010700000000     C                   when      p_i = '*YMD'
010800000000     C     *ymd          test(d)                 p_datin                90
010900000000     C                   when      p_i = '*ISO' OR p_i = '*JIS'
011000000000     C     *iso          test(d)                 p_datin                90
011100000000     C                   when      p_i = '*USA'
011200000000     C     *usa          test(d)                 p_datin                90
011300000000     C                   when      p_i = '*DMY'
011400000000     C     *dmy          test(d)                 p_datin                90
011500000000     C                   when      p_i = '*EUR'
011600000000     C     *eur          test(d)                 p_datin                90
011700000000     C                   when      p_i = '*JUL'
011800000000     C     *jul          test(d)                 p_datin                90
011900000000     C                   endsl
012000000000
012100000000     C   90              leave                                                  Bad date
012200000000
012300000000     C* Move the date to a common holding date-format field.
012400000000     C                   select
012500000000     C                   when      p_i = '*MDY'
012600000000     C     *mdy          move      p_datin       d_iso
012700000000     C                   when      p_i = '*YMD'
012800000000     C     *ymd          move      p_datin       d_iso
012900000000     C                   when      p_i = '*ISO' OR p_i = '*JIS'
013000000000     C     *iso          move      p_datin       d_iso
013100000000     C                   when      p_i = '*USA'
013200000000     C     *usa          move      p_datin       d_iso
013300000000     C                   when      p_i = '*DMY'
013400000000     C     *dmy          move      p_datin       d_iso
013500000000     C                   when      p_i = '*EUR'
013600000000     C     *eur          move      p_datin       d_iso
013700000000     C                   when      p_i = '*JUL'
013800000000     C     *jul          move      p_datin       d_iso
013900000000     C                   endsl
014000000000
014100000000     C* Move from the holding field to the requested output format field (if output is in ISO/JIS
014200000000     C* format, no need to move since it was loaded there above).
014300000000     C                   select
014400000000     C                   when      p_o = '*MDY'
014500000000     C                   move      d_iso         d_mdy
014600000000     C                   move      d_mdy         result
014700000000     C                   when      p_o = '*YMD'
014800000000     C                   move      d_iso         d_ymd
014900000000     C                   move      d_ymd         result
015000000000     C                   when      p_o = '*ISO' OR p_o = '*JIS'
015100000000     C                   move      d_iso         result
015200000000     C                   when      p_o = '*USA'
015300000000     C                   move      d_iso         d_usa
015400000000     C                   move      d_usa         result
015500000000     C                   when      p_o = '*DMY'
015600000000     C                   move      d_iso         d_dmy
015700000000     C                   move      d_dmy         result
015800000000     C                   when      p_o = '*EUR'
015900000000     C                   move      d_iso         d_eur
016000000000     C                   move      d_eur         result
016100000000     C                   when      p_o = '*JUL'
016200000000     C                   move      d_iso         d_jul
016300000000     C                   move      d_jul         result
016400131015     C                   when      p_o = '*YM '
016500131015     C                   move      d_iso         d_ymd
016600131015     C                   move      d_ymd         int6                           YYMMDD
016700131015     C                   movel     int6          int4                           Truncate to YYMM
016800131015     C                   z-add     int4          result
016900131015     C                   when      p_o = '*MY '
017000131015     C                   move      d_iso         d_dmy
017100131015     C                   move      d_dmy         int6                           DDMMYY
017200131015     C                   move      int6          int4                           Truncate to MMYY
017300131015     C                   z-add     int4          result
017400000000     C                   endsl
017500000000
017600000000     C                   enddo
017700000000      * Return result.
017800000000     C                   return    result
017900000000
018000000000     P#cvtdate         e                                                        End procedure
018100000000
018200000000      *-------------------------------------------------------------------------
018300131022      * Begin the procedure.
018400000000      *-------------------------------------------------------------------------
018500000000     P#get_dow         b                   export
018600000000
018700131022      * Procedure interface
018800000000      /Define Copy_#get_dow_interface
018900000000      /Define Copy_#get_dow_Fields
019000131015      /copy qcpysrc,datsrvpgmp
019100000000      /UnDefine Copy_#get_dow_Fields
019200000000      /Undefine Copy_#get_dow_interface
019300000000
019400000000      * Local Variables
019500000000     D BaseDate        S               D   datfmt(*iso) inz(D'1899-12-31')
019600000000     D WorkField       S              5  0
019700000000     D DayOfWeek       S              9    BASED(DayPtr)
019800000000     D DayPtr          S               *   INZ(%ADDR(DayName))
019900000000
020000000000     D DayData         DS
020100000000     D                                9A   inz('Sunday')
020200000000     D                                9A   inz('Monday')
020300000000     D                                9A   inz('Tuesday')
020400000000     D                                9A   inz('Wednesday')
020500000000     D                                9A   inz('Thursday')
020600000000     D                                9A   inz('Friday')
020700000000     D                                9A   inz('Saturday')
020800000000
020900000000     D DayName                        9    DIM(7) Overlay(DayData)
021000000000
021100131022     C                   Test(e)                 p_datein
021200000000
021300000000     C                   if        not %error
021400131022     C     p_datein      Subdur    BaseDate      WorkField:*D
021500000000     C                   Div       7             WorkField
021600000000     C                   Mvr                     WorkField
021700000000     C                   Eval      Dayptr = %ADDR(DayName(WorkField + 1))
021800000000
021900000000     C                   Else
022000000000     C                   Eval      DayOfWeek = *Blanks
022100000000     C                   Endif
022200000000
022300000000     C                   Return    DayOfWeek
022400000000
022500000000     P#get_dow         e
022600000000
022700131022      *-------------------------------------------------------------------------
022800131022      * Begin the procedure.
022900131022      *-------------------------------------------------------------------------
023000131023     P#chk_holiday     b                   export
023100131022
023200131022      * Procedure interface
023300131023      /Define Copy_#chk_holiday_interface
023400131023      /Define Copy_#chk_holiday_Fields
023500131022      /copy qcpysrc,datsrvpgmp
023600131023      /unDefine Copy_#chk_holiday_interface
023700131023      /unDefine Copy_#chk_holiday_Fields
023800131022
023900131022      /free
024000131023        #dat_openfiles('HOLIDAYS') ;
024100131022
024200131023        //?the 2nd parm is the holiday type (bank, GBS, etc...)...if not
024300131023        //?passed assume caller is requesting BANK holiday
024400131023        if %parms < 2 ;
024500131023         holidytype = 'BANK' ;
024600131023        else ;
024700131023         holidytype = p_holidaytype ;
024800131023        endif ;
024900131023
025000131023        setll (p_datein:holidytype) holidays ;
025100131023        if %equal(holidays) ;
025200131022         return 'Y' ;
025300131022        else ;
025400131022         return 'N' ;
025500131022        endif ;
025600131022
025700131022      /end-free
025800131022
025900131023     P#chk_holiday     e
026000131022
026100131022      *---------------------------------------------------------------------
026200131022      *
026300131022      *---------------------------------------------------------------------
026400131022     P #dat_openfiles  b
026500131022
026600131022     d #dat_openfiles  pi
026700131022     D  file                         10    value
026800131022
026900131022      /free
027000131022
027100131023       if file = 'HOLIDAYS';
027200131023        if not %open(holidays) ;
027300131023         open holidays ;
027400131022        endif ;
027500131022       endif ;
027600131022
027700131022      /end-free
027800131022
027900131022     P #dat_openfiles  e
028000131022      *---------------------------------------------------------------------
028100131022      *
028200131022      *---------------------------------------------------------------------
028300131022     P #dat_closesrv   b                   export
028400131022
028500131022      /define dat_closesrv_pi
028600131022      /copy qcpysrc,datsrvpgmp
028700131022      /undefine dat_closesrv_pi
028800131022
028900131022      /free
029000131022
029100131022       close *all ;
029200131022
029300131022      /end-free
029400131022
029500131022     P #dat_closesrv   e
029600140325
029700140325      *---------------------------------------------------------------------
029800140325      * function:  get_gbs_eom
029900140325      *---------------------------------------------------------------------
030000140325     P #get_gbs_eom    b                   export
030100140325
030200140325     D eom             s               d
030300140325     D rundate         s               d
030400140327     D start_date      s               d
030500140325
030600140325      /define copy_#get_gbs_eom_interface
030700140327      /define copy_#get_gbs_eom_fields
030800140325      /copy qcpysrc,datsrvpgmp
030900140325      /undefine copy_#get_gbs_eom_interface
031000140327      /undefine copy_#get_gbs_eom_fields
031100140325
031200140325      /free
031300140325
031400140402       //?optional *entry parm is date to use instead of system date
031500140327       if %parms > 0 ;
031600140327        start_date = p_datein ;
031700140327       else ;
031800140327        start_date = %date() ;
031900140327       endif ;
032000140327
032100140402       //?start with today or *entry date then get the last day of the month
032200140327       eom = (start_date + %months(1))
032300140327              - %days(%subdt(start_date + %months(1):*DAYS));
032400140325
032500140402       //?initially set rundate = eom date
032600140325       rundate = eom ;
032700140325
032800140325       //?now stay in this DO loop until "rundate" is a working GBS day
032900140325       //?(non GBS holiday and not a weekend)
033000140325       dow 1 = 1 ;
033100140325
033200140325        if #chk_holiday(rundate:'GBS') <> 'Y' and
033300140325           #get_dow(rundate) <> 'Saturday' and
033400140325           #get_dow(rundate) <> 'Sunday' ;
033500140325         leave ;
033600140325        else ;
033700140325         rundate -= %days(1) ;
033800140325        endif ;
033900140325
034000140325       enddo ;
034100140325
034200140325       return rundate ;
034300140325
034400140325      /end-free
034500140325
034600140325     P #get_gbs_eom    e
034700140325      *---------------------------------------------------------------------
