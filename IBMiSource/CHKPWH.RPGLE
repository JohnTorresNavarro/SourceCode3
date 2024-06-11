000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020306    ? *  Description:  Check Password Validation User Profile Header
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *___________________________________________________________________
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900020306    ?D WTM             S             80    DIM(2) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300020306    ?D WUDTA         E DS                  EXTNAME(PWVHDR)
001400000810    ? *
001500000000    ? * Program status data structure
001600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001700000000    ? *___________________________________________________________________
001800000000    ? * Process check request
001900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002000000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002100000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002200000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002300000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002400000000    ?C                   Endcs                                                  END CASE
002500000000    ?C                   Return                                                 RETURN
002600000000    ? *___________________________________________________________________
002700000000    ? * Edit record
002800000000    ? *___________________________________________________________________
002900000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003000000810    ? *
003100000810    ? * Defualt Data
003200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003300010219    ? *
003400020306    ? * User Must be entered.
003500020306     C                   If        PHUSER   =   *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003900020227     C                   End
004000020306    ? *
004100020306    ? * User Description Must be entered.
004200020306     C                   If        PHDESC   =   *BLANKS
004300020306    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400020306    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500020306    ?C                   Exsr      SNDMSG                                       SEND MSG
004600020306     C                   End
004700020306    ? *
004800010220    ? *
004900000000    ?C                   Endsr                                                  END EDIT RECORD
005000000000    ? *___________________________________________________________________
005100000000    ? * Edit delete request
005200000000    ? *___________________________________________________________________
005300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
005400000000    ?C                   Endsr                                                  END DLT RQST
005500000000    ? *___________________________________________________________________
005600000000    ? * Default data
005700000000    ? *___________________________________________________________________
005800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
005900000000    ?C                   Endsr                                                  END DFT DATA
006000000000    ? *___________________________________________________________________
006100000000    ? * Send messages
006200000000    ? *___________________________________________________________________
006300000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
006400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
006500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
006600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
006700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
006800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
006900000000    ?C                   Endsr                                                  END SND ERRMSG
007000000000    ? *___________________________________________________________________
007100000000    ? * Process error
007200000000    ? *___________________________________________________________________
007300000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
007400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
007600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
007700000000    ?C                   Endsr                                                  END PRCERR
007800000000    ? *___________________________________________________________________
007900000000    ? * Parameter list
008000000000    ? *___________________________________________________________________
008100000000    ?C     PLIST         Begsr                                                  PARM LISTS
008200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
008300000000    ?C                   Parm                    WIRQS             8            REQUEST
008400000000    ?C                   Parm                    WORTN             8            RETURN CODE
008500000614    ?C                   Parm                    WUDTA                          DATA
008600000000    ?C                   Endsr                                                  END PLIST
008700000000    ? *___________________________________________________________________
008800000000    ? * Define Variables and Key Lists
008900000000    ? *___________________________________________________________________
009000000000    ?C     DEFN          Begsr                                                  PARM LISTS
009100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
009200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
009300000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
009400000000    ?C                   Endsr                                                  END DEFN
009500000000    ? *___________________________________________________________________
009600000000    ? * Program error handler
009700000000    ? *___________________________________________________________________
009800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
009900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
010000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
010100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
010200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
010300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
010400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
010500000000    ? *___________________________________________________________________
010600000112** WTMP
01070000000000T-Record is not eligible for deletion.
01080002030600Request not supported by program CHKPWH.
010900000117** WTM
01100002030661User Profile must be entered.
01110002030662User Description must be entered.
