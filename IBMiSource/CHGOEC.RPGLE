000100020304      *_________________________________________________________________________
000200020304      *
000300070329      *  Description:  Change Account OLE Codes
000400020304      *
000500061129      *  (c)Copyright 2006 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000601070313      * 03/13/07 szz - Add prompt for Prompt Employer Retention Flag       *
000603070313      *                                                                    *
000604070313      *_________________________________________________________________________
000700061129     FCHGOECD   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000061130     D WAD             S             80    DIM(5)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200020304      *_________________________________________________________________________
001300020304      * Data structure
001400061129     D WUDTA         E DS                  EXTNAME(AOECOD)
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
009200040518     d bch@lda         ds
009300040518     d blah                    1    240a
009400040518     d co_name               200    240a
009500020304      *_________________________________________________________________________
009600020304      *
009700020304      * Process Entry Panel
009800020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
009900020304     C                   Move      WUDTA         WWDTA
010000020304E1   C                   ENDIF
010100020304      *
010200020304     C                   Exsr      PRPPNL
010300020304      *
010400020304B1   C                   DOW       WWSTT <> 'END'
010500020304     C                   Exsr      RCVMSG
010600020304     C                   Exsr      DSPPNL
010700020304     C                   Exsr      PRCFKY
010800020304      *
010900020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
011000020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
011100020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
011200020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
011300020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
011400020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
011500020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
011600020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
011700020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
011800020304E2   C                   Endcs
011900020304      *
012000020304B2   C                   IF        WWSTT = 'END'
012100020304     C                   Exsr      PRCEND
012200020304E2   C                   Endif
012300020304E1   C                   Enddo
012400020304      *
012500020304      * Send Info Updated message.
012600020304     C                   IF        WWCHG = 'Y'
012700020304     C                   MOVEL     'UPDATE  '    WORTN
012800020304     C                   Endif
012900020304      *
013000020304     C                   Return
013100020304      *___________________________________________________________________
013200020304      * Prepare panel
013300020304      *___________________________________________________________________
013400020304     C     PRPPNL        Begsr
013500020304     C                   Move      *BLANKS       WORTN
013600020304     C                   Move      'N'           WWERR
013700020304     C                   Move      'N'           WWCHG
013800020304     C                   Move      'N'           WWWRNF
013900020304     C                   Move      *BLANKS       WWSTT
014000020304     C                   Z-add     1             WWPNL
014100020304     C                   Z-add     1             WWFKS
014200020304     C                   Movea     WWZERO        *IN(60)
014300020304     C                   Move      *BLANKS       WWSTT
014400040518      *
014500040518     C     *DTAARA       DEFINE    *LDA          BCH@LDA
014600040518     C                   IN        BCH@LDA
014700040518     c                   eval      wsname = co_name
014800020304      *
014900020304B1   C                   IF        WQPGMN = WUPGM
015000020304B2   C                   IF        WIRQS <> WWORQS
015100020304     C                   Move      *BLANKS       WUPGM
015200020304E2   C                   Endif
015300020304     C                   Move      WIRQS         WWORQS
015400020304E1   C                   Endif
015500020304      *
015600020304     C                   Exsr      BLDFKY
015700020304      *
015800020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015900020304     C     WWTSK         Caseq     'ADD     '    PRPADD
016000020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
016100020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016200020304     C                   Cas                     PRCERR
016300020304E1   C                   Endcs
016400020304      *
016500020304      *
016600020304     C                   Endsr
016700020304      *___________________________________________________________________
016800020304      * Prepare ADD request
016900020304      *___________________________________________________________________
017000020304     C     PRPADD        Begsr
017100020304     C                   Clear                   WUDTA
017200020304     C                   Exsr      DFTDTA
017300020304     C                   Endsr
017400020304      *___________________________________________________________________
017500020304      * Prepare CHANGE request
017600020304      *___________________________________________________________________
017700020304     C     PRPCHG        Begsr
017800061129     C                   Call      'UPDOEC  '
017900020304     C                   Parm      'GET     '    WWRQS
018000020304     C                   Parm                    WWRTN
018100020304     C                   Parm                    WUDTA
018200020304B1   C                   IF        WWRTN <> *BLANKS
018300020304B2   C                   IF        WWRTN = 'NOTAVL'
018400020304     C                   Movel     WTM(5)        WWMSG
018500020304X2   C                   Else
018600020304     C                   Movel     WTM(4)        WWMSG
018700020304E2   C                   Endif
018800020304     C                   Exsr      SNDMSG
018900020304     C                   Move      'ERROR   '    WORTN
019000020304     C                   Move      'END'         WWSTT
019100020304E1   C                   End
019200020304     C                   Endsr
019300020304      *___________________________________________________________________
019400020304      * Prepare COPY request
019500020304      *___________________________________________________________________
019600020304     C     PRPCPY        Begsr
019700020304     C                   Move      WWDTA         WUDTA
019800061129     C                   Call      'UPDOEC  '
019900020304     C                   Parm      'GETNL   '    WWRQS
020000020304     C                   Parm                    WWRTN
020100020304     C                   Parm                    WUDTA
020200020304B1   C                   IF        WWRTN <> *BLANKS
020300020304     C                   Movel     WTM(4)        WWMSG
020400020304     C                   Exsr      SNDMSG
020500020304     C                   Move      'ERROR   '    WORTN
020600020304     C                   Move      'END'         WWSTT
020700020304X1   C                   Else
020800020304     C                   Move      'Y'           WWCHG
020900020304E1   C                   Endif
021000020304     C                   Endsr
021100020304      *___________________________________________________________________
021200020304      * Default Data
021300020304      *___________________________________________________________________
021400020304     C     DFTDTA        Begsr
021500061129     C                   Call      'CHKOEC  '
021600020304     C                   Parm      'DFTDTA'      WWRQS
021700020304     C                   Parm                    WWRTN
021800020304     C                   Parm                    WUDTA
021900020304B1   C                   IF        WWRTN <> *BLANKS
022000020304     C                   Movel     WTM(7)        WWMSG
022100020304     C                   Exsr      SNDMSG
022200020304     C                   Move      'ERROR   '    WORTN
022300020304     C                   Move      'END'         WWSTT
022400020304E1   C                   Endif
022500020304     C                   Endsr
022600020304      *___________________________________________________________________
022700020304      * Process ERROR function
022800020304      *___________________________________________________________________
022900020304     C     PRCERR        Begsr
023000020304     C                   Move      WTM(1)        WWMSG
023100020304     C                   Exsr      SNDMSG
023200020304     C                   Move      'ERROR   '    WORTN
023300020304     C                   Move      'END'         WWSTT
023400020304     C                   Endsr
023500020304      *___________________________________________________________________
023600020304      * Receive messages
023700020304      *___________________________________________________________________
023800020304     C     RCVMSG        Begsr
023900020304B1   C                   IF        WWMSGC <> 'NORESET'
024000020304     C                   Movel     'RECEIVE'     WWRQS
024100020304X1   C                   Else
024200020304     C                   Movel     'DISPLAY'     WWRQS
024300020304E1   C                   Endif
024400020304     C                   Movel     'RESET   '    WWMSGC
024500020304     C                   Movea     *IN           WWIN
024600020304     C                   Call      'PRCMSG2'
024700020304     C                   Parm                    WWRQS
024800020304     C                   Parm                    WWIN
024900020304     C                   Parm                    WWRTN
025000020304     C                   Movea     WWIN          *IN
025100020304     C                   Endsr
025200020304      *___________________________________________________________________
025300020304      * Display panels
025400020304      *___________________________________________________________________
025500020304     C     DSPPNL        Begsr
025600020304      *
025700020304      * Set PUTOVR based on last display file processed
025800020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025900020304     C                   MOVE      *OFF          *IN35
026000020304     C                   Move      WQPGMN        WUPGM
026100020304     C                   Move      WWPNL         WWPNLO
026200020304X1   C                   Else
026300020304     C                   MOVE      *ON           *IN35
026400020304E1   C                   Endif
026500020304      *
026600020304      * Set PROTECT key based on request
026700020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026800020304     C                             WWTSK = 'COPY  '
026900020304 001 C                   Setoff                                       40
027000020304X001 C                   Else
027100020304 001 C                   Seton                                        40
027200020304E001 C                   Endif
027300020304      *
027400020304      * Select title
027500020304     C                   IF        WWTSK = 'CHANGE'
027600020304 001 C                   MOVE      *OFF          *IN38
027700020304X001 C                   Else
027800020304 001 C                   MOVE      *ON           *IN38
027900020304E001 C                   Endif
028000020304      *
028100020304      * Position cursor based on error status
028200020304     C                   IF        WWERR = 'Y'
028300020304 001 C                   MOVE      *ON           *IN99
028400020304X001 C                   Else
028500020304 001 C                   MOVE      *OFF          *IN99
028600020304E001 C                   Endif
028700020304      *
028800020304      * Write message subfile
028900020304     C                   Seton                                        30
029000020304     C                   Write     MSGCTL
029100020304      *
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
030300020304      *___________________________________________________________________
030400020304      * Process function key
030500020304      *___________________________________________________________________
030600020304     C     PRCFKY        Begsr
030700020304     C                   Movea     *IN           WWIN
030800020304     C                   Call      'PRCFKY2'
030900020304     C                   Parm      'PROCESS '    WWRQS
031000020304     C     WWFKA         Parm                    WWRTN
031100020304     C                   Parm                    WAD
031200020304     C                   Parm                    WWIN
031300020304     C                   Parm                    WAF
031400020304     C                   Parm                    WIFKV
031500020304     C                   Endsr
031600020304      *___________________________________________________________________
031700020304      * Process KEYS function
031800020304      *___________________________________________________________________
031900020304     C     PRCDKY        Begsr
032000020304     C                   Z-add     1             WW
032100020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
032200020304 001 C     WWFKS         Add       1             WWFKS
032300020304 001  *
032400020304     C                   IF        WWFKS > 3
032500020304 002 C                   Z-add     1             WWFKS
032600020304E002 C                   Endif
032700020304 001  *
032800020304 001 C     WWFKS         Add       WWFKS         WW
032900020304 001 C                   Sub       1             WW
033000020304E001 C                   Enddo
033100020304      *
033200020304     C                   Movel     WAD(WW)       WSFKD1
033300020304     C                   Add       1             WW
033400020304     C                   Movel     WAD(WW)       WSFKD2
033500020304     C                   Endsr
033600020304      *___________________________________________________________________
033700020304      * Process EXIT Function
033800020304      *___________________________________________________________________
033900020304     C     PRCEXT        Begsr
034000020304      *
034100020304     C                   Exsr      PRCPNL
034200020304      *
034300020304     C                   IF        WWERR = 'Y'
034400020304 001 C                   Move      *BLANKS       WWSTT
034500020304X001 C                   Else
034600020304 001 C                   Movel     WWFKA         WORTN
034700020304 001 C                   Move      'END'         WWSTT
034800020304E001 C                   Endif
034900020304     C                   Endsr
035000020304      *___________________________________________________________________
035100020304      * Process PROMPT function
035200020304      *___________________________________________________________________
035300020304     C     PRCPMT        Begsr
035400020304     C                   Movel     WDCRSL        WWRQS
035500020304     C                   Move      'Y'           WWCHG
035600020304     C                   Move      'N'           WWWRNF
035700020304     C                   Movel     'NORESET '    WWMSGC
035800020304      *
035900020304B001 C                   Select
036000061130 001 C                   When      WSFLD = 'AECODE'
036100061130     C                   Call      'SLCOEC'                                     *ENTRY LIST
036200061130     C                   Parm                    WWRQS                          PROGRAM REQUEST
036300061130     C                   Parm                    WWRTN                          RETURN CODE
036400061130     C                   Parm                    WUPGM                          LAST PGM NAME
036500061130     C                   Parm                    AECODE                         RECORD DS
036600020304     C                   IF        WWRTN = *BLANKS
036900020304E001 C                   Endif
037000020304 001  *
037100020304 001 C                   Other
037200020304 001 C                   Move      WTM(6)        WWMSG
037300020304 001 C                   Exsr      SNDMSG
037400020304E001 C                   Endsl
037500020304      *
037600020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
037700020304     C                   Movel     WDCRSL        WWCRSL
037800020304     C     WWCRSN        Div       256           WSROW
037900020304     C                   Mvr                     WSLIN
038000020304     C                   Seton                                        37
038100020304      *
038200020304     C                   Endsr
038300020304      *___________________________________________________________________
038400020304      * Process CANCEL Function
038500020304      *___________________________________________________________________
038600020304     C     PRCCNL        Begsr
038700020304     C                   Movel     WWFKA         WORTN
038800020304     C                   Move      'END'         WWSTT
038900020304     C                   Move      'N'           WWCHG
039000020304     C                   Endsr
039100020304      *___________________________________________________________________
039200020304      * Process ROLLUP function
039300020304      *___________________________________________________________________
039400020304     C     PRCRUP        Begsr
039500020304     C     WWPNL         Add       1             WWPNL
039600020304     C                   IF        WWPNL > WWPNLN
039700020304 001 C     WWPNL         Sub       1             WWPNL
039800020304E001 C                   Endif
039900020304     C                   Movel     'NORESET '    WWMSGC
040000020304     C                   Endsr
040100020304      *___________________________________________________________________
040200020304      * Process ROLLDOWN function
040300020304      *___________________________________________________________________
040400020304     C     PRCRDN        Begsr
040500020304     C     WWPNL         Sub       1             WWPNL
040600020304     C                   IF        WWPNL < 1
040700020304 001 C     WWPNL         Add       1             WWPNL
040800020304E001 C                   Endif
040900020304     C                   Movel     'NORESET '    WWMSGC
041000020304     C                   Endsr
041100020304      *___________________________________________________________________
041200020304      * Process ENTER function
041300020304      *___________________________________________________________________
041400020304     C     PRCPNL        Begsr
041500020304     C                   Move      *BLANKS       WWRTN
041600020304     C                   Movea     *ZEROS        *IN(60)
041700020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
041800020304 001 C                   Move      'N'           WWWRNF
041900020304     C                   IF        WWTSK = 'CHANGE  '
042000061129 001 C                   Call      'CHKOEC  '
042100020304 001 C                   Parm      'EDTCHG  '    WWRQS
042200020304 001 C                   Parm                    WWRTN
042300020304 001 C                   Parm                    WUDTA
042400020304     C                   ELSE
042500061129 001 C                   Call      'CHKOEC  '
042600020304 001 C                   Parm      'EDTADD  '    WWRQS
042700020304 001 C                   Parm                    WWRTN
042800020304 001 C                   Parm                    WUDTA
042900020304E001 C                   Endif
043000020304E001 C                   Endif
043100020304      *
043200020304B001 C                   Select
043300020304     C                   WHEN      WWRTN = *BLANKS
043400020304 001 C                   Move      'N'           WWERR
043500020304 001  *
043600020304     C                   WHEN      WWRTN = 'WARNING'
043700020304     C                   IF        WWWRNF = 'Y'
043800020304 002 C                   Move      'N'           WWERR
043900020304X002 C                   Else
044000020304 002 C                   Move      'Y'           WWWRNF
044100020304 002 C                   Move      'Y'           WWERR
044200020304E002 C                   Endif
044300020304 001  *
044400020304     C                   WHEN      WWRTN = 'ERROR  '
044500020304 001 C                   Move      'Y'           WWERR
044600020304 001 C                   Move      *BLANKS       WWSTT
044700020304 001 C                   Move      'N'           WWWRNF
044800020304E001 C                   Endsl
044900020304      *
045000020304     C                   Endsr
045100020304      *___________________________________________________________________
045200020304      * Process end - write data or release record
045300020304      *___________________________________________________________________
045400020304     C     PRCEND        Begsr
045500020304      *
045600020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
045700020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
045800020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
045900020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
046000020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
046100020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
046200020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
046300020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
046400020304 001 C                   Endcs
046500020304 001  *
046600020304     C                   IF        WWRTN <> *BLANKS
046700020304 002 C                   Move      *BLANKS       WWSTT
046800020304 002  *
046900020304X002 C                   Else
047000020304     C                   IF        WWFKA <> 'EXIT'
047100020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
047200020304 004 C                   Exsr      PRPPNL
047300020304E004 C                   Endif
047400020304E003 C                   Endif
047500020304E002 C                   Endif
047600020304 001  *
047700020304X001 C                   Else
047800020304 001 C                   Exsr      RELREC
047900020304E001 C                   Endif
048000020304      *
048100020304     C                   Endsr
048200020304      *___________________________________________________________________
048300020304      * Add new record
048400020304      *___________________________________________________________________
048500020304     C     WRTADD        Begsr
048600020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
048700020304     C                             WWTSK = 'COPY  '
048800020304 001 C                   Movel     'ADD    '     WWRQS
048900020304E001 C                   Endif
049000020304      *
049100020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
049200020304     C                             WWTSK = 'CPYKEY'
049300020304 001 C                   Movel     'ADDKEY '     WWRQS
049400020304E001 C                   Endif
049500020304      *
049600061129     C                   Call      'UPDOEC  '
049700020304     C                   Parm                    WWRQS
049800020304     C                   Parm                    WWRTN
049900020304     C                   Parm                    WUDTA
050000020304      *
050100020304     C                   IF        WWRTN <> *BLANKS
050200020304 001 C                   Movel     WTM(3)        WWMSG
050300020304 001 C                   Exsr      SNDMSG
050400020304X001 C                   Else
050500020304E001 C                   Endif
050600020304      *
050700020304     C                   Endsr
050800020304      *___________________________________________________________________
050900020304      * Write changed record
051000020304      *___________________________________________________________________
051100020304     C     WRTCHG        Begsr
051200061129     C                   Call      'UPDOEC  '
051300020304     C                   Parm      'CHANGE'      WWRQS
051400020304     C                   Parm                    WWRTN
051500020304     C                   Parm                    WUDTA
051600020304     C                   IF        WWRTN <> *BLANKS
051700020304 001 C                   Movel     WTM(2)        WWMSG
051800020304 001 C                   Exsr      SNDMSG
051900020304E001 C                   Endif
052000020304      *
052100020304     C                   Endsr
052200020304      *___________________________________________________________________
052300020304      * Release record
052400020304      *___________________________________________________________________
052500020304     C     RELREC        Begsr
052600061129     C                   Call      'UPDOEC  '
052700020304     C                   Parm      'RELEASE '    WWRQS
052800020304     C                   Parm                    WWRTN
052900020304     C                   Parm                    WUDTA
053000020304     C                   IF        WWRTN <> *BLANKS
053100020304 001 C                   Movel     WTM(4)        WWMSG
053200020304 001 C                   Exsr      SNDMSG
053300020304E001 C                   Endif
053400020304     C                   Endsr
053500020304      *___________________________________________________________________
053600020304      * Build function keys
053700020304      *___________________________________________________________________
053800020304     C     BLDFKY        Begsr
053900020304     C                   Movea     *IN           WWIN
054000020304     C                   Call      'PRCFKY2'
054100020304     C                   Parm      'BUILD   '    WWRQS
054200020304     C     WWFKA         Parm                    WWRTN
054300020304     C                   Parm                    WAD
054400020304     C                   Parm                    WWIN
054500020304     C                   Parm                    WAF
054600020304     C                   Parm                    WIFKV
054700020304     C     WWFKS         Add       WWFKS         WW
054800020304     C                   Movel     WAD(WW)       WSFKD2
054900020304     C                   Sub       1             WW
055000020304     C                   Movel     WAD(WW)       WSFKD1
055100020304     C                   Endsr
055200020304      *___________________________________________________________________
055300020304      * Send message
055400020304      *___________________________________________________________________
055500020304     C     SNDMSG        Begsr
055600020304     C                   Call      'QSNDDTAQ'
055700020304     C                   Parm                    WWDTAQ
055800020304     C                   Parm                    WWLIB
055900020304     C                   Parm                    WWLNGQ
056000020304     C                   Parm                    WWMSG
056100020304     C                   Endsr
056200020304      *___________________________________________________________________
056300020304      * Paremater list
056400020304      *___________________________________________________________________
056500020304     C     PLIST         Begsr
056600020304     C     *ENTRY        Plist
056700020304     C     WWTSK         Parm                    WIRQS
056800020304     C                   Parm                    WORTN
056900020304     C                   Parm                    WUPGM
057000020304     C                   Parm                    WUDTA
057100020304     C                   Parm                    WIFKV
057200020304     C                   Endsr
057300020304      *___________________________________________________________________
057400020304      * Initialize routine
057500020304      *___________________________________________________________________
057600020304     C     *INZSR        Begsr
057700020304     C     *LIKE         Define    WUDTA         WWDTA
057800020304     C     *LIKE         Define    WIRQS         WWRQS
057900020304     C     *LIKE         Define    WIRQS         WWORQS
058000020304     C     *LIKE         Define    WIRQS         WWTSK
058100020304     C     *LIKE         Define    WORTN         WWRTN
058200020304     C     *LIKE         Define    WORTN         WWFKA
058300020304     C     *LIKE         Define    WIFKV         WWFKV
058400020304     C     *LIKE         Define    WIFKV         WWOPV
058500020304     C                   Movel     'RESET   '    WWMSGC
058600020304     C                   Movel     '*'           MSPGMQ
058700020304     C                   Movel     'MSGDTAQ'     WWDTAQ
058800020304     C                   Movel     'QTEMP'       WWLIB
058900020304     C                   Z-add     80            WWLNGQ
059000020304     C                   Move      *BLANKS       WWMSG
059100020304     C                   Move      *BLANKS       WWIN
059200020304     C                   Move      *BLANKS       WWSTT
059300020304     C                   Move      *ZEROS        WWZERO
059400020304     C                   Z-add     1             WWPNL
059500020304     C                   Z-add     1             WWPNLN
059600020304     C                   Z-add     1             WWFKS
059700020304     C                   Move      'N'           WWERR
059800020304     C                   Move      'N'           WWCHG
059900020304     C                   Move      'N'           WWWRNF
060000020304     C                   Z-add     0             WW
060100061129     C                   Movel(P)  'AOECOD'      WWFIL
060200020304     C                   Move      *BLANKS       WWFLK
060300020304     C                   Move      *BLANKS       WWTXT
060400020304     C                   Endsr
060500020304      *___________________________________________________________________
060600020304      * Program error handler
060700020304      *___________________________________________________________________
060800020304     C     *PSSR         Begsr
060900020304     C                   Call      'SNDRPGM'                            50
061000020304     C                   Parm                    WQPGMN
061100020304     C                   Parm                    WQSTSC
061200020304     C                   Parm                    WQRPGS
061300020304     C                   Parm                    WQMSG
061400020304     C                   Endsr     '*CANCL'
061500020304      *___________________________________________________________________
061600020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06170002030403EXIT    F3=Exit
06190002030405REFRESH F5=Refresh
06200002030410UPDATE  F10=Update
06210002030412CANCEL  F12=Cancel
06220002030425ROLLUP
06230002030426ROLLDOWN
062400020304** WTM
06250006112900Request not supported in program CHGOEC.
06260002030400Update error.  Data was not updated.
06270002030400Duplicate key detected.  Data was NOT added to file.
06280002030400Record not found.
06290002030400Record not available now.
06300002030400The cursor is not in a prompt area.
06310002030400Default error.  Data not defaulted.
