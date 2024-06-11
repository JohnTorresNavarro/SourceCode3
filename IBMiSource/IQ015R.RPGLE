000100991124     F*-------------------------------------------------------------------------
000200131205     F* IQ015R     GBS SOFTWARE 2013
000300081111     F*            WRITTEN BY - RLJ
000400131205     F*            DATE - 12/2013
000500131209     F*  DESCRIPTION - ACA Premium Display
000600991124     F*
000700991124     F*-------------------------------------------------------------------------
000800151002     ** MODIFICATION HISTORY
000900151002     ** rlj 01/22/2014 - Expand subfile to include Seq# and Plan# -
001000151002     **                  Add Total Premium to display. Use GETRATE.
001100151002     ** rlj 02/14/2014 - Add 2% to premium for Cobra
001200151002     ** rlj 05/30/2014 - Add SMOKER flag to subfile
001300151002     ** B.Rees  12/2/2015   br01
001400151002     **   Issue when dispalying the amounts. We were passing the Enrolment
001500151002     **   date to #GetRate. At times there were no rates setup at the time
001600151002     **   of enrollment.  Also. This should be displaying the Current rates.
001700151002     **   Changed the Parmater: parmeffymd to be the first of the current
001800151002     **   month.
001900991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000140122     FMCOVC     IF   E           K DISK
002100140122     FDCOV22    IF   E           K DISK
002200130423     FPLNMST    IF   E           K DISK
002300140122     FPLNAUXP   IF   E           K DISK
002400131205     FMEMBER    IF   E           K DISK
002500131205     FDEPNDC    IF   E           K DISK
002600131206     Faccmst    IF   E           K DISK
002700140530     FSMOKE     IF   E           K DISK
002800131205     FIQ015D    CF   E             WORKSTN
002900130607     F                                     SFILE(DETAIL:RRN)
003000130425   X* *
003100130424     D                UDS
003200130424     D  @USER                100    107
003300130424     D  CONAME               201    240
0034001304240056 D  lprefix              241    241
003500140123JGE01D  LD8YMD               248    255  0
003600131231      *
003700131231    *** TIMESTAMP FIELDS DATA STRUCTURE
003800131231      *
003900131231     D @TIMESTAMP      DS
004000131231     D  #TSCYMD                1      8S 0
004100131231     D  #TSTIME                9     14S 0
004200131231     D  @TSJOB                15     24
004300131231     D  @TSUSER               25     34
004400131231     D  #TSNBR                35     40S 0
004500131231    ***
004600131126    * *
004700131126     D                 DS
004800131205     D @KEYPRM                 1      9A
004900131205     D #KSSN                   1      9S 0
005000130424    * *
0051001401220048 D                 DS
0052001402060055 D mtspabct                1     15
0053001401220055 D mctrst                  1      3  0
0054001401220055 D mcsub#                  4      6  0
0055001401220055 D mcplan                  7     10
0056001401220055 D mcageb                 11     12  0
0057001401220055 D mcovtp2                13     15
005800140123    * *
0059001402060048 D                 DS
0060001402060055 D dtspabct                1     15
0061001402060055 D dvtrst                  1      3  0
0062001402060055 D dvsub#                  4      6  0
0063001402060055 D dvplan                  7     10
0064001402060055 D dvageb                 11     12  0 INZ(0)
0065001402060055 D dvcovtp                13     15    INZ('   ')
006600140206    * *
006700140123     D                 DS
006800140123     D  GRgroup                      15
006900140123     D  GRP#                          6    OVERLAY(GRgroup)
007000140123    * *
007100130424     D                 DS
0072001312050037 D wkdate          S               D   datfmt(*iso)
0073001311110037 D sysdateymd      S               D   datfmt(*iso)
007400130510     D usadt           S               D   DATFMT(*USA/)
007500140618     D svseq           S                   LIKE(dseq#)
007600140206     D kplan           S                   LIKE(mcplan)
007700131231     D todate          S              8S 0
007800131231     D @TS40           S             40A
007900140618     D cbrflg          S              1
008000151002br01 D FirstOfMth      S              8
008100081111      *
0082001304230053 D                 DS
0083001304230054 D  invacc         C                   'INVALID TRUST/SUB#/ACCOUNT  '
008400151002      *--------------------------------------------------------------------------
008500131209     C     mplky         KLIST
008600140122     C                   KFLD                    mctrst
008700140122     C                   KFLD                    mcsub#
008800140122     C                   KFLD                    mcplan
008900140206    * *
009000140206     C     dc22ky        KLIST
009100140206     C                   KFLD                    mctrst
009200140206     C                   KFLD                    mcsub#
009300140206     C                   KFLD                    kplan
009400140206     C                   KFLD                    mcssno
009500131209    * *
009600131209     C     plnky         KLIST
009700140618     C                   KFLD                    dvtrst
009800140618     C                   KFLD                    dvsub#
009900140618     C                   KFLD                    dvplan
010000131206    * *
010100131206     C     acckey        KLIST
010200131206     C                   KFLD                    mbtrst
010300131206     C                   KFLD                    mbsub#
010400131206     C                   KFLD                    mbacct
010500131107    * *
010600131205     C     depky         KLIST
010700140206     C                   KFLD                    ssno
010800140206     C                   KFLD                    dseq#
010900140530    * *
011000140530     C     smkky         KLIST
011100140530     C                   KFLD                    sssno             9 0
011200140530     C                   KFLD                    sdseq#            2 0
011300131205    * *
011400131205    * *
011500131205    * *
011600131205     C     *ENTRY        PLIST
011700131205     C                   PARM                    @PARM             9
011800131205     C                   MOVEL(P)  @PARM         @KEYPRM
011900140123     C                   MOVEL     @KEYPRM       ssnod
012000131231    * *
012100131231     C                   CLEAR                   @TIMESTAMP
012200131231     C                   MOVE      *BLANKS       @TS40
012300131231     C                   CALL      'TIMESTMP'
012400131231     C                   PARM                    @TS40
012500131231     C                   MOVEL     @TS40         @TIMESTAMP
012600131231     C                   MOVE      #TSCYMD       todate
012700151002     C
012800151002br01 C                   eval      FirstOfMth =
012900151002br01 C                               %subst(%char(%Date):1:6) + '01'
013000151002     C
013100131205    * *
013200131206     C     #kssn         chain     member                             32
013300131206     C                   if        *in32 = '0'
013400131206     C                   eval      mbrnam = %TRIM(mlname) + ', ' +
013500131206     C                             %TRIM(mfname)
013600131206      *
013700131206     C                   MOVEL     mbtrst        trust
013800131206     C                   MOVEL     mbsub#        subno
013900131206     C                   MOVEL     mbacct        accno
014000140618      *     Check for COBRA
014100140618     C                   eval      cbrflg = 'N'
014200140618     C                   if        gbscdt <> 0 and gbscdt < todate
014300140618     C                   if        cexpdt = 0 or cexpdt > todate
014400140618     C                   if        elecrt <> 'D'
014500140618     C                   eval      cbrflg = 'Y'
014600140618     C                   endif
014700140618     C                   endif
014800140618     C                   endif
014900131206    * *
015000131206     C     acckey        chain     accmst                             33
015100131206     C                   if        *in33 = '0'
015200131206     C                   eval      accnam = acnam1
015300131206     C                   endif
015400131206      *
015500131206     C                   endif
015600131206      *
015700131205     C                   MOVEL     CONAME        TITLE
015800131205     C                   MOVE      '0'           @EXIT             1
015900130426    * *
016000130423      * MAINLINE
016100130607      *
016200130607     C     *IN01         DOWEQ     *OFF
016300130607     C     *IN07         ANDEQ     *OFF
016400130607      *      RELOAD IF CLIENT SEARCH CHANGES
016500130607     C                   EXSR      $CLEAR
016600130607     C                   EXSR      $LOAD
016700130607     C                   EXSR      $DISPLAY
016800130607     C                   setoff                                       88
016900130607      *    PROCESS SELECTION
017000130607     C***  *IN01         IFEQ      *OFF
017100130607     C***  *IN07         ANDEQ     *OFF
017200130607     C***  RRN           ANDNE     *ZERO
017300130607     C********           EXSR      $PROCES
017400130607     C*****              ENDIF
017500130607      *
017600130607     C                   enddo
017700130607      *
017800131205     C                   eval      *inlr = '1'
017900131205     C                   return
018000130607      ******************************************************************
018100130607      *       SUBROUTINE - $CLEAR                                      *
018200130607      *                    CLEAR SUBF AND RRN                          *
018300130607      ******************************************************************
018400130607     C     $CLEAR        BEGSR
018500130607     C                   MOVEA     '001'         *IN(31)
018600130607     C                   wRITE     HEADER
018700130607     C                   Z-ADD     *ZERO         RRN               4 0
018800130607     C                   WRITE     HEADER
018900130607     C                   MOVEA     '010'         *IN(31)
019000130607     C                   ENDSR
019100130607      ******************************************************************
019200130607      *       SUBROUTINE - $LOAD                                       *
019300130607      *                    LOAD SUBFILE W/ Change Info                 *
019400130607      ******************************************************************
019500130607     C     $LOAD         BEGSR
019600140618      *
019700130607     C                   SETOFF                                       3495
019800140122     C     #kssn         setll     mcovc                              34
019900130607     C     *IN34         DOUEQ     *ON
020000130607     C     *IN95         OREQ      *ON
020100140122     C     #kssn         reade     mcovc                                  34
020200130607     C                   IF        (*In34 <> *ON) and
020300140122     C                             mcssno = #kssn
020400131205      *
020500140122     C                   if        candt <> 0
020600140122     C                   if        enrldt = candt or
020700140122     C                             candt < todate
020800131231     C                   iter
020900131231     C                   endif
021000131231     C                   endif
021100140122      *
021200140122     C     mplky         chain     plnauxp                            35
021300140122     C                   if        *in35 = '1' or pxacar <> 'Y'
021400140122     C                   iter
021500140122     C                   endif
021600131231      *
021700140206     C                   eval      kplan = mcplan
021800140206      *
021900140206     C                   ADD       1             RRN
022000131205      *
022100131209     C                   eval      ddepnam = mbrnam
022200131209     C                   movel(P)  'MEMBER'      ddeprel
022300140122     C                   movel(P)  '00'          ddseq#
022400131205      *
022500140122     C                   if        enrldt = 0
022600131216     C                   eval      ddcovd = '00/00/0000'
022700131216     C                   else
022800140122     C                   movel     enrldt        wkdate
022900131205     C                   eval      usadt = wkdate
023000131205     C                   movel     usadt         ddcovd
023100131216     C                   endif
023200131205      *
023300140122     C                   movel(P)  mcplan        ddplan
023400140122      *
023500131209     C     mplky         chain     plnmst                             37
023600131205     C                   if        *in37 = '0'
023700131205     C                   movel     pdescr        dddesc
023800131205     C                   endif
023900140122      **********
024000140122
024100140122      *? GET RATE
024200140122
0243001401220074 C                   EVAL      *IN80 = *OFF
0244001401220385 C* clear fields first
0245001401220387 C                   clear                   grgroup
0246001402060073  *
024700140206     c     grplist       plist
024800140206     c                   parm                    parmkey          15
024900140206     C                   PARM                    PARMSSN           9
025000140206     C                   PARM                    PARMSEQ           2
025100140206     c                   parm                    parmeffymd        8
025200140206     c                   parm                    parmbenamt        7
025300140206     c                   parm                    parmgroup        15
025400140206     c                   parm                    parmbilrte       11
025500140206     c                   parm                    parmnetrte       11
025600140206     c                   parm                    parmbilprem       7
025700140206     c                   parm                    parmnetprem       7
025800140206     c                   parm                    parmfound         1
025900140206    * *
026000140206     C                   movel     #kssn         PARMSSN
026100140206     C                   movel     '00'          PARMSEQ
026200140206      *
026300140206     c                   move      mtspabct      parmkey
026400140618     c*****              move      ld8ymd        parmeffymd
026500151002br01 c*****              move      enrldt        parmeffymd
026600151002br01 c                   move      FirstOfMth    parmeffymd
026700140122     c                   move      benamt        parmbenamt
026800140122     c                   clear                   parmgroup
026900140122     c                   clear                   parmbilrte
027000140122     c                   clear                   parmnetrte
027100140122     c                   clear                   parmbilprem
027200140122     c                   clear                   parmnetprem
027300140122     c                   clear                   parmfound
027400140122
027500140122     c                   call      'GETRATE'     grplist
027600140122
027700140122      * grate not returned
0278001401220361 C                   if        parmfound = 'Y'
027900140207     c                   move      parmkey       mtspabct
028000140122     c                   move      parmgroup     grgroup
028100140207     c                   move      parmbilprem   prem              7 2
028200140618      *     Cobra? - add 2%
0283001406180361 C                   if        cbrflg = 'Y'
028400140618     C     prem          mult(H)   1.02          prem
028500140618     C                   endif
028600140618      *
028700140618     c                   z-add     prem          totprem           7 2
028800140618     C                   eval      ddprem = %EDITC(prem:'1')
028900140207     C                   eval      ddage = %EDITC(mcageb:'1')
029000140122     c                   else
029100140122     C                   EVAL      *IN80 = *ON
029200140123     C********           MOVEL     MSG(1)        HMSG
029300140122     C                   END
029400140122
029500140122      *********?
029600140123     C***                eval      ddage = %EDITC(m2rage:'A')
029700140123     C***                eval      ddprem = %EDITC(m2crate:'1')
029800130607      *
029900140530     C                   eval      ddsmk = *blank
030000140530     C                   eval      sssno = #kssn
030100140530     C                   eval      sdseq# = 0
030200140530     C     smkky         chain     smoke                              37
030300140530     C                   if        *in37 = '0' and skratefr < todate and
030400140530     C                             (skrateto > todate or skrateto = 0)
030500140530     C                   eval      ddsmk = 'Y'
030600140530     C                   ENDIF
030700140530      *
030800130607     C                   WRITE     DETAIL
030900130607     C                   ENDIF
031000130607     C                   ENDDO
031100131209      *           Look for Dependent records
031200131209     C                   eval      svseq = 0
031300140206     C     dc22ky        setll     dcov22                             34
031400131209     C     *IN34         DOUEQ     *ON
031500131209     C     *IN95         OREQ      *ON
031600140206     C     dc22ky        reade     dcov22                                 34
031700131209     C                   IF        (*In34 <> *ON) and
031800140206     C                             ssno = #kssn
031900131231      *
032000140206     C                   if        ccandt <> 0
032100140206     C                   if        denrdt = ccandt or
032200140206     C                             ccandt < todate
032300131231     C                   iter
032400131231     C                   endif
032500131231     C                   endif
032600131231      *
032700131209     C                   ADD       1             RRN
032800131209      *
032900140206     C                   movel(P)  dseq#         ddseq#
033000140206      *
033100140206     C                   if        svseq <> dseq#
033200131209     C     depky         chain     depndc                             36
033300131209     C                   if        *in36 = '0'
033400131209     C                   eval      ddepnam = %TRIM(dlname) + ', ' +
033500131209     C                             %TRIM(dfname)
033600131209      *
033700131209     C                   if        drelcd = 'RSO'
033800131209     C                   movel(P)  'SON'         ddeprel
033900131209     C                   elseif    drelcd = 'RDA'
034000131209     C                   movel(P)  'DAUGHTER'    ddeprel
034100131209     C                   elseif    drelcd = 'RHU'
034200131209     C                   movel(P)  'HUSBAND'     ddeprel
034300131209     C                   elseif    drelcd = 'RWI'
034400131209     C                   movel(P)  'WIFE'        ddeprel
034500131209     C                   else
034600131209     C                   movel(P)  'OTHER'       ddeprel
034700131209     C                   endif
034800131209      *
034900131209     C                   endif
035000131209      *
035100131209     C                   endif
035200131209      *
035300140206     C                   if        denrdt = 0
035400131216     C                   eval      ddcovd = '00/00/0000'
035500131216     C                   else
035600140206     C                   movel     denrdt        wkdate
035700131209     C                   eval      usadt = wkdate
035800131209     C                   movel     usadt         ddcovd
035900131216     C                   endif
036000131209      *
036100131209     C     plnky         chain     plnmst                             37
036200131209     C                   if        *in37 = '0'
036300131209     C                   movel     pdescr        dddesc
036400131209     C                   endif
036500140206
036600140206      *? GET RATE
036700140206
0368001402060074 C                   EVAL      *IN80 = *OFF
0369001402060385 C* clear fields first
0370001402060387 C                   clear                   grgroup
037100140206    * *
037200140206     C                   movel     ssno          PARMSSN
037300140206     C                   movel     dseq#         PARMSEQ
037400140206      *
037500140206     c                   move      dtspabct      parmkey
037600140618     c******             move      ld8ymd        parmeffymd
037700140618     c                   move      denrdt        parmeffymd
037800140206     c                   move      benamt        parmbenamt
037900140206     c                   clear                   parmgroup
038000140206     c                   clear                   parmbilrte
038100140206     c                   clear                   parmnetrte
038200140206     c                   clear                   parmbilprem
038300140206     c                   clear                   parmnetprem
038400140206     c                   clear                   parmfound
038500140206
038600140206     c                   call      'GETRATE'     grplist
038700140206
038800140206      * grate not returned
0389001402060361 C                   if        parmfound = 'Y'
039000140207     c                   move      parmkey       dtspabct
039100140206     c                   move      parmgroup     grgroup
039200140207     c                   move      parmbilprem   prem
039300140618      *     Cobra? - add 2%
0394001406180361 C                   if        cbrflg = 'Y'
039500140618     C     prem          mult(H)   1.02          prem
039600140618     C                   endif
039700140618      *
039800140207     c                   add       prem          totprem
039900140207     C                   eval      ddprem = %EDITC(prem:'1')
040000140207     C                   eval      ddage = %EDITC(dvageb:'1')
040100140206     c                   else
040200140206     C                   EVAL      *IN80 = *ON
040300140206     C********           MOVEL     MSG(1)        HMSG
040400140206     C                   END
040500140530      *
040600140530     C                   eval      ddsmk = *blank
040700140530     C                   eval      sssno = #kssn
040800140530     C                   eval      sdseq# = dseq#
040900140530     C     smkky         chain     smoke                              37
041000140530     C                   if        *in37 = '0' and skratefr < todate and
041100140530     C                             (skrateto > todate or skrateto = 0)
041200140530     C                   eval      ddsmk = 'Y'
041300140530     C                   ENDIF
041400131209      *
041500131209     C                   WRITE     DETAIL
041600131209     C                   ENDIF
041700131209     C                   ENDDO
041800140207      *
041900140207     C                   eval      ddepnam = *blanks
042000140207     C                   eval      ddeprel = *blanks
042100140207     C                   eval      ddseq# = *blanks
042200140207     C                   eval      ddcovd = *blanks
042300140207     C                   eval      ddplan = *blanks
042400140207     C                   eval      dddesc = *blanks
042500140207     C                   move      'TOTAL'       dddesc
042600140530     C                   eval      ddsmk  = *blanks
042700140530     C                   eval      ddage  = *blanks
042800140207     C                   eval      ddprem = %EDITC(totprem:'1')
042900140207     C                   ADD       1             RRN
043000140207     C                   WRITE     DETAIL
043100140207      *
043200130607     C                   ENDSR
043300130607      ******************************************************************
043400130607      *       SUBROUTINE - $DISPLAY                                    *
043500130607      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
043600130607      ******************************************************************
043700130607     C     $DISPLAY      BEGSR
043800130607     C                   If        RRN <> *Zero
043900130607     C                   MOVE      *ON           *IN31
044000130607     C                   ENDIF
044100130607     C                   WRITE     TRAILER
044200130607     C                   EXFMT     HEADER
044300130607     C                   ENDSR
044400130607      *
