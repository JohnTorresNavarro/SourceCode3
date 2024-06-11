000100080215    ? *  (c)Copyright 2008 by GBS, Inc.
000200131010      *
000300131010      * 10/10/13 sbt - hist file expansion project
000400131010      *
000500000000    ? *_________________________________________________________________________
000600080215    ?FACCMST    IF   E           K DISK
000700090730     FACCMSP    UF A E           K Disk
000800090730     FHIST      O  A E           K Disk
000900090730    ?FPMTMAID   CF   E             WORKSTN
001000000000    ?F                                     INFDS(DSPD)
001100000000    ? *_________________________________________________________________________
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001300000000    ?D WAD             S             80    DIM(6)
001400080215    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)
001500090730     D @ACCT           S              4A
001600090730     D @SUBD           S              3A
001700090730     D @TRST           S              3A
001701131025     D thispgmname     S             10a   inz('PMTMAI    ')
001800000000    ? *_________________________________________________________________________
001900080218    ?D  W0DATE         s              8  0 INZ
002000080808    ?
002100090731     D WOPMT           DS
002200090731     D   ParmList              1     25
002300090730     D   Trst                  1      3
002400090730     D   Sub#                  4      6
002500090730     D   Acct                  7     10
002600090731     D   Medicaid             11     25
002700080218    ?
002800080808      * Account key
002900080808     D                 DS
003000080808     D  WDACC                  1     10
003100080808     D  WDtrst                 1      3s 0 inz
003200080808     D  WDsub#                 4      6s 0 inz
003300080808     D  WDacct                 7     10s 0 inz
003400090730     D  WDmaid                15     19    inz
003500080215    ? *
003600000000    ? * Program status data structure
003700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003800000000    ? *
003900000000    ? * Display file data structure
004000991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004100991116    ? *
004200991116    ? * Date data structure
004300991116    ?D DATD          E DS                  EXTNAME(IODATD)
004400000000    ? *
004500080808    ?D WDACCTx       E DS                  EXTNAME(ACCMST)
004600980311    ? *
004700980311    ? * CURSOR LOCATION
004800980311    ?D                 DS
004900980311    ?D  WWCRSL                 1      2
005000980311    ?D  WWCRSN                 1      2B 0
005100090730     D                UDS
005200131014     D  @USER                100    109
005300000000    ? *_________________________________________________________________________
005400000000    ? * Process display panel
005500000000    ?C                   Exsr      PRPPNL
005600000000    ? *
005700000000B001?C     WWSTT         Downe     'END'
005800000000 001?C                   Exsr      RCVMSG
005900000000 001?C                   Exsr      DSPPNL
006000000000 001?C                   Exsr      PRCFKY
006100000000 001? *
006200000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY
006300000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN
006400000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL
006500980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT
006600980312 001? *
006700000000 001?C                   Endcs
006800000000 001? *
006900000000E001?C                   Enddo
007000980402    ?C                   Move      *ON           *INLR
007100000000    ? *___________________________________________________________________
007200000000    ? * Prepare display panel
007300000000    ? *___________________________________________________________________
007400000000    ?C     PRPPNL        Begsr
007500000000    ? *
007600000000    ? * Initialize variables
007700000000    ?C                   Move      *BLANKS       WWIN
007800000000    ?C                   Move      *BLANKS       WWOCD
007900000000    ?C                   Move      *BLANKS       WWSTT
008000000000    ?C                   Move      *BLANKS       WORTN
008100000000    ?C                   Z-add     1             WWPNL
008200000000    ?C                   Z-add     1             WWPNLN
008300000000    ?C                   Z-add     1             WWFKS
008400000000    ?C                   Z-add     *ZEROS        WW
008500980323    ?C                   Z-add     1             WWDSP
008600010524    ? *
008700090730     C                   Movel     Trst          ACTRST
008800090730     C                   Movel     Sub#          ACSUB#
008900090730     C                   Movel     Acct          ACACCT
009000090730     C     AKey          Chain     ACCMST
009100090730     C                   If        %Found(ACCMST)
009200090730     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
009300090730     C                                       %trim(Sub#) + '-'   +
009400090730     C                                       %trim(Acct) + '  '  +
009500090730     C                                       %trim(ACNAM1)
009600090730     C                   Movel(P)  WWNAME        WISTR
009700090730     C                   Z-add     60            WILEN
009800090730     C                   Call      'UTLCENSTR'
009900090730     C                   Parm                    WISTR           256
010000090730     C                   Parm                    WILEN             3 0
010100090730     C                   Movel     WISTR         WWNAME
010200090730     C                   End
010300090730    ? *
010400090730     C     AKey          Chain     ACCMSP
010500090730     C                   If        %Found(ACCMSP)
010600090730     C                   Movel     AMMAID        SVMCAID          15
010700090730     C                   Else
010800090730     C                   Move      *Blanks       SVMCAID
010900090730     C                   End
011000090730    ? *
011100000000    ?C                   Exsr      BLDFKY
011200991108    ? *
011300000000    ?C                   Endsr
011400000000    ? *___________________________________________________________________
011500000000    ? * Receive messages
011600000000    ? *___________________________________________________________________
011700000000    ?C     RCVMSG        Begsr
011800000000    ?C                   Movea     *IN           WWIN
011900000000    ?C                   Call      'PRCMSG2'
012000980223    ?C                   Parm      'RECEIVE '    WWRQS             8
012100000000    ?C                   Parm                    WWIN
012200000000    ?C                   Parm                    WWRTN             8
012300000000    ?C                   Movea     WWIN          *IN
012400000000    ?C                   Endsr
012500000000    ? *___________________________________________________________________
012600000000    ? * Display the display panel
012700000000    ? *___________________________________________________________________
012800000000    ?C     DSPPNL        Begsr
012900000000    ? *
013000000000    ? * Set OVERLAY based on last display file processed
013100000000B001?C     WQPGMN        Ifne      WUPGM
013200000000 001?C                   Setoff                                       35
013300000000 001?C                   Move      WQPGMN        WUPGM
013400000000X001?C                   Else
013500000000 001?C                   Seton                                        35
013600000000E001?C                   Endif
013700000000    ? *
013800000000    ? * Write message subfile
013900000000    ?C                   Seton                                        30
014000980216    ?C                   Write     MSGCTL
014100000000    ? *
014200000000    ? * Write display panels
014300980218    ? *
014400980323B001?C     WWDSP         Ifeq      1
014500980216 001?C                   Exfmt     DSPPNL1
014600980323E001?C                   Endif
014700980323    ? *
014800000000    ?C                   Endsr
014900000000    ? *___________________________________________________________________
015000000000    ? * Build function key information
015100000000    ? *___________________________________________________________________
015200000000    ?C     BLDFKY        Begsr
015300991108    ?C                   Movea     *IN           WWIN
015400991108    ?C                   Call      'PRCFKY2'
015500000000    ?C                   Parm      'BUILD   '    WWRQS
015600000000    ?C     WWFNC         Parm                    WWRTN
015700000000    ?C                   Parm                    WAD
015800991108    ?C                   Parm                    WWIN
015900000000    ?C                   Parm                    WAF
016000000000    ?C                   Parm                    WIFKY
016100000000    ? *
016200000000    ?C     WWFKS         Add       WWFKS         WW
016300080218     C                   Movel     WAD(WW)       WSFKD2
016400000000    ?C                   Sub       1             WW
016500080218     C                   Movel     WAD(WW)       WSFKD1
016600980312    ? *
016700000000    ?C                   Endsr
016800000000    ? *___________________________________________________________________
016900000000    ? * Process function keys
017000000000    ? *___________________________________________________________________
017100000000    ?C     PRCFKY        Begsr
017200991108    ?C                   Movea     *IN           WWIN
017300991108    ?C                   Call      'PRCFKY2'
017400000000    ?C                   Parm      'PROCESS '    WWRQS
017500000000    ?C     WWFNC         Parm                    WWRTN
017600000000    ?C                   Parm                    WAD
017700991108    ?C                   Parm                    WWIN
017800000000    ?C                   Parm                    WAF
017900000000    ?C                   Parm                    WIFKY
018000000000    ?C                   Endsr
018100000000    ? *___________________________________________________________________
018200000000    ? * Process KEYS function
018300000000    ? *___________________________________________________________________
018400000000    ?C     PRCDKY        Begsr
018500000000    ?C                   Z-add     1             WW
018600000000B001?C     WWFKS         Doueq     1
018700000000 001?C     WAD(WW)       Orne      *BLANKS
018800000000 001? *
018900000000 001?C     WWFKS         Add       1             WWFKS
019000000000B002?C     WWFKS         Ifgt      3
019100000000 002?C                   Z-add     1             WWFKS
019200000000E002?C                   Endif
019300000000 001? *
019400000000 001?C     WWFKS         Mult      2             WW
019500000000 001?C                   Sub       1             WW
019600000000E001?C                   Enddo
019700000000    ? *
019800000000    ?C     WWFKS         Add       WWFKS         WW
019900000000    ?C                   Sub       1             WW
020000080218      *
020100080218     C                   Movel     WAD(WW)       WSFKD1
020200080218     C                   Add       1             WW
020300080218     C                   Movel     WAD(WW)       WSFKD2
020400000000    ? *
020500000000    ?C                   Endsr
020600000000    ? *___________________________________________________________________
020700000000    ? * Process RETURN function
020800000000    ? *___________________________________________________________________
020900000000    ?C     PRCRTN        Begsr
021000000000    ?C                   Movel     WWFNC         WORTN
021100000000    ?C                   Move      'END'         WWSTT
021200000000    ?C                   Endsr
021300000000    ? *___________________________________________________________________
021400000000    ? * Process CANCEL function
021500000000    ? *___________________________________________________________________
021600000000    ?C     PRCCNL        Begsr
021700000000    ?C                   Movel     WWFNC         WORTN
021800000000    ?C                   Move      'END'         WWSTT
021900000000    ?C                   Endsr
022000000000    ? *___________________________________________________________________
022100000000    ? * Process ROLLUP function
022200000000    ? *___________________________________________________________________
022300000000    ?C     PRCRUP        Begsr
022400000000    ?C     WWPNL         Add       1             WWPNL
022500000000B001?C     WWPNL         Ifgt      WWPNLN
022600000000 001?C     WWPNL         Sub       1             WWPNL
022700000000E001?C                   Endif
022800000000    ?C                   Endsr
022900000000    ? *___________________________________________________________________
023000000000    ? * Process ROLLDOWN function
023100000000    ? *___________________________________________________________________
023200000000    ?C     PRCRDN        Begsr
023300000000    ?C     WWPNL         Sub       1             WWPNL
023400000000B001?C     WWPNL         Iflt      1
023500000000 001?C     WWPNL         Add       1             WWPNL
023600000000E001?C                   Endif
023700000000    ?C                   Endsr
023800000000    ? *___________________________________________________________________
023900000000    ? * Process ENTER function
024000000000    ? *___________________________________________________________________
024100000000    ?C     PRCENT        Begsr
024200980323    ? *
024300980402    ?C                   Move      *BLANKS       WWRTN
024400980402    ?C                   Exsr      CHKDTA
024500090730      * Add or update to ACCMSP here
024600090730     C                   If        %Found(ACCMSP)
024700090730     C                   Update    ACCMSPR
024800090730     C                   Else
024900090730     C                   Movel     ACTRST        AMTRST
025000090730     C                   Movel     ACSUB#        AMSUB#
025100090730     C                   Movel     ACACCT        AMACCT
025200090730     C                   Write     ACCMSPR
025300090730    ?C                   End
025400090731     C                   Eval      Medicaid  =   AMMAID
025500090730     C                   If        SVMCAID   <>  AMMAID
025600090730     C                   EXSR      $COMNHIST
025700090730     C                   MOVE      'U59'         TRCODE
025800090730     C                   MOVEL     SVMCAID       CK#NOT
025900090730     C                   MOVEL     AMMAID        NOTE2
026000131010     c                   eval      hstrtime = %time
026100090730     C                   WRITE     HISTR
026200090730     C                   End
026300090730      * Return to calling program
026400090730    ?C                   Move      'END'         WWSTT
026500980415    ? *
026600980415    ? * SET RETURN PARMS
026700980402B001?C     WWRTN         Ifeq      *BLANKS
026800980402 001?C                   Move      *BLANKS       WORTN
026900980323 001?C                   Move      'END'         WWSTT
027000980430E001?C                   Endif
027100980430    ? *
027200000000    ?C                   Endsr
027300980402    ? *___________________________________________________________________
027400980402    ? * Check data
027500980402    ? *___________________________________________________________________
027600980402    ?C     CHKDTA        Begsr
027700980402    ? *
027800980402    ?C                   Move      *BLANKS       WWRTN
027900980402    ?C                   Movea     *ALL'0'       *IN(60)
028000080808      *
028100980402    ?C                   Endsr
028200090730    ? *___________________________________________________________________
028300090730     C     $COMNHIST     BEGSR
028400000000    ? *___________________________________________________________________
028500090730     C                   CLEAR                   HISTR
028600090730     C                   MOVE      ACTRST        @TRST
028700090730     C                   MOVE      ACSUB#        @SUBD
028800090730     C                   MOVE      ACACCT        @ACCT
028900090730     C     @TRST         CAT(P)    @SUBD:0       HKEY
029000090730     C                   CAT       @ACCT:0       HKEY
029100090730     C                   MOVE      *Blanks       TRMFLG
029200090730     C                   MOVE      *Blanks       TRLFLG
029300090730     C                   MOVE      'N'           DTRFLG
029400090730     C                   MOVE      *ZEROS        HDSEQ#
029500131025     C                   MOVEL     thispgmname   HPRGNM
029600090730     C                   Z-ADD     ACTRST        HSTRST
029700090730     C                   Z-ADD     ACSUB#        HSSUB#
029800090730     C                   Z-ADD     ACACCT        HSACCT
029900090730     C                   MOVEL     @USER         HOPER
030000090730     C                   MOVE      'A'           HSDLTD
030100090730     C                   MOVE      Today         TRDATE
030200090730    ***
030300090730     C                   ENDSR
030400090730    ? *___________________________________________________________________
030500000000    ? * Send message
030600000000    ? *___________________________________________________________________
030700000000    ?C     SNDMSG        Begsr
030800000000    ?C                   Call      'QSNDDTAQ'
030900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10
031000000000    ?C                   Parm      'QTEMP'       WWLIB            10
031100000000    ?C                   Parm      80            WWLNGQ            5 0
031200000000    ?C                   Parm                    WWMSG            80
031300000000    ?C                   Endsr
031400000000    ? *___________________________________________________________________
031500000000    ? * Parameter lists
031600000000    ? *___________________________________________________________________
031700000000    ?C     PLIST         Begsr
031800000000    ?C     *ENTRY        Plist
031900000000    ?C     WWTSK         Parm                    WIRQS             8
032000000000    ?C                   Parm                    WORTN             8
032100000000    ?C                   Parm                    WUPGM            10
032200000000    ?C                   Parm                    WIFKY            60
032300080215    ?C                   Parm                    WOPMT
032400000000    ?C                   Endsr
032500090730    ? *___________________________________________________________________
032600090730    ? * Klists
032700090730    ? *___________________________________________________________________
032800090730    ?C     KList         Begsr
032900090730    ? *
033000090730    ?C     AKey          Klist
033100090730    ?C                   Kfld                    ACTRST
033200090730    ?C                   Kfld                    ACSUB#
033300090730    ?C                   Kfld                    ACACCT
033400090730      *
033500090730    ?C                   Endsr
033600000000    ? *___________________________________________________________________
033700000000    ? * Initialize routine
033800000000    ? *___________________________________________________________________
033900000000    ?C     *INZSR        Begsr
034000080905     C     *DATE         Mult      10000.0001    Today             8 0
034100000000    ?C                   Movel     '*'           MSPGMQ
034200080215    ?C                   Movel     'ACCMST  '    WWFIL
034300000000    ?C                   Move      *BLANKS       WWFLK
034400000000    ?C                   Move      *BLANKS       WWTXT
034500000000    ?C                   Endsr
034600000000    ? *___________________________________________________________________
034700000000    ? * Define  routine
034800000000    ? *___________________________________________________________________
034900000000    ?C     DEFN          Begsr
035000980311    ? *
035100980311    ?C     *LIKE         Define    WIRQS         WWORQS
035200980311    ?C     *LIKE         Define    WWPNL         WWPNLO
035300980323    ?C     *LIKE         Define    WWPNL         WWDSP
035400980311    ? *
035500000000    ?C     *LIKE         Define    WIRQS         WWTSK
035600000000    ?C     *LIKE         Define    WORTN         WWFNC
035700000000    ?C     *LIKE         Define    WIFKY         WWFKY
035800000000    ?C     *LIKE         Define    WIFKY         WWFKV
035900000000    ?C     *LIKE         Define    WIFKY         WWOPV
036000000000    ?C                   Move      WWIN          WWIN             99
036100000000    ?C                   Move      WWOCD         WWOCD             8
036200000000    ?C                   Move      WWSTT         WWSTT             3
036300000000    ?C                   Z-add     WWPNL         WWPNL             1 0
036400000000    ?C                   Z-add     WWPNLN        WWPNLN            1 0
036500000000    ?C                   Z-add     WWFKS         WWFKS             1 0
036600000000    ?C                   Z-add     WW            WW                3 0
036700000000    ?C                   Move      WWFIL         WWFIL            10
036800000000    ?C                   Move      WWFLK         WWFLK           128
036900000000    ?C                   Move      WWTXT         WWTXT            60
037000980312    ? *
037100980403    ?C     *LIKE         Define    WW            WWCNT
037200980312    ? *
037300000000    ?C                   Endsr
037400000000    ? *___________________________________________________________________
037500000000    ? * Program error handler
037600000000    ? *___________________________________________________________________
037700000000    ?C     *PSSR         Begsr
037800000000    ?C                   Call      'SNDRPGM'                            50
037900000000    ?C                   Parm                    WQPGMN
038000000000    ?C                   Parm                    WQSTSC
038100000000    ?C                   Parm                    WQRPGS
038200000000    ?C                   Parm                    WQMSG
038300000000    ?C                   Endsr     '*CANCL'
038400980312    ? *
038500991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03860009073010ENTER   ENTER=Update Medicaid#
03870000000012CANCEL  F12=Cancel
03880098032425ROLLUP
03890098032426ROLLDOWN
039000980312** WTM
03910008080800The cursor is not in a prompt area.
