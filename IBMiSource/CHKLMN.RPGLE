000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040115    ? *  Description:  Check Broker Licensing Salesperson File
000400000000    ? *
000500040115    ? *  (c)Copyright 2004 by Group Benefit Services, Inc.
000600000000    ? *___________________________________________________________________
000601040203    ?FBLILMANL1 IF   E           K DISK
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900010522    ?D WTM             S             80    DIM(7) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300030811    ?D WUDTA         E DS                  EXTNAME(BLILSM)
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
003400030811    ? * SALESMAN
003500030811     C                   If        LSSMAN = *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003801030811     C                   Else
003802040203     C     LSSMAN        Chain     BLILMANL1
003803030811     C                   IF        not %Found
003804030811    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003805030811    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003806030811    ?C                   Exsr      SNDMSG                                       SEND MSG
003807030811     C                   Endif
003900010219     C                   Endif
003901040203    ? *
010500000000    ?C                   Endsr                                                  END EDIT RECORD
010600010220    ? *___________________________________________________________________
010700010220    ? * format Date edit
010800010220    ? *___________________________________________________________________
010900010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
011000010220     C                   movel     'MMDDYYYY'    Input_Format
011100010220     C                   Call      'FMTDATE'
011200010220     C                   Parm                    Input_Date       32
011300010220     C                   Parm                    Input_Format     32
011400010220     C                   Parm                    Output_Format    32
011500010220     C                   Parm                    Output_Date      32
011600010220     C                   Parm                    Output_Error     10
011700010220    ?C                   Endsr                                                  END DLT RQST
011800000000    ? *___________________________________________________________________
011900000000    ? * Edit delete request
012000000000    ? *___________________________________________________________________
012100000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
012200000000    ?C                   Endsr                                                  END DLT RQST
012300000000    ? *___________________________________________________________________
012400000000    ? * Default data
012500000000    ? *___________________________________________________________________
012600000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
012700000000    ?C                   Endsr                                                  END DFT DATA
012800000000    ? *___________________________________________________________________
012900000000    ? * Send messages
013000000000    ? *___________________________________________________________________
013100000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
013200000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
013300000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
013400000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
013500000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
013600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
013700000000    ?C                   Endsr                                                  END SND ERRMSG
013800000000    ? *___________________________________________________________________
013900000000    ? * Process error
014000000000    ? *___________________________________________________________________
014100000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
014200000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014300000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
014400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
014500000000    ?C                   Endsr                                                  END PRCERR
014600000000    ? *___________________________________________________________________
014700000000    ? * Parameter list
014800000000    ? *___________________________________________________________________
014900000000    ?C     PLIST         Begsr                                                  PARM LISTS
015000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
015100000000    ?C                   Parm                    WIRQS             8            REQUEST
015200000000    ?C                   Parm                    WORTN             8            RETURN CODE
015300000614    ?C                   Parm                    WUDTA                          DATA
015400000000    ?C                   Endsr                                                  END PLIST
015500000000    ? *___________________________________________________________________
015600000000    ? * Define Variables and Key Lists
015700000000    ? *___________________________________________________________________
015800000000    ?C     DEFN          Begsr                                                  PARM LISTS
015900000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
016000000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
016100000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
016200000000    ?C                   Endsr                                                  END DEFN
016300000000    ? *___________________________________________________________________
016400000000    ? * Program error handler
016500000000    ? *___________________________________________________________________
016600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
016700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
016800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
016900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
017000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
017100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
017200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
017300000000    ? *___________________________________________________________________
017400000112** WTMP
01750000000000T-Record is not eligible for deletion.
01760003081100Request not supported by program CHKLSM.
017700000117** WTM
01780003081161Salesman must be valid.
01790003071662State must be entered.
01800003071663License must be entered.
01810003072264Effective Date must be valid.
01820003072265Expire Date must be valid.
01830003072264Expire Date must be > Effective Date.
01840003072266Business Type must be (L)ife, (H)ealth, or (B)oth.
