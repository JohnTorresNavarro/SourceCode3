000100000424     hdatfmt(*iso)
0002000108100002  *---------------------------------------------------------------**
0003000108100003  * COB222     GROUP BENEFIT SERVICES SOFTWARE                     *
0004000108100005  *            WRITTEN BY - M.L.F.                                 *
0005000108100006  *            DATE - 09/98                                        *
0006000108100008  *  DESCRIPTION - THIS PROGRAM PRINTS DEPENDENT CANCELLATION      *
0007000108100009  *                LETTERS.                                        *
000800010810      *                                                                *
000900010810      *  DMA 12.08.98   Significant changes to all letters/forms       *
001000010810      *  DLW 12.98 CHANGE TO USE 8 BYTE DATES -Y2K COMPLIANT.          *
001100990927      *  DMA 9.27.99 - Change mail to addresses to different PO boxes  *
0012000108100017  * DLK 04/14/00 - CONVERT hard coded COBRA administrator name     *
001300010810      *                to use "COB" aacode name                        *
0014000108100017  * DLK 04/24/00 - CONVERT all letters to external and change      *
001500010810      *                wording.                                        *
001600010821      * DLK 06/09/00 fix name length                                   *
0017000108100017  * DLK 10/13/00 - change label to fit 7 lines                     *
0018000108210017  * KSJ 08/21/01 - ADDED COBRA CROSS-REF FILE (CBRPLNF1) TO GET    *
001900010821      *                COBRA PLAN ASSOCIATED WITH ACCT PLAN.           *
002000010904      *                MODIFIED TO PRINT PREMIUMS FOR SELF-FUNDED.     *
002100010904      *                MODIFIED FOR MENTAL HEALTH PLANS TO BE USED BY  *
002200010904      *                MAGELLAN ONLY.                                  *
002300020510      * SZZ 05/10/02 - Modify text of letter and use page segments.    *
002400020603      * JON 06/03/02 - Minor adjustments to coverage print logic.      *
002500030502      * SZZ  5/02/03 - Add Extended Group form for Blue Cross Coverage.*
002600030502      *                 This requires adding the CARMST file because   *
002700030502      *                 it has the CARBC code.  The form will only     *
002800030502      *                 print if the value is 'D'.                     *
0029000407260017  * DLK 07/26/04 - change PMH to PRX                               *
0030000408230017  * DLK 08/19/04 - change wording to match tr172                   *
0031000409220017  * DLK 09/21/04 - include rx with med                             *
0032000410280017  * DLK 10/28/04 - add cobra lite letters                          *
0033000503310017  * DLK 03/31/05 - remove acc # from letters                       *
003400050505      * SZZ  5/02/05 - Add Benegap premiums to medical premiums w/o    *
003500050502      *                 showing Benegap plan description.              *
0036000505040017  * DLK 05/04/05 - fix dep address 2                               *
003700050725      * DLK 07/25/05 - change remittance po box                        *
003800060829      * DLK 08/29/06 - list benegap seperately and add addendum letter *
0039000707110017  * DLK 07/11/07 - convert state letter to page seg and make       *
004000070711      *                changes to other letters.                       *
004100090402      * DLK 04/01/09 - add subsidy addendum (4 pages)                  *
004200100713      * DLK 07/13/10 - change subsidy addendum and history note to     *
004300100713      *                only show if term date is <= 6/1/10             *
004400110524      * DLK 05/24/11 - remove period from aaname                       *
0045001111080011  * DLK 11/08/11 - mask ssn
0046001111280011  * DLK 11/28/11 - change HRA special logic. Do not print adden for
0047001111280011  *                state acct and print a different addedn for fed. Also
0048001111280011  *                do not print rates for fed & state. also do not
0049001111280011  *                show plan for state accts.
0050001204040011  * DLK 04/04/12 - remove fields from this program that are now
005100120404      *                created in cob221 and included in cob220wk because
005200120404      *                of the need to inclunde them in the clethst file
005300120405      *                that is written in cob221. also stop printing   *
005400120405      *                labels                                          *
0055001210150011  * DLK 10/15/12 - add fields to cob220wk for mplan2 - hra bundling
0056001303080011  * DLK 03/08/13 - wording changes to dependent letters but the rate
0057001303080011  *                sheet added to the member letters is not included
0058001303080011  *                in the dependent letters.
0059001310100011  * DLK 10/07/13 - more wording changes for HCR / Obamacare
0060001711150017  * DLK 11/15/17 - add inserter marks
006100171115      *              - remove subsidy addendum, it ended 6/1/2010. Also
006200171115      *                add gbs logo and contact info at top of first page
006300171115      *                to simulate letterhead paper. This will eliminate
006400171115      *                printing with 2 drawers, eliminate preprinted
006500171115      *                letterhead and allow emailing the letters back
006600171115      *                to the user as a pdf.
0067001809240011  * DLK 09/24/18 - add fields to cob220wk for eapplan - EAP plan
0068002007280011  * DLK 07/28/20 - remove period after state in mailing address due to
0069002007280017  *                mail being returned. Request from Shelly / Lisa.     h
0070001310100011  *
0071001712040017  *   ** Note - The letterhead overlay (CLETHDC) is used in             h
0072001712040017  *             multiple programs.                                      h
0073001712040017  *                                                                     h
007400120405      * ************************************************************** *
007500120405      * * Make sure any changes to the variables in the letter are     *
007600120405      * * made in COB221 and passed to this program in cob220wk        *
007700120405      * * because the letter history file (CLETHST) is written in      *
007800120405      * * COB221.                                                      *
007900120405      * *                                                              *
008000120405      * ************************************************************** *
008100120405      *                                                                *
0082000108100013  *---------------------------------------------------------------**
008300010815     FCOB220WK  IP   E             DISK
008400120404     **FACCMST    IF   E           K DISK
008500120405JGE01**FPLNMST    IF   E           K DISK
008600000424     Fcob222p2  O    e             PRINTER                                      RPF140
0087001204050021 F*REPORT    O    F  198        PRINTER
008800120405     F*                                     FORMLEN(8)
008900120405     F*                                     FORMOFL(8)
009000010810
0091000004240037 D dat2wkdt        S               d   datfmt(*iso)                         last day of month
009200000424     D YR              S              9    DIM(12) CTDATA PERRCD(1)             MONTHS
009300990927     D PO              S             42    DIM(2) CTDATA PERRCD(1)
009400010813     D CPLAN           S              4
009500010813     D PREM            S              7  2
009600040921     D PDSC            S             50
009700130501     D PDSC1           S                   like(pdsc)
009800130501     D PDSC2           S                   like(pdsc)
009900130501     D PDSC3           S                   like(pdsc)
010000130501     D PDSC4           S                   like(pdsc)
010100130501     D PDSC5           S                   like(pdsc)
010200130501     D PREM1           S                   like(prem)
010300130501     D PREM2           S                   like(prem)
010400130501     D PREM3           S                   like(prem)
010500130501     D PREM4           S                   like(prem)
010600130501     D PREM5           S                   like(prem)
010700041008     D                 DS                                                       RP020
010800041008     D  memtsa                 1     10  0                                      RPF140
010900041008     D  trust                  1      3  0                                      RPF140
011000041008     D  sub                    4      6  0                                      RPF140
011100041008     D  acct                   7     10  0                                      RPF140
011200010904
0113009809020104 D                UDS                                                       RP020
011400010223     D  USERID                25     32
011500000424JGE01D  LD8YMD               248    255  0
011600000424JGE01D  LD8Y                 248    251  0
011700020510     D  WDATE8         S              8S 0 Inz(0)
011800000424
011900020604
012000980911     C                   MOVE      *BLANKS       ACSZ
012100980911     C                   MOVE      *BLANKS       FLD3
012200980911     C                   Z-ADD     0             AZ1               5 0
012300980911     C                   MOVEL     AZIP          AZ1
012400120405     C                   movel     aname         acnam1
012500120405     C**                 movel     aname         acnaml           35
012600120405     C**                 movel     aname2        acnaml2          35
012700980911     C                   EXSR      CATCSZ
012800050504
012900050504     c                   movel     dadd1         addr1
013000050504     c                   movel     dadd2         addr2            30
013100130425
013200130425     c                   clear                   dssnout
013300130425     c                   if        depssn <> 0
013400130425     c                   move      depssn        depssn4           4
013500130425     c                   movel     'XXX-XX-'     dssnout
013600130425     c                   move      depssn4       dssnout
013700130425     c                   end
013800010810
0139000004240151 C                   EXSR      #ADDAY
014000041028     c                   exsr      #addr
0141000410080151 C                   EXSR      #acnamnum
014200041028     c                   exsr      #acccsz
0143000108100156
014400060829      * medical
014500120405     C                   If        mplandsc <> *blanks
014600010828     C                   EVAL      PREM = MPRE
014700120405     C                   EVAL      PDSC = mplandsc
014800041028     C                   EXSR      LTR_PLN
014900010828     C                   ENDIF
015000010828
015100060829      * dental
015200120405     C                   IF        dplandsc <> *blanks
015300010828     C                   EVAL      PREM = DPRE
015400120405     C                   EVAL      PDSC = dplandsc
015500010828     C                   EXSR      LTR_PLN
015600010828     C                   ENDIF
015700010828
015800060829      * vision
015900120405     C                   IF        vplandsc <> *blanks
016000010828     C                   EVAL      PREM = VPRE
016100120405     C                   EVAL      PDSC = vplandsc
016200010828     C                   EXSR      LTR_PLN
016300010828     C                   ENDIF
016400060829
016500120405      * Benegap
016600120405     C                   IF        bgplandsc <> *blanks
016700120405     C                   EVAL      PREM = bgpre
016800120405     C                   EVAL      PDSC = bgplandsc
016900060829     C                   EXSR      LTR_PLN
017000111128     c                   end
017100180924
017200180924      * EAP
017300180924     C                   IF        eapplandsc <> *blanks
017400180924     C                   EVAL      PREM = EAPPRE
017500180924     C                   EVAL      PDSC = eapplandsc
017600180924     C                   EXSR      LTR_PLN
017700180924     C                   ENDIF
017800180924
017900180924      *
018000180924      * Maximum 5 plans on the election form at once. As of 9/24/18
018100180924      * there are 5 - med, den, vis, benegap and eap. Any more will require
018200180924      * changes to the election form and code in this program.
018300180924      *
018400010814
018500990405     C                   MOVE      DCAND         CYMD#             8
018600990405     C                   EXSR      #CYMD8
018700990405     C                   MOVE      MDCY#         DCAMDY            8 0
018800010814
018900010814      * convert fields to match output dds
019000010814
019100000424     c                   movel     name          n1
019200000424     c                   movel     name          n3
019300000424     c                   exsr      #name2
019400111209     c                   move      memssn        ssno4             4
019500000424     C                   move      dcamdy        termdy
019600130313     C****               move      termdy        termdy2
019700040819     C                   move      termdy        termdy3
019800020510      *
019900020510      * Spell out date routine
020000040819     C*                  Z-add     termdy        Wdate8
020100040819     C*                  Exsr      DateFmt
020200040819     C*                  Eval      TMDATE  =     %trim(Output_Date)
020300040819     C*    TMDATE        CAT       ',':0         TMDATE
020400040819     C*                  Eval      TMDATE2 =     %trim(Output_Date)
020500040819     C*                  Eval      TMDATE3 =     %trim(Output_Date)
020600040819     C*    TMDATE3       CAT       '.':0         TMDATE3
020700020510      *******
020800010814
020900041028      * full service
021000120405     c                   if        cserv   = 'F'
021100120405     C                   IF        flag   = 'F'
0212009809020160 C                   EXSR      LET1
0213009809020162 C                   END
0214000108140165
021500120405     C                   IF        flag   = 'S'
0216009809020167 C                   EXSR      LET2
0217000108140169 C                   END
021800041028     C                   END
021900010814
022000041028      * letter only service
022100120405     c                   if        cserv   = 'L'
022200120405     C                   IF        flag   = 'F'
022300041028     C                   EXSR      LET3
022400041028     C                   END
022500120405     C                   IF        flag   = 'S'
022600041028     C                   EXSR      LET4
022700041028     C                   END
022800041028     C                   END
022900041028
023000120404      * 4/4/12 - stop printing labels
023100120404     C***                EXSR      #LABEL
023200000424     c     #end          tag
023300000424
023400980911      **--------------------------------------------**
023500980911     CSR   CATCSZ        BEGSR
023600000424     C                   MOVEL     ACITY         FLD3             20
023700000424     C                   CAT       ',':0         FLD3
023800000424     C                   CAT       ASTATE:1      FLD3
023900980911     C                   MOVEL     FLD3          ACSZ             20
024000980911     C                   ENDSR
024100020510     C/EJECT
024200041028     C*    DateFmt       BEGSR
024300041028     C*                  Movel     Wdate8        Input_Date
024400041028     C*                  Eval      Input_Format  = 'MMDDYYYY'
024500041028     C*                  Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
024600041028     C*                  Call      'FMTDATE'
024700041028     C*                  Parm                    Input_Date       32
024800041028     C*                  Parm                    Input_Format     32
024900041028     C*                  Parm                    Output_Format    32
025000041028     C*                  Parm                    Output_Date      32
025100041028     C*                  Parm                    Output_Error     10
025200020510
025300041028     C*                  ENDSR
0254000108140647  ****************************************************************
0255000108140648  * ROUTINE FOR PRINTING LABELS - 1 PER ACCOUNT                  *
0256000108140649  ****************************************************************
0257001204050650 C*    #LABEL        BEGSR
0258000108140038
0259001204050039 C*                  IF        FIRSTL <> 'N'
0260001204050040 C*                  MOVE      'N'           FIRSTL            1                           RPF14
0261001204050041 C*                  EXCEPT    HEADER                                                      RPF14
0262001204050042 C*                  END                                                                   RPF14
0263000108140050
026400120405     C*                  EXCEPT    LABtop                                                      RPF14
026500120405     c*                  if        acnaml2 <> *blanks
026600120405     c*                  except    lab2
026700120405     c*                  end
026800120405     C*                  EXCEPT    LAB3                                                        RPF14
026900120405     c*                  if        aaddr2  <> *blanks
027000120405     c*                  except    lab4
027100120405     c*                  end
027200120405     C*                  EXCEPT    LAB5                                                        RPF14
027300010814
027400120405     C*                  ENDSR
027500010814      ****************************************************************
027600120405      * 4/5/12 - 45 or 60 days in the future for return date is now
027700120405      * from work file. this routine just moves it to other work fields
027800120405      * for printing on the letters
027900010814      ****************************************************************
0280009809020294 C     #ADDAY        BEGSR
028100010814
028200120405     C                   MOVE      returndt      newymd            8 0
028300000424     C                   MOVEL     newymd        newy              4 0
028400000424     C                   MOVE      newymd        newmd             4 0
028500000424     C                   MOVEL     newmd         newmdy            8 0
028600000424     C                   MOVE      newy          newmdy
028700040819     C                   Z-add     newmdy        newmdy2           8 0
028800040819     C                   Z-add     newmdy        newmdy3           8 0
028900040819
0290009809020340 C                   ENDSR
029100980902     C/EJECT
029200010814      **************************************************************
029300070711      *  FEDERAL LETTERS / ELECTION FORMS - full service           *
029400010814      **************************************************************
0295009809020176 C     LET1          BEGSR
029600130501
029700130501      * prepare plans to print on election form
029800130501     c                   exsr      #electpln
0299001305010177
0300000108140178  * FEDERAL LETTER
030100171115
030200171115      * letter head overlay
030300171115     c                   write     lethdol
030400171115
030500171115      * inserter mark for page 1
030600171115     c                   write     insp1
0307001711150179
030800171115     c                   write     fed1var
030900130308     C                   Write     fed1
031000171115
031100171115      * inserter mark for all pages other than page 1
031200171115     c                   write     insp2
031300130308     C                   Write     fed2
031400171115
031500171115      * inserter mark for all pages other than page 1
031600171115     c                   write     insp2
031700130308     C                   Write     fed3
031800171115
031900171115      * inserter mark for all pages other than page 1
032000171115     c                   write     insp2
032100130308     C                   Write     fed4
032200171115
032300171115      * inserter mark for all pages other than page 1
032400171115     c                   write     insp2
032500130308     C                   Write     fed5
032600171115
032700171115      * inserter mark for all pages other than page 1
032800171115     c                   write     insp2
032900171115     C                   Write     fed5bvar
033000131010     C                   Write     fed5b
033100040819
033200040819      * election form - page 6
033300171115      * inserter mark for all pages other than page 1
033400171115     c                   write     insp2
033500130308     C                   Write     fed6var
033600130308     C                   Write     fed6
033700041028
033800120405      * check for and print addendums needed
033900120405     c                   exsr      #chkadden
034000120405
034100120405      * clear plans on election form
034200120405     c                   exsr      #clearplans
034300041028     c                   exsr      #clearorigpl
034400010828
034500980902     C                   ENDSR
0346000108140234  ********************************************************************
0347000707110235  * STATE LETTERS / ELECTION FORMS - Full service                    *
0348000108140236  ********************************************************************
0349009809020237 C     LET2          BEGSR
035000070711
035100070711      * prepare plans to print on election form
035200070711     c                   exsr      #electpln
035300070711
0354000707110239  * STATE LETTERS
035500171115      * letter head overlay
035600171115     c                   write     lethdol
035700171115      * inserter mark for page 1
035800171115     c                   write     insp1
035900070711     c                   write     sta1var
036000070711     C                   Write     sta1
036100171115
036200171115      * inserter mark for all pages other than page 1
036300171115     c                   write     insp2
036400070711     C                   Write     sta2
036500171115
036600171115      * inserter mark for all pages other than page 1
036700171115     c                   write     insp2
036800070711     C                   Write     sta3
036900131010
037000171115      * inserter mark for all pages other than page 1
037100171115     c                   write     insp2
037200131010     c                   write     sta4var
037300131010     C                   Write     sta4
037400131010
037500070711      * election form - page 5
037600171115      * inserter mark for all pages other than page 1
037700171115     c                   write     insp2
037800070711     c                   write     sta5var
037900070711     C                   Write     sta5
038000070711
038100120405      * check for and print addendums needed
038200120405     c                   exsr      #chkadden
038300070711
038400070711      * clear plans on election form
038500070711     c                   exsr      #clearplans
038600070711     c                   exsr      #clearorigpl
038700070711
038800980902     C                   ENDSR
038900041028     C/EJECT
039000041028
039100041028      ********************************************************************
039200041028      *  FEDERAL LETTERS / ELECTION FORMS - Letter only service          *
039300041028      ********************************************************************
039400041028
039500041028     C     LET3          BEGSR
039600041028
039700041028      * prepare plans to print on election form
039800041028
039900041028     c                   exsr      #electpln
040000041028
040100041028      * print Federal Letter for Letter Only service
040200041028
040300171115      * letter head overlay
040400171115     c                   write     lethdol
040500171115
040600171115      * inserter mark for page 1
040700171115     c                   write     insp1
040800041028     c                   write     fedlo1var
040900041028     C                   Write     fedlo1
041000171115
041100171115      * inserter mark for all pages other than page 1
041200171115     c                   write     insp2
041300041028     C                   Write     fedlo2
041400171115
041500171115      * inserter mark for all pages other than page 1
041600171115     c                   write     insp2
041700041028     C                   Write     fedlo3
041800171115
041900171115      * inserter mark for all pages other than page 1
042000171115     c                   write     insp2
042100041028     C                   Write     fedlo4
042200171115
042300171115      * inserter mark for all pages other than page 1
042400171115     c                   write     insp2
042500041028     C                   Write     fedlo5
042600171115
042700171115      * inserter mark for all pages other than page 1
042800171115     c                   write     insp2
042900131011     c                   write     fedlo5bvar
043000131011     C                   Write     fedlo5b
043100171115
043200041028      * election form - page 6
043300171115      * inserter mark for all pages other than page 1
043400171115     c                   write     insp2
043500041028     c                   write     fedlo6var
043600041028     C                   Write     fedlo6
043700060829
043800120405      * check for and print addendums needed
043900120405     c                   exsr      #chkadden
044000041028
044100041028      * clear plans on election form
044200041028     c                   exsr      #clearplans
044300041028     c                   exsr      #clearorigpl
044400041028
044500041028     C                   ENDSR
044600041028
044700041028      ********************************************************
044800041028      * STATE LETTERS / ELECTION FORMS - Letter only service *
044900041028      ********************************************************
045000041028
045100041028     C     LET4          BEGSR
045200041028
045300041028      * prepare plans to print on election form
045400041028
045500041028     c                   exsr      #electpln
045600041028
045700041028      * state letter
045800171115
045900171115      * letter head overlay
046000171115     c                   write     lethdol
046100171115
046200171115      * inserter mark for page 1
046300171115     c                   write     insp1
046400041028     c                   write     stalo1var
046500041028     C                   Write     stalo1
046600171115
046700171115      * inserter mark for all pages other than page 1
046800171115     c                   write     insp2
046900041028     C                   Write     stalo2
047000171115
047100171115      * inserter mark for all pages other than page 1
047200171115     c                   write     insp2
047300041028     C                   Write     stalo3
047400171115
047500171115      * inserter mark for all pages other than page 1
047600171115     c                   write     insp2
047700131010     c                   write     stalo3bvar
047800131010     C                   Write     stalo3b
047900171115
048000041028      * election form - page 4
048100171115      * inserter mark for all pages other than page 1
048200171115     c                   write     insp2
048300041028     c                   write     stalo4var
048400041028     C                   Write     stalo4
048500060829
048600120405      * check for and print addendums needed
048700120405     c                   exsr      #chkadden
048800041028
048900041028      * clear plans on election form
049000041028     c                   exsr      #clearplans
049100041028     c                   exsr      #clearorigpl
049200041028
049300041028     C                   ENDSR
049400041028      ********************************************************
049500041028      * plans to print on the election form
049600041028      ********************************************************
049700041028
049800041028     C     #electpln     BEGSR
049900041028
050000041028      * clear prevoius plan text
050100041028
050200041028     c                   exsr      #clearplans
050300041028
050400041028     c                   if        pdsc1 <> *blanks
050500041028     c                   eval      pdash1 = '____'
050600041028     c                   eval      pdes1  = pdsc1
050700041028     c                   evalr     prat1  = %editc(prem1 : '2' : *CURSYM)
050800041028     c                   end
050900041028
051000041028     c                   if        pdsc2 <> *blanks
051100041028     c                   eval      pdash2 = '____'
051200041028     c                   eval      pdes2  = pdsc2
051300041028     c                   evalr     prat2  = %editc(prem2 : '2' : *CURSYM)
051400041028     c                   end
051500041028
051600041028     c                   if        pdsc3 <> *blanks
051700041028     c                   eval      pdash3 = '____'
051800041028     c                   eval      pdes3  = pdsc3
051900041028     c                   evalr     prat3  = %editc(prem3 : '2' : *CURSYM)
052000041028     c                   end
052100041028
052200041028     c                   if        pdsc4 <> *blanks
052300041028     c                   eval      pdash4 = '____'
052400041028     c                   eval      pdes4  = pdsc4
052500041028     c                   evalr     prat4  = %editc(prem4 : '2' : *CURSYM)
052600041028     c                   end
052700060829
052800060829     c                   if        pdsc5 <> *blanks
052900060829     c                   eval      pdash5 = '____'
053000060829     c                   eval      pdes5  = pdsc5
053100060829     c                   evalr     prat5  = %editc(prem5 : '2' : *CURSYM)
053200060829     c                   end
053300041028
053400041028
053500041028     C                   ENDSR
053600041028      ****************************************************************
053700041028      * clear plan fields on election form
053800041028      ****************************************************************
053900041028     C     #clearplans   BEGSR
054000041028
054100041028     c                   clear                   pdash1
054200041028     c                   clear                   pdash2
054300041028     c                   clear                   pdash3
054400041028     c                   clear                   pdash4
054500060829     c                   clear                   pdash5
054600041028     c                   clear                   pdes1
054700041028     c                   clear                   pdes2
054800041028     c                   clear                   pdes3
054900041028     c                   clear                   pdes4
055000060829     c                   clear                   pdes5
055100041028     c                   clear                   prat1
055200041028     c                   clear                   prat2
055300041028     c                   clear                   prat3
055400041028     c                   clear                   prat4
055500060829     c                   clear                   prat5
055600041028
055700041028     C                   ENDSR
055800041028      ****************************************************************
055900041028      * clear orig plan fields
056000041028      ****************************************************************
056100041028     C     #clearorigpl  BEGSR
056200041028
056300041028     C                   CLEAR                   PDSC1
056400041028     C                   CLEAR                   PREM1
056500041028     C                   CLEAR                   PDSC2
056600041028     C                   CLEAR                   PREM2
056700041028     C                   CLEAR                   PDSC3
056800041028     C                   CLEAR                   PREM3
056900041028     C                   CLEAR                   PDSC4
057000041028     C                   CLEAR                   PREM4
057100060829     C                   CLEAR                   PDSC5
057200060829     C                   CLEAR                   PREM5
057300041028
057400041028     C                   ENDSR
057500041028     C/EJECT
057600010814      *****************************************************************
057700010814      * REARRANGE DATE FROM CCYYMMDD TO MMDDCCYY
057800010814      *****************************************************************
057900981218     C     #CYMD8        BEGSR
058000981218     C                   MOVE      CYMD#         MMDD#             4
058100981218     C                   MOVEL     CYMD#         CCYY#             4
058200981218     C                   MOVEL     MMDD#         MDCY#             8
058300981218     C                   MOVE      CCYY#         MDCY#
058400981218     C                   ENDSR
058500010814
058600010814      **********************************************************
058700010814      *    AL = CITY, ST  ZIP+4                                *
058800010814      *                    COMPRESS CITY/STATE/ZIP             *
058900010814      **********************************************************
059000010814
059100000424     C     #ADDR         BEGSR
059200010814
059300000424     C                   MOVE      *BLANKS       AL               31
059400000424     C                   MOVEL     dcsz          AL
059500200728     c** removed 7/28/20 cat       '.':0         al
059600000424     C                   MOVEL     dzip5         ZIP5              5
059700000424     C                   MOVE      dzip4         ZIP4              4
059800000424     c                   cat       zip5:1        al
059900000424     C                   IF        zip4 <> '0000'
060000000424     c                   cat       '-':0         al
060100000424     c                   cat       zip4:0        al
060200000424     C                   END
060300000517
060400010814      * set address for output
060500000517
060600000517     c                   eval      a2 = *blanks
060700000517     c                   eval      a3 = *blanks
060800000517     c                   if        addr2 <> *blanks
060900000517     c                   movel     addr2         a2
061000000517     c                   movel     al            a3
061100000517     c                   else
061200000517     c                   movel     al            a2
061300000517     c                   end
061400000517
061500000424     C                   ENDSR
061600010814
061700010814      ********************************************************
061800010814      *  ROUTINE FOR NAME LINE 2 - DEAR "FIRST MI. LAST :"   *
061900010814      ********************************************************
062000000424     C     #NAME2        BEGSR
062100010814
062200000609     C                   MOVE      *BLANKS       N2               36
062300000424     C                   MOVEl     name          N2
062400000424     C                   CAT       ':':1         N2
062500000424     C                   ENDSR
062600010814
062700041008      ********************************************************
062800041008      *  ROUTINE FOR acct name / # x-----------x 999-999-9999*
062900041008      ********************************************************
063000041008     C     #acnamnum     BEGSR
063100041008
063200041008     C                   clear                   acnamnum         56
063300120404     C                   MOVEl     aname         acnamnum
063400050331      * 3/31/05 remove acc #
063500050331     C*                  clear                   acnumtxt         12
063600050331     c*                  eval      acnumtxt = %editw(memtsa: '   -   -    ')
063700050331     C*                  CAT       acnumtxt:1    acnamnum
063800041008     C                   ENDSR
063900000424     C/EJECT
064000041028      ********************************************************
064100041028      *  account city, state zip line - AL2
064200041028      ********************************************************
064300041028     C     #acccsz       BEGSR
064400041028     C                   MOVE      *BLANKS       AL2              30
064500041028     C                   MOVEl     ACITY         AL2
064600041028
064700041028     c                   cat       ',':0         al2
064800041028     c                   cat       astate:1      al2
064900200728     c***remove 7/28/20  cat       '.':0         al2
065000041028
065100041028     C                   MOVEL     AZIP          ZIP5
065200041028     C                   MOVE      AZIP          ZIP4
065300041028     c                   cat       zip5:1        al2
065400041028     C                   IF        ZIP4 <> '0000'
065500041028     c                   cat       '-':0         al2
065600041028     c                   cat       zip4:0        al2
065700041028     C                   END
065800041028
065900041028     c                   movel     aarea         aphoneout
066000041028     c                   move      aphone        aphoneout
066100041028
066200041028      * 2nd line acct addr on page 5 & 6 of lite letters
066300041028     c                   clear                   aline1
066400041028     c                   clear                   aline2
066500041028     c                   if        aaddr2 <> *blanks
066600041028     c                   movel     aaddr2        aline1
066700041028     c                   movel     al2           aline2
066800041028     c                   else
066900041028     c                   movel     al2           aline1
067000041028     c                   end
067100041028
067200041028     C                   ENDSR
067300010828      ********************************************************
067400010828      *  WRITE PLANS TO LETTER - FULLY INSURED               *
067500010828      ********************************************************
067600010828     C     LTR_PLN       BEGSR
067700010828
067800010828     C                   SELECT
067900010828
068000010828     C                   WHEN      PDSC1 = *BLANKS
068100010828     C                   EVAL      PDSC1 = PDSC
068200010828     C                   EVAL      PREM1 = PREM
068300010828
068400010828     C                   WHEN      PDSC2 = *BLANKS
068500010828     C                   EVAL      PDSC2 = PDSC
068600010828     C                   EVAL      PREM2 = PREM
068700010828
068800010828     C                   WHEN      PDSC3 = *BLANKS
068900010828     C                   EVAL      PDSC3 = PDSC
069000010904     C                   EVAL      PREM3 = PREM
069100010828
069200010828     C                   WHEN      PDSC4 = *BLANKS
069300010828     C                   EVAL      PDSC4 = PDSC
069400010904     C                   EVAL      PREM4 = PREM
069500010828
069600060829     C                   WHEN      PDSC5 = *BLANKS
069700060829     C                   EVAL      PDSC5 = PDSC
069800060829     C                   EVAL      PREM5 = PREM
069900060829
070000010828     C                   ENDSL
070100010828
070200010828     C                   ENDSR
070300090402
070400120405      ********************************************************
070500120405      * check for addendums needed
070600120405      ********************************************************
070700120405     C     #chkadden     BEGSR
070800120405      * print Benegap addendum
070900120405     c                   if        wadden1 = 'BENEGAP   ' or
071000120405     c                             wadden2 = 'BENEGAP   ' or
071100120405     c                             wadden3 = 'BENEGAP   '
071200171115      * inserter mark for all pages other than page 1
071300171115     c                   write     insp2
071400120405     c                   write     bgaddend
071500120405     c                   end
071600120405
071700120405     C                   endsr
071800010828
071900010814      *****************************************************************
072000981217     C     *INZSR        BEGSR
072100000424
072200010828
072300010814      * GET FIRST DATE LINE - LETTER DATE
072400010814
072500000424     C                   MOVE      *BLANKS       DL               19
072600000424JGE01C                   move      *month        UM                2 0
072700000424JGE01C                   move      *day          Ud                2
072800000424JGE01C                   move      *year         Uy                4
072900000424     C                   MOVE      YR(UM)        DL1               9
073000000424     C                   MOVEl     DL1           DL
073100000424     c                   cat       ud:1          dl
073200000424     c                   cat       ',':0         dl
073300000424     c                   cat       uy:1          dl
073400010821
073500990927     C                   MOVE      PO(1)         POST             42
073600010814
073700010814
073800981217     C                   ENDSR
073900010814      *****************************************************************
074000120405     O*EPORT    E            HEADER         1 01
0741001204050105 O*                                          26 '*'                         RPF140
0742001204050106 O*                                          25 '************************'  RPF140
0743001204050107 O*                                          29 '****'                      RPF140
0744001204050108 O*         E            HEADER         1                                   RPF140
0745001204050109 O*                                           3 '**'                        RPF140
0746001204050110 O*                                          27 'LABEL-*DEP COBRA LETTERS'  RPF140
0747001204050111 O*                                          29 '**'                        RPF140
0748001204050112 O*         E            HEADER         1                                   RPF140
0749001204050113 O*                                           2 '*'                         RPF140
0750001204050114 O*                      USERID              15                             RPF140
0751001204050115 O*                                          26 'COB221'                    RPF140
0752001204050116 O*                                          29 '*'                         RPF140
0753001204050117 O*         E            HEADER         1                                   RPF140
0754001204050118 O*                                          25 '************************'  RPF140
0755001204050119 O*                                          29 '****'                      RPF140
0756001204050120 O*         E            LABEL          1 01                                RPF140
0757001204050121 O*                      TRUST                6                             RPF140
075800120405     O*                                           7 '-'
075900120405     O*                      SUB                 10
076000120405     O*                                          11 '-'
076100120405     O*         E            LABtop         1 01                                RPF140
0762001204050121 O*                      TRUST                6                             RPF140
076300120405     O*                                           7 '-'
076400120405     O*                      SUB                 10
076500120405     O*                                          11 '-'
076600120405     O*                      ACCT                15
076700120405     O*         E            LABtop         1                                   RPF140
076800120405     O*                      CONTAC              30                             RPF140
076900120405     O*         E            LABtop         1                                   RPF140
077000120405     O*                      ACNAML              35                             RPF140
077100120405     O*         E            LAB2           1                                   RPF140
077200120405     O*                      ACNAML2             35                             RPF140
077300120405     O*         E            LAB3           1                                   RPF140
077400120405     O*                      AADDR1              30                             RPF140
077500120405     O*         E            LAB4           1                                   RPF140
077600120405     O*                      AADDR2              30                             RPF140
077700120405     O*         E            LAB5           1                                   RPF140
0778001204050127 O*                      ACSZ                20                             RPF140
077900120405     O*                      AZ1                 28
078000000424**
078100000424January
078200000424February
078300000424March
078400000424April
078500000424May
078600000424June
078700000424July
078800000424August
078900000424September
079000000424October
079100000424November
079200000424December
079300990927**
079400050725P.O. Box 64802, Baltimore, MD 21264-4802
079500990927P.O. Box 17309, Baltimore, MD 21297-1288.
