000100030521     H DATEDIT(*YMD)
000101141118    *H OPTION(*NODEBUGIO) DFTACTGRP(*NO) ACTGRP(*CALLER)
000102141205    *H** ALWNULL(*USRCTL)
000103141118     Hbnddir('ALLSRVPGMN')
0002009707230002 F******************************************************************
0003001404010003 F* fm410      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009707230004 F*                                                                *
0005009707230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006001404010006 F*            DATE - 04/01/14                                     *
0007009707230007 F*                                                                *
0008001404010008 F*  DESCRIPTION - THIS PROGRAM ALLOWS MAINTENANCE OF THE SMOKE    *
0009001404110009 F*                / TOBACCO FILE. It is accessed from the FM3     *
003300140411SK   F*                menu (#11) and it is called from FM070.         *
003301140709SK   F*                                                                *
003302140709SK   F* 07/08/14 dlk - add trnmit for Coventry since they are the only *
003303140709SK   F*                one who uses the tobacco indicator in their     *
003304140709SK   F*                update file. Note: only the fields needed for   *
003305140709SK   F*                the Coventry programs (DW340) are filled in the *
003306140709SK   F*                trnmit record so if this is ever needed for     *
003307140709SK   F*                other carriers the fields filled will need to be*
003308140709SK   F*                reviewed.                                       *
003309141118      * 11/18/14 dlk - change to use value returned from checkacaplan
003310141118      *                function instead of field pxacar in plnauxp because
003311141118      *                there are now other values with different meanings
003312141118      *                but the value returned will be "Y" for individual
003313141118      *                rating and "N" for group rating.
003314141118      *                Binding directory "ALLSRVPGMN" added for chkacaplan
003315141118      *                function.
003316141205      * 12/05/14 dlk - remove allow null compiler directive, since FM410
003317141205      *                is also called from FM070 and some files share
003318141205      *                the open data path (TRNMIT) that was already opened
003319141205      *                without allowing nulls, an error occured.
003320150421      * 04/21/15 dlk - add new carrier group code for coventry
003321140709SK   F*                                                                *
0034009811190013 F******************************************************************
003500140401     Ffm410D    CF   E             WORKSTN INFDS(WSDS)
003600140401     F                                     SFILE(s02s:RR2)
003601140401     FMEMBER    IF   E           K DISK
004000970813     FDEPNDC    IF   E           K DISK
004001140402     Fmcov      IF   E           K DISK
004002140402     Fdcovc     IF   E           K DISK
004003140402     Fplnmst    IF   E           K DISK
004004140402     Fplnauxp   IF   E           K DISK
004005140708     Fcarmst    IF   E           K DISK
004301140401     Fsmoke     UF A E             DISK
004302140401     Fsmokel1   if   E           K DISK    infds(smokeinfds)
004303140401     f                                     rename(smoker:smokerl1)
004305140401     Fhist      o  A E             DISK
0043061407070024 Ftrnmit    o  a e             disk
004307141118
004308141118      * Check ACA Function (#chk_aca_plan)
004309141118      /define chk_ACA_plan_pr
004310141118      /define chk_ACA_plan_fields
004311141118      /copy qcpysrc,acasrvpgmp
004312141118      /undefine chk_ACA_plan_pr
004313141118      /undefine chk_ACA_plan_fields
004314141118
004315141118      *
004316140410     D MSG             S             60A   DIM(7) CTDATA PERRCD(1)
004317140401     D done            s              1    inz(' ')
0043181404100037 D workdtmdy       S               d   datfmt(*usa)
0043191405220037 D workdtymd       S               d   datfmt(*iso)
004320140514     D chgdate         s              8  0
004321140514     D fromchg         s              8  0
004322140410     D lastdom         s              2  0
004323140410     D todateok        s              1
004324140410     D daterr          s              1
004325140402     D acaplans        s              1
004326140502     D action          s              1
004327140401     D keyrec#         s                   like(wqrelr)
004328140402     D keyplan         s                   like(mcplan)
0043291404020037 D sysdateymd      S               d   datfmt(*iso)
0043301404020037 D systime         S               t
004331140402     D thispgmname     S             10a   inz('FM410     ')
004332140708     d hplan#          s                   like(plan#)
004333140708     d henrldt         s                   like(enrldt)
004334140708     d hcancdt         s                   like(cancdt)
004335140708     d hcarcod         s                   like(pcarr)
004336141118     D acairat         S              1
004337140402
004338140401     D smokeinfds    E DS                  EXTNAME(IODBFD)
004339140402DTAQ D WDHIST        E DS                  EXTNAME(HIST) PREFIX(Q_)
004340140401     D WSDS            DS
004341140401     D  FKEY                 369    369A
004342140410
004343140410     D                 DS
004344140410     d dateck                  1      8  0
004345140410     d dateckmm                1      2  0
004346140410     d dateckdd                3      4  0
004347140410     D                 DS
004348140410     d tempdtmdy               1      8  0
004349140410     d tempdtdd                3      4  0
004350140402
004351140402     D beforeds        DS
004352140402     d bfratefr                       8  0
004353140402     d bfrateto                       8  0
004354140402
004355140402     D afterds         DS
004356140402     d afratefr                       8  0
004357140402     d afrateto                       8  0
004358140514     D                 DS
004359140514     d tochg                   1      8  0
004360140514     d tochgdd                 7      8  0
004361140402      * member hist note 1
0043621404020055 D                 DS
0043631404020056 D  note1out               1     30
004364140502     D  n1ptxt                 1      4    inz('Bf- ')
004365140502     D  n1ratefr               6     13
004366140502     D  n1rateto              15     22
004367140402     D  n1deptxt              26     30
004368140402      * member hist note 2
0043691404020055 D                 DS
0043701404020056 D  note2out               1     30
004371140502     D  n2ptxt                 1      4    inz('Af- ')
004372140403     D  n2ratefr               6     13
004373140403     D  n2rateto              15     22
004374140402
004375140402DTAQ  * adjust note 1
004376140402DTAQ D                 DS                  Inz
004377140402DTAQ D  adj_note1              1     30
004378140402DTAQ D   a_plan                1      4
004379140402DTAQ D   a_ab                 15     16S 0
004380140402DTAQ D   a_ct                 27     28
004381140402
004382140401     ***
004383140401     D  F1             C                   CONST(X'31')
004384140401     D  F2             C                   CONST(X'32')
004385140401     D  F3             C                   CONST(X'33')
004386140401     D  F4             C                   CONST(X'34')
004387140401     D  F5             C                   CONST(X'35')
004388140401     D  F6             C                   CONST(X'36')
004389140401     D  F7             C                   CONST(X'37')
004390140401     D  F8             C                   CONST(X'38')
004391140401     D  F9             C                   CONST(X'39')
004392140401     D  F10            C                   CONST(X'3A')
004393140401     D  F11            C                   CONST(X'3B')
004394140401     D  F12            C                   CONST(X'3C')
004395140401     D  F13            C                   CONST(X'B1')
004396140401     D  F14            C                   CONST(X'B2')
004397140401     D  F15            C                   CONST(X'B3')
004398140401     D  F16            C                   CONST(X'B4')
004399140401     D  F17            C                   CONST(X'B5')
004400140401     D  F18            C                   CONST(X'B6')
004401140401     D  F19            C                   CONST(X'B7')
004402140401     D  F20            C                   CONST(X'B8')
004403140401     D  F21            C                   CONST(X'B9')
004404140401     D  F22            C                   CONST(X'BA')
004405140401     D  F23            C                   CONST(X'BB')
004406140401     D  F24            C                   CONST(X'BC')
0053009709240600 D                UDS
0053011404020692 D  luser                  1     10
0054009707230601 D  CONAME               201    240
005401140402
005900140401SSK1 D HOLDSSN         S              9S 0
005901140401SSK1 D HOLDdep         S              2S 0
006000001127SSK1 D #ISO            S               D   DATFMT(*ISO)
006100001127SSK1 D #USA            S               D   DATFMT(*USA)
006321081114
006322081029      * Program status data structure
006323081029     D PGMD          ESDS                  EXTNAME(IOPGMD)
0063240810290025
006500971103     C     *ENTRY        PLIST
006600971103     C                   PARM                    SSNIN             9
006601140401     C                   PARM                    depin             2
006800140401SSK1 C                   MOVE      SSNIN         HOLDSSN
006801140401SSK1 C                   MOVE      depin         holddep
006900971103     C*
007201140401     C     depkey        KLIST
007202140401     C                   KFLD                    s1ssn
007203140401     C                   KFLD                    s1dep
007204140401
007205140402     C     plankey       KLIST
007206140402     C                   KFLD                    mbtrst
007207140402     C                   KFLD                    mbsub#
007208140402     C                   KFLD                    keyplan
007217140707
010501140401SSK1 C                   Z-ADD     HOLDSSN       s1ssn
010502140401SSK1 C                   Z-ADD     HOLDdep       s1dep
010504140401
010601140401     c                   dou       done = 'Y'
010602140401
010800140414      * DISPLAY FIRST SCREEN if called from menu. If called from FM070 with
010801140414      * the ssn already passed as a parm then do not show the first screen
010802140414      * unless an error occurs. This will save a step for the user
010804140414     c                   if        holdssn = 0 or s1msg <> *blanks
011200970813     C                   EXFMT     S01
011201140414     c                   end
011202140414
011204140401     c                   clear                   mname
011205140401     c                   clear                   dname
011206140402     c                   clear                   s1msg
011600140401      * F1 END
011601140401     C                   IF        FKEY = F1
011800140401     C                   leave
011801140401     c                   end
011900140401
012000970813     C* VALIDATE SSN
012200140401     C     s1ssn         CHAIN     MEMBER
012201140401     c                   if        not %found(member)
012202140401     C                   MOVEL(P)  MSG(1)        s1msg
012203140401     c                   iter
012205140401     c                   end
012206140402
012207140402      * format mem name
012208140402     C                   movel     mfname        mname
012209140402     C                   if        mmi <> ' '
012210140402     C                   cat       mmi:1         mname
012211140402     C                   cat       '.':0         mname
012212140402     C                   end
012213140402     C                   cat       mlname:1      mname
012216140401
012217140401
012218140401     C* VALIDATE dep #
012219140401     c                   if        s1dep <> 0
012220140401     C     depkey        CHAIN     depndc
012221140401     c                   if        not %found(depndc)
012222140401     C                   MOVEL(P)  MSG(2)        s1msg
012223140401     c                   iter
012224140401     c                   end
012225140402      * format dep name
012226140402     C                   movel     dfname        dname
012227140402     C                   if        dmi <> ' '
012228140402     C                   cat       dmi:1         dname
012229140402     C                   cat       '.':0         dname
012230140402     C                   end
012231140402     C                   cat       dlname:1      dname
012232140402
012234140401     c                   end
012235140401
012236140401      * screen 2
012237140401     c                   exsr      #dsp02
012238140401
014301140401     c                   enddo
014302140401
014303140401      * end - return to menu or calling pgm
014500970812     C                   MOVE      *ON           *INLR
014600970812     C*
014700970813     C*******************************************************
014800970813     C* SCREEN 2 SUBROUTINE - SELECT RECORD TO UPDATE       *
014900970813     C*******************************************************
015000970812     C*
015100970812     C     #DSP02        BEGSR
015200140401
015201140401     C     #T0100        TAG
015300140401      * CLEAR SUBFILE
015700970813     C                   MOVEA     '0010'        *IN(60)
015800140402     C                   clear                   s2sel
015900970812     C                   WRITE     S02CTL
016000970723     C                   MOVE      '0'           *IN62
016100970723     C*
016200140401     C* BUILD SUBFILE - LOAD ALL FOR THIS SSN / dep#
016300970723     C*
016500140402     C                   clear                   RR2               5 0
016501140402     C                   clear                   sfrec#
016700140401     C     depkey        SETLL     smokel1
016900140401     C                   dou       %eof(smokel1)
017000140401     C     depkey        READe     smokel1
017100970723     C*
017200140401    1C                   if        not %eof(smokel1)
017400140401     C                   CLEAR                   s02s
019507140401      * rate from dt
019508140401     C                   MOVE      SKRATEFR      @DATIN
019509140401     C                   EXSR      #DATYM
019510140401     C                   MOVE      @datou        s2rafrdt
019512140401      * rate to dt
019513140401     C                   MOVE      SKRATETO      @DATIN
019514140401     C                   EXSR      #DATYM
019515140401     C                   MOVE      @datou        s2ratodt
019516140401
019700140402     C                   ADD       1             sfrec#
019701140402     C                   ADD       1             RR2
019801140401     c                   move      wqrelr        s2rec#
019802140402     C                   clear                   s2sel
019900140401     C                   WRITE     s02s
020100001127    1C                   END
020101140401    1C                   enddo
020200970723     C*
020300970723     C* DISPLAY SUBFILE
020400970723     C*
020500970723     C     #T0120        TAG
020600140401     C                   if        rr2 > 0
020700140401     C                   eval      *IN60 = *on
020800970813     C                   END
020801140401     C                   eval      *IN61 = *on
021000970813     C*
021100140401     C                   WRITE     S02FKEY
021200970813     C                   EXFMT     S02CTL
021400140401     C* F1 RETURN
021501140401     c                   if        fkey = f1
021600140401     C                   leavesr
021601140401     c                   end
021602140401     C* F6 add new record
021603140401     c                   if        fkey = f6
021604140401     c                   clear                   keyrec#
021610140401     C                   exsr      #dsp03
021611140401     C                   goto      #t0100
021612140401     c                   end
021700970723     C*
021800140401     C* READ SUBFILE FOR SSN SELECTED
021900970723     C*
022000140402     C                   if        *in60 = *on
022002140401     c                   dou       %eof(fm410d)
022200140401     C                   READC     s02s
022201140401     c                   if        not %eof(fm410d) and s2sel <> ' '
022202140401     c                   move      s2rec#        keyrec#
022203140402     c                   clear                   s2sel
022504140401     c                   exsr      #dsp03
023001140401     c                   end
023002140401     c                   enddo
023003140401     c                   end
023100970723     C*
023200970813     C* ENTER PRESSED ... RE-DISPLAY AND TRY AGAIN
023300970723     C*
023400140402     C                   GOTO      #T0100
023500970723     C*
023700970812     C                   ENDSR
023800970813     C*
023900970813     C*******************************************************
024000970813     C* SCREEN 3 - UPDATE                                   *
024100970813     C*******************************************************
024200970813     C*
024300970812     C     #DSP03        BEGSR
024301140402
024500140402      * clear before / after DS
024501140402     c                   clear                   beforeds
024502140402     c                   clear                   afterds
024503140402
024504140402      * GET RECORD FOR UPDATE OR CLEAR FIELDS FOR ADD
024800140401     C     keyrec#       CHAIN     smoke
025100140402      * new rec
025200140401    1C                   if        not %found(smoke)
025201140402
025300140401SSK1 C                   CLEAR                   smoker
025301140401     c                   move      s1ssn         skssn
025302140401     c                   move      s1dep         skdep#
025305140402     c                   clear                   S03RAFRDT
025306140402     c                   clear                   S03RATODT
025307140402
025309140402     c                   else
025310140402      * hold fields before update (YMD)
025313140402     C                   MOVE      SKRATEFR      bfratefr
025314140402     C                   MOVE      SKRATETO      bfrateto
025315140402      * update rec
025316140402
028809140401      * rate from dt
028810140401     C                   MOVE      SKRATEFR      @DATIN
028811140401     C                   EXSR      #DATYM
028812140401     C                   MOVE      @datou        S03RAFRDT
028813140401      * rate to dt
028814140401     C                   MOVE      SKRATETO      @DATIN
028815140401     C                   EXSR      #DATYM
028816140401     C                   MOVE      @datou        S03RATODT
028817140401     c                   end
028818140401
028819140401     c                   dou       fkey = f1
029000970813     C                   EXFMT     S03
029002140402     c                   clear                   s3msg
029003140401     c                   movea     '0000'        *in(70)
029200140401      * F1 = return
029201140401     c                   if        fkey = f1
029202140401     c                   unlock    smoke
029203140401     c                   leave
029204140401     c                   end
029400140410      ************
030200140410      * EDITS
030201140410      ************
030254140401
030255140410      * rate from date
030259140401     C                   MOVE      S03RAFRDT     dateck
030260140401     c                   exsr      #datck
030261140410     c                   if        daterr = 'Y' or s03rafrdt = 0 or
030262140410     c                             dateckdd <> 01
030263140401     c                   eval      *in72 = *on
030264140410     C                   MOVEL(P)  MSG(6)        s3msg
030265140401     c                   iter
030266140401     c                   end
030267140401
030268140410      * rate to date
030269140410     c                   clear                   todateok
030270140410     c                   clear                   s03rafrdtymd
030271140410     c                   clear                   s03ratodtymd
030272140401     C                   MOVE      S03RATODT     dateck
030273140401     c                   exsr      #datck
030274140410      * valid to dates are zero, same as from date and last day of month
030275140410      * after the from date
030276140410
030277140410     c                   clear                   lastdom
030278140410     c                   if        s03ratodt <> 0 and daterr <> 'Y'
030279140410      * get last day of month
030280140410     c                   move      dateck        tempdtmdy
030281140410     c                   move      01            tempdtdd
030282140410     c                   move      tempdtmdy     workdtmdy
030283140410     c                   adddur    1:*m          workdtmdy
030284140410     c                   subdur    1:*d          workdtmdy
030285140410     c                   extrct    workdtmdy:*d  lastdom
030286140410     c                   end
030287140410
030288140410     C                   MOVE      S03RATODT     @DATIN
030289140410     C                   EXSR      #DATYM
030290140410     C                   MOVE      @datou        s03ratodtymd      8 0
030291140410
030292140410     C                   MOVE      S03RAFRDT     @DATIN
030293140410     C                   EXSR      #DATYM
030294140410     C                   MOVE      @datou        s03rafrdtymd      8 0
030295140410
030296140410     c                   if        s03ratodt = 0 or
030297140410     c                             s03ratodt = s03rafrdt or
030298140410     c                             (s03ratodtymd > s03rafrdtymd and
030299140410     c                             dateckdd = lastdom)
030300140410     c                   eval      todateok = 'Y'
030301140410     c                   end
030302140410
030303140410     c                   if        daterr = 'Y' or todateok <> 'Y'
030304140401     c                   eval      *in73 = *on
030305140410     C                   MOVEL(P)  MSG(7)        s3msg
030306140401     c                   iter
030307140401     c                   end
030308140401
030309140401
030310140402      * convert dates back to ymd for update
030319140401      * rate from dt
030320140401     C                   MOVE      S03RAFRDT     @DATIN
030321140401     C                   EXSR      #DATYM
030322140401     C                   MOVE      @datou        SKRATEFR
030323140401      * rate to dt
030324140401     C                   MOVE      S03RATODT     @DATIN
030325140401     C                   EXSR      #DATYM
030326140401     C                   MOVE      @datou        SKRATETO
030327140402
030328140402      * additional edits
030343140402
030344140402      * rate to dt
030345140402     c                   if        skrateto <> 0 and skrateto < skratefr
030346140402     c                   eval      *in73 = *on
030347140402     C                   MOVEL(P)  MSG(5)        s3msg
030348140402     c                   iter
030349140402     c                   end
030350140402
044600140402     C* fields after any changes on screen
044603140402     C                   MOVE      SKRATEFR      afratefr
044604140402     C                   MOVE      SKRATETO      afrateto
044605140402
044607140402     C* UPDATE
044701140401     c                   if        %found(smoke)
044702140502     c                   eval      action = 'C'
044703140401     C                   UPDATE    smoker
044710140401     c                   else
044711140502     c                   eval      action = 'A'
044800140401     C                   WRITE     smoker
045001140401     c                   end
045002140401
045003140402      * write history and adjust if anything changed
045005140402     c                   if        beforeds <> afterds
045006140402     c                   exsr      #hist
045007140402     c                   end
045008140402
045009140401     c                   leave
045010140401
045011140401     c                   enddo
045012140401
057100140401     C                   ENDSR
057101140707
057200970813     C*
057201140401      ****************************************************************
0572021404023881  *----------------------- DATE CHECK ---------------------------*
0572031404011244  *  This subr validates the field DATECK in MMDDYYYY order
057204140402      ****************************************************************
0572051404011239 C*
0572061404011240 C     #DATCK        BEGSR
057207140402
057208140410     C                   clear                   daterr
057209140410     C                   clear                   lastdom
057210140410
057212140401     c                   if        dateck <> 0
057213140410     c     *usa          test(de)                dateck
057215140401     c                   if        %error
057216140401     C                   eval      daterr = 'Y'
057217140410     c                   else
057229140401     c                   end
057230140410     c                   end
057231140401
057232140401     C                   ENDSR
062601140401
0647011404010103 C***************************************************
0647021404010104 C* CONVERT FIELD FROM YMD to MDY or MDY to YMD     *
0647031404010105 C***************************************************
0647041404010107 C*
0647051404020107 C* DATE IN  = @DATIN (8.0)
0647061404020107 C* DATE OUT = @DATOU (8.0)
0647071404010107 C*
0647081404010106 C     #DATYM        BEGSR
064709140401     C                   MOVE      @DATIN        @MD               4 0
064710140401     C                   MOVEL     @DATIN        @Y                4 0
064711140401     C                   MOVEL     @MD           @DATOU            8 0
064712140401     C                   MOVE      @Y            @DATOU
064713140401     C                   MOVE      *ZEROS        @DATIN            8 0
0647141404010120 C                   ENDSR
064715140402
064716140402DTAQ  ******************************************************************
064717140402DTAQ  * write hist and adjust                                          *
064718140402DTAQ  ******************************************************************
064719140402DTAQ C     #hist         BEGSR
064726140514
064728140522      * find the earliest date that changed (before/after) for use as the
064729140522      * effective date in hist
064730140522
064734140522      * get earliest "from" date that changed
064735140514     c                   clear                   fromchg
064736140514     c                   if        bfratefr <> afratefr
064737140514     c                   if        bfratefr < afratefr and bfratefr <> 0
064738140514     c                   move      bfratefr      fromchg
064739140514     c                   else
064740140514     c                   move      afratefr      fromchg
064741140514     c                   end
064742140514     c                   end
064743140514
064744140522      * get earliest "to" date that changed
064745140514     c                   clear                   tochg
064746140514     c                   if        bfrateto <> afrateto
064747140514     c                   if        bfrateto < afrateto and bfrateto <> 0
064748140514     c                   move      bfrateto      tochg
064749140514     c                   else
064750140514     c                   move      afrateto      tochg
064751140514     c                   end
064752140514      * override for change to zero, need to use before date
064753140514     c                   if        tochg = 0
064754140514     c                   move      bfrateto      tochg
064755140514     c                   end
064756140514     c                   end
064757140514
064758140522      * change "to" date to 1st of the next month (cannot use last day of
064759140603      * month for hist / adjust effective date). Skip if day is already
064760140603      * 01 since this means the cancel date was changed to equal the
064761140603      * begin date (same day term).
064762140603     c                   if        tochg <> 0 and tochgdd > 01
064763140514     c                   move      01            tochgdd
064764140522     c                   move      tochg         workdtymd
064765140522     c                   adddur    1:*months     workdtymd
064766140522     c                   move      workdtymd     tochg
064767140514     c                   end
064768140514
064769140522      * final compare to determine the earliest date that changed
064770140514     c                   clear                   chgdate
064771140514     c                   move      fromchg       chgdate
064772140514     c                   if        tochg <> 0 and
064773140514     c                             (chgdate = 0 or tochg < chgdate)
064774140514     c                   move      tochg         chgdate
064775140514     c                   end
064778140514
064781140402      ***************
064782140402      * write hist
064783140402      ***************
064785140402     c                   clear                   histr
064786140502      * Before
064787140502     C                   MOVE      bfratefr      n1ratefr
064788140502     C                   MOVE      bfrateto      n1rateto
064789140502      * After
064790140502     C                   MOVE      afratefr      n2ratefr
064791140502     C                   MOVE      afrateto      n2rateto
064792140402     c                   clear                   n1deptxt
064793140402     c                   if        s1dep <> 0
064794140409     c                   movel     'D#-'         n1deptxt
064795140402     c                   move      s1dep         n1deptxt
064796140402     c                   end
064797140402
064798140402     C                   MOVE      s1ssn         HKEY
064799140502      * MSK = add
064800140502      * MSM = change
064801140502     c                   if        action = 'A'
064802140502     C                   MOVE      'MSK'         TRCODE
064803140502     c                   else
064804140402     C                   MOVE      'MSM'         TRCODE
064805140502     c                   end
064806140502
064807140402     C                   MOVE      note1out      ck#not
064808140402     C                   MOVE      note2out      note2
064809140402     C                   MOVE      'X'           TRMFLG
064810140402     C                   MOVE      'X'           TRLFLG
064811140402     C                   MOVE      'N'           DTRFLG
064812140402     C                   MOVE      s1dep         HDSEQ#
064813140402     C                   MOVEl     thispgmname   HPRGNM
064814140402     C                   MOVE      mbtrst        HSTRST
064815140402     C                   MOVE      mbsub#        HSSUB#
064816140402     C                   MOVE      mbacct        HSACCT
064817140402     C                   MOVEl     luser         HOPER
064818140402     C                   MOVE      'A'           HSDLTD
064819140514     C                   MOVE      chgdate       COVTDT
064820140522     c                   exsr      #getsystime
064822140402     C                   MOVE      sysdateymd    trdate
064823140522     c                   move      systime       hstrtime
0648251404024114 C                   write     histr                                         WRITE HIST
064826140402
064827140708     c                   clear                   henrldt
064828140708     c                   clear                   hcancdt
064830140708     c                   clear                   hplan#
064832140708     c                   clear                   hcarcod
064836140402      ***************
064837140402      * if member has any aca plans then check for adjustments needed
064838140402      ***************
064839140402     c                   if        s1dep = 0
064840140402
064841140402     c     s1ssn         setll     mcov
064842140402     c                   dou       %eof(mcov)
064843140402     c     s1ssn         reade     mcov
064844140402     c                   if        not %eof(mcov) and candt = 0
064845140402     c                   move      mcplan        keyplan
064846140402     c                   move      mcplan        a_plan
064847140402     c                   move      mcageb        a_ab
064848140402     c                   move      mcovtp        a_ct
0648491404022996 C     plankey       CHAIN     PLNMST
064850140402     c                   if        %found(plnmst)
064851141118      * if individually rated aca plan do adjust routine
064852141118      * (plnauxp still needed for group #)
064853141118     c                   clear                   acairat
0648541411182996 C     plankey       CHAIN     plnauxp
064855141118     c                   if        %found(plnauxp)
064856141120
064857141120     c                   monitor
064858141118     c                   eval      acairat = #chk_aca_plan(mbtrst:mbsub#:
064859141118     c                             keyplan)
064860141120      * trap anything that goes wrong with the check aca function
064861141120     c                   on-error
064862141120      * error handling code here
064863141120     c                   endmon
064864141120
064865141118     c                   if        acairat = 'Y'
064866140708      * hold fields for trnmit
064867140708     c                   move      pcarr         hcarcod
064868140708     c                   move      enrldt        henrldt
064869140708     c                   move      candt         hcancdt
064870140708     c                   move      mcplan        hplan#
064871140708
064872140708      * check for adjustment
064873140402     C                   EXSR      #hstadj
064874140402     c                   end
064875141118     c                   end
064876140402     c                   end
064877140402     c                   end
064878140402     c                   enddo
064879140402
064880140402     c                   else
064881140402
064882140402      * dependent transaction
064883140402     c     depkey        setll     dcovc
064884140402     c                   dou       %eof(dcovc)
064885140402     c     depkey        reade     dcovc
064886140402     c                   if        not %eof(dcovc) and ccandt = 0
064887140402     c                   move      dvplan        keyplan
064888140402     c                   move      dvplan        a_plan
064889140402     c                   move      *zeros        a_ab
064890140402     c                   move      'NA'          a_ct
0648911404022996 C     plankey       CHAIN     PLNMST
064892140402     c                   if        %found(plnmst)
064893141118      * if aca individually rated plan do adjust routine
064894141118      * (plnauxp still needed for group #)
064895141118     c                   clear                   acairat
0648961404022996 C     plankey       CHAIN     plnauxp
064897141118     c                   if        %found(plnauxp)
064898141120     c                   monitor
064899141118     c                   eval      acairat = #chk_aca_plan(mbtrst:mbsub#:
064900141118     c                             keyplan)
064901141120      * trap anything that goes wrong with the check aca function
064902141120     c                   on-error
064903141120      * error handeling code here
064904141120     c                   endmon
064905141120
064906141118     c                   if        acairat = 'Y'
064907140708      * hold fields for trnmit
064908140708     c                   move      pcarr         hcarcod
064909140708     c                   move      DENRDT        henrldt
064910140708     c                   move      CCANDT        hcancdt
064911140708     c                   move      dvplan        hplan#
064912140708
064913140402     C                   EXSR      #hstadj
064914140402     c                   end
064915141118     c                   end
064916140402     c                   end
064917140402     c                   end
064918140402     c                   enddo
064919140402
064920140402     c                   end
064921140402
0649221404020120 C                   ENDSR
064923140402
064924140402DTAQ  ******************************************************
064925140402DTAQ  *  CREATE ADJUSTMENT
064926140402DTAQ  ******************************************************
064927140402DTAQ C     #hstadj       BEGSR
064928140402
064929140402DTAQ C                   CLEAR                   WDHIST
064930140402
064931140402DTAQ C                   MOVE      hkey          Q_HKEY
064932140402DTAQ C                   MOVE      TRCODE        Q_TRCODE
064933140402DTAQ C                   MOVE      hdseq#        Q_HDSEQ#
064934140402
064935140402DTAQ C                   MOVE      adj_note1     Q_CK#NOT
064936140402
064937140402DTAQ C                   MOVEl     hprgnm        Q_HPRGNM
064938140402DTAQ C                   MOVE      HSTRST        Q_HSTRST
064939140402DTAQ C                   MOVE      HSSUB#        Q_HSSUB#
064940140402DTAQ C                   MOVE      HSACCT        Q_HSACCT
064941140402DTAQ C                   MOVEl     HOPER         Q_HOPER
064942140402DTAQ C                   MOVE      HSDLTD        Q_HSDLTD
064943140402DTAQ C                   MOVE      TRDATE        Q_TRDATE
064944140402DTAQ C                   MOVE      COVTDT        Q_COVTDT
064945140402
064946140403DTAQ C                   CALL      'TR261'
064947140403DTAQ C                   PARM                    Wdhist
064948140402
064949140707      * write trnmit rec
064950140707     c                   exsr      #trnmit
064951140707
064952140402DTAQ C                   ENDSR
064953140707
064954140707      **********************************
064955140707      * create "MD" trnmit rec for member
064956140707      **********************************
064957140707     c     #trnmit       begsr
064958140707
064959140708      * Only Coventry needs trnmit at this time
064960140707     c     pcarr         chain     carmst
064961150421     c                   if        not %found(carmst) or
064962150421     c                             (cgrpcd <> 'CH' and cgrpcd <> 'S2')
064963140707     c                   leavesr
064964140707     c                   end
064965140707
064966140707      * clear trnmit record so only certain fields get filled on write
064967140707     c                   clear                   trnmir
064968140707     c                   move      s1ssn         socsoc
064969140708     c                   move      s1dep         depseq
064970140707
064971140708     c                   move      mbtrst        trust
064972140708     c                   move      mbsub#        subno
064973140708     c                   move      mbacct        accno
064974140707
064975140708   8 C* use group # from plnauxp for all aca plans
064976140708     c                   move      pxgroup       group#
064977140708
064978140707     c                   move      hplan#        plan#
064979140707     c                   move      henrldt       enrldt
064980140707     c                   move      henrldt       oenrdt
064981140707     c                   move      hcancdt       cancdt
064982140707     c                   move      'A'           dltcod
064983140707     c                   move      hcarcod       carcod
064984140708     c                   move      'FM410'       trnsrc
064985140707      * Set defaults
064986140708     C                   eval      QQPGNM = 'FM410     '
064987140708     C                   eval      QQUSER = luser
064988140707     C                   eval      QQFIXF = 'N'
064989140707     C                   eval      QQFLAG = 'H'
064990140708
064991140708     c                   exsr      #getsystime
064992140708     C                   MOVE      sysdateymd    QQDATE
064993140708     c                   move      systime       QQTIME
064994140708     C**                 Time                    QQTIME
064995140707
064996140708      * write "MD" (member demographic change) or "DD" (Depend change)
064997140708     c                   if        s1dep = *zeros
064998140708     c                   move      'MD'          actcod
064999140708     c                   else
065000140708     c                   move      'DD'          actcod
065001140708     c                   move      depss#        ddepss
065002140708     c                   move      henrldt       denrld
065003140708     c                   move      hcancdt       dcandt
065004140708     c                   end
065005140708
065006140707     c                   write     trnmir
065007140707
065008140707     c                   endsr
065009140707
065010140402DTAQ  ******************************************************
065011140402      * Get current system time and date to be used in history record
065012140402DTAQ  ******************************************************
065013140402DTAQ c     #getsystime   begsr
065014140402
065015140402     C                   eval      sysdateymd = %date
065016140402     c                   eval      systime = %time
065017140402
065018140402DTAQ C                   ENDSR
065019140402
0650201404010107 C*
065021030521     C     *inzsr        begsr
0650220305210621 C                   MOVE      *DATE         UDATE8            8 0
065023030521     C                   ENDSR
065100140401** MESSAGES
065200140401ERROR - SUBSCRIBER NOT FOUND                                 1
065300140401ERROR - DEPENDENT NOT FOUND                                  2
065400140502                                                             3
065500140502                                                             4
065600140410RATE to date cannot be less than from date                   5
065700140410Invalid from date, use format MM/01/YYYY                     6
065800140410To date must be 0, last day of month or same as from date    7
