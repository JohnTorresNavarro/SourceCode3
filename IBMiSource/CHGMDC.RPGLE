000100020304      *_________________________________________________________________________
000200020304      *
000300121011      *  Description:  Change MARKETING DIARY NOTE CODE
000400020304      *
000500121011      *  (c)Copyright 2012 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700121011     FCHGMDCD   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000020304     D WAD             S             80    DIM(6)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200121011      *_________________________________________________________________________
001300121011     D                UDS
001400121011     D  CONAME               201    240
001500020304      *_________________________________________________________________________
001600020304      * Data structure
001700121011     D WUDTA         E DS                  EXTNAME(CODE20P)
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
009500020304      *_________________________________________________________________________
009600020304      *
009700020304      * Process Entry Panel
009800090317B1   C                   If        WWTSK = 'COPY' Or WWTSK = 'CPYKEY'
009900090317     C                   Eval      WWDTA = WUDTA
010000090317E1   C                   EndIf
010100020304      *
010200090317     C                   ExSR      PRPPNL
010300020304      *
010400090317B1   C                   DoW       WWSTT <> 'END'
010500090317     C                   ExSR      RCVMSG
010600090317     C                   ExSR      DSPPNL
010700090317     C                   ExSR      PRCFKY
010800020304      *
010900090317B2   C     WWFKA         CasEq     'KEYS    '    PRCDKY
011000090317     C     WWFKA         CasEq     'EXIT    '    PRCEXT
011100090317     C     WWFKA         CasEq     'PROMPT  '    PRCPMT
011200090317     C     WWFKA         CasEq     'REFRESH '    PRPPNL
011300090317     C     WWFKA         CasEq     'CANCEL  '    PRCCNL
011400090317     C     WWFKA         CasEq     'ROLLUP  '    PRCRUP
011500090317     C     WWFKA         CasEq     'ROLLDOWN'    PRCRDN
011600090317     C     WWFKA         CasEq     'ENTER   '    PRCPNL
011700090317     C     WWFKA         CasEq     'UPDATE  '    PRCEXT
011800090317E2   C                   EndCs
011900020304      *
012000020304B2   C                   IF        WWSTT = 'END'
012100090317     C                   ExSR      PRCEND
012200090317E2   C                   EndIf
012300090317E1   C                   EndDo
012400020304      *
012500020304      * Send Info Updated message.
012600090317     C                   If        WWCHG = 'Y'
012700090317     C                   Eval      WORTN = 'UPDATE'
012800090317     C                   EndIf
012900020304      *
013000020304     C                   Return
013100020304      *___________________________________________________________________
013200020304      * Prepare panel
013300020304      *___________________________________________________________________
013400020304     C     PRPPNL        Begsr
013500090317     c                   Eval      WORTN= *Blanks
013600090317     c                   Eval      WWERR = 'N'
013700090317     C                   Eval      WWCHG = 'N'
013800090317     C                   Eval      WWWRNF = 'N'
013900090317     C                   Eval      WWSTT = *Blanks
014000090317     C                   Z-Add     1             WWPNL
014100090317     C                   Z-Add     1             WWFKS
014200090317     C                   MoveA     WWZERO        *IN(60)
014300090317     C                   Eval      WWSTT = *Blanks
014400020304      *
014500090317B1   C                   If        WQPGMN = WUPGM
014600090317B2   C                   If        WIRQS <> WWORQS
014700020304     C                   Move      *BLANKS       WUPGM
014800090317E2   C                   EndIf
014900020304     C                   Move      WIRQS         WWORQS
015000090317E1   C                   EndIf
015100020304      *
015200020304     C                   Exsr      BLDFKY
015300020304      *
015400020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015500020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015600020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
015700020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
015800020304     C                   Cas                     PRCERR
015900020304E1   C                   Endcs
016000020304      *
016100020304      *
016200020304     C                   Endsr
016300020304      *___________________________________________________________________
016400020304      * Prepare ADD request
016500020304      *___________________________________________________________________
016600020304     C     PRPADD        Begsr
016700020304     C                   Clear                   WUDTA
016800020304     C                   Exsr      DFTDTA
016900020304     C                   Endsr
017000020304      *___________________________________________________________________
017100020304      * Prepare CHANGE request
017200020304      *___________________________________________________________________
017300020304     C     PRPCHG        Begsr
017400121011     C                   Call      'UPDMDC  '
017500020304     C                   Parm      'GET     '    WWRQS
017600020304     C                   Parm                    WWRTN
017700020304     C                   Parm                    WUDTA
017800020304B1   C                   IF        WWRTN <> *BLANKS
017900020304B2   C                   IF        WWRTN = 'NOTAVL'
018000020304     C                   Movel     WTM(5)        WWMSG
018100020304X2   C                   Else
018200020304     C                   Movel     WTM(4)        WWMSG
018300020304E2   C                   Endif
018400020304     C                   Exsr      SNDMSG
018500020304     C                   Move      'ERROR   '    WORTN
018600020304     C                   Move      'END'         WWSTT
018700020304E1   C                   End
018800020304     C                   Endsr
018900020304      *___________________________________________________________________
019000020304      * Prepare COPY request
019100020304      *___________________________________________________________________
019200020304     C     PRPCPY        Begsr
019300020304     C                   Move      WWDTA         WUDTA
019400121011     C                   Call      'UPDMDC  '
019500020304     C                   Parm      'GETNL   '    WWRQS
019600020304     C                   Parm                    WWRTN
019700020304     C                   Parm                    WUDTA
019800020304B1   C                   IF        WWRTN <> *BLANKS
019900020304     C                   Movel     WTM(4)        WWMSG
020000020304     C                   Exsr      SNDMSG
020100020304     C                   Move      'ERROR   '    WORTN
020200020304     C                   Move      'END'         WWSTT
020300020304X1   C                   Else
020400020304     C                   Move      'Y'           WWCHG
020500020304     ***                 Clear                   MSMSID
020600020304E1   C                   Endif
020700020304     C                   Endsr
020800020304      *___________________________________________________________________
020900020304      * Default Data
021000020304      *___________________________________________________________________
021100020304     C     DFTDTA        Begsr
021200121011     C                   Call      'CHKMDC  '
021300020304     C                   Parm      'DFTDTA'      WWRQS
021400020304     C                   Parm                    WWRTN
021500020304     C                   Parm                    WUDTA
021600020304B1   C                   IF        WWRTN <> *BLANKS
021700020304     C                   Movel     WTM(7)        WWMSG
021800020304     C                   Exsr      SNDMSG
021900020304     C                   Move      'ERROR   '    WORTN
022000020304     C                   Move      'END'         WWSTT
022100020304E1   C                   Endif
022200020304     C                   Endsr
022300020304      *___________________________________________________________________
022400020304      * Process ERROR function
022500020304      *___________________________________________________________________
022600020304     C     PRCERR        Begsr
022700020304     C                   Move      WTM(1)        WWMSG
022800020304     C                   Exsr      SNDMSG
022900020304     C                   Move      'ERROR   '    WORTN
023000020304     C                   Move      'END'         WWSTT
023100020304     C                   Endsr
023200020304      *___________________________________________________________________
023300020304      * Receive messages
023400020304      *___________________________________________________________________
023500020304     C     RCVMSG        Begsr
023600020304B1   C                   IF        WWMSGC <> 'NORESET'
023700020304     C                   Movel     'RECEIVE'     WWRQS
023800020304X1   C                   Else
023900020304     C                   Movel     'DISPLAY'     WWRQS
024000020304E1   C                   Endif
024100020304     C                   Movel     'RESET   '    WWMSGC
024200020304     C                   Movea     *IN           WWIN
024300020304     C                   Call      'PRCMSG2'
024400020304     C                   Parm                    WWRQS
024500020304     C                   Parm                    WWIN
024600020304     C                   Parm                    WWRTN
024700020304     C                   Movea     WWIN          *IN
024800020304     C                   Endsr
024900020304      *___________________________________________________________________
025000020304      * Display panels
025100020304      *___________________________________________________________________
025200020304     C     DSPPNL        Begsr
025300020304      *
025400020304      * Set PUTOVR based on last display file processed
025500020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025600020304     C                   MOVE      *OFF          *IN35
025700020304     C                   Move      WQPGMN        WUPGM
025800020304     C                   Move      WWPNL         WWPNLO
025900020304X1   C                   Else
026000020304     C                   MOVE      *ON           *IN35
026100020304E1   C                   Endif
026200020304      *
026300020304      * Set PROTECT key based on request
026400020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026500020304     C                             WWTSK = 'COPY  '
026600100618 001 C                   Eval      *in40 = *off
026700020304X001 C                   Else
026800100618 001 C                   Eval      *in40 = *on
026900020304E001 C                   Endif
027000020304      *
027100020304      * Select title
027200020304     C                   IF        WWTSK = 'CHANGE'
027300100618 001 C                   Eval      *in38 = *off
027400020304X001 C                   Else
027500100618 001 C                   Eval      *in38 = *on
027600020304E001 C                   Endif
027700020304      *
027800020304      * Position cursor based on error status
027900020304     C                   IF        WWERR = 'Y'
028000100618 001 C                   Eval      *in99 = *on
028100020304X001 C                   Else
028200100618 001 C                   Eval      *in99 = *off
028300020304E001 C                   Endif
028400020304      *
028500020304      * Write message subfile
028600020304     C                   Seton                                        30
028700020304     C                   Write     MSGCTL
028800020304      *
028900020304      * Write entry panel
029000020304B001 C                   Select
029100020304     C                   WHEN      WWPNL = 1
029200121011     C                   MOVEL(P)  C20CODE       S20CODE
029300121011     C                   EVAL      WSNAME = CONAME
029400020304 001 C                   Exfmt     ENTPNL
029500121011     C                   MOVEL(P)  S20CODE       C20CODE
029600020304 001 C                   Setoff                                       37
029700020304E001 C                   Endsl
029800020304      *
029900020304B001 C                   If        *IN39 = *ON
030000100618 001 C                   Eval      WWCHG = 'Y'
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
032200060317 001 C                   Add       1             WWFKS
032300020304 001  *
032400020304     C                   IF        WWFKS > 3
032500020304 002 C                   Z-add     1             WWFKS
032600020304E002 C                   Endif
032700020304 001  *
032800060317     C                   Eval      WW = WWFKS + WWFKS
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
036000121011 001 C                   When      WSFLD = 'XXXXXX'
036100020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
036200040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
036300040305     C*                  Parm                    WWRTN                          RETURN CODE
036400040305     C*                  Parm                    WUPGM                          LAST PGM NAME
036500020304     C*                  Parm                    WDCARP                         RECORD DS
036600020304     C                   IF        WWRTN = *BLANKS
036700020304     C*                  Eval      MSCAID   =    CMCARR
036800020304     C*                  EVAL      WSCNAME  =    CMNAME
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
042000121011 001 C                   Call      'CHKMDC  '
042100020304 001 C                   Parm      'EDTCHG  '    WWRQS
042200020304 001 C                   Parm                    WWRTN
042300020304 001 C                   Parm                    WUDTA
042400020304     C                   ELSE
042500121011 001 C                   Call      'CHKMDC  '
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
049600121011     C                   Call      'UPDMDC  '
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
051200121011     C                   Call      'UPDMDC  '
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
052600121011     C                   Call      'UPDMDC  '
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
060100121011     C                   Movel(P)  'CODE20P '    WWFIL
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
06180002030404PROMPT  F4=Prompt
06190002030405REFRESH F5=Refresh
06200002030410UPDATE  F10=Update
06210002030412CANCEL  F12=Cancel
06220002030425ROLLUP
06230002030426ROLLDOWN
062400020304** WTM
06250012101100Request not supported in program CHGMDC.
06260002030400Update error.  Data was not updated.
06270002030400Duplicate key detected.  Data was NOT added to file.
06280002030400Record not found.
06290002030400Record not available now.
06300002030400The cursor is not in a prompt area.
06310002030400Default error.  Data not defaulted.
