000100140305     H  OPTION(*NODEBUGIO : *SRCSTMT) bnddir('ALLSRVPGMN') actgrp(*caller)
000200130916     h  dftactgrp(*no)
000300010412      *? ***************************************************************
000400010412      * FM060_2R - ACCOUNT MASTER MAINTENANCE second screen
000500010416      *   WRITTEN by Terry Powers  04/01
000600010412      *
000700010417      *? Description: display additional maintanence screen
000800010417
000900160811      *? FIELDS BEGINNING WITH W_ ARE DISPLAY FIELDS
001000020430      *? FIELDS beginning with A2 are ac2mst fields
001100010417      *? FIELDS beginning with A3 are accmst3 fields
001200020220   ***** 02.20.2002 SSK REMOVE USAGE OF ACCMST3
001300021206   ***** 12.06.2002 KSJ ADDED NCA PRODUCT DATE TO SCREEN 1 (STORED IN AC2MST)
001400030429   ***** 03.23.2003 TWP VALIDATE ADDRESSES
001500030429   ***** 04.29.2003 TWP REMOVED THE 'IF NEEDED' MESSAGE FROM ADDR2
001600051115   ** *  11/10/2005 DLK Add invoice heading overrides
001700060201   ** *  01/20/2006 DLK Add invoice heading override effective date so
001800060120   ** *             the Web invoice reprint would not show invoices
001900060120   ** *             prior to this date.
002000060201   ** *  02/01/2006 DLK Add "use cost center" field
002100090401      *  04/01/2009 April Fools.  No, really.  TAX ID is mandatory if
002200090401   ** *             trust category type code indicates Onsite Dental trust.
002300090521      *  05/21/2009 Apparently it WAS an April Fools joke.  Cindy has now
002400090521      *             requested that TAX ID not be mandatory.
002500120423      *  04/20/2012 INVOICE PRINT is added to the Additional Screen using
002600120423      *             the CAFIC field from ACCMST.  P, N and O are valid values.
002700120716      *  07/16/2012 INVOICE PRINT allow also 'B' same as 'O'
002800120718      *             szz, 7/18/12: Make 'B' the default for non SDper Dave A.
002900130213      *  02/13/2013 szz Add "Allow Domestic Partner" file.
003000130917      *  09/16/2013 dpb Add logic for county validation if state is MD
003100140114      *  01/14/2014 dpb Add PA to county validation logic
003200140219   X***X 02.06.2014.SSK.ADD HIST RECORDS FOR ADDRESS CHANGES [INCLUDING COUNTY]
003300140305      *  03/05/2014 dpb Clear county code if all other addr fields blanked
003400140219   X***X
003500160811      *  08/11/2016 B.Rees -Created a Window for the Print Invoice Flag
003600160811      *  Mod ID: BR01      -New Flag for EDT Admin Fee
003700160811      *                    -Created a window for the new EDT Flag.
003800170125      *  Mod ID: BR02  1/25/2016
003900170125      *    Added CT to the ACA County Edit.
004000180109      *  01/09/2018 rlj Add logic for Adv Mbl - check TSCODE for Dental.
004100190226   ** *  02/21/2019 DLK increase size of admin fee description on screen
004200200115      *  01/15/2020 rlj Add logic for CSMi - check TSCODE O D.
004201220127      *  1/27/2022  B.Rees  Converted to PL Screens.
004300140219      *  ***************************************************************
004400010412     FFM060_2D  CF   E             WORKSTN PREFIX(W_)
004500010412     F                                     SFILE(SFL_REC1:SRECNO1)
004600010412     F                                      INDDS(INDICATORS)
004601220127     F                                     HANDLER('PROFOUNDUI(HANDLER)')
004700010416     FACCMST    IF   E           K DISK    PREFIX(A_)
004800020430     FAC2MST    UF A E           K DISK
004900010503     FCODES     IF   E           K DISK    PREFIX(C_)
005000010503     FSUBMST    IF   E           K DISK    PREFIX(S_)
005100010416     FSTATECD   IF   E           K DISK
005200090401     FTRSMST    IF   E           K Disk
005300130213     FACCADP    UF A E           K Disk
005400140219     FHIST      O  A E             DISK
005500160811br01 FCode20P   if   e           k disk
005600160811      *------------------------------------------------------------------------
005700140219   X***X
0058000104120030 D INDICATORS      DS            99
0059000105110019 D F1_PREVIOUS_SC          1      1N   INZ('0')
006000160811br01 D F4_PROMPT               4      4N   INZ('0')
0061000202200SSK*D*F5_COM_NEW********      5      5N   INZ('0')
0062000202200SSK*D*F6_COM_HIST*******      6      6N   INZ('0')
0063000106060019 D F8_COSTCTR              8      8N   INZ('0')
0064000105180019 D F9_RELATE               9      9N   INZ('0')
0065000106050019 D F10_CARRIER            10     10N   INZ('0')
006600010511     D SFLDSP_11              11     11N   INZ('0')
006700010511     D F12_FKEYS              12     12N   INZ('0')
006800010511     D SFLEND_21              21     21N   INZ('0')
006900051110     D f22                    22     22N   INZ('0')
007000010607     D ADD_DSP_MODE           49     49N   INZ('0')
007100010607     D CURSOR2STATE           50     50N   INZ('0')
007200010607     D CURSOR2TERMP           51     51N   INZ('0')
007300010511     D IN52_SELFUNDED         52     52N   INZ('0')
007400010607     D CURSOR2INVCY           53     53N   INZ('0')
007500010607     D CURSOR2FUND            54     54N   INZ('0')
007600010607     D CURSOR2PART            55     55N   INZ('0')
007700010607     D CURSOR2OTHR            56     56N   INZ('0')
007800010607     D CURSOR2RETR            57     57N   INZ('0')
007900010607     D CURSOR2MAX             58     58N   INZ('0')
008000010607     D CURSOR2MAIL2           59     59N   INZ('0')
008100010608     D CURSOR2MED             60     60N   INZ('0')
008200010608     D CURSOR2DEN             61     61N   INZ('0')
008300010608     D CURSOR2LIF             62     62N   INZ('0')
008400021206     D CURSOR2NCAPD           63     63N   INZ('0')
008500060120     D CURSOR2iheff           64     64N   INZ('0')
008600030318     D CURSOR2CITY            65     65N   INZ('0')
008700030318     D CURSOR2STATE2          66     66N   INZ('0')
008800030318     D CURSOR2ZIP             67     67N   INZ('0')
008900030318     D CURSOR2CC              68     68N   INZ('0')
009000030318     D CURSOR2ADDR1           69     69N   INZ('0')
009100060201     D CURSOR2usecc           70     70N   INZ('0')
009200090401     D CURSOR2TAXID           71     71N   Inz('0')
009300120423     D CURSOR2PRTIN           72     72N   Inz('0')
009400130213     D CURSOR2ALWDP           73     73N   Inz('0')
0095000106060019 D CANED_ACT_80           80     80N   INZ('0')
0096001608110019 D Hide_AdminFee          81     81N   INZ('0')
0097001608110019 D Cursor2Admin           82     82N   INZ('0')
009800010412
009900120423     D FetchUpdFlag    S              1    Inz(' ')
010000010412     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
010100010412     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
010200010416     D SCREEN          S              8A                                        CONTROL VARIABLE
010300010503     D GO_BACK         S                   LIKE(SCREEN)                         CONTROL VARIABLE
010400010606     D MAXAGE_CNT      S              1  0 INZ(*ZEROS)
010500010606     D SRECNO1         S              4  0 INZ(*ZEROS)
010600020220SSK**D*A3SEQ#_HLD***   S                   LIKE(A3SEQ#)  INZ(*ZEROS)
010700010419     D ACCT_NBR_E      S             10A                                        CONTROL VARIABLE
010800130916     D wrk_countycode  s                   like(w_countycd)
010900140219    ***
011000140219     D HSADR1          S                   LIKE(W_ADDRESS1)
011100140219     D HSADR2          S                   LIKE(W_ADDRESS2)
011200140219     D HSCITY          S                   LIKE(W_CITY)
011300140219     D HSSTAT          S                   LIKE(W_STATE)
011400140219     D HSZIP5          S                   LIKE(W_ZIP5)
011500140219     D HSZIP4          S                   LIKE(W_ZIP4)
011600140219     D HSCNTY          S                   LIKE(W_COUNTYCD)
011700140219    ***
011800130916     D sv_zip5         s                   like(w_zip5)
011900160811br01 D FKEY1           C                   'ENTER=Update F1=Previous   F4=Promp-
012000160811     D                                     t                          F12=More -
012100010517     D                                     FKEYS'
012200010606     D FKEY2           C                   'ENTER=Update F8=Cost Ctr F9=Related-
012300010606     D                                      Accts   F10=Carrier Id    F12=More -
012400010504     D                                     FKEYS'
012500051110     D invupmsg        C                   'Headings copied: ENTER-update, -
012600051110     D                                     F1-cancel'
012700010502
012800010502     D                 DS
012900010503     D TIMEDATE_DS                   12  0 INZ(*ZEROS)
013000010503     D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
013100010503     D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
013200010412
013300010104     D                 DS
013400010503     D ACCT_NBR                      10  0 INZ(*ZEROS)
013500010412     D  W_TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
013600010412     D  W_SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
013700010412     D  W_ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
013800020220SSK**D**A3TRST******                       OVERLAY(ACCT_NBR)   INZ(*ZEROS)
013900020220SSK**D**A3SUB#******                       OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
014000020220SSK**D**A3ACCT******                       OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
014100010416     D  A2TRST                             OVERLAY(ACCT_NBR)   INZ(*ZEROS)
014200010416     D  A2SUB#                             OVERLAY(ACCT_NBR:4) INZ(*ZEROS)
014300010416     D  A2ACCT                             OVERLAY(ACCT_NBR:7) INZ(*ZEROS)
014400010412
014500010412     D                 DS
014600010606     D C_CODE
014700010503     D  W_CODE                             OVERLAY(C_CODE)
014800010503
014900010503     D                 DS
015000010606     D C_LDESCR
015100010503     D  W_LDESCR                           OVERLAY(C_LDESCR)
015200010503
015300010503     D                 DS
015400010606     D A_ACNAM1
015500010503     D  W_ACCT_NAME                        OVERLAY(A_ACNAM1)
015600010412
015700010412     D                 DS
015800010606     D S_SUBNAM
015900010416     D  W_SUB#_NAME                        OVERLAY(S_SUBNAM)
016000010417
016100010503     D                 DS
016200010606     D A2USER
016300020220SSK**D**A3USER******                       OVERLAY(A2USER)
016400010503     D  W_USER                             OVERLAY(A2USER)
016500010503
016600020220SSK**D**************   DS
016700020220SSK**D*A2TIME*******
016800020220SSK**D**A3TIME******                       OVERLAY(A2TIME) INZ(*ZEROS)
016900020220
017000020220SSK**D*****************DS
017100020220SSK**D*A2DATE*******
017200020220SSK**D**A3DATE******                       OVERLAY(A2DATE) INZ(*ZEROS)
017300010608
017400010608     D                 DS
017500010608     D MONTH_DAY80                    8  0
017600010608     D  YEAR2001                      4  0 OVERLAY(MONTH_DAY80) INZ(2001)
017700010608     D  MONTH_DAY                     4  0 OVERLAY(MONTH_DAY80:5)
017800010503
017900010417     D                 DS
018000010417     D COMPANY                       50
018100010419     D W_CONAME                            OVERLAY(COMPANY:2)
018200010419     D APPLICATION                    2    OVERLAY(COMPANY:45)
018300010412
018400060120     D ihover          DS
018500060120     D w_a2ih1t
018600060120     D w_a2ih2t
018700060120     D w_a2ih3t
018800060120     D w_a2ih4t
018900060120     D w_a2ih5t
019000060120     D w_a2ih6t
019100060120     D w_a2ih7t
019200060120     D w_a2ih8t
019300060120     D w_a2ih9t
019400060120     D w_a2ih1b
019500060120     D w_a2ih2b
019600060120     D w_a2ih3b
019700060120     D w_a2ih4b
019800060120     D w_a2ih5b
019900060120     D w_a2ih6b
020000060120     D w_a2ih7b
020100060120     D w_a2ih8b
020200060120     D w_a2ih9b
020300130916
020400130916      /define copy_all_protos_and_fields
020500131004      /copy qcpysrc,zipsrvpgmp
020600130916      /undefine copy_all_protos_and_fields
020700130916
020800010412      *? LOCAL DATA AREA
020900000102     D                UDS
021000140219     D  USER_DS              100    109A
021100140219   X***X
0212001402190037 D sysdateymd      S               d   datfmt(*iso)
021300160811     D
021400160811br01 D CodeKey         s             10a   inz
021500160811br01 D CodeSearch      s             20a   inz
021600160811br01 D oType           s             10a   inz
021700160811br01 D oDescr          s             20a   inz
021800190226br01 D oDescr3r        s             50a   inz
021900160811br01 D cancel          s              1a   inz
022000160811br01 D SkipReload      s              1a   inz
022100160811      *------------------------------------------------------------------------
022200140219   X***X
022300010416     C                   DOU       SCREEN = 'EXIT    '
022400010416     C     SCREEN        CASEQ     'SCRN1   '    SCRN1_SR
022500010606     C     SCREEN        CASEQ     'SCRN2   '    SCRN2_SR
022600020220 SSK*C*****SCREEN********CASEQ     'COM_NEW '    COM_NEW_SR
022700020220 SSK*C*****SCREEN********CASEQ     'COM_HIST'    COM_HIST_SR
022800010606     C     SCREEN        CASEQ     'COSTCTR '    COSTCTR_SR
022900010518     C     SCREEN        CASEQ     'RELATE  '    RELATE_SR
023000010605     C     SCREEN        CASEQ     'CARRIER '    CARRIER_SR
023100010712     C     SCREEN        CASEQ     'VALID1  '    VALID1_SR
023200010712     C     SCREEN        CASEQ     'VALID2  '    VALID2_SR
023300010606     C     SCREEN        CASEQ     'MAINT   '    MAINT_SR
023400120423     C                   ENDCS
023500000102     C                   ENDDO
023600010412
023700010412     C                   EXSR      END_JOB_SR
023800010412
023900010412      *? ***************************************************************
024000010412     C     SCRN1_SR      BEGSR
024100010416
024200010416     C                   IF        W_ERROR_MSG = *BLANKS
024300160811br01 c                             and  SkipReload <> 'Y'
024400160811
024500051118      * subdivision headings (for display only)
024600051118     C                   EVAL      w_ih1t   = s_ih1t
024700051118     C                   EVAL      w_ih2t   = s_ih2t
024800051118     C                   EVAL      w_ih3t   = s_ih3t
024900051118     C                   EVAL      w_ih4t   = s_ih4t
025000051118     C                   EVAL      w_ih5t   = s_ih5t
025100051118     C                   EVAL      w_ih6t   = s_ih6t
025200051118     C                   EVAL      w_ih7t   = s_ih7t
025300051118     C                   EVAL      w_ih8t   = s_ih8t
025400051118     C                   EVAL      w_ih9t   = s_ih9t
025500051118     C                   EVAL      w_ih1b   = s_ih1b
025600051118     C                   EVAL      w_ih2b   = s_ih2b
025700051118     C                   EVAL      w_ih3b   = s_ih3b
025800051118     C                   EVAL      w_ih4b   = s_ih4b
025900051118     C                   EVAL      w_ih5b   = s_ih5b
026000051118     C                   EVAL      w_ih6b   = s_ih6b
026100051118     C                   EVAL      w_ih7b   = s_ih7b
026200051118     C                   EVAL      w_ih8b   = s_ih8b
026300051118     C                   EVAL      w_ih9b   = s_ih9b
026400120423      *---
026500120423      * PRINT INVOICE (CAFIC) field processes via FM060_2CA
026600120423      *---
026700120423     C                   If        FetchUpdFlag <> 'E'
026800120425     C     W_TRST        Chain     TRSMST
026900120425     C                   If        %Found(TRSMST)
027000200115     C                   If        TSCODE = 'O N' or TSCODE = 'O M' or
027100200115     C                             TSCODE = 'O D'
027200120718     C                   Eval      W_CAFIC      = 'O'
027300120425     C                   End
027400120425     C                   End
027500120424     C****************** Clear                   W_CAFIC           1
027600120423     C                   Eval      FetchUpdFlag = 'F'                           F=Fetch (Read)
027700120423     C                   Call      'FM060_2CA'
027800120423     C                   Parm                    W_TRST
027900120423     C                   Parm                    W_SUB#
028000120423     C                   Parm                    W_ACCT
028100120423     C                   Parm                    W_CAFIC
028200120423     C                   Parm                    FetchUpdFlag
028300120423     C                   End
028400051118
028500160811br01 C*?Get the Print Invoice Decription
028600160811 |            CodeKey = 'PRTINVCDE';
028700160811 |            CodeSearch = w_cafic ;
028800160811 |            w_s2PrtDesc = *Blanks;
028900160811 |
029000160811 |            Chain (CodeKey : CodeSearch) Code20p;
029100160811 |            if %Found(Code20P);
029200160811 |               w_s2PrtDesc = c20lDesc;
029300160811 |            endif;
029400160811 |
029500160811 |
029600160811 |
029700160811br01 C
029800160811
029900010416     C     ACCMST2_KEY   CHAIN     ACCMSR2
030000020430     C                   IF        %FOUND(AC2MST)
030100010606     C                   EVAL      W_TAX_ID#  = A2TAX_ID#
030200010416     C                   EVAL      W_ADDRESS1 = A2ADDRESS1
030300010416     C                   EVAL      W_ADDRESS2 = A2ADDRESS2
030400010416     C                   EVAL      W_CITY     = A2CITY
030500010416     C                   EVAL      W_STATE    = A2STATE
030600010416     C                   EVAL      W_ZIP5     = A2ZIP5
030700010416     C                   EVAL      W_ZIP4     = A2ZIP4
030800010606     C                   EVAL      W_COUNTYCD = A2COUNTYCD
030900130916     C                   eval      sv_zip5 = w_zip5
031000140219    ***
031100140219    *** B4 IMAGE FOR HIST RECORDS
031200140219     C                   EVAL      HSADR1 = A2ADDRESS1
031300140219     C                   EVAL      HSADR2 = A2ADDRESS2
031400140219     C                   EVAL      HSCITY = A2CITY
031500140219     C                   EVAL      HSSTAT = A2STATE
031600140219     C                   EVAL      HSZIP5 = A2ZIP5
031700140219     C                   EVAL      HSZIP4 = A2ZIP4
031800140219     C                   EVAL      HSCNTY = A2COUNTYCD
031900140219    ***
032000051110      * invoice heading override
032100051110     C                   EVAL      w_a2ih1t   = a2ih1t
032200051110     C                   EVAL      w_a2ih2t   = a2ih2t
032300051110     C                   EVAL      w_a2ih3t   = a2ih3t
032400051110     C                   EVAL      w_a2ih4t   = a2ih4t
032500051110     C                   EVAL      w_a2ih5t   = a2ih5t
032600051110     C                   EVAL      w_a2ih6t   = a2ih6t
032700051110     C                   EVAL      w_a2ih7t   = a2ih7t
032800051110     C                   EVAL      w_a2ih8t   = a2ih8t
032900051110     C                   EVAL      w_a2ih9t   = a2ih9t
033000051110     C                   EVAL      w_a2ih1b   = a2ih1b
033100051110     C                   EVAL      w_a2ih2b   = a2ih2b
033200051110     C                   EVAL      w_a2ih3b   = a2ih3b
033300051110     C                   EVAL      w_a2ih4b   = a2ih4b
033400051110     C                   EVAL      w_a2ih5b   = a2ih5b
033500051110     C                   EVAL      w_a2ih6b   = a2ih6b
033600051110     C                   EVAL      w_a2ih7b   = a2ih7b
033700051110     C                   EVAL      w_a2ih8b   = a2ih8b
033800051110     C                   EVAL      w_a2ih9b   = a2ih9b
033900051110
034000010416     C                   EVAL      W_PARTTIME = A2PARTTIME
034100010416     C                   EVAL      W_RETIREES = A2RETIREES
034200010606     C                   EVAL      W_OTHERINS = A2OTHERINS
034300010606     C                   EVAL      W_TERMPOLC = A2TERMPOLC
034400051110     C**                 EVAL      W_COBRAFEE = A2COBRAFEE
034500010606     C                   EVAL      W_EMAIL1 = A2EMAIL1
034600010606     C                   EVAL      W_EMAIL2 = A2EMAIL2
034700010503     C                   EVAL      W_INSCYCLE = A2INSCYCLE
034800060201     C                   EVAL      W_usecc    = A2usecc
034900051110     C**                 EVAL      W_FUNDED   = A2FUNDED
035000010606     C                   EVAL      W_RENEWMED = A2RENEWMED
035100010606     C                   EVAL      W_RENEWDEN = A2RENEWDEN
035200010606     C                   EVAL      W_RENEWLIF = A2RENEWLIF
035300010606     C                   EVAL      W_MAXAGE1  = A2MAXAGE1
035400010606     C                   EVAL      W_MAXAGE2  = A2MAXAGE2
035500010606     C                   EVAL      W_MAXAGE3  = A2MAXAGE3
035600010606     C                   EVAL      W_MAXAGE4  = A2MAXAGE4
035700010606     C                   EVAL      W_MAXAGE5  = A2MAXAGE5
035800010606     C                   EVAL      W_MAXAGE6  = A2MAXAGE6
035900120426     C                   Eval      W_MAXAGM26 = A2MAXAGM26
036000120426     C                   Eval      W_MAXAGY26 = A2MAXAGY26
036100120426     C                   Eval      W_MAXAGEOT = A2MAXAGEOT
036200010606     C                   EVAL      W_MAIL_TO  = A2MAIL_TO
036300010606     C                   EVAL      W_RENWDAYM = A2RENWDAYM
036400010606     C                   EVAL      W_RENWDAYD = A2RENWDAYD
036500010606     C                   EVAL      W_RENWDAYL = A2RENWDAYL
036600021204     C                   IF        A2NCAPDT <> *ZEROS
036700021204     C                   MOVE      A2NCAPDT      ISO_DATE
036800021204     C                   MOVE      ISO_DATE      USA_DATE
036900021205     C                   MOVE      USA_DATE      W_NCAPRDT
037000021204    1C                   ENDIF
037100060120
037200060120      * invoice head effdt
037300060120     C                   IF        A2iheff <> *ZEROS
037400060120     C                   MOVE      A2iheff       ISO_DATE
037500060120     C                   MOVE      ISO_DATE      USA_DATE
037600060120     C                   MOVE      USA_DATE      W_iheff
037700060120    1C                   ENDIF
037800060120
037900010503     C                   IF        A2USER = *BLANKS
038000010503     C                   EVAL      W_USER = USER_DS
038100010503     C                   ELSE
038200010503     C                   EVAL      W_USER     = A2USER
038300010503     C                   END
038400010518     C                   END
038500010416     C                   END
038600010518     C                   TIME                    TIMEDATE_DS
038700010518     C     *MDY          MOVE      DATE_DS       USA_DATE
038800020220     C                   MOVE      USA_DATE      W_XDATE
038900020220     C                   EVAL      W_XTIME = TIME_DS
039000030429     C*                  IF        W_ADDRESS2 = *BLANKS
039100030429     C*                  EVAL      W_ADDRESS2 = '(IF NEEDED)'
039200030429     C*                  END
039300010416
039400010412     C                   EXFMT     SCRN1
039500010412
039600010416      *? END PGM *******************************************************
039700010502     C                   IF        F1_PREVIOUS_SC = *ON
039800010412     C                   EVAL      SCREEN = 'EXIT '
039900010103     C                   LEAVESR
040000010412     C                   END
040100010416
040200160811 |   C                   eval      CURSOR2PRTIN = *off
040300160811 |   C                   eval      Cursor2Admin = *off
040400160811BR01 C                   eval      SkipReload = *Blanks
040500160811 |   C                   IF        F4_PROMPT = *ON
040600160811 |   C
040700160811 |   C**?Print Invoice
040800160811 |   C                   if        W_FLD1 = 'CAFIC'
040900160811 |   C                   call      'WN0002R'
041000160811 |   C                   parm                    oType
041100160811 |   C                   parm                    oDescr
041200160811 |   C                   parm                    cancel
041300160811 |   C
041400160811 |   C                   if        Cancel = ''
041500160811 |   C                   eval      w_cafic = oType
041600160811 |   C                   eval      w_s2prtDesc = oDescr
041700160811 |   C                   eval      SkipReload = 'Y'
041800160811 |   C                   endif
041900160811 |   C                   eval      CURSOR2PRTIN = *on
042000160811 |   C                   endif
042100160811 |   C
042200160811 |   C
042300160811 |   C**?Admin Fee
042400160811 |   C                   if        W_FLD1 = 'OLDT06'
042500160811 |   C                   call      'WN0003R'
042600160811 |   C                   parm                    oType
042700190226 |   C                   parm                    oDescr3r
042800160811 |   C                   parm                    cancel
042900160811 |   C
043000160811 |   C                   if        Cancel = ''
043100160811 |   C                   eval      w_oldt06 = oType
043200190226 |   C                   eval      w_s2AdmDesc = oDescr3r
043300160811 |   C                   eval      SkipReload = 'Y'
043400160811 |   C                   endif
043500160811 |   C                   eval      Cursor2Admin = *on
043600160811 |   C
043700160811 |   C                   endif
043800160811 |   C
043900160811 |   C                   LEAVESR
044000160811BR01 C                   END
044100160811
044200020220 SSK*****DISPLAY*COMMENTS SCREEN              **************************
044300020220 SSK*C*******************IF        F5_COM_NEW  = *ON
044400020220 SSK*C*******************EVAL      SCREEN = 'COM_NEW '
044500020220 SSK*C*******************LEAVESR
044600020220 SSK*C*******************END
044700020220 SSK*****DISPLAY*COMMENT*HIST SCREEN          **************************
044800020220 SSK*C*******************IF        F6_COM_HIST = *ON
044900020220 SSK*C*******************EVAL      SCREEN = 'COM_HIST'
045000020220 SSK*C*******************LEAVESR
045100020220 SSK*C*******************END
045200010504
045300010606      *? COST CTR SCREEN                      **************************
045400010606     C                   IF        F8_COSTCTR  = *ON
045500010606     C                   EVAL      SCREEN = 'COSTCTR '
045600010504     C                   EVAL      GO_BACK = 'SCRN1   '
045700010504     C                   LEAVESR
045800010504     C                   END
045900010504
046000010518      *? RELATE SCREEN                        **************************
046100010518     C                   IF        F9_RELATE   = *ON
046200010518     C                   EVAL      SCREEN = 'RELATE  '
046300010504     C                   EVAL      GO_BACK = 'SCRN1   '
046400010504     C                   LEAVESR
046500010504     C                   END
046600010605
046700010605      *?CARRIER SCREEN                        **************************
046800010605     C                   IF        F10_CARRIER = *ON
046900010605     C                   EVAL      SCREEN = 'CARRIER '
047000010605     C                   EVAL      GO_BACK = 'SCRN1   '
047100010605     C                   LEAVESR
047200010605     C                   END
047300010504
047400010504      *? MORE FKEYS                           **************************
047500010504     C                   IF        F12_FKEYS   = *ON
047600010504     C                   IF        W_FKEY_LINE = FKEY1
047700010504     C                   EVAL      W_FKEY_LINE =  FKEY2
047800010504     C                   ELSE
047900010504     C                   EVAL      W_FKEY_LINE =  FKEY1
048000010504     C                   END
048100010504     C                   EVAL      GO_BACK = 'SCRN1   '
048200010504     C                   LEAVESR
048300010504     C                   END
048400051110
048500010606     C                   EVAL      SCREEN = 'VALID1'
048600010606     C                   ENDSR
048700010606
048800010606      *? ***************************************************************
048900010606     C     SCRN2_SR      BEGSR
049000010606
049100130226     C     ACCMST_KEY    Chain     ACCADP
049200130226     C                   If        %Found(ACCADP)
049300130226     C                   Eval      W_ALWDP  =  ADADFL
049400130226     C                   Else
049500130226     C                   Eval      W_ALWDP  =  *Blanks
049600130226     C                   End
049700130226     C                   EXFMT     SCRN2
049800130226
049900010606      *? END PGM *******************************************************
050000010606     C                   IF        F1_PREVIOUS_SC = *ON
050100010606     C                   EVAL      SCREEN = 'SCRN1'
050200010606     C                   LEAVESR
050300010606     C                   END
050400010606
050500020220 SSK*****DISPLAY*COMMENTS SCREEN              **************************
050600020220 SSK*C*******************IF        F5_COM_NEW  = *ON
050700020220 SSK*C*******************EVAL      SCREEN = 'COM_NEW '
050800020220 SSK*C*******************LEAVESR
050900020220 SSK*C*******************END
051000020220 SSK*****DISPLAY*COMMENT*HIST SCREEN          **************************
051100020220 SSK*C*******************IF        F6_COM_HIST = *ON
051200020220 SSK*C*******************EVAL      SCREEN = 'COM_HIST'
051300020220 SSK*C*******************LEAVESR
051400020220 SSK*C*******************END
051500010606
051600010606      *? COST CTR SCREEN                      **************************
051700010606     C                   IF        F8_COSTCTR  = *ON
051800010606     C                   EVAL      SCREEN = 'COSTCTR '
051900010606     C                   EVAL      GO_BACK = 'SCRN2   '
052000010606     C                   LEAVESR
052100010606     C                   END
052200010606
052300010606      *? RELATE SCREEN                        **************************
052400010606     C                   IF        F9_RELATE   = *ON
052500010606     C                   EVAL      SCREEN = 'RELATE  '
052600010606     C                   EVAL      GO_BACK = 'SCRN2   '
052700010606     C                   LEAVESR
052800010606     C                   END
052900010606
053000010606      *?CARRIER SCREEN                        **************************
053100010606     C                   IF        F10_CARRIER = *ON
053200010606     C                   EVAL      SCREEN = 'CARRIER '
053300010606     C                   EVAL      GO_BACK = 'SCRN2   '
053400010606     C                   LEAVESR
053500010606     C                   END
053600010606
053700010606      *? MORE FKEYS                           **************************
053800010606     C                   IF        F12_FKEYS   = *ON
053900010606     C                   IF        W_FKEY_LINE = FKEY1
054000010606     C                   EVAL      W_FKEY_LINE =  FKEY2
054100010606     C                   ELSE
054200010606     C                   EVAL      W_FKEY_LINE =  FKEY1
054300010606     C                   END
054400010606     C                   EVAL      GO_BACK = 'SCRN2   '
054500010606     C                   LEAVESR
054600010606     C                   END
054700010606
054800010606     C                   EVAL      SCREEN = 'VALID2  '
054900010606     C                   ENDSR
055000010606      *? ***************************************************************
055100010606     C     VALID1_SR     BEGSR
055200010606      *? VALIDATIONS                          **************************
055300010606     C                   EVAL      W_ERROR_MSG = *BLANKS
055400120423      ****
055500021206     C                   RESET                   CURSOR2NCAPD
055600021206     C                   IF        W_NCAPRDT <> *ZEROS
055700021206     C     *USA          TEST(DE)                W_NCAPRDT
055800021206    1C                   IF        %ERROR
055900021206     C                   EVAL      W_ERROR_MSG = 'INVALID DATE'
056000021206     C                   EVAL      CURSOR2NCAPD = *ON
056100021206     C                   EVAL      SCREEN = 'SCRN1   '
056200021206     C                   LEAVESR
056300021206     C                   END
056400021206     C                   ENDIF
056500051110
056600060201      * validate use cost center
056700060201     C                   RESET                   CURSOR2usecc
056800060201     C                   IF        W_usecc <> 'Y' and w_usecc <> ' '
056900060201     C                   EVAL      W_ERROR_MSG = 'PLEASE CHOOSE Y OR BLANK +
057000060201     C                             FOR COST CENTER'
057100060201     C                   EVAL      CURSOR2usecc = *ON
057200060201     C                   EVAL      SCREEN = 'SCRN1   '
057300060201     C                   LEAVESR
057400060201     C                   END
057500060201
057600060120      * invoice head effdt
057700060120     C                   RESET                   CURSOR2iheff
057800060120     C                   IF        W_iheff <> *ZEROS
057900060120     C     *USA          TEST(DE)                W_iheff
058000060120    1C                   IF        %ERROR
058100060120     C                   EVAL      W_ERROR_MSG = 'INVALID OVERRIDE BEGIN DATE'
058200060120     C                   EVAL      CURSOR2iheff = *ON
058300060120     C                   EVAL      SCREEN = 'SCRN1   '
058400060120     C                   LEAVESR
058500060120     C                   END
058600060120     C                   ENDIF
058700060120
058800060120      * if heading overrides are entered, effdt must also be entered
058900060120     C                   IF        ihover <> *blanks and w_iheff = *ZEROS
059000060120     C                   EVAL      W_ERROR_MSG = 'PLEASE ENTER HEADING +
059100060120     c                             OVERRIDE DATE'
059200060120     C                   EVAL      CURSOR2iheff = *ON
059300060120     C                   EVAL      SCREEN = 'SCRN1   '
059400060120     C                   LEAVESR
059500060120     C                   END
059600060120
059700060120
059800060120      * if heading overrides are blank, effdt must also be blank
059900060120     C                   IF        ihover = *blanks and w_iheff <> *ZEROS
060000060120     C                   EVAL      W_ERROR_MSG = 'PLEASE CLEAR HEADING +
060100060120     c                             OVERRIDE DATE'
060200060120     C                   EVAL      CURSOR2iheff = *ON
060300060120     C                   EVAL      SCREEN = 'SCRN1   '
060400060120     C                   LEAVESR
060500060120     C                   END
060600060120
060700030429     C*                  IF        W_ADDRESS2 = '(IF NEEDED)'
060800030429     C*                  EVAL      W_ADDRESS2 = *BLANKS
060900030429     C*                  END
061000030318     C                   IF        W_ADDRESS1 = *BLANKS AND
061100030318    1C                             W_CITY     = *BLANKS AND
061200030318    1C                             W_STATE    = *BLANKS AND
061300030318    1C                             W_ZIP5     = *ZEROS
061400140305     C                   clear                   w_countycd
061500030318     C                   ELSE
061600030318     C                   RESET                   CURSOR2ADDR1
061700051110
061800030318    1C                   IF        W_ADDRESS1 = *BLANKS
061900030318     C                   EVAL      W_ERROR_MSG = 'MUST ENTER ADDRESS'
062000030318     C                   EVAL      CURSOR2ADDR1 = *ON
062100030318     C                   EVAL      SCREEN = 'SCRN1   '
062200030318     C                   LEAVESR
062300030318     C                   END
062400051110
062500030318     C                   RESET                   CURSOR2CITY
062600051110
062700030318    1C                   IF        W_CITY     = *BLANKS
062800030318     C                   EVAL      W_ERROR_MSG = 'MUST ENTER CITY   '
062900030318     C                   EVAL      CURSOR2CITY  = *ON
063000030318     C                   EVAL      SCREEN = 'SCRN1   '
063100030318     C                   LEAVESR
063200030318     C                   END
063300051110
063400130916     C                   RESET                   CURSOR2STATE2
063500030318    1C                   IF        W_STATE    = *BLANKS
063600030318     C                   EVAL      W_ERROR_MSG = 'MUST ENTER STATE  '
063700030318     C                   EVAL      CURSOR2STATE2 = *ON
063800030318     C                   EVAL      SCREEN = 'SCRN1   '
063900030318     C                   LEAVESR
064000030318     C                   END
064100051110
064200030318     C                   RESET                   CURSOR2ZIP
064300030318    1C                   IF        W_ZIP5     = *ZEROS
064400030318     C                   EVAL      W_ERROR_MSG = 'MUST ENTER ZIP    '
064500030318     C                   EVAL      CURSOR2ZIP   = *ON
064600030318     C                   EVAL      SCREEN = 'SCRN1   '
064700030318     C                   LEAVESR
064800130917     C                   else
064900180109      *   Changed to look at TSCODE
065000200115     C                   if        (TSCODE <> 'O N' and TSCODE <> 'O M' and
065100200115     C                             TSCODE <> 'O D') and
065200131010     C                             (#valid_zip(w_zip5:w_state) = 'N')
065300130917     C                   EVAL      W_ERROR_MSG = 'INVALID ZIP'
065400130917     C                   EVAL      CURSOR2ZIP   = *ON
065500130917     C                   EVAL      SCREEN = 'SCRN1   '
065600130917     C                   LEAVESR
065700130917     C                   endif
065800030318     C                   END
065900051110
066000030318     C                   RESET                   CURSOR2CC
066100130917
066200170125     C                   if        (w_state = 'MD' or
066300170125     C                              w_state = 'PA' or
066400170125br02 C                              w_state = 'CT') and
066500180109      * Chg'd to look for TSCODE
066600200115     C                             (TSCODE <> 'O N' and TSCODE <> 'O M' and
066700200115     C                             TSCODE <> 'O D')
066800130917     C                   exsr      edit_county
066900131015     C                   elseif    w_countycd <> *blanks
067000131015     C                   clear                   w_countycd
067100130917     C                   endif
067200051110
067300030318     C                   END
067400090401
067500120423      *---
067600120423      * PRINT INVOICE (CAFIC) is from ACCMST and processed via FM060_2CA
067700120423      *---
067800120423     C                   RESET                   CURSOR2PRTIN
067900120423
068000120423     C     W_TRST        Chain     TRSMST
068100120423     C                   If        %Found(TRSMST)
068200200115     C                   If        TSCODE <> 'O N' and TSCODE <> 'O M' and
068300200115     C                             TSCODE <> 'O D'
068400120425     C                   If        W_CAFIC <> 'P' and
068500120425     C                             W_CAFIC <> 'N' and
068600120716     C                             W_CAFIC <> 'O' and
068700120716     C                             W_CAFIC <> 'B'
068800120423     C                   Eval      W_ERROR_MSG = 'INVOICE PRINT FLAG NOT VALID'
068900160811     C                   eval      w_s2PrtDesc = *Blanks
069000120423     C                   Eval      CURSOR2PRTIN = *ON
069100120423     C                   Eval      SCREEN = 'SCRN1   '
069200120423     C                   LeaveSr
069300120423     C                   End
069400120423     C                   End
069500120423     C                   End
069600120423
069700160811br01 C* Get the print description
069800160811 |
069900160811 |            CodeKey = 'PRTINVCDE';
070000160811 |            CodeSearch = w_cafic ;
070100160811 |            w_s2PrtDesc = *Blanks;
070200160811 |
070300160811 |            Chain (CodeKey : CodeSearch) Code20p;
070400160811 |            if %Found(Code20P);
070500160811 |               w_s2PrtDesc = c20lDesc;
070600160811 |            endif;
070700160811 |
070800160811br01 C
070900160811     C
071000160811br01 C*?Check the Admin Fee Value
071100160811 |
071200160811 |            CodeKey = 'ADMINFEE';
071300160811 |            CodeSearch = w_oldt06;
071400160811 |            w_s2AdmDesc = *Blanks;
071500160811 |
071600160811 |            if w_oldt06 > *Blanks;
071700160811 |
071800160811 |               Chain (CodeKey : CodeSearch) Code20p;
071900160811 |               if not %Found(Code20P);
072000160811 |                  w_s2AdmDesc = *Blanks;
072100160811 |                  w_Error_Msg = 'Admin Fee Code is not valid.';
072200160811 |                  Screen = 'Scrn1';
072300160811 |               else;
072400160811 |                  w_s2AdmDesc = c20lDesc;
072500160811 |               endif;
072600160811 |
072700160811 |            endif;
072800160811 |
072900160811 |
073000160811br01
073100160811     C
073200090401     C                   RESET                   CURSOR2TAXID
073300090521     C***                If        W_TAX_ID#  = *Zeros
073400090521     C***  W_TRST        Chain     TRSMST
073500090521     C***                If        %Found(TRSMST)
073600090521     C***                If        TSCODE     = 'O N'
073700090521     C***                EVAL      W_ERROR_MSG =
073800090521     C***                            'TAX ID REQUIRED FOR ONSITE DENTAL TRUST'
073900090521     C***                EVAL      CURSOR2TAXID = *ON
074000090521     C***                EVAL      SCREEN = 'SCRN1   '
074100090521     C***                LEAVESR
074200090521     C***                End
074300090521     C***                End
074400090521     C***                End
074500090401
074600021206     C****
074700090401     C                   GOTO      SKIP1
074800051110
074900051110
075000010606     C                   RESET                   CURSOR2STATE
075100010607     C                   RESET                   CURSOR2TERMP
075200010607     C                   RESET                   CURSOR2INVCY
075300010607     C                   RESET                   CURSOR2FUND
075400010606     C     W_STATE       SETLL     STATEF
075500010606     C                   IF        NOT %EQUAL(STATECD)
075600010606     C                   EVAL      W_ERROR_MSG = 'INVALID STATE'
075700010606     C                   EVAL      CURSOR2STATE = *ON
075800010606     C                   EVAL      SCREEN = 'SCRN1   '
075900010606     C                   LEAVESR
076000010606     C                   END
076100130916
076200130916
076300010607     C                   IF        W_TERMPOLC = 'F' OR
076400010607     C                             W_TERMPOLC = 'A' OR
076500010607     C                             W_TERMPOLC = 'E'
076600010607     C                   ELSE
076700010607     C                   EVAL      W_ERROR_MSG = 'INVALID TERMINATION POLICY'
076800010607     C                   EVAL      CURSOR2TERMP = *ON
076900010607     C                   EVAL      SCREEN = 'SCRN1   '
077000010607     C                   LEAVESR
077100010607     C                   END
077200090401
077300090521     C***                If        W_TAX_ID#  = *Zeros
077400090521     C***  W_TRST        Chain     TRSMST
077500090521     C***                If        %Found(TRSMST)
077600090521     C***                If        TSCODE     = 'N'
077700090521     C***                EVAL      W_ERROR_MSG =
077800090521     C***                            'TAX ID REQUIRED FOR ONSITE DENTAL TRUST'
077900090521     C***                EVAL      CURSOR2TAXID = *ON
078000090521     C***                EVAL      SCREEN = 'SCRN1   '
078100090521     C***                LEAVESR
078200090521     C***                End
078300090521     C***                End
078400090521     C***                End
078500051110
078600010607     C                   IF        W_INSCYCLE = 'F' OR
078700010607     C                             W_INSCYCLE = 'S'
078800010607     C                   ELSE
078900010607     C                   EVAL      W_ERROR_MSG = 'INVALID INVOICING CYCLE'
079000010607     C                   EVAL      CURSOR2INVCY = *ON
079100010607     C                   EVAL      SCREEN = 'SCRN1   '
079200010607     C                   LEAVESR
079300010607     C                   END
079400060201
079500051110     C*                  IF        IN52_SELFUNDED = *ON
079600051110     C*                  IF        W_FUNDED   = 'C' OR
079700051110     C*                            W_FUNDED   = 'W' OR
079800051110     C*                            W_FUNDED   = 'R'
079900051110     C*                  ELSE
080000051110     C*                  EVAL      W_ERROR_MSG = 'INVALID FUNDING'
080100051110     C*                  EVAL      CURSOR2FUND  = *ON
080200051110     C*                  EVAL      SCREEN = 'SCRN1   '
080300051110     C*                  LEAVESR
080400051110     C*                  END
080500051110     C*                  END
080600010606
080700010712     C     SKIP1         TAG
080800051110
080900051110      * if all edits are okay and user pressed f22 - copy submaster
081000051110      * headings to ac2mst headings
081100051110
081200051110     C                   IF        W_ERROR_MSG = *BLANKS and f22 = *on
081300051110     c                   exsr      #copyhead
081400051110     C                   EVAL      SCREEN = 'SCRN1 '
081500051110     C                   EVAL      w_error_msg = invupmsg
081600051110     C                   LEAVESR
081700051110     c                   end
081800051110
081900010712      *? TEMP DO NOT EDIT **********************************************
082000010606     C                   IF        W_ERROR_MSG = *BLANKS
082100010606     C                   EVAL      SCREEN = 'SCRN2 '
082200010606     C                   ELSE
082300010606     C                   EVAL      SCREEN = 'SCRN1 '
082400010606     C                   END
082500051110
082600010606     C                   ENDSR
082700010606
082800010606      *? ***************************************************************
082900010606     C     VALID2_SR     BEGSR
083000010606      *? VALIDATIONS                          **************************
083100010607     C                   RESET                   CURSOR2PART
083200010607     C                   RESET                   CURSOR2OTHR
083300010607     C                   RESET                   CURSOR2RETR
083400010607     C                   RESET                   CURSOR2MAX
083500010607     C                   RESET                   CURSOR2MAIL2
083600010608     C                   RESET                   CURSOR2MED
083700010608     C                   RESET                   CURSOR2DEN
083800010608     C                   RESET                   CURSOR2LIF
083900130226     C                   RESET                   CURSOR2ALWDP
084000010608     C                   EVAL      W_ERROR_MSG = *BLANKS
084100130213     C*****************  GOTO      SKIP2
084200010607     C                   IF        W_PARTTIME = 'Y' OR
084300010607     C                             W_PARTTIME = 'N'
084400010607     C                   ELSE
084500010607     C                   EVAL      W_ERROR_MSG = 'INVALID HOUSE BILL'
084600010607     C                   EVAL      CURSOR2PART  = *ON
084700010607     C                   EVAL      SCREEN = 'SCRN2   '
084800010607     C                   LEAVESR
084900010607     C                   END
085000010607     C                   IF        W_OTHERINS = 'Y' OR
085100010607     C                             W_OTHERINS = 'N'
085200010607     C                   ELSE
085300010607     C                   EVAL      W_ERROR_MSG = 'INVALID HOUSE BILL'
085400010607     C                   EVAL      CURSOR2OTHR  = *ON
085500010607     C                   EVAL      SCREEN = 'SCRN2   '
085600010607     C                   LEAVESR
085700010607     C                   END
085800010607     C                   IF        W_RETIREES = 'Y' OR
085900010607     C                             W_RETIREES = 'N'
086000010607     C                   ELSE
086100010607     C                   EVAL      W_ERROR_MSG = 'INVALID HOUSE BILL'
086200010607     C                   EVAL      CURSOR2RETR  = *ON
086300010607     C                   EVAL      SCREEN = 'SCRN2   '
086400010607     C                   LEAVESR
086500010607     C                   END
086600130226      *---
086700130226      * Allow Domestic Partner Flag
086800130226      *---
086900130226     C                   IF        W_ALWDP    = 'Y' OR
087000130226     C                             W_ALWDP    = 'N'
087100130226     C                                              Or
087200130226     C                             W_ALWDP    = 'U'
087300130226     C                   If        W_ALWDP  <> ADADFL
087400130226     C                   EVAL      ADADFL     = W_ALWDP
087500130226     C                   Time                    ADCHTM
087600130226     C                   Eval      ADCHDT = Today
087700130226     C                   Eval      ADCHGU = USER_DS
087800130226     C                   End
087900130226     C                   If        %Found(ACCADP)
088000130226     C                   Update    ACCADPR
088100130226     C                   Else
088200130226     C                   Eval      ADTRST = W_TRST
088300130226     C                   Eval      ADSUB# = W_SUB#
088400130226     C                   Eval      ADACCT = W_ACCT
088500130226     C                   Time                    ADCHTM
088600130226     C                   Eval      ADCHDT = Today
088700130226     C                   Eval      ADCHGU = USER_DS
088800130226     C                   Write     ACCADPR
088900130226     C                   End
089000130226     C                   ELSE
089100130226     C                   EVAL      W_ERROR_MSG = 'ALLOW DOMESTIC PARTNER +
089200130226     C                             MUST BE Y, N or U FOR UNDEFINED.'
089300130226     C                   EVAL      CURSOR2ALWDP = *ON
089400130226     C                   EVAL      SCREEN = 'SCRN2   '
089500130226     C                   LEAVESR
089600130226     C                   END
089700130213      *---test
089800130213     C                   GOTO      SKIP2
089900130213      *---test
090000010608     C                   IF        W_RENEWMED <> *ZEROS
090100010608     C                   EVAL      MONTH_DAY = W_RENEWMED
090200010608     C     *ISO          TEST(D)                 MONTH_DAY80            26
090300010608     C                   IF        *IN26 = *ON
090400010608     C                   EVAL      W_ERROR_MSG = 'MONTH-DAY ERROR'
090500010608     C                   EVAL      CURSOR2MED   = *ON
090600010608     C                   EVAL      SCREEN = 'SCRN2   '
090700010608     C                   LEAVESR
090800010608     C                   END
090900010608     C                   END
091000010608     C                   IF        W_RENEWDEN <> *ZEROS
091100010608     C                   EVAL      MONTH_DAY = W_RENEWDEN
091200010608     C     *ISO          TEST(D)                 MONTH_DAY80            26
091300010608     C                   IF        *IN26 = *ON
091400010608     C                   EVAL      W_ERROR_MSG = 'MONTH-DAY ERROR'
091500010608     C                   EVAL      CURSOR2DEN   = *ON
091600010608     C                   EVAL      SCREEN = 'SCRN2   '
091700010608     C                   LEAVESR
091800010608     C                   END
091900010608     C                   END
092000010608     C                   IF        W_RENEWLIF <> *ZEROS
092100010608     C                   EVAL      MONTH_DAY = W_RENEWLIF
092200010608     C     *ISO          TEST(D)                 MONTH_DAY80            26
092300010608     C                   IF        *IN26 = *ON
092400010608     C                   EVAL      W_ERROR_MSG = 'MONTH-DAY ERROR'
092500010608     C                   EVAL      CURSOR2LIF   = *ON
092600010608     C                   EVAL      SCREEN = 'SCRN2   '
092700010608     C                   LEAVESR
092800010608     C                   END
092900010608     C                   END
093000010606     C                   EVAL      MAXAGE_CNT  = *ZEROS
093100010606     C                   IF        W_RENEWMED <> *ZEROS AND
093200010606     C                             W_RENWDAYM =  *ZEROS
093300010606     C                   EVAL      W_RENWDAYM = 30
093400010606     C                   END
093500010606     C                   IF        W_RENEWDEN <> *ZEROS AND
093600010606     C                             W_RENWDAYD =  *ZEROS
093700010606     C                   EVAL      W_RENWDAYD = 30
093800010606     C                   END
093900010606     C                   IF        W_RENEWLIF <> *ZEROS AND
094000010606     C                             W_RENWDAYL =  *ZEROS
094100010606     C                   EVAL      W_RENWDAYL = 30
094200010606     C                   END
094300010606     C                   IF        W_MAXAGE1 = 'X' AND
094400010606     C                             W_MAXAGE2 = 'X'
094500010606     C                   EVAL      W_ERROR_MSG = 'MAX AGE ERROR'
094600010607     C                   EVAL      CURSOR2MAX   = *ON
094700010606     C                   EVAL      SCREEN = 'SCRN2   '
094800010606     C                   LEAVESR
094900010606     C                   END
095000010606     C                   IF        W_MAXAGE3 = 'X'
095100010606     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
095200010606     C                   END
095300010606     C                   IF        W_MAXAGE4 = 'X'
095400010606     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
095500010606     C                   END
095600010606     C                   IF        W_MAXAGE5 = 'X'
095700010606     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
095800010606     C                   END
095900010606     C                   IF        W_MAXAGE6 = 'X'
096000010606     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
096100010606     C                   END
096200120426     C                   IF        W_MAXAGM26 = 'X'
096300120426     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
096400120426     C                   END
096500120426     C                   IF        W_MAXAGY26 = 'X'
096600120426     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
096700120426     C                   END
096800120426     C                   IF        W_MAXAGEOT = 'X'
096900120426     C                   EVAL      MAXAGE_CNT = MAXAGE_CNT + 1
097000120426     C                   END
097100010606     C                   IF        MAXAGE_CNT <> 1
097200010606     C                   EVAL      W_ERROR_MSG = 'MAX AGE ERROR'
097300010607     C                   EVAL      CURSOR2MAX   = *ON
097400010606     C                   EVAL      SCREEN = 'SCRN2   '
097500010606     C                   LEAVESR
097600010606     C                   END
097700010606     C                   IF        W_MAXAGE1 = 'X' OR
097800010606     C                             W_MAXAGE2 = 'X'
097900010606     C                   IF        W_MAXAGE3 = 'X' OR
098000010606     C                             W_MAXAGE4 = 'X' OR
098100010606     C                             W_MAXAGE5 = 'X' OR
098200120426     C                             W_MAXAGE6 = 'X' OR
098300120426     C                             W_MAXAGM26= 'X' OR
098400120426     C                             W_MAXAGY26= 'X' OR
098500120426     C                             W_MAXAGEOT= 'X'
098600010606     C                   ELSE
098700010606     C                   EVAL      W_ERROR_MSG = 'MAX AGE ERROR'
098800010607     C                   EVAL      CURSOR2MAX   = *ON
098900010606     C                   EVAL      SCREEN = 'SCRN2   '
099000010606     C                   LEAVESR
099100010606     C                   END
099200010606     C                   ELSE
099300010606     C                   EVAL      W_ERROR_MSG = 'MAX AGE 19 ERROR'
099400010607     C                   EVAL      CURSOR2MAX   = *ON
099500010606     C                   EVAL      SCREEN = 'SCRN2   '
099600010606     C                   LEAVESR
099700010606     C                   END
099800010607     C                   IF        W_MAIL_TO  = 'G' OR
099900010607     C                             W_MAIL_TO  = 'E' OR
100000010607     C                             W_MAIL_TO  = ' '
100100010607     C                   ELSE
100200010607     C                   EVAL      W_ERROR_MSG = 'INVALID MAIL TO'
100300010607     C                   EVAL      CURSOR2MAIL2 = *ON
100400010607     C                   EVAL      SCREEN = 'SCRN2   '
100500010607     C                   LEAVESR
100600010607     C                   END
100700010712     C     SKIP2         TAG
100800010606
100900010712      *? TEMP DO NOT EDIT **********************************************
101000010712     C                   IF        W_ERROR_MSG = *BLANKS
101100010606     C                   EVAL      SCREEN = 'MAINT '
101200010606     C                   ELSE
101300010606     C                   EVAL      SCREEN = 'SCRN2 '
101400010606     C                   END
101500010606     C                   ENDSR
101600010606
101700010606      *? ***************************************************************
101800010606     C     MAINT_SR      BEGSR
101900010606
102000010606     C                   EVAL      A2ADDRESS1 = W_ADDRESS1
102100010606     C                   EVAL      A2ADDRESS2 = W_ADDRESS2
102200010606     C                   EVAL      A2CITY     = W_CITY
102300010606     C                   EVAL      A2STATE    = W_STATE
102400010606     C                   EVAL      A2ZIP5     = W_ZIP5
102500010606     C                   EVAL      A2ZIP4     = W_ZIP4
102600140219     C                   EVAL      A2COUNTYCD = W_COUNTYCD
102700051110
102800051110      * invoice headings
102900051110     C                   EVAL      a2ih1t     = w_a2ih1t
103000051110     C                   EVAL      a2ih2t     = w_a2ih2t
103100051110     C                   EVAL      a2ih3t     = w_a2ih3t
103200051110     C                   EVAL      a2ih4t     = w_a2ih4t
103300051110     C                   EVAL      a2ih5t     = w_a2ih5t
103400051110     C                   EVAL      a2ih6t     = w_a2ih6t
103500051110     C                   EVAL      a2ih7t     = w_a2ih7t
103600051110     C                   EVAL      a2ih8t     = w_a2ih8t
103700051110     C                   EVAL      a2ih9t     = w_a2ih9t
103800051110     C                   EVAL      a2ih1b     = w_a2ih1b
103900051110     C                   EVAL      a2ih2b     = w_a2ih2b
104000051110     C                   EVAL      a2ih3b     = w_a2ih3b
104100051110     C                   EVAL      a2ih4b     = w_a2ih4b
104200051110     C                   EVAL      a2ih5b     = w_a2ih5b
104300051110     C                   EVAL      a2ih6b     = w_a2ih6b
104400051110     C                   EVAL      a2ih7b     = w_a2ih7b
104500051110     C                   EVAL      a2ih8b     = w_a2ih8b
104600051110     C                   EVAL      a2ih9b     = w_a2ih9b
104700051110
104800010606     C                   EVAL      A2PARTTIME = W_PARTTIME
104900010606     C                   EVAL      A2OTHERINS = W_OTHERINS
105000010606     C                   EVAL      A2RETIREES = W_RETIREES
105100051110     C**                 EVAL      A2COBRAFEE = W_COBRAFEE
105200010606     C                   EVAL      A2EMAIL1   = W_EMAIL1
105300010606     C                   EVAL      A2EMAIL2   = W_EMAIL2
105400010606     C                   EVAL      A2COUNTYCD = W_COUNTYCD
105500010606     C                   EVAL      A2TERMPOLC = W_TERMPOLC
105600010606     C                   EVAL      A2TAX_ID#  = W_TAX_ID#
105700010606     C                   EVAL      A2INSCYCLE = W_INSCYCLE
105800060201     C                   EVAL      A2usecc    = W_usecc
105900051110     C**                 EVAL      A2FUNDED   = W_FUNDED
106000010606     C                   EVAL      A2RENEWMED = W_RENEWMED
106100010606     C                   EVAL      A2RENEWDEN = W_RENEWDEN
106200010606     C                   EVAL      A2RENEWLIF = W_RENEWLIF
106300010606     C                   EVAL      A2MAXAGE1  = W_MAXAGE1
106400010606     C                   EVAL      A2MAXAGE2  = W_MAXAGE2
106500010606     C                   EVAL      A2MAXAGE3  = W_MAXAGE3
106600010606     C                   EVAL      A2MAXAGE4  = W_MAXAGE4
106700010606     C                   EVAL      A2MAXAGE5  = W_MAXAGE5
106800010606     C                   EVAL      A2MAXAGE6  = W_MAXAGE6
106900120426     C                   EVAL      A2MAXAGM26 = W_MAXAGM26
107000120426     C                   EVAL      A2MAXAGY26 = W_MAXAGY26
107100120426     C                   EVAL      A2MAXAGEOT = W_MAXAGEOT
107200010606     C                   EVAL      A2MAIL_TO  = W_MAIL_TO
107300010606     C                   EVAL      A2RENWDAYM = W_RENWDAYM
107400010606     C                   EVAL      A2RENWDAYD = W_RENWDAYD
107500010606     C                   EVAL      A2RENWDAYL = W_RENWDAYL
107600021204     C                   IF        W_NCAPRDT <> *ZEROS
107700021204     C                   MOVE      W_NCAPRDT     USA_DATE
107800021204     C                   MOVE      USA_DATE      ISO_DATE
107900021205     C                   MOVE      ISO_DATE      A2NCAPDT
108000021206    1C                   ELSE
108100021206     C                   EVAL      A2NCAPDT = *ZEROS
108200021204    1C                   ENDIF
108300120423      *---
108400120423      * PRINT INVOICE (CAFIC) field processes via FM060_2CA
108500120423      *---
108600120425     C     W_TRST        Chain     TRSMST
108700120425     C                   If        %Found(TRSMST)
108800200115     C                   If        TSCODE = 'O N' or TSCODE = 'O M' or
108900200115     C                             TSCODE = 'O D'
109000120718     C                   Eval      W_CAFIC      = 'O'
109100120425     C                   End
109200120425     C                   End
109300120423     C                   Eval      FetchUpdFlag = 'U'                           F=Fetch (Read)
109400120423     C                   Call      'FM060_2CA'
109500120423     C                   Parm                    W_TRST
109600120423     C                   Parm                    W_SUB#
109700120423     C                   Parm                    W_ACCT
109800120423     C                   Parm                    W_CAFIC
109900120423     C                   Parm                    FetchUpdFlag
110000160811br01 C                   Parm                    W_Oldt06
110100120423
110200060120      * invoice head effdt
110300060120     C                   IF        W_iheff <> *ZEROS
110400060120     C                   MOVE      W_iheff       USA_DATE
110500060120     C                   MOVE      USA_DATE      ISO_DATE
110600060120     C                   MOVE      ISO_DATE      A2iheff
110700060120    1C                   ELSE
110800060120     C                   EVAL      A2iheff = *ZEROS
110900060120    1C                   ENDIF
111000060120
111100010608     C                   RESET                   A2APPL
111200010606     C
111300020430     C                   IF        %FOUND(AC2MST)
111400010606     C                   UPDATE    ACCMSR2
111500140219     C                   EXSR      $CHK4HIST
111600010606     C                   ELSE
111700010606     C                   EVAL      A2USER     = USER_DS
111800010606     C                   EVAL      A2TIME     = TIME_DS
111900010606     C                   MOVE      ISO_DATE      A2DATE
112000010606     C                   WRITE     ACCMSR2
112100010606     C                   END
112200010606     C                   EVAL      SCREEN = 'SCRN1 '
112300010606     C                   ENDSR
112400140219   S***S
112500140219     C     $CHK4HIST     BEGSR
112600140219    ***
112700140219     C                   IF        HSADR1 <> A2ADDRESS1
112800140219     C                   EXSR      $COMNHIST
112900140219     C                   MOVE      'L54'         TRCODE
113000140219     C                   EVAL      CK#NOT = %TRIM(HSADR1)
113100140219     C                   EVAL      NOTE2 = %TRIM(A2ADDRESS1)
113200140219     C                   WRITE     HISTR
113300140219     C                   ENDIF
113400140219    ***
113500140219     C                   IF        HSADR2 <> A2ADDRESS2
113600140219     C                   EXSR      $COMNHIST
113700140219     C                   MOVE      'L55'         TRCODE
113800140219     C                   EVAL      CK#NOT = %TRIM(HSADR2)
113900140219     C                   EVAL      NOTE2 = %TRIM(A2ADDRESS2)
114000140219     C                   WRITE     HISTR
114100140219     C                   ENDIF
114200140219    ***
114300140219     C                   IF        HSCITY <> A2CITY
114400140219     C                   EXSR      $COMNHIST
114500140219     C                   MOVE      'L56'         TRCODE
114600140219     C                   EVAL      CK#NOT = %TRIM(HSCITY)
114700140219     C                   EVAL      NOTE2 = %TRIM(A2CITY)
114800140219     C                   WRITE     HISTR
114900140219     C                   ENDIF
115000140219    ***
115100140219     C                   IF        HSSTAT <> A2STATE
115200140219     C                   EXSR      $COMNHIST
115300140219     C                   MOVE      'L57'         TRCODE
115400140219     C                   EVAL      CK#NOT = %TRIM(HSSTAT)
115500140219     C                   EVAL      NOTE2 = %TRIM(A2STATE)
115600140219     C                   WRITE     HISTR
115700140219     C                   ENDIF
115800140219    ***
115900140219     C                   IF        HSZIP5 <> A2ZIP5 OR HSZIP4 <> A2ZIP4
116000140219     C                   EXSR      $COMNHIST
116100140219     C                   MOVE      'L58'         TRCODE
116200140219     C                   EVAL      CK#NOT = %EDITC(HSZIP5:'X') + '-' +
116300140219     C                                      %EDITC(HSZIP4:'X')
116400140219     C                   EVAL      NOTE2 = %EDITC(A2ZIP5:'X') + '-' +
116500140219     C                                      %EDITC(A2ZIP4:'X')
116600140219     C                   WRITE     HISTR
116700140219     C                   ENDIF
116800140219    ***
116900140219     C                   IF        HSCNTY <> A2COUNTYCD
117000140219     C                   EXSR      $COMNHIST
117100140219     C                   MOVE      'L59'         TRCODE
117200140219     C                   EVAL      CK#NOT = %TRIM(HSCNTY)
117300140219     C                   EVAL      NOTE2 = %TRIM(A2COUNTYCD)
117400140219     C                   WRITE     HISTR
117500140219     C                   ENDIF
117600140219    ***
117700140219     C                   ENDSR
117800140219   S***S
117900140219     C     $COMNHIST     BEGSR
118000140219    ***
118100140219     C                   CLEAR                   HISTR
118200140219     C                   EVAL      HKEY = %EDITC(A2TRST:'X') +
118300140219     C                             %EDITC(A2SUB#:'X') + %EDITC(A2ACCT:'X')
118400140219     C                   MOVE      'N'           DTRFLG
118500140219     C                   MOVE      *ZEROS        HDSEQ#
118600140219     C                   EVAL      HPRGNM = 'FM060_2R'
118700140219     C                   Z-ADD     A2TRST        HSTRST
118800140219     C                   Z-ADD     A2SUB#        HSSUB#
118900140219     C                   Z-ADD     A2ACCT        HSACCT
119000140219     C                   EVAL      HOPER = USER_DS
119100140219     C                   MOVE      'A'           HSDLTD
119200140219     C                   eval      sysdateymd = %date
119300140219     C                   MOVE      sysdateymd    trdate
119400140219     c                   eval      hstrtime = %time
119500140219    ***
119600140219     C                   ENDSR
119700140219   S***S
119800010606      *? F8 ************************************************************
119900010606     C     COSTCTR_SR    BEGSR
120000010608      *?MAINT COST CTR  CODES
120100010608     C                   CALL      'FM060_5R'
120200010608     C                   PARM                    W_TRST
120300010608     C                   PARM                    W_SUB#
120400010608     C                   PARM                    W_ACCT
120500010608
120600010608     C                   EVAL      SCREEN = GO_BACK
120700010608     C                   ENDSR
120800010503
120900010606      *? F9 ************************************************************
121000010518     C     RELATE_SR     BEGSR
121100010606      *?MAINT   RELATED ACCTS
121200010607     C                   CALL      'FM060_4R'
121300010607     C                   PARM                    W_TRST
121400010607     C                   PARM                    W_SUB#
121500010607     C                   PARM                    W_ACCT
121600010504
121700010606     C                   EVAL      SCREEN = GO_BACK
121800010504     C                   ENDSR
121900010607
122000010607      *? F10 ***********************************************************
122100010607     C     CARRIER_SR    BEGSR
122200010607     C                   CALL      'FM060_3R'
122300010607     C                   PARM                    W_TRST
122400010607     C                   PARM                    W_SUB#
122500010607     C                   PARM                    W_ACCT
122600010607     C                   EVAL      SCREEN = GO_BACK
122700010607     C                   ENDSR
122800010412
122900020220      *  ***************************************************************
123000020220 SSK*C*****COM_NEW_SR****BEGSR
123100020220 SSK****ADD*****COMMENTS*
123200020220 SSK*C*******************EVAL      ADD_DSP_MODE = *ON
123300020220 SSK*C*******************EVAL      A3SEQ# = 99999
123400020220 SSK*C*******************EVAL      A3LINE = 1
123500020220 SSK*C*****ACCMST3_KEY***SETLL     ACCMSR3
123600020220 SSK*C*****ACCMST3_KEY3**READE     ACCMSR3
123700020220 SSK*C*******************IF        NOT %EOF(ACCMST3)
123800020220 SSK*C*******************EVAL      A3SEQ#     = A3SEQ#     + 1
123900020220 SSK*C*******************ELSE
124000020220 SSK*C*******************EVAL      A3SEQ#     = 1
124100020220 SSK*C*******************END
124200020220 SSK*C*******************RESET                   SRECNO1
124300020220 SSK*C*******************RESET                   W_RECNUM
124400020220 SSK*C*******************RESET                   SFLEND_21
124500020220 SSK*C*******************EVAL      SFLDSP_11  = *ON
124600020220 SSK*C*******************WRITE     SFL_CTL1
124700020220 SSK*C*******************RESET                   SFLDSP_11
124800020220 SSK*********************
124900020220 SSK*C*******************DO        1000
125000020220 SSK*C*******************EVAL      SRECNO1  = SRECNO1 + 1
125100020220 SSK*********************
125200020220 SSK*C*******************EVAL      W_COMMENT = *BLANKS
125300020220 SSK*C*******************WRITE     SFL_REC1
125400020220 SSK*C*******************ENDDO
125500020220 SSK*C*******************TIME                    TIMEDATE_DS
125600020220 SSK*C******MDY**********MOVE      DATE_DS       USA_DATE
125700020220 SSK*C*******************MOVE      USA_DATE      W_DATE
125800020220 SSK*C*******************EVAL      W_TIME = TIME_DS
125900020220 SSK*C*******************WRITE     CMD_LINE1
126000020220 SSK*C*******************EXFMT     SFL_CTL1
126100020220 SSK*********************
126200020220 SSK*C*******************IF        F1_PREVIOUS_SC   = *ON
126300020220 SSK*C*******************EVAL      SCREEN = 'SCRN1   '
126400020220 SSK*C*******************LEAVESR
126500020220 SSK*C*******************END
126600020220 SSK*********************
126700020220 SSK*****COST*CTR*SCREEN*                     **************************
126800020220 SSK*C*******************IF        F8_COSTCTR  = *ON
126900020220 SSK*C*******************EVAL      SCREEN = 'COSTCTR '
127000020220 SSK*C*******************EVAL      GO_BACK = 'COM_NEW '
127100020220 SSK*C*******************LEAVESR
127200020220 SSK*C*******************END
127300020220 SSK*********************
127400020220 SSK*****RELATE*SCREEN***                     **************************
127500020220 SSK*C*******************IF        F9_RELATE   = *ON
127600020220 SSK*C*******************EVAL      SCREEN = 'RELATE  '
127700020220 SSK*C*******************EVAL      GO_BACK = 'COM_NEW '
127800020220 SSK*C*******************LEAVESR
127900020220 SSK*C*******************END
128000020220 SSK*********************
128100020220 SSK****CARRIER*SCREEN***                     **************************
128200020220 SSK*C*******************IF        F10_CARRIER = *ON
128300020220 SSK*C*******************EVAL      SCREEN = 'CARRIER '
128400020220 SSK*C*******************EVAL      GO_BACK = 'COM_NEW '
128500020220 SSK*C*******************LEAVESR
128600020220 SSK*C*******************END
128700020220 SSK*********************
128800020220 SSK*C*******************EVAL      A3LINE     = *ZEROS
128900020220 SSKOC*******************DOU       %EOF
129000020220 SSK C*******************READC     SFL_REC1
129100020220 SSK*C*******************IF        NOT %EOF
129200020220 SSK*C*******************EVAL      A3LINE     = A3LINE     + 1
129300020220 SSK*C*****ACCMST3_KEY***CHAIN     ACCMSR3
129400020220 SSK*********************
129500020220 SSK*C*******************RESET                   A3APPL
129600020220 SSK*C*******************EVAL      A3COMMENT = W_COMMENT
129700020220 SSK*C*******************IF        %FOUND(ACCMST3)
129800020220 SSK*C*******************UPDATE    ACCMSR3
129900020220 SSK*C*******************ELSE
130000020220 SSK*C*******************EVAL      A3USER     = USER_DS
130100020220 SSK*C*******************EVAL      A3TIME     =  TIME_DS
130200020220 SSK*C******MDY**********MOVE      DATE_DS       ISO_DATE
130300020220 SSK*C*******************MOVE      ISO_DATE      A3DATE
130400020220 SSK*C*******************WRITE     ACCMSR3
130500020220 SSK*C*******************END
130600020220 SSK*C*******************END
130700020220 SSK C*******************ENDDO
130800020220 SSK*********************
130900020220 SSK*C*******************EVAL      SCREEN = 'COM_NEW '
131000020220 SSK*********************
131100020220 SSK*C*******************ENDSR
131200010412
131300020220 SSK*** ****************************************************************
131400020220 SSK*C*****COM_HIST_SR***BEGSR
131500020220 SSK*** DISPLAY*COMMENT**HIST
131600020220 SSK*C*******************EVAL      ADD_DSP_MODE = *OFF
131700020220 SSK*C*******************EVAL      A3SEQ# = 99999
131800020220 SSK*C*******************EVAL      A3LINE = 1
131900020220 SSK C*****ACCMST3_KEY***SETLL     ACCMSR3
132000020220 SSK*C*****ACCMST3_KEY3**READE     ACCMSR3
132100020220 SSK*C*******************DOU       F1_PREVIOUS_SC = *ON
132200020220 SSK C*****ACCMST3_KEY***SETLL     ACCMSR3
132300020220 SSK*C*******************RESET                   SRECNO1
132400020220 SSK*C*******************RESET                   W_RECNUM
132500020220 SSK*C*******************RESET                   SFLEND_21
132600020220 SSK*C*******************EVAL      SFLDSP_11  = *ON
132700020220 SSK C*******************WRITE     SFL_CTL1
132800020220 SSK*C*******************RESET                   SFLDSP_11
132900020220 SSK*********************
133000020220 SSK C*******************DOU       %EOF(ACCMST3)
133100020220 SSK*C*****ACCMST3_KEY2**READE     ACCMSR3
133200020220 SSK*********************
133300020220 SSK*C*******************IF        NOT %EOF(ACCMST3)
133400020220 SSK*C*******************EVAL      SRECNO1  = SRECNO1 + 1
133500020220 SSK*C*******************EVAL      W_COMMENT = A3COMMENT
133600020220 SSK C*******************WRITE     SFL_REC1
133700020220 SSK*C*******************ELSE
133800020220 SSK*C*******************EVAL      W_COMMENT = *BLANKS
133900020220 SSK*C*******************EVAL      W_COMMENT = '*END OF COMMENT*'
134000020220 SSK*C*******************EVAL      SRECNO1  = SRECNO1 + 1
134100020220 SSK C*******************WRITE     SFL_REC1
134200020220 SSK*C*******************END
134300020220 SSK C*******************ENDDO
134400020220 SSK*C*******************IF        A3DATE     = *ZEROS
134500020220 SSK*C*******************MOVE      USA_DATE      W_DATE
134600020220 SSK*C*******************ELSE
134700020220 SSK*C******ISO**********MOVE      A3DATE        USA_DATE
134800020220 SSK*C*******************MOVE      USA_DATE      W_DATE
134900020220 SSK*C*******************END
135000020220 SSK*C*******************IF        A3TIME     = *ZEROS
135100020220 SSK*C*******************EVAL      W_TIME = TIME_DS
135200020220 SSK*C*******************ELSE
135300020220 SSK*C*******************EVAL      W_TIME = A2TIME
135400020220 SSK*C*******************END
135500020220 SSK C*******************WRITE     CMD_LINE4
135600020220 SSK C*******************EXFMT     SFL_CTL1
135700020220 SSK*********************
135800020220 SSK*** *COST*CENTER*CODES SCREEN             **************************
135900020220 SSK*C*******************IF        F8_COSTCTR  = *ON
136000020220 SSK*C*******************EVAL      SCREEN = 'COSTCTR '
136100020220 SSK*C*******************EVAL      GO_BACK = 'COM_HIST'
136200020220 SSK*C*******************LEAVESR
136300020220 SSK*C*******************END
136400020220 SSK*********************
136500020220 SSK*** *RELATE*SCREEN***                     **************************
136600020220 SSK*C*******************IF        F9_RELATE   = *ON
136700020220 SSK*C*******************EVAL      SCREEN = 'RELATE  '
136800020220 SSK*C*******************EVAL      GO_BACK = 'COM_HIST'
136900020220 SSK*C*******************LEAVESR
137000020220 SSK*C*******************END
137100020220 SSK*********************
137200020220 SSK*** *CARRIER*SCREEN**                     **************************
137300020220 SSK*C*******************IF        F10_CARRIER = *ON
137400020220 SSK*C*******************EVAL      SCREEN = 'CARRIER '
137500020220 SSK*C*******************EVAL      GO_BACK = 'COM_HIST'
137600020220 SSK*C*******************LEAVESR
137700020220 SSK*C*******************END
137800020220 SSK*********************
137900020220 SSK*C*******************EVAL      A3SEQ# = A3SEQ# - 1
138000020220 SSK*C*******************EVAL      A3LINE = 1
138100020220 SSK*C*******************ENDDO
138200020220 SSK*C*******************EVAL      SCREEN = 'SCRN1   '
138300020220 SSK*********************
138400020220 SSK*C*******************ENDSR
138500010503
138600010605      *? ***************************************************************
138700010605     C     END_JOB_SR    BEGSR
138800131004     C                   callp     #zip_closesrv()
138900010605     C                   EVAL      *INLR = *ON
139000010605     C                   RETURN
139100010605     C                   ENDSR
139200010412      *? **********************************************************
139300010412     C     *INZSR        BEGSR                                                  INITIAL SETUP
139400010412
139500010416     C     ACCMST2_KEY   KLIST
139600010416     C                   KFLD                    A2APPL
139700010416     C                   KFLD                    W_TRST
139800010412     C                   KFLD                    W_SUB#
139900010412     C                   KFLD                    W_ACCT
140000010416
140100020220 SSK*C*****ACCMST3_KEY***KLIST
140200020220 SSK*C*******************KFLD                    A3APPL
140300020220 SSK*C*******************KFLD                    W_TRST
140400020220 SSK*C*******************KFLD                    W_SUB#
140500020220 SSK*C*******************KFLD                    W_ACCT
140600020220 SSK*C*******************KFLD                    A3SEQ#
140700020220 SSK*C*******************KFLD                    A3LINE
140800010416
140900020220 SSK*C*****ACCMST3_KEY2**KLIST
141000020220 SSK*C*******************KFLD                    A3APPL
141100020220 SSK*C*******************KFLD                    W_TRST
141200020220 SSK*C*******************KFLD                    W_SUB#
141300020220 SSK*C*******************KFLD                    W_ACCT
141400020220 SSK*C*******************KFLD                    A3SEQ#
141500010607
141600020220 SSK*C*****ACCMST3_KEY3**KLIST
141700020220 SSK*C*******************KFLD                    A3APPL
141800020220 SSK*C*******************KFLD                    W_TRST
141900020220 SSK*C*******************KFLD                    W_SUB#
142000020220 SSK*C*******************KFLD                    W_ACCT
142100010416
142200010503     C     ACCMST_KEY    KLIST
142300010416     C                   KFLD                    W_TRST
142400010416     C                   KFLD                    W_SUB#
142500010416     C                   KFLD                    W_ACCT
142600010416
142700010503     C     SUBMST_KEY    KLIST
142800010416     C                   KFLD                    W_TRST
142900010416     C                   KFLD                    W_SUB#
143000010504
143100090401
143200010503     C     *ENTRY        PLIST
143300010503     C                   PARM                    ACCT_NBR_E
143400160811
143500130213     C     *DATE         Mult      10000.0001    Today             8 0
143600010503     C                   MOVE      ACCT_NBR_E    ACCT_NBR
143700160811
143800160811br01 C                   eval      Hide_AdminFee = *off
143900160811br01 C     W_TRST        Chain     TRSMST
144000160811br01 C                   if        %Found(TrsMst)
144100160811br01 C                   if        %SubSt(tsCode:3:1) = 'W'
144200160811br01 C                   eval      Hide_AdminFee = *on
144300160811br01 C                   endif
144400160811br01 C                   endif
144500160811
144600010419
144700010417     C     *DTAARA       DEFINE                  COMPANY
144800010417     C                   IN        COMPANY
144900010416
145000051110     C                   IF        APPLICATION = 'N.'
145100051110     C                   EVAL      A2APPL = 'S'
145200020220SSK**C**************     EVAL      A3APPL = 'S'
145300051110     C                   EVAL      W_APPL = 'SELF'
145400051110     C                   EVAL      IN52_SELFUNDED  = *ON
145500010416     C                   ELSE
145600010608     C                   EVAL      A2APPL = 'F'
145700020220SSK**C**************     EVAL      A3APPL = 'F'
145800010608     C                   EVAL      W_APPL = 'FULL'
145900010416     C                   END
146000010416
146100010416     C                   EVAL      SCREEN = 'SCRN1   '
146200010416
146300160811     C     ACCMST_KEY    CHAIN     ACCMSR
146400160811br01 C                   eval      w_oldt06 = a_oldt06
146500160811 |
146600160811 |     //?Get the Admin Fee Decription
146700160811 |            CodeKey = 'ADMINFEE';
146800160811 |            CodeSearch = w_oldt06;
146900160811 |            w_s2AdmDesc = *Blanks;
147000160811 |
147100160811 |            Chain (CodeKey : CodeSearch) Code20p;
147200160811 |            if %Found(Code20P);
147300160811 |               w_s2AdmDesc = c20lDesc;
147400160811 |            endif;
147500160811 |
147600160811br01 C
147700160811
147800160811
147900160811
148000160811     C     SUBMST_KEY    CHAIN     SUBMSR
148100010416
148200020220     ***DUMMY WRITE FOR FIELD VALUES
148300020220     C                   IF        A_ACDLTD = '9'
148400020220     C                   WRITE     SFL_CTL1
148500020220     C                   ENDIF
148600020220
148700010416     C                   IF        A_ACDLTD     = 'C'
148800010606     C                   EVAL      CANED_ACT_80 = *ON
148900010416     C                   ELSE
149000010606     C                   EVAL      CANED_ACT_80 = *OFF
149100010416     C                   END
149200010503     C                   TIME                    TIMEDATE_DS
149300010503     C     *MDY          MOVE      DATE_DS       USA_DATE
149400010503     C     *MDY          MOVE      DATE_DS       ISO_DATE
149500010412
149600010504     C                   EVAL      W_FKEY_LINE =  FKEY1
149700010511     C                   EVAL      W_RECNUM  = 1
149800010606     C                   EVAL      W_RENWDAYM = 30
149900010606     C                   EVAL      W_RENWDAYD = 30
150000010606     C                   EVAL      W_RENWDAYL = 30
150100010412     C                   ENDSR
150200051110
150300051110      ***********************************************************
150400051110      * copy subdivision headings to ac2mst headings
150500051110      ***********************************************************
150600051110     C     #copyhead     begsr
150700051110
150800051110      * subdivision headings (for display only)
150900051110     C                   EVAL      w_a2ih1t = w_ih1t
151000051110     C                   EVAL      w_a2ih2t = w_ih2t
151100051110     C                   EVAL      w_a2ih3t = w_ih3t
151200051110     C                   EVAL      w_a2ih4t = w_ih4t
151300051110     C                   EVAL      w_a2ih5t = w_ih5t
151400051110     C                   EVAL      w_a2ih6t = w_ih6t
151500051110     C                   EVAL      w_a2ih7t = w_ih7t
151600051110     C                   EVAL      w_a2ih8t = w_ih8t
151700051110     C                   EVAL      w_a2ih9t = w_ih9t
151800051110     C                   EVAL      w_a2ih1b = w_ih1b
151900051110     C                   EVAL      w_a2ih2b = w_ih2b
152000051110     C                   EVAL      w_a2ih3b = w_ih3b
152100051110     C                   EVAL      w_a2ih4b = w_ih4b
152200051110     C                   EVAL      w_a2ih5b = w_ih5b
152300051110     C                   EVAL      w_a2ih6b = w_ih6b
152400051110     C                   EVAL      w_a2ih7b = w_ih7b
152500051110     C                   EVAL      w_a2ih8b = w_ih8b
152600051110     C                   EVAL      w_a2ih9b = w_ih9b
152700051110
152800051110     C                   ENDSR
152900130917      **********************************************************************
153000140114      * edit_county: Currently, for MD & PA only, set the county code
153100130917      *              programmatically if there is only one county for that
153200130917      *              zip -OR - prompt the user to select a county.
153300170125      *  1/25/2016 B.Rees  - Added CT for the EDIT.
153400130917      **********************************************************************
153500130917     C     edit_county   begsr
153600130917
153700130917      * call function to retrieve county for this zip - function can return
153800130917      * 'ER' (error) or '**' (multiple counties for zip) or a single county.
153900131017     C                   eval      wrk_countycode = #get_county(w_zip5:w_state)
154000130917     C                   if        wrk_countycode <> '**' and
154100130917     C                             wrk_countycode <> 'ER'
154200130917     C                   if        wrk_countycode <> w_countycd
154300130917     C                   eval      w_countycd = wrk_countycode
154400130917     C                   endif
154500130917
154600130917      * else, either mult counties or error returned from function...       e
154700130917     C                   elseif    (sv_zip5 <> w_zip5) or (#valid_county(
154800130917     c                              w_zip5:w_state:w_countycd) = 'N')
154900131017     C                   eval      wrk_countycode = #select_county(w_zip5:
155000131017     C                             w_state)
155100130917     C                   if        wrk_countycode <> *blanks
155200130917     C                   eval      w_countycd = wrk_countycode
155300130917     c                   else
155400130917     C                   eval      w_error_msg = 'Invalid County'
155500130917     C                   eval      cursor2cc = *on
155600130917     C                   endif
155700130917
155800130917     C                   endif
155900130917
156000130917     C                   endsr
