000100110812     H*DFTNAME(DB933)
0002009102150002 F******************************************************************
0003009907300003 F* DB933      GROUP BENEFIT SERVICES SOFTWARE           1990      *
0004009102150004 F*                                                                *
000500110812     F*            WRITTEN BY - DAVID KETTERMAN                        *
000600110812     F*            DATE - 07/30/99                                     *
000700110812     F*                                                                *
0008009102150007 F*                                                                *
000900110812     F*  DESCRIPTION - COPY OF DB932I FOR TR020CL TO RUN               *
0010009610080011 F*                                                                *
001100000615     F* 06/15/00 DLK - put userid in hist rec instead of "TR010"       *
001200010618     F* 06/18/01 DLK - ALLOW "AC" PLAN TYPE                            *
001300010703     F* 07/03/01 DLK - ALLOW "OA" PLAN TYPE                            *
001400011023     F* 10/23/01 DLK - ALLOW "BD" PLAN TYPE FOR MAGELLAN               *
001500030730     F* 07/30/03 DLK - ALLOW "CC" PLAN TYPE                            *
001600031222     F* 12/22/03 DLK - ALLOW "LS" & "SA" PLAN TYPE                     *
001700110519     F* 05/19/11 DLK - ALLOW AA, SP, SS, TL, NS & NE PLAN TYPES        *
002200110812      *                                                                *
002300110812      * 08/12/2011 SSK CONVERT S/36 TO NATIVE                          *
002400110912      *                ORIGINAL BENEFIT AMOUNT MODIFICATION            *
0027009102150012 F******************************************************************
002800110913     F* 09/13/2011 SSK   MCOV MODIFICATION EXPLAINED.........          *
002900110913     F*  FLAT RATE PLANS USE MCORGBEN TO BRING FORWARD THE PREVIOUS    *
003000110913     F*     ORIGINAL AMOUNT.                                           *
003100110913     F*  SALARY PLANS WILL USE MCORGBEN TO CAPTURE THE CALCULATED      *
003200110913     F*     AMOUNT BEFORE THE APPLICATION OF DECLINING BENEFIT.        *
003300110913     F*                                                                *
0033011205210012 F******************************************************************
003302120521     F* 05/21/12 DLK - ALLOW "A1" & "LL" PLAN TYPE                     *
003303130213      * 02/13/13 DLK - do away with hard coded list of plan types      *
003304130930      * 09/30/13 dlk - hist file expansion project
003305120521      *                                                                *
003309120521      *                                                                *
0034001109130012 F******************************************************************
003500110812      *
003600110921     FMCOVC16   UF   E           K DISK
003700110812      *
003800110812     FMCOV      O  A E             DISK    PREFIX(Z) RENAME(MCOVR:OUTCOV)
003900110812      *
004000110812     FDECLIF    IF   E           K DISK
004100110812      *
004200110812     FPLNMST    IF   E           K DISK
004300110812      *
004400110812     FMEMBER    IF   E           K DISK
004500110812      *
004600130930     FHIST      O  A F  216        DISK
004700110812      *
0048001204160019 Fdb933p    O    F  132        PRINTER OFLIND(*INOF)
0049001108120020 F*
0050009102150020 F*
005100110812     D DS@DCL        E DS                  EXTNAME(DECLIF)
0052001108120021 D ABF                    11     50P 0 DIM(20)
0053001108120022 D ABT                    71    110P 0 DIM(20)
0054001109210023 D DRT                   131    190P 5 DIM(20)
005500110812     D DROUND                221    221A
005600110812     D DRNDAM                222    224P 0
005700110812     ***
0058009110100024 D*
0059001108120158 D                 DS
006000110812     D RA@                     1      5A
0061001108120025 D $RA                     1      5S 0 DIM(5)
0062001108120158 D                 DS
006300110812     D BA@                     1      9A
0064001108120026 D $BA                     1      9S 0 DIM(9)
0065001108120158 D                 DS
006600110812     D BR@                     1      9A
0067001108120027 D $BR                     1      9S 0 DIM(9)
006800110812     ***
006900110812     D HL@MCV1       E DS                  EXTNAME(MCOV) PREFIX(Z)
007000110812     D  MCV@OUT                1     88
007100110812     ***
007200110812     D HL@MCV2       E DS                  EXTNAME(MCOV)
007300110812     D  MCV@IN                 1     88
007400110812     ***
0075009808280158 D                 DS
0076009808280159 D  LYMD                   1      8  0
0077009808280160 D  LYR                    1      4  0
0078009808280161 D  LMNTH                  5      6  0
0079009808280162 D  LDAY                   7      8  0
0080009102150080 D                UDS
0081009102150081 D  CONAME               201    240
0082009102150082 D  LMONTH                 1      2  0
0083009808280083 D  LYEAR                  3      6  0
008400110812   01D  LT                     7      9  0
008500110812   01D  LS                    10     12  0
008600110812   01D  LA                    13     16  0
008700110812   01D  MCKEY#                 7     16  0
0088001309300083 D  LUSER                 25     34
008900130930Y2K  D  LD8YMD               248    255  0
009000110812     ***
009100110812     D ADD$R           S              3A
009200110812     D AGE             S              3S 0
009300110812     D BENAMTWK        S              7S 0
009400110812     D BENCHK          S              7S 0
009500110812     D BRTEST          S              9S 2
009600110812     D D               S              2S 0
009700110812     D FINIT           S              1A
009800110812     D FIRSTE          S              1A
009900110812     D HDRT            S              5S 3
010000110812     D HOLD            S             13S 5
010100110812     D HTIME           S              6S 0
010200130213     D*LFCODE          S              2A
010300110812     D MH1             S              4A
010400110812     D MH2             S              2S 0
010500110812     D MH3             S              2A
010600110812     D MH4             S              7A
010700110812     D MH6             S              7A
010800110812     D OBENAM          S              7S 0
010900110812     D ORGAMT          S              7S 0
011000110812     D S               S              2S 0
011100110812     D TRANDT          S              8S 0
011200110812     D TRCODE          S              3A
011300110812     D X               S              1A
011400110812     D ZERO7           S              7S 0
011401130930     D ZERO8           S              8S 0 inz
011500110812     D ZERO9           S              9S 0
011600110812     D BENHLD          S              9S 2
011700110812     D $C              S              1S 0
011800110812     D $D              S              1S 0
0118011309300037 D sysdateymd      S               d   datfmt(*iso)
0118021309300037 D systime         S               t
011803130930     D thispgmname     S             10a   inz('DB933     ')
011900110812     ***
0120001108120158 D                 DS
0121001108120159 D  BIRTH@                 1      8A
0122001108120067 D  BYR                    1      4S 0
0123001108120066 D  BMO                    5      6S 0
012400110812   X***X
0125009102150084 C****************************************************************
0126009102150085 C*
0127009102150099 C*
012800990730     C*
012900110812     C     MCKEY         SETLL     MCOVR
013000990730     C     #T0010        TAG
013100110812     C     MCKEY         READE     MCOVR                                  50
013200990730     C   50              GOTO      #END
013300110921     C*
013400110921     C* DO NOT REPROCESS THE RECORD THAT WAS JUST WROTE
013500110921     C*
013600110921     C                   IF        MCV@IN = MCV@OUT
0137001109210110 C                   GOTO      #T0010
0138001109210120 C                   END
0139009907300102 C*
0140009907300103 C*  SELECT ACTIVE PLANS
0141009907300105 C*
014200990730     C*
0143001108120109 C     ENRLDT        IFGT      LYMD
0144009907300110 C                   GOTO      #T0010
0145009907300111 C                   END
0146009907300121 C*
0147009610080106 C     CANDT         IFNE      0
0148009808280109 C     CANDT         IFLE      LYMD
0149009907300110 C                   GOTO      #T0010
0150009102150111 C                   END
0151009102150112 C                   END
0152009610090121 C*
0153001302130122 C* validate plan
0154009610080123 C*
0155001108120124 C     PLANKY        CHAIN     PLNMSR                             68
0156009907300126 C   68              GOTO      #T0010
0157001302130123
0157011302130123 C* 2/13/13 - disable hard coded list
015800130213     C**                 EVAL      LFCODE = %SUBST(PLNCAT:2:2)
015801130213     C**                 IF        lfcode <> 'SL' and lfcode <> 'LF' and
015802130213     C**                           lfcode <> 'AC' and lfcode <> 'BD' and
015803130213     C**                           lfcode <> 'CC' and lfcode <> 'OA' and
015804130213     C**                           lfcode <> 'LS' and lfcode <> 'SA' and
015805130213     C**                           lfcode <> 'EV' and lfcode <> 'SS' and
015806130213     C**                           lfcode <> 'SP' and lfcode <> 'AA' and
015807130213     C**                           lfcode <> 'NS' and lfcode <> 'NE' and
015808130213     C**                           lfcode <> 'TL' and lfcode <> 'S1' and
015809130213     C**                           lfcode <> 'S2' and lfcode <> 'S3' and
015810130213     C**                           lfcode <> 'S4' and lfcode <> 'S5' and
015811130213     C**                           lfcode <> 'S6' and lfcode <> 'S7' and
015812130213     C**                           lfcode <> 'S8' and lfcode <> 'S9' and
015813130213     C**                           lfcode <> 'D1' and lfcode <> 'D2' and
015814130213     C**                           lfcode <> 'D3' and lfcode <> 'O1' and
015815130213     C**                           lfcode <> 'O2' and lfcode <> 'O3' and
015816130213     C**                           lfcode <> 'A1' and lfcode <> 'LL'
0173001302130126 C**                 GOTO      #T0010
0187021302130127 C**                 END
0188009610080128 C*
0189009610080129 C*  IF NO "DECLIF" RECORD IS FOUND FOR PLAN, IGNORE RECORD.......
0190009610080130 C*
0191001108120131 C     PLANKY        CHAIN     DECLIR                             68
0192009907300132 C   68              GOTO      #T0010
0193009610080113 C*
0194001108120114 C     MCSSNO        CHAIN     MEMBR                              69
0195009907300119 C   69              GOTO      #T0010
019600110812     C                   EVAL      FINIT = %SUBST(MFNAME:1:1)
019700110812     C                   MOVE      BIRTH         BIRTH@
0198009102150115 C*
0199009102150116 C*  IF MEMBER'S BIRTH MONTH IS NOT EQUAL TO LDA MONTH, IGNORE RECORD......
0200009102150117 C*
0201009102150118 C     BMO           IFNE      LMONTH
0202009907300119 C                   GOTO      #T0010
0203009102150120 C                   END
0204009102150133 C*
0205009102150134 C*  IF "DECLIF" RECORD IS FOUND, BUT AGE IS NOT IN ANY AGE BAND RANGE,
020600961008  35 C*  IGNORE RECORD......
0207009102150136 C*
020800930505     C*
0209009102150137 C                   EXSR      #AGEBD
0210009102150138 C     S             IFEQ      *ZEROS
0211009907300139 C                   GOTO      #T0010
0212009102150140 C                   END
0213009102150141 C*
021400110812     C                   EVAL      MCV@OUT = MCV@IN
021500110812     C                   Z-ADD     BENAMT        OBENAM
021600911010     C*
0217009102150142 C     MULT          IFNE      *ZEROS
0218009102150143 C                   EXSR      #SALRY
0219009102150144 C                   ELSE
0220009102150145 C                   EXSR      #FLAT
0221009102150146 C                   END
0222009102150147 C*
0223001108120149 C     DRT(S)        MULT      100           HDRT
0224009808280522 C   27FIRSTE        IFNE      'Y'
0225009210210523 C                   EXCEPT    HEAD
0226001108120524 C                   MOVE      'Y'           FIRSTE
0227009210210525 C                   END
0228009808280150 C   27              EXCEPT    PRINT
022900980828     C   OF
0230009808280148 CAN 27              EXCEPT    HEAD
0231009808280152 C*
023200990730     C                   GOTO      #T0010
0233009907300152 C*
0234009907160151 C     #END          TAG
023500990730     C                   SETON                                        LR
023600110812     C******************************************************************
023700110812     C     *INZSR        BEGSR
023800110812     ****
023900110812     C     MCKEY         KLIST
024000110812     C                   KFLD                    LT
024100110812     C                   KFLD                    LS
024200110812     C                   KFLD                    LA
024300110812     ****
024400110812     C     PLANKY        KLIST
024500110812     C                   KFLD                    MCTRST
024600110812     C                   KFLD                    MCSUB#
024700110812     C                   KFLD                    MCPLAN
024800110812     ****
0249001108120087 C                   TIME                    HTIME
0250001108120089 C                   Z-ADD     *ZEROS        ZERO7
0251001108120090 C                   Z-ADD     *ZEROS        ZERO9
0252001108120091 C                   Z-ADD     LMONTH        LMNTH
0253001108120092 C                   Z-ADD     LYEAR         LYR
0254001108120093 C                   Z-ADD     01            LDAY
025500110812     ****
025600110812     ****
025700110812     ****
025800110812     ****
025900110812     C                   ENDSR
026000110812     C******************************************************************
0261009102150152 C*
0262009102150153 C*----------------- CALCULATE AGE BAND -------------------------*
0263009102150154 C*
0264009102150155 C     #AGEBD        BEGSR
0265009102150156 C*
0266009102150157 C* CALCULATE AGE
0267009102150158 C*
0268001108120159 C     LYEAR         SUB       BYR           AGE
0269009102150160 C     LMONTH        IFNE      12
0270009102150161 C     LMONTH        IFLT      BMO
0271009102150162 C                   SUB       1             AGE
0272009102150163 C                   END
0273009102150164 C                   END
0274009102150165 C*
0275009610080166 C* CHECK FOR AGE IN RANGE OF DECLINING LIFE BENEFIT
0276009102150167 C*
0277001108120168 C                   Z-ADD     0             S
0278009102150169 C                   SETOFF                                       98
0279001108120170 C  N98              DO        20            D
0280009102150171 C     AGE           COMP      ABF(D)                             98  98
0281009102150172 C   98AGE           COMP      ABT(D)                               9898
0282009102150173 C   98              Z-ADD     D             S
0283009102150174 C* END DO 20 LOOP
0284009102150175 C                   END
0285009102150176 C*
0286009102150177 C                   ENDSR
0287009102150178 C*
0288009102150179 C****************************************************************
0289009102150180 C*
0290009908190181 C*------------- SALARY BASED BENEFIT CALCULATION ---------------*
0291009102150182 C*
0292009102150183 C*
0293009102150184 C* THIS SUBROUTINE FOR SALARY BASED LIFE IS CALLED FROM SUB-
0294009102150185 C* ROUTINE #DSPMC.
0295009102150186 C*
0296009102150187 C     #SALRY        BEGSR
0297009102150188 C*
0298009102150189 C* MULTIPLY SALARY TIMES MULTIPLIER IN PLAN RECORD, FOR SALARY
0299009102150190 C* BASED LIFE OR DISABILITY PLAN. MOVE TO WORK FIELD
0300009102150191 C*
0301001108120192 C     SALARY        MULT      MULT          BENHLD
030200110812     C                   MOVE      BENHLD        BA@
0303009102150194 C*
0304009102150195 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM PLAN RECORD
0305009102150196 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0306009102150197 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0307009102150198 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0308009102150199 C*
0309001108120200 C                   MOVE      'NO '         ADD$R
0310009102150201 C     ROUND         IFGT      0
0311009102150202 C*
0312009102150203 C* FIND $ AMOUNT TO BE ROUNDED
0313009102150204 C*
031400110812     C                   MOVE      ROUND         RA@
0315009102150206 C                   MOVE      *ZEROS        $BR
0316001108120207 C                   Z-ADD     5             $C
0317001108120208 C                   Z-ADD     7             $D
0318009102150209 C                   MOVE      $BA(9)        $BR(9)
0319009102150210 C                   MOVE      $BA(8)        $BR(8)
0320009102150211 C                   DO        5
0321009102150212 C     $RA($C)       IFEQ      0
0322009102150213 C                   MOVE      $BA($D)       $BR($D)
0323009102150214 C                   SUB       1             $C
0324009102150215 C                   SUB       1             $D
0325009102150216 C                   ELSE
0326009102150217 C                   GOTO      #S$T01
0327009102150218 C                   END
0328009102150219 C                   END
0329009102150220 C*
0330009102150221 C     #S$T01        TAG
0331009102150222 C*
0332009102150223 C     $BA           SUB       $BR           $BA
0333009102150224 C*
0334001108120225 C     PRNDFL        IFEQ      'U'
033500110812     C                   MOVE      BR@           BRTEST
0336009102150227 C     BRTEST        IFGT      0
0337009102150228 C                   MOVE      'YES'         ADD$R
0338009102150229 C                   END
0339009102150230 C                   END
0340009102150231 C*
0341009102150232 C                   END
0342009102150233 C*
0343009102150234 C*
0344009102150235 C* NOW PLACE RESULT IN FIELD BENAMT, AND MOVE TO SCREEN ARRAY
0345009102150236 C* FOR SCREEN IO03, BA,Z.
0346009102150237 C*
0347001108120238 C                   MOVE      BENAMTWK      BENCHK
034800110812     C                   MOVEL     BA@           BENAMTWK
0349009102150240 C     ADD$R         IFEQ      'YES'
0350001108120241 C                   ADD       ROUND         BENAMTWK
0351009102150242 C                   END
0352009102150243 C*
0353009102150244 C* IF COMPUTED BENEFIT AMOUNT IS GREATER THAN THE MAXIMUM BENEFIT
0354009102150245 C* ALLOWED, REPLACE COMPUTED BENEFIT WITH MAXIMUM BENEFIT
0355009102150246 C* FROM PLAN RECORD.
0356009102150247 C*
0357001108120248 C     BENAMTWK      IFGT      MAXBEN
0358001108120249 C                   MOVE      MAXBEN        BENAMTWK
0359009102150250 C                   END
0360001108120251 C                   Z-ADD     BENAMTWK      ORGAMT
0361001109130252 C*
0362001109210252 C* CAPTURE BENAMTWK AND PLACE IN ORIGINAL BEN AMT FIELD PER KETTERMAN
0363001109210252 C*
036400110913     C                   Z-ADD     BENAMTWK      SAL#CALC          7 0
0365001109130252 C*
0366001109130252 C*
0367001109130252 C*   APPLY DECLINING LIFE TO SALARY CALC'D AMOUNT
0368009102150252 C*
0369001108120253 C     BENAMTWK      MULT(H)   DRT(S)        HOLD
0370009102150254 C                   Z-ADD     HOLD          BENHLD
0371009102150255 C*
037200110812     C                   MOVE      BENHLD        BA@
0373009102150257 C*
0374009102150258 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM DECLINING LIFE BENEFIT RECORD
0375009102150259 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0376009102150260 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0377009102150261 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0378009102150262 C*
0379001108120263 C                   MOVE      'NO '         ADD$R
0380009102150264 C     DRNDAM        IFGT      0
0381009102150265 C*
0382009102150266 C* FIND $ AMOUNT TO BE ROUNDED
0383009102150267 C*
038400110812     C                   MOVE      DRNDAM        RA@
0385009102150269 C                   MOVE      *ZEROS        $BR
0386001108120270 C                   Z-ADD     5             $C
0387001108120271 C                   Z-ADD     7             $D
0388009102150272 C                   MOVE      $BA(9)        $BR(9)
0389009102150273 C                   MOVE      $BA(8)        $BR(8)
0390009102150274 C                   DO        5
0391009102150275 C     $RA($C)       IFEQ      0
0392009102150276 C                   MOVE      $BA($D)       $BR($D)
0393009102150277 C                   SUB       1             $C
0394009102150278 C                   SUB       1             $D
0395009102150279 C                   ELSE
0396009102150280 C                   GOTO      #S$T02
0397009102150281 C                   END
0398009102150282 C                   END
0399009102150283 C*
0400009102150284 C     #S$T02        TAG
0401009102150285 C*
0402009102150286 C     $BA           SUB       $BR           $BA
0403009102150287 C*
0404009102150288 C     DROUND        IFEQ      'U'
040500110812     C                   MOVE      BR@           BRTEST
0406009102150290 C     BRTEST        IFGT      0
0407009102150291 C                   MOVE      'YES'         ADD$R
0408009102150292 C                   END
0409009102150293 C                   END
0410009102150294 C*
0411009102150295 C                   END
0412009102150296 C*
0413009102150297 C*
0414009102150298 C*
0415001108120299 C                   MOVE      BENAMTWK      BENCHK
041600110812     C                   MOVEL     BA@           BENAMTWK
0417009102150301 C     ADD$R         IFEQ      'YES'
0418001108120302 C                   ADD       DRNDAM        BENAMTWK
0419009102150303 C                   END
0420009102150304 C*
0421009102150305 C*
0422009202180306 C*  UPDATE HISTORY IF CHANGE BENAMT RECORD
0423009102150307 C*
042400920218     C                   SETOFF                                       27
042500110812     C     OBENAM        IFNE      BENAMTWK
042600920218     C                   SETON                                        27
042700920218     C                   END
042800920218     C*
0429009808280308 C                   Z-ADD     LYMD          TRANDT
0430001108120309 C                   MOVE      MCPLAN        MH1
0431001108120310 C                   MOVE      MCAGEB        MH2
0432001108120311 C                   MOVE      MCOVTP        MH3
0433009808280312 C                   MOVE      OBENAM        MH4
0434001108120313 C                   MOVE      BENAMTWK      MH6
0435009808280314 C                   MOVE      'MCB'         TRCODE
0436009202180316 C                   SETON                                          26
043601130930     C                   eval      sysdateymd = %date
043602130930     C                   MOVE      sysdateymd    ld8ymd
043603130930     c                   eval      systime = %time
0437009102150317 C                   EXCEPT
0438009202180318 C                   SETOFF                                         26
043900961008     C*
044000961008     C* UPDATE AND ADD NEW REC IF ACTIVE PLAN OR IF PLAN IS CANCELLED
044100961008     C* WITH A FUTURE CANCEL DATE
044200961008     C* CANCEL CURRENT MCOV REC AND ADD NEW
044300961008     C*
0444001108120321 C   27              EXSR      $UPDMCVS
0445001108120321 C   27              EXSR      $ADDMCVS
0446009102150322 C*
0447009610080323 C                   ENDSR
0448009102150324 C*
0449009108220326 C*****************************************************************
0450001108120329 C     $UPDMCVS      BEGSR
0451001108120322 C*
045200110812     C                   EVAL      CANDT = LYMD
045300110812     C                   EVAL      MCDLTD = 'C'
045400110812     C                   UPDATE    MCOVR
0455001108120322 C*
0456001108120323 C                   ENDSR
0457001108120327 C*****************************************************************
0458001108120329 C     $ADDMCVS      BEGSR
0459001108120322 C*
046000110812     C                   EVAL      ZENRLDT = LYMD
046100110812     C                   EVAL      ZLPREM = 0
046200110812     C                   Z-ADD     BENAMTWK      ZBENAMT
046300110913     C                   Z-ADD     SAL#CALC      ZMCORGBEN
046400110819     C                   MOVE      *ALL'0'       ZMCUNIQ
046500110812     C                   WRITE     OUTCOV
0466001108120322 C*
0467001108120323 C                   ENDSR
0468009108220327 C*****************************************************************
0469009102150328 C*
0470009102150329 C     #FLAT         BEGSR
0471009102150330 C*
0472009102150331 C*
0473001108120332 C                   Z-ADD     MCORGBEN      ORGAMT
0474001108120333 C     MCORGBEN      MULT(H)   DRT(S)        HOLD
0475009102150334 C                   Z-ADD     HOLD          BENHLD
0476009102150335 C*
047700110812     C                   MOVE      BENHLD        BA@
0478009102150337 C*
0479009102150338 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM DECLINING LIFE BENEFIT RECORD
0480009102150339 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0481009102150340 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0482009102150341 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0483009102150342 C*
0484001108120343 C                   MOVE      'NO '         ADD$R
0485009102150344 C     DRNDAM        IFGT      0
0486009102150345 C*
0487009102150346 C* FIND $ AMOUNT TO BE ROUNDED
0488009102150347 C*
048900110812     C                   MOVE      DRNDAM        RA@
0490009102150349 C                   MOVE      *ZEROS        $BR
0491001108120350 C                   Z-ADD     5             $C
0492001108120351 C                   Z-ADD     7             $D
0493009102150352 C                   MOVE      $BA(9)        $BR(9)
0494009102150353 C                   MOVE      $BA(8)        $BR(8)
0495009102150354 C                   DO        5
0496009102150355 C     $RA($C)       IFEQ      0
0497009102150356 C                   MOVE      $BA($D)       $BR($D)
0498009102150357 C                   SUB       1             $C
0499009102150358 C                   SUB       1             $D
0500009102150359 C                   ELSE
0501009102150360 C                   GOTO      #S$T03
0502009102150361 C                   END
0503009102150362 C                   END
0504009102150363 C*
0505009102150364 C     #S$T03        TAG
0506009102150365 C*
0507009102150366 C     $BA           SUB       $BR           $BA
0508009102150367 C*
0509009102150368 C     DROUND        IFEQ      'U'
051000110812     C                   MOVE      BR@           BRTEST
0511009102150370 C     BRTEST        IFGT      0
0512009102150371 C                   MOVE      'YES'         ADD$R
0513009102150372 C                   END
0514009102150373 C                   END
0515009102150374 C*
0516009102150375 C                   END
0517009102150376 C*
0518009102150377 C*
0519009102150378 C*
0520001108120379 C                   MOVE      BENAMTWK      BENCHK
052100110812     C                   MOVEL     BA@           BENAMTWK
0522009102150381 C     ADD$R         IFEQ      'YES'
0523001108120382 C                   ADD       DRNDAM        BENAMTWK
0524009102150383 C                   END
0525009102150384 C*
0526009102150385 C*
0527009202180386 C*  UPDATE HISTORY IF CHANGE BENAMT RECORD
0528009102150387 C*
052900920218     C                   SETOFF                                       27
053000110812     C     OBENAM        IFNE      BENAMTWK
053100920218     C                   SETON                                        27
053200920218     C                   END
053300920218     C*
0534001108120388 C                   Z-ADD     LYMD          TRANDT
0535001108120389 C                   MOVE      MCPLAN        MH1
0536001108120390 C                   MOVE      MCAGEB        MH2
0537001108120391 C                   MOVE      MCOVTP        MH3
0538001108120392 C                   MOVE      OBENAM        MH4
0539001108120393 C                   MOVE      BENAMTWK      MH6
0540001108120394 C                   MOVE      'MCB'         TRCODE
0541009202180396 C                   SETON                                          26
054101130930     C                   eval      sysdateymd = %date
054102130930     C                   MOVE      sysdateymd    ld8ymd
054103130930     c                   eval      systime = %time
0542009102150397 C                   EXCEPT
0543009202180398 C                   SETOFF                                         26
0544009102150399 C*
054500961008     C*
054600961008     C* UPDATE AND ADD NEW REC IF ACTIVE PLAN OR IF PLAN IS CANCELLED
054700961008     C* WITH A FUTURE CANCEL DATE
054800961008     C* CANCEL CURRENT MCOV REC AND ADD NEW
054900961008     C*
0550001108120321 C   27              EXSR      $UPDMCVF
0551001108120321 C   27              EXSR      $ADDMCVF
0552009610080322 C*
0553009610080403 C                   ENDSR
0554009102150404 C*
0555001108120326 C*****************************************************************
0556001108120329 C     $UPDMCVF      BEGSR
0557001108120322 C*
055800110812     C                   EVAL      CANDT = LYMD
055900110812     C                   EVAL      MCDLTD = 'C'
056000110812     C                   UPDATE    MCOVR
0561001108120322 C*
0562001108120323 C                   ENDSR
0563001108120327 C*****************************************************************
0564001108120329 C     $ADDMCVF      BEGSR
0565001108120322 C*
056600110812     C                   EVAL      ZENRLDT = LYMD
056700110812     C                   EVAL      ZLPREM = 0
056800110812     C                   Z-ADD     BENAMTWK      ZBENAMT
056900110812     C                   EVAL      ZMCORGBEN = MCORGBEN
057000110819     C                   MOVE      *ALL'0'       ZMCUNIQ
057100110812     C                   WRITE     OUTCOV
0572001108120322 C*
0573001108120323 C                   ENDSR
0574001108120327 C*****************************************************************
0575001108120322 C*
0576009102150405 C*-------------------------------------------------------------------
0577009102150409 OHIST      EADD 27
0578001108120412 O                       MCSSNO              10
0579009102150416 O                       TRCODE         B    19
0580009102150417 O                       ZERO9               24P
0581009102150420 O                       MH1            B    29
0582009102150421 O                                           39 'AgeBand-'
0583009102150422 O                       MH2            B    41
0584009102150423 O                                           51 'CovType-'
0585009110100424 O                       MH3                 53
0586009102150427 O               26                          62 'From-'
0587009102150428 O               26      MH4            B    69
0588009110110431 O                       MH6                 85
058900040616     O                                           90 '00'
059001130930     O                       thispgmname        107
059002130930     O                                          108 ' '
0591001108120436 O                       MCTRST             112
0592001108120437 O                       MCSUB#             115
0593001108120438 O                       MBACCT             119
059401130930     o                       zero8              127
0595009102150440 O                                          128 'A'
0596001309300413 O                       LD8YMD             136
059601130930   01O                       ZERO8              144
059602130930   01O                       ZERO8              152
0599009808280435 O                       TRANDT             160
059901130930     o                       zero9              184
059902130930     o                       zero7              191
059903130930     o                       systime            199
059904130930     o                       zero7              206
059905130930     O                       luser              216
0600009110100411 O*
0601001204160441 Odb933p    E            HEAD           2 03
0602009102150442 O                                           45 '*****'
0603009102150443 O                       CONAME              85
0604009102150444 O                                           91 '*****'
0605009102150445 O          E            HEAD           1
0606009102150446 O                                           66 'DECLINING LIFE BENEFIT '
0607009102150447 O                                           82 'EXCEPTION REPORT'
0608009102150448 O          E            HEAD           1
0609009907300449 O                                           24 'PROGRAM NAME: DB933'
0610009102150450 O                                          122 'PAGE :'
0611009102150451 O                       PAGE          Z    131
0612009610080452 O          E            HEAD           1
0613009102150453 O                                           14 'RUN DATE:'
0614009102150454 O                       UDATE         Y     25
0615009102150455 O                                           69 'FOR  BIRTHDAY :'
0616009102150456 O                       LMONTH              73
0617009102150457 O                                           74 '/'
0618009808280458 O                       LYEAR               78
0619009102150459 O                                          122 'TIME :'
0620009102150460 O                       HTIME              131 '  :  :  '
0621009610080101 O          E            HEAD           2
062200990730     O                                           66 'ACCOUNT:'
062300110812     O                       MCKEY#              79 '   -   -    '
0624009102150461 O          E            HEAD           1
0625009102150462 O                                          104 '*AGE BAND*'
0626009102150463 O                                          112 '%  OF'
0627009102150464 O                                          119 'OLD'
0628009102150465 O                                          129 'NEW'
0629009102150466 O          E            HEAD           2
0630009102150467 O                                            9 'SOC. SEC#'
0631009102150468 O                                           22 'LAST  NAME'
0632009102150469 O                                           46 'PLAN  #'
0633009102150470 O                                           61 'DESCRIPTION'
0634009102150471 O                                           94 'AGE'
0635009102150472 O                                          103 'FROM  TO'
0636009102150473 O                                          113 'BENEFIT'
0637009102150474 O                                          121 'BEN AMT'
0638009102150475 O                                          131 'BEN AMT'
0639009102150476 O          E            HEAD           2
0640009102150477 O                                           20 '--------------------'
0641009102150478 O                                           40 '--------------------'
0642009102150479 O                                           60 '--------------------'
0643009102150480 O                                           80 '--------------------'
0644009102150481 O                                          100 '--------------------'
0645009102150482 O                                          120 '--------------------'
0646009102150483 O                                          132 '------------'
0647001204160484 O          E            PRINT          1
0648001108120485 O                       MCSSNO              11 '   -  -   0'
0649001108120486 O                       MLNAME              31
0650009102150487 O                       FINIT               33
0651009102150488 O                                           34 '.'
0652001108120489 O                       MCTRST              38
0653009808280493 O                                           39 '-'
0654001108120489 O                       MCSUB#              42
0655009808280493 O                                           43 '-'
0656001108120489 O                       MCPLAN              47
0657009102150490 O                       PDESCR         B    90
0658009102150491 O                       AGE           Z     94
0659009102150492 O                       ABF(S)        Z     98
0660009102150493 O                                          100 '-'
0661009102150494 O                       ABT(S)        Z    103
0662009102150495 O                       HDRT          KB   113
0663001109270496 O                       BENAMT        K    122
0664001108120497 O                       BENAMTWK      K    132
0665001109270496 O*******                ORGAMT        KB   122
0666001109270497 O********               BENAMTWK      K    132
