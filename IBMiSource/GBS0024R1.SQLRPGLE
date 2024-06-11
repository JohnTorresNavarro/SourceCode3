000100170925     H DftActGrp(*NO)
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428      *-------------------------------------------------------------------------
000400160428      *
000500171024      *  Description: Load F.Depend
000600160428      *  Programmer.: Brian Rees
000700170922      *  Date.......: 9/22/2017
000800170313      *
000900170925      *  Notes: The idea of this program is that it would be called from
001000170925      *         many separate programs.  The input parameter is a Data Structure
001100170925      *         defined by F.DEPEND.   If a record exists, we will update the
001200170925      *         F.HIST record and update file file.  Otherwise, we will write
001300170925      *         a new F.DEPEND file.
001400170925      *
001500160428      *-------------------------------------------------------------------------
001600160428      * Modifications
001700160428      *
001800170427      * Date         Programmer    Mod      Description
001900160428      *-------------------------------------------------------------------------
002000171020      * 10/20/2017   B.Rees        br01
002100171020      *  For CF Accounts, we need to write the the F.TRNMIT File.
002200171020      *
002300191114      * 11/05/2019   J.Allen       ja01
002400191114      *  For TXMTYN Accounts, get the group# in the F.TRNMIT File.
002500171020      *
002600201206      * 12/04/2020   B.Rees
002700201206      * Check the PayFile Error List, If the SSN is in that file, do not
002800201206      *  update the data.
002900201206      *
003000201221      * 12/21/2020  B.Rees
003100201221      *  Added Writing SSN Changes to the History.
003200201206      *
003300210914      * 09/14/2021   B.Rees
003400210914      * For Addresses:  Removed the "Update if not blank" logic.
003500210914      *  When an apt number is removed from a payfile, that number
003600210914      *  would stay in F.MEMBER becuase it wasn't updating if the value
003700210914      *  was blank.  TICKET: CR000385
003800220413      *
003900220413      * 04/13/2022  J.Allen
004000220413      *  Zero SSN, something is wrong, return to caller.
004100210914      *
004200160428      *-------------------------------------------------------------------------
004300170925     fMember    if   E           K Disk    ExtDesc('F.MEMBER') ExtFile(*extdesc)
004400170925     fDepndc    uf a E           K Disk    ExtDesc('F.DEPNDC') ExtFile(*extdesc)
004500170427     fHist      if a E           K Disk    ExtDesc('F.HIST') ExtFile(*extdesc)
004600171024     fTrnMit    uf a E           K Disk    ExtDesc('F.TRNMIT') ExtFile(*extdesc)
004700171024     f                                     Prefix(t_)
004800160428      *-------------------------------------------------------------------------
004900160428
005000170922     d Pgmd          ESDS                  ExtName(IOPGMD)
005100170922      *?Program status data structure
005200161010
005300170315
005400170925     d input_data    e ds                  extName('F.DEPEND') Prefix(i_)
005500170922      *?Input Data
005600170922
005700170926     d HoldSeq         s              2s 0
005800191114br01 d Today           s              8s 0
005900171020br01 d CFS_Account     s              1
006000171020br01 d CFS_Count       s              5s 0
006100171020br01 d CFS_Action      s              2
006200171024br01 d CFS_Carrier     s              3
006300191114br01 d CFS_Plan        s              4
006400191114ja01 d CFS_Group#      s             15
006500171020br01 d DataChanged     s              1
006600171020
006700201206       dcl-s Err_Count Zoned(3);
006800201206
006900160127      *------------------------------------------------------------------
007000160127      *?Main Program
007100160127      *------------------------------------------------------------------
007200170315     C     *entry        plist
007300170922     C                   parm                    input_data
007400220413
007500220413          if i_dssno = 0;
007600220413             *inlr = *on;
007700220413             return;
007800220413          endif;
007900160126
008000201206       HoldSeq = 0;
008100170926
008200201206       //?Search for the Dependent Sequence #
008300201206       if i_depss# > 0;
008400201206         Exec Sql
008500201206           Select dpSeq#
008600201206             into :HoldSeq
008700201206             FROM "F.DEPEND"
008800201206             Where dssno = :i_dssno and
008900201206                   Depss# = :i_Depss#;
009000201206       endif;
009100181205
009200181205
009300201206       //?Check by Last Name...
009400201206       if HoldSeq = 0;
009500201206         Exec Sql
009600201206           Select dpSeq#
009700201206             into :HoldSeq
009800201206             FROM "F.DEPEND"
009900201206             Where dssno = :i_dssno and
010000201206                   Dfname = :i_Dfname;
010100201206       endif;
010200170927
010300171020
010400201206br01   //?Check to see if we need to write to F.TRNMIT
010500201206       CFS_Account = 'N';
010600201206       Exec Sql
010700201206         Select carrcd, count(*)
010800201206           into :CFS_Carrier, :CFS_Count
010900201206           From "F.MCOV"
011000201206                Join "F.PLNMST"
011100201206                  on plTrst = mctrst and
011200201206                    plsub# = mcsub# and
011300201206                    plplan = mcplan
011400201206                Join "F.CARMST"
011500201206                  on pcarr = carrcd
011600201206           Where mcssno = :i_dssno and
011700201206                 txmtyn = 'Y' and
011800201206                 mcdltd = 'A'
011900201206           Group by Carrcd
012000201206           Fetch first 1 rows only;
012100170927
012200171024
012300171024
012400201206       If CFS_Count > 0;
012500201206         CFS_Account = 'Y';
012600201206       endif;
012700171020
012800201206       err_Count = 0;
012900201206       exec sql
013000201206         select Count(*)
013100201206           into :Err_Count
013200201206           from PyFile_Err
013300201206           where erSsn = :i_dssno;
013400201206
013500201206       if Err_Count = 0;
013600201206
013700171020
013800201206         //?Assign the Sequence Number..
013900201206         if HoldSeq = 0;
014000201206           Exec Sql
014100201206             Select Max(dpSeq#)
014200201206               into :i_dpSeq#
014300201206               FROM "F.DEPEND"
014400201206               Where dssno = :i_dssno;
014500170927           i_dpSeq# = i_dpSeq# + 1;
014600201206         else;
014700170926           i_dpSeq# = HoldSeq;
014800201206         endif;
014900170926
015000170926
015100201206         //?Check to see if the passed in SSN is in the system...
015200201206         chain (i_dssno :i_dpSeq#) DepnDc;
015300170922
015400170922
015500201206         //?If the Data wasn't found, Add to F.Depend
015600201206         if not %found( DepnDc );
015700170922           exsr Write_NewRcd;
015800201206         endif;
015900170922
016000170922
016100201206         //?If the account was found; check to see if any
016200201206         //?data needs to be changed.
016300201206         exsr Check_DataChange;
016400171024
016500171024
016600201206br01     //?CFS - Figure out which Action Code is needed.
016700201206br01     //?Write F.TRNMIT Records
016800201206         if CFS_Account = 'Y';
016900171024           if not %found( DepnDc );
017000201206             CFS_Action = 'DA';
017100171024           else;
017200201206             if DataChanged = 'Y';
017300201206               CFS_Action = 'DD';
017400201206             endif;
017500171024           endif;
017600210218
017700210218           if dataChanged = 'Y';
017800191114           exsr Get_Group#;
017900171024           exsr Write_TransRcd;
018000210218           endif;
018100201206         endif;
018200171020
018300171024
018400201206         //?If a record was found, only update what was changed..
018500210218         if %found( DepnDc ) and dataChanged = 'Y';
018600171025           exsr Update_Hst;
018700170925           exsr Update_Rcd;
018800201206         endif;
018900170922
019000201206       endif;   // Not In Error File.
019100171020
019200201206       *inlr = *on;
019300170922
019400170922       //----------------------------------------------------------------
019500170926       //? Write New F.Depend Record.
019600170922       //----------------------------------------------------------------
019700170922       Begsr Write_NewRcd;
019800170922
019900201206         dssno  = i_dssno;
020000201206         dpSeq# = i_dpSeq#;
020100170925
020200201206         dlname = i_dlname;
020300201206         dfname = i_dfname;
020400201206         dmi    = i_dmi;
020500201206         daddr1 = i_daddr1;
020600201206         daddr2 = i_daddr2;
020700201206         dcity  = i_dcity;
020800201206         dstate = i_dstate;
020900201206         dzip   = i_dzip;
021000201206         darea  = i_darea;
021100201206         dphone = i_dphone;
021200201206         dsex   = i_dsex;
021300201215         dbirth = i_dbirth;
021400170925
021500201206         dRelCd = i_dRelCd;
021600201206         depss# = i_depss#;
021700201206         dstudn = i_dstudn;
021800201206         dhndcp = i_dhndcp;
021900170925
022000201206         dCob   = i_dCob;
022100201206         dCobbc = i_dCobbc;
022200201206         dMedcr = i_dMedcr;
022300201206         dMed#  = i_dMed#;
022400201206         dOper  = 'AUTOGEN';
022500201206         dpdltd = i_dpdltd;
022600201206         dhddt  = i_dhddt;
022700201206         dlupdt = %Dec(%Date);
022800170925
022900201206         Write depenr;
023000170922
023100201206         chain i_dssno Member;
023200170925
023300201206         //?Write History Record
023400201206         hkey = ' ' + %editc( i_dssno : 'X') ;
023500201206         hPrgnm = 'GBS0024R1';
023600201206         trDate = %Dec(%Date);
023700201206         hsTrst = mbtrst;
023800201206         hsSub# = mbSub#;
023900201206         hsAcct = mbAcct;
024000201206         hsDltd = 'A';
024100201206         hstrTime = %Time;
024200201206         hOper =  'AUTOGEN';
024300201206         covtdt = %Dec(%Date);
024400201206         trCode = 'MDB';
024500201206         ck#Not =  *Blanks;
024600201206         note2 = *Blanks;
024700170922
024800201206         write histr;
024900170922
025000170922       Endsr;
025100170922
025200170427       //----------------------------------------------------------------
025300170922       //
025400170922       //? Write to the History File.
025500170922       //
025600170427       //----------------------------------------------------------------
025700170922       Begsr Update_Hst;
025800170925
025900201206         chain i_dssno Member;
026000170925
026100201206         //?Setup Defaults
026200201206         hkey = ' ' + %editc(i_dssno  : 'X') ;
026300201206         hPrgnm = 'GBS0024R1';
026400201206         trDate = %Dec(%Date);
026500201206         hsTrst = mbtrst;
026600201206         hsSub# = mbSub#;
026700201206         hsAcct = mbAcct;
026800201206         hsDltd = 'A';
026900201206         hstrTime = %Time;
027000201206         hOper =  'AUTOGEN';
027100201206         covtdt = %Dec(%Date);
027200170427
027300170427
027400201221         //?SSN
027500201221         if i_depss# > 0 and i_Depss# <> Depss#;
027600201221           trCode = 'M54';
027700201221           ck#Not = %Editc(Depss#:'X');
027800201221           note2  = %Editc(i_depss#:'X');
027900201206           write histr;
028000201206         EndIf;
028100201221
028200201221         //?Last Name
028300201221         if i_dlname > *blanks and i_dlname <> dlname;
028400201221           trCode = 'M42';
028500201221           ck#Not = dlname;
028600201221           note2  = i_dlname;
028700201221           write histr;
028800201221         EndIf;
028900170427
029000201206         //?First Name
029100201206         if i_dfname > *blanks and i_dfname <> dfname;
029200201206           trCode = 'M43';
029300201206           ck#Not = dfname;
029400201206           note2  = i_dfname;
029500201206           write histr;
029600201206         EndIf;
029700170922
029800201206         //?mmi
029900201206         if i_dmi > *blanks and i_dmi <> dmi;
030000201206           trCode = 'M44';
030100201206           ck#Not = dmi;
030200201206           note2  = i_dmi;
030300201206           write histr;
030400201206         EndIf;
030500170922
030600170427
030700201206         //?Address Line 1
030800210914         // if i_daddr1 > *blanks and i_daddr1 <> daddr1;
030900210914         if i_daddr1 <> daddr1;
031000201206           trCode = 'M45';
031100201206           ck#Not = daddr1;
031200201206           note2  = i_daddr1;
031300201206           write histr;
031400201206         EndIf;
031500170922
031600201206         //?Address Line 2
031700210914         // if i_daddr2 > *blanks and i_daddr2 <> daddr2;
031800210914         if i_daddr2 <> daddr2;
031900201206           trCode = 'M46';
032000201206           ck#Not = daddr2;
032100201206           note2  = i_daddr2;
032200201206           write histr;
032300201206         EndIf;
032400170922
032500201206         //?City
032600201206         if i_dcity > *blanks and i_dcity <> dcity;
032700201206           trCode = 'M47';
032800201206           ck#Not = dcity;
032900201206           note2  = i_dcity;
033000201206           write histr;
033100201206         EndIf;
033200170922
033300201206         //?State
033400201206         if i_dstate > *blanks and i_dstate <> dstate;
033500201206           trCode = 'M48';
033600201206           ck#Not = dstate;
033700201206           note2  = i_dstate;
033800201206           write histr;
033900201206         EndIf;
034000170922
034100201206         //?Zip
034200201206         if i_dzip > 0 and i_dzip <> dzip;
034300201206           trCode = 'M49';
034400201206           ck#Not = %Char(dzip);
034500201206           note2  = %Char(i_dzip);
034600201206           write histr;
034700201206         EndIf;
034800170922
034900201206         //?Area
035000201206         if i_darea > 0 and i_darea <> darea;
035100201206           trCode = 'M52';
035200201206           ck#Not = %Char(darea);
035300201206           note2  = %Char(i_darea);
035400201206           write histr;
035500201206         EndIf;
035600170922
035700170922
035800201206         //?Phone
035900201206         if i_dphone > 0 and i_dPhone <> dphone;
036000201206           trCode = 'M53';
036100201206           ck#Not = %Char(dphone);
036200201206           note2  = %Char(i_dphone);
036300201206           write histr;
036400201206         EndIf;
036500170922
036600201206         //?Gender
036700201206         if i_dsex > *blanks and i_dsex <> dsex;
036800201206           trCode = 'M50';
036900201206           ck#Not = dsex;
037000201206           note2  = i_dsex;
037100201206           write histr;
037200201206         EndIf;
037300170922
037400201206         //?Birth Date
037500201206         //  if i_dbirth > 0 and i_dbirth <> dbirth;
037600201206         //     trCode = 'M51';
037700201206         //     ck#Not = %Char(dbirth);
037800201206         //     note2  = %Char(i_dbirth);
037900201206         //     write histr;
038000201206         //  EndIf;
038100170922
038200201206         //?Student
038300201206         if i_dStudn > *Blanks and i_dStudn <> dStudn;
038400201206           trCode = 'M55';
038500201206           ck#Not = dStudn;
038600201206           note2  = i_dStudn;
038700201206           write histr;
038800201206         EndIf;
038900170925
039000201206         //?Medicare
039100201206         if i_dmed# > *Blanks and i_dMed# <> dMed#;
039200201206           trCode = 'M57';
039300201206           ck#Not = dMed#;
039400201206           note2  = i_dMed#;
039500201206           write histr;
039600201206         EndIf;
039700170925
039800201206         //?COB
039900201206         if i_dcobpn > *Blanks and i_dcobpn <> dcobpn;
040000201206           trCode = 'M62';
040100201206           ck#Not = dcobpn;
040200201206           note2  = i_dcobpn;
040300201206           write histr;
040400201206         EndIf;
040500170925
040600201206         //?COB #
040700201206         if i_dcobp# > *Blanks and i_dcobp# <> dcobp#;
040800201206           trCode = 'M65';
040900201206           ck#Not = dcobp#;
041000201206           note2  = i_dcobp#;
041100201206           write histr;
041200201206         EndIf;
041300170925
041400201206         //?Relationship
041500201206         if i_drelcd > *Blanks and i_drelcd <> drelcd;
041600201206           trCode = 'M41';
041700201206           ck#Not = drelcd;
041800201206           note2  = i_drelcd;
041900201206           write histr;
042000201206         EndIf;
042100170925
042200170427       endsr;
042300170427
042400170925
042500170925       //----------------------------------------------------------------
042600170925       //
042700170925       //? Update Member Record.
042800170925       //
042900170925       //----------------------------------------------------------------
043000170925       Begsr Update_Rcd;
043100170925
043200170925
043300201206         //?Last Name
043400201206         if i_dlname > *blanks;
043500201206           dlname = i_dlname;
043600201206         EndIf;
043700170925
043800201206         //?First Name
043900201206         if i_dfname > *blanks;
044000201206           dfname = i_dfname;
044100201206         EndIf;
044200170925
044300201206         //?mmi
044400201206         if i_dmi > *blanks;
044500201206           dmi  = i_dmi;
044600201206         EndIf;
044700170925
044800201206         //?Address Line 1
044900210914         // if i_daddr1 > *blanks;
045000201206           daddr1 = i_daddr1;
045100210914         //EndIf;
045200170925
045300201206         //?Address Line 2
045400210914         //if i_daddr2 > *blanks;
045500201206           daddr2 = i_daddr2;
045600210914         //EndIf;
045700170925
045800201206         //?City
045900201206         if i_dcity > *blanks;
046000201206           dcity  = i_dcity;
046100201206         EndIf;
046200170925
046300201206         //?State
046400201206         if i_dstate > *blanks;
046500201206           dstate = i_dstate;
046600201206         EndIf;
046700170925
046800201206         //?Zip
046900201206         if i_dzip > 0;
047000201206           dzip = i_dzip;
047100201206         EndIf;
047200170925
047300201206         //?Area
047400201206         if i_darea > 0;
047500201206           darea = i_darea;
047600201206         EndIf;
047700170925
047800201206         //?Phone
047900201206         if i_dphone > 0;
048000201206           dphone = i_dphone;
048100201206         EndIf;
048200170925
048300201206         //?Gender
048400201206         if i_dsex > *blanks;
048500201206           dsex   = i_dsex;
048600201206         EndIf;
048700170925
048800201206         //?Birth Date
048900171108         // if i_dbirth > 0;
049000171108         //    dbirth = i_dbirth;
049100171108         // EndIf;
049200170925
049300201206         //?Student
049400201206         if i_dStudn > *Blanks;
049500201206           dStudn = i_dStudn;
049600201206         EndIf;
049700170925
049800201206         //?Medicare
049900201206         if i_dmed# > *Blanks;
050000201206           dMed#  = i_dMed#;
050100201206         EndIf;
050200170925
050300201206         //?COB
050400201206         if i_dcobpn > *Blanks;
050500201206           dcobpn = i_dcobpn;
050600201206         EndIf;
050700170925
050800201206         //?COB #
050900201206         if i_dcobp# > *Blanks;
051000201206           dcobp# = i_dcobp#;
051100201206         EndIf;
051200170925
051300201206         //?Relationship
051400201206         if i_drelcd > *Blanks;
051500201206           drelcd = i_drelcd;
051600201206         EndIf;
051700170925
051800170925
051900201206         //?Dep SSN#
052000201206         if i_depss# > *zero;
052100201206           depss# = i_depss#;
052200201206         EndIf;
052300170925
052400201206         if i_dcob > *blanks;
052500201206           dcob = i_dcob;
052600201206         endif;
052700170925
052800201206         if i_dcoben > *blanks;
052900201206           dcoben = i_dcoben;
053000201206         endif;
053100170925
053200201206         if i_dmorb1 > *blanks;
053300201206           dmorb1 = i_dmorb1;
053400201206         endif;
053500170925
053600201206         if i_dmorb2 > *blanks;
053700201206           dmorb2 = i_dmorb2;
053800201206         endif;
053900170925
054000201206         if i_dmorb3 > *blanks;
054100201206           dmorb3 = i_dmorb3;
054200201206         endif;
054300170925
054400201206         if i_dmorb4 > *blanks;
054500201206           dmorb4 = i_dmorb4;
054600201206         endif;
054700170925
054800201206         if i_dmorb5 > *blanks;
054900201206           dmorb5 = i_dmorb5;
055000201206         endif;
055100170925
055200201206         if i_depdmt > *zeros;
055300201206           depdmt = i_depdmt;
055400201206         endif;
055500170925
055600201206         if i_depoop > *zeros;
055700201206           depoop = i_depoop;
055800201206         endif;
055900170925
056000201206         if i_dcobbc > *zeros;
056100201206           dcobbc = i_dcobbc;
056200201206         endif;
056300170925
056400201206         if i_dcobct > *zeros;
056500201206           dcobct = i_dcobct;
056600201206         endif;
056700170925
056800201206         if i_dcobst > *zeros;
056900201206           dcobst = i_dcobst;
057000201206         endif;
057100170925
057200201206         if i_dc1pd  > *zeros;
057300201206           dc1pd  = i_dc1pd;
057400201206         endif;
057500170925
057600201206         if i_dpdltd > *zeros;
057700201206           dpdltd = i_dpdltd;
057800201206         endif;
057900170925
058000201206         if i_dmedad > *zeros;
058100201206           dmedad = i_dmedad;
058200201206         endif;
058300170925
058400201206         if i_dmedbd > *zeros;
058500201206           dmedbd = i_dmedbd;
058600201206         endif;
058700170925
058800170925
058900201206         update Depenr;
059000170925
059100170925       endsr;
059200170925
059300171024
059400171024       //----------------------------------------------------------------
059500171024       //
059600171024       //? Check to see if any data needs to be modified.
059700171024       //
059800171024       //----------------------------------------------------------------
059900171024       Begsr Check_DataChange;
060000171024
060100201206         DataChanged = 'N';
060200171024
060300201206         //?Last Name
060400201206         if i_dlname > *blanks and i_dlname <> dlname;
060500201206           DataChanged = 'Y';
060600201206         EndIf;
060700171024
060800201206         //?First Name
060900201206         if i_dfname > *blanks and i_dfname <> dfname;
061000201206           DataChanged = 'Y';
061100201206         EndIf;
061200171024
061300201206         //?mmi
061400201206         if i_dmi > *blanks and i_dmi <> dmi;
061500201206           DataChanged = 'Y';
061600201206         EndIf;
061700171024
061800171024
061900201206         //?Address Line 1
062000210914         // if i_daddr1 > *blanks and i_daddr1 <> daddr1;
062100210914         if i_daddr1 <> daddr1;
062200201206           DataChanged = 'Y';
062300201206         EndIf;
062400171024
062500201206         //?Address Line 2
062600210914         // if i_daddr2 > *blanks and i_daddr2 <> daddr2;
062700210914         if i_daddr2 <> daddr2;
062800201206           DataChanged = 'Y';
062900201206         EndIf;
063000171024
063100201206         //?City
063200201206         if i_dcity > *blanks and i_dcity <> dcity;
063300201206           DataChanged = 'Y';
063400201206         EndIf;
063500171024
063600201206         //?State
063700201206         if i_dstate > *blanks and i_dstate <> dstate;
063800201206           DataChanged = 'Y';
063900201206         EndIf;
064000171024
064100201206         //?Zip
064200201206         if i_dzip > 0 and i_dzip <> dzip;
064300201206           DataChanged = 'Y';
064400201206         EndIf;
064500171024
064600201206         //?Area
064700201206         if i_darea > 0 and i_darea <> darea;
064800201206           DataChanged = 'Y';
064900201206         EndIf;
065000171024
065100201206         //?Phone
065200201206         if i_dphone > 0 and i_dPhone <> dphone;
065300201206           DataChanged = 'Y';
065400201206         EndIf;
065500171024
065600201206         //?Gender
065700201206         if i_dsex > *blanks and i_dsex <> dsex;
065800201206           DataChanged = 'Y';
065900201206         EndIf;
066000171024
066100201206         //?Birth Date
066200171108         // if i_dbirth > 0 and i_dbirth <> dbirth;
066300171108         //    DataChanged = 'Y';
066400171108         // EndIf;
066500171024
066600201206         //?Student
066700201206         if i_dStudn > *Blanks and i_dStudn <> dStudn;
066800201206           DataChanged = 'Y';
066900201206         EndIf;
067000171024
067100201206         //?Medicare
067200201206         if i_dmed# > *Blanks and i_dMed# <> dMed#;
067300201206           DataChanged = 'Y';
067400201206         EndIf;
067500171024
067600201206         //?COB
067700201206         if i_dcobpn > *Blanks and i_dcobpn <> dcobpn;
067800201206           DataChanged = 'Y';
067900201206         EndIf;
068000171024
068100201206         //?COB #
068200201206         if i_dcobp# > *Blanks and i_dcobp# <> dcobp#;
068300201206           DataChanged = 'Y';
068400201206         EndIf;
068500171024
068600201206         //?Relationship
068700201206         if i_drelcd > *Blanks and i_drelcd <> drelcd;
068800201206           DataChanged = 'Y';
068900201206         EndIf;
069000171024
069100171024       endsr;
069200171024
069300191114       //----------------------------------------------------------------
069400191114       //
069500191114       //? Get the Group# (ja01)
069600191114       //
069700191114       //----------------------------------------------------------------
069800191114       Begsr Get_Group#;
069900191114
070000201206         CFS_Group# = *Blanks;
070100201206         Today = %Dec(%Date);
070200191114
070300201206         chain i_dssno Member;
070400201206         if %found( Member );
070500191114
070600201206           Exec Sql
070700201206             Select mcplan
070800201206               into :CFS_Plan
070900201206               From "F.MCOV"
071000201206                    Join "F.PLNMST"
071100201206                      on plTrst = mctrst and
071200201206                        plsub# = mcsub# and
071300201206                        plplan = mcplan
071400201206                    Join "F.CARMST"
071500201206                      on pcarr = carrcd
071600201206               Where mcssno = :i_dssno and
071700201206                     txmtyn = 'Y' and
071800201206                     mcdltd = 'A'
071900201206               Group by mcplan
072000201206               Fetch first 1 rows only;
072100191114
072200201206           Exec Sql
072300201206             Select group#
072400201206               into :CFS_Group#
072500201206               From "F.GRATE"
072600201206               Where grtrst = :mbtrst and
072700201206                     grsub# = :mbsub# and
072800201206                     grplan = :CFS_Plan and
072900201206                     :Today between FrmDat and toDat
073000201206               Group by Group#
073100201206               Fetch first row only;
073200191114
073300191114
073400201206         endif;
073500191114
073600191114       endsr;
073700171024
073800171024       //----------------------------------------------------------------
073900171024       //
074000171024       //? Write Transmit Record.
074100171024       //
074200171024       //----------------------------------------------------------------
074300171024       Begsr Write_TransRcd;
074400171024
074500201206         chain i_dssno Member;
074600171024
074700201206         Clear TrnMir;
074800201206         t_ActCod = CFS_Action;
074900201206         t_qqTime = %Dec(%Time);
075000201206         t_qqUser = 'AUTOLOAD';
075100201206         t_qqFlag = 'H';
075200201206         t_qqPgnm = 'GBS0024R1';
075300201206         t_DltCod = 'A';
075400201206         t_Carcod = CFS_Carrier;
075500201206         t_SocSoc = i_dssno;
075600171024
075700201206         //?ja01
075800201206         t_Group# = CFS_Group#;
075900171024
076000201206         //?Member Before
076100201206         t_olName = mlname;
076200201206         t_ofName = mfname;
076300201206         t_omi    = mmi;
076400201206         t_oaddr1 = addr1;
076500201206         t_oaddr2 = addr2;
076600201206         t_ocity  = city;
076700201206         t_ostate = state;
076800201206         t_ozip   = zip;
076900201206         t_osex   = sex;
077000201206         t_oarea  = area;
077100201206         t_ophone = phone;
077200171024
077300201206         t_oTrust = mbtrst;
077400201206         t_oSubno = mbsub#;
077500201206         t_oaccno = mbacct;
077600171024
077700201206         //  t_osalar = salary;
077800201206         t_oempst = empst;
077900201206         t_ohndic = Hndicp;
078000171024
078100171024
078200201206         //----------------------------------
078300201206         //?Member After
078400201206         //----------------------------------
078500201206         t_lName = mlname;
078600201206         t_fName = mfname;
078700201206         t_mi    = mmi;
078800201206         t_addr1 = addr1;
078900201206         t_addr2 = addr2;
079000201206         t_city  = city;
079100201206         t_state = state;
079200201206         t_mzip  = zip;
079300201206         t_sex   = sex;
079400201206         t_marea = area;
079500201206         t_mphone = phone;
079600171024
079700201206         t_Trust = mbtrst;
079800201206         t_Subno = mbsub#;
079900201206         t_accno = mbacct;
080000171024
080100201206         // t_msalry = salary;
080200201206         t_empst = empst;
080300201206         t_qqDate = %Dec(%Date);
080400201206         t_hndicp = Hndicp;
080500171024
080600201206         //----------------------------------
080700201206         //?Dependent Before
080800201206         //----------------------------------
080900171025
081000201206         if  CFS_Action = 'DD';
081100201206           t_odrelc = drelcd;
081200201206           t_odlnam = dlname;
081300201206           t_odfnam = dfname;
081400201206           t_odmi   = dmi;
081500201206           t_odadr1 = daddr1;
081600201206           t_odadr2 = daddr2;
081700201206           t_odcity = dcity;
081800201206           t_odstat = dState;
081900201206           t_odzip  = dZip;
082000201206           t_odsex  = dSex;
082100201206           t_odarea = dArea;
082200201206           t_odphon = dPhone;
082300201206           t_odss#  = Depss#;
082400201206           t_odstud = dStudn;
082500201206           t_odmedc = dMedCr;
082600201206           t_odmed# = dMed#;
082700201206           t_odhndc = dHndcp;
082800201206           t_odcob  = dCob;
082900201206         endif;
083000171025
083100201206         //----------------------------------
083200201206         //?Dependent After
083300201206         //----------------------------------
083400201206         t_drelc2 = i_drelcd;
083500201206         t_dlname = i_dlname;
083600201206         t_dfname = i_dfname;
083700201206         t_dmi    = i_dmi;
083800201206         t_daddr1 = i_daddr1;
083900201206         t_daddr2 = i_daddr2;
084000201206         t_dcity  = i_dcity;
084100201206         t_dstate = i_dState;
084200201206         t_dzip   = i_dZip;
084300201206         t_dsex   = i_dSex;
084400201206         t_ddarea = i_dArea;
084500201206         t_ddphon = i_dPhone;
084600201206         t_ddepss = i_Depss#;
084700201206         t_dstudn = i_dStudn;
084800201206         t_dmedcr = i_dMedCr;
084900201206         t_dmed#  = i_dMed#;
085000201206         t_dhndcp = i_dHndcp;
085100201206         t_dcob   = i_dCob;
085200171024
085300201206         Write trnmir;
085400171024
085500171024       endsr;
