000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300120612    ? *  Description:  Check Senior Dental Writeoff Balance
000400000000    ? *
000500120612    ? *  (c)Copyright 2012 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000601070516    ? *
000900050318    ? *___________________________________________________________________
001000120612    ?FACCSWB    IF   E           K DISK
001001090520     FACCMST    IF   E           K Disk
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300110210    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700120612    ?D WUDTA         E DS                  EXTNAME(ACCSWB)
002100000810    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000    ? *___________________________________________________________________
003200000000    ? * Process check request
003300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003400000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003500000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003600000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003700000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003800000000    ?C                   Endcs                                                  END CASE
003900000000    ?C                   Return                                                 RETURN
004000000000    ? *___________________________________________________________________
004100000000    ? * Edit record
004200000000    ? *___________________________________________________________________
004300000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
004400000810    ? *
004500000810    ? * Defualt Data
004600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
006900000810    ? *
006903090520     C     AKey          Chain     ACCMST
006920050318     C                   If        Output_Error <> *Blanks
006921050318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006922090224    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006923050318    ?C                   Exsr      SNDMSG                                       SEND MSG
006924050318     C                   Endif
006926010301    ? *
007005000000    ?C                   Endsr                                                  END EDIT RECORD
007006010301    ? *___________________________________________________________________
007007010301    ? * format Date edit
007008010301    ? *___________________________________________________________________
007009010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007010010301     C                   movel     'MMDDYYYY'    Input_Format
007011010301     C                   Call      'FMTDATE'
007012010301     C                   Parm                    Input_Date       32
007013010301     C                   Parm                    Input_Format     32
007014010301     C                   Parm                    Output_Format    32
007015010301     C                   Parm                    Output_Date      32
007016010301     C                   Parm                    Output_Error     10
007017010301    ?C                   Endsr                                                  END DLT RQST
007100000000    ? *___________________________________________________________________
007200000000    ? * Edit delete request
007300000000    ? *___________________________________________________________________
007400000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007500000000    ?C                   Endsr                                                  END DLT RQST
007600000000    ? *___________________________________________________________________
007700000000    ? * Default data
007800000000    ? *___________________________________________________________________
007900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
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
010701090520      *
010702090520    ?C     KLIST         Begsr                                                  KEY LISTS
010703090520    ?C     AKey          Klist                                                  ACKCTL
010704120612    ?C                   Kfld                    SWTRST
010705120612    ?C                   Kfld                    SWSUB#
010706120612    ?C                   Kfld                    SWACCT                         POSITION TO 1
010707090520    ?C                   Endsr                                                  END PLIST
010800000000    ? *___________________________________________________________________
010900000000    ? * Define Variables and Key Lists
011000000000    ? *___________________________________________________________________
011100000000    ?C     DEFN          Begsr                                                  PARM LISTS
011200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
011300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
011400000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
011500000000    ?C                   Endsr                                                  END DEFN
011600000000    ? *___________________________________________________________________
011700000000    ? * Program error handler
011800000000    ? *___________________________________________________________________
011900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
012000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
012100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
012200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012600000000    ? *___________________________________________________________________
012700000112** WTMP
01280000000000T-Record is not eligible for deletion.
01290012061200Request not supported by program CHKSWB
013000000117** WTM
01310012061261Balance must be a valid amount.
01330012061262
01340012061263
01350012061264
01360012061264
01370012061265
01380012061266
01390012061267
01400012061268
01410012061269
