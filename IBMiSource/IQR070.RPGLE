000100121025   X***X  IQ*07 MCOV POP UP WINDOW
000200121025   X***X
000300121025   X***X  SSK 10/24/2012
000400121025   X***X
000500121025   X***X   03 = EXIT FROM INITIAL SCREEN
000600121025   X***X   25 = SFLDSP
000700121025   X***X   26 = SFL DSP CTL
000800121025   X***X   27 = SFL CLR
000900121025   X***X
001000121107   X***X
001100121107   X***X 11/7/2012 SK  FLIP FLOP ORIG AND CURRENT AMTS
001200121107   X***X               ADD F8 SORT KEY
001300121107   X***X
001400140129   X***X 01/29/2014 SK SWITCH FROM GRATE TO GETRATE
001500140129   X***X
001600140129   X***X
001700121025   X***X
001800121026     FIQR070D   CF   E             WORKSTN SFILE(WDWSFL:RRT) INFDS(WSDS)
001900121025     FMCOVC     IF   E           K DISK
002000121025     FCLASS     IF   E           K DISK
002100121025     FMEMBER    IF   E           K DISK
002200121025     FACMUNIQUE IF   E           K DISK
002300121026     FPLNUNIQUE IF   E           K DISK
002400121025   X***X
002500121025     D WSDS            DS
002600121025     D  FKEY                 369    369A
002700121025    ***
002800121025     D  F1             C                   CONST(X'31')
002900121025     D  F2             C                   CONST(X'32')
003000121025     D  F3             C                   CONST(X'33')
003100121025     D  F4             C                   CONST(X'34')
003200121025     D  F5             C                   CONST(X'35')
003300121025     D  F6             C                   CONST(X'36')
003400121025     D  F7             C                   CONST(X'37')
003500121025     D  F8             C                   CONST(X'38')
003600121025     D  F9             C                   CONST(X'39')
003700121025     D  F10            C                   CONST(X'3A')
003800121025     D  F11            C                   CONST(X'3B')
003900121025     D  F12            C                   CONST(X'3C')
004000121025     D  F13            C                   CONST(X'B1')
004100121025     D  F14            C                   CONST(X'B2')
004200121025     D  F15            C                   CONST(X'B3')
004300121025     D  F16            C                   CONST(X'B4')
004400121025     D  F17            C                   CONST(X'B5')
004500121025     D  F18            C                   CONST(X'B6')
004600121025     D  F19            C                   CONST(X'B7')
004700121025     D  F20            C                   CONST(X'B8')
004800121025     D  F21            C                   CONST(X'B9')
004900121025     D  F22            C                   CONST(X'BA')
005000121025     D  F23            C                   CONST(X'BB')
005100121025     D  F24            C                   CONST(X'BC')
005200121025    ***
005300121026     D RRT             S              4S 0
005400121025     D @PROC           S             10A
005500121026     D SORTED          S               N
005600121026     D YES             S               N   INZ(*ON)
005700121026     D NO              S               N   INZ(*OFF)
005800121025    ***
005900121025     D LD@MCV        E DS                  EXTNAME(MCOV)
006000140128     D  TSPABCT               12     26A
006100121025    ***
006200121025     D MCOV@@        E DS                  EXTNAME(MCOV)
006300121025     D                                     PREFIX(Z:1) OCCURS(200)
006400121025    ***
006500121026     D MCOV@SRT      E DS                  EXTNAME(MCOV)
006600121026     D                                     PREFIX(Y:1) OCCURS(200)
006700121026    ***
006800121026     D S               S             26A
006900121026     D SK@             S             26A   DIM(200)
007000121026     D D@              S             40A   DIM(200)
007100121025     D G@              S             15A   DIM(200)
007200121025     D C@              S              4A   DIM(200)
007300121025     D CNE             S              3S 0
007400121025     D NDX             S              3S 0
007500121026     D SK@SRT          S             26A   DIM(200)
007600121026     D D@SRT           S             40A   DIM(200)
007700121026     D G@SRT           S             15A   DIM(200)
007800121026     D C@SRT           S              4A   DIM(200)
007900121026     D CNS             S              3S 0
008000121026     D SRX             S              3S 0
008100121107     D SORTYPE         S              1A
008200121025    ***
008300121025     D                 DS
008400121025     D ACCT@@                  1     10A
008500121025     D  T#                     1      3S 0
008600121025     D  S#                     4      6S 0
008700121025     D  A#                     7     10S 0
008800121025    ***
008900121025     D @@MEMBER        S                   LIKE(SCMEMBER)
009000121025     D @@ACCOUNT       S                   LIKE(SCACCOUNT)
009100121025    ***
009200121025   X***X
009300121107     C     *ENTRY        Plist                                                  *ENTRY LIST
009400121107     C                   Parm                    ACCT@            10
009500121107     C                   Parm                    MBR@              9
009600121107    ***
009700121026     C                   EVAL      @PROC = 'INITIALIZE'
009800121107     C                   EVAL      SORTYPE = 'S'
009900121107     C                   EVAL      *IN30 = *ON
010000121025    ***
010100121026     C                   DOU       @PROC = 'LEAVE APP '
010200121026     C     @PROC         CASEQ     'INITIALIZE'  $INZ
010300121026     C     @PROC         CASEQ     'GET MCOVS '  $EXTMCV
010400121026     C     @PROC         CASEQ     'SORT DATA '  $SORTCTL
010500121026     C     @PROC         CASEQ     'BUILD SCRN'  $BLDSFL
010600121026     C     @PROC         CASEQ     'DISPLAYMCV'  $SCREEN
010700121025     C                   ENDCS
010800121025    ***
010900121025     C                   ENDDO
011000121025    ***
011100121025     C                   EVAL      *INLR = *ON
011200121025    ***
011300121025   S***S
011400121025     C     $INZ          BEGSR
011500121025    ***
011600121026     C                   EVAL      @PROC = 'GET MCOVS '
011700121025    ***
011800121025     C     KL#TSA        KLIST
011900121025     C                   KFLD                    T#
012000121025     C                   KFLD                    S#
012100121025     C                   KFLD                    A#
012200121026      *
012300121026     C     KL#TSP        KLIST
012400121026     C                   KFLD                    MCTRST
012500121026     C                   KFLD                    MCSUB#
012600121026     C                   KFLD                    MCPLAN
012700121025      *
012800121025     C     KL#TSPE       KLIST
012900121025     C                   KFLD                    MCTRST
013000121025     C                   KFLD                    MCSUB#
013100121025     C                   KFLD                    MCPLAN
013200121025     C                   KFLD                    MCOVTP
013300121025      *
013400121025     C     KL#TSPAE      KLIST
013500121025     C                   KFLD                    MCTRST
013600121025     C                   KFLD                    MCSUB#
013700121025     C                   KFLD                    MCPLAN
013800121025     C                   KFLD                    MCAGEB
013900121025     C                   KFLD                    MCOVTP
014000140128      *
014100140128     C     GRPLIST       PLIST
014200140128     C                   PARM                    PARMKEY          15
014300140128     C                   PARM                    PARMSSN           9
014400140128     C                   PARM                    PARMSEQ           2
014500140128     C                   PARM                    PARMEFFYMD        8
014600140128     C                   PARM                    PARMBENAMT        7
014700140128     C                   PARM                    PARMGROUP        15
014800140128     C                   PARM                    PARMBILRTE       11
014900140128     C                   PARM                    PARMNETRTE       11
015000140128     C                   PARM                    PARMBILPREM       7
015100140128     C                   PARM                    PARMNETPREM       7
015200140128     C                   PARM                    PARMFOUND         1
015300121025      *
015400121025     C                   MOVE      ACCT@         ACCT@@
015500121025     C     KL#TSA        CHAIN     ACCMSR
015600121025      *
015700121025     C                   EVAL      @@ACCOUNT = %SUBST(ACCT@:1:3) + '-' +
015800121025     C                             %SUBST(ACCT@:4:3) + '-' +
015900121025     C                             %SUBST(ACCT@:7:4) + ' ' +
016000121025     C                             %TRIM(ACNAM1)
016100121025      *
016200121025     C                   MOVE      MBR@          MBR#              9 0
016300121025      *
016400121025     C     MBR#          CHAIN     MEMBR
016500121025      *
016600121025     C                   EVAL      @@MEMBER = MBR@ + ' ' +
016700121025     C                             %TRIM(MFNAME) + ' ' + MMI
016800121025     C                   EVAL      @@MEMBER = %TRIM(@@MEMBER) + ' ' +
016900121025     C                             %TRIM(MLNAME)
017000121025    ***
017100121025     C                   EVAL      NDX = 0
017200121025     C                   EVAL      CNE = 0
017300121025    ***
017400121026     C                   CLEAR                   SK@
017500121026     C                   CLEAR                   D@
017600121025     C                   CLEAR                   G@
017700121025     C                   CLEAR                   C@
017800121025    ***
017900121025     C                   DO        200
018000121025     C                   ADD       1             NDX
018100121025     C     NDX           OCCUR     MCOV@@
018200121025     C                   CLEAR                   MCOV@@
018300121025     C                   ENDDO
018400121025     C                   EVAL      NDX = 0
018500121025    ***
018600121025     C     MBR#          SETLL     MCOVR
018700121025    ***
018800121025     C                   ENDSR
018900121025   S***S
019000121025     C     $EXTMCV       BEGSR
019100121025    ***
019200121025     C     MBR#          READE     MCOVR
019300121025     C                   IF        %EOF(MCOVC)
019400121026     C                   EVAL      @PROC = 'SORT DATA '
019500121025     C                   LEAVESR
019600121025     C                   ENDIF
019700121107    ***
019800121107     C                   IF        CANDT = ENRLDT
019900121107     C                   LEAVESR
020000121107     C                   ENDIF
020100121025    ***
020200121025     C                   ADD       1             CNE
020300121025    ***
020400121031     C     CNE           OCCUR     MCOV@@
020500121025     C                   EVAL      MCOV@@ = LD@MCV
020600121025    ***
020700121025     C     KL#TSPE       CHAIN     FCLASS
020800121025     C                   IF        %FOUND(CLASS)
020900121025     C                   EVAL      C@(CNE) = CLCLASS
021000121025     C                   ENDIF
021100121025    ***
021200140128     C                   EXSR      $GETRATE
021300140128    ***
021400121026     C     KL#TSP        CHAIN     PLNMSR
021500121026     C                   IF        %FOUND(PLNUNIQUE)
021600121026     C                   EVAL      D@(CNE) = PDESCR
021700121026     C                   ELSE
021800121026     C                   EVAL      D@(CNE) = 'UNAVAILABLE'
021900121026     C                   ENDIF
022000121107    ***
022100121107     C                   IF        SORTYPE = 'S'
022200121107    *** *
022300121026     C                   SELECT
022400121026     C                   WHEN      CANDT = 0
022500121026     C                   EVAL      S = '1'
022600121026     C                   WHEN      CANDT > 0 AND ENRLDT <> CANDT
022700121026     C                   EVAL      S = '2'
022800121026     C                   OTHER
022900121026     C                   EVAL      S = '3'
023000121026     C                   ENDSL
023100121026     C                   EVAL      S = %TRIM(S) + MCPLAN +
023200121026     C                             %EDITC(ENRLDT:'X') + %EDITC(CANDT:'X') +
023300121026     C                             %EDITC(MCAGEB:'X') + MCOVTP
023400121026     C                   EVAL      SK@(CNE) = S
023500121107    *** *
023600121107     C                   ELSE
023700121107    *** *
023800121107     C                   EVAL      S = '0' + MCPLAN +
023900121107     C                             %EDITC(ENRLDT:'X') + %EDITC(CANDT:'X') +
024000121107     C                             %EDITC(MCAGEB:'X') + MCOVTP
024100121107     C                   EVAL      SK@(CNE) = S
024200121025    *** *
024300121107     C                   ENDIF
024400140128    ***
024500140128     C                   ENDSR
024600140128   S***S
024700140128     C     $GETRATE      BEGSR
024800140128    ***
024900140128     C                   EVAL      PARMSSN = MBR@
025000140128     C                   EVAL      PARMSEQ = 'FA'
025100140128    ***
025200140128     C                   MOVE      TSPABCT       PARMKEY
025300140128     C                   MOVE      ENRLDT        PARMEFFYMD
025400140128     C                   MOVE      *ALL'0'       PARMBENAMT
025500140128     C                   CLEAR                   PARMGROUP
025600140128     C                   CLEAR                   PARMBILRTE
025700140128     C                   CLEAR                   PARMNETRTE
025800140128     C                   CLEAR                   PARMBILPREM
025900140128     C                   CLEAR                   PARMNETPREM
026000140128     C                   CLEAR                   PARMFOUND
026100140128    ***
026200140128     C                   CALL      'GETRATE'     GRPLIST
026300140128    ***
026400140128    *** GRATE NOT RETURNED
026500140128    ***
026600140128     C                   IF        PARMFOUND = 'Y'
026700140128     C                   EVAL      G@(CNE) = PARMGROUP
026800140128     C                   ELSE
026900140128     C                   EVAL      G@(CNE) = *BLANKS
027000140128     C                   ENDIF
027100140128    ***
027200140128     C                   IF        LPREM = 0.00 AND
027300140128     C                             PARMFOUND = 'Y'
027400140128     C                   MOVE      PARMBILPREM   ZPREM
027500140128     C                   ENDIF
027600121025    ***
027700121025     C                   ENDSR
027800121025   S***S
027900121026     C     $SORTCTL      BEGSR
028000121025    ***
028100121026     C                   IF        CNE = 1
028200121026     C                   EVAL      @PROC = 'BUILD SCRN'
028300121026     C                   LEAVESR
028400121026     C                   ENDIF
028500121025    ***
028600121026     C                   EVAL      SORTED = NO
028700121026    ***
028800121026     C                   DOU       SORTED = YES
028900121026    *****
029000121026     C                   EXSR      $SORTCHK
029100121026    *****
029200121026     C                   IF        SORTED = YES
029300121026     C                   LEAVE
029400121026     C                   ENDIF
029500121026    *****
029600121026     C                   EVAL      SRX = 0
029700121026     C                   EVAL      CNS = 0
029800121026    *****
029900121026     C                   CLEAR                   SK@SRT
030000121026     C                   CLEAR                   D@SRT
030100121026     C                   CLEAR                   G@SRT
030200121026     C                   CLEAR                   C@SRT
030300121026    ***
030400121026     C                   DO        200
030500121026     C                   ADD       1             SRX
030600121026     C     SRX           OCCUR     MCOV@SRT
030700121026     C                   CLEAR                   MCOV@SRT
030800121026     C                   ENDDO
030900121026     C                   EVAL      SRX = 0
031000121026    *****
031100121026     C                   EXSR      $SORTIT
031200121026    *****
031300121101     C                   EVAL      NDX = 0
031400121026     C                   DO        CNE
031500121026     C                   ADD       1             NDX
031600121026     C                   EVAL      SK@(NDX) = SK@SRT(NDX)
031700121026     C                   EVAL      G@(NDX) = G@SRT(NDX)
031800121026     C                   EVAL      D@(NDX) = D@SRT(NDX)
031900121026     C                   EVAL      C@(NDX) = C@SRT(NDX)
032000121026     C     NDX           OCCUR     MCOV@SRT
032100121026     C     NDX           OCCUR     MCOV@@
032200121026     C                   EVAL      MCOV@@ = MCOV@SRT
032300121026     C                   ENDDO
032400121026    *****
032500121026     C                   ENDDO
032600121026    ***
032700121026     C                   EVAL      @PROC = 'BUILD SCRN'
032800121026    ***
032900121025     C                   ENDSR
033000121025   S***S
033100121026     C     $SORTCHK      BEGSR
033200121026    ***
033300121026     C                   EVAL      NDX = 0
033400121026     C                   MOVE      *BLANKS       S
033500121026    ***
033600121026     C                   DO        CNE
033700121026    ***
033800121026     C                   ADD       1             NDX
033900121026    ***
034000121026     C                   IF        NDX = 1
034100121026     C                   EVAL      S = SK@(NDX)
034200121026     C                   ITER
034300121026     C                   ENDIF
034400121026    ***
034500121026     C                   IF        SK@(NDX) < S
034600121026     C                   LEAVESR
034700121026     C                   ENDIF
034800121026    ***
034900121026     C                   EVAL      S = SK@(NDX)
035000121026    ***
035100121026     C                   ENDDO
035200121026    ***
035300121026     C                   EVAL      SORTED = YES
035400121026    ***
035500121026     C                   ENDSR
035600121026   S***S
035700121026     C     $SORTIT       BEGSR
035800121026    ***
035900121026     C                   EVAL      NDX = 0
036000121026     C                   MOVE      *BLANKS       S
036100121026     C                   EVAL      SRX = 0
036200121026    ***
036300121026     C                   DO        CNE
036400121026    *****
036500121026     C                   ADD       1             NDX
036600121026    *****
036700121026     C                   IF        NDX = 1
036800121026     C                   EVAL      S = SK@(NDX)
036900121026     C                   EVAL      SRX = NDX
037000121026     C                   ITER
037100121026     C                   ENDIF
037200121026    *****
037300121026     C                   IF        SK@(NDX) <= S
037400121026    ********
037500121026     C                   ADD       1             CNS
037600121026    ********
037700121026     C                   EVAL      SK@SRT(CNS) = SK@(NDX)
037800121026     C                   EVAL      D@SRT(CNS) = D@(NDX)
037900121026     C                   EVAL      G@SRT(CNS) = G@(NDX)
038000121026     C                   EVAL      C@SRT(CNS) = C@(NDX)
038100121026    ********
038200121026     C     CNS           OCCUR     MCOV@SRT
038300121026     C     NDX           OCCUR     MCOV@@
038400121026     C                   EVAL      MCOV@SRT = MCOV@@
038500121026    ********
038600121026     C                   ITER
038700121026     C                   ENDIF
038800121026    ***
038900121026    *** SK@(NDX) > S
039000121026    ***
039100121026     C                   ADD       1             CNS
039200121026     C                   EVAL      SK@SRT(CNS) = SK@(SRX)
039300121026     C                   EVAL      G@SRT(CNS) = G@(SRX)
039400121026     C                   EVAL      D@SRT(CNS) = D@(SRX)
039500121026     C                   EVAL      C@SRT(CNS) = C@(SRX)
039600121026     C     CNS           OCCUR     MCOV@SRT
039700121026     C     SRX           OCCUR     MCOV@@
039800121026     C                   EVAL      MCOV@SRT = MCOV@@
039900121026     C                   EVAL      SRX = NDX
040000121101     C                   EVAL      S = SK@(NDX)
040100121026    ***
040200121026     C                   ENDDO
040300121026    ***
040400121026     C                   IF        CNS < CNE
040500121026     C                   ADD       1             CNS
040600121026     C                   EVAL      SK@SRT(CNS) = SK@(SRX)
040700121026     C                   EVAL      G@SRT(CNS) = G@(SRX)
040800121026     C                   EVAL      D@SRT(CNS) = D@(SRX)
040900121026     C                   EVAL      C@SRT(CNS) = C@(SRX)
041000121026     C     CNS           OCCUR     MCOV@SRT
041100121026     C     SRX           OCCUR     MCOV@@
041200121026     C                   EVAL      MCOV@SRT = MCOV@@
041300121026     C                   EVAL      SRX = NDX
041400121026     C                   ENDIF
041500121026    ***
041600121026     C                   ENDSR
041700121026   S***S
041800121026     C     $BLDSFL       BEGSR
041900121026    ***
042000121026     C                   EVAL      @PROC = 'DISPLAYMCV'
042100121026    ***
042200121026     C                   MOVE      '0'           @1STLOOP          1
042300121101     C                   MOVEA     '011'         *IN(25)
042400121101     C                   WRITE     WDWCTL
042500121101     C                   MOVEA     '010'         *IN(25)
042600121026     C                   Z-ADD     *ZERO         RRT
042700121026    ***
042800121026     C                   EVAL      NDX = 0
042900121026     C                   DO        CNE
043000121101    ******
043100121026     C                   ADD       1             NDX
043200121101     C                   MOVE      *ON           *IN25
043300121026     C     NDX           OCCUR     MCOV@@
043400121101    ******
043500121026     C                   EVAL      SFPLAN = ZCPLAN
043600121026     C                   EVAL      SFDESC = D@(NDX)
043700121101     C                   EVALR     SFCOVTP = ZCOVTP
043800121101     C                   EVAL      SFLPREM = ZPREM
043900121101     C                   EVAL      SFCLASS = C@(NDX)
044000121101     C                   EVAL      SFCGRP = G@(NDX)
044100121101    ******
044200121026     C                   EVAL      SFAGEB = %EDITC(ZCAGEB:'X')
044300121101     C                   IF        SFAGEB = '00'
044400121101     C                   EVAL      SFAGEB = *BLANKS
044500121101     C                   ENDIF
044600121101    ******
044700121101     C                   IF        ZNRLDT = 0
044800121101     C                   EVAL      SFENRLDT = *BLANKS
044900121101     C                   ELSE
045000121026     C     ZNRLDT        MULT      10000.0001    #8S0              8 0
045100121101     C                   EVAL      SFENRLDT = %EDITC(#8S0:'Y')
045200121101     C                   ENDIF
045300121101    ******
045400121026     C                   IF        ZANDT = 0
045500121101     C                   EVAL      SFCANDT = *BLANKS
045600121026     C                   ELSE
045700121026     C     ZANDT         MULT      10000.0001    #8S0
045800121101     C                   EVAL      SFCANDT = %EDITC(#8S0:'Y')
045900121026     C                   ENDIF
046000121101    ******
046100121101     C                   IF        ZENAMT = 0
046200121101     C                   EVAL      SFBENAMT = *BLANKS
046300121101     C                   ELSE
046400121101     C                   EVAL      SFBENAMT = %EDITC(ZENAMT:'1')
046500121101     C                   ENDIF
046600121101    ******
046700121101     C                   IF        ZCORGBEN = 0
046800121101     C                   EVAL      SFORGBEN = *BLANKS
046900121101     C                   ELSE
047000121101     C                   EVAL      SFORGBEN = %EDITC(ZCORGBEN:'1')
047100121101     C                   ENDIF
047200121107    ******
047300121101     C                   IF        ZENAMT <> ZCORGBEN
047400121026     C                   EVAL      SFRB = 'Y'
047500121026     C                   ELSE
047600121026     C                   EVAL      SFRB = *BLANKS
047700121026     C                   ENDIF
047800121101    ******
047900121112     C                   EVAL      *IN91 = *OFF
048000121112     C                   IF        CNE <= 14 OR NDX = CNE
048100121112     C                   EVAL      *IN91 = *ON
048200121112     C                   ENDIF
048300121112    ******
048400121026     C                   ADD       1             RRT
048500121026     C                   IF        @1STLOOP = '0'
048600121026     C                   Z-ADD     RRT           WSPAG
048700121026     C                   MOVE      '1'           @1STLOOP
048800121026     C                   ENDIF
048900121026     C                   WRITE     WDWSFL
049000121101    ******
049100121026     C                   ENDDO
049200121112    ***
049300121026     C                   ENDSR
049400121026   S***S
049500121026     C     $SCREEN       BEGSR
049600121025    ***
049700121101     C                   EVAL      SCMEMBER = @@MEMBER
049800121101     C                   EVAL      SCACCOUNT = @@ACCOUNT
049900121101     C                   WRITE     JUNK
050000121101     C                   EXFMT     WDWCTL
050100121025    ***
050200121025     C                   IF        FKEY = F3
050300121101     C                   EVAL      @PROC = 'LEAVE APP '
050400121025     C                   LEAVESR
050500121025     C                   ENDIF
050600121107    ***
050700121107     C                   IF        FKEY = F8
050800121107     C                   IF        *IN30 = *ON
050900121107     C                   EVAL      SORTYPE = 'P'
051000121107     C                   EVAL      *IN30 = *OFF
051100121107     C                   ELSE
051200121107     C                   EVAL      SORTYPE = 'S'
051300121107     C                   EVAL      *IN30 = *ON
051400121107     C                   ENDIF
051500121107     C                   EVAL      @PROC = 'INITIALIZE'
051600121107     C                   ENDIF
051700121025    ***
051800121026     C                   ENDSR
051900121025   S***S
