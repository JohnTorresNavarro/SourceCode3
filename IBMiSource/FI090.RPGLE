0001009408170002 F******************************************************************
0002009909300003 F* FM90A      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009703310006 F*            DATE - 03/31/97                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008009703310009 F*            WCEXCL FILE.                                        *
0009009408170010 F*                                                                *
0010009803270010 F*----------------------------------------------------------------*
001100980327     F*  MODIFICATION : COPY OF FM090 MODIFIED FOR EXTENSION MASTER
001200980327     F*                 FILE INQUIRY ONLY.                3/98   MLF
0013009408170011 F******************************************************************
0014009408170012 F*                                                                *
0015009803310013 FFI090D    CF   E             WORKSTN
001600970401     F                                     SFILE(SF01:RRN)
0017009803270015 FWCEXCL    IF   E           K DISK
0018009703310015 FACCMST    IF   E           K DISK
001900950126     D COMPAN          DS
002000940921     D*  DATA AREA - COMPANY NAME
002100940921     D  COMP                   1     55
002200970401     D                 DS
002300970401     D  TSA                    1     10  0
002400970401     D  WCETRS                 1      3  0
002500970401     D  WCESUB                 4      6  0
002600970401     D  WCEACC                 7     10  0
002700940921     C*
002800940921     C* GET DATA AREA AND IMMEDIATELY RELEASE
002900940921     C*
0030009409210088 C     FIRST         IFNE      'F'
003100940921     C     *DTAARA       DEFINE                  COMPAN
003200940921     C                   IN        COMPAN
003300940921     C                   MOVEL     COMP          COMPNY
003400970331     C     WCKEY         KLIST
003500970331     C                   KFLD                    WCETRS
003600970331     C                   KFLD                    WCESUB
003700970331     C                   KFLD                    WCEACC
003800940921     C                   MOVE      'F'           FIRST             1
0039009409210096 C                   END
004000970401     C*
004100970401     C                   MOVE      *ZEROS        WCETRS
004200970401     C                   MOVE      *ZEROS        WCESUB
004300970401     C                   MOVE      *ZEROS        WCEACC
004400970401     C                   SETON                                          88
004500940817     C     #T0005        TAG
004600940817     C*
004700970331     C                   SETOFF                                       KD
004800940817     C                   EXFMT     SCRN01
0049009408170076 C*
0050009408170077 C*  ON CMD 7 END
0051009408170078 C*
0052009409210079 C     *IN07         IFEQ      '1'
0053009409210080 C                   SETON                                        LR
0054009409210080 C                   GOTO      #END
005500940921     C                   END
0056009704010076 C*
0057009704010077 C*  ON CMD 5 DISPLAY SUBFILE OF ACCTS
0058009704010078 C*
0059009704010079 C     *INKE         IFEQ      '1'
0060009704010080 C                   EXSR      #DSPAC
0061009704010080 C                   GOTO      #T0005
006200970401     C                   END
0063009501260076 C*
006400970331     C     WCKEY         CHAIN     ACCMST                             87
0065009703310168 C   87              GOTO      #T0005
0066009703310076 C*
006700970331     C     WCKEY         CHAIN     WCEXCR                             88
0068009704010076 C*
006900980327     C     *IN88         IFEQ      *ON
007000980327     C                   GOTO      #T0005
007100970401     C                   END
0072009408170167 C*
007300940817     C     #END          TAG
007400970401     C************************************
007500970401     C* DISPLAY ACCTS IN SUBFILE WINDOW  *
007600970401     C************************************
007700970401     C     #DSPAC        BEGSR
007800970401     C*
007900970401     C* CLEAR SUBFILE
008000970401     C*
008100970401     C                   MOVEA     '001'         *IN(90)
008200970401     C                   WRITE     SF01CTL
008300970401     C                   MOVE      '0'           *IN92
008400970401     C*
008500970401     C* BUILD SUBFILE
008600970401     C*
008700970401     C                   MOVE      *ZEROS        RRN               5 0
008800970401     C     *LOVAL        SETLL     WCEXCL
008900970401     C     #T0020        TAG
009000970401     C                   READ      WCEXCL                                 91
009100970401     C     *IN91         IFEQ      '0'
009200970401     C     WCKEY         CHAIN     ACCMST                             50
009300970401     C   50              MOVE      *BLANKS       NAME
009400970401     C  N50              MOVEL     ACNAM1        NAME
009500970401     C                   ADD       1             RRN
009600970401     C                   WRITE     SF01
009700970401     C                   GOTO      #T0020
009800970401     C                   END
009900970401     C*
010000970401     C* DISPLAY SUBFILE IN WINDOW
010100970401     C*
010200970401     C     #T0030        TAG
010300970401     C     RRN           IFGT      0
010400970401     C                   MOVE      '1'           *IN90
010500970401     C                   END
010600970401     C*
010700970401     C                   WRITE     WINDOW
010800970401     C                   EXFMT     SF01CTL
010900970401     C                   MOVE      *ZEROS        TSA
011000970401     C*
011100970401     C                   ENDSR
