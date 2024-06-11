000100010412      *? ***************************************************************
000200020515      * FM060_1R - ACCOUNT MASTER INQUIRY
000300020513      *   WRITTEN by Terry Powers  05/13/02
000400010412      *
000500020515      *? Description: display FUNCTION KEYS
000600010417
000700010416      *? ***************************************************************
000800020515     FFI060_1D  CF   E             WORKSTN
000900010412     F                                      INDDS(INDICATORS)
001000010412
001100020515     D SCREEN          S              8A                                        CONTROL VARIABLE
001200020715     D STATUS          S              3                                         CONTROL VARIABLE
001201070822     D parmletA        s              1a   inz('A')
001202070822     D parmletB        s              1a   inz('B')
001203070822     D parmacnam1      s             40a   inz(*blanks)
001204070822
001205070822     D                 DS
001206070822     D @@TSA                   1     10A
001207070822     D  I_TRST                 1      3S 0
001208070822     D  I_SUB#                 4      6S 0
001209070822     D  I_ACCT                 7     10S 0
001210070822
0013000104120030 D INDICATORS      DS            99
0014000206200019 D F1_BACK                01     01N   INZ('0')
001500020618     D F2                     02     02N   INZ('0')
001600020618     D F3                     03     03N   INZ('0')
001700020618     D F4                     04     04N   INZ('0')
0018000206180019 D F5                     05     05N   INZ('0')
0019000206180019 D F6                     06     06N   INZ('0')
0020000205240019 D F7_EXIT                07     07N   INZ('0')
0021000206180019 D F8                     08     08N   INZ('0')
0022000206180019 D F9                     09     09N   INZ('0')
0023000206180019 D F10                    10     10N   INZ('0')
0024000206180019 D F11                    11     11N   INZ('0')
0025000206180019 D F12                    12     12N   INZ('0')
0026000206180019 D F13_NEXT               13     13N   INZ('0')
002700020516
002800020516     D                 DS
002900020516     D AREA                         100
003000020516     D  TRST_E                        3    OVERLAY(AREA)
003100020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003200020516     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003300020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003400020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003500020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003600020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003700020716     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003800020517     D                UDS
003900020620     D  APPL_E                 1      1
004000020517     D  CONAME               201    240
004100010412
004200010412      *? ***************************************************************
004300020514     C                   SELECT
004400020515     C                   WHEN      SCREEN = 'CF3     '
004500020515     C                   EXSR      CF3_SR
004600020618     C                   WHEN      SCREEN = 'CF13    '
004700020618     C                   EXSR      CF13_SR
004800020619     C                   WHEN      SCREEN = 'FKEYS   '
004900020619     C                   EXSR      FKEYS_SR
005000020619     C                   WHEN      SCREEN = 'FKEYS2  '
005100020619     C                   EXSR      FKEYS2_SR
005200020515     C                   WHEN      SCREEN = 'TRSTINQ '
005300020515     C                   EXSR      TRSTINQ_SR
005400020515     C                   WHEN      SCREEN = 'SUBINQ  '
005500020515     C                   EXSR      SUBINQ_SR
005600020515     C                   WHEN      SCREEN = 'ACCTINQ '
005700030326     C                   EXSR      ACCTINQ_SR
005800020515     C                   WHEN      SCREEN = 'RELATED '
005900020515     C                   EXSR      RELATED_SR
006000020515     C                   WHEN      SCREEN = 'MARKET  '
006100020515     C                   EXSR      MARKET_SR
006200020515     C                   WHEN      SCREEN = 'SALESMAN'
006300020515     C                   EXSR      SALESMAN_SR
006400020716     C                   WHEN      SCREEN = 'CARR_ID '
006500020716     C                   EXSR      CARR_ID_SR
006600020515     C                   WHEN      SCREEN = 'PRIMARY '
006700020515     C                   EXSR      PRIMARY_SR
006800020515     C                   WHEN      SCREEN = 'COSTCTR '
006900020515     C                   EXSR      COSTCTR_SR
007000020528     C                   WHEN      SCREEN = 'ACCMKTSZ'
007100020528     C                   EXSR      ACCMKTSZ_SR
007200020528     C                   WHEN      SCREEN = 'COMMISS '
007300020528     C                   EXSR      COMMISS_SR
007301070822     C                   WHEN      SCREEN = 'AFOVER  '
007302070822     C                   EXSR      AFOVER_SR
007303070822     C                   WHEN      SCREEN = 'BDOVER  '
007304070822     C                   EXSR      BDOVER_SR
007400020618     C                   WHEN      SCREEN = 'PLANINQ '
007500020618     C                   EXSR      PLANINQ_SR
007600020620     C                   WHEN      SCREEN = 'GRATE   '
007700020620     C                   EXSR      GRATE_SR
007800020620     C                   WHEN      SCREEN = 'DECLIF  '
007900020620     C                   EXSR      DECLIF_SR
008000020716     C                   WHEN      SCREEN = 'CARRIER '
008100020716     C                   EXSR      CARRIER_SR
008200020716     C                   WHEN      SCREEN = 'AGENCY  '
008300020716     C                   EXSR      AGENCY_SR
008400020528     C                   WHEN      SCREEN = 'EXIT    '
008500020528     C                   EXSR      EXIT_SR
008600020514     C                   OTHER
008700020515     C                   EXSR      CF3_SR
008800020514     C                   ENDSL
008900010412
009000010412      *? ***************************************************************
009100020515     C     CF3_SR        BEGSR
009200020715
009300020715     C     *DTAARA       DEFINE    FI060A        AREA
009400020715     C     *LOCK         IN        AREA
009500020715     C                   MOVE      TRST_E        I_TRST
009600020715     C                   MOVE      SUB#_E        I_SUB#
009700020715     C                   MOVE      ACCT_E        I_ACCT
009800020716     C                   MOVE      SMAN_E        I_SMAN
009900020716     C                   MOVE      CARR_E        I_CARR
010000020716     C*                  MOVE      COST_E        W_COSTCTR
010100020715     C                   MOVE      PLAN_E        I_PLAN
010200020715     C                   MOVE      STAT_E        STATUS
010300020716     C                   MOVE      AGEN_E        I_AGEN
010400020715     C                   OUT       AREA
010500020716
010600020716     C                   IF        STATUS = 'F7 '
010700020716     C                   EVAL      SCREEN = 'EXIT    '
010800020716     C                   LEAVESR
010900020716     C                   END
011000010416
011100020515     C                   EXFMT     CF3
011200020515
011300020715     C                   IF        F1_BACK        = *ON
011400020715     C                   EVAL      STATUS = 'F1 '
011500020515     C                   EVAL      SCREEN = 'EXIT    '
011600020514     C                   LEAVESR
011700020514     C                   END
011800020715
011900020715     C                   IF        F7_EXIT        = *ON
012000020715     C                   EVAL      STATUS = 'F7 '
012100020715     C                   EVAL      SCREEN = 'EXIT    '
012200020715     C                   LEAVESR
012300020715     C                   END
012400020618      *?NEXT MENU                             **************************
012500020618     C                   IF        F13_NEXT    = *ON
012600020618     C                   EVAL      SCREEN = 'CF13    '
012700020618     C                   LEAVESR
012800020618     C                   END
012900020619     C                   EVAL      SCREEN = 'FKEYS   '
013000020716     C     *LOCK         IN        AREA
013100020716     C                   MOVE      I_TRST        TRST_E
013200020716     C                   MOVE      I_SUB#        SUB#_E
013300020716     C                   MOVE      I_ACCT        ACCT_E
013400020716     C                   MOVE      I_SMAN        SMAN_E
013500020716     C                   MOVE      I_CARR        CARR_E
013600020716     C*                  MOVE      COST_E        W_COSTCTR
013700020716     C                   MOVE      I_PLAN        PLAN_E
013800020716     C                   MOVE      STATUS        STAT_E
013900020716     C                   MOVE      I_AGEN        AGEN_E
014000020716     C                   OUT       AREA
014100010412
014200010606     C                   ENDSR
014300020618      *? ***************************************************************
014400020618     C     CF13_SR       BEGSR
014500020715     C     *LOCK         IN        AREA
014600020715     C                   MOVE      TRST_E        I_TRST
014700020715     C                   MOVE      SUB#_E        I_SUB#
014800020715     C                   MOVE      ACCT_E        I_ACCT
014900020716     C                   MOVE      SMAN_E        I_SMAN
015000020716     C                   MOVE      CARR_E        I_CARR
015100020716     C*                  MOVE      COST_E        W_COSTCTR
015200020715     C                   MOVE      PLAN_E        I_PLAN
015300020715     C                   MOVE      STAT_E        STATUS
015400020716     C                   MOVE      AGEN_E        I_AGEN
015500020715     C                   OUT       AREA
015600020716
015700020716     C                   IF        STATUS = 'F7 '
015800020716     C                   EVAL      SCREEN = 'EXIT    '
015900020716     C                   LEAVESR
016000020716     C                   END
016100020618
016200020618     C                   EXFMT     CF13
016300020618
016400020715     C                   IF        F1_BACK        = *ON
016500020618     C                   EVAL      SCREEN = 'EXIT    '
016600020715     C                   EVAL      STATUS = 'F1 '
016700020618     C                   LEAVESR
016800020618     C                   END
016900020715
017000020715     C                   IF        F7_EXIT        = *ON
017100020715     C                   EVAL      SCREEN = 'EXIT    '
017200020715     C                   EVAL      STATUS = 'F7 '
017300020715     C                   LEAVESR
017400020715     C                   END
017500020618      *?NEXT MENU                             **************************
017600020618     C                   IF        F13_NEXT       = *ON
017700020618     C                   EVAL      SCREEN = 'CF3     '
017800020618     C                   LEAVESR
017900020618     C                   END
018000020619     C                   EVAL      SCREEN = 'FKEYS2  '
018100020716     C     *LOCK         IN        AREA
018200020716     C                   MOVE      I_TRST        TRST_E
018300020716     C                   MOVE      I_SUB#        SUB#_E
018400020716     C                   MOVE      I_ACCT        ACCT_E
018500020716     C                   MOVE      I_SMAN        SMAN_E
018600020716     C                   MOVE      I_CARR        CARR_E
018700020716     C*                  MOVE      COST_E        W_COSTCTR
018800020716     C                   MOVE      I_PLAN        PLAN_E
018900020716     C                   MOVE      STATUS        STAT_E
019000020716     C                   MOVE      I_AGEN        AGEN_E
019100020716     C                   OUT       AREA
019200020618
019300020618     C                   ENDSR
019400010606
019500020514      *? ***************************************************************
019600020514     C     FKEYS_SR      BEGSR
019700020514     C                   SELECT
019800020515      *? TRUST INQUIRY                        **************************
019900020618     C                   WHEN      F2           = *ON
020000020515     C                   EVAL      SCREEN = 'TRSTINQ '
020100020515     C                   LEAVESR
020200020515      *? SUB   INQUIRY                        **************************
020300020618     C                   WHEN      F3           = *ON
020400020515     C                   EVAL      SCREEN = 'SUBINQ  '
020500020515     C                   LEAVESR
020600020515      *? ACCT  INQUIRY                        **************************
020700020618     C                   WHEN      F4           = *ON
020800020515     C                   EVAL      SCREEN = 'ACCTINQ '
020900020515     C                   LEAVESR
021000020514
021100020515      *? RELATED                              **************************
021200020618     C                   WHEN      F5           = *ON
021300020515     C                   EVAL      SCREEN = 'RELATED '
021400020514     C                   LEAVESR
021500020716      *?ACC MKT SIZE                          **************************
021600020716     C                   WHEN      F6           = *ON
021700020716     C                   EVAL      SCREEN = 'ACCMKTSZ'
021800020716     C                   LEAVESR
021900020716
022000020716      *?PRIMARY SCREEN                        **************************
022100020716     C                   WHEN      F8         = *ON
022200020716     C                   EVAL      SCREEN = 'PRIMARY '
022300020716     C                   LEAVESR
022400020716      *?COST CENTER                           **************************
022500020716     C                   WHEN      F9          = *ON
022600020716     C                   EVAL      SCREEN = 'COSTCTR '
022700020716     C                   LEAVESR
022800020716      *? COMMISSION CTL                       **************************
022900020716     C                   WHEN      F10         = *ON
023000020716     C                   EVAL      SCREEN = 'COMMISS '
023100020716     C                   LEAVESR
023101070822      *?Admin fee override
023102070822     C                   WHEN      F11         = *ON
023103070822     C                   EVAL      SCREEN = 'AFOVER  '
023104070822     C                   LEAVESR
023105070822      *?Bonus draw override
023106070822     C                   WHEN      F12         = *ON
023107070822     C                   EVAL      SCREEN = 'BDOVER  '
023108070822     C                   LEAVESR
023200020514
023300020515     C                   OTHER
023400020515     C                   EVAL      SCREEN = 'CF3   '
023500020514     C                   ENDSL
023600020514     C                   ENDSR
023700020618      *? ***************************************************************
023800020618     C     FKEYS2_SR     BEGSR
023900020618     C                   SELECT
024000020716
024100020716      *? SALESMAN                             **************************
024200020716     C                   WHEN      F2           = *ON
024300020716     C                   EVAL      SCREEN = 'SALESMAN'
024400020716     C                   LEAVESR
024500020618      *? PLAN INQ                             **************************
024600020618     C                   WHEN      F3          = *ON
024700020618     C                   EVAL      SCREEN = 'PLANINQ '
024800020618     C                   LEAVESR
024900020620      *? GRATE   INQ                          **************************
025000020618     C                   WHEN      F4          = *ON
025100020620     C                   EVAL      SCREEN = 'GRATE   '
025200020618     C                   LEAVESR
025300020620      *? DECLIF  INQ                          **************************
025400020620     C                   WHEN      F5          = *ON
025500020620     C                   EVAL      SCREEN = 'DECLIF  '
025600020620     C                   LEAVESR
025700020716
025800020716      *?CARR_ID SCREEN                        **************************
025900020716     C                   WHEN      F6         = *ON
026000020716     C                   EVAL      SCREEN = 'CARR_ID '
026100020716     C                   LEAVESR
026200020716
026300020716      *? MARKET   SCREEN                      **************************
026400020716     C                   WHEN      F8          = *ON
026500020716     C                   EVAL      SCREEN = 'MARKET  '
026600020716     C                   LEAVESR
026700020716
026800020716      *?CARRIER CODE                          **************************
026900020716     C                   WHEN      F9          = *ON
027000020716     C                   EVAL      SCREEN = 'CARRIER '
027100020716     C                   LEAVESR
027200030327      *? AGENCY                               **************************
027300030327     C                   WHEN      F11         = *ON
027400030327     C                   EVAL      SCREEN = 'AGENCY  '
027500030327     C                   LEAVESR
027600020620
027700020618     C                   OTHER
027800020618     C                   EVAL      SCREEN = 'CF13  '
027900020618     C                   ENDSL
028000020618     C                   ENDSR
028100020515      *? F2 ************************************************************
028200020515     C     TRSTINQ_SR    BEGSR
028300020515     C                   CALL      'FI006R'
028400020515     C                   EVAL      SCREEN = 'CF3   '
028500020515     C                   ENDSR
028600020515      *? F3 ************************************************************
028700020515     C     SUBINQ_SR     BEGSR
028800020515     C                   CALL      'FI007R'
028900020515     C                   EVAL      SCREEN = 'CF3   '
029000020515     C                   ENDSR
029100020515      *? F4 ************************************************************
029200030326     C     ACCTINQ_SR    BEGSR
029300030327     C                   EVAL      STAT_E = '   '
029400030326     C                   CALL      'FI008R'
029500030326     C     *LOCK         IN        AREA
029600030326     C                   MOVE      TRST_E        I_TRST
029700030326     C                   MOVE      SUB#_E        I_SUB#
029800030326     C                   MOVE      ACCT_E        I_ACCT
029900030327     C                   MOVE      STAT_E        STATUS
030000030326     C                   OUT       AREA
030100030327     C                   IF        STATUS = 'F1 '
030200030327     C                   EVAL      SCREEN = 'CF3   '
030300030327     C                   ELSE
030400030327     C                   EVAL      SCREEN = 'EXIT  '
030500030327     C                   END
030600030326     C                   ENDSR
030700020515      *? F5 ************************************************************
030800020515     C     RELATED_SR    BEGSR
030900020516     C                   CALL      'FI060_4R'
031000020515     C                   EVAL      SCREEN = 'CF3   '
031100020515     C                   ENDSR
031200020717      *? F6  ***********************************************************
031300020717     C     ACCMKTSZ_SR   BEGSR
031400020717     C                   CALL      'FI063R  '
031500020717     C                   EVAL      SCREEN = 'CF3   '
031600020717     C                   ENDSR
031700010503
031800020716      *? F8  ***********************************************************
031900020515     C     PRIMARY_SR    BEGSR
032000020517     C                   CALL      'FI062R'
032100020515     C                   EVAL      SCREEN = 'CF3   '
032200020515     C                   ENDSR
032300020716      *? F9  ***********************************************************
032400020716     C     COSTCTR_SR    BEGSR
032500020716     C                   CALL      'FI060_5R'
032600020716     C                   EVAL      SCREEN = 'CF3   '
032700020716     C                   ENDSR
032800020716      *? F10 ***********************************************************
032900020528     C     COMMISS_SR    BEGSR
033000020528     C                   CALL      'FI061R  '
033100020716     C                   EVAL      SCREEN = 'CF3   '
033200020528     C                   ENDSR
033201070822      *? F11 - first screen - admin fee override
033202070822     C     afover_sr     BEGSR
033205070822     C                   CALL      'FI064CL'
033206070822     C                   PARM                    parmletA
033207070822     C                   PARM                    @@TSA
033208070822     C                   PARM                    parmacnam1
033209070822     C                   EVAL      SCREEN = 'CF3   '
033210070822     C                   ENDSR
033211070822      *? F12 - first screen - bonus draw override
033212070822     C     bdover_sr     BEGSR
033214070822     C                   CALL      'FI064CL'
033215070822     C                   PARM                    parmletB
033216070822     C                   PARM                    @@TSA
033217070822     C                   PARM                    parmacnam1
033218070822     C                   EVAL      SCREEN = 'CF3   '
033219070822     C                   ENDSR
033300020716      *? F11 ***********************************************************
033400020716     C     AGENCY_SR     BEGSR
033500020716     C                   CALL      'FI120R  '
033600030327     C                   EVAL      SCREEN = 'CF13  '
033700020716     C                   ENDSR
033800020716      *? F2  ***********************************************************
033900020716     C     SALESMAN_SR   BEGSR
034000020716     C                   CALL      'FI003R'
034100020716     C                   EVAL      SCREEN = 'CF13  '
034200020716     C                   ENDSR
034300020618      *? F3  ***********************************************************
034400020618     C     PLANINQ_SR    BEGSR
034500020618     C                   CALL      'FI030R  '
034600020619     C                   EVAL      SCREEN = 'CF13  '
034700020618     C                   ENDSR
034800020618      *? F4  ***********************************************************
034900020620     C     GRATE_SR      BEGSR
035000020620     C                   CALL      'FI040R'
035100020619     C                   EVAL      SCREEN = 'CF13  '
035200020529     C                   ENDSR
035300020620      *? F5  ***********************************************************
035400020620     C     DECLIF_SR     BEGSR
035500020620     C                   CALL      'FI050R'
035600020620     C                   EVAL      SCREEN = 'CF13  '
035700020620     C                   ENDSR
035800020716      *? F6  ***********************************************************
035900020716     C     CARR_ID_SR    BEGSR
036000020716     C                   CALL      'FI060_3R'
036100020716     C                   EVAL      SCREEN = 'CF13  '
036200020716     C                   ENDSR
036300020717
036400020717      *? F8 ************************************************************
036500020717     C     MARKET_SR     BEGSR
036600020717     C                   CALL      'FI005R'
036700020717     C                   EVAL      SCREEN = 'CF13  '
036800020717     C                   ENDSR
036900020716
037000020716      *? F9  ***********************************************************
037100020716     C     CARRIER_SR    BEGSR
037200020716     C                   CALL      'FI080R'
037300020716     C                   EVAL      SCREEN = 'CF13  '
037400020716     C                   ENDSR
037500010503
037600010605      *? ***************************************************************
037700020514     C     EXIT_SR       BEGSR
037800020716
037900020716     C     *LOCK         IN        AREA
038000020716     C                   MOVE      I_TRST        TRST_E
038100020716     C                   MOVE      I_SUB#        SUB#_E
038200020716     C                   MOVE      I_ACCT        ACCT_E
038300020716     C                   MOVE      I_SMAN        SMAN_E
038400020716     C                   MOVE      I_CARR        CARR_E
038500020716     C*                  MOVE      W_COSTCTR     COST_E
038600020716     C                   MOVE      I_PLAN        PLAN_E
038700020716     C                   MOVE      STATUS        STAT_E
038800020716     C                   MOVE      I_AGEN        AGEN_E
038900020716     C                   OUT       AREA
039000010605     C                   EVAL      *INLR = *ON
039100010605     C                   RETURN
039200010605     C                   ENDSR
039300010412      *? **********************************************************
039400010412     C     *INZSR        BEGSR                                                  INITIAL SETUP
039500010416
039600020515     C                   EVAL      SCREEN = 'CF3     '
039700020517    *
039800020620     C                   IF        APPL_E = 'F'
039900020517     C                   EVAL      W_APPL = 'FULL'
040000020517     C                   ELSE
040100020517     C                   EVAL      W_APPL = 'SELF'
040200020517     C                   END
040300010416
040400010412     C                   ENDSR
