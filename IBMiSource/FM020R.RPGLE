000100000216     F*********************************************************************
000200000217     F* FM020      - SUBDIVISION MASTER MAINTENANCE                       *
000300000216     F*                                                                   *
000400000217     F* ORIGINALLY WRITTEN BY MICHAEL C. DUNPHY  7/20/88                  *
000500000216     F*                       GROUP BENEFIT SERVICES SOFTWARE 1988        *
000600000216     F*                                                                   *
000700000216     F* REWRITTEN BY  STEPHEN KING  2/16/2000                             *
000800000216     F*               INNOVATIVE OUTSOURCING  2000                        *
000900000216     F*                                                                   *
001000000216     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
001100000217     F*            SUBDIVISION MASTER FILE (ADD CHANGE DELETE).           *
001200000216     F*                                                                   *
001300000216     F*********************************************************************
001400000216     F* MODIFICATION HISTORY                                              *
001500000216     F* ### UUU CCYYMMDD X-->                                             *
001600000216     F* 000 SSK 20000216 REWRITE TO NATIVE AS/400                         *
001700001019     F* 001 SSK 20001019 ADD STUFF                                        *
001800010109     F* 002 SSK 20010109 ADD WINDOW INQUIRIES                             *
001900180108     F*     RLJ 20180108 Add logic for Advanced Mobile Dental            *
002000010109     F*                                                                   *
002100010109     F*                                                                   *
002200000216     F*********************************************************************
002300000428     FFM020D    CF   E             WORKSTN INFDS(WSDS)
002400000217     FSUBMST    UF A E           K DISK
002500000217     FTRSMST    IF   E           K DISK
002600000223     FSUBHIST0  O  A E             DISK
002700000216     ***
002800000223      *
002900000223    *** TIMESTAMP FIELDS DATA STRUCTURE
003000000223      *
003100000223     D @TIMESTAMP      DS
003200000223     D  #TSCYMD                1      8S 0
003300000223     D  #TSTIME                9     14S 0
003400000223     D  @TSJOB                15     24
003500000223     D  @TSUSER               25     34
003600000223     D  #TSNBR                35     40S 0
003700000223     ***
003800000216     D WSDS            DS
003900000216     D  FKEY                 369    369A
004000000216     ***
004100000216     D  F1             C                   CONST(X'31')
004200000216     D  F2             C                   CONST(X'32')
004300000216     D  F3             C                   CONST(X'33')
004400000216     D  F4             C                   CONST(X'34')
004500000216     D  F5             C                   CONST(X'35')
004600000216     D  F6             C                   CONST(X'36')
004700000216     D  F7             C                   CONST(X'37')
004800000216     D  F8             C                   CONST(X'38')
004900000216     D  F9             C                   CONST(X'39')
005000000216     D  F10            C                   CONST(X'3A')
005100000216     D  F11            C                   CONST(X'3B')
005200000216     D  F12            C                   CONST(X'3C')
005300000216     D  F13            C                   CONST(X'B1')
005400000216     D  F14            C                   CONST(X'B2')
005500000216     D  F15            C                   CONST(X'B3')
005600000216     D  F16            C                   CONST(X'B4')
005700000216     D  F17            C                   CONST(X'B5')
005800000216     D  F18            C                   CONST(X'B6')
005900000216     D  F19            C                   CONST(X'B7')
006000000216     D  F20            C                   CONST(X'B8')
006100000216     D  F21            C                   CONST(X'B9')
006200000216     D  F22            C                   CONST(X'BA')
006300000216     D  F23            C                   CONST(X'BB')
006400000216     D  F24            C                   CONST(X'BC')
006500000216     ***
006600010109     D MSG             S             45    DIM(9) CTDATA PERRCD(1)
006700000216     ***
006800000216     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
006900000216     D                UDS
007000000216     D  TITLE                201    240
007100000216     ***
007200000216     C                   DOU       @STEP = 'EXIT'
007300000216     C     @STEP         CASEQ     'STEP1 '      $STEP1
007400000216     C     @STEP         CASEQ     'STEP2 '      $STEP2
007500000216     C     @STEP         CASEQ     'STEP3 '      $STEP3
007600000216     C     @STEP         CASEQ     'STEP4 '      $STEP4
007700000216     C                   ENDCS
007800000216     C                   ENDDO
007900000216     C*
008000000216     C                   MOVE      *ON           *INLR
008100000216     C*
008200000216     C     *INZSR        BEGSR
008300000217     C                   MOVE      'STEP1 '      @STEP             6
008400000217     C                   MOVE      *BLANKS       @EMSG            45
008500000217     C     *LIKE         DEFINE    SBTRST        #TRSKEY
008600000217     C     *LIKE         DEFINE    SBSUB#        #SUBKEY
008700000217     C     @KEYSUB       KLIST
008800000217     C                   KFLD                    #TRSKEY
008900000217     C                   KFLD                    #SUBKEY
009000000217     C                   MOVE      *BLANKS       @UPDWRT           1
009100000217     C                   MOVE      '0'           @GD               1
009200000217     C*
009300000216     C                   ENDSR
009400000216     C*
009500000216     C     $STEP1        BEGSR
009600000216     C*
009700000216     C                   MOVEL(P)  @EMSG         SMSG
009800000216     C                   EXFMT     IO01
009900000216     C                   MOVE      *BLANKS       @EMSG
010000000216     C*
010100000216     C                   IF        FKEY = F7
010200000216     C                   MOVEL(P)  'EXIT'        @STEP
010300000216     C                   LEAVESR
010400000216     C                   ENDIF
010500010109     C*
010600010109    1C                   IF        FKEY = F9
010700010109     C                   MOVE      TRUST#        @3                3
010800010109     C                   CALL      'FM006CL'
010900010109     C                   PARM                    @3
011000010109    2C                   IF        @3 = '*LR'
011100010109     C                   MOVEL(P)  MSG(9)        @EMSG
011200010109     C                   LEAVESR
011300010109    2C                   ELSE
011400010109     C                   MOVE      @3            TRUST#
011500010109     C                   MOVE      @3            #TRSKEY
011600010109    2C                   ENDIF
011700010109    1C                   ENDIF
011800000217     C*
011900081216    2C                   eval      *in35 = '0'
012000000217     C                   Z-ADD     TRUST#        #TRSKEY
012100000223     C     #TRSKEY       CHAIN(N)  TRSMSR
012200000217     C                   IF        NOT %FOUND(TRSMST)
012300000217     C                   MOVEL(P)  MSG(1)        @EMSG
012400000217     C                   LEAVESR
012500000217     C                   ENDIF
012600010109     C*
012700010109    1C                   IF        FKEY = F11
012800010109     C                   MOVE      TRUST#        @3
012900010109     C                   MOVEL(P)  @3            @6                6
013000010109     C                   CALL      'FM007CL'
013100010109     C                   PARM                    @6
013200010109     C                   MOVE      *BLANKS       @3
013300010109     C                   MOVE      @6            @3
013400010109    2C                   IF        @3 = '*LR'
013500010109     C                   MOVEL(P)  MSG(9)        @EMSG
013600010109     C                   LEAVESR
013700010109     C                   ELSE
013800010109     C                   MOVE      @3            #SUBKEY
013900010109     C                   MOVE      @3            SUB#
014000010109    2C                   ENDIF
014100010109    1C                   ENDIF
014200000216     C*
014300000217     C                   IF        SUB# = 0
014400000217     C                   MOVEL(P)  MSG(2)        @EMSG
014500000216     C                   LEAVESR
014600000216     C                   ENDIF
014700000216     C*
014800000216     C                   MOVEL(P)  'STEP2'       @STEP
014900000223     C                   Z-ADD     TRUST#        SBTRST
015000000223     C                   Z-ADD     SUB#          SBSUB#
015100000223     C                   Z-ADD     TRUST#        #TRSKEY
015200000223     C                   Z-ADD     SUB#          #SUBKEY
015300000216     C*
015400000216     C                   ENDSR
015500000216     C*
015600000216     C     $STEP2        BEGSR
015700000223     C*
015800000223     C                   CLEAR                   RSUBHIST
015900000223     C                   Z-ADD     SBTRST        HTRST
016000000223     C                   Z-ADD     SBSUB#        HSUB
016100000216     C*
016200000217     C     @KEYSUB       CHAIN     SUBMSR
016300000216     C*
016400000217     C                   IF        %FOUND(SUBMST)
016500000217     C                   MOVE      'U'           @UPDWRT
016600000216     C*
016700000223     C                   MOVEL     SUBNAM        HBSUBNAM
016800000223     C                   MOVEL     SUBDSC        HBSUBDSC
016900000223     C                   MOVEL     IH1T          HBIH1T
017000000223     C                   MOVEL     IH1B          HBIH1B
017100000223     C                   MOVEL     IH2T          HBIH2T
017200000223     C                   MOVEL     IH2B          HBIH2B
017300000223     C                   MOVEL     IH3T          HBIH3T
017400000223     C                   MOVEL     IH3B          HBIH3B
017500000223     C                   MOVEL     IH4T          HBIH4T
017600000223     C                   MOVEL     IH4B          HBIH4B
017700000223     C                   MOVEL     IH5T          HBIH5T
017800000223     C                   MOVEL     IH5B          HBIH5B
017900000223     C                   MOVEL     IH6T          HBIH6T
018000000223     C                   MOVEL     IH6B          HBIH6B
018100000223     C                   MOVEL     IH7T          HBIH7T
018200000223     C                   MOVEL     IH7B          HBIH7B
018300000223     C                   MOVEL     IH8T          HBIH8T
018400000223     C                   MOVEL     IH8B          HBIH8B
018500000223     C                   MOVEL     IH9T          HBIH9T
018600000223     C                   MOVEL     IH9B          HBIH9B
018700000223     C                   Z-ADD     SADMFE        HBSADMFE
018800000223     C                   Z-ADD     AFICOL        HBAFICOL
018900000223     C                   Z-ADD     COMFEE        HBCOMFEE
019000000223     C                   Z-ADD     GRCPRD        HBGRCPRD
019100000223     C                   MOVEL     IDVARY        HBIDVARY
019200000223     C                   Z-ADD     DUEDAY        HBDUEDAY
019300000223     C                   MOVE      SBDLTD        HBSBDLTD
019400000223     C*
019500001019     C                   MOVEL     SUBNAM        HASUBNAM
019600001019     C                   MOVEL     SUBDSC        HASUBDSC
019700001019     C                   MOVEL     IH1T          HAIH1T
019800001019     C                   MOVEL     IH1B          HAIH1B
019900001019     C                   MOVEL     IH2T          HAIH2T
020000001019     C                   MOVEL     IH2B          HAIH2B
020100001019     C                   MOVEL     IH3T          HAIH3T
020200001019     C                   MOVEL     IH3B          HAIH3B
020300001019     C                   MOVEL     IH4T          HAIH4T
020400001019     C                   MOVEL     IH4B          HAIH4B
020500001019     C                   MOVEL     IH5T          HAIH5T
020600001019     C                   MOVEL     IH5B          HAIH5B
020700001019     C                   MOVEL     IH6T          HAIH6T
020800001019     C                   MOVEL     IH6B          HAIH6B
020900001019     C                   MOVEL     IH7T          HAIH7T
021000001019     C                   MOVEL     IH7B          HAIH7B
021100001019     C                   MOVEL     IH8T          HAIH8T
021200001019     C                   MOVEL     IH8B          HAIH8B
021300001019     C                   MOVEL     IH9T          HAIH9T
021400001019     C                   MOVEL     IH9B          HAIH9B
021500001019     C                   Z-ADD     SADMFE        HASADMFE
021600001019     C                   Z-ADD     AFICOL        HAAFICOL
021700001019     C                   Z-ADD     COMFEE        HACOMFEE
021800001019     C                   Z-ADD     GRCPRD        HAGRCPRD
021900001019     C                   MOVEL     IDVARY        HAIDVARY
022000001019     C                   Z-ADD     DUEDAY        HADUEDAY
022100001019     C                   MOVE      SBDLTD        HASBDLTD
022200001019     C*
022300001020     C                   IF        SBDLTD = 'D'
022400001020     C                   MOVEL(P)  MSG(3)        @EMSG
022500001020     C                   MOVEL(P)  'STEP3'       @STEP
022600001020     C                   LEAVESR
022700001020     C                   ENDIF
022800001020     C*
022900000216     C                   ELSE
023000000216     C*
023100000217     C                   CLEAR                   SUBMSR
023200000217     C                   MOVE      'W'           @UPDWRT
023300000216     C*
023400000216     C                   ENDIF
023500000216     C*
023600000216     C                   MOVEL(P)  'STEP4'       @STEP
023700000216     C*
023800000216     C                   ENDSR
023900000216     C*
024000000223     C     $TSTAMP       BEGSR
024100000223     C*
024200000223     C                   CLEAR                   @TIMESTAMP
024300000223     C                   MOVE      *BLANKS       @TS40            40
024400000223     C                   CALL      'TIMESTMP'
024500000223     C                   PARM                    @TS40
024600000223     C                   MOVEL     @TS40         @TIMESTAMP
024700000223     C                   MOVEL     @TSUSER       HUSERID
024800000223     C                   MOVE      #TSCYMD       HDATE
024900000223     C                   MOVE      #TSTIME       HTIME
025000000223     C                   MOVEL     @TSJOB        HJOB
025100000223     C                   MOVE      #TSNBR        HNUMBER
025200000223     C                   ENDSR
025300000223     C*
025400000216     C     $STEP3        BEGSR
025500000216     C*
025600000216     C                   MOVEL(P)  @EMSG         SMSG
025700000217     C                   EXFMT     IO03
025800000216     C*
025900000216     C                   SELECT
026000000216     C*
026100000216     C                   WHEN      FKEY = F1
026200000216     C                   MOVEL(P)  'STEP1'       @STEP
026300000216     C                   MOVE      *BLANKS       @EMSG
026400000216     C                   LEAVESR
026500000223     C*
026600000223     C                   WHEN      FKEY = F5
026700000223     C                   MOVEL     SBTRST        @P1               6
026800000223     C                   MOVE      SBSUB#        @P1
026900000901     C                   CALL      'FM021R'
027000000223     C                   PARM                    @P1
027100000223     C                   LEAVESR
027200000217     C*
027300000217     C                   WHEN      FKEY = F6
027400000217     C                   MOVE      'A'           SBDLTD
027500000223     C                   MOVE      SBDLTD        HASBDLTD
027600000223     C                   EXSR      $TSTAMP
027700000223     C                   WRITE     RSUBHIST
027800000217     C                   UPDATE    SUBMSR
027900000217     C                   MOVEL(P)  'STEP1'       @STEP
028000000217     C                   MOVEL(P)  'REC NOW ACTV'@EMSG
028100000217     C                   LEAVESR
028200000217     C*
028300000216     C                   WHEN      FKEY = F7
028400000216     C                   MOVEL(P)  'EXIT'        @STEP
028500000216     C                   LEAVESR
028600000216     C*
028700000216     C                   ENDSL
028800000216     C*
028900000216     C                   ENDSR
029000000216     C*
029100000216     C     $STEP4        BEGSR
029200081216      *
029300081216    2C                   eval      *in35 = '0'
029400180108     C                   If        tscode = 'O N' or tscode = 'O M'
029500081216    2C                   eval      *in35 = '1'
029600081216    2C                   ENDIF
029700081216      *
029800000216     C                   MOVEL(P)  @EMSG         SMSG
029900000216     C                   EXFMT     IO02
030000000216     C                   MOVE      *BLANKS       @EMSG
030100000216     C*
030200000216     C                   SELECT
030300000216     C*
030400000216     C                   WHEN      FKEY = F1
030500000216     C                   MOVEL(P)  'STEP1'       @STEP
030600000216     C                   MOVE      *BLANKS       @EMSG
030700000216     C                   LEAVESR
030800000216     C*
030900000217     C                   WHEN      FKEY = F4
031000000217     C                   MOVE      'D'           SBDLTD
031100000223     C                   MOVE      SBDLTD        HASBDLTD
031200000223     C                   EXSR      $TSTAMP
031300000223     C                   WRITE     RSUBHIST
031400000217     C                   UPDATE    SUBMSR
031500000217     C                   MOVEL(P)  'STEP1'       @STEP
031600000217     C                   MOVEL(P)  'REC INACTIVE'@EMSG
031700000217     C                   LEAVESR
031800000217     C*
031900000223     C                   WHEN      FKEY = F5
032000000223     C                   MOVEL     SBTRST        @P1
032100000223     C                   MOVE      SBSUB#        @P1
032200000901     C                   CALL      'FM021R'
032300000223     C                   PARM                    @P1
032400000223     C                   LEAVESR
032500000223     C*
032600000216     C                   WHEN      FKEY = F7
032700000216     C                   MOVEL(P)  'EXIT'        @STEP
032800000216     C                   LEAVESR
032900081216      *
033000081216     C                   WHEN      FKEY = F12
033100180108     C                   If        tscode = 'O N' or tscode = 'O M'
033200081216     C                   MOVEL     SBTRST        @P1
033300081216     C                   MOVE      SBSUB#        @P1
033400081216     C                   CALL      'FM022CL'
033500081216     C                   PARM                    @P1
033600081216     C                   LEAVESR
033700081216     C                   ENDIF
033800081216      *
033900000216     C*
034000000216     C                   ENDSL
034100000216     C*
034200000216     C                   EXSR      $VALID
034300000217     C*
034400000216     C                   ENDSR
034500000217     C*
034600000217     C     $VALID        BEGSR
034700000217     C*
034800000216     C                   EXSR      $VALDATE
034900000217     C*
035000000216     C                   SELECT
035100000217     C                   WHEN      SUBNAM = *BLANKS
035200000217     C                   MOVEL(P)  MSG(4)        @EMSG
035300000217     C                   WHEN      SUBDSC = *BLANKS
035400000217     C                   MOVEL(P)  MSG(5)        @EMSG
035500000216     C                   WHEN      @GD = '1'
035600000217     C                   MOVEL(P)  MSG(6)        @EMSG
035700000217     C                   WHEN      GRCPRD = 0
035800000217     C                   MOVEL(P)  MSG(7)        @EMSG
035900000217     C                   WHEN      DUEDAY < 1 OR DUEDAY > 31
036000000217     C                   MOVEL(P)  MSG(8)        @EMSG
036100000216     C                   ENDSL
036200000217     C*
036300000217     C                   IF        @EMSG = *BLANKS
036400000223     C*                  Z-ADD     COMMFEE       COMFEE
036500000217     C                   IF        @UPDWRT = 'W'
036600000217     C                   Z-ADD     TRUST#        SBTRST
036700000217     C                   Z-ADD     SUB#          SBSUB#
036800000217     C                   MOVE      'A'           SBDLTD
036900000223     C                   EXSR      $MOVAFTR
037000000223     C                   EXSR      $TSTAMP
037100000223     C                   WRITE     RSUBHIST
037200000217     C                   WRITE     SUBMSR
037300000217     C                   MOVEL(P)  'STEP1'       @STEP
037400000217     C                   MOVEL(P)  'REC ADDED'   @EMSG
037500000217     C                   ELSE
037600000223     C                   EXSR      $MOVAFTR2
037700000223     C                   EXSR      $TSTAMP
037800000223     C                   WRITE     RSUBHIST
037900000217     C                   UPDATE    SUBMSR
038000000217     C                   MOVEL(P)  'REC CHANGED' @EMSG
038100001122     C                   MOVEL(P)  'STEP2'       @STEP
038200000217     C                   ENDIF
038300000217     C                   ENDIF
038400000217     C*
038500000217     C                   ENDSR
038600000217     C*
038700000223     C     $MOVAFTR      BEGSR
038800000223     C*
038900000223     C                   MOVEL     SUBNAM        HASUBNAM
039000000223     C                   MOVEL     SUBDSC        HASUBDSC
039100000223     C                   MOVEL     IH1T          HAIH1T
039200000223     C                   MOVEL     IH1B          HAIH1B
039300000223     C                   MOVEL     IH2T          HAIH2T
039400000223     C                   MOVEL     IH2B          HAIH2B
039500000223     C                   MOVEL     IH3T          HAIH3T
039600000223     C                   MOVEL     IH3B          HAIH3B
039700000223     C                   MOVEL     IH4T          HAIH4T
039800000223     C                   MOVEL     IH4B          HAIH4B
039900000223     C                   MOVEL     IH5T          HAIH5T
040000000223     C                   MOVEL     IH5B          HAIH5B
040100000223     C                   MOVEL     IH6T          HAIH6T
040200000223     C                   MOVEL     IH6B          HAIH6B
040300000223     C                   MOVEL     IH7T          HAIH7T
040400000223     C                   MOVEL     IH7B          HAIH7B
040500000223     C                   MOVEL     IH8T          HAIH8T
040600000223     C                   MOVEL     IH8B          HAIH8B
040700000223     C                   MOVEL     IH9T          HAIH9T
040800000223     C                   MOVEL     IH9B          HAIH9B
040900000223     C                   Z-ADD     SADMFE        HASADMFE
041000000223     C                   Z-ADD     AFICOL        HAAFICOL
041100000223     C                   Z-ADD     COMFEE        HACOMFEE
041200000223     C                   Z-ADD     GRCPRD        HAGRCPRD
041300000223     C                   MOVEL     IDVARY        HAIDVARY
041400000223     C                   Z-ADD     DUEDAY        HADUEDAY
041500000223     C                   MOVE      SBDLTD        HASBDLTD
041600000223     C*
041700000223     C                   ENDSR
041800000217     C*
041900000223     C     $MOVAFTR2     BEGSR
042000000223     C*
042100000223     C                   IF        SUBNAM <> HBSUBNAM
042200000223     C                   MOVEL     SUBNAM        HASUBNAM
042300000223     C                   ENDIF
042400000223     C                   IF        SUBDSC <> HBSUBDSC
042500000223     C                   MOVEL     SUBDSC        HASUBDSC
042600000223     C                   ENDIF
042700000223     C                   IF        IH1T <> HBIH1T
042800000223     C                   MOVEL     IH1T          HAIH1T
042900000223     C                   ENDIF
043000000223     C                   IF        IH1B <> HBIH1B
043100000223     C                   MOVEL     IH1B          HAIH1B
043200000223     C                   ENDIF
043300000223     C                   IF        IH2T <> HBIH2T
043400000223     C                   MOVEL     IH2T          HAIH2T
043500000223     C                   ENDIF
043600000223     C                   IF        IH2B <> HBIH2B
043700000223     C                   MOVEL     IH2B          HAIH2B
043800000223     C                   ENDIF
043900000223     C                   IF        IH3T <> HBIH3T
044000000223     C                   MOVEL     IH3T          HAIH3T
044100000223     C                   ENDIF
044200000223     C                   IF        IH3B <> HBIH3B
044300000223     C                   MOVEL     IH3B          HAIH3B
044400000223     C                   ENDIF
044500000223     C                   IF        IH4T <> HBIH4T
044600000223     C                   MOVEL     IH4T          HAIH4T
044700000223     C                   ENDIF
044800000223     C                   IF        IH4B <> HBIH4B
044900000223     C                   MOVEL     IH4B          HAIH4B
045000000223     C                   ENDIF
045100000223     C                   IF        IH5T <> HBIH5T
045200000223     C                   MOVEL     IH5T          HAIH5T
045300000223     C                   ENDIF
045400000223     C                   IF        IH5B <> HBIH5B
045500000223     C                   MOVEL     IH5B          HAIH5B
045600000223     C                   ENDIF
045700000223     C                   IF        IH6T <> HBIH6T
045800000223     C                   MOVEL     IH6T          HAIH6T
045900000223     C                   ENDIF
046000000223     C                   IF        IH6B <> HBIH6B
046100000223     C                   MOVEL     IH6B          HAIH6B
046200000223     C                   ENDIF
046300000223     C                   IF        IH7T <> HBIH7T
046400000223     C                   MOVEL     IH7T          HAIH7T
046500000223     C                   ENDIF
046600000223     C                   IF        IH7B <> HBIH7B
046700000223     C                   MOVEL     IH7B          HAIH7B
046800000223     C                   ENDIF
046900000223     C                   IF        IH8T <> HBIH8T
047000000223     C                   MOVEL     IH8T          HAIH8T
047100000223     C                   ENDIF
047200000223     C                   IF        IH8B <> HBIH8B
047300000223     C                   MOVEL     IH8B          HAIH8B
047400000223     C                   ENDIF
047500000223     C                   IF        IH9T <> HBIH9T
047600000223     C                   MOVEL     IH9T          HAIH9T
047700000223     C                   ENDIF
047800000223     C                   IF        IH9B <> HBIH9B
047900000223     C                   MOVEL     IH9B          HAIH9B
048000000223     C                   ENDIF
048100000223     C                   IF        SADMFE <> HBSADMFE
048200000223     C                   Z-ADD     SADMFE        HASADMFE
048300000223     C                   ENDIF
048400000223     C                   IF        AFICOL <> HBAFICOL
048500000223     C                   Z-ADD     AFICOL        HAAFICOL
048600000223     C                   ENDIF
048700000223     C                   IF        COMFEE <> HBCOMFEE
048800000223     C                   Z-ADD     COMFEE        HACOMFEE
048900000223     C                   ENDIF
049000000223     C                   IF        GRCPRD <> HBGRCPRD
049100000223     C                   Z-ADD     GRCPRD        HAGRCPRD
049200000223     C                   ENDIF
049300000223     C                   IF        IDVARY <> HBIDVARY
049400000223     C                   MOVEL     IDVARY        HAIDVARY
049500000223     C                   ENDIF
049600000223     C                   IF        DUEDAY <> HBDUEDAY
049700000223     C                   Z-ADD     DUEDAY        HADUEDAY
049800000223     C                   ENDIF
049900000223     C                   IF        SBDLTD <> HBSBDLTD
050000000223     C                   MOVE      SBDLTD        HASBDLTD
050100000223     C                   ENDIF
050200000223     C*
050300000223     C                   ENDSR
050400000217     C*
050500000216     C     $VALDATE      BEGSR
050600000217     C*
050700000217     C                   IF        (SADMFE = 0 AND AFICOL > 0) OR
050800000217     C                             (SADMFE <> 0 AND AFICOL < 1) OR
050900000217     C                             AFICOL > 9
051000000217     C                   MOVE      '1'           @GD
051100000216     C                   ELSE
051200000217     C                   MOVE      '0'           @GD
051300000216     C                   ENDIF
051400000217     C*
051500000216     C                   ENDSR
051600000217     C*
051700000217     C*
051800000217     C*
051900000217     C*
052000910215**   ERROR MESSAGE ARRAY
052100000216TRUST # CODE IS INVALID
052200000217SUBDIVISION # CANNOT BE ZERO
052300000217INQUIRY MODE - PRESS F6 TO REACTIVATE
052400000217SUB NAME CANNOT BE BLANK
052500000217SUB DESCRIPTION CANNOT BE BLANK
052600000217INVALID ADMIN FEE/COL
052700000223GRACE PERIOD CANNOT BE ZERO
052800000217DUE DAY MUST BE BETWEEN 1 AND 31
052900010109NO SELECTION MADE
