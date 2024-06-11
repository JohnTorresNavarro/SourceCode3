000100020613     F*-------------------------------------------------------------------------
000200030311     F* FM106      INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020613     F*            FM10* SALESMAN MASTER APPLICATION
000400020613     F*            WRITTEN BY - S.S.K.
000500020613     F*            DATE - 06/02
000600030311     F*  DESCRIPTION - GROUPER XREF MAINTENANCE
000700020613     F*  INDICATOR USAGE:
000800030311     F*    01 = CANCEL OUT OF THIS PROGRAM
000900030311     F*    04 = SALESMAN INQUIRY
001000030311     F*    06 = CREATE NEW GROUPER
001100030311     F*    07 = EXIT
001200030311     F*    27 = SELF FUNDED/FULLY INSURED LITERAL FLAG
001300020613     F*
001400020613     F*-------------------------------------------------------------------------
001500020613     ** MODIFICATION HISTORY                                              **
001600020613     ** ###  UUU  MMDDCCYY  X---->                                        **
001700030311     ** 000  SSK  03112003  ORIGINAL SOURCE                               **
001800031202     ** 001  SSK  12022003  ADD GROUPER HISTORY FILE                      **
001900070830     ** 002 *08/30/2007 DO NOT ALLOW ENTRY OF A TERMED SMAN CODE FOR XREF
002000020613     **                                                                   **
002100020613     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002200030311     FFM106D    CF   E             WORKSTN INFDS(WSDS)
002300041004     Fsman2l    UF A E           K DISK    RENAME(sman2r:BYGRP)
002400041004     Fsman2l1   IF   E           K DISK    RENAME(sman2r:BYSMN)
002500040928     Fsm2hist0  o  a e             disk
002600030313     FFM102W2   IF   E           K DISK
002700020612   X***X
002800020612     D WSDS            DS
002900020612     D  FKEY                 369    369A
003000020612    ***
003100020612     D  F1             C                   CONST(X'31')
003200020612     D  F2             C                   CONST(X'32')
003300020612     D  F3             C                   CONST(X'33')
003400020612     D  F4             C                   CONST(X'34')
003500020612     D  F5             C                   CONST(X'35')
003600020612     D  F6             C                   CONST(X'36')
003700020612     D  F7             C                   CONST(X'37')
003800020612     D  F8             C                   CONST(X'38')
003900020612     D  F9             C                   CONST(X'39')
004000020612     D  F10            C                   CONST(X'3A')
004100020612     D  F11            C                   CONST(X'3B')
004200020612     D  F12            C                   CONST(X'3C')
004300020612     D  F13            C                   CONST(X'B1')
004400020612     D  F14            C                   CONST(X'B2')
004500020612     D  F15            C                   CONST(X'B3')
004600020612     D  F16            C                   CONST(X'B4')
004700020612     D  F17            C                   CONST(X'B5')
004800020612     D  F18            C                   CONST(X'B6')
004900020612     D  F19            C                   CONST(X'B7')
005000020612     D  F20            C                   CONST(X'B8')
005100020612     D  F21            C                   CONST(X'B9')
005200020612     D  F22            C                   CONST(X'BA')
005300020612     D  F23            C                   CONST(X'BB')
005400020612     D  F24            C                   CONST(X'BC')
005500020612    ***
005600020612     D @STEP           S              5A
005700030311     D P@4             S              4A
005800030311     D P@1             S              1A
005900030311     D @5              S              5A
006000020612    ***
006100020612     D @EMSG           S             70A
006200030313     D A@20            S             20A
006300030312     D A@40            S             40A
006400031202    ***
006500040928     D DS@grp        E DS                  EXTNAME(sman2)
006600031202    ***
006700031202      *
006800031202    *** TIMESTAMP FIELDS DATA STRUCTURE
006900031202      *
007000031202     d @ts40           s             40a
007100031202     D @TIMESTAMP      DS
007200031202     D  #TSCYMD                1      8S 0
007300031202     D  #TSTIME                9     14S 0
007400031202     D  @TSJOB                15     24
007500031202     D  @TSUSER               25     34
007600031202     D  #TSNBR                35     40S 0
007700031202    ***
007800020612   X***X
007900020612     C                   DOU       @STEP = 'LEAVE'
008000030311     C     @STEP         CASEQ     'PREP1'       $PREP1
008100020612     C     @STEP         CASEQ     'STEP1'       $STEP1
008200020612     C                   ENDCS
008300020612     C                   ENDDO
008400020612    ***
008500020612     C                   MOVE      *ON           *INLR
008600020612   S***S
008700020612     C     *INZSR        BEGSR
008800020612    ***
008900020612     C     *ENTRY        PLIST
009000020612     C                   PARM                    P@4
009100020613     C                   PARM                    P@1
009200020613    ***
009300030311     C                   EVAL      @STEP   = 'PREP1'
009400030311    ***
009500030311     C                   ENDSR
009600030311   S***S
009700030311     C     $PREP1        BEGSR
009800030311    ***
009900030311     C                   EVAL      *IN25 = *OFF
010000030311    ***
010100030311     C                   IF        P@4 = 'SELF'
010200030311     C                   EVAL      *IN27 = *ON
010300030311     C                   ELSE
010400030311     C                   EVAL      *IN27 = *OFF
010500030311     C                   ENDIF
010600041004    ***
010700041004     C                   clear                   BYGRP
010800020612    ***
010900030313     C                   EVAL      @STEP   = 'STEP1'
011000030313    ***
011100020612     C                   ENDSR
011200020612   S***S
011300020612     C     $STEP1        BEGSR
011400020612    ***
011500020612     C                   MOVEL     @EMSG         EMSG
011600020612     C                   EXFMT     IO01
011700020612     C                   MOVE      *BLANKS       EMSG
011800020612     C                   MOVE      *BLANKS       @EMSG
011900030312     C                   MOVE      *BLANKS       D_SMAN
012000030312    ***
012100030312     C                   SELECT
012200030312     C                   WHEN      FKEY = F1
012300030312     C                   EVAL      P@1 = *BLANKS
012400030312     C                   EVAL      @STEP = 'LEAVE'
012500030312     C                   LEAVESR
012600030312     C                   WHEN      FKEY = F7
012700030312     C                   EVAL      P@1 = 'X'
012800020612     C                   EVAL      @STEP = 'LEAVE'
012900020612     C                   LEAVESR
013000030312     C                   WHEN      FKEY = F4
013100030312     C                   EXSR      $F4
013200020612     C                   LEAVESR
013300031212     C                   WHEN      FKEY = F9 and i_grpr <> *blanks
013400031212     C                   EXSR      $F9
013500031212     C                   LEAVESR
013600030312     C                   WHEN      FKEY = F6
013700030312     C                   EXSR      $F6
013800030304     C                   LEAVESR
013900050706     C                   WHEN      FKEY = F11
014000050706     C                   EXSR      $F11
014100050706     C                   LEAVESR
014200030312     C                   ENDSL
014300020729    ***
014400020612     C                   EXSR      $VALID
014500020612    ***
014600030312     C                   IF        @VR = 'Y'
014700030312     C                   EXSR      $UPDATECHK
014800030312     C                   ENDIF
014900031212    ***
015000031212     C                   ENDSR
015100031212   S***S
015200031212     C     $f9           begsr
015300031212    ***
015400041004     c                   eval      @8 = i_grpr + GRDMGDFT
015500031212     c                   call      'FM108CL'
015600041004     c                   parm                    @8                8
015700030312    ***
015800030312     C                   ENDSR
015900030312   S***S
016000050706     C     $f11          begsr
016100050706    ***
016200050706     C                   IF        I_GRPR = *BLANKS
016300050706     C                   EVAL      @EMSG = 'SELECT GROUPER TO DELETE.'
016400050706     C                   LEAVESR
016500050706     C                   ENDIF
016600050706    ***
016700050706     c                   eval      @5 = i_grpr
016800050706     c                   call      'FM111CL'
016900050706     c                   parm                    @5                5
017000050706    ***
017100050706     C                   IF        @5 = 'PASS '
017200050706     C                   EVAL      @EMSG = 'GROUPER DELETED.'
017300050706     C                   EVAL      I_GRPR = *BLANKS
017400050706     C                   EVAL      I_SMAN = *BLANKS
017500050706     C                   ELSE
017600050706     C                   EVAL      @EMSG = 'GROUPER IN USE, DELETE DENIED'
017700050706     C                   ENDIF
017800050706    ***
017900050706     C                   ENDSR
018000050706   S***S
018100030312     C     $VALID        BEGSR
018200030312    ***
018300030312     C                   MOVE      'N'           @VR               1
018400030312    ***
018500030312     C                   IF        I_GRPR = *BLANKS
018600030312     C                   EVAL      @EMSG = 'SELECT OR CREATE A GROUPER.'
018700030312     C                   LEAVESR
018800030312     C                   ENDIF
018900030312    ***
019000030312     C                   IF        I_SMAN <> *BLANKS
019100030312     C*
019200030312     C     I_SMAN        CHAIN     SMANR
019300030313     C                   IF        NOT %FOUND(FM102W2)
019400030312     C                   EVAL      @EMSG = 'INVALID SALESMAN CODE.'
019500030312     C                   LEAVESR
019600030312     C                   ENDIF
019700030312     C*
019800030312     C     I_SMAN        CHAIN     BYSMN
019900040928     C                   IF        %FOUND(sman2l1)
020000030312     C                   EVAL      @EMSG = 'SALESMAN ALREADY DEFAULT CODE.'
020100030312     C                   LEAVESR
020200030312     C                   ENDIF
020300070830     C*
020400070830     C*******08/30/2007 MODIFICATION BEGIN
020500070830     C*******08/30/2007 DO NOT ALLOW ENTRY OF A TERMED SMAN CODE FOR XREF
020600070830     C                   IF        SENDDT <> 0
020700070830     C                   EVAL      @EMSG = 'TERMED CODES ARE NOT ALLOWED.'
020800070830     C                   LEAVESR
020900070830     C                   ENDIF
021000070830     C*******08/30/2007 MODIFICATION END
021100030312     C*
021200030312     C                   ENDIF
021300030312    ***
021400030312     C                   MOVE      'Y'           @VR
021500030312    ***
021600030312     C                   ENDSR
021700030312   S***S
021800030312     C     $GETSMAN      BEGSR
021900030312    ***
022000030313     C                   CLEAR                   A@20
022100030312     C                   CLEAR                   A@40
022200030312    ***
022300030312     C                   IF        SFNAME <> *BLANKS
022400030313     C                   MOVEL     SFNAME        A@20
022500030312     C                   EXSR      $LDADDR
022600030312     C                   ENDIF
022700030312    ***
022800030312     C                   IF        SMI <> *BLANKS
022900030313     C                   MOVEL     SMI           A@20
023000030312     C                   EXSR      $LDADDR
023100030312     C                   ENDIF
023200030312    ***
023300030312     C                   IF        SLNAME <> *BLANKS
023400030313     C                   MOVEL     SLNAME        A@20
023500030312     C                   EXSR      $LDADDR
023600030312     C                   ENDIF
023700030312    ***
023800030312     C                   ENDSR
023900030312   S***S
024000030312     C     $LDADDR       BEGSR
024100030312    ***
024200030313     C                   EVAL      A@20 = %TRIM(A@20)
024300030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
024400030313     C                   CLEAR                   A@20
024500030312    ***
024600030312     C                   ENDSR
024700030312   S***S
024800030312     C     $F4           BEGSR
024900030312    ***
025000050705     C                   IF        WSFLD = 'I_SMAN    '
025100030312     C                   MOVEL     P@4           @4                4
025200030603     C                   MOVE      *blanks       p@3
025300030312     C                   CALL      'FM102CL'
025400030313     C                   PARM                    P@3               3
025500030312     C                   PARM                    @4
025600030312     C                   IF        P@3 <> '*LR'
025700030312     C                   EVAL      I_SMAN = P@3
025800030312     C                   EXSR      $GETSMAN
025900030312     C                   MOVEL(P)  A@40          D_SMAN
026000050705     C                   ENDIF
026100050705     C                   LEAVESR
026200030312     C                   ENDIF
026300050705    ***
026400050705     C                   IF        WSFLD = 'I_GRPR    '
026500050705     C                   MOVE      '00000'       @5                5
026600050705     C                   CALL      'FM110CL'
026700050705     C                   PARM                    @5
026800050705     C                   IF        @5 <> '00000'
026900050705     C                   EVAL      I_GRPR = @5
027000050705     C                   EXSR      $VALID
027100050705     C                   ENDIF
027200050705     C                   LEAVESR
027300050705     C                   ENDIF
027400020613    ***
027500020613     C                   ENDSR
027600020613   S***S
027700020613     C     $F6           BEGSR
027800020613    ***
027900030312     C                   CLEAR                   BYGRP
028000030312    ***
028100030311     C                   CALL      'FM104CLU'
028200030311     C                   PARM                    @5
028300030312     C                   MOVEL     @5            I_GRPR
028400040928    ***
028500040928     ******** dft info
028600040928     c                   eval      sgbsag = 'N'
028700040928     c                   eval      sgbsac = 'N'
028800040928     c                   eval      snoeml = 'Y'
028900040928     c                   eval      snofax = 'Y'
029000040928     c                   eval      sgwl   = 'N'
029100040928     c                   eval      sprtct = 'N'
029200030312    ***
029300040928     C                   EVAL      sgrpcd = @5
029400071030     C                   EVAL      GRFUSE = 'F'
029500030313     C                   WRITE     BYGRP
029600030312     C     I_GRPR        CHAIN     BYGRP
029700031202     c                   eval      hfgrp = i_grpr
029800031202     c                   exsr      $histrec
029900041004     c                   clear                   rsm2hist
030000031202     c                   eval      hfgrp = i_grpr
030100031202     C                   MOVEL     ds@grp        hbefore
030200030312    ***
030300030312     C                   ENDSR
030400030312   S***S
030500031202     C     $HISTREC      BEGSR
030600031202    ***
030700031202     C                   MOVEL     ds@grp        HAFTER
030800031202     C                   EVAL      HMSG = %TRIM(M50) + ' ' + %TRIM(M100)
030900031202    ***
031000031202     C                   CLEAR                   @TIMESTAMP
031100031202     C                   MOVE      *BLANKS       @TS40
031200031202    ***
031300031202     C                   CALL      'TIMESTMP'
031400031202     C                   PARM                    @TS40
031500031202    ***
031600031202     C                   MOVEL     @TS40         @TIMESTAMP
031700031202     C                   MOVEL     @TSUSER       HUSERID
031800031202     C                   MOVE      #TSCYMD       HDATE
031900031202     C                   MOVE      #TSTIME       HTIME
032000031202     C                   MOVEL     @TSJOB        HJOB
032100031202     C                   MOVE      #TSNBR        HNUMBER
032200031202    ***
032300041004     C                   WRITE     rsm2hist
032400031202    ***
032500031202     C                   MOVE      *BLANKS       M50
032600031202     C                   MOVE      *BLANKS       M100
032700031202    ***
032800031202     C                   ENDSR
032900031202   S***S
033000031202     C     $setbefore    BEGSR
033100031202    ***
033200041004     c                   clear                   rsm2hist
033300031202     c                   eval      hfgrp = i_grpr
033400031202     C                   MOVEL     ds@grp        hbefore
033500031202    ***
033600031202     C                   ENDSR
033700031202   S***S
033800030312     C     $UPDATECHK    BEGSR
033900030312    ***
034000040928    1C                   IF        I_GRPR <> *BLANKS AND sgrpcd = *BLANKS
034100030313     C     I_GRPR        CHAIN     BYGRP
034200040928    2C                   IF        NOT %FOUND(sman2l)
034300030312     C                   EVAL      @EMSG = 'SELECT OR CREATE A GROUPER.'
034400030313    2C                   ELSE
034500031202     c                   exsr      $setbefore
034600030312     C                   EVAL      I_SMAN = GRDMGDFT
034700030313    3C                   IF        I_SMAN <> *BLANKS
034800030312     C                   EXSR      $GETSMAN
034900030313    3C                   ENDIF
035000030313    2C                   ENDIF
035100030312     C                   LEAVESR
035200030313    1C                   ENDIF
035300030312     C*
035400040928    1C                   IF        sgrpcd <> I_GRPR
035500030312     C     I_GRPR        CHAIN     BYGRP
035600040928    2C                   IF        NOT %FOUND(SMAN2L)
035700030312     C                   EVAL      @EMSG = 'SELECT OR CREATE A GROUPER.'
035800030312     C                   LEAVESR
035900030313    2C                   ELSE
036000030312     C                   EVAL      I_SMAN = GRDMGDFT
036100031202     c                   exsr      $setbefore
036200030313    3C                   IF        I_SMAN <> *BLANKS
036300030313     C     I_SMAN        CHAIN     SMANR
036400030312     C                   EXSR      $GETSMAN
036500030313    3C                   ENDIF
036600030313    2C                   ENDIF
036700030312     C                   LEAVESR
036800030313    1C                   ENDIF
036900030312     C*
037000030313    1C                   IF        I_SMAN =  *BLANKS AND GRDMGDFT <> *BLANKS
037100030312     C                   EXSR      $GENUPDT
037200030312     C                   LEAVESR
037300030313    1C                   ENDIF
037400030312     C*
037500030313    1C                   IF        I_SMAN =  *BLANKS AND GRDMGDFT =  *BLANKS
037600030312     C                   LEAVESR
037700030313    1C                   ENDIF
037800030312     C*
037900030313    1C                   IF        I_SMAN <> *BLANKS AND GRDMGDFT <> *BLANKS
038000030312     C                             AND I_SMAN <> GRDMGDFT
038100030312     C                   EXSR      $GENUPDT
038200030313     C     I_SMAN        CHAIN     SMANR
038300030312     C                   EXSR      $GETSMAN
038400030312     C                   LEAVESR
038500030313    1C                   ENDIF
038600030312     C*
038700030313    1C                   IF        I_SMAN <> *BLANKS AND GRDMGDFT <> *BLANKS
038800030312     C                             AND I_SMAN = GRDMGDFT
038900030312     C                   LEAVESR
039000030313    1C                   ENDIF
039100030312     C*
039200030313    1C                   IF        I_SMAN <> *BLANKS AND GRDMGDFT =  *BLANKS
039300030312     C                   EXSR      $GENUPDT
039400030313     C     I_SMAN        CHAIN     SMANR
039500030312     C                   EXSR      $GETSMAN
039600030312     C                   LEAVESR
039700030313    1C                   ENDIF
039800030312    ***
039900030312     C                   ENDSR
040000030312   S***S
040100030312     C     $GENUPDT      BEGSR
040200030312    ***
040300030312     C                   EVAL      GRDMGDFT = I_SMAN
040400071030     C*******************IF        I_SMAN <> *BLANKS
040500071030     C*******************IF        P@4 = 'SELF'
040600071030     C*******************EVAL      GRFUSE = 'N'
040700071030     C*******************ELSE
040800030313     C                   EVAL      GRFUSE = 'F'
040900071030     C*******************ENDIF
041000071030     C*******************ELSE
041100071030     C*******************MOVE      *BLANKS       GRFUSE
041200071030     C*******************ENDIF
041300030312     C                   UPDATE    BYGRP
041400031202     c                   eval      hfgrp = i_grpr
041500031202     c                   exsr      $histrec
041600030313     C                   EVAL      @STEP = 'LEAVE'
041700030313     C                   EVAL      P@1 = *BLANKS
041800030312    ***
041900030312     C                   ENDSR
042000030312   S***S
