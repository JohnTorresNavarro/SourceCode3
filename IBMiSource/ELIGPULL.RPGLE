000100160719     H option(*noDebugIo)
000200160719      *========================================================================
000300160719      * GENERIC ELIGIBILITY PULL
000400160719      *========================================================================
000500160719
000600160719      * 08/15/2014 SSK ADD SMOKER FLAG AND GROUP # AND ALTERNATE ID
000700160719
000800160719      * 07/19/2016 JT Eliminated Alternate ID Header from RX
000900160719
001000160719      *========================================================================
001100160719
001200130617     FELIGPULLD CF   E             WORKSTN INFDS(WSDS)
001300130617     ***
001400140815     FCARUNIQUE IF   E           K DISK
001500140815     ***
001600130612     FACMUNIQUE IF   E           K DISK
001700130617     ***
001800130612     FCOMCTUNIQ IF   E           K DISK
001900130612     ***CMTRST CSUBDV CMACCT CMPLAN
002000130617     ***
002100130612     FPLNUNIQUE IF   E           K DISK
002200130617     ***
002300130612     FCODESL1   IF   E           K DISK
002400130617     ***
002500140815     FMEMALTL3  IF   E           K DISK
002600140815     ***
002700140815     FSMOKE     IF   E           K DISK
002800140815     ***
002900140815     FGRATEX    IF   E           K DISK
003000140815     ***
003100130620     FELIGPULLA O  A F 5000        DISK    USROPN
003200130620     FELIGPULLB O  A F 5000        DISK    USROPN
003300130617     ***
003400130619     FELIGPULLWLIF   E           K DISK    RENAME(WKF:WKF2) PREFIX(Y:1)
003500130619     ***
003600130619     FELIGPULLW1IF A E           K DISK
003700130617     ***
003800130618     FMEMAC#1   IF   E           K DISK
003900130618     FMCOVC     IF   E           K DISK
004000130618     FDEPNDC    IF   E           K DISK
004100130618     FDCOVC     IF   E           K DISK
004200130617   X***X
004300130617     D WSDS            DS
004400130617     D  FKEY                 369    369A
004500130617     ***
004600130617     D  F1             C                   CONST(X'31')
004700130617     D  F2             C                   CONST(X'32')
004800130617     D  F3             C                   CONST(X'33')
004900130617     D  F4             C                   CONST(X'34')
005000130617     D  F5             C                   CONST(X'35')
005100130617     D  F6             C                   CONST(X'36')
005200130617     D  F7             C                   CONST(X'37')
005300130617     D  F8             C                   CONST(X'38')
005400130617     D  F9             C                   CONST(X'39')
005500130617     D  F10            C                   CONST(X'3A')
005600130617     D  F11            C                   CONST(X'3B')
005700130617     D  F12            C                   CONST(X'3C')
005800130617     D  F13            C                   CONST(X'B1')
005900130617     D  F14            C                   CONST(X'B2')
006000130617     D  F15            C                   CONST(X'B3')
006100130617     D  F16            C                   CONST(X'B4')
006200130617     D  F17            C                   CONST(X'B5')
006300130617     D  F18            C                   CONST(X'B6')
006400130617     D  F19            C                   CONST(X'B7')
006500130617     D  F20            C                   CONST(X'B8')
006600130617     D  F21            C                   CONST(X'B9')
006700130617     D  F22            C                   CONST(X'BA')
006800130617     D  F23            C                   CONST(X'BB')
006900130617     D  F24            C                   CONST(X'BC')
007000130617   X***X
007100130619     D Q               C                   CONST('","')
007200130612     D DS@PLN          DS                  OCCURS(200)
007300140815     D  DTA@                   1     76A
007400130618     D  SRT@                   1      9A
007500130618     D  PLN@                  10     13A
007600130618     D  ENR@                  14     16A
007700130618     D  EFF@                  17     24A
007800130618     D  DES@                  25     34A
007900130618     D  VOL@                  35     41A
008000140815     D  GRP@                  42     56A
008100140815     D  ALT@                  57     76A
008200130612     D #C              S              3S 0
008300130612     D #N              S              3S 0
008400130619     D X               S              3S 0
008500130619     D Y               S              3S 0
008600130618      *
008700130618     D S1@PLN          DS                  OCCURS(200)
008800140815     D  S1@@                   1     76A
008900130619     D  S1SRT                  1      9A
009000130619     D S               S              3S 0
009100130618      *
009200140815     D SMOKE#TO        S              8S 0
009300130619     D #XSX            S              8S 0
009400130619     D #XTD            S              8S 0
009500140815     D #TODAY          S              8S 0
009600130620     D #TD             S               D   DATFMT(*ISO)
009700130620     D #ISO            S               D   DATFMT(*ISO)
009800130619     D #8              S              8S 0
009900130619     D @ED             S             16A
010000140815     D COMP@           S             76A
010100130620     D PRT_YET         S               N
010200130619     D MATCH_FND       S               N
010300130619     D YES             S               N   INZ(*ON)
010400130619     D NO              S               N   INZ(*OFF)
010500130619     D @EMSG           S                   LIKE(EMSG)
010600130619     D KSQ             S              2S 0
010700130619     D @IO             S              1A
010800130619     D @SORT           S              9A
010900130620     D X1              S           5000A
011000130620     D X2              S           5000A
011100130620     D HH              S           5000A
011200140815      *
011300130619     D LDES            S             10A
011400130619     D LEFF            S              8A
011500130619     D LENR            S              3A
011600130619     D LPLN            S              4A
011700130619     D LSRT            S              9A
011800130619     D LVOL            S              7A
011900140815     D LGRP            S             15A
012000140815     D LALT            S             20A
012100140815      *
012200140815     D @GRPID          S             15A
012300140815     D @ALTID          S             20A
012400140815     D @SMOKE          S              3A
012500140815      *
012600130617   X***X
012700140815       #ISO = %DATE;
012800140815     C                   MOVE      #ISO          #TODAY
012900130612      *
013000130620     C                   CLEAR                   IO01
013100130620     C                   EVAL      FILEX = 'A'
013200130620     C                   EVAL      DATEX = 'A'
013300130620     C                   EVAL      ADRX = 'A'
013400130620     C                   EVAL      GENX = 'A'
013500130620     C                   EVAL      RELX = 'A'
013600130620     C                   EVAL      NAMEX = 'A'
013700130620     C                   EVAL      TIERX = 'C'
013800130620     C                   EVAL      PHONX = 'A'
013900130620     C                   EVAL      AGEX = 'B'
014000130620     C                   EVAL      TERMX = 'B'
014100130710     C                   EVAL      MBRX = 'B'
014200130620      *
014300130617     C                   DOU       FKEY = F3
014400130617     C                   EXSR      $LOOP
014500130617     C                   ENDDO
014600130612      *
014700130620     C                   CLOSE     ELIGPULLA
014800130618      *
014900130618     C                   IF        FILEX = 'C'
015000130620     C                   CLOSE     ELIGPULLB
015100130618     C                   ENDIF
015200130618      *
015300130618     C                   EVAL      *INLR = *ON
015400130618     ***
015500130617     ***
015600130617     ***
015700130617     C     $LOOP         BEGSR
015800130617     ***
015900130617     C                   EVAL      EMSG = @EMSG
016000130617     C                   EXFMT     IO01
016100130617     C                   EVAL      @EMSG = *BLANKS
016200130617     ***
016300130617     C                   IF        FKEY = F3
016400130617     C                   LEAVESR
016500130617     C                   ENDIF
016600130617     ***
016700130617     C                   IF        FKEY = F12
016800130617     C                   EVAL      *IN25 = *OFF
016900130617     C                   LEAVESR
017000130617     C                   ENDIF
017100130617     ***
017200130617     C                   IF        FKEY = F10
017300130617     C                   EXSR      $RUN
017400130617     C                   EVAL      FKEY = F3
017500130617     C                   LEAVESR
017600130617     C                   ENDIF
017700130617     ***
017800130617     C                   IF        FILEX <> 'A' AND FILEX <> 'B' AND
017900130617     C                             FILEX <> 'C'
018000130617     C                   EVAL      @EMSG = 'INVALID FILE SELECTION'
018100130617     C                   LEAVESR
018200130617     C                   ENDIF
018300130617     ***
018400130617     C                   IF        DATEX <> 'A' AND DATEX <> 'B' AND
018500130617     C                             DATEX <> 'C' AND DATEX <> 'D'
018600130617     C                   EVAL      @EMSG = 'INVALID DATE SELECTION'
018700130617     C                   LEAVESR
018800130617     C                   ENDIF
018900130617     ***
019000130617     C                   IF        GENX <> 'A' AND GENX <> 'B'
019100130617     C                   EVAL      @EMSG = 'INVALID GENDER SELECTION'
019200130617     C                   LEAVESR
019300130617     C                   ENDIF
019400130617     ***
019500130620     C                   IF        AGEX <> 'A' AND AGEX <> 'B'
019600130620     C                   EVAL      @EMSG = 'INVALID AGE SELECTION'
019700130620     C                   LEAVESR
019800130620     C                   ENDIF
019900130620     ***
020000130617     C                   IF        NAMEX <> 'A' AND NAMEX <> 'B' AND
020100130617     C                             NAMEX <> 'C'
020200130617     C                   EVAL      @EMSG = 'INVALID NAME SELECTION'
020300130617     C                   LEAVESR
020400130617     C                   ENDIF
020500130617     ***
020600130617     C                   IF        ADRX <> 'A' AND ADRX <> 'B'
020700130617     C                   EVAL      @EMSG = 'INVALID ADDRESS SELECTION'
020800130617     C                   LEAVESR
020900130617     C                   ENDIF
021000130617     ***
021100130710     C                   IF        MBRX <> 'A' AND MBRX <> 'B'
021200130710     C                   EVAL      @EMSG = 'INVALID MBR SSN SELECTION'
021300130710     C                   LEAVESR
021400130710     C                   ENDIF
021500130710     ***
021600130617     C                   IF        PHONX <> 'A' AND PHONX <> 'B' AND
021700130617     C                             PHONX <> 'C'
021800130617     C                   EVAL      @EMSG = 'INVALID PHONE SELECTION'
021900130617     C                   LEAVESR
022000130617     C                   ENDIF
022100130617     ***
022200130617     C                   IF        RELX <> 'A' AND RELX <> 'B' AND
022300130710     C                             RELX <> 'C' AND RELX <> 'D' AND
022400130710     C                             RELX <> 'E' AND RELX <> 'F'
022500130617     C                   EVAL      @EMSG = 'INVALID RELATIONSHIP CODE SELECTION'
022600130617     C                   LEAVESR
022700130617     C                   ENDIF
022800130617     ***
022900130617     C                   IF        TIERX <> 'A' AND TIERX <> 'B' AND
023000130816     C                             TIERX <> 'C' AND TIERX <> 'L'
023100130617     C                   EVAL      @EMSG = 'INVALID TIER SELECTION'
023200130617     C                   LEAVESR
023300130617     C                   ENDIF
023400130621     ***
023500130621     C                   IF        MEDX <> 'X' AND MEDX <> *BLANKS
023600130621     C                   EVAL      @EMSG = 'INVALID MED SELECTION'
023700130621     C                   LEAVESR
023800130621     C                   ENDIF
023900130617     ***
024000130621     C                   IF        RXDX <> 'X' AND RXDX <> *BLANKS
024100130621     C                   EVAL      @EMSG = 'INVALID RXD SELECTION'
024200130621     C                   LEAVESR
024300130621     C                   ENDIF
024400130621     ***
024500130621     C                   IF        DENX <> 'X' AND DENX <> *BLANKS
024600130621     C                   EVAL      @EMSG = 'INVALID DEN SELECTION'
024700130621     C                   LEAVESR
024800130621     C                   ENDIF
024900130621     ***
025000130621     C                   IF        VISX <> 'X' AND VISX <> *BLANKS
025100130621     C                   EVAL      @EMSG = 'INVALID VIS SELECTION'
025200130621     C                   LEAVESR
025300130621     C                   ENDIF
025400130621     ***
025500130621     C                   IF        ADDX <> 'X' AND ADDX <> *BLANKS
025600130621     C                   EVAL      @EMSG = 'INVALID ADD SELECTION'
025700130621     C                   LEAVESR
025800130621     C                   ENDIF
025900130621     ***
026000130621     C                   IF        LIFX <> 'X' AND LIFX <> *BLANKS
026100130621     C                   EVAL      @EMSG = 'INVALID LIF SELECTION'
026200130621     C                   LEAVESR
026300130621     C                   ENDIF
026400130621     ***
026500130621     C                   IF        DEPX <> 'X' AND DEPX <> *BLANKS
026600130621     C                   EVAL      @EMSG = 'INVALID DEP SELECTION'
026700130621     C                   LEAVESR
026800130621     C                   ENDIF
026900130621     ***
027000130621     C                   IF        EAPX <> 'X' AND EAPX <> *BLANKS
027100130621     C                   EVAL      @EMSG = 'INVALID EAP SELECTION'
027200130621     C                   LEAVESR
027300130621     C                   ENDIF
027400130621     ***
027500130621     C                   IF        STDX <> 'X' AND STDX <> *BLANKS
027600130621     C                   EVAL      @EMSG = 'INVALID STD SELECTION'
027700130621     C                   LEAVESR
027800130621     C                   ENDIF
027900130621     ***
028000130621     C                   IF        LTDX <> 'X' AND LTDX <> *BLANKS
028100130621     C                   EVAL      @EMSG = 'INVALID LTD SELECTION'
028200130621     C                   LEAVESR
028300130621     C                   ENDIF
028400130621     ***
028500130621     C                   IF        FSAX <> 'X' AND FSAX <> *BLANKS
028600130621     C                   EVAL      @EMSG = 'INVALID FSA SELECTION'
028700130621     C                   LEAVESR
028800130621     C                   ENDIF
028900130621     ***
029000130621     C                   IF        MEDX = *BLANKS AND RXDX = *BLANKS AND
029100130621     C                             DENX = *BLANKS AND EAPX = *BLANKS AND
029200130621     C                             VISX = *BLANKS AND STDX = *BLANKS AND
029300130621     C                             ADDX = *BLANKS AND LTDX = *BLANKS AND
029400130621     C                             LIFX = *BLANKS AND FSAX = *BLANKS AND
029500130621     C                             DEPX = *BLANKS
029600130621     C                   EVAL      @EMSG = 'MINIMUM 1 PRODUCT SELECTION'
029700130621     C                   LEAVESR
029800130621     C                   ENDIF
029900130621     ***
030000130617     C                   IF        TERMX <> 'A' AND TERMX <> 'B'
030100130617     C                   EVAL      @EMSG = 'INVALID TERM SELECTION'
030200130617     C                   LEAVESR
030300130617     C                   ENDIF
030400130617     ***
030500130617     C                   IF        TRSX = 0 OR SUBX = 0 OR ACCX = 0
030600130617     C                   EVAL      @EMSG = 'FULL ACCOUNT # REQUIRED'
030700130617     C                   LEAVESR
030800130617     C                   ENDIF
030900130617     ***
031000130619     C*                  EVAL      KT = TRSX
031100130619     C*                  EVAL      KS = SUBX
031200130619     C*                  EVAL      KA = ACCX
031300130617     C     KL#TSA        CHAIN     ACCMSR
031400130617     C                   IF        NOT %FOUND(ACMUNIQUE)
031500130617     C                   EVAL      @EMSG = 'INVALID ACCOUNT NUMBER'
031600130617     C                   LEAVESR
031700130617     C                   ENDIF
031800130617     ***
031900130617     C                   IF        TERMX = 'A' AND TERMDT = 0
032000130617     C                   EVAL      @EMSG = 'ACCOUNT IS ACTIVE; TERM REQ INVALID'
032100130617     C                   LEAVESR
032200130617     C                   ENDIF
032300130617     ***
032400130617     C                   IF        TERMX = 'B' AND TERMDT > 0
032500130617     C                   EVAL      @EMSG = 'ACCOUNT IS TERMED; TERM REQ INVALID'
032600130617     C                   LEAVESR
032700130617     C                   ENDIF
032800130618     ***
032900130618     C                   IF        TERMX = 'A'
033000130618     C     *USA          TEST(DE)                XTD
033100130618     C                   IF        %ERROR
033200130618     C                   EVAL      @EMSG = 'INVALID TERM DATE'
033300130618     C                   LEAVESR
033400130618     C                   ENDIF
033500130618     C     XTD           MULT      10000.0001    #XTD
033600130618     C                   ENDIF
033700130617     ***
033800130617     C                   EVAL      *IN25 = *ON
033900130617     ***
034000130617     C                   ENDSR
034100130617     ***
034200130617     ***
034300130617     C     $RUN          BEGSR
034400130618     ***
034500130617     C                   EXSR      $FINDPLAN
034600130618     ***
034700130620     C                   OPEN      ELIGPULLA
034800130617     C                   IF        FILEX = 'C'
034900130620     C                   OPEN      ELIGPULLB
035000130617     C                   ENDIF
035100130618     ***
035200130618     C                   EXSR      $HDGS
035300130618     ***
035400130617     C     KL#TSA        SETLL     MEMBR
035500130618     ***
035600130618     C                   DOU       %EOF(MEMAC#1)
035700130617     C                   EXSR      $MBRPULL
035800130618     C                   ENDDO
035900130618     ***
036000130617     C                   ENDSR
036100130617     ***
036200130617     ***
036300130617     C     $MBRPULL      BEGSR
036400130618     ***
036500130618     C     KL#TSA        READE     MEMBR
036600130618     ***
036700130618     C                   IF        %EOF(MEMAC#1)
036800130618     C                   LEAVESR
036900130618     C                   ENDIF
037000130618     ***
037100130618     C                   IF        TERMX = 'B' AND TERMDT > 0
037200130618     C                   LEAVESR
037300130618     C                   ENDIF
037400130618     ***
037500130618     C                   IF        TERMX = 'A' AND TERMDT < #XTD
037600130618     C                   LEAVESR
037700130618     C                   ENDIF
037800130618     ***
037900130618     C                   MOVE      *ZEROS        KSQ
038000130618     C     KL#MCVC       CHAIN     MCOVR
038100130618     C                   IF        NOT %FOUND(MCOVC)
038200130618     C                   LEAVESR
038300130618     C                   ENDIF
038400130618     ***
038500130618     C                   EXSR      $CLRSTG
038600130618     ***
038700130618     C     KL#MCVC       SETLL     MCOVR
038800130618     ***
038900130620     C                   DOU       %EOF(MCOVC)
039000130618     C                   EXSR      $MCVPULL
039100130618     C                   ENDDO
039200130619     ***
039300130619     C                   IF        #C = 0
039400130619     C                   LEAVESR
039500130619     C                   ENDIF
039600130618     ***
039700130618     C                   EXSR      $PREPMBR
039800130618     C                   EXSR      $SORT
039900130618     C                   EXSR      $GEN
040000130619     ***
040100130619     C                   EXSR      $DEPCTL
040200130618     ***
040300130618     C                   ENDSR
040400130618     ***
040500130618     ***
040600130618     C     $CLRSTG       BEGSR
040700130618     ***
040800130618     C                   EVAL      #N = 0
040900130618     ***
041000130618     C                   DO        200
041100130618     C                   ADD       1             #N
041200130618     C     #N            OCCUR     DS@PLN
041300130618     C                   CLEAR                   DS@PLN
041400130618     C     #N            OCCUR     S1@PLN
041500130618     C                   CLEAR                   S1@PLN
041600130618     C                   ENDDO
041700130618     ***
041800130619     C                   EVAL      COMP@ = *BLANKS
041900130618     C                   EVAL      #C = 0
042000130618     C                   EVAL      #N = 0
042100130619     C                   EVAL      X = 0
042200130619     C                   EVAL      Y = 0
042300130619     C                   EVAL      S = 0
042400130618     ***
042500130618     C                   ENDSR
042600130618     ***
042700130618     ***
042800130618     C     $MCVPULL      BEGSR
042900130618     ***
043000130618     C     KL#MCVC       READE     MCOVR
043100130618     ***
043200130618     C                   IF        %EOF(MCOVC)
043300130618     C                   LEAVESR
043400130618     C                   ENDIF
043500130618     ***
043600130618     C                   IF        TERMX = 'B' AND CANDT > 0
043700130618     C                   LEAVESR
043800130618     C                   ENDIF
043900130618     ***
044000130618     C                   IF        TERMX = 'A' AND CANDT < #XTD
044100130618     C                   LEAVESR
044200130618     C                   ENDIF
044300130618     ***
044400130618     C     MCPLAN        CHAIN     WKF
044500130618     ***
044600130618     C                   IF        NOT %FOUND(ELIGPULLW1)
044700130618     C                   LEAVESR
044800130618     C                   ENDIF
044900130618     ***
045000140815       IF WDESC = 'MEDICAL';
045100140815          EXSR $ALTID;
045200140815       ELSE;
045300140815          @ALTID = *BLANKS;
045400140815       ENDIF;
045500140815     ***
045600140815       EXSR $CARGRP;
045700140815     ***
045800130618     C                   EVAL      LSRT = WSORT
045900130618     C                   EVAL      LPLN = MCPLAN
046000130618     C                   EVAL      LENR = MCOVTP
046100130618     C                   EVAL      LEFF = %CHAR(ENRLDT)
046200130618     C                   EVAL      LDES = WDESC
046300130618     C                   EVAL      LVOL = %EDITC(BENAMT:'X')
046400140815     C                   EVAL      LGRP = @GRPID
046500140815     C                   EVAL      LALT = @ALTID
046600130618     C                   EXSR      $ADDCHK
046700130618     ***
046800130618     C                   ENDSR
046900130618     ***
047000140815     ***
047100140815     C     $CARGRP       BEGSR
047200140815     ***
047300140815       @GRPID = *BLANKS;
047400140815     ***
047500140815       CHAIN (MCTRST:MCSUB#:MCPLAN:MCAGEB:MCOVTP) GRATER;
047600140815       IF NOT %FOUND(GRATEX);
047700140815          LEAVESR;
047800140815       ENDIF;
047900140815     ***
048000140815       SETLL (MCTRST:MCSUB#:MCPLAN:MCAGEB:MCOVTP) GRATER;
048100140815       DOU %EOF(GRATEX);
048200140815          READE (MCTRST:MCSUB#:MCPLAN:MCAGEB:MCOVTP) GRATER;
048300140815          IF NOT %EOF(GRATEX);
048400140815             IF TERMX = 'B';
048500140815                IF #TODAY >= FRMDAT AND #TODAY <= TODAT;
048600140815                   @GRPID = GROUP#;
048700140815                   LEAVESR;
048800140815                ENDIF;
048900140815             ELSE;
049000140815                IF #XTD >= FRMDAT AND #XTD <= TODAT;
049100140815                   @GRPID = GROUP#;
049200140815                   LEAVESR;
049300140815                ENDIF;
049400140815             ENDIF;
049500140815          ENDIF;
049600140815       ENDDO;
049700140815     ***
049800140815     C                   ENDSR
049900140815     ***
050000140815     ***
050100140815     C     $ALTID        BEGSR
050200140815     ***
050300140815       @ALTID = *BLANKS;
050400140815     ***
050500140815       CHAIN (PCARR) CARMSR;
050600140815       IF NOT %FOUND(CARUNIQUE);
050700140815          LEAVESR;
050800140815       ENDIF;
050900140815     ***
051000140815       CHAIN (MBSSNO) MEMALTR;
051100140815       IF NOT %FOUND(MEMALTL3);
051200140815          LEAVESR;
051300140815       ENDIF;
051400140815     ***
051500140815       SETLL (MBSSNO) MEMALTR;
051600140815       DOU %EOF(MEMALTL3);
051700140815          READE (MBSSNO) MEMALTR;
051800140815          IF NOT %EOF(MEMALTL3);
051900140815             IF CGRPCD <> 'CF';
052000140815                IF MAALTTP = CGRPCD;
052100140815                   @ALTID = MAALTID;
052200140815                   LEAVESR;
052300140815                ENDIF;
052400140815             ELSE;
052500140815                IF MAALTTP = 'CFSX' OR MAALTTP = '00' OR
052600140815                     MAALTTP = '01' OR MAALTTP = '08';
052700140815                   @ALTID = MAALTID;
052800140815                   LEAVESR;
052900140815                ENDIF;
053000140815             ENDIF;
053100140815          ENDIF;
053200140815       ENDDO;
053300140815     ***
053400140815     C                   ENDSR
053500140815     ***
053600130618     ***
053700130618     C     *INZSR        BEGSR
053800130618     ***
053900130618     C     KL#MCVC       KLIST
054000130618     C                   KFLD                    MBSSNO
054100130618     C                   KFLD                    KSQ
054200130618     C                   KFLD                    MBTRST
054300130618     C                   KFLD                    MBSUB#
054400130618     ***
054500130618     C     KL#TSA        KLIST
054600130618     C                   KFLD                    TRSX
054700130618     C                   KFLD                    SUBX
054800130618     C                   KFLD                    ACCX
054900130619     C     KL#TSP        KLIST
055000130619     C                   KFLD                    CMTRST
055100130619     C                   KFLD                    CSUBDV
055200130619     C                   KFLD                    CMPLAN
055300130620     ***
055400130620     C                   EVAL      #TD = %DATE
055500130618     ***
055600130617     C                   ENDSR
055700130617     ***
055800130617     ***
055900130618     C     $ADDCHK       BEGSR
056000130618     ***
056100130618     C                   IF        #C = 0
056200130618     C                   EXSR      $ADDOCC
056300130618     C                   LEAVESR
056400130618     C                   ENDIF
056500130618     ***
056600130618     C                   EVAL      #N = 0
056700130618     C                   DO        #C
056800130618      *
056900130618     C                   ADD       1             #N
057000130618     C     #N            OCCUR     DS@PLN
057100130618      *
057200130618     C                   IF        PLN@ = LPLN
057300130618     C                   LEAVESR
057400130618     C                   ENDIF
057500130618      *
057600130618     C                   IF        %SUBST(LSRT:1:2) = '01' OR
057700130618     C                             %SUBST(LSRT:1:2) = '02' OR
057800130618     C                             %SUBST(LSRT:1:2) = '03' OR
057900140815     C                             %SUBST(LSRT:1:2) = '04'
058000140815     C*                            %SUBST(LSRT:3:3) = 'EAP'
058100130618      * *
058200130618     C                   IF        %SUBST(LSRT:1:2) = %SUBST(SRT@:1:2)
058300130618     C                   LEAVESR
058400130618     C                   ENDIF
058500130618      * *
058600130618     C                   ELSE
058700130618      * *
058800130618     C                   IF        %SUBST(LSRT:1:5) = %SUBST(SRT@:1:5)
058900130618     C                   LEAVESR
059000130618     C                   ENDIF
059100130618      * *
059200130618     C                   ENDIF
059300130618      *
059400130618     C                   ENDDO
059500130618     ***
059600130618     C                   EXSR      $ADDOCC
059700130618     ***
059800130618     C                   EVAL      #N = 0
059900130618     ***
060000130617     C                   ENDSR
060100130617     ***
060200130617     ***
060300130618     C     $ADDOCC       BEGSR
060400130618     ***
060500130618     C                   ADD       1             #C
060600130618     ***
060700130618     C     #C            OCCUR     DS@PLN
060800130618     ***
060900130618     C                   EVAL      SRT@ = LSRT
061000130618     C                   EVAL      PLN@ = LPLN
061100130618     C                   EVAL      ENR@ = LENR
061200130618     C                   EVAL      EFF@ = LEFF
061300130618     C                   EVAL      DES@ = LDES
061400130618     C                   EVAL      VOL@ = LVOL
061500140815     C                   EVAL      ALT@ = LALT
061600140815     C                   EVAL      GRP@ = LGRP
061700130618     ***
061800130617     C                   ENDSR
061900130617     ***
062000130617     ***
062100130618     C     $PREPMBR      BEGSR
062200130618     ***
062300140815       EXSR $SMOKER;
062400140815     ***
062500130618     C                   EVAL      X1 = '"' + %EDITC(MBSSNO:'X') + '",'
062600130618     ***
062700130618     C                   EVAL      HH = *BLANKS
062800130618     C                   SELECT
062900130618      * *
063000130618     C                   WHEN      NAMEX = 'A'
063100130618     C                   EVAL      HH = '"' + %TRIM(MFNAME) + Q + %TRIM(MMI) +
063200130618     C                             Q + %TRIM(MLNAME) + '",'
063300130618      * *
063400130618     C                   WHEN      NAMEX = 'B'
063500130618     C                   EVAL      HH = '"' + %TRIM(MLNAME) + ', ' +
063600130618     C                             %TRIM(MFNAME) + ' ' + MMI
063700130618     C                   EVAL      HH = %TRIM(HH) + '",'
063800130618      * *
063900130618     C                   WHEN      NAMEX = 'C'
064000130618     C                   EVAL      HH = '"' + %TRIM(MFNAME) + ' ' + %TRIM(MMI)
064100130618     C                   EVAL      HH = %TRIM(HH) + ' ' + %TRIM(MLNAME) + '",'
064200130618      * *
064300130618     C                   ENDSL
064400130618      * *
064500130618     C                   EVAL      X1 = %TRIM(X1) + %TRIM(HH)
064600130618     ***
064700130710     C                   IF        MBRX = 'B'
064800130618     C                   EVAL      X1 = %TRIM(X1) + '"' +
064900130618     C                             %EDITC(MBSSNO:'X') + '",'
065000130710     C                   ELSE
065100130710     C                   EVAL      X1 = %TRIM(X1) + ','
065200130710     C                   ENDIF
065300130618     ***
065400130618     C                   EVAL      HH = *BLANKS
065500130618     C                   SELECT
065600130618     C                   WHEN      RELX = 'A'
065700130618     C                   EVAL      HH = 'MEMBER'
065800130618     C                   WHEN      RELX = 'B'
065900130618     C                   EVAL      HH = 'EMPLOYEE'
066000130618     C                   WHEN      RELX = 'C'
066100130618     C                   EVAL      HH = 'EE'
066200130618     C                   WHEN      RELX = 'D'
066300130618     C                   EVAL      HH = *BLANKS
066400130618     C                   WHEN      RELX = 'E'
066500130618     C                   EVAL      HH = 'E'
066600130710     C                   WHEN      RELX = 'F'
066700130710     C                   EVAL      HH = 'E'
066800130618     C                   ENDSL
066900130618     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
067000130618     ***
067100130618     C                   EVAL      HH = *BLANKS
067200130618     C                   SELECT
067300130618     C                   WHEN      GENX = 'A'
067400130618     C                   EVAL      HH = SEX
067500130618     C                   WHEN      GENX = 'B' AND SEX = 'M'
067600130618     C                   EVAL      HH = 'MALE'
067700130618     C                   WHEN      GENX = 'B' AND SEX = 'F'
067800130618     C                   EVAL      HH = 'FEMALE'
067900130618     C                   ENDSL
068000130618     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
068100130618     ***
068200130618     C                   EVAL      #XSX = BIRTH
068300130618     C                   EXSR      $DATE
068400130618     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
068500140815     ***
068600140815     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(@SMOKE) + '",'
068700130620     ***
068800130620     C                   IF        AGEX = 'A'
068900130620     C                   MOVE      BIRTH         #ISO
069000130620     C                   MOVE      *ZEROS        AGE               3 0
069100130620     C                   EVAL      AGE = %DIFF(#TD:#ISO:*Y)
069200130620     C                   EVAL      X1 = %TRIM(X1) + '"' + %EDITC(AGE:'X') + '",'
069300130620     C                   ENDIF
069400130618     ***
069500130618     C                   EVAL      HH = *BLANKS
069600130618     C                   SELECT
069700130618     C                   WHEN      ADRX = 'A'
069800130618     C                   EVAL      HH = %TRIM(ADDR1) + Q + %TRIM(ADDR2)
069900130620     C                   WHEN      ADRX = 'B'
070000130618     C                   EVAL      HH = %TRIM(ADDR1) + ' ' + %TRIM(ADDR2)
070100130618     C                   ENDSL
070200130618     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
070300130618     ***
070400130619     C                   EVAL      HH = %EDITC(ZIP:'X')
070500130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(CITY) + Q +
070600130619     C                             %TRIM(STATE) + Q + %SUBST(HH:1:5) + '",'
070700130619     ***
070800130619     C                   SELECT
070900130619     C                   WHEN      PHONX = 'A'
071000130619     C                   EVAL      HH = %EDITC(AREA:'X') + Q +
071100130619     C                             %EDITC(PHONE:'X')
071200130619     C                   WHEN      PHONX = 'B'
071300130619     C                   EVAL      HH = %EDITC(AREA:'X') +
071400130619     C                             %EDITC(PHONE:'X')
071500130619     C                   WHEN      PHONX = 'C'
071600130620     C                   EVAL      HH = '(' + %EDITC(AREA:'X') + ')' +
071700130619     C                             %EDITW(PHONE:'0   -    ')
071800130619     C                   ENDSL
071900130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
072000130619     ***
072100130619     C                   EVAL      #XSX = EMPDT
072200130619     C                   EXSR      $DATE
072300130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
072400130619     ***
072500130619     C                   SELECT
072600130619     C                   WHEN      EMPST = 'A'
072700130619     C                   EVAL      HH = 'ACTIVE'
072800130619     C                   WHEN      EMPST = 'C'
072900130619     C                   EVAL      HH = 'COBRA'
073000130619     C                   OTHER
073100130619     C                   EVAL      HH = 'UNKNOWN'
073200130619     C                   ENDSL
073300130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
073400130916     ***
073500130916     C                   MOVE      *BLANKS       SAL              20
073600130916     C                   EVAL      SAL = %EDITC(SALARY:'X')
073700140319     C                   EVAL      X1 = %TRIM(X1) + %TRIM(SAL) + ',"00",'
073800130618     ***
073900130617     C                   ENDSR
074000140815     ***
074100140815     ***
074200140815     C     $SMOKER       BEGSR
074300140815     ***
074400140815       @SMOKE = 'NO';
074500140815       CHAIN (MBSSNO:KSQ) SMOKER;
074600140815       IF NOT %FOUND(SMOKE);
074700140815          LEAVESR;
074800140815       ENDIF;
074900140815       SETLL (MBSSNO:KSQ) SMOKER;
075000140815       DOU %EOF(SMOKE);
075100140815          READE (MBSSNO:KSQ) SMOKER;
075200140815          IF NOT %EOF(SMOKE);
075300140815             IF SKRATETO = 0;
075400140815                SMOKE#TO = 99999999;
075500140815             ELSE;
075600140815                SMOKE#TO = SKRATETO;
075700140815             ENDIF;
075800140815             IF SKRATEFR <= #TODAY AND SMOKE#TO >= #TODAY;
075900140815                @SMOKE = 'YES';
076000140815                LEAVESR;
076100140815             ENDIF;
076200140815          ENDIF;
076300140815       ENDDO;
076400140815     ***
076500140815     *** MBSSNO
076600140815     *** KSQ
076700140815     C                   ENDSR
076800140815     ***
076900140815     ***
077000140815     ***
077100140815     ***
077200130617     ***
077300130618     C     $DATE         BEGSR
077400130618     ***
077500130618     C                   EVAL      HH = *BLANKS
077600130618     C                   SELECT
077700130618      * *
077800130618     C                   WHEN      DATEX = 'A'
077900130618     C     #XSX          MULT      10000.0001    #8
078000130618     C                   EVAL      HH = %EDITC(#8:'Y')
078100130618      * *
078200130618     C                   WHEN      DATEX = 'B'
078300130618     C     #XSX          MULT      10000.0001    #8
078400130618     C                   EVAL      HH = %EDITC(#8:'X')
078500130618      * *
078600130618     C                   WHEN      DATEX = 'C'
078700130620     C                   EVAL      HH = %EDITW(#XSX:'    /  /  ')
078800130618      * *
078900130618     C                   WHEN      DATEX = 'D'
079000130618     C                   EVAL      HH = %EDITC(#XSX:'X')
079100130618      * *
079200130618     C                   ENDSL
079300130618     ***
079400130618     C                   ENDSR
079500130618     ***
079600130618     ***
079700130618     C     $HDGS         BEGSR
079800130618     ***
079900130618     C                   EVAL      X1 = '"ELIGIBILITY PULL FOR: ' +
080000130618     C                             %EDITC(ACTRST:'X') + '-' +
080100130618     C                             %EDITC(ACSUB#:'X') + '-' +
080200130618     C                             %EDITC(ACACCT:'X') + '-' +
080300130618     C                             %TRIM(ACNAM1) + '"'
080400130618     ***
080500130618      *
080600130618     C                   IF        FILEX = 'C'
080700130618     C                   EVAL      X2 = %TRIM(X1)
080800130618     C                   EXCEPT    OUTF2
080900130618     C                   EVAL      X2 = ','
081000130618     C                   EXCEPT    OUTF2
081100130618     C                   EVAL      X2 = ','
081200130618     C                   EXCEPT    OUTF2
081300130618     C                   ENDIF
081400130618      *
081500130618     C                   EXCEPT    OUTF1
081600130618     C                   EVAL      X1 = ','
081700130618     C                   EXCEPT    OUTF1
081800130618     C                   EVAL      X1 = ','
081900130618     C                   EXCEPT    OUTF1
082000130618     ***
082100130618     C                   EVAL      X1 = '"MEMBER ID",'
082200130618     ***
082300130618     C                   IF        NAMEX = 'A'
082400130618     C                   EVAL      X1 = %TRIM(X1) + '"FIRST NAME","MI","LAST",'
082500130618     C                   ELSE
082600130618     C                   EVAL      X1 = %TRIM(X1) + '"NAME",'
082700130618     C                   ENDIF
082800130618     ***
082900130618     C                   EVAL      X1 = %TRIM(X1) + '"SSN","RELATIONSHIP","GE' +
083000140815     C                             'NDER","DATE OF BIRTH","SMOKER",'
083100130620     ***
083200130620     C                   IF        AGEX = 'A'
083300130620     C                   EVAL      X1 = %TRIM(X1) + '"AGE",'
083400130620     C                   ENDIF
083500130618     ***
083600130618     C                   IF        ADRX = 'A'
083700130618     C                   EVAL      X1 = %TRIM(X1) + '"ADDRESS 1","ADDRESS 2",'
083800130618     C                   ELSE
083900130618     C                   EVAL      X1 = %TRIM(X1) + '"ADDRESS",'
084000130618     C                   ENDIF
084100130618     ***
084200130618     C                   EVAL      X1 = %TRIM(X1) + '"CITY","STATE","ZIP",'
084300130618     ***
084400130618     C                   IF        PHONX = 'A'
084500130618     C                   EVAL      X1 = %TRIM(X1) + '"AREA CODE","PHONE NUMBE' +
084600130618     C                             'R",'
084700130618     C                   ELSE
084800130618     C                   EVAL      X1 = %TRIM(X1) + '"PHONE NUMBER",'
084900130618     C                   ENDIF
085000130618     ***
085100130618     C                   EVAL      X1 = %TRIM(X1) + '"HIRE DATE","STATUS",'
085200140319     C                             + '"SALARY","SEQ",'
085300130618     ***
085400130618     C                   MOVE      *ALL'0'       @9                9
085500130620     C                   MOVE      'NNNNN'       P@O               5            PRT ONCE CTL
085600130618     ***
085700130618     C     @9            SETLL     WKF2
085800130618     C                   DOU       %EOF(ELIGPULLWL)
085900130618     C                   READ      WKF2
086000130618     C                   IF        NOT %EOF(ELIGPULLWL)
086100130618      * *
086200130618     C                   SELECT
086300130618      * *
086400130618     C                   WHEN      %SUBST(YSORT:1:2) = '01'
086500130620     C                   IF        %SUBST(P@O:1:1) = 'N'
086600130620     C                   EVAL      %SUBST(P@O:1:1) = 'Y'
086700130618     C                   EVAL      X1 = %TRIM(X1) + '"MED PLAN","MED TIER","M' +
086800140815     C                             'ED DESC","MED EFF DATE","ALT ID","GROUP#",'
086900130620     C                   ENDIF
087000130618      * *
087100130618     C                   WHEN      %SUBST(YSORT:1:2) = '02'
087200130620     C                   IF        %SUBST(P@O:2:1) = 'N'
087300130620     C                   EVAL      %SUBST(P@O:2:1) = 'Y'
087400130618     C                   EVAL      X1 = %TRIM(X1) + '"RXD PLAN","RXD TIER","R' +
087500160719     C                             'XD DESC","RXD EFF DATE","GROUP#",'
087600160719     C****                         'XD DESC","RXD EFF DATE","ALT ID","GROUP#",'
087700130620     C                   ENDIF
087800130618      * *
087900130618     C                   WHEN      %SUBST(YSORT:1:2) = '03'
088000130620     C                   IF        %SUBST(P@O:3:1) = 'N'
088100130620     C                   EVAL      %SUBST(P@O:3:1) = 'Y'
088200130618     C                   EVAL      X1 = %TRIM(X1) + '"DEN PLAN","DEN TIER","D' +
088300140815     C                             'EN DESC","DEN EFF DATE","GROUP#",'
088400130620     C                   ENDIF
088500130618      * *
088600130618     C                   WHEN      %SUBST(YSORT:1:2) = '04'
088700130620     C                   IF        %SUBST(P@O:4:1) = 'N'
088800130620     C                   EVAL      %SUBST(P@O:4:1) = 'Y'
088900130618     C                   EVAL      X1 = %TRIM(X1) + '"VIS PLAN","VIS TIER","V' +
089000140815     C                             'IS DESC","VIS EFF DATE","GROUP#",'
089100130620     C                   ENDIF
089200130618      * *
089300140815     C                   WHEN      %SUBST(YSORT:3:3) = 'EAP'
089400130620     C                   IF        %SUBST(P@O:5:1) = 'N'
089500130620     C                   EVAL      %SUBST(P@O:5:1) = 'Y'
089600130618     C                   EVAL      X1 = %TRIM(X1) + '"EAP PLAN","EAP TIER","E' +
089700140815     C                             'AP DESC","EAP EFF DATE","GROUP#",'
089800130620     C                   ENDIF
089900130618      * *
090000130618     C                   OTHER
090100130618     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(YDESC) + ' PL' +
090200130618     C                             'AN","' + %TRIM(YDESC) + ' TIER","' +
090300130618     C                             %TRIM(YDESC) + ' DESC","' +
090400130618     C                             %TRIM(YDESC) + ' EFF DATE","' +
090500140815     C                             %TRIM(YDESC) + ' VOLUME","' +
090600140815     C                             %TRIM(YDESC) + ' GROUP#",'
090700140815      * *
090800130618     C                   ENDSL
090900130618      * *
091000130618     C                   ENDIF
091100130618     C                   ENDDO
091200130618     ***
091300130620     C                   SELECT
091400130620     C                   WHEN      FILEX = 'A'
091500130620     C                   EXCEPT    OUTF1
091600130620     C                   WHEN      FILEX = 'B'
091700130620     C                   MOVE      *BLANKS       M1
091800130620     C                   EVAL      M1 = %TRIM(X1)
091900130620     C                   EVAL      X1 = %TRIM(X1) + %TRIM(M1)
092000130620     C                   EXCEPT    OUTF1
092100130620     C                   WHEN      FILEX = 'C'
092200130620     C                   EVAL      X2 = %TRIM(X1)
092300130620     C                   EXCEPT    OUTF2
092400130620     C                   EXCEPT    OUTF1
092500130620     C                   ENDSL
092600130618     ***
092700130617     C                   ENDSR
092800130617     ***
092900130617     ***
093000130617     C     $FINDPLAN     BEGSR
093100130618     ***
093200130619     C**                 EVAL      #CTL = 0
093300140815     C                   Z-ADD     5             ##COL             2 0
093400130617     ***
093500130617     C     KL#TSA        SETLL     COMCXR
093600130617     C                   DOU       %EOF(COMCTUNIQ)
093700130617     C     KL#TSA        READE     COMCXR
093800130617     C                   IF        NOT %EOF(COMCTUNIQ)
093900130617     ***
094000130618     C                   IF        (TERMX = 'A' AND CMCAN < #XTD) OR
094100130618     C                             (TERMX = 'B' AND CMCAN > 0)
094200130617     C                   ITER
094300130617     C                   ENDIF
094400130617     ***
094500130617     C     KL#TSP        CHAIN     PLNMSR
094600140319     ***
094700131119     C*                  IF        PCARR = 'NAB'
094800131119     C*                  ITER
094900131119     C*                  ENDIF
095000130617     ***
095100140319     C                   IF        PLNCAT = 'P1P' OR PLNCAT = 'P2P' OR
095200140319     C                             PLNCAT = 'P3P'
095300140319     C                   ITER
095400140319     C                   ENDIF
095500140319     ***
095600130617     C     PLNCAT        CHAIN     CODESR
095700130617     ***
095800130617     C                   SELECT
095900140815     ****
096000140815     C                   WHEN      ACTION = 'M' AND MEDX = 'X'
096100140815     C                   EVAL      @SORT = '01' + PLPLAN
096200140815     C                   EXSR      $ACCUM
096300140815     ****
096400140815     C                   WHEN      ACTION = 'R' AND RXDX = 'X'
096500140815     C                   EVAL      @SORT = '02' + PLPLAN
096600140815     C                   EXSR      $ACCUM
096700140815     ****
096800140815     C                   WHEN      ACTION = 'D' AND DENX = 'X'
096900140815     C                   EVAL      @SORT = '03' + PLPLAN
097000140815     C                   EXSR      $ACCUM
097100140815     ****
097200140815     C                   WHEN      ACTION = 'V' AND VISX = 'X'
097300140815     C                   EVAL      @SORT = '04' + PLPLAN
097400140815     C                   EXSR      $ACCUM
097500140815     ****
097600130617     C                   WHEN      ACTION = 'A' AND ADDX = 'X'
097700140815     C                   EXSR      $NXTNO
097800140815     C                   EVAL      @SORT = @@COL + PLNCAT + PLPLAN
097900130617     C                   EXSR      $ACCUM
098000140815     ****
098100140815     C                   WHEN      ACTION = 'C' AND EAPX = 'X'
098200140815     C                   EXSR      $NXTNO
098300140815     C                   EVAL      @SORT = @@COL + 'EAP' + PLPLAN
098400140815     C                   EXSR      $ACCUM
098500140815     ****
098600140815     C                   WHEN      ACTION = 'L' AND LIFX = 'X'
098700140815     C                   EXSR      $NXTNO
098800140815     C                   EVAL      @SORT = @@COL + PLNCAT + PLPLAN
098900140815     C                   EXSR      $ACCUM
099000140815     ****
099100130617     C                   WHEN      ACTION = 'E' AND DEPX = 'X'
099200140815     C                   EXSR      $NXTNO
099300140815     C                   EVAL      @SORT = @@COL + PLNCAT + PLPLAN
099400130617     C                   EXSR      $ACCUM
099500140815     ****
099600130617     C                   WHEN      ACTION = 'S' AND STDX = 'X'
099700140815     C                   EXSR      $NXTNO
099800140815     C                   EVAL      @SORT = @@COL + PLNCAT + PLPLAN
099900130617     C                   EXSR      $ACCUM
100000140815     ****
100100130617     C                   WHEN      ACTION = 'T' AND LTDX = 'X'
100200140815     C                   EXSR      $NXTNO
100300140815     C                   EVAL      @SORT = @@COL + PLNCAT + PLPLAN
100400130617     C                   EXSR      $ACCUM
100500140815     ****
100600140815     C                   WHEN      ACTION = 'F' AND FSAX = 'X'
100700140815     C                   EXSR      $NXTNO
100800140815     C                   EVAL      @SORT = @@COL + PLNCAT + PLPLAN
100900140815     C                   EXSR      $ACCUM
101000140815     ****
101100130617     C                   ENDSL
101200130617     ***
101300130617     C                   ENDIF
101400130617     C                   ENDDO
101500130617     ***
101600130617     C                   ENDSR
101700130617     ***
101800130617     ***
101900140815     C     $NXTNO        BEGSR
102000130617     ***
102100140815       ##COL+=1;
102200140815     C                   MOVE      ##COL         @@COL             2
102300140815     ***
102400140815     C                   ENDSR
102500140815     ***
102600140815     ***
102700140815     C     $ACCUM        BEGSR
102800140815     ***
102900130617     C     PLPLAN        CHAIN     WKF
103000130617     ***
103100130617     C                   IF        %FOUND(ELIGPULLW1)
103200130617     C                   LEAVESR
103300130617     C                   ENDIF
103400130617     ***
103500130617     C                   CLEAR                   WKF
103600130617     C                   EVAL      WSORT = @SORT
103700130617     C                   EVAL      WPLAN = CMPLAN
103800130617     C                   EVAL      WDESC = SDESCR
103900130618     C                   EVAL      WPDSC = %TRIM(PDESCR)
104000130617     C                   WRITE     WKF
104100130618     ***
104200130619     C**                 ADD       1             #CTL
104300130617     ***
104400130617     C                   ENDSR
104500130617     ***
104600130617     ***
104700130619     C     $SORT         BEGSR
104800130619     ***
104900130619     C                   IF        #C < 2
105000130619     C                   LEAVESR
105100130619     C                   ENDIF
105200130619     ***
105300130619     C                   EVAL      #N = #C - 1
105400130619     C                   EXSR      $IN_ORDER
105500130619     C                   IF        @IO = 'N'
105600130619     C                   DOU       @IO = 'Y'
105700130619     C                   EXSR      $SORTCYCLE
105800130619     C                   EXSR      $IN_ORDER
105900130619     C                   ENDDO
106000130619     C                   ENDIF
106100130619     ***
106200130617     C                   ENDSR
106300130619     ***
106400130619     ***
106500130619     C     $IN_ORDER     BEGSR
106600130619    ***
106700130619     C                   EVAL      @IO = 'Y'
106800130619     C     1             DO        #N            X
106900130619      * *
107000130619     C     X             OCCUR     DS@PLN
107100130619     C                   EVAL      COMP@ = DTA@
107200130619      * *
107300130619     C                   EVAL      Y = X + 1
107400130619     C     Y             OCCUR     DS@PLN
107500130619      * *
107600130619     C                   IF        %SUBST(COMP@:1:9) > SRT@
107700130619     C                   EVAL      @IO = 'N'
107800130619     C                   LEAVE
107900130619     C                   ENDIF
108000130619     C                   ENDDO
108100130619    ***
108200130619     C                   ENDSR
108300130619   S***S
108400130619     C     $SORTCYCLE    BEGSR
108500130619    ***
108600130619     C                   EVAL      S = 0
108700130619     C                   EVAL      X = 0
108800130619     C                   EVAL      Y = 1
108900130619     C                   EVAL      COMP@ = *BLANKS
109000130619    ***
109100130619     C                   DO        #N
109200130619      * *
109300130619     C                   IF        COMP@ = *BLANKS
109400130619     C                   ADD       1             X
109500130619     C                   ADD       1             Y
109600130619     C                   ELSE
109700130619     C                   ADD       1             Y
109800130619     C                   ENDIF
109900130619      * *
110000130619     C     X             OCCUR     DS@PLN
110100130619     C                   EVAL      COMP@ = DTA@
110200130619      * *
110300130619     C     Y             OCCUR     DS@PLN
110400130619      * *
110500130619     C                   IF        %SUBST(COMP@:1:9) <= SRT@
110600130619      * *
110700130619     C                   ADD       1             S
110800130619     C     S             OCCUR     S1@PLN
110900130619     C                   EVAL      S1@@ = COMP@
111000130619     C                   EVAL      COMP@ = *BLANKS
111100130619     C                   EVAL      X = Y - 1
111200130619     C                   IF        Y = #C
111300130619     C                   ADD       1             S
111400130619     C     S             OCCUR     S1@PLN
111500130619     C                   EVAL      S1@@ = DTA@
111600130619     C                   ENDIF
111700130619      * *
111800130619     C                   ELSE
111900130619      * *
112000130619     C                   ADD       1             S
112100130619     C     S             OCCUR     S1@PLN
112200130619     C                   EVAL      S1@@ = DTA@
112300130619      * *
112400130619     C                   IF        Y = #C
112500130619     C                   ADD       1             S
112600130619     C     S             OCCUR     S1@PLN
112700130619     C                   EVAL      S1@@ = COMP@
112800130619     C                   ENDIF
112900130619      * *
113000130619     C                   ENDIF
113100130619      * *
113200130619     C                   ENDDO
113300130619    ***
113400130619     C                   EVAL      X = 0
113500130619     C                   DO        #C
113600130619     C                   ADD       1             X
113700130619     C     X             OCCUR     DS@PLN
113800130620     C     X             OCCUR     S1@PLN
113900130619     C                   EVAL      DTA@ = S1@@
114000130619     C                   CLEAR                   S1@@
114100130619     C                   ENDDO
114200130619    ***
114300130619     C                   EVAL      X = 0
114400130619     C                   EVAL      Y = 0
114500130619     C                   EVAL      S = 0
114600130619    ***
114700130619     C                   ENDSR
114800130619   S***S
114900130617     ***
115000130617     ***
115100130619     C     $GEN          BEGSR
115200130619     ***
115300130620     C                   MOVE      *ALL'0'       @9
115400130620     C                   MOVE      'NNNNN'       P@O                            PRT ONCE CTL
115500130620     C                   MOVE      *BLANKS       HS                2
115600130620     C                   EVAL      PRT_YET = NO
115700130619     ***
115800130619     C     @9            SETLL     WKF2
115900130619     C                   DOU       %EOF(ELIGPULLWL)
116000130619     C                   READ      WKF2
116100130619     C                   IF        NOT %EOF(ELIGPULLWL)
116200130620      * *
116300130620     C                   IF        HS = *BLANKS
116400130620     C                   EVAL      HS = %SUBST(YSORT:1:2)
116500130620     C                   ENDIF
116600130620      * *
116700130620     C                   IF        %SUBST(YSORT:1:2) <> HS
116800130620     C                   IF        PRT_YET = NO
116900130620     C                   EXSR      $COMMAS
117000130620     C                   ENDIF
117100130620     C                   EVAL      PRT_YET = NO
117200130620     C                   EVAL      HS = %SUBST(YSORT:1:2)
117300130620     C                   ENDIF
117400130619      * *
117500130619     C                   EXSR      $RTVMTCH
117600130619      * *
117700130619     C                   IF        MATCH_FND = NO
117800130620     C                   ITER
117900130620     C                   ENDIF
118000130619      * *
118100130621     C                   EVAL      PRT_YET = YES
118200130619     C                   MOVE      EFF@          #XSX
118300130619     C                   EXSR      $DATE
118400130619     C                   EVAL      @ED = %TRIM(HH)
118500130619      * *
118600130619     C                   EXSR      $TIERTXT
118700130619      * *
118800140815     C                   SELECT
118900140815     C                   WHEN      %SUBST(SRT@:1:2) = '01'
119000140815     C                   EVAL      HH = %TRIM(PLN@) + Q + %TRIM(TTYPE) + Q
119100140815     C                             + %TRIM(YPDSC) + Q + %TRIM(@ED)
119200140815     C                             + Q + %TRIM(ALT@) + Q + %TRIM(GRP@)
119300140815     C                   WHEN      %SUBST(SRT@:3:3) = 'EAP' OR
119400130619     C                             %SUBST(SRT@:1:2) = '02' OR
119500130619     C                             %SUBST(SRT@:1:2) = '03' OR
119600130619     C                             %SUBST(SRT@:1:2) = '04'
119700130620     C                   EVAL      HH = %TRIM(PLN@) + Q + %TRIM(TTYPE) + Q
119800140815     C                             + %TRIM(YPDSC) + Q + %TRIM(@ED)
119900140815     C                             + Q + %TRIM(GRP@)
120000140815     C                   OTHER
120100130620     C                   MOVE      VOL@          #7                7 0
120200130620     C                   EVAL      HH = %TRIM(PLN@) + Q + %TRIM(TTYPE) + Q
120300130620     C                             + %TRIM(YPDSC) + Q + %TRIM(@ED) + Q +
120400130620     C                             %TRIM(%EDITC(#7:'2'))
120500140815     C                             + Q +  %TRIM(GRP@)
120600140815     C                   ENDSL
120700130619      * *
120800130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
120900130619      * *
121000130619     C                   ENDIF
121100130619     C                   ENDDO
121200130620     ***
121300130620     C                   IF        PRT_YET = NO
121400130620     C                   EXSR      $COMMAS
121500130620     C                   ENDIF
121600130620     ***
121700130620     C                   ENDSR
121800130620     ***
121900130620     ***
122000130620     C     $COMMAS       BEGSR
122100130620     ***
122200130620     C                   SELECT
122300130620      * * *
122400130620     C                   WHEN      HS = '01'
122500130620     C                   IF        %SUBST(P@O:1:1) = 'N'
122600130620     C                   EVAL      %SUBST(P@O:1:1) = 'Y'
122700140815     C                   EVAL      X1 = %TRIM(X1) + ',,,,,,'
122800130620     C                   ENDIF
122900130620      * * *
123000130620     C                   WHEN      HS = '02'
123100130620     C                   IF        %SUBST(P@O:2:1) = 'N'
123200130620     C                   EVAL      %SUBST(P@O:2:1) = 'Y'
123300140815     C                   EVAL      X1 = %TRIM(X1) + ',,,,,'
123400130620     C                   ENDIF
123500130620      * * *
123600130620     C                   WHEN      HS = '03'
123700130620     C                   IF        %SUBST(P@O:3:1) = 'N'
123800130620     C                   EVAL      %SUBST(P@O:3:1) = 'Y'
123900140815     C                   EVAL      X1 = %TRIM(X1) + ',,,,,'
124000130620     C                   ENDIF
124100130620      * * *
124200130620     C                   WHEN      HS = '04'
124300130620     C                   IF        %SUBST(P@O:4:1) = 'N'
124400130620     C                   EVAL      %SUBST(P@O:4:1) = 'Y'
124500140815     C                   EVAL      X1 = %TRIM(X1) + ',,,,,'
124600130620     C                   ENDIF
124700130620      * * *
124800140815     C                   WHEN      %SUBST(YSORT:3:3) = 'EAP'
124900130620     C                   IF        %SUBST(P@O:5:1) = 'N'
125000130620     C                   EVAL      %SUBST(P@O:5:1) = 'Y'
125100140815     C                   EVAL      X1 = %TRIM(X1) + ',,,,,'
125200130620     C                   ENDIF
125300130620      * * *
125400130620     C                   OTHER
125500140815     C                   EVAL      X1 = %TRIM(X1) + ',,,,,,'
125600130620      * * *
125700130620     C                   ENDSL
125800130619     ***
125900130617     C                   ENDSR
126000130617     ***
126100130617     ***
126200130619     C     $TIERTXT      BEGSR
126300130619     ***
126400130619     C                   MOVE      *BLANKS       TTYPE            30
126500130619     ***
126600130619     C                   IF        TIERX = 'A'
126700130619     C                   SELECT
126800130619     C                   WHEN      ENR@ = 'TDB'
126900130619     C                   EVAL      TTYPE = 'HUS/WIFE-PARENT/CHILD'
127000130619     C                   WHEN      ENR@ = 'TED'
127100130619     C                   EVAL      TTYPE = 'EMPLOYEE + 1 DEPENDENT'
127200130619     C                   WHEN      ENR@ = 'TFA'
127300130619     C                   EVAL      TTYPE = 'FAMILY'
127400130619     C                   WHEN      ENR@ = 'TFM'
127500130619     C                   EVAL      TTYPE = 'FAMILY MEDICARE'
127600130619     C                   WHEN      ENR@ = 'THM'
127700130619     C                   EVAL      TTYPE = 'HUSBAND AND WIFE MED SUPP'
127800130619     C                   WHEN      ENR@ = 'THW'
127900130619     C                   EVAL      TTYPE = 'HUSBAND AND WIFE'
128000130619     C                   WHEN      ENR@ = 'TIN'
128100130619     C                   EVAL      TTYPE = 'INDIVIDUAL'
128200130619     C                   WHEN      ENR@ = 'TMF'
128300130619     C                   EVAL      TTYPE = 'FAMILY MEDICARE'
128400130619     C                   WHEN      ENR@ = 'TMH'
128500130619     C                   EVAL      TTYPE = 'MEDICARE HUSBAND/WIFE'
128600130619     C                   WHEN      ENR@ = 'TMI'
128700130619     C                   EVAL      TTYPE = 'INDIVIDUAL MEDICARE'
128800130619     C                   WHEN      ENR@ = 'TMM'
128900130619     C                   EVAL      TTYPE = 'FAMILY 2 ON MEDICARE SUPP'
129000130619     C                   WHEN      ENR@ = 'TMP'
129100130619     C                   EVAL      TTYPE = 'MEDICARE PARENT/CHILD'
129200130619     C                   WHEN      ENR@ = 'TM2'
129300130619     C                   EVAL      TTYPE = 'MEDSUPP PARENT/CHILDREN'
129400130619     C                   WHEN      ENR@ = 'TPC'
129500130619     C                   EVAL      TTYPE = 'PARENT AND CHILD'
129600130619     C                   WHEN      ENR@ = 'TP2'
129700130619     C                   EVAL      TTYPE = 'PARENT/CHILDREN'
129800130619     C                   WHEN      ENR@ = 'T2P'
129900130619     C                   EVAL      TTYPE = '2 PERSON'
130000130619     C                   OTHER
130100130619     C                   EVAL      TTYPE = '*UNKNOWN*'
130200130619     C                   ENDSL
130300130619     C                   LEAVESR
130400130619     C                   ENDIF
130500130619     ***
130600130619     C                   IF        TIERX = 'B'
130700130619     C                   SELECT
130800130619     C                   WHEN      ENR@ = 'TDB'
130900130619     C                   EVAL      TTYPE = 'EMPLOYEE+1'
131000130619     C                   WHEN      ENR@ = 'TED'
131100130619     C                   EVAL      TTYPE = 'EMPLOYEE+1 DEP'
131200130619     C                   WHEN      ENR@ = 'TFA'
131300130619     C                   EVAL      TTYPE = 'EMPLOYEE+FAMILY'
131400130619     C                   WHEN      ENR@ = 'TFM'
131500130619     C                   EVAL      TTYPE = 'EMPL+FAMILY MED SUPP'
131600130619     C                   WHEN      ENR@ = 'THM'
131700130619     C                   EVAL      TTYPE = 'EMPL+SPOUSE MED SUPP'
131800130619     C                   WHEN      ENR@ = 'THW'
131900130619     C                   EVAL      TTYPE = 'EMPL+SPOUSE'
132000130619     C                   WHEN      ENR@ = 'TIN'
132100130619     C                   EVAL      TTYPE = 'EMPLOYEE ONLY'
132200130619     C                   WHEN      ENR@ = 'TMF'
132300130619     C                   EVAL      TTYPE = 'EMPL+FAMILY MEDICARE'
132400130619     C                   WHEN      ENR@ = 'TMH'
132500130619     C                   EVAL      TTYPE = 'EMPL+SPOUSE MEDICARE'
132600130619     C                   WHEN      ENR@ = 'TMI'
132700130619     C                   EVAL      TTYPE = 'EMPLOYEE MEDICARE'
132800130619     C                   WHEN      ENR@ = 'TMM'
132900130619     C                   EVAL      TTYPE = 'EMPL+FAMILY MED SUPP'
133000130619     C                   WHEN      ENR@ = 'TMP'
133100130619     C                   EVAL      TTYPE = 'EMPL+CHILD MEDICARE'
133200130619     C                   WHEN      ENR@ = 'TM2'
133300130619     C                   EVAL      TTYPE = 'EMPL+CHILD MED SUPP'
133400130619     C                   WHEN      ENR@ = 'TPC'
133500130619     C                   EVAL      TTYPE = 'EMPLOYEE+CHILD'
133600130619     C                   WHEN      ENR@ = 'TP2'
133700130619     C                   EVAL      TTYPE = 'EMPLOYEE+CHILDREN'
133800130619     C                   WHEN      ENR@ = 'T2P'
133900130619     C                   EVAL      TTYPE = 'EMPLOYEE+1'
134000130619     C                   OTHER
134100130619     C                   EVAL      TTYPE = '*UNKNOWN*'
134200130619     C                   ENDSL
134300130619     C                   LEAVESR
134400130619     C                   ENDIF
134500130619     ***
134600130619     C                   IF        TIERX = 'C'
134700130619     C                   EVAL      TTYPE = ENR@
134800130619     C                   ENDIF
134900130619     ***
135000130816     C                   IF        TIERX = 'L'
135100130816     C                   SELECT
135200130816     C                   WHEN      ENR@ = 'TDB'
135300130816     C                   EVAL      TTYPE = 'TDB'
135400130816     C                   WHEN      ENR@ = 'TED'
135500130816     C                   EVAL      TTYPE = 'TED'
135600130816     C                   WHEN      ENR@ = 'TFA'
135700130816     C                   EVAL      TTYPE = 'F99'
135800130816     C                   WHEN      ENR@ = 'TFM'
135900130816     C                   EVAL      TTYPE = 'TFM'
136000130816     C                   WHEN      ENR@ = 'THM'
136100130816     C                   EVAL      TTYPE = 'THM'
136200130816     C                   WHEN      ENR@ = 'THW'
136300130816     C                   EVAL      TTYPE = 'F00'
136400130816     C                   WHEN      ENR@ = 'TIN'
136500130816     C                   EVAL      TTYPE = 'P00'
136600130816     C                   WHEN      ENR@ = 'TMF'
136700130816     C                   EVAL      TTYPE = 'TMF'
136800130816     C                   WHEN      ENR@ = 'TMH'
136900130816     C                   EVAL      TTYPE = 'TMH'
137000130816     C                   WHEN      ENR@ = 'TMI'
137100130816     C                   EVAL      TTYPE = 'TMI'
137200130816     C                   WHEN      ENR@ = 'TMM'
137300130816     C                   EVAL      TTYPE = 'TMM'
137400130816     C                   WHEN      ENR@ = 'TMP'
137500130816     C                   EVAL      TTYPE = 'TMP'
137600130816     C                   WHEN      ENR@ = 'TM2'
137700130816     C                   EVAL      TTYPE = 'TM2'
137800130816     C                   WHEN      ENR@ = 'TPC'
137900130816     C                   EVAL      TTYPE = 'P01'
138000130816     C                   WHEN      ENR@ = 'TP2'
138100130816     C                   EVAL      TTYPE = 'P99'
138200130816     C                   WHEN      ENR@ = 'T2P'
138300130816     C                   EVAL      TTYPE = 'T2P'
138400130816     C                   OTHER
138500130816     C                   EVAL      TTYPE = '*UNKNOWN*'
138600130816     C                   ENDSL
138700130816     C                   LEAVESR
138800130816     C                   ENDIF
138900130816     ***
139000130617     C                   ENDSR
139100130617     ***
139200130617     ***
139300130619     C     $RTVMTCH      BEGSR
139400130619     ***
139500130619     C                   EVAL      #N = 0
139600130619     C                   EVAL      MATCH_FND = NO
139700130619     ***
139800130619     C                   DO        #C
139900130619      * *
140000130619     C                   ADD       1             #N
140100130619      * *
140200130619     C     #N            OCCUR     DS@PLN
140300130619      * *
140400130619     C                   IF        SRT@ = YSORT
140500130619     C                   EVAL      MATCH_FND = YES
140600130620     C                   LEAVESR
140700130619     C                   ENDIF
140800130619      * *
140900130619     C                   ENDDO
141000130619     ***
141100130617     C                   ENDSR
141200130617     ***
141300130617     ***
141400130619     C     $DEPCTL       BEGSR
141500130619     ***
141600130619     C                   SELECT
141700130619     C                   WHEN      FILEX = 'A'
141800130619     C                   EXCEPT    OUTF1
141900130619     C                   WHEN      FILEX = 'B'
142000130620     C                   MOVE      *BLANKS       M1             5000
142100130619     C                   EVAL      M1 = %TRIM(X1)
142200130619     C                   WHEN      FILEX = 'C'
142300130619     C                   EXCEPT    OUTF1
142400130619     C                   ENDSL
142500130619     ***
142600130619     C     MBSSNO        CHAIN     DEPENR
142700130619     C                   IF        NOT %FOUND(DEPNDC)
142800130619     C                   IF        FILEX = 'B'
142900130619     C                   EVAL      X1 = %TRIM(M1)
143000130619     C                   EXCEPT    OUTF1
143100130619     C                   ENDIF
143200130619     C                   LEAVESR
143300130619     C                   ENDIF
143400130619     ***
143500130619     C                   MOVE      'N'           WRT1              1
143600130619     C     MBSSNO        SETLL     DEPENR
143700130619     ***
143800130619     C                   DOU       %EOF(DEPNDC)
143900130619     C                   EXSR      $DEPPULL
144000130619     C                   ENDDO
144100130619     ***
144200130619     C                   IF        WRT1 = 'N' AND FILEX = 'B'
144300130619     C                   EVAL      X1 = %TRIM(M1)
144400130619     C                   EXCEPT    OUTF1
144500130619     C                   ENDIF
144600130619     ***
144700130619     C                   ENDSR
144800130619     ***
144900130619     ***
145000130619     C     $DEPPULL      BEGSR
145100130619     ***
145200130619     C     MBSSNO        READE     DEPENR
145300130619     ***
145400130619     C                   IF        %EOF(DEPNDC)
145500130619     C                   LEAVESR
145600130619     C                   ENDIF
145700130619     ***
145800130619     C                   MOVE      DPSEQ#        KSQ
145900130619     ***
146000130619     C     KL#DCVC       KLIST
146100130619     C                   KFLD                    MBSSNO
146200130619     C                   KFLD                    KSQ
146300130619     ***
146400130619     C     KL#DCVC       CHAIN     DCOVR
146500130619     C                   IF        NOT %FOUND(DCOVC)
146600130619     C                   LEAVESR
146700130619     C                   ENDIF
146800130619     ***
146900130619     C                   EXSR      $CLRSTG
147000140815     ***
147100140815       EXSR $SMOKER;
147200130619     ***
147300130621     C     KL#DCVC       SETLL     DCOVR
147400130619     ***
147500130619     C                   DOU       %EOF(DCOVC)
147600130619     C                   EXSR      $DCVPULL
147700130619     C                   ENDDO
147800130619     ***
147900130619     C                   IF        #C = 0
148000130619     C                   LEAVESR
148100130619     C                   ENDIF
148200130619     ***
148300130619     C                   EXSR      $PREPDEP
148400130619     C                   EXSR      $SORT
148500130619     C                   EXSR      $DGEN
148600130619     ***
148700130617     C                   ENDSR
148800130619     ***
148900130619     ***
149000130619     C     $DCVPULL      BEGSR
149100130619     ***
149200130619     C     KL#DCVC       READE     DCOVR
149300130619     ***
149400130619     C                   IF        %EOF(DCOVC)
149500130619     C                   LEAVESR
149600130619     C                   ENDIF
149700130619     ***
149800130619     C                   IF        TERMX = 'B' AND CCANDT > 0
149900130619     C                   LEAVESR
150000130619     C                   ENDIF
150100130619     ***
150200130619     C                   IF        TERMX = 'A' AND CCANDT < #XTD
150300130619     C                   LEAVESR
150400130619     C                   ENDIF
150500130619     ***
150600130619     C     DVPLAN        CHAIN     WKF
150700130619     ***
150800130619     C                   IF        NOT %FOUND(ELIGPULLW1)
150900130619     C                   LEAVESR
151000130619     C                   ENDIF
151100130619     ***
151200140815       EXSR $DCVGRP;
151300140815       @ALTID = *BLANKS;
151400140815     ***
151500130619     C                   EVAL      LSRT = WSORT
151600130619     C                   EVAL      LPLN = DVPLAN
151700130619     C                   EVAL      LENR = 'SKP'
151800130619     C                   EVAL      LEFF = %CHAR(DENRDT)
151900130619     C                   EVAL      LDES = WDESC
152000130619     C                   EVAL      LVOL = '000000'
152100130619     C                   EXSR      $ADDCHK
152200130619     ***
152300130619     C                   ENDSR
152400130619     ***
152500140815     ***
152600140815     C     $DCVGRP       BEGSR
152700140815     ***
152800140815       @GRPID = *BLANKS;
152900140815     ***
153000140815       CHAIN (DVTRST:DVSUB#:DVPLAN) GRATER;
153100140815       IF NOT %FOUND(GRATEX);
153200140815          LEAVESR;
153300140815       ENDIF;
153400140815     ***
153500140815       SETLL (DVTRST:DVSUB#:DVPLAN) GRATER;
153600140815       DOU %EOF(GRATEX);
153700140815          READE (DVTRST:DVSUB#:DVPLAN) GRATER;
153800140815          IF NOT %EOF(GRATEX);
153900140815             IF TERMX = 'B';
154000140815                IF #TODAY >= FRMDAT AND #TODAY <= TODAT;
154100140815                   @GRPID = GROUP#;
154200140815                   LEAVESR;
154300140815                ENDIF;
154400140815             ELSE;
154500140815                IF #XTD >= FRMDAT AND #XTD <= TODAT;
154600140815                   @GRPID = GROUP#;
154700140815                   LEAVESR;
154800140815                ENDIF;
154900140815             ENDIF;
155000140815          ENDIF;
155100140815       ENDDO;
155200140815     ***
155300140815     C                   ENDSR
155400130619     ***
155500130619     C     $PREPDEP      BEGSR
155600130619     ***
155700130619     C                   EVAL      X1 = '"' + %EDITC(DSSNO:'X') + '",'
155800130619     C                   EVAL      HH = *BLANKS
155900130619     ***
156000130619     C                   SELECT
156100130619      * *
156200130619     C                   WHEN      NAMEX = 'A'
156300130619     C                   EVAL      HH = '"' + %TRIM(DFNAME) + Q + %TRIM(DMI) +
156400130619     C                             Q + %TRIM(DLNAME) + '",'
156500130619      * *
156600130619     C                   WHEN      NAMEX = 'B'
156700130619     C                   EVAL      HH = '"' + %TRIM(DLNAME) + ', ' +
156800130619     C                             %TRIM(DFNAME) + ' ' + DMI
156900130619     C                   EVAL      HH = %TRIM(HH) + '",'
157000130619      * *
157100130619     C                   WHEN      NAMEX = 'C'
157200130619     C                   EVAL      HH = '"' + %TRIM(DFNAME) + ' ' + %TRIM(DMI)
157300130619     C                   EVAL      HH = %TRIM(HH) + ' ' + %TRIM(DLNAME) + '",'
157400130619      * *
157500130619     C                   ENDSL
157600130619      * *
157700130619     C                   EVAL      X1 = %TRIM(X1) + %TRIM(HH)
157800130619     ***
157900130710     C                   IF        DEPSS# > 0
158000130619     C                   EVAL      X1 = %TRIM(X1) + '"' +
158100130619     C                             %EDITC(DEPSS#:'X') + '",'
158200130710     C                   ELSE
158300130710     C                   EVAL      X1 = %TRIM(X1) + ','
158400130710     C                   ENDIF
158500130619     ***
158600130619     C                   EXSR      $RELX
158700130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
158800130619     ***
158900130619     C                   EVAL      HH = *BLANKS
159000130619     C                   SELECT
159100130619     C                   WHEN      GENX = 'A'
159200130620     C                   EVAL      HH = DSEX
159300130620     C                   WHEN      GENX = 'B' AND DSEX = 'M'
159400130619     C                   EVAL      HH = 'MALE'
159500130620     C                   WHEN      GENX = 'B' AND DSEX = 'F'
159600130619     C                   EVAL      HH = 'FEMALE'
159700130619     C                   ENDSL
159800130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
159900130619     ***
160000130619     C                   EVAL      #XSX = DBIRTH
160100130619     C                   EXSR      $DATE
160200130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
160300140815     ***
160400140815     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(@SMOKE) + '",'
160500130619     ***
160600130620     C                   IF        AGEX = 'A'
160700130620     C                   IF        DBIRTH = 0
160800130620     C                   EVAL      X1 = %TRIM(X1) + '"000",'
160900130620     C                   ELSE
161000130620     C                   MOVE      DBIRTH        #ISO
161100130620     C                   MOVE      *ZEROS        AGE               3 0
161200130620     C                   EVAL      AGE = %DIFF(#TD:#ISO:*Y)
161300130620     C                   EVAL      X1 = %TRIM(X1) + '"' + %EDITC(AGE:'X') + '",'
161400130620     C                   ENDIF
161500130620     C                   ENDIF
161600130620     ***
161700130619     C                   EVAL      HH = *BLANKS
161800130619     C                   SELECT
161900130619     C                   WHEN      ADRX = 'A'
162000130619     C                   EVAL      HH = %TRIM(ADDR1) + Q + %TRIM(ADDR2)
162100130620     C                   WHEN      ADRX = 'B'
162200130619     C                   EVAL      HH = %TRIM(ADDR1) + ' ' + %TRIM(ADDR2)
162300130619     C                   ENDSL
162400130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
162500130619     ***
162600130619     C                   EVAL      HH = %EDITC(ZIP:'X')
162700130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(CITY) + Q +
162800130619     C                             %TRIM(STATE) + Q + %SUBST(HH:1:5) + '",'
162900130619     ***
163000130619     C                   SELECT
163100130619     C                   WHEN      PHONX = 'A'
163200130619     C                   EVAL      HH = %EDITC(AREA:'X') + Q +
163300130619     C                             %EDITC(PHONE:'X')
163400130619     C                   WHEN      PHONX = 'B'
163500130619     C                   EVAL      HH = %EDITC(AREA:'X') +
163600130619     C                             %EDITC(PHONE:'X')
163700130619     C                   WHEN      PHONX = 'C'
163800130619     C                   EVAL      HH = '(' + %EDITC(AREA:'X') + ') ' +
163900130619     C                             %EDITW(PHONE:'0   -    ')
164000130619     C                   ENDSL
164100130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
164200130619     ***
164300140319     C                   EVAL      X1 = %TRIM(X1) + ',,,"' +
164400140319     C                             %EDITC(DPSEQ#:'X') + '",'
164500130619     ***
164600130619     C                   ENDSR
164700130619     ***
164800130619     ***
164900130619     C     $RELX         BEGSR
165000130619     ***
165100130619     C                   EVAL      HH = *BLANKS
165200130619     ***
165300130619     C                   IF        RELX = 'A'
165400130619     C                   SELECT
165500130619     C                   WHEN      DRELCD = 'RSO'
165600130619     C                   EVAL      HH = 'SON'
165700130619     C                   WHEN      DRELCD = 'RDA'
165800130619     C                   EVAL      HH = 'DAUGHTER'
165900130619     C                   WHEN      DRELCD = 'RHU'
166000130619     C                   EVAL      HH = 'HUSBAND'
166100130619     C                   WHEN      DRELCD = 'RWI'
166200130619     C                   EVAL      HH = 'WIFE'
166300130619     C                   WHEN      DRELCD = 'ROO'
166400130619     C                   EVAL      HH = 'OTHER'
166500130619     C                   WHEN      DRELCD = 'RPA'
166600130619     C                   EVAL      HH = 'PARTNER'
166700130619     C                   ENDSL
166800130619     C                   LEAVESR
166900130619     C                   ENDIF
167000130619     ***
167100130619     C                   IF        RELX = 'B'
167200130619     C                   SELECT
167300130619     C                   WHEN      DRELCD = 'RSO'
167400130619     C                   EVAL      HH = 'CHILD'
167500130619     C                   WHEN      DRELCD = 'RDA'
167600130619     C                   EVAL      HH = 'CHILD'
167700130619     C                   WHEN      DRELCD = 'RHU'
167800130619     C                   EVAL      HH = 'SPOUSE'
167900130619     C                   WHEN      DRELCD = 'RWI'
168000130619     C                   EVAL      HH = 'SPOUSE'
168100130619     C                   WHEN      DRELCD = 'ROO'
168200130619     C                   EVAL      HH = 'OTHER'
168300130619     C                   WHEN      DRELCD = 'RPA'
168400130619     C                   EVAL      HH = 'DSPOUSE'
168500130619     C                   ENDSL
168600130619     C                   LEAVESR
168700130619     C                   ENDIF
168800130619     ***
168900130619     C                   IF        RELX = 'C'
169000130619     C                   SELECT
169100130619     C                   WHEN      DRELCD = 'RSO'
169200130619     C                   EVAL      HH = 'CH'
169300130619     C                   WHEN      DRELCD = 'RDA'
169400130619     C                   EVAL      HH = 'CH'
169500130619     C                   WHEN      DRELCD = 'RHU'
169600130619     C                   EVAL      HH = 'SP'
169700130619     C                   WHEN      DRELCD = 'RWI'
169800130619     C                   EVAL      HH = 'SP'
169900130619     C                   WHEN      DRELCD = 'ROO'
170000130619     C                   EVAL      HH = 'XX'
170100130619     C                   WHEN      DRELCD = 'RPA'
170200130619     C                   EVAL      HH = 'DP'
170300130619     C                   ENDSL
170400130619     C                   LEAVESR
170500130619     C                   ENDIF
170600130619     ***
170700130619     C                   IF        RELX = 'D'
170800130619     C                   SELECT
170900130619     C                   WHEN      DRELCD = 'RSO'
171000130619     C                   EVAL      HH = '19'
171100130619     C                   WHEN      DRELCD = 'RDA'
171200130619     C                   EVAL      HH = '19'
171300130619     C                   WHEN      DRELCD = 'RHU'
171400130619     C                   EVAL      HH = '01'
171500130619     C                   WHEN      DRELCD = 'RWI'
171600130619     C                   EVAL      HH = '01'
171700130619     C                   WHEN      DRELCD = 'ROO'
171800130619     C                   EVAL      HH = '36'
171900130619     C                   WHEN      DRELCD = 'RPA'
172000130619     C                   EVAL      HH = '53'
172100130619     C                   ENDSL
172200130619     C                   LEAVESR
172300130619     C                   ENDIF
172400130619     ***
172500130619     C                   IF        RELX = 'E'
172600130619     C                   SELECT
172700130619     C                   WHEN      DRELCD = 'RSO'
172800130619     C                   EVAL      HH = 'C'
172900130619     C                   WHEN      DRELCD = 'RDA'
173000130619     C                   EVAL      HH = 'C'
173100130619     C                   WHEN      DRELCD = 'RHU'
173200130619     C                   EVAL      HH = 'S'
173300130619     C                   WHEN      DRELCD = 'RWI'
173400130619     C                   EVAL      HH = 'S'
173500130619     C                   WHEN      DRELCD = 'ROO'
173600130619     C                   EVAL      HH = 'O'
173700130619     C                   WHEN      DRELCD = 'RPA'
173800130619     C                   EVAL      HH = 'D'
173900130619     C                   ENDSL
174000130619     C                   LEAVESR
174100130619     C                   ENDIF
174200130619     ***
174300130710     C                   IF        RELX = 'F'
174400130710     C                   SELECT
174500130710     C                   WHEN      DRELCD = 'RSO'
174600130710     C                   EVAL      HH = 'S'
174700130710     C                   WHEN      DRELCD = 'RDA'
174800130710     C                   EVAL      HH = 'D'
174900130710     C                   WHEN      DRELCD = 'RHU'
175000130710     C                   EVAL      HH = 'H'
175100130710     C                   WHEN      DRELCD = 'RWI'
175200130710     C                   EVAL      HH = 'W'
175300130710     C                   WHEN      DRELCD = 'ROO'
175400130710     C                   EVAL      HH = 'O'
175500130710     C                   WHEN      DRELCD = 'RPA'
175600130710     C                   EVAL      HH = 'P'
175700130710     C                   ENDSL
175800130710     C                   LEAVESR
175900130710     C                   ENDIF
176000130710     ***
176100130619     C                   ENDSR
176200130619     ***
176300130619     ***
176400130619     C     $DGEN         BEGSR
176500130619     ***
176600130619     C                   MOVE      *ALL'0'       @9                9
176700130620     C                   MOVE      'NNNNN'       P@O                            PRT ONCE CTL
176800130620     C                   MOVE      *BLANKS       HS                2
176900130620     C                   EVAL      PRT_YET = NO
177000130619     ***
177100130619     C     @9            SETLL     WKF2
177200130619     C                   DOU       %EOF(ELIGPULLWL)
177300130619     C                   READ      WKF2
177400130619     C                   IF        NOT %EOF(ELIGPULLWL)
177500130619      * *
177600130620     C                   IF        HS = *BLANKS
177700130620     C                   EVAL      HS = %SUBST(YSORT:1:2)
177800130620     C                   ENDIF
177900130620      * *
178000130620     C                   IF        %SUBST(YSORT:1:2) <> HS
178100130620     C                   IF        PRT_YET = NO
178200130620     C                   EXSR      $COMMAS
178300130620     C                   ENDIF
178400130620     C                   EVAL      PRT_YET = NO
178500130620     C                   EVAL      HS = %SUBST(YSORT:1:2)
178600130620     C                   ENDIF
178700130620      * *
178800130620     C                   EXSR      $RTVMTCH
178900130620      * *
179000130620     C                   IF        MATCH_FND = NO
179100130620     C                   ITER
179200130620     C                   ENDIF
179300130619      * *
179400130620     C                   MOVE      EFF@          #XSX
179500130619     C                   EXSR      $DATE
179600130619     C                   EVAL      @ED = %TRIM(HH)
179700130619      * *
179800130621     C                   EVAL      PRT_YET = YES
179900130621      * *
180000130620     C*                  EXSR      $TIERTXT
180100130620     C                   EVAL      TTYPE = *BLANKS
180200130619      * *
180300140815     C                   SELECT
180400140815     C                   WHEN      %SUBST(SRT@:1:2) = '01'
180500140815     C                   EVAL      HH = %TRIM(PLN@) + Q + %TRIM(TTYPE) + Q
180600140815     C                             + %TRIM(YPDSC) + Q + %TRIM(@ED)
180700140815     C                             + '",,"'
180800140815     C                   WHEN      %SUBST(SRT@:3:3) = 'EAP' OR
180900130619     C                             %SUBST(SRT@:1:2) = '02' OR
181000130619     C                             %SUBST(SRT@:1:2) = '03' OR
181100130619     C                             %SUBST(SRT@:1:2) = '04'
181200130620     C                   EVAL      HH = %TRIM(PLN@) + Q + %TRIM(TTYPE) + Q
181300140815     C                             + %TRIM(YPDSC) + Q + %TRIM(@ED)
181400140815     C                             + '","'
181500140815     C                   OTHER
181600130620     C                   MOVE      VOL@          #7                7 0
181700130620     C                   EVAL      HH = %TRIM(PLN@) + Q + %TRIM(TTYPE) + Q
181800130620     C                             + %TRIM(YPDSC) + Q + %TRIM(@ED) + Q +
181900130620     C                             %TRIM(%EDITC(#7:'2'))
182000140815     C                             + '","'
182100140815     C                   ENDSL
182200130619      * *
182300130619     C                   EVAL      X1 = %TRIM(X1) + '"' + %TRIM(HH) + '",'
182400130619      * *
182500130619     C                   ENDIF
182600130619     C                   ENDDO
182700130620     ***
182800130620     C                   IF        PRT_YET = NO
182900130620     C                   EXSR      $COMMAS
183000130620     C                   ENDIF
183100130619     ***
183200130619     C                   MOVE      'Y'           WRT1
183300130619     C                   SELECT
183400130619     C                   WHEN      FILEX = 'A'
183500130619     C                   EXCEPT    OUTF1
183600130619     C                   WHEN      FILEX = 'B'
183700130619     C                   EVAL      X1 = %TRIM(M1) + %TRIM(X1)
183800130619     C                   EXCEPT    OUTF1
183900130619     C                   WHEN      FILEX = 'C'
184000130619     C                   EVAL      X2 = %TRIM(X1)
184100130619     C                   EXCEPT    OUTF2
184200130619     C                   ENDSL
184300130619     ***
184400130619     C                   ENDSR
184500130619     ***
184600130619     ***
184700130620     OELIGPULLA EADD         OUTF1
184800130620     O                       X1             B  5000
184900130620     OELIGPULLB EADD         OUTF2
185000130620     O                       X2             B  5000
