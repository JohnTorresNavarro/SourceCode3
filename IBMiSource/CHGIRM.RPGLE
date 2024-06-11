000100020304      *_________________________________________________________________________
000200020304      *
000300081230      *  Description:  Change INACTIVE REASON MAINT
000400020304      *
000500060310      *  (c)Copyright 2006 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700081230     FCHGIRMD   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000020304     D WAD             S             80    DIM(6)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200020304      *_________________________________________________________________________
001300020304      * Data structure
001400081230     D WUDTA         E DS                  EXTNAME(IRMMSTP)
001500090206     D  IMTEXT1                4     43A
001600090206     D  IMTEXT2               44     83A
001700020304      *
001800020304      * Program status data structure
001900020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000020304      *
002100020304      * Display file data structure
002200020304     D DSPD          E DS                  EXTNAME(IODSPD)
002300020304      *
002400020304      * CURSOR LOCATION
002500020304     D                 DS
002600020304     D  WWCRSL                 1      2
002700020304     D  WWCRSN                 1      2B 0
002800020304     ***
002900020304     D WWDTA           S                   LIKE(WUDTA)
003000021008     ***
003100021008     D WIFKV           S             60A
003200021008     D WIFKY           S                   LIKE(WIFKV)
003300021008     D WIOPV           S                   LIKE(WIFKV)
003400021008     D WIRQS           S              8A
003500021008     D WORTN           S              8A
003600021008     D WUPGM           S             10A
003700021008     D WWCHG           S              1A
003800021008     D WWDLT           S              1A
003900021008     D WWDTAQ          S             10A
004000021008     D WWENDF          S              3A
004100021008     D WWENDO          S                   LIKE(WWENDF)
004200021008     D WWERR           S              1A
004300021008     D WWFIL           S             10A
004400021008     D WWFKA           S              8A
004500021008     D WWFKV           S                   LIKE(WIFKV)
004600021008     D WWFKY           S                   LIKE(WIFKV)
004700021008     D WWFLK           S            128A
004800021008     D WWFMTN          S              8A
004900021008     D WWFNC           S              8A
005000021008     D WWIJI           S             16A
005100021008     D WWIN            S             99A
005200021008     D WWLIB           S             10A
005300021008     D WWMSG           S             80A
005400021008     D WWMSGC          S              7A
005500021008     D WWOCD           S              8A
005600021008     D WWOPA           S              8A
005700021008     D WWOPN           S              1A
005800021008     D WWOPT           S              8A
005900021008     D WWOPV           S                   LIKE(WIFKV)
006000021008     D WWORQS          S                   LIKE(WIRQS)
006100021008     D WWPSNC          S              1A
006200021008     D WWQJN           S             26A
006300021008     D WWRQS           S                   LIKE(WIRQS)
006400021008     D WWRQSD          S                   LIKE(WIRQS)
006500021008     D WWRTN           S                   LIKE(WORTN)
006600021008     D WWRTND          S                   LIKE(WORTN)
006700021008     D WWRTNH          S                   LIKE(WORTN)
006800021008     D WWSFLE          S              1A
006900021008     D WWSTT           S              3A
007000021008     D WWTSK           S              8A
007100021008     D WWTXT           S             60A
007200021008     D WWUPD           S              1A
007300021008     D WWWRNF          S              1A
007400021008     D WWZERO          S             40A
007500021008     D WFRRN           S              4P 0
007600021008     D WW              S              3P 0
007700021008     D WWFKS           S              1P 0
007800021008     D WWFKSO          S                   LIKE(WWFKS)
007900021008     D WWLMT           S              2P 0
008000021008     D WWLNG           S             15P 5
008100021008     D WWLNGQ          S              5P 0
008200021008     D WWLOWR          S              4P 0
008300021008     D WWLSTS          S              2P 0
008400021008     D WWOPS           S              1P 0
008500021008     D WWOPSO          S                   LIKE(WWOPS)
008600021008     D WWPNL           S              1P 0
008700021008     D WWPNLN          S                   LIKE(WWPNL)
008800021008     D WWPNLO          S                   LIKE(WWPNL)
008900021008     D WWPSNI          S              2P 0
009000021008     D WWPSNN          S              1P 0
009100021008     D WWPSNP          S                   LIKE(WWPSNN)
009200021008     D WWRRN           S              4P 0
009300020304     ***
009400020304      *_________________________________________________________________________
009500020304      *
009600020304      * Process Entry Panel
009700020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
009800020304     C                   Move      WUDTA         WWDTA
009900020304E1   C                   ENDIF
010000020304      *
010100020304     C                   Exsr      PRPPNL
010200020304      *
010300020304B1   C                   DOW       WWSTT <> 'END'
010400020304     C                   Exsr      RCVMSG
010500020304     C                   Exsr      DSPPNL
010600020304     C                   Exsr      PRCFKY
010700020304      *
010800020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
010900020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
011000020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
011100020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
011200020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
011300020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
011400020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
011500020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
011600020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
011700020304E2   C                   Endcs
011800020304      *
011900020304B2   C                   IF        WWSTT = 'END'
012000020304     C                   Exsr      PRCEND
012100020304E2   C                   Endif
012200020304E1   C                   Enddo
012300020304      *
012400020304      * Send Info Updated message.
012500020304     C                   IF        WWCHG = 'Y'
012600020304     C                   MOVEL     'UPDATE  '    WORTN
012700020304     C                   Endif
012800020304      *
012900020304     C                   Return
013000020304      *___________________________________________________________________
013100020304      * Prepare panel
013200020304      *___________________________________________________________________
013300020304     C     PRPPNL        Begsr
013400020304     C                   Move      *BLANKS       WORTN
013500020304     C                   Move      'N'           WWERR
013600020304     C                   Move      'N'           WWCHG
013700020304     C                   Move      'N'           WWWRNF
013800020304     C                   Move      *BLANKS       WWSTT
013900020304     C                   Z-add     1             WWPNL
014000020304     C                   Z-add     1             WWFKS
014100020304     C                   Movea     WWZERO        *IN(60)
014200020304     C                   Move      *BLANKS       WWSTT
014300020304      *
014400020304B1   C                   IF        WQPGMN = WUPGM
014500020304B2   C                   IF        WIRQS <> WWORQS
014600020304     C                   Move      *BLANKS       WUPGM
014700020304E2   C                   Endif
014800020304     C                   Move      WIRQS         WWORQS
014900020304E1   C                   Endif
015000020304      *
015100020304     C                   Exsr      BLDFKY
015200020304      *
015300020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015400020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015500020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
015600020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
015700020304     C                   Cas                     PRCERR
015800020304E1   C                   Endcs
015900020304      *
016000020304      *
016100020304     C                   Endsr
016200020304      *___________________________________________________________________
016300020304      * Prepare ADD request
016400020304      *___________________________________________________________________
016500020304     C     PRPADD        Begsr
016600020304     C                   Clear                   WUDTA
016700020304     C                   Exsr      DFTDTA
016800020304     C                   Endsr
016900020304      *___________________________________________________________________
017000020304      * Prepare CHANGE request
017100020304      *___________________________________________________________________
017200020304     C     PRPCHG        Begsr
017300081230     C                   Call      'UPDIRM  '
017400020304     C                   Parm      'GET     '    WWRQS
017500020304     C                   Parm                    WWRTN
017600020304     C                   Parm                    WUDTA
017700020304B1   C                   IF        WWRTN <> *BLANKS
017800020304B2   C                   IF        WWRTN = 'NOTAVL'
017900020304     C                   Movel     WTM(5)        WWMSG
018000020304X2   C                   Else
018100020304     C                   Movel     WTM(4)        WWMSG
018200020304E2   C                   Endif
018300020304     C                   Exsr      SNDMSG
018400020304     C                   Move      'ERROR   '    WORTN
018500020304     C                   Move      'END'         WWSTT
018600020304E1   C                   End
018700020304     C                   Endsr
018800020304      *___________________________________________________________________
018900020304      * Prepare COPY request
019000020304      *___________________________________________________________________
019100020304     C     PRPCPY        Begsr
019200020304     C                   Move      WWDTA         WUDTA
019300081230     C                   Call      'UPDIRM  '
019400020304     C                   Parm      'GETNL   '    WWRQS
019500020304     C                   Parm                    WWRTN
019600020304     C                   Parm                    WUDTA
019700020304B1   C                   IF        WWRTN <> *BLANKS
019800020304     C                   Movel     WTM(4)        WWMSG
019900020304     C                   Exsr      SNDMSG
020000020304     C                   Move      'ERROR   '    WORTN
020100020304     C                   Move      'END'         WWSTT
020200020304X1   C                   Else
020300020304     C                   Move      'Y'           WWCHG
020400020304     ***                 Clear                   MSMSID
020500020304E1   C                   Endif
020600020304     C                   Endsr
020700020304      *___________________________________________________________________
020800020304      * Default Data
020900020304      *___________________________________________________________________
021000020304     C     DFTDTA        Begsr
021100081230     C                   Call      'CHKIRM  '
021200020304     C                   Parm      'DFTDTA'      WWRQS
021300020304     C                   Parm                    WWRTN
021400020304     C                   Parm                    WUDTA
021500020304B1   C                   IF        WWRTN <> *BLANKS
021600020304     C                   Movel     WTM(7)        WWMSG
021700020304     C                   Exsr      SNDMSG
021800020304     C                   Move      'ERROR   '    WORTN
021900020304     C                   Move      'END'         WWSTT
022000020304E1   C                   Endif
022100020304     C                   Endsr
022200020304      *___________________________________________________________________
022300020304      * Process ERROR function
022400020304      *___________________________________________________________________
022500020304     C     PRCERR        Begsr
022600020304     C                   Move      WTM(1)        WWMSG
022700020304     C                   Exsr      SNDMSG
022800020304     C                   Move      'ERROR   '    WORTN
022900020304     C                   Move      'END'         WWSTT
023000020304     C                   Endsr
023100020304      *___________________________________________________________________
023200020304      * Receive messages
023300020304      *___________________________________________________________________
023400020304     C     RCVMSG        Begsr
023500020304B1   C                   IF        WWMSGC <> 'NORESET'
023600020304     C                   Movel     'RECEIVE'     WWRQS
023700020304X1   C                   Else
023800020304     C                   Movel     'DISPLAY'     WWRQS
023900020304E1   C                   Endif
024000020304     C                   Movel     'RESET   '    WWMSGC
024100020304     C                   Movea     *IN           WWIN
024200020304     C                   Call      'PRCMSG2'
024300020304     C                   Parm                    WWRQS
024400020304     C                   Parm                    WWIN
024500020304     C                   Parm                    WWRTN
024600020304     C                   Movea     WWIN          *IN
024700020304     C                   Endsr
024800020304      *___________________________________________________________________
024900020304      * Display panels
025000020304      *___________________________________________________________________
025100020304     C     DSPPNL        Begsr
025200020304      *
025300020304      * Set PUTOVR based on last display file processed
025400020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025500020304     C                   MOVE      *OFF          *IN35
025600020304     C                   Move      WQPGMN        WUPGM
025700020304     C                   Move      WWPNL         WWPNLO
025800020304X1   C                   Else
025900020304     C                   MOVE      *ON           *IN35
026000020304E1   C                   Endif
026100020304      *
026200020304      * Set PROTECT key based on request
026300020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026400020304     C                             WWTSK = 'COPY  '
026500020304 001 C                   Setoff                                       40
026600020304X001 C                   Else
026700020304 001 C                   Seton                                        40
026800020304E001 C                   Endif
026900020304      *
027000020304      * Select title
027100020304     C                   IF        WWTSK = 'CHANGE'
027200020304 001 C                   MOVE      *OFF          *IN38
027300020304X001 C                   Else
027400020304 001 C                   MOVE      *ON           *IN38
027500020304E001 C                   Endif
027600020304      *
027700020304      * Position cursor based on error status
027800020304     C                   IF        WWERR = 'Y'
027900020304 001 C                   MOVE      *ON           *IN99
028000020304X001 C                   Else
028100020304 001 C                   MOVE      *OFF          *IN99
028200020304E001 C                   Endif
028300020304      *
028400020304      * Write message subfile
028500020304     C                   Seton                                        30
028600020304     C                   Write     MSGCTL
028700020304      *
028800020304      * Write entry panel
028900020304B001 C                   Select
029000020304     C                   WHEN      WWPNL = 1
029100020304 001 C                   Exfmt     ENTPNL
029200020304 001 C                   Setoff                                       37
029300020304E001 C                   Endsl
029400020304      *
029500020304B001 C                   If        *IN39 = *ON
029600020304 001 C                   Move      'Y'           WWCHG
029700020304E001 C                   Endif
029800020304     C                   Endsr
029900020304      *___________________________________________________________________
030000020304      * Process function key
030100020304      *___________________________________________________________________
030200020304     C     PRCFKY        Begsr
030300020304     C                   Movea     *IN           WWIN
030400020304     C                   Call      'PRCFKY2'
030500020304     C                   Parm      'PROCESS '    WWRQS
030600020304     C     WWFKA         Parm                    WWRTN
030700020304     C                   Parm                    WAD
030800020304     C                   Parm                    WWIN
030900020304     C                   Parm                    WAF
031000020304     C                   Parm                    WIFKV
031100020304     C                   Endsr
031200020304      *___________________________________________________________________
031300020304      * Process KEYS function
031400020304      *___________________________________________________________________
031500020304     C     PRCDKY        Begsr
031600020304     C                   Z-add     1             WW
031700020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
031800060317 001 C                   Add       1             WWFKS
031900020304 001  *
032000020304     C                   IF        WWFKS > 3
032100020304 002 C                   Z-add     1             WWFKS
032200020304E002 C                   Endif
032300020304 001  *
032400060317     C                   Eval      WW = WWFKS + WWFKS
032500020304 001 C                   Sub       1             WW
032600020304E001 C                   Enddo
032700020304      *
032800020304     C                   Movel     WAD(WW)       WSFKD1
032900020304     C                   Add       1             WW
033000020304     C                   Movel     WAD(WW)       WSFKD2
033100020304     C                   Endsr
033200020304      *___________________________________________________________________
033300020304      * Process EXIT Function
033400020304      *___________________________________________________________________
033500020304     C     PRCEXT        Begsr
033600020304      *
033700020304     C                   Exsr      PRCPNL
033800020304      *
033900020304     C                   IF        WWERR = 'Y'
034000020304 001 C                   Move      *BLANKS       WWSTT
034100020304X001 C                   Else
034200020304 001 C                   Movel     WWFKA         WORTN
034300020304 001 C                   Move      'END'         WWSTT
034400020304E001 C                   Endif
034500020304     C                   Endsr
034600020304      *___________________________________________________________________
034700020304      * Process PROMPT function
034800020304      *___________________________________________________________________
034900020304     C     PRCPMT        Begsr
035000020304     C                   Movel     WDCRSL        WWRQS
035100020304     C                   Move      'Y'           WWCHG
035200020304     C                   Move      'N'           WWWRNF
035300020304     C                   Movel     'NORESET '    WWMSGC
035400020304      *
035500020304B001 C                   Select
035600020304 001 C                   When      WSFLD = 'XXXXXX'
035700020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
035800040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
035900040305     C*                  Parm                    WWRTN                          RETURN CODE
036000040305     C*                  Parm                    WUPGM                          LAST PGM NAME
036100020304     C*                  Parm                    WDCARP                         RECORD DS
036200020304     C                   IF        WWRTN = *BLANKS
036300020304     C*                  Eval      MSCAID   =    CMCARR
036400020304     C*                  EVAL      WSCNAME  =    CMNAME
036500020304E001 C                   Endif
036600020304 001  *
036700020304 001 C                   Other
036800020304 001 C                   Move      WTM(6)        WWMSG
036900020304 001 C                   Exsr      SNDMSG
037000020304E001 C                   Endsl
037100020304      *
037200020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
037300020304     C                   Movel     WDCRSL        WWCRSL
037400020304     C     WWCRSN        Div       256           WSROW
037500020304     C                   Mvr                     WSLIN
037600020304     C                   Seton                                        37
037700020304      *
037800020304     C                   Endsr
037900020304      *___________________________________________________________________
038000020304      * Process CANCEL Function
038100020304      *___________________________________________________________________
038200020304     C     PRCCNL        Begsr
038300020304     C                   Movel     WWFKA         WORTN
038400020304     C                   Move      'END'         WWSTT
038500020304     C                   Move      'N'           WWCHG
038600020304     C                   Endsr
038700020304      *___________________________________________________________________
038800020304      * Process ROLLUP function
038900020304      *___________________________________________________________________
039000020304     C     PRCRUP        Begsr
039100020304     C     WWPNL         Add       1             WWPNL
039200020304     C                   IF        WWPNL > WWPNLN
039300020304 001 C     WWPNL         Sub       1             WWPNL
039400020304E001 C                   Endif
039500020304     C                   Movel     'NORESET '    WWMSGC
039600020304     C                   Endsr
039700020304      *___________________________________________________________________
039800020304      * Process ROLLDOWN function
039900020304      *___________________________________________________________________
040000020304     C     PRCRDN        Begsr
040100020304     C     WWPNL         Sub       1             WWPNL
040200020304     C                   IF        WWPNL < 1
040300020304 001 C     WWPNL         Add       1             WWPNL
040400020304E001 C                   Endif
040500020304     C                   Movel     'NORESET '    WWMSGC
040600020304     C                   Endsr
040700020304      *___________________________________________________________________
040800020304      * Process ENTER function
040900020304      *___________________________________________________________________
041000020304     C     PRCPNL        Begsr
041100020304     C                   Move      *BLANKS       WWRTN
041200020304     C                   Movea     *ZEROS        *IN(60)
041300020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
041400020304 001 C                   Move      'N'           WWWRNF
041500020304     C                   IF        WWTSK = 'CHANGE  '
041600081230 001 C                   Call      'CHKIRM  '
041700020304 001 C                   Parm      'EDTCHG  '    WWRQS
041800020304 001 C                   Parm                    WWRTN
041900020304 001 C                   Parm                    WUDTA
042000020304     C                   ELSE
042100081230 001 C                   Call      'CHKIRM  '
042200020304 001 C                   Parm      'EDTADD  '    WWRQS
042300020304 001 C                   Parm                    WWRTN
042400020304 001 C                   Parm                    WUDTA
042500020304E001 C                   Endif
042600020304E001 C                   Endif
042700020304      *
042800020304B001 C                   Select
042900020304     C                   WHEN      WWRTN = *BLANKS
043000020304 001 C                   Move      'N'           WWERR
043100020304 001  *
043200020304     C                   WHEN      WWRTN = 'WARNING'
043300020304     C                   IF        WWWRNF = 'Y'
043400020304 002 C                   Move      'N'           WWERR
043500020304X002 C                   Else
043600020304 002 C                   Move      'Y'           WWWRNF
043700020304 002 C                   Move      'Y'           WWERR
043800020304E002 C                   Endif
043900020304 001  *
044000020304     C                   WHEN      WWRTN = 'ERROR  '
044100020304 001 C                   Move      'Y'           WWERR
044200020304 001 C                   Move      *BLANKS       WWSTT
044300020304 001 C                   Move      'N'           WWWRNF
044400020304E001 C                   Endsl
044500020304      *
044600020304     C                   Endsr
044700020304      *___________________________________________________________________
044800020304      * Process end - write data or release record
044900020304      *___________________________________________________________________
045000020304     C     PRCEND        Begsr
045100020304      *
045200020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
045300020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
045400020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
045500020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
045600020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
045700020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
045800020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
045900020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
046000020304 001 C                   Endcs
046100020304 001  *
046200020304     C                   IF        WWRTN <> *BLANKS
046300020304 002 C                   Move      *BLANKS       WWSTT
046400020304 002  *
046500020304X002 C                   Else
046600020304     C                   IF        WWFKA <> 'EXIT'
046700020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
046800020304 004 C                   Exsr      PRPPNL
046900020304E004 C                   Endif
047000020304E003 C                   Endif
047100020304E002 C                   Endif
047200020304 001  *
047300020304X001 C                   Else
047400020304 001 C                   Exsr      RELREC
047500020304E001 C                   Endif
047600020304      *
047700020304     C                   Endsr
047800020304      *___________________________________________________________________
047900020304      * Add new record
048000020304      *___________________________________________________________________
048100020304     C     WRTADD        Begsr
048200020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
048300020304     C                             WWTSK = 'COPY  '
048400020304 001 C                   Movel     'ADD    '     WWRQS
048500020304E001 C                   Endif
048600020304      *
048700020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
048800020304     C                             WWTSK = 'CPYKEY'
048900020304 001 C                   Movel     'ADDKEY '     WWRQS
049000020304E001 C                   Endif
049100020304      *
049200081230     C                   Call      'UPDIRM  '
049300020304     C                   Parm                    WWRQS
049400020304     C                   Parm                    WWRTN
049500020304     C                   Parm                    WUDTA
049600020304      *
049700020304     C                   IF        WWRTN <> *BLANKS
049800020304 001 C                   Movel     WTM(3)        WWMSG
049900020304 001 C                   Exsr      SNDMSG
050000020304X001 C                   Else
050100020304E001 C                   Endif
050200020304      *
050300020304     C                   Endsr
050400020304      *___________________________________________________________________
050500020304      * Write changed record
050600020304      *___________________________________________________________________
050700020304     C     WRTCHG        Begsr
050800081230     C                   Call      'UPDIRM  '
050900020304     C                   Parm      'CHANGE'      WWRQS
051000020304     C                   Parm                    WWRTN
051100020304     C                   Parm                    WUDTA
051200020304     C                   IF        WWRTN <> *BLANKS
051300020304 001 C                   Movel     WTM(2)        WWMSG
051400020304 001 C                   Exsr      SNDMSG
051500020304E001 C                   Endif
051600020304      *
051700020304     C                   Endsr
051800020304      *___________________________________________________________________
051900020304      * Release record
052000020304      *___________________________________________________________________
052100020304     C     RELREC        Begsr
052200081230     C                   Call      'UPDIRM  '
052300020304     C                   Parm      'RELEASE '    WWRQS
052400020304     C                   Parm                    WWRTN
052500020304     C                   Parm                    WUDTA
052600020304     C                   IF        WWRTN <> *BLANKS
052700020304 001 C                   Movel     WTM(4)        WWMSG
052800020304 001 C                   Exsr      SNDMSG
052900020304E001 C                   Endif
053000020304     C                   Endsr
053100020304      *___________________________________________________________________
053200020304      * Build function keys
053300020304      *___________________________________________________________________
053400020304     C     BLDFKY        Begsr
053500020304     C                   Movea     *IN           WWIN
053600020304     C                   Call      'PRCFKY2'
053700020304     C                   Parm      'BUILD   '    WWRQS
053800020304     C     WWFKA         Parm                    WWRTN
053900020304     C                   Parm                    WAD
054000020304     C                   Parm                    WWIN
054100020304     C                   Parm                    WAF
054200020304     C                   Parm                    WIFKV
054300020304     C     WWFKS         Add       WWFKS         WW
054400020304     C                   Movel     WAD(WW)       WSFKD2
054500020304     C                   Sub       1             WW
054600020304     C                   Movel     WAD(WW)       WSFKD1
054700020304     C                   Endsr
054800020304      *___________________________________________________________________
054900020304      * Send message
055000020304      *___________________________________________________________________
055100020304     C     SNDMSG        Begsr
055200020304     C                   Call      'QSNDDTAQ'
055300020304     C                   Parm                    WWDTAQ
055400020304     C                   Parm                    WWLIB
055500020304     C                   Parm                    WWLNGQ
055600020304     C                   Parm                    WWMSG
055700020304     C                   Endsr
055800020304      *___________________________________________________________________
055900020304      * Paremater list
056000020304      *___________________________________________________________________
056100020304     C     PLIST         Begsr
056200020304     C     *ENTRY        Plist
056300020304     C     WWTSK         Parm                    WIRQS
056400020304     C                   Parm                    WORTN
056500020304     C                   Parm                    WUPGM
056600020304     C                   Parm                    WUDTA
056700020304     C                   Parm                    WIFKV
056800020304     C                   Endsr
056900020304      *___________________________________________________________________
057000020304      * Initialize routine
057100020304      *___________________________________________________________________
057200020304     C     *INZSR        Begsr
057300020304     C     *LIKE         Define    WUDTA         WWDTA
057400020304     C     *LIKE         Define    WIRQS         WWRQS
057500020304     C     *LIKE         Define    WIRQS         WWORQS
057600020304     C     *LIKE         Define    WIRQS         WWTSK
057700020304     C     *LIKE         Define    WORTN         WWRTN
057800020304     C     *LIKE         Define    WORTN         WWFKA
057900020304     C     *LIKE         Define    WIFKV         WWFKV
058000020304     C     *LIKE         Define    WIFKV         WWOPV
058100020304     C                   Movel     'RESET   '    WWMSGC
058200020304     C                   Movel     '*'           MSPGMQ
058300020304     C                   Movel     'MSGDTAQ'     WWDTAQ
058400020304     C                   Movel     'QTEMP'       WWLIB
058500020304     C                   Z-add     80            WWLNGQ
058600020304     C                   Move      *BLANKS       WWMSG
058700020304     C                   Move      *BLANKS       WWIN
058800020304     C                   Move      *BLANKS       WWSTT
058900020304     C                   Move      *ZEROS        WWZERO
059000020304     C                   Z-add     1             WWPNL
059100020304     C                   Z-add     1             WWPNLN
059200020304     C                   Z-add     1             WWFKS
059300020304     C                   Move      'N'           WWERR
059400020304     C                   Move      'N'           WWCHG
059500020304     C                   Move      'N'           WWWRNF
059600020304     C                   Z-add     0             WW
059700081230     C                   Movel(P)  'IRMMSTP '    WWFIL
059800020304     C                   Move      *BLANKS       WWFLK
059900020304     C                   Move      *BLANKS       WWTXT
060000020304     C                   Endsr
060100020304      *___________________________________________________________________
060200020304      * Program error handler
060300020304      *___________________________________________________________________
060400020304     C     *PSSR         Begsr
060500020304     C                   Call      'SNDRPGM'                            50
060600020304     C                   Parm                    WQPGMN
060700020304     C                   Parm                    WQSTSC
060800020304     C                   Parm                    WQRPGS
060900020304     C                   Parm                    WQMSG
061000020304     C                   Endsr     '*CANCL'
061100020304      *___________________________________________________________________
061200020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06130002030403EXIT    F3=Exit
06140002030404PROMPT  F4=Prompt
06150002030405REFRESH F5=Refresh
06160002030410UPDATE  F10=Update
06170002030412CANCEL  F12=Cancel
06180002030425ROLLUP
06190002030426ROLLDOWN
062000020304** WTM
06210008123000Request not supported in program CHGIRM.
06220002030400Update error.  Data was not updated.
06230002030400Duplicate key detected.  Data was NOT added to file.
06240002030400Record not found.
06250002030400Record not available now.
06260002030400The cursor is not in a prompt area.
06270002030400Default error.  Data not defaulted.
