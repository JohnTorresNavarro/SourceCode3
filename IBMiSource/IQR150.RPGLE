000100030109     F*-------------------------------------------------------------------------
000200040708     F* IQR150    GBS/IO SOFTWARE 2003
000300030109     F*           FM46* SUPER AGENCY ENCHANCMENT PROJECT
000400030109     F*           WRITTEN BY - S.S.K.
000500030109     F*           DATE - 01/03
000600030109     F*  DESCRIPTION - PROMPT
000700030109     F*  INDICATOR USAGE:
000800030109     F*    01 = EXIT FROM INITIAL SCREEN
000900030109     F*    25 = SFLDSP
001000030109     F*    26 = SFL DSP CTL
001100030109     F*    27 = SFL CLR
001200030109     F*
001300030109     F*-------------------------------------------------------------------------
001400030109     ** MODIFICATION HISTORY                                              **
001500030109     ** ###  UUU  MMDDCCYY  X---->                                        **
001600030109     ** 000  SSK  01092003  ORIGINAL SOURCE                               **
001700040708     ** ***  SSK  01022004  COPY FM460 TO IQ                              **
001800090105     ** 001  SSK  01052003  ADD INACTIVITY PROGRAMMING PIECES             **
001900030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000040708     FIQR150D   CF   E             WORKSTN INFDS(WSDS)
002100040102     FSUPRAGCY  IF   E           K DISK
002200090105     FIRMMSTP   IF   E           K DISK
002300090105     FMKTSTSP   IF   E           K DISK
002400030109   X***X
002500030109     D WSDS            DS
002600030109     D  FKEY                 369    369A
002700030109    ***
002800030109     D  F1             C                   CONST(X'31')
002900030109     D  F2             C                   CONST(X'32')
003000030109     D  F3             C                   CONST(X'33')
003100030109     D  F4             C                   CONST(X'34')
003200030109     D  F5             C                   CONST(X'35')
003300030109     D  F6             C                   CONST(X'36')
003400030109     D  F7             C                   CONST(X'37')
003500030109     D  F8             C                   CONST(X'38')
003600030109     D  F9             C                   CONST(X'39')
003700030109     D  F10            C                   CONST(X'3A')
003800030109     D  F11            C                   CONST(X'3B')
003900030109     D  F12            C                   CONST(X'3C')
004000030109     D  F13            C                   CONST(X'B1')
004100030109     D  F14            C                   CONST(X'B2')
004200030109     D  F15            C                   CONST(X'B3')
004300030109     D  F16            C                   CONST(X'B4')
004400030109     D  F17            C                   CONST(X'B5')
004500030109     D  F18            C                   CONST(X'B6')
004600030109     D  F19            C                   CONST(X'B7')
004700030109     D  F20            C                   CONST(X'B8')
004800030109     D  F21            C                   CONST(X'B9')
004900030109     D  F22            C                   CONST(X'BA')
005000030109     D  F23            C                   CONST(X'BB')
005100030109     D  F24            C                   CONST(X'BC')
005200030109    ***
005300090105     D DS@IRM        E DS                  EXTNAME(IRMMSTP)
005400090105     D  IMTXT1                 2     41A
005500090105     D  IMTXT2                42     81A
005600090105    ***
005700030519    ***
005800030109     D #TDAY           S              8S 0
005900030109     D #ISO            S               D   DATFMT(*ISO)
006000030109     D #USA            S               D   DATFMT(*USA)
006100030109     D @VP             S              1A
006200030109    ***
006300030109     D @IM             S              1A
006400030109     D @STEP           S              5A
006500030429     D P@3             S              3A
006600030109    ***
006700030109     D @EMSG           S             70A
006800030109   X***X
006900030109    1C                   DOU       @STEP = 'LEAVE'
007000030109    2C     @STEP         CASEQ     'PREP1'       $PREP1
007100030109    2C     @STEP         CASEQ     'STEP1'       $STEP1
007200030109    2C                   ENDCS
007300030109    1C                   ENDDO
007400030109    ***
007500030109     C                   MOVE      *ON           *INLR
007600030109   S***S
007700030109     C     *INZSR        BEGSR
007800030109    ***
007900030109     C     *ENTRY        PLIST
008000030429     C                   PARM                    P@3
008100030109     C                   PARM                    P@1               1
008200030109    ***
008300030109     C                   CLEAR                   IO01
008400030429     C                   MOVEL     P@3           I_CODE
008500030109     C                   MOVE      P@1           @IM
008600030109     C                   EVAL      @STEP = 'PREP1'
008700030109    ***
008800090105     C     KL#MS         KLIST
008900090105     C                   KFLD                    KF@T1             1
009000090105     C                   KFLD                    I_CODE
009100090105    ***
009200030109     C                   ENDSR
009300030109   S***S
009400030109     C     $PREP1        BEGSR
009500030109    ***
009600030109     C                   EVAL      *IN25 = *ON
009700030109     C     I_CODE        CHAIN(N)  SAF
009800030109     C                   EXSR      $FMTREC
009900030109     C                   EVAL      @STEP = 'STEP1'
010000030109    ***
010100030109     C                   ENDSR
010200030109   S***S
010300030109     C     $FMTREC       BEGSR
010400030109    ***
010500030109     C                   IF        SAEFFDTE > 0
010600030109     C     SAEFFDTE      MULT      10000.0001    I_BEGDT
010700030109     C                   ELSE
010800030109     C                   Z-ADD     SAEFFDTE      I_BEGDT
010900030109     C                   ENDIF
011000030109    ***
011100030109     C                   IF        SATRMDTE > 0
011200030109     C     SATRMDTE      MULT      10000.0001    I_ENDDT
011300030109     C                   ELSE
011400030109     C                   Z-ADD     SATRMDTE      I_ENDDT
011500030109     C                   ENDIF
011600030109    ***
011700090105     C                   EVAL      *IN28 = *ON
011800090105     C                   EVAL      *IN30 = *ON
011900090105     C                   EVAL      *IN31 = *OFF
012000090105     C                   EVAL      INAC = *BLANKS
012100090105    * *
012200090105     C                   IF        SATRMDTE <> 0
012300090105    * *
012400090105     C                   EVAL      *IN28 = *ON
012500090105     C                   EVAL      *IN30 = *OFF
012600090105     C                   EVAL      KF@T1 = 'U'
012700090105    * *
012800090105     C     KL#MS         CHAIN     MKTSTSR
012900090105     C                   IF        %FOUND(MKTSTSP)
013000090105    * *
013100090105     C                   EVAL      *IN31 = *ON
013200090105     C                   EVAL      *IN28 = *OFF
013300090105     C                   EVAL      *IN30 = *ON
013400090105     C                   EVAL      INAC = MSREASN
013500090105    * *
013600090105     C     MSREASN       CHAIN     IRMMSTR
013700090105     C                   IF        NOT %FOUND(IRMMSTP)
013800090105    * *
013900090105     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
014000090105    * *
014100090105     C                   ENDIF
014200090105    * *
014300090105     C                   ENDIF
014400090105    * *
014500090105     C                   ENDIF
014600090105    ***
014700030109     C                   MOVEL(P)  SANAME1       I_NAME1
014800030109     C                   MOVEL(P)  SANAME2       I_NAME2
014900030109     C                   MOVEL(P)  SAADD1        I_ADD1
015000030109     C                   MOVEL(P)  SAADD2        I_ADD2
015100030109     C                   MOVEL(P)  SACITY        I_CITY
015200030109     C                   MOVEL(P)  SASTATE       I_STATE
015300030109     C                   MOVEL(P)  SAZIP         I_ZIP
015400030109     C                   MOVEL(P)  SACNTCT       I_CONTACT
015500030109     C                   MOVEL(P)  SAPHONE       I_PHONE
015600030109     C                   MOVEL(P)  SAFAX         I_FAX
015700030109     C                   MOVEL(P)  SATAXID       I_TAXID
015800030519    ***
015900030109     C                   ENDSR
016000030109   S***S
016100030109     C     $STEP1        BEGSR
016200030109    ***
016300030109     C                   MOVEL     @EMSG         EMSG
016400030109     C                   EXFMT     IO01
016500030109     C                   MOVE      *BLANKS       EMSG
016600030109     C                   MOVE      *BLANKS       @EMSG
016700030109    ***
016800030109    1C                   IF        FKEY = F7
016900030109     C                   EVAL      @STEP = 'LEAVE'
017000030109     C                   MOVE      'X'           P@1
017100030109     C                   LEAVESR
017200030109    1C                   ENDIF
017300030109    ***
017400030109    1C                   IF        FKEY = F1
017500030109     C                   EVAL      @STEP = 'LEAVE'
017600030109     C                   MOVE      *BLANKS       P@1
017700030109     C                   LEAVESR
017800030109    1C                   ENDIF
017900030109    ***
018000030109     C                   ENDSR
018100030109   S***S
