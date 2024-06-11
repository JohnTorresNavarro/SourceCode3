000100000000   X***X SUBSCRIBER INITIAL NOTICE APPLICATION
000200000000   X***X SINGLE LETTER REPRINTING PROGRAM
000300000000   X***X SSK  05/22/2012
000400000000   X***X
000500131007   X***X 10/04/2013 SSK HIST EXPANSION PROJECT
000600180626   X* *  06/26/2018 DLK - add overlay to first page and remove ssn
000700210729   X* *  07/29/2021 DLK - rebrand to Amwins, update letter, change printer
000800210729   X* *                   file name
000900180626   X* *
001000000000     FCOB442D   CF   E             WORKSTN INFDS(WSDS)
001100000000     FCOB440W2  IF   E           K DISK
001200000000     FMEMBER    IF   E           K DISK
001300000000     FHIST      O  A E             DISK    USROPN
001400210729     fcob441p   O    E             PRINTER
001500000000    ***
001600000000     D WSDS            DS
001700000000     D  FKEY                 369    369A
001800000000    ***
001900000000     D  F1             C                   CONST(X'31')
002000000000     D  F2             C                   CONST(X'32')
002100000000     D  F3             C                   CONST(X'33')
002200000000     D  F4             C                   CONST(X'34')
002300000000     D  F5             C                   CONST(X'35')
002400000000     D  F6             C                   CONST(X'36')
002500000000     D  F7             C                   CONST(X'37')
002600000000     D  F8             C                   CONST(X'38')
002700000000     D  F9             C                   CONST(X'39')
002800000000     D  F10            C                   CONST(X'3A')
002900000000     D  F11            C                   CONST(X'3B')
003000000000     D  F12            C                   CONST(X'3C')
003100000000     D  F13            C                   CONST(X'B1')
003200000000     D  F14            C                   CONST(X'B2')
003300000000     D  F15            C                   CONST(X'B3')
003400000000     D  F16            C                   CONST(X'B4')
003500000000     D  F17            C                   CONST(X'B5')
003600000000     D  F18            C                   CONST(X'B6')
003700000000     D  F19            C                   CONST(X'B7')
003800000000     D  F20            C                   CONST(X'B8')
003900000000     D  F21            C                   CONST(X'B9')
004000000000     D  F22            C                   CONST(X'BA')
004100000000     D  F23            C                   CONST(X'BB')
004200000000     D  F24            C                   CONST(X'BC')
004300000000    ***
004400000000     D @EMSG           S             70A
004500000000     D #USA            S               D   DATFMT(*USA)
004600000000     D #ISO            S               D   DATFMT(*ISO)
004700120530     D #TISO           S              8S 0
004800000000     D RUN#DATE        S              8S 0
004900000000    ***
005000120530     D @TIMESTAMP      DS
005100120530     D  #TSCYMD                1      8S 0
005200120530     D  #TSTIME                9     14S 0
005300120530     D  @TSJOB                15     24
005400120530     D  @TSUSER               25     34
005500120530     D  #TSNBR                35     40S 0
005600120530    * *
005700120530     D @TS40           S             40A
005800000000    ***
0059001310070037 D sysdateymd      S               d   datfmt(*iso)
006000210729     D thispgmname     S             10a   inz('COB442    ')
006100000000    ***
006200000000   X***X
006300000000     d @9              s              9a
006400120523     d Z5              s              5a
006500000000    ***
006600000000     D P1DATE          S             50A
006700000000     D P1NAME          S             50A
006800000000     D P1ADDR          S             50A
006900000000     D P1ADD2          S             50A
007000000000     D P1CSZ           S             50A
007100000000    ? * Program status data structure
007200000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
007300000000   X***X
007400120530    ***
007500120530    ***
007600180626     c     *entry        plist
007700180626     c                   parm                    parm1let          1
007800180626
007900120530     C     KL#TSA        KLIST
008000120530     C                   KFLD                    MBTRST
008100120530     C                   KFLD                    MBSUB#
008200120530     C                   KFLD                    MBACCT
008300120530    ***
008400000000     C                   MOVEL(P)  'INITIALIZE'  @PROC            10
008500120523    ***
008600000000     C                   DOU       @PROC = 'LEAVE LOOP'
008700000000     C     @PROC         CASEQ     'INITIALIZE'  $INITIAL
008800000000     C     @PROC         CASEQ     'SCREEN ONE'  $SCREEN1
008900000000     C     @PROC         CASEQ     'FORMAT SCR'  $FMTSCRN
009000120523     C     @PROC         CASEQ     'SCREEN TWO'  $SCREEN2
009100120530     C     @PROC         CASEQ     'REPRINT   '  $REPRINT
009200000000     C                   ENDCS
009300000000     C                   ENDDO
009400120523    ***
009500000000     C                   EVAL      *INLR = *ON
009600000000    ***
009700000000   S***S
009800000000     C     $INITIAL      BEGSR
009900000000    ***
010000000000     C                   CLEAR                   SCREEN
010100000000     C                   EVAL      *IN25 = *OFF
010200000000     C                   EVAL      SCHIST = 'Y'
010300000000     C                   EVAL      RUN#DATE = 0
010400120530     C                   EVAL      #ISO = %DATE
010500120530     C                   MOVE      #ISO          #TISO
010600000000     C                   EVAL      #USA = %DATE
010700000000     C                   MOVE      #USA          SCDATE
010800000000     C                   EVAL      @PROC = 'SCREEN ONE'
010900000000    ***
011000000000     C                   ENDSR
011100000000   S***S
011200000000     C     $SCREEN1      BEGSR
011300000000    ***
011400000000     C                   EVAL      EMSG = @EMSG
011500000000     C                   EXFMT     SCREEN
011600000000     C                   EVAL      @EMSG = *BLANKS
011700000000    ***
011800120523     C                   IF        FKEY = F3
011900000000     C                   EVAL      @PROC = 'LEAVE LOOP'
012000000000     C                   LEAVESR
012100000000     C                   ENDIF
012200000000    ***
012300000000     C                   IF        SCDATE = 0
012400000000     C                   EVAL      @EMSG = 'INVALID DATE'
012500000000     C                   LEAVESR
012600000000     C                   ENDIF
012700000000    ***
012800000000     C     *USA          TEST(DE)                SCDATE
012900000000     C                   IF        %ERROR
013000000000     C                   EVAL      @EMSG = 'INVALID DATE'
013100000000     C                   LEAVESR
013200000000     C                   ENDIF
013300000000    ***
013400000000     C                   MOVE      SCDATE        #USA
013500000000     C                   MOVE      #USA          #ISO
013600000000     C                   MOVE      #ISO          RUN#DATE
013700000000    ***
013800000000     C                   IF        SCHIST <> 'Y' AND SCHIST <> 'N'
013900000000     C                   EVAL      @EMSG = 'INVALID HIST NOTE'
014000000000     C                   LEAVESR
014100000000     C                   ENDIF
014200000000    ***
014300000000     C     SCSSN         CHAIN     MEMBR
014400000000     C                   IF        NOT %FOUND(MEMBER)
014500000000     C                   EVAL      @EMSG = 'INVALID MEMBER NUMBER'
014600000000     C                   LEAVESR
014700000000     C                   ENDIF
014800120530    ***
014900120530     C     KL#TSA        CHAIN     C2F
015000120530     C                   IF        NOT %FOUND(COB440W2)
015100120530     C                   EVAL      @EMSG = 'ACCOUNT NOT SET UP FOR LETTER'
015200120530     C                   LEAVESR
015300120530     C                   ENDIF
015400000000    ***
015500000000     C                   EVAL      @PROC = 'FORMAT SCR'
015600000000    ***
015700000000     C                   ENDSR
015800000000   S***S
015900000000     C     $FMTSCRN      BEGSR
016000000000    ***
016100000000     C                   EVAL      *IN25 = *ON
016200000000    ***
016300000000     C                   IF        MMI <> *BLANKS
016400000000     C                   EVAL      SCNAME = %TRIM(MFNAME) + ' ' + MMI +
016500000000     C                             ' ' + %TRIM(MLNAME)
016600000000     C                   ELSE
016700000000     C                   EVAL      SCNAME = %TRIM(MFNAME) + ' ' + %TRIM(MLNAME)
016800000000     C                   ENDIF
016900000000    ***
017000000000     c                   EVAL      SCSAL = %TRIM(SCNAME) + ' ' + 'and Spouse' +
017100000000     c                             ' (If Any)'
017200120525    ***
017300120530     C                   EVAL      SCRE = %TRIM(C2REMK)
017400120523    ***
017500120523     C                   EVAL      @9 = %CHAR(ZIP)
017600120523     C                   EVAL      Z5 = %SUBST(@9:1:5)
017700000000    ***
017800000000     C                   EVAL      SCA1 = %TRIM(ADDR1)
017900000000     C                   EVAL      SCA2 = %TRIM(ADDR2)
018000120523     c                   EVAL      SCCSZ = %TRIM(CITY) + ', ' + STATE + ' ' + Z5
018100000000    ***
018200120523     C                   EVAL      @PROC = 'SCREEN TWO'
018300000000    ***
018400000000     C                   ENDSR
018500000000   S***S
018600120523     C     $SCREEN2      BEGSR
018700120523    ***
018800120523     C                   EVAL      EMSG = @EMSG
018900120523     C                   EXFMT     SCREEN
019000120523     C                   EVAL      @EMSG = *BLANKS
019100120523    ***
019200120523     C                   IF        FKEY = F12
019300120523     C                   EVAL      @PROC = 'INITIALIZE'
019400120523     C                   LEAVESR
019500120523     C                   ENDIF
019600120523    ***
019700120523     C                   IF        FKEY = F5
019800120523     C                   EVAL      @PROC = 'FORMAT SCR'
019900120523     C                   LEAVESR
020000120523     C                   ENDIF
020100120523    ***
020200120523     C                   IF        FKEY = F10
020300120523     C                   EXSR      $VALID2
020400120523     C                   IF        @VALID = 'YES'
020500120523     C                   EVAL      @PROC = 'REPRINT   '
020600120523     C                   ENDIF
020700120523     C                   LEAVESR
020800120523     C                   ENDIF
020900120523    ***
021000120523     C                   EXSR      $VALID2
021100000000    ***
021200000000     C                   ENDSR
021300000000   S***S
021400120525     C     $REPRINT      BEGSR
021500210804    * *
021600210804    * * date and mailing address
021700210804    * *
021800210804     C                   EVAL      P1L1 = %trim(%EDITC(SCDATE:'Y'))
021900210804     C                   EVAL      P1L2 = *BLANKS
022000210804     C                   EVAL      P1L3 = SCSAL
022100210804     C                   EVAL      P1L4 = SCA1
022200210804
022300120525     C                   IF        SCA2 = *BLANKS
022400210804     C                   EVAL      P1L5 = SCCSZ
022500210804     C                   EVAL      P1L6 = *blanks
022600120523     C                   ELSE
022700120525     C                   EVAL      P1L5 = SCA2
022800120525     C                   EVAL      P1L6 = SCCSZ
022900120523     C                   ENDIF
023000120525    ***
023100120529     C                   Eval      p1re = %TRIM(SCRE)
023200120525    ***
023300180626    * * one letter has been printed - notify CL to espool it back to user
023400180626     c                   eval      parm1let = 'Y'
023500180626
023600210729
023700210729      * Page 1 gets letter head ovelay
023800210729     c                   write     lethdol
023900210729     C                   WRITE     varp1
024000210729     C                   WRITE     PAGSEG1
024100210729      * Page 2
024200210729     C                   WRITE     PAGSEG2
024300210729      * Page 3
024400210729     C                   WRITE     PAGSEG3
024500210729      * Page 4
024600210729     C                   WRITE     varp4
024700210729     C                   WRITE     PAGSEG4
024800210729
024900120525    ***
025000120525     C                   IF        SCHIST = 'Y'
025100120525     C                   EXSR      $HISTREC
025200120525     C                   ENDIF
025300000000    ***
025400120530     C                   EVAL      @PROC = 'INITIALIZE'
025500000000    ***
025600000000     C                   ENDSR
025700000000   S***S
025800120523     C     $VALID2       BEGSR
025900120523    ***
026000120523     C                   MOVEL(P)  'NO'          @VALID            3
026100120523    ***
026200120530     C                   IF        SCNAME = *BLANKS
026300120523     C                   EVAL      @EMSG = 'NAME CANNOT BE BLANK'
026400120523     C                   LEAVESR
026500120523     C                   ENDIF
026600120523    ***
026700120523     C                   IF        SCA1  = *BLANKS
026800120523     C                   EVAL      @EMSG = 'ADDRESS 1 CANNOT BE BLANK'
026900120523     C                   LEAVESR
027000120523     C                   ENDIF
027100120523    ***
027200120523     C                   IF        SCCSZ = *BLANKS
027300120523     C                   EVAL      @EMSG = 'CITY/ST/ZIP CANNOT BE BLANK'
027400120523     C                   LEAVESR
027500120523     C                   ENDIF
027600120523    ***
027700120523     C                   IF        SCSAL = *BLANKS
027800120523     C                   EVAL      @EMSG = 'SALUTATION REQUIRED'
027900120523     C                   LEAVESR
028000120523     C                   ENDIF
028100120523    ***
028200120529     C                   IF        SCRE = *BLANKS
028300120529     C                   EVAL      @EMSG = 'REGARDING REQUIRED'
028400120529     C                   LEAVESR
028500120529     C                   ENDIF
028600120529    ***
028700120523     C                   EVAL      @VALID = 'YES'
028800120523    ***
028900120523     C                   ENDSR
029000120523   S***S
029100000000     C     $HISTREC      BEGSR
029200120530    ***
029300120530     c                   clear                   @timestamp
029400120530     C                   MOVE      *BLANKS       @TS40
029500120530     C                   CALL      'TIMESTMP'
029600120530     C                   PARM                    @TS40
029700120530     C                   MOVEL     @TS40         @TIMESTAMP
029800000000    ***
029900120530     C                   OPEN(E)   HIST
030000120530    ***
030100000000     C                   CLEAR                   HISTR
030200120530     C                   EVAL      %SUBST(HKEY:2:9) = %EDITC(MBSSNO:'X')
030300000000     C                   EVAL      TRCODE = 'U42'
030400000000     C                   EVAL      TRAMT = *ZEROS
030500120525     C                   EVAL      HDSEQ# = 00
030600131007     ********************EVAL      HPRGNM = 'ICN '
030700131007     c                   eval      hprgnm = thispgmname
030800000000     C                   EVAL      HSTRST = mbtrst
030900000000     C                   EVAL      HSSUB# = mbsub#
031000000000     C                   EVAL      HSACCT = mbacct
031100120530     C                   EVAL      HOPER = %TRIM(@TSUSER)
031200000000     C                   EVAL      HSDLTD = 'A'
031300000000     C                   EVAL      HINVDT = *ZERO
031400000000     C                   EVAL      RECVDT = *ZERO
031500120530     C                   EVAL      COVTDT = RUN#DATE
031600131007     ********************EVAL      TRDATE = #TISO
031700131007     c                   Eval      trdate = #TSCYMD
031800131007     c                   eval      hstrtime = %time
031900000000     C                   WRITE     HISTR
032000000000    ***
032100120530     C                   CLOSE(E)  HIST
032200120530    ***
032300000000     C                   ENDSR
032400210729      *
032500210729      * First cycle
032600210729      *
032700210729     C     *INZSR        BEGSR
032800210729    ***
032900210729      * page 4 variables
033000210729     c                   EVAL      P4ANAM  = 'AMWINS CONNECT ADMINISTRATORS'
033100210729     c                   EVAL      P4AADR  = '6 NORTH PARK DRIVE, SUITE 310'
033200210729     c                   EVAL      P4ACSZ  = 'HUNT VALLEY, MD  21030'
033300210729     c                   EVAL      P4CEMAIL = 'gbs.cobradmins@amwins.com'
033400210729    ***
033500210729     C                   ENDSR
