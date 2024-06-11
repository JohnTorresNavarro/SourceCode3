000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300111216    ? *  Description:  Check Pay Period Start Dates
000400000000    ? *
000500111216    ? *  (c)Copyright 2011 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000700140326    ?FCFS100P   IF   E           K DISK
000800140326     FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER')
000900140326     FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC')
001000000000    ? *
001100010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200060303    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001300110110    ? *
001400110110     D WDATE1          s              8S 0 inz
001500110110     D WDATE2          s              8S 0 inz
001600000000    ? *___________________________________________________________________
001700000000    ? *
001800000614    ? * Data structure
001900140326    ?D WUDTA         E DS                  EXTNAME(CFS100P)
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
004000140326    ? * Check SSN
004100140326     C     CFSSN         Chain     MEMBER
004200140326     C                   if        not %found(MEMBER)
004300100617    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400100617    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004500100617    ?C                   Exsr      SNDMSG                                       SEND MSG
004600140326     C                   LeaveSR
004700100617     C                   End
004800140326    ? *
004900140326    ? * Check Dependent Seq
005000140326     C                   If        CFSEQ <> 0
005100140326     C     DPKEY         klist
005200140326     C                   kfld                    CFSSN
005300140326     C                   kfld                    CFSEQ
005400140326     C     DPKEY         Chain     DEPNDC
005500140326     C                   if        not %found(DEPNDC)
005600140326    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005700140326    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005800140326    ?C                   Exsr      SNDMSG                                       SEND MSG
005900140326     C                   LeaveSR
006000140326     C                   End
006100140326     C                   End
006200140326    ? *
006300140326    ? * First Name
006400140326     C                   If        %trim(CFSFST) = *blanks
006500111216    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006600140326    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006700111216    ?C                   Exsr      SNDMSG                                       SEND MSG
006800111216     C                   LeaveSR
006900111219     C                   Endif
007000100617    ? *
007100140326    ? * Last Name
007200140326     C                   If        %trim(CFSLST) = *blanks
007300140326    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007400140326    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007500140326    ?C                   Exsr      SNDMSG                                       SEND MSG
007600140326     C                   LeaveSR
007700140326     C                   Endif
007800031215    ? *
007900010913    ?C                   Endsr                                                  END DLT RQST
008000000000    ? *___________________________________________________________________
008100000000    ? * Edit delete request
008200000000    ? *___________________________________________________________________
008300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
008400100617    ? *
008500000000    ?C                   Endsr                                                  END DLT RQST
008600000000    ? *___________________________________________________________________
008700000000    ? * Default data
008800000000    ? *___________________________________________________________________
008900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
009000000000    ?C                   Endsr                                                  END DFT DATA
009100000000    ? *___________________________________________________________________
009200000000    ? * Send messages
009300000000    ? *___________________________________________________________________
009400000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
009500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
009600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
009700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
009800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
009900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
010000000000    ?C                   Endsr                                                  END SND ERRMSG
010100000000    ? *___________________________________________________________________
010200000000    ? * Process error
010300000000    ? *___________________________________________________________________
010400000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
010500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
010700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
010800000000    ?C                   Endsr                                                  END PRCERR
010900000000    ? *___________________________________________________________________
011000000000    ? * Parameter list
011100000000    ? *___________________________________________________________________
011200000000    ?C     PLIST         Begsr                                                  PARM LISTS
011300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
011400000000    ?C                   Parm                    WIRQS             8            REQUEST
011500000000    ?C                   Parm                    WORTN             8            RETURN CODE
011600000614    ?C                   Parm                    WUDTA                          DATA
011700000000    ?C                   Endsr                                                  END PLIST
011800000000    ? *___________________________________________________________________
011900000000    ? * Define Variables and Key Lists
012000000000    ? *___________________________________________________________________
012100000000    ?C     DEFN          Begsr                                                  PARM LISTS
012200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
012300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
012400000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
012500000000    ?C                   Endsr                                                  END DEFN
012600010914    ? *___________________________________________________________________
012700010914    ? * Key lists
012800010914    ? *___________________________________________________________________
012900010914    ?C     KLIST         Begsr                                                  KEY LISTS
013000010914    ?C                   Endsr
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
014100031215      *-------------------------------------------------------------------*
014200031215      * Format Date
014300031215      *-------------------------------------------------------------------*
014400031215     C     FMTDATE       Begsr
014500031215     C                   Eval      Input_Format  = 'MMDDYYYY'
014600031215     C                   Eval      Output_Format = 'MMDDYYYY'
014700031215     C                   Call      'FMTDATE'
014800031215     C                   Parm                    Input_Date       32
014900031215     C                   Parm                    Input_Format     32
015000031215     C                   Parm                    Output_Format    32
015100031215     C                   Parm                    Output_Date      32
015200031215     C                   Parm                    Output_Error     10
015300031215     C                   Endsr
015400000000    ? *___________________________________________________________________
015500000112** WTMP
01560000000000T-Record is not eligible for deletion.
01570014032600Request not supported by program CHK100.
015800000117** WTM
01590014032661Invalid SSN.  Member not found.
01600014032661Invalid SSN/SEQ.  Dependent not found.
01610014032662First Name is required.
01620014032663Last Name is required.
