000100990714      ******************************************************************
000200990714      *  FL170     GROUP BENEFIT SERVICES SOFTWARE                     *
000300990714      *                                                                *
000400990714      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000500990714      *            DATE - 07/14/99                                     *
000600990714      *                                                                *
000700990714      *  DESCRIPTION - THIS PROGRAM ALLOWS A SEARCH, DISPLAY & PRINT   *
000800990714      *                OF THE EXCLUSION FILE.                          *
000900000317      * 03/17/00 dlk - add aacode/name to screen and aacode/name/      *
001000000317      *                smancd/sman name to report. Also add to report: *
001100000317      *                page #, total                                   *
001200020524      *  5/24/02 szz - Recompiled over new AACODE file                 *
001300141107      * 11/07/14 dpb - Added F11 for excel listing of exclusions       *
001400000317      *                                                                *
001500990714      ******************************************************************
001600990714     FFL170D    CF   E             WORKSTN
001700000000     F                                     SFILE(S05SFL:RR5)
001800990714     FINVEXC    IF   E           K DISK
001900990714     FACCMST    IF   E           K DISK
002000000317     Faacode    IF   E           K DISK
002100000317     Fsman      IF   E           K DISK
002200990716     FFL170P    O    E             PRINTER OFLIND(*IN80)
002300000317
002400990714     D                UDS
002500990714     D  CONAME               201    240
002600000317     iaccmsr
002700000317     I              aacode                      a_aacode
002800141107
002900141107     C     *entry        plist
003000141107     C                   parm                    email_xls         1
003100141107
003200990714     C     ACCKEY        KLIST
003300990714     C                   KFLD                    IETRUS
003400990714     C                   KFLD                    IESUB
003500990714     C                   KFLD                    IEACC
003600990714      *
003700000000     C     #START        TAG
003800990714      *
003900990714      * DISPLAY SEARCH
004000990714      *
004100000000     C                   MOVEA     '0010'        *IN(60)
004200990714      *
004300990714      * CLEAR SUBFILE
004400990714      *
004500000000     C                   WRITE     S05CTL
004600000000     C                   MOVE      '0'           *IN62
004700990714      *
004800990714      * BUILD SUBFILE - READ EXCLUSION FILE
004900990714      *
005000000000     C                   Z-ADD     1             SFREC#
005100000000     C                   MOVE      *ZEROS        RR5               5 0
005200000000     C                   MOVE      *ZEROS        COUNT             5 0
005300990816     C     *LOVAL        SETLL     INVEXC
005400990816     C     SEARCH        SETLL     INVEXC
005500990816     C     #T0100        TAG
005600990714      *
005700990714     C                   READ      INVEXC                                 64
005800990715      *
005900000317     C     *IN64         IFEQ      '0'
006000990715     C                   MOVE      IEEFF         @DATIN
006100990715     C                   EXSR      #DATYM
006200990715     C                   MOVE      @DATOU        IEEFF
006300990715      *
006400990715     C     ACCKEY        CHAIN     ACCMST                             80
006500000317
006600000317     C     a_aacode      CHAIN     aacode                             81
006700000317     c                   if        *in81 = *off
006800000317     c                   movel     alnam         aaname
006900000317     c                   else
007000000317     c                   move      *blanks       aaname
007100000317     c                   end
007200990715      *
007300000000     C                   ADD       1             RR5
007400000000     C                   ADD       1             COUNT
007500990714      *
007600000000     C                   WRITE     S05SFL
007700990714      *
007800990714      * EXPANDING SUBFILE, LOAD 75  RECORDS AT A TIME (15 PER PAGE)
007900990714      *
008000000000     C     COUNT         CABEQ     75            #T0120
008100000000     C                   GOTO      #T0100
008200990816     C                   END
008300990714      *
008400990714      * DISPLAY SUBFILE
008500990714      *
008600000000     C     #T0120        TAG
008700990714      *
008800990714      * *IN63 IS ON WHEN LAST PAGE IS DISPLAYED AND ROLLUP
008900990714      * KEY IS PRESSED AGAIN... IF ANY MORE RECORDS WERE ADDED
009000990714      * TO SUBFILE THEN DISPLAY NEXT PAGE,  ELSE IF THE LAST RECORD
009100990714      * TO DISPLAY WAS EXACTLY THE LAST ONE ON THE LAST PAGE, THEN
009200990714      * DISPLAY THE LAST PAGE
009300990714      *
009400000000     C     *IN63         IFEQ      '1'
009500000000     C     COUNT         IFGT      0
009600000000     C                   ADD       75            SFREC#
009700000000     C                   ELSE
009800000000     C                   ADD       74            SFREC#
009900000000     C                   END
010000000000     C                   MOVE      '0'           *IN63
010100000000     C                   END
010200990714      *
010300000000     C                   MOVE      '1'           *IN61
010400000000     C     RR5           IFGT      0
010500000000     C                   MOVE      '1'           *IN60
010600000000     C                   END
010700000000     C                   WRITE     S05CMDKY
010800990714      *
010900000000     C                   EXFMT     S05CTL
011000990714      *
011100141107     C                   if        *inkg = *on or *in11 = *on
011200141107     C                   goto      #end
011300141107     C                   endif
011400990714      *
011500990714      * IF ENTER PRESSED BUT NO RECORDS IN SUBFILE, RE-DISPLAY SCREEN
011600990714      *
011700990817     C****       *IN60     CABEQ'0'       #T0120
011800990817     C     *IN60         CABEQ     '0'           #START
011900990714      *
012000990714      * *IN63 IS ON WHEN LAST PAGE IS DISPLAYED AND ROLLUP
012100990714      * KEY IS PRESSED AGAIN... LOAD NEXT 75  RECORDS IN SUBFILE
012200990714      *
012300000000     C     *IN63         IFEQ      '1'
012400000000     C                   MOVE      *ZEROS        COUNT
012500000000     C                   GOTO      #T0100
012600000000     C                   END
012700990715      *
012800990719     C     #XPRT         TAG
012900000000     C     *INKA         CABEQ     *ON           #START
013000990714      *
013100000000     C     *INKG         CABEQ     *ON           #END
013200990714      *
013300990719     C     *INKI         IFEQ      *ON
013400990719     C                   CLEAR                   TRST#
013500990719     C                   EXFMT     WINDO1
013600990720     C     *INKA         CABEQ     *ON           #START
013700990719     C                   EXSR      #PRINT
013800990719     C                   ENDIF
013900990719      *
014000990719     C                   GOTO      #START
014100990714      *
014200000000     C     #END          TAG
014300141107
014400141107     C                   if        *in11 = *on
014500141107     C                   eval      email_xls = 'Y'
014600141107     C                   endif
014700990715      *
014800141107     C                   MOVE      *ON           *INLR
014900990715      ***************************************************
015000990715      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
015100990715      ***************************************************
015200990715      *
015300990715      * DATE IN  = @DATIN (8.0) YYYYMMDD
015400990715      * DATE OUT = @DATOU (8.0) MMDDYYYY
015500990715      *
015600990715     C     #DATYM        BEGSR
015700990323     C                   MOVE      @DATIN        @MD               4 0
015800990323     C                   MOVEL     @DATIN        @Y                4 0
015900990323     C                   MOVEL     @MD           @DATOU            8 0
016000990323     C                   MOVE      @Y            @DATOU
016100990323     C                   MOVE      *ZEROS        @DATIN            8 0
016200990715     C                   ENDSR
016300990715      *
016400990715      ****************************************
016500990715      * PRINT SELECTED TRUST# OR ALL RECORDS *
016600990715      ****************************************
016700990715      *
016800990715     C     #PRINT        BEGSR
016900000317     c                   eval      totacc = *zeros
017000990719     C     *LOVAL        SETLL     INVEXC
017100990716     C     TRST#         IFNE      *ZEROS
017200990716     C     TRST#         SETLL     INVEXC
017300990716     C     TRST#         READE     INVEXC                                 99
017400990719     C                   MOVE      *ON           *IN80
017500990716     C     *IN99         DOWEQ     *OFF
017600990719     C     *IN80         IFEQ      *ON
017700990719     C                   WRITE     HEADER
017800990719     C                   MOVE      *OFF          *IN80
017900990719     C                   ENDIF
018000990719      *
018100990719     C                   MOVE      IEEFF         @DATIN
018200990719     C                   EXSR      #DATYM
018300990719     C                   MOVE      @DATOU        IEEFF
018400990719      *
018500990719     C     ACCKEY        CHAIN     ACCMST                             80
018600000317
018700000317     C     smancd        CHAIN     sman                               82
018800000317     c                   if        *in82
018900000317     c                   move      *blanks       slname
019000000317     c                   end
019100000317
019200000317     C     a_aacode      CHAIN     aacode                             81
019300000317     c                   if        *in81 = *off
019400000317     c                   movel     alnam         aaname
019500000317     c                   else
019600000317     c                   move      *blanks       aaname
019700000317     c                   end
019800000317      *
019900000317     c                   add       1             totacc
020000990716     C                   WRITE     DETAIL
020100990719     C                   CLEAR                   DETAIL
020200990716     C     TRST#         READE     INVEXC                                 99
020300990716     C                   ENDDO
020400000317     C                   WRITE     footer
020500000317
020600990716     C                   ELSE
020700000317
020800990716     C                   READ      INVEXC                                 99
020900990719     C                   MOVE      *ON           *IN80
021000990716     C     *IN99         DOWEQ     *OFF
021100990719     C     *IN80         IFEQ      *ON
021200990719     C                   WRITE     HEADER
021300990719     C                   MOVE      *OFF          *IN80
021400990719     C                   ENDIF
021500990719      *
021600990719     C                   MOVE      IEEFF         @DATIN
021700990719     C                   EXSR      #DATYM
021800990719     C                   MOVE      @DATOU        IEEFF
021900990719      *
022000990719     C     ACCKEY        CHAIN     ACCMST                             80
022100000317
022200000317     C     smancd        CHAIN     sman                               82
022300000317     c                   if        *in82
022400000317     c                   move      *blanks       slname
022500000317     c                   end
022600000317
022700000317
022800000317     C     a_aacode      CHAIN     aacode                             81
022900000317     c                   if        *in81 = *off
023000000317     c                   movel     alnam         aaname
023100000317     c                   else
023200000317     c                   move      *blanks       aaname
023300000317     c                   end
023400000317      *
023500000317     c                   add       1             totacc
023600990716     C                   WRITE     DETAIL
023700990719     C                   CLEAR                   DETAIL
023800990716     C                   READ      INVEXC                                 99
023900990716     C                   ENDDO
024000000317     C                   WRITE     footer
024100000317
024200990716     C                   ENDIF
024300000317
024400990716     C                   MOVE      *OFF          *IN99
024500990719     C                   GOTO      #START
024600990715     C                   ENDSR
