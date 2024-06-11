000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020306    ? *  Description:  Check Password Validation Menu Options
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *___________________________________________________________________
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900020307    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300020306    ?D WUDTA         E DS                  EXTNAME(PWVMNU)
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
003400020306    ? * Menu Must be entered.
003500020306     C                   If        PMMENU   =   *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003900020227     C                   End
004000020306    ? *
004100020306    ? * Menu Option must be entered.
004200020306     C                   If        PMOPTN   =   *ZEROS
004300020306    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400020306    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500020306    ?C                   Exsr      SNDMSG                                       SEND MSG
004600020306     C                   End
004700020306    ? *
004800020306    ? * Menu Option Description Must be entered.
004900020306     C                   If        PMDESC   =   *BLANKS
005000020306    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005100020306    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005200020306    ?C                   Exsr      SNDMSG                                       SEND MSG
005300020306     C                   End
005400020307    ? *
005500020307    ? * Menu Option Department Must be valid.
005600020307     C                   Select
005700020307     C                   When      PMDEPT   <>  'FIN'   and
005800020307     C                             PMDEPT   <>  'E+B'   and
005900020307     C                             PMDEPT   <>  'MKT'   and
006000020307     C                             PMDEPT   <>  'OPS'   and
006100020307     C                             PMDEPT   <>  'MSC'
006200020307    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006300020307    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006400020307    ?C                   Exsr      SNDMSG                                       SEND MSG
006500020307     C                   Endsl
006600020306    ? *
006700010220    ? *
006800000000    ?C                   Endsr                                                  END EDIT RECORD
006900000000    ? *___________________________________________________________________
007000000000    ? * Edit delete request
007100000000    ? *___________________________________________________________________
007200000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007300000000    ?C                   Endsr                                                  END DLT RQST
007400000000    ? *___________________________________________________________________
007500000000    ? * Default data
007600000000    ? *___________________________________________________________________
007700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
007800000000    ?C                   Endsr                                                  END DFT DATA
007900000000    ? *___________________________________________________________________
008000000000    ? * Send messages
008100000000    ? *___________________________________________________________________
008200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
008300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
008800000000    ?C                   Endsr                                                  END SND ERRMSG
008900000000    ? *___________________________________________________________________
009000000000    ? * Process error
009100000000    ? *___________________________________________________________________
009200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
009300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009600000000    ?C                   Endsr                                                  END PRCERR
009700000000    ? *___________________________________________________________________
009800000000    ? * Parameter list
009900000000    ? *___________________________________________________________________
010000000000    ?C     PLIST         Begsr                                                  PARM LISTS
010100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
010200000000    ?C                   Parm                    WIRQS             8            REQUEST
010300000000    ?C                   Parm                    WORTN             8            RETURN CODE
010400000614    ?C                   Parm                    WUDTA                          DATA
010500000000    ?C                   Endsr                                                  END PLIST
010600000000    ? *___________________________________________________________________
010700000000    ? * Define Variables and Key Lists
010800000000    ? *___________________________________________________________________
010900000000    ?C     DEFN          Begsr                                                  PARM LISTS
011000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
011100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
011200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
011300000000    ?C                   Endsr                                                  END DEFN
011400000000    ? *___________________________________________________________________
011500000000    ? * Program error handler
011600000000    ? *___________________________________________________________________
011700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
012000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012400000000    ? *___________________________________________________________________
012500000112** WTMP
01260000000000T-Record is not eligible for deletion.
01270002022700Request not supported by program CHKPZC.
012800000117** WTM
01290002030661Menu must be entered.
01300002030662Option must be entered.
01310002030663Option Description must be entered.
01320002030764Department must be valid.
