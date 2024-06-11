000100130327   X***X
000200130327    ***
000300130515     FMEMAC#1   IF   E           K DISK
000400130327     FSUMUNIQUE IF   E           K DISK
000500130823     FPLNUNIQUE IF   E           K DISK
000600130515     FACCMSP    IF   E           K DISK
000700130515     FMCOVMPLN  IF   E           K DISK
000800130516     FANKW030   IF   E           K DISK
000900130516     FODCNTCP   IF   E           K DISK
001000130531     FODFACP    IF   E           K DISK
001100130327     FT2000     O  A F 2000        DISK
001200130327    ***
001300130327   X***X
001400130516     D HP              S                   LIKE(MCPLAN)
001500130516     D @UD             S             10A
001600130516     D BD              S             10A
001700130516     D ZP5             S              5A
001800130516     D ZP9             S              9A
001900130516     D PH              S             10A
002000130516     D ADR             S             90A
002100130327     D X               S           2000A
002200130516     D #XSX            S              8S 0
002300130515     D TDY             S              8S 0
002400130516     D #ISO            S               D   DATFMT(*ISO)
002500130823     D #T              S                   LIKE(MBTRST) INZ(30)
002600130327    ***
002700130515     D DS@M          E DS                  EXTNAME(MCOV)
002800130515     D DS@AC         E DS                  EXTNAME(ACCMSP)
002900130327     D DS@S          E DS                  EXTNAME(SUMUNIQUE)
003000130327    ***
003100130327     D Q               C                   CONST('","')
003200130515     D C1              S             29A   INZ('Patient Save,,,,,,,,,,,,,,,,,')
003300130515    ***
003400130515     D XTNDR           S             80A
003500130515     D CRMSTS          S             80A
003600130515     D PS              S              1A
003700130516     D PL              S             30A
003800130515     D PID3            S             50A
003900130515    ***
004000130516     D @CCOD           S                   LIKE(OCCCOD) INZ('APS')
004100130515    ***
004200130515    ***
004300130515     D C2              C                   CONST('PatientID,SistemDescr1,Custom-
004400130515     D                                     erID,SistemPatientID1,LastName,First-
004500130515     D                                     Name,MiddleName,BirthDate,PatientPho-
004600130515     D                                     ne,Address,Agency,SSN,MedicaidNo,Ext-
004700130515     D                                     ender,CRMStatus,PatientStatus,Plan,P-
004800130515     D                                     atientID3')
004900130515    ***
005000130515    *** MCSSNO MDSEQ# MCTRST MCSUB# ACC#
005100130515    ***
005200130515     D S2              S                   LIKE(MDSEQ#) INZ(00)
005300130327   X***X
005400130516     C     KL#ODC        KLIST
005500130516     C                   KFLD                    MBTRST
005600130516     C                   KFLD                    MBSUB#
005700130516     C                   KFLD                    MBACCT
005800130516     C                   KFLD                    @CCOD
005900130515    ***
006000130531     C     KL#FAC        KLIST
006100130531     C                   KFLD                    MBTRST
006200130531     C                   KFLD                    MBSUB#
006300130531    ***
006400130515     C     KL#MCV        KLIST
006500130515     C                   KFLD                    MBSSNO
006600130515     C                   KFLD                    S2
006700130515     C                   KFLD                    MBTRST
006800130515     C                   KFLD                    MBSUB#
006900130515     C                   KFLD                    MBACCT
007000130515    ***
007100130515     C     KL#TS         KLIST
007200130515     C                   KFLD                    MBTRST
007300130515     C                   KFLD                    MBSUB#
007400130515    ***
007500130515     C     KL#TSA        KLIST
007600130515     C                   KFLD                    MBTRST
007700130515     C                   KFLD                    MBSUB#
007800130515     C                   KFLD                    MBACCT
007900130515    ***
008000130515     C     #T            SETLL     MEMBR
008100130823     C                   DOU       %EOF(MEMAC#1) OR MBTRST > 030
008200130515     C                   READ      MEMBR
008300130515     C                   IF        NOT %EOF(MEMAC#1) AND
008400130624     C                             MBTRST = 30
008500130515    ***
008600130515     C     KL#TS         CHAIN     SUBMSR
008700130515     C                   IF        NOT %FOUND(SUMUNIQUE)
008800130515     C                   SETON                                        H1
008900130515     C                   ENDIF
009000130515    ***
009100130515     C     KL#TSA        CHAIN     ACCMSPR
009200130515     C                   IF        NOT %FOUND(ACCMSP)
009300130515     C                   CLEAR                   DS@AC
009400130515     C                   ENDIF
009500130515    ***
009600130516     C                   MOVE      *BLANKS       BD
009700130516     C                   MOVE      *BLANKS       ZP5
009800130516     C                   MOVE      *BLANKS       ZP9
009900130516     C                   MOVE      *BLANKS       PH
010000130516     C                   MOVE      *BLANKS       ADR
010100130515     C                   MOVE      *BLANKS       XTNDR
010200130515     C                   MOVE      *BLANKS       CRMSTS
010300130515     C                   MOVE      '1'           PS
010400130516     C                   MOVEL(P)  'STANDARD'    PL
010500130515     C                   MOVE      *BLANKS       PID3
010600130515    ***
010700130516     C     BIRTH         MULT      10000.0001    #XSX
010800130531     C                   EVAL      BD = %EDITC(#XSX:'Y')
010900130515    ***
011000130531     C                   EXSR      $FACILITY
011100130516    ***
011200130516     C     MBSSNO        CHAIN     ANKF030
011300130516     C                   IF        NOT %FOUND(ANKW030)
011400130531     C                   EVAL      XTNDR = 'DENTITION;##MUSTCONTACTRP;'
011500130516     C                   ELSE
011600130516     C                   EVAL      XTNDR = 'DENTITION;' + %TRIM(A30TEXT) +
011700130531     C                             '##MUSTCONTACTRP;'
011800130516     C                   ENDIF
011900130516    ***
012000130516     C     KL#ODC        CHAIN     ODCNTCR
012100130516     C                   IF        %FOUND(ODCNTCP)
012200130516     C                   EVAL      XTNDR = %TRIM(XTNDR) + 'YES'
012300130516     C                   ELSE
012400130516     C                   EVAL      XTNDR = %TRIM(XTNDR) + 'NO'
012500130516     C                   ENDIF
012600130517    ***
012700130517     C                   EVAL      PID3 = %EDITC(MBTRST:'X') +
012800130517     C                             %EDITC(MBSUB#:'X') +
012900130517     C                             %EDITC(MBACCT:'X')
013000130515    ***
013100130515     C                   EXSR      $MCOV
013200130515    ***
013300130515     C                   EVAL      X = '0,9,338,"' + %EDITC(MBSSNO:'X') + Q +
013400130515     C                             %TRIM(MLNAME) + Q + %TRIM(MFNAME) + Q +
013500130515     C                             %TRIM(MMI) + Q +
013600130515     C                             BD + '",0;;' + PH + ',"0;1;' +
013700130531     C                             %TRIM(ADDY) + ';","' +
013800130515     C                             %TRIM(SUBDSC) + Q +
013900130517     C                             %EDITC(MBSSNO:'X') + Q +
014000130515     C                             %TRIM(AMMAID) + Q +
014100130515     C                             %TRIM(XTNDR) + Q +
014200130515     C                             %TRIM(CRMSTS) + Q +
014300130516     C                             %TRIM(PS) + Q +
014400130516     C                             %TRIM(PL) + Q +
014500130516     C                             %TRIM(PID3) + '"'
014600130515     C                   EXCEPT    OUTF
014700130515    ***
014800130515     C                   ENDIF
014900130515     C                   ENDDO
015000130515    ***
015100130515     C                   EVAL      *INLR = *ON
015200130515   S***S
015300130531     C     $FACILITY     BEGSR
015400130515    ***
015500130531     C                   MOVE      *BLANKS       ADDY            100
015600130531    ***
015700130531     C     KL#FAC        CHAIN     ODFACR
015800130531     C                   IF        %FOUND(ODFACP)
015900130531     C                   MOVEL     S2ZIP         ZP5
016000130531     C                   EVAL      PH = S2PHON
016100130531     C                   EVAL      ADR = %TRIM(S2ADD1)
016200130531     C                   IF        S2ADD2 <> *BLANKS
016300130531     C                   EVAL      ADR = %TRIM(ADR) + ' ' + %TRIM(S2ADD2)
016400130531     C                   ENDIF
016500130531     C                   EVAL      ADDY =
016600130531     C                             %TRIM(S2CITY) + ';' +
016700130531     C                             %TRIM(S2ST) + ';' + ZP5 + ';' +
016800130531     C                             %TRIM(ADR)
016900130531     C                   LEAVESR
017000130531     C                   ENDIF
017100130531    ***
017200130531     C                   EVAL      ZP9 = %EDITC(ZIP:'X')
017300130531     C                   MOVEL     ZP9           ZP5
017400130531    ***
017500130531     C                   EVAL      PH = %EDITC(AREA:'X') +
017600130531     C                             %EDITC(PHONE:'X')
017700130531    ***
017800130531     C                   EVAL      ADR = %TRIM(ADDR1)
017900130531     C                   IF        ADDR2 <> *BLANKS
018000130531     C                   EVAL      ADR = %TRIM(ADR) + ' ' + %TRIM(ADDR2)
018100130531     C                   ENDIF
018200130531     C                   EVAL      ADDY =
018300130531     C                             %TRIM(CITY) + ';' +
018400130531     C                             %TRIM(STATE) + ';' + ZP5 + ';' +
018500130531     C                             %TRIM(ADR)
018600130531    ***
018700130531     C                   ENDSR
018800130531   S***S
018900130531     C     $MCOV         BEGSR
019000130531    ***
019100130515     C                   EVAL      #XSX = 0
019200130516     C                   EVAL      HP = *BLANKS
019300130515    ***
019400130515     C     KL#MCV        SETLL     MCOVR
019500130515     C                   DOU       %EOF(MCOVMPLN)
019600130515     C     KL#MCV        READE     MCOVR
019700130515     C                   IF        NOT %EOF(MCOVMPLN)
019800130515    ***
019900130515     C                   IF        CANDT = 0
020000130515     C                   EVAL      CANDT = 99999999
020100130515     C                   ENDIF
020200130515    ***
020300130516     C                   EVAL      HP = MCPLAN
020400130516    ***
020500130531     C                   IF        CANDT = 99999999
020600130531     C                   EVAL      PS = '0'
020700130531     C                   MOVE      ENRLDT        #XSX
020800130531     C                   LEAVE
020900130531     C                   ENDIF
021000130531    ***
021100130515     C                   IF        TDY >= ENRLDT AND TDY <= CANDT
021200130515     C                   EVAL      PS = '0'
021300130515     C                   MOVE      ENRLDT        #XSX
021400130515     C                   LEAVE
021500130515     C                   ENDIF
021600130515    ***
021700130515     C                   MOVE      CANDT         #XSX
021800130515    ***
021900130515     C                   ENDIF
022000130515     C                   ENDDO
022100130515    ***
022200130823     C     KL#TSP        CHAIN     PLNMSR
022300130823     C                   IF        %FOUND(PLNUNIQUE)
022400130823     C                   SELECT
022500130823     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN A'
022600130823     C                   EVAL      PL = 'DENTAL ONLY'
022700130823     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN B'
022800130823     C                   EVAL      PL = 'DENTAL PLUS'
022900130823     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN C'
023000130823     C                   EVAL      PL = 'COMP PLUS'
023100130823     C                   ENDSL
023200130823     C                   ENDIF
023300130516    ***
023400130531     C                   IF        #XSX = 99999999
023500130531     C                   EVAL      @UD = *BLANKS
023600130531     C                   ELSE
023700130531     C     #XSX          MULT      10000.0001    #XSX
023800130531     C                   EVAL      @UD = %EDITC(#XSX:'Y')
023900130531     C                   ENDIF
024000130515    ***
024100130515     C                   IF        PS = '0'
024200130515     C                   EVAL      CRMSTS = 'ACTIVE MEMBER;' + @UD
024300130515     C                   ELSE
024400130515     C                   EVAL      CRMSTS = 'TERMINATED;' + @UD
024500130515     C                   ENDIF
024600130515    ***
024700130515     C                   ENDSR
024800130327   S***S
024900130327     C     *INZSR        BEGSR
025000130823    ***
025100130823     C     KL#TSP        KLIST
025200130823     C                   KFLD                    MCTRST
025300130823     C                   KFLD                    MCSUB#
025400130823     C                   KFLD                    MCPLAN
025500130515    ***
025600130515     C                   EVAL      #ISO = %DATE
025700130515     C                   MOVE      #ISO          TDY
025800130327    ***
025900130327     C                   EVAL      X = C1
026000130327     C                   EXCEPT    OUTF
026100130327    ***
026200130327     C                   EVAL      X = C2
026300130327     C                   EXCEPT    OUTF
026400130327    ***
026500130327     C                   ENDSR
026600130327   S***S
026700130327   X***X
026800130327     OT2000     EADD         OUTF
026900130327     O                       X              B  2000
