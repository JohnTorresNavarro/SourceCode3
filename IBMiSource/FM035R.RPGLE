000100140312     H option(*nodebugio) alwnull(*usrctl) debug
000200991124     F*-------------------------------------------------------------------------
000300130423     F* FM035R     GBS SOFTWARE 2013
000400081111     F*            WRITTEN BY - RLJ
000500130423     F*            DATE - 04/2013
000600130423     F*  DESCRIPTION - Plan Auxiliary File Maintenance Pgm
000700991124     F*  INDICATOR USAGE:
000800991124     F*    03 = EXIT FROM INITIAL SCREEN
000900991124     F*
001000991124     F*-------------------------------------------------------------------------
001100991209     ** MODIFICATION HISTORY                                              **
001200140114     ** rlj 01/14/2014 - Pre-fill ACA w/ CARMST2P value on a record Add   **
001300140115     ** rlj 01/15/2014 - Do not allow ACA flag to be chgd on ADD or CHG   **
001400140115     ** rlj 01/15/2014 - Do not allow Car Pln ID to be chgd if there are  **
001500140115     **                  any active MCOV recs attached to plan            **
001600140211     ** rlj 02/07/2014 - Check for valid Carrier Plan ID                  **
001700140211     ** rlj 02/11/2014 - Allow for field Mst Grp# for Coventry ACA Plans  **
001800140214     **                - and write COVG#XRF record using Mst Grp# data    **
001900140212     ** rlj 02/12/2014 - Include Renew YR in parms - use it for GRATE     **
002000140916     ** rlj 09/16/2014 - Don't allow user to exit w/o writing PLNAUX rec  **
002100141104     ** rlj 10/16/2014 - Allow ACA rateing code to be Y,N,C or D          **
002200141104     ** rlj 11/04/2014 - Change descriptions to all caps                  **
002300141104     ** rlj 11/04/2014 - Don't change ACA rating on Add unless it is blank**
002400141113     ** rlj 11/13/2014 - Add selection window for ACA Rating              **
002500150126     ** rlj 01/26/2015 - Add code for file EXAGERATE                      **
002600160413     ** jt  04/13/2016 - Added code to update Group # at CARPLNP          **
002700160609     ** rlj 06/08/2016 - Added code for Student Max Age field             **
002800160927     ** rlj 09/27/2016 - Added code for Age Based on EMP or SPS           **
002900161014     ** rlj 10/13/2016 - Added code Dep Cov Ends - EO plan yr             **
003000161220     ** rlj 12/20/2016 - Remove code for COVG#XRF per DK.                 **
003100991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
003200130423     FPLNAUXP   UF A E           K DISK
003300130423     FPLNMST    IF   E           K DISK
003400130423     FTRSMST    IF   E           K DISK
003500130423     FSUBMST    IF   E           K DISK
003600130423     FACCMST    IF   E           K DISK
003700131107     FCODES     IF   E           K DISK
003800131108     FCARMST    IF   E           K DISK
003900140114     FCARMST2P  IF   E           K DISK
004000140211     FCODE20P   IF   E           K DISK
004100140211     FAGERATEL1 IF   E           K DISK    RENAME(AGERATE:RATEF)
004200150126     FEXAGERATE IF   E           K DISK    RENAME(EXAGERATE:RATEFX)
004300140115     FMCOVL1    IF   E           K DISK
004400130607     FPLNAXHSTP UF A E           K DISK
004500131217     FGRATE     UF A E           K DISK
004600160413     FCARPLNL   UF A E           K DISK    rename(carplnr:planSetup)
004700131108     FGRTHIST0  O    E             DISK
004800130423     FFM035D    CF   E             WORKSTN
004900130607     F                                     SFILE(DETAIL:RRN)
005000141113     F                                     SFILE(SELACA:ARRN)
005100130425   X* *
005200130424     D                UDS
005300130424     D  @USER                100    107
005400130424     D  CONAME               201    240
0055001304240056 D  lprefix              241    241
005600130424      *
005700130606    *** TIMESTAMP FIELDS DATA STRUCTURE
005800130606      *
005900130606     D @TIMESTAMP      DS
006000130606     D  #TSCYMD                1      8S 0
006100130606     D  #TSTIME                9     14S 0
006200130606     D  @TSJOB                15     24
006300130606     D  @TSUSER               25     34
006400130606     D  #TSNBR                35     40S 0
006500130606    ***
006600130424    * *
006700010918     D @K5             S              4A
006800130606     D @TS40           S             40A
006900130424    * *
007000001207     D                 DS
007100131126     D @ENTPRM                        1A
007200131126    * *
007300131126     D                 DS
007400140212     D @KEYPRM                 1     14A
007500001207     D #KT                     1      3S 0
007600001207     D #KS                     4      6S 0
007700081111     D #KP                     7     10A
007800140212     D #KY                    11     14A
007900130424    * *
008000130424     D                 DS
008100140106     D kycarpln        S            150A
008200140106     D addflg          S              1A   INZ('N')
008300130510     D chgflg          S              1A   INZ('N')
008400140214     D cvxflg          S              1A   INZ('N')
008500131217     D chkrtf          S              1A   INZ('N')
008600140916     D recwrt          S              1A   INZ('N')
008700141114     D denpln          S              1A   INZ('N')
008800141113     D wacac           S              1A
008900140211     D k20typ          S             10A   INZ('RATE CARR ')
009000130723     D adwtdy          S              5A
009100130925     D adrhdy          S              5A
009200131111     D wkdatmm         S              2  0
009300131111     D wkdat           S               D
0094001311110037 D wkdat1          S               D   datfmt(*iso)
0095001311110037 D sysdateymd      S               D   datfmt(*iso)
009600130510     D usadt           S               D   DATFMT(*USA/)
009700130710     D svborefd        S                   LIKE(pxborefd)
009800130606     D svwtpd          S                   LIKE(pxwtpd)
009900130606     D svrhpd          S                   LIKE(pxrhpd)
010000130606     D svtrmc          S                   LIKE(pxtrmc)
010100130606     D svdpcd          S                   LIKE(pxdpcd)
010200130606     D svmpcd          S                   LIKE(pxmpcd)
010300140211     D arkpln          S                   LIKE(RTPLNID)
010400140211     D arkcar          S                   LIKE(RTCARRIER) INZ(*BLANKS)
010500160414     D exportID        S             10    inz('0000000114')
010600140211      *
010700130624     D                 DS
010800130913     D  svborlrd               1      8  0
010900130913     D   borlrdmm              5      6  0
011000130913      *
011100130913     D                 DS
011200130913     D  datmdy                 1      8  0
011300130913     D   mdymmdd               1      4  0
011400130913     D   mdyyyyy               5      8  0
011500130426      *
011600130426     D                 DS
011700130426     D  datymd                 1      8  0
011800130426     D   ymdyyyy               1      4  0
011900130426     D   ymdmmdd               5      8  0
012000130426      *
012100130426     D                 DS
012200130426     D  wtpd3                  1      3
012300130426     D   aawtpd1               1      1
012400130426     D   aawtpd2               2      2
012500130426     D   aawtpd3               3      3
012600130509      *
012700130509     D                 DS
012800130509     D cwtpd3                  1      3
012900130509     D   acwtpd1               1      1
013000130509     D   acwtpd2               2      2
013100130509     D   acwtpd3               3      3
013200081111      *
013300130426     D                 DS
013400130613     D  rhpd4                  1      4
013500130426     D   aarhpd1               1      1
013600130426     D   aarhpd2               2      2
013700130426     D   aarhpd3               3      3
013800130613     D   aarhpd4               4      4
013900130426      *
014000130509     D                 DS
014100130613     D crhpd4                  1      4
014200130509     D   acrhpd1               1      1
014300130509     D   acrhpd2               2      2
014400130509     D   acrhpd3               3      3
014500130613     D   acrhpd4               4      4
014600130509      *
014700130426     D                 DS
014800130426     D  trmc4                  1      4
014900130426     D   aatrmc1               1      1
015000130426     D   aatrmc2               2      2
015100130426     D   aatrmc3               3      3
015200130426     D   aatrmc4               4      4
015300130509     D                 DS
015400130509     D  trcc4                  1      4
015500130509     D   actrmc1               1      1
015600130509     D   actrmc2               2      2
015700130509     D   actrmc3               3      3
015800130509     D   actrmc4               4      4
015900130426      *
016000130426     D                 DS
016100161013     D  dpcd4                  1      4
016200130426     D   aadpcd1               1      1
016300130426     D   aadpcd2               2      2
016400130426     D   aadpcd3               3      3
016500161013     D   aadpcd4               4      4
016600130509     D                 DS
016700161013     D cdpcd4                  1      4
016800130509     D   acdpcd1               1      1
016900130509     D   acdpcd2               2      2
017000130509     D   acdpcd3               3      3
017100161013     D   acdpcd4               4      4
017200130426     D                 DS
017300130426     D  mpcd3                  1      3
017400130426     D   aampcd1               1      1
017500130426     D   aampcd2               2      2
017600130426     D   aampcd3               3      3
017700130426      *
017800130509     D                 DS
017900130509     D cmpcd3                  1      3
018000130509     D   acmpcd1               1      1
018100130509     D   acmpcd2               2      2
018200130509     D   acmpcd3               3      3
018300131107      *
018400131107     D                 DS
018500131107     D pxcfsen                 1      5
018600131107     D   pxcfse1               1      1
018700131107      *
018800131107     D                 DS
018900131107     D plncat                  1      3
019000131107     D   cdkey1                1      1
019100131107     D   cdkey2                2      3
019200131107      *
019300131107     D                 DS
019400131107     D  ratdat                 1      8  0
019500131107     D   rdyyyy                1      4  0
019600131107     D   rdmm                  5      6  0
019700131107     D   rddd                  7      8  0
019800130426      *
019900081111     D                 DS
020000081111     D  plnx           S              1
020100081111     D  plnnmb         S              1  0
020200081111     D  plbeg          S              4
020300081111      *
0204001304230053 D                 DS
0205001304230054 D  invpln         C                   'INVALID TRUST/SUB#/PLAN     '
0206001304230054 D  invacc         C                   'INVALID TRUST/SUB#/ACCOUNT  '
0207001411040054 D  wdhcon         C                   'DATE OF HIRE PLUS '
0208001411040054 D  wfmcon         C                   'FIRST OF MONTH FOLLOW DOH + '
0209001411040054 D  wffcon         C                   'FIRST DAY FOLLOWING '
0210001411040054 D  rhdcon         C                   'DATE OF REHIRE PLUS '
0211001411040054 D  rfmcon         C                   'FIRST OF MONTH FOLLOW DOR + '
0212001411040054 D  rffcon         C                   'FIRST DAY FOLLOWING '
0213001306130054 D  rnacon         C                   'N/A                              '
0214001411040054 D  tadcon         C                   'ACTUAL DATE OF TERMINATION'
0215001411140054 D  temcon         C                   'EOM FOLLOWING TERMINATION'
0216001411040054 D  tfmcon         C                   '1ST OF MONTH AFTER TERMINATION'
0217001411040054 D  tdacon         C                   'DAU AFTER TERMINATION'
0218001411040054 D  dbdcon         C                   'DEPENDENTS DOB'
0219001411040054 D  demcon         C                   'END OF MONTH'
0220001411040054 D  deycon         C                   'END OF CALENDAR YEAR'
0221001610130054 D  depcon         C                   'END OF PLAN YEAR'
0222001411040054 D  mbbcon         C                   'BENEFIT BASED PLAN'
0223001411040054 D  msbcon         C                   'SALARY BASED PLAN'
0224001411040054 D  mbmcon         C                   'BENEFIT CONV PREM VOL FOR WEB'
0225001306240054 D  wtpderr        C                   'Waiting Period entry required'
0226001307120054 D  wtdyerr        C                   'Waiting Per + Days cannot be 0'
0227001307160054 D  wtdnerr        C                   'See Diary Notes must be Y or N'
0228001306240054 D  rhpderr        C                   'Rehire Waiting Period entry require'
0229001304260054 D  rhwderr        C                   'Rehire Within must be less than 151'
0230001306240054 D  trmcerr        C                   'Term Date Definition entry required'
0231001304260054 D  econerr        C                   'Employer Cont must be less than 101'
0232001311220054 D  excherr        C                   'Exchange must be Y or N'
0233001609270054 D  acaerr         C                   'ACA Rating must be Y or C'
0234001609270054 D  eoserr         C                   'Age Based must be E or S'
0235001311220054 D  ptynerr        C                   'Part_Time Eligible must be Y or N'
0236001304260054 D  pthlerr        C                   'Must enter Part Time Hours'
0237001304260054 D  ptloerr        C                   'From Hours must range 20 - 40'
0238001304260054 D  pthierr        C                   'To Hours must range 20 - 40'
0239001304260054 D  dpmxerr        C                   'Dependent Max Age must be below 27'
0240001606090054 D  stmxerr        C                   'Student Max age req if St ver = Y'
0241001606100054 D  stmxerx        C                   'If St Max Age is set, St ver must b-
0242001606100054 D                                     e Y'
0243001306240054 D  dpcderr        C                   'Dep Coverage Ends On entry required'
0244001304260054 D  dpsverr        C                   'Student Verification must be Y or N'
0245001311070054 D  cfseerr        C                   'CFS Entity must be A,B,C or blank'
0246001311080054 D  cfseerr1       C                   'CFS Entity can not be blank for a C-
0247001311110054 D                                     FS Med Plan'
0248001409160054 D  writerr        C                   'Cannot exit without adding new PLN-
0249001409160054 D                                      AUX record'
0250001409160054 D  brdterr        C                   'BOR Effective Date is invalid'
0251001304260054 D  brlrerr        C                   'BOR Last Renew Date is invalid'
0252001305090054 D  brsserr        C                   'If 1 BOR date is 0, both must 0'
0253001308230054 D  brleerr        C                   'BOR Eff Date s/b after Last Renewal'
0254001309130054 D  brlmerr        C                   'BOR Last Renew month s/b equal to P'
0255001306240054 D  mpcderr        C                   'Mult to Conv PBV entry required    '
0256001304260054 D  ussperr        C                   'Use Spouse DOB must be Y or N'
0257001304260054 D  shwwerr        C                   'Show on Web must be Y or N'
0258001402110054 D  mgrperr        C                   'Mst Grp# cannot be blank for ACA Co-
0259001402110054 D                                     ventry Plans'
0260001402110054 D  stopadd        C                   'Plan was not added - hit CMD-1, the-
0261001402110054 D                                     n hit enter from Screen 1!'
0262001312190054 D  grpcerr        C                   'Group and Carrier Plan ID must both-
0263001311140054 D                                      be blank or entered'
0264001401060054 D  carperr        C                   'Carrier Plan ID is invalid'
0265001305100054 D  addmsg         C                   'Plan Auxiliary record added'
0266001305100054 D  chgmsg         C                   'Plan Auxiliary record changed'
0267001306240054 D  xmsg           C                   '     X - Indicates Selection       '
0268001411130054 D  aytext         C                   'ACA Member Level Rating       '
0269001411200054 D  actext         C                   'ACA Composite Rating          '
0270001411130054 D  adtext         C                   'ACA Dental Mbr Level Rating   '
0271001411130054 D  antext         C                   'Non ACA Composite Rating      '
027200130426    * *
027300130426     C     keytsa        KLIST
027400130426     C                   KFLD                    #KT
027500130426     C                   KFLD                    #KS
027600130426     C                   KFLD                    pxacct
027700130426    * *
027800130426     C     keytsa1       KLIST
027900130426     C                   KFLD                    #KT
028000130426     C                   KFLD                    #KS
028100130426     C                   KFLD                    aaacct
028200130426    * *
028300130426     C     keytsp        KLIST
028400130426     C                   KFLD                    #KT
028500130426     C                   KFLD                    #KS
028600130426     C                   KFLD                    #KP               4
028700130426    * *
028800130426     C     keyts         KLIST
028900130426     C                   KFLD                    #KT
029000130426     C                   KFLD                    #KS
029100131107    * *
029200131107     C     keycd         KLIST
029300131107     C                   KFLD                    cdkey1
029400131107     C                   KFLD                    cdkey2
029500131217    * *
029600131217     C     ratkey        KLIST
029700131217     C                   KFLD                    pxtrst
029800131217     C                   KFLD                    pxsub#
029900131217     C                   KFLD                    pxplan
030000140211    * *
030100140211     C     co20ky        KLIST
030200140211     C                   KFLD                    k20typ
030300140211     C                   KFLD                    k20grp           20
030400140211    * *
030500140211     C     agrtky        KLIST
030600140211     C                   KFLD                    arkcar
030700140211     C                   KFLD                    arkpln
030800140214    * *
030900140214     C     cvxkey        KLIST
031000140214     C                   KFLD                    pxtrst
031100140214     C                   KFLD                    pxsub#
031200140214     C                   KFLD                    pxplan
031300140214     C                   KFLD                    pxgroup
031400160413
031500160413     C     planIDkey     KLIST
031600160413     C                   KFLD                    exportID
031700160413     C                   KFLD                    pxtrst
031800160413     C                   KFLD                    pxsub#
031900160413     C                   KFLD                    pxplan
032000160413
032100130423   X* *X
032200130423      * MAINLINE
032300130423    * *
032400991124     C                   EXSR      ONCE
032500130423      *
032600991216     C                   DOU       @EXIT = '1'
032700130423      *
032800130426     C                   IF        *IN01 = '1' or *IN07 = '1'
032900000217     C                   MOVE      '1'           @EXIT
033000000217     C                   MOVE      '*LR'         @PARM
033100130501     C                   iter
033200130501     C                   endif
033300130501      *
033400130501     C     keytsp        chain     plnauxp                            24
033500130501     C                   if        *in24 = '1'
033600130501     C                   clear                   auxadd
033700130501     C                   exsr      addaux
033800130501     C                   iter
033900130501     C                   else
034000130501     C                   exsr      dspaux
034100130509      *
034200130509     C                   if        *IN06 = '1'
034300130606     C                   eval      chgflg = 'N'
034400130509     C                   exsr      chgaux
034500130509     C                   endif
034600130607      *
034700130607     C                   if        *IN09 = '1'
034800130607     C                   exsr      hstaux
034900130607     C                   eval      *IN01 = '0'
035000130607     C                   endif
035100130509      *
035200130501     C                   endif
035300130423      *
035400081119     C                   ENDDO
035500130423      *
035600081119     C                   MOVE      *ON           *INLR
035700081119     C                   RETURN
035800991124   S***S
035900991124     C* ONETIME ROUTINE
036000081119    ***
036100081119     C     ONCE          BEGSR
036200130423    * *
036300081119     C     *ENTRY        PLIST
036400140212     C                   PARM                    @PARM            14
036500081119     C                   MOVEL(P)  @PARM         @KEYPRM
036600130423    * *
036700130424     C                   MOVEL     CONAME        TITLE
036800081126     C                   MOVE      '0'           @EXIT             1
036900130423    * *
037000010918     C                   ENDSR
037100130423      ******************************************************************
037200130423      *       SUBROUTINE - DSPAUX                                      *
037300130423      *                    Display Plan Auxiliary Data                 *
037400130423      ******************************************************************
037500130423     C     dspaux        BEGSR
037600130423      *
037700130423     C                   clear                   auxdsp
037800130424     C                   MOVEL     CONAME        TITLE
037900130423      *
038000130423     C                   eval      adtrst = #KT
038100130423     C     #KT           chain     trsmst                             21
038200130423     C                   if        *in21 = '1'
038300130423     C                   eval      adtname = 'INVALID TRUST#      '
038400130423     C                   exfmt     auxdsp
038500130423     C                   leavesr
038600130423     C                   else
038700130423     C                   eval      adtname = tname
038800130423     C                   endif
038900130423      *
039000130423     C                   eval      adsub# = #KS
039100130423     C     keyts         chain     submst                             22
039200130423     C                   if        *in22 = '1'
039300130423     C                   eval      adsname = 'INVALID TRUST/SUB#  '
039400130423     C                   exfmt     auxdsp
039500130423     C                   leavesr
039600130423     C                   else
039700130423     C                   eval      adsname = subnam
039800130423     C                   endif
039900130423      *
040000130423     C                   eval      adplan = #KP
040100130423     C     keytsp        chain     plnmst                             23
040200130423     C                   if        *in23 = '1'
040300130423     C                   movel(P)  invpln        adpdesc
040400130423     C                   exfmt     auxdsp
040500130423     C                   leavesr
040600130423     C                   else
040700130423     C                   eval      adpdesc = pdescr
040800130423     C                   endif
040900140211      *      See if Coventry and ACA => Mst Grp# enabled
041000140211     C                   eval      *in87 = '0'
041100140211     C     pcarr         chain     carmst                             24
041200140211     C                   if        *in24 = '0' and cgrpcd = 'CH'
041300140211      *
041400140211     C     pcarr         chain     carmst2p                           96
041500140211     C                   if        *in96 = '0' and c2acart = 'Y'
041600140211     C                   eval      *in87 = '1'
041700140211     C                   endif
041800140211     C                   endif
041900130423      *
042000130423     C                   movel     pxacct        adacct
042100130423     C                   if        pxacct <> 0
042200130423     C     keytsa        chain     accmst                             25
042300130423     C                   if        *in25 = '1'
042400130423     C                   movel(P)  invacc        adacnam
042500130423     C                   else
042600130423     C                   eval      adacnam = acnam1
042700130423     C                   endif
042800130423     C                   endif
042900130423      *
043000130723     C                   eval      adwtdy = %EDITC(pxwtdy:'A')
043100130423     C                   eval      adwtpd = pxwtpd
043200130423     C                   select
043300130423     C                   when      adwtpd =  'WDH'
043400141120     C                   eval      adwtdsc = wdhcon + %trim(adwtdy) + ' DAYS'
043500130423     C                   when      adwtpd =  'WFM'
043600141120     C                   eval      adwtdsc = wfmcon + %trim(adwtdy) + ' DAYS'
043700130423     C                   when      adwtpd =  'WFF'
043800141120     C                   eval      adwtdsc = wffcon + %trim(adwtdy) + ' DAYS'
043900130423     C                   endsl
044000130423      *
044100130716     C                   eval      adwtdn = pxwtdn
044200130716      *
044300130716     C                   eval      adrhwd = pxrhwd
044400130423      *
044500130424     C                   eval      adrhdy = %EDITC(pxrhdy:'1')
044600130423     C                   eval      adrhpd = pxrhpd
044700130423     C                   select
044800130423     C                   when      adrhpd =  'RDH'
044900141120     C                   eval      adrhdsc = rhdcon + %trim(adrhdy) + ' DAYS'
045000130423     C                   when      adrhpd =  'RFM'
045100141120     C                   eval      adrhdsc = rfmcon + %trim(adrhdy) + ' DAYS'
045200130423     C                   when      adrhpd =  'RFF'
045300141120     C                   eval      adrhdsc = rffcon + %trim(adrhdy) + ' DAYS'
045400130613     C                   when      adrhpd =  'RNA'
045500130613     C                   eval      adrhdsc = rnacon
045600130423     C                   endsl
045700130423      *
045800130423     C                   eval      adtrmc = pxtrmc
045900130423     C                   select
046000130423     C                   when      adtrmc =  'TAD'
046100130423     C                   movel(P)  tadcon        adtmdsc
046200130423     C                   when      adtrmc =  'TEM'
046300130423     C                   movel(P)  temcon        adtmdsc
046400130423     C                   when      adtrmc =  'TFM'
046500130423     C                   movel(P)  tfmcon        adtmdsc
046600130423     C                   when      adtrmc =  'TDA'
046700130423     C                   movel(P)  tdacon        adtmdsc
046800130423     C                   endsl
046900130423      *
047000160927     C                   eval      *in37 = '0'
047100160927     C                   if        pabfl <> 'N'
047200160927     C                   if        plncat = 'PSA' or plncat = 'PSP' or
047300160927     C                             plncat = 'PS1'
047400160927     C                   eval      *in37 = '1'
047500160927     C                   eval      adeors = pxeors
047600160927     C                   endif
047700160927     C                   endif
047800160927      *
047900130423     C                   eval      adecon = pxecon
048000131122     C                   eval      adexchg = pxexchg
048100131206     C                   eval      adacar = pxacar
048200131107     C                   eval      adgroup = pxgroup
048300130423     C                   eval      adptyn = pxptyn
048400130611      *
048500130611     C                   eval      *in64 = '0'
048600130611     C                   if        adptyn = 'Y'
048700130611     C                   eval      *in64 = '1'
048800130611     C                   eval      adptlo = pxptlo
048900130423     C                   eval      adpthi = pxpthi
049000130611     C                   endif
049100130423      *
049200130423     C                   eval      addpmx = pxdpmx
049300130423      *
049400130423     C                   eval      addpcd = pxdpcd
049500130423     C                   select
049600130423     C                   when      addpcd =  'DBD'
049700130423     C                   movel(P)  dbdcon        addpdsc
049800130423     C                   when      addpcd =  'DEM'
049900130423     C                   movel(P)  demcon        addpdsc
050000130423     C                   when      addpcd =  'DEY'
050100130423     C                   movel(P)  deycon        addpdsc
050200161013     C                   when      addpcd =  'DEP'
050300161013     C                   movel(P)  depcon        addpdsc
050400130423     C                   endsl
050500130423      *
050600130423     C                   eval      addpsv = pxdpsv
050700160609      *
050800160609     C                   eval      adstmx = pxstmx
050900130424      *
051000131107     C                   eval      adcfse1 = pxcfse1
051100131107      *
051200130710     C                   if        pxborefd = 0
051300130509     C                   eval      adbrdt = *blanks
051400130509     C                   else
051500130710     C                   movel     pxborefd      wkdat
051600130424     C                   eval      usadt = wkdat
051700130424     C                   movel     usadt         adbrdt
051800130509     C                   endif
051900130424      *
052000130509     C                   if        pxborlrd = 0
052100130509     C                   eval      adbrlr = *blanks
052200130509     C                   else
052300130424     C                   movel     pxborlrd      wkdat
052400130424     C                   eval      usadt = wkdat
052500130424     C                   movel     usadt         adbrlr
052600130509     C                   endif
052700130424      *
052800130424     C                   eval      admpcd = pxmpcd
052900130424     C                   select
053000130424     C                   when      admpcd =  'MBB'
053100130424     C                   movel(P)  mbbcon        admpdsc
053200130424     C                   when      admpcd =  'MSB'
053300130424     C                   movel(P)  msbcon        admpdsc
053400130424     C                   when      admpcd =  'MBM'
053500130424     C                   movel(P)  mbmcon        admpdsc
053600130424     C                   endsl
053700130424      *
053800130423     C                   eval      adussp = pxussp
053900130423     C                   eval      adshww = pxshww
054000140211     C   87              eval      admgrp# = pxmgrp#
054100130510      *
054200131107     C                   eval      adcarpln = pxcarpln
054300131107      *
054400130510     C                   if        addflg = 'Y'
054500130510     C                   eval      admsg = addmsg
054600130510     C                   eval      addflg = 'N'
054700130510     C                   eval      *IN81 = '1'
054800130510     C                   endif
054900130510      *
055000130510     C                   if        chgflg = 'Y'
055100130510     C                   eval      admsg = chgmsg
055200130510     C                   eval      *IN81 = '1'
055300130510     C                   eval      chgflg = 'N'
055400130510     C                   endif
055500130510      *
055600130423     C                   exfmt     auxdsp
055700130510     C                   eval      *IN81 = '0'
055800130423      *
055900130423     C                   endsr
056000130607      ******************************************************************
056100130607      *       SUBROUTINE - HSTAUX                                      *
056200130607      *                    Display Plan Auxiliary History              *
056300130607      ******************************************************************
056400130607     C     hstaux        BEGSR
056500130607      *
056600130607     C     *IN01         DOWEQ     *OFF
056700130607     C     *IN07         ANDEQ     *OFF
056800130607      *      RELOAD IF CLIENT SEARCH CHANGES
056900130607     C                   EXSR      $CLEAR
057000130607     C                   EXSR      $LOAD
057100130607     C                   EXSR      $DISPLAY
057200130607     C                   setoff                                       88
057300130607      *    PROCESS SELECTION
057400130607     C***  *IN01         IFEQ      *OFF
057500130607     C***  *IN07         ANDEQ     *OFF
057600130607     C***  RRN           ANDNE     *ZERO
057700130607     C********           EXSR      $PROCES
057800130607     C*****              ENDIF
057900130607      *
058000130607     C                   enddo
058100130607      *
058200130607     C                   endsr
058300130607      ******************************************************************
058400130607      *       SUBROUTINE - $CLEAR                                      *
058500130607      *                    CLEAR SUBF AND RRN                          *
058600130607      ******************************************************************
058700130607     C     $CLEAR        BEGSR
058800130607     C                   MOVEA     '001'         *IN(31)
058900130607     C                   wRITE     HEADER
059000130607     C                   Z-ADD     *ZERO         RRN               4 0
059100130607     C                   WRITE     HEADER
059200130607     C                   MOVEA     '010'         *IN(31)
059300130607     C                   ENDSR
059400130607      ******************************************************************
059500130607      *       SUBROUTINE - $LOAD                                       *
059600130607      *                    LOAD SUBFILE W/ Change Info                 *
059700130607      ******************************************************************
059800130607     C     $LOAD         BEGSR
059900130607     C                   SETOFF                                       3495
060000130607     C     keytsp        setll     plnaxhstp                          34
060100130607     C     *IN34         DOUEQ     *ON
060200130607     C     *IN95         OREQ      *ON
060300130607     C     keytsp        reade     plnaxhstp                              34
060400130607     C                   IF        (*In34 <> *ON) and
060500130607     C                             axplan = #KP
060600130607      *
060700130607     C                   ADD       1             RRN
060800130607     C                   movel     axdate        wkdat
060900130607     C                   eval      usadt = wkdat
061000130607     C                   movel     usadt         ahdate
061100130607      *
061200130607     C                   movel     axuser        ahuser
061300130607     C                   if        axtype = 'A'
061400130607     C                   movel(P)  addmsg        ahmsg
061500130607     C                   else
061600130607     C                   eval      ahmsg = *blanks
061700130607     C                   eval      ahmsg = %trim(axfld) + ' changed from ' +
061800130607     C                             %trim(axfrom) + ' to ' + %trim(axto)
061900130607     C                   endif
062000130607      *
062100130607     C                   WRITE     DETAIL
062200130607     C                   ENDIF
062300130607     C                   ENDDO
062400130607     C                   ENDSR
062500130607      ******************************************************************
062600130607      *       SUBROUTINE - $DISPLAY                                    *
062700130607      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
062800130607      ******************************************************************
062900130607     C     $DISPLAY      BEGSR
063000130607     C                   If        RRN <> *Zero
063100130607     C                   MOVE      *ON           *IN31
063200130607     C                   ENDIF
063300130607     C                   WRITE     TRAILER
063400130607     C                   EXFMT     HEADER
063500130607     C                   ENDSR
063600130607      *
063700130425      ******************************************************************
063800130425      *       SUBROUTINE - ADDAUX                                      *
063900130425      *                    Add Plan Auxiliary Record                   *
064000130425      ******************************************************************
064100130425     C     addaux        BEGSR
064200130425      *
064300130425     C                   MOVEL     CONAME        TITLE
064400130624     C                   movel(P)  xmsg          aamsg
064500130509     C                   eval      aashww = 'Y'
064600130716     C                   eval      aawtdn = 'N'
064700131115     C                   eval      aarhpd4 = 'X'
064800141104     C                   eval      aaacar = ' '
064900140916     C                   eval      recwrt = 'N'
065000130425      *
065100130425     C                   eval      aatrst = #KT
065200130425     C     #KT           chain     trsmst                             21
065300130425     C                   if        *in21 = '1'
065400130425     C                   eval      aatname = 'INVALID TRUST#      '
065500130425     C                   exfmt     auxadd
065600130425     C                   leavesr
065700130425     C                   else
065800130425     C                   eval      aatname = tname
065900130425     C                   endif
066000130425      *
066100130425     C                   eval      aasub# = #KS
066200130425     C     keyts         chain     submst                             22
066300130425     C                   if        *in22 = '1'
066400130425     C                   eval      aasname = 'INVALID TRUST/SUB#  '
066500130425     C                   exfmt     auxadd
066600130425     C                   leavesr
066700130425     C                   else
066800130425     C                   eval      aasname = subnam
066900130425     C                   endif
067000130425      *
067100130425     C                   eval      aaplan = #KP
067200130425     C     keytsp        chain     plnmst                             23
067300130425     C                   if        *in23 = '1'
067400130425     C                   movel(P)  invpln        aapdesc
067500131219     C                   eval      *in73 = '1'
067600131219     C                   movel(P)  stopadd       aamsg
067700131219     C                   eval      *in81 = '1'
067800130425     C                   exfmt     auxadd
067900131219     C                   eval      *in73 = '0'
068000130425     C                   leavesr
068100130425     C                   else
068200130425     C                   eval      aapdesc = pdescr
068300160927      *
068400160927     C                   eval      *in37 = '0'
068500160927     C                   if        pabfl <> 'N'
068600160927     C                   if        plncat = 'PSA' or plncat = 'PSP' or
068700160927     C                             plncat = 'PS1'
068800160927     C                   eval      *in37 = '1'
068900160927     C                   endif
069000160927     C                   endif
069100160927      *
069200130425     C                   endif
069300141114      *            Check for Dental Plans
069400141114     C                   eval      denpln = 'N'
069500141114     C     pcarr         chain     carmst                             24
069600141114     C                   if        *in24 = '0'
069700141114     C     keycd         chain     codes                              21
069800141114     C                   if        *in21 = '0' and action = 'D'
069900141114     C                   eval      denpln = 'Y'
070000141114     C                   endif
070100141114     C                   endif
070200130425      *
070300141104     C                   if        aaacar = ' '
070400141104      *
070500141016     C                   eval      *in89 = '0'
070600141113     C                   eval      *in79 = '1'
070700140114     C     pcarr         chain     carmst2p                           96
070800140114     C                   if        *in96 = '0'
070900140114     C                   movel(P)  c2acart       aaacar
071000141016     C                   if        c2acart = 'N'
071100141016     C                   eval      *in89 = '1'
071200141113     C                   eval      *in79 = '0'
071300141124     C                   else
071400141124     C                   if        denpln = 'Y'
071500141124     C                   movel     'D'           aaacar
071600141124     C                   eval      *in79 = '0'
071700141124     C                   eval      *in89 = '1'
071800141124     C                   endif
071900141124     C                   endif
072000140114     C                   endif
072100140211      *
072200140211     C                   eval      *in87 = '0'
072300140211     C                   if        c2acart = 'Y'
072400140211     C     pcarr         chain     carmst                             96
072500141114     C                   if        *in96 = '0' and cgrpcd = 'CH'
072600140211     C                   eval      *in87 = '1'
072700140211     C                   endif
072800140211     C                   endif
072900140211      *
073000141104     C                   endif
073100141124      *
073200141124     C                   DOU       *IN01 = '1'
073300141104      *
073400130425     C                   if        aaacct = 0
073500130425     C                   eval      aaacnam = '(Optional - can be 0)'
073600130425     C                   else
073700130425     C     keytsa1       chain     accmst                             35
073800130425     C                   if        *in35 = '1'
073900130425     C                   movel(P)  invacc        aaacnam
074000130425     C                   exfmt     auxadd
074100130425     C                   else
074200130425     C                   eval      aaacnam = acnam1
074300130425     C                   endif
074400130425     C                   endif
074500130425      *
074600130425     C                   exfmt     auxadd
074700141113      *
074800130426     C                   movel     *blanks       aamsg
074900130426     C                   eval      *in81 = '0'
075000130712     C                   eval      *in41 = '0'
075100130716     C                   eval      *in42 = '0'
075200130712     C                   eval      *in46 = '0'
075300130426     C                   eval      *in47 = '0'
075400130426     C                   eval      *in48 = '0'
075500130426     C                   eval      *in49 = '0'
075600130426     C                   eval      *in50 = '0'
075700130426     C                   eval      *in51 = '0'
075800130426     C                   eval      *in52 = '0'
075900130426     C                   eval      *in53 = '0'
076000130426     C                   eval      *in54 = '0'
076100130426     C                   eval      *in55 = '0'
076200130426     C                   eval      *in56 = '0'
076300130426     C                   eval      *in57 = '0'
076400130426     C                   eval      *in58 = '0'
076500130426     C                   eval      *in59 = '0'
076600130426     C                   eval      *in60 = '0'
076700130501     C                   eval      *in61 = '0'
076800131107     C                   eval      *in62 = '0'
076900131107     C                   eval      *in63 = '0'
077000131122     C                   eval      *in65 = '0'
077100131220     C                   eval      *in66 = '0'
077200131206     C                   eval      *in67 = '0'
077300160609     C                   eval      *in68 = '0'
077400160927     C                   eval      *in69 = '0'
077500140211     C                   eval      *in70 = '0'
077600130426      *      Command Keys?
077700130426     C                   if        *in01 = '1' or *in07 = '1'
077800140916      *         Can't exit w/o writing PLNAUXP record
077900140916     C                   if        recwrt = 'N'
078000140916     C                   movel(P)  writerr       aamsg
078100140916     C                   eval      *in81 = '1'
078200140916     C                   eval      *in01 = '0'
078300140916     C                   eval      *in07 = '0'
078400140916     C                   iter
078500140916     C                   endif
078600140916      *
078700130426     C                   leavesr
078800130426     C                   endif
078900130426      *
079000141113     C******             if        *in04 = '1'
079100141113     C***                clear                   auxadd
079200141113     C****               MOVEL     CONAME        TITLE
079300141113     C****               iter
079400141113     C******             endif
079500141113      *
079600141113     C                   IF        *IN06 = *ON
079700141113     C                   exsr      acasel
079800141113     C                   movel(P)  wacac         aaacar
079900141114     C                   MOVE      *Off          *IN06
080000141113     C                   endif
080100131126      *
080200131126     C                   if        *in11 = '1'
080300131126     C                   EVAL      @ENTPRM = ' '
080400131126     C                   CALL      'FM036R'
080500131126     C                   PARM                    @ENTPRM
080600131126    * *
080700131126    1C****               IF        @ENTPRM = '*'
080800131126     C****               LEAVESR
080900131126    1C****               ENDIF
081000131126    * *
081100131126    1C                   IF        @ENTPRM = 'A' or @ENTPRM = 'B' or
081200131126    1C                             @ENTPRM = 'C'
081300131126     C                   eval      aacfse1 = @ENTPRM
081400131126    1C                   ENDIF
081500131220    * *        Position cursor
081600131220     C                   eval      *in66 = '1'
081700131220    * *
081800131220     C                   eval      *in11 = '0'
081900131126    1C                   iter
082000131126    1C                   ENDIF
082100131126      *
082200130426      *
082300130426      *      Edit entry fields
082400130426      *
082500130927     C                   if        aawtdn <> 'Y'
082600130426     C                   if        wtpd3 <> 'X  ' and wtpd3 <> ' X ' and
082700130426     C                             wtpd3 <> '  X'
082800130426     C                   movel(P)  wtpderr       aamsg
082900130426     C                   eval      *in81 = '1'
083000130426     C                   eval      *in46 = '1'
083100130426     C                   iter
083200130426     C                   endif
083300130927     C                   endif
083400130712      *
083500130712     C                   if        aawtpd3= 'X' and aawtdy = 0
083600130712     C                   movel(P)  wtdyerr       aamsg
083700130712     C                   eval      *in81 = '1'
083800130712     C                   eval      *in41 = '1'
083900130712     C                   iter
084000130712     C                   endif
084100130716      *
084200131108     C                   if        aawtdn <> 'Y'and aawtdn <> 'N' and
084300131108     C                             wtpd3 = '   '
084400130716     C                   movel(P)  wtdnerr       aamsg
084500130716     C                   eval      *in81 = '1'
084600130716     C                   eval      *in42 = '1'
084700130716     C                   iter
084800130716     C                   endif
084900130426      *
085000130613     C                   if        rhpd4 <> 'X   ' and rhpd4 <> ' X  ' and
085100130613     C                             rhpd4 <> '  X ' and rhpd4 <> '   X'
085200130624     C                   movel(P)  *blanks       aamsg
085300130624     C                   eval      aamsg = rhpderr + 'd'
085400130426     C                   eval      *in81 = '1'
085500130426     C                   eval      *in47 = '1'
085600130426     C                   iter
085700130426     C                   endif
085800130925      *  Mo max rehire w/in per candace
085900130925     C*****              if        aarhwd > 150
086000130925     C**                 movel(P)  rhwderr       aamsg
086100130925     C**                 eval      *in81 = '1'
086200130925     C**                 eval      *in48 = '1'
086300130925     C**                 iter
086400130925     C****               endif
086500130426      *
086600130426     C                   if        trmc4 <> 'X   ' and trmc4 <> ' X  ' and
086700130426     C                             trmc4 <> '  X ' and trmc4 <> '   X'
086800130426     C                   movel(P)  trmcerr       aamsg
086900130426     C                   eval      *in81 = '1'
087000130426     C                   eval      *in49 = '1'
087100130426     C                   iter
087200130426     C                   endif
087300130426      *
087400130426     C                   if        aaecon > 100
087500130426     C                   movel(P)  econerr       aamsg
087600130426     C                   eval      *in81 = '1'
087700130426     C                   eval      *in50 = '1'
087800130426     C                   iter
087900130426     C                   endif
088000160927      *
088100160927     C                   if        *in37 = '1'
088200160927     C                   if        aaeors <> 'E' and aaeors <> 'S'
088300160927     C                   movel(P)  eoserr        aamsg
088400160927     C                   eval      *in81 = '1'
088500160927     C                   eval      *in69 = '1'
088600160927     C                   endif
088700160927     C                   endif
088800130426      *
088900131122     C                   if        aaexchg <> 'Y' and aaexchg <> 'N'
089000131122     C                   movel(P)  excherr       aamsg
089100130426     C                   eval      *in81 = '1'
089200131122     C                   eval      *in65 = '1'
089300130426     C                   iter
089400130426     C                   endif
089500131206      *
089600141204     C                   if        aaacar <> 'N' and aaacar <> 'D'
089700141204     C                   if        aaacar <> 'Y' and aaacar <> 'C'
089800131206     C                   movel(P)  acaerr        aamsg
089900131206     C                   eval      *in81 = '1'
090000131206     C                   eval      *in67 = '1'
090100131206     C                   iter
090200131206     C                   endif
090300141204     C                   endif
090400131122      *
090500131122     C                   if        aaptyn <> 'Y' and aaptyn <> 'N'
090600131122     C                   movel(P)  ptynerr       aamsg
090700131122     C                   eval      *in81 = '1'
090800131122     C                   eval      *in51 = '1'
090900131122     C                   iter
091000131122     C                   endif
091100130426      *
091200130426     C                   if        aaptyn = 'Y' and
091300130426     C                             (aaptlo = 0 or aapthi = 0)
091400130426     C                   movel(P)  pthlerr       aamsg
091500130426     C                   eval      *in81 = '1'
091600130426     C                   eval      *in52 = '1'
091700130426     C                   iter
091800130426     C                   endif
091900130426      *
092000130925     C*****              if        aaptyn = 'Y'
092100130925     C**                 if        aaptlo < 20 or aaptlo > 40
092200130925     C**                 movel(P)  ptloerr       aamsg
092300130925     C**                 eval      *in81 = '1'
092400130925     C**                 eval      *in52 = '1'
092500130925     C**                 iter
092600130925     C*****              endif
092700130426      *
092800130925     C*****              if        aapthi < 20 or aapthi > 40
092900130925     C**                 movel(P)  pthierr       aamsg
093000130925     C**                 eval      *in81 = '1'
093100130925     C**                 eval      *in53 = '1'
093200130925     C**                 iter
093300130925     C**                 endif
093400130925     C*****              endif
093500130509      *   Per SR - no max Dep max age
093600130509     C********           if        aadpmx > 26
093700130509     C*****              movel(P)  dpmxerr       aamsg
093800130509     C*****              eval      *in81 = '1'
093900130509     C*****              eval      *in54 = '1'
094000130509     C*****              iter
094100130509     C********           endif
094200130426      *
094300161013     C                   if        dpcd4 <> 'X   ' and dpcd4 <> ' X  ' and
094400161013     C                             dpcd4 <> '  X ' and dpcd4 <> '    ' and
094500161013     C                             dpcd4 <> '   X'
094600130426     C                   movel(P)  dpcderr       aamsg
094700130426     C                   eval      *in81 = '1'
094800130426     C                   eval      *in55 = '1'
094900130426     C                   iter
095000130426     C                   endif
095100130426      *
095200130509     C                   if        aadpsv <> 'Y' and aadpsv <> 'N' and
095300130509     C                             aadpsv <> ' '
095400130426     C                   movel(P)  dpsverr       aamsg
095500130426     C                   eval      *in81 = '1'
095600130426     C                   eval      *in56 = '1'
095700130426     C                   iter
095800130426     C                   endif
095900160609      *
096000160609     C                   if        aadpsv = 'Y' and aastmx = 0
096100160609     C                   movel(P)  stmxerr       aamsg
096200160609     C                   eval      *in81 = '1'
096300160609     C                   eval      *in68 = '1'
096400160609     C                   iter
096500160609     C                   endif
096600160610      *
096700160610     C                   if        aadpsv = 'N' and aastmx > 0
096800160610     C                   movel(P)  stmxerx       aamsg
096900160610     C                   eval      *in81 = '1'
097000160610     C                   eval      *in68 = '1'
097100160610     C                   iter
097200160610     C                   endif
097300160609      *
097400131107     C                   if        aacfse1 <> 'A' and aacfse1 <> 'B' and
097500131107     C                             aacfse1 <> 'C' and aacfse1 <> ' '
097600131107     C                   movel(P)  cfseerr       aamsg
097700131107     C                   eval      *in81 = '1'
097800131107     C                   eval      *in63 = '1'
097900131107     C                   iter
098000131107     C                   endif
098100131108      *          If CFS plan aacfse1 can't be blank
098200131219      *            Not mandatory per Shelly
098300131108     C     pcarr         chain     carmst                             24
098400131108     C                   if        *in24 = '0' and cgrpcd = 'CF'
098500131113     C**** keycd         chain     codes                              21
098600131113     C****               if        *in21 = '0' and action = 'M'
098700131219      *            Not mandatory per Shelly
098800131219     C*****####          if        aacfse1 = ' '
098900131219     C***                movel(P)  cfseerr1      aamsg
099000131219     C***                eval      *in81 = '1'
099100131219     C****               eval      *in63 = '1'
099200131219     C******             iter
099300131219     C****####           endif
099400131219     C****               endif
099500131111     C                   endif
099600131108      *
099700130509     C                   if        aabrdt <> 0
099800130426     C     *USA          test(D)                 aabrdt                 57
099900130426     C                   if        *in57 = '1'
100000130426     C                   movel(P)  brdterr       aamsg
100100130426     C                   eval      *in81 = '1'
100200130426     C                   iter
100300130426     C                   endif
100400130509     C                   endif
100500130426      *
100600130509     C                   if        aabrlr <> 0
100700130426     C     *USA          test(D)                 aabrlr                 58
100800130426     C                   if        *in58 = '1'
100900130426     C                   movel(P)  brlrerr       aamsg
101000130426     C                   eval      *in81 = '1'
101100130426     C                   iter
101200130426     C                   endif
101300130509     C                   endif
101400130509      *
101500130509     C                   if        (aabrlr <> 0 and aabrdt = 0) or
101600130509     C                             (aabrdt <> 0 and aabrlr = 0)
101700130509     C                   eval      *in57 = '1'
101800130509     C                   movel(P)  brsserr       aamsg
101900130509     C                   eval      *in81 = '1'
102000130509     C                   iter
102100130509     C                   endif
102200130510      *
102300130510     C                   eval      datmdy = aabrdt
102400130510     C                   eval      ymdyyyy = mdyyyyy
102500130510     C                   eval      ymdmmdd = mdymmdd
102600130710     C                   eval      svborefd = datymd
102700130510     C                   eval      datmdy = aabrlr
102800130510     C                   eval      ymdyyyy = mdyyyyy
102900130510     C                   eval      ymdmmdd = mdymmdd
103000130510     C                   eval      svborlrd = datymd
103100130510      *
103200130924     C                   if        borlrdmm <> prenew and prenew <> 0 and
103300130924     C                             borlrdmm <> 0
103400130913     C                   eval      *in58 = '1'
103500130716     C                   eval      aamsg = *blanks
103600130913     C                   eval      aamsg = brlmerr + 'lan Renew Month'
103700130509     C                   eval      *in81 = '1'
103800130509     C                   iter
103900130509     C                   endif
104000130913      *
104100130913     C                   if        svborefd < svborlrd
104200130913     C                   eval      *in57 = '1'
104300130913     C                   eval      aamsg = *blanks
104400130913     C                   eval      aamsg = brleerr + ' Date'
104500130913     C                   eval      *in81 = '1'
104600130913     C                   iter
104700130913     C                   endif
104800130426      *
104900130426     C                   if        mpcd3 <> 'X  ' and mpcd3 <> ' X ' and
105000130509     C                             mpcd3 <> '  X' and mpcd3 <> '   '
105100130426     C                   movel(P)  mpcderr       aamsg
105200130426     C                   eval      *in81 = '1'
105300130426     C                   eval      *in59 = '1'
105400130426     C                   iter
105500130426     C                   endif
105600130426      *
105700130509     C                   if        aaussp <> 'Y' and aaussp <> 'N' and
105800130509     C                             aaussp <> ' '
105900130426     C                   movel(P)  ussperr       aamsg
106000130426     C                   eval      *in81 = '1'
106100130426     C                   eval      *in60 = '1'
106200130426     C                   iter
106300130426     C                   endif
106400130426      *
106500130426     C                   if        aashww <> 'Y' and aashww <> 'N'
106600130426     C                   movel(P)  shwwerr       aamsg
106700130426     C                   eval      *in81 = '1'
106800130426     C                   eval      *in61 = '1'
106900130426     C                   iter
107000130426     C                   endif
107100140211      *
107200140211     C                   if        *in87 = '1' and aamgrp# = *blanks
107300140211     C                   movel(P)  mgrperr       aamsg
107400140211     C                   eval      *in81 = '1'
107500140211     C                   eval      *in70 = '1'
107600140211     C                   iter
107700140211     C                   endif
107800160818      *    Per Candace - allow for trust 005
107900160818     C                   if        aatrst <> 005
108000131108      *
108100131108     C                   if        aacarpln <> *blanks and
108200131108     C                             aagroup = *blanks
108300131108     C                   movel(P)  grpcerr       aamsg
108400131108     C                   eval      *in81 = '1'
108500131108     C                   eval      *in62 = '1'
108600131108     C                   iter
108700131108     C                   endif
108800131114      *
108900131114     C                   if        aacarpln = *blanks and
109000131114     C                             aagroup <> *blanks
109100131114     C                   movel(P)  grpcerr       aamsg
109200131114     C                   eval      *in81 = '1'
109300131114     C                   eval      *in62 = '1'
109400131114     C                   iter
109500131114     C                   endif
109600160818     C                   endif
109700140211      *       Check for valid Carrier Plan ID
109800140211     C                   if        aacarpln <> *blanks
109900140211     C                   movel(P)  cgrpcd        k20grp
110000140211     C     co20ky        chain     code20p                            21
110100140211     C                   if        *in21 = '1'
110200140211     C                   movel(P)  carperr       aamsg
110300140211     C                   eval      *in81 = '1'
110400140211     C                   eval      *in66 = '1'
110500140211     C                   iter
110600140211     C                   else
110700140211      *
110800140211     C                   if        c20actn1 <> 'ENTITY    '
110900140211     C                   movel(P)  c20actn1      arkcar
111000140211     C                   else
111100140211     C                   select
111200140211     C                   when      aacfse1 = 'A'
111300140211     C                   movel(P)  'BLUEC'       arkcar
111400140211     C                   when      aacfse1 = 'B'
111500140211     C                   movel(P)  'CFMI'        arkcar
111600140211     C                   when      aacfse1 = 'C'
111700140211     C                   movel(P)  'GHMSI'       arkcar
111800140211     C                   endsl
111900140211     C                   endif
112000140211      *
112100140211     C                   movel(P)  aacarpln      arkpln
112200140211     C                   eval      arkpln = %TRIM(aacarpln)
112300150126      *
112400150126     C                   if        aaexchg <> 'Y'
112500150126      *
112600140211     C     agrtky        chain     ratef
112700140211     C                   if        NOT %FOUND(ageratel1)
112800150127      *
112900150127     C******             if        aacfse1 = 'B'
113000150127     C****               movel(P)  'BCBSM'       arkcar
113100150127     C**** agrtky        chain     ratef
113200150127     C*****              if        NOT %FOUND(ageratel1)
113300150127      *
113400140211     C                   movel(P)  carperr       aamsg
113500140211     C                   eval      *in81 = '1'
113600140211     C                   eval      *in66 = '1'
113700140211     C                   iter
113800150127     C*****              endif
113900150127     C*****              endif
114000150127     C                   endif
114100150126     C                   else
114200150126      *
114300150126     C     agrtky        chain     ratefx
114400150126     C                   if        NOT %FOUND(exagerate)
114500150127      *
114600150127     C********           if        aacfse1 = 'B'
114700150127     C**                 movel(P)  'BCBSM'       arkcar
114800150127     C**   agrtky        chain     ratef
114900150127     C**********         if        NOT %FOUND(ageratel1)
115000150127      *
115100150126     C                   movel(P)  carperr       aamsg
115200150126     C                   eval      *in81 = '1'
115300150126     C                   eval      *in66 = '1'
115400150126     C                   iter
115500150127     C****               endif
115600150127     C****               endif
115700150127     C                   endif
115800150126      *
115900150126     C                   endif
116000150126      *
116100140211     C                   endif
116200140211     C                   endif
116300130426      *
116400130426      *      All fields have valid data - write PLNAUX record
116500130426      *
116600130426     C                   clear                   plnauxr
116700130426     C                   eval      pxtrst = aatrst
116800130426     C                   eval      pxsub# = aasub#
116900130426     C                   eval      pxplan = aaplan
117000130426     C                   eval      pxacct = aaacct
117100130426      *
117200130426     C                   select
117300130426     C                   when      aawtpd1 = 'X'
117400130426     C                   eval      pxwtpd = 'WDH'
117500130426     C                   when      aawtpd2 = 'X'
117600130426     C                   eval      pxwtpd = 'WFM'
117700130426     C                   when      aawtpd3 = 'X'
117800130426     C                   eval      pxwtpd = 'WFF'
117900130426     C                   endsl
118000130426      *
118100130426     C                   eval      pxwtdy = aawtdy
118200130716     C                   eval      pxwtdn = aawtdn
118300130426     C                   eval      pxrhwd = aarhwd
118400130426      *
118500130426     C                   select
118600130426     C                   when      aarhpd1 = 'X'
118700130426     C                   eval      pxrhpd = 'RDH'
118800130426     C                   when      aarhpd2 = 'X'
118900130426     C                   eval      pxrhpd = 'RFM'
119000130426     C                   when      aarhpd3 = 'X'
119100130426     C                   eval      pxrhpd = 'RFF'
119200130613     C                   when      aarhpd4 = 'X'
119300130613     C                   eval      pxrhpd = 'RNA'
119400130426     C                   endsl
119500130426      *
119600131114     C                   if        pxrhpd = *blanks
119700131114     C                   eval      pxrhpd = 'RNA'
119800131114     C                   endif
119900131114      *
120000130426     C                   eval      pxrhdy = aarhdy
120100130426      *
120200130426     C                   select
120300130426     C                   when      aatrmc1 = 'X'
120400130426     C                   eval      pxtrmc = 'TAD'
120500130426     C                   when      aatrmc2 = 'X'
120600130501     C                   eval      pxtrmc = 'TEM'
120700130426     C                   when      aatrmc3 = 'X'
120800130426     C                   eval      pxtrmc = 'TFM'
120900130426     C                   when      aatrmc4 = 'X'
121000130426     C                   eval      pxtrmc = 'TDA'
121100130426     C                   endsl
121200130426      *
121300130426     C                   eval      pxecon = aaecon
121400131122     C                   eval      pxexchg = aaexchg
121500131206     C                   eval      pxacar = aaacar
121600131122     C                   eval      pxgroup = aagroup
121700130426     C                   eval      pxptyn = aaptyn
121800130426     C                   eval      pxptlo = aaptlo
121900130426     C                   eval      pxpthi = aapthi
122000130426     C                   eval      pxdpmx = aadpmx
122100130426      *
122200130426     C                   select
122300130426     C                   when      aadpcd1 = 'X'
122400130426     C                   eval      pxdpcd = 'DBD'
122500130426     C                   when      aadpcd2 = 'X'
122600130426     C                   eval      pxdpcd = 'DEM'
122700130426     C                   when      aadpcd3 = 'X'
122800130426     C                   eval      pxdpcd = 'DEY'
122900161013     C                   when      aadpcd4 = 'X'
123000161013     C                   eval      pxdpcd = 'DEP'
123100130426     C                   endsl
123200130426      *
123300130426     C                   eval      pxdpsv = aadpsv
123400130426      *
123500160609     C                   eval      pxstmx = aastmx
123600160927     C                   eval      pxeors = aaeors
123700160609      *
123800131107     C                   eval      pxcfse1 = aacfse1
123900131107      *
124000130426     C                   select
124100130426     C                   when      aampcd1 = 'X'
124200130426     C                   eval      pxmpcd = 'MBB'
124300130426     C                   when      aampcd2 = 'X'
124400130426     C                   eval      pxmpcd = 'MSB'
124500130426     C                   when      aampcd3 = 'X'
124600130426     C                   eval      pxmpcd = 'MBM'
124700130426     C                   endsl
124800130426      *
124900130426     C                   eval      datmdy = aabrdt
125000130426     C                   eval      ymdyyyy = mdyyyyy
125100130426     C                   eval      ymdmmdd = mdymmdd
125200130710     C                   eval      pxborefd = datymd
125300130426      *
125400130426     C                   eval      datmdy = aabrlr
125500130426     C                   eval      ymdyyyy = mdyyyyy
125600130426     C                   eval      ymdmmdd = mdymmdd
125700130426     C                   eval      pxborlrd = datymd
125800130426      *
125900130426     C                   eval      pxussp = aaussp
126000130426     C                   eval      pxshww = aashww
126100131107     C                   eval      pxcarpln = aacarpln
126200140211     C                   eval      pxmgrp# = aamgrp#
126300130426      *
126400130510     C                   eval      addflg = 'Y'
126500140916     C                   eval      recwrt = 'Y'
126600130510      *
126700130426     C                   write     plnauxr
126800130606      *
126900140214      *      Write Plan Aux Hist record
127000140214     C                   clear                   plnaxhstr
127100140214      *
127200140214     C                   eval      axtrst = pxtrst
127300140214     C                   eval      axsub# = pxsub#
127400140214     C                   eval      axplan = pxplan
127500140214      *
127600140214     C                   CLEAR                   @TIMESTAMP
127700140214     C                   MOVE      *BLANKS       @TS40
127800140214     C                   CALL      'TIMESTMP'
127900140214     C                   PARM                    @TS40
128000140214      *
128100140214     C                   movel     @TS40         @TIMESTAMP
128200140214     C                   movel     @TSUSER       axuser
128300140214     C                   move      #TSCYMD       axdate
128400140214     C                   move      #TSTIME       axtime
128500140214    * *
128600140214     C                   eval      axtype = 'A'
128700140214      *
128800140214     C                   write     plnaxhstr
128900131107      *    See if GRATE records should be written
129000141016     C                   if        pxacar <> 'N'
129100131107     C                   exsr      wrtrat
129200131107     C                   endif
129300131107      *
129400130501     C                   leavesr
129500130501      *
129600130426     C                   enddo
129700130425      *
129800130425      *
129900130425     C                   endsr
130000130509      ******************************************************************
130100130509      *       SUBROUTINE - CHGAUX                                      *
130200130509      *                    Change Plan Auxiliary Data                  *
130300130509      ******************************************************************
130400130509     C     chgaux        BEGSR
130500130509      *
130600130509     C                   clear                   auxchg
130700130509     C                   MOVEL     CONAME        TITLE
130800130509      *
130900130509     C                   eval      actrst = #KT
131000130509     C     #KT           chain     trsmst                             21
131100130509     C                   if        *in21 = '1'
131200130509     C                   eval      actname = 'INVALID TRUST#      '
131300130509     C                   exfmt     auxchg
131400130509     C                   leavesr
131500130509     C                   else
131600130509     C                   eval      actname = tname
131700130509     C                   endif
131800130509      *
131900130509     C                   eval      acsub# = #KS
132000130509     C     keyts         chain     submst                             22
132100130509     C                   if        *in22 = '1'
132200130509     C                   eval      acsname = 'INVALID TRUST/SUB#  '
132300130509     C                   exfmt     auxchg
132400130509     C                   leavesr
132500130509     C                   else
132600130509     C                   eval      acsname = subnam
132700130509     C                   endif
132800130509      *
132900130509     C                   eval      acplan = #KP
133000130509     C     keytsp        chain     plnmst                             23
133100130509     C                   if        *in23 = '1'
133200130509     C                   movel(P)  invpln        acpdesc
133300130509     C                   exfmt     auxchg
133400130509     C                   leavesr
133500130509     C                   else
133600130509     C                   eval      acpdesc = pdescr
133700130509     C                   endif
133800160927      *
133900160927     C                   eval      *in37 = '0'
134000160927     C                   if        pabfl <> 'N'
134100160927     C                   if        plncat = 'PSA' or plncat = 'PSP' or
134200160927     C                             plncat = 'PS1'
134300160927     C                   eval      *in37 = '1'
134400160927     C                   endif
134500160927     C                   endif
134600160927      *
134700140211      *      See if Coventry and ACA => Mst Grp# enabled
134800140211     C                   eval      *in87 = '0'
134900140211     C     pcarr         chain     carmst                             24
135000141114     C                   if        *in24 = '0'
135100141114     C     keycd         chain     codes                              21
135200141114     C                   if        *in21 = '0' and action = 'D'
135300141114     C                   eval      denpln = 'Y'
135400141114     C                   endif
135500141114     C                   endif
135600141114      *
135700140211     C                   if        *in24 = '0' and cgrpcd = 'CH'
135800140211      *
135900140211     C     pcarr         chain     carmst2p                           96
136000140211     C                   if        *in96 = '0' and c2acart = 'Y'
136100140211     C                   eval      *in87 = '1'
136200140211     C                   endif
136300140211     C                   endif
136400130509      *
136500140115      *
136600140115     C                   eval      *in86 = '0'
136700140115     C     keytsp        setll     mcovl1                             85
136800140115     C                   dou       *in85 = '1'
136900140115     C     keytsp        reade     mcovl1                                 85
137000140115     C                   IF        *In85 = '1'
137100140115     C                   leave
137200140115     C                   endif
137300140115      *
137400140115     C                   if        enrldt <> candt
137500140218      *
137600140218     C                   eval      *in86 = '1'
137700140115     C                   leave
137800140115     C                   endif
137900140115      *
138000140115     C                   enddo
138100140115      *
138200140115      *
138300130509     C                   movel     pxacct        acacct
138400130509     C                   if        pxacct <> 0
138500130509     C     keytsa        chain     accmst                             25
138600130509     C                   if        *in25 = '1'
138700130509     C                   movel(P)  invacc        acacnam
138800130509     C                   else
138900130509     C                   eval      acacnam = acnam1
139000130509     C                   endif
139100130509     C                   endif
139200130509      *
139300130509     C                   select
139400130509     C                   when      pxwtpd =  'WDH'
139500130509     C                   eval      acwtpd1 = 'X'
139600130509     C                   when      pxwtpd =  'WFM'
139700130509     C                   eval      acwtpd2 = 'X'
139800130509     C                   when      pxwtpd =  'WFF'
139900130509     C                   eval      acwtpd3 = 'X'
140000130509     C                   endsl
140100130509      *
140200130509     C                   eval      acwtdy = pxwtdy
140300130509      *
140400130716     C                   eval      acwtdn = pxwtdn
140500130716      *
140600130509     C                   select
140700130509     C                   when      pxrhpd =  'RDH'
140800130509     C                   eval      acrhpd1 = 'X'
140900130509     C                   when      pxrhpd =  'RFM'
141000130509     C                   eval      acrhpd2 = 'X'
141100130509     C                   when      pxrhpd =  'RFF'
141200130509     C                   eval      acrhpd3 = 'X'
141300130613     C                   when      pxrhpd =  'RNA'
141400130613     C                   eval      acrhpd4 = 'X'
141500130509     C                   endsl
141600130509      *
141700130509     C                   eval      acrhwd = pxrhwd
141800130509      *
141900130509     C                   eval      acrhdy = pxrhdy
142000130509      *
142100130509     C                   select
142200130509     C                   when      pxtrmc =  'TAD'
142300130509     C                   eval      actrmc1 = 'X'
142400130509     C                   when      pxtrmc =  'TEM'
142500130509     C                   eval      actrmc2 = 'X'
142600130509     C                   when      pxtrmc =  'TFM'
142700130509     C                   eval      actrmc3 = 'X'
142800130509     C                   when      pxtrmc =  'TDA'
142900130509     C                   eval      actrmc4 = 'X'
143000130509     C                   endsl
143100130509      *
143200160927     C                   if        *in37 = '1'
143300160927     C                   eval      aceors = pxeors
143400160927     C                   endif
143500160927      *
143600160927     C                   eval      acecon = pxecon
143700131122     C                   eval      acexchg = pxexchg
143800131206     C                   eval      acacar = pxacar
143900141016      *
144000141016     C                   eval      *in89 = '0'
144100141114     C                   eval      *in79 = '1'
144200141124     C                   if        pxacar = 'N' or pxacar = 'D'
144300141114     C                   eval      *in79 = '0'
144400141016     C                   eval      *in89 = '1'
144500141016     C                   endif
144600141016      *
144700131122     C                   eval      acgroup = pxgroup
144800130509      *
144900130509     C                   eval      acptyn = pxptyn
145000130509     C                   eval      acptlo = pxptlo
145100130509     C                   eval      acpthi = pxpthi
145200130509      *
145300130509     C                   eval      acdpmx = pxdpmx
145400130509      *
145500130509     C                   select
145600130509     C                   when      pxdpcd =  'DBD'
145700130509     C                   eval      acdpcd1 = 'X'
145800130509     C                   when      pxdpcd =  'DEM'
145900130509     C                   eval      acdpcd2 = 'X'
146000130509     C                   when      pxdpcd =  'DEY'
146100130509     C                   eval      acdpcd3 = 'X'
146200161013     C                   when      pxdpcd =  'DEP'
146300161013     C                   eval      acdpcd4 = 'X'
146400130509     C                   endsl
146500130509      *
146600130509     C                   eval      acdpsv = pxdpsv
146700160609      *
146800160609     C                   eval      acstmx = pxstmx
146900130509      *
147000131107     C                   eval      accfse1 = pxcfse1
147100131107      *
147200130710     C                   if        pxborefd = 0
147300130509     C                   eval      adbrdt = *blanks
147400130509     C                   else
147500130710     C                   eval      datymd = pxborefd
147600130509     C                   eval      mdyyyyy = ymdyyyy
147700130509     C                   eval      mdymmdd = ymdmmdd
147800130509     C                   eval      acbrdt = datmdy
147900130509     C                   endif
148000130509      *
148100130509     C                   if        pxborlrd = 0
148200130509     C                   eval      adbrlr = *blanks
148300130509     C                   else
148400130509     C                   eval      datymd = pxborlrd
148500130509     C                   eval      mdyyyyy = ymdyyyy
148600130509     C                   eval      mdymmdd = ymdmmdd
148700130509     C                   eval      acbrlr = datmdy
148800130509     C                   endif
148900130509      *
149000130509     C                   select
149100130509     C                   when      pxmpcd =  'MBB'
149200130509     C                   eval      acmpcd1 = 'X'
149300130509     C                   when      pxmpcd =  'MSB'
149400130509     C                   eval      acmpcd2 = 'X'
149500130509     C                   when      pxmpcd =  'MBM'
149600130509     C                   eval      acmpcd2 = 'X'
149700130509     C                   endsl
149800130509      *
149900130509     C                   eval      acussp = pxussp
150000130509     C                   eval      acshww = pxshww
150100140211     C   87              eval      acmgrp# = pxmgrp#
150200140211     C                   eval      accarpln = pxcarpln
150300130624     C                   movel(P)  xmsg          acmsg
150400130509      *
150500130509     C                   DOU       *IN01 = '1'
150600130509      *
150700130509     C                   exfmt     auxchg
150800130509      *
150900130509     C                   movel     *blanks       acmsg
151000130509     C                   eval      *in81 = '0'
151100130712     C                   eval      *in41 = '0'
151200130716     C                   eval      *in42 = '0'
151300130712     C                   eval      *in46 = '0'
151400130509     C                   eval      *in47 = '0'
151500130509     C                   eval      *in48 = '0'
151600130509     C                   eval      *in49 = '0'
151700130509     C                   eval      *in50 = '0'
151800130509     C                   eval      *in51 = '0'
151900130509     C                   eval      *in52 = '0'
152000130509     C                   eval      *in53 = '0'
152100130509     C                   eval      *in54 = '0'
152200130509     C                   eval      *in55 = '0'
152300130509     C                   eval      *in56 = '0'
152400130509     C                   eval      *in57 = '0'
152500130509     C                   eval      *in58 = '0'
152600130509     C                   eval      *in59 = '0'
152700130509     C                   eval      *in60 = '0'
152800130509     C                   eval      *in61 = '0'
152900131122     C                   eval      *in62 = '0'
153000131122     C                   eval      *in63 = '0'
153100131122     C                   eval      *in65 = '0'
153200131220     C                   eval      *in66 = '0'
153300131206     C                   eval      *in67 = '0'
153400160609     C                   eval      *in68 = '0'
153500160927     C                   eval      *in69 = '0'
153600140211     C                   eval      *in70 = '0'
153700130509      *      Command Keys?
153800130509     C                   if        *in01 = '1' or *in07 = '1'
153900130509     C                   leavesr
154000130509     C                   endif
154100131126      *
154200130509     C                   if        *in04 = '1'
154300130509     C                   clear                   auxadd
154400130509     C                   MOVEL     CONAME        TITLE
154500130509     C                   iter
154600130509     C                   endif
154700141114      *
154800141114     C                   IF        *IN06 = *ON
154900141114     C                   exsr      acasel
155000141114     C                   movel(P)  wacac         acacar
155100141114     C                   MOVE      *Off          *IN06
155200141114     C                   endif
155300130509      *
155400131126     C                   if        *in11 = '1'
155500131126     C                   EVAL      @ENTPRM = ' '
155600131126     C                   CALL      'FM036R'
155700131126     C                   PARM                    @ENTPRM
155800131126    * *
155900131126    1C****               IF        @ENTPRM = '*'
156000131126     C****               LEAVESR
156100131126    1C****               ENDIF
156200131126    * *
156300131126    1C                   IF        @ENTPRM = 'A' or @ENTPRM = 'B' or
156400131126    1C                             @ENTPRM = 'C'
156500131126     C                   eval      accfse1 = @ENTPRM
156600131126    1C                   ENDIF
156700131220    * *        Position cursor
156800131220     C                   eval      *in66 = '1'
156900131126    * *
157000131126     C                   eval      *in11 = '0'
157100131126    1C                   iter
157200131126    1C                   ENDIF
157300131126      *
157400130509      *      Edit entry fields
157500130509      *
157600130927     C                   if        acwtdn <> 'Y'
157700130509     C                   if        cwtpd3 <> 'X  ' and cwtpd3 <> ' X ' and
157800130509     C                             cwtpd3 <> '  X'
157900130509     C                   movel(P)  wtpderr       acmsg
158000130509     C                   eval      *in81 = '1'
158100130509     C                   eval      *in46 = '1'
158200130509     C                   iter
158300130509     C                   endif
158400130927     C                   endif
158500130712      *
158600130712     C                   if        acwtpd3= 'X' and acwtdy = 0
158700130712     C                   movel(P)  wtdyerr       acmsg
158800130712     C                   eval      *in81 = '1'
158900130712     C                   eval      *in41 = '1'
159000130712     C                   iter
159100130712     C                   endif
159200130716      *
159300131108     C                   if        acwtdn <> 'Y'and acwtdn <> 'N' and
159400131108     C                             cwtpd3 = '   '
159500130716     C                   movel(P)  wtdnerr       acmsg
159600130716     C                   eval      *in81 = '1'
159700130716     C                   eval      *in42 = '1'
159800130716     C                   iter
159900130716     C                   endif
160000130509      *
160100130613     C                   if        crhpd4 <> 'X   ' and crhpd4 <> ' X  ' and
160200130613     C                             crhpd4 <> '  X ' and crhpd4 <> '   X'
160300130624     C                   movel(P)  *blanks       acmsg
160400130624     C                   eval      acmsg = rhpderr + 'd'
160500130509     C                   eval      *in81 = '1'
160600130509     C                   eval      *in47 = '1'
160700130509     C                   iter
160800130509     C                   endif
160900130509      *
161000130925     C******             if        acrhwd > 150
161100130925     C**                 movel(P)  rhwderr       acmsg
161200130925     C**                 eval      *in81 = '1'
161300130925     C**                 eval      *in48 = '1'
161400130925     C***                iter
161500130925     C******             endif
161600130509      *
161700130509     C                   if        trcc4 <> 'X   ' and trcc4 <> ' X  ' and
161800130509     C                             trcc4 <> '  X ' and trcc4 <> '   X'
161900130509     C                   movel(P)  trmcerr       acmsg
162000130509     C                   eval      *in81 = '1'
162100130509     C                   eval      *in49 = '1'
162200130509     C                   iter
162300130509     C                   endif
162400130509      *
162500130509     C                   if        acecon > 100
162600130509     C                   movel(P)  econerr       acmsg
162700130509     C                   eval      *in81 = '1'
162800130509     C                   eval      *in50 = '1'
162900130509     C                   iter
163000130509     C                   endif
163100160927      *
163200160927     C                   if        *in37 = '1'
163300160927     C                   if        aceors <> 'E' and aceors <> 'S'
163400160927     C                   movel(P)  eoserr        acmsg
163500160927     C                   eval      *in81 = '1'
163600160927     C                   eval      *in69 = '1'
163700160927     C                   iter
163800160927     C                   endif
163900160927     C                   endif
164000130509      *
164100131122     C                   if        acexchg <> 'Y' and acexchg <> 'N'
164200131122     C                   movel(P)  excherr       acmsg
164300130509     C                   eval      *in81 = '1'
164400131122     C                   eval      *in65 = '1'
164500130509     C                   iter
164600130509     C                   endif
164700131206      *
164800141204     C                   if        acacar <> pxacar
164900141204     C                   if        acacar <> 'Y' and acacar <> 'C'
165000131206     C                   movel(P)  acaerr        acmsg
165100131206     C                   eval      *in81 = '1'
165200131206     C                   eval      *in67 = '1'
165300131206     C                   iter
165400131206     C                   endif
165500141204     C                   endif
165600131122      *
165700131122     C                   if        acptyn <> 'Y' and acptyn <> 'N'
165800131122     C                   movel(P)  ptynerr       acmsg
165900131122     C                   eval      *in81 = '1'
166000131122     C                   eval      *in51 = '1'
166100131122     C                   iter
166200131122     C                   endif
166300130509      *
166400130509     C                   if        acptyn = 'Y' and
166500130509     C                             (acptlo = 0 or acpthi = 0)
166600130509     C                   movel(P)  pthlerr       acmsg
166700130509     C                   eval      *in81 = '1'
166800130509     C                   eval      *in52 = '1'
166900130509     C                   iter
167000130509     C                   endif
167100130509      *
167200130925     C*****              if        acptyn = 'Y'
167300130925     C**                 if        acptlo < 20 or acptlo > 40
167400130925     C**                 movel(P)  ptloerr       acmsg
167500130925     C**                 eval      *in81 = '1'
167600130925     C**                 eval      *in52 = '1'
167700130925     C**                 iter
167800130925     C**                 endif
167900130509      *
168000130925     C**                 if        acpthi < 20 or acpthi > 40
168100130925     C**                 movel(P)  pthierr       acmsg
168200130925     C**                 eval      *in81 = '1'
168300130925     C**                 eval      *in53 = '1'
168400130925     C**                 iter
168500130925     C***                endif
168600130925     C*****              endif
168700130509      *   Per SR - no max Dep max age
168800130509     C********           if        aadpmx > 26
168900130509     C*****              movel(P)  dpmxerr       aamsg
169000130509     C*****              eval      *in81 = '1'
169100130509     C*****              eval      *in54 = '1'
169200130509     C*****              iter
169300130509     C********           endif
169400130509      *
169500161013     C                   if        cdpcd4 <> 'X   ' and cdpcd4 <> ' X  ' and
169600161013     C                             cdpcd4 <> '  X ' and cdpcd4 <> '    ' and
169700161013     C                             cdpcd4 <> '   X'
169800130509     C                   movel(P)  dpcderr       acmsg
169900130509     C                   eval      *in81 = '1'
170000130509     C                   eval      *in55 = '1'
170100130509     C                   iter
170200130509     C                   endif
170300130509      *
170400130509     C                   if        acdpsv <> 'Y' and acdpsv <> 'N' and
170500130509     C                             acdpsv <> ' '
170600130509     C                   movel(P)  dpsverr       acmsg
170700130509     C                   eval      *in81 = '1'
170800130509     C                   eval      *in56 = '1'
170900130509     C                   iter
171000130509     C                   endif
171100160609      *
171200160609     C                   if        acdpsv = 'Y' and acstmx = 0
171300160609     C                   movel(P)  stmxerr       acmsg
171400160609     C                   eval      *in81 = '1'
171500160609     C                   eval      *in68 = '1'
171600160609     C                   iter
171700160609     C                   endif
171800160610      *
171900160610     C                   if        acdpsv = 'N' and acstmx > 0
172000160610     C                   movel(P)  stmxerx       acmsg
172100160610     C                   eval      *in81 = '1'
172200160610     C                   eval      *in68 = '1'
172300160610     C                   iter
172400160610     C                   endif
172500131107      *
172600131107     C                   if        accfse1 <> 'A' and accfse1 <> 'B' and
172700131107     C                             accfse1 <> 'C' and accfse1 <> ' '
172800131107     C                   movel(P)  cfseerr       acmsg
172900131107     C                   eval      *in81 = '1'
173000131107     C                   eval      *in63 = '1'
173100131107     C                   iter
173200131107     C                   endif
173300131108      *          If CFS plan aacfse1 can't be blank
173400131108     C     pcarr         chain     carmst                             24
173500131108     C                   if        *in24 = '0' and cgrpcd = 'CF'
173600131219      *            Not mandatory per Shelly
173700131219     C****####           if        accfse1 = ' '
173800131219     C***                movel(P)  cfseerr1      acmsg
173900131219     C***                eval      *in81 = '1'
174000131219     C***                eval      *in63 = '1'
174100131219     C***                iter
174200131219     C****####           endif
174300131108     C                   endif
174400131108      *
174500131107      *
174600130509      *
174700130509     C                   if        acbrdt <> 0
174800130509     C     *USA          test(D)                 acbrdt                 57
174900130509     C                   if        *in57 = '1'
175000130509     C                   movel(P)  brdterr       acmsg
175100130509     C                   eval      *in81 = '1'
175200130509     C                   iter
175300130509     C                   endif
175400130509     C                   endif
175500130509      *
175600130509     C                   if        acbrlr <> 0
175700130509     C     *USA          test(D)                 acbrlr                 58
175800130509     C                   if        *in58 = '1'
175900130509     C                   movel(P)  brlrerr       acmsg
176000130509     C                   eval      *in81 = '1'
176100130509     C                   iter
176200130509     C                   endif
176300130509     C                   endif
176400130509      *
176500130509     C                   if        (acbrlr <> 0 and acbrdt = 0) or
176600130509     C                             (acbrdt <> 0 and acbrlr = 0)
176700130509     C                   eval      *in57 = '1'
176800130509     C                   movel(P)  brsserr       acmsg
176900130509     C                   eval      *in81 = '1'
177000130509     C                   iter
177100130509     C                   endif
177200130509      *
177300130510     C                   eval      datmdy = acbrdt
177400130510     C                   eval      ymdyyyy = mdyyyyy
177500130510     C                   eval      ymdmmdd = mdymmdd
177600130710     C                   eval      svborefd = datymd
177700130510     C                   eval      datmdy = acbrlr
177800130510     C                   eval      ymdyyyy = mdyyyyy
177900130510     C                   eval      ymdmmdd = mdymmdd
178000130510     C                   eval      svborlrd = datymd
178100130913      *
178200130924     C                   if        borlrdmm <> prenew and prenew <> 0 and
178300130924     C                             borlrdmm <> 0
178400130913     C                   eval      *in58 = '1'
178500130913     C                   eval      acmsg = *blanks
178600130913     C                   eval      acmsg = brlmerr + 'lan Renew Month'
178700130913     C                   eval      *in81 = '1'
178800130913     C                   iter
178900130913     C                   endif
179000130510      *
179100130823     C                   if        svborefd < svborlrd
179200130509     C                   eval      *in57 = '1'
179300130716     C                   eval      acmsg = *blanks
179400130823     C                   eval      acmsg = brleerr + ' Date'
179500130509     C                   eval      *in81 = '1'
179600130509     C                   iter
179700130509     C                   endif
179800130509      *
179900130509     C                   if        cmpcd3 <> 'X  ' and cmpcd3 <> ' X ' and
180000130509     C                             cmpcd3 <> '  X' and cmpcd3 <> '   '
180100130509     C                   movel(P)  mpcderr       acmsg
180200130509     C                   eval      *in81 = '1'
180300130509     C                   eval      *in59 = '1'
180400130509     C                   iter
180500130509     C                   endif
180600130509      *
180700130509     C                   if        acussp <> 'Y' and acussp <> 'N' and
180800130509     C                             acussp <> ' '
180900130509     C                   movel(P)  ussperr       acmsg
181000130509     C                   eval      *in81 = '1'
181100130509     C                   eval      *in60 = '1'
181200130509     C                   iter
181300130509     C                   endif
181400130509      *
181500130509     C                   if        acshww <> 'Y' and acshww <> 'N'
181600130509     C                   movel(P)  shwwerr       acmsg
181700130509     C                   eval      *in81 = '1'
181800130509     C                   eval      *in61 = '1'
181900130509     C                   iter
182000130509     C                   endif
182100140211      *
182200140211     C                   if        *in87 = '1' and acmgrp# = *blanks
182300140211     C                   movel(P)  mgrperr       acmsg
182400140211     C                   eval      *in81 = '1'
182500140211     C                   eval      *in70 = '1'
182600140211     C                   iter
182700140211     C                   endif
182800160818      *    Per Candace - allow for trust 005
182900160818     C                   if        actrst <> 005
183000131114      *
183100131114     C                   if        accarpln <> *blanks and
183200131114     C                             acgroup = *blanks
183300131114     C                   movel(P)  grpcerr       acmsg
183400131114     C                   eval      *in81 = '1'
183500131114     C                   eval      *in62 = '1'
183600131114     C                   iter
183700131114     C                   endif
183800131114      *
183900131114     C                   if        accarpln = *blanks and
184000131114     C                             acgroup <> *blanks
184100131114     C                   movel(P)  grpcerr       acmsg
184200131114     C                   eval      *in81 = '1'
184300131114     C                   eval      *in62 = '1'
184400131114     C                   iter
184500131114     C                   endif
184600140106      *
184700160818     C                   endif
184800160818      *
184900140211      *       Check for valid Carrier Plan ID
185000140211     C                   if        accarpln <> *blanks
185100140211     C                   movel(P)  cgrpcd        k20grp
185200140211     C     co20ky        chain     code20p                            21
185300140211     C                   if        *in21 = '1'
185400150325     C                   movel(P)  carperr       acmsg
185500140211     C                   eval      *in81 = '1'
185600140211     C                   eval      *in66 = '1'
185700140211     C                   iter
185800140211     C                   else
185900140211      *
186000140211     C                   if        c20actn1 <> 'ENTITY    '
186100140211     C                   movel(P)  c20actn1      arkcar
186200140211     C                   else
186300140211     C                   select
186400140211     C                   when      accfse1 = 'A'
186500140211     C                   movel(P)  'BLUEC'       arkcar
186600140211     C                   when      accfse1 = 'B'
186700140211     C                   movel(P)  'CFMI'        arkcar
186800140211     C                   when      accfse1 = 'C'
186900140211     C                   movel(P)  'GHMSI'       arkcar
187000140211     C                   endsl
187100140211     C                   endif
187200140211      *
187300140211     C                   movel(P)  accarpln      arkpln
187400140211     C                   eval      arkpln = %TRIM(accarpln)
187500150126      *
187600150126     C                   if        acexchg <> 'Y'
187700150126      *
187800140211     C     agrtky        chain     ratef
187900140211     C                   if        NOT %FOUND(ageratel1)
188000150127      *
188100150127     C******             if        accfse1 = 'B'
188200150127     C***                movel(P)  'BCBSM'       arkcar
188300150127     C***  agrtky        chain     ratef
188400150127     C******             if        NOT %FOUND(ageratel1)
188500150127      *
188600140211     C                   movel(P)  carperr       acmsg
188700140211     C                   eval      *in81 = '1'
188800140211     C                   eval      *in66 = '1'
188900140211     C                   iter
189000150127     C****               endif
189100150127     C****               endif
189200150127     C                   endif
189300150126     C                   else
189400150126      *
189500150126     C     agrtky        chain     ratefx
189600150126     C                   if        NOT %FOUND(exagerate)
189700150127      *
189800150127     C*****              if        accfse1 = 'B'
189900150127     C**                 movel(P)  'BCBSM'       arkcar
190000150127     C**   agrtky        chain     ratef
190100150127     C********           if        NOT %FOUND(ageratel1)
190200150127      *
190300150126     C                   movel(P)  carperr       acmsg
190400150126     C                   eval      *in81 = '1'
190500150126     C                   eval      *in66 = '1'
190600150126     C                   iter
190700150127     C*****              endif
190800150127     C*****              endif
190900150127     C                   endif
191000150126      *
191100150126     C                   endif
191200150126      *
191300140211     C                   endif
191400140211     C                   endif
191500130509      *
191600130509      *      All fields have valid data - change PLNAUX record
191700161014      *
191800161014     C                   eval      cvxflg = 'N'
191900161014      *
192000161014     C                   exsr      setcom
192100161014      *
192200161014     C                   if        pxacct <> acacct
192300161014     C                   eval      axfld = 'Account Number '
192400161014     C                   movel(P)  pxacct        axfrom
192500161014     C                   movel(P)  acacct        axto
192600161014     C                   write     plnaxhstr
192700161014     C                   eval      chgflg = 'Y'
192800161014     C                   eval      pxacct = acacct
192900161014     C                   endif
193000161014      *
193100161014     C                   select
193200161014     C                   when      acwtpd1 = 'X'
193300161014     C                   eval      svwtpd = 'WDH'
193400161014     C                   when      acwtpd2 = 'X'
193500130606     C                   eval      svwtpd = 'WFM'
193600130509     C                   when      acwtpd3 = 'X'
193700130606     C                   eval      svwtpd = 'WFF'
193800130509     C                   endsl
193900130509      *
194000130606     C                   if        pxwtpd <> svwtpd
194100130606     C                   eval      axfld = 'Waiting Period '
194200130607      *
194300130607     C                   select
194400130607     C                   when      pxwtpd = 'WDH'
194500130607     C                   movel(P)  'DOH'         axfrom
194600130607     C                   when      pxwtpd = 'WFM'
194700130613     C                   movel(P)  'FOM'         axfrom
194800130607     C                   when      pxwtpd = 'WFF'
194900130607     C                   eval      axfrom = '1st Day after'
195000130607     C                   endsl
195100130607      *
195200130607     C                   select
195300130607     C                   when      svwtpd = 'WDH'
195400130607     C                   movel(P)  'DOH'         axto
195500130607     C                   when      svwtpd = 'WFM'
195600130613     C                   movel(P)  'FOM'         axto
195700130607     C                   when      svwtpd = 'WFF'
195800130607     C                   eval      axto = '1st Day after'
195900130607     C                   endsl
196000130607      *
196100130606     C                   write     plnaxhstr
196200130606     C                   eval      chgflg = 'Y'
196300130606     C                   eval      pxwtpd = svwtpd
196400130606     C                   endif
196500130606      *
196600130606     C                   if        pxwtdy <> acwtdy
196700130606     C                   eval      axfld = 'Wait Per Days  '
196800130613     C                   movel(P)  pxwtdy        axfrom
196900130613     C                   movel(P)  acwtdy        axto
197000130606     C                   write     plnaxhstr
197100130606     C                   eval      chgflg = 'Y'
197200130606     C                   eval      pxwtdy = acwtdy
197300130606     C                   endif
197400130716      *
197500130716     C                   if        pxwtdn <> acwtdn
197600130716     C                   eval      axfld = 'See Diary Notes'
197700130716     C                   movel(P)  pxwtdn        axfrom
197800130716     C                   movel(P)  acwtdn        axto
197900130716     C                   write     plnaxhstr
198000130716     C                   eval      chgflg = 'Y'
198100130716     C                   eval      pxwtdn = acwtdn
198200130716     C                   endif
198300130509      *
198400130606     C                   if        pxrhwd <> acrhwd
198500130606     C                   eval      axfld = 'Rehire Within  '
198600130613     C                   movel(P)  pxrhwd        axfrom
198700130613     C                   movel(P)  acrhwd        axto
198800130606     C                   write     plnaxhstr
198900130606     C                   eval      chgflg = 'Y'
199000130606     C                   eval      pxrhwd = acrhwd
199100130606     C                   endif
199200130606      *
199300130509     C                   select
199400130509     C                   when      acrhpd1 = 'X'
199500130606     C                   eval      svrhpd = 'RDH'
199600130509     C                   when      acrhpd2 = 'X'
199700130606     C                   eval      svrhpd = 'RFM'
199800130509     C                   when      acrhpd3 = 'X'
199900130606     C                   eval      svrhpd = 'RFF'
200000130613     C                   when      acrhpd4 = 'X'
200100130613     C                   eval      svrhpd = 'RNA'
200200130509     C                   endsl
200300130606      *
200400130606     C                   if        pxrhpd <> svrhpd
200500130613     C                   eval      axfld = 'Rehire Wait PD '
200600130607     C****               movel     pxrhpd        axfrom
200700130607     C****               movel     svrhpd        axto
200800130607      *
200900130607     C                   select
201000130607     C                   when      pxrhpd = 'RDH'
201100130607     C                   movel(P)  'DOR'         axfrom
201200130607     C                   when      pxrhpd = 'RFM'
201300130614     C                   movel(P)  'FOM'         axfrom
201400130607     C                   when      pxrhpd = 'RFF'
201500130607     C                   eval      axfrom = '1st Day after'
201600130613     C                   when      pxrhpd = 'RNA'
201700130613     C                   movel(P)  'N/A      '   axfrom
201800130607     C                   endsl
201900130607      *
202000130607     C                   select
202100130607     C                   when      svrhpd = 'RDH'
202200130607     C                   movel(P)  'DOR'         axto
202300130607     C                   when      svrhpd = 'RFM'
202400130614     C                   movel(P)  'FOM'         axto
202500130607     C                   when      svrhpd = 'RFF'
202600130607     C                   eval      axto = '1st Day after'
202700130613     C                   when      svrhpd = 'RNA'
202800130613     C                   movel(P)  'N/A      '   axto
202900130607     C                   endsl
203000130607      *
203100130606     C                   write     plnaxhstr
203200130606     C                   eval      chgflg = 'Y'
203300130606     C                   eval      pxrhpd = svrhpd
203400130606     C                   endif
203500130509      *
203600130606     C                   if        pxrhdy <> acrhdy
203700130606     C                   eval      axfld = 'Rehire Days    '
203800130613     C                   movel(P)  pxrhdy        axfrom
203900130613     C                   movel(P)  acrhdy        axto
204000130606     C                   write     plnaxhstr
204100130606     C                   eval      chgflg = 'Y'
204200130606     C                   eval      pxrhdy = acrhdy
204300130606     C                   endif
204400130509      *
204500130509     C                   select
204600130509     C                   when      actrmc1 = 'X'
204700130606     C                   eval      svtrmc = 'TAD'
204800130509     C                   when      actrmc2 = 'X'
204900130606     C                   eval      svtrmc = 'TEM'
205000130509     C                   when      actrmc3 = 'X'
205100130606     C                   eval      svtrmc = 'TFM'
205200130509     C                   when      actrmc4 = 'X'
205300130606     C                   eval      svtrmc = 'TDA'
205400130509     C                   endsl
205500130509      *
205600130606     C                   if        pxtrmc <> svtrmc
205700130606     C                   eval      axfld = 'Term Code      '
205800130607      *
205900130607     C                   select
206000130607     C                   when      pxtrmc = 'TAD'
206100130607     C                   movel(P)  'Day of Term' axfrom
206200130607     C                   when      pxtrmc = 'TEM'
206300130607     C                   movel(P)  'EOM'         axfrom
206400130607     C                   when      pxtrmc = 'TFM'
206500130607     C                   movel(P)  'FOM'         axfrom
206600130607     C                   when      pxtrmc = 'TDA'
206700130607     C                   eval      axfrom = 'Day After Term '
206800130607     C                   endsl
206900130607      *
207000130607     C                   select
207100130607     C                   when      svtrmc = 'TAD'
207200130607     C                   movel(P)  'Day of Term' axto
207300130607     C                   when      svtrmc = 'TEM'
207400130607     C                   movel(P)  'EOM'         axto
207500130607     C                   when      svtrmc = 'TFM'
207600130607     C                   movel(P)  'FOM'         axto
207700130607     C                   when      svtrmc = 'TDA'
207800130607     C                   eval      axto = 'Day After Term '
207900130607     C                   endsl
208000130607      *
208100130606     C                   write     plnaxhstr
208200130606     C                   eval      chgflg = 'Y'
208300130606     C                   eval      pxtrmc = svtrmc
208400130606     C                   endif
208500130606      *
208600130606     C                   if        pxecon <> acecon
208700130606     C                   eval      axfld = 'Emplr Cont%    '
208800130613     C                   movel(P)  pxecon        axfrom
208900130613     C                   movel(P)  acecon        axto
209000130606     C                   write     plnaxhstr
209100130606     C                   eval      chgflg = 'Y'
209200130606     C                   eval      pxecon = acecon
209300130606     C                   endif
209400160927      *
209500160927     C                   if        pxeors <> aceors
209600160927     C                   eval      axfld = 'Age Based      '
209700160927     C                   movel(P)  pxeors        axfrom
209800160927     C                   movel(P)  aceors        axto
209900160927     C                   write     plnaxhstr
210000160927     C                   eval      chgflg = 'Y'
210100160927     C                   eval      pxeors = aceors
210200160927     C                   endif
210300131107      *
210400131122     C                   if        pxexchg <> acexchg
210500131122     C                   eval      axfld = 'Exchange       '
210600131122     C                   movel(P)  pxexchg       axfrom
210700131122     C                   movel(P)  acexchg       axto
210800131107     C                   write     plnaxhstr
210900131107     C                   eval      chgflg = 'Y'
211000131122     C                   eval      pxexchg = acexchg
211100131107     C                   endif
211200131206      *
211300131206     C                   if        pxacar <> acacar
211400131206     C                   eval      axfld = 'ACA Rating     '
211500131206     C                   movel(P)  pxacar        axfrom
211600131206     C                   movel(P)  acacar        axto
211700131206     C                   write     plnaxhstr
211800131206     C                   eval      chgflg = 'Y'
211900131206     C                   eval      pxacar = acacar
212000131206     C                   endif
212100131122      *
212200131217     C                   eval      chkrtf = 'N'
212300131122     C                   if        pxgroup <> acgroup
212400131122     C                   eval      axfld = 'Group#         '
212500131122     C                   movel(P)  pxgroup       axfrom
212600131122     C                   movel(P)  acgroup       axto
212700131122     C                   write     plnaxhstr
212800131122     C                   eval      chgflg = 'Y'
212900140214     C                   eval      cvxflg = 'Y'
213000131122     C                   eval      pxgroup = acgroup
213100131217     C                   eval      chkrtf = 'Y'
213200131122     C                   endif
213300130606      *
213400130606     C                   if        pxptyn <> acptyn
213500130606     C                   eval      axfld = 'Part Time Y/N  '
213600130613     C                   movel(P)  pxptyn        axfrom
213700130613     C                   movel(P)  acptyn        axto
213800130606     C                   write     plnaxhstr
213900130606     C                   eval      chgflg = 'Y'
214000130606     C                   eval      pxptyn = acptyn
214100130606     C                   endif
214200130606      *
214300130606     C                   if        pxptlo <> acptlo
214400130606     C                   eval      axfld = 'PT Low Range   '
214500130925     C                   eval      axfrom = %editc(pxptlo:'3')
214600130925     C                   eval      axto = %editc(acptlo:'3')
214700130606     C                   write     plnaxhstr
214800130606     C                   eval      chgflg = 'Y'
214900130606     C                   eval      pxptlo = acptlo
215000130606     C                   endif
215100130606      *
215200130606     C                   if        pxpthi <> acpthi
215300130606     C                   eval      axfld = 'PT High Range  '
215400130925     C                   eval      axfrom = %editc(pxpthi:'3')
215500130925     C                   eval      axto = %editc(acpthi:'3')
215600130606     C                   write     plnaxhstr
215700130606     C                   eval      chgflg = 'Y'
215800130606     C                   eval      pxpthi = acpthi
215900130606     C                   endif
216000130606      *
216100130606     C                   if        pxdpmx <> acdpmx
216200130606     C                   eval      axfld = 'Dep Max Age    '
216300130613     C                   movel(P)  pxdpmx        axfrom
216400130613     C                   movel(P)  acdpmx        axto
216500130606     C                   write     plnaxhstr
216600130606     C                   eval      chgflg = 'Y'
216700130606     C                   eval      pxdpmx = acdpmx
216800130606     C                   endif
216900130509      *
217000130509     C                   select
217100130509     C                   when      acdpcd1 = 'X'
217200130606     C                   eval      svdpcd = 'DBD'
217300130509     C                   when      acdpcd2 = 'X'
217400130606     C                   eval      svdpcd = 'DEM'
217500130606     C                   when      acdpcd3 = 'X'
217600130606     C                   eval      svdpcd = 'DEY'
217700161013     C                   when      acdpcd4 = 'X'
217800161013     C                   eval      svdpcd = 'DEP'
217900130509     C                   endsl
218000130606      *
218100130606     C                   if        pxdpcd <> svdpcd
218200130606     C                   eval      axfld = 'Dep Ends Code  '
218300130607      *
218400130607     C                   select
218500130607     C                   when      pxdpcd = 'DBD'
218600130607     C                   movel(P)  'DOB'         axfrom
218700130607     C                   when      pxdpcd = 'DEM'
218800130607     C                   movel(P)  'EOM'         axfrom
218900130607     C                   when      pxdpcd = 'DEY'
219000130607     C                   movel(P)  'EOY'         axfrom
219100161013     C                   when      pxdpcd = 'DEP'
219200161013     C                   movel(P)  'EOP'         axfrom
219300130607     C                   endsl
219400130607      *
219500130607     C                   select
219600130607     C                   when      svdpcd = 'DBD'
219700130607     C                   movel(P)  'DOB'         axto
219800130607     C                   when      svdpcd = 'DEM'
219900130607     C                   movel(P)  'EOM'         axto
220000130607     C                   when      svdpcd = 'DEY'
220100130607     C                   movel(P)  'EOY'         axto
220200161013     C                   when      svdpcd = 'DEP'
220300161013     C                   movel(P)  'EOP'         axto
220400130607     C                   endsl
220500130607      *
220600130606     C                   write     plnaxhstr
220700130606     C                   eval      chgflg = 'Y'
220800130606     C                   eval      pxdpcd = svdpcd
220900130606     C                   endif
221000130509      *
221100130606     C                   if        pxdpsv <> acdpsv
221200130606     C                   eval      axfld = 'Student Vefify '
221300130613     C                   movel(P)  pxdpsv        axfrom
221400130613     C                   movel(P)  acdpsv        axto
221500130606     C                   write     plnaxhstr
221600130606     C                   eval      chgflg = 'Y'
221700130606     C                   eval      pxdpsv = acdpsv
221800130606     C                   endif
221900160609      *
222000160609     C                   if        pxstmx <> acstmx
222100160609     C                   eval      axfld = 'Student Max age'
222200160609     C                   movel(P)  pxstmx        axfrom
222300160609     C                   movel(P)  acstmx        axto
222400160609     C                   write     plnaxhstr
222500160609     C                   eval      chgflg = 'Y'
222600160609     C                   eval      pxstmx = acstmx
222700160609     C                   endif
222800131107      *
222900131107     C                   if        pxcfse1 <> accfse1
223000131107     C                   eval      axfld = 'CFS Entity     '
223100131107     C                   movel(P)  pxcfse1       axfrom
223200131107     C                   movel(P)  accfse1       axto
223300131107     C                   write     plnaxhstr
223400131107     C                   eval      chgflg = 'Y'
223500131107     C                   eval      pxcfse1 = accfse1
223600131107     C                   endif
223700130509      *
223800130509     C                   select
223900130509     C                   when      acmpcd1 = 'X'
224000130606     C                   eval      svmpcd = 'MBB'
224100130509     C                   when      acmpcd2 = 'X'
224200130606     C                   eval      svmpcd = 'MSB'
224300130509     C                   when      acmpcd3 = 'X'
224400130606     C                   eval      svmpcd = 'MBM'
224500130509     C                   endsl
224600130509      *
224700130606     C                   if        pxmpcd <> svmpcd
224800130606     C                   eval      axfld = 'Multiplier PBV '
224900130613     C                   movel(P)  pxmpcd        axfrom
225000130613     C                   movel(P)  svmpcd        axto
225100130606     C                   write     plnaxhstr
225200130606     C                   eval      chgflg = 'Y'
225300130606     C                   eval      pxmpcd = svmpcd
225400130606     C                   endif
225500130606      *
225600130509     C                   eval      datmdy = acbrdt
225700130509     C                   eval      ymdyyyy = mdyyyyy
225800130509     C                   eval      ymdmmdd = mdymmdd
225900130710     C                   if        pxborefd <> datymd
226000130710     C                   eval      axfld = 'BOR Eff Date   '
226100130710     C                   movel(P)  pxborefd      axfrom
226200130613     C                   movel(P)  datymd        axto
226300130606     C                   write     plnaxhstr
226400130606     C                   eval      chgflg = 'Y'
226500130710     C                   eval      pxborefd = datymd
226600130606     C                   endif
226700130509      *
226800130509     C                   eval      datmdy = acbrlr
226900130509     C                   eval      ymdyyyy = mdyyyyy
227000130509     C                   eval      ymdmmdd = mdymmdd
227100130606     C                   if        pxborlrd <> datymd
227200130606     C                   eval      axfld = 'BOR Last Renew '
227300130613     C                   movel(P)  pxborlrd      axfrom
227400130613     C                   movel(P)  datymd        axto
227500130606     C                   write     plnaxhstr
227600130606     C                   eval      chgflg = 'Y'
227700130606     C                   eval      pxborlrd = datymd
227800130606     C                   endif
227900130509      *
228000130606     C                   if        pxussp <> acussp
228100130606     C                   eval      axfld = 'Use Spouse DOB '
228200130613     C                   movel(P)  pxussp        axfrom
228300130613     C                   movel(P)  acussp        axto
228400130606     C                   write     plnaxhstr
228500130606     C                   eval      chgflg = 'Y'
228600130606     C                   eval      pxussp = acussp
228700130606     C                   endif
228800130606      *
228900130606     C                   if        pxshww <> acshww
229000130606     C                   eval      axfld = 'Show on WEB    '
229100130613     C                   movel(P)  pxshww        axfrom
229200130613     C                   movel(P)  acshww        axto
229300130606     C                   write     plnaxhstr
229400130606     C                   eval      chgflg = 'Y'
229500130606     C                   eval      pxshww = acshww
229600130606     C                   endif
229700140211      *
229800140211     C                   if        pxmgrp# <> acmgrp#
229900140211     C                   eval      axfld = 'Master Group#  '
230000140211     C                   movel(P)  pxmgrp#       axfrom
230100140211     C                   movel(P)  acmgrp#       axto
230200140211     C                   write     plnaxhstr
230300140211     C                   eval      chgflg = 'Y'
230400140214     C                   eval      cvxflg = 'Y'
230500140211     C                   eval      pxmgrp# = acmgrp#
230600140211     C                   endif
230700131107      *
230800131107     C                   if        pxcarpln <> accarpln
230900131107     C                   eval      axfld = 'Carrier Plan ID'
231000131107     C                   movel(P)  'Old'         axfrom
231100131107     C                   movel(P)  'New'         axto
231200131107     C                   write     plnaxhstr
231300131107     C                   eval      chgflg = 'Y'
231400131107     C                   eval      pxcarpln = accarpln
231500131107     C                   endif
231600130510      *
231700130606     C                   if        chgflg = 'Y'
231800130509     C                   update    plnauxr
231900131217      *
232000160413     c     planIDkey     setll     planSetup
232100160413     c     planIDkey     reade     planSetup
232200160413     c                   dow       not %eof
232300160413     c                   eval      cpcid1 = pxgroup
232400160413     c                   update    planSetup
232500160413     c     planIDkey     reade     planSetup
232600160413     c                   enddo
232700160413
232800131217     C                   if        chkrtf = 'Y'
232900131217     C                   exsr      chkrat
233000131217     C                   eval      chkrtf = 'N'
233100130606     C                   endif
233200130509      *
233300131217     C                   endif
233400131217      *
233500130509     C                   leavesr
233600130509      *
233700130509     C                   enddo
233800130509      *
233900130509     C                   endsr
234000130606      ******************************************************************
234100130606      *       SUBROUTINE - SETCOM                                      *
234200130606      *                    Load Common fields for Pln Hist Change Rec  *
234300130606      ******************************************************************
234400130606     C     setcom        BEGSR
234500130606      *
234600130606     C                   clear                   plnaxhstr
234700130606      *
234800130606     C                   eval      axtrst = pxtrst
234900130606     C                   eval      axsub# = pxsub#
235000130606     C                   eval      axplan = pxplan
235100130606      *
235200130606     C                   CLEAR                   @TIMESTAMP
235300130606     C                   MOVE      *BLANKS       @TS40
235400130606     C                   CALL      'TIMESTMP'
235500130606     C                   PARM                    @TS40
235600130606      *
235700130606     C                   movel     @TS40         @TIMESTAMP
235800130606     C                   movel     @TSUSER       axuser
235900130606     C                   move      #TSCYMD       axdate
236000130606     C                   move      #TSTIME       axtime
236100130606    * *
236200130606     C                   eval      axtype = 'C'
236300130606      *
236400130606     C                   endsr
236500130606      *
236600131107      ******************************************************************
236700131107      *       SUBROUTINE - WRTRAT                                      *
236800131107      *            Create Group Rate records for Med and Den plans     *
236900131107      ******************************************************************
237000131107     C     wrtrat        BEGSR
237100131107      *
237200131107     C                   clear                   grater
237300131107      *
237400131107     C                   eval      grtrst = pxtrst
237500131107     C                   eval      grsub# = pxsub#
237600131107     C                   eval      grplan = pxplan
237700131107      *
237800131107     C                   eval      group# = pxgroup
237900131107     C                   eval      grdltd = 'A'
238000131107      *         Calculate from and to Dates
238100131107     C                   eval      sysdateymd = %date
238200131111     C                   eval      wkdat1 = sysdateymd
238300131107     C                   move      sysdateymd    ratdat
238400131107     C                   eval      rdmm = prenew
238500131107     C                   eval      rddd = 01
238600131107     C                   move      ratdat        wkdat
238700131107      *
238800131111     C                   extrct    wkdat1:*M     wkdatmm
238900131111      *
239000131111     C                   if        wkdatmm > prenew
239100131107     C                   adddur    01:*Y         wkdat
239200131107     C                   endif
239300131107      *
239400131107     C                   move      wkdat         frmdat
239500131107     C                   adddur    01:*Y         wkdat
239600131107     C                   subdur    01:*D         wkdat
239700131107     C                   move      wkdat         todat
239800131107      *
239900140212     C                   if        #KY <> *blanks
240000140212     C                   if        #KY > '2013' and #KY < '2099'
240100140212     C                   move      #KY           rdyyyy
240200140212     C                   eval      rddd = 01
240300140212     C                   move      ratdat        wkdat
240400140212     C                   move      wkdat         frmdat
240500140212     C                   adddur    01:*Y         wkdat
240600140212     C                   subdur    01:*D         wkdat
240700140212     C                   move      wkdat         todat
240800140212     C                   endif
240900140212     C                   endif
241000140212      *
241100140212     C                   if        pxborefd <> 0 and pxborefd <> frmdat
241200140212     C                   eval      frmdat = pxborefd
241300140212     C                   endif
241400140212      *
241500140212     C                   eval      typecd = 'TIN'
241600140212     C                   write     grater
241700140212     C                   exsr      hist0
241800131107      *
241900131107     C                   eval      typecd = 'TPC'
242000131107     C                   write     grater
242100131108     C                   exsr      hist0
242200131107      *
242300131107     C                   eval      typecd = 'TP2'
242400131107     C                   write     grater
242500131108     C                   exsr      hist0
242600131107      *
242700131107     C                   eval      typecd = 'THW'
242800131107     C                   write     grater
242900131108     C                   exsr      hist0
243000131107      *
243100131107     C                   eval      typecd = 'TFA'
243200131107     C                   write     grater
243300131108     C                   exsr      hist0
243400131107      *
243500131107     C                   endsr
243600131108      ****************************************************
243700131108      *          HIST0 - Write Rate Hist Rec
243800131108      ****************************************************
243900131108     C     hist0         BEGSR
244000131108      *
244100131108     C                   CLEAR                   RGRTHIST
244200131108     C                   Z-ADD     GRTRST        HFTRST
244300131108     C                   Z-ADD     GRSUB#        HFSUB#
244400131108     C                   MOVEL     GRPLAN        HFPLAN
244500131108     C                   CLEAR                   @TIMESTAMP
244600131108     C                   MOVE      *BLANKS       @TS40
244700131108     C                   CALL      'TIMESTMP'
244800131108     C                   PARM                    @TS40
244900131108     C                   MOVEL     @TS40         @TIMESTAMP
245000131108     C                   MOVEL     @TSUSER       HFUSERID
245100131108     C                   MOVE      #TSCYMD       HFDATE
245200131108     C                   MOVE      #TSTIME       HFTIME
245300131108     C                   MOVEL     @TSJOB        HFJOBNAM
245400131108     C                   MOVE      #TSNBR        HFJOBNBR
245500131108      *
245600131108     C                   MOVE      FRMDAT        HFAFFRDT
245700131108     C                   MOVE      TODAT         HFAFTODT
245800131108     C                   MOVE      AGEBND        HFAFAGBN
245900131108     C                   MOVE      GRDLTD        HFAFDLTC
246000131108     C                   MOVEL     TYPECD        HFAFTYCD
246100131108     C                   MOVE      BILRTE        HFAFBILR
246200131108     C                   MOVE      NETRTE        HFAFNETR
246300131108     C                   MOVEL     GROUP#        HFAFGRP#
246400131108     C                   MOVE      AGEBND        HFAFAGBN
246500131108     C                   WRITE     RGRTHIST
246600131108     C                   ENDSR
246700131217      ******************************************************************
246800131217      *       SUBROUTINE - CHKRAT                                      *
246900131217      *           Change GROUP# in GRATE if 0 rate record              *
247000131217      ******************************************************************
247100131217     C     chkrat        BEGSR
247200131217      *
247300131217     C     ratkey        setll     grate                              75
247400131217     C                   dou       *in75 = '1'
247500131217     C     ratkey        reade     grate                                  75
247600131217     C                   IF        *In75 = '1'
247700131217     C                   leavesr
247800131217     C                   endif
247900131217      *
248000131217     C                   if        pxgroup <> group# and
248100131217     C                             netrte = 0
248200131217     C                   eval      group# = pxgroup
248300131217     C                   update    grater
248400131217     C                   endif
248500131217      *
248600131217     C                   enddo
248700131217      *
248800131217     C                   endsr
248900141113      ******************************************************************
249000141113      *       SUBROUTINE - ACASEL                                      *
249100141113      *                    Select ACA Rating Code                      *
249200141113      ******************************************************************
249300141113     C     acasel        BEGSR
249400141113     C     *IN01         DOWEQ     *OFF
249500141113      *
249600141113     C                   EXSR      $ACLEAR
249700141113     C                   EXSR      $ALOAD
249800141113     C                   EXSR      $ADISPLAY
249900141113      *    PROCESS SELECTION
250000141113     C     *IN01         IFEQ      *OFF
250100141113     C***  *IN07         ANDEQ     *OFF
250200141113     C***  RRN           ANDNE     *ZERO
250300141113     C                   eval      wacac = '  '
250400141113     C                   EXSR      $APROCES
250500141113     C*                  If        wofc# <> 0
250600141113     C                   leavesr
250700141113     C*                  ENDIF
250800141113     C                   ENDIF
250900141113     C                   ENDDO
251000141113      *
251100141113     C                   movel     '0'           *in01
251200141113     C                   ENDSR
251300141113      ******************************************************************
251400141113      *       SUBROUTINE - $ACLEAR                                      *
251500141113      *                    CLEAR SUBF AND RRN                          *
251600141113      ******************************************************************
251700141113     C     $ACLEAR       BEGSR
251800141113     C                   MOVEA     '001'         *IN(71)
251900141113     C                   WRITE     HDSELA
252000141113     C                   Z-ADD     *ZERO         ARRN              3 0
252100141113     C                   WRITE     HDSELA
252200141113     C                   MOVEA     '010'         *IN(71)
252300141113     C                   ENDSR
252400141113      ******************************************************************
252500141113      *       SUBROUTINE - $ALOAD                                       *
252600141113      *                    LOAD SUBFILE W/ ACA Rating Specs             *
252700141113      ******************************************************************
252800141113     C     $ALOAD        BEGSR
252900141113     C                   SETOFF                                       7496
253000141113      *
253100141113     C                   ADD       1             ARRN
253200141113     C                   MOVEL     'Y'           saccod
253300141113     C                   movel(P)  aytext        sacdsc
253400141113     C                   WRITE     selaca
253500141113      *
253600141113     C                   ADD       1             ARRN
253700141113     C                   MOVEL     'C'           saccod
253800141113     C                   movel(P)  actext        sacdsc
253900141113     C                   WRITE     selaca
254000141113      *
254100141114     C                   if        denpln = 'Y'
254200141114     C                   ADD       1             ARRN
254300141113     C                   MOVEL     'D'           saccod
254400141113     C                   movel(P)  adtext        sacdsc
254500141113     C                   WRITE     selaca
254600141114     C                   endif
254700141113      *
254800141114     C***                ADD       1             ARRN
254900141114     C***                MOVEL     'N'           saccod
255000141114     C***                movel(P)  antext        sacdsc
255100141114     C***                WRITE     selaca
255200141113      *
255300141113     C                   ENDSR
255400141113      ******************************************************************
255500141113      *       SUBROUTINE - $ADISPLAY                                    *
255600141113      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
255700141113      ******************************************************************
255800141113     C     $ADISPLAY     BEGSR
255900141113     C                   If        ARRN <> *Zero
256000141113     C                   MOVE      *ON           *IN71
256100141113     C                   ENDIF
256200141113     C                   WRITE     TRSELA
256300141113     C                   EXFMT     HDSELA
256400141113     C                   ENDSR
256500141113      ******************************************************************
256600141113      *       SUBROUTINE - $APROCES                                     *
256700141113      *                    PROCESS THE SELECTION                       *
256800141113      ******************************************************************
256900141113     C     $APROCES      BEGSR
257000141113     C     *IN96         DOUEQ     *ON
257100141113      *
257200141113     C                   READC     SELACA                                 96
257300141113     C                   IF        *IN96 = *OFF
257400141113      *      Select ACA Rating Code
257500141113     C                   IF        SELA = 'X'
257600141113     C                   eval      wacac = saccod
257700141113     C                   leavesr
257800141113     C                   endif
257900141113      *
258000141113     C                   CLEAR                   SELA
258100141113     C                   UPDATE    SELACA
258200141113     C                   ENDIF
258300141113     C                   ENDDO
258400141113     C                   ENDSR
