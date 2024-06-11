000100020304      *_________________________________________________________________________
000200020304      *
000300060313      *  Description:  Change RELATIONSHIP MANAGER MASTER
000400020304      *
000500060310      *  (c)Copyright 2006 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700060313     FCHGRMMD   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000020304     D WAD             S             80    DIM(6)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200020304      *_________________________________________________________________________
001300020304      * Data structure
001400060313     D WUDTA         E DS                  EXTNAME(RMGRMST0)
001500020304      *
001600020304      * Program status data structure
001700020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
001800020304      *
001900020304      * Display file data structure
002000020304     D DSPD          E DS                  EXTNAME(IODSPD)
002100020304      *
002200020304      * CURSOR LOCATION
002300020304     D                 DS
002400020304     D  WWCRSL                 1      2
002500020304     D  WWCRSN                 1      2B 0
002600020304     ***
002700020304     D WWDTA           S                   LIKE(WUDTA)
002800021008     ***
002900021008     D WIFKV           S             60A
003000021008     D WIFKY           S                   LIKE(WIFKV)
003100021008     D WIOPV           S                   LIKE(WIFKV)
003200021008     D WIRQS           S              8A
003300021008     D WORTN           S              8A
003400021008     D WUPGM           S             10A
003500021008     D WWCHG           S              1A
003600021008     D WWDLT           S              1A
003700021008     D WWDTAQ          S             10A
003800021008     D WWENDF          S              3A
003900021008     D WWENDO          S                   LIKE(WWENDF)
004000021008     D WWERR           S              1A
004100021008     D WWFIL           S             10A
004200021008     D WWFKA           S              8A
004300021008     D WWFKV           S                   LIKE(WIFKV)
004400021008     D WWFKY           S                   LIKE(WIFKV)
004500021008     D WWFLK           S            128A
004600021008     D WWFMTN          S              8A
004700021008     D WWFNC           S              8A
004800021008     D WWIJI           S             16A
004900021008     D WWIN            S             99A
005000021008     D WWLIB           S             10A
005100021008     D WWMSG           S             80A
005200021008     D WWMSGC          S              7A
005300021008     D WWOCD           S              8A
005400021008     D WWOPA           S              8A
005500021008     D WWOPN           S              1A
005600021008     D WWOPT           S              8A
005700021008     D WWOPV           S                   LIKE(WIFKV)
005800021008     D WWORQS          S                   LIKE(WIRQS)
005900021008     D WWPSNC          S              1A
006000021008     D WWQJN           S             26A
006100021008     D WWRQS           S                   LIKE(WIRQS)
006200021008     D WWRQSD          S                   LIKE(WIRQS)
006300021008     D WWRTN           S                   LIKE(WORTN)
006400021008     D WWRTND          S                   LIKE(WORTN)
006500021008     D WWRTNH          S                   LIKE(WORTN)
006600021008     D WWSFLE          S              1A
006700021008     D WWSTT           S              3A
006800021008     D WWTSK           S              8A
006900021008     D WWTXT           S             60A
007000021008     D WWUPD           S              1A
007100021008     D WWWRNF          S              1A
007200021008     D WWZERO          S             40A
007300021008     D WFRRN           S              4P 0
007400021008     D WW              S              3P 0
007500021008     D WWFKS           S              1P 0
007600021008     D WWFKSO          S                   LIKE(WWFKS)
007700021008     D WWLMT           S              2P 0
007800021008     D WWLNG           S             15P 5
007900021008     D WWLNGQ          S              5P 0
008000021008     D WWLOWR          S              4P 0
008100021008     D WWLSTS          S              2P 0
008200021008     D WWOPS           S              1P 0
008300021008     D WWOPSO          S                   LIKE(WWOPS)
008400021008     D WWPNL           S              1P 0
008500021008     D WWPNLN          S                   LIKE(WWPNL)
008600021008     D WWPNLO          S                   LIKE(WWPNL)
008700021008     D WWPSNI          S              2P 0
008800021008     D WWPSNN          S              1P 0
008900021008     D WWPSNP          S                   LIKE(WWPSNN)
009000021008     D WWRRN           S              4P 0
009100020304     ***
009200020304      *_________________________________________________________________________
009300020304      *
009400020304      * Process Entry Panel
009500020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
009600020304     C                   Move      WUDTA         WWDTA
009700020304E1   C                   ENDIF
009800020304      *
009900020304     C                   Exsr      PRPPNL
010000020304      *
010100020304B1   C                   DOW       WWSTT <> 'END'
010200020304     C                   Exsr      RCVMSG
010300020304     C                   Exsr      DSPPNL
010400020304     C                   Exsr      PRCFKY
010500020304      *
010600020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
010700020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
010800020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
010900020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
011000020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
011100020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
011200020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
011300020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
011400020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
011500020304E2   C                   Endcs
011600020304      *
011700020304B2   C                   IF        WWSTT = 'END'
011800020304     C                   Exsr      PRCEND
011900020304E2   C                   Endif
012000020304E1   C                   Enddo
012100020304      *
012200020304      * Send Info Updated message.
012300020304     C                   IF        WWCHG = 'Y'
012400020304     C                   MOVEL     'UPDATE  '    WORTN
012500020304     C                   Endif
012600020304      *
012700020304     C                   Return
012800020304      *___________________________________________________________________
012900020304      * Prepare panel
013000020304      *___________________________________________________________________
013100020304     C     PRPPNL        Begsr
013200020304     C                   Move      *BLANKS       WORTN
013300020304     C                   Move      'N'           WWERR
013400020304     C                   Move      'N'           WWCHG
013500020304     C                   Move      'N'           WWWRNF
013600020304     C                   Move      *BLANKS       WWSTT
013700020304     C                   Z-add     1             WWPNL
013800020304     C                   Z-add     1             WWFKS
013900020304     C                   Movea     WWZERO        *IN(60)
014000020304     C                   Move      *BLANKS       WWSTT
014100020304      *
014200020304B1   C                   IF        WQPGMN = WUPGM
014300020304B2   C                   IF        WIRQS <> WWORQS
014400020304     C                   Move      *BLANKS       WUPGM
014500020304E2   C                   Endif
014600020304     C                   Move      WIRQS         WWORQS
014700020304E1   C                   Endif
014800020304      *
014900020304     C                   Exsr      BLDFKY
015000020304      *
015100020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015200020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015300020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
015400020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
015500020304     C                   Cas                     PRCERR
015600020304E1   C                   Endcs
015700020304      *
015800020304      *
015900020304     C                   Endsr
016000020304      *___________________________________________________________________
016100020304      * Prepare ADD request
016200020304      *___________________________________________________________________
016300020304     C     PRPADD        Begsr
016400020304     C                   Clear                   WUDTA
016500020304     C                   Exsr      DFTDTA
016600020304     C                   Endsr
016700020304      *___________________________________________________________________
016800020304      * Prepare CHANGE request
016900020304      *___________________________________________________________________
017000020304     C     PRPCHG        Begsr
017100060313     C                   Call      'UPDRMM  '
017200020304     C                   Parm      'GET     '    WWRQS
017300020304     C                   Parm                    WWRTN
017400020304     C                   Parm                    WUDTA
017500020304B1   C                   IF        WWRTN <> *BLANKS
017600020304B2   C                   IF        WWRTN = 'NOTAVL'
017700020304     C                   Movel     WTM(5)        WWMSG
017800020304X2   C                   Else
017900020304     C                   Movel     WTM(4)        WWMSG
018000020304E2   C                   Endif
018100020304     C                   Exsr      SNDMSG
018200020304     C                   Move      'ERROR   '    WORTN
018300020304     C                   Move      'END'         WWSTT
018400020304E1   C                   End
018500020304     C                   Endsr
018600020304      *___________________________________________________________________
018700020304      * Prepare COPY request
018800020304      *___________________________________________________________________
018900020304     C     PRPCPY        Begsr
019000020304     C                   Move      WWDTA         WUDTA
019100060313     C                   Call      'UPDRMM  '
019200020304     C                   Parm      'GETNL   '    WWRQS
019300020304     C                   Parm                    WWRTN
019400020304     C                   Parm                    WUDTA
019500020304B1   C                   IF        WWRTN <> *BLANKS
019600020304     C                   Movel     WTM(4)        WWMSG
019700020304     C                   Exsr      SNDMSG
019800020304     C                   Move      'ERROR   '    WORTN
019900020304     C                   Move      'END'         WWSTT
020000020304X1   C                   Else
020100020304     C                   Move      'Y'           WWCHG
020200020304     ***                 Clear                   MSMSID
020300020304E1   C                   Endif
020400020304     C                   Endsr
020500020304      *___________________________________________________________________
020600020304      * Default Data
020700020304      *___________________________________________________________________
020800020304     C     DFTDTA        Begsr
020900060313     C                   Call      'CHKRMM  '
021000020304     C                   Parm      'DFTDTA'      WWRQS
021100020304     C                   Parm                    WWRTN
021200020304     C                   Parm                    WUDTA
021300020304B1   C                   IF        WWRTN <> *BLANKS
021400020304     C                   Movel     WTM(7)        WWMSG
021500020304     C                   Exsr      SNDMSG
021600020304     C                   Move      'ERROR   '    WORTN
021700020304     C                   Move      'END'         WWSTT
021800020304E1   C                   Endif
021900020304     C                   Endsr
022000020304      *___________________________________________________________________
022100020304      * Process ERROR function
022200020304      *___________________________________________________________________
022300020304     C     PRCERR        Begsr
022400020304     C                   Move      WTM(1)        WWMSG
022500020304     C                   Exsr      SNDMSG
022600020304     C                   Move      'ERROR   '    WORTN
022700020304     C                   Move      'END'         WWSTT
022800020304     C                   Endsr
022900020304      *___________________________________________________________________
023000020304      * Receive messages
023100020304      *___________________________________________________________________
023200020304     C     RCVMSG        Begsr
023300020304B1   C                   IF        WWMSGC <> 'NORESET'
023400020304     C                   Movel     'RECEIVE'     WWRQS
023500020304X1   C                   Else
023600020304     C                   Movel     'DISPLAY'     WWRQS
023700020304E1   C                   Endif
023800020304     C                   Movel     'RESET   '    WWMSGC
023900020304     C                   Movea     *IN           WWIN
024000020304     C                   Call      'PRCMSG2'
024100020304     C                   Parm                    WWRQS
024200020304     C                   Parm                    WWIN
024300020304     C                   Parm                    WWRTN
024400020304     C                   Movea     WWIN          *IN
024500020304     C                   Endsr
024600020304      *___________________________________________________________________
024700020304      * Display panels
024800020304      *___________________________________________________________________
024900020304     C     DSPPNL        Begsr
025000020304      *
025100020304      * Set PUTOVR based on last display file processed
025200020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025300020304     C                   MOVE      *OFF          *IN35
025400020304     C                   Move      WQPGMN        WUPGM
025500020304     C                   Move      WWPNL         WWPNLO
025600020304X1   C                   Else
025700020304     C                   MOVE      *ON           *IN35
025800020304E1   C                   Endif
025900020304      *
026000020304      * Set PROTECT key based on request
026100020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026200020304     C                             WWTSK = 'COPY  '
026300020304 001 C                   Setoff                                       40
026400020304X001 C                   Else
026500020304 001 C                   Seton                                        40
026600020304E001 C                   Endif
026700020304      *
026800020304      * Select title
026900020304     C                   IF        WWTSK = 'CHANGE'
027000020304 001 C                   MOVE      *OFF          *IN38
027100020304X001 C                   Else
027200020304 001 C                   MOVE      *ON           *IN38
027300020304E001 C                   Endif
027400020304      *
027500020304      * Position cursor based on error status
027600020304     C                   IF        WWERR = 'Y'
027700020304 001 C                   MOVE      *ON           *IN99
027800020304X001 C                   Else
027900020304 001 C                   MOVE      *OFF          *IN99
028000020304E001 C                   Endif
028100020304      *
028200020304      * Write message subfile
028300020304     C                   Seton                                        30
028400020304     C                   Write     MSGCTL
028500020304      *
028600020304      * Write entry panel
028700020304B001 C                   Select
028800020304     C                   WHEN      WWPNL = 1
028900020304 001 C                   Exfmt     ENTPNL
029000020304 001 C                   Setoff                                       37
029100020304E001 C                   Endsl
029200020304      *
029300020304B001 C                   If        *IN39 = *ON
029400020304 001 C                   Move      'Y'           WWCHG
029500020304E001 C                   Endif
029600020304     C                   Endsr
029700020304      *___________________________________________________________________
029800020304      * Process function key
029900020304      *___________________________________________________________________
030000020304     C     PRCFKY        Begsr
030100020304     C                   Movea     *IN           WWIN
030200020304     C                   Call      'PRCFKY2'
030300020304     C                   Parm      'PROCESS '    WWRQS
030400020304     C     WWFKA         Parm                    WWRTN
030500020304     C                   Parm                    WAD
030600020304     C                   Parm                    WWIN
030700020304     C                   Parm                    WAF
030800020304     C                   Parm                    WIFKV
030900020304     C                   Endsr
031000020304      *___________________________________________________________________
031100020304      * Process KEYS function
031200020304      *___________________________________________________________________
031300020304     C     PRCDKY        Begsr
031400020304     C                   Z-add     1             WW
031500020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
031600020304 001 C     WWFKS         Add       1             WWFKS
031700020304 001  *
031800020304     C                   IF        WWFKS > 3
031900020304 002 C                   Z-add     1             WWFKS
032000020304E002 C                   Endif
032100020304 001  *
032200020304 001 C     WWFKS         Add       WWFKS         WW
032300020304 001 C                   Sub       1             WW
032400020304E001 C                   Enddo
032500020304      *
032600020304     C                   Movel     WAD(WW)       WSFKD1
032700020304     C                   Add       1             WW
032800020304     C                   Movel     WAD(WW)       WSFKD2
032900020304     C                   Endsr
033000020304      *___________________________________________________________________
033100020304      * Process EXIT Function
033200020304      *___________________________________________________________________
033300020304     C     PRCEXT        Begsr
033400020304      *
033500020304     C                   Exsr      PRCPNL
033600020304      *
033700020304     C                   IF        WWERR = 'Y'
033800020304 001 C                   Move      *BLANKS       WWSTT
033900020304X001 C                   Else
034000020304 001 C                   Movel     WWFKA         WORTN
034100020304 001 C                   Move      'END'         WWSTT
034200020304E001 C                   Endif
034300020304     C                   Endsr
034400020304      *___________________________________________________________________
034500020304      * Process PROMPT function
034600020304      *___________________________________________________________________
034700020304     C     PRCPMT        Begsr
034800020304     C                   Movel     WDCRSL        WWRQS
034900020304     C                   Move      'Y'           WWCHG
035000020304     C                   Move      'N'           WWWRNF
035100020304     C                   Movel     'NORESET '    WWMSGC
035200020304      *
035300020304B001 C                   Select
035400020304 001 C                   When      WSFLD = 'XXXXXX'
035500020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
035600040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
035700040305     C*                  Parm                    WWRTN                          RETURN CODE
035800040305     C*                  Parm                    WUPGM                          LAST PGM NAME
035900020304     C*                  Parm                    WDCARP                         RECORD DS
036000020304     C                   IF        WWRTN = *BLANKS
036100020304     C*                  Eval      MSCAID   =    CMCARR
036200020304     C*                  EVAL      WSCNAME  =    CMNAME
036300020304E001 C                   Endif
036400020304 001  *
036500020304 001 C                   Other
036600020304 001 C                   Move      WTM(6)        WWMSG
036700020304 001 C                   Exsr      SNDMSG
036800020304E001 C                   Endsl
036900020304      *
037000020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
037100020304     C                   Movel     WDCRSL        WWCRSL
037200020304     C     WWCRSN        Div       256           WSROW
037300020304     C                   Mvr                     WSLIN
037400020304     C                   Seton                                        37
037500020304      *
037600020304     C                   Endsr
037700020304      *___________________________________________________________________
037800020304      * Process CANCEL Function
037900020304      *___________________________________________________________________
038000020304     C     PRCCNL        Begsr
038100020304     C                   Movel     WWFKA         WORTN
038200020304     C                   Move      'END'         WWSTT
038300020304     C                   Move      'N'           WWCHG
038400020304     C                   Endsr
038500020304      *___________________________________________________________________
038600020304      * Process ROLLUP function
038700020304      *___________________________________________________________________
038800020304     C     PRCRUP        Begsr
038900020304     C     WWPNL         Add       1             WWPNL
039000020304     C                   IF        WWPNL > WWPNLN
039100020304 001 C     WWPNL         Sub       1             WWPNL
039200020304E001 C                   Endif
039300020304     C                   Movel     'NORESET '    WWMSGC
039400020304     C                   Endsr
039500020304      *___________________________________________________________________
039600020304      * Process ROLLDOWN function
039700020304      *___________________________________________________________________
039800020304     C     PRCRDN        Begsr
039900020304     C     WWPNL         Sub       1             WWPNL
040000020304     C                   IF        WWPNL < 1
040100020304 001 C     WWPNL         Add       1             WWPNL
040200020304E001 C                   Endif
040300020304     C                   Movel     'NORESET '    WWMSGC
040400020304     C                   Endsr
040500020304      *___________________________________________________________________
040600020304      * Process ENTER function
040700020304      *___________________________________________________________________
040800020304     C     PRCPNL        Begsr
040900020304     C                   Move      *BLANKS       WWRTN
041000020304     C                   Movea     *ZEROS        *IN(60)
041100020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
041200020304 001 C                   Move      'N'           WWWRNF
041300020304     C                   IF        WWTSK = 'CHANGE  '
041400060313 001 C                   Call      'CHKRMM  '
041500020304 001 C                   Parm      'EDTCHG  '    WWRQS
041600020304 001 C                   Parm                    WWRTN
041700020304 001 C                   Parm                    WUDTA
041800020304     C                   ELSE
041900060313 001 C                   Call      'CHKRMM  '
042000020304 001 C                   Parm      'EDTADD  '    WWRQS
042100020304 001 C                   Parm                    WWRTN
042200020304 001 C                   Parm                    WUDTA
042300020304E001 C                   Endif
042400020304E001 C                   Endif
042500020304      *
042600020304B001 C                   Select
042700020304     C                   WHEN      WWRTN = *BLANKS
042800020304 001 C                   Move      'N'           WWERR
042900020304 001  *
043000020304     C                   WHEN      WWRTN = 'WARNING'
043100020304     C                   IF        WWWRNF = 'Y'
043200020304 002 C                   Move      'N'           WWERR
043300020304X002 C                   Else
043400020304 002 C                   Move      'Y'           WWWRNF
043500020304 002 C                   Move      'Y'           WWERR
043600020304E002 C                   Endif
043700020304 001  *
043800020304     C                   WHEN      WWRTN = 'ERROR  '
043900020304 001 C                   Move      'Y'           WWERR
044000020304 001 C                   Move      *BLANKS       WWSTT
044100020304 001 C                   Move      'N'           WWWRNF
044200020304E001 C                   Endsl
044300020304      *
044400020304     C                   Endsr
044500020304      *___________________________________________________________________
044600020304      * Process end - write data or release record
044700020304      *___________________________________________________________________
044800020304     C     PRCEND        Begsr
044900020304      *
045000020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
045100020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
045200020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
045300020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
045400020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
045500020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
045600020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
045700020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
045800020304 001 C                   Endcs
045900020304 001  *
046000020304     C                   IF        WWRTN <> *BLANKS
046100020304 002 C                   Move      *BLANKS       WWSTT
046200020304 002  *
046300020304X002 C                   Else
046400020304     C                   IF        WWFKA <> 'EXIT'
046500020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
046600020304 004 C                   Exsr      PRPPNL
046700020304E004 C                   Endif
046800020304E003 C                   Endif
046900020304E002 C                   Endif
047000020304 001  *
047100020304X001 C                   Else
047200020304 001 C                   Exsr      RELREC
047300020304E001 C                   Endif
047400020304      *
047500020304     C                   Endsr
047600020304      *___________________________________________________________________
047700020304      * Add new record
047800020304      *___________________________________________________________________
047900020304     C     WRTADD        Begsr
048000020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
048100020304     C                             WWTSK = 'COPY  '
048200020304 001 C                   Movel     'ADD    '     WWRQS
048300020304E001 C                   Endif
048400020304      *
048500020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
048600020304     C                             WWTSK = 'CPYKEY'
048700020304 001 C                   Movel     'ADDKEY '     WWRQS
048800020304E001 C                   Endif
048900020304      *
049000060313     C                   Call      'UPDRMM  '
049100020304     C                   Parm                    WWRQS
049200020304     C                   Parm                    WWRTN
049300020304     C                   Parm                    WUDTA
049400020304      *
049500020304     C                   IF        WWRTN <> *BLANKS
049600020304 001 C                   Movel     WTM(3)        WWMSG
049700020304 001 C                   Exsr      SNDMSG
049800020304X001 C                   Else
049900020304E001 C                   Endif
050000020304      *
050100020304     C                   Endsr
050200020304      *___________________________________________________________________
050300020304      * Write changed record
050400020304      *___________________________________________________________________
050500020304     C     WRTCHG        Begsr
050600060313     C                   Call      'UPDRMM  '
050700020304     C                   Parm      'CHANGE'      WWRQS
050800020304     C                   Parm                    WWRTN
050900020304     C                   Parm                    WUDTA
051000020304     C                   IF        WWRTN <> *BLANKS
051100020304 001 C                   Movel     WTM(2)        WWMSG
051200020304 001 C                   Exsr      SNDMSG
051300020304E001 C                   Endif
051400020304      *
051500020304     C                   Endsr
051600020304      *___________________________________________________________________
051700020304      * Release record
051800020304      *___________________________________________________________________
051900020304     C     RELREC        Begsr
052000060313     C                   Call      'UPDRMM  '
052100020304     C                   Parm      'RELEASE '    WWRQS
052200020304     C                   Parm                    WWRTN
052300020304     C                   Parm                    WUDTA
052400020304     C                   IF        WWRTN <> *BLANKS
052500020304 001 C                   Movel     WTM(4)        WWMSG
052600020304 001 C                   Exsr      SNDMSG
052700020304E001 C                   Endif
052800020304     C                   Endsr
052900020304      *___________________________________________________________________
053000020304      * Build function keys
053100020304      *___________________________________________________________________
053200020304     C     BLDFKY        Begsr
053300020304     C                   Movea     *IN           WWIN
053400020304     C                   Call      'PRCFKY2'
053500020304     C                   Parm      'BUILD   '    WWRQS
053600020304     C     WWFKA         Parm                    WWRTN
053700020304     C                   Parm                    WAD
053800020304     C                   Parm                    WWIN
053900020304     C                   Parm                    WAF
054000020304     C                   Parm                    WIFKV
054100020304     C     WWFKS         Add       WWFKS         WW
054200020304     C                   Movel     WAD(WW)       WSFKD2
054300020304     C                   Sub       1             WW
054400020304     C                   Movel     WAD(WW)       WSFKD1
054500020304     C                   Endsr
054600020304      *___________________________________________________________________
054700020304      * Send message
054800020304      *___________________________________________________________________
054900020304     C     SNDMSG        Begsr
055000020304     C                   Call      'QSNDDTAQ'
055100020304     C                   Parm                    WWDTAQ
055200020304     C                   Parm                    WWLIB
055300020304     C                   Parm                    WWLNGQ
055400020304     C                   Parm                    WWMSG
055500020304     C                   Endsr
055600020304      *___________________________________________________________________
055700020304      * Paremater list
055800020304      *___________________________________________________________________
055900020304     C     PLIST         Begsr
056000020304     C     *ENTRY        Plist
056100020304     C     WWTSK         Parm                    WIRQS
056200020304     C                   Parm                    WORTN
056300020304     C                   Parm                    WUPGM
056400020304     C                   Parm                    WUDTA
056500020304     C                   Parm                    WIFKV
056600020304     C                   Endsr
056700020304      *___________________________________________________________________
056800020304      * Initialize routine
056900020304      *___________________________________________________________________
057000020304     C     *INZSR        Begsr
057100020304     C     *LIKE         Define    WUDTA         WWDTA
057200020304     C     *LIKE         Define    WIRQS         WWRQS
057300020304     C     *LIKE         Define    WIRQS         WWORQS
057400020304     C     *LIKE         Define    WIRQS         WWTSK
057500020304     C     *LIKE         Define    WORTN         WWRTN
057600020304     C     *LIKE         Define    WORTN         WWFKA
057700020304     C     *LIKE         Define    WIFKV         WWFKV
057800020304     C     *LIKE         Define    WIFKV         WWOPV
057900020304     C                   Movel     'RESET   '    WWMSGC
058000020304     C                   Movel     '*'           MSPGMQ
058100020304     C                   Movel     'MSGDTAQ'     WWDTAQ
058200020304     C                   Movel     'QTEMP'       WWLIB
058300020304     C                   Z-add     80            WWLNGQ
058400020304     C                   Move      *BLANKS       WWMSG
058500020304     C                   Move      *BLANKS       WWIN
058600020304     C                   Move      *BLANKS       WWSTT
058700020304     C                   Move      *ZEROS        WWZERO
058800020304     C                   Z-add     1             WWPNL
058900020304     C                   Z-add     1             WWPNLN
059000020304     C                   Z-add     1             WWFKS
059100020304     C                   Move      'N'           WWERR
059200020304     C                   Move      'N'           WWCHG
059300020304     C                   Move      'N'           WWWRNF
059400020304     C                   Z-add     0             WW
059500060313     C                   Movel(P)  'RMGRMST0'    WWFIL
059600020304     C                   Move      *BLANKS       WWFLK
059700020304     C                   Move      *BLANKS       WWTXT
059800020304     C                   Endsr
059900020304      *___________________________________________________________________
060000020304      * Program error handler
060100020304      *___________________________________________________________________
060200020304     C     *PSSR         Begsr
060300020304     C                   Call      'SNDRPGM'                            50
060400020304     C                   Parm                    WQPGMN
060500020304     C                   Parm                    WQSTSC
060600020304     C                   Parm                    WQRPGS
060700020304     C                   Parm                    WQMSG
060800020304     C                   Endsr     '*CANCL'
060900020304      *___________________________________________________________________
061000020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06110002030403EXIT    F3=Exit
06120002030404PROMPT  F4=Prompt
06130002030405REFRESH F5=Refresh
06140002030410UPDATE  F10=Update
06150002030412CANCEL  F12=Cancel
06160002030425ROLLUP
06170002030426ROLLDOWN
061800020304** WTM
06190006031300Request not supported in program CHGRMM.
06200002030400Update error.  Data was not updated.
06210002030400Duplicate key detected.  Data was NOT added to file.
06220002030400Record not found.
06230002030400Record not available now.
06240002030400The cursor is not in a prompt area.
06250002030400Default error.  Data not defaulted.
