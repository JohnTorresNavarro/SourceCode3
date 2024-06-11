000100191216     H Option(*noDebugIo)  DftActGrp(*NO)
000200150515    ? *-------------------------------------------------------------------------
000300150515    ? *
000400150817    ? *  Description:  Guardian file Transfer
000500150515    ? *  Programmer.:  Brian Rees
000600150817    ? *  Date.......:  08/17/2015
000700150515    ? *
000800150515    ? *  (c)Copyright 2015 by GBS, Inc.
000900150826    ? *
001000150821    ? *
001100150821    ? *? Pseudo Logic
001200150821    ? *  ------------
001300150918    ? *  Pass in the Unique ID
001400150821    ? *  Read the Account File.  (CarAccp);
001500150821    ? *    Get each?Trst-Sub-Acct
001600150821    ? *    Process each Member in Account:?$MemberData
001700150821    ? *       Retrieve Member Data:?$MemberRcd
001800150821    ? *       Process Member Coverage Data:?$MemberCoverage
001900150821      *       Generate the Coverage Record:?$CoverageRcd;
002000150821      *
002100150821    ? *       Retrieve Dependents:?$ProcessDepnd
002200150821    ? *         For Each of the Members Dependent
002300150821    ? *           Get the Dependent Data:?$DependRcd
002400150821      *           Clear Coverge Data:?$ClearCovg
002500150821    ? *           Get all Coverages For that Dependent:?$DependCovg
002600150821      *           Generate the Coverage Record:?$CoverageRcd;
002700150821    ? *         Loop
002800150821    ? *    Loop
002900150821    ? *  Loop
003000150824    ? *  Check Termed Records:?$ProcessTerms
003100150922      *
003200150922    ? *-------------------------------------------------------------------------
003300150922    ? *? Notes:
003400150922      *   We need to send Same-day Terms.  (Same day terms could occur on different
003500150922      *   days)
003600151023    ? *-------------------------------------------------------------------------
003700151023      * 10/23/2015  Antwerpen Automotive: Division Code is based on Cost Center
003800151023      *             Code.
003900151102      * 11/02/2015  FEI.Com: Need to create VOLADD Logic
004000160121      * 01/21/2016  Omni Technoligies Needs to Pass the Voluntary Life Coverage
004100160121      *       If A group needs this blank, we will have to add another field
004200160121      *       in the Transmission File.  (GuarTranp)
004300160127      * 01/27/2016  Not All Married Members have a Married Date.  Now using
004400160127      *       F.Depend and searching for RHU or RWI
004500160309      * 03/09/2016  Need an adjustment for VOLLIF Plans. If a Member adds VOLLIF
004600160309      *       for a Spouse or Child, the coverage level stays as 'IN' for the
004700160309      *       member.  This fix would read through the Work file and update
004800160309      *       all coverage level for VOLLIF.      ModID: Br01
004900160620      * 06/20/2016  Setup Division Override based on Plan ID.  ModID: br02
005000160621      * 06/21/2016  Setup Override Database.                   ModID: br03
005100160701      * 07/01/2016  New Guardian Plan Type: Accident           ModID: br04
005200160804      * 08/04/2016  Added a validation:  If the effective date of the plan
005300160804      * Mod: br05   occurs before the plan starts, use the plan start date.
005400160915      * 09/15/2016  Added the PCP for Dental.                  ModID: br06
005500161108      * 11/08/2016  B.Rees                                     ModID: br07
005600161108      *   Medi Rents & Sales:  Their Voluntary Life and Voluntary AD&D
005700161108      *   had to be broken down by EMP, SPO or CHD.  I created a new
005800161108      *   function that will receive the Plan Category (PlnCat) description
005900161108      *   and set the Coverage Level based on that description.
006000170123      * 01/23/2017  B.Rees                                     ModID: br08
006100170123      *   Added HOSP as a plan type...
006200170215      * 02/15/2017  B.Rees                                     ModID: br09
006300170215      *   Programmed for Dependent Life...
006400170316      * 03/16/2017  B.Rees                                     ModID: br10
006500170316      *   Check the History Record for BOR...
006600170623      * 06/23/2017  B.Rees                                     ModID: br11
006700170623      *   Added CRITIL as a plan type...
006800170623      * 06/23/2017  B.Rees                                     ModID: br12
006900170623      *   Added VOLCRIT as a plan type...
007000180418      * 03/08/2018  B.Rees                                     ModID: br13
007100180308      *   Use Cost Center to generate Division Code.
007200180418      * 04/18/2018  B.Rees                                     ModID: br14
007300180418      *   New Variable in GuartranpL BlankVLVO ( Blank Voluntary
007400180418      *   Volume Election )
007500180529      * 05/29/2018  B.Rees
007600180529      *   Changed Check_Bor Logic to check for an effective Date.
007700180911      * 09/11/2018  J. Torres                                  ModID: jt01
007800180911      *   Added call to new send/not send program that maintains new file
007900190506      *
008000181012      * 10/10/2018  B.Rees  Added a DNS field ( Do Not Send )
008100181012      *   Field being used: CARPLNP ( CPCID9, CPTXT9 )
008200181012      *
008300190506      *
008400190506      * 05/06/2019  B.Rees  Update Class Date using the plan effective
008500190506      *  ModOD: br15        date.
008600190506      *
008700190523      *
008800190523      * 05/23/2019  B.Rees  New Field: Effective Date Override
008900190523      *  ModOD: br16
009000190523      *
009100190708      *
009200190708      * 07/08/2019  B.Rees                                     ModID: br17
009300190708      *   COBRA should continue sending terms.
009400191021      *
009500191021      * 10/21/2019  B.Rees                                     ModID: br18
009600191021      *   When assigning a class, update the class effective date.
009700191216      *
009800191216      * 12/16/2019  B.Rees                                     ModID: br19
009900191216      *   Added Department Override.  CPCID7
010000200604      *
010100200604      * 06/04/2020  B.Rees                                     ModID: br20
010200200604      *   Grab the salary change date from the history file.  Instead of
010300200604      *   using the current date.
010400200610      *
010500200610      * 06/10/2020  B.Rees
010600200610      *   Removed the Check for member Cancel Date matching dependent
010700200610      *   cancel date in $DependCovg Routine
010800200610      *
010900200610      * 06/10/2020 B.Rees                                     ModID: br21
011000200610      *  New Field: created for PT Network: Cst2Dept.
011100200610      *  If this is set to "Y", retrieve the member cost center from
011200200610      *  the member file and retrieve the first 8 charactes from the
011300200610      *  full description.
011400200610      *
011500200610      * 06/10/2020 B.Rees                                     ModID: br22
011600200610      *  Changed the COSTCNTR code for the Department to be table based.
011700200610      *  New Table: GUARDEPXP
011800200610      *  This Appends change: BR13
011900200610      *
012000200630      * 06/30/2020  B.Rees                                    ModID: br23
012100200630      *   Added CANCER  as a plan type...
012200200701      *
012300200701      * 07/01/2020  B.Rees                                    ModID: br24
012400200701      *   New Department Override: State Code.
012500220222      * 02/22/2022  B.Rees
012600220222      *   Added CLASS Override
012700220224      * 02/24/2022  B.Rees   Added Life Vol Election Flag to DepLIF
012800220224      *  NOTE:  In the future, if we need to hide LIFE VOL and SHOW DEP LIF
012900220224      *         VOL, we would need to add a field to GUARTRANP.
013000221024      * 10/24/2022  RLJ      Chg'd test for LIFVOLELEC from "= 'N'" to
013100221024      *         "<> 'Y'" to include ' ' or 'N'.
013200221101      * 10/31/2022  RLJ      Chg'd test for ADDVOLELEC from "= 'N'" to
013300221101      *         "<> 'Y'" to include ' ' or 'N'. Also STD and LTDVOLELEC
013400221103      * 11/17/2022  JT       Do nt subtract 1 day if enroll/cancel date are the same.
013500221201      * 11/29/2022  RLJ      Chg'd all non-voluntary volumes to be blank
013600221201      *         except for STD which is controlled by STDVOLELEC. Voluntary
013700221201      *         plan volumes are controlled by the xxxVOLELEC setting.
013800230517      * 05/17/2023  RLJ      Do not check for proper Plan Cat for Vol
013900230517      *         Crit Ill plans - per Candace.
014000240213      * 02.13.2024  JVA      Include CRTILLELEC Critical Illness - J001     the same.
014100240213      * 02.13.2024  JVA      Include CRTVOLELEC VOL Critical Illness - J001 the same.
014200150515    ? *-------------------------------------------------------------------------
014300150817     FCarAccp   if   e           k disk
014400150818     FCarPlnp   if   e           k disk
014500150904     FGuarTranp if   e           k disk                                         Guardian Transmit
014600150818     F
014700151027     FPlnMst    if   e           k disk    ExtDesc('F.PLNMST')
014800151027     F                                     ExtFile(*extdesc)
014900160105     FGuar011wf o  a e           k disk    UsrOpn                               Header Record
015000151215     FGuar012wf uf a e           k disk    UsrOpn
015100151215     FGuar013wf o  a e           k disk    UsrOpn                               Footer Record
015200151215     FGuar014wf uf a e           k disk    UsrOpn
015300150914     FMCovc15   if   e           k disk    ExtDesc('F.MCOVC15')
015400150914     F                                     ExtFile(*extdesc)
015500150914     F                                     Rename(MCovr : Rcd1)
015600160127     FDepend    if   e           k disk    ExtDesc('F.DEPEND')
015700160127     F                                     ExtFile(*extdesc)
015800160309br01 FGuar012lf uf   e           k disk    UsrOpn  Rename(gf012f : Rcd2)
015900160621br01 FGuarOvrdp if   e           k disk
016000160804br05 Fcmct14    if   e           k disk    ExtDesc('F.CMCT14')
016100160804br05 F                                     ExtFile(*extdesc)
016200160915br06 FPcpl1     if   e           k disk    ExtDesc('F.PCPL1') ExtFile(*extdesc)
016300161108br07 FCodesL1   if   e           k disk    ExtDesc('F.CODESL1')
016400161108br07 F                                     ExtFile(*extdesc)
016500180529       dcl-f HistAA Keyed
016600180529         ExtDesc('F.HISTAA') extFile(*ExtDesc);
016700180529
016800200610br22   dcl-f GuarDepxp keyed;
016900200610
017000200610
017100150515    ? *-------------------------------------------------------------------------
017200150515    ? * Program status data structure
017300150515    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
017400150515     D  @pgmq            *proc
017500150515
017600150713     d SqlStmt         s           1000a   inz
017700150818     d SqlStmt2        s           1000a   inz
017800150821     d SqlStmt3        s           1000a   inz
017900150821     d SqlStmt4        s           1000a   inz
018000150821
018100150817     d UniqueID        s             10a
018200150818     D q               c                   Const('''')
018300150818     d @Date           s               d   DatFmt(*iso)
018400150818     d ZipCode         s              9a   inz
018500170316br10 d BorKey          s             10
018600170316br10 d BorCount        s              5s 0
018700170316
018800150821     d EnrollDt        s              8s 0 inz
018900150821     d CancelDt        s              8s 0 inz
019000150824     d TermDate        s              8s 0 inz
019100150821     d WriteData       s              1    inz
019200150821     d PlanId          s              4    inz
019300150826     d #Sal            s             11S 0 inz
019400150914     d RecordType      s             10a   inz
019500150915     d SaveCovTp       s              3a   inz
019600160309br01 d has_VolLif      s              1a   inz
019700160309br01 d has_Emp         s              1a   inz
019800160309br01 d has_Esp         s              1a   inz
019900160309br01 d has_Ech         s              1a   inz
020000160309br01 d has_Fam         s              1a   inz
020100160309br01 d New_Covg        s              3a   inz
020200160309
020300150824     D*--------------------------------------------------
020400150824     D*?Saved Termed Accounts.
020500150824     D*--------------------------------------------------
020600150824     D TermRcd         ds                  Qualified Dim(5000)
020700150824     D   ssno                         9s 0
020800150824     D   Depno                        2s 0
020900150824     D   TermDt                       8s 0
021000150824     D   Plan                         4a
021100150824     D   Covtp                        3a
021200150824     D   Trst                         3s 0
021300150824     D   Sub#                         3s 0
021400150824     D   Acct                         4s 0
021500150824     D   TransDt                      8s 0
021600150824     D   Cid1                        10
021700150824     D   Process                      1
021800150824     d wni             s              4s 0 inz
021900150824     d wnj             s              4s 0 inz
022000150824
022100150821     d*--------------------------------------------------
022200150821     d*?Data Structures.
022300150821     d*--------------------------------------------------
022400150819     d Sq_mCovmPln   e ds                  extname('MCOVMPLN')
022500150915     d Sq_MemAc#1      ds
022600150915     d  mbSsno                        9s 0
022700150915     d  mlName                       18
022800150915     d  mfName                       12
022900150915     d  mmi                           1
023000150915     d  Addr1                        30
023100150915     d  Addr2                        30
023200150915     d  City                         15
023300150915     d  State                         2
023400150915     d  Zip                           9  0
023500150915     d  Area                          3  0
023600150915     d  phone                         7  0
023700150915     d  Sex                           1
023800150915     d  mbTrst                        3s 0
023900150915     d  mbSub#                        3s 0
024000150915     d  mbAcct                        4s 0
024100150915     d  EmpSt                         1
024200150915     d  Salary                        9  0
024300150915     d  TermDt                        8s 0
024400150915     d  Birth                         8s 0
024500150915     d  marDt                         8s 0
024600150915     d  EmpDt                         8s 0
024700151023     d  ccFlg                         3a
024800160128     d  cExpDt                        8s 0
024900200929     d  qedt                          8s 0
025000201123     d  Fill66                       66a
025100150915
025200150915     d Sq_DCovc        ds
025300150915     d  ssno                          9s 0
025400150930     d  dSeq#                         2s 0
025500150915     d  dvPlan                        4
025600150915     d  dEnrdT                        8s 0
025700150921     d  cCanDt                        8s 0
025800150915     d  dCovTp                        3a
025900200721     d  wbenamt                       7s 0
026000150915
026100150821     d Sq_Depndc       ds
026200150821     d  dssno                         9s 0
026300150821     d  dpSeq#                        2s 0
026400150821     d  dlName                       18a
026500150821     d  dfName                       12a
026600150821     d  dmi                           1a
026700150821     d  dAddr1                       30a
026800150821     d  dAddr2                       30a
026900150821     d  dCity                        15a
027000150821     d  dState                        2a
027100150821     d  dZip                          9  0
027200150821     d  dArea                         3  0
027300150821     d  dPhone                        7  0
027400150821     d  dSex                          1
027500150821     d  dRelCd                        3
027600150821     d  dBirth                        8s 0
027700150821     d  depss#                        9  0
027800150821     d  dHndcp                        1
027900150821     d  dStudn                        1
028000150821
028100150821
028200150929     d*?Saved Plans
028300150929     d DenPlan         s              4
028400150929     d ADDPlan         s              4
028500150929     d LTDPlan         s              4
028600150929     d LifePlan        s              4
028700150929     d VisPlan         s              4
028800150929     d VolLifPlan      s              4
028900150929     d STDPlan         s              4
029000150929     d VolLTDPlan      s              4
029100151102     d VolAddPlan      s              4
029200160701br04 d AccPlan         s              4
029300150929
029400150929     d*?Saved Date
029500150929     d OrigDate        s              8s 0
029600150929     d DenDate         s              8s 0
029700150929     d ADDDate         s              8s 0
029800150929     d LTDDate         s              8s 0
029900150929     d LifeDate        s              8s 0
030000150929     d VisDate         s              8s 0
030100150929     d VolLifDate      s              8s 0
030200150929     d STDDate         s              8s 0
030300150929     d VolLTDDate      s              8s 0
030400151102     d VolAddDate      s              8s 0
030500160701br04 d AccDate         s              8s 0
030600150929
030700150929     d*?Saved Coverage Type
030800150929     d DenCovTp        s              3
030900150929     d ADDCovTp        s              3
031000150929     d LTDCovTp        s              3
031100150929     d LifeCovTp       s              3
031200150929     d VisCovTp        s              3
031300150929     d VolLifCovTp     s              3
031400150929     d STDCovTp        s              3
031500150929     d VolLTDCovTp     s              3
031600151102     d VolAddCovTp     s              3
031700160701br04 d AccCovTp        s              3
031800170123br08 d HosCovTp        s              3
031900170123br08 d HosDate         s              8s 0
032000170123br08 d HosPlan         s              4
032100170215br09 d DLifCovTp       s              3
032200170215br09 d DLifDate        s              8s 0
032300170215br09 d DLifPlan        s              4
032400170623br11 d CritCovTp       s              3
032500170623br11 d CritDate        s              8s 0
032600170623br11 d CritPlan        s              4
032700170623br12 d VCritCovTp      s              3
032800170623br12 d VCritDate       s              8s 0
032900170623br12 d VCritPlan       s              4
033000200630
033100200630br23 d CancCovTp       s              3
033200200630br23 d CancDate        s              8s 0
033300200630br23 d CancPlan        s              4
033400150929
033500150929     d Continue        s              1
033600150930     d Dep#            s              2s 0
033700151215     d RcdCount        s             10s 0 inz
033800151221     d FileCreate      s              1
033900180911     d incarrier       s              2  0
034000180911     d ioption         s              1
034100150929
034200150821     d*--------------------------------------------------
034300150821     d*?Procedures  - Created at the end of the program.
034400150821     d*--------------------------------------------------
034500150818     d #GetCovgLvl     pr             3a
034600150818     d   DataIn                       3a   value
034700150821
034800170216     d #GetDLCovgLvl   pr             3a
034900170216     d   DataIn                       3a   value
035000170216
035100150821     d #GetRelCode     pr             2a
035200150821     d   DataIn                       3a   value
035300151023
035400151023     d #GetDivCode     pr             4a
035500151023     d   DataIn                       3a   value
035600150818
035700161108br07 d #GetVol_Lvl     pr             3a
035800161108br07 d   inTrst                       3s 0 value
035900161108br07 d   inSub#                       3s 0 value
036000161108br07 d   inPlan                       4a   value
036100161108
036200180911jt01 d dltadd          pr                  ExtPgm('TROFF3')
036300180911  ¦  d  catrst                        3  0
036400180911  ¦  d  casub#                        3  0
036500180911  ¦  d  caacct                        4  0
036600180911  ¦  d  incarrier                     2  0
036700180911jt01 d  ioption                       1
036800180911
036900200604br20   dcl-s Emp_Key Char(10);
037000200604
037100200604      *-------------------------------------------------------------------------
037200150713
037300150713
037400200604      *-------------------------------------------------------------------------
037500200604      *
037600200604      * Mainline Program
037700200604      *
037800200604      *-------------------------------------------------------------------------
037900150817     C     *entry        plist
038000150817     C                   parm                    UniqueID
038100151221     C                   parm                    FileCreate
038200160119     C                   parm                    FileType          1
038300150817
038400150515      /Free
038500201103       Exec Sql
038600201103         Set Option Commit = *NONE, Naming = *SYS;
038700151214
038800191216       Exsr $OpenFiles;
038900191216       wni = 0;
039000191216       RcdCount = 0;
039100150824
039200191216       Setll UniqueId CarAccp;
039300191216       dou %Eof(CarAccp);
039400150817
039500191216         Reade UniqueId CarAccp;
039600191216         if %Eof(CarAccp);
039700191216           Leave;
039800191216         endif;
039900150904
040000201110          if caStatus = 'N' and FileType = 'P';
040100201103            iter;
040200201103          EndIf;
040300201103
040400191216br10     Exsr Check_BOR;
040500191216         if BorCount > 0;
040600191216           iter;
040700191216         endif;
040800170316
040900170316
041000191216         // Get supplemental Data..
041100191216         chain (caUniq : caTrst : caSub# : caAcct) GuarTranp;
041200150904
041300150904
041400191216         //?Get Member Data
041500191216         Exsr $MemberData;
041600150817
041700191216       enddo;
041800191216       exsr $ProcessTerms;
041900150824
042000191216       exsr $HeaderRcd;
042100191216       exsr $FooterRcd;
042200191216       exsr $CloseFiles;
042300151221
042400191216       FileCreate = 'N';
042500191216       if RcdCount > 0;
042600191216         FileCreate = 'Y';
042700191216       endif;
042800151215
042900151215
043000191216       *inlr = *on;
043100150817
043200191216       //--------------------------------------------------------------------
043300191216       Begsr $MemberData;
043400150817
043500191216         //?Use SQL to only select the Member that has/had Guardian Coverage.
043600191216         //  This SQL uses?Where IN?Sql statements instead of Joins. This will
043700191216         //  only return the data in F.MemAc#1 instead of all data that would
043800191216         //  be been returned with a join.
043900191216         //------------------------------------------------------------------
044000191216         // SQL Statement Example
044100191216         //   Select  * from "F.MEMAC#1"
044200191216         //    Where mbssno in
044300191216         //     (?Select Distinct mcssno from mCovmPln where mcPlan in
044400191216         //         (?Select cpPlan from CarPlnp where cpUniq = '0000000130')
044500191216         //      ?and mcssno not in (
044600191216         //           ?Select Distinct ntssno from Guar014wf where
044700191216         //           ?ntTrst = mbTrst and ntSub# = mbSub# and ntAcct = mbAcct
044800191216         //           ?ntPlan = mcPlan   and ntDepno = 0)
044900191216         //     and mbTrst = 590 and mbSub# = 6 and mbAcct = 15
045000191216         //     order by mbssno
045100191216         //------------------------------------------------------------------
045200191216         SqlStmt =
045300191216           'Select ' +
045400191216           '  mbSsno, mlName, mfName, mmi, Addr1,   '  +
045500191216           '  Addr2, City, State, Zip, Area, phone, '  +
045600191216           '  Sex, mbTrst, mbSub#, mbAcct, EmpSt,   '  +
045700191216           '  Salary, TermDt, Birth, marDt, EmpDt,  '  +
045800201123           '  ccFlg, cexpdt, qedt,Fill66 '             +
045900191216           '  From "F.MEMAC#1" '  +
046000191216           '   Where mbssno in '         +
046100191216           '    ( Select Distinct mcssno from mCovmPln where mcPlan in ' +
046200191216           '      ( Select cpPlan from CarPlnp where cpUniq = ' +
046300191216                     q + %Trim(UniqueID) + q + ') ' +
046400191216           '      and mcssno not in ( ' +
046500191216           '           Select Distinct ntssno from Guar014wf where ' +
046600191216           '           ntTrst = mbTrst and ntSub# = mbSub# ' +
046700191216           '           and ntDepno = 0 ' +
046800191216           '           and ntAcct = mbAcct  ' +
046900191216           '           and candt = ntTermDt ' +
047000191216           '           and ntPlan = mcPlan ) ) ' +
047100191216           '    and mbTrst = ' +  %Char(caTrst) +
047200191216           '    and mbSub# = ' +  %Char(caSub#) +
047300191216           '    and mbAcct = ' +  %Char(caAcct) +
047400191216           '    Order by mbssno ' ;
047500150818
047600201103         Exec Sql
047700201103           Declare C1 Cursor For Sqlstmt;
047800201103         Exec Sql
047900201103           Prepare Sqlstmt From :Sqlstmt;
048000201103         Exec Sql
048100201103           Open C1;
048200150818
048300191216         dou SqlCod <> *Zero;
048400201103           Exec Sql
048500201103             Fetch Next From C1
048600201103               Into :Sq_MemAc#1;
048700150818
048800191216           if SqlCod <> *zero;
048900191216             leave;
049000191216           endif;
049100150818
049200191216           //?Get Member Data
049300191216           exsr $MemberRcd;
049400150818
049500150818
049600191216           //?Loop throu the Member Coverages.
049700191216           exsr $MemberCoverage;
049800150929
049900150929
050000191216           //?Verify that the plans are not
050100191216           //?in the TERM file.
050200191216           Dep# = 0;
050300191216           exsr $CheckTerm;
050400191216           if Continue = 'N';
050500191216             exsr $ClearCovg;
050600191216             iter;
050700191216           endif;
050800150929
050900191216           RcdCount = RcdCount + 1;
051000191216           Write  gf012f;
051100150929
051200150820
051300191216           //?Get Any Dependents
051400191216           exsr $ProcessDepnd;
051500191216           exsr $ClearCovg;
051600150818
051700191216         enddo;
051800201103         Exec Sql
051900201103           Close C1;
052000150818
052100150818
052200191216       EndSr;
052300191216       //--------------------------------------------------------------------
052400191216       Begsr $MemberCoverage;
052500150818
052600191216         //------------------------------------------------------------------
052700191216         //?Use SQL to only select the Guardian Coverages.
052800191216         //------------------------------------------------------------------
052900191216         //?We are printing the record on 1 line. We will process the results
053000191216         //?from the SQL and write the record when completed.
053100191216         //------------------------------------------------------------------
053200191216         // SQL Statement Example
053300191216         //   Select * from mCovmPln where mcPlan in
053400191216         //     (?Select cpPlan from CarPlnp where cpUniq = '0000000130')
053500191216         //   and mcTrst = 590 and mcSub# = 6
053600191216         //   and Acc# = 15  and mcssno = 19481872
053700191216         //------------------------------------------------------------------
053800191216         SqlStmt2 =
053900191216           'Select * from mCovmPln where mcPlan in ' +
054000191216           '  ( Select cpPlan from CarPlnp where cpUniq = ' +
054100191216                     q + %Trim(UniqueID) + q + ') ' +
054200191216           '    and mcTrst = ' +  %Char(mbTrst) +
054300191216           '    and mcSub# = ' +  %Char(mbSub#) +
054400191216           '    and Acc# = ' +  %Char(mbAcct) +
054500191216           '    and mcssno = ' +  %Char(mbssno)  ;
054600150917
054700201103         Exec Sql
054800201103           Declare C2 Cursor For Sqlstmt2;
054900201103         Exec Sql
055000201103           Prepare Sqlstmt2 From :Sqlstmt2;
055100201103         Exec Sql
055200201103           Open C2;
055300150818
055400191216         dou SqlCod <> *Zero;
055500201103           Exec Sql
055600201103             Fetch Next From C2
055700201103               Into :Sq_Mcovmpln;
055800150818
055900191216           if SqlCod <> *zero;
056000191216             leave;
056100191216           endif;
056200150818
056300150918
056400191216           //?Process Coverages
056500191216           chain (UniqueId : mcTrst : mcSub# :
056600191216                      acc# : ' ' : mcPlan) CarPlnp;
056700150821
056800191216           //?Do Not Send...
056900191216           if cpcid9 = 'Y';
057000191216             iter;
057100191216           endif;
057200181010
057300191216br02       //?Check for Division Override.
057400191216           if   cpCid5 > '' and CanDt = 0;
057500191216             g2Divn = cpCid5;
057600191216           endif;
057700150821
057800191216
057900191216           //?Replace Division with a cancelled plan only
058000191216           //?if the division code is blank.
058100191216           if cpCid5 > '' and CanDt > 0 and g2Divn = '';
058200191216             g2Divn = cpCid5;
058300191216           endif;
058400160906
058500191216           EnrollDt = EnrlDt;
058600191216           CancelDt = CanDt;
058700191216           TermDate = CanDt;
058800191216           dpSeq# = 0;                          // Initialize the Dependent Seq#
058900191216           PlanId = mcPlan;
059000150821
059100191216           RecordType = 'Member';
059200191216           exsr $CoverageRcd;
059300150818
059400191216         enddo;
059500201103         Exec Sql
059600201103           Close C2;
059700150820
059800150818
059900150818
060000191216       EndSr;
060100191216       //--------------------------------------------------------------------
060200191216       Begsr $MemberRcd;
060300150818
060400191216         Clear Gf012f;
060500150818
060600191216         // Dft01 = 'D';                            // Detail Record
060700191216         g2Edi = 'E';                            // Employee
060800191216         g2Ssn = %Editc(mbssno:'X');
060900191216         g2gnbr = caCid2;                        // Group Number
061000150818
061100191216         g2eSts = 'FT';                          // Full Time
061200191216         g2cSts = 'A';                           // Active
061300191216         g2cbra = *BLANKS;                       // Cobra
061400150818
061500191216         Select;
061600191216         When EmpSt = 'R';
061700191216           g2eSts = 'RT';
061800191216         When EmpSt = 'C';
061900191216           g2eSts = 'FT';
062000191216           g2cSts = 'C';
062100191216           g2cbra = 'Y';
062200191216         Endsl;
062300150818
062400191216         if caCid4 = 'N/A';
062500191216           caCid4 = *blanks;
062600191216         endif;
062700151023
062800191216         g2Clas = caCid4;                        // Class
062900220222
063000220222         //?Check Override Database.
063100220222         g2Clas = #CheckOverRide('CLASS': g2clas);
063200220222
063300191216         //?Division
063400191216         g2Divn = caCid5;
063500160620
063600160620
063700191216         if UseCstCntr = 'Y';
063800191216           g2Divn = #GetDivCode(ccFlg);
063900191216         endif;
064000151023
064100191216         //?Check Override Database.
064200191216         g2Divn = #CheckOverRide('DIVISION': g2Divn);
064300160621
064400160621
064500160621
064600191216         g2Dept = caCid6;                        // Department code
064700150818
064800191216br19     //?Check for Department Override.
064900191216         if   cpCid7 > '' and CanDt = 0;
065000191216           g2Dept = cpCid7;
065100191216         endif;
065200191216
065300191216
065400191216br19     //?Replace Division with a cancelled plan only
065500191216         //?if the division code is blank.
065600191216         if cpCid7 > '' and CanDt > 0 and g2Dept = '';
065700191216           g2Dept = cpCid7;
065800191216         endif;
065900191216
066000191216
066100200610br21     if Cst2Dept = 'Y';
066200200610           g2Dept = '';
066300200610           chain ccFlg CodesL1;
066400200610           if %Found( Codesl1 );
066500200610             g2Dept = %Subst( lDescr : 1 : 8 );
066600200610           EndIf;
066700200610         EndIf;
066800200610
066900200610
067000191216br13     if g2Dept = 'COSTCNTR';
067100180308
067200200929           g2Dept = '';
067300200929           chain ccflg GuarDepxp;
067400200929           if %Found (GuarDepxp );
067500200929             g2Dept = GDDEPT;
067600200929           EndIf;
067700200610
067800200610
067900191216         endif;
068000180308
068100200701br24     if g2Dept = 'STATECOD';
068200200701
068300200929           g2Dept = State;
068400200701
068500200701         endif;
068600200701
068700180308
068800180308
068900191216         if EmpDt < AcctStrDt;
069000191216           g2Cled = %Char(AcctStrDt);           // Class Effective Date
069100191216           g2Dved = %Char(AcctStrDt);           // Division Effective Date
069200191216         else;
069300191216           g2Cled = %Char(EmpDt);
069400191216           g2Dved = %Char(EmpDt);
069500191216         endif;
069600150818
069700191216         g2Hire = %Char(EmpDt);                 // Hire Date
069800150818
069900191216         //?If Cobra, Set the TermDt to be the Cobra
070000191216         //?Expiration Date.   1/28/2016  Adfero
070100200929         //
070200200929         //  New Logic.  9/29/2020
070300200929         // If COBRA, the Term Date should be 1 day
070400200929         // before the QE Date.
070500191216         if g2cbra = 'Y' and termDt = 0;
070600200929
070700201103           TermDt = cExpDt;
070800200929
070900201103         // Add this when Cindy Approves.
071000201103         //    if qedt > 0;
071100201103         //      @Date = %Date(qeDt:*Iso);
071200201103         //      @Date = @Date - %Days(1);
071300201103         //      TermDt = %Char(%Dec(@Date));
071400201103         //    EndIf;
071500200929
071600191216         endif;
071700160128
071800200929
071900191216         // Term Date
072000191216         if TermDt = 0;
072100191216           g2eTrm = *Blanks;
072200191216         else;
072300191216           @Date = %Date(TermDt:*Iso);
072400191216           if %SubDt(@Date : *Days) = 1;
072500191216             @Date = @Date - %Days(1);
072600191216           endif;
072700191216           g2eTrm = %Char(%Dec(@Date));
072800191216         endif;
072900150818
073000191216         g2Last = %Trim(mLName);                 // Name
073100191216         g2First = mFName;
073200191216         g2Mid  = mmi;
073300150818
073400191216         g2hPhn = *Blanks;                       // Phone
073500191216         if phone > 0;
073600191216           g2hPhn = %editc(Area:'X') + %Char(Phone);
073700191216         endif;
073800150818
073900191216         g2Ad1 = Addr1;                          // Address
074000191216         g2Ad2 = Addr2;
074100201123         g2Email = %Subst(Fill66:1:50);
074200191216         g2City = City;
074300191216         g2St  = State;
074400191216         ZipCode = %Editc(Zip:'X');
074500191216         g2Zip = %Subst(ZipCode:1:5);
074600150818
074700191216         g2dob = %Char(Birth);
074800191216         g2Sex = Sex;
074900191216         g2Rel = 'SE';                           // Relationship Code
075000191216         // SE = Self
075100191216         g2ms = 'S';                             // Marriage
075200160127
075300191216         //?Check for Married Code.
075400191216         setll mbssno Depend;
075500191216         dou %eof(Depend);
075600191216           reade mbssno Depend;
075700191216           if %eof(Depend);
075800191216             leave;
075900191216           endif;
076000191216           if dRelCd = 'RHU' or
076100191216              dRelCd = 'RWI';
076200191216             g2ms = 'M';
076300191216           endif;
076400191216         enddo;
076500160127
076600191216         //?Check Marriage Date
076700191216         if marDt > 0;
076800191216           g2ms = 'M';
076900191216         endif;
077000150818
077100191216         //?Show Salary Information
077200191216         if ShowSalary = 'Y' ;
077300191216           g2Sal = '000';
077400150826
077500191216           #Sal = Salary * 100;
077600191216           if #Sal > 0;
077700191216             g2Sal = %Trim(%Char(#Sal));
077800191216           endif;
077900150826
078000191216           g2Samf = 'A';
078100200604
078200200604           g2saed = %Char(%Dec(%Date));        // Default with todays date.
078300200610br20       Exsr Get_SalChgDt;
078400200604
078500191216           g2Hours = '40.0';
078600191216         endif;
078700150826
078800191216br01     has_VolLif = 'N';
078900160309
079000191216       EndSr;
079100191216       //--------------------------------------------------------------------
079200191216       Begsr $CoverageRcd;
079300150818
079400191216         //?Adjust the Cancellation Date.
079500191216         OrigDate = *Zeros;
079600191216         if CancelDt > 0;
079700191216           OrigDate = CancelDt;
079800191216           @Date = %Date(CancelDt:*Iso);
079900191216           if %SubDt(@Date : *Days) = 1;
080000191216             @Date = @Date - %Days(1);
080100191216             CancelDt = %Dec(@Date);
080200160804
080300191216             //?Br05  8/4/2016
080400191216             //?If the adjusted cancel date is prior to the
080500191216             //?plans effective date, use the original Date.
080600191216             chain ( mcTrst : mcSub# : acc# : PlanID ) Cmct14;
080700191216             if %Found(cmct14);
080800191216               if effdat > CancelDt;
080900191216                 CancelDt = OrigDate;
081000191216               endif;
081100191216             endif;
081200160804
081300191216           endif;
081400191021
081500191216         endif;
081600150820
081700191216         if cpcid2 = 'N/A';
081800191216           cpcid2 = *Blanks;
081900191216         endif;
082000151023
082100191216         if cpcid3 = 'N/A';
082200191216           cpcid3 = *Blanks;
082300191216         endif;
082400151113
082500191216         Select;
082600191216         //----------------------------------------------------------------
082700191216         //?                          Dental
082800191216         //----------------------------------------------------------------
082900191216         When cpCid1 = 'DEN';
083000150820
083100191216           //?Skip processed Records
083200191216           if g2Dnd > *Blanks;
083300150820
083400191216             //?Already has an Active Record.
083500191216             if g2Dned = *Blanks;
083600191216               leavesr;
083700191216             endif;
083800150820
083900191216             //?Already processed a Newer Record.
084000191216             if %Dec(g2Dned:8:0) > CancelDt and
084100191216              CancelDt > 0;
084200191216               leavesr;
084300191216             endif;
084400191216           endif;
084500150820
084600191216           if RecordType = 'Member';
084700191216             SaveCovTp = mCovTp;
084800191216           else;
084900191216             SaveCovTp = dCovTp;
085000191216           endif;
085100150915
085200191216           //?Override the Class.. If Needed.
085300191216           exsr $Check_Class;
085400150917
085500221103           DenCovTp = #GetCovgLvl(SaveCovTp);
085600191216           DenDate = OrigDate;
085700191216           DenPlan = PlanId;
085800150929
085900191216           g2Dnd = cpCid1;                      // Dental Election
086000191216           g2Dncd = cpCid2;                     // Coverage Desc
086100161020
086200161020
086300191216           F006 = *Blanks;
086400191216           if %Subst(g2dncd:1:3) = 'HMO';
086500191216             chain ( mbssno: dpSeq#: 'DEN') pcpl1;
086600191216             if %Found(pcpl1);
086700191216               F006 = pcid#;
086800191216             endif;
086900191216           endif;
087000160915
087100191216           g2Dncl = #GetCovgLvl(SaveCovTp);     // Coverage Level
087200191216           g2dnbd = %Char(EnrollDt);
087300190523
087400191216
087500191216           // Effective Date Override
087600191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
087700191216 |           g2dnbd = cpcid6;
087800191216br16       endif;
087900190523
088000190523
088100191216           g2dned = %Char(CancelDt);
088200191216           if CancelDt = 0 or CancelDt = 99999999;
088300191216             g2dned = *Blanks;
088400191216             exsr $ClearArray;
088500191216           else;
088600191216             exsr $RemoveRcd;
088700191216           endif;
088800150818
088900221123           if CancelDt > 0;
089000221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
089100221103            g2dned = g2dnbd;
089200221103           endif;
089300221123           endif;
089400150818
089500150904
089600191216         //----------------------------------------------------------------
089700191216         //?                      ADD
089800191216         //----------------------------------------------------------------
089900191216         When cpCid1 = 'ADD';
090000150917
090100191216           //?Skip processed Records
090200191216           if g2bad > *Blanks;
090300150917
090400191216             //?Already has an Active Record.
090500191216             if g2Baed = *Blanks;
090600191216               leavesr;
090700191216             endif;
090800150917
090900191216             //?Already processed a Newer Record.
091000191216             if %Dec(g2Baed:8:0) > CancelDt and
091100191216              CancelDt > 0;
091200191216               leavesr;
091300191216             endif;
091400191216           endif;
091500150917
091600191216           if RecordType = 'Member';
091700191216             SaveCovTp = mCovTp;
091800191216           else;
091900191216             SaveCovTp = dCovTp;
092000191216           endif;
092100150917
092200191216           //?Override the Class.. If Needed.
092300191216           exsr $Check_Class;
092400150917
092500191216           AddCovTp = #GetCovgLvl(SaveCovTp);
092600191216           AddDate = OrigDate;
092700191216           ADDPlan = PlanId;
092800150929
092900191216           g2bad = cpCid1;                      // Dental Election
093000191216           g2bacd = cpCid2;                     // Coverage Desc
093100191216           g2bacl = #GetCovgLvl(SaveCovTp);     // Coverage Level
093200150929
093300221128           g2Bavo = '';
093400150929
093500191216           g2babd = %Char(EnrollDt);
093600190523
093700191216           // Effective Date Override
093800191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
093900191216 |           g2babd = cpcid6;
094000191216br16       endif;
094100190523
094200191216           g2baed = %Char(CancelDt);
094300191216           if CancelDt = 0 or CancelDt = 99999999;
094400191216             g2baed = *Blanks;
094500191216             exsr $ClearArray;
094600191216           else;
094700191216             exsr $RemoveRcd;
094800191216           endif;
094900150917
095000221123           if CancelDt > 0;
095100221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
095200221103            g2baed = g2babd;
095300221103           endif;
095400221123           endif;
095500150917
095600150917
095700191216         //----------------------------------------------------------------
095800191216         //?                  LTD - Long Term Disability
095900191216         //----------------------------------------------------------------
096000191216         When cpCid1 = 'LTD';
096100150917
096200191216           //?Skip processed Records
096300191216           if g2Ltd > *Blanks;
096400150917
096500191216             //?Already has an Active Record.
096600191216             if g2Lted = *Blanks;
096700191216               leavesr;
096800191216             endif;
096900150917
097000191216             //?Already processed a Newer Record.
097100191216             if %Dec(g2Lted:8:0) > CancelDt and
097200191216              CancelDt > 0;
097300191216               leavesr;
097400191216             endif;
097500191216           endif;
097600150917
097700191216           if RecordType = 'Member';
097800191216             SaveCovTp = mCovTp;
097900191216           else;
098000191216             SaveCovTp = dCovTp;
098100191216           endif;
098200150917
098300191216           //?Override the Class.. If Needed.
098400191216           exsr $Check_Class;
098500150917
098600191216           LtdCovTp = #GetCovgLvl(SaveCovTp);
098700191216           LtdDate = OrigDate;
098800191216           LtdPlan = PlanId;
098900150929
099000191216           g2Ltd = cpCid1;                      // Dental Election
099100191216           g2Ltcd = cpCid2;                     // Coverage Desc
099200191216           g2Ltcl = #GetCovgLvl(SaveCovTp);     // Coverage Level
099300150929
099400221128           g2Ltvo = ' ';
099500150929
099600191216           g2Ltbd = %Char(EnrollDt);
099700190523
099800191216
099900191216           // Effective Date Override
100000191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
100100191216 |           g2ltbd = cpcid6;
100200191216br16       endif;
100300190523
100400191216           g2Lted = %Char(CancelDt);
100500191216           if CancelDt = 0 or CancelDt = 99999999;
100600191216             g2Lted = *Blanks;
100700191216             exsr $ClearArray;
100800191216           else;
100900191216             exsr $RemoveRcd;
101000191216           endif;
101100221103
101200221123           if CancelDt > 0;
101300221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
101400221103            g2lted = g2ltbd;
101500221103           endif;
101600221123           endif;
101700150917
101800150917
101900191216         //----------------------------------------------------------------
102000191216         //?                  LIFE - Basic Life
102100191216         //----------------------------------------------------------------
102200191216         When cpCid1 = 'LIFE';
102300150917
102400191216           //?Skip processed Records
102500191216           if g2bld > *Blanks;
102600150917
102700191216             //?Already has an Active Record.
102800191216             if g2bled = *Blanks;
102900191216               leavesr;
103000191216             endif;
103100150917
103200191216             //?Already processed a Newer Record.
103300191216             if %Dec(g2bled:8:0) > CancelDt and
103400191216              CancelDt > 0;
103500191216               leavesr;
103600191216             endif;
103700191216           endif;
103800150917
103900191216           if RecordType = 'Member';
104000191216             SaveCovTp = mCovTp;
104100191216           else;
104200191216             SaveCovTp = dCovTp;
104300191216           endif;
104400150917
104500191216           //?Override the Class.. If Needed.
104600191216           exsr $Check_Class;
104700150917
104800191216           LifeCovTp = #GetCovgLvl(SaveCovTp);
104900191216           LifeDate = OrigDate;
105000191216           LifePlan = PlanId;
105100150929
105200191216           g2Bld = cpCid1;                      // Dental Election
105300191216           g2Blcd = cpCid2;                     // Coverage Desc
105400191216           g2Blcl = #GetCovgLvl(SaveCovTp);     // Coverage Level
105500150929
105600221128           g2Blvo = ' ';
105700150929
105800191216           g2Blbd = %Char(EnrollDt);
105900190523
106000191216
106100191216           // Effective Date Override
106200191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
106300191216 |           g2blbd = cpcid6;
106400191216br16       endif;
106500190523
106600191216           g2Bled = %Char(CancelDt);
106700191216           if CancelDt = 0 or CancelDt = 99999999;
106800191216             g2Bled = *Blanks;
106900191216             exsr $ClearArray;
107000191216           else;
107100191216             exsr $RemoveRcd;
107200191216           endif;
107300150917
107400221123           if CancelDt > 0;
107500221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
107600221103            g2bled = g2blbd;
107700221103           endif;
107800221123           endif;
107900221103
108000221103
108100150917
108200191216         //----------------------------------------------------------------
108300191216         //?                  VIS - Vision
108400191216         //----------------------------------------------------------------
108500191216         When cpCid1 = 'VIS';
108600150917
108700191216           //?Skip processed Records
108800191216           if g2Vid > *Blanks;
108900150917
109000191216             //?Already has an Active Record.
109100191216             if g2Vied = *Blanks;
109200191216               leavesr;
109300191216             endif;
109400150917
109500191216             //?Already processed a Newer Record.
109600191216             if %Dec(g2Vied:8:0) > CancelDt and
109700191216              CancelDt > 0;
109800191216               leavesr;
109900191216             endif;
110000191216           endif;
110100150917
110200191216           if RecordType = 'Member';
110300191216             SaveCovTp = mCovTp;
110400191216           else;
110500191216             SaveCovTp = dCovTp;
110600191216           endif;
110700150917
110800191216           //?Override the Class.. If Needed.
110900191216           exsr $Check_Class;
111000150917
111100191216           VisCovTp = #GetCovgLvl(SaveCovTp);
111200191216           VisDate = OrigDate;
111300191216           VisPlan = PlanId;
111400191216           g2Vid = cpCid1;                      // Dental Election
111500191216           g2Vicd = cpCid2;                     // Coverage Desc
111600191216           if BlankVicd = 'Y';
111700191216             g2Vicd = *blanks;
111800191216           endif;
111900151023
112000191216           g2Vicl = #GetCovgLvl(SaveCovTp);     // Coverage Level
112100191216           g2Vibd = %Char(EnrollDt);
112200190523
112300191216
112400191216           // Effective Date Override
112500191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
112600191216 |           g2vibd = cpcid6;
112700191216br16       endif;
112800190523
112900191216           g2Vied = %Char(CancelDt);
113000191216           if CancelDt = 0 or CancelDt = 99999999;
113100191216             g2Vied = *Blanks;
113200191216             exsr $ClearArray;
113300191216           else;
113400191216             exsr $RemoveRcd;
113500191216           endif;
113600150917
113700150917
113800221123           if CancelDt > 0;
113900221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
114000221103            g2vied = g2vibd;
114100221103           endif;
114200221123           endif;
114300221123
114400150917
114500191216         //----------------------------------------------------------------
114600191216         //?                  Volunteer Life  VOLLIF
114700191216         //----------------------------------------------------------------
114800191216         When cpCid1 = 'VOLLIF';
114900150904
115000191216           //?Make ure the VOLLIF is for either the
115100191216           //?Member or the Dependent
115200191216           chain ( mcTrst : mcSub# : PlanId ) PlnMst;
115300191216           if RecordType = 'Member' and
115400191216              (PlnCat <> 'PSL' and PlnCat <> 'PLS' and
115500191216               PlnCat <> 'PO4' and PlnCat <> 'PO5' and
115600191216               PlnCat <> 'PS4' and PlnCat <> 'PS5' and
115700191216               PlnCat <> 'PNE') ;
115800191216             leaveSr;
115900191216           endif;
116000151027
116100191216           if RecordType = 'Dependent' and
116200191216               ( PlnCat <> 'PSD' and PlnCat <> 'PSP'  and
116300191216                 PlnCat <> 'PSA');
116400191216             leaveSr;
116500191216           endif;
116600151027
116700151027
116800151027
116900151027
117000151027
117100191216           //?Skip processed Records
117200191216           if g2Sld > *Blanks;
117300160309
117400191216             //?Already has an Active Record.
117500191216             if g2Sled = *Blanks;
117600191216               leavesr;
117700191216             endif;
117800150904
117900191216             //?Already processed a Newer Record.
118000191216             if %Dec(g2Sled:8:0) > %Dec(CancelDt:8:0) and
118100191216              %Dec(CancelDt:8:0) > 0;
118200191216               leavesr;
118300191216             endif;
118400191216           endif;
118500150904
118600200618
118700200618           // If the Record type is Member, but the vol plan
118800200618           // is not... leave.
118900200618           if RecordType = 'Member' and
119000200618               #GetVol_Lvl(mcTrst : mcSub# : PlanId ) <> 'EMP';
119100200929             leavesr;
119200200618           EndIf;
119300200618
119400200618           if RecordType = 'Dependent' and
119500200618               #GetVol_Lvl(mcTrst : mcSub# : PlanId ) = 'EMP';
119600200929             leavesr;
119700200618           EndIf;
119800200618
119900200618
120000191216           //?Get Volumn Election - Benefit Amount
120100191216br01       has_VolLif = 'Y';
120200191216           chain (mcTrst : mcSub# : acc# :
120300191216                  mbssno : PlanID ) mCovc15 ;
120400150914
120500191216           if RecordType = 'Member';
120600191216             SaveCovTp = mCovTp;
120700191216           else;
120800191216             SaveCovTp = dCovTp;
120900191216           //  SaveCovTp = *blanks;
121000191216           endif;
121100150917
121200191216           //?Override the Class.. If Needed.
121300191216           exsr $Check_Class;
121400150915
121500191216           VolLifCovTp = #GetCovgLvl(SaveCovTp);
121600191216           VolLifDate = OrigDate;
121700191216           VolLifPlan = PlanId;
121800150929
121900191216           g2Sld = cpCid1;                      // VolLif Election
122000191216           g2Slcd = cpCid2;                     // Coverage Desc
122100191216br07       // g2slcl = #GetCovgLvl(SaveCovTp);     // Coverage Level
122200191216br07       g2slcl = #GetVol_Lvl(mcTrst : mcSub# : PlanId );     // Coverage Level
122300221129
122400221129           g2slvo = '';
122500221129           if LifVolElec = 'Y';                 // Show Volume (GuarTranp)
122600221129             g2slvo = %Char(benAmt * 100);      // Volume Election
122700221128           endif;
122800221128
122900191216           g2slbd = %Char(EnrollDt);
123000190523
123100191216
123200191216           // Effective Date Override
123300191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
123400191216 |           g2slbd = cpcid6;
123500191216br16       endif;
123600190523
123700191216           g2sled = %Char(CancelDt);
123800191216           if CancelDt = 0 or CancelDt = 99999999;
123900191216             g2sled = *Blanks;
124000191216             exsr $ClearArray;
124100191216           else;
124200191216             exsr $RemoveRcd;
124300191216           endif;
124400150904
124500221123           if CancelDt > 0;
124600221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
124700221103            g2sled = g2slbd;
124800221103           endif;
124900221123           endif;
125000150818
125100150914
125200191216         //----------------------------------------------------------------
125300191216         //?               STD - Short Term Disability
125400191216         //----------------------------------------------------------------
125500191216         When cpCid1 = 'STD';
125600150914
125700191216           //?Skip processed Records
125800191216           if g2Std > *Blanks;
125900150914
126000191216             //?Already has an Active Record.
126100191216             if g2Sted = *Blanks;
126200191216               leavesr;
126300191216             endif;
126400150914
126500191216             //?Already processed a Newer Record.
126600191216             if %Dec(g2STed:8:0) > %Dec(CancelDt:8:0) and
126700191216              %Dec(CancelDt:8:0) > 0;
126800191216               leavesr;
126900191216             endif;
127000191216           endif;
127100150914
127200191216           if RecordType = 'Member';
127300191216             SaveCovTp = mCovTp;
127400191216           else;
127500191216             SaveCovTp = dCovTp;
127600191216           endif;
127700150917
127800191216           //?Override the Class.. If Needed.
127900191216           exsr $Check_Class;
128000150915
128100191216           StdCovTp = #GetCovgLvl(SaveCovTp);
128200191216           StdDate = OrigDate;
128300191216           StdPlan = PlanId;
128400150929
128500191216           g2Std = cpCid1;                      // VolLif Election
128600191216           g2Stcd = %Char(benAmt) ;             // Coverage Desc
128700150917
128800191216           if StdCovDesc = 'N';                 // Hide Coverage (GuarTranp)
128900191216             g2stcd = '';
129000191216           endif;
129100150917
129200191216           g2stcl = #GetCovgLvl(SaveCovTp);     // Coverage Level
129300150922
129400221129           g2stvo = '';
129500221129           if StdVolElec = 'Y';                 // Show Volume (GuarTranp)
129600221129             g2stvo = %Char(benAmt * 100);      // Volume Election
129700191216           endif;
129800150922
129900191216           g2stbd = %Char(EnrollDt);
130000190523
130100191216
130200191216           // Effective Date Override
130300191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
130400191216 |           g2stbd = cpcid6;
130500191216br16       endif;
130600190523
130700191216           g2sted = %Char(CancelDt);
130800191216           if CancelDt = 0 or CancelDt = 99999999;
130900191216             g2sted = *Blanks;
131000191216             exsr $ClearArray;
131100191216           else;
131200191216             exsr $RemoveRcd;
131300191216           endif;
131400150914
131500221123
131600221123           if CancelDt > 0;
131700221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
131800221103            g2sted = g2stbd;
131900221103           endif;
132000221123           endif;
132100221123
132200150914
132300191216         //----------------------------------------------------------------
132400191216         //?             VOLLTD - Volunteer Long Term Disability
132500191216         //----------------------------------------------------------------
132600191216         When cpCid1 = 'VOLLTD';
132700150914
132800191216           //?Skip processed Records
132900191216           if g2vld > *Blanks;
133000150914
133100191216             //?Already has an Active Record.
133200191216             if g2Vled = *Blanks;
133300191216               leavesr;
133400191216             endif;
133500150914
133600150914
133700191216             //?Already processed a Newer Record.
133800191216             if %Dec(g2Vled:8:0) > %Dec(CancelDt:8:0) and
133900191216              %Dec(CancelDt:8:0) > 0;
134000191216               leavesr;
134100191216             endif;
134200191216           endif;
134300150914
134400191216           if RecordType = 'Member';
134500191216             SaveCovTp = mCovTp;
134600191216           else;
134700191216             SaveCovTp = dCovTp;
134800191216           endif;
134900150917
135000191216           //?Override the Class.. If Needed.
135100191216           exsr $Check_Class;
135200150915
135300191216           VolLtdCovTp = #GetCovgLvl(SaveCovTp);
135400191216           VolLtdDate = OrigDate;
135500191216           VolLtdPlan = PlanId;
135600150929
135700191216           g2Vld = cpCid1;                      // VolLtd Election
135800191216           g2Vlcd = 'VL' + %Char(benAmt);       // Coverage Desc
135900170612
136000191216           g2Vlcl = #GetCovgLvl(SaveCovTp);     // Coverage Level
136100221128
136200221129           g2vlvo = '';
136300221129           if LtdVolElec = 'Y';                 // Show Volume (GuarTranp)
136400221129             g2Vlvo = %Char(benAmt);            // Volume Election
136500221128           endif;
136600221128
136700191216           g2Vlbd = %Char(EnrollDt);
136800190523
136900191216
137000191216           // Effective Date Override
137100191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
137200191216 |           g2vlbd = cpcid6;
137300191216br16       endif;
137400190523
137500191216           g2Vled = %Char(CancelDt);
137600170612
137700191216           if VLCovDesc = 'N';                 // Hide Coverage (GuarTranp)
137800191216             g2vlcd = '';
137900191216             g2vlvo = '';
138000191216           endif;
138100170612
138200170612
138300191216br14       if BlankVLVO = 'Y';                 // Blank Voluntary LTD Volume
138400191216             g2vlvo = '';                     // Election
138500191216           endif;
138600180418
138700180418
138800191216           if CancelDt = 0 or CancelDt = 99999999;
138900191216             g2Vled = *Blanks;
139000191216             exsr $ClearArray;
139100191216           else;
139200191216             exsr $RemoveRcd;
139300191216           endif;
139400150914
139500221123
139600221123           if CancelDt > 0;
139700221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
139800221103            g2vled = g2vlbd;
139900221103           endif;
140000221123           endif;
140100221123
140200151102
140300191216         //----------------------------------------------------------------
140400191216         //?                  Volunteer AD&D  VOLADD
140500191216         //----------------------------------------------------------------
140600191216         When cpCid1 = 'VOLADD';
140700151102
140800191216           //?Skip processed Records
140900191216           if g2Vad > *Blanks;
141000151102
141100191216             //?Already has an Active Record.
141200191216             if g2Vaed = *Blanks;
141300191216               leavesr;
141400191216             endif;
141500151102
141600191216             //?Already processed a Newer Record.
141700191216             if %Dec(g2Vaed:8:0) > %Dec(CancelDt:8:0) and
141800191216              %Dec(CancelDt:8:0) > 0;
141900191216               leavesr;
142000191216             endif;
142100191216           endif;
142200151102
142300200618           // If the Record type is Member, but the vol plan
142400200618           // is not... leave.
142500200618           if RecordType = 'Member' and
142600200618               #GetVol_Lvl(mcTrst : mcSub# : PlanId ) <> 'EMP';
142700200929             leavesr;
142800200618           EndIf;
142900200618
143000200618           if RecordType = 'Dependent' and
143100200618               #GetVol_Lvl(mcTrst : mcSub# : PlanId ) = 'EMP';
143200200929             leavesr;
143300200618           EndIf;
143400200618
143500191216           //?Get Volumn Election - Benefit Amount
143600191216           chain (mcTrst : mcSub# : acc# :
143700191216                  mbssno : PlanID ) mCovc15 ;
143800151102
143900191216           if RecordType = 'Member';
144000191216             SaveCovTp = mCovTp;
144100191216           else;
144200191216             SaveCovTp = dCovTp;
144300191216           endif;
144400151102
144500191216           //?Override the Class.. If Needed.
144600191216           exsr $Check_Class;
144700151102
144800191216           VolAddCovTp = #GetCovgLvl(SaveCovTp);
144900191216           VolAddDate = OrigDate;
145000191216           VolAddPlan = PlanId;
145100151102
145200191216           g2vad = cpCid1;                      // VolAdd Election
145300191216           g2vacd = cpCid2;                     // Coverage Desc
145400191216br07       g2vacl = #GetVol_Lvl(mcTrst : mcSub# : PlanId );     // Coverage Level
145500221129
145600221129           g2vavo = '';
145700221129           if AddVolElec = 'Y';                 // Show Volume (GuarTranp)
145800221129             g2vavo = %Char(benAmt * 100);      // Volume Election
145900221128           endif;
146000221128
146100191216           g2vabd = %Char(EnrollDt);
146200190523
146300191216
146400191216           // Effective Date Override
146500191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
146600191216 |           g2vabd = cpcid6;
146700191216br16       endif;
146800190523
146900191216           g2vaed = %Char(CancelDt);
147000191216           if CancelDt = 0 or CancelDt = 99999999;
147100191216             g2vaed = *Blanks;
147200191216             exsr $ClearArray;
147300191216           else;
147400191216             exsr $RemoveRcd;
147500191216           endif;
147600151102
147700170123
147800221123           if CancelDt > 0;
147900221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
148000221103            g2vaed = g2vabd;
148100221103           endif;
148200221123           endif;
148300221123
148400221103
148500191216         //----------------------------------------------------------------
148600191216         //?BR08             HOSP - Hospital Indemnity
148700191216         //----------------------------------------------------------------
148800191216         When cpCid1 = 'HOSP';
148900170123
149000191216           //?Skip processed Records
149100191216           if g2Hod > *Blanks;
149200170123
149300191216             //?Already has an Active Record.
149400191216             if g2Hoed = *Blanks;
149500191216               leavesr;
149600191216             endif;
149700170123
149800191216             //?Already processed a Newer Record.
149900191216             if %Dec(g2Hoed:8:0) > CancelDt and
150000191216              CancelDt > 0;
150100191216               leavesr;
150200191216             endif;
150300191216           endif;
150400170123
150500191216           if RecordType = 'Member';
150600191216             SaveCovTp = mCovTp;
150700191216           else;
150800191216             SaveCovTp = dCovTp;
150900191216           endif;
151000170123
151100191216           //?Override the Class.. If Needed.
151200191216           exsr $Check_Class;
151300170123
151400191216           HosCovTp = #GetCovgLvl(SaveCovTp);
151500191216           HosDate = OrigDate;
151600191216           HosPlan = PlanId;
151700191216           g2Hod = cpCid1;                      // Dental Election
151800191216           g2Hocd = cpCid2;                     // Coverage Desc
151900191216           if BlankVicd = 'Y';
152000191216             g2Hocd = *blanks;
152100191216           endif;
152200170123
152300191216           g2Hocl = #GetCovgLvl(SaveCovTp);     // Coverage Level
152400191216           g2Hobd = %Char(EnrollDt);
152500190523
152600191216
152700191216           // Effective Date Override
152800191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
152900191216 |           g2hobd = cpcid6;
153000191216br16       endif;
153100190523
153200191216           g2Hoed = %Char(CancelDt);
153300191216           if CancelDt = 0 or CancelDt = 99999999;
153400191216             g2Hoed = *Blanks;
153500191216             exsr $ClearArray;
153600191216           else;
153700191216             exsr $RemoveRcd;
153800191216           endif;
153900170123
154000221123
154100221123           if CancelDt > 0;
154200221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
154300221103            g2hoed = g2hobd;
154400221103           endif;
154500221123           endif;
154600221123
154700170623
154800191216         //----------------------------------------------------------------
154900191216         //?BR11           CRITIL - Critical Illness
155000191216         //----------------------------------------------------------------
155100191216         When cpCid1 = 'CRITIL';
155200170623
155300191216           //?Skip processed Records
155400191216           if g2Cid > *Blanks;
155500170623
155600191216             //?Already has an Active Record.
155700191216             if g2Cied = *Blanks;
155800191216               leavesr;
155900191216             endif;
156000170623
156100191216             //?Already processed a Newer Record.
156200191216             if %Dec(g2Cied:8:0) > CancelDt and
156300191216              CancelDt > 0;
156400191216               leavesr;
156500191216             endif;
156600191216           endif;
156700240213
156800240213           //?Get Volumn Election - Benefit Amount - J001
156900240213           chain (mcTrst : mcSub# : acc# :
157000240213                  mbssno : PlanID ) mCovc15 ;
157100170623
157200191216           if RecordType = 'Member';
157300191216             SaveCovTp = mCovTp;
157400191216           else;
157500191216             SaveCovTp = dCovTp;
157600191216           endif;
157700170623
157800191216           //?Override the Class.. If Needed.
157900191216           exsr $Check_Class;
158000170623
158100240213           //?Critical Illness Benefit Amount - J001.
158200191216           CritCovTp = #GetCovgLvl(SaveCovTp);
158300191216           CritDate = OrigDate;
158400191216           CritPlan = PlanId;
158500191216           g2Cid = cpCid1;                      // Dental Election
158600240213           // g2Cicd = %Char(benAmt) ;  J001       // Coverage Desc
158700240213           g2Cicd = '';
158800240213           if CRTIllElec = 'Y';                 // Show Volume (GuarTranp)
158900240301           chain ( mcTrst : mcSub# : PlanId ) PlnMst;
159000240301             g2Cicd = %Char(maxben * 100);      // Volume Election J001
159100240301          // g2Cicd = %Char(benAmt * 100);      // Volume Election J001
159200240213           endif;
159300240213
159400191216           if BlankCicd = 'Y';
159500191216             g2Cicd = *blanks;
159600191216           endif;
159700170623
159800191216           g2Cicl = #GetCovgLvl(SaveCovTp);     // Coverage Level
159900191216           g2Cibd = %Char(EnrollDt);
160000190523
160100191216
160200191216           // Effective Date Override
160300191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
160400191216 |           g2cibd = cpcid6;
160500191216br16       endif;
160600190523
160700191216           g2Cied = %Char(CancelDt);
160800191216           if CancelDt = 0 or CancelDt = 99999999;
160900191216             g2Cied = *Blanks;
161000191216             exsr $ClearArray;
161100191216           else;
161200191216             exsr $RemoveRcd;
161300191216           endif;
161400170623
161500170623
161600221123           if CancelDt > 0;
161700221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
161800221103            g2cied = g2cibd;
161900221103           endif;
162000221123           endif;
162100221103
162200170623
162300191216         //----------------------------------------------------------------
162400191216         //?BR12         VOLCRIT - Voluntary Critical Illness
162500191216         //----------------------------------------------------------------
162600191216         When cpCid1 = 'VOLCRIT';
162700170623
162800191216           //?Skip processed Records
162900191216           if g2Vcd > *Blanks;
163000170623
163100191216             //?Already has an Active Record.
163200191216             if g2Vced = *Blanks;
163300191216               leavesr;
163400191216             endif;
163500170623
163600191216             //?Already processed a Newer Record.
163700191216             if %Dec(g2Vced:8:0) > CancelDt and
163800191216              CancelDt > 0;
163900191216               leavesr;
164000191216             endif;
164100191216           endif;
164200170623
164300200929           // If the Record type is Member, but the vol plan
164400200624           // is not... leave.
164500230517           if RecordType = 'Member' and
164600230517               #GetVol_Lvl(mcTrst : mcSub# : PlanId ) <> 'EMP';
164700230517             leavesr;
164800230517           EndIf;
164900200624
165000230517           // **** Per Candace - do not perform this step!! ******
165100230517           // if RecordType = 'Dependent' and
165200230517               // #GetVol_Lvl(mcTrst : mcSub# : PlanId ) = 'EMP';
165300230517             // leavesr;
165400230517           // EndIf;
165500240213
165600240213           //?Get Volumn Election - Benefit Amount - J001
165700240213           chain (mcTrst : mcSub# : acc# :
165800240213                  mbssno : PlanID ) mCovc15 ;
165900200624
166000200624
166100191216           if RecordType = 'Member';
166200191216             SaveCovTp = mCovTp;
166300191216           else;
166400191216             SaveCovTp = dCovTp;
166500191216           endif;
166600170623
166700191216           //?Override the Class.. If Needed.
166800191216           exsr $Check_Class;
166900170623
167000210706           VCritCovTp = #GetDLCovgLvl(SaveCovTp);
167100191216           VCritDate = OrigDate;
167200191216           VCritPlan = PlanId;
167300191216           g2Vcd = cpCid1;                      // Dental Election
167400191216           g2Vccd = cpCid2;                     // Coverage Desc
167500191216           if BlankVccd = 'Y';
167600191216             g2Vccd = *blanks;
167700191216           endif;
167800170623
167900191216           g2Vccl = #GetCovgLvl(SaveCovTp);     // Coverage Level
168000191216           g2Vcbd = %Char(EnrollDt);
168100190523
168200240213           // g2vcvo = %Char(benAmt * 100);              // Volume Election
168300240213           g2vcvo = '';
168400240213           if CRTVolElec = 'Y';                 // Show Volume (GuarTranp)
168500240301           chain ( mcTrst : mcSub# : PlanId ) PlnMst;
168600240301             g2vcvo = %Char(maxben * 100);      // Volume Election J001
168700240301          // g2vcvo = %Char(benAmt * 100);      // Volume Election J001
168800240213           endif;
168900191216
169000191216           // Effective Date Override
169100191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
169200191216 |           g2vcbd = cpcid6;
169300191216br16       endif;
169400190523
169500191216           g2Vced = %Char(CancelDt);
169600191216           if CancelDt = 0 or CancelDt = 99999999;
169700191216             g2Vced = *Blanks;
169800191216             exsr $ClearArray;
169900191216           else;
170000191216             exsr $RemoveRcd;
170100191216           endif;
170200170623
170300221123
170400221123           if CancelDt > 0;
170500221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
170600221103            g2vced = g2vcbd;
170700221103           endif;
170800221123           endif;
170900170623
171000170623
171100191216         //----------------------------------------------------------------
171200191216         //?BR09            DEPLIF - Dependent Life
171300191216         //----------------------------------------------------------------
171400191216         When cpCid1 = 'DEPLIF';
171500170215
171600191216           //?Skip processed Records
171700191216           if g2Dld > *Blanks;
171800170215
171900191216             //?Already has an Active Record.
172000191216             if g2dled = *Blanks;
172100191216               leavesr;
172200191216             endif;
172300170216
172400191216             //?Already processed a Newer Record.
172500191216             if %Dec(g2Dled:8:0) > CancelDt and
172600191216              CancelDt > 0;
172700191216               leavesr;
172800191216             endif;
172900191216           endif;
173000170215
173100191216           if RecordType = 'Member';
173200191216             SaveCovTp = mCovTp;
173300191216           else;
173400191216             SaveCovTp = dCovTp;
173500191216           endif;
173600170215
173700191216           //?Override the Class.. If Needed.
173800191216           exsr $Check_Class;
173900170215
174000191216           dLifCovTp = #GetDLCovgLvl(SaveCovTp);
174100191216           DLifDate = OrigDate;
174200191216           DLifPlan = PlanId;
174300191216           g2Dld = cpCid1;                      // Dental Election
174400191216           g2Dlcd = cpCid2;                     // Coverage Desc
174500191216           if BlankVicd = 'Y';
174600191216             g2Dlcd = *blanks;
174700191216           endif;
174800170215
174900221129           g2dlvo = '';
175000221129           if LifVolElec <> 'Y' ;               // Show Volume (GuarTranp)
175100221129             g2dlvo = %Char(benAmt * 100);      // Volume Election
175200220224           endif;
175300220224
175400220224
175500220224
175600220224
175700191216           g2Dlcl = #GetDLCovgLvl(SaveCovTp);     // Coverage Level
175800191216           g2Dlbd = %Char(EnrollDt);
175900190523
176000191216
176100191216           // Effective Date Override
176200191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
176300191216 |           g2dlbd = cpcid6;
176400191216br16       endif;
176500190523
176600191216           g2Dled = %Char(CancelDt);
176700191216           if CancelDt = 0 or CancelDt = 99999999;
176800191216             g2Dled = *Blanks;
176900191216             exsr $ClearArray;
177000191216           else;
177100191216             exsr $RemoveRcd;
177200191216           endif;
177300170215
177400170215
177500221123           if CancelDt > 0;
177600221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
177700221103            g2dled = g2dlbd;
177800221103           endif;
177900221123           endif;
178000170215
178100160701
178200191216         //----------------------------------------------------------------
178300191216         //?             Accident - ACC      Mod ID: Br04   7/1/2016
178400191216         //----------------------------------------------------------------
178500191216         When cpCid1 = 'ACC';
178600160701
178700191216           //?Skip processed Records
178800191216           if g2acd > *Blanks;
178900160701
179000191216             //?Already has an Active Record.
179100191216             if g2aced = *Blanks;
179200191216               leavesr;
179300191216             endif;
179400160701
179500191216             //?Already processed a Newer Record.
179600191216             if %Dec(g2aced:8:0) > CancelDt and
179700191216              CancelDt > 0;
179800191216               leavesr;
179900191216             endif;
180000191216           endif;
180100160701
180200191216           if RecordType = 'Member';
180300191216             SaveCovTp = mCovTp;
180400191216           else;
180500191216             SaveCovTp = dCovTp;
180600191216           endif;
180700160701
180800191216           //?Override the Class.. If Needed.
180900191216           exsr $Check_Class;
181000160701
181100191216           AccCovTp = #GetCovgLvl(SaveCovTp);
181200191216           AccDate = OrigDate;
181300191216           AccPlan = PlanId;
181400160701
181500191216           g2acd = cpCid1;                      // Dental Election
181600191216           g2accd = cpCid2;                     // Coverage Desc
181700191216           g2accl = #GetCovgLvl(SaveCovTp);     // Coverage Level
181800160701
181900191216           g2acbd = %Char(EnrollDt);
182000190523
182100191216
182200191216           // Effective Date Override
182300191216br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
182400191216 |           g2acbd = cpcid6;
182500191216br16       endif;
182600190523
182700191216           g2aced = %Char(CancelDt);
182800191216           if CancelDt = 0 or CancelDt = 99999999;
182900191216             g2aced = *Blanks;
183000191216             exsr $ClearArray;
183100191216           else;
183200191216             exsr $RemoveRcd;
183300191216           endif;
183400160701
183500221123
183600221123           if CancelDt > 0;
183700221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
183800221103            g2aced = g2acbd;
183900221103           endif;
184000221123           endif;
184100221103
184200160701
184300200630         //----------------------------------------------------------------
184400200630         // BR23           CAN    - Cancer
184500200630         //----------------------------------------------------------------
184600200630         When cpCid1 = 'CAN';
184700200630
184800200630           //?Skip processed Records
184900200630           if g2Cad > *Blanks;
185000200630
185100200630             //?Already has an Active Record.
185200200630             if g2caed = *Blanks;
185300200630               leavesr;
185400200630             endif;
185500200630
185600200630             //?Already processed a Newer Record.
185700200630             if %Dec(g2caed:8:0) > CancelDt and
185800200630              CancelDt > 0;
185900200630               leavesr;
186000200630             endif;
186100200630           endif;
186200200630
186300200630           if RecordType = 'Member';
186400200630             SaveCovTp = mCovTp;
186500200630           else;
186600200630             SaveCovTp = dCovTp;
186700200630           endif;
186800200630
186900200630           //?Override the Class.. If Needed.
187000200630           exsr $Check_Class;
187100200630
187200200630           cancCovTp = #GetCovgLvl(SaveCovTp);
187300200630           CancDate = OrigDate;
187400200630           CancPlan = PlanId;
187500200630           g2cad = cpCid1;                      // Dental Election
187600200630           g2cacd = %Char(benAmt) ;             // Coverage Desc
187700200729           if g2cacd ='0';
187800200729             g2cacd = '';
187900200729           EndIf;
188000200729
188100200929           // if BlankCacd = 'Y';
188200200929           //   g2Cacd = *blanks;
188300200929           //  endif;
188400200630
188500200630           g2cacl = #GetCovgLvl(SaveCovTp);     // Coverage Level
188600200630           g2cabd = %Char(EnrollDt);
188700200630
188800200630
188900200630           // Effective Date Override
189000200630br16       if cpcid6 > '' and cpcid6 > %Char(EnrollDt);
189100200630 |           g2cabd = cpcid6;
189200200630br16       endif;
189300200630
189400200630           g2Caed = %Char(CancelDt);
189500200630           if CancelDt = 0 or CancelDt = 99999999;
189600200630             g2caed = *Blanks;
189700200630             exsr $ClearArray;
189800200630           else;
189900200630             exsr $RemoveRcd;
190000200630           endif;
190100221103
190200221123
190300221123           if CancelDt > 0;
190400221103           if %date(%dec(EnrollDt)) = %date(%dec(CancelDt)) + %days(1);
190500221103            g2caed = g2cabd;
190600221103           endif;
190700221123           endif;
190800151102
190900191216         endsl;
191000150914
191100150914
191200150818
191300191216       EndSr;
191400191216       //--------------------------------------------------------------------
191500191216       Begsr $ProcessDepnd;
191600150821
191700191216         // SQL Statement Example
191800191216         //   Select * from "F.DEPNDC"
191900191216         //    Where dssno in = mbssno
192000191216         //     order by dssno, dpSeq#
192100191216         //------------------------------------------------------------------
192200191216         SqlStmt3 =
192300191216           'Select ' +
192400191216           ' dssno, dpSeq#, dlName, dfName, dmi,   ' +
192500191216           ' dAddr1, dAddr2, dCity, dState, dZip,  ' +
192600191216           ' dArea, dPhone, dSex, dRelCd, dBirth,  ' +
192700191216           ' depss#, dHndcp, dStudn ' +
192800191216           ' from "F.DEPNDC" '  +
192900191216           '   Where dssno = ' + %Char(mbssno) +
193000191216           '    Order by dssno, dpSeq# ';
193100150821
193200201103         Exec Sql
193300201103           Declare C3 Cursor For Sqlstmt3;
193400201103         Exec Sql
193500201103           Prepare Sqlstmt3 From :Sqlstmt3;
193600201103         Exec Sql
193700201103           Open C3;
193800150821
193900191216         dou SqlCod <> *Zero;
194000201103           Exec Sql
194100201103             Fetch Next From C3
194200201103               Into :Sq_Depndc;
194300150821
194400191216           if SqlCod <> *zero;
194500191216             leave;
194600191216           endif;
194700150821
194800191216           //?Process Dependent Data
194900191216           exsr $DependRcd;                     // Get Dependent Record
195000191216           exsr $ClearCovg;                     // Clear Coverage Data
195100191216           exsr $DependCovg;                    // Get Dependent Coverages
195200150821
195300191216         enddo;
195400201103         Exec Sql
195500201103           Close C3;
195600191216br01     //?Removed B.Rees  BR07    exsr $Check_VolLif;
195700191216         exsr $ClearCovg;                        // Clear Coverage Data
195800150821
195900191216       EndSr;
196000150821
196100191216       //--------------------------------------------------------------------
196200191216       Begsr $DependRcd;
196300150821
196400191216         g2Edi = 'D';                            // Dependent
196500191216         g2Ssn = %Editc(mbssno:'X');
196600191216         g2Hire = '';
196700150821
196800191216         g2Last = %Trim(dLName);                 // Name
196900191216         g2First = dFName;
197000191216         g2Mid  = dmi;
197100150821
197200191216         //?Default with home Phone Number
197300191216         g2hPhn = g2hPhn;                        // Phone
197400191216         if dphone > 0;
197500191216           g2hPhn = %editc(dArea:'X') + %Char(dPhone);
197600191216         endif;
197700150821
197800201123         g2Email = '';
197900191216         g2Ad1 = dAddr1;                         // Address
198000191216         g2Ad2 = dAddr2;
198100191216         g2City = dCity;
198200191216         g2St  = dState;
198300191216         ZipCode = %Editc(dZip:'X');
198400191216         g2Zip = %Subst(ZipCode:1:5);
198500150821
198600191216         g2dob = %Char(dBirth);
198700191216         g2Sex = dSex;
198800191216         g2Rel = #GetRelCode(dRelCd);            // Relationship Code
198900191216         g2ms = '';                              // Marriage
199000150821
199100150821
199200191216         g2dss = *Blanks;
199300191216         if DepSS# > 0;
199400191216           g2dss  = %Editc(DepSS#:'X');
199500191216         endif;
199600150821
199700191216         g2Stu = 'N';                            // Student
199800191216         if dStudn = 'Y';
199900191216           g2Stu = 'F';
200000191216         endif;
200100150821
200200191216         g2Han = *Blanks;                        // HandiCap
200300191216         if dHndCp = '3';
200400191216           g2Han = 'H';
200500191216         endif;
200600150821
200700191216         g2Sal   = *Blanks;
200800191216         g2Samf  = *Blanks;
200900191216         g2saed  = *Blanks;
201000191216         g2Hours = *Blanks;
201100150917
201200150821
201300191216       EndSr;
201400150821
201500150821
201600191216       //--------------------------------------------------------------------
201700191216       Begsr $DependCovg;
201800150821
201900191216         WriteData = 'N';
202000150821
202100191216         //------------------------------------------------------------------
202200191216         // SQL Statement Example
202300191216         //    Select
202400191216         //       ssno, dvPlan, dEnrdT, CanDt, mCovTp
202500191216         //    From "F.DCOVC"
202600191216         //    join mCovmPln on mcssno = ssno
202700191216         //                 and mctrst = dvTrst
202800191216         //                 and mcSub# = dvsub#
202900191216         //                 and mcplan = dvplan
203000191216         //    Where dvPlan in
203100191216         //     (?Select cpPlan from CarPlnp where cpUniq = '0000000130')
203200191216         //   and ssno = 19481872  and dSeq# = 1
203300191216         //   and dEnrdT <> CanDt
203400191216         //   and EnrlDt <> Candt
203500191216         //   and CanDt = ccandt
203600191216         //
203700191216         //------------------------------------------------------------------
203800191216         SqlStmt4 =
203900200629           ' Select ssno, dSeq#, dvPlan, dEnrDT, cCanDt, mCovTp, benamt ' +
204000191216           ' from "F.DCOVC" ' +
204100191216           ' join mCovmPln on mcssno = ssno '   +
204200191216           '              and mctrst = dvTrst ' +
204300191216           '              and mcSub# = dvsub# ' +
204400191216           '              and mcplan = dvplan ' +
204500191216           '  Where dvPlan in ' +
204600191216           '  ( Select cpPlan from CarPlnp where cpUniq = ' +
204700191216                     q + %Trim(UniqueID) + q + ') ' +
204800191216           '    and ssno = ' +  %Char(dssno)        +
204900191216           '    and dSeq# = ' +  %Char(dpSeq#)      +
205000200610           '    and dEnrdT <> cCanDt ' ;
205100200929         // '    and EnrlDt <> Candt  ' +
205200200929         //'    and CanDt = ccandt   ';
205300150928
205400201103         Exec Sql
205500201103           Declare C4 Cursor For Sqlstmt4;
205600201103         Exec Sql
205700201103           Prepare Sqlstmt4 From :Sqlstmt4;
205800201103         Exec Sql
205900201103           Open C4;
206000150821
206100191216         dou SqlCod <> *Zero;
206200201103           Exec Sql
206300201103             Fetch Next From C4
206400201103               Into :Sq_dCovc;
206500150821
206600191216           if SqlCod <> *zero;
206700191216             leave;
206800191216           endif;
206900181010
207000191216           WriteData = 'Y';
207100200629           benamt = wbenamt;
207200150821
207300191216           //?Process Coverages
207400191216           chain (UniqueId : mcTrst : mcSub# :
207500191216                      acc# : ' ' : dvPlan) CarPlnp;
207600181010
207700191216           //?Do Not Send...
207800191216           if cpcid9 = 'Y';
207900191216             iter;
208000191216           endif;
208100181010
208200150821
208300191216           EnrollDt = dEnrDt;
208400191216           CancelDt = cCanDt;
208500191216           TermDate = cCanDt;
208600191216           PlanId = dvPlan;
208700150821
208800191216           RecordType = 'Dependent';
208900191216           exsr $CoverageRcd;
209000150821
209100191216         enddo;
209200201103         Exec Sql
209300201103           Close C4;
209400150821
209500191216         //  If WriteData = 'Y' and Continue = 'Y';
209600191216         If WriteData = 'Y';
209700151022
209800191216           //?Verify that the plans are not
209900191216           //?in the TERM file.
210000191216           Dep# = dSeq#;
210100191216           exsr $CheckTerm;
210200151027
210300191216           if Continue = 'Y';
210400191216             RcdCount = RcdCount + 1;
210500191216             Write  gf012f;
210600191216           endif;
210700191216         endif;
210800150821
210900150821
211000191216       EndSr;
211100150821
211200191216       //--------------------------------------------------------------------
211300191216       Begsr $ClearCovg;
211400150821
211500191216         benAmt = 0;
211600150914
211700191216         //?Saved Plans
211800191216         DenCovTp = *Blanks;
211900191216         ADDCovTp = *Blanks;
212000191216         LTDCovTp = *Blanks;
212100191216         LifeCovTp = *Blanks;
212200191216         VisCovTp = *Blanks;
212300191216         VolLifCovTp = *Blanks;
212400191216         STDCovTp = *Blanks;
212500191216         VolLTDCovTp = *Blanks;
212600191216         VolAddCovTp = *Blanks;
212700200624         VCritCovTp = '';
212800200630br23     CancCovTp = '';
212900200624
213000191216         //?Saved Plans
213100191216         DenPlan = *Blanks;
213200191216         ADDPlan = *Blanks;
213300191216         LTDPlan = *Blanks;
213400191216         LifePlan = *Blanks;
213500191216         VisPlan = *Blanks;
213600191216         VolLifPlan = *Blanks;
213700191216         STDPlan = *Blanks;
213800191216         VolLTDPlan = *Blanks;
213900191216         VolAddPlan = *Blanks;
214000200624         vCritPlan = '';
214100200630br23     CancPlan = '';
214200150929
214300191216         //?Saved Dates
214400191216         OrigDate = *zero;
214500191216         DenDate = *zero;
214600191216         ADDDate = *zero;
214700191216         LTDDate = *zero;
214800191216         LifeDate = *zero;
214900191216         VisDate = *zero;
215000191216         VolLifDate = *zero;
215100191216         STDDate = *zero;
215200191216         VolLTDDate = *zero;
215300191216         VolAddDate = *zero;
215400200624         vCritDate = 0;
215500200630br23     CancDate = 0;
215600150929
215700191216         //?Dental
215800191216         g2Dnd  = *Blanks;
215900191216         g2Dncd = *Blanks;
216000191216         g2Dncl = *Blanks;
216100191216         g2dnbd = *Blanks;
216200191216         g2dned = *Blanks;
216300150821
216400191216         //?Volunteer Life  VOLLIF
216500191216         g2Sld  = *Blanks;
216600191216         g2Slcd = *Blanks;
216700191216         g2slvo = *Blanks;
216800191216         g2slcl = *Blanks;
216900191216         g2slbd = *Blanks;
217000191216         g2sled = *Blanks;
217100150914
217200191216         //?STD - Short Term Disability
217300191216         g2Std  = *Blanks;
217400191216         g2Stcl = *Blanks;
217500191216         g2Stbd = *Blanks;
217600191216         g2Sted = *Blanks;
217700191216         g2stvo = *Blanks;
217800191216         g2stcd = *Blanks;
217900150914
218000191216         //?VOLLTD - Volunteer Long Term Disability
218100191216         g2Vld  = *Blanks;
218200191216         g2vlcd = *Blanks;
218300191216         g2vlcl = *Blanks;
218400191216         g2vlbd = *Blanks;
218500191216         g2vled = *Blanks;
218600191216         g2vlvo = *Blanks;
218700150821
218800191216         //?VIS - Vision
218900191216         g2Vid  = *Blanks;
219000191216         g2vicd = *Blanks;
219100191216         g2vicl = *Blanks;
219200191216         g2vibd = *Blanks;
219300191216         g2Vied = *Blanks;
219400150917
219500191216         //?LTD - Long Term Disability
219600191216         g2Ltd  = *Blanks;
219700191216         g2Ltcd = *Blanks;
219800191216         g2Ltcl = *Blanks;
219900191216         g2Ltbd = *Blanks;
220000191216         g2Lted = *Blanks;
220100191216         g2Ltvo = *Blanks;
220200150917
220300191216         //?LIFE - Basic Life
220400191216         g2Bld  = *Blanks;
220500191216         g2Blcd = *Blanks;
220600191216         g2Blcl = *Blanks;
220700191216         g2Blbd = *Blanks;
220800191216         g2Bled = *Blanks;
220900191216         g2Blvo = *Blanks;
221000150917
221100150917
221200191216         //?ADD - ADND
221300191216         g2Bad  = *Blanks;
221400191216         g2Bacd = *Blanks;
221500191216         g2Bacl = *Blanks;
221600191216         g2Babd = *Blanks;
221700191216         g2Baed = *Blanks;
221800191216         g2Bavo = *Blanks;
221900150917
222000191216         //?Volunteer AD&D  VOLADD
222100191216         g2vad  = *Blanks;
222200191216         g2vacd = *Blanks;
222300191216         g2vavo = *Blanks;
222400191216         g2vacl = *Blanks;
222500191216         g2vabd = *Blanks;
222600191216         g2vaed = *Blanks;
222700151102
222800191216         //?Hospital  HOSP
222900191216         g2Hod  = *Blanks;
223000191216         g2Hocd = *Blanks;
223100191216         g2Hocl = *Blanks;
223200191216         g2Hobd = *Blanks;
223300191216         g2Hoed = *Blanks;
223400200624
223500200624         // VOLCRIT - Voluntary Critical Illness
223600200624         g2vcd = '';
223700200624         g2vccd = *Blanks;
223800200624         g2vcvo = *Blanks;
223900200624         g2vccl = *Blanks;
224000200624         g2vcbd = *Blanks;
224100200624         g2vced = *Blanks;
224200200624
224300200630
224400200630br23     // CANC    - Cancer
224500200630         g2cad = '';
224600200630         g2cacd = *Blanks;
224700200630         g2cacl = *Blanks;
224800200630         g2cabd = *Blanks;
224900200630         g2caed = *Blanks;
225000170123
225100150821
225200191216       EndSr;
225300191216       //--------------------------------------------------------------------
225400191216       Begsr $RemoveRcd;
225500150824
225600191216br17     //?Skip COBRA and a Future Date.
225700191216         if g2cbra = 'Y' and TermDate > %Dec(%Date);
225800191216           leavesr;
225900191216         endif;
226000190708
226100191216         //?Store any Termed Records to an Array.
226200150824
226300191216         chain ( mbssno : dpSeq# : TermDate :
226400191216                 PlanId : #GetCovgLvl( SaveCovTp ) : mbTrst   :
226500191216                 mbSub# : mbAcct ) Guar014Wf;
226600150824
226700191216         if not %Found(Guar014wf);
226800191216           wni = wni + 1;
226900150824
227000191216           TermRcd(wni).ssno   = mbssno ;
227100191216           TermRcd(wni).Depno  = dpSeq#;
227200191216           TermRcd(wni).TermDt = TermDate;
227300191216           TermRcd(wni).Plan   = PlanId;
227400191216           TermRcd(wni).CovTp  = #GetCovgLvl( SaveCovTp );
227500190513           //  TermRcd(wni).CovTp  =  SaveCovTp ;
227600191216           TermRcd(wni).Trst   = mbTrst;
227700191216           TermRcd(wni).Sub#   = mbSub#;
227800191216           TermRcd(wni).Acct   = mbAcct;
227900191216           TermRcd(wni).TransDt = %Dec(%Date);
228000191216           TermRcd(wni).Cid1    = cpCid1;
228100191216           TermRcd(wni).Process = ' ';
228200150824
228300191216         endif;
228400150824
228500191216       EndSr;
228600150821
228700191216       //--------------------------------------------------------------------
228800191216       Begsr $ProcessTerms;
228900150824
229000191216         //?Read through the TermRcd Array.
229100191216         if wni = 0;
229200191216           leaveSr;
229300191216         endif;
229400150824
229500191216         wnj = 0;
229600150824
229700191216         dou TermRcd(wnj).ssno = 0;
229800150824
229900191216           wnj = wnj + 1;
230000150824
230100191216           if wnj > wni;
230200191216             leave;
230300191216           endif;
230400150824
230500191216           //?Write to the Term Tracker File.
230600191216           if TermRcd(wnj).Process <> 'N';
230700191216             NtSsno =  TermRcd(wnj).ssno;
230800191216             NtDepno = TermRcd(wnj).Depno;
230900191216             NtTermDt = TermRcd(wnj).TermDt;
231000191216             NtPlan = TermRcd(wnj).Plan;
231100191216             NtCovTp = TermRcd(wnj).CovTp;
231200191216             NtTrst = TermRcd(wnj).Trst;
231300191216             NtSub# = TermRcd(wnj).Sub#;
231400191216             NtAcct = TermRcd(wnj).Acct;
231500191216             NtTransDt = TermRcd(wnj).TransDt;
231600150824
231700191216             Write gf014f;
231800191216           endif;
231900191216         enddo;
232000150824
232100150824
232200191216       EndSr;
232300150824
232400191216       //--------------------------------------------------------------------
232500191216       Begsr $ClearArray;
232600150824
232700191216         //?Read through the TermRcd Array.
232800191216         if wni = 0;
232900191216           leaveSr;
233000191216         endif;
233100150824
233200150824
233300191216         wnj = 0;
233400150824
233500191216         dou TermRcd(wnj).ssno = 0;
233600150824
233700191216           wnj = wnj + 1;
233800150824
233900191216           if wnj > wni;
234000191216             leave;
234100191216           endif;
234200150824
234300191216           if TermRcd(wnj).ssno <> mbssno;
234400191216             iter;
234500191216           endif;
234600150824
234700191216           if TermRcd(wnj).depno = dpSeq#  and
234800191216              TermRcd(wnj).Cid1 = cpCid1;
234900150824
235000191216             //?This record has an active Account..
235100191216             //?Set the Process Flag to No
235200191216             TermRcd(wnj).Process = 'N';
235300191216           endif;
235400150824
235500191216         enddo;
235600150824
235700191216       EndSr;
235800150824
235900191216       //--------------------------------------------------------------------
236000191216       Begsr $CheckTerm;
236100150929
236200191216         //?Check the Term File. The Continue Flag will say 'Y'es if
236300191216         //?any of the plans are NOT in the Term File.
236400191216         //?--------------------------------------------------------
236500191216         //?If any are found.. Clear out the Data from that Section
236600150929
236700191216         Continue = 'N';
236800150929
236900191216         //?Dental
237000191216         chain(n)( mbssno : Dep# : DenDate : DenPlan : DenCovTp :
237100191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
237200191216         if not %Found(Guar014wf) and DenPlan > *Blanks;
237300191216           Continue = 'Y';
237400191216         else;
237500191216           g2Dnd  = *Blanks;
237600191216           g2Dncd = *Blanks;
237700191216           g2Dncl = *Blanks;
237800191216           g2dnbd = *Blanks;
237900191216           g2dned = *Blanks;
238000191216         endif;
238100150929
238200191216         //?AD&D
238300191216         chain(n)( mbssno : Dep# : AddDate : AddPlan : AddCovTp :
238400191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
238500191216         if not %Found(Guar014wf) and AddPlan > *Blanks;
238600191216           Continue = 'Y';
238700191216         else;
238800191216           g2Bad  = *Blanks;
238900191216           g2Bacd = *Blanks;
239000191216           g2Bacl = *Blanks;
239100191216           g2Babd = *Blanks;
239200191216           g2Baed = *Blanks;
239300191216           g2Bavo = *Blanks;
239400191216         endif;
239500150929
239600191216         //?LTD
239700191216         chain(n)( mbssno : Dep# : LtdDate : LtdPlan : LtdCovTp :
239800191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
239900191216         if not %Found(Guar014wf) and LtdPlan > *Blanks;
240000191216           Continue = 'Y';
240100191216         else;
240200191216           g2Ltd  = *Blanks;
240300191216           g2Ltcd = *Blanks;
240400191216           g2Ltcl = *Blanks;
240500191216           g2Ltbd = *Blanks;
240600191216           g2Lted = *Blanks;
240700191216           g2Ltvo = *Blanks;
240800191216         endif;
240900150929
241000191216         //?Life
241100191216         chain(n)( mbssno : Dep# : LifeDate : LifePlan : LifeCovTp :
241200191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
241300191216         if not %Found(Guar014wf) and LifePlan > *Blanks;
241400191216           Continue = 'Y';
241500191216         else;
241600191216           g2Bld  = *Blanks;
241700191216           g2Blcd = *Blanks;
241800191216           g2Blcl = *Blanks;
241900191216           g2Blbd = *Blanks;
242000191216           g2Bled = *Blanks;
242100191216           g2Blvo = *Blanks;
242200191216         endif;
242300150929
242400191216         //?Vision
242500191216         chain(n)( mbssno : Dep# : VisDate : VisPlan : VisCovTp :
242600191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
242700191216         if not %Found(Guar014wf) and VisPlan > *Blanks;
242800191216           Continue = 'Y';
242900191216         else;
243000191216           g2Vid  = *Blanks;
243100191216           g2vicd = *Blanks;
243200191216           g2vicl = *Blanks;
243300191216           g2vibd = *Blanks;
243400191216           g2Vied = *Blanks;
243500191216         endif;
243600150929
243700191216         //?VOLLIF
243800191216         chain(n)( mbssno : Dep# : VolLifDate : VolLifPlan : VolLifCovTp :
243900191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
244000191216         if not %Found(Guar014wf) and VolLifPlan > *Blanks;
244100191216           Continue = 'Y';
244200191216         else;
244300191216           g2Sld  = *Blanks;
244400191216           g2Slcd = *Blanks;
244500191216           g2slvo = *Blanks;
244600191216           g2slcl = *Blanks;
244700191216           g2slbd = *Blanks;
244800191216           g2sled = *Blanks;
244900191216         endif;
245000150929
245100150929
245200191216         //?STD
245300191216         chain(n)( mbssno : Dep# : StdDate : StdPlan : StdCovTp :
245400191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
245500191216         if not %Found(Guar014wf) and StdPlan > *Blanks;
245600191216           Continue = 'Y';
245700191216         else;
245800191216           g2Std  = *Blanks;
245900191216           g2Stcl = *Blanks;
246000191216           g2Stbd = *Blanks;
246100191216           g2Sted = *Blanks;
246200191216           g2stvo = *Blanks;
246300191216           g2stcd = *Blanks;
246400191216         endif;
246500150929
246600191216         //?VOLLTD
246700191216         chain(n)( mbssno : Dep# : VolLtdDate : VolLtdPlan : VolLtdCovTp :
246800191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
246900191216         if not %Found(Guar014wf) and VolLtdPlan > *Blanks;
247000191216           Continue = 'Y';
247100191216         else;
247200191216           g2Vld  = *Blanks;
247300191216           g2vlcd = *Blanks;
247400191216           g2vlcl = *Blanks;
247500191216           g2vlbd = *Blanks;
247600191216           g2vled = *Blanks;
247700191216           g2vlvo = *Blanks;
247800191216         endif;
247900150929
248000191216         //?VOLADD
248100191216         chain(n)( mbssno : Dep# : VolAddDate : VolAddPlan : VolAddCovTp :
248200191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
248300191216         if not %Found(Guar014wf) and VolAddPlan > *Blanks;
248400191216           Continue = 'Y';
248500191216         else;
248600191216           g2vad  = *Blanks;
248700191216           g2vacd = *Blanks;
248800191216           g2vavo = *Blanks;
248900191216           g2vacl = *Blanks;
249000191216           g2vabd = *Blanks;
249100191216           g2vaed = *Blanks;
249200191216         endif;
249300151102
249400160804
249500191216         //?ACC - Accident
249600191216         chain(n)( mbssno : Dep# : AccDate : AccPlan : AccCovTp :
249700191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
249800191216         if not %Found(Guar014wf) and AccPlan > *Blanks;
249900191216           Continue = 'Y';
250000191216         else;
250100191216           g2acd  = *Blanks;
250200191216           g2accd = *Blanks;
250300191216           g2accl = *Blanks;
250400191216           g2acbd = *Blanks;
250500191216           g2aced = *Blanks;
250600191216         endif;
250700160804
250800170123
250900191216         //?HOSP - Hospital
251000191216         chain(n)( mbssno : Dep# : HosDate : HosPlan : HosCovTp :
251100191216                   mbTrst : mbSub# : mbAcct) Guar014wf;
251200191216         if not %Found(Guar014wf) and HosPlan > *Blanks;
251300191216           Continue = 'Y';
251400191216         else;
251500191216           g2Hod  = *Blanks;
251600191216           g2Hocd = *Blanks;
251700191216           g2Hocl = *Blanks;
251800191216           g2Hobd = *Blanks;
251900191216           g2Hoed = *Blanks;
252000191216         endif;
252100170123
252200150929
252300191216       EndSr;
252400151215
252500191216       //--------------------------------------------------------------------
252600191216       Begsr $HeaderRcd;
252700151215
252800191216         Clear gf011f;
252900151215
253000191216         g1gNam = GrpName;
253100191216         g1gNbr = caCid2;
253200191216         g1Date = %Char(%Dec(%Date));
253300191216         // g1tp   = 'P' ;
253400191216         g1tp   = Filetype;
253500151215
253600191216         Write gf011f;
253700151215
253800191216       EndSr;
253900151215
254000151215
254100191216       //--------------------------------------------------------------------
254200191216       Begsr $FooterRcd;
254300151215
254400191216         Clear gf013f;
254500151215
254600191216         g3Recs = %Editc(RcdCount : 'X');
254700191216         write gf013f;
254800151215
254900191216       EndSr;
255000151215
255100191216       //--------------------------------------------------------------------
255200191216       Begsr $OpenFiles;
255300191216         open Guar011wf;
255400191216         open Guar012wf;
255500191216         open Guar012lf;
255600191216         open Guar013wf;
255700191216         open Guar014wf;
255800191216       EndSr;
255900151215
256000191216       //--------------------------------------------------------------------
256100191216       Begsr $CloseFiles;
256200191216         Close Guar011wf;
256300191216         Close Guar012wf;
256400191216         Close Guar012lf;
256500191216         Close Guar013wf;
256600191216         Close Guar014wf;
256700191216       EndSr;
256800151215
256900191216       //--------------------------------------------------------------------
257000191216       Begsr $Check_Class;
257100151216
257200191216         //?Override the Class.. If Needed.
257300191216         if cpCid3 > *Blanks and  caCid4 <> cpCid3;
257400151216
257500191216           //?if we already have a class... Dont update
257600191216           //?if this plan has been canceled.
257700191216           if g2Clas = *Blanks;
257800191216             g2Clas = cpCid3;
257900190506
258000191216br15         if g2cled < %Char(EnrollDt);
258100191216               g2cled = %Char(EnrollDt);
258200191216             endif;
258300190506
258400190506
258500191216           else;
258600191216             if CancelDt = 0 or CancelDt = 99999999;
258700191216               g2Clas = cpCid3;
258800191216br18           g2cled = %Char(EnrollDt);
258900191216br18           g2Dved = %Char(EnrollDt);
259000191216             endif;
259100191216           endif;
259200151216
259300191216         endif;
259400151216
259500151216
259600191216         //?Check to see if the Department Code has to
259700191216         //?match the Class Code.
259800191216         if Dept_Class = 'Y';
259900191216           g2Dept = g2Clas;
260000191216         endif;
260100151216
260200191216       EndSr;
260300160309
260400191216       //--------------------------------------------------------------------
260500191216br01   Begsr $Check_VolLif;
260600160309
260700191216         if has_VolLif = 'Y';
260800160309
260900191216           has_Emp = '';
261000191216           has_Esp = '';
261100191216           has_Ech = '';
261200191216           has_Fam = '';
261300160309
261400191216           //?Get the Coverage Levels for all Vol Life for the Member...
261500191216           setll ( caCid2 : %Editc(mbssno:'X') ) Guar012lf;
261600191216           dou %Eof(Guar012lf);
261700191216             Reade(n) ( caCid2 : %Editc(mbssno:'X') ) Guar012lf;
261800160309
261900191216             if %Eof(Guar012lf);
262000191216               leave;
262100191216             endif;
262200160309
262300191216             Select;
262400191216             When g2slcl = 'EMP';
262500191216               has_EMP = 'Y';
262600191216             When g2slcl = 'ESP';
262700191216               has_ESP = 'Y';
262800191216             When g2slcl = 'ECH';
262900191216               has_ECH = 'Y';
263000191216             When g2slcl = 'FAM';
263100191216               has_FAM = 'Y';
263200191216             Endsl;
263300160309
263400191216           Enddo;
263500160309
263600191216           //?Set New Coverage..
263700191216           New_Covg = '';
263800160309
263900191216           Select;
264000191216           When has_FAM = 'Y';
264100191216             New_Covg = 'FAM';
264200160309
264300191216           When has_ECH = 'Y';
264400191216             New_Covg = 'ECH';
264500160309
264600191216           When has_ESP = 'Y';
264700191216             New_Covg = 'ESP';
264800160309
264900191216           When has_EMP = 'Y';
265000191216             New_Covg = 'EMP';
265100191216           Endsl;
265200160309
265300191216           //?Update File..
265400191216           setll ( caCid2 : %Editc(mbssno:'X') ) Guar012lf;
265500191216           dou %Eof(Guar012lf);
265600191216             Reade ( caCid2 : %Editc(mbssno:'X') ) Guar012lf;
265700191216             if %Eof(Guar012lf);
265800191216               leave;
265900191216             endif;
266000160311
266100191216             if g2slcl > *Blanks;
266200191216               g2slcl = New_Covg;
266300191216               update Rcd2;
266400191216             endif;
266500160311
266600191216           enddo;
266700191216         endif;
266800160309
266900191216       EndSr;
267000151216
267100170316
267200191216       //--------------------------------------------------------------------
267300191216br10   Begsr Check_BOR;
267400170316
267500191216         BorKey = %editc(caTrst : 'X') + %editc(caSub# : 'X') +
267600191216                  %editc(caAcct : 'X');
267700170316
267800180529
267900191216         setll ( BorKey : 'DAC' ) HistAA;
268000191216         dou %Eof( HistAA ) ;
268100191216           reade ( BorKey : 'DAC' ) HistAA;
268200191216           if %Eof( HistAA );
268300191216             leave;
268400191216           endif;
268500180529
268600191216           if CovtDt >= %Dec(%Date);
268700191216             BorCount = 1;
268800191216             leave;
268900191216           endif;
269000191216         enddo;
269100170316
269200180529
269300191216         if BorCount > 0;
269400201103           Exec Sql
269500201103             Update CarAccp
269600201103               Set caStatus = 'N'
269700201103               where caUniq = :caUniq and
269800201103               caTrst = :caTrst and
269900201103               caSub# = :caSub# and
270000201103               caAcct = :caAcct;
270100170316
270200191216jt01       exsr add_toTransfile;
270300180911
270400201103           Exec Sql
270500201103             Update Guartranp
270600201103               Set gtChgBy = 'AUTO_BOR', gtChgDt =
270700201103                     int(replace(char(current_date, ISO), '-', '')), gtChgTm =
270800201103                     int(replace(char(current_time), ':', ''))
270900201103               Where gtUniq = :caUniq and
271000201103               gtTrst = :caTrst and
271100201103               gtSub# = :caSub# and
271200201103               gtAcct = :caAcct;
271300170316
271400191216         endif;
271500170316
271600191216       Endsr;
271700200604
271800200604       //--------------------------------------------------------------------
271900200604br20   Begsr Get_SalChgDt;
272000200604
272100200604         // This will read through the History file
272200200604         // looking for the last salary changed record.
272300200604
272400200604         Emp_Key = ' ' + %editc(mbssno : 'X');
272500200604
272600200604         setll ( Emp_Key : 'M17' ) HistAA;
272700200604         dou %Eof( HistAA ) ;
272800200604           reade ( Emp_Key : 'M17' ) HistAA;
272900200604           if %Eof( HistAA );
273000200604             leave;
273100200604           endif;
273200200604
273300200604           g2saed = %char( CovtDt );
273400200604         enddo;
273500200604
273600200604       endsr;
273700200604
273800180911jt01   //===========================================================================================
273900180911 ¦     // Add to Transmission file
274000180911\¦/    //===========================================================================================
274100180911
274200180911       begsr add_toTransfile;
274300180911
274400191216         incarrier = 13;
274500180911
274600191216         if castatus = 'Y';
274700191216           ioption = 'D';
274800191216         endif;
274900180911
275000191216         if castatus = 'N';
275100191216           ioption = 'A';
275200191216         endif;
275300180911
275400191216/¦\      dltadd(catrst : casub# : caacct : incarrier : ioption);
275500180911 ¦
275600180911jt01   endsr;
275700180911
275800180911       //===========================================================================================
275900180911
276000150818      /End-Free
276100150821      *--------------------------------------------------------------------------
276200150821      *?             * * * *      P R O C E D U R E S     * * * *
276300150821      *--------------------------------------------------------------------------
276400150821
276500150821      *--------------------------------------------------------------------------
276600150821      *?Get the Coverage Level.
276700150821      *--------------------------------------------------------------------------
276800150818     p #GetCovgLvl     b
276900150818
277000150818     d #GetCovgLvl     pi             3a
277100150818     d   DataIn                       3a   value
277200150818     d  DataOut        s              3a   inz
277300150818
277400150818      /Free
277500150818
277600191216       Select;
277700191216       When DataIn = 'TIN';
277800191216         DataOut = 'EMP';
277900191216       When DataIn = 'THW';
278000191216         DataOut = 'ESP';
278100191216       When DataIn = 'TPC' or DataIn = 'TP2';
278200191216         DataOut = 'ECH';
278300191216       When DataIn = 'TFA';
278400191216         DataOut = 'FAM';
278500191216       Endsl;
278600150818
278700191216       Return DataOut;
278800150818
278900150818      /End-Free
279000150818
279100150818     p #GetCovgLvl     e
279200150821
279300150821
279400170216      *--------------------------------------------------------------------------
279500210706      * Get the Coverage Level for Dependent Life
279600170216      *--------------------------------------------------------------------------
279700170216     p #GetDLCovgLvl   b
279800170216
279900170216     d #GetDLCovgLvl   pi             3a
280000170216     d   DataIn                       3a   value
280100170216     d  DataOut        s              3a   inz
280200170216
280300170216      /Free
280400170216
280500191216       Select;
280600191216       When DataIn = 'TIN';
280700210706         DataOut = 'EMP';
280800191216       When DataIn = 'THW';
280900191216         DataOut = 'SPO';
281000191216       When DataIn = 'TPC' or DataIn = 'TP2';
281100191216         DataOut = 'CHD';
281200170620
281300191216       //?Per Ron Mass; For an Error with American Telecom;
281400191216       //?Dependent Life for Children are setup as Family.
281500191216       When DataIn = 'TFA';
281600191216         DataOut = 'CHD';
281700191216       Endsl;
281800170216
281900191216       Return DataOut;
282000170216
282100170216      /End-Free
282200170216
282300170216     p #GetDLCovgLvl   e
282400170216
282500170216
282600161108br07  *--------------------------------------------------------------------------
282700161108      *?Get the Voluntary Coverage Level.
282800161108      *--------------------------------------------------------------------------
282900161108     p #GetVol_Lvl     b
283000161108
283100161108     d #GetVol_Lvl     pi             3a
283200161108     d   inTrst                       3s 0 value
283300161108     d   inSub#                       3s 0 value
283400161108     d   inPlan                       4a   value
283500161108
283600161108     d  DataOut        s              3a   inz
283700161108
283800161108      /Free
283900161108
284000191216       chain (inTrst : inSub# : inPlan) PlnMst;
284100191216       chain plnCat Codesl1;
284200161108
284300191216       Select;
284400191216       when sDescr = 'VOL LF DEP';
284500191216         DataOut = 'CHD';
284600191216       when sDescr = 'VOL AD DEP';
284700191216         DataOut = 'CHD';
284800191216       when sDescr = 'VOL LF SP';
284900191216         DataOut = 'SPO';
285000191216       when sDescr = 'VOL AD SP';
285100191216         DataOut = 'SPO';
285200191216       when sDescr = 'VOL LF EE';
285300191216         DataOut = 'EMP';
285400191216       when sDescr = 'VOL AD EE';
285500191216         DataOut = 'EMP';
285600200624
285700200624       when sDescr = 'VOLCRT_EE';
285800200624         DataOut = 'EMP';
285900200624       when sDescr = 'VOLCRT_SP';
286000200624         DataOut = 'SPO';
286100200624       when sDescr = 'VOLCRT_CHD';
286200200624         DataOut = 'CHD';
286300191216       Endsl;
286400161108
286500191216       Return DataOut;
286600161108
286700161108      /End-Free
286800161108
286900161108     p #GetVol_Lvl     e
287000161108
287100161108
287200150821      *--------------------------------------------------------------------------
287300150821      *?Get the RelationShip Code.
287400150821      *--------------------------------------------------------------------------
287500150821     p #GetRelCode     b
287600150821
287700150821     d #GetRelCode     pi             2a
287800150821     d   DataIn                       3a   value
287900150821     d  DataOut        s              2a   inz
288000150821
288100150821      /Free
288200150821
288300191216       Select;
288400191216       When DataIn = 'RWI' or DataIn = 'RHU';
288500191216         DataOut = 'SP';
288600191216       When DataIn = 'RSO' or DataIn = 'RDA';
288700191216         DataOut = 'CH';
288800191216       When DataIn = 'RPA';
288900191216         DataOut = 'DP';
289000191216       Endsl;
289100150821
289200191216       Return DataOut;
289300150821
289400150821      /End-Free
289500150821
289600150821     p #GetRelCode     e
289700150904
289800150904
289900151023      *--------------------------------------------------------------------------
290000151023      *?Get the Division Code from the Cost Center code.
290100151023      *--------------------------------------------------------------------------
290200151023     p #GetDivCode     b
290300151023
290400151023     d #GetDivCode     pi             4a
290500151023     d   DataIn                       3a   value
290600151023     d  DataOut        s              4a   inz
290700151023
290800151023      /Free
290900151023
291000191216       Select;
291100191216       When DataIn = 'YK8';
291200191216         DataOut = '0000';
291300191216       When DataIn = 'YXZ';
291400191216         DataOut = '0001';
291500191216       When DataIn = 'YLM';
291600191216         DataOut = '0002';
291700191216       When DataIn = 'YKY';
291800191216         DataOut = '0003';
291900191216       When DataIn = 'YKZ';
292000191216         DataOut = '0004';
292100191216       When DataIn = 'YXY';
292200191216         DataOut = '0007';
292300191216       Endsl;
292400151023
292500191216       Return DataOut;
292600151023
292700151023      /End-Free
292800151023
292900151023     p #GetDivCode     e
293000151023
293100160621
293200160621      *--------------------------------------------------------------------------
293300160621      *?Check the Guardian Override File.
293400160621      *--------------------------------------------------------------------------
293500160621     p #CheckOverRide  b
293600160621
293700160621     d #CheckOverRide  pi            20a
293800160621     d   inType                      10a   value
293900160621     d   inData                      20a   value
294000160621     d  DataOut        s             20a   inz
294100160621
294200160621      /Free
294300191216       DataOut = inData;
294400160621
294500191216       //-----------------------------------------
294600191216       //?Division Override
294700191216       //-----------------------------------------
294800220222       if inType = 'DIVISION' or inType = 'CLASS';
294900191216         setll (caUniq : caTrst : caSub# : caAcct: inType) GuarOvrdp;
295000191216         dou %Eof(GuarOvrdp);
295100191216           reade (caUniq : caTrst : caSub# : caAcct: inType) GuarOvrdp;
295200160621
295300191216           if %Eof(GuarOvrdp);
295400191216             leave;
295500191216           endif;
295600160621
295700191216           //?State Check
295800191216           if goCheck = 'STATE';
295900191216             if State = goComp;
296000191216               DataOut = goRepl;
296100191216               leave;
296200191216             endif;
296300191216           endif;
296400191216         enddo;
296500191216       endif;
296600160621
296700161020
296800161020
296900191216       Return DataOut;
297000160621
297100160621      /End-Free
297200160621
297300160621     p #CheckOverRide  e
297400160621
