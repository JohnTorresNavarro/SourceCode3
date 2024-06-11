000100020304      *_________________________________________________________________________
000200020304      *
000300070809      *  Description:  Reverse Payment for Account
000400020304      *
000500070809      *  (c)Copyright 2007 by Group Benefit Services, Inc.
000501131004      *
000502131004      * dlk 10/04/13 - hist file expansion project - recompile only
000503131004      *
000600020304      *_________________________________________________________________________
000700070313      *                                                                    *
000800070313      *_________________________________________________________________________
000900070809     FCHGPRAD   CF   E             WORKSTN INFDS(DSPD)
001000070809     FACCMST    IF   E           K Disk
001002080625     FHISTL7    IF   E           K Disk    Rename(HISTR:HIST7) Prefix(H7)
001003080630     FRVRCOD    IF   E           K Disk
001100020304      *
001200020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001300061130     D WAD             S             80    DIM(5)
001400080625     D WTM             S             80    DIM(8)  CTDATA PERRCD(1)
001500020304      *_________________________________________________________________________
001600020304      * Data structure
001700070809     D WUDTA         E DS                  EXTNAME(HISTL6)
001800020304      *
001900020304      * Program status data structure
002000020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100020304      *
002200020304      * Display file data structure
002300020304     D DSPD          E DS                  EXTNAME(IODSPD)
002400020304      *
002500020304      * CURSOR LOCATION
002600020304     D                 DS
002700020304     D  WWCRSL                 1      2
002800020304     D  WWCRSN                 1      2B 0
002900020304     ***
003000020304     D WWDTA           S                   LIKE(WUDTA)
003100021008     ***
003200021008     D WIFKV           S             60A
003300021008     D WIFKY           S                   LIKE(WIFKV)
003400021008     D WIOPV           S                   LIKE(WIFKV)
003500021008     D WIRQS           S              8A
003600021008     D WORTN           S              8A
003700021008     D WUPGM           S             10A
003800021008     D WWCHG           S              1A
003900021008     D WWDLT           S              1A
004000021008     D WWDTAQ          S             10A
004100021008     D WWENDF          S              3A
004200021008     D WWENDO          S                   LIKE(WWENDF)
004300021008     D WWERR           S              1A
004400021008     D WWFIL           S             10A
004500021008     D WWFKA           S              8A
004600021008     D WWFKV           S                   LIKE(WIFKV)
004700021008     D WWFKY           S                   LIKE(WIFKV)
004800021008     D WWFLK           S            128A
004900021008     D WWFMTN          S              8A
005000021008     D WWFNC           S              8A
005100021008     D WWIJI           S             16A
005200021008     D WWIN            S             99A
005300021008     D WWLIB           S             10A
005400021008     D WWMSG           S             80A
005500021008     D WWMSGC          S              7A
005600021008     D WWOCD           S              8A
005700021008     D WWOPA           S              8A
005800021008     D WWOPN           S              1A
005900021008     D WWOPT           S              8A
006000021008     D WWOPV           S                   LIKE(WIFKV)
006100021008     D WWORQS          S                   LIKE(WIRQS)
006200021008     D WWPSNC          S              1A
006300021008     D WWQJN           S             26A
006400021008     D WWRQS           S                   LIKE(WIRQS)
006500021008     D WWRQSD          S                   LIKE(WIRQS)
006600021008     D WWRTN           S                   LIKE(WORTN)
006700021008     D WWRTND          S                   LIKE(WORTN)
006800021008     D WWRTNH          S                   LIKE(WORTN)
006900021008     D WWSFLE          S              1A
007000021008     D WWSTT           S              3A
007100021008     D WWTSK           S              8A
007200021008     D WWTXT           S             60A
007300021008     D WWUPD           S              1A
007400021008     D WWWRNF          S              1A
007500021008     D WWZERO          S             40A
007600021008     D WFRRN           S              4P 0
007700021008     D WW              S              3P 0
007800021008     D WWFKS           S              1P 0
007900021008     D WWFKSO          S                   LIKE(WWFKS)
008000021008     D WWLMT           S              2P 0
008100021008     D WWLNG           S             15P 5
008200021008     D WWLNGQ          S              5P 0
008300021008     D WWLOWR          S              4P 0
008400021008     D WWLSTS          S              2P 0
008500021008     D WWOPS           S              1P 0
008600021008     D WWOPSO          S                   LIKE(WWOPS)
008700021008     D WWPNL           S              1P 0
008800021008     D WWPNLN          S                   LIKE(WWPNL)
008900021008     D WWPNLO          S                   LIKE(WWPNL)
009000021008     D WWPSNI          S              2P 0
009100021008     D WWPSNN          S              1P 0
009200021008     D WWPSNP          S                   LIKE(WWPSNN)
009300021008     D WWRRN           S              4P 0
009400020304     ***
009500070809     D WWTRST          S                   LIKE(ACTRST)
009600070809     D WWSUB#          S                   LIKE(ACSUB#)
009601080625     D WWACCT          S                   LIKE(ACACCT)
009602080625     D RADATE2         S              8S 0 inz
009700080625     D REVFLG          S              1    inz
009800070809      *
009900040518     d bch@lda         ds
010000040518     d blah                    1    240a
010100040518     d co_name               200    240a
010200020304      *_________________________________________________________________________
010300020304      *
010400020304      * Process Entry Panel
010500020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
010600020304     C                   Move      WUDTA         WWDTA
010700020304E1   C                   ENDIF
010800020304      *
010900020304     C                   Exsr      PRPPNL
011000020304      *
011100020304B1   C                   DOW       WWSTT <> 'END'
011200020304     C                   Exsr      RCVMSG
011300020304     C                   Exsr      DSPPNL
011400020304     C                   Exsr      PRCFKY
011500020304      *
011600020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
011700020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
011800020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
011900020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
012000020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
012100020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
012200020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
012300020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
012400020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
012500020304E2   C                   Endcs
012600020304      *
012700020304B2   C                   IF        WWSTT = 'END'
012800020304     C                   Exsr      PRCEND
012900020304E2   C                   Endif
013000020304E1   C                   Enddo
013100020304      *
013200020304      * Send Info Updated message.
013300020304     C                   IF        WWCHG = 'Y'
013400020304     C                   MOVEL     'UPDATE  '    WORTN
013500020304     C                   Endif
013600020304      *
013700020304     C                   Return
013800020304      *___________________________________________________________________
013900020304      * Prepare panel
014000020304      *___________________________________________________________________
014100020304     C     PRPPNL        Begsr
014200020304     C                   Move      *BLANKS       WORTN
014300020304     C                   Move      'N'           WWERR
014400020304     C                   Move      'N'           WWCHG
014500020304     C                   Move      'N'           WWWRNF
014600020304     C                   Move      *BLANKS       WWSTT
014700020304     C                   Z-add     1             WWPNL
014800020304     C                   Z-add     1             WWFKS
014900020304     C                   Movea     WWZERO        *IN(60)
015000020304     C                   Move      *BLANKS       WWSTT
015100040518      *
015200040518     C     *DTAARA       DEFINE    *LDA          BCH@LDA
015300040518     C                   IN        BCH@LDA
015400040518     c                   eval      wsname = co_name
015500020304      *
015600020304B1   C                   IF        WQPGMN = WUPGM
015700020304B2   C                   IF        WIRQS <> WWORQS
015800020304     C                   Move      *BLANKS       WUPGM
015900020304E2   C                   Endif
016000020304     C                   Move      WIRQS         WWORQS
016100020304E1   C                   Endif
016200020304      *
016300070809     C                   Movel     HSTRST        Trst              3
016400070809     C                   Movel     HSSUB#        Sub#              3
016500070809     C                   Movel     HSACCT        Acct              4
016600070809     C     AKey          Chain     ACCMST
016700070809     C                   If        %Found(ACCMST)
016701080606     C                   If        ATRMDT  <>    *Zero
016702080606     C                   Eval      *In77   =     *On
016703080606     C                   Else
016704080606     C                   Eval      *In77   =     *Off
016705080606     C                   End
016800070809     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
016900070809     C                                       %trim(Sub#) + '-'   +
017000070809     C                                       %trim(Acct) + '  '  +
017100070809     C                                       %trim(ACNAM1)
017200070809     C                   Movel(P)  WWNAME        WISTR
017300070809     C                   Z-add     60            WILEN
017400070809     C                   Call      'UTLCENSTR'
017500070809     C                   Parm                    WISTR           256
017600070809     C                   Parm                    WILEN             3 0
017700070809     C                   Movel     WISTR         WWNAME
017800070809     C                   End
017900070809    ? *
018000020304     C                   Exsr      BLDFKY
018100020304      *
018200020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
018300020304     C     WWTSK         Caseq     'ADD     '    PRPADD
018400020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
018500020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
018600020304     C                   Cas                     PRCERR
018700020304E1   C                   Endcs
018800020304      *
018900020304      *
019000020304     C                   Endsr
019100020304      *___________________________________________________________________
019200020304      * Prepare ADD request
019300020304      *___________________________________________________________________
019400020304     C     PRPADD        Begsr
019500020304     C                   Clear                   WUDTA
019600020304     C                   Exsr      DFTDTA
019700020304     C                   Endsr
019800020304      *___________________________________________________________________
019900020304      * Prepare CHANGE request
020000020304      *___________________________________________________________________
020100020304     C     PRPCHG        Begsr
020200070809     C                   Call      'UPDPRA  '
020300020304     C                   Parm      'GET     '    WWRQS
020400020304     C                   Parm                    WWRTN
020500020304     C                   Parm                    WUDTA
020600070815     C                   Parm                    TRAMTA
020700070910     C                   Parm                    RADate            8 0
020701080612     C                   Parm                    REVRSN
020702080627     C                   Parm                    REVCOD
020800020304B1   C                   IF        WWRTN <> *BLANKS
020900020304B2   C                   IF        WWRTN = 'NOTAVL'
021000020304     C                   Movel     WTM(5)        WWMSG
021100020304X2   C                   Else
021200020304     C                   Movel     WTM(4)        WWMSG
021300020304E2   C                   Endif
021400020304     C                   Exsr      SNDMSG
021500020304     C                   Move      'ERROR   '    WORTN
021600020304     C                   Move      'END'         WWSTT
021700020304E1   C                   End
021800020304     C                   Endsr
021900020304      *___________________________________________________________________
022000020304      * Prepare COPY request
022100020304      *___________________________________________________________________
022200020304     C     PRPCPY        Begsr
022300020304     C                   Move      WWDTA         WUDTA
022400070809     C                   Call      'UPDPRA  '
022500020304     C                   Parm      'GETNL   '    WWRQS
022600020304     C                   Parm                    WWRTN
022700020304     C                   Parm                    WUDTA
022800070815     C                   Parm                    TRAMTA
022900070910     C                   Parm                    RADate
022901080612     C                   Parm                    REVRSN
022902080627     C                   Parm                    REVCOD
023000020304B1   C                   IF        WWRTN <> *BLANKS
023100020304     C                   Movel     WTM(4)        WWMSG
023200020304     C                   Exsr      SNDMSG
023300020304     C                   Move      'ERROR   '    WORTN
023400020304     C                   Move      'END'         WWSTT
023500020304X1   C                   Else
023600020304     C                   Move      'Y'           WWCHG
023700020304E1   C                   Endif
023800020304     C                   Endsr
023900020304      *___________________________________________________________________
024000020304      * Default Data
024100020304      *___________________________________________________________________
024200020304     C     DFTDTA        Begsr
024201080716     C                   If        WWMSG   <>    WTM(8)
024300070809     C                   Call      'CHKPRA  '
024400020304     C                   Parm      'DFTDTA'      WWRQS
024500020304     C                   Parm                    WWRTN
024600020304     C                   Parm                    WUDTA
024601080630     C                   Parm                    REVRSN
024602080630     C                   Parm                    REVCOD
024700020304B1   C                   IF        WWRTN <> *BLANKS
024800020304     C                   Movel     WTM(7)        WWMSG
024900020304     C                   Exsr      SNDMSG
025000020304     C                   Move      'ERROR   '    WORTN
025100020304     C                   Move      'END'         WWSTT
025200020304E1   C                   Endif
025201080716E1   C                   Endif
025300020304     C                   Endsr
025400020304      *___________________________________________________________________
025500020304      * Process ERROR function
025600020304      *___________________________________________________________________
025700020304     C     PRCERR        Begsr
025800020304     C                   Move      WTM(1)        WWMSG
025900020304     C                   Exsr      SNDMSG
026000020304     C                   Move      'ERROR   '    WORTN
026100020304     C                   Move      'END'         WWSTT
026200020304     C                   Endsr
026300020304      *___________________________________________________________________
026400020304      * Receive messages
026500020304      *___________________________________________________________________
026600020304     C     RCVMSG        Begsr
026700020304B1   C                   IF        WWMSGC <> 'NORESET'
026800020304     C                   Movel     'RECEIVE'     WWRQS
026900020304X1   C                   Else
027000020304     C                   Movel     'DISPLAY'     WWRQS
027100020304E1   C                   Endif
027200020304     C                   Movel     'RESET   '    WWMSGC
027300020304     C                   Movea     *IN           WWIN
027400020304     C                   Call      'PRCMSG2'
027500020304     C                   Parm                    WWRQS
027600020304     C                   Parm                    WWIN
027700020304     C                   Parm                    WWRTN
027800020304     C                   Movea     WWIN          *IN
027900020304     C                   Endsr
028000020304      *___________________________________________________________________
028100020304      * Display panels
028200020304      *___________________________________________________________________
028300020304     C     DSPPNL        Begsr
028400020304      *
028500020304      * Set PUTOVR based on last display file processed
028600020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
028700020304     C                   MOVE      *OFF          *IN35
028800020304     C                   Move      WQPGMN        WUPGM
028900020304     C                   Move      WWPNL         WWPNLO
029000020304X1   C                   Else
029100020304     C                   MOVE      *ON           *IN35
029200020304E1   C                   Endif
029300020304      *
029400020304      * Set PROTECT key based on request
029500020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
029600020304     C                             WWTSK = 'COPY  '
029700020304 001 C                   Setoff                                       40
029800020304X001 C                   Else
029900020304 001 C                   Seton                                        40
030000020304E001 C                   Endif
030100020304      *
030200020304      * Select title
030300020304     C                   IF        WWTSK = 'CHANGE'
030400020304 001 C                   MOVE      *OFF          *IN38
030500020304X001 C                   Else
030600020304 001 C                   MOVE      *ON           *IN38
030700020304E001 C                   Endif
030800020304      *
030900020304      * Position cursor based on error status
031000020304     C                   IF        WWERR = 'Y'
031100020304 001 C                   MOVE      *ON           *IN99
031200020304X001 C                   Else
031300020304 001 C                   MOVE      *OFF          *IN99
031400020304E001 C                   Endif
031500020304      *
031600020304      * Write message subfile
031700020304     C                   Seton                                        30
031800020304     C                   Write     MSGCTL
031900020304      *
032000020304      * Write entry panel
032100020304B001 C                   Select
032200020304     C                   WHEN      WWPNL = 1
032201080625     C                   Eval      REVFLG  = ' '
032202080625     C                   If        RADATE = 0
032203080625     C     HistKey       Chain     HISTL7
032204080625     C                   If        %found
032205080625     C                   Eval      REVFLG  = 'R'
032206080625     C                   End
032207080625     C                   Else
032208080625     C     RADATE        Mult      10000.0001    RADATE2
032209080625     C     HistKey       setll     HISTL7
032210080625     C     HistKey       reade     HISTL7
032211080625     C                   Dow       not %eof(HISTL7)
032212080625     C                   If        RADATE2 = H7RECVDT
032213080625     C                   Eval      REVFLG  = 'R'
032214080625     C                   End
032215080625     C     HistKey       reade     HISTL7
032216080625     C                   Enddo
032217080625     C                   End
032218080625     C                   If        REVFLG <> 'R'
032300020304 001 C                   Exfmt     ENTPNL
032400020304 001 C                   Setoff                                       37
032402080625     C                   Else
032403080715     C                   Movel     *Blanks       WWMSG
032404080625     C                   Movel     WTM(8)        WWMSG
032405080625     C                   Exsr      SNDMSG
032406080625     C                   Move      'ERROR   '    WORTN
032407080625     C                   Move      'END'         WWSTT
032408080625     C                   End
032500020304E001 C                   Endsl
032600020304      *
032700070815B001 C***********        If        *IN39 = *ON
032800070815      *
032900070815      * Nothing is changing on the screen so In39 cannot determine change.
033000070815      * The user presses F10 to confirm payment reversal, so use In10.
033100070815     C                   If        *IN10 = *On
033200020304 001 C                   Move      'Y'           WWCHG
033300020304E001 C                   Endif
033400020304     C                   Endsr
033500020304      *___________________________________________________________________
033600020304      * Process function key
033700020304      *___________________________________________________________________
033800020304     C     PRCFKY        Begsr
033900020304     C                   Movea     *IN           WWIN
034000020304     C                   Call      'PRCFKY2'
034100020304     C                   Parm      'PROCESS '    WWRQS
034200020304     C     WWFKA         Parm                    WWRTN
034300020304     C                   Parm                    WAD
034400020304     C                   Parm                    WWIN
034500020304     C                   Parm                    WAF
034600020304     C                   Parm                    WIFKV
034700020304     C                   Endsr
034800020304      *___________________________________________________________________
034900020304      * Process KEYS function
035000020304      *___________________________________________________________________
035100020304     C     PRCDKY        Begsr
035200020304     C                   Z-add     1             WW
035300020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
035400020304 001 C     WWFKS         Add       1             WWFKS
035500020304 001  *
035600020304     C                   IF        WWFKS > 3
035700020304 002 C                   Z-add     1             WWFKS
035800020304E002 C                   Endif
035900020304 001  *
036000020304 001 C     WWFKS         Add       WWFKS         WW
036100020304 001 C                   Sub       1             WW
036200020304E001 C                   Enddo
036300020304      *
036400020304     C                   Movel     WAD(WW)       WSFKD1
036500020304     C                   Add       1             WW
036600020304     C                   Movel     WAD(WW)       WSFKD2
036700020304     C                   Endsr
036800020304      *___________________________________________________________________
036900020304      * Process EXIT Function
037000020304      *___________________________________________________________________
037100020304     C     PRCEXT        Begsr
037200020304      *
037300020304     C                   Exsr      PRCPNL
037400020304      *
037500020304     C                   IF        WWERR = 'Y'
037600020304 001 C                   Move      *BLANKS       WWSTT
037700020304X001 C                   Else
037800020304 001 C                   Movel     WWFKA         WORTN
037900020304 001 C                   Move      'END'         WWSTT
038000020304E001 C                   Endif
038100020304     C                   Endsr
038200020304      *___________________________________________________________________
038300020304      * Process PROMPT function
038400020304      *___________________________________________________________________
038500020304     C     PRCPMT        Begsr
038600020304     C                   Movel     WDCRSL        WWRQS
038700020304     C                   Move      'Y'           WWCHG
038800020304     C                   Move      'N'           WWWRNF
038900020304     C                   Movel     'NORESET '    WWMSGC
039000020304      *
039100080630B001 C                   Select
039200080630 001 C                   When      WSFLD = 'REVCOD'
039300080630     C                   Call      'SLCRVR'
039400080630     C                   Parm                    WWRQS
039500080630     C                   Parm                    WWRTN
039600080630     C                   Parm                    WUPGM
039700080630     C                   Parm                    REVCOD
039800080630     C                   IF        WWRTN = *BLANKS
039801080716     C                   Clear                   REVRSN
039802080701     C     REVCOD        Chain     RVRCOD
039803080701     C                   If        %Found(RVRCOD)
040000080630     C                   EVAL      WSDESC   =    RVDESC
040001080701     C                   Else
040002080701     C                   Eval      WSDESC   =    %Trim('Reversal Reason Cod+
040003080701     C                                           e Not on File')
040100080630E001 C                   Endif
040101080701E001 C                   Endif
040200020304 001  *
040300080630 001 C                   Other
040400080630 001 C                   Move      WTM(6)        WWMSG
040500080630 001 C                   Exsr      SNDMSG
040600080630E001 C                   Endsl
040700020304      *
040800020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
040900020304     C                   Movel     WDCRSL        WWCRSL
041000020304     C     WWCRSN        Div       256           WSROW
041100020304     C                   Mvr                     WSLIN
041200020304     C                   Seton                                        37
041300020304      *
041400020304     C                   Endsr
041500020304      *___________________________________________________________________
041600020304      * Process CANCEL Function
041700020304      *___________________________________________________________________
041800020304     C     PRCCNL        Begsr
041900020304     C                   Movel     WWFKA         WORTN
042000020304     C                   Move      'END'         WWSTT
042100020304     C                   Move      'N'           WWCHG
042200020304     C                   Endsr
042300020304      *___________________________________________________________________
042400020304      * Process ROLLUP function
042500020304      *___________________________________________________________________
042600020304     C     PRCRUP        Begsr
042700020304     C     WWPNL         Add       1             WWPNL
042800020304     C                   IF        WWPNL > WWPNLN
042900020304 001 C     WWPNL         Sub       1             WWPNL
043000020304E001 C                   Endif
043100020304     C                   Movel     'NORESET '    WWMSGC
043200020304     C                   Endsr
043300020304      *___________________________________________________________________
043400020304      * Process ROLLDOWN function
043500020304      *___________________________________________________________________
043600020304     C     PRCRDN        Begsr
043700020304     C     WWPNL         Sub       1             WWPNL
043800020304     C                   IF        WWPNL < 1
043900020304 001 C     WWPNL         Add       1             WWPNL
044000020304E001 C                   Endif
044100020304     C                   Movel     'NORESET '    WWMSGC
044200020304     C                   Endsr
044300020304      *___________________________________________________________________
044400020304      * Process ENTER function
044500020304      *___________________________________________________________________
044600020304     C     PRCPNL        Begsr
044601080716     C                   If        WWMSG   <>    WTM(8)
044700020304     C                   Move      *BLANKS       WWRTN
044800020304     C                   Movea     *ZEROS        *IN(60)
044900020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
045000020304 001 C                   Move      'N'           WWWRNF
045100020304     C                   IF        WWTSK = 'CHANGE  '
045200070809 001 C                   Call      'CHKPRA  '
045300020304 001 C                   Parm      'EDTCHG  '    WWRQS
045400020304 001 C                   Parm                    WWRTN
045500020304 001 C                   Parm                    WUDTA
045501080630     C                   Parm                    REVRSN
045502080630     C                   Parm                    REVCOD
045600020304     C                   ELSE
045700070809 001 C                   Call      'CHKPRA  '
045800020304 001 C                   Parm      'EDTADD  '    WWRQS
045900020304 001 C                   Parm                    WWRTN
046000020304 001 C                   Parm                    WUDTA
046001080630     C                   Parm                    REVRSN
046002080630     C                   Parm                    REVCOD
046100020304E001 C                   Endif
046200020304E001 C                   Endif
046300020304      *
046400020304B001 C                   Select
046500020304     C                   WHEN      WWRTN = *BLANKS
046600020304 001 C                   Move      'N'           WWERR
046601101129     C     REVCOD        Chain     RVRCOD
046602101129     C                   Eval      WSDESC = RVDESC
046700020304 001  *
046800020304     C                   WHEN      WWRTN = 'WARNING'
046900020304     C                   IF        WWWRNF = 'Y'
047000020304 002 C                   Move      'N'           WWERR
047100020304X002 C                   Else
047200020304 002 C                   Move      'Y'           WWWRNF
047300020304 002 C                   Move      'Y'           WWERR
047400020304E002 C                   Endif
047500020304 001  *
047600020304     C                   WHEN      WWRTN = 'ERROR  '
047700020304 001 C                   Move      'Y'           WWERR
047702080715sztstC                   If        WWMSG  <>     WTM(8)
047800020304 001 C                   Move      *BLANKS       WWSTT
047801080715sztstC                   End
047900020304 001 C                   Move      'N'           WWWRNF
048000020304E001 C                   Endsl
048001080716      *
048002080716     C                   End
048100020304      *
048200020304     C                   Endsr
048300020304      *___________________________________________________________________
048400020304      * Process end - write data or release record
048500020304      *___________________________________________________________________
048600020304     C     PRCEND        Begsr
048700020304      *
048800020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
048900020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
049000020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
049100020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
049200020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
049300020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
049400020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
049500020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
049600020304 001 C                   Endcs
049700020304 001  *
049800020304     C                   IF        WWRTN <> *BLANKS
049900020304 002 C                   Move      *BLANKS       WWSTT
050000020304 002  *
050100020304X002 C                   Else
050200020304     C                   IF        WWFKA <> 'EXIT'
050300020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
050400020304 004 C                   Exsr      PRPPNL
050500020304E004 C                   Endif
050600020304E003 C                   Endif
050700020304E002 C                   Endif
050800020304 001  *
050900020304X001 C                   Else
051000020304 001 C                   Exsr      RELREC
051100020304E001 C                   Endif
051200020304      *
051300020304     C                   Endsr
051400020304      *___________________________________________________________________
051500020304      * Add new record
051600020304      *___________________________________________________________________
051700020304     C     WRTADD        Begsr
051800020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
051900020304     C                             WWTSK = 'COPY  '
052000020304 001 C                   Movel     'ADD    '     WWRQS
052100020304E001 C                   Endif
052200020304      *
052300020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
052400020304     C                             WWTSK = 'CPYKEY'
052500020304 001 C                   Movel     'ADDKEY '     WWRQS
052600020304E001 C                   Endif
052700020304      *
052800070809     C                   Call      'UPDPRA  '
052900020304     C                   Parm                    WWRQS
053000020304     C                   Parm                    WWRTN
053100020304     C                   Parm                    WUDTA
053200070815     C                   Parm                    TRAMTA
053300070910     C                   Parm                    RADate
053301080612     C                   Parm                    REVRSN
053302080627     C                   Parm                    REVCOD
053400020304      *
053500020304     C                   IF        WWRTN <> *BLANKS
053600020304 001 C                   Movel     WTM(3)        WWMSG
053700020304 001 C                   Exsr      SNDMSG
053800020304X001 C                   Else
053900020304E001 C                   Endif
054000020304      *
054100020304     C                   Endsr
054200020304      *___________________________________________________________________
054300020304      * Write changed record
054400020304      *___________________________________________________________________
054500020304     C     WRTCHG        Begsr
054600070809     C                   Call      'UPDPRA  '
054700020304     C                   Parm      'CHANGE'      WWRQS
054800020304     C                   Parm                    WWRTN
054900020304     C                   Parm                    WUDTA
055000070815     C                   Parm                    TRAMTA
055100070910     C                   Parm                    RADate
055101080612     C                   Parm                    REVRSN
055102080627     C                   Parm                    REVCOD
055200020304     C                   IF        WWRTN <> *BLANKS
055300020304 001 C                   Movel     WTM(2)        WWMSG
055400020304 001 C                   Exsr      SNDMSG
055500020304E001 C                   Endif
055600020304      *
055700020304     C                   Endsr
055800020304      *___________________________________________________________________
055900020304      * Release record
056000020304      *___________________________________________________________________
056100020304     C     RELREC        Begsr
056200070809     C                   Call      'UPDPRA  '
056300020304     C                   Parm      'RELEASE '    WWRQS
056400020304     C                   Parm                    WWRTN
056500020304     C                   Parm                    WUDTA
056600070815     C                   Parm                    TRAMTA
056700070910     C                   Parm                    RADate
056701080612     C                   Parm                    REVRSN
056702080627     C                   Parm                    REVCOD
056800020304     C                   IF        WWRTN <> *BLANKS
056900020304 001 C                   Movel     WTM(4)        WWMSG
057000020304 001 C                   Exsr      SNDMSG
057100020304E001 C                   Endif
057200020304     C                   Endsr
057300020304      *___________________________________________________________________
057400020304      * Build function keys
057500020304      *___________________________________________________________________
057600020304     C     BLDFKY        Begsr
057700020304     C                   Movea     *IN           WWIN
057800020304     C                   Call      'PRCFKY2'
057900020304     C                   Parm      'BUILD   '    WWRQS
058000020304     C     WWFKA         Parm                    WWRTN
058100020304     C                   Parm                    WAD
058200020304     C                   Parm                    WWIN
058300020304     C                   Parm                    WAF
058400020304     C                   Parm                    WIFKV
058500020304     C     WWFKS         Add       WWFKS         WW
058600020304     C                   Movel     WAD(WW)       WSFKD2
058700020304     C                   Sub       1             WW
058800020304     C                   Movel     WAD(WW)       WSFKD1
058900020304     C                   Endsr
059000020304      *___________________________________________________________________
059100020304      * Send message
059200020304      *___________________________________________________________________
059300020304     C     SNDMSG        Begsr
059400020304     C                   Call      'QSNDDTAQ'
059500020304     C                   Parm                    WWDTAQ
059600020304     C                   Parm                    WWLIB
059700020304     C                   Parm                    WWLNGQ
059800020304     C                   Parm                    WWMSG
059900020304     C                   Endsr
060000020304      *___________________________________________________________________
060100020304      * Paremater list
060200020304      *___________________________________________________________________
060300020304     C     PLIST         Begsr
060400020304     C     *ENTRY        Plist
060500020304     C     WWTSK         Parm                    WIRQS
060600020304     C                   Parm                    WORTN
060700020304     C                   Parm                    WUPGM
060800020304     C                   Parm                    WUDTA
061000070809     C                   Parm                    TRAMTA            9
061100070910     C                   Parm                    RADate
061101080701     C                   Parm                    WIFKV
061200020304     C                   Endsr
061300020304      *___________________________________________________________________
061400020304      * Initialize routine
061500020304      *___________________________________________________________________
061600020304     C     *INZSR        Begsr
061700020304     C     *LIKE         Define    WUDTA         WWDTA
061800020304     C     *LIKE         Define    WIRQS         WWRQS
061900020304     C     *LIKE         Define    WIRQS         WWORQS
062000020304     C     *LIKE         Define    WIRQS         WWTSK
062100020304     C     *LIKE         Define    WORTN         WWRTN
062200020304     C     *LIKE         Define    WORTN         WWFKA
062300020304     C     *LIKE         Define    WIFKV         WWFKV
062400020304     C     *LIKE         Define    WIFKV         WWOPV
062500020304     C                   Movel     'RESET   '    WWMSGC
062600020304     C                   Movel     '*'           MSPGMQ
062700020304     C                   Movel     'MSGDTAQ'     WWDTAQ
062800020304     C                   Movel     'QTEMP'       WWLIB
062900020304     C                   Z-add     80            WWLNGQ
063000020304     C                   Move      *BLANKS       WWMSG
063100020304     C                   Move      *BLANKS       WWIN
063200020304     C                   Move      *BLANKS       WWSTT
063300020304     C                   Move      *ZEROS        WWZERO
063400020304     C                   Z-add     1             WWPNL
063500020304     C                   Z-add     1             WWPNLN
063600020304     C                   Z-add     1             WWFKS
063700020304     C                   Move      'N'           WWERR
063800020304     C                   Move      'N'           WWCHG
063900020304     C                   Move      'N'           WWWRNF
064000020304     C                   Z-add     0             WW
064100070809     C                   Movel(P)  'HISTL6'      WWFIL
064200020304     C                   Move      *BLANKS       WWFLK
064300020304     C                   Move      *BLANKS       WWTXT
064400070809     C                   Move      TRAMTA        TRAMTT
064500070815     C     TRAMTT        Mult      -1            TRAMTT
064600020304     C                   Endsr
064700070809    ? *___________________________________________________________________
064800070809    ? * Key lists
064900070809    ? *___________________________________________________________________
065000070809    ?C     KLIST         Begsr
065100070809    ?C     AKey          Klist
065200070809    ?C                   Kfld                    HSTRST
065300070809    ?C                   Kfld                    HSSUB#
065400070809    ?C                   Kfld                    HSACCT
065401080625      *
065402080625    ?C     HistKey       Klist
065403080625    ?C                   Kfld                    HKey
065404080625    ?C                   Kfld                    CHECK#
065405080625      *
065406080625    ?C     HistKey2      Klist
065407080625    ?C                   Kfld                    HKey
065408080625    ?C                   Kfld                    CHECK#
065409080625     C                   Kfld                    RECVDT
065410080625      *
065500070809    ?C                   Endsr
065600020304      *___________________________________________________________________
065700020304      * Program error handler
065800020304      *___________________________________________________________________
065900020304     C     *PSSR         Begsr
066000020304     C                   Call      'SNDRPGM'                            50
066100020304     C                   Parm                    WQPGMN
066200020304     C                   Parm                    WQSTSC
066300020304     C                   Parm                    WQRPGS
066400020304     C                   Parm                    WQMSG
066500020304     C                   Endsr     '*CANCL'
066600020304      *___________________________________________________________________
066700020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06680002030403EXIT    F3=Exit
06690002030405REFRESH F5=Refresh
06690108070104PROMPT  F4=Prompt
06700007080910UPDATE  F10=Confirm Reversal
06710002030412CANCEL  F12=Cancel
06720002030425ROLLUP
06730002030426ROLLDOWN
067400020304** WTM
06750007080900Request not supported in program CHGPRA.
06760002030400Update error.  Data was not updated.
06770002030400Duplicate key detected.  Data was NOT added to file.
06780002030400Record not found.
06790002030400Record not available now.
06800002030400The cursor is not in a prompt area.
06810002030400Default error.  Data not defaulted.
06820008062500At least some parts of this check have been reversed.
