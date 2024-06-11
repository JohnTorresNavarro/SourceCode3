000100130501     H*Indent ('| ')
000200001003    ? *_________________________________________________________________________
000300001003    ? *                                                                *
000400130501    ? *  Description:  AARPT01  Report any new or changed AAs for      *
000500130501    ? *                          accounts.                             *
000600001003    ? *                                                                *
000700130501    ? *  (c)Copyright 2013 by GBS Inc.                                 *
000800041116    ? *  This document contains restricted materials of GBS, Inc.      *
000900001003    ? *                                                                *
001000030121    ? *  Written by:    SZZ                                            *
001100130501    ? *  Date Written:  5/01/13                                        *
001200001003    ? *                                                                *
001300001003    ? *  History:                                                      *
001400130528    ? *            Revised by -  szz                                   *
001500130528    ? *            Date -        05/28/2013                            *
001600130528    ? *            Revision -    Brandon asked that the report be      *
001700130528    ? *                           generated only once a week instead   *
001800130528    ? *                           of daily so the report will have to  *
001900130528    ? *                           select for the previous week not for *
002000130528    ? *                           "today".                             *
002100070413      *                                                                *
002200021218      *                                                                *
002300991207    ? *_________________________________________________________________________
002400130501     FHISTL10   IF   E           K Disk
002500130501     FACCMST    IF   E           K Disk
002600130501     FAACODE    IF   E           K Disk
002700130501     FGBSECURE  IF   E           K Disk
002800130501     FAARPTCSV  O  A E             Disk
002900030121      *
003000130528     D OneWeekAgo      S               D   datfmt(*ISO)
003100130528    ?D ISOToday        S               D   datfmt(*ISO)
003200130501     IACCMSR
003300130501     i              AACODE                      A_AACODE
003400070417      *
003500130528     C     CmpDate       Setll     HISTL10
003600130528     C                   Read      HISTL10
003700021003      *
003800130501    ?C                   Dow       Not %Eof(HISTL10)
003900130528     C                   If        TRDATE   >=  CmpDate
004000130501     C                   Exsr      Process
004100130528     C                   End
004200130528     C                   If        TRDATE   >   Today
004300130528     C                   Leave
004400130528     C                   End
004500130528     C                   Read      HISTL10
004600080619     C                   Enddo
004700080619
004800030127    ?C                   Move      *On           *InLR
004900021004     C
005000130501      *---------------------------------------------------------------*
005100130501     C     Process       Begsr
005200130501      *---------------------------------------------------------------*
005300130501     C                   Exsr      Getfields
005400130501     C
005500130501     C                   Eval      WKRECORD  =   '"' +
005600130501     C                              %Trim(%Editc(HSTRST:'P'))   + '","' +
005700130501     C                              %Trim(%Editc(HSSUB#:'P'))   + '","' +
005800130501     C                              %Trim(%Editc(HSACCT:'P'))   + '","' +
005900130501     C                                           ACNAM1         + '","' +
006000130501     C                              %Trim(%Editc(TRDATE:'P'))   + '","' +
006100130501     C                                           CK#NOT         + '","' +
006200130501     C                                           FromName       + '","' +
006300130501     C                                           NOTE2          + '","' +
006400130501     C                                           ToName         + '","' +
006500130501     C                                           EnteredBy      + '",'
006600130501     C                   Write     AARPTCSR
006700130501     C*
006800130501     C                   EndSr
006900130501
007000130501      *---------------------------------------------------------------*
007100130501     C     GetFields     Begsr
007200130501      *---------------------------------------------------------------*
007300130501     C                   Clear                   FromName         30
007400130501     C                   Clear                   ToName           30
007500130501     C                   Clear                   EnteredBy        30
007600130501     C                   Z-Add     *Zeros        CodeAASeq         2 0
007700130501      * Account Name
007800130501     C     ActKey        Chain     ACCMST
007900130501      *
008000130501      * Entered by User:
008100130501     C                   Movel     HOPER         UserKey          10
008200130501     C     UserKey       Chain     GBSECURE
008300130501     C                   If        %Found(GBSECURE)
008400130501     C                   Eval      EnteredBy = %Trim(SCNAME)
008500130501     C                   Else
008600130501     C                   Eval      EnteredBy = %Trim('User Not on File ' +
008700130501     C                                           HOPER)
008800130501     C                   End
008900130501      * From AA
009000130501     C                   If        CK#NOT = *Blanks
009100130501     C                   Eval      FromName  = %Trim('No Previous AA')
009200130501     C                   Else
009300130501     C                   Eval      CodeAA = %Trim(CK#NOT)
009400130501     C     AAKey         Chain     AACODE
009500130501     C                   If        %Found(AACODE)
009600130501     C                   Eval      FromName  = %Trim(%Trim(ALNAM) + ', ' +
009700130501     C                                         %Trim(AFNAM))
009800130501     C                   Else
009900130501     C                   Eval      FromName  = %Trim('Not on File')
010000130501     C                   End
010100130501     C                   End
010200130501      *
010300130501      * New AA
010400130501     C                   Eval      CodeAA = %Trim(NOTE2)
010500130501     C     AAKey         Chain     AACODE
010600130501     C                   If        %Found(AACODE)
010700130501     C                   Eval      ToName    = %Trim(%Trim(ALNAM) + ', ' +
010800130501     C                                         %Trim(AFNAM))
010900130501     C                   Else
011000130501     C                   Eval      ToName    = %Trim('AA Code Not on File: ' +
011100130501     C                                          CodeAA)
011200130501     C                   End
011300130501      *
011400130501    ?C                   Endsr
011500130501      * ? _____________________________________________________________
011600130501      *? *                                                             *
011700130501      *? *        Write Excel Spreadsheet Title to CSV File            *
011800130501      *? *_____________________________________________________________*
011900130501     C     WriteSpTitle  BEGSR
012000130501     C*
012100130501     C                   Eval      WKRECORD  =   '"' +   'Trust'  + '","' +
012200130501     C                                                    'Sub#'  + '","' +
012300130501     C                                                    'Acct'  + '","' +
012400130501     C                                            'Account Name'  + '","' +
012500130501     C                                            'Date Entered'  + '","' +
012600130501     C                                                 'AA From'  + '","' +
012700130501     C                                     'Name of Previous AA'  + '","' +
012800130501     C                                                   'AA To'  + '","' +
012900130501     C                                      'Name of Current AA'  + '","' +
013000130501     C                                              'Entered By'  + '",'
013100130501     C                   Write     AARPTCSR
013200130501     C*
0133001305010320 C                   ENDSR
013400130501
013500070327    ? *___________________________________________________________________
013600070327    ? * Key lists
013700070327    ? *___________________________________________________________________
013800130501    ?C     Klist         Begsr
013900070427    ?C                   Endsr
014000041116    ? *________________________________________________________________
014100041116    ? * Initialization
014200041116    ? *________________________________________________________________
014300130501    ?C     *Inzsr        Begsr
014400130501    ? *
014500130501     C     AAKey         Klist
014600130501    ?C                   Kfld                    CodeAA            3
014700130501    ?C                   Kfld                    CodeAASeq
014800130501    ? *
014900130501     C     ActKey        Klist
015000130501    ?C                   Kfld                    HSTRST
015100130501    ?C                   Kfld                    HSSUB#
015200130501    ?C                   Kfld                    HSACCT
015300130501    ? *
015400021007     C     *DATE         Mult      10000.0001    Today             8 0
015500130501     C                   Exsr      WriteSpTitle
015600130528     C     *ISO          Move      Today         ISOToday
015700130528     C     ISOToday      Subdur    7:*d          OneWeekAgo
015800130528     C                   Move      OneWeekAgo    CmpDate           8 0
015900030414    * *
016000001003    ?C                   Endsr
