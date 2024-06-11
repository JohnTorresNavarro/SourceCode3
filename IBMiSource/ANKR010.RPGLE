000100130327   X***X
000200130327    ***
000300130327     FODFACP    IPE  E           K DISK
000400130327     FSUMUNIQUE IF   E           K DISK
000500130327     FODHYGP    IF   E           K DISK
000600130327     FODDENTP   IF   E           K DISK
000700130327     FT2000     O  A F 2000        DISK
000800130327    ***
000900130327   X***X
001000130327     D X               S           2000A
001100130327     D @@H             S             80A
001200130327     D @@D             S             80A
001300130327    ***
001400130327     D DS@S          E DS                  EXTNAME(SUMUNIQUE)
001500130327    ***
001600130327     D Q               C                   CONST('","')
001700130327     D C1              C                   CONST('Business Save,,,,,,,,,,,')
001800130327     D C2              C                   CONST('BusinessID,Name,Address1,Addr-
001900130327     D                                     ess2,City,StateCode,PostalCode,Phone-
002000130327     D                                     1,Fax,Email1,Admin1,Admin2')
002100130327     D C3              C                   CONST('kdwhitis@mahweb.com')
002200130327   X***X
002300130327     C                   IF        S2TRST > 0 AND S2SUB# > 0 AND S2TRM = 0
002400130327     C                   EXSR      $A
002500130327     C                   ENDIF
002600130327    ***
002700130327   S***S
002800130327     C     $A            BEGSR
002900130327    ***
003000130327     C                   EVAL      @@H = *BLANKS
003100130327     C                   EVAL      @@D = *BLANKS
003200130327    ***
003300130327     C     KL#TS         KLIST
003400130327     C                   KFLD                    S2TRST
003500130327     C                   KFLD                    S2SUB#
003600130327    ***
003700130327     C     KL#TS         CHAIN     SUBMSR
003800130327     C                   IF        NOT %FOUND(SUMUNIQUE)
003900130327     C                   CLEAR                   DS@S
004000130327     C                   ENDIF
004100130327    ***
004200130327     C     S2HYG#        CHAIN     ODHYGR
004300130327     C                   IF        %FOUND(ODHYGP)
004400130327     C                   EVAL      @@H = %SUBST((%TRIM(MHFNAM)):1:1) +
004500130327     C                                %TRIM(MHLNAM)
004600130327     C                   ENDIF
004700130327    ***
004800130327     C     S2DENT        CHAIN     ODDENTR
004900130327     C                   IF        %FOUND(ODDENTP)
005000130327     C                   EVAL      @@D = %SUBST((%TRIM(ODFNAM)):1:1) +
005100130327     C                                %TRIM(ODLNAM)
005200130327     C                   ENDIF
005300130327    ***
005400130327     C                   EVAL      X = '"338' + Q + %TRIM(SUBDSC) + Q +
005500130327     C                             %TRIM(S2ADD1) + Q +
005600130327     C                             %TRIM(S2ADD2) + Q +
005700130327     C                             %TRIM(S2CITY) + Q +
005800130327     C                             %TRIM(S2ST) + Q +
005900130327     C                             %SUBST(S2ZIP:1:5) + Q +
006000130327     C                             %TRIM(S2PHON) + Q +
006100130327     C                             %TRIM(S2FAX) + Q + C3 + Q +
006200130327     C                             %TRIM(@@H) + Q + %TRIM(@@D) + '"'
006300130327     C                   EXCEPT    OUTF
006400130327    ***
006500130327     C                   ENDSR
006600130327   S***S
006700130327     C     *INZSR        BEGSR
006800130327    ***
006900130327     C                   EVAL      X = C1
007000130327     C                   EXCEPT    OUTF
007100130327    ***
007200130327     C                   EVAL      X = C2
007300130327     C                   EXCEPT    OUTF
007400130327    ***
007500130327     C                   ENDSR
007600130327   S***S
007700130327   X***X
007800130327     OT2000     EADD         OUTF
007900130327     O                       X              B  2000
