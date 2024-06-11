000100101130     H*  GBS ACCESS CROSS REFERENCE QUICK AND DIRTY PROGRAM THAT BECAME PRODUCTION
000200101130     H*
000300101130     H* WRITTEN BY SK BACK IN JULY 2007
000400101130     H*
000500101130     H* PUT BACK MODIFICATION FOR FUTURE PLANS AS PER CLAIRE ON 11/30/2010
000600101130     H*   ALSO ADD A YEARS WORTH OF SCANNING TO, AS PER KEVIN
000700101130     H*    MOD 001 SSK
000800101130     H*
000900131120     H* BOSS SAY MAKE EM 90 DAYS ON 11/19/2013
001000131119     H*    MOD 002 SSK
001100190904     H* 09/04/19 dlk - add carrier code per request from Claire
001101190904     H*
001200070717     FGBSAXRF1  IF A E           K DISK
001300070717     FPLNMST    IF   E           K DISK
001400070717     FGRATE     IF   E           K DISK
001500070717     FOEPLAN    IF   E           K DISK
001600070717     FCARMST    IF   E           K DISK
001700070717     FHYPERCARR IF   E           K DISK
001800070717     FCODES     IF   E           K DISK
001900070717     FPCTMST    IF   E           K DISK
002000070717   X***X
002100070717     D H@CGRP          S                   LIKE(X1CGRP)
002200070717     D H@PDES          S                   LIKE(X1PDES)
002300070717     D H@TDES          S                   LIKE(X1TDES)
002400070717     D H@CDES          S                   LIKE(X1CDES)
002401190904     D H@CCOD          S                   LIKE(X1CCOD)
002500070717     D @STEP           S              5A
002600070717     D K@T             S              3S 0
002700070717     D K@S             S              3S 0
002800070717     D K@P             S              4A
002900070717     D K@C             S              3A
003000070717     D K@TYP           S              1A
003100070717     D K@VAL           S              2A
003200070717     D #ISO            S               D   DATFMT(*ISO)
003300070717     D #TODAY          S              8S 0
003400101130     D #FUTURE         S              8S 0
003500070717   X***X
003600070717     C                   MOVE      'PREP1'       @STEP
003700070717    ***
003800070717     C                   DOU       @STEP = 'LEAVE'
003900070717     C     @STEP         CASEQ     'PREP1'       $PREP1
004000070717     C     @STEP         CASEQ     'STEP1'       $STEP1
004100070717     C     @STEP         CASEQ     'STEP2'       $STEP2
004200070717     C     @STEP         CASEQ     'STEP3'       $STEP3
004300070717     C     @STEP         CASEQ     'STEP4'       $STEP4
004400070717     C     @STEP         CASEQ     'STEP5'       $STEP5
004500070717     C     @STEP         CASEQ     'STEP6'       $STEP6
004600070717     C                   ENDCS
004700070717     C                   ENDDO
004800070717     C                   EVAL      *INLR = *ON
004900070717   S***S
005000070717     C     $PREP1        BEGSR
005100070717    ***
005200070717     C     KL#COD        KLIST
005300070717     C                   KFLD                    K@TYP
005400070717     C                   KFLD                    K@VAL
005500070717    ***
005600070717     C     KL#TSP        KLIST
005700070717     C                   KFLD                    K@T
005800070717     C                   KFLD                    K@S
005900070717     C                   KFLD                    K@P
006000070717    ***
006100101130    *** 001 MOD BEGIN
006200101130     C                   EVAL      #ISO = %DATE
006300101130     C                   SUBDUR    1:*Y          #ISO
006400101130     C                   MOVE      #ISO          #TODAY
006500101130     C                   EVAL      #ISO = %DATE
006600131119     C****002            ADDDUR    15:*D         #ISO
006700131120     C                   ADDDUR    90:*D         #ISO
006800101130     C                   MOVE      #ISO          #FUTURE
006900101130    *** 001 MOD END
007000070717    ***
007100070717     C                   MOVE      'STEP1'       @STEP
007200070717    ***
007300070717     C                   ENDSR
007400070717   S***S
007500070717     C     $STEP1        BEGSR
007600070717    ***
007700070717     C                   READ      GRATER
007800070717    ***
007900070717     C                   IF        %EOF(GRATE)
008000070717     C                   EVAL      @STEP = 'LEAVE'
008100070717     C                   ENDIF
008200070717    ***
008300101130    *** 001 MOD BEGIN
008400101130    ***
008500101130    *** IF AN OLD RANGE [TODAT OF GRATE LESS THAN TODAY] OR IF THE
008600101130    *** RANGE IS FUTURE [FRMDAT OF GRATE IS MORE THAN 15 DAYS IN THE
008700101130    *** FUTURE], THEN BYPASS.
008800101130    ***
008900101130     C******             IF        FRMDAT > #TODAY OR TODAT < #TODAY
009000101130     C                   IF        TODAT < #TODAY OR
009100101130     C                             FRMDAT > #FUTURE
009200101130    *** 001 MOD END
009300070717     C                   LEAVESR
009400070717     C                   ENDIF
009500070717    ***
009600070717     C                   IF        GRTRST = K@T AND GRSUB# = K@S AND
009700070717     C                             GRPLAN = K@P
009800070717     C                   LEAVESR
009900070717     C                   ENDIF
010000070717    ***
010100070717     C                   EVAL      K@T = GRTRST
010200070717     C                   EVAL      K@S = GRSUB#
010300070717     C                   EVAL      K@P = GRPLAN
010400070717     C                   EVAL      H@CGRP = %TRIM(GROUP#)
010500070717     C                   MOVE      *BLANKS       H@PDES
010600070717     C                   MOVE      *BLANKS       H@TDES
010700070717     C                   MOVE      *BLANKS       H@CDES
010701190904     C                   MOVE      *BLANKS       H@CCOD
010800070717    ***
010900070717     C     KL#TSP        CHAIN(N)  GBSAF1
011000070717     C                   IF        %FOUND(GBSAXRF1)
011100070717     C                   LEAVESR
011200070717     C                   ENDIF
011300070717    ***
011400070717     C                   MOVE      'STEP2'       @STEP
011500070717    ***
011600070717     C                   ENDSR
011700070717   S***S
011800070717     C     $STEP2        BEGSR
011900070717    ***
012000070717     C     KL#TSP        CHAIN     OEPLANR
012100070717    ***
012200070717     C                   IF        %FOUND(OEPLAN) AND ODESC <> *BLANKS
012300070717     C                   EVAL      H@PDES = %TRIM(ODESC)
012400070717     C                   ENDIF
012500070717    ***
012600070717     C                   MOVE      'STEP3'       @STEP
012700070717    ***
012800070717     C                   ENDSR
012900070717   S***S
013000070717     C     $STEP3        BEGSR
013100070717    ***
013200070717     C     KL#TSP        CHAIN     PLNMSR
013300070717    ***
013400070717     C                   IF        NOT %FOUND(PLNMST)
013500070717     C                   MOVE      'STEP1'       @STEP
013600070717     C                   ENDIF
013700070717    ***
013800070717     C                   IF        H@PDES = *BLANKS
013900070717     C                   EVAL      H@PDES = %TRIM(PDESCR)
014000070717     C                   ENDIF
014100070717    ***
014200070717     C                   EVAL      K@C = PCARR
014300070717     C                   EVAL      K@TYP = %SUBST(PLNCAT:1:1)
014400070717     C                   EVAL      K@VAL = %SUBST(PLNCAT:2:2)
014401190904
014402190904     C                   EVAL      H@CCOD = pcarr
014500070717    ***
014600070717     C                   MOVE      'STEP4'       @STEP
014700070717    ***
014800070717     C                   ENDSR
014900070717   S***S
015000070717     C     $STEP4        BEGSR
015100070717    ***
015200070717     C     K@C           CHAIN     CARMSR
015300070717    ***
015400070717     C                   IF        %FOUND(CARMST)
015500070717     C     CGRPCD        CHAIN     RHC
015600070717     C                   IF        NOT %FOUND(HYPERCARR)
015700070717     C                   EVAL      HCNAME = '*UNDEFINED*'
015800070717     C                   ENDIF
015900070717     C                   ELSE
016000070717     C                   EVAL      HCNAME = '*UNDEFINED*'
016100070717     C                   ENDIF
016200070717    ***
016300070717     C                   EVAL      H@CDES = %TRIM(HCNAME)
016400070717     C                   MOVE      'STEP5'       @STEP
016500070717    ***
016600070717     C                   ENDSR
016700070717   S***S
016800070717     C     $STEP5        BEGSR
016900070717    ***
017000070717     C     KL#COD        CHAIN     CODESR
017100070717    ***
017200070717     C                   IF        %FOUND(CODES)
017300070717     C     ACTION        CHAIN     PCTR
017400070717     C                   IF        NOT %FOUND(PCTMST)
017500070717     C                   EVAL      PCDES = '*UNDEFINED*'
017600070717     C                   ENDIF
017700070717     C                   ELSE
017800070717     C                   EVAL      PCDES = '*UNDEFINED*'
017900070717     C                   ENDIF
018000070717    ***
018100070717     C                   EVAL      H@TDES = %TRIM(PCDES)
018200070717     C                   MOVE      'STEP6'       @STEP
018300070717    ***
018400070717     C                   ENDSR
018500070717   S***S
018600070717     C     $STEP6        BEGSR
018700070717    ***
018800070717     C                   CLEAR                   GBSAF1
018900070717    ***
019000070717     C                   EVAL      X1TRST = K@T
019100070717     C                   EVAL      X1SUBD = K@S
019200070717     C                   EVAL      X1PLAN = K@P
019300070717     C                   EVAL      X1CGRP = H@CGRP
019400070717     C                   EVAL      X1PDES = H@PDES
019500070717     C                   EVAL      X1TDES = H@TDES
019600070717     C                   EVAL      X1CDES = H@CDES
019601190904     C                   EVAL      X1CCOD = H@CCOD
019700070717    ***
019800070911     C                   WRITE(E)  GBSAF1
019900070717     C                   MOVE      'STEP1'       @STEP
020000070717    ***
020100070717     C                   ENDSR
020200070717   S***S
