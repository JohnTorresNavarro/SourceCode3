000100110622     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200110622     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500110621    ? *  Description:  Check On-Demand Deductions
000600000000    ? *
000700100520    ? *  (c)Copyright 2010 by GBS, Inc.
000800000000    ? *___________________________________________________________________
000900110621    ?FWEBPAYOND IF   E           K DISK
001000140428    ?FWEBPAYONL3IF   E           K DISK    rename(webpayonr:onr) prefix(o_)
001100110613    ?FACCMST    IF   E           K DISK
001200110613    ?FMEMBER    IF   E           K DISK
001300110613    ?FPLNMST    IF   E           K DISK
001400110622
001500110622      * Prototypes
001600110622      /copy *libl/qmodsrc,#gettyppr
001700110622
001800000000    ? *
001900010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
002000140428    ?D WTM             S             80    DIM(15) CTDATA PERRCD(1)             ERROR MESSAGE TBL
002100110110    ? *
002200110110     D WDATE1          s              8S 0 inz
002300110110     D WDATE2          s              8S 0 inz
002400110622     d wwtyp           s              1a   inz
002500000000    ? *___________________________________________________________________
002600000000    ? *
002700000614    ? * Data structure
002800110621    ?D WUDTA         E DS                  EXTNAME(WEBPAYOND)
002900000810    ? *
003000000000    ? * Program status data structure
003100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003200000000    ? *___________________________________________________________________
003300000000    ? * Process check request
003400000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003500000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003600000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003700000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003800000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003900000000    ?C                   Endcs                                                  END CASE
004000000000    ?C                   Return                                                 RETURN
004100000000    ? *___________________________________________________________________
004200000000    ? * Edit record
004300000000    ? *___________________________________________________________________
004400000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
004500000810    ? *
004600000810    ? * Defualt Data
004700000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
004800110523    ? *
004900110613    ? * Validate TSA
005000110613     C     ACCKEY        Klist
005100110621     C                   kfld                    POTRS
005200110621     C                   kfld                    POSUB
005300110621     C                   kfld                    POACT
005400110613     C     ACCKEY        Chain     ACCMST
005500110613     C                   If        not %found(ACCMST)
005600110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005700110613    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
005800110613    ?C                   Exsr      SNDMSG                                       SEND MSG
005900110621     C                   LeaveSR
006000110613     C                   End
006100110613    ? *
006200110901    ? * Validate SSN - temp - only 1 SSN at a time
006300111019     C                   If        POSSN > *Zeros
006400110621     C     POSSN         Chain     MEMBER
006500110613     C                   If        not %found(MEMBER)
006600110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006700110613    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
006800110613    ?C                   Exsr      SNDMSG                                       SEND MSG
006900110727     C                   Else
007000110727     C                   If        MBTRST <> POTRS or
007100110727     C                             MBSUB# <> POSUB or
007200110727     C                             MBACCT <> POACT
007300110727    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007400110727    ?C                   Move      WTM(12)       WWMSG                          PASS MSG
007500110727    ?C                   Exsr      SNDMSG                                       SEND MSG
007600110727     C                   End
007700110621     C                   End
007800111019     C                   End
007900110901    ? *
008000110901    ? * All Plan - Phase II - Temp turned off
008100110919     C**                 If        POALL = 'Y'
008200110919    ?C**                 Move      'ERROR   '    WORTN                          REQUEST ERROR
008300110919    ?C**                 Move      WTM(13)       WWMSG                          PASS MSG
008400110919    ?C**                 Exsr      SNDMSG                                       SEND MSG
008500110919     C**                 LeaveSR
008600110919     C**                 End
008700110613    ? *
008800110613    ? * Validate Plan
008900110613     C     PLNKEY        Klist
009000110621     C                   kfld                    POTRS
009100110621     C                   kfld                    POSUB
009200110621     C                   kfld                    POPLN
009300110726     C                   If        POPLN <> *blanks  and
009400110726     C                             POPLN <> '****'
009500110613     C     PLNKEY        Chain     PLNMST
009600110613     C                   If        not %found(PLNMST)
009700110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009800110613    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
009900110613    ?C                   Exsr      SNDMSG                                       SEND MSG
010000110613     C                   Else
010100110621     C                   If        POALL = 'Y'
010200110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010300110621    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
010400110621    ?C                   Exsr      SNDMSG                                       SEND MSG
010500110621     C                   End
010600110621     C                   End
010700110613     C                   End
010800110621    ? *
010900110621     C                   If        POPLN = *blanks  and
011000110621     C                             POALL = *blanks
011100110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011200110621    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
011300110621    ?C                   Exsr      SNDMSG                                       SEND MSG
011400110621     C                   End
011500110621    ? *
011600110621     C                   If        POPLN = *blanks   and
011700110621     C                             POALL <> 'Y'
011800110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011900110621    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
012000110621    ?C                   Exsr      SNDMSG                                       SEND MSG
012100110621     C                   End
012200110621    ? *
012300110621     C                   If        POPLN <> *blanks  and
012400110621     C                             POALL <> 'Y'      and
012500110621     C                             POALL <> 'N'
012600110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012700110621    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
012800110621    ?C                   Exsr      SNDMSG                                       SEND MSG
012900110621     C                   End
013000110621    ? *
013100110621     C                   If        PODEM <> 'Y' and
013200110621     C                             PODEM <> 'N'
013300110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013400110621    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
013500110621    ?C                   Exsr      SNDMSG                                       SEND MSG
013600110621     C                   End
013700110613    ? *
013800110621    ? * Validate Start Date
013900110726     C                   If        POPLN <> '****'
014000110621     C                   If        POSTART <> *Zeros
014100110621     C                   Movel     POSTART       Input_Date
014200110523     C                   Exsr      FMTDATE
014300110523     C                   If        Output_Error <> *Blanks
014400110523    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014500110621    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
014600110523    ?C                   Exsr      SNDMSG                                       SEND MSG
014700110523     C                   LeaveSR
014800110523     C                   End
014900110523     C                   Else
015000110621     C                   If        POSTOP  = *Zeros
015100110523    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015200110621    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
015300110523    ?C                   Exsr      SNDMSG                                       SEND MSG
015400110523     C                   LeaveSR
015500110621     C                   End
015600110726     C                   End
015700110621    ? *
015800110621     C                   If        POSTART <> *Zeros  and
015900110621     C                             POSTOP  <> *Zeros
016000110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016100110621    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
016200110621    ?C                   Exsr      SNDMSG                                       SEND MSG
016300110621     C                   LeaveSR
016400110621     C                   End
016500110621    ? *
016600110621    ? * Validate Stop Date
016700110621     C                   If        POSTOP  <> *Zeros
016800110621     C                   Movel     POSTOP        Input_Date
016900110621     C                   Exsr      FMTDATE
017000110621     C                   If        Output_Error <> *Blanks
017100110621    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017200110621    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
017300110621    ?C                   Exsr      SNDMSG                                       SEND MSG
017400110621     C                   LeaveSR
017500110621     C                   End
017600110621     C                   End
017700110622
017800110622      * Get Plan Type for benefit amount bucket
017900110622     C                   eval      wwtyp = #gettyp(plncat)
018000110622     C                   If        wwtyp = '1'  or
018100110622     C                             wwtyp = '2'  or
018200110622     C                             wwtyp = '3'  or
018300110622     C                             wwtyp = '4'  or
018400110622     C                             wwtyp = '5'  or
018500110622     C                             wwtyp = '6'  or
018600110622     C                             wwtyp = '7'
018700110622     C                   If        POBEN  = *Zeros
018800110622    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
018900110622    ?C                   Exsr      SNDMSG                                       SEND MSG
019000110622     C                   LeaveSR
019100110622     C                   End
019200110622     C                   End
019300110726     C                   End
019400111130    ? *
019500111130    ? * Validate Rate Override Date
019600111130     C                   If        POEFDT  <> *Zeros
019700111130     C                   Movel     POEFDT        Input_Date
019800111130     C                   Exsr      FMTDATE
019900111130     C                   If        Output_Error <> *Blanks
020000111130    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020100111130    ?C                   Move      WTM(14)       WWMSG                          PASS MSG
020200111130    ?C                   Exsr      SNDMSG                                       SEND MSG
020300111130     C                   LeaveSR
020400111130     C                   End
020500111130     C                   End
020600110726    ? *
020700110726     C                   If        POPLN = '****' and
020800110919     C                             POALL =  'N'   and
020900110919     C                             PODEM <> 'Y'
021000110726    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
021100110726    ?C                   Exsr      SNDMSG                                       SEND MSG
021200110726     C                   LeaveSR
021300110726     C                   End
021400140428    ? *
021500140428    ? * Validate duplicate OND
021600140428     C     DEDKEY        Klist
021700140428     C                   kfld                    POTRS
021800140428     C                   kfld                    POSUB
021900140428     C                   kfld                    POACT
022000140428     C                   kfld                    POSSN
022100140428     C                   kfld                    POPLN
022200140428     C     DEDKEY        Chain     WEBPAYONL3
022300140428     C                   If        %found(WEBPAYONL3)
022400140428     C                   If        O_POSENT = 0
022500140428    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
022600140428    ?C                   Move      WTM(15)       WWMSG                          PASS MSG
022700140428    ?C                   Exsr      SNDMSG                                       SEND MSG
022800140428     C                   LeaveSR
022900140428     C                   End
023000140428     C                   End
023100110523    ? *
023200010913    ?C                   Endsr                                                  END DLT RQST
023300000000    ? *___________________________________________________________________
023400000000    ? * Edit delete request
023500000000    ? *___________________________________________________________________
023600000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
023700100617    ? *
023800000000    ?C                   Endsr                                                  END DLT RQST
023900000000    ? *___________________________________________________________________
024000000000    ? * Default data
024100000000    ? *___________________________________________________________________
024200000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
024300110726     C                   If        POPLN = *blanks
024400110726     C                   Eval      POPLN = '****'
024500110726     C                   End
024600110621     C                   If        POALL = *blanks
024700110621     C                   Eval      POALL = 'N'
024800110621     C                   End
024900110621     C                   If        PODEM = *blanks
025000110621     C                   Eval      PODEM = 'N'
025100110621     C                   End
025200000000    ?C                   Endsr                                                  END DFT DATA
025300000000    ? *___________________________________________________________________
025400000000    ? * Send messages
025500000000    ? *___________________________________________________________________
025600000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
025700000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
025800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
025900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
026000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
026100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
026200000000    ?C                   Endsr                                                  END SND ERRMSG
026300000000    ? *___________________________________________________________________
026400000000    ? * Process error
026500000000    ? *___________________________________________________________________
026600000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
026700000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
026800000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
026900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
027000000000    ?C                   Endsr                                                  END PRCERR
027100000000    ? *___________________________________________________________________
027200000000    ? * Parameter list
027300000000    ? *___________________________________________________________________
027400000000    ?C     PLIST         Begsr                                                  PARM LISTS
027500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
027600000000    ?C                   Parm                    WIRQS             8            REQUEST
027700000000    ?C                   Parm                    WORTN             8            RETURN CODE
027800000614    ?C                   Parm                    WUDTA                          DATA
027900000000    ?C                   Endsr                                                  END PLIST
028000000000    ? *___________________________________________________________________
028100000000    ? * Define Variables and Key Lists
028200000000    ? *___________________________________________________________________
028300000000    ?C     DEFN          Begsr                                                  PARM LISTS
028400000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
028500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
028600000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
028700000000    ?C                   Endsr                                                  END DEFN
028800010914    ? *___________________________________________________________________
028900010914    ? * Key lists
029000010914    ? *___________________________________________________________________
029100010914    ?C     KLIST         Begsr                                                  KEY LISTS
029200010914    ?C                   Endsr
029300000000    ? *___________________________________________________________________
029400000000    ? * Program error handler
029500000000    ? *___________________________________________________________________
029600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
029700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
029800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
030000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
030100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
030200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
030300031215      *-------------------------------------------------------------------*
030400031215      * Format Date
030500031215      *-------------------------------------------------------------------*
030600031215     C     FMTDATE       Begsr
030700110523     C                   Eval      Input_Format  = 'MMDDYYYY'
030800031215     C                   Eval      Output_Format = 'MMDDYYYY'
030900031215     C                   Call      'FMTDATE'
031000031215     C                   Parm                    Input_Date       32
031100031215     C                   Parm                    Input_Format     32
031200031215     C                   Parm                    Output_Format    32
031300031215     C                   Parm                    Output_Date      32
031400031215     C                   Parm                    Output_Error     10
031500031215     C                   Endsr
031600000000    ? *___________________________________________________________________
031700000112** WTMP
03180000000000T-Record is not eligible for deletion.
03190011062100Request not supported by program CHKOND.
032000000117** WTM
03210011061361Account is invalid.
03220011062162Member is invalid.
03230011061363Plan is invalid.
03240011062164Plan and All Plans cannot be both selected.
03250011062165Include Demographs must be Y/N.
03260011062166Start Date is invalid.
03270011062167Stop Date is invalid.
03280011062167Only enter either Start or Stop Date.
03290011062263Plan is invalid.
03300011062268Benefit Amount is required for this type of plan
03310011072665Include Demographs must be Y if sending demographics only.
03320011072762Member does not exist in that account.
03330011090164All Plans not avaiable at this time - Jon
03340014042869Rate Override Date is invalid.
03350014042870Deduction already in the queue.  F12 and complete the existing transaction.
