000100151116     H option(*noDebugIo)
000200020613     F*-------------------------------------------------------------------------
000300020613     F* FM104      INNOVATIVE OUTSOURCING SOFTWARE 2002
000400020613     F*            FM10* SALESMAN MASTER APPLICATION
000500020613     F*            WRITTEN BY - S.S.K.
000600020613     F*            DATE - 06/02
000700020613     F*  DESCRIPTION - PROMPT
000800020613     F*  INDICATOR USAGE:
000900020613     F*    01 = EXIT FROM INITIAL SCREEN
001000020613     F*    25 = SFLDSP
001100020613     F*    26 = SFL DSP CTL
001200020613     F*    27 = SFL CLR
001300021203     F*
001400021203     F*-------------------------------------------------------------------------
001500020613     ** MODIFICATION HISTORY                                              **
001600020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001700020613     ** 000  SSK  06132002  ORIGINAL SOURCE                               **
001800021203     ** 001  SSK  12032002  DEFINE TWO NEW FIELDS DERIVED FROM FILL20     **
001900021209     ** 002  SSK  12092002  REMOVE REQUIREMENT FOR SS#                    **
002000030211001  ** 003  SSK  02102003  BREAK FILL20 INTO FOUR FIELDS                 **
002100030313     ** 004  SSK  03132003  GROUPER CODE MOD                              **
002200080204     ** 10/05/05 dlk - add salesman type edit                             **
002300080204     ** 02/03/2008 SSK REMOVE OLD CHANGES TO RESTORE SOURCE BACK, USER CHANGED MIND.
002400110418     ** 04/18/2011 SSK ADD MARKETING DIARY NOTES
002500110701     ** 06.30.2011 SSK ADD SALESMAN RELATIONSHIP MANAGER.                 **
002600160916     ** 11.11.2015 JT - Added NPN file (NP Number) and maintenance code
002700160916     ** 11.07.2016 JT - Fixed issue with blank sman code in NPN file.
002800110418     **
002900020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
003000020613     FFM104D    CF   E             WORKSTN INFDS(WSDS)
003100040928     Fsman2l1   IF   E           K DISK    RENAME(sman2r:F1X) PREFIX(XY:2)
003200020613     FSMAN      UF A E           K DISK
003300020613     FCODES     IF   E           K DISK
003400040928     Fsman2l    UF A E           K DISK
003500020613     FSLMHIST0  O  A E             DISK
003600090105     FIRMMSTP   IF   E           K DISK
003700090105     FMKTSTSP   UF A E           K DISK
003800110701     FRMGRMST3  IF   E           K DISK
003900110701     FSMANRMGP  UF A E           K DISK
004000151111
004100151111     Fnpn       uf a e           k disk
004200151111
004300020612   X***X
004400020612     D WSDS            DS
004500020612     D  FKEY                 369    369A
004600020612    ***
004700020612     D  F1             C                   CONST(X'31')
004800020612     D  F2             C                   CONST(X'32')
004900020612     D  F3             C                   CONST(X'33')
005000020612     D  F4             C                   CONST(X'34')
005100020612     D  F5             C                   CONST(X'35')
005200020612     D  F6             C                   CONST(X'36')
005300020612     D  F7             C                   CONST(X'37')
005400020612     D  F8             C                   CONST(X'38')
005500020612     D  F9             C                   CONST(X'39')
005600020612     D  F10            C                   CONST(X'3A')
005700020612     D  F11            C                   CONST(X'3B')
005800020612     D  F12            C                   CONST(X'3C')
005900020612     D  F13            C                   CONST(X'B1')
006000020612     D  F14            C                   CONST(X'B2')
006100020612     D  F15            C                   CONST(X'B3')
006200020612     D  F16            C                   CONST(X'B4')
006300020612     D  F17            C                   CONST(X'B5')
006400020612     D  F18            C                   CONST(X'B6')
006500020612     D  F19            C                   CONST(X'B7')
006600020612     D  F20            C                   CONST(X'B8')
006700020612     D  F21            C                   CONST(X'B9')
006800020612     D  F22            C                   CONST(X'BA')
006900020612     D  F23            C                   CONST(X'BB')
007000020612     D  F24            C                   CONST(X'BC')
007100020613    ***
007200020613      *
007300020613    *** TIMESTAMP FIELDS DATA STRUCTURE
007400020613      *
007500020613     D @TIMESTAMP      DS
007600020613     D  #TSCYMD                1      8S 0
007700020613     D  #TSTIME                9     14S 0
007800020613     D  @TSJOB                15     24
007900020613     D  @TSUSER               25     34
008000020613     D  #TSNBR                35     40S 0
008100020613    ***
008200020613     D #ISO            S               D   DATFMT(*ISO)
008300020613     D #USA            S               D   DATFMT(*USA)
008400020613     D #7              S              7S 0
008500020613     D @7              S              7A
008600020613     D #9              S              9S 0
008700020613     D @VP             S              1A
008800020613     D @5              S              5A
008900020613     D @9              S              9A
009000020613     D @TS40           S             40A
009100020613     D DS@SM         E DS                  EXTNAME(SMAN)
009200020612    ***
009300020613     D @IM             S              1A
009400020613     D KEY@TYPE        S                   LIKE(TYPE)
009500020613     D KEY@CODE        S                   LIKE(CODE)
009600020612     D @STEP           S              5A
009700020613     D P@1             S              1A
009800020612     D P@3             S              3A
009900020613     D P@4             S              4A
010000040929    ***
010100040929     d                 ds
010200040929     d parms@out               1     51a
010300040929     d  po@grpr                1      5a
010400040929     d  po@sman                6      8a
010500040929     d  po@name                9     43a
010600040929     d  po@term               44     51a
010700090105    ***
010800090105     D DS@IRM        E DS                  EXTNAME(IRMMSTP)
010900090206     D  IMTXT1                 4     43A
011000090206     D  IMTXT2                44     83A
011100020612    ***
011200020613     D @3              S              3A
011300020612     D @EMSG           S             70A
011400020613     D @LD             S                   LIKE(LDESCR)
011500020612   X***X
011600020613    1C                   DOU       @STEP = 'LEAVE'
011700020613    2C     @STEP         CASEQ     'PREP1'       $PREP1
011800020613    2C     @STEP         CASEQ     'STEP1'       $STEP1
011900020613    2C                   ENDCS
012000020613    1C                   ENDDO
012100020612    ***
012200020612     C                   MOVE      *ON           *INLR
012300020612   S***S
012400020612     C     *INZSR        BEGSR
012500020612    ***
012600020612     C     *ENTRY        PLIST
012700020613     C                   PARM                    P@3
012800020613     C                   PARM                    P@4
012900020613     C                   PARM                    P@1
013000020613    ***
013100020613     C     KEY@CODES     KLIST
013200020613     C                   KFLD                    KEY@TYPE
013300020613     C                   KFLD                    KEY@CODE
013400020613    ***
013500090107     C                   EVAL      @CTYPE = 'S'
013600020617     C                   CLEAR                   RSLMHIST
013700020617     C                   CLEAR                   DS@SM
013800020613     C                   MOVEL     P@3           I_SMAN
013900020613     C                   MOVE      P@1           @IM
014000020613     C                   EVAL      @STEP = 'PREP1'
014100020613    ***
014200020613     C                   ENDSR
014300020613   S***S
014400020613     C     $PREP1        BEGSR
014500020613    ***
014600020613    1C                   SELECT
014700020613    1C                   WHEN      @IM = 'I'
014800020613     C                   MOVEA     '11'          *IN(25)
014900020613    1C                   OTHER
015000020613     C                   CLEAR                   RSLMHIST
015100020613     C                   MOVEL     I_SMAN        HFSMAN
015200020613     C                   MOVEA     '00'          *IN(25)
015300020613    1C                   ENDSL
015400020613    ***
015500020617    1C                   SELECT
015600110701    * * *
015700020617    1C                   WHEN      @IM = 'I'
015800020613     C     I_SMAN        CHAIN(N)  SMANR
015900151111
016000151111       chain(n) i_sman npnr;
016100151111
016200021203     C                   EXSR      $FMTREC
016300110701    * * *
016400020617    1C                   WHEN      @IM = 'M'
016500020613     C     I_SMAN        CHAIN     SMANR
016600020617     C                   MOVEL     DS@SM         HBEFORE
016700151111       chain i_sman npnr;
016800020614     C                   EXSR      $FMTREC
016900110701    * * *
017000020617    1C                   WHEN      @IM = 'A'
017100020617     C                   CLEAR                   DS@SM
017200030723     c                   move      'N'           dftbroker
017300020617     C                   MOVEL     DS@SM         HBEFORE
017400090107     C                   EVAL      *IN28 = *OFF
017500090107     C                   EVAL      *IN30 = *OFF
017600090107     C                   EVAL      *IN31 = *OFF
017700030709     C                   EXSR      $SETGRPR
017800110701     C                   EVAL      SCRMGR = '*UA*'
017900110701     C     SCRMGR        CHAIN     RMGRMSTR
018000110701     C                   IF        %FOUND(RMGRMST3)
018100110701     C                   EVAL      D_RMGR = RMNAME
018200110701    1C                   ENDIF
018300110701    * * *
018400020617    1C                   ENDSL
018500020613    ***
018600020613     C                   EVAL      @STEP = 'STEP1'
018700020614    ***
018800020614     C                   ENDSR
018900020614   S***S
019000030709     C     $SETGRPR      BEGSR
019100020614    ***
019200030709     C                   CALL      'FM104CLU'
019300030709     C                   PARM                    @nxtgrp           5
019400030709     C                   MOVEL     @nxtgrp       SGRP
019500030709     C                   EVAL      @EMSG = 'SUGGESTED NEXT GROUPER NUMBER'
019600030709    ***
019700030709     C                   ENDSR
019800030709   S***S
019900030709     C     $FMTREC       BEGSR
020000030709    ***
020100020614     C                   EVAL      @9 = %EDITC(SZIPCD:'X')
020200020614     C                   MOVEL     @9            SZIP5
020300020614     C                   MOVE      @9            SZIP4
020400020614    ***
020500020614     C                   EVAL      @7 = %EDITC(SPHONE:'X')
020600020614     C                   MOVEL     @7            SPHONE3
020700020614     C                   MOVE      @7            SPHONE4
020800020614    ***
020900020614     C                   IF        SBEGDT > 0
021000020614     C     SBEGDT        MULT      10000.0001    I_BEGDT
021100020614     C                   ENDIF
021200020612    ***
021300020614     C                   IF        SENDDT > 0
021400020617     C     SENDDT        MULT      10000.0001    I_ENDDT
021500020614     C                   ENDIF
021600020614    ***
021700020614     C                   MOVE      STYPE         I_STYPE
021800020614     C                   EXSR      $GETCODES
021900080204    ***
022000090105     C                   EVAL      *IN28 = *ON
022100090105     C                   EVAL      *IN30 = *ON
022200090105     C                   EVAL      *IN31 = *OFF
022300090105     C                   EVAL      INAC = *BLANKS
022400090105    * *
022500090105     C                   IF        SENDDT <> 0
022600090105    * *
022700090206     C                   EVAL      *IN31 = *ON
022800090105    * *
022900090105     C     KL#MS         CHAIN     MKTSTSR
023000090105     C                   IF        %FOUND(MKTSTSP)
023100090105    * *
023200090206     C                   EVAL      INAC = MSREASN
023300090206     C                   IF        %SUBST(MSREASN:1:1) = 'I'
023400090105     C                   EVAL      *IN28 = *OFF
023500090105     C                   EVAL      *IN30 = *ON
023600090206     C                   ELSE
023700090206     C                   EVAL      *IN28 = *ON
023800090206     C                   EVAL      *IN30 = *OFF
023900090206     C                   ENDIF
024000090105    * *
024100090105     C     MSREASN       CHAIN     IRMMSTR
024200090105     C                   IF        NOT %FOUND(IRMMSTP)
024300090105    * *
024400090105     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
024500090105    * *
024600090105     C                   ENDIF
024700090206    * *
024800090206     C                   ELSE
024900090206    * *
025000090206     C                   EVAL      *IN28 = *ON
025100090206     C                   EVAL      *IN30 = *OFF
025200090105    * *
025300090105     C                   ENDIF
025400090105    * *
025500090105     C                   ENDIF
025600090105    ***
025700110701     C     I_SMAN        CHAIN     SMANRMGR
025800110701     C                   IF        %FOUND(SMANRMGP)
025900110701     C                   EVAL      SCRMGR = SMRMGR
026000110701     C     SMRMGR        CHAIN     RMGRMSTR
026100110701     C                   IF        %FOUND(RMGRMST3)
026200110701     C                   EVAL      D_RMGR = RMNAME
026300110701     C                   ELSE
026400110701     C                   EVAL      D_RMGR = '*INVALID*'
026500110701    1C                   ENDIF
026600110701     C                   ELSE
026700110701     C                   EVAL      SCRMGR = *BLANKS
026800110701     C                   EVAL      D_RMGR = '*INVALID*'
026900110701    1C                   ENDIF
027000110701    ***
027100080204     C                   SELECT
027200080204     C                   WHEN      FUSE = 'F'
027300080204     C                   EVAL      D_PDTSOLD = 'FULLY INSURED'
027400080204     C                   WHEN      FUSE = 'S'
027500080204     C                   EVAL      D_PDTSOLD = 'SELF FUNDED'
027600080204     C                   WHEN      FUSE = 'B'
027700080204     C                   EVAL      D_PDTSOLD = 'BOTH FULLY INSURED AND ' +
027800080204     C                                         'SELF FUNDED'
027900080204     C                   ENDSL
028000080204    ***
028100030723     C     I_SMAN        CHAIN     F1X
028200080325     C                   IF        %FOUND(sman2l1) AND XYRPCD = SGRP
028300030723     C                   EVAL      DFTBROKER = 'Y'
028400030723     C                   ELSE
028500030723     C                   EVAL      DFTBROKER = 'N'
028600030723     C                   ENDIF
028700020614    ***
028800030304     C                   MOVE      STIN          SCTIN
028900151111
029000151111       npnc = npnumber;
029100151111
029200020614    ***
029300020612     C                   ENDSR
029400020612   S***S
029500020612     C     $STEP1        BEGSR
029600020612    ***
029700020612     C                   MOVEL     @EMSG         EMSG
029800090107    * *
029900020612     C                   EXFMT     IO01
030000090107    * *
030100020612     C                   MOVE      *BLANKS       EMSG
030200020612     C                   MOVE      *BLANKS       @EMSG
030300090107    * *
030400020614    1C                   IF        @IM <> 'I'
030500020613     C                   MOVE      *BLANKS       O_LDESCR
030600020614     C                   ENDIF
030700110418    ***
030800110418    1C                   IF        FKEY = F2
030900110418     C                   EXSR      $F2
031000110418     C                   LEAVESR
031100110418    1C                   ENDIF
031200020612    ***
031300020613    1C                   IF        FKEY = F7
031400020612     C                   EVAL      @STEP = 'LEAVE'
031500020613     C                   MOVE      'X'           P@1
031600020612     C                   LEAVESR
031700020613    1C                   ENDIF
031800020612    ***
031900020613    1C                   IF        FKEY = F1
032000090107     C                   IF        *IN25 = *OFF
032100020613     C                   EVAL      @STEP = 'LEAVE'
032200020613     C                   MOVE      *BLANKS       P@1
032300090107     C                   ELSE
032400090107     C                   EVAL      *IN25 = *OFF
032500090107     C                   ENDIF
032600020613     C                   LEAVESR
032700020613    1C                   ENDIF
032800020613    ***
032900040709    1C                   IF        FKEY = F11
033000090107     C                   EXSR      $FM1042
033100040709     C                   LEAVESR
033200040709    1C                   ENDIF
033300040709    ***
033400090105    1C                   IF        FKEY = F4
033500090107     C                   EXSR      $F4
033600020613     C                   LEAVESR
033700020613    1C                   ENDIF
033800020612    ***
033900090107    1C                   IF        @IM = 'I'
034000090107     C                   LEAVESR
034100090107    1C                   ENDIF
034200090107    ***
034300090107    1C                   IF        FKEY = F10
034400090107     C                   EXSR      $F10
034500090107     C                   LEAVESR
034600090107    1C                   ENDIF
034700020612    ***
034800090107     C                   EXSR      $VALID
034900090107    * *
035000090107     C                   IF        @VP = 'N'
035100090107     C                   LEAVESR
035200090107    1C                   ENDIF
035300090107    * *
035400090107     C                   IF        (*IN31 = *ON AND I_ENDDT <> 0) OR
035500090107     C                             I_ENDDT = 0
035600090107     C                   EVAL      *IN25 = *ON
035700090107     C                   ENDIF
035800090107    * *
035900090107     C                   IF        SENDDT = 0 AND I_ENDDT <> 0
036000090107     C                   EVAL      *IN31 = *ON
036100090107     C                   ENDIF
036200090107    * *
036300090107     C                   IF        SENDDT <> 0 AND I_ENDDT = 0
036400090107     C                   EVAL      *IN31 = *OFF
036500090107     C                   ENDIF
036600090107    * *
036700090107     C                   IF        I_ENDDT = 0
036800090107     C                   EVAL      *IN28 = *ON
036900090107     C                   EVAL      *IN30 = *ON
037000090107     C                   LEAVESR
037100090107     C                   ENDIF
037200090107    * *
037300090107     C                   IF        INAC = *BLANKS
037400090107     C                   EVAL      *IN28 = *ON
037500090107     C                   EVAL      *IN30 = *OFF
037600090107     C                   ELSE
037700090206     C                   IF        %SUBST(MSREASN:1:1) = 'I'
037800090206     C                   EVAL      *IN28 = *OFF
037900090206     C                   EVAL      *IN30 = *ON
038000090206     C                   ELSE
038100090206     C                   EVAL      *IN28 = *ON
038200090206     C                   EVAL      *IN30 = *OFF
038300090206     C                   ENDIF
038400090107     C                   ENDIF
038500090107    ***
038600090107     C                   ENDSR
038700090107   S***S
038800090107     C     $F10          BEGSR
038900090107    ***
039000090107     C                   EXSR      $VALID
039100090107    2C                   IF        @VP = 'Y'
039200090107     C                   EXSR      $I#O
039300090107     C                   EXSR      $HISTREC
039400090107     C                   EVAL      @STEP = 'PREP1'
039500090107     C                   MOVE      *BLANKS       P@1
039600090324    1C                   EVAL      @IM = 'M'
039700090107    2C                   ENDIF
039800110418    ***
039900110418     C                   ENDSR
040000110418   S***S
040100110418     C     $F2           BEGSR
040200110418    ***
040300110418     C                   EVAL      @NTEPARM = '000' + I_SMAN
040400110418     C                   CALL      'MDC010  '
040500110418     C                   PARM                    @NTEPARM         11
040600090107    ***
040700090107     C                   ENDSR
040800090107   S***S
040900090107     C     $F4           BEGSR
041000090107    ***
041100090107     C                   IF        WSFLD = 'I_STYPE   '
041200090107     C                   MOVEL(P)  'F'           @3
041300090107     C                   CALL      'FM001CL'
041400090107     C                   PARM                    @3
041500090107    2C                   IF        @3 <> '*LR'
041600090107     C                   MOVE      @3            I_STYPE
041700090107     C                   EXSR      $GETCODES
041800090107    2C                   ENDIF
041900090107    1C                   ENDIF
042000110701    ***
042100110701     C                   IF        WSFLD = 'SCRMGR    '
042200110701     C                   MOVEL(P)  '*'           @4
042300110701     C                   CALL      'FM105CL2'
042400110701     C                   PARM                    @4                4
042500110701    2C                   IF        @4 <> '*LR'
042600110701     C                   EVAL      SCRMGR = @4
042700110701     C                   EXSR      $VALID
042800110701    2C                   ENDIF
042900110701    1C                   ENDIF
043000110701    ***
043100090107     C                   IF        WSFLD = 'INAC      '
043200090108     C                   CALL      'SLCIRMCL'
043300090107     C                   PARM      'LOAD'        WRQS              8
043400090107     C                   PARM                    WRTN              8
043500090107     C                   PARM      'SLCIRM'      WPGM             10
043600090206     C                   PARM                    @83              83
043700090206     C                   EVAL      INAC = %SUBST(@83:1:3)
043800090206     C                   EVAL      IMTXT1 = %SUBST(@83:4:40)
043900090206     C                   EVAL      IMTXT2 = %SUBST(@83:44:40)
044000090206     C                   EVAL      DS@IRM = @83
044100090107    2C                   ENDIF
044200090107    ***
044300090107     C                   ENDSR
044400090107   S***S
044500090107     C     $FM1042       BEGSR
044600090107    ***
044700090107     c     i_enddt       mult      10000.0001    #termdte          8 0
044800090107     c                   move      #termdte      po@term
044900090107    * *
045000090107     C                   MOVEL     I_SMAN        po@sman
045100090107     C                   Move      sgrp          po@grpr
045200090107    * *
045300090107     C                   movel(p)  sfname        @35              35
045400090107     c                   eval      @35 = %trimr(@35) + ' ' + smi
045500090107     c                   eval      @35 = %trimr(@35) + ' ' + slname
045600090107     c                   movel(p)  @35           po@name
045700090107    * *
045800090107     C                   CALL      'FM104_2CL'
045900090107     c                   parm                    parms@out
046000020613    ***
046100020613     C                   ENDSR
046200020613   S***S
046300020613     C     $HISTREC      BEGSR
046400020613    ***
046500020613     C                   MOVEL     DS@SM         HAFTER
046600020613     C                   EVAL      HMSG = %TRIM(M50) + ' ' + %TRIM(M100)
046700020613    ***
046800020613     C                   CLEAR                   @TIMESTAMP
046900020613     C                   MOVE      *BLANKS       @TS40
047000020613    ***
047100020613     C                   CALL      'TIMESTMP'
047200020613     C                   PARM                    @TS40
047300020613    ***
047400020613     C                   MOVEL     @TS40         @TIMESTAMP
047500020613     C                   MOVEL     @TSUSER       HUSERID
047600020613     C                   MOVE      #TSCYMD       HDATE
047700020613     C                   MOVE      #TSTIME       HTIME
047800020613     C                   MOVEL     @TSJOB        HJOB
047900020613     C                   MOVE      #TSNBR        HNUMBER
048000020613    ***
048100090107     C                   IF        HBEFORE <> HAFTER
048200020613     C                   WRITE     RSLMHIST
048300090107    1C                   ENDIF
048400020617    ***
048500020617     C                   MOVE      *BLANKS       M50
048600020617     C                   MOVE      *BLANKS       M100
048700020613    ***
048800020613     C                   ENDSR
048900020613   S***S
049000020613     C     $I#O          BEGSR
049100020613    ***
049200020613    1C                   IF        @IM = 'A'
049300020613    *** ADD RECORD
049400030313    ***
049500090107     C                   EXSR      $ADDSMAN
049600020613     C                   LEAVESR
049700020613    1C                   ENDIF
049800020613    *** CHANGE RECORD
049900020613     C                   MOVEL     SZIP5         @9
050000020613     C                   MOVE      SZIP4         @9
050100020613     C                   MOVE      @9            #9
050200020613     C                   Z-ADD     #9            SZIPCD
050300020613    ***
050400020613     C                   MOVEL     SPHONE3       @7
050500020613     C                   MOVE      SPHONE4       @7
050600020613     C                   MOVE      @7            #7
050700020613     C                   Z-ADD     #7            SPHONE
050800020613    ***
050900020613    1C                   IF        I_BEGDT = 0
051000020613     C                   EVAL      SBEGDT = 0
051100020613    1C                   ELSE
051200020613     C                   MOVE      I_BEGDT       #USA
051300020613     C                   MOVE      #USA          #ISO
051400020613     C                   MOVE      #ISO          SBEGDT
051500020613    1C                   ENDIF
051600030211    ***
051700030211003  C                   EVAL      STIN = %EDITC(SCTIN:'X')
051800151111       npnumber = npnc;
051900021203    ***
052000110701     C     I_SMAN        CHAIN     SMANRMGR
052100110701     C                   IF        NOT %FOUND(SMANRMGP)
052200110701     C                   EVAL      SMSMAN = I_SMAN
052300110701     C                   EVAL      SMRMGR = SCRMGR
052400110701     C                   WRITE(E)  SMANRMGR
052500110701     C                   ELSE
052600110701     C                   EVAL      SMRMGR = SCRMGR
052700110701     C                   UPDATE(E) SMANRMGR
052800110701     C                   ENDIF
052900110701    ***
053000090107    1C                   IF        I_ENDDT = 0
053100090107     C                   EVAL      SENDDT = 0
053200090107     C                   EVAL      SMDLTD = 'A'
053300090107    1C                   ELSE
053400090107     C                   EVAL      SMDLTD = 'D'
053500090107     C                   MOVE      I_ENDDT       #USA
053600090107     C                   MOVE      #USA          #ISO
053700090107     C                   MOVE      #ISO          SENDDT
053800090107     C                   ENDIF
053900090107    ***
054000090107    1C                   IF        I_ENDDT = 0 OR
054100090107     C                             (I_ENDDT <> 0 AND INAC = *BLANKS)
054200090107     C                   EXSR      $INACTDLT
054300090107     C                   ENDIF
054400090107     **
054500090107     C                   IF        INAC <> *BLANKS AND I_ENDDT <> 0
054600090107     C                   EXSR      $INACTWRT
054700090105     C                   ENDIF
054800020613    ***
054900020613     C                   EVAL      STYPE = 'F' + I_STYPE
055000020613     C                   UPDATE    SMANR
055100151111
055200151116       chain i_sman npnr;
055300151116       if not %found;
055400151116       smancd3 = i_sman;
055500151116       npnumber = npnc;
055600151116       write npnr;
055700151116       else;
055800151116       npnumber = npnc;
055900151116       update npnr;
056000151116       endif;
056100151111
056200020613    ***
056300040928     C     SGRP          CHAIN     sman2r
056400031218     C                   IF        GRDMGDFT = *BLANKS or dftbroker = 'Y'
056500030313     C                   MOVEL     I_SMAN        GRDMGDFT
056600080204     C                   EVAL      GRFUSE = 'F'
056700040928     C                   UPDATE    sman2r
056800080204     C                   ELSE
056900080204     C                   UNLOCK    SMAN2L
057000030313    2C                   ENDIF
057100090107    ***
057200090107     C                   ENDSR
057300090107   S***S
057400090107     C     $ADDSMAN      BEGSR
057500090107    ***
057600090107     C                   MOVEL     I_SMAN        SMANCD
057700090107    ***
057800090107     C                   MOVEL     SZIP5         @9
057900090107     C                   MOVE      SZIP4         @9
058000090107     C                   MOVE      @9            #9
058100090107     C                   Z-ADD     #9            SZIPCD
058200090107    ***
058300090107     C                   MOVEL     SPHONE3       @7
058400090107     C                   MOVE      SPHONE4       @7
058500090107     C                   MOVE      @7            #7
058600090107     C                   Z-ADD     #7            SPHONE
058700090107    ***
058800090107003  C                   EVAL      STIN = %EDITC(SCTIN:'X')
058900151111
059000151111       npnumber = npnc;
059100151111
059200151111
059300090107    ***
059400090107    2C                   IF        I_BEGDT = 0
059500090107     C                   EVAL      SBEGDT = 0
059600090107    2C                   ELSE
059700090107     C                   MOVE      I_BEGDT       #USA
059800090107     C                   MOVE      #USA          #ISO
059900090107     C                   MOVE      #ISO          SBEGDT
060000090107    2C                   ENDIF
060100090107    ***
060200090107    2C                   IF        I_ENDDT = 0
060300090107     C                   EVAL      SENDDT = 0
060400090107     C                   EVAL      SMDLTD = 'A'
060500090107    2C                   ELSE
060600090107     C                   EVAL      SMDLTD = 'D'
060700090107     C                   MOVE      I_ENDDT       #USA
060800090107     C                   MOVE      #USA          #ISO
060900090107     C                   MOVE      #ISO          SENDDT
061000090107    2C                   ENDIF
061100110701    ***
061200110701     C                   CLEAR                   SMANRMGR
061300110701     C                   EVAL      SMSMAN = I_SMAN
061400110701     C                   EVAL      SMRMGR = SCRMGR
061500110701     C                   WRITE     SMANRMGR
061600090107    ***
061700090107     C                   EVAL      STYPE = 'F' + I_STYPE
061800090107     C                   WRITE     SMANR
061900151111
062000160916       smancd3 = i_sman;
062100160916       npnumber = npnc;
062200151111       write npnr;
062300151111
062400090107    ***
062500090107     C                   IF        I_ENDDT <> 0 AND INAC <> *BLANKS
062600090107     C                   CLEAR                   MKTSTSR
062700090107     C                   EVAL      MSCTYPE = 'S'
062800090107     C                   EVAL      MSCODE = SMANCD
062900090107     C                   EVAL      MSREASN = INAC
063000090108     C                   CALL      'TIMESTMP'
063100090108     C                   PARM                    @TS40
063200090108     C                   MOVEL     @TS40         @TIMESTAMP
063300090107     C                   EVAL      MSCDATE = #TSCYMD
063400090107     C                   EVAL      MSCUSER = @TSUSER
063500090107     C                   WRITE(E)  MKTSTSR
063600090107    2C                   ENDIF
063700090107    ***
063800090107     C     SGRP          CHAIN     sman2r
063900090107     C                   IF        GRDMGDFT = *BLANKS
064000090107     C                   MOVEL     I_SMAN        GRDMGDFT
064100090107     C                   EVAL      GRFUSE = 'F'
064200090107     C                   UPDATE    sman2r
064300090107     C                   ELSE
064400090107     C                   UNLOCK    SMAN2L
064500090107    2C                   ENDIF
064600090107    ***
064700090107     C                   ENDSR
064800090107   S***S
064900090107     C     $INACTDLT     BEGSR
065000090107    ***
065100090107     C     KL#MS         KLIST
065200090107     C                   KFLD                    @CTYPE            1
065300090107     C                   KFLD                    I_SMAN
065400090107     C     KL#MS         CHAIN     MKTSTSR
065500090107     C                   IF        %FOUND(MKTSTSP)
065600090107     C     KL#MS         DELETE    MKTSTSR
065700090107     C                   ENDIF
065800030313    ***
065900020613     C                   ENDSR
066000020613   S***S
066100090107     C     $INACTWRT     BEGSR
066200090108    ***
066300090108     C                   CALL      'TIMESTMP'
066400090108     C                   PARM                    @TS40
066500090108     C                   MOVEL     @TS40         @TIMESTAMP
066600090107    ***
066700090107     C     KL#MS         CHAIN     MKTSTSR
066800090107    ***
066900090107     C                   IF        %FOUND(MKTSTSP)
067000090107    * *
067100090107     C                   IF        MSREASN <> INAC
067200090107     C                   EVAL      MSREASN = INAC
067300090107     C                   MOVEL     @TSUSER       MSCUSER
067400090107     C                   MOVE      #TSCYMD       MSCDATE
067500090107     C                   UPDATE    MKTSTSR
067600090107     C                   ENDIF
067700090107    * *
067800090107     C                   LEAVESR
067900090107     C                   ENDIF
068000090107    ***
068100090107     C                   CLEAR                   MKTSTSR
068200090107     C                   EVAL      MSCTYPE = 'S'
068300090107     C                   EVAL      MSCODE = I_SMAN
068400090107     C                   EVAL      MSREASN = INAC
068500090107     C                   MOVEL     @TSUSER       MSCUSER
068600090107     C                   MOVE      #TSCYMD       MSCDATE
068700090107     C                   WRITE     MKTSTSR
068800090107    ***
068900090107     C                   ENDSR
069000090107   S***S
069100020613     C     $GETCODES     BEGSR
069200020613    ***
069300020613     C                   MOVE      'F'           KEY@TYPE
069400020613     C                   MOVEL(P)  I_STYPE       KEY@CODE
069500080204     C     KEY@CODES     CHAIN     CODESR
069600020613    1C                   IF        NOT %FOUND(CODES)
069700020613     C                   EVAL      @LD = *BLANKS
069800020613    1C                   ELSE
069900020613     C                   EVAL      @LD = LDESCR
070000020613    1C                   ENDIF
070100020613    ***
070200020613     C                   MOVEL(P)  @LD           O_LDESCR
070300020612    ***
070400020612     C                   ENDSR
070500020612   S***S
070600020612     C     $VALID        BEGSR
070700020612    ***
070800020612     C                   EVAL      @VP = 'N'
070900020613    ***
071000090107     C                   IF        I_ENDDT = 0
071100090107     C                   EVAL      *IN28 = *ON
071200090107     C                   ELSE
071300090107     C                   EVAL      *IN28 = *OFF
071400020613     C                   ENDIF
071500080204    ***
071600080204     C                   IF        FUSE <> 'F' AND FUSE <> 'B' AND
071700080204     C                             FUSE <> 'S'
071800080204     C                   EVAL      @EMSG = 'INVALID PRODUCT TYPE'
071900080204     C                   LEAVESR
072000080204    1C                   ENDIF
072100080204    ***
072200080204     C                   SELECT
072300080204     C                   WHEN      FUSE = 'F'
072400080204     C                   EVAL      D_PDTSOLD = 'FULLY INSURED'
072500080204     C                   WHEN      FUSE = 'S'
072600080204     C                   EVAL      D_PDTSOLD = 'SELF FUNDED'
072700080204     C                   WHEN      FUSE = 'B'
072800080204     C                   EVAL      D_PDTSOLD = 'BOTH FULLY INSURED AND ' +
072900080204     C                                         'SELF FUNDED'
073000080204     C                   ENDSL
073100020612    ***
073200020613    1C                   IF        SLNAME = *BLANKS
073300020613     C                   EVAL      @EMSG = 'LAST NAME CANNOT BE BLANK.'
073400020612     C                   LEAVESR
073500020613    1C                   ENDIF
073600021203    ***
073700020613    1C                   IF        SFNAME = *BLANKS
073800020613     C                   EVAL      @EMSG = 'FIRST NAME CANNOT BE BLANK.'
073900020613     C                   LEAVESR
074000020613    1C                   ENDIF
074100030513    ***
074200030513    1c                   if        sctin = 0 or sctin = 111111111 or
074300030513    1c                             sctin = 222222222
074400030513     c                   eval      @EMSG = 'SALESMAN SS# INVALID.'
074500030513     c                   leavesr
074600030513    1c                   endif
074700020612    ***
074800020613    1C                   IF        I_STYPE = *BLANKS
074900020613     C                   EVAL      @EMSG = 'SALES TYPE CANNOT BE BLANK.'
075000020613     C                   LEAVESR
075100020613    1C                   ENDIF
075200151111
075300151124       // no blanks or zeros allowed...
075400151124    1  if npnc = ' '
075500151124        or npnc = '0'
075600151124         or npnc = '00'
075700151124          or npnc = '000'
075800151124           or npnc = '0000'
075900151124            or npnc = '00000'
076000151124             or npnc = '000000'
076100151124             or npnc = '0000000'
076200151124            or npnc = '00000000'
076300151124           or npnc = '000000000'
076400151124          or npnc = '0000000000';
076500151124         @emsg = 'NP Number cannot be blank or zeros';
076600151111        leavesr;
076700151111    1  endif;
076800151111
076900080204    *** validate stype
077000080204     c                   exsr      $getcodes
077100080204    1C                   IF        NOT %FOUND(CODES)
077200080204     C                   EVAL      @EMSG = 'INVALID SALESMAN TYPE      '
077300080204     C                   LEAVESR
077400080204    1C                   ENDIF
077500020613    ***
077600020617    1C                   IF        (@IM = 'A' AND I_BEGDT = 0) OR
077700020617     C                             (@IM = 'C' AND I_BEGDT = 0 AND
077800020617     C                             SBEGDT <> 0)
077900020613     C                   EVAL      @EMSG = 'BEGIN DATE IS REQUIRED'
078000020613     C                   LEAVESR
078100020613    1C                   ENDIF
078200110701    ***
078300110701     C     SCRMGR        CHAIN     RMGRMSTR
078400110701     C                   IF        NOT %FOUND(RMGRMST3)
078500110701     C                   EVAL      D_RMGR = '*INVALID CODE*'
078600110701     C                   EVAL      @EMSG = 'MISSING OR INVALID REL MGR CODE'
078700110701     C                   LEAVESR
078800110701     C                   ELSE
078900110701     C                   EVAL      D_RMGR = RMNAME
079000110701     C                   ENDIF
079100020613    ***
079200020613     C                   IF        I_BEGDT > 0
079300020613     C     *USA          TEST(DE)                I_BEGDT
079400020613     C                   IF        %ERROR
079500020613     C                   EVAL      @EMSG = 'BEGIN DATE IS INVALID'
079600020613     C                   LEAVESR
079700020613     C                   ENDIF
079800020613     C                   ENDIF
079900020613    ***
080000020613     C                   IF        I_ENDDT > 0
080100020613     C     *USA          TEST(DE)                I_ENDDT
080200020613     C                   IF        %ERROR
080300020613     C                   EVAL      @EMSG = 'TERMINATION DATE IS INVALID'
080400020613     C                   LEAVESR
080500020613     C                   ENDIF
080600020613     C                   ENDIF
080700090107    ***
080800090107     C                   IF        INAC <> *BLANKS AND *IN31 = *ON
080900090107     C     INAC          CHAIN     IRMMSTR
081000090107     C                   IF        NOT %FOUND(IRMMSTP)
081100090107     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
081200090107     C                   ENDIF
081300090107     C                   ENDIF
081400030709    ***
081500030709    1c                   if        dftbroker <> 'Y' and dftbroker <> 'N'
081600030709     c                   eval      @emsg = 'DEFAULT BROKER REQUIRED.'
081700030709     c                   leavesr
081800030709     c                   endif
081900020613    ***
082000040928     C     SGRP          CHAIN(N)  sman2r
082100040928    1C                   IF        NOT %FOUND(SMAN2L)
082200030709    * *
082300030709    2C                   IF        SGRP <> @nxtgrp
082400030313     C                   EVAL      @EMSG = 'GROUPER DOES NOT EXIST'
082500030313     C                   LEAVESR
082600030709    * *
082700030709    2c                   else
082800030709    * *
082900040928     c                   eval      sgrpcd = sgrp
083000030709    * *
083100080204    3c                   if        dftbroker = 'Y' OR GRDMGDFT = *BLANKS
083200030709     C                   MOVEL     I_SMAN        GRDMGDFT
083300030709     C                   EVAL      GRFUSE = 'F'
083400030709    3c                   endif
083500040928    * *
083600040928     ******** dft info
083700040928     c                   eval      sgbsag = 'N'
083800040928     c                   eval      sgbsac = 'N'
083900040928     c                   eval      snoeml = 'Y'
084000040928     c                   eval      snofax = 'Y'
084100040928     c                   eval      sgwl   = 'N'
084200040928     c                   eval      sprtct = 'N'
084300030709    * *
084400040928     c                   write     sman2r
084500030709    * *
084600030709    2C                   ENDIF
084700030709    * *
084800030709    1c                   endif
084900030313    ***
085000020612     C                   EVAL      @VP = 'Y'
085100020612    ***
085200020612     C                   ENDSR
085300020612   S***S
