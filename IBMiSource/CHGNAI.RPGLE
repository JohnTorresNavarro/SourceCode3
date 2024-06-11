000100020304      *_________________________________________________________________________
000200020304      *
000300130809      *  Description:  Change NASCO ALT ID XRF
000400020304      *
000500130131      *  (c)Copyright 2013 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700130809     FCHGNAID   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000020304     D WAD             S             80    DIM(6)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200020304      *_________________________________________________________________________
001300020304      * Data structure
001400130809     D WUDTA         E DS                  EXTNAME(MEMALT)
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
009100130809     ***
009200130809     d bch@lda         ds
009300130809     d blah                    1    240a
009400130809     d co_name               201    240a
009500020304     ***
009600020304      *_________________________________________________________________________
009700020304      *
009800020304      * Process Entry Panel
009900090317B1   C                   If        WWTSK = 'COPY' Or WWTSK = 'CPYKEY'
010000090317     C                   Eval      WWDTA = WUDTA
010100090317E1   C                   EndIf
010200020304      *
010300090317     C                   ExSR      PRPPNL
010400020304      *
010500090317B1   C                   DoW       WWSTT <> 'END'
010600090317     C                   ExSR      RCVMSG
010700090317     C                   ExSR      DSPPNL
010800090317     C                   ExSR      PRCFKY
010900020304      *
011000090317B2   C     WWFKA         CasEq     'KEYS    '    PRCDKY
011100090317     C     WWFKA         CasEq     'EXIT    '    PRCEXT
011200090317     C     WWFKA         CasEq     'PROMPT  '    PRCPMT
011300090317     C     WWFKA         CasEq     'REFRESH '    PRPPNL
011400090317     C     WWFKA         CasEq     'CANCEL  '    PRCCNL
011500090317     C     WWFKA         CasEq     'ROLLUP  '    PRCRUP
011600090317     C     WWFKA         CasEq     'ROLLDOWN'    PRCRDN
011700090317     C     WWFKA         CasEq     'ENTER   '    PRCPNL
011800090317     C     WWFKA         CasEq     'UPDATE  '    PRCEXT
011900090317E2   C                   EndCs
012000020304      *
012100020304B2   C                   IF        WWSTT = 'END'
012200090317     C                   ExSR      PRCEND
012300090317E2   C                   EndIf
012400090317E1   C                   EndDo
012500020304      *
012600020304      * Send Info Updated message.
012700090317     C                   If        WWCHG = 'Y'
012800090317     C                   Eval      WORTN = 'UPDATE'
012900090317     C                   EndIf
013000020304      *
013100020304     C                   Return
013200020304      *___________________________________________________________________
013300020304      * Prepare panel
013400020304      *___________________________________________________________________
013500020304     C     PRPPNL        Begsr
013600130809      *
013700130809     C     *DTAARA       DEFINE    *LDA          BCH@LDA
013800130809     C                   IN        BCH@LDA
013900130809     c                   eval      wsname = co_name
014000130809      *
014100090317     c                   Eval      WORTN= *Blanks
014200090317     c                   Eval      WWERR = 'N'
014300090317     C                   Eval      WWCHG = 'N'
014400090317     C                   Eval      WWWRNF = 'N'
014500090317     C                   Eval      WWSTT = *Blanks
014600090317     C                   Z-Add     1             WWPNL
014700090317     C                   Z-Add     1             WWFKS
014800090317     C                   MoveA     WWZERO        *IN(60)
014900090317     C                   Eval      WWSTT = *Blanks
015000020304      *
015100090317B1   C                   If        WQPGMN = WUPGM
015200090317B2   C                   If        WIRQS <> WWORQS
015300020304     C                   Move      *BLANKS       WUPGM
015400090317E2   C                   EndIf
015500020304     C                   Move      WIRQS         WWORQS
015600090317E1   C                   EndIf
015700020304      *
015800020304     C                   Exsr      BLDFKY
015900020304      *
016000020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
016100020304     C     WWTSK         Caseq     'ADD     '    PRPADD
016200020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
016300020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016400020304     C                   Cas                     PRCERR
016500020304E1   C                   Endcs
016600020304      *
016700020304      *
016800020304     C                   Endsr
016900020304      *___________________________________________________________________
017000020304      * Prepare ADD request
017100020304      *___________________________________________________________________
017200020304     C     PRPADD        Begsr
017300020304     C                   Clear                   WUDTA
017400020304     C                   Exsr      DFTDTA
017500020304     C                   Endsr
017600020304      *___________________________________________________________________
017700020304      * Prepare CHANGE request
017800020304      *___________________________________________________________________
017900020304     C     PRPCHG        Begsr
018000130809     C                   Call      'UPDNAI  '
018100020304     C                   Parm      'GET     '    WWRQS
018200020304     C                   Parm                    WWRTN
018300020304     C                   Parm                    WUDTA
018400130809      *
018500020304B1   C                   IF        WWRTN <> *BLANKS
018600020304B2   C                   IF        WWRTN = 'NOTAVL'
018700020304     C                   Movel     WTM(5)        WWMSG
018800020304X2   C                   Else
018900020304     C                   Movel     WTM(4)        WWMSG
019000020304E2   C                   Endif
019100020304     C                   Exsr      SNDMSG
019200020304     C                   Move      'ERROR   '    WORTN
019300020304     C                   Move      'END'         WWSTT
019400130809X2   C                   Else
019500130809     C                   EVAL      *IN61 = *ON
019600130809E1   C                   End
019700130809      *
019800020304     C                   Endsr
019900020304      *___________________________________________________________________
020000020304      * Prepare COPY request
020100020304      *___________________________________________________________________
020200020304     C     PRPCPY        Begsr
020300020304     C                   Move      WWDTA         WUDTA
020400130809     C                   Call      'UPDNAI  '
020500020304     C                   Parm      'GETNL   '    WWRQS
020600020304     C                   Parm                    WWRTN
020700020304     C                   Parm                    WUDTA
020800020304B1   C                   IF        WWRTN <> *BLANKS
020900020304     C                   Movel     WTM(4)        WWMSG
021000020304     C                   Exsr      SNDMSG
021100020304     C                   Move      'ERROR   '    WORTN
021200020304     C                   Move      'END'         WWSTT
021300020304X1   C                   Else
021400020304     C                   Move      'Y'           WWCHG
021500020304     ***                 Clear                   MSMSID
021600020304E1   C                   Endif
021700020304     C                   Endsr
021800020304      *___________________________________________________________________
021900020304      * Default Data
022000020304      *___________________________________________________________________
022100020304     C     DFTDTA        Begsr
022200130809     C                   Call      'CHKNAI  '
022300020304     C                   Parm      'DFTDTA'      WWRQS
022400020304     C                   Parm                    WWRTN
022500020304     C                   Parm                    WUDTA
022600020304B1   C                   IF        WWRTN <> *BLANKS
022700020304     C                   Movel     WTM(7)        WWMSG
022800020304     C                   Exsr      SNDMSG
022900020304     C                   Move      'ERROR   '    WORTN
023000020304     C                   Move      'END'         WWSTT
023100020304E1   C                   Endif
023200020304     C                   Endsr
023300020304      *___________________________________________________________________
023400020304      * Process ERROR function
023500020304      *___________________________________________________________________
023600020304     C     PRCERR        Begsr
023700020304     C                   Move      WTM(1)        WWMSG
023800020304     C                   Exsr      SNDMSG
023900020304     C                   Move      'ERROR   '    WORTN
024000020304     C                   Move      'END'         WWSTT
024100020304     C                   Endsr
024200020304      *___________________________________________________________________
024300020304      * Receive messages
024400020304      *___________________________________________________________________
024500020304     C     RCVMSG        Begsr
024600020304B1   C                   IF        WWMSGC <> 'NORESET'
024700020304     C                   Movel     'RECEIVE'     WWRQS
024800020304X1   C                   Else
024900020304     C                   Movel     'DISPLAY'     WWRQS
025000020304E1   C                   Endif
025100020304     C                   Movel     'RESET   '    WWMSGC
025200020304     C                   Movea     *IN           WWIN
025300020304     C                   Call      'PRCMSG2'
025400020304     C                   Parm                    WWRQS
025500020304     C                   Parm                    WWIN
025600020304     C                   Parm                    WWRTN
025700020304     C                   Movea     WWIN          *IN
025800020304     C                   Endsr
025900020304      *___________________________________________________________________
026000020304      * Display panels
026100020304      *___________________________________________________________________
026200020304     C     DSPPNL        Begsr
026300020304      *
026400020304      * Set PUTOVR based on last display file processed
026500020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
026600020304     C                   MOVE      *OFF          *IN35
026700020304     C                   Move      WQPGMN        WUPGM
026800020304     C                   Move      WWPNL         WWPNLO
026900020304X1   C                   Else
027000020304     C                   MOVE      *ON           *IN35
027100020304E1   C                   Endif
027200020304      *
027300020304      * Set PROTECT key based on request
027400020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
027500020304     C                             WWTSK = 'COPY  '
027600100618 001 C                   Eval      *in40 = *off
027700020304X001 C                   Else
027800100618 001 C                   Eval      *in40 = *on
027900020304E001 C                   Endif
028000020304      *
028100020304      * Select title
028200020304     C                   IF        WWTSK = 'CHANGE'
028300100618 001 C                   Eval      *in38 = *off
028400020304X001 C                   Else
028500100618 001 C                   Eval      *in38 = *on
028600020304E001 C                   Endif
028700020304      *
028800020304      * Position cursor based on error status
028900020304     C                   IF        WWERR = 'Y'
029000100618 001 C                   Eval      *in99 = *on
029100020304X001 C                   Else
029200100618 001 C                   Eval      *in99 = *off
029300020304E001 C                   Endif
029400020304      *
029500020304      * Write message subfile
029600020304     C                   Seton                                        30
029700020304     C                   Write     MSGCTL
029800020304      *
029900020304      * Write entry panel
030000020304B001 C                   Select
030100020304     C                   WHEN      WWPNL = 1
030200130809     C     MACRTDT       MULT      10000.0001    SCCRTDT
030300020304 001 C                   Exfmt     ENTPNL
030400020304 001 C                   Setoff                                       37
030500020304E001 C                   Endsl
030600020304      *
030700020304B001 C                   If        *IN39 = *ON
030800100618 001 C                   Eval      WWCHG = 'Y'
030900020304E001 C                   Endif
031000020304     C                   Endsr
031100020304      *___________________________________________________________________
031200020304      * Process function key
031300020304      *___________________________________________________________________
031400020304     C     PRCFKY        Begsr
031500020304     C                   Movea     *IN           WWIN
031600020304     C                   Call      'PRCFKY2'
031700020304     C                   Parm      'PROCESS '    WWRQS
031800020304     C     WWFKA         Parm                    WWRTN
031900020304     C                   Parm                    WAD
032000020304     C                   Parm                    WWIN
032100020304     C                   Parm                    WAF
032200020304     C                   Parm                    WIFKV
032300020304     C                   Endsr
032400020304      *___________________________________________________________________
032500020304      * Process KEYS function
032600020304      *___________________________________________________________________
032700020304     C     PRCDKY        Begsr
032800020304     C                   Z-add     1             WW
032900020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
033000060317 001 C                   Add       1             WWFKS
033100020304 001  *
033200020304     C                   IF        WWFKS > 3
033300020304 002 C                   Z-add     1             WWFKS
033400020304E002 C                   Endif
033500020304 001  *
033600060317     C                   Eval      WW = WWFKS + WWFKS
033700020304 001 C                   Sub       1             WW
033800020304E001 C                   Enddo
033900020304      *
034000020304     C                   Movel     WAD(WW)       WSFKD1
034100020304     C                   Add       1             WW
034200020304     C                   Movel     WAD(WW)       WSFKD2
034300020304     C                   Endsr
034400020304      *___________________________________________________________________
034500020304      * Process EXIT Function
034600020304      *___________________________________________________________________
034700020304     C     PRCEXT        Begsr
034800020304      *
034900020304     C                   Exsr      PRCPNL
035000020304      *
035100020304     C                   IF        WWERR = 'Y'
035200020304 001 C                   Move      *BLANKS       WWSTT
035300020304X001 C                   Else
035400020304 001 C                   Movel     WWFKA         WORTN
035500020304 001 C                   Move      'END'         WWSTT
035600020304E001 C                   Endif
035700020304     C                   Endsr
035800020304      *___________________________________________________________________
035900020304      * Process PROMPT function
036000020304      *___________________________________________________________________
036100020304     C     PRCPMT        Begsr
036200020304     C                   Movel     WDCRSL        WWRQS
036300020304     C                   Move      'Y'           WWCHG
036400020304     C                   Move      'N'           WWWRNF
036500020304     C                   Movel     'NORESET '    WWMSGC
036600020304      *
036700020304B001 C                   Select
036800020304 001 C                   When      WSFLD = 'XXXXXX'
036900020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
037000040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
037100040305     C*                  Parm                    WWRTN                          RETURN CODE
037200040305     C*                  Parm                    WUPGM                          LAST PGM NAME
037300020304     C*                  Parm                    WDCARP                         RECORD DS
037400020304     C                   IF        WWRTN = *BLANKS
037500020304     C*                  Eval      MSCAID   =    CMCARR
037600020304     C*                  EVAL      WSCNAME  =    CMNAME
037700020304E001 C                   Endif
037800020304 001  *
037900020304 001 C                   Other
038000020304 001 C                   Move      WTM(6)        WWMSG
038100020304 001 C                   Exsr      SNDMSG
038200020304E001 C                   Endsl
038300020304      *
038400020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
038500020304     C                   Movel     WDCRSL        WWCRSL
038600020304     C     WWCRSN        Div       256           WSROW
038700020304     C                   Mvr                     WSLIN
038800020304     C                   Seton                                        37
038900020304      *
039000020304     C                   Endsr
039100020304      *___________________________________________________________________
039200020304      * Process CANCEL Function
039300020304      *___________________________________________________________________
039400020304     C     PRCCNL        Begsr
039500020304     C                   Movel     WWFKA         WORTN
039600020304     C                   Move      'END'         WWSTT
039700020304     C                   Move      'N'           WWCHG
039800020304     C                   Endsr
039900020304      *___________________________________________________________________
040000020304      * Process ROLLUP function
040100020304      *___________________________________________________________________
040200020304     C     PRCRUP        Begsr
040300020304     C     WWPNL         Add       1             WWPNL
040400020304     C                   IF        WWPNL > WWPNLN
040500020304 001 C     WWPNL         Sub       1             WWPNL
040600020304E001 C                   Endif
040700020304     C                   Movel     'NORESET '    WWMSGC
040800020304     C                   Endsr
040900020304      *___________________________________________________________________
041000020304      * Process ROLLDOWN function
041100020304      *___________________________________________________________________
041200020304     C     PRCRDN        Begsr
041300020304     C     WWPNL         Sub       1             WWPNL
041400020304     C                   IF        WWPNL < 1
041500020304 001 C     WWPNL         Add       1             WWPNL
041600020304E001 C                   Endif
041700020304     C                   Movel     'NORESET '    WWMSGC
041800020304     C                   Endsr
041900020304      *___________________________________________________________________
042000020304      * Process ENTER function
042100020304      *___________________________________________________________________
042200020304     C     PRCPNL        Begsr
042300020304     C                   Move      *BLANKS       WWRTN
042400020304     C                   Movea     *ZEROS        *IN(60)
042500020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
042600020304 001 C                   Move      'N'           WWWRNF
042700020304     C                   IF        WWTSK = 'CHANGE  '
042800130809 001 C                   Call      'CHKNAI  '
042900020304 001 C                   Parm      'EDTCHG  '    WWRQS
043000020304 001 C                   Parm                    WWRTN
043100020304 001 C                   Parm                    WUDTA
043200020304     C                   ELSE
043300130809 001 C                   Call      'CHKNAI  '
043400020304 001 C                   Parm      'EDTADD  '    WWRQS
043500020304 001 C                   Parm                    WWRTN
043600020304 001 C                   Parm                    WUDTA
043700020304E001 C                   Endif
043800020304E001 C                   Endif
043900020304      *
044000020304B001 C                   Select
044100020304     C                   WHEN      WWRTN = *BLANKS
044200020304 001 C                   Move      'N'           WWERR
044300020304 001  *
044400020304     C                   WHEN      WWRTN = 'WARNING'
044500020304     C                   IF        WWWRNF = 'Y'
044600020304 002 C                   Move      'N'           WWERR
044700020304X002 C                   Else
044800020304 002 C                   Move      'Y'           WWWRNF
044900020304 002 C                   Move      'Y'           WWERR
045000020304E002 C                   Endif
045100020304 001  *
045200020304     C                   WHEN      WWRTN = 'ERROR  '
045300020304 001 C                   Move      'Y'           WWERR
045400020304 001 C                   Move      *BLANKS       WWSTT
045500020304 001 C                   Move      'N'           WWWRNF
045600020304E001 C                   Endsl
045700020304      *
045800020304     C                   Endsr
045900020304      *___________________________________________________________________
046000020304      * Process end - write data or release record
046100020304      *___________________________________________________________________
046200020304     C     PRCEND        Begsr
046300020304      *
046400020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
046500020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
046600020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
046700020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
046800020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
046900020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
047000020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
047100020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
047200020304 001 C                   Endcs
047300020304 001  *
047400020304     C                   IF        WWRTN <> *BLANKS
047500020304 002 C                   Move      *BLANKS       WWSTT
047600020304 002  *
047700020304X002 C                   Else
047800020304     C                   IF        WWFKA <> 'EXIT'
047900020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
048000020304 004 C                   Exsr      PRPPNL
048100020304E004 C                   Endif
048200020304E003 C                   Endif
048300020304E002 C                   Endif
048400020304 001  *
048500020304X001 C                   Else
048600020304 001 C                   Exsr      RELREC
048700020304E001 C                   Endif
048800020304      *
048900020304     C                   Endsr
049000020304      *___________________________________________________________________
049100020304      * Add new record
049200020304      *___________________________________________________________________
049300020304     C     WRTADD        Begsr
049400020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
049500020304     C                             WWTSK = 'COPY  '
049600020304 001 C                   Movel     'ADD    '     WWRQS
049700020304E001 C                   Endif
049800020304      *
049900020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
050000020304     C                             WWTSK = 'CPYKEY'
050100020304 001 C                   Movel     'ADDKEY '     WWRQS
050200020304E001 C                   Endif
050300020304      *
050400130809     C                   Call      'UPDNAI  '
050500020304     C                   Parm                    WWRQS
050600020304     C                   Parm                    WWRTN
050700020304     C                   Parm                    WUDTA
050800020304      *
050900020304     C                   IF        WWRTN <> *BLANKS
051000020304 001 C                   Movel     WTM(3)        WWMSG
051100020304 001 C                   Exsr      SNDMSG
051200020304X001 C                   Else
051300020304E001 C                   Endif
051400020304      *
051500020304     C                   Endsr
051600020304      *___________________________________________________________________
051700020304      * Write changed record
051800020304      *___________________________________________________________________
051900020304     C     WRTCHG        Begsr
052000130809     C                   Call      'UPDNAI  '
052100020304     C                   Parm      'CHANGE'      WWRQS
052200020304     C                   Parm                    WWRTN
052300020304     C                   Parm                    WUDTA
052400020304     C                   IF        WWRTN <> *BLANKS
052500020304 001 C                   Movel     WTM(2)        WWMSG
052600020304 001 C                   Exsr      SNDMSG
052700020304E001 C                   Endif
052800020304      *
052900020304     C                   Endsr
053000020304      *___________________________________________________________________
053100020304      * Release record
053200020304      *___________________________________________________________________
053300020304     C     RELREC        Begsr
053400130809     C                   Call      'UPDNAI  '
053500020304     C                   Parm      'RELEASE '    WWRQS
053600020304     C                   Parm                    WWRTN
053700020304     C                   Parm                    WUDTA
053800020304     C                   IF        WWRTN <> *BLANKS
053900020304 001 C                   Movel     WTM(4)        WWMSG
054000020304 001 C                   Exsr      SNDMSG
054100020304E001 C                   Endif
054200020304     C                   Endsr
054300020304      *___________________________________________________________________
054400020304      * Build function keys
054500020304      *___________________________________________________________________
054600020304     C     BLDFKY        Begsr
054700020304     C                   Movea     *IN           WWIN
054800020304     C                   Call      'PRCFKY2'
054900020304     C                   Parm      'BUILD   '    WWRQS
055000020304     C     WWFKA         Parm                    WWRTN
055100020304     C                   Parm                    WAD
055200020304     C                   Parm                    WWIN
055300020304     C                   Parm                    WAF
055400020304     C                   Parm                    WIFKV
055500020304     C     WWFKS         Add       WWFKS         WW
055600020304     C                   Movel     WAD(WW)       WSFKD2
055700020304     C                   Sub       1             WW
055800020304     C                   Movel     WAD(WW)       WSFKD1
055900020304     C                   Endsr
056000020304      *___________________________________________________________________
056100020304      * Send message
056200020304      *___________________________________________________________________
056300020304     C     SNDMSG        Begsr
056400020304     C                   Call      'QSNDDTAQ'
056500020304     C                   Parm                    WWDTAQ
056600020304     C                   Parm                    WWLIB
056700020304     C                   Parm                    WWLNGQ
056800020304     C                   Parm                    WWMSG
056900020304     C                   Endsr
057000020304      *___________________________________________________________________
057100020304      * Paremater list
057200020304      *___________________________________________________________________
057300020304     C     PLIST         Begsr
057400020304     C     *ENTRY        Plist
057500020304     C     WWTSK         Parm                    WIRQS
057600020304     C                   Parm                    WORTN
057700020304     C                   Parm                    WUPGM
057800020304     C                   Parm                    WUDTA
057900020304     C                   Parm                    WIFKV
058000020304     C                   Endsr
058100020304      *___________________________________________________________________
058200020304      * Initialize routine
058300020304      *___________________________________________________________________
058400020304     C     *INZSR        Begsr
058500020304     C     *LIKE         Define    WUDTA         WWDTA
058600020304     C     *LIKE         Define    WIRQS         WWRQS
058700020304     C     *LIKE         Define    WIRQS         WWORQS
058800020304     C     *LIKE         Define    WIRQS         WWTSK
058900020304     C     *LIKE         Define    WORTN         WWRTN
059000020304     C     *LIKE         Define    WORTN         WWFKA
059100020304     C     *LIKE         Define    WIFKV         WWFKV
059200020304     C     *LIKE         Define    WIFKV         WWOPV
059300020304     C                   Movel     'RESET   '    WWMSGC
059400020304     C                   Movel     '*'           MSPGMQ
059500020304     C                   Movel     'MSGDTAQ'     WWDTAQ
059600020304     C                   Movel     'QTEMP'       WWLIB
059700020304     C                   Z-add     80            WWLNGQ
059800020304     C                   Move      *BLANKS       WWMSG
059900020304     C                   Move      *BLANKS       WWIN
060000020304     C                   Move      *BLANKS       WWSTT
060100020304     C                   Move      *ZEROS        WWZERO
060200020304     C                   Z-add     1             WWPNL
060300020304     C                   Z-add     1             WWPNLN
060400020304     C                   Z-add     1             WWFKS
060500020304     C                   Move      'N'           WWERR
060600020304     C                   Move      'N'           WWCHG
060700020304     C                   Move      'N'           WWWRNF
060800020304     C                   Z-add     0             WW
060900060317     C                   Movel(P)  'FFFFFFF0'    WWFIL
061000020304     C                   Move      *BLANKS       WWFLK
061100020304     C                   Move      *BLANKS       WWTXT
061200020304     C                   Endsr
061300020304      *___________________________________________________________________
061400020304      * Program error handler
061500020304      *___________________________________________________________________
061600020304     C     *PSSR         Begsr
061700020304     C                   Call      'SNDRPGM'                            50
061800020304     C                   Parm                    WQPGMN
061900020304     C                   Parm                    WQSTSC
062000020304     C                   Parm                    WQRPGS
062100020304     C                   Parm                    WQMSG
062200020304     C                   Endsr     '*CANCL'
062300020304      *___________________________________________________________________
062400020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06250002030403EXIT    F3=Exit
06260002030404PROMPT  F4=Prompt
06270002030405REFRESH F5=Refresh
06280002030410UPDATE  F10=Update
06290002030412CANCEL  F12=Cancel
06300002030425ROLLUP
06310002030426ROLLDOWN
063200020304** WTM
06330013080900Request not supported in program CHGNAI.
06340002030400Update error.  Data was not updated.
06350002030400Duplicate key detected.  Data was NOT added to file.
06360002030400Record not found.
06370002030400Record not available now.
06380002030400The cursor is not in a prompt area.
06390002030400Default error.  Data not defaulted.
