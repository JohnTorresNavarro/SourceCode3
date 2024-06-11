000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010220    ? *  Description:  Check Internal Sales Commission Type
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *___________________________________________________________________
000700020227     FCARMST    IF   E           K DISK
000800000000    ? *
000900000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001000020227    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001100000000    ? *___________________________________________________________________
001200000000    ? *
001300000614    ? * Data structure
001400020227    ?D WUDTA         E DS                  EXTNAME(ISCPZC)
001500000810    ? *
001600000000    ? * Program status data structure
001700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001800000000    ? *___________________________________________________________________
001900000000    ? * Process check request
002000000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002100000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002200000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002300000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002400000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002500000000    ?C                   Endcs                                                  END CASE
002600000000    ?C                   Return                                                 RETURN
002700000000    ? *___________________________________________________________________
002800000000    ? * Edit record
002900000000    ? *___________________________________________________________________
003000000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003100000810    ? *
003200000810    ? * Defualt Data
003300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003400010219    ? *
003500020227    ? * CARRIER
003600020227     C                   If        IZCAR  = *BLANKS
003700010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003800010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003900010219    ?C                   Exsr      SNDMSG                                       SEND MSG
004000020227     C                   Else
004100020227     C     IZCAR         Chain     CARMST
004200020227     C                   if        not %Found
004300020227    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400020227    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004500020227    ?C                   Exsr      SNDMSG                                       SEND MSG
004600020227     C                   End
004700020227     C                   End
004800010220    ? *
004900020227    ? * PERCENT OF PREMIUM
005000020227     C                   If        IZPPRM = *ZEROS and
005100020227     C                             IZPCPM = *ZEROS
005200020227    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005300020227    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005400020227    ?C                   Exsr      SNDMSG                                       SEND MSG
005500020227     C                   end
005600020227    ? *
005700020227    ? * PERCENT OF PREMIUM
005800020227     C                   If        IZPPRM <> *ZEROS and
005900020227     C                             IZPCPM <> *ZEROS
006000020227    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006100020227    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006200020227    ?C                   Exsr      SNDMSG                                       SEND MSG
006300020227     C                   end
006400000810    ? *
006500000000    ?C                   Endsr                                                  END EDIT RECORD
006600010220    ? *___________________________________________________________________
006700010220    ? * format Date edit
006800010220    ? *___________________________________________________________________
006900010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007000010220     C                   movel     'MMDDYYYY'    Input_Format
007100010220     C                   Call      'FMTDATE'
007200010220     C                   Parm                    Input_Date       32
007300010220     C                   Parm                    Input_Format     32
007400010220     C                   Parm                    Output_Format    32
007500010220     C                   Parm                    Output_Date      32
007600010220     C                   Parm                    Output_Error     10
007700010220    ?C                   Endsr                                                  END DLT RQST
007800000000    ? *___________________________________________________________________
007900000000    ? * Edit delete request
008000000000    ? *___________________________________________________________________
008100000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
008200000000    ?C                   Endsr                                                  END DLT RQST
008300000000    ? *___________________________________________________________________
008400000000    ? * Default data
008500000000    ? *___________________________________________________________________
008600000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
008700000000    ?C                   Endsr                                                  END DFT DATA
008800000000    ? *___________________________________________________________________
008900000000    ? * Send messages
009000000000    ? *___________________________________________________________________
009100000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
009200000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
009300000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
009400000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
009500000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
009600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
009700000000    ?C                   Endsr                                                  END SND ERRMSG
009800000000    ? *___________________________________________________________________
009900000000    ? * Process error
010000000000    ? *___________________________________________________________________
010100000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
010200000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010300000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
010400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
010500000000    ?C                   Endsr                                                  END PRCERR
010600000000    ? *___________________________________________________________________
010700000000    ? * Parameter list
010800000000    ? *___________________________________________________________________
010900000000    ?C     PLIST         Begsr                                                  PARM LISTS
011000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
011100000000    ?C                   Parm                    WIRQS             8            REQUEST
011200000000    ?C                   Parm                    WORTN             8            RETURN CODE
011300000614    ?C                   Parm                    WUDTA                          DATA
011400000000    ?C                   Endsr                                                  END PLIST
011500000000    ? *___________________________________________________________________
011600000000    ? * Define Variables and Key Lists
011700000000    ? *___________________________________________________________________
011800000000    ?C     DEFN          Begsr                                                  PARM LISTS
011900000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
012000000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
012100000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
012200000000    ?C                   Endsr                                                  END DEFN
012300000000    ? *___________________________________________________________________
012400000000    ? * Program error handler
012500000000    ? *___________________________________________________________________
012600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
012700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
012800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
012900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
013000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
013100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
013200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
013300000000    ? *___________________________________________________________________
013400000112** WTMP
01350000000000T-Record is not eligible for deletion.
01360002022700Request not supported by program CHKPZC.
013700000117** WTM
01380002022761Carrier must be valid.
01390002022762Either Percent of Premium or Flat Fee must be entered.
01400002022763Both Percent of Premium and Flat Fee cannot be entered.
