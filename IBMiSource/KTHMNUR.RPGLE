000100101025     FKTHMNUD   CF   E             WORKSTN SFILE(SCN01B:RRN) INFDS(DFINF)
000200101025     FKTHMNUP   IF   E           K DISK
000300020522   X***X
000400020523     D H@CMD           S                   LIKE(CMD)
000500020522     D CM              S            100A   DIM(100)                             PREVIOUS CMD'S
000600020522     D CMD1            S            155A
000700020522     D CW              S              1A   DIM(100)                             WORK ARRAY
000800020522     D DSPRSV          S              4S 0
000900020522     D LENGTH          S             15P 5
001000020522     D MEN             S             10A   DIM(100)                             PREVIOUS MENUS
001100020522     D RRN             S              3P 0
001200020522     D SVNAME          S                   LIKE(GMMENU)
001300020522     D SVTITL          S                   LIKE(GMTITLE)
001400020522     D WRK5            S              5A
001500020522     D X               S              2S 0
001600020522     D X1              S              2S 0
001700020522     D Y               S              2S 0
001800020522     D #LEN            S              3P 0
001900020522    ***
002000020522     D DFINF           DS
002100020522     D  FKEY                 369    369A
002200020522     D  FROP#                378    379B 0
002300020522    ***
002400020522     D DATA01          DS
002500020522     D  OPT                    1      2S 0
002600020522     D  OPT1                   1      1A
002700020522     D  OPT2                   2      2A
002800020522     D  OPTA                   1      2A
002900020522    ***
003000020522     D  F1             C                   CONST(X'31')
003100020522     D  F2             C                   CONST(X'32')
003200020522     D  F3             C                   CONST(X'33')
003300020522     D  F4             C                   CONST(X'34')
003400020522     D  F5             C                   CONST(X'35')
003500020522     D  F6             C                   CONST(X'36')
003600020522     D  F7             C                   CONST(X'37')
003700020522     D  F8             C                   CONST(X'38')
003800020522     D  F9             C                   CONST(X'39')
003900020522     D  F10            C                   CONST(X'3A')
004000020522     D  F11            C                   CONST(X'3B')
004100020522     D  F12            C                   CONST(X'3C')
004200020522     D  F13            C                   CONST(X'B1')
004300020522     D  F14            C                   CONST(X'B2')
004400020522     D  F15            C                   CONST(X'B3')
004500020522     D  F16            C                   CONST(X'B4')
004600020522     D  F17            C                   CONST(X'B5')
004700020522     D  F18            C                   CONST(X'B6')
004800020522     D  F19            C                   CONST(X'B7')
004900020522     D  F20            C                   CONST(X'B8')
005000020522     D  F21            C                   CONST(X'B9')
005100020522     D  F22            C                   CONST(X'BA')
005200020522     D  F23            C                   CONST(X'BB')
005300020522     D  F24            C                   CONST(X'BC')
005400020522    ***
005500020522   X***X
005600020522     C                   EXSR      FILSBF                                       SETUPSUBFIL
005700020522    ***
005800020522     C                   EVAL      *IN21 = *ON                                  DSPCTL
005900020522    ***
006000020522     C                   WRITE     SCN01C                                       FUNCT KEYS
006100020522     C                   EXFMT     SCN01A                                       SHOWSCREEN
006200020522    ***
006300020522     C                   DOW       FKEY  <> F3
006400020522    ***
006500020522     C                   EXSR      $SCREENCTL
006600020522    ***
006700020522     C                   ENDDO
006800020522    ***
006900020522     C                   EVAL      *INLR = *ON
007000020522   S***S
007100020522     C     *INZSR        BEGSR
007200020522    ***
007300020522     C     *ENTRY        PLIST
007400020522     C                   PARM                    GMMENU                         FIRST MENU
007500020522    ***
007600020522     C                   IF        GMMENU = *BLANKS
007700020522     C                   EVAL      GMMENU = 'MAIN'
007800020522     C                   ENDIF
007900020522    ***
008000020522     C                   Z-ADD     1             X                              RETRIEVE IDX
008100020522     C                   Z-ADD     1             X1                             RETRIEVE IDX
008200020522     C                   Z-ADD     1             Y                              MENU INDEX
008300020522     C                   MOVEL     '*'           PGMQ                           PGM QUEUE
008400020522    ***
008500020522     C     KEY#GM        KLIST
008600020522     C                   KFLD                    GMMENU
008700020522     C                   KFLD                    GMSEQ#
008800020522    ***
008900020522     C                   ENDSR
009000020522   S***S
009100020522     C     FILSBF        BEGSR                                                  *?
009200020522    ***
009300020522     C                   Z-ADD     0             #READS            6 0
009400020522     C                   Z-ADD     0             RRN
009500020522     C                   Z-ADD     1             DSPREC
009600020522     C                   EVAL      *IN21 = *OFF                                 SFLCLR
009700020522     C                   WRITE     SCN01A
009800020523     C                   EVAL      XXMENU = GMMENU
009900020522    ***
010000101025     C     GMMENU        SETLL     KTHMNUR
010100020522     C                   Z-ADD     0             RRN
010200020522    ***
010300101025    1C                   DOW       RRN < 100 AND NOT %EOF(KTHMNUP)
010400020522    ***
010500020522     C                   ADD       1             RRN
010600020522    ***
010700101025     C     GMMENU        READE     KTHMNUR
010800020522    ***
010900101025    2C                   IF        %EOF(KTHMNUP) AND RRN = 1
011000020522     C                   MOVE      *ON           *IN03                          ENDPROGRAM
011100020522    2C                   ELSE
011200020522     C*
011300020522     C                   ADD       1             #READS
011400020522    3C                   IF        #READS = 1
011500020523     C                   EVAL      XXTITLE = GMTITLE
011600020522     C                   MOVE      GMTITLE       SVTITL
011700020522     C                   MOVEL     GMMENU        SVNAME
011800020522    3C                   ENDIF
011900020522    2C                   ENDIF
012000020522    ***
012100020717    2C                   IF        #READS = 1
012200020522     C                   EVAL      GMOPTXT = 'SELECT ONE OF THE FOLLOWING OPTIO+
012300020522     C                             NS BELOW'
012400020522    2C                   ENDIF
012500020522    ***
012600101025    2C                   IF        NOT %EOF(KTHMNUP)
012700020522     C                   WRITE     SCN01B                                       WRITE SUBFL
012800020522    2C                   ENDIF
012900020522    ***
013000020522    1C                   ENDDO
013100020522    ***
013200020522     C                   MOVE      SVTITL        GMTITLE                         RESTORETITL
013300020522     C                   MOVEL     SVNAME        GMMENU                          RESTORENAME
013400020522    ***
013500020522     C                   ENDSR
013600020522   S***S
013700020522     C     $SCREENCTL    BEGSR
013800020522    ***
013900020522     C                   READ      SCN01C                                 99    READ COMMAND
014000020522    ***
014100020522     C                   Z-ADD     FROP#         DSPRSV
014200020522    ***
014300020522     C                   SELECT
014400020522    1C                   WHEN      FKEY = F5
014500020522     C                   EXSR      $F5PROC
014600020522    1C                   WHEN      FKEY = F9
014700020522     C                   EXSR      $F9PROC
014800020522    1C                   WHEN      FKEY = F12
014900020522     C                   EXSR      $F12PROC
015000020522    1C                   OTHER
015100020522     C                   EXSR      $CHK4OPT
015200020522    1C                   ENDSL
015300020522    ***
015400020522     C                   EVAL      *IN21 = *ON                                  SFLDSPCTL
015500020522     C                   Z-ADD     DSPRSV        DSPREC
015600020522     C                   WRITE     SCN01C
015700020522     C                   EXFMT     SCN01A
015800020522    ***
015900020522     C                   CLEAR                   CMD
016000020522     C                   MOVEL     'RMVMSG'      CMD
016100020522     C                   EXSR      $EXECMD
016200020522    ***
016300020522     C                   ENDSR
016400020522   S***S
016500020522     C     $F5PROC       BEGSR
016600020522    ***
016700020522     C                   EXSR      FILSBF
016800020522    ***
016900020522     C                   ENDSR
017000020522   S***S
017100020522     C     $F9PROC       BEGSR
017200020522    ***
017300020522    1C                   IF        X1 > 1
017400020522     C                   SUB       1             X1
017500020522    1C                   ENDIF
017600020522     C*
017700020522     C                   MOVEL     CM(X1)        CMD
017800020522    ***
017900020522     C                   ENDSR
018000020522   S***S
018100020522     C     $F12PROC      BEGSR
018200020522    ***
018300020522    1C                   IF        Y > 1                                        NOT 1ST MENU
018400020522     C                   SUB       1             Y
018500020522     C                   MOVEL     MEN(Y)        GMMENU
018600020717     C                   Z-ADD     1             DSPRSV
018700020522     C                   EXSR      FILSBF
018800020522    1C                   END
018900020522    ***
019000020522     C                   ENDSR
019100020522   S***S
019200020522     C     $CHK4OPT      BEGSR
019300020522    ***
019400020522     C                   MOVEL     CMD           WRK5
019500020522     C                   MOVEL     CMD           OPTA
019600020522    ***
019700020522    1C                   IF        OPT1 > '0' AND OPT2 = ' '
019800020522     C                   MOVEL     OPT1          OPT2                           RIGHT ADJUST
019900020522     C                   MOVEL     '0'           OPT1
020000020522    1C                   END
020100020522    ***
020200020522     C                   TESTN                   OPTA                 50
020300020522     C*
020400020522    1C                   IF        *IN50 = *ON OR WRK5 = 'MENU '
020500020522     C*
020600020522    2C                   IF        WRK5 = 'MENU '
020700020522     C                   MOVEA     CMD           CW
020800020522     C                   MOVE      *BLANKS       CMD
020900020522     C                   MOVEA     CW(6)         GMMENU
021000020522     C                   MOVE      '01'          OPT
021100020522    2C                   ENDIF
021200020522     C*
021300020522     C                   EXSR      MENU#                                        GET OPT# REC
021400020522     C                   MOVEL     *BLANKS       CMD                             COMMAND LN
021500020522     C                   LEAVESR
021600020522    1C                   ENDIF
021700020522    ***
021800020522    1C                   IF        CMD > *BLANKS
021900020522     C                   MOVEL     CMD           CM(X)
022000020522     C                   ADD       1             X
022100020522     C                   Z-ADD     X             X1
022200020522    1C                   END
022300020522    ***
022400020522    1C                   IF        FKEY = F4                                    PROMPT
022500020522     C                   EVAL      CMD1 = '?' + %TRIM(CMD)                      LEN=155
022600020522     C                   MOVEL(P)  CMD1          CMD
022700020522    1C                   END
022800020522    ***
022900020522     C                   EXSR      $EXECMD
023000020522    ***
023100020522     C                   ENDSR
023200020522   S***S
023300020522     C     $EXECMD       BEGSR
023400020522    ***
023500020522     C                   EVAL      #LEN = %LEN(%TRIM(CMD))
023600020522     C                   Z-ADD     #LEN          LENGTH
023700020522     C                   CALL      'MENUECL'                                    EXECUTE
023800020522     C                   PARM                    CMD
023900020522     C                   PARM                    LENGTH
024000020522     C                   MOVEL     *BLANKS       CMD                             COMMAND LN
024100020522    ***
024200020522     C                   ENDSR
024300020522   S***S
024400020522     C     MENU#         BEGSR
024500020522    ***
024600020522     C                   Z-ADD     1             DSPREC
024700020522     C                   EVAL      GMSEQ# = OPT * 10
024800020522     C*                  MOVEL     OPT           GMSEQ#
024900020522    ***
025000020522    1C                   IF        GMSEQ# = 900                                  SIGNOFF CMD
025100020522     C                   EVAL      *IN03 = *ON
025200020522     C                   EVAL      FKEY = F3
025300020522     C                   MOVEL(P)  'SIGNOFF'     CMD
025400020522     C                   EXSR      $EXECMD
025500020522     C                   MOVE      SVTITL        GMTITLE
025600020522     C                   MOVEL     SVNAME        GMMENU
025700020522     C                   LEAVESR
025800020522    1C                   ENDIF
025900020522    ***
026000020522     C                   MOVEL     GMMENU        @@MENU           10
026100101025     C     KEY#GM        CHAIN     KTHMNUR
026200101025     C                   IF        NOT %FOUND(KTHMNUP)
026300090327     C                   LEAVESR
026400090327     C                   ENDIF
026500090327    ***
026600020522    1C                   IF        GMTYPE = 'M'
026700020522     C                   MOVEL     @@MENU        MEN(Y)
026800020522     C                   ADD       1             Y
026900020522     C                   MOVEL     GMCMD         GMMENU
027000020522     C                   Z-ADD     1             DSPRSV
027100020522     C                   EXSR      FILSBF
027200020522     C                   MOVE      SVTITL        GMTITLE
027300020522     C                   MOVEL     SVNAME        GMMENU
027400020522     C                   LEAVESR
027500020522    1C                   ENDIF
027600020522    ***
027700020523    1C                   IF        GMTYPE = 'C' OR GMTYPE = 'A'
027800020523    1C                   IF        GMCMD <> *BLANKS                             COMMAND
027900020523     C                   EVAL      H@CMD = CMD
028000020523     C                   EVAL      CMD = GMCMD
028100020522     C                   EXSR      $EXECMD
028200020523     C                   EVAL      CMD = H@CMD
028300020522     C                   LEAVESR
028400020522    1C                   ENDIF
028500020522    1C                   ENDIF
028600020522    ***
028700020522     C                   MOVE      SVTITL        GMTITLE
028800020522     C                   MOVEL     SVNAME        GMMENU
028900020522    ***
029000020522     C                   ENDSR
