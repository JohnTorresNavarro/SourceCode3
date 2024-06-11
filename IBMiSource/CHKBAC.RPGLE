000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040219    ? *  Description:  Check Broker Representative Table
000400000000    ? *
000500040219    ? *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700110504      * 05/04/2011.SSK.CHANGE FROM GROUPER TO SMAN2
000800000000    ? *___________________________________________________________________
000900040220    ?FBRKACON   IF   E           K DISK
001000110504     fSMAN2L    if   e           k disk
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300040325    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700040220    ?D WUDTA         E DS                  EXTNAME(BRKACON)
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
003500040220    ? * Check ID
003600040220     C     BRAID         Ifeq      *Zeros
003700010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003800010914    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003900010914    ?C                   Exsr      SNDMSG                                       SEND MSG
004000010914     C                   Endif
004100040220    ? *
004200040927      * Check Grouper
004300040924     c                   if        bragrp = *blanks or bragrp = '00000'
004400040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004500040220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004600040220    ?C                   Exsr      SNDMSG                                       SEND MSG
004700040220     C                   Endif
004800040924    ? *
004900110504     c     bragrp        chain     SMAN2R
005000110504     c                   if        not %found(SMAN2L)
005100040924    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005200040924    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005300040924    ?C                   Exsr      SNDMSG                                       SEND MSG
005400040924     C                   Endif
005500010914    ? *
005600040220    ? * Check First Name
005700040220     C     BRAFNM        Ifeq      *Blanks
005800010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005900040220    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006000010914    ?C                   Exsr      SNDMSG                                       SEND MSG
006100010914     C                   Endif
006200011022    ? *
006300040220    ? * Check Last Name
006400040220     C     BRALNM        Ifeq      *Blanks
006500011022    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006600040220    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006700011022    ?C                   Exsr      SNDMSG                                       SEND MSG
006800040219     C                   Endif
006900040220    ? *
007000040220    ? * Check Phone
007100040220     C     BRAPHN        Ifeq      *Zeros
007200040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007300040220    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
007400040220    ?C                   Exsr      SNDMSG                                       SEND MSG
007500040220     C                   Endif
007600040220    ? *
007700040220    ? * Check Fax
007800040220     C     BRAFAX        Ifeq      *Zeros
007900040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008000040220    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
008100040220    ?C                   Exsr      SNDMSG                                       SEND MSG
008200040220     C                   Endif
008300040325    ? * Check Email Address
008400040220     C     BRAEML        Ifeq      *Blanks
008500040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008600040220    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
008700040220    ?C                   Exsr      SNDMSG                                       SEND MSG
008800040220     C                   Endif
008900040325    ? * Check Term Date
009000040325     C                   IF        bratmd <> *ZEROS
009100040325     C     *USA          TEST(DE)                bratmd
009200040325     C*    *ISO          TEST(DE)                bratmd
009300040325    1C                   IF        %ERROR
009400040325    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009500040325    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
009600040325    ?C                   Exsr      SNDMSG                                       SEND MSG
009700040325     C                   END
009800040325     C                   ENDIF
009900010914    ? *
010000010913    ?C                   Endsr                                                  END DLT RQST
010100010301    ? *___________________________________________________________________
010200010301    ? * format Date edit
010300010301    ? *___________________________________________________________________
010400010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
010500010301     C                   movel     'MMDDYYYY'    Input_Format
010600010301     C                   Call      'FMTDATE'
010700010301     C                   Parm                    Input_Date       32
010800010301     C                   Parm                    Input_Format     32
010900010301     C                   Parm                    Output_Format    32
011000010301     C                   Parm                    Output_Date      32
011100010301     C                   Parm                    Output_Error     10
011200010301    ?C                   Endsr                                                  END DLT RQST
011300000000    ? *___________________________________________________________________
011400000000    ? * Edit delete request
011500000000    ? *___________________________________________________________________
011600000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
011700000000    ?C                   Endsr                                                  END DLT RQST
011800000000    ? *___________________________________________________________________
011900000000    ? * Default data
012000000000    ? *___________________________________________________________________
012100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
012200000000    ?C                   Endsr                                                  END DFT DATA
012300000000    ? *___________________________________________________________________
012400000000    ? * Send messages
012500000000    ? *___________________________________________________________________
012600000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
012700000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
012800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
012900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
013000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
013100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
013200000000    ?C                   Endsr                                                  END SND ERRMSG
013300000000    ? *___________________________________________________________________
013400000000    ? * Process error
013500000000    ? *___________________________________________________________________
013600000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
013700000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013800000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
013900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
014000000000    ?C                   Endsr                                                  END PRCERR
014100000000    ? *___________________________________________________________________
014200000000    ? * Parameter list
014300000000    ? *___________________________________________________________________
014400000000    ?C     PLIST         Begsr                                                  PARM LISTS
014500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
014600000000    ?C                   Parm                    WIRQS             8            REQUEST
014700000000    ?C                   Parm                    WORTN             8            RETURN CODE
014800000614    ?C                   Parm                    WUDTA                          DATA
014900000000    ?C                   Endsr                                                  END PLIST
015000000000    ? *___________________________________________________________________
015100000000    ? * Define Variables and Key Lists
015200040927      *___________________________________________________________________
015300040927     C     DEFN          Begsr                                                  PARM LISTS
015400000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
015500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
015600000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
015700040927     C                   Endsr                                                  END DEFN
015800040927      *___________________________________________________________________
015900040927      * Program error handler
016000040927      *___________________________________________________________________
016100040927     C     *PSSR         Begsr                                                  PROGRAM ERROR
016200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
016300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
016400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
016500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
016600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
016700040927     C                   Endsr     '*CANCL'                                     END PGM ERROR
016800040927      *___________________________________________________________________
016900000112** WTMP
01700000000000T-Record is not eligible for deletion.
01710004022000Request not supported by program CHKBAC.
017200000117** WTM
01730004022061ID must be entered.
01740011050462Grouper must be entered and exist on SMAN2 file.
01750004022063First name must be entered.
01760004022064Last name must be entered.
01770004022065Phone number must be entered.
01780004022066Fax number must be entered.
01790004022067Email address must be entered.
01800004032568Term Date is invalid.
