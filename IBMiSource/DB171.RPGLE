000100140606     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200140606     H ALWNULL(*USRCTL)
0003009908180002 F******************************************************************
0004009908190003 F* DB171      GROUP BENEFIT SERVICES SOFTWARE                     *
0005009908180004 F*                                                                *
0006009908180013 F*  DESCRIPTION - COBRA MEMBERS RATE AUDIT RUN FROM TR130         *
0007009908180004 F*                                                                *
0008009908180004 F* DLK 08/12/99 - COPY OF DB170 USED IN TR130 (COBRA INVOICE)     *
0009009908180004 F*                AS A PRE INVOICE RATE AUDIT AND RENEWAL LETTER  *
0010009908180004 F*                PRINT                                           *
001100000414     F* 04/14/00 DLK - change hard coded cobra administrator name      *
001200000414     F*                to use "COB" aacode name                        *
001300020228     F* 02/28/02 DLK - do not include member if account is termed      *
001400020228     F*                <= run date                                     *
001500020313     F* 03/13/02 SZZ - Retrieve the selected trusts from a file rather *
001600020313     F*                than from the LDA.                              *
001700020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
001800050408     F* 04/08/05 DLK - change letter - remove acc#, add Cust #, fix    *
001900050408     F*                cobra aa name                                   *
002000060607     F* 06/07/06 DLK - fix total error count                           *
002100071011      * 10/11/07 dlk - convert to use external pgm for grate           *
002200080410     F* 04/10/08 szz - Retrieve the COBRA Alternate ID from MEMALT so  *
002300080410     F*                that member number will not show on letter.     *
002400131003      * 10/03/13 dlk  hist file expansion project
002500140106   X***X
002600140106   X***X 01.03.2014.SSK.ACA PLAN CHECK
002700140606   X***X 06.06.2014.SSK.REVISED ACA PLAN CHECK
002800140708      * 07/08/14 dlk  fix ssn parm for aca getrate
002900210326      * 03/26/21 dlk  change report to db171p2 for a unique name so
003000210326      *               espool cna use it with confidence
0031009908180004 F*                                                                *
0032009908180016 F******************************************************************
0033009908180018 FMEMBER    IP   E             DISK
0034009908180018 FMCOV      IF   E           K DISK
0035001406060034 FDEPNDC    IF   e           k DISK
0036001406060034 FDCOVC     IF   e           k DISK
0037009908120034 FACCMST    IF   E           K DISK
0038009908120019 FGRATE     IF   E           K DISK
0039009908120020 FPLNMST    IF   E           K DISK
004000000414JGE01Faacode    IF   e           k DISK
004100050408     FCOBRAAA   IF   E           K DISK
004200020313     FTRSSLC    IF   E           k DISK
004300080410     FMEMALTL3  IF   E           K Disk
0044009908160020 FDB171WK   O  A E             DISK
0045009908170020 FHIST      O  A E             DISK
0046009908160020 FDB171P    O    E             PRINTER
0047002103260021 Fdb171p2   O    F  132        PRINTER OFLIND(*INOF)
004800140606   X***X
004900140606      /DEFINE CHK_ACA_PLAN_PR
005000140606      /DEFINE CHK_ACA_PLAN_FIELDS
005100140606      /COPY QCPYSRC,ACASRVPGMP
005200140606      /UNDEFINE CHK_ACA_PLAN_PR
005300140606      /UNDEFINE CHK_ACA_PLAN_FIELDS
005400140606   X***X
0055001406060125 D YES             S               N   INZ(*ON)
0056001406060125 D NO              S               N   INZ(*OFF)
0057001406060125 D AM_I_ACA        S               N   INZ(*OFF)
005800140606     D @1              S              1A   INZ
005900140606    ***
0060009908160037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
006100990818     D AND1            C                   CONST('and all eligible dependents')
006200990818     D NOT1            C                   CONST('RENEWAL NOTICE ISSUED')
0063001310030037 D sysdateymd      S               d   datfmt(*iso)
006400131003     D thispgmname     S             10a   inz('DB171     ')
0065000710110048 D                 DS
0066000710110055 D tspabct                 1     15
0067000710110055 D mctrst                  1      3  0
0068000710110055 D mcsub#                  4      6  0
0069000710110055 D mcplan                  7     10
0070000710110055 D mcageb                 11     12  0
0071000710110055 D mcovtp                 13     15
007200071011
0073009102150054 D* LDA                                                               DB020
0074009102150055 D                UDS
0075009908160056 D  LM                     1      2  0
0076009908180056 D  LY                     3      6  0
0077001310030056 D  LUSER                 25     34
0078009908170056 D  TAR                  100    171  0
007900990817     D                                     DIM(24)
0080009505080056 D  CONAME               201    240
0081009505090055 D  TIME                 242    247  0
008200000414     Iaccmsr
008300000414     i              aacode                      a_aacode
008400990816     C*
008500990812     C* INITIAL SELECTION DONE IN CL FOR TRUST AND COBRA
008600990812     C*
008700020314     C*
0088009911290108 C* SKIP IF NOT COBRA OR COBRA ENDS PRIOR TO THE SELECTED DATE
008900991129     C*
009000080410     C                   Eval      GBSType   =   'GBS '
009100990812     C     CEXPDT        CABLE     LYMD          #END
0092009911290108 C*
0093009911290108 C* SKIP IF COBRA BEGINS AFTER THE SELECTED DATE
0094009911290108 C*
009500991129     C                   MOVE      QEDT          QEDT2             8 0
009600991129     C                   MOVE      01            QEDT2
0097009911290110 C     QEDT2         CABGT     LYMD          #END
0098009911290108 C*
009900990812     C*
010000990812     C     TERMDT        IFNE      0
010100990817     C     TERMDT        ANDLE     LYMD
010200990812     C                   GOTO      #END
010300990812     C                   END
0104009801060060 C*                                                                   UTL001
0105009908120144 C     ACCKEY        CHAIN     ACCMST                             87
010600990812     C     *IN87         CABEQ     *ON           #END
010700990812     C     FCSTFL        IFNE      'F'
010800990812     C     FCSTFL        ANDNE     'S'
010900990812     C                   GOTO      #END
011000990812     C                   END
011100020228
0112000202280060 C* skip if account is termed <= run date
011300020228     c                   if        atrmdt <> 0 and atrmdt <= lymd
011400020228     c                   goto      #end
011500020228     c                   end
011600020228
0117000202280060 C*                                                                   UTL001
0118009908120060 C* CHECK ALL VALID PLANS FOR RATES, IF AT LEAST 1 PLAN WILL BE       UTL001
0119009908120060 C* INVOICED AND THERE ARE NO RATE ERRORS - PLACE IN WORK FILE,       UTL001
0120009908120060 C* ELSE IF THER WERE ERRORS - PRINT RENEWAL LETTER AND WRITE HIST    UTL001
0121009908120060 C* REC AND DO NOT PLACE IN WORK FILE                                 UTL001
0122009908120060 C*                                                                   UTL001
0123009908120102 C                   MOVE      *ZEROS        RATERR            2 0
0124009908120102 C                   MOVE      *ZEROS        PLNCNT            2 0
0125009908120060 C*                                                                   UTL001
0126009801060076 C     MBSSNO        SETLL     MCOV
0127009908120060 C*                                                                   UTL001
012800990812     C     #T0010        TAG
0129009801060080 C     MBSSNO        READE     MCOV                                   80
0130009908120060 C*                                                                   UTL001
013100990812     C     *IN80         CABEQ     *ON           #T0020
0132009102150060 C*                                                                   UTL001
0133009505080060 C*  DATE SELECT FROM LDA                                             UTL001
0134009412160060 C*                                                                   UTL001
013500971009     C     ENRLDT        IFEQ      CANDT
013600980604     C                   GOTO      #T0010
013700971009     C                   END
013800990812     C                   MOVE      ENRLDT        MCEYMD            8 0
013900990812     C                   MOVE      01            MCEYMD
014000990812     C     MCEYMD        IFGT      LYMD
014100980604     C                   GOTO      #T0010
014200990812     C                   END
014300981112     C     CANDT         IFNE      0
014400990812     C     CANDT         ANDLE     LYMD
014500980604     C                   GOTO      #T0010
014600941216     C                   END
0147009102150061 C     PLNKEY        CHAIN     PLNMST                             51
0148009908120102 C   51              GOTO      #T0010
0149009801060062 C*
015000980604     C     SFADM         CABEQ     'Y'           #T0010
0151009102150062 C*
015200980206     C* VALID RATE NEEDED FOR RUN DATE IF ACTIVE PLAN
015300910701     C*
015400140606    ***
015500140606    *** CHECK IF ACA PLAN
015600140606    ***
015700140606     C                   MOVE      *BLANKS       @ACA              1
015800140606     C                   EVAL      @ACA = #CHK_ACA_PLAN(MCTRST:MCSUB#:MCPLAN)
015900140606    ***
016000140606    ***
016100990812     C                   ADD       1             PLNCNT
016200981112     C                   EXSR      #FNDRT
016300140606     C                   IF        @ACA = 'Y'
016400140606     C                   EVAL      *IN53 = *ON
016500140606     C                   EXSR      #DEPRT
016600140606     C                   ENDIF
016700980106     C*
016800980106     C                   GOTO      #T0010
016900980106     C*
017000990812     C     #T0020        TAG
017100990812     C*
017200990816     C* QUALIFIED FOR INVOICE AND HAS VALID RATES...PLACE IN WORKFILE
017300990812     C*
017400990812     C     PLNCNT        IFNE      0
017500990812     C     RATERR        ANDEQ     0
017600990816     C                   MOVE      MBSSNO        DBSSN
017700990816     C                   WRITE     DB171R
017800990812     C                   END
017900990812     C*
018000990816     C* QUALIFIED FOR INVOICE BUT MISSING RATES...DO NOT PLACE IN
018100990816     C* WORKFILE, PRINT LETTER, WRITE HISTORY RECORD.
018200990816     C*
018300990812     C     PLNCNT        IFNE      0
018400990812     C     RATERR        ANDNE     0
018500990812     C                   EXSR      #LTR
018600990812     C                   END
018700990812     C*
018800990812     C*
018900910701     C     #END          TAG
0190009107010073 C*
0191009107010073 C* FIND RATE
0192009107010073 C*
019300910701     C     #FNDRT        BEGSR
019400140106    ***
019500140106     C     GRPLIST       PLIST
019600140106     C                   PARM                    PARMKEY          15
019700140106     C                   PARM                    PARMSSN           9
019800140106     C                   PARM                    PARMSEQ           2
019900140106     C                   PARM                    PARMEFFYMD        8
020000140106     C                   PARM                    PARMBENAMT        7
020100140106     C                   PARM                    PARMGROUP        15
020200140106     C                   PARM                    PARMBILRTE       11
020300140106     C                   PARM                    PARMNETRTE       11
020400140106     C                   PARM                    PARMBILPREM       7
020500140106     C                   PARM                    PARMNETPREM       7
020600140106     C                   PARM                    PARMFOUND         1
020700140106    ***
020800140606     C                   IF        @ACA = 'Y'
020900140708     C                   EVAL      PARMSSN = %EDITC(mbssno:'X')
021000140606     C                   EVAL      PARMSEQ = '00'
021100140606     C                   EVAL      *IN53 = *ON
021200140606     C                   ELSE
021300140606     C                   EVAL      *IN53 = *OFF
021400140106     C                   EVAL      PARMSSN = *BLANKS
021500140106     C                   EVAL      PARMSEQ = *BLANKS
021600140606     C                   ENDIF
021700140606     C                   MOVE      *BLANKS       @DSEQ             2
021800140106    ***
021900140106     C                   MOVE      TSPABCT       PARMKEY
022000140106     C                   MOVE      LYMD          PARMEFFYMD
022100140106     C                   MOVE      BENAMT        PARMBENAMT
022200140106     C                   CLEAR                   PARMGROUP
022300140106     C                   CLEAR                   PARMBILRTE
022400140106     C                   CLEAR                   PARMNETRTE
022500140106     C                   CLEAR                   PARMBILPREM
022600140106     C                   CLEAR                   PARMNETPREM
022700140106     C                   CLEAR                   PARMFOUND
022800140106     C                   CALL      'GETRATE'     GRPLIST
022900140106    ***
023000140606     C                   EXSR      $RESULT
023100140606    ***
023200140606     C                   ENDSR
023300140606   S***S
023400140606     C     $RESULT       BEGSR
023500071011      * grate not returned
0236000710110361 C                   if        parmfound <> 'Y'
023700990817     C                   MOVE      ENRLDT        @DATIN
023800990817     C                   EXSR      #DATYM
023900990817     C                   MOVE      @DATOU        ENRMDY            8 0
024000990817     C                   MOVE      CANDT         @DATIN
024100990817     C                   EXSR      #DATYM
024200990817     C                   MOVE      @DATOU        CANMDY            8 0
0243009908170102 C                   EXCEPT    ERROR
0244000606070102 C                   ADD       1             toterr            5 0
0245000607070102 C                   ADD       1             raterr
0246009102150097 C                   END
0247009908120103 C*                                                                   UTL001
024800910701     C                   ENDSR
0249009908160103 C*                                                                   UTL001
025000140606   S***S
025100140606     C***********************************************
025200140606     C* FIND RATE FOR DEPENDENTS                    *
025300140606     C***********************************************
025400140606     C     #DEPRT        BEGSR
025500140606    ***
025600140606     C     MBSSNO        CHAIN     DEPENR
025700140606     C                   IF        NOT %FOUND(DEPNDC)
025800140606     C                   LEAVESR
025900140606     C                   ENDIF
026000140606    ***
026100140606     C     KL#SQTSP      KLIST
026200140606     C                   KFLD                    DSSNO
026300140606     C                   KFLD                    DPSEQ#
026400140606     C                   KFLD                    MCTRST
026500140606     C                   KFLD                    MCSUB#
026600140606     C                   KFLD                    MCPLAN
026700140606    ***
026800140606     C     MBSSNO        SETLL     DEPENR
026900140606     C                   DOU       %EOF(DEPNDC)
027000140606     C     MBSSNO        READE     DEPENR
027100140606     C                   IF        NOT %EOF(DEPNDC)
027200140606    ***
027300140606     C     KL#SQTSP      CHAIN     DCOVR
027400140606     C                   IF        NOT %FOUND(DCOVC)
027500140606     C                   ITER
027600140606     C                   ENDIF
027700140606    ***
027800140606     C     KL#SQTSP      SETLL     DCOVR
027900140606     C                   DOU       %EOF(DCOVC)
028000140606     C     KL#SQTSP      READE     DCOVR
028100140606     C                   IF        NOT %EOF(DCOVC) AND
028200140606     C                             DENRDT <= LYMD AND
028300140606     C                             (CCANDT = 0 OR CCANDT > LYMD)
028400140606    ***
028500140708     C                   EVAL      PARMSSN = %EDITC(mbssno:'X')
028600140606     C                   EVAL      PARMSEQ = %EDITC(DPSEQ#:'X')
028700140606     C                   EVAL      @DSEQ = PARMSEQ
028800140606    ***
028900140606     C                   MOVE      TSPABCT       PARMKEY
029000140606     C                   MOVE      LYMD          PARMEFFYMD
029100140606     C                   MOVE      BENAMT        PARMBENAMT
029200140606     C                   CLEAR                   PARMGROUP
029300140606     C                   CLEAR                   PARMBILRTE
029400140606     C                   CLEAR                   PARMNETRTE
029500140606     C                   CLEAR                   PARMBILPREM
029600140606     C                   CLEAR                   PARMNETPREM
029700140606     C                   CLEAR                   PARMFOUND
029800140606
029900140606     C                   CALL      'GETRATE'     GRPLIST
030000140606
030100140606    ***
030200140606     C                   EXSR      $RESULT
030300140606    ***
030400140606     C                   ENDIF
030500140606     C                   ENDDO
030600140606    ***
030700140606     C                   ENDIF
030800140606     C                   ENDDO
030900140606    ***
031000140606     C                   ENDSR
031100140606   S***S
031200990816     C*****************************************************
0313009908160073 C* PRINT RENEWAL LETTER AND WRITE HISTORY REC
031400990816     C*****************************************************
0315009908160103 C*                                                                   UTL001
031600990816     C     #LTR          BEGSR
0317009102150103 C*                                                                   UTL001
031800990816     C                   EXSR      #NAME
031900990816     C                   EXSR      #ADR
032000080410      *
032100080410      *  GET COBRA Alternate ID
032200080410      *
032300080410     C     AltKey        Chain     MEMALTL3
032400050408     C*
032500050408     C*  GET COBRA aa name
032600050408     C*
032700050408     c                   eval      aaname = *blanks
032800050408     c     mbtrst        Chain     COBRAAA
032900050408     c                   if        %found(COBRAAA)
033000050408     c     CACODE        chain     AACODE
033100050408     c                   if        %found(AACODE)
033200050408     c     afnam         cat(p)    alnam:1       aaname           30
033300050408     c                   endif
033400050408     c                   endif
033500050408
033600990817     C                   WRITE     LETTER
0337009908170103 C*                                                                   UTL001
0338009908170103 C* WRITE HIST REC TO SHOW EXCLUSION                                  UTL001
0339009908170103 C*                                                                   UTL001
034000990817     C     *INU8         IFEQ      *ON
034100990817     C                   MOVE      'UEI'         TRCODE
034200990817     C                   MOVE      MBSSNO        HKEY
034300990817     C                   MOVE      *ZEROS        TRAMT
034400131003     C                   MOVEl     thispgmname   HPRGNM
034500990817     C                   MOVE      MBTRST        HSTRST
034600990817     C                   MOVE      MBSUB#        HSSUB#
034700990817     C                   MOVE      MBACCT        HSACCT
034800131003     C                   MOVEl     LUSER         HOPER
034900990817     C                   MOVE      'A'           HSDLTD
035000990817     C                   MOVE      LYMD          COVTDT
035100990818     C                   MOVE      *BLANKS       CK#NOT
035200990818     C                   MOVEL     NOT1          CK#NOT
035300131003     C                   eval      sysdateymd = %date
035400131003     C                   MOVE      sysdateymd    trdate
035500131003     c                   eval      hstrtime = %time
035600990817     C                   WRITE     HISTR
035700990817     C                   END
035800990817     C*
035900990816     C                   ENDSR
036000990816     C*
036100990816     C************************************************************
036200990816     C* ROUTINE FOR NAME LINE1 - FIRST MI LAST AND ALL ELIGIBLE  *
036300990816     C*                           DEPENDENTS                     *
036400990816     C************************************************************
036500990816     C*
036600990816     C     #NAME         BEGSR
036700990816     C*
036800990816     C                   MOVE      *BLANKS       N1               59
036900990817     C                   MOVEL     MFNAME        N1
037000990816     C*
037100990817     C     MMI           IFNE      ' '
037200990817     C                   CAT       MMI:1         N1
037300990816     C                   CAT       '.':0         N1
037400990816     C                   END
037500990816     C*
037600990816     C                   CAT       MLNAME:1      N1
037700990816     C                   CAT       AND1:1        N1
037800990816     C                   ENDSR
037900990816     C*
038000990816     C************************************************************
038100990816     C* ROUTINE FOR ADDRESS
038200990816     C************************************************************
038300990816     C*
038400990816     C     #ADR          BEGSR
038500990820     C                   MOVE      *BLANKS       AL               31
038600990820     C                   MOVEL     CITY          AL
038700990817     C                   CAT       ',':0         AL
038800990817     C                   CAT       STATE:1       AL
038900990816     C                   MOVEL     ZIP           ZIP5              5
039000990816     C                   MOVE      ZIP           ZIP4              4
039100990816     C                   CAT       ZIP5:1        AL
039200990816     C     ZIP4          IFNE      '0000'
039300990816     C                   CAT       '-':0         AL
039400990816     C                   CAT       ZIP4:0        AL
039500990816     C                   END
039600050408
039700050408     c* set address for output
039800050408
039900050408     c                   eval      a2 = *blanks
040000050408     c                   eval      a3 = *blanks
040100050408     c                   if        addr2 <> *blanks
040200050408     c                   movel     addr2         a2
040300050408     c                   movel     al            a3
040400050408     c                   else
040500050408     c                   movel     al            a2
040600050408     c                   end
040700050408
040800990816     C                   ENDSR
0409009908170107 C*
0410009908170103 C***************************************************
0411009908170104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0412009908170105 C***************************************************
0413009908170107 C*
0414009908170107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0415009908170107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0416009908170107 C*
0417009908170106 C     #DATYM        BEGSR
041800990817     C                   MOVE      @DATIN        @MD               4 0
041900990817     C                   MOVEL     @DATIN        @Y                4 0
042000990817     C                   MOVEL     @MD           @DATOU            8 0
042100990817     C                   MOVE      @Y            @DATOU
042200990817     C                   MOVE      *ZEROS        @DATIN            8 0
0423009908170120 C                   ENDSR
042400990817     C*
0425009908170103 C***************************************************
0426009908170104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0427009908170105 C***************************************************
0428009908170107 C*
0429009908170107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0430009908170107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0431009908170107 C*
0432009908170106 C     #DATMY        BEGSR
043300990817     C                   MOVEL     @DATIN        @MD               4 0
043400990817     C                   MOVE      @DATIN        @Y                4 0
043500990817     C                   MOVE      @MD           @DATOU            8 0
043600990817     C                   MOVEL     @Y            @DATOU
043700990817     C                   MOVE      *ZEROS        @DATIN            8 0
0438009908170120 C                   ENDSR
043900990817     C*
0440009811120103 C*****************************************************************   UTL001
044100981112     C     *INZSR        BEGSR
044200990818     C                   MOVE      01            ld                2 0
044300990818     C                   MOVEL     lm            lmd               4 0
044400990818     C                   MOVE      01            lmd
044500990818     C                   MOVEl     lmd           lmdy              8 0
044600990818     C                   MOVE      ly            lmdy
044700990818     C                   MOVE      LMDY          @DATIN
044800990817     C                   EXSR      #DATMY
044900990817     C                   MOVE      @DATOU        LYMD              8 0
045000990816     C*
045100990817     C                   MOVE      *DATE         @DATIN
045200990817     C                   EXSR      #DATMY
045300990817     C                   MOVE      @DATOU        UD8YMD            8 0
045400990817     C*
0455009908160323 C* FIRST DATE LINE - UDATE
0456009908160328 C*
0457009908160329 C                   MOVE      *BLANKS       DL               19
0458009908160331 C                   MOVE      *MONTH        M                 2 0
0459009908160331 C                   MOVE      *DAY          D                 2
0460009908160331 C                   MOVE      *YEAR         Y                 4
0461009908160332 C                   MOVEL     YR(M)         DL
046200990816     C                   CAT       D:1           DL
046300990816     C                   CAT       ',':0         DL
046400990816     C                   CAT       Y:1           DL
046500990816     C*
0466009908160323 C* 2ND DATE LINE - EFFDT OF NO RATES
0467009908160328 C*
0468009908160329 C                   MOVE      *BLANKS       DL2              19
0469009908160331 C                   MOVE      LM            M
0470009908160331 C                   MOVE      LD            D
0471009908160331 C                   MOVE      LY            Y
0472009908160332 C                   MOVEL     YR(M)         DL2
047300990816     C                   CAT       D:1           DL2
047400990816     C                   CAT       ',':0         DL2
047500990816     C                   CAT       Y:1           DL2
047600990816     C*
047700990816     C                   MOVE      YR(M)         RENMO             9
047800990816     C*
047900990816     C* 1 MONTH PRIOR TO RENEWAL
048000990816     C*
0481009908160331 C                   MOVE      LM            WM                2 0
048200990816     C                   SUB       1             WM
048300990816     C     WM            IFLT      1
048400990816     C                   MOVE      12            WM
048500990816     C                   END
048600990818     C                   MOVEL     YR(WM)        RENMO2           10
048700990816     C                   CAT       '.':0         RENMO2
048800020325      *---
048900020325      * List trusts selected out of TRSSLC file
049000020325      *---
049100020325     C                   Except    TRSTTI
049200020325     C                   Move      *Off          *InOF
049300020325     C                   Read      TRSSLC
049400020325     C                   Dou       %Eof
049500020325     C                   If        Not %Eof
049600020325     C     Trust_Ctr     Doueq     *Zero
049700020325     C                   Add       1             Trust_Ctr         2 0
049800020325     C                   Select
049900020325     C     Trust_Ctr     Wheneq    1
050000020325     C                   Clear                   Tr1               3 0
050100020325     C                   Clear                   Tr2               3 0
050200020325     C                   Clear                   Tr3               3 0
050300020325     C                   Clear                   Tr4               3 0
050400020325     C                   Clear                   Tr5               3 0
050500020325     C                   Clear                   Tr6               3 0
050600020325     C                   Clear                   Tr7               3 0
050700020325     C                   Clear                   Tr8               3 0
050800020325     C                   Clear                   Tr9               3 0
050900020325     C                   Clear                   Tr10              3 0
051000020325     C                   Clear                   Tr11              3 0
051100020325     C                   Clear                   Tr12              3 0
051200020325     C                   Clear                   Tr13              3 0
051300020325     C                   Clear                   Tr14              3 0
051400020325     C                   Clear                   Tr15              3 0
051500020325     C                   Clear                   Tr16              3 0
051600020325     C                   Clear                   Tr17              3 0
051700020325     C                   Clear                   Tr18              3 0
051800020325     C                   Clear                   Tr19              3 0
051900020325     C                   Clear                   Tr20              3 0
052000020325     C                   Clear                   Tr21              3 0
052100020325     C                   Clear                   Tr22              3 0
052200020325     C                   Clear                   Tr23              3 0
052300020325     C                   Clear                   Tr24              3 0
052400020325     C                   Clear                   Tr25              3 0
052500020325     C                   Clear                   Tr26              3 0
052600020325     C                   Movel     TRTRST        Tr1
052700020325     C     Trust_Ctr     Wheneq    2
052800020325     C                   Move      TRTRST        Tr2
052900020325     C     Trust_Ctr     Wheneq    3
053000020325     C                   Move      TRTRST        Tr3
053100020325     C     Trust_Ctr     Wheneq    4
053200020325     C                   Move      TRTRST        Tr4
053300020325     C     Trust_Ctr     Wheneq    5
053400020325     C                   Move      TRTRST        Tr5
053500020325     C     Trust_Ctr     Wheneq    6
053600020325     C                   Move      TRTRST        Tr6
053700020325     C     Trust_Ctr     Wheneq    7
053800020325     C                   Move      TRTRST        Tr7
053900020325     C     Trust_Ctr     Wheneq    8
054000020325     C                   Move      TRTRST        Tr8
054100020325     C     Trust_Ctr     Wheneq    9
054200020325     C                   Move      TRTRST        Tr9
054300020325     C     Trust_Ctr     Wheneq    10
054400020325     C                   Move      TRTRST        Tr10
054500020325     C     Trust_Ctr     Wheneq    11
054600020325     C                   Move      TRTRST        Tr11
054700020325     C     Trust_Ctr     Wheneq    12
054800020325     C                   Move      TRTRST        Tr12
054900020325     C     Trust_Ctr     Wheneq    13
055000020325     C                   Move      TRTRST        Tr13
055100020325     C     Trust_Ctr     Wheneq    14
055200020325     C                   Move      TRTRST        Tr14
055300020325     C     Trust_Ctr     Wheneq    15
055400020325     C                   Move      TRTRST        Tr15
055500020325     C     Trust_Ctr     Wheneq    16
055600020325     C                   Move      TRTRST        Tr16
055700020325     C     Trust_Ctr     Wheneq    17
055800020325     C                   Move      TRTRST        Tr17
055900020325     C     Trust_Ctr     Wheneq    18
056000020325     C                   Move      TRTRST        Tr18
056100020325     C     Trust_Ctr     Wheneq    19
056200020325     C                   Move      TRTRST        Tr19
056300020325     C     Trust_Ctr     Wheneq    20
056400020325     C                   Move      TRTRST        Tr20
056500020325     C     Trust_Ctr     Wheneq    21
056600020325     C                   Move      TRTRST        Tr21
056700020325     C     Trust_Ctr     Wheneq    22
056800020325     C                   Move      TRTRST        Tr22
056900020325     C     Trust_Ctr     Wheneq    23
057000020325     C                   Move      TRTRST        Tr23
057100020325     C     Trust_Ctr     Wheneq    24
057200020325     C                   Move      TRTRST        Tr24
057300020325     C     Trust_Ctr     Wheneq    25
057400020325     C                   Move      TRTRST        Tr25
057500020325     C     Trust_Ctr     Wheneq    26
057600020325     C                   Move      TRTRST        Tr26
057700020325     C     *InOF         Ifeq      *On
057800020325     C                   Move      *Off          *InOF
057900020325     C                   Except    TRSTTI
058000020325     C                   End
058100020325     C                   Except    TRUSTS
058200020325     C                   Z-add     *Zeros        Trust_Ctr
058300020325     C                   Endsl
058400020325     C                   Read      TRSSLC
058500020325     C                   If        %Eof
058600020325     C                   Z-add     *Zeros        Trust_Ctr
058700020325     C     Trust_Ctr     Ifne      26
058800020325     C     *InOF         Ifeq      *On
058900020325     C                   Move      *Off          *InOF
059000020325     C                   Except    TRSTTI
059100020325     C                   End
059200020325     C                   Except    TRUSTS
059300020325     C                   End
059400020325     C                   End
059500020325     C                   Enddo
059600020325     C                   Else
059700020325     C                   Z-add     *Zeros        Trust_Ctr
059800020325     C                   End
059900020325     C                   Enddo
060000020325     C                   ENDSR
060100000414     C*
0602000203250098 C*
0603000203250098 C*
060400020325    ?C     KLIST         Begsr
060500990812     C     PLNKEY        KLIST
060600990812     C                   KFLD                    MCTRST
060700990812     C                   KFLD                    MCSUB#
060800990812     C                   KFLD                    MCPLAN
060900990812     C     ACCKEY        KLIST
061000990817     C                   KFLD                    MBTRST
061100990817     C                   KFLD                    MBSUB#
061200990817     C                   KFLD                    MBACCT
061300080410
061400080410     C     AltKey        Klist
061500080410     C                   Kfld                    MBSSNO
061600080410     C                   Kfld                    GBSType           4
061700981112     C                   ENDSR
0618009102150104 O******************************************************              DB020
0619009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0620009102150106 O******************************************************              DB020
0621009102150107 O*                                                                   DB020
0622002103260108 Odb171p2   H    1P                     2  3
062300140606     O         OR    OF
0624009102150110 O                       CONAME              87
0625002103260108 O          H    1P                     1
062600140606     O         OR    OF
0627009811120113 O                       *DATE         Y     16
0628009908180114 O                                           55 'COBRA RATE AUDIT FO'
0629009908180114 O                                           56 'R'
0630009908180114 O                       LMDY          Y     67
0631009908180114 O                                           94 ': RENEWAL LETTER GENERATED'
0632009102150115 O                                          120 'PAGE :'
0633009707110116 O                       PAGE          Z    130
0634002103260108 O          H    1P                     1
063500140606     O         OR    OF
0636009908120119 O                                           17 'PROG: DB171 '
0637009102150120 O                                          120 'TIME :'
0638009505090121 O                       TIME               130 '  :  :  '
0639002103260108 O          H    1P                     1
064000140606     O         OR    OF
0641009102150124 O                                           24 '------------------------'
0642009102150125 O                                           48 '------------------------'
0643009102150126 O                                           72 '------------------------'
0644009102150127 O                                           96 '------------------------'
0645009102150128 O                                          120 '------------------------'
0646009102150129 O                                          132 '------------'
0647002103260108 O          H    1P                     1
064800140606     O         OR    OF
0649009707150132 O                                            8 'SS#'
065000140606     O                                           16 'SEQ#'
0651001406060133 O                                           27 'T/S/A'
0652001406060133 O                                           36 'PLAN'
0653001406060134 O                                           47 'AGE BAND'
0654001406060135 O                                           57 'COV TYPE'
065500140606     O                                           97 'ENROLL DATE'
065600140606     O                                          111 'CANCEL DATE'
0657002103260108 O          H    1P                     1
065800140606     O         OR    OF
065900970710     O*
0660001406060141 O                                           24 '------------------------'
0661001406060142 O                                           48 '------------------------'
0662001406060143 O                                           72 '------------------------'
0663001406060144 O                                           96 '------------------------'
0664001406060145 O                                          120 '------------------------'
0665001406060146 O                                          132 '------------'
0666002103260147 O          E            TRSTTI         1
066700020325      *---
066800020325      * Trusts Selected
066900020325      *---
0670000203250110 O                       CONAME              87
0671002103260147 O          E            TRSTTI         1
0672000203250113 O                       *DATE         Y     16
0673000203250114 O                                           55 'COBRA RATE AUDIT FO'
0674000203250114 O                                           56 'R'
0675000203250114 O                       LMDY          Y     67
0676000203250114 O                                           94 ': RENEWAL LETTER GENERATED'
0677002103260147 O          E            TRSTTI         1
0678000203250115 O                                          120 'PAGE :'
0679000203250116 O                       PAGE          Z    130
0680000203250119 O                                           17 'PROG: DB171 '
0681002103260147 O          E            TRSTTI         2
0682000203250120 O                                          120 'TIME :'
0683000203250121 O                       TIME               130 '  :  :  '
0684002103260147 O          E            TRSTTI         1
068500020325     O                                           18 'TRUSTS SELECTED:'
0686002103260147 O          E            TRUSTS         1
068700020325     O                       TR1           Z      5
068800020325     O                       TR2           Z     10
068900020325     O                       TR3           Z     15
069000020325     O                       TR4           Z     20
069100020325     O                       TR5           Z     25
069200020325     O                       TR6           Z     30
069300020325     O                       TR7           Z     35
069400020325     O                       TR8           Z     40
069500020325     O                       TR9           Z     45
069600020325     O                       TR10          Z     50
069700020325     O                       TR11          Z     55
069800020325     O                       TR12          Z     60
069900020325     O                       TR13          Z     65
070000020325     O                       TR14          Z     70
070100020325     O                       TR15          Z     75
070200020325     O                       TR16          Z     80
070300020325     O                       TR17          Z     85
070400020325     O                       TR18          Z     90
070500020325     O                       TR19          Z     95
070600020325     O                       TR20          Z    100
070700020325     O                       TR21          Z    105
070800020325     O                       TR22          Z    110
070900020325     O                       TR21          Z    115
071000020325     O                       TR24          Z    120
071100020325     O                       TR25          Z    125
071200020325     O                       TR26          Z    130
0713002103260147 O          E            ERROR          1
0714009908170149 O                       MBSSNO              12 '0   -  -    '
071500140606     O                       @DSEQ               15
0716001406060150 O                       MCTRST              21
071700140606     O                                           22 '-'
0718001406060150 O                       MCSUB#              25
071900140606     O                                           26 '-'
0720001406060150 O                       ACC#                30
0721001406060151 O                       MCPLAN              36
0722001406060151 O                       MCAGEB              44
0723001406060152 O                       MCOVTP              54
0724001406060032 O                       ENRMDY        Y     97
0725001406060036 O                       CANMDY        Y    111
0726002103260156 O          T    LR                  3
0727009102150157 O                                           29 '*** TOTAL ERRORS:'
0728000606070158 O                       TOTERR        3B    38
072900990816**
073000990816January
073100990816February
073200990816March
073300990816April
073400990816May
073500990816June
073600990816July
073700990816August
073800990816September
073900990816October
074000990816November
074100990816December
