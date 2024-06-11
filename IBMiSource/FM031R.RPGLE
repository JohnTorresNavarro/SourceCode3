000100991124     F*-------------------------------------------------------------------------
000200020208     F* FM031      GBS SOFTWARE 2002
000300991124     F*            WRITTEN BY - S.S.K.
000400020208     F*            DATE - 02/02
000500020208     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR PLAN MASTER MAINT
000600991124     F*  INDICATOR USAGE:
000700020208     F*    01 = EXIT FROM INITIAL SCREEN
000800000211     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900991124     F*    25 = SFLDSP
001000991124     F*    26 = SFL DSP CTL
001100991124     F*    27 = SFL CLR
001200020306     F*    29 = F3 CONDITIONING
001300020306     F*    28 = F5 CONDITIONING
001400991124     F*
001500991124     F*-------------------------------------------------------------------------
001600991209     ** MODIFICATION HISTORY                                              **
001700991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001800000211     ** 000  SSK  02112000  ORIGINAL SOURCE                               **
001900020604     ** 001  SSK  06042002  RESEQUENCE INDICATORS TO MATCH DISPLAY FILE   **
002000020604     **                     FOR THE AGE BAND DISPLAY.                     **
002100071102     ** 11/02/07 dlk - add round premium field                            **
002101090129     ** 01/29/09 dlk - add debit card, remove id card                     **
002102090923     ** 09/23/09 dlk - fix enrollment date change display                 **
002103120123     ** 01/23/12 dlk - change renewal date to renewal month               **
002104071102     **                                                                   **
002200991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002300020208     FPLNHIST1  IF   E           K DISK    RENAME(RPLNHIST:BEFSEQ)
002400020208     FPLNHIST2  IF   E           K DISK    RENAME(RPLNHIST:AFTSEQ)
002500001019     FGBSECURE  IF   E           K DISK
002600020208     FFM031D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002700991124   X***X
002800000211     D @PARM           DS
002900020208     D  P@TRS                  1      3S 0
003000020208     D  P@SUB                  4      6S 0
003100020208     D  P@PLN                  7     10A
003200020213     D  TRNAME                11     30A
003300020213     D  SBNAME                31     50A
003400020208     D KEY@TRS         S                   LIKE(HFTRST)
003500020208     D KEY@SUB         S                   LIKE(HFSUB#)
003600020208     D KEY@PLN         S                   LIKE(HFPLAN)
003700020208     D KEY@USR         S                   LIKE(SCUSR)
003800001019    ***
003900001019     D #ISO            S               D   DATFMT(*ISO)
004000001019     D #USA            S               D   DATFMT(*USA)
004100020208     D #ISA            S              8S 0
004200000211    ***
004300000211     D                UDS
004400000211     D  TITLE                201    240A
004500000211    ***
004600991216     D WSDS            DS
004700991216     D  FKEY                 369    369A
004800991216    ***
004900991216     D  F1             C                   CONST(X'31')
005000991216     D  F2             C                   CONST(X'32')
005100991216     D  F3             C                   CONST(X'33')
005200991216     D  F4             C                   CONST(X'34')
005300991216     D  F5             C                   CONST(X'35')
005400991216     D  F6             C                   CONST(X'36')
005500991216     D  F7             C                   CONST(X'37')
005600991216     D  F8             C                   CONST(X'38')
005700991216     D  F9             C                   CONST(X'39')
005800991216     D  F10            C                   CONST(X'3A')
005900991216     D  F11            C                   CONST(X'3B')
006000991216     D  F12            C                   CONST(X'3C')
006100991216     D  F13            C                   CONST(X'B1')
006200991216     D  F14            C                   CONST(X'B2')
006300991216     D  F15            C                   CONST(X'B3')
006400991216     D  F16            C                   CONST(X'B4')
006500991216     D  F17            C                   CONST(X'B5')
006600991216     D  F18            C                   CONST(X'B6')
006700991216     D  F19            C                   CONST(X'B7')
006800991216     D  F20            C                   CONST(X'B8')
006900991216     D  F21            C                   CONST(X'B9')
007000991216     D  F22            C                   CONST(X'BA')
007100991216     D  F23            C                   CONST(X'BB')
007200991216     D  F24            C                   CONST(X'BC')
007300020208    ***
007400020208     D @STEP           S              5A
007500020208    ***
007600020208     D DS@LOD        E DS                  EXTNAME(PLNHIST0)
007700020208     D  HMSG0150              51    100A
007800020208     D  HMSG5100             101    150A
007900020208     D DS@B4         E DS                  EXTNAME(PLNMST) PREFIX(B:1)
008000020208     D DS@AF         E DS                  EXTNAME(PLNMST) PREFIX(A:1)
008100020208    ***
008200991124   X***X
008300020208      /FREE
008400020208    *    KEY@TRS = P@TRS;
008500020208    *    KEY@SUB = P@SUB;
008600020208    *    KEY@PLN = P@PLN;
008700020208    *    @STEP = 'PREP1';
008800020208      /END-FREE
008900020208     C**
009000020208    *C                   DOU       @STEP = 'LEAVE'
009100020208    *C     @STEP         CASEQ     'PREP1'       $PREP1
009200020208    *C     @STEP         CASEQ     'STEP1'       $STEP1
009300020208    *C                   ENDCS
009400020208    *C                   ENDDO
009500020208    *C                   EVAL      *INLR = *ON
009600020208  *S***S
009700020208     C* ONETIME ROUTINE
009800020208    ***
009900020208     C     *INZSR        BEGSR
010000020208    ***
010100020208     C     *ENTRY        PLIST
010200020208     C                   PARM                    @PARM
010300020208    ***
010400020208     C     KEY#PHST      KLIST
010500020208     C                   KFLD                    KEY@TRS
010600020208     C                   KFLD                    KEY@SUB
010700020208     C                   KFLD                    KEY@PLN
010800020208    ***
010900020208     C                   MOVE      *ZEROS        RRT               3 0
011000020208     C                   MOVE      *ZEROS        #CNTREC           2 0
011100020208    ***
011200020208     C                   MOVE      '0'           @1STLOOP          1
011300020208     C                   MOVE      '0'           @SFLOOP           1
011400020208    *C*                  MOVE      '0'           @CNFRM            1
011500020208     C                   MOVE      '1'           @LOOPIT           1
011600020208     C                   MOVE      '0'           @ACTION           1
011700020208     C                   MOVE      'M'           @SEQ              1
011800020208    ***
011900020208     C                   ENDSR
012000020208  *S***S
012100020208     C     $PREP1        BEGSR
012200020208    ***
012300020208     C                   EXSR      $CLEAR
012400020208    *C*
012500020208     C                   EXSR      $BUILD
012600020208    *C*
012700020208     C                   EVAL      @STEP = 'STEP1'
012800020208     C                   EVAL      HTRST = KEY@TRS
012900020208     C                   EVAL      HSUB = KEY@SUB
013000020208     C                   EVAL      HPLAN = KEY@PLN
013100020208     C                   EVAL      TNAME = TRNAME
013200020208     C                   EVAL      SUBNAM = SBNAME
013300020208    ***
013400020208     C                   ENDSR
013500020208  *S***S
013600020208     C     $CLEAR        BEGSR
013700020208    ***
013800020208     C                   MOVEA     '011'         *IN(25)
013900020208     C                   WRITE     GBSCTL
014000020208     C                   MOVEA     '010'         *IN(25)
014100020208     C                   Z-ADD     *ZERO         RRT
014200020208    ***
014300020208     C                   ENDSR
014400020208   S***S
014500020208     C     $BUILD        BEGSR
014600020208    ***
014700020208     C                   EXSR      $CLEAR
014800020208     C                   MOVE      *ZEROS        #CNTREC
014900020208     C                   MOVE      '0'           @1STLOOP
015000020208     C                   MOVE      '0'           @SFLOOP
015100020208    ***
015200020208     C                   IF        @SEQ = 'M'
015300020208     C     KEY#PHST      SETLL     BEFSEQ
015400020208     C                   EXSR      $BLDBEF
015500020208     C                   ELSE
015600020208     C     KEY#PHST      SETLL     AFTSEQ
015700020208     C                   EXSR      $BLDAFT
015800020208     C                   ENDIF
015900020208    ***
016000020208     C                   ENDSR
016100020208   S***S
016200020208     C* BUILD BY BEFORE IMAGE
016300020208    ***
016400020208     C     $BLDBEF       BEGSR
016500020208    ***
016600020208     C                   DOU       %EOF(PLNHIST1) OR @SFLOOP = '1'
016700020208     C     KEY#PHST      READE     BEFSEQ
016800020208     C                   IF        NOT %EOF(PLNHIST1)
016900020208     C                   EXSR      $LOADSFL
017000020208     C                   ENDIF
017100020208     C                   ENDDO
017200020208    ***
017300020208     C                   ENDSR
017400020208   S***S
017500020208     C     $LOADSFL      BEGSR
017600020208    ***
017700020208     C                   MOVE      *ON           *IN25
017800020208    ***
017900020208     C                   EVAL      HDATA = DS@LOD
018000020208     C                   MOVE      *BLANKS       SEL01
018100020208     C                   EVAL      SFADES = %TRIM(%SUBST(HAFTER:11:35))
018200020208     C*
018300020208     C                   MOVEL(P)  HUSERID       KEY@USR
018400020208     C     KEY@USR       CHAIN     SECR
018500020208     C                   IF        %FOUND(GBSECURE)
018600020208     C                   MOVEL(P)  SCNAME        SFUSERID
018700020208     C                   ELSE
018800020208     C                   MOVE      *BLANKS       SFUSERID
018900020208     C                   END
019000020208     C*
019100020208     C                   MOVE      HDATE         #ISO
019200020208     C                   MOVE      #ISO          #USA
019300020208     C                   MOVE      #USA          SFDATE
019400020208     C                   Z-ADD     HTIME         SFTIME
019500020208     C*
019600020208     C                   ADD       1             RRT
019700020208     C                   IF        @1STLOOP = '0'
019800020208     C                   Z-ADD     RRT           SFLPOS
019900020208     C                   MOVE      '1'           @1STLOOP
020000020208     C                   ENDIF
020100020208     C*
020200020208     C                   WRITE     GBSSFL
020300020208    ***
020400020208     C                   ENDSR
020500020208   S***S
020600020208     C     $BLDAFT       BEGSR
020700020208     C*
020800020208     C                   DOU       %EOF(PLNHIST2) OR @SFLOOP = '1'
020900020208     C     KEY#PHST      READE     AFTSEQ
021000020208     C                   IF        NOT %EOF(PLNHIST2)
021100020208     C                   EXSR      $LOADSFL
021200020208     C                   ENDIF
021300020208     C                   ENDDO
021400020208    ***
021500020208     C                   ENDSR
021600020208   S***S
021700020208     C     $STEP1        BEGSR
021800020208    ***
021900020208     C                   EXSR      $DISPLAY
022000020208    ***
022100020208     C                   IF        FKEY = F1
022200020208     C                   EVAL      @STEP = 'LEAVE'
022300020208     C                   LEAVESR
022400020208     C                   ENDIF
022500020208    ***
022600020208     C                   IF        FKEY = F8
022700020208     C                   IF        @SEQ = 'M'
022800020208     C                   MOVE      'X'           @SEQ
022900020208     C                   ELSE
023000020208     C                   MOVE      'M'           @SEQ
023100020208     C                   ENDIF
023200020208     C                   EVAL      @STEP = 'PREP1'
023300020208     C                   LEAVESR
023400020208     C                   ENDIF
023500020208    ***
023600020214     C                   IF        RRT > 0
023700020208     C                   EXSR      $CHKSELC
023800020214     C                   ENDIF
023900020208    ***
024000020208     C                   ENDSR
024100991124   S***S
024200991124     C     $DISPLAY      BEGSR
024300991124    ***
024400000211     C                   WRITE     GBSREC
024500000211     C                   EXFMT     GBSCTL
024600991124    ***
024700991124     C                   ENDSR
024800000113   S***S
024900020208    SC     $CHKSELC      BEGSR
025000020208     C*
025100020208    1C                   DOU       %EOF(FM031D)
025200020214     C                   READC(E)  GBSSFL
025300020214    2C                   IF        NOT %EOF(FM031D) AND SEL01 = 'X' AND
025400020214     C                             NOT %ERROR
025500020208     C                   EXSR      $DSPCTL
025600020208     C                   EVAL      SEL01 = *BLANKS
025700020208     C                   UPDATE    GBSSFL
025800020208    3C                   ENDIF
025900020208    1C                   ENDDO
026000020208    ***
026100020208    SC                   ENDSR
026200020208   S***S
026300020208    SC     $DSPCTL       BEGSR
026400020208    ***
026500020208     C                   EXSR      $FMTDSP
026600020208    ***
026700020208     C                   DOU       FKEY = F1
026800020208     C                   EXFMT     EXPNDSCRA
026900020208     C                   SELECT
027000020208     C                   WHEN      FKEY = F3
027100020306     C                   IF        *IN29 = *ON
027200020306     C                   EVAL      *IN29 = *OFF
027300020208     C                   ELSE
027400020306     C                   EVAL      *IN29 = *ON
027500020208     C                   ENDIF
027600020208     C                   WHEN      FKEY = F5
027700020208     C                   EXSR      $DSPCTL2
027800020208     C                   ENDSL
027900020208    1C                   ENDDO
028000020208     C                   CLEAR                   FKEY
028100020208    ***
028200020208    SC                   ENDSR
028300020208   S***S
028400020208    SC     $FMTDSP       BEGSR
028500020208    ***
028600020306     C                   Z-ADD     29            ZZ
028700020306     C                   DO        41
028800020306     C                   ADD       1             ZZ                2 0
028900020306     C                   EVAL      *IN(ZZ) = *OFF
029000020306     C                   ENDDO
029001071102     C                   EVAL      *IN77   = *OFF
029002090923
029100020306    ***
029200020208      /FREE
029300020208       DS@LOD = HDATA;
029400020208       DS@B4 = HBEFORE;
029500020208       DS@AF = HAFTER;
029501090923      /END-FREE
029502090923
029503120123      * 1/23/12 - change to use only renewal month
029504120123
029505090923     C                   IF        BRENEW > 0
029506120123     C**                 MOVE      BRENEW        #ISO
029507120123     C**                 MOVE      #ISO          #USA
029508120123     C**                 MOVE      #USA          BRENEWU
029511120124     C                   MOVE      brenew        BRENEWU
029512090923     C                   ENDIF
029513090923     C                   IF        ARENEW > 0
029514120123     C**                 MOVE      ARENEW        #ISO
029515120123     C**                 MOVE      #ISO          #USA
029516120123     C**                 MOVE      #USA          ARENEWU
029519120124     C                   MOVE      arenew        ARENEWU
029520090923     C                   ENDIF
029521090923
029522090923      /FREE
029600020306       *IN29 = *OFF;
029700020208       IF BABFL <> 'N' OR AABFL <> 'N';
029800020306         *IN28 = *ON;
029900020208       ELSE;
030000020306         *IN28 = *OFF;
030100020208       ENDIF;
030200020306       IF BCARR      <> ACARR;
030300020306         *IN30 = *ON;
030400020306       ENDIF;
030500090129       IF Bdebit     <> Adebit;
030600020306         *IN31 = *ON;
030700020306       ENDIF;
030800020306       IF BNVCOL     <> ANVCOL;
030900020306         *IN32 = *ON;
031000020306       ENDIF;
031100020306       IF BLDLTD     <> ALDLTD;
031200020306         *IN33 = *ON;
031300020306       ENDIF;
031400020306       IF BABFL      <> AABFL;
031500020306         *IN34 = *ON;
031600020306       ENDIF;
031700020306       IF BRENEWU    <> ARENEWU;
031800020306         *IN35 = *ON;
031900020306       ENDIF;
032000020306       IF BEMITP     <> AEMITP;
032100020306         *IN36 = *ON;
032200020306       ENDIF;
032300020306       IF BULT       <> AULT;
032400020306         *IN37 = *ON;
032500020306       ENDIF;
032600020306       IF BDDESC     <> ADDESC;
032700020306         *IN38 = *ON;
032800020306       ENDIF;
032900020306       IF BOUND      <> AOUND;
033000020306         *IN39 = *ON;
033100020306       ENDIF;
033200020306       IF BRTYPE     <> ARTYPE;
033300020306         *IN40 = *ON;
033400020306       ENDIF;
033500020306       IF BRNDFL     <> ARNDFL;
033600020306         *IN41 = *ON;
033700020306       ENDIF;
033701071102       IF Brndprm    <> Arndprm;
033702071102         *IN77 = *ON;
033703071102       ENDIF;
033800020306       IF BBONP      <> ABONP;
033900020306         *IN42 = *ON;
034000020306       ENDIF;
034100020306       IF BAXBEN     <> AAXBEN;
034200020306         *IN43 = *ON;
034300020306       ENDIF;
034400020306       IF BAFP       <> AAFP;
034500020306         *IN44 = *ON;
034600020306       ENDIF;
034700020306       IF BCOMP      <> ACOMP;
034800020306         *IN45 = *ON;
034900020306       ENDIF;
035000020306       IF BDESCR     <> ADESCR;
035100020306         *IN46 = *ON;
035200020306       ENDIF;
035300020306       IF BGRRMT     <> AGRRMT;
035400020306         *IN47 = *ON;
035500020306       ENDIF;
035600020306       IF BLNCAT     <> ALNCAT;
035700020306         *IN48 = *ON;
035800020306       ENDIF;
035900020306       IF BEMITF     <> AEMITF;
036000020306         *IN49 = *ON;
036100020306       ENDIF;
036200020306       IF BFADM      <> AFADM;
036300020306         *IN50 = *ON;
036400020306       ENDIF;
036500020306       IF BABF01 <> AABF01 OR BABT01 <> AABT01;
036600020306         *IN51 = *ON;
036700020306       ENDIF;
036800020306       IF BABF02 <> AABF02 OR BABT02 <> AABT02;
036900020604         *IN53 = *ON;
037000020306       ENDIF;
037100020306       IF BABF03 <> AABF03 OR BABT03 <> AABT03;
037200020604         *IN55 = *ON;
037300020306       ENDIF;
037400020306       IF BABF04 <> AABF04 OR BABT04 <> AABT04;
037500020604         *IN57 = *ON;
037600020306       ENDIF;
037700020306       IF BABF05 <> AABF05 OR BABT05 <> AABT05;
037800020604         *IN59 = *ON;
037900020306       ENDIF;
038000020306       IF BABF06 <> AABF06 OR BABT06 <> AABT06;
038100020604         *IN61 = *ON;
038200020306       ENDIF;
038300020306       IF BABF07 <> AABF07 OR BABT07 <> AABT07;
038400020604         *IN63 = *ON;
038500020306       ENDIF;
038600020306       IF BABF08 <> AABF08 OR BABT08 <> AABT08;
038700020604         *IN65 = *ON;
038800020306       ENDIF;
038900020306       IF BABF09 <> AABF09 OR BABT09 <> AABT09;
039000020604         *IN67 = *ON;
039100020306       ENDIF;
039200020306       IF BABF10 <> AABF10 OR BABT10 <> AABT10;
039300020604         *IN69 = *ON;
039400020306       ENDIF;
039500020306       IF BABF11 <> AABF11 OR BABT11 <> AABT11;
039600020604         *IN52 = *ON;
039700020306       ENDIF;
039800020306       IF BABF12 <> AABF12 OR BABT12 <> AABT12;
039900020604         *IN54 = *ON;
040000020306       ENDIF;
040100020306       IF BABF13 <> AABF13 OR BABT13 <> AABT13;
040200020604         *IN56 = *ON;
040300020306       ENDIF;
040400020306       IF BABF14 <> AABF14 OR BABT14 <> AABT14;
040500020604         *IN58 = *ON;
040600020306       ENDIF;
040700020306       IF BABF15 <> AABF15 OR BABT15 <> AABT15;
040800020604         *IN60 = *ON;
040900020306       ENDIF;
041000020306       IF BABF16 <> AABF16 OR BABT16 <> AABT16;
041100020604         *IN62 = *ON;
041200020306       ENDIF;
041300020306       IF BABF17 <> AABF17 OR BABT17 <> AABT17;
041400020604         *IN64 = *ON;
041500020306       ENDIF;
041600020306       IF BABF18 <> AABF18 OR BABT18 <> AABT18;
041700020604         *IN66 = *ON;
041800020306       ENDIF;
041900020306       IF BABF19 <> AABF19 OR BABT19 <> AABT19;
042000020604         *IN68 = *ON;
042100020306       ENDIF;
042200020306       IF BABF20 <> AABF20 OR BABT20 <> AABT20;
042300020306         *IN70 = *ON;
042400020306       ENDIF;
042500020208      /END-FREE
043600020208    ***
043700020208    SC                   ENDSR
043800020208   S***S
043900020208    SC     $DSPCTL2      BEGSR
044000020208    ***
044100020208     C                   DOU       FKEY = F1
044200020208     C                   EXFMT     EXPNDSCRB
044300020208    1C                   ENDDO
044400020208     C                   CLEAR                   FKEY
044500020208    ***
044600020208     C                   ENDSR
044700020208   S***S
