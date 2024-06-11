000100991124     F*-------------------------------------------------------------------------
000200130723     F* FI035R     GBS SOFTWARE 2013
000300081111     F*            WRITTEN BY - RLJ
000400130723     F*            DATE - 07/2013
000500130723     F*  DESCRIPTION - Plan Auxiliary File Display Pgm
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800991124     F*
000900991124     F*-------------------------------------------------------------------------
001000991209     ** MODIFICATION HISTORY                                              **
001100130423     ** xxx mm/dd/yyyy -                                                  **
001200991209     **                                                                   **
001300991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001400130723     FPLNAUXP   IF   E           K DISK
001500130423     FPLNMST    IF   E           K DISK
001600130423     FTRSMST    IF   E           K DISK
001700130423     FSUBMST    IF   E           K DISK
001800130423     FACCMST    IF   E           K DISK
001900140307     FCARMST    IF   E           K DISK
002000140307     FCARMST2P  IF   E           K DISK
002100130723     FPLNAXHSTP IF   E           K DISK
002200130723     FFI035D    CF   E             WORKSTN
002300130607     F                                     SFILE(DETAIL:RRN)
002400130425   X* *
002500130424     D                UDS
002600130424     D  @USER                100    107
002700130424     D  CONAME               201    240
0028001304240056 D  lprefix              241    241
002900130424      *
003000130606    *** TIMESTAMP FIELDS DATA STRUCTURE
003100130606      *
003200130606     D @TIMESTAMP      DS
003300130606     D  #TSCYMD                1      8S 0
003400130606     D  #TSTIME                9     14S 0
003500130606     D  @TSJOB                15     24
003600130606     D  @TSUSER               25     34
003700130606     D  #TSNBR                35     40S 0
003800130606    ***
003900130424    * *
004000010918     D @K5             S              4A
004100130606     D @TS40           S             40A
004200130424    * *
004300001207     D                 DS
004400001207     D @KEYPRM                 1     10A
004500001207     D #KT                     1      3S 0
004600001207     D #KS                     4      6S 0
004700081111     D #KP                     7     10A
004800130424    * *
004900130424     D                 DS
005000130510     D addflg          S              1A   INZ('N')
005100130510     D chgflg          S              1A   INZ('N')
005200130723     D adwtdy          S              5A
005300130925     D adrhdy          S              4A
005400130424     D wkdat           S               D
005500130510     D usadt           S               D   DATFMT(*USA/)
005600130710     D svborefd        S                   LIKE(pxborefd)
005700130510     D svborlrd        S                   LIKE(pxborlrd)
005800130606     D svwtpd          S                   LIKE(pxwtpd)
005900130606     D svrhpd          S                   LIKE(pxrhpd)
006000130606     D svtrmc          S                   LIKE(pxtrmc)
006100130606     D svdpcd          S                   LIKE(pxdpcd)
006200130606     D svmpcd          S                   LIKE(pxmpcd)
006300081111      *
006400130624     D                 DS
006500130624     D  datmdy                 1      8  0
006600130624     D   mdymmdd               1      4  0
006700130624     D   mdyyyyy               5      8  0
006800130426      *
006900130426     D                 DS
007000130426     D  datymd                 1      8  0
007100130426     D   ymdyyyy               1      4  0
007200130426     D   ymdmmdd               5      8  0
007300130426      *
007400130426     D                 DS
007500130426     D  wtpd3                  1      3
007600130426     D   aawtpd1               1      1
007700130426     D   aawtpd2               2      2
007800130426     D   aawtpd3               3      3
007900130509      *
008000130509     D                 DS
008100130509     D cwtpd3                  1      3
008200130509     D   acwtpd1               1      1
008300130509     D   acwtpd2               2      2
008400130509     D   acwtpd3               3      3
008500081111      *
008600130426     D                 DS
008700130613     D  rhpd4                  1      4
008800130426     D   aarhpd1               1      1
008900130426     D   aarhpd2               2      2
009000130426     D   aarhpd3               3      3
009100130613     D   aarhpd4               4      4
009200130426      *
009300130509     D                 DS
009400130613     D crhpd4                  1      4
009500130509     D   acrhpd1               1      1
009600130509     D   acrhpd2               2      2
009700130509     D   acrhpd3               3      3
009800130613     D   acrhpd4               4      4
009900130509      *
010000130426     D                 DS
010100130426     D  trmc4                  1      4
010200130426     D   aatrmc1               1      1
010300130426     D   aatrmc2               2      2
010400130426     D   aatrmc3               3      3
010500130426     D   aatrmc4               4      4
010600130509     D                 DS
010700130509     D  trcc4                  1      4
010800130509     D   actrmc1               1      1
010900130509     D   actrmc2               2      2
011000130509     D   actrmc3               3      3
011100130509     D   actrmc4               4      4
011200130426      *
011300130426     D                 DS
011400130426     D  dpcd3                  1      3
011500130426     D   aadpcd1               1      1
011600130426     D   aadpcd2               2      2
011700130426     D   aadpcd3               3      3
011800130509     D                 DS
011900130509     D cdpcd3                  1      3
012000130509     D   acdpcd1               1      1
012100130509     D   acdpcd2               2      2
012200130509     D   acdpcd3               3      3
012300130426     D                 DS
012400130426     D  mpcd3                  1      3
012500130426     D   aampcd1               1      1
012600130426     D   aampcd2               2      2
012700130426     D   aampcd3               3      3
012800130426      *
012900130509     D                 DS
013000130509     D cmpcd3                  1      3
013100130509     D   acmpcd1               1      1
013200130509     D   acmpcd2               2      2
013300130509     D   acmpcd3               3      3
013400130509      *
013500131111     D                 DS
013600131111     D pxcfsen                 1      5
013700131111     D   pxcfse1               1      1
013800131111      *
013900130426      *
014000081111     D                 DS
014100081111     D  plnx           S              1
014200081111     D  plnnmb         S              1  0
014300081111     D  plbeg          S              4
014400081111      *
0145001304230053 D                 DS
0146001307230054 D  noauxm         C                   'No Plan Auxilliary record for Plan'
0147001307230054 D  invpln         C                   'INVALID TRUST/SUB#/PLAN     '
0148001304230054 D  invacc         C                   'INVALID TRUST/SUB#/ACCOUNT  '
0149001306110054 D  wdhcon         C                   'Date of Hire plus '
0150001306100054 D  wfmcon         C                   'First of month follow DOH +'
0151001304240054 D  wffcon         C                   'First day following'
0152001304240054 D  rhdcon         C                   'Date of Rehire plus'
0153001306100054 D  rfmcon         C                   'First of month follow DOR +'
0154001304240054 D  rffcon         C                   'First day following'
0155001306130054 D  rnacon         C                   'N/A                              '
0156001304230054 D  tadcon         C                   'Actual date of termination'
0157001304230054 D  temcon         C                   'EOM following termination'
0158001306100054 D  tfmcon         C                   '1st of month after termination'
0159001304230054 D  tdacon         C                   'Day after termination'
0160001304230054 D  dbdcon         C                   'Dependents DOB'
0161001304230054 D  demcon         C                   'End of Month'
0162001304230054 D  deycon         C                   'End of Calendar Year'
0163001610140054 D  depcon         C                   'End of Plan Year'
0164001304240054 D  mbbcon         C                   'Benefit Based Plan'
0165001304240054 D  msbcon         C                   'Salary Based Plan'
0166001306130054 D  mbmcon         C                   'Benefit Conv Prem Vol for Web'
0167001306240054 D  wtpderr        C                   'Waiting Period entry required'
0168001307120054 D  wtdyerr        C                   'Waiting Per + Days cannot be 0'
0169001307160054 D  wtdnerr        C                   'See Diary Notes must be Y or N'
0170001306240054 D  rhpderr        C                   'Rehire Waiting Period entry require'
0171001304260054 D  rhwderr        C                   'Rehire Within must be less than 151'
0172001306240054 D  trmcerr        C                   'Term Date Definition entry required'
0173001304260054 D  econerr        C                   'Employer Cont must be less than 101'
0174001304260054 D  ptynerr        C                   'Part_Time Eligible must be Y or N'
0175001304260054 D  pthlerr        C                   'Must enter Part Time Hours'
0176001304260054 D  dpmxerr        C                   'Dependent Max Age must be below 27'
0177001306240054 D  dpcderr        C                   'Dep Coverage Ends On entry required'
0178001304260054 D  dpsverr        C                   'Student Verification must be Y or N'
0179001307100054 D  brdterr        C                   'BOR Effective Date is invalid'
0180001304260054 D  brlrerr        C                   'BOR Last Renew Date is invalid'
0181001305090054 D  brsserr        C                   'If 1 BOR date is 0, both must 0'
0182001307160054 D  brleerr        C                   'BOR Eff Date s/b prior to Last Rene'
0183001306240054 D  mpcderr        C                   'Mult to Conv PBV entry required    '
0184001304260054 D  ussperr        C                   'Use Spouse DOB must be Y or N'
0185001304260054 D  shwwerr        C                   'Show on Web must be Y or N'
0186001305100054 D  addmsg         C                   'Plan Auxiliary record added'
0187001305100054 D  chgmsg         C                   'Plan Auxiliary record changed'
0188001306240054 D  xmsg           C                   '     X - Indicates Selection       '
018900130426    * *
019000130426     C     keytsa        KLIST
019100130426     C                   KFLD                    #KT
019200130426     C                   KFLD                    #KS
019300130426     C                   KFLD                    pxacct
019400130426    * *
019500130426     C     keytsp        KLIST
019600130426     C                   KFLD                    #KT
019700130426     C                   KFLD                    #KS
019800130426     C                   KFLD                    #KP               4
019900130426    * *
020000130426     C     keyts         KLIST
020100130426     C                   KFLD                    #KT
020200130426     C                   KFLD                    #KS
020300130426    * *
020400130423   X* *X
020500130423      * MAINLINE
020600130423    * *
020700991124     C                   EXSR      ONCE
020800130423      *
020900991216     C                   DOU       @EXIT = '1'
021000130423      *
021100130426     C                   IF        *IN01 = '1' or *IN07 = '1'
021200000217     C                   MOVE      '1'           @EXIT
021300000217     C                   MOVE      '*LR'         @PARM
021400130501     C                   iter
021500130501     C                   endif
021600130723      *
021700130501     C                   exsr      dspaux
021800130607      *
021900130607     C                   if        *IN09 = '1'
022000130607     C                   exsr      hstaux
022100130607     C                   eval      *IN01 = '0'
022200130607     C                   endif
022300130423      *
022400081119     C                   ENDDO
022500130423      *
022600081119     C                   MOVE      *ON           *INLR
022700081119     C                   RETURN
022800991124   S***S
022900991124     C* ONETIME ROUTINE
023000081119    ***
023100081119     C     ONCE          BEGSR
023200130423    * *
023300081119     C     *ENTRY        PLIST
023400081119     C                   PARM                    @PARM            10
023500081119     C                   MOVEL(P)  @PARM         @KEYPRM
023600130423    * *
023700130424     C                   MOVEL     CONAME        TITLE
023800081126     C                   MOVE      '0'           @EXIT             1
023900130423    * *
024000010918     C                   ENDSR
024100130423      ******************************************************************
024200130423      *       SUBROUTINE - DSPAUX                                      *
024300130423      *                    Display Plan Auxiliary Data                 *
024400130423      ******************************************************************
024500130423     C     dspaux        BEGSR
024600130423      *
024700130423     C                   clear                   auxdsp
024800130424     C                   MOVEL     CONAME        TITLE
024900130423      *
025000130423     C                   eval      adtrst = #KT
025100130423     C     #KT           chain     trsmst                             21
025200130423     C                   if        *in21 = '1'
025300130423     C                   eval      adtname = 'INVALID TRUST#      '
025400130423     C                   exfmt     auxdsp
025500130423     C                   leavesr
025600130423     C                   else
025700130423     C                   eval      adtname = tname
025800130423     C                   endif
025900130423      *
026000130423     C                   eval      adsub# = #KS
026100130423     C     keyts         chain     submst                             22
026200130423     C                   if        *in22 = '1'
026300130423     C                   eval      adsname = 'INVALID TRUST/SUB#  '
026400130423     C                   exfmt     auxdsp
026500130423     C                   leavesr
026600130423     C                   else
026700130423     C                   eval      adsname = subnam
026800130423     C                   endif
026900130423      *
027000130423     C                   eval      adplan = #KP
027100130423     C     keytsp        chain     plnmst                             23
027200130423     C                   if        *in23 = '1'
027300130423     C                   movel(P)  invpln        adpdesc
027400130423     C                   exfmt     auxdsp
027500130423     C                   leavesr
027600130423     C                   else
027700130423     C                   eval      adpdesc = pdescr
027800130423     C                   endif
027900140307      *      See if Coventry and ACA => Mst Grp# enabled
028000140307     C                   eval      *in87 = '0'
028100140307     C     pcarr         chain     carmst                             24
028200140307     C                   if        *in24 = '0' and cgrpcd = 'CH'
028300140307      *
028400140307     C     pcarr         chain     carmst2p                           96
028500140307     C                   if        *in96 = '0' and c2acart = 'Y'
028600140307     C                   eval      *in87 = '1'
028700140307     C                   endif
028800140307     C                   endif
028900130723      *
029000130723     C     keytsp        chain     plnauxp                            24
029100130723     C                   if        *in24 = '1'
029200130723     C                   eval      admsg = noauxm
029300130723     C                   eval      *IN81 = '1'
029400130723     C                   else
029500131113      *
029600131113     C                   movel     pxacct        adacct
029700131113     C                   if        pxacct <> 0
029800131113     C     keytsa        chain     accmst                             25
029900131113     C                   if        *in25 = '1'
030000131113     C                   movel(P)  invacc        adacnam
030100131113     C                   else
030200131113     C                   eval      adacnam = acnam1
030300131113     C                   endif
030400131113     C                   endif
030500130423      *
030600130723     C                   eval      adwtdy = %EDITC(pxwtdy:'A')
030700130423     C                   eval      adwtpd = pxwtpd
030800130423     C                   select
030900130423     C                   when      adwtpd =  'WDH'
031000130424     C                   eval      adwtdsc = wdhcon + adwtdy + ' Days'
031100130423     C                   when      adwtpd =  'WFM'
031200130424     C                   eval      adwtdsc = wfmcon + adwtdy + ' Days'
031300130423     C                   when      adwtpd =  'WFF'
031400130424     C                   eval      adwtdsc = wffcon + adwtdy + ' Days'
031500130423     C                   endsl
031600130423      *
031700130716     C                   eval      adwtdn = pxwtdn
031800130716      *
031900130716     C                   eval      adrhwd = pxrhwd
032000130423      *
032100130424     C                   eval      adrhdy = %EDITC(pxrhdy:'1')
032200130423     C                   eval      adrhpd = pxrhpd
032300130423     C                   select
032400130423     C                   when      adrhpd =  'RDH'
032500130424     C                   eval      adrhdsc = rhdcon + adrhdy + ' Days'
032600130423     C                   when      adrhpd =  'RFM'
032700130424     C                   eval      adrhdsc = rfmcon + adrhdy + ' Days'
032800130423     C                   when      adrhpd =  'RFF'
032900130424     C                   eval      adrhdsc = rffcon + adrhdy + ' Days'
033000130613     C                   when      adrhpd =  'RNA'
033100130613     C                   eval      adrhdsc = rnacon
033200130423     C                   endsl
033300130423      *
033400130423     C                   eval      adtrmc = pxtrmc
033500130423     C                   select
033600130423     C                   when      adtrmc =  'TAD'
033700130423     C                   movel(P)  tadcon        adtmdsc
033800130423     C                   when      adtrmc =  'TEM'
033900130423     C                   movel(P)  temcon        adtmdsc
034000130423     C                   when      adtrmc =  'TFM'
034100130423     C                   movel(P)  tfmcon        adtmdsc
034200130423     C                   when      adtrmc =  'TDA'
034300130423     C                   movel(P)  tdacon        adtmdsc
034400130423     C                   endsl
034500170125      *
034600170125     C                   eval      *in37 = '0'
034700170125     C                   if        pabfl <> 'N'
034800170125     C                   if        plncat = 'PSA' or plncat = 'PSP' or
034900170125     C                             plncat = 'PS1'
035000170125     C                   eval      *in37 = '1'
035100170125     C                   eval      adeors = pxeors
035200170125     C                   endif
035300170125     C                   endif
035400130423      *
035500130423     C                   eval      adecon = pxecon
035600131122     C                   eval      adexchg = pxexchg
035700131206     C                   eval      adacar = pxacar
035800131111     C                   eval      adgroup = pxgroup
035900130423     C                   eval      adptyn = pxptyn
036000130611      *
036100130611     C                   eval      *in64 = '0'
036200130611     C                   if        adptyn = 'Y'
036300130611     C                   eval      *in64 = '1'
036400130611     C                   eval      adptlo = pxptlo
036500130423     C                   eval      adpthi = pxpthi
036600130611     C                   endif
036700130423      *
036800130423     C                   eval      addpmx = pxdpmx
036900130423      *
037000130423     C                   eval      addpcd = pxdpcd
037100130423     C                   select
037200130423     C                   when      addpcd =  'DBD'
037300130423     C                   movel(P)  dbdcon        addpdsc
037400130423     C                   when      addpcd =  'DEM'
037500130423     C                   movel(P)  demcon        addpdsc
037600130423     C                   when      addpcd =  'DEY'
037700130423     C                   movel(P)  deycon        addpdsc
037800161014     C                   when      addpcd =  'DEP'
037900161014     C                   movel(P)  depcon        addpdsc
038000161014     C                   endsl
038100130423      *
038200130423     C                   eval      addpsv = pxdpsv
038300170125      *
038400170125     C                   eval      adstmx = pxstmx
038500130424      *
038600131111     C                   eval      adcfse1 = pxcfse1
038700131111      *
038800130710     C                   if        pxborefd = 0
038900130509     C                   eval      adbrdt = *blanks
039000130509     C                   else
039100130710     C                   movel     pxborefd      wkdat
039200130424     C                   eval      usadt = wkdat
039300130424     C                   movel     usadt         adbrdt
039400130509     C                   endif
039500130424      *
039600130509     C                   if        pxborlrd = 0
039700130509     C                   eval      adbrlr = *blanks
039800130509     C                   else
039900130424     C                   movel     pxborlrd      wkdat
040000130424     C                   eval      usadt = wkdat
040100130424     C                   movel     usadt         adbrlr
040200130509     C                   endif
040300130424      *
040400130424     C                   eval      admpcd = pxmpcd
040500130424     C                   select
040600130424     C                   when      admpcd =  'MBB'
040700130424     C                   movel(P)  mbbcon        admpdsc
040800130424     C                   when      admpcd =  'MSB'
040900130424     C                   movel(P)  msbcon        admpdsc
041000130424     C                   when      admpcd =  'MBM'
041100130424     C                   movel(P)  mbmcon        admpdsc
041200130424     C                   endsl
041300130424      *
041400130423     C                   eval      adussp = pxussp
041500130423     C                   eval      adshww = pxshww
041600140307     C   87              eval      admgrp# = pxmgrp#
041700131111      *
041800131111     C                   eval      adcarpln = pxcarpln
041900130510      *
042000130510     C                   if        addflg = 'Y'
042100130510     C                   eval      admsg = addmsg
042200130510     C                   eval      addflg = 'N'
042300130510     C                   eval      *IN81 = '1'
042400130510     C                   endif
042500130510      *
042600130510     C                   if        chgflg = 'Y'
042700130510     C                   eval      admsg = chgmsg
042800130510     C                   eval      *IN81 = '1'
042900130510     C                   eval      chgflg = 'N'
043000130510     C                   endif
043100130510      *
043200130723     C                   endif
043300130723      *
043400130423     C                   exfmt     auxdsp
043500130510     C                   eval      *IN81 = '0'
043600130423      *
043700130423     C                   endsr
043800130607      ******************************************************************
043900130607      *       SUBROUTINE - HSTAUX                                      *
044000130607      *                    Display Plan Auxiliary History              *
044100130607      ******************************************************************
044200130607     C     hstaux        BEGSR
044300130607      *
044400130607     C     *IN01         DOWEQ     *OFF
044500130607     C     *IN07         ANDEQ     *OFF
044600130607      *      RELOAD IF CLIENT SEARCH CHANGES
044700130607     C                   EXSR      $CLEAR
044800130607     C                   EXSR      $LOAD
044900130607     C                   EXSR      $DISPLAY
045000130607     C                   setoff                                       88
045100130607      *    PROCESS SELECTION
045200130607     C***  *IN01         IFEQ      *OFF
045300130607     C***  *IN07         ANDEQ     *OFF
045400130607     C***  RRN           ANDNE     *ZERO
045500130607     C********           EXSR      $PROCES
045600130607     C*****              ENDIF
045700130607      *
045800130607     C                   enddo
045900130607      *
046000130607     C                   endsr
046100130607      ******************************************************************
046200130607      *       SUBROUTINE - $CLEAR                                      *
046300130607      *                    CLEAR SUBF AND RRN                          *
046400130607      ******************************************************************
046500130607     C     $CLEAR        BEGSR
046600130607     C                   MOVEA     '001'         *IN(31)
046700130607     C                   wRITE     HEADER
046800130607     C                   Z-ADD     *ZERO         RRN               4 0
046900130607     C                   WRITE     HEADER
047000130607     C                   MOVEA     '010'         *IN(31)
047100130607     C                   ENDSR
047200130607      ******************************************************************
047300130607      *       SUBROUTINE - $LOAD                                       *
047400130607      *                    LOAD SUBFILE W/ Change Info                 *
047500130607      ******************************************************************
047600130607     C     $LOAD         BEGSR
047700130607     C                   SETOFF                                       3495
047800130607     C     keytsp        setll     plnaxhstp                          34
047900130607     C     *IN34         DOUEQ     *ON
048000130607     C     *IN95         OREQ      *ON
048100130607     C     keytsp        reade     plnaxhstp                              34
048200130607     C                   IF        (*In34 <> *ON) and
048300130607     C                             axplan = #KP
048400130607      *
048500130607     C                   ADD       1             RRN
048600130607     C                   movel     axdate        wkdat
048700130607     C                   eval      usadt = wkdat
048800130607     C                   movel     usadt         ahdate
048900130607      *
049000130607     C                   movel     axuser        ahuser
049100130607     C                   if        axtype = 'A'
049200130607     C                   movel(P)  addmsg        ahmsg
049300130607     C                   else
049400130607     C                   eval      ahmsg = *blanks
049500130607     C                   eval      ahmsg = %trim(axfld) + ' changed from ' +
049600130607     C                             %trim(axfrom) + ' to ' + %trim(axto)
049700130607     C                   endif
049800130607      *
049900130607     C                   WRITE     DETAIL
050000130607     C                   ENDIF
050100130607     C                   ENDDO
050200130607     C                   ENDSR
050300130607      ******************************************************************
050400130607      *       SUBROUTINE - $DISPLAY                                    *
050500130607      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
050600130607      ******************************************************************
050700130607     C     $DISPLAY      BEGSR
050800130607     C                   If        RRN <> *Zero
050900130607     C                   MOVE      *ON           *IN31
051000130607     C                   ENDIF
051100130607     C                   WRITE     TRAILER
051200130607     C                   EXFMT     HEADER
051300130607     C                   ENDSR
