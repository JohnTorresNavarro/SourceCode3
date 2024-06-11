0001009709020002  *---------------------------------------------------------------**
0002009909300003  * RPM120     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009709020005  *            WRITTEN BY - MARY FONTI       9/97                  *
0004009709020007  *           *BROKER YTD ACTIVITY WORK FILE BUILD                 *
0005009812070007  *                                                                *
0006009812070007  * DLW 12/98 CHANGED TO USE TO 8 BYTE DATES -Y2K COMPLAINT        *
0007009709020012  *---------------------------------------------------------------**
0008009709020014 FACCMST    IP   E             DISK
0009009709020018 FSMAN      IF   E           K DISK
0010009709020018 FMCOV      IF   E           K DISK
0011009709020018 FMEMAC#    IF   E           K DISK
0012009709020018 FPLNMST    IF   E           K DISK
0013009709020019 FRPM120WK  O  A E             DISK
001400970902     D*-----------------------------------------------------
0015009709020054 D                 DS
0016009812070055 D  LEFYMD                 1      8  0
0017009812070056 D  LEYY                   1      4  0
0018009812070057 D  LEMM                   5      6  0
0019009812070058 D  LEDD                   7      8  0
0020009709020044 D                 DS
0021009812090047 D  ANVYMD                 1      8  0
0022009812090045 D  ANVYY                  1      4  0
0023009812090046 D  ANVMM                  5      6  0
0024009812090046 D  ANVDD                  7      8  0
0025009709020059 D                UDS
0026009812090060 D  BUSYY                  7     10
0027009709020061 D  BUSMO                 11     12
0028009709020062 D  CONAME               201    240
0029009709020063 D  TIME                 242    247  0
003000970904     C*-----------------------------------------------------
003100970905     C*MEMBER KEY.
003200970905     C*----------
003300970904     C     ACKEY         KLIST
003400970904     C                   KFLD                    ACTRST
003500970904     C                   KFLD                    ACSUB#
003600970904     C                   KFLD                    ACACCT
003700970905     C*PLAN MASTER KEY.
003800970905     C*---------------
003900970904     C     PLNKEY        KLIST
004000970904     C                   KFLD                    MCTRST
004100970904     C                   KFLD                    MCSUB#
004200970904     C                   KFLD                    MCPLAN
004300970905     C* FIRST CYCLE PROCESS ONLY.
004400970905     C*-------------------------
004500970904     C     *IN99         IFEQ      '0'
004600970904     C                   MOVE      BUSYY         LEYY
004700970904     C                   MOVE      BUSMO         LEMM
004800970904     C                   MOVE      01            LEDD
004900981209     C                   MOVE      BUSYY         CURRYY            4 0
005000981209     C     CURRYY        SUB       1             PASTYY            4 0
005100970904     C                   MOVE      '1'           *IN99
005200970904     C                   END
0053009709020087 C* ACCT ENROLL/CANCEL DATE VERSUS EFFECTIVE DATE.
005400970905     C*----------------------------------------------
005500981209     C     LEFYMD        IFLT      ENROLL
005600970902     C                   GOTO      #END
005700970902     C                   END
0058009709020087 C*
005900970902     C     ATRMDT        IFNE      0
006000981209     C     LEFYMD        IFGE      ATRMDT
006100970902     C                   GOTO      #END
006200970902     C                   END
006300970902     C                   END
006400970905     C*INCLUDE CURRENT & PREVIOUS YEAR
006500970905     C*-------------------------------
006600981209     C                   MOVE      ENROLL        ANVYMD
006700970905     C*SELECT CURRENT AND PAST YEAR ONLY
006800970905     C*---------------------------------
006900981209     C     ANVYY         IFEQ      CURRYY
007000981209     C     ANVYY         OREQ      PASTYY
0071009709050087 C*GET BROKER NAME
007200970905     C*---------------
0073009709020088 C     SMANCD        CHAIN     SMAN                               61
007400970902     C                   MOVE      *BLANKS       BROKER           32
007500970902     C  N61SFNAME        CAT       SLNAME:1      BROKER
0076009709050087 C*MEMBER DATE CHECK
007700970905     C*-----------------
007800970902     C     ACKEY         SETLL     MEMAC#
007900970904     C     #LOOP         TAG
008000970904     C     *IN50         DOUEQ     '1'
008100970902     C     ACKEY         READE     MEMAC#                                 50
008200970904     C     *IN50         IFEQ      '0'
008300981209     C     LEFYMD        IFLT      MBENRL
008400970904     C                   GOTO      #LOOP
008500970902     C                   END
008600970902     C     TERMDT        IFNE      0
008700981209     C     LEFYMD        ANDGE     TERMDT
008800970904     C                   GOTO      #LOOP
008900970902     C                   END
009000970905     C*COV DATE CHECK.
009100970905     C*--------------
009200970902     C     MBSSNO        SETLL     MCOV
009300970904     C     #LOOP1        TAG
009400970904     C     *IN51         DOUEQ     '1'
009500970902     C     MBSSNO        READE     MCOV                                   51
009600970904     C     *IN51         IFEQ      '0'
009700981209     C     LEFYMD        IFLT      ENRLDT
009800970904     C                   GOTO      #LOOP1
009900970902     C                   END
010000970902     C     CANDT         IFNE      0
010100981209     C     LEFYMD        ANDGE     CANDT
010200970904     C                   GOTO      #LOOP1
010300970902     C                   END
010400970904     C*
010500970904     C* OUTPUT PROCESS.
010600970905     C*---------------
010700970904     C                   EXSR      OUTPUT
010800970905     C*COV
010900970904     C                   END
011000970904     C                   END
011100970905     C*MEMB
011200970904     C                   END
011300970904     C                   END
011400970905     C*CURR/PAST YY
011500970905     C                   END
011600970905     C*
011700970904     C     #END          TAG
0118009709040090 C*------------------------------------------------------
0119009709040090 C* WRITE WORK FILE RECORD ACCORDING TO PLAN.
012000970905     C*------------------------------------------
012100970904     C     OUTPUT        BEGSR
0122009709020088 C     PLNKEY        CHAIN     PLNMST                             60
012300970902     C     *IN60         IFEQ      *OFF
012400970902     C                   EXSR      #PLNCT
012500970903     C*
012600970905     C                   CLEAR                   RPMAN
012700970905     C                   CLEAR                   RPNAME
012800970905     C                   CLEAR                   RPTYPE
012900970905     C                   CLEAR                   RPPREM
013000970905     C                   CLEAR                   RPDATE
013100970909     C                   CLEAR                   RPTRM
013200970909     C                   CLEAR                   RPCAN
013300970903     C*
013400981209     C* MEDICAL. DENTAL. LIFE.
013500981209     C*-----------------------
013600970903     C     PLNTYP        IFEQ      'M'
013700981209     C     PLNTYP        OREQ      'D'
013800981209     C     PLNTYP        OREQ      'L'
013900970902     C                   MOVE      SMANCD        RPMAN
014000970902     C                   MOVE      BROKER        RPNAME
014100970902     C                   MOVE      PLNTYP        RPTYPE
014200970904     C                   MOVE      LPREM         RPPREM
014300981209     C                   MOVE      ENROLL        RPDATE
014400981209     C                   MOVE      ATRMDT        RPTRM
014500981209     C                   MOVE      CANDT         RPCAN
014600970904     C                   WRITE     RP120R
014700970903     C                   GOTO      EXIT
014800970902     C                   END
014900970902     C*
015000970903     C     EXIT          TAG
0151009709030090 C*
015200970902     C                   END
015300970903     C*
015400970904     C                   ENDSR
015500970902     C*-----------------------------------------------------
015600970904     C* DETERMINE TYPE OF PLAN.
015700970905     C*-----------------------
015800970902     C     #PLNCT        BEGSR
015900970902     C                   MOVE      ' '           PLNTYP            1
016000970902     C* MEDICAL
016100970902     C     PLNCAT        IFEQ      'PMM'
016200970902     C     PLNCAT        OREQ      'PCM'
016300970902     C     PLNCAT        OREQ      'PMS'
016400970902     C                   MOVE      'M'           PLNTYP
016500970902     C                   END
016600970902     C* DENTAL
016700970902     C     PLNCAT        IFEQ      'PDN'
016800970902     C     PLNCAT        OREQ      'PCD'
016900970902     C                   MOVE      'D'           PLNTYP
017000970902     C                   END
017100970902     C* LIFE/DIS
017200970902     C     PLNCAT        IFEQ      'PLF'
017300970902     C     PLNCAT        OREQ      'PDL'
017400970902     C     PLNCAT        OREQ      'PLT'
017500970902     C     PLNCAT        OREQ      'PSL'
017600970902     C     PLNCAT        OREQ      'PWD'
017700970902     C     PLNCAT        OREQ      'PWS'
017800970902     C                   MOVE      'L'           PLNTYP
017900970902     C                   END
018000970903     C*
018100970903     C                   MOVE      *BLANKS       RPMAN
018200970903     C                   MOVE      *BLANKS       RPNAME
018300970903     C                   MOVE      *BLANKS       RPTYPE
018400970903     C                   Z-ADD     0             RPPREM
018500970903     C                   Z-ADD     0             RPDATE
018600970903     C*
018700970902     C                   ENDSR
0188009709020107 O*
