000100131121     H option(*nodebugio)
000200990630      *? ***************************************************************
000300020523      *
000400100727      *             GROUP BENIFIT SERVICES SOFTWARE           2010     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700100921      *  Date Written:  10/21/10                                       *
000800100727      *  Description:   Generate work file for Senior Dental Final     *
000900100921      *                   Termination Letters OTHER (not NP or death)  *
001000000118      *                                                                *
001100000118      *                R E V I S I O N    H I S T O R Y                *
001200000118      *  Date                                                          *
001300000118      *  Revised   Initials    Revision                                *
001400000118      *  --------  --------    --------------------------------------  *
001500101206      *  12/6/2010   szz       Clear RRN compare field before reading  *
001600101206      *                         the next record to make sure no        *
001700101206      *                         previous value leftover.               *
001800020621      *                                                                *
001900110117      *  1/17/2011   szz       Add ARP & BOM info.                     *
002000110117      *                                                                *
002100110222      *  2/22/2011   szz       Add Archive File for reprinting letters.*
002200110222      *                                                                *
002300110803      *  8/03/2011   szz       Add fields for additional Medicaid      *
002400110803      *                         states per Angie W.                    *
002500110803      *                        Replace ODOFCP with ODRGNP per Rick J.  *
002600110803      *                         since ODOFCP is no longer used.        *
002700131015      * 10/15/13 dlk  hist file expansion project
002800131121      * 11/21/13 dpb  In the event there are multiple TERM HIST rcds for
002900131121      *               a t/s/a for the exact same day (i.e...originally
003000131121      *               notes as DisEnrolled then changed to Per Request)
003100131121      *               use the reason from the last record.
003101170720      * 07/20/17 dlk  fix A4CSZ and A4RCSZ in od140arc file
003200990630      *? ***************************************************************
003300091029     FACCMST    IF   E           K Disk
003400110217     FSUBMST    IF   E           K Disk
003500100727     FHISTL9    IF   E           K Disk
003600100920     F                                     INFDS(IODBFD)
003700100921     FHISTL92   IF   E           K Disk    Rename(HISTR:DACR) Prefix(X_)
003800100920     F                                     INFDS(IODBFDX)
003900100727     FHIST      O  A E           K Disk    Rename(HISTR:HSTR) Prefix(H_)
004000100914     FACCMSP    IF   E           K Disk
004100100915     FCODES     IF   E           K Disk
004200101011     FODFACP    IF   E           K Disk
004300110803     F***ODOFCP    IF   E           K DISK
004400110803     FODRGNP    IF   E           K Disk
004500110117     FODCNTCP   IF   E           K Disk
004600101011     FMEMBER    IF   E           K Disk
004700101011     FMCOVX     IF   E           K Disk    Rename(MCOVR:XR) Prefix(X)
004800131121     FOD140OUT  uf A E           k Disk
004900101101     FOD150OUT  UF A E           K Disk
005000110222     FOD140ARC  O  A E             Disk
005100110222     FOD150ARC  O  A E             Disk
005200101122     FSDNSSCSV  O  A E             Disk
005300010326
005400100917     D IODBFD        E DS                  Extname(IODBFD)
005500100917     D  #RRN                 397    400B 0
005600100920
005700100920     D IODBFDX       E DS                  Extname(IODBFD) Prefix(X)
005800100920     D  #RRNX                397    400B 0
005900100920
0060001007280050 D  FmtTodayIn     DS
0061001007280054 D  YYin                   1      4
0062001007280052 D  MOin                   5      6  0
0063001007280053 D  DDin                   7      8
006400101122     D                 DS
0065001011220125 D  TSA                    1     10  0
0066001011220125 D  ACTRST                 1      3  0
0067001011220125 D  ACSUB#                 4      6  0
0068001011220125 D  ACACCT                 7     10  0
006900100728
0070001007280050 D  FmtToday       DS
0071001007280052 D  MO##                   1      2  0
0072001007280053 D  DD##                   3      4
0073001007280054 D  YY##                   5      8
007400100728
0075001009210055 D                 DS
0076001009210056 D  BAL                    1    108  2
007700100921     D                                     DIM(12)
0078001009210056 D  BAL1                   1      9  2
0079001009210056 D  BAL2                  10     18  2
0080001009210056 D  BAL3                  19     27  2
0081001009210056 D  BAL4                  28     36  2
0082001009210056 D  BAL5                  37     45  2
0083001009210056 D  BAL6                  46     54  2
0084001009210056 D  BAL7                  55     63  2
0085001009210056 D  BAL8                  64     72  2
0086001009210056 D  BAL9                  73     81  2
0087001009210056 D  BAL10                 82     90  2
0088001009210056 D  BAL11                 91     99  2
0089001009210056 D  BAL12                100    108  2
009000100921
009100100727     D DAC             S              3    inz('DAC')
009200100921     D TC              S              6    Inz('TC=   ')
009300100727     D NonPay          S              6    inz('TC= NP')
009400101011     D Deceased1       S              6    inz('TC= 5 ')
009500101011     D Deceased2       S              6    inz('TC=  5')
009600100727     D BOM             S              3    inz('BOM')
009700100727     D ARP             S              3    inz('ARP')
009800100727     D SAD             S              3    inz('SAD')
009900100727     D Zero4           S              4s 0 inz
010000100915     D TypeD           S              1    inz('D')
010100100921     D CodeNP          S              2    inz('NP')
010200100921     D CodeDeath       S              2    inz('5 ')
0103001310150037 D sysdateymd      S               d   datfmt(*iso)
010400131015     D thispgmname     S             10a   inz('OD140R    ')
010500061017     D                UDS
010600131015     D LUSER                  10     19
010700061017
010800100727     D ErrorMsg        C                   'Sample Error Message.'
010900060816      *
011000090904     C
011100100727     C     HstKey        Setll     HISTL9
011200100921     C     HKeyP         Reade     HISTL9
011300100727     C                   Dow       Not %Eof(HISTL9)
011400100727     C                   If        Not %Eof(HISTL9)
011500101011     C                   If        Reason <> NonPay And Reason <> Deceased1
011600101011     C                               And Reason <> Deceased2
011700100727     C     AccKey        Chain     ACCMST
011800100727     C                   If        %Found(ACCMST)
011900100727     c                   If        ASPHFL = 'F' Or
012000100727     C                             ASPHFL = 'D' or
012100100727     C                             ASPHFL = 'P'
012200100920      * Hold the Hist RRN to compare if there are other DACs for same day.
012300100921     C                   Z-add     #RRN          HoldOther         8 0
012400100917      *
012500101206     C                   Z-add     *Zeros        CompNP5
012600100921     C     HsDKey        Setll     HISTL92
012700100921     C     HsDKey        Reade     HISTL92
012800100921     C                   If        Not %Eof(HISTL92)
012900100917      *
013000100921     C*** Compare RRN between Other DAC record and NP or 5(death)history reco
013100100921     C                   Z-add     #RRNX         CompNP5           8 0
013200100917      *
013300100917     C                   End
013400100920      *
013500100921     C                   If        CompNP5   =   *Zero   Or
013600100921     C                             CompNP5   <   HoldOther
013700100805     C                   If        ATRMDT    <>  *Zero
013800100727     C                   Exsr      Process
013900100727     C                   End
014000100920     C                   End
014100100727     C                   End
014200100727     C                   End
014300100921     C                   End
014400100921     C     HKeyP         Reade     HISTL9
014500100727     C                   End
014600061010     C                   EndDo
014700060817     C                   Eval      *InLR     =   *On
014800010403
014900060817      *---------------------------------------------------------------*
015000061010     C     Process       Begsr
015100060817      *---------------------------------------------------------------*
015200100921     C                   Exsr      PrepOther
015300131121
015301170720      * write to od140out file - this workfile will be used to print the
015302170720      * letter in rpg_word
015400100921     C                   Write     OD4R                                 99
015500131121
015600131121      /free
015700131121        // if duplicate key - delete rcd from OD140 and write new record
015800131121        if *in99 = *on ;
015900131121         delete(e) (o4ltyp:o4pyfl:o4trst:o4sub#:o4acct) od140out ;
016000131121         write od4r ;
016100131121        endif ;
016200131121      /end-free
016300131121
016301170720      * write to od140arch file - archive of letters printed from here
016400110222     C                   Exsr      WriteArchive4
016500101011     C                   Movel     HKEY          O5TSA
016600101011     C     AccKey        Chain     MCOVX
016700101011     C                   If        %Found(MCOVX)
016800101011     C                   Eval      O5SSNO  =  XMCSSNO
016900101011     C                   Else
017000101011     C                   Clear                   O5SSNO
017100101122     C                   Clear                   XMCSSNO
017200101122     C                   Exsr      WriteOut
017300101011     C                   End
017400101101      *
017500101101     C     O5KEYK        Klist
017600101101     C                   Kfld                    O5LTYP
017700101101     C                   Kfld                    O5PYFL
017800101101     C                   Kfld                    HSTRST
017900101101     C                   Kfld                    HSSUB#
018000101101     C                   Kfld                    HSACCT
018100101101      *
018200101101     C                   Eval      O5LTYP  =  'F'
018300101101     C                   Eval      O5PYFL  =  ASPHFL
018400101101      *
018500131121     C                   Exsr      PrepMed
018600131121     C                   write     OD5r                                 98
018700131121
018800131121      /free
018900131121        // if duplicate key - delete rcd from OD150 and write new record
019000131121        if *in98 = *on ;
019100131121         delete(e) (o5ltyp:o5pyfl:o5trst:o5sub#:o5acct) od150out ;
019200131121         write od5r ;
019300131121        endif ;
019400131121      /end-free
019500131121
019600110222     C                   Exsr      WriteArchive5
019700101101      *
019800100831     C                   If        *In99     =   *Zero
019900100728     C                   Exsr      WriteHis
020000100831     C                   End
020100100921     C                   Clear                   OD4R
020200090909     C                   EndSr
020300070111      *
020400101011    ? *___________________________________________________________________
020500101011    ? * Prepare fields for Medicaid form (OD150OUT)
020600101011    ? *___________________________________________________________________
020700101011    ?C     PrepMed       Begsr
020800101011     C                   Eval      O5TRST  =  HSTRST
020900101011     C                   Eval      O5SUB#  =  HSSUB#
021000101011     C                   Eval      O5ACCT  =  HSACCT
021100101011     C                   Eval      O5LTYP  =  'F'
021200101011     C                   Eval      O5PYFL  =  ASPHFL
021300101105     C**********         Eval      O5STAT  =  ASTATE
021400101105      * Per Angie Whitehead State on the Medicaid form should be based on
021500101105      * the Account's Trust:
021600101105     C                   Select
021700101105     C                   When      ACTRST  =  25
021800101216     C                   Eval      O5STAT  =  'FL'
021900101105     C                   When      ACTRST  =  26
022000101216     C                   Eval      O5STAT  =  'MD'
022100101105     C                   When      ACTRST  =  27
022200101216     C                   Eval      O5STAT  =  'GA'
022300101105     C                   When      ACTRST  =  28
022400101216     C                   Eval      O5STAT  =  'NJ'
022500101105     C                   When      ACTRST  =  29
022600101216     C                   Eval      O5STAT  =  'OH'
022700110803     C                   When      ACTRST  =  30
022800110803     C                   Eval      O5STAT  =  'TX'
022900120613     C                   When      ACTRST  =  31
023000120613     C                   Eval      O5STAT  =  'IN'
023100101105     C                   Other
023200101105     C                   Eval      O5STAT  =  '**'
023300101105     C                   EndSl
023400101011     C     SubKey        Chain     ODFACP
023500110803     C     OfcKey        Chain     ODRGNP
023600110803     C                   If        %Found(ODRGNP)
023700101011     C                   Eval      O5REGN  =  MOOLOC
023800101011     C                   Else
023900101011     C                   Eval      O5REGN  =  *Blanks
024000101011     C                   End
024100101011     C                   Eval      O5RENM  =  ACNAM1
024200101011     C                   Eval      O5SSNO  =  XMCSSNO
024300101011     C     AccKey        Chain     ACCMSP
024400101011     C                   If        %Found(ACCMSP)
024500101011     C                   Movel     AMMAID        O5MEDI
024600101011     C                   End
024700101011      * Notice Date
024800101011     C     Today         Mult      10000.0001    Todayform         8 0
024900101011     C                   Move      TodayForm     FmtToday
025000101011     C                   Movel     MO##          MOa
025100101011     C                   Eval      O5NODT   =    %Trim(MOa + '/' + DD## +
025200101011     C                                           '/' + YY##)
025300101011      * Birth Date
025400101011     C     XMCSSNO       Chain     MEMBER
025500101011     C                   If        %Found(MEMBER)
025600101011     C     BIRTH         Mult      10000.0001    BirthForm         8 0
025700101011     C                   Move      BirthForm     FmtToday
025800101011     C                   Movel     MO##          MOa               2
025900101011     C                   Eval      O5DOB    =    %Trim(MOa + '/' + DD## +
026000101011     C                                           '/' + YY##)
026100101122     C                   Else
026200101122     C                   Eval      O5DOB    =    *Blanks
026300101011     C                   End
026400101011      * Effective Date of Termination
026500101011     C     ATRMDT        Mult      10000.0001    AtrmdtForm        8 0
026600101011     C                   Move      AtrmdtForm    FmtToday
026700101011     C                   Movel     MO##          MOa
026800101011     C                   Eval      O5TRDT   =    %Trim(MOa + '/' + DD## +
026900101011     C                                           '/' + YY##)
027000101011     C                   Move      wktsaa        O5TSA
027100101011     C                   EndSr
027200100914    ? *___________________________________________________________________
027300100921    ? * Prepare fields for Other Final Term Letter (OD140OUT)
027400100914    ? *___________________________________________________________________
027500100921    ?C     PrepOther     Begsr
027600110217     C     SubKey        Chain     SUBMST
027700110117     C                   Exsr      ARP_BOM
027800100921     C                   Eval      O4TRST  =  HSTRST
027900100921     C                   Eval      O4SUB#  =  HSSUB#
028000100921     C                   Eval      O4ACCT  =  HSACCT
028100110217     C                   Eval      O4SUBD  =  %Trim(SUBDSC)
028200100921     C                   Move      HSTRST        wktrsta           3
028300100921     C                   Move      HSSUB#        wksub#a           3
028400100921     C                   Move      HSACCT        wkaccta           4
028500100921     C                   Move      *Blanks       wktsaa           10
028600100921     C                   Eval      wktsaa  =  wktrsta + wksub#a + wkaccta
028700100921     C                   Move      wktsaa        O4TSA
028800100921     C                   Eval      O4LTYP  =  'F'
028900100921     C                   Eval      O4PYFL  =  ASPHFL
029000100921     C                   Eval      O4CONT  =  CONTAC
029100100921     C                   Eval      O4ACN1  =  ACNAM1
029200100921     C                   Eval      O4ACN2  =  ACNAM2
029300100921     C                   Eval      O4ADR1  =  AADDR1
029400100921     C                   Eval      O4ADR2  =  AADDR2
029500100922     C                   Movel     AZIP          ZipA              5
029600100921     c                   Eval      O4CSZ   =  %Trim(ACITY) + ', ' +
029700100921     C                                        %Trim(ASTATE)   + '  ' +
029800100921     C                                        %Trim(ZipA)
029900100921      * Get account cancellation reason
030000100921     C                   Move      REASON        CodeFromHist      2
030100100921     C     CodKey        Chain     CODES
030200100921     C                   If        %Found(CODES)
030300101015     C                   Eval      O5TERE      = LDESCR
030400101015     C                   Eval      O4TERE      = LDESCR
030500100921     C                   End
030600100921      * Format letter date
030700100921     C                   Movel     Today         FmtTodayIn
030800100921     C                   Move      MOin          MO##
030900100921     C                   Move      DDin          DD##
031000100921     C                   Move      YYin          YY##
031100100921     C                   Select
031200100921     C                   When      MO##       =  01
031300100921     C                   Eval      O4DATE     = 'January ' + DD## + ', ' + YY##
031400100921     C                   When      MO##       =  02
031500100921     C                   Eval      O4DATE     = 'February ' + DD## + ', ' + YY##
031600100921     C                   When      MO##       =  03
031700100921     C                   Eval      O4DATE     = 'March ' + DD## + ', ' + YY##
031800100921     C                   When      MO##       =  04
031900100921     C                   Eval      O4DATE     = 'April ' + DD## + ', ' + YY##
032000100921     C                   When      MO##       =  05
032100100921     C                   Eval      O4DATE     = 'May '   + DD## + ', ' + YY##
032200100921     C                   When      MO##       =  06
032300100921     C                   Eval      O4DATE     = 'June '  + DD## + ', ' + YY##
032400100921     C                   When      MO##       =  07
032500100921     C                   Eval      O4DATE     = 'July '  + DD## + ', ' + YY##
032600100921     C                   When      MO##       =  08
032700100921     C                   Eval      O4DATE     = 'August ' + DD## + ', ' + YY##
032800100921     C                   When      MO##       =  09
032900100921     C                   Eval      O4DATE     = 'September ' + DD## + ', ' +
033000100921     C                                                         YY##
033100100921     C                   When      MO##       =  10
033200100921     C                   Eval      O4DATE     = 'October ' + DD## + ', ' + YY##
033300100921     C                   When      MO##       =  11
033400100921     C                   Eval      O4DATE     = 'November ' + DD## + ', ' + YY##
033500100921     C                   When      MO##       =  12
033600100921     C                   Eval      O4DATE     = 'December ' + DD## + ', ' + YY##
033700100921     C                   Endsl
033800100914      * Effective Date of Termination
033900100921     C                   Movel     ATRMDT        FmtTodayIn
034000100921     C                   Move      MOin          MO##
034100100921     C                   Move      DDin          DD##
034200100921     C                   Move      YYin          YY##
034300100921     C                   Select
034400100921     C                   When      MO##       =  01
034500100922     C                   Eval      O4TRDT     = 'January ' + DD## + ', ' + YY##
034600100921     C                   When      MO##       =  02
034700100922     C                   Eval      O4TRDT     = 'February ' + DD## + ', ' + YY##
034800100921     C                   When      MO##       =  03
034900100922     C                   Eval      O4TRDT     = 'March ' + DD## + ', ' + YY##
035000100921     C                   When      MO##       =  04
035100100922     C                   Eval      O4TRDT     = 'April ' + DD## + ', ' + YY##
035200100921     C                   When      MO##       =  05
035300100922     C                   Eval      O4TRDT     = 'May '   + DD## + ', ' + YY##
035400100921     C                   When      MO##       =  06
035500100922     C                   Eval      O4TRDT     = 'June '  + DD## + ', ' + YY##
035600100921     C                   When      MO##       =  07
035700100922     C                   Eval      O4TRDT     = 'July '  + DD## + ', ' + YY##
035800100921     C                   When      MO##       =  08
035900100922     C                   Eval      O4TRDT     = 'August ' + DD## + ', ' + YY##
036000100921     C                   When      MO##       =  09
036100100922     C                   Eval      O4TRDT     = 'September ' + DD## + ', ' +
036200100921     C                                                         YY##
036300100921     C                   When      MO##       =  10
036400100922     C                   Eval      O4TRDT     = 'October ' + DD## + ', ' + YY##
036500100921     C                   When      MO##       =  11
036600100922     C                   Eval      O4TRDT     = 'November ' + DD## + ', ' + YY##
036700100921     C                   When      MO##       =  12
036800100922     C                   Eval      O4TRDT     = 'December ' + DD## + ', ' + YY##
036900100921     C                   Endsl
037000100921      *
0371001009211074 C                   XFOOT     BAL           O4TOT
037200100914     C                   EndSr
037300110117    ? *___________________________________________________________________
037400110117    ? * Write the ARP & BOM information
037500110117    ? *___________________________________________________________________
037600110117    ?C     ARP_BOM       Begsr
037700110117      * BOM (Business Office Manager)
037800110117     C                   Clear                   O4BOM
037900110117     c     OdKey         Setll     ODCNTCP
038000110117     c                   Dou       %eof(ODCNTCP)
038100110117     c     OdKey         Reade     ODCNTCP
038200110117     c                   If        Not %Eof(ODCNTCP) and Today  >= OCEFF And
038300110117     c                             (OCTRM = 0 or OCTRM > Today)
038400110117     C                   Eval      O4BOM   =  %Trim(OCFNAM) + ' ' +
038500110117     C                                        %Trim(OCLNAM)
038600110117     c                   Eval      O4BOA1  =  %Trim(OCADD1)
038700110117     c                   Eval      O4BOA2  =  %Trim(OCADD2)
038800110117     c                   Eval      O4BOCZ  =  %Trim(OCCITY) + ', ' +
038900110117     C                                        %Trim(OCST)   + '  ' +
039000110117     C                                        %TRim(OCZIP)
039100110117     c                   Leave
039200110117     c                   End
039300110117     c                   EndDo
039400110117
039500110117      *
039600110117      * Get Responsible Party aka Family Representative aka Authorized Rep
039700110117      *
039800110117     C     OdarpKey      Setll     ODCNTCP
039900110117     c                   Dou       %Eof(ODCNTCP)
040000110117     C     OdarpKey      Reade     ODCNTCP
040100110117     C                   If        Not %Eof(ODCNTCP)   And
040200110117     c                                 COVTDT >= OCEFF And
040300110117     c                             (OCTRM = 0 Or OCTRM > COVTDT)
040400110117     c                   Eval      O4RPNM  =  %Trim(OCFNAM) + ' ' +
040500110117     C                                        %Trim(OCLNAM)
040600110117     c                   Eval      O4RPA1  =  %Trim(OCADD1)
040700110117     c                   Eval      O4RPA2  =  %Trim(OCADD2)
040800110117     c                   Eval      O4RCSZ  =  %Trim(OCCITY) + ', ' +
040900110117     C                                        %Trim(OCST)   + '  ' +
041000110117     C                                        %TRim(OCZIP)
041100110117     C                   Leave
041200110117     C                   Else
041300110117     C                   Eval      O4RPNM = 'Attn: Responsible Party'
041400110117     C                   End
041500110117     C                   EndDo
041600110117     C                   EndSr
041700090904    ? *___________________________________________________________________
041800100727    ? * Write a Final Termination Letter History Record
041900090904    ? *___________________________________________________________________
042000090904    ?C     WriteHis      Begsr
042100100727     C                   Movel     HKEY          H_HKEY
042200100728     C                   Eval      H_TRCODE  =   'U70'
042300100727     C                   Eval      H_TRDATE  =   Today
042400100727     C                   Eval      H_HSTRST  =   HSTRST
042500100728     C                   Eval      H_HSSUB#  =   HSSUB#
042600100727     C                   Eval      H_HSACCT  =   HSACCT
042700131015     c                   eval      h_hprgnm = thispgmname
042800100727     C                   Eval      H_HSDLTD  =   'A'
042900100728     C                   Eval      H_HOPER   =   %Trim('ROBOT')
043000100727     C                   Eval      H_COVTDT  =   COVTDT
043100131015     C                   eval      sysdateymd = %date
043200131015     C                   MOVE      sysdateymd    h_trdate
043300131015     c                   eval      h_hstrtime = %time
043400110223     C**************     If        *InU1     =   *On
043500100727     C                   Write     HSTR
043600100728     C                   Clear                   HSTR
043700110223     C****************   End
043800090904    ?C                   Endsr
043900101122      *---------------------------------------------------------------*
044000101122     C     WriteOut      Begsr
044100101122      *---------------------------------------------------------------*
044200101122     C                   Clear                   SDNSSCSR
044300101122
044400101122     C                   Eval      WKRECORD=%Trim(%Editw(TSA:'0   -   -    '))+
044500101122     C                                                            ',"' +
044600101122     C                             %Trim(ACNAM1)                + '",' +
044700101122     C                             %Trim(LDESCR)
044800101122     C                   Write     SDNSSCSR
044900101122     C                   Clear                   SDNSSCSR
045000101122     C                   EndSr
045100110222      * ? _____________________________________________________________
045200110222      *? *                                                             *
045300110222      *? * Write all data fields to the Final Term OTHER letter archive*
045400110222      *? *_____________________________________________________________*
045500110222     C     WriteArchive4 BEGSR
045600110222      *
045700110222     C                   Eval      A4TRST    =   O4TRST
045800110222     C                   Eval      A4SUB#    =   O4SUB#
045900110222     C                   Eval      A4ACCT    =   O4ACCT
046000110222     C                   Eval      A4LTYP    =   O4LTYP
046100110222     C                   Eval      A4PYFL    =   O4PYFL
046200110222     C                   Eval      A4CONT    =   O4CONT
046300110222     C                   Eval      A4ACN1    =   O4ACN1
046400110222     C                   Eval      A4ACN2    =   O4ACN2
046500110222     C                   Eval      A4ADR1    =   O4ADR1
046600110222     C                   Eval      A4ADR2    =   O4ADR2
046700110222     C                   Eval      A4CSZ     =   O4CSZ
046800110421     C                   Eval      A4BOM     =   O4BOM
046900110421     C                   Eval      A4BOA1    =   O4BOA1
047000110421     C                   Eval      A4BOA2    =   O4BOA2
047100110421     C                   Eval      A4BOCZ    =   O4BOCZ
047200110418     C                   Eval      A4RPNM    =   O4RPNM
047300110421     C                   Eval      A4RPA1    =   O4RPA1
047400110421     C                   Eval      A4RPA2    =   O4RPA2
047401170720      * fixed 7/20/17
047500170720     C******             Eval      A4CSZ     =   O4RCSZ
047501170720     C                   Eval      A4RCSZ    =   O4RCSZ
047502170720
047600110222     C                   Eval      A4TERE    =   O4TERE
047700110222     C                   Eval      A4TRDT    =   O4TRDT
047800110222     C                   Eval      A4DATE    =   O4DATE
047900110222     C                   Eval      A4TOT     =   O4TOT
048000110222     C                   Eval      A4TSA     =   O4TSA
048100110222     C                   Eval      A4DESC    =   %Trim('Final Term +
048200110222     C                                                   OTHER Letter')
048300110222     C     *Date         Mult      10000.0001    A4LDT
048400110222     C                   Write     OD4RA
048500110222     C                   Clear                   OD4RA
048600110222      *
048700110222     C                   EndSr
048800110222      * ? _____________________________________________________________
048900110222      *? *                                                             *
049000110222      *? * Write all data fields to the Medicaid Form archive          *
049100110222      *? *_____________________________________________________________*
049200110222     C     WriteArchive5 BEGSR
049300110222      *
049400110222     C                   Eval      A5TRST    =   O5TRST
049500110222     C                   Eval      A5SUB#    =   O5SUB#
049600110222     C                   Eval      A5ACCT    =   O5ACCT
049700110222     C                   Eval      A5LTYP    =   O5LTYP
049800110222     C                   Eval      A5PYFL    =   O5PYFL
049900110222     C                   Eval      A5STAT    =   O5STAT
050000110222     C                   Eval      A5REGN    =   O5REGN
050100110222     C                   Eval      A5RENM    =   O5RENM
050200110222     C                   Eval      A5SSNO    =   O5SSNO
050300110222     C                   Eval      A5MEDI    =   O5MEDI
050400110222     C                   Eval      A5DOB     =   O5DOB
050500110222     C                   Eval      A5TERE    =   O5TERE
050600110222     C                   Eval      A5TRDT    =   O5TRDT
050700110222     C                   Eval      A5NODT    =   O5NODT
050800110222     C                   Eval      A5TSA     =   O5TSA
050900110222     C                   Eval      A5DESC    =   %Trim('Medicaid Form')
051000110222     C     *Date         Mult      10000.0001    A5LDT
051100110222     C                   Write     OD5RA
051200110222     C                   Clear                   OD5RA
051300110222      *
051400110222     C                   EndSr
051500110222
051600101122      * ? _____________________________________________________________
051700101122      *? *                                                             *
051800101122      *? *        Write Excel Spreadsheet Title to CSV File            *
051900101122      *? *_____________________________________________________________*
052000101122     C     WriteSpTitle  BEGSR
052100101122     C*
052200101122     C                   Eval      WKRECORD        =    'Account#' + ',' +
052300101122     C                                          'Term Reason'
052400101122     C                   Write     SDNSSCSR
052500101122     C                   Clear                   SDNSSCSR
052600101122     C*
0527001011220320 C                   ENDSR
052800101122
052900090903    ? *___________________________________________________________________
053000090903    ? * Klists
053100090903    ? *___________________________________________________________________
053200090904    ?C     KList         Begsr
053300090909    ? *
053400090909     C     HstKey        Klist
053500100728     C                   Kfld                    Today
053600100727     C                   Kfld                    DAC
053700100921     C                   Kfld                    TC
053800100921    ? *
053900100921     C     HKeyP         Klist
054000100921     C                   Kfld                    Today
054100100921     C                   Kfld                    DAC
054200100917    ? *
054300100917     C     HsDKey        Klist
054400100917     C                   Kfld                    HKEY
054500100917     C                   Kfld                    Today
054600100727    ? *
054700100727     C     AccKey        Klist
054800100727     C                   Kfld                    HSTRST
054900100727     C                   Kfld                    HSSUB#
055000100727     C                   Kfld                    HSACCT
055100100915     C*
055200100915     C     CodKey        Klist
055300100915     C                   Kfld                    TypeD             1
055400100921     C                   Kfld                    CodefromHist      2
055500100727     C*
055600101011     C     OfcKey        klist
055700101011     C                   kfld                    S2TRST
055800101011     C                   kfld                    S2OFC#
055900101011      *
056000101011     C     SubKey        Klist
056100101011     C                   Kfld                    HSTRST
056200101011     C                   Kfld                    HSSUB#
056300110117     C*
056400110117     C     OdarpKey      Klist
056500110117     C                   Kfld                    HSTRST
056600110117     C                   Kfld                    HSSUB#
056700110117     C                   Kfld                    HSACCT
056800110117     C                   Kfld                    ARP
056900110117     C*
057000110117     C     OdKey         Klist
057100110117     C                   Kfld                    HSTRST
057200110117     C                   Kfld                    HSSUB#
057300110117     C                   Kfld                    Zero4
057400110117     C                   Kfld                    BOM
057500101011      *
057600090903    ?C                   Endsr
057700090903    ? *___________________________________________________________________
057800090903     C     *Inzsr        BEGSR
057900090903    ? *___________________________________________________________________
058000130515     C     *Date         Mult      10000.0001    Today             8 0
058100140512     C*********          z-add     20140509      Today             8 0
058200101122     C                   Exsr      WriteSpTitle
058300100727     C                   EndSr
058400010412
058500010403     C/EJECT
