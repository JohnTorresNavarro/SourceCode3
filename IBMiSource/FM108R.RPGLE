000100031203     F*-------------------------------------------------------------------------
000200031203     F* FM108      GBS/IO SOFTWARE 2003
000300031203     F*            WRITTEN BY - S.S.K.
000400031203     F*            DATE - 12/03
000500041004     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR sman2
000600031203     F*  INDICATOR USAGE:
000700031203     F*    03 = EXIT FROM INITIAL SCREEN
000800031203     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900031203     F*    25 = SFLDSP
001000031203     F*    26 = SFL DSP CTL
001100031203     F*    27 = SFL CLR
001200031203     F*    30 = ALLOW ROLL KEY
001300031203     F*    29 = ROLL FUNCTION SELECTED
001400031203     F*
001500031203     F*-------------------------------------------------------------------------
001600031203     ** MODIFICATION HISTORY                                              **
001700031203     ** ###  UUU  MMDDCCYY  X---->                                        **
001800031203     ** 000  SSK  12032003  ORIGINAL SOURCE                               **
001900031203     **                                                                   **
002000031203     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100041004     FSM2HIST1  IF   E           K DISK    RENAME(RSM2HIST:BEFSEQ)
002200041004     FSM2HIST2  IF   E           K DISK    RENAME(RSM2HIST:AFTSEQ)
002300031203     FGBSECURE  IF   E           K DISK
002400041004     FSMANLF    IF   E           K DISK    RENAME(SMANR:FS)
002500031203     FFM108D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002600031203   X***X
002700041004     D P@8             S              8A
002800041004     D P@5             S              5A
002900041004     D P@3             S              3A
003000031203     D KEY@SUP         S              3A
003100031203     D KEY@DTE         S              8S 0
003200031203     D KEY@USR         S                   LIKE(SCUSR)
003300031203    ***
003400031203     D #ISO            S               D   DATFMT(*ISO)
003500031203     D #USA            S               D   DATFMT(*USA)
003600031203     D #ISA            S              8S 0
003700031203    ***
003800031203     D                UDS
003900031203     D  TITLE                201    240A
004000031203    ***
004100031203     D WSDS            DS
004200031203     D  FKEY                 369    369A
004300031203    ***
004400031203     D  F1             C                   CONST(X'31')
004500031203     D  F2             C                   CONST(X'32')
004600031203     D  F3             C                   CONST(X'33')
004700031203     D  F4             C                   CONST(X'34')
004800031203     D  F5             C                   CONST(X'35')
004900031203     D  F6             C                   CONST(X'36')
005000031203     D  F7             C                   CONST(X'37')
005100031203     D  F8             C                   CONST(X'38')
005200031203     D  F9             C                   CONST(X'39')
005300031203     D  F10            C                   CONST(X'3A')
005400031203     D  F11            C                   CONST(X'3B')
005500031203     D  F12            C                   CONST(X'3C')
005600031203     D  F13            C                   CONST(X'B1')
005700031203     D  F14            C                   CONST(X'B2')
005800031203     D  F15            C                   CONST(X'B3')
005900031203     D  F16            C                   CONST(X'B4')
006000031203     D  F17            C                   CONST(X'B5')
006100031203     D  F18            C                   CONST(X'B6')
006200031203     D  F19            C                   CONST(X'B7')
006300031203     D  F20            C                   CONST(X'B8')
006400031203     D  F21            C                   CONST(X'B9')
006500031203     D  F22            C                   CONST(X'BA')
006600031203     D  F23            C                   CONST(X'BB')
006700031203     D  F24            C                   CONST(X'BC')
006800031203    ***
006900031203     D @STEP           S              5A
007000031203    ***
007100041004     D DS@LOD        E DS                  EXTNAME(SM2HIST0)
007200031203     D  HMSG1                 46     95A
007300031203     D  HMSG2                 96    145A
007400031203    ***
007500041004     D DS@B4         E DS                  EXTNAME(sman2) PREFIX(B:1)
007600041004     D  B_N1                 402    433A
007700041004     D  B_N2                 434    465A
007800041004     D  B_N3                 466    497A
007900041004     D  B_N4                 498    529A
008000041004     d  bxl                  656    665a
008100031203    ***
008200041004     D DS@AF         E DS                  EXTNAME(sman2) PREFIX(A:1)
008300041004     D  A_N1                 402    433A
008400041004     D  A_N2                 434    465A
008500041004     D  A_N3                 466    497A
008600041004     D  A_N4                 498    529A
008700041004     d  axl                  656    665a
008800031203    ***
008900031203     D @DTA50          S             50A
009000031203   X***X
009100031203      /FREE
009200031203         KEY@SUP = P@8;
009300031203         @STEP = 'PREP1';
009400031203      /END-FREE
009500031203    ***
009600031203     C     *DTAARA       DEFINE    COMPANY       @DTA50
009700031203     C                   IN        @DTA50
009800031203     C                   EVAL      TITLE = %SUBST(@DTA50:1:40)
009900031203    ***
010000031203    *C                   DOU       @STEP = 'LEAVE'
010100031203    *C     @STEP         CASEQ     'PREP1'       $PREP1
010200031203    *C     @STEP         CASEQ     'STEP1'       $STEP1
010300031203    *C                   ENDCS
010400031203    *C                   ENDDO
010500031203    *C                   EVAL      *INLR = *ON
010600031203  *S***S
010700031203     C* ONETIME ROUTINE
010800031203    ***
010900031203     C     *INZSR        BEGSR
011000031203    ***
011100031203     C     *ENTRY        PLIST
011200031203     C                   PARM                    P@8
011300041004    ***
011400041004     c                   movel     p@8           p@5
011500041004     c                   move      p@8           p@3
011600031203    ***
011700031203     C                   MOVE      *ZEROS        RRT               3 0
011800031203     C                   MOVE      *ZEROS        #CNTREC           2 0
011900031203    ***
012000031203     C                   MOVE      '0'           @1STLOOP          1
012100031203     C                   MOVE      '0'           @SFLOOP           1
012200031203    *C*                  MOVE      '0'           @CNFRM            1
012300031203     C                   MOVE      '1'           @LOOPIT           1
012400031203     C                   MOVE      '0'           @ACTION           1
012500031203     C                   MOVE      'M'           @SEQ              1
012600031203    ***
012700031203     C                   ENDSR
012800031203  *S***S
012900031203     C     $PREP1        BEGSR
013000031203    ***
013100031203     C                   EXSR      $CLEAR
013200031203    *C*
013300031203     C                   EXSR      $BUILD
013400041004    ***
013500041004     c     p@3           chain     fs
013600041004     c                   if        %found(SMANLF)
013700041004     c                   eval      brokername = %trim(SFNAME)
013800041004     c                   eval      brokername = %trim(brokername)+ %trim(SMI)
013900041004     c                   eval      brokername = %trim(brokername)+ %trim(SLNAME)
014000041004     C                   else
014100041004     C                   eval      brokername = '**UNKNOWN**'
014200041004     c                   endif
014300041004    ***
014400031203     C                   EVAL      @STEP = 'STEP1'
014500031203    ***
014600031203     C                   ENDSR
014700031203  *S***S
014800031203     C     $CLEAR        BEGSR
014900031203    ***
015000031203     C                   MOVEA     '011'         *IN(25)
015100031203     C                   WRITE     GBSCTL
015200031203     C                   MOVEA     '010'         *IN(25)
015300031203     C                   Z-ADD     *ZERO         RRT
015400031203    ***
015500031203     C                   ENDSR
015600031203   S***S
015700031203     C     $BUILD        BEGSR
015800031203    ***
015900031203     C                   EXSR      $CLEAR
016000031203     C                   MOVE      *ZEROS        #CNTREC
016100031203     C                   MOVE      '0'           @1STLOOP
016200031203     C                   MOVE      '0'           @SFLOOP
016300031203    ***
016400031203     C                   EXSR      $LODSCTL
016500031203    ***
016600031203     C                   IF        @SEQ = 'M'
016700041004     C     P@5           SETLL     BEFSEQ
016800031203     C                   EXSR      $BLDBEF
016900031203     C                   ELSE
017000041004     C     P@5           SETLL     AFTSEQ
017100031203     C                   EXSR      $BLDAFT
017200031203     C                   ENDIF
017300031203    ***
017400031203     C                   ENDSR
017500031203   S***S
017600031203     C     $LODSCTL      BEGSR
017700031203    ***
017800031203     C                   MOVE      P@8           O_GRP
017900031203    ***
018000031203     C                   ENDSR
018100031203   S***S
018200031203     C* BUILD BY BEFORE IMAGE
018300031203    ***
018400031203     C     $BLDBEF       BEGSR
018500031203    ***
018600041004     C                   DOU       %EOF(SM2HIST1) OR @SFLOOP = '1'
018700041004     C     P@5           READE     BEFSEQ
018800041004     C                   IF        NOT %EOF(SM2HIST1)
018900031203     C                   EXSR      $LOADSFL
019000031203     C                   ENDIF
019100031203     C                   ENDDO
019200031203    ***
019300031203     C                   ENDSR
019400031203   S***S
019500031203     C     $LOADSFL      BEGSR
019600031203    ***
019700031203     C                   MOVE      *ON           *IN25
019800031203    ***
019900031203     C                   EVAL      HDATA = DS@LOD
020000031203     C                   MOVE      *BLANKS       SEL01
020100031203     C*
020200031203     C                   MOVEL(P)  HUSERID       KEY@USR
020300031203     C     KEY@USR       CHAIN     SECR
020400031203     C                   IF        %FOUND(GBSECURE)
020500031203     C                   MOVEL(P)  SCNAME        SFUSER
020600031203     C                   ELSE
020700031203     C                   MOVE      HUSERID       SFUSER
020800031203     C                   END
020900031203     C*
021000031203     C                   MOVE      HDATE         #ISO
021100031203     C                   MOVE      #ISO          #USA
021200031203     C                   MOVE      #USA          SFDATE
021300031203     C                   Z-ADD     HTIME         SFTIME
021400031203     C*
021500031203     C                   ADD       1             RRT
021600031203     C                   IF        @1STLOOP = '0'
021700031203     C                   Z-ADD     RRT           SFLPOS
021800031203     C                   MOVE      '1'           @1STLOOP
021900031203     C                   ENDIF
022000031203     C*
022100031203     C                   WRITE     GBSSFL
022200031203    ***
022300031203     C                   ENDSR
022400031203   S***S
022500031203     C     $BLDAFT       BEGSR
022600031203     C*
022700041004     C                   DOU       %EOF(SM2HIST2) OR @SFLOOP = '1'
022800041004     C     P@5           READE     AFTSEQ
022900041004     C                   IF        NOT %EOF(SM2HIST2)
023000031203     C                   EXSR      $LOADSFL
023100031203     C                   ENDIF
023200031203     C                   ENDDO
023300031203    ***
023400031203     C                   ENDSR
023500031203   S***S
023600031203     C     $STEP1        BEGSR
023700031203    ***
023800031203     C                   EXSR      $DISPLAY
023900031203    ***
024000031203     C                   IF        FKEY = F1
024100031203     C                   EVAL      @STEP = 'LEAVE'
024200031203     C                   LEAVESR
024300031203     C                   ENDIF
024400031203    ***
024500031203     C                   IF        FKEY = F8
024600031203     C                   IF        @SEQ = 'M'
024700031203     C                   MOVE      'X'           @SEQ
024800031203     C                   ELSE
024900031203     C                   MOVE      'M'           @SEQ
025000031203     C                   ENDIF
025100031203     C                   EVAL      @STEP = 'PREP1'
025200031203     C                   LEAVESR
025300031203     C                   ENDIF
025400031203    ***
025500031203     C                   IF        RRT > 0
025600031203     C                   EXSR      $CHKSELC
025700031203     C                   ENDIF
025800031203    ***
025900031203     C                   ENDSR
026000031203   S***S
026100031203     C     $DISPLAY      BEGSR
026200031203    ***
026300031203     C                   WRITE     GBSREC
026400031203     C                   EXFMT     GBSCTL
026500031203    ***
026600031203     C                   ENDSR
026700031203   S***S
026800031203    SC     $CHKSELC      BEGSR
026900031203     C*
027000031203    1C                   DOU       %EOF(FM108D)
027100031203     C                   READC(E)  GBSSFL
027200031203    2C                   IF        NOT %EOF(FM108D) AND SEL01 = 'X' AND
027300031203     C                             NOT %ERROR
027400031203     C                   EXSR      $DSPCTL
027500031203     C                   EVAL      SEL01 = *BLANKS
027600031203     C                   UPDATE    GBSSFL
027700031203    3C                   ENDIF
027800031203    1C                   ENDDO
027900031203    ***
028000031203    SC                   ENDSR
028100031203   S***S
028200031203    SC     $DSPCTL       BEGSR
028300031203    ***
028400041004     c                   eval      k = 5
028500041004     c                   exsr      $ndcs
028600031203     C                   EXSR      $FMTDSP
028700031203    ***
028800031203     C                   DOU       FKEY = F1
028900031203     C*
029000031203     C                   EXFMT     EXPNDSCRN
029100041004     C*
029200041004     C                   if        FKEY = F2
029300041004     c                   exsr      $ndcs
029400041004     c                   endif
029500031203     C*
029600031203    1C                   ENDDO
029700031203     C                   CLEAR                   FKEY
029800041004    ***
029900041004    SC                   ENDSR
030000041004   S***S
030100041004    SC     $ndcs         BEGSR
030200041004    ***
030300041004     c                   add       1             k                 1 0
030400041004    ***
030500041004     c                   if        k > 4
030600041004     c                   eval      k = 0
030700041004     c                   endif
030800041004    ***
030900041004     c                   select
031000041004    ***
031100041004     c                   when      k = 0
031200041004     c                   movea     '10000'       *in(50)
031300031203    ***
031400041004     c                   when      k = 1
031500041004     c                   movea     '01000'       *in(50)
031600041004    ***
031700041004     c                   when      k = 2
031800041004     c                   movea     '00100'       *in(50)
031900041004    ***
032000041004     c                   when      k = 3
032100041004     c                   movea     '00010'       *in(50)
032200041004    ***
032300041004     c                   when      k = 4
032400041004     c                   movea     '00001'       *in(50)
032500041004    ***
032600041004     c                   endsl
032700041004    ***
032800031203    SC                   ENDSR
032900031203   S***S
033000031203    SC     $FMTDSP       BEGSR
033100031203    ***
033200031203     C                   MOVEL     HDATA         DS@LOD
033300031203     C                   MOVEL     HBEFORE       DS@B4
033400031203     C                   MOVEL     HAFTER        DS@AF
033500041004    ***
033600041004     c     ' ':'0'       xlate     bxl           bxl
033700041004     c     ' ':'0'       xlate     axl           axl
033800031203    ***
033900031212     C     hdate         Mult      10000.0001    KDATE
034000031211     C                   MOVE      htime         KTIME
034100031203    ***
034200031212     C                   MOVEL(P)  HUSERID       Kuserid
034300031211     C                   MOVEL(P)  HUSERID       KEY@USR
034400031203     C     KEY@USR       CHAIN     SECR
034500031203     C                   IF        %FOUND(GBSECURE)
034600031203     C                   MOVEL(P)  SCNAME        O_USERNAME
034700031203     C                   ELSE
034800031203     C                   MOVE      HUSERID       O_USERNAME
034900031203     C                   END
035000031203    ***
035100031203     C                   EVAL      D_MSG1 = HMSG1
035200031203     C                   EVAL      D_MSG2 = HMSG2
035300031211     C                   EVAL      O_GRP = HFGRP
035400031203    ***
035500041004     c                   eval      B_BRADPH = %editw(bbradph:'0(   )   -    ')
035600041004     c                   eval      A_BRADPH = %editw(abradph:'0(   )   -    ')
035700041004     c                   eval      B_BRfax = %editw(bbrfax:'0(   )   -    ')
035800041004     c                   eval      a_BRfax = %editw(abrfax:'0(   )   -    ')
035900041004     c                   eval      B_asphn = %editw(basphn:'0(   )   -    ')
036000041004     c                   eval      a_asphn = %editw(aasphn:'0(   )   -    ')
036100041004     c                   eval      B_asfax = %editw(basfax:'0(   )   -    ')
036200041004     c                   eval      a_asfax = %editw(aasfax:'0(   )   -    ')
036300041004     c                   if        bdob <> 0
036400041004     c                   mult      10000.0001    bdob
036500041004     c                   endif
036600041004     c                   eval      b_dob = %editc(bdob:'Y')
036700041004     c                   if        adob <> 0
036800041004     c                   mult      10000.0001    adob
036900041004     c                   endif
037000041004     c                   eval      a_dob = %editc(adob:'Y')
037100031203    ***
037200031203    SC                   ENDSR
037300031203   S***S
