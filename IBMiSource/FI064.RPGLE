000100001206     F*********************************************************************
000200070821     F* fi064      - admin fee / bonus draw overide inquiry               *
000300001206     F*                                                                   *
000700070821     F* 08/21/07 dlk - adapted from FM064                                 *
000900001206     F*                                                                   *
001400001206     F*                                                                   *
001500001206     F*********************************************************************
001600070821     Fabover    IF   E           K DISK
001800060327     Fcarmst    IF   E           K DISK
001801060327     Fcodes     IF   E           K DISK
001900070821     Ffi064D    CF   E             WORKSTN INFDS(WSDS)
002000060328     F                                     SFILE(IO01S:RRN)
002200060328     D                 DS
002300060328     D  r2plncat3              1      3
002301060329     D  ppre                   1      1    inz('P')
002302060328     D  r2plncat               2      3
002303060328     D                 DS
002304060328     D  i_tsa                  1     10s 0
002305060328     D  i_trust                1      3s 0
002306060328     D  i_sub                  4      6s 0
002307060328     D  i_acc                  7     10s 0
002308060328     ***
002309060328     D WSDS            DS
002310060328     D  FKEY                 369    369A
002400001206     ***
002500001206     D  F1             C                   CONST(X'31')
002600001206     D  F2             C                   CONST(X'32')
002700001206     D  F3             C                   CONST(X'33')
002800001206     D  F4             C                   CONST(X'34')
002900001206     D  F5             C                   CONST(X'35')
003000001206     D  F6             C                   CONST(X'36')
003100001206     D  F7             C                   CONST(X'37')
003200001206     D  F8             C                   CONST(X'38')
003300001206     D  F9             C                   CONST(X'39')
003400001206     D  F10            C                   CONST(X'3A')
003500001206     D  F11            C                   CONST(X'3B')
003600001206     D  F12            C                   CONST(X'3C')
003700001206     D  F13            C                   CONST(X'B1')
003800001206     D  F14            C                   CONST(X'B2')
003900001206     D  F15            C                   CONST(X'B3')
004000001206     D  F16            C                   CONST(X'B4')
004100001206     D  F17            C                   CONST(X'B5')
004200001206     D  F18            C                   CONST(X'B6')
004300001206     D  F19            C                   CONST(X'B7')
004400001206     D  F20            C                   CONST(X'B8')
004500001206     D  F21            C                   CONST(X'B9')
004600001206     D  F22            C                   CONST(X'BA')
004700001206     D  F23            C                   CONST(X'BB')
004800001206     D  F24            C                   CONST(X'BC')
004900001206     ***
005000060331     D MSG             S             50A   DIM(14) CTDATA PERRCD(1)
005100010109     D @STEP           S              5A   INZ('STEP1')
005200010109     D #ISO            S               D   DATFMT(*ISO)
005300010109     D #USA            S               D   DATFMT(*USA)
005301060328     D #isa            S              8s 0
005302060328     D fee2txt         S             11a
005304060328     D p               s              1a   inz('P')
005400001206     ***
005500001206     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
005600001206     D                UDS
005700001206     D  TITLE                201    240
005800001206     ***
005900010109     C                   DOU       @STEP = 'EXIT'
006000010109     C     @STEP         CASEQ     'STEP1'       $STEP1
006100010109     C     @STEP         CASEQ     'STEP2'       $STEP2
006400001206     C                   ENDCS
006500001206     C                   ENDDO
006600001206     C*
006700001206     C                   MOVE      *ON           *INLR
006701060329
006801060328   S* **************************************************
006802070821   S* * step 1 - fill subfile
006803060328   S* **************************************************
008800001206     C     $STEP1        BEGSR
008900001206     C*
009000060329     C                   MOVEL     parmtsa       I_tsa
009001060329     C                   MOVEL     parmacname    I_acname
009100001206     C                   MOVE      *BLANKS       R1MSG
009200001206     C* CLEAR SFL
009300001206     C                   MOVEA     '011'         *IN(28)
009400001206     C                   WRITE     IO01C
009500001206     C                   MOVEA     '010'         *IN(28)
009600001206     C* SFL BUILD
009700060328     C                   Z-ADD     *ZERO         RRN               3 0
009800001206     C                   MOVE      '0'           @1STLOOP          1
009900001206     C*
010000060328     C     abkey1        SETLL     abover
010100060327    1C                   DOU       %EOF(abover)
010200070821     C     abkey1        READE     abover
010201060328
010300060327    2C                   IF        NOT %EOF(abover)
010500001206     C                   CLEAR                   IO01S
010600001206     C                   MOVE      *ON           *IN28
010700001206     C                   MOVE      *OFF          *IN31
010702060331      * get carrier desc
010703060331*****C                   move      abcarr        SFcar
012101060331     c     sfcar         chain     carmst
012103060331     c                   if        %found(carmst)
012104060331     c                   movel     cname         sfcard
012105060331     c                   end
012106060331      * get plan cat desc
012107060331*****C                   move      abpcat        SFplncat
012109060331      /Free
012110060331        chain ('P' : sfplncat) codes;
012111060331      /END-FREE
012114060331     c                   if        %found(codes)
012115060331     c                   movel     ldescr        sfpcatd
012116060331     c                   end
012117060331
012118060328*****C                   move      abpcat        SFplncat
012119060328*****C                   Z-ADD     abovpp        SFpp
012200060328*****C                   Z-ADD     abovra        SFff
012300060328     C                   Z-ADD     abOVPC        SFPC
012301060329      * ymd to mdy
012600060327     C                   Z-ADD     abFRDT        #ISA
012700010122     C                   EXSR      $ISOUSA
012800010122     C                   Z-ADD     #ISA          SFFRDT
012801060329
012802060329      * ymd to mdy
013000060327     C                   Z-ADD     abTODT        #ISA
013100010122     C                   EXSR      $ISOUSA
013200010122     C                   Z-ADD     #ISA          SFTODT
013201060329
013400060328     C                   ADD       1             RRN
013500001206    3C                   IF        @1STLOOP = '0'
013600060328     C                   Z-ADD     RRN           SFLRRN
013700001206     C                   MOVE      '1'           @1STLOOP
013800001206    3C                   ENDIF
014101060328     C                   WRITE     IO01S
014200001206    2C                   ENDIF
014201060328
014400001206    1C                   ENDDO
014500060328
014600001206     C                   MOVEL(P)  'STEP2'       @STEP
014700001206     C                   MOVE      *BLANKS       R1MSG
014800001206     C*
014900001206     C                   ENDSR
016101060328   S* **************************************************
016102060329   S* * step 2 display screen 1
016103060328   S* **************************************************
016200010109     C     $STEP2        BEGSR
016300060328    * * display 1st screen
016401060329     C                   WRITE     IO01fkey
016402060328     C                   EXFMT     IO01C
016500010109     C                   MOVE      *BLANKS       R1MSG
016700010109    ***
016800010109     C                   IF        FKEY = F1
016900010109     C                   MOVEL(P)  'EXIT'        @STEP
017000010109     C                   LEAVESR
017100010109     C                   ENDIF
018200010109    ***
018300010109     C                   MOVEL(P)  'STEP1'       @STEP
018400010109    ***
018500010109     C                   ENDSR
018501070821
018502070821   S* **************************************************
018503070821   S* * date change ymd - mdy
018504070821   S* **************************************************
018505070821     C     $ISOUSA       BEGSR
018506070821     C     *ISO          TEST (DE)               #ISA
018507070821     C                   IF        %ERROR
018508070821     C                   MOVE      *ZEROS        #ISA
018509070821     C                   ELSE
018510070821     C                   MOVE      #ISA          #ISO
018511070821     C                   MOVE      #ISO          #USA
018512070821     C                   MOVE      #USA          #ISA
018513070821     C                   ENDIF
018514070821     C                   ENDSR
018515070821   S*
018516070821   S* **************************************************
018517070821   S* * date change mdy - ymd
018518070821   S* **************************************************
018519070821     C     $USAISO       BEGSR
018520070821     C     *USA          TEST (DE)               #ISA
018521070821     C                   IF        %ERROR
018522070821     C                   MOVE      *ZEROS        #ISA
018523070821     C                   ELSE
018524070821     C                   MOVE      #ISA          #USA
018525070821     C                   MOVE      #USA          #ISO
018526070821     C                   MOVE      #ISO          #ISA
018527070821     C                   ENDIF
018528070821     C                   ENDSR
018529070821
050301060327
050302060328   S* **************************************************
050303060328   S* * first cycle
050304060328   S* **************************************************
050305060327     C     *INZSR        BEGSR
050306060327
050307060329     C* parmtsa = pass t/s/a
050308060329     C* parmab = A-admin fee or B-bonus draw
050309060327     C     *ENTRY        PLIST
050310060329     C                   PARM                    parmab            1
050311060329     C                   PARM                    parmtsa          10
050314060329     C                   PARM                    parmacname       40
050315060327     C*
050316060329     c                   if        parmab = 'A'
050317060327     c                   eval      headab  = ' Admin Fee'
050318060327     c                   eval      feetxt  = 'Comm    '
050319060327     c                   eval      fee2txt = 'Commission '
050320060327     c                   else
050321060327     c                   eval      headab  = 'Bonus Draw'
050322060327     c                   eval      feetxt  = 'Admin   '
050323060327     c                   eval      fee2txt = 'Admin Fee  '
050324060403      * 98-*on = protect flat fee on the bonus draw - Future use
050326060403     c                   eval      *in98 = *on
050327060327     c                   end
050328060327
050329060327     C     *LIKE         DEFINE    abFRDT        #FRDT
050330060327     C     *LIKE         DEFINE    abTODT        #TODT
050331060328
050332060328     C     plncatkey     KLIST
050333060328     C                   KFLD                    p
050334060328     C                   KFLD                    r2plncat
050335060327     C*
050336060328     C     abkey1        KLIST
050337060329     C                   KFLD                    parmab
050338060327     C                   KFLD                    I_trust
050339060327     C                   KFLD                    I_sub
050340060328     C                   KFLD                    I_acc
050341060328     C     abkey         KLIST
050342060329     C                   KFLD                    parmab
050343060328     C                   KFLD                    I_trust
050344060328     C                   KFLD                    I_sub
050345060328     C                   KFLD                    I_acc
050346070821     C                   KFLD                    r2car             3
050347060328     C                   KFLD                    r2plncat3
050348060329     C                   KFLD                    fromymd           8 0
050349060329     C                   KFLD                    toymd             8 0
050350060327     C*
050351060327     C                   ENDSR
050500010109123456*8901234567890123456789012345678901234567890
050600010109      *  11111111112222222222333333333344444444445
050700010109** CTDATA MSG
050800060328INVALID CARRIER
050900060328INVALID PLAN CATEGORY
051000010109FROM DATE CANNOT BE ZERO
051100010109FROM DATE IS IN A NON-VALID FORMAT
051200010109TO DATE IS IN A NON-VALID FORMAT
051300010109%AGE OF PREMIUM CANNOT EXCEED 100%
051400010109%AGE OF COMMISSION CANNOT EXCEED 100%
051500060403PLEASE CHOOSE ONLY ONE OF THE OVERRIDES
051600010109UPDATE OF RECORD COMPLETE
051700010109REC EXISTS OR OPEN RECORD ALREADY EXISTS
051800060329FLAT FEE CANNOT EXCEED $100, use 999.99 for $0.00
051900060329RECORD NOT FOUND
052000060331THIS RECORD HAS BEEN ADDED
052100060331TO DATE CANNOT BE BEFORE THE FROM DATE
