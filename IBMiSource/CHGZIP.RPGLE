000100020304      *_________________________________________________________________________
000200020304      *
000300020927      *  Description:  Change Zip Code Cross Reference
000400020304      *
000500020304      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600020304      *_________________________________________________________________________
000700021003     FCHGZIPD   CF   E             WORKSTN INFDS(DSPD)
000800020927     FNYSUASM0  IF   E           K DISK
000900020304      *
001000020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001100020304     D WAD             S             80    DIM(6)
001200020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001300020304      *_________________________________________________________________________
001400020304      * Data structure
001500020927     D WUDTA         E DS                  EXTNAME(NYZIPXF0)
001600020927     D WSUAA         E DS                  EXTNAME(NYSUASM0)
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
002900020304     D WIFKV           S             60A
003000020304     D WIRQS           S              8A
003100020304     D WORTN           S              8A
003200020304     D WWORQS          S                   LIKE(WIRQS)
003300020304     D WUPGM           S             10A
003400020304     D WW              S              3P 0
003500020304     D WWCHG           S              1A
003600020304     D WWDTA           S                   LIKE(WUDTA)
003700020304     D WWDTAQ          S             10A
003800020304     D WWERR           S              1A
003900020304     D WWFIL           S             10A
004000020304     D WWFKA           S                   LIKE(WORTN)
004100020304     D WWFKS           S              1P 0
004200020304     D WWFKV           S                   LIKE(WIFKV)
004300020304     D WWFLK           S            128A
004400020304     D WWIN            S             99A
004500020304     D WWLIB           S             10A
004600020304     D WWLNGQ          S              5P 0
004700020304     D WWMSG           S             80A
004800020304     D WWMSGC          S              7A
004900020304     D WWOPV           S                   LIKE(WIFKV)
005000020304     D WWPNL           S              1P 0
005100020304     D WWPNLN          S              1P 0
005200020304     D WWPNLO          S                   LIKE(WWPNL)
005300020304     D WWRQS           S                   LIKE(WIRQS)
005400020304     D WWRTN           S                   LIKE(WORTN)
005500020304     D WWSTT           S              3A
005600020304     D WWTSK           S                   LIKE(WIRQS)
005700020304     D WWTXT           S             60A
005800020304     D WWWRNF          S              1A
005900020304     D WWZERO          S             40A
006000020304     ***
006100020304      *_________________________________________________________________________
006200020304      *
006300020304      * Process Entry Panel
006400020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
006500020304     C                   Move      WUDTA         WWDTA
006600020304E1   C                   ENDIF
006700020304      *
006800020304     C                   Exsr      PRPPNL
006900020304      *
007000020304B1   C                   DOW       WWSTT <> 'END'
007100020304     C                   Exsr      RCVMSG
007200020304     C                   Exsr      DSPPNL
007300020304     C                   Exsr      PRCFKY
007400020304      *
007500020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
007600020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
007700020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
007800020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
007900020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
008000020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
008100020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
008200020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
008300020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
008400020304E2   C                   Endcs
008500020304      *
008600020304B2   C                   IF        WWSTT = 'END'
008700020304     C                   Exsr      PRCEND
008800020304E2   C                   Endif
008900020304E1   C                   Enddo
009000020304      *
009100020304      * Send Info Updated message.
009200020304     C                   IF        WWCHG = 'Y'
009300020304     C                   MOVEL     'UPDATE  '    WORTN
009400020304     C                   Endif
009500020304      *
009600020304     C                   Return
009700020304      *___________________________________________________________________
009800020304      * Prepare panel
009900020304      *___________________________________________________________________
010000020304     C     PRPPNL        Begsr
010100020304     C                   Move      *BLANKS       WORTN
010200020304     C                   Move      'N'           WWERR
010300020304     C                   Move      'N'           WWCHG
010400020304     C                   Move      'N'           WWWRNF
010500020304     C                   Move      *BLANKS       WWSTT
010600020304     C                   Z-add     1             WWPNL
010700020304     C                   Z-add     1             WWFKS
010800020304     C                   Movea     WWZERO        *IN(60)
010900020304     C                   Move      *BLANKS       WWSTT
011000020304      *
011100020304B1   C                   IF        WQPGMN = WUPGM
011200020304B2   C                   IF        WIRQS <> WWORQS
011300020304     C                   Move      *BLANKS       WUPGM
011400020304E2   C                   Endif
011500020304     C                   Move      WIRQS         WWORQS
011600020304E1   C                   Endif
011700020304      *
011800020304     C                   Exsr      BLDFKY
011900020304      *
012000020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
012100020304     C     WWTSK         Caseq     'ADD     '    PRPADD
012200020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
012300020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
012400020304     C                   Cas                     PRCERR
012500020304E1   C                   Endcs
012600020304      *
012700020304      *
012800020304     C                   Endsr
012900020304      *___________________________________________________________________
013000020304      * Prepare ADD request
013100020304      *___________________________________________________________________
013200020304     C     PRPADD        Begsr
013300020304     C                   Clear                   WUDTA
013400020304     C                   Exsr      DFTDTA
013500020304     C                   Endsr
013600020304      *___________________________________________________________________
013700020304      * Prepare CHANGE request
013800020304      *___________________________________________________________________
013900020304     C     PRPCHG        Begsr
014000021003     C                   Call      'UPDZIP  '
014100020304     C                   Parm      'GET     '    WWRQS
014200020304     C                   Parm                    WWRTN
014300020304     C                   Parm                    WUDTA
014400020304B1   C                   IF        WWRTN <> *BLANKS
014500020304B2   C                   IF        WWRTN = 'NOTAVL'
014600020304     C                   Movel     WTM(5)        WWMSG
014700020304X2   C                   Else
014800020304     C                   Movel     WTM(4)        WWMSG
014900020304E2   C                   Endif
015000020304     C                   Exsr      SNDMSG
015100020304     C                   Move      'ERROR   '    WORTN
015200020304     C                   Move      'END'         WWSTT
015300020304E1   C                   End
015400020304     C                   Endsr
015500020304      *___________________________________________________________________
015600020304      * Prepare COPY request
015700020304      *___________________________________________________________________
015800020304     C     PRPCPY        Begsr
015900020304     C                   Move      WWDTA         WUDTA
016000021003     C                   Call      'UPDZIP  '
016100020304     C                   Parm      'GETNL   '    WWRQS
016200020304     C                   Parm                    WWRTN
016300020304     C                   Parm                    WUDTA
016400020304B1   C                   IF        WWRTN <> *BLANKS
016500020304     C                   Movel     WTM(4)        WWMSG
016600020304     C                   Exsr      SNDMSG
016700020304     C                   Move      'ERROR   '    WORTN
016800020304     C                   Move      'END'         WWSTT
016900020304X1   C                   Else
017000020304     C                   Move      'Y'           WWCHG
017100020304     ***                 Clear                   MSMSID
017200020304E1   C                   Endif
017300020304     C                   Endsr
017400020304      *___________________________________________________________________
017500020304      * Default Data
017600020304      *___________________________________________________________________
017700020304     C     DFTDTA        Begsr
017800021003     C                   Call      'CHKZIP  '
017900020304     C                   Parm      'DFTDTA'      WWRQS
018000020304     C                   Parm                    WWRTN
018100020304     C                   Parm                    WUDTA
018200020304B1   C                   IF        WWRTN <> *BLANKS
018300020304     C                   Movel     WTM(7)        WWMSG
018400020304     C                   Exsr      SNDMSG
018500020304     C                   Move      'ERROR   '    WORTN
018600020304     C                   Move      'END'         WWSTT
018700020304E1   C                   Endif
018800020304     C                   Endsr
018900020304      *___________________________________________________________________
019000020304      * Process ERROR function
019100020304      *___________________________________________________________________
019200020304     C     PRCERR        Begsr
019300020304     C                   Move      WTM(1)        WWMSG
019400020304     C                   Exsr      SNDMSG
019500020304     C                   Move      'ERROR   '    WORTN
019600020304     C                   Move      'END'         WWSTT
019700020304     C                   Endsr
019800020304      *___________________________________________________________________
019900020304      * Receive messages
020000020304      *___________________________________________________________________
020100020304     C     RCVMSG        Begsr
020200020304B1   C                   IF        WWMSGC <> 'NORESET'
020300020304     C                   Movel     'RECEIVE'     WWRQS
020400020304X1   C                   Else
020500020304     C                   Movel     'DISPLAY'     WWRQS
020600020304E1   C                   Endif
020700020304     C                   Movel     'RESET   '    WWMSGC
020800020304     C                   Movea     *IN           WWIN
020900020304     C                   Call      'PRCMSG2'
021000020304     C                   Parm                    WWRQS
021100020304     C                   Parm                    WWIN
021200020304     C                   Parm                    WWRTN
021300020304     C                   Movea     WWIN          *IN
021400020304     C                   Endsr
021500020304      *___________________________________________________________________
021600020304      * Display panels
021700020304      *___________________________________________________________________
021800020304     C     DSPPNL        Begsr
021900020304      *
022000020304      * Set PUTOVR based on last display file processed
022100020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
022200020304     C                   MOVE      *OFF          *IN35
022300020304     C                   Move      WQPGMN        WUPGM
022400020304     C                   Move      WWPNL         WWPNLO
022500020304X1   C                   Else
022600020304     C                   MOVE      *ON           *IN35
022700020304E1   C                   Endif
022800020304      *
022900020304      * Set PROTECT key based on request
023000020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
023100020304     C                             WWTSK = 'COPY  '
023200020304 001 C                   Setoff                                       40
023300020304X001 C                   Else
023400020304 001 C                   Seton                                        40
023500020304E001 C                   Endif
023600020304      *
023700020304      * Select title
023800020304     C                   IF        WWTSK = 'CHANGE'
023900020304 001 C                   MOVE      *OFF          *IN38
024000020304X001 C                   Else
024100020304 001 C                   MOVE      *ON           *IN38
024200020304E001 C                   Endif
024300020304      *
024400020304      * Position cursor based on error status
024500020304     C                   IF        WWERR = 'Y'
024600020304 001 C                   MOVE      *ON           *IN99
024700020304X001 C                   Else
024800020304 001 C                   MOVE      *OFF          *IN99
024900020304E001 C                   Endif
025000020304      *
025100020304      * Write message subfile
025200020304     C                   Seton                                        30
025300020304     C                   Write     MSGCTL
025400020927      *
025500020927      * GET REGION NAME
025600020927     C     ZXREGION      CHAIN     RNYSUASM
025700020927     C                   IF        %FOUND(NYSUASM0)
025800020927     C                   EVAL      WWDESC = SURGDESC
025900020927     C                   ELSE
026000020927     C                   EVAL      WWDESC = *BLANKS
026100020927     C                   ENDIF
026200020304      *
026300020304      * Write entry panel
026400020304B001 C                   Select
026500020304     C                   WHEN      WWPNL = 1
026600020304 001 C                   Exfmt     ENTPNL
026700020304 001 C                   Setoff                                       37
026800020304E001 C                   Endsl
026900020304      *
027000020304B001 C                   If        *IN39 = *ON
027100020304 001 C                   Move      'Y'           WWCHG
027200020304E001 C                   Endif
027300020304     C                   Endsr
027400020304      *___________________________________________________________________
027500020304      * Process function key
027600020304      *___________________________________________________________________
027700020304     C     PRCFKY        Begsr
027800020304     C                   Movea     *IN           WWIN
027900020304     C                   Call      'PRCFKY2'
028000020304     C                   Parm      'PROCESS '    WWRQS
028100020304     C     WWFKA         Parm                    WWRTN
028200020304     C                   Parm                    WAD
028300020304     C                   Parm                    WWIN
028400020304     C                   Parm                    WAF
028500020304     C                   Parm                    WIFKV
028600020304     C                   Endsr
028700020304      *___________________________________________________________________
028800020304      * Process KEYS function
028900020304      *___________________________________________________________________
029000020304     C     PRCDKY        Begsr
029100020304     C                   Z-add     1             WW
029200020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
029300020304 001 C     WWFKS         Add       1             WWFKS
029400020304 001  *
029500020304     C                   IF        WWFKS > 3
029600020304 002 C                   Z-add     1             WWFKS
029700020304E002 C                   Endif
029800020304 001  *
029900020304 001 C     WWFKS         Add       WWFKS         WW
030000020304 001 C                   Sub       1             WW
030100020304E001 C                   Enddo
030200020304      *
030300020304     C                   Movel     WAD(WW)       WSFKD1
030400020304     C                   Add       1             WW
030500020304     C                   Movel     WAD(WW)       WSFKD2
030600020304     C                   Endsr
030700020304      *___________________________________________________________________
030800020304      * Process EXIT Function
030900020304      *___________________________________________________________________
031000020304     C     PRCEXT        Begsr
031100020304      *
031200020304     C                   Exsr      PRCPNL
031300020304      *
031400020304     C                   IF        WWERR = 'Y'
031500020304 001 C                   Move      *BLANKS       WWSTT
031600020304X001 C                   Else
031700020304 001 C                   Movel     WWFKA         WORTN
031800020304 001 C                   Move      'END'         WWSTT
031900020304E001 C                   Endif
032000020304     C                   Endsr
032100020304      *___________________________________________________________________
032200020304      * Process PROMPT function
032300020304      *___________________________________________________________________
032400020304     C     PRCPMT        Begsr
032500020304     C                   Movel     WDCRSL        WWRQS
032600020304     C                   Move      'Y'           WWCHG
032700020304     C                   Move      'N'           WWWRNF
032800020304     C                   Movel     'NORESET '    WWMSGC
032900020304      *
033000020304B001 C                   Select
033100020927 001 C                   When      WSFLD = 'ZXREGION'
033200020927     C                   Call      'SLCSUA'                                     *ENTRY LIST
033300020927     C                   Parm                    WWRQS             8            PROGRAM REQUEST
033400020927     C                   Parm                    WWRTN             8            RETURN CODE
033500020927     C                   Parm                    WUPGM            10            LAST PGM NAME
033600020927     C                   Parm                    WSUAA                          RECORD DS
033700020304     C                   IF        WWRTN = *BLANKS
033800020927     C                   Eval      ZXREGION = SUREGION
033900020927     C                   EVAL      WWDESC = SURGDESC
034000020304E001 C                   Endif
034100020304 001  *
034200020304 001 C                   Other
034300020304 001 C                   Move      WTM(6)        WWMSG
034400020304 001 C                   Exsr      SNDMSG
034500020304E001 C                   Endsl
034600020304      *
034700020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
034800020304     C                   Movel     WDCRSL        WWCRSL
034900020304     C     WWCRSN        Div       256           WSROW
035000020304     C                   Mvr                     WSLIN
035100020304     C                   Seton                                        37
035200020304      *
035300020304     C                   Endsr
035400020304      *___________________________________________________________________
035500020304      * Process CANCEL Function
035600020304      *___________________________________________________________________
035700020304     C     PRCCNL        Begsr
035800020304     C                   Movel     WWFKA         WORTN
035900020304     C                   Move      'END'         WWSTT
036000020304     C                   Move      'N'           WWCHG
036100020304     C                   Endsr
036200020304      *___________________________________________________________________
036300020304      * Process ROLLUP function
036400020304      *___________________________________________________________________
036500020304     C     PRCRUP        Begsr
036600020304     C     WWPNL         Add       1             WWPNL
036700020304     C                   IF        WWPNL > WWPNLN
036800020304 001 C     WWPNL         Sub       1             WWPNL
036900020304E001 C                   Endif
037000020304     C                   Movel     'NORESET '    WWMSGC
037100020304     C                   Endsr
037200020304      *___________________________________________________________________
037300020304      * Process ROLLDOWN function
037400020304      *___________________________________________________________________
037500020304     C     PRCRDN        Begsr
037600020304     C     WWPNL         Sub       1             WWPNL
037700020304     C                   IF        WWPNL < 1
037800020304 001 C     WWPNL         Add       1             WWPNL
037900020304E001 C                   Endif
038000020304     C                   Movel     'NORESET '    WWMSGC
038100020304     C                   Endsr
038200020304      *___________________________________________________________________
038300020304      * Process ENTER function
038400020304      *___________________________________________________________________
038500020304     C     PRCPNL        Begsr
038600020304     C                   Move      *BLANKS       WWRTN
038700020304     C                   Movea     *ZEROS        *IN(60)
038800020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
038900020304 001 C                   Move      'N'           WWWRNF
039000020304     C                   IF        WWTSK = 'CHANGE  '
039100021003 001 C                   Call      'CHKZIP  '
039200020304 001 C                   Parm      'EDTCHG  '    WWRQS
039300020304 001 C                   Parm                    WWRTN
039400020304 001 C                   Parm                    WUDTA
039500020304     C                   ELSE
039600021003 001 C                   Call      'CHKZIP  '
039700020304 001 C                   Parm      'EDTADD  '    WWRQS
039800020304 001 C                   Parm                    WWRTN
039900020304 001 C                   Parm                    WUDTA
040000020304E001 C                   Endif
040100020304E001 C                   Endif
040200020304      *
040300020304B001 C                   Select
040400020304     C                   WHEN      WWRTN = *BLANKS
040500020304 001 C                   Move      'N'           WWERR
040600020304 001  *
040700020304     C                   WHEN      WWRTN = 'WARNING'
040800020304     C                   IF        WWWRNF = 'Y'
040900020304 002 C                   Move      'N'           WWERR
041000020304X002 C                   Else
041100020304 002 C                   Move      'Y'           WWWRNF
041200020304 002 C                   Move      'Y'           WWERR
041300020304E002 C                   Endif
041400020304 001  *
041500020304     C                   WHEN      WWRTN = 'ERROR  '
041600020304 001 C                   Move      'Y'           WWERR
041700020304 001 C                   Move      *BLANKS       WWSTT
041800020304 001 C                   Move      'N'           WWWRNF
041900020304E001 C                   Endsl
042000020304      *
042100020304     C                   Endsr
042200020304      *___________________________________________________________________
042300020304      * Process end - write data or release record
042400020304      *___________________________________________________________________
042500020304     C     PRCEND        Begsr
042600020304      *
042700020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
042800020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
042900020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
043000020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
043100020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
043200020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
043300020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
043400020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
043500020304 001 C                   Endcs
043600020304 001  *
043700020304     C                   IF        WWRTN <> *BLANKS
043800020304 002 C                   Move      *BLANKS       WWSTT
043900020304 002  *
044000020304X002 C                   Else
044100020304     C                   IF        WWFKA <> 'EXIT'
044200020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
044300020304 004 C                   Exsr      PRPPNL
044400020304E004 C                   Endif
044500020304E003 C                   Endif
044600020304E002 C                   Endif
044700020304 001  *
044800020304X001 C                   Else
044900020304 001 C                   Exsr      RELREC
045000020304E001 C                   Endif
045100020304      *
045200020304     C                   Endsr
045300020304      *___________________________________________________________________
045400020304      * Add new record
045500020304      *___________________________________________________________________
045600020304     C     WRTADD        Begsr
045700020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
045800020304     C                             WWTSK = 'COPY  '
045900020304 001 C                   Movel     'ADD    '     WWRQS
046000020304E001 C                   Endif
046100020304      *
046200020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
046300020304     C                             WWTSK = 'CPYKEY'
046400020304 001 C                   Movel     'ADDKEY '     WWRQS
046500020304E001 C                   Endif
046600020304      *
046700021003     C                   Call      'UPDZIP  '
046800020304     C                   Parm                    WWRQS
046900020304     C                   Parm                    WWRTN
047000020304     C                   Parm                    WUDTA
047100020304      *
047200020304     C                   IF        WWRTN <> *BLANKS
047300020304 001 C                   Movel     WTM(3)        WWMSG
047400020304 001 C                   Exsr      SNDMSG
047500020304X001 C                   Else
047600020304E001 C                   Endif
047700020304      *
047800020304     C                   Endsr
047900020304      *___________________________________________________________________
048000020304      * Write changed record
048100020304      *___________________________________________________________________
048200020304     C     WRTCHG        Begsr
048300021003     C                   Call      'UPDZIP  '
048400020304     C                   Parm      'CHANGE'      WWRQS
048500020304     C                   Parm                    WWRTN
048600020304     C                   Parm                    WUDTA
048700020304     C                   IF        WWRTN <> *BLANKS
048800020304 001 C                   Movel     WTM(2)        WWMSG
048900020304 001 C                   Exsr      SNDMSG
049000020304E001 C                   Endif
049100020304      *
049200020304     C                   Endsr
049300020304      *___________________________________________________________________
049400020304      * Release record
049500020304      *___________________________________________________________________
049600020304     C     RELREC        Begsr
049700021003     C                   Call      'UPDZIP  '
049800020304     C                   Parm      'RELEASE '    WWRQS
049900020304     C                   Parm                    WWRTN
050000020304     C                   Parm                    WUDTA
050100020304     C                   IF        WWRTN <> *BLANKS
050200020304 001 C                   Movel     WTM(4)        WWMSG
050300020304 001 C                   Exsr      SNDMSG
050400020304E001 C                   Endif
050500020304     C                   Endsr
050600020304      *___________________________________________________________________
050700020304      * Build function keys
050800020304      *___________________________________________________________________
050900020304     C     BLDFKY        Begsr
051000020304     C                   Movea     *IN           WWIN
051100020304     C                   Call      'PRCFKY2'
051200020304     C                   Parm      'BUILD   '    WWRQS
051300020304     C     WWFKA         Parm                    WWRTN
051400020304     C                   Parm                    WAD
051500020304     C                   Parm                    WWIN
051600020304     C                   Parm                    WAF
051700020304     C                   Parm                    WIFKV
051800020304     C     WWFKS         Add       WWFKS         WW
051900020304     C                   Movel     WAD(WW)       WSFKD2
052000020304     C                   Sub       1             WW
052100020304     C                   Movel     WAD(WW)       WSFKD1
052200020304     C                   Endsr
052300020304      *___________________________________________________________________
052400020304      * Send message
052500020304      *___________________________________________________________________
052600020304     C     SNDMSG        Begsr
052700020304     C                   Call      'QSNDDTAQ'
052800020304     C                   Parm                    WWDTAQ
052900020304     C                   Parm                    WWLIB
053000020304     C                   Parm                    WWLNGQ
053100020304     C                   Parm                    WWMSG
053200020304     C                   Endsr
053300020304      *___________________________________________________________________
053400020304      * Paremater list
053500020304      *___________________________________________________________________
053600020304     C     PLIST         Begsr
053700020304     C     *ENTRY        Plist
053800020304     C     WWTSK         Parm                    WIRQS
053900020304     C                   Parm                    WORTN
054000020304     C                   Parm                    WUPGM
054100020304     C                   Parm                    WUDTA
054200020304     C                   Parm                    WIFKV
054300020304     C                   Endsr
054400020304      *___________________________________________________________________
054500020304      * Initialize routine
054600020304      *___________________________________________________________________
054700020304     C     *INZSR        Begsr
054800020304     C     *LIKE         Define    WUDTA         WWDTA
054900020304     C     *LIKE         Define    WIRQS         WWRQS
055000020304     C     *LIKE         Define    WIRQS         WWORQS
055100020304     C     *LIKE         Define    WIRQS         WWTSK
055200020304     C     *LIKE         Define    WORTN         WWRTN
055300020304     C     *LIKE         Define    WORTN         WWFKA
055400020304     C     *LIKE         Define    WIFKV         WWFKV
055500020304     C     *LIKE         Define    WIFKV         WWOPV
055600020304     C                   Movel     'RESET   '    WWMSGC
055700020304     C                   Movel     '*'           MSPGMQ
055800020304     C                   Movel     'MSGDTAQ'     WWDTAQ
055900020304     C                   Movel     'QTEMP'       WWLIB
056000020304     C                   Z-add     80            WWLNGQ
056100020304     C                   Move      *BLANKS       WWMSG
056200020304     C                   Move      *BLANKS       WWIN
056300020304     C                   Move      *BLANKS       WWSTT
056400020304     C                   Move      *ZEROS        WWZERO
056500020304     C                   Z-add     1             WWPNL
056600020304     C                   Z-add     1             WWPNLN
056700020304     C                   Z-add     1             WWFKS
056800020304     C                   Move      'N'           WWERR
056900020304     C                   Move      'N'           WWCHG
057000020304     C                   Move      'N'           WWWRNF
057100020304     C                   Z-add     0             WW
057200020927     C                   Movel(P)  'NYZIPXF0'    WWFIL
057300020304     C                   Move      *BLANKS       WWFLK
057400020304     C                   Move      *BLANKS       WWTXT
057500020304     C                   Endsr
057600020304      *___________________________________________________________________
057700020304      * Program error handler
057800020304      *___________________________________________________________________
057900020304     C     *PSSR         Begsr
058000020304     C                   Call      'SNDRPGM'                            50
058100020304     C                   Parm                    WQPGMN
058200020304     C                   Parm                    WQSTSC
058300020304     C                   Parm                    WQRPGS
058400020304     C                   Parm                    WQMSG
058500020304     C                   Endsr     '*CANCL'
058600020304      *___________________________________________________________________
058700020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05880002030403EXIT    F3=Exit
05890002030404PROMPT  F4=Prompt
05900002030405REFRESH F5=Refresh
05910002030410UPDATE  F10=Update
05920002030412CANCEL  F12=Cancel
05930002030425ROLLUP
05940002030426ROLLDOWN
059500020304** WTM
05960002100300Request not supported in program CHGZIP.
05970002030400Update error.  Data was not updated.
05980002030400Duplicate key detected.  Data was NOT added to file.
05990002030400Record not found.
06000002030400Record not available now.
06010002030400The cursor is not in a prompt area.
06020002030400Default error.  Data not defaulted.
