000100000216     F*********************************************************************
000200000216     F* FM010      - TRUST MASTER MAINTENANCE                             *
000300000216     F*                                                                   *
000400000216     F* ORIGINALLY WRITTEN BY MICHAEL C. DUNPHY  6/29/88                  *
000500000216     F*                       GROUP BENEFIT SERVICES SOFTWARE 1988        *
000600000216     F*                                                                   *
000700000216     F* REWRITTEN BY  STEPHEN KING  2/16/2000                             *
000800000216     F*               INNOVATIVE OUTSOURCING  2000                        *
000900000216     F*                                                                   *
001000000216     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
001100000216     F*            TRUST MASTER FILE (ADD CHANGE DELETE).                 *
001200000216     F*                                                                   *
001300000216     F*********************************************************************
001400000216     F* MODIFICATION HISTORY                                              *
001500000216     F* ### UUU CCYYMMDD X-->                                             *
001600000216     F* 000 SSK 20000216 REWRITE TO NATIVE AS/400                         *
0017000009050010 F* 08/01/00 DLK - DEFAULT TRNBIL TO "Y"                           *
001800010108     F* 001 SSK 20010108 ADD TRUST SELECTION WINDOW                       *
001900010322     F* DAVE A. REQUESTED TRNBIL ALLOW OTHER VALUES TRNBIL FIELD, THAN JUST 'Y'
002000020507     F* 05/07/02 SZZ - Add the Cobra Account Administrator (AACODE) field
002100021010     F* 002 SSK 20021010 ADD TRUST REACTIVATION KEY F6                    *
002200041116     F* 11/16/04 SZZ - Add invoice exception frequency fields.            *
002300081205     F* 12/05/08 RLJ - Add Onsite Dental Maint Logic.                     *
002400120425     F*  4/25/12 SZZ - Notify if new Senior Dental Trust has been added.  *
002500180110      * 01/08/18 jt  - Added changes for Advanced Mobile
002600180110      * 01/10/18 DLK - add new parm to SDNEWTC call to show what trust cat
002700180110      *                is being added (needed for Advanced Mobile)
002800200113      * 01/13/20 jt  - Added changes for CMS
002900180109
003000000216     F*********************************************************************
003100000428     FFM010D    CF   E             WORKSTN INFDS(WSDS)
003200000216     FTRSMST    UF A E           K DISK
003300041116     FTRSSUP    UF A E           K DISK
003400020507     FCOBRAAA   UF A E           K DISK
003500020507     FAACODE    IF   E           K DISK
003600000216     FCODES     IF   E           K DISK
003700000222     FTRMHIST0  O  A E             DISK
003800000216     ***
003900000217     D @CYMD           DS
004000000217     D  #CY                    1      4  0
004100000217     D  #MM                    5      6  0
004200000217     D  #DD                    7      8  0
004300000920    ***
004400090602    ?D WDDTA         E DS                  EXTNAME(ODCNTCP)
004500090602    ?D WMDTA         E DS                  EXTNAME(ODCMGRP)
004600090602    ***
004700000920     D #USA            S               D   DATFMT(*USA)
004800000920     D #ISO            S               D   DATFMT(*ISO)
004900000222      *
005000000222    *** TIMESTAMP FIELDS DATA STRUCTURE
005100000222      *
005200000222     D @TIMESTAMP      DS
005300000222     D  #TSCYMD                1      8S 0
005400000222     D  #TSTIME                9     14S 0
005500000222     D  @TSJOB                15     24
005600000222     D  @TSUSER               25     34
005700000222     D  #TSNBR                35     40S 0
005800000217     ***
005900000216     D WSDS            DS
006000000216     D  FKEY                 369    369A
006100000216     ***
006200000216     D  F1             C                   CONST(X'31')
006300000216     D  F2             C                   CONST(X'32')
006400000216     D  F3             C                   CONST(X'33')
006500000216     D  F4             C                   CONST(X'34')
006600000216     D  F5             C                   CONST(X'35')
006700000216     D  F6             C                   CONST(X'36')
006800000216     D  F7             C                   CONST(X'37')
006900000216     D  F8             C                   CONST(X'38')
007000000216     D  F9             C                   CONST(X'39')
007100000216     D  F10            C                   CONST(X'3A')
007200000216     D  F11            C                   CONST(X'3B')
007300000216     D  F12            C                   CONST(X'3C')
007400000216     D  F13            C                   CONST(X'B1')
007500000216     D  F14            C                   CONST(X'B2')
007600000216     D  F15            C                   CONST(X'B3')
007700000216     D  F16            C                   CONST(X'B4')
007800000216     D  F17            C                   CONST(X'B5')
007900000216     D  F18            C                   CONST(X'B6')
008000000216     D  F19            C                   CONST(X'B7')
008100000216     D  F20            C                   CONST(X'B8')
008200000216     D  F21            C                   CONST(X'B9')
008300000216     D  F22            C                   CONST(X'BA')
008400000216     D  F23            C                   CONST(X'BB')
008500000216     D  F24            C                   CONST(X'BC')
008600000216     ***
008700041118001  D MSG             S             45    DIM(16) CTDATA PERRCD(1)
008800000216     ***
008900000216     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
009000000216     D                UDS
009100000216     D  TITLE                201    240
009200000216     ***
009300000216     C                   DOU       @STEP = 'EXIT'
009400000216     C     @STEP         CASEQ     'STEP1 '      $STEP1
009500000216     C     @STEP         CASEQ     'STEP2 '      $STEP2
009600000216     C     @STEP         CASEQ     'STEP3 '      $STEP3
009700000216     C     @STEP         CASEQ     'STEP4 '      $STEP4
009800000216     C                   ENDCS
009900000216     C                   ENDDO
010000000216     C*
010100000216     C                   MOVE      *ON           *INLR
010200000216     C*
010300000216     C     *INZSR        BEGSR
010400000217     C                   MOVE      'O  '         @3                3
010500000217     C                   MOVE      *BLANKS       @UPDWRT           1
010600041118     C                   Move      *Blanks       @UWSUP            1
010700000216     C                   MOVE      'STEP1 '      @STEP             6
010800000216     C                   MOVE      *BLANKS       @EMSG            45
010900000216     C                   MOVE      'O'           @O                1
011000000216     C                   MOVE      '0'           @GD               1
011100000222     C                   MOVE      *BLANKS       @TS40            40
011200000216     C     *LIKE         DEFINE    TRTRST        @KEYTRST
011300000216     C     *LIKE         DEFINE    CODE          @CODE
011400000216     C     @CODEKEY      KLIST
011500000216     C                   KFLD                    @O
011600000216     C                   KFLD                    @CODE
011700000216     C                   ENDSR
011800000216     C*
011900000216     C     $STEP1        BEGSR
012000000216     C*
012100000216     C                   MOVEL(P)  @EMSG         SMSG
012200000216     C                   EXFMT     IO01
012300000216     C                   MOVE      *BLANKS       @EMSG
012400000216     C*
012500010108    1C                   IF        FKEY = F7
012600000216     C                   MOVEL(P)  'EXIT'        @STEP
012700000216     C                   LEAVESR
012800010108    1C                   ENDIF
012900000216     C*
013000010108001 1C                   IF        FKEY = F9
013100010108001  C                   MOVE      *BLANK        @PARM3            3
013200010108001  C                   CALL      'FM006CL'
013300010108001  C                   PARM                    @PARM3
013400010108001 2C                   IF        @PARM3 = '*LR'
013500010108001  C                   MOVEL(P)  MSG(11)       @EMSG
013600010108001  C                   LEAVESR
013700010108001 2C                   ELSE
013800010108001  C                   MOVE      @PARM3        TRUST#
013900010108001 2C                   ENDIF
014000010108001 1C                   ENDIF
014100010108     C*
014200000216     C                   IF        TRUST# = 0
014300000216     C                   MOVEL(P)  MSG(1)        @EMSG
014400000216     C                   LEAVESR
014500000216     C                   ENDIF
014600000216     C*
014700000216     C                   MOVEL(P)  'STEP2'       @STEP
014800000216     C*
014900000216     C                   ENDSR
015000000216     C*
015100000216     C     $STEP2        BEGSR
015200000216     C*
015300000216     C                   Z-ADD     TRUST#        @KEYTRST
015400081205      *
015500081205     C                   eval      stloss = 0
015600081205     C                   eval      i2cntdt = 0
015700081205     C                   eval      tc = *blanks
015800081205     C                   eval      trnbil = *blanks
015900081205     C                   eval      ldescr = *blanks
016000081205    2C                   eval      *in35 = '0'
016100041116      *
016200041118     C     @KEYTRST      CHAIN     TRSSUR
016300041118     C                   Z-ADD     @KEYTRST      TSTRST
016400041116     C                   If        %Found(TRSSUP)
016500041118     C     EFFDT         Mult      10000.0001    WSEFDT
016600041118szz  C                   Move      'U'           @UWSUP
016700041118szz  C                   Else
016800041118     C                   Clear                   TRSSUR
016900041118     C                   Clear                   WSEFDT
017000041118szz  C                   Move      'W'           @UWSUP
017100041116     C                   End
017200041116      *
017300000216     C     @KEYTRST      CHAIN     TRSMSR
017400000216     C*
017500000920    1C                   IF        %FOUND(TRSMST)
017600000920     C                   MOVE      'U'           @UPDWRT
017700000920     C*
017800001204    2C                   IF        CONTDT <> 0
017900000920     C                   MOVE      CONTDT        #ISO
018000000920     C                   MOVE      #ISO          #USA
018100000920     C                   MOVE      #USA          I2CNTDT
018200000920     C                   MOVE      #USA          I4CNTDT
018300001204    2C                   ENDIF
018400020507     C*---
018500020507     C* AA Code (Account Administrator)
018600020507     C*---
018700020507     C     TRUST#        Chain     COBRAAA
018800020507     C                   If        Not %Found(COBRAAA)
018900020507     C                   Move      *Blanks       DACODE
019000020516     C                   Move      *Blanks       ALNAM
019100020507     C                   Else
019200020507     C                   Movel     CACODE        DACODE
019300020507     C     CACODE        Chain     AACODE
019400020507     C                   If        Not %Found(AACODE)
019500020507     C                   Move      *Blanks       ALNAM
019600020507     C                   End
019700020507     C                   End
019800000217     C*
019900000216     C                   MOVE      TSCODE        TC
020000000217     C                   MOVE      *BLANKS       @CODE
020100000217     C                   MOVE      TC            @CODE
020200081205      *
020300081205    2C                   eval      *in35 = '0'
020400180108     C****               If        tscode = 'O N'
020500180108     c                   If        tscode = 'O N' or tscode = 'O M'
020600200113     c                             or tscode = 'O D'
020700081205    2C                   eval      *in35 = '1'
020800081205    2C                   ENDIF
020900081205      *
021000000217     C     @CODEKEY      CHAIN     CODESR
021100000216     C*
021200000905    2C                   IF        TRDLTD = 'D'
021300021010     C                   MOVEL(P)  MSG(13)       @EMSG
021400000216     C                   MOVEL(P)  'STEP3'       @STEP
021500000216     C                   LEAVESR
021600000905    2C                   ENDIF
021700000222     C*
021800000222     C                   Z-ADD     TRTRST        HTRST
021900000222     C*
022000000222     C                   MOVEL(P)  TNAME         HBTNAME
022100000222     C                   MOVEL(P)  TDESCR        HBTDESCR
022200000222     C                   MOVEL(P)  PTADL1        HBPTADL1
022300000222     C                   MOVEL(P)  PTADL2        HBPTADL2
022400000222     C                   MOVEL(P)  PTADL3        HBPTADL3
022500000222     C                   MOVEL(P)  PTADL4        HBPTADL4
022600000222     C                   Z-ADD     STLOSS        HBSTLOSS
022700000222     C                   MOVE      TRNBIL        HBTRNBIL
022800000222     C                   MOVEL(P)  TSCODE        HBTSCODE
022900000222     C                   MOVE      TRDLTD        HBTRDLTD
023000000222     C                   Z-ADD     CONTDT        HBCONTDT
023100000216     C*
023200001019     C                   MOVEL(P)  TNAME         HATNAME
023300001019     C                   MOVEL(P)  TDESCR        HATDESCR
023400001019     C                   MOVEL(P)  PTADL1        HAPTADL1
023500001019     C                   MOVEL(P)  PTADL2        HAPTADL2
023600001019     C                   MOVEL(P)  PTADL3        HAPTADL3
023700001019     C                   MOVEL(P)  PTADL4        HAPTADL4
023800001019     C                   Z-ADD     STLOSS        HASTLOSS
023900001019     C                   MOVE      TRNBIL        HATRNBIL
024000001019     C                   MOVEL(P)  TSCODE        HATSCODE
024100001019     C                   MOVE      TRDLTD        HATRDLTD
024200001019     C                   Z-ADD     CONTDT        HACONTDT
024300001019     C*
024400000905    1C                   ELSE
024500000216     C*
024600041118szz  C                   CLEAR                   TRSMSR
024700001204     C                   Z-ADD     @KEYTRST      TRUST#
024800001204     C                   Z-ADD     @KEYTRST      TRTRST
024900000217     C                   MOVE      'W'           @UPDWRT
025000000905     C                   MOVE      'Y'           TRNBIL
025100020507     C                   Clear                   DACODE
025200020507     C                   Clear                   ALNAM
025300000216     C*
025400000905    1C                   ENDIF
025500000216     C*
025600000216     C                   MOVEL(P)  'STEP4'       @STEP
025700000216     C*
025800000216     C                   ENDSR
025900000216     C*
026000000216     C     $STEP3        BEGSR
026100000216     C*
026200000216     C                   MOVEL(P)  @EMSG         SMSG
026300000216     C                   EXFMT     IO04
026400000216     C*
026500000216     C                   SELECT
026600000216     C*
026700000216     C                   WHEN      FKEY = F1
026800000216     C                   MOVEL(P)  'STEP1'       @STEP
026900000216     C                   MOVE      *BLANKS       @EMSG
027000000216     C                   LEAVESR
027100000216     C*
027200000222     C                   WHEN      FKEY = F5
027300000222     C                   MOVE      TRUST#        @P1               3
027400000222     C                   CALL      'FM011R'
027500000222     C                   PARM                    @P1
027600000222     C                   LEAVESR
027700000222     C*
027800021010     C                   WHEN      FKEY = F6
027900021010     C                   EXSR      $REACT
028000021010     C                   MOVEL(P)  'STEP2'       @STEP
028100021010     C                   LEAVESR
028200021010     C
028300000216     C                   WHEN      FKEY = F7
028400000216     C                   MOVEL(P)  'EXIT'        @STEP
028500000216     C                   LEAVESR
028600000216     C*
028700000216     C                   ENDSL
028800021010     C*
028900021010     C                   ENDSR
029000021010     C*
029100021010     C     $REACT        BEGSR
029200021010     C*
029300021010     C                   Z-ADD     TRTRST        HTRST
029400021010     C*
029500021010     C                   MOVEL(P)  TNAME         HBTNAME
029600021010     C                   MOVEL(P)  TDESCR        HBTDESCR
029700021010     C                   MOVEL(P)  PTADL1        HBPTADL1
029800021010     C                   MOVEL(P)  PTADL2        HBPTADL2
029900021010     C                   MOVEL(P)  PTADL3        HBPTADL3
030000021010     C                   MOVEL(P)  PTADL4        HBPTADL4
030100021010     C                   Z-ADD     STLOSS        HBSTLOSS
030200021010     C                   MOVE      TRNBIL        HBTRNBIL
030300021010     C                   MOVEL(P)  TSCODE        HBTSCODE
030400021010     C                   MOVE      TRDLTD        HBTRDLTD
030500021010     C                   Z-ADD     CONTDT        HBCONTDT
030600021010     C*
030700021010     C                   EVAL      TRDLTD = 'A'
030800021010     C*
030900021010     C                   EXSR      $CHGHIST
031000021010     C                   UPDATE    TRSMSR
031100041118szz  C                   UPDATE    TRSSUR
031200021010     C                   MOVEL(P)  'REC CHANGED' @EMSG
031300000216     C*
031400000216     C                   ENDSR
031500000216     C*
031600000216     C     $STEP4        BEGSR
031700000216     C*
031800000216     C                   MOVEL(P)  @EMSG         SMSG
031900000216     C                   EXFMT     IO02
032000000216     C                   MOVE      *BLANKS       @EMSG
032100000216     C*
032200000216     C                   SELECT
032300000216     C*
032400000216     C                   WHEN      FKEY = F1
032500000216     C                   MOVEL(P)  'STEP1'       @STEP
032600000216     C                   MOVE      *BLANKS       @EMSG
032700000216     C                   LEAVESR
032800000216     C*
032900000222     C                   WHEN      FKEY = F5
033000000222     C                   MOVE      TRUST#        @P1               3
033100000222     C                   CALL      'FM011R'
033200000222     C                   PARM                    @P1
033300000222     C                   LEAVESR
033400000222     C*
033500000216     C                   WHEN      FKEY = F7
033600000216     C                   MOVEL(P)  'EXIT'        @STEP
033700000216     C                   LEAVESR
033800000216     C*
033900000217     C                   WHEN      FKEY = F10
034000000222     C                   MOVE      'O  '         @3
034100000901     C                   CALL      'FM001CL'
034200000217     C                   PARM                    @3
034300000217     C                   IF        @3 <> '*LR'
034400000217     C                   MOVE      @3            TC
034500000217     C                   ENDIF
034600090602      *
034700090602     C                   WHEN      FKEY = F13
034800180108     C****               If        tscode = 'O N'
034900180108     c                   If        tscode = 'O N' or tscode = 'O M'
035000200113     c                             or tscode = 'O D'
035100200113     C                   Eval      OCTRST   =    TRUST#
035200090602     C                   Eval      OCSUB#   =    *Loval
035300090602     C                   Eval      OCACCT   =    *Loval
035400090602     C                   Eval      CMTRST   =    TRUST#
035500090602     C                   Eval      CMCMGR   =    *Loval
035600090608    ?C                   Call      'WRKOM2CL'                                   END FNC LOOP
035700090602     C                   Parm                    WMDTA
035800090602     C                   Parm                    WDDTA
035900090602     C                   LEAVESR
036000090602     C                   ENDIF
036100090602      *
036200081205      *
036300081205     C                   WHEN      FKEY = F12
036400180108     C****               If        tscode = 'O N'
036500180108     c                   If        tscode = 'O N' or tscode = 'O M'
036600200113     c                             or tscode = 'O D'
036700081205     C                   MOVE      TRUST#        @P1               3
036800081205     C                   CALL      'FM012CL'
036900081205     C                   PARM                    @P1
037000081205     C                   LEAVESR
037100081205     C                   ENDIF
037200090421      *
037300090421     C                   WHEN      FKEY = F11
037400180108     C****               If        tscode = 'O N'
037500180108     c                   If        tscode = 'O N' or tscode = 'O M'
037600200113     c                             or tscode = 'O D'
037700090421     C                   MOVE      TRUST#        @P1               3
037800090421     C                   CALL      'FM013CL'
037900090421     C                   PARM                    @P1
038000090421     C                   LEAVESR
038100090421     C                   ENDIF
038200081205      *
038300000216     C                   ENDSL
038400000216     C*
038500000216     C                   EXSR      $VALID
038600000217     C*
038700000216     C                   ENDSR
038800000217     C*
038900000217     C*
039000000217     C*
039100000217     C*
039200000217     C     $VALID        BEGSR
039300000217     C*
039400020507     C*---
039500020507     C* AA Code
039600020507     C*---
039700020507     C     DACODE        Chain     AACODE
039800020507     C                   If        Not %Found(AACODE)
039900020507     C                   Movel(P)  Msg(12)       @EMSG
040000020507     C                   End
040100000217     C                   MOVE      *BLANKS       @CODE
040200000216     C                   MOVE      TC            @CODE
040300000216     C     @CODEKEY      CHAIN     CODESR
040400000217     C*
040500000216     C                   EXSR      $VALDATE
040600000217     C*
040700000216     C                   SELECT
040800000217     C                   WHEN      TNAME = *BLANKS
040900000216     C                   MOVEL(P)  MSG(3)        @EMSG
041000000216     C                   WHEN      TDESCR = *BLANKS
041100000216     C                   MOVEL(P)  MSG(4)        @EMSG
041200000216     C                   WHEN      PTADL1 = *BLANKS OR PTADL2 = *BLANKS OR
041300000216     C                             PTADL3 = *BLANKS
041400000216     C                   MOVEL(P)  MSG(5)        @EMSG
041500000217     C                   WHEN      NOT %FOUND(CODES)
041600000216     C                   MOVEL(P)  MSG(6)        @EMSG
041700000222     C*                  WHEN      STLOSS = *ZERO
041800000222     C*                  MOVEL(P)  MSG(7)        @EMSG
041900000216     C                   WHEN      @GD = '1'
042000000216     C                   MOVEL(P)  MSG(8)        @EMSG
042100010322     C                   WHEN      TRNBIL <> 'Y' AND TRNBIL <> ' ' AND
042200010322     C                             TRNBIL <> 'N'
042300000217     C                   MOVEL(P)  MSG(9)        @EMSG
042400000217     C                   WHEN      TRDLTD <> 'A' AND TRDLTD <> 'C' AND
042500000217     C                             TRDLTD <> 'D'
042600000217     C                   MOVEL(P)  MSG(10)       @EMSG
042700000216     C                   ENDSL
042800000217     C*
042900041118     C                   If        WSEFDT <> *Zeros    And
043000041118     C                             FREMTH =  *Zeros
043100041118     C                   Movel(P)  Msg(14)       @EMSG
043200041118     C                   End
043300041118     C*
043400041118     C                   If        FREMTH >  12
043500041118     C                   Movel(P)  Msg(14)       @EMSG
043600041118     C                   End
043700041118     C*
043800041118     C                   If        WSEFDT <> *Zeros    And
043900041118     C                             BEGMTH =  *Zeros
044000041118     C                   Movel(P)  Msg(15)       @EMSG
044100041118     C                   End
044200041118     C*
044300041118     C                   If        BEGMTH >  12
044400041118     C                   Movel(P)  Msg(15)       @EMSG
044500041118     C                   End
044600041118     C*
044700041118     C                   If        WSEFDT =  *Zeros    And
044800041118     C                             BEGMTH <> *Zeros
044900041118     C                   Movel(P)  Msg(16)       @EMSG
045000041118     C                   End
045100041118     C*
045200041118     C                   If        WSEFDT =  *Zeros    And
045300041118     C                             FREMTH <> *Zeros
045400041118     C                   Movel(P)  Msg(16)       @EMSG
045500041118     C                   End
045600041118     C*
045700000217     C                   IF        @EMSG = *BLANKS
045800000920     C                   IF        I2CNTDT <> 0
045900000920     C                   MOVE      I2CNTDT       #USA
046000000920     C                   MOVE      #USA          #ISO
046100000920     C                   MOVE      #ISO          CONTDT
046200000920     C                   ELSE
046300000920     C                   MOVE      *ZEROS        CONTDT
046400000920     C                   ENDIF
046500041118szz  C     WSEFDT        Mult      10000.0001    EFFDT
046600000217     C                   MOVEL(P)  'O'           TSCODE
046700000217     C                   MOVE      TC            TSCODE
046800041118szz  C                   If        @UWSUP  = 'W'
046900041118     C                   Z-add     TRTRST        TSTRST
047000041118szz  C                   WRITE     TRSSUR
047100041118szz  C                   Else
047200041118szz  C                   UPDATE    TRSSUR
047300041118szz  C                   End
047400000217     C                   IF        @UPDWRT = 'W'
047500041118     C                   WRITE     TRSMSR
047600001026     C                   EXSR      $ADDHIST
047700000217     C                   MOVEL(P)  'STEP1'       @STEP
047800000217     C                   MOVEL(P)  'REC ADDED'   @EMSG
047900180108     C****               If        tscode = 'O N'
048000180108     c                   If        tscode = 'O N' or tscode = 'O M'
048100200113     c                             or tscode = 'O D'
048200120425     C                   MOVE      TRUST#        SDNewTrs          3
048300180110     C                   MOVE      tscode        parmtscode1       1
048400120425     C                   Call      'SDNEWTC'
048500120425001  C                   Parm                    SDNewTrs
048600180110001  C                   Parm                    parmtscode1
048700120425     C                   End
048800000217     C                   ELSE
048900000217     C                   UPDATE    TRSMSR
049000001026     C                   EXSR      $CHGHIST
049100020507     C                   Exsr      $ChgCobra
049200000217     C                   MOVEL(P)  'REC CHANGED' @EMSG
049300001122     C                   MOVEL(P)  'STEP2'       @STEP
049400000217     C                   ENDIF
049500000217     C                   ENDIF
049600000217     C*
049700000217     C                   ENDSR
049800000222     C*
049900000222     C     $ADDHIST      BEGSR
050000000222     C*
050100000222     C                   EXSR      $TSTAMP
050200000222     C*
050300000222     C                   Z-ADD     TRTRST        HTRST
050400000222     C*
050500000222     C                   MOVEL(P)  TNAME         HATNAME
050600000222     C                   MOVEL(P)  TDESCR        HATDESCR
050700000222     C                   MOVEL(P)  PTADL1        HAPTADL1
050800000222     C                   MOVEL(P)  PTADL2        HAPTADL2
050900000222     C                   MOVEL(P)  PTADL3        HAPTADL3
051000000222     C                   MOVEL(P)  PTADL4        HAPTADL4
051100000222     C                   Z-ADD     STLOSS        HASTLOSS
051200000222     C                   MOVE      TRNBIL        HATRNBIL
051300000222     C                   MOVEL(P)  TSCODE        HATSCODE
051400000222     C                   MOVE      TRDLTD        HATRDLTD
051500000222     C                   Z-ADD     CONTDT        HACONTDT
051600000222     C*
051700000222     C                   WRITE     RTRMHIST
051800000222     C*
051900000222     C                   ENDSR
052000000217     C*
052100000222     C     $TSTAMP       BEGSR
052200000222     C*
052300000222     C                   CLEAR                   @TIMESTAMP
052400000222     C                   MOVE      *BLANKS       @TS40
052500000222     C                   CALL      'TIMESTMP'
052600000222     C                   PARM                    @TS40
052700000222     C                   MOVEL     @TS40         @TIMESTAMP
052800000222     C                   MOVEL     @TSUSER       HUSERID
052900000222     C                   MOVE      #TSCYMD       HDATE
053000000222     C                   MOVE      #TSTIME       HTIME
053100000222     C                   MOVEL     @TSJOB        HJOB
053200000222     C                   MOVE      #TSNBR        HNUMBER
053300000222     C*
053400000222     C                   ENDSR
053500000222     C*
053600020507     C     $ChgCobra     BEGSR
053700020507     C*
053800020507     C     TRUST#        Chain     COBRAAA
053900020507     C                   If        %Found(COBRAAA)
054000020507     C                   Movel     DACODE        CACODE
054100020507     C                   Update    COBRAR
054200020507     C                   Else
054300020507     C                   Movel     DACODE        CACODE
054400020507     C                   Z-add     TRUST#        CTRST
054500020507     C                   Write     COBRAR
054600020507     C                   End
054700020507     C*
054800020507     C                   ENDSR
054900020507     C*
055000000222     C     $CHGHIST      BEGSR
055100000222     C*
055200000222     C                   EXSR      $TSTAMP
055300000222     C*
055400001020     C                   MOVE      '0'           @WRITE            1
055500000222     C                   IF        TNAME <> HBTNAME
055600000222     C                   MOVEL(P)  TNAME         HATNAME
055700001020     C                   MOVE      '1'           @WRITE
055800000222     C                   ENDIF
055900000222     C                   IF        TDESCR <> HBTDESCR
056000000222     C                   MOVEL(P)  TDESCR        HATDESCR
056100001020     C                   MOVE      '1'           @WRITE
056200000222     C                   ENDIF
056300000222     C                   IF        PTADL1 <> HBPTADL1
056400000222     C                   MOVEL(P)  PTADL1        HAPTADL1
056500001020     C                   MOVE      '1'           @WRITE
056600000222     C                   ENDIF
056700000222     C                   IF        PTADL2 <> HBPTADL2
056800000222     C                   MOVEL(P)  PTADL2        HAPTADL2
056900001020     C                   MOVE      '1'           @WRITE
057000000222     C                   ENDIF
057100000222     C                   IF        PTADL3 <> HBPTADL3
057200000222     C                   MOVEL(P)  PTADL3        HAPTADL3
057300001020     C                   MOVE      '1'           @WRITE
057400000222     C                   ENDIF
057500000222     C                   IF        PTADL4 <> HBPTADL4
057600000222     C                   MOVEL(P)  PTADL4        HAPTADL4
057700001020     C                   MOVE      '1'           @WRITE
057800000222     C                   ENDIF
057900000222     C                   IF        STLOSS <> HBSTLOSS
058000000222     C                   Z-ADD     STLOSS        HASTLOSS
058100001020     C                   MOVE      '1'           @WRITE
058200000222     C                   ENDIF
058300000222     C                   IF        TRNBIL <> HBTRNBIL
058400000222     C                   MOVE      TRNBIL        HATRNBIL
058500001020     C                   MOVE      '1'           @WRITE
058600000222     C                   ENDIF
058700000222     C                   IF        TSCODE <> HBTSCODE
058800000222     C                   MOVEL(P)  TSCODE        HATSCODE
058900001020     C                   MOVE      '1'           @WRITE
059000000222     C                   ENDIF
059100000222     C                   IF        TRDLTD <> HBTRDLTD
059200000222     C                   MOVE      TRDLTD        HATRDLTD
059300001020     C                   MOVE      '1'           @WRITE
059400000222     C                   ENDIF
059500000222     C                   IF        CONTDT <> HBCONTDT
059600000222     C                   Z-ADD     CONTDT        HACONTDT
059700001020     C                   MOVE      '1'           @WRITE
059800000222     C                   ENDIF
059900000222     C*
060000001020     C                   IF        @WRITE = '1'
060100000222     C                   WRITE     RTRMHIST
060200001020     C                   ENDIF
060300000222     C*
060400000222     C                   ENDSR
060500000217     C*
060600000216     C     $VALDATE      BEGSR
060700000217     C*
060800000920     C                   IF        I2CNTDT <> 0
060900000920     C                   MOVE      I2CNTDT       #USA
061000000920     C                   MOVE      #USA          #ISO
061100000920     C                   MOVE      #ISO          #8                8 0
061200000920     C                   MOVE      #8            @CYMD
061300000920     C                   ELSE
061400000920     C                   MOVE      *ZEROS        @CYMD
061500000920     C                   ENDIF
061600041118szz  C                   If        WSEFDT >  *Zero
061700041118szz  C     WSEFDT        Mult      10000.0001    EFFDT
061800041118szz  C                   End
061900000217     C*
062000000216     C                   IF        (#CY > 1950 AND #CY < 2050) AND
062100000216     C                             (#MM > 0 AND #MM < 13) AND
062200000216     C                             (#DD > 0 AND #DD < 32)
062300000216     C                   MOVE      '0'           @GD
062400000216     C                   ELSE
062500000216     C                   MOVE      '1'           @GD
062600000216     C                   ENDIF
062700000217     C*
062800000216     C                   ENDSR
062900000217     C*
063000000217     C*
063100000217     C*
063200000217     C*
063300910215**   ERROR MESSAGE ARRAY
063400000216TRUST # CODE IS INVALID
063500000216INQUIRY MODE - THIS TRUST HAS BEEN DELETED
063600000216TRUST NAME CANNOT BE BLANK
063700000216TRUST DESCRIPTION CANNOT BE BLANK
063800000216PAYABLE INFO LINES 1-3 MUST BE COMPLETED
063900000216INVALID TRUST CATEGORY
064000000216STOP LOSS CANNOT BE ZERO
064100000216CONTRACT DATE CANNOT BE ZERO
064200010322TRANSMIT BILL MUST BE Y,N,BLANK
064300000216STATUS CODE (A, C, OR D)
064400010108NO SELECTION MADE
064500020507AA Code is not on file. Please enter AA Code.
064600021010PRESS F6 TO REACTIVATE TRUST.
064700041118Frequency must be a valid month between 1-12.
064800041118Beginning month must be between 1-12.
064900041118Enter effective date for exception frequency.
