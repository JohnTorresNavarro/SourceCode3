000100140623     H Indent ('| ') dftactgrp(*No) actgrp(*caller) bnddir('ALLSRVPGMN')
000200170112     H Option(*nodebugio)
000300990630      *? ***************************************************************
000400010322      *             GROUP BENIFIT SERVICES SOFTWARE           2000     *
000500010322      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700120820      *  Date Written:  08/20/12                                       *
000800120820      *  Description:   ACH Intercept 3-day Batches to Post Report     *
000900000118      *                                                                *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500120820      *                                                                *
001600121012      *  10/12/12  szz         Skip a day for Intercept bank holidays. *
001700130701      *   7/01/13  szz         Add Auto Debit Files to the report.     *
001800131025      *  10/24/13  dpb         Use external functions to retrieve      *
001900131025      *                        day_of_week and check banking holidays  *
002000131025      *                        (externalizes holidays)                 *
002100140506      *  05/06/14  dpb         Due to changes to the Robot Auto Debit  *
002200140506      *                        job - add warning to Auto debit file(s).*
002300170112      *  01/12/17  B.Rees      Added writing to a Physical File
002400170419      *  04/19/17  B.Rees      Checking the Name for the date instead
002500170419      *   Mod: Br02            of the file date.
002600190418      *  04/18/19  B.Rees      Adding a Mondays Date
002700190418      *   Mod: Br03
002800170112      *-----------------------------------------------------------------
002900010322
003000120820     FACH3DAYS  IF   E           K disk
003100120820     fACH3DAYR  O    E             Printer Oflind(*in91)
003200170112br01 fACH3DAYP  O    E           k disk
003300131023
003400131115     D check_date      s               d
003500131115     D counter         s              1  0
003600991020
003700170419br02 d isHoliday       s              1
003800170419br02 d DayName         s              9
003900170419br02 d CharDate        s             10
004000170419br02 d CompDate        s              6
004100170419br02 d FileDate        s              6
004200190418br03 d MondayDate      s              6
004300170419
004400991230    ? * Program status data structure
004500140506    ?D               ESDS                  EXTNAME(IOPGMD)
004600121120
004700131023      /define Copy_all_protos_and_fields
004800131023      /copy qcpysrc,datsrvpgmp
004900131023      /Undefine Copy_all_protos_and_fields
005000170419      *----------------------------------------------------------------
005100170419
005200120820     C                   Read      ACH3DAYS
005300170419     C                   Dou       %Eof(ACH3DAYS)
005400121106     C                   Movel     ODOBNM        IsItAW            2
005500130701     C                   Movel     ODOBNM        IsItAUT           3
005600130701     C                   If        IsItAW     =  'AW'    Or
005700130701     C                             IsItAUT    =  'AUT'
005800170419     C
005900170419     C*----------------------------------------------------------------
006000170419     C* Is the file creation date <= three business days ago?
006100170419     C*----------------------------------------------------------------
006200170419br02 C**                 if        %date(odcdat:*mdy0) <= check_date
006300170419br02 C                   if        CompDate = %Subst(odobnm:4:6)
006400190418br03 C                               or MondayDate = %Subst(odobnm:4:6)
006500170419
006600170419
006700140506       clear warn_text ;
006800140506       if isitaut = 'AUT' ;
006900140506        warn_text = 'Please check posting date from Finance before actually' +
007000140506                    ' posting this file.' ;
007100140506       endif ;
007200170112br01 C                   Write     Ach3Day_R
007300170112     C                   Write     DTL
007400120820     C                   End
007500121120      *
007600121106     C                   End
007700120820     C                   Read      ACH3DAYS
007800170419     C                   Enddo
007900121120      *
008000001211     C                   Write     EOR
008100121120     C                   Eval      *INLR = *On
008200000118      * ? _____________________________________________________________
008300000118      *? *                                                             *
008400000118      *? *        Initialize.                                          *
008500000118      *? *_____________________________________________________________*
008600120820     C     *Inzsr        BegSr
008700001012
008800120820     C                   Write     HDR
008900120820
009000121113      *---
009100131119      * Starting with today, count backwards until you've gone through 3
009200131119      * business/non-banking days/non-weekend days
009300121113      *---
009400131115     C                   eval      check_date = %date()
009500170622     C                   dou       counter = 3
009600131115
009700170419     C                   eval      check_date -= %days(1)
009800170419
009900170419br02 C                   eval      isHoliday = #chk_holiday(check_date)
010000170419br02 C                   eval      DayName = #get_dow(check_date)
010100170419
010200131115     C                   if        #chk_holiday(check_date) <> 'Y' and
010300131115     C                             #get_dow(check_date) <> 'Saturday' and
010400131115     C                             #get_dow(check_date) <> 'Sunday'
010500131115     C                   add       1             counter
010600131115     C                   endif
010700131115
010800131115     C                   enddo
010900170419     C
011000170419br02 C                   eval      CharDate = %Char(Check_Date:*iso)
011100170419br02 C                   eval      CompDate = %Subst(CharDate:6:2) +
011200170419br02 C                                        %Subst(CharDate:9:2) +
011300170419br02 C                                        %Subst(CharDate:3:2)
011400170419
011500190418         MondayDate = '';
011600190418br03     if #get_dow(check_date) = 'Monday';
011700190418            Check_date -= %days(2);       // Get Saturday Date
011800190418            CharDate = %Char(Check_Date:*iso);
011900190418
012000190418            MondayDate = %Subst(CharDate:6:2) +
012100190418                         %Subst(CharDate:9:2) +
012200190418                         %Subst(CharDate:3:2);
012300190418         endif;
012400190418
012500001107     C                   Move      *On           *In91
012600001107
012700120820     C                   EndSr
