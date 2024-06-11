000100010124    *** FM063RPT - EDIT REPORT FOR SIZE CODES ATTACHED BUT NO LONGER MATCH TO THE
000200010124    ***              CARRIER MARKET SIZES FILE
000300010124    ***
000400010124    *** SSK 01.24.2001
000500010124    ***
000600010124    ***
000700010124     FMKTCARA1  IPE  E           K DISK
000800000102     FACCMST    IF   E           K DISK
000900000102     FCARMST    IF   E           K DISK
001000010124     FCARMKSZ1  IF   E           K DISK
001100010124     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOA)
001200000102   X***X
001300010116     D #ISO            S               D   DATFMT(*ISO)
001400010116     D #USA            S               D   DATFMT(*USA)
001500010120     D #ISA            S              8S 0
001600010124     D #FUSA           S              8S 0
001700010124     D #TUSA           S              8S 0
001800000102    ***
001900010124     D ACNAM1          DS
002000010124     D  @@PANAM                1     30A
002100010124    ***
002200010124     D CNAME           DS
002300010124     D  @@PCNAM                1     30A
002400000102   X***X
002500010124     C     CK            CHAIN(N)  RCARMKSZ
002600010124    1C                   IF        NOT %FOUND(CARMKSZ1)
002700010124     C     AK            CHAIN(N)  ACCMSR
002800010124    2C                   IF        NOT %FOUND(ACCMST)
002900010124     C                   MOVE      *BLANKS       ACNAM1
003000010124    2C                   ENDIF
003100010124     C     MACARR        CHAIN(N)  CARMSR
003200010124    2C                   IF        NOT %FOUND(CARMST)
003300010124     C                   MOVE      *BLANKS       CNAME
003400010124    2C                   ENDIF
003500010124     C                   MOVE      MAFRDT        #ISA
003600010124     C                   EXSR      $ISOUSA
003700010124     C                   MOVE      #ISA          #FUSA
003800010124     C                   MOVE      MATODT        #ISA
003900010124     C                   EXSR      $ISOUSA
004000010124     C                   MOVE      #ISA          #TUSA
004100010124    2C                   IF        *INOA = *ON
004200010124     C                   EXCEPT    HDGF01
004300010124    2C                   ENDIF
004400010124     C                   EXCEPT    DTLF01
004500010124    1C                   ENDIF
004600000102   S***S
004700000102     C     *INZSR        BEGSR
004800000102    ***
004900010124     C     CK            KLIST
005000010124     C                   KFLD                    MACARR
005100010124     C                   KFLD                    MASZCD
005200010124     C     AK            KLIST
005300010124     C                   KFLD                    MATRST
005400010124     C                   KFLD                    MASUB#
005500010124     C                   KFLD                    MAACC#
005600010124    ***
005700010124     C                   EXCEPT    HDGF01
005800000102    ***
005900000102     C                   ENDSR
006000000102   S***S
006100010116     C     $ISOUSA       BEGSR
006200010116    ***
006300010124    1C                   IF        #ISA <> 0
006400010120     C     *ISO          TEST (DE)               #ISA
006500010120    2C                   IF        NOT %ERROR
006600010120     C                   MOVE      #ISA          #ISO
006700010120     C                   MOVE      #ISO          #USA
006800010120     C                   MOVE      #USA          #ISA
006900010120    2C                   ELSE
007000010120     C                   MOVE      *ZEROS        #ISA
007100010120    2C                   ENDIF
007200010120    1C                   ENDIF
007300000102    ***
007400000102     C                   ENDSR
007500010124   X***X
007600010124     OQSYSPRT   E            HDGF01         1  1
007700010124     O                                            9 'FM063RPT'
007800010124     O                                           73 'MARKET SIZES BY ACCOUNT & '
007900010124     O                                           85 'CARRIER EDIT'
008000010124     O                       UDATE         Y    117
008100010124     O                       PAGE          Z    130
008200010124     OQSYSPRT   E            HDGF01         2
008300010124     O                                           76 'SIZE CODES NO LONGER VALID'
008400010124     O                                           83 ' REPORT'
008500010124     OQSYSPRT   E            HDGF01         1
008600010124     O                                            4 'TRS'
008700010124     O                                            9 'SUB'
008800010124     O                                           37 'ACCT & NAME               '
008900010124     O                                           46 '         '
009000010124     O                                           74 'CARRIER & NAME            '
009100010124     O                                           82 '        '
009200010124     O                                           94 'FROM DATE '
009300010124     O                                          106 'TO DATE   '
009400010124     O                                          113 'CODE '
009500010124     OQSYSPRT   E            DTLF01      1
009600010124     O                       MATRST               4
009700010124     O                       MASUB#               9
009800010124     O                       MAACC#              15
009900010124     O                       @@PANAM             46
010000010124     O                       MACARR              51
010100010124     O                       @@PCNAM             82
010200010124     O                       #FUSA         Y     94
010300010124     O                       #TUSA         Y    106
010400010124     O                       MASZCD             113
