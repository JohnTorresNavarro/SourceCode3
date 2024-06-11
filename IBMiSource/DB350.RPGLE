0001009211230002 F******************************************************************
0002009909300003 F* DB350      GROUP BENEFIT SERVICES SOFTWARE           1992      *
0003009211230007 F*                                                                *
0004009211230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009211230006 F*            DATE - 11/23/92                                     *
0006009211230007 F*                                                                *
0007009211230006 F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE A  LISTING OF ALL     *
0008009211230007 F*                DUPLICATE COMMISSION CONTROL RECORDS IN COMCTX  *
0009009211230008 F*                                                                *
0010009707030008 F*  7/97 - SELECT ALL ACTIVE, NON ZZZ RECORDS                     *
0011009811110008 F* 11/11/98 DLW CHANGE DATE POSITIONING IN CMCT14 -Y2K COMPLIANT. *
0012000101180008 F* 01/18/01 SSK CHANGE RCD LEN TO COMPLY WITH NEW FORMAT          *
0012010103300008 F* 03/30/01 change to look for overlapping dates                  *
0012020506100008 F* 06/10/05 add relid to sort/break                               *
0013009707030008 F*                                                                *
0014009211230009 F******************************************************************
0015009211230010 F*                                                                *
001600050610     Fcomctx    IP   e             DISK
001700921123     FREPORT    O    F  132        PRINTER OFLIND(*INOF)
002601010330     D ERR             S             45    DIM(3) CTDATA PERRCD(1)
0026020103300053 D                UDS
0026030103300054 D  CONAME               201    240
0026040103300055 D  TIME                 242    247  0
002605010330     Icomcxr
0026060103300018 I                                          cmtrst        l1
0026070103300018 I                                          csubdv        l1
0026080103300018 I                                          cmacct        l1
0026090103300018 I                                          cmplan        l1
0026100103300021 I                                          slsman        l1
0026110506100021 I                                          cmrelid       l1
002612010330     c* when cancelled the cancel date should be >= effective date
002613010330
002614010330     C                   if        cmcan <> 0
002615010330     C                   if        cmcan < effdat
002616010330     C                   Z-ADD     1             X                 1 0
002617010330     C                   ADD       1             CNT               5 0
002618050610     C                   exsr      #dates
002619010330     C                   EXCEPT    ERROR
002620010330     C                   END
002621010330     C*
002622010330     C                   ELSE
002623010330     C                   ADD       1             NUMACT            2 0
002624010330     C                   END
002625010330
002626050610     C* ON PLAN/SMAN/relid CHANGE - SKIP CHECK FOR PREVIOUS PLAN
002627010330     C                   if        *inl1 = *off
002629010330     C* ENROLL DATE MUST BE >= PREVIOUS CANCEL DATE TO BE VALID
002631010330     c                   if        effdat < savcan
002632010330     C                   Z-ADD     2             X                 1 0
002633010330     C                   ADD       1             CNT
002635050610     c                   exsr      #dates
002643010330     C                   EXCEPT    ERROR
002644010330     C                   END
002646010330     C                   end
002647010330     C* SAVE cancel date
002649010330     C                   MOVE      cmcan         SAVcan            8 0
002650010330     C*
002651050610     C* ONLY 1 RECORD PER PLAN/sman/relid CAN BE ACTIVE AT ONCE
002652010330     C*
002653010330     CL1                 if        numact > 1
002654010330     CL1                 Z-ADD     3             X
002655010330     CL1                 ADD       1             CNT
002656050610     CL1                 exsr      #dates
002657010330     CL1                 EXCEPT    ERROR
002658010330     CL1                 END
002659010330     CL1                 clear                   NUMACT
0026600506100107 C*
0026610506100103 C***************************************************
0026620506100104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0026630506100105 C***************************************************
0026640506100107 C*
0026650506100107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0026660506100107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0026670506100107 C*
0026680506100106 C     #DATYM        BEGSR
002669050610     C                   MOVE      @DATIN        @MD               4 0
002670050610     C                   MOVEL     @DATIN        @Y                4 0
002671050610     C                   MOVEL     @MD           @DATOU            8 0
002672050610     C                   MOVE      @Y            @DATOU
002673050610     C                   MOVE      *ZEROS        @DATIN            8 0
0026740506100120 C                   ENDSR
0026750506100107 C*
0026760506100120 C     #dates        begsr
002677050610     C                   MOVE      effdat        @DATIN
002678050610     C                   EXSR      #DATYM
002679050610     C                   MOVE      @DATOU        effdatmdy         8 0
002680050610     C                   MOVE      cmcan         @DATIN
002681050610     C                   EXSR      #DATYM
002682050610     C                   MOVE      @DATOU        cmcanmdy          8 0
0026830506100120 C                   ENDSR
002684050610
0041009211230237 OREPORT    H    1P                     2 03
0042009211230238 O         OR    OF
0043009211230239 O                                           44 '*****'
0044009211230240 O                       CONAME              85
0045009211230241 O                                           91 '*****'
0046009211230242 O          H    1P                     1
0047009211230243 O         OR    OF
0048009211230244 O                                           66 'COMMISSION CONTROL AUDIT'
0049009211230245 O                                           86 ' FOR DUPLICATE PLANS'
0051009211230246 O          H    1P                     1
0052009211230247 O         OR    OF
0053009211230248 O                                           24 'PROGRAM NAME: DB350'
0054009211230249 O                                          122 'PAGE :'
0055009211230250 O                       PAGE          Z    131
0056009211230251 O          H    1P                     1
0057009211230252 O         OR    OF
0058009211230253 O                                           14 'RUN DATE:'
0059009811110254 O                       *DATE         Y     27
0060009211230255 O                                          122 'TIME :'
0061009211300256 O                       TIME               131 '  :  :  '
0062009211230257 O          H    1P                     1
0063009211230258 O         OR    OF
0064009211230259 O                                           24 '""""""""""""""""""""""""'
0065009211230260 O                                           48 '""""""""""""""""""""""""'
0066009211230261 O                                           72 '""""""""""""""""""""""""'
0067009211230262 O                                           96 '""""""""""""""""""""""""'
0068009211230263 O                                          120 '""""""""""""""""""""""""'
0069009211230264 O                                          132 '""""""""""""'
0070009211230265 O          H    1P                     1
0071009211230266 O         OR    OF
007200921123     O                                           14 'TRUST-SUB-ACCT'
007300921123     O                                           21 'PLAN'
007301010330     O                                           28 'SMAN'
0073020506100134 O                                           38 'REL ID'
0073030506100134 O                                           53 'ENROLL'
0073040506100135 O                                           68 'CANCEL'
0073050506100136 O                                           77 'ERROR'
0074009211230279 O          H    1P                     2
0075009211230280 O         OR    OF
0076009211230281 O                                           24 '""""""""""""""""""""""""'
0077009211230282 O                                           48 '""""""""""""""""""""""""'
0078009211230283 O                                           72 '""""""""""""""""""""""""'
0079009211230284 O                                           96 '""""""""""""""""""""""""'
0080009211230285 O                                          120 '""""""""""""""""""""""""'
0081009211230286 O                                          132 '""""""""""""'
0082000103300265 O          E            error          1
008300010330     O                       cmtrst               3
008400921130     O                                            4 '-'
008500010330     O                       csubdv               7
008600921130     O                                            8 '-'
008700010330     O                       cmacct              12
008800010330     O                       cmplan              21
008801010330     O                       slsman              28
008802050610     O                       cmrelid             38
0088030506100151 O                       effdatmdy           53 '  /  /    '
0088040506100152 O                       cmcanmdy            68 '  /  /    '
008805050610     O                       ERR(X)             117                             000045
0089009211300265 O          T    LR                  1
009000010330     O                                           16 'TOTAL ERRORS :'
0092000103300158 O                       CNT           Z     25
009300010330** ERROR TABLE
009400010330ENROLL DATE GREATER THAN CANCEL DATE
009500010330ENROLL DATE LESS THAN PREVIOUS CANCEL DATE
009600050610MULTIPLE ACTIVE PLANS PER SALESMAN / RELATION
