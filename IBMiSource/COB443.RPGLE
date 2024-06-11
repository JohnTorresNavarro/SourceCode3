000100120605   X***X SUBSCRIBER INITIAL NOTICE APPLICATION
000200120605   X***X GROUP LETTER REPRINTING PROGRAM
000300120605   X***X SSK  06/05/2012
000400120605   X***X
000500131007   X***X 10/04/2013 SSK HIST EXPANSION PROJECT
000600120605   X***X
000700120605   X***X
000800180626   X* *  06/26/2018 DLK - add overlay to first page and remove ssn
000900210729   X* *  07/29/2021 DLK - rebrand to Amwins, update letter, change printer
001000210729   X* *                   file name
001100211005   X* *  10/05/2021 DLK - add Waived employment status members (Shelly
001200211005   X* *                   request)
001300211005   X* *
001400120605     FCOB443D   CF   E             WORKSTN INFDS(WSDS)
001500120605     FCOB440W1  IF A E           K DISK
001600120605     FCOB440W2  IF   E           K DISK
001700120605     FACMUNIQUE IF   E           K DISK
001800120605     FMEMAC#3   IF   E           K DISK
001900120605     FMCOV      IF   E           K DISK
002000120605     FHIST      O  A E             DISK
002100210729     fcob441p   O    E             PRINTER
002200120605    ***
002300120605     D WSDS            DS
002400120605     D  FKEY                 369    369A
002500120605    ***
002600120605     D  F1             C                   CONST(X'31')
002700120605     D  F2             C                   CONST(X'32')
002800120605     D  F3             C                   CONST(X'33')
002900120605     D  F4             C                   CONST(X'34')
003000120605     D  F5             C                   CONST(X'35')
003100120605     D  F6             C                   CONST(X'36')
003200120605     D  F7             C                   CONST(X'37')
003300120605     D  F8             C                   CONST(X'38')
003400120605     D  F9             C                   CONST(X'39')
003500120605     D  F10            C                   CONST(X'3A')
003600120605     D  F11            C                   CONST(X'3B')
003700120605     D  F12            C                   CONST(X'3C')
003800120605     D  F13            C                   CONST(X'B1')
003900120605     D  F14            C                   CONST(X'B2')
004000120605     D  F15            C                   CONST(X'B3')
004100120605     D  F16            C                   CONST(X'B4')
004200120605     D  F17            C                   CONST(X'B5')
004300120605     D  F18            C                   CONST(X'B6')
004400120605     D  F19            C                   CONST(X'B7')
004500120605     D  F20            C                   CONST(X'B8')
004600120605     D  F21            C                   CONST(X'B9')
004700120605     D  F22            C                   CONST(X'BA')
004800120605     D  F23            C                   CONST(X'BB')
004900120605     D  F24            C                   CONST(X'BC')
005000120605    ***
005100120605     D @EMSG           S             70A
005200120605     D #USA            S               D   DATFMT(*USA)
005300120605     D #ISO            S               D   DATFMT(*ISO)
005400120605     D #TISO           S              8S 0
005500120605     D RUN#DATE        S              8S 0
005600120605    ***
005700120605     D @TIMESTAMP      DS
005800120605     D  #TSCYMD                1      8S 0
005900120605     D  #TSTIME                9     14S 0
006000120605     D  @TSJOB                15     24
006100120605     D  @TSUSER               25     34
006200120605     D  #TSNBR                35     40S 0
006300120605    * *
006400120605     D @TS40           S             40A
006500120605    ***
0066001310070037 D sysdateymd      S               d   datfmt(*iso)
006700210729     D thispgmname     S             10a   inz('COB443    ')
006800131007    ***
006900120605     D YES             S               N   INZ(*ON)
007000120605     D NO              S               N   INZ(*OFF)
007100120605     D VALID_MBR       S               N
007200120605     D VALID_PLN       S               N
007300120605    ***
007400120605   X***X
007500120605     d @9              s              9a
007600120605     d Z5              s              5a
007700120605     d #TDAY           s              8S 0
007800120605     d @TDAY           s             10a
007900120605    ***
008000120605     D P1DATE          S             50A
008100120605     D P1NAME          S             50A
008200120605     D P1ADDR          S             50A
008300120605     D P1ADD2          S             50A
008400120605     D P1CSZ           S             50A
008500120605    ? * Program status data structure
008600120605    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
008700120605   X***X
008800120605    ***
008900180626     c     *entry        plist
009000180626     c                   parm                    parm1let          1
009100180626
009200120605     C     KL#TSAS       KLIST
009300120605     C                   KFLD                    SCTRST
009400120605     C                   KFLD                    SCSUB#
009500120605     C                   KFLD                    SCACCT
009600120605     C                   KFLD                    SLSSNO
009700120605    ***
009800120605     C     KL#TSA        KLIST
009900120605     C                   KFLD                    SCTRST
010000120605     C                   KFLD                    SCSUB#
010100120605     C                   KFLD                    SCACCT
010200120605    ***
010300120605     C                   MOVEL(P)  'INITIALIZE'  @PROC            10
010400120605    ***
010500120605     C                   DOU       @PROC = 'LEAVE LOOP'
010600120605     C     @PROC         CASEQ     'INITIALIZE'  $INITIAL
010700120605     C     @PROC         CASEQ     'SCREEN ONE'  $SCREEN1
010800120605     C     @PROC         CASEQ     'FORMAT SCR'  $FMTSCRN
010900120605     C     @PROC         CASEQ     'SCREEN TWO'  $SCREEN2
011000120605     C     @PROC         CASEQ     'REPRT EXTR'  $REPRINT
011100120605     C     @PROC         CASEQ     'PRINT LETR'  $PRINT
011200120605     C                   ENDCS
011300120605     C                   ENDDO
011400120605    ***
011500120605     C                   EVAL      *INLR = *ON
011600120605    ***
011700120605   S***S
011800120605     C     $INITIAL      BEGSR
011900120605    ***
012000120605     C                   CLEAR                   SCREEN
012100120605     C                   EVAL      *IN25 = *OFF
012200120605     C                   EVAL      SCHIST = 'Y'
012300120605     C                   EVAL      RUN#DATE = 0
012400120605     C                   EVAL      #ISO = %DATE
012500120605     C                   MOVE      #ISO          #TISO
012600120605     C                   EVAL      #USA = %DATE
012700120605     C                   MOVE      #USA          SCDATE
012800120605     C                   MOVE      #USA          #TDAY
012900120605     C                   EVAL      @PROC = 'SCREEN ONE'
013000120605    ***
013100120605     C                   ENDSR
013200120605   S***S
013300120605     C     $SCREEN1      BEGSR
013400120605    ***
013500120605     C                   EVAL      EMSG = @EMSG
013600120605     C                   EXFMT     SCREEN
013700120605     C                   EVAL      @EMSG = *BLANKS
013800120605    ***
013900120605     C                   IF        FKEY = F3
014000120605     C                   EVAL      @PROC = 'LEAVE LOOP'
014100120605     C                   LEAVESR
014200120605     C                   ENDIF
014300120605    ***
014400120605     C                   IF        SCDATE = 0
014500120605     C                   EVAL      @EMSG = 'INVALID DATE'
014600120605     C                   LEAVESR
014700120605     C                   ENDIF
014800120605    ***
014900120605     C     *USA          TEST(DE)                SCDATE
015000120605     C                   IF        %ERROR
015100120605     C                   EVAL      @EMSG = 'INVALID DATE'
015200120605     C                   LEAVESR
015300120605     C                   ENDIF
015400120605    ***
015500120605     C                   MOVE      SCDATE        #USA
015600120605     C                   MOVE      #USA          #ISO
015700120605     C                   MOVE      #ISO          RUN#DATE
015800120605    ***
015900120605     C                   IF        SCHIST <> 'Y' AND SCHIST <> 'N'
016000120605     C                   EVAL      @EMSG = 'INVALID HIST NOTE'
016100120605     C                   LEAVESR
016200120605     C                   ENDIF
016300120605    ***
016400120605     C     KL#TSA        CHAIN     ACCMSR
016500120605     C                   IF        NOT %FOUND(ACMUNIQUE)
016600120605     C                   EVAL      @EMSG = 'ACCOUNT DOES NOT EXIST'
016700120605     C                   LEAVESR
016800120605     C                   ENDIF
016900120605     C                   EVAL      D_ACCT = %TRIM(ACNAM1)
017000120605    ***
017100120605     C     KL#TSA        CHAIN     C2F
017200120605     C                   IF        NOT %FOUND(COB440W2)
017300120605     C                   EVAL      @EMSG = 'ACCOUNT NOT SET UP FOR LETTER'
017400120605     C                   LEAVESR
017500120605     C                   ENDIF
017600120605    ***
017700120605     C                   EVAL      @PROC = 'FORMAT SCR'
017800120605    ***
017900120605     C                   ENDSR
018000120605   S***S
018100120605     C     $FMTSCRN      BEGSR
018200120605    ***
018300120605     C                   EVAL      *IN25 = *ON
018400120605    ***
018500120605    ***
018600120605     C                   EVAL      SCRE = %TRIM(C2REMK)
018700120605    ***
018800120605     C                   EVAL      @PROC = 'SCREEN TWO'
018900120605    ***
019000120605     C                   ENDSR
019100120605   S***S
019200120605     C     $SCREEN2      BEGSR
019300120605    ***
019400120605     C                   EVAL      EMSG = @EMSG
019500120605     C                   EXFMT     SCREEN
019600120605     C                   EVAL      @EMSG = *BLANKS
019700120605    ***
019800120605     C                   IF        FKEY = F12
019900120605     C                   EVAL      @PROC = 'INITIALIZE'
020000120605     C                   LEAVESR
020100120605     C                   ENDIF
020200120605    ***
020300120605     C                   IF        FKEY = F5
020400120605     C                   EVAL      @PROC = 'FORMAT SCR'
020500120605     C                   LEAVESR
020600120605     C                   ENDIF
020700120605    ***
020800120605     C                   IF        FKEY = F10
020900120605     C                   EXSR      $VALID2
021000120605     C                   IF        @VALID = 'YES'
021100120605     C                   EVAL      @PROC = 'REPRT EXTR'
021200120606     C     KL#TSA        SETLL     MEMBR
021300120605     C                   ENDIF
021400120605     C                   LEAVESR
021500120605     C                   ENDIF
021600120605    ***
021700120605     C                   EXSR      $VALID2
021800120605    ***
021900120605     C                   ENDSR
022000120605   S***S
022100120605     C     $VALID2       BEGSR
022200120605    ***
022300120605     C                   MOVEL(P)  'NO'          @VALID            3
022400120605    ***
022500120605     C                   IF        SCRE = *BLANKS
022600120605     C                   EVAL      @EMSG = 'REGARDING REQUIRED'
022700120605     C                   LEAVESR
022800120605     C                   ENDIF
022900120605    ***
023000120605     C                   EVAL      @VALID = 'YES'
023100120605    ***
023200120605     C                   ENDSR
023300120605   S***S
023400120606    *** MEMAC#3 IS ONLY ACTIVE MEMBERSHIP
023500120606    ***
023600120605     C     $REPRINT      BEGSR
023700120605    ***
023800120605     C     KL#TSA        READE     MEMBR
023900120606    ***
024000120606     C                   IF        %EOF(MEMAC#3)
024100120606     C                   EVAL      @PROC = 'PRINT LETR'
024200120606     C                   LEAVESR
024300120606     C                   ENDIF
024400120605    ***
024500120605    *** MUST BE A VALID MEMBER
024600120605    ***
024700120605     C                   EXSR      $CHKMBR
024800120605     C                   IF        VALID_MBR = NO
024900120605     C                   LEAVESR
025000120605     C                   ENDIF
025100120605    ***
025200120605    *** MUST HAVE A VALID PLAN ACTIVE
025300120605    ***
025400120605     C                   EXSR      $MPLAN
025500120605     C                   IF        VALID_PLN = NO
025600120605     C                   LEAVESR
025700120605     C                   ENDIF
025800120605    ***
025900120605    *** LOAD INTO LETTER CREATION FILE
026000120605    ***
026100120605     C                   CLEAR                   FSUBLTR
026200120605     C                   EVAL      SLSSNO = MBSSNO
026300120605     C                   EVAL      SLSEQ# = 00
026400120605     C                   EVAL      SLDATE = 00010101
026500120605     C                   EVAL      SLTRAN = #TISO
026600120605     C                   WRITE     FSUBLTR
026700120605    ***
026800120605     C                   ENDSR
026900120605   S***S
027000120605     C     $CHKMBR       BEGSR
027100120605    ***
027200120605     C                   EVAL      VALID_MBR = NO
027300211005    ***
027400211005    *** Only include active and waived memebrs so COBRA is skipped
027500211005    *** (administered and non-administered) which has status = C
027600211005    ***
027700211005        if (empst <> 'A' and empst <> 'W');
027800211005        leavesr;
027900211005        endif;
028000120605    ***
028100120605     C                   EVAL      VALID_MBR = YES
028200120605    ***
028300120605     C                   ENDSR
028400120605   S***S
028500120605     C     $MPLAN        BEGSR
028600120607    ***
028700120607     C                   EVAL      VALID_PLN = YES
028800120605    ***
028900120607    *** MEMBER MUST HAVE ANOTHER ACTIVE PLAN BEYOND JUST 401K AND ROTH PLANS
029000120607    ***  OTHERWISE, WE MUST SKIP THEM FOR THE LETTER.
029100120607    ***
029200120607    *C*                  EVAL      VALID_PLN = NO
029300120607    ***
029400120607    *C*    MBSSNO        CHAIN     MCOVR
029500120607    *C*                  IF        NOT %FOUND(MCOV)
029600120607    *C*                  LEAVESR
029700120607    *C*                  ENDIF
029800120607    ***
029900120607    *C*    MBSSNO        SETLL     MCOVR
030000120607    *C*                  DOU       %EOF(MCOV)
030100120607    *C*    MBSSNO        READE     MCOVR
030200120607    *C*                  IF        NOT %EOF(MCOV) AND
030300120607    *C*                            CANDT = 0
030400120607    ***
030500120607    *C*                  IF        MCPLAN = '401%' OR
030600120607    *C*                            MCPLAN = 'ROT%' OR
030700120607    *C*                            MCPLAN = '$BEN' OR
030800120607    *C*                            MCPLAN = 'ROT$' OR
030900120607    *C*                            MCPLAN = '401$'
031000120607    *C*                  ITER
031100120607    *C*                  ENDIF
031200120605    ***
031300120607     C*                  EVAL      VALID_PLN = YES
031400120607    *C*                  LEAVESR
031500120607    ***
031600120607    *C*                  ENDIF
031700120607    *C*                  ENDDO
031800120605    ***
031900120605     C                   ENDSR
032000120605   S***S
032100120605     C     $PRINT        BEGSR
032200120605    ***
032300120605     C                   Z-ADD     1             KF@SSN            9 0
032400120605     c                   Eval      @tday = %EditC(#TDAY:'Y')
032500120605    ***
032600120605     C     KF@SSN        SETLL     FSUBLTR
032700120605     C                   DOU       %EOF(COB440W1)
032800120605     C                   READ      FSUBLTR
032900120605     C                   IF        NOT %EOF(COB440W1)
033000120605    ***
033100120605     C     KL#TSAS       CHAIN     MEMBR
033200120605    ***
033300120605     c                   Move      zip           @9
033400120605     c                   Eval      z5 = %SubSt(@9:1:5)
033500210729     c                   EVAL      P1DATE = %trim(@tday)
033600120605    ***
033700120605     c                   if        mmi <> *blanks
033800120605     c                   Eval      p1name = %Trim(mfname) + ' ' + mmi +
033900120605     c                             ' ' + %Trim(mlname)
034000120605     c                   else
034100120605     c                   Eval      p1name = %Trim(mfname) + ' ' + %Trim(mlname)
034200120605     c                   endif
034300120605    ***
034400120605     c                   Eval      p1name = %Trim(p1name) + ' ' + 'and Spouse' +
034500120605     c                             ' (If Any)'
034600120605     C                   Eval      p1addr = %Trim(addr1)
034700120605     C                   Eval      p1add2 = %Trim(addr2)
034800120605     c                   Eval      p1csz = %Trim(city) + ', ' + state + ' ' + z5
034900210804    * *
035000210804    * * date and mailing address
035100210804    * *
035200210804     C                   EVAL      P1L1 = P1DATE
035300210804     C                   EVAL      P1L2 = *BLANKS
035400210804     C                   EVAL      P1L3 = P1NAME
035500210804     C                   EVAL      P1L4 = P1ADDR
035600210804
035700120605     C                   IF        P1ADD2 = *BLANKS
035800210804     C                   EVAL      P1L5 = P1CSZ
035900210804     C                   EVAL      P1L6 = *blanks
036000120605     C                   ELSE
036100120605     C                   EVAL      P1L5 = P1ADD2
036200120605     C                   EVAL      P1L6 = P1CSZ
036300120605     C                   ENDIF
036400120605    ***
036500120605     C                   Eval      p1re = %TRIM(SCRE)
036600120605    ***
036700180626    * * one letter has been printed - notify CL to espool it back to user
036800180626     c                   eval      parm1let = 'Y'
036900210729
037000210729      * Page 1 gets letter head ovelay
037100210729     c                   write     lethdol
037200210729     C                   WRITE     varp1
037300210729     C                   WRITE     PAGSEG1
037400210729      * Page 2
037500210729     C                   WRITE     PAGSEG2
037600210729      * Page 3
037700210729     C                   WRITE     PAGSEG3
037800210729      * Page 4
037900210729     C                   WRITE     varp4
038000210729     C                   WRITE     PAGSEG4
038100210729
038200120605    ***
038300120605     C                   IF        SCHIST = 'Y'
038400120605     C                   EXSR      $HISTREC
038500120605     C                   ENDIF
038600120605    ***
038700120605     C                   ENDIF
038800120605     C                   ENDDO
038900120605    ***
039000120605     C                   EVAL      @PROC = 'LEAVE LOOP'
039100120605    ***
039200120605     C                   ENDSR
039300120605   S***S
039400120605     C     $HISTREC      BEGSR
039500120605    ***
039600120605     c                   clear                   @timestamp
039700120605     C                   MOVE      *BLANKS       @TS40
039800120605     C                   CALL      'TIMESTMP'
039900120605     C                   PARM                    @TS40
040000120605     C                   MOVEL     @TS40         @TIMESTAMP
040100120605    ***
040200120605     C                   CLEAR                   HISTR
040300120605     C                   EVAL      %SUBST(HKEY:2:9) = %EDITC(SLSSNO:'X')
040400120605     C                   EVAL      TRCODE = 'U42'
040500120605     C                   EVAL      TRAMT = *ZEROS
040600120605     C                   EVAL      HDSEQ# = 00
040700131007     ********************EVAL      HPRGNM = 'ICN '
040800131007     c                   eval      hprgnm = thispgmname
040900120605     C                   EVAL      HSTRST = mbtrst
041000120605     C                   EVAL      HSSUB# = mbsub#
041100120605     C                   EVAL      HSACCT = mbacct
041200120605     C                   EVAL      HOPER = %TRIM(@TSUSER)
041300120605     C                   EVAL      HSDLTD = 'A'
041400120605     C                   EVAL      HINVDT = *ZERO
041500120605     C                   EVAL      RECVDT = *ZERO
041600120605     C                   EVAL      COVTDT = #TISO
041700131007     ********************EVAL      TRDATE = #TISO
041800131007     c                   Eval      trdate = #TSCYMD
041900131007     c                   eval      hstrtime = %time
042000120605     C                   WRITE     HISTR
042100120605    ***
042200120605     C                   ENDSR
042300210729      *
042400210729      * First cycle
042500210729      *
042600210729     C     *INZSR        BEGSR
042700210729    ***
042800210729      * page 4 variables
042900210729     c                   EVAL      P4ANAM  = 'AMWINS CONNECT ADMINISTRATORS'
043000210729     c                   EVAL      P4AADR  = '6 NORTH PARK DRIVE, SUITE 310'
043100210729     c                   EVAL      P4ACSZ  = 'HUNT VALLEY, MD  21030'
043200210729     c                   EVAL      P4CEMAIL = 'gbs.cobradmins@amwins.com'
043300210729    ***
043400210729     C                   ENDSR
