000100190619         ctl-opt option(*nodebugio);
000200190619
000300001130     F*********************************************************************
000400001206     F* FM081      - ADMIN FEE MAINTENANCE                                *
000500001130     F*                                                                   *
000600001206     F* WRITTEN BY    STEPHEN KING 12/06/2000                             *
000700001130     F*               INNOVATIVE OUTSOURCING  2000                        *
000800001130     F*                                                                   *
000900001130     F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE         *
001000001206     F*            ADMIN FEE FILE.                                        *
001100001130     F*                                                                   *
001200001130     F*********************************************************************
001300001130     F* MODIFICATION HISTORY                                              *
001400001130     F* ### UUU CCYYMMDD X-->                                             *
001500001206     F* 000 SSK 20001206 ORIGINAL SOURCE                                  *
001600030411     F* 001 SSK 20030411 COVENTRY CHANGES                                 *
001700090102     F* 002 SSK 20090102 ADD SOME DATES                                   *
001800161229     F* 12/29/16 dlk - change search to find market size by comm from date*
001900190619     F* 06/19/2019 B.Rees
002000190619     F*  Added a check to the READC of the subfile. If all data is blank.
002100190619     F*  Skip the record.
002200190619     F*
002300001130     F*********************************************************************
002400090102     FADMNFEE0  UF A E             DISK
002500010120     FADMNFEE3  IF   E           K DISK    RENAME(RADMNFEE:A3) PREFIX(Z:1)
002600090102     F                                     INFDS(IODBFD)
002700001220     FCARMKSZ3  IF   E           K DISK
002800001206     FFM081D    CF   E             WORKSTN INFDS(WSDS)
002900001206     F                                     SFILE(IO01S:RRT)
003000001130     ***
003100001130     D WSDS            DS
003200001130     D  FKEY                 369    369A
003300001130     ***
003400001130     D  F1             C                   CONST(X'31')
003500001130     D  F2             C                   CONST(X'32')
003600001130     D  F3             C                   CONST(X'33')
003700001130     D  F4             C                   CONST(X'34')
003800001130     D  F5             C                   CONST(X'35')
003900001130     D  F6             C                   CONST(X'36')
004000001130     D  F7             C                   CONST(X'37')
004100001130     D  F8             C                   CONST(X'38')
004200001130     D  F9             C                   CONST(X'39')
004300001130     D  F10            C                   CONST(X'3A')
004400001130     D  F11            C                   CONST(X'3B')
004500001130     D  F12            C                   CONST(X'3C')
004600001130     D  F13            C                   CONST(X'B1')
004700001130     D  F14            C                   CONST(X'B2')
004800001130     D  F15            C                   CONST(X'B3')
004900001130     D  F16            C                   CONST(X'B4')
005000001130     D  F17            C                   CONST(X'B5')
005100001130     D  F18            C                   CONST(X'B6')
005200001130     D  F19            C                   CONST(X'B7')
005300001130     D  F20            C                   CONST(X'B8')
005400001130     D  F21            C                   CONST(X'B9')
005500001130     D  F22            C                   CONST(X'BA')
005600001130     D  F23            C                   CONST(X'BB')
005700001130     D  F24            C                   CONST(X'BC')
005800001130     ***
005900090102     D @MSG            S             70A   DIM(6) CTDATA PERRCD(1)              ERROR MESSAGES
006000001206     D @STEP           S              6A   INZ('STEP1 ')                        CONTROL FIELD
006100090102     D #XSX            S              8S 0
006200090102     D #USA            S               D   DATFMT(*USA)
006300090102     D #ISO            S               D   DATFMT(*ISO)
006400001130     ***
006500001130     D* USER DATA STRUCTURE FOR TITLE OF SCREENS
006600001130     D                UDS
006700001130     D  TITLE                201    240
006800001130     ***
006900090102     D IODBFD        E DS                  EXTNAME(IODBFD)
007000090102     D #RRN                  397    400B 0
007100090102    ***
007200001130     C                   DOU       @STEP = 'EXIT'
007300001130     C     @STEP         CASEQ     'STEP1 '      $STEP1
007400001130     C     @STEP         CASEQ     'STEP2 '      $STEP2
007500001130     C                   ENDCS
007600001130     C                   ENDDO
007700001130     C*
007800001130     C                   MOVE      *ON           *INLR
007900001130   S***S
008000001130     C     *INZSR        BEGSR
008100001130     C*
008200001130     C     *ENTRY        PLIST
008300001206     C                   PARM                    @3CARR            3
008400001220     C     UNVKEY        KLIST
008500001206     C                   KFLD                    I_CARR
008600001220     C                   KFLD                    @SZCD             5
008700001130     C*
008800001130     C                   ENDSR
008900001130   S***S
009000001206     C     $STEP1        BEGSR
009100001130     C*
009200001206     C                   MOVEL     @3CARR        I_CARR
009300001206     C                   MOVE      *BLANKS       R1MSG
009400001206     C* CLEAR SFL
009500001206     C                   MOVEA     '011'         *IN(28)
009600001206     C                   WRITE     IO01C
009700001206     C                   MOVEA     '010'         *IN(28)
009800001206     C* SFL BUILD
009900001206     C                   Z-ADD     *ZERO         RRT               3 0
010000001206     C                   MOVE      *ZEROS        #O2CREC           3 0
010100001206     C                   MOVE      '0'           @1STLOOP          1
010200001206     C*
010300010120     C     I_CARR        SETLL     A3
010400010120    1C                   DOU       %EOF(ADMNFEE3)
010500010120     C     I_CARR        READE     A3
010600010120    2C                   IF        NOT %EOF(ADMNFEE3) OR #O2CREC = 100
010700001206     C*
010800001206     C                   CLEAR                   IO01S
010900001206     C                   ADD       1             #O2CREC
011000001206     C                   MOVE      *ON           *IN28
011100001206     C                   MOVE      *OFF          *IN31
011200001206     C*
011300161229      *
011400161229      * get market size range for this "from date"
011500161229      *
011600161229     C                   MOVE      *ZEROS        SFFRSZ
011700161229     C                   MOVE      *ZEROS        SFTOSZ
011800010122     C                   MOVEL(P)  ZFSZCD        @SZCD             5
011900161229     C     UNVKEY        setll     carmksz3
012000161229     c                   dou       %eof(carmksz3)
012100161229     C     UNVKEY        reade     carmksz3
012200161229     C                   if        not %eof(CARMKSZ3) and
012300161229     c                             zffromdt >= czfrdt and
012400161229     c                             (cztodt = 0 or zFFROMDT <= cztodt)
012500161229     C                   Z-ADD     CZFRSZ        SFFRSZ
012600161229     C                   Z-ADD     CZTOSZ        SFTOSZ
012700161229     c                   leave
012800161229     C                   end
012900161229     c                   enddo
013000001220     C*
013100010122     C                   MOVEL(P)  ZFSZCD        SFSZCD
013200010122     C                   Z-ADD     ZFFEE         SFFEE
013300010122     C                   Z-ADD     ZFSEQ         SFSEQ
013400030411     C                   Z-ADD     ZFFEEPP       SFFEEPP
013500030411     C                   Z-ADD     ZFFEEPC       SFFEEPC
013600090102     C                   Z-ADD     ZFFROMDT      #XSX
013700090102     C                   EXSR      $XSA
013800090102     C                   Z-ADD     #XSX          SFFROMDT
013900090102     C                   Z-ADD     ZFTODATE      #XSX
014000090102     C                   EXSR      $XSA
014100090102     C                   Z-ADD     #XSX          SFTODATE
014200001206     C*
014300090102     C                   Z-ADD     ZFFROMDT      HFFROMDT
014400090102     C                   Z-ADD     ZFTODATE      HFTODATE
014500010122     C                   MOVEL(P)  ZFSZCD        HSZCD
014600010122     C                   Z-ADD     ZFFEE         HFEE
014700010122     C                   Z-ADD     ZFSEQ         HSEQ
014800030411     C                   Z-ADD     ZFFEEPP       HFEEPP
014900030411     C                   Z-ADD     ZFFEEPC       HFEEPC
015000090102     C                   Z-ADD     #RRN          HK
015100001206     C*
015200001206     C                   ADD       1             RRT
015300001206    3C                   IF        @1STLOOP = '0'
015400001206     C                   Z-ADD     RRT           SFLRRN
015500001206     C                   MOVE      '1'           @1STLOOP
015600001206    3C                   ENDIF
015700001206     C*
015800001206     C                   WRITE     IO01S
015900001206     C*
016000001206    2C                   ENDIF
016100001206     C*
016200001206    1C                   ENDDO
016300090105     C                   CLEAR                   A3
016400090105     C                   CLEAR                   RADMNFEE
016500001206     C*
016600001206    1C                   IF        #O2CREC < 100
016700001206     C*
016800001206     C                   MOVE      *ZEROS        #DLOOP            3 0
016900001206     C                   EVAL      #DLOOP = 100 - #O2CREC
017000001206     C*
017100001206    2C                   DOU       #DLOOP = 0
017200001206     C*
017300001206     C                   CLEAR                   IO01S
017400001206     C                   MOVE      *ON           *IN28
017500001206     C                   SUB       1             #DLOOP
017600001206     C*
017700001220     C                   MOVE      *BLANKS       SFSZCD
017800001206     C                   MOVE      *ZEROS        SFFEE
017900030411     C                   MOVE      *ZEROS        SFFEEPC
018000030411     C                   MOVE      *ZEROS        SFFEEPP
018100090102     C                   MOVE      *ZEROS        SFFROMDT
018200090102     C                   MOVE      *ZEROS        SFTODATE
018300001220     C                   MOVE      *BLANKS       HSZCD
018400001206     C                   MOVE      *ZEROS        HFEE
018500030411     C                   MOVE      *ZEROS        HFEEPP
018600030411     C                   MOVE      *ZEROS        HFEEPC
018700090102     C                   MOVE      *ZEROS        HFFROMDT
018800090102     C                   MOVE      *ZEROS        HFTODATE
018900090102     C                   Z-ADD     0             HK
019000001206     C*
019100001206     C                   ADD       1             RRT
019200001206    3C                   IF        @1STLOOP = '0'
019300001206     C                   Z-ADD     RRT           SFLRRN
019400001206     C                   MOVE      '1'           @1STLOOP
019500001206    3C                   ENDIF
019600001206     C*
019700001206     C                   WRITE     IO01S
019800001206     C*
019900001206    2C                   ENDDO
020000001206     C*
020100001206    1C                   ENDIF
020200001206     C*
020300001206     C                   MOVEL(P)  'STEP2'       @STEP
020400220901     C****               MOVEL(P)  @MSG(3)       R1MSG
020500001130     C*
020600001130     C                   ENDSR
020700090102   S***S
020800090102     ****CONVERT YMD TO MDY
020900090102     C     $XSA          BEGSR
021000090102    ***
021100090102     C                   IF        #XSX = 0
021200090102     C                   LEAVESR
021300090102     C                   ENDIF
021400090102    ***
021500090102     C                   MOVE      #XSX          #ISO
021600090102     C     *USA          MOVE      #ISO          #XSX
021700090102    ***
021800090102     C                   ENDSR
021900001130   S***S
022000001130     C* PRESENT INITIAL SCREEN
022100001130     C*
022200001206     C     $STEP2        BEGSR
022300001130     C*
022400001206     C                   WRITE     IO01R
022500001206     C                   EXFMT     IO01C
022600001206     C*
022700001206     C                   MOVE      *BLANKS       R1MSG
022800001206     C                   MOVE      *OFF          *IN32
022900001130    ***
023000001130     C* EXIT APPLICATION
023100001206    1C                   IF        FKEY = F1
023200001130     C                   MOVEL(P)  'EXIT'        @STEP
023300001130     C                   LEAVESR
023400001130    1C                   ENDIF
023500001220    ***
023600001220     C* F4 = MARKET SIZES INQUIRY
023700001220    1C                   IF        FKEY = F4
023800001220     C                   MOVEL(P)  I_CARR        @P8               8
023900150121     C                   CALL      'FM005CL32'
024000001220     C                   PARM                    @P8
024100001220     C                   LEAVESR
024200001220    1C                   ENDIF
024300001130    ***
024400001206     C* VALIDATE/UPDATE RANGES
024500001206    1C                   DOU       *IN32 = *ON OR R1MSG <> *BLANKS
024600001206     C*
024700001206     C                   READC     IO01S                                  32
024800190619
024900190619         // Skip a completly blank line
025000190619         if sfszcd = '' and  sffeepc = 0 and sffeepp = 0 and
025100190619            sffee = 0 and sffromdt = 0 and sftodate = 0 and
025200190619            sfseq = 0;
025300190619          iter;
025400190619         endif;
025500190619
025600190619
025700001206     C*
025800001206    2C                   IF        *IN32 = *OFF AND R1MSG = *BLANKS
025900001206     C*
026000001206     C                   EXSR      $VALIDATE
026100001206     C*
026200001206    3C                   IF        R1MSG = *BLANKS
026300001206     C                   EXSR      $UPDATES
026400001206    3C                   ENDIF
026500001206     C*
026600001206    2C                   ENDIF
026700001206     C*
026800001206    1C                   ENDDO
026900001206    ***
027000001206    1C                   IF        R1MSG = *BLANKS
027100001206     C                   MOVEL(P)  'STEP1'       @STEP
027200001206    1C                   ENDIF
027300001206    ***
027400001206     C                   ENDSR
027500001206   S***S
027600001206     C     $VALIDATE     BEGSR
027700030414    ***
027800030414    *** An edit is not required on % of prem or % of comm, as Shelly Rapski
027900030414    *** on 4/11/2003 sent an email stating the maximum value that can be
028000030414    *** added is 99.9999%. Since this is high value, no edit required for
028100030414    *** amount entered, just an existence check of the fields.
028200001206    ***
028300001220    1C                   IF        SFSZCD = *BLANKS
028400001206     C                   MOVEL(P)  @MSG(1)       R1MSG
028500001220     C                   LEAVESR
028600001220    1C                   ENDIF
028700001220    ***
028800001220     C                   MOVEL(P)  SFSZCD        @SZCD
028900001220     C     UNVKEY        CHAIN(N)  RCARMKSZ
029000001220    1C                   IF        NOT %FOUND(CARMKSZ3)
029100001220     C                   MOVEL(P)  @MSG(2)       R1MSG
029200001220     C                   LEAVESR
029300001220    1C                   ELSE
029400001220     C                   Z-ADD     CZFRSZ        SFFRSZ
029500001220     C                   Z-ADD     CZTOSZ        SFTOSZ
029600001220    1C                   ENDIF
029700030411    ***
029800030411    1C                   IF        (SFFEE <> 0.00 AND SFFEEPP <> 0.00
029900030411     C                             AND SFFEEPC <> 0.00) or
030000030411    1C                             (SFFEE <> 0.00 AND SFFEEPP <> 0.00) or
030100030411    1C                             (SFFEEPC <> 0.00 AND SFFEEPP <> 0.00) or
030200030411    1C                             (SFFEE <> 0.00 AND SFFEEPC <> 0.00)
030300030411     C                   MOVEL(P)  @MSG(4)       R1MSG
030400030411     C                   LEAVESR
030500030411    1C                   ENDIF
030600001206    ***
030700090102     C                   IF        SFFROMDT = 0
030800090102     C                   MOVEL(P)  @MSG(5)       R1MSG
030900090102     C                   LEAVESR
031000090102     C                   ENDIF
031100090102     C     *USA          TEST(DE)                SFFROMDT
031200090102     C                   IF        %ERROR
031300090102     C                   MOVEL(P)  @MSG(5)       R1MSG
031400090102     C                   LEAVESR
031500090102     C                   ELSE
031600090102     C                   MOVE      SFFROMDT      #USA
031700090102     C                   MOVE      #USA          #ISO
031800090102     C                   MOVE      #ISO          CAP#FRM           8 0
031900090102     C                   ENDIF
032000090102    ***
032100090102     C                   IF        SFTODATE = 0
032200090102     C                   EVAL      CAP#TRM = 0
032300090102     C                   LEAVESR
032400090102     C                   ENDIF
032500090102    * *
032600090102     C     *USA          TEST(DE)                SFTODATE
032700090102     C                   IF        %ERROR
032800090102     C                   MOVEL(P)  @MSG(6)       R1MSG
032900090102     C                   LEAVESR
033000090102     C                   ENDIF
033100090102    * *
033200090102     C                   MOVE      SFTODATE      @8                8
033300090102     C                   IF        %SUBST(@8:3:2) < '28' AND
033400090102     C                             SFTODATE <> SFFROMDT
033500090102     C                   MOVEL(P)  @MSG(6)       R1MSG
033600090102     C                   LEAVESR
033700090102     C                   ENDIF
033800090102    * *
033900090102     C                   MOVE      SFTODATE      #USA
034000090102     C                   MOVE      #USA          #ISO
034100090102     C                   MOVE      #ISO          CAP#TRM           8 0
034200090102    ***
034300090102    ***
034400001206     C                   ENDSR
034500001206   S***S
034600001206     C     $UPDATES      BEGSR
034700001206    ***
034800001220    1C                   IF        HSZCD = *BLANKS
034900001220     C                   MOVEL(P)  SFSZCD        @SZCD
035000001220    1C                   ELSE
035100001220     C                   MOVEL(P)  HSZCD         @SZCD
035200001220    1C                   ENDIF
035300090102    ***
035400090102     C                   IF        HK = 0
035500001206     C                   CLEAR                   RADMNFEE
035600001206     C                   MOVEL(P)  I_CARR        AFCARR
035700001220     C                   MOVEL(P)  SFSZCD        AFSZCD
035800001206     C                   Z-ADD     SFFEE         AFFEE
035900030411     C                   Z-ADD     SFFEEPP       AFFEEPP
036000030411     C                   Z-ADD     SFFEEPC       AFFEEPC
036100010120     C                   Z-ADD     SFSEQ         AFSEQ
036200090102     C                   Z-ADD     CAP#FRM       AFFROMDT
036300090102     C                   Z-ADD     CAP#TRM       AFTODATE
036400001206     C                   WRITE     RADMNFEE
036500010120     C*
036600001220    1C                   ELSE
036700090102     C     HK            CHAIN     RADMNFEE
036800001220     C                   MOVEL(P)  SFSZCD        AFSZCD
036900001220     C                   Z-ADD     SFFEE         AFFEE
037000030411     C                   Z-ADD     SFFEEPP       AFFEEPP
037100030411     C                   Z-ADD     SFFEEPC       AFFEEPC
037200010120     C                   Z-ADD     SFSEQ         AFSEQ
037300090102     C                   Z-ADD     CAP#FRM       AFFROMDT
037400090102     C                   Z-ADD     CAP#TRM       AFTODATE
037500001206     C                   UPDATE    RADMNFEE
037600010120    1C                   ENDIF
037700010120    ***
037800001220     C                   MOVEL(P)  SFSZCD        HSZCD
037900001220     C                   Z-ADD     SFFEE         HFEE
038000090102     C                   Z-ADD     SFFEEPP       HFEEPP
038100090102     C                   Z-ADD     SFFEEPC       HFEEPC
038200010120     C                   Z-ADD     SFSEQ         HSEQ
038300001206     C                   UPDATE    IO01S
038400001206    ***
038500001206     C                   ENDSR
038600001130   X***X
038700001130**   ERROR MESSAGE ARRAY
038800001220SIZE CODE CANNOT BE BLANK
038900001220SIZE CODE IS NOT VALID
039000010108SELECTION WINDOW FOR DISPLAY ONLY
039100030411PICK ONLY ONE COMMISSION TYPE
039200090102ENTER A CORRECT DATE FOR FROM DATE
039300090102ENTER A CORRECT DATE OR ZERO FOR TO DATE
