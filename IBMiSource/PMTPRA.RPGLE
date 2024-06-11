000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300080818    ? *  Description:  Reverse Payment for Account - Prompt
000400000000    ? *
000500070906    ? *  (c)Copyright 2007 by GBS, Inc.
000501131004      *
000502131004      * dlk 10/04/13 - hist file expansion project - recompile only
000503131004      *
000600000000    ? *_________________________________________________________________________
000700070906    ?FPMTPRAD   CF   E             WORKSTN
000800070906     FACCMST    IF   E           K Disk
000900070906     FTRSMST    IF   E           K Disk
001000070906     FSUBMST    IF   E           K Disk
001001081215     FMEMBER    IF   E           K Disk
001100081230     FHISTL6    IF   E           K Disk
001200000000    ?F                                     INFDS(DSPD)
001300000000    ? *_________________________________________________________________________
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001500000000    ?D WAD             S             80    DIM(6)
001600081215    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)
001700000000    ? *_________________________________________________________________________
001800000000    ? * Program status data structure
001900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000    ? *
002100000000    ? * Display file data structure
002200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002300070906    ? *
002400070906    ? * Screen Date
002500070906    ?D                 DS                  INZ
002600070906    ?D  WSDATE                 1      8  0
002601081215    ? *
002602081215    ?D                 DS                  INZ
002603081230    ?D  W6DATE                 1      8  0
002604081215    ?D  RecFlg                 9      9
002605081230     D  W6KEY                 10     19
002700991116    ? *
002800991116    ? * Output Date
002900991116    ?D                 DS                  INZ
003000991116    ?D  WODATE                 1      8  0
003100980311    ? *
003200980311    ? * CURSOR LOCATION
003300980311    ?D                 DS
003400980311    ?D  WWCRSL                 1      2
003500980311    ?D  WWCRSN                 1      2B 0
003600070906    ? *
003700070906    ? * Output Date
003800070906     D  WOPMT          DS
003900070906     D  TRUST                  1      3
004000070906     D  SUB                    4      6
004100070906     D  ACCNO                  7     10
004200070907     D  ACHECK                11     20
004300070906     D  MBR                   21     29
004400070907     D  CCHECK                30     39
004500070906     D Ptr             S              3  0
004600070906     D Digits          C                   Const('0123456789')
004700000000    ? *_________________________________________________________________________
004800000000    ? * Process display panel
004900000000    ?C                   Exsr      PRPPNL
005000000000    ? *
005100000000B001?C     WWSTT         Downe     'END'
005200000000 001?C                   Exsr      RCVMSG
005300000000 001?C                   Exsr      DSPPNL
005400000000 001?C                   Exsr      PRCFKY
005500000000 001? *
005600000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY
005700000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN
005800980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT
005900000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL
006000980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT
006100980312 001? *
006200000000 001?C                   Endcs
006300000000 001? *
006400000000E001?C                   Enddo
006500070907    ?C                   Move      *ON           *INLR
006600000000    ? *___________________________________________________________________
006700000000    ? * Prepare display panel
006800000000    ? *___________________________________________________________________
006900000000    ?C     PRPPNL        Begsr
007000000000    ? *
007100000000    ? * Initialize variables
007200000000    ?C                   Move      *BLANKS       WWIN
007300000000    ?C                   Move      *BLANKS       WWSTT
007400000000    ?C                   Move      *BLANKS       WORTN
007500000000    ?C                   Z-add     1             WWPNL
007600000000    ?C                   Z-add     1             WWPNLN
007700000000    ?C                   Z-add     1             WWFKS
007800000000    ?C                   Z-add     *ZEROS        WW
007900980323    ?C                   Z-add     1             WWDSP
008000991108    ? *
008100000000    ?C                   Exsr      BLDFKY
008200991108    ? *
008300000000    ?C                   Endsr
008400000000    ? *___________________________________________________________________
008500000000    ? * Receive messages
008600000000    ? *___________________________________________________________________
008700000000    ?C     RCVMSG        Begsr
008800000000    ?C                   Movea     *IN           WWIN
008900000000    ?C                   Call      'PRCMSG2'
009000980223    ?C                   Parm      'RECEIVE '    WWRQS             8
009100000000    ?C                   Parm                    WWIN
009200000000    ?C                   Parm                    WWRTN             8
009300000000    ?C                   Movea     WWIN          *IN
009400000000    ?C                   Endsr
009500000000    ? *___________________________________________________________________
009600000000    ? * Display the display panel
009700000000    ? *___________________________________________________________________
009800000000    ?C     DSPPNL        Begsr
009900000000    ? *
010000000000    ? * Set OVERLAY based on last display file processed
010100000000B001?C     WQPGMN        Ifne      WUPGM
010200000000 001?C                   Setoff                                       35
010300000000 001?C                   Move      WQPGMN        WUPGM
010400000000X001?C                   Else
010500000000 001?C                   Seton                                        35
010600000000E001?C                   Endif
010700000000    ? *
010800000000    ? * Write message subfile
010900000000    ?C                   Seton                                        30
011000980216    ?C                   Write     MSGCTL
011100000000    ? *
011200000000    ? * Write display panels
011300980218    ? *
011400980323B001?C     WWDSP         Ifeq      1
011500980216 001?C                   Exfmt     DSPPNL1
011600980323E001?C                   Endif
011700980323    ? *
011800000000    ?C                   Endsr
011900000000    ? *___________________________________________________________________
012000000000    ? * Build function key information
012100000000    ? *___________________________________________________________________
012200000000    ?C     BLDFKY        Begsr
012300991108    ?C                   Movea     *IN           WWIN
012400991108    ?C                   Call      'PRCFKY2'
012500000000    ?C                   Parm      'BUILD   '    WWRQS
012600000000    ?C     WWFNC         Parm                    WWRTN
012700000000    ?C                   Parm                    WAD
012800991108    ?C                   Parm                    WWIN
012900000000    ?C                   Parm                    WAF
013000000000    ?C                   Parm                    WIFKY
013100000000    ? *
013200000000    ?C     WWFKS         Add       WWFKS         WW
013300000000    ?C                   Sub       1             WW
013400980312    ? *
013500000000    ?C                   Endsr
013600000000    ? *___________________________________________________________________
013700000000    ? * Process function keys
013800000000    ? *___________________________________________________________________
013900000000    ?C     PRCFKY        Begsr
014000991108    ?C                   Movea     *IN           WWIN
014100991108    ?C                   Call      'PRCFKY2'
014200000000    ?C                   Parm      'PROCESS '    WWRQS
014300000000    ?C     WWFNC         Parm                    WWRTN
014400000000    ?C                   Parm                    WAD
014500991108    ?C                   Parm                    WWIN
014600000000    ?C                   Parm                    WAF
014700000000    ?C                   Parm                    WIFKY
014800000000    ?C                   Endsr
014900000000    ? *___________________________________________________________________
015000000000    ? * Process KEYS function
015100000000    ? *___________________________________________________________________
015200000000    ?C     PRCDKY        Begsr
015300000000    ?C                   Z-add     1             WW
015400000000B001?C     WWFKS         Doueq     1
015500000000 001?C     WAD(WW)       Orne      *BLANKS
015600000000 001? *
015700000000 001?C     WWFKS         Add       1             WWFKS
015800000000B002?C     WWFKS         Ifgt      3
015900000000 002?C                   Z-add     1             WWFKS
016000000000E002?C                   Endif
016100000000 001? *
016200000000 001?C     WWFKS         Mult      2             WW
016300000000 001?C                   Sub       1             WW
016400000000E001?C                   Enddo
016500000000    ? *
016600000000    ?C     WWFKS         Add       WWFKS         WW
016700000000    ?C                   Sub       1             WW
016800000000    ? *
016900000000    ?C                   Endsr
017000000000    ? *___________________________________________________________________
017100000000    ? * Process RETURN function
017200000000    ? *___________________________________________________________________
017300000000    ?C     PRCRTN        Begsr
017400000000    ?C                   Movel     WWFNC         WORTN
017500000000    ?C                   Move      'END'         WWSTT
017600000000    ?C                   Endsr
017700980311    ? *___________________________________________________________________
017800980311    ? * Process PROMPT function
017900980311    ? *___________________________________________________________________
018000980311    ?C     PRCPMT        Begsr
018100980311    ? *
018200980311    ?C                   Movel     WDCRSL        WWRQS
018300980311    ? *
018400991108    ? * PROMPT MEMBER
018500010124B001?C     WSFLD         Ifeq      'XXXXXXX'
018600991116X001?C                   Else
018700991108 001?C                   Movel     WTM(1)        WWMSG
018800991108 001?C                   Exsr      SNDMSG
018900991116E001?C                   Endif
019000980403    ? *
019100980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
019200980311    ?C                   Movel     WDCRSL        WWCRSL
019300980311    ?C     WWCRSN        Div       256           WSROW
019400980311    ?C                   Mvr                     WSLIN
019500980311    ?C                   Seton                                        37
019600980311    ? *
019700980311    ?C                   Endsr
019800000000    ? *___________________________________________________________________
019900000000    ? * Process CANCEL function
020000000000    ? *___________________________________________________________________
020100000000    ?C     PRCCNL        Begsr
020200000000    ?C                   Movel     WWFNC         WORTN
020300000000    ?C                   Move      'END'         WWSTT
020400000000    ?C                   Endsr
020500000000    ? *___________________________________________________________________
020600000000    ? * Process ROLLUP function
020700000000    ? *___________________________________________________________________
020800000000    ?C     PRCRUP        Begsr
020900000000    ?C     WWPNL         Add       1             WWPNL
021000000000B001?C     WWPNL         Ifgt      WWPNLN
021100000000 001?C     WWPNL         Sub       1             WWPNL
021200000000E001?C                   Endif
021300000000    ?C                   Endsr
021400000000    ? *___________________________________________________________________
021500000000    ? * Process ROLLDOWN function
021600000000    ? *___________________________________________________________________
021700000000    ?C     PRCRDN        Begsr
021800000000    ?C     WWPNL         Sub       1             WWPNL
021900000000B001?C     WWPNL         Iflt      1
022000000000 001?C     WWPNL         Add       1             WWPNL
022100000000E001?C                   Endif
022200000000    ?C                   Endsr
022300000000    ? *___________________________________________________________________
022400000000    ? * Process ENTER function
022500000000    ? *___________________________________________________________________
022600000000    ?C     PRCENT        Begsr
022700980323    ? *
022800980402    ?C                   Move      *BLANKS       WWRTN
022900980402    ?C                   Exsr      CHKDTA
023000081215     C**********         Return
023001081215    ? *
023002081215    ? * SET RETURN PARMS
023003081215B001?C     WWRTN         Ifeq      *BLANKS
023004081215 001?C                   Move      *BLANKS       WORTN
023005081215 001?C                   Move      'END'         WWSTT
023006081215E001?C                   Endif
024200980430    ? *
024300000000    ?C                   Endsr
024400980402    ? *___________________________________________________________________
024500980402    ? * Check data
024600980402    ? *___________________________________________________________________
024700980402    ?C     CHKDTA        Begsr
024800980402    ? *
024900980402    ?C                   Move      *BLANKS       WWRTN
025000980402    ?C                   Movea     *ALL'0'       *IN(60)
025100070907      *---
025200070907      *  Only validate Account info if COBRA info was not entered
025300070907      *---
025400070907     C                   If        MBR       =   *Blanks
025500070906 001? *
025600070906 001? * Trust must be valid; check TRSMST file.
025700070906 001? *
025800070907     C/Free
025900070906
026000070906           Ptr = %Check(digits:TRUST);
026100070906
026200070907      /End-Free
026300070906
026400070907    ?C                   If        Ptr      =    *Zero
026500070906     C                   Movel     TRUST         TrustN
026600070906     C     TrustN        Chain     TRSMST
026700070906B002?C                   If        Not %Found(TRSMST)
026800070906 003?C                   Movel     WTM(2)        WWMSG
026900070906 003?C                   Exsr      SNDMSG
027000070906 003?C                   Move      'ERROR   '    WWRTN
027100070906E002?C                   Endif
027200070906     C                   Else
027300070906 003?C                   Movel     WTM(2)        WWMSG
027400070906 003?C                   Exsr      SNDMSG
027500070906 003?C                   Move      'ERROR   '    WWRTN
027600070906E002?C                   Endif
027700070906    ? *
027800070906    ? * Sub must be valid
027900070906    ? *
028000070907     C/Free
028100070906
028200070906           Ptr = %Check(digits:SUB);
028300070906
028400070907      /End-Free
028500070906
028600070907    ?C                   If        Ptr      =    *Zero
028700070906     C                   Movel     SUB           SubN
028800070906     C     TSKey         Chain     SUBMST
028900070906B002?C                   If        Not %Found(SUBMST)
029000070906 003?C                   Movel     WTM(3)        WWMSG
029100070906 003?C                   Exsr      SNDMSG
029200070906 003?C                   Move      'ERROR   '    WWRTN
029300070906E002?C                   Endif
029400070906     C                   Else
029500070906 003?C                   Movel     WTM(3)        WWMSG
029600070906 003?C                   Exsr      SNDMSG
029700070906 003?C                   Move      'ERROR   '    WWRTN
029800070906E002?C                   Endif
029900070906    ? *
030000070906    ? * Account must be valid
030100070906    ? *
030200070907     C/Free
030300070906
030400070906           Ptr = %Check(digits:ACCNO);
030500070906
030600070907      /End-Free
030700070906
030800070907    ?C                   If        Ptr      =    *Zero
030900070906     C                   Movel     ACCNO         AccnoN
031000070906     C     AKey          Chain     ACCMST
031100070906B002?C                   If        Not %Found(ACCMST)
031200070906 003?C                   Movel     WTM(4)        WWMSG
031300070906 003?C                   Exsr      SNDMSG
031400070906 003?C                   Move      'ERROR   '    WWRTN
031500070906E002?C                   Endif
031600070906     C                   Else
031700070906 003?C                   Movel     WTM(4)        WWMSG
031800070906 003?C                   Exsr      SNDMSG
031900070906 003?C                   Move      'ERROR   '    WWRTN
032000070906E002?C                   Endif
032100070906 001? *
032200070906 001? * Check entered for Account cannot be blank.
032300070906 001? *
032400070906B002?C     ACHECK        Ifeq      *Blanks
032500070906 003?C                   Movel     WTM(5)        WWMSG
032600070906 003?C                   Exsr      SNDMSG
032700070906 003?C                   Move      'ERROR   '    WWRTN
032800070906E002?C                   Endif
032900990329    ? *
033000070906    ? * Account Received Date must be valid.
033100991116    ?C                   Clear                   WODATE
033101081215     C                   Eval      RecFlg = 'N'
033200070907     C                   If        WSDATEA  <>   *Zeros
033300070906     C                   Movel     WSDATEA       Input_Date
033400010228     C                   Call      'FMTDATE'
033500010228     C                   Parm                    Input_Date       32
033600010228     C                   Parm      'MMDDYYYY'    Input_Format     32
033700010228     C                   Parm                    Output_Format    32
033800010228     C                   Parm                    Output_Date      32
033900010228     C                   Parm                    Output_Error     10
034000010228     C                   If        Output_Error <> *Blanks
034100070906 001?C                   Movel     WTM(6)        WWMSG
034200010228 001?C                   Exsr      SNDMSG
034300010228 001?C                   Move      'ERROR   '    WWRTN
034400010228E001?C                   Else
034401081230     C                   Eval      W6KEY = TRUST + SUB + ACCNO
034402081230     C     WSDATEA       mult      10000.0001    W6DATE
034403081230     C     H6KEYD        Setll     HISTL6
034404081230     C                   Reade     HISTL6
034405081230     C                   dow       not %eof(HISTL6)
034408081230     C                   If        W6DATE = RECVDT
034409081215     C                   Eval      RecFlg = 'Y'
034410081230     C                   Leave
034411081215     C                   End
034412081230     C     H6KEYD        Reade     HISTL6
034414081230     C                   enddo
034415081215     C                   If        RecFlg <> 'Y'
034416081215    ?C                   Movel     WTM(10)       WWMSG
034417081215    ?C                   Exsr      SNDMSG
034418081215    ?C                   Move      'ERROR   '    WWRTN
034419081215     C                   End
034500010228E001?C                   Endif
034600070907     C                   End
034601081215      *
034602081230     C     H6KEY         Klist
034603081230     C                   Kfld                    W6KEY
034604081215     C                   Kfld                    ACHECK
034700070907      *
034701081230     C     H6KEYD        Klist
034702081230     C                   Kfld                    W6KEY
034703081230     C                   Kfld                    ACHECK
034704081230     C                   Kfld                    W6DATE
034705081230      *
034800070907      *  End of Account entry validation
034900070907     C                   End
035000070907      *---
035100070907      *  Only validate Member info if Account info was not entered
035200070907      *---
035300070907     C                   If        TrustN   =    *Zero
035400070906    ? *
035500070906    ? * Member  must be valid
035600070906    ? *
035700070907     C/Free
035800070906
035900070906           Ptr = %Check(digits:MBR);
036000070906
036100070907      /End-Free
036200070906
036300070907    ?C                   If        Ptr      =    *Zero
036400070906     C                   Movel     MBR           MbrN              9 0
036500070906     C     MbrN          Chain     MEMBER
036600070906B002?C                   If        Not %Found(MEMBER)
036700070906 003?C                   Movel     WTM(7)        WWMSG
036800070906 003?C                   Exsr      SNDMSG
036900070906 003?C                   Move      'ERROR   '    WWRTN
037000070906E002?C                   Endif
037100070906     C                   Else
037200070906 003?C                   Movel     WTM(7)        WWMSG
037300070906 003?C                   Exsr      SNDMSG
037400070906 003?C                   Move      'ERROR   '    WWRTN
037500070906E002?C                   Endif
037600070906 001? *
037700070906 001? * Check entered for COBRA   cannot be blank.
037800070906 001? *
037900070906B002?C     CCHECK        Ifeq      *Blanks
038000070906 003?C                   Movel     WTM(8)        WWMSG
038100070906 003?C                   Exsr      SNDMSG
038200070906 003?C                   Move      'ERROR   '    WWRTN
038300070906E002?C                   Endif
038400070906    ? *
038500070906    ? * COBRA Received Date must be valid.
038600070906    ?C                   Clear                   WODATE
038700070907     C                   If        WSDATEA  <>   *Zeros
038800070906     C                   Movel     WSDATEC       Input_Date
038900070906     C                   Call      'FMTDATE'
039000070906     C                   Parm                    Input_Date       32
039100070906     C                   Parm      'MMDDYYYY'    Input_Format     32
039200070906     C                   Parm                    Output_Format    32
039300070906     C                   Parm                    Output_Date      32
039400070906     C                   Parm                    Output_Error     10
039500070906     C                   If        Output_Error <> *Blanks
039600070906 001?C                   Movel     WTM(9)        WWMSG
039700070906 001?C                   Exsr      SNDMSG
039800070906 001?C                   Move      'ERROR   '    WWRTN
039900070906E001?C                   Else
040000070906E001?C                   Endif
040100070907     C                   End
040200070907      *
040300070907      * End Member (COBRA) info entry validation
040400070907     C                   End
040500991116 001? *
040600980415    ? * WWCNT is for Enter Key control (x2)
040700991108B001?C     WWCNT         Ifeq      *ZEROS
040800980403 001?C     WWRTN         Andeq     *BLANKS
040900980403 001?C                   Add       1             WWCNT
041000980403 001?C                   Move      'WARNING '    WWRTN
041100980403X001?C                   Else
041200980403 001?C                   Z-add     *ZEROS        WWCNT
041300980403E001?C                   Endif
041400980402    ? *
041500980402    ?C                   Endsr
041600000000    ? *___________________________________________________________________
041700000000    ? * Send message
041800000000    ? *___________________________________________________________________
041900000000    ?C     SNDMSG        Begsr
042000000000    ?C                   Call      'QSNDDTAQ'
042100000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10
042200000000    ?C                   Parm      'QTEMP'       WWLIB            10
042300000000    ?C                   Parm      80            WWLNGQ            5 0
042400000000    ?C                   Parm                    WWMSG            80
042500000000    ?C                   Endsr
042600000000    ? *___________________________________________________________________
042700000000    ? * Parameter lists
042800000000    ? *___________________________________________________________________
042900000000    ?C     PLIST         Begsr
043000000000    ?C     *ENTRY        Plist
043100000000    ?C     WWTSK         Parm                    WIRQS             8
043200000000    ?C                   Parm                    WORTN             8
043300000000    ?C                   Parm                    WUPGM            10
043400000000    ?C                   Parm                    WIFKY            60
043500070906    ?C                   Parm                    WOPMT
043600070906     C                   Parm                    WSDATEA           8 0
043700070906     C                   Parm                    WSDATEC           8 0
043800000000    ?C                   Endsr
043900070906      *___________________________________________________________________
044000070906      * Key lists
044100070906      *___________________________________________________________________
044200070906     C     KLIST         Begsr
044300070906    ?C     TSKey         Klist
044400070906    ?C                   Kfld                    TrustN            3 0
044500070906    ?C                   Kfld                    SubN              3 0
044600070906    ?C     AKey          Klist
044700070906    ?C                   Kfld                    TrustN
044800070906    ?C                   Kfld                    SubN
044900070906    ?C                   Kfld                    AccnoN            4 0
045000070906     C                   Endsr
045100000000    ? *___________________________________________________________________
045200000000    ? * Initialize routine
045300000000    ? *___________________________________________________________________
045400000000    ?C     *INZSR        Begsr
045500000000    ?C                   Movel     '*'           MSPGMQ
045600030926    ?C                   Movel     'XXXXXXXX'    WWFIL
045700000000    ?C                   Move      *BLANKS       WWFLK
045800000000    ?C                   Move      *BLANKS       WWTXT
045900000000    ?C                   Endsr
046000000000    ? *___________________________________________________________________
046100000000    ? * Define  routine
046200000000    ? *___________________________________________________________________
046300000000    ?C     DEFN          Begsr
046400980311    ? *
046500980311    ?C     *LIKE         Define    WIRQS         WWORQS
046600980311    ?C     *LIKE         Define    WWPNL         WWPNLO
046700980323    ?C     *LIKE         Define    WWPNL         WWDSP
046800980311    ? *
046900000000    ?C     *LIKE         Define    WIRQS         WWTSK
047000000000    ?C     *LIKE         Define    WORTN         WWFNC
047100000000    ?C     *LIKE         Define    WIFKY         WWFKY
047200000000    ?C     *LIKE         Define    WIFKY         WWFKV
047300000000    ?C     *LIKE         Define    WIFKY         WWOPV
047400000000    ?C                   Move      WWIN          WWIN             99
047500000000    ?C                   Move      WWSTT         WWSTT             3
047600000000    ?C                   Z-add     WWPNL         WWPNL             1 0
047700000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0
047800000000    ?C                   Z-add     WWFKS         WWFKS             1 0
047900000000    ?C                   Z-add     WW            WW                3 0
048000000000    ?C                   Move      WWFIL         WWFIL            10
048100000000    ?C                   Move      WWFLK         WWFLK           128
048200000000    ?C                   Move      WWTXT         WWTXT            60
048300980312    ? *
048400980403    ?C     *LIKE         Define    WW            WWCNT
048500980312    ? *
048600000000    ?C                   Endsr
048700000000    ? *___________________________________________________________________
048800000000    ? * Program error handler
048900000000    ? *___________________________________________________________________
049000000000    ?C     *PSSR         Begsr
049100000000    ?C                   Call      'SNDRPGM'                            50
049200000000    ?C                   Parm                    WQPGMN
049300000000    ?C                   Parm                    WQSTSC
049400000000    ?C                   Parm                    WQRPGS
049500000000    ?C                   Parm                    WQMSG
049600000000    ?C                   Endsr     '*CANCL'
049700980312    ? *
049800991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
04990000000012CANCEL  F12=Cancel
05000098032425ROLLUP
05010098032426ROLLDOWN
050200980312** WTM
05030098031200The cursor is not in a prompt area.
05040007090660Please enter a valid Trust.
05050007090661Please enter a valid Subdivision.
05060007090662Please enter a valid Account.
05070007090663You must enter a Check number for the account payment.
05080007090664The Received Date must be in MMDDYYYY format.
05090007090665Please enter a valid Member number.
05100007090666You must enter a Check number for the COBRA payment.
05100108121567Please enter a valid Received Date for the COBRA transaction.
05110008121564No Receive Date exists for this check number.
