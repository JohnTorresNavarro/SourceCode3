000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300080627    ? *  Description:  Check Payment Reversal Reason Codes
000400000000    ? *
000500080627    ? *  (c)Copyright 2008 by GBS, Inc.
000600000000    ? *___________________________________________________________________
001100000000    ? *
001200000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300010516    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700010220    ?D WUDTA         E DS                  EXTNAME(ISCOVR)
001800000810    ? *
001900000000    ? * Program status data structure
002000991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000    ? *___________________________________________________________________
002200000000    ? * Process check request
002300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002400000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002500000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002600000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002700000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002800000000    ?C                   Endcs                                                  END CASE
002900000000    ?C                   Return                                                 RETURN
003000000000    ? *___________________________________________________________________
003100000000    ? * Edit record
003200000000    ? *___________________________________________________________________
003300000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003400000810    ? *
003500000810    ? * Defualt Data
003600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
014800000810    ? *
014900000000    ?C                   Endsr                                                  END EDIT RECORD
015000010220    ? *___________________________________________________________________
015100010220    ? * format Date edit
015200010220    ? *___________________________________________________________________
015300010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
015400010220     C                   movel     'MMDDYYYY'    Input_Format
015500010220     C                   Call      'FMTDATE'
015600010220     C                   Parm                    Input_Date       32
015700010220     C                   Parm                    Input_Format     32
015800010220     C                   Parm                    Output_Format    32
015900010220     C                   Parm                    Output_Date      32
016000010220     C                   Parm                    Output_Error     10
016100010220    ?C                   Endsr                                                  END DLT RQST
016200000000    ? *___________________________________________________________________
016300000000    ? * Edit delete request
016400000000    ? *___________________________________________________________________
016500000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
016600000000    ?C                   Endsr                                                  END DLT RQST
016700000000    ? *___________________________________________________________________
016800000000    ? * Default data
016900000000    ? *___________________________________________________________________
017000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
017400000000    ?C                   Endsr                                                  END DFT DATA
017500000000    ? *___________________________________________________________________
017600000000    ? * Send messages
017700000000    ? *___________________________________________________________________
017800000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
017900000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
018000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
018100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
018200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
018300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
018400000000    ?C                   Endsr                                                  END SND ERRMSG
018500000000    ? *___________________________________________________________________
018600000000    ? * Process error
018700000000    ? *___________________________________________________________________
018800000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
018900000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019000000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
019100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019200000000    ?C                   Endsr                                                  END PRCERR
019300000000    ? *___________________________________________________________________
019400000000    ? * Parameter list
019500000000    ? *___________________________________________________________________
019600000000    ?C     PLIST         Begsr                                                  PARM LISTS
019700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
019800000000    ?C                   Parm                    WIRQS             8            REQUEST
019900000000    ?C                   Parm                    WORTN             8            RETURN CODE
020000000614    ?C                   Parm                    WUDTA                          DATA
020100000000    ?C                   Endsr                                                  END PLIST
020200000000    ? *___________________________________________________________________
020300000000    ? * Define Variables and Key Lists
020400000000    ? *___________________________________________________________________
020500000000    ?C     DEFN          Begsr                                                  PARM LISTS
020600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
020700000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
020800000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
020900000000    ?C                   Endsr                                                  END DEFN
021000000000    ? *___________________________________________________________________
021100000000    ? * Program error handler
021200000000    ? *___________________________________________________________________
021300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
021400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
021500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
021600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
021700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
021800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
021900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
022000000000    ? *___________________________________________________________________
022100000112** WTMP
02220000000000T-Record is not eligible for deletion.
02230008062700Request not supported by program CHKRVR.
022400000117** WTM
02250001022061Account must be valid.
02260001022062Plan must be valid.
02270001022363Internal Sales Type must be valid.
02280001022064Only one % or flat fee field must be entered.
02290001022065Pay Commissions must be Y or N.
02300001022066Effective Date must be valid.
02310001022067Term Date must be valid.
02320001022367Term Date Cannot be less than Effective Date.
02330001051668Internal Salesman must be valid.
