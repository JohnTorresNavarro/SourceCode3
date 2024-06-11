000100110609     H option(*SRCSTMT: *NODEBUGIO)
000200030701     H* RPA061RG - RPA060WK Maintenance, allows ADD, CHANGE, & DELETE of
000300030701     H*             Salesman Commission Records created by RPA060.
000400030701     H* (c) Copyright 1997 by GROUP BENEFIT SERVICES SOFTWARE, Inc.
000500030703     H* (c) Copyright 2003 by GROUP BENEFIT SERVICES SOFTWARE, Inc.
000600030701     H*
000700030701     H*  SSK  6/30/2003 REWRITE PROGRAM BECAUSE ITS A HEADACHE TO MODIFY
000800030703     H*                 RELATIONSHIP ID COMPLIANT
000900040810     H* 08/10/04 dlk - protect relid on add to prevent blank relid
001000040819     H* 08/19/04 dlk - include "F"lat fee for calc
001100050208     H* 02/08/05 ssk - keep screen frozen at last step of add
001200050505     H* 05/05/05 dlk - mark manual add records with "A" in RPCHG field
001300050517     H* 05/17/05 szz - Initialize new Commission Paid Date before writing
001400050816     H* 08/16/05 dlk - add % of com global method
001500060314     H* 03/14/06 dlk - fill carrier with 999 when dummy add
001600061218     H* 12/18/06 dlk - add comm(remit) date to key of rpa060l2 because
001700061218     H*                there can be 2 rec in the same paid run but from
001800061218     H*                different comm(remit) runs.
001900080125     H* 01/25/08 dlk - allow maint of comm paid date
002000080207     H* 02/07/08 dlk - add seq#
002100081008     H* 10/08/08 dlk - add paid y/n field
002200110628     H* 06/08/11 dlk - add agency override fields, fix edit on paid y/n
002300110628      *                field and default paid y/n to Y when adding a rec
002400110830     H* 08/30/11 dlk - clear mksz field after update or f12 to cancel update
002500150108     H* 01/08/15 dlk - temporarily disable the group # edit so Mick can
002600150108      *                fix a record with an invlaid group #. Edit was
002700150108      *                put back after Mick was finished.
002800150904     H* 09/04/15 dlk - temporarily disable the group # edit so Toni can
002900150904      *                fix a record with an invlaid group #. Edit was
003000150904      *                put back after Toni was finished.
003100151106      * 11/06/15 dlk - temporarily disable the group # edit so Toni can
003200151106      *                fix a record with an invlaid group #. Edit was
003300151106      *                put back after Toni was finished.
003301160708      * 07/08/16 dlk - temporarily disable the group # edit so Mick can
003302160708      *                fix a record with an invlaid group #. Edit was
003303160708      *                put back after Toni was finished.
003304161108      * 11/08/16 dlk - temporarily disable the group # edit so Mick can
003305161108      *                fix a record with an invlaid group #. Edit was
003306161108      *                put back after Toni was finished.
003400030701   X***X
003500030701    * *
003600001212     FRPA060L2  UF A E           K DISK
003700030701    * *
003800970929     FACCMST    IF   E           K DISK
003900030701    * *
004000970929     FCARMST    IF   E           K DISK
004100030701    * *
004200970929     FGRATEL1   IF   E           K DISK
004300030701    * *
004400970929     FPLNMST    IF   E           K DISK
004500030701    * *
004600970929     FSMAN      IF   E           K DISK
004700030701    * *
004800030328     FSMANRLT   IF   E           K DISK
004900030701    * *
005000030328     FSPRAGXR2  IF   E           K DISK
0051001106090014 Fmktcara1  IF   e           k DISK
005200030701    * *
005300030701     FRPA061DF  CF   E             WORKSTN INFDS(WSDS)
005400030701    * *
005500030701   X***X
005600030701     D WSDS            DS
005700030701     D  FKEY                 369    369A
005800050519     D #First          DS
005900050519     D  FirstYear              1      4
006000050519     D  FirstMonth             5      6
006100050519     D  FirstofMonth           7      8
006200030701    ***
006300030701     D  F1             C                   CONST(X'31')
006400030701     D  F2             C                   CONST(X'32')
006500030701     D  F3             C                   CONST(X'33')
006600030701     D  F4             C                   CONST(X'34')
006700030701     D  F5             C                   CONST(X'35')
006800030701     D  F6             C                   CONST(X'36')
006900030701     D  F7             C                   CONST(X'37')
007000030701     D  F8             C                   CONST(X'38')
007100030701     D  F9             C                   CONST(X'39')
007200030701     D  F10            C                   CONST(X'3A')
007300030701     D  F11            C                   CONST(X'3B')
007400030701     D  F12            C                   CONST(X'3C')
007500030701     D  F13            C                   CONST(X'B1')
007600030701     D  F14            C                   CONST(X'B2')
007700030701     D  F15            C                   CONST(X'B3')
007800030701     D  F16            C                   CONST(X'B4')
007900030701     D  F17            C                   CONST(X'B5')
008000030701     D  F18            C                   CONST(X'B6')
008100030701     D  F19            C                   CONST(X'B7')
008200030701     D  F20            C                   CONST(X'B8')
008300030701     D  F21            C                   CONST(X'B9')
008400030701     D  F22            C                   CONST(X'BA')
008500030701     D  F23            C                   CONST(X'BB')
008600030701     D  F24            C                   CONST(X'BC')
008700030701    ***
008800030701     D @DTA50          S             50A
008900030701     D @EMSG           S             70A
009000030701     D @STEP           S              5A
009100030701     D @35             S             35A
009200030701    ***
009300030701     D #ISO            S               D   DATFMT(*ISO)
009400030701     D #USA            S               D   DATFMT(*USA)
009500030701     D #XSX            S              8S 0
009600030701    ***
009700030701     D GBSREALM        S             40A
009800030703     D change_fnd      S               N
009900030701     D DATE_ERROR      S               N
010000030701     D ERROR_FREE      S               N
010100030701     D GOOD_ACCT       S               N
010200030701     D GOOD_PLAN       S               N
010300030701     D NO              S               N   INZ(*OFF)
010400030701     D RELID_GOOD      S               N
010500030701     D YES             S               N   INZ(*ON)
010600030701    ***
010700050519     D KEY@CPDAT       S                   LIKE(RPCPDDT)
010800030701     D KEY@CDAT        S                   LIKE(RPCDAT)
010900080207     D KEY@seq         S                   LIKE(RPseq#)
011000030701     D KEY@RELID       S                   LIKE(RPRELID)
011100030701     D KEY@TRS         S                   LIKE(ACTRST)
011200030701     D KEY@SUB         S                   LIKE(RPSUB)
011300030701     D KEY@ACC         S                   LIKE(RPACC)
011400110609     D KEY@car         S                   LIKE(RPPCAR)
011500030701     D KEY@GRP         S                   LIKE(RPGRP)
011600030701     D KEY@PLN         S                   LIKE(RPPLAN)
011700030701     D KEY@EFDT        S                   LIKE(RPEFDT)
011800030701    ***
011900030701     D P_ACC           S                   LIKE(S_ACC)
012000030701     D P_ANM           S                   LIKE(S_ANM)
012100030701     D P_CDAT          S                   LIKE(I_CDAT)
012200080207     D P_seq           S                   LIKE(I_seq)
012300050519     D P_CPDAT         S                   LIKE(I_CPDAT)
012400030701     D P_CNAM          S                   LIKE(S_CNAM)
012500030701     D P_EFDT          S                   LIKE(I_EFDT)
012600030701     D P_GRP           S                   LIKE(S_GRP)
012700110609     D P_mksz          S                   LIKE(S_mksz)
012800030701     D P_PCAR          S                   LIKE(S_PCAR)
012900030701     D P_PDSC          S                   LIKE(S_PDSC)
013000030701     D P_PLAN          S                   LIKE(S_PLAN)
013100030701     D P_RELID         S                   LIKE(S_RELID)
013200030701     D P_SUB           S                   LIKE(S_SUB)
013300030703     D P_TRST          S                   LIKE(S_TRS)
013400030701    ***
013500030701     D S_CDAT          S                   LIKE(RPCDAT)
013600080207     D S_seq           S                   LIKE(RPseq#)
013700050519     D S_CPDAT         S                   Like(RPCPDDT)
013800030701     D S_EFDT          S                   LIKE(RPEFDT)
013900110608     D parmrel         s                   like(rprelid)
014000110608     D parmcar         s                   like(rppcar)
014100110608     D parmmksz        s                   like(rpmaszcd)
014200110608     D parmeffymd      s                   like(rpefdt)
014300110608     D parmcomamt      s                   like(rppcom)
014400110608     D parmprem        s                   like(rppprm)
014500110608     D parmmcnt        s                   like(rpmcnt)
014600110608     D parmmethod      s                   like(rpaomthd)
014700110608     D parmrate        s                   like(rpaorate)
014800110608     D parmovramt      s                   like(rpaoamt)
014900110608     D parmfound       s              1
015000110609     D mksz            s                   like(rpmaszcd)
015100030701   X***X
015200030701     C                   DOU       @STEP = 'LEAVE'
015300030701     C     @STEP         CASEQ     'STEP0'       $STEP0
015400030701     C     @STEP         CASEQ     'STEP1'       $STEP1
015500030703     C     @STEP         CASEQ     'PREP2'       $PREP2
015600030701     C     @STEP         CASEQ     'STEP2'       $STEP2
015700030703     C     @STEP         CASEQ     'PREP3'       $PREP3
015800030701     C     @STEP         CASEQ     'STEP3'       $STEP3
015900030703     C     @STEP         CASEQ     'PREP4'       $PREP4
016000030703     C     @STEP         CASEQ     'STEP4'       $STEP4
016100030703     C     @STEP         CASEQ     'PREP5'       $PREP5
016200030703     C     @STEP         CASEQ     'STEP5'       $STEP5
016300030703     C     @STEP         CASEQ     'PREP6'       $PREP6
016400030703     C     @STEP         CASEQ     'STEP6'       $STEP6
016500030703     C                   ENDCS
016600030701     C                   ENDDO
016700030701    ***
016800030701     C                   EVAL      *INLR = *ON
016900030701   S***S
017000030701     C     *INZSR        BEGSR
017100030701    ***
017200030701     C     *DTAARA       DEFINE    COMPANY       @DTA50
017300030701     C                   IN        @DTA50
017400030701    * *
017500030701     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
017600030701    ***
017700030701     C                   EVAL      @STEP = 'STEP0'
017800030701    ***
017900030701     C     KEY#ACC       KLIST
018000030701     C                   KFLD                    KEY@TRS
018100030701     C                   KFLD                    KEY@SUB
018200030701     C                   KFLD                    KEY@ACC
018300030701    ***
018400030701     C     KEY#PLN       KLIST
018500030701     C                   KFLD                    KEY@TRS
018600030701     C                   KFLD                    KEY@SUB
018700030701     C                   KFLD                    KEY@PLN
018800030701    ***
018900030701     C     KEY#RPA       KLIST
019000050519     C                   KFLD                    KEY@CPDAT
019100061218     C                   KFLD                    KEY@CDAT
019200080207     C                   KFLD                    KEY@seq
019300030701     C                   KFLD                    KEY@RELID
019400030701     C                   KFLD                    KEY@TRS
019500030701     C                   KFLD                    KEY@SUB
019600030701     C                   KFLD                    KEY@ACC
019700030701     C                   KFLD                    KEY@GRP
019800030701     C                   KFLD                    KEY@PLN
019900030701     C                   KFLD                    KEY@EFDT
020000030701    ***
020100110609     c     mkcaky        klist
020200110609     C                   KFLD                    KEY@TRS
020300110609     C                   KFLD                    KEY@SUB
020400110609     C                   KFLD                    KEY@ACC
020500110609     C                   KFLD                    KEY@CAR
020600110609
020700030701     C                   ENDSR
020800030701   S***S
020900030701     C     $STEP0        BEGSR
021000030701    ***
021100030701     C                   CLEAR                   SCREEN
021200030703     C                   MOVEA     '010111000'   *IN(25)
021300030701    ***
021400030701     C                   EVAL      CONAME = GBSREALM
021500030701     C                   EVAL      @STEP = 'STEP1'
021600030701    ***
021700030701     C                   Z-ADD     P_CDAT        I_CDAT
021800080207     C                   Z-ADD     P_seq         I_seq
021900050519     C                   Z-add     P_CPDAT       I_CPDAT
022000030701     C                   EVAL      S_RELID = P_RELID
022100030703     C                   EVAL      S_TRS   = P_TRST
022200030701     C                   EVAL      S_SUB   = P_SUB
022300030701     C                   EVAL      S_ACC   = P_ACC
022400030701     C                   EVAL      S_ANM   = P_ANM
022500030701     C                   EVAL      S_GRP   = P_GRP
022600110830     C**                 EVAL      S_mksz  = P_mksz
022700030701     C                   EVAL      S_PLAN  = P_PLAN
022800030701     C                   EVAL      S_PDSC  = P_PDSC
022900050308*************************EVAL      S_PCAR  = P_PCAR
023000050308**************************VAL      S_CNAM  = P_CNAM
023100030701     C                   EVAL      I_EFDT  = P_EFDT
023200030701    ***
023300030701     C                   ENDSR
023400030701   S***S
023500030701     C     $STEP1        BEGSR
023600030701    ***
023700030701     C                   EVAL      EMSG = %TRIM(@EMSG)
023800030701     C                   EXFMT     SCREEN
023900030701     C                   EVAL      @EMSG = *BLANKS
024000030701    ***
024100030701     C                   IF        FKEY = F3
024200030701     C                   EVAL      @STEP = 'LEAVE'
024300030701     C                   LEAVESR
024400030701     C                   ENDIF
024500030701    ***
024600030701     C                   IF        FKEY = F5
024700030701     C                   EXSR      $F5
024800030701     C                   LEAVESR
024900030701     C                   ENDIF
025000030701    ***
025100030701     C                   EXSR      $VALIDATE
025200030701     C                   IF        ERROR_FREE = YES
025300030701     C                   EXSR      $SAVALUE
025400030703     c                   select
025500030703     C                   when      ACTION = 'R'
025600030701     C                   EVAL      @STEP = 'PREP2'
025700030703     C                   when      ACTION = 'A'
025800030703     C                   EVAL      @STEP = 'PREP4'
025900030703     C                   when      ACTION = 'C'
026000030703     C                   EVAL      @STEP = 'PREP5'
026100030703     C                   when      ACTION = 'D'
026200030703     C                   EVAL      @STEP = 'PREP6'
026300030703     C                   endsl
026400030701     C                   ENDIF
026500030701    ***
026600030701     C                   ENDSR
026700030701   S***S
026800030701     C     $F5           BEGSR
026900030701    ***
027000030701     C                   EVAL      @35 = *BLANKS
027100030701    ***
027200030701     C                   CALL      'FM484CL'
027300030701     C                   PARM                    @35
027400030701    ***
027500030701     C                   IF        %SUBST(@35:1:3) <> '*LR'
027600030701    * *
027700030701     C                   EVAL      S_RELID = %SUBST(@35:1:8)
027800030701     C                   EXSR      $VLDRLT
027900030701    * *
028000030701     C                   IF        RELID_GOOD = NO
028100030701     C                   EVAL      @EMSG = 'INVALID RELATION ID RETURNED BY INQ'
028200030701     C                   ENDIF
028300030701    * *
028400030701     C                   ENDIF
028500030701    ***
028600030701     C                   ENDSR
028700030701   S***S
028800030701     C     $VLDRLT       BEGSR
028900030701    ***
029000030701     C                   EVAL      RELID_GOOD = NO
029100030701    ***
029200030701     C     S_RELID       CHAIN     SRF
029300030701     C                   IF        NOT %FOUND(SMANRLT)
029400030701     C                   LEAVESR
029500030701     C                   ENDIF
029600030701    * *
029700030703     C                   EVAL      S_SMcd = SRSMAN
029800030701     C                   EXSR      $GETSMAN
029900030701    ***
030000030701     C     SRASID        CHAIN     SXF
030100030701     C                   IF        NOT %FOUND(SPRAGXR2)
030200030701     C                   LEAVESR
030300030701     C                   ENDIF
030400030701    * *
030500030701     C                   EVAL      O_SUPER = SXSUPER
030600030701     C                   EVAL      S_CCDE = SXAGCY
030700030701    ***
030800030701     C                   EVAL      RELID_GOOD = YES
030900030701    ***
031000030701     C                   ENDSR
031100030701   S***S
031200030701     C     $GETSMAN      BEGSR
031300030701    ***
031400030703     C     S_SMcd        CHAIN     SMANR
031500030701    * *
031600030701     C                   IF        %FOUND(SMAN)
031700030701    * *
031800030701     C                   EVAL      S_SLNM = %TRIM(SLNAME)
031900030701     C                   EVAL      S_SFNM = %TRIM(SFNAME)
032000030701     C                   EVAL      S_SMI = SMI
032100030701    * *
032200030701     C                   ELSE
032300030701    * *
032400030701     C                   EVAL      S_SLNM = '*FAILED*'
032500030701     C                   EVAL      S_SFNM = *BLANKS
032600030701     C                   EVAL      S_SMI = *BLANKS
032700030701    * *
032800030701     C                   ENDIF
032900030701    ***
033000030701     C                   ENDSR
033100030701   S***S
033200030701     C     $VALIDATE     BEGSR
033300030701    ***
033400030701     C                   EVAL      ERROR_FREE = NO
033500030701    ***
033600030701     C                   IF        ACTION <> 'A' AND ACTION <> 'C' AND
033700030701     C                             ACTION <> 'D' AND ACTION <> 'R'
033800030701     C                   EVAL      @EMSG = 'ACTION CODE IS INVALID OR BLANK'
033900030701     C                             + ' PLEASE SELECT A, C, D, OR R'
034000030701     C                   LEAVESR
034100030701     C                   ENDIF
034200030804    ***
034300080125    *** commission date
034400030701     C                   Z-ADD     I_CDAT        #XSX
034500030701     C                   EXSR      $CVTUSO
034600030701     C                   IF        DATE_ERROR = YES
034700030701     C                   EVAL      @EMSG = 'COMMISSION ' + @EMSG
034800030701     C                   LEAVESR
034900030701     C                   ENDIF
035000030701    * *
035100030701     C                   MOVE      #XSX          S_CDAT
035200080207    *** seq
035300080207     C                   MOVE      i_seq         S_seq
035400050519    ***
035500080125      * commission paid date
035600050519     C                   Z-ADD     I_CPDAT       #XSX
035700050609     C                   If        #XSX     <>   *Zero
035800050519     C                   EXSR      $CVTUSO
035900080129      * also verify day = 01
036000080129     c                   movel     i_cpdat       testmd            4 0
036100080129     c                   move      testmd        testday           2 0
036200080129     c                   if        testday <> 01
036300080129     C                   eval      DATE_ERROR = YES
036400080129     c                   end
036500080129     C                   End
036600080129
036700050609     C                   IF        DATE_ERROR = YES
036800050609     C                   Eval      @EMSG = *Blanks
036900050519     C                   EVAL      @EMSG = 'COMMISSION PAID DATE NOT' +
037000050519     C                              ' VALID' + @EMSG
037100050519     C                   LEAVESR
037200050519     C                   ENDIF
037300050519    ***
037400050519     C                   Movel     #XSX          #First
037500050610     C                   IF        FirstofMonth <> '01'  And
037600050609     C                             FirstofMonth <> '00'
037700050519     C                   EVAL      @EMSG = 'COMMISSION PAID DATE' +
037800050519     C                              ' MUST BE 1ST OF MONTH' + @EMSG
037900050519     C                   EVAL      DATE_ERROR = YES
038000050519     C                   LEAVESR
038100050519     C                   ENDIF
038200050519    * *
038300050519     C                   MOVE      #XSX          S_CPDAT
038400030701    ***
038500030701     C                   EXSR      $VLDRLT
038600030701    * *
038700030701     C                   IF        RELID_GOOD = NO
038800030701     C                   EVAL      @EMSG = 'INVALID RELATION ID'
038900030701     C                   LEAVESR
039000030701     C                   ENDIF
039100030701    ***
039200030701     C                   EXSR      $ACCTCHK
039300030701     C                   IF        GOOD_ACCT = NO
039400030701     C                   LEAVESR
039500030701     C                   ENDIF
039600030701    ***
039700030703     C                   IF        ACTION <> 'R' AND S_TRS <> 999
039800030701     C                   EVAL      KEY@GRP = S_GRP
039900030701     C     KEY@GRP       CHAIN     GRATER
040000030701     C                   IF        NOT %FOUND(GRATEL1)
040100150904      ************
040200161108      * 11/8/16 - temp disable edit, then put back  (comment out next 2
040201161108      *           lines)
040300161108     C                   EVAL      @EMSG = 'INVALID GROUP NUMBER'
040400161108     C                   LEAVESR
040500150904      ************
040600030701     C                   ENDIF
040700030701     C                   ENDIF
040800030703     C                   EVAL      KEY@GRP = S_GRP
040900030701    ***
041000030701     C                   EXSR      $PLANCHK
041100030701     C                   IF        GOOD_PLAN = NO
041200030701     C                   LEAVESR
041300030701     C                   ENDIF
041400030701    ***
041500030701     C                   Z-ADD     I_EFDT        #XSX
041600030701     C                   EXSR      $CVTUSO
041700030701     C                   IF        DATE_ERROR = YES
041800030701     C                   EVAL      @EMSG = 'EFFECTIVE ' + @EMSG
041900030701     C                   LEAVESR
042000030701     C                   ENDIF
042100030701    * *
042200030701     C                   MOVE      #XSX          S_EFDT
042300030701    ***
042400110609
042500110609      * validate market size
042600110609     C                   IF        ACTION <> 'R' AND S_TRS <> 999
042700110609     c                   exsr      #getmktsz
042800110609     c                   if        s_mksz <> mksz
042900110609     C                   EVAL      @EMSG = 'INVALID MARKET SIZE'
043000110609     C                   LEAVESR
043100110609     C                   end
043200110609     C                   end
043300110609
043400030701     C                   EVAL      ERROR_FREE = YES
043500030701    ***
043600030701     C                   ENDSR
043700030701   S***S
043800030701     C     $CVTUSO       BEGSR
043900030701    ***
044000030701     C                   EVAL      DATE_ERROR = YES
044100030701    ***
044200030701     C                   IF        #XSX = 0
044300030701     C                   EVAL      @EMSG = 'DATE CANNOT BE ZERO'
044400030701     C                   LEAVESR
044500030701     C                   ENDIF
044600030701    ***
044700030701     C     *USA          TEST(DE)                #XSX
044800030701     C                   IF        %ERROR
044900030701     C                   EVAL      @EMSG = 'DATE IS INVALID'
045000030701     C                   LEAVESR
045100030701     C                   ENDIF
045200030701    ***
045300030701     C                   MOVE      #XSX          #USA
045400030701     C                   MOVE      #USA          #ISO
045500030701     C                   MOVE      #ISO          #XSX
045600030701    ***
045700030701     C                   EVAL      DATE_ERROR = NO
045800030701    ***
045900030701     C                   ENDSR
046000030701   S***S
046100030701     C     $ACCTCHK      BEGSR
046200030701    ***
046300030701     C                   EVAL      GOOD_ACCT = NO
046400030703    ***
046500030703     C                   Z-ADD     S_TRS         KEY@TRS
046600030703     C                   Z-ADD     S_SUB         KEY@SUB
046700030703     C                   Z-ADD     S_ACC         KEY@ACC
046800030701    ***
046900030703     C                   IF        ACTION = 'R' OR S_TRS = 999
047000030703     C                   EVAL      S_TRS  = 999
047100030701     C                   EVAL      S_SUB = 999
047200030701     C                   EVAL      S_ACC = 9999
047300030701     C                   EVAL      GOOD_ACCT = YES
047400030701     C                   LEAVESR
047500030701     C                   ENDIF
047600030701    ***
047700030701     C     KEY#ACC       CHAIN     ACCMSR
047800030701    ***
047900030701     C                   IF        NOT %FOUND(ACCMST)
048000030701     C                   EVAL      @EMSG = 'INVALID ACCOUNT'
048100030701     C                   LEAVESR
048200030701     C                   ENDIF
048300030701    ***
048400030701     C                   EVAL      S_ANM = %TRIM(ACNAM1)
048500030701     C                   EVAL      GOOD_ACCT = YES
048600030701    ***
048700030701     C                   ENDSR
048800030701   S***S
048900030701     C     $PLANCHK      BEGSR
049000030701    ***
049100030701     C                   EVAL      GOOD_PLAN = NO
049200030703     C                   MOVEL     S_PLAN        KEY@PLN
049300030701    ***
049400030701     C                   IF        ACTION = 'R'
049500030701     C                   EVAL      S_PLAN = '9999'
049600060314     C                   EVAL      S_pcar = '999'
049700030701     C                   EVAL      GOOD_PLAN = YES
049800030701     C                   LEAVESR
049900030701     C                   ENDIF
050000030703    ***
050100030703     C                   IF        s_plan = '9999' and s_trs = 999
050200030703     C                   EVAL      GOOD_PLAN = YES
050300030703     C                   LEAVESR
050400030703     C                   ENDIF
050500030701    ***
050600030701    * *
050700030701     C     KEY#PLN       CHAIN     PLNMSR
050800030701    * *
050900030701     C                   IF        NOT %FOUND(PLNMST)
051000030701     C                   EVAL      @EMSG = 'INVALID PLAN'
051100030701     C                   LEAVESR
051200030701     C                   ENDIF
051300030701    * *
051400030703     c                   movel(p)  pdescr        s_pdsc
051500030703     ********************EVAL      S_PDSC = %SUBST(%TRIM(PDESCR):1:35)
051600030701    ***
051700030701     C     PCARR         CHAIN     CARMSR
051800030701    * *
051900030701     C                   IF        NOT %FOUND(CARMST)
052000030701     C                   EVAL      @EMSG = 'CARRIER CODE CHECK FAILED FOR PLAN'
052100030701     C                   LEAVESR
052200030701     C                   ENDIF
052300030701    * *
052400030703     c                   if        s_pcar = *blanks
052500030703     c                   movel     PCARR         s_pcar
052600030703     c                   endif
052700030703    * *
052800030701     C                   EVAL      S_CNAM = %TRIM(CNAME)
052900030701    ***
053000030701     C                   EVAL      GOOD_PLAN = YES
053100030701    ***
053200030701     C                   ENDSR
053300030701   S***S
053400030701     C     $SAVALUE      BEGSR
053500030701    ***
053600030701     C                   Z-ADD     I_CDAT        P_CDAT
053700080207     C                   Z-ADD     I_seq         P_seq
053800050519     C                   Z-add     I_CPDAT       P_CPDAT
053900030701     C                   EVAL      P_RELID = S_RELID
054000030703     C                   EVAL      P_TRST  = S_TRS
054100030701     C                   EVAL      P_SUB   = S_SUB
054200030701     C                   EVAL      P_ACC   = S_ACC
054300030701     C                   EVAL      P_ANM   = S_ANM
054400030701     C                   EVAL      P_GRP   = S_GRP
054500110609     C                   EVAL      P_mksz  = S_mksz
054600030701     C                   EVAL      P_PCAR  = S_PCAR
054700030701     C                   EVAL      P_CNAM  = S_CNAM
054800030701     C                   EVAL      P_PLAN  = S_PLAN
054900030701     C                   EVAL      P_PDSC  = S_PDSC
055000030701     C                   EVAL      P_EFDT  = I_EFDT
055100030701    ***
055200030701     C                   ENDSR
055300030701   S***S
055400030701     C     $PREP2        BEGSR
055500030701    ***
055600061218     C                   MOVE      S_CDAT        KEY@CDAT
055700080207     C                   MOVE      S_seq         KEY@seq
055800050519     C                   MOVE      S_CPDAT       KEY@CPDAT
055900030701     C                   MOVEL     S_RELID       KEY@RELID
056000030701     C                   MOVE      S_EFDT        KEY@EFDT
056100030701    ***
056200030701     C     KEY#RPA       CHAIN(N)  RPA60R
056300030701     C                   IF        %FOUND(RPA060L2)
056400030701     C                   EVAL      @EMSG = 'RECORD ALREADY EXISTS, ' +
056500030701     C                             'DUMMY ADD DENIED'
056600030701     C                   EVAL      @STEP = 'STEP1'
056700030701     C                   LEAVESR
056800030701     C                   ENDIF
056900030701    ***
057000030701     C                   CLEAR                   RPA60R
057100030701     C                   EVAL      @STEP = 'STEP2'
057200030703     C                   MOVEA     '101001111'   *IN(25)
057300030701     C                   EVAL      @EMSG = 'YOU MAY OVERRIDE TEXT '
057400030701     C                                 + 'DESCRIPTIONS NOW'
057500030701    ***
057600030701     C                   ENDSR
057700030701   S***S
057800030701     C     $STEP2        BEGSR
057900030701    ***
058000030701     C                   EVAL      EMSG = %TRIM(@EMSG)
058100030701     C                   EXFMT     SCREEN
058200030701     C                   EVAL      @EMSG = *BLANKS
058300030701    ***
058400030701     C                   IF        FKEY = F12
058500030701     C                   EVAL      @STEP = 'STEP0'
058600030701     C                   LEAVESR
058700030701     C                   ENDIF
058800030701    ***
058900030701     C                   EVAL      @STEP = 'PREP3'
059000030701    ***
059100030701     C                   ENDSR
059200030701   S***S
059300030701     C     $PREP3        BEGSR
059400030701    ***
059500030701     C                   EVAL      @STEP = 'STEP3'
059600030703     C                   MOVEA     '111110011'   *IN(25)
059700030701     C                   EVAL      @EMSG = 'ENTER COMMISSION AMOUN'
059800030701     C                                 + 'TS NOW'
059900030701    ***
060000030701     C                   ENDSR
060100030701   S***S
060200030701     C     $STEP3        BEGSR
060300081008
060400081008    *** edit dummy add rec
060500081008
060600030701     C                   EVAL      EMSG = %TRIM(@EMSG)
060700030701     C                   EXFMT     SCREEN
060800030701     C                   EVAL      @EMSG = *BLANKS
060900030701    ***
061000030701     C                   IF        FKEY = F12
061100030701     C                   EVAL      @STEP = 'PREP2'
061200030701     C                   LEAVESR
061300030701     C                   ENDIF
061400030702    ***
061500030805    *C*                  IF        S_MTHD <> 'G ' AND S_MTHD <> 'P ' AND
061600030805    *C*                            S_MTHD <> 'C ' AND S_MTHD <> 'F '
061700030805    *C*                  EVAL      @EMSG = 'METHOD REQUIRED'
061800030805    *C*                  LEAVESR
061900030805    *C*                  ENDIF
062000030804    ***
062100030805    *C*                  IF        RPMTHD = 'G ' or  RPMTHD = 'C '
062200030805     C*                  EXSR      $CALC
062300030805    *C*                  LEAVESR
062400030805    *C*                  ENDIF
062500030701    ***
062600081008      * edit paid field
062700110628     c                   if        s_paid <> 'N' and s_paid <> 'Y'
062800110628     C                   EVAL      @EMSG = 'PAID FIELD MUST BE Y/N         +
062900110628     c                                            '
063000081008     C                   LEAVESR
063100081008     c                   end
063200110628
063300110628     c                   if        s_paid = 'N' and
063400110628     c                             (s_pprm <> 0 or s_pcom <> 0 or
063500110628     c                              s_mcnt <> 0)
063600110628     C                   EVAL      @EMSG = 'IF PAID = N THEN PREM, COM AND +
063700110628     c                             # MBRS MUST = 0'
063800110628     C                   LEAVESR
063900110628     c                   end
064000081008
064100110610      * re-calc agency override
064200110610     C                   EXSR      #getao
064300110610
064400030701     C                   EXSR      $PREPREC
064500030703     C                   MOVE      '*'           RPDUM
064600080125     C***                Eval      RPCPDDT   =   *Zeros
064700030701     C                   WRITE     RPA60R
064800030701     C                   EXSR      $SAVALUE
064900030701     C                   EVAL      @STEP = 'STEP0'
065000030701    ***
065100030701     C                   ENDSR
065200030701   S***S
065300030701     C     $PREPREC      BEGSR
065400030701    ***
065500030701     C                   MOVE      S_CDAT        RPCDAT
065600080207     C                   MOVE      S_seq         RPseq#
065700080125     C                   MOVE      S_Cpdat       RPCpddt
065800030701     C                   MOVEL     S_SMCD        RPSMCD
065900030701     C                   MOVEL     S_SLNM        RPSLNM
066000030701     C                   MOVEL     S_SFNM        RPSFNM
066100030701     C                   MOVEL     S_SMI         RPSMI
066200030701     C                   MOVEL     S_CCDE        RPCCDE
066300030703     C                   MOVE      S_TRS         RPTRST
066400030701     C                   MOVE      S_SUB         RPSUB
066500030701     C                   MOVE      S_ACC         RPACC
066600030701     C                   MOVEL     S_ANM         RPANM
066700110609     C                   MOVEL     S_mksz        RPmaszcd
066800030701     C                   MOVEL     S_GRP         RPGRP
066900030701     C                   MOVEL     S_PCAR        RPPCAR
067000030701     C                   MOVEL     S_CNAM        RPCNAM
067100030701     C                   MOVEL     S_PLAN        RPPLAN
067200030701     C                   MOVEL     S_PDSC        RPPDSC
067300030701     C                   MOVE      S_CMRT        RPCMRT
067400030701     C                   MOVE      S_MCNT        RPMCNT
067500081008     C                   MOVE      S_paid        RPpaid
067600110608     C                   MOVE      S_aorate      RPaorate
067700110608     C                   MOVE      S_aomthd      RPaomthd
067800110608     C                   MOVE      S_aoamt       RPaoamt
067900030701     C                   MOVE      S_PPRM        RPPPRM
068000030701     C                   MOVE      S_PCOM        RPPCOM
068100030701     C                   MOVEL     S_NOTE        RPNOTE
068200030703     c                   move      '000000'      @6                6
068300030703     c                   move      s_efdt        @8                8
068400030703     c                   eval      @6 = %subst(@8:1:4) + %subst(@8:5:2)
068500030703     C                   MOVE      @6            RPEDAT
068600030701     C                   MOVE      S_EFDT        RPEFDT
068700030701     C                   MOVEL     S_MTHD        RPMTHD
068800030701     C                   MOVE      S_PSPL        RPPSPL
068900030701     C                   MOVE      S_RELID       RPRELID
069000050505
069100050505    * * A = Manual Add from this program
069200050505     C                   MOVE      'A'           RPCHG
069300030701    ***
069400030701     C                   ENDSR
069500030701   S***S
069600030702     C     $CALC         BEGSR
069700030701    ***
069800040819     C                   IF        S_MTHD = 'G ' OR S_MTHD = 'C ' or
069900040819     C                             S_MTHD = 'F '
070000030702     C     S_MCNT        MULT(H)   S_CMRT        S_PCOM
070100030702     C                   ELSE
070200030702     C     S_PPRM        MULT(H)   S_CMRT        S_PCOM
070300030702     C     S_PCOM        DIV(H)    100           S_PCOM
070400030702     C                   ENDIF                                                  RPMTHD = 'G '
070500030702    ***
070600030702     C                   ENDSR
070700030702   S***S
070800110608      *************************************************
070900110608      * get agency override
071000110608      *************************************************
0711001106080120 C     #getao        begsr
0712001106080456
071300110608     c     grplist       plist
071400110608     c                   parm                    parmrel
071500110608     c                   parm                    parmcar
071600110608     c                   parm                    parmmksz
071700110608     c                   parm                    parmeffymd
071800110608     c                   parm                    parmcomamt
071900110608     c                   parm                    parmprem
072000110608     c                   parm                    parmmcnt
072100110608     c                   parm                    parmmethod
072200110608     c                   parm                    parmrate
072300110608     c                   parm                    parmovramt
072400110608     c                   parm                    parmfound
072500110608
072600110609      * set parameter values
072700110609     c                   move      S_RELID       parmrel
072800110609     c                   move      S_PCAR        parmcar
072900110609     c                   move      s_mksz        parmmksz
073000110609     c                   move      s_efdt        parmeffymd
073100110609     c                   move      s_pcom        parmcomamt
073200110609     c                   move      s_pprm        parmprem
073300110609     c                   move      s_mcnt        parmmcnt
073400110608     c                   clear                   parmmethod
073500110608     c                   clear                   parmrate
073600110608     c                   clear                   parmovramt
073700110608     c                   clear                   parmfound
073800110608
073900110608     c                   call      'GETAO'       grplist
074000110608
074100110608      * if a valid agency override was found then move the calculated
074200110609      * retun values to the screen
074300110628     c                   if        parmfound = 'Y'
074400110609     c                   move      parmmethod    s_aomthd
074500110609     c                   move      parmrate      s_aorate
074600110609     c                   move      parmovramt    s_aoamt
074700110608     c                   end
074800110610
074900110610      * clear agency override values if the record is not "paid"
075000110610     c                   IF        s_paid <> 'Y'
075100110610     c                   clear                   s_aomthd
075200110610     c                   clear                   s_aorate
075300110610     c                   clear                   s_aoamt
075400110610     C                   end
075500110608
0756001106080120 C                   ENDSR
075700110608
075800030702     C     $PREP4        BEGSR
075900030702    ***
076000030702     C                   MOVE      S_CDAT        KEY@CDAT
076100080207     C                   MOVE      S_seq         KEY@seq
076200050519     C                   MOVE      S_CPDAT       KEY@CPDAT
076300030702     C                   MOVEL     S_RELID       KEY@RELID
076400030702     C                   MOVE      S_EFDT        KEY@EFDT
076500030702    ***
076600030702     C     KEY#RPA       CHAIN(N)  RPA60R
076700030702     C                   IF        %FOUND(RPA060L2)
076800030702     C                   EVAL      @EMSG = 'RECORD ALREADY EXISTS, ' +
076900030702     C                             'ADD DENIED'
077000030702     C                   EVAL      @STEP = 'STEP1'
077100030702     C                   LEAVESR
077200030702     C                   ENDIF
077300030702    ***
077400030702     C                   CLEAR                   RPA60R
077500030703     c                   move      i_efdt        #iefdt
077600080125     c                   move      i_cpdat       #icpdat
077700030702     C                   EVAL      @STEP = 'STEP4'
077800040810     C                   MOVEA     '111110111'   *IN(25)
077900030702     C                   EVAL      @EMSG = 'ENTER COMMISSION AMOUN'
078000030702     C                                 + 'TS NOW'
078100110628      * default paid field to "Y"
078200110628     c                   eval      s_paid = 'Y'
078300030701    ***
078400030701     C                   ENDSR
078500030701   S***S
078600030702     C     $STEP4        BEGSR
078700030701    ***
078800030702     C                   EVAL      EMSG = %TRIM(@EMSG)
078900030702     C                   EXFMT     SCREEN
079000030702     C                   EVAL      @EMSG = *BLANKS
079100030702    ***
079200030702     C                   IF        FKEY = F12
079300030703     C                   EVAL      @STEP = 'STEP0'
079400030702     C                   EVAL      @EMSG = 'RECORD ADD FUNCTION CANCELLED.'
079500030702     C                   LEAVESR
079600030702     C                   ENDIF
079700030702    ***
079800030805     C                   IF        COMSCH = '2'
079900030804     C                   IF        S_MTHD <> 'G ' AND S_MTHD <> 'P ' AND
080000050816     C                             S_MTHD <> 'C ' AND S_MTHD <> 'F ' and
080100050816     C                             S_MTHD <> 'O '
080200030804     C                   EVAL      @EMSG = 'METHOD REQUIRED'
080300030804     C                   LEAVESR
080400030805     C                   ENDIF
080500030804     C                   ENDIF
080600030804    ***
080700030805    *C*                  IF        s_MTHD = 'G ' or  s_MTHD = 'C '
080800030702     C                   EXSR      $CALC
080900110610      * re-calc agency override
081000110610     C                   EXSR      #getao
081100110610    ***
081200030805    *C*                  ENDIF
081300080125    *** eff date
081400030703     c                   if        i_efdt <> #iefdt
081500030703     c                   move      i_efdt        #iefdt
081600030703     C                   Z-ADD     I_EFDT        #XSX
081700030703     C                   EXSR      $CVTUSO
081800030703     C                   IF        DATE_ERROR = YES
081900030703     C                   EVAL      @EMSG = 'EFFECTIVE ' + @EMSG
082000030703     C                   LEAVESR
082100030703     C                   ENDIF
082200030703     C                   MOVE      #XSX          S_EFDT
082300030703     C                   ENDIF
082400080125    *** comm paid date
082500080125     c                   if        i_cpdat <> #icpdat
082600080125     c                   move      i_cpdat       #icpdat
082700080125     C                   Z-ADD     I_cpdat       #XSX
082800080125     c                   if        i_cpdat <> 0
082900080125     C                   EXSR      $CVTUSO
083000080129      * also verify day = 01
083100080129     c                   movel     i_cpdat       testmd            4 0
083200080129     c                   move      testmd        testday           2 0
083300080129     c                   if        testday <> 01
083400080129     C                   eval      DATE_ERROR = YES
083500080129     C                   EVAL      @EMSG = 'DAY MUST BE 01'
083600080129     c                   end
083700080125     C                   IF        DATE_ERROR = YES
083800080125     C                   EVAL      @EMSG = 'COMM PAID ' + @EMSG
083900080125     C                   LEAVESR
084000080125     C                   ENDIF
084100080125     C                   end
084200080125     C                   MOVE      #XSX          S_cpdat
084300080125     C                   ENDIF
084400081008      * edit paid field
084500081008     c                   if        s_paid = 'N' and
084600081008     c                             (s_pprm <> 0 or s_pcom <> 0 or
084700081008     c                              s_mcnt <> 0)
084800081008     C                   EVAL      @EMSG = 'IF PAID = N THEN PREM, COM AND +
084900081008     c                             # MBRS MUST = 0'
085000081008     C                   LEAVESR
085100081008     c                   end
085200080125    ***
085300030702     C                   EXSR      $PREPREC
085400030702     C                   WRITE     RPA60R
085500030702     C                   EXSR      $SAVALUE
085600050208     C                   EVAL      EMSG = 'Press enter or Fx key to continue.'
085700050208     C                   EXFMT     SCREEN
085800050208     C                   EVAL      @EMSG = *BLANKS
085900030702     C                   EVAL      @STEP = 'STEP0'
086000030701    ***
086100030701     C                   ENDSR
086200030701   S***S
086300030702     C     $PREP5        BEGSR
086400030701    ***
086500030702     C                   MOVE      S_CDAT        KEY@CDAT
086600080207     C                   MOVE      S_seq         KEY@seq
086700050519     C                   MOVE      S_CPDAT       KEY@CPDAT
086800030702     C                   MOVEL     S_RELID       KEY@RELID
086900030702     C                   MOVE      S_EFDT        KEY@EFDT
087000030703     c                   move      i_efdt        #iefdt            8 0
087100080125     c                   move      i_cpdat       #icpdat           8 0
087200030702    ***
087300030702     C     KEY#RPA       CHAIN(N)  RPA60R
087400030702     C                   IF        NOT %FOUND(RPA060L2)
087500030702     C                   EVAL      @EMSG = 'RECORD DOES NOT EXISTS, ' +
087600030702     C                             'CHANGE DENIED'
087700030702     C                   EVAL      @STEP = 'STEP1'
087800030702     C                   LEAVESR
087900030702     C                   ENDIF
088000030702    ***
088100030702     C     KEY#RPA       CHAIN     RPA60R
088200030703    ***
088300031103     C                   EXSR      $REC2SCR
088400031103     C                   EXSR      $SAVALUE
088500030703    ***
088600030702     C                   EVAL      @STEP = 'STEP5'
088700030703     C                   MOVEA     '111110110'   *IN(25)
088800030702     C                   EVAL      @EMSG = 'CHANGE COMMISSION AMOUN'
088900030702     C                                 + 'TS NOW'
089000031103    ***
089100031103     C                   ENDSR
089200031103   S***S
089300031103     C     $REC2SCR      BEGSR
089400031103    ***
089500031103     C                   MOVE      RPCMRT        S_CMRT
089600031103     C                   MOVE      RPMCNT        S_MCNT
089700081008     C                   MOVE      RPpaid        S_paid
089800110608     C                   MOVE      RPaorate      S_aorate
089900110608     C                   MOVE      RPaomthd      S_aomthd
090000110608     C                   MOVE      RPaoamt       S_aoamt
090100031103     C                   MOVE      RPPPRM        S_PPRM
090200031103     C                   MOVE      RPPCOM        S_PCOM
090300031103     C                   MOVEL     RPMTHD        S_MTHD
090400031103     C                   MOVEL     RPNOTE        S_NOTE
090500031103     C                   MOVE      RPPSPL        S_PSPL
090600031103     C                   MOVEL     RPPDSC        S_PDSC
090700031103     C                   MOVEL     RPANM         S_ANM
090800110609      * if market size is blank in rpa060wk then use keep the calculated
090900110609      * value on the screen so it updates rpa060wk
091000110609     c                   if        rpmaszcd <> *blanks
091100110609     C                   MOVEL     RPmaszcd      S_mksz
091200110609     c                   end
091300031103     C                   MOVEL     RPPCAR        S_PCAR
091400031103     C                   MOVEL     RPCNAM        S_CNAM
091500030701    ***
091600030701     C                   ENDSR
091700030701   S***S
091800030702     C     $STEP5        BEGSR
091900030701    ***
092000030702     C                   EVAL      EMSG = %TRIM(@EMSG)
092100030702     C                   EXFMT     SCREEN
092200030702     C                   EVAL      @EMSG = *BLANKS
092300030702    ***
092400030702     C                   IF        FKEY = F12
092500030702     C                   UNLOCK    RPA060L2
092600030703     C                   EVAL      @STEP = 'STEP0'
092700030702     C                   EVAL      @EMSG = 'RECORD CHG FUNCTION CANCELLED.'
092800030702     C                   LEAVESR
092900030702     C                   ENDIF
093000030702    ***
093100030708     C                   EXSR      $VLDRLT
093200030708    * *
093300030708     C                   IF        RELID_GOOD = NO
093400030708     C                   EVAL      @EMSG = 'INVALID RELATION ID'
093500030708     C                   LEAVESR
093600030708     C                   ENDIF
093700030804    ***
093800030805     C                   IF        COMSCH = '2'
093900030804     C                   IF        S_MTHD <> 'G ' AND S_MTHD <> 'P ' AND
094000050816     C                             S_MTHD <> 'C ' AND S_MTHD <> 'F ' and
094100050816     C                             S_MTHD <> 'O '
094200030804     C                   EVAL      @EMSG = 'METHOD REQUIRED'
094300030804     C                   LEAVESR
094400030805     C                   ENDIF
094500030804     C                   ENDIF
094600081008
094700081008      * edit paid field
094800081008     c                   if        s_paid = 'N' and
094900081008     c                             (s_pprm <> 0 or s_pcom <> 0 or
095000081008     c                              s_mcnt <> 0)
095100081008     C                   EVAL      @EMSG = 'IF PAID = N THEN PREM, COM AND +
095200081008     c                             # MBRS MUST = 0'
095300081008     C                   LEAVESR
095400081008     c                   end
095500081008
095600030708    ***
095700030703     c                   exsr      $chk4upd
095800030703     c                   if        change_fnd = yes
095900030703     c                   leavesr
096000030703     c                   endif
096100030702    ***
096200030702     C                   EXSR      $PREPUPD
096300030702     C                   UPDATE    RPA60R
096400030702     C                   EXSR      $SAVALUE
096500030702     C                   EVAL      @STEP = 'STEP0'
096600030703    ***
096700030703     C                   ENDSR
096800030703   S***S
096900030703     C     $chk4upd      BEGSR
097000030703    ***
097100030703     c                   eval      change_fnd = no
097200030703    ***
097300110609      * member count, comm rate or premium change
097400030808     c                   IF        (s_mcnt <> rpmcnt or s_cmrt <> rpcmrt
097500030703     c                             or s_pprm <> rppprm)
097600030703     C                   EXSR      $CALC
097700110609      * re-calc agency override
097800110609     C                   EXSR      #getao
097900030703     c                   eval      change_fnd = yes
098000030703     C                   ENDIF
098100110609
098200110609      * paid Y/N change or
098300110609      * relation change or commision amount change
098400110609     c                   IF        (s_paid <> rppaid) or
098500110609     c                             (rprelid <> s_relid) or
098600110609     c                             (rppcom <> s_pcom)
098700110609      * re-calc agency override
098800110609     C                   EXSR      #getao
098900081008     c                   eval      change_fnd = yes
099000081008     C                   ENDIF
099100030703    ***
099200080125      * effdt change
099300030703     c                   if        i_efdt <> #iefdt
099400030703     c                   move      i_efdt        #iefdt
099500030703     C                   Z-ADD     I_EFDT        #XSX
099600030703     C                   EXSR      $CVTUSO
099700030703     C                   IF        DATE_ERROR = YES
099800030703     C                   EVAL      @EMSG = 'EFFECTIVE ' + @EMSG
099900030703     C                   LEAVESR
100000030703     C                   ENDIF
100100030703     C                   MOVE      #XSX          S_EFDT
100200110609      * re-calc agency override
100300110609     C                   EXSR      #getao
100400030703     c                   eval      change_fnd = yes
100500030703     C                   ENDIF
100600030708    ***
100700080125      * comm paid date change
100800080125     c                   if        i_cpdat <> #icpdat
100900080125     c                   move      i_cpdat       #icpdat
101000080125     C                   Z-ADD     I_cpdat       #XSX
101100080125     c                   if        i_cpdat <> 0
101200080125     C                   EXSR      $CVTUSO
101300080129      * also verify day = 01
101400080129     c                   movel     i_cpdat       testmd            4 0
101500080129     c                   move      testmd        testday           2 0
101600080129     c                   if        testday <> 01
101700080129     C                   eval      DATE_ERROR = YES
101800080129     C                   EVAL      @EMSG = 'DAY MUST BE 01'
101900080129     c                   end
102000080125     C                   IF        DATE_ERROR = YES
102100080125     C                   EVAL      @EMSG = 'COMM PAID ' + @EMSG
102200080125     C                   LEAVESR
102300080125     C                   ENDIF
102400080125     C                   end
102500080125     C                   MOVE      #XSX          S_cpdat
102600080125     c                   eval      change_fnd = yes
102700080125     C                   ENDIF
102800080125    ***
102900030703    ***
103000030703     c                   if        change_fnd = yes
103100030703     C                   EXSR      $PREPUPD
103200030703     c                   endif
103300030702    ***
103400030702     C                   ENDSR
103500030702   S***S
103600030702     C     $PREPUPD      BEGSR
103700030702    ***
103800050505    * * mark rec as changed if it was not a manual add
103900050505     c                   if        rpchg <> 'A'
104000030703     C                   MOVE      '*'           RPCHG
104100050505     c                   end
104200050505
104300030702     C                   MOVE      S_RELID       RPRELID
104400030708     C                   MOVEL(p)  S_SMCD        RPSMCD
104500030708     C                   MOVEL(p)  S_SLNM        RPSLNM
104600030708     C                   MOVEL(p)  S_SFNM        RPSFNM
104700030708     C                   MOVEL(p)  S_SMI         RPSMI
104800030708     C                   MOVEL(p)  S_CCDE        RPCCDE
104900030702     C                   MOVE      S_CMRT        RPCMRT
105000030702     C                   MOVE      S_MCNT        RPMCNT
105100081008     C                   MOVE      S_paid        RPpaid
105200110608     C                   MOVE      S_aorate      RPaorate
105300110608     C                   MOVE      S_aomthd      RPaomthd
105400110608     C                   MOVE      S_aoamt       RPaoamt
105500030702     C                   MOVE      S_PPRM        RPPPRM
105600030702     C                   MOVE      S_PCOM        RPPCOM
105700030702     C                   MOVEL     S_MTHD        RPMTHD
105800030702     C                   MOVEL     S_NOTE        RPNOTE
105900030702     C                   MOVE      S_PSPL        RPPSPL
106000030703     c                   move      '000000'      @6                6
106100030703     c                   move      s_efdt        @8                8
106200030703     c                   eval      @6 = %subst(@8:1:4) + %subst(@8:5:2)
106300030703     C                   MOVE      @6            RPEDAT
106400030703     c                   move      s_efdt        rpefdt
106500080125     c                   move      s_cpdat       rpcpddt
106600030701    ***
106700030701     C                   ENDSR
106800030701   S***S
106900030703     C     $PREP6        BEGSR
107000030702    ***
107100030703     C                   MOVE      S_CDAT        KEY@CDAT
107200080207     C                   MOVE      S_seq         KEY@seq
107300050519     C                   MOVE      S_CPDAT       KEY@CPDAT
107400030703     C                   MOVEL     S_RELID       KEY@RELID
107500030703     C                   MOVE      S_EFDT        KEY@EFDT
107600030703    ***
107700030703     C     KEY#RPA       CHAIN(N)  RPA60R
107800030703     C                   IF        NOT %FOUND(RPA060L2)
107900030703     C                   EVAL      @EMSG = 'RECORD DOES NOT EXIST, ' +
108000030703     C                             'DELETE DENIED'
108100030703     C                   EVAL      @STEP = 'STEP1'
108200030703     C                   LEAVESR
108300030703     C                   ENDIF
108400030703    ***
108500030703     C     KEY#RPA       CHAIN     RPA60R
108600031103     C                   EXSR      $REC2SCR
108700030703     C                   EVAL      @STEP = 'STEP6'
108800030703     C                   MOVEA     '001111101'   *IN(25)
108900030703     C                   EVAL      @EMSG = 'PRESS ENTER TO DELETE OR F12'
109000030703     C                                 + ' TO CANCEL'
109100030702    ***
109200030702     C                   ENDSR
109300030702   S***S
109400030703     C     $STEP6        BEGSR
109500030702    ***
109600030703     C                   EVAL      EMSG = %TRIM(@EMSG)
109700030703     C                   EXFMT     SCREEN
109800030703     C                   EVAL      @EMSG = *BLANKS
109900030703    ***
110000030703     C                   IF        FKEY = F12
110100030703     C                   UNLOCK    RPA060L2
110200030703     C                   EVAL      @STEP = 'STEP0'
110300030703     C                   EVAL      @EMSG = 'RECORD CHG FUNCTION CANCELLED.'
110400030703     C                   LEAVESR
110500030703     C                   ENDIF
110600030703    ***
110700030703     C                   EXSR      $SAVALUE
110800030703     C                   EVAL      @STEP = 'STEP0'
110900030703     C     KEY#RPA       DELETE    RPA60R
111000030702    ***
111100030702     C                   ENDSR
111200110609
111300110609      *************************************************
111400110609      * get acct / carrier market size
111500110609      *************************************************
1116001106090120 C     #getmktsz     begsr
1117001106090456  * Get Acct Mkt size - default to 50 if not found
111800110609     c                   clear                   mksz
111900110609     c                   eval      KEY@TRS = s_trs
112000110609     c                   eval      KEY@SUB = s_sub
112100110609     c                   eval      KEY@ACC = s_acc
112200110609     c                   eval      KEY@CAR = s_pcar
112300110609
112400110609     c     mkcaky        setll     mktcara1
112500110609     C                   dou       %eof(mktcara1)
112600110609     c     mkcaky        reade     mktcara1
112700110609     c                   if        (not %eof(mktcara1)) and (mafrdt <> matodt)
112800110609     c                             and (mafrdt <= s_efdt) and
112900110609     c                             ((matodt >= s_efdt) or (matodt = 0))
113000110609     c                   movel     maszcd        mksz
113100110609     c                   leave
113200110609     c                   endif
113300110609     c                   enddo
1134001106090456  *
113500110609     c                   if        mksz = *blanks
113600110609     c                   movel     '50'          mksz
113700110609     c                   endif
113800110609
113900110609      * if the market size was blank on the screen / from the file then
114000110609      * fill it in with the value obtained here
114100110609     c                   if        s_mksz = *blanks
114200110609     c                   movel     mksz          s_mksz
114300110609     c                   endif
114400110609    * *
1145001106090120 C                   ENDSR
