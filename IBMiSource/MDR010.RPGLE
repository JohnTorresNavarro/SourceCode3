000100110411     FMDD010    CF   E             WORKSTN SFILE(S01SFL:RRT) INFDS(WSDS)
000200110412     FAGENL4    IF   E           K DISK
000300110412     FSMANSP    IF   E           K DISK
000400110412     FSMAN2L    IF   E           K DISK    PREFIX(ZZ:2)
000500110412     FSUPRAGCY  IF   E           K DISK
000600110412     FSPRAGXR2  IF   E           K DISK
000700110412     FSMANRLT   IF   E           K DISK
000800110411     **
000900110411     **
001000110411     FMKTDIARYH1IF   E           K DISK    RENAME(MKTHR:BYSMAN)
001100110411     ** SMAN LOGICAL
001200110411     FMKTDIARYH2IF   E           K DISK    RENAME(MKTHR:BYAGCY)
001300110411     ** AGENCY LOGICAL
001400110411     FMKTDIARYH3IF   E           K DISK    RENAME(MKTHR:BYSUPR)
001500110411     ** SUPER AGENCY LOGICAL
001600110411     FMKTDIARYH4IF   E           K DISK    RENAME(MKTHR:BYLINK)
001700110411     ** LINK ID LOGICAL
001800110411     FMKTDIARYH5IF   E           K DISK    RENAME(MKTHR:BYRELD)
001900110411     ** RELATIONSHIP ID LOGICAL
002000110411     FMKTDIARYH6IF   E           K DISK    RENAME(MKTHR:BYGRPR)
002100110411     ** GROUPER CODE LOGICAL
002200110411     **
002300110411     **
002400110412   X***X
002500110412     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
002600110412     D                UDS
002700110412     D  TITLE                201    240
002800010919   X***X
002900020102     D #CNTREC         S              4S 0
003000020102     D @1STLOOP        S              1A
003100020102     D RRT             S              4S 0
003200011220     D @DV             S              1A
003300011220     D @STEP           S              5A
003400011220     D E#              S              3S 0
003500020102     D #ISO            S               D   DATFMT(*ISO)
003600020102     D #USA            S               D   DATFMT(*USA)
003700020102     D #USO            S              8S 0
003800020102     D #ISA            S              8S 0
003900110412    ***
004000110412     D EOF_FLG         S               N   INZ(*OFF)
004100110412     D YES             S               N   INZ(*ON)
004200110412     D NO              S               N   INZ(*OFF)
004300020102    ***
004400110411     D KF@SMAN         S              3A
004500110411     D KF@AGCY         S              3A
004600110411     D KF@SUPR         S              3A
004700110411     D KF@LINK         S              8A
004800110411     D KF@RELD         S              8A
004900110411     D KF@GRPR         S              5A
005000011220    ***
005100011220     D WSDS            DS
005200011220     D  FKEY                 369    369A
005300011220    ***
005400011220     D  F1             C                   CONST(X'31')
005500011220     D  F2             C                   CONST(X'32')
005600011220     D  F3             C                   CONST(X'33')
005700011220     D  F4             C                   CONST(X'34')
005800011220     D  F5             C                   CONST(X'35')
005900011220     D  F6             C                   CONST(X'36')
006000011220     D  F7             C                   CONST(X'37')
006100011220     D  F8             C                   CONST(X'38')
006200011220     D  F9             C                   CONST(X'39')
006300011220     D  F10            C                   CONST(X'3A')
006400011220     D  F11            C                   CONST(X'3B')
006500011220     D  F12            C                   CONST(X'3C')
006600011220     D  F13            C                   CONST(X'B1')
006700011220     D  F14            C                   CONST(X'B2')
006800011220     D  F15            C                   CONST(X'B3')
006900011220     D  F16            C                   CONST(X'B4')
007000011220     D  F17            C                   CONST(X'B5')
007100011220     D  F18            C                   CONST(X'B6')
007200011220     D  F19            C                   CONST(X'B7')
007300011220     D  F20            C                   CONST(X'B8')
007400011220     D  F21            C                   CONST(X'B9')
007500011220     D  F22            C                   CONST(X'BA')
007600011220     D  F23            C                   CONST(X'BB')
007700011220     D  F24            C                   CONST(X'BC')
007800011220    ***
007900110412    *** @PARMOUT: POS 001-003 CONTROL VALUE
008000110412    ***               004-033 KEY VALUES 004-006 SMAN
008100110412    ***                                  007-009 AGENCY
008200110412    ***                                  010-012 SUPER
008300110412    ***                                  013-020 RELID
008400110412    ***                                  021-028 LINKID
008500110412    ***                                  029-033 GROUPER
008600110412    ***               034-073 DESCRIPTION
008700110412    ***               074-088 UNIQUE KEY
008800110412    ***               089-089 '*' FOR PARM INTEGRITY
008900110412    ***
009000110412     D @PARMOUT        S             89A   INZ
009100110412    ***
009200110412     D @CTL            S              3A
009300110412    ***
009400010919   X***X
009500011220     C                   DOU       @STEP = 'LEAVE'
009600011220     C     @STEP         CASEQ     'PREP1'       $PREP1
009700011220     C     @STEP         CASEQ     'STEP1'       $STEP1
009800011220     C     @STEP         CASEQ     'STEP2'       $STEP2
009900011220     C                   ENDCS
010000011220     C                   ENDDO
010100011220     C                   MOVE      *ON           *INLR
010200010919   S***S
010300010919     C     *INZSR        BEGSR
010400011220    ***
010500110411    *** PARM POS
010600110411    ***      1-3  PROMPT CONTROL
010700110411    ***      4-11 RECORD SELECTION VALUE - EITHER SMAN CODE, AGENCY CODE, SUPER AGENCY CODE,
010800110411    ***               LINK ID, GROUPER CODE, OR RELATIONSHIP ID VALUE.
010900110411    ***
011000110411    ***
011100031231     C     *ENTRY        PLIST
011200031231     C                   PARM                    PARM@IN          11
011300110411    ***
011400110411     C                   EVAL      @CTL = %SUBST(PARM@IN:1:3)
011500110411     C                   EVAL      KF@SMAN = *BLANKS
011600110411     C                   EVAL      KF@AGCY = *BLANKS
011700110411     C                   EVAL      KF@SUPR = *BLANKS
011800110411     C                   EVAL      KF@LINK = *BLANKS
011900110411     C                   EVAL      KF@RELD = *BLANKS
012000110411     C                   EVAL      KF@GRPR = *BLANKS
012100110411    ***
012200110411    *** CTL = 000 SALESMAN CODE ONLY
012300110411    ***       001 AGENCY CODE ONLY
012400110411    ***       010 SUPER AGENCY CODE ONLY
012500110411    ***       011 AGENCY/SUPER AGENCY LINK ID ONLY
012600110411    ***       100 RELATIONSHIP ID ONLY
012700110411    ***       101 GROUPER CODE ONLY
012800110411    ***
012900110411     C                   SELECT
013000110412      *
013100110411     C                   WHEN      @CTL = '000'
013200110411     C                   EVAL      KF@SMAN = %SUBST(PARM@IN:4:3)
013300110412     C     KF@SMAN       CHAIN     SMANR
013400110412     C                   EXSR      $GETSNAME
013500110412     C                   EVAL      I_SMAN = KF@SMAN
013600110412     C                   EVAL      @@DESC = %TRIM(A@40)
013700110412     C                   EVAL      %SUBST(@PARMOUT:04:03) = KF@SMAN
013800110415     C                   EVAL      %SUBST(@PARMOUT:29:05) = SGRP
013900110412      *
014000110411     C                   WHEN      @CTL = '001'
014100110411     C                   EVAL      KF@AGCY = %SUBST(PARM@IN:4:3)
014200110412     C     KF@AGCY       CHAIN     AGENR
014300110412     C                   EVAL      I_AGENCY = KF@AGCY
014400110412     C                   EVAL      @@DESC = %TRIM(AGNAM1)
014500110412     C                   EVAL      %SUBST(@PARMOUT:07:03) = KF@AGCY
014600110412      *
014700110411     C                   WHEN      @CTL = '010'
014800110411     C                   EVAL      KF@SUPR = %SUBST(PARM@IN:4:3)
014900110412     C     KF@SUPR       CHAIN     SAF
015000110412     C                   EVAL      I_SUPER  = KF@SUPR
015100110412     C                   EVAL      @@DESC = %TRIM(SANAME1)
015200110412     C                   EVAL      %SUBST(@PARMOUT:10:03) = KF@SUPR
015300110412      *
015400110411     C                   WHEN      @CTL = '011'
015500110411     C                   EVAL      KF@LINK = %SUBST(PARM@IN:4:8)
015600110412     C     KF@LINK       CHAIN     SXF
015700110412     C                   EVAL      I_LINKID = KF@LINK
015800110412     C                   EVAL      @@DESC = 'AGENCY:' + SXAGCY +
015900110412     C                                      ' & SUPER:' + SXSUPER
016000110412     C                   EVAL      %SUBST(@PARMOUT:07:03) = SXAGCY
016100110412     C                   EVAL      %SUBST(@PARMOUT:10:03) = SXSUPER
016200110412     C                   EVAL      %SUBST(@PARMOUT:21:08) = KF@LINK
016300110412      *
016400110411     C                   WHEN      @CTL = '100'
016500110411     C                   EVAL      KF@RELD = %SUBST(PARM@IN:4:8)
016600110412     C     KF@RELD       CHAIN     SRF
016700110412     C                   EVAL      I_RELID  = KF@RELD
016800110412     C                   EVAL      @@DESC = 'SMAN:' + SRSMAN +
016900110412     C                                      ' & LINK:' + SRASID
017000110412     C                   EVAL      %SUBST(@PARMOUT:13:08) = KF@RELD
017100110412     C                   EVAL      %SUBST(@PARMOUT:04:03) = SRSMAN
017200110412     C                   EVAL      %SUBST(@PARMOUT:21:08) = SRASID
017300110412     C     SRASID        CHAIN     SXF
017400110412     C                   EVAL      %SUBST(@PARMOUT:07:03) = SXAGCY
017500110412     C                   EVAL      %SUBST(@PARMOUT:10:03) = SXSUPER
017600110412     C     SRSMAN        CHAIN     SMANR
017700110412     C                   EVAL      %SUBST(@PARMOUT:29:05) = SGRP
017800110412      *
017900110411     C                   WHEN      @CTL = '101'
018000110411     C                   EVAL      KF@GRPR = %SUBST(PARM@IN:4:5)
018100110412     C     KF@GRPR       CHAIN     SMAN2R
018200110412     C                   EVAL      KF@SMAN = ZZDMGDFT
018300110412     C     KF@SMAN       CHAIN     SMANR
018400110412     C                   EXSR      $GETSNAME
018500110412     C                   EVAL      I_GROUPER = KF@GRPR
018600110412     C                   EVAL      @@DESC = %TRIM(A@40)
018700110412     C                   EVAL      %SUBST(@PARMOUT:04:03) = KF@SMAN
018800110412     C                   EVAL      %SUBST(@PARMOUT:29:05) = SGRP
018900110412      *
019000110411     C                   ENDSL
019100110411    ***
019200110412     C                   EVAL      %SUBST(@PARMOUT:01:03) = @CTL
019300110412     C                   EVAL      %SUBST(@PARMOUT:34:40) = %TRIM(@@DESC)
019400110412     C                   EVAL      %SUBST(@PARMOUT:89:1) = '*'
019500110412    ***
019600011220     C                   MOVE      'PREP1'       @STEP
019700011220    ***
019800011220     C                   ENDSR
019900011220   S***S
020000011220     C     $PREP1        BEGSR
020100011220    ***
020200020102     C                   MOVE      'STEP1'       @STEP
020300020102    ***
020400110411     C                   SELECT
020500110411     C                   WHEN      @CTL = '000'
020600110411     C                   MOVEA     '000'         *IN(35)
020700110411     C                   WHEN      @CTL = '001'
020800110411     C                   MOVEA     '001'         *IN(35)
020900110411     C                   WHEN      @CTL = '010'
021000110411     C                   MOVEA     '010'         *IN(35)
021100110411     C                   WHEN      @CTL = '011'
021200110411     C                   MOVEA     '011'         *IN(35)
021300110411     C                   WHEN      @CTL = '100'
021400110411     C                   MOVEA     '100'         *IN(35)
021500110411     C                   WHEN      @CTL = '101'
021600110411     C                   MOVEA     '101'         *IN(35)
021700110411     C                   ENDSL
021800110411    ***
021900010919     C                   ENDSR
022000010919   S***S
022100011220     C     $STEP1        BEGSR
022200020102    ***
022300020102     C                   EXSR      $CLEAR
022400110411    ***
022500020102     C                   EXSR      $BUILD
022600020102    ***
022700110411     C                   MOVE      'STEP2'       @STEP
022800020102    ***
022900020102     C                   ENDSR
023000020102   S***S
023100110411     C     $BUILD        BEGSR
023200110411    ***
023300020102    ***
023400020102     C                   MOVE      *ZEROS        #CNTREC
023500020102     C                   MOVE      '0'           @1STLOOP
023600110411    ***
023700020102    ***
023800110411     C                   SELECT
023900110411     C                   WHEN      @CTL = '000'
024000110411     C     KF@SMAN       SETLL     BYSMAN
024100110411     C                   WHEN      @CTL = '001'
024200110411     C     KF@AGCY       SETLL     BYAGCY
024300110411     C                   WHEN      @CTL = '010'
024400110411     C     KF@SUPR       SETLL     BYSUPR
024500110411     C                   WHEN      @CTL = '011'
024600110411     C     KF@LINK       SETLL     BYLINK
024700110411     C                   WHEN      @CTL = '100'
024800110411     C     KF@RELD       SETLL     BYRELD
024900110411     C                   WHEN      @CTL = '101'
025000110411     C     KF@GRPR       SETLL     BYGRPR
025100110411     C                   ENDSL
025200110411    ***
025300110411    ***
025400110412     C                   EVAL      EOF_FLG = NO
025500110412     C                   DOU       EOF_FLG = YES
025600110411    ***
025700110411     C                   SELECT
025800110412      *
025900110411     C                   WHEN      @CTL = '000'
026000110412     C     KF@SMAN       READE     BYSMAN
026100110411     C                   IF        %EOF(MKTDIARYH1)
026200110412     C                   EVAL      EOF_FLG = YES
026300110412     C                   ITER
026400110411     C                   ENDIF
026500110412      *
026600110411     C                   WHEN      @CTL = '001'
026700110412     C     KF@AGCY       READE     BYAGCY
026800110411     C                   IF        %EOF(MKTDIARYH2)
026900110412     C                   EVAL      EOF_FLG = YES
027000110412     C                   ITER
027100110411     C                   ENDIF
027200110412      *
027300110411     C                   WHEN      @CTL = '010'
027400110412     C     KF@SUPR       READE     BYSUPR
027500110411     C                   IF        %EOF(MKTDIARYH3)
027600110412     C                   EVAL      EOF_FLG = YES
027700110412     C                   ITER
027800110411     C                   ENDIF
027900110412      *
028000110411     C                   WHEN      @CTL = '011'
028100110415     C     KF@LINK       READE     BYLINK
028200110411     C                   IF        %EOF(MKTDIARYH4)
028300110412     C                   EVAL      EOF_FLG = YES
028400110412     C                   ITER
028500110412     C                   ENDIF
028600110412      *
028700110411     C                   WHEN      @CTL = '100'
028800110411     C     KF@RELD       READE     BYRELD
028900110411     C                   IF        %EOF(MKTDIARYH5)
029000110412     C                   EVAL      EOF_FLG = YES
029100110412     C                   ITER
029200110412     C                   ENDIF
029300110412      *
029400110411     C                   WHEN      @CTL = '101'
029500110411     C     KF@GRPR       READE     BYGRPR
029600110411     C                   IF        %EOF(MKTDIARYH6)
029700110412     C                   EVAL      EOF_FLG = YES
029800110412     C                   ITER
029900110412     C                   ENDIF
030000110412      *
030100110411     C                   ENDSL
030200110411    * *
030300020102     C                   EXSR      $LOADSFL
030400110411    ***
030500020102     C                   ENDDO
030600020102    ***
030700020102     C                   ENDSR
030800011220   S***S
030900020102     C     $CLEAR        BEGSR
031000020102    ***
031100020102     C                   MOVEA     '011'         *IN(25)
031200020102     C                   WRITE     S01CTL
031300020102     C                   MOVEA     '010'         *IN(25)
031400020102     C                   Z-ADD     *ZERO         RRT
031500020102    ***
031600020102     C                   ENDSR
031700020102   S***S
031800020102     C* LOAD SUBFILE RECORDS
031900020102    ***
032000020102     C     $LOADSFL      BEGSR
032100020102    ***
032200020102     C                   MOVE      *ON           *IN25
032300020102     C                   MOVE      *BLANKS       SEL
032400110411     C                   MOVE      MHCODE        SFCODE
032500020108     C*
032600110411     C                   MOVEL(P)  MHSUBJ        SFSUBJ
032700110411     C     MHADDT        MULT      10000.0001    SFADDT
032800110411     C                   Z-ADD     MHADTI        SFADTI
032900110411     C*
033000110411     C                   MOVEL(P)  MHADJOB       SFJOB
033100110411     C                   MOVEL(P)  MHADUSER      SFUSER
033200110411     C                   MOVEL(P)  MHADNBR       SFNBR
033300110411     C                   MOVEL(P)  MHUNIQUE      SFUNIQUE
033400110412     C                   EVAL      HHUNIQUE = MHUNIQUE
033500020102     C*
033600020102     C                   ADD       1             RRT
033700020315     C                   ADD       1             #CNTREC
033800020102     C*
033900020102     C                   IF        @1STLOOP = '0'
034000020102     C                   Z-ADD     RRT           SFLPOS
034100020102     C                   MOVE      '1'           @1STLOOP
034200020102     C                   ENDIF
034300020102     C*
034400020102     C                   WRITE     S01SFL
034500020102    ***
034600020102     C                   ENDSR
034700020102   S***S
034800110411     C     $STEP2        BEGSR
034900020102    ***
035000020102     C                   EXSR      $DISPLAY
035100110411    ***
035200110411    *** F1=CANCEL  F6=ADD   P=PRINT  X=DISPLAY
035300110411    ***
035400020102    ***
035500110411     C                   IF        FKEY = F1
035600020102     C                   MOVE      'LEAVE'       @STEP
035700020102     C                   LEAVESR
035800020102     C                   ENDIF
035900040102    ***
036000110411     C                   IF        FKEY = F6
036100020102     C                   EXSR      $ADDCALL
036200110411     C                   MOVE      'STEP1'       @STEP
036300020102     C                   LEAVESR
036400020102     C                   ENDIF
036500020102    ***
036600121011     C                   IF        FKEY = F8
036700121011     C                   CALL      'WRKMDCCL'
036800121011     C                   LEAVESR
036900121011     C                   ENDIF
037000121011    ***
037100020315     C                   IF        #CNTREC > 0
037200020102     C                   EXSR      $CHKSELC
037300020315     C                   ENDIF
037400020102    ***
037500020102     C                   ENDSR
037600020102   S***S
037700040102     C     $DISPLAY      BEGSR
037800040102    ***
037900020102     C                   WRITE     S01REC
038000020102     C                   EXFMT     S01CTL
038100020102    ***
038200020102     C                   ENDSR
038300020102   S***S
038400020102     C     $CHKSELC      BEGSR
038500020102    ***
038600110411    1C                   DOU       %EOF(MDD010 )
038700020102     C                   READC     S01SFL
038800110411    2C                   IF        NOT %EOF(MDD010 ) AND SEL <> *BLANKS
038900020103     C     SEL           CASEQ     'P'           $PRTCTL
039000020103     C     SEL           CASEQ     'X'           $DSPCTL
039100020103    3C                   ENDCS
039200110415     C                   EVAL      SEL = *BLANKS
039300110415     C                   UPDATE    S01SFL
039400020102    2C                   ENDIF
039500020102    1C                   ENDDO
039600020102    ***
039700110415     C                   EVAL      @STEP = 'STEP2'
039800110415    ***
039900020102     C                   ENDSR
040000020102   S***S
040100020102     C     $DSPCTL       BEGSR
040200020102    ***
040300110412     C                   EVAL      %SUBST(@PARMOUT:74:15) = HHUNIQUE
040400110412     C                   CALL      'MDR011'
040500110412     C                   PARM                    @PARMOUT
040600020102    ***
040700020102     C                   ENDSR
040800020102   S***S
040900020103     C     $PRTCTL       BEGSR
041000020103    ***
041100110412     C                   EVAL      @PRT = HHUNIQUE
041200110412     C                   CALL      'MDC012'
041300110412     C                   PARM                    @PRT             15
041400020103    ***
041500020103     C                   ENDSR
041600020103   S***S
041700020102     C     $ADDCALL      BEGSR
041800020102    ***
041900110412     C                   EVAL      %SUBST(@PARMOUT:74:15) = 'ADDADDADDADDADD'
042000110412     C                   CALL      'MDR011'
042100110412     C                   PARM                    @PARMOUT
042200020102    ***
042300020102     C                   ENDSR
042400020102   S***S
042500110412     C     $GETSNAME     BEGSR
042600110412    ***
042700110412     C                   CLEAR                   A@20             20
042800110412     C                   CLEAR                   A@40             40
042900110412    ***
043000110412     C                   IF        SFNAME <> *BLANKS
043100110412     C                   MOVEL     SFNAME        A@20
043200110412     C                   EXSR      $LDADDR
043300110412     C                   ENDIF
043400110412    ***
043500110412     C                   IF        SMI <> *BLANKS
043600110412     C                   MOVEL     SMI           A@20
043700110412     C                   EXSR      $LDADDR
043800110412     C                   ENDIF
043900110412    ***
044000110412     C                   IF        SLNAME <> *BLANKS
044100110412     C                   MOVEL     SLNAME        A@20
044200110412     C                   EXSR      $LDADDR
044300110412     C                   ENDIF
044400110412    ***
044500110412     C                   ENDSR
044600110412   S***S
044700110412     C     $LDADDR       BEGSR
044800110412    ***
044900110412     C                   EVAL      A@20 = %TRIM(A@20)
045000110412     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
045100110412     C                   CLEAR                   A@20
045200110412    ***
045300110412     C                   ENDSR
045400110412   S***S
