000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100520    ? *  Description:  Check Pay Choice Codes
000400000000    ? *
000500100520    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000700100617    ?FWEBPAYOPT IF   E           K DISK
000800100617    ?FWEBPAYCHP IF   E           K DISK
000900100521     FACCMST    IF   E           K DISK
001000000000    ? *
001100010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200060303    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001300130326     D N_WAIT          S              3S 0 inz
001400130326     D w80date1        S              8S 0 inz
001500130326     D w80date2        S              8S 0 inz
001600000000    ? *___________________________________________________________________
001700000000    ? *
001800000614    ? * Data structure
001900100617    ?D WUDTA         E DS                  EXTNAME(WEBPAYOPT)
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
004900101130     C                   IF        POGRPR <> 'WAIVER' and
005000101130     C                             POGRPR <> 'DEFCON'
005100100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005200100617    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005300100617    ?C                   Exsr      SNDMSG                                       SEND MSG
005400100617     C                   LeaveSR
005500100617     C                   Endif
005600100610    ? *
005700100610    ? * Check valid grouper
005800100617     C                   Eval      PCTRST = 0
005900100617     C                   Eval      PCSUB# = 0
006000100617     C                   Eval      PCACCT = 0
006100100617     C     W_KEY         Chain     WEBPAYCHP
006200100617     C                   If        not %found(WEBPAYCHP)
006300100610    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006400100617    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006500100610    ?C                   Exsr      SNDMSG                                       SEND MSG
006600100610     C                   LeaveSR
006700100610     C                   Endif
006800150625
006900150625      * Refund Y/M
007000150625     C                   If        PORFND <> 'Y' and
007100150625     C                             PORFND <> 'N'
007200150625    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007300150625    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
007400150625    ?C                   Exsr      SNDMSG                                       SEND MSG
007500150625     C                   LeaveSR
007600150625     C                   end
007700101202
007800101202      * Wait Days Valid Values.
007900101202     C                   Move      POWAIT        N_WAIT
008000101202     C                   Select
008100101202     C                   When      N_WAIT =  *Zeros
008200101202     C                   When      N_WAIT =  1
008300101202     C                   When      N_WAIT =  30
008400101202     C                   When      N_WAIT =  60
008500101202     C                   When      N_WAIT =  90
008600101202     C                   When      N_WAIT =  120
008700101202     C                   When      N_WAIT =  150
008800101202     C                   When      N_WAIT =  180
008900101202     C                   Other
009000101202    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009100101202    ?C                   Move      WTM(7)        WWMSG                          EOF MSG
009200101202    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
009300101202     C                   Endsl
009400100617    ? *
009500100617    ? * Validate Effective Date
009600100617     C                   If        POEFFD <> *Zeros
009700100617     C                   Movel     POEFFD        Input_Date
009800100617     C                   Exsr      FMTDATE
009900100617     C                   If        Output_Error <> *Blanks
010000100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010100100617    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
010200100617    ?C                   Exsr      SNDMSG                                       SEND MSG
010300100617     C                   LeaveSR
010400100617     C                   End
010500100617     C                   Else
010600100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010700100617    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
010800100617    ?C                   Exsr      SNDMSG                                       SEND MSG
010900100617     C                   LeaveSR
011000100617     C                   End
011100100617    ? *
011200100617    ? * Validate Term Date
011300100617     C                   If        POTRMD <> *Zeros
011400100617     C                   Movel     POTRMD        Input_Date
011500100617     C                   Exsr      FMTDATE
011600100617     C                   If        Output_Error <> *Blanks
011700100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011800100617    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
011900100617    ?C                   Exsr      SNDMSG                                       SEND MSG
012000100617     C                   LeaveSR
012100100617     C                   End
012200100617     C                   End
012300100617    ? *
012400100617    ? * Validate Effective Date < Term Date
012500130326     C     POEFFD        mult      10000.0001    w80date1
012600130326     C     POTRMD        mult      10000.0001    w80date2
012700100617     C                   If        POEFFD <> *Zeros  and
012800100617     C                             POTRMD <> *Zeros
012900130326     C                   If        w80date1 > w80date2
013000100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013100100617    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
013200100617    ?C                   Exsr      SNDMSG                                       SEND MSG
013300100617     C                   LeaveSR
013400100617     C                   End
013500100617     C                   End
013600031215    ? *
013700010913    ?C                   Endsr                                                  END DLT RQST
013800000000    ? *___________________________________________________________________
013900000000    ? * Edit delete request
014000000000    ? *___________________________________________________________________
014100000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
014200100617    ? *
014300000000    ?C                   Endsr                                                  END DLT RQST
014400000000    ? *___________________________________________________________________
014500000000    ? * Default data
014600000000    ? *___________________________________________________________________
014700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
014800000000    ?C                   Endsr                                                  END DFT DATA
014900000000    ? *___________________________________________________________________
015000000000    ? * Send messages
015100000000    ? *___________________________________________________________________
015200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
015300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
015400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
015500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
015600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
015700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
015800000000    ?C                   Endsr                                                  END SND ERRMSG
015900000000    ? *___________________________________________________________________
016000000000    ? * Process error
016100000000    ? *___________________________________________________________________
016200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
016300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
016500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016600000000    ?C                   Endsr                                                  END PRCERR
016700000000    ? *___________________________________________________________________
016800000000    ? * Parameter list
016900000000    ? *___________________________________________________________________
017000000000    ?C     PLIST         Begsr                                                  PARM LISTS
017100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
017200000000    ?C                   Parm                    WIRQS             8            REQUEST
017300000000    ?C                   Parm                    WORTN             8            RETURN CODE
017400000614    ?C                   Parm                    WUDTA                          DATA
017500000000    ?C                   Endsr                                                  END PLIST
017600000000    ? *___________________________________________________________________
017700000000    ? * Define Variables and Key Lists
017800000000    ? *___________________________________________________________________
017900000000    ?C     DEFN          Begsr                                                  PARM LISTS
018000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
018100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
018200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
018300000000    ?C                   Endsr                                                  END DEFN
018400010914    ? *___________________________________________________________________
018500010914    ? * Key lists
018600010914    ? *___________________________________________________________________
018700010914    ?C     KLIST         Begsr                                                  KEY LISTS
018800100617     C     KEYACC        Klist
018900100617     C                   kfld                    POTRST
019000100617     C                   kfld                    POSUB#
019100100617     C                   kfld                    POACCT
019200100617     C     W_KEY         Klist
019300100617     C                   kfld                    PCTRST
019400100617     C                   kfld                    PCSUB#
019500100617     C                   kfld                    PCACCT
019600100617     C                   kfld                    POGRPR
019700010914    ?C                   Endsr
019800000000    ? *___________________________________________________________________
019900000000    ? * Program error handler
020000000000    ? *___________________________________________________________________
020100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
020200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
020300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
020400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
020500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
020600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
020700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
020800031215      *-------------------------------------------------------------------*
020900031215      * Format Date
021000031215      *-------------------------------------------------------------------*
021100031215     C     FMTDATE       Begsr
021200031215     C                   Eval      Input_Format  = 'MMDDYYYY'
021300031215     C                   Eval      Output_Format = 'MMDDYYYY'
021400031215     C                   Call      'FMTDATE'
021500031215     C                   Parm                    Input_Date       32
021600031215     C                   Parm                    Input_Format     32
021700031215     C                   Parm                    Output_Format    32
021800031215     C                   Parm                    Output_Date      32
021900031215     C                   Parm                    Output_Error     10
022000031215     C                   Endsr
022100000000    ? *___________________________________________________________________
022200000112** WTMP
02230000000000T-Record is not eligible for deletion.
02240010061700Request not supported by program CHKOPT.
022500000117** WTM
02260010061761Account Number is invalid
02270010061762Grouper Code must already exist (F4) prompt 1
02280010061762Grouper Code must already exist (F4) prompt 2
02290010061764Effective Date is invalid
02300010061765Term Date is invalid
02310010061764Effective Date is greater than Term Date
02320015062569Wait Days valid values 0,1,30,60,90,120,150,180
02330015062570Refund flag must be Y or N.
