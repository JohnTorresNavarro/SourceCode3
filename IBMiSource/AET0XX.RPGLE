000100101026   X***X
000200110512     ** WORK ARRAY FOR PLANS
000300110512     **
000400110512     ** PC# - PLAN COUNT
000500110512     ** PP# - PLAN POINTER
000600110512     **
000700110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
000800110512     D                                     OCCURS(50) PREFIX(X:1)
000900110512     D PC#             S              3S 0
001000110512     D PP#             S              3S 0
001100110512     D @PLANIN         S              4A
001200110512     D @CCTRIN         S              3A
001300121005     D ENR@IN          S              3A
001400121005     D ENR@OUT         S              1A
001500110513   X***X
001600110513    ***
001700110512     C                   EVAL      @PLANIN = MCPLAN
001800111020     C                   EVAL      ENR@IN = MCOVTP
001900110802    ***
002000110802     C                   EXSR      $QUIK
002100110802    ***
002200110512   S***S
002300110802     C     $QUIK         BEGSR
002400110802    ***
002500110805     C                   EVAL      @CCTRIN = *BLANKS
002600120803    ***
002700120803     C     AE1MAP        CASEQ     '2TIER     '  $METH01
002800120803     C     AE1MAP        CASEQ     'ITOBJECTS '  $METH02
002900120803     C     AE1MAP        CASEQ     'NORULE    '  $METH03
003000120803     C     AE1MAP        CASEQ     'STATETIER '  $METH04
003100120803     C     AE1MAP        CASEQ     'TIERSTS   '  $METH05
003200120803     C     AE1MAP        CASEQ     'MAYOR     '  $METH06
003300120803     C     AE1MAP        CASEQ     'EMPSTS    '  $METH07
003400120803     C     AE1MAP        CASEQ     'JUSTSTATE '  $METH08
003500120803     C     AE1MAP        CASEQ     'JOHNLS    '  $METH09
003600120803     C     AE1MAP        CASEQ     'CREATIVE  '  $METH10
003700120803     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
003800120803     C     AE1MAP        CASEQ     'STSTATE   '  $METH12
003900120803     C                   ENDCS
004000120803    ***
004100120803     C                   ENDSR
004200120803   S***S
004300120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
004400120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
004500120803    ***  DEPENDENTS HAVE 'FAM' ONLY
004600120803    ***
004700120803    *** IND, FAM
004800120803    ***
004900120803     C     $METH01       BEGSR
005000120803    ***
005100120803     C                   IF        WRT@TYPE = 'MEMBER'
005200120803    *** *
005300120803     C                   IF        ENR@IN = 'TIN'
005400120803     C                   EVAL      @CCTRIN = 'IND'
005500120803     C                   ELSE
005600120803     C                   EVAL      @CCTRIN = 'FAM'
005700120803     C                   ENDIF
005800120803    *** *
005900120803     C                   ENDIF
006000120803    ***
006100120803     C                   IF        WRT@TYPE = 'DEPEND'
006200120803    *** *
006300120803     C                   EVAL      @CCTRIN = 'FAM'
006400120803    *** *
006500120803     C                   ENDIF
006600120803    ***
006700120803     C                   ENDSR
006800120803   S***S
006900120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
007000120803    ***
007100120803    *** VA, OH, XX
007200120803    ***
007300120803     C     $METH02       BEGSR
007400120803    ***
007500120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
007600120803     C                   EVAL      @CCTRIN = 'XX '
007700120803     C                   ELSE
007800120803     C                   EVAL      @CCTRIN = STATE
007900120803     C                   ENDIF
008000120803    ***
008100120803     C                   ENDSR
008200120803   S***S
008300120803    *** NORULE = NUFF SAID
008400120803    ***
008500120803     C     $METH03       BEGSR
008600120803    ***
008700120803     C                   EVAL      @CCTRIN = *BLANKS
008800120803    ***
008900120803     C                   ENDSR
009000120803   S***S
009100120803    *** STATETIER
009200120803    ***  START WITH STATE CODE
009300120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
009400120803    ***  DEPENDENTS HAVE 'F' ONLY
009500120803    ***
009600120803    *** MDI, MDF, ETC...
009700120803    ***
009800120803     C     $METH04       BEGSR
009900120803    ***
010000120803     C                   EVAL      @CCTRIN = STATE
010100120803    ***
010200120803     C                   IF        WRT@TYPE = 'MEMBER'
010300120803     C                   IF        ENR@IN = 'TIN'
010400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
010500120803     C                   ELSE
010600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
010700120803     C                   ENDIF
010800120803     C                   ENDIF
010900120803    ***
011000120803     C                   IF        WRT@TYPE = 'DEPEND'
011100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
011200120803     C                   ENDIF
011300120803    ***
011400120803     C                   ENDSR
011500120803   S***S
011600120803    *** TIERSTS
011700120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
011800120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
011900120803    ***  DEPENDENTS HAVE 'F' ONLY
012000120803    ***
012100120803    *** ACI, ACF, COI, COF
012200120803    ***
012300120803     C     $METH05       BEGSR
012400120803    ***
012500120803     C                   IF        EMPST =  'C'
012600120803     C                   EVAL      @CCTRIN = 'COB'
012700120803     C                   ELSE
012800120803     C                   EVAL      @CCTRIN = 'ACT'
012900120803     C                   ENDIF
013000120803    ***
013100120803     C                   IF        ENR@IN = 'TIN'
013200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
013300120803     C                   ELSE
013400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
013500120803     C                   ENDIF
013600120803    ***
013700120803     C                   ENDSR
013800120803   S***S
013900120803    *** MAYOR
014000120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
014100120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
014200120803    ***
014300120803    ***  WVI, WVF, IND, FAM
014400120803    ***
014500120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
014600120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
014700120803    ***
014800120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
014900120803    ***
015000120803    ***
015100120803     C     $METH06       BEGSR
015200120803    ***
015300120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
015400120803      *
015500120803    2C                   IF        STATE = 'WV'
015600120803      **
015700120803    3C                   IF        ENR@IN = 'TIN'
015800120803     C                   EVAL      @CCTRIN = 'WVI'
015900120803    3C                   ELSE
016000120803     C                   EVAL      @CCTRIN = 'WVF'
016100120803    3C                   ENDIF
016200120803      **
016300120803    2C                   ELSE
016400120803      **
016500120803    3C                   IF        ENR@IN = 'TIN'
016600120803     C                   EVAL      @CCTRIN = 'IND'
016700120803    3C                   ELSE
016800120803     C                   EVAL      @CCTRIN = 'FAM'
016900120803    3C                   ENDIF
017000120803      **
017100120803    2C                   ENDIF
017200120803      *
017300120803     C                   LEAVESR
017400120803    1C                   ENDIF
017500120803    ***
017600120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
017700120803      *
017800120803     C                   IF        STATE = 'WV'
017900120803     C                   EVAL      @CCTRIN = 'WVF'
018000120803     C                   ELSE
018100120803     C                   EVAL      @CCTRIN = 'FAM'
018200120803     C                   ENDIF
018300120803      *
018400120803     C                   LEAVESR
018500120803     C                   ENDIF
018600120803    ***
018700120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
018800120803      *
018900120803    2C                   IF        STATE = 'WV'
019000120803      **
019100120803    3C                   IF        ENR@IN = 'TIN'
019200120803     C                   EVAL      @CCTRIN = 'WVI'
019300120803    3C                   ELSE
019400120803     C                   EVAL      @CCTRIN = 'WVF'
019500120803    3C                   ENDIF
019600120803      **
019700120803    2C                   ELSE
019800120803      **
019900120803    3C                   IF        EMPST =  'C'
020000120803     C                   EVAL      @CCTRIN = 'CB '
020100120803    3C                   ELSE
020200120803     C                   EVAL      @CCTRIN = 'AC '
020300120803    3C                   ENDIF
020400120803    3C                   IF        ENR@IN = 'TIN'
020500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
020600120803    3C                   ELSE
020700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
020800120803    3C                   ENDIF
020900120803      **
021000120803    2C                   ENDIF
021100120803      *
021200120803     C                   LEAVESR
021300120803    1C                   ENDIF
021400120803    ***
021500120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
021600120803      *
021700120803     C                   IF        STATE = 'WV'
021800120803     C                   EVAL      @CCTRIN = 'WVF'
021900120803     C                   ELSE
022000120803     C                   IF        EMPST =  'C'
022100120803     C                   EVAL      @CCTRIN = 'CBF'
022200120803     C                   ELSE
022300120803     C                   EVAL      @CCTRIN = 'ACF'
022400120803     C                   ENDIF
022500120803     C                   ENDIF
022600120803      *
022700120803     C                   ENDIF
022800120803    ***
022900120803     C                   ENDSR
023000120803   S***S
023100120803    *** EMPSTS
023200120803    ***   PRETTY STRAIGHT FORWARDED
023300120803    ***
023400120803     C     $METH07       BEGSR
023500120803    ***
023600120803     C                   IF        EMPST =  'C'
023700120803     C                   EVAL      @CCTRIN = 'COB'
023800120803     C                   ELSE
023900120803     C                   EVAL      @CCTRIN = 'ACT'
024000120803     C                   ENDIF
024100120803    ***
024200120803     C                   ENDSR
024300120803   S***S
024400120803    *** JUSTSTATE
024500120803    ***   PRETTY STRAIGHT FORWARDED
024600120803    ***
024700120803     C     $METH08       BEGSR
024800120803    ***
024900120803     C                   EVAL      @CCTRIN = STATE
025000120803    ***
025100120803     C                   ENDSR
025200120803   S***S
025300120803    *** JOHNLS
025400120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
025500120803    ***
025600120803    *** MDI, MDF, XXI, XXF
025700120803    ***
025800120803     C     $METH09       BEGSR
025900120803    ***
026000120803     C                   IF        WRT@TYPE = 'MEMBER'
026100120803     C                   IF        STATE = 'MD'
026200120803     C                   EVAL      @CCTRIN = 'MD'
026300120803     C                   ELSE
026400120803     C                   EVAL      @CCTRIN = 'XX'
026500120803     C                   ENDIF
026600120803     C                   IF        ENR@IN = 'TIN'
026700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
026800120803     C                   ELSE
026900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
027000120803     C                   ENDIF
027100120803     C                   ENDIF
027200120803    ***
027300120803     C                   IF        WRT@TYPE = 'DEPEND'
027400120803     C                   IF        STATE = 'MD'
027500120803     C                   EVAL      @CCTRIN = 'MDF'
027600120803     C                   ELSE
027700120803     C                   EVAL      @CCTRIN = 'XXF'
027800120803     C                   ENDIF
027900120803     C                   ENDIF
028000120803    ***
028100120803     C                   ENDSR
028200120803   S***S
028300120803    *** CREATIVE
028400120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
028500120803    ***
028600120803    *** MD, OK, **
028700120803    ***
028800120803     C     $METH10       BEGSR
028900120803    ***
029000120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
029100120803     C                   EVAL      @CCTRIN = '** '
029200120803     C                   ELSE
029300120803     C                   EVAL      @CCTRIN = STATE
029400120803     C                   ENDIF
029500120803    ***
029600120803     C                   ENDSR
029700120803   S***S
029800120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
029900120803    ***
030000120803    ***  TN, XX
030100120803    ***
030200120803     C     $METH11       BEGSR
030300120803    ***
030400120803     C                   IF        STATE <> 'TN'
030500120803     C                   EVAL      @CCTRIN = 'XX '
030600120803     C                   ELSE
030700120803     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
030800120803     C                   ENDIF
030900120803    ***
031000120803     C                   ENDSR
031100120803   S***S
031200120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
031300120803    ***
031400120803    ***  MDA, MDC, ETC...
031500120803    ***
031600120803     C     $METH12       BEGSR
031700120803    ***
031800120803     C                   EVAL      @CCTRIN = STATE + EMPST
031900120803    ***
032000120803     C                   ENDSR
032100120803   S***S
032200121005    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
032300121005    ***    ACTIVE = 0   COBRA = 500
032400121005    ***    IND = +0   NON-IND COVERAGE = +100
032500121005    ***    EACH STATE IS GIVEN A NUMBER = AK IS 1, ETC...
032600121005    ***
032700121005    ***  001, 559, ETC...
032800121005    ***
032900121005     C     $METH13       BEGSR
033000121005    ***
033100121005     C                   SELECT
033200121005     C                   WHEN      EMPST =  'C'
033300121005     C                   Z-ADD     500           #CALC
033400121005     C                   OTHER
033500121005     C                   MOVE      *ZEROS        #CALC             3 0
033600121005     C                   ENDSL
033700121005    ***
033800121005     C                   SELECT
033900121005     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
034000121005     C                   ADD       000           #CALC
034100121005     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
034200121005     C                   ADD       100           #CALC
034300121005     C                   WHEN      WRT@TYPE = 'DEPEND'
034400121005     C                   ADD       100           #CALC
034500121005     C                   ENDSL
034600121005    ***
034700121005     C                   SELECT
034800121005     C                   WHEN      STATE = 'AK'
034900121005     C                   ADD       001           #CALC
035000121005     C                   WHEN      STATE = 'AL'
035100121005     C                   ADD       002           #CALC
035200121005     C                   WHEN      STATE = 'AR'
035300121005     C                   ADD       003           #CALC
035400121005     C                   WHEN      STATE = 'AS'
035500121005     C                   ADD       004           #CALC
035600121005     C                   WHEN      STATE = 'AZ'
035700121005     C                   ADD       005           #CALC
035800121005     C                   WHEN      STATE = 'CA'
035900121005     C                   ADD       006           #CALC
036000121005     C                   WHEN      STATE = 'CO'
036100121005     C                   ADD       007           #CALC
036200121005     C                   WHEN      STATE = 'CT'
036300121005     C                   ADD       008           #CALC
036400121005     C                   WHEN      STATE = 'DC'
036500121005     C                   ADD       009           #CALC
036600121005     C                   WHEN      STATE = 'DE'
036700121005     C                   ADD       010           #CALC
036800121005     C                   WHEN      STATE = 'FL'
036900121005     C                   ADD       011           #CALC
037000121005     C                   WHEN      STATE = 'FM'
037100121005     C                   ADD       012           #CALC
037200121005     C                   WHEN      STATE = 'GA'
037300121005     C                   ADD       013           #CALC
037400121005     C                   WHEN      STATE = 'GU'
037500121005     C                   ADD       014           #CALC
037600121005     C                   WHEN      STATE = 'HI'
037700121005     C                   ADD       015           #CALC
037800121005     C                   WHEN      STATE = 'IA'
037900121005     C                   ADD       016           #CALC
038000121005     C                   WHEN      STATE = 'ID'
038100121005     C                   ADD       017           #CALC
038200121005     C                   WHEN      STATE = 'IL'
038300121005     C                   ADD       018           #CALC
038400121005     C                   WHEN      STATE = 'IN'
038500121005     C                   ADD       019           #CALC
038600121005     C                   WHEN      STATE = 'KS'
038700121005     C                   ADD       020           #CALC
038800121005     C                   WHEN      STATE = 'KY'
038900121005     C                   ADD       021           #CALC
039000121005     C                   WHEN      STATE = 'LA'
039100121005     C                   ADD       022           #CALC
039200121005     C                   WHEN      STATE = 'MA'
039300121005     C                   ADD       023           #CALC
039400121005     C                   WHEN      STATE = 'MD'
039500121005     C                   ADD       024           #CALC
039600121005     C                   WHEN      STATE = 'ME'
039700121005     C                   ADD       025           #CALC
039800121005     C                   WHEN      STATE = 'MH'
039900121005     C                   ADD       026           #CALC
040000121005     C                   WHEN      STATE = 'MI'
040100121005     C                   ADD       027           #CALC
040200121005     C                   WHEN      STATE = 'MN'
040300121005     C                   ADD       028           #CALC
040400121005     C                   WHEN      STATE = 'MO'
040500121005     C                   ADD       029           #CALC
040600121005     C                   WHEN      STATE = 'MP'
040700121005     C                   ADD       030           #CALC
040800121005     C                   WHEN      STATE = 'MS'
040900121005     C                   ADD       031           #CALC
041000121005     C                   WHEN      STATE = 'MT'
041100121005     C                   ADD       032           #CALC
041200121005     C                   WHEN      STATE = 'NC'
041300121005     C                   ADD       033           #CALC
041400121005     C                   WHEN      STATE = 'ND'
041500121005     C                   ADD       034           #CALC
041600121005     C                   WHEN      STATE = 'NE'
041700121005     C                   ADD       035           #CALC
041800121005     C                   WHEN      STATE = 'NH'
041900121005     C                   ADD       036           #CALC
042000121005     C                   WHEN      STATE = 'NJ'
042100121005     C                   ADD       037           #CALC
042200121005     C                   WHEN      STATE = 'NM'
042300121005     C                   ADD       038           #CALC
042400121005     C                   WHEN      STATE = 'NV'
042500121005     C                   ADD       039           #CALC
042600121005     C                   WHEN      STATE = 'NY'
042700121005     C                   ADD       040           #CALC
042800121005     C                   WHEN      STATE = 'OH'
042900121005     C                   ADD       041           #CALC
043000121005     C                   WHEN      STATE = 'OK'
043100121005     C                   ADD       042           #CALC
043200121005     C                   WHEN      STATE = 'OR'
043300121005     C                   ADD       043           #CALC
043400121005     C                   WHEN      STATE = 'PA'
043500121005     C                   ADD       044           #CALC
043600121005     C                   WHEN      STATE = 'PR'
043700121005     C                   ADD       045           #CALC
043800121005     C                   WHEN      STATE = 'PW'
043900121005     C                   ADD       046           #CALC
044000121005     C                   WHEN      STATE = 'RI'
044100121005     C                   ADD       047           #CALC
044200121005     C                   WHEN      STATE = 'SC'
044300121005     C                   ADD       048           #CALC
044400121005     C                   WHEN      STATE = 'SD'
044500121005     C                   ADD       049           #CALC
044600121005     C                   WHEN      STATE = 'TN'
044700121005     C                   ADD       050           #CALC
044800121005     C                   WHEN      STATE = 'TX'
044900121005     C                   ADD       051           #CALC
045000121005     C                   WHEN      STATE = 'UT'
045100121005     C                   ADD       052           #CALC
045200121005     C                   WHEN      STATE = 'VA'
045300121005     C                   ADD       053           #CALC
045400121005     C                   WHEN      STATE = 'VI'
045500121005     C                   ADD       054           #CALC
045600121005     C                   WHEN      STATE = 'VT'
045700121005     C                   ADD       055           #CALC
045800121005     C                   WHEN      STATE = 'WA'
045900121005     C                   ADD       056           #CALC
046000121005     C                   WHEN      STATE = 'WI'
046100121005     C                   ADD       057           #CALC
046200121005     C                   WHEN      STATE = 'WV'
046300121005     C                   ADD       058           #CALC
046400121005     C                   WHEN      STATE = 'WY'
046500121005     C                   ADD       059           #CALC
046600121005     C                   ENDSL
046700121005    ***
046800121005     C                   MOVE      #CALC         @CCTRIN
046900121005    ***
047000121005     C                   ENDSR
047100121005   S***S
