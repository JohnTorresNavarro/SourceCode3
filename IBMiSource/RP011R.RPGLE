000100000000      *?****************************************************************
000200000000      *?                                                               *
000300000000      *? RP011      GROUP BENEFIT SERVICES SOFTWARE                    *
000400000000      *?                                                               *
000500000000      *?           WRITTEN BY - DLK                                    *
000600000000      *?           DATE - 07/15/98                                     *
000700000000      *?                                                               *
000800000000      *? DESCRIPTION - NEW FRONT END FOR RP010...SELECTS T/S/A         *
000900000000      *?                                                               *
001000000607      *? SZZ   6.7.00 -  ALLOW SELECTION OF ONE SALESPERSON.           *
0011000206130015  *?11/15/01 DLK - CONVERT TO RPGLE                                *
0012000206130015  *?06/13/02 TWP - EVAL MCSMCD = SMANCD ON ALL RECORDS             *
001300000607      *?                                                               *
001400000000      *?****************************************************************
001500011115JGE01FMEMAC#    IF   E           K DISK
001600011115JGE01FMCOV      IF   E           K DISK
001700011115     FACCMST    IF   E           K DISK
001800020613JGE01FUTL040    O    E             DISK
001900000000     D                UDS
002000000000     D  LT                     2      4
002100000000     D  LS                     5      7
002200000000     D  LA                     8     11
002300000607     D  SL                    30     32
002400000000JGE01D  LD8YMD               248    255  0
002500011115
002600000000     C     TSA           SETLL     MEMAC#
002700011115
002800000000     C     #T0010        TAG
002900000000     C                   READ      MEMAC#                                 50
003000000000     C   50              GOTO      #END
003100011115
003200020613      *? ALL TRUST = 80
003300011115     C  N80T             IFNE      MBTRST
003400000000     C                   GOTO      #END
003500000000     C                   END
003600011115
003700020613      *? ALL SUB   = 81
003800011115     C  N81S             IFNE      MBSUB#
003900020613      *? ALL TRUST = 80
004000000000     C   80              GOTO      #T0010
004100000000     C  N80              GOTO      #END
004200000000     C                   END
004300011115
004400020613      *? ALL ACC   = 82
004500011115     C  N82A             IFNE      MBACCT
004600020613      *? ALL TRUST = 80
004700020613      *? ALL SUB   = 81
004800000000     C   80
004900000000     COR 81              GOTO      #T0010
005000000000     C                   GOTO      #END
005100000000     C                   END
005200011115
005300020613      *? SKIP CANCELLED MEMBERS
005400000000     C     TERMDT        IFNE      0
005500000000JGE01C     TERMDT        IFLE      LD8YMD
005600000000     C                   GOTO      #T0010
005700000000     C                   END
005800000000     C                   END
005900011115
006000000000     C     MBSSNO        SETLL     MCOV
006100000000     C     #T0020        TAG
006200000000     C     MBSSNO        READE     MCOV                                   51
006300000000     C   51              GOTO      #T0010
006400011115
006500020613      *? SKIP CANCELLED COVERAGES
006600011115
006700000000     C     ENRLDT        IFEQ      CANDT
006800000000     C                   GOTO      #T0020
006900000000     C                   END
007000011115
007100000000     C     CANDT         IFNE      0
007200000000JGE01C     CANDT         IFLE      LD8YMD
007300000000     C                   GOTO      #T0020
007400000000     C                   END
007500000000     C                   END
007600011115
007700020613     C     *NOKEY        CLEAR     *ALL          ACCMSR
007800000607     C     ACCKEY        CHAIN     ACCMST                             52
007900020613     C     SL            IFNE      'ALL'
008000011115     C     SMANCD        IFNE      SL
008100000607     C                   GOTO      #T0010
008200000607     C                   END
008300000607     C                   END
008400020613     C                   EVAL      MCSMCD = SMANCD
008500011115
008600020613      *? OUTPUT RECORD
008700011115
008800011115     C                   WRITE     UTL04R
008900000000     C                   GOTO      #T0020
009000011115
009100000000     C     #END          TAG
009200011115
009300000000     C                   SETON                                        LR
009400011115
009500020613      *?*****************************************************
009600011115     C     *INZSR        BEGSR
009700020613      *? SET UP TSA SELECTION
009800011115     C     LT            IFNE      'ALL'
009900030410     C                   TESTN                   LT                   26
010000030410     C                   IF        *IN26 = *OFF
010100030410     C                   EVAL      LT = *ZEROS
010200030410     C                   END
010300011115     C                   MOVE      LT            T                 3 0
010400011115     C                   ELSE
010500020613      *? ALL TRUST
010600011115     C                   MOVE      *ZEROS        T
010700011115     C                   SETON                                        80
010800011115     C                   END
010900011115
011000011115     C     LS            IFNE      'ALL'
011100030410     C                   TESTN                   LS                   26
011200030410     C                   IF        *IN26 = *OFF
011300030410     C                   EVAL      LS = *ZEROS
011400030410     C                   END
011500011115     C                   MOVE      LS            S                 3 0
011600011115     C                   ELSE
011700011115     C                   MOVE      *ZEROS        S
011800011115     C                   SETON                                        81
011900011115     C                   END
012000011115
012100011115     C     LA            IFNE      'ALL '
012200030410     C                   TESTN                   LA                   26
012300030410     C                   IF        *IN26 = *OFF
012400030410     C                   EVAL      LA = *ZEROS
012500030410     C                   END
012600011115     C                   MOVE      LA            A                 4 0
012700011115     C                   ELSE
012800011115     C                   MOVE      *ZEROS        A
012900011115     C                   SETON                                        82
013000011115     C                   END
013100011115
013200011115     C     ACCKEY        KLIST
013300011115     C                   KFLD                    MBTRST
013400011115     C                   KFLD                    MBSUB#
013500011115     C                   KFLD                    MBACCT
013600011115
013700011115     C     TSA           KLIST
013800011115     C                   KFLD                    T
013900011115     C                   KFLD                    S
014000011115     C                   KFLD                    A
014100011115
014200011115     C                   ENDSR
