000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300061207    ? *  Description:  Check Account OLE Supplemental Data
000400000000    ? *
000500061130    ? *  (c)Copyright 2006 by GBS,Inc.
000600050318    ? *  This document contains restricted materials of GBS,Inc.
000700050318    ? *___________________________________________________________________
000800061221     FACCOSPL   IF   E           K DISK    RENAME(ACCOSPR:OSP) Prefix(OS)
000900061130     FAOECOD    IF   E           K Disk
001000070329     FOEUSER    IF   E           K Disk
001100000000    ? *
001200070329    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300160520    ?D WTM             S             80    DIM(9) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600160520     D winiso          s               d   datfmt(*iso)
001700160520     D w80date         s              8S 0 inz
001800160520     D tomorrow        s              8S 0 inz
001900160520    ? *
002000000614    ? * Data structure
002100061130    ?D WUDTA         E DS                  EXTNAME(ACCOSP)
002200000810    ? *
002300000000    ? * Program status data structure
002400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000    ? *___________________________________________________________________
002600000000    ? * Process check request
002700061207     C     *DATE         Mult      10000.0001    Today             8 0
002800061221    ?C                   Movel     WORTN         CHGADD           10            SET RETURN CODE
002900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003000000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003100000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003200000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003300000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003400000000    ?C                   Endcs                                                  END CASE
003500000000    ?C                   Return                                                 RETURN
003600000000    ? *___________________________________________________________________
003700000000    ? * Edit record
003800000000    ? *___________________________________________________________________
003900000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
004000000810    ? *
004100000810    ? * Defualt Data
004200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
004300080422    ? *
004400080422    ? * Add mode only
004500080422     C                   If        CHGADD = 'ADD'
004600070413    ? * Check EFF Date; per Cindy W & Dave A it cannot be in the past
004700080422     C                   If        AOBEDT <> 0
004800061221     C                   Movel     AOBEDT        Input_Date
004900061221     C                   Exsr      EDTDAT
005000061221     C                   If        Output_Error <> *Blanks
005100061221    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005200061221    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
005300061221    ?C                   Exsr      SNDMSG                                       SEND MSG
005400061221     C                   Endif
005500061221     C                   Endif
005600080403      *
005700070413     C     AOBEDT        Mult      10000.0001    AOBEDT
005800070413     C                   If        AOBEDT =  0         Or
005900070413     C                             AOBEDT <=  Today
006000070315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006100070315    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
006200070315    ?C                   Exsr      SNDMSG                                       SEND MSG
006300080422     C                   Endif
006400080423     C                   Else
006500080423     C     AOBEDT        Mult      10000.0001    AOBEDT
006600070315     C                   Endif
006700080408     C     AOBEDT        Mult      10000.0001    AOBEDT
006800160520    ? *
006900160520    ? * candace
007000160520     C                   If        CHGADD = 'ADD'
007100160520     C     AOBEDT        Mult      10000.0001    w80date
007200160520     C                   Move      Today         winiso
007300160520     C     winiso        Adddur    1:*d          winiso
007400160520     C                   Move      winiso        Tomorrow
007500160520     C                   If        w80date <> Tomorrow
007600160520    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007700160520    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
007800160520    ?C                   Exsr      SNDMSG                                       SEND MSG
007900160520     C                   leaveSR
008000160520     C                   Endif
008100160520     C                   Endif
008200160520    ? * candace
008300160520     C                   if        AOENDT <> 0
008400160520     C     AOENDT        Mult      10000.0001    w80date
008500160520     C                   Move      Today         winiso
008600160520     C     winiso        Adddur    1:*d          winiso
008700160520     C                   Move      winiso        Tomorrow
008800160520     C                   If        w80date <> Tomorrow
008900160520    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009000160520    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
009100160520    ?C                   Exsr      SNDMSG                                       SEND MSG
009200160520     C                   leaveSR
009300160520     C                   Endif
009400160520     C                   Endif
009500061221    ? *
009600061221    ? * Check TRM Date
009700061221     C                   If        AOENDT <> 0
009800061221     C                   Movel     AOENDT        Input_Date
009900061221     C                   Exsr      EDTDAT
010000080408     C     AOENDT        Mult      10000.0001    CmpTDT            8 0
010100080408     C                   If        Output_Error <> *Blanks    Or
010200080408     C                             CmpTDT < Today
010300061221    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010400160520    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
010500061221    ?C                   Exsr      SNDMSG                                       SEND MSG
010600061221     C                   Endif
010700061221     C                   Endif
010800061221    ? *
010900080408    ? * Check EFF < TRM Date
011000061221     C                   If        AOBEDT <> 0    and
011100061221     C                             AOENDT <> 0
011200061221     C     AOBEDT        Mult      10000.0001    WWEFF             8 0
011300061221     C     AOENDT        Mult      10000.0001    WWTRM             8 0
011400061221     C                   If        WWEFF > WWTRM
011500061221    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011600061221    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
011700061221    ?C                   Exsr      SNDMSG                                       SEND MSG
011800061221     C                   End
011900061221     C                   End
012000080408     C     AOBEDT        Mult      10000.0001    AOBEDT
012100061221    ? *
012200061221    ? *
012300061221     C     AOBEDT        Mult      10000.0001    BDT               8 0
012400061221     C     AOENDT        Mult      10000.0001    EDT               8 0
012500070413      *---
012600070413      * 4.13.07  All code relating to WTM(4) which is now commented out
012700070413      *          relates to the previous requirement that a new range not
012800070413      *          be allowed to be added if a current range exists.  The new
012900070413      *          request by Cindy W. & Dave A. is that a new range can be ad
013000070413      *          added with an overlapping effective date and the program is
013100070413      *          to automatically term the previous range.  sz
013200070413      *---
013300061221    ? * New effective date must be greater than existing end dates.
013400061221    ? * Term date must be less than existing begin dates.
013500070413     C**** Akey          Setgt     ACCOSPL
013600070413     C**** Akey          Readpe    ACCOSPL
013700070413     C****               Dow       not %Eof(ACCOSPL)
013800070103      *                                                   *****
013900070103      * If in CHG Mode, skip myself                       *****
014000070413     C****               If        %trim(CHGADD) <> 'ADD'  and
014100070413     C****                         BDT = OSAOBEDT
014200070103     C* Skip edits
014300070413     C****               Else
014400070103      *                                                   *****
014500070413     C****               If        BDT       >=  OSAOBEDT And
014600070413     C****                         OSAOENDT   =  0
014700070413    ?C****               Move      'ERROR   '    WORTN                          REQUEST ERROR
014800070413    ?C****               Move      WTM(4)        WWMSG                          PASS MSG
014900070413    ?C****               Exsr      SNDMSG                                       SEND MSG
015000070413     C****               Leave
015100070413     C****               End
015200061221      *                                                   *****
015300070413     C****               If        BDT       >=  OSAOBEDT And
015400070413     C****                         BDT       <=  OSAOENDT
015500070413    ?C****               Move      'ERROR   '    WORTN                          REQUEST ERROR
015600070413    ?C****               Move      WTM(4)        WWMSG                          PASS MSG
015700070413    ?C****               Exsr      SNDMSG                                       SEND MSG
015800070413     C****               Leave
015900070413     C****               End
016000070103      *                                                   *****
016100070413     C****               If        EDT       >=  OSAOBEDT And
016200070413     C****                         EDT       <=  OSAOENDT
016300070413    ?C****               Move      'ERROR   '    WORTN                          REQUEST ERROR
016400070413    ?C****               Move      WTM(4)        WWMSG                          PASS MSG
016500070413    ?C****               Exsr      SNDMSG                                       SEND MSG
016600070413     C****               Leave
016700070413     C****               End
016800070413     C****               End
016900061221      *
017000070413     C**** Akey          Readpe    ACCOSPL
017100070413     C****               Enddo
017200061221    ? *
017300061207    ? * OLE Code must be found in OLE file.
017400010301    ? *
017500061130     C     AOCODE        Chain     AOECOD
017600061130     C                   If        Not %Found(AOECOD)
017700061130     C                   Move      'ERROR   '    WORTN
017800070103     C                   Move      WTM(5)        WWMSG
017900061130     C                   Exsr      SNDMSG
018000121107     C                   Else
018100121107     C                   If        AECODE = 1 or
018200121107     C                             AECODE = 4 or
018300121107     C                             AECODE = 5 or
018400121107     C                             AECODE = 6 or
018500150422     C                             AECODE = 7 or
018600150422     C                             AECODE = 8 or
018700150422     C                             AECODE = 9
018800121107      * Allow only these
018900121107     C                   Else
019000121107     C                   If        AOENDT = 0
019100121107     C                   Move      'ERROR   '    WORTN
019200121107     C                   Move      WTM(5)        WWMSG
019300121107     C                   Exsr      SNDMSG
019400121107     C                   End
019500121107     C                   End
019600121107     C                   End
019700070313    ? *
019800090219    ? * Prompt Retention Flag must be Y or N if AOPERF is Y.
019900070313    ? *
020000070313     C                   If        AEPERF  = 'Y'
020100070329     C                   If        AOPERF <> 'Y'          And
020200070329     C                             AOPERF <> 'N'
020300070313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020400070313    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
020500070313    ?C                   Exsr      SNDMSG                                       SEND MSG
020600070313     C                   End
020700070313     C                   End
020800070329    ? *
020900070329    ? * There must be at least one user in the OEUSER file to update ACCOSP
021000070329    ? *
021100070329     C     Akey          Chain     OEUSER
021200070329     C                   If        Not %Found(OEUSER)
021300070329    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
021400070329    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
021500070329    ?C                   Exsr      SNDMSG                                       SEND MSG
021600070329     C                   End
021700000000    ?C                   Endsr                                                  END EDIT RECORD
021800010301    ? *___________________________________________________________________
021900010301    ? * format Date edit
022000010301    ? *___________________________________________________________________
022100010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
022200010301     C                   movel     'MMDDYYYY'    Input_Format
022300010301     C                   Call      'FMTDATE'
022400010301     C                   Parm                    Input_Date       32
022500010301     C                   Parm                    Input_Format     32
022600010301     C                   Parm                    Output_Format    32
022700010301     C                   Parm                    Output_Date      32
022800010301     C                   Parm                    Output_Error     10
022900010301    ?C                   Endsr                                                  END DLT RQST
023000000000    ? *___________________________________________________________________
023100000000    ? * Edit delete request
023200000000    ? *___________________________________________________________________
023300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
023400000000    ?C                   Endsr                                                  END DLT RQST
023500000000    ? *___________________________________________________________________
023600000000    ? * Default data
023700000000    ? *___________________________________________________________________
023800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
023900000000    ?C                   Endsr                                                  END DFT DATA
024000000000    ? *___________________________________________________________________
024100000000    ? * Send messages
024200000000    ? *___________________________________________________________________
024300000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
024400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
024500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
024600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
024700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
024800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
024900000000    ?C                   Endsr                                                  END SND ERRMSG
025000000000    ? *___________________________________________________________________
025100000000    ? * Process error
025200000000    ? *___________________________________________________________________
025300000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
025400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
025500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
025600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
025700000000    ?C                   Endsr                                                  END PRCERR
025800000000    ? *___________________________________________________________________
025900000000    ? * Parameter list
026000000000    ? *___________________________________________________________________
026100000000    ?C     PLIST         Begsr                                                  PARM LISTS
026200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
026300000000    ?C                   Parm                    WIRQS             8            REQUEST
026400000000    ?C                   Parm                    WORTN             8            RETURN CODE
026500000614    ?C                   Parm                    WUDTA                          DATA
026600000000    ?C                   Endsr                                                  END PLIST
026700061201    ? *___________________________________________________________________
026800061201    ? * Key lists
026900061201    ? *___________________________________________________________________
027000061201    ?C     KLIST         Begsr                                                  KEY LISTS
027100070329    ?C     AKey          Klist                                                  ACKCTL
027200070329    ?C                   Kfld                    AOTRST
027300070329    ?C                   Kfld                    AOSUB#
027400070329    ?C                   Kfld                    AOACCT                         POSITION TO 1
027500061204    ?C                   Endsr                                                  END KLIST
027600000000    ? *___________________________________________________________________
027700000000    ? * Define Variables and Key Lists
027800000000    ? *___________________________________________________________________
027900000000    ?C     DEFN          Begsr                                                  PARM LISTS
028000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
028100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
028200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
028300000000    ?C                   Endsr                                                  END DEFN
028400000000    ? *___________________________________________________________________
028500000000    ? * Program error handler
028600000000    ? *___________________________________________________________________
028700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
028800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
028900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
029100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
029200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
029300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
029400000000    ? *___________________________________________________________________
029500000112** WTMP
02960000000000T-Record is not eligible for deletion.
02970006113000Request not supported by program CHKOSP
029800000117** WTM
02990007041361Account OLE begin date must be a valid future date.
03000008040862Account OLE end date must be a valid future date.
03010006122162End date cannot be less than begin date.
03020006122262This range cannot be added.  Please check existing ranges.
03030012110765OLE Code is not valid.
03040009021966Prompt Retention Flag (PERF) must be Y or N
03050007032967Account must have at least one OLE User.
03060016052061Account OLE begin date must be tomorrows date.
03070016052062Account OLE end date must be tomorrows date.
