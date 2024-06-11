000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300101019    ? *  Description:  Check Pay Choice Date Ranges
000400000000    ? *
000500100520    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000601110613    ?FWEBPAYARC IF   E           K DISK
000602110613    ?FACCMST    IF   E           K DISK
000603110613    ?FMEMBER    IF   E           K DISK
000604110613    ?FPLNMST    IF   E           K DISK
000900000000    ? *
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100060303    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001101110110    ? *
001102110110     D WDATE1          s              8S 0 inz
001103110110     D WDATE2          s              8S 0 inz
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500110523    ?D WUDTA         E DS                  EXTNAME(WEBPAYARC)
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
003401110523    ? *
003402110613    ? * Validate TSA
003403110613     C     ACCKEY        Klist
003404110613     C                   kfld                    PQTRS
003405110613     C                   kfld                    PQSUB
003406110613     C                   kfld                    PQACT
003407110613     C     ACCKEY        Chain     ACCMST
003408110613     C                   If        not %found(ACCMST)
003409110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003410110613    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003411110613    ?C                   Exsr      SNDMSG                                       SEND MSG
003412110613     C                   End
003413110613    ? *
003414110613    ? * Validate SSN
003419110613     C     PQSSN         Chain     MEMBER
003420110613     C                   If        not %found(MEMBER)
003421110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003422110613    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
003423110613    ?C                   Exsr      SNDMSG                                       SEND MSG
003424110613     C                   End
003425110613    ? *
003426110613    ? * Validate Plan
003427110613     C     PLNKEY        Klist
003428110613     C                   kfld                    PQTRS
003429110613     C                   kfld                    PQSUB
003430110613     C                   kfld                    PQPLN
003431110613     C     PLNKEY        Chain     PLNMST
003432110613     C                   If        not %found(PLNMST)
003433110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003434110613    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
003435110613    ?C                   Exsr      SNDMSG                                       SEND MSG
003436110613     C                   Else
003437110613     C                   If        %trim(PQCAT) <> %trim(PLNCAT)
003438110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003439110613    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
003440110613    ?C                   Exsr      SNDMSG                                       SEND MSG
003441110613     C                   End
003442110613     C                   End
003443110613    ? *
003444110523    ? * Validate Effective Date
003445110523     C                   If        PQSTART <> *Zeros
003446110523     C                   Movel     PQSTART       Input_Date
003447110523     C                   Exsr      FMTDATE
003448110523     C                   If        Output_Error <> *Blanks
003449110523    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003450110613    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
003451110523    ?C                   Exsr      SNDMSG                                       SEND MSG
003452110523     C                   LeaveSR
003453110523     C                   End
003454110523     C                   Else
003455110523    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003456110613    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
003457110523    ?C                   Exsr      SNDMSG                                       SEND MSG
003458110523     C                   LeaveSR
003459110523     C                   End
003460110523    ? *
005800010913    ?C                   Endsr                                                  END DLT RQST
005900000000    ? *___________________________________________________________________
006000000000    ? * Edit delete request
006100000000    ? *___________________________________________________________________
006200000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
006201100617    ? *
006300000000    ?C                   Endsr                                                  END DLT RQST
006400000000    ? *___________________________________________________________________
006500000000    ? * Default data
006600000000    ? *___________________________________________________________________
006700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
006800000000    ?C                   Endsr                                                  END DFT DATA
006900000000    ? *___________________________________________________________________
007000000000    ? * Send messages
007100000000    ? *___________________________________________________________________
007200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
007300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
007400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
007500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
007600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
007700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
007800000000    ?C                   Endsr                                                  END SND ERRMSG
007900000000    ? *___________________________________________________________________
008000000000    ? * Process error
008100000000    ? *___________________________________________________________________
008200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
008300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
008500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
008600000000    ?C                   Endsr                                                  END PRCERR
008700000000    ? *___________________________________________________________________
008800000000    ? * Parameter list
008900000000    ? *___________________________________________________________________
009000000000    ?C     PLIST         Begsr                                                  PARM LISTS
009100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
009200000000    ?C                   Parm                    WIRQS             8            REQUEST
009300000000    ?C                   Parm                    WORTN             8            RETURN CODE
009400000614    ?C                   Parm                    WUDTA                          DATA
009500000000    ?C                   Endsr                                                  END PLIST
009600000000    ? *___________________________________________________________________
009700000000    ? * Define Variables and Key Lists
009800000000    ? *___________________________________________________________________
009900000000    ?C     DEFN          Begsr                                                  PARM LISTS
010000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
010100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
010200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010300000000    ?C                   Endsr                                                  END DEFN
010400010914    ? *___________________________________________________________________
010500010914    ? * Key lists
010600010914    ? *___________________________________________________________________
010700010914    ?C     KLIST         Begsr                                                  KEY LISTS
011200010914    ?C                   Endsr
011300000000    ? *___________________________________________________________________
011400000000    ? * Program error handler
011500000000    ? *___________________________________________________________________
011600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
011900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012300031215      *-------------------------------------------------------------------*
012400031215      * Format Date
012500031215      *-------------------------------------------------------------------*
012600031215     C     FMTDATE       Begsr
012700110523     C                   Eval      Input_Format  = 'MMDDYYYY'
012800031215     C                   Eval      Output_Format = 'MMDDYYYY'
012900031215     C                   Call      'FMTDATE'
013000031215     C                   Parm                    Input_Date       32
013100031215     C                   Parm                    Input_Format     32
013200031215     C                   Parm                    Output_Format    32
013300031215     C                   Parm                    Output_Date      32
013400031215     C                   Parm                    Output_Error     10
013500031215     C                   Endsr
013600000000    ? *___________________________________________________________________
013700000112** WTMP
01380000000000T-Record is not eligible for deletion.
01390011052300Request not supported by program CHKDED.
014000000117** WTM
01400111061361Account is invalid.
01400211061362Member  is invalid.
01400311061363Plan is invalid.
01400411061364Plan Cat is invalid.
01410011061365Start Date is invalid.
