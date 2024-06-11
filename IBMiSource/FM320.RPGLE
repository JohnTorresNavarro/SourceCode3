0001009602140002 F******************************************************************
0002009909300003 F* FM320      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009602140004 F*                                                                *
0004009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009708060006 F*            DATE -  8/06/97                                     *
0006009602140007 F*                                                                *
0007009708060008 F*  DESCRIPTION - FILE MAINT FOR RIDER MASTER                     *
0008009602140012 F*                                                                *
0009009602140013 F******************************************************************
001000970806     FFM320D    CF   E             WORKSTN
001100961031     F                                     SFILE(SF01:RRN)
001200970807     F                                     SFILE(SF02:RR2)
001300970806     FRIDPLN    UF A E           K DISK
001400970806     FRIDMST    IF   E           K DISK
001500970806     FPLNMST    IF   E           K DISK
0016009708070124 D                UDS
0017009708070054 D  CONAME               201    240
001800970806     C     RPKEY         KLIST
001900970806     C                   KFLD                    ITRST
002000970806     C                   KFLD                    ISUB
002100970806     C                   KFLD                    IPLN
002200970806     C                   KFLD                    IRID
002300970806     C     RKEY          KLIST
002400970806     C                   KFLD                    PCARR
002500970806     C                   KFLD                    IRID
002600970806     C     PLNKEY        KLIST
002700970806     C                   KFLD                    ITRST
002800970806     C                   KFLD                    ISUB
002900970806     C                   KFLD                    IPLN
003000921015     C*
003100960208     C* WRITE FIRST SCREEN
003200960208     C*
003300960206     C     #T0010        TAG
003400970806     C                   MOVE      *ZEROS        ITRST
003500970806     C                   MOVE      *ZEROS        ISUB
003600970806     C                   MOVE      *ZEROS        IPLN
003700970806     C                   MOVE      *BLANKS       IRID
003800961111     C     #T0015        TAG
003900961030     C                   EXFMT     SCRN01
004000921013     C*
004100960208     C* CMD7 END
004200960208     C*
004300960208     C     *INKG         CABEQ     '1'           #END
004400961111     C*
004500970806     C* CMD4 - DSPLAY RIDERS IN WINDOW
004600961111     C*
004700961111     C     *INKD         IFEQ      '1'
004800970806     C                   EXSR      #DSPRI
004900961111     C                   GOTO      #T0015
005000961111     C                   END
005100970807     C*
005200970807     C* CMD6 - DSPLAY RIDER/PLAN LINKS IN WINDOW
005300970807     C*
005400970807     C     *INKF         IFEQ      '1'
005500970807     C                   EXSR      #DSPRL
005600970807     C                   GOTO      #T0015
005700970807     C                   END
005800921013     C*
005900970806     C* EDIT
006000960208     C*
006100970806     C     PLNKEY        CHAIN     PLNMST                             40
006200970806     C   40              GOTO      #T0015
006300970806     C     RKEY          CHAIN     RIDMST                             41
006400970806     C   41              GOTO      #T0015
006500970806     C     RPKEY         CHAIN     RIDPLN                             42
006600970806     C     *IN42         IFEQ      *ON
006700970806     C                   MOVE      ITRST         RPTRST
006800970806     C                   MOVE      ISUB          RPSUB
006900970806     C                   MOVE      IPLN          RPPLN
007000970806     C                   MOVE      IRID          RPRID
007100970806     C                   MOVE      *ZEROS        RPEFF
007200970806     C                   MOVE      *ZEROS        RPCAN
007300970806     C                   END
007400961030     C                   EXSR      #UP
007500960208     C*
007600960219     C                   GOTO      #T0010
007700960208     C*
007800960208     C     #END          TAG
007900960208     C                   MOVE      '1'           *INLR
008000961031     C*******************
008100961031     C* UPDATE RECORDS  *
008200961031     C*******************
008300961030     C     #UP           BEGSR
008400960208     C*
008500970806     C                   MOVEA     '00'          *IN(43)
008600970806     C     #T0018        TAG
008700970806     C                   EXFMT     SCRN02
008800970806     C     *INKA         CABEQ     '1'           #T0010
008900961030     C*
009000970806     C* EDIT FIELDS
009100970806     C*
009200970806     C     RPEFF         IFLT      19970101
009300970806     C                   MOVE      '1'           *IN43
009400970806     C                   GOTO      #T0018
009500970806     C                   END
009600960208     C*
009700970806     C     RPCAN         IFNE      0
009800970806     C     RPCAN         ANDLT     19970101
009900970806     C                   MOVE      '1'           *IN44
010000970806     C                   GOTO      #T0018
010100970806     C                   END
010200970806     C*
010300970806     C     RPCAN         IFNE      0
010400970806     C     RPCAN         ANDLT     RPEFF
010500970806     C                   MOVE      '1'           *IN44
010600970806     C                   GOTO      #T0018
010700970806     C                   END
010800970806     C*
010900970806     C   42              WRITE     RIDPLR
011000970806     C  N42              UPDATE    RIDPLR
011100970806     C*
011200961031     C                   ENDSR
011300961031     C************************************
011400970806     C* DISPLAY RIDERS IN SUBFILE WINDOW *
011500961031     C************************************
011600970806     C     #DSPRI        BEGSR
011700961031     C*
011800961031     C* CLEAR SUBFILE
011900961031     C*
012000961031     C                   MOVEA     '001'         *IN(90)
012100961031     C                   WRITE     SF01CTL
012200961031     C                   MOVE      '0'           *IN92
012300961031     C*
012400970806     C* BUILD SUBFILE - LOAD ALL
012500961031     C*
012600961031     C                   MOVE      *ZEROS        RRN               5 0
012700970806     C     *LOVAL        SETLL     RIDMST
012800961031     C     #T0020        TAG
012900970806     C                   READ      RIDMST                                 91
013000961031     C     *IN91         IFEQ      '0'
013100961031     C                   ADD       1             RRN
013200970806     C                   MOVE      RCARR         OCARR
013300970806     C                   MOVE      RCODE         ORIDER
013400970806     C                   MOVEL     RDESC         ODESC
013500961031     C                   WRITE     SF01
013600961031     C                   GOTO      #T0020
013700961031     C                   END
013800961031     C*
013900961031     C* DISPLAY SUBFILE IN WINDOW
014000961031     C*
014100961031     C     #T0030        TAG
014200961031     C     RRN           IFGT      0
014300961031     C                   MOVE      '1'           *IN90
014400961031     C                   END
014500961031     C*
014600961031     C                   WRITE     WINDOW
014700961031     C                   EXFMT     SF01CTL
014800961031     C                   ENDSR
014900970807     C**********************************************
015000970807     C* DISPLAY RIDER/PLAN LINKS IN SUBFILE WINDOW *
015100970807     C**********************************************
015200970807     C     #DSPRL        BEGSR
015300970807     C*
015400970807     C* CLEAR SUBFILE
015500970807     C*
015600970807     C                   MOVEA     '001'         *IN(80)
015700970807     C                   WRITE     SF02CTL
015800970807     C                   MOVE      '0'           *IN82
015900970807     C*
016000970807     C* BUILD SUBFILE - LOAD ALL
016100970807     C*
016200970807     C                   MOVE      *ZEROS        RR2               5 0
016300970807     C     RPKEY         SETLL     RIDPLN
016400970807     C     #T0040        TAG
016500970807     C                   READ      RIDPLN                                 81
016600970807     C     *IN81         IFEQ      '0'
016700970807     C     RPTRST        ANDEQ     ITRST
016800970807     C     RPSUB         ANDEQ     ISUB
016900970807     C     RPPLN         ANDEQ     IPLN
017000970807     C                   ADD       1             RR2
017100970807     C                   MOVE      RPTRST        OTRST
017200970807     C                   MOVE      RPSUB         OSUB
017300970807     C                   MOVE      RPPLN         OPLN
017400970807     C                   MOVE      RPRID         ORID
017500970807     C                   WRITE     SF02
017600970807     C                   GOTO      #T0040
017700970807     C                   END
017800970807     C*
017900970807     C* DISPLAY SUBFILE IN WINDOW
018000970807     C*
018100970807     C     #T0050        TAG
018200970807     C     RR2           IFGT      0
018300970807     C                   MOVE      '1'           *IN80
018400970807     C                   END
018500970807     C                   MOVE      '1'           *IN81
018600970807     C*
018700970807     C                   WRITE     WINDOW2
018800970807     C                   EXFMT     SF02CTL
018900970807     C                   ENDSR
