000100140912   X***X
000200140912   X***X REMOVE FUTURE TERM FILTER PER ANKOTA
000300140912   X***X
000400140912   X***X
000500130327   X***X
000600130327    ***
000700130517     FANKW020   IPE  E           K DISK
000800130515     FMEMAC#1   IF   E           K DISK
000900130327     FSUMUNIQUE IF   E           K DISK
001000130815     FPLNUNIQUE IF   E           K DISK
001100130531     FODFACP    IF   E           K DISK
001200130515     FACCMSP    IF   E           K DISK
001300130515     FMCOVMPLN  IF   E           K DISK
001400130516     FANKW030   IF   E           K DISK
001500130516     FODCNTCP   IF   E           K DISK
001600130327     FT2000     O  A F 2000        DISK
001700130327    ***
001800130327   X***X
001900130516     D HP              S                   LIKE(MCPLAN)
002000130516     D @UD             S             10A
002100130516     D BD              S             10A
002200130516     D ZP5             S              5A
002300130516     D ZP9             S              9A
002400130516     D PH              S             10A
002500130516     D ADR             S             90A
002600130327     D X               S           2000A
002700130516     D #XSX            S              8S 0
002800130515     D TDY             S              8S 0
002900130516     D #ISO            S               D   DATFMT(*ISO)
003000130516     D #T              S                   LIKE(MBTRST) INZ(25)
003100130327    ***
003200130918     D DS@FA         E DS                  EXTNAME(ODFACP)
003300130918     D DS@MB         E DS                  EXTNAME(MEMBER)
003400130515     D DS@M          E DS                  EXTNAME(MCOV)
003500130515     D DS@AC         E DS                  EXTNAME(ACCMSP)
003600130327     D DS@S          E DS                  EXTNAME(SUMUNIQUE)
003700130327    ***
003800130918     D Q               C                   CONST(',')
003900130515     D C1              S             29A   INZ('Patient Save,,,,,,,,,,,,,,,,,')
004000130515    ***
004100130515     D XTNDR           S             80A
004200130515     D CRMSTS          S             80A
004300130515     D PS              S              1A
004400130516     D PL              S             30A
004500130515     D PID3            S             50A
004600130515    ***
004700130516     D @CCOD           S                   LIKE(OCCCOD) INZ('APS')
004800130515    ***
004900130515    ***
005000130515     D C2              C                   CONST('PatientID,SistemDescr1,Custom-
005100130515     D                                     erID,SistemPatientID1,LastName,First-
005200130515     D                                     Name,MiddleName,BirthDate,PatientPho-
005300130515     D                                     ne,Address,Agency,SSN,MedicaidNo,Ext-
005400130515     D                                     ender,CRMStatus,PatientStatus,Plan,P-
005500130905     D                                     atientID3')
005600130515    ***
005700130515    *** MCSSNO MDSEQ# MCTRST MCSUB# ACC#
005800130515    ***
005900130515     D S2              S                   LIKE(MDSEQ#) INZ(00)
006000130327   X***X
006100130531     C     KL#FAC        KLIST
006200130531     C                   KFLD                    MBTRST
006300130531     C                   KFLD                    MBSUB#
006400130531    ***
006500130517    ***
006600130517     C     KL#A20        SETLL     MEMBR
006700130517     C                   DOU       %EOF(MEMAC#1)
006800130517     C     KL#A20        READE     MEMBR
006900130517     C                   IF        NOT %EOF(MEMAC#1)
007000130515    ***
007100130515     C     KL#TS         CHAIN     SUBMSR
007200130515     C                   IF        NOT %FOUND(SUMUNIQUE)
007300130515     C                   SETON                                        H1
007400130515     C                   ENDIF
007500130515    ***
007600130515     C     KL#TSA        CHAIN     ACCMSPR
007700130515     C                   IF        NOT %FOUND(ACCMSP)
007800130515     C                   CLEAR                   DS@AC
007900130515     C                   ENDIF
008000130515    ***
008100130516     C                   MOVE      *BLANKS       BD
008200130516     C                   MOVE      *BLANKS       ZP5
008300130516     C                   MOVE      *BLANKS       ZP9
008400130516     C                   MOVE      *BLANKS       PH
008500130516     C                   MOVE      *BLANKS       ADR
008600130515     C                   MOVE      *BLANKS       XTNDR
008700130515     C                   MOVE      *BLANKS       CRMSTS
008800130515     C                   MOVE      '1'           PS
008900130516     C                   MOVEL(P)  'STANDARD'    PL
009000130515     C                   MOVE      *BLANKS       PID3
009100130515    ***
009200130516     C     BIRTH         MULT      10000.0001    #XSX
009300130805     C                   EVAL      BD = %TRIM(%EDITC(#XSX:'Y'))
009400130515    ***
009500130531     C                   EXSR      $FACILITY
009600130516    ***
009700130516     C     MBSSNO        CHAIN     ANKF030
009800130516     C                   IF        NOT %FOUND(ANKW030)
009900130531     C                   EVAL      XTNDR = 'DENTITION;##MUSTCONTACTRP;'
010000130516     C                   ELSE
010100130516     C                   EVAL      XTNDR = 'DENTITION;' + %TRIM(A30TEXT) +
010200130531     C                             '##MUSTCONTACTRP;'
010300130516     C                   ENDIF
010400130516    ***
010500130516     C     KL#ODC        CHAIN     ODCNTCR
010600130516     C                   IF        %FOUND(ODCNTCP)
010700130516     C                   EVAL      XTNDR = %TRIM(XTNDR) + 'YES'
010800130516     C                   ELSE
010900130516     C                   EVAL      XTNDR = %TRIM(XTNDR) + 'NO'
011000130516     C                   ENDIF
011100130517    ***
011200130517     C                   EVAL      PID3 = %EDITC(MBTRST:'X') +
011300130517     C                             %EDITC(MBSUB#:'X') +
011400130517     C                             %EDITC(MBACCT:'X')
011500130515    ***
011600130515     C                   EXSR      $MCOV
011700130918    ***
011800130918     C     ',':' '       XLATE     MLNAME        MLNAME
011900130918     C     ',':' '       XLATE     MFNAME        MFNAME
012000130515    ***
012100130918     C                   EVAL      X = '0,9,338,' + %EDITC(MBSSNO:'X') + Q +
012200130515     C                             %TRIM(MLNAME) + Q + %TRIM(MFNAME) + Q +
012300130515     C                             %TRIM(MMI) + Q +
012400130918     C                             BD + ',0;;' + PH + ',0;1;' +
012500130918     C                             %TRIM(ADDY) + ';,' +
012600130515     C                             %TRIM(SUBDSC) + Q +
012700130517     C                             %EDITC(MBSSNO:'X') + Q +
012800130515     C                             %TRIM(AMMAID) + Q +
012900130515     C                             %TRIM(XTNDR) + Q +
013000130515     C                             %TRIM(CRMSTS) + Q +
013100130516     C                             %TRIM(PS) + Q +
013200130516     C                             %TRIM(PL) + Q +
013300130918     C                             %TRIM(PID3)
013400130515     C                   EXCEPT    OUTF
013500130515    ***
013600130515     C                   ENDIF
013700130515     C                   ENDDO
013800130515    ***
013900130531   S***S
014000130531     C     $FACILITY     BEGSR
014100130531    ***
014200130531     C                   MOVE      *BLANKS       ADDY            100
014300130531    ***
014400130531     C     KL#FAC        CHAIN     ODFACR
014500130531     C                   IF        %FOUND(ODFACP)
014600130918     C     ',':' '       XLATE     S2ADD1        S2ADD1
014700130918     C     ',':' '       XLATE     S2ADD2        S2ADD2
014800130918     C     ',':' '       XLATE     S2CITY        S2CITY
014900130531     C                   MOVEL     S2ZIP         ZP5
015000130531     C                   EVAL      PH = S2PHON
015100130531     C                   EVAL      ADR = %TRIM(S2ADD1)
015200130531     C                   IF        S2ADD2 <> *BLANKS
015300130531     C                   EVAL      ADR = %TRIM(ADR) + ' ' + %TRIM(S2ADD2)
015400130531     C                   ENDIF
015500130531     C                   EVAL      ADDY =
015600130531     C                             %TRIM(S2CITY) + ';' +
015700130531     C                             %TRIM(S2ST) + ';' + ZP5 + ';' +
015800130531     C                             %TRIM(ADR)
015900130531     C                   LEAVESR
016000130531     C                   ENDIF
016100130531    ***
016200130531     C                   EVAL      ZP9 = %EDITC(ZIP:'X')
016300130531     C                   MOVEL     ZP9           ZP5
016400130531    ***
016500130531     C                   EVAL      PH = %EDITC(AREA:'X') +
016600130531     C                             %EDITC(PHONE:'X')
016700130531    ***
016800130918     C     ',':' '       XLATE     ADDR1         ADDR1
016900130918     C     ',':' '       XLATE     ADDR2         ADDR2
017000130918     C     ',':' '       XLATE     CITY          CITY
017100130531     C                   EVAL      ADR = %TRIM(ADDR1)
017200130531     C                   IF        ADDR2 <> *BLANKS
017300130531     C                   EVAL      ADR = %TRIM(ADR) + ' ' + %TRIM(ADDR2)
017400130531     C                   ENDIF
017500130531     C                   EVAL      ADDY =
017600130531     C                             %TRIM(CITY) + ';' +
017700130531     C                             %TRIM(STATE) + ';' + ZP5 + ';' +
017800130531     C                             %TRIM(ADR)
017900130531    ***
018000130531     C                   ENDSR
018100130515   S***S
018200130515     C     $MCOV         BEGSR
018300130515    ***
018400130515     C                   EVAL      #XSX = 0
018500130516     C                   EVAL      HP = *BLANKS
018600130515    ***
018700130515     C     KL#MCV        SETLL     MCOVR
018800130515     C                   DOU       %EOF(MCOVMPLN)
018900130515     C     KL#MCV        READE     MCOVR
019000130515     C                   IF        NOT %EOF(MCOVMPLN)
019100130515    ***
019200130515     C                   IF        CANDT = 0
019300130515     C                   EVAL      CANDT = 99999999
019400130515     C                   ENDIF
019500130515    ***
019600130516     C                   EVAL      HP = MCPLAN
019700130516    ***
019800130531     C                   IF        CANDT = 99999999
019900130531     C                   EVAL      PS = '0'
020000130531     C                   MOVE      ENRLDT        #XSX
020100130531     C                   LEAVE
020200130531     C                   ENDIF
020300140912    ***
020400140912    *** FUTURE TERM FILTER // DISCONTINUED AS OF 9/14
020500130531    ***
020600140912    *C*                  IF        TDY >= ENRLDT AND TDY <= CANDT
020700140912    *C*                  EVAL      PS = '0'
020800140912    *C*                  MOVE      ENRLDT        #XSX
020900140912    *C*                  LEAVE
021000140912    *C*                  ENDIF
021100130515    ***
021200130515     C                   MOVE      CANDT         #XSX
021300130515    ***
021400130515     C                   ENDIF
021500130515     C                   ENDDO
021600130815    ***
021700130815    *** PLAN OVERRIDE
021800130815    ***
021900130815     C     KL#TSP        CHAIN     PLNMSR
022000130815     C                   IF        %FOUND(PLNUNIQUE)
022100130815     C                   SELECT
022200130815     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN A'
022300130815     C                   EVAL      PL = 'DENTAL ONLY'
022400130815     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN B'
022500130815     C                   EVAL      PL = 'DENTAL PLUS'
022600130815     C                   WHEN      %SUBST(PDESCR:1:6) = 'PLAN C'
022700130815     C                   EVAL      PL = 'COMP PLUS'
022800130815     C                   ENDSL
022900130815     C                   ENDIF
023000130815    ***
023100130815    *** PLAN OVERRIDE FOR 025 // DISCONTINUED AS OF 8/14
023200130515    ***
023300130815    *C*                  IF        MBTRST = 025
023400130815    *C*                  SELECT
023500130815    *C*                  WHEN      %SUBST(HP:2:1) = 'A'
023600130815    *C*                  EVAL      PL = 'DENTAL ONLY'
023700130815    *C*                  WHEN      %SUBST(HP:2:1) = 'B'
023800130815    *C*                  EVAL      PL = 'DENTAL PLUS'
023900130815    *C*                  WHEN      %SUBST(HP:2:1) = 'C'
024000130815    *C*                  EVAL      PL = 'COMP PLUS'
024100130815    *C*                  ENDSL
024200130815    *C*                  ENDIF
024300130516    ***
024400130531     C                   IF        #XSX = 99999999
024500130531     C                   EVAL      @UD = *BLANKS
024600130531     C                   ELSE
024700130515     C     #XSX          MULT      10000.0001    #XSX
024800130515     C                   EVAL      @UD = %EDITC(#XSX:'Y')
024900130531     C                   ENDIF
025000130515    ***
025100130515     C                   IF        PS = '0'
025200130515     C                   EVAL      CRMSTS = 'ACTIVE MEMBER;' + @UD
025300130515     C                   ELSE
025400130515     C                   EVAL      CRMSTS = 'TERMINATED;' + @UD
025500130515     C                   ENDIF
025600130515    ***
025700130515     C                   ENDSR
025800130327   S***S
025900130327     C     *INZSR        BEGSR
026000130517    ***
026100130517     C     KL#A20        KLIST
026200130517     C                   KFLD                    A20TRS
026300130517     C                   KFLD                    A20SUB
026400130517     C                   KFLD                    A20ACC
026500130517     C                   KFLD                    A20SSN
026600130517    ***
026700130815     C     KL#TSP        KLIST
026800130815     C                   KFLD                    MCTRST
026900130815     C                   KFLD                    MCSUB#
027000130815     C                   KFLD                    MCPLAN
027100130517    ***
027200130517     C     KL#ODC        KLIST
027300130517     C                   KFLD                    MBTRST
027400130517     C                   KFLD                    MBSUB#
027500130517     C                   KFLD                    MBACCT
027600130517     C                   KFLD                    @CCOD
027700130517    ***
027800130517     C     KL#MCV        KLIST
027900130517     C                   KFLD                    MBSSNO
028000130517     C                   KFLD                    S2
028100130517     C                   KFLD                    MBTRST
028200130517     C                   KFLD                    MBSUB#
028300130517     C                   KFLD                    MBACCT
028400130517    ***
028500130517     C     KL#TS         KLIST
028600130517     C                   KFLD                    MBTRST
028700130517     C                   KFLD                    MBSUB#
028800130517    ***
028900130517     C     KL#TSA        KLIST
029000130517     C                   KFLD                    MBTRST
029100130517     C                   KFLD                    MBSUB#
029200130517     C                   KFLD                    MBACCT
029300130515    ***
029400130515     C                   EVAL      #ISO = %DATE
029500130515     C                   MOVE      #ISO          TDY
029600130327    ***
029700130327     C                   EVAL      X = C1
029800130327     C                   EXCEPT    OUTF
029900130327    ***
030000130327     C                   EVAL      X = C2
030100130327     C                   EXCEPT    OUTF
030200130327    ***
030300130327     C                   ENDSR
030400130327   S***S
030500130327   X***X
030600130327     OT2000     EADD         OUTF
030700130327     O                       X              B  2000
