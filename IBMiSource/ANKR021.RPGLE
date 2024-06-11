000100140912   X***X
000200140912   X***X REMOVE FUTURE TERM FILTER
000300140912   X***X
000400140912   X***X
000500130327   X***X
000600130327    ***
000700130515     FMEMAC#1   IF   E           K DISK
000800130327     FSUMUNIQUE IF   E           K DISK
000900130815     FPLNUNIQUE IF   E           K DISK
001000130515     FACCMSP    IF   E           K DISK
001100130515     FMCOVMPLN  IF   E           K DISK
001200130516     FANKW030   IF   E           K DISK
001300130516     FODCNTCP   IF   E           K DISK
001400130531     FODFACP    IF   E           K DISK
001500130327     FT2000     O  A F 2000        DISK
001600130327    ***
001700130327   X***X
001800130516     D HP              S                   LIKE(MCPLAN)
001900130516     D @UD             S             10A
002000130516     D BD              S             10A
002100130516     D ZP5             S              5A
002200130516     D ZP9             S              9A
002300130516     D PH              S             10A
002400130516     D ADR             S             90A
002500130327     D X               S           2000A
002600130516     D #XSX            S              8S 0
002700130515     D TDY             S              8S 0
002800130516     D #ISO            S               D   DATFMT(*ISO)
002900130516     D #T              S                   LIKE(MBTRST) INZ(25)
003000130327    ***
003100130515     D DS@M          E DS                  EXTNAME(MCOV)
003200130515     D DS@AC         E DS                  EXTNAME(ACCMSP)
003300130327     D DS@S          E DS                  EXTNAME(SUMUNIQUE)
003400130327    ***
003500130327     D Q               C                   CONST('","')
003600130515     D C1              S             29A   INZ('Patient Save,,,,,,,,,,,,,,,,,')
003700130515    ***
003800130515     D XTNDR           S             80A
003900130515     D CRMSTS          S             80A
004000130515     D PS              S              1A
004100130516     D PL              S             30A
004200130515     D PID3            S             50A
004300130515    ***
004400130516     D @CCOD           S                   LIKE(OCCCOD) INZ('APS')
004500130515    ***
004600130515    ***
004700130515     D C2              C                   CONST('PatientID,SistemDescr1,Custom-
004800130515     D                                     erID,SistemPatientID1,LastName,First-
004900130515     D                                     Name,MiddleName,BirthDate,PatientPho-
005000130515     D                                     ne,Address,Agency,SSN,MedicaidNo,Ext-
005100130515     D                                     ender,CRMStatus,PatientStatus,Plan,P-
005200130515     D                                     atientID3')
005300130515    ***
005400130515    *** MCSSNO MDSEQ# MCTRST MCSUB# ACC#
005500130515    ***
005600130515     D S2              S                   LIKE(MDSEQ#) INZ(00)
005700130327   X***X
005800130516     C     KL#ODC        KLIST
005900130516     C                   KFLD                    MBTRST
006000130516     C                   KFLD                    MBSUB#
006100130516     C                   KFLD                    MBACCT
006200130516     C                   KFLD                    @CCOD
006300130515    ***
006400130531     C     KL#FAC        KLIST
006500130531     C                   KFLD                    MBTRST
006600130531     C                   KFLD                    MBSUB#
006700130531    ***
006800130515     C     KL#MCV        KLIST
006900130515     C                   KFLD                    MBSSNO
007000130515     C                   KFLD                    S2
007100130515     C                   KFLD                    MBTRST
007200130515     C                   KFLD                    MBSUB#
007300130515     C                   KFLD                    MBACCT
007400130515    ***
007500130515     C     KL#TS         KLIST
007600130515     C                   KFLD                    MBTRST
007700130515     C                   KFLD                    MBSUB#
007800130515    ***
007900130515     C     KL#TSA        KLIST
008000130515     C                   KFLD                    MBTRST
008100130515     C                   KFLD                    MBSUB#
008200130515     C                   KFLD                    MBACCT
008300130515    ***
008400180111     C     #T            SETLL     MEMBR
008500180111     C                   DOU       %EOF(MEMAC#1) OR MBTRST > 075
008600130515     C                   READ      MEMBR
008700130515     C                   IF        NOT %EOF(MEMAC#1) AND
008800130515     C                             MBTRST >= 025 AND MBTRST <= 075
008900130515    ***
009000130515     C     KL#TS         CHAIN     SUBMSR
009100130515     C                   IF        NOT %FOUND(SUMUNIQUE)
009200130515     C                   SETON                                        H1
009300130515     C                   ENDIF
009400130515    ***
009500130515     C     KL#TSA        CHAIN     ACCMSPR
009600130515     C                   IF        NOT %FOUND(ACCMSP)
009700130515     C                   CLEAR                   DS@AC
009800130515     C                   ENDIF
009900130515    ***
010000130516     C                   MOVE      *BLANKS       BD
010100130516     C                   MOVE      *BLANKS       ZP5
010200130516     C                   MOVE      *BLANKS       ZP9
010300130516     C                   MOVE      *BLANKS       PH
010400130516     C                   MOVE      *BLANKS       ADR
010500130515     C                   MOVE      *BLANKS       XTNDR
010600130515     C                   MOVE      *BLANKS       CRMSTS
010700130515     C                   MOVE      '1'           PS
010800130516     C                   MOVEL(P)  'STANDARD'    PL
010900130515     C                   MOVE      *BLANKS       PID3
011000130515    ***
011100130516     C     BIRTH         MULT      10000.0001    #XSX
011200130531     C                   EVAL      BD = %EDITC(#XSX:'Y')
011300130515    ***
011400130531     C                   EXSR      $FACILITY
011500130516    ***
011600130516     C     MBSSNO        CHAIN     ANKF030
011700130516     C                   IF        NOT %FOUND(ANKW030)
011800130531     C                   EVAL      XTNDR = 'DENTITION;##MUSTCONTACTRP;'
011900130516     C                   ELSE
012000130516     C                   EVAL      XTNDR = 'DENTITION;' + %TRIM(A30TEXT) +
012100130531     C                             '##MUSTCONTACTRP;'
012200130516     C                   ENDIF
012300130516    ***
012400130516     C     KL#ODC        CHAIN     ODCNTCR
012500130516     C                   IF        %FOUND(ODCNTCP)
012600130516     C                   EVAL      XTNDR = %TRIM(XTNDR) + 'YES'
012700130516     C                   ELSE
012800130516     C                   EVAL      XTNDR = %TRIM(XTNDR) + 'NO'
012900130516     C                   ENDIF
013000130517    ***
013100130517     C                   EVAL      PID3 = %EDITC(MBTRST:'X') +
013200130517     C                             %EDITC(MBSUB#:'X') +
013300130517     C                             %EDITC(MBACCT:'X')
013400130515    ***
013500130515     C                   EXSR      $MCOV
013600130515    ***
013700130515     C                   EVAL      X = '0,9,338,"' + %EDITC(MBSSNO:'X') + Q +
013800130515     C                             %TRIM(MLNAME) + Q + %TRIM(MFNAME) + Q +
013900130515     C                             %TRIM(MMI) + Q +
014000130515     C                             BD + '",0;;' + PH + ',"0;1;' +
014100130531     C                             %TRIM(ADDY) + ';","' +
014200130515     C                             %TRIM(SUBDSC) + Q +
014300130517     C                             %EDITC(MBSSNO:'X') + Q +
014400130515     C                             %TRIM(AMMAID) + Q +
014500130515     C                             %TRIM(XTNDR) + Q +
014600130515     C                             %TRIM(CRMSTS) + Q +
014700130516     C                             %TRIM(PS) + Q +
014800130516     C                             %TRIM(PL) + Q +
014900130516     C                             %TRIM(PID3) + '"'
015000130515     C                   EXCEPT    OUTF
015100130515    ***
015200130515     C                   ENDIF
015300130515     C                   ENDDO
015400130515    ***
015500130515     C                   EVAL      *INLR = *ON
015600130515   S***S
015700130531     C     $FACILITY     BEGSR
015800130515    ***
015900130531     C                   MOVE      *BLANKS       ADDY            100
016000130531    ***
016100130531     C     KL#FAC        CHAIN     ODFACR
016200130531     C                   IF        %FOUND(ODFACP)
016300130531     C                   MOVEL     S2ZIP         ZP5
016400130531     C                   EVAL      PH = S2PHON
016500130531     C                   EVAL      ADR = %TRIM(S2ADD1)
016600130531     C                   IF        S2ADD2 <> *BLANKS
016700130531     C                   EVAL      ADR = %TRIM(ADR) + ' ' + %TRIM(S2ADD2)
016800130531     C                   ENDIF
016900130531     C                   EVAL      ADDY =
017000130531     C                             %TRIM(S2CITY) + ';' +
017100130531     C                             %TRIM(S2ST) + ';' + ZP5 + ';' +
017200130531     C                             %TRIM(ADR)
017300130531     C                   LEAVESR
017400130531     C                   ENDIF
017500130531    ***
017600130531     C                   EVAL      ZP9 = %EDITC(ZIP:'X')
017700130531     C                   MOVEL     ZP9           ZP5
017800130531    ***
017900130531     C                   EVAL      PH = %EDITC(AREA:'X') +
018000130531     C                             %EDITC(PHONE:'X')
018100130531    ***
018200130531     C                   EVAL      ADR = %TRIM(ADDR1)
018300130531     C                   IF        ADDR2 <> *BLANKS
018400130531     C                   EVAL      ADR = %TRIM(ADR) + ' ' + %TRIM(ADDR2)
018500130531     C                   ENDIF
018600130531     C                   EVAL      ADDY =
018700130531     C                             %TRIM(CITY) + ';' +
018800130531     C                             %TRIM(STATE) + ';' + ZP5 + ';' +
018900130531     C                             %TRIM(ADR)
019000130531    ***
019100130531     C                   ENDSR
019200130531   S***S
019300130531     C     $MCOV         BEGSR
019400130531    ***
019500130515     C                   EVAL      #XSX = 0
019600130516     C                   EVAL      HP = *BLANKS
019700130515    ***
019800130515     C     KL#MCV        SETLL     MCOVR
019900130515     C                   DOU       %EOF(MCOVMPLN)
020000130515     C     KL#MCV        READE     MCOVR
020100130515     C                   IF        NOT %EOF(MCOVMPLN)
020200130515    ***
020300130515     C                   IF        CANDT = 0
020400130515     C                   EVAL      CANDT = 99999999
020500130515     C                   ENDIF
020600130515    ***
020700130516     C                   EVAL      HP = MCPLAN
020800130516    ***
020900130531     C                   IF        CANDT = 99999999
021000130531     C                   EVAL      PS = '0'
021100130531     C                   MOVE      ENRLDT        #XSX
021200130531     C                   LEAVE
021300130531     C                   ENDIF
021400130531    ***
021500140912    ***
021600140912    *** FUTURE TERM FILTER // DISCONTINUED AS OF 9/14
021700140912    ***
021800140912    *C*                  IF        TDY >= ENRLDT AND TDY <= CANDT
021900140912    *C*                  EVAL      PS = '0'
022000140912    *C*                  MOVE      ENRLDT        #XSX
022100140912    *C*                  LEAVE
022200140912    *C*                  ENDIF
022300130515    ***
022400130515     C                   MOVE      CANDT         #XSX
022500130515    ***
022600130515     C                   ENDIF
022700130515     C                   ENDDO
022800130515    ***
022900130815    *** PLAN OVERRIDE
023000130815    ***
023100130815     C     KL#TSP        CHAIN     PLNMSR
023200130815     C                   IF        %FOUND(PLNUNIQUE)
023300130815     C                   SELECT
023400130815     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN A'
023500130815     C                   EVAL      PL = 'DENTAL ONLY'
023600130815     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN B'
023700130815     C                   EVAL      PL = 'DENTAL PLUS'
023800130815     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN C'
023900130815     C                   EVAL      PL = 'COMP PLUS'
024000130815     C                   ENDSL
024100130815     C                   ENDIF
024200130815    ***
024300130815    *** PLAN OVERRIDE FOR 025 // DISCONTINUED AS OF 8/14
024400130815    ***
024500130815    *C*                  IF        MBTRST = 025
024600130815    *C*                  SELECT
024700130815    *C*                  WHEN      %SUBST(HP:2:1) = 'A'
024800130815    *C*                  EVAL      PL = 'DENTAL ONLY'
024900130815    *C*                  WHEN      %SUBST(HP:2:1) = 'B'
025000130815    *C*                  EVAL      PL = 'DENTAL PLUS'
025100130815    *C*                  WHEN      %SUBST(HP:2:1) = 'C'
025200130815    *C*                  EVAL      PL = 'COMP PLUS'
025300130815    *C*                  ENDSL
025400130815    *C*                  ENDIF
025500130516    ***
025600130531     C                   IF        #XSX = 99999999
025700130531     C                   EVAL      @UD = *BLANKS
025800130531     C                   ELSE
025900130531     C     #XSX          MULT      10000.0001    #XSX
026000130531     C                   EVAL      @UD = %EDITC(#XSX:'Y')
026100130531     C                   ENDIF
026200130515    ***
026300130515     C                   IF        PS = '0'
026400130515     C                   EVAL      CRMSTS = 'ACTIVE MEMBER;' + @UD
026500130515     C                   ELSE
026600130515     C                   EVAL      CRMSTS = 'TERMINATED;' + @UD
026700130515     C                   ENDIF
026800130515    ***
026900130515     C                   ENDSR
027000130327   S***S
027100130327     C     *INZSR        BEGSR
027200130515    ***
027300130515     C                   EVAL      #ISO = %DATE
027400130515     C                   MOVE      #ISO          TDY
027500130327    ***
027600130327     C                   EVAL      X = C1
027700130327     C                   EXCEPT    OUTF
027800130327    ***
027900130327     C                   EVAL      X = C2
028000130327     C                   EXCEPT    OUTF
028100130815    ***
028200130815     C     KL#TSP        KLIST
028300130815     C                   KFLD                    MCTRST
028400130815     C                   KFLD                    MCSUB#
028500130815     C                   KFLD                    MCPLAN
028600130327    ***
028700130327     C                   ENDSR
028800130327   S***S
028900130327   X***X
029000130327     OT2000     EADD         OUTF
029100130327     O                       X              B  2000
