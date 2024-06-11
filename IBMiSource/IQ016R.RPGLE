000100991124     F*-------------------------------------------------------------------------
000200140807     F* IQ016R     GBS SOFTWARE 2014
000300141024     F*            WRITTEN BY - RLJ
000400141024     F*            AATE - 07/2014
000500140814     F*  DESCRIPTION - Issue Tracking File Maintenance
000600141024     F*
000700991124     F*-------------------------------------------------------------------------
000800991209     ** MODIFICATION HISTORY                                              **
000900150723     ** rlj 07/23/2015 - Add logic to call CL to send email to referral
001000150731     ** rlj 07/31/2015 - Don't allow Follow Up Date to be 0
001100150915     ** rlj 09/15/2015 - Reset DTISS# to 0 after issue close
001200141024     **                                                                   **
001300140925     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001400141024     FITISSP    IF   E           K DISK
001500150210     FITISSL1   IF   E           K DISK    RENAME(ITISSR:ITISSR1)
001600150210     FITISSL2   IF   E           K DISK    RENAME(ITISSR:ITISSR2)
001700150528     FITISSL3   IF   E           K DISK    PREFIX(Z)
001800150528     F                                     RENAME(ITISSR:ITISSZ)
001900150528     FITISSL    UF A E           K DISK    PREFIX(X)
002000150528     F                                     RENAME(ITISSR:ITISSX)
002100141024     FITHISP    UF A E           K DISK
002200141024     FITHISL    IF   E           K DISK    PREFIX(X)
002300141024     F                                     RENAME(ITHISR:ITHISX)
002400141024     FITCODP    IF   E           K DISK
002500150514     FHIST      O    E             DISK
002600141024     FMEMBER    IF   E           K DISK
002700141024     FACCMST    IF   E           K DISK
002800141024     FMCOV      IF   E           K DISK
002900140923     FPLNMST    IF   E           K DISK
003000140805     FCARMST    IF   E           K DISK
003100140923     FHYPERCARR IF   E           K DISK
003200140805     FCMCT14    IF   E           K DISK
003300140923     FIQ016D    CF   E             WORKSTN
003400141024     F                                     SFILE(DETAIL:RRN)
003500141024     F                                     SFILE(DETTYP:TRRN)
003600141024     F                                     SFILE(DETREQ:QRRN)
003700141024     F                                     SFILE(DETVEW:VRRN)
003800141024     F                                     SFILE(DETREF:RRRN)
003900141024     F                                     SFILE(DETCGR:CRRN)
004000141024     F                                     SFILE(DETHST:HRRN)
004100140804   X* *
004200140804     D                UDS
004300140804     D  @USER                100    107
004400140804     D  CONAME               201    240
0045001408040056 D  lprefix              241    241
004600140804JGE01D  LD8YMD               248    255  0
004700140804      *
004800131231    *** TIMESTAMP FIELDS DATA STRUCTURE
004900140804      *
005000140911     D @TIMESTAMP      DS
005100140911     D  #TSCYMD                1      8S 0
005200140911     D  #TSTIME                9     14S 0
005300140911     D  @TSJOB                15     24
005400140911     D  @TSUSER               25     34
005500140911     D  #TSNBR                35     40S 0
005600140911    * *
005700140911     D                 DS
005800140911     D @KEYPRM                 1     19A
005900140911     D #KTRST                  1      3S 0
006000140911     D #KSUB#                  4      6S 0
006100140911     D #KACCT                  7     10S 0
006200140911     D #KSSN                  11     19S 0
006300140911    * *
0064001409100048 D                 DS
0065001409100055 D mtspabct                1     15
0066001409100055 D mctrst                  1      3  0
0067001409100055 D mcsub#                  4      6  0
0068001409100055 D mcplan                  7     10
0069001409100055 D mcageb                 11     12  0
0070001409100055 D mcovtp2                13     15
007100140910    * *
0072001409100048 D                 DS
0073001402060055 D dtspabct                1     15
0074001402060055 D dvtrst                  1      3  0
0075001402060055 D dvsub#                  4      6  0
0076001402060055 D dvplan                  7     10
0077001402060055 D dvageb                 11     12  0 INZ(0)
0078001402060055 D dvcovtp                13     15    INZ('   ')
007900140731    * *
0080001407310048 D                 DS
0081001408260055 D ymddt                   1      8  0
0082001408260055 D   ymdyy                 1      4  0
0083001408260055 D   ymdmd                 5      8  0
008400140826    * *
0085001408260048 D                 DS
0086001408260055 D mdydt                   1      8  0
0087001408260055 D   mdymd                 1      4  0
0088001408260055 D   mdyyy                 5      8  0
008900141013    * *
0090001410130048 D                 DS
0091001505140055 D histtsa                 1     10
0092001505140055 D   htrst                 1      3
0093001505140055 D   hsub#                 4      6
0094001505140055 D   hacct                 7     10
009500150514    * *
0096001505140048 D                 DS
0097001505140055 D ihtext                  1    180
0098001505140055 D   ihtxt1                1     90
0099001505140055 D   htxt95                1     95
0100001505140055 D   ihtxt2               91    180
010100140826    * *
0102001408260048 D                 DS
0103001408260055 D xitdesc                 1    480
0104001408260055 D   desc1                 1    120
0105001408260055 D   desc2               121    240
0106001408040055 D   desc3               241    360
0107001408040055 D   desc4               361    480
010800140926    * *
0109001409260048 D                 DS
0110001409260055 D attxt480                1    480
0111001409260055 D   attxt1                1    120
0112001409260055 D   attxt2              121    240
0113001409260055 D   attxt3              241    360
0114001409260055 D   attxt4              361    480
011500141009    * *
0116001410090048 D                 DS
0117001410090055 D cttxt480                1    480
0118001410090055 D   cttxt1                1    120
0119001410090055 D   cttxt2              121    240
0120001410090055 D   cttxt3              241    360
0121001410090055 D   cttxt4              361    480
012200141012    * *
0123001408050048 D                 DS
0124001408270055 D carc20                  1     40
0125001408270055 D   dtcac1                1      2
0126001408270055 D   dtcac2                3      4
0127001408270055 D   dtcac3                5      6
0128001408270055 D   dtcac4                7      8
0129001408270055 D   dtcac5                9     10
0130001408270055 D   dtcac6               11     12
0131001408270055 D   dtcac7               13     14
0132001408270055 D   dtcac8               15     16
0133001409020055 D   dtcac9               17     18
0134001409020055 D   dtcac10              19     20
0135001409020055 D   dtcac11              21     22
0136001409020055 D   dtcac12              23     24
0137001409020055 D   dtcac13              25     26
0138001409020055 D   dtcac14              27     28
0139001409020055 D   dtcac15              29     30
0140001409020055 D   dtcac16              31     32
0141001409020055 D   dtcac17              33     34
0142001408270055 D   dtcac18              35     36
0143001408270055 D   dtcac19              37     38
0144001408270055 D   dtcac20              39     40
014500140827    * *
0146001408270048 D                 DS
0147001408270055 D carr20                  1    600
0148001408270055 D   dtcar1                1     30
0149001408270055 D   dtcar2               31     60
0150001408270055 D   dtcar3               61     90
0151001408270055 D   dtcar4               91    120
0152001408270055 D   dtcar5              121    150
0153001408270055 D   dtcar6              151    180
0154001408270055 D   dtcar7              181    210
0155001408270055 D   dtcar8              211    240
0156001408270055 D   dtcar9              241    270
0157001408270055 D   dtcar10             271    300
0158001408270055 D   dtcar11             301    330
0159001408270055 D   dtcar12             331    360
0160001408270055 D   dtcar13             361    390
0161001408270055 D   dtcar14             391    420
0162001408270055 D   dtcar15             421    450
0163001408270055 D   dtcar16             451    480
0164001408270055 D   dtcar17             481    510
0165001408270055 D   dtcar18             511    540
0166001408270055 D   dtcar19             541    570
0167001408270055 D   dtcar20             571    600
016800140926    * *
0169001409260048 D                 DS
0170001409260055 D cari20                  1     40
0171001410100055 D  xitcgr1                1      2
0172001410100055 D  xitcgr2                3      4
0173001410100055 D  xitcgr3                5      6
0174001410100055 D  xitcgr4                7      8
0175001410100055 D  xitcgr5                9     10
0176001410100055 D  xitcgr6               11     12
0177001410100055 D  xitcgr7               13     14
0178001410100055 D  xitcgr8               15     16
0179001410100055 D  xitcgr9               17     18
0180001410100055 D  xitcgr10              19     20
0181001410100055 D  xitcgr11              21     22
0182001410100055 D  xitcgr12              23     24
0183001410100055 D  xitcgr13              25     26
0184001410100055 D  xitcgr14              27     28
0185001410100055 D  xitcgr15              29     30
0186001410100055 D  xitcgr16              31     32
0187001410100055 D  xitcgr17              33     34
0188001410100055 D  xitcgr18              35     36
0189001410100055 D  xitcgr19              37     38
0190001410100055 D  xitcgr20              39     40
019100141008    * *
0192001410080048 D                 DS
0193001410090055 D itcur                   1    108
0194001410090055 D  xitfudt                1      8  0
0195001410090055 D  xitvewc                9     11
0196001410090055 D  xittypc               12     14
0197001410090055 D  xitsbjt               15     34
0198001410140055 D  xitrefr               35     37
0199001410090055 D  xitreft               38     97
0200001410090055 D  xitrefd               98    105  0
0201001410090055 D  xitresp              106    108
020200141008    * *
0203001410080048 D                 DS
0204001410090055 D itsav                   1    108
0205001410080055 D   svfudt                1      8  0
0206001410080055 D   svvewc                9     11
0207001410080055 D   svtypc               12     14
0208001410080055 D   svsbjt               15     34
0209001410140055 D   svrefr               35     37
0210001410080055 D   svreft               38     97
0211001410080055 D   svrefd               98    105  0
0212001410080055 D   svresp              106    108
021300140926    * *
021400140123     D                 DS
021500140123     D  GRgroup                      15
021600140123     D  GRP#                          6    OVERLAY(GRgroup)
021700140123    * *
021800130424     D                 DS
0219001408150037 D wktime          S               T   timfmt(*hms:)
0220001408150037 D wkdate          S               D   datfmt(*iso)
0221001408040037 D sysZateymd      S               D   datfmt(*iso)
022200130510     D usadt           S               D   DATFMT(*USA/)
022300140828     D basedate        S               D   INZ(D'1899-12-30')
022400140828     D wkfld           S              5S 0
022500140828     D dayowk          S              1S 0
022600140828     D todate          S              8S 0
022700150210     D #kdat9          S              8S 0 INZ(99999999)
022800140904     D @TS40           S             40A
022900140904     D typflg          S              1
023000141010     D edtcln          S              1
023100141010     D chgind          S              1
023200150514     D itissa          S              6
023300150723     D rfeto           S             20
023400150723     D rfesub          S             60
023500150723     D rfetxt          S            755
023600141014     D getiss          S              1    INZ('N')
023700141010     D htypc           S                   LIKE(IHTYPC)
023800141010     D itxt            S                   LIKE(IHTEXT)
023900141010     D wtyp            S                   LIKE(STTCOD)
024000140904     D wttdsc          S                   LIKE(STTDSC)
024100140904     D wttday          S                   LIKE(STTDAY)
024200140904     D wreq            S                   LIKE(SRQCOD)
024300140904     D wrqdsc          S                   LIKE(SRQDSC)
024400140904     D wvew            S                   LIKE(SVWCOD)
024500140904     D wvwdsc          S                   LIKE(SVWDSC)
024600140826     D wref            S                   LIKE(SRFCOD)
024700140826     D wrfdsc          S                   LIKE(SRFDSC)
024800140827     D wcgr            S                   LIKE(SCGCOD)
024900140827     D wcgdsc          S                   LIKE(SCGDSC)
025000140819     D wtfudt          S                   LIKE(todate)
025100140818     D niss#           S                   LIKE(itiss#)
025200140818     D nssn            S                   LIKE(itmssn)
025300141010     D svdesc          S                   LIKE(itdesc)
025400141010     D svcarr          S                   LIKE(cari20)
025500141013     D svhis#          S                   LIKE(ihhis#)
025600141014     D sviss#          S                   LIKE(itiss#)
025700081111      *
0258001304230053 D                 DS
0259001304230054 D  invacc         C                   'INVALID TRUST/SUB#/ACCOUNT  '
0260001410070054 D  blksjt         C                   'SUBJECT CANNOT BE BLANK    '
0261001410070054 D  blkvew         C                   'VIEWABLE BY CANNOT BE BLANK     '
0262001410070054 D  blktxt         C                   'TEXT CANNOT BE BLANK         '
0263001504270054 D  crablx         C                   'HIT F5 TO ADD CARRIERS       '
0264001504270054 D  crcblx         C                   'HIT F5 TO CHG CARRIERS       '
0265001502170054 D  blkcar         C                   'YOU MUST SELECT 1 OR MORE CARRIERS'
0266001502170054 D  fuderr         C                   'FOLLOW UP DATE INVALID - MMDDYYYY'
0267001410140054 D  fuderx         C                   'FOLLOW UP DT IS PRIOR TO TODAY  '
0268001409260054 D  rfderr         C                   'REFERRAL DATE INVALID - MMDDYYYY'
0269001410140054 D  rfderx         C                   'REFERRAL DATE IS PRIOR TO TODAY '
0270001410130054 D  noochg         C                   'NO FIELDS WERE CHANGED ?        '
0271001410140054 D  nootxt         C                   'YOU MUST ENTER A COMMENT TO CLOSE'
0272001410130054 D  cr20chg        C                   'ASSOCIATED CARRIERS WERE CHANGED '
0273001410130054 D  descchg        C                   'ISSUE DESCRIPTION WAS CHANGED     '
0274001410130054 D  fudtchg        C                   'FOLLOW UP DATE WAS CHANGED        '
0275001410130054 D  typcchg        C                   'ISSUE TYPE WAS CHANGED           '
0276001410130054 D  vewcchg        C                   'VIEWABLE BY WAS CHANGED           '
0277001410130054 D  sbjtchg        C                   'ISSUE SUBJECT WAS CHANGED         '
0278001410140054 D  refrchg        C                   'REFERRED TO WAS CHANGED         '
0279001410130054 D  reftchg        C                   'REFERRAL TEXT WAS CHANGED         '
0280001410130054 D  refdchg        C                   'REFERRAL DATE WAS CHANGED         '
0281001410130054 D  respchg        C                   'RESPONSE REQ FROM WAS CHANGED      '
0282001505140054 D  hstopn1        C                   'ISSUE TRACKING #'
0283001505140054 D  hstopn2        C                   ' OPENED'
028400150514    * *
028500131206     C     acckey        KLIST
028600140730     C                   KFLD                    #ktrst
028700140730     C                   KFLD                    #ksub#
028800140730     C                   KFLD                    #kacct
028900140731    * *
029000140805     C     plnkey        KLIST
029100140904     C                   KFLD                    mctrst
029200140904     C                   KFLD                    mcsub#
029300140904     C                   KFLD                    mcplan
029400140904    * *
029500140904     C     plxkey        KLIST
029600140904     C                   KFLD                    #ktrst
029700140904     C                   KFLD                    #ksub#
029800140904     C                   KFLD                    cmplan
029900140904    * *
030000140904     C     mbrkey        KLIST
030100140731     C                   KFLD                    #kssn
030200150210     C                   KFLD                    #kdat9
030300150210    * *
030400150210     C     acckeyx       KLIST
030500150210     C                   KFLD                    #ktrst
030600150210     C                   KFLD                    #ksub#
030700150210     C                   KFLD                    #kacct
030800150210     C                   KFLD                    #kdat9
030900140819    * *
031000140819     C     codkey        KLIST
031100140819     C                   KFLD                    cktyp             1
031200140819     C                   KFLD                    ckcod             3
031300141010    * *
031400141010     C     hiskey        KLIST
031500141010     C                   KFLD                    hiss#             6 0
031600141010     C                   KFLD                    hhis#             5 0
031700131205    * *
031800131205    * *
031900131205    * *
032000131205     C     *ENTRY        PLIST
032100140730     C                   PARM                    @PARM            19
032200131205     C                   MOVEL(P)  @PARM         @KEYPRM
032300131231    * *
032400140730     C                   eval      typflg = 'A'
032500140730     C                   if        #kssn <> 0
032600140730     C                   eval      typflg = 'M'
032700140730     C                   movel     #kssn         ssnod
032800140730     C                   endif
032900140730    * *
033000131231     C                   CLEAR                   @TIMESTAMP
033100131231     C                   MOVE      *BLANKS       @TS40
033200131231     C                   CALL      'TIMESTMP'
033300131231     C                   PARM                    @TS40
033400131231     C                   MOVEL     @TS40         @TIMESTAMP
033500131231     C                   MOVE      #TSCYMD       todate
033600131205    * *
033700140730     C                   eval      mbrnam = *blanks
033800140730     C                   if        typflg = 'M'
033900140904     C     #kssn         chain     member                             32
034000140904     C                   if        *in32 = '0'
034100140904     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
034200140904     C                             %TRIM(mfname)
034300140904     C                   endif
034400140904      *
034500140904     C                   endif
034600140904      *
034700140904     C                   MOVEL     #ktrst        trust
034800140904     C                   MOVEL     #ksub#        subno
034900140904     C                   MOVEL     #kacct        accno
035000140904      *
035100140904     C     acckey        chain     accmst                             33
035200140904     C                   if        *in33 = '0'
035300140904     C                   eval      accnam = acnam1
035400131206     C                   endif
035500131206      *
035600131205     C                   MOVEL     CONAME        TITLE
035700131205     C                   MOVE      '0'           @EXIT             1
035800130426    * *
035900130423      * MAINLINE
036000130607      *
036100130607     C     *IN01         DOWEQ     *OFF
036200130607      *      RELOAD IF CLIENT SEARCH CHANGES
036300130607     C                   EXSR      $CLEAR
036400130607     C                   EXSR      $LOAD
036500130607     C                   EXSR      $DISPLAY
036600130607     C                   setoff                                       88
036700130607      *    PROCESS SELECTION
036800141007     C     *IN01         IFEQ      *OFF
036900130607     C***  *IN07         ANDEQ     *OFF
037000130607     C***  RRN           ANDNE     *ZERO
037100140731     C                   EXSR      $PROCES
037200130607     C*****              ENDIF
037300130607      *
037400141007     C                   endif
037500130607      *
037600141007     C                   enddo
037700141007      *
037800131205     C                   eval      *inlr = '1'
037900131205     C                   return
038000130607      ******************************************************************
038100130607      *       SUBROUTINE - $CLEAR                                      *
038200130607      *                    CLEAR SUBF AND RRN                          *
038300130607      ******************************************************************
038400130607     C     $CLEAR        BEGSR
038500130607     C                   MOVEA     '001'         *IN(31)
038600130607     C                   wRITE     HEADER
038700130607     C                   Z-ADD     *ZERO         RRN               4 0
038800130607     C                   WRITE     HEADER
038900130607     C                   MOVEA     '010'         *IN(31)
039000130607     C                   ENDSR
039100130607      ******************************************************************
039200130607      *       SUBROUTINE - $LOAD                                       *
039300140730      *                    LOAD SUBFILE W/ Issue Info                  *
039400130607      ******************************************************************
039500130607     C     $LOAD         BEGSR
039600140618      *
039700140730     C                   if        typflg = 'M'
039800130607     C                   SETOFF                                       3495
039900150210     C     mbrkey        setll     itissl2                            34
040000130607     C     *IN34         DOUEQ     *ON
040100130607     C     *IN95         OREQ      *ON
040200150210     C                   read      itissl2                                34
040300140730     C                   IF        *In34 <> *ON
040400150210     C                   IF        #kssn <> itmssn
040500150217     C                   eval      *In34 = *ON
040600150210     C                   leave
040700150210     C                   endif
040800150210      *
040900150210     C                   if        *in71 = '1' and itsts <> 'O'
041000150210     C                   iter
041100150210     C                   endif
041200150210      *
041300140730     C                   exsr      loddtl
041400131231     C                   endif
041500140122      *
041600130607     C                   ENDDO
041700140730      *
041800140730     C                   else
041900140730      *
042000150210     C     acckeyx       setll     itissl1                            34
042100140730     C     *IN34         DOUEQ     *ON
042200140730     C     *IN95         OREQ      *ON
042300150210     C                   read      itissl1                                34
042400150210     C                   IF        *In34 <> *ON
042500150210     C                   IF        #ktrst <> ittrst or #ksub# <> itsub# or
042600150210     C                             #kacct <> itacct
042700150217     C                   eval      *In34 = *ON
042800150210     C                   leave
042900140730     C                   endif
043000150210      *
043100150210     C                   if        *in71 = '1' and itsts <> 'O'
043200150210     C                   iter
043300150210     C                   endif
043400140730      *
043500150210     C                   exsr      loddtl
043600150210     C                   endif
043700150210      *
043800140730     C                   ENDDO
043900140730     C                   endif
044000140730      *
044100140207      *
044200130607     C                   ENDSR
044300140730      ******************************************************************
044400140730      *       SUBROUTINE - loddtl                                      *
044500140730      *                    LOAD SUBFILE Detail                         *
044600140730      ******************************************************************
044700140730     C     loddtl        BEGSR
044800140730      *
044900140731     C                   eval      stmssn = %editc(itmssn:'4')
045000140731     C                   eval      stiss# = %editc(itiss#:'4')
045100140731     C                   eval      stinit = itinit
045200140912     C                   eval      sttypc = ittypc
045300140912     C                   movel     itdato        wkdate
045400140912     C                   eval      usadt = wkdate
045500140912     C                   movel     usadt         stdato
045600140912     C                   eval      stsbjt = itsbjt
045700140912     C                   movel     itfudt        wkdate
045800140912     C                   eval      usadt = wkdate
045900140912     C                   movel     usadt         stfudt
046000140912      *
046100140912     C                   if        itdatc = 0
046200140912     C                   movel(P)  'OPEN'        stdatc
046300140912     C                   else
046400140912     C                   movel     itdatc        wkdate
046500140912     C                   eval      usadt = wkdate
046600140908     C                   movel     usadt         stdatc
046700150731     C                   endif
046800140912      *
046900140731     C                   ADD       1             RRN
047000140731     C                   WRITE     DETAIL
047100140731      *
047200140731     C                   ENDSR
047300130607      ******************************************************************
047400130607      *       SUBROUTINE - $DISPLAY                                    *
047500130607      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
047600130607      ******************************************************************
047700130607     C     $DISPLAY      BEGSR
047800130607     C                   If        RRN <> *Zero
047900130607     C                   MOVE      *ON           *IN31
048000130607     C                   ENDIF
048100130607     C                   WRITE     TRAILER
048200130607     C                   EXFMT     HEADER
048300130607     C                   ENDSR
048400130607      *
048500140731      ******************************************************************
048600140731      *       SUBROUTINE - $PROCES                                     *
048700140731      *                    PROCESS THE SELECTION                       *
048800140731      ******************************************************************
048900140731     C     $PROCES       BEGSR
049000140731     C     *IN96         DOUEQ     *ON
049100150210      *       Display Mode - Open Only or Show All
049200150210     C                   if        *in09 = *ON
049300150210     C                   if        *in71 = *ON
049400150210     C                   eval      *in71 = *OFF
049500150210     C                   else
049600150210     C                   eval      *in71 = *ON
049700150210     C                   endif
049800150210     C                   eval      *in09 = *OFF
049900140814     C                   leavesr
050000140814     C                   endif
050100150210      *      Add new record
050200150210     C                   IF        *in06 = *ON or rrn = 0
050300150210     C                   exsr      issadd
050400150210     C                   eval      *in06 = *OFF
050500150210     C                   leavesr
050600150210     C                   endif
050700140731      *
050800140731     C                   READC     DETAIL                                 96
050900140731     C                   IF        *IN96 = *OFF
051000140731      *        Display Action
051100140731     C                   IF        SELECT = '5'
051200140731     C                   exsr      issdsp
051300140731     C                   iter
051400140731     C                   endif
051500140731      *        Change Action
051600141008     C                   IF        SELECT = '2'
051700141008     C                   exsr      isschg
051800141008     C                   iter
051900141008     C                   endif
052000141014      *        Show Comments/History
052100141014     C                   IF        SELECT = '6'
052200141014     C                   movel     stiss#        sviss#
052300141014     C                   eval      getiss = 'Y'
052400141014     C                   exsr      isshst
052500141014     C                   eval      getiss = 'N'
052600141014     C                   iter
052700141014     C                   endif
052800140731      *
052900140731     C                   CLEAR                   SELECT
053000140731     C                   UPDATE    DETAIL
053100140731     C                   ENDIF
053200140731     C                   ENDDO
053300140731     C                   ENDSR
053400140731      ******************************************************************
053500140731      *       SUBROUTINE - ISSDSP                                      *
053600140731      *                    Dispaly Issue Details                       *
053700140731      ******************************************************************
053800140731     C     issdsp        BEGSR
053900140805     C                   movel     stmssn        nssn
054000140805     C                   movel     stiss#        niss#
054100140731     C     *IN01         DOWEQ     *OFF
054200140818     C     niss#         chain     itissl                             22
054300140731     C                   if        *in22 = '0'
054400140805      *   If Member display - fill in Mbr hdr fields
054500140805     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
054600140805     C                   movel     nssn          ssnod
054700140805     C     nssn          chain     member                             32
054800140805     C                   if        *in32 = '0'
054900140805     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
055000140805     C                             %TRIM(mfname)
055100140805     C                   endif
055200140805     C                   endif
055300140805      *
055400140731     C                   movel     xitiss#       dtiss#
055500140731     C                   movel     xitinit       dtinit
055600140731      *
055700140731     C                   movel     xitdato       wkdate
055800140731     C                   eval      usadt = wkdate
055900140731     C                   movel     usadt         dtdato
056000140731      *
056100140926     C                   eval      dttimo = %EDITW(xittimo:'0 :  :  ')
056200140926      *
056300140731     C                   if        xitdatc = 0
056400140731     C                   movel(P)  'OPEN'        dtdatc
056500140822     C                   else
056600140822     C                   movel     xitdatc       wkdate
056700140822     C                   eval      usadt = wkdate
056800140822     C                   movel     usadt         dtdatc
056900141014      *
057000141014     C                   eval      dttimc = %EDITW(xittimc:'0 :  :  ')
057100140822     C                   endif
057200140822      *
057300141015     C                   if        xitfudt = 0
057400141015     C                   eval      dtfudt = *blanks
057500141015     C                   else
057600140822     C                   movel     xitfudt       wkdate
057700140822     C                   eval      usadt = wkdate
057800140822     C                   movel     usadt         dtfudt
057900141015     C                   endif
058000140819      *
058100140819     C                   eval      cktyp = 'Q'
058200140819     C                   eval      ckcod = xitresp
058300140819     C     codkey        chain     itcodp                             32
058400140819     C                   if        *in32 = '0'
058500140819     C                   movel(P)  ictext        dtresp
058600140819     C                   endif
058700140819      *
058800140731      *
058900140819     C                   eval      cktyp = 'T'
059000140819     C                   eval      ckcod = xittypc
059100140819     C     codkey        chain     itcodp                             32
059200140819     C                   if        *in32 = '0'
059300140819     C                   movel(P)  ictext        dttype
059400140731     C                   endif
059500140731      *
059600140731     C                   movel     xitsbjt       dtsbjt
059700140819      *
059800140819     C                   eval      cktyp = 'V'
059900140819     C                   eval      ckcod = xitvewc
060000140819     C     codkey        chain     itcodp                             32
060100140819     C                   if        *in32 = '0'
060200140819     C                   movel(P)  ictext        dtview
060300140819     C                   endif
060400140819      *
060500140819     C                   eval      cktyp = 'R'
060600140819     C                   eval      ckcod = xitrefr
060700140819     C     codkey        chain     itcodp                             32
060800140819     C                   if        *in32 = '0'
060900140819     C                   movel(P)  ictext        dtrefr
061000140819     C                   endif
061100140819      *
061200140805     C                   movel(P)  xitreft       dtreft
061300140731      *
061400141015     C                   if        xitrefd = 0
061500141015     C                   eval      dtrefd = *blanks
061600141015     C                   else
061700140806     C                   movel     xitrefd       wkdate
061800140806     C                   eval      usadt = wkdate
061900140806     C                   movel     usadt         dtrefd
062000140806     C                   endif
062100140806      *
062200140826     C                   eval      carr20 = *blanks
062300140826      *
062400140826     C                   if        xitcgr1 <> *blanks
062500150212     C                   if        xitcgr1 = 'NC'
062600150212     C                   eval      dtcar1 = 'NOT CARRIER SPECIFIC'
062700150212     C                   else
062800140826     C     xitcgr1       chain     hypercarr                          52
062900140826     C                   if        *in52 = '0'
063000140826     C                   movel(P)  hcname        dtcar1
063100140826     C                   endif
063200140826     C                   endif
063300150212     C                   endif
063400140826      *
063500140826     C                   if        xitcgr2 <> *blanks
063600140826     C     xitcgr2       chain     hypercarr                          52
063700140826     C                   if        *in52 = '0'
063800140826     C                   movel(P)  hcname        dtcar2
063900140826     C                   endif
064000140826     C                   endif
064100140826      *
064200140826     C                   if        xitcgr3 <> *blanks
064300140826     C     xitcgr3       chain     hypercarr                          52
064400140826     C                   if        *in52 = '0'
064500140826     C                   movel(P)  hcname        dtcar3
064600140826     C                   endif
064700140826     C                   endif
064800140826      *
064900140826     C                   if        xitcgr4 <> *blanks
065000140826     C     xitcgr4       chain     hypercarr                          52
065100140826     C                   if        *in52 = '0'
065200140826     C                   movel(P)  hcname        dtcar4
065300140826     C                   endif
065400140826     C                   endif
065500140826      *
065600140826     C                   if        xitcgr5 <> *blanks
065700140826     C     xitcgr5       chain     hypercarr                          52
065800140826     C                   if        *in52 = '0'
065900140826     C                   movel(P)  hcname        dtcar5
066000140826     C                   endif
066100140826     C                   endif
066200140826      *
066300140826     C                   if        xitcgr6 <> *blanks
066400140826     C     xitcgr6       chain     hypercarr                          52
066500140826     C                   if        *in52 = '0'
066600140826     C                   movel(P)  hcname        dtcar6
066700140826     C                   endif
066800140826     C                   endif
066900140826      *
067000140826     C                   if        xitcgr7 <> *blanks
067100140826     C     xitcgr7       chain     hypercarr                          52
067200140826     C                   if        *in52 = '0'
067300140826     C                   movel(P)  hcname        dtcar7
067400140826     C                   endif
067500140826     C                   endif
067600140826      *
067700140826     C                   if        xitcgr8 <> *blanks
067800140826     C     xitcgr8       chain     hypercarr                          52
067900140826     C                   if        *in52 = '0'
068000140826     C                   movel(P)  hcname        dtcar8
068100140826     C                   endif
068200140826     C                   endif
068300140826      *
068400140826     C                   if        xitcgr9 <> *blanks
068500140826     C     xitcgr9       chain     hypercarr                          52
068600140826     C                   if        *in52 = '0'
068700140826     C                   movel(P)  hcname        dtcar9
068800140826     C                   endif
068900140826     C                   endif
069000140826      *
069100140826     C                   if        xitcgr10 <> *blanks
069200140826     C     xitcgr10      chain     hypercarr                          52
069300140826     C                   if        *in52 = '0'
069400140826     C                   movel(P)  hcname        dtcar10
069500140826     C                   endif
069600140826     C                   endif
069700140826      *
069800140826     C                   if        xitcgr11 <> *blanks
069900140826     C     xitcgr11      chain     hypercarr                          52
070000140826     C                   if        *in52 = '0'
070100140826     C                   movel(P)  hcname        dtcar11
070200140826     C                   endif
070300140826     C                   endif
070400140826      *
070500140826     C                   if        xitcgr12 <> *blanks
070600140826     C     xitcgr12      chain     hypercarr                          52
070700140826     C                   if        *in52 = '0'
070800140826     C                   movel(P)  hcname        dtcar12
070900140826     C                   endif
071000140826     C                   endif
071100140826      *
071200140826     C                   if        xitcgr13 <> *blanks
071300140826     C     xitcgr13      chain     hypercarr                          52
071400140826     C                   if        *in52 = '0'
071500140826     C                   movel(P)  hcname        dtcar13
071600140826     C                   endif
071700140826     C                   endif
071800140826      *
071900140826     C                   if        xitcgr14 <> *blanks
072000140826     C     xitcgr14      chain     hypercarr                          52
072100140826     C                   if        *in52 = '0'
072200140826     C                   movel(P)  hcname        dtcar14
072300140826     C                   endif
072400140826     C                   endif
072500140826      *
072600140826     C                   if        xitcgr15 <> *blanks
072700140826     C     xitcgr15      chain     hypercarr                          52
072800140826     C                   if        *in52 = '0'
072900140826     C                   movel(P)  hcname        dtcar15
073000140826     C                   endif
073100140826     C                   endif
073200140826      *
073300140826     C                   if        xitcgr16 <> *blanks
073400140826     C     xitcgr16      chain     hypercarr                          52
073500140826     C                   if        *in52 = '0'
073600140826     C                   movel(P)  hcname        dtcar16
073700140826     C                   endif
073800140826     C                   endif
073900140826      *
074000140826     C                   if        xitcgr17 <> *blanks
074100140826     C     xitcgr17      chain     hypercarr                          52
074200140826     C                   if        *in52 = '0'
074300140826     C                   movel(P)  hcname        dtcar17
074400140826     C                   endif
074500140826     C                   endif
074600140826      *
074700140826     C                   if        xitcgr18 <> *blanks
074800140826     C     xitcgr18      chain     hypercarr                          52
074900140826     C                   if        *in52 = '0'
075000140826     C                   movel(P)  hcname        dtcar18
075100140826     C                   endif
075200140826     C                   endif
075300140826      *
075400140826     C                   if        xitcgr19 <> *blanks
075500140826     C     xitcgr19      chain     hypercarr                          52
075600140826     C                   if        *in52 = '0'
075700140826     C                   movel(P)  hcname        dtcar19
075800140826     C                   endif
075900140826     C                   endif
076000140826      *
076100140826     C                   if        xitcgr20 <> *blanks
076200140826     C     xitcgr20      chain     hypercarr                          52
076300140826     C                   if        *in52 = '0'
076400140826     C                   movel(P)  hcname        dtcar20
076500140826     C                   endif
076600140826     C                   endif
076700140826      *
076800140826      *
076900140731     C                   movel(P)  desc1         dttxt1
077000140731     C                   movel(P)  desc2         dttxt2
077100140731     C                   movel(P)  desc3         dttxt3
077200140804     C                   movel(P)  desc4         dttxt4
077300140731      *
077400140826     C************       exsr      getcar
077500140805      *
077600140805     C                   exfmt     dspiss
077700140731      *
077800141013      *      Display History
077900141012     C                   IF        *in06 = *ON
078000140818     C                   exsr      isshst
078100141012     C                   eval      *in06 = *OFF
078200141012     C                   iter
078300140818     C                   endif
078400140731      *
078500140731     C                   IF        *IN01 = *ON
078600140731     C                   eval      smsg = *blanks
078700140805     C                   if        typflg <> 'M'
078800140805     C                   eval      ssnod = *blanks
078900140805     C                   eval      mbrnam = *blanks
079000140805     C                   endif
079100140731     C                   MOVE      *Off          *IN01
079200140731     C                   leavesr
079300140731     C                   endif
079400140731      *
079500140731     C                   endif
079600140731      *
079700140731     C                   ENDDO
079800140731      *
079900140731     C                   ENDSR
080000141008      ******************************************************************
080100141008      *       SUBROUTINE - ISSCHG                                      *
080200141008      *                    Change Issue Details                        *
080300141008      ******************************************************************
080400141008     C     isschg        BEGSR
080500141008     C                   movel     stmssn        nssn
080600141008     C                   movel     stiss#        niss#
080700141008     C     niss#         chain     itissl                             22
080800141008     C                   if        *in22 = '0'
080900141009     C                   eval      itsav = itcur
081000141010     C                   eval      svdesc = xitdesc
081100141010     C                   eval      svcarr = cari20
081200141008      *   If Member display - fill in Mbr hdr fields
081300141008     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
081400141008     C                   movel     nssn          ssnod
081500141008     C     nssn          chain     member                             32
081600141008     C                   if        *in32 = '0'
081700141008     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
081800141008     C                             %TRIM(mfname)
081900141008     C                   endif
082000141008     C                   endif
082100141008      *
082200141008     C                   movel     xitiss#       ctiss#
082300141008     C                   movel     xitinit       ctinit
082400141008      *
082500141008     C                   movel     xitdato       wkdate
082600141008     C                   eval      usadt = wkdate
082700141008     C                   movel     usadt         ctdato
082800141008      *
082900141008     C                   eval      cttimo = %EDITW(xittimo:'0 :  :  ')
083000141008      *
083100141008     C                   if        xitdatc = 0
083200141008     C                   movel(P)  'OPEN'        ctdatc
083300141008     C                   else
083400141008     C                   movel     xitdatc       wkdate
083500141008     C                   eval      usadt = wkdate
083600141008     C                   movel     usadt         ctdatc
083700141008     C                   endif
083800141008      *
083900141015     C                   if        xitfudt = 0
084000141015     C                   eval      ctfudt = 0
084100141015     C                   else
084200141008     C                   movel     xitfudt       ymddt
084300141008     C                   eval      mdymd = ymdmd
084400141008     C                   eval      mdyyy = ymdyy
084500141008     C                   movel     mdydt         ctfudt
084600141015     C                   endif
084700141008      *
084800141008     C                   eval      cktyp = 'Q'
084900141008     C                   eval      ckcod = xitresp
085000141010     C                   eval      ctrespc = xitresp
085100141008     C     codkey        chain     itcodp                             32
085200141008     C                   if        *in32 = '0'
085300141008     C                   movel(P)  ictext        ctresp
085400141008     C                   endif
085500141008      *
085600141008      *
085700141008     C                   eval      cktyp = 'T'
085800141008     C                   eval      ckcod = xittypc
085900141010     C                   eval      cttypc = xittypc
086000141008     C     codkey        chain     itcodp                             32
086100141008     C                   if        *in32 = '0'
086200141008     C                   movel(P)  ictext        cttype
086300141008     C                   endif
086400141008      *
086500141008     C                   movel     xitsbjt       ctsbjt
086600141008      *
086700141008     C                   eval      cktyp = 'V'
086800141008     C                   eval      ckcod = xitvewc
086900141010     C                   eval      ctviewc = xitvewc
087000141008     C     codkey        chain     itcodp                             32
087100141008     C                   if        *in32 = '0'
087200141008     C                   movel(P)  ictext        ctview
087300141008     C                   endif
087400141008      *
087500141008     C                   eval      cktyp = 'R'
087600141010     C                   eval      ckcod = xitrefr
087700141010     C                   eval      ctrefrc = xitrefr
087800141008     C     codkey        chain     itcodp                             32
087900141008     C                   if        *in32 = '0'
088000141008     C                   movel(P)  ictext        ctrefr
088100141008     C                   endif
088200141008      *
088300141008     C                   movel(P)  xitreft       ctreft
088400141008      *
088500141015     C                   if        xitrefd = 0
088600141015     C                   eval      ctrefd = 0
088700141015     C                   else
088800141008     C                   movel     xitrefd       wkdate
088900141008     C                   eval      usadt = wkdate
089000141008     C                   movel     usadt         ctrefd
089100141008     C                   endif
089200141008      *
089300141008     C                   eval      carr20 = *blanks
089400141010     C                   eval      carc20 = cari20
089500141008      *
089600141008     C                   if        xitcgr1 <> *blanks
089700150212     C                   if        xitcgr1 = 'NC'
089800150212     C                   eval      dtcar1 = 'NOT CARRIER SPECIFIC'
089900150212     C                   else
090000141008     C     xitcgr1       chain     hypercarr                          52
090100141008     C                   if        *in52 = '0'
090200141008     C                   movel(P)  hcname        dtcar1
090300141008     C                   endif
090400141008     C                   endif
090500150212     C                   endif
090600141008      *
090700141008     C                   if        xitcgr2 <> *blanks
090800141008     C     xitcgr2       chain     hypercarr                          52
090900141008     C                   if        *in52 = '0'
091000141008     C                   movel(P)  hcname        dtcar2
091100141008     C                   endif
091200141008     C                   endif
091300141008      *
091400141008     C                   if        xitcgr3 <> *blanks
091500141008     C     xitcgr3       chain     hypercarr                          52
091600141008     C                   if        *in52 = '0'
091700141008     C                   movel(P)  hcname        dtcar3
091800141008     C                   endif
091900141008     C                   endif
092000141008      *
092100141008     C                   if        xitcgr4 <> *blanks
092200141008     C     xitcgr4       chain     hypercarr                          52
092300141008     C                   if        *in52 = '0'
092400141008     C                   movel(P)  hcname        dtcar4
092500141008     C                   endif
092600141008     C                   endif
092700141008      *
092800141008     C                   if        xitcgr5 <> *blanks
092900141008     C     xitcgr5       chain     hypercarr                          52
093000141008     C                   if        *in52 = '0'
093100141008     C                   movel(P)  hcname        dtcar5
093200141008     C                   endif
093300141008     C                   endif
093400141008      *
093500141008     C                   if        xitcgr6 <> *blanks
093600141008     C     xitcgr6       chain     hypercarr                          52
093700141008     C                   if        *in52 = '0'
093800141008     C                   movel(P)  hcname        dtcar6
093900141008     C                   endif
094000141008     C                   endif
094100141008      *
094200141008     C                   if        xitcgr7 <> *blanks
094300141008     C     xitcgr7       chain     hypercarr                          52
094400141008     C                   if        *in52 = '0'
094500141008     C                   movel(P)  hcname        dtcar7
094600141008     C                   endif
094700141008     C                   endif
094800141008      *
094900141008     C                   if        xitcgr8 <> *blanks
095000141008     C     xitcgr8       chain     hypercarr                          52
095100141008     C                   if        *in52 = '0'
095200141008     C                   movel(P)  hcname        dtcar8
095300141008     C                   endif
095400141008     C                   endif
095500141008      *
095600141008     C                   if        xitcgr9 <> *blanks
095700141008     C     xitcgr9       chain     hypercarr                          52
095800141008     C                   if        *in52 = '0'
095900141008     C                   movel(P)  hcname        dtcar9
096000141008     C                   endif
096100141008     C                   endif
096200141008      *
096300141008     C                   if        xitcgr10 <> *blanks
096400141008     C     xitcgr10      chain     hypercarr                          52
096500141008     C                   if        *in52 = '0'
096600141008     C                   movel(P)  hcname        dtcar10
096700141008     C                   endif
096800141008     C                   endif
096900141008      *
097000141008     C                   if        xitcgr11 <> *blanks
097100141008     C     xitcgr11      chain     hypercarr                          52
097200141008     C                   if        *in52 = '0'
097300141008     C                   movel(P)  hcname        dtcar11
097400141008     C                   endif
097500141008     C                   endif
097600141008      *
097700141008     C                   if        xitcgr12 <> *blanks
097800141008     C     xitcgr12      chain     hypercarr                          52
097900141008     C                   if        *in52 = '0'
098000141008     C                   movel(P)  hcname        dtcar12
098100141008     C                   endif
098200141008     C                   endif
098300141008      *
098400141008     C                   if        xitcgr13 <> *blanks
098500141008     C     xitcgr13      chain     hypercarr                          52
098600141008     C                   if        *in52 = '0'
098700141008     C                   movel(P)  hcname        dtcar13
098800141008     C                   endif
098900141008     C                   endif
099000141008      *
099100141008     C                   if        xitcgr14 <> *blanks
099200141008     C     xitcgr14      chain     hypercarr                          52
099300141008     C                   if        *in52 = '0'
099400141008     C                   movel(P)  hcname        dtcar14
099500141008     C                   endif
099600141008     C                   endif
099700141008      *
099800141008     C                   if        xitcgr15 <> *blanks
099900141008     C     xitcgr15      chain     hypercarr                          52
100000141008     C                   if        *in52 = '0'
100100141008     C                   movel(P)  hcname        dtcar15
100200141008     C                   endif
100300141008     C                   endif
100400141008      *
100500141008     C                   if        xitcgr16 <> *blanks
100600141008     C     xitcgr16      chain     hypercarr                          52
100700141008     C                   if        *in52 = '0'
100800141008     C                   movel(P)  hcname        dtcar16
100900141008     C                   endif
101000141008     C                   endif
101100141008      *
101200141008     C                   if        xitcgr17 <> *blanks
101300141008     C     xitcgr17      chain     hypercarr                          52
101400141008     C                   if        *in52 = '0'
101500141008     C                   movel(P)  hcname        dtcar17
101600141008     C                   endif
101700141008     C                   endif
101800141008      *
101900141008     C                   if        xitcgr18 <> *blanks
102000141008     C     xitcgr18      chain     hypercarr                          52
102100141008     C                   if        *in52 = '0'
102200141008     C                   movel(P)  hcname        dtcar18
102300141008     C                   endif
102400141008     C                   endif
102500141008      *
102600141008     C                   if        xitcgr19 <> *blanks
102700141008     C     xitcgr19      chain     hypercarr                          52
102800141008     C                   if        *in52 = '0'
102900141008     C                   movel(P)  hcname        dtcar19
103000141008     C                   endif
103100141008     C                   endif
103200141008      *
103300141008     C                   if        xitcgr20 <> *blanks
103400141008     C     xitcgr20      chain     hypercarr                          52
103500141008     C                   if        *in52 = '0'
103600141008     C                   movel(P)  hcname        dtcar20
103700141008     C                   endif
103800141008     C                   endif
103900141008      *
104000150210     C                   eval      *in51 = '0'
104100150210     C                   eval      *in53 = '0'
104200150210     C                   eval      *in54 = '0'
104300150210     C                   eval      *in55 = '0'
104400141008      *
104500141008     C                   movel(P)  desc1         cttxt1
104600141008     C                   movel(P)  desc2         cttxt2
104700141008     C                   movel(P)  desc3         cttxt3
104800141008     C                   movel(P)  desc4         cttxt4
104900141008      *
105000141009     C     *IN01         DOWEQ     *OFF
105100141009      *
105200141008     C                   exfmt     chgiss
105300141008      *>>>>>>>>
105400141008      *
105500141008     C                   IF        *IN01 = *ON
105600141008     C                   eval      smsg = *blanks
105700141009     C****??             if        typflg <> 'M'
105800141009     C**                 eval      ssnod = *blanks
105900141009     C**                 eval      mbrnam = *blanks
106000141009     C****??             endif
106100141008     C                   MOVE      *Off          *IN01
106200141008     C                   leavesr
106300141008     C                   endif
106400141009      *
106500141009     C                   IF        *IN02 = *ON
106600141009     C                   exsr      selreq
106700141009     C                   movel(P)  wrqdsc        ctresp
106800141009     C                   movel(P)  wreq          ctrespc
106900141009     C                   MOVE      *Off          *IN02
107000141009     C                   endif
107100141009      *
107200141009     C                   IF        *IN03 = *ON
107300141009     C                   exsr      selvew
107400141009     C                   movel(P)  wvwdsc        ctview
107500141009     C                   movel(P)  wvew          ctviewc
107600141009     C                   MOVE      *Off          *IN03
107700141009     C                   endif
107800141009      *
107900141009     C                   IF        *IN04 = *ON
108000141009     C                   exsr      selref
108100141009     C                   movel(P)  wrfdsc        ctrefr
108200141009     C                   movel(P)  wref          ctrefrc
108300141009     C                   MOVE      *Off          *IN04
108400141009     C                   endif
108500141009      *
108600141009     C                   IF        *IN05 = *ON
108700141009     C                   exsr      selcgr
108800141009     C                   MOVE      *Off          *IN05
108900141009     C                   endif
109000150211      *
109100150211     C                   IF        *IN19 = *ON
109200150211     C                   exsr      isscls
109300150211     C                   MOVE      *Off          *IN19
109400150211     C                   leavesr
109500150211     C                   endif
109600150211      *     Enter Key - Update
109700150211     C******             IF        *IN14 = *ON
109800141010     C                   exsr      edtchg
109900150211     C******             MOVE      *Off          *IN14
110000141009      *
110100141010     C                   IF        edtcln = 'Y'
110200141010     C                   exsr      chgrec
110300141010     C                   if        chgind = 'Y'
110400141010     C                   leavesr
110500141010     C                   endif
110600141010     C                   endif
110700141009      *
110800150211     C*******            endif
110900141014      *
111000141008     C                   ENDDO
111100141008      *
111200141009     C                   endif
111300141009      *
111400141008     C                   ENDSR
111500141010      ******************************************************************
111600141010      *       SUBROUTINE - EDTCHG                                      *
111700141010      *                    Edit Change data for validity               *
111800141010      ******************************************************************
111900141010     C     edtchg        BEGSR
112000141010      *
112100141010     C                   eval      edtcln = 'N'
112200141010     C                   eval      smsg = *blanks
112300141010      *
112400141020     C                   eval      *in51 = '0'
112500150731     C********           IF        ctfudt <> 0
112600141010     C     *USA          test(D)                 ctfudt                 57
112700141010     C                   if        *in57 = '1'
112800141010     C                   eval      smsg = fuderr
112900141020     C                   eval      *in51 = '1'
113000141010     C                   leavesr
113100141010     C                   endif
113200141014      *
113300141014     C                   movel     ctfudt        mdydt
113400141014     C                   eval      ymdyy = mdyyy
113500141014     C                   eval      ymdmd = mdymd
113600141015     C                   if        ymddt < todate and ymddt <> xitfudt
113700141014     C                   eval      smsg = fuderx
113800141020     C                   eval      *in51 = '1'
113900141014     C                   leavesr
114000141014     C                   endif
114100141014      *
114200150731     C*********          endif
114300141010      *
114400141020     C                   eval      *in53 = '0'
114500141010     C                   IF        ctsbjt = *blanks
114600141010     C                   eval      smsg = blksjt
114700141020     C                   eval      *in53 = '1'
114800141010     C                   leavesr
114900141010     C                   endif
115000141010      *
115100141010     C                   IF        ctview = *blanks
115200141010     C                   eval      smsg = blkvew
115300141010     C                   leavesr
115400141010     C                   endif
115500141010      *
115600141020     C                   eval      *in54 = '0'
115700141010     C                   IF        ctrefd <> 0
115800141010     C     *USA          test(D)                 ctrefd                 57
115900141010     C                   if        *in57 = '1'
116000141010     C                   eval      smsg = rfderr
116100141020     C                   eval      *in54 = '1'
116200141010     C                   leavesr
116300141010     C                   endif
116400141014      *
116500141014     C                   movel     ctrefd        mdydt
116600141014     C                   eval      ymdyy = mdyyy
116700141014     C                   eval      ymdmd = mdymd
116800141015     C                   if        ymddt < todate and ymddt <> xitrefd
116900141014     C                   eval      smsg = rfderx
117000141020     C                   eval      *in54 = '1'
117100141014     C                   leavesr
117200141014     C                   endif
117300141014      *
117400141010     C                   endif
117500141010      *
117600150217     C                   IF        carc20 = *blanks
117700150217     C                   eval      smsg = blkcar
117800141010     C                   leavesr
117900141010     C                   endif
118000150427      *
118100150427     C                   eval      *in56 = '0'
118200150427     C                   IF        ctcarx <> ' '
118300150427     C                   eval      smsg = crcblx
118400150427     C                   eval      *in56 = '1'
118500150427     C                   eval      ctcarx = ' '
118600150427     C                   leavesr
118700150427     C                   endif
118800150217      *
118900150217     C                   eval      *in55 = '0'
119000150217     C                   IF        cttxt1 = *blanks
119100150217     C                   eval      smsg = blktxt
119200150217     C                   eval      *in55 = '1'
119300150217     C                   leavesr
119400150217     C                   endif
119500141010      *
119600141010     C                   eval      edtcln = 'Y'
119700141010      *
119800141010     C                   ENDSR
119900141010      ******************************************************************
120000141010      *       SUBROUTINE - CHGREC                                      *
120100141010      *                    Change Issue record                         *
120200141010      ******************************************************************
120300141010     C     chgrec        BEGSR
120400141010      *
120500141010     C                   movel     ctfudt        mdydt
120600141010     C                   eval      ymdyy = mdyyy
120700141010     C                   eval      ymdmd = mdymd
120800141010     C                   eval      xitfudt = ymddt
120900141010      *
121000141010     C                   eval      xitvewc = ctviewc
121100141010     C                   eval      xittypc = cttypc
121200141010     C                   eval      xitrefr = ctrefrc
121300141010     C                   eval      xitresp = ctrespc
121400141010     C                   eval      xitsbjt = ctsbjt
121500141010      *
121600141010     C                   movel     ctrefd        mdydt
121700141010     C                   eval      ymdyy = mdyyy
121800141010     C                   eval      ymdmd = mdymd
121900141010     C                   eval      xitrefd = ymddt
122000141010      *
122100141010     C                   movel     ctreft        xitreft
122200141010     C                   movel     carc20        cari20
122300141010      *
122400141010     C                   movel     cttxt480      xitdesc
122500141010     C                   eval      chgind = 'N'
122600141010      *      Check to see if anything changed
122700141010     C                   if        xitdesc = svdesc and
122800141010     C                             cari20 = svcarr and
122900141010     C                             itcur = itsav
123000141010     C                   eval      smsg = noochg
123100141010     C                   leavesr
123200141010     C                   endif
123300141013     C                   eval      htypc = 'C'
123400141013      *         Write Hist Rec for Carrier Change
123500141013     C                   if        cari20 <> svcarr
123600141013     C                   movel     cr20chg       itxt
123700141013     C                   exsr      wrthst
123800141013     C                   endif
123900141013      *         Write Hist Rec for Description Change
124000141013     C                   if        xitdesc <> svdesc
124100141013     C                   movel     descchg       itxt
124200141013     C                   exsr      wrthst
124300141013     C                   endif
124400141013      *         Write Hist Rec for Description Change
124500141013     C                   if        itcur <> itsav
124600141013     C                   if        xitfudt <> svfudt
124700141013     C                   movel     fudtchg       itxt
124800141013     C                   exsr      wrthst
124900141013     C                   endif
125000141013     C                   if        xitvewc <> svvewc
125100141013     C                   movel     vewcchg       itxt
125200141013     C                   exsr      wrthst
125300141013     C                   endif
125400141013     C                   if        xittypc <> svtypc
125500141013     C                   movel     typcchg       itxt
125600141013     C                   exsr      wrthst
125700141013     C                   endif
125800141013     C                   if        xitsbjt <> svsbjt
125900141013     C                   movel     sbjtchg       itxt
126000141013     C                   exsr      wrthst
126100141013     C                   endif
126200141014     C                   if        xitrefr <> svrefr
126300141014     C                   movel     refrchg       itxt
126400141013     C                   exsr      wrthst
126500150724     C                   exsr      refceml
126600141013     C                   endif
126700141013     C                   if        xitreft <> svreft
126800141013     C                   movel     reftchg       itxt
126900141013     C                   exsr      wrthst
127000141013     C                   endif
127100141013     C                   if        xitrefd <> svrefd
127200141013     C                   movel     refdchg       itxt
127300141013     C                   exsr      wrthst
127400141013     C                   endif
127500141013     C                   if        xitresp <> svresp
127600141013     C                   movel     respchg       itxt
127700141013     C                   exsr      wrthst
127800141013     C                   endif
127900141013     C                   endif
128000141010      *         If changes were made, update record
128100141010      *
128200141010     C                   update    itissx
128300141010     C                   eval      chgind = 'Y'
128400141010      *
128500141010     C                   ENDSR
128600150724      ******************************************************************
128700150724      *       SUBROUTINE - REFCEML                                     *
128800150724      *                    Call CL to email referral change notice     *
128900150724      ******************************************************************
129000150724     C     refceml       BEGSR
129100151124      *
129200151124     C                   if        xitrefr = '   '
129300151124     C                   leavesr
129400151124     C                   endif
129500151124      *      Create To Line
129600151124     C                   eval      rfeto = *blanks
129700150724     C                   SELECT
129800150724     C                   when      xitrefr = 'BSC'
129900150724     C                   eval      rfeto = 'bscarfield@gbsio.net'
130000150724     C                   when      xitrefr = 'CBL'
130100150724     C                   eval      rfeto = 'cblizzard@gbsio.net '
130200150724     C                   when      xitrefr = 'CFA'
130300150724     C                   eval      rfeto = 'cfallin@gbsio.net   '
130400150724     C                   when      xitrefr = 'CFB'
130500150724     C                   eval      rfeto = 'cfabiszak@gbsio.net '
130600150724     C                   when      xitrefr = 'CWH'
130700150724     C                   eval      rfeto = 'cwhitehead@gbsio.net'
130800150724     C                   when      xitrefr = 'DCL'
130900150724     C                   eval      rfeto = 'dclark@gbsio.net    '
131000150724     C                   when      xitrefr = 'LKE'
131100150724     C                   eval      rfeto = 'lketterman@gbsio.net'
131200150724     C                   when      xitrefr = 'SRA'
131300150817     C                   eval      rfeto = 'srapski@gbsio.net   '
131400150724     C                   other
131500150724     C                   eval      rfeto = 'rjones@gbsio.net    '
131600150724     C                   ENDSL
131700150724      *
131800150724      *      Create Subject Line
131900150724     C                   eval      rfesub = *blanks
132000150724     C                   if        xitmssn = 0
132100150724      *          Account Issue
132200150724DTAQ C                   movel     trust         trusta            3
132300150724DTAQ C                   movel     subno         subnoa            3
132400150724DTAQ C                   movel     accno         accnoa            4
132500150724     C                   eval      rfesub = ('Issue Tracking - ' + trusta +
132600150724     C                             '-' + subnoa + '-' + accnoa + ' - ' +
132700150724     C                             accnam)
132800150724     C                   else
132900150724      *          Member Issue
133000150724     C                   eval      rfesub = ('Issue Tracking - ' + ssnod +
133100150724     C                             ' - ' + mbrnam)
133200150724     C                   endif
133300150724      *      Create Email Text
133400150724     C                   eval      rfetxt = *blanks
133500150724DTAQ C                   movel     ctiss#        atiss#a           6
133600150724      *
133700150724     C                   movel     xitfudt       wkdate
133800150724     C                   eval      usadt = wkdate
133900150724     C                   movel     usadt         emfudt           10
134000150724      *
134100150724     C                   eval      rfetxt = ('Iss Trk Issue# ' +
134200150724     C                             atiss#a + ' has been changed ' +
134300150724     C                             'and is now referred to you. ' +
134400150724     C                             ':/NFollow up date is ' +
134500150724     C                             emfudt + '. Type is ' +
134600150724     C                             %TRIM(attypd) + '. ' +
134700150724     C                             ':/NReferral Text : "' +
134800150724     C                             %TRIM(xitreft) + '" ' +
134900150724     C                             ':/N:/NIssue Details : "' +
135000150724     C                             %TRIM(xitdesc) + '".')
135100150724      *
135200150724     C                   CALL      'ITEMAILC'
135300150724     C                   PARM                    rfeto
135400150724     C                   PARM                    rfesub
135500150724     C                   PARM                    rfetxt
135600150724      *
135700150724      *          Write IT Hist record
135800150724      *
135900150724      *           Get next hist#
136000150724     C                   z-add     xitiss#       hiss#
136100150724     C                   z-add     99999         hhis#
136200150724     C     hiskey        setgt     ithisp
136300150724     C                   readp     ithisp                                 24
136400150724     C                   if        *in24 = '1' or xitiss# <> hiss#
136500150724     C                   z-add     01            svhis#
136600150724     C                   else
136700150724     C     ihhis#        add       01            svhis#
136800150724     C                   endif
136900150724      *
137000150724     C                   clear                   ithisr
137100150724      *
137200150724     C                   eval      ihiss# = xitiss#
137300150724     C                   eval      ihhis# = svhis#
137400150724      *
137500150724     C                   CLEAR                   @TIMESTAMP
137600150724     C                   MOVE      *BLANKS       @TS40
137700150724     C                   CALL      'TIMESTMP'
137800150724     C                   PARM                    @TS40
137900150724      *
138000150724     C                   movel     @TS40         @TIMESTAMP
138100150724     C                   movel     @TSUSER       ihuser
138200150724     C                   move      #TSCYMD       svdato
138300150724     C                   move      #TSTIME       svtimo
138400150724    * *
138500150724     C                   movel     svdato        ihdate
138600150724     C                   movel     svtimo        ihtime
138700150724      *
138800150724     C                   eval      ihtypc = 'H'
138900150724      *
139000150724     C                   eval      ihtext = 'REFERRAL CHANGE EMAIL SENT TO ' +
139100150724     C                             %TRIM(atrefr) + '.'
139200150724      *
139300150724     C                   write     ithisr
139400150724      *
139500150724     C                   ENDSR
139600141014      ******************************************************************
139700141014      *       SUBROUTINE - ISSCLS                                      *
139800141014      *                    Close Issue                                 *
139900141014      ******************************************************************
140000141014     C     isscls        BEGSR
140100141014      *
140200141014     C                   eval      smsg = *blanks
140300141014      *
140400141014     C                   if        dtiss# = 0
140500141014     C     xitiss#       chain     itissl                             22
140600141014     C                   if        *in22 = '0'
140700141014      *   If Member display - fill in Mbr hdr fields
140800141014     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
140900141014     C                   movel     nssn          ssnod
141000141014     C     nssn          chain     member                             32
141100141014     C                   if        *in32 = '0'
141200141014     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
141300141014     C                             %TRIM(mfname)
141400141014     C                   endif
141500141014     C                   endif
141600141014      *
141700141014     C                   movel     xitiss#       dtiss#
141800141014     C                   movel     xitinit       dtinit
141900141014      *
142000141014     C                   movel     xitdato       wkdate
142100141014     C                   eval      usadt = wkdate
142200141014     C                   movel     usadt         dtdato
142300141014      *
142400141014     C                   eval      dttimo = %EDITW(xittimo:'0 :  :  ')
142500141014      *
142600141014     C                   if        xitdatc = 0
142700141014     C                   movel(P)  'OPEN'        dtdatc
142800141014     C                   else
142900141014     C                   movel     xitdatc       wkdate
143000141014     C                   eval      usadt = wkdate
143100141014     C                   movel     usadt         dtdatc
143200141014      *
143300141014     C                   eval      dttimc = %EDITW(xittimc:'0 :  :  ')
143400141014     C                   endif
143500141014      *
143600141014     C                   movel     xitfudt       wkdate
143700141014     C                   eval      usadt = wkdate
143800141014     C                   movel     usadt         dtfudt
143900141014      *
144000141014     C                   eval      cktyp = 'Q'
144100141014     C                   eval      ckcod = xitresp
144200141014     C     codkey        chain     itcodp                             32
144300141014     C                   if        *in32 = '0'
144400141014     C                   movel(P)  ictext        dtresp
144500141014     C                   endif
144600141014      *
144700141014     C                   eval      cktyp = 'T'
144800141014     C                   eval      ckcod = xittypc
144900141014     C     codkey        chain     itcodp                             32
145000141014     C                   if        *in32 = '0'
145100141014     C                   movel(P)  ictext        dttype
145200141014     C                   endif
145300141014      *
145400141014     C                   movel     xitsbjt       dtsbjt
145500141014      *
145600141014     C                   endif
145700141014     C                   endif
145800141014      *
145900141014      *
146000141014      *           Get next hist#
146100141014     C                   z-add     xitiss#       hiss#
146200141014     C                   z-add     99999         hhis#
146300141014     C     hiskey        setgt     ithisp
146400141014     C                   readp     ithisp                                 24
146500141014     C                   if        *in24 = '1' or xitiss# <> hiss#
146600141014     C                   z-add     01            svhis#
146700141014     C                   else
146800141014     C     ihhis#        add       01            svhis#
146900141014     C                   endif
147000141014     C                   z-add     atiss#        sviss#
147100141014      *
147200141014     C                   CLEAR                   @TIMESTAMP
147300141014     C                   MOVE      *BLANKS       @TS40
147400141014     C                   CALL      'TIMESTMP'
147500141014     C                   PARM                    @TS40
147600141014      *
147700141014     C                   movel     @TS40         @TIMESTAMP
147800141014     C                   movel     @TSUSER       hduser
147900141014     C                   move      #TSCYMD       svdato            8 0
148000141014     C                   move      #TSTIME       svtimo            6 0
148100141014    * *
148200141014     C                   movel     svdato        wkdate
148300141014     C                   eval      usadt = wkdate
148400141014     C                   movel     usadt         hddate
148500141014    * *
148600141014     C                   movel     svtimo        wktime
148700141014     C                   movel     wktime        hdtime
148800141014    * *
148900141014     C                   eval      hatxt1 = *blanks
149000141014     C                   eval      hatxt2 = *blanks
149100141014      *
149200141014     C     *IN01         DOWEQ     *OFF
149300141014      *
149400141014     C                   exfmt     clsiss
149500141014      *
149600141014     C                   IF        *IN01 = *ON
149700141014     C                   eval      smsg = *blanks
149800141014     C                   MOVE      *Off          *IN01
149900141014     C                   leavesr
150000141014     C                   endif
150100141014      *
150200141014     C                   IF        hatxt1 = *blanks and hatxt2 = *blanks
150300141014     C                   eval      smsg = nootxt
150400141014     C                   iter
150500141014     C                   endif
150600141014      *         Write new hist rec
150700141014      *
150800141014     C                   clear                   ithisr
150900141014      *
151000141014     C                   eval      ihiss# = xitiss#
151100141014     C                   eval      ihhis# = svhis#
151200141014      *
151300141014     C                   CLEAR                   @TIMESTAMP
151400141014     C                   MOVE      *BLANKS       @TS40
151500141014     C                   CALL      'TIMESTMP'
151600141014     C                   PARM                    @TS40
151700141014      *
151800141014     C                   movel     @TS40         @TIMESTAMP
151900141014     C                   movel     @TSUSER       ihuser
152000141014     C                   move      #TSCYMD       svdato
152100141014     C                   move      #TSTIME       svtimo
152200141014    * *
152300141014     C                   movel     svdato        ihdate
152400141014     C                   movel     svtimo        ihtime
152500141014      *
152600141014     C                   eval      ihtypc = 'C'
152700141014      *
152800141014     C                   movel(P)  hatxt1        ihtext
152900141014     C                   move      hatxt2        ihtext
153000141014      *
153100141014     C                   write     ithisr
153200141014      *          Write close Hist rec
153300141014     C                   eval      ihhis# = ihhis# + 1
153400141014     C                   eval      ihtypc = 'H'
153500141014     C                   movel(P)  'ISSUE CLOSED'ihtext
153600141014     C                   write     ithisr
153700141014      *          Update Issue rec w/ close info
153800141014     C                   eval      xitsts = 'C'
153900141014     C                   eval      xitdatc = svdato
154000141014     C                   eval      xittimc = svtimo
154100141014      *
154200141014     C                   update    itissx
154300141014      *
154400150915     C                   eval      dtiss# = 0
154500150915      *
154600150514     C                   exsr      clhist
154700150514      *
154800141014     C                   leavesr
154900141014      *
155000141014     C                   ENDDO
155100141014      *
155200141014     C                   ENDSR
155300150514      ******************************************************************
155400150514      *       SUBROUTINE - CLHIST                                      *
155500150514      *                    Write HIST rec for Issue Closed             *
155600150514      ******************************************************************
155700150514     C     clhist        BEGSR
155800150514      *
155900150514     C                   clear                   histr
156000150514     C                   if        xitmssn = 0
156100150514      *        Account Hist Rec
156200150514     C                   move      xittrst       htrst
156300150514     C                   move      xitsub#       hsub#
156400150514     C                   move      xitacct       hacct
156500150514     C                   move      histtsa       hkey
156600150514     C                   else
156700150514      *        Member Hist Rec
156800150514     C                   move      xitmssn       hkey
156900150514     C                   endif
157000150514      *  >>>>
157100150514     C                   movel     #TSCYMD       trdate
157200150514     C                   move      'UIC'         trcode
157300150514     C                   Z-ADD     0             TRAMT
157400150514     C                   MOVE      *BLANKS       CM$FLG
157500150514     C                   MOVE      XITISS#       itissa
157600150514     C                   eval      ck#not = hstopn1 + itissa + ' CLOSED'
157700150604     C                   MOVEL     xitsbjt       NOTE2
157800150514     C                   MOVEL     'IQ016'       HPRGNM
157900150514     C                   Z-ADD     0             RECVDT
158000150514     C                   z-add     xittrst       HSTRST
158100150514     C                   z-add     xitsub#       HSSUB#
158200150514     C                   z-add     xitacct       HSACCT
158300150514DTAQ C                   movel     @TSUSER       hoper
158400150514     C                   MOVEL     'A'           HSDLTD
158500150514      *
158600150514     C                   MOVE      #TSCYMD       trdate
158700150514     c                   move      #TSTIME       hstrtime
158800150514      *
158900150514     C                   WRITE     HISTR
159000150514      *
159100150514     C                   ENDSR
159200140815      ******************************************************************
159300140815      *       SUBROUTINE - ISSADD                                      *
159400140815      *                    Add a new Issue Rec                         *
159500140815      ******************************************************************
159600140815     C     issadd        BEGSR
159700140815     C*                  eval      selof = 'N'
159800140815     C*                  eval      selhy = 'N'
159900140815     C*                  eval      seldn = 'N'
160000140815      *
160100140815     C                   eval      wtyp = '   '
160200140815     C****               eval      seltp = 'N'
160300140815     C                   exsr      seltyp
160400140815     C                   if        wtyp = '   '
160500140815     C                   leavesr
160600140815     C                   endif
160700140815      *
160800140815     C                   eval      smsg = *blanks
160900140815     C*                  eval      *in68 = *off
161000140815      *
161100140815      *           Get next issue #
161200140818     C                   z-add     999999        niss#
161300140818     C     niss#         setgt     itissl
161400150528     C                   readp(N)  itissl                                 24
161500140818     C                   if        *in24 = '1'
161600140815     C                   z-add     01            atiss#
161700140815     C                   else
161800140818     C     xitiss#       add       01            atiss#
161900140815     C                   endif
162000141014     C                   z-add     atiss#        sviss#
162100140815      *
162200140815      *
162300140815     C                   CLEAR                   @TIMESTAMP
162400140815     C                   MOVE      *BLANKS       @TS40
162500140815     C                   CALL      'TIMESTMP'
162600140815     C                   PARM                    @TS40
162700140815      *
162800140815     C                   movel     @TS40         @TIMESTAMP
162900140815     C                   movel     @TSUSER       atinit
163000140904     C                   move      #TSCYMD       svdato            8 0
163100140904     C                   move      #TSTIME       svtimo            6 0
163200140904    * *
163300140904     C                   movel     svdato        wkdate
163400140904     C                   eval      usadt = wkdate
163500140904     C                   movel     usadt         atdato
163600140904    * *
163700140904    * *
163800140904     C                   movel     svtimo        wktime
163900140904     C                   movel     wktime        attimo
164000140904      *
164100140904     C                   exsr      calcfudt
164200140903     C                   movel     wtfudt        wkdate
164300140904     C                   eval      usadt = wkdate
164400140904     C                   movel     wtfudt        ymddt
164500140904     C                   eval      mdymd = ymdmd
164600140903     C                   eval      mdyyy = ymdyy
164700140826     C                   movel     mdydt         atfudt
164800140822      *
164900140815     C                   eval      atresp = *blanks
165000140815     C                   eval      attypc = wtyp
165100140815     C                   eval      attypd = wttdsc
165200140815     C                   eval      atsbjt = *blanks
165300140815     C                   eval      atview = *blanks
165400140815     C                   eval      atrefr = *blanks
165500140815     C                   eval      atreft = *blanks
165600140815     C                   eval      atrefd = 0
165700140815     C                   eval      attxt1 = *blanks
165800140815     C                   eval      attxt2 = *blanks
165900140815     C                   eval      attxt3 = *blanks
166000140815     C                   eval      attxt4 = *blanks
166100141010     C                   eval      carr20 = *blanks
166200141010     C                   eval      carc20 = *blanks
166300150210      *
166400150210     C                   eval      *in51 = '0'
166500150210     C                   eval      *in53 = '0'
166600150210     C                   eval      *in54 = '0'
166700150210     C                   eval      *in55 = '0'
166800150427     C                   eval      *in56 = '0'
166900150210      *
167000140815     C     *IN01         DOWEQ     *OFF
167100140815      *
167200140815     C******             if        selof <> 'Y' and
167300140815     C*                            selhy <> 'Y' and
167400140815     C*                            seldn <> 'Y' and
167500140815     C*******                      smsg = *blanks
167600140815      *
167700140815     C*******            endif
167800140815      *
167900140815     C                   exfmt     addiss
168000140815      *
168100140815     C                   IF        *IN01 = *ON
168200140815     C                   eval      smsg = *blanks
168300140926     C                   MOVE      *Off          *IN01
168400140815     C                   leavesr
168500140815     C                   endif
168600140826      *
168700140826     C                   IF        *IN02 = *ON
168800140826     C                   exsr      selreq
168900140826     C                   movel(P)  wrqdsc        atresp
169000140926     C                   movel(P)  wreq          atrespc
169100140826     C                   MOVE      *Off          *IN02
169200150211     C                   iter
169300150211     C                   endif
169400140826      *
169500140826     C                   IF        *IN03 = *ON
169600140826     C                   exsr      selvew
169700140826     C                   movel(P)  wvwdsc        atview
169800140926     C                   movel(P)  wvew          atviewc
169900140826     C                   MOVE      *Off          *IN03
170000150211     C                   iter
170100140826     C                   endif
170200140826      *
170300140826     C                   IF        *IN04 = *ON
170400140826     C                   exsr      selref
170500140826     C                   movel(P)  wrfdsc        atrefr
170600140926     C                   movel(P)  wref          atrefrc
170700140826     C                   MOVE      *Off          *IN04
170800150211     C                   iter
170900140826     C                   endif
171000140827      *
171100140827     C                   IF        *IN05 = *ON
171200140827     C                   exsr      selcgr
171300140909     C                   MOVE      *Off          *IN05
171400150211     C                   iter
171500140827     C                   endif
171600150211      *          ENTER - Add record
171700150211     C********           IF        *IN14 = *ON
171800140909     C                   exsr      edtinp
171900150211     C********           MOVE      *Off          *IN14
172000140926      *
172100140926     C                   IF        edtcln = 'Y'
172200140926     C                   exsr      wrtiss
172300141010      *
172400141010     C                   eval      htypc = 'H'
172500141010     C                   eval      itxt = 'ISSUE ' +
172600141010     C                             %TRIM(%EDITC(xitiss#:'4'))+' OPENED'
172700141010     C                   exsr      wrthst
172800141010      *
172900140926     C                   leavesr
173000140909     C                   endif
173100140909      *
173200150211     C********           endif
173300140926      *
173400140815     C                   ENDDO
173500140815      *
173600140815     C                   ENDSR
173700140815      ******************************************************************
173800140819      *       SUBROUTINE - CALCFUDT                                    *
173900140819      *                    Calculate Follow up Date                    *
174000140815      ******************************************************************
174100140819     C     calcfudt      BEGSR
174200140819     C                   movel     todate        wtfudt
174300140819     C                   if        wttday < 1
174400150227     C                   leavesr
174500150227     C                   endif
174600150227      *
174700150227     C                   move      wtfudt        wkdate
174800150227     C                   dow       wttday > 0
174900150227     C                   adddur    1:*D          wkdate
175000150227     C     wkdate        subdur    basedate      wkfld:*D
175100150227     C                   div       7             wkfld
175200150227     C                   mvr                     dayowk
175300150227     C                   if        dayowk <> 0 and dayowk <> 1
175400150227     C                   eval      wttday = wttday - 1
175500140819     C                   endif
175600140819     C                   enddo
175700140819      *
175800140819     C                   move      wkdate        wtfudt
175900140819      *
176000140815     C                   ENDSR
176100140819      ******************************************************************
176200140819      *       SUBROUTINE - SELTYP                                      *
176300140819      *                    Select Issue Type                           *
176400140819      ******************************************************************
176500140819     C     seltyp        BEGSR
176600140819     C     *IN01         DOWEQ     *OFF
176700140819     C***  *IN07         ANDEQ     *OFF
176800140819      *
176900140819     C                   EXSR      $TCLEAR
177000140819     C                   EXSR      $TLOAD
177100140819     C                   EXSR      $TDISPLAY
177200140819      *    PROCESS SELECTION
177300140819     C     *IN01         IFEQ      *OFF
177400140819     C***  *IN07         ANDEQ     *OFF
177500140819     C***  RRN           ANDNE     *ZERO
177600140819     C                   eval      wtyp = '   '
177700140819     C                   EXSR      $TPROCES
177800140819     C*                  If        wofc# <> 0
177900150213     C                   movel     '0'           *in01
178000140819     C                   leavesr
178100140819     C*                  ENDIF
178200140819     C                   ENDIF
178300140819     C                   ENDDO
178400140819      *
178500140819     C                   movel     '0'           *in01
178600140819     C                   ENDSR
178700140815      ******************************************************************
178800140815      *       SUBROUTINE - $TCLEAR                                      *
178900140815      *                    CLEAR SUBF AND RRN                          *
179000140815      ******************************************************************
179100140815     C     $TCLEAR       BEGSR
179200140815     C                   MOVEA     '001'         *IN(61)
179300140815     C                   WRITE     HDTYP
179400140815     C                   Z-ADD     *ZERO         TRRN              3 0
179500140815     C                   WRITE     HDTYP
179600140815     C                   MOVEA     '010'         *IN(61)
179700140815     C                   ENDSR
179800140815      ******************************************************************
179900140815      *       SUBROUTINE - $TLOAD                                       *
180000140815      *                    LOAD SUBFILE W/ Issue Type Specs             *
180100140815      ******************************************************************
180200140815     C     $TLOAD        BEGSR
180300140819     C                   eval      cktyp = 'T'
180400140819     C                   eval      ckcod = *blanks
180500140819     C     codkey        SETLL     itcodp
180600140819     C                   SETOFF                                       6496
180700140819     C     *IN64         DOUEQ     *ON
180800140819     C     *IN96         OREQ      *ON
180900140819     C                   READ      itcodp                                 64
181000140819     C                   IF        (*In64 <> *ON)
181100140815      *
181200140819     C                   IF        ictype <> 'T'
181300140819     C                   leave
181400140819     C                   endif
181500140815      *
181600140815     C                   ADD       1             TRRN
181700140819     C                   MOVEL     iccode        sttcod
181800140819     C                   movel(P)  ictext        sttdsc
181900140819     C                   movel(P)  icdays        sttday
182000140815     C                   WRITE     dettyp
182100140815      *
182200140819     C                   endif
182300140819     C                   enddo
182400140815     C                   ENDSR
182500140815      ******************************************************************
182600140815      *       SUBROUTINE - $TDISPLAY                                    *
182700140815      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
182800140815      ******************************************************************
182900140815     C     $TDISPLAY     BEGSR
183000140815     C                   If        TRRN <> *Zero
183100140815     C                   MOVE      *ON           *IN61
183200140815     C                   ENDIF
183300140815     C                   WRITE     TRTYP
183400140815     C                   EXFMT     HDTYP
183500140815     C                   ENDSR
183600140815      ******************************************************************
183700140815      *       SUBROUTINE - $TPROCES                                     *
183800140815      *                    PROCESS THE SELECTION                       *
183900140815      ******************************************************************
184000140815     C     $TPROCES      BEGSR
184100140815     C     *IN96         DOUEQ     *ON
184200140815      *
184300140815     C                   READC     DETTYP                                 96
184400140815     C                   IF        *IN96 = *OFF
184500140815      *      Select Hyg
184600140815     C                   IF        SEL1 = '1'
184700140815     C                   eval      wtyp = sttcod
184800140815     C                   eval      wttdsc = sttdsc
184900140819     C                   eval      wttday = sttday
185000140815     C                   leavesr
185100140815     C                   endif
185200140815      *
185300140815     C                   CLEAR                   SEL1
185400140815     C                   UPDATE    DETTYP
185500140815     C                   ENDIF
185600140815     C                   ENDDO
185700140815     C                   ENDSR
185800140826      ******************************************************************
185900140826      *       SUBROUTINE - SELREQ                                      *
186000140826      *                    Select Response Requested From              *
186100140826      ******************************************************************
186200140826     C     selreq        BEGSR
186300140826     C     *IN01         DOWEQ     *OFF
186400140826      *
186500140826     C                   EXSR      $QCLEAR
186600140826     C                   EXSR      $QLOAD
186700140826     C                   EXSR      $QDISPLAY
186800140826      *    PROCESS SELECTION
186900140826     C     *IN01         IFEQ      *OFF
187000140826     C***  *IN07         ANDEQ     *OFF
187100140826     C***  RRN           ANDNE     *ZERO
187200140826     C                   eval      wreq = '   '
187300140826     C                   EXSR      $QPROCES
187400140826     C*                  If        wofc# <> 0
187500150213     C                   movel     '0'           *in01
187600140826     C                   leavesr
187700140826     C*                  ENDIF
187800140826     C                   ENDIF
187900140826     C                   ENDDO
188000140826      *
188100140826     C                   movel     '0'           *in01
188200140826     C                   ENDSR
188300140826      ******************************************************************
188400140826      *       SUBROUTINE - $QCLEAR                                      *
188500140826      *                    CLEAR SUBF AND RRN                          *
188600140826      ******************************************************************
188700140826     C     $QCLEAR       BEGSR
188800140826     C                   MOVEA     '001'         *IN(61)
188900140826     C                   WRITE     HDREQ
189000140826     C                   Z-ADD     *ZERO         QRRN              3 0
189100140826     C                   WRITE     HDREQ
189200140826     C                   MOVEA     '010'         *IN(61)
189300140826     C                   ENDSR
189400140826      ******************************************************************
189500140826      *       SUBROUTINE - $QLOAD                                       *
189600140826      *                    LOAD SUBFILE W/ Resp Req From Specs          *
189700140826      ******************************************************************
189800140826     C     $QLOAD        BEGSR
189900140826     C                   eval      cktyp = 'Q'
190000140826     C                   eval      ckcod = *blanks
190100140826     C     codkey        SETLL     itcodp
190200140826     C                   SETOFF                                       6496
190300140826     C     *IN64         DOUEQ     *ON
190400140826     C     *IN96         OREQ      *ON
190500140826     C                   READ      itcodp                                 64
190600140826     C                   IF        (*In64 <> *ON)
190700140826      *
190800140826     C                   IF        ictype <> 'Q'
190900140826     C                   leave
191000140826     C                   endif
191100140826      *
191200140826     C                   ADD       1             QRRN
191300140826     C                   MOVEL     iccode        srqcod
191400140826     C                   movel(P)  ictext        srqdsc
191500140826     C                   WRITE     detreq
191600140826      *
191700140826     C                   endif
191800140826     C                   enddo
191900140826     C                   ENDSR
192000140826      ******************************************************************
192100140826      *       SUBROUTINE - $QDISPLAY                                    *
192200140826      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
192300140826      ******************************************************************
192400140826     C     $QDISPLAY     BEGSR
192500140826     C                   If        QRRN <> *Zero
192600140826     C                   MOVE      *ON           *IN61
192700140826     C                   ENDIF
192800140826     C                   WRITE     TRREQ
192900140826     C                   EXFMT     HDREQ
193000140826     C                   ENDSR
193100140826      ******************************************************************
193200140826      *       SUBROUTINE - $QPROCES                                     *
193300140826      *                    PROCESS THE SELECTION                       *
193400140826      ******************************************************************
193500140826     C     $QPROCES      BEGSR
193600140826     C     *IN96         DOUEQ     *ON
193700140826      *
193800140826     C                   READC     DETREQ                                 96
193900140826     C                   IF        *IN96 = *OFF
194000140826      *      Select Resp Req From
194100140826     C                   IF        SEL2 = '1'
194200140826     C                   eval      wreq = srqcod
194300140826     C                   eval      wrqdsc = srqdsc
194400140826     C                   leavesr
194500140826     C                   endif
194600140826      *
194700140826     C                   CLEAR                   SEL2
194800140826     C                   UPDATE    DETREQ
194900140826     C                   ENDIF
195000140826     C                   ENDDO
195100140826     C                   ENDSR
195200140826      ******************************************************************
195300140826      *       SUBROUTINE - SELREF                                      *
195400140826      *                    Select Referral                             *
195500140826      ******************************************************************
195600140826     C     selref        BEGSR
195700140826     C     *IN01         DOWEQ     *OFF
195800140826     C***  *IN07         ANDEQ     *OFF
195900140826      *
196000140826     C                   EXSR      $RCLEAR
196100140826     C                   EXSR      $RLOAD
196200140826     C                   EXSR      $RDISPLAY
196300140826      *    PROCESS SELECTION
196400140826     C     *IN01         IFEQ      *OFF
196500140826     C***  *IN07         ANDEQ     *OFF
196600140826     C***  RRN           ANDNE     *ZERO
196700140826     C                   eval      wref = '   '
196800140826     C                   EXSR      $RPROCES
196900140826     C*                  If        wofc# <> 0
197000150213     C                   movel     '0'           *in01
197100140826     C                   leavesr
197200140826     C*                  ENDIF
197300140826     C                   ENDIF
197400140826     C                   ENDDO
197500140826      *
197600140826     C                   movel     '0'           *in01
197700140826     C                   ENDSR
197800140826      ******************************************************************
197900140826      *       SUBROUTINE - $RCLEAR                                      *
198000140826      *                    CLEAR SUBF AND RRN                          *
198100140826      ******************************************************************
198200140826     C     $RCLEAR       BEGSR
198300140826     C                   MOVEA     '001'         *IN(61)
198400140826     C                   WRITE     HDREF
198500140826     C                   Z-ADD     *ZERO         RRRN              3 0
198600140826     C                   WRITE     HDREF
198700140826     C                   MOVEA     '010'         *IN(61)
198800140826     C                   ENDSR
198900140826      ******************************************************************
199000140826      *       SUBROUTINE - $RLOAD                                       *
199100140826      *                    LOAD SUBFILE W/ Resferral Specs              *
199200140826      ******************************************************************
199300140826     C     $RLOAD        BEGSR
199400140826     C                   eval      cktyp = 'R'
199500140826     C                   eval      ckcod = *blanks
199600140826     C     codkey        SETLL     itcodp
199700140826     C                   SETOFF                                       6496
199800140826     C     *IN64         DOUEQ     *ON
199900140826     C     *IN96         OREQ      *ON
200000140826     C                   READ      itcodp                                 64
200100140826     C                   IF        (*In64 <> *ON)
200200140826      *
200300140826     C                   IF        ictype <> 'R'
200400140826     C                   leave
200500140826     C                   endif
200600140826      *
200700140826     C                   ADD       1             RRRN
200800140826     C                   MOVEL     iccode        srfcod
200900140826     C                   movel(P)  ictext        srfdsc
201000140826     C                   WRITE     detref
201100140826      *
201200140826     C                   endif
201300140826     C                   enddo
201400140826     C                   ENDSR
201500140826      ******************************************************************
201600140826      *       SUBROUTINE - $RDISPLAY                                    *
201700140826      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
201800140826      ******************************************************************
201900140826     C     $RDISPLAY     BEGSR
202000140826     C                   If        RRRN <> *Zero
202100140826     C                   MOVE      *ON           *IN61
202200140826     C                   ENDIF
202300140826     C                   WRITE     TRREF
202400140826     C                   EXFMT     HDREF
202500140826     C                   ENDSR
202600140826      ******************************************************************
202700140826      *       SUBROUTINE - $RPROCES                                     *
202800140826      *                    PROCESS THE SELECTION                       *
202900140826      ******************************************************************
203000140826     C     $RPROCES      BEGSR
203100140826     C     *IN96         DOUEQ     *ON
203200140826      *
203300140826     C                   READC     DETREF                                 96
203400140826     C                   IF        *IN96 = *OFF
203500140826      *      Select Resp Req From
203600140826     C                   IF        SEL4 = '1'
203700140826     C                   eval      wref = srfcod
203800140826     C                   eval      wrfdsc = srfdsc
203900140826     C                   leavesr
204000140826     C                   endif
204100140826      *
204200140826     C                   CLEAR                   SEL4
204300140826     C                   UPDATE    DETREF
204400140826     C                   ENDIF
204500140826     C                   ENDDO
204600140826     C                   ENDSR
204700140826      ******************************************************************
204800140826      *       SUBROUTINE - SELVEW                                      *
204900140826      *                    Select Viewable By                          *
205000140826      ******************************************************************
205100140826     C     selvew        BEGSR
205200140826     C     *IN01         DOWEQ     *OFF
205300140826     C***  *IN07         ANDEQ     *OFF
205400140826      *
205500140826     C                   EXSR      $VCLEAR
205600140826     C                   EXSR      $VLOAD
205700140826     C                   EXSR      $VDISPLAY
205800140826      *    PROCESS SELECTION
205900140826     C     *IN01         IFEQ      *OFF
206000140826     C***  *IN07         ANDEQ     *OFF
206100140826     C***  RRN           ANDNE     *ZERO
206200140826     C                   eval      wvew = '   '
206300140826     C                   EXSR      $VPROCES
206400140826     C*                  If        wofc# <> 0
206500150213     C                   movel     '0'           *in01
206600140826     C                   leavesr
206700140826     C*                  ENDIF
206800140826     C                   ENDIF
206900140826     C                   ENDDO
207000140826      *
207100140826     C                   movel     '0'           *in01
207200140826     C                   ENDSR
207300140826      ******************************************************************
207400140826      *       SUBROUTINE - $VCLEAR                                      *
207500140826      *                    CLEAR SUBF AND RRN                          *
207600140826      ******************************************************************
207700140826     C     $VCLEAR       BEGSR
207800140826     C                   MOVEA     '001'         *IN(61)
207900140826     C                   WRITE     HDVEW
208000140826     C                   Z-ADD     *ZERO         VRRN              3 0
208100140826     C                   WRITE     HDVEW
208200140826     C                   MOVEA     '010'         *IN(61)
208300140826     C                   ENDSR
208400140826      ******************************************************************
208500140826      *       SUBROUTINE - $VLOAD                                       *
208600140826      *                    LOAD SUBFILE W/ Viewable By                  *
208700140826      ******************************************************************
208800140826     C     $VLOAD        BEGSR
208900140826     C                   eval      cktyp = 'V'
209000140826     C                   eval      ckcod = *blanks
209100140826     C     codkey        SETLL     itcodp
209200140826     C                   SETOFF                                       6496
209300140826     C     *IN64         DOUEQ     *ON
209400140826     C     *IN96         OREQ      *ON
209500140826     C                   READ      itcodp                                 64
209600140826     C                   IF        (*In64 <> *ON)
209700140826      *
209800140826     C                   IF        ictype <> 'V'
209900140826     C                   leave
210000140826     C                   endif
210100140826      *
210200140826     C                   ADD       1             VRRN
210300140826     C                   MOVEL     iccode        svwcod
210400140826     C                   movel(P)  ictext        svwdsc
210500140826     C                   WRITE     detvew
210600140826      *
210700140826     C                   endif
210800140826     C                   enddo
210900140826     C                   ENDSR
211000140826      ******************************************************************
211100140826      *       SUBROUTINE - $VDISPLAY                                    *
211200140826      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
211300140826      ******************************************************************
211400140826     C     $VDISPLAY     BEGSR
211500140926     C                   If        VRRN <> *Zero
211600140826     C                   MOVE      *ON           *IN61
211700140826     C                   ENDIF
211800140826     C                   WRITE     TRVEW
211900140826     C                   EXFMT     HDVEW
212000140826     C                   ENDSR
212100140826      ******************************************************************
212200140826      *       SUBROUTINE - $VPROCES                                     *
212300140826      *                    PROCESS THE SELECTION                       *
212400140826      ******************************************************************
212500140826     C     $VPROCES      BEGSR
212600140826     C     *IN96         DOUEQ     *ON
212700140826      *
212800140826     C                   READC     DETVEW                                 96
212900140826     C                   IF        *IN96 = *OFF
213000140826      *      Select Resp Req From
213100140826     C                   IF        SEL3 = '1'
213200140826     C                   eval      wvew = svwcod
213300140826     C                   eval      wvwdsc = svwdsc
213400140826     C                   leavesr
213500140826     C                   endif
213600140826      *
213700140826     C                   CLEAR                   SEL3
213800140826     C                   UPDATE    DETVEW
213900140826     C                   ENDIF
214000140826     C                   ENDDO
214100140826     C                   ENDSR
214200140826      ******************************************************************
214300140826      *       SUBROUTINE - SELCGR                                      *
214400140826      *                    Select Carrier Grouper                      *
214500140826      ******************************************************************
214600140826     C     selcgr        BEGSR
214700140826     C     *IN01         DOWEQ     *OFF
214800140826     C***  *IN07         ANDEQ     *OFF
214900140826      *
215000140826     C                   EXSR      $CCLEAR
215100140826     C                   EXSR      $CLOAD
215200140826     C                   EXSR      $CDISPLAY
215300140826      *    PROCESS SELECTION
215400140826     C     *IN01         IFEQ      *OFF
215500140826     C***  *IN07         ANDEQ     *OFF
215600140826     C***  RRN           ANDNE     *ZERO
215700140826     C                   eval      wcgr = '  '
215800140826     C                   EXSR      $CPROCES
215900140826     C*                  If        wofc# <> 0
216000150213     C                   movel     '0'           *in01
216100140826     C                   leavesr
216200140826     C*                  ENDIF
216300140826     C                   ENDIF
216400140826     C                   ENDDO
216500140826      *
216600140826     C                   movel     '0'           *in01
216700140826     C                   ENDSR
216800140826      ******************************************************************
216900140826      *       SUBROUTINE - $CCLEAR                                      *
217000140826      *                    CLEAR SUBF AND RRN                          *
217100140826      ******************************************************************
217200140826     C     $CCLEAR       BEGSR
217300140826     C                   MOVEA     '001'         *IN(61)
217400140826     C                   WRITE     HDCGR
217500140826     C                   Z-ADD     *ZERO         CRRN              3 0
217600140826     C                   WRITE     HDCGR
217700140826     C                   MOVEA     '010'         *IN(61)
217800140826     C                   ENDSR
217900140826      ******************************************************************
218000140826      *       SUBROUTINE - $CLOAD                                       *
218100140826      *                    LOAD SUBFILE W/ Carrier Grouper              *
218200140826      ******************************************************************
218300140826     C     $CLOAD        BEGSR
218400140909     C                   eval      carr20 = *blanks
218500140827     C                   eval      carc20 = *blanks
218600150212      *         Set first option to NC
218700150212     C                   movel     'NC'          dtcac1
218800150212     C                   add       1             crrn
218900150212     C                   movel     'NC'          scgcod
219000150212     C                   eval      scgdsc = 'NOT CARRIER SPECIFIC'
219100150212     C                   write     detcgr
219200150212      *         See if member or acct
219300140827     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
219400140827     C     nssn          setll     mcov                               44
219500140827     C     *IN44         DOUEQ     *ON
219600140827     C     nssn          reade     mcov                                   44
219700140827     C                   if        *In44 <> *ON
219800140827     C                   if        candt = 0 or candt > todate
219900140827     C     plnkey        chain     plnmst                             45
220000140827     C                   if        *in45 = '0'
220100140827     C     pcarr         chain     carmst                             46
220200140827     C                   if        *in46 = '0'
220300140827     C     cgrpcd        chain     hypercarr                          47
220400140827     C                   if        *in47 = '0'
220500140827      *      Check to see if Carrier Grpr already there
220600140827     C                   if        dtcac1 = *blanks
220700140827     C                   movel     cgrpcd        dtcac1
220800140827     C                   add       1             crrn
220900140827     C                   movel     cgrpcd        scgcod
221000140827     C                   movel     hcname        scgdsc
221100140827     C                   write     detcgr
221200140827     C                   iter
221300140827     C                   else
221400140827     C                   if        dtcac1 = cgrpcd
221500140827     C                   iter
221600140827     C                   endif
221700140827      *
221800140827     C                   if        dtcac2 = *blanks
221900141023     C                   movel     cgrpcd        dtcac2
222000140827     C                   add       1             crrn
222100140827     C                   movel     cgrpcd        scgcod
222200140827     C                   movel     hcname        scgdsc
222300140827     C                   write     detcgr
222400140827     C                   iter
222500140827     C                   else
222600140827     C                   if        dtcac2 = cgrpcd
222700140827     C                   iter
222800140827     C                   endif
222900140827      *
223000140827     C                   if        dtcac3 = *blanks
223100141023     C                   movel     cgrpcd        dtcac3
223200140827     C                   add       1             crrn
223300140827     C                   movel     cgrpcd        scgcod
223400140827     C                   movel     hcname        scgdsc
223500140827     C                   write     detcgr
223600140827     C                   iter
223700140827     C                   else
223800140827     C                   if        dtcac3 = cgrpcd
223900140827     C                   iter
224000140827     C                   endif
224100140827      *
224200140827     C                   if        dtcac4 = *blanks
224300141023     C                   movel     cgrpcd        dtcac4
224400140827     C                   add       1             crrn
224500140827     C                   movel     cgrpcd        scgcod
224600140827     C                   movel     hcname        scgdsc
224700140827     C                   write     detcgr
224800140827     C                   iter
224900140827     C                   else
225000140827     C                   if        dtcac4 = cgrpcd
225100140827     C                   iter
225200140827     C                   endif
225300140827      *
225400140827     C                   if        dtcac5 = *blanks
225500141023     C                   movel     cgrpcd        dtcac5
225600140827     C                   add       1             crrn
225700140827     C                   movel     cgrpcd        scgcod
225800140827     C                   movel     hcname        scgdsc
225900140827     C                   write     detcgr
226000140827     C                   iter
226100140827     C                   else
226200140827     C                   if        dtcac5 = cgrpcd
226300140827     C                   iter
226400140827     C                   endif
226500140827      *
226600140827     C                   if        dtcac6 = *blanks
226700141023     C                   movel     cgrpcd        dtcac6
226800140827     C                   add       1             crrn
226900140827     C                   movel     cgrpcd        scgcod
227000140827     C                   movel     hcname        scgdsc
227100140827     C                   write     detcgr
227200140827     C                   iter
227300140827     C                   else
227400140827     C                   if        dtcac6 = cgrpcd
227500140827     C                   iter
227600140827     C                   endif
227700140827      *
227800140827     C                   if        dtcac7 = *blanks
227900141023     C                   movel     cgrpcd        dtcac7
228000140827     C                   add       1             crrn
228100140827     C                   movel     cgrpcd        scgcod
228200140827     C                   movel     hcname        scgdsc
228300140827     C                   write     detcgr
228400140827     C                   iter
228500140827     C                   else
228600140827     C                   if        dtcac7 = cgrpcd
228700140827     C                   iter
228800140827     C                   endif
228900140827      *
229000140827     C                   if        dtcac8 = *blanks
229100141023     C                   movel     cgrpcd        dtcac8
229200140827     C                   add       1             crrn
229300140827     C                   movel     cgrpcd        scgcod
229400140827     C                   movel     hcname        scgdsc
229500140827     C                   write     detcgr
229600140827     C                   iter
229700140827     C                   else
229800140827     C                   if        dtcac8 = cgrpcd
229900140827     C                   iter
230000140827     C                   endif
230100140827      *
230200140827     C                   if        dtcac9 = *blanks
230300141023     C                   movel     cgrpcd        dtcac9
230400140827     C                   add       1             crrn
230500140827     C                   movel     cgrpcd        scgcod
230600140827     C                   movel     hcname        scgdsc
230700140827     C                   write     detcgr
230800140827     C                   iter
230900140827     C                   else
231000140827     C                   if        dtcac9 = cgrpcd
231100140827     C                   iter
231200140827     C                   endif
231300140827      *
231400140827     C                   if        dtcac10 = *blanks
231500141023     C                   movel     cgrpcd        dtcac10
231600140827     C                   add       1             crrn
231700140827     C                   movel     cgrpcd        scgcod
231800140827     C                   movel     hcname        scgdsc
231900140827     C                   write     detcgr
232000140827     C                   iter
232100140827     C                   else
232200140827     C                   if        dtcac10 = cgrpcd
232300140827     C                   iter
232400140827     C                   endif
232500140827      *
232600140827     C                   if        dtcac11 = *blanks
232700141023     C                   movel     cgrpcd        dtcac11
232800140827     C                   add       1             crrn
232900140827     C                   movel     cgrpcd        scgcod
233000140827     C                   movel     hcname        scgdsc
233100140827     C                   write     detcgr
233200140827     C                   iter
233300140827     C                   else
233400140827     C                   if        dtcac11 = cgrpcd
233500140827     C                   iter
233600140827     C                   endif
233700140827      *
233800140827     C                   if        dtcac12 = *blanks
233900141023     C                   movel     cgrpcd        dtcac12
234000140827     C                   add       1             crrn
234100140827     C                   movel     cgrpcd        scgcod
234200140827     C                   movel     hcname        scgdsc
234300140827     C                   write     detcgr
234400140827     C                   iter
234500140827     C                   else
234600140827     C                   if        dtcac12 = cgrpcd
234700140827     C                   iter
234800140827     C                   endif
234900140827      *
235000140827     C                   if        dtcac13 = *blanks
235100141023     C                   movel     cgrpcd        dtcac13
235200140827     C                   add       1             crrn
235300140827     C                   movel     cgrpcd        scgcod
235400140827     C                   movel     hcname        scgdsc
235500140827     C                   write     detcgr
235600140827     C                   iter
235700140827     C                   else
235800140827     C                   if        dtcac13 = cgrpcd
235900140827     C                   iter
236000140827     C                   endif
236100140827      *
236200140827     C                   if        dtcac14 = *blanks
236300141023     C                   movel     cgrpcd        dtcac14
236400140827     C                   add       1             crrn
236500140827     C                   movel     cgrpcd        scgcod
236600140827     C                   movel     hcname        scgdsc
236700140827     C                   write     detcgr
236800140827     C                   iter
236900140827     C                   else
237000140827     C                   if        dtcac14 = cgrpcd
237100140827     C                   iter
237200140827     C                   endif
237300140827      *
237400140827     C                   if        dtcac15 = *blanks
237500141023     C                   movel     cgrpcd        dtcac15
237600140827     C                   add       1             crrn
237700140827     C                   movel     cgrpcd        scgcod
237800140827     C                   movel     hcname        scgdsc
237900140827     C                   write     detcgr
238000140827     C                   iter
238100140827     C                   else
238200140827     C                   if        dtcac15 = cgrpcd
238300140827     C                   iter
238400140827     C                   endif
238500140827      *
238600140827     C                   if        dtcac16 = *blanks
238700141023     C                   movel     cgrpcd        dtcac16
238800140827     C                   add       1             crrn
238900140827     C                   movel     cgrpcd        scgcod
239000140827     C                   movel     hcname        scgdsc
239100140827     C                   write     detcgr
239200140827     C                   iter
239300140827     C                   else
239400140827     C                   if        dtcac16 = cgrpcd
239500140827     C                   iter
239600140827     C                   endif
239700140827      *
239800140827     C                   if        dtcac17 = *blanks
239900141023     C                   movel     cgrpcd        dtcac17
240000140827     C                   add       1             crrn
240100140827     C                   movel     cgrpcd        scgcod
240200140827     C                   movel     hcname        scgdsc
240300140827     C                   write     detcgr
240400140827     C                   iter
240500140827     C                   else
240600140827     C                   if        dtcac17 = cgrpcd
240700140827     C                   iter
240800140827     C                   endif
240900140827      *
241000140827     C                   if        dtcac18 = *blanks
241100141023     C                   movel     cgrpcd        dtcac18
241200140827     C                   add       1             crrn
241300140827     C                   movel     cgrpcd        scgcod
241400140827     C                   movel     hcname        scgdsc
241500140827     C                   write     detcgr
241600140827     C                   iter
241700140827     C                   else
241800140827     C                   if        dtcac18 = cgrpcd
241900140827     C                   iter
242000140827     C                   endif
242100140827      *
242200140827     C                   if        dtcac19 = *blanks
242300141023     C                   movel     cgrpcd        dtcac19
242400140827     C                   add       1             crrn
242500140827     C                   movel     cgrpcd        scgcod
242600140827     C                   movel     hcname        scgdsc
242700140827     C                   write     detcgr
242800140827     C                   iter
242900140827     C                   else
243000140827     C                   if        dtcac19 = cgrpcd
243100140827     C                   iter
243200140827     C                   endif
243300140827      *
243400140827     C                   if        dtcac20 = *blanks
243500141023     C                   movel     cgrpcd        dtcac20
243600140827     C                   add       1             crrn
243700140827     C                   movel     cgrpcd        scgcod
243800140827     C                   movel     hcname        scgdsc
243900140827     C                   write     detcgr
244000140827     C                   leavesr
244100140827      *
244200140827     C                   endif
244300140827     C                   endif
244400140827     C                   endif
244500140827     C                   endif
244600140827     C                   endif
244700140827     C                   endif
244800140827     C                   endif
244900140827     C                   endif
245000140827     C                   endif
245100140827     C                   endif
245200140827     C                   endif
245300140827     C                   endif
245400140827     C                   endif
245500140827     C                   endif
245600140827     C                   endif
245700140827     C                   endif
245800140827     C                   endif
245900140827     C                   endif
246000140827     C                   endif
246100140827     C                   endif
246200140827      *
246300140827     C                   endif
246400140827     C                   endif
246500140827     C                   endif
246600140827     C                   endif
246700140827     C                   endif
246800140827      *
246900140827     C                   enddo
247000140827      *
247100140827     C                   else
247200140827      *   Acct level logic
247300140827     C     acckey        setll     cmct14                             44
247400140827     C     *IN44         DOUEQ     *ON
247500140827     C     acckey        reade     cmct14                                 44
247600140827     C                   if        *In44 <> *ON
247700140827     C                   if        cmcan = 0 or cmcan > todate
247800140827     C     plxkey        chain     plnmst                             45
247900140827     C                   if        *in45 = '0'
248000140827     C     pcarr         chain     carmst                             46
248100140827     C                   if        *in46 = '0'
248200140827     C     cgrpcd        chain     hypercarr                          47
248300140827     C                   if        *in47 = '0'
248400140827      *      Check to see if Carrier Grpr already there
248500140827     C                   if        dtcac1 = *blanks
248600140827     C                   movel     cgrpcd        dtcac1
248700140827     C                   add       1             crrn
248800140827     C                   movel     cgrpcd        scgcod
248900140827     C                   movel     hcname        scgdsc
249000140827     C                   write     detcgr
249100140827     C                   iter
249200140827     C                   else
249300140827     C                   if        dtcac1 = cgrpcd
249400140827     C                   iter
249500140827     C                   endif
249600140827      *
249700140827     C                   if        dtcac2 = *blanks
249800141023     C                   movel     cgrpcd        dtcac2
249900140827     C                   add       1             crrn
250000140827     C                   movel     cgrpcd        scgcod
250100140827     C                   movel     hcname        scgdsc
250200140827     C                   write     detcgr
250300140827     C                   iter
250400140827     C                   else
250500140827     C                   if        dtcac2 = cgrpcd
250600140827     C                   iter
250700140827     C                   endif
250800140827      *
250900140827     C                   if        dtcac3 = *blanks
251000141023     C                   movel     cgrpcd        dtcac3
251100140827     C                   add       1             crrn
251200140827     C                   movel     cgrpcd        scgcod
251300140827     C                   movel     hcname        scgdsc
251400140827     C                   write     detcgr
251500140827     C                   iter
251600140827     C                   else
251700140827     C                   if        dtcac3 = cgrpcd
251800140827     C                   iter
251900140827     C                   endif
252000140827      *
252100140827     C                   if        dtcac4 = *blanks
252200141023     C                   movel     cgrpcd        dtcac4
252300140827     C                   add       1             crrn
252400140827     C                   movel     cgrpcd        scgcod
252500140827     C                   movel     hcname        scgdsc
252600140827     C                   write     detcgr
252700140827     C                   iter
252800140827     C                   else
252900140827     C                   if        dtcac4 = cgrpcd
253000140827     C                   iter
253100140827     C                   endif
253200140827      *
253300140827     C                   if        dtcac5 = *blanks
253400141023     C                   movel     cgrpcd        dtcac5
253500140827     C                   add       1             crrn
253600140827     C                   movel     cgrpcd        scgcod
253700140827     C                   movel     hcname        scgdsc
253800140827     C                   write     detcgr
253900140827     C                   iter
254000140827     C                   else
254100140827     C                   if        dtcac5 = cgrpcd
254200140827     C                   iter
254300140827     C                   endif
254400140827      *
254500140827     C                   if        dtcac6 = *blanks
254600141023     C                   movel     cgrpcd        dtcac6
254700140827     C                   add       1             crrn
254800140827     C                   movel     cgrpcd        scgcod
254900140827     C                   movel     hcname        scgdsc
255000140827     C                   write     detcgr
255100140827     C                   iter
255200140827     C                   else
255300140827     C                   if        dtcac6 = cgrpcd
255400140827     C                   iter
255500140827     C                   endif
255600140827      *
255700140827     C                   if        dtcac7 = *blanks
255800141023     C                   movel     cgrpcd        dtcac7
255900140827     C                   add       1             crrn
256000140827     C                   movel     cgrpcd        scgcod
256100140827     C                   movel     hcname        scgdsc
256200140827     C                   write     detcgr
256300140827     C                   iter
256400140827     C                   else
256500140827     C                   if        dtcac7 = cgrpcd
256600140827     C                   iter
256700140827     C                   endif
256800140827      *
256900140827     C                   if        dtcac8 = *blanks
257000141023     C                   movel     cgrpcd        dtcac8
257100140827     C                   add       1             crrn
257200140827     C                   movel     cgrpcd        scgcod
257300140827     C                   movel     hcname        scgdsc
257400140827     C                   write     detcgr
257500140827     C                   iter
257600140827     C                   else
257700140827     C                   if        dtcac8 = cgrpcd
257800140827     C                   iter
257900140827     C                   endif
258000140827      *
258100140827     C                   if        dtcac9 = *blanks
258200141023     C                   movel     cgrpcd        dtcac9
258300140827     C                   add       1             crrn
258400140827     C                   movel     cgrpcd        scgcod
258500140827     C                   movel     hcname        scgdsc
258600140827     C                   write     detcgr
258700140827     C                   iter
258800140827     C                   else
258900140827     C                   if        dtcac9 = cgrpcd
259000140827     C                   iter
259100140827     C                   endif
259200140827      *
259300140827     C                   if        dtcac10 = *blanks
259400141023     C                   movel     cgrpcd        dtcac10
259500140827     C                   add       1             crrn
259600140827     C                   movel     cgrpcd        scgcod
259700140827     C                   movel     hcname        scgdsc
259800140827     C                   write     detcgr
259900140827     C                   iter
260000140827     C                   else
260100140827     C                   if        dtcac10 = cgrpcd
260200140827     C                   iter
260300140827     C                   endif
260400140827      *
260500140827     C                   if        dtcac11 = *blanks
260600141023     C                   movel     cgrpcd        dtcac11
260700140827     C                   add       1             crrn
260800140827     C                   movel     cgrpcd        scgcod
260900140827     C                   movel     hcname        scgdsc
261000140827     C                   write     detcgr
261100140827     C                   iter
261200140827     C                   else
261300140827     C                   if        dtcac11 = cgrpcd
261400140827     C                   iter
261500140827     C                   endif
261600140827      *
261700140827     C                   if        dtcac12 = *blanks
261800141023     C                   movel     cgrpcd        dtcac12
261900140827     C                   add       1             crrn
262000140827     C                   movel     cgrpcd        scgcod
262100140827     C                   movel     hcname        scgdsc
262200140827     C                   write     detcgr
262300140827     C                   iter
262400140827     C                   else
262500140827     C                   if        dtcac12 = cgrpcd
262600140827     C                   iter
262700140827     C                   endif
262800140827      *
262900140827     C                   if        dtcac13 = *blanks
263000141023     C                   movel     cgrpcd        dtcac13
263100140827     C                   add       1             crrn
263200140827     C                   movel     cgrpcd        scgcod
263300140827     C                   movel     hcname        scgdsc
263400140827     C                   write     detcgr
263500140827     C                   iter
263600140827     C                   else
263700140827     C                   if        dtcac13 = cgrpcd
263800140827     C                   iter
263900140827     C                   endif
264000140827      *
264100140827     C                   if        dtcac14 = *blanks
264200141023     C                   movel     cgrpcd        dtcac14
264300140827     C                   add       1             crrn
264400140827     C                   movel     cgrpcd        scgcod
264500140827     C                   movel     hcname        scgdsc
264600140827     C                   write     detcgr
264700140827     C                   iter
264800140827     C                   else
264900140827     C                   if        dtcac14 = cgrpcd
265000140827     C                   iter
265100140827     C                   endif
265200140827      *
265300140827     C                   if        dtcac15 = *blanks
265400141023     C                   movel     cgrpcd        dtcac15
265500140827     C                   add       1             crrn
265600140827     C                   movel     cgrpcd        scgcod
265700140827     C                   movel     hcname        scgdsc
265800140827     C                   write     detcgr
265900140827     C                   iter
266000140827     C                   else
266100140827     C                   if        dtcac15 = cgrpcd
266200140827     C                   iter
266300140827     C                   endif
266400140827      *
266500140827     C                   if        dtcac16 = *blanks
266600141023     C                   movel     cgrpcd        dtcac16
266700140827     C                   movel     cgrpcd        scgcod
266800140827     C                   iter
266900140827     C                   movel     hcname        scgdsc
267000140827     C                   write     detcgr
267100140827     C                   add       1             crrn
267200140827     C                   else
267300140827     C                   if        dtcac16 = cgrpcd
267400140827     C                   iter
267500140827     C                   endif
267600140827      *
267700140827     C                   if        dtcac17 = *blanks
267800141023     C                   movel     cgrpcd        dtcac17
267900140827     C                   add       1             crrn
268000140827     C                   movel     cgrpcd        scgcod
268100140827     C                   movel     hcname        scgdsc
268200140827     C                   write     detcgr
268300140827     C                   iter
268400140827     C                   else
268500140827     C                   if        dtcac17 = cgrpcd
268600140827     C                   iter
268700140827     C                   endif
268800140827      *
268900140827     C                   if        dtcac18 = *blanks
269000141023     C                   movel     cgrpcd        dtcac18
269100140827     C                   add       1             crrn
269200140827     C                   movel     cgrpcd        scgcod
269300140827     C                   movel     hcname        scgdsc
269400140827     C                   write     detcgr
269500140827     C                   iter
269600140827     C                   else
269700140827     C                   if        dtcac18 = cgrpcd
269800140827     C                   iter
269900140827     C                   endif
270000140827      *
270100140827     C                   if        dtcac19 = *blanks
270200141023     C                   movel     cgrpcd        dtcac19
270300140827     C                   add       1             crrn
270400140827     C                   movel     cgrpcd        scgcod
270500140827     C                   movel     hcname        scgdsc
270600140827     C                   write     detcgr
270700140827     C                   iter
270800140827     C                   else
270900140827     C                   if        dtcac19 = cgrpcd
271000140827     C                   iter
271100140827     C                   endif
271200140827      *
271300140827     C                   if        dtcac20 = *blanks
271400141023     C                   movel     cgrpcd        dtcac20
271500140827     C                   add       1             crrn
271600140827     C                   movel     cgrpcd        scgcod
271700140827     C                   movel     hcname        scgdsc
271800140827     C                   write     detcgr
271900140827     C                   leavesr
272000140827      *
272100140827     C                   endif
272200140827     C                   endif
272300140827     C                   endif
272400140827     C                   endif
272500140827     C                   endif
272600140827     C                   endif
272700140827     C                   endif
272800140827     C                   endif
272900140827     C                   endif
273000140827     C                   endif
273100140827     C                   endif
273200140827     C                   endif
273300140827     C                   endif
273400140827     C                   endif
273500140827     C                   endif
273600140827     C                   endif
273700140827     C                   endif
273800140827     C                   endif
273900140827     C                   endif
274000140827     C                   endif
274100140827      *
274200140827     C                   endif
274300140827     C                   endif
274400140827     C                   endif
274500140827     C                   endif
274600140827     C                   endif
274700140827      *
274800140827     C                   enddo
274900140827     C                   endif
275000140827      *
275100140827     C                   ENDSR
275200140826      ******************************************************************
275300140826      *       SUBROUTINE - $CDISPLAY                                    *
275400140826      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
275500140826      ******************************************************************
275600140826     C     $CDISPLAY     BEGSR
275700140826     C                   If        CRRN <> *Zero
275800140826     C                   MOVE      *ON           *IN61
275900140826     C                   ENDIF
276000140827     C                   WRITE     TRCGR
276100140827     C                   EXFMT     HDCGR
276200140826     C                   ENDSR
276300140826      ******************************************************************
276400140826      *       SUBROUTINE - $CPROCES                                     *
276500140826      *                    PROCESS THE SELECTION                       *
276600140826      ******************************************************************
276700140826     C     $CPROCES      BEGSR
276800140909     C                   eval      carc20 = *blanks
276900141010     C******??           eval      cara20c = *blanks
277000140909      *
277100140826     C     *IN96         DOUEQ     *ON
277200140826      *
277300140826     C                   READC     DETCGR                                 96
277400140826     C                   IF        *IN96 = *OFF
277500140826      *      Select Resp Req From
277600140903     C                   IF        SEL5 = '1'
277700140909      *          Place Code and Desc in pos 1-20
277800141010     C                   if        dtcac1 = *blanks
277900141010     C                   movel     scgcod        dtcac1
278000141010     C                   movel     scgdsc        dtcar1
278100150212      *           If NC is sel'd - no other codes can be sel'd
278200150212     C                   if        dtcac1 = 'NC'
278300150212     C                   clear                   sel5
278400150212     C                   update    detcgr
278500150212     C                   leave
278600150212     C                   else
278700150212     C                   iter
278800150212     C                   endif
278900150212     C                   endif
279000140909      *
279100141010     C                   if        dtcac2 = *blanks
279200141010     C                   movel     scgcod        dtcac2
279300141010     C                   movel     scgdsc        dtcar2
279400140909     C                   iter
279500140909     C                   endif
279600140909      *
279700141010     C                   if        dtcac3 = *blanks
279800141010     C                   movel     scgcod        dtcac3
279900141010     C                   movel     scgdsc        dtcar3
280000140909     C                   iter
280100140909     C                   endif
280200140909      *
280300141010     C                   if        dtcac4 = *blanks
280400141010     C                   movel     scgcod        dtcac4
280500141010     C                   movel     scgdsc        dtcar4
280600140909     C                   iter
280700140909     C                   endif
280800141010      *
280900141010     C                   if        dtcac5 = *blanks
281000141010     C                   movel     scgcod        dtcac5
281100141010     C                   movel     scgdsc        dtcar5
281200140909     C                   iter
281300140909     C                   endif
281400140909      *
281500141010     C                   if        dtcac6 = *blanks
281600141010     C                   movel     scgcod        dtcac6
281700141010     C                   movel     scgdsc        dtcar6
281800140909     C                   iter
281900140909     C                   endif
282000140909      *
282100141010     C                   if        dtcac7 = *blanks
282200141010     C                   movel     scgcod        dtcac7
282300141010     C                   movel     scgdsc        dtcar7
282400140909     C                   iter
282500140909     C                   endif
282600140909      *
282700141010     C                   if        dtcac8 = *blanks
282800141010     C                   movel     scgcod        dtcac8
282900141010     C                   movel     scgdsc        dtcar8
283000140909     C                   iter
283100140909     C                   endif
283200140909      *
283300141010     C                   if        dtcac9 = *blanks
283400141010     C                   movel     scgcod        dtcac9
283500141010     C                   movel     scgdsc        dtcar9
283600140909     C                   iter
283700140909     C                   endif
283800140909      *
283900141010     C                   if        dtcac10 = *blanks
284000141010     C                   movel     scgcod        dtcac10
284100141010     C                   movel     scgdsc        dtcar10
284200140909     C                   iter
284300140909     C                   endif
284400141010      *
284500141010     C                   if        dtcac11 = *blanks
284600141010     C                   movel     scgcod        dtcac11
284700141010     C                   movel     scgdsc        dtcar11
284800140909     C                   iter
284900140909     C                   endif
285000140909      *
285100141010     C                   if        dtcac12 = *blanks
285200141010     C                   movel     scgcod        dtcac12
285300141010     C                   movel     scgdsc        dtcar12
285400140909     C                   iter
285500140909     C                   endif
285600140909      *
285700141010     C                   if        dtcac13 = *blanks
285800141010     C                   movel     scgcod        dtcac13
285900141010     C                   movel     scgdsc        dtcar13
286000140909     C                   iter
286100140909     C                   endif
286200140909      *
286300141010     C                   if        dtcac14 = *blanks
286400141010     C                   movel     scgcod        dtcac14
286500141010     C                   movel     scgdsc        dtcar14
286600140909     C                   iter
286700140909     C                   endif
286800140909      *
286900141010     C                   if        dtcac15 = *blanks
287000141010     C                   movel     scgcod        dtcac15
287100141010     C                   movel     scgdsc        dtcar15
287200140909     C                   iter
287300140909     C                   endif
287400140909      *
287500141010     C                   if        dtcac16 = *blanks
287600141010     C                   movel     scgcod        dtcac16
287700141010     C                   movel     scgdsc        dtcar16
287800140909     C                   iter
287900140909     C                   endif
288000140909      *
288100141010     C                   if        dtcac17 = *blanks
288200141010     C                   movel     scgcod        dtcac17
288300141010     C                   movel     scgdsc        dtcar17
288400140909     C                   iter
288500140909     C                   endif
288600140909      *
288700141010     C                   if        dtcac18 = *blanks
288800141010     C                   movel     scgcod        dtcac18
288900141010     C                   movel     scgdsc        dtcar18
289000140909     C                   iter
289100140909     C                   endif
289200140909      *
289300141010     C                   if        dtcac19 = *blanks
289400141010     C                   movel     scgcod        dtcac19
289500141010     C                   movel     scgdsc        dtcar19
289600140909     C                   iter
289700140909     C                   endif
289800140909      *
289900141010     C                   if        dtcac20 = *blanks
290000141010     C                   movel     scgcod        dtcac20
290100141010     C                   movel     scgdsc        dtcar20
290200140909     C                   iter
290300140909     C                   endif
290400140909      *
290500140826     C                   endif
290600140826      *
290700140828     C                   CLEAR                   SEL5
290800140826     C                   UPDATE    DETCGR
290900140826     C                   ENDIF
291000140826     C                   ENDDO
291100140826     C                   ENDSR
291200140818      ******************************************************************
291300140909      *       SUBROUTINE - EDTINP                                      *
291400140909      *                    Edit Input data for validity                *
291500140818      ******************************************************************
291600140909     C     edtinp        BEGSR
291700140818      *
291800140909     C                   eval      edtcln = 'N'
291900140909     C                   eval      smsg = *blanks
292000140818      *
292100141020     C                   eval      *in51 = '0'
292200150731     C*********          IF        atfudt <> 0
292300140926     C     *USA          test(D)                 atfudt                 57
292400140926     C                   if        *in57 = '1'
292500140926     C                   eval      smsg = fuderr
292600141020     C                   eval      *in51 = '1'
292700140818     C                   leavesr
292800140818     C                   endif
292900141014      *
293000141014     C                   movel     atfudt        mdydt
293100141014     C                   eval      ymdyy = mdyyy
293200141014     C                   eval      ymdmd = mdymd
293300141014     C                   if        ymddt < todate
293400141014     C                   eval      smsg = fuderx
293500141020     C                   eval      *in51 = '1'
293600141014     C                   leavesr
293700141014     C                   endif
293800141014      *
293900150731     C*********          endif
294000140926      *
294100141020     C                   eval      *in53 = '0'
294200140926     C                   IF        atsbjt = *blanks
294300140926     C                   eval      smsg = blksjt
294400141020     C                   eval      *in53 = '1'
294500140926     C                   leavesr
294600140926     C                   endif
294700140909      *
294800140909     C                   IF        atview = *blanks
294900140909     C                   eval      smsg = blkvew
295000140909     C                   leavesr
295100140909     C                   endif
295200150217      *
295300150217     C                   IF        carc20 = *blanks
295400150217     C                   eval      smsg = blkcar
295500150217     C                   leavesr
295600150217     C                   endif
295700140926      *
295800141020     C                   eval      *in54 = '0'
295900140926     C                   IF        atrefd <> 0
296000140926     C     *USA          test(D)                 atrefd                 57
296100140926     C                   if        *in57 = '1'
296200140926     C                   eval      smsg = rfderr
296300141020     C                   eval      *in54 = '1'
296400140926     C                   leavesr
296500140926     C                   endif
296600141014      *
296700141014     C                   movel     atrefd        mdydt
296800141014     C                   eval      ymdyy = mdyyy
296900141014     C                   eval      ymdmd = mdymd
297000141014     C                   if        ymddt < todate
297100141014     C                   eval      smsg = rfderx
297200141020     C                   eval      *in54 = '1'
297300141014     C                   leavesr
297400141014     C                   endif
297500141014      *
297600140926     C                   endif
297700140909      *
297800150427     C                   eval      *in56 = '0'
297900150427     C                   IF        atcarx <> ' '
298000150427     C                   eval      smsg = crablx
298100150427     C                   eval      *in56 = '1'
298200150427     C                   eval      atcarx = ' '
298300140909     C                   leavesr
298400140909     C                   endif
298500150427      *
298600150427     C                   eval      *in55 = '0'
298700150427     C                   IF        attxt1 = *blanks
298800150427     C                   eval      smsg = blktxt
298900150427     C                   eval      *in55 = '1'
299000150427     C                   leavesr
299100150427     C                   endif
299200140818      *
299300140926     C                   eval      edtcln = 'Y'
299400140926      *
299500140818     C                   ENDSR
299600140926      ******************************************************************
299700140926      *       SUBROUTINE - WRTISS                                      *
299800140926      *                    Write new Issue record                      *
299900140926      ******************************************************************
300000140926     C     wrtiss        BEGSR
300100140926      *
300200141010     C                   clear                   itissx
300300140926      *
300400141010     C                   movel     trust         xittrst
300500141010     C                   movel     subno         xitsub#
300600141010     C                   movel     accno         xitacct
300700140926      *
300800141010     C                   movel     ssnod         xitmssn
300900150528      *
301000150528      *           Make sure issue# is right
301100150528     C                   z-add     999999        niss#
301200150528     C     niss#         setgt     itissl3
301300150528     C                   readp     itissl3                                24
301400150528     C                   if        *in24 = '1'
301500150528     C                   z-add     01            atiss#
301600150528     C                   else
301700150528     C     zitiss#       add       01            atiss#
301800150528     C                   endif
301900150528     C                   z-add     atiss#        sviss#
302000150528      *
302100141010     C                   movel     atiss#        xitiss#
302200140926      *
302300140926     C                   CLEAR                   @TIMESTAMP
302400140926     C                   MOVE      *BLANKS       @TS40
302500140926     C                   CALL      'TIMESTMP'
302600140926     C                   PARM                    @TS40
302700140926      *
302800140926     C                   movel     @TS40         @TIMESTAMP
302900141010     C                   movel     @TSUSER       xitinit
303000140926     C                   move      #TSCYMD       svdato            8 0
303100140926     C                   move      #TSTIME       svtimo            6 0
303200140926    * *
303300141010     C                   movel     svdato        xitdato
303400141010     C                   movel     svtimo        xittimo
303500140926      *
303600140926     C                   movel     atfudt        mdydt
303700140926     C                   eval      ymdyy = mdyyy
303800140926     C                   eval      ymdmd = mdymd
303900141010     C                   eval      xitfudt = ymddt
304000140926      *
304100141010     C                   eval      xitvewc = atviewc
304200141010     C                   eval      xittypc = attypc
304300141010     C                   eval      xitrefr = atrefrc
304400141010     C                   eval      xitresp = atrespc
304500141010     C                   eval      xitsbjt = atsbjt
304600140926      *
304700140926     C                   movel     atrefd        mdydt
304800140926     C                   eval      ymdyy = mdyyy
304900140926     C                   eval      ymdmd = mdymd
305000141010     C                   eval      xitrefd = ymddt
305100140926      *
305200141010     C                   movel     atreft        xitreft
305300141010     C                   movel     carc20        cari20
305400140926      *
305500141010     C                   movel     attxt480      xitdesc
305600141010     C                   eval      xitsts = 'O'
305700140926      *
305800141010     C                   write     itissx
305900150514      *
306000150723     C                   if        xitrefr <> *blanks
306100150723     C                   exsr      refemail
306200150723     C                   endif
306300150723      *
306400150514     C                   exsr      ophist
306500140926      *
306600140926     C                   ENDSR
306700140909      ******************************************************************
306800150514      *       SUBROUTINE - OPHIST                                      *
306900150514      *                    Write HIST rec for Issue Opened             *
307000140909      ******************************************************************
307100150514     C     ophist        BEGSR
307200140909      *
307300150514     C                   clear                   histr
307400150514     C                   if        xitmssn = 0
307500150514      *        Account Hist Rec
307600150514     C                   move      xittrst       htrst
307700150514     C                   move      xitsub#       hsub#
307800150514     C                   move      xitacct       hacct
307900150514     C                   move      histtsa       hkey
308000150514     C                   else
308100150514      *        Member Hist Rec
308200150514     C                   move      xitmssn       hkey
308300150514     C                   endif
308400150514      *  >>>>
308500150514     C                   movel     #TSCYMD       trdate
308600150514     C                   move      'UIO'         trcode
308700150514     C                   Z-ADD     0             TRAMT
308800150514     C                   MOVE      *BLANKS       CM$FLG
308900150514     C                   MOVE      XITISS#       itissa
309000150514     C                   eval      ck#not = hstopn1 + itissa  + hstopn2
309100150604     C                   MOVEL     xitsbjt       NOTE2
309200150514     C                   MOVEL     'IQ016'       HPRGNM
309300150514     C                   Z-ADD     0             RECVDT
309400150514     C                   z-add     xittrst       HSTRST
309500150514     C                   z-add     xitsub#       HSSUB#
309600150514     C                   z-add     xitacct       HSACCT
309700150514DTAQ C                   movel     @TSUSER       hoper
309800150514     C                   MOVEL     'A'           HSDLTD
309900150514      *
310000150514     C                   MOVE      #TSCYMD       trdate
310100150514     c                   move      #TSTIME       hstrtime
310200150514      *
310300150514     C                   WRITE     HISTR
310400140909      *
310500140909     C                   ENDSR
310600150723      ******************************************************************
310700150723      *       SUBROUTINE - REFEMAIL                                    *
310800150723      *                    Call CL to email referral notice            *
310900150723      ******************************************************************
311000150723     C     refemail      BEGSR
311100151124      *
311200151124     C                   if        xitrefr = '   '
311300151124     C                   leavesr
311400151124     C                   endif
311500150723      *      Create To Line
311600150723     C                   eval      rfeto = *blanks
311700150723     C                   SELECT
311800150723     C                   when      xitrefr = 'BSC'
311900150723     C                   eval      rfeto = 'bscarfield@gbsio.net'
312000150723     C                   when      xitrefr = 'CBL'
312100150723     C                   eval      rfeto = 'cblizzard@gbsio.net '
312200150723     C                   when      xitrefr = 'CFA'
312300150723     C                   eval      rfeto = 'cfallin@gbsio.net   '
312400150723     C                   when      xitrefr = 'CFB'
312500150723     C                   eval      rfeto = 'cfabiszak@gbsio.net '
312600150723     C                   when      xitrefr = 'CWH'
312700150723     C                   eval      rfeto = 'cwhitehead@gbsio.net'
312800150723     C                   when      xitrefr = 'DCL'
312900150723     C                   eval      rfeto = 'dclark@gbsio.net    '
313000150723     C                   when      xitrefr = 'LKE'
313100150723     C                   eval      rfeto = 'lketterman@gbsio.net'
313200150723     C                   when      xitrefr = 'SRA'
313300150817     C                   eval      rfeto = 'srapski@gbsio.net   '
313400150723     C                   other
313500150723     C                   eval      rfeto = 'rjones@gbsio.net    '
313600150723     C                   ENDSL
313700150723      *
313800150723      *      Create Subject Line
313900150723     C                   eval      rfesub = *blanks
314000150723     C                   if        xitmssn = 0
314100150723      *          Account Issue
314200150723DTAQ C                   movel     trust         trusta            3
314300150723DTAQ C                   movel     subno         subnoa            3
314400150723DTAQ C                   movel     accno         accnoa            4
314500150723     C                   eval      rfesub = ('Issue Tracking - ' + trusta +
314600150723     C                             '-' + subnoa + '-' + accnoa + ' - ' +
314700150723     C                             accnam)
314800150723     C                   else
314900150723      *          Member Issue
315000150723     C                   eval      rfesub = ('Issue Tracking - ' + ssnod +
315100150723     C                             ' - ' + mbrnam)
315200150723     C                   endif
315300150723      *      Create Email Text
315400150723     C                   eval      rfetxt = *blanks
315500150723DTAQ C                   movel     atiss#        atiss#a           6
315600150723      *
315700150723     C                   movel     xitfudt       wkdate
315800150723     C                   eval      usadt = wkdate
315900150723     C                   movel     usadt         emfudt           10
316000150723      *
316100150724     C                   eval      rfetxt = ('Iss Trk Issue# ' +
316200150724     C                             atiss#a + ' opened by ' +
316300150724     C                             %TRIM(atinit) +
316400150724     C                             ' has been referred to you. ' +
316500150724     C                             ':/NFollow up date is ' +
316600150724     C                             emfudt + '. Type is ' +
316700150724     C                             %TRIM(attypd) + '. ' +
316800150724     C                             ':/NReferral Text : "' +
316900150724     C                             %TRIM(xitreft) + '" ' +
317000150724     C                             ':/N:/NIssue Details : "' +
317100150724     C                             %TRIM(xitdesc) + '".')
317200150723      *
317300150724     C                   CALL      'ITEMAILC'
317400150723     C                   PARM                    rfeto
317500150723     C                   PARM                    rfesub
317600150723     C                   PARM                    rfetxt
317700150723      *
317800150723      *          Write IT Hist record
317900150723      *
318000150723      *           Get next hist#
318100150723     C                   z-add     xitiss#       hiss#
318200150723     C                   z-add     99999         hhis#
318300150723     C     hiskey        setgt     ithisp
318400150723     C                   readp     ithisp                                 24
318500150723     C                   if        *in24 = '1' or xitiss# <> hiss#
318600150723     C                   z-add     01            svhis#
318700150723     C                   else
318800150723     C     ihhis#        add       01            svhis#
318900150723     C                   endif
319000150723      *
319100150723     C                   clear                   ithisr
319200150723      *
319300150723     C                   eval      ihiss# = xitiss#
319400150723     C                   eval      ihhis# = svhis#
319500150723      *
319600150723     C                   CLEAR                   @TIMESTAMP
319700150723     C                   MOVE      *BLANKS       @TS40
319800150723     C                   CALL      'TIMESTMP'
319900150723     C                   PARM                    @TS40
320000150723      *
320100150723     C                   movel     @TS40         @TIMESTAMP
320200150723     C                   movel     @TSUSER       ihuser
320300150723     C                   move      #TSCYMD       svdato
320400150723     C                   move      #TSTIME       svtimo
320500150723    * *
320600150723     C                   movel     svdato        ihdate
320700150723     C                   movel     svtimo        ihtime
320800150723      *
320900150723     C                   eval      ihtypc = 'H'
321000150723      *
321100150723     C                   eval      ihtext = 'REFERRAL EMAIL SENT TO ' +
321200150723     C                             %TRIM(atrefr) + '.'
321300150723      *
321400150723     C                   write     ithisr
321500150723      *
321600150723     C                   ENDSR
321700150514      ******************************************************************
321800150514      *       SUBROUTINE - WRTHST                                      *
321900150514      *                    Write Issue History Rec                     *
322000150514      ******************************************************************
322100150514     C     wrthst        BEGSR
322200150514      *
322300150514      *           Get next Hist #
322400150514     C                   z-add     xitiss#       hiss#
322500150514     C                   z-add     99999         hhis#
322600150514     C     hiskey        setgt     ithisp
322700150514     C                   readp     ithisp                                 24
322800150514     C                   if        *in24 = '1' or hiss# <> ihiss#
322900150514     C                   z-add     01            svhis#
323000150514     C                   else
323100150514     C     ihhis#        add       01            svhis#
323200150514     C                   endif
323300150514      *
323400150514     C                   clear                   ithisr
323500150514     C                   z-add     xitiss#       ihiss#
323600150514     C                   z-add     svhis#        ihhis#
323700150514      *
323800150514     C                   CLEAR                   @TIMESTAMP
323900150514     C                   MOVE      *BLANKS       @TS40
324000150514     C                   CALL      'TIMESTMP'
324100150514     C                   PARM                    @TS40
324200150514      *
324300150514     C                   movel     @TS40         @TIMESTAMP
324400150514     C                   movel     @TSUSER       ihuser
324500150514     C                   move      #TSCYMD       svdato
324600150514     C                   move      #TSTIME       svtimo
324700150514    * *
324800150514     C                   movel     svdato        ihdate
324900150514    * *
325000150514     C                   movel     svtimo        wktime
325100150514     C                   movel     wktime        ihtime
325200150514      *
325300150514     C                   eval      ihtypc = htypc
325400150514     C                   movel(P)  itxt          ihtext
325500150514    * *
325600150514     C                   write     ithisr
325700150514      *
325800150514     C                   ENDSR
325900141010      ******************************************************************
326000141010      *       SUBROUTINE - ISSHST                                      *
326100141010      *                    Display Issue History                       *
326200141010      ******************************************************************
326300141010     C     isshst        BEGSR
326400141014      *
326500141014     C                   if        getiss = 'Y'
326600141014     C     sviss#        chain     itissl                             22
326700141014     C                   if        *in22 = '0'
326800141014      *   If Member display - fill in Mbr hdr fields
326900141014     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
327000141014     C                   movel     nssn          ssnod
327100141014     C     nssn          chain     member                             32
327200141014     C                   if        *in32 = '0'
327300141014     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
327400141014     C                             %TRIM(mfname)
327500141014     C                   endif
327600141014     C                   endif
327700141014     C                   endif
327800141014     C                   endif
327900141014      *
328000141013     C                   movel     xitiss#       hhiss#
328100141013     C                   movel     xitsbjt       hhsbjt
328200141013     C     *IN01         DOWEQ     *OFF
328300141012     C***  *IN07         ANDEQ     *OFF
328400141012      *
328500141012     C                   EXSR      $HCLEAR
328600141012     C                   EXSR      $HLOAD
328700141012     C                   EXSR      $HDISPLAY
328800141012      *    PROCESS SELECTION
328900141012     C     *IN01         IFEQ      *OFF
329000141012     C***  *IN07         ANDEQ     *OFF
329100141015     C***  hrrn          ANDNE     *ZERO
329200141012     C                   EXSR      $HPROCES
329300141015     C*****              leavesr
329400141012     C                   ENDIF
329500141012     C                   ENDDO
329600141012      *
329700141012     C                   movel     '0'           *in01
329800141012     C                   ENDSR
329900141012      ******************************************************************
330000141012      *       SUBROUTINE - $HCLEAR                                      *
330100141012      *                    CLEAR SUBF AND RRN                          *
330200141012      ******************************************************************
330300141012     C     $HCLEAR       BEGSR
330400141012     C                   MOVEA     '001'         *IN(41)
330500141012     C                   WRITE     HEADHS
330600141012     C                   Z-ADD     *ZERO         HRRN              3 0
330700141012     C                   WRITE     HEADHS
330800141012     C                   MOVEA     '010'         *IN(41)
330900141012     C                   ENDSR
331000141012      ******************************************************************
331100141012      *       SUBROUTINE - $HLOAD                                       *
331200141012      *                    LOAD SUBFILE W/ Hist Detail                  *
331300141012      ******************************************************************
331400141012     C     $HLOAD        BEGSR
331500141012     C                   eval      hiss# = xitiss#
331600141012     C                   eval      hhis# = 0
331700141012     C     hiskey        SETLL     ithisp
331800141012     C                   SETOFF                                       4496
331900141012     C     *IN44         DOUEQ     *ON
332000141012     C     *IN96         OREQ      *ON
332100141012     C                   READ      ithisp                                 44
332200141012     C                   IF        (*In44 <> *ON)
332300141012      *
332400141013     C                   IF        ihiss# <> xitiss#
332500141014     C                   eval      *In44 = *ON
332600141012     C                   leave
332700141012     C                   endif
332800141012      *
332900141012     C                   ADD       1             HRRN
333000141012     C                   movel     ihdate        wkdate
333100141012     C                   eval      usadt = wkdate
333200141012     C                   movel     usadt         hsdate
333300141012     C                   MOVEL(P)  ihuser        hsuser
333400141012     C                   movel(P)  htxt95        hstext
333500141013     C                   eval      hshis# = ihhis#
333600141013     C                   WRITE     dethst
333700141012      *
333800141012     C                   endif
333900141012     C                   enddo
334000141012     C                   ENDSR
334100141012      ******************************************************************
334200141012      *       SUBROUTINE - $HDISPLAY                                    *
334300141012      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
334400141012      ******************************************************************
334500141012     C     $HDISPLAY     BEGSR
334600141012     C                   If        HRRN <> *Zero
334700141012     C                   MOVE      *ON           *IN41
334800141012     C                   ENDIF
334900141012     C                   WRITE     TRAILHS
335000141012     C                   EXFMT     HEADHS
335100141012     C                   ENDSR
335200141012      ******************************************************************
335300141012      *       SUBROUTINE - $HPROCES                                     *
335400141012      *                    PROCESS THE SELECTION                       *
335500141012      ******************************************************************
335600141012     C     $HPROCES      BEGSR
335700141015     C     *IN96         DOUEQ     *ON
335800141012      *
335900141012     C                   IF        *IN01 = *ON
336000141012     C                   eval      smsg = *blanks
336100141012     C**                 MOVE      *Off          *IN01
336200141012     C                   leavesr
336300141012     C                   endif
336400141013      *        Add new freeform history record
336500141013     C                   IF        *IN06 = *ON
336600141013     C                   eval      smsg = *blanks
336700141013     C                   MOVE      *Off          *IN06
336800141013     C                   exsr      hstadd
336900141014     C                   leavesr
337000141013     C                   endif
337100141012      *
337200141015     C                   IF        hrrn = 0
337300141015     C                   leavesr
337400141015     C                   endif
337500141015      *
337600141013     C                   READC     DETHST                                 96
337700141015     C                   IF        *IN96 = *OFF
337800141013      *      Hist Detail
337900141013     C                   IF        SELH = '5'
338000141013     C                   exsr      HSTDTL
338100141015     C                   endif
338200141015      *
338300141015     C                   CLEAR                   SELH
338400141015     C                   UPDATE    DETHST
338500141015     C                   iter
338600141013     C                   endif
338700141012      *
338800141012     C                   ENDDO
338900141012     C                   ENDSR
339000141013      ******************************************************************
339100141013      *       SUBROUTINE - HSTDTL                                      *
339200141013      *                    Dispaly History Detail                      *
339300141013      ******************************************************************
339400141013     C     hstdtl        BEGSR
339500141014      *
339600141014     C                   if        dtiss# = 0
339700141014     C     hhiss#        chain     itissl                             22
339800141014     C                   if        *in22 = '0'
339900141014      *   If Member display - fill in Mbr hdr fields
340000141014     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
340100141014     C                   movel     nssn          ssnod
340200141014     C     nssn          chain     member                             32
340300141014     C                   if        *in32 = '0'
340400141014     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
340500141014     C                             %TRIM(mfname)
340600141014     C                   endif
340700141014     C                   endif
340800141014      *
340900141014     C                   movel     xitiss#       dtiss#
341000141014     C                   movel     xitinit       dtinit
341100141014      *
341200141014     C                   movel     xitdato       wkdate
341300141014     C                   eval      usadt = wkdate
341400141014     C                   movel     usadt         dtdato
341500141014      *
341600141014     C                   eval      dttimo = %EDITW(xittimo:'0 :  :  ')
341700141014      *
341800141014     C                   if        xitdatc = 0
341900141014     C                   movel(P)  'OPEN'        dtdatc
342000141014     C                   else
342100141014     C                   movel     xitdatc       wkdate
342200141014     C                   eval      usadt = wkdate
342300141014     C                   movel     usadt         dtdatc
342400141014      *
342500141014     C                   eval      dttimc = %EDITW(xittimc:'0 :  :  ')
342600141014     C                   endif
342700141014      *
342800141014     C                   movel     xitfudt       wkdate
342900141014     C                   eval      usadt = wkdate
343000141014     C                   movel     usadt         dtfudt
343100141014      *
343200141014     C                   eval      cktyp = 'Q'
343300141014     C                   eval      ckcod = xitresp
343400141014     C     codkey        chain     itcodp                             32
343500141014     C                   if        *in32 = '0'
343600141014     C                   movel(P)  ictext        dtresp
343700141014     C                   endif
343800141014      *
343900141014     C                   eval      cktyp = 'T'
344000141014     C                   eval      ckcod = xittypc
344100141014     C     codkey        chain     itcodp                             32
344200141014     C                   if        *in32 = '0'
344300141014     C                   movel(P)  ictext        dttype
344400141014     C                   endif
344500141014      *
344600141014     C                   movel     xitsbjt       dtsbjt
344700141014      *
344800141014     C                   endif
344900141014     C                   endif
345000141014      *
345100141013     C                   eval      hiss# = hhiss#
345200141013     C                   eval      hhis# = hshis#
345300141013     C     hiskey        chain     ithisp                             32
345400141013     C                   if        *in32 = '0'
345500141013      *
345600141013     C                   movel     ihdate        wkdate
345700141013     C                   eval      usadt = wkdate
345800141013     C                   movel     usadt         hddate
345900141013      *
346000141013     C                   eval      hdtime = %EDITW(ihtime:'0 :  :  ')
346100141013      *
346200141013     C                   movel(P)  ihuser        hduser
346300141013      *
346400141013     C                   movel(P)  ihtxt1        hdtxt1
346500141013     C                   movel(P)  ihtxt2        hdtxt2
346600141013      *
346700141013     C                   endif
346800141013      *
346900141013     C     *IN01         DOUEQ     *ON
347000141013      *
347100141013     C                   exfmt     dshsdt
347200141013      *
347300141013     C                   IF        *IN01 = *ON
347400141013     C                   eval      smsg = *blanks
347500141014     C                   eval      *IN01 = *OFF
347600141013     C                   leave
347700141013     C                   endif
347800141013      *
347900141013     C                   enddo
348000141013      *
348100141013     C                   MOVE      *Off          *IN01
348200141013     C                   ENDSR
348300141013      ******************************************************************
348400141013      *       SUBROUTINE - HSTADD                                      *
348500141013      *                    Add a new History Rec                       *
348600141013      ******************************************************************
348700141013     C     hstadd        BEGSR
348800141013      *
348900141013     C                   eval      smsg = *blanks
349000141013      *
349100141014     C                   if        dtiss# = 0
349200141014     C     xitiss#       chain     itissl                             22
349300141014     C                   if        *in22 = '0'
349400141014      *   If Member display - fill in Mbr hdr fields
349500141014     C                   if        nssn <> 0 and nssn <> 8 and nssn <> 9
349600141014     C                   movel     nssn          ssnod
349700141014     C     nssn          chain     member                             32
349800141014     C                   if        *in32 = '0'
349900141014     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
350000141014     C                             %TRIM(mfname)
350100141014     C                   endif
350200141014     C                   endif
350300141014      *
350400141014     C                   movel     xitiss#       dtiss#
350500141014     C                   movel     xitinit       dtinit
350600141014      *
350700141014     C                   movel     xitdato       wkdate
350800141014     C                   eval      usadt = wkdate
350900141014     C                   movel     usadt         dtdato
351000141014      *
351100141014     C                   eval      dttimo = %EDITW(xittimo:'0 :  :  ')
351200141014      *
351300141014     C                   if        xitdatc = 0
351400141014     C                   movel(P)  'OPEN'        dtdatc
351500141014     C                   else
351600141014     C                   movel     xitdatc       wkdate
351700141014     C                   eval      usadt = wkdate
351800141014     C                   movel     usadt         dtdatc
351900141014      *
352000141014     C                   eval      dttimc = %EDITW(xittimc:'0 :  :  ')
352100141014     C                   endif
352200141014      *
352300141014     C                   movel     xitfudt       wkdate
352400141014     C                   eval      usadt = wkdate
352500141014     C                   movel     usadt         dtfudt
352600141014      *
352700141014     C                   eval      cktyp = 'Q'
352800141014     C                   eval      ckcod = xitresp
352900141014     C     codkey        chain     itcodp                             32
353000141014     C                   if        *in32 = '0'
353100141014     C                   movel(P)  ictext        dtresp
353200141014     C                   endif
353300141014      *
353400141014     C                   eval      cktyp = 'T'
353500141014     C                   eval      ckcod = xittypc
353600141014     C     codkey        chain     itcodp                             32
353700141014     C                   if        *in32 = '0'
353800141014     C                   movel(P)  ictext        dttype
353900141014     C                   endif
354000141014      *
354100141014     C                   movel     xitsbjt       dtsbjt
354200141014      *
354300141014     C                   endif
354400141014     C                   endif
354500141014      *
354600141013      *           Get next hist#
354700141013     C                   z-add     xitiss#       hiss#
354800141013     C                   z-add     99999         hhis#
354900141013     C     hiskey        setgt     ithisp
355000141013     C                   readp     ithisp                                 24
355100141013     C                   if        *in24 = '1' or xitiss# <> hiss#
355200141013     C                   z-add     01            svhis#
355300141013     C                   else
355400141013     C     ihhis#        add       01            svhis#
355500141013     C                   endif
355600141014     C                   z-add     atiss#        sviss#
355700141013      *
355800141013     C                   CLEAR                   @TIMESTAMP
355900141013     C                   MOVE      *BLANKS       @TS40
356000141013     C                   CALL      'TIMESTMP'
356100141013     C                   PARM                    @TS40
356200141013      *
356300141013     C                   movel     @TS40         @TIMESTAMP
356400141013     C                   movel     @TSUSER       hduser
356500141013     C                   move      #TSCYMD       svdato            8 0
356600141013     C                   move      #TSTIME       svtimo            6 0
356700141013    * *
356800141013     C                   movel     svdato        wkdate
356900141013     C                   eval      usadt = wkdate
357000141013     C                   movel     usadt         hddate
357100141013    * *
357200141013     C                   movel     svtimo        wktime
357300141013     C                   movel     wktime        hdtime
357400141013    * *
357500141013     C                   eval      hatxt1 = *blanks
357600141013     C                   eval      hatxt2 = *blanks
357700141013      *
357800141013     C     *IN01         DOWEQ     *OFF
357900141013      *
358000141013     C                   exfmt     addhst
358100141013      *
358200141013     C                   IF        *IN01 = *ON
358300141013     C                   eval      smsg = *blanks
358400141013     C                   MOVE      *Off          *IN01
358500141013     C                   leavesr
358600141013     C                   endif
358700141013      *
358800141013     C                   IF        hatxt1 = *blanks and hatxt2 = *blanks
358900141013     C                   iter
359000141013     C                   endif
359100141013      *         Write new hist rec
359200141013      *
359300141013     C                   clear                   ithisr
359400141013      *
359500141013     C                   eval      ihiss# = xitiss#
359600141013     C                   eval      ihhis# = svhis#
359700141013      *
359800141013     C                   CLEAR                   @TIMESTAMP
359900141013     C                   MOVE      *BLANKS       @TS40
360000141013     C                   CALL      'TIMESTMP'
360100141013     C                   PARM                    @TS40
360200141013      *
360300141013     C                   movel     @TS40         @TIMESTAMP
360400141013     C                   movel     @TSUSER       ihuser
360500141013     C                   move      #TSCYMD       svdato
360600141013     C                   move      #TSTIME       svtimo
360700141013    * *
360800141013     C                   movel     svdato        ihdate
360900141013     C                   movel     svtimo        ihtime
361000141013      *
361100141013     C                   eval      ihtypc = 'C'
361200141013      *
361300141013     C                   movel(P)  hatxt1        ihtext
361400141013     C                   move      hatxt2        ihtext
361500141013      *
361600141013     C                   write     ithisr
361700141013      *
361800141013     C                   leavesr
361900141013      *
362000141013     C                   ENDDO
362100141013      *
362200141013     C                   ENDSR
