000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040219    ? *  Description:  Check Broker Representative Table
000400000000    ? *
000500040219    ? *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700000000    ? *___________________________________________________________________
000800040220    ?FBRKACON   IF   E           K DISK
000900000000    ? *
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100040325    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500040220    ?D WUDTA         E DS                  EXTNAME(BRKACON)
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
003400040312    ?C*                  Exsr      DFTDTA                                       DEFAULT DATA
003500010219    ? *
003600040220    ? * Check ID
003700040220     C     BRAID         Ifeq      *Zeros
003800010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003900010914    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004000010914    ?C                   Exsr      SNDMSG                                       SEND MSG
004100010914     C                   Endif
004200040220    ? *
004300040220    ? * Check SSNO
004400040924     c                   if        bragrp = *blanks or bragrp = '00000'
004500040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004600040220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004700040220    ?C                   Exsr      SNDMSG                                       SEND MSG
004800040220     C                   Endif
004900010914    ? *
005000040220    ? * Check First Name
005100040220     C     BRAFNM        Ifeq      *Blanks
005200010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005300040220    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005400010914    ?C                   Exsr      SNDMSG                                       SEND MSG
005500010914     C                   Endif
005600011022    ? *
005700040220    ? * Check Last Name
005800040220     C     BRALNM        Ifeq      *Blanks
005900011022    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006000040220    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006100011022    ?C                   Exsr      SNDMSG                                       SEND MSG
006200040219     C                   Endif
006300040220    ? *
006400040220    ? * Check Phone
006500040220     C     BRAPHN        Ifeq      *Zeros
006600040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006700040220    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006800040220    ?C                   Exsr      SNDMSG                                       SEND MSG
006900040220     C                   Endif
007000040220    ? *
007100040220    ? * Check Fax
007200040220     C     BRAFAX        Ifeq      *Zeros
007300040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007400040220    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
007500040220    ?C                   Exsr      SNDMSG                                       SEND MSG
007600040220     C                   Endif
007700040325    ? * Check Email Address
007800040220     C     BRAEML        Ifeq      *Blanks
007900040220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008000040220    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
008100040220    ?C                   Exsr      SNDMSG                                       SEND MSG
008200040220     C                   Endif
008300010914    ? *
008400040325     C                   IF        bratmd <> *ZEROS
008500040325     C     *USA          TEST(DE)                bratmd
008600040325     C*    *ISO          TEST(DE)                bratmd
008700040325    1C                   IF        %ERROR
008800040325    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008900040325    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
009000040325    ?C                   Exsr      SNDMSG                                       SEND MSG
009100040325     C                   END
009200040325     C                   ENDIF
009300040325    ? *
009400010913    ?C                   Endsr                                                  END DLT RQST
009500010301    ? *___________________________________________________________________
009600010301    ? * format Date edit
009700010301    ? *___________________________________________________________________
009800010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
009900010301     C                   movel     'MMDDYYYY'    Input_Format
010000010301     C                   Call      'FMTDATE'
010100010301     C                   Parm                    Input_Date       32
010200010301     C                   Parm                    Input_Format     32
010300010301     C                   Parm                    Output_Format    32
010400010301     C                   Parm                    Output_Date      32
010500010301     C                   Parm                    Output_Error     10
010600010301    ?C                   Endsr                                                  END DLT RQST
010700000000    ? *___________________________________________________________________
010800000000    ? * Edit delete request
010900000000    ? *___________________________________________________________________
011000000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
011100000000    ?C                   Endsr                                                  END DLT RQST
011200000000    ? *___________________________________________________________________
011300000000    ? * Default data
011400000000    ? *___________________________________________________________________
011500000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
011600000000    ?C                   Endsr                                                  END DFT DATA
011700000000    ? *___________________________________________________________________
011800000000    ? * Send messages
011900000000    ? *___________________________________________________________________
012000000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
012100000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
012200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
012300000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
012400000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
012500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
012600000000    ?C                   Endsr                                                  END SND ERRMSG
012700000000    ? *___________________________________________________________________
012800000000    ? * Process error
012900000000    ? *___________________________________________________________________
013000000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
013100000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013200000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
013300000000    ?C                   Exsr      SNDMSG                                       SEND MSG
013400000000    ?C                   Endsr                                                  END PRCERR
013500000000    ? *___________________________________________________________________
013600000000    ? * Parameter list
013700000000    ? *___________________________________________________________________
013800000000    ?C     PLIST         Begsr                                                  PARM LISTS
013900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
014000000000    ?C                   Parm                    WIRQS             8            REQUEST
014100000000    ?C                   Parm                    WORTN             8            RETURN CODE
014200000614    ?C                   Parm                    WUDTA                          DATA
014300000000    ?C                   Endsr                                                  END PLIST
014400000000    ? *___________________________________________________________________
014500000000    ? * Define Variables and Key Lists
014600000000    ? *___________________________________________________________________
014700000000    ?C     DEFN          Begsr                                                  PARM LISTS
014800000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
014900000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
015000000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
015100000000    ?C                   Endsr                                                  END DEFN
015200000000    ? *___________________________________________________________________
015300000000    ? * Program error handler
015400000000    ? *___________________________________________________________________
015500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
015600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
015700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
015800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
015900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
016000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
016100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
016200000000    ? *___________________________________________________________________
016300000112** WTMP
01640000000000T-Record is not eligible for deletion.
01650004022000Request not supported by program CHKBAC.
016600000117** WTM
01670004022061ID must be entered.
01680004092462SS Grouper must be entered and exist on Grouper file.
01690004022063First name must be entered.
01700004022064Last name must be entered.
01710004022065Phone number must be entered.
01720004022066Fax number must be entered.
01730004022067Email address must be entered.
01740004032568Term Date is invalid.
