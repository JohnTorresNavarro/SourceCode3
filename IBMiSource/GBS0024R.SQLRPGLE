000100170925     H DftActGrp(*NO)
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428      *-------------------------------------------------------------------------
000400160428      *
000500170922      *  Description: Load F.Member
000600160428      *  Programmer.: Brian Rees
000700170922      *  Date.......: 9/22/2017
000800170313      *
000900170925      *  Notes: The idea of this program is that it would be called from
001000170925      *         many separate programs.  The input parameter is a Data Structure
001100170925      *         defined by F.MEMBER.   If a record exists, we will update the
001200170925      *         F.HIST record and update file file.  Otherwise, we will write
001300170925      *         a new F.MEMBER file.
001400170925      *
001500160428      *-------------------------------------------------------------------------
001600160428      * Modifications
001700160428      *
001800170427      * Date         Programmer    Mod      Description
001900160428      *-------------------------------------------------------------------------
002000171020      * 10/20/2017   B.Rees        br01
002100171020      *  For CF Accounts, we need to write the the F.TRNMIT File.
002200171020      *
002300191105      * 11/05/2019   J.Allen       ja01
002400191114      *  For TXMTYN Accounts, get the group# in the F.TRNMIT File.
002500191105      *
002600200929      * 09/29/2020   B.Rees
002700200929      *  For NEW Records we can write the Birth Date.
002800201204      *
002900201204      * 12/04/2020   B.Rees
003000201204      * Check the PayFile Error List, If the SSN is in that file, do not
003100201204      *  update the data.
003200201204      *
003300210914      * 09/14/2021   B.Rees
003400210914      * For Addresses:  Removed the "Update if not blank" logic.
003500210914      *  When an apt number is removed from a payfile, that number
003600210914      *  would stay in F.MEMBER becuase it wasn't updating if the value
003700210914      *  was blank.  TICKET: CR000385
003800211130      *
003900211130      * 11/30/2021   B.Rees
004000211130      *  Addition of Cost Center
004100220413      *
004200220413      * 04/13/2022  J.Allen
004300220413      *  Zero SSN, something is wrong, return to caller.
004400210914      *
004500160428      *-------------------------------------------------------------------------
004600170922     fMember    uf a E           K Disk    ExtDesc('F.MEMBER') ExtFile(*extdesc)
004700170427     fHist      if a E           K Disk    ExtDesc('F.HIST') ExtFile(*extdesc)
004800171024     fTrnMit    uf a E           K Disk    ExtDesc('F.TRNMIT') ExtFile(*extdesc)
004900171024     f                                     Prefix(t_)
005000160428      *-------------------------------------------------------------------------
005100160428
005200170922     d Pgmd          ESDS                  ExtName(IOPGMD)
005300170922      *?Program status data structure
005400161010
005500170315
005600171024     d input_data    e ds                  extName('F.MEMBER') Prefix(i_)
005700170922      *?Input Data
005800170922
005900191105br01 d Today           s              8s 0
006000171020br01 d CFS_Account     s              1
006100171020br01 d CFS_Count       s              5s 0
006200171020br01 d CFS_Action      s              2
006300191105br01 d CFS_Carrier     s              3
006400191105br01 d CFS_Plan        s              4
006500191111ja01 d CFS_Group#      s             15
006600171020br01 d DataChanged     s              1
006700170505
006800201204       dcl-s Err_Count Zoned(3);
006900201204
007000170430
007100160127      *------------------------------------------------------------------
007200211130      * Main Program
007300160127      *------------------------------------------------------------------
007400170315     C     *entry        plist
007500171024     C                   parm                    input_data
007600220413
007700220413          if i_mbssno = 0;
007800220413             *inlr = *on;
007900220413             return;
008000220413          endif;
008100160126
008200211130br01   // Check to see if we need to write to F.TRNMIT
008300201204       CFS_Account = 'N';
008400201204       CFS_Count = 0;
008500201204       CFS_Carrier = *Blanks;
008600171024
008700201204       Exec Sql
008800201204         Select carrcd, count(*)
008900201204           into :CFS_Carrier, :CFS_Count
009000201204           From "F.MCOV"
009100201204                Join "F.PLNMST"
009200201204                  on plTrst = mctrst and
009300201204                    plsub# = mcsub# and
009400201204                    plplan = mcplan
009500201204                Join "F.CARMST"
009600201204                  on pcarr = carrcd
009700201204           Where mcssno = :i_mbssno and
009800201204                 txmtyn = 'Y' and
009900201204                 mcdltd = 'A'
010000201204           Group by Carrcd
010100201204           Fetch first 1 rows only;
010200171024
010300201204       If CFS_Count > 0;
010400201204         CFS_Account = 'Y';
010500201204       endif;
010600171020
010700171020
010800170427
010900211130       // Check to see if the passed in SSN is in the system...
011000201204       chain i_mbssno Member;
011100170922
011200170922
011300211130       // If the Data wasn't found, Add to F.Member
011400201204       if not %found( Member );
011500201204         exsr Write_NewRcd;
011600201204       endif;
011700170922
011800201204       err_Count = 0;
011900201204       exec sql
012000201204         select Count(*)
012100201204           into :Err_Count
012200201204           from PyFile_Err
012300210430           where erSsn = :i_mbssno
012400210430           and erTrst = :i_mbTrst
012500210430           and erSub#  = :i_mbsub#
012600210430           and erAcct = :i_mbacct;
012700210430
012800201204
012900201204       if Err_Count = 0;
013000201204
013100211130         // If the account was found; check to see if any
013200211130         // data needs to be changed.
013300201204         exsr Check_DataChange;
013400171024
013500171024
013600211130br01     // CFS - Figure out which Action Code is needed.
013700211130br01     // Write F.TRNMIT Records
013800201204         if CFS_Account = 'Y' and DataChanged = 'Y';
013900171024           CFS_Action = 'MD';
014000191105           exsr Get_Group#;
014100171024           exsr Write_TransRcd;
014200201204         endif;
014300171020
014400171020
014500171020
014600171023
014700211130         // If a record was found, only update what was changed..
014800210218         if %found( Member ) and DataChanged = 'Y';
014900171025           exsr Update_Hst;
015000171023           exsr Update_Rcd;
015100201204         endif;
015200171023
015300201204       endif;   // No Errors Found
015400201204
015500201204       *inlr = *on;
015600170922
015700170922       //----------------------------------------------------------------
015800211130       //  Write New F.Member Record.
015900170922       //----------------------------------------------------------------
016000170922       Begsr Write_NewRcd;
016100170922
016200201204         mbssno = i_mbssno;
016300201204         mlname = i_mlname;
016400201204         mfname = i_mfname;
016500201204         mmi    = i_mmi;
016600201204         addr1  = i_addr1;
016700201204         addr2  = i_addr2;
016800201204         city   = i_city;
016900201204         state  = i_state;
017000201204         zip    = i_zip;
017100201204         area   = i_area;
017200201204         phone  = i_phone;
017300201204         sex    = i_sex;
017400201204         mbtrst = i_mbtrst;
017500201204         mbsub# = i_mbsub#;
017600201204         mbacct = i_mbacct;
017700201204         empst  = i_empst;
017800201204         nodpnd = i_nodpnd;
017900201204         hndicp = i_hndicp;
018000201204         medicr = i_medicr;
018100190516
018200201204         if i_med# = 'No';
018300201204           i_Med# = '';
018400201204         endif;
018500190516
018600201204         med#   = i_med#;
018700201204         gbscdt = i_gbscdt;
018800201204         // salary = i_salary;
018900201204         termcd = i_termcd;
019000201204         fill66 = i_fill66;
019100201204         moper  = 'AUTOGEN';
019200201204         birth  = i_birth;
019300201204         mardt  = i_mardt;
019400201204         hdcpdt = i_hdcpdt;
019500201204         medadt = i_medadt;
019600201204         medbdt = i_medbdt;
019700201204         empdt  = i_empdt;
019800201204         mbenrl = i_mbenrl;
019900201204         cvthdt = i_cvthdt;
020000201204         termdt = i_termdt;
020100201204         cob = i_Cob;
020200201204         medicr = i_medicr;
020300201204         Cobbcf = i_Cobbcf;
020400201204         status = i_status;
020500211130         ccflg  = i_ccflg;
020600211130
020700201204         mlupdt = %Dec(%date);
020800170926
020900201204         Write membr;
021000170922
021100211130         // Write History Record
021200201204         hkey = ' ' + %editc(i_mbssno : 'X') ;
021300201204         hPrgnm = 'GBS0024R';
021400201204         trDate = %Dec(%Date);
021500201204         hsTrst = i_mbtrst;
021600201204         hsSub# = i_mbSub#;
021700201204         hsAcct = i_mbAcct;
021800201204         hsDltd = 'A';
021900201204         hstrTime = %Time;
022000201204         hOper =  'AUTOGEN';
022100201204         covtdt = %Dec(%Date);
022200201204         trCode = 'MMA';
022300201204         ck#Not =  *Blanks;
022400201204         note2 = *Blanks;
022500170922
022600201204         write histr;
022700170922
022800170922       Endsr;
022900170922
023000171023
023100171023       //----------------------------------------------------------------
023200171023       //
023300211130       //  Check to see if any data needs to be modified.
023400171023       //
023500171023       //----------------------------------------------------------------
023600171023       Begsr Check_DataChange;
023700171023
023800201204         DataChanged = 'N';
023900171024
024000211130         // Last Name
024100201204         if i_mlname > *blanks and i_mlname <> mlname;
024200201204           DataChanged = 'Y';
024300201204         EndIf;
024400171023
024500211130         // First Name
024600201204         if i_mfname > *blanks and i_mfname <> mfname;
024700201204           DataChanged = 'Y';
024800201204         EndIf;
024900171023
025000211130         // mmi
025100201204         if i_mmi > *blanks and i_mmi <> mmi;
025200201204           DataChanged = 'Y';
025300201204         EndIf;
025400171023
025500211130         // Address Line 1
025600210914         //   if i_addr1 > *blanks and i_addr1 <> addr1;
025700210914         if i_addr1 <> addr1;
025800201204           DataChanged = 'Y';
025900201204         EndIf;
026000171023
026100211130         // Address Line 2
026200210914         //  if i_addr2 > *blanks and i_addr2 <> addr2;
026300210914         if i_addr2 <> addr2;
026400201204           DataChanged = 'Y';
026500201204         EndIf;
026600171023
026700211130         // City
026800201204         if i_city > *blanks and i_city <> city;
026900201204           DataChanged = 'Y';
027000201204         EndIf;
027100171023
027200211130         // State
027300201204         if i_state > *blanks and i_state <> state;
027400201204           DataChanged = 'Y';
027500201204         EndIf;
027600171023
027700211130         // Zip
027800201204         if i_zip > 0 and i_zip <> zip;
027900201204           DataChanged = 'Y';
028000201204         EndIf;
028100171023
028200211130         // Area
028300201204         if i_area > 0 and i_area <> area;
028400201204           DataChanged = 'Y';
028500201204         EndIf;
028600171023
028700171023
028800211130         // Phone
028900201204         if i_phone > 0 and i_Phone <> phone;
029000201204           DataChanged = 'Y';
029100201204         EndIf;
029200171023
029300211130         // Gender
029400201204         if i_sex > *blanks and i_sex <> sex;
029500201204           DataChanged = 'Y';
029600201204         EndIf;
029700171023
029800211130         // Birth Date
029900201204         //if i_birth > 0 and i_birth <> birth;
030000201204         //   DataChanged = 'Y';
030100201204         //EndIf;
030200171023
030300211130         // Hire Date
030400201204         if i_empdt > 0 and i_empdt <> empdt;
030500201204           DataChanged = 'Y';
030600201204         EndIf;
030700171023
030800211130         // Marriage Date
030900201204         if i_mardt > 0 and i_mardt <> mardt;
031000201204           DataChanged = 'Y';
031100201204         EndIf;
031200171023
031300211130         // Salary
031400171108         // if i_Salary > 0 and i_Salary <> Salary;
031500171108         //    DataChanged = 'Y';
031600171108         // EndIf;
031700171023
031800211130         // Medicare
031900201204         if i_med# > *Blanks and i_Med# <> Med#;
032000201204           DataChanged = 'Y';
032100201204         EndIf;
032200211130
032300211130
032400211130         // Cost Center
032500211130         if i_ccflg > '' and i_ccflg <> ccflg;
032600211130           DataChanged = 'Y';
032700211130         EndIf;
032800211130
032900211130
033000171023       endsr;
033100171023
033200171023
033300170427       //----------------------------------------------------------------
033400170922       //
033500211130       //  Write to the History File.
033600170922       //
033700170427       //----------------------------------------------------------------
033800170922       Begsr Update_Hst;
033900170427
034000211130         // Setup Defaults
034100201204         hkey = ' ' + %editc(i_mbssno : 'X') ;
034200201204         hPrgnm = 'GBS0024R';
034300201204         trDate = %Dec(%Date);
034400201204         hsTrst = i_mbtrst;
034500201204         hsSub# = i_mbSub#;
034600201204         hsAcct = i_mbAcct;
034700201204         hsDltd = 'A';
034800201204         hstrTime = %Time;
034900201204         hOper =  'AUTOGEN';
035000201204         covtdt = %Dec(%Date);
035100170427
035200211130         // Last Name
035300201204         if i_mlname > *blanks and i_mlname <> mlname;
035400201204           trCode = 'M01';
035500201204           ck#Not = mlname;
035600201204           note2  = i_mlname;
035700201204           write histr;
035800201204         EndIf;
035900170427
036000211130         // First Name
036100201204         if i_mfname > *blanks and i_mfname <> mfname;
036200201204           trCode = 'M02';
036300201204           ck#Not = mfname;
036400201204           note2  = i_mfname;
036500201204           write histr;
036600201204         EndIf;
036700170922
036800211130         // mmi
036900201204         if i_mmi > *blanks and i_mmi <> mmi;
037000201204           trCode = 'M03';
037100201204           ck#Not = mmi;
037200201204           note2  = i_mmi;
037300201204           write histr;
037400201204         EndIf;
037500170922
037600170427
037700211130         // Address Line 1
037800210914         // if i_addr1 > *blanks and i_addr1 <> addr1;
037900210914         if i_addr1 <> addr1;
038000201204           trCode = 'M04';
038100201204           ck#Not = addr1;
038200201204           note2  = i_addr1;
038300201204           write histr;
038400201204         EndIf;
038500170922
038600211130         // Address Line 2
038700210914         // if i_addr2 > *blanks and i_addr2 <> addr2;
038800210914         if i_addr2 <> addr2;
038900201204           trCode = 'M05';
039000201204           ck#Not = addr2;
039100201204           note2  = i_addr2;
039200201204           write histr;
039300201204         EndIf;
039400170922
039500211130         // City
039600201204         if i_city > *blanks and i_city <> city;
039700201204           trCode = 'M06';
039800201204           ck#Not = city;
039900201204           note2  = i_city;
040000201204           write histr;
040100201204         EndIf;
040200170922
040300211130         // State
040400201204         if i_state > *blanks and i_state <> state;
040500201204           trCode = 'M07';
040600201204           ck#Not = state;
040700201204           note2  = i_state;
040800201204           write histr;
040900201204         EndIf;
041000170922
041100211130         // Zip
041200201204         if i_zip > 0 and i_zip <> zip;
041300201204           trCode = 'M08';
041400201204           ck#Not = %Char(zip);
041500201204           note2  = %Char(i_zip);
041600201204           write histr;
041700201204         EndIf;
041800170922
041900211130         // Area
042000201204         if i_area > 0 and i_area <> area;
042100201204           trCode = 'M11';
042200201204           ck#Not = %Char(area);
042300201204           note2  = %Char(i_area);
042400201204           write histr;
042500201204         EndIf;
042600170922
042700170922
042800211130         // Phone
042900201204         if i_phone > 0 and i_Phone <> phone;
043000201204           trCode = 'M12';
043100201204           ck#Not = %Char(phone);
043200201204           note2  = %Char(i_phone);
043300201204           write histr;
043400201204         EndIf;
043500170922
043600211130         // Gender
043700201204         if i_sex > *blanks and i_sex <> sex;
043800201204           trCode = 'M09';
043900201204           ck#Not = %Char(sex);
044000201204           note2  = %Char(i_sex);
044100201204           write histr;
044200201204         EndIf;
044300170922
044400211130         // Birth Date
044500201204         //  if i_birth > 0 and i_birth <> birth;
044600201204         //     trCode = 'M10';
044700201204         //     ck#Not = %Char(birth);
044800201204         //     note2  = %Char(i_birth);
044900201204         //     write histr;
045000201204         //  EndIf;
045100170922
045200211130         // Hire Date
045300201204         if i_empdt > 0 and i_empdt <> empdt;
045400201204           trCode = 'M16';
045500201204           ck#Not = %Char(empdt);
045600201204           note2  = %Char(i_empdt);
045700201204           write histr;
045800201204         EndIf;
045900170925
046000211130         // Marriage Date
046100201204         if i_mardt > 0 and i_mardt <> mardt;
046200201204           trCode = 'M19';
046300201204           ck#Not = %Char(mardt);
046400201204           note2  = %Char(i_mardt);
046500201204           write histr;
046600201204         EndIf;
046700170925
046800211130         // Salary
046900171108         // if i_Salary > 0 and i_Salary <> Salary;
047000171108         //    trCode = 'M17';
047100171108         //    ck#Not = %Char(Salary);
047200171108         //    note2  = %Char(i_Salary);
047300171108         //    write histr;
047400171108         // EndIf;
047500170922
047600211130         // Medicare
047700201204         if i_med# > *Blanks and i_Med# <> Med#;
047800201204           trCode = 'M20';
047900201204           ck#Not = Med#;
048000201204           note2  = i_Med#;
048100201204           write histr;
048200201204         EndIf;
048300211130
048400211130
048500211130         // Cost Center
048600211130         if i_ccflg > '' and i_ccflg <> ccflg;
048700211130           trCode = 'CCC';
048800211130           ck#Not = ccFlg;
048900211130           note2  = i_ccflg;
049000211130           write histr;
049100211130         EndIf;
049200211130
049300211130
049400211130
049500170427       endsr;
049600170427
049700170925
049800170925       //----------------------------------------------------------------
049900170925       //
050000211130       //  Update Member Record.
050100170925       //
050200170925       //----------------------------------------------------------------
050300170925       Begsr Update_Rcd;
050400170925
050500170925
050600211130         // Last Name
050700201204         if i_mlname > *blanks;
050800201204           mlname = i_mlname;
050900201204         EndIf;
051000170925
051100211130         // First Name
051200201204         if i_mfname > *blanks;
051300201204           mfname = i_mfname;
051400201204         EndIf;
051500170925
051600211130         // mmi
051700201204         if i_mmi > *blanks;
051800201204           mmi = i_mmi;
051900201204         EndIf;
052000170925
052100211130         // Address Line 1
052200210914         //  if i_addr1 > *blanks;
052300201204           addr1 = i_addr1;
052400210914         //  EndIf;
052500170925
052600211130         // Address Line 2
052700210914         // if i_addr2 > *blanks;
052800201204           addr2 = i_addr2;
052900210914         //  EndIf;
053000170925
053100211130         // City
053200201204         if i_city > *blanks;
053300201204           city = i_city;
053400201204         EndIf;
053500170925
053600211130         // State
053700201204         if i_state > *blanks;
053800201204           state = i_state;
053900201204         EndIf;
054000170925
054100211130         // Zip
054200201204         if i_zip > 0;
054300201204           zip = i_zip;
054400201204         EndIf;
054500170925
054600211130         // Area
054700201204         if i_area > 0;
054800201204           area = i_area;
054900201204         EndIf;
055000170925
055100170925
055200211130         // Phone
055300201204         if i_phone > 0;
055400201204           phone = i_phone;
055500201204         EndIf;
055600170925
055700211130         // Gender
055800201204         if i_sex > *blanks;
055900201204           sex = i_sex;
056000201204         EndIf;
056100170925
056200211130         // Employment Status      Removed per dk  8/22/2018
056300201204         //  if i_EmpSt > *Blanks;
056400201204         //     EmpSt = i_Empst;
056500201204         //  EndIf;
056600170926
056700211130         // Nbr of Dependents
056800201204         if i_NoDpnd > 0;
056900201204           NoDpnd = i_NoDpnd;
057000201204         EndIf;
057100170926
057200211130         // Handicapped
057300201204         if i_hndicp > *Blanks;
057400201204           Hndicp = i_Hndicp;
057500201204         EndIf;
057600170926
057700211130         // COB
057800201204         if i_cob > *Blanks;
057900201204           Cob = i_Cob;
058000201204         EndIf;
058100170926
058200211130         // Medicare
058300201204         if i_Medicr > *Blanks;
058400201204           Medicr = i_Medicr;
058500201204         EndIf;
058600170926
058700211130         // Med#
058800201204         if i_Med# > *Blanks;
058900201204           Med# = i_Med#;
059000201204         EndIf;
059100170926
059200211130         // GBS Cobra Beg Date
059300201204         if i_GBSCDT > 0;
059400201204           GbsCdt = i_GbsCdt;
059500201204         EndIf;
059600170926
059700211130         // Morbidity Codes
059800201204         if i_Morb1 > *Blanks;
059900201204           Morb1 = i_Morb1;
060000201204         EndIf;
060100201204         if i_Morb2 > *Blanks;
060200201204           Morb2 = i_Morb2;
060300201204         EndIf;
060400201204         if i_Morb3 > *Blanks;
060500201204           Morb3 = i_Morb3;
060600201204         EndIf;
060700201204         if i_Morb4 > *Blanks;
060800201204           Morb4 = i_Morb4;
060900201204         EndIf;
061000201204         if i_Morb5 > *Blanks;
061100201204           Morb5 = i_Morb5;
061200201204         EndIf;
061300170926
061400211130         // Deductable Met
061500201204         if i_mdepdm > 0;
061600201204           mDepdm = i_mDepdm;
061700201204         EndIf;
061800170926
061900211130         // Out of Pocket
062000201204         if i_mdepop > 0;
062100201204           mDepop = i_mDepop;
062200201204         EndIf;
062300170926
062400211130         // Cob Other Bc/bs
062500201204         if i_Cobbcf > *Blanks;
062600201204           Cobbcf = i_Cobbcf;
062700201204         EndIf;
062800170926
062900211130         // Cob City
063000201204         if i_CobCty > *Blanks;
063100201204           CobCty = i_CobCty;
063200201204         EndIf;
063300170926
063400211130         // Cob State
063500201204         if i_CobSt > *Blanks;
063600201204           CobSt = i_CobSt;
063700201204         EndIf;
063800170926
063900211130         // Ineligible Flags
064000201204         if i_Inelig > *Blanks;
064100201204           Inelig = i_Inelig;
064200201204         EndIf;
064300170926
064400211130         // Term Code
064500201204         if i_TermCd > *Blanks;
064600201204           TermCd = i_TermCd;
064700201204         EndIf;
064800170926
064900211130         // Qualifying Event Code
065000201204         if i_QeCd > *Blanks;
065100201204           QeCd = i_QeCd;
065200201204         EndIf;
065300170926
065400211130         // Notification Letter Code
065500201204         if i_NtfyCd > *Blanks;
065600201204           NtfyCd = i_NtfyCd;
065700201204         EndIf;
065800170926
065900211130         // Cancellation Code
066000201204         if i_CanCd > *Blanks;
066100201204           CanCd = i_CanCd;
066200201204         EndIf;
066300170926
066400211130         // Salary
066500201204         //if i_Salary > 0;
066600201204         //   Salary = i_Salary;
066700201204         //EndIf;
066800170926
066900211130         // Birth Date
067000201204         //  if i_birth > 0;
067100201204         //     birth = i_birth;
067200171108         // EndIf;
067300170926
067400211130         // Hire Date
067500201204         if i_empdt > 0;
067600201204           empdt = i_empdt;
067700201204         EndIf;
067800170925
067900211130         // Marriage Date
068000201204         if i_mardt > 0;
068100201204           mardt = i_mardt;
068200201204         EndIf;
068300170925
068400170925
068500211130         // Term Date
068600201204         if i_TermDt > 0;
068700201204           TermDt = i_TermDt;
068800201204         EndIf;
068900170925
069000170926
069100211130         // Status   Removed per dk  8/22/2018
069200201204         //  if i_Status = *Blanks;
069300201204         //     i_Status = 'AA';
069400201204         //  EndIf;
069500201204         //  status = i_status;
069600170926
069700211130
069800211130           // Cost Center
069900211130           if i_ccflg > '';
070000211130             ccflg = i_ccFlg;
070100211130           EndIf;
070200211130
070300201204         mlupdt = %Dec(%date);
070400170926
070500201204         Update Membr;
070600170925
070700170925       endsr;
070800191105
070900191105
071000191105       //----------------------------------------------------------------
071100191105       //
071200211130       //  Get the Group# (ja01)
071300191105       //
071400191105       //----------------------------------------------------------------
071500191105       Begsr Get_Group#;
071600191105
071700201204         CFS_Group# = *Blanks;
071800201204         Today = %Dec(%Date);
071900191105
072000201204         chain i_mbssno Member;
072100201204         if %found( Member );
072200191105
072300201204           Exec Sql
072400201204             Select mcplan
072500201204               into :CFS_Plan
072600201204               From "F.MCOV"
072700201204                    Join "F.PLNMST"
072800201204                      on plTrst = mctrst and
072900201204                        plsub# = mcsub# and
073000201204                        plplan = mcplan
073100201204                    Join "F.CARMST"
073200201204                      on pcarr = carrcd
073300201204               Where mcssno = :i_mbssno and
073400201204                     txmtyn = 'Y' and
073500201204                     mcdltd = 'A'
073600201204               Group by mcplan
073700201204               Fetch first 1 rows only;
073800191105
073900201204           Exec Sql
074000201204             Select group#
074100201204               into :CFS_Group#
074200201204               From "F.GRATE"
074300201204               Where grtrst = :mbtrst and
074400201204                     grsub# = :mbsub# and
074500201204                     grplan = :CFS_Plan and
074600201204                     :Today between FrmDat and toDat
074700201204               Group by Group#
074800201204               Fetch first row only;
074900191105
075000191105
075100201204         endif;
075200191105
075300191105       endsr;
075400171023
075500171023       //----------------------------------------------------------------
075600171023       //
075700211130       //  Write Transmit Record.
075800171023       //
075900171023       //----------------------------------------------------------------
076000171023       Begsr Write_TransRcd;
076100171023
076200201204         Clear TrnMir;
076300201204         t_ActCod = CFS_Action;
076400201204         t_qqTime = %Dec(%Time);
076500201204         t_qqUser = 'AUTOLOAD';
076600201204         t_qqFlag = 'H';
076700201204         t_qqPgnm = 'GBS0024R';
076800201204         t_DltCod = 'A';
076900201204         t_Carcod = CFS_Carrier;
077000201204         t_SocSoc = i_mbssno;
077100191111
077200211130         // ja01
077300201204         t_Group# = CFS_Group#;
077400171024
077500171024
077600211130         // Member Before
077700201204         t_olName = mlname;
077800201204         t_ofName = mfname;
077900201204         t_omi    = mmi;
078000201204         t_oaddr1 = addr1;
078100201204         t_oaddr2 = addr2;
078200201204         t_ocity  = city;
078300201204         t_ostate = state;
078400201204         t_ozip   = zip;
078500201204         t_osex   = sex;
078600201204         t_oarea  = area;
078700201204         t_ophone = phone;
078800171024
078900201204         t_oTrust = mbtrst;
079000201204         t_oSubno = mbsub#;
079100201204         t_oaccno = mbacct;
079200171024
079300171108         // t_osalar = salary;
079400201204         t_oempst = empst;
079500201204         t_ohndic = Hndicp;
079600171023
079700171023
079800201204         //----------------------------------
079900211130         // Member After
080000201204         //----------------------------------
080100201204         t_lName = i_mlname;
080200201204         t_fName = i_mfname;
080300201204         t_mi    = i_mmi;
080400201204         t_addr1 = i_addr1;
080500201204         t_addr2 = i_addr2;
080600201204         t_city  = i_city;
080700201204         t_state = i_state;
080800201204         t_mzip  = i_zip;
080900201204         t_sex   = i_sex;
081000201204         t_marea = i_area;
081100201204         t_mphone = i_phone;
081200171024
081300201204         t_Trust = i_mbtrst;
081400201204         t_Subno = i_mbsub#;
081500201204         t_accno = i_mbacct;
081600171024
081700171108         // t_msalry = i_salary;
081800201225         // t_empst = i_empst;  // Not changing this currently.
081900201225         t_empst = empst;
082000201225
082100201225
082200201204         t_qqDate = %Dec(%Date);
082300201204         t_hndicp = i_Hndicp;
082400171023
082500201204         Write trnmir;
082600171023
082700171023       endsr;
