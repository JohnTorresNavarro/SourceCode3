000100020304      *_________________________________________________________________________
000200020304      *
000300101101      *  Description:  Change GAS RENEWAL
000400020304      *
000500090204      *  (c)Copyright 2009 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700101101     FCHGGRWD   CF   E             WORKSTN INFDS(DSPD)
000800101101     FCARMSTP   IF   E           K DISK    PREFIX(RV:2) RENAME(CARMSTR:CARMSF)
000900020304      *
001000020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001100020304     D WAD             S             80    DIM(6)
001200020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001300020304      *_________________________________________________________________________
001400020304      * Data structure
001500101101     D WUDTA         E DS                  EXTNAME(RNW01GRW)
001600101102     D WDCARP        E DS                  EXTNAME(CARMSTP)
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
009400101102     d @lda            ds
009500101102     d blah                    1    240a
009600101102     d co_name               200    240a
009700101102     ***
009800020304      *_________________________________________________________________________
009900020304      *
010000020304      * Process Entry Panel
010100090317B1   C                   If        WWTSK = 'COPY' Or WWTSK = 'CPYKEY'
010200090317     C                   Eval      WWDTA = WUDTA
010300090317E1   C                   EndIf
010400020304      *
010500090317     C                   ExSR      PRPPNL
010600020304      *
010700090317B1   C                   DoW       WWSTT <> 'END'
010800090317     C                   ExSR      RCVMSG
010900090317     C                   ExSR      DSPPNL
011000090317     C                   ExSR      PRCFKY
011100020304      *
011200090317B2   C     WWFKA         CasEq     'KEYS    '    PRCDKY
011300090317     C     WWFKA         CasEq     'EXIT    '    PRCEXT
011400090317     C     WWFKA         CasEq     'PROMPT  '    PRCPMT
011500090317     C     WWFKA         CasEq     'REFRESH '    PRPPNL
011600090317     C     WWFKA         CasEq     'CANCEL  '    PRCCNL
011700090317     C     WWFKA         CasEq     'ROLLUP  '    PRCRUP
011800090317     C     WWFKA         CasEq     'ROLLDOWN'    PRCRDN
011900090317     C     WWFKA         CasEq     'ENTER   '    PRCPNL
012000090317     C     WWFKA         CasEq     'UPDATE  '    PRCEXT
012100090317E2   C                   EndCs
012200020304      *
012300020304B2   C                   IF        WWSTT = 'END'
012400090317     C                   ExSR      PRCEND
012500090317E2   C                   EndIf
012600090317E1   C                   EndDo
012700020304      *
012800020304      * Send Info Updated message.
012900090317     C                   If        WWCHG = 'Y'
013000090317     C                   Eval      WORTN = 'UPDATE'
013100090317     C                   EndIf
013200020304      *
013300020304     C                   Return
013400020304      *___________________________________________________________________
013500020304      * Prepare panel
013600020304      *___________________________________________________________________
013700020304     C     PRPPNL        Begsr
013800090317     c                   Eval      WORTN= *Blanks
013900090317     c                   Eval      WWERR = 'N'
014000090317     C                   Eval      WWCHG = 'N'
014100090317     C                   Eval      WWWRNF = 'N'
014200090317     C                   Eval      WWSTT = *Blanks
014300090317     C                   Z-Add     1             WWPNL
014400090317     C                   Z-Add     1             WWFKS
014500090317     C                   MoveA     WWZERO        *IN(60)
014600090317     C                   Eval      WWSTT = *Blanks
014700101102      *
014800101102     C     *DTAARA       DEFINE    *LDA          @LDA
014900101102     C                   IN        @LDA
015000101102     c                   eval      wsname = co_name
015100020304      *
015200090317B1   C                   If        WQPGMN = WUPGM
015300090317B2   C                   If        WIRQS <> WWORQS
015400020304     C                   Move      *BLANKS       WUPGM
015500090317E2   C                   EndIf
015600020304     C                   Move      WIRQS         WWORQS
015700090317E1   C                   EndIf
015800020304      *
015900020304     C                   Exsr      BLDFKY
016000020304      *
016100020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
016200020304     C     WWTSK         Caseq     'ADD     '    PRPADD
016300020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
016400020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016500020304     C                   Cas                     PRCERR
016600020304E1   C                   Endcs
016700020304      *
016800020304      *
016900020304     C                   Endsr
017000020304      *___________________________________________________________________
017100020304      * Prepare ADD request
017200020304      *___________________________________________________________________
017300020304     C     PRPADD        Begsr
017400020304     C                   Clear                   WUDTA
017500020304     C                   Exsr      DFTDTA
017600020304     C                   Endsr
017700020304      *___________________________________________________________________
017800020304      * Prepare CHANGE request
017900020304      *___________________________________________________________________
018000020304     C     PRPCHG        Begsr
018100101101     C                   Call      'UPDGRW  '
018200020304     C                   Parm      'GET     '    WWRQS
018300020304     C                   Parm                    WWRTN
018400020304     C                   Parm                    WUDTA
018500020304B1   C                   IF        WWRTN <> *BLANKS
018600020304B2   C                   IF        WWRTN = 'NOTAVL'
018700020304     C                   Movel     WTM(5)        WWMSG
018800020304X2   C                   Else
018900020304     C                   Movel     WTM(4)        WWMSG
019000020304E2   C                   Endif
019100020304     C                   Exsr      SNDMSG
019200020304     C                   Move      'ERROR   '    WORTN
019300020304     C                   Move      'END'         WWSTT
019400020304E1   C                   End
019500020304     C                   Endsr
019600020304      *___________________________________________________________________
019700020304      * Prepare COPY request
019800020304      *___________________________________________________________________
019900020304     C     PRPCPY        Begsr
020000020304     C                   Move      WWDTA         WUDTA
020100101101     C                   Call      'UPDGRW  '
020200020304     C                   Parm      'GETNL   '    WWRQS
020300020304     C                   Parm                    WWRTN
020400020304     C                   Parm                    WUDTA
020500020304B1   C                   IF        WWRTN <> *BLANKS
020600020304     C                   Movel     WTM(4)        WWMSG
020700020304     C                   Exsr      SNDMSG
020800020304     C                   Move      'ERROR   '    WORTN
020900020304     C                   Move      'END'         WWSTT
021000020304X1   C                   Else
021100020304     C                   Move      'Y'           WWCHG
021200020304     ***                 Clear                   MSMSID
021300020304E1   C                   Endif
021400020304     C                   Endsr
021500020304      *___________________________________________________________________
021600020304      * Default Data
021700020304      *___________________________________________________________________
021800020304     C     DFTDTA        Begsr
021900101101     C                   Call      'CHKGRW  '
022000020304     C                   Parm      'DFTDTA'      WWRQS
022100020304     C                   Parm                    WWRTN
022200020304     C                   Parm                    WUDTA
022300020304B1   C                   IF        WWRTN <> *BLANKS
022400020304     C                   Movel     WTM(7)        WWMSG
022500020304     C                   Exsr      SNDMSG
022600020304     C                   Move      'ERROR   '    WORTN
022700020304     C                   Move      'END'         WWSTT
022800020304E1   C                   Endif
022900020304     C                   Endsr
023000020304      *___________________________________________________________________
023100020304      * Process ERROR function
023200020304      *___________________________________________________________________
023300020304     C     PRCERR        Begsr
023400020304     C                   Move      WTM(1)        WWMSG
023500020304     C                   Exsr      SNDMSG
023600020304     C                   Move      'ERROR   '    WORTN
023700020304     C                   Move      'END'         WWSTT
023800020304     C                   Endsr
023900020304      *___________________________________________________________________
024000020304      * Receive messages
024100020304      *___________________________________________________________________
024200020304     C     RCVMSG        Begsr
024300020304B1   C                   IF        WWMSGC <> 'NORESET'
024400020304     C                   Movel     'RECEIVE'     WWRQS
024500020304X1   C                   Else
024600020304     C                   Movel     'DISPLAY'     WWRQS
024700020304E1   C                   Endif
024800020304     C                   Movel     'RESET   '    WWMSGC
024900020304     C                   Movea     *IN           WWIN
025000020304     C                   Call      'PRCMSG2'
025100020304     C                   Parm                    WWRQS
025200020304     C                   Parm                    WWIN
025300020304     C                   Parm                    WWRTN
025400020304     C                   Movea     WWIN          *IN
025500020304     C                   Endsr
025600020304      *___________________________________________________________________
025700020304      * Display panels
025800020304      *___________________________________________________________________
025900020304     C     DSPPNL        Begsr
026000020304      *
026100020304      * Set PUTOVR based on last display file processed
026200020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
026300020304     C                   MOVE      *OFF          *IN35
026400020304     C                   Move      WQPGMN        WUPGM
026500020304     C                   Move      WWPNL         WWPNLO
026600020304X1   C                   Else
026700020304     C                   MOVE      *ON           *IN35
026800020304E1   C                   Endif
026900020304      *
027000020304      * Set PROTECT key based on request
027100020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
027200020304     C                             WWTSK = 'COPY  '
027300100618 001 C                   Eval      *in40 = *off
027400020304X001 C                   Else
027500100618 001 C                   Eval      *in40 = *on
027600020304E001 C                   Endif
027700020304      *
027800020304      * Select title
027900020304     C                   IF        WWTSK = 'CHANGE'
028000100618 001 C                   Eval      *in38 = *off
028100020304X001 C                   Else
028200100618 001 C                   Eval      *in38 = *on
028300020304E001 C                   Endif
028400020304      *
028500020304      * Position cursor based on error status
028600020304     C                   IF        WWERR = 'Y'
028700100618 001 C                   Eval      *in99 = *on
028800020304X001 C                   Else
028900100618 001 C                   Eval      *in99 = *off
029000020304E001 C                   Endif
029100020304      *
029200020304      * Write message subfile
029300020304     C                   Seton                                        30
029400020304     C                   Write     MSGCTL
029500020304      *
029600020304      * Write entry panel
029700020304B001 C                   Select
029800020304     C                   WHEN      WWPNL = 1
029900101101     C     RGCAID        CHAIN     CARMSF
030000101101     C                   IF        %FOUND(CARMSTP)
030100101101     C                   EVAL      SCNAME = %TRIM(RVNAME)
030200101101     C                   ELSE
030300101101     C                   EVAL      SCNAME = '***ERROR***'
030400101101     C                   ENDIF
030500020304 001 C                   Exfmt     ENTPNL
030600020304 001 C                   Setoff                                       37
030700020304E001 C                   Endsl
030800020304      *
030900020304B001 C                   If        *IN39 = *ON
031000100618 001 C                   Eval      WWCHG = 'Y'
031100020304E001 C                   Endif
031200020304     C                   Endsr
031300020304      *___________________________________________________________________
031400020304      * Process function key
031500020304      *___________________________________________________________________
031600020304     C     PRCFKY        Begsr
031700020304     C                   Movea     *IN           WWIN
031800020304     C                   Call      'PRCFKY2'
031900020304     C                   Parm      'PROCESS '    WWRQS
032000020304     C     WWFKA         Parm                    WWRTN
032100020304     C                   Parm                    WAD
032200020304     C                   Parm                    WWIN
032300020304     C                   Parm                    WAF
032400020304     C                   Parm                    WIFKV
032500020304     C                   Endsr
032600020304      *___________________________________________________________________
032700020304      * Process KEYS function
032800020304      *___________________________________________________________________
032900020304     C     PRCDKY        Begsr
033000020304     C                   Z-add     1             WW
033100020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
033200060317 001 C                   Add       1             WWFKS
033300020304 001  *
033400020304     C                   IF        WWFKS > 3
033500020304 002 C                   Z-add     1             WWFKS
033600020304E002 C                   Endif
033700020304 001  *
033800060317     C                   Eval      WW = WWFKS + WWFKS
033900020304 001 C                   Sub       1             WW
034000020304E001 C                   Enddo
034100020304      *
034200020304     C                   Movel     WAD(WW)       WSFKD1
034300020304     C                   Add       1             WW
034400020304     C                   Movel     WAD(WW)       WSFKD2
034500020304     C                   Endsr
034600020304      *___________________________________________________________________
034700020304      * Process EXIT Function
034800020304      *___________________________________________________________________
034900020304     C     PRCEXT        Begsr
035000020304      *
035100020304     C                   Exsr      PRCPNL
035200020304      *
035300020304     C                   IF        WWERR = 'Y'
035400020304 001 C                   Move      *BLANKS       WWSTT
035500020304X001 C                   Else
035600020304 001 C                   Movel     WWFKA         WORTN
035700020304 001 C                   Move      'END'         WWSTT
035800020304E001 C                   Endif
035900020304     C                   Endsr
036000020304      *___________________________________________________________________
036100020304      * Process PROMPT function
036200020304      *___________________________________________________________________
036300020304     C     PRCPMT        Begsr
036400020304     C                   Movel     WDCRSL        WWRQS
036500020304     C                   Move      'Y'           WWCHG
036600020304     C                   Move      'N'           WWWRNF
036700020304     C                   Movel     'NORESET '    WWMSGC
036800020304      *
036900020304B001 C                   Select
037000101101 001 C                   When      WSFLD = 'RGCAID'
037100101101     C                   Call      'SLCCRM'                                     *ENTRY LIST
037200101101     C                   Parm                    WWRQS                          PROGRAM REQUEST
037300101101     C                   Parm                    WWRTN                          RETURN CODE
037400101101     C                   Parm                    WUPGM                          LAST PGM NAME
037500101101     C                   Parm                    WDCARP                         RECORD DS
037600020304     C                   IF        WWRTN = *BLANKS
037700101102     C                   Eval      RGCAID   =    CMCAID
037800101101     C                   EVAL      SCNAME   =    CMNAME
037900020304E001 C                   Endif
038000020304 001  *
038100020304 001 C                   Other
038200020304 001 C                   Move      WTM(6)        WWMSG
038300020304 001 C                   Exsr      SNDMSG
038400020304E001 C                   Endsl
038500020304      *
038600020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
038700020304     C                   Movel     WDCRSL        WWCRSL
038800020304     C     WWCRSN        Div       256           WSROW
038900020304     C                   Mvr                     WSLIN
039000020304     C                   Seton                                        37
039100020304      *
039200020304     C                   Endsr
039300020304      *___________________________________________________________________
039400020304      * Process CANCEL Function
039500020304      *___________________________________________________________________
039600020304     C     PRCCNL        Begsr
039700020304     C                   Movel     WWFKA         WORTN
039800020304     C                   Move      'END'         WWSTT
039900020304     C                   Move      'N'           WWCHG
040000020304     C                   Endsr
040100020304      *___________________________________________________________________
040200020304      * Process ROLLUP function
040300020304      *___________________________________________________________________
040400020304     C     PRCRUP        Begsr
040500020304     C     WWPNL         Add       1             WWPNL
040600020304     C                   IF        WWPNL > WWPNLN
040700020304 001 C     WWPNL         Sub       1             WWPNL
040800020304E001 C                   Endif
040900020304     C                   Movel     'NORESET '    WWMSGC
041000020304     C                   Endsr
041100020304      *___________________________________________________________________
041200020304      * Process ROLLDOWN function
041300020304      *___________________________________________________________________
041400020304     C     PRCRDN        Begsr
041500020304     C     WWPNL         Sub       1             WWPNL
041600020304     C                   IF        WWPNL < 1
041700020304 001 C     WWPNL         Add       1             WWPNL
041800020304E001 C                   Endif
041900020304     C                   Movel     'NORESET '    WWMSGC
042000020304     C                   Endsr
042100020304      *___________________________________________________________________
042200020304      * Process ENTER function
042300020304      *___________________________________________________________________
042400020304     C     PRCPNL        Begsr
042500020304     C                   Move      *BLANKS       WWRTN
042600020304     C                   Movea     *ZEROS        *IN(60)
042700020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
042800020304 001 C                   Move      'N'           WWWRNF
042900020304     C                   IF        WWTSK = 'CHANGE  '
043000101101 001 C                   Call      'CHKGRW  '
043100020304 001 C                   Parm      'EDTCHG  '    WWRQS
043200020304 001 C                   Parm                    WWRTN
043300020304 001 C                   Parm                    WUDTA
043400020304     C                   ELSE
043500101101 001 C                   Call      'CHKGRW  '
043600020304 001 C                   Parm      'EDTADD  '    WWRQS
043700020304 001 C                   Parm                    WWRTN
043800020304 001 C                   Parm                    WUDTA
043900020304E001 C                   Endif
044000020304E001 C                   Endif
044100020304      *
044200020304B001 C                   Select
044300020304     C                   WHEN      WWRTN = *BLANKS
044400020304 001 C                   Move      'N'           WWERR
044500020304 001  *
044600020304     C                   WHEN      WWRTN = 'WARNING'
044700020304     C                   IF        WWWRNF = 'Y'
044800020304 002 C                   Move      'N'           WWERR
044900020304X002 C                   Else
045000020304 002 C                   Move      'Y'           WWWRNF
045100020304 002 C                   Move      'Y'           WWERR
045200020304E002 C                   Endif
045300020304 001  *
045400020304     C                   WHEN      WWRTN = 'ERROR  '
045500020304 001 C                   Move      'Y'           WWERR
045600020304 001 C                   Move      *BLANKS       WWSTT
045700020304 001 C                   Move      'N'           WWWRNF
045800020304E001 C                   Endsl
045900020304      *
046000020304     C                   Endsr
046100020304      *___________________________________________________________________
046200020304      * Process end - write data or release record
046300020304      *___________________________________________________________________
046400020304     C     PRCEND        Begsr
046500020304      *
046600020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
046700020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
046800020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
046900020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
047000020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
047100020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
047200020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
047300020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
047400020304 001 C                   Endcs
047500020304 001  *
047600020304     C                   IF        WWRTN <> *BLANKS
047700020304 002 C                   Move      *BLANKS       WWSTT
047800020304 002  *
047900020304X002 C                   Else
048000020304     C                   IF        WWFKA <> 'EXIT'
048100020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
048200020304 004 C                   Exsr      PRPPNL
048300020304E004 C                   Endif
048400020304E003 C                   Endif
048500020304E002 C                   Endif
048600020304 001  *
048700020304X001 C                   Else
048800020304 001 C                   Exsr      RELREC
048900020304E001 C                   Endif
049000020304      *
049100020304     C                   Endsr
049200020304      *___________________________________________________________________
049300020304      * Add new record
049400020304      *___________________________________________________________________
049500020304     C     WRTADD        Begsr
049600020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
049700020304     C                             WWTSK = 'COPY  '
049800020304 001 C                   Movel     'ADD    '     WWRQS
049900020304E001 C                   Endif
050000020304      *
050100020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
050200020304     C                             WWTSK = 'CPYKEY'
050300020304 001 C                   Movel     'ADDKEY '     WWRQS
050400020304E001 C                   Endif
050500020304      *
050600101101     C                   Call      'UPDGRW  '
050700020304     C                   Parm                    WWRQS
050800020304     C                   Parm                    WWRTN
050900020304     C                   Parm                    WUDTA
051000020304      *
051100020304     C                   IF        WWRTN <> *BLANKS
051200020304 001 C                   Movel     WTM(3)        WWMSG
051300020304 001 C                   Exsr      SNDMSG
051400020304X001 C                   Else
051500020304E001 C                   Endif
051600020304      *
051700020304     C                   Endsr
051800020304      *___________________________________________________________________
051900020304      * Write changed record
052000020304      *___________________________________________________________________
052100020304     C     WRTCHG        Begsr
052200101101     C                   Call      'UPDGRW  '
052300020304     C                   Parm      'CHANGE'      WWRQS
052400020304     C                   Parm                    WWRTN
052500020304     C                   Parm                    WUDTA
052600020304     C                   IF        WWRTN <> *BLANKS
052700020304 001 C                   Movel     WTM(2)        WWMSG
052800020304 001 C                   Exsr      SNDMSG
052900020304E001 C                   Endif
053000020304      *
053100020304     C                   Endsr
053200020304      *___________________________________________________________________
053300020304      * Release record
053400020304      *___________________________________________________________________
053500020304     C     RELREC        Begsr
053600101101     C                   Call      'UPDGRW  '
053700020304     C                   Parm      'RELEASE '    WWRQS
053800020304     C                   Parm                    WWRTN
053900020304     C                   Parm                    WUDTA
054000020304     C                   IF        WWRTN <> *BLANKS
054100020304 001 C                   Movel     WTM(4)        WWMSG
054200020304 001 C                   Exsr      SNDMSG
054300020304E001 C                   Endif
054400020304     C                   Endsr
054500020304      *___________________________________________________________________
054600020304      * Build function keys
054700020304      *___________________________________________________________________
054800020304     C     BLDFKY        Begsr
054900020304     C                   Movea     *IN           WWIN
055000020304     C                   Call      'PRCFKY2'
055100020304     C                   Parm      'BUILD   '    WWRQS
055200020304     C     WWFKA         Parm                    WWRTN
055300020304     C                   Parm                    WAD
055400020304     C                   Parm                    WWIN
055500020304     C                   Parm                    WAF
055600020304     C                   Parm                    WIFKV
055700020304     C     WWFKS         Add       WWFKS         WW
055800020304     C                   Movel     WAD(WW)       WSFKD2
055900020304     C                   Sub       1             WW
056000020304     C                   Movel     WAD(WW)       WSFKD1
056100020304     C                   Endsr
056200020304      *___________________________________________________________________
056300020304      * Send message
056400020304      *___________________________________________________________________
056500020304     C     SNDMSG        Begsr
056600020304     C                   Call      'QSNDDTAQ'
056700020304     C                   Parm                    WWDTAQ
056800020304     C                   Parm                    WWLIB
056900020304     C                   Parm                    WWLNGQ
057000020304     C                   Parm                    WWMSG
057100020304     C                   Endsr
057200020304      *___________________________________________________________________
057300020304      * Paremater list
057400020304      *___________________________________________________________________
057500020304     C     PLIST         Begsr
057600020304     C     *ENTRY        Plist
057700020304     C     WWTSK         Parm                    WIRQS
057800020304     C                   Parm                    WORTN
057900020304     C                   Parm                    WUPGM
058000020304     C                   Parm                    WUDTA
058100020304     C                   Parm                    WIFKV
058200020304     C                   Endsr
058300020304      *___________________________________________________________________
058400020304      * Initialize routine
058500020304      *___________________________________________________________________
058600020304     C     *INZSR        Begsr
058700020304     C     *LIKE         Define    WUDTA         WWDTA
058800020304     C     *LIKE         Define    WIRQS         WWRQS
058900020304     C     *LIKE         Define    WIRQS         WWORQS
059000020304     C     *LIKE         Define    WIRQS         WWTSK
059100020304     C     *LIKE         Define    WORTN         WWRTN
059200020304     C     *LIKE         Define    WORTN         WWFKA
059300020304     C     *LIKE         Define    WIFKV         WWFKV
059400020304     C     *LIKE         Define    WIFKV         WWOPV
059500020304     C                   Movel     'RESET   '    WWMSGC
059600020304     C                   Movel     '*'           MSPGMQ
059700020304     C                   Movel     'MSGDTAQ'     WWDTAQ
059800020304     C                   Movel     'QTEMP'       WWLIB
059900020304     C                   Z-add     80            WWLNGQ
060000020304     C                   Move      *BLANKS       WWMSG
060100020304     C                   Move      *BLANKS       WWIN
060200020304     C                   Move      *BLANKS       WWSTT
060300020304     C                   Move      *ZEROS        WWZERO
060400020304     C                   Z-add     1             WWPNL
060500020304     C                   Z-add     1             WWPNLN
060600020304     C                   Z-add     1             WWFKS
060700020304     C                   Move      'N'           WWERR
060800020304     C                   Move      'N'           WWCHG
060900020304     C                   Move      'N'           WWWRNF
061000020304     C                   Z-add     0             WW
061100101101     C                   Movel(P)  'RNW01GRW'    WWFIL
061200020304     C                   Move      *BLANKS       WWFLK
061300020304     C                   Move      *BLANKS       WWTXT
061400020304     C                   Endsr
061500020304      *___________________________________________________________________
061600020304      * Program error handler
061700020304      *___________________________________________________________________
061800020304     C     *PSSR         Begsr
061900020304     C                   Call      'SNDRPGM'                            50
062000020304     C                   Parm                    WQPGMN
062100020304     C                   Parm                    WQSTSC
062200020304     C                   Parm                    WQRPGS
062300020304     C                   Parm                    WQMSG
062400020304     C                   Endsr     '*CANCL'
062500020304      *___________________________________________________________________
062600020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06270002030403EXIT    F3=Exit
06280002030404PROMPT  F4=Prompt
06290002030405REFRESH F5=Refresh
06300002030410UPDATE  F10=Update
06310002030412CANCEL  F12=Cancel
06320002030425ROLLUP
06330002030426ROLLDOWN
063400020304** WTM
06350010110100Request not supported in program CHGGRW.
06360002030400Update error.  Data was not updated.
06370002030400Duplicate key detected.  Data was NOT added to file.
06380002030400Record not found.
06390002030400Record not available now.
06400002030400The cursor is not in a prompt area.
06410002030400Default error.  Data not defaulted.
