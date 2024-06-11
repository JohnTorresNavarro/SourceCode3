000100130327   X***X
000200130327    ***
000300130517     FANKW020   IPE  E           K DISK
000400130517     FODCNTCP   IF   E           K DISK
000500130514     FACMUNIQUE IF   E           K DISK
000600130514     FMEMAC#    IF   E           K DISK    PREFIX(W)
000700130327     FT2000     O  A F 2000        DISK
000800130327    ***
000900130327   X***X
001000130327     D X               S           2000A
001100130327    ***
001200130514     D DS@O          E DS                  EXTNAME(ODCNTCP)
001300130514     D DS@M          E DS                  EXTNAME(MEMBER) PREFIX(W)
001400130514     D DS@A          E DS                  EXTNAME(ACMUNIQUE)
001500130327    ***
001600130918     D Q               C                   CONST(',')
001700130514    ***
001800130617     D C1              C                   CONST('Contact Save,,,,,,,,,,,,,,')
001900130514    ***
002000130617     D C2              C                   CONST('CustomerId,ContactDescription-
002100130617     D                                     ,FirstName,LastName,Phone,Address1,A-
002200130617     D                                     ddress2,City,State,PostalCode,Relati-
002300130617     D                                     onship,Email,IsMaster,SystemPatientI-
002400130617     D                                     D,IsPayer')
002500130514    ***
002600130327   X***X
002700130517     C     KL#ODC        SETLL     ODCNTCR
002800130517     C                   DOU       %EOF(ODCNTCP)
002900130517     C     KL#ODC        READE     ODCNTCR
003000130517     C                   IF        NOT %EOF(ODCNTCP)
003100130517    ***
003200130514     C                   IF        OCTRST > 0 AND OCSUB# > 0 AND OCACCT > 0
003300130514     C                             AND OCCCOD = 'ARP' AND OCTRM = 0
003400130327     C                   EXSR      $A
003500130327     C                   ENDIF
003600130327    ***
003700130517     C                   ENDIF
003800130517     C                   ENDDO
003900130517    ***
004000130327   S***S
004100130327     C     $A            BEGSR
004200130327    ***
004300130514     C                   CLEAR                   DS@A
004400130514     C                   CLEAR                   DS@M
004500130327    ***
004600130514     C     KL#TSA        CHAIN     ACCMSR
004700130514     C                   IF        NOT %FOUND(ACMUNIQUE) OR
004800130514     C                             ATRMDT > 0
004900130514     C                   LEAVESR
005000130327     C                   ENDIF
005100130327    ***
005200130514     C     KL#TSA        CHAIN     MEMBR
005300130514     C                   IF        NOT %FOUND(MEMAC#) OR
005400130514     C                             WTERMDT > 0
005500130514     C                   LEAVESR
005600130514     C                   ENDIF
005700130514    ***
005800130514     C                   IF        OCPHN1 = '0000000000' OR
005900130514     C                             OCPHN1 = '1111111111' OR
006000130514     C                             OCPHN1 = '2222222222' OR
006100130514     C                             OCPHN1 = '3333333333' OR
006200130514     C                             OCPHN1 = '4444444444' OR
006300130514     C                             OCPHN1 = '5555555555' OR
006400130514     C                             OCPHN1 = '6666666666' OR
006500130514     C                             OCPHN1 = '7777777777' OR
006600130514     C                             OCPHN1 = '8888888888' OR
006700130514     C                             OCPHN1 = '9999999999'
006800130514     C                   EVAL      OCPHN1 = *BLANKS
006900130514     C                   ENDIF
007000130918    ***
007100130918     C     ',':' '       XLATE     OCFNAM        OCFNAM
007200130918     C     ',':' '       XLATE     OCLNAM        OCLNAM
007300130918     C     ',':' '       XLATE     OCADD1        OCADD1
007400130918     C     ',':' '       XLATE     OCADD2        OCADD2
007500130918     C     ',':' '       XLATE     OCCITY        OCCITY
007600130514    ***
007700130918     C                   EVAL      X = '338' + Q +
007800130514     C                             %TRIM(%EDITC(WMBSSNO:'X')) + %TRIM(OCLNAM) +
007900130514     C                             %SUBST(OCFNAM:1:1) + Q +
008000130514     C                             %TRIM(OCFNAM) + Q +
008100130514     C                             %TRIM(OCLNAM) + Q + %TRIM(OCPHN1) + Q +
008200130514     C                             %TRIM(OCADD1) + Q + %TRIM(OCADD2) + Q +
008300130514     C                             %TRIM(OCCITY) + Q + OCST + Q +
008400130514     C                             %SUBST(OCZIP:1:5) + Q +
008500130514     C                             %TRIM(OCTITL) + Q + %TRIM(OCEMAL) +
008600130918     C                             ',FALSE,' + %EDITC(WMBSSNO:'X') + ',FALSE'
008700130327     C                   EXCEPT    OUTF
008800130327    ***
008900130327     C                   ENDSR
009000130327   S***S
009100130327     C     *INZSR        BEGSR
009200130517    ***
009300130517     C     KL#ODC        KLIST
009400130517     C                   KFLD                    A20TRS
009500130517     C                   KFLD                    A20SUB
009600130517     C                   KFLD                    A20ACC
009700130517    ***
009800130517     C     KL#TSA        KLIST
009900130517     C                   KFLD                    OCTRST
010000130517     C                   KFLD                    OCSUB#
010100130517     C                   KFLD                    OCACCT
010200130327    ***
010300130327     C                   EVAL      X = C1
010400130327     C                   EXCEPT    OUTF
010500130327    ***
010600130327     C                   EVAL      X = C2
010700130327     C                   EXCEPT    OUTF
010800130327    ***
010900130327     C                   ENDSR
011000130327   S***S
011100130327   X***X
011200130327     OT2000     EADD         OUTF
011300130327     O                       X              B  2000
