000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300070216    ? *  Description:  Market Exclude Account File
000400000000    ? *
000500070216    ? *  (c)Copyright 2007 by GBS, Inc.
000600070216    ? *  This document contains restricted materials of GBS, Inc.
000700000000    ? *___________________________________________________________________
000800070216    ?FMKTRNE    IF   E           K DISK
001000060712    ?FACCMST    IF   E           K DISK
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300070216    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700070216    ?D WUDTA         E DS                  EXTNAME(MKTRNE)
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
003700010219    ? *
003800061127    ? * Check
003900070216     C     MEEEDT        Ifeq      *Zeros
004000010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004100010914    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004200010914    ?C                   Exsr      SNDMSG                                       SEND MSG
005400010914     C                   Endif
005500060712    ? *
005600060712    ? * Check Account
005700070216     C                   If        METRST <> 0 or
005800070216     C                             MESUB# <> 0 or
005900070216     C                             MEACCT <> 0
006000060712     C     ACCKEY        klist
006100070216     C                   kfld                    METRST
006200070216     C                   kfld                    MESUB#
006300070216     C                   kfld                    MEACCT
006400060712     C     ACCKEY        Chain     ACCMST
006500060712     C                   if        not %found(ACCMST)
006600060712    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006700070216    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006800060712    ?C                   Exsr      SNDMSG                                       SEND MSG
006900060712     C                   End
007000060712     C                   End
007826061127    ? *
007827070216    ? * Exclude Date
007828070216     C                   If        MEEEDT <> *ZEROS
007829070216     C                   movel     MEEEDT        Input_Date
007830061127     C                   Exsr      EDTDAT
007831061127     C                   If        Output_Error <> *Blanks
007832061127    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007833070216    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
007834061127    ?C                   Exsr      SNDMSG                                       SEND MSG
007848061127     C                   Endif
007849061127     C                   Endif
007850061127    ? *
007851061127    ? *
007900010913    ?C                   Endsr                                                  END DLT RQST
008000010301    ? *___________________________________________________________________
008100010301    ? * format Date edit
008200010301    ? *___________________________________________________________________
008300010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
008400010301     C                   movel     'MMDDYYYY'    Input_Format
008500010301     C                   Call      'FMTDATE'
008600010301     C                   Parm                    Input_Date       32
008700010301     C                   Parm                    Input_Format     32
008800010301     C                   Parm                    Output_Format    32
008900010301     C                   Parm                    Output_Date      32
009000010301     C                   Parm                    Output_Error     10
009100010301    ?C                   Endsr                                                  END DLT RQST
009200000000    ? *___________________________________________________________________
009300000000    ? * Edit delete request
009400000000    ? *___________________________________________________________________
009500000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
009600000000    ?C                   Endsr                                                  END DLT RQST
009700000000    ? *___________________________________________________________________
009800000000    ? * Default data
009900000000    ? *___________________________________________________________________
010000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
010800000000    ?C                   Endsr                                                  END DFT DATA
010900000000    ? *___________________________________________________________________
011000000000    ? * Send messages
011100000000    ? *___________________________________________________________________
011200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
011300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
011400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
011500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
011600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
011700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
011800000000    ?C                   Endsr                                                  END SND ERRMSG
011900000000    ? *___________________________________________________________________
012000000000    ? * Process error
012100000000    ? *___________________________________________________________________
012200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
012300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
012500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
012600000000    ?C                   Endsr                                                  END PRCERR
012700000000    ? *___________________________________________________________________
012800000000    ? * Parameter list
012900000000    ? *___________________________________________________________________
013000000000    ?C     PLIST         Begsr                                                  PARM LISTS
013100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
013200000000    ?C                   Parm                    WIRQS             8            REQUEST
013300000000    ?C                   Parm                    WORTN             8            RETURN CODE
013400000614    ?C                   Parm                    WUDTA                          DATA
013500000000    ?C                   Endsr                                                  END PLIST
013600000000    ? *___________________________________________________________________
013700000000    ? * Define Variables and Key Lists
013800000000    ? *___________________________________________________________________
013900000000    ?C     DEFN          Begsr                                                  PARM LISTS
014000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
014100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
014200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
014300000000    ?C                   Endsr                                                  END DEFN
014400000000    ? *___________________________________________________________________
014500000000    ? * Program error handler
014600000000    ? *___________________________________________________________________
014700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
014800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
014900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
015000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
015100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
015200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
015300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
015400000000    ? *___________________________________________________________________
015500000112** WTMP
01560007021600Record is not eligible for deletion.
01570007021600Request not supported by program CHKMKE.
015800000117** WTM
01590007021661Exclude Date must be entered.
01610006071263Please enter a valid account.
01610407021666Exclude Date must be valid.
