000100020304      *_________________________________________________________________________
000200020304      *
000300060105      *  Description:  Change WEB CODES
000400020304      *
000500060105      *  (c)Copyright 2006 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700060105     FCHGWBCD   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000020304     D WAD             S             80    DIM(6)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200020304      *_________________________________________________________________________
001300020304      * Data structure
001400060105     D WUDTA         E DS                  EXTNAME(WEBCODE)
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
017100060105     C                   Call      'UPDWBC  '
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
019100060105     C                   Call      'UPDWBC  '
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
020900060105     C                   Call      'CHKWBC  '
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
028500060105      *
028600060105     C                   IF        WCDISP = 'N'
028700060105     C                   EVAL      SCVIS = 'NO'
028800060105     C                   ELSE
028900060105     C                   EVAL      SCVIS = 'YES'
029000060105     C                   ENDIF
029100060105    ***
029200060105     C                   SELECT
029300060105     C                   WHEN      WCSIGN = 'T'
029400060105     C                   EVAL      SCEDIT = 'TEXT'
029500060105     C                   WHEN      WCSIGN = 'D'
029600060105     C                   EVAL      SCEDIT = 'DATE'
029700060105     C                   WHEN      WCSIGN = 'R'
029800060105     C                   EVAL      SCEDIT = 'RELATION CODE'
029900060105     C                   WHEN      WCSIGN = 'C'
030000060105     C                   EVAL      SCEDIT = 'CURRENCY'
030100060105     C                   WHEN      WCSIGN = 'P'
030200060105     C                   EVAL      SCEDIT = 'PERCENTAGE'
030300060105     C                   WHEN      WCSIGN = 'S'
030400060105     C                   EVAL      SCEDIT = 'SOC SEC # FORMAT'
030500060105     C                   WHEN      WCSIGN = 'B'
030600060105     C                   EVAL      SCEDIT = 'PHONE NUMBER'
030700060105     C                   WHEN      WCSIGN = 'Z'
030800060105     C                   EVAL      SCEDIT = 'ZIP CODE'
030900060105     C                   OTHER
031000060105     C                   EVAL      SCEDIT = 'UNDEFINED'
031100060105     C                   ENDSL
031200020304      *
031300020304      * Write entry panel
031400020304B001 C                   Select
031500020304     C                   WHEN      WWPNL = 1
031600020304 001 C                   Exfmt     ENTPNL
031700020304 001 C                   Setoff                                       37
031800020304E001 C                   Endsl
031900020304      *
032000020304B001 C                   If        *IN39 = *ON
032100020304 001 C                   Move      'Y'           WWCHG
032200020304E001 C                   Endif
032300020304     C                   Endsr
032400020304      *___________________________________________________________________
032500020304      * Process function key
032600020304      *___________________________________________________________________
032700020304     C     PRCFKY        Begsr
032800020304     C                   Movea     *IN           WWIN
032900020304     C                   Call      'PRCFKY2'
033000020304     C                   Parm      'PROCESS '    WWRQS
033100020304     C     WWFKA         Parm                    WWRTN
033200020304     C                   Parm                    WAD
033300020304     C                   Parm                    WWIN
033400020304     C                   Parm                    WAF
033500020304     C                   Parm                    WIFKV
033600020304     C                   Endsr
033700020304      *___________________________________________________________________
033800020304      * Process KEYS function
033900020304      *___________________________________________________________________
034000020304     C     PRCDKY        Begsr
034100020304     C                   Z-add     1             WW
034200020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
034300020304 001 C     WWFKS         Add       1             WWFKS
034400020304 001  *
034500020304     C                   IF        WWFKS > 3
034600020304 002 C                   Z-add     1             WWFKS
034700020304E002 C                   Endif
034800020304 001  *
034900020304 001 C     WWFKS         Add       WWFKS         WW
035000020304 001 C                   Sub       1             WW
035100020304E001 C                   Enddo
035200020304      *
035300020304     C                   Movel     WAD(WW)       WSFKD1
035400020304     C                   Add       1             WW
035500020304     C                   Movel     WAD(WW)       WSFKD2
035600020304     C                   Endsr
035700020304      *___________________________________________________________________
035800020304      * Process EXIT Function
035900020304      *___________________________________________________________________
036000020304     C     PRCEXT        Begsr
036100020304      *
036200020304     C                   Exsr      PRCPNL
036300020304      *
036400020304     C                   IF        WWERR = 'Y'
036500020304 001 C                   Move      *BLANKS       WWSTT
036600020304X001 C                   Else
036700020304 001 C                   Movel     WWFKA         WORTN
036800020304 001 C                   Move      'END'         WWSTT
036900020304E001 C                   Endif
037000020304     C                   Endsr
037100020304      *___________________________________________________________________
037200020304      * Process PROMPT function
037300020304      *___________________________________________________________________
037400020304     C     PRCPMT        Begsr
037500020304     C                   Movel     WDCRSL        WWRQS
037600020304     C                   Move      'Y'           WWCHG
037700020304     C                   Move      'N'           WWWRNF
037800020304     C                   Movel     'NORESET '    WWMSGC
037900020304      *
038000020304B001 C                   Select
038100060105 001 C                   When      WSFLD = 'XXXXXX'
038200020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
038300040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
038400040305     C*                  Parm                    WWRTN                          RETURN CODE
038500040305     C*                  Parm                    WUPGM                          LAST PGM NAME
038600020304     C*                  Parm                    WDCARP                         RECORD DS
038700020304     C                   IF        WWRTN = *BLANKS
038800020304     C*                  Eval      MSCAID   =    CMCARR
038900020304     C*                  EVAL      WSCNAME  =    CMNAME
039000020304E001 C                   Endif
039100020304 001  *
039200020304 001 C                   Other
039300020304 001 C                   Move      WTM(6)        WWMSG
039400020304 001 C                   Exsr      SNDMSG
039500020304E001 C                   Endsl
039600020304      *
039700020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
039800020304     C                   Movel     WDCRSL        WWCRSL
039900020304     C     WWCRSN        Div       256           WSROW
040000020304     C                   Mvr                     WSLIN
040100020304     C                   Seton                                        37
040200020304      *
040300020304     C                   Endsr
040400020304      *___________________________________________________________________
040500020304      * Process CANCEL Function
040600020304      *___________________________________________________________________
040700020304     C     PRCCNL        Begsr
040800020304     C                   Movel     WWFKA         WORTN
040900020304     C                   Move      'END'         WWSTT
041000020304     C                   Move      'N'           WWCHG
041100020304     C                   Endsr
041200020304      *___________________________________________________________________
041300020304      * Process ROLLUP function
041400020304      *___________________________________________________________________
041500020304     C     PRCRUP        Begsr
041600020304     C     WWPNL         Add       1             WWPNL
041700020304     C                   IF        WWPNL > WWPNLN
041800020304 001 C     WWPNL         Sub       1             WWPNL
041900020304E001 C                   Endif
042000020304     C                   Movel     'NORESET '    WWMSGC
042100020304     C                   Endsr
042200020304      *___________________________________________________________________
042300020304      * Process ROLLDOWN function
042400020304      *___________________________________________________________________
042500020304     C     PRCRDN        Begsr
042600020304     C     WWPNL         Sub       1             WWPNL
042700020304     C                   IF        WWPNL < 1
042800020304 001 C     WWPNL         Add       1             WWPNL
042900020304E001 C                   Endif
043000020304     C                   Movel     'NORESET '    WWMSGC
043100020304     C                   Endsr
043200020304      *___________________________________________________________________
043300020304      * Process ENTER function
043400020304      *___________________________________________________________________
043500020304     C     PRCPNL        Begsr
043600020304     C                   Move      *BLANKS       WWRTN
043700020304     C                   Movea     *ZEROS        *IN(60)
043800020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
043900020304 001 C                   Move      'N'           WWWRNF
044000020304     C                   IF        WWTSK = 'CHANGE  '
044100060105 001 C                   Call      'CHKWBC  '
044200020304 001 C                   Parm      'EDTCHG  '    WWRQS
044300020304 001 C                   Parm                    WWRTN
044400020304 001 C                   Parm                    WUDTA
044500020304     C                   ELSE
044600060105 001 C                   Call      'CHKWBC  '
044700020304 001 C                   Parm      'EDTADD  '    WWRQS
044800020304 001 C                   Parm                    WWRTN
044900020304 001 C                   Parm                    WUDTA
045000020304E001 C                   Endif
045100020304E001 C                   Endif
045200020304      *
045300020304B001 C                   Select
045400020304     C                   WHEN      WWRTN = *BLANKS
045500020304 001 C                   Move      'N'           WWERR
045600020304 001  *
045700020304     C                   WHEN      WWRTN = 'WARNING'
045800020304     C                   IF        WWWRNF = 'Y'
045900020304 002 C                   Move      'N'           WWERR
046000020304X002 C                   Else
046100020304 002 C                   Move      'Y'           WWWRNF
046200020304 002 C                   Move      'Y'           WWERR
046300020304E002 C                   Endif
046400020304 001  *
046500020304     C                   WHEN      WWRTN = 'ERROR  '
046600020304 001 C                   Move      'Y'           WWERR
046700020304 001 C                   Move      *BLANKS       WWSTT
046800020304 001 C                   Move      'N'           WWWRNF
046900020304E001 C                   Endsl
047000020304      *
047100020304     C                   Endsr
047200020304      *___________________________________________________________________
047300020304      * Process end - write data or release record
047400020304      *___________________________________________________________________
047500020304     C     PRCEND        Begsr
047600020304      *
047700020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
047800020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
047900020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
048000020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
048100020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
048200020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
048300020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
048400020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
048500020304 001 C                   Endcs
048600020304 001  *
048700020304     C                   IF        WWRTN <> *BLANKS
048800020304 002 C                   Move      *BLANKS       WWSTT
048900020304 002  *
049000020304X002 C                   Else
049100020304     C                   IF        WWFKA <> 'EXIT'
049200020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
049300020304 004 C                   Exsr      PRPPNL
049400020304E004 C                   Endif
049500020304E003 C                   Endif
049600020304E002 C                   Endif
049700020304 001  *
049800020304X001 C                   Else
049900020304 001 C                   Exsr      RELREC
050000020304E001 C                   Endif
050100020304      *
050200020304     C                   Endsr
050300020304      *___________________________________________________________________
050400020304      * Add new record
050500020304      *___________________________________________________________________
050600020304     C     WRTADD        Begsr
050700020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
050800020304     C                             WWTSK = 'COPY  '
050900020304 001 C                   Movel     'ADD    '     WWRQS
051000020304E001 C                   Endif
051100020304      *
051200020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
051300020304     C                             WWTSK = 'CPYKEY'
051400020304 001 C                   Movel     'ADDKEY '     WWRQS
051500020304E001 C                   Endif
051600020304      *
051700060105     C                   Call      'UPDWBC  '
051800020304     C                   Parm                    WWRQS
051900020304     C                   Parm                    WWRTN
052000020304     C                   Parm                    WUDTA
052100020304      *
052200020304     C                   IF        WWRTN <> *BLANKS
052300020304 001 C                   Movel     WTM(3)        WWMSG
052400020304 001 C                   Exsr      SNDMSG
052500020304X001 C                   Else
052600020304E001 C                   Endif
052700020304      *
052800020304     C                   Endsr
052900020304      *___________________________________________________________________
053000020304      * Write changed record
053100020304      *___________________________________________________________________
053200020304     C     WRTCHG        Begsr
053300060105     C                   Call      'UPDWBC  '
053400020304     C                   Parm      'CHANGE'      WWRQS
053500020304     C                   Parm                    WWRTN
053600020304     C                   Parm                    WUDTA
053700020304     C                   IF        WWRTN <> *BLANKS
053800020304 001 C                   Movel     WTM(2)        WWMSG
053900020304 001 C                   Exsr      SNDMSG
054000020304E001 C                   Endif
054100020304      *
054200020304     C                   Endsr
054300020304      *___________________________________________________________________
054400020304      * Release record
054500020304      *___________________________________________________________________
054600020304     C     RELREC        Begsr
054700060105     C                   Call      'UPDWBC  '
054800020304     C                   Parm      'RELEASE '    WWRQS
054900020304     C                   Parm                    WWRTN
055000020304     C                   Parm                    WUDTA
055100020304     C                   IF        WWRTN <> *BLANKS
055200020304 001 C                   Movel     WTM(4)        WWMSG
055300020304 001 C                   Exsr      SNDMSG
055400020304E001 C                   Endif
055500020304     C                   Endsr
055600020304      *___________________________________________________________________
055700020304      * Build function keys
055800020304      *___________________________________________________________________
055900020304     C     BLDFKY        Begsr
056000020304     C                   Movea     *IN           WWIN
056100020304     C                   Call      'PRCFKY2'
056200020304     C                   Parm      'BUILD   '    WWRQS
056300020304     C     WWFKA         Parm                    WWRTN
056400020304     C                   Parm                    WAD
056500020304     C                   Parm                    WWIN
056600020304     C                   Parm                    WAF
056700020304     C                   Parm                    WIFKV
056800020304     C     WWFKS         Add       WWFKS         WW
056900020304     C                   Movel     WAD(WW)       WSFKD2
057000020304     C                   Sub       1             WW
057100020304     C                   Movel     WAD(WW)       WSFKD1
057200020304     C                   Endsr
057300020304      *___________________________________________________________________
057400020304      * Send message
057500020304      *___________________________________________________________________
057600020304     C     SNDMSG        Begsr
057700020304     C                   Call      'QSNDDTAQ'
057800020304     C                   Parm                    WWDTAQ
057900020304     C                   Parm                    WWLIB
058000020304     C                   Parm                    WWLNGQ
058100020304     C                   Parm                    WWMSG
058200020304     C                   Endsr
058300020304      *___________________________________________________________________
058400020304      * Paremater list
058500020304      *___________________________________________________________________
058600020304     C     PLIST         Begsr
058700020304     C     *ENTRY        Plist
058800020304     C     WWTSK         Parm                    WIRQS
058900020304     C                   Parm                    WORTN
059000020304     C                   Parm                    WUPGM
059100020304     C                   Parm                    WUDTA
059200020304     C                   Parm                    WIFKV
059300020304     C                   Endsr
059400020304      *___________________________________________________________________
059500020304      * Initialize routine
059600020304      *___________________________________________________________________
059700020304     C     *INZSR        Begsr
059800020304     C     *LIKE         Define    WUDTA         WWDTA
059900020304     C     *LIKE         Define    WIRQS         WWRQS
060000020304     C     *LIKE         Define    WIRQS         WWORQS
060100020304     C     *LIKE         Define    WIRQS         WWTSK
060200020304     C     *LIKE         Define    WORTN         WWRTN
060300020304     C     *LIKE         Define    WORTN         WWFKA
060400020304     C     *LIKE         Define    WIFKV         WWFKV
060500020304     C     *LIKE         Define    WIFKV         WWOPV
060600020304     C                   Movel     'RESET   '    WWMSGC
060700020304     C                   Movel     '*'           MSPGMQ
060800020304     C                   Movel     'MSGDTAQ'     WWDTAQ
060900020304     C                   Movel     'QTEMP'       WWLIB
061000020304     C                   Z-add     80            WWLNGQ
061100020304     C                   Move      *BLANKS       WWMSG
061200020304     C                   Move      *BLANKS       WWIN
061300020304     C                   Move      *BLANKS       WWSTT
061400020304     C                   Move      *ZEROS        WWZERO
061500020304     C                   Z-add     1             WWPNL
061600020304     C                   Z-add     1             WWPNLN
061700020304     C                   Z-add     1             WWFKS
061800020304     C                   Move      'N'           WWERR
061900020304     C                   Move      'N'           WWCHG
062000020304     C                   Move      'N'           WWWRNF
062100020304     C                   Z-add     0             WW
062200060105     C                   Movel(P)  'WEBCODE'     WWFIL
062300020304     C                   Move      *BLANKS       WWFLK
062400020304     C                   Move      *BLANKS       WWTXT
062500020304     C                   Endsr
062600020304      *___________________________________________________________________
062700020304      * Program error handler
062800020304      *___________________________________________________________________
062900020304     C     *PSSR         Begsr
063000020304     C                   Call      'SNDRPGM'                            50
063100020304     C                   Parm                    WQPGMN
063200020304     C                   Parm                    WQSTSC
063300020304     C                   Parm                    WQRPGS
063400020304     C                   Parm                    WQMSG
063500020304     C                   Endsr     '*CANCL'
063600020304      *___________________________________________________________________
063700020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06380002030403EXIT    F3=Exit
06390002030404PROMPT  F4=Prompt
06400002030405REFRESH F5=Refresh
06410002030410UPDATE  F10=Update
06420002030412CANCEL  F12=Cancel
06430002030425ROLLUP
06440002030426ROLLDOWN
064500020304** WTM
06460006010500Request not supported in program CHGWBC.
06470002030400Update error.  Data was not updated.
06480002030400Duplicate key detected.  Data was NOT added to file.
06490002030400Record not found.
06500002030400Record not available now.
06510002030400The cursor is not in a prompt area.
06520002030400Default error.  Data not defaulted.
