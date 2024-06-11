000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Check Internal Sales Commission Salesman
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600030219    ? *
000700030219    ? *  Revised by:   SZZ  February 17, 2003
000800030219    ? *                Add fields for new rate structure.
000900000000    ? *___________________________________________________________________
001000040802    ?FISCGLB    IF   E           K DISK
001100040802    ?FISCSM2LF  IF   E           K DISK    prefix(X_)
001200000000    ? *
001300000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001400030317    ?D WTM             S             80    DIM(18) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001500000000    ? *___________________________________________________________________
001600000000    ? *
001700000614    ? * Data structure
001800040802    ?D WUDTA         E DS                  EXTNAME(ISCSM2)
001900040802    ?D WWDTA         E DS                  EXTNAME(ISCSM2) prefix(W)
002000000810    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *___________________________________________________________________
002400000000    ? * Process check request
002500000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002600000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002700040802    ?C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT DLT RQST
002800000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002900000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003000000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003100000000    ?C                   Endcs                                                  END CASE
003200000000    ?C                   Return                                                 RETURN
003300040802    ? *___________________________________________________________________
003400040802    ? * Edit Add record
003500040802    ? *___________________________________________________________________
003600040802    ?C     EDTADD        Begsr                                                  EDIT RECORD
003700040802     C                   Exsr      EDTRCD
003800040802     C                   If        WORTN = *Blanks
003900040802     C     ISEFDT        Mult      10000.0001    WISEFDT
004000040802     C     ISTRDT        Mult      10000.0001    WISTRDT
004100040802     C     ISSMAN        Setll     ISCSM2LF
004200040802     C     ISSMAN        Reade     ISCSM2LF
004300040802     C                   Dow       not %Eof(ISCSM2LF)
004400040802     C                   Select
004500040802     C                   When      WISEFDT <= X_ISEFDT and
004600040802     C                             WISTRDT = *Zeros
004700040802     C                   Eval      WORTN = 'ERROR'
004800040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
004900040802    ?C                   Exsr      SNDMSG                                       SEND MSG
005000040802     C                   LeaveSR
005100040802     C                   When      WISEFDT <= X_ISEFDT and
005200040802     C                             WISTRDT = *Zeros
005300040802     C                   Eval      WORTN = 'ERROR'
005400040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
005500040802    ?C                   Exsr      SNDMSG                                       SEND MSG
005600040802     C                   LeaveSR
005700040802     C                   When      WISEFDT <= X_ISEFDT and
005800040802     C                             WISTRDT >= X_ISEFDT and
005900040802     C                             WISTRDT <= X_ISTRDT
006000040802     C                   Eval      WORTN = 'ERROR'
006100040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
006200040802    ?C                   Exsr      SNDMSG                                       SEND MSG
006300040802     C                   LeaveSR
006400040802     C                   When      WISEFDT >= X_ISEFDT and
006500040802     C                             X_ISTRDT = *Zeros
006600040802     C                   Eval      WORTN = 'ERROR'
006700040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
006800040802    ?C                   Exsr      SNDMSG                                       SEND MSG
006900040802     C                   LeaveSR
007000040802     C                   When      WISEFDT >= X_ISEFDT and
007100040802     C                             WISTRDT <= X_ISTRDT and
007200040802     C                             WISTRDT <> *Zeros
007300040802     C                   Eval      WORTN = 'ERROR'
007400040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
007500040802    ?C                   Exsr      SNDMSG                                       SEND MSG
007600040802     C                   LeaveSR
007700040802     C                   When      WISEFDT >= X_ISEFDT and
007800040802     C                             WISEFDT <= X_ISTRDT
007900040802     C                   Eval      WORTN = 'ERROR'
008000040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
008100040802    ?C                   Exsr      SNDMSG                                       SEND MSG
008200040802     C                   LeaveSR
008300040802     C                   When      WISEFDT >= X_ISEFDT and
008400040804     C                             WISTRDT <= X_ISTRDT and
008500040804     C                             WISTRDT <> 0
008600040802     C                   Eval      WORTN = 'ERROR'
008700040802    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
008800040802    ?C                   Exsr      SNDMSG                                       SEND MSG
008900040802     C                   LeaveSR
009000040802     C                   Endsl
009100040802     C     ISSMAN        Reade     ISCSM2LF
009200040802     C                   Enddo
009300040802     C                   End
009400040802    ?C                   Endsr                                                  END EDIT RECORD
009500000000    ? *___________________________________________________________________
009600000000    ? * Edit record
009700000000    ? *___________________________________________________________________
009800000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
009900000810    ? *
010000000810    ? * Defualt Data
010100000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
010200010219    ? *
010300010219    ? * INTERNAL SALES TYPE
010400010219     C     ISITYP        CHAIN     ISCGLB
010500010219     C                   IF        NOT %FOUND
010600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010700040729    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
010800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
010900010219     C                   Endif
011000010219    ? * DURATION
011100020220     C*                  If        ISDERM = *ZEROS
011200020220    ?C*                  Move      'ERROR   '    WORTN                          REQUEST ERROR
011300040729    ?C*                  Move      WTM(3)        WWMSG                          PASS MSG
011400020220    ?C*                  Exsr      SNDMSG                                       SEND MSG
011500020220     C*                  Endif
011600010220    ? * SALES MANAGER
011700030522     C                   If        ISITYP <> 'DIR'
011800010222     C                   If        ISSMGR = *BLANKS
011900010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012000040729    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
012100010220    ?C                   Exsr      SNDMSG                                       SEND MSG
012200010220     C                   Endif
012300010222     C                   Endif
012400000810    ? *
012500020220    ? * EFFECTIVE DATE
012600020220     C                   If        ISEFDT = *ZEROS
012700020220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012800040729    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
012900020220    ?C                   Exsr      SNDMSG                                       SEND MSG
013000020220     C                   Else
013100020220     C                   movel     ISEFDT        Input_Date
013200020220     C                   Exsr      EDTDAT
013300020220     C                   If        Output_Error <> *Blanks
013400020220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013500040729    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
013600020220    ?C                   Exsr      SNDMSG                                       SEND MSG
013700020220     C                   Endif
013800020220     C                   Endif
013900020220    ? *
014000020220    ? * TERM DATE
014100020220     C                   If        ISTRDT <> *ZEROS
014200020220     C                   movel     ISTRDT        Input_Date
014300020220     C                   Exsr      EDTDAT
014400020220     C                   If        Output_Error <> *Blanks
014500020220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014600040729    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
014700020220    ?C                   Exsr      SNDMSG                                       SEND MSG
014800020220     C                   Else
014900020220    ? *
015000020220    ? * TERM DATE > EFF DATE
015100020220     C                   If        ISTRDT <> *ZEROS and
015200020220     C                             ISEFDT <> *ZEROS
015300020220     C     ISTRDT        Mult      10000.0001    WWTRDT            8 0
015400020220     C     ISEFDT        Mult      10000.0001    WWEFDT            8 0
015500020220     C                   If        WWEFDT  > WWTRDT
015600020220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015700040729    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
015800020220    ?C                   Exsr      SNDMSG                                       SEND MSG
015900020220     C                   Endif
016000020220     C                   Endif
016100020220     C                   Endif
016200020220     C                   Endif
016300030219    ? * Low/High Flag
016400030219     C                   If        ISLHFL <> 'L'   And
016500030219     C                             ISLHFL <> 'H'
016600030219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016700040729    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
016800030219    ?C                   Exsr      SNDMSG                                       SEND MSG
016900030219     C                   Endif
017000030220    ? * Low/High Size Code
017100030220     C****               If        ISSZCD = *Zero
017200030220    ?C****               Move      'ERROR   '    WORTN                          REQUEST ERROR
017300040729    ?C****               Move      WTM(9)        WWMSG                          PASS MSG
017400030220    ?C****               Exsr      SNDMSG                                       SEND MSG
017500030220     C****               Endif
017600030219    ? * Rate
017700030926     C****               If        ISRATE = *Zero
017800030926    ?C****               Move      'ERROR   '    WORTN                          REQUEST ERROR
017900040729    ?C****               Move      WTM(10)       WWMSG                          PASS MSG
018000030926    ?C****               Exsr      SNDMSG                                       SEND MSG
018100030926     C*****              Endif
018200030219    ? * Bypass Flag
018300030219     C                   If        ISBYFL <> 'Y' And
018400030219     C                             ISBYFL <> 'N'
018500030219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018600040729    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
018700030219    ?C                   Exsr      SNDMSG                                       SEND MSG
018800030219     C                   Endif
018900060504    ? * Bypass Flag
019000060504     C                   If        ISSKIP <> 'Y' And
019100060504     C                             ISSKIP <> 'N'
019200060504    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019300060504    ?C                   Move      WTM(15)       WWMSG                          PASS MSG
019400060504    ?C                   Exsr      SNDMSG                                       SEND MSG
019500060504     C                   Endif
019600030317    ? * Sales Category
019700030317     C                   If        ISCATG <> 'ALL' And
019800030317     C                             ISCATG <> 'ANC' And
019900030317     C                             ISCATG <> 'MED'
020000030317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020100040729    ?C                   Move      WTM(12)       WWMSG                          PASS MSG
020200030317    ?C                   Exsr      SNDMSG                                       SEND MSG
020300030317     C                   Endif
020400040729    ? * Run-Out Flag
020500040729     C                   If        ISRUNO <> 'Y' And
020600040729     C                             ISRUNO <> 'N'
020700040729    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020800040729    ?C                   Move      WTM(13)       WWMSG                          PASS MSG
020900040729    ?C                   Exsr      SNDMSG                                       SEND MSG
021000040729     C                   Endif
021100020220    ? *
021200000000    ?C                   Endsr                                                  END EDIT RECORD
021300000000    ? *___________________________________________________________________
021400000000    ? * Edit delete request
021500000000    ? *___________________________________________________________________
021600000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
021700000000    ?C                   Endsr                                                  END DLT RQST
021800000000    ? *___________________________________________________________________
021900000000    ? * Default data
022000000000    ? *___________________________________________________________________
022100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
022200000000    ?C                   Endsr                                                  END DFT DATA
022300020220    ? *___________________________________________________________________
022400020220    ? * format Date edit
022500020220    ? *___________________________________________________________________
022600020220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
022700020220     C                   movel     'MMDDYYYY'    Input_Format
022800020220     C                   Call      'FMTDATE'
022900020220     C                   Parm                    Input_Date       32
023000020220     C                   Parm                    Input_Format     32
023100020220     C                   Parm                    Output_Format    32
023200020220     C                   Parm                    Output_Date      32
023300020220     C                   Parm                    Output_Error     10
023400020220    ?C                   Endsr                                                  END DLT RQST
023500000000    ? *___________________________________________________________________
023600000000    ? * Send messages
023700000000    ? *___________________________________________________________________
023800000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
023900000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
024000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
024100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
024200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
024300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
024400000000    ?C                   Endsr                                                  END SND ERRMSG
024500000000    ? *___________________________________________________________________
024600000000    ? * Process error
024700000000    ? *___________________________________________________________________
024800000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
024900000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
025000000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
025100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
025200000000    ?C                   Endsr                                                  END PRCERR
025300000000    ? *___________________________________________________________________
025400000000    ? * Parameter list
025500000000    ? *___________________________________________________________________
025600000000    ?C     PLIST         Begsr                                                  PARM LISTS
025700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
025800000000    ?C                   Parm                    WIRQS             8            REQUEST
025900000000    ?C                   Parm                    WORTN             8            RETURN CODE
026000000614    ?C                   Parm                    WUDTA                          DATA
026100000000    ?C                   Endsr                                                  END PLIST
026200000000    ? *___________________________________________________________________
026300000000    ? * Define Variables and Key Lists
026400000000    ? *___________________________________________________________________
026500000000    ?C     DEFN          Begsr                                                  PARM LISTS
026600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
026700000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
026800000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
026900000000    ?C                   Endsr                                                  END DEFN
027000000000    ? *___________________________________________________________________
027100000000    ? * Program error handler
027200000000    ? *___________________________________________________________________
027300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
027400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
027500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
027600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
027700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
027800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
027900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
028000000000    ? *___________________________________________________________________
028100000112** WTMP
02820000000000T-Record is not eligible for deletion.
02830004072800Request not supported by program CHKSM2.
028400000117** WTM
02850001021961Salesman Code must be entered.
02860004072962Internal Sales Type must be valid.
02870004072963Duration Months must be entered.
02880004072964Sales Manager must be entered.
02890004072965Effective Date must be valid.
02900004072966Term Date must be valid.
02910004072966Term Date Cannot be less than Effective Date.
02920004072967Low/High Flag must be L or H.
02930004072968Low/High Size Code cannot be zero.
02940004072969Percent of Income cannot be zero.
02950004072970By-pass GBS Admin Date Flag must be Y or N.
02960004072971Sales Category must be ALL,ANC, or MED.
02970006050472Run-Out Flag must be Y or N.
02980004080265Overlapping Dates not allowed.
02990006050473By-Pass Plan Cat Flag must be Y or N.
