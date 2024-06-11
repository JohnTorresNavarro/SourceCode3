0001009602140002 F******************************************************************
0002009909300003 F* FM340      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009602140004 F*                                                                *
0004009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009708080006 F*            DATE -  8/08/97                                     *
0006009602140007 F*                                                                *
0007009708080008 F*  DESCRIPTION - FILE MAINT FOR SPECIALTY MASTER FILE            *
0008009602140012 F*                                                                *
0009009602140013 F******************************************************************
001000970808     FFM340D    CF   E             WORKSTN
001100961031     F                                     SFILE(SF01:RRN)
001200970808     FSPCMST    UF A E           K DISK
0013009708070124 D                UDS
0014009708070054 D  CONAME               201    240
001500921015     C*
001600960208     C* WRITE FIRST SCREEN
001700960208     C*
001800960206     C     #T0010        TAG
001900970808     C                   MOVE      *BLANKS       ISPC
002000961111     C     #T0015        TAG
002100961030     C                   EXFMT     SCRN01
002200921013     C*
002300960208     C* CMD7 END
002400960208     C*
002500960208     C     *INKG         CABEQ     '1'           #END
002600961111     C*
002700970808     C* CMD4 - DSPLAY SPECIALTY CODES IN WINDOW
002800961111     C*
002900961111     C     *INKD         IFEQ      '1'
003000970808     C                   EXSR      #DSPSP
003100961111     C                   GOTO      #T0015
003200961111     C                   END
003300970808     C*
003400970808     C     ISPC          CABEQ     '     '       #T0015
003500970808     C*
003600970808     C     ISPC          CHAIN     SPCMST                             31
003700970806     C     *IN31         IFEQ      *ON
003800970808     C                   MOVE      ISPC          SPCODE
003900970808     C                   MOVE      *BLANKS       SPDESC
004000970808     C                   MOVE      *BLANKS       SPSEX
004100970808     C                   MOVE      *BLANKS       SPEDT1
004200970808     C                   MOVE      *BLANKS       SPEDT2
004300970808     C                   MOVE      *BLANKS       SPEDT3
004400970808     C                   MOVE      *BLANKS       SPEDT4
004500970806     C                   END
004600961030     C                   EXSR      #UP
004700960208     C*
004800960219     C                   GOTO      #T0010
004900960208     C*
005000960208     C     #END          TAG
005100960208     C                   MOVE      '1'           *INLR
005200961031     C*******************
005300961031     C* UPDATE RECORDS  *
005400961031     C*******************
005500961030     C     #UP           BEGSR
005600960208     C*
005700970808     C                   MOVE      '0'           *IN40
005800970806     C     #T0018        TAG
005900970806     C                   EXFMT     SCRN02
006000970806     C     *INKA         CABEQ     '1'           #T0010
006100970808     C*
006200970808     C* EDIT FIELD
006300970808     C*
006400970808     C     SPSEX         IFEQ      ' '
006500970808     C                   MOVE      '1'           *IN40
006600970808     C                   GOTO      #T0018
006700970808     C                   END
006800970806     C*
006900970808     C   31              WRITE     SPCMSR
007000970808     C  N31              UPDATE    SPCMSR
007100970806     C*
007200961031     C                   ENDSR
007300961031     C************************************
007400970806     C* DISPLAY RIDERS IN SUBFILE WINDOW *
007500961031     C************************************
007600970808     C     #DSPSP        BEGSR
007700961031     C*
007800961031     C* CLEAR SUBFILE
007900961031     C*
008000961031     C                   MOVEA     '001'         *IN(90)
008100961031     C                   WRITE     SF01CTL
008200961031     C                   MOVE      '0'           *IN92
008300961031     C*
008400970806     C* BUILD SUBFILE - LOAD ALL
008500961031     C*
008600961031     C                   MOVE      *ZEROS        RRN               5 0
008700970808     C     *LOVAL        SETLL     SPCMST
008800961031     C     #T0020        TAG
008900970808     C                   READ      SPCMST                                 91
009000961031     C     *IN91         IFEQ      '0'
009100961031     C                   ADD       1             RRN
009200970808     C                   MOVE      SPCODE        OCODE
009300970808     C                   MOVEL     SPDESC        ODESC
009400961031     C                   WRITE     SF01
009500961031     C                   GOTO      #T0020
009600961031     C                   END
009700961031     C*
009800961031     C* DISPLAY SUBFILE IN WINDOW
009900961031     C*
010000961031     C     #T0030        TAG
010100961031     C     RRN           IFGT      0
010200961031     C                   MOVE      '1'           *IN90
010300961031     C                   END
010400961031     C*
010500961031     C                   WRITE     WINDOW
010600961031     C                   EXFMT     SF01CTL
010700961031     C                   ENDSR
