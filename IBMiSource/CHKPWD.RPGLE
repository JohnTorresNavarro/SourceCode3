000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020306    ? *  Description:  Check PassWord Validation User Details
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *___________________________________________________________________
000700020306     FPWVMNU    IF   E           K DISK
000800000000    ? *
000900000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001000020307    ?D WTM             S             80    DIM(5) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001100000000    ? *___________________________________________________________________
001200000000    ? *
001300000614    ? * Data structure
001400020306    ?D WUDTA         E DS                  EXTNAME(PWVDTL)
001500020307    ?D WQDTA         E DS                  EXTNAME(PWVHDR) PREFIX(Q)
001600000810    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *___________________________________________________________________
002000000000    ? * Process check request
002100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002200000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002300000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002400000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002500000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002600000000    ?C                   Endcs                                                  END CASE
002700000000    ?C                   Return                                                 RETURN
002800000000    ? *___________________________________________________________________
002900000000    ? * Edit record
003000000000    ? *___________________________________________________________________
003100000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003200000810    ? *
003300000810    ? * Defualt Data
003400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003500010219    ? *
003600020306    ? * Menu Must be entered.
003700020306     C                   If        PDMENU   =   *BLANKS
003800010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003900020306    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004000010219    ?C                   Exsr      SNDMSG                                       SEND MSG
004100020227     C                   End
004200020306    ? *
004300020306    ? * Menu Option must be entered.
004400020306     C                   If        PDOPTN   =   *ZEROS
004500020306    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004600020306    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004700020306    ?C                   Exsr      SNDMSG                                       SEND MSG
004800020306     C                   End
004900020306    ? *
005000020306    ? * Menu Option must be entered.
005100020306     C                   If        PDMENU   <>  *BLANKS and
005200020306     C                             PDOPTN   <>  *ZEROS
005300020307    ? * Menu Option must be valid for this user/dept.
005400020307     C     WKMNU         Chain     PWVMNU
005500020307    ?C                   If        not %Found                                   ENDIF
005600020307    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005700020307    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005800020307    ?C                   Exsr      SNDMSG                                       SEND MSG
005900020307    ?C                   Else                                                   ENDIF
006000020307    ?C                   If        QPHDEPT <>    PMDEPT and                     ENDIF
006100020307    ?C                             QPHDEPT <>    *BLANKS                        ENDIF
006200020307    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006300020307    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006400020307    ?C                   Exsr      SNDMSG                                       SEND MSG
006500020307    ?C                   End                                                    ENDIF
006600020307    ?C                   End                                                    ENDIF
006700020307    ?C                   End                                                    ENDIF
006800010220    ? *
006900000000    ?C                   Endsr                                                  END EDIT RECORD
007000000000    ? *___________________________________________________________________
007100000000    ? * Edit delete request
007200000000    ? *___________________________________________________________________
007300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007400000000    ?C                   Endsr                                                  END DLT RQST
007500000000    ? *___________________________________________________________________
007600000000    ? * Default data
007700000000    ? *___________________________________________________________________
007800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
007900020307     C                   Exsr      GetCurUsrDpt
008000000000    ?C                   Endsr                                                  END DFT DATA
008100000000    ? *___________________________________________________________________
008200000000    ? * Send messages
008300000000    ? *___________________________________________________________________
008400000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
008500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
009000000000    ?C                   Endsr                                                  END SND ERRMSG
009100000000    ? *___________________________________________________________________
009200000000    ? * Process error
009300000000    ? *___________________________________________________________________
009400000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
009500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009800000000    ?C                   Endsr                                                  END PRCERR
009900000000    ? *___________________________________________________________________
010000000000    ? * Parameter list
010100000000    ? *___________________________________________________________________
010200000000    ?C     PLIST         Begsr                                                  PARM LISTS
010300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
010400000000    ?C                   Parm                    WIRQS             8            REQUEST
010500000000    ?C                   Parm                    WORTN             8            RETURN CODE
010600000614    ?C                   Parm                    WUDTA                          DATA
010700000000    ?C                   Endsr                                                  END PLIST
010800000000    ? *___________________________________________________________________
010900000000    ? * Define Variables and Key Lists
011000000000    ? *___________________________________________________________________
011100000000    ?C     DEFN          Begsr                                                  PARM LISTS
011200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
011300020307    ?C     *LIKE         Define    WIRQS         WQRQS                          REQUEST CODE
011400000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
011500020307    ?C     *LIKE         Define    WORTN         WQRTN                          RETURN CODE
011600000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
011700020306     C     WKMNU         Klist
011800020306     C                   Kfld                    PDMENU
011900020306     C                   Kfld                    PDOPTN
012000000000    ?C                   Endsr                                                  END DEFN
012100020307    ? *___________________________________________________________________
012200020307    ? * Get Current User Department
012300020307    ? *___________________________________________________________________
012400020307    ?C     GetCurUsrDpt  Begsr                                                  PROGRAM ERROR
012500020307     C                   Eval      QPHUSER  =    WQUSRN
012600020307    ?C                   Call      'UPDPWH  '                                   PROCESS REC IO
012700020307    ?C                   Parm      'GETNL   '    WQRQS                          GET RECORD
012800020307    ?C                   Parm                    WQRTN                          RETURN CODE
012900020307    ?C                   Parm                    WQDTA                          REC DATA
013000020307    ?C                   Endsr                                                  END PGM ERROR
013100000000    ? *___________________________________________________________________
013200000000    ? * Program error handler
013300000000    ? *___________________________________________________________________
013400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
013500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
013600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
013700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
013800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
013900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
014000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
014100000000    ? *___________________________________________________________________
014200000112** WTMP
01430000000000T-Record is not eligible for deletion.
01440002030600Request not supported by program CHKPWD.
014500000117** WTM
01460002030661Menu must be entered.
01470002030662Option must be entered.
01480002030761Menu/Option combo must be valid.
01490002030761Menu/Option not valid for this user profile/dept.
