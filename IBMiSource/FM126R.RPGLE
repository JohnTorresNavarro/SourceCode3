000100091103     F*-------------------------------------------------------------------------
000200091103     F* FM126      GBS SOFTWARE 2009   FM12* AGENCY MASTER APPLICATION
000300091103     F*            WRITTEN BY - S.S.K.
000400091103     F*            DATE - 11/09
000500091103     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR AGENCY MASTER MAINT
000600091103     F*  INDICATOR USAGE:
000700091103     F*    01 = EXIT FROM INITIAL SCREEN
000800091103     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900091103     F*    25 = SFLDSP
001000091103     F*    26 = SFL DSP CTL
001100091103     F*    27 = SFL CLR
001200091103     F*
001300091103     F*-------------------------------------------------------------------------
001400091103     ** MODIFICATION HISTORY                                              **
001500091103     ** ###  UUU  MMDDCCYY  X---->                                        **
001600091103     ** 000  SSK  11032009  ORIGINAL SOURCE                               **
001700091103     **                                                                   **
001800091103     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900091103     FAGRHIST1  IF   E           K DISK    RENAME(RAGRHIST:BEFSEQ)
002000091103     FAGRHIST2  IF   E           K DISK    RENAME(RAGRHIST:AFTSEQ)
002100091103     FRMGRMST0  IF   E           K DISK
002200091103     FGBSECURE  IF   E           K DISK
002300091103     FFM126D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002400091103   X***X
002500091103     D P@3             S              3A
002600091103     D P@4             S              4A
002700091103     D KEY@AGC         S              3A
002800091103     D KEY@DTE         S              8S 0
002900091103     D KEY@USR         S                   LIKE(SCUSR)
003000091103    ***
003100091103     D #ISO            S               D   DATFMT(*ISO)
003200091103     D #USA            S               D   DATFMT(*USA)
003300091103     D #ISA            S              8S 0
003400091103    ***
003500091103     D                UDS
003600091103     D  TITLE                201    240A
003700091103    ***
003800091103     D WSDS            DS
003900091103     D  FKEY                 369    369A
004000091103    ***
004100091103     D  F1             C                   CONST(X'31')
004200091103     D  F2             C                   CONST(X'32')
004300091103     D  F3             C                   CONST(X'33')
004400091103     D  F4             C                   CONST(X'34')
004500091103     D  F5             C                   CONST(X'35')
004600091103     D  F6             C                   CONST(X'36')
004700091103     D  F7             C                   CONST(X'37')
004800091103     D  F8             C                   CONST(X'38')
004900091103     D  F9             C                   CONST(X'39')
005000091103     D  F10            C                   CONST(X'3A')
005100091103     D  F11            C                   CONST(X'3B')
005200091103     D  F12            C                   CONST(X'3C')
005300091103     D  F13            C                   CONST(X'B1')
005400091103     D  F14            C                   CONST(X'B2')
005500091103     D  F15            C                   CONST(X'B3')
005600091103     D  F16            C                   CONST(X'B4')
005700091103     D  F17            C                   CONST(X'B5')
005800091103     D  F18            C                   CONST(X'B6')
005900091103     D  F19            C                   CONST(X'B7')
006000091103     D  F20            C                   CONST(X'B8')
006100091103     D  F21            C                   CONST(X'B9')
006200091103     D  F22            C                   CONST(X'BA')
006300091103     D  F23            C                   CONST(X'BB')
006400091103     D  F24            C                   CONST(X'BC')
006500091103    ***
006600091103     D @STEP           S              5A
006700091103    ***
006800091103     D DS@LOD        E DS                  EXTNAME(AGRHIST0)
006900091103    ***
007000091103     D DS@B4         E DS                  EXTNAME(AGCYRMG0) PREFIX(BB:2)
007100091103    ***
007200091103     D DS@AF         E DS                  EXTNAME(AGCYRMG0) PREFIX(AA:2)
007300091103    ***
007400091103     D @DTA50          S             50A
007500091103   X***X
007600091103      /FREE
007700091103         O_AGCY = P@3;
007800091103         KEY@DTE = 00010101;
007900091103         KEY@AGC = P@3;
008000091103         @STEP = 'PREP1';
008100091103      /END-FREE
008200091103    ***
008300091103     C     *DTAARA       DEFINE    COMPANY       @DTA50
008400091103     C                   IN        @DTA50
008500091103     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
008600091103    ***
008700091103    *C                   DOU       @STEP = 'LEAVE'
008800091103    *C     @STEP         CASEQ     'PREP1'       $PREP1
008900091103    *C     @STEP         CASEQ     'STEP1'       $STEP1
009000091103    *C                   ENDCS
009100091103    *C                   ENDDO
009200091103    *C                   EVAL      *INLR = *ON
009300091103  *S***S
009400091103     C* ONETIME ROUTINE
009500091103    ***
009600091103     C     *INZSR        BEGSR
009700091103    ***
009800091103     C     *ENTRY        PLIST
009900091103     C                   PARM                    P@3
010000091103    ***
010100091103     C     KEY#SHST      KLIST
010200091103     C                   KFLD                    KEY@AGC
010300091103     C                   KFLD                    KEY@DTE
010400091103    ***
010500091103     C                   MOVE      *ZEROS        RRT               3 0
010600091103     C                   MOVE      *ZEROS        #CNTREC           2 0
010700091103    ***
010800091103     C                   MOVE      '0'           @1STLOOP          1
010900091103     C                   MOVE      '0'           @SFLOOP           1
011000091103    *C*                  MOVE      '0'           @CNFRM            1
011100091103     C                   MOVE      '1'           @LOOPIT           1
011200091103     C                   MOVE      '0'           @ACTION           1
011300091103     C                   MOVE      'M'           @SEQ              1
011400091103    ***
011500091103     C                   ENDSR
011600091103  *S***S
011700091103     C     $PREP1        BEGSR
011800091103    ***
011900091103     C                   EXSR      $CLEAR
012000091103    *C*
012100091103     C                   EXSR      $BUILD
012200091103    *C*
012300091103     C                   EVAL      @STEP = 'STEP1'
012400091103    ***
012500091103     C                   ENDSR
012600091103  *S***S
012700091103     C     $CLEAR        BEGSR
012800091103    ***
012900091103     C                   MOVEA     '011'         *IN(25)
013000091103     C                   WRITE     GBSCTL
013100091103     C                   MOVEA     '010'         *IN(25)
013200091103     C                   Z-ADD     *ZERO         RRT
013300091103    ***
013400091103     C                   ENDSR
013500091103   S***S
013600091103     C     $BUILD        BEGSR
013700091103    ***
013800091103     C                   EXSR      $CLEAR
013900091103     C                   MOVE      *ZEROS        #CNTREC
014000091103     C                   MOVE      '0'           @1STLOOP
014100091103     C                   MOVE      '0'           @SFLOOP
014200091103    ***
014300091103     C                   IF        @SEQ = 'M'
014400091103     C     KEY#SHST      SETLL     BEFSEQ
014500091103     C                   EXSR      $BLDBEF
014600091103     C                   ELSE
014700091103     C     KEY#SHST      SETLL     AFTSEQ
014800091103     C                   EXSR      $BLDAFT
014900091103     C                   ENDIF
015000091103    ***
015100091103     C                   EVAL      I_DTE = 0
015200091103    ***
015300091103     C                   ENDSR
015400091103   S***S
015500091103     C* BUILD BY BEFORE IMAGE
015600091103    ***
015700091103     C     $BLDBEF       BEGSR
015800091103    ***
015900091103     C                   DOU       %EOF(AGRHIST1) OR @SFLOOP = '1'
016000091103     C     KEY@AGC       READE     BEFSEQ
016100091103     C                   IF        NOT %EOF(AGRHIST1)
016200091103     C                   EXSR      $LOADSFL
016300091103     C                   ENDIF
016400091103     C                   ENDDO
016500091103    ***
016600091103     C                   ENDSR
016700091103   S***S
016800091103     C     $LOADSFL      BEGSR
016900091103    ***
017000091103     C                   MOVE      *ON           *IN25
017100091103    ***
017200091103     C                   EVAL      HDATA = DS@LOD
017300091103     C                   MOVE      *BLANKS       SEL01
017400091103     C*DLT               EVAL      SFNAM1 = %SUBST(HAFTER:4:30)
017500091103     C*
017600091103     C                   MOVEL(P)  HUSERID       KEY@USR
017700091103     C     KEY@USR       CHAIN     SECR
017800091103     C                   IF        %FOUND(GBSECURE)
017900091103     C                   MOVEL(P)  SCNAME        SFUSERID
018000091103     C                   ELSE
018100091103     C                   MOVE      *BLANKS       SFUSERID
018200091103     C                   END
018300091103     C*
018400091103     C                   MOVE      HDATE         #ISO
018500091103     C                   MOVE      #ISO          #USA
018600091103     C                   MOVE      #USA          SFDATE
018700091103     C                   Z-ADD     HTIME         SFTIME
018800091103     C*
018900091103     C                   ADD       1             RRT
019000091103     C                   IF        @1STLOOP = '0'
019100091103     C                   Z-ADD     RRT           SFLPOS
019200091103     C                   MOVE      '1'           @1STLOOP
019300091103     C                   ENDIF
019400091103     C*
019500091103     C                   WRITE     GBSSFL
019600091103    ***
019700091103     C                   ENDSR
019800091103   S***S
019900091103     C     $BLDAFT       BEGSR
020000091103     C*
020100091103     C                   DOU       %EOF(AGRHIST2) OR @SFLOOP = '1'
020200091103     C     KEY@AGC       READE     AFTSEQ
020300091103     C                   IF        NOT %EOF(AGRHIST2)
020400091103     C                   EXSR      $LOADSFL
020500091103     C                   ENDIF
020600091103     C                   ENDDO
020700091103    ***
020800091103     C                   ENDSR
020900091103   S***S
021000091103     C     $STEP1        BEGSR
021100091103    ***
021200091103     C                   EXSR      $DISPLAY
021300091103    ***
021400091103     C                   IF        FKEY = F1
021500091103     C                   EVAL      @STEP = 'LEAVE'
021600091103     C                   LEAVESR
021700091103     C                   ENDIF
021800091103    ***
021900091103     C                   IF        FKEY = F8
022000091103     C                   IF        @SEQ = 'M'
022100091103     C                   MOVE      'X'           @SEQ
022200091103     C                   ELSE
022300091103     C                   MOVE      'M'           @SEQ
022400091103     C                   ENDIF
022500091103     C                   EVAL      @STEP = 'PREP1'
022600091103     C                   LEAVESR
022700091103     C                   ENDIF
022800091103    ***
022900091103     C                   IF        I_DTE <> 0
023000091103     C                   EVAL      @STEP = 'PREP1'
023100091103     C                   LEAVESR
023200091103     C                   ENDIF
023300091103    ***
023400091103     C                   IF        RRT > 0
023500091103     C                   EXSR      $CHKSELC
023600091103     C                   ENDIF
023700091103    ***
023800091103     C                   ENDSR
023900091103   S***S
024000091103     C     $DISPLAY      BEGSR
024100091103    ***
024200091103     C                   WRITE     GBSREC
024300091103     C                   EXFMT     GBSCTL
024400091103    ***
024500091103     C                   ENDSR
024600091103   S***S
024700091103    SC     $CHKSELC      BEGSR
024800091103     C*
024900091103    1C                   DOU       %EOF(FM126D)
025000091103     C                   READC(E)  GBSSFL
025100091103    2C                   IF        NOT %EOF(FM126D) AND SEL01 = 'X' AND
025200091103     C                             NOT %ERROR
025300091103     C                   EXSR      $DSPCTL
025400091103     C                   EVAL      SEL01 = *BLANKS
025500091103     C                   UPDATE    GBSSFL
025600091103    3C                   ENDIF
025700091103    1C                   ENDDO
025800091103    ***
025900091103    SC                   ENDSR
026000091103   S***S
026100091103    SC     $DSPCTL       BEGSR
026200091103    ***
026300091103     C                   EXSR      $FMTDSP
026400091103    ***
026500091103     C                   DOU       FKEY = F1
026600091103     C*
026700091103     C                   EXFMT     EXPNDSCRA
026800091103     C*
026900091103    1C                   ENDDO
027000091103     C                   CLEAR                   FKEY
027100091103    ***
027200091103    SC                   ENDSR
027300091103   S***S
027400091103    SC     $FMTDSP       BEGSR
027500091103    ***
027600091103     C                   EVAL      *IN30 = *OFF
027700091103     C                   Z-ADD     41            ZZ
027800091103     C                   DO        20
027900091103     C                   ADD       1             ZZ                2 0
028000091103     C                   EVAL      *IN(ZZ) = *OFF
028100091103     C                   ENDDO
028200091103    ***
028300091103     C                   EVAL      DS@LOD = HDATA
028400091103    ***
028500091103     C                   MOVEL(P)  HUSERID       KEY@USR
028600091103     C     KEY@USR       CHAIN     SECR
028700091103     C                   IF        %FOUND(GBSECURE)
028800091103     C                   MOVEL(P)  SCNAME        GBSUSER
028900091103     C                   ELSE
029000091103     C                   MOVE      *BLANKS       GBSUSER
029100091103     C                   END
029200091103    ***
029300091103     C                   EVAL      DS@B4 = HBEFORE
029400091103     C                   EVAL      DS@AF = HAFTER
029500091103    ***
029600091103     C                   MOVE      *BLANKS       BSDESC
029700091103     C                   MOVE      *BLANKS       BLDESC
029800091103     C                   MOVE      *BLANKS       BRDESC
029900091103     C                   MOVE      *BLANKS       ASDESC
030000091103     C                   MOVE      *BLANKS       ALDESC
030100091103     C                   MOVE      *BLANKS       ARDESC
030200091103    ***
030300091103     C                   IF        BBSGR <> AASGR
030400091103     C                   EVAL      *IN41 = *ON
030500091103     C                   EVAL      KF@4A = BBSGR
030600091103     C                   EXSR      $GET_TEXT
030700091103     C                   EVAL      BSDESC = DESC20
030800091103     C                   EVAL      KF@4A = AASGR
030900091103     C                   EXSR      $GET_TEXT
031000091103     C                   EVAL      ASDESC = DESC20
031100091103     C                   ENDIF
031200091103    ***
031300091103     C                   IF        BBLGR <> AALGR
031400091103     C                   EVAL      *IN42 = *ON
031500091103     C                   EVAL      KF@4A = BBLGR
031600091103     C                   EXSR      $GET_TEXT
031700091103     C                   EVAL      BLDESC = DESC20
031800091103     C                   EVAL      KF@4A = AALGR
031900091103     C                   EXSR      $GET_TEXT
032000091103     C                   EVAL      ALDESC = DESC20
032100091103     C                   ENDIF
032200091103    ***
032300091103     C                   IF        BBRMGR <> AARMGR
032400091103     C                   EVAL      *IN43 = *ON
032500091103     C                   EVAL      KF@4A = BBRMGR
032600091103     C                   EXSR      $GET_TEXT
032700091103     C                   EVAL      BRDESC = DESC20
032800091103     C                   EVAL      KF@4A = AARMGR
032900091103     C                   EXSR      $GET_TEXT
033000091103     C                   EVAL      ARDESC = DESC20
033100091103     C                   ENDIF
033200091103    ***
033300091103     C                   MOVE      HDATE         #ISO
033400091103     C                   MOVE      #ISO          #USA
033500091103     C                   MOVE      #USA          HDATE
033600091103    ***
033700091103    SC                   ENDSR
033800091103   S***S
033900091103    SC     $GET_TEXT     BEGSR
034000091103    ***
034100091103     C                   MOVE      *BLANKS       DESC20           20
034200091103    ***
034300091103     C     KF@4A         CHAIN     RMGRMSTR
034400091103     C                   IF        %FOUND(RMGRMST0)
034500091103     C                   MOVEL(P)  RMNAME        DESC20
034600091103     C                   ENDIF
034700091103    ***
034800091103     C                   MOVE      *BLANKS       KF@4A             4
034900091103    ***
035000091103    SC                   ENDSR
035100091103   S***S
