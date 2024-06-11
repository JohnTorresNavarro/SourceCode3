000100991124     F*-------------------------------------------------------------------------
000200040708     F* IQR132     GBS SOFTWARE 2002   FM10* SALESMAN MASTER APPLICATION
000300991124     F*            WRITTEN BY - S.S.K.
000400020612     F*            DATE - 06/02
000500020612     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR SALESMAN MASTER MAINT
000600991124     F*  INDICATOR USAGE:
000700020208     F*    01 = EXIT FROM INITIAL SCREEN
000800000211     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900991124     F*    25 = SFLDSP
001000991124     F*    26 = SFL DSP CTL
001100991124     F*    27 = SFL CLR
001200991124     F*
001300991124     F*-------------------------------------------------------------------------
001400991209     ** MODIFICATION HISTORY                                              **
001500991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001600020612     ** 000  SSK  06112002  ORIGINAL SOURCE                               **
001700021203     ** 001  SSK  12032002  DEFINE TWO NEW FIELDS DERIVED FROM FILL20     **
001800030401     ** 002  ssk  04012003  salesman relationship project                 **
001900040708     ** ***  SSK  01012004  COPY FM103R TO IQ                             **
002000991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100020612     FSLMHIST1  IF   E           K DISK    RENAME(RSLMHIST:BEFSEQ)
002200020612     FSLMHIST2  IF   E           K DISK    RENAME(RSLMHIST:AFTSEQ)
002300020612     FGBSECURE  IF   E           K DISK
002400040708     FIQR132D   CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002500991124   X***X
002600020614     D P@3             S              3A
002700020614     D P@4             S              4A
002800020612     D KEY@SLM         S              3A
002900020612     D KEY@DTE         S              8S 0
003000020208     D KEY@USR         S                   LIKE(SCUSR)
003100001019    ***
003200001019     D #ISO            S               D   DATFMT(*ISO)
003300001019     D #USA            S               D   DATFMT(*USA)
003400020208     D #ISA            S              8S 0
003500000211    ***
003600000211     D                UDS
003700000211     D  TITLE                201    240A
003800000211    ***
003900991216     D WSDS            DS
004000991216     D  FKEY                 369    369A
004100991216    ***
004200991216     D  F1             C                   CONST(X'31')
004300991216     D  F2             C                   CONST(X'32')
004400991216     D  F3             C                   CONST(X'33')
004500991216     D  F4             C                   CONST(X'34')
004600991216     D  F5             C                   CONST(X'35')
004700991216     D  F6             C                   CONST(X'36')
004800991216     D  F7             C                   CONST(X'37')
004900991216     D  F8             C                   CONST(X'38')
005000991216     D  F9             C                   CONST(X'39')
005100991216     D  F10            C                   CONST(X'3A')
005200991216     D  F11            C                   CONST(X'3B')
005300991216     D  F12            C                   CONST(X'3C')
005400991216     D  F13            C                   CONST(X'B1')
005500991216     D  F14            C                   CONST(X'B2')
005600991216     D  F15            C                   CONST(X'B3')
005700991216     D  F16            C                   CONST(X'B4')
005800991216     D  F17            C                   CONST(X'B5')
005900991216     D  F18            C                   CONST(X'B6')
006000991216     D  F19            C                   CONST(X'B7')
006100991216     D  F20            C                   CONST(X'B8')
006200991216     D  F21            C                   CONST(X'B9')
006300991216     D  F22            C                   CONST(X'BA')
006400991216     D  F23            C                   CONST(X'BB')
006500991216     D  F24            C                   CONST(X'BC')
006600020208    ***
006700020208     D @STEP           S              5A
006800020208    ***
006900020612     D DS@LOD        E DS                  EXTNAME(SLMHIST0)
007000020614     D  HMSG1                 44     93A
007100020614     D  HMSG2                 94    143A
007200030401    ***
007300020612     D DS@B4         E DS                  EXTNAME(SMAN) PREFIX(B)
007400020612     D  BLN                    4     21A
007500020612     D  BFN                   22     33A
007600020612     D  BMI                   34     34A
007700020612     D  BADDR                 35     64A
007800020612     D  BCITY                 65     79
007900020612     D  BSTAT                 80     81A
008000020612     D  BZIP                  82     86P 0
008100020612     D  BAREA                 87     88P 0
008200020612     D  BPHONE                89     92P 0
008300020612     D  BTYPE                 93     95A
008400020612     D  BGRPR                111    115A
008500030311     D  BTINA                237    245A
008600021203     D  BTIN                 237    245S 0
008700020612     D  BDLTD                256    256A
008800030401    ***
008900020612     D DS@AF         E DS                  EXTNAME(SMAN) PREFIX(A)
009000020612     D  ALN                    4     21A
009100020612     D  AFN                   22     33A
009200020612     D  AMI                   34     34A
009300020612     D  AADDR                 35     64A
009400020612     D  ACITY                 65     79
009500020612     D  ASTAT                 80     81A
009600020612     D  AZIP                  82     86P 0
009700020612     D  AAREA                 87     88P 0
009800020612     D  APHONE                89     92P 0
009900020612     D  ATYPE                 93     95A
010000020612     D  AGRPR                111    115A
010100030311     D  ATINA                237    245A
010200021203     D  ATIN                 237    245S 0
010300020612     D  ADLTD                256    256A
010400020208    ***
010500991124   X***X
010600020208      /FREE
010700020614         O_SMAN = P@3;
010800020614         O_INSR = P@4;
010900020612         KEY@DTE = 00010101;
011000020614         KEY@SLM = P@3;
011100020614         @STEP = 'PREP1';
011200020208      /END-FREE
011300020208     C**
011400020208    *C                   DOU       @STEP = 'LEAVE'
011500020208    *C     @STEP         CASEQ     'PREP1'       $PREP1
011600020208    *C     @STEP         CASEQ     'STEP1'       $STEP1
011700020208    *C                   ENDCS
011800020208    *C                   ENDDO
011900020208    *C                   EVAL      *INLR = *ON
012000020208  *S***S
012100020208     C* ONETIME ROUTINE
012200020208    ***
012300020208     C     *INZSR        BEGSR
012400020208    ***
012500020208     C     *ENTRY        PLIST
012600020614     C                   PARM                    P@3
012700020614     C                   PARM                    P@4
012800020208    ***
012900020612     C     KEY#SHST      KLIST
013000020612     C                   KFLD                    KEY@SLM
013100020612     C                   KFLD                    KEY@DTE
013200020208    ***
013300020208     C                   MOVE      *ZEROS        RRT               3 0
013400020208     C                   MOVE      *ZEROS        #CNTREC           2 0
013500020208    ***
013600020208     C                   MOVE      '0'           @1STLOOP          1
013700020208     C                   MOVE      '0'           @SFLOOP           1
013800020208    *C*                  MOVE      '0'           @CNFRM            1
013900020208     C                   MOVE      '1'           @LOOPIT           1
014000020208     C                   MOVE      '0'           @ACTION           1
014100020208     C                   MOVE      'M'           @SEQ              1
014200020208    ***
014300020208     C                   ENDSR
014400020208  *S***S
014500020208     C     $PREP1        BEGSR
014600020208    ***
014700020208     C                   EXSR      $CLEAR
014800020208    *C*
014900020208     C                   EXSR      $BUILD
015000020208    *C*
015100020208     C                   EVAL      @STEP = 'STEP1'
015200020208    ***
015300020208     C                   ENDSR
015400020208  *S***S
015500020208     C     $CLEAR        BEGSR
015600020208    ***
015700020208     C                   MOVEA     '011'         *IN(25)
015800020208     C                   WRITE     GBSCTL
015900020208     C                   MOVEA     '010'         *IN(25)
016000020208     C                   Z-ADD     *ZERO         RRT
016100020208    ***
016200020208     C                   ENDSR
016300020208   S***S
016400020208     C     $BUILD        BEGSR
016500020208    ***
016600020208     C                   EXSR      $CLEAR
016700020208     C                   MOVE      *ZEROS        #CNTREC
016800020208     C                   MOVE      '0'           @1STLOOP
016900020208     C                   MOVE      '0'           @SFLOOP
017000020208    ***
017100020208     C                   IF        @SEQ = 'M'
017200020612     C     KEY#SHST      SETLL     BEFSEQ
017300020208     C                   EXSR      $BLDBEF
017400020208     C                   ELSE
017500020612     C     KEY#SHST      SETLL     AFTSEQ
017600020208     C                   EXSR      $BLDAFT
017700020208     C                   ENDIF
017800020614    ***
017900020614     C                   EVAL      I_DTE = 0
018000020208    ***
018100020208     C                   ENDSR
018200020208   S***S
018300020208     C* BUILD BY BEFORE IMAGE
018400020208    ***
018500020208     C     $BLDBEF       BEGSR
018600020208    ***
018700020612     C                   DOU       %EOF(SLMHIST1) OR @SFLOOP = '1'
018800020614     C     KEY@SLM       READE     BEFSEQ
018900020612     C                   IF        NOT %EOF(SLMHIST1)
019000020208     C                   EXSR      $LOADSFL
019100020208     C                   ENDIF
019200020208     C                   ENDDO
019300020208    ***
019400020208     C                   ENDSR
019500020208   S***S
019600020208     C     $LOADSFL      BEGSR
019700020208    ***
019800020208     C                   MOVE      *ON           *IN25
019900020208    ***
020000020208     C                   EVAL      HDATA = DS@LOD
020100020208     C                   MOVE      *BLANKS       SEL01
020200020612     C                   EVAL      SFADES = %SUBST(HAFTER:4:18) + ' ' +
020300020612     C                                      %SUBST(HAFTER:22:12) + ' ' +
020400020612     C                                      %SUBST(HAFTER:34:1)
020500020208     C*
020600020208     C                   MOVEL(P)  HUSERID       KEY@USR
020700020208     C     KEY@USR       CHAIN     SECR
020800020208     C                   IF        %FOUND(GBSECURE)
020900020208     C                   MOVEL(P)  SCNAME        SFUSERID
021000020208     C                   ELSE
021100020208     C                   MOVE      *BLANKS       SFUSERID
021200020208     C                   END
021300020208     C*
021400020208     C                   MOVE      HDATE         #ISO
021500020208     C                   MOVE      #ISO          #USA
021600020208     C                   MOVE      #USA          SFDATE
021700020208     C                   Z-ADD     HTIME         SFTIME
021800020208     C*
021900020208     C                   ADD       1             RRT
022000020208     C                   IF        @1STLOOP = '0'
022100020208     C                   Z-ADD     RRT           SFLPOS
022200020208     C                   MOVE      '1'           @1STLOOP
022300020208     C                   ENDIF
022400020208     C*
022500020208     C                   WRITE     GBSSFL
022600020208    ***
022700020208     C                   ENDSR
022800020208   S***S
022900020208     C     $BLDAFT       BEGSR
023000020208     C*
023100020612     C                   DOU       %EOF(SLMHIST2) OR @SFLOOP = '1'
023200020614     C     KEY@SLM       READE     AFTSEQ
023300020612     C                   IF        NOT %EOF(SLMHIST2)
023400020208     C                   EXSR      $LOADSFL
023500020208     C                   ENDIF
023600020208     C                   ENDDO
023700020208    ***
023800020208     C                   ENDSR
023900020208   S***S
024000020208     C     $STEP1        BEGSR
024100020208    ***
024200020208     C                   EXSR      $DISPLAY
024300020208    ***
024400020208     C                   IF        FKEY = F1
024500020208     C                   EVAL      @STEP = 'LEAVE'
024600020208     C                   LEAVESR
024700020208     C                   ENDIF
024800020208    ***
024900020208     C                   IF        FKEY = F8
025000020208     C                   IF        @SEQ = 'M'
025100020208     C                   MOVE      'X'           @SEQ
025200020208     C                   ELSE
025300020208     C                   MOVE      'M'           @SEQ
025400020208     C                   ENDIF
025500020208     C                   EVAL      @STEP = 'PREP1'
025600020208     C                   LEAVESR
025700020208     C                   ENDIF
025800020614    ***
025900020614     C                   IF        I_DTE <> 0
026000020614     C                   EVAL      @STEP = 'PREP1'
026100020614     C                   LEAVESR
026200020614     C                   ENDIF
026300020208    ***
026400020214     C                   IF        RRT > 0
026500020208     C                   EXSR      $CHKSELC
026600020214     C                   ENDIF
026700020208    ***
026800020208     C                   ENDSR
026900991124   S***S
027000991124     C     $DISPLAY      BEGSR
027100991124    ***
027200000211     C                   WRITE     GBSREC
027300000211     C                   EXFMT     GBSCTL
027400991124    ***
027500991124     C                   ENDSR
027600000113   S***S
027700020208    SC     $CHKSELC      BEGSR
027800020208     C*
027900040708    1C                   DOU       %EOF(IQR132D)
028000020214     C                   READC(E)  GBSSFL
028100040708    2C                   IF        NOT %EOF(IQR132D) AND SEL01 = 'X' AND
028200020214     C                             NOT %ERROR
028300020208     C                   EXSR      $DSPCTL
028400020208     C                   EVAL      SEL01 = *BLANKS
028500020208     C                   UPDATE    GBSSFL
028600020208    3C                   ENDIF
028700020208    1C                   ENDDO
028800020208    ***
028900020208    SC                   ENDSR
029000020208   S***S
029100020208    SC     $DSPCTL       BEGSR
029200020208    ***
029300020208     C                   EXSR      $FMTDSP
029400020208    ***
029500020208     C                   DOU       FKEY = F1
029600021203     C*
029700020208     C                   EXFMT     EXPNDSCRA
029800021203     C*
029900021203     C*
030000020208    1C                   ENDDO
030100020208     C                   CLEAR                   FKEY
030200020208    ***
030300020208    SC                   ENDSR
030400020208   S***S
030500020208    SC     $FMTDSP       BEGSR
030600020208    ***
030700021203     C                   EVAL      *IN30 = *OFF
030800020612     C                   Z-ADD     41            ZZ
030900020612     C                   DO        20
031000020306     C                   ADD       1             ZZ                2 0
031100020306     C                   EVAL      *IN(ZZ) = *OFF
031200020306     C                   ENDDO
031300020614    ***
031400020614     C                   MOVEL(P)  HUSERID       KEY@USR
031500020614     C     KEY@USR       CHAIN     SECR
031600020614     C                   IF        %FOUND(GBSECURE)
031700020614     C                   MOVEL(P)  SCNAME        GBSUSER
031800020614     C                   ELSE
031900020614     C                   MOVE      *BLANKS       GBSUSER
032000020614     C                   END
032100020306    ***
032200020208      /FREE
032300020208       DS@LOD = HDATA;
032400020208       DS@B4 = HBEFORE;
032500020208       DS@AF = HAFTER;
032600020612       IF BLN        <> ALN;
032700020612         *IN41 = *ON;
032800020208       ENDIF;
032900020612       IF BFN        <> AFN;
033000020612         *IN42 = *ON;
033100020306       ENDIF;
033200020612       IF BMI        <> AMI;
033300020612         *IN43 = *ON;
033400020306       ENDIF;
033500020612       IF BADDR      <> AADDR;
033600020612         *IN44 = *ON;
033700020306       ENDIF;
033800020612       IF BCITY      <> ACITY;
033900020612         *IN45 = *ON;
034000020306       ENDIF;
034100020612       IF BSTAT      <> ASTAT;
034200020612         *IN46 = *ON;
034300020306       ENDIF;
034400020612       IF BZIP       <> AZIP;
034500020612         *IN47 = *ON;
034600020306       ENDIF;
034700020612       IF BAREA      <> AAREA;
034800020612         *IN48 = *ON;
034900020306       ENDIF;
035000020612       IF BPHONE     <> APHONE;
035100020612         *IN48 = *ON;
035200020306       ENDIF;
035300020612       IF BTYPE      <> ATYPE;
035400020612         *IN49 = *ON;
035500020306       ENDIF;
035600020612       IF BGRPR      <> AGRPR;
035700020612         *IN51 = *ON;
035800020306       ENDIF;
035900020612       IF BDLTD      <> ADLTD;
036000020612         *IN54 = *ON;
036100020306       ENDIF;
036200030311       BTINA = %XLATE(' ':'0':BTINA);
036300030311       ATINA = %XLATE(' ':'0':ATINA);
036400021203       IF BTIN       <> ATIN;
036500021203         *IN30 = *ON;
036600021203         *IN55 = *ON;
036700021203       ENDIF;
036800020208      /END-FREE
036900020612     C                   IF        ASBEGDT <> BSBEGDT
037000020612     C                   EVAL      *IN52 = *ON
037100020612     C                   IF        ASBEGDT > 0
037200020612     C                   MOVE      ASBEGDT       #ISO
037300020208     C                   MOVE      #ISO          #USA
037400020612     C                   MOVE      #USA          AEFFDTE
037500020220     C                   ENDIF
037600020612     C                   IF        BSBEGDT > 0
037700020612     C                   MOVE      BSBEGDT       #ISO
037800020208     C                   MOVE      #ISO          #USA
037900020612     C                   MOVE      #USA          BEFFDTE
038000020612     C                   ENDIF
038100020220     C                   ENDIF
038200020614    ***
038300020614     C                   MOVE      HDATE         #ISO
038400020614     C                   MOVE      #ISO          #USA
038500020614     C                   MOVE      #USA          HDATE
038600020208    ***
038700020612     C                   IF        ASENDDT <> BSENDDT
038800020612     C                   EVAL      *IN53 = *ON
038900020612     C                   IF        ASENDDT > 0
039000020612     C                   MOVE      ASENDDT       #ISO
039100020612     C                   MOVE      #ISO          #USA
039200020612     C                   MOVE      #USA          ATERMDT
039300020612     C                   ENDIF
039400020612     C                   IF        BSENDDT > 0
039500020612     C                   MOVE      BSENDDT       #ISO
039600020612     C                   MOVE      #ISO          #USA
039700020612     C                   MOVE      #USA          BTERMDT
039800020612     C                   ENDIF
039900020612     C                   ENDIF
040000020612    ***
040100020208    SC                   ENDSR
040200020208   S***S
