000100130327   X***X
000200130327    ***
000300130514     FODCNTCP   IPE  E           K DISK
000400130514     FACMUNIQUE IF   E           K DISK
000500130514     FMEMAC#    IF   E           K DISK    PREFIX(W)
000600130327     FT2000     O  A F 2000        DISK
000700130327    ***
000800130327   X***X
000900130327     D X               S           2000A
001000130327    ***
001100130514     D DS@O          E DS                  EXTNAME(ODCNTCP)
001200130514     D DS@M          E DS                  EXTNAME(MEMBER) PREFIX(W)
001300130514     D DS@A          E DS                  EXTNAME(ACMUNIQUE)
001400130327    ***
001500130327     D Q               C                   CONST('","')
001600130514    ***
001700130617     D C1              C                   CONST('Contact Save,,,,,,,,,,,,,,')
001800130514    ***
001900130617     D C2              C                   CONST('CustomerId,ContactDescription-
002000130617     D                                     ,FirstName,LastName,Phone,Address1,A-
002100130617     D                                     ddress2,City,State,PostalCode,Relati-
002200130617     D                                     onship,Email,IsMaster,SystemPatientI-
002300130617     D                                     D,IsPayer')
002400130514    ***
002500130327   X***X
002600130514     C                   IF        OCTRST > 0 AND OCSUB# > 0 AND OCACCT > 0
002700130514     C                             AND OCCCOD = 'ARP' AND OCTRM = 0
002800130327     C                   EXSR      $A
002900130327     C                   ENDIF
003000130327    ***
003100130327   S***S
003200130327     C     $A            BEGSR
003300130327    ***
003400130514     C                   CLEAR                   DS@A
003500130514     C                   CLEAR                   DS@M
003600130327    ***
003700130514     C     KL#TSA        KLIST
003800130514     C                   KFLD                    OCTRST
003900130514     C                   KFLD                    OCSUB#
004000130514     C                   KFLD                    OCACCT
004100130327    ***
004200130514     C     KL#TSA        CHAIN     ACCMSR
004300130514     C                   IF        NOT %FOUND(ACMUNIQUE) OR
004400130514     C                             ATRMDT > 0
004500130514     C                   LEAVESR
004600130327     C                   ENDIF
004700130327    ***
004800130514     C     KL#TSA        CHAIN     MEMBR
004900130514     C                   IF        NOT %FOUND(MEMAC#) OR
005000130514     C                             WTERMDT > 0
005100130514     C                   LEAVESR
005200130514     C                   ENDIF
005300130514    ***
005400130514     C                   IF        OCPHN1 = '0000000000' OR
005500130514     C                             OCPHN1 = '1111111111' OR
005600130514     C                             OCPHN1 = '2222222222' OR
005700130514     C                             OCPHN1 = '3333333333' OR
005800130514     C                             OCPHN1 = '4444444444' OR
005900130514     C                             OCPHN1 = '5555555555' OR
006000130514     C                             OCPHN1 = '6666666666' OR
006100130514     C                             OCPHN1 = '7777777777' OR
006200130514     C                             OCPHN1 = '8888888888' OR
006300130514     C                             OCPHN1 = '9999999999'
006400130514     C                   EVAL      OCPHN1 = *BLANKS
006500130514     C                   ENDIF
006600130514    ***
006700130514     C                   EVAL      X = '"338' + Q +
006800130514     C                             %TRIM(%EDITC(WMBSSNO:'X')) + %TRIM(OCLNAM) +
006900130514     C                             %SUBST(OCFNAM:1:1) + Q +
007000130514     C                             %TRIM(OCFNAM) + Q +
007100130514     C                             %TRIM(OCLNAM) + Q + %TRIM(OCPHN1) + Q +
007200130514     C                             %TRIM(OCADD1) + Q + %TRIM(OCADD2) + Q +
007300130514     C                             %TRIM(OCCITY) + Q + OCST + Q +
007400130514     C                             %SUBST(OCZIP:1:5) + Q +
007500130514     C                             %TRIM(OCTITL) + Q + %TRIM(OCEMAL) +
007600130514     C                             '",FALSE,' + %EDITC(WMBSSNO:'X') + ',FALSE'
007700130327     C                   EXCEPT    OUTF
007800130327    ***
007900130327     C                   ENDSR
008000130327   S***S
008100130327     C     *INZSR        BEGSR
008200130327    ***
008300130327     C                   EVAL      X = C1
008400130327     C                   EXCEPT    OUTF
008500130327    ***
008600130327     C                   EVAL      X = C2
008700130327     C                   EXCEPT    OUTF
008800130327    ***
008900130327     C                   ENDSR
009000130327   S***S
009100130327   X***X
009200130327     OT2000     EADD         OUTF
009300130327     O                       X              B  2000
