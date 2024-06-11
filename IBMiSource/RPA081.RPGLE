000100071127     hoption(*nodebugio)
0002009408170002 F******************************************************************
0003001311220003 F* rpa081     GROUP BENEFIT SERVICES SOFTWARE                     *
0004009408170004 F*                                                                *
0005009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006001311220006 F*            DATE - 11/22/13                                     *
0007009408170007 F*                                                                *
0008001311250008 F*  DESCRIPTION - Prompt for ar run and update arctl file. The    *
0009001311250010 F*                update can only be run once.                    *
0010001311250010 F*                                                                *
0011009408170011 F******************************************************************
0012009408170012 F*                                                                *
0013001311220013 Frpa081d   CF   E             WORKSTN
001400071127     F                                     SFILE(SF01:RRN)
0015001311260015 Farctll1   iF a E           K DISK
001600131125     FGBSECURE  IF   E           K DISK
001700051028     d workdtymd       s               d   datfmt(*iso)
0018000510260056 D  parmcancel     s              1
0019000510260056 D  error          s              1
0020001311250056 D  err1           c                   const('** THIS MONTH HAS ALREADY +
0021001311250056 D                                     BEEN UPDATED, PLEASE SELECT PRINT +
0022001311250056 D                                     ONLY **   ')
0023001311250056 D  err2           c                   const('** ERROR - THE PRIOR MONTH +
0024001311250056 D                                     HAS NOT BEEN RUN YET ***         +
0025001311250056 D                                                ')
0026001311250056 D  err3           c                   const('** WHEN UPDATE IS SELECTED +
0027001311250056 D                                     YOU MUST SELECT ALL NEW ACTIVITY +
0028001311250056 D                                     **         ')
0029001311250056 D  err4           c                   const('** THIS DATE HAS NOT BEEN +
0030001311250056 D                                     UPDATED YET, PLEASE CHOOSE NEW +
0031001311250056 D                                     ACTIVITY ** ')
0032001311260056 D  err5           c                   const('** WHEN UPDATE IS SELECTED +
0033001311260056 D                                     ACC# AND TRUST CAT MUST NOT BE +
0034001311260056 D                                     SELECTED **')
0035000510260055 D                 DS
0036001311250056 D  seffdt                 1      8s 0
0037001311250056 D  seffm                  1      2s 0
0038001311250056 D  seffd                  3      4s 0
0039001311250056 D  seffy                  5      8s 0
0040000510260055 D                uDS
0041001311250056 D  leffymd                1      8
0042001311250056 D  lupdate                9      9
0043001311250056 D  lreprint              10     10
0044001311260056 D  ltrust                11     13
0045001311260056 D  lsub                  14     16
0046001311260056 D  lacct                 17     20
0047001311260056 D  ltcat1                21     21
0048001311260056 D  ltcat2                22     22
0049001311260056 D  ltcat3                23     23
0050001311260056 D  ltcat4                24     24
0051001311260056 D  ltcat5                25     25
0052001311260056 D  ltcat6                26     26
0053001311260056 D  ltcat7                27     27
0054001311260056 D  ltcat8                28     28
0055001311260056 D  ltcat9                29     29
0056001311260056 D  ltcat10               30     30
0057000510260601 D  CONAME               201    240
0058000510260601 D  luser               1000   1009
005900020702
006000131125     c                   clear                   seffdt
006100131126      * set screen default values
006200131126     c                   eval      sreprint = 'N'
006300131125     c                   eval      supdate  = 'N'
006400131126     c                   eval      strust   = 'ALL'
006500131126     c                   eval      ssub     = 'ALL'
006600131126     c                   eval      sacct    = 'ALL '
006700051026
006800051026     c                   dou       *inlr = *on
006900051026     C                   exfmt     scrn01
007000051026
007100051026      * f7 - cancel
007200051026     c                   if        *in07 = *on
007300051026     c                   move      'Y'           parmcancel
007400051026     c                   goto      #end
007500051026     c                   end
007600051026
007700051026      * clear errors
007800051026     c                   clear                   error
007900051026     c                   clear                   errortxt
008000051026     c                   eval      *in21 = *off
008100071127     c                   eval      *in22 = *off
008200071127     c                   eval      *in23 = *off
008300051026     c                   eval      *in92 = *off
008400131125
0085001311250076 C*
0086001311250077 C*  ON CMD 5 DISPLAY SUBFILE OF ar history
0087001311250078 C*
0088001311250079 C                   if        *inke = *on
0089001311250080 C                   EXSR      #DSPhist
0090001311250080 C                   iter
009100131125     C                   END
009200051026
009300051026      * edits
009400131125     c                   if        seffm < 1 or seffm > 12 or seffd <> 1 or
009500151104     c                             seffy < 2015
009600051026     c                   eval      *in21 = *on
009700051026     c                   eval      error = 'Y'
009800051026     c                   iter
009900051026     c                   end
010000071127
010100131125     c                   move      seffdt        @datin
010200071127     c                   exsr      #datym
010300131125     c                   move      @datou        seffymd           8 0
010301151119
010400151119      *******************************************************************
010500160302      * Do not allow run for conversion date (2/16) or prior because the
010501151119      * conversion date detail will contain every history rec (inv, payment
010502151119      * etc.) up to the conversion and this amounts to millions of records.
010503151119      *
010600160302      * The live conversion is for AR effective 02/2016 run on 3/5/16
010601160302      * so I will have to manually enter a 02/16 ARCTL record showing the
010602151119      * conversion so the edits work going forward.
010605151119      *******************************************************************
010702160302     c                   if        seffymd < 20160301
010800131125     c                   eval      *in21 = *on
010900131125     c                   eval      error = 'Y'
011000131125     c                   iter
011100131125     c                   end
011200071127
011300131125      * reprint?
011400131125     c                   if        sreprint <> 'R' and sreprint <> 'N'
011500131125     c                   eval      *in22 = *on
011600131125     c                   eval      error = 'Y'
011700131125     c                   iter
011800131125     c                   end
011900131125
012000131125      * update ?
012100131125     c                   if        supdate <> 'Y' and supdate <> 'N'
012200131125     c                   eval      *in23 = *on
012300131125     c                   eval      error = 'Y'
012400131125     c                   iter
012500131125     c                   end
012600131125
012700131126      * when update is selected, all new activity must also be selected
012800131125     c                   if        supdate = 'Y' and sreprint <> 'N'
012900131125     c                   eval      errortxt = err3
013000131125     c                   eval      error = 'Y'
013100131125     c                   iter
013200131125     c                   end
013300131125
013400131122      * has this month already been run?
013500131126     C     seffymd       CHAIN     arctll1
013600131126     c                   if        %found(arctll1)
013700131125     c                   if        supdate = 'Y'
013800051027     c                   eval      errortxt = err1
013900051027     c                   eval      error    = 'Y'
014000071127     c                   iter
014100131125     c                   end
014200131125      * this month has not been run, reprint not allowed
014300131125     c                   else
014400131125     c                   if        sreprint <> 'N'
014500131125     c                   eval      errortxt = err4
014600131125     c                   eval      error    = 'Y'
014700131125     c                   end
014800131125     c                   end
014900071128
015000131125      * prior month must have been run (cannot skip a month)
015100131125     c                   move      seffymd       workdtymd
015200071128     c                   subdur    1:*m          workdtymd
015300071128     c                   move      workdtymd     effymdminus1      8 0
015400071128
015500131126     C     effymdminus1  chain     arctll1
015600131126     c                   if        not %found(arctll1)
015700131125     c                   eval      errortxt = err2
015800071128     c                   eval      error    = 'Y'
0159000711280080 C                   iter
016000071128     c                   end
016100131126
016200131126      * if update Y is selected, acc# and trust cat are not valid
016300131126     c                   if        supdate = 'Y' and
016400131126     c                             (strust <> 'ALL'  or ssub <> 'ALL' or
016500131126     c                              sacct  <> 'ALL ' or stcat1 <> ' ' or
016600131126     c                              stcat2 <> ' '    or stcat3 <> ' ' or
016700131126     c                              stcat4 <> ' '    or stcat5 <> ' ' or
016800131126     c                              stcat6 <> ' '    or stcat7 <> ' ' or
016900131126     c                              stcat8 <> ' '    or stcat9 <> ' ' or
017000131126     c                              stcat10 <> ' ')
017100131126     c                   eval      errortxt = err5
017200131126     c                   eval      error    = 'Y'
0173001311260080 C                   iter
017400131126     c                   end
017500131126
017600051027      * if no errors display F2 - submit (92 = unhide text)
017700051027     c                   if        error = *blank
017800051026     c                   eval      *in92 = *on
017900051026     c                   end
018000051026
018100071127      * if no errors and user pressed F2- fill lda, write and continue
018200131125     c                   if        error = *blank and *in02
018300131125     c                   move      seffymd       leffymd
018400131125     c                   move      supdate       lupdate
018500131125     c                   move      sreprint      lreprint
018600131126     c                   move      strust        ltrust
018700131126     c                   move      ssub          lsub
018800131126     c                   move      sacct         lacct
018900131126     c                   move      stcat1        ltcat1
019000131126     c                   move      stcat2        ltcat2
019100131126     c                   move      stcat3        ltcat3
019200131126     c                   move      stcat4        ltcat4
019300131126     c                   move      stcat5        ltcat5
019400131126     c                   move      stcat6        ltcat6
019500131126     c                   move      stcat7        ltcat7
019600131126     c                   move      stcat8        ltcat8
019700131126     c                   move      stcat9        ltcat9
019800131126     c                   move      stcat10       ltcat10
019900051026
020000051026     c                   move      *date         @datin
020100051026     c                   exsr      #datym
020200051026     c                   move      @datou        udymd             8 0
020300051026
020400131125      * update
020500131125     c                   if        supdate = 'Y'
020600131122     c                   clear                   arctlr
020700131125     c                   move      seffymd       ARCEFFDAT
020800131125     c                   move      udymd         ARCRUNDAT
020900131125     c                   time                    ARCRUNTIM
021000131125     c                   movel     luser         ARCRUNUSR
021100131122     c                   write     arctlr
021200131125     c                   end
021300131125
021400051026     c                   leave
021500051026     c                   end
021600051026
021700020702     c                   enddo
021800051026
021900051026     c     #end          tag
022000051026
022100020703     c                   eval      *inlr = *on
022200071127
0223000510280103 C***************
0224000510280104 C* flip dates
0225000510280103 C***************
0226000510280106 C     #flipdates    BEGSR
022700051028
022800131122     c                   move      ARCRUNDAT     @datin
022900051028     c                   exsr      #datym
023000131125     c                   move      @datou        arrunmdy
023100051028
023200131125     c                   move      ARCEFFDAT     @datin
023300131125     c                   exsr      #datym
023400131125     c                   move      @datou        ardtmdy
023500131125
023600131125      * format time field on screen
023700131125     c                   move      arcruntim     arcruntimo
023800131125      * user on screen
023900131125     c                   clear                   userout
024000131125     C     arcrunusr     CHAIN     GBSECURE
024100131125     c                   if        %found(gbsecure)
024200131125     c                   movel     scname        userout
024300131206     c                   else
024400131206     c                   movel     arcrunusr     userout
024500131125     c                   end
024600131125
0247000510280120 C                   ENDSR
024800071127     C************************************
024900131125     C* DISPLAY arctl in SUBFILE WINDOW  *
025000071127     C************************************
025100071127     C     #DSPhist      BEGSR
025200071127     C*
025300071127     C* CLEAR SUBFILE
025400071127     C*
025500071127     C                   MOVEA     '001'         *IN(90)
025600071127     C                   WRITE     SF01CTL
025700071127     C                   MOVE      '0'           *IN92
025800071127     C*
025900071127     C* BUILD SUBFILE
026000071127     C*
026100071127     C                   clear                   RRN               5 0
026200131126     C* arctll1 is in descending order by effective date
026300131126     C     *hival        SETLL     arctll1
026400131126     C                   dou       %eof(arctll1)
026500131126     C                   READ      arctll1                                91
026600071127     C                   if        *in91 = *off
026700071127     c                   exsr      #flipdates
026800071127     C                   ADD       1             RRN
026900071127     C                   WRITE     SF01
027000071127     C                   END
027100071127     C                   enddo
027200071127     C*
027300071127     C* DISPLAY SUBFILE IN WINDOW
027400071127     C* if no rec found, display not found msg
027500071127     C                   if        rrn = 0
027600071127     c                   clear                   sf01
027700131125     c                   eval      userout = 'NOT FOUND'
027800071127     c                   add       1             rrn
027900071127     c                   write     sf01
028000071127     C                   end
028100071127
028200071127     C                   eval      *in90 = *on
028300071127     C*
028400071127     C                   WRITE     WINDOW
028500071127     C                   EXFMT     SF01CTL
028600071127     C*
028700071127     C                   ENDSR
028800051026
0289000510260103 C***************************************************
0290000510260104 C* CONVERT FIELD FROM YMD TO MDY or MDY TO YMD
0291000510260105 C***************************************************
0292000510260106 C     #DATYM        BEGSR
029300051026     C                   MOVE      @DATIN        @MD               4 0
029400051026     C                   MOVEL     @DATIN        @Y                4 0
029500051026     C                   MOVEL     @MD           @DATOU            8 0
029600051026     C                   MOVE      @Y            @DATOU
029700051026     C                   MOVE      *ZEROS        @DATIN            8 0
0298000510260120 C                   ENDSR
029900051026
030000020703
030100020701     C     *inzsr        BEGSR
030200051026     c     *ENTRY        plist
030300051026     C                   parm                    parmcancel
030400071127
030500020701     C                   ENDSR
