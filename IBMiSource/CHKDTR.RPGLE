000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300101019    ? *  Description:  Check Pay Choice Date Ranges
000400000000    ? *
000500100520    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000700101019    ?FWEBPAYDTR IF   E           K DISK
000800100617    ?FWEBPAYCHP IF   E           K DISK
000900100521     FACCMST    IF   E           K DISK
001000000000    ? *
001100010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200151008    ?D WTM             S             80    DIM(11) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001300110110    ? *
001400110110     D WDATE1          s              8S 0 inz
001500110110     D WDATE2          s              8S 0 inz
001600000000    ? *___________________________________________________________________
001700000000    ? *
001800000614    ? * Data structure
001900101019    ?D WUDTA         E DS                  EXTNAME(WEBPAYDTR)
002000000810    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *___________________________________________________________________
002400000000    ? * Process check request
002500000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002600000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002700000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002800000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002900000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003000000000    ?C                   Endcs                                                  END CASE
003100000000    ?C                   Return                                                 RETURN
003200000000    ? *___________________________________________________________________
003300000000    ? * Edit record
003400000000    ? *___________________________________________________________________
003500000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003600000810    ? *
003700000810    ? * Defualt Data
003800000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003900100617    ? *
004000100617    ? * Check TSA
004100100617     C     KEYACC        Chain     ACCMST
004200100617     C                   if        not %found(ACCMST)
004300100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400100617    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004500100617    ?C                   Exsr      SNDMSG                                       SEND MSG
004600100617     C                   End
004700100617    ? *
004800100617    ? * Check valid grouper
004900101019     C                   IF        PGCODE <> 'OPEN' and
005000101019     C                             PGCODE <> 'INIT'
005100100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005200100617    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005300100617    ?C                   Exsr      SNDMSG                                       SEND MSG
005400100617     C                   LeaveSR
005500100617     C                   Endif
005600100610    ? *
005700100610    ? * Check valid grouper
005800100617     C                   Eval      PCTRST = 0
005900100617     C                   Eval      PCSUB# = 0
006000101019     C                   Eval      PCACCT = 0
006100101019     C                   Eval      PCGRPR = 'RANGE'
006200101019     C                   Eval      PGGRPR = 'RANGE'
006300100617     C     W_KEY         Chain     WEBPAYCHP
006400100617     C                   If        not %found(WEBPAYCHP)
006500100610    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006600100617    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006700100610    ?C                   Exsr      SNDMSG                                       SEND MSG
006800100610     C                   LeaveSR
006900100610     C                   Endif
007000100617    ? *
007100100617    ? * Validate Effective Date
007200101019     C                   If        PGFRDT <> *Zeros
007300101019     C                   Movel     PGFRDT        Input_Date
007400100617     C                   Exsr      FMTDATE
007500100617     C                   If        Output_Error <> *Blanks
007600100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007700100617    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007800100617    ?C                   Exsr      SNDMSG                                       SEND MSG
007900100617     C                   LeaveSR
008000100617     C                   End
008100100617     C                   Else
008200100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008300100617    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
008400100617    ?C                   Exsr      SNDMSG                                       SEND MSG
008500100617     C                   LeaveSR
008600100617     C                   End
008700100617    ? *
008800100617    ? * Validate Term Date
008900101019     C                   If        PGTODT <> *Zeros
009000101019     C                   Movel     PGTODT        Input_Date
009100100617     C                   Exsr      FMTDATE
009200100617     C                   If        Output_Error <> *Blanks
009300100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009400100617    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
009500100617    ?C                   Exsr      SNDMSG                                       SEND MSG
009600100617     C                   LeaveSR
009700100617     C                   End
009800100617     C                   End
009900100617    ? *
010000100617    ? * Validate Effective Date < Term Date
010100101019     C                   If        PGFRDT <> *Zeros  and
010200101019     C                             PGTODT <> *Zeros
010300110110     C     PGFRDT        Mult      10000.0001    WDATE1
010400110110     C     PGTODT        Mult      10000.0001    WDATE2
010500110110     C                   If        WDATE1  > WDATE2
010600100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010700100617    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
010800100617    ?C                   Exsr      SNDMSG                                       SEND MSG
010900100617     C                   LeaveSR
011000100617     C                   End
011100100617     C                   End
011200101019    ? *
011300110110    ? * Validate Effective Date < To Date
011400110110     C**                 If        PGEFDT <> *Zeros  and
011500110110     C**                           PGTODT <> *Zeros
011600110110     C**   PGEFDT        Mult      10000.0001    WDATE1
011700110110     C**   PGTODT        Mult      10000.0001    WDATE2
011800110110     C**                 If        WDATE1  < WDATE2
011900110110    ?C**                 Move      'ERROR   '    WORTN                          REQUEST ERROR
012000110110    ?C**                 Move      WTM(7)        WWMSG                          PASS MSG
012100110110    ?C**                 Exsr      SNDMSG                                       SEND MSG
012200110110     C**                 LeaveSR
012300110110     C**                 End
012400110110     C**                 End
012500101019    ? *
012600101019    ? * Validate Effective Date > To Date
012700101019     C                   If        PGEFDT =  *Zeros
012800101019    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012900101019    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
013000101019    ?C                   Exsr      SNDMSG                                       SEND MSG
013100101019     C                   LeaveSR
013200101019     C                   End
013300151008    ? *
013400151008    ? * Validate Email From Date
013500151008     C                   If        PGMFDT <> *Zeros
013600151008     C                   Movel     PGMFDT        Input_Date
013700151008     C                   Exsr      FMTDATE
013800151008     C                   If        Output_Error <> *Blanks
013900151008    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014000151008    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
014100151008    ?C                   Exsr      SNDMSG                                       SEND MSG
014200151008     C                   LeaveSR
014300151008     C                   End
014400151008     C                   End
014500151008    ? *
014600151008    ? * Validate Email To Date
014700151008     C                   If        PGMTDT <> *Zeros
014800151008     C                   Movel     PGMTDT        Input_Date
014900151008     C                   Exsr      FMTDATE
015000151008     C                   If        Output_Error <> *Blanks
015100151008    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015200151008    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
015300151008    ?C                   Exsr      SNDMSG                                       SEND MSG
015400151008     C                   LeaveSR
015500151008     C                   End
015600151008     C                   End
015700151008    ? *
015800151008    ? * Validate Effective Date < Term Date
015900151008     C                   If        PGMFDT <> *Zeros  and
016000151008     C                             PGMTDT <> *Zeros
016100151008     C     PGMFDT        Mult      10000.0001    WDATE1
016200151008     C     PGMTDT        Mult      10000.0001    WDATE2
016300151008     C                   If        WDATE1  > WDATE2
016400151008    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016500151008    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
016600151008    ?C                   Exsr      SNDMSG                                       SEND MSG
016700151008     C                   LeaveSR
016800151008     C                   End
016900151008     C                   End
017000031215    ? *
017100010913    ?C                   Endsr                                                  END DLT RQST
017200000000    ? *___________________________________________________________________
017300000000    ? * Edit delete request
017400000000    ? *___________________________________________________________________
017500000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
017600100617    ? *
017700000000    ?C                   Endsr                                                  END DLT RQST
017800000000    ? *___________________________________________________________________
017900000000    ? * Default data
018000000000    ? *___________________________________________________________________
018100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
018200000000    ?C                   Endsr                                                  END DFT DATA
018300000000    ? *___________________________________________________________________
018400000000    ? * Send messages
018500000000    ? *___________________________________________________________________
018600000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
018700000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
018800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
018900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
019000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
019100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
019200000000    ?C                   Endsr                                                  END SND ERRMSG
019300000000    ? *___________________________________________________________________
019400000000    ? * Process error
019500000000    ? *___________________________________________________________________
019600000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
019700000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019800000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
019900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
020000000000    ?C                   Endsr                                                  END PRCERR
020100000000    ? *___________________________________________________________________
020200000000    ? * Parameter list
020300000000    ? *___________________________________________________________________
020400000000    ?C     PLIST         Begsr                                                  PARM LISTS
020500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
020600000000    ?C                   Parm                    WIRQS             8            REQUEST
020700000000    ?C                   Parm                    WORTN             8            RETURN CODE
020800000614    ?C                   Parm                    WUDTA                          DATA
020900000000    ?C                   Endsr                                                  END PLIST
021000000000    ? *___________________________________________________________________
021100000000    ? * Define Variables and Key Lists
021200000000    ? *___________________________________________________________________
021300000000    ?C     DEFN          Begsr                                                  PARM LISTS
021400000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
021500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
021600000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
021700000000    ?C                   Endsr                                                  END DEFN
021800010914    ? *___________________________________________________________________
021900010914    ? * Key lists
022000010914    ? *___________________________________________________________________
022100010914    ?C     KLIST         Begsr                                                  KEY LISTS
022200100617     C     KEYACC        Klist
022300101019     C                   kfld                    PGTRST
022400101019     C                   kfld                    PGSUB#
022500101019     C                   kfld                    PGACCT
022600100617     C     W_KEY         Klist
022700100617     C                   kfld                    PCTRST
022800100617     C                   kfld                    PCSUB#
022900100617     C                   kfld                    PCACCT
023000101019     C                   kfld                    PGGRPR
023100010914    ?C                   Endsr
023200000000    ? *___________________________________________________________________
023300000000    ? * Program error handler
023400000000    ? *___________________________________________________________________
023500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
023600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
023700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
023800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
023900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
024000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
024100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
024200031215      *-------------------------------------------------------------------*
024300031215      * Format Date
024400031215      *-------------------------------------------------------------------*
024500031215     C     FMTDATE       Begsr
024600031215     C                   Eval      Input_Format  = 'MMDDYYYY'
024700031215     C                   Eval      Output_Format = 'MMDDYYYY'
024800031215     C                   Call      'FMTDATE'
024900031215     C                   Parm                    Input_Date       32
025000031215     C                   Parm                    Input_Format     32
025100031215     C                   Parm                    Output_Format    32
025200031215     C                   Parm                    Output_Date      32
025300031215     C                   Parm                    Output_Error     10
025400031215     C                   Endsr
025500000000    ? *___________________________________________________________________
025600000112** WTMP
02570000000000T-Record is not eligible for deletion.
02580010101900Request not supported by program CHKDTR.
025900000117** WTM
02600010061761Account Number is invalid
02610010101962Range Code must already exist (F4)
02620010101962Range Code must already exist (F4)
02630010101964From Date is invalid
02640010101965To Date is invalid
02650010101964From Date is greater than To Date
02660010101967Effective Date must be greater than To Date
02670010101967Effective Date is required
02680015100868Email From Date is invalid
02690015100869Email To Date is invalid
02700015100868Email From Date must be greater than To Date
