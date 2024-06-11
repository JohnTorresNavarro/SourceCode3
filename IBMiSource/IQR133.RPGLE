000100020613     F*-------------------------------------------------------------------------
000200040708     F* IQR133     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020613     F*            FM10* SALESMAN MASTER APPLICATION
000400020613     F*            WRITTEN BY - S.S.K.
000500020613     F*            DATE - 06/02
000600020613     F*  DESCRIPTION - PROMPT
000700020613     F*  INDICATOR USAGE:
000800020613     F*    01 = EXIT FROM INITIAL SCREEN
000900020613     F*    25 = SFLDSP
001000020613     F*    26 = SFL DSP CTL
001100020613     F*    27 = SFL CLR
001200021203     F*
001300021203     F*-------------------------------------------------------------------------
001400020613     ** MODIFICATION HISTORY                                              **
001500020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001600020613     ** 000  SSK  06132002  ORIGINAL SOURCE                               **
001700021203     ** 001  SSK  12032002  DEFINE TWO NEW FIELDS DERIVED FROM FILL20     **
001800021209     ** 002  SSK  12092002  REMOVE REQUIREMENT FOR SS#                    **
001900030211001  ** 003  SSK  02102003  BREAK FILL20 INTO FOUR FIELDS                 **
002000030313     ** 004  SSK  03132003  GROUPER CODE MOD                              **
002100040708     ** ***  SSK  01012004  COPY FM104R TO IQ                             **
002200110801     ** 06.30.2011 SSK ADD SALESMAN RELATIONSHIP MANAGER.                 **
002300020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002400040708     FIQR133D   CF   E             WORKSTN INFDS(WSDS)
002500041006     Fsman2l1   IF   E           K DISK    RENAME(sman2r:F1X) PREFIX(XY:2)
002600040102     FSMAN      IF   E           K DISK
002700020613     FCODES     IF   E           K DISK
002800090105     FIRMMSTP   IF   E           K DISK
002900090105     FMKTSTSP   IF   E           K DISK
003000110801     FRMGRMST3  IF   E           K DISK
003100110801     FSMANRMGP  UF A E           K DISK
003200020612   X***X
003300020612     D WSDS            DS
003400020612     D  FKEY                 369    369A
003500020612    ***
003600020612     D  F1             C                   CONST(X'31')
003700020612     D  F2             C                   CONST(X'32')
003800020612     D  F3             C                   CONST(X'33')
003900020612     D  F4             C                   CONST(X'34')
004000020612     D  F5             C                   CONST(X'35')
004100020612     D  F6             C                   CONST(X'36')
004200020612     D  F7             C                   CONST(X'37')
004300020612     D  F8             C                   CONST(X'38')
004400020612     D  F9             C                   CONST(X'39')
004500020612     D  F10            C                   CONST(X'3A')
004600020612     D  F11            C                   CONST(X'3B')
004700020612     D  F12            C                   CONST(X'3C')
004800020612     D  F13            C                   CONST(X'B1')
004900020612     D  F14            C                   CONST(X'B2')
005000020612     D  F15            C                   CONST(X'B3')
005100020612     D  F16            C                   CONST(X'B4')
005200020612     D  F17            C                   CONST(X'B5')
005300020612     D  F18            C                   CONST(X'B6')
005400020612     D  F19            C                   CONST(X'B7')
005500020612     D  F20            C                   CONST(X'B8')
005600020612     D  F21            C                   CONST(X'B9')
005700020612     D  F22            C                   CONST(X'BA')
005800020612     D  F23            C                   CONST(X'BB')
005900020612     D  F24            C                   CONST(X'BC')
006000020613    ***
006100040102     D @7              S              7A
006200040102     D @9              S              9A
006300090105     D DS@IRM        E DS                  EXTNAME(IRMMSTP)
006400090105     D  IMTXT1                 2     41A
006500090105     D  IMTXT2                42     81A
006600040102    ***
006700040102     D KEY@TYPE        S                   LIKE(TYPE)
006800040102     D KEY@CODE        S                   LIKE(CODE)
006900040102     D @STEP           S              5A
007000040102     D P@1             S              1A
007100040102     D P@3             S              3A
007200040102     D P@4             S              4A
007300040102    ***
007400040102     D @EMSG           S             70A
007500040102     D @LD             S                   LIKE(LDESCR)
007600041006    ***
007700041006     d                 ds
007800041006     d parms@out               1     51a
007900041006     d  po@grpr                1      5a
008000041006     d  po@sman                6      8a
008100041006     d  po@name                9     43a
008200041006     d  po@term               44     51a
008300041006    ***
008400020612   X***X
008500020613    1C                   DOU       @STEP = 'LEAVE'
008600020613    2C     @STEP         CASEQ     'PREP1'       $PREP1
008700020613    2C     @STEP         CASEQ     'STEP1'       $STEP1
008800020613    2C                   ENDCS
008900020613    1C                   ENDDO
009000020612    ***
009100020612     C                   MOVE      *ON           *INLR
009200020612   S***S
009300020612     C     *INZSR        BEGSR
009400020612    ***
009500020612     C     *ENTRY        PLIST
009600020613     C                   PARM                    P@3
009700020613     C                   PARM                    P@4
009800020613     C                   PARM                    P@1
009900090105    ***
010000090105     C     KL#MS         KLIST
010100090105     C                   KFLD                    KF@T1             1
010200090105     C                   KFLD                    I_SMAN
010300020613    ***
010400020613     C     KEY@CODES     KLIST
010500020613     C                   KFLD                    KEY@TYPE
010600020613     C                   KFLD                    KEY@CODE
010700020613    ***
010800020613     C                   MOVEL     P@3           I_SMAN
010900020613     C                   EVAL      @STEP = 'PREP1'
011000020613    ***
011100020613     C                   ENDSR
011200020613   S***S
011300020613     C     $PREP1        BEGSR
011400020613    ***
011500040102     C                   EVAL      *IN27 = *OFF
011600020613     C                   MOVEA     '11'          *IN(25)
011700020613     C     I_SMAN        CHAIN(N)  SMANR
011800021203     C                   EXSR      $FMTREC
011900020613     C                   EVAL      @STEP = 'STEP1'
012000020614    ***
012100020614     C                   ENDSR
012200020614   S***S
012300030709     C     $FMTREC       BEGSR
012400030709    ***
012500090105    *C* OLD WAY          IF        SENDDT = 0
012600090105    *C* OLD WAY          EVAL      *IN28 = *ON
012700090105    *C* OLD WAY          ELSE
012800090105    *C* OLD WAY          EVAL      *IN28 = *OFF
012900090105    *C* OLD WAY          ENDIF
013000110801    ***
013100110801     C     I_SMAN        CHAIN     SMANRMGR
013200110801     C                   IF        %FOUND(SMANRMGP)
013300110801     C                   EVAL      SCRMGR = SMRMGR
013400110801     C     SMRMGR        CHAIN     RMGRMSTR
013500110801     C                   IF        %FOUND(RMGRMST3)
013600110801     C                   EVAL      D_RMGR = RMNAME
013700110801     C                   ELSE
013800110801     C                   EVAL      D_RMGR = '*INVALID*'
013900110801    1C                   ENDIF
014000110801     C                   ELSE
014100110801     C                   EVAL      SCRMGR = *BLANKS
014200110801     C                   EVAL      D_RMGR = '*INVALID*'
014300110801    1C                   ENDIF
014400020614    ***
014500020614     C                   EVAL      @9 = %EDITC(SZIPCD:'X')
014600020614     C                   MOVEL     @9            SZIP5
014700020614     C                   MOVE      @9            SZIP4
014800020614    ***
014900020614     C                   EVAL      @7 = %EDITC(SPHONE:'X')
015000020614     C                   MOVEL     @7            SPHONE3
015100020614     C                   MOVE      @7            SPHONE4
015200020614    ***
015300020614     C                   IF        SBEGDT > 0
015400020614     C     SBEGDT        MULT      10000.0001    I_BEGDT
015500020614     C                   ENDIF
015600020612    ***
015700020614     C                   IF        SENDDT > 0
015800020617     C     SENDDT        MULT      10000.0001    I_ENDDT
015900020614     C                   ENDIF
016000020614    ***
016100020614     C                   MOVE      STYPE         I_STYPE
016200020614     C                   EXSR      $GETCODES
016300090105    ***
016400090105     C                   EVAL      *IN28 = *ON
016500090105     C                   EVAL      *IN30 = *ON
016600090105     C                   EVAL      *IN31 = *OFF
016700090105     C                   EVAL      INAC = *BLANKS
016800090105    * *
016900090105     C                   IF        SENDDT <> 0
017000090105    * *
017100090105     C                   EVAL      *IN28 = *ON
017200090105     C                   EVAL      *IN30 = *OFF
017300090105     C                   EVAL      KF@T1 = 'S'
017400090105    * *
017500090105     C     KL#MS         CHAIN     MKTSTSR
017600090105     C                   IF        %FOUND(MKTSTSP)
017700090105    * *
017800090105     C                   EVAL      *IN31 = *ON
017900090105     C                   EVAL      *IN28 = *OFF
018000090105     C                   EVAL      *IN30 = *ON
018100090105     C                   EVAL      INAC = MSREASN
018200090105    * *
018300090105     C     MSREASN       CHAIN     IRMMSTR
018400090105     C                   IF        NOT %FOUND(IRMMSTP)
018500090105    * *
018600090105     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
018700090105    * *
018800090105     C                   ENDIF
018900090105    * *
019000090105     C                   ENDIF
019100090105    * *
019200090105     C                   ENDIF
019300090105    ***
019400090105     C                   SELECT
019500090105     C                   WHEN      FUSE = 'F'
019600090105     C                   EVAL      D_PDTSOLD = 'FULLY INSURED'
019700090105     C                   WHEN      FUSE = 'S'
019800090105     C                   EVAL      D_PDTSOLD = 'SELF FUNDED'
019900090105     C                   WHEN      FUSE = 'B'
020000090105     C                   EVAL      D_PDTSOLD = 'BOTH FULLY INSURED AND ' +
020100090105     C                                         'SELF FUNDED'
020200090105     C                   ENDSL
020300090105    ***
020400030723     C     I_SMAN        CHAIN     F1X
020500041006     C                   IF        %FOUND(sman2l1)
020600030723     C                   EVAL      DFTBROKER = 'Y'
020700030723     C                   ELSE
020800030723     C                   EVAL      DFTBROKER = 'N'
020900030723     C                   ENDIF
021000030211    ***
021100030304     C                   MOVE      STIN          SCTIN
021200020614    ***
021300020612     C                   ENDSR
021400020612   S***S
021500020612     C     $STEP1        BEGSR
021600020612    ***
021700020612     C                   MOVEL     @EMSG         EMSG
021800020612     C                   EXFMT     IO01
021900020612     C                   MOVE      *BLANKS       EMSG
022000020612     C                   MOVE      *BLANKS       @EMSG
022100020612    ***
022200020613    1C                   IF        FKEY = F7
022300020612     C                   EVAL      @STEP = 'LEAVE'
022400020613     C                   MOVE      'X'           P@1
022500020612     C                   LEAVESR
022600020613    1C                   ENDIF
022700040709    ***
022800040709    1C                   IF        FKEY = F11
022900040709     c     i_enddt       mult      10000.0001    #termdte          8 0
023000041006     c                   move      #termdte      po@term           8
023100040709    * *
023200040709     C     pl@2r         plist
023300040709     C                   PARM                    @9                9
023400040709     C                   PARM                    @3                3
023500040709     C                   PARM                    @35              35
023600040709     c                   parm                    @termdte          8
023700041006     C                   MOVEL     I_SMAN        po@sman
023800041006     C                   Move      sgrp          po@grpr
023900040709    * *
024000040709     C                   movel(p)  sfname        @35
024100040709     c                   eval      @35 = %trimr(@35) + ' ' + smi
024200040709     c                   eval      @35 = %trimr(@35) + ' ' + slname
024300041006     c                   movel(p)  @35           po@name
024400040709    * *
024500041006     C                   CALL      'IQ104_2CL'
024600041006     c                   parm                    parms@out
024700040709     C                   LEAVESR
024800040709    1C                   ENDIF
024900020612    ***
025000020613    1C                   IF        FKEY = F1
025100020613     C                   EVAL      @STEP = 'LEAVE'
025200020613     C                   MOVE      *BLANKS       P@1
025300020613     C                   LEAVESR
025400020613    1C                   ENDIF
025500020613    ***
025600020613     C                   ENDSR
025700020613   S***S
025800020613     C     $GETCODES     BEGSR
025900020613    ***
026000020613     C                   MOVE      'F'           KEY@TYPE
026100020613     C                   MOVEL(P)  I_STYPE       KEY@CODE
026200020613     C     KEY@CODES     CHAIN(N)  CODESR
026300020613    1C                   IF        NOT %FOUND(CODES)
026400020613     C                   EVAL      @LD = *BLANKS
026500020613    1C                   ELSE
026600020613     C                   EVAL      @LD = LDESCR
026700020613    1C                   ENDIF
026800020613    ***
026900020613     C                   MOVEL(P)  @LD           O_LDESCR
027000020612    ***
027100020612     C                   ENDSR
027200020612   S***S
