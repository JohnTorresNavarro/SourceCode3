000100120517     FACMUNIQUE IF   E           K DISK
000200120517     FCOMCTUNIQ IF   E           K DISK
000300120517     FPLNUNIQUE IF   E           K DISK
000400120517     FCARUNIQUE IF   E           K DISK
000500120517     FMCOVAPSE  IF   E           K DISK
000600120517     FCARPTRKP  UF A E           K DISK
000700120517     FGRATEINQ  IF   E           K DISK
000800120719     FCARRSCANAAIF   E           K DISK
000900120517      *
001000120517     FT500      O  A F  500        DISK
001100111005   X***X
001200120517     D X               S            500A   INZ
001300111005     D A               S              1A   INZ('1')
001400120517     D H_TRST          S                   LIKE(ACTRST)
001500120517     D H_SUB#          S                   LIKE(ACSUB#)
001600120517     D H_ACCT          S                   LIKE(ACACCT)
001700120517     D H_PLAN          S                   LIKE(CMPLAN)
001800111005   X***X
001900120517     C                   DOU       A = 'X'
002000120517     C     A             CASEQ     '1'           $1
002100120517     C     A             CASEQ     '2'           $2
002200120517     C     A             CASEQ     '3'           $3
002300120517     C                   ENDCS
002400120517     C                   ENDDO
002500120517    ***
002600120517     C                   EVAL      *INLR = *ON
002700120517   S***S
002800120517     C     $1            BEGSR
002900120517    ***
003000120517     C     KL#TSAP       KLIST
003100120517     C                   KFLD                    ACTRST
003200120517     C                   KFLD                    ACSUB#
003300120517     C                   KFLD                    ACACCT
003400120517     C                   KFLD                    CMPLAN
003500120517    ***
003600120517     C     KL#TSA        KLIST
003700120517     C                   KFLD                    ACTRST
003800120517     C                   KFLD                    ACSUB#
003900120517     C                   KFLD                    ACACCT
004000120517    ***
004100120517     C     KL#TSP        KLIST
004200120517     C                   KFLD                    CMTRST
004300120517     C                   KFLD                    CSUBDV
004400120517     C                   KFLD                    CMPLAN
004500120517    ***
004600120517     C                   EVAL      X = '"TRUST","SUB","ACCT","ACCT NAME","PLA' +
004700120517     C                             'N","PLAN NAME","RATE FROM","RATE TO","CAR' +
004800120517     C                             'R CODE","CARR NAME","GROUP NBR","LIVES","' +
004900120719     C                             'NOTES","AA CODE"'
005000120517     C                   EXCEPT    OUTF
005100120517    ***
005200120517     C                   EVAL      A = '2'
005300120517    ***
005400120517     C                   ENDSR
005500120517   S***S
005600120517     C     $2            BEGSR
005700120517    ***
005800120517     C                   READ      ACCMSR
005900120517     C                   IF        %EOF(ACMUNIQUE)
006000120517     C                   EVAL      A = 'X'
006100120517     C                   LEAVESR
006200120517     C                   ENDIF
006300120517    ***
006400120517     C                   IF        ATRMDT <> 0
006500120517     C                   LEAVESR
006600120517     C                   ENDIF
006700120517    ***
006800120517     C     KL#TSA        CHAIN     COMCXR
006900120517     C                   IF        NOT %FOUND(COMCTUNIQ)
007000120517     C                   LEAVESR
007100120517     C                   ENDIF
007200120517    ***
007300120517     C     KL#TSA        SETLL     COMCXR
007400120517     C                   EVAL      A = '3'
007500120517    ***
007600120517     C                   ENDSR
007700120517   S***S
007800120517     C     $3            BEGSR
007900120517    ***
008000120517     C     KL#TSA        READE     COMCXR
008100120517     C                   IF        %EOF(COMCTUNIQ)
008200120517     C                   EVAL      A = '2'
008300120517     C                   LEAVESR
008400120517     C                   ENDIF
008500120517    ***
008600120517     C                   IF        CMCAN <> 0
008700120517     C                   LEAVESR
008800120517     C                   ENDIF
008900120517    ***
009000120517     C                   IF        H_TRST <> ACTRST OR
009100120517     C                             H_SUB# <> ACSUB# OR
009200120517     C                             H_ACCT <> ACACCT OR
009300120517     C                             H_PLAN <> CMPLAN
009400120517     C                   EVAL      H_TRST = ACTRST
009500120517     C                   EVAL      H_SUB# = ACSUB#
009600120517     C                   EVAL      H_ACCT = ACACCT
009700120517     C                   EVAL      H_PLAN = CMPLAN
009800120517     C                   ELSE
009900120517     C                   LEAVESR
010000120517     C                   ENDIF
010100120517    ***
010200120517     C     KL#TSP        CHAIN     PLNMSR
010300120517     C                   IF        NOT %FOUND(PLNUNIQUE)
010400120517     C                   LEAVESR
010500120517     C                   ENDIF
010600120517    ***
010700120517     C     PCARR         CHAIN     CARMSR
010800120517     C                   IF        NOT %FOUND(CARUNIQUE)
010900120517     C                   LEAVESR
011000120517     C                   ENDIF
011100120517    ***
011200140307     C                   IF        CGRPCD <> 'AD' AND                           ADVANTICA
011300141210     C                             CGRPCD <> 'EV' AND                           AVESIS
011400140307     C                             CGRPCD <> 'AV' AND                           AVESIS
011500140307     C                             CGRPCD <> 'NV'                               NVA
011600120517     C                   LEAVESR
011700120517     C                   ENDIF
011800120517    ***
011900120827     C                   MOVE      *BLANKS       @CHGS           300
012000120827     C                   MOVE      *BLANKS       @MSG            100
012100120827    ***
012200120517     C                   EXSR      $RATE
012300120517    ***
012400120517     C                   EXSR      $COUNT
012500120517    ***
012600120517     C     KL#TSAP       CHAIN     FCRT
012700120517     C                   IF        %FOUND(CARPTRKP)
012800120517     C                   EXSR      $CHKIT
012900120517     C                   ELSE
013000120517     C                   EXSR      $MAKEIT
013100120517     C                   ENDIF
013200120517    ***
013300120517     C                   ENDSR
013400120517   S***S
013500120517     C     $CHKIT        BEGSR
013600120517    ***
013700120517     C                   IF        FCGRP <> @G
013800120517     C                   EVAL      @MSG = 'GROUP # CHANGED'
013900120517     C                   EXSR      $AD2CHGS
014000120517     C                   ENDIF
014100120517    ***
014200120517     C                   IF        #FR <> FCRFR
014300120517     C                   EVAL      @MSG = 'NEW RATES ADDED'
014400120517     C                   EXSR      $AD2CHGS
014500120517     C                   ENDIF
014600120517    ***
014700120517     C                   IF        #FR = FCRFR AND #TO <> FCRTO
014800120517     C                   EVAL      @MSG = 'RATES EXTENDED'
014900120517     C                   EXSR      $AD2CHGS
015000120517     C                   ENDIF
015100120824    ***
015200120824     C                   IF        PDESCR <> FCDESC
015300120824     C                   EVAL      @MSG = 'PLAN DESC CHANGED'
015400120824     C                   EXSR      $AD2CHGS
015500120824     C                   ENDIF
015600120517    ***
015700120517     C                   IF        @CHGS <> *BLANKS
015800120517     C                   EVAL      FCGRP = @G
015900120517     C                   EVAL      FCRFR = #FR
016000120517     C                   EVAL      FCRTO = #TO
016100120824     C                   EVAL      FCDESC = PDESCR
016200120517     C                   UPDATE    FCRT
016300120517     C                   EXSR      $PRINTIT
016400120517     C                   ENDIF
016500120517    ***
016600120517     C                   ENDSR
016700120517   S***S
016800120517     C     $AD2CHGS      BEGSR
016900120517    ***
017000120517     C                   MOVE      *ZEROS        #3                3 0
017100120517     C                   EVAL      #3 = %LEN(@CHGS)
017200120517    ***
017300120517     C                   IF        #3 = 0
017400120517     C                   EVAL      @CHGS = %TRIM(@MSG)
017500120517     C                   LEAVESR
017600120517     C                   ENDIF
017700120517    ***
017800120824     C                   IF        @CHGS = *BLANKS
017900120824     C                   EVAL      @CHGS = %TRIM(@MSG)
018000120824     C                   ELSE
018100120517     C                   EVAL      @CHGS = %TRIM(@CHGS) +
018200120517     C                             '; ' + %TRIM(@MSG)
018300120824     C                   ENDIF
018400120517    ***
018500120517     C                   ENDSR
018600120517   S***S
018700120517     C     $MAKEIT       BEGSR
018800120517    ***
018900120517     C                   CLEAR                   FCRT
019000120517    ***
019100120517     C                   EVAL      FCTRS = ACTRST
019200120517     C                   EVAL      FCSUB = ACSUB#
019300120517     C                   EVAL      FCACC = ACACCT
019400120517     C                   EVAL      FCPLN = CMPLAN
019500120517     C                   EVAL      FCGRP = @G
019600120517     C                   EVAL      FCRFR = #FR
019700120517     C                   EVAL      FCRTO = #TO
019800120517    ***
019900120517     C                   WRITE     FCRT
020000120517    ***
020100120824     C                   EVAL      @MSG = 'NEW ACCOUNT/PLAN'
020200120824     C                   EXSR      $AD2CHGS
020300120806    ***
020400120806     C                   EXSR      $PRINTIT
020500120806    ***
020600120806     C                   ENDSR
020700120806   S***S
020800120517   S***S
020900120517     C     $COUNT        BEGSR
021000120517    ***
021100120517     C                   MOVE      *ZEROS        #C                9 0
021200120517    ***
021300120517     C     KL#TSAP       CHAIN     MCOVR
021400120806     C                   IF        NOT %FOUND(MCOVAPSE)
021500120517     C                   LEAVESR
021600120517     C                   ENDIF
021700120517    ***
021800120517     C     KL#TSAP       SETLL     MCOVR
021900120517     C                   DOU       %EOF(MCOVAPSE)
022000120517     C     KL#TSAP       READE     MCOVR
022100120517     C                   IF        NOT %EOF(MCOVAPSE) AND
022200120517     C                             CANDT = 0
022300120517    ***
022400120517     C                   ADD       1             #C
022500120517    ***
022600120517     C                   ENDIF
022700120517     C                   ENDDO
022800120517    ***
022900120517     C                   ENDSR
023000120517   S***S
023100120517     C     $RATE         BEGSR
023200120517    ***
023300120517     C                   MOVE      *ZEROS        #FR               8 0
023400120517     C                   MOVE      *ZEROS        #TO               8 0
023500120517     C                   MOVE      *BLANKS       @G               15
023600120517    ***
023700120517     C     KL#TSP        CHAIN     GRATER
023800120517     C                   IF        NOT %FOUND(GRATEINQ)
023900120517     C                   LEAVESR
024000120517     C                   ENDIF
024100120517    ***
024200120517     C     KL#TSP        SETGT     GRATER
024300120517     C     KL#TSP        READPE    GRATER
024400120517     C                   EVAL      #FR = FRMDAT
024500120517     C                   EVAL      #TO = TODAT
024600120517     C                   EVAL      @G = GROUP#
024700120517    ***
024800120517     C                   ENDSR
024900120517   S***S
025000120517     C     $PRINTIT      BEGSR
025100120719    ***
025200120719     C     AACODE        CHAIN     AACODR
025300120517    ***
025400120517     C                   EVAL      X = '"' + %CHAR(FCTRS) + '","' +
025500120517     C                             %CHAR(FCSUB) + '","' + %CHAR(FCACC) + '","' +
025600120517     C                             %TRIM(ACNAM1) + '","' + FCPLN + '","' +
025700120517     C                             %TRIM(PDESCR) + '","' +
025800120517     C                             %EDITW(FCRFR:'    /  /  ') + '","' +
025900120517     C                             %EDITW(FCRTO:'    /  /  ') + '","' +
026000120517     C                             PCARR + '","' + %TRIM(CNAME) + '","' +
026100120517     C                             %TRIM(FCGRP) + '","' + %CHAR(#C) +
026200120719     C                             '","' + %TRIM(@CHGS) + '","'
026300120719     C                             + %TRIM(AFNAM) + ' ' + %TRIM(ALNAM) + '"'
026400120517    ***
026500120517     C                   EXCEPT    OUTF
026600120517    ***
026700120517     C                   ENDSR
026800120517   S***S
026900120517     OT500      EADD         OUTF
027000120517     O                       X              B   500
