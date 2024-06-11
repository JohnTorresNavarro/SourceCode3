000100991124     F*-------------------------------------------------------------------------
000200081111     F* FM014      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300081111     F*            WRITTEN BY - RLJ
000400081111     F*            DATE - 11/08
000500081111     F*  DESCRIPTION - DISPLAY AVAILABLE PLAN#'S
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800991124     F*    25 = SFLDSP
000900991124     F*    26 = SFL DSP CTL
001000991124     F*    27 = SFL CLR
001100991124     F*
001200991124     F*-------------------------------------------------------------------------
001300991209     ** MODIFICATION HISTORY                                              **
001400090202     ** RLJ  UUU  02022009  Do not use the letter F in plan names         **
001500991209     **                                                                   **
001600991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001700001207     FPLNMST    IF   E           K DISK
001800081111     FFM014D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
001900991124   X***X
002000991216     D WSDS            DS
002100991216     D  FKEY                 369    369A
002200991216    ***
002300991216     D  F1             C                   CONST(X'31')
002400991216     D  F2             C                   CONST(X'32')
002500991216     D  F3             C                   CONST(X'33')
002600991216     D  F4             C                   CONST(X'34')
002700991216     D  F5             C                   CONST(X'35')
002800991216     D  F6             C                   CONST(X'36')
002900991216     D  F7             C                   CONST(X'37')
003000991216     D  F8             C                   CONST(X'38')
003100991216     D  F9             C                   CONST(X'39')
003200991216     D  F10            C                   CONST(X'3A')
003300991216     D  F11            C                   CONST(X'3B')
003400991216     D  F12            C                   CONST(X'3C')
003500991216     D  F13            C                   CONST(X'B1')
003600991216     D  F14            C                   CONST(X'B2')
003700991216     D  F15            C                   CONST(X'B3')
003800991216     D  F16            C                   CONST(X'B4')
003900991216     D  F17            C                   CONST(X'B5')
004000991216     D  F18            C                   CONST(X'B6')
004100991216     D  F19            C                   CONST(X'B7')
004200991216     D  F20            C                   CONST(X'B8')
004300991216     D  F21            C                   CONST(X'B9')
004400991216     D  F22            C                   CONST(X'BA')
004500991216     D  F23            C                   CONST(X'BB')
004600991216     D  F24            C                   CONST(X'BC')
004700001207    ***
004800010918     D @K5             S              4A
004900010918    ***
005000001207     D                 DS
005100001207     D @KEYPRM                 1     10A
005200001207     D #KT                     1      3S 0
005300001207     D #KS                     4      6S 0
005400081111     D #KP                     7     10A
005500081111      *
005600081111     D                 DS
005700081111     D  ppplan                 1      4
005800081111     D   pln1                  1      1
005900081111     D   pln2                  2      2
006000081111     D   pln3                  3      3
006100081111     D   pln4                  4      4
006200081111      *
006300081111     D                 DS
006400081111     D  plnx           S              1
006500081111     D  plnnmb         S              1  0
006600081111     D  plbeg          S              4
006700081111      *
006800991124   X***X
006900991124     C* MAINLINE
007000991124    ***
007100991124     C                   EXSR      ONCE
007200991124     C*
007300991216     C                   DOU       @EXIT = '1'
007400991124     C*
007500000217     C                   IF        FKEY = F1
007600000217     C                   MOVE      '1'           @EXIT
007700000217     C                   MOVE      '*LR'         @PARM
007800000217     C                   ELSE
007900000217     C                   EXSR      $CHKSEL
008000000217     C                   ENDIF
008100991124     C*
008200000217     C                   IF        @EXIT = '0'
008300010918     C*
008400081111     C                   IF        CPLAN <> @K5
008500081111     C                   MOVEL(P)  CPLAN         @K5
008600081112     C                   MOVEL(P)  CPLAN         #KP
008700081112     C                   EXSR      $BUILDSFL
008800081112     C                   ENDIF
008900081112     C*
009000081112     C                   WRITE     JUNK
009100081119     C                   EXFMT     WDWCTL
009200081119     C*
009300081119     C                   ENDIF
009400081119     C*
009500081119     C                   ENDDO
009600081119     C*
009700081119     C                   MOVE      *ON           *INLR
009800081119     C                   RETURN
009900991124   S***S
010000991124     C* ONETIME ROUTINE
010100081119    ***
010200081119     C     ONCE          BEGSR
010300081119    ***
010400081119     C     *ENTRY        PLIST
010500081119     C                   PARM                    @PARM            10
010600081119     C                   MOVEL(P)  @PARM         @KEYPRM
010700081119    ***
010800081119     C     @KEY          KLIST
010900001207     C                   KFLD                    #KT
011000081119     C                   KFLD                    #KS
011100010918     C                   KFLD                    #KP               4
011200010918     C     @KEY2         KLIST
011300081126     C                   KFLD                    #KT
011400081126     C                   KFLD                    #KS
011500081126    ***
011600081126     C                   MOVE      '   A'        @K5
011700081126     C                   MOVEL     '   A'        CPLAN
011800081126     C                   MOVE      '0'           @EXIT             1
011900010918     C                   EXSR      $BUILDSFL
012000081126    ***
012100010918     C                   WRITE     JUNK
012200010918     C                   EXFMT     WDWCTL
012300010918    ***
012400010918     C                   ENDSR
012500081111   S***********************************************************************
012600081111   S***S
012700081119     C     $BUILDSFL     BEGSR
012800081119    ***
012900081125     C                   MOVE      *ZEROS        RRT               4 0
013000081125    ***
013100081125     C                   MOVEA     '011'         *IN(25)
013200081125     C                   WRITE     WDWCTL
013300081125     C                   MOVEA     '010'         *IN(25)
013400081125     C*
013500081125     C                   MOVE      *ZEROS        #CNTREC           3 0
013600081125     C                   MOVE      #KT           CTRST
013700081119     C                   MOVE      #KS           CSUB
013800081125     C                   MOVE      #KP           CPLAN
013900081119     C                   MOVE      #KP           ppplan
014000081111      *     Locate Starting Point
014100081111      *         All blank
014200081111     C                   if        ppplan = '    '
014300081111     C                   eval      plbeg = 'AAAA'
014400081111     C                   else
014500081111      *         3 blank
014600081111     C                   if        pln4 = ' ' and pln3 = ' ' and
014700081111     C                             pln2 = ' '
014800081111     C                   eval      pln4 = 'A'
014900081111     C                   eval      pln3 = 'A'
015000081119     C                   eval      pln2 = 'A'
015100081119     C                   eval      plbeg = ppplan
015200081119     C                   else
015300081111      *         2 blank
015400081126     C                   if        pln4 = ' ' and pln3 = ' '
015500081126     C                   eval      pln4 = 'A'
015600081126     C                   eval      pln3 = 'A'
015700081126     C                   eval      plbeg = ppplan
015800081126     C                   else
015900081126      *         1 blank
016000081111     C                   if        pln4 = ' '
016100081111     C                   eval      pln4 = 'A'
016200081111     C                   eval      plbeg = ppplan
016300081111     C                   else
016400081111      *         0 blank
016500081111     C                   eval      plbeg = ppplan
016600081119     C                   endif
016700081112     C                   endif
016800081119     C                   endif
016900081119     C                   endif
017000081119      *
017100081112     C                   eval      ppplan = plbeg
017200081119      *
017300081111     C                   eval      #KP = plbeg
017400081119      *
017500081119     C                   DOU       %EOF(PLNMST) OR #CNTREC = 600
017600081119     C                   eval      #KP = ppplan
017700081119     C     @KEY          SETLL     PLNMSR
017800081111     C                   READ      PLNMSR
017900081111      *
018000081124     C                   if        ppplan <> plplan
018100081124     C                   MOVE      *ON           *IN25
018200081124     C                   ADD       1             RRT
018300081124     C                   IF        RRT = 1
018400081124     C                   Z-ADD     RRT           SFLPOS
018500081124     C                   ENDIF
018600081124     C                   MOVE      *BLANKS       SEL
018700081124     C                   MOVEL(P)  ppplan        SFPLAN
018800081124     C                   WRITE     POPUP
018900081124     C                   ADD       1             #CNTREC
019000081111     C                   ENDIF
019100081111      *
019200081111     C                   exsr      incpln
019300081111      *
019400081111     C                   ENDDO
019500081111      *
019600020221     C                   IF        RRT > 6
019700020221     C                   MOVE      *ON           *IN91
019800020221     C                   ENDIF
019900991124    ***
020000991124     C                   ENDSR
020100081111   S***********************************************************************
020200991124   S***S
020300000217     C     $CHKSEL       BEGSR
020400081125     C*
020500081125     C                   MOVE      *OFF          *IN33
020600081125     C                   DOU       *IN33 = *ON
020700081125     C                   READC     POPUP                                  33
020800081125     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
020900081125     C                   MOVE      *ON           *IN33
021000081111     C                   MOVEL(P)  SFPLAN        #KP
021100081125     C                   MOVEL(P)  @KEYPRM       @PARM
021200000217     C                   MOVE      '1'           @EXIT
021300000217     C                   ENDIF
021400000217     C                   ENDDO
021500000217     C*
021600000217     C                   ENDSR
021700081111      ******************************************************************
021800081111      *       SUBROUTINE - INCPLN                                      *
021900081111      *                    Increment Plan#                             *
022000081111      ******************************************************************
022100081111     C     incpln        BEGSR
022200081111      *
022300081111     C                   if        pln4 <> '9'
022400081111     C                   eval      plnx = pln4
022500081125     C                   exsr      incone
022600081125     C                   eval      pln4 = plnx
022700081125     C                   else
022800081125      *
022900081125     C                   eval      pln4 = 'A'
023000081125     C                   if        pln3 <> '9'
023100081125     C                   eval      plnx = pln3
023200081125     C                   exsr      incone
023300081125     C                   eval      pln3 = plnx
023400081125     C                   else
023500081125      *
023600081124     C                   eval      pln3 = 'A'
023700081126     C                   if        pln2 <> '9'
023800081126     C                   eval      plnx = pln2
023900081126     C                   exsr      incone
024000081126     C                   eval      pln2 = plnx
024100081126     C                   else
024200081126      *
024300081124     C                   eval      pln2 = 'A'
024400081126     C                   if        pln1 <> '9'
024500081111     C                   eval      plnx = pln1
024600081125     C                   eval      pln1 = plnx
024700081111     C                   exsr      incone
024800081125     C                   else
024900081111      *
025000081111     C                   eval      ppplan = '****'
025100081111     C                   leavesr
025200081111      *
025300081111     C                   endif
025400081111     C                   endif
025500081111     C                   endif
025600081111     C                   endif
025700081111      *
025800081111     C                   endsr
025900081111      ******************************************************************
026000081111      *       SUBROUTINE - INCONE                                      *
026100081111      *                    Increment 1 character by 1                  *
026200081111      ******************************************************************
026300081124     C     incone        BEGSR
026400081124      *
026500081124     C                   if        plnx >= '0' and
026600081124     C                             plnx <= '8'
026700081124     C                   movel     plnx          plnnmb
026800081124     C                   eval      plnnmb = plnnmb + 1
026900081111     C                   movel     plnnmb        plnx
027000081111     C                   leavesr
027100081111     C                   endif
027200081111      *
027300081111     C                   if        plnx = 'A'
027400081111     C                   eval      plnx = 'B'
027500081111     C                   leavesr
027600081111     C                   endif
027700081111      *
027800081111     C                   if        plnx = 'B'
027900081111     C                   eval      plnx = 'C'
028000081125     C                   leavesr
028100081125     C                   endif
028200081125      *
028300081125     C                   if        plnx = 'C'
028400081125     C                   eval      plnx = 'D'
028500081125     C                   leavesr
028600081125     C                   endif
028700081125      *
028800081111     C                   if        plnx = 'D'
028900081125     C                   eval      plnx = 'E'
029000081111     C                   leavesr
029100081125     C                   endif
029200090202      * Skip F - as requested
029300081119     C                   if        plnx = 'E'
029400090202     C                   eval      plnx = 'G'
029500090202     C                   leavesr
029600090202     C                   endif
029700081111      *
029800090202     C                   if        plnx = 'F'
029900081126     C                   eval      plnx = 'G'
030000081126     C                   leavesr
030100081126     C                   endif
030200081111      *
030300081126     C                   if        plnx = 'G'
030400081111     C                   eval      plnx = 'H'
030500081126     C                   leavesr
030600081126     C                   endif
030700081126      *   Skip I - can be confused with 1
030800081126     C                   if        plnx = 'H'
030900081126     C                   eval      plnx = 'J'
031000081126     C                   leavesr
031100081126     C                   endif
031200090202      *
031300090202     C                   if        plnx = 'I'
031400090202     C                   eval      plnx = 'J'
031500090202     C                   leavesr
031600090202     C                   endif
031700081111      *
031800081111     C                   if        plnx = 'J'
031900081111     C                   eval      plnx = 'K'
032000081111     C                   leavesr
032100081111     C                   endif
032200081111      *
032300081111     C                   if        plnx = 'K'
032400081111     C                   eval      plnx = 'L'
032500081111     C                   leavesr
032600081111     C                   endif
032700081111      *
032800081111     C                   if        plnx = 'L'
032900081111     C                   eval      plnx = 'M'
033000081111     C                   leavesr
033100081111     C                   endif
033200081111      *
033300081111     C                   if        plnx = 'M'
033400081126     C                   eval      plnx = 'N'
033500081126     C                   leavesr
033600081126     C                   endif
033700081126      *   Skip O - can be confused with 0
033800081126     C                   if        plnx = 'N'
033900081126     C                   eval      plnx = 'P'
034000081126     C                   leavesr
034100081126     C                   endif
034200090202      *
034300090202     C                   if        plnx = 'O'
034400090202     C                   eval      plnx = 'P'
034500090202     C                   leavesr
034600090202     C                   endif
034700081126      *
034800081111     C                   if        plnx = 'P'
034900081111     C                   eval      plnx = 'Q'
035000081111     C                   leavesr
035100081111     C                   endif
035200081111      *
035300081111     C                   if        plnx = 'Q'
035400081111     C                   eval      plnx = 'R'
035500081111     C                   leavesr
035600081111     C                   endif
035700081111      *
035800081111     C                   if        plnx = 'R'
035900081111     C                   eval      plnx = 'S'
036000081111     C                   leavesr
036100081111     C                   endif
036200081111      *
036300081111     C                   if        plnx = 'S'
036400081111     C                   eval      plnx = 'T'
036500081111     C                   leavesr
036600081111     C                   endif
036700081111      *
036800081111     C                   if        plnx = 'T'
036900081111     C                   eval      plnx = 'U'
037000081111     C                   leavesr
037100081111     C                   endif
037200081111      *
037300081111     C                   if        plnx = 'U'
037400081111     C                   eval      plnx = 'V'
037500081111     C                   leavesr
037600081111     C                   endif
037700081111      *
037800081111     C                   if        plnx = 'V'
037900081111     C                   eval      plnx = 'W'
038000081111     C                   leavesr
038100081111     C                   endif
038200081111      *
038300081111     C                   if        plnx = 'W'
038400081111     C                   eval      plnx = 'X'
038500081111     C                   leavesr
038600081111     C                   endif
038700081111      *
038800081111     C                   if        plnx = 'X'
038900081111     C                   eval      plnx = 'Y'
039000081111     C                   leavesr
039100081111     C                   endif
039200081111      *
039300081111     C                   if        plnx = 'Y'
039400081111     C                   eval      plnx = 'Z'
039500081111     C                   leavesr
039600081111     C                   endif
039700081111      *
039800081111     C                   if        plnx = 'Z'
039900081111     C                   eval      plnx = '0'
040000081111     C                   leavesr
040100081111     C                   endif
040200081111      *
040300081111     C                   ENDSR
