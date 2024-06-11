0001009602140002 F******************************************************************
0002009909300003 F* FM310      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009602140004 F*                                                                *
0004009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009708060006 F*            DATE -  8/06/97                                     *
0006009602140007 F*                                                                *
0007009708060008 F*  DESCRIPTION - FILE MAINT FOR RIDER MASTER                     *
0008009602140012 F*                                                                *
0009009602140013 F******************************************************************
001000970806     FFM310D    CF   E             WORKSTN
001100961031     F                                     SFILE(SF01:RRN)
001200970806     FRIDMST    UF A E           K DISK
001300970806     FCARMST    IF   E           K DISK
0014009708070124 D                UDS
0015009708070054 D  CONAME               201    240
001600970806     C     RKEY          KLIST
001700970806     C                   KFLD                    ICARR
001800970806     C                   KFLD                    ICODE
001900921015     C*
002000960208     C* WRITE FIRST SCREEN
002100960208     C*
002200960206     C     #T0010        TAG
002300970806     C                   MOVE      *BLANKS       ICARR
002400970806     C                   MOVE      *BLANKS       ICODE
002500961111     C     #T0015        TAG
002600961030     C                   EXFMT     SCRN01
002700921013     C*
002800960208     C* CMD7 END
002900960208     C*
003000960208     C     *INKG         CABEQ     '1'           #END
003100961111     C*
003200970806     C* CMD4 - DSPLAY RIDERS IN WINDOW
003300961111     C*
003400961111     C     *INKD         IFEQ      '1'
003500970806     C                   EXSR      #DSPRI
003600961111     C                   GOTO      #T0015
003700961111     C                   END
003800921013     C*
003900970806     C* EDIT CARRIER
004000960208     C*
004100970806     C     ICARR         CHAIN     CARMST                             30
004200970806     C   30              GOTO      #T0015
004300970808     C*
004400970808     C     ICODE         IFEQ      *BLANKS
004500970808     C                   GOTO      #T0015
004600970808     C                   END
004700970808     C*
004800970806     C     RKEY          CHAIN     RIDMST                             31
004900970806     C     *IN31         IFEQ      *ON
005000970806     C                   MOVE      ICARR         RCARR
005100970806     C                   MOVE      ICODE         RCODE
005200970806     C                   MOVE      *BLANKS       RDESC
005300970806     C                   MOVE      *BLANKS       RTYPE
005400970806     C                   MOVE      *BLANKS       REFFDT
005500970806     C                   MOVE      *BLANKS       RCANDT
005600970806     C                   END
005700961030     C                   EXSR      #UP
005800960208     C*
005900960219     C                   GOTO      #T0010
006000960208     C*
006100960208     C     #END          TAG
006200960208     C                   MOVE      '1'           *INLR
006300961031     C*******************
006400961031     C* UPDATE RECORDS  *
006500961031     C*******************
006600961030     C     #UP           BEGSR
006700960208     C*
006800970806     C                   MOVEA     '000'         *IN(40)
006900970806     C     #T0018        TAG
007000970806     C                   EXFMT     SCRN02
007100970806     C     *INKA         CABEQ     '1'           #T0010
007200961030     C*
007300970806     C* EDIT FIELDS
007400970806     C*
007500970806     C     RTYPE         IFEQ      '   '
007600970806     C                   MOVE      '1'           *IN42
007700970806     C                   GOTO      #T0018
007800970806     C                   END
007900970806     C*
008000970806     C     REFFDT        IFLT      19970101
008100970806     C                   MOVE      '1'           *IN40
008200970806     C                   GOTO      #T0018
008300970806     C                   END
008400960208     C*
008500970806     C     RCANDT        IFNE      0
008600970806     C     RCANDT        ANDLT     19970101
008700970806     C                   MOVE      '1'           *IN41
008800970806     C                   GOTO      #T0018
008900970806     C                   END
009000970806     C*
009100970806     C     RCANDT        IFNE      0
009200970806     C     RCANDT        ANDLT     REFFDT
009300970806     C                   MOVE      '1'           *IN41
009400970806     C                   GOTO      #T0018
009500970806     C                   END
009600970806     C*
009700970806     C   31              WRITE     RIDMSR
009800970806     C  N31              UPDATE    RIDMSR
009900970806     C*
010000961031     C                   ENDSR
010100961031     C************************************
010200970806     C* DISPLAY RIDERS IN SUBFILE WINDOW *
010300961031     C************************************
010400970806     C     #DSPRI        BEGSR
010500961031     C*
010600961031     C* CLEAR SUBFILE
010700961031     C*
010800961031     C                   MOVEA     '001'         *IN(90)
010900961031     C                   WRITE     SF01CTL
011000961031     C                   MOVE      '0'           *IN92
011100961031     C*
011200970806     C* BUILD SUBFILE - LOAD ALL
011300961031     C*
011400961031     C                   MOVE      *ZEROS        RRN               5 0
011500970806     C     *LOVAL        SETLL     RIDMST
011600961031     C     #T0020        TAG
011700970806     C                   READ      RIDMST                                 91
011800961031     C     *IN91         IFEQ      '0'
011900961031     C                   ADD       1             RRN
012000970806     C                   MOVE      RCARR         OCARR
012100970806     C                   MOVE      RCODE         ORIDER
012200970806     C                   MOVEL     RDESC         ODESC
012300961031     C                   WRITE     SF01
012400961031     C                   GOTO      #T0020
012500961031     C                   END
012600961031     C*
012700961031     C* DISPLAY SUBFILE IN WINDOW
012800961031     C*
012900961031     C     #T0030        TAG
013000961031     C     RRN           IFGT      0
013100961031     C                   MOVE      '1'           *IN90
013200961031     C                   END
013300961031     C*
013400961031     C                   WRITE     WINDOW
013500961031     C                   EXFMT     SF01CTL
013600961031     C                   ENDSR
