000100081114     F*---------------------------------------------------------------**
000200081114     F* FM510      GROUP BENEFIT SERVICES SOFTWARE                     *
000300081114     F* COMMISSION CONTROL MAINTENANCE FOR MICK TO FLIP ON THE         *
000400081114     F* PERSISTENCY BROKER FOR A SPLIT COMMISSIONS SITUATION.          *
000500081114     F*                                                                *
000600110114     F* SK 01/14/2011 CHANGE FROM CARBC TO CGRPCD TO DO BOTH CFS AND COVENTRY
000700121107     F* SK 11/07/2012 LIMIT TO JUST THE MICK-STER BY MICK'S REQUEST    *
000800131106     F* DK 01/04/2013 Add AetnA                                        *
000900131106     F* SK 11/06/2013 CHANGE ACCESS AND EXPAND DISPLAY                 *
001000150826     F* dlk 08/26/15 - add new carrier group codes for coventry and    *
001100150826     F*                aetna (S2,S1)                                   *
001200160502     F* dlk 05/02/16 - change carrier selection for care first to use  *
001300160502     F*                the same "carbc" selection instead of the       *
001400160502     F*                exact carrier group code so this pgm matches    *
001500160502     F*                rpa190.                                         *
001600160502     F*                                                                *
001700190614     F* B.Rees  6/14/2019  Added UH to the Carrier Selection.
001800190614     F*
001900190614     F*---------------------------------------------------------------
002000081114    ***
002100081114     FFM510D    CF   E             WORKSTN INFDS(WSDS)
002200081114     F                                     SFILE(S01SFL:RR3)
002300131106     FCOMCTX    UF   E             DISK    RENAME(COMCXR:C33)
002400081114     FCMCT17    IF   E           K DISK    RENAME(COMCXR:C17) PREFIX(Z:1)
002500081114     FCMCT14    IF   E           K DISK    RENAME(COMCXR:C14) PREFIX(K:1)
002600131106     F                                     INFDS(IODBF2)
002700131106     FSMANSP    IF   E           K DISK
002800131106     FAGENL4    IF   E           K DISK
002900081114     FSUPRAGCY  IF   E           K DISK
003000081114     FSPRAGXR2  IF   E           K DISK
003100081114     FSMANRLT   IF   E           K DISK
003200131106     FPLNUNIQUE IF   E           K DISK
003300131106     FCARUNIQUE IF   E           K DISK    PREFIX(XX:2)
003400081114     FMKTCARA1  IF   E           K DISK
003500131106     FTRMUNIQUE IF   E           K DISK
003600131106     FSUMUNIQUE IF   E           K DISK
003700131106     FACMUNIQUE IF   E           K DISK
003800081114     FCRATE     IF   E           K DISK
003900081215     FCOMHST    O  A E             DISK
004000081114   X***X
004100081114     D                UDS
004200081218     D  @USER102              25     34A
004300081218     D  @USER                100    107A
004400081218     D  @USER10              100    109A
004500081218     D  CONAME               201    240A
004600081114     ***
004700081114     D WSDS            DS
004800081114     D  FKEY                 369    369A
004900081114     ***
005000081114     D  F1             C                   CONST(X'31')
005100081114     D  F2             C                   CONST(X'32')
005200081114     D  F3             C                   CONST(X'33')
005300081114     D  F4             C                   CONST(X'34')
005400081114     D  F5             C                   CONST(X'35')
005500081114     D  F6             C                   CONST(X'36')
005600081114     D  F7             C                   CONST(X'37')
005700081114     D  F8             C                   CONST(X'38')
005800081114     D  F9             C                   CONST(X'39')
005900081114     D  F10            C                   CONST(X'3A')
006000081114     D  F11            C                   CONST(X'3B')
006100081114     D  F12            C                   CONST(X'3C')
006200081114     D  F13            C                   CONST(X'B1')
006300081114     D  F14            C                   CONST(X'B2')
006400081114     D  F15            C                   CONST(X'B3')
006500081114     D  F16            C                   CONST(X'B4')
006600081114     D  F17            C                   CONST(X'B5')
006700081114     D  F18            C                   CONST(X'B6')
006800081114     D  F19            C                   CONST(X'B7')
006900081114     D  F20            C                   CONST(X'B8')
007000081114     D  F21            C                   CONST(X'B9')
007100081114     D  F22            C                   CONST(X'BA')
007200081114     D  F23            C                   CONST(X'BB')
007300081114     D  F24            C                   CONST(X'BC')
007400081114    ***
007500081114     D                 DS
007600081114     D @P10                    1     10A
007700081114     D  #KTR                   1      3S 0
007800081114     D  @KTR                   1      3A
007900081114     D  #KSU                   4      6S 0
008000081114     D  @KSU                   4      6A
008100081114     D  #KAC                   7     10S 0
008200081114    ***
008300081114     D A@20            S             20A
008400081114     D A@40            S             40A
008500081114     D IN@             S              1A   DIM(7)
008600081114     D I5@             S              1A   DIM(5)
008700081114     D MSG             S             70A   DIM(24) PERRCD(1) CTDATA
008800081114     D OUT@            S              1A   DIM(8)
008900081114     D O6@             S              1A   DIM(6)
009000081114     D RR3             S              3S 0
009100081114    ***
009200081114     D #CNISO          S              8S 0
009300081114     D #CNTREC         S              3S 0
009400081114     D #ECNT           S              1S 0
009500081114     D #EFISO          S              8S 0
009600081114     D #HEFDT          S              8S 0
009700081114     D #HENDT          S              8S 0
009800081114     D #ISO            S               D   DATFMT(*ISO)
009900081218     D #TISO           S               D   DATFMT(*ISO)
010000081114     D #KCN            S                   LIKE(CMCAN)
010100081114     D #KEF            S                   LIKE(EFFDAT)
010200081114     D #USA            S               D   DATFMT(*USA)
010300081114     D #XSX            S              8S 0
010400081114     ***
010500081114     D @ACCT           S              4A
010600081114     D @ACTIVE         S              1A
010700081114     D @DUPE           S              1A
010800081114     D @KPL            S                   LIKE(CMPLAN)
010900081114     D @KSL            S                   LIKE(SLSMAN)
011000081114     D @PARM           S             10A
011100081114     D @PLPARM         S             10A
011200081114     D @PLPARM2        S              3A
011300081114     D @SFLOOP         S              1A
011400081114     D @STEP           S              5A
011500081114     D @SUBD           S              3A
011600081114     D @T              S              1A
011700081114     D @TRST           S              3A
011800081114     D @VCC            S              1A
011900081114     D @1STLOOP        S              1A
012000081114     D @2              S              2A
012100081114     D @3              S              3A
012200081114     D @35             S             35A
012300081114     D @4              S              4A
012400081114     D @5              S              5A
012500081114     D @6              S              6A
012600081114     D @7              S              7A
012700081114     D @8              S              8A
012800081114     ***
012900081114     D @@A             S              1A
013000081114     D @@CTYPE         S              1A
013100081114     D @@E             S              1A
013200081114     D @@FNDACT        S              1A
013300081114     D @@RF            S              1A
013400081114     D @@STP           S              5A
013500081114     D @@W1            S              1A
013600131106    ***
013700131106     D IODBF2        E DS                  EXTNAME(IODBFD)
013800131106     D #RRN2                 397    400B 0
013900131106    ***
014000131106     D*IODBFD        E DS                  EXTNAME(IODBFD)
014100131106     D*#RRN                  397    400B 0
014200131106    ***
014300081114   X***X
014400081114     C                   DOU       @STEP = 'EXIT '
014500081114     C     @STEP         CASEQ     'STEP0'       $STEP0
014600081114     C     @STEP         CASEQ     'STEP1'       $STEP1
014700081114     C     @STEP         CASEQ     'STEP2'       $STEP2
014800081114     C                   ENDCS
014900081114     C                   ENDDO
015000081114     C*
015100081114     C                   MOVE      *ON           *INLR
015200081114     C*
015300081114   S***S
015400081114     C     *INZSR        BEGSR
015500081114    ***
015600081114     C     *ENTRY        PLIST
015700081114     C                   PARM                    @PARM
015800081114    ***
015900081114     C                   MOVE      'STEP0'       @STEP
016000081114     C                   MOVE      *ZEROS        RR3
016100081114     C                   MOVE      '0'           @1STLOOP
016200081114     C                   MOVE      '0'           @SFLOOP
016300081114     C                   MOVE      *BLANKS       @@A
016400081114     C                   MOVE      *ZEROS        #HEFDT
016500081114     C                   MOVE      *ZEROS        #HENDT
016600081114     C                   MOVE      *ZEROS        #ECNT
016700081114     C                   MOVE      *ZEROS        #CNTREC
016800081114    ***
016900081114     C                   MOVEL     @PARM         @P10
017000081114     C                   Z-ADD     #KTR          I_TRST
017100081114     C                   Z-ADD     #KSU          I_SUB#
017200081114     C                   Z-ADD     #KAC          I_ACCT
017300081215    ***
017400081218     C                   MOVE      *DATE         #TISO
017500081114    ***
017600081114     C     CKEY          KLIST
017700081114     C                   KFLD                    #KTR
017800081114     C                   KFLD                    #KSU
017900081114     C                   KFLD                    #KAC
018000081114     C*
018100081114     C     SUBKEY        KLIST
018200081114     C                   KFLD                    #KTR
018300081114     C                   KFLD                    #KSU
018400081114     C*
018500081114     C     ACCKEY        KLIST
018600081114     C                   KFLD                    #KTR
018700081114     C                   KFLD                    #KSU
018800081114     C                   KFLD                    #KAC
018900081114     C*
019000081114     C     MKTKEY        KLIST
019100081114     C                   KFLD                    #KTR
019200081114     C                   KFLD                    #KSU
019300081114     C                   KFLD                    #KAC
019400081114     C                   KFLD                    PCARR
019500081114     C*
019600081114     C     C17KEY        KLIST
019700081114     C                   KFLD                    #KTR
019800081114     C                   KFLD                    #KSU
019900081114     C                   KFLD                    #KAC
020000081114     C                   KFLD                    R2PLAN
020100081114     C                   KFLD                    O_SMAN
020200081114     C*
020300081114     C     PLNKEY        KLIST
020400081114     C                   KFLD                    #KTR
020500081114     C                   KFLD                    #KSU
020600081114     C                   KFLD                    @KPL
020700081114     C*
020800081114    ***
020900081114     C                   ENDSR
021000081114   S***S
021100081114     C* SETUP TEXT FIELDS
021200081114     C     $STEP0        BEGSR
021300081114    ***
021400081215     C     #KTR          CHAIN     TRSMSR
021500131106     C                   IF        %FOUND(TRMUNIQUE)
021600081114     C                   MOVEL(P)  TNAME         O_TNAM
021700081114     C                   ENDIF
021800081114    ***
021900081215     C     SUBKEY        CHAIN     SUBMSR
022000131106     C                   IF        %FOUND(SUMUNIQUE)
022100081114     C                   MOVEL(P)  SUBNAM        O_SUBN
022200081114     C                   ENDIF
022300081114    ***
022400081215     C     ACCKEY        CHAIN     ACCMSR
022500131106     C                   IF        %FOUND(ACMUNIQUE)
022600081114     C                   MOVEL(P)  ACNAM1        O_ACCN
022700081114     C                   ENDIF
022800081218    ***
022900081218     C                   IF        @USER10 = *BLANKS
023000081218     C                   EVAL      @USER10 = @USER102
023100081218     C                   ENDIF
023200081114    ***
023300081114     C                   MOVEL(P)  'STEP1'       @STEP
023400081114    ***
023500081114     C                   ENDSR
023600081114   S***S
023700081114     C     $STEP1        BEGSR
023800081114    ***
023900081114     C                   MOVE      *ZEROS        #ECNT
024000081114     C                   MOVE      *ZEROS        RR3
024100081114     C                   MOVE      *ZEROS        #CNTREC
024200081114    ***
024300081114     C                   EXSR      $CLEAR
024400081114    ***
024500081216     C                   MOVE      'N'           @W1               1
024600081216     C                   MOVEL(P)  'STEP2'       @STEP
024700081114     C                   EXSR      $BUILD
024800081114    ***
024900081114     C                   ENDSR
025000081114   S***S
025100081114     C* INITIALIZE THE SUBFILE
025200081114    ***
025300081114     C     $CLEAR        BEGSR
025400081114    ***
025500081114     C                   MOVEA     '011'         *IN(25)
025600081114     C                   WRITE     S01CTL
025700081114     C                   MOVEA     '010'         *IN(25)
025800081114     C                   Z-ADD     *ZERO         RR3
025900081114    ***
026000081114     C                   ENDSR
026100081114   S***S
026200081114     C* BUILD SUBFILE CONTROL ROUTINE
026300081114    ***
026400081114     C     $BUILD        BEGSR
026500081114    ***
026600081114     C                   MOVE      *ZEROS        #CNTREC
026700081114     C                   MOVE      '0'           @1STLOOP
026800081114     C                   MOVEA     '00'          *IN(33)
026900081114     C                   MOVE      '0'           @SFLOOP
027000081114    ***
027100081114     C     CKEY          SETLL     C14
027200081114     C                   DOU       %EOF(CMCT14) OR @SFLOOP = '1'
027300081114     C     CKEY          READE     C14
027400081114     C                   IF        NOT %EOF(CMCT14)
027500081114     C                   EXSR      $LOADSFL
027600081114     C                   ENDIF
027700081114     C                   ENDDO
027800081114    ***
027900081114     C                   IF        RR3 = 0
028000081114     C                   MOVE      *OFF          *IN60
028100081114     C                   ELSE
028200081114     C                   MOVE      *ON           *IN60
028300081114     C                   ENDIF
028400081114    ***
028500081114     C                   IF        %EOF(CMCT14)
028600081114     C                   MOVE      *OFF          *IN29
028700081114     C                   ELSE
028800081114     C                   MOVE      *ON           *IN29
028900081114     C                   ENDIF
029000081114    ***
029100081216     C                   IF        @W1 = 'N'
029200081216     C                   DOU       @W1 = 'L'
029300081216     C                   EXFMT     S03R
029400081216     C                   IF        FKEY = F1
029500081216     C                   MOVEL(P)  'EXIT'        @STEP
029600081216     C                   LEAVESR
029700081216     C                   ENDIF
029800081216     C                   ENDDO
029900081216     C                   ENDIF
030000081216    ***
030100081114     C                   ENDSR
030200081114   S***S
030300081114     C* LOAD SUBFILE RECORDS
030400081114    ***
030500081114     C     $LOADSFL      BEGSR
030600081114    ***
030700081114     C                   MOVE      *ON           *IN25
030800081114     C                   MOVE      *BLANKS       SEL
030900081218    ***
031000111229     C*                  IF        KCCMSP = 0.0000                              TEMPORARY
031100111229     C*                  LEAVESR                                                TEMPORARY
031200111229     C*                  ENDIF                                                  TEMPORARY
031300081218    ***
031400081114     C                   MOVEL(P)  KLSMAN        SFSCOD
031500081114     C                   MOVEL     KMRELID       SFRELID
031600081114    ***
031700081114     C     KMRELID       CHAIN     SRF
031800081114     C     SRSMAN        CHAIN     SMANR
031900131106     C                   IF        %FOUND(SMANSP)
032000081114     C                   EXSR      $GETSNAME
032100081114     C                   MOVEL(P)  A@40          SFSLNM
032200081114     C                   ELSE
032300081114     C                   MOVE      *BLANKS       SFSLNM
032400081114     C                   ENDIF
032500081114    ***
032600081114     C                   MOVEL(P)  KMPLAN        SFPLAN
032700081114     C                   MOVEL(P)  KMPLAN        @KPL
032800081114    ***
032900081215     C     PLNKEY        CHAIN     PLNMSR
033000131106     C                   IF        %FOUND(PLNUNIQUE)
033100081114     C                   MOVEL(P)  PDESCR        SFPDES
033200081216    *C     PCARR         CHAIN     CARMSR
033300131106     C                   IF        %FOUND(CARUNIQUE) AND
033400160502      * this list of carriers should match rpa190
033500160502     C                             (XXrbc  <> 'D')  AND
033600160502     C                             (XXRPCD <> 'CH' and XXRPCD <> 'AH' and
033700190614     C                              xxrpcd <> 'S1' and xxrpcd <> 'S2' and
033800190614     C                              xxrpcd <> 'UH' and xxrpcd <> 'HL')
033900081216     C                   LEAVESR
034000081216     C                   ENDIF
034100081114     C                   ELSE
034200081114     C                   MOVE      *BLANKS       SFPDES
034300081114     C                   ENDIF
034400131106    ***
034500131106     C                   Z-ADD     KCCMSP        SFCMSP
034600131106     C                   Z-ADD     KCOVPC        SFOVPC
034700131106     C                   Z-ADD     KCOVRA        SFOVRA
034800131106     C                   Z-ADD     KCOVPP        SFOVPP
034900131106     C                   EVAL      SFPNC = KCPNC
035000081114    ***
035100081114     C                   MOVE      KFFDAT        #XSX
035200081114     C                   EXSR      $ISOUSA
035300081114     C                   MOVE      #XSX          SFEFDT
035400081114     C*
035500081114     C                   MOVE      KMCAN         #XSX
035600081114     C                   EXSR      $ISOUSA
035700081114     C                   MOVE      #XSX          SFCNDT
035800081216     C*
035900081216     C                   IF        %SUBST(KREE5:1:1) = 'Y'
036000081216     C                   EVAL      *IN65 = *ON
036100081216     C                   ELSE
036200081216     C                   EVAL      *IN65 = *OFF
036300081216     C                   ENDIF
036400081114     C*
036500131106     C                   Z-ADD     #RRN2         HK
036600081114     C                   ADD       1             RR3
036700081114     C*
036800081114     C                   IF        @1STLOOP = '0'
036900081114     C                   Z-ADD     RR3           SFLPOS
037000081114     C                   MOVE      '1'           @1STLOOP
037100081114     C                   ENDIF
037200081114     C*
037300081114     C                   WRITE     S01SFL
037400081216     C                   MOVE      'Y'           @W1
037500081114     C*
037600081114     C                   ADD       1             #CNTREC
037700131106     C                   IF        #CNTREC = 2000
037800081114     C                   MOVE      '1'           @SFLOOP
037900081114     C                   ENDIF
038000081114    ***
038100081114     C                   ENDSR
038200081114   S***S
038300081114     C     $ISOUSA       BEGSR
038400081114     C                   IF        #XSX = 0
038500081114     C                   LEAVESR
038600081114     C                   ELSE
038700081114     C     *ISO          TEST (DE)               #XSX
038800081114     C                   IF        NOT %ERROR
038900081114     C                   MOVE      #XSX          #ISO
039000081114     C                   MOVE      #ISO          #USA
039100081114     C                   MOVE      #USA          #XSX
039200081114     C                   ENDIF
039300081114     C                   ENDIF
039400081114     C                   ENDSR
039500081114   S***S
039600081114     C     $STEP2        BEGSR
039700081114    ***
039800081114     C                   EXSR      $DISPLAY
039900081114     C                   MOVE      *BLANKS       S01MSG
040000081114     C                   ADD       1             #ECNT
040100081114    ***
040200081114     C                   IF        FKEY = F1
040300081114     C                   MOVEL(P)  'EXIT'        @STEP
040400081114     C                   LEAVESR
040500081114     C                   ENDIF
040600081114    ***
040700081114     C                   IF        *IN60 = *ON
040800081114     C                   EXSR      $CHKSELC
040900081114     C                   ENDIF
041000081114    ***
041100081114     C                   IF        #ECNT >= 3
041200081114     C                   MOVEL(P)  'STEP1'       @STEP
041300081114     C                   LEAVESR
041400081114     C                   ENDIF
041500081114    ***
041600081114     C                   ENDSR
041700081114   S***S
041800081114     C* DISPLAY THE SCREEN
041900081114    ***
042000081114     C     $DISPLAY      BEGSR
042100121107    ***
042200130402     C                   IF        @USER102 = 'MICKG' OR @USER102 = 'TONIN'
042300121107     C                   EVAL      *IN98 = *OFF
042400121107     C                   ELSE
042500121107     C                   EVAL      *IN98 = *ON
042600121107     C                   ENDIF
042700081114    ***
042800081114     C                   WRITE     S01REC
042900081114     C                   EXFMT     S01CTL
043000081114     C*
043100081114     C                   MOVE      *BLANKS       S01MSG
043200081114    ***
043300081114     C                   ENDSR
043400081114    ***
043500081114   S***S
043600081114     C* CHECK SUBFILE SELECTION
043700081114    ***
043800081114     C     $CHKSELC      BEGSR
043900081114    ***
044000081114     C                   DOU       %EOF(FM510D)
044100081114     C                   READC     S01SFL
044200081114     C                   IF        NOT %EOF(FM510D) AND SEL <> *BLANKS
044300081114     C*
044400081114     C                   SELECT
044500081114     C                   WHEN      SEL = 'C' or SEL = 'X'
044600121107     C                             OR SEL = 'I'
044700081114     C                   EXSR      $CHGCTL
044800081114     C                   ENDSL
044900081114     C*
045000081114     C                   IF        S01MSG <> *BLANKS
045100081114     C                   LEAVESR
045200081114     C                   ENDIF
045300081114     C*
045400081114     C                   MOVE      *BLANKS       SEL
045500081114     C                   UPDATE    S01SFL
045600081114     C*
045700081114     C                   ENDIF
045800081114     C                   ENDDO
045900081218    ***
046000081218     C                   MOVEL(P)  'STEP1'       @STEP
046100081114    ***
046200081114     C                   ENDSR
046300081114   S***S
046400131106     C     $CLRSC2       BEGSR
046500081114    ***
046600081114     C                   MOVE      *BLANKS       R2MSG
046700081114     C                   MOVE      *OFF          *IN80
046800081114    ***
046900081114     C                   MOVE      *BLANKS       R2PLAN
047000081114     C                   MOVE      *BLANKS       R2PDES
047100081114     C                   MOVE      *ALL'0'       R2RELID
047200081114     C                   MOVE      *BLANKS       O_SMAN
047300081114     C                   MOVE      *BLANKS       D_SMAN
047400081114     C                   MOVE      *BLANKS       O_AGCY
047500081114     C                   MOVE      *BLANKS       D_AGCY
047600081114     C                   MOVE      *BLANKS       O_SUPER
047700081114     C                   MOVE      *BLANKS       D_SUPER
047800081114     c                   eval      o_efusa = 0
047900081114     c                   eval      o_trusa = 0
048000081114     C                   MOVE      *ZEROS        R2EFDT
048100081114SSK  C                   MOVE      *ZEROS        #EFISO
048200081114     C                   MOVE      *ZEROS        R2CNDT
048300081114SSK  C                   MOVE      *ZEROS        #CNISO
048400081114     c                   move      *zeros        r2cmsp
048500081114     C                   MOVE      *ZEROS        R2OVPC
048600081114     C                   MOVE      *ZEROS        R2OVRA
048700081114     C                   MOVE      *ZEROS        R2OVPP
048800081114     C                   MOVE      *BLANKS       R2PNC
048900081114    ***
049000081114     C                   IF        @@A = 'A'
049100081114     C                   Z-ADD     #HEFDT        R2EFDT
049200081114     C                   MOVE      *ON           *IN50
049300081114     C                   ELSE
049400081114     C                   MOVE      SFRELID       R2RELID
049500081114     C                   ENDIF
049600081114    ***
049700081114     C                   MOVE      *OFF          *IN30
049800121107    ***
049900130402     C                   IF        @USER102 = 'MICKG' OR @USER102 = 'TONIN'
050000121107     C                   EVAL      *IN98 = *OFF
050100121107     C                   ELSE
050200121107     C                   EVAL      *IN98 = *ON
050300121107     C                   ENDIF
050400081114    ***
050500081114     C                   ENDSR
050600081114   S***S
050700131106     C     $PRCSC2       BEGSR
050800081114    ***
050900081114     C                   EXFMT     S02R
051000081114     C                   MOVE      *BLANKS       R2MSG
051100081114    ***
051200081114    1C                   IF        FKEY = F1
051300081114     C                   MOVEL(P)  'STEP1'       @STEP
051400081114     C                   LEAVESR
051500081114    1C                   ENDIF
051600081114    ***
051700130402     C                   IF        @USER102 = 'MICKG' OR @USER102 = 'TONIN'
051800081114     C                   EXSR      $VALIDATE
051900081114     C                   IF        @VCC = 'Y'
052000081215     C                             AND OLPRI <> CMPRI
052100081114     C                   EXSR      $UPDATE
052200081218     C                   EVAL      OLPRI = CMPRI
052300081114     C                   ENDIF
052400121107    1C                   ENDIF
052500081114    ***
052600081114     C                   ENDSR
052700081114   S***S
052800081114     C     $GETDESC      BEGSR
052900081114    ***
053000081114     C                   EVAL      O_SMAN = SRSMAN
053100081114     c     sreffdte      mult      10000.0001    o_efusa
053200081114     c                   if        srtrmdte > 0
053300081114     c     srtrmdte      mult      10000.0001    o_trusa
053400081114     c                   else
053500081114     c                   eval      o_trusa = 0
053600081114     c                   endif
053700081114    ***
053800081215     C     SRSMAN        CHAIN     SMANR
053900131106     C                   IF        %FOUND(SMANSP)
054000081114     C                   EXSR      $GETSNAME
054100081114     C                   MOVEL(P)  A@40          D_SMAN
054200081114     C                   ELSE
054300081114     C                   MOVEL(P)  '*UNKNOWN'    D_SMAN
054400081114     C                   ENDIF
054500081114    ***
054600081114     C                   ENDSR
054700081114   S***S
054800081114     C     $GETLINK      BEGSR
054900081114    ***
055000081114     C     SRASID        CHAIN     SXF
055100081114     C                   IF        NOT %FOUND(SPRAGXR2)
055200081114     C                   MOVE      *BLANKS       O_AGCY
055300081114     C                   MOVE      *BLANKS       O_SUPER
055400081114     C                   MOVE      *BLANKS       D_AGCY
055500081114     C                   MOVE      *BLANKS       D_SUPER
055600081114     C                   LEAVESR
055700081114     C                   ENDIF
055800081114    ***
055900081114     C                   EVAL      O_AGCY = SXAGCY
056000081114     C                   EVAL      O_SUPER = SXSUPER
056100081114    ***
056200081114     C     SXAGCY        CHAIN     AGENR
056300131106     C                   IF        %FOUND(AGENL4)
056400081114     C                   MOVEL(P)  AGNAM1        D_AGCY
056500081114     C                   ELSE
056600081114     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
056700081114     C                   ENDIF
056800081114    ***
056900081114     C     SXSUPER       CHAIN     SAF
057000081114     C                   IF        %FOUND(SUPRAGCY)
057100081114     C                   MOVEL(P)  SANAME1       D_SUPER
057200081114     C                   ELSE
057300081114     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
057400081114     C                   ENDIF
057500081114    ***
057600081114     C                   ENDSR
057700081114   S***S
057800081114     C     $GETSNAME     BEGSR
057900081114    ***
058000081114     C                   CLEAR                   A@20
058100081114     C                   CLEAR                   A@40
058200081114    ***
058300081114     C                   IF        SFNAME <> *BLANKS
058400081114     C                   MOVEL     SFNAME        A@20
058500081114     C                   EXSR      $LDADDR
058600081114     C                   ENDIF
058700081114    ***
058800081114     C                   IF        SMI <> *BLANKS
058900081114     C                   MOVEL     SMI           A@20
059000081114     C                   EXSR      $LDADDR
059100081114     C                   ENDIF
059200081114    ***
059300081114     C                   IF        SLNAME <> *BLANKS
059400081114     C                   MOVEL     SLNAME        A@20
059500081114     C                   EXSR      $LDADDR
059600081114     C                   ENDIF
059700081114    ***
059800081114     C                   ENDSR
059900081114   S***S
060000081114     C     $LDADDR       BEGSR
060100081114    ***
060200081114     C                   EVAL      A@20 = %TRIM(A@20)
060300081114     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
060400081114     C                   CLEAR                   A@20
060500081114    ***
060600081114     C                   ENDSR
060700081114   S***S
060800081114     C* VALIDATE VALUES
060900081114    ***
061000081114     C     $VALIDATE     BEGSR
061100081114    ***
061200081114     C                   MOVE      'N'           @VCC
061300081114     C                   MOVE      *BLANKS       R2PDES
061400081114     C                   MOVE      *BLANKS       D_SMAN
061500081114     C                   MOVE      *BLANKS       D_AGCY
061600081114     C                   MOVE      *BLANKS       D_SUPER
061700081114     C                   MOVE      *BLANKS       O_SMAN
061800081114     C                   MOVE      *BLANKS       O_AGCY
061900081114     C                   MOVE      *BLANKS       O_SUPER
062000081114    ***
062100081215     C                   IF        CMPRI = *BLANKS
062200081114     C                   EVAL      R2MSG = 'RECORD NO LONGER DENOTES PERSISTE' +
062300081114     C                             'NCY BROKER RECORD'
062400081114     C                   ENDIF
062500081114    ***
062600081215     C                   IF        CMPRI <> *BLANKS AND CMPRI <> 'Y'
062700081215     C                   EVAL      R2MSG = 'INVALID VALUE FOR PRIMARY BROKER ' +
062800081215     C                             'FIELD'
062900081215     C                   LEAVESR
063000081215     C                   ENDIF
063100081215    ***
063200081114     C                   MOVEL(P)  R2PLAN        @KPL
063300081215     C     PLNKEY        CHAIN     PLNMSR
063400131106    1C                   IF        %FOUND(PLNUNIQUE)
063500081114     C                   MOVEL(P)  PDESCR        R2PDES
063600081114    1C                   ENDIF
063700081114    ***
063800081215     C     R2RELID       CHAIN     SRF
063900081114    1C                   IF        %FOUND(SMANRLT)
064000081114     C*
064100081114     C                   EXSR      $GETDESC
064200081114     C                   EXSR      $GETLINK
064300081114     C*
064400081114    2C                   ENDIF
064500081114    ***
064600081114     C                   MOVE      'Y'           @VCC
064700081114    ***
064800081114     C                   ENDSR
064900081114   S***S
065000081114     C     $USAISO       BEGSR
065100081114     C                   IF        #XSX = 0
065200081114     C                   LEAVESR
065300081114     C                   ENDIF
065400081114     C     *USA          TEST (DE)               #XSX
065500081114     C                   IF        %ERROR
065600081114     C                   MOVE      *ZEROS        #XSX
065700081114     C                   LEAVESR
065800081114     C                   ENDIF
065900081114     C                   MOVE      #XSX          #USA
066000081114     C                   MOVE      #USA          #ISO
066100081114     C                   MOVE      #ISO          #XSX
066200081114     C                   ENDSR
066300081114   S***S
066400081114     C     $UPDATE       BEGSR
066500081114    ***
066600081114     C                   EXSR      $GENHIST
066700081114    ***
066800081114     C                   MOVEL(P)  SFPLAN        @KPL
066900081114     C                   MOVEL(P)  SFSCOD        @KSL
067000081114     C                   Z-ADD     SFEFDT        #XSX
067100081114     C                   EXSR      $USAISO
067200081114     C                   Z-ADD     #XSX          #KEF
067300081114     C                   Z-ADD     SFCNDT        #XSX
067400081114     C                   EXSR      $USAISO
067500081114     C                   Z-ADD     #XSX          #KCN
067600131106     C     HK            CHAIN     C33
067700131106    2C                   IF        %FOUND(COMCTX)
067800081215     C                   EVAL      FREE5 = CMPRI
067900081114     C                   UPDATE    C33
068000081114     C                   MOVEL(P)  MSG(15)       R2MSG
068100131106     C                   ELSE
068200131106     C                   SETON                                        H1
068300081114    2C                   ENDIF
068400081114    ***
068500081114     C                   ENDSR
068600081114   S***S
068700081114     C     $GENHIST      BEGSR
068800081114    ***
068900081114    ***  PUT IN KETTERMAN'S NEW HISTORY
069000081114    ***
069100081215
069200081215      * common fields in commission history file
069300081215     c                   clear                   comhstr
069400081215     C                   move      I_TRST        chtrust
069500081215     C                   move      I_SUB#        chsub
069600081215     C                   move      I_ACCT        chacc
069700081215     C                   MOVEL     r2plan        chplan
069800081215     c                   move      #tiso         chtrdat
069900081215     c                   time                    chtrtim
070000081215     C                   MOVEL     @USER10       chuser
070100081218     C                   MOVEL(P)  'FM510R'      chpgm
070200081215
070300081215      * after fields
070400081218     c                   move      EFFDAT        chaeff
070500081218     c                   move      CMCAN         chacan
070600081218     c                   move      CMRELID       charel
070700081218     c                   move      CCOVPP        chapop
070800081218     c                   move      CCOVRA        chaff
070900081218     c                   move      CCOVPC        chapoc
071000081218     c                   move      CCPNC         chapnc
071100081218     c                   move      CCCMSP        chacmsp
071200081215     c                   MOVEL     CMPRI         chapri
071300081215
071400081215      * before fields
071500081215     c                   move      effdat        chbeff
071600081215     c                   move      cmcan         chbcan
071700081215     c                   move      cmrelid       chbrel
071800081215     c                   move      ccovpp        chbpop
071900081215     c                   move      ccovra        chbff
072000081215     c                   move      ccovpc        chbpoc
072100081215     c                   move      ccpnc         chbpnc
072200081215     c                   move      cccmsp        chbcmsp
072300081215     c                   movel     FREE5         chbpri
072400081215
072500081218     C                   EVAL      CHSTAT = ' '
072600081215     C                   eval      chtrcod = 'LCC'
072700081215      * add rec with before and after fields
072800081215     c                   write     comhstr
072900081114    ***
073000081114     C                   ENDSR
073100081114   S***S
073200081114    ***
073300081114     C     $CHGCTL       BEGSR
073400081114    ***
073500081114     C                   MOVE      *ON           *IN80
073600081114     C                   MOVE      'C'           @@A
073700081114     C                   MOVE      *OFF          *IN30
073800081114     C                   MOVE      *ON           *IN50
073900081114     C                   EXSR      $LOADNLOCK
074000081114     C*
074100081114     C                   IF        S01MSG <> *BLANKS
074200081114     C                   LEAVESR
074300081114     C                   ENDIF
074400081114    ***
074500081114     C                   MOVE      '0'           @@E
074600081114     C                   DOU       @@E = '1'
074700081114     C*
074800081114     C                   MOVE      *ON           *IN80
074900131106     C                   EXSR      $PRCSC2
075000081114     C*
075100081114     C                   IF        @STEP = 'STEP1'
075200081114     C                   MOVE      @@STP         @STEP
075300081114     C                   MOVE      '1'           @@E
075400081114     C                   LEAVESR
075500081114     C                   ENDIF
075600081114     C*
075700081114     C                   ENDDO
075800081114    ***
075900081114     C                   ENDSR
076000081114   S***S
076100081114     C* LOAD SCREEN 2 W/O LOCKING REC
076200081114    ***
076300081114     C     $LOADNLOCK    BEGSR
076400081114    ***
076500131106     C                   EXSR      $CLRSC2
076600081114    ***
076700081114     C                   MOVEL(P)  SFPLAN        @KPL
076800081114     C                   MOVEL(P)  SFSCOD        @KSL
076900081114     C                   Z-ADD     SFEFDT        #XSX
077000081114     C                   EXSR      $USAISO
077100081114     C                   Z-ADD     #XSX          #KEF
077200081114     C                   Z-ADD     SFCNDT        #XSX
077300081114     C                   EXSR      $USAISO
077400081114     C                   Z-ADD     #XSX          #KCN
077500081114    ***
077600131106     C     HK            CHAIN(N)  C33
077700131106    2C                   IF        NOT %FOUND(COMCTX)
077800081114     C                   MOVEL(P)  MSG(11)       S01MSG
077900081114     C                   MOVEL(P)  'STEP1'       @STEP
078000081114     C                   LEAVESR
078100081114     C                   ENDIF
078200081114    ***
078300081215     C                   MOVEL     FREE5         OLPRI             1
078400081215     C                   MOVEL     FREE5         CMPRI
078500081114     C                   MOVEL     CMPLAN        R2PLAN
078600081114     C                   MOVEL(P)  CMPLAN        @KPL
078700081216     C     PLNKEY        CHAIN     PLNMSR
078800131106    1C                   IF        %FOUND(PLNUNIQUE)
078900081114     C                   MOVEL(P)  PDESCR        R2PDES
079000081114    1C                   ENDIF
079100081114     C*
079200081114     C     CMRELID       CHAIN     SRF
079300081114     C                   EXSR      $GETDESC
079400081114     C                   EXSR      $GETLINK
079500081114     C*
079600081114     C                   IF        EFFDAT <> 0
079700081114     C                   MOVE      EFFDAT        #ISO
079800081114     C                   MOVE      #ISO          #USA
079900081114     C                   MOVE      #USA          R2EFDT
080000081114     C                   ELSE
080100081114     C                   MOVE      *ZEROS        R2EFDT
080200081114     C                   ENDIF
080300081114     C*
080400081114     C                   IF        CMCAN <> 0
080500081114     C                   MOVE      CMCAN         #ISO
080600081114     C                   MOVE      #ISO          #USA
080700081114     C                   MOVE      #USA          R2CNDT
080800081114     C                   ELSE
080900081114     C                   MOVE      *ZEROS        R2CNDT
081000081114     C                   ENDIF
081100081114    ***
081200081114     C                   Z-ADD     CCOVPP        R2OVPP
081300081114     C                   Z-ADD     CCOVRA        R2OVRA
081400081114     C                   Z-ADD     CCOVPC        R2OVPC
081500081114     C                   MOVE      CCPNC         R2PNC
081600081114     C                   Z-ADD     CCCMSP        R2CMSP
081700081114    ***
081800081114     C                   ENDSR
081900081114   S***S
082000081114123456*890123456789012345678901234567890123456789012345678901234567890
082100081114      *  1111111111222222222233333333334444444444555555555566666666667
082200081114** CTDATA MSG
082300081114PLAN CODE CANNOT BE BLANK
082400081114PLAN CODE IS INVALID
082500081114RELATIONSHIP ID CANNOT BE BLANK
082600081114RELATIONSHIP ID IS INVALID OR TERMED
082700081114EFFECTIVE DATE CANNOT BE ZERO
082800081114EFFECTIVE DATE IS IN A NON-VALID FORMAT
082900081114CANCEL DATE IS IN A NON-VALID FORMAT
083000081114PLAN/SALESMAN ALREADY ACTIVE
083100081114PLAN/SLSMN/EFF DATE/TRM DATE ALREADY EXISTS
083200081114ACTIVE RECORD FOR THIS ACCOUNT ALREADY EXISTS
083300131106CANNOT FIND RECORD
083400081114%AGE OF COMMISSION CANNOT EXCEED 100%
083500081114CHOOSE %AGE, AMOUNT, OR NO COMM; CAN ONLY BE ONE
083600081114CANCEL DATE CANNOT BE 01 FOR DAY
083700081114UPDATE OF RECORD COMPLETE
083800081114COMMISSION SPLIT CANNOT EXCEED 100%
083900081114COMMISSION RATE RECORD NOT FOUND
084000081114COMM SPLIT REQUIRED FOR % OF COMM & FLAT FEE
084100081114CHOOSE %AGE, AMOUNT, OR NO COMM; REQ FOR 51+ GROUP
084200081114EFFECTIVE DATE CANNOT BE GREATER THAN CANCEL DATE
08430008111450 GROUPS REQUIRE AMOUNT & % OF PREMIUM BE ZERO
084400081114CHOOSE %AGE, AMOUNT, OR NO COMM; MUST BE AT LEAST OF THEM.
084500081114NO COMM FIELD CAN ONLY BE BLANK, N, OR P.
084600081114MUST ENTER OVERRIDE (% OF COMM OR % OF PREM) WHEN PREM SPLIT IS USED
