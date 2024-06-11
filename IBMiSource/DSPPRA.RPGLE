000100000000      *_________________________________________________________________________
000200000000      *
000300070807      *  Description:  Display Payment Reversal for Account
000400000000      *
000500070807      *  (C)COPYRIGHT 2007 BY GROUP BENEFIT SERVICES, INC.
000600000000      *
000601131004      * dlk 10/04/13 - hist file expansion project - recompile only
000700000000      *_________________________________________________________________________
000800000000      *
000900070807     FDSPPRAD   CF   E             WORKSTN INFDS(DSPD)
000901070905     FHIST      IF   E             Disk
000902070808     FACCMST    IF   E           K Disk
000903070808     FCODES     IF   E           K Disk
001000000000      *_________________________________________________________________________
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001200000000     D WAD             S             80    DIM(6)
001300000000     D WTM             S             80    DIM(1) CTDATA PERRCD(1)
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700070807     D WDDTA         E DS                  EXTNAME(HISTL6)
001800000000      *
001900000000      * Program status data structure
002000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000      *
002200000000      * Display file data structure
002300000000     D DSPD          E DS                  EXTNAME(IODSPD)
002400000000      *
002500021008     D WIFKV           S             60A
002600021008     D WIFKY           S                   LIKE(WIFKV)
002700021008     D WIOPV           S                   LIKE(WIFKV)
002800021008     D WIRQS           S              8A
002900021008     D WORTN           S              8A
003000021008     D WUPGM           S             10A
003100021008     D WWCHG           S              1A
003200021008     D WWDLT           S              1A
003300021008     D WWDTAQ          S             10A
003400021008     D WWENDF          S              3A
003500021008     D WWENDO          S                   LIKE(WWENDF)
003600021008     D WWERR           S              1A
003700021008     D WWFIL           S             10A
003800021008     D WWFKA           S              8A
003900021008     D WWFKV           S                   LIKE(WIFKV)
004000021008     D WWFKY           S                   LIKE(WIFKV)
004100021008     D WWFLK           S            128A
004200021008     D WWFMTN          S              8A
004300021008     D WWFNC           S              8A
004400021008     D WWIJI           S             16A
004500021008     D WWIN            S             99A
004600021008     D WWLIB           S             10A
004700021008     D WWMSG           S             80A
004800021008     D WWMSGC          S              7A
004900021008     D WWOCD           S              8A
005000021008     D WWOPA           S              8A
005100021008     D WWOPN           S              1A
005200021008     D WWOPT           S              8A
005300021008     D WWOPV           S                   LIKE(WIFKV)
005400021008     D WWORQS          S                   LIKE(WIRQS)
005500021008     D WWPSNC          S              1A
005600021008     D WWQJN           S             26A
005700021008     D WWRQS           S                   LIKE(WIRQS)
005800021008     D WWRQSD          S                   LIKE(WIRQS)
005900021008     D WWRTN           S                   LIKE(WORTN)
006000021008     D WWRTND          S                   LIKE(WORTN)
006100021008     D WWRTNH          S                   LIKE(WORTN)
006200021008     D WWSFLE          S              1A
006300021008     D WWSTT           S              3A
006400021008     D WWTSK           S              8A
006500021008     D WWTXT           S             60A
006600021008     D WWUPD           S              1A
006700021008     D WWWRNF          S              1A
006800021008     D WWZERO          S             40A
006900021008     D WFRRN           S              4P 0
007000021008     D WW              S              3P 0
007100021008     D WWFKS           S              1P 0
007200021008     D WWFKSO          S                   LIKE(WWFKS)
007300021008     D WWLMT           S              2P 0
007400021008     D WWLNG           S             15P 5
007500021008     D WWLNGQ          S              5P 0
007600021008     D WWLOWR          S              4P 0
007700021008     D WWLSTS          S              2P 0
007800021008     D WWOPS           S              1P 0
007900021008     D WWOPSO          S                   LIKE(WWOPS)
008000021008     D WWPNL           S              1P 0
008100021008     D WWPNLN          S                   LIKE(WWPNL)
008200021008     D WWPNLO          S                   LIKE(WWPNL)
008300021008     D WWPSNI          S              2P 0
008400021008     D WWPSNN          S              1P 0
008500021008     D WWPSNP          S                   LIKE(WWPSNN)
008600021008     D WWRRN           S              4P 0
008700000000     ****
008701070808     D WWTRST          S                   LIKE(ACTRST)
008702070808     D WWSUB#          S                   LIKE(ACSUB#)
008703070808     D WWACCT          S                   LIKE(ACACCT)
008800000000      *
008900040518     d bch@lda         ds
009000040518     d blah                    1    240a
009100040518     d co_name               200    240a
009200000000      *
009300000000      *_________________________________________________________________________
009400000000      * Process display panel
009500000000     C                   EXSR      PRPPNL
009600000000      *
009700000000B001 C                   DOW       WWSTT <> 'END'
009800000000 001 C                   EXSR      RCVMSG
009900000000 001 C                   EXSR      DSPPNL
010000000000 001 C                   EXSR      PRCFKY
010100000000 001  *
010200000000 001 C     WWFNC         CASEQ     'KEYS'        PRCDKY
010300000000 001 C     WWFNC         CASEQ     'EXIT'        PRCRTN
010400000000 001 C     WWFNC         CASEQ     'CANCEL'      PRCCNL
010500000000 001 C     WWFNC         CASEQ     'ROLLUP'      PRCRUP
010600000000 001 C     WWFNC         CASEQ     'ROLLDOWN'    PRCRDN
010700000000 001 C     WWFNC         CASEQ     'ENTER '      PRCENT
010800000000 001 C                   ENDCS
010900000000 001  *
011000000000E001 C                   ENDDO
011100000000     C                   RETURN
011200000000      *___________________________________________________________________
011300000000      * Prepare display panel
011400000000      *___________________________________________________________________
011500000000     C     PRPPNL        BEGSR
011600000000      *
011700000000     C                   MOVE      *BLANKS       WWIN
011800000000     C                   MOVE      *BLANKS       WWOCD
011900000000     C                   MOVE      *BLANKS       WWSTT
012000000000     C                   MOVE      *BLANKS       WORTN
012100000000     C                   Z-ADD     1             WWPNL
012200000000     C                   Z-ADD     1             WWPNLN
012300000000     C                   Z-ADD     1             WWFKS
012400000000     C                   Z-ADD     *ZEROS        WW
012500040518      *
012600040518     C     *dtaara       define    *lda          bch@lda
012700040518     C                   in        bch@lda
012800040518     c                   eval      wsname = co_name
012801070808      *
012802070808     C                   Movel     TRCODE        WTyp
012803070808     C                   Move      TRCODE        WCod
012804070808     C     CodKey        Chain     CODES
012805070808     C                   If        Not %Found(CODES)
012806070808     C                   Eval      LDESCR =      %Trim('Code Not On File')
012807070808     C                   End
012808070808    ? *
012809070808     C                   Eval      WWTRST = HSTRST
012810070808     C                   Eval      WWSUB# = HSSUB#
012811070808     C                   Eval      WWACCT = HSACCT
012812070808     C                   Movel     HSTRST        Trst              3
012813070808     C                   Movel     HSSUB#        Sub#              3
012814070808     C                   Movel     HSACCT        Acct              4
012815070808     C     AKey          Chain     ACCMST
012816070808     C                   If        %Found(ACCMST)
012817070808     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
012818070808     C                                       %trim(Sub#) + '-'   +
012819070808     C                                       %trim(Acct) + '  '  +
012820070808     C                                       %trim(ACNAM1)
012821070808     C                   Movel(P)  WWNAME        WISTR
012822070808     C                   Z-add     60            WILEN
012823070808     C                   Call      'UTLCENSTR'
012824070808     C                   Parm                    WISTR           256
012825070808     C                   Parm                    WILEN             3 0
012826070808     C                   Movel     WISTR         WWNAME
012827070808     C                   End
012900000000      *
013000000000     C                   EXSR      BLDFKY
013100000000     C                   EXSR      GETREC
013200000000B001 C                   IF        WWRTN <> *BLANKS
013300000000 001 C                   MOVE      WTM(1)        WWMSG
013400000000 001 C                   EXSR      SNDMSG
013500000000 001 C                   MOVE      'ERROR   '    WORTN
013600000000 001 C                   MOVE      'END'         WWSTT
013700000000E001 C                   ENDIF
013800000000      *
013900000000      *
014000000000     C                   ENDSR
014100000000      *___________________________________________________________________
014200000000      * Get record
014300000000      *___________________________________________________________________
014400000000     C     GETREC        BEGSR
014401070905     C     FRRN          CHAIN     HIST
014500070905     C***                CALL      'UPDPRA'
014600070905     C***                PARM      'GETNL '      WWRQS
014700070905     C***                PARM                    WWRTN
014701070905     C***                PARM                    WDDTA
014800070905     C***                PARM                    FRRN
014900070905     C                   ENDSR
015000000000      *___________________________________________________________________
015100000000      * Receive messages
015200000000      *___________________________________________________________________
015300000000     C     RCVMSG        BEGSR
015400000000     C                   MOVEA     *IN           WWIN
015500000000     C                   CALL      'PRCMSG2'
015600000000     C                   PARM      'RECEIVE '    WWRQS
015700000000     C                   PARM                    WWIN
015800000000     C                   PARM                    WWRTN
015900000000     C                   MOVEA     WWIN          *IN
016000000000     C                   ENDSR
016100000000      *___________________________________________________________________
016200000000      * Display the display panel
016300000000      *___________________________________________________________________
016400000000     C     DSPPNL        BEGSR
016500000000      *
016600000000      * Set OVERLAY based on last display file processed
016700000000     C                   IF        WQPGMN <> WUPGM
016800000000 001 C                   MOVE      *OFF          *IN35
016900000000 001 C                   MOVE      WQPGMN        WUPGM
017000000000X001 C                   ELSE
017100000000 001 C                   MOVE      *ON           *IN35
017200000000E001 C                   ENDIF
017202090102     C     RECVDT        Mult      10000.0001    WSRECDT
017203090102     C     COVTDT        Mult      10000.0001    WSCOVDT
017300000000      *
017400000000      * Write message subfile
017500000000     C                   MOVE      *ON           *IN30
017600000000     C                   WRITE     MSGSFLC
017700000000      *
017800000000      * Write display panels
017900000000B001 C                   SELECT
018000000000 001 C                   WHEN      WWPNL = 1
018100000000 001 C                   EXFMT     DSPPNL1
018200000000E001 C                   ENDSL
018300000000     C                   ENDSR
018400000000      *___________________________________________________________________
018500000000      * Build function key information
018600000000      *___________________________________________________________________
018700000000     C     BLDFKY        BEGSR
018800000000     C                   MOVEA     *IN           WWIN
018900000000     C                   CALL      'PRCFKY2'
019000000000     C                   PARM      'BUILD   '    WWRQS
019100000000     C     WWFNC         PARM                    WWRTN
019200000000     C                   PARM                    WAD
019300000000     C                   PARM                    WWIN
019400000000     C                   PARM                    WAF
019500000000     C                   PARM                    WIFKY
019600000000      *
019700000000     C     WWFKS         ADD       WWFKS         WW
019800000000     C                   MOVEL     WAD(WW)       WSFKD2
019900000000     C                   SUB       1             WW
020000000000     C                   MOVEL     WAD(WW)       WSFKD1
020100000000     C                   ENDSR
020200000000      *___________________________________________________________________
020300000000      * Process function keys
020400000000      *___________________________________________________________________
020500000000     C     PRCFKY        BEGSR
020600000000     C                   MOVEA     *IN           WWIN
020700000000     C                   CALL      'PRCFKY2'
020800000000     C                   PARM      'PROCESS '    WWRQS
020900000000     C     WWFNC         PARM                    WWRTN
021000000000     C                   PARM                    WAD
021100000000     C                   PARM                    WWIN
021200000000     C                   PARM                    WAF
021300000000     C                   PARM                    WIFKY
021400000000     C                   ENDSR
021500000000      *___________________________________________________________________
021600000000      * Process KEYS function
021700000000      *___________________________________________________________________
021800000000     C     PRCDKY        BEGSR
021900000000     C                   Z-ADD     1             WW
022000000000B001 C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
022100000000 001 C*
022200000000 001  *
022300000000 001 C     WWFKS         ADD       1             WWFKS
022400000000B002 C                   IF        WWFKS > 3
022500000000 002 C                   Z-ADD     1             WWFKS
022600000000E002 C                   ENDIF
022700000000 001  *
022800000000 001 C     WWFKS         MULT      2             WW
022900000000 001 C                   SUB       1             WW
023000000000E001 C                   ENDDO
023100000000      *
023200000000     C     WWFKS         ADD       WWFKS         WW
023300000000     C                   MOVEL     WAD(WW)       WSFKD2
023400000000     C                   SUB       1             WW
023500000000     C                   MOVEL     WAD(WW)       WSFKD1
023600000000      *
023700000000     C                   ENDSR
023800000000      *___________________________________________________________________
023900000000      * Process RETURN function
024000000000      *___________________________________________________________________
024100000000     C     PRCRTN        BEGSR
024200000000     C                   MOVEL     WWFNC         WORTN
024300000000     C                   MOVE      'END'         WWSTT
024400000000     C                   ENDSR
024500000000      *___________________________________________________________________
024600000000      * Process CANCEL function
024700000000      *___________________________________________________________________
024800000000     C     PRCCNL        BEGSR
024900000000     C                   MOVEL     WWFNC         WORTN
025000000000     C                   MOVE      'END'         WWSTT
025100000000     C                   ENDSR
025200000000      *___________________________________________________________________
025300000000      * Process ROLLUP function
025400000000      *___________________________________________________________________
025500000000     C     PRCRUP        BEGSR
025600000000     C     WWPNL         ADD       1             WWPNL
025700000000B001 C                   IF        WWPNL > WWPNLN
025800000000 001 C     WWPNL         SUB       1             WWPNL
025900000000E001 C                   ENDIF
026000000000     C                   ENDSR
026100000000      *___________________________________________________________________
026200000000      * Process ROLLDOWN function
026300000000      *___________________________________________________________________
026400000000     C     PRCRDN        BEGSR
026500000000     C     WWPNL         SUB       1             WWPNL
026600000000B001 C                   IF        WWPNL < 1
026700000000 001 C     WWPNL         ADD       1             WWPNL
026800000000E001 C                   ENDIF
026900000000     C                   ENDSR
027000000000      *___________________________________________________________________
027100000000      * Process ENTER function
027200000000      *___________________________________________________________________
027300000000     C     PRCENT        BEGSR
027400000000     C                   MOVE      *BLANKS       WORTN
027500000000     C                   MOVE      'END'         WWSTT
027600000000     C                   ENDSR
027700000000      *___________________________________________________________________
027800000000      * Send message
027900000000      *___________________________________________________________________
028000000000     C     SNDMSG        BEGSR
028100000000     C                   CALL      'QSNDDTAQ'
028200000000     C                   PARM      'MSGDTAQ'     WWDTAQ
028300000000     C                   PARM      'QTEMP'       WWLIB
028400000000     C                   PARM      80            WWLNGQ
028500000000     C                   PARM                    WWMSG
028600000000     C                   ENDSR
028700000000      *___________________________________________________________________
028800000000      * Parameter lists
028900000000      *___________________________________________________________________
029000000000     C     PLIST         BEGSR
029100000000     C     *ENTRY        PLIST
029200000000     C     WWTSK         PARM                    WIRQS
029300000000     C                   PARM                    WORTN
029400000000     C                   PARM                    WUPGM
029500000000     C                   PARM                    WDDTA
029501070905     C                   PARM                    WIFKY
029600070905     C                   PARM                    FRRN             10 0
029700000000     C                   ENDSR
029701070808      *___________________________________________________________________
029702070808     C     KLIST         Begsr
029800000000      *___________________________________________________________________
029801070808    ?C     AKey          Klist
029802070808    ?C                   Kfld                    WWTRST
029803070808    ?C                   Kfld                    WWSUB#
029804070808    ?C                   Kfld                    WWACCT
029805070808    ?C     CodKey        Klist
029806070808    ?C                   Kfld                    WTyp              1
029807070808    ?C                   Kfld                    WCod              2
029808070808     C                   Endsr
029809070808      *___________________________________________________________________
029900000000      * Initialize routine
030000000000      *___________________________________________________________________
030100000000     C     *INZSR        BEGSR
030200000000     C                   MOVEL     '*'           MSPGMQ
030300070807     C                   MOVEL     'HISTL6'      WWFIL
030400000000     C                   MOVE      *BLANKS       WWFLK
030500000000     C                   MOVE      *BLANKS       WWTXT
030600000000     C                   Move      *BLANKS       WWIN
030700000000     C                   MOVE      WWOCD         WWOCD
030800000000     C                   MOVE      WWSTT         WWSTT
030900000000     C                   Z-ADD     WWPNL         WWPNL
031000000000     C                   Z-ADD     WWPNLN        WWPNLN
031100000000     C                   Z-ADD     WWFKS         WWFKS
031200000000     C                   Z-ADD     WW            WW
031300000000     C                   MOVE      WWFIL         WWFIL
031400000000     C                   MOVE      WWFLK         WWFLK
031500000000     C                   MOVE      WWTXT         WWTXT
031600000000     C                   ENDSR
031700000000      *___________________________________________________________________
031800000000      * Program error handler
031900000000      *___________________________________________________________________
032000000000     C     *PSSR         BEGSR
032100000000     C                   CALL      'SNDRPGM'                            50
032200000000     C                   PARM                    WQPGMN
032300000000     C                   PARM                    WQSTSC
032400000000     C                   PARM                    WQRPGS
032500000000     C                   PARM                    WQMSG
032600000000     C                   ENDSR     '*CANCL'
032700000000      *___________________________________________________________________
032800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03290000000003EXIT    F3=Exit
03300000000012CANCEL  F12=Cancel
03310000000025ROLLUP
03320000000026ROLLDOWN
033300000000** WTM
03340007080700History record for payment not found.
