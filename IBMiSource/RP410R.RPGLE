0001009102150002 F******************************************************************
0002000004140003 F* RP410      GROUP BENEFIT SERVICES SOFTWARE           1991      *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009111080006 F*            DATE - 11/08/91                                     *
0006009102150007 F*                                                                *
0007009111080008 F*  DESCRIPTION - THIS PROGRAM PRODUCES A TRANSFERED MEMBERS      *
0008009111080009 F*                REPORT.                                         *
0009009102150011 F*                                                                *
0010009811190011 F*                                                                *
0011009811190010 F*  Y2K CONVERT - 1998                                            *
0012009811190012 F*                                                                *
0013000412100012 F* 12/09/04 dlk - fix errors from RPGLE conversion                *
0014009102150013 F******************************************************************
001500030612   X***X
0016000306120016 FRP410WF   IF   E           K DISK
0017000306120017 FACCMST    IF   E           K DISK
0018000306120018 FSMAN      IF   E           K DISK    PREFIX(Z)
0019000306130019 FREPORT    O    F  198        PRINTER OFLIND(*INOA)
0020000306130019 FREPORT2   O    F  132        PRINTER OFLIND(*INOB)
002100030612   X***X
0021010412100055 D                 DS
0021020412100056 D  BAL                    1    108  2
002103041210     D                                     DIM(12)
0021040412100056 D  BAL1                   1      9  2
0021050412100056 D  BAL2                  10     18  2
0021060412100056 D  BAL3                  19     27  2
0021070412100056 D  BAL4                  28     36  2
0021080412100056 D  BAL5                  37     45  2
0021090412100056 D  BAL6                  46     54  2
0021100412100056 D  BAL7                  55     63  2
0021110412100056 D  BAL8                  64     72  2
0021120412100056 D  BAL9                  73     81  2
0021130412100056 D  BAL10                 82     90  2
0021140412100056 D  BAL11                 91     99  2
0021150412100056 D  BAL12                100    108  2
0022009102150053 D                UDS
002300041209     D  LTRST                  1      3a
002400041209     D  LSUB                   4      6A
002500041209     D  LACC                   7     10A
002600041209     D  FRMDT                 11     18S 0
002700041209     D  TODT                  19     26S 0
0028000306120054 D  CONAME               201    240A
0029000306120055 D  TIME                 242    247S 0
003000030612    ***
003100030613     D A@20            S             20A
003200030613     D A@40            S             40A
003300030612     D BADACC          S             10S 0
003400030612     D FRBAL           S             11P 2
003500030612     D TOBAL           S             11P 2
003600030612     D FRSMAN          S              3A
003700030612     D TOSMAN          S              3A
003800030612     D FRTYPE          S              3A
003900030612     D TOTYPE          S              3A
004000030612    ***
0041000306120053 D                 DS
004200030612     D KEY@TRS                 1      3S 0
004300030612     D KEY@SUB                 4      6S 0
004400030612     D KEY@ACC                 7     10S 0
004500030612     D #10                     1     10S 0
004600030612     D @10                     1     10A
004700030613    ***
004800030613     D FRSM40          S             40A
004900030613     D TOSM40          S             40A
005000030613     D #ISO            S               D   DATFMT(*ISO)
005100030613     D #USA            S               D   DATFMT(*USA)
005200030613     D #XSX            S              8S 0
005300030612    ***
005400041210     D** DS@ACM        E DS                  EXTNAME(ACCMST)
005600030613    ***
005700030613     D TRDMDY          S              8S 0
005800030613     D COVMDY          S              8S 0
005900030613     D TOTMEM          S              7S 0
006000030613     D TOTAC           S              5S 0
006100030613     D BREAK@FRACC     S                   LIKE(FRACC)
006200030612   X***X
006300030612     C                   DOU       %EOF(RP410WF)
006400030612     C                   READ      HISTR
006500030612     C                   IF        NOT %EOF(RP410WF)
006600030613    ***
006700911223     C* 2 TRANSFER RECORDS ARE WRITTEN FOR EACH TRANSFER, ONLY
006800911223     C* PRINT ONE
006900911223     C*
007000030613     C                   IF        BREAK@FRACC <> FRACC
007100030613     C                   EVAL      BREAK@FRACC = FRACC
007200030613     C                   ITER
007300030613     C                   ENDIF
007400030612    ***
007500030612     C                   EXSR      $FRACC
007600030613    ***
007700030613     C                   EXSR      $TOACC
007800030613    ***
007900030613     C                   Z-ADD     TRDATE        #XSX
008000030613     C                   EXSR      $ISOUSA
008100030613     C                   Z-ADD     #XSX          TRDMDY
008200030613    ***
008300030613     C                   Z-ADD     COVTDT        #XSX
008400030613     C                   EXSR      $ISOUSA
008500030613     C                   Z-ADD     #XSX          COVMDY
008600030613    ***
008700030613     C                   ADD       MEMTRN        TOTMEM
008800030613     C                   ADD       1             TOTAC
008900030613    * *
009000030613     C                   IF        *INOA = *ON
0091000306130233 C                   EXCEPT    HDGF
009200030613     C                   ENDIF
0093009111110233 C                   EXCEPT    LINE
009400030613    ***
009500030613     C                   ELSE
009600030613    * *
009700030613     C                   IF        *INOA = *ON
0098000306130233 C                   EXCEPT    HDGF
009900030613     C                   ENDIF
010100030613    ***
010200030613     C                   ENDIF
010300030613     C                   ENDDO
010301041210
010302041210     C                   EXCEPT    SUMF
010400030613    ***
010500030613     C                   MOVE      *ON           *INLR
010600030612   S***S
010700030612     C     *INZSR        BEGSR
010800030612    ***
010900030612     C     KEY#ACM       KLIST
011000030612     C                   KFLD                    KEY@TRS
011100030612     C                   KFLD                    KEY@SUB
011200030612     C                   KFLD                    KEY@ACC
011201041209
011203041209     C                   MOVE      frmdt         @DATIN
011204041209     C                   EXSR      #DATYM
011205041209     C                   MOVE      @DATOU        frmmdy            8 0
011206041209
011207041209     C                   MOVE      todt          @DATIN
011208041209     C                   EXSR      #DATYM
011209041209     C                   MOVE      @DATOU        tomdy             8 0
011300030613    ***
0114000306130233 C                   EXCEPT    HDGF
011500030612    ***
011600030612     C                   ENDSR
0116010412090103 C***************************************************
0116020412090104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0116030412090105 C***************************************************
0116040412090107 C*
0116050412090107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0116060412090107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0116070412090107 C*
0116080412090106 C     #DATYM        BEGSR
011609041209     C                   MOVE      @DATIN        @MD               4 0
011610041209     C                   MOVEL     @DATIN        @Y                4 0
011611041209     C                   MOVEL     @MD           @DATOU            8 0
011612041209     C                   MOVE      @Y            @DATOU
011613041209     C                   MOVE      *ZEROS        @DATIN            8 0
0116140412090120 C                   ENDSR
0116150412090107 C*
011700030612   S***S
011800030613     C     $ISOUSA       BEGSR
011900030612    ***
012000030613     C                   IF        #XSX = 0
012100030613     C                   LEAVESR
012200030613     C                   ENDIF
012300030613    ***
012400030613     C                   MOVE      #XSX          #ISO
012500030613     C                   MOVE      #ISO          #USA
012600030613     C                   MOVE      #USA          #XSX
012700030613    ***
012800030613     C                   ENDSR
012900030613   S***S
013000030613    *** FROM ACCOUNT INFORMATION RETRIEVAL
013100030613    ***
013200030613     C     $FRACC        BEGSR
013300030613    ***
013400030613     C                   MOVE      FRACC         @10
013500041210     C**                 CLEAR                   DS@ACM
013600030612     C                   MOVE      *BLANKS       FRTYPE
013700030612    ***
0138000306120065 C     KEY#ACM       CHAIN     ACCMSR
013900030612    ***
014000030612     C                   IF        NOT %FOUND(ACCMST)
014100030612    * *
014200030612     C  N01              EXCEPT    ERRHED
014300030612     C  N01              SETON                                        01
014400030612    * *
014500030612     C                   MOVE      FRACC         BADACC
014600030613     C                   IF        *INOB = *ON
0147000306130233 C                   EXCEPT    ERRHED
014800030613     C                   ENDIF
014900030612     C                   EXCEPT    ERR1
015000030612     C                   LEAVESR
015100030612    * *
015200030612     C                   ENDIF
015300030612    ***
015400030612     C                   XFOOT     BAL           FRBAL
015500030612     C                   MOVE      SMANCD        FRSMAN
015600030612    ***
015700030612     C     SMANCD        CHAIN     SMANR
015800030612    ***
015900030612     C                   IF        NOT %FOUND(SMAN)
016000030612    * *
016100030612     C  N01              EXCEPT    ERRHED
016200030612     C  N01              SETON                                        01
016300030612    * *
016400030612     C                   Z-ADD     FRACC         BADACC
016500030613     C                   IF        *INOB = *ON
0166000306130233 C                   EXCEPT    ERRHED
016700030613     C                   ENDIF
016800030612     C                   EXCEPT    ERR2
016900030612     C                   LEAVESR
017000030613    * *
017100030613     C                   ELSE
017200030613    * *
017300030613     C                   EXSR      $GETSNAME
017400030613     C                   MOVEL(P)  A@40          FRSM40
017500030612    * *
017600030612     C                   ENDIF
017700030612    ***
017800030612     C                   MOVE      ZSTYPE        FRTYPE
017900030612    ***
018000030612     C                   ENDSR
018100030612   S***S
018200030613     C     $GETSNAME     BEGSR
018300030613    ***
018400030613     C                   CLEAR                   A@20
018500030613     C                   CLEAR                   A@40
018600030613    ***
018700030616     C                   IF        zSFNAME <> *BLANKS
018800030616     C                   MOVEL     zSFNAME       A@20
018900030613     C                   EXSR      $LDADDR
019000030613     C                   ENDIF
019100030613    ***
019200030616     C                   IF        zSMI <> *BLANKS
019300030616     C                   MOVEL     zSMI          A@20
019400030613     C                   EXSR      $LDADDR
019500030613     C                   ENDIF
019600030613    ***
019700030616     C                   IF        zSLNAME <> *BLANKS
019800030616     C                   MOVEL     zSLNAME       A@20
019900030613     C                   EXSR      $LDADDR
020000030613     C                   ENDIF
020100030613    ***
020200030613     C                   ENDSR
020300030613   S***S
020400030613     C     $LDADDR       BEGSR
020500030613    ***
020600030613     C                   EVAL      A@20 = %TRIM(A@20)
020700030613     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
020800030613     C                   CLEAR                   A@20
020900030613    ***
021000030613     C                   ENDSR
021100030613   S***S
021200030612     C     $TOACC        BEGSR
021300030612    ***
021400030613     C                   MOVE      TOACC         @10
021500041210     C**                 CLEAR                   DS@ACM
021600030613     C                   MOVE      *BLANKS       FRTYPE
021700030613    ***
0218000306130065 C     KEY#ACM       CHAIN     ACCMSR
021900030613    ***
022000030613     C                   IF        NOT %FOUND(ACCMST)
022100030613    * *
022200030613     C  N01              EXCEPT    ERRHED
022300030613     C  N01              SETON                                        01
022400030613    * *
022500030613     C                   MOVE      TOACC         BADACC
022600030613     C                   IF        *INOB = *ON
0227000306130233 C                   EXCEPT    ERRHED
022800030613     C                   ENDIF
022900030613     C                   EXCEPT    ERR1
023000030613     C                   LEAVESR
023100030613    * *
023200030613     C                   ENDIF
023300030613    ***
023400030613     C                   XFOOT     BAL           TOBAL
023500030613     C                   MOVE      SMANCD        TOSMAN
023600030613    ***
023700030613     C     SMANCD        CHAIN     SMANR
023800030613    ***
023900030613     C                   IF        NOT %FOUND(SMAN)
024000030613    * *
024100030613     C  N01              EXCEPT    ERRHED
024200030613     C  N01              SETON                                        01
024300030613    * *
024400030613     C                   Z-ADD     TOACC         BADACC
024500030613     C                   IF        *INOB = *ON
0246000306130233 C                   EXCEPT    ERRHED
024700030613     C                   ENDIF
024800030613     C                   EXCEPT    ERR2
024900030613     C                   LEAVESR
025000030613    * *
025100030613     C                   ELSE
025200030613    * *
025300030613     C                   EXSR      $GETSNAME
025400030613     C                   MOVEL(P)  A@40          TOSM40
025500030613    * *
025600030613     C                   ENDIF
025700030613    ***
025800030613     C                   MOVE      ZSTYPE        TOTYPE
025900030612    ***
026000030612     C                   ENDSR
026100030612   S***S
0262000306130237 OREPORT    E            HDGF           1  1
0263000306130125 O                                           77 '***'
0264000306130126 O                       CONAME             117
0265000306130127 O                                          120 '***'
0266000306130237 OREPORT    E            HDGF           1
0267000306130244 O                                          107 'ACCOUNT TRANSFER REPORT'
0268000306130237 OREPORT    E            HDGF           1
026900041209     O                       FRMmdy              94 '  /  /    '
027000030613     O                                           96 '-'
027100041209     O                       TOmdy              107 '  /  /    '
0272000306130237 OREPORT    E            HDGF           1
0273000306130248 O                                           19 'PROGRAM NAME: RP410'
027400030613     O                                           93 'ACCOUNT'
027500030613     O                       LTRST               97
027600030613     O                                           98 '/'
027700030613     O                       LSUB               101
027800030613     O                                          102 '/'
027900030613     O                       LACC               106
0280000306130138 O                                          188 'PAGE:'
0281000306130139 O                       PAGE          Z    197
0282000306130237 OREPORT    E            HDGF           1
0283000306130253 O                                            9 'RUN DATE:'
0284000306130254 O                       UDATE         Y     18
0285000306130144 O                                          188 'TIME:'
0286000306130145 O                       TIME               197 '  :  :  '
0287000306130237 OREPORT    E            HDGF           1
0288000306130259 O                                           24 '""""""""""""""""""""""""'
0289000306130260 O                                           48 '""""""""""""""""""""""""'
0290000306130261 O                                           72 '""""""""""""""""""""""""'
0291000306130262 O                                           96 '""""""""""""""""""""""""'
0292000306130263 O                                          120 '""""""""""""""""""""""""'
0293000306130153 O                                          144 '""""""""""""""""""""""""'
0294000306130154 O                                          168 '""""""""""""""""""""""""'
0295000306130155 O                                          192 '""""""""""""""""""""""""'
0296000306130156 O                                          198 '""""""'
0297000306130237 OREPORT    E            HDGF           1
0298000306130269 O                                           53 '# OF'
0299000306130269 O                                           61 'FROM'
030000030613     O                                           74 'F R O M'
0301000306130269 O                                          113 'TO'
030200030613     O                                          125 'T O'
0303000306130269 O                                          160 'TRANSFER'
030400030613     O                                          174 'EFFECTIVE'
0305000306130237 OREPORT    E            HDGF           1
0306000306130268 O                                            5 'NAME'
0307000306130272 O                                           53 'MEMBERS'
0308000306130273 O                                           63 'ACCOUNT'
0309000306130269 O                                           70 'SMAN'
0310000306130274 O                                           76 'TYPE'
0311000306130269 O                                           93 'BALANCE'
0312000306130273 O                                          116 'ACCOUNT'
0313000306130269 O                                          124 'SMAN'
0314000306130274 O                                          130 'TYPE'
0315000306130269 O                                          146 'BALANCE'
0316000306130275 O                                          156 'DATE'
0317000306130275 O                                          171 'DATE'
0318000306130237 OREPORT    E            HDGF           1
0319000306130281 O                                           24 '""""""""""""""""""""""""'
0320000306130282 O                                           48 '""""""""""""""""""""""""'
0321000306130283 O                                           72 '""""""""""""""""""""""""'
0322000306130284 O                                           96 '""""""""""""""""""""""""'
0323000306130285 O                                          120 '""""""""""""""""""""""""'
0324000306130153 O                                          144 '""""""""""""""""""""""""'
0325000306130154 O                                          168 '""""""""""""""""""""""""'
0326000306130155 O                                          192 '""""""""""""""""""""""""'
0327000306130156 O                                          198 '""""""'
0328000306130237 OREPORT    E            LINE           1
0329000306130289 O                       ACNAM1         B    41
0330000412100290 O                       MEMTRN        NB    52
0331000306130291 O                       FRACC          B    65 '0   -   -    '
033200030613     O                       FRSMAN         B    70
033300030613     O                       FRTYPE         B    76
033400030613     O                       FRBAL         AB    95
0335000306130291 O                       TOACC          B   118 '0   -   -    '
0336000306130292 O                       TOSMAN         B   124
0337000306130293 O                       TOTYPE         B   130
033800030613     O                       TOBAL         AB   148
0339000306130293 O                       TRDMDY             161 '  /  /    '
034000030613     O                       COVMDY             174 '  /  /    '
0341000306130237 OREPORT    E            LINE           1
034200030613     O                       FRSM40             107
034300030613     O                       TOSM40             161
0344000306130237 OREPORT    E            SUMF           2
0345000306130289 O                                           17 'TOTAL MEMBERS  :'
0346000306130290 O                       TOTMEM        1     28
0347000306130237 OREPORT    E            SUMF           1
0348000306130289 O                                           17 'TOTAL ACCOUNTS :'
0349000306130290 O                       TOTAC         1     25
0350000306130237 OREPORT2   E            ERRHED         1  1
035100911111     O                                           19 'PROGRAM NAME: RP410'
035200911111     O                                           73 'ACCOUNT TRANSFER ERROR'
035300911111     O                                           80 'REPORT'
0354000306130237 OREPORT2   E            ERR1           1
035500911111     O                                           17 'INVALID ACCOUNT -'
035600911112     O                       BADACC              28
0357000306130237 OREPORT2   E            ERR2           1
035800911111     O                                           23 'INVALID SALESMAN CODE -'
035900911111     O                       SMANCD              27
036000911111     O                                           39 'ACCOUNT -'
036100911112     O                       BADACC              51
