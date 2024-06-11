000100020304      *_________________________________________________________________________
000200020304      *
000300060315      *  Description:  Change AGENCY RELATIONSHIP MANAGERS
000400020304      *
000500060310      *  (c)Copyright 2006 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700060315     FCHGARMD   CF   E             WORKSTN INFDS(DSPD)
000800060315     FAGENCY    IF   E           K DISK
000900060315     FRMGRMST0  IF   E           K DISK
001000020304      *
001100020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001200020304     D WAD             S             80    DIM(6)
001300020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001400020304      *_________________________________________________________________________
001500020304      * Data structure
001600060315     D WUDTA         E DS                  EXTNAME(AGCYRMG0)
001700060315     D WDRMM         E DS                  EXTNAME(RMGRMST0)
001800060315     D WDAGCY        E DS                  EXTNAME(AGENCY)
001900020304      *
002000020304      * Program status data structure
002100020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200020304      *
002300020304      * Display file data structure
002400020304     D DSPD          E DS                  EXTNAME(IODSPD)
002500020304      *
002600020304      * CURSOR LOCATION
002700020304     D                 DS
002800020304     D  WWCRSL                 1      2
002900020304     D  WWCRSN                 1      2B 0
003000020304     ***
003100020304     D WWDTA           S                   LIKE(WUDTA)
003200021008     ***
003300021008     D WIFKV           S             60A
003400021008     D WIFKY           S                   LIKE(WIFKV)
003500021008     D WIOPV           S                   LIKE(WIFKV)
003600021008     D WIRQS           S              8A
003700021008     D WORTN           S              8A
003800021008     D WUPGM           S             10A
003900021008     D WWCHG           S              1A
004000021008     D WWDLT           S              1A
004100021008     D WWDTAQ          S             10A
004200021008     D WWENDF          S              3A
004300021008     D WWENDO          S                   LIKE(WWENDF)
004400021008     D WWERR           S              1A
004500021008     D WWFIL           S             10A
004600021008     D WWFKA           S              8A
004700021008     D WWFKV           S                   LIKE(WIFKV)
004800021008     D WWFKY           S                   LIKE(WIFKV)
004900021008     D WWFLK           S            128A
005000021008     D WWFMTN          S              8A
005100021008     D WWFNC           S              8A
005200021008     D WWIJI           S             16A
005300021008     D WWIN            S             99A
005400021008     D WWLIB           S             10A
005500021008     D WWMSG           S             80A
005600021008     D WWMSGC          S              7A
005700021008     D WWOCD           S              8A
005800021008     D WWOPA           S              8A
005900021008     D WWOPN           S              1A
006000021008     D WWOPT           S              8A
006100021008     D WWOPV           S                   LIKE(WIFKV)
006200021008     D WWORQS          S                   LIKE(WIRQS)
006300021008     D WWPSNC          S              1A
006400021008     D WWQJN           S             26A
006500021008     D WWRQS           S                   LIKE(WIRQS)
006600021008     D WWRQSD          S                   LIKE(WIRQS)
006700021008     D WWRTN           S                   LIKE(WORTN)
006800021008     D WWRTND          S                   LIKE(WORTN)
006900021008     D WWRTNH          S                   LIKE(WORTN)
007000021008     D WWSFLE          S              1A
007100021008     D WWSTT           S              3A
007200021008     D WWTSK           S              8A
007300021008     D WWTXT           S             60A
007400021008     D WWUPD           S              1A
007500021008     D WWWRNF          S              1A
007600021008     D WWZERO          S             40A
007700021008     D WFRRN           S              4P 0
007800021008     D WW              S              3P 0
007900021008     D WWFKS           S              1P 0
008000021008     D WWFKSO          S                   LIKE(WWFKS)
008100021008     D WWLMT           S              2P 0
008200021008     D WWLNG           S             15P 5
008300021008     D WWLNGQ          S              5P 0
008400021008     D WWLOWR          S              4P 0
008500021008     D WWLSTS          S              2P 0
008600021008     D WWOPS           S              1P 0
008700021008     D WWOPSO          S                   LIKE(WWOPS)
008800021008     D WWPNL           S              1P 0
008900021008     D WWPNLN          S                   LIKE(WWPNL)
009000021008     D WWPNLO          S                   LIKE(WWPNL)
009100021008     D WWPSNI          S              2P 0
009200021008     D WWPSNN          S              1P 0
009300021008     D WWPSNP          S                   LIKE(WWPSNN)
009400021008     D WWRRN           S              4P 0
009500020304     ***
009600020304      *_________________________________________________________________________
009700020304      *
009800020304      * Process Entry Panel
009900020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
010000020304     C                   Move      WUDTA         WWDTA
010100020304E1   C                   ENDIF
010200020304      *
010300020304     C                   Exsr      PRPPNL
010400020304      *
010500020304B1   C                   DOW       WWSTT <> 'END'
010600020304     C                   Exsr      RCVMSG
010700020304     C                   Exsr      DSPPNL
010800020304     C                   Exsr      PRCFKY
010900020304      *
011000020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
011100020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
011200020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
011300020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
011400020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
011500020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
011600020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
011700020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
011800020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
011900020304E2   C                   Endcs
012000020304      *
012100020304B2   C                   IF        WWSTT = 'END'
012200020304     C                   Exsr      PRCEND
012300020304E2   C                   Endif
012400020304E1   C                   Enddo
012500020304      *
012600020304      * Send Info Updated message.
012700020304     C                   IF        WWCHG = 'Y'
012800020304     C                   MOVEL     'UPDATE  '    WORTN
012900020304     C                   Endif
013000020304      *
013100020304     C                   Return
013200020304      *___________________________________________________________________
013300020304      * Prepare panel
013400020304      *___________________________________________________________________
013500020304     C     PRPPNL        Begsr
013600020304     C                   Move      *BLANKS       WORTN
013700020304     C                   Move      'N'           WWERR
013800020304     C                   Move      'N'           WWCHG
013900020304     C                   Move      'N'           WWWRNF
014000020304     C                   Move      *BLANKS       WWSTT
014100020304     C                   Z-add     1             WWPNL
014200020304     C                   Z-add     1             WWFKS
014300020304     C                   Movea     WWZERO        *IN(60)
014400020304     C                   Move      *BLANKS       WWSTT
014500020304      *
014600020304B1   C                   IF        WQPGMN = WUPGM
014700020304B2   C                   IF        WIRQS <> WWORQS
014800020304     C                   Move      *BLANKS       WUPGM
014900020304E2   C                   Endif
015000020304     C                   Move      WIRQS         WWORQS
015100020304E1   C                   Endif
015200020304      *
015300020304     C                   Exsr      BLDFKY
015400020304      *
015500020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015600020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015700020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
015800020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
015900020304     C                   Cas                     PRCERR
016000020304E1   C                   Endcs
016100020304      *
016200020304      *
016300020304     C                   Endsr
016400020304      *___________________________________________________________________
016500020304      * Prepare ADD request
016600020304      *___________________________________________________________________
016700020304     C     PRPADD        Begsr
016800020304     C                   Clear                   WUDTA
016900020304     C                   Exsr      DFTDTA
017000020304     C                   Endsr
017100020304      *___________________________________________________________________
017200020304      * Prepare CHANGE request
017300020304      *___________________________________________________________________
017400020304     C     PRPCHG        Begsr
017500060315     C                   Call      'UPDARM  '
017600020304     C                   Parm      'GET     '    WWRQS
017700020304     C                   Parm                    WWRTN
017800020304     C                   Parm                    WUDTA
017900020304B1   C                   IF        WWRTN <> *BLANKS
018000020304B2   C                   IF        WWRTN = 'NOTAVL'
018100020304     C                   Movel     WTM(5)        WWMSG
018200020304X2   C                   Else
018300020304     C                   Movel     WTM(4)        WWMSG
018400020304E2   C                   Endif
018500020304     C                   Exsr      SNDMSG
018600020304     C                   Move      'ERROR   '    WORTN
018700020304     C                   Move      'END'         WWSTT
018800020304E1   C                   End
018900020304     C                   Endsr
019000020304      *___________________________________________________________________
019100020304      * Prepare COPY request
019200020304      *___________________________________________________________________
019300020304     C     PRPCPY        Begsr
019400020304     C                   Move      WWDTA         WUDTA
019500060315     C                   Call      'UPDARM  '
019600020304     C                   Parm      'GETNL   '    WWRQS
019700020304     C                   Parm                    WWRTN
019800020304     C                   Parm                    WUDTA
019900020304B1   C                   IF        WWRTN <> *BLANKS
020000020304     C                   Movel     WTM(4)        WWMSG
020100020304     C                   Exsr      SNDMSG
020200020304     C                   Move      'ERROR   '    WORTN
020300020304     C                   Move      'END'         WWSTT
020400020304X1   C                   Else
020500020304     C                   Move      'Y'           WWCHG
020600020304     ***                 Clear                   MSMSID
020700020304E1   C                   Endif
020800020304     C                   Endsr
020900020304      *___________________________________________________________________
021000020304      * Default Data
021100020304      *___________________________________________________________________
021200020304     C     DFTDTA        Begsr
021300060315     C                   Call      'CHKARM  '
021400020304     C                   Parm      'DFTDTA'      WWRQS
021500020304     C                   Parm                    WWRTN
021600020304     C                   Parm                    WUDTA
021700020304B1   C                   IF        WWRTN <> *BLANKS
021800020304     C                   Movel     WTM(7)        WWMSG
021900020304     C                   Exsr      SNDMSG
022000020304     C                   Move      'ERROR   '    WORTN
022100020304     C                   Move      'END'         WWSTT
022200020304E1   C                   Endif
022300020304     C                   Endsr
022400020304      *___________________________________________________________________
022500020304      * Process ERROR function
022600020304      *___________________________________________________________________
022700020304     C     PRCERR        Begsr
022800020304     C                   Move      WTM(1)        WWMSG
022900020304     C                   Exsr      SNDMSG
023000020304     C                   Move      'ERROR   '    WORTN
023100020304     C                   Move      'END'         WWSTT
023200020304     C                   Endsr
023300020304      *___________________________________________________________________
023400020304      * Receive messages
023500020304      *___________________________________________________________________
023600020304     C     RCVMSG        Begsr
023700020304B1   C                   IF        WWMSGC <> 'NORESET'
023800020304     C                   Movel     'RECEIVE'     WWRQS
023900020304X1   C                   Else
024000020304     C                   Movel     'DISPLAY'     WWRQS
024100020304E1   C                   Endif
024200020304     C                   Movel     'RESET   '    WWMSGC
024300020304     C                   Movea     *IN           WWIN
024400020304     C                   Call      'PRCMSG2'
024500020304     C                   Parm                    WWRQS
024600020304     C                   Parm                    WWIN
024700020304     C                   Parm                    WWRTN
024800020304     C                   Movea     WWIN          *IN
024900020304     C                   Endsr
025000020304      *___________________________________________________________________
025100020304      * Display panels
025200020304      *___________________________________________________________________
025300020304     C     DSPPNL        Begsr
025400020304      *
025500020304      * Set PUTOVR based on last display file processed
025600020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025700020304     C                   MOVE      *OFF          *IN35
025800020304     C                   Move      WQPGMN        WUPGM
025900020304     C                   Move      WWPNL         WWPNLO
026000020304X1   C                   Else
026100020304     C                   MOVE      *ON           *IN35
026200020304E1   C                   Endif
026300020304      *
026400020304      * Set PROTECT key based on request
026500020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026600020304     C                             WWTSK = 'COPY  '
026700020304 001 C                   Setoff                                       40
026800020304X001 C                   Else
026900020304 001 C                   Seton                                        40
027000020304E001 C                   Endif
027100020304      *
027200020304      * Select title
027300020304     C                   IF        WWTSK = 'CHANGE'
027400020304 001 C                   MOVE      *OFF          *IN38
027500020304X001 C                   Else
027600020304 001 C                   MOVE      *ON           *IN38
027700020304E001 C                   Endif
027800020304      *
027900020304      * Position cursor based on error status
028000020304     C                   IF        WWERR = 'Y'
028100020304 001 C                   MOVE      *ON           *IN99
028200020304X001 C                   Else
028300020304 001 C                   MOVE      *OFF          *IN99
028400020304E001 C                   Endif
028500020304      *
028600020304      * Write message subfile
028700020304     C                   Seton                                        30
028800020304     C                   Write     MSGCTL
028900020304      *
029000060315     C                   EXSR      $GETDESC
029100060315      *
029200020304      * Write entry panel
029300020304B001 C                   Select
029400020304     C                   WHEN      WWPNL = 1
029500020304 001 C                   Exfmt     ENTPNL
029600020304 001 C                   Setoff                                       37
029700020304E001 C                   Endsl
029800020304      *
029900020304B001 C                   If        *IN39 = *ON
030000020304 001 C                   Move      'Y'           WWCHG
030100020304E001 C                   Endif
030200020304     C                   Endsr
030300060315   S***S
030400060315     C     $GETDESC      BEGSR
030500060315      *
030600060315     C                   IF        ARAGCY = *BLANKS
030700060315     C                   EVAL      D_AGCY = '*ERROR'
030800060315     C                   ELSE
030900060315     C     ARAGCY        CHAIN     AGENR
031000060315     C                   IF        %FOUND(AGENCY)
031100060315     C                   EVAL      D_AGCY  = AGNAM1
031200060315     C                   ELSE
031300060315     C                   EVAL      D_AGCY  = '*ERROR'
031400060315     C                   ENDIF
031500060315     C                   ENDIF
031600060315      *
031700060315     C                   IF        ARSGR = *BLANKS
031800060315     C                   EVAL      D_SGR  = '*ERROR'
031900060315     C                   ELSE
032000060315     C     ARSGR         CHAIN     RMGRMSTR
032100060315     C                   IF        %FOUND(RMGRMST0)
032200060315     C                   EVAL      D_SGR   = RMNAME
032300060315     C                   ELSE
032400060315     C                   EVAL      D_SGR   = '*ERROR'
032500060315     C                   ENDIF
032600060315     C                   ENDIF
032700060315      *
032800060315     C                   IF        ARLGR = *BLANKS
032900060315     C                   EVAL      D_LGR  = '*ERROR'
033000060315     C                   ELSE
033100060315     C     ARLGR         CHAIN     RMGRMSTR
033200060315     C                   IF        %FOUND(RMGRMST0)
033300060315     C                   EVAL      D_LGR   = RMNAME
033400060315     C                   ELSE
033500060315     C                   EVAL      D_LGR   = '*ERROR'
033600060315     C                   ENDIF
033700060315     C                   ENDIF
033800060315      *
033900060315     C                   IF        ARRMGR = *BLANKS
034000060315     C                   EVAL      D_RMGR  = '*ERROR'
034100060315     C                   ELSE
034200060315     C     ARRMGR        CHAIN     RMGRMSTR
034300060315     C                   IF        %FOUND(RMGRMST0)
034400060315     C                   EVAL      D_RMGR  = RMNAME
034500060315     C                   ELSE
034600060315     C                   EVAL      D_RMGR  = '*ERROR'
034700060315     C                   ENDIF
034800060315     C                   ENDIF
034900060315      *
035000060315     C                   ENDSR
035100060315   S***S
035200020304      *___________________________________________________________________
035300020304      * Process function key
035400020304      *___________________________________________________________________
035500020304     C     PRCFKY        Begsr
035600020304     C                   Movea     *IN           WWIN
035700020304     C                   Call      'PRCFKY2'
035800020304     C                   Parm      'PROCESS '    WWRQS
035900020304     C     WWFKA         Parm                    WWRTN
036000020304     C                   Parm                    WAD
036100020304     C                   Parm                    WWIN
036200020304     C                   Parm                    WAF
036300020304     C                   Parm                    WIFKV
036400020304     C                   Endsr
036500020304      *___________________________________________________________________
036600020304      * Process KEYS function
036700020304      *___________________________________________________________________
036800020304     C     PRCDKY        Begsr
036900020304     C                   Z-add     1             WW
037000020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
037100020304 001 C     WWFKS         Add       1             WWFKS
037200020304 001  *
037300020304     C                   IF        WWFKS > 3
037400020304 002 C                   Z-add     1             WWFKS
037500020304E002 C                   Endif
037600020304 001  *
037700020304 001 C     WWFKS         Add       WWFKS         WW
037800020304 001 C                   Sub       1             WW
037900020304E001 C                   Enddo
038000020304      *
038100020304     C                   Movel     WAD(WW)       WSFKD1
038200020304     C                   Add       1             WW
038300020304     C                   Movel     WAD(WW)       WSFKD2
038400020304     C                   Endsr
038500020304      *___________________________________________________________________
038600020304      * Process EXIT Function
038700020304      *___________________________________________________________________
038800020304     C     PRCEXT        Begsr
038900020304      *
039000020304     C                   Exsr      PRCPNL
039100020304      *
039200020304     C                   IF        WWERR = 'Y'
039300020304 001 C                   Move      *BLANKS       WWSTT
039400020304X001 C                   Else
039500020304 001 C                   Movel     WWFKA         WORTN
039600020304 001 C                   Move      'END'         WWSTT
039700020304E001 C                   Endif
039800020304     C                   Endsr
039900020304      *___________________________________________________________________
040000020304      * Process PROMPT function
040100020304      *___________________________________________________________________
040200020304     C     PRCPMT        Begsr
040300020304     C                   Movel     WDCRSL        WWRQS
040400020304     C                   Move      'Y'           WWCHG
040500020304     C                   Move      'N'           WWWRNF
040600020304     C                   Movel     'NORESET '    WWMSGC
040700020304      *
040800020304B001 C                   Select
040900020304 001  *
041000060315 001 C                   When      WSFLD = 'ARAGCY'
041100060315     C                   Call      'SLCAGNY'                                    *ENTRY LIST
041200060315     C                   Parm                    WWRQS                          PROGRAM REQUEST
041300060315     C                   Parm                    WWRTN                          RETURN CODE
041400060315     C                   Parm                    WUPGM                          LAST PGM NAME
041500060315     C                   Parm                    WDAGCY                         RECORD DS
041600060315     C                   IF        WWRTN = *BLANKS
041700060315     C                   Eval      ARAGCY  = AGCODE
041800060315     C                   MOVEL(P)  AGNAM1        D_AGCY
041900060315E001 C                   Endif
042000060315 001  *
042100060315 001 C                   When      WSFLD = 'ARSGR'
042200060315     C                   Call      'SLCRMM1'                                    *ENTRY LIST
042300060315     C                   Parm                    WWRQS                          PROGRAM REQUEST
042400060315     C                   Parm                    WWRTN                          RETURN CODE
042500060315     C                   Parm                    WUPGM                          LAST PGM NAME
042600060315     C                   Parm                    WDRMM                          RECORD DS
042700060315     C                   IF        WWRTN = *BLANKS
042800060315     C                   Eval      ARSGR = RMCODE
042900060315     C                   MOVEL(P)  RMNAME        D_SGR
043000060315E001 C                   Endif
043100060315 001  *
043200060315 001 C                   When      WSFLD = 'ARLGR'
043300060315     C                   Call      'SLCRMM2'                                    *ENTRY LIST
043400060315     C                   Parm                    WWRQS                          PROGRAM REQUEST
043500060315     C                   Parm                    WWRTN                          RETURN CODE
043600060315     C                   Parm                    WUPGM                          LAST PGM NAME
043700060315     C                   Parm                    WDRMM                          RECORD DS
043800060315     C                   IF        WWRTN = *BLANKS
043900060315     C                   Eval      ARLGR = RMCODE
044000060315     C                   MOVEL(P)  RMNAME        D_LGR
044100060315E001 C                   Endif
044200060315 001  *
044300060315 001 C                   When      WSFLD = 'ARRMGR'
044400060315     C                   Call      'SLCRMM3'                                    *ENTRY LIST
044500060315     C                   Parm                    WWRQS                          PROGRAM REQUEST
044600060315     C                   Parm                    WWRTN                          RETURN CODE
044700060315     C                   Parm                    WUPGM                          LAST PGM NAME
044800060315     C                   Parm                    WDRMM                          RECORD DS
044900060315     C                   IF        WWRTN = *BLANKS
045000060315     C                   Eval      ARRMGR = RMCODE
045100060315     C                   MOVEL(P)  RMNAME        D_RMGR
045200060315E001 C                   Endif
045300060315 001  *
045400020304 001 C                   Other
045500020304 001 C                   Move      WTM(6)        WWMSG
045600020304 001 C                   Exsr      SNDMSG
045700060315 001  *
045800020304E001 C                   Endsl
045900020304      *
046000020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
046100020304     C                   Movel     WDCRSL        WWCRSL
046200020304     C     WWCRSN        Div       256           WSROW
046300020304     C                   Mvr                     WSLIN
046400020304     C                   Seton                                        37
046500020304      *
046600020304     C                   Endsr
046700020304      *___________________________________________________________________
046800020304      * Process CANCEL Function
046900020304      *___________________________________________________________________
047000020304     C     PRCCNL        Begsr
047100020304     C                   Movel     WWFKA         WORTN
047200020304     C                   Move      'END'         WWSTT
047300020304     C                   Move      'N'           WWCHG
047400020304     C                   Endsr
047500020304      *___________________________________________________________________
047600020304      * Process ROLLUP function
047700020304      *___________________________________________________________________
047800020304     C     PRCRUP        Begsr
047900020304     C     WWPNL         Add       1             WWPNL
048000020304     C                   IF        WWPNL > WWPNLN
048100020304 001 C     WWPNL         Sub       1             WWPNL
048200020304E001 C                   Endif
048300020304     C                   Movel     'NORESET '    WWMSGC
048400020304     C                   Endsr
048500020304      *___________________________________________________________________
048600020304      * Process ROLLDOWN function
048700020304      *___________________________________________________________________
048800020304     C     PRCRDN        Begsr
048900020304     C     WWPNL         Sub       1             WWPNL
049000020304     C                   IF        WWPNL < 1
049100020304 001 C     WWPNL         Add       1             WWPNL
049200020304E001 C                   Endif
049300020304     C                   Movel     'NORESET '    WWMSGC
049400020304     C                   Endsr
049500020304      *___________________________________________________________________
049600020304      * Process ENTER function
049700020304      *___________________________________________________________________
049800020304     C     PRCPNL        Begsr
049900020304     C                   Move      *BLANKS       WWRTN
050000020304     C                   Movea     *ZEROS        *IN(60)
050100020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
050200020304 001 C                   Move      'N'           WWWRNF
050300020304     C                   IF        WWTSK = 'CHANGE  '
050400060315 001 C                   Call      'CHKARM  '
050500020304 001 C                   Parm      'EDTCHG  '    WWRQS
050600020304 001 C                   Parm                    WWRTN
050700020304 001 C                   Parm                    WUDTA
050800020304     C                   ELSE
050900060315 001 C                   Call      'CHKARM  '
051000020304 001 C                   Parm      'EDTADD  '    WWRQS
051100020304 001 C                   Parm                    WWRTN
051200020304 001 C                   Parm                    WUDTA
051300020304E001 C                   Endif
051400020304E001 C                   Endif
051500020304      *
051600020304B001 C                   Select
051700020304     C                   WHEN      WWRTN = *BLANKS
051800020304 001 C                   Move      'N'           WWERR
051900020304 001  *
052000020304     C                   WHEN      WWRTN = 'WARNING'
052100020304     C                   IF        WWWRNF = 'Y'
052200020304 002 C                   Move      'N'           WWERR
052300020304X002 C                   Else
052400020304 002 C                   Move      'Y'           WWWRNF
052500020304 002 C                   Move      'Y'           WWERR
052600020304E002 C                   Endif
052700020304 001  *
052800020304     C                   WHEN      WWRTN = 'ERROR  '
052900020304 001 C                   Move      'Y'           WWERR
053000020304 001 C                   Move      *BLANKS       WWSTT
053100020304 001 C                   Move      'N'           WWWRNF
053200020304E001 C                   Endsl
053300020304      *
053400020304     C                   Endsr
053500020304      *___________________________________________________________________
053600020304      * Process end - write data or release record
053700020304      *___________________________________________________________________
053800020304     C     PRCEND        Begsr
053900020304      *
054000020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
054100020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
054200020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
054300020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
054400020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
054500020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
054600020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
054700020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
054800020304 001 C                   Endcs
054900020304 001  *
055000020304     C                   IF        WWRTN <> *BLANKS
055100020304 002 C                   Move      *BLANKS       WWSTT
055200020304 002  *
055300020304X002 C                   Else
055400020304     C                   IF        WWFKA <> 'EXIT'
055500020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
055600020304 004 C                   Exsr      PRPPNL
055700020304E004 C                   Endif
055800020304E003 C                   Endif
055900020304E002 C                   Endif
056000020304 001  *
056100020304X001 C                   Else
056200020304 001 C                   Exsr      RELREC
056300020304E001 C                   Endif
056400020304      *
056500020304     C                   Endsr
056600020304      *___________________________________________________________________
056700020304      * Add new record
056800020304      *___________________________________________________________________
056900020304     C     WRTADD        Begsr
057000020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
057100020304     C                             WWTSK = 'COPY  '
057200020304 001 C                   Movel     'ADD    '     WWRQS
057300020304E001 C                   Endif
057400020304      *
057500020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
057600020304     C                             WWTSK = 'CPYKEY'
057700020304 001 C                   Movel     'ADDKEY '     WWRQS
057800020304E001 C                   Endif
057900020304      *
058000060315     C                   Call      'UPDARM  '
058100020304     C                   Parm                    WWRQS
058200020304     C                   Parm                    WWRTN
058300020304     C                   Parm                    WUDTA
058400020304      *
058500020304     C                   IF        WWRTN <> *BLANKS
058600020304 001 C                   Movel     WTM(3)        WWMSG
058700020304 001 C                   Exsr      SNDMSG
058800020304X001 C                   Else
058900020304E001 C                   Endif
059000020304      *
059100020304     C                   Endsr
059200020304      *___________________________________________________________________
059300020304      * Write changed record
059400020304      *___________________________________________________________________
059500020304     C     WRTCHG        Begsr
059600060315     C                   Call      'UPDARM  '
059700020304     C                   Parm      'CHANGE'      WWRQS
059800020304     C                   Parm                    WWRTN
059900020304     C                   Parm                    WUDTA
060000020304     C                   IF        WWRTN <> *BLANKS
060100020304 001 C                   Movel     WTM(2)        WWMSG
060200020304 001 C                   Exsr      SNDMSG
060300020304E001 C                   Endif
060400020304      *
060500020304     C                   Endsr
060600020304      *___________________________________________________________________
060700020304      * Release record
060800020304      *___________________________________________________________________
060900020304     C     RELREC        Begsr
061000060315     C                   Call      'UPDARM  '
061100020304     C                   Parm      'RELEASE '    WWRQS
061200020304     C                   Parm                    WWRTN
061300020304     C                   Parm                    WUDTA
061400020304     C                   IF        WWRTN <> *BLANKS
061500020304 001 C                   Movel     WTM(4)        WWMSG
061600020304 001 C                   Exsr      SNDMSG
061700020304E001 C                   Endif
061800020304     C                   Endsr
061900020304      *___________________________________________________________________
062000020304      * Build function keys
062100020304      *___________________________________________________________________
062200020304     C     BLDFKY        Begsr
062300020304     C                   Movea     *IN           WWIN
062400020304     C                   Call      'PRCFKY2'
062500020304     C                   Parm      'BUILD   '    WWRQS
062600020304     C     WWFKA         Parm                    WWRTN
062700020304     C                   Parm                    WAD
062800020304     C                   Parm                    WWIN
062900020304     C                   Parm                    WAF
063000020304     C                   Parm                    WIFKV
063100020304     C     WWFKS         Add       WWFKS         WW
063200020304     C                   Movel     WAD(WW)       WSFKD2
063300020304     C                   Sub       1             WW
063400020304     C                   Movel     WAD(WW)       WSFKD1
063500020304     C                   Endsr
063600020304      *___________________________________________________________________
063700020304      * Send message
063800020304      *___________________________________________________________________
063900020304     C     SNDMSG        Begsr
064000020304     C                   Call      'QSNDDTAQ'
064100020304     C                   Parm                    WWDTAQ
064200020304     C                   Parm                    WWLIB
064300020304     C                   Parm                    WWLNGQ
064400020304     C                   Parm                    WWMSG
064500020304     C                   Endsr
064600020304      *___________________________________________________________________
064700020304      * Paremater list
064800020304      *___________________________________________________________________
064900020304     C     PLIST         Begsr
065000020304     C     *ENTRY        Plist
065100020304     C     WWTSK         Parm                    WIRQS
065200020304     C                   Parm                    WORTN
065300020304     C                   Parm                    WUPGM
065400020304     C                   Parm                    WUDTA
065500020304     C                   Parm                    WIFKV
065600020304     C                   Endsr
065700020304      *___________________________________________________________________
065800020304      * Initialize routine
065900020304      *___________________________________________________________________
066000020304     C     *INZSR        Begsr
066100020304     C     *LIKE         Define    WUDTA         WWDTA
066200020304     C     *LIKE         Define    WIRQS         WWRQS
066300020304     C     *LIKE         Define    WIRQS         WWORQS
066400020304     C     *LIKE         Define    WIRQS         WWTSK
066500020304     C     *LIKE         Define    WORTN         WWRTN
066600020304     C     *LIKE         Define    WORTN         WWFKA
066700020304     C     *LIKE         Define    WIFKV         WWFKV
066800020304     C     *LIKE         Define    WIFKV         WWOPV
066900020304     C                   Movel     'RESET   '    WWMSGC
067000020304     C                   Movel     '*'           MSPGMQ
067100020304     C                   Movel     'MSGDTAQ'     WWDTAQ
067200020304     C                   Movel     'QTEMP'       WWLIB
067300020304     C                   Z-add     80            WWLNGQ
067400020304     C                   Move      *BLANKS       WWMSG
067500020304     C                   Move      *BLANKS       WWIN
067600020304     C                   Move      *BLANKS       WWSTT
067700020304     C                   Move      *ZEROS        WWZERO
067800020304     C                   Z-add     1             WWPNL
067900020304     C                   Z-add     1             WWPNLN
068000020304     C                   Z-add     1             WWFKS
068100020304     C                   Move      'N'           WWERR
068200020304     C                   Move      'N'           WWCHG
068300020304     C                   Move      'N'           WWWRNF
068400020304     C                   Z-add     0             WW
068500060315     C                   Movel(P)  'AGCYRMG0'    WWFIL
068600020304     C                   Move      *BLANKS       WWFLK
068700020304     C                   Move      *BLANKS       WWTXT
068800020304     C                   Endsr
068900020304      *___________________________________________________________________
069000020304      * Program error handler
069100020304      *___________________________________________________________________
069200020304     C     *PSSR         Begsr
069300020304     C                   Call      'SNDRPGM'                            50
069400020304     C                   Parm                    WQPGMN
069500020304     C                   Parm                    WQSTSC
069600020304     C                   Parm                    WQRPGS
069700020304     C                   Parm                    WQMSG
069800020304     C                   Endsr     '*CANCL'
069900020304      *___________________________________________________________________
070000020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
07010002030403EXIT    F3=Exit
07020002030404PROMPT  F4=Prompt
07030002030405REFRESH F5=Refresh
07040002030410UPDATE  F10=Update
07050002030412CANCEL  F12=Cancel
07060002030425ROLLUP
07070002030426ROLLDOWN
070800020304** WTM
07090006031500Request not supported in program CHGARM.
07100002030400Update error.  Data was not updated.
07110002030400Duplicate key detected.  Data was NOT added to file.
07120002030400Record not found.
07130002030400Record not available now.
07140002030400The cursor is not in a prompt area.
07150002030400Default error.  Data not defaulted.
