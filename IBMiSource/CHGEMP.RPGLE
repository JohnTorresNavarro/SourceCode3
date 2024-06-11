000100020304      *_________________________________________________________________________
000200020304      *
000300111212      *  Description:  Change EMPLOYEE AUXILIARY
000400020304      *
000500090204      *  (c)Copyright 2009 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700111212     FCHGEMPD   CF   E             WORKSTN INFDS(DSPD)
000800111222     FACMUNIQUE IF   E           K DISK
000900111222     FMEMBER    IF   E           K DISK
001000111222     FDEPNDC    IF   E           K DISK
001100020304      *
001200020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001300020304     D WAD             S             80    DIM(6)
001400020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001500111222     D                UDS
001600111222     D  CONAME               201    240
001700020304      *_________________________________________________________________________
001800020304      * Data structure
001900111212     D WUDTA         E DS                  EXTNAME(EMPAUX)
002000020304      *
002100020304      * Program status data structure
002200020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300020304      *
002400020304      * Display file data structure
002500020304     D DSPD          E DS                  EXTNAME(IODSPD)
002600020304      *
002700020304      * CURSOR LOCATION
002800020304     D                 DS
002900020304     D  WWCRSL                 1      2
003000020304     D  WWCRSN                 1      2B 0
003100020304     ***
003200020304     D WWDTA           S                   LIKE(WUDTA)
003300021008     ***
003400021008     D WIFKV           S             60A
003500021008     D WIFKY           S                   LIKE(WIFKV)
003600021008     D WIOPV           S                   LIKE(WIFKV)
003700021008     D WIRQS           S              8A
003800021008     D WORTN           S              8A
003900021008     D WUPGM           S             10A
004000021008     D WWCHG           S              1A
004100021008     D WWDLT           S              1A
004200021008     D WWDTAQ          S             10A
004300021008     D WWENDF          S              3A
004400021008     D WWENDO          S                   LIKE(WWENDF)
004500021008     D WWERR           S              1A
004600021008     D WWFIL           S             10A
004700021008     D WWFKA           S              8A
004800021008     D WWFKV           S                   LIKE(WIFKV)
004900021008     D WWFKY           S                   LIKE(WIFKV)
005000021008     D WWFLK           S            128A
005100021008     D WWFMTN          S              8A
005200021008     D WWFNC           S              8A
005300021008     D WWIJI           S             16A
005400021008     D WWIN            S             99A
005500021008     D WWLIB           S             10A
005600021008     D WWMSG           S             80A
005700021008     D WWMSGC          S              7A
005800021008     D WWOCD           S              8A
005900021008     D WWOPA           S              8A
006000021008     D WWOPN           S              1A
006100021008     D WWOPT           S              8A
006200021008     D WWOPV           S                   LIKE(WIFKV)
006300021008     D WWORQS          S                   LIKE(WIRQS)
006400021008     D WWPSNC          S              1A
006500021008     D WWQJN           S             26A
006600021008     D WWRQS           S                   LIKE(WIRQS)
006700021008     D WWRQSD          S                   LIKE(WIRQS)
006800021008     D WWRTN           S                   LIKE(WORTN)
006900021008     D WWRTND          S                   LIKE(WORTN)
007000021008     D WWRTNH          S                   LIKE(WORTN)
007100021008     D WWSFLE          S              1A
007200021008     D WWSTT           S              3A
007300021008     D WWTSK           S              8A
007400021008     D WWTXT           S             60A
007500021008     D WWUPD           S              1A
007600021008     D WWWRNF          S              1A
007700021008     D WWZERO          S             40A
007800021008     D WFRRN           S              4P 0
007900021008     D WW              S              3P 0
008000021008     D WWFKS           S              1P 0
008100021008     D WWFKSO          S                   LIKE(WWFKS)
008200021008     D WWLMT           S              2P 0
008300021008     D WWLNG           S             15P 5
008400021008     D WWLNGQ          S              5P 0
008500021008     D WWLOWR          S              4P 0
008600021008     D WWLSTS          S              2P 0
008700021008     D WWOPS           S              1P 0
008800021008     D WWOPSO          S                   LIKE(WWOPS)
008900021008     D WWPNL           S              1P 0
009000021008     D WWPNLN          S                   LIKE(WWPNL)
009100021008     D WWPNLO          S                   LIKE(WWPNL)
009200021008     D WWPSNI          S              2P 0
009300021008     D WWPSNN          S              1P 0
009400021008     D WWPSNP          S                   LIKE(WWPSNN)
009500021008     D WWRRN           S              4P 0
009600020304     ***
009700020304      *_________________________________________________________________________
009800020304      *
009900020304      * Process Entry Panel
010000090317B1   C                   If        WWTSK = 'COPY' Or WWTSK = 'CPYKEY'
010100090317     C                   Eval      WWDTA = WUDTA
010200090317E1   C                   EndIf
010300020304      *
010400090317     C                   ExSR      PRPPNL
010500020304      *
010600090317B1   C                   DoW       WWSTT <> 'END'
010700090317     C                   ExSR      RCVMSG
010800090317     C                   ExSR      DSPPNL
010900090317     C                   ExSR      PRCFKY
011000020304      *
011100090317B2   C     WWFKA         CasEq     'KEYS    '    PRCDKY
011200090317     C     WWFKA         CasEq     'EXIT    '    PRCEXT
011300090317     C     WWFKA         CasEq     'PROMPT  '    PRCPMT
011400090317     C     WWFKA         CasEq     'REFRESH '    PRPPNL
011500090317     C     WWFKA         CasEq     'CANCEL  '    PRCCNL
011600090317     C     WWFKA         CasEq     'ROLLUP  '    PRCRUP
011700090317     C     WWFKA         CasEq     'ROLLDOWN'    PRCRDN
011800090317     C     WWFKA         CasEq     'ENTER   '    PRCPNL
011900090317     C     WWFKA         CasEq     'UPDATE  '    PRCEXT
012000090317E2   C                   EndCs
012100020304      *
012200020304B2   C                   IF        WWSTT = 'END'
012300090317     C                   ExSR      PRCEND
012400090317E2   C                   EndIf
012500090317E1   C                   EndDo
012600020304      *
012700020304      * Send Info Updated message.
012800090317     C                   If        WWCHG = 'Y'
012900090317     C                   Eval      WORTN = 'UPDATE'
013000090317     C                   EndIf
013100020304      *
013200020304     C                   Return
013300020304      *___________________________________________________________________
013400020304      * Prepare panel
013500020304      *___________________________________________________________________
013600020304     C     PRPPNL        Begsr
013700090317     c                   Eval      WORTN= *Blanks
013800090317     c                   Eval      WWERR = 'N'
013900090317     C                   Eval      WWCHG = 'N'
014000090317     C                   Eval      WWWRNF = 'N'
014100090317     C                   Eval      WWSTT = *Blanks
014200090317     C                   Z-Add     1             WWPNL
014300090317     C                   Z-Add     1             WWFKS
014400090317     C                   MoveA     WWZERO        *IN(60)
014500090317     C                   Eval      WWSTT = *Blanks
014600020304      *
014700090317B1   C                   If        WQPGMN = WUPGM
014800090317B2   C                   If        WIRQS <> WWORQS
014900020304     C                   Move      *BLANKS       WUPGM
015000090317E2   C                   EndIf
015100020304     C                   Move      WIRQS         WWORQS
015200090317E1   C                   EndIf
015300020304      *
015400020304     C                   Exsr      BLDFKY
015500020304      *
015600020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015700020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015800020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
015900020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016000020304     C                   Cas                     PRCERR
016100020304E1   C                   Endcs
016200020304      *
016300020304      *
016400020304     C                   Endsr
016500020304      *___________________________________________________________________
016600020304      * Prepare ADD request
016700020304      *___________________________________________________________________
016800020304     C     PRPADD        Begsr
016900020304     C                   Clear                   WUDTA
017000020304     C                   Exsr      DFTDTA
017100020304     C                   Endsr
017200020304      *___________________________________________________________________
017300020304      * Prepare CHANGE request
017400020304      *___________________________________________________________________
017500020304     C     PRPCHG        Begsr
017600111212     C                   Call      'UPDEMP  '
017700020304     C                   Parm      'GET     '    WWRQS
017800020304     C                   Parm                    WWRTN
017900020304     C                   Parm                    WUDTA
018000020304B1   C                   IF        WWRTN <> *BLANKS
018100020304B2   C                   IF        WWRTN = 'NOTAVL'
018200020304     C                   Movel     WTM(5)        WWMSG
018300020304X2   C                   Else
018400020304     C                   Movel     WTM(4)        WWMSG
018500020304E2   C                   Endif
018600020304     C                   Exsr      SNDMSG
018700020304     C                   Move      'ERROR   '    WORTN
018800020304     C                   Move      'END'         WWSTT
018900020304E1   C                   End
019000020304     C                   Endsr
019100020304      *___________________________________________________________________
019200020304      * Prepare COPY request
019300020304      *___________________________________________________________________
019400020304     C     PRPCPY        Begsr
019500020304     C                   Move      WWDTA         WUDTA
019600111212     C                   Call      'UPDEMP  '
019700020304     C                   Parm      'GETNL   '    WWRQS
019800020304     C                   Parm                    WWRTN
019900020304     C                   Parm                    WUDTA
020000020304B1   C                   IF        WWRTN <> *BLANKS
020100020304     C                   Movel     WTM(4)        WWMSG
020200020304     C                   Exsr      SNDMSG
020300020304     C                   Move      'ERROR   '    WORTN
020400020304     C                   Move      'END'         WWSTT
020500020304X1   C                   Else
020600020304     C                   Move      'Y'           WWCHG
020700111212     **
020800020304E1   C                   Endif
020900020304     C                   Endsr
021000020304      *___________________________________________________________________
021100020304      * Default Data
021200020304      *___________________________________________________________________
021300020304     C     DFTDTA        Begsr
021400111212     C                   Call      'CHKEMP  '
021500020304     C                   Parm      'DFTDTA'      WWRQS
021600020304     C                   Parm                    WWRTN
021700020304     C                   Parm                    WUDTA
021800020304B1   C                   IF        WWRTN <> *BLANKS
021900020304     C                   Movel     WTM(7)        WWMSG
022000020304     C                   Exsr      SNDMSG
022100020304     C                   Move      'ERROR   '    WORTN
022200020304     C                   Move      'END'         WWSTT
022300020304E1   C                   Endif
022400020304     C                   Endsr
022500020304      *___________________________________________________________________
022600020304      * Process ERROR function
022700020304      *___________________________________________________________________
022800020304     C     PRCERR        Begsr
022900020304     C                   Move      WTM(1)        WWMSG
023000020304     C                   Exsr      SNDMSG
023100020304     C                   Move      'ERROR   '    WORTN
023200020304     C                   Move      'END'         WWSTT
023300020304     C                   Endsr
023400020304      *___________________________________________________________________
023500020304      * Receive messages
023600020304      *___________________________________________________________________
023700020304     C     RCVMSG        Begsr
023800020304B1   C                   IF        WWMSGC <> 'NORESET'
023900020304     C                   Movel     'RECEIVE'     WWRQS
024000020304X1   C                   Else
024100020304     C                   Movel     'DISPLAY'     WWRQS
024200020304E1   C                   Endif
024300020304     C                   Movel     'RESET   '    WWMSGC
024400020304     C                   Movea     *IN           WWIN
024500020304     C                   Call      'PRCMSG2'
024600020304     C                   Parm                    WWRQS
024700020304     C                   Parm                    WWIN
024800020304     C                   Parm                    WWRTN
024900020304     C                   Movea     WWIN          *IN
025000020304     C                   Endsr
025100020304      *___________________________________________________________________
025200020304      * Display panels
025300020304      *___________________________________________________________________
025400020304     C     DSPPNL        Begsr
025500020304      *
025600020304      * Set PUTOVR based on last display file processed
025700020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025800020304     C                   MOVE      *OFF          *IN35
025900020304     C                   Move      WQPGMN        WUPGM
026000020304     C                   Move      WWPNL         WWPNLO
026100020304X1   C                   Else
026200020304     C                   MOVE      *ON           *IN35
026300020304E1   C                   Endif
026400020304      *
026500020304      * Set PROTECT key based on request
026600020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026700020304     C                             WWTSK = 'COPY  '
026800100618 001 C                   Eval      *in40 = *off
026900020304X001 C                   Else
027000100618 001 C                   Eval      *in40 = *on
027100020304E001 C                   Endif
027200020304      *
027300020304      * Select title
027400020304     C                   IF        WWTSK = 'CHANGE'
027500100618 001 C                   Eval      *in38 = *off
027600020304X001 C                   Else
027700100618 001 C                   Eval      *in38 = *on
027800020304E001 C                   Endif
027900020304      *
028000020304      * Position cursor based on error status
028100020304     C                   IF        WWERR = 'Y'
028200100618 001 C                   Eval      *in99 = *on
028300020304X001 C                   Else
028400100618 001 C                   Eval      *in99 = *off
028500020304E001 C                   Endif
028600020304      *
028700020304      * Write message subfile
028800020304     C                   Seton                                        30
028900020304     C                   Write     MSGCTL
029000020304      *
029100020304      * Write entry panel
029200020304B001 C                   Select
029300020304     C                   WHEN      WWPNL = 1
029400111222     C                   EXSR      $GETDTA
029500020304 001 C                   Exfmt     ENTPNL
029600111222     C                   EXSR      $RTVDTA
029700020304 001 C                   Setoff                                       37
029800020304E001 C                   Endsl
029900020304      *
030000020304B001 C                   If        *IN39 = *ON
030100100618 001 C                   Eval      WWCHG = 'Y'
030200020304E001 C                   Endif
030300020304     C                   Endsr
030400111222   S***S
030500111222     C     $RTVDTA       BEGSR
030600111222      *
030700111222     C                   IF        SCSALEFFD > 0
030800111222     C     SCSALEFFD     MULT      10000.0001    EASALEFFD
030900111222     C                   ELSE
031000111222     C                   MOVE      *ZEROS        EASALEFFD
031100111222     C                   ENDIF
031200111222      *
031300111222     C                   IF        SCCOBEDT  > 0
031400111222     C     SCCOBEDT      MULT      10000.0001    EACOBEDT
031500111222     C                   ELSE
031600111222     C                   MOVE      *ZEROS        EACOBEDT
031700111222     C                   ENDIF
031800111222      *
031900111222     C                   IF        SCCOBTDT  > 0
032000111222     C     SCCOBTDT      MULT      10000.0001    EACOBTDT
032100111222     C                   ELSE
032200111222     C                   MOVE      *ZEROS        EACOBTDT
032300111222     C                   ENDIF
032400111222      *
032500111222     C                   IF        SCFTSEFFD > 0
032600111222     C     SCFTSEFFD     MULT      10000.0001    EAFTSEFFD
032700111222     C                   ELSE
032800111222     C                   MOVE      *ZEROS        EAFTSEFFD
032900111222     C                   ENDIF
033000111222      *
033100111222     C                   Endsr
033200111222   S***S
033300111222     C     $GETDTA       BEGSR
033400111222      *
033500111222     C                   EVAL      WSNAME = CONAME
033600111222      *
033700111222     C                   IF        EASALEFFD > 0
033800111222     C     EASALEFFD     MULT      10000.0001    SCSALEFFD
033900111222     C                   ELSE
034000111222     C                   MOVE      *ZEROS        SCSALEFFD
034100111222     C                   ENDIF
034200111222      *
034300111222     C                   IF        EACOBEDT  > 0
034400111222     C     EACOBEDT      MULT      10000.0001    SCCOBEDT
034500111222     C                   ELSE
034600111222     C                   MOVE      *ZEROS        SCCOBEDT
034700111222     C                   ENDIF
034800111222      *
034900111222     C                   IF        EACOBTDT  > 0
035000111222     C     EACOBTDT      MULT      10000.0001    SCCOBTDT
035100111222     C                   ELSE
035200111222     C                   MOVE      *ZEROS        SCCOBTDT
035300111222     C                   ENDIF
035400111222      *
035500111222     C                   IF        EAFTSEFFD > 0
035600111222     C     EAFTSEFFD     MULT      10000.0001    SCFTSEFFD
035700111222     C                   ELSE
035800111222     C                   MOVE      *ZEROS        SCFTSEFFD
035900111222     C                   ENDIF
036000111222      *
036100111222     C                   IF        EAADDT    > 0
036200111222     C     EAADDT        MULT      10000.0001    SCADDT
036300111222     C                   ELSE
036400111222     C                   MOVE      *ZEROS        SCADDT
036500111222     C                   ENDIF
036600111222      *
036700111222     C                   IF        EASSEQ = 0
036800111222     C     EASSNO        CHAIN     MEMBR
036900111222     C                   IF        %FOUND(MEMBER)
037000111222     C                   MOVEL(P)  MLNAME        @70              70
037100111222     C                   EVAL      @70 = %TRIM(@70) + ', ' + MFNAME
037200111222     C                   ELSE
037300111222     C                   EVAL      @70 = '**UNKNOWN**'
037400111222     C                   ENDIF
037500111222     C                   ELSE
037600111222     C     KL#DEP        CHAIN     DEPENR
037700111222     C                   IF        %FOUND(DEPNDC)
037800111222     C                   MOVEL(P)  DLNAME        @70              70
037900111222     C                   EVAL      @70 = %TRIM(@70) + ', ' + DFNAME
038000111222     C                   ELSE
038100111222     C                   EVAL      @70 = '**UNKNOWN**'
038200111222     C                   ENDIF
038300111222     C                   ENDIF
038400111222     C                   MOVEL(P)  @70           D_MBR
038500111222      *
038600111222     C     KL#DEP        KLIST
038700111222     C                   KFLD                    EASSNO
038800111222     C                   KFLD                    EASSEQ
038900111222     C     KL#ACM        KLIST
039000111222     C                   KFLD                    EATRST
039100111222     C                   KFLD                    EASUB#
039200111222     C                   KFLD                    EAACCT
039300111222     C     KL#ACM        CHAIN     ACCMSR
039400111222     C                   IF        %FOUND(ACMUNIQUE)
039500111222     C                   MOVEL(P)  ACNAM1        D_ACC
039600111222     C                   ELSE
039700111222     C                   EVAL      D_ACC = *BLANKS
039800111222     C                   ENDIF
039900111222      *
040000111222      *
040100111222     C                   ENDSR
040200111222   S***S
040300020304      *___________________________________________________________________
040400020304      * Process function key
040500020304      *___________________________________________________________________
040600020304     C     PRCFKY        Begsr
040700020304     C                   Movea     *IN           WWIN
040800020304     C                   Call      'PRCFKY2'
040900020304     C                   Parm      'PROCESS '    WWRQS
041000020304     C     WWFKA         Parm                    WWRTN
041100020304     C                   Parm                    WAD
041200020304     C                   Parm                    WWIN
041300020304     C                   Parm                    WAF
041400020304     C                   Parm                    WIFKV
041500020304     C                   Endsr
041600020304      *___________________________________________________________________
041700020304      * Process KEYS function
041800020304      *___________________________________________________________________
041900020304     C     PRCDKY        Begsr
042000020304     C                   Z-add     1             WW
042100020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
042200060317 001 C                   Add       1             WWFKS
042300020304 001  *
042400020304     C                   IF        WWFKS > 3
042500020304 002 C                   Z-add     1             WWFKS
042600020304E002 C                   Endif
042700020304 001  *
042800060317     C                   Eval      WW = WWFKS + WWFKS
042900020304 001 C                   Sub       1             WW
043000020304E001 C                   Enddo
043100020304      *
043200020304     C                   Movel     WAD(WW)       WSFKD1
043300020304     C                   Add       1             WW
043400020304     C                   Movel     WAD(WW)       WSFKD2
043500020304     C                   Endsr
043600020304      *___________________________________________________________________
043700020304      * Process EXIT Function
043800020304      *___________________________________________________________________
043900020304     C     PRCEXT        Begsr
044000020304      *
044100020304     C                   Exsr      PRCPNL
044200020304      *
044300020304     C                   IF        WWERR = 'Y'
044400020304 001 C                   Move      *BLANKS       WWSTT
044500020304X001 C                   Else
044600020304 001 C                   Movel     WWFKA         WORTN
044700020304 001 C                   Move      'END'         WWSTT
044800020304E001 C                   Endif
044900020304     C                   Endsr
045000020304      *___________________________________________________________________
045100020304      * Process PROMPT function
045200020304      *___________________________________________________________________
045300020304     C     PRCPMT        Begsr
045400020304     C                   Movel     WDCRSL        WWRQS
045500020304     C                   Move      'Y'           WWCHG
045600020304     C                   Move      'N'           WWWRNF
045700020304     C                   Movel     'NORESET '    WWMSGC
045800020304      *
045900020304B001 C                   Select
046000020304 001 C                   When      WSFLD = 'XXXXXX'
046100020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
046200040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
046300040305     C*                  Parm                    WWRTN                          RETURN CODE
046400040305     C*                  Parm                    WUPGM                          LAST PGM NAME
046500020304     C*                  Parm                    WDCARP                         RECORD DS
046600020304     C                   IF        WWRTN = *BLANKS
046700020304     C*                  Eval      MSCAID   =    CMCARR
046800020304     C*                  EVAL      WSCNAME  =    CMNAME
046900020304E001 C                   Endif
047000020304 001  *
047100020304 001 C                   Other
047200020304 001 C                   Move      WTM(6)        WWMSG
047300020304 001 C                   Exsr      SNDMSG
047400020304E001 C                   Endsl
047500020304      *
047600020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
047700020304     C                   Movel     WDCRSL        WWCRSL
047800020304     C     WWCRSN        Div       256           WSROW
047900020304     C                   Mvr                     WSLIN
048000020304     C                   Seton                                        37
048100020304      *
048200020304     C                   Endsr
048300020304      *___________________________________________________________________
048400020304      * Process CANCEL Function
048500020304      *___________________________________________________________________
048600020304     C     PRCCNL        Begsr
048700020304     C                   Movel     WWFKA         WORTN
048800020304     C                   Move      'END'         WWSTT
048900020304     C                   Move      'N'           WWCHG
049000020304     C                   Endsr
049100020304      *___________________________________________________________________
049200020304      * Process ROLLUP function
049300020304      *___________________________________________________________________
049400020304     C     PRCRUP        Begsr
049500020304     C     WWPNL         Add       1             WWPNL
049600020304     C                   IF        WWPNL > WWPNLN
049700020304 001 C     WWPNL         Sub       1             WWPNL
049800020304E001 C                   Endif
049900020304     C                   Movel     'NORESET '    WWMSGC
050000020304     C                   Endsr
050100020304      *___________________________________________________________________
050200020304      * Process ROLLDOWN function
050300020304      *___________________________________________________________________
050400020304     C     PRCRDN        Begsr
050500020304     C     WWPNL         Sub       1             WWPNL
050600020304     C                   IF        WWPNL < 1
050700020304 001 C     WWPNL         Add       1             WWPNL
050800020304E001 C                   Endif
050900020304     C                   Movel     'NORESET '    WWMSGC
051000020304     C                   Endsr
051100020304      *___________________________________________________________________
051200020304      * Process ENTER function
051300020304      *___________________________________________________________________
051400020304     C     PRCPNL        Begsr
051500020304     C                   Move      *BLANKS       WWRTN
051600020304     C                   Movea     *ZEROS        *IN(60)
051700020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
051800020304 001 C                   Move      'N'           WWWRNF
051900020304     C                   IF        WWTSK = 'CHANGE  '
052000111212 001 C                   Call      'CHKEMP  '
052100020304 001 C                   Parm      'EDTCHG  '    WWRQS
052200020304 001 C                   Parm                    WWRTN
052300020304 001 C                   Parm                    WUDTA
052400020304     C                   ELSE
052500111212 001 C                   Call      'CHKEMP  '
052600020304 001 C                   Parm      'EDTADD  '    WWRQS
052700020304 001 C                   Parm                    WWRTN
052800020304 001 C                   Parm                    WUDTA
052900020304E001 C                   Endif
053000020304E001 C                   Endif
053100020304      *
053200020304B001 C                   Select
053300020304     C                   WHEN      WWRTN = *BLANKS
053400020304 001 C                   Move      'N'           WWERR
053500020304 001  *
053600020304     C                   WHEN      WWRTN = 'WARNING'
053700020304     C                   IF        WWWRNF = 'Y'
053800020304 002 C                   Move      'N'           WWERR
053900020304X002 C                   Else
054000020304 002 C                   Move      'Y'           WWWRNF
054100020304 002 C                   Move      'Y'           WWERR
054200020304E002 C                   Endif
054300020304 001  *
054400020304     C                   WHEN      WWRTN = 'ERROR  '
054500020304 001 C                   Move      'Y'           WWERR
054600020304 001 C                   Move      *BLANKS       WWSTT
054700020304 001 C                   Move      'N'           WWWRNF
054800020304E001 C                   Endsl
054900020304      *
055000020304     C                   Endsr
055100020304      *___________________________________________________________________
055200020304      * Process end - write data or release record
055300020304      *___________________________________________________________________
055400020304     C     PRCEND        Begsr
055500020304      *
055600020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
055700020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
055800020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
055900020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
056000020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
056100020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
056200020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
056300020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
056400020304 001 C                   Endcs
056500020304 001  *
056600020304     C                   IF        WWRTN <> *BLANKS
056700020304 002 C                   Move      *BLANKS       WWSTT
056800020304 002  *
056900020304X002 C                   Else
057000020304     C                   IF        WWFKA <> 'EXIT'
057100020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
057200020304 004 C                   Exsr      PRPPNL
057300020304E004 C                   Endif
057400020304E003 C                   Endif
057500020304E002 C                   Endif
057600020304 001  *
057700020304X001 C                   Else
057800020304 001 C                   Exsr      RELREC
057900020304E001 C                   Endif
058000020304      *
058100020304     C                   Endsr
058200020304      *___________________________________________________________________
058300020304      * Add new record
058400020304      *___________________________________________________________________
058500020304     C     WRTADD        Begsr
058600020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
058700020304     C                             WWTSK = 'COPY  '
058800020304 001 C                   Movel     'ADD    '     WWRQS
058900020304E001 C                   Endif
059000020304      *
059100020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
059200020304     C                             WWTSK = 'CPYKEY'
059300020304 001 C                   Movel     'ADDKEY '     WWRQS
059400020304E001 C                   Endif
059500020304      *
059600111212     C                   Call      'UPDEMP  '
059700020304     C                   Parm                    WWRQS
059800020304     C                   Parm                    WWRTN
059900020304     C                   Parm                    WUDTA
060000020304      *
060100020304     C                   IF        WWRTN <> *BLANKS
060200020304 001 C                   Movel     WTM(3)        WWMSG
060300020304 001 C                   Exsr      SNDMSG
060400020304X001 C                   Else
060500020304E001 C                   Endif
060600020304      *
060700020304     C                   Endsr
060800020304      *___________________________________________________________________
060900020304      * Write changed record
061000020304      *___________________________________________________________________
061100020304     C     WRTCHG        Begsr
061200111212     C                   Call      'UPDEMP  '
061300020304     C                   Parm      'CHANGE'      WWRQS
061400020304     C                   Parm                    WWRTN
061500020304     C                   Parm                    WUDTA
061600020304     C                   IF        WWRTN <> *BLANKS
061700020304 001 C                   Movel     WTM(2)        WWMSG
061800020304 001 C                   Exsr      SNDMSG
061900020304E001 C                   Endif
062000020304      *
062100020304     C                   Endsr
062200020304      *___________________________________________________________________
062300020304      * Release record
062400020304      *___________________________________________________________________
062500020304     C     RELREC        Begsr
062600111212     C                   Call      'UPDEMP  '
062700020304     C                   Parm      'RELEASE '    WWRQS
062800020304     C                   Parm                    WWRTN
062900020304     C                   Parm                    WUDTA
063000020304     C                   IF        WWRTN <> *BLANKS
063100020304 001 C                   Movel     WTM(4)        WWMSG
063200020304 001 C                   Exsr      SNDMSG
063300020304E001 C                   Endif
063400020304     C                   Endsr
063500020304      *___________________________________________________________________
063600020304      * Build function keys
063700020304      *___________________________________________________________________
063800020304     C     BLDFKY        Begsr
063900020304     C                   Movea     *IN           WWIN
064000020304     C                   Call      'PRCFKY2'
064100020304     C                   Parm      'BUILD   '    WWRQS
064200020304     C     WWFKA         Parm                    WWRTN
064300020304     C                   Parm                    WAD
064400020304     C                   Parm                    WWIN
064500020304     C                   Parm                    WAF
064600020304     C                   Parm                    WIFKV
064700020304     C     WWFKS         Add       WWFKS         WW
064800020304     C                   Movel     WAD(WW)       WSFKD2
064900020304     C                   Sub       1             WW
065000020304     C                   Movel     WAD(WW)       WSFKD1
065100020304     C                   Endsr
065200020304      *___________________________________________________________________
065300020304      * Send message
065400020304      *___________________________________________________________________
065500020304     C     SNDMSG        Begsr
065600020304     C                   Call      'QSNDDTAQ'
065700020304     C                   Parm                    WWDTAQ
065800020304     C                   Parm                    WWLIB
065900020304     C                   Parm                    WWLNGQ
066000020304     C                   Parm                    WWMSG
066100020304     C                   Endsr
066200020304      *___________________________________________________________________
066300020304      * Paremater list
066400020304      *___________________________________________________________________
066500020304     C     PLIST         Begsr
066600020304     C     *ENTRY        Plist
066700020304     C     WWTSK         Parm                    WIRQS
066800020304     C                   Parm                    WORTN
066900020304     C                   Parm                    WUPGM
067000020304     C                   Parm                    WUDTA
067100020304     C                   Parm                    WIFKV
067200020304     C                   Endsr
067300020304      *___________________________________________________________________
067400020304      * Initialize routine
067500020304      *___________________________________________________________________
067600020304     C     *INZSR        Begsr
067700020304     C     *LIKE         Define    WUDTA         WWDTA
067800020304     C     *LIKE         Define    WIRQS         WWRQS
067900020304     C     *LIKE         Define    WIRQS         WWORQS
068000020304     C     *LIKE         Define    WIRQS         WWTSK
068100020304     C     *LIKE         Define    WORTN         WWRTN
068200020304     C     *LIKE         Define    WORTN         WWFKA
068300020304     C     *LIKE         Define    WIFKV         WWFKV
068400020304     C     *LIKE         Define    WIFKV         WWOPV
068500020304     C                   Movel     'RESET   '    WWMSGC
068600020304     C                   Movel     '*'           MSPGMQ
068700020304     C                   Movel     'MSGDTAQ'     WWDTAQ
068800020304     C                   Movel     'QTEMP'       WWLIB
068900020304     C                   Z-add     80            WWLNGQ
069000020304     C                   Move      *BLANKS       WWMSG
069100020304     C                   Move      *BLANKS       WWIN
069200020304     C                   Move      *BLANKS       WWSTT
069300020304     C                   Move      *ZEROS        WWZERO
069400020304     C                   Z-add     1             WWPNL
069500020304     C                   Z-add     1             WWPNLN
069600020304     C                   Z-add     1             WWFKS
069700020304     C                   Move      'N'           WWERR
069800020304     C                   Move      'N'           WWCHG
069900020304     C                   Move      'N'           WWWRNF
070000020304     C                   Z-add     0             WW
070100111212     C                   Movel(P)  'EMPAUX  '    WWFIL
070200020304     C                   Move      *BLANKS       WWFLK
070300020304     C                   Move      *BLANKS       WWTXT
070400020304     C                   Endsr
070500020304      *___________________________________________________________________
070600020304      * Program error handler
070700020304      *___________________________________________________________________
070800020304     C     *PSSR         Begsr
070900020304     C                   Call      'SNDRPGM'                            50
071000020304     C                   Parm                    WQPGMN
071100020304     C                   Parm                    WQSTSC
071200020304     C                   Parm                    WQRPGS
071300020304     C                   Parm                    WQMSG
071400020304     C                   Endsr     '*CANCL'
071500020304      *___________________________________________________________________
071600020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
07170002030403EXIT    F3=Exit
07180002030404PROMPT  F4=Prompt
07190002030405REFRESH F5=Refresh
07200002030410UPDATE  F10=Update
07210002030412CANCEL  F12=Cancel
07220002030425ROLLUP
07230002030426ROLLDOWN
072400020304** WTM
07250011121200Request not supported in program CHGEMP.
07260002030400Update error.  Data was not updated.
07270002030400Duplicate key detected.  Data was NOT added to file.
07280002030400Record not found.
07290002030400Record not available now.
07300002030400The cursor is not in a prompt area.
07310002030400Default error.  Data not defaulted.
