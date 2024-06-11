000100210422     FLINRPTP   IPE  E           K DISK
000200210422     FLINCSVP   O  A F 9000        DISK
000300050823   X***X
000400210422     D @OUTPUT         S           9000A   INZ
000500161221     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000704030250 D                 DS
0009001612300251 D  i5enm1                 1     40
0010001612300251 D   name1                 1     34
0011001612300025  *
0012001612300250 D                 DS
0013001612300251 D  i5enm2                 1     40
0014001612300251 D   name2                 1     34
0015001612300025  *
0016001612300250 D                 DS
0017001612300251 D  iftrst                 1      3  0
0018001612300251 D   cstrst                1      3
0019001507280025  *
0020001507280250 D                 DS
0021001507280251 D  ifsub#                 1      3  0
0022001507280251 D   cssub#                1      3
0023001507280025  *
0024001507280250 D                 DS
0025001507280251 D  ifacct                 1      4  0
0026001507280251 D   csacct                1      4
0027001507280025  *
0028001507280250 D                 DS
0029001507280251 D  ifmssn                 1      9  0
0030001507280251 D   csmssn                1      9
0031001507280025  *
0032001507280250 D                 DS
0033001507280251 D  ifiss#                 1      6  0
0034001507280251 D   csiss#                1      6
0035001507020025  *
0036000704030025  *
0037000704030250 D                 DS
0038001507020251 D  txhveff                1      8  0
0039001507020251 D   axhveff               1      8
0040001507020250 D                 DS
0041001507280037 D wkdate          S               D   datfmt(*iso)
004200150728     D usadt           S               D   DATFMT(*USA/)
004300161116     D bl              S              1    INZ(' ')
004400200102     D acstat          S              2    INZ('  ')
004500081114   X* *
004600150728      *
004700150728     C                   CLEAR                   @OUTPUT
004800210512     C*******            EVAL      @OUTPUT = '"' + %TRIM(lirssn) + '"' + ',,,' +
004900210512     C                   EVAL      @OUTPUT = ',,,' +
005000210422     C                             '"' + %TRIM(lirtmdt) + '"' + ',' +
005100210422     C                             '"' + %TRIM(lirfnam) + '"' + ',' +
005200210422     C                             '"' + %TRIM(lirlnam) + '"' + ',' +
005300210422     C                             '"' + %TRIM(lirmi) + '"' + ',' +
005400210422     C                             '"' + %TRIM(lirssn) + '"' + ',' +
005500210422     C                             '"' + %TRIM(lirsex) + '"' + ',' +
005600210422     C                             '"' + %TRIM(lirdob) + '"' + ',' +
005700210422     C                             '"' + %TRIM(lirefdt) + '"' + ',' +
005800210623     C                             ',40,,,,' +
005900210422     C                             '"' + %TRIM(liradd1) + '"' + ',' +
006000210422     C                             '"' + %TRIM(liradd2) + '"' + ',' +
006100210422     C                             '"' + %TRIM(lircity) + '"' + ',' +
006200210422     C                             '"' + %TRIM(lirst) + '"' + ',' +
006300210422     C                             %TRIM(lirzip) + ',,,,,,' +
006400210422     C                             %TRIM(lirdoh) + ',,,,,,,,,,,,,,,,,,,,,' +
006500210422     C                             ',,,,,' +
006600210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
006700210422     C                             ',,,,,' +
006800210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
006900210426     C                             ',,,,,,,,' +
007000210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
007100210422     C                             ',,,,,' +
007200210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
007300210426     C                             ',,,,,,,,,,,,,,,,,,,,' +
007400210422     C                             %TRIM('00001D033741-00000') + ',' +
007500210512     C                             %TRIM('1660598') + ',,' +
007600210512     C                             %TRIM(LIREFDT) + ',' +
007700210512     C                             %TRIM('1') + ',' +
007800210512     C                             %TRIM('1') + ',' +
007900210426     C                             %TRIM(LIRTIER) + ',' +
008000210422     C                             %TRIM('N') + ',' +
008100210422     C                             %TRIM(LIRTMDT) + ',' +
008200210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
008300210422     C                             ',,,' +
008400210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
008500210422     C                             ',,,,' +
008600210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,,' +
008700210426     C                             ',,,,,,,,,' +
008800210422     C                             %TRIM(' ') + ',,,,,,,,,,,,,,,,,,,,' +
008900210422     C                             %TRIM(LIRFNAMD) + ',' +
009000210422     C                             %TRIM(LIRLNAMD) + ',' +
009100210422     C                             %TRIM(LIRMID) + ',' +
009200210422     C                             %TRIM(LIRSEXD) + ',' +
009300210422     C                             %TRIM(LIRDOBD) + ',' +
009400210514     C                             %TRIM(LIRRELD) + ',' +
009500210514     C                             %TRIM(LIRSTD) + ',,' +
009600210512     C                             %TRIM(LIRCOVD) + ',,' +
009700210422     C                             %TRIM(LIRFNAM2) + ',' +
009800210422     C                             %TRIM(LIRLNAM2) + ',' +
009900210422     C                             %TRIM(LIRMI2) + ',' +
010000210422     C                             %TRIM(LIRSEX2) + ',' +
010100210422     C                             %TRIM(LIRDOB2) + ',' +
010200210514     C                             %TRIM(LIRREL2) + ',' +
010300210514     C                             %TRIM(LIRSTD2) + ',,' +
010400210512     C                             %TRIM(LIRCOV2) + ',,' +
010500210422     C                             %TRIM(LIRFNAM3) + ',' +
010600210422     C                             %TRIM(LIRLNAM3) + ',' +
010700210422     C                             %TRIM(LIRMI3) + ',' +
010800210422     C                             %TRIM(LIRSEX3) + ',' +
010900210422     C                             %TRIM(LIRDOB3) + ',' +
011000210514     C                             %TRIM(LIRREL3) + ',' +
011100210514     C                             %TRIM(LIRSTD3) + ',,' +
011200210512     C                             %TRIM(LIRCOV3) + ',,' +
011300210422     C                             %TRIM(LIRFNAM4) + ',' +
011400210422     C                             %TRIM(LIRLNAM4) + ',' +
011500210422     C                             %TRIM(LIRMI4) + ',' +
011600210422     C                             %TRIM(LIRSEX4) + ',' +
011700210422     C                             %TRIM(LIRDOB4) + ',' +
011800210514     C                             %TRIM(LIRREL4) + ',' +
011900210514     C                             %TRIM(LIRSTD4) + ',,' +
012000210512     C                             %TRIM(LIRCOV4) + ',,' +
012100210422     C                             %TRIM(LIRFNAM5) + ',' +
012200210422     C                             %TRIM(LIRLNAM5) + ',' +
012300210422     C                             %TRIM(LIRMI5) + ',' +
012400210514     C                             %TRIM(LIRREL5) + ',' +
012500210514     C                             %TRIM(LIRSTD5) + ',,' +
012600210512     C                             %TRIM(LIRCOV5) + ',,' +
012700210422     C                             %TRIM(LIRDOB5) + ',' +
012800210422     C                             %TRIM(LIRREL5) + ',,,,,'
012900150702    * *
013000060315     C                   EXCEPT    OUTFA
013100150702   S* *
013200150929   S* *
013300150702     C     *INZSR        BEGSR
013400150702    * *
013500150911    * *        Build Column Headings Row
013600150702     C                   CLEAR                   @OUTPUT
013700210422     C                   EVAL      @OUTPUT = 'Employee ID,' +
013800210416     C                             'Change Date,' +
013900210416     C                             'Dep Change Date,' +
014000210416     C                             'Termination Date,' +
014100210416     C                             'Mbr First Name,' +
014200210416     C                             'Mbr Last Name,' +
014300210416     C                             'Mbr Middle Initial,' +
014400210416     C                             'Mbr SSN,' +
014500210420     C                             'Mbr Gender,' +
014600210420     C                             'Mbr DOB,' +
014700210420     C                             'App Sign Date,' +
014800210420     C                             'Occupation,' +
014900210420     C                             'Hrs Per Week,' +
015000210420     C                             'Salary Amt,' +
015100210420     C                             'Salary Code,' +
015200210420     C                             'Sal Eff Date,' +
015300210420     C                             'Mbr Addr 1,' +
015400210416     C                             'Mbr Addr 2,' +
015500210416     C                             'Mbr City,' +
015600210419     C                             'Mbr State,' +
015700210419     C                             'Mbr Zip Code,' +
015800210419     C                             'Mbr Zip Plus 4,' +
015900210419     C                             'Home Phone,' +
016000210419     C                             'Work Phone,' +
016100210419     C                             'Work Phone Ext,' +
016200210419     C                             'Email Address,' +
016300210426      * Col AA
016400210426     C                             'Date of Benefits Eligibility,' +
016500210416     C                             'Subsequent Date of Benefits Eligibility,' +
016600210426     C                             'Reason for Prior Loss of Benefits ' +
016700210426     C                             'Eligibility,' +
016800210419     C                             'Pri Bene First Name,' +
016900210419     C                             'Pri Bene Last Name,' +
017000210419     C                             'Pri Bene Middle Init,' +
017100210419     C                             'Pri Bene Relationship,' +
017200210419     C                             'Pri Bene Address 1,' +
017300210416     C                             'Pri Bene Address 2,' +
017400210416     C                             'Pri Bene City,' +
017500210416     C                             'Pri Bene State,' +
017600210416     C                             'Pri Bene Zip Code,' +
017700210416     C                             'Pri Bene Zip Plus 4,' +
017800210416     C                             'Pri Bene SSN,' +
017900210416     C                             'Co Bene First Name,' +
018000210416     C                             'Co Bene Last Name,' +
018100210416     C                             'Co Bene Middle Init,' +
018200210416     C                             'Co Bene Relationship,' +
018300210416     C                             'Co Bene Address 1,' +
018400210416     C                             'Co Bene Address 2,' +
018500210416     C                             'Co Bene City,' +
018600210416     C                             'Co Bene State,' +
018700210416     C                             'Co Bene Zip Code,' +
018800210416     C                             'Co Bene Zip Plus 4,' +
018900210416     C                             'Co Bene SSN,' +
019000210416     C                             'Beneficiay Comments,' +
019100210426      *  Col BA
019200210426     C                             'Accident Policy Number,' +
019300210416     C                             'Accident Bill Location A/C Number,' +
019400210416     C                             'Accident Sort Group,' +
019500210416     C                             'Accident Eff Date,' +
019600210416     C                             'Accident Plan Code,' +
019700210416     C                             'Accident Class Code,' +
019800210416     C                             'Accident Tier Code,' +
019900210416     C                             'Health Asses Tier,' +
020000210416     C                             'Hospital Tier,' +
020100210416     C                             'Accident Disability Amount,' +
020200210416     C                             'Accident DI Tier,' +
020300210416     C                             'Accident DI Benefit Period,'+
020400210416     C                             'Accident DI Elim Period,' +
020500210426     C                             'Accident Sickness Disability Amount,' +
020600210416     C                             'Accident/sick DI Tier,' +
020700210416     C                             'Accident/sick DI Benefit Period,'+
020800210416     C                             'Accident/sick DI Elim Period,' +
020900210416     C                             'Accident Termination Date,' +
021000210416     C                             'Critical Illness Policy Number,' +
021100210416     C                             'Critical Illness Bill Location A/C Number,'+
021200210416     C                             'Critical Illness Sort Group,' +
021300210416     C                             'Critical Illness Eff Date,' +
021400210416     C                             'Critical Illness Plan Code,' +
021500210416     C                             'Critical Illness Class Code,' +
021600210416     C                             'Critical Illness Termination Date,' +
021700210416     C                             'EE Principal Sum Amt Approved,' +
021800210426      *  Col CA
021900210416     C                             'EE Principal Sum Amt Pending,' +
022000210416     C                             'SP Principal Sum Amt Approved,' +
022100210416     C                             'SP Principal Sum Amt Pending,' +
022200210416     C                             'CH Principal Sum Amt Approved,' +
022300210416     C                             'CH Principal Sum Amt Pending,' +
022400210416     C                             'EE Heart Amt Approved,' +
022500210416     C                             'EE Heart Amt Pending,' +
022600210426     C                             'SP Heart Amt Approved,' +
022700210426     C                             'SP Heart Amt Pending,' +
022800210416     C                             'CH Heart Amt Approved,' +
022900210416     C                             'CH Heart Amt Pending,' +
023000210416     C                             'EE Cancer Amt Approved,' +
023100210416     C                             'EE Cancer Amt Pending,' +
023200210416     C                             'SP Cancer Amt Approved,' +
023300210416     C                             'SP Cancer Amt Pending,' +
023400210416     C                             'CH Cancer Amt Approved,' +
023500210416     C                             'CH Cancer Amt Pending,' +
023600210416     C                             'EE Organ Amt Approved,' +
023700210416     C                             'EE Organ Amt Pending,' +
023800210416     C                             'SP Organ Amt Approved,' +
023900210416     C                             'SP Organ Amt Pending,' +
024000210416     C                             'CH Organ Amt Approved,' +
024100210416     C                             'CH Organ Amt Pending,' +
024200210416     C                             'EE Quality of Life Amt Approved,' +
024300210426      *  Col DA
024400210416     C                             'EE Quality of Life Amt Pending,' +
024500210416     C                             'SP Quality of Life Amt Approved,' +
024600210416     C                             'SP Quality of Life Amt Pending,' +
024700210416     C                             'CH Quality of Life Amt Approved,' +
024800210416     C                             'CH Quality of Life Amt Pending,' +
024900210416     C                             'Child Category Amt Approved,' +
025000210416     C                             'Child Category Amt Pending,' +
025100210416     C                             'EE Treatment Care Y/N,' +
025200210416     C                             'SP Treatment Care Y/N,' +
025300210416     C                             'CH Treatment Care Y/N,' +
025400210416     C                             'EE DI Y/N,' +
025500210416     C                             'SP DI Y/N,' +
025600210416     C                             'EE Accident Y/N,' +
025700210416     C                             'SP Accident Y/N,' +
025800210416     C                             'CH Accident Y/N,' +
025900210416     C                             'EE Occ/HIV Y/N,' +
026000210416     C                             'Life Policy Number,' +
026100210419     C                             'Life Bill Location A/C Number,' +
026200210419     C                             'Life Sort Group,' +
026300210419     C                             'Life Eff Date,' +
026400210419     C                             'Life Plan Code,' +
026500210419     C                             'Life Class Code,' +
026600210419     C                             'LI Cvgs,' +
026700210419     C                             'LI Termination Date,' +
026800210419     C                             'AD Cvgs,' +
026900210419     C                             'AD Termination Date,' +
027000210419     C                             'DLI Cvgs,' +
027100210419     C                             'DLI Termination Date,' +
027200210426      *  Col EA
027300210419     C                             'DAD Cvgs,' +
027400210419     C                             'DAD Termination Date,' +
027500210419     C                             'OLI Cvgs,' +
027600210416     C                             'OLI Termination Date,' +
027700210416     C                             'OAD Cvgs,' +
027800210416     C                             'OAD Termination Date,' +
027900210416     C                             'ODLI Cvgs,' +
028000210416     C                             'ODLI Termination Date,' +
028100210416     C                             'ODAD Cvgs,' +
028200210416     C                             'ODAD Termination Date,' +
028300210416     C                             'SLI Cvgs,' +
028400210416     C                             'SLI Termination Date,' +
028500210416     C                             'SAD Cvgs,' +
028600210416     C                             'SAD Termination Date,' +
028700210416     C                             'CLI Cvgs,' +
028800210416     C                             'CLI Termination Date,' +
028900210416     C                             'OSLI Cvgs,' +
029000210416     C                             'OSLI Termination Date,' +
029100210416     C                             'OSAD Cvgs,' +
029200210416     C                             'OSAD Termination Date,' +
029300210416     C                             'OCLI Cvgs,' +
029400210416     C                             'OCLI Termination Date,' +
029500210416     C                             'WI Policy Number,' +
029600210416     C                             'WI Bill Location A/C Number,' +
029700210416     C                             'WI Sort Group,' +
029800210416     C                             'WI Eff Date,' +
029900210426      *  Col FA
030000210416     C                             'WI Plan Code,' +
030100210416     C                             'WI Class Code,' +
030200210416     C                             'WI Cvgs,' +
030300210416     C                             'WI Termination Date,' +
030400210416     C                             'OWI Cvgs,' +
030500210416     C                             'OWI Termination Date,' +
030600210416     C                             'LTD Policy Number,' +
030700210416     C                             'LTD Bill Location A/C Number,' +
030800210416     C                             'LTD Sort Group,' +
030900210416     C                             'LTD Eff Date,' +
031000210416     C                             'LTD Plan Code,' +
031100210416     C                             'LTD Class Code,' +
031200210416     C                             'LTD Cvgs,' +
031300210416     C                             'LTD Termination Date,' +
031400210416     C                             'OLTD Cvgs,' +
031500210416     C                             'OLTD Termination Date,' +
031600210416     C                             'CI Cvgs,' +
031700210416     C                             'CI Termination Date,' +
031800210416     C                             'Dent Policy Number,' +
031900210416     C                             'Dent Bill Location A/C Number,' +
032000210416     C                             'Dent Sort Group,' +
032100210416     C                             'Dent Eff Date,' +
032200210416     C                             'Dent Plan Code,' +
032300210416     C                             'Dent Class Code,' +
032400210416     C                             'Dent Coverage Tier,' +
032500210420     C                             'Dent Other Ins,' +
032600210426      *  Col GA
032700210420     C                             'Dent Termination Date,' +
032800210420     C                             'DHMO Policy Number,' +
032900210420     C                             'DHMO Bill Location A/C Number,' +
033000210420     C                             'DHMO Sort Group,' +
033100210420     C                             'DHMO Eff Date,' +
033200210420     C                             'DHMO Plan Code,' +
033300210420     C                             'DHMO Class Code,' +
033400210416     C                             'DHMO Coverage Tier,' +
033500210420     C                             'DHMO PCP,' +
033600210420     C                             'DHMO Termination Date,' +
033700210420     C                             'LVC Policy Number,' +
033800210420     C                             'LVC Bill Location A/C Number,' +
033900210420     C                             'LVC Sort Group,' +
034000210420     C                             'LVC Eff Date,' +
034100210416     C                             'LVC Plan Code,' +
034200210416     C                             'LVC Class Code,' +
034300210416     C                             'LVC Coverage Tier,' +
034400210416     C                             'LVC Other Ins,' +
034500210416     C                             'LVC Termination Date,' +
034600210416     C                             'VLVC Policy Number,' +
034700210416     C                             'VLVC Bill Location A/C Number,' +
034800210416     C                             'VLVC Sort Group,' +
034900210416     C                             'VLVC Eff Date,' +
035000210416     C                             'VLVC Plan Code,' +
035100210416     C                             'VLVC Class Code,' +
035200210416     C                             'VLVC Coverage Tier,' +
035300210426      *  Col HA
035400210416     C                             'VLVC Other Ins,' +
035500210416     C                             'VLVC Termination Date,' +
035600210416     C                             'VDN Policy Number,' +
035700210416     C                             'VDN Bill Location A/C Number,' +
035800210416     C                             'VDN Sort Group,' +
035900210416     C                             'VDN Eff Date,' +
036000210416     C                             'VDN Plan Code,' +
036100210416     C                             'VDN Class Code,' +
036200210416     C                             'VDN Coverage Tier,' +
036300210416     C                             'VDN Other Ins,' +
036400210416     C                             'VDN Termination Date,' +
036500210416     C                             'VDHMO Policy Number,' +
036600210416     C                             'VDHMO Bill Location A/C Number,' +
036700210416     C                             'VDHMO Sort Group,' +
036800210416     C                             'VDHMO Eff Date,' +
036900210416     C                             'VDHMO Plan Code,' +
037000210416     C                             'VDHMO Class Code,' +
037100210416     C                             'VDHMO Coverage Tier,' +
037200210416     C                             'VDHMO PCP,' +
037300210416     C                             'VDHMO Termination Date,' +
037400210416     C                             'VLIF Policy Number,' +
037500210416     C                             'VLIF Bill Location A/C Number,' +
037600210416     C                             'VLIF Sort Group,' +
037700210416     C                             'VLIF Eff Date,' +
037800210416     C                             'VLIF Plan Code,' +
037900210416     C                             'VLIF Class Code,' +
038000210426      *  Col IA
038100210416     C                             'VLI Cvgs,' +
038200210416     C                             'VLI Termination Date,' +
038300210416     C                             'VAD Cvgs,' +
038400210416     C                             'VAD Termination Date,' +
038500210416     C                             'VSLI Cvgs,' +
038600210416     C                             'VSLI Termination Date,' +
038700210416     C                             'VSAD Cvgs,' +
038800210416     C                             'VSAD Termination Date,' +
038900210416     C                             'VCLI Cvgs,' +
039000210416     C                             'VCLI Termination Date,' +
039100210416     C                             'VWI Policy Number,' +
039200210416     C                             'VWI Bill Location A/C Number,' +
039300210416     C                             'VWI Sort Group,' +
039400210416     C                             'VWI Eff Date,' +
039500210416     C                             'VWI Plan Code,' +
039600210416     C                             'VWI Class Code,' +
039700210416     C                             'VWI Benefit Amt,' +
039800210416     C                             'VWI Elim Period,' +
039900210416     C                             'VWI Benefit Duration,' +
040000210416     C                             'VWI Termination Date,' +
040100210416     C                             'VLTD Policy Number,' +
040200210416     C                             'VLTD Bill Location A/C Number,' +
040300210416     C                             'VLTD Sort Group,' +
040400210416     C                             'VLTD Eff Date,' +
040500210416     C                             'VLTD Plan Code,' +
040600210416     C                             'VLTD Class Code,' +
040700210416     C                             'VLTD Benefit Amt,' +
040800210426      *  Col JA
040900210416     C                             'VLTD Elim Period,' +
041000210416     C                             'VLTD Benefit Duration,' +
041100210426     C                             'VLTD Benefit Pct,' +
041200210416     C                             'VLTD Termination Date,' +
041300210416     C                             'STAD Policy Number,' +
041400210416     C                             'STAD Bill Location A/C Number,' +
041500210416     C                             'STAD Sort Group,' +
041600210416     C                             'STAD Eff Date,' +
041700210416     C                             'STAD Plan Code,' +
041800210416     C                             'STAD Class Code,' +
041900210416     C                             'STVAD Cvgs,' +
042000210416     C                             'STVAD Termination Date,' +
042100210416     C                             'STVSAD Cvgs,' +
042200210416     C                             'STVSAD Termination Date,' +
042300210416     C                             'STVCAD Cvgs,' +
042400210416     C                             'STVCAD Termination Date,' +
042500210416     C                             'Qualifying Event Code,' +
042600210416     C                             'Qualifying Event Eff Date,' +
042700210416     C                             'Mbr Smoker,' +
042800210416     C                             'Spouse Smoker,' +
042900210416     C                             'Spouse DOB,' +
043000210416     C                             'Dep First Name,' +
043100210416     C                             'Dep Last Name,' +
043200210416     C                             'Dep M I,' +
043300210416     C                             'Dep Gender,' +
043400210426      *  Col KA
043500210416     C                             'Dep DOB,' +
043600210416     C                             'Dep Relationship Code,' +
043700210416     C                             'Dep Student Code,' +
043800210416     C                             'Dep Disabled Y/N,' +
043900210416     C                             'Dep Cvg Indicator,' +
044000210421     C                             'Dep DHMO PCP,' +
044100210421     C                             'Dep 2 First Name,' +
044200210421     C                             'Dep 2 Last Name,' +
044300210421     C                             'Dep 2 M I,' +
044400210421     C                             'Dep 2 Gender,' +
044500210421     C                             'Dep 2 DOB,' +
044600210421     C                             'Dep 2 Relationship Code,' +
044700210421     C                             'Dep 2 Student Code,' +
044800210421     C                             'Dep 2 Disabled Y/N,' +
044900210421     C                             'Dep 2 Cvg Indicator,' +
045000210421     C                             'Dep 2 DHMO PCP,' +
045100210421     C                             'Dep 3 First Name,' +
045200210421     C                             'Dep 3 Last Name,' +
045300210421     C                             'Dep 3 M I,' +
045400210421     C                             'Dep 3 Gender,' +
045500210421     C                             'Dep 3 DOB,' +
045600210421     C                             'Dep 3 Relationship Code,' +
045700210421     C                             'Dep 3 Student Code,' +
045800210421     C                             'Dep 3 Disabled Y/N,' +
045900210421     C                             'Dep 3 Cvg Indicator,' +
046000210421     C                             'Dep 3 DHMO PCP,' +
046100210421     C                             'Dep 4 First Name,' +
046200210421     C                             'Dep 4 Last Name,' +
046300210421     C                             'Dep 4 M I,' +
046400210421     C                             'Dep 4 Gender,' +
046500210421     C                             'Dep 4 DOB,' +
046600210421     C                             'Dep 4 Relationship Code,' +
046700210421     C                             'Dep 4 Student Code,' +
046800210421     C                             'Dep 4 Disabled Y/N,' +
046900210421     C                             'Dep 4 Cvg Indicator,' +
047000210421     C                             'Dep 4 DHMO PCP,' +
047100210421     C                             'Dep 5 First Name,' +
047200210421     C                             'Dep 5 Last Name,' +
047300210421     C                             'Dep 5 M I,' +
047400210421     C                             'Dep 5 Gender,' +
047500210421     C                             'Dep 5 DOB,' +
047600210421     C                             'Dep 5 Relationship Code,' +
047700210421     C                             'Dep 5 Student Code,' +
047800210421     C                             'Dep 5 Disabled Y/N,' +
047900210421     C                             'Dep 5 Cvg Indicator,' +
048000210421     C                             'Dep 5 DHMO PCP'
048100150702    * *
048200150702     C                   EXCEPT    OUTFA
048300150702   X* *
048400150702    * *
048500150702     C                   ENDSR
048600150702    * *
048700210416     OLINCSVP   EADD         OUTFA
048800210422     O                       @OUTPUT           9000
