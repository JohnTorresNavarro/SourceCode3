0001000108100002  *---------------------------------------------------------------**
0002000108100003  * COB220     GROUP BENEFIT SERVICES SOFTWARE                     *
0003000108100005  *            WRITTEN BY - M.L.F.                                 *
0004000108100006  *            DATE - 09/98                                        *
0005000108100008  *  DESCRIPTION - THIS PROGRAM PRINTS DEPENDENT CANCELLATION      *
0006000108100009  *                LETTERS WORK FILE BUILD.(BASED UPON SELECTION)  *
000700010810      * DLW 12.98 CHANGED PGM TO HANDLE 8 BYTE DATE -Y2K COMPLIANT.    *
000800010810      *           CHANGED PLAN TO ALPHA FORMAT.                        *
000900010810      * DLK 06/11/99 ADD RATE SHEET PRINT FOR S.F                      *
001000010810      * DLK 06/09/00 fix name length                                   *
001100010904      * KSJ 08/21/01 MODIFIED TO GET PLANS FROM CK#NOT FOR SELF-       *
001200010821      *              FUNDED. OMITTED PRINTING OF RATE SHEET.           *
001300040726      * DLK 07/26/04 include RX plans, remove MH plans                 *
001400040921      * DLK 09/21/04 use new plan cat type                             *
001500050502      * SZZ 05/02/05 Search for "B"enegap plan cat type and store the  *
001600050505      *               related premiums in the new Benegap premium field*
001700050502      *               of the COB220WK file.                            *
001800090423      * DLK 04/23/09 remove COBRAR file (rate sheet)                   *
001900110201      * DLK 02/01/11 add new plan cat type "I" for payroll benegap funding
0020001103110011  * dlk 03/11/11 Exclude plans OPTM & OPTD even though they are a cat
0021001312060011  *              type "M" (like we did in DB430). - Per Dave A and Shelly
0022001110110011  * dlk 10/11/11 fix catmem routine
0023001210150011  * dlk 10/15/12 add fields to cob220wk for hra bundling plan (mplan2)
002400131011      * dlk 10/11/13 hist file expansion project - recompile only
0025001312060011  * DLK 12/06/13 - Hard coded exclusion of plans WAVM, WAVD, WAVV due
0026001312060011  *                to a design flaw in OLE. - Per Dave A.
0027001401170011  * DLK 01/17/14 - use dep # from hist rec instead of note field
0028001403280011  * DLK 03/28/14 - remove cbrplnf file, it was not used.
0029001510230011  * DLK 10/23/15 - Hard coded exclusion of plans DECD, DECM and DECV
0030001510230011  *                since no other soultion has been accepted yet
0031001801300011  * DLK 01/30/18 - add CM to 1P for hra bundling plan, both plan
003200180130      *                category codes will be considered the hra bundling
003300180130      *                plan so the premium is added to the medical plan
003400180925      * DLK 09/24/18 - add new plan cat type "C" for EAP for fed cobra only
0035001812100011  * DLK 12/10/18 - Hard code Humana med and den carriers in md state
0036001812100011  *                accts as ineligible. Humana does not allow state
0037001812100011  *                extension.
0037012002040011  * DLK 02/04/20 - Identify EBS dependents on the screen
003800180130      *                                                                *
0039000108100013  *---------------------------------------------------------------**
004000980901     FCOB220D   CF   E             WORKSTN
004100980901     FMEMBER    IF   E           K DISK
004200980901     FACCMST    IF   E           K DISK
004300980904     FHISTAK    IF   E           K DISK
004400980904     FPLNMST    IF   E           K DISK
004500980901     FDEPNDC    IF   E           K DISK
004600040921     Fcodesl1   IF   E           K DISK
0047000108150027 FCOB220WK  O  A E             DISK
004800010821ksj  F*TR173P    O    E             PRINTER
004900010814
0050009809030032 D M               S              1    DIM(19)
005100980903     D TABA            S              2  0 DIM(12) CTDATA PERRCD(1)
005200980903     D TABB            S              9    DIM(12) ALT(TABA)
005201200204     D ebsacct         S              1
005202200204     D ebsmsg          S             50a   inz('This is an EBS account')
005203200204     D parmebsyn       S              1
005204200204     D parmebstsa      S             10
005300990611     D                UDS
005400990611     D  USERID                25     32
0055009809010693 D  CONAME               201    240
0056009809010694 D  STIME                242    253  0
005700010814
005800010814      * HISTAK KEY.
005900010814      * -----------
006000980904     C     HSTKEY        KLIST
006100980904     C                   KFLD                    HISKEY
006200980904     C                   KFLD                    HISDAT
006300010814      * PLNMST KEY.
006400010814      * -----------
006500980904     C     PLNKEY        KLIST
006600980904     C                   KFLD                    TRUST
006700980904     C                   KFLD                    SUB
006800980904     C                   KFLD                    PLN
006900010814      * ACCMST KEY.
007000010814      * -----------
007100980901     C     AKEY          KLIST
007200980901     C                   KFLD                    TRUST
007300980901     C                   KFLD                    SUB
007400980901     C                   KFLD                    ACCT
007500010814      * DEPEND KEY.
007600010814      * -----------
007700980904     C     DKEY          KLIST
007800980904     C                   KFLD                    MEMSSN
007900980904     C                   KFLD                    DEPSEQ
008000010814
008100980901     C     LOOP          TAG
008200010814
008300980901     C                   EXSR      INIT
008400010814
008500041028     C     #redisplay    TAG
008600010814     C                   EXFMT     S01
008700110414     c                   eval      *in55 = *off
008800010814
008900980903     C                   IF        FIRST = ' '
009000980903     C                   MOVEL     UMONTH        TABMON            2 0
009100980903     C                   MOVEL     UDAY          TABDAY            2 0
0092009809030075 C                   MOVE      *YEAR         YEARC             4
009300980903     C                   MOVE      'Y'           FIRST             1
009400980903     C     TABMON        LOOKUP    TABA          TABB                     66
009500980903     C                   IF        *IN66 = '1'
009600980903     C                   MOVEL     TABB          MONTH             9
009700980903     C                   MOVE      *BLANKS       MON              10
009800980903     C                   MOVEL     TABB          MON
009900980903     C                   END
010000980903     C                   EXSR      #MONTH
010100980903     C                   END
010200010814
010300980901     C     *IN07         CABEQ     '1'           #END
010400010814      *  SET UP HISTORY KEY FROM SCREEN FORMAT KEYS.
010500980904     C                   MOVE      MEMSSN        HISKEY           10
010600981217     C                   MOVE      TRNDAT        MDCY#             8
010700981217     C                   EXSR      #MDCY8
010800981217     C                   MOVE      CYMD#         HISDAT            8 0
010900010814
011000010814      *GET MEMBER T,S,A.
011100010814      *-----------------
011200040921     C     MEMSSN        CHAIN     MEMBER                             50
011300040921     C                   IF        *IN50 = *on
011400040921     C                   GOTO      loop
011500040921     C                   END
011600980901     C                   MOVE      MBTRST        TRUST
011700980903     C                   MOVE      MBSUB#        SUB
011800980903     C                   MOVE      MBACCT        ACCT
011900980903     C                   EXSR      CATMEM
012000980903     C                   MOVE      MNAM          MNAME
012100040921
012200010814      *GET DEPENDENT NAME,ADDRESS.
012300010814      *---------------------------
012400040921     C     DKEY          CHAIN     DEPNDC                             60
012500040921     C                   IF        *IN60 = *on
012600040921     C                   GOTO      loop
012700040921     C                   END
012800040921
012900130425     C                   clear                   depssn
013000130425     C                   MOVE      depss#        depssn
013100130425     C                   MOVE      *BLANKS       DADD1
013200980901     C                   MOVE      *BLANKS       DADD2
013300980901     C                   MOVE      *BLANKS       TSTADD            2
013400980902     C                   Z-ADD     0             DZIP5
013500980902     C                   Z-ADD     0             DZIP4
013600980901     C                   MOVEL     DADDR1        TSTADD
013700980901     C                   IF        TSTADD = 'SA'
013800980901     C                             OR TSTADD = '??'
013900980901     C                             OR TSTADD = '  '
014000980901     C                   MOVE      ADDR1         DADD1
014100980901     C                   MOVE      ADDR2         DADD2
014200980902     C                   MOVEL     ZIP           DZIP5
014300980902     C                   MOVE      ZIP           DZIP4
014400980903     C                   MOVE      *BLANKS       DCSZ
014500980903     C                   EXSR      CATADD
014600980901     C                   ELSE
014700980901     C                   MOVE      DADDR1        DADD1
014800980901     C                   MOVE      DADDR2        DADD2
014900980902     C                   MOVEL     DZIP          DZIP5
015000980902     C                   MOVE      DZIP          DZIP4
015100980903     C                   MOVE      *BLANKS       DCSZ
015200980903     C                   EXSR      CATCSZ
015300980901     C                   END
015400010814
015500980902     C                   EXSR      BLANK
015600010814
015700980902     C                   MOVEL     DFNAME        FNAME
015800980901     C                   IF        DLNAME = 'SAME'
015900980902     C                   MOVEL     MLNAME        LNAME
016000980901     C                   ELSE
016100980901     C                   MOVEL     DLNAME        LNAME
016200980901     C                   END
016300980901     C                   EXSR      CATNAM
016301200204     C                   MOVE      DNAME         NAME
016302200204
016401200204       name_o = 'Depend name: ' + DNAME;
016500040921
016600010814      * GET ACCMST ACCOUNT NAME.
016700010814      *-------------------------
016800040921     C     AKEY          CHAIN     ACCMST
016900040921     C                   IF        not %found(accmst)
017000040921     c                   goto      loop
017100040921     C                   END
017200041028
017300041028     c                   if        (fcstfl <> 'F' and fcstfl <> 'S') or
017400041028     c                             (acobsrv <> 'F' and acobsrv <> 'L')
017500041028     c                   eval      *in51 = *on
017600041028     c                   goto      #redisplay
017700041028     C                   END
017800041028
017900040921
018000980901     C                   MOVE      ACNAM1        ANAME
018100110415     C                   MOVE      ACNAM2        ANAME2
018200980902     C                   MOVE      FCSTFL        FLAG
018300041028     C                   MOVE      acobsrv       cserv
018400010814      *-------------------------------------
018500010814
018600990721     C                   MOVE      *BLANKS       PMMFLD
018700990721     C                   MOVE      *BLANKS       PDNFLD
018800990721     C                   MOVE      *BLANKS       PVSFLD
018900040726     C                   MOVE      *BLANKS       prxfld
019000010814
019100010814      * GET PLANS FROM CK#NOT FIELD.
019200010814      *-----------------------------
019300010814
019400110414     C                   clear                   histfound         1
019500980904     C     HSTKEY        SETLL     HISTAK
019600040921     C                   DOU       %eof(histak)
019700040921     C     HSTKEY        READE     HISTAK
019800040921     C                   IF        not %eof(histak)
019900040921
020000140117     c                   if        trcode <> 'MDD' or hdseq# <> depseq
020100040921     c                   iter
020200040921     c                   end
020300040921
020400980908     C                   Z-ADD     0             DCAND
020500981217     C                   MOVE      *BLANK        PLN               4
020600980908     C                   MOVE      COVTDT        DCAND
020700980904     C                   MOVEL     CK#NOT        PLN
020800110311
020900110311      * 03/11/11 exclude opt out payroll plans
021000151023      * 10/23/15 exclude decline plans
021100131206     c                   if        (pln = 'OPTM' or pln = 'OPTD' or
021200131206     c                              pln = 'WAVM' or pln = 'WAVD' or
021300151023     c                              pln = 'WAVV' or
021400151023     c                              pln = 'DECM' or pln = 'DECD' or
021500151023     c                              pln = 'DECV')
021600110311     c                   iter
021700110311     c                   end
021800110311
021900040921     C     PLNKEY        CHAIN     PLNMST
022000040921     C                   IF        not %found(plnmst)
022100040921     c                   iter
022200040921     c                   end
022300181210
022400181210      * 12/10/18 - Skip Humana med & den in state accounts since they are
022500181210      *            not elig for state extension
022600181210     c                   if        (pcarr = 'HUM' or pcarr = 'HUD')
022700181210     c                             and fcstfl = 'S'
022800181210     c                   iter
022900181210     c                   end
023000181210
023100040921
023200040921     c     plncat        chain     codesl1
023300040921     c                   if        not %found(codesl1)
023400040921     C                   iter
0235000409210089 C                   ENDIF
023600010814
023700110414      * a valid hist rec was found
023800110414     c                   eval      histfound = 'Y'
023900180130
024000180130      * is this an HRA bundled plan?
024100180130     c                   move      'N'           hrabundleplan     1
024200180130     c                   if        plncat = 'P1P' or plncat = 'PCM'
024300180130     c                   eval      hrabundleplan = 'Y'
024400180130     c                   end
024500110414
024600040921     c                   select
024700050505    ? * Benegap Funding Fee                                            *
024800110204    ? * 2/1/11 add plan cat type "I" for payroll
024900110201     C                   When      BNPLAN    =   *Blanks And
025000110204     C                             ((ACTION = 'B' and plncat = 'PBN') or
025100110204     C                              (ACTION = 'I'))
025200110201     C                   Eval      BENNFLD   =   'B'
025300110201     C                   Movel     CK#NOT        BNPLAN
025400110201
025500050505    ? * Benegap Claims Processing Fee                                  *
025600050505     C                   When      BGPLAN    =   *Blanks And
025700050505     C                             ACTION    =   'B'     And
025800050505     C                             PLNCAT    =   'PBG'
025900050505     C                   Eval      BENGFLD   =   'B'
026000050505     C                   Movel     CK#NOT        BGPLAN
026100050505
026200180130    ? * medical - non HRA bundling
026300180130     C                   when      mplan = *blanks and action = 'M' and
026400180130     c                             hrabundleplan = 'N'
026500040921     C                   EVAL      PMMFLD = 'M  '
026600980911     C                   MOVEL     CK#NOT        MPLAN
026700010814
026800180130    ? * medical - hra bundling plan
026900180130     C                   when      mplan2 = *blanks and action = 'M' and
027000180130     c                             hrabundleplan = 'Y'
027100121015     C                   MOVEL     CK#NOT        MPLAN2
027200121015
027300121015    ? *
027400040921     C                   when      dplan = *blanks and
027500040921     C                             action = 'D  '
027600010814     C                   EVAL      PDNFLD = 'PDN'
027700010814     C                   MOVEL     CK#NOT        DPLAN
027800010814
027900040921     C                   when      vplan = *blanks and
028000040921     C                             action = 'V'
028100040921     C                   EVAL      PVSFLD = 'V  '
028200010814     C                   MOVEL     CK#NOT        VPLAN
028300010814
028400040921     C                   when      rplan = *blanks and
028500040921     C                             action = 'R'
028600040921     C                   EVAL      prxfld = 'R  '
028700040726     C                   MOVEL     CK#NOT        rplan
028800010814
028900180925    ? * EAP plan - Fed COBRA only
029000180924     C                   when      eapplan = *blanks and
029100180925     C                             action = 'C' and fcstfl = 'F'
029200180924     C*** Not used?      EVAL      eapfld = 'EAP'
029300180924     C                   MOVEL     CK#NOT        eapplan
029400180924
029500040921     c                   endsl
029600040921
029700040921     c                   end
029800040921     C                   enddo
029900110414
030000110414      * if no letter was found on this date, redisplay with error.
030100110414
030200110414     c                   if        histfound = *blank
030300110414     c                   eval      *in55 = *on
030400110414     c                   goto      #redisplay
030500110414     C                   END
030600010814
030601200204      * check for EBS acct
030602200204     c                   exsr      #chkebs
030603200204
030700980901     C                   EXFMT     S02
030800110414
030801200204      * only enter will select the dependent. F1 or F7 skips it
030900200204     c                   if        *inka = *off and *inkg = *off
031000980914     C                   WRITE     COBWRK
031100110414     c                   end
031200110414
031300011012     C                   CLEAR                   COBWRK
031400010814
031500980901     C                   GOTO      LOOP
031600010814
031700980901     C     #END          TAG
031800980901     C                   SETON                                        LR
031900010814
032000010814      *----------------------------------------------------
032100010814      **TOPIC DATE EXAMPLE(SEPTEMBER 19,1997)
0322009809030650 C     #MONTH        BEGSR
0323000108140651
0324000108140652  * INITIALIZE ARRAY AND COUNTER
0325000108140653
0326009809030654 C                   MOVE      *BLANKS       M
0327009809030655 C                   Z-ADD     19            N#                2 0
0328009809030656 C                   MOVEA     MON           M(1)
0329000108140657
0330000108140658  *  FIND FIRST BLANK SPACE
0331000108140659
0332009809030660 C                   DOU       M(N#) <> ' '
0333009809030661 C                   SUB       1             N#
0334009809030662 C                   END
0335000108140663
0336000108140664  * MOVE IN DAY.
0337000108140665
033800980903     C                   MOVE      TABDAY        DAY               2
0339009809030666 C                   IF        DAY <> ' '
0340009809030667 C                   ADD       2             N#
0341009809030668 C                   MOVEA     DAY           M(N#)
0342009809030669 C                   ADD       2             N#
0343009809030670 C                   MOVEA     ','           M(N#)
0344009809030671 C                   END
0345000108140672
0346009809030673 C                   ADD       2             N#
0347009809030674 C                   MOVEA     YEARC         M(N#)
034800980903     C                   MOVEA     M             MSCRIP
0349009809030675 C                   ENDSR
035000980903      **--------------------------------------------**
035100010814      **CAT MEMBER NAME.
035200980903     CSR   CATMEM        BEGSR
035300111011     C                   clear                   FLD2
035400111011     C                   clear                   mnam
035500111011     C                   MOVEL     MFNAME        FLD2             34
035600980903     C                   IF        MMI <> *BLANKS
035700111011     C                   CAT       MMI:1         FLD2
035800980903     C                   CAT       '.':0         FLD2
035900980903     C                   ENDIF
036000980903     C                   CAT       MLNAME:1      FLD2
036100000609     C                   MOVEL     FLD2          MNAM             34
036200980903     C                   ENDSR
036300980901      **--------------------------------------------**
036400010814      **CAT DEPENDENT NAME.
036500980901     CSR   CATNAM        BEGSR
036600000609     C                   MOVEL     FNAME         FLD1             34
036700980901     C                   IF        DMI <> *BLANKS
036800980901     C     FNAME         CAT       DMI:1         FLD1
036900980901     C                   CAT       '.':0         FLD1
037000980901     C                   ENDIF
037100980901     C                   CAT       LNAME:1       FLD1
037200000609     C                   MOVEL     FLD1          DNAME            34
037300980901     C                   ENDSR
037400980901      **--------------------------------------------**
037500980901     CSR   CATADD        BEGSR
037600000424     C                   MOVEL     CITY          FLD3             20
037700980903     C                   CAT       ',':0         FLD3
037800000424     C                   CAT       STATE:1       FLD3
037900980903     C                   MOVEL     FLD3          DCSZ             20
038000980901     C                   ENDSR
038100980901      **--------------------------------------------**
038200980901     CSR   CATCSZ        BEGSR
038300000424     C                   MOVEL     DCITY         FLD3
038400980903     C                   CAT       ',':0         FLD3
038500000424     C                   CAT       DSTATE:1      FLD3
038600980903     C                   MOVEL     FLD3          DCSZ             20
038700980901     C                   ENDSR
038800010814      *------------------------------------------------------
038900980901     C     INIT          BEGSR
039000980901     C                   CLEAR                   FNAME
039100980901     C                   CLEAR                   LNAME
039200200204     C                   CLEAR                   NAME
039201200204     C                   CLEAR                   NAME_O
039300980901     C                   CLEAR                   MEMSSN
039400980901     C                   CLEAR                   DEPSEQ
039500980908     C                   CLEAR                   TRNDAT
039600980901     C                   CLEAR                   TRUST
039700980901     C                   CLEAR                   SUB
039800980901     C                   CLEAR                   ACCT
039900980901     C                   CLEAR                   ANAME
040000110415     C                   CLEAR                   ANAME2
040100980902     C                   CLEAR                   FLAG
040200041028     C                   CLEAR                   cserv
040300980901     C                   CLEAR                   DNAME
040400980901     C                   CLEAR                   DADD1
040500980901     C                   CLEAR                   DADD2
040600980901     C                   CLEAR                   DCAND
040700980903     C                   CLEAR                   FLD3
040800041028     c                   eval      *in51 = *off
040900110414     c                   eval      *in55 = *off
041000980901     C                   ENDSR
041100980904      **--------------------------------------------**
041200980904     CSR   BLANK         BEGSR
041300000609     C                   MOVE      *BLANKS       FNAME            12
041400000609     C                   MOVE      *BLANKS       LNAME            18
041500200204     C                   MOVE      *BLANKS       NAME
041501200204     C                   MOVE      *BLANKS       NAME_O
041600980904     C                   MOVE      *BLANKS       DNAME
041700980904     C                   MOVE      *BLANKS       FLD1
041800980904     C                   MOVE      *BLANKS       FLD2
041900980904     C                   ENDSR
042000010814
042100010814      *****************************************************************
042200010814      * REARRANGE DATE FROM MMDDCCYY TO CCYYMMDD
042300010814      *****************************************************************
042400981217     C     #MDCY8        BEGSR
042500981217     C                   MOVEL     MDCY#         MMDD#             4
042600981217     C                   MOVE      MDCY#         CCYY#             4
042700981217     C                   MOVE      MMDD#         CYMD#             8
042800981217     C                   MOVEL     CCYY#         CYMD#
042900981217     C                   ENDSR
0429012002040103  ***************************************************
0429022002040104  * check for EBS account.
0429032002040105  ***************************************************
0429042002040106   begsr #chkebs;
042905200204
042909200204
042910200204       clear ebsacct;
042911200204       clear msg;
042912200204
042913200204       parmebstsa = %editc(trust:'X') + %editc(sub:'X') +
042914200204                    %editc(acct:'X');
042915200204       clear parmebsyn;
042916200204
042917200204     c                   call      'GETEBSCL'
042918200204     c                   parm                    parmebstsa
042919200204     c                   parm                    parmebsyn
042927200204
042928200204      * show EBS message
042929200204       if parmebsyn = 'Y';
042930200204        ebsacct = 'Y';
042931200204        msg = ebsmsg;
042932200204       endif;
042936200204
0429372002040106   endsr;
042938200204
042939200204
043000981217     C*****************************************************************
043100980903**
04320098090301JANUARY
04330098090302FEBRUARY
04340098090303MARCH
04350098090304APRIL
04360098090305MAY
04370098090306JUNE
04380098090307JULY
04390098090308AUGUST
04400098090309SEPTEMBER
04410098090310OCTOBER
04420098090311NOVEMBER
04430098090312DECEMBER
