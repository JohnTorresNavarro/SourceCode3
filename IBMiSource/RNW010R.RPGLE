000100160412      *========================================================================
000200160412     H option(*noDebugIo)
000300160412      *========================================================================
000400131010    *** Renewal 90 Day Letter Main Extract
000500131010    ***
000600131010    *** 10/10/13 sbt Hist file expansion project
000700160412
000800160412    *** 04/11/16 jt  Added plan aux to determine what record is SHOP
000900160412
001000160412      *========================================================================
001100160412
001200060707     FACCMST    IF   E           K DISK    PREFIX(Z:1)
001300060727     FTRSMST    IF   E           K DISK
001400060706     FMCOV14    IF   E           K DISK
001500060706     FTRKRNWLP  IF   E           K DISK
001600060706     FCARMKSZ1  IF   E           K DISK
001700060706     FPLNMST    IF   E           K DISK
001800160411     FPLNAUXP   IF   E           K DISK
001900060706     FCMCT33    IF   E           K DISK
002000060706     FSMANRLT   IF   E           K DISK
002100060706     FSPRAGXR2  IF   E           K DISK
002200060713    ***
002300060713     FRNWP017A  UF A E           K DISK
002400060713     FRNWP018A  UF A E           K DISK
002500060713     FRNWP019A  UF A E           K DISK
002600060706    ***
002700060705     FSMAN      IF   E           K DISK
002800060705     FAGENCY    IF   E           K DISK
002900060705     FSUPRAGCY  IF   E           K DISK
003000060706    ***
003100060706     FACCPRDL1  IF   E           K DISK
003200060706     FACCMSTP   IF   E           K DISK
003300060706     FBRKPRDL7  IF   E           K DISK
003400060706     FMKTSIZP   IF   E           K DISK
003500060706     FPRDMSTP   IF   E           K DISK
003600060727    ***
003700101102     FRNW01GRW  IF   E           K DISK
003800060727     FRNWP01WF  UF A E           K DISK
003900060727     FHIST      O  A E             DISK    PREFIX(V)
004000060706    ***
004100060711     FRNWP010   O  A F  900        DISK
004200060711     FRNWP011   O  A F  900        DISK
004300060711     FRNWP012   O  A F  900        DISK
004400060711     FRNWP013   O  A F  900        DISK
004500060711     FRNWP014   O  A F  900        DISK
004600060711     FRNWP015   O  A F  900        DISK
004700060711     FRNWP016   O  A F  900        DISK
004800060706   X***X
004900060706     D @S              S              1A   INZ('A')
005000060711     D O@              S            900A   INZ
005100060713     D O10             S            900A   INZ
005200060713     D O11             S            900A   INZ
005300060713     D O12             S            900A   INZ
005400060713     D O13             S            900A   INZ
005500060713     D O14             S            900A   INZ
005600060713     D O15             S            900A   INZ
005700060713     D O16             S            900A   INZ
005800060705     D S@              C                   CONST('","')
005900060710     D RUNDATE         S              8S 0
006000060727     D ISOTDAY         S               D   DATFMT(*ISO)
006100060710     D ISORUNDATE      S               D   DATFMT(*ISO)
006200060710     D RUNTEXT         S             20A
006300060710     D RUNMONTH        S              2S 0
006400060710     D RUN#            S              8S 0
006500060707    ***
006600060707     D F@TRS           S                   LIKE(ZCTRST)
006700060707     D F@SUB           S                   LIKE(ZCSUB#)
006800060707     D F@ACC           S                   LIKE(ZCACCT)
006900060706     D F@PLN           S                   LIKE(PLPLAN)
007000060706     D F@CAR           S              3A
007100060706     D F@MSZ           S              5A
007200060706    ***
007300060706     D G@ACCT          S             10A
007400060706     D G@PRID          S             10A
007500060706     D G@CAID          S             10A
007600060706     D G@CGRP          S             10A
007700060706     D G@MKSZ          S             10A
007800060713     D L@ACC           S             20A
007900060713     D L@ANM           S             50A
008000060713     D L@BKR           S             50A
008100060713     D L@SMN           S             30A
008200110602    ? * Program status data structure
008300110602    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
008400060706   X***X
008500060706     C                   EVAL      O@ = '"TRUST","SUB","ACCT","GA ACCT","NEXT' +
008600060707     C                             ' RENEWAL","ACCOUNT NAME","MKT SIZE","MKT ' +
008700060710     C                             'FROM","MKT TO","CARRIER","CARRIER GROUP #'+
008800060707     C                             '","PLAN #","PLAN DESCRIPTION",' +
008900060706     C                             '"# MEM","PLAN CAT","SERVICING BROKER CODE' +
009000060706     C                             '","SERVICING BROKER NAME","RELATIONSHIP I' +
009100060706     C                             'D","BROKER CODE","SMAN LNAME","SMAN FNAME' +
009200060706     C                             '","SMAN NAME","AGY #","AGENCY DESCRIP","S' +
009300060706     C                             'UPER AGY #","SUPER AGENCY DESCRIP","GBREP' +
009400060706     C                             '","ELECTED","DEFAULT","TERM","DATE TO CAR' +
009500060706     C                             'RIER","DATE TO ADMIN","COMMENT","DATE REC' +
009600060706     C                             'VD IN ADMIN","GRP # REC","ACCT INSTALL","' +
009700060706     C                             'DATA ENTRY","INVOICE MAILED","Q/A COMM","' +
009800060706     C                             'GRP # LAG TIME","DAYS IN ACCT","DAY IN AC' +
009900060706     C                             'CT","TOTAL ADMIN TIME","DTE RETURNED","RE' +
010000060706     C                             'SUBMISSION","SENT TO CLIENT","SENT TO BRO' +
010100060706     C                             'KER"'
010200060711     C                   EVAL      O10 = O@
010300060711     C                   EXCEPT    O10F
010400060711     C                   EVAL      O11 = O@
010500060711     C                   EXCEPT    O11F
010600060711     C                   EVAL      O12 = O@
010700060711     C                   EXCEPT    O12F
010800060711     C                   EVAL      O13 = O@
010900060711     C                   EXCEPT    O13F
011000060711     C                   EVAL      O14 = O@
011100060711     C                   EXCEPT    O14F
011200060711     C                   EVAL      O15 = O@
011300060711     C                   EXCEPT    O15F
011400060711     C                   EVAL      O16 = O@
011500060711     C                   EXCEPT    O16F
011600060710    ***
011700060710     C     *ENTRY        PLIST
011800060710     C                   PARM                    @8                8
011900060710    ***
012000060710     C                   MOVE      @8            RUNDATE
012100060710     C                   MOVE      RUNDATE       ISORUNDATE
012200060710     C                   EXTRCT    ISORUNDATE:*M RUNMONTH
012300060710     C     *USA          MOVE      ISORUNDATE    RUN#
012400060710     C                   EVAL      RUNTEXT = %EDITC(RUN#:'Y')
012500060706    ***
012600060707     C                   DOU       @S = '7'
012700060707*************GBS
012800060707     C     @S            CASEQ     'A'           $RFTRKRNW
012900060710     C     @S            CASEQ     'B'           $CFACCMST
013000060710     C     @S            CASEQ     'C'           $CFMCOV
013100060710     C     @S            CASEQ     'D'           $MBR_CNT
013200060710     C     @S            CASEQ     'E'           $CFPLNM
013300060710     C     @S            CASEQ     'F'           $CFMKSZ
013400060710     C     @S            CASEQ     'G'           $SFCTX
013500060710     C     @S            CASEQ     'H'           $RFCTX
013600060710     C     @S            CASEQ     'I'           $CFSRL
013700060710     C     @S            CASEQ     'J'           $CFSMN
013800060710     C     @S            CASEQ     'K'           $CFSPR
013900060710     C     @S            CASEQ     'L'           $CFAGCY
014000060710     C     @S            CASEQ     'M'           $CFSUPR
014100060710     C     @S            CASEQ     'N'           $WFOUTPUT
014200060707*************GAS
014300060710     C     @S            CASEQ     'O'           $RGACP
014400060710     C     @S            CASEQ     'P'           $CGACM
014500060710     C     @S            CASEQ     'Q'           $CGMSZ
014600060710     C     @S            CASEQ     'R'           $CGPDM
014700060710     C     @S            CASEQ     'S'           $SGBRP
014800060710     C     @S            CASEQ     'T'           $RGBRP
014900060710     C     @S            CASEQ     'U'           $CGSMN
015000060710     C     @S            CASEQ     'V'           $CGAGCY
015100060710     C     @S            CASEQ     'W'           $CGSUPR
015200060710     C     @S            CASEQ     'X'           $WGOUTPUT
015300060706     C                   ENDCS
015400060707    ***
015500060706     C                   ENDDO
015600060706    ***
015700060710     C                   EVAL      *INLR = *ON
015800060706    ***
015900060706   S***S
016000060706     C     *INZSR        BEGSR
016100060706    ***
016200060707     C     F#TSA         KLIST
016300060706     C                   KFLD                    F@TRS
016400060706     C                   KFLD                    F@SUB
016500060706     C                   KFLD                    F@ACC
016600060713    ***
016700060713     C     L#NABS        KLIST
016800060713     C                   KFLD                    L@ANM
016900060713     C                   KFLD                    L@ACC
017000060713     C                   KFLD                    L@BKR
017100060713     C                   KFLD                    L@SMN
017200060707    ***
017300060707     C     F#TSAP        KLIST
017400060707     C                   KFLD                    F@TRS
017500060707     C                   KFLD                    F@SUB
017600060707     C                   KFLD                    F@ACC
017700060707     C                   KFLD                    F@PLN
017800060706    ***
017900060707     C     F#TSP         KLIST
018000060707     C                   KFLD                    F@TRS
018100060707     C                   KFLD                    F@SUB
018200060707     C                   KFLD                    F@PLN
018300060706    ***
018400060707     C     F#CM          KLIST
018500060707     C                   KFLD                    F@CAR
018600060707     C                   KFLD                    F@MSZ
018700060706    ***
018800060707     C     G#PAG         KLIST
018900060707     C                   KFLD                    APPRID
019000060707     C                   KFLD                    APACCT
019100060707     C                   KFLD                    APCGRP
019200060706    ***
019300060707     C     G#CM          KLIST
019400060707     C                   KFLD                    APCAID
019500060707     C                   KFLD                    APMKSZ
019600060906    ***
019700060906     C                   MOVE      *DATE         ISOTDAY
019800060707    ***
019900060707     C                   ENDSR
020000060707   S***S
020100060707     C     $RFTRKRNW     BEGSR
020200060707    ***
020300060707     C                   READ      TRKRNWLR
020400060707    ***
020500060710     C                   IF        %EOF(TRKRNWLP)
020600060707     C                   EVAL      @S = 'O'
020700060707     C                   LEAVESR
020800060707     C                   ENDIF
020900060707    ***
021000060707     C                   IF        TRNONRN = ' ' AND TRNRNDT = RUNDATE
021100060707     C                   EVAL      @S = 'B'
021200060707     C                   EVAL      F@TRS = TRTRST
021300060707     C                   EVAL      F@SUB = TRSUB#
021400060707     C                   EVAL      F@ACC = TRACCT
021500060707     C                   EVAL      F@PLN = TRPLAN
021600060707     C                   EVAL      F@CAR = TRPCARR
021700060707     C                   EVAL      F@MSZ = TRMKTSIZE
021800060707     C                   LEAVESR
021900060707     C                   ENDIF
022000060706    ***
022100060706     C                   ENDSR
022200060706   S***S
022300060707     C     $CFACCMST     BEGSR
022400060706    ***
022500060707     C     F#TSA         CHAIN     ACCMSR
022600060706    ***
022700060707     C                   IF        NOT %FOUND(ACCMST)
022800060707     C                   EVAL      @S = 'A'
022900060706     C                   LEAVESR
023000060706     C                   ENDIF
023100060706    ***
023200060707     C                   IF        ZTRMDT = 0
023300060727     C     F@TRS         CHAIN     TRSMSR
023400060707     C     ZMANCD        CHAIN     SMANR
023500060707     C                   EXSR      $GETSNAME
023600060707     C                   MOVEL(P)  A@40          SRV@SMAN         40
023700060707     C                   EVAL      @S = 'C'
023800060706     C                   LEAVESR
023900060706     C                   ENDIF
024000060706    ***
024100060710     C                   EVAL      @S = 'A'
024200060710    ***
024300060706     C                   ENDSR
024400060706   S***S
024500060707     C     $CFMCOV       BEGSR
024600060706    ***
024700060707     C     F#TSAP        CHAIN     MCOVR
024800060706    ***
024900060707     C                   IF        %FOUND(MCOV14)
025000060707     C                   EVAL      @S = 'D'
025100060706     C                   ELSE
025200060706     C                   EVAL      @S = 'A'
025300060706     C                   ENDIF
025400060707    ***
025500060707     C                   ENDSR
025600060707   S***S
025700060707     C     $MBR_CNT      BEGSR
025800060707    ***
025900060707     C                   EVAL      #PCNT = 0
026000060706    ***
026100060707     C     F#TSAP        SETLL     MCOVR
026200060707     C                   DOU       %EOF(MCOV14)
026300060707     C     F#TSAP        READE     MCOVR
026400060707     C                   IF        NOT %EOF(MCOV14) AND CANDT = 0
026500060706    ***
026600060710     C                   ADD       1             #PCNT             7 0
026700060707    ***
026800060706     C                   ENDIF
026900060710     C                   ENDDO
027000060707    ***
027100060707     C                   IF        #PCNT = 0
027200060707     C                   EVAL      @S = 'A'
027300060707     C                   ELSE
027400060707     C                   EVAL      @S = 'E'
027500060707     C                   ENDIF
027600060706    ***
027700060706     C                   ENDSR
027800060706   S***S
027900060707     C     $CFPLNM       BEGSR
028000060707    ***
028100060707     C     F#TSP         CHAIN     PLNMSR
028200060706    ***
028300060707     C                   IF        %FOUND(PLNMST)
028400060707     C                   EVAL      @S = 'F'
028500060707     C                   ELSE
028600060707     C                   EVAL      @S = 'A'
028700060707     C                   ENDIF
028800060706    ***
028900060706     C                   ENDSR
029000060706   S***S
029100060707     C     $CFMKSZ       BEGSR
029200060707    ***
029300060707     C     F#CM          SETLL     RCARMKSZ
029400060707     C                   DOU       %EOF(CARMKSZ1)
029500060707     C     F#CM          READE     RCARMKSZ
029600101104     C                   IF        NOT %EOF(CARMKSZ1) AND
029700101104     C                             RUNDATE >= CZFRDT AND
029800101104     C                             (RUNDATE <= CZTODT OR CZTODT = 0)
029900060707    ***
030000060707     C                   EVAL      @S = 'G'
030100060707     C                   LEAVESR
030200060707    ***
030300060707     C                   ENDIF
030400060707     C                   ENDDO
030500060707    ***
030600060707     C                   EVAL      @S = 'A'
030700060706    ***
030800060706     C                   ENDSR
030900060706   S***S
031000060707     C     $SFCTX        BEGSR
031100060706    ***
031200060707     C     F#TSAP        SETLL     COMCXR
031300060707     C                   IF        %EQUAL
031400060707     C                   EVAL      @S = 'H'
031500060707     C                   LEAVESR
031600060707     C                   ENDIF
031700060707    ***
031800060707     C                   EVAL      @S = 'A'
031900060706    ***
032000060706     C                   ENDSR
032100060706   S***S
032200060707     C     $RFCTX        BEGSR
032300060706    ***
032400060707     C     F#TSAP        READE     COMCXR
032500060707    ***
032600060707     C                   IF        %EOF(CMCT33)
032700060707     C                   EVAL      @S = 'A'
032800060707     C                   LEAVESR
032900060707     C                   ENDIF
033000060707    ***
033100060707     C                   IF        CMCAN = 0
033200060707     C                   EVAL      @S = 'I'
033300060707     C                   ENDIF
033400060706    ***
033500060706     C                   ENDSR
033600060706   S***S
033700060707     C     $CFSRL        BEGSR
033800060706    ***
033900060707     C     CMRELID       CHAIN     SRF
034000060707    ***
034100060707     C                   IF        %FOUND(SMANRLT)
034200060707     C                   EVAL      @S = 'J'
034300060707     C                   ELSE
034400060707     C                   EVAL      @S = 'H'
034500060707     C                   ENDIF
034600060706    ***
034700060706     C                   ENDSR
034800060706   S***S
034900060707     C     $CFSMN        BEGSR
035000060706    ***
035100060707     C     SRSMAN        CHAIN     SMANR
035200060707    ***
035300060707     C                   IF        %FOUND(SMAN)
035400060707     C                   EVAL      @S = 'K'
035500060707     C                   EXSR      $GETSNAME
035600060707     C                   ELSE
035700060707     C                   EVAL      @S = 'H'
035800060707     C                   ENDIF
035900060706    ***
036000060706     C                   ENDSR
036100060706   S***S
036200060707     C     $CFSPR        BEGSR
036300060706    ***
036400060707     C     SRASID        CHAIN     SXF
036500060707    ***
036600060707     C                   IF        %FOUND(SPRAGXR2)
036700060707     C                   EVAL      @S = 'L'
036800060707     C                   ELSE
036900060707     C                   EVAL      @S = 'H'
037000060707     C                   ENDIF
037100060706    ***
037200060706     C                   ENDSR
037300060706   S***S
037400060707     C     $CFAGCY       BEGSR
037500060706    ***
037600060707     C     SXAGCY        CHAIN     AGENR
037700060707    ***
037800060707     C                   IF        %FOUND(AGENCY)
037900060707     C                   EVAL      @S = 'M'
038000060707     C                   ELSE
038100060707     C                   EVAL      @S = 'H'
038200060707     C                   ENDIF
038300060706    ***
038400060706     C                   ENDSR
038500060706   S***S
038600060707     C     $CFSUPR       BEGSR
038700060706    ***
038800060707     C     SXSUPER       CHAIN     SAF
038900060707    ***
039000060707     C                   IF        %FOUND(SUPRAGCY)
039100060707     C                   EVAL      @S = 'N'
039200060707     C                   ELSE
039300060707     C                   EVAL      @S = 'H'
039400060707     C                   ENDIF
039500060706    ***
039600060706     C                   ENDSR
039700060706   S***S
039800060707     C     $WFOUTPUT     BEGSR
039900060727    ***
040000060906     C                   EXSR      $WRTHST
040100060706    ***
040200060809     C                   EVAL      O@ = %EDITC(F@TRS:'X') + ',' +
040300060809     C                             %EDITC(F@SUB:'X') + ',' + %EDITC(F@ACC:'X') +
040400060809     C                             ',"","' + %TRIM(RUNTEXT) + S@ +
040500060710     C                             %TRIM(ZCNAM1) + S@ + %TRIM(F@MSZ) + S@ +
040600060809     C                             %EDITC(CZFRSZ:'X') + S@ + %EDITC(CZTOSZ:'X')
040700060809     C                             + S@ + %TRIM(F@CAR) +
040800060707     C                             S@ + %TRIM(TRGROUP#) + S@ + %TRIM(F@PLN) +
040900060809     C                             S@ + %TRIM(PDESCR) + '",' + %EDITC(#PCNT:'X')
041000060809     C                             + ',"' + TRPLNCAT +
041100060707     C                             S@ + ZMANCD + S@ + %TRIM(SRV@SMAN) + S@ +
041200060707     C                             CMRELID + S@ + SRSMAN + S@ + %TRIM(SLNAME) +
041300060707     C                             S@ + %TRIM(SFNAME) + S@ + %TRIM(A@40) + S@ +
041400060707     C                             SXAGCY + S@ + %TRIM(AGNAM1) + S@ +
041500060710     C                             SXSUPER + S@ + %TRIM(SANAME1) + '"'
041600060727    ***
041700060727     C                   CLEAR                   R01WF
041800061027     C                   EVAL      RFSUPER = SXSUPER
041900061027     C                   EVAL      RFAGCY = SXAGCY
042000101102     C                   EVAL      RFAN = AGNAM1
042100101104     C                   EVAL      RFSMAN = SMANCD
042200061018     C                   EVAL      RFPROD = PLPLAN
042300060727     C                   EVAL      RFLN = SLNAME
042400060727     C                   EVAL      RFFN = SFNAME
042500060727     C                   EVAL      RFMI = SMI
042600060727     C                   EVAL      RFADR = SADDR
042700060727     C                   EVAL      RFCITY = SCITY
042800060727     C                   EVAL      RFST = SSTATE
042900060727     C                   MOVE      SZIPCD        @9                9
043000060727     C                   EVAL      RFZIP = %SUBST(@9:1:5)
043100060727     C                   Z-ADD     ZOEMPL        RFNOEMP
043200060727     C                   EVAL      RFTN = %TRIM(TNAME)
043300060809     C                   EVAL      RFTSA = %EDITC(F@TRS:'X') +
043400060809     C                             %EDITC(F@SUB:'X') +
043500060809     C                             %EDITC(F@ACC:'X')
043600060727     C                   EVAL      RFDES = PDESCR
043700060727     C                   MOVE      ISOTDAY       #8                8 0
043800060727     C                   MOVE      #8            RFPD
043900060727     C                   MOVE      RUNDATE       RFRD
044000060727     C                   MOVEL(P)  ZCNAM1        RFACN
044100160411
044200160412     C     f#tsp         chain     plnauxr
044300160411       if pxexchg = 'Y';
044400160413        rfacn = %trim('*-') + %trim(rfacn);
044500160411       endif;
044600160411
044700101104     C                   WRITE(E)  R01WF
044800060711    ***
044900060713     C                   MOVE      F@TRS         @3                3
045000060713     C                   EVAL      L@ACC = @3
045100060713     C                   MOVE      F@SUB         @3
045200060713     C                   EVAL      L@ACC = %TRIM(L@ACC) + '-' + @3
045300060713     C                   MOVE      F@ACC         @4                4
045400060713     C                   EVAL      L@ACC = %TRIM(L@ACC) + '-' + @4
045500060713    * *
045600060713     C                   EVAL      L@ANM = %TRIM(ZCNAM1)
045700060713     C                   IF        SXAGCY = '226'
045800060713     C                   EVAL      L@BKR = 'MEDCHI AGENCY'
045900060713     C                   ELSE
046000060713     C                   EVAL      L@BKR = %TRIM(SRV@SMAN)
046100060713     C                   ENDIF
046200060713     C                   EVAL      L@SMN = ZMANCD
046300060713    * *
046400060713     C                   SELECT
046500060713     C                   WHEN      F@CAR = 'BCM' OR F@CAR = 'BMS' OR
046600060713     C                             F@CAR = 'BVS'
046700060713     C     L#NABS        CHAIN     F019A
046800060713     C                   IF        NOT %FOUND(RNWP019A)
046900060713     C                   EVAL      R9ACC = L@ACC
047000060713     C                   EVAL      R9ANM = L@ANM
047100060713     C                   EVAL      R9BKR = L@BKR
047200060713     C                   EVAL      R9SMN = L@SMN
047300060713     C                   WRITE     F019A
047400060713     C                   ENDIF
047500060713     C                   WHEN      F@CAR = 'BVP' OR F@CAR = 'NHD' OR
047600060713     C                             F@CAR = 'NHM' OR F@CAR = 'NID' OR
047700060713     C                             F@CAR = 'NIM' OR F@CAR = 'NRX' OR
047800060713     C                             F@CAR = 'BVM'
047900060713     C     L#NABS        CHAIN     F018A
048000060713     C                   IF        NOT %FOUND(RNWP018A)
048100060713     C                   EVAL      R8ACC = L@ACC
048200060713     C                   EVAL      R8ANM = L@ANM
048300060713     C                   EVAL      R8BKR = L@BKR
048400060713     C                   EVAL      R8SMN = L@SMN
048500060713     C                   WRITE     F018A
048600060713     C                   ENDIF
048700060713     C                   WHEN      F@CAR <> 'BCM' AND F@CAR <> 'BMS' AND
048800060713     C                             F@CAR <> 'BVS' AND F@CAR <> 'BVP' AND
048900060713     C                             F@CAR <> 'NHD' AND F@CAR <> 'NHM' AND
049000060713     C                             F@CAR <> 'NID' AND F@CAR <> 'NIM' AND
049100060713     C                             F@CAR <> 'NRX' AND F@CAR <> 'BVM'
049200060713     C     L#NABS        CHAIN     F017A
049300060713     C                   IF        NOT %FOUND(RNWP017A)
049400060713     C                   EVAL      R7ACC = L@ACC
049500060713     C                   EVAL      R7ANM = L@ANM
049600060713     C                   EVAL      R7BKR = L@BKR
049700060713     C                   EVAL      R7SMN = L@SMN
049800060713     C                   WRITE     F017A
049900060713     C                   ENDIF
050000060713     C                   ENDSL
050100060713    ***
050200060711     C                   EVAL      O10 = O@
050300060711     C                   EXCEPT    O10F
050400060711    ***
050500060711     C                   SELECT
050600060711     C                   WHEN      SXAGCY = '226'
050700060711     C                   EVAL      O11 = O@
050800060711     C                   EXCEPT    O11F
050900060711     C                   WHEN      SXSUPER = '307'
051000060711     C                   EVAL      O12 = O@
051100060711     C                   EXCEPT    O12F
051200060711     C                   WHEN      SXSUPER = '389' OR SXSUPER = '390'
051300060711     C                   EVAL      O13 = O@
051400060711     C                   EXCEPT    O13F
051500060711     C                   OTHER
051600060711     C                   EVAL      O14 = O@
051700060711     C                   EXCEPT    O14F
051800060711     C                   ENDSL
051900060711    ***
052000060711     C                   SELECT
052100060711     C                   WHEN      F@CAR = 'BCM' OR F@CAR = 'BMS' OR
052200060711     C                             F@CAR = 'BVS'
052300060711     C                   EVAL      O15 = O@
052400060711     C                   EXCEPT    O15F
052500060711     C                   WHEN      F@CAR <> 'BCM' AND F@CAR <> 'BMS' AND
052600060711     C                             F@CAR <> 'BVS' AND F@CAR <> 'BVP' AND
052700060711     C                             F@CAR <> 'NHD' AND F@CAR <> 'NHM' AND
052800060711     C                             F@CAR <> 'NID' AND F@CAR <> 'NIM' AND
052900060711     C                             F@CAR <> 'NRX' AND F@CAR <> 'BVM'
053000060711     C                   EVAL      O16 = O@
053100060711     C                   EXCEPT    O16F
053200060711     C                   ENDSL
053300060707    ***
053400060707     C                   EVAL      @S = 'H'
053500060706    ***
053600060706     C                   ENDSR
053700060706   S***S
053800060707     C     $RGACP        BEGSR
053900060706    ***
054000060710     C                   READ      ACCPRDR
054100060710    ***
054200060710     C                   IF        %EOF(ACCPRDL1)
054300060710     C                   EVAL      @S = '7'
054400060710     C                   LEAVESR
054500060707     C                   ENDIF
054600101102    ***
054700101102     C     APCAID        CHAIN     RNW01GR
054800101102     C                   IF        NOT %FOUND(RNW01GRW) OR
054900101102     C                             RGRENEW = 'N'
055000101102     C                   LEAVESR
055100101102     C                   ENDIF
055200060707    ***
055300060707     C                   IF        APTRDT >= ISORUNDATE AND APRMON = RUNMONTH
055400060707     C                   EVAL      @S = 'P'
055500060707     C                   ENDIF
055600060706    ***
055700060706     C                   ENDSR
055800060706   S***S
055900060707     C     $CGACM        BEGSR
056000060706    ***
056100060809     C     APACCT        CHAIN     ACCMSTR
056200060707    ***
056300060707     C                   IF        %FOUND(ACCMSTP) AND ADIMD = 'N'
056400060707     C                   EVAL      @S = 'Q'
056500060707     C                   ELSE
056600060707     C                   EVAL      @S = 'O'
056700060707     C                   ENDIF
056800060706    ***
056900060706     C                   ENDSR
057000060706   S***S
057100060707     C     $CGMSZ        BEGSR
057200060707    ***
057300060809     C     G#CM          CHAIN     MKTSIZR
057400060707    ***
057500060707     C                   IF        %FOUND(MKTSIZP)
057600060707     C                   EVAL      @S = 'R'
057700060707     C                   ELSE
057800060707     C                   EVAL      @S = 'O'
057900060707     C                   ENDIF
058000060707    ***
058100060707     C                   ENDSR
058200060707   S***S
058300060707     C     $CGPDM        BEGSR
058400060707    ***
058500060809     C     APPRID        CHAIN     PRDMSTR
058600060707    ***
058700060707     C                   IF        %FOUND(PRDMSTP)
058800060707     C                   EVAL      @S = 'S'
058900060707     C                   ELSE
059000060707     C                   EVAL      @S = 'O'
059100060707     C                   ENDIF
059200060707    ***
059300060707     C                   ENDSR
059400060707   S***S
059500060707     C     $SGBRP        BEGSR
059600060707    ***
059700060707     C     G#PAG         SETLL     BRKPRDR
059800060707     C                   IF        %EQUAL
059900060707     C                   EVAL      @S = 'T'
060000060707     C                   LEAVESR
060100060707     C                   ENDIF
060200060707    ***
060300060707     C                   EVAL      @S = 'O'
060400060707    ***
060500060707     C                   ENDSR
060600060707   S***S
060700060707     C     $RGBRP        BEGSR
060800060707    ***
060900060707     C     G#PAG         READE     BRKPRDR
061000060707    ***
061100060707     C                   IF        %EOF(BRKPRDL7)
061200060707     C                   EVAL      @S = 'O'
061300060707     C                   LEAVESR
061400060707     C                   ENDIF
061500060707    ***
061600060707     C                   IF        BPTRDT >= ISORUNDATE
061700060707     C                   EVAL      @S = 'U'
061800060707     C                   ENDIF
061900060707    ***
062000060707     C                   ENDSR
062100060707   S***S
062200060707     C     $CGSMN        BEGSR
062300060707    ***
062400060707     C     BPSMAN        CHAIN     SMANR
062500060707    ***
062600060707     C                   IF        %FOUND(SMAN)
062700060707     C                   EVAL      @S = 'V'
062800060707     C                   EXSR      $GETSNAME
062900060707     C                   ELSE
063000060707     C                   EVAL      @S = 'T'
063100060707     C                   ENDIF
063200060707    ***
063300060707     C                   ENDSR
063400060707   S***S
063500060707     C     $CGAGCY       BEGSR
063600060707    ***
063700060707     C     BPAGCY        CHAIN     AGENR
063800060707    ***
063900060707     C                   IF        %FOUND(AGENCY)
064000060707     C                   EVAL      @S = 'W'
064100060707     C                   ELSE
064200060707     C                   EVAL      @S = 'T'
064300060707     C                   ENDIF
064400060707    ***
064500060707     C                   ENDSR
064600060707   S***S
064700060710     C     $CGSUPR       BEGSR
064800060707    ***
064900060707     C     BPSUPER       CHAIN     SAF
065000060707    ***
065100060707     C                   IF        %FOUND(SUPRAGCY)
065200060707     C                   EVAL      @S = 'X'
065300060707     C                   ELSE
065400060707     C                   EVAL      @S = 'T'
065500060707     C                   ENDIF
065600060707    ***
065700060707     C                   ENDSR
065800060707   S***S
065900060707     C     $WGOUTPUT     BEGSR
066000060707    ***
066100060712     C                   EVAL      O@ = '"","","",' + APACCT + ',"' +
066200060712     C                             %TRIM(RUNTEXT) + S@ +
066300060712     C                             %TRIM(ADNAME) + S@ + %TRIM(APMKSZ) + S@
066400060809     C                             + %EDITC(MSFRSZ:'X') + S@
066500060809     C                             + %EDITC(MSTOSZ:'X') + S@ + %TRIM(APCAID) +
066600060707     C                             S@ + %TRIM(APCGRP) + S@ + %TRIM(APPRID) +
066700060710     C                             S@ + %TRIM(PMNAME) + '",' +
066800060710     C                             %TRIM(%CHAR(ADBENR)) + ',"' + TRPLNCAT +
066900060710     C                             S@ + BPSMAN + S@ + %TRIM(A@40) + S@ +
067000060710     C                             CMRELID + S@ + BPSMAN + S@ + %TRIM(SLNAME) +
067100060707     C                             S@ + %TRIM(SFNAME) + S@ + %TRIM(A@40) + S@ +
067200060710     C                             BPAGCY + S@ + %TRIM(AGNAM1) + S@ +
067300060710     C                             BPSUPER + S@ + %TRIM(SANAME1) + '"'
067400060707    ***
067500060727     C                   CLEAR                   R01WF
067600061018     C                   EVAL      RFCGRP = APCGRP
067700061027     C                   EVAL      RFSUPER = BPSUPER
067800061027     C                   EVAL      RFAGCY = BPAGCY
067900101102     C                   EVAL      RFAN = AGNAM1
068000061018     C                   EVAL      RFSMAN = BPSMAN
068100061018     C                   EVAL      RFPROD = APPRID
068200060727     C                   EVAL      RFLN = SLNAME
068300060727     C                   EVAL      RFFN = SFNAME
068400060727     C                   EVAL      RFMI = SMI
068500060727     C                   EVAL      RFADR = SADDR
068600060727     C                   EVAL      RFCITY = SCITY
068700060727     C                   EVAL      RFST = SSTATE
068800060727     C                   MOVE      SZIPCD        @9                9
068900060727     C                   EVAL      RFZIP = %SUBST(@9:1:5)
069000060727     C                   Z-ADD     ADBENR        RFNOEMP
069100060727     C                   EVAL      RFTN = *BLANKS
069200060727     C                   EVAL      RFTSA = APACCT
069300061018     C                   EVAL      RFDES = PMNAME
069400060727     C                   MOVE      ISOTDAY       #8                8 0
069500060727     C                   MOVE      #8            RFPD
069600060727     C                   MOVE      RUNDATE       RFRD
069700060727     C                   MOVEL(P)  ADNAME        RFACN
069800160411
069900160412     C     f#tsp         chain     plnauxr
070000160411       if pxexchg = 'Y';
070100160413        rfacn = %trim('*-') + %trim(rfacn);
070200160411       endif;
070300160411
070400101104     C                   WRITE(E)  R01WF
070500060727    ***
070600060713     C                   EVAL      L@ACC = 'GA:' + APACCT
070700060713     C                   EVAL      L@ANM = %TRIM(ADNAME)
070800060713     C                   IF        SXAGCY = '226'
070900060713     C                   EVAL      L@BKR = 'MEDCHI AGENCY'
071000060713     C                   ELSE
071100060713     C                   EVAL      L@BKR = %TRIM(A@40)
071200060713     C                   ENDIF
071300060713     C                   EVAL      L@SMN = BPSMAN
071400060713    * *
071500060713     C     L#NABS        CHAIN     F017A
071600060713     C                   IF        NOT %FOUND(RNWP017A)
071700060713     C                   EVAL      R7ACC = L@ACC
071800060713     C                   EVAL      R7ANM = L@ANM
071900060713     C                   EVAL      R7BKR = L@BKR
072000060713     C                   EVAL      R7SMN = L@SMN
072100060713     C                   WRITE     F017A
072200060713     C                   ENDIF
072300060713    ***
072400060711     C                   EVAL      O10 = O@
072500060711     C                   EXCEPT    O10F
072600060711    ***
072700060711     C                   SELECT
072800060713     C                   WHEN      BPAGCY = '226'
072900060711     C                   EVAL      O11 = O@
073000060711     C                   EXCEPT    O11F
073100060713     C                   WHEN      BPSUPER = '307'
073200060711     C                   EVAL      O12 = O@
073300060711     C                   EXCEPT    O12F
073400060713     C                   WHEN      BPSUPER = '389' OR BPSUPER = '390'
073500060711     C                   EVAL      O13 = O@
073600060711     C                   EXCEPT    O13F
073700060711     C                   OTHER
073800060711     C                   EVAL      O14 = O@
073900060711     C                   EXCEPT    O14F
074000060711     C                   ENDSL
074100060711    ***
074200060711     C                   EVAL      O16 = O@
074300060711     C                   EXCEPT    O16F
074400060711    ***
074500060707     C                   EVAL      @S = 'T'
074600060707    ***
074700060707     C                   ENDSR
074800060707   S***S
074900060707     C     $GETSNAME     BEGSR
075000060707    ***
075100060707     C                   CLEAR                   A@20             20
075200060707     C                   CLEAR                   A@40             40
075300060707    ***
075400060707     C                   IF        SLNAME <> *BLANKS
075500060707     C                   MOVEL(P)  SLNAME        A@20
075600060707     C                   EXSR      $LDADDR
075700060707     C                   EVAL      A@40 = %TRIM(A@40) + ','
075800060707     C                   ENDIF
075900060707    ***
076000060707     C                   IF        SFNAME <> *BLANKS
076100060707     C                   MOVEL(P)  SFNAME        A@20
076200060707     C                   EXSR      $LDADDR
076300060707     C                   ENDIF
076400060707    ***
076500060707     C                   IF        SMI <> *BLANKS
076600060707     C                   MOVEL(P)  SMI           A@20
076700060707     C                   EXSR      $LDADDR
076800060707     C                   ENDIF
076900060707    ***
077000060707     C                   ENDSR
077100060707   S***S
077200060707     C     $LDADDR       BEGSR
077300060707    ***
077400060707     C                   EVAL      A@20 = %TRIM(A@20)
077500060707     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
077600060707     C                   CLEAR                   A@20
077700060707    ***
077800060707     C                   ENDSR
077900060727   S***S
078000060727     C     $WRTHST       BEGSR
078100060727    ***
078200060727     C                   CLEAR                   HISTR
078300060727     C                   MOVE      F@TRS         @3                3
078400060727     C                   CAT       @3:0          VHKEY
078500060727     C                   MOVE      F@SUB         @3
078600060727     C                   CAT       @3:0          VHKEY
078700060727     C                   MOVE      F@ACC         @4                4
078800060727     C                   CAT       @4:0          VHKEY
078900060727     C                   MOVE      'UHM'         VTRCODE
079000060727     C                   EVAL      VCK#NOT = 'SENT RENEWAL LETTER - B90'
079100131025     C                   MOVEL     'RNW010R'     VHPRGNM
079200060727     C                   MOVE      F@TRS         VHSTRST
079300060727     C                   MOVE      F@SUB         VHSSUB#
079400060727     C                   MOVE      F@ACC         VHSACCT
079500131014     C                   MOVEL     WQUSRN        VHOPER
079600060727     C                   MOVE      'A'           VHSDLTD
079700060727     C                   MOVE      ISOTDAY       VTRDATE
079800060727     C                   MOVE      ISOTDAY       VCOVTDT
079900131010     c                   eval      vhstrtime = %time
080000060727    ***
080100060727     C                   WRITE     HISTR
080200060727    ***
080300060727     C                   ENDSR
080400060707   S***S
080500060711     ORNWP010   EADD         O10F
080600060711     O                       O10                900
080700060711     ORNWP011   EADD         O11F
080800060711     O                       O11                900
080900060711     ORNWP012   EADD         O12F
081000060711     O                       O12                900
081100060711     ORNWP013   EADD         O13F
081200060711     O                       O13                900
081300060711     ORNWP014   EADD         O14F
081400060711     O                       O14                900
081500060711     ORNWP015   EADD         O15F
081600060711     O                       O15                900
081700060711     ORNWP016   EADD         O16F
081800060711     O                       O16                900
