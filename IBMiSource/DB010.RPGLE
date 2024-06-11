000100170526    *H OPTION(*NODEBUGIO) DFTACTGRP(*NO) ACTGRP(*CALLER)
000200170526    *H BNDDIR('GBSBDIR') ALWNULL(*USRCTL)
000300170526     Hbnddir('ALLSRVPGMN')
0004009102150002 F******************************************************************  DB0101
0005000004140003 F* DB010      GROUP BENEFIT SERVICES SOFTWARE           1989      *  DB0101
0006001705260004 F*                                                                *  DB0121
0007001705260004 F*  NOTES:  This program must be COMPILED with this on            *  DB0121
0008001705260004 F*          the libray list.                                      *  DB0121
0009001705260004 F*                                                                *  DB0121
0010001705260004 F*          Production:  RPGSPDASH                                *  DB0121
0011001705260004 F*                                                                *  DB0121
0012001705260004 F*          Test:        RPGSPBETA                                *  DB0121
0013001705260004 F*                                                                *  DB0121
0014001705260004 F*                                                                *  DB0121
0015009102150004 F*                                                                *  DB0101
0016009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *  DB0101
0017009102150006 F*            DATE - 10/89                                        *  DB0101
0018009102150007 F*                                                                *  DB0101
0019009102150008 F*  DESCRIPTION - THIS PROGRAM WILL CHECK FOR ANY UNMATCHED       *  DB0101
0020009102150009 F*                RECORDS. POSSIBLE ERRORS:1) ACTIVE MEMBER/      *  DB0101
0021009102150010 F*                NO ACTIVE COVERAGE, 2) CANCELLED MEMBER/        *  DB0101
0022009102150011 F*                COVERAGE STILL ACTIVE, 3) ACTIVE COVERAGE/      *  DB010
0023009102150012 F*                NO MEMBER IN FILE.                              *  DB010
0024009102150013 F*                                                                *  DB010
0025001110100010 F*  Y2K CONVERT - 1998                                            *
002600980120     F*  DMA 01.20.98  Added Account Administrator name to report
002700010221     F*  SSK 02.21.01  RPGIV CONVERSION
002800020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
002900111010     F* 10/10/11 dlk - change to sort by aacode - request from Lisha Iacovelli
003000120207     F* 02/07/12 dlk - rewrite and convert to csv output                    li
003100130510     F* 05/10/13 dlk - add cobra indicator                                  li
003200130529     F* 05/29/13 SSK - FUTURE TERM MESSAGE ADDED PER LISHA                  li
003300131015     F* 10/15/13 SSK - QUANTIFY MESSAGE TO NON-SENIOR DENTAL ACCOUNTS
003400170203     F* 02/03/17 dlk - add "date added" column per request from Deb C.      li
003500170526     F* 05/12/17 J.Allen ignore declined plans
003501170526      * 05/26/17 dlk - Shelly request this report stop considering future
003502170526      *                cancel dates as still active
0036009808200015 F*                                                                *
0037009102150014 F******************************************************************  DB0101
003800111010     Fdb010j    ip   e           k DISK
0039001202070017 FMEMBER    If   e           k DISK
004000120207     FAACODE    IF   e           k DISK
004100170526     FWEBTRANL1 IF   E           K DISK
004200170203     Fhistaa    IF   e           k DISK
0043001202070018 F*EPORT    O    F  132        PRINTER OFLIND(*INOF)
0044001202070017 Fdb010xl   o  a e             DISK
004500170526
00460017052600    * Payroll Prototypes
004700170526      /copy *libl/qmodsrc,#chkdeclpr
004800170526      /copy *libl/qmodsrc,#chkdectpr
004900170526
005000170526     D outdc           S              1A
005100170526     D incat           S              3A
005200170526
0053001202070125 Dcsv              c                   const('","')
0054001305290019 D MSG             S             34    DIM(4) CTDATA PERRCD(1)              ERROR MESSAGES
0055001702030019 D madddtout       S             10                                         ERROR MESSAGES
0056001702030019 D mcadddtout      S             10                                         ERROR MESSAGES
0057009412200030 D                 DS
0058001202070031 D  tsa                    1     10  0
0059001202070031 D  t                      1      3  0
0060001202070031 D  s                      4      6  0
0061001202070031 D  a                      7     10  0
0062009412200030 D                UDS
0063009412200031 D  CONAME               201    240
0064009102150032 D  TIME                 242    247  0
006500980820Y2K  D  UD8YMD               248    255  0                                      COMPNY
0066001110100030 Idb010r
006700120207     I              aacode                      acaacode
006800111010     I                                          mcssno        l1
006900170203
007000170203     c                   clear                   madddtout
007100170203     c                   clear                   mcadddtout
007200120207     c                   if        *inl1
007300120207     c                   clear                   activecov         1
007400120207     c                   end
0075001202070040 C*                                                                     0101
0076001202070041 C* CHECK FOR ACTIVE COVERAGE -                                         010
0077001202070042 C*                                                                     010
0078001202070043 C                   if        candt = 0
0079001202070044 C                   eval      activecov = 'Y'                                             DB010
007901170526
007902170526      * 5/26/17 - Shelly request this report stop considering future
007903170526      *           cancel dates as still active
0080001705260045 C**                 ELSE
008100170526     c**                 if        enrldt <> candt and candt > ud8ymd
0082001705260044 C**                 eval      activecov = 'Y'                                             DB010
0083001705260051 C**                 END                                                                   DB010
0084009302250051 C                   END                                                                   DB010
0085001202070052
008600111010     cl1                 exsr      #l1tot
008700120207     clr                 exsr      #lr
008800111010
008900111010     c     #l1tot        begsr
0090001202070059 C                   MOVE      mctrst        T                                             DB010
0091001202070059 C                   MOVE      mcsub#        s                                             DB010
0092001202070059 C                   MOVE      acc#          A                                             DB010
009300120207
009400120207      * get aa name
009500120207     c                   clear                   aanamout         30
009600120207     C     AAKEY         CHAIN     AACODE
009700120207     c                   if        %found(aacode)
009800120207     C     AFNAM         CAT       ALNAM:1       aanamout
009900120207     c                   end
0100009102150056 C*                                                                   DB010
0101009102150057 C* IF NO MEMBER IS FOUND WRITE ERROR LINE                            DB010
0102009102150058 C*                                                                   DB010
010300130510     c                   clear                   cobraout          3
0104001202070053 C     mcssno        CHAIN     MEMBER                                                      DB010
010500120207     c                   if        not %found(member)
0106001110100059 C                   MOVE      3             N                 1 0                         DB010
0107001202070061 C*                  EXCEPT    DETAIL                                                      DB010
010800120207     C                   exsr      writexldet
0109001110110061 C                   add       1             toterr            7 0                         DB010
0110001202070062 C                   leavesr                                                               DB010
011100111010     c                   end
0112001305100063
011300130510     c                   if        cexpdt <> 0
011400130510     c                   eval      cobraout = 'YES'
011500130510     c                   end
011600130510
0117009102150064 C*                                                                   DB010
0118009102150065 C* IF COVERAGE IS ACTIVE AND MEMBER IS NOT, WRITE ERROR LINE         DB010
0119009102150066 C*                                                                   DB010
0120001705260044 C                   if        activecov = 'Y' and termdt <> 0                             DB010
012001170526
012002170526      * 5/26/17 - Shelly request this report stop considering future
012003170526      *           cancel dates as still active
0121001705260067 C**                           and termdt <= ud8ymd
012101170526
0122001110100070 C                   MOVE      2             N                                             DB010
0123001202070072 C*                  EXCEPT    DETAIL                                                      DB010
012400120207     C                   exsr      writexldet
0125001202070061 C                   add       1             toterr                                        DB010
0126001202070074 C                   END                                                                   DB010
0127009102150075 C/SPACE
0128009102150076 C*                                                                   DB010
0129009102150077 C* IF COVERAGE IS NOT ACTIVE AND MEMBER IS ACTIVE WRITE ERROR LINE
0130009102150078 C*                                                                   DB010
0131001202070044 C                   if        activecov <> 'Y'                                            DB010
013200170203
0133001202070044 C                   if        termdt = 0                                                  DB010
0134001110100080 C                   MOVE      1             N                                             DB010
0135001202070082 C*                  EXCEPT    DETAIL                                                      DB010
013600120207     C                   exsr      writexldet
0137001202070061 C                   add       1             toterr                                        DB010
013701170530      * 5/26/17 - Shelly request this report stop reporting future
013702170530      *           cancel date coverages
0138001705300083 C**                 ELSE                                                                  DB010
013900170530     C**                 if        termdt <> mbenrl
013904170526     C**                           and termdt > ud8ymd
014000170530     C**                 IF        MBTRST > 24 AND MBTRST < 76
0141001705300086 C**                 MOVE      1             N                               SENIOR DENTAL ACCT
014200170530     C**                 ELSE
0143001705300086 C**                 MOVE      4             N                               REGULAR ACCT
014400170530     C**                 ENDIF
0145001202070088 C*                  EXCEPT    DETAIL                                                      DB010
014600170530     C**                 exsr      writexldet
0147001705300061 C**                 add       1             toterr                                        DB010
0148001705300089 C**                 END
014801170530
0149001705300090 C                   END
0151001202070090 C                   END
015200120207
015300111010     c                   endsr
015400170203
015500170203      *******************************
015600170203      * find date added
015700170203      *******************************
015800170203     c     #fndadddt     begsr
015900170203     c                   clear                   madddtout
016000170203     c                   clear                   mcadddtout
016100170203     c                   clear                   keyssn           10
016200170203
016300170203      * find member add date
016400170203     c                   move      'MMA'         keytrcode         3
016500170203     c                   move      mcssno        keyssn
016600170203     c     histaakey     chain     histaa
016700170203     c                   if        %found(histaa)
016800170203     C                   MOVE      trdate        @DATIN
016900170203     C                   EXSR      #DATYM
017000170203     C                   MOVE      @DATOU        trdmdy            8 0
017100170203     c                   eval      madddtout = %editw(trdmdy:'  /  /    ')
017200170203     c                   end
017300170203
017400170203      * find coverage add date
017500170203     c                   if        mcplan <> *blanks
017600170203     c                   move      'MAC'         keytrcode
017700170203     c     histaakey     setll     histaa
017800170203     c                   dou       %eof(histaa)
017900170203     c     histaakey     reade     histaa
018000170203     c                   if        not %eof(histaa)
018100170203     c                   if        hprgnm = 'DBCONVERT2' and
018200170203     c                             %subst(note2:1:4) = mcplan or
018300170203     c                             hprgnm <> 'DBCONVERT2' and
018400170203     c                             %subst(ck#not:1:4) = mcplan
018500170203     C                   MOVE      trdate        @DATIN
018600170203     C                   EXSR      #DATYM
018700170203     C                   MOVE      @DATOU        trdmdy            8 0
018800170203     c                   eval      mcadddtout = %editw(trdmdy:'  /  /    ')
018900170203     c                   leave
019000170203     c                   end
019100170203     c                   end
019200170203     c                   enddo
019300170203     c                   end
019400170203
019500170203     c                   endsr
019600120207
0197001702030103 C***************************************************
0198001702030104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0199001702030105 C***************************************************
0200001702030107 C*
0201001702030107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0202001702030107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0203001702030107 C*
0204001702030106 C     #DATYM        BEGSR
020500170203     C                   MOVE      @DATIN        @MD               4 0
020600170203     C                   MOVEL     @DATIN        @Y                4 0
020700170203     C                   MOVEL     @MD           @DATOU            8 0
020800170203     C                   MOVE      @Y            @DATOU
020900170203     C                   MOVE      *ZEROS        @DATIN            8 0
0210001702030120 C                   ENDSR
021100170203
021200170203
021300120207      * final total
021400120207     c     #lr           begsr
021500120207     c                   if        toterr = 0
021600120207     c*                  except    noerr
021700120207     c                   else
021800120207     c*                  except    errcnt
021900120207     c                   end
022000120207     c                   endsr
022100120207
0222001202070164 C*************************************************************
0223001202070164 C*                                                           *
0224001202070164 C* Write Spreadsheet Detail                                  *
0225001202070164 C*                                                           *
0226001202070164 C*************************************************************
022700120207     C     Writexldet    BEGSR
022800120207
022900170203     C                   exsr      #fndadddt
023000170203
023100170526     C                   exsr      chkdecline
023200170526     C                   if        outdc = *blanks
023300170526
023400120207     c                   clear                   db010fld
023500120207     C                   Eval      db010fld  = '"' +
023600120207     C                             %trim(%editw(mcssno:'0   -  -    ')) + csv +
023700130510     C                             %trim(cobraout)                      + csv +
023800120207     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
023900120207     C                             %trim(msg(n))                        + csv +
024000170203     C                             %trim(madddtout)                     + csv +
024100170203     C                             %trim(mcadddtout)                    + csv +
024200170203     C                             %trim(acaacode)                      + csv +
024300120207     C                             %trim(aanamout)                      + csv +
024400120207     C                             ' '                                  + '",'
024500120207     C*
024600120207     C                   Write     db010xr
024700170526     C                   end
0248001202070320 C                   ENDSR
024900170526      *---------------------------------------------------------*
025000170526     C     chkdecline    Begsr
025100170526      *---------------------------------------------------------*
025200170526     C                   eval      outdc = *blanks
025300170526
025400170526     C     webkey        setll     WEBTRANL1
025500170526     C     webkey        reade     WEBTRANL1
025600170526     C                   dow       not %eof(WEBTRANL1)
025700170526
025800170526      * save trn# of declines for later cleanup
025900170526     C                   If        %subst(OEGRPV:1:8) = 'ADD_COVG' and
026000170526     C                             %subst(OEFLDV:1:4) = 'PCAT'
026100170526
026200170526     C                   eval      incat = %trim(oeafter)
026300170526     C                   eval      outdc = #chkdecl(oetrst:oesub#:oeacct:
026400170526     C                                              oessno:incat)
026500170526     C                   If        outdc = 'Y'
026600170526     C                   LeaveSR
026700170526     C                   else
026800170526     C                   eval      outdc = #chkdect(oetrn#)
026900170526     C                   If        outdc = 'Y'
027000170526     C                   LeaveSR
027100170526     C                   end
027200170526     C                   end
027300170526
027400170526     C                   end
027500170526
027600170526     C     webkey        reade     WEBTRANL1
027700170526     C                   enddo
027800170526
027900170526     C     webkey        klist
028000170526     C                   kfld                    mbtrst
028100170526     C                   kfld                    mbsub#
028200170526     C                   kfld                    mbacct
028300170526     C                   kfld                    mbssno
028400170526
028500170526     C                   Endsr
028600120207     C*
028700120207     C/EJECT
028800120207     C*************************************************************
028900120207     C*                                                           *
029000120207     C* Write Spreadsheet heading                                 *
029100120207     C*                                                           *
029200120207     C*************************************************************
029300120207     C     Writexlhead   BEGSR
029400120207
029500120207     c                   clear                   db010fld
029600120207     C                   Eval      db010fld = '"' + 'SS #'              + csv +
029700130510     C                                              'COBRA'             + csv +
029800130510     C                                              'ACCOUNT'           + csv +
029900120207     C                                              'ERROR'             + csv +
030000170203     C                                              'MEMBER ADDED'      + csv +
030100170203     C                                              'COVERAGE ADDED'    + csv +
030200120207     C                                              'AA CODE'           + csv +
030300120207     C                                              'AA NAME'           + csv +
030400120207     C                                              ' '                 + '",'
030500120207     C                   Write     db010xr
030600120207     C*
0307001202070320 C                   ENDSR
030800120207
030900120207     C     *INZSR        BEGSR
0310001202070210 C                   MOVE      *ZEROS        ZERO2
031100120207     C     aakey         KLIST
031200120207     C                   KFLD                    acaacode
031300120207     C                   KFLD                    ZERO2             2 0
031400120207
031500170203     C     histaakey     KLIST
031600170203     C                   KFLD                    keyssn
031700170203     C                   KFLD                    keytrcode
031800170203
031900120207     C                   Exsr      Writexlhead
032000120207     C                   endsr
032100120207
0322001202070093 O*EPORT    H    1P                  2     3
032300120207     O*        OR    OF
0324001202070095 O*                                          86 '**'
0325001202070096 O*                      CONAME              84
0326001202070097 O*                                          44 '**'
0327001202070093 O*EPORT    H    1P                  2
032800120207     O*        OR    OF
0329001202070100 O*                      UDATE         Y     14
0330001202070101 O*                                          69 'MCOV/MEMBER AUDIT'
0331001202070102 O*                                          77 'LISTING'
0332001202070103 O*                                         120 'PAGE :'
0333001202070104 O*                      PAGE          Z    126
0334001202070093 O*EPORT    H    1P                  1
033500120207     O*        OR    OF
0336001202070107 O*                                          17 'PROG: DB010'
0337001202070108 O*                                         120 'TIME :'
0338001202070109 O*                      TIME               130 '  :  :  '
0339001202070093 O*EPORT    H    1P                  1
034000120207     O*        OR    OF
0341001202070112 O*                                          24 '------------------------'
0342001202070113 O*                                          48 '------------------------'
0343001202070114 O*                                          72 '------------------------'
0344001202070115 O*                                          96 '------------------------'
0345001202070116 O*                                         120 '------------------------'
0346001202070117 O*                                         132 '------------'
0347001202070093 O*EPORT    H    1P                  1
034800120207     O*        OR    OF
0349001202070120 O*                                           8 'SS #'
0350001202070121 O*                                          25 'ACCOUNT'
0351001202070122 O*                                          48 'ERROR'
035200120207     O*                                          82 'AA NAME'
0353001202070093 O*EPORT    H    1P                  1  1
035400120207     O*        OR    OF
0355001202070125 O*                                          24 '------------------------'
0356001202070126 O*                                          48 '------------------------'
0357001202070127 O*                                          72 '------------------------'
0358001202070128 O*                                          96 '------------------------'
0359001202070129 O*                                         120 '------------------------'
0360001202070130 O*                                         132 '------------'
0361001202070131 O*EPORT    E            DETAIL         1
0362001202070132 O*                      mcssno              11 '   -  -    '
0363001202070133 O*                      tsa                 28 '   -   -    '
0364001202070134 O*                      MSG(N)              67                             000034
036500120207     O*                      acaacode            78
036600120207     O*                                          80 '-'
036700120207     O*                      aanamout           102
0368001202070135 O*EPORT    e            noerr          2
0369001202070136 O*                                          17 'ALL RECORDS MATCH'
0370001202070135 O*         e            errcnt      1  1
0371001202070136 O*                                          13 'TOTAL ERRORS:'
037200120207     O*                      toterr        1     +2
03730013052912345**890123456789012345678901234
037400910215**  ERROR MESSAGE ARRAY
037500170203ACTIVE MEMBER, NO ACTIVE COVERAGE
037600910215NON-ACTIVE MEMBER, ACTIVE COVERAGE
037700910215COVERAGE WITHOUT MEMBER RECORD
037800130529ACT MBR W/FUTURE TERM, INACT COVG
