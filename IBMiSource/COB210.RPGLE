0001009808240002 F*---------------------------------------------------------------**
0002009909300003 F* COB210     GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009808240005 F*            WRITTEN BY - MARY L FONTI                           *
0004009808240006 F*            DATE - 08/98                                        *
0005009808240007 F*                                                                *
0006009808240006 F*  DESCRIPTION - THIS PROGRAM WILL LIST COBRA DEPENDENT          *
0007009808240007 F*                CANCELLATIONS BASED UPON SELECTED DATE          *
000800980824     F*                RANGE.
0009009907270007 F*                                                                *
0010009907270007 F* 07/27/99 DLK - REWRITE TO FIX PROBLEMS AND CONVERT TO ILE      *
0011000408310007 F* 08/31/04 DLK - add fed / state flag                            *
0012000412020007 F* 12/02/04 DLK - add cobra service                               *
0013001110110007 F* 10/11/11 DLK - exclude billing only accts                      *
0014001201120007 F* 01/12/12 DLK - remove edit that skips active dependents,       *
0015001201120007 F*                add exclusion of plan change hist records       *
0016001201120007 F*                and add new fields                              *
0017001202030007 F* 02/03/12 DLK - only show cobra extendable plans                *
0018001202160007 F* 02/16/12 DLK - change to process every record and only print   *
0019001202160007 F*                at L1 total time if there was a plan eligible   *
0020001202160007 F*                to be printed.                                  *
0021001302260007 F* 02/26/13 DLK - add acct state column                           *
0022001401170007 F* 01/17/14 DLK - change to use dep# field in hist instead of     *
0023001401170007 F*                taking it from the note field
0023012002040011  * 02/04/20 DLK - Identify EBS members
0024009808240009 F*---------------------------------------------------------------**
002500980824     FHISTAK    IP   E           K DISK
002600980824     FDEPNDC    IF   E           K DISK
002700980824     FMEMBER    IF   E           K DISK
002800980824     FACCMST    IF   E           K DISK
002900130226     Fac2mst    IF   E           K DISK
003000120112     Fdcovc     IF   E           K DISK
003100120203     Fplnmst    IF   E           K DISK
003200120203     Fcodesl1   IF   E           K DISK
003300130226     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
0034001302260037 D comparestate    S                   like(astate)
0035001302260037 D stateout        S                   like(astate)
003501200204     D ebsacct         S              1
003502200204     D parmebsyn       S              1
003503200204     D parmebstsa      S             10
003600990727 053 D                 DS
003700120203     D  ck#not                 1     30
003800120203     D  Hplan                  1      4
0039009907270053 D                UDS
004000980826     D  BEGDAT                11     18  0
004100980826     D  ENDDAT                19     26  0
004200980826     D  SDATE                 36     43  0
004300980826     D  EDATE                 44     51  0
0044009808240054 D  CONAME               201    240
0045001302260056 D  lprefix              241    241
004600980825     I*---------------------------------------------------------------
0047009808250035 IHISTR
0048009808250039 I                                          HKEY          L1
0049001401170040 I                                          hdseq#        L1
005000120216      * clear selection flag on new dependent
005100990727     C                   IF        *inl1
005200120216     c                   clear                   oktoprint         1
005300130226     c                   clear                   stateout
005400120216     C                   END
005500120216
005600120216      * process each record to decide if this dependent should be printed
005700120203     C                   Z-ADD     0             HSSN              9 0
005800120203     C                   MOVE      HKEY          HSSN
005900990727     C*
006000120216     C     HISKEY        CHAIN     ACCMST
006100120216     C                   IF        not %found(accmst)
006200990727     C                   GOTO      #END
006300990727     C                   END
006400980824     C*
006500111011     C* PROCESS COBRA accounts only and exclude billing only service
006600111011     C                   IF        fcstfl = 'N' or acobsrv = 'B'
006700990727     C                   GOTO      #END
006800990727     C                   END
006900120203
007000120203      * only include cobra extendable plans
0071001202030153 C                   clear                   medflg            1
0072001202030171 C     PLNKEY        CHAIN     PLNMST
007300120203     c                   if        %found(plnmst)
007400120203     c     plncat        chain     codesl1
0075001202030175
007600120203      * only include medical, dental, vision, rx and fsa
007700120203     c                   if        %found(codesl1) and
007800120203     c                             (action = 'M' or action = 'D' or
007900120203     c                             action = 'V' or action = 'R' or
008000120203     c                             action = 'F')
008100120203     c                   eval      medflg = 'Y'
008200120203     c                   move      action        actionH           1
0083001202030184 c                   end
0084001202030184 c                   end
008500120203
008600120203     c                   if        medflg <> 'Y'
008700120203     C                   GOTO      #END
008800120203     c                   end
008900120203
009000120203      * find active dcov
009100120203     c                   exsr      #getnum
009200120203
009300120216      * if the same plan category type is still active or the plan was
009400120216      * never effective then skip this plan
009500120216     c                   if        samecatact = 'Y' or plnneveff = 'Y'
009600120203     C                   GOTO      #END
009700120203     c                   end
009800980824     C*
009900980824     C* GET DEPENDENT SSN, LAST(*IFNE SAME) AND FIRST NAME.
010000980824     C*
010100120216     C     DKEY          CHAIN     DEPNDC
010200120216     C                   IF        not %found(depndc)
010300990727     C                   GOTO      #END
010400990727     C                   END
010500980826     C*
010600980826     C* IF DEPENDENT DELETED THEN REINSTATED DO NOT PRINT.
010700120203     C* 1/12/12 - remove this edit, moved to the plan cat level
010800120112     C**                 IF        dpdltd = 'A'
010900120112     C**                 GOTO      #END
011000120112     C**                 END
011100980826     C*
011200980824     C                   MOVEL     DLNAME        LNAME
011300980824     C*
011400980824     C* GET LAST NAME FROM MEMBER FILE IF DEPENDENT FILE = *SAME
011500980824     C*
011600120216     C     HSSN          CHAIN     MEMBER
011700120216     C                   IF        not %found(member)
011800990727     C                   GOTO      #END
011900990727     C                   END
012000980826     C*
012100120112     C* PRINT DEPENDENT ONLY IF MEMBER is still active
012200990727     C                   IF        termdt <> 0
012300990727     C                   GOTO      #END
012400980826     C                   END
012500980825     C*
012600120216     C                   clear                   LNAME            15
012700120216     C                   clear                   FNAME            10
012800980825     C     DLNAME        IFEQ      'SAME'
012900980825     C                   MOVEL     MLNAME        LNAME
013000980825     C                   ELSE
013100980825     C                   MOVEL     DLNAME        LNAME
013200980825     C                   END
013300980825     C*
013400980825     C                   MOVEL     DFNAME        FNAME
013500980826     C*
013600990727     C                   MOVEL(P)  FNAME         FLD1             27
013700990727     C     DMI           IFNE      *BLANKS
013800990727     C     FNAME         CAT       DMI:1         FLD1
013900990727     C                   CAT       '.':0         FLD1
014000990727     C                   ENDIF
014100990727     C                   CAT       LNAME:1       FLD1
014200990727     C                   MOVEL     FLD1          FN               28
014300990727     C*
014400990727     C                   MOVE      TRDATE        TMD               4 0
014500990727     C                   MOVEL     TRDATE        TYY               4 0
014600990727     C                   MOVE      TYY           TRD               8 0
014700990727     C                   MOVEL     TMD           TRD
014800120216
014900120216      * if we made it to this point then the dependent is valid to print
015000120216     C                   eval      oktoprint = 'Y'
015100130226
0152001302260090  * IF STATE ACCOUNT AND ACCT IS OUTSIDE MD - print state on report
015300130226      * use the physical address if one exists, otherwise use the mailing
015400130226      * address.
015500130226
0156001302260092 C                   if        fcstfl = 'S' and stateout = *blanks
0157001302260234 C     ac2key        CHAIN     ac2mst
015800130226     c                   if        %found(ac2mst) and a2state <> *blanks
015900130226     c                   move      a2state       comparestate
016000130226     c                   else
016100130226     c                   move      astate        comparestate
016200130226     c                   end
016300130226
0164001302260092 C                   if        comparestate <> 'MD'
0165001302260095 C                   MOVE      comparestate  stateout
016600130226     C                   ADD       1             stateerr          6 0
0167001302260100 C                   end
0168001302260100 C                   END
0169001302260101 C*
017000130226
017100120216
017200990727     C     #END          TAG
017300120216
017400120216      * print on report at end of transactions for this dependent if
017500120216      * at least one transaction was valid for printing
017600120216     CL1                 if        oktoprint = 'Y'
017700120216     CL1                 exsr      #l1tot
017800120216     cL1                 end
017900120216
018000120216     CLR OF              EXCEPT    HEAD
018100990727     CLR   COUNT         IFEQ      0
018200980824     CLR                 EXCEPT    MSG
018300990727     CLR                 ELSE
018400990727     CLR                 EXCEPT    LRCNT
018500990727     CLR                 END
018600120216
018700120216      *********************************
018800120216      * print this dependent on the report
018900120216      *********************************
019000120216     C     #l1tot        BEGSR
019100120216     C                   ADD       1             COUNT             6 0
019101200204     c                   exsr      #chkebs
019200120216     C   OF              EXCEPT    HEAD
019300120216     C                   EXCEPT    DETL
019400120216     c                   endsr
019500120203
019600120203      *********************************
019700120216      * get number of active dcov and check for this plan being same day
019800120216      * termed
019900120203      *********************************
020000120112     C     #getnum       BEGSR
020100120112
020200120112     c                   clear                   numact            4 0
020300120203     c                   clear                   samecatact        1
020400120216     c                   clear                   plnneveff         1
020500120203
020600120112     C     dkey          SETLL     dcovc
020700120112     c                   dou       %eof(dcovc)
020800120112     C     dkey          reade     dcovc
020900120216     c                   if        not %eof(dcovc)
021000120216
021100120216      * was plan never effective?
021200120216     c                   if        dvplan = hplan and denrdt = ccandt
021300120216     c                   eval      plnneveff = 'Y'
021400120216     c                   end
021500120216
021600120216     c                   if        ccandt = 0
021700120112     c                   add       1             numact
021800120203      * check for same plan category type still active
0219001202030171 C     dcovtsp       CHAIN     PLNMST
022000120203     c                   if        %found(plnmst)
022100120203     c     plncat        chain     codesl1
022200120203     c                   if        %found(codesl1) and
022300120203     c                             (action = actionH)
022400120203     c                   eval      samecatact = 'Y'
0225001202030184 c                   end
0226001202030184 c                   end
0227001202160184 c                   end
022800120216
022900120112     c                   end
023000120112     C                   enddo
023100120112
023200120112     C                   endsr
0232012002040103  ***************************************************
0232032002040104  * call getebs to see if this acct is an EBS acct
0232042002040105  ***************************************************
0232052002040106   begsr #chkebs;
023209200204
023210200204       clear ebsacct;
023211200204       parmebstsa = %editc(hstrst:'X') + %editc(hssub#:'X') +
023212200204                    %editc(hsacct:'X');
023215200204       clear parmebsyn;
023216200204
023217200204     c                   call      'GETEBSCL'
023218200204     c                   parm                    parmebstsa
023219200204     c                   parm                    parmebsyn
023220200204       if parmebsyn = 'Y';
023221200204        ebsacct = 'Y';
023222200204       endif;
023226200204
0232272002040106   endsr;
023228200204
023300120112
023400120112     C     *INZSR        BEGSR
023500990727     C     DKEY          KLIST
023600990727     C                   KFLD                    HSSN
023700140117     C                   KFLD                    hdseq#
023800990727     C     HISKEY        KLIST
023900990727     C                   KFLD                    HSTRST
024000990727     C                   KFLD                    HSSUB#
024100990727     C                   KFLD                    HSACCT
024200120203
024300120203     C     plnkey        KLIST
024400120203     C                   KFLD                    HSTRST
024500120203     C                   KFLD                    HSSUB#
024600120203     C                   KFLD                    Hplan
024700120203
024800120203     C     dcovtsp       KLIST
024900120203     C                   KFLD                    DVTRST
025000120203     C                   KFLD                    DVSUB#
025100120203     C                   KFLD                    DVPLAN
025200990727     C*
025300130226     C     ac2key        KLIST
025400130226     C                   KFLD                    lprefix
025500130226     C                   KFLD                    HSTRST
025600130226     C                   KFLD                    HSSUB#
025700130226     C                   KFLD                    HSACCT
025701200204
025702200204     C                   TIME                    HTIME             6 0
025800130226
025900990727     C                   EXCEPT    HEAD
026000990727     C                   ENDSR
0261001302260237 OQSYSPRT   E            HEAD           1  3
0262001201120248 O                                           16 'PGM     : COB210'
0263001201120240 O                       CONAME              86
0264002002040249 O                                          121 'PAGE :'
0265001201120250 O                       PAGE          Z    131
0266001302260237 O          E            HEAD           2
0267009808240253 O                                            9 'RUN DATE:'
0268001201120254 O                       *DATE         Y     20
0269001201120244 O                                           84 'COBRA DEPENDENT CANCELLATI-
027000120112     O                                              ON LISTING'
0270012002040120 O                                          121 'TIME :'
0270022002040121 O                       HTIME              131 '  :  :  '
0271001302260237 O          E            HEAD           1
027200120112     O                                           52 'FROM :'
0273001201120245 O                       SDATE               63 '  /  /    '
027400120112     O                                           73 'TO :'
0275001201120245 O                       EDATE               84 '  /  /    '
0276001302260237 O          E            HEAD           1
0277009808240259 O                                           24 '""""""""""""""""""""""""'
0278009808240260 O                                           48 '""""""""""""""""""""""""'
0279009808240261 O                                           72 '""""""""""""""""""""""""'
0280001201120284 O                                           96 '""""""""""""""""""""""""'
0281001201120284 O                                          120 '""""""""""""""""""""""""'
0282001201120284 O                                          132 '""""""""""""'
0283001302260237 O          E            HEAD           1
028400130226     O                                           26 'ACCT'
028500041202     O                                           21 'COBRA'
028600040831     O                                           15 'F'
028700130226     O                                           54 'DEPENDENT'
028800130226     O                                           97 'TRAN DATE'
028900130226     O                                          107 '# ACTIVE'
029000130226     O                                          115 'DEP'
029001200204     O                                          119 'EBS'
0291001302260237 O          E            HEAD           1
029200130226     O                                           27 'STATE'
029300041202     O                                           21 'SERV'
029400980825     O                                           10 'ACCOUNT #'
029500040831     O                                           15 'S'
029600130226     O                                           38 'MEMBER SSN'
029700130226     O                                           43 'SQ'
029800130226     O                                           48 'SSN'
029900130226     O                                           72 'DEPENDENT NAME'
030000130226     O                                           97 'OF TERM'
030100130226     O                                          107 'COV NOW'
030200130226     O                                          115 'STATUS'
0303001302260237 O          E            HEAD           2
0304009808240281 O                                           24 '""""""""""""""""""""""""'
0305009808240282 O                                           48 '""""""""""""""""""""""""'
0306009808240283 O                                           72 '""""""""""""""""""""""""'
0307001201120284 O                                           96 '""""""""""""""""""""""""'
0308001201120284 O                                          120 '""""""""""""""""""""""""'
0309001201120284 O                                          132 '""""""""""""'
0310001302260265 O          E            DETL           1
031100990727     O                       HSTRST         B     3
031200980824     O                                            4 '-'
031300990727     O                       HSSUB#         B     7
031400980824     O                                            8 '-'
031500130226     O                       STATEOUT            25
031600990727     O                       HSACCT         B    12
031700040831     O                       FCSTFL              15
031800041202     O                       ACOBSRV             20
031900130226     O                       HSSN                39 '0   -  -    '
032000140117     O                       hdseq#              43
032100130226     O                       DEPSS#              56 '0   -  -    '
032200130226     O                       FN                  86
032300130226     O                       TRD            B    97 '0 /  /    '
032400130226     O                       NUMACT        3    105
032500130226     O                       DPDLTD             113
032501200204     O                       EBSACCT            118
0326001302260265 O          E            LRCNT       2
032700120112     O                                           13 'TOTAL COUNT :'
032800130226     O                       COUNT         3     20
032900130226     O                                           +3 'STATE ACCTS NOT IN MD:'
033000130226     O                       STATEERR      3     +1
0331001302261265 O          E            MSG         2
033200040831     O                                           56 'NO DEPENDENTS CANCELLED'
