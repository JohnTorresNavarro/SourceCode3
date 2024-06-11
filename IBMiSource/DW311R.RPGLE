000100140214     Hoption(*nodebugio) debug dftactgrp(*no) actgrp(*caller)
000200140611     Hbnddir('ALLSRVPGMN')
000300140214
000400000000      *_________________________________________________________________________
000500000000      *
000600000000      *  Description:  Delegated Billing Electronic Enrollment
000700000000      *
000800000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000900000000      *
001000000000      *    Created by:  JALLEN - October 24, 2002
001100131010      *
001200131010      * 10/10/13 sbt - hist file expansion project
001300190111      *
001400190111      * 01/11/19 jon - use dependent address (could be different) ja01
001500191001      *
001600191001      * 10/01/19 jon - added relationship code GC (Grandchildren) ja02
001700000000      *_________________________________________________________________________
001800021024      *
001900021106     FDW310JF   IP   E           K DISK    Infds(DBFD)
002000090326     FTRNMIT    UF   E             DISK    Rename(TRNMIR:TRNUPD)
002100111115     FWEBTRNMIT UF   E           K DISK
002200081111     FACCMST    IF   E           K DISK    Prefix(N_)
002300081111     FAC2MST    IF   E           K DISK    Prefix(A_)
002400081111     FMEMALT    IF   E           K DISK
002500021111     FCLASS     IF   E           K DISK    Prefix(C_)
002600021204     FDW310LF   IF   E           K DISK    Prefix(X_) rename(dw310r:dwlf)
002700021213     FDW310L2   IF   E           K DISK    Prefix(X_)
002800021213     FDW310PF   IF   E           K DISK    Prefix(X_) rename(dw310r:dwpf)
002900081113     FMEMBER    IF   E           K DISK    Prefix(M_)
003000081113     FDEPNDC    IF   E           K DISK    Prefix(D_)
003100090403     FPCPL1     IF   E           K DISK    Prefix(V_)
003200090421     FGRAT24    IF   E           K DISK    Prefix(G_)
003300091104     FACCMSP    IF   E           K DISK
003400141210     FPLNMST    IF   E           K DISK
003500180516     FCFSDENP   IF   E           K DISK
003600141210     FPLNAUXP   IF   E           K DISK
003700140407     FCFS100P   IF   E           K DISK
003800091207     FHIST      O  A E           K DISK    Prefix(H_)
003900100816     FDW311TRK  IF A E           K DISK
004000121112     FDBTRAN834 O  A E             DISK
004100121112     FDW311RRN  UF A E           K DISK
004200121112     FDBEDTL834KO  A E             DISK    rename(DBEDTLD:SKIPR)
004300091027     FPRTDBEP   O    E             PRINTER oflind(*in91)
004400091027     FT2000     O  A E             DISK    RENAME(T2000:R2000)
004500091027     F                                     PREFIX(X_)
004600140214
004700140214      /define copy_all_protos_and_fields
004800140611      /copy qcpysrc,ACAsrvpgmp
004900140214      /undefine copy_all_protos_and_fields
005000140214
005100090409     D SKIPWRT         S              1A   INZ
005200090409     D RMVDEP1         S              1A   INZ
005300090409     D RMVDEP2         S              1A   INZ
005400090409     D RMVDEP3         S              1A   INZ
005500090409     D RMVDEP4         S              1A   INZ
005600090729      *
005700090730     D TYP01           S              1A   INZ
005800090730     D TYP02           S              1A   INZ
005900090730     D TYP03           S              1A   INZ
006000090730     D TYP04           S              1A   INZ
006100090731      *
006200090806     D FM075           S              1A   INZ
006300090806      *
006400090731     D TR051           S              4A   INZ
006500090731     D TR052           S              4A   INZ
006600090731     D TR053           S              4A   INZ
006700090731     D TR054           S              4A   INZ
006800091027      *
006900091027     D WWNAM           S             30A   INZ
007000091027     D WWSD            S              1A   INZ
007100090731      *
007200130423     D LEN2            S              2S 0 INZ
007300130423      *
007400110708     D DEP#            S              2A   DIM(99)
007500090326     D DEPN            S              2S 0 INZ
007600090326     D SENDDEP         S              1    INZ('Y')
007700090813     D PLNGRP          S             15A   INZ
007800090813     D KING            S             80A   INZ
007900120611     D DEMONLY         S              1    INZ
008000090618      *
008100090813     D P_SSN           S              9A
008200090813     D P_SEQ           S              2A
008300090618     D P_ORG           S              8A
008400090811     D P_PLN           S              4A
008500090811     D P_CAT           S              3A
008600091207     D P_FLG           S              1A
008700091207     D P_GRP           S             20A
008800090827     D R_FLG           S              1A
008900090824     D P_EFF           S              8A
009000091109     D U_FLG           S              1A
009100110720     D Q_SSN           S              9A
009200110720     D Q_SEQ           S              2A
009300100209     D Q_FLG           S              1A
009400100209     D Q_GRP           S              1A
009500090811      *
009600090811     D P_CATM          S              1A
009700090811     D P_CATR          S              1A
009800090811     D P_CATV          S              1A
009900090811     D P_CATD          S              1A
010000091124      *
010100091124     D T_PLNM          S              4A
010200091124     D T_PLNR          S              4A
010300091124     D T_PLNV          S              4A
010400091124     D T_PLND          S              4A
010500160224     D DNFPLN          S              4A
010600091112      *
010700091112     D U_CATM          S              1A
010800091112     D U_CATR          S              1A
010900091112     D U_CATV          S              1A
011000091112     D U_CATD          S              1A
011100021029      *
011200021216     D ISO_DATE        S               D   DATFMT(*ISO)
011300090428    ?D ISOTODAY        S               D   datfmt(*ISO)
011400090428      *
011500090729     D W3ORGEF         s              8s 0
011600090428     D REDATE          s              8s 0
011700120821     D TODAY           s              8s 0
011800120821     D WTODAY          s             10a
011900120821     D W80DATE         s              8s 0
012000120821     D W8ADATE         s             10a
012100090428     D CURYER          s              4s 0
012200090428     D CURMTH          s              2s 0
012300090428     D NXTMTH          s              2s 0
012400090428     D RENMTH          s              2s 0
012500090428     D RENMON          s              2s 0
012600090428     D RENDAY          s              2s 0
012700110330     D RENYER          s              4s 0
012800021216      *
012900090421     D MSPDATE         s             10A   inz
013000090825     D MbrChg          s              1A   inz
013100090825     D MbrTyp          s              1A   inz
013200090330     D Axt             s              2S 0 inz
013300090330     D Pxt             s              2S 0 inz
013400090320     D Nxt             s              2S 0 inz
013500091014     D Pss             s              2S 0 inz
013600090403     D Pqq             s              2S 0 inz
013700090515     D Pms             s              2S 0 inz
013800090515     D Pre             s              2S 0 inz
013900090330     D Pxs             s              2S 0 inz
014000090326     D Pos             s              2S 0 inz
014100090326     D Pod             s              2S 0 inz
014200090501     D Mdc             s              2S 0 inz
014300090501     D Ddc             s              2S 0 inz
014400090828     D Mac             s              2S 0 inz
014500090828     D Mma             s              2S 0 inz
014600090402     D X               s              2S 0 inz
014700090402     D N               s              2S 0 inz
014800090803     D aaa             s              2S 0 inz
014900090803     D bbb             s              2S 0 inz
015000090331     D cdc             s              2S 0 inz
015100030612     D Count           s              2S 0 inz
015200090520     D P_TERMDT        S              8S 0 inz
015300070125     D T_TERMDT        S              8S 0 inz
015400021112     D W_DRELCD        S              2    inz
015500021111     D W_COVT          S              2    inz
015600021209     D W_CAT           S              3    inz
015700021209     D W_NAME6         S              6    inz
015800021209     D W_FFFFFF        S              1    inz('F')
015900021206     D W_IN_ONLY       S              1    inz('N')
016000021206     D W_TM_ONLY       S              1    inz('N')
016100021111     D W_COVTP         S                   LIKE(X_DWCOVT) inz('TNA')
016200021029     D W_SEVT          S                   LIKE(D3SEVT1) inz
016300090326     D W_SFAM          S                   LIKE(D3SFAM1) inz
016400090326     D W_FILL          S                   LIKE(D3FIL41) inz
016500021104     D W_SSN#          S                   LIKE(V_PCSSN) inz
016600021112     D W_SPCD          S                   LIKE(V_PCSPCD) inz
016700021112     D W_SFX#          S                   LIKE(V_PCDSEQ) inz
016800021203     D W_DEPSSN        S                   LIKE(SOCSOC) inz
016900021203     D W_SEQ           S                   LIKE(D_DPSEQ#) inz
017000090326     D W_DEPTRM        S                   LIKE(X_DWENRL) inz
017100100121     D W_TRSEQ#        S             10s 0 inz
017200021111      *
017300081112     D D3SCAT_W        S                   LIKE(D3SCAT1) inz
017400081112     D D3SLVL_W        S                   LIKE(D3SLVL1) inz
017500081111     D D3SCEF_W        S                   LIKE(D3SCEF1) inz
017600081111     D D3SCTR_W        S                   LIKE(D3SCTR1) inz
017700021111     D D3SEVT_W        S                   LIKE(D3SEVT1) inz
017800090326     D D3SFAM_W        S                   LIKE(D3SFAM1) inz
017900090428     D D3FILL_W        S                   LIKE(D3FIL41) inz
018000090731      *
018100110708     D W_PGM           DS                  OCCURS(99)
018200110708     D APGM                    1    396A   DIM(99)
018300021112      *
018400110708     D W_PLANS         DS                  OCCURS(99)
018500110708     D APLN                    1    396A   DIM(99)
018600091015      *
018700110708     D W_CVTYP         DS                  OCCURS(99)
018800110708     D ACTY                    1    396A   DIM(99)
018900091104      *
019000110708     D W_CATYP         DS                  OCCURS(99)
019100110708     D ACAT                    1    396A   DIM(99)
019200090515      *
019300110708     D W_REEFF         DS                  OCCURS(99)
019400110708     D AEFF                    1    792S 0 DIM(99)
019500091001      *
019600110708     D W_RETRM         DS                  OCCURS(99)
019700110708     D ATRM                    1    792S 0 DIM(99)
019800090804      *
019900110708     D D_REEFF         DS                  OCCURS(99)
020000110708     D DEFF                    1    792S 0 DIM(99)
020100091001      *
020200110708     D D_RETRM         DS                  OCCURS(99)
020300110708     D DTRM                    1    792S 0 DIM(99)
020400090403      *
020500110708     D W_PCODS         DS                  OCCURS(99)
020600110708     D APCD                    1    198A   DIM(99)
020700091006      *
020800110708     D W_CODES         DS                  OCCURS(99)
020900110708     D ACOD                    1    198A   DIM(99)
021000091006      *
021100110708     D W_PCP           DS                  OCCURS(99)
021200110708     D APCP                    1     99A   DIM(99)
021300091028      *
021400110708     D W_DEMO          DS                  OCCURS(99)
021500110708     D ADEMO                   1     99A   DIM(99)
021600090827      *
021700110708     D W_OLD           DS                  OCCURS(99)
021800140416     D D4OLDFN                 1     25A
021900140416     D D4OLDLS                26     60A
022000140416     D D4OLDMI                61     61A
022100140416     D D4OLDBI                62     71A
022200090731      *
022300090731     D M_PGM           DS
022400110708     D MPGM                    1    396A   DIM(99)
022500090727      *
022600090727     D M_PLANS         DS
022700110708     D MPLN                    1    396A   DIM(99)
022800090323      *
022900090727     D M_REEFF         DS
023000110708     D MEFF                    1    792S 0 DIM(99)
023100090727      *
023200090323     D W_FILL37        DS
023300021112     D DEPEFFDT                       8    OVERLAY(W_FILL37)
023400021112     D DEPSCHOOL                     25    OVERLAY(W_FILL37:9)
023500021024      *
023600021025     D                 DS
023700021025     D ZIPCHAR                        9
023800021025     D W_ZIP                          9S 0 OVERLAY(ZIPCHAR) inz
023900021025      *
024000021025     D PHONECHAR       DS
024100021025     D W_AREA                         3S 0 OVERLAY(PHONECHAR) inz
024200021025     D W_PHONE                        7S 0 OVERLAY(PHONECHAR:4) inz
024300081111      *
024400090428     D                 DS
024500090731     D RENEWAL                        8S 0
024600090428     D R_Y                            4S 0 OVERLAY(RENEWAL) inz
024700090428     D R_M                            2S 0 OVERLAY(RENEWAL:5) inz
024800090428     D R_D                            2S 0 OVERLAY(RENEWAL:7) inz
024900081111     D                 DS
025000081111     D TSACHAR                       10
025100081111     D W_T                            3S 0 OVERLAY(TSACHAR) inz
025200081111     D W_S                            3S 0 OVERLAY(TSACHAR:4) inz
025300081111     D W_A                            4S 0 OVERLAY(TSACHAR:7) inz
025400090216     D                 DS
025500090216     D TSAC                          10
025600090216     D W_TC                           3S 0 OVERLAY(TSAC) inz
025700090216     D W_SC                           3S 0 OVERLAY(TSAC:4) inz
025800090216     D W_AC                           4S 0 OVERLAY(TSAC:7) inz
025900090421      *
026000090421     D                 DS
026100090421     D WCDATE                         8
026200090421     D WNDATE                         8S 0 OVERLAY(WCDATE:1) inz
026300090729      *
026400090729     D                 DS
026500090729     D WCORGEF                        8
026600090729     D WNORGEF                        8S 0 OVERLAY(WCORGEF:1) inz
026700021025      *
026800021024     D                 DS
026900021024     D MMDDYYYYHHMMSS                14S 0
027000021101     D MMDDYYYY                       8S 0 OVERLAY(MMDDYYYYHHMMSS:1) inz
027100021101     D MMDD                           4    OVERLAY(MMDDYYYYHHMMSS:1)
027200100816     D YY                             2    OVERLAY(MMDDYYYYHHMMSS:7)
027300021101     D HHMM                           4    OVERLAY(MMDDYYYYHHMMSS:9)
027400021101     D HHMMSS                         6S 0 OVERLAY(MMDDYYYYHHMMSS:9) inz
027500021024      *
027600090505     D EnrollmentDataE DS                  EXTNAME(DBEDTL834) inz
027700021024      *
027800070809     D WDTA          E DS                  EXTNAME(DEPEND) Prefix(D_)
027900070430      *
028000021106      * File DS
028100021106     D DBFD          E DS                  EXTNAME(IODBFD)
028200021106      * Program status data structure
028300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
028400030513
028500070213     D                UDS
028600070213     D  CONAME               201    240
028700000000      *
028800021028     IJOINR         01
028900090402     I                                          SOCSOC        L3
029000090402     I                                          DEPSEQ        L2
029100090320      * Reset Arrays
029200090402     C                   If        *INL3
029300100121     C                   Exsr      RESETL3
029400090320     C                   End
029500090402      * Seq Change
029600090402     C                   If        *INL2
029700090402     C                   Eval      axt = 0
029800090402     C                   Eval      pxt = 0
029900090402     C                   End
030000121112      * Update Trans
030100121112     C   01              Exsr      UpdateTranSR
030200090320      *
030300021024      *
030400090320     C   01              Exsr      TrapDataSR
030500090320      *
030600090313      * Enrollment
030700090402     CL3                 Exsr      ProcessSR
030800090320      *___________________________________________________________________
030900090320      * Trap Tranmit Data in Arrays
031000090320      *___________________________________________________________________
031100090320     C     TrapDataSR    BEGSR
031200160224
031300160224      * Save plan for DNF Dental check
031400160224     C                   eval      DNFPLN = PLAN#
031500160224
031600120611      * Dem Only
031700120611     C                   Select
031800120611     C                   When      DEMONLY = *blanks  and
031900120611     C                             ACTCOD =  'MD'
032000120611     C                   Eval      DEMONLY = 'Y'
032100120611     C                   When      ACTCOD <> 'MD'
032200120611     C                   Eval      DEMONLY = 'N'
032300120611     C                   Endsl
032400110708      * Seq Member
032500110708     C                   If        DEPSEQ = '00'
032600110708     C                   Eval      DEPSEQ = '  '
032700110708     C                   End
032800090323      * Seq
032900090320     C                   Select
033000090320     C                   When      DEPSEQ = ''
033100090320     C                   Eval      mbrchg = 'Y'
033200090320     C                   Other
033300090320     C                   Eval      pos = %lookup(DEPSEQ:DEP#)
033400090320     C                   If        pos = 0
033500090320     C                   Eval      nxt = nxt + 1
033600090320     C                   Eval      DEP#(nxt) = DEPSEQ
033700090320     C                   End
033800090320     C                   Endsl
033900090323      * Codes
034000090323     C                   If        DEPSEQ = ''
034100090330     C     20            occur     W_CODES
034200090731     C     20            occur     W_PGM
034300091015     C     20            occur     W_PLANS
034400091104     C     20            occur     W_CVTYP
034500091104     C     20            occur     W_CATYP
034600090403     C     20            occur     W_PCODS
034700090827     C     20            occur     W_REEFF
034800091006     C     20            occur     W_OLD
034900091028     C     20            occur     W_PCP
035000091028     C     20            occur     W_DEMO
035100090323     C                   Else
035200090323     C                   move      depseq        X
035300090330     C     X             occur     W_CODES
035400090731     C     X             occur     W_PGM
035500091015     C     X             occur     W_PLANS
035600091104     C     X             occur     W_CVTYP
035700091104     C     X             occur     W_CATYP
035800090403     C     X             occur     W_PCODS
035900090827     C     X             occur     W_REEFF
036000091006     C     X             occur     W_OLD
036100091028     C     X             occur     W_PCP
036200091028     C     X             occur     W_DEMO
036300090323     C                   End
036400090806
036500090806      * If FM075 the always ADD MEMBER
036600090806     C                   If        %trim(TRNSRC) = 'FM075'
036700090806     C                   Eval      FM075 = 'Y'
036800090806     C                   End
036900090330
037000090922      * If FM070 add mode force ADD MEMBER
037100090922     C                   If        %trim(TRNSRC) = 'FM070' and
037200090922     C                             ACTCOD =  'MA' and
037300090922     C                             OLNAME =  *BLANKS
037400090922     C                   Eval      FM075 = 'Y'
037500090331     C                   End
037600090922
037700090922      * Pre-Codes change to ADD COVG - MEMBER
037800090922     C                   If        ACTCOD =  'MA' and
037900090922     C                             OLNAME <> *BLANKS
038000090922     C                   Eval      ACTCOD =  'AC'
038100090922     C                   End
038200090828
038300090806      * TR050 Bug change to ADD COVG - MEMBER
038400090806     C                   If        ACTCOD =  'MA' and
038500090806     C                             %trim(TRNSRC) = 'TR050'
038600090806     C                   Eval      ACTCOD =  'AC'
038700090806     C                   End
038800090828
038900090828      * If MC check if prior ADD - MEMBER
039000090828     C                   If        ACTCOD =  'MC'
039100090828     C                   Eval      pos = %lookup(PLAN#:APLN)
039200090828     C                   If        pos > 0
039300090902     C                   If        APCD(pos) = 'MA'
039400090901     C                   Eval      ACTCOD =  'MA'
039500090828     C                   End
039600090902     C                   If        APCD(pos) = 'AC'
039700090902     C                   Eval      ACTCOD =  'AC'
039800090902     C                   End
039900090828     C                   End
040000090828     C                   End
040100090901
040200091104      * If MR check if prior MT - MEMBER - WASH OUT - SAME PLAN
040300090901     C                   If        ACTCOD =  'MR'
040400090901     C                   Eval      pos = %lookup(PLAN#:APLN)
040500090901     C                   If        pos > 0
040600090901     C                   If        APCD(pos) = 'MT' and
040700091001     C                             AEFF(pos) = ENRLDT or
040800091001     C                             APCD(pos) = 'MT' and
040900091001     C                             ATRM(pos) = ENRLDT
041000091015     C                   If        ACTY(pos) = MCVTYP
041100090901     C                   Eval      APLN(pos) = *blanks
041200090901     C                   Eval      APCD(pos) = *blanks
041300091001     C                   Eval      AEFF(pos) = *zeros
041400091001     C                   Eval      ATRM(pos) = *zeros
041500091001     C                   Eval      DEFF(pos) = *zeros
041600091001     C                   Eval      DTRM(pos) = *zeros
041700090901     C                   Eval      APGM(pos) = *blanks
041800090901     C                   Eval      ACTCOD = *blanks
041900090901     C                   Eval      PLAN#  = *blanks
042000091015     C                   Else
042100091015     C                   Eval      ACTCOD = 'MC'
042200091015     C                   Eval      APCD(pos) = 'MC'
042300091029     C                   Eval      AEFF(pos) = ENRLDT
042400091015     C                   End
042500090901     C                   End
042600090901     C                   End
042700090901     C                   End
042800091207
042900091207      * If MT check if prior MR - MEMBER - WASH OUT - SAME PLAN
043000091207     C                   If        ACTCOD =  'MT'
043100091207     C                   Eval      pos = %lookup(PLAN#:APLN)
043200091207     C                   If        pos > 0
043300091207     C                   If        APCD(pos) = 'MR' and
043400091207     C                             AEFF(pos) = ENRLDT or
043500091207     C                             APCD(pos) = 'MR' and
043600091207     C                             ATRM(pos) = ENRLDT
043700091207     C                   If        ACTY(pos) = MCVTYP
043800091207     C                   Eval      APLN(pos) = *blanks
043900091207     C                   Eval      APCD(pos) = *blanks
044000091207     C                   Eval      AEFF(pos) = *zeros
044100091207     C                   Eval      ATRM(pos) = *zeros
044200091207     C                   Eval      DEFF(pos) = *zeros
044300091207     C                   Eval      DTRM(pos) = *zeros
044400091207     C                   Eval      APGM(pos) = *blanks
044500091207     C                   Eval      ACTCOD = *blanks
044600091207     C                   Eval      PLAN#  = *blanks
044700091207     C                   Else
044800091207     C                   Eval      ACTCOD = 'MC'
044900091207     C                   Eval      APCD(pos) = 'MC'
045000091207     C                   Eval      AEFF(pos) = ENRLDT
045100091207     C                   End
045200091207     C                   End
045300091207     C                   End
045400091207     C                   End
045500091104
045600091104      * If MR check if prior MT - MEMBER - CHANGE - SAME CATEGORY
045700091104     C                   If        ACTCOD =  'MR'
045800091104     C                   Exsr      GetPlanCat
045900091104     C                   Eval      pos = %lookup(PLNCAT:ACAT)
046000091104     C                   If        pos > 0
046100091104     C                   If        APCD(pos) = 'MT' and
046200091104     C                             AEFF(pos) = ENRLDT or
046300091104     C                             APCD(pos) = 'MT' and
046400091104     C                             ATRM(pos) = ENRLDT
046500091104     C                   Eval      APLN(pos) = *blanks
046600091104     C                   Eval      APCD(pos) = *blanks
046700091104     C                   Eval      AEFF(pos) = *zeros
046800091104     C                   Eval      ATRM(pos) = *zeros
046900091104     C                   Eval      DEFF(pos) = *zeros
047000091104     C                   Eval      DTRM(pos) = *zeros
047100091104     C                   Eval      APGM(pos) = *blanks
047200091104     C                   Eval      ACAT(pos) = *blanks
047300091104     C                   Eval      ACTCOD = 'MC'
047400091104     C                   End
047500091104     C                   End
047600091104     C                   End
047700091208
047800091208      * If MA check if prior MT - MEMBER - CHANGE - SAME CATEGORY
047900091208     C                   If        ACTCOD =  'MA'
048000091208     C                   Exsr      GetPlanCat
048100091208     C                   Eval      pos = %lookup(PLNCAT:ACAT)
048200091208     C                   If        pos > 0
048300091208     C                   If        APCD(pos) = 'MT' and
048400091208     C                             AEFF(pos) = ENRLDT or
048500091208     C                             APCD(pos) = 'MT' and
048600091208     C                             ATRM(pos) = ENRLDT
048700091208     C                   Eval      APLN(pos) = *blanks
048800091208     C                   Eval      APCD(pos) = *blanks
048900091208     C                   Eval      AEFF(pos) = *zeros
049000091208     C                   Eval      ATRM(pos) = *zeros
049100091208     C                   Eval      DEFF(pos) = *zeros
049200091208     C                   Eval      DTRM(pos) = *zeros
049300091208     C                   Eval      APGM(pos) = *blanks
049400091208     C                   Eval      ACAT(pos) = *blanks
049500091208     C                   Eval      ACTCOD = 'MC'
049600091208     C                   End
049700091208     C                   End
049800091208     C                   End
049900091014
050000091014      * If MT check if prior AC - MEMBER - WASH OUT (SAME DAY TERM)
050100091014     C                   If        ACTCOD =  'MT'
050200091014     C                   Eval      pos = %lookup(PLAN#:APLN)
050300091014     C                   If        pos > 0
050400091014     C                   If        APCD(pos) = 'AC' and
050500091014     C                             AEFF(pos) = ENRLDT and
050600091014     C                             CANCDT    = ENRLDT
050700091014     C                   Eval      APLN(pos) = *blanks
050800091014     C                   Eval      APCD(pos) = *blanks
050900091014     C                   Eval      AEFF(pos) = *zeros
051000091014     C                   Eval      ATRM(pos) = *zeros
051100091014     C                   Eval      DEFF(pos) = *zeros
051200091014     C                   Eval      DTRM(pos) = *zeros
051300091014     C                   Eval      APGM(pos) = *blanks
051400091014     C                   Eval      ACTCOD = *blanks
051500091014     C                   Eval      PLAN#  = *blanks
051600091014     C                   End
051700091014     C                   End
051800091014     C                   End
051900090901
052000090901      * If DR check if prior DT - DEPENDENT - WASH OUT
052100090901     C                   If        ACTCOD =  'DR'
052200090901     C                   Eval      pos = %lookup(PLAN#:APLN)
052300090901     C                   If        pos > 0
052400090901     C                   If        APCD(pos) = 'DT' and
052500091001     C                             DEFF(pos) = DENRLD or
052600091001     C                             APCD(pos) = 'DT' and
052700091001     C                             DTRM(pos) = DENRLD
052800090901     C                   Eval      APLN(pos) = *blanks
052900090901     C                   Eval      APCD(pos) = *blanks
053000091001     C                   Eval      AEFF(pos) = *zeros
053100091001     C                   Eval      ATRM(pos) = *zeros
053200091001     C                   Eval      DEFF(pos) = *zeros
053300091001     C                   Eval      DTRM(pos) = *zeros
053400090901     C                   Eval      APGM(pos) = *blanks
053500090901     C                   Eval      ACTCOD = *blanks
053600090901     C                   Eval      PLAN#  = *blanks
053700090901     C                   End
053800090901     C                   End
053900090901     C                   End
054000091104
054100091104      * If DR check if prior DT - MEMBER - CHANGE - SAME CATEGORY
054200091104     C                   If        ACTCOD =  'DR'
054300091104     C                   Exsr      GetPlanCat
054400091104     C                   Eval      pos = %lookup(PLNCAT:ACAT)
054500091104     C                   If        pos > 0
054600091104     C                   If        APCD(pos) = 'DT' and
054700091104     C                             AEFF(pos) = DENRLD or
054800091104     C                             APCD(pos) = 'DT' and
054900091104     C                             ATRM(pos) = DENRLD
055000091104     C                   Eval      APLN(pos) = *blanks
055100091104     C                   Eval      APCD(pos) = *blanks
055200091104     C                   Eval      AEFF(pos) = *zeros
055300091104     C                   Eval      ATRM(pos) = *zeros
055400091104     C                   Eval      DEFF(pos) = *zeros
055500091104     C                   Eval      DTRM(pos) = *zeros
055600091104     C                   Eval      APGM(pos) = *blanks
055700091104     C                   Eval      ACAT(pos) = *blanks
055800091104     C                   Eval      ACTCOD = 'DC'
055900091104     C                   End
056000091104     C                   End
056100091104     C                   End
056200091014
056300091014      * If DT check if prior AC - DEPEND - WASH OUT (SAME DAY TERM)
056400091014     C                   If        ACTCOD =  'DT'
056500091014     C                   Eval      pos = %lookup(PLAN#:APLN)
056600091014     C                   If        pos > 0
056700091014     C                   If        APCD(pos) = 'AC' and
056800091014     C                             AEFF(pos) = DENRLD and
056900091014     C                             DCANDT    = DENRLD
057000091029     C                   Eval      APLN(pos) = *blanks
057100091014     C                   Eval      APCD(pos) = *blanks
057200091014     C                   Eval      AEFF(pos) = *zeros
057300091014     C                   Eval      ATRM(pos) = *zeros
057400091014     C                   Eval      DEFF(pos) = *zeros
057500091014     C                   Eval      DTRM(pos) = *zeros
057600091014     C                   Eval      APGM(pos) = *blanks
057700091014     C                   Eval      ACTCOD = *blanks
057800091014     C                   Eval      PLAN#  = *blanks
057900091014     C                   End
058000091014     C                   End
058100091014     C                   End
058200090806
058300090730      * Pre-Codes change to ADD COVG - DEPENDENT
058400090730     C                   If        ACTCOD =  'DA' and
058500090804     C                             ODLNAM <> *BLANKS
058600090730     C                   Eval      ACTCOD =  'AC'
058700090730     C                   End
058800090930
058900090930      * Pre-Codes change to CHG COVG - DEPENDENT
059000090930      * KMAN FM-70 change
059100090930     C                   If        ACTCOD =  'DT' and
059200090930     C                             %trim(OLDT93) = 'C'
059300090930     C                   Eval      ACTCOD =  'DC'
059400090930     C                   End
059500090806
059600090806      * TR050 Bug change to ADD COVG - DEPENDENT
059700090806     C                   If        ACTCOD =  'DA' and
059800090806     C                             %trim(TRNSRC) = 'TR050'
059900090806     C                   Eval      ACTCOD =  'AC'
060000090806     C                   End
060100090902
060200090902      * If DC check if prior ADD - DEPENDENT
060300090902     C                   If        ACTCOD =  'DC'
060400090902     C                   Eval      pos = %lookup(PLAN#:APLN)
060500090902     C                   If        pos > 0
060600090902     C                   If        APCD(pos) = 'DA'
060700090902     C                   Eval      ACTCOD =  'DA'
060800090902     C                   End
060900090902     C                   If        APCD(pos) = 'AC'
061000090902     C                   Eval      ACTCOD =  'AC'
061100090902     C                   End
061200090902     C                   End
061300090902     C                   End
061400090901
061500090901      * Ignore MD Plan Info
061600090901     C                   If        ACTCOD =  'MD'  and
061700090901     C                             %trim(TRNSRC) <> 'TR050'
061800090901     C                   Eval      ACTCOD = *blanks
061900090901     C                   Eval      PLAN#  = *blanks
062000091028     C                   Eval      ADEMO(1) = 'Y'
062100090901     C                   End
062200090929
062300090929      * Ignore DD Plan Info
062400090929     C                   If        ACTCOD =  'DD'  and
062500090929     C                             %trim(TRNSRC) <> 'TR050'
062600090929     C                   Eval      ACTCOD = *blanks
062700090929     C                   Eval      PLAN#  = *blanks
062800091028     C                   Eval      ADEMO(1) = 'Y'
062900090929     C                   End
063000090901
063100090901      * Ignore PC Plan Info
063200090901     C                   If        ACTCOD =  'PC'
063300090901     C                   Eval      ACTCOD = *blanks
063400090901     C                   Eval      PLAN#  = *blanks
063500091006     C                   Eval      APCP(1) = 'Y'
063600090901     C                   End
063700090805
063800090330      * Codes
063900090901     C                   If        %trim(ACTCOD) <> *BLANKS
064000090323     C                   Eval      pos = %lookup(ACTCOD:ACOD)
064100090323     C                   If        pos = 0
064200090323     C                   Eval      axt = axt + 1
064300090323     C                   Eval      ACOD(axt) = ACTCOD
064400090901     C                   End
064500090323     C                   End
064600090330      * Plans
064700090901     C                   If        %trim(PLAN#) <> *BLANKS
064800090330     C                   Eval      pos = %lookup(PLAN#:APLN)
064900090330     C                   If        pos = 0
065000090330     C                   Eval      pxt = pxt + 1
065100091015     C                   Eval      APLN(pxt) = PLAN#
065200091104     C                   Eval      ACTY(pxt) = MCVTYP
065300091104     C                   Exsr      GetPlanCat
065400091104     C                   Eval      ACAT(pxt) = PLNCAT
065500090515     C                   Eval      APCD(pxt) = ACTCOD
065600091001     C                   Eval      AEFF(pxt) = ENRLDT
065700091001     C                   Eval      ATRM(pxt) = CANCDT
065800091001     C                   Eval      DEFF(pxt) = DENRLD
065900091001     C                   Eval      DTRM(pxt) = DCANDT
066000090731     C                   Eval      APGM(pxt) = %trim(TRNSRC)
066100090407     C                   Else
066200091006     C                   If        APCP(1) <> 'Y'
066300090407     C                   Eval      APCD(pos) = ACTCOD
066400090409     C                   End
066500090901     C                   End
066600090330     C                   End
066700090827
066800090827      * Trap Demo Changes - Member
066900090827     C                   If        DEPSEQ = ''
067000090827      * Last Name
067100090827     C                   If        %trim(OLNAME) <> *BLANKS AND
067200090827     C                             %trim(LNAME)  <> *BLANKS AND
067300090827     C                             %trim(OLNAME) <> %trim(LNAME)
067400090827     C                   Eval      D4OLDLS = %trim(OLNAME)
067500090827     C                   End
067600090827      * First Name
067700090827     C                   If        %trim(OFNAME) <> *BLANKS AND
067800090827     C                             %trim(FNAME)  <> *BLANKS AND
067900090827     C                             %trim(OFNAME) <> %trim(FNAME)
068000090827     C                   Eval      D4OLDFN = %trim(OFNAME)
068100090827     C                   End
068200090827      * Middle Name
068300090827     C                   If        %trim(QQPGNM) <> 'TR050'
068400090827     C                   If        %trim(OMI) <> *BLANKS AND
068500090827     C                             %trim(OMI) <> %trim(MI) OR
068600090827     C                             %trim(OMI) =  *BLANKS AND
068700090827     C                             %trim(MI)  <> *BLANKS
068800090827     C                   If        %trim(OMI) = *blanks
068900090827     C                   Eval      D4OLDMI = '1'
069000090827     C                   else
069100090827     C                   Eval      D4OLDMI = %trim(OMI)
069200090827     C                   End
069300090827     C                   End
069400090827     C                   End
069500090827      * Birth Date
069600090827     C                   If        OBIRTH <> *ZEROS AND
069700090827     C                             BIRTH  <> *ZEROS AND
069800090827     C                             OBIRTH <> BIRTH
069900090827     C                   Movel     OBIRTH        Input_Date
070000090827     C                   Eval      Input_Format  = 'YYYYMMDD'
070100090827     C                   Eval      Output_Format = 'MM/DD/YYYY'
070200090827     C                   Exsr      FormatDateSR
070300090827     C                   Eval      D4OLDBI = %trim(Output_Date)
070400090827     C                   End
070500090827
070600090827      * Trap Demo Changes - Dependent
070700090827     C                   Else
070800090827      * Last Name
070900090827     C                   If        %trim(ODLNAM) <> *BLANKS AND
071000090827     C                             %trim(DLNAME) <> *BLANKS AND
071100090827     C                             %trim(ODLNAM) <> %trim(DLNAME)
071200090827     C                   Eval      D4OLDLS = %trim(ODLNAM)
071300090827     C                   End
071400090827      * First Name
071500090827     C                   If        %trim(ODFNAM) <> *BLANKS AND
071600090827     C                             %trim(DFNAME)  <> *BLANKS AND
071700090827     C                             %trim(ODFNAM) <> %trim(DFNAME)
071800090827     C                   Eval      D4OLDFN = %trim(ODFNAM)
071900090827     C                   End
072000090827      * Middle Name
072100090827     C                   If        %trim(QQPGNM) <> 'TR050'
072200090827     C                   If        %trim(ODMI) <> *BLANKS AND
072300090827     C                             %trim(ODMI) <> %trim(DMI) or
072400090827     C                             %trim(ODMI) =  *BLANKS AND
072500090827     C                             %trim(DMI)  <> *BLANKS
072600090827     C                   If        %trim(ODMI) = *blanks
072700090827     C                   Eval      D4OLDMI = '1'
072800090827     C                   else
072900090827     C                   Eval      D4OLDMI = %trim(ODMI)
073000090827     C                   End
073100090827     C                   End
073200090827     C                   End
073300090827      * Birth Date
073400090827     C                   If        ODBRTH <> *ZEROS AND
073500090827     C                             ODBRTH <> DBIRTH
073600090827     C                   Movel     ODBRTH        Input_Date
073700090827     C                   Eval      Input_Format  = 'YYYYMMDD'
073800090827     C                   Eval      Output_Format = 'MM/DD/YYYY'
073900090827     C                   Exsr      FormatDateSR
074000090827     C                   Eval      D4OLDBI = %trim(Output_Date)
074100090827     C                   End
074200090827
074300090827     C                   End
074400090330
074500090320     C                   ENDSR
074600090313      *___________________________________________________________________
074700090402      * Process at L3 Total Time
074800090313      *___________________________________________________________________
074900090313     C     ProcessSR     BEGSR
075000090313      *
075100090402     C     20            occur     W_CODES
075200090731     C     20            occur     W_PGM
075300091015     C     20            occur     W_PLANS
075400091104     C     20            occur     W_CVTYP
075500091104     C     20            occur     W_CATYP
075600090515     C     20            occur     W_PCODS
075700091027     C     20            occur     W_REEFF
075800091028     C     20            occur     W_PCP
075900091028     C     20            occur     W_DEMO
076000090402      *
076100090313     C                   Eval      W_TC =  TRUST
076200090313     C                   Eval      W_SC =  SUBNO
076300090313     C                   Eval      W_AC =  ACCNO
076400090313     C                   Exsr      EnrollmentSR
076500090313      *
076600090313     C                   ENDSR
076700021024      *___________________________________________________________________
076800021024      * Enrollment SR
076900021024      *___________________________________________________________________
077000021024     C     EnrollmentSR  BEGSR
077100021112      *
077200021112      * Reset Enrollment DS
077300021112     C                   Clear                   EnrollmentData
077400090323      *
077500090323      * Set to Member
077600090326     C                   eval      pod = 0
077700091006     C     20            occur     W_CODES
077800091028     C     20            occur     W_PCP
077900091028     C     20            occur     W_DEMO
078000090331      *
078100090331      * Count codes
078200090331     C                   eval      cdc = 0
078300090331     C     1             do        20            x
078400090331     C                   If        ACOD(x) <> *blanks
078500090331     C                   eval      cdc = cdc + 1
078600090331     C                   end
078700090331     C                   enddo
078800090323      *
078900090323      * Check if Add
079000090323     C                   Eval      pos = %lookup('MA':ACOD)
079100090331     C                   If        pos > 0   and
079200090331     C                             pos > pod
079300090323     C                   Eval      D3MNTYP = 'A'
079400090323     C                   Eval      D3MNRSN = '1'
079500090326     C                   eval      pod = pos
079600090323     C**                 Eval      D3MNRSN = 'MEMBER ADD   '
079700090323     C                   End
079800090401      *
079900090401      * Check if Term
080000090401     C                   Eval      pos = %lookup('MT':ACOD)
080100090401     C                   If        pos > 0  and
080200090401     C                             pos > pod and
080300090401     C                             cdc = 1
080400090401     C                   Eval      D3MNTYP = 'T'
080500090401     C                   Eval      D3MNRSN = '5'
080600090401     C                   eval      pod = pos
080700090401     C***                Eval      D3MNRSN = 'MEMBER TERM  '
080800090401     C                   End
080900090331      *
081000090331      * Check if Re-instatement
081100090331     C                   Eval      pos = %lookup('MR':ACOD)
081200090728     C                   If        pos > 0
081300090728     C*********                    pos > pod and
081400090728     C*********                    cdc = 1
081500090331     C                   Eval      *in95 = *on
081600090331     C                   Eval      D3MNTYP = 'R'
081700090331     C                   Eval      D3MNRSN = '3'
081800090331     C                   eval      pod = pos
081900090331     C**                 Eval      D3MNRSN = 'MEMBER REINSTATEMENT'
082000090331     C                   Else
082100090331     C                   Eval      *in95 = *off
082200090331     C                   End
082300090401      *
082400090401      * Check if Change
082500090401     C                   Eval      pos = %lookup('MC':ACOD)
082600090401     C                   If        pos > 0  and
082700090401     C                             pos > pod and
082800090401     C                             cdc = 1
082900090401     C                   Eval      D3MNTYP = 'C'
083000090401     C                   Eval      D3MNRSN = '7'
083100090401     C**                 Eval      D3MNRSN = 'CHANGE'
083200090401     C                   End
083300090402      *
083400090402      * Check if Change
083500090402     C                   Eval      pos = %lookup('ME':ACOD)
083600090402     C                   If        pos > 0  and
083700090402     C                             pos > pod and
083800090402     C                             cdc = 1
083900090402     C                   Eval      D3MNTYP = 'C'
084000090402     C                   Eval      D3MNRSN = '7'
084100090402     C**                 Eval      D3MNRSN = 'CHANGE'
084200090402     C                   End
084300090402      *
084400090403      * Check if Change (AC) Add Coverage
084500090402     C                   Eval      pos = %lookup('AC':ACOD)
084600090402     C                   If        pos > 0  and
084700090402     C                             pos > pod
084800090402     C                   Eval      D3MNTYP = 'C'
084900090403     C                   Eval      D3MNRSN = '7'
085000090402     C**                 Eval      D3MNRSN = 'CHANGE'
085100090402     C                   End
085200090401      *
085300091006      * Check if PCP Change Only
085400091028     C                   If        APCP(1) = 'Y'  and
085500091028     C                             cdc <= 1       or
085600091028     C                             ADEMO(1) = 'Y' and
085700091023     C                             cdc <= 1
085800090401     C                   Eval      D3MNTYP = 'C'
085900090401     C                   Eval      D3MNRSN = '7'
086000090401     C**                 Eval      D3MNRSN = 'PCP CHANGE'
086100090401     C                   End
086200090323      *
086300090323      * Check if Change
086400090401     C                   If        D3MNTYP = ' '
086500090323     C                   If        MBRCHG  = 'Y'
086600090323     C                   Eval      D3MNTYP = 'C'
086700090323     C                   Eval      D3MNRSN = '7'
086800090323     C**                 Eval      D3MNRSN = 'CHANGE'
086900090401     C                   End
087000090401     C                   End
087100090401      *
087200090401      * Check if NO-Change (override)
087300090401     C                   If        MBRCHG <> 'Y'
087400090323     C                   Eval      D3MNTYP = 'N'
087500090323     C                   Eval      D3MNRSN = '8'
087600090323     C**                 Eval      D3MNRSN = 'NO CHANGE'
087700090323     C                   End
087800021025      *
087900021030      * Process Current Member Info
088000021106     C     SocSoc        Chain     Member
088100021106     C                   If        not %Found
088200021106     C                   Clear                   Membr
088300021106     C                   Else
088400111005      *
088500111005      * Set Email if email
088600111005     C                   Movel     M_FILL66      EMAIL            65
088700111005     C                   If        %trim(EMAIL) <> *blanks
088800111005     C                   Eval      D3FIL15 = %trim(EMAIL)
088900111005     C                   Eval      D3FIL12 = *blanks
089000111005     C                   Else
089100111005     C                   Eval      D3FIL15 = *blanks
089200111005     C                   Eval      D3FIL12 = *blanks
089300111005     C                   End
089400110218      *
089500110218      * If Non-SSN, set flag
089600110218     C                   Move      M_FILL66      NONSSN            1
089700110218     C                   If        NONSSN = 'Y'
089800110218     C                   Eval      D3FIL3 = 'Y'
089900110218     C                   Else
090000110218     C                   Eval      D3FIL3 = *blanks
090100110218     C                   End
090200021106      *
090300021106      * Fill Subscriber Data on Add or Demographic Change
090400021106     C                   Eval      D3ADR1   =    %trim(M_ADDR1)
090500021106     C                   Eval      D3ADR2   =    %trim(M_ADDR2)
090600021106     C                   Eval      D3CITY   =    %trim(M_CITY)
090700021106     C                   Eval      D3STAT   =    %trim(M_STATE)
090800021106     C                   Z-Add     M_Zip         W_Zip
090900021106     C                   Eval      D3ZIPC   =    %trim(ZIPCHAR)
091000021106     C                   Eval      D3CNTY   =    *BLANKS
091100160201      *
091200160201      * ONLY EMPLOY(EE) SHOP GETS SPLIT
091300160201     C                   If        %trim(CARRCD) = 'EBP' or
091400160201     C                             %trim(CARRCD) = 'ECD' or
091500160201     C                             %trim(CARRCD) = 'EHB' or
091600160201     C                             %trim(CARRCD) = 'EHC' or
091700160201     C                             %trim(CARRCD) = 'EHM'
091800160201     C                   Eval      D3CNTR = 'SC'
091900160201     C                   else
092000160201     C                   Eval      D3CNTR = *blanks
092100160201     C                   end
092200160201      *
092300160201      *
092400070307      * If 0 send blanks
092500070307     C                   If        M_Phone <> 0
092600021106     C                   Z-Add     M_Area        W_Area
092700021106     C                   Z-Add     M_Phone       W_Phone
092800021106     C                   Eval      D3HOME   =    %trim(PHONECHAR)
092900070307     C                   Else
093000070307     C                   Z-Add     0             W_Area
093100070307     C                   Z-Add     0             W_Phone
093200070307     C                   Eval      D3HOME   =    *blanks
093300070307     C                   End
093400081111      *
093500081111      * Get the Member Employment Status
093600081111     C                   Eval      D3EMPST = M_EMPST
093700081111      *
093800081111      * Get the Member Salary
093900081111     C                   Eval      D3SALAR = M_SALARY
094000021106      *
094100021106      * Get the Member Coverages
094200021203     C                   Eval      W_SEQ  =   0
094300021106     C                   Exsr      GetPlanMaster
094400021106      *
094500021106      * Member Enrollment Date (MEMBER) to Sub-Group Effect Date
094600021202     C                   Eval      D3SGRE        = D3CLSE
094700021106      *
094800021106      * Member Employment Date (MEMBER) to Subcriber Hire Date
094900021106     C                   Movel     M_EMPDT       Input_Date
095000021106     C                   Eval      Input_Format  = 'YYYYMMDD'
095100021106     C                   Eval      Output_Format = 'MM/DD/YYYY'
095200021106     C                   Exsr      FormatDateSR
095300021106     C                   Eval      D3HIRE        = %trim(Output_Date)
095400021211      *
095500031113      * Term Date (MEMBER) else Same Day Term.
095600031113     C                   If        M_TERMDT <>   *ZEROS
095700031113     C                   If        M_TERMDT <>   M_MBENRL
095800021216     C     *YMD          MOVE      M_TERMDT      ISO_DATE
095900021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
096000070129     C     *ISO          MOVE      ISO_DATE      T_TERMDT
096100070125     C                   Movel     T_TERMDT      Input_Date
096200021216     C                   Eval      Input_Format  = 'YYYYMMDD'
096300021211     C                   Eval      Output_Format = 'MM/DD/YYYY'
096400021211     C                   Exsr      FormatDateSR
096500021211     C                   Eval      D3TRMDT       = %trim(Output_Date)
096600021211     C                   Eval      D3TRMR        = 'SBUN'
096700110830     C                   Move      '00'          Q_SEQ
096800110330     C                   Exsr      DECEASED
096900081112     C****CLAIR********  Exsr      ResetCovg
097000031113     C                   Else
097100070125     C                   Movel     M_TERMDT      Input_Date
097200031113     C                   Eval      Input_Format  = 'YYYYMMDD'
097300031113     C                   Eval      Output_Format = 'MM/DD/YYYY'
097400031113     C                   Exsr      FormatDateSR
097500031113     C                   Eval      D3TRMDT       = %trim(Output_Date)
097600031113     C                   Eval      D3TRMR        = 'SBER'
097700110830     C                   Move      '00'          Q_SEQ
097800110330     C                   Exsr      DECEASED
097900081112     C****CLAIR********  Exsr      ResetCovg
098000031113     C                   End
098100021211     C                   End
098200021106      *
098300021106      * Count Member No Dependents
098400060928     C**************     If        W_IN_ONLY = 'N'
098500060928     C                   Eval      D3NBRD   =    0
098600021111     C     SOCSOC        Setll     DEPNDC
098700021111     C     SOCSOC        Reade     DEPNDC                                 50
098800021106     C     *IN50         Doweq     *OFF
098900021106     C                   Eval      D3NBRD   =    D3NBRD + 1
099000021111     C     SOCSOC        Reade     DEPNDC                                 50
099100021106     C                   Enddo
099200060928     C**************     Else
099300060928     C**************     Eval      D3NBRD   =    0
099400060928     C**************     End
099500021112      *
099600021030      * Subscriber Indicative data
099700021112     C                   Eval      D3REL  = 'M'
099800021112     C                   Eval      D3LST    =    %trim(M_MLNAME)
099900021112     C                   Eval      D3FST    =    %trim(M_MFNAME)
100000021112     C                   Eval      D3MID    =    %trim(M_MMI)
100100021112     C                   Move      SOCSOC        D3SSN
100200021112     C                   Eval      D3SEX    =    %trim(M_SEX)
100300030826     C                   Eval      D3PHN    =    *BLANKS
100400021112     C                   Eval      D3MAR    =    *BLANKS
100500140407      *
100600140407      * Longer Name
100700140407     C     CFSKEY        klist
100800140407     C                   kfld                    cfssn
100900140407     C                   kfld                    cfseq
101000140407     C                   eval      cfssn = M_MBSSNO
101100140407     C                   eval      cfseq = 0
101200140407     C     CFSKEY        Chain     CFS100P
101300140407     C                   If        %Found(CFS100P)
101400140408     C                   If        %trim(CFSLST) <> *blanks
101500140407     C                   Eval      D3LST    =    %trim(CFSLST)
101600140408     C                   End
101700140408     C                   If        %trim(CFSFST) <> *blanks
101800140407     C                   Eval      D3FST    =    %trim(CFSFST)
101900140408     C                   End
102000140407     C                   End
102100081111      *
102200081111      * Alternate ID
102300081111     C     M_MBSSNO      Chain     MEMALT
102400081111     C                   If        %Found
102500081111     C                   Eval      D3ALTID = MAALTID
102600081111     C                   Else
102700081111     C                   Eval      D3ALTID = *BLANKS
102800081111     C                   End
102900081111      *
103000081111      * Account Name + TSA
103100131015     C                   Eval      D3TSA = TSAC
103200081111     C     WkAct         Chain     ACCMST
103300081111     C                   If        %Found
103400130423     C                   Eval      D3TSANM = %trim(N_ACNAM1)
103500130423     C                   Eval      D3ADR3   =    *BLANKS
103600130423     C                   If        N_ACNAM2 <> *blanks
103700130423     C                   Eval      LEN2 = %LEN(N_ACNAM2)
103800130423     C                   If        LEN2 > 3
103900130419     C                   Select
104000130424     C                   When      %subst(N_ACNAM2:1:3) = 'C/O'
104100130424     C                   Eval      D3ADR3   =    *BLANKS
104200130423     C                   When      %subst(N_ACNAM2:1:3) = 'T/A'
104300130419     C                   Eval      D3ADR3   =    *BLANKS
104400130423     C                   When      %subst(N_ACNAM2:1:3) = 'DBA'
104500130419     C                   Eval      D3ADR3   =    *BLANKS
104600130419     C                   Other
104700140424      * What the heck was this for???
104800140424     C***********        Eval      D3ADR3   =    %trim(N_ACNAM2)
104900130419     C                   Endsl
105000130423     C                   End
105100130423     C                   End
105200081111     C                   Else
105300081111     C                   Eval      D3TSANM = *BLANKS
105400130419     C                   Eval      D3ADR3   =    *BLANKS
105500081111     C                   End
105600090428      *
105700090428      * Check Renewal
105800090428     C                   Exsr      CheckRenewal
105900021202      *
106000021202      * Subscriber Status
106100021209     C     WkAcc         Chain     AC2MST
106200021202     C                   If        %Found
106300021209     C                   If        A_A2NCAPDT =  X_DWENRL
106400021209     C                   Eval      D3STS      =  'INIT'
106500021202     C                   Else
106600021209     C                   Eval      D3STS      =  'SUBS'
106700021202     C                   End
106800081111     C                   Eval      D3TAXID    =  A_A2TAX_ID#
106900021224     C                   Else
107000081111     C                   Eval      D3TAXID    =  *ZEROS
107100021224     C                   Eval      D3STS      =  'SUBS'
107200021202     C                   End
107300021112      *
107400090618      * Get Original CFS Effective Date (MEMBER)
107500090618     C                   Movel     M_MBSSNO      P_SSN
107600090618     C                   CALL      'DW311OCL'
107700090618     C                   PARM                    P_SSN
107800090618     C                   PARM                    P_ORG
107900090618
108000090618     C                   Movel     P_ORG         Input_Date
108100090609     C                   Eval      Input_Format  = 'YYYYMMDD'
108200090609     C                   Eval      Output_Format = 'MM/DD/YYYY'
108300090609     C                   Exsr      FormatDateSR
108400090609     C                   Eval      D3ORGEF       = %trim(Output_Date)
108500021112      *
108600021112      * Birth Date (MEMBER) to Birth Date
108700021112     C                   Movel     M_BIRTH       Input_Date
108800021112     C                   Eval      Input_Format  = 'YYYYMMDD'
108900021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
109000021112     C                   Exsr      FormatDateSR
109100021112     C                   Eval      D3BIRTH       = %trim(Output_Date)
109200021030      *
109300021112      * Subscriber Handicap data
109400021112     C                   If        M_hndicp  <>  *Blanks
109500021112      * Effective (MEMBER)
109600021112     C                   Movel     M_HDCPDT      Input_Date
109700021112     C                   Eval      Input_Format  = 'YYYYMMDD'
109800021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
109900021112     C                   Exsr      FormatDateSR
110000021112     C                   Eval      D3HANEFF      = %trim(Output_Date)
110100021112      * Term (MEMBER)
110200021210     C                   If        M_TERMDT <>   *ZEROS
110300021216     C     *YMD          MOVE      M_TERMDT      ISO_DATE
110400021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
110500070129     C     *ISO          MOVE      ISO_DATE      T_TERMDT
110600070125     C                   Movel     T_TERMDT      Input_Date
110700021112     C                   Eval      Input_Format  = 'YYYYMMDD'
110800021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
110900021112     C                   Exsr      FormatDateSR
111000021112     C                   Eval      D3HANTRM      = %trim(Output_Date)
111100021112     C                   Eval      D3HANRES      = 'MHUN'
111200021210     C                   End
111300021112      *
111400021112     C                   Eval      D3HANDES      = %trim('DISABLED')
111500021112     C                   Eval      D3HANTYP      = 'P'
111600021112      *
111700021112     C                   End
111800021210      *
111900021210      * Subscriber Medicare data
112000021210     C                   If        M_MEDICR  <>  *Blanks  and
112100021210     C                             M_MEDICR  <>  'N'
112200190513      *
112300190513     C                   Eval      Pos    =  %scan('NONE':M_MED#)
112400190513     C                   If        Pos    >  0
112500190513     C                   eval      M_MED# = *BLANKS
112600190513     C                   End
112700190522     C                   Eval      Pos    =  %scan('None':M_MED#)
112800190522     C                   If        Pos    >  0
112900190522     C                   eval      M_MED# = *BLANKS
113000190522     C                   End
113100190513     C                   Eval      Pos    =  %scan('NO ':M_MED#)
113200190513     C                   If        Pos    >  0
113300190513     C                   eval      M_MED# = *BLANKS
113400190513     C                   End
113500190516     C                   Eval      Pos    =  %scan('No ':M_MED#)
113600190516     C                   If        Pos    >  0
113700190516     C                   eval      M_MED# = *BLANKS
113800190516     C                   End
113900190522     C                   Eval      Pos    =  %scan('no ':M_MED#)
114000190522     C                   If        Pos    >  0
114100190522     C                   eval      M_MED# = *BLANKS
114200190522     C                   End
114300190522     C                   Eval      Pos    =  %scan('N  ':M_MED#)
114400190522     C                   If        Pos    >  0
114500190522     C                   eval      M_MED# = *BLANKS
114600190522     C                   End
114700190522     C                   Eval      Pos    =  %scan('n  ':M_MED#)
114800190522     C                   If        Pos    >  0
114900190522     C                   eval      M_MED# = *BLANKS
115000190522     C                   End
115100190513     C                   Eval      Pos    =  %scan('NA ':M_MED#)
115200190513     C                   If        Pos    >  0
115300190513     C                   eval      M_MED# = *BLANKS
115400190513     C                   End
115500190513     C                   Eval      Pos    =  %scan('N/A ':M_MED#)
115600190513     C                   If        Pos    >  0
115700190513     C                   eval      M_MED# = *BLANKS
115800190513     C                   End
115900190513     C                   Eval      Pos    =  %scan('YES ':M_MED#)
116000190513     C                   If        Pos    >  0
116100190513     C                   eval      M_MED# = *BLANKS
116200190513     C                   End
116300190522     C                   Eval      Pos    =  %scan('Yes ':M_MED#)
116400190522     C                   If        Pos    >  0
116500190522     C                   eval      M_MED# = *BLANKS
116600190522     C                   End
116700190522     C                   Eval      Pos    =  %scan('Y   ':M_MED#)
116800190522     C                   If        Pos    >  0
116900190522     C                   eval      M_MED# = *BLANKS
117000190522     C                   End
117100190522     C                   Eval      Pos    =  %scan('y   ':M_MED#)
117200190522     C                   If        Pos    >  0
117300190522     C                   eval      M_MED# = *BLANKS
117400190522     C                   End
117500190522     C                   if        M_MED# <> *blanks
117600190522     C                   Eval      LEN2 = %LEN(%trim(M_MED#))
117700190522     C                   If        LEN2 < 10
117800190522     C                   eval      M_MED# = *BLANKS
117900190522     C                   End
118000190522     C                   End
118100021210      *
118200021210      * Find the - or & and pull it out.
118300021210     C                   Eval      Pos    =  %scan('-':M_MED#)
118400021210     C                   If        Pos    =  0
118500021210     C                   Eval      Pos    =  %scan('&':M_MED#)
118600021210     C                   End
118700021210      *
118800021210     C                   If        Pos    =  0
118900021210     C                   Eval      D3HICN =  %trim(M_MED#)
119000021210     C                   Else
119100021210     C                   Eval      D3HICN= %replace(%subst(M_MED#:pos+1:13-pos):
119200021210     C                             M_MED#:pos)
119300021210     C                   End
119400021210      * Medicare Eff-A (MEMBER)
119500021210     C                   If        M_MEDADT <>   *ZEROS
119600021210     C                   Movel     M_MEDADT      Input_Date
119700021210     C                   Eval      Input_Format  = 'YYYYMMDD'
119800021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
119900021210     C                   Exsr      FormatDateSR
120000081112     C                   Eval      D3MEDEFF      = *BLANKS
120100021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
120200021210     C                   Eval      D3MEDEVT1     = 'PRTA'
120300021210     C                   End
120400021210      *
120500021210      * Medicare Eff-B (MEMBER)
120600021210     C                   If        M_MEDBDT <>   *ZEROS
120700021210     C                   Movel     M_MEDBDT      Input_Date
120800021210     C                   Eval      Input_Format  = 'YYYYMMDD'
120900021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
121000021210     C                   Exsr      FormatDateSR
121100081112     C                   Eval      D3MEDEFF      = *BLANKS
121200021210     C                   Eval      D3EVTEFF2     = %trim(Output_Date)
121300021210     C                   Eval      D3MEDEVT2     = 'PRTB'
121400021210     C                   End
121500021210     C                   End
121600021112      *
121700021112      * Subscriber Provider PCP data
121800021112     C                   Z-add     SOCSOC        W_SSN#
121900021112     C                   Z-add     *ZEROS        W_SFX#
122000021112     C                   Eval      W_SPCD    =   'MED'
122100021112     C                   Exsr      GetProvider
122200030523      *
122300030523      * COB Data
122400030523     C                   If        M_COB    = 'Y'
122500030523     C                   Eval      D3COBINF = 'Y'
122600030523     C                   Eval      D3COBFLG = 'Y'
122700030523     C                   Eval      D3COBCON = 'Y'
122800030523     C                   Eval      D3HLDNAM = %trim(M_COBENM)
122900030523     C                   Eval      D3OIPOLY = %trim(M_COBP#)
123000030523     C                   Eval      D3OINAME = %trim(M_MCOBPN)
123100030523     C                   Else
123200030523     C                   Eval      D3COBINF = 'N'
123300030523     C                   End
123400021112      *
123500021112      * Set Group Key elements
123600140214     C*************      Eval      D3PRN    =    *BLANKS
123700030611     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
123800021112     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
123900021112     C                   Move      SOCSOC        D3SUB
124000040304      *
124100040304      * Set Mod for Medicare IN.
124200040304     C                   If        W_COVT   =    'MI'
124300040304     C                   Eval      D3MOD    =    %trim(D3GRP) + 'M'
124400040304     C                   End
124500081112      *
124600081112      * Set Old/Saved Info.
124700090827     C     20            occur     W_OLD
124800081112      * Last Name
124900090827     C                   Eval      D3OLDLS = %trim(D4OLDLS)
125000081112      * First Name
125100090827     C                   Eval      D3OLDFN = %trim(D4OLDFN)
125200081112      * Middle Name
125300090827     C                   Eval      D3OLDMI = %trim(D4OLDMI)
125400081112      * Birth Date
125500090827     C                   Eval      D3OLDBI = %trim(D4OLDBI)
125600041130      *
125700041130      * If Reinstate, override dates
125800041130     C                   If        *in95 = *on
125900090727     C****               Exsr      ReinstateSR
126000041130     C                   End
126100090331      *
126200090326      * If Member Term (all coverages termed)
126300090326      * Don't send DEP.
126400090326     C                   Eval      SENDDEP  =   'Y'
126500090402     C                   If        (D3FIL41  =   *BLANKS OR
126600090402     C                             D3FIL41  =   'T')     AND
126700090402     C                             (D3FIL42  =   *BLANKS OR
126800090402     C                             D3FIL42  =   'T')     AND
126900090402     C                             (D3FIL43  =   *BLANKS OR
127000090402     C                             D3FIL43  =   'T')     AND
127100090402     C                             (D3FIL44  =   *BLANKS OR
127200090813     C                             D3FIL44  =   'T')     OR
127300090813     C                             (D3FIL41  =   *BLANKS OR
127400090813     C                             D3FIL41  =   'S')     AND
127500090813     C                             (D3FIL42  =   *BLANKS OR
127600090813     C                             D3FIL42  =   'S')     AND
127700090813     C                             (D3FIL43  =   *BLANKS OR
127800090813     C                             D3FIL43  =   'S')     AND
127900090813     C                             (D3FIL44  =   *BLANKS OR
128000090813     C                             D3FIL44  =   'S')
128100090409      * And at least one coverage termed
128200090409     C                   If        D3FIL41  = 'T' or
128300090409     C                             D3FIL42  = 'T' or
128400090409     C                             D3FIL43  = 'T' or
128500090813     C                             D3FIL44  = 'T' or
128600090813     C                             D3FIL41  = 'S' or
128700090813     C                             D3FIL42  = 'S' or
128800090813     C                             D3FIL43  = 'S' or
128900090813     C                             D3FIL44  = 'S'
129000090326     C                   Eval      SENDDEP  =   'N'
129100090331     C                   Eval      D3MNTYP = 'T'
129200090331     C                   Eval      D3MNRSN = '5'
129300090409     C                   End
129400090326     C                   End
129500090409      *
129600090409      * Override various 834 values
129700090421     C                   Exsr      Override834
129800110518      *
129900110518      * Check for Voids (again)
130000110518     C                   If        D3MNTYP = 'T'
130100110518     C                   If        D3FIL41 =  'S'
130200110518     C                   If        D3SCEF1 <> *Blanks  and
130300110518     C                             D3SCTR1 <> *Blanks  and
130400110518     C                             D3SCEF1 <> D3SCTR1
130500110518     C                   Movel     D3SCEF1       D3SCTR1
130600110518     C                   Movel     D3SCEF1       D3TRMDT
130700110518     C                   End
130800110518     C                   End
130900110518     C                   If        D3FIL42 =  'S'
131000110518     C                   If        D3SCEF2 <> *Blanks  and
131100110518     C                             D3SCTR2 <> *Blanks  and
131200110518     C                             D3SCEF2 <> D3SCTR2
131300110518     C                   Movel     D3SCEF2       D3SCTR2
131400110518     C                   Movel     D3SCEF2       D3TRMDT
131500110518     C                   End
131600110518     C                   End
131700110518     C                   If        D3FIL43 =  'S'
131800110518     C                   If        D3SCEF3 <> *Blanks  and
131900110518     C                             D3SCTR3 <> *Blanks  and
132000110518     C                             D3SCEF3 <> D3SCTR3
132100110518     C                   Movel     D3SCEF3       D3SCTR3
132200110518     C                   Movel     D3SCEF3       D3TRMDT
132300110518     C                   End
132400110518     C                   End
132500110518     C                   If        D3FIL44 =  'S'
132600110518     C                   If        D3SCEF4 <> *Blanks  and
132700110518     C                             D3SCTR4 <> *Blanks  and
132800110518     C                             D3SCEF4 <> D3SCTR4
132900110518     C                   Movel     D3SCEF4       D3SCTR4
133000110518     C                   Movel     D3SCEF4       D3TRMDT
133100110518     C                   End
133200110518     C                   End
133300110518     C                   End
133400130611      *
133500130611      * bugfix - dont skip write if #dep > 0
133600130611     C                   If        D3NBRD   >    0   and
133700130611     C                             SENDDEP  =   'Y'
133800130611     C                   Eval      SKIPWRT  =   'N'
133900130611     C                   End
134000091102      *
134100091102      * Skip write?
134200130611     C                   If        SKIPWRT  <>  'Y'
134300091102      *
134400021112     C                   Eval      D3SFX    =    '00'
134500100224     C                   Eval      D3HLD    =    'X'
134600100511     C                   Eval      D3FIL1   =    %trim(QQUSER)
134700100511     C                   Eval      D3FIL2   =    %trim(QQRVWR)
134800100816     C                   Eval      D3FIL10  =    MMDD + YY + HHMM
134900021112     C                   Eval      DB2150   =    EnrollmentData
135000021112     C                   Write     DBTRANR
135100100208     C  NU1              Exsr      PlanTracking
135200030612     C                   Exsr      CheckOverflow
135300030612     C                   Write     PRTDTL
135400091207     C                   Exsr      WRT834
135500030612     C                   Eval      Count = Count + 1
135600070131     C                   Clear                   DBTRANR
135700100204
135800100204      * Always Send Dependents from 834Tool
135900100204     C   U1              If        SENDDEP  =  'N'
136000100204     C   U1              Eval      SENDDEP  =  'Y'
136100100204     C                   End
136200100204      *
136300100204      * Process Dependents
136400090326     C                   If        SENDDEP = 'Y'
136500090320     C     DEPKEY        Klist
136600090320     C                   Kfld                    SOCSOC
136700090320     C                   Kfld                    DEPN
136800090402     C                   Eval      N = 0
136900090402     C     1             Do        Nxt           N
137000090402     C                   Move      DEP#(N)       DEPN
137100090323     C                   If        DEPN > 0
137200090323     C     DEPKEY        Chain     DEPNDC
137300090323     C                   If        %found(DEPNDC)
137400021112     C                   Exsr      ProcessDepSR
137500090323     C                   End
137600090323     C                   End
137700090323     C                   Enddo
137800090326     C                   End
137900091102      *
138000091102      *End skip write
138100121112     C                   Else
138200121112     C                   Write     SKIPR
138300121112      * If Skipping the write, remove RRN records so they dont getn BATIDs
138400121112      * and stay in the queue.
138500121112     C                   Move      D3SUB         QQSSN
138600121112     C     QQSSN         Setll     DW311RRN
138700121112     C     QQSSN         Reade     DW311RRN
138800121112     C                   Dow       not %eof(DW311RRN)
138900121112     C                   Delete    RRNR
139000121112     C     QQSSN         Reade     DW311RRN
139100121112     C                   Enddo
139200091102     C                   End
139300091102     C                   Clear                   DBTRANR
139400091102      *
139500090323     C                   End
139600021112     C                   ENDSR
139700021112      *___________________________________________________________________
139800021112      * Process Dependents SR
139900021112      *___________________________________________________________________
140000021112     C     ProcessDepSR  BEGSR
140100090813      *
140200100208     C                   Eval      SKIPWRT = 'N'
140300090813     C                   Eval      P_CATM  = *Blanks
140400090813     C                   Eval      P_CATR  = *Blanks
140500090813     C                   Eval      P_CATV  = *Blanks
140600090813     C                   Eval      P_CATD  = *Blanks
140700091124      *
140800091124     C                   Eval      T_PLNM  = *Blanks
140900091124     C                   Eval      T_PLNR  = *Blanks
141000091124     C                   Eval      T_PLNV  = *Blanks
141100091124     C                   Eval      T_PLND  = *Blanks
141200021112      *
141300100208     C                   Eval      U_CATM  = *Blanks
141400100208     C                   Eval      U_CATR  = *Blanks
141500100208     C                   Eval      U_CATV  = *Blanks
141600100208     C                   Eval      U_CATD  = *Blanks
141700100208      *
141800100208     C                   Eval      P_SSN = *Blanks
141900100208     C                   Eval      P_SEQ = *Blanks
142000100208     C                   Eval      P_ORG = *Blanks
142100100208     C                   Eval      P_PLN = *Blanks
142200100208     C                   Eval      P_CAT = *Blanks
142300100208     C                   Eval      P_FLG = *Blanks
142400100208     C                   Eval      P_GRP = *Blanks
142500100208     C                   Eval      R_FLG = *Blanks
142600100208     C                   Eval      P_EFF = *Blanks
142700100208     C                   Eval      U_FLG = *Blanks
142800100208      *
142900110330     C                   Eval      W_FILL37 =   %trim(D_FILL37)
143000021112      *
143100070202      * Reset Each Dep: Number Dependents & Term Info
143200021112     C                   Eval      D3NBRD   =    *ZEROS
143300070202     C                   Eval      D3TRMDT       = *blanks
143400070212     C                   Eval      D3TRMR        = *blanks
143500070212     C                   Eval      D3HIRE        = *blanks
143600090323     C                   Eval      D3MNTYP       = *blanks
143700110330     C                   Eval      D3MNRSN       = *blanks
143800111017     C                   Eval      D3FIL15 = *blanks
143900111017     C                   Eval      D3FIL12 = *blanks
144000090727      *
144100090727      * Save Member Plan/Eff Dates
144200090731     C     20            occur     W_PGM
144300090731     C                   eval      MPGM(1) = APGM(1)
144400090731     C                   eval      MPGM(2) = APGM(2)
144500090731     C                   eval      MPGM(3) = APGM(3)
144600090731     C                   eval      MPGM(4) = APGM(4)
144700090727     C     20            occur     W_PLANS
144800090727     C                   eval      MPLN(1) = APLN(1)
144900090727     C                   eval      MPLN(2) = APLN(2)
145000090727     C                   eval      MPLN(3) = APLN(3)
145100090727     C                   eval      MPLN(4) = APLN(4)
145200090727     C     20            occur     W_REEFF
145300090727     C                   eval      MEFF(1) = AEFF(1)
145400090727     C                   eval      MEFF(2) = AEFF(2)
145500090727     C                   eval      MEFF(3) = AEFF(3)
145600090727     C                   eval      MEFF(4) = AEFF(4)
145700090323      *
145800090323      * Set to Dependent
145900090326     C                   eval      pod = 0
146000090330     C     D_DPSEQ#      occur     W_CODES
146100090731     C     D_DPSEQ#      occur     W_PGM
146200091015     C     D_DPSEQ#      occur     W_PLANS
146300091104     C     D_DPSEQ#      occur     W_CVTYP
146400091104     C     D_DPSEQ#      occur     W_CATYP
146500090403     C     D_DPSEQ#      occur     W_PCODS
146600091006     C     D_DPSEQ#      occur     W_REEFF
146700091028     C     D_DPSEQ#      occur     W_PCP
146800091028     C     D_DPSEQ#      occur     W_DEMO
146900090401      *
147000090401      * Count codes
147100090401     C                   eval      cdc = 0
147200090401     C     1             do        20            x
147300090401     C                   If        ACOD(x) <> *blanks
147400090401     C                   eval      cdc = cdc + 1
147500090401     C                   end
147600090401     C                   enddo
147700090401      *
147800090401      * Check if Add
147900090401     C                   Eval      pos = %lookup('DA':ACOD)
148000090401     C                   If        pos > 0  and
148100090401     C                             pos > pod
148200090401     C                   Eval      D3MNTYP = 'A'
148300090401     C                   Eval      D3MNRSN = '2'
148400090401     C                   Eval      pod = pos
148500090401     C**                 Eval      D3MNRSN = 'DEPEND ADD   '
148600090401     C                   End
148700090401      *
148800090401      * Check if Term
148900090401     C                   Eval      pos = %lookup('DT':ACOD)
149000090401     C                   If        pos > 0  and
149100090401     C                             pos > pod
149200090401      * If truly termed
149300090401     C                   If        D_DPDLTD = 'C'
149400090401     C                   Eval      D3MNTYP = 'T'
149500090401     C                   Eval      D3MNRSN = '6'
149600090401     C                   Eval      pod = pos
149700090401     C**                 Eval      D3MNRSN = 'DEPEND TERM  '
149800090401     C                   Else
149900090401     C                   Eval      D3MNTYP = 'C'
150000090401     C                   Eval      D3MNRSN = '7'
150100090401     C**                 Eval      D3MNRSN = 'DEPEND CHANGE'
150200090401     C                   End
150300090401     C                   End
150400021203      *
150500090323      * Check if Re-instatement
150600090323     C                   Eval      pos = %lookup('DR':ACOD)
150700091029     C                   If        pos > 0  and
150800091029     C                             cdc = 1
150900090323     C                   Eval      *in95 = *on
151000090323     C                   Eval      D3MNTYP = 'R'
151100090323     C                   Eval      D3MNRSN = '4'
151200090326     C                   Eval      pod = pos
151300090323     C**                 Eval      D3MNRSN = 'DEPEND REINSTATEMENT'
151400090323     C                   Else
151500090323     C                   Eval      *in95 = *off
151600090323     C                   End
151700090323      *
151800090323      * Check if Change
151900090401     C                   Eval      pos = %lookup('DC':ACOD)
152000090401     C                   If        pos > 0  and
152100090401     C                             pos > pod and
152200090401     C                             cdc = 1
152300090323     C                   Eval      D3MNTYP = 'C'
152400090323     C                   Eval      D3MNRSN = '7'
152500090323     C**                 Eval      D3MNRSN = 'DEPEND CHANGE'
152600090323     C                   End
152700090427      *
152800090427      * Check if DEMO Change
152900090427     C                   Eval      pos = %lookup('DD':ACOD)
153000090427     C                   If        pos > 0  and
153100090427     C                             pos > pod and
153200091023     C                             cdc = 0
153300090427     C                   Eval      D3MNTYP = 'C'
153400090427     C                   Eval      D3MNRSN = '7'
153500090427     C**                 Eval      D3MNRSN = 'DEPEND DEMO CHANGE'
153600090427     C                   End
153700090401      *
153800090401      * Check if PCP Change
153900091028     C                   If        APCP(1) = 'Y'  and
154000091028     C                             cdc = 0        or
154100091028     C                             ADEMO(1) = 'Y' and
154200091023     C                             cdc = 0
154300090401     C                   Eval      D3MNTYP = 'C'
154400090401     C                   Eval      D3MNRSN = '7'
154500090401     C**                 Eval      D3MNRSN = 'PCP CHANGE'
154600090401     C                   End
154700090730      *
154800090730      * Check if Change (AC) Add Coverage
154900090730     C                   Eval      pos = %lookup('AC':ACOD)
155000090730     C                   If        pos > 0  and
155100090730     C                             pos > pod
155200090730     C                   Eval      D3MNTYP = 'C'
155300090730     C                   Eval      D3MNRSN = '7'
155400090730     C**                 Eval      D3MNRSN = 'CHANGE'
155500090730     C                   End
155600090323      *
155700021203      * Get the Dependent Coverages
155800021206     C                   Eval      W_TM_ONLY =   'Y'
155900021212     C                   Exsr      ResetCovg
156000021203     C                   Eval      W_SEQ    =   D_DPSEQ#
156100021213     C     DW310KeyPF    Chain     DW310PF
156200030702     C                   If        %Found(DW310PF)
156300090330     C                   Exsr      GetPlanMasterD
156400021213     C                   Else
156500021213     C                   LeaveSR
156600021213     C                   End
156700090813      *
156800090813      * Check existing CFS
156900090813     C                   Move      SOCSOC        P_SSN
157000100118     C                   Move      D_DPSEQ#      P_SEQ
157100090813     C                   Move      *BLANKS       P_FLG
157200090813     C                   Movea     APLN          KING
157300090813      *
157400090813     C                   Call      'DW311CFSDC'
157500090813     C                   Parm                    P_SSN
157600090813     C                   Parm                    P_SEQ
157700090813     C                   Parm                    P_FLG
157800090813     C                   Parm                    KING
157900021206      *
158000021212      * If Completly Termed, Term Date (MEMBER)
158100021212     C                   If        W_TM_ONLY  =  'Y'
158200021212     C                   If        M_TERMDT <>   *ZEROS
158300021216     C     *YMD          MOVE      M_TERMDT      ISO_DATE
158400021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
158500070129     C     *ISO          MOVE      ISO_DATE      T_TERMDT
158600070125     C                   Movel     T_TERMDT      Input_Date
158700070202     C**************     Else
158800070202     C**************     Movel     W_DEPTRM      Input_Date
158900070202     C**************     End
159000021212     C                   Eval      Input_Format  = 'YYYYMMDD'
159100021212     C                   Eval      Output_Format = 'MM/DD/YYYY'
159200021212     C                   Exsr      FormatDateSR
159300021212     C                   Eval      D3TRMDT       = %trim(Output_Date)
159400021212     C                   Eval      D3TRMR        = 'MEUN'
159500081113     C****CLAIR*******   Exsr      ResetCovg
159600070202     C                   End
159700021206     C                   End
159800021112      *
159900021112      * Set Relationship code
160000021112     C                   Move      D_DRELCD      W_DRELCD
160100021112     C                   Select
160200021112     C                   When      W_DRELCD = 'WI'
160300021112     C                   Eval      D3REL    = 'W'
160400021112     C                   When      W_DRELCD = 'HU'
160500021112     C                   Eval      D3REL    = 'H'
160600021112     C                   When      W_DRELCD = 'SO'
160700021112     C                   Eval      D3REL    = 'S'
160800110330     C                   When      W_DRELCD = 'DA'
160900110330     C                   Eval      D3REL    = 'D'
161000110330     C                   When      W_DRELCD = 'PA'
161100110330     C                   Eval      D3REL    = 'P'
161200191001JA02 C                   When      W_DRELCD = 'GC'
161300191001JA02 C                   Eval      D3REL    = 'G'
161400021112     C                   Other
161500021112     C                   Eval      D3REL    = 'O'
161600021112     C                   Endsl
161700021112      *
161800021112      * Dependent misc.
161900021209     C                   Movel     D_DLNAME      W_NAME6
162000021209     C                   If        W_NAME6  =    'SAME  '
162100021209     C                   Eval      D3LST    =    %trim(M_MLNAME)
162200021209     C                   Else
162300021209     C                   Eval      D3LST    =    %trim(D_DLNAME)
162400021209     C                   End
162500021112     C                   Eval      D3FST    =    %trim(D_DFNAME)
162600021112     C                   Eval      D3MID    =    %trim(D_DMI)
162700140407
162800140407      * Longer Name
162900140407     C                   eval      cfssn = SOCSOC
163000140407     C                   eval      cfseq = D_DPSEQ#
163100140407     C     CFSKEY        Chain     CFS100P
163200140407     C                   If        %Found(CFS100P)
163300140408     C                   If        %trim(CFSLST) <> *blanks
163400140407     C                   Eval      D3LST    =    %trim(CFSLST)
163500140408     C                   End
163600140408     C                   If        %trim(CFSFST) <> *blanks
163700140407     C                   Eval      D3FST    =    %trim(CFSFST)
163800140408     C                   End
163900140407     C                   End
164000190111      *
164100190111ja01  * Fill Dependent Address
164200190111 |   C                   if        %trim(D_DADDR1) <> 'SAME' and
164300190111 |   C                             %trim(D_DADDR1) <> *blanks
164400190111 |   C                   Eval      D3ADR1   =    %trim(D_DADDR1)
164500190111 |   C                   Eval      D3ADR2   =    %trim(D_DADDR2)
164600190111 |   C                   Eval      D3CITY   =    %trim(D_DCITY)
164700190111 |   C                   Eval      D3STAT   =    %trim(D_DSTATE)
164800190111 |   C                   Z-Add     D_DZip        W_Zip
164900190111 |   C                   Eval      D3ZIPC   =    %trim(ZIPCHAR)
165000190111 |   C                   Eval      D3CNTY   =    *BLANKS
165100190111ja01 C                   End
165200081113      *
165300090827      * Set Old/Saved Info.
165400090827     C     D_DPSEQ#      occur     W_OLD
165500090827      * Last Name
165600090827     C                   Eval      D3OLDLS = %trim(D4OLDLS)
165700090827      * First Name
165800090827     C                   Eval      D3OLDFN = %trim(D4OLDFN)
165900090827      * Middle Name
166000090827     C                   Eval      D3OLDMI = %trim(D4OLDMI)
166100090827      * Birth Date
166200090827     C                   Eval      D3OLDBI = %trim(D4OLDBI)
166300070307      *
166400070307      * Send BLANKS if 0
166500070307     C                   If        D_DEPSS# = 0
166600070307     C                   Move      *blanks       D3SSN
166700070307     C                   Z-add     0             W_DEPSSN
166800070307     C                   Else
166900070307     C                   Z-add     D_DEPSS#      W_DEPSSN
167000021112     C                   Move      W_DEPSSN      D3SSN
167100070307     C                   End
167200070307      *
167300021112     C                   Eval      D3SEX    =    %trim(D_DSEX)
167400021112      *
167500021112      * Birth Date (DEPEND) to Birth Date
167600021112     C                   Movel     D_DBIRTH      Input_Date
167700021112     C                   Eval      Input_Format  = 'YYYYMMDD'
167800021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
167900021112     C                   Exsr      FormatDateSR
168000021112     C                   Eval      D3BIRTH       = %trim(Output_Date)
168100021112      *
168200021210      * Student data
168300021030     C                   Exsr      GetStudent
168400021030      *
168500021030      * Handicap data
168600021030     C                   Exsr      GetHandicap
168700021210      *
168800021210      * Medicare data
168900021210     C                   Eval      D3MEDEFF      = *BLANKS
169000021210     C                   Eval      D3EVTEFF1     = *BLANKS
169100021210     C                   Eval      D3MEDEVT1     = *BLANKS
169200021210     C                   Eval      D3EVTEFF2     = *BLANKS
169300021210     C                   Eval      D3MEDEVT2     = *BLANKS
169400080502     C                   Eval      D3HICN        = *BLANKS
169500080502      *
169600021210     C                   If        D_DMEDCR  <>  *Blanks  and
169700021210     C                             D_DMEDCR  <>  'N'
169800190513      *
169900190513     C                   Eval      Pos    =  %scan('NONE':D_DMED#)
170000190513     C                   If        Pos    >  0
170100190513     C                   eval      D_DMED# = *BLANKS
170200190513     C                   End
170300190522     C                   Eval      Pos    =  %scan('None':D_DMED#)
170400190522     C                   If        Pos    >  0
170500190522     C                   eval      D_DMED# = *BLANKS
170600190522     C                   End
170700190513     C                   Eval      Pos    =  %scan('NO ':D_DMED#)
170800190513     C                   If        Pos    >  0
170900190513     C                   eval      D_DMED# = *BLANKS
171000190513     C                   End
171100190516     C                   Eval      Pos    =  %scan('No ':D_DMED#)
171200190516     C                   If        Pos    >  0
171300190516     C                   eval      D_DMED# = *BLANKS
171400190516     C                   End
171500190522     C                   Eval      Pos    =  %scan('no ':D_DMED#)
171600190522     C                   If        Pos    >  0
171700190522     C                   eval      D_DMED# = *BLANKS
171800190522     C                   End
171900190522     C                   Eval      Pos    =  %scan('N  ':D_DMED#)
172000190522     C                   If        Pos    >  0
172100190522     C                   eval      D_DMED# = *BLANKS
172200190522     C                   End
172300190522     C                   Eval      Pos    =  %scan('n  ':D_DMED#)
172400190522     C                   If        Pos    >  0
172500190522     C                   eval      D_DMED# = *BLANKS
172600190522     C                   End
172700190513     C                   Eval      Pos    =  %scan('NA ':D_DMED#)
172800190513     C                   If        Pos    >  0
172900190513     C                   eval      D_DMED# = *BLANKS
173000190513     C                   End
173100190513     C                   Eval      Pos    =  %scan('N/A ':D_DMED#)
173200190513     C                   If        Pos    >  0
173300190513     C                   eval      D_DMED# = *BLANKS
173400190513     C                   End
173500190513     C                   Eval      Pos    =  %scan('YES ':D_DMED#)
173600190513     C                   If        Pos    >  0
173700190513     C                   eval      D_DMED# = *BLANKS
173800190513     C                   End
173900190522     C                   Eval      Pos    =  %scan('Yes ':D_DMED#)
174000190522     C                   If        Pos    >  0
174100190522     C                   eval      D_DMED# = *BLANKS
174200190522     C                   End
174300190522     C                   Eval      Pos    =  %scan('Y   ':D_DMED#)
174400190522     C                   If        Pos    >  0
174500190522     C                   eval      D_DMED# = *BLANKS
174600190522     C                   End
174700190522     C                   Eval      Pos    =  %scan('y   ':D_DMED#)
174800190522     C                   If        Pos    >  0
174900190522     C                   eval      D_DMED# = *BLANKS
175000190522     C                   End
175100190522     C                   if        D_DMED# <> *blanks
175200190522     C                   Eval      LEN2 = %LEN(%trim(D_DMED#))
175300190522     C                   If        LEN2 < 10
175400190522     C                   eval      D_DMED# = *BLANKS
175500190522     C                   End
175600190522     C                   End
175700021210      *
175800021210      * Find the - or & and pull it out.
175900021210     C                   Eval      Pos    =  %scan('-':D_DMED#)
176000021210     C                   If        Pos    =  0
176100021210     C                   Eval      Pos    =  %scan('&':D_DMED#)
176200021210     C                   End
176300021210      *
176400021210     C                   If        Pos    =  0
176500021210     C                   Eval      D3HICN =  %trim(D_DMED#)
176600021210     C                   Else
176700021210     C                   Eval      D3HICN=%replace(%subst(D_DMED#:pos+1:13-pos):
176800021210     C                             D_DMED#:pos)
176900021210     C                   End
177000021210      * Medicare Eff-A (DEPEND)
177100021210     C                   If        D_DMEDAD <>   *ZEROS
177200080911     C                   Movel     D_DMEDAD      Input_Date
177300021210     C                   Eval      Input_Format  = 'YYYYMMDD'
177400021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
177500021210     C                   Exsr      FormatDateSR
177600021210     C                   Eval      D3MEDEFF      = %trim(Output_Date)
177700021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
177800021210     C                   Eval      D3MEDEVT1     = 'PRTA'
177900021210     C                   End
178000021210      *
178100021210      * Medicare Eff-B (DEPEND)
178200080911     C                   If        D_DMEDBD <>   *ZEROS
178300021210     C                   Movel     D_DMEDBD      Input_Date
178400021210     C                   Eval      Input_Format  = 'YYYYMMDD'
178500021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
178600021210     C                   Exsr      FormatDateSR
178700021210     C                   If        D3MEDEFF      = *BLANKS
178800021210     C                   Eval      D3MEDEFF      = %trim(Output_Date)
178900021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
179000021210     C                   Eval      D3MEDEVT1     = 'PRTB'
179100021210     C                   Else
179200021210     C                   Eval      D3EVTEFF2     = %trim(Output_Date)
179300021210     C                   Eval      D3MEDEVT2     = 'PRTB'
179400021210     C                   End
179500021210     C                   End
179600021210     C                   End
179700021104      *
179800021104      * Provider PCP data
179900021112     C                   Z-add     SOCSOC        W_SSN#
180000081112     C                   Z-add     D_DPSEQ#      W_SFX#
180100081112     C                   Z-add     D_DPSEQ#      D3BIRSQ
180200021112     C                   Eval      W_SPCD    =   'MED'
180300021104     C                   Exsr      GetProvider
180400021104      *
180500041130      * If Reinstate, override dates
180600041130     C                   If        *in95 = *on
180700090727     C***********        Exsr      ReinstateSR
180800041130     C                   End
180900070430      *
181000100129      * Get Dep# original eff date (overrides in 311cl)
181100100129     C                   Call      'DW311DV'
181200080116     C                   Parm                    WDTA
181300080116     C                   Parm                    GROUP#
181400070430     C                   Parm                    D3ORGEF
181500100129      *
181600100129      * If D3ORGEF is blank, use coverage effective date (missing rates)
181700100129     C                   If        D3ORGEF = *blanks
181800100129     C                   Select
181900100129     C                   When      D3SCEF1 <> *blanks
182000100129     C                   Eval      D3ORGEF = D3SCEF1
182100100129     C                   When      D3SCEF2 <> *blanks
182200100129     C                   Eval      D3ORGEF = D3SCEF2
182300100129     C                   When      D3SCEF3 <> *blanks
182400100129     C                   Eval      D3ORGEF = D3SCEF3
182500100129     C                   When      D3SCEF4 <> *blanks
182600100129     C                   Eval      D3ORGEF = D3SCEF4
182700100129     C                   Endsl
182800100129     C                   End
182900110720      *
183000110720      * Check Deceased
183100110720     C                   Move      D_DPSEQ#      Q_SEQ
183200110720     C                   Exsr      DECEASED
183300090422      *
183400090422      * Override various 834 values
183500090422     C                   Exsr      Override834
183600070430      *
183700021104     C                   Eval      D3SFX    =    '99'
183800021024     C                   Eval      D3HLD    =    'X'
183900100224     C                   Eval      D3FIL1   =    %trim(QQUSER)
184000100511     C                   Eval      D3FIL2   =    %trim(QQRVWR)
184100100816     C                   Eval      D3FIL10  =    MMDD + YY + HHMM
184200021024     C                   Eval      DB2150   =    EnrollmentData
184300090409      *
184400090409      * Skip write?
184500090409     C                   If        SKIPWRT  <>  'Y'
184600021209      *
184700021024     C                   Write     DBTRANR
184800100208     C  NU1              Exsr      PlanTracking
184900030612     C                   Exsr      CheckOverflow
185000030612     C                   Write     PRTDTL
185100030612     C                   Eval      Count = Count + 1
185200090409     C                   End
185300090409      *
185400070131     C                   Clear                   DBTRANR
185500070125     C                   Exsr      ResetCovg
185600021106      *
185700021024     C                   ENDSR
185800021030      *___________________________________________________________________
185900021030      * Get Member Student Data
186000021030      *___________________________________________________________________
186100021030     C     GetStudent    BEGSR
186200060929      *
186300060929      * Reset Student
186400060929     C                   Eval      D3STUEFF      = *blanks
186500060929     C                   Eval      D3SCHOOL      = *blanks
186600060929     C                   Eval      D3STUTYP      = *blanks
186700021030      *
186800021112      * Effective (FILL37)
186900021112     C                   If        DEPEFFDT   <>   *BLANKS    and
187000021112     C                             DEPEFFDT   <>   '00000000'
187100021112     C                   Movel     DEPEFFDT      Input_Date
187200021030     C                   Eval      Input_Format  = 'YYYYMMDD'
187300021030     C                   Eval      Output_Format = 'MM/DD/YYYY'
187400021030     C                   Exsr      FormatDateSR
187500021030     C                   Eval      D3STUEFF      = %trim(Output_Date)
187600021217     C                   Eval      D3SCHOOL      = %trim(DEPSCHOOL)
187700021217     C                   Eval      D3STUTYP      = 'F'
187800021217     C                   End
187900021217      *
188000021112      * Term (NO TERM DATE YET)
188100021112     C***                Movel     DCANDT        Input_Date
188200021112     C***                Eval      Input_Format  = 'YYYYMMDD'
188300021112     C***                Eval      Output_Format = 'MM/DD/YYYY'
188400021112     C***                Exsr      FormatDateSR
188500021112     C***                Eval      D3STUTRM      = %trim(Output_Date)
188600021112     C***                Eval      D3STURES      = 'MSUN'
188700021104      *
188800021030     C                   ENDSR
188900021030      *___________________________________________________________________
189000021030      * Get Handicap Data
189100021030      *___________________________________________________________________
189200021030     C     GetHandicap   BEGSR
189300060929      *
189400060929      * Reset Handicap
189500060929     C                   Eval      D3HANEFF      = *blanks
189600060929     C                   Eval      D3HANDES      = *blanks
189700060929     C                   Eval      D3HANTYP      = *blanks
189800021030      * If handicaped
189900021112     C                   If        dhndcp  <>    *Blanks
190000021030      *
190100021112      * Effective (DEPEND)
190200021112     C                   Movel     D_DHDDT       Input_Date
190300021030     C                   Eval      Input_Format  = 'YYYYMMDD'
190400021030     C                   Eval      Output_Format = 'MM/DD/YYYY'
190500021030     C                   Exsr      FormatDateSR
190600021030     C                   Eval      D3HANEFF      = %trim(Output_Date)
190700021112      *
190800021112      * Term (NO TERM DATE YET)
190900021112     C***                Movel                   Input_Date
191000021112     C***                Eval      Input_Format  = 'YYYYMMDD'
191100021112     C***                Eval      Output_Format = 'MM/DD/YYYY'
191200021112     C***                Exsr      FormatDateSR
191300021112     C***                Eval      D3HANTRM      = %trim(Output_Date)
191400021112     C***                Eval      D3HANRES      = 'MHUN'
191500021030      *
191600021030      * Description and Type.
191700021031     C                   Eval      D3HANDES      = %trim('DISABLED')
191800021030     C                   Eval      D3HANTYP      = 'P'
191900021030      *
192000021030     C                   End
192100021030      *
192200021030     C                   ENDSR
192300021104      *___________________________________________________________________
192400091104      * Get Plan category
192500021104      *___________________________________________________________________
192600091104     C     GetPlanCat    BEGSR
192700091104      *
192800091104     C     PCATKY        KLIST
192900091104     C                   Kfld                    TRUST
193000091104     C                   Kfld                    SUBNO
193100091104     C                   Kfld                    PLAN#
193200091104      *
193300091104     C     PCATKY        CHAIN     PLNMST
193400091104     C                   IF        not %FOUND(PLNMST)
193500091104     C                   EVAL      PLNCAT = *BLANKS
193600091104     C                   END
193700091104      *
193800091104     C                   ENDSR
193900091104      *___________________________________________________________________
194000091104      * Get Provider Data
194100091104      *___________________________________________________________________
194200091104     C     GetProvider   BEGSR
194300021112      *
194400021112     C                   Eval      D3PRVID1  =   *BLANKS
194500021112     C                   Eval      D3PRIME1  =   *BLANKS
194600021112     C                   Eval      D3PRVEF1  =   *BLANKS
194700021112     C                   Eval      D3PRVTR1  =   *BLANKS
194800021112     C                   Eval      D3PRVID2  =   *BLANKS
194900021112     C                   Eval      D3PRIME2  =   *BLANKS
195000021112     C                   Eval      D3PRVEF2  =   *BLANKS
195100090520     C                   Eval      D3PRVTR2  =   *BLANKS
195200090520     C                   Eval      P_TERMDT  =   *ZEROS
195300070213      *
195400090406      * Always send PCP information
195500021104      *
195600021104     C     PCPKEY        Setll     PCPL1
195700021104     C     PCPKEY        Reade     PCPL1                                  51
195800021104     C     *IN51         Doweq     *OFF
195900021104      *
196000021104      * Provider 1
196100021104     C                   Eval      D3PRVID1  =   %trim(V_PCID#)
196200021104     C                   Eval      D3PRIME1  =   'MP'
196300021104      * Effective Date
196400021104     C                   Movel     V_PCEFF       Input_Date
196500021104     C                   Eval      Input_Format  = 'YYYYMMDD'
196600021104     C                   Eval      Output_Format = 'MM/DD/YYYY'
196700021104     C                   Exsr      FormatDateSR
196800021104     C                   Eval      D3PRVEF1      = %trim(Output_Date)
196900180509     C                   Eval      D3PRVTR1      = *blanks
197000021104      * Term Date
197100021216     C                   If        V_PCCAN  <>   *ZEROS
197200021104     C                   Movel     V_PCCAN       Input_Date
197300021104     C                   Eval      Input_Format  = 'YYYYMMDD'
197400021104     C                   Eval      Output_Format = 'MM/DD/YYYY'
197500021104     C                   Exsr      FormatDateSR
197600021104     C                   Eval      D3PRVTR1      = %trim(Output_Date)
197700090520     C                   Eval      P_TERMDT  =   V_PCCAN
197800030625     C                   Else
197900090520     C                   Eval      P_TERMDT  =   *ZEROS
198000030625     C                   Eval      D3PRVTR1      = *BLANKS
198100091008     C                   Leave
198200021216     C                   End
198300180420      * Provider 2 - per Cindie D allow transmit 04.20.2018
198400180420     C***                Eval      D3PRVID2  =   *BLANKS
198500180420     C***                Eval      D3PRIME2  =   *BLANKS
198600180420     C***                Eval      D3PRVEF2  =   *BLANKS
198700180420     C***                Eval      D3PRVTR2  =   *BLANKS
198800021104      *
198900021104     C     PCPKEY        Reade     PCPL1                                  51
199000070213     C                   Enddo
199100090520      *
199200090520      * Don't Send Termed PCP records
199300090520     C     *Date         Mult      10000.0001    Today
199400090520     C                   If        Today    >=   P_TERMDT  and
199500090520     C                             P_TERMDT <>   0
199600090520     C                   Eval      D3PRVID1  =   *BLANKS
199700090520     C                   Eval      D3PRIME1  =   *BLANKS
199800090520     C                   Eval      D3PRVEF1  =   *BLANKS
199900090520     C                   Eval      D3PRVTR1  =   *BLANKS
200000090520     C                   Eval      P_TERMDT  =   *ZEROS
200100090520     C                   End
200200160224      *
200300160224      * Check for DNF dental carrier and load dental PCP if found
200400180507      * SKIP this per Cindie/Carol 05.07.2018
200500160224     C     DNFKEY        KLIST
200600160224     C                   Kfld                    TRUST
200700160224     C                   Kfld                    SUBNO
200800160224     C                   Kfld                    PLAN#
200900160224     C     DNFKEY        CHAIN     PLNMST
201000160224     C                   if        %FOUND(PLNMST)
201100160224     C                   If        %trim(PCARR) <> 'DNF'
201200180507     C******** SKIP      LeaveSR
201300160224     C                   end
201400160224     C                   else
201500180507     C******** SKIP      LeaveSR
201600160224     C                   end
201700160216      *
201800160216      * Always send PCP information  - DEN
201900160216      *
202000160216     C                   Eval      W_SPCD    =   'DEN'
202100160216     C     PCPKEY        Setll     PCPL1
202200160216     C     PCPKEY        Reade     PCPL1                                  51
202300160216     C     *IN51         Doweq     *OFF
202400160216      *
202500180516      * Provider 2 (DEN)
202600180516     C                   Eval      LEN2 = %LEN(V_PCID#)
202700180516     C                   If        LEN2 = 4
202800180516     C                   Eval      DHNBR =   %trim(V_PCID#)
202900180516     C     DHNBR         chain     CFSDENP
203000180516     C                   If        %found(CFSDENP)
203100180516     C                   Eval      D3PRVID2  =   %trim(DHTIN)
203200180516     C                   else
203300180516     C                   Eval      D3PRVID2  =   %trim(V_PCID#)
203400180516     C                   end
203500180516     C                   else
203600180516     C                   Eval      D3PRVID2  =   %trim(V_PCID#)
203700180516     C                   end
203800160216     C                   Eval      D3PRIME2  =   'DP'
203900160216      * Effective Date
204000160216     C                   Movel     V_PCEFF       Input_Date
204100160216     C                   Eval      Input_Format  = 'YYYYMMDD'
204200160216     C                   Eval      Output_Format = 'MM/DD/YYYY'
204300160216     C                   Exsr      FormatDateSR
204400160216     C                   Eval      D3PRVEF2      = %trim(Output_Date)
204500180509     C                   Eval      D3PRVTR2      = *blanks
204600160216      * Term Date
204700160216     C                   If        V_PCCAN  <>   *ZEROS
204800160216     C                   Movel     V_PCCAN       Input_Date
204900160216     C                   Eval      Input_Format  = 'YYYYMMDD'
205000160216     C                   Eval      Output_Format = 'MM/DD/YYYY'
205100160216     C                   Exsr      FormatDateSR
205200160216     C                   Eval      D3PRVTR2      = %trim(Output_Date)
205300160216     C                   Eval      P_TERMDT  =   V_PCCAN
205400160216     C                   Else
205500160216     C                   Eval      P_TERMDT  =   *ZEROS
205600160216     C                   Eval      D3PRVTR2      = *BLANKS
205700160216     C                   Leave
205800160216     C                   End
205900160216      *
206000160216     C     PCPKEY        Reade     PCPL1                                  51
206100160216     C                   Enddo
206200160216      *
206300160216      * Don't Send Termed PCP records
206400160216     C     *Date         Mult      10000.0001    Today
206500160216     C                   If        Today    >=   P_TERMDT  and
206600160216     C                             P_TERMDT <>   0
206700160216     C                   Eval      D3PRVID2  =   *BLANKS
206800160216     C                   Eval      D3PRIME2  =   *BLANKS
206900160216     C                   Eval      D3PRVEF2  =   *BLANKS
207000160216     C                   Eval      D3PRVTR2  =   *BLANKS
207100160216     C                   Eval      P_TERMDT  =   *ZEROS
207200160216     C                   End
207300030611      *
207400021104     C     PCPKEY        KLIST
207500021104     C                   KFLD                    W_SSN#
207600021104     C                   KFLD                    W_SFX#
207700021104     C                   KFLD                    W_SPCD
207800021104      *
207900021104     C                   ENDSR
208000091207      *___________________________________________________________________
208100091207      * Get Group
208200091207      *___________________________________________________________________
208300091207     C     GetGroup      BEGSR
208400091207      *
208500091207      * Get Plan Group
208600091207     C                   Eval      P_GRP  = *blanks
208700091207     C     GrtKey        Setll     GRAT24
208800091207     C     GrtKey        Reade     GRAT24
208900091207     C                   Dow       not %eof(GRAT24)
209000091207      * GBS Date Logic
209100091207     C                   If        G_frmdat <> G_todat
209200091207      *
209300091207     C                   if        X_DWENRL >= G_frmdat and
209400091207     C                             X_DWENRL <= G_todat
209500091207      *
209600091207     C                   Eval      P_GRP = %trim(G_group#)
209700091207      *
209800091207      * This is the real group#
209900091207     C                   Eval      GROUP# = %trim(G_group#)
210000091207      *
210100091207     C                   Leave
210200091207     C                   end
210300091207     C                   end
210400091207     C     GrtKey        Reade     GRAT24
210500091207     C                   Enddo
210600100223      *
210700100223      * If no rates, use trnmit group#.
210800100223     C                   If        %trim(P_GRP) = *Blanks
210900100223     C                   Eval      P_GRP = %trim(GROUP#)
211000100223     C                   End
211100091207      *
211200091207     C                   ENDSR
211300021025      *___________________________________________________________________
211400021025      * Get class record
211500021025      *___________________________________________________________________
211600021025     C     GetClass      BEGSR
211700090409     C                   Eval      D3CLS    =    *BLANKS
211800021025     C     ClassKey      Chain     CLASS
211900021025     C                   If        %Found
212000021104     C                   Eval      D3CLS    =    C_CLCLASS
212100021106      *
212200021106     C                   If        D3CLSE        = *BLANKS
212300021111     C                   Movel     X_DWENRL      Input_Date
212400021106     C                   Eval      Input_Format  = 'YYYYMMDD'
212500021106     C                   Eval      Output_Format = 'MM/DD/YYYY'
212600021106     C                   Exsr      FormatDateSR
212700021106     C                   Eval      D3CLSE        = %trim(Output_Date)
212800021106     C                   End
212900021106     C                   End
213000090403      *
213100090403      * Get Plan Group
213200100223     C     *Date         Mult      10000.0001    Today
213300090403     C                   Eval      PLNGRP = *blanks
213400100412     C     GrtKey        Setgt     GRAT24
213500100412     C     GrtKey        Readpe    GRAT24
213600090403     C                   Dow       not %eof(GRAT24)
213700090403      * GBS Date Logic
213800090403     C                   If        G_frmdat <> G_todat
213900090403     C                   If        G_todat  = *zeros
214000090403     C                   eval      G_todat  = 99999999
214100090403     C                   End
214200100412
214300100412     C                   Select
214400100412      * First look for current rates
214500100412     C                   When      (Today >= G_frmdat and
214600100223     C                             Today <= G_todat)
214700100412     C                   Eval      PLNGRP = %trim(G_group#)
214800091026     C                   Eval      GROUP# = %trim(G_group#)
214900090403     C                   Leave
215000100412
215100100412      * Then look for eff rates
215200100412     C                   When      (X_DWENRL >= G_frmdat and
215300100412     C                             X_DWENRL <= G_todat)
215400100412     C                   Eval      PLNGRP = %trim(G_group#)
215500100412     C                   Eval      GROUP# = %trim(G_group#)
215600100412     C                   Leave
215700100412     C                   endsl
215800100412
215900090403     C                   end
216000100412     C     GrtKey        Readpe    GRAT24
216100090403     C                   Enddo
216200100223      *
216300100223      * If no rates, use trnmit group#.
216400100223     C                   If        %trim(PLNGRP) = *Blanks
216500100223     C                   Eval      PLNGRP = %trim(GROUP#)
216600100223     C                   End
216700021106      *
216800090403     C     GrtKey        Klist
216900090403     C                   Kfld                    X_DWTRST
217000090403     C                   Kfld                    X_DWSUB#
217100090403     C                   Kfld                    X_DWPLAN
217200090403      *
217300021025     C                   ENDSR
217400021025      *___________________________________________________________________
217500021025      * Get Plan Master record
217600021025      *___________________________________________________________________
217700021025     C     GetPlanMaster BEGSR
217800021111      *
217900021029      * Medical
218000021111     C                   Eval      W_CAT     = 'PMM'
218100021204     C     DW310Key      Chain     DW310LF
218200030702     C                   If        %Found(DW310LF)
218300141210
218400141210     C                   exsr      CHKACAPLN
218500141210
218600021204     C                   Eval      D3SCAT_W  = 'M'
218700021204     C                   Exsr      PlanStatusSR
218800090331     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
218900090331     C                   If        pms = 0
219000090731     C                   Eval      W_FILL        = 'N'
219100090731     C                   Eval      TR051         = *BLANKS
219200090731     C                   Else
219300090731     C                   Eval      TR051     = APGM(pms)
219400090331     C                   End
219500081112     C                   Eval      D3SLVL_W  = W_COVT
219600021204     C                   Eval      D3SEVT_W  = W_SEVT
219700090326     C                   Eval      D3SFAM_W  = W_SFAM
219800090730     C                   Eval      D3FILL_W  = W_FILL
219900091124     C                   Eval      TYP01     = W_FILL
220000091124     C                   Eval      T_PLNM    = X_DWPLAN
220100090515
220200090515      * Reinstate rule: If reinstate, then swap dates to original term date
220300090515     C                   If        D3FILL_W  = 'R'
220400090515     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
220500090515     C                   If        pre > 0
220600090515     C                   Movel     AEFF(pre)     Input_Date
220700090515     C                   Eval      Input_Format  = 'YYYYMMDD'
220800090515     C                   Eval      Output_Format = 'MM/DD/YYYY'
220900090515     C                   Exsr      FormatDateSR
221000090515     C                   Eval      D3SCEF_W  = %trim(Output_Date)
221100090515     C                   End
221200090515     C                   End
221300090515
221400090401     C                   Exsr      LoadBucketSR
221500021204     C                   Exsr      GetClass
221600090403     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
221700090403     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
221800090403     C                   Eval      D3CLS1  = D3CLS
221900090403     C                   Eval      D3CLSE1 = D3CLSE
222000090401     C                   Exsr      LoadChangeSR
222100021204     C                   Else
222200021213     C     DW310Key      Chain     DW310L2
222300030702     C                   If        %Found(DW310L2)
222400141210
222500141210     C                   exsr      CHKACAPLN
222600141210
222700021111     C                   Eval      D3SCAT_W  = 'M'
222800021029     C                   Exsr      PlanStatusSR
222900081112     C                   Eval      D3SLVL_W  = W_COVT
223000021111     C                   Eval      D3SEVT_W  = W_SEVT
223100021111     C                   Eval      D3SFAM_W  = W_SFAM
223200090326     C                   Eval      D3FILL_W  = W_FILL
223300090730     C                   Eval      TYP01     = W_FILL
223400091124     C                   Eval      T_PLNM    = X_DWPLAN
223500021111     C                   Exsr      LoadBucketSR
223600021111     C                   Exsr      GetClass
223700090403     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
223800090403     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
223900090403     C                   Eval      D3CLS1  = D3CLS
224000090403     C                   Eval      D3CLSE1 = D3CLSE
224100021204     C                   End
224200021204     C                   End
224300121023      *
224400121023      * Medical COBRA
224500121023     C                   Eval      W_CAT     = 'PCM'
224600121023     C     DW310Key      Chain     DW310LF
224700121023     C                   If        %Found(DW310LF)
224800141210
224900141210     C                   exsr      CHKACAPLN
225000141210
225100121023     C                   Eval      D3SCAT_W  = 'M'
225200121023     C                   Exsr      PlanStatusSR
225300121023     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
225400121023     C                   If        pms = 0
225500121023     C                   Eval      W_FILL        = 'N'
225600121023     C                   Eval      TR051         = *BLANKS
225700121023     C                   Else
225800121023     C                   Eval      TR051     = APGM(pms)
225900121023     C                   End
226000121023     C                   Eval      D3SLVL_W  = W_COVT
226100121023     C                   Eval      D3SEVT_W  = W_SEVT
226200121023     C                   Eval      D3SFAM_W  = W_SFAM
226300121023     C                   Eval      D3FILL_W  = W_FILL
226400121023     C                   Eval      TYP01     = W_FILL
226500121023     C                   Eval      T_PLNM    = X_DWPLAN
226600121023
226700121023      * Reinstate rule: If reinstate, then swap dates to original term date
226800121023     C                   If        D3FILL_W  = 'R'
226900121023     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
227000121023     C                   If        pre > 0
227100121023     C                   Movel     AEFF(pre)     Input_Date
227200121023     C                   Eval      Input_Format  = 'YYYYMMDD'
227300121023     C                   Eval      Output_Format = 'MM/DD/YYYY'
227400121023     C                   Exsr      FormatDateSR
227500121023     C                   Eval      D3SCEF_W  = %trim(Output_Date)
227600121023     C                   End
227700121023     C                   End
227800121023
227900121023     C                   Exsr      LoadBucketSR
228000121023     C                   Exsr      GetClass
228100121023     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
228200121023     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
228300121023     C                   Eval      D3CLS1  = D3CLS
228400121023     C                   Eval      D3CLSE1 = D3CLSE
228500121023     C                   Exsr      LoadChangeSR
228600121023     C                   Else
228700121023     C     DW310Key      Chain     DW310L2
228800121023     C                   If        %Found(DW310L2)
228900141210
229000141210     C                   exsr      CHKACAPLN
229100141210
229200121023     C                   Eval      D3SCAT_W  = 'M'
229300121023     C                   Exsr      PlanStatusSR
229400121023     C                   Eval      D3SLVL_W  = W_COVT
229500121023     C                   Eval      D3SEVT_W  = W_SEVT
229600121023     C                   Eval      D3SFAM_W  = W_SFAM
229700121023     C                   Eval      D3FILL_W  = W_FILL
229800121023     C                   Eval      TYP01     = W_FILL
229900121023     C                   Eval      T_PLNM    = X_DWPLAN
230000121023     C                   Exsr      LoadBucketSR
230100121023     C                   Exsr      GetClass
230200121023     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
230300121023     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
230400121023     C                   Eval      D3CLS1  = D3CLS
230500121023     C                   Eval      D3CLSE1 = D3CLSE
230600121023     C                   End
230700121023     C                   End
230800121023
230900021029      * Rx Drug
231000021111     C                   Eval      W_CAT     = 'PRX'
231100021204     C     DW310Key      Chain     DW310LF
231200030702     C                   If        %Found(DW310LF)
231300021204     C                   Eval      D3SCAT_W  = 'R'
231400021204     C                   Exsr      PlanStatusSR
231500090331     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
231600090331     C                   If        pms = 0
231700090331     C                   Eval      W_FILL        = 'N'
231800090731     C                   Eval      TR052         = *BLANKS
231900090731     C                   Else
232000090731     C                   Eval      TR052     = APGM(pms)
232100090331     C                   End
232200081112     C                   Eval      D3SLVL_W  = W_COVT
232300021204     C                   Eval      D3SEVT_W  = W_SEVT
232400021204     C                   Eval      D3SFAM_W  = W_SFAM
232500090326     C                   Eval      D3FILL_W  = W_FILL
232600090730     C                   Eval      TYP02     = W_FILL
232700091124     C                   Eval      T_PLNR    = X_DWPLAN
232800090515
232900090515      * Reinstate rule: If reinstate, then swap dates to original term date
233000090515     C                   If        D3FILL_W  = 'R'
233100090515     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
233200090515     C                   If        pre > 0
233300090515     C                   Movel     AEFF(pre)     Input_Date
233400090515     C                   Eval      Input_Format  = 'YYYYMMDD'
233500090515     C                   Eval      Output_Format = 'MM/DD/YYYY'
233600090515     C                   Exsr      FormatDateSR
233700090515     C                   Eval      D3SCEF_W  = %trim(Output_Date)
233800090515     C                   End
233900090515     C                   End
234000090515
234100021204     C                   Exsr      LoadBucketSR
234200021204     C                   Exsr      GetClass
234300090403     C                   Eval      D3GRP2  = %trim(%subst(PLNGRP:1:8))
234400090403     C                   Eval      D3SGR2  = %trim(%subst(PLNGRP:9:4))
234500090403     C                   Eval      D3CLS2  = D3CLS
234600090403     C                   Eval      D3CLSE2 = D3CLSE
234700090401     C                   Exsr      LoadChangeSR
234800021204     C                   Else
234900021213     C     DW310Key      Chain     DW310L2
235000030702     C                   If        %Found(DW310L2)
235100021111     C                   Eval      D3SCAT_W  = 'R'
235200021029     C                   Exsr      PlanStatusSR
235300081112     C                   Eval      D3SLVL_W  = W_COVT
235400021111     C                   Eval      D3SEVT_W  = W_SEVT
235500021111     C                   Eval      D3SFAM_W  = W_SFAM
235600090326     C                   Eval      D3FILL_W  = W_FILL
235700090730     C                   Eval      TYP02     = W_FILL
235800091124     C                   Eval      T_PLNR    = X_DWPLAN
235900021111     C                   Exsr      LoadBucketSR
236000021111     C                   Exsr      GetClass
236100090403     C                   Eval      D3GRP2  = %trim(%subst(PLNGRP:1:8))
236200090403     C                   Eval      D3SGR2  = %trim(%subst(PLNGRP:9:4))
236300090403     C                   Eval      D3CLS2  = D3CLS
236400090403     C                   Eval      D3CLSE2 = D3CLSE
236500021204     C                   End
236600021111     C                   End
236700110922      * Dental - PDR
236800021111     C                   Eval      W_CAT     = 'PDR'
236900021204     C     DW310Key      Chain     DW310LF
237000030702     C                   If        %Found(DW310LF)
237100021204     C                   Eval      D3SCAT_W  = 'D'
237200021204     C                   Exsr      PlanStatusSR
237300090331     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
237400090331     C                   If        pms = 0
237500090331     C                   Eval      W_FILL        = 'N'
237600090731     C                   Eval      TR053         = *BLANKS
237700090731     C                   Else
237800090731     C                   Eval      TR053     = APGM(pms)
237900090331     C                   End
238000081112     C                   Eval      D3SLVL_W  = W_COVT
238100021204     C                   Eval      D3SEVT_W  = W_SEVT
238200021204     C                   Eval      D3SFAM_W  = W_SFAM
238300090326     C                   Eval      D3FILL_W  = W_FILL
238400090730     C                   Eval      TYP03     = W_FILL
238500091124     C                   Eval      T_PLND    = X_DWPLAN
238600090515
238700090515      * Reinstate rule: If reinstate, then swap dates to original term date
238800090515     C                   If        D3FILL_W  = 'R'
238900090515     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
239000090515     C                   If        pre > 0
239100090515     C                   Movel     AEFF(pre)     Input_Date
239200090515     C                   Eval      Input_Format  = 'YYYYMMDD'
239300090515     C                   Eval      Output_Format = 'MM/DD/YYYY'
239400090515     C                   Exsr      FormatDateSR
239500090515     C                   Eval      D3SCEF_W  = %trim(Output_Date)
239600090515     C                   End
239700090515     C                   End
239800090515
239900021204     C                   Exsr      LoadBucketSR
240000021204     C                   Exsr      GetClass
240100090403     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
240200090403     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
240300090403     C                   Eval      D3CLS3  = D3CLS
240400090403     C                   Eval      D3CLSE3 = D3CLSE
240500090401     C                   Exsr      LoadChangeSR
240600021204     C                   Else
240700021213     C     DW310Key      Chain     DW310L2
240800030702     C                   If        %Found(DW310L2)
240900021111     C                   Eval      D3SCAT_W  = 'D'
241000021029     C                   Exsr      PlanStatusSR
241100081112     C                   Eval      D3SLVL_W  = W_COVT
241200021111     C                   Eval      D3SEVT_W  = W_SEVT
241300021111     C                   Eval      D3SFAM_W  = W_SFAM
241400090326     C                   Eval      D3FILL_W  = W_FILL
241500090730     C                   Eval      TYP03     = W_FILL
241600091124     C                   Eval      T_PLND    = X_DWPLAN
241700021111     C                   Exsr      LoadBucketSR
241800021111     C                   Exsr      GetClass
241900090403     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
242000090403     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
242100090403     C                   Eval      D3CLS3  = D3CLS
242200090403     C                   Eval      D3CLSE3 = D3CLSE
242300021204     C                   End
242400021111     C                   End
242500140917      * Dental - PCD
242600140917     C                   Eval      W_CAT     = 'PCD'
242700140917     C     DW310Key      Chain     DW310LF
242800140917     C                   If        %Found(DW310LF)
242900140917     C                   Eval      D3SCAT_W  = 'D'
243000140917     C                   Exsr      PlanStatusSR
243100140917     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
243200140917     C                   If        pms = 0
243300140917     C                   Eval      W_FILL        = 'N'
243400140917     C                   Eval      TR053         = *BLANKS
243500140917     C                   Else
243600140917     C                   Eval      TR053     = APGM(pms)
243700140917     C                   End
243800140917     C                   Eval      D3SLVL_W  = W_COVT
243900140917     C                   Eval      D3SEVT_W  = W_SEVT
244000140917     C                   Eval      D3SFAM_W  = W_SFAM
244100140917     C                   Eval      D3FILL_W  = W_FILL
244200140917     C                   Eval      TYP03     = W_FILL
244300140917     C                   Eval      T_PLND    = X_DWPLAN
244400140917
244500140917      * Reinstate rule: If reinstate, then swap dates to original term date
244600140917     C                   If        D3FILL_W  = 'R'
244700140917     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
244800140917     C                   If        pre > 0
244900140917     C                   Movel     AEFF(pre)     Input_Date
245000140917     C                   Eval      Input_Format  = 'YYYYMMDD'
245100140917     C                   Eval      Output_Format = 'MM/DD/YYYY'
245200140917     C                   Exsr      FormatDateSR
245300140917     C                   Eval      D3SCEF_W  = %trim(Output_Date)
245400140917     C                   End
245500140917     C                   End
245600140917
245700140917     C                   Exsr      LoadBucketSR
245800140917     C                   Exsr      GetClass
245900140917     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
246000140917     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
246100140917     C                   Eval      D3CLS3  = D3CLS
246200140917     C                   Eval      D3CLSE3 = D3CLSE
246300140917     C                   Exsr      LoadChangeSR
246400140917     C                   Else
246500140917     C     DW310Key      Chain     DW310L2
246600140917     C                   If        %Found(DW310L2)
246700140917     C                   Eval      D3SCAT_W  = 'D'
246800140917     C                   Exsr      PlanStatusSR
246900140917     C                   Eval      D3SLVL_W  = W_COVT
247000140917     C                   Eval      D3SEVT_W  = W_SEVT
247100140917     C                   Eval      D3SFAM_W  = W_SFAM
247200140917     C                   Eval      D3FILL_W  = W_FILL
247300140917     C                   Eval      TYP03     = W_FILL
247400140917     C                   Eval      T_PLND    = X_DWPLAN
247500140917     C                   Exsr      LoadBucketSR
247600140917     C                   Exsr      GetClass
247700140917     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
247800140917     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
247900140917     C                   Eval      D3CLS3  = D3CLS
248000140917     C                   Eval      D3CLSE3 = D3CLSE
248100140917     C                   End
248200140917     C                   End
248300110922      * Dental - PDN
248400110922     C                   Eval      W_CAT     = 'PDN'
248500110922     C     DW310Key      Chain     DW310LF
248600110922     C                   If        %Found(DW310LF)
248700110922     C                   Eval      D3SCAT_W  = 'D'
248800110922     C                   Exsr      PlanStatusSR
248900110922     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
249000110922     C                   If        pms = 0
249100110922     C                   Eval      W_FILL        = 'N'
249200110922     C                   Eval      TR053         = *BLANKS
249300110922     C                   Else
249400110922     C                   Eval      TR053     = APGM(pms)
249500110922     C                   End
249600110922     C                   Eval      D3SLVL_W  = W_COVT
249700110922     C                   Eval      D3SEVT_W  = W_SEVT
249800110922     C                   Eval      D3SFAM_W  = W_SFAM
249900110922     C                   Eval      D3FILL_W  = W_FILL
250000110922     C                   Eval      TYP03     = W_FILL
250100110922     C                   Eval      T_PLND    = X_DWPLAN
250200110922
250300110922      * Reinstate rule: If reinstate, then swap dates to original term date
250400110922     C                   If        D3FILL_W  = 'R'
250500110922     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
250600110922     C                   If        pre > 0
250700110922     C                   Movel     AEFF(pre)     Input_Date
250800110922     C                   Eval      Input_Format  = 'YYYYMMDD'
250900110922     C                   Eval      Output_Format = 'MM/DD/YYYY'
251000110922     C                   Exsr      FormatDateSR
251100110922     C                   Eval      D3SCEF_W  = %trim(Output_Date)
251200110922     C                   End
251300110922     C                   End
251400110922
251500110922     C                   Exsr      LoadBucketSR
251600110922     C                   Exsr      GetClass
251700110922     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
251800110922     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
251900110922     C                   Eval      D3CLS3  = D3CLS
252000110922     C                   Eval      D3CLSE3 = D3CLSE
252100110922     C                   Exsr      LoadChangeSR
252200110922     C                   Else
252300110922     C     DW310Key      Chain     DW310L2
252400110922     C                   If        %Found(DW310L2)
252500110922     C                   Eval      D3SCAT_W  = 'D'
252600110922     C                   Exsr      PlanStatusSR
252700110922     C                   Eval      D3SLVL_W  = W_COVT
252800110922     C                   Eval      D3SEVT_W  = W_SEVT
252900110922     C                   Eval      D3SFAM_W  = W_SFAM
253000110922     C                   Eval      D3FILL_W  = W_FILL
253100110922     C                   Eval      TYP03     = W_FILL
253200110922     C                   Eval      T_PLND    = X_DWPLAN
253300110922     C                   Exsr      LoadBucketSR
253400110922     C                   Exsr      GetClass
253500110922     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
253600110922     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
253700110922     C                   Eval      D3CLS3  = D3CLS
253800110922     C                   Eval      D3CLSE3 = D3CLSE
253900110922     C                   End
254000110922     C                   End
254100130118      * Dental - PDE
254200130118     C                   Eval      W_CAT     = 'PDE'
254300130118     C     DW310Key      Chain     DW310LF
254400130118     C                   If        %Found(DW310LF)
254500130118     C                   Eval      D3SCAT_W  = 'D'
254600130118     C                   Exsr      PlanStatusSR
254700130118     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
254800130118     C                   If        pms = 0
254900130118     C                   Eval      W_FILL        = 'N'
255000130118     C                   Eval      TR053         = *BLANKS
255100130118     C                   Else
255200130118     C                   Eval      TR053     = APGM(pms)
255300130118     C                   End
255400130118     C                   Eval      D3SLVL_W  = W_COVT
255500130118     C                   Eval      D3SEVT_W  = W_SEVT
255600130118     C                   Eval      D3SFAM_W  = W_SFAM
255700130118     C                   Eval      D3FILL_W  = W_FILL
255800130118     C                   Eval      TYP03     = W_FILL
255900130118     C                   Eval      T_PLND    = X_DWPLAN
256000130118
256100130118      * Reinstate rule: If reinstate, then swap dates to original term date
256200130118     C                   If        D3FILL_W  = 'R'
256300130118     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
256400130118     C                   If        pre > 0
256500130118     C                   Movel     AEFF(pre)     Input_Date
256600130118     C                   Eval      Input_Format  = 'YYYYMMDD'
256700130118     C                   Eval      Output_Format = 'MM/DD/YYYY'
256800130118     C                   Exsr      FormatDateSR
256900130118     C                   Eval      D3SCEF_W  = %trim(Output_Date)
257000130118     C                   End
257100130118     C                   End
257200130118
257300130118     C                   Exsr      LoadBucketSR
257400130118     C                   Exsr      GetClass
257500130118     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
257600130118     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
257700130118     C                   Eval      D3CLS3  = D3CLS
257800130118     C                   Eval      D3CLSE3 = D3CLSE
257900130118     C                   Exsr      LoadChangeSR
258000130118     C                   Else
258100130118     C     DW310Key      Chain     DW310L2
258200130118     C                   If        %Found(DW310L2)
258300130118     C                   Eval      D3SCAT_W  = 'D'
258400130118     C                   Exsr      PlanStatusSR
258500130118     C                   Eval      D3SLVL_W  = W_COVT
258600130118     C                   Eval      D3SEVT_W  = W_SEVT
258700130118     C                   Eval      D3SFAM_W  = W_SFAM
258800130118     C                   Eval      D3FILL_W  = W_FILL
258900130118     C                   Eval      TYP03     = W_FILL
259000130118     C                   Eval      T_PLND    = X_DWPLAN
259100130118     C                   Exsr      LoadBucketSR
259200130118     C                   Exsr      GetClass
259300130118     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
259400130118     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
259500130118     C                   Eval      D3CLS3  = D3CLS
259600130118     C                   Eval      D3CLSE3 = D3CLSE
259700130118     C                   End
259800130118     C                   End
259900110922      * Vision - PVR
260000021111     C                   Eval      W_CAT     = 'PVR'
260100021204     C     DW310Key      Chain     DW310LF
260200030702     C                   If        %Found(DW310LF)
260300021204     C                   Eval      D3SCAT_W  = 'V'
260400021204     C                   Exsr      PlanStatusSR
260500090331     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
260600090331     C                   If        pms = 0
260700090331     C                   Eval      W_FILL        = 'N'
260800090731     C                   Eval      TR054         = *BLANKS
260900090731     C                   Else
261000090731     C                   Eval      TR054     = APGM(pms)
261100090331     C                   End
261200081112     C                   Eval      D3SLVL_W  = W_COVT
261300021204     C                   Eval      D3SEVT_W  = W_SEVT
261400021204     C                   Eval      D3SFAM_W  = W_SFAM
261500090326     C                   Eval      D3FILL_W  = W_FILL
261600090730     C                   Eval      TYP04     = W_FILL
261700091124     C                   Eval      T_PLNV    = X_DWPLAN
261800090515
261900090515      * Reinstate rule: If reinstate, then swap dates to original term date
262000090515     C                   If        D3FILL_W  = 'R'
262100090515     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
262200090515     C                   If        pre > 0
262300090515     C                   Movel     AEFF(pre)     Input_Date
262400090515     C                   Eval      Input_Format  = 'YYYYMMDD'
262500090515     C                   Eval      Output_Format = 'MM/DD/YYYY'
262600090515     C                   Exsr      FormatDateSR
262700090515     C                   Eval      D3SCEF_W  = %trim(Output_Date)
262800090515     C                   End
262900090515     C                   End
263000090515
263100021204     C                   Exsr      LoadBucketSR
263200021204     C                   Exsr      GetClass
263300090403     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
263400090403     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
263500090403     C                   Eval      D3CLS4  = D3CLS
263600090403     C                   Eval      D3CLSE4 = D3CLSE
263700090401     C                   Exsr      LoadChangeSR
263800021204     C                   Else
263900021213     C     DW310Key      Chain     DW310L2
264000030702     C                   If        %Found(DW310L2)
264100021111     C                   Eval      D3SCAT_W  = 'V'
264200021029     C                   Exsr      PlanStatusSR
264300081112     C                   Eval      D3SLVL_W  = W_COVT
264400021111     C                   Eval      D3SEVT_W  = W_SEVT
264500021111     C                   Eval      D3SFAM_W  = W_SFAM
264600090326     C                   Eval      D3FILL_W  = W_FILL
264700090730     C                   Eval      TYP04     = W_FILL
264800091124     C                   Eval      T_PLNV    = X_DWPLAN
264900021111     C                   Exsr      LoadBucketSR
265000021111     C                   Exsr      GetClass
265100090403     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
265200090403     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
265300090403     C                   Eval      D3CLS4  = D3CLS
265400090403     C                   Eval      D3CLSE4 = D3CLSE
265500021204     C                   End
265600021111     C                   End
265700110922      * Vision - PVS
265800110922     C                   Eval      W_CAT     = 'PVS'
265900110922     C     DW310Key      Chain     DW310LF
266000110922     C                   If        %Found(DW310LF)
266100110922     C                   Eval      D3SCAT_W  = 'V'
266200110922     C                   Exsr      PlanStatusSR
266300110922     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
266400110922     C                   If        pms = 0
266500110922     C                   Eval      W_FILL        = 'N'
266600110922     C                   Eval      TR054         = *BLANKS
266700110922     C                   Else
266800110922     C                   Eval      TR054     = APGM(pms)
266900110922     C                   End
267000110922     C                   Eval      D3SLVL_W  = W_COVT
267100110922     C                   Eval      D3SEVT_W  = W_SEVT
267200110922     C                   Eval      D3SFAM_W  = W_SFAM
267300110922     C                   Eval      D3FILL_W  = W_FILL
267400110922     C                   Eval      TYP04     = W_FILL
267500110922     C                   Eval      T_PLNV    = X_DWPLAN
267600110922
267700110922      * Reinstate rule: If reinstate, then swap dates to original term date
267800110922     C                   If        D3FILL_W  = 'R'
267900110922     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
268000110922     C                   If        pre > 0
268100110922     C                   Movel     AEFF(pre)     Input_Date
268200110922     C                   Eval      Input_Format  = 'YYYYMMDD'
268300110922     C                   Eval      Output_Format = 'MM/DD/YYYY'
268400110922     C                   Exsr      FormatDateSR
268500110922     C                   Eval      D3SCEF_W  = %trim(Output_Date)
268600110922     C                   End
268700110922     C                   End
268800110922
268900110922     C                   Exsr      LoadBucketSR
269000110922     C                   Exsr      GetClass
269100110922     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
269200110922     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
269300110922     C                   Eval      D3CLS4  = D3CLS
269400110922     C                   Eval      D3CLSE4 = D3CLSE
269500110922     C                   Exsr      LoadChangeSR
269600110922     C                   Else
269700110922     C     DW310Key      Chain     DW310L2
269800110922     C                   If        %Found(DW310L2)
269900110922     C                   Eval      D3SCAT_W  = 'V'
270000110922     C                   Exsr      PlanStatusSR
270100110922     C                   Eval      D3SLVL_W  = W_COVT
270200110922     C                   Eval      D3SEVT_W  = W_SEVT
270300110922     C                   Eval      D3SFAM_W  = W_SFAM
270400110922     C                   Eval      D3FILL_W  = W_FILL
270500110922     C                   Eval      TYP04     = W_FILL
270600110922     C                   Eval      T_PLNV    = X_DWPLAN
270700110922     C                   Exsr      LoadBucketSR
270800110922     C                   Exsr      GetClass
270900110922     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
271000110922     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
271100110922     C                   Eval      D3CLS4  = D3CLS
271200110922     C                   Eval      D3CLSE4 = D3CLSE
271300110922     C                   End
271400110922     C                   End
271500130725      * Vision - PCV
271600130725     C                   Eval      W_CAT     = 'PCV'
271700130725     C     DW310Key      Chain     DW310LF
271800130725     C                   If        %Found(DW310LF)
271900130725     C                   Eval      D3SCAT_W  = 'V'
272000130725     C                   Exsr      PlanStatusSR
272100130725     C                   Eval      pms = %lookup(X_DWPLAN:APLN)
272200130725     C                   If        pms = 0
272300130725     C                   Eval      W_FILL        = 'N'
272400130725     C                   Eval      TR054         = *BLANKS
272500130725     C                   Else
272600130725     C                   Eval      TR054     = APGM(pms)
272700130725     C                   End
272800130725     C                   Eval      D3SLVL_W  = W_COVT
272900130725     C                   Eval      D3SEVT_W  = W_SEVT
273000130725     C                   Eval      D3SFAM_W  = W_SFAM
273100130725     C                   Eval      D3FILL_W  = W_FILL
273200130725     C                   Eval      TYP04     = W_FILL
273300130725     C                   Eval      T_PLNV    = X_DWPLAN
273400130725
273500130725      * Reinstate rule: If reinstate, then swap dates to original term date
273600130725     C                   If        D3FILL_W  = 'R'
273700130725     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
273800130725     C                   If        pre > 0
273900130725     C                   Movel     AEFF(pre)     Input_Date
274000130725     C                   Eval      Input_Format  = 'YYYYMMDD'
274100130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
274200130725     C                   Exsr      FormatDateSR
274300130725     C                   Eval      D3SCEF_W  = %trim(Output_Date)
274400130725     C                   End
274500130725     C                   End
274600130725
274700130725     C                   Exsr      LoadBucketSR
274800130725     C                   Exsr      GetClass
274900130725     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
275000130725     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
275100130725     C                   Eval      D3CLS4  = D3CLS
275200130725     C                   Eval      D3CLSE4 = D3CLSE
275300130725     C                   Exsr      LoadChangeSR
275400130725     C                   Else
275500130725     C     DW310Key      Chain     DW310L2
275600130725     C                   If        %Found(DW310L2)
275700130725     C                   Eval      D3SCAT_W  = 'V'
275800130725     C                   Exsr      PlanStatusSR
275900130725     C                   Eval      D3SLVL_W  = W_COVT
276000130725     C                   Eval      D3SEVT_W  = W_SEVT
276100130725     C                   Eval      D3SFAM_W  = W_SFAM
276200130725     C                   Eval      D3FILL_W  = W_FILL
276300130725     C                   Eval      TYP04     = W_FILL
276400130725     C                   Eval      T_PLNV    = X_DWPLAN
276500130725     C                   Exsr      LoadBucketSR
276600130725     C                   Exsr      GetClass
276700130725     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
276800130725     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
276900130725     C                   Eval      D3CLS4  = D3CLS
277000130725     C                   Eval      D3CLSE4 = D3CLSE
277100130725     C                   End
277200130725     C                   End
277300021111      *
277400021111     C                   ENDSR
277500090330      *___________________________________________________________________
277600090330      * Get Plan Master record - Dependents
277700090330      *___________________________________________________________________
277800090330     C     GetPlanMasterDBEGSR
277900090330      *
278000090330      * Medical
278100090330     C                   Eval      W_CAT     = 'PMM'
278200090330     C     DW310Key      Chain     DW310LF
278300090330     C                   If        %Found(DW310LF)
278400141210
278500141210     C                   exsr      CHKACAPLN
278600141210
278700090330     C                   Eval      D3SCAT_W  = 'M'
278800090330     C                   Exsr      PlanStatusSR
278900090819     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
279000090819     C                   If        pxs = 0
279100090819     C                   Eval      W_FILL        = 'N'
279200090819     C                   Eval      TR051         = *BLANKS
279300090819     C                   Else
279400090819     C                   Eval      TR051     = APGM(pxs)
279500090819     C                   End
279600090330     C                   Eval      D3SLVL_W  = W_COVT
279700090330     C                   Eval      D3SEVT_W  = W_SEVT
279800090330     C                   Eval      D3SFAM_W  = W_SFAM
279900091124     C                   Eval      T_PLNM    = X_DWPLAN
280000090730
280100090730      * Force CHANGE on Dep Coverage if Member is CHANGE
280200091002     C****               If        W_FILL = 'A'  and
280300091002     C****                         TYP01  = 'C'
280400091002     C****               Eval      W_FILL    = TYP01
280500091002     C****               Eval      D3FILL_W  = TYP01
280600091002     C****               Else
280700090330     C                   Eval      D3FILL_W  = W_FILL
280800091002     C****               End
280900090515
281000090515      * Reinstate rule: If reinstate, then swap dates to original term date
281100090515     C                   If        D3FILL_W  = 'R'
281200090727     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
281300090515     C                   If        pre > 0
281400090727     C                   Movel     MEFF(pre)     Input_Date
281500090727     C                   Eval      Input_Format  = 'YYYYMMDD'
281600090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
281700090727     C                   Exsr      FormatDateSR
281800090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
281900090727     C                   Else
282000090727     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
282100090727     C                   If        pre > 0
282200090804     C                   Movel     DEFF(pre)     Input_Date
282300090515     C                   Eval      Input_Format  = 'YYYYMMDD'
282400090515     C                   Eval      Output_Format = 'MM/DD/YYYY'
282500090515     C                   Exsr      FormatDateSR
282600090515     C                   Eval      D3SCEF_W  = %trim(Output_Date)
282700090727     C                   End
282800090727     C                   End
282900090515     C                   End
283000090515
283100090330     C                   Exsr      LoadBucketSR
283200090330     C                   Exsr      GetClass
283300100107     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
283400100107     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
283500100107     C                   Eval      D3CLS1  = D3CLS
283600100107     C                   Eval      D3CLSE1 = D3CLSE
283700091117     C*** Mem Only       Exsr      LoadChangeSR
283800090330     C                   Else
283900090330     C     DW310Key      Chain     DW310L2
284000090330     C                   If        %Found(DW310L2)
284100141210
284200141210     C                   exsr      CHKACAPLN
284300141210
284400091002     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
284500091002     C** DT TEST         If        pxs > 0
284600090330     C                   Eval      D3SCAT_W  = 'M'
284700090330     C                   Exsr      PlanStatusSR
284800090330     C                   Eval      D3SLVL_W  = W_COVT
284900090330     C                   Eval      D3SEVT_W  = W_SEVT
285000090330     C                   Eval      D3SFAM_W  = W_SFAM
285100090330     C                   Eval      D3FILL_W  = W_FILL
285200091124     C                   Eval      T_PLNM    = X_DWPLAN
285300090330     C                   Exsr      LoadBucketSR
285400090330     C                   Exsr      GetClass
285500100107     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
285600100107     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
285700100107     C                   Eval      D3CLS1  = D3CLS
285800100107     C                   Eval      D3CLSE1 = D3CLSE
285900091002     C** DT TEST         End
286000090330     C                   End
286100090330     C                   End
286200121023      *
286300121023      * Medical COBRA
286400121023     C                   Eval      W_CAT     = 'PCM'
286500121023     C     DW310Key      Chain     DW310LF
286600121023     C                   If        %Found(DW310LF)
286700141210
286800141210     C                   exsr      CHKACAPLN
286900141210
287000121023     C                   Eval      D3SCAT_W  = 'M'
287100121023     C                   Exsr      PlanStatusSR
287200121023     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
287300121023     C                   If        pxs = 0
287400121023     C                   Eval      W_FILL        = 'N'
287500121023     C                   Eval      TR051         = *BLANKS
287600121023     C                   Else
287700121023     C                   Eval      TR051     = APGM(pxs)
287800121023     C                   End
287900121023     C                   Eval      D3SLVL_W  = W_COVT
288000121023     C                   Eval      D3SEVT_W  = W_SEVT
288100121023     C                   Eval      D3SFAM_W  = W_SFAM
288200121023     C                   Eval      T_PLNM    = X_DWPLAN
288300121023
288400121023      * Force CHANGE on Dep Coverage if Member is CHANGE
288500121023     C****               If        W_FILL = 'A'  and
288600121023     C****                         TYP01  = 'C'
288700121023     C****               Eval      W_FILL    = TYP01
288800121023     C****               Eval      D3FILL_W  = TYP01
288900121023     C****               Else
289000121023     C                   Eval      D3FILL_W  = W_FILL
289100121023     C****               End
289200121023
289300121023      * Reinstate rule: If reinstate, then swap dates to original term date
289400121023     C                   If        D3FILL_W  = 'R'
289500121023     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
289600121023     C                   If        pre > 0
289700121023     C                   Movel     MEFF(pre)     Input_Date
289800121023     C                   Eval      Input_Format  = 'YYYYMMDD'
289900121023     C                   Eval      Output_Format = 'MM/DD/YYYY'
290000121023     C                   Exsr      FormatDateSR
290100121023     C                   Eval      D3SCEF_W  = %trim(Output_Date)
290200121023     C                   Else
290300121023     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
290400121023     C                   If        pre > 0
290500121023     C                   Movel     DEFF(pre)     Input_Date
290600121023     C                   Eval      Input_Format  = 'YYYYMMDD'
290700121023     C                   Eval      Output_Format = 'MM/DD/YYYY'
290800121023     C                   Exsr      FormatDateSR
290900121023     C                   Eval      D3SCEF_W  = %trim(Output_Date)
291000121023     C                   End
291100121023     C                   End
291200121023     C                   End
291300121023
291400121023     C                   Exsr      LoadBucketSR
291500121023     C                   Exsr      GetClass
291600121023     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
291700121023     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
291800121023     C                   Eval      D3CLS1  = D3CLS
291900121023     C                   Eval      D3CLSE1 = D3CLSE
292000121023     C*** Mem Only       Exsr      LoadChangeSR
292100121023     C                   Else
292200121023     C     DW310Key      Chain     DW310L2
292300121023     C                   If        %Found(DW310L2)
292400141210
292500141210     C                   exsr      CHKACAPLN
292600141210
292700121023     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
292800121023     C** DT TEST         If        pxs > 0
292900121023     C                   Eval      D3SCAT_W  = 'M'
293000121023     C                   Exsr      PlanStatusSR
293100121023     C                   Eval      D3SLVL_W  = W_COVT
293200121023     C                   Eval      D3SEVT_W  = W_SEVT
293300121023     C                   Eval      D3SFAM_W  = W_SFAM
293400121023     C                   Eval      D3FILL_W  = W_FILL
293500121023     C                   Eval      T_PLNM    = X_DWPLAN
293600121023     C                   Exsr      LoadBucketSR
293700121023     C                   Exsr      GetClass
293800121023     C                   Eval      D3GRP1  = %trim(%subst(PLNGRP:1:8))
293900121023     C                   Eval      D3SGR1  = %trim(%subst(PLNGRP:9:4))
294000121023     C                   Eval      D3CLS1  = D3CLS
294100121023     C                   Eval      D3CLSE1 = D3CLSE
294200121023     C** DT TEST         End
294300121023     C                   End
294400121023     C                   End
294500121023
294600090330      * Rx Drug
294700090330     C                   Eval      W_CAT     = 'PRX'
294800090330     C     DW310Key      Chain     DW310LF
294900090330     C                   If        %Found(DW310LF)
295000090330     C                   Eval      D3SCAT_W  = 'R'
295100090330     C                   Exsr      PlanStatusSR
295200090819     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
295300090819     C                   If        pxs = 0
295400090819     C                   Eval      W_FILL    = 'N'
295500090819     C                   Eval      TR052     = *BLANKS
295600090819     C                   Else
295700090819     C                   Eval      TR052     = APGM(pxs)
295800090819     C                   End
295900090330     C                   Eval      D3SLVL_W  = W_COVT
296000090330     C                   Eval      D3SEVT_W  = W_SEVT
296100090330     C                   Eval      D3SFAM_W  = W_SFAM
296200091124     C                   Eval      T_PLNR    = X_DWPLAN
296300090730
296400090730      * Force CHANGE on Dep Coverage if Member is CHANGE
296500091002     C***                If        W_FILL = 'A'  and
296600091002     C***                          TYP02  = 'C'
296700091002     C***                Eval      W_FILL    = TYP02
296800091002     C***                Eval      D3FILL_W  = TYP02
296900091002     C***                Else
297000090730     C                   Eval      D3FILL_W  = W_FILL
297100091002     C***                End
297200090727
297300090727      * Reinstate rule: If reinstate, then swap dates to original term date
297400090727     C                   If        D3FILL_W  = 'R'
297500090727     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
297600090727     C                   If        pre > 0
297700090727     C                   Movel     MEFF(pre)     Input_Date
297800090727     C                   Eval      Input_Format  = 'YYYYMMDD'
297900090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
298000090727     C                   Exsr      FormatDateSR
298100090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
298200090727     C                   Else
298300090727     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
298400090727     C                   If        pre > 0
298500090804     C                   Movel     DEFF(pre)     Input_Date
298600090727     C                   Eval      Input_Format  = 'YYYYMMDD'
298700090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
298800090727     C                   Exsr      FormatDateSR
298900090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
299000090727     C                   End
299100090727     C                   End
299200090727     C                   End
299300090727
299400090330     C                   Exsr      LoadBucketSR
299500090330     C                   Exsr      GetClass
299600100107     C                   Eval      D3GRP2  = %trim(%subst(PLNGRP:1:8))
299700100107     C                   Eval      D3SGR2  = %trim(%subst(PLNGRP:9:4))
299800100107     C                   Eval      D3CLS2  = D3CLS
299900100107     C                   Eval      D3CLSE2 = D3CLSE
300000091117     C**** Mem Only      Exsr      LoadChangeSR
300100090330     C                   Else
300200090330     C     DW310Key      Chain     DW310L2
300300090330     C                   If        %Found(DW310L2)
300400091002     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
300500091002     C** DT TEST         If        pxs > 0
300600090330     C                   Eval      D3SCAT_W  = 'R'
300700090330     C                   Exsr      PlanStatusSR
300800090330     C                   Eval      D3SLVL_W  = W_COVT
300900090330     C                   Eval      D3SEVT_W  = W_SEVT
301000090330     C                   Eval      D3SFAM_W  = W_SFAM
301100090330     C                   Eval      D3FILL_W  = W_FILL
301200091124     C                   Eval      T_PLNR    = X_DWPLAN
301300090330     C                   Exsr      LoadBucketSR
301400090330     C                   Exsr      GetClass
301500100107     C                   Eval      D3GRP2  = %trim(%subst(PLNGRP:1:8))
301600100107     C                   Eval      D3SGR2  = %trim(%subst(PLNGRP:9:4))
301700100107     C                   Eval      D3CLS2  = D3CLS
301800100107     C                   Eval      D3CLSE2 = D3CLSE
301900091002     C** DT TEST         End
302000090330     C                   End
302100090330     C                   End
302200110922      * Dental - PDR
302300090330     C                   Eval      W_CAT     = 'PDR'
302400090330     C     DW310Key      Chain     DW310LF
302500090330     C                   If        %Found(DW310LF)
302600090330     C                   Eval      D3SCAT_W  = 'D'
302700090330     C                   Exsr      PlanStatusSR
302800090819     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
302900090819     C                   If        pxs = 0
303000090819     C                   Eval      W_FILL    = 'N'
303100090819     C                   Eval      TR053     = *BLANKS
303200090819     C                   Else
303300090819     C                   Eval      TR053     = APGM(pxs)
303400090819     C                   End
303500090330     C                   Eval      D3SLVL_W  = W_COVT
303600090330     C                   Eval      D3SEVT_W  = W_SEVT
303700090330     C                   Eval      D3SFAM_W  = W_SFAM
303800091124     C                   Eval      T_PLND    = X_DWPLAN
303900090730
304000090730      * Force CHANGE on Dep Coverage if Member is CHANGE
304100091002     C***                If        W_FILL = 'A'  and
304200091002     C***                          TYP03  = 'C'
304300091002     C***                Eval      W_FILL    = TYP03
304400091002     C***                Eval      D3FILL_W  = TYP03
304500091002     C***                Else
304600090730     C                   Eval      D3FILL_W  = W_FILL
304700091002     C***                End
304800090515
304900090727      * Reinstate rule: If reinstate, then swap dates to original term date
305000090727     C                   If        D3FILL_W  = 'R'
305100090727     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
305200090727     C                   If        pre > 0
305300090727     C                   Movel     MEFF(pre)     Input_Date
305400090727     C                   Eval      Input_Format  = 'YYYYMMDD'
305500090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
305600090727     C                   Exsr      FormatDateSR
305700090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
305800090727     C                   Else
305900090727     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
306000090727     C                   If        pre > 0
306100090804     C                   Movel     DEFF(pre)     Input_Date
306200090727     C                   Eval      Input_Format  = 'YYYYMMDD'
306300090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
306400090727     C                   Exsr      FormatDateSR
306500090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
306600090727     C                   End
306700090727     C                   End
306800090727     C                   End
306900090515
307000090330     C                   Exsr      LoadBucketSR
307100090330     C                   Exsr      GetClass
307200100107     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
307300100107     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
307400100107     C                   Eval      D3CLS3  = D3CLS
307500100107     C                   Eval      D3CLSE3 = D3CLSE
307600091117     C**** Mem Only      Exsr      LoadChangeSR
307700090330     C                   Else
307800090330     C     DW310Key      Chain     DW310L2
307900090330     C                   If        %Found(DW310L2)
308000091002     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
308100091002     C** DT TEST         If        pxs > 0
308200090330     C                   Eval      D3SCAT_W  = 'D'
308300090330     C                   Exsr      PlanStatusSR
308400090330     C                   Eval      D3SLVL_W  = W_COVT
308500090330     C                   Eval      D3SEVT_W  = W_SEVT
308600090330     C                   Eval      D3SFAM_W  = W_SFAM
308700090330     C                   Eval      D3FILL_W  = W_FILL
308800091124     C                   Eval      T_PLND    = X_DWPLAN
308900090330     C                   Exsr      LoadBucketSR
309000090330     C                   Exsr      GetClass
309100100107     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
309200100107     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
309300100107     C                   Eval      D3CLS3  = D3CLS
309400100107     C                   Eval      D3CLSE3 = D3CLSE
309500091002     C** DT TEST         End
309600090330     C                   End
309700090330     C                   End
309800140917      * Dental - PCD
309900140917     C                   Eval      W_CAT     = 'PCD'
310000140917     C     DW310Key      Chain     DW310LF
310100140917     C                   If        %Found(DW310LF)
310200140917     C                   Eval      D3SCAT_W  = 'D'
310300140917     C                   Exsr      PlanStatusSR
310400140917     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
310500140917     C                   If        pxs = 0
310600140917     C                   Eval      W_FILL    = 'N'
310700140917     C                   Eval      TR053     = *BLANKS
310800140917     C                   Else
310900140917     C                   Eval      TR053     = APGM(pxs)
311000140917     C                   End
311100140917     C                   Eval      D3SLVL_W  = W_COVT
311200140917     C                   Eval      D3SEVT_W  = W_SEVT
311300140917     C                   Eval      D3SFAM_W  = W_SFAM
311400140917     C                   Eval      T_PLND    = X_DWPLAN
311500140917
311600140917      * Force CHANGE on Dep Coverage if Member is CHANGE
311700140917     C***                If        W_FILL = 'A'  and
311800140917     C***                          TYP03  = 'C'
311900140917     C***                Eval      W_FILL    = TYP03
312000140917     C***                Eval      D3FILL_W  = TYP03
312100140917     C***                Else
312200140917     C                   Eval      D3FILL_W  = W_FILL
312300140917     C***                End
312400140917
312500140917      * Reinstate rule: If reinstate, then swap dates to original term date
312600140917     C                   If        D3FILL_W  = 'R'
312700140917     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
312800140917     C                   If        pre > 0
312900140917     C                   Movel     MEFF(pre)     Input_Date
313000140917     C                   Eval      Input_Format  = 'YYYYMMDD'
313100140917     C                   Eval      Output_Format = 'MM/DD/YYYY'
313200140917     C                   Exsr      FormatDateSR
313300140917     C                   Eval      D3SCEF_W  = %trim(Output_Date)
313400140917     C                   Else
313500140917     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
313600140917     C                   If        pre > 0
313700140917     C                   Movel     DEFF(pre)     Input_Date
313800140917     C                   Eval      Input_Format  = 'YYYYMMDD'
313900140917     C                   Eval      Output_Format = 'MM/DD/YYYY'
314000140917     C                   Exsr      FormatDateSR
314100140917     C                   Eval      D3SCEF_W  = %trim(Output_Date)
314200140917     C                   End
314300140917     C                   End
314400140917     C                   End
314500140917
314600140917     C                   Exsr      LoadBucketSR
314700140917     C                   Exsr      GetClass
314800140917     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
314900140917     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
315000140917     C                   Eval      D3CLS3  = D3CLS
315100140917     C                   Eval      D3CLSE3 = D3CLSE
315200140917     C**** Mem Only      Exsr      LoadChangeSR
315300140917     C                   Else
315400140917     C     DW310Key      Chain     DW310L2
315500140917     C                   If        %Found(DW310L2)
315600140917     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
315700140917     C** DT TEST         If        pxs > 0
315800140917     C                   Eval      D3SCAT_W  = 'D'
315900140917     C                   Exsr      PlanStatusSR
316000140917     C                   Eval      D3SLVL_W  = W_COVT
316100140917     C                   Eval      D3SEVT_W  = W_SEVT
316200140917     C                   Eval      D3SFAM_W  = W_SFAM
316300140917     C                   Eval      D3FILL_W  = W_FILL
316400140917     C                   Eval      T_PLND    = X_DWPLAN
316500140917     C                   Exsr      LoadBucketSR
316600140917     C                   Exsr      GetClass
316700140917     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
316800140917     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
316900140917     C                   Eval      D3CLS3  = D3CLS
317000140917     C                   Eval      D3CLSE3 = D3CLSE
317100140917     C** DT TEST         End
317200140917     C                   End
317300140917     C                   End
317400110922      * Dental - PDN
317500110922     C                   Eval      W_CAT     = 'PDN'
317600110922     C     DW310Key      Chain     DW310LF
317700110922     C                   If        %Found(DW310LF)
317800110922     C                   Eval      D3SCAT_W  = 'D'
317900110922     C                   Exsr      PlanStatusSR
318000110922     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
318100110922     C                   If        pxs = 0
318200110922     C                   Eval      W_FILL    = 'N'
318300110922     C                   Eval      TR053     = *BLANKS
318400110922     C                   Else
318500110922     C                   Eval      TR053     = APGM(pxs)
318600110922     C                   End
318700110922     C                   Eval      D3SLVL_W  = W_COVT
318800110922     C                   Eval      D3SEVT_W  = W_SEVT
318900110922     C                   Eval      D3SFAM_W  = W_SFAM
319000110922     C                   Eval      T_PLND    = X_DWPLAN
319100110922
319200110922      * Force CHANGE on Dep Coverage if Member is CHANGE
319300110922     C***                If        W_FILL = 'A'  and
319400110922     C***                          TYP03  = 'C'
319500110922     C***                Eval      W_FILL    = TYP03
319600110922     C***                Eval      D3FILL_W  = TYP03
319700110922     C***                Else
319800110922     C                   Eval      D3FILL_W  = W_FILL
319900110922     C***                End
320000110922
320100110922      * Reinstate rule: If reinstate, then swap dates to original term date
320200110922     C                   If        D3FILL_W  = 'R'
320300110922     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
320400110922     C                   If        pre > 0
320500110922     C                   Movel     MEFF(pre)     Input_Date
320600110922     C                   Eval      Input_Format  = 'YYYYMMDD'
320700110922     C                   Eval      Output_Format = 'MM/DD/YYYY'
320800110922     C                   Exsr      FormatDateSR
320900110922     C                   Eval      D3SCEF_W  = %trim(Output_Date)
321000110922     C                   Else
321100110922     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
321200110922     C                   If        pre > 0
321300110922     C                   Movel     DEFF(pre)     Input_Date
321400110922     C                   Eval      Input_Format  = 'YYYYMMDD'
321500110922     C                   Eval      Output_Format = 'MM/DD/YYYY'
321600110922     C                   Exsr      FormatDateSR
321700110922     C                   Eval      D3SCEF_W  = %trim(Output_Date)
321800110922     C                   End
321900110922     C                   End
322000110922     C                   End
322100110922
322200110922     C                   Exsr      LoadBucketSR
322300110922     C                   Exsr      GetClass
322400110922     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
322500110922     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
322600110922     C                   Eval      D3CLS3  = D3CLS
322700110922     C                   Eval      D3CLSE3 = D3CLSE
322800110922     C**** Mem Only      Exsr      LoadChangeSR
322900110922     C                   Else
323000110922     C     DW310Key      Chain     DW310L2
323100110922     C                   If        %Found(DW310L2)
323200110922     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
323300110922     C** DT TEST         If        pxs > 0
323400110922     C                   Eval      D3SCAT_W  = 'D'
323500110922     C                   Exsr      PlanStatusSR
323600110922     C                   Eval      D3SLVL_W  = W_COVT
323700110922     C                   Eval      D3SEVT_W  = W_SEVT
323800110922     C                   Eval      D3SFAM_W  = W_SFAM
323900110922     C                   Eval      D3FILL_W  = W_FILL
324000110922     C                   Eval      T_PLND    = X_DWPLAN
324100110922     C                   Exsr      LoadBucketSR
324200110922     C                   Exsr      GetClass
324300110922     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
324400110922     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
324500110922     C                   Eval      D3CLS3  = D3CLS
324600110922     C                   Eval      D3CLSE3 = D3CLSE
324700110922     C** DT TEST         End
324800110922     C                   End
324900110922     C                   End
325000130118      * Dental - PDE
325100130118     C                   Eval      W_CAT     = 'PDE'
325200130118     C     DW310Key      Chain     DW310LF
325300130118     C                   If        %Found(DW310LF)
325400130118     C                   Eval      D3SCAT_W  = 'D'
325500130118     C                   Exsr      PlanStatusSR
325600130118     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
325700130118     C                   If        pxs = 0
325800130118     C                   Eval      W_FILL    = 'N'
325900130118     C                   Eval      TR053     = *BLANKS
326000130118     C                   Else
326100130118     C                   Eval      TR053     = APGM(pxs)
326200130118     C                   End
326300130118     C                   Eval      D3SLVL_W  = W_COVT
326400130118     C                   Eval      D3SEVT_W  = W_SEVT
326500130118     C                   Eval      D3SFAM_W  = W_SFAM
326600130118     C                   Eval      T_PLND    = X_DWPLAN
326700130118
326800130118      * Force CHANGE on Dep Coverage if Member is CHANGE
326900130118     C***                If        W_FILL = 'A'  and
327000130118     C***                          TYP03  = 'C'
327100130118     C***                Eval      W_FILL    = TYP03
327200130118     C***                Eval      D3FILL_W  = TYP03
327300130118     C***                Else
327400130118     C                   Eval      D3FILL_W  = W_FILL
327500130118     C***                End
327600130118
327700130118      * Reinstate rule: If reinstate, then swap dates to original term date
327800130118     C                   If        D3FILL_W  = 'R'
327900130118     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
328000130118     C                   If        pre > 0
328100130118     C                   Movel     MEFF(pre)     Input_Date
328200130118     C                   Eval      Input_Format  = 'YYYYMMDD'
328300130118     C                   Eval      Output_Format = 'MM/DD/YYYY'
328400130118     C                   Exsr      FormatDateSR
328500130118     C                   Eval      D3SCEF_W  = %trim(Output_Date)
328600130118     C                   Else
328700130118     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
328800130118     C                   If        pre > 0
328900130118     C                   Movel     DEFF(pre)     Input_Date
329000130118     C                   Eval      Input_Format  = 'YYYYMMDD'
329100130118     C                   Eval      Output_Format = 'MM/DD/YYYY'
329200130118     C                   Exsr      FormatDateSR
329300130118     C                   Eval      D3SCEF_W  = %trim(Output_Date)
329400130118     C                   End
329500130118     C                   End
329600130118     C                   End
329700130118
329800130118     C                   Exsr      LoadBucketSR
329900130118     C                   Exsr      GetClass
330000130118     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
330100130118     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
330200130118     C                   Eval      D3CLS3  = D3CLS
330300130118     C                   Eval      D3CLSE3 = D3CLSE
330400130118     C**** Mem Only      Exsr      LoadChangeSR
330500130118     C                   Else
330600130118     C     DW310Key      Chain     DW310L2
330700130118     C                   If        %Found(DW310L2)
330800130118     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
330900130118     C** DT TEST         If        pxs > 0
331000130118     C                   Eval      D3SCAT_W  = 'D'
331100130118     C                   Exsr      PlanStatusSR
331200130118     C                   Eval      D3SLVL_W  = W_COVT
331300130118     C                   Eval      D3SEVT_W  = W_SEVT
331400130118     C                   Eval      D3SFAM_W  = W_SFAM
331500130118     C                   Eval      D3FILL_W  = W_FILL
331600130118     C                   Eval      T_PLND    = X_DWPLAN
331700130118     C                   Exsr      LoadBucketSR
331800130118     C                   Exsr      GetClass
331900130118     C                   Eval      D3GRP3  = %trim(%subst(PLNGRP:1:8))
332000130118     C                   Eval      D3SGR3  = %trim(%subst(PLNGRP:9:4))
332100130118     C                   Eval      D3CLS3  = D3CLS
332200130118     C                   Eval      D3CLSE3 = D3CLSE
332300130118     C** DT TEST         End
332400130118     C                   End
332500130118     C                   End
332600110922      * Vision - PVR
332700090330     C                   Eval      W_CAT     = 'PVR'
332800090330     C     DW310Key      Chain     DW310LF
332900090330     C                   If        %Found(DW310LF)
333000090330     C                   Eval      D3SCAT_W  = 'V'
333100090330     C                   Exsr      PlanStatusSR
333200090819     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
333300090819     C                   If        pxs = 0
333400090819     C                   Eval      W_FILL    = 'N'
333500090819     C                   Eval      TR054     = *BLANKS
333600090819     C                   Else
333700090819     C                   Eval      TR054     = APGM(pxs)
333800090819     C                   End
333900090330     C                   Eval      D3SLVL_W  = W_COVT
334000090330     C                   Eval      D3SEVT_W  = W_SEVT
334100090330     C                   Eval      D3SFAM_W  = W_SFAM
334200091124     C                   Eval      T_PLNV    = X_DWPLAN
334300090730
334400090730      * Force CHANGE on Dep Coverage if Member is CHANGE
334500091002     C***                If        W_FILL = 'A'  and
334600091002     C***                          TYP04  = 'C'
334700091002     C***                Eval      W_FILL    = TYP04
334800091002     C***                Eval      D3FILL_W  = TYP04
334900091002     C***                Else
335000090730     C                   Eval      D3FILL_W  = W_FILL
335100091002     C***                End
335200090515
335300090727      * Reinstate rule: If reinstate, then swap dates to original term date
335400090727     C                   If        D3FILL_W  = 'R'
335500090727     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
335600090727     C                   If        pre > 0
335700090727     C                   Movel     MEFF(pre)     Input_Date
335800090727     C                   Eval      Input_Format  = 'YYYYMMDD'
335900090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
336000090727     C                   Exsr      FormatDateSR
336100090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
336200090727     C                   Else
336300090727     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
336400090727     C                   If        pre > 0
336500090804     C                   Movel     DEFF(pre)     Input_Date
336600090727     C                   Eval      Input_Format  = 'YYYYMMDD'
336700090727     C                   Eval      Output_Format = 'MM/DD/YYYY'
336800090727     C                   Exsr      FormatDateSR
336900090727     C                   Eval      D3SCEF_W  = %trim(Output_Date)
337000090727     C                   End
337100090727     C                   End
337200090727     C                   End
337300090515
337400090330     C                   Exsr      LoadBucketSR
337500090330     C                   Exsr      GetClass
337600100107     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
337700100107     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
337800100107     C                   Eval      D3CLS4  = D3CLS
337900100107     C                   Eval      D3CLSE4 = D3CLSE
338000091117     C**** Mem Only      Exsr      LoadChangeSR
338100090330     C                   Else
338200090330     C     DW310Key      Chain     DW310L2
338300090330     C                   If        %Found(DW310L2)
338400091002     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
338500091002     C** DT TEST         If        pxs > 0
338600090330     C                   Eval      D3SCAT_W  = 'V'
338700090330     C                   Exsr      PlanStatusSR
338800090330     C                   Eval      D3SLVL_W  = W_COVT
338900090330     C                   Eval      D3SEVT_W  = W_SEVT
339000090330     C                   Eval      D3SFAM_W  = W_SFAM
339100090330     C                   Eval      D3FILL_W  = W_FILL
339200091124     C                   Eval      T_PLNV    = X_DWPLAN
339300090330     C                   Exsr      LoadBucketSR
339400090330     C                   Exsr      GetClass
339500100107     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
339600100107     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
339700100107     C                   Eval      D3CLS4  = D3CLS
339800100107     C                   Eval      D3CLSE4 = D3CLSE
339900091002     C** DT TEST         End
340000090330     C                   End
340100090330     C                   End
340200110922      * Vision - PVS
340300110922     C                   Eval      W_CAT     = 'PVS'
340400110922     C     DW310Key      Chain     DW310LF
340500110922     C                   If        %Found(DW310LF)
340600110922     C                   Eval      D3SCAT_W  = 'V'
340700110922     C                   Exsr      PlanStatusSR
340800110922     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
340900110922     C                   If        pxs = 0
341000110922     C                   Eval      W_FILL    = 'N'
341100110922     C                   Eval      TR054     = *BLANKS
341200110922     C                   Else
341300110922     C                   Eval      TR054     = APGM(pxs)
341400110922     C                   End
341500110922     C                   Eval      D3SLVL_W  = W_COVT
341600110922     C                   Eval      D3SEVT_W  = W_SEVT
341700110922     C                   Eval      D3SFAM_W  = W_SFAM
341800110922     C                   Eval      T_PLNV    = X_DWPLAN
341900110922
342000110922      * Force CHANGE on Dep Coverage if Member is CHANGE
342100110922     C***                If        W_FILL = 'A'  and
342200110922     C***                          TYP04  = 'C'
342300110922     C***                Eval      W_FILL    = TYP04
342400110922     C***                Eval      D3FILL_W  = TYP04
342500110922     C***                Else
342600110922     C                   Eval      D3FILL_W  = W_FILL
342700110922     C***                End
342800110922
342900110922      * Reinstate rule: If reinstate, then swap dates to original term date
343000110922     C                   If        D3FILL_W  = 'R'
343100110922     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
343200110922     C                   If        pre > 0
343300110922     C                   Movel     MEFF(pre)     Input_Date
343400110922     C                   Eval      Input_Format  = 'YYYYMMDD'
343500110922     C                   Eval      Output_Format = 'MM/DD/YYYY'
343600110922     C                   Exsr      FormatDateSR
343700110922     C                   Eval      D3SCEF_W  = %trim(Output_Date)
343800110922     C                   Else
343900110922     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
344000110922     C                   If        pre > 0
344100110922     C                   Movel     DEFF(pre)     Input_Date
344200110922     C                   Eval      Input_Format  = 'YYYYMMDD'
344300110922     C                   Eval      Output_Format = 'MM/DD/YYYY'
344400110922     C                   Exsr      FormatDateSR
344500110922     C                   Eval      D3SCEF_W  = %trim(Output_Date)
344600110922     C                   End
344700110922     C                   End
344800110922     C                   End
344900110922
345000110922     C                   Exsr      LoadBucketSR
345100110922     C                   Exsr      GetClass
345200110922     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
345300110922     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
345400110922     C                   Eval      D3CLS4  = D3CLS
345500110922     C                   Eval      D3CLSE4 = D3CLSE
345600110922     C**** Mem Only      Exsr      LoadChangeSR
345700110922     C                   Else
345800110922     C     DW310Key      Chain     DW310L2
345900110922     C                   If        %Found(DW310L2)
346000110922     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
346100110922     C** DT TEST         If        pxs > 0
346200110922     C                   Eval      D3SCAT_W  = 'V'
346300110922     C                   Exsr      PlanStatusSR
346400110922     C                   Eval      D3SLVL_W  = W_COVT
346500110922     C                   Eval      D3SEVT_W  = W_SEVT
346600110922     C                   Eval      D3SFAM_W  = W_SFAM
346700110922     C                   Eval      D3FILL_W  = W_FILL
346800110922     C                   Eval      T_PLNV    = X_DWPLAN
346900110922     C                   Exsr      LoadBucketSR
347000110922     C                   Exsr      GetClass
347100110922     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
347200110922     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
347300110922     C                   Eval      D3CLS4  = D3CLS
347400110922     C                   Eval      D3CLSE4 = D3CLSE
347500110922     C** DT TEST         End
347600110922     C                   End
347700110922     C                   End
347800130725      * Vision - PCV
347900130725     C                   Eval      W_CAT     = 'PCV'
348000130725     C     DW310Key      Chain     DW310LF
348100130725     C                   If        %Found(DW310LF)
348200130725     C                   Eval      D3SCAT_W  = 'V'
348300130725     C                   Exsr      PlanStatusSR
348400130725     C                   Eval      pxs = %lookup(X_DWPLAN:APLN)
348500130725     C                   If        pxs = 0
348600130725     C                   Eval      W_FILL    = 'N'
348700130725     C                   Eval      TR054     = *BLANKS
348800130725     C                   Else
348900130725     C                   Eval      TR054     = APGM(pxs)
349000130725     C                   End
349100130725     C                   Eval      D3SLVL_W  = W_COVT
349200130725     C                   Eval      D3SEVT_W  = W_SEVT
349300130725     C                   Eval      D3SFAM_W  = W_SFAM
349400130725     C                   Eval      T_PLNV    = X_DWPLAN
349500130725
349600130725      * Force CHANGE on Dep Coverage if Member is CHANGE
349700130725     C***                If        W_FILL = 'A'  and
349800130725     C***                          TYP04  = 'C'
349900130725     C***                Eval      W_FILL    = TYP04
350000130725     C***                Eval      D3FILL_W  = TYP04
350100130725     C***                Else
350200130725     C                   Eval      D3FILL_W  = W_FILL
350300130725     C***                End
350400130725
350500130725      * Reinstate rule: If reinstate, then swap dates to original term date
350600130725     C                   If        D3FILL_W  = 'R'
350700130725     C                   Eval      pre = %lookup(X_DWPLAN:MPLN)
350800130725     C                   If        pre > 0
350900130725     C                   Movel     MEFF(pre)     Input_Date
351000130725     C                   Eval      Input_Format  = 'YYYYMMDD'
351100130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
351200130725     C                   Exsr      FormatDateSR
351300130725     C                   Eval      D3SCEF_W  = %trim(Output_Date)
351400130725     C                   Else
351500130725     C                   Eval      pre = %lookup(X_DWPLAN:APLN)
351600130725     C                   If        pre > 0
351700130725     C                   Movel     DEFF(pre)     Input_Date
351800130725     C                   Eval      Input_Format  = 'YYYYMMDD'
351900130725     C                   Eval      Output_Format = 'MM/DD/YYYY'
352000130725     C                   Exsr      FormatDateSR
352100130725     C                   Eval      D3SCEF_W  = %trim(Output_Date)
352200130725     C                   End
352300130725     C                   End
352400130725     C                   End
352500130725
352600130725     C                   Exsr      LoadBucketSR
352700130725     C                   Exsr      GetClass
352800130725     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
352900130725     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
353000130725     C                   Eval      D3CLS4  = D3CLS
353100130725     C                   Eval      D3CLSE4 = D3CLSE
353200130725     C**** Mem Only      Exsr      LoadChangeSR
353300130725     C                   Else
353400130725     C     DW310Key      Chain     DW310L2
353500130725     C                   If        %Found(DW310L2)
353600130725     C** DT TEST         Eval      pxs = %lookup(X_DWPLAN:APLN)
353700130725     C** DT TEST         If        pxs > 0
353800130725     C                   Eval      D3SCAT_W  = 'V'
353900130725     C                   Exsr      PlanStatusSR
354000130725     C                   Eval      D3SLVL_W  = W_COVT
354100130725     C                   Eval      D3SEVT_W  = W_SEVT
354200130725     C                   Eval      D3SFAM_W  = W_SFAM
354300130725     C                   Eval      D3FILL_W  = W_FILL
354400130725     C                   Eval      T_PLNV    = X_DWPLAN
354500130725     C                   Exsr      LoadBucketSR
354600130725     C                   Exsr      GetClass
354700130725     C                   Eval      D3GRP4  = %trim(%subst(PLNGRP:1:8))
354800130725     C                   Eval      D3SGR4  = %trim(%subst(PLNGRP:9:4))
354900130725     C                   Eval      D3CLS4  = D3CLS
355000130725     C                   Eval      D3CLSE4 = D3CLSE
355100130725     C** DT TEST         End
355200130725     C                   End
355300130725     C                   End
355400090330      *
355500090330     C                   ENDSR
355600021111      *___________________________________________________________________
355700021111      * Load Coverage Bucket
355800021111      *___________________________________________________________________
355900021111     C     LoadBucketSR  BEGSR
356000021111      *
356100021111      * Select Bucket
356200021111     C                   Select
356300090401     C                   When      D3SCAT1  =   *Blanks  and
356400090401     C                             D3SCAT_W =   'M'
356500021111     C                   Eval      D3SCAT1  =   D3SCAT_W
356600081112     C                   Eval      D3SCEF1  =   D3SCEF_W
356700081112     C                   Eval      D3SCTR1  =   D3SCTR_W
356800021112     C                   Eval      D3SEVT1  =   D3SEVT_W
356900090326     C                   Eval      D3SFAM1  =   D3SFAM_W
357000090326     C                   Eval      D3FIL41  =   D3FILL_W
357100081112     C                   Eval      D3SLVL1  =   D3SLVL_W
357200090401     C                   When      D3SCAT2  =   *Blanks  and
357300090401     C                             D3SCAT_W =   'R'
357400021111     C                   Eval      D3SCAT2  =   D3SCAT_W
357500021112     C                   Eval      D3SCEF2  =   D3SCEF_W
357600081112     C                   Eval      D3SCTR2  =   D3SCTR_W
357700021112     C                   Eval      D3SEVT2  =   D3SEVT_W
357800021112     C                   Eval      D3SFAM2  =   D3SFAM_W
357900090326     C                   Eval      D3FIL42  =   D3FILL_W
358000081112     C                   Eval      D3SLVL2  =   D3SLVL_W
358100090401     C                   When      D3SCAT3  =   *Blanks  and
358200090401     C                             D3SCAT_W =   'D'
358300021111     C                   Eval      D3SCAT3  =   D3SCAT_W
358400021112     C                   Eval      D3SCEF3  =   D3SCEF_W
358500081112     C                   Eval      D3SCTR3  =   D3SCTR_W
358600021112     C                   Eval      D3SEVT3  =   D3SEVT_W
358700021112     C                   Eval      D3SFAM3  =   D3SFAM_W
358800090326     C                   Eval      D3FIL43  =   D3FILL_W
358900081112     C                   Eval      D3SLVL3  =   D3SLVL_W
359000090401     C                   When      D3SCAT4  =   *Blanks  and
359100090401     C                             D3SCAT_W =   'V'
359200021111     C                   Eval      D3SCAT4  =   D3SCAT_W
359300021112     C                   Eval      D3SCEF4  =   D3SCEF_W
359400081112     C                   Eval      D3SCTR4  =   D3SCTR_W
359500021112     C                   Eval      D3SEVT4  =   D3SEVT_W
359600021112     C                   Eval      D3SFAM4  =   D3SFAM_W
359700090326     C                   Eval      D3FIL44  =   D3FILL_W
359800081112     C                   Eval      D3SLVL4  =   D3SLVL_W
359900021111     C                   Other
360000021111     C                   Endsl
360100021111      *
360200021025     C                   ENDSR
360300090401      *___________________________________________________________________
360400090401      * Load Coverage Bucket for Terms/Changes
360500090401      *___________________________________________________________________
360600090401     C     LoadChangeSR  BEGSR
360700090409      *
360800090409      * Only Fill Term Buckets if Add Coverage Mode
360900090409     C                   If        W_FILL  = 'A'
361000090401      *
361100090401      * Medical - Term
361200121023     C                   If        W_CAT   = 'PMM' or
361300121023     C                             W_CAT   = 'PCM'
361400090401     C     DW310Key      Chain     DW310L2
361500090401     C                   If        %Found(DW310L2)
361600090401     C                   Exsr      PlanStatusSR
361700090813     C                   If        W_FILL  = 'T' or
361800090813     C                             W_FILL  = 'S'
361900091221     C******             Eval      D3FIL41 = 'C'
362000090730     C                   Eval      TYP01   = 'C'
362100090729     C                   Eval      D3FIL45  = W_FILL
362200090729     C                   Eval      D3SLVL5  = W_COVT
362300090729     C                   End
362400090803     C                   End
362500090401     C                   End
362600090401      *
362700090401      * RX - Term
362800090803     C                   If        W_CAT     = 'PRX'
362900090401     C     DW310Key      Chain     DW310L2
363000090401     C                   If        %Found(DW310L2)
363100090729     C                   Exsr      PlanStatusSR
363200090813     C                   If        W_FILL  = 'T' or
363300090813     C                             W_FILL  = 'S'
363400091221     C*********          Eval      D3FIL42 = 'C'
363500090730     C                   Eval      TYP02   = 'C'
363600090729     C                   Eval      D3FIL46  = W_FILL
363700090729     C                   Eval      D3SLVL6  = W_COVT
363800090729     C                   End
363900090803     C                   End
364000090729     C                   End
364100090401      *
364200110922      * DENTAL - Term - PDR
364300090803     C                   If        W_CAT     = 'PDR'
364400090401     C     DW310Key      Chain     DW310L2
364500090401     C                   If        %Found(DW310L2)
364600090729     C                   Exsr      PlanStatusSR
364700090813     C                   If        W_FILL  = 'T' or
364800090813     C                             W_FILL  = 'S'
364900091221     C*********          Eval      D3FIL43 = 'C'
365000090730     C                   Eval      TYP03   = 'C'
365100090729     C                   Eval      D3FIL47  = W_FILL
365200090729     C                   Eval      D3SLVL7  = W_COVT
365300090729     C                   End
365400090803     C                   End
365500090729     C                   End
365600140917      *
365700140917      * DENTAL - Term - PCD
365800140917     C                   If        W_CAT     = 'PCD'
365900140917     C     DW310Key      Chain     DW310L2
366000140917     C                   If        %Found(DW310L2)
366100140917     C                   Exsr      PlanStatusSR
366200140917     C                   If        W_FILL  = 'T' or
366300140917     C                             W_FILL  = 'S'
366400140917     C*********          Eval      D3FIL43 = 'C'
366500140917     C                   Eval      TYP03   = 'C'
366600140917     C                   Eval      D3FIL47  = W_FILL
366700140917     C                   Eval      D3SLVL7  = W_COVT
366800140917     C                   End
366900140917     C                   End
367000140917     C                   End
367100110922      * DENTAL - Term - PDN
367200110922     C                   If        W_CAT     = 'PDN'
367300110922     C     DW310Key      Chain     DW310L2
367400110922     C                   If        %Found(DW310L2)
367500110922     C                   Exsr      PlanStatusSR
367600110922     C                   If        W_FILL  = 'T' or
367700110922     C                             W_FILL  = 'S'
367800110922     C*********          Eval      D3FIL43 = 'C'
367900110922     C                   Eval      TYP03   = 'C'
368000110922     C                   Eval      D3FIL47  = W_FILL
368100110922     C                   Eval      D3SLVL7  = W_COVT
368200110922     C                   End
368300110922     C                   End
368400110922     C                   End
368500130118      *
368600130118      * DENTAL - Term - PDE
368700130118     C                   If        W_CAT     = 'PDE'
368800130118     C     DW310Key      Chain     DW310L2
368900130118     C                   If        %Found(DW310L2)
369000130118     C                   Exsr      PlanStatusSR
369100130118     C                   If        W_FILL  = 'T' or
369200130118     C                             W_FILL  = 'S'
369300130118     C*********          Eval      D3FIL43 = 'C'
369400130118     C                   Eval      TYP03   = 'C'
369500130118     C                   Eval      D3FIL47  = W_FILL
369600130118     C                   Eval      D3SLVL7  = W_COVT
369700130118     C                   End
369800130118     C                   End
369900130118     C                   End
370000090401      *
370100110922      * VISION - Term - PVR
370200090803     C                   If        W_CAT     = 'PVR'
370300090401     C     DW310Key      Chain     DW310L2
370400090401     C                   If        %Found(DW310L2)
370500090729     C                   Exsr      PlanStatusSR
370600090813     C                   If        W_FILL  = 'T' or
370700090813     C                             W_FILL  = 'S'
370800091221     C*********          Eval      D3FIL44 = 'C'
370900090730     C                   Eval      TYP04   = 'C'
371000090729     C                   Eval      D3FIL48  = W_FILL
371100090729     C                   Eval      D3SLVL8  = W_COVT
371200090729     C                   End
371300090803     C                   End
371400090729     C                   End
371500110922      *
371600110922      * VISION - Term - PVS
371700110922     C                   If        W_CAT     = 'PVS'
371800110922     C     DW310Key      Chain     DW310L2
371900110922     C                   If        %Found(DW310L2)
372000110922     C                   Exsr      PlanStatusSR
372100110922     C                   If        W_FILL  = 'T' or
372200110922     C                             W_FILL  = 'S'
372300110922     C*********          Eval      D3FIL44 = 'C'
372400110922     C                   Eval      TYP04   = 'C'
372500110922     C                   Eval      D3FIL48  = W_FILL
372600110922     C                   Eval      D3SLVL8  = W_COVT
372700110922     C                   End
372800110922     C                   End
372900110922     C                   End
373000130725      *
373100130725      * VISION - Term - PCV
373200130725     C                   If        W_CAT     = 'PCV'
373300130725     C     DW310Key      Chain     DW310L2
373400130725     C                   If        %Found(DW310L2)
373500130725     C                   Exsr      PlanStatusSR
373600130725     C                   If        W_FILL  = 'T' or
373700130725     C                             W_FILL  = 'S'
373800130725     C*********          Eval      D3FIL44 = 'C'
373900130725     C                   Eval      TYP04   = 'C'
374000130725     C                   Eval      D3FIL48  = W_FILL
374100130725     C                   Eval      D3SLVL8  = W_COVT
374200130725     C                   End
374300130725     C                   End
374400130725     C                   End
374500090409      *
374600090409     C                   End
374700090401      *
374800090401     C                   ENDSR
374900021029      *___________________________________________________________________
375000021029      * Determine Plan Status - Term or Enrolled
375100021029      *___________________________________________________________________
375200021029     C     PlanStatusSR  BEGSR
375300100114      *
375400100114     C     TRKKEY        Klist
375500100114     C                   Kfld                    X_DWSSNO
375600100114     C                   Kfld                    X_DWSEQ#
375700100114     C                   Kfld                    X_DWPLAN
375800100114     C                   Kfld                    X_DWENRL
375900140214
376000021111     C                   Eval      W_COVT   =    %trim(%subst(X_DWCOVT:2:2))
376100021206     C                   Eval      W_IN_ONLY =   'Y'
376200021029      *
376300021029     C                   Select
376400021219      * Termed (sub -1 day) if not same day term.
376500021111     C                   When      X_DWCAND <>   *ZEROS
376600021219     C                   If        X_DWCAND <>   X_DWENRL
376700021216     C     *YMD          MOVE      X_DWCAND      ISO_DATE
376800021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
376900070129     C     *ISO          MOVE      ISO_DATE      X_DWCAND
377000021219     C                   End
377100090813
377200090813     C                   If        X_DWCAND <>   X_DWENRL
377300090326     C                   Eval      W_SEVT        = 'TM'
377400090326     C                   Eval      W_FILL        = 'T'
377500090813     C                   Else
377600100114      * If already sent, then not Same Day Term
377700100114     C     TRKKEY        Chain     DW311TRK
377800100114     C                   If        %found(DW311TRK)
377900100114     C                   Eval      W_SEVT        = 'TM'
378000100121     C                   Eval      W_FILL        = 'T'
378100100121     C     *YMD          MOVE      X_DWCAND      ISO_DATE
378200100121     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
378300100121     C     *ISO          MOVE      ISO_DATE      X_DWCAND
378400100114     C                   Else
378500091014     C                   Eval      pss = %lookup(X_DWPLAN:APLN)
378600091014     C                   If        pss > 0
378700090813     C                   Eval      W_SEVT        = 'TM'
378800090813     C                   Eval      W_FILL        = 'S'
378900091014     C                   Else
379000091014      * Same Day Term WASHout
379100091029     C                   Eval      W_FILL        = 'W'
379200100114     C                   End
379300091014     C                   End
379400090813     C                   End
379500081111
379600021111     C                   Movel     X_DWCAND      Input_Date
379700021029     C                   Eval      Input_Format  = 'YYYYMMDD'
379800021029     C                   Eval      Output_Format = 'MM/DD/YYYY'
379900021029     C                   Exsr      FormatDateSR
380000081111     C                   Eval      D3SCTR_W  = %trim(Output_Date)
380100081111
380200081111     C                   Movel     X_DWENRL      Input_Date
380300081111     C                   Eval      Input_Format  = 'YYYYMMDD'
380400081111     C                   Eval      Output_Format = 'MM/DD/YYYY'
380500081111     C                   Exsr      FormatDateSR
380600081111     C                   Eval      D3SCEF_W  = %trim(Output_Date)
380700021212      *
380800021212      * Save Lastest Term Date
380900021212     C                   If        W_DEPTRM < X_DWCAND
381000021212     C                   Eval      W_DEPTRM = X_DWCAND
381100021212     C                   End
381200021029      *
381300021029      * Enrollment Date (MCOV) to Subsriber Coverage Effect Date
381400021029     C                   Other
381500021111     C                   Movel     X_DWENRL      Input_Date
381600021029     C                   Eval      Input_Format  = 'YYYYMMDD'
381700021029     C                   Eval      Output_Format = 'MM/DD/YYYY'
381800021029     C                   Exsr      FormatDateSR
381900081111     C                   Eval      D3SCEF_W  = %trim(Output_Date)
382000081111     C                   Eval      D3SCTR_W  = *BLANKS
382100081111
382200090407     C                   Eval      pqq = %lookup(X_DWPLAN:APLN)
382300090403     C                   If        pqq > 0
382400090403     C                   Select
382500090403     C                   When      APCD(pqq) = 'MA'
382600090403     C                   Eval      W_FILL        = 'A'
382700090403     C                   When      APCD(pqq) = 'AC'
382800090403     C                   Eval      W_FILL        = 'A'
382900091029      *
383000091117      * Special:  When coverage level change, use new effective date if future.
383100090403     C                   When      APCD(pqq) = 'MC'
383200090403     C                   Eval      W_FILL        = 'C'
383300091117     C                   If        AEFF(pqq) > X_DWENRL
383400091029     C                   Movel     AEFF(pqq)     Input_Date
383500091029     C                   Eval      Input_Format  = 'YYYYMMDD'
383600091029     C                   Eval      Output_Format = 'MM/DD/YYYY'
383700091029     C                   Exsr      FormatDateSR
383800091029     C                   Eval      D3SCEF_W  = %trim(Output_Date)
383900091029     C                   Movel     AEFF(pqq)     X_DWENRL
384000091117     C                   End
384100091029      *
384200090403     C                   When      APCD(pqq) = 'ME'
384300090403     C                   Eval      W_FILL        = 'C'
384400090403     C                   When      APCD(pqq) = 'MD'
384500090403     C                   Eval      W_FILL        = 'C'
384600090403     C                   When      APCD(pqq) = 'MT'
384700090403     C                   Eval      W_FILL        = 'T'
384800090403     C                   When      APCD(pqq) = 'MR'
384900090403     C                   Eval      W_FILL        = 'R'
385000090403     C                   When      APCD(pqq) = 'DA'
385100090403     C                   Eval      W_FILL        = 'A'
385200090403     C                   When      APCD(pqq) = 'DD'
385300090403     C                   Eval      W_FILL        = 'C'
385400090403     C                   When      APCD(pqq) = 'DC'
385500090403     C                   Eval      W_FILL        = 'C'
385600090403     C                   When      APCD(pqq) = 'DT'
385700090403     C                   Eval      W_FILL        = 'T'
385800090403     C                   When      APCD(pqq) = 'DR'
385900090403     C                   Eval      W_FILL        = 'R'
386000090528     C                   When      APCD(pqq) = 'PC'
386100090529     C                   Eval      W_FILL        = 'C'
386200090403     C                   Endsl
386300090403     C                   End
386400090326
386500021029     C                   Eval      W_SEVT        = 'SL'
386600070130     C                   Eval      W_DEPTRM      = 0
386700070130     C                   Eval      W_TM_ONLY = 'N'
386800090811
386900090811      * Determine if prior CFS coverage
387000090811     C                   Eval      P_PLN = %trim(X_DWPLAN)
387100090811     C                   Eval      P_CAT = %trim(X_DWPCAT)
387200090813
387300090824     C                   Move      X_DWENRL      P_EFF
387400090813     C                   Move      SOCSOC        P_SSN
387500100118     C                   Move      W_SEQ         P_SEQ
387600090811
387700090811     C                   If        W_SEQ = 0
387800091207     C                   Exsr      GetGroup
387900091207     C                   Call      'DW311CFSGC'
388000090811     C                   Parm                    P_SSN
388100090811     C                   Parm                    P_PLN
388200090824     C                   Parm                    P_CAT
388300090824     C                   Parm                    P_EFF
388400091207     C                   Parm                    P_FLG
388500091207     C                   Parm                    P_GRP
388600090827     C                   Else
388700091001     C                   Call      'DW311CFBC'
388800091001     C                   Parm                    P_SSN
388900091001     C                   Parm                    P_SEQ
389000091001     C                   Parm                    P_PLN
389100091001     C                   Parm                    P_CAT
389200091001     C                   Parm                    P_EFF
389300091001     C                   Parm                    P_FLG
389400090827     C                   End
389500091118
389600091207      * If "A" which is change in group #
389700091207     C                   Select
389800091207     C                   When      %trim(P_FLG) = 'A'
389900100209     C                   Eval      W_FILL = %trim(P_FLG)
390000100209     C                   Eval      Q_GRP  = 'Y'
390100091207
390200091207      * If "C" which is no break in coverage
390300091207     C                   When      %trim(P_FLG) = 'C'
390400091118     C                   Eval      W_FILL = %trim(P_FLG)
390500091222
390600091222      * If "R" which is no break in coverage
390700091222     C                   When      %trim(P_FLG) = 'R'
390800091222     C                   Eval      W_FILL = %trim(P_FLG)
390900091222     C                   Select
391000121023     C                   When      %trim(X_DWPCAT) = 'PMM' or
391100121023     C                             %trim(X_DWPCAT) = 'PCM'
391200091222     C                   Eval      P_CATM = 'Y'
391300091222     C                   When      %trim(X_DWPCAT) = 'PRX'
391400091222     C                   Eval      P_CATR = 'Y'
391500110922     C                   When      %trim(X_DWPCAT) = 'PVR'
391600110922     C                   Eval      P_CATV = 'Y'
391700110922     C                   When      %trim(X_DWPCAT) = 'PVS'
391800091222     C                   Eval      P_CATV = 'Y'
391900130725     C                   When      %trim(X_DWPCAT) = 'PCV'
392000130725     C                   Eval      P_CATV = 'Y'
392100091222     C                   When      %trim(X_DWPCAT) = 'PDR'
392200091222     C                   Eval      P_CATD = 'Y'
392300140917     C                   When      %trim(X_DWPCAT) = 'PCD'
392400140917     C                   Eval      P_CATD = 'Y'
392500110922     C                   When      %trim(X_DWPCAT) = 'PDN'
392600110922     C                   Eval      P_CATD = 'Y'
392700130118     C                   When      %trim(X_DWPCAT) = 'PDE'
392800130118     C                   Eval      P_CATD = 'Y'
392900091222     C                   Endsl
393000091207
393100091207     C                   Other
393200090811     C                   Select
393300121023     C                   When      %trim(X_DWPCAT) = 'PMM' or
393400121023     C                             %trim(X_DWPCAT) = 'PCM'
393500090811     C                   Eval      P_CATM = %trim(P_FLG)
393600090811     C                   When      %trim(X_DWPCAT) = 'PRX'
393700090811     C                   Eval      P_CATR = %trim(P_FLG)
393800110922     C                   When      %trim(X_DWPCAT) = 'PVR'
393900110922     C                   Eval      P_CATV = %trim(P_FLG)
394000110922     C                   When      %trim(X_DWPCAT) = 'PVS'
394100090811     C                   Eval      P_CATV = %trim(P_FLG)
394200130725     C                   When      %trim(X_DWPCAT) = 'PCV'
394300130725     C                   Eval      P_CATV = %trim(P_FLG)
394400110922     C                   When      %trim(X_DWPCAT) = 'PDR'
394500110922     C                   Eval      P_CATD = %trim(P_FLG)
394600140917     C                   When      %trim(X_DWPCAT) = 'PCD'
394700140917     C                   Eval      P_CATD = %trim(P_FLG)
394800110922     C                   When      %trim(X_DWPCAT) = 'PDN'
394900090811     C                   Eval      P_CATD = %trim(P_FLG)
395000130118     C                   When      %trim(X_DWPCAT) = 'PDE'
395100130118     C                   Eval      P_CATD = %trim(P_FLG)
395200090811     C                   Endsl
395300091207     C                   Endsl
395400090811
395500021029     C                   Endsl
395600021029      *
395700021029      * Set Coverage Type
395800021029     C                   Select
395900021029     C                   When      W_COVT = 'FA'
396000021029     C                   Eval      W_SFAM = 'A'
396100021206     C                   Eval      W_IN_ONLY = 'N'
396200021029     C                   When      W_COVT = 'HW'
396300021029     C                   Eval      W_SFAM = 'B'
396400021206     C                   Eval      W_IN_ONLY = 'N'
396500021029     C                   When      W_COVT = 'IN'
396600021029     C                   Eval      W_SFAM = 'C'
396700040304     C                   When      W_COVT = 'MI'
396800041207     C                   Eval      W_SFAM = 'C'
396900041228     C                   When      W_COVT = 'PC'
397000041228     C                   Eval      W_SFAM = 'D'
397100041228     C                   Eval      W_IN_ONLY = 'N'
397200041228     C                   When      W_COVT = 'P2'
397300060823     C                   Eval      W_SFAM = 'A'
397400021206     C                   Eval      W_IN_ONLY = 'N'
397500021029     C                   Other
397600021029     C                   Eval      W_SFAM = 'O'
397700021206     C                   Eval      W_IN_ONLY = 'N'
397800021029     C                   Endsl
397900091029      *
398000091029      * True WASHOUT remove from existence
398100091029     C                   If        W_FILL = 'W'
398200091029     C                   Eval      W_FILL = *BLANKS
398300091029     C                   Eval      W_SEVT = *BLANKS
398400091029     C                   Eval      W_SFAM = *BLANKS
398500091029     C                   Eval      D3SCAT_W  = *BLANKS
398600091029     C                   Eval      D3SFAM_W  = *BLANKS
398700091029     C                   Eval      D3SCEF_W  = *BLANKS
398800091029     C                   Eval      D3SCTR_W  = *BLANKS
398900091029     C                   Eval      W_DEPTRM  = *ZEROS
399000091029     C                   End
399100021206      *
399200021029     C                   ENDSR
399300041130      *___________________________________________________________________
399400041130      * Reinstate Member
399500041130      *___________________________________________________________________
399600041130     C     ReinstateSR   BEGSR
399700041130     C                   Movel     ENRLDT        Input_Date
399800041130     C                   Eval      Input_Format  = 'YYYYMMDD'
399900041130     C                   Eval      Output_Format = 'MM/DD/YYYY'
400000041130     C                   Exsr      FormatDateSR
400100041130     C                   Eval      D3CLSE        = %trim(Output_Date)
400200041130     C                   Eval      D3SGRE        = %trim(Output_Date)
400300041130     C                   If        D3SCEF1  <>   *BLANKS
400400041130     C                   Eval      D3SCEF1       = %trim(Output_Date)
400500041130     C                   End
400600041130     C                   If        D3SCEF2  <>   *BLANKS
400700041130     C                   Eval      D3SCEF2       = %trim(Output_Date)
400800041130     C                   End
400900041130     C                   If        D3SCEF3  <>   *BLANKS
401000041130     C                   Eval      D3SCEF3       = %trim(Output_Date)
401100041130     C                   End
401200041130     C                   If        D3SCEF4  <>   *BLANKS
401300041130     C                   Eval      D3SCEF4       = %trim(Output_Date)
401400041130     C                   End
401500041130     C                   ENDSR
401600021101      *___________________________________________________________________
401700021101      * Update Transmit Record
401800021101      *___________________________________________________________________
401900021101     C     UpdateTranSR  BEGSR
402000121112      *
402100121112      * See program DW311RRN
402200121112     C                   Eval      QQSSN  = SOCSOC
402300121112     C                   Eval      QQRELR = WQRELR
402400121112     C                   Write     RRNR
402500090326      *
402600121112     C****               eval      W_TRSEQ# = W_TRSEQ# + 1
402700121112      ****
402800121112     C**** WQRELR        Chain     TRNMIT
402900121112     C****               If        %found
403000121112     C****               Eval      dltcod   =    'X'
403100121112     C****               Eval      trnbid   =    MMDD + YY + HHMM
403200121112     C****               Move      W_TRSEQ#      trnseq
403300121112     C**** *Date         mult      10000.0001    txmtdt
403400121112     C****               Update    TRNUPD
403500121112     C****               End
403600021101      *
403700021101     C                   ENDSR
403800021212      *___________________________________________________________________
403900021212      * Reset Coverages
404000021212      *___________________________________________________________________
404100021212     C     RESETCOVG     BEGSR
404200021212     C                   Eval      W_DEPTRM =   *Zeros
404300021212     C                   Eval      D3SCAT1  =   *Blanks
404400081111     C                   Eval      D3SCEF1  =   *Blanks
404500081111     C                   Eval      D3SCTR1  =   *Blanks
404600021212     C                   Eval      D3SEVT1  =   *Blanks
404700021212     C                   Eval      D3SFAM1  =   *Blanks
404800090330     C                   Eval      D3SLVL1  =   *Blanks
404900090330     C                   Eval      D3FIL41  =   *Blanks
405000021212     C                   Eval      D3SCAT2  =   *Blanks
405100021212     C                   Eval      D3SCEF2  =   *Blanks
405200081111     C                   Eval      D3SCTR2  =   *Blanks
405300021212     C                   Eval      D3SEVT2  =   *Blanks
405400021212     C                   Eval      D3SFAM2  =   *Blanks
405500090330     C                   Eval      D3SLVL2  =   *Blanks
405600090330     C                   Eval      D3FIL42  =   *Blanks
405700021212     C                   Eval      D3SCAT3  =   *Blanks
405800021212     C                   Eval      D3SCEF3  =   *Blanks
405900081111     C                   Eval      D3SCTR3  =   *Blanks
406000021212     C                   Eval      D3SEVT3  =   *Blanks
406100021212     C                   Eval      D3SFAM3  =   *Blanks
406200090330     C                   Eval      D3SLVL3  =   *Blanks
406300090330     C                   Eval      D3FIL43  =   *Blanks
406400021212     C                   Eval      D3SCAT4  =   *Blanks
406500021212     C                   Eval      D3SCEF4  =   *Blanks
406600081111     C                   Eval      D3SCTR4  =   *Blanks
406700021212     C                   Eval      D3SEVT4  =   *Blanks
406800021212     C                   Eval      D3SFAM4  =   *Blanks
406900090330     C                   Eval      D3SLVL4  =   *Blanks
407000090330     C                   Eval      D3FIL44  =   *Blanks
407100021212     C                   Eval      D3SCAT_W =   *Blanks
407200081111     C                   Eval      D3SCEF_W =   *Blanks
407300081111     C                   Eval      D3SCTR_W =   *Blanks
407400021212     C                   Eval      D3SEVT_W =   *Blanks
407500090326     C                   Eval      D3SFAM_W =   *Blanks
407600090330     C                   Eval      D3FILL_W =   *Blanks
407700090330     C                   Eval      D3SLVL_W =   *Blanks
407800090408     C                   Eval      D3SCAT5  =   *Blanks
407900090408     C                   Eval      D3SCEF5  =   *Blanks
408000090408     C                   Eval      D3SCTR5  =   *Blanks
408100090408     C                   Eval      D3SEVT5  =   *Blanks
408200090408     C                   Eval      D3SFAM5  =   *Blanks
408300090408     C                   Eval      D3SLVL5  =   *Blanks
408400090408     C                   Eval      D3FIL45  =   *Blanks
408500090408     C                   Eval      D3SCAT6  =   *Blanks
408600090408     C                   Eval      D3SCEF6  =   *Blanks
408700090408     C                   Eval      D3SCTR6  =   *Blanks
408800090408     C                   Eval      D3SEVT6  =   *Blanks
408900090408     C                   Eval      D3SFAM6  =   *Blanks
409000090408     C                   Eval      D3SLVL6  =   *Blanks
409100090408     C                   Eval      D3FIL46  =   *Blanks
409200090408     C                   Eval      D3SCAT7  =   *Blanks
409300090408     C                   Eval      D3SCEF7  =   *Blanks
409400090408     C                   Eval      D3SCTR7  =   *Blanks
409500090408     C                   Eval      D3SEVT7  =   *Blanks
409600090408     C                   Eval      D3SFAM7  =   *Blanks
409700090408     C                   Eval      D3SLVL7  =   *Blanks
409800090408     C                   Eval      D3FIL47  =   *Blanks
409900090408     C                   Eval      D3SCAT8  =   *Blanks
410000090408     C                   Eval      D3SCEF8  =   *Blanks
410100090408     C                   Eval      D3SCTR8  =   *Blanks
410200090408     C                   Eval      D3SEVT8  =   *Blanks
410300090408     C                   Eval      D3SFAM8  =   *Blanks
410400090408     C                   Eval      D3SLVL8  =   *Blanks
410500090408     C                   Eval      D3FIL48  =   *Blanks
410600090428     C                   Eval      D3RNWLD  = *BLANKS
410700021212     C                   ENDSR
410800110330      *___________________________________________________________________
410900110330      * Check Deceased
411000110330      *___________________________________________________________________
411100110330     C     DECEASED      BEGSR
411200110330      *
411300110330      * Check Member Termed as DECEASED
411400110330     C                   Eval      Q_FLG = ' '
411500110330     C                   Eval      D3FIL8  = ' '
411600110330     C                   Move      SOCSOC        Q_SSN
411700110330     C                   Call      'DW311D5RC'
411800110720     C                   Parm                    Q_SSN
411900110720     C                   Parm                    Q_SEQ
412000110330     C                   Parm                    Q_FLG
412100110330      *
412200110330     C                   If        Q_FLG = 'Y'
412300110330     C                   Eval      D3FIL8  = 'DECEASED'
412400110330     C                   End
412500110330      *
412600110330     C                   ENDSR
412700090409      *___________________________________________________________________
412800090409      * 834 Overrides
412900090409      *___________________________________________________________________
413000090409     C     Override834   BEGSR
413100100209      *
413200100209      * Check Member Added from Conversion - step 1
413300100209     C                   Eval      Q_FLG = ' '
413400100209     C                   Eval      D3FIL9  = ' '
413500100209     C                   If        W_SEQ = 0
413600100209     C                   Move      SOCSOC        Q_SSN
413700100209     C                   Call      'DW311MACC'
413800100209     C                   Parm                    Q_SSN
413900100209     C                   Parm                    Q_FLG
414000100209     C                   If        D3MNTYP = 'A' and
414100100209     C                             Q_FLG   = 'Y'
414200100209     C                   Eval      D3MNTYP = 'C'
414300100209     C                   Eval      D3FIL9  = 'Y'
414400100209     C                   End
414500100209     C                   End
414600090409      *
414700090409     C                   If        (RMVDEP1 = 'Y') and
414800090409     C                             (D3FIL41 = 'R')
414900090409     C                   Eval      D3SCAT1  =   *Blanks
415000090409     C                   Eval      D3SCEF1  =   *Blanks
415100090409     C                   Eval      D3SCTR1  =   *Blanks
415200090409     C                   Eval      D3SEVT1  =   *Blanks
415300090409     C                   Eval      D3SFAM1  =   *Blanks
415400090409     C                   Eval      D3SLVL1  =   *Blanks
415500090409     C                   Eval      D3FIL41  =   *Blanks
415600090409     C                   Eval      D3SCAT5  =   *Blanks
415700090409     C                   Eval      D3SCEF5  =   *Blanks
415800090409     C                   Eval      D3SCTR5  =   *Blanks
415900090409     C                   Eval      D3SEVT5  =   *Blanks
416000090409     C                   Eval      D3SFAM5  =   *Blanks
416100090409     C                   Eval      D3SLVL5  =   *Blanks
416200090409     C                   Eval      D3FIL45  =   *Blanks
416300090409     C                   End
416400090409      *
416500090409     C                   If        (RMVDEP2 = 'Y') and
416600090409     C                             (D3FIL42 = 'R')
416700090409     C                   Eval      D3SCAT2  =   *Blanks
416800090409     C                   Eval      D3SCEF2  =   *Blanks
416900090409     C                   Eval      D3SCTR2  =   *Blanks
417000090409     C                   Eval      D3SEVT2  =   *Blanks
417100090409     C                   Eval      D3SFAM2  =   *Blanks
417200090409     C                   Eval      D3SLVL2  =   *Blanks
417300090409     C                   Eval      D3FIL42  =   *Blanks
417400090409     C                   Eval      D3SCAT6  =   *Blanks
417500090409     C                   Eval      D3SCEF6  =   *Blanks
417600090409     C                   Eval      D3SCTR6  =   *Blanks
417700090409     C                   Eval      D3SEVT6  =   *Blanks
417800090409     C                   Eval      D3SFAM6  =   *Blanks
417900090409     C                   Eval      D3SLVL6  =   *Blanks
418000090409     C                   Eval      D3FIL46  =   *Blanks
418100090409     C                   End
418200090409      *
418300090409     C                   If        (RMVDEP3 = 'Y') and
418400090409     C                             (D3FIL43 = 'R')
418500090409     C                   Eval      D3SCAT3  =   *Blanks
418600090409     C                   Eval      D3SCEF3  =   *Blanks
418700090409     C                   Eval      D3SCTR3  =   *Blanks
418800090409     C                   Eval      D3SEVT3  =   *Blanks
418900090409     C                   Eval      D3SFAM3  =   *Blanks
419000090409     C                   Eval      D3SLVL3  =   *Blanks
419100090409     C                   Eval      D3FIL43  =   *Blanks
419200090409     C                   Eval      D3SCAT7  =   *Blanks
419300090409     C                   Eval      D3SCEF7  =   *Blanks
419400090409     C                   Eval      D3SCTR7  =   *Blanks
419500090409     C                   Eval      D3SEVT7  =   *Blanks
419600090409     C                   Eval      D3SFAM7  =   *Blanks
419700090409     C                   Eval      D3SLVL7  =   *Blanks
419800090409     C                   Eval      D3FIL47  =   *Blanks
419900090409     C                   End
420000090409      *
420100090409     C                   If        (RMVDEP4 = 'Y') and
420200090409     C                             (D3FIL44 = 'R')
420300090409     C                   Eval      D3SCAT4  =   *Blanks
420400090409     C                   Eval      D3SCEF4  =   *Blanks
420500090409     C                   Eval      D3SCTR4  =   *Blanks
420600090409     C                   Eval      D3SEVT4  =   *Blanks
420700090409     C                   Eval      D3SFAM4  =   *Blanks
420800090409     C                   Eval      D3SLVL4  =   *Blanks
420900090409     C                   Eval      D3FIL44  =   *Blanks
421000090409     C                   Eval      D3SCAT8  =   *Blanks
421100090409     C                   Eval      D3SCEF8  =   *Blanks
421200090409     C                   Eval      D3SCTR8  =   *Blanks
421300090409     C                   Eval      D3SEVT8  =   *Blanks
421400090409     C                   Eval      D3SFAM8  =   *Blanks
421500090409     C                   Eval      D3SLVL8  =   *Blanks
421600090409     C                   Eval      D3FIL48  =   *Blanks
421700090409     C                   End
421800090729      *
421900091028      * Check Coverage Level Change for Members Only
422000091028     C                   If        W_SEQ = 0
422100090409     C                   If        (D3FIL41 = 'A') and
422200090409     C                             (D3FIL45 = 'T') and
422300090409     C                             (D3SLVL1 <> D3SLVL5)
422400090409     C                   Eval      D3FIL41 = 'C'
422500090409     C                   Eval      RMVDEP1 = 'Y'
422600090409     C                   Eval      D3SCAT5  =   *Blanks
422700090409     C                   Eval      D3SCEF5  =   *Blanks
422800090409     C                   Eval      D3SCTR5  =   *Blanks
422900090409     C                   Eval      D3SEVT5  =   *Blanks
423000090409     C                   Eval      D3SFAM5  =   *Blanks
423100090409     C                   Eval      D3SLVL5  =   *Blanks
423200090409     C                   Eval      D3FIL45  =   *Blanks
423300090409     C                   End
423400090409      *
423500091028      * Check Coverage Level Change for Members Only
423600090409     C                   If        (D3FIL42 = 'A') and
423700090409     C                             (D3FIL46 = 'T') and
423800090409     C                             (D3SLVL2 <> D3SLVL6)
423900090409     C                   Eval      D3FIL42 = 'C'
424000090409     C                   Eval      RMVDEP2 = 'Y'
424100090409     C                   Eval      D3SCAT6  =   *Blanks
424200090409     C                   Eval      D3SCEF6  =   *Blanks
424300090409     C                   Eval      D3SCTR6  =   *Blanks
424400090409     C                   Eval      D3SEVT6  =   *Blanks
424500090409     C                   Eval      D3SFAM6  =   *Blanks
424600090409     C                   Eval      D3SLVL6  =   *Blanks
424700090409     C                   Eval      D3FIL46  =   *Blanks
424800090409     C                   End
424900090409      *
425000091028      * Check Coverage Level Change for Members Only
425100090409     C                   If        (D3FIL43 = 'A') and
425200090409     C                             (D3FIL47 = 'T') and
425300090409     C                             (D3SLVL3 <> D3SLVL7)
425400090409     C                   Eval      D3FIL43 = 'C'
425500090409     C                   Eval      RMVDEP3 = 'Y'
425600090409     C                   Eval      D3SCAT7  =   *Blanks
425700090409     C                   Eval      D3SCEF7  =   *Blanks
425800090409     C                   Eval      D3SCTR7  =   *Blanks
425900090409     C                   Eval      D3SEVT7  =   *Blanks
426000090409     C                   Eval      D3SFAM7  =   *Blanks
426100090409     C                   Eval      D3SLVL7  =   *Blanks
426200090409     C                   Eval      D3FIL47  =   *Blanks
426300090409     C                   End
426400090409      *
426500091028      * Check Coverage Level Change for Members Only
426600090409     C                   If        (D3FIL44 = 'A') and
426700090409     C                             (D3FIL48 = 'T') and
426800090409     C                             (D3SLVL4 <> D3SLVL8)
426900090409     C                   Eval      D3FIL44 = 'C'
427000090409     C                   Eval      RMVDEP4 = 'Y'
427100090409     C                   Eval      D3SCAT8  =   *Blanks
427200090409     C                   Eval      D3SCEF8  =   *Blanks
427300090409     C                   Eval      D3SCTR8  =   *Blanks
427400090409     C                   Eval      D3SEVT8  =   *Blanks
427500090409     C                   Eval      D3SFAM8  =   *Blanks
427600090409     C                   Eval      D3SLVL8  =   *Blanks
427700090409     C                   Eval      D3FIL48  =   *Blanks
427800090409     C                   End
427900091028     C                   End
428000091028      *
428100091106      *
428200091106      * SKip WRite if NO Product activity
428300090409     C                   If        (D3FIL41 = *blanks) and
428400090409     C                             (D3FIL42 = *blanks) and
428500090409     C                             (D3FIL43 = *blanks) and
428600090409     C                             (D3FIL44 = *blanks) and
428700090409     C                             (D3FIL45 = *blanks) and
428800090409     C                             (D3FIL46 = *blanks) and
428900090409     C                             (D3FIL47 = *blanks) and
429000090409     C                             (D3FIL48 = *blanks)
429100090409     C                   Eval      SKIPWRT = 'Y'
429200090409     C                   Else
429300090409     C                   Eval      SKIPWRT = 'N'
429400090409     C                   End
429500091106      *
429600091106      * SKip WRite if Member ADDED but no product activity
429700091106     C                   If        W_SEQ = 0       And
429800091106     C                             FM075 = 'Y'     And
429900091106     C                             D3MNTYP = 'A'
430000091106     C                   If        (D3FIL41 = *blanks) and
430100091106     C                             (D3FIL42 = *blanks) and
430200091106     C                             (D3FIL43 = *blanks) and
430300091106     C                             (D3FIL44 = *blanks)
430400091106     C                   Eval      SKIPWRT = 'Y'
430500091106     C                   Else
430600091106     C                   Eval      SKIPWRT = 'N'
430700091106     C                   End
430800091106     C                   End
430900091023      *
431000091023      * Only do this if Demograph/PCP Change Only
431100091023      *
431200091023     C                   If        CDC = 0
431300090731     C                   If        D3FIL41 <> *BLANKS  and
431400090731     C                             TR051   <> 'TR05'
431500090427     C                   Eval      D3FIL41  =   'N'
431600090427     C                   End
431700090731     C                   If        D3FIL42 <> *BLANKS  and
431800090731     C                             TR052   <> 'TR05'
431900090427     C                   Eval      D3FIL42  =   'N'
432000090427     C                   End
432100090731     C                   If        D3FIL43 <> *BLANKS  and
432200090731     C                             TR053   <> 'TR05'
432300090427     C                   Eval      D3FIL43  =   'N'
432400090427     C                   End
432500090731     C                   If        D3FIL44 <> *BLANKS  and
432600090731     C                             TR054   <> 'TR05'
432700090427     C                   Eval      D3FIL44  =   'N'
432800090427     C                   End
432900090427     C                   End
433000090421      *
433100091027      * Only do this if Demograph Change Only/PCP Only/No Plan Changes only
433200091027     C                   If        cdc = 0
433300090501      *
433400090421     C     KMSP          Klist
433500090421     C                   Kfld                    TRUST
433600090421     C                   Kfld                    SUBNO
433700090421     C                   Kfld                    ACCNO
433800090421      * Dates
433900090421     C     KMSP          Chain     ACCMSP
434000090421     C                   If        %found(ACCMSP)
434100090421      *
434200090421      * Format MSP Date
434300090421     C                   Movel     AMC8DT        Input_Date
434400090421     C                   Eval      Input_Format  = 'YYYYMMDD'
434500090421     C                   Eval      Output_Format = 'MM/DD/YYYY'
434600090421     C                   Exsr      FormatDateSR
434700090421     C                   Eval      MSPDATE       = %trim(Output_Date)
434800090421      *
434900090421      * Format 834 Date
435000090421     C                   If        D3CLSE <> *BLANKS
435100090421     C                   Movel     D3CLSE        Input_Date
435200090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
435300090421     C                   Eval      Output_Format  = 'YYYYMMDD'
435400090421     C                   Exsr      FormatDateSR
435500090421     C                   Eval      WCDATE        = %trim(Output_Date)
435600090421      *
435700090421      * If 834 Date < MSP Date; use MSP Date
435800090421     C                   If        WNDATE < AMC8DT
435900090421     C                   Eval      D3CLSE = MSPDATE
436000090421     C                   End
436100090421     C                   End
436200090421      *
436300090421      * Format 834 Date
436400090421     C                   If        D3SGRE <> *BLANKS
436500090421     C                   Movel     D3SGRE        Input_Date
436600090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
436700090421     C                   Eval      Output_Format  = 'YYYYMMDD'
436800090421     C                   Exsr      FormatDateSR
436900090421     C                   Eval      WCDATE        = %trim(Output_Date)
437000090421      *
437100090421      * If 834 Date < MSP Date; use MSP Date
437200090421     C                   If        WNDATE < AMC8DT
437300090421     C                   Eval      D3SGRE = MSPDATE
437400090421     C                   End
437500090421     C                   End
437600090421      *
437700090609      * Format 834 Date - org is now mbenrl
437800090609     C**                 If        D3ORGEF <> *BLANKS
437900090609     C**                 Movel     D3ORGEF       Input_Date
438000090609     C**                 Eval      Input_Format = 'MM/DD/YYYY'
438100090609     C**                 Eval      Output_Format  = 'YYYYMMDD'
438200090609     C**                 Exsr      FormatDateSR
438300090609     C**                 Eval      WCDATE        = %trim(Output_Date)
438400090421      *
438500090421      * If 834 Date < MSP Date; use MSP Date
438600090609     C**                 If        WNDATE  < AMC8DT
438700090609     C**                 Eval      D3ORGEF = MSPDATE
438800090609     C**                 End
438900090609     C**                 End
439000090421      *
439100090421      * Format 834 Date
439200090421     C                   If        D3SCEF1 <> *BLANKS
439300090421     C                   Movel     D3SCEF1       Input_Date
439400090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
439500090421     C                   Eval      Output_Format  = 'YYYYMMDD'
439600090421     C                   Exsr      FormatDateSR
439700090421     C                   Eval      WCDATE        = %trim(Output_Date)
439800090421      *
439900090421      * If 834 Date < MSP Date; use MSP Date
440000090421     C                   If        WNDATE  < AMC8DT
440100090421     C                   Eval      D3SCEF1 = MSPDATE
440200090421     C                   End
440300090421     C                   End
440400090421      *
440500090421      * Format 834 Date
440600090421     C                   If        D3SCEF2 <> *BLANKS
440700090421     C                   Movel     D3SCEF2       Input_Date
440800090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
440900090421     C                   Eval      Output_Format  = 'YYYYMMDD'
441000090421     C                   Exsr      FormatDateSR
441100090421     C                   Eval      WCDATE        = %trim(Output_Date)
441200090421      *
441300090421      * If 834 Date < MSP Date; use MSP Date
441400090421     C                   If        WNDATE  < AMC8DT
441500090421     C                   Eval      D3SCEF2 = MSPDATE
441600090421     C                   End
441700090421     C                   End
441800090421      *
441900090421      * Format 834 Date
442000090421     C                   If        D3SCEF3 <> *BLANKS
442100090421     C                   Movel     D3SCEF3       Input_Date
442200090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
442300090421     C                   Eval      Output_Format  = 'YYYYMMDD'
442400090421     C                   Exsr      FormatDateSR
442500090421     C                   Eval      WCDATE        = %trim(Output_Date)
442600090421      *
442700090421      * If 834 Date < MSP Date; use MSP Date
442800090421     C                   If        WNDATE  < AMC8DT
442900090421     C                   Eval      D3SCEF3 = MSPDATE
443000090421     C                   End
443100090421     C                   End
443200090421      *
443300090421      * Format 834 Date
443400090421     C                   If        D3SCEF4 <> *BLANKS
443500090421     C                   Movel     D3SCEF4       Input_Date
443600090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
443700090421     C                   Eval      Output_Format  = 'YYYYMMDD'
443800090421     C                   Exsr      FormatDateSR
443900090421     C                   Eval      WCDATE        = %trim(Output_Date)
444000090421      *
444100090421      * If 834 Date < MSP Date; use MSP Date
444200090421     C                   If        WNDATE  < AMC8DT
444300090421     C                   Eval      D3SCEF4 = MSPDATE
444400090421     C                   End
444500090421     C                   End
444600090421      *
444700090421      * Format 834 Date
444800090421     C                   If        D3SCEF5 <> *BLANKS
444900090421     C                   Movel     D3SCEF5       Input_Date
445000090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
445100090421     C                   Eval      Output_Format  = 'YYYYMMDD'
445200090421     C                   Exsr      FormatDateSR
445300090421     C                   Eval      WCDATE        = %trim(Output_Date)
445400090421      *
445500090421      * If 834 Date < MSP Date; use MSP Date
445600090421     C                   If        WNDATE  < AMC8DT
445700090421     C                   Eval      D3SCEF5 = MSPDATE
445800090421     C                   End
445900090421     C                   End
446000090421      *
446100090421      * Format 834 Date
446200090421     C                   If        D3SCEF6 <> *BLANKS
446300090421     C                   Movel     D3SCEF6       Input_Date
446400090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
446500090421     C                   Eval      Output_Format  = 'YYYYMMDD'
446600090421     C                   Exsr      FormatDateSR
446700090421     C                   Eval      WCDATE        = %trim(Output_Date)
446800090421      *
446900090421      * If 834 Date < MSP Date; use MSP Date
447000090421     C                   If        WNDATE  < AMC8DT
447100090421     C                   Eval      D3SCEF6 = MSPDATE
447200090421     C                   End
447300090421     C                   End
447400090421      *
447500090421      * Format 834 Date
447600090421     C                   If        D3SCEF7 <> *BLANKS
447700090421     C                   Movel     D3SCEF7       Input_Date
447800090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
447900090421     C                   Eval      Output_Format  = 'YYYYMMDD'
448000090421     C                   Exsr      FormatDateSR
448100090421     C                   Eval      WCDATE        = %trim(Output_Date)
448200090421      *
448300090421      * If 834 Date < MSP Date; use MSP Date
448400090421     C                   If        WNDATE  < AMC8DT
448500090421     C                   Eval      D3SCEF7 = MSPDATE
448600090421     C                   End
448700090421     C                   End
448800090421      *
448900090421      * Format 834 Date
449000090421     C                   If        D3SCEF8 <> *BLANKS
449100090421     C                   Movel     D3SCEF8       Input_Date
449200090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
449300090421     C                   Eval      Output_Format  = 'YYYYMMDD'
449400090421     C                   Exsr      FormatDateSR
449500090421     C                   Eval      WCDATE        = %trim(Output_Date)
449600090421      *
449700090421      * If 834 Date < MSP Date; use MSP Date
449800090421     C                   If        WNDATE  < AMC8DT
449900090421     C                   Eval      D3SCEF8 = MSPDATE
450000090421     C                   End
450100090421     C                   End
450200090421      *
450300090421      * Format 834 Date
450400090421     C                   If        D3SCTR1 <> *BLANKS
450500090421     C                   Movel     D3SCTR1       Input_Date
450600090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
450700090421     C                   Eval      Output_Format  = 'YYYYMMDD'
450800090421     C                   Exsr      FormatDateSR
450900090421     C                   Eval      WCDATE        = %trim(Output_Date)
451000090421      *
451100090421      * If 834 Date < MSP Date; use MSP Date
451200090421     C                   If        WNDATE  < AMC8DT
451300090421     C                   Eval      D3SCTR1 = MSPDATE
451400090421     C                   End
451500090421     C                   End
451600090421      *
451700090421      * Format 834 Date
451800090421     C                   If        D3SCTR2 <> *BLANKS
451900090421     C                   Movel     D3SCTR2       Input_Date
452000090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
452100090421     C                   Eval      Output_Format  = 'YYYYMMDD'
452200090421     C                   Exsr      FormatDateSR
452300090421     C                   Eval      WCDATE        = %trim(Output_Date)
452400090421      *
452500090421      * If 834 Date < MSP Date; use MSP Date
452600090421     C                   If        WNDATE  < AMC8DT
452700090421     C                   Eval      D3SCTR2 = MSPDATE
452800090421     C                   End
452900090421     C                   End
453000090421      *
453100090421      * Format 834 Date
453200090421     C                   If        D3SCTR3 <> *BLANKS
453300090421     C                   Movel     D3SCTR3       Input_Date
453400090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
453500090421     C                   Eval      Output_Format  = 'YYYYMMDD'
453600090421     C                   Exsr      FormatDateSR
453700090421     C                   Eval      WCDATE        = %trim(Output_Date)
453800090421      *
453900090421      * If 834 Date < MSP Date; use MSP Date
454000090421     C                   If        WNDATE  < AMC8DT
454100090421     C                   Eval      D3SCTR3 = MSPDATE
454200090421     C                   End
454300090421     C                   End
454400090421      *
454500090421      * Format 834 Date
454600090421     C                   If        D3SCTR4 <> *BLANKS
454700090421     C                   Movel     D3SCTR4       Input_Date
454800090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
454900090421     C                   Eval      Output_Format  = 'YYYYMMDD'
455000090421     C                   Exsr      FormatDateSR
455100090421     C                   Eval      WCDATE        = %trim(Output_Date)
455200090421      *
455300090421      * If 834 Date < MSP Date; use MSP Date
455400090421     C                   If        WNDATE  < AMC8DT
455500090421     C                   Eval      D3SCTR4 = MSPDATE
455600090421     C                   End
455700090421     C                   End
455800090421      *
455900090421      * Format 834 Date
456000090421     C                   If        D3SCTR5 <> *BLANKS
456100090421     C                   Movel     D3SCTR5       Input_Date
456200090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
456300090421     C                   Eval      Output_Format  = 'YYYYMMDD'
456400090421     C                   Exsr      FormatDateSR
456500090421     C                   Eval      WCDATE        = %trim(Output_Date)
456600090421      *
456700090421      * If 834 Date < MSP Date; use MSP Date
456800090421     C                   If        WNDATE  < AMC8DT
456900090421     C                   Eval      D3SCTR5 = MSPDATE
457000090421     C                   End
457100090421     C                   End
457200090421      *
457300090421      * Format 834 Date
457400090421     C                   If        D3SCTR6 <> *BLANKS
457500090421     C                   Movel     D3SCTR6       Input_Date
457600090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
457700090421     C                   Eval      Output_Format  = 'YYYYMMDD'
457800090421     C                   Exsr      FormatDateSR
457900090421     C                   Eval      WCDATE        = %trim(Output_Date)
458000090421      *
458100090421      * If 834 Date < MSP Date; use MSP Date
458200090421     C                   If        WNDATE  < AMC8DT
458300090421     C                   Eval      D3SCTR6 = MSPDATE
458400090421     C                   End
458500090421     C                   End
458600090421      *
458700090421      * Format 834 Date
458800090421     C                   If        D3SCTR7 <> *BLANKS
458900090421     C                   Movel     D3SCTR7       Input_Date
459000090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
459100090421     C                   Eval      Output_Format  = 'YYYYMMDD'
459200090421     C                   Exsr      FormatDateSR
459300090421     C                   Eval      WCDATE        = %trim(Output_Date)
459400090421      *
459500090421      * If 834 Date < MSP Date; use MSP Date
459600090421     C                   If        WNDATE  < AMC8DT
459700090421     C                   Eval      D3SCTR7 = MSPDATE
459800090421     C                   End
459900090421     C                   End
460000090421      *
460100090421      * Format 834 Date
460200090421     C                   If        D3SCTR8 <> *BLANKS
460300090421     C                   Movel     D3SCTR8       Input_Date
460400090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
460500090421     C                   Eval      Output_Format  = 'YYYYMMDD'
460600090421     C                   Exsr      FormatDateSR
460700090421     C                   Eval      WCDATE        = %trim(Output_Date)
460800090421      *
460900090421      * If 834 Date < MSP Date; use MSP Date
461000090421     C                   If        WNDATE  < AMC8DT
461100090421     C                   Eval      D3SCTR8 = MSPDATE
461200090421     C                   End
461300090421     C                   End
461400090421      *
461500090421      * Format 834 Date
461600090421     C                   If        D3CLSE1 <> *BLANKS
461700090421     C                   Movel     D3CLSE1       Input_Date
461800090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
461900090421     C                   Eval      Output_Format  = 'YYYYMMDD'
462000090421     C                   Exsr      FormatDateSR
462100090421     C                   Eval      WCDATE        = %trim(Output_Date)
462200090421      *
462300090421      * If 834 Date < MSP Date; use MSP Date
462400090421     C                   If        WNDATE  < AMC8DT
462500090421     C                   Eval      D3CLSE1 = MSPDATE
462600090421     C                   End
462700090421     C                   End
462800090421      *
462900090421      * Format 834 Date
463000090421     C                   If        D3CLSE2 <> *BLANKS
463100090421     C                   Movel     D3CLSE2       Input_Date
463200090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
463300090421     C                   Eval      Output_Format  = 'YYYYMMDD'
463400090421     C                   Exsr      FormatDateSR
463500090421     C                   Eval      WCDATE        = %trim(Output_Date)
463600090421      *
463700090421      * If 834 Date < MSP Date; use MSP Date
463800090421     C                   If        WNDATE  < AMC8DT
463900090421     C                   Eval      D3CLSE2 = MSPDATE
464000090421     C                   End
464100090421     C                   End
464200090421      *
464300090421      * Format 834 Date
464400090421     C                   If        D3CLSE3 <> *BLANKS
464500090421     C                   Movel     D3CLSE3       Input_Date
464600090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
464700090421     C                   Eval      Output_Format  = 'YYYYMMDD'
464800090421     C                   Exsr      FormatDateSR
464900090421     C                   Eval      WCDATE        = %trim(Output_Date)
465000090421      *
465100090421      * If 834 Date < MSP Date; use MSP Date
465200090421     C                   If        WNDATE  < AMC8DT
465300090421     C                   Eval      D3CLSE3 = MSPDATE
465400090421     C                   End
465500090421     C                   End
465600090421      *
465700090421      * Format 834 Date
465800090421     C                   If        D3CLSE4 <> *BLANKS
465900090421     C                   Movel     D3CLSE4       Input_Date
466000090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
466100090421     C                   Eval      Output_Format  = 'YYYYMMDD'
466200090421     C                   Exsr      FormatDateSR
466300090421     C                   Eval      WCDATE        = %trim(Output_Date)
466400090421      *
466500090421      * If 834 Date < MSP Date; use MSP Date
466600090421     C                   If        WNDATE  < AMC8DT
466700090421     C                   Eval      D3CLSE4 = MSPDATE
466800090421     C                   End
466900090421     C                   End
467000090421      *
467100090421      * Format 834 Date
467200090421     C                   If        D3CLSE5 <> *BLANKS
467300090421     C                   Movel     D3CLSE5       Input_Date
467400090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
467500090421     C                   Eval      Output_Format  = 'YYYYMMDD'
467600090421     C                   Exsr      FormatDateSR
467700090421     C                   Eval      WCDATE        = %trim(Output_Date)
467800090421      *
467900090421      * If 834 Date < MSP Date; use MSP Date
468000090421     C                   If        WNDATE  < AMC8DT
468100090421     C                   Eval      D3CLSE5 = MSPDATE
468200090421     C                   End
468300090421     C                   End
468400090421      *
468500090421      * Format 834 Date
468600090421     C                   If        D3CLSE6 <> *BLANKS
468700090421     C                   Movel     D3CLSE6       Input_Date
468800090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
468900090421     C                   Eval      Output_Format  = 'YYYYMMDD'
469000090421     C                   Exsr      FormatDateSR
469100090421     C                   Eval      WCDATE        = %trim(Output_Date)
469200090421      *
469300090421      * If 834 Date < MSP Date; use MSP Date
469400090421     C                   If        WNDATE  < AMC8DT
469500090421     C                   Eval      D3CLSE6 = MSPDATE
469600090421     C                   End
469700090421     C                   End
469800090421      *
469900090421      * Format 834 Date
470000090421     C                   If        D3CLSE7 <> *BLANKS
470100090421     C                   Movel     D3CLSE7       Input_Date
470200090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
470300090421     C                   Eval      Output_Format  = 'YYYYMMDD'
470400090421     C                   Exsr      FormatDateSR
470500090421     C                   Eval      WCDATE        = %trim(Output_Date)
470600090421      *
470700090421      * If 834 Date < MSP Date; use MSP Date
470800090421     C                   If        WNDATE  < AMC8DT
470900090421     C                   Eval      D3CLSE7 = MSPDATE
471000090421     C                   End
471100090421     C                   End
471200090421      *
471300090421      * Format 834 Date
471400090421     C                   If        D3CLSE8 <> *BLANKS
471500090421     C                   Movel     D3CLSE8       Input_Date
471600090421     C                   Eval      Input_Format = 'MM/DD/YYYY'
471700090421     C                   Eval      Output_Format  = 'YYYYMMDD'
471800090421     C                   Exsr      FormatDateSR
471900090421     C                   Eval      WCDATE        = %trim(Output_Date)
472000090421      *
472100090421      * If 834 Date < MSP Date; use MSP Date
472200090421     C                   If        WNDATE  < AMC8DT
472300090421     C                   Eval      D3CLSE8 = MSPDATE
472400090421     C                   End
472500090421     C                   End
472600090421      *
472700090501     C                   End
472800090421     C                   End
472900090512      *
473000090512      * Never send blanks
473100090512     C                   If        D3MNTYP = ' '   and
473200090512     C                             D3MNRSN = ' '
473300090512     C                   Eval      D3MNTYP = 'C'
473400090512     C                   Eval      D3MNRSN = '7'
473500090512     C**                 Eval      D3MNRSN = 'CHANGE'
473600090512     C                   End
473700090811      *
473800090811      * Check for Reinstate flags
473900090827     C                   Eval      R_FLG   =  *BLANKS
474000091103     C                   If        D3FIL41 =  'A' and
474100091103     C                             P_CATM  =  'Y'
474200090811     C                   Eval      D3FIL41 = 'R'
474300090812     C                   Movel     D3SCEF1       Input_Date
474400090812     C                   Exsr      CHKREIN
474500090811     C                   End
474600091103     C                   If        D3FIL42 =  'A' and
474700091103     C                             P_CATR  =  'Y'
474800090811     C                   Eval      D3FIL42 = 'R'
474900090812     C                   Movel     D3SCEF2       Input_Date
475000090812     C                   Exsr      CHKREIN
475100090811     C                   End
475200091103     C                   If        D3FIL43 =  'A' and
475300091103     C                             P_CATD  =  'Y'
475400090811     C                   Eval      D3FIL43 = 'R'
475500090812     C                   Movel     D3SCEF3       Input_Date
475600090812     C                   Exsr      CHKREIN
475700090811     C                   End
475800091103     C                   If        D3FIL44 =  'A' and
475900091103     C                             P_CATV  =  'Y'
476000090811     C                   Eval      D3FIL44 = 'R'
476100090812     C                   Movel     D3SCEF4       Input_Date
476200090812     C                   Exsr      CHKREIN
476300090811     C                   End
476400110330      *
476500110330      * Check for Voids
476600110330     C                   If        D3FIL41 =  'S'
476700110330     C                   If        D3SCEF1 <> *Blanks  and
476800110330     C                             D3SCTR1 <> *Blanks
476900110330     C                   Movel     D3SCEF1       D3SCTR1
477000110330     C                   End
477100110330     C                   End
477200110330     C                   If        D3FIL42 =  'S'
477300110330     C                   If        D3SCEF2 <> *Blanks  and
477400110330     C                             D3SCTR2 <> *Blanks
477500110330     C                   Movel     D3SCEF2       D3SCTR2
477600110330     C                   End
477700110330     C                   End
477800110330     C                   If        D3FIL43 =  'S'
477900110330     C                   If        D3SCEF3 <> *Blanks  and
478000110330     C                             D3SCTR3 <> *Blanks
478100110330     C                   Movel     D3SCEF3       D3SCTR3
478200110330     C                   End
478300110330     C                   End
478400110330     C                   If        D3FIL44 =  'S'
478500110330     C                   If        D3SCEF4 <> *Blanks  and
478600110330     C                             D3SCTR4 <> *Blanks
478700110330     C                   Movel     D3SCEF4       D3SCTR4
478800110330     C                   End
478900110330     C                   End
479000091103      *
479100091204      * Member Only - History ERE Record only if prior coverage.
479200091118     C                   If        W_SEQ   =   0   and
479300091118     C                             D3MNTYP <> 'T'
479400091221     C                   If        P_CATM =  'Y' or
479500091221     C                             P_CATR =  'Y' or
479600091221     C                             P_CATD =  'Y' or
479700091221     C                             P_CATV =  'Y'
479800091103     C                   Exsr      CHKREIN2
479900091204     C                   End
480000091103     C                   End
480100090813      *
480200090813      * Dependents Only
480300090813     C                   If        W_SEQ <> 0
480400090813     C                   If        D3MNTYP =  'R' and
480500090827     C                             R_FLG   =  'Y'
480600090813     C                   Eval      D3MNTYP = 'C'
480700090813     C                   Eval      D3MNRSN = '7'
480800090813     C                   End
480900090813     C                   End
481000090618      *
481100090806      * If any record from FM075, then All must be ADD too.
481200090806     C                   If        FM075 = 'Y'
481300090806     C                   Eval      D3MNTYP = 'A'
481400090806     C                   Eval      D3MNRSN = '1'
481500090806     C                   End
481600091028      *
481700091028      * Cannot have TM,N (no change) must be from chg PCP term plan
481800091028     C                   If        D3SEVT1 =  'TM' and
481900091028     C                             D3FIL41 =  'N'
482000091028     C                   Eval      D3SCAT1  =   *Blanks
482100091028     C                   Eval      D3SCEF1  =   *Blanks
482200091028     C                   Eval      D3SCTR1  =   *Blanks
482300091028     C                   Eval      D3SEVT1  =   *Blanks
482400091028     C                   Eval      D3SFAM1  =   *Blanks
482500091028     C                   Eval      D3SLVL1  =   *Blanks
482600091028     C                   Eval      D3FIL41  =   *Blanks
482700091028     C                   End
482800091028     C                   If        D3SEVT2 =  'TM' and
482900091028     C                             D3FIL42 =  'N'
483000091028     C                   Eval      D3SCAT2  =   *Blanks
483100091028     C                   Eval      D3SCEF2  =   *Blanks
483200091028     C                   Eval      D3SCTR2  =   *Blanks
483300091028     C                   Eval      D3SEVT2  =   *Blanks
483400091028     C                   Eval      D3SFAM2  =   *Blanks
483500091028     C                   Eval      D3SLVL2  =   *Blanks
483600091028     C                   Eval      D3FIL42  =   *Blanks
483700091028     C                   End
483800091028     C                   If        D3SEVT3 =  'TM' and
483900091028     C                             D3FIL43 =  'N'
484000091028     C                   Eval      D3SCAT3  =   *Blanks
484100091028     C                   Eval      D3SCEF3  =   *Blanks
484200091028     C                   Eval      D3SCTR3  =   *Blanks
484300091028     C                   Eval      D3SEVT3  =   *Blanks
484400091028     C                   Eval      D3SFAM3  =   *Blanks
484500091028     C                   Eval      D3SLVL3  =   *Blanks
484600091028     C                   Eval      D3FIL43  =   *Blanks
484700091028     C                   End
484800091028     C                   If        D3SEVT4 =  'TM' and
484900091028     C                             D3FIL44 =  'N'
485000091028     C                   Eval      D3SCAT4  =   *Blanks
485100091028     C                   Eval      D3SCEF4  =   *Blanks
485200091028     C                   Eval      D3SCTR4  =   *Blanks
485300091028     C                   Eval      D3SEVT4  =   *Blanks
485400091028     C                   Eval      D3SFAM4  =   *Blanks
485500091028     C                   Eval      D3SLVL4  =   *Blanks
485600091028     C                   Eval      D3FIL44  =   *Blanks
485700091028     C                   End
485800111117      *
485900111117      * Cannot have TM,C (change) must be SL,C
486000111117     C                   If        D3SEVT1 =  'TM' and
486100111117     C                             D3FIL41 =  'C'
486200111117     C                   Eval      D3SEVT1  =   'SL'
486300111117     C                   Eval      D3SCTR1  =   *Blanks
486400111117     C                   End
486500111117     C                   If        D3SEVT2 =  'TM' and
486600111117     C                             D3FIL42 =  'C'
486700111117     C                   Eval      D3SEVT2  =   'SL'
486800111117     C                   Eval      D3SCTR2  =   *Blanks
486900111117     C                   End
487000111117     C                   If        D3SEVT3 =  'TM' and
487100111117     C                             D3FIL43 =  'C'
487200111117     C                   Eval      D3SEVT3  =   'SL'
487300111117     C                   Eval      D3SCTR3  =   *Blanks
487400111117     C                   End
487500111117     C                   If        D3SEVT4 =  'TM' and
487600111117     C                             D3FIL44 =  'C'
487700111117     C                   Eval      D3SEVT4  =   'SL'
487800111117     C                   Eval      D3SCTR4  =   *Blanks
487900111117     C                   End
488000090806      *
488100090806      * If the end result is an ADD, then the plans must be ADD too.
488200090618     C                   If        D3MNTYP = 'A'
488300090922     C                   If        D3FIL41 <> *blanks and
488400090922     C                             D3FIL41 <> 'T'     and
488500090922     C                             D3FIL41 <> 'S'
488600090618     C                   Eval      D3FIL41 = 'A'
488700090618     C                   End
488800090922     C                   If        D3FIL41 =  'T'     or
488900090922     C                             D3FIL41 =  'S'
489000090922     C                   Eval      D3SCAT1  =   *Blanks
489100090922     C                   Eval      D3SCEF1  =   *Blanks
489200090922     C                   Eval      D3SCTR1  =   *Blanks
489300090922     C                   Eval      D3SEVT1  =   *Blanks
489400090922     C                   Eval      D3SFAM1  =   *Blanks
489500090922     C                   Eval      D3SLVL1  =   *Blanks
489600090922     C                   Eval      D3FIL41  =   *Blanks
489700090922     C                   End
489800090922     C                   If        D3FIL42 <> *blanks and
489900090922     C                             D3FIL42 <> 'T'     and
490000090922     C                             D3FIL42 <> 'S'
490100090618     C                   Eval      D3FIL42 = 'A'
490200090618     C                   End
490300090922     C                   If        D3FIL42 =  'T'     or
490400090922     C                             D3FIL42 =  'S'
490500090922     C                   Eval      D3SCAT2  =   *Blanks
490600090922     C                   Eval      D3SCEF2  =   *Blanks
490700090922     C                   Eval      D3SCTR2  =   *Blanks
490800090922     C                   Eval      D3SEVT2  =   *Blanks
490900090922     C                   Eval      D3SFAM2  =   *Blanks
491000090922     C                   Eval      D3SLVL2  =   *Blanks
491100090922     C                   Eval      D3FIL42  =   *Blanks
491200090922     C                   End
491300090922     C                   If        D3FIL43 <> *blanks and
491400090922     C                             D3FIL43 <> 'T'     and
491500090922     C                             D3FIL43 <> 'S'
491600090618     C                   Eval      D3FIL43 = 'A'
491700090618     C                   End
491800090922     C                   If        D3FIL43 =  'T'     or
491900090922     C                             D3FIL43 =  'S'
492000090922     C                   Eval      D3SCAT3  =   *Blanks
492100090922     C                   Eval      D3SCEF3  =   *Blanks
492200090922     C                   Eval      D3SCTR3  =   *Blanks
492300090922     C                   Eval      D3SEVT3  =   *Blanks
492400090922     C                   Eval      D3SFAM3  =   *Blanks
492500090922     C                   Eval      D3SLVL3  =   *Blanks
492600090922     C                   Eval      D3FIL43  =   *Blanks
492700090922     C                   End
492800090922     C                   If        D3FIL44 <> *blanks and
492900090922     C                             D3FIL44 <> 'T'     and
493000090922     C                             D3FIL44 <> 'S'
493100090618     C                   Eval      D3FIL44 = 'A'
493200090618     C                   End
493300090922     C                   If        D3FIL44 =  'T'     or
493400090922     C                             D3FIL44 =  'S'
493500090922     C                   Eval      D3SCAT4  =   *Blanks
493600090922     C                   Eval      D3SCEF4  =   *Blanks
493700090922     C                   Eval      D3SCTR4  =   *Blanks
493800090922     C                   Eval      D3SEVT4  =   *Blanks
493900090922     C                   Eval      D3SFAM4  =   *Blanks
494000090922     C                   Eval      D3SLVL4  =   *Blanks
494100090922     C                   Eval      D3FIL44  =   *Blanks
494200090922     C                   End
494300090618     C                   End
494400100129      *
494500100129      * If the end result is an CHG all plans ADD, must be ADD too.
494600100129      * and never had coverage before, must be ADD too.
494700100209     C                   If        Q_FLG = ' '
494800100129     C                   If        D3MNTYP = 'C' and
494900100129     C                             P_CATM  = ' ' and
495000100129     C                             P_CATR  = ' ' and
495100100129     C                             P_CATD  = ' ' and
495200100129     C                             P_CATV  = ' '
495300100129     C                   If        (D3FIL41 = 'A' or
495400100129     C                             D3FIL41 = ' ') and
495500100129     C                             (D3FIL42 = 'A' or
495600100129     C                             D3FIL42 = ' ') and
495700100129     C                             (D3FIL43 = 'A' or
495800100129     C                             D3FIL43 = ' ') and
495900100129     C                             (D3FIL44 = 'A' or
496000100129     C                             D3FIL44 = ' ')
496100100129     C                   Eval      D3MNTYP = 'A'
496200100129     C                   End
496300100209     C                   End
496400100129     C                   End
496500090730      *
496600100129      * If the end result is an ADD all plans ADD,
496700100129      * double check we never sent add before.
496800100205     C                   Select
496900100205     C                   When      D3MNTYP = 'A'
497000090824     C                   If        (D3FIL41 = 'A' or
497100090824     C                             D3FIL41 = ' ') and
497200090824     C                             (D3FIL42 = 'A' or
497300090824     C                             D3FIL42 = ' ') and
497400090824     C                             (D3FIL43 = 'A' or
497500090824     C                             D3FIL43 = ' ') and
497600090824     C                             (D3FIL44 = 'A' or
497700090824     C                             D3FIL44 = ' ')
497800100129
497900100129      * Medical
498000100129     C                   If        D3FIL41 = 'A'
498100100129     C                   Move      SOCSOC        P_SSN
498200100129     C                   Move      W_SEQ         P_SEQ
498300100129     C                   Call      'DW311TRKR'
498400100129     C                   Parm                    P_SSN
498500100129     C                   Parm                    P_SEQ
498600100129     C                   Parm      'M'           P_MDVC            1
498700100129     C                   Parm      'A'           P_MDVF            1
498800100129     C                   Parm                    P_RTN             1
498900100129     C                   If        P_RTN = 'C'
499000100129     C                   Eval      D3MNTYP = 'C'
499100100129     C                   Eval      D3FIL41 = 'C'
499200100129     C                   End
499300100129     C                   End
499400100129
499500100129      * RX
499600100129     C                   If        D3FIL42 = 'A'
499700100129     C                   Move      SOCSOC        P_SSN
499800100129     C                   Move      W_SEQ         P_SEQ
499900100129     C                   Call      'DW311TRKR'
500000100129     C                   Parm                    P_SSN
500100100129     C                   Parm                    P_SEQ
500200100129     C                   Parm      'R'           P_MDVC            1
500300100129     C                   Parm      'A'           P_MDVF            1
500400100129     C                   Parm                    P_RTN             1
500500100129     C                   If        P_RTN = 'C'
500600100129     C                   Eval      D3MNTYP = 'C'
500700100129     C                   Eval      D3FIL42 = 'C'
500800100129     C                   End
500900100129     C                   End
501000100129
501100100129      * DENTAL
501200100129     C                   If        D3FIL43 = 'A'
501300100129     C                   Move      SOCSOC        P_SSN
501400100129     C                   Move      W_SEQ         P_SEQ
501500100129     C                   Call      'DW311TRKR'
501600100129     C                   Parm                    P_SSN
501700100129     C                   Parm                    P_SEQ
501800100129     C                   Parm      'D'           P_MDVC            1
501900100129     C                   Parm      'A'           P_MDVF            1
502000100129     C                   Parm                    P_RTN             1
502100100129     C                   If        P_RTN = 'C'
502200100129     C                   Eval      D3MNTYP = 'C'
502300100129     C                   Eval      D3FIL43 = 'C'
502400100129     C                   End
502500100129     C                   End
502600100129
502700100129      * VISION
502800100129     C                   If        D3FIL44 = 'A'
502900100129     C                   Move      SOCSOC        P_SSN
503000100129     C                   Move      W_SEQ         P_SEQ
503100100129     C                   Call      'DW311TRKR'
503200100129     C                   Parm                    P_SSN
503300100129     C                   Parm                    P_SEQ
503400100129     C                   Parm      'V'           P_MDVC            1
503500100129     C                   Parm      'A'           P_MDVF            1
503600100129     C                   Parm                    P_RTN             1
503700100129     C                   If        P_RTN = 'C'
503800100129     C                   Eval      D3MNTYP = 'C'
503900100129     C                   Eval      D3FIL44 = 'C'
504000100129     C                   End
504100100129     C                   End
504200100129
504300090824     C                   End
504400100205      *
504500100205      * If the end result is an CHG all plans CHG,
504600100205      * double check we never sent add before.
504700100205     C                   When      D3MNTYP = 'C'
504800100205     C                   If        (D3FIL41 = 'C' or
504900100205     C                             D3FIL41 = ' ') and
505000100205     C                             (D3FIL42 = 'C' or
505100100205     C                             D3FIL42 = ' ') and
505200100205     C                             (D3FIL43 = 'C' or
505300100205     C                             D3FIL43 = ' ') and
505400100205     C                             (D3FIL44 = 'C' or
505500100205     C                             D3FIL44 = ' ')
505600100205
505700100205      * Medical
505800100205     C                   If        D3FIL41 = 'C'
505900100205     C                   Move      SOCSOC        P_SSN
506000100205     C                   Move      W_SEQ         P_SEQ
506100100205     C                   Call      'DW311TRKR'
506200100205     C                   Parm                    P_SSN
506300100205     C                   Parm                    P_SEQ
506400100205     C                   Parm      'M'           P_MDVC            1
506500100205     C                   Parm      'C'           P_MDVF            1
506600100205     C                   Parm                    P_RTN             1
506700100205     C                   If        P_RTN = 'R'
506800100205     C                   Eval      D3MNTYP = 'R'
506900100205     C                   Eval      D3FIL41 = 'R'
507000100205     C                   End
507100100205     C                   End
507200100205
507300100205      * RX
507400100205     C                   If        D3FIL42 = 'C'
507500100205     C                   Move      SOCSOC        P_SSN
507600100205     C                   Move      W_SEQ         P_SEQ
507700100205     C                   Call      'DW311TRKR'
507800100205     C                   Parm                    P_SSN
507900100205     C                   Parm                    P_SEQ
508000100205     C                   Parm      'R'           P_MDVC            1
508100100205     C                   Parm      'C'           P_MDVF            1
508200100205     C                   Parm                    P_RTN             1
508300100205     C                   If        P_RTN = 'R'
508400100205     C                   Eval      D3MNTYP = 'R'
508500100205     C                   Eval      D3FIL42 = 'R'
508600100205     C                   End
508700100205     C                   End
508800100205
508900100205      * DENTAL
509000100205     C                   If        D3FIL43 = 'C'
509100100205     C                   Move      SOCSOC        P_SSN
509200100205     C                   Move      W_SEQ         P_SEQ
509300100205     C                   Call      'DW311TRKR'
509400100205     C                   Parm                    P_SSN
509500100205     C                   Parm                    P_SEQ
509600100205     C                   Parm      'D'           P_MDVC            1
509700100205     C                   Parm      'C'           P_MDVF            1
509800100205     C                   Parm                    P_RTN             1
509900100205     C                   If        P_RTN = 'R'
510000100205     C                   Eval      D3MNTYP = 'R'
510100100205     C                   Eval      D3FIL43 = 'R'
510200100205     C                   End
510300100205     C                   End
510400100205
510500100205      * VISION
510600100205     C                   If        D3FIL44 = 'C'
510700100205     C                   Move      SOCSOC        P_SSN
510800100205     C                   Move      W_SEQ         P_SEQ
510900100205     C                   Call      'DW311TRKR'
511000100205     C                   Parm                    P_SSN
511100100205     C                   Parm                    P_SEQ
511200100205     C                   Parm      'V'           P_MDVC            1
511300100205     C                   Parm      'C'           P_MDVF            1
511400100205     C                   Parm                    P_RTN             1
511500100205     C                   If        P_RTN = 'R'
511600100205     C                   Eval      D3MNTYP = 'R'
511700100205     C                   Eval      D3FIL44 = 'R'
511800100205     C                   End
511900100205     C                   End
512000100205
512100100205     C                   End
512200100205     C                   Endsl
512300091029      *
512400091029      * DEPENDENTS ONLY
512500091029      * If the end result is an CHG
512600091029      * and had CFS coverage before,
512700091029      * All are REI, then must be REI too.
512800091029     C                   If        D3MNTYP = 'C'  and
512900091029     C                             W_SEQ <> 0
513000091029     C                   If        P_CATM  <> ' ' or
513100091029     C                             P_CATR  <> ' ' or
513200091029     C                             P_CATD  <> ' ' or
513300091029     C                             P_CATV  <> ' '
513400091029     C                   If        (D3FIL41 = 'R' or
513500091029     C                             D3FIL41 = ' ') and
513600091029     C                             (D3FIL42 = 'R' or
513700091029     C                             D3FIL42 = ' ') and
513800091029     C                             (D3FIL43 = 'R' or
513900091029     C                             D3FIL43 = ' ') and
514000091029     C                             (D3FIL44 = 'R' or
514100091029     C                             D3FIL44 = ' ')
514200091029     C                   Eval      D3MNTYP = 'R'
514300091029     C                   Eval      D3MNRSN = '4'
514400091029     C                   End
514500091029     C                   End
514600091029     C                   End
514700091029      *
514800091029      * If the end result is an REI or CHG, and all plans termed, set TERM.
514900091029     C                   If        D3MNTYP = 'R'  or
515000091029     C                             D3MNTYP = 'C'
515100091029     C                   If        (D3FIL41 = 'T' or
515200091029     C                             D3FIL41 = 'S'  or
515300091029     C                             D3FIL41 = ' ') and
515400091029     C                             (D3FIL42 = 'T' or
515500091029     C                             D3FIL42 = 'S'  or
515600091029     C                             D3FIL42 = ' ') and
515700091029     C                             (D3FIL43 = 'T' or
515800091029     C                             D3FIL43 = 'S'  or
515900091029     C                             D3FIL43 = ' ') and
516000091029     C                             (D3FIL44 = 'T' or
516100091029     C                             D3FIL44 = 'S'  or
516200091029     C                             D3FIL44 = ' ')
516300091029     C                   Eval      D3MNTYP = 'T'
516400091029     C                   Eval      D3MNRSN = '5'
516500091029     C                   End
516600091029     C                   End
516700091104      *
516800091104      * If the end result is an CHG, and if at least 1 R,
516900091104      *   and the rest blank or A, then REI.
517000091104     C                   If        W_SEQ = 0
517100091104     C                   If        D3MNTYP = 'C'
517200091104     C                   If        (D3FIL41 = 'R' or
517300091104     C                              D3FIL42 = 'R'  or
517400091104     C                              D3FIL43 = 'R'  or
517500091104     C                              D3FIL44 = 'R')
517600091104     C                   If        (D3FIL41 = 'R' or
517700091104     C                              D3FIL41 = 'A' or
517800091104     C                             D3FIL41 = ' ') and
517900091104     C                             (D3FIL42 = 'R' or
518000091104     C                              D3FIL42 = 'A' or
518100091104     C                             D3FIL42 = ' ') and
518200091104     C                             (D3FIL43 = 'R' or
518300091104     C                              D3FIL43 = 'A' or
518400091104     C                             D3FIL43 = ' ') and
518500091104     C                             (D3FIL44 = 'R' or
518600091104     C                              D3FIL44 = 'A' or
518700091104     C                             D3FIL44 = ' ')
518800091104     C                   Eval      D3MNTYP = 'R'
518900091104     C                   Eval      D3MNRSN = '3'
519000091104     C                   End
519100091104     C                   End
519200091104     C                   End
519300091104     C                   End
519400090914      *
519500090914      * If the end result is an TRM, and all plans termed, set term date.
519600090914     C                   If        D3MNTYP = 'T'
519700090914     C                   If        (D3FIL41 = 'T' or
519800090914     C                             D3FIL41 = 'S'  or
519900090914     C                             D3FIL41 = ' ') and
520000090914     C                             (D3FIL42 = 'T' or
520100090914     C                             D3FIL42 = 'S'  or
520200090914     C                             D3FIL42 = ' ') and
520300090914     C                             (D3FIL43 = 'T' or
520400090914     C                             D3FIL43 = 'S'  or
520500090914     C                             D3FIL43 = ' ') and
520600090914     C                             (D3FIL44 = 'T' or
520700090914     C                             D3FIL44 = 'S'  or
520800090914     C                             D3FIL44 = ' ')
520900090914     C                   If        D3TRMDT = *BLANKS
521000090914     C                   Select
521100090914     C                   When      D3SCEF1 <> *BLANKS
521200091029     C                   Eval      D3TRMDT =  D3SCTR1
521300090914     C                   When      D3SCEF2 <> *BLANKS
521400091029     C                   Eval      D3TRMDT =  D3SCTR2
521500090914     C                   When      D3SCEF3 <> *BLANKS
521600091029     C                   Eval      D3TRMDT =  D3SCTR3
521700090914     C                   When      D3SCEF4 <> *BLANKS
521800091029     C                   Eval      D3TRMDT =  D3SCTR4
521900090914     C                   Endsl
522000090914     C                   End
522100090914     C                   End
522200090914     C                   End
522300090824      *
522400090730      * If the end result is an TRM, and NOCHG plan exist, must be CHANGE.
522500090730     C                   If        D3MNTYP = 'T'
522600090730     C                   If        D3FIL41 = 'N'
522700090730     C                   Eval      D3MNTYP = 'C'
522800090730     C                   Eval      D3MNRSN = '7'
522900090730     C                   End
523000090730     C                   If        D3FIL42 = 'N'
523100090730     C                   Eval      D3MNTYP = 'C'
523200090730     C                   Eval      D3MNRSN = '7'
523300090730     C                   End
523400090730     C                   If        D3FIL43 = 'N'
523500090730     C                   Eval      D3MNTYP = 'C'
523600090730     C                   Eval      D3MNRSN = '7'
523700090730     C                   End
523800090730     C                   If        D3FIL44 = 'N'
523900090730     C                   Eval      D3MNTYP = 'C'
524000090730     C                   Eval      D3MNRSN = '7'
524100090730     C                   End
524200090730     C                   End
524300090813      *
524400090813      * If the end result is an RIE, and NOCHG plan exist, must be CHANGE.
524500090813     C                   If        D3MNTYP = 'R'
524600090813     C                   If        D3FIL41 = 'N'
524700090813     C                   Eval      D3MNTYP = 'C'
524800090813     C                   Eval      D3MNRSN = '7'
524900090813     C                   End
525000090813     C                   If        D3FIL42 = 'N'
525100090813     C                   Eval      D3MNTYP = 'C'
525200090813     C                   Eval      D3MNRSN = '7'
525300090813     C                   End
525400090813     C                   If        D3FIL43 = 'N'
525500090813     C                   Eval      D3MNTYP = 'C'
525600090813     C                   Eval      D3MNRSN = '7'
525700090813     C                   End
525800090813     C                   If        D3FIL44 = 'N'
525900090813     C                   Eval      D3MNTYP = 'C'
526000090813     C                   Eval      D3MNRSN = '7'
526100090813     C                   End
526200090813     C                   End
526300120316
526400120316      *** WARNING ****  Per Cindie,this was an EPOC FAIL!
526500120316
526600120316      * If the end result is CHG, and NOCHG plan exist, must be TODAY.
526700120316      * Issue where on a demograph change the CFS expected old plan eff
526800120316      * not the new plan effect date so to force the error to CFS side we
526900120316      * use today's date as the product date.  Cindie.
527000120821     C     *Date         Mult      10000.0001    Today
527100120821     C                   Movel     Today         Input_Date
527200120821     C                   Eval      Input_Format = 'YYYYMMDD'
527300120821     C                   Eval      Output_Format  = 'MM/DD/YYYY'
527400120821     C                   Exsr      FormatDateSR
527500120821     C                   Eval      WTODAY        = %trim(Output_Date)
527600120821      *
527700120821     C                   If        D3MNTYP = 'C'
527800120821     C                   If        D3FIL41 = 'N'
527900120821     C                   Movel     D3SCEF1       Input_Date
528000120821     C                   Eval      Input_Format = 'MM/DD/YYYY'
528100120821     C                   Eval      Output_Format  = 'YYYYMMDD'
528200120821     C                   Exsr      FormatDateSR
528300120821     C                   Movel     Output_date   w80date
528400120821     C                   If        w80date < Today
528500130604     C***                Eval      D3SCEF1 = %trim(WTODAY)
528600120821     C                   End
528700120821     C                   End
528800120821     C                   If        D3FIL42 = 'N'
528900120821     C                   Movel     D3SCEF2       Input_Date
529000120821     C                   Eval      Input_Format = 'MM/DD/YYYY'
529100120821     C                   Eval      Output_Format  = 'YYYYMMDD'
529200120821     C                   Exsr      FormatDateSR
529300120821     C                   Movel     Output_date   w80date
529400120821     C                   If        w80date < Today
529500130604     C***                Eval      D3SCEF2 = %trim(WTODAY)
529600120821     C                   End
529700120821     C                   End
529800120821     C                   If        D3FIL43 = 'N'
529900120821     C                   Movel     D3SCEF3       Input_Date
530000120821     C                   Eval      Input_Format = 'MM/DD/YYYY'
530100120821     C                   Eval      Output_Format  = 'YYYYMMDD'
530200120821     C                   Exsr      FormatDateSR
530300120821     C                   Movel     Output_date   w80date
530400120821     C                   If        w80date < Today
530500130604     C***                Eval      D3SCEF3 = %trim(WTODAY)
530600120821     C                   End
530700120821     C                   End
530800120821     C                   If        D3FIL44 = 'N'
530900120821     C                   Movel     D3SCEF4       Input_Date
531000120821     C                   Eval      Input_Format = 'MM/DD/YYYY'
531100120821     C                   Eval      Output_Format  = 'YYYYMMDD'
531200120821     C                   Exsr      FormatDateSR
531300120821     C                   Movel     Output_date   w80date
531400120821     C                   If        w80date < Today
531500130604     C***                Eval      D3SCEF4 = %trim(WTODAY)
531600120821     C                   End
531700120821     C                   End
531800120821     C                   End
531900120907      *
532000120907      * Sometimes the do a DEMO Only and change all the flags to A just
532100120907      * to push through the products using today date if prod old.
532200120907      *
532300120907     C                   If        DEMONLY = 'Y'
532400120907     C                   If        D3FIL41 = 'A'
532500120907     C                   Movel     D3SCEF1       Input_Date
532600120907     C                   Eval      Input_Format = 'MM/DD/YYYY'
532700120907     C                   Eval      Output_Format  = 'YYYYMMDD'
532800120907     C                   Exsr      FormatDateSR
532900120907     C                   Movel     Output_date   w80date
533000120907     C                   If        w80date < Today
533100120925     C****               Eval      D3SCEF1 = %trim(WTODAY)
533200120907     C                   End
533300120907     C                   End
533400120907     C                   If        D3FIL42 = 'A'
533500120907     C                   Movel     D3SCEF2       Input_Date
533600120907     C                   Eval      Input_Format = 'MM/DD/YYYY'
533700120907     C                   Eval      Output_Format  = 'YYYYMMDD'
533800120907     C                   Exsr      FormatDateSR
533900120907     C                   Movel     Output_date   w80date
534000120907     C                   If        w80date < Today
534100120925     C****               Eval      D3SCEF2 = %trim(WTODAY)
534200120907     C                   End
534300120907     C                   End
534400120907     C                   If        D3FIL43 = 'A'
534500120907     C                   Movel     D3SCEF3       Input_Date
534600120907     C                   Eval      Input_Format = 'MM/DD/YYYY'
534700120907     C                   Eval      Output_Format  = 'YYYYMMDD'
534800120907     C                   Exsr      FormatDateSR
534900120907     C                   Movel     Output_date   w80date
535000120907     C                   If        w80date < Today
535100120925     C****               Eval      D3SCEF3 = %trim(WTODAY)
535200120907     C                   End
535300120907     C                   End
535400120907     C                   If        D3FIL44 = 'A'
535500120907     C                   Movel     D3SCEF4       Input_Date
535600120907     C                   Eval      Input_Format = 'MM/DD/YYYY'
535700120907     C                   Eval      Output_Format  = 'YYYYMMDD'
535800120907     C                   Exsr      FormatDateSR
535900120907     C                   Movel     Output_date   w80date
536000120907     C                   If        w80date < Today
536100120925     C****               Eval      D3SCEF4 = %trim(WTODAY)
536200120907     C                   End
536300120907     C                   End
536400120907     C                   End
536500090902      *
536600090902      * Check existing CFS
536700090902     C                   If        W_SEQ = 0
536800090902     C                   If        D3MNTYP = 'C'
536900090902     C                   If        (D3FIL41 = 'R' or
537000090902     C                             D3FIL41 = ' ') and
537100090902     C                             (D3FIL42 = 'R' or
537200090902     C                             D3FIL42 = ' ') and
537300090902     C                             (D3FIL43 = 'R' or
537400090902     C                             D3FIL43 = ' ') and
537500090902     C                             (D3FIL44 = 'R' or
537600090902     C                             D3FIL44 = ' ')
537700090902      *
537800090902     C                   Move      SOCSOC        P_SSN
537900100118     C                   Move      W_SEQ         P_SEQ
538000090902     C                   Move      *BLANKS       P_FLG
538100090902     C                   Movea     APLN          KING
538200090902      *
538300090902     C                   Call      'DW311ANYC'
538400090902     C                   Parm                    P_SSN
538500090902     C                   Parm                    P_FLG
538600090902     C                   Parm                    KING
538700090902      *
538800090902     C                   If        P_FLG = ' '
538900090902     C                   Eval      MBRTYP  = 'R'
539000090902     C                   Eval      D3MNTYP = 'R'
539100090902     C                   Eval      D3MNRSN = '3'
539200090902     C                   End
539300090902      *
539400090902     C                   End
539500090902     C                   End
539600090902     C                   End
539700091109      *
539800091109      * Check Account Transfer - Member Only
539900091118     C                   If        W_SEQ   =   0    and
540000091118     C                             D3MNTYP <> 'T'
540100091109     C                   Exsr      CHKUTM
540200091109     C                   End
540300090409      *
540400090825      * Dependents Only if member endend up REINSTATE then dep must be
540500090825     C                   If        W_SEQ <> 0
540600090825     C                   If        MBRTYP = 'R' and
540700090825     C                             D3MNTYP = 'C'
540800090825     C                   Eval      D3MNTYP = 'R'
540900090825     C                   Eval      D3MNRSN = '4'
541000090825     C                   End
541100090825     C                   Else
541200090825     C                   Eval      MBRTYP = D3MNTYP
541300090825     C                   End
541400100208      *
541500100208      * Member Only - On Reinstate, If DOH changes, set flag
541600100208     C                   Eval      D3FIL5  = ' '
541700100208     C                   If        W_SEQ   =   0   and
541800100208     C                             D3MNTYP = 'R'
541900100208     C                   If        OEMPDT <> EMPDT
542000100208     C                   Eval      D3FIL5  = 'Y'
542100100208     C                   End
542200100208     C                   End
542300111115
542400111115     C     WEBKEY        Klist
542500111115     C                   Kfld                    TRUST
542600111115     C                   Kfld                    SUBNO
542700111115     C                   Kfld                    ACCNO
542800111115     C                   Kfld                    SOCSOC
542900111115     C                   Kfld                    W_SEQ
543000111115
543100111115      * If end result is "A" Check added from WEBTRAN, close sent date
543200111115     C                   If        D3MNTYP = 'A'
543300111115     C     WEBKEY        Chain     WEBTRNMIT
543400111115     C                   If        %found(WEBTRNMIT)
543500111115     C                   If        TMSNDT = 0
543600111115     C     *Date         Mult      10000.0001    TMSNDT
543700111115     C                   Time                    TMSNTM
543800111115     C                   Update    WEBTRNMITR
543900111115     C                   End
544000111115     C                   End
544100111115     C                   End
544200100209      *
544300100209      * Member only
544400100209      * If end result is "A" and it was added from conversion, "C"
544500100209     C                   If        W_SEQ = 0     and
544600100209     C                             D3MNTYP = 'A' and
544700100209     C                             Q_FLG   = 'Y'
544800100209     C                   Eval      D3MNTYP = 'C'
544900100209     C                   End
545000120611      *
545100120828      * If Dem Only then product eff = Today (off becuase see EPOC above)
545200120828     C***                If        DEMONLY = 'Y'
545300120828     C***                If        D3SCEF1 <> *BLANKS
545400120828     C***  *Date         Mult      10000.0001    Today
545500120828     C***                Movel     Today         Input_Date
545600120828     C***                Eval      Input_Format = 'YYYYMMDD'
545700120828     C***                Eval      Output_Format  = 'MM/DD/YYYY'
545800120828     C***                Exsr      FormatDateSR
545900120828     C***                Eval      D3SCEF1       = %trim(Output_Date)
546000120828     C***                End
546100120828     C***                If        D3SCEF2 <> *BLANKS
546200120828     C***  *Date         Mult      10000.0001    Today
546300120828     C***                Movel     Today         Input_Date
546400120828     C***                Eval      Input_Format = 'YYYYMMDD'
546500120828     C***                Eval      Output_Format  = 'MM/DD/YYYY'
546600120828     C***                Exsr      FormatDateSR
546700120828     C***                Eval      D3SCEF2       = %trim(Output_Date)
546800120828     C***                End
546900120828     C***                If        D3SCEF3 <> *BLANKS
547000120828     C***  *Date         Mult      10000.0001    Today
547100120828     C***                Movel     Today         Input_Date
547200120828     C***                Eval      Input_Format = 'YYYYMMDD'
547300120828     C***                Eval      Output_Format  = 'MM/DD/YYYY'
547400120828     C***                Exsr      FormatDateSR
547500120828     C***                Eval      D3SCEF3       = %trim(Output_Date)
547600120828     C***                End
547700120828     C***                If        D3SCEF4 <> *BLANKS
547800120828     C***  *Date         Mult      10000.0001    Today
547900120828     C***                Movel     Today         Input_Date
548000120828     C***                Eval      Input_Format = 'YYYYMMDD'
548100120828     C***                Eval      Output_Format  = 'MM/DD/YYYY'
548200120828     C***                Exsr      FormatDateSR
548300120828     C***                Eval      D3SCEF4       = %trim(Output_Date)
548400120828     C***                End
548500120828     C***                End
548600090825      *
548700090902      * Also on ADD, blank out OLD fields
548800090902     C                   If        D3MNTYP = 'A'
548900090902     C                   Move      *BLANKS       D4OLDFN
549000090902     C                   Move      *BLANKS       D4OLDLS
549100090902     C                   Move      *BLANKS       D4OLDMI
549200090902     C                   Move      *BLANKS       D4OLDBI
549300090902     C                   Move      *BLANKS       D3OLDFN
549400090902     C                   Move      *BLANKS       D3OLDLS
549500090902     C                   Move      *BLANKS       D3OLDMI
549600090902     C                   Move      *BLANKS       D3OLDBI
549700090902     C                   End
549800091027      *
549900091202      *Create PCP Only report and skip write
550000091028     C                   If        APCP(1)   = 'Y' and
550100091028     C                             ADEMO(1) <> 'Y' and
550200091027     C                             cdc = 0
550300180510     C                   If        D3SFX = '00' or
550400180510     C                             D3SFX = '  '
550500091027     C                   Eval      WWSD = 'S'
550600091027     C                   Else
550700091027     C                   Eval      WWSD = 'D'
550800091027     C                   End
550900091027
551000091027     C                   Eval      WWNAM = %trim(D3FST) + ' ' +
551100091027     C                                     %trim(D3MID) + ' ' +
551200091027     C                                     %trim(D3LST)
551300091027
551400091027     C                   Exsr      CheckPCPOflow
551500091027     C                   Eval      X_T2000 =  '"' +
551600091027     C                                     %trim(GROUP#) + '","' +
551700091027     C                                     %trim(D3TSANM) + '","' +
551800091027     C                                     %trim(D3TSA)  + '","' +
551900091027     C                                     %trim(D3SUB)  + '","' +
552000091027     C                                     %trim(WWNAM)  + '","' +
552100091027     C                                     %trim(WWSD)  + '","' +
552200091027     C                                     %trim(D3PRVID1)  + '","' +
552300091027     C                                     %trim(D3PRVEF1)+ '",'
552400091027     C                   WRITE     R2000
552500091202     C                   Eval      SKIPWRT = 'Y'
552600091027     C                   End
552700091027      *
552800091106     C   U1              If        SKIPWRT  =  'Y'
552900091106     C   U1              Eval      SKIPWRT  =  'N'
553000091106     C                   End
553100091106      *
553200090409     C                   ENDSR
553300000000      *___________________________________________________________________
553400000000      * Program open
553500000000      *___________________________________________________________________
553600000000     C     *INZSR        BEGSR
553700021024     C                   Eval      MMDDYYYY =    *DATE
553800021024     C                   Time                    HHMMSS
553900021106     C                   Eval      *IN99    =    *IN99
554000091027    ?C                   Move      *on           *in91
554100091027    ?C                   Move      *on           *in92
554200000000     C                   ENDSR
554300021024      *___________________________________________________________________
554400021024      * Format Date
554500021024      *___________________________________________________________________
554600021024     C     FormatDateSR  BEGSR
554700021024     C                   Call      'FMTDATE'
554800021024     C                   Parm                    Input_Date       32
554900021024     C                   Parm                    Input_Format     32
555000021024     C                   Parm                    Output_Format    32
555100021024     C                   Parm                    Output_Date      32
555200021024     C                   Parm                    Output_Error     10
555300090422     C                   Eval      Input_Date   = *blanks
555400090422     C                   Eval      Input_Format = *blanks
555500090422     C                   Eval      OutPut_Format = *blanks
555600021024     C                   ENDSR
555700021024      *___________________________________________________________________
555800021024      * Key List
555900021024      *___________________________________________________________________
556000021024     C     KLIST         BEGSR
556100021213     C     DW310KeyPF    KLIST
556200021213     C                   KFLD                    SOCSOC
556300021213     C                   KFLD                    W_SEQ
556400021111     C     DW310Key      KLIST
556500021111     C                   KFLD                    SOCSOC
556600021203     C                   KFLD                    W_SEQ
556700021111     C                   KFLD                    W_CAT
556800021024     C     ClassKey      KLIST
556900021111     C                   KFLD                    X_DWTRST
557000021111     C                   KFLD                    X_DWSUB#
557100021111     C                   KFLD                    X_DWPlan
557200021106     C                   KFLD                    W_COVTP
557300021024     C                   ENDSR
557400021202     C     WKACC         KLIST
557500021209     C                   KFLD                    W_FFFFFF
557600140725     C                   KFLD                    W_TC
557700140725     C                   KFLD                    W_SC
557800140725     C                   KFLD                    W_AC
557900081111     C     WKACT         KLIST
558000140725     C                   KFLD                    W_TC
558100140725     C                   KFLD                    W_SC
558200140725     C                   KFLD                    W_AC
558300030612      *___________________________________________________________________
558400030612      * Check Overflow - Print Header
558500030612      *___________________________________________________________________
558600030612     C     CheckOverflow BEGSR
558700030612     C                   If        *in91  = *on  or
558800030612     C                             Count  = 2
558900030612     C                   Write     PRTHDR
559000030612     C                   Move      *off          *In91
559100030612     C                   Eval      Count =  0
559200030612     C                   End
559300030612     C                   ENDSR
559400091027      *___________________________________________________________________
559500091027      * Check Overflow - Print Header
559600091027      *___________________________________________________________________
559700091027     C     CheckPCPOflow BEGSR
559800091027     C                   If        *in92  = *on
559900091027     C                   eval      X_T2000 = 'Group - Sub Group' + ',' +
560000091027     C                                     'Account Name' + ',' +
560100091027     C                                     'GBS TSA Number' + ',' +
560200091027     C                                     'SSN' + ',' +
560300091027     C                                     'Name' + ',' +
560400091027     C                                     'Sub/Dep' + ',' +
560500091027     C                                     'PCP' + ',' +
560600091027     C                                     'PCP Eff' + ','
560700091027     C                   WRITE     R2000
560800091027     C                   Move      *off          *In92
560900091027     C                   End
561000091027     C                   ENDSR
561100090812      *___________________________________________________________________
561200090812      * Check for Reinstatement F6
561300090812      *___________________________________________________________________
561400090812     C     CHKREIN       BEGSR
561500090812      *
561600090812      * Format Date
561700090812     C                   Eval      Input_Format = 'MM/DD/YYYY'
561800090812     C                   Eval      Output_Format  = 'YYYYMMDD'
561900090812     C                   Exsr      FormatDateSR
562000090812     C                   Eval      WCDATE        = %trim(Output_Date)
562100090812      *
562200090812     C                   Eval      P_FLG = *BLANKS
562300090812     C                   Move      SOCSOC        P_SSN
562400090812     C                   Call      'DW311EREC'
562500090812     C                   Parm                    P_SSN
562600090812     C                   Parm                    WCDATE
562700090812     C                   Parm                    P_FLG
562800090812      *
562900090812     C                   If        P_FLG = 'Y'
563000090812     C                   Eval      D3MNTYP = 'R'
563100090812     C                   Eval      D3MNRSN = '3'
563200090827     C                   Eval      R_FLG = 'Y'
563300090812     C                   End
563400090812      *
563500090812     C                   ENDSR
563600091109      *___________________________________________________________________
563700091109      * Check for Account Transfer
563800091109      *___________________________________________________________________
563900091109     C     CHKUTM        BEGSR
564000091109      *
564100091109      * Format Date
564200091117     C                   Select
564300091117     C                   When      D3SCEF1 <> *blanks
564400091117     C                   Movel     D3SCEF1       Input_Date
564500091117     C                   When      D3SCEF2 <> *blanks
564600091117     C                   Movel     D3SCEF2       Input_Date
564700091117     C                   When      D3SCEF3 <> *blanks
564800091117     C                   Movel     D3SCEF3       Input_Date
564900091117     C                   When      D3SCEF4 <> *blanks
565000091117     C                   Movel     D3SCEF4       Input_Date
565100091117     C                   Other
565200091117     C                   Movel     D3CLSE        Input_Date
565300091117     C                   Endsl
565400091109     C                   Eval      Input_Format = 'MM/DD/YYYY'
565500091109     C                   Eval      Output_Format  = 'YYYYMMDD'
565600091109     C                   Exsr      FormatDateSR
565700091109     C                   Eval      WCDATE        = %trim(Output_Date)
565800091109      *
565900091109     C                   Eval      U_FLG = *BLANKS
566000091112     C                   Eval      U_CATM = *BLANKS
566100091112     C                   Eval      U_CATR = *BLANKS
566200091112     C                   Eval      U_CATD = *BLANKS
566300091112     C                   Eval      U_CATV = *BLANKS
566400091112      *
566500091109     C                   Move      SOCSOC        P_SSN
566600091109     C                   Call      'DW311UTMC'
566700091109     C                   Parm                    P_SSN
566800091109     C                   Parm                    WCDATE
566900091109     C                   Parm                    U_FLG
567000091112     C                   Parm                    U_CATM
567100091112     C                   Parm                    U_CATR
567200091112     C                   Parm                    U_CATD
567300091112     C                   Parm                    U_CATV
567400091109      *
567500100209      * If group change and
567600091111      * If Y, true account transfer, must be ADD
567700091111     C                   Select
567800100209     C                   When      U_FLG = 'Y'  and
567900100209     C                             Q_GRP = 'Y'
568000091109     C                   Eval      D3MNTYP = 'A'
568100091109     C                   Eval      D3MNRSN = '1'
568200091109     C                   If        D3FIL41 <> *blanks
568300091109     C                   Eval      D3FIL41 = 'A'
568400091109     C                   Eval      D3SCAT5  =   *Blanks
568500091109     C                   Eval      D3SCEF5  =   *Blanks
568600091109     C                   Eval      D3SCTR5  =   *Blanks
568700091109     C                   Eval      D3SEVT5  =   *Blanks
568800091109     C                   Eval      D3SFAM5  =   *Blanks
568900091109     C                   Eval      D3SLVL5  =   *Blanks
569000091109     C                   Eval      D3FIL45  =   *Blanks
569100091109     C                   End
569200091109     C                   If        D3FIL42 <> *blanks
569300091109     C                   Eval      D3FIL42 = 'A'
569400091109     C                   Eval      D3SCAT6  =   *Blanks
569500091109     C                   Eval      D3SCEF6  =   *Blanks
569600091109     C                   Eval      D3SCTR6  =   *Blanks
569700091109     C                   Eval      D3SEVT6  =   *Blanks
569800091109     C                   Eval      D3SFAM6  =   *Blanks
569900091109     C                   Eval      D3SLVL6  =   *Blanks
570000091109     C                   Eval      D3FIL46  =   *Blanks
570100091109     C                   End
570200091109     C                   If        D3FIL43 <> *blanks
570300091109     C                   Eval      D3FIL43 = 'A'
570400091109     C                   Eval      D3SCAT7  =   *Blanks
570500091109     C                   Eval      D3SCEF7  =   *Blanks
570600091109     C                   Eval      D3SCTR7  =   *Blanks
570700091109     C                   Eval      D3SEVT7  =   *Blanks
570800091109     C                   Eval      D3SFAM7  =   *Blanks
570900091109     C                   Eval      D3SLVL7  =   *Blanks
571000091109     C                   Eval      D3FIL47  =   *Blanks
571100091109     C                   End
571200091109     C                   If        D3FIL44 <> *blanks
571300091109     C                   Eval      D3FIL44 = 'A'
571400091109     C                   Eval      D3SCAT8  =   *Blanks
571500091109     C                   Eval      D3SCEF8  =   *Blanks
571600091109     C                   Eval      D3SCTR8  =   *Blanks
571700091109     C                   Eval      D3SEVT8  =   *Blanks
571800091109     C                   Eval      D3SFAM8  =   *Blanks
571900091109     C                   Eval      D3SLVL8  =   *Blanks
572000091109     C                   Eval      D3FIL48  =   *Blanks
572100091109     C                   End
572200091111      *
572300091112      * Same account transfer...
572400091112      * If S, same account transfer, must be REI if Prior
572500091111     C                   When      U_FLG = 'S'
572600091112     C                   If        D3FIL41 <> *blanks  and
572700091112     C                             U_CATM  <> *Blanks
572800091112     C                   Eval      D3FIL41 = 'R'
572900091112     C                   Eval      D3SCAT5  =   *Blanks
573000091112     C                   Eval      D3SCEF5  =   *Blanks
573100091112     C                   Eval      D3SCTR5  =   *Blanks
573200091112     C                   Eval      D3SEVT5  =   *Blanks
573300091112     C                   Eval      D3SFAM5  =   *Blanks
573400091112     C                   Eval      D3SLVL5  =   *Blanks
573500091112     C                   Eval      D3FIL45  =   *Blanks
573600091112     C                   End
573700091112     C                   If        D3FIL42 <> *blanks   and
573800091112     C                             U_CATR  <> *Blanks
573900091112     C                   Eval      D3FIL42 = 'R'
574000091112     C                   Eval      D3SCAT6  =   *Blanks
574100091112     C                   Eval      D3SCEF6  =   *Blanks
574200091112     C                   Eval      D3SCTR6  =   *Blanks
574300091112     C                   Eval      D3SEVT6  =   *Blanks
574400091112     C                   Eval      D3SFAM6  =   *Blanks
574500091112     C                   Eval      D3SLVL6  =   *Blanks
574600091112     C                   Eval      D3FIL46  =   *Blanks
574700091112     C                   End
574800091112     C                   If        D3FIL43 <> *blanks   and
574900091112     C                             U_CATD  <> *Blanks
575000091112     C                   Eval      D3FIL43 = 'R'
575100091112     C                   Eval      D3SCAT7  =   *Blanks
575200091112     C                   Eval      D3SCEF7  =   *Blanks
575300091112     C                   Eval      D3SCTR7  =   *Blanks
575400091112     C                   Eval      D3SEVT7  =   *Blanks
575500091112     C                   Eval      D3SFAM7  =   *Blanks
575600091112     C                   Eval      D3SLVL7  =   *Blanks
575700091112     C                   Eval      D3FIL47  =   *Blanks
575800091112     C                   End
575900091112     C                   If        D3FIL44 <> *blanks   and
576000091112     C                             U_CATV  <> *Blanks
576100091112     C                   Eval      D3FIL44 = 'R'
576200091112     C                   Eval      D3SCAT8  =   *Blanks
576300091112     C                   Eval      D3SCEF8  =   *Blanks
576400091112     C                   Eval      D3SCTR8  =   *Blanks
576500091112     C                   Eval      D3SEVT8  =   *Blanks
576600091112     C                   Eval      D3SFAM8  =   *Blanks
576700091112     C                   Eval      D3SLVL8  =   *Blanks
576800091112     C                   Eval      D3FIL48  =   *Blanks
576900091112     C                   End
577000091111     C                   Endsl
577100091109      *
577200091109     C                   ENDSR
577300091103      *___________________________________________________________________
577400091103      * Check for Reinstatement History Record
577500091103      *___________________________________________________________________
577600091103     C     CHKREIN2      BEGSR
577700091103      *
577800091103      * Format Date
577900091103     C                   Movel     D3CLSE        Input_Date
578000091103     C                   Eval      Input_Format = 'MM/DD/YYYY'
578100091103     C                   Eval      Output_Format  = 'YYYYMMDD'
578200091103     C                   Exsr      FormatDateSR
578300091103     C                   Eval      WCDATE        = %trim(Output_Date)
578400091103      *
578500091103     C                   Eval      P_FLG = *BLANKS
578600091103     C                   Move      SOCSOC        P_SSN
578700091103     C                   Call      'DW311EREC'
578800091103     C                   Parm                    P_SSN
578900091103     C                   Parm                    WCDATE
579000091103     C                   Parm                    P_FLG
579100091103      *
579200091103     C                   If        P_FLG = 'Y'
579300091103     C                   Eval      D3MNTYP = 'R'
579400091103     C                   Eval      D3MNRSN = '3'
579500091103     C                   Eval      R_FLG = 'Y'
579600091103     C                   If        D3FIL41 = 'C'
579700091103     C                   Eval      D3FIL41 = 'R'
579800091103     C                   End
579900091103     C                   If        D3FIL42 = 'C'
580000091103     C                   Eval      D3FIL42 = 'R'
580100091103     C                   End
580200091103     C                   If        D3FIL43 = 'C'
580300091103     C                   Eval      D3FIL43 = 'R'
580400091103     C                   End
580500091103     C                   If        D3FIL44 = 'C'
580600091103     C                   Eval      D3FIL44 = 'R'
580700091103     C                   End
580800091103     C                   End
580900091103      *
581000091103     C                   ENDSR
581100090428      *___________________________________________________________________
581200090428      * Check for Renewal
581300090428      *___________________________________________________________________
581400090428     C     CheckRenewal  BEGSR
581500090428      *
581600090428     C                   Eval      D3RNWLD = *BLANKS
581700090428      *
581800090428      * GBS Begin Admin Date
581900090428     C                   IF        N_GBSBDT <> 0
582000090428      *
582100090428     C     *Date         Mult      10000.0001    Today
582200090428     C     *ISO          Move      Today         isoToday
582300090428     C                   extrct    isoToday:*m   curmth
582400090428     C                   extrct    isoToday:*y   curyer
582500090428      *
582600090428     C     *ISO          Move      N_GBSBDT      isoToday
582700090428     C                   extrct    isoToday:*m   renmon
582800090428     C                   extrct    isoToday:*d   renday
582900110330     C                   extrct    isoToday:*m   renmth
583000110330     C                   extrct    isoToday:*y   renyer
583100090428     C                   eval      renmth = renmth - 1
583200090428     C                   If        renmth = 0
583300090428     C                   eval      renmth = 12
583400090428     C                   End
583500090428      *
583600090428      * If renewal (month - 1) is December, actual year is next year
583700090428     C                   If        renmth = 12
583800090428     C                   eval      curyer = curyer + 1
583900090428     C                   End
584000090428      *
584100110330     C                   If        curyer > renyer
584200090428      * If reneal is this month or next month, then your in renewal
584300090428     C                   If        curmth = renmon  or
584400090428     C                             curmth = renmth
584500090428     C                   Eval      R_Y = curyer
584600090428     C                   Eval      R_M = renmon
584700090428     C                   Eval      R_D = renday
584800110330
584900090731      * If Renewal Date is less than CFS Effective Date, use CFS Date
585000090731     C     KMSP          Chain     ACCMSP
585100090731     C                   If        %found(ACCMSP)
585200090731     C                   If        RENEWAL < AMC8DT
585300090731     C                   Movel     AMC8DT        RENEWAL
585400090731     C                   End
585500090731     C                   End
585600090731
585700090428     C                   Movel     RENEWAL       Input_Date
585800090428     C                   Eval      Input_Format  = 'YYYYMMDD'
585900090428     C                   Eval      Output_Format = 'MM/DD/YYYY'
586000090428     C                   Exsr      FormatDateSR
586100090428     C                   Eval      D3RNWLD = %trim(Output_Date)
586200090428     C                   End
586300110330     C                   End
586400090428     C                   End
586500090428      *
586600090428     C                   ENDSR
586700091124      *___________________________________________________________________
586800091124      * Plan Tracking
586900091124      *___________________________________________________________________
587000091124     C     PlanTracking  BEGSR
587100091124
587200091124      * MED
587300091124     C                   If        T_PLNM <> *BLANKS
587400091124     C                   Eval      DTSSN = SOCSOC
587500091124     C                   Eval      DTSEQ = W_SEQ
587600091124     C                   Eval      DTPLN = T_PLNM
587700091124     C                   Eval      DTCAT = 'M'
587800091124     C                   Eval      DTFLG = D3FIL41
587900091124
588000091124     C                   If        D3SCEF1 <> *BLANKS
588100091124     C                   Movel     D3SCEF1       Input_Date
588200091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
588300091124     C                   Eval      Output_Format  = 'YYYYMMDD'
588400091124     C                   Exsr      FormatDateSR
588500091124     C                   Movel     Output_Date   DTEFF
588600091124     C                   Else
588700091124     C                   Eval      DTEFF  =  *Zeros
588800091124     C                   End
588900091124
589000091124     C                   If        D3SCTR1 <> *BLANKS
589100091124     C                   Movel     D3SCTR1       Input_Date
589200091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
589300091124     C                   Eval      Output_Format  = 'YYYYMMDD'
589400091124     C                   Exsr      FormatDateSR
589500091124     C                   Movel     Output_Date   DTTRM
589600091124     C                   Else
589700091124     C                   Eval      DTTRM  =  *Zeros
589800091124     C                   End
589900091124
590000091124     C     *Date         Mult      10000.0001    DTSNT
590100091124     C                   Write     DW311TR
590200091124     C                   End
590300091124
590400091124      * RXD
590500091124     C                   If        T_PLNR <> *BLANKS
590600091124     C                   Eval      DTSSN = SOCSOC
590700091124     C                   Eval      DTSEQ = W_SEQ
590800091124     C                   Eval      DTPLN = T_PLNR
590900091124     C                   Eval      DTCAT = 'R'
591000091124     C                   Eval      DTFLG = D3FIL42
591100091124
591200091124     C                   If        D3SCEF2 <> *BLANKS
591300091124     C                   Movel     D3SCEF2       Input_Date
591400091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
591500091124     C                   Eval      Output_Format  = 'YYYYMMDD'
591600091124     C                   Exsr      FormatDateSR
591700091124     C                   Movel     Output_Date   DTEFF
591800091124     C                   Else
591900091124     C                   Eval      DTEFF  =  *Zeros
592000091124     C                   End
592100091124
592200091124     C                   If        D3SCTR2 <> *BLANKS
592300091124     C                   Movel     D3SCTR2       Input_Date
592400091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
592500091124     C                   Eval      Output_Format  = 'YYYYMMDD'
592600091124     C                   Exsr      FormatDateSR
592700091124     C                   Movel     Output_Date   DTTRM
592800091124     C                   Else
592900091124     C                   Eval      DTTRM  =  *Zeros
593000091124     C                   End
593100091124
593200091124     C     *Date         Mult      10000.0001    DTSNT
593300091124     C                   Write     DW311TR
593400091124     C                   End
593500091124
593600091124      * DEN
593700091124     C                   If        T_PLND <> *BLANKS
593800091124     C                   Eval      DTSSN = SOCSOC
593900091124     C                   Eval      DTSEQ = W_SEQ
594000091124     C                   Eval      DTPLN = T_PLND
594100091124     C                   Eval      DTCAT = 'D'
594200091124     C                   Eval      DTFLG = D3FIL43
594300091124
594400091124     C                   If        D3SCEF3 <> *BLANKS
594500091124     C                   Movel     D3SCEF3       Input_Date
594600091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
594700091124     C                   Eval      Output_Format  = 'YYYYMMDD'
594800091124     C                   Exsr      FormatDateSR
594900091124     C                   Movel     Output_Date   DTEFF
595000091124     C                   Else
595100091124     C                   Eval      DTEFF  =  *Zeros
595200091124     C                   End
595300091124
595400091124     C                   If        D3SCTR3 <> *BLANKS
595500091124     C                   Movel     D3SCTR3       Input_Date
595600091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
595700091124     C                   Eval      Output_Format  = 'YYYYMMDD'
595800091124     C                   Exsr      FormatDateSR
595900091124     C                   Movel     Output_Date   DTTRM
596000091124     C                   Else
596100091124     C                   Eval      DTTRM  =  *Zeros
596200091124     C                   End
596300091124
596400091124     C     *Date         Mult      10000.0001    DTSNT
596500091124     C                   Write     DW311TR
596600091124     C                   End
596700091124
596800091124      * VIS
596900091124     C                   If        T_PLNV <> *BLANKS
597000091124     C                   Eval      DTSSN = SOCSOC
597100091124     C                   Eval      DTSEQ = W_SEQ
597200091208     C                   Eval      DTPLN = T_PLNV
597300091124     C                   Eval      DTCAT = 'V'
597400091124     C                   Eval      DTFLG = D3FIL44
597500091124
597600091124     C                   If        D3SCEF4 <> *BLANKS
597700091124     C                   Movel     D3SCEF4       Input_Date
597800091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
597900091124     C                   Eval      Output_Format  = 'YYYYMMDD'
598000091124     C                   Exsr      FormatDateSR
598100091124     C                   Movel     Output_Date   DTEFF
598200091124     C                   Else
598300091124     C                   Eval      DTEFF  =  *Zeros
598400091124     C                   End
598500091124
598600091124     C                   If        D3SCTR4 <> *BLANKS
598700091124     C                   Movel     D3SCTR4       Input_Date
598800091124     C                   Eval      Input_Format = 'MM/DD/YYYY'
598900091124     C                   Eval      Output_Format  = 'YYYYMMDD'
599000091124     C                   Exsr      FormatDateSR
599100091124     C                   Movel     Output_Date   DTTRM
599200091124     C                   Else
599300091124     C                   Eval      DTTRM  =  *Zeros
599400091124     C                   End
599500091124
599600091124     C     *Date         Mult      10000.0001    DTSNT
599700091124     C                   Write     DW311TR
599800091124     C                   End
599900091124
600000091124     C                   ENDSR
600100091207      *___________________________________________________________________
600200091207      * Plan Tracking
600300091207      *___________________________________________________________________
600400091207     C     WRT834        BEGSR
600500091207     C                   Clear                   HISTR
600600091207
600700091207     C                   Eval      H_CK#NOT = 'TRANSMITTED'
600800091207     C                   MOVE      SOCSOC        H_HKEY
600900091207     C                   Eval      H_TRCODE = 'U61'
601000091207     C                   Eval      H_HOPER = %trim(QQRVWR)
601100091207     C                   Eval      H_HPRGNM = 'DW311R'
601200091207     C                   Eval      H_HSTRST = TRUST
601300091207     C                   Eval      H_HSSUB# = SUBNO
601400091207     C                   Eval      H_HSACCT = ACCNO
601500091207     C                   Eval      H_HSDLTD = 'A'
601600091207     C     *Date         Mult      10000.0001    H_TRDATE
601700091207     C     *Date         Mult      10000.0001    H_COVTDT
601800131010     c                   eval      h_hstrtime = %time
601900091207     C                   WRITE     HISTR
602000091207     C                   ENDSR
602100100121      *___________________________________________________________________
602200100121      * Reset work fields L3
602300100121      *___________________________________________________________________
602400100121     C     RESETL3       BEGSR
602500100121
602600100121      * Codes
602700100121     C                   Eval      x   = 0
602800100121     C     1             do        20            x
602900100121     C     x             occur     W_CODES
603000100121     C                   Clear                   ACOD
603100100121     C                   enddo
603200100121      * Plans
603300100121     C                   Eval      x   = 0
603400100121     C     1             do        20            x
603500100121     C     x             occur     W_PGM
603600100121     C                   Clear                   APGM
603700100121     C     x             occur     W_PLANS
603800100121     C                   Clear                   APLN
603900100121     C     x             occur     W_CVTYP
604000100121     C                   Clear                   ACTY
604100100121     C     x             occur     W_CATYP
604200100121     C                   Clear                   ACAT
604300100121     C     x             occur     W_PCODS
604400100121     C                   Clear                   APCD
604500100121     C     x             occur     W_REEFF
604600100121     C                   Clear                   AEFF
604700100121     C     x             occur     W_RETRM
604800100121     C                   Clear                   ATRM
604900100121     C     x             occur     W_PCP
605000100121     C                   Clear                   APCP
605100100121     C     x             occur     W_DEMO
605200100121     C                   Clear                   ADEMO
605300100121     C     x             occur     D_REEFF
605400100121     C                   Clear                   DEFF
605500100121     C     x             occur     D_RETRM
605600100121     C                   Clear                   DTRM
605700100121     C     x             occur     W_OLD
605800100121     C                   Clear                   D4OLDFN
605900100121     C                   Clear                   D4OLDLS
606000100121     C                   Clear                   D4OLDMI
606100100121     C                   Clear                   D4OLDBI
606200100121     C                   enddo
606300100121      *
606400100121     C                   Eval      mbrchg = 'N'
606500100121     C                   Eval      mbrtyp = *blanks
606600100121     C                   Eval      x   = 0
606700100121      *
606800100121     C                   Eval      FM075   = *Blanks
606900120611     C                   Eval      DEMONLY = *Blanks
607000100121      *
607100100121     C                   Eval      TYP01   = *Blanks
607200100121     C                   Eval      TYP02   = *Blanks
607300100121     C                   Eval      TYP03   = *Blanks
607400100121     C                   Eval      TYP04   = *Blanks
607500100121      *
607600100121     C                   Eval      P_CATM  = *Blanks
607700100121     C                   Eval      P_CATR  = *Blanks
607800100121     C                   Eval      P_CATV  = *Blanks
607900100121     C                   Eval      P_CATD  = *Blanks
608000100121      *
608100100121     C                   Eval      T_PLNM  = *Blanks
608200100121     C                   Eval      T_PLNR  = *Blanks
608300100121     C                   Eval      T_PLNV  = *Blanks
608400100121     C                   Eval      T_PLND  = *Blanks
608500100121      *
608600100121     C                   Eval      TR051   = *Blanks
608700100121     C                   Eval      TR052   = *Blanks
608800100121     C                   Eval      TR053   = *Blanks
608900100121     C                   Eval      TR054   = *Blanks
609000100121      *
609100100121     C                   Eval      RMVDEP1 = *Blanks
609200100121     C                   Eval      RMVDEP2 = *Blanks
609300100121     C                   Eval      RMVDEP3 = *Blanks
609400100121     C                   Eval      RMVDEP4 = *Blanks
609500100121      *
609600100121     C                   Clear                   DEP#
609700100121     C                   Eval      axt = 0
609800100121     C                   Eval      pxt = 0
609900100121     C                   Eval      nxt = 0
610000100121     C                   Eval      Pss = 0
610100100121     C                   Eval      Pqq = 0
610200100121     C                   Eval      Pms = 0
610300100121     C                   Eval      Pre = 0
610400100121     C                   Eval      Pxs = 0
610500100121     C                   Eval      Pos = 0
610600100121     C                   Eval      Pod = 0
610700100121     C                   Eval      Mdc = 0
610800100121     C                   Eval      Ddc = 0
610900100121     C                   Eval      Mac = 0
611000100121     C                   Eval      Mma = 0
611100100121     C                   Eval      N   = 0
611200100121     C                   Eval      aaa = 0
611300100121     C                   Eval      bbb = 0
611400100121     C                   Eval      cdc = 0
611500100121     C                   Eval      count = 0
611600100121     C                   Eval      DEPN  = 0
611700100121      *
611800100121     C                   Eval      RMVDEP1 = *Blanks
611900100121     C                   Eval      RMVDEP2 = *Blanks
612000100121     C                   Eval      RMVDEP3 = *Blanks
612100100121     C                   Eval      RMVDEP4 = *Blanks
612200100121      *
612300100121     C                   Eval      KING    = *Blanks
612400100121     C                   Eval      PLNGRP  = *Blanks
612500100121     C                   Eval      SKIPWRT = 'N'
612600100121      *
612700100121     C                   Eval      TYP01   = *Blanks
612800100121     C                   Eval      TYP02   = *Blanks
612900100121     C                   Eval      TYP03   = *Blanks
613000100121     C                   Eval      TYP04   = *Blanks
613100100121      *
613200100121     C                   Eval      P_CATM  = *Blanks
613300100121     C                   Eval      P_CATR  = *Blanks
613400100121     C                   Eval      P_CATV  = *Blanks
613500100121     C                   Eval      P_CATD  = *Blanks
613600100121      *
613700100121     C                   Eval      U_CATM  = *Blanks
613800100121     C                   Eval      U_CATR  = *Blanks
613900100121     C                   Eval      U_CATV  = *Blanks
614000100121     C                   Eval      U_CATD  = *Blanks
614100100121      *
614200100121     C                   Eval      T_PLNM  = *Blanks
614300100121     C                   Eval      T_PLNR  = *Blanks
614400100121     C                   Eval      T_PLNV  = *Blanks
614500100121     C                   Eval      T_PLND  = *Blanks
614600100121      *
614700100121     C                   Eval      TR051   = *Blanks
614800100121     C                   Eval      TR052   = *Blanks
614900100121     C                   Eval      TR053   = *Blanks
615000100121     C                   Eval      TR054   = *Blanks
615100100121      *
615200100121     C                   Eval      RMVDEP1 = *Blanks
615300100121     C                   Eval      RMVDEP2 = *Blanks
615400100121     C                   Eval      RMVDEP3 = *Blanks
615500100121     C                   Eval      RMVDEP4 = *Blanks
615600100121
615700100121     C                   Eval      P_SSN = *Blanks
615800100121     C                   Eval      P_SEQ = *Blanks
615900100121     C                   Eval      P_ORG = *Blanks
616000100121     C                   Eval      P_PLN = *Blanks
616100100121     C                   Eval      P_CAT = *Blanks
616200100121     C                   Eval      P_FLG = *Blanks
616300100121     C                   Eval      P_GRP = *Blanks
616400100121     C                   Eval      R_FLG = *Blanks
616500100121     C                   Eval      P_EFF = *Blanks
616600100209     C                   Eval      U_FLG = *Blanks
616700100209     C                   Eval      Q_SSN = *Blanks
616800100209     C                   Eval      Q_FLG = *Blanks
616900100209     C                   Eval      Q_GRP = *Blanks
617000100121
617100100121     C                   Eval      W3ORGEF = *Zeros
617200100121     C                   Eval      REDATE  = *Zeros
617300100121     C                   Eval      TODAY   = *Zeros
617400100121     C                   Eval      CURYER  = *Zeros
617500100121     C                   Eval      CURMTH  = *Zeros
617600100121     C                   Eval      NXTMTH  = *Zeros
617700100121     C                   Eval      RENMTH  = *Zeros
617800100121     C                   Eval      RENMON  = *Zeros
617900100121     C                   Eval      RENDAY  = *Zeros
618000100121
618100100121     C                   Eval      MSPDATE = *blanks
618200100121     C                   Eval      MBRCHG  = *blanks
618300100121     C                   Eval      MBRTYP  = *blanks
618400100121
618500100121     C                   Eval      P_TERMDT = *zeros
618600100121     C                   Eval      T_TERMDT = *zeros
618700100121     C                   Eval      W_DRELCD = *blanks
618800100121     C                   Eval      W_COVT   = *blanks
618900100121     C                   Eval      W_CAT    = *blanks
619000100121     C                   Eval      W_NAME6  = *blanks
619100100121     C                   Eval      W_SEVT   = *blanks
619200100121     C                   Eval      W_SFAM   = *blanks
619300100121     C                   Eval      W_FILL   = *blanks
619400100121     C                   Eval      W_SSN#   = *zeros
619500100121     C                   Eval      W_SFX#   = *zeros
619600100121     C                   Eval      W_SPCD   = *blanks
619700100121     C                   Eval      W_DEPSSN = *zeros
619800100121     C                   Eval      W_SEQ    = *zeros
619900100121     C                   Eval      W_DEPTRM = *zeros
620000100121     C                   Eval      W_TRSEQ# = *zeros
620100100121
620200100121     C                   Eval      D3SCAT_W = *Blanks
620300100121     C                   Eval      D3SLVL_W = *Blanks
620400100121     C                   Eval      D3SCEF_W = *Blanks
620500100121     C                   Eval      D3SCTR_W = *Blanks
620600100121     C                   Eval      D3SEVT_W = *Blanks
620700100121     C                   Eval      D3SFAM_W = *Blanks
620800100121     C                   Eval      D3FILL_W = *Blanks
620900100121
621000141210     C                   ENDSR
621100141210      *___________________________________________________________________
621200141210      * check for ACA
621300141210      *___________________________________________________________________
621400141210     C     CHKACAPLN     BEGSR
621500141210
621600141210      * D3PRN is used in DW311SYNR as a temp flag noting ACA Plan
621700141210
621800141210     C     ACAKEY        KLIST
621900141210     C                   Kfld                    X_DWTRST
622000141210     C                   Kfld                    X_DWSUB#
622100141210     C                   Kfld                    X_DWPLAN
622200141210
622300141210     C     ACAKEY        chain     PLNAUXP
622400141210     C                   If        %found(PLNAUXP)
622500141210
622600141210     C                   If        %trim(PXACAR) = 'Y' or
622700141210     C                             %trim(PXACAR) = 'C'
622800141210     C                   eval      D3PRN = 'Y'
622900141210     C                   end
623000141210
623100141210     C                   else
623200141210     C                   eval      D3PRN = 'N'
623300141210     C                   end
623400141210
623500100121     C                   ENDSR
