000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030926    ? *  Description:  Jefferson Pilot Remittance - Prompt
000400000000    ? *
000500030926    ? *  (c)Copyright 2003 by Inovative Outsourcing, Inc.
000600071204    ? * 12/04/07 dlk - change orig / late to run sequence
000700131017    ? * 10/17/13 dpb - remove sequence# all together...runs once/month now
000800000000    ? *_________________________________________________________________________
000900030926    ?FPMT170JD  CF   E             WORKSTN
001000000000    ?F                                     INFDS(DSPD)
001100000000    ? *_________________________________________________________________________
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001300000000    ?D WAD             S             80    DIM(6)
001400010228    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)
001500000000    ? *_________________________________________________________________________
001600000000    ? * Program status data structure
001700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001800000000    ? *
001900000000    ? * Display file data structure
002000991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002100980311    ? *
002200991116    ? * Screen Date
002300991116    ?D                 DS                  INZ
002400010124    ?D  WSDATE                 1      8  0
002500991116    ? *
002600991116    ? * Output Date
002700991116    ?D                 DS                  INZ
002800991116    ?D  WODATE                 1      8  0
002900980311    ? *
003000980311    ? * CURSOR LOCATION
003100980311    ?D                 DS
003200980311    ?D  WWCRSL                 1      2
003300980311    ?D  WWCRSN                 1      2B 0
003400000000    ? *_________________________________________________________________________
003500000000    ? * Process display panel
003600000000    ?C                   Exsr      PRPPNL
003700000000    ? *
003800000000B001?C     WWSTT         Downe     'END'
003900000000 001?C                   Exsr      RCVMSG
004000000000 001?C                   Exsr      DSPPNL
004100000000 001?C                   Exsr      PRCFKY
004200000000 001? *
004300000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY
004400000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN
004500980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT
004600000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL
004700980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT
004800980312 001? *
004900000000 001?C                   Endcs
005000000000 001? *
005100000000E001?C                   Enddo
005200980402    ?C                   Move      *ON           *INLR
005300000000    ? *___________________________________________________________________
005400000000    ? * Prepare display panel
005500000000    ? *___________________________________________________________________
005600000000    ?C     PRPPNL        Begsr
005700000000    ? *
005800000000    ? * Initialize variables
005900000000    ?C                   Move      *BLANKS       WWIN
006000000000    ?C                   Move      *BLANKS       WWSTT
006100000000    ?C                   Move      *BLANKS       WORTN
006200000000    ?C                   Z-add     1             WWPNL
006300000000    ?C                   Z-add     1             WWPNLN
006400000000    ?C                   Z-add     1             WWFKS
006500000000    ?C                   Z-add     *ZEROS        WW
006600980323    ?C                   Z-add     1             WWDSP
006700991108    ? *
006800000000    ?C                   Exsr      BLDFKY
006900991108    ? *
007000000000    ?C                   Endsr
007100000000    ? *___________________________________________________________________
007200000000    ? * Receive messages
007300000000    ? *___________________________________________________________________
007400000000    ?C     RCVMSG        Begsr
007500000000    ?C                   Movea     *IN           WWIN
007600000000    ?C                   Call      'PRCMSG2'
007700980223    ?C                   Parm      'RECEIVE '    WWRQS             8
007800000000    ?C                   Parm                    WWIN
007900000000    ?C                   Parm                    WWRTN             8
008000000000    ?C                   Movea     WWIN          *IN
008100000000    ?C                   Endsr
008200000000    ? *___________________________________________________________________
008300000000    ? * Display the display panel
008400000000    ? *___________________________________________________________________
008500000000    ?C     DSPPNL        Begsr
008600000000    ? *
008700000000    ? * Set OVERLAY based on last display file processed
008800000000B001?C     WQPGMN        Ifne      WUPGM
008900000000 001?C                   Setoff                                       35
009000000000 001?C                   Move      WQPGMN        WUPGM
009100000000X001?C                   Else
009200000000 001?C                   Seton                                        35
009300000000E001?C                   Endif
009400000000    ? *
009500000000    ? * Write message subfile
009600000000    ?C                   Seton                                        30
009700980216    ?C                   Write     MSGCTL
009800000000    ? *
009900000000    ? * Write display panels
010000980218    ? *
010100980323B001?C     WWDSP         Ifeq      1
010200980216 001?C                   Exfmt     DSPPNL1
010300980323E001?C                   Endif
010400980323    ? *
010500000000    ?C                   Endsr
010600000000    ? *___________________________________________________________________
010700000000    ? * Build function key information
010800000000    ? *___________________________________________________________________
010900000000    ?C     BLDFKY        Begsr
011000991108    ?C                   Movea     *IN           WWIN
011100991108    ?C                   Call      'PRCFKY2'
011200000000    ?C                   Parm      'BUILD   '    WWRQS
011300000000    ?C     WWFNC         Parm                    WWRTN
011400000000    ?C                   Parm                    WAD
011500991108    ?C                   Parm                    WWIN
011600000000    ?C                   Parm                    WAF
011700000000    ?C                   Parm                    WIFKY
011800000000    ? *
011900000000    ?C     WWFKS         Add       WWFKS         WW
012000000000    ?C                   Sub       1             WW
012100980312    ? *
012200000000    ?C                   Endsr
012300000000    ? *___________________________________________________________________
012400000000    ? * Process function keys
012500000000    ? *___________________________________________________________________
012600000000    ?C     PRCFKY        Begsr
012700991108    ?C                   Movea     *IN           WWIN
012800991108    ?C                   Call      'PRCFKY2'
012900000000    ?C                   Parm      'PROCESS '    WWRQS
013000000000    ?C     WWFNC         Parm                    WWRTN
013100000000    ?C                   Parm                    WAD
013200991108    ?C                   Parm                    WWIN
013300000000    ?C                   Parm                    WAF
013400000000    ?C                   Parm                    WIFKY
013500000000    ?C                   Endsr
013600000000    ? *___________________________________________________________________
013700000000    ? * Process KEYS function
013800000000    ? *___________________________________________________________________
013900000000    ?C     PRCDKY        Begsr
014000000000    ?C                   Z-add     1             WW
014100000000B001?C     WWFKS         Doueq     1
014200000000 001?C     WAD(WW)       Orne      *BLANKS
014300000000 001? *
014400000000 001?C     WWFKS         Add       1             WWFKS
014500000000B002?C     WWFKS         Ifgt      3
014600000000 002?C                   Z-add     1             WWFKS
014700000000E002?C                   Endif
014800000000 001? *
014900000000 001?C     WWFKS         Mult      2             WW
015000000000 001?C                   Sub       1             WW
015100000000E001?C                   Enddo
015200000000    ? *
015300000000    ?C     WWFKS         Add       WWFKS         WW
015400000000    ?C                   Sub       1             WW
015500000000    ? *
015600000000    ?C                   Endsr
015700000000    ? *___________________________________________________________________
015800000000    ? * Process RETURN function
015900000000    ? *___________________________________________________________________
016000000000    ?C     PRCRTN        Begsr
016100000000    ?C                   Movel     WWFNC         WORTN
016200000000    ?C                   Move      'END'         WWSTT
016300000000    ?C                   Endsr
016400980311    ? *___________________________________________________________________
016500980311    ? * Process PROMPT function
016600980311    ? *___________________________________________________________________
016700980311    ?C     PRCPMT        Begsr
016800980311    ? *
016900980311    ?C                   Movel     WDCRSL        WWRQS
017000980311    ? *
017100991108    ? * PROMPT MEMBER
017200010124B001?C     WSFLD         Ifeq      'XXXXXXX'
017300991116X001?C                   Else
017400991108 001?C                   Movel     WTM(1)        WWMSG
017500991108 001?C                   Exsr      SNDMSG
017600991116E001?C                   Endif
017700980403    ? *
017800980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
017900980311    ?C                   Movel     WDCRSL        WWCRSL
018000980311    ?C     WWCRSN        Div       256           WSROW
018100980311    ?C                   Mvr                     WSLIN
018200980311    ?C                   Seton                                        37
018300980311    ? *
018400980311    ?C                   Endsr
018500000000    ? *___________________________________________________________________
018600000000    ? * Process CANCEL function
018700000000    ? *___________________________________________________________________
018800000000    ?C     PRCCNL        Begsr
018900000000    ?C                   Movel     WWFNC         WORTN
019000000000    ?C                   Move      'END'         WWSTT
019100000000    ?C                   Endsr
019200000000    ? *___________________________________________________________________
019300000000    ? * Process ROLLUP function
019400000000    ? *___________________________________________________________________
019500000000    ?C     PRCRUP        Begsr
019600000000    ?C     WWPNL         Add       1             WWPNL
019700000000B001?C     WWPNL         Ifgt      WWPNLN
019800000000 001?C     WWPNL         Sub       1             WWPNL
019900000000E001?C                   Endif
020000000000    ?C                   Endsr
020100000000    ? *___________________________________________________________________
020200000000    ? * Process ROLLDOWN function
020300000000    ? *___________________________________________________________________
020400000000    ?C     PRCRDN        Begsr
020500000000    ?C     WWPNL         Sub       1             WWPNL
020600000000B001?C     WWPNL         Iflt      1
020700000000 001?C     WWPNL         Add       1             WWPNL
020800000000E001?C                   Endif
020900000000    ?C                   Endsr
021000000000    ? *___________________________________________________________________
021100000000    ? * Process ENTER function
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCENT        Begsr
021400980323    ? *
021500980402    ?C                   Move      *BLANKS       WWRTN
021600980402    ?C                   Exsr      CHKDTA
021700980415    ? *
021800980415    ? * SET RETURN PARMS
021900980402B001?C     WWRTN         Ifeq      *BLANKS
022000991116 001?C                   Movel     WODATE        WOPMT
022100980402 001?C                   Move      *BLANKS       WORTN
022200980323 001?C                   Move      'END'         WWSTT
022300010228E001?C                   Else
022400010228 003?C                   Movel     WTM(4)        WWMSG
022500010228 003?C                   Exsr      SNDMSG
022600010228 003?C                   Move      'ERROR   '    WWRTN
022700010228E001?C                   Endif
022800980430    ? *
022900000000    ?C                   Endsr
023000980402    ? *___________________________________________________________________
023100980402    ? * Check data
023200980402    ? *___________________________________________________________________
023300980402    ?C     CHKDTA        Begsr
023400980402    ? *
023500980402    ?C                   Move      *BLANKS       WWRTN
023600980402    ?C                   Movea     *ALL'0'       *IN(60)
023700990329    ? *
023800991116    ? * Date Must be valid.
023900991116    ?C                   Clear                   WODATE
024000010228     C                   movel     WSDATE        Input_Date
024100010228     C                   Call      'FMTDATE'
024200010228     C                   Parm                    Input_Date       32
024300010228     C                   Parm      'MMDDYYYY'    Input_Format     32
024400010228     C                   Parm                    Output_Format    32
024500010228     C                   Parm                    Output_Date      32
024600010228     C                   Parm                    Output_Error     10
024700010228     C                   If        Output_Error <> *Blanks
024800010228 001?C                   Movel     WTM(2)        WWMSG
024900010228 001?C                   Exsr      SNDMSG
025000010228 001?C                   Move      'ERROR   '    WWRTN
025100010228E001?C                   Else
025200010228     C                   Move      WSDATE        WODATE
025300010228E001?C                   Endif
025400010228 001? *
025500980415    ? * WWCNT is for Enter Key control (x2)
025600991108B001?C     WWCNT         Ifeq      *ZEROS
025700980403 001?C     WWRTN         Andeq     *BLANKS
025800980403 001?C                   Add       1             WWCNT
025900980403 001?C                   Move      'WARNING '    WWRTN
026000980403X001?C                   Else
026100980403 001?C                   Z-add     *ZEROS        WWCNT
026200980403E001?C                   Endif
026300980402    ? *
026400980402    ?C                   Endsr
026500000000    ? *___________________________________________________________________
026600000000    ? * Send message
026700000000    ? *___________________________________________________________________
026800000000    ?C     SNDMSG        Begsr
026900000000    ?C                   Call      'QSNDDTAQ'
027000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10
027100000000    ?C                   Parm      'QTEMP'       WWLIB            10
027200000000    ?C                   Parm      80            WWLNGQ            5 0
027300000000    ?C                   Parm                    WWMSG            80
027400000000    ?C                   Endsr
027500000000    ? *___________________________________________________________________
027600000000    ? * Parameter lists
027700000000    ? *___________________________________________________________________
027800000000    ?C     PLIST         Begsr
027900000000    ?C     *ENTRY        Plist
028000000000    ?C     WWTSK         Parm                    WIRQS             8
028100000000    ?C                   Parm                    WORTN             8
028200000000    ?C                   Parm                    WUPGM            10
028300000000    ?C                   Parm                    WIFKY            60
028400071204    ?C                   Parm                    WOPMT            10
028500000000    ?C                   Endsr
028600000000    ? *___________________________________________________________________
028700000000    ? * Initialize routine
028800000000    ? *___________________________________________________________________
028900000000    ?C     *INZSR        Begsr
029000000000    ?C                   Movel     '*'           MSPGMQ
029100030926    ?C                   Movel     'XXXXXXXX'    WWFIL
029200000000    ?C                   Move      *BLANKS       WWFLK
029300000000    ?C                   Move      *BLANKS       WWTXT
029400000000    ?C                   Endsr
029500000000    ? *___________________________________________________________________
029600000000    ? * Define  routine
029700000000    ? *___________________________________________________________________
029800000000    ?C     DEFN          Begsr
029900980311    ? *
030000980311    ?C     *LIKE         Define    WIRQS         WWORQS
030100980311    ?C     *LIKE         Define    WWPNL         WWPNLO
030200980323    ?C     *LIKE         Define    WWPNL         WWDSP
030300980311    ? *
030400000000    ?C     *LIKE         Define    WIRQS         WWTSK
030500000000    ?C     *LIKE         Define    WORTN         WWFNC
030600000000    ?C     *LIKE         Define    WIFKY         WWFKY
030700000000    ?C     *LIKE         Define    WIFKY         WWFKV
030800000000    ?C     *LIKE         Define    WIFKY         WWOPV
030900000000    ?C                   Move      WWIN          WWIN             99
031000000000    ?C                   Move      WWSTT         WWSTT             3
031100000000    ?C                   Z-add     WWPNL         WWPNL             1 0
031200000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0
031300000000    ?C                   Z-add     WWFKS         WWFKS             1 0
031400000000    ?C                   Z-add     WW            WW                3 0
031500000000    ?C                   Move      WWFIL         WWFIL            10
031600000000    ?C                   Move      WWFLK         WWFLK           128
031700000000    ?C                   Move      WWTXT         WWTXT            60
031800980312    ? *
031900980403    ?C     *LIKE         Define    WW            WWCNT
032000980312    ? *
032100000000    ?C                   Endsr
032200000000    ? *___________________________________________________________________
032300000000    ? * Program error handler
032400000000    ? *___________________________________________________________________
032500000000    ?C     *PSSR         Begsr
032600000000    ?C                   Call      'SNDRPGM'                            50
032700000000    ?C                   Parm                    WQPGMN
032800000000    ?C                   Parm                    WQSTSC
032900000000    ?C                   Parm                    WQRPGS
033000000000    ?C                   Parm                    WQMSG
033100000000    ?C                   Endsr     '*CANCL'
033200980312    ? *
033300991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03340000000012CANCEL  F12=Cancel
03350098032425ROLLUP
03360098032426ROLLDOWN
033700980312** WTM
03380098031200The cursor is not in a prompt area.
03390003092660Effective Date must be valid MM01YYYY format.
