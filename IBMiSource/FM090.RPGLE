0001009408170002 F******************************************************************
0002009909300003 F* FM090      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009703310006 F*            DATE - 03/31/97                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008009703310009 F*            WCEXCL FILE.                                        *
0009009408170010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012009703310013 FFM090D    CF   E             WORKSTN
001300970401     F                                     SFILE(SF01:RRN)
0014009703310015 FWCEXCL    UF A E           K DISK
0015009703310015 FACCMST    IF   E           K DISK
001600950126     D COMPAN          DS
001700940921     D*  DATA AREA - COMPANY NAME
001800940921     D  COMP                   1     55
001900970401     D                 DS
002000970401     D  TSA                    1     10  0
002100970401     D  WCETRS                 1      3  0
002200970401     D  WCESUB                 4      6  0
002300970401     D  WCEACC                 7     10  0
002400940921     C*
002500940921     C* GET DATA AREA AND IMMEDIATELY RELEASE
002600940921     C*
0027009409210088 C     FIRST         IFNE      'F'
002800940921     C     *DTAARA       DEFINE                  COMPAN
002900940921     C                   IN        COMPAN
003000940921     C                   MOVEL     COMP          COMPNY
003100970331     C     WCKEY         KLIST
003200970331     C                   KFLD                    WCETRS
003300970331     C                   KFLD                    WCESUB
003400970331     C                   KFLD                    WCEACC
003500940921     C                   MOVE      'F'           FIRST             1
0036009409210096 C                   END
003700970401     C*
003800970401     C                   MOVE      *ZEROS        WCETRS
003900970401     C                   MOVE      *ZEROS        WCESUB
004000970401     C                   MOVE      *ZEROS        WCEACC
004100970401     C                   SETON                                          88
004200940817     C     #T0005        TAG
004300940817     C*
004400970331     C                   SETOFF                                       KD
004500940817     C                   EXFMT     SCRN01
0046009408170076 C*
0047009408170077 C*  ON CMD 7 END
0048009408170078 C*
0049009409210079 C     *IN07         IFEQ      '1'
0050009409210080 C                   SETON                                        LR
0051009409210080 C                   GOTO      #END
005200940921     C                   END
0053009704010076 C*
0054009704010077 C*  ON CMD 5 DISPLAY SUBFILE OF ACCTS
0055009704010078 C*
0056009704010079 C     *INKE         IFEQ      '1'
0057009704010080 C                   EXSR      #DSPAC
0058009704010080 C                   GOTO      #T0005
005900970401     C                   END
0060009501260076 C*
006100970331     C     WCKEY         CHAIN     ACCMST                             87
0062009703310168 C   87              GOTO      #T0005
0063009703310076 C*
006400970331     C     WCKEY         CHAIN     WCEXCR                             88
0065009704010076 C*
006600970401     C     *IN88         IFEQ      *OFF
006700970401     C  NKD              GOTO      #T0005
006800970401     C   KD              DELETE    WCEXCR
0069009704010076 C*
007000970401     C                   ELSE
0071009704010076 C*
007200970401     C                   WRITE     WCEXCR
007300970401     C                   END
0074009408170167 C*
007500970401     C                   MOVE      *ZEROS        WCETRS
007600970401     C                   MOVE      *ZEROS        WCESUB
007700970401     C                   MOVE      *ZEROS        WCEACC
007800970401     C                   SETON                                        88
0079009408170168 C                   GOTO      #T0005
008000940817     C     #END          TAG
008100970401     C************************************
008200970401     C* DISPLAY ACCTS IN SUBFILE WINDOW  *
008300970401     C************************************
008400970401     C     #DSPAC        BEGSR
008500970401     C*
008600970401     C* CLEAR SUBFILE
008700970401     C*
008800970401     C                   MOVEA     '001'         *IN(90)
008900970401     C                   WRITE     SF01CTL
009000970401     C                   MOVE      '0'           *IN92
009100970401     C*
009200970401     C* BUILD SUBFILE
009300970401     C*
009400970401     C                   MOVE      *ZEROS        RRN               5 0
009500970401     C     *LOVAL        SETLL     WCEXCL
009600970401     C     #T0020        TAG
009700970401     C                   READ      WCEXCL                                 91
009800970401     C     *IN91         IFEQ      '0'
009900970401     C     WCKEY         CHAIN     ACCMST                             50
010000970401     C   50              MOVE      *BLANKS       NAME
010100970401     C  N50              MOVEL     ACNAM1        NAME
010200970401     C                   ADD       1             RRN
010300970401     C                   WRITE     SF01
010400970401     C                   GOTO      #T0020
010500970401     C                   END
010600970401     C*
010700970401     C* DISPLAY SUBFILE IN WINDOW
010800970401     C*
010900970401     C     #T0030        TAG
011000970401     C     RRN           IFGT      0
011100970401     C                   MOVE      '1'           *IN90
011200970401     C                   END
011300970401     C*
011400970401     C                   WRITE     WINDOW
011500970401     C                   EXFMT     SF01CTL
011600970401     C                   MOVE      *ZEROS        TSA
011700970401     C*
011800970401     C                   ENDSR
