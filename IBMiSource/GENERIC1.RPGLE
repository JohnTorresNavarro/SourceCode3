000100050322     ** CLONED IN PIECES FROM ENRCONV BY THE "K" MAN
000200050322     **
000300050322     ** ANOTHER FUN FILLED SSK PROGRAM
000400050322     **
000500050322     **
0006000503220007 H* Convert enrollment from GBS to Luminx.                         *
0007000503220008 H* This program will read gbs enrollment files and create the     *
0008000503220008 H* import file for luminx in the "Format C" record layout.        *
000900050322     H*
001000050322     H* FOR BENEGAP, WE WILL EXPORT ONLY ONE COVERAGE, ONE PLAN.
001100050322     H*
001200050322     FMCOV14    iF   E           K DISK
001300050322     Fmember    iF   E           K DISK
001400050329     Fdepndc    iF   E           K DISK
001500050322     Fdcovc     iF   E           K DISK
001600050822     F*CCBSP    UF   E           K DISK
001700050322     FBG0012WA  UF A E           K DISK
001800050322     FBG0012WB  UF A E           K DISK
001900050322     Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
002000050322     Fqprint    O    F  132        PRINTER OFLIND(*INOg)
002100050322   X***X
002200050322     D @55             S             55A
002300050322     D                 DS
002400050322     D P@IN                    1     55A
002500050322     D  KEY@TRS                1      3S 0
002600050322     D  KEY@SUB                4      6S 0
002700050322     D  KEY@ACC                7     10S 0
002800050322     D  KEY@PLN               11     14A
002900050322     D  KEY@LGR               15     34A
003000050322     D  KEY@LPL               35     54A
003100050322     D #ISO            S               D   DATFMT(*ISO)
003200050329     D YES             S               N   INZ(*ON)
003300050329     D NO              S               N   INZ(*OFF)
003400050329     D DEP_FOUND       S               N
003500050322     D #TDAY           S              8S 0
003600050323     D K@PARTIC        S             20A
003700050329     D CANDAY          S              2S 0
003800050329     **
003900050329     D #MSG            S             30A   DIM(11) CTDATA PERRCD(1)
004000050322     ** coverage type xref
004100050329     D TABA            S              3A   DIM(12) CTDATA PERRCD(1)
004200050329     D TABB            S              3A   DIM(12) ALT(TABA)
004300050322     **
0044000503290037 D wkcexpdt        S               D   datfmt(*iso)
0045000503290037 D wkqedt          S               d   datfmt(*iso)
004600050329     d errcnt          s              5S 0
004700050329     d warcnt          s              5S 0
0048000503290037 D wkcan           S               d   datfmt(*iso)
0049000503290037 D wkcan2          S              8S 0
0050000503290037 D wkenr           S               d   datfmt(*iso)
0051000503290037 D wkenr2          S              8S 0
005200050322     **
0053000503290055 D                 DS
0054000503290056 D  zip                    1      9  0
0055000503290056 D  zip5                   1      5  0
0056000503290056 D  zip4                   6      9  0
005700050329   X***X
005800050322     **
005900050323     C                   EXSR      $UPD_BSP
006000050322    ***
006100050322     C     KEY#MCV       SETLL     MCOVR
006200050322     C                   DOU       %EOF(MCOV14)
006300050322     C     KEY#MCV       READE     MCOVR
006400050428     C                   IF        NOT %EOF(MCOV14) AND
006500050428     C                             ENRLDT <> CANDT
006600050322    * *
006700050323     C                   EXSR      $PROC_MCV
006800050323    * *
006900050323     C                   ENDIF
007000050323     C                   ENDDO
007100050323    ***
007200050323     C                   EVAL      *INLR = *ON
007300050323   S***S
007400050323     C     *INZSR        BEGSR
007500050323    ***
007600050323     C     *ENTRY        PLIST
007700050323     C                   PARM                    @55
007800050323     C                   MOVE      *DATE         #ISO
007900050323     C                   MOVE      #ISO          #TDAY
008000050323    ***
008100050323     C                   EVAL      P@IN = @55
008200050323    ***
008300050323     C     KEY#BSP       KLIST
008400050323     C                   KFLD                    KEY@TRS
008500050323     C                   KFLD                    KEY@SUB
008600050323     C                   KFLD                    KEY@ACC
008700050323    ***
008800050323     C     KEY#MCV       KLIST
008900050323     C                   KFLD                    KEY@TRS
009000050323     C                   KFLD                    KEY@SUB
009100050323     C                   KFLD                    KEY@ACC
009200050323     C                   KFLD                    KEY@PLN
009300050329    ***
009400050329     C     DEPKEY        KLIST
009500050329     C                   KFLD                    SSNO
009600050329     C                   KFLD                    DSEQ#
009700050323    ***
009800050329     C     K#DC          KLIST
009900050329     C                   KFLD                    MCSSNO
010000050329     C                   KFLD                    DPSEQ#
010100050329     C                   KFLD                    MCTRST
010200050329     C                   KFLD                    MCSUB#
010300050329     C                   KFLD                    MCPLAN
010400050329    ***
010500050323     C                   ENDSR
010600050323   S***S
010700050323     C     $UPD_BSP      BEGSR
010800050323    ***
010900050822     C*    KEY#BSP       CHAIN     ACCBSPR
011000050323    ***
011100050822     C*                  IF        %FOUND(ACCBSP)
011200050822     C*                  EVAL      ABLMXGRP = KEY@LGR
011300050822     C*                  EVAL      ABGBSPLN = KEY@PLN
011400050822     C*                  EVAL      ABLMXPLN = KEY@LPL
011500050822     C*                  UPDATE    ACCBSPR
011600050822     C*                  ENDIF
011700050323    ***
011800050323     C                   ENDSR
011900050323   S***S
012000050323     C     $PROC_MCV     BEGSR
012100050323    ***
012200050329     C                   IF        CANDT <= #TDAY AND CANDT <> 0
012300050323     C                   LEAVESR
012400050323     C                   ENDIF
012500050323    ***
012600050323     C                   EVAL      K@PARTIC = %EDITC(MCSSNO:'X')
012700050323     C     K@PARTIC      CHAIN(N)  LUMENRC1R
012800050323     C                   IF        %FOUND(BG0012WA)
012900050323     C                   LEAVESR
013000050323     C                   ENDIF
013100050323    ***
013200050323     C     MCSSNO        CHAIN     MEMBR
013300050323     C                   IF        NOT %FOUND(MEMBER)
013400050323     C                   LEAVESR
013500050323     C                   ENDIF
013600050323    ***
013700050323     C                   EXSR      $CONT_PROC
013800050329    ***
013900050329     C                   EXSR      $CHK_4_DEP
014000050323    ***
014100050323     C                   ENDSR
014200050323   S***S
014300050323     C     $CONT_PROC    BEGSR
014400050323    ***
014500050323     C                   CLEAR                   LUMENRC1R
014600050323    ***
014700050323     c                   EVAL      E3GROUP = %TRIM(KEY@LGR)
014800050323     c                   move      '1'           e3rectyp
014900050323     c                   movel     mbssno        e3partic
015000050323     c                   move      '00'          e3depno
015100050323     c                   move      empdt         e3hiredt
015200050428     C                   EVAL      E3DIV = 'A001'
015300050323    ***
015400050323     c                   move      mbenrl        e3initdt
015500050323     c                   movel     mlname        e3last
015600050323     c                   movel     mfname        e3first
015700050323     c                   move      mmi           e3mi
015800050323    ***
015900050323     c                   movel     addr1         e3addr
016000050323     c                   movel     addr2         e3addr2
016100050323     c                   movel     city          e3city
016200050323     c                   movel     state         e3stat
016300050323    ***
016400050329    1c                   if        zip4 <> 0
016500050323     c                   move      zip           e3zip
016600050329    1c                   else
016700050323     c                   movel     zip5          e3zip
016800050329    1c                   end
016900050323    ***
017000050323     c                   movel     area          phonewk          10
017100050323     c                   move      phone         phonewk
017200050323     c                   movel     phonewk       e3phone
017300050323    ***
017400050323     c                   move      sex           e3sex
017500050323     c                   move      birth         e3dob
017600050323     c                   move      mbssno        e3ssn
017700050323    ***
017800050329    1c                   if        mardt <> 0
017900050323     c                   move      'M'           e3marsta
018000050329    1c                   else
018100050323     c                   move      'S'           e3marsta
018200050329    1c                   end
018300050323    ***
018400050329    1c                   if        qedt  <> 0
018500050323     c                   move      qedt          e3qedate
018600050329    1c                   end
018700050323    ***
018800050329    1c                   if        cvthdt  <> 0
018900050323     c                   move      cvthdt        e3pdthru
019000050329    1c                   end
019100050323    ***
019200050329    1c                   if        medadt  <> 0
019300050323     c                   move      medadt        e3medicr
019400050329    1c                   end
019500050323    ***
019600050329    1c                   if        cexpdt <> 0 and termdt = 0
019700050323    * *
019800050323     c                   move      e3div         e3qediv
019900050323     c                   move      qedt          wkqedt
020000050323     c                   move      cexpdt        wkcexpdt
020100050323     c     wkcexpdt      subdur    wkqedt        months:*m         4 0
020200050323    * *
020300050329    2c                   select
020400050329    2c                   when      months = 18
020500050323     c                   move      '1'           e3qecode
020600050329    2c                   when      months = 36
020700050323     c                   move      '6'           e3qecode
020800050329    2c                   other
020900050323     c                   move      '1'           e3qecode
021000050323     c                   z-add     5             x
021100050323     c                   add       1             warcnt
021200050323     c                   movel     months        msgdta
021300050323     C   of              EXCEPT    #HEAD
021400050323     c                   except    #prt
021500050323     c                   except    #prt2
021600050323     c                   clear                   msgdta
021700050329    2c                   endsl
021800050323    * *
021900050329    1c                   end
022000050323    ***
022100050329    1c                   if        termdt  <> 0
022200050323     c                   move      termdt        e3emptrm
022300050329    1c                   end
022400050323    ***
022500050329    1c                   if        empst = 'R'
022600050323     c                   move      'Y'           e3retire
022700050329    1c                   end
022800050323    ***
022900050323     c                   z-add     salary        salarywk         10 2
023000050323     c                   eval      e3sal = %editc(salarywk : '3')
023100050323    ***
023200050323     c     mcovtp        lookup    taba          tabb                     66
023300050329    1C                   if        *in66
023400050323     C                   MOVEL     TABB          e3enr1
023500050329    1c                   else
023600050323     c                   z-add     2             x
023700050323     c                   add       1             errcnt
023800050323     c                   movel     mcovtp        msgdta           10
023900050323     C   of              EXCEPT    #HEAD
024000050323     c                   except    #prt
024100050323     c                   except    #prt2
024200050323     c                   clear                   msgdta
024300050329     c                   LEAVESR
024400050329    1c                   end
024500050323      * special code for E1 & 2P coverage type. Deafult to F00 but change
024600050323      * to P01 if an active child is found on the plan.
024700050323
024800050329    1c                   if        mcovtp = 'TE1' or mcovtp = 'T2P'
024900050323     c                   move      mcplan        plan_h            4
025000050323     c                   move      candt         candt_h           8 0
025100050323     c                   move      enrldt        enrldt_h          8 0
025200050329     c                   exsr      $e12P
025300050329    1c                   end
025400050323
025500050323
025600050329     c                   EVAL      e3plan1 = KEY@LPL
025700050822     C                   IF        KEY@PLN = '3594' OR KEY@PLN = '3595' OR
025800050822     C                             KEY@PLN = '3593'
025900050822     c                   EVAL      e3cov1 = 'DEN'
026000050822     C                   ELSE
026100050822     c                   EVAL      e3cov1 = 'MED'
026200050822     C                   ENDIF
026300050329      *
026400050329     c                   eval      e3vol1  = '      .00'
026500050323     c                   eval      e3vol2  = '      .00'
026600050323     c                   eval      e3vol3  = '      .00'
026700050323     c                   eval      e3vol4  = '      .00'
026800050323     c                   eval      e3vol5  = '      .00'
026900050323     c                   eval      e3vol6  = '      .00'
027000050323     c                   eval      e3vol7  = '      .00'
027100050323     c                   eval      e3vol8  = '      .00'
027200050323     c                   eval      e3vol9  = '      .00'
027300050323     c                   eval      e3vol10 = '      .00'
027400050323     c                   eval      e3vol11 = '      .00'
027500050323     c                   eval      e3vol12 = '      .00'
027600050323     c                   eval      e3vol13 = '      .00'
027700050323     c                   eval      e3vol14 = '      .00'
027800050323     c                   eval      e3vol15 = '      .00'
027900050323     c                   eval      e3vol16 = '      .00'
028000050329      *
028100050323      * effdt & candt
028200050323      * for cobra members : add 1 day to MCOV enroll date if day <> 01
028300050323      * subtract 1 day from cancel date if day = 01
028400050323
028500050323     c                   movel     enrldt        e3effdt
028600050323     c                   move      enrldt        enrdd             2 0
028700050329    1c                   if        cexpdt <> 0 and enrdd <> 01
028800050323     c                   move      enrldt        wkenr
028900050323     c                   adddur    1:*d          wkenr
029000050323     c                   move      wkenr         wkenr2
029100050323     c                   movel     wkenr2        e3effdt
029200050329    1c                   end
029300050329    1c                   if        candt <> 0
029400050323     c                   move      candt         wkcan
029500050329     c                   exsr      $candt
029600050323     c                   movel     wkcan2        e3end
029700050323      * if subtracting 1 day made effective date >= cancel date then skip
029800050329    2c                   if        e3effdt >= e3end
029900050329     c                   LEAVESR
030000050329    2c                   end
030100050329    1c                   else
030200050323     c                   clear                   e3end
030300050329    1c                   end
030400050323
030500050323      * was this a domestice partner coverage ? (TDE, TDF)
030600050329    1c                   if        mcovtp = 'TDE' or mcovtp = 'TDF' or
030700050323     c                             mcovtp = 'TDP'
030800050329     c                   MOVE      'Y'           dompart           1
030900050329    1c                   end
031000050323
031100050323     c                   add       1             mcovcnt           3 0
031200050329    ***
031300050329    *** write subscriber record to subscriber file
031400050329     C                   EVAL      E3X = '*'
031500050323     c                   write     lumenrc1r
031600050329    ***
031700050329    *** if any coverages were created, print msg that member was converted
031800050329    ***
031900050329    1c                   if        mcovcnt <> 0
032000050329     c*                  add       mcovcnt       totmcov
032100050329     c*                  add       1             totmem
032200050323     c                   z-add     1             x                 2 0
032300050323     C   of              EXCEPT    #HEAD
032400050323     c                   except    #prt
032500050329    1c                   end
032600050323    ***
032700050323     C                   ENDSR
032800050323   S***S
032900050329     C     $CHK_4_DEP    BEGSR
033000050329    ***
033100050329     C     MCSSNO        CHAIN     DEPENR
033200050329     C                   IF        NOT %FOUND(DEPNDC)
033300050329     C                   LEAVESR
033400050329     C                   ENDIF
033500050329    ***
033600050329     C     MCSSNO        SETLL     DEPENR
033700050329     C                   DOU       %EOF(DEPNDC)
033800050329     C     MCSSNO        READE     DEPENR
033900050329     C                   IF        NOT %EOF(DEPNDC)
034000050329    * *
034100050329     C     K#DC          CHAIN     DCOVR
034200050823     C                   IF        NOT %FOUND(DCOVC) OR
034300050823     C                             (CCANDT <> 0 AND CCANDT <= #TDAY)
034400050329     C                   ITER
034500050329     C                   ENDIF
034600050329    * *
034700050329     C                   EXSR      $DEPLOAD
034800050329    * *
034900050329     C                   ENDIF
035000050329     C                   ENDDO
035100050323    ***
035200050323     C                   ENDSR
035300050323   S***S
035400050329     C     $DEPLOAD      BEGSR
035500050323    ***
035600050329     c                   clear                   lumenrc2r
035700050329    ***
035800050329     c                   movel     dpseq#        e4dep
035900050329     c                   move      '2'           e4rectyp
036000050329     c                   movel     E3GROUP       e4group
036100050329     c                   movel     E3PARTIC      e4partic
036200050329    ***
036300050329     c                   movel     E3DIV         e4div
036400050329     c                   movel     dfname        e4first
036500050329     c                   movel     dmi           e4mi
036600050329    ***
036700050329     c                   movel     dlname        dlname6           6
036800050329     c                   if        dlname6 <> 'SAME  '
036900050329     c                   movel     dlname        e4last
037000050329     c                   else
037100050329     c                   movel     E3LAST        e4last
037200050329     c                   end
037300050329    ***
037400050329     c                   if        drelcd = 'RHU' or drelcd = 'RWI'
037500050329     c                   move      'S'           e4relat
037600050329     c                   move      'M'           e4marit
037700050329     c                   else
037800050329     c                   move      'C'           e4relat
037900050329     c                   move      'S'           e4marit
038000050329     c                   end
038100050329      * domestic partner override
038200050329     c                   if        (dompart = 'Y') and
038300050329     c                             (drelcd = 'RHU' or drelcd = 'RWI')
038400050329     c                   move      'D'           e4relat
038500050329     c                   move      'S'           e4marit
038600050329     c                   end
038700050329    ***
038800050329     c                   move      dsex          e4sex
038900050329     c                   movel     dbirth        e4dob
039000050329     c                   movel     depss#        e4ssn
039100050329     c                   movel     dstudn        e4ftsflg
039200050329    ***
039300050329     c                   if        dhndcp <> ' ' and dhndcp <> 'N'
039400050329     c                   move      'Y'           e4hanflg
039500050329     c                   movel     dhddt         e4handte
039600050329     c                   end
039700050329    ***
039800050329     c                   if        dmedad <> 0
039900050329     c                   move      dmedad        e4meddte
040000050329     c                   end
040100050329    ***
040200050329     c                   EVAL      e4plan1 = KEY@LPL
040300050822     C                   IF        KEY@PLN = '3594' OR KEY@PLN = '3595' OR
040400050822     C                             KEY@PLN = '3593'
040500050822     c                   EVAL      e4cov1 = 'DEN'
040600050822     C                   ELSE
040700050822     c                   EVAL      e4cov1 = 'MED'
040800050822     C                   ENDIF
040900050329    ***
041000050329    *** effdt & candt
041100050329    *** for cobra members : add 1 day to DCOV enroll date if day <> 01
041200050329    *** subtract 1 day from cancel date if day = 01
041300050329    ***
041400050329     c                   movel     denrdt        e4effdt
041500050329     c                   move      denrdt        enrdd             2 0
041600050329    * *
041700050329     c                   if        cexpdt <> 0 and enrdd <> 01
041800050329     c                   move      denrdt        wkenr
041900050329     c                   adddur    1:*d          wkenr
042000050329     c                   move      wkenr         wkenr2
042100050329     c                   movel     wkenr2        e4effdt
042200050329     c                   end
042300050329    * *
042400050329     c                   if        ccandt <> 0
042500050329     c                   move      ccandt        wkcan
042600050329     c                   exsr      $candt
042700050329     c                   movel     wkcan2        e4end
042800050329    *** if subtracting 1 day made effective date >= cancel date then skip
042900050329     c                   if        e4effdt >= e4end
043000050329     c                   LEAVESR
043100050329     c                   end
043200050329     c                   else
043300050329     c                   clear                   e4end
043400050329     c                   end
043500050329    ***
043600050329     c                   add       1             dcovcnt           3 0
043700050329    ***
043800050329      * write depend record to dependent file
043900050329     C                   EVAL      E4X = '*'
044000050329     c                   write     lumenrc2r
044100050323    ***
044200050323     C                   ENDSR
044300050323   S***S
044400050329     C     $E12P         BEGSR
044500050329    ***
044600050329    *** default to F00
044700050329     c                   movel     'F00'         e3enr1
044800050329    ***
044900050329     c     mbssno        setll     dcovc
045000050329     c                   dow       not %eof(dcovc)
045100050329     c     mbssno        reade     dcovc
045200050329     c                   if        not %eof(dcovc) AND CCANDT <> DENRDT
045300050329     C                             AND DVPLAN = MCPLAN
045400050329    * *
045500050329     c                   IF        (denrdt < enrldt) or
045600050329     c                             (candt <> 0 and denrdt > candt)
045700050329     c                   iter
045800050329     c                   endIF
045900050329    * *
046000050329      * get relation, if son or daughter found use P01 as luminx
046100050329      * enrollment level instead of F00
046200050329     c     depkey        chain     depndc
046300050329     c                   if        %found(depndc) and
046400050329     c                             (drelcd = 'RSO' or drelcd = 'RDA')
046500050329     c                   movel     'P01'         e3enr1
046600050329     c                   leaveSR
046700050329     c                   endIF
046800050329
046900050329     c                   endIF
047000050329
047100050329     c                   enddo
047200050323    ***
047300050323     C                   ENDSR
047400050329   S***S
047500050329     C     $CANDT        BEGSR
047600050323    ***
047700050329      * if cancel day = 01 subtract 1 day
047800050329     c                   extrct    wkcan:*d      canday
047900050329     c                   if        canday = 01
048000050329     c                   subdur    1:*d          wkcan
048100050329     c                   end
048200050329     c                   move      wkcan         wkcan2
048300050323    ***
048400050323     C                   ENDSR
048500050323   S***S
048600050322     C*************************************************************
048700050322     Oqsysprt   E            #HEAD       2    03
048800050322     O                                           75 '** Group Benefit Service'
048900050322     O                                           79 's **'
049000050322     O          E            #HEAD       1
049100050322     O                                           76 'LUMINX CONVERSION REPORT'
049200050322     O          E            #HEAD       1
0493000503290120 O                                           14 'PROG : BG0012R'
049400050329     O                                           39 'ACCTS SELECTED...'
049500050329     O                       KEY@TRS       Z     43
049600050329     O                       KEY@SUB       Z     48
049700050329     O                       KEY@ACC       Z     54
0498000503220120 O                                          122 'PAGE :'
0499000503220122 O                       PAGE          Z    132
050000050322     O          E            #HEAD       1
0501000503220121 O                                            6 'DATE :'
0502000503220122 O                       *DATE         Y     17
0503000503220158 O          E            #HEAD       1  1
0504000503220159 O                                           24 '------------------------'
0505000503220160 O                                           48 '------------------------'
0506000503220161 O                                           72 '------------------------'
0507000503220162 O                                           96 '------------------------'
0508000503220163 O                                          120 '------------------------'
0509000503220164 O                                          132 '------------'
0510000503220158 O          E            #HEAD          1
0511000503220122 O                                           11 'SSN'
0512000503220122 O                                           25 'GBS T-S-A'
0513000503220122 O                                           52 '---LUMINX GROUP & DIV----'
0514000503220122 O                                           98 'MESSAGE'
0515000503220122 O                                          126 'DATA'
0516000503220158 O          E            #HEAD          2
0517000503220159 O                                           24 '------------------------'
0518000503220160 O                                           48 '------------------------'
0519000503220161 O                                           72 '------------------------'
0520000503220162 O                                           96 '------------------------'
0521000503220163 O                                          120 '------------------------'
0522000503220164 O                                          132 '------------'
0523000503220158 O          E            #prt           1
0524000503290122 O                       MCSSNO              11 '   -  -    '
0525000503220122 O                       e3group             47
0526000503220122 O                       e3div               52
0527000503220122 O                       #MSG(X)            121
0528000503220122 O                       msgdta             132
0529000503220158 O          E            #prtmtr     1  1
0530000503290122 O                                           41 '** MESSAGES RELATING TO TR'
0531000503290122 O                                           60 'ANSFERS FOLLOW **'
0532000503220158 O          E            #prtl1      1  1
0533000503290122 O                                           41 '     TRUST TOTALS:'
0534000503220122 O                                           +2 'ERRORS:'
0535000503220122 O                       errcnt        3     +1
0536000503220122 O                                           +2 'WARNINGS:'
0537000503220122 O                       warcnt        3     +1
0538000503220158 O          E            #prtl1         1
0539000503290122 O                                           40 'TRANSFERRED MEMBER COVERAG'
0540000503290122 O                                           43 'ES:'
0541000503220158 O          E            #prtlr      2  1
0542000503290122 O                                           70 'CONVERSION TOTALS:'
0543000503220158 O          E            #prtlr         1
0544000503290122 O                                           40 'TRANSFERRED MEMBER COVERAG'
0545000503290122 O                                           44 'ES:'
054600050322     Oqprint    E            #HEAD2      2    03
054700050322     O                                           75 '** Group Benefit Service'
054800050322     O                                           79 's **'
054900050322     O          E            #HEAD2      1
055000050322     O                                           76 'LUMINX CONVERSION REPORT'
055100050322     O                                           +1 '- ERRORS ONLY'
055200050322     O          E            #HEAD2      1
0553000503290120 O                                           14 'PROG : BG0012R'
055400050329     O                                           39 'ACCTS SELECTED...'
055500050329     O                       KEY@TRS       Z     43
055600050329     O                       KEY@SUB       Z     48
055700050329     O                       KEY@ACC       Z     54
0558000503220120 O                                          122 'PAGE :'
0559000503220122 O                       PAGE2         Z    132
056000050322     O          E            #HEAD2      1
0561000503220121 O                                            6 'DATE :'
0562000503220122 O                       *DATE         Y     17
0563000503220158 O          E            #HEAD2      1  1
0564000503220159 O                                           24 '------------------------'
0565000503220160 O                                           48 '------------------------'
0566000503220161 O                                           72 '------------------------'
0567000503220162 O                                           96 '------------------------'
0568000503220163 O                                          120 '------------------------'
0569000503220164 O                                          132 '------------'
0570000503220158 O          E            #HEAD2         1
0571000503220122 O                                           11 'SSN'
0572000503220122 O                                           25 'GBS T-S-A'
0573000503220122 O                                           52 '---LUMINX GROUP & DIV----'
0574000503220122 O                                           98 'MESSAGE'
0575000503220122 O                                          126 'DATA'
0576000503220158 O          E            #HEAD2         2
0577000503220159 O                                           24 '------------------------'
0578000503220160 O                                           48 '------------------------'
0579000503220161 O                                           72 '------------------------'
0580000503220162 O                                           96 '------------------------'
0581000503220163 O                                          120 '------------------------'
0582000503220164 O                                          132 '------------'
0583000503220158 O          E            #prt2          1
0584000503290122 O                       MCSSNO              11 '   -  -    '
0585000503290122 O
0586000503220122 O                       e3group             47
0587000503220122 O                       e3div               52
0588000503220122 O                       #MSG(X)            121
0589000503220122 O                       msgdta             132
0590000503220158 O          E            #prtlr2     2  1
0591000503220122 O                                              'CONVERSION TOTALS:'
059200050322** MESSAGES ------------------
059300050322MEMBER CONVERTED
059400050322ERROR: COV TYPE NOT IN XREF
059500050322ERROR: BENAMT > 999,999
059600050322ERROR: SALARY > 99,999,999
059700050322WARNING: COBRA PERIOD <> 18,36
059800050322WARNING: GBS ACC# NOT IN XREF
059900050322ERROR: TRANSFER MEM NOT FOUND
060000050322TRANSFER MEM COV CONVERTED
060100050322TRANSFER DEP COV CONVERTED
060200050322BENEFIT AMOUNT OVERRIDE
060300050322ERROR: NO PLAN COMBO FOUND
060400050322** coverage types (3-3): GBS - LUM
060500050322TINP00
060600050322TPCP01
060700050322T2PP99
060800050322TP2P99
060900050322THWF00
061000050322TFAF99
061100050322TDEF00
061200050322TDFF99
061300050322TTCP19
061400050322TFCF19
061500050322TE1F00
061600050322TDPF00
