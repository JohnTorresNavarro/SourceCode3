000100900330     FMENUSDF   CF   E             WORKSTN
000200891108     F                                     SFILE(SCN01B:RRN)
000300900402     F                                     INFDS(DFINF)
000400900330     FMENUSPF   IF   E           K DISK
000500900108     D CM              S            100    DIM(100)                             PREVIOUS CMD'S
000600900403     D CW              S              1    DIM(100)                             WORK ARRAY
000700900108     D MEN             S             10    DIM(100)                             PREVIOUS MENUS
000800900402     D DFINF           DS
000900900402     D  FROP#                378    379B 0
001000891117     D DATA01          DS
001100891117     D  OPT                    1      2
001200891117     D  OPT1                   1      1
001300891117     D  OPT2                   2      2
001400900108     C                   Z-ADD     1             X                 2 0          RETRIEVE IDX
001500900403     C                   Z-ADD     1             X1                2 0          RETRIEVE IDX
001600900108     C                   Z-ADD     1             Y                 2 0          MENU INDEX
001700900815     C                   MOVEL     '*'           PGMQ                           PGM QUEUE
001800891108     C     *ENTRY        PLIST
001900900108     C                   PARM                    MNNAME           10            FIRST MENU
002000900108     C     MENU          KLIST
002100900108     C                   KFLD                    MNNAME
002200900108     C                   KFLD                    MNOPT#
002300900402     C                   EXSR      FILSBF                                       SETUPSUBFIL
002400900402     C                   SETON                                        21        DSPCTL
002500900402     C                   WRITE     SCN01C                                       FUNCT KEYS
002600900402     C                   EXFMT     SCN01A                                       SHOWSCREEN
002700900404      *
002800900330     C     *IN03         DOWEQ     '0'
002900900402     C                   READ      SCN01C                                 99    READ COMMAND
003000900403     C                   Z-ADD     FROP#         DSPRSV            4 0
003100900330     C     *INKI         IFEQ      '1'
003200900403     C     X1            IFGT      1                                            NOT 1ST REC
003300900403     C                   SUB       1             X1
003400900403     C                   END
003500900403     C                   MOVEL     CM(X1)        CMD
003600900223     C                   ELSE
003700900330     C     *INKE         IFEQ      '1'                                          F5=REFRESH
003800900223     C                   EXSR      FILSBF
003900900223     C                   ELSE
004000900330     C     *INKL         IFEQ      '1'                                          F12=PREVIOUS
004100900108     C     Y             IFGT      1                                            NOT 1ST MENU
004200900108     C                   SUB       1             Y
004300891207     C                   MOVEL     MEN(Y)        MNNAME
004400900223     C                   EXSR      FILSBF
004500891120     C                   END
004600900223     C                   ELSE
004700900403     C                   MOVEL     CMD           WRK5              5
004800900402     C                   MOVEL     CMD           OPT
004900900402     C     OPT1          IFGT      '0'
005000900402     C     OPT2          ANDEQ     ' '
005100900402     C                   MOVEL     OPT1          OPT2                           RIGHT ADJUST
005200900402     C                   MOVEL     '0'           OPT1
005300900402     C                   END
005400900402     C                   TESTN                   OPT                  50
005500900402     C     *IN50         IFEQ      '1'                                          NUMERIC=Y
005600900403     C     WRK5          OREQ      'MENU '
005700900403     C     WRK5          IFEQ      'MENU '
005800900403     C                   MOVEA     CMD           CW
005900900403     C                   MOVE      *BLANKS       CMD
006000900403     C                   MOVEA     CW(6)         MNNAME
006100900403     C                   MOVE      '01'          OPT
006200900403     C                   END
006300900223     C                   EXSR      MENU#                                        GET OPT# REC
006400900403     C                   MOVEL     *BLANKS       CMD                             COMMAND LN
006500900223     C                   ELSE
006600900403     C     CMD           IFGT      *BLANKS
006700900402     C                   MOVEL     CMD           CM(X)
006800900402     C                   ADD       1             X
006900900403     C                   Z-ADD     X             X1                2 0
007000900403     C                   END
007100891120     C                   Z-ADD     154           LENGTH           15 5          LEN COMMAND
007200900402     C     *INKD         IFEQ      '1'                                          PROMPT
007300891120     C                   MOVE      CMD           CMD1            155            LEN=155
007400891117     C                   MOVEL     '?'           CMD1
007500891120     C                   MOVEL     *BLANKS       CMD
007600891120     C                   MOVEL     CMD1          CMD
007700900223     C                   END
007800900402     C                   CALL      'MENUECL'                                    EXECUTE
007900891120     C                   PARM                    CMD
008000891117     C                   PARM                    LENGTH
008100900403     C                   MOVEL     *BLANKS       CMD                             COMMAND LN
008200900223     C                   END
008300900223     C                   END
008400900223     C                   END
008500900223     C                   END
008600900402     C     *IN03         IFEQ      '0'
008700900402     C                   SETON                                        21        SFLDSPCTL
008800900403     C                   Z-ADD     DSPRSV        DSPREC
008900900223     C                   WRITE     SCN01C
009000900402     C                   EXFMT     SCN01A
009100900815     C                   MOVE      *BLANKS       CMD
009200900815     C                   MOVEL     'RMVMSG'      CMD
009300900815     C                   CALL      'MENUECL'
009400900815     C                   PARM                    CMD
009500900815     C                   PARM                    LENGTH
009600900223     C                   END
009700900402     C                   END
009800900404      *
009900900402     C                   SETON                                        LR
010000900330     C******************************************************?
010100900330     C     MENU#         BEGSR                                                  *?
010200900330     C******************************************************?
010300900403     C                   Z-ADD     1             DSPREC
010400891117     C                   MOVEL     OPT           MNOPT#
010500900108     C     MNOPT#        IFEQ      90                                            SIGNOFF CMD
010600900330     C                   SETON                                        03
010700900402     C                   Z-ADD     7             LENGTH
010800900402     C                   MOVEL     *BLANKS       CMD
010900900402     C                   MOVEL     'SIGNOFF'     CMD
011000900402     C                   CALL      'MENUECL'                                    EXECUTE
011100900402     C                   PARM                    CMD
011200900402     C                   PARM                    LENGTH
011300900223     C                   ELSE
011400900108     C     MENU          CHAIN     MENUS                              99
011500900403     C     WRK5          IFEQ      'MENU '
011600900403     C                   MOVEL     MNNAME        MNNEW
011700900403     C                   END
011800891120     C     MNNEW         IFNE      *BLANKS
011900891207     C                   MOVEL     MNNAME        MEN(Y)
012000891207     C                   ADD       1             Y
012100891120     C                   MOVEL     MNNEW         MNNAME
012200900815     C                   Z-ADD     1             DSPRSV
012300900223     C                   EXSR      FILSBF
012400900223     C                   ELSE
012500891117     C     MNCMD         IFNE      *BLANKS                                      COMMAND
012600900108     C                   Z-ADD     80            LENGTH           15 5
012700900330     C                   CALL      'MENUECL'
012800891117     C                   PARM                    MNCMD
012900891117     C                   PARM                    LENGTH
013000900223     C                   ELSE
013100891117     C     MNPGM         IFNE      *BLANKS
013200891117     C                   CALL      MNPGM
013300891117     C                   END
013400900223     C                   END
013500900223     C                   END
013600900223     C                   END
013700900223     C                   MOVEL     SVTITL        MNTITL
013800900223     C                   MOVEL     SVNAME        MNNAME
013900900223     C                   ENDSR
014000900402     C******************************************************?
014100900402     C     FILSBF        BEGSR                                                  *?
014200900402     C******************************************************?
014300900223     C                   Z-ADD     0             RRN               3 0
014400900403     C                   Z-ADD     1             DSPREC
014500900402     C                   SETOFF                                       21        SFLCLR
014600900223     C                   WRITE     SCN01A
014700900223     C     *LIKE         DEFINE    MNTITL        SVTITL                         SAVETITLE
014800900223     C     *LIKE         DEFINE    MNNAME        SVNAME                         SAVENAME
014900900223     C     MNNAME        SETLL     MENUS
015000900223     C                   Z-ADD     0             RRN
015100900223     C     RRN           DOWLT     100
015200900330     C     *IN99         ANDEQ     '0'
015300900223     C                   ADD       1             RRN
015400900223     C     MNNAME        READE     MENUS                                  99
015500900330     C     *IN99         IFEQ      '1'
015600900223     C     RRN           ANDEQ     1
015700900330     C                   MOVE      '1'           *IN03                          ENDPROGRAM
015800900223     C                   ELSE
015900900223     C     RRN           IFEQ      1
016000900223     C                   MOVEL     MNTITL        SVTITL
016100900223     C                   MOVEL     MNNAME        SVNAME
016200900223     C                   END
016300900223     C                   END
016400900402     C     *IN99         IFEQ      '0'
016500900402     C                   WRITE     SCN01B                                       WRITE SUBFL
016600900402     C                   END
016700900223     C                   END
016800900223     C                   MOVEL     SVTITL        MNTITL                          RESTORETITL
016900900223     C                   MOVEL     SVNAME        MNNAME                          RESTORENAME
017000900223     C                   ENDSR
