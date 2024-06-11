000100961008     H DFTNAME(DB932I)
0002009102150002 F******************************************************************
0003009102150003 F* DB932      GROUP BENEFIT SERVICES SOFTWARE           1990      *
0004009102150004 F*                                                                *
0005009102150005 F*            WRITTEN BY - WALTER J. PICCININI                    *
0006009102150006 F*            DATE - 04/20/90                                     *
0007009102150007 F*                                                                *
0008009102150008 F*  DESCRIPTION - THIS PROGRAM RECALCULATES MEMBER BENEFIT AMOUNT *
0009009102150009 F*            FOR LIFE PLANS BASED ON % OF BENEFIT FOUND IN       *
0010009102150010 F*            FILE "DECLIF"......                                 *
0011009102150011 F*                                                                *
0012009610080011 F*       VERSION TO RUN FROM TR010CL - INVOICE PROGRAM            *
0013009610080011 F*                                                                *
0014009610080011 F*                                                                *
0015009808280014 F*                                                                *
0016009808280010 F*  Y2K CONVERT - 1998                                            *
0017009808280015 F*                                                                *
001800990715     F*                                                                *
001900990715     F* DLK 07/15/99 - CHANGE INPUT TO USE MCOVX (LOGICAL BY TSA) FOR  *
002000990715     F*                ACC# CHAIN TO INVOICE EXCLUSION FILE            *
002100990806     F* DLK 08/06/99 - ADD LDA POS. 425: SHOWS WHAT PROGRAM DB932I IS  *
002200990806     F*                BEING CALLED FROM, THIS WILL SERVE AS A         *
002300990806     F*                DECISION MAKER FOR SELECTION.                   *
002400000615     F* 06/15/00 DLK - put userid in hist rec instead of "TR010"       *
002500010618     F* 06/18/01 DLK - ALLOW "AC" PLAN TYPE                            *
002600010703     F* 07/03/01 DLK - ALLOW "OA" PLAN TYPE                            *
002700011023     F* 10/23/01 DLK - ALLOW "BD" PLAN TYPE FOR MAGELLAN               *
002800020319     F*  3/19/02 SZZ - Retrieve selected trusts from TRSSLC instead of *
002900020319     F*                LDA.                                            *
003000030730     F* 07/30/03 DLK - ALLOW "CC" PLAN TYPE                            *
003100031222     F* 12/22/03 DLK - ALLOW "LS" & "SA" PLAN TYPE                     *
003200090115     F* 01/15/09 DLK - ALLOW AA, SP, SS AND TL PLAN TYPES              *
003300090728     F* 07/28/09 DLK - ALLOW NS & NE PLAN TYPES                        *
003400110810     F* 08/10/2011 SSK - CONVERSION FROM S/36 TO NATIVE                *
003500110912     F*                  ORIGINAL BENEFIT AMOUNT MODIFICATION          *
0036009102150012 F******************************************************************
003700110913     F* 09/13/2011 SSK   MCOV MODIFICATION EXPLAINED.........          *
003800110913     F*  FLAT RATE PLANS USE MCORGBEN TO BRING FORWARD THE PREVIOUS    *
003900110913     F*     ORIGINAL AMOUNT.                                           *
004000110913     F*  SALARY PLANS WILL USE MCORGBEN TO CAPTURE THE CALCULATED      *
004100110913     F*     AMOUNT BEFORE THE APPLICATION OF DECLINING BENEFIT.        *
004200110913     F*                                                                *
0043001109130012 F******************************************************************
004400120521     F* 05/21/12 DLK - ALLOW A1 & LL PLAN TYPES                        *
004500130213      * 02/13/13 DLK - do away with hard coded list of plan types      *
004501131001      * 10/01/13 dlk - hist file expansion project
004600110810      *
004700130213      *
0048001205210012  ******************************************************************
004900110921     FMCOVC16   UPE  E           K DISK
005100110811     FMCOV      O  A E             DISK    PREFIX(Z) RENAME(MCOVR:OUTCOV)
005300110810     FDECLIF    IF   E           K DISK
005500110810     FPLNMST    IF   E           K DISK
005700110810     FMEMBER    IF   E           K DISK
005900110810     FINVEXC    IF   E           K DISK
006100110810     FTRSSLC    IF   E           K DISK
006300131001     FHIST      O  A F  216        DISK
0065001204160019 Fdb932p    O    F  132        PRINTER OFLIND(*INOF)
006700110810     ***
006800110810     D DS@DCL        E DS                  EXTNAME(DECLIF)
0069001108100021 D ABF                    11     50P 0 DIM(20)
0070001108100022 D ABT                    71    110P 0 DIM(20)
0071001109200023 D DRT                   131    190P 5 DIM(20)
007200110810     D DROUND                221    221A
007300110811     D DRNDAM                222    224P 0
007400110810     ***
0075001108110158 D                 DS
007600110811     D RA@                     1      5A
0077001108110025 D $RA                     1      5S 0 DIM(5)
0078001108110158 D                 DS
007900110811     D BA@                     1      9A
0080001108110026 D $BA                     1      9S 0 DIM(9)
0081001108110158 D                 DS
008200110811     D BR@                     1      9A
0083001108110027 D $BR                     1      9S 0 DIM(9)
008400110810     ***
008500110811     D HL@MCV1       E DS                  EXTNAME(MCOV) PREFIX(Z)
008600110811     D  MCV@OUT                1     88
008700110810     ***
008800110811     D HL@MCV2       E DS                  EXTNAME(MCOV)
008900110811     D  MCV@IN                 1     88
009000110811     ***
0091009808280158 D                 DS
0092009808280159 D  LYMD                   1      8  0
0093009808280160 D  LYR                    1      4  0
0094009808280161 D  LMNTH                  5      6  0
0095009808280162 D  LDAY                   7      8  0
009600110810     ***
0097009102150080 D                UDS
0098009102150081 D  CONAME               201    240
0099009102150082 D  LMONTH                 1      2  0
0100009808280083 D  LYEAR                  3      6  0
0101001310010083 D  LUSER                 25     34
0102009610080685 D  TR#                  100    171  0
010300961008     D                                     DIM(24)
010400131001     D  ld8ymd               248    255  0
010500990806   01D  LRUNFR               425    425
010600110810     ***
010700110810     D DS@PLN        E DS                  EXTNAME(PLNMST)
010800130213     D  LFCODE               164    165A
010900110810     ***
011000110810     D DS@MBR        E DS                  EXTNAME(MEMBER)
011100110810     D  FINIT                 28     28A
011200110810     D  BYR                  513    516S 0
011300110810     D  BMO                  517    518S 0
011400110810     D  A                    001    001A
011500110810     ***
011600110811     D ADD$R           S              3A
011700110811     D AGE             S              3S 0
011800110811     D BENAMTWK        S              7S 0
011900110811     D BENCHK          S              7S 0
012000110811     D BENHLD          S              9S 2
012100110811     D BRTEST          S              9S 2
012200110811     D D               S              2S 0
012300110811     D DOACC           S              1A
012400110811     D FIRSTE          S              1A
012500110811     D HDRT            S              5S 3
012600110811     D HLDACC          S                   LIKE(ACC#)
012700110811     D HLDTRS          S                   LIKE(MCTRST)
012800110811     D HLDSUB          S                   LIKE(MCSUB#)
012900110811     D HOLD            S             13S 5
013000110811     D HTIME           S              6S 0
013100110811     D MH1             S              4A
013200110811     D MH2             S              2S 0
013300110811     D MH3             S              2A
013400110811     D MH4             S              7A
013500110811     D MH6             S              7A
013600110811     D OBENAM          S                   LIKE(BENAMT)
013700110811     D ORGAMT          S              7S 0
013800110811     D S               S              2S 0
013900110811     D TRANDT          S              8S 0
014000110811     D TRCODE          S              3A
014100110811     D X               S              2S 0
014200110811     D ZERO7           S              7S 0
014201131001     D ZERO8           S              8S 0 inz
014300110811     D ZERO9           S              9S 0
014400110811     D $C              S              1S 0
014500110811     D $D              S              1S 0
0145011310010037 D sysdateymd      S               d   datfmt(*iso)
0145021310010037 D systime         S               t
014503131001     D thispgmname     S             10a   inz('DB932I    ')
014600110810     ***
014700110810      *
0148009102150084 C****************************************************************
0149009102150085 C*
015000990716     C*
015100990716     C*  ON ACC CHANGE - CHECK TRUST ARRAY FOR TRUST TO INCLUDE AND
015200990716     C*  INVEXC FILE FOR ACCOUNTS TO EXCLUDE
015300990716     C*
015400110810     C                   IF        MCTRST <> HLDTRS OR MCSUB# <> HLDSUB OR
015500110810     C                             ACC# <> HLDACC
015600110811     C                   MOVE      MCTRST        HLDTRS
015700110811     C                   MOVE      MCSUB#        HLDSUB
015800110811     C                   MOVE      ACC#          HLDACC
015900110811     C                   MOVE      'N'           DOACC
016000990716     C*
016100110811     C                   DO        24            X
016200110811     C     MCTRST        CHAIN     TRSMSR                             81
016300110810     C   81              GOTO      #T0010
016400990806     C*
016500990806     C* "LRUNFR" = 0 WHEN RUN FROM TR010CL OR 5 WHEN RUN FROM TR015CL.
016600990806     C* IF FROM TR010CL - SELECT ACCT IF NOT IN EXCLUSION FILE.
016700990806     C* IF FROM TR015CL - SELECT ACCT IF IT IS IN EXCLUSION FILE AND
016800990806     C* "IENOR" = ' '
016900990806     C*
017000110811     C     ACCKEY        CHAIN     INVER                              54
017100990806     C*
017200110810     C     LRUNFR        IFEQ      '0'
017300110810     C   54              MOVE      'Y'           DOACC
017400110810     C                   ELSE
017500110810     C     LRUNFR        IFEQ      '5'
017600110810     C
017700110810     C  N54IENOR         IFEQ      ' '
017800110810     C  N54              MOVE      'Y'           DOACC
017900110810     C                   ENDIF
018000110810     C                   ENDIF
018100110810     C                   ENDIF
018200990806     C*
018300110810     C                   GOTO      #T0010
018400110810     C                   ENDDO
018500110810     C*
018600110810     C                   ENDIF
018700110921     C*
018800110921     C* DO NOT REPROCESS THE RECORD THAT WAS JUST WROTE
018900110921     C*
019000110921     C                   IF        MCV@IN = MCV@OUT
0191001109210119 C                   GOTO      #END
0192001109210120 C                   END
019300990716     C*
019400990716     C* IF NOT TRUST SELECTED OR ACC WAS IN EXCLUSION FILE - SKIP
019500990716     C*
019600990716     C     #T0010        TAG
019700990716     C     DOACC         IFEQ      'N'
019800990716     C                   GOTO      #END
019900990716     C                   END
0200009102150102 C*
0201009610080103 C*  SELECT ACTIVE PLANS
0202009102150105 C*
0203001108100109 C     ENRLDT        IFEQ      CANDT
0204009907160110 C                   GOTO      #END
0205009808280111 C                   END
0206009808280105 C*
0207009610080106 C     CANDT         IFNE      0
0208009808280109 C     CANDT         IFLE      LYMD
0209009907160110 C                   GOTO      #END
0210009102150111 C                   END
0211009102150112 C                   END
0212009610080121 C*
0213001108100109 C     ENRLDT        IFGT      LYMD
0214009907160110 C                   GOTO      #END
0215009610090111 C                   END
0216009610090121 C*
0217001302130122 C* validate plan
0218009610080123 C*
0219001108110124 C     PLANKY        CHAIN     PLNMSR                             68
0220009907160126 C   68              GOTO      #END
0221009610080123 C*
0222001302130123 C* 2/13/13 - disable hard coded list
022300130213     C**                 IF        lfcode <> 'SL' and lfcode <> 'LF' and
022400130213     C**                           lfcode <> 'AC' and lfcode <> 'BD' and
022500130213     C**                           lfcode <> 'CC' and lfcode <> 'OA' and
022600130213     C**                           lfcode <> 'LS' and lfcode <> 'SA' and
022700130213     C**                           lfcode <> 'EV' and lfcode <> 'SS' and
022800130213     C**                           lfcode <> 'SP' and lfcode <> 'AA' and
022900130213     C**                           lfcode <> 'NS' and lfcode <> 'NE' and
023000130213     C**                           lfcode <> 'TL' and lfcode <> 'S1' and
023100130213     C**                           lfcode <> 'S2' and lfcode <> 'S3' and
023200130213     C**                           lfcode <> 'S4' and lfcode <> 'S5' and
023300130213     C**                           lfcode <> 'S6' and lfcode <> 'S7' and
023400130213     C**                           lfcode <> 'S8' and lfcode <> 'S9' and
023500130213     C**                           lfcode <> 'D1' and lfcode <> 'D2' and
023600130213     C**                           lfcode <> 'D3' and lfcode <> 'O1' and
023700130213     C**                           lfcode <> 'O2' and lfcode <> 'O3' and
023800130213     C**                           lfcode <> 'A1' and lfcode <> 'LL'
0239001302130126 C**                 GOTO      #END
0240001302130127 C**                 END
0241001302130128 C*
0242009610080129 C*  IF NO "DECLIF" RECORD IS FOUND FOR PLAN, IGNORE RECORD.......
0243009610080130 C*
0244001108110131 C     PLANKY        CHAIN     DECLIR                             68
0245009907160132 C   68              GOTO      #END
0246009610080113 C*
0247001108110114 C     MCSSNO        CHAIN     MEMBR                              69
0248009907160119 C   69              GOTO      #END
0249009102150115 C*
0250009102150116 C*  IF MEMBER'S BIRTH MONTH IS NOT EQUAL TO LDA MONTH, IGNORE RECORD......
0251009102150117 C*
0252009102150118 C     BMO           IFNE      LMONTH
0253009907160119 C                   GOTO      #END
0254009102150120 C                   END
0255009102150133 C*
0256009102150134 C*  IF "DECLIF" RECORD IS FOUND, BUT AGE IS NOT IN ANY AGE BAND RANGE,
025700961008  35 C*  IGNORE RECORD......
0258009102150136 C*
025900930505     C*
0260009102150137 C                   EXSR      #AGEBD
0261009102150138 C     S             IFEQ      *ZEROS
0262009907160139 C                   GOTO      #END
0263009102150140 C                   END
0264009102150141 C*
026500110811     C                   EVAL      MCV@OUT = MCV@IN
026600110811     C                   Z-ADD     BENAMT        OBENAM
026700911010     C*
0268009102150142 C     MULT          IFNE      *ZEROS
0269009102150143 C                   EXSR      #SALRY
0270009102150144 C                   ELSE
0271009102150145 C                   EXSR      #FLAT
0272009102150146 C                   END
0273009102150147 C*
0274001108110149 C     DRT(S)        MULT      100           HDRT
0275009808280522 C   27FIRSTE        IFNE      'Y'
0276009210210523 C                   EXCEPT    HEAD
027700020319     C                   MOVE      *ZEROS        TRTRST
027800020319     C     TRTRST        SETLL     TRSSLC
027900020319     C     READTR        TAG
028000020319     C                   READ      TRSSLC                                 61
028100020319     C  N61              EXCEPT    TRUSTS
028200020319     C  N61              GOTO      READTR
0283001108110524 C                   MOVE      'Y'           FIRSTE
0284009210210525 C                   END
0285009808280150 C   27              EXCEPT    PRINT
028600980828     C   OF
0287009808280148 CAN 27              EXCEPT    HEAD
0288009808280152 C*
0289009907160151 C     #END          TAG
0290009102150152 C*
0291009102150153 C*----------------- CALCULATE AGE BAND -------------------------*
0292009102150154 C*
0293009102150155 C     #AGEBD        BEGSR
0294009102150156 C*
0295009102150157 C* CALCULATE AGE
0296009102150158 C*
0297001108110159 C     LYEAR         SUB       BYR           AGE
0298009102150160 C     LMONTH        IFNE      12
0299009102150161 C     LMONTH        IFLT      BMO
0300009102150162 C                   SUB       1             AGE
0301009102150163 C                   END
0302009102150164 C                   END
0303009102150165 C*
0304009610080166 C* CHECK FOR AGE IN RANGE OF DECLINING LIFE BENEFIT
0305009102150167 C*
0306001108110168 C                   Z-ADD     0             S
0307009102150169 C                   SETOFF                                       98
0308001108110170 C  N98              DO        20            D
0309009102150171 C     AGE           COMP      ABF(D)                             98  98
0310009102150172 C   98AGE           COMP      ABT(D)                               9898
0311009102150173 C   98              Z-ADD     D             S
0312009102150174 C* END DO 20 LOOP
0313009102150175 C                   END
0314009102150176 C*
0315009102150177 C                   ENDSR
0316009102150178 C*
0317009102150179 C****************************************************************
0318009102150180 C*
0319009908190181 C*------------- SALARY BASED BENEFIT CALCULATION ---------------*
0320009102150182 C*
0321009102150183 C*
0322009102150184 C* THIS SUBROUTINE FOR SALARY BASED LIFE IS CALLED FROM SUB-
0323009102150185 C* ROUTINE #DSPMC.
0324009102150186 C*
0325009102150187 C     #SALRY        BEGSR
0326009102150188 C*
0327009102150189 C* MULTIPLY SALARY TIMES MULTIPLIER IN PLAN RECORD, FOR SALARY
0328009102150190 C* BASED LIFE OR DISABILITY PLAN. MOVE TO WORK FIELD
0329009102150191 C*
0330001108110192 C     SALARY        MULT      MULT          BENHLD
033100110811     C                   MOVE      BENHLD        BA@
0332001108110193 C*****              MOVEA     BENHLD        $BA
0333009102150194 C*
0334009102150195 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM PLAN RECORD
0335009102150196 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0336009102150197 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0337009102150198 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0338009102150199 C*
0339001108110200 C                   MOVE      'NO '         ADD$R
0340009102150201 C     ROUND         IFGT      0
0341009102150202 C*
0342009102150203 C* FIND $ AMOUNT TO BE ROUNDED
0343009102150204 C*
034400110811     C                   MOVE      ROUND         RA@
0345001108110205 C************       MOVEA     ROUND         $RA
0346009102150206 C                   MOVE      *ZEROS        $BR
0347001108110207 C                   Z-ADD     5             $C
0348001108110208 C                   Z-ADD     7             $D
0349009102150209 C                   MOVE      $BA(9)        $BR(9)
0350009102150210 C                   MOVE      $BA(8)        $BR(8)
0351009102150211 C                   DO        5
0352009102150212 C     $RA($C)       IFEQ      0
0353009102150213 C                   MOVE      $BA($D)       $BR($D)
0354009102150214 C                   SUB       1             $C
0355009102150215 C                   SUB       1             $D
0356009102150216 C                   ELSE
0357009102150217 C                   GOTO      #S$T01
0358009102150218 C                   END
0359009102150219 C                   END
0360009102150220 C*
0361009102150221 C     #S$T01        TAG
0362009102150222 C*
0363009102150223 C     $BA           SUB       $BR           $BA
0364009102150224 C*
0365001108100225 C     PRNDFL        IFEQ      'U'
036600110811     C                   MOVE      BR@           BRTEST
0367001108110226 C*************      MOVEA     $BR(1)        BRTEST
0368009102150227 C     BRTEST        IFGT      0
0369009102150228 C                   MOVE      'YES'         ADD$R
0370009102150229 C                   END
0371009102150230 C                   END
0372009102150231 C*
0373009102150232 C                   END
0374009102150233 C*
0375009102150234 C*
0376009102150235 C* NOW PLACE RESULT IN FIELD BENAMT, AND MOVE TO SCREEN ARRAY
0377009102150236 C* FOR SCREEN IO03, BA,Z.
0378009102150237 C*
0379001108110238 C                   MOVE      BENAMTWK      BENCHK
038000110811     C                   MOVEL     BA@           BENAMTWK
0381001108110239 C*******************MOVEA     $BA(1)        BENAMT
0382009102150240 C     ADD$R         IFEQ      'YES'
0383001108110241 C                   ADD       ROUND         BENAMTWK
0384009102150242 C                   END
0385009102150243 C*
0386009102150244 C* IF COMPUTED BENEFIT AMOUNT IS GREATER THAN THE MAXIMUM BENEFIT
0387009102150245 C* ALLOWED, REPLACE COMPUTED BENEFIT WITH MAXIMUM BENEFIT
0388009102150246 C* FROM PLAN RECORD.
0389009102150247 C*
0390001108110248 C     BENAMTWK      IFGT      MAXBEN
0391001108110249 C                   MOVE      MAXBEN        BENAMTWK
0392009102150250 C                   END
0393001108110251 C                   Z-ADD     BENAMTWK      ORGAMT
0394001109130252 C*
0395001109130252 C* CAPTURE BENAMTWK AND PLACE IN ORIGINAL BEN AMT FIELD PER KETTERMAN
0396001109130252 C*
039700110913     C                   Z-ADD     BENAMTWK      SAL#CALC          7 0
0398001109130252 C*
0399001109130252 C* APPLY DECLINING LIFE RATE IF NECESSARY
0400009102150252 C*
0401001304010253 C     BENAMTWK      MULT(H)   DRT(S)        HOLD
0402009102150254 C                   Z-ADD     HOLD          BENHLD
0403009102150255 C*
0404001108110256 C*******************MOVEA     BENHLD        $BA
040500110811     C                   MOVE      BENHLD        BA@
0406009102150257 C*
0407009102150258 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM DECLINING LIFE BENEFIT RECORD
0408009102150259 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0409009102150260 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0410009102150261 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0411009102150262 C*
0412001108110263 C                   MOVE      'NO '         ADD$R
0413009102150264 C     DRNDAM        IFGT      0
0414009102150265 C*
0415009102150266 C* FIND $ AMOUNT TO BE ROUNDED
0416009102150267 C*
0417001108110268 C*******************MOVEA     DRNDAM        $RA
041800110811     C                   MOVE      DRNDAM        RA@
0419009102150269 C                   MOVE      *ZEROS        $BR
0420001108110270 C                   Z-ADD     5             $C
0421001108110271 C                   Z-ADD     7             $D
0422009102150272 C                   MOVE      $BA(9)        $BR(9)
0423009102150273 C                   MOVE      $BA(8)        $BR(8)
0424009102150274 C                   DO        5
0425009102150275 C     $RA($C)       IFEQ      0
0426009102150276 C                   MOVE      $BA($D)       $BR($D)
0427009102150277 C                   SUB       1             $C
0428009102150278 C                   SUB       1             $D
0429009102150279 C                   ELSE
0430009102150280 C                   GOTO      #S$T02
0431009102150281 C                   END
0432009102150282 C                   END
0433009102150283 C*
0434009102150284 C     #S$T02        TAG
0435009102150285 C*
0436009102150286 C     $BA           SUB       $BR           $BA
0437009102150287 C*
0438009102150288 C     DROUND        IFEQ      'U'
043900110811     C                   MOVE      BR@           BRTEST
0440001108110289 C*******************MOVEA     $BR(1)        BRTEST
0441009102150290 C     BRTEST        IFGT      0
0442009102150291 C                   MOVE      'YES'         ADD$R
0443009102150292 C                   END
0444009102150293 C                   END
0445009102150294 C*
0446009102150295 C                   END
0447009102150296 C*
0448009102150297 C*
0449009102150298 C*
0450001108110299 C                   MOVE      BENAMTWK      BENCHK
045100110811     C                   MOVEL     BA@           BENAMTWK
0452001108110300 C****************** MOVEA     $BA(1)        BENAMT
0453009102150301 C     ADD$R         IFEQ      'YES'
0454001108110302 C                   ADD       DRNDAM        BENAMTWK
0455009102150303 C                   END
0456009102150304 C*
0457009102150305 C*
0458009202180306 C*  UPDATE HISTORY IF CHANGE BENAMT RECORD
0459009102150307 C*
046000920218     C                   SETOFF                                       27
046100110811     C     OBENAM        IFNE      BENAMTWK
046200920218     C                   SETON                                        27
046300920218     C                   END
046400920218     C*
0465009808280308 C                   Z-ADD     LYMD          TRANDT
0466001108100309 C                   MOVE      MCPLAN        MH1
0467001108100310 C                   MOVE      MCAGEB        MH2
0468001108100311 C                   MOVE      MCOVTP        MH3
0469001108100312 C                   MOVE      OBENAM        MH4
0470001108110313 C                   MOVE      BENAMTWK      MH6
0471009808280314 C                   MOVE      'MCB'         TRCODE
0472009202180316 C                   SETON                                          26
047201131001     C                   eval      sysdateymd = %date
047202131001     C                   MOVE      sysdateymd    ld8ymd
047203131001     c                   eval      systime = %time
0473009102150317 C                   EXCEPT
0474009202180318 C                   SETOFF                                         26
047500961008     C*
047600961008     C* UPDATE AND ADD NEW REC IF ACTIVE PLAN OR IF PLAN IS CANCELLED
047700961008     C* WITH A FUTURE CANCEL DATE
047800961008     C* CANCEL CURRENT MCOV REC AND ADD NEW
047900961008     C*
0480001108110321 C   27              EXSR      $UPDMCVS
0481001108110321 C   27              EXSR      $ADDMCVS
0482009102150322 C*
0483009610080323 C                   ENDSR
0484009102150324 C*
0485009108220326 C*****************************************************************
0486001108110329 C     $UPDMCVS      BEGSR
0487001108100322 C*
048800110810     C                   EVAL      CANDT = LYMD
048900110810     C                   EVAL      MCDLTD = 'C'
049000110810     C                   UPDATE    MCOVR
0491001108100322 C*
0492001108100323 C                   ENDSR
0493009108220327 C*****************************************************************
0494001108110329 C     $ADDMCVS      BEGSR
0495001108100322 C*
049600110811     C                   EVAL      ZENRLDT = LYMD
049700110811     C                   EVAL      ZLPREM = 0
049800110811     C                   Z-ADD     BENAMTWK      ZBENAMT
049900110913     C                   Z-ADD     SAL#CALC      ZMCORGBEN
050000110819     C                   MOVE      *ALL'0'       ZMCUNIQ
050100110811     C                   WRITE     OUTCOV
0502001108100322 C*
0503001108100323 C                   ENDSR
0504001108100327 C*****************************************************************
0505009102150328 C*
0506009102150329 C     #FLAT         BEGSR
0507009102150330 C*
0508009102150331 C*
0509001108110332 C*******************Z-ADD     MAXBEN        ORGAMT
0510001108110333 C*****MAXBEN********MULT(H)   DRT(S)        HOLD
0511001108110332 C                   Z-ADD     MCORGBEN      ORGAMT
0512001108110333 C     MCORGBEN      MULT(H)   DRT(S)        HOLD
0513001108110334 C                   Z-ADD     HOLD          BENHLD
0514009102150335 C*
0515001108110336 C*******************MOVEA     BENHLD        $BA
051600110811     C                   MOVE      BENHLD        BA@
0517009102150337 C*
0518009102150338 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM DECLINING LIFE BENEFIT RECORD
0519009102150339 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
0520009102150340 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
0521009102150341 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
0522009102150342 C*
0523001108110343 C                   MOVE      'NO '         ADD$R
0524009102150344 C     DRNDAM        IFGT      0
0525009102150345 C*
0526009102150346 C* FIND $ AMOUNT TO BE ROUNDED
0527009102150347 C*
0528001108110348 C*******************MOVEA     DRNDAM        $RA
052900110811     C                   MOVE      DRNDAM        RA@
0530009102150349 C                   MOVE      *ZEROS        $BR
0531001108110350 C                   Z-ADD     5             $C
0532001108110351 C                   Z-ADD     7             $D
0533009102150352 C                   MOVE      $BA(9)        $BR(9)
0534009102150353 C                   MOVE      $BA(8)        $BR(8)
0535009102150354 C                   DO        5
0536009102150355 C     $RA($C)       IFEQ      0
0537009102150356 C                   MOVE      $BA($D)       $BR($D)
0538009102150357 C                   SUB       1             $C
0539009102150358 C                   SUB       1             $D
0540009102150359 C                   ELSE
0541009102150360 C                   GOTO      #S$T03
0542009102150361 C                   END
0543009102150362 C                   END
0544009102150363 C*
0545009102150364 C     #S$T03        TAG
0546009102150365 C*
0547009102150366 C     $BA           SUB       $BR           $BA
0548009102150367 C*
0549009102150368 C     DROUND        IFEQ      'U'
0550001108110369 C*******************MOVEA     $BR(1)        BRTEST
055100110811     C                   MOVE      BR@           BRTEST
0552009102150370 C     BRTEST        IFGT      0
0553009102150371 C                   MOVE      'YES'         ADD$R
0554009102150372 C                   END
0555009102150373 C                   END
0556009102150374 C*
0557009102150375 C                   END
0558009102150376 C*
0559009102150377 C*
0560009102150378 C*
0561001108110379 C                   MOVE      BENAMTWK      BENCHK
0562001108110380 C****************** MOVEA     $BA(1)        BENAMT
056300110811     C                   MOVEL     BA@           BENAMTWK
0564009102150381 C     ADD$R         IFEQ      'YES'
0565001108110382 C                   ADD       DRNDAM        BENAMTWK
0566009102150383 C                   END
0567009102150384 C*
0568009102150385 C*
0569009202180386 C*  UPDATE HISTORY IF CHANGE BENAMT RECORD
0570009102150387 C*
057100920218     C                   SETOFF                                       27
057200110811     C     OBENAM        IFNE      BENAMTWK
057300920218     C                   SETON                                        27
057400920218     C                   END
057500920218     C*
0576001108110388 C                   Z-ADD     LYMD          TRANDT
0577001108110389 C                   MOVE      MCPLAN        MH1
0578001108110390 C                   MOVE      MCAGEB        MH2
0579001108110391 C                   MOVE      MCOVTP        MH3
0580001108110392 C                   MOVE      OBENAM        MH4
0581001108110393 C                   MOVE      BENAMTWK      MH6
0582001108110394 C                   MOVE      'MCB'         TRCODE
0583009202180396 C                   SETON                                          26
058301131001     C                   eval      sysdateymd = %date
058302131001     C                   MOVE      sysdateymd    ld8ymd
058303131001     c                   eval      systime = %time
0584009102150397 C                   EXCEPT
0585009202180398 C                   SETOFF                                         26
0586009102150399 C*
058700961008     C*
058800961008     C* UPDATE AND ADD NEW REC IF ACTIVE PLAN OR IF PLAN IS CANCELLED
058900961008     C* WITH A FUTURE CANCEL DATE
059000961008     C* CANCEL CURRENT MCOV REC AND ADD NEW
059100961008     C*
0592001108110321 C   27              EXSR      $UPDMCVF
0593001108110321 C   27              EXSR      $ADDMCVF
0594009610080322 C*
0595009610080403 C                   ENDSR
0596001108110404 C*
0597001108110326 C*****************************************************************
0598001108110329 C     $UPDMCVF      BEGSR
0599001108110322 C*
060000110811     C                   EVAL      CANDT = LYMD
060100110811     C                   EVAL      MCDLTD = 'C'
060200110811     C                   UPDATE    MCOVR
0603001108110322 C*
0604001108110323 C                   ENDSR
0605001108110327 C*****************************************************************
0606001108110329 C     $ADDMCVF      BEGSR
0607001108110322 C*
060800110811     C                   EVAL      ZENRLDT = LYMD
060900110811     C                   EVAL      ZLPREM = 0
061000110811     C                   Z-ADD     BENAMTWK      ZBENAMT
061100110811     C                   EVAL      ZMCORGBEN = MCORGBEN
061200110819     C                   MOVE      *ALL'0'       ZMCUNIQ
061300110811     C                   WRITE     OUTCOV
0614001108110322 C*
0615001108110323 C                   ENDSR
0616001108110327 C*****************************************************************
0617009102150404 C*
0618009102150405 C*-------------------------------------------------------------------
061900110810     C     *INZSR        BEGSR
062000110810      *
0621001108110087 C                   TIME                    HTIME
0622001108110089 C                   Z-ADD     *ZEROS        ZERO7
0623001108110090 C                   Z-ADD     *ZEROS        ZERO9
0624001108100091 C                   Z-ADD     LMONTH        LMNTH
0625001108100092 C                   Z-ADD     LYEAR         LYR
0626001108100093 C                   Z-ADD     01            LDAY
0627001108100099 C*
062800110810     C     PLANKY        KLIST
062900110810     C                   KFLD                    MCTRST
063000110810     C                   KFLD                    MCSUB#
063100110810     C                   KFLD                    MCPLAN
063200110810      *
063300110810     C     ACCKEY        KLIST
063400110810     C                   KFLD                    MCTRST
063500110810     C                   KFLD                    MCSUB#
063600110810     C                   KFLD                    ACC#
063700110810      *
063800110810     C                   ENDSR
0639001108100405 C*-------------------------------------------------------------------
0648009102150409 OHIST      EADD 27
0649001108100412 O                       MCSSNO              10
0650009102150416 O                       TRCODE         B    19
0651009102150417 O                       ZERO9               24P
0652009102150420 O                       MH1            B    29
0653009102150421 O                                           39 'AgeBand-'
0654009102150422 O                       MH2            B    41
0655009102150423 O                                           51 'CovType-'
0656009110100424 O                       MH3                 53
0657009102150427 O               26                          62 'From-'
0658009102150428 O               26      MH4            B    69
0659009110110431 O                       MH6                 85
066000040616     O                                           90 '00'
066101131001     O                       thispgmname        107
066102131001     O                                          108 ' '
0662001108100436 O                       MCTRST             112
0663001108100437 O                       MCSUB#             115
0664001108100438 O                       MBACCT             119
066401131001     o                       zero8              127
0666009102150440 O                                          128 'A'
0667001310010413 O                       LD8YMD             136
066901131001   01O                       ZERO8              144
066902131001   01O                       ZERO8              152
0670009808280435 O                       TRANDT             160
067001131001     o                       zero9              184
067002131001     o                       zero7              191
067003131001     o                       systime            199
067004131001     o                       zero7              206
067005131001     O                       luser              216
0671009110100411 O*
0672001204160441 Odb932p    E            HEAD           2 03
0673009102150442 O                                           45 '*****'
0674009102150443 O                       CONAME              85
0675009102150444 O                                           91 '*****'
0676009102150445 O          E            HEAD           1
0677009102150446 O                                           66 'DECLINING LIFE BENEFIT '
0678009102150447 O                                           82 'EXCEPTION REPORT'
0679009102150448 O          E            HEAD           1
0680009102150449 O                                           24 'PROGRAM NAME: DB932'
0681009102150450 O                                          122 'PAGE :'
0682009102150451 O                       PAGE          Z    131
0683009610080452 O          E            HEAD           1
0684009102150453 O                                           14 'RUN DATE:'
0685009102150454 O                       UDATE         Y     25
0686009102150455 O                                           69 'FOR  BIRTHDAY :'
0687009102150456 O                       LMONTH              73
0688009102150457 O                                           74 '/'
0689009808280458 O                       LYEAR               78
0690009102150459 O                                          122 'TIME :'
0691009102150460 O                       HTIME              131 '  :  :  '
0692009610080101 O          E            HEAD           2
0693009102150461 O          E            HEAD           1
0694009102150462 O                                          104 '*AGE BAND*'
0695009102150463 O                                          112 '%  OF'
0696009102150464 O                                          119 'OLD'
0697009102150465 O                                          129 'NEW'
0698009102150466 O          E            HEAD           2
0699009102150467 O                                            9 'SOC. SEC#'
0700009102150468 O                                           22 'LAST  NAME'
0701009102150469 O                                           46 'PLAN  #'
0702009102150470 O                                           61 'DESCRIPTION'
0703009102150471 O                                           94 'AGE'
0704009102150472 O                                          103 'FROM  TO'
0705009102150473 O                                          113 'BENEFIT'
0706009102150474 O                                          121 'BEN AMT'
0707009102150475 O                                          131 'BEN AMT'
0708009102150476 O          E            HEAD           2
0709009102150477 O                                           20 '--------------------'
0710009102150478 O                                           40 '--------------------'
0711009102150479 O                                           60 '--------------------'
0712009102150480 O                                           80 '--------------------'
0713009102150481 O                                          100 '--------------------'
0714009102150482 O                                          120 '--------------------'
0715009102150483 O                                          132 '------------'
0716000203190476 O          E            HEAD           2
071700020319     O                                           16 'TRUSTS SELECTED:'
071800120416     O          E            TRUSTS         1
071900020319     O                       TRTRST              20
0720001204160484 O          E            PRINT          1
0721001108100485 O                       MCSSNO              11 '   -  -   0'
0722001108100486 O                       MLNAME              31
0723009102150487 O                       FINIT               33
0724009102150488 O                                           34 '.'
0725001108100489 O                       MCTRST              38
0726009808280493 O                                           39 '-'
0727001108100489 O                       MCSUB#              42
0728009808280493 O                                           43 '-'
0729001108100489 O                       MCPLAN              47
0730009102150490 O                       PDESCR         B    90
0731009102150491 O                       AGE           Z     94
0732009102150492 O                       ABF(S)        Z     98
0733009102150493 O                                          100 '-'
0734009102150494 O                       ABT(S)        Z    103
0735009102150495 O                       HDRT          KB   113
0736001109270496 O                       BENAMT        K    122
0737001109270497 O                       BENAMTWK      K    132
0738001109270496 O*******                ORGAMT        KB   122
0739001109270497 O*********              BENAMT        K    132
