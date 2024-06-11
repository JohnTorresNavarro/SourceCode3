000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300060712    ? *  Description:  Check Category Notes
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700180906    ? *
000800220721    ? *  jv01 - remove edits on amounts
000900220721    ? *  jv02 - amounts cannot be negative  07.21.2022
001000000000    ? *___________________________________________________________________
001100060712    ?FWEBNOTP   IF   E           K DISK
001200110208     FWEBNOTL2  IF   E           K DISK    RENAME(WEBNOTR:WEBR) Prefix(WR)
001300060712    ?FCODES     IF   E           K DISK
001400101215    ?FACCMST    IF   E           K DISK
001500101215    ?FPLNMST    IF   E           K DISK
001600000000    ? *
001700010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001800220721    ?D WTM             S             80    DIM(12) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001900110209     D W80DATB         S              8S 0 INZ
002000110209     D W80DATE         S              8S 0 INZ
002100000000    ? *___________________________________________________________________
002200000000    ? *
002300000614    ? * Data structure
002400060712    ?D WUDTA         E DS                  EXTNAME(WEBNOTP)
002500000810    ? *
002600000000    ? * Program status data structure
002700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002800000000    ? *___________________________________________________________________
002900000000    ? * Process check request
003000000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003100000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003200000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003300000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003400000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003500000000    ?C                   Endcs                                                  END CASE
003600000000    ?C                   Return                                                 RETURN
003700000000    ? *___________________________________________________________________
003800000000    ? * Edit record
003900000000    ? *___________________________________________________________________
004000000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
004100000810    ? *
004200000810    ? * Defualt Data
004300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
004400010219    ? *
004500061127    ? * Check
004600060712     C     CNCAT         Ifeq      *Blanks
004700010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004800010914    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004900010914    ?C                   Exsr      SNDMSG                                       SEND MSG
005000060712     C                   Else
005100060712     C     CATKEY        klist
005200060712     C                   kfld                    TYPE
005300060712     C                   kfld                    CNCAT
005400060712     C                   eval      type = 'P'
005500060712     C     CATKEY        Chain     CODES
005600060712     C                   if        not %found(CODES)
005700060712    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005800060712    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005900060712    ?C                   Exsr      SNDMSG                                       SEND MSG
006000060712     C                   End
006100010914     C                   Endif
006200060712    ? *
006300060712    ? * Check Account
006400060712     C                   If        cntrs <> 0 or
006500060712     C                             cnsub <> 0 or
006600060712     C                             cnacc <> 0
006700060712     C     ACCKEY        klist
006800060712     C                   kfld                    CNTRS
006900060712     C                   kfld                    CNSUB
007000060712     C                   kfld                    CNACC
007100060712     C     ACCKEY        Chain     ACCMST
007200060712     C                   if        not %found(ACCMST)
007300060712    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007400060712    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
007500060712    ?C                   Exsr      SNDMSG                                       SEND MSG
007600060712     C                   End
007700060712     C                   End
007800010914    ? *
007900061127    ? * Check
008000060712     C     CNDSC         Ifeq      *Blanks
008100010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008200060712    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
008300010914    ?C                   Exsr      SNDMSG                                       SEND MSG
008400010914     C                   Endif
008500130912    ? * maxmininc
008600130912     C                   Select
008700130912     C                   when      CNMAX <> 0  and
008800130912     C                             CNMIN <> 0  and
008900130912     C                             CNINC <> 0
009000130912      * Ok
009100130912     C                   when      CNMAX =  0  and
009200130912     C                             CNMIN =  0  and
009300130912     C                             CNINC =  0
009400130912      * Ok
009500130912     C                   Other
009600180906    ?C*** jv01           Move      'ERROR   '    WORTN                          REQUEST ERROR
009700180906    ?C*** jv01           Move      WTM(11)       WWMSG                          PASS MSG
009800180906    ?C*** jv01           Exsr      SNDMSG                                       SEND MSG
009900130912     C                   Endsl
010000220721
010100220721JV02? * Can not be negative
010200220721 |   C                   if        CNMAX < 0  or
010300220721 |   C                             CNMIN < 0  or
010400220721 |   C                             CNINC < 0  or
010500220721 |   C                             CNGIA < 0
010600220721 |  ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010700220721 |  ?C                   Move      WTM(12)       WWMSG                          PASS MSG
010800220721 |  ?C                   Exsr      SNDMSG                                       SEND MSG
010900220721JV02 C                   end
011000220721
011100101215    ? *
011200101215    ? * Check Plan
011300101215     C     CNPLN         Ifne      *Blanks
011400101215     C     KPLN          klist
011500101215     C                   kfld                    CNTRS
011600101215     C                   kfld                    CNSUB
011700101215     C                   kfld                    CNPLN
011800101215     C     KPLN          Chain     PLNMST
011900101215     C                   If        not %found(PLNMST)
012000101215    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012100101215    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
012200101215    ?C                   Exsr      SNDMSG                                       SEND MSG
012300101215     C                   End
012400101215     C                   End
012500010914    ? *
012600061127    ? * Check
012700061127     C     CNSMK         Ifeq      *Blanks
012800061127     C     CNSMK         orne      'N'
012900061127     C     CNSMK         andne     'Y'
013000061127    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013100061127    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
013200061127    ?C                   Exsr      SNDMSG                                       SEND MSG
013300061127     C                   Endif
013400110208    ? *
013500110208    ? * No overlapping date ranges.
013600110208    ?C     WKNOTL2       Klist
013700110208    ?C                   Kfld                    CNCAT
013800110208    ?C                   Kfld                    CNTRS
013900110208    ?C                   Kfld                    CNSUB
014000110208    ?C                   Kfld                    CNACC
014100110209     C     CNBEG         Mult      10000.0001    W80DATB
014200110209     C     CNEND         Mult      10000.0001    W80DATE
014300110209     C     WKNOTL2       Setgt     WEBNOTL2
014400110209     C     WKNOTL2       Readpe    WEBNOTL2
014500110209     C                   Dow       not %Eof(WEBNOTL2)
014600110209      *
014700110209     C                   If        W80DATB <> WRCNBEG
014800110208      *
014900110209     C***                If        (W80DATB < WRCNBEG   And
015000110209     C***                           W80DATE > WRCNBEG)
015100110209     C***                                 Or
015200110209     C                   If        (WRCNBEG > W80DATB   And
015300110209     C                              WRCNBEG < W80DATE)
015400110209     C                                    Or
015500110209     C                             (WRCNEND > W80DATB   And
015600110209     C                              WRCNEND < W80DATE)
015700110208     C                                    Or
015800110209     C                             (W80DATB > WRCNBEG   And
015900110209     C                              W80DATB < WRCNEND)
016000110208     C                                    Or
016100110209     C                             (W80DATE > WRCNBEG   And
016200110209     C                              W80DATE < WRCNEND)
016300110208      *
016400110208    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016500110208    ?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
016600110208    ?C                   Exsr      SNDMSG                                       SEND MESSAGE
016700110208     C                   Leave
016800110208     C                   End
016900110209     C                   End
017000110209     C     WKNOTL2       Readpe    WEBNOTL2
017100110208     C                   Enddo
017200061127    ? *
017300061127    ? * EFFECTIVE DATE
017400061127     C                   If        CNBEG  = *ZEROS
017500061127    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017600061127    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
017700061127    ?C                   Exsr      SNDMSG                                       SEND MSG
017800061127     C                   Else
017900061127     C                   movel     CNBEG         Input_Date
018000061127     C                   Exsr      EDTDAT
018100061127     C                   If        Output_Error <> *Blanks
018200061127    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018300061127    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
018400061127    ?C                   Exsr      SNDMSG                                       SEND MSG
018500061127     C                   Endif
018600061127     C                   Endif
018700061127    ? *
018800061127    ? * TERM DATE
018900061127     C                   If        CNEND  <> *ZEROS
019000061127     C                   movel     CNEND         Input_Date
019100061127     C                   Exsr      EDTDAT
019200061127     C                   If        Output_Error <> *Blanks
019300061127    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019400061127    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
019500061127    ?C                   Exsr      SNDMSG                                       SEND MSG
019600061127     C                   Else
019700061127    ? *
019800061127    ? * TERM DATE > EFF DATE
019900061127     C                   If        CNEND  <> *ZEROS and
020000061127     C                             CNBEG  <> *ZEROS
020100061127     C     CNEND         Mult      10000.0001    WWTRDT            8 0
020200061127     C     CNBEG         Mult      10000.0001    WWEFDT            8 0
020300061127     C                   If        WWEFDT  > WWTRDT
020400061127    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020500061127    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
020600061127    ?C                   Exsr      SNDMSG                                       SEND MSG
020700061127     C                   Endif
020800061127     C                   Endif
020900061127     C                   Endif
021000061127     C                   Endif
021100061127    ? *
021200061127    ? *
021300010913    ?C                   Endsr                                                  END DLT RQST
021400010301    ? *___________________________________________________________________
021500010301    ? * format Date edit
021600010301    ? *___________________________________________________________________
021700010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
021800010301     C                   movel     'MMDDYYYY'    Input_Format
021900010301     C                   Call      'FMTDATE'
022000010301     C                   Parm                    Input_Date       32
022100010301     C                   Parm                    Input_Format     32
022200010301     C                   Parm                    Output_Format    32
022300010301     C                   Parm                    Output_Date      32
022400010301     C                   Parm                    Output_Error     10
022500010301    ?C                   Endsr                                                  END DLT RQST
022600000000    ? *___________________________________________________________________
022700000000    ? * Edit delete request
022800000000    ? *___________________________________________________________________
022900000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
023000000000    ?C                   Endsr                                                  END DLT RQST
023100000000    ? *___________________________________________________________________
023200000000    ? * Default data
023300000000    ? *___________________________________________________________________
023400000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
023500060712     C                   If        cndsc = *blanks
023600060712     C                   eval      type = 'P'
023700060712     C     CATKEY        Chain     CODES
023800060712     C                   if        %found(CODES)
023900060712     C                   eval      cndsc = %trim(LDESCR)
024000060712     C                   end
024100060712     C                   end
024200061127     C                   If        cnsmk = *blanks
024300061127     C                   Eval      cnsmk = 'N'
024400061127     C                   end
024500000000    ?C                   Endsr                                                  END DFT DATA
024600000000    ? *___________________________________________________________________
024700000000    ? * Send messages
024800000000    ? *___________________________________________________________________
024900000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
025000000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
025100000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
025200000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
025300000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
025400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
025500000000    ?C                   Endsr                                                  END SND ERRMSG
025600000000    ? *___________________________________________________________________
025700000000    ? * Process error
025800000000    ? *___________________________________________________________________
025900000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
026000000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
026100000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
026200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
026300000000    ?C                   Endsr                                                  END PRCERR
026400000000    ? *___________________________________________________________________
026500000000    ? * Parameter list
026600000000    ? *___________________________________________________________________
026700000000    ?C     PLIST         Begsr                                                  PARM LISTS
026800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
026900000000    ?C                   Parm                    WIRQS             8            REQUEST
027000000000    ?C                   Parm                    WORTN             8            RETURN CODE
027100000614    ?C                   Parm                    WUDTA                          DATA
027200000000    ?C                   Endsr                                                  END PLIST
027300000000    ? *___________________________________________________________________
027400000000    ? * Define Variables and Key Lists
027500000000    ? *___________________________________________________________________
027600000000    ?C     DEFN          Begsr                                                  PARM LISTS
027700000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
027800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
027900000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
028000000000    ?C                   Endsr                                                  END DEFN
028100000000    ? *___________________________________________________________________
028200000000    ? * Program error handler
028300000000    ? *___________________________________________________________________
028400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
028500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
028600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
028700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
028800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
028900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
029000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
029100000000    ? *___________________________________________________________________
029200000112** WTMP
02930000000000T-Record is not eligible for deletion.
02940006071200Request not supported by program CHKNOT.
029500000117** WTM
02960006071261Category must be entered.
02970006071261Category Not setup in CODES file.
02980006071263Please enter a valid account.
02990006112762Category description must be entered.
03000006112764Smoker flag must be Y or N.
03010006112765Effective Date must be valid.
03020006112766Term Date must be valid.
03030010121565Term Date Cannot be less than Effective Date.
03040010121567Plan must be valid for this account.
03050013091265An active range already exists.
03060022072168Min Max Inc must all be entered.
03070022072168Min Max Inc Gia cannot be negative.
