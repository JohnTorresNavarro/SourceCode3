000100140312     H option(*nodebugio) alwnull(*usrctl) debug
000200150323     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000300991124     F*-------------------------------------------------------------------------
000400150415     F* REFPLNR    GBS SOFTWARE 2015
000500081111     F*            WRITTEN BY - RLJ
000600150415     F*            DATE - 04/2015
000700150415     F*  DESCRIPTION - Build Refernce Plan data
000800150304     F*
000900991124     F*-------------------------------------------------------------------------
001000991209     ** MODIFICATION HISTORY                                              **
001100190129     ** RLJ 01/29/2019 - Per CF allow more than 1 ref plan per TSA
001200991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001300150304     FACCMST    IF   E           K DISK
001400150415     FCOMCTUNIQ IF   E           K DISK
001500150415     FPLNMST    IF   E           K DISK
001600150416     FPLNAUXP   IF   E           K DISK
001700150415     FCODES     IF   E           K DISK
001800150421     FPAYDED    IF   E           K Disk
001900150421     FGRAT25    IF   E           K Disk
002000150422     FPDREFPLP  UF A E           K Disk
002100150415     FREFPLND   CF   E             WORKSTN
002200150415     F                                     SFILE(DETAIL:RRN)
002300150421    * *
002400150421     D WDTA          E DS                  extname(PAYDED)
002500141222   X* *
002600141222     D                UDS
002700141222     D  @USER                100    107
002800141222     D  CONAME               201    240
0029001501200056 D  lprefix              241    241
003000150331    * *
003100150331     D DS@BASE       E DS                  EXTNAME(PLNMST)
003200150402      *
003300150402     D                 DS
003400150415     D hldcat                  1      3
003500150415     D  kcod1                  1      1
003600150415     D  kcod2                  2      3
003700150317      *
003800150317     D @TIMESTAMP      DS
003900150317     D  #TSCYMD                1      8S 0
004000150317     D  #TSTIME                9     14S 0
004100150317     D  @TSJOB                15     24
004200141222     D  @TSUSER               25     34
004300141222     D  #TSNBR                35     40S 0
004400141222    * *
004500150415     D                 DS
004600150421     D @TS40           S             40A
004700140106     D kycarpln        S            150A
004800140106     D addflg          S              1A   INZ('N')
004900150506     D exitp           S              1A   INZ('N')
0050001504150251 D todadd          S               D   DATFMT(*ISO)
005100150415     D todaa           S              8  0
005200150416     D wkZat           S               D
0053001311110037 D wkdat1          S               D   datfmt(*iso)
0054001501120037 D sysdateymd      S               D   datfmt(*iso)
005500150120     D usadt           S               D   DATFMT(*USA/)
005600150415     D svplan          S                   LIKE(cmplan)
005700150204      *
005800150204     D                 DS
005900150112     D  datmdy                 1      8  0
006000150112     D   mdymmdd               1      4  0
006100150107     D   mdyyyyy               5      8  0
006200150107      *
006300150107     D                 DS
006400150115     D  datymd                 1      8  0
006500150115     D   ymdyyyy               1      4  0
006600150115     D   ymdmmdd               5      8  0
006700081111      *
0068001304230053 D                 DS
0069001304230054 D  invpln         C                   'INVALID TRUST/SUB#/PLAN     '
0070001304230054 D  invacc         C                   'INVALID TRUST/SUB#/ACCOUNT  '
0071001504220054 D  accdup         C                   'Reference Plan already exists for A-
0072001504220054 D                                     ccount'
0073001504160054 D  invsel         C                   'Select must be 8 or 9 only'
007400130426    * *
007500130426     C     keytsa        KLIST
007600150415     C                   KFLD                    rptrst
007700150415     C                   KFLD                    rpsub#
007800150415     C                   KFLD                    rpacct
007900150415    * *
008000150415     C     keypln        KLIST
008100150415     C                   KFLD                    cmtrst
008200150415     C                   KFLD                    csubdv
008300150415     C                   KFLD                    cmplan
008400150415    * *
008500150421     C     keyplx        KLIST
008600150421     C                   KFLD                    rptrst
008700150421     C                   KFLD                    rpsub#
008800150421     C                   KFLD                    dsplan
008900150421    * *
009000150421     C     keygrt        KLIST
009100150421     C                   KFLD                    rptrst
009200150421     C                   KFLD                    rpsub#
009300150421     C                   KFLD                    dsplan
009400150421     C                   KFLD                    dat9              8 0
009500150421    * *
009600150415     C     keycod        KLIST
009700150415     C                   KFLD                    kcod1
009800150415     C                   KFLD                    kcod2
009900130426    * *
010000130423      * MAINLINE
010100130423    * *
010200991124     C                   EXSR      ONCE
010300141217      *
010400141217     C                   MOVEL     CONAME        TITLE
010500141218     C                   eval      *in51 = '0'
010600141217      *
010700150109     C                   DOU       *in07 = '1'
010800141217      *
010900141217     C                   exfmt     io01
011000141217      *      Command Keys?
011100141217     C                   if        *in07 = '1'
011200141217     C                   leave
011300141217     C                   endif
011400141218      *
011500141218     C                   eval      smsg = *blanks
011600141218     C                   eval      *in81 = '0'
011700141218      *         Check for valid TSA
011800141218     C                   eval      *in51 = '0'
011900141218     C     keytsa        chain     accmst                             21
012000141218     C                   if        *in21 = '1'
012100141218     C                   movel(P)  invacc        smsg
012200141218     C                   eval      *in51 = '1'
012300141218     C                   eval      *in81 = '1'
012400141218     C                   iter
012500141218     C                   endif
012600150422      *         Check for to see if Ref Plan exists for TSA
012700190129     C****               eval      *in51 = '0'
012800190129     C*    keytsa        chain     pdrefplp                           21
012900190129     C*                  if        *in21 = '0'
013000190129     C*                  movel(P)  accdup        smsg
013100190129     C*                  eval      *in51 = '1'
013200190129     C*                  eval      *in81 = '1'
013300190129     C*                  iter
013400190129     C****               endif
013500150422      *
013600150323      *     All Edits have passed - Process data
013700150323      *
013800150424     C                   eval      *in12 = '0'
013900150424     C                   eval      *in03 = '0'
014000150415     C                   exsr      bldpsf                                   '
014100150306      *
014200150109     C                   enddo
014300130423      *
014400081119     C                   MOVE      *ON           *INLR
014500081119     C                   RETURN
014600141218      ******************************************************************
014700150415      *       SUBROUTINE - BLDPSF                                      *
014800150415      *              Build Subfile of Plans for TSA                    *
014900141218      ******************************************************************
015000150415     C     BLDPSF        BEGSR
015100141218    * *
015200150506     C                   eval      exitp = 'N'
015300150415     C     *IN03         DOWEQ     *OFF
015400150415     C     *IN12         ANDEQ     *OFF
015500150415      *      RELOAD IF CLIENT SEARCH CHANGES
015600150415     C                   EXSR      $CLEAR
015700150415     C                   EXSR      $LOAD
015800150415     C                   EXSR      $DISPLAY
015900150415     C                   setoff                                       88
016000150415      *    PROCESS SELECTION
016100150415     C     *IN03         IFEQ      *OFF
016200150415     C     *IN12         ANDEQ     *OFF
016300150415     C***  RRN           ANDNE     *ZERO
016400150415     C                   EXSR      $PROCES
016500150506     C                   if        exitp = 'Y'
016600150506     C                   leavesr
016700150506     C                   endif
016800150415      *
016900150506     C                   ENDIF
017000150506      *
017100150415     C                   enddo
017200150415      *
017300150415     C                   endsr
017400150415      ******************************************************************
017500150415      *       SUBROUTINE - $CLEAR                                      *
017600150415      *                    CLEAR SUBF AND RRN                          *
017700150415      ******************************************************************
017800150415     C     $CLEAR        BEGSR
017900150415     C                   MOVEA     '001'         *IN(31)
018000150415     C                   wRITE     HEADER
018100150415     C                   Z-ADD     *ZERO         RRN               4 0
018200150415     C                   WRITE     HEADER
018300150415     C                   MOVEA     '010'         *IN(31)
018400150415     C                   ENDSR
018500150415      ******************************************************************
018600150415      *       SUBROUTINE - $LOAD                                       *
018700150415      *                    LOAD SUBFILE W/ Plan Info                   *
018800150415      ******************************************************************
018900150415     C     $LOAD         BEGSR
019000150415     C                   SETOFF                                       3495
019100150415     C                   eval      radesc = acnam1
019200150415     C                   eval      svplan = *blanks
019300150415     C                   eval      rrn = 0
019400150415     C     keytsa        setll     comctuniq                          34
019500150415     C     *IN34         DOUEQ     *ON
019600150415     C     *IN95         OREQ      *ON
019700150415     C     keytsa        reade     comctuniq                              34
019800150415     C                   if        *in34 = '1' or rpacct <> cmacct
019900150415     C                   leave
020000150415     C                   endif
020100150415      *
020200150415     C                   if        cmcan <> 0 and cmcan < todaa
020300150415     C                   iter
020400150415     C                   endif
020500150415      *
020600150415     C                   if        cmplan = svplan
020700150415     C                   iter
020800150415     C                   endif
020900150415      *
021000150415     C                   eval      svplan = cmplan
021100150415      *
021200150415     C     keypln        chain     plnmst                             21
021300150415     C                   if        *in21 = '0'
021400150415     C                   eval      hldcat = plncat
021500150415      *
021600150415     C     keycod        chain     codes                              22
021700150415     C                   if        *in22 = '0' and action = 'M'
021800150415     C                   eval      dsplan = plplan
021900150415     C                   eval      dsdesc = pdescr
022000150415     C                   eval      dscarr = pcarr
022100150415     C                   eval      dspcat = plncat
022200150415     C                   eval      rrn = rrn + 1
022300150415     C                   write     detail
022400150415     C                   endif
022500150415      *
022600150415     C                   endif
022700150415      *
022800150415     C                   enddo
022900150415     C                   ENDSR
023000150415      ******************************************************************
023100150415      *       SUBROUTINE - $DISPLAY                                    *
023200150415      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
023300150415      ******************************************************************
023400150415     C     $DISPLAY      BEGSR
023500150415     C                   If        RRN <> *Zero
023600150415     C                   MOVE      *ON           *IN31
023700150415     C                   ENDIF
023800150415     C                   WRITE     TRAILER
023900150415     C                   EXFMT     HEADER
024000150415     C                   ENDSR
024100150415      ******************************************************************
024200150415      *       SUBROUTINE - $PROCES                                     *
024300150415      *                    PROCESS THE SELECTION                       *
024400150415      ******************************************************************
024500150415     C     $PROCES       BEGSR
024600150415     C     *IN95         DOUEQ     *ON
024700150415      *
024800150415     C                   READC     DETAIL                                 95
024900150415     C                   IF        *IN95 = *OFF
025000150416     C                   IF        SELECT <> '8' and select <> '9'
025100150416     C                   movel(P)  invsel        xmsg
025200150416     C                   eval      *in81 = '1'
025300150416     C                   iter
025400150416     C                   endif
025500150416      *
025600150421     C                   exsr      $bldref
025700150415      *
025800150415     C                   CLEAR                   SELECT
025900150415     C                   UPDATE    DETAIL
026000150506      *       Do not redisplay subfile
026100150506     C                   leavesr
026200150506     C                   ENDIF
026300150415     C                   ENDDO
026400150415     C                   ENDSR
026500150316      ******************************************************************
026600150421      *       SUBROUTINE - $BLDREF                                     *
026700150421      *                    Build Reference Plan - Call WRKPRDCL        *
026800150109      ******************************************************************
026900150316    * *
027000150421     C     $BLDREF       BEGSR
027100150316    * *
027200150421     C                   eval      dat9 = 99999999
027300150421     C     keygrt        setll     grat25
027400150421    2C                   read      grat25                                 23
027500150421     C                   If        *in23 = '0' and dsplan = grplan
027600150421    * *
027700150421     C                   Eval      PDTRST   =    rptrst
027800150421     C                   Eval      PDSUB#   =    rpsub#
027900150421     C                   Eval      PDPLAN   =    dsplan
028000150421     C                   Eval      PDCVTP   =    'TIN'
028100150421     C                   Eval      PDBEDT   =    frmdat
028200150421     C                   Eval      PDENDT   =    todat
028300150421    1C                   If        select = '8'
028400150421     C                   Eval      WIFKEY = 'F8'
028500150421    1C                   else
028600150421    1C                   If        select = '9'
028700150421     C                   Eval      WIFKEY = 'F9'
028800150421    1C                   endif
028900150421    1C                   endif
029000150421    * *
029100150421     C     keyplx        chain     plnauxp
029200150421     C                   If        %found(plnauxp)
029300150421     C                   select
029400150421    1C                   when      select = '8'
029500150421     C                   if        pxacar = 'Y' or pxacar = 'D' or
029600150421     C                             pxacar = 'C'
029700150421     C                   eval      wiSTFLG = 'T'
029800150421     C                   else
029900150421     C                   eval      wiSTFLG = ' '
030000150421     C                   endif
030100150421    1C                   when      select = '9'
030200150421     C                   if        PXEXCHG = 'Y' or
030300150421     C                             pxacar = 'Y'  or pxacar = 'D' or
030400150421     C                             pxacar = 'C'
030500150421     C                   eval      wiSTFLG = 'S'
030600150421     C                   endif
030700150421     C                   endsl
030800150421     C                   endif
030900150421    * *
031000150421     C                   Call      'WRKPRDCL'
031100150421     C                   Parm                    WDTA
031200150421     C                   Parm                    WIFKEY            2
031300150421     C                   Parm                    WISTFLG           1
031400150421      *         Create Payroll Deduct Ref Plan rec
031500150421     C                   clear                   pdrefplr
031600150421     C                   eval      prtrst = rptrst
031700150421     C                   eval      prsub# = rpsub#
031800150421     C                   eval      pracct = rpacct
031900150421     C                   eval      prplan = dsplan
032000150421    1C                   if        select = '8'
032100150421     C                   eval      prtype = 'D'
032200150421    1C                   else
032300150421     C                   eval      prtype = 'P'
032400150421    1C                   endif
032500150421     C                   eval      prefdt = frmdat
032600150421     C                   eval      prterm = todat
032700150421     C                   CLEAR                   @TIMESTAMP
032800150421     C                   MOVE      *BLANKS       @TS40
032900150421     C                   CALL      'TIMESTMP'
033000150421     C                   PARM                    @TS40
033100150421     C                   MOVEL     @TS40         @TIMESTAMP
033200150423     C                   movel     @TSUSER       pruser
033300150421     C                   MOVE      #TSCYMD       prdate
033400150421     C                   MOVE      #TSTIME       prtime
033500150421     C                   write     pdrefplr
033600150506     C                   eval      exitp = 'Y'
033700150415    * *
033800150506    * *     Call process to copy ref plan deductions to other plans
033900150506     C                   movel     pracct        cracct
034000150506     C                   Call      'CRTDEDR'
034100150506     C                   Parm                    WDTA
034200150506     C                   Parm                    CRACCT            4
034300150506    * *
034400150421     C                   endif
034500150421    * *
034600150421     C                   ENDSR
034700150421      ******************************************************************
034800150421      *                    House Keeping                               *
034900150421      ******************************************************************
035000150421    * *
035100150421     C     ONCE          BEGSR
035200150421    * *
035300150421     C                   MOVEL     CONAME        TITLE
035400150421     C                   MOVE      '0'           @EXIT             1
035500150421    * *
0356001504210297 C                   movel     UDATE         todadd
0357001504210297 C                   movel     todadd        todaa
035800150421    * *
035900150421     C                   ENDSR
