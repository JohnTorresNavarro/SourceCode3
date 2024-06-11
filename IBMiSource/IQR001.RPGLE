000100100218     FSMANSP    IF   E           K DISK
000200100218     FSMANRLT   IF   E           K DISK
000300100218     FSPRAGXR2  IF   E           K DISK
000400100218     FAGENL4    IF   E           K DISK
000500100218     FSMAN2L    IF   E           K DISK
000600100218     FBLILSM    IF   E           K DISK
000700100218     FBLIEOC    IF   E           K DISK
000800100218     FBLILAG    IF   E           K DISK
000900100218     FIQR001D   CF   E             WORKSTN INFDS(WSDS)
001000100218   X***X
001100100218     D WSDS            DS
001200100218     D  FKEY                 369    369A
001300100218    ***
001400100218     D  F1             C                   CONST(X'31')
001500100218     D  F2             C                   CONST(X'32')
001600100218     D  F3             C                   CONST(X'33')
001700100218     D  F4             C                   CONST(X'34')
001800100218     D  F5             C                   CONST(X'35')
001900100218     D  F6             C                   CONST(X'36')
002000100218     D  F7             C                   CONST(X'37')
002100100218     D  F8             C                   CONST(X'38')
002200100218     D  F9             C                   CONST(X'39')
002300100218     D  F10            C                   CONST(X'3A')
002400100218     D  F11            C                   CONST(X'3B')
002500100218     D  F12            C                   CONST(X'3C')
002600100218     D  F13            C                   CONST(X'B1')
002700100218     D  F14            C                   CONST(X'B2')
002800100218     D  F15            C                   CONST(X'B3')
002900100218     D  F16            C                   CONST(X'B4')
003000100218     D  F17            C                   CONST(X'B5')
003100100218     D  F18            C                   CONST(X'B6')
003200100218     D  F19            C                   CONST(X'B7')
003300100218     D  F20            C                   CONST(X'B8')
003400100218     D  F21            C                   CONST(X'B9')
003500100218     D  F22            C                   CONST(X'BA')
003600100218     D  F23            C                   CONST(X'BB')
003700100218     D  F24            C                   CONST(X'BC')
003800100218   X***X
003900100218     D                 DS
004000100218     D PRMS                    1      9A
004100100218     D P@RELID                 1      8A
004200100218     D P@FILLER                9      9A
004300100218    ***
004400100218     D @80             S             80A
004500100218     D @@@PARMS        S              9A
004600100218     D @@EXPD          S                   LIKE(LGEXPD)
004700100219     D #XSX            S              8S 0
004800100218    ***
004900100218     D DS@SMN        E DS                  EXTNAME(SMAN)
005000100218     D DS@SMR        E DS                  EXTNAME(SMANRLT)
005100100218     D DS@SPR        E DS                  EXTNAME(SPRAGXRF)
005200100218     D DS@AGC        E DS                  EXTNAME(AGENCY)
005300100218     D DS@SM2        E DS                  EXTNAME(SMAN2)
005400100218     D DS@LSM        E DS                  EXTNAME(BLILSM)
005500100218     D DS@EOC        E DS                  EXTNAME(BLIEOC)
005600100218     D DS@LAG        E DS                  EXTNAME(BLILAG)
005700100218   X***X
005800100218    ***
005900100218     C     *ENTRY        PLIST
006000100218     C                   PARM                    @@@PARMS
006100100218     C                   EVAL      PRMS = @@@PARMS
006200100218    ***
006300100218     C                   CLEAR                   POPWDW
006400100218     C                   CLEAR                   DS@SMN
006500100218     C                   CLEAR                   DS@SMR
006600100218     C                   CLEAR                   DS@SPR
006700100218     C                   CLEAR                   DS@AGC
006800100218     C                   CLEAR                   DS@SM2
006900100218     C                   CLEAR                   DS@LSM
007000100218     C                   CLEAR                   DS@EOC
007100100218     C                   CLEAR                   DS@LAG
007200100218    ***
007300100218     C     P@RELID       CHAIN     SRF
007400100218     C                   IF        NOT %FOUND(SMANRLT)
007500100218     C                   EVAL      VRELID = '*ERROR*'
007600100218     C                   GOTO      DSPREC
007700100218     C                   ENDIF
007800100218    * *
007900100218     C     P@RELID       CHAIN     BLIEOCR
008000100218     C                   IF        NOT %FOUND(BLIEOC)
008100100218     C                   EVAL      VEOEXP = 'UNKNOWN'
008200100218     C                   ELSE
008300100218     C                   IF        LEEXPD = 99999999
008400100218     C                   EVAL      VEOEXP = 'NO EXPIRTN'
008500100218     C                   ELSE
008600100218     C     LEEXPD        MULT      10000.0001    #XSX
008700100218     C                   EVAL      VEOEXP = %EDITC(#XSX:'Y')
008800100218     C                   ENDIF
008900100218     C                   ENDIF
009000100218    * *
009100100218     C                   EVAL      VRELID = P@RELID
009200100218    * *
009300100218     C     SRASID        CHAIN     SXF
009400100218     C                   IF        NOT %FOUND(SPRAGXR2)
009500100218     C                   EVAL      VRELID = '*ERROR*'
009600100218     C                   GOTO      DSPREC
009700100218     C                   ENDIF
009800100218    * *
009900100218     C     SXAGCY        CHAIN     AGENR
010000100219     C                   IF        NOT %FOUND(AGENL4)
010100100218     C                   EVAL      VAGNME = '*ERROR*'
010200100218     C                   GOTO      DSPREC
010300100218     C                   ENDIF
010400100218    * *
010500100218     C                   EVAL      @80 = SXAGCY + '=' + %TRIM(AGNAM1)
010600100218     C                   MOVEL(P)  @80           VAGNME
010700100218    * *
010800100218     C                   EVAL      VAGAD1 = %TRIM(AGADD1)
010900100218     C                   EVAL      VAGAD2 = %TRIM(AGADD2)
011000100218     C                   EVAL      VAGCSZ = %TRIM(AGCITY) + ', ' + AGSTAT +
011100100218     C                             ' ' + %EDITC(AGZIP5:'Z')
011200100218    * *
011300100218     C                   MOVE      AGTLX3        @3                3
011400100218     C                   MOVE      AGTLX7        @7                7
011500100218     C                   EVAL      VAGPHN = '(' + @3 + ') ' +
011600100218     C                             %SUBST(@7:1:3) + '-' +
011700100218     C                             %SUBST(@7:4:4)
011800100219     C                   EVAL      VAGCON = %TRIM(AGCONT)
011900100219     C                   EVAL      VAGEML = '*FUTURE ENHANCEMENT*'
012000100218    * *
012100100218     C     KL#LAG        KLIST
012200100218     C                   KFLD                    SXAGCY
012300100218     C                   KFLD                    KF@STATE          2
012400100218    * *
012500100218     C                   EVAL      KF@STATE = 'MD'
012600100218     C     KL#LAG        CHAIN     BLIAGR
012700100218     C                   IF        %FOUND(BLILAG)
012800100218     C                   MOVE      LGEXPD        @@EXPD
012900100218     C                   EVAL      VAGLNB = %TRIM(LGLICN)
013000100218     C                   ELSE
013100100218     C     SXAGCY        CHAIN     BLIAGR
013200100218     C                   IF        %FOUND(BLILAG)
013300100218     C                   MOVE      LGEXPD        @@EXPD
013400100218     C                   EVAL      VAGLNB = %TRIM(LGLICN)
013500100218     C                   ELSE
013600100218     C                   EVAL      VAGLNB = '*UNKNOWN*'
013700100218     C                   EVAL      @@EXPD = 1
013800100218     C                   ENDIF
013900100218     C                   ENDIF
014000100218    * *
014100100218     C                   SELECT
014200100218     C                   WHEN      @@EXPD = 1
014300100218     C                   EVAL      VAGLEX = '*UNKNOWN*'
014400100218     C                   WHEN      @@EXPD = 99999999
014500100219     C                   EVAL      VAGLEX = 'NO EXPIRTN'
014600100218     C                   OTHER
014700100218     C     @@EXPD        MULT      10000.0001    #XSX
014800100219     C                   EVAL      VAGLEX = %EDITC(#XSX:'Y')
014900100218     C                   ENDSL
015000100218    ***
015100100219     C     SRSMAN        CHAIN     SMANR
015200100219     C                   IF        NOT %FOUND(SMANSP)
015300100219     C                   EVAL      VSMNME = '*ERROR*'
015400100219     C                   GOTO      DSPREC
015500100218     C                   ENDIF
015600100219    * *
015700100219     C                   Z-ADD     SAREA         #3S0              3 0
015800100219     C                   Z-ADD     SPHONE        #7S0              7 0
015900100219     C                   MOVE      #3S0          @3                3
016000100219     C                   MOVE      #7S0          @7                7
016100100219     C                   EVAL      VSMPHN = '(' + @3 + ') ' +
016200100219     C                             %SUBST(@7:1:3) + '-' +
016300100219     C                             %SUBST(@7:4:4)
016400100219     C                   EVAL      VSMEML = '*FUTURE ENHANCEMENT*'
016500100218    * *
016600100219     C                   Z-ADD     SZIPCD        #9S0              9 0
016700100219     C                   MOVE      #9S0          @9                9
016800100219     C                   EVAL      VSMAD1 = %TRIM(SADDR)
016900100219     C                   EVAL      VSMAD2 = *BLANKS
017000100219     C                   EVAL      VSMCSZ = %TRIM(SCITY) + ', ' + SSTATE +
017100100219     C                             ' ' + %SUBST(@9:1:5)
017200100219    * *
017300100219     C     KL#LSM        KLIST
017400100219     C                   KFLD                    SXAGCY
017500100219     C                   KFLD                    KF@STATE          2
017600100219    * *
017700100219     C                   EVAL      KF@STATE = 'MD'
017800100219     C     KL#LSM        CHAIN     BLISMR
017900100219     C                   IF        %FOUND(BLILSM)
018000100219     C                   MOVE      LSEXPD        @@EXPD
018100100219     C                   EVAL      VSMLNB = %TRIM(LSLICN)
018200100219     C                   ELSE
018300100219     C     SRSMAN        CHAIN     BLISMR
018400100219     C                   IF        %FOUND(BLILSM)
018500100219     C                   MOVE      LSEXPD        @@EXPD
018600100219     C                   EVAL      VSMLNB = %TRIM(LSLICN)
018700100219     C                   ELSE
018800100219     C                   EVAL      VSMLNB = '*UNKNOWN*'
018900100219     C                   EVAL      @@EXPD = 1
019000100219     C                   ENDIF
019100100219     C                   ENDIF
019200100219    * *
019300100219     C                   SELECT
019400100219     C                   WHEN      @@EXPD = 1
019500100219     C                   EVAL      VSMLEX = '*UNKNOWN*'
019600100219     C                   WHEN      @@EXPD = 99999999
019700100219     C                   EVAL      VSMLEX = 'NO EXPIRTN'
019800100219     C                   OTHER
019900100219     C     @@EXPD        MULT      10000.0001    #XSX
020000100219     C                   EVAL      VSMLEX = %EDITC(#XSX:'Y')
020100100219     C                   ENDSL
020200100219    * *
020300100219     C     SGRP          CHAIN     SMAN2R
020400100219     C                   IF        NOT %FOUND(SMAN2L)
020500100219     C                   EVAL      VSMEML = '*ERROR*'
020600100219     C                   GOTO      DSPREC
020700100219     C                   ENDIF
020800100219     C                   EVAL      SBREML = %TRIM(SBREML)
020900100219     C                   MOVEL(P)  SBREML        VSMEML
021000100219    * *
021100100218     C                   EXSR      $GETSNAME
021200100218     C                   EVAL      @80 = SRSMAN + '=' + %TRIM(A@40)
021300100218     C                   MOVEL(P)  @80           VSMNME
021400100218    * *
021500100218     C     DSPREC        TAG
021600100219     C                   WRITE     JUNK
021700100218     C                   DOU       FKEY = F1
021800100218     C                   EXFMT     POPWDW
021900100218     C                   ENDDO
022000100218    * *
022100100218     C                   EVAL      *INLR = *ON
022200100218     C                   RETURN
022300100218   S***S
022400100218     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
022500100218   S***S
