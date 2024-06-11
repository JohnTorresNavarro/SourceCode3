000100151217     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200141211    ? *-------------------------------------------------------------------------
000300000000    ? *
000400170803    ? *  Description: NVA - New Account / Plan Auto Setup
000500170802    ? *  Programmer.: Brian Rees
000600170803    ? *  Date.......: 08/03/2017
000700141210    ? *
000800170803    ? *  Notes: This program will look at all active NVA plans. It will then
000900170803    ? *           (1) Check to see if the plan is setup in the Carrier Plan
001000170802    ? *               file. If it is not, we will add the plan to the file,
001100170802    ? *               and send an email to Brian to review.
001200170802    ? *
001300170803    ? *         The only setup that we would have to do, is the Processor
001400170803    ? *         Control ID which is sent to us by NVA.
001500170802    ? *
001600180927    ? *
001700180927    ? *-------------------------------------------------------------------------
001800180927    ? * Change Log:
001900180927    ? * 9/27/2018  B.Rees
002000180927    ? *  When checking F.Grate for the group number - If not found, based on the rate
002100180927    ? *  starting later than TODAY, recheck for anything greater than TODAY
002200180927    ? *
002300180927    ? *
002400141211    ? *-------------------------------------------------------------------------
002500170801     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
002600180509    ?FCarPlnx   uf a e           k Disk
002700170802    ?FCarAccp   if a e           k Disk
002800170803    ?FGbs0023p  o    e           k Disk
002900170801
003000170802
003100141211    ? *-------------------------------------------------------------------------
003200170802     D PGMD          ESDS                  EXTNAME(IOPGMD)
003300170802
003400170725     D @Data           ds
003500170801     D  sqTrst                        3s 0
003600170801     D  sqSub#                        3s 0
003700170801     D  sqAcct                        4s 0
003800170725     D  sqPlan                        4
003900170725     D  sqDescr                      40
004000170725
004100170801     d UniqueID        S             10    inz
004200170801
004300170801     d savSqlCod       S                   like(SqlCod)
004400170801     d hldGroup#       S             15    inz
004500170802     d SavTSA          S             10    inz
004600170802     d CurrTSA         S             10    inz
004700180511     d wDate           s              8s 0 inz
004800180511
004900151217      *--------------------------------------------
005000151217      *?Procedures
005100151217      *--------------------------------------------
005200170803     d EmailNVA        pr                  ExtPgm('GBS0023C1')
005300170801     d  oGroup                       40
005400170803     d  oGroupNbr                    15
005500170801
005600160701
005700141211    ? *-------------------------------------------------------------------------
005800151216      *?Mainline Program
005900141211    ? *-------------------------------------------------------------------------
006000170802     C     *entry        plist
006100170802     C                   parm                    pContinue         1
006200151216
006300170803        UniqueID = '0000000115';
006400170802        pContinue = 'N';
006500170802
006600180509          //?This will automatically load all of the NVA plans
006700170725          //?from the Commission control File.
006800170725
006900170801          Exec Sql   Declare C1 Cursor For
007000170803              Select Cmtrst, Csubdv, Cmacct, Plplan, Pdescr
007100170801              From "F.PLNMST"
007200170801              Join "F.COMCTX" On Pltrst = Cmtrst
007300170801                             and Plsub# = Csubdv
007400170801                             and Plplan = Cmplan
007500170801              Where
007600170803                  Pcarr In ('NVA', 'NV1', 'NMD', 'NAN')  And
007700170801                  Pldltd = 'A' and cmdltd = 'A'
007800170801
007900170801              Order By Cmtrst, Csubdv, Cmacct;
008000170801
008100170725
008200170801          Exec Sql    Open C1;
008300170725
008400170801          //?Read through the SQL
008500170725          Dou SqlCod <> *Zero;
008600170801             Exec Sql  Fetch Next From C1 Into :@data  ;
008700170725
008800170725             if SqlCod <> *Zero;
008900170725                leave;
009000170725             endif;
009100170725
009200170801
009300170801             //?Is This account setup yet?
009400170803             chain ( UniqueID : sqTrst : sqSub# : sqAcct ) CarAccp;
009500170803             if not %Found( CarAccp );
009600170802                savTSA = %Editc(sqTrst:'X') + %Editc(sqSub#:'X') +
009700170802                         %Editc(sqAcct:'X');
009800170801                Exsr NewGrp_Setup;
009900180927
010000180927                //?if the group number isn't setup yet... check later.
010100180927                if hldGroup# = '';
010200180927                 iter;
010300180927                endif;
010400180927             endif;
010500180927
010600180927
010700170802             //?Is This plan setup yet?
010800170802             chain ( sqTrst : sqSub# : sqAcct : sqPlan ) CarPlnx;
010900170802             if not %Found( CarPlnx );
011000170802                pContinue = 'Y';
011100170802                Exsr NewPlan_Setup;
011200180509             else;
011300180509                Exsr Update_Plan;
011400180509                unlock CarPlnx;
011500170802             endif;
011600170802
011700170801
011800170801
011900170725          enddo;
012000170725
012100170725          Exec Sql   Close C1;
012200170725
012300170725
012400170725
012500170801          *inlr = *on;
012600170801      *------------------------------------------------------------
012700170801       Begsr NewGrp_Setup;
012800170801
012900170801           chain (sqTrst: sqSub#: sqAcct) AccMst;
013000170801
013100180511           wDate = %Dec(%Date);
013200180511
013300170801           //?Get Group Number...
013400170801           savSqlCod = SqlCod;
013500170801           Exec Sql Select Group# into :hldGroup#
013600170801             From "F.GRATE"
013700170801             Where grTrst = :sqTrst and grSub# = :sqSub#
013800170801               and grPlan = :sqPlan and grdltd = 'A'
013900180511               and :wDate between FrmDat and toDat
014000170801             Fetch first row only;
014100170801
014200180927          if SqlCod <> 0;
014300180927             hldGroup# = '';
014400180927
014500180927             // Try Again
014600180927             Exec Sql Select Group# into :hldGroup#
014700180927               From "F.GRATE"
014800180927               Where grTrst = :sqTrst and grSub# = :sqSub#
014900180927               and grPlan = :sqPlan and grdltd = 'A'
015000180927               and FrmDat >= :wDate
015100180927               Fetch first row only;
015200180927
015300180927              if SqlCod <> 0;
015400180927               hldGroup# = '';
015500180927               endif;
015600180927
015700180927          endif;
015800180927
015900180927          SqlCod = savSqlCod;
016000180108
016100180927          // Only process if a group# is setup.
016200180927          if hldGroup# = '';
016300180927             leavesr;
016400180927          endif;
016500180927
016600180927
016700180108           // Check to see if this file name is aready in use.
016800180108           // if it is - retrieve the Processer Control ID.
016900180108
017000180108           caCid1 = 'NV' + %Subst(HldGroup# : 1 : 5);
017100180108           caCid2 = *Blanks;
017200180108
017300180108           Exec Sql Select cacid2 into :caCid2
017400180108             From CarAccp
017500180108             Where caUniq = :UniqueID and caCid1 = :caCid1
017600180108               and caStatus = 'Y'
017700180108             Fetch first row only;
017800180108
017900180108
018000180108
018100180108
018200180108
018300170803           caUniq = UniqueId;
018400170801           caTrst = sqTrst;
018500170801           caSub# = sqSub#;
018600170801           caAcct = sqAcct;
018700170801
018800170803           CaTxt1 = 'Export File Name';
018900170803           CaTxt2 = 'Control Id';
019000170803
019100170803           caCid1 = 'NV' + %Subst(HldGroup# : 1 : 5);
019200180108         //caCid2 = *Blanks;
019300170803
019400180324           caStatus = 'Y';
019500180529
019600180529           caCidA = 'Created: ' + 'GBS0023R  ' + %Char(%Dec(%Date));
019700180529           caTxtA = '';
019800170803
019900170803           Write CarAccr;
020000170801
020100170801
020200170803           //?Send the initial email to NVA
020300180108           if caCid2 = *Blanks;
020400170803           EmailNVA( acNam1 : hldGroup# );
020500180108           endif;
020600170801
020700170801
020800170801       Endsr;
020900170801
021000170802      *------------------------------------------------------------
021100170802       Begsr NewPlan_Setup;
021200170802          Clear Carplnr;
021300170802
021400170803          cpuniq = UniqueId;
021500170802          cpTrst = sqTrst;
021600170802          cpSub# = sqSub#;
021700170802          cpAcct = sqAcct;
021800170802          cpPlan = sqPlan;
021900170802
022000180511          wDate = %Dec(%Date);
022100170803
022200170803          // Get Group Number...
022300170803          savSqlCod = SqlCod;
022400170803          Exec Sql Select Group# into :hldGroup#
022500170803             From "F.GRATE"
022600170803             Where grTrst = :sqTrst and grSub# = :sqSub#
022700170803               and grPlan = :sqPlan and grdltd = 'A'
022800180511               and :wDate between FrmDat and toDat
022900170803             Fetch first row only;
023000180927
023100180927          if SqlCod <> 0;
023200180927             hldGroup# = '';
023300180927
023400180927             // Try Again
023500180927             Exec Sql Select Group# into :hldGroup#
023600180927               From "F.GRATE"
023700180927               Where grTrst = :sqTrst and grSub# = :sqSub#
023800180927               and grPlan = :sqPlan and grdltd = 'A'
023900180927               and FrmDat >= :wDate
024000180927               Fetch first row only;
024100180927
024200180927              if SqlCod <> 0;
024300180927               hldGroup# = '';
024400180927               endif;
024500180927
024600180927          endif;
024700180927          SqlCod = savSqlCod;
024800170803
024900170803          cpTxt1 = 'Group Number';
025000170803          cpCid1 = %Trim(hldGroup#);
025100170803
025200180529          cpCidA = 'Created: ' + 'GBS0023R  ' + %Char(%Dec(%Date));
025300180529          cpTxtA = '';
025400180529
025500170803          Write CarPlnr;
025600170802
025700170802
025800170802          //--------------------------------------------
025900170802          //?Write the Plan information to the workfile.
026000170802          //--------------------------------------------
026100170802          chain (sqTrst: sqSub#: sqAcct) AccMst;
026200170802
026300170803          nvTrst = sqTrst;
026400170803          nvSub# = sqSub#;
026500170803          nvAcct = sqAcct;
026600170803          nvNam1 = acNam1;
026700170803          nvPlan = sqPlan;
026800170803          nvDescr = sqDescr;
026900170803          nvGroup = hldGroup#;
027000170803
027100170803
027200170802          // Check to see if this record is for a new account
027300170802          // or just a new plan
027400170802          CurrTSA = %Editc(sqTrst:'X') + %Editc(sqSub#:'X') +
027500170802                    %Editc(sqAcct:'X');
027600170802
027700170802          if CurrTSA = SavTSA;
027800170803             nvType = 'New Acct';
027900170802          else;
028000170803             nvType = 'New Plan';
028100170802          endif;
028200170802
028300170802
028400170803          Write r_NewNVA;
028500170802
028600170802       Endsr;
028700170802
028800180509      *------------------------------------------------------------
028900180509       Begsr Update_Plan;
029000180509
029100180511          wDate = %Dec(%Date);
029200180511
029300180509          // Get Group Number...
029400180509          savSqlCod = SqlCod;
029500180509          Exec Sql Select Group# into :hldGroup#
029600180509             From "F.GRATE"
029700180509             Where grTrst = :sqTrst and grSub# = :sqSub#
029800180509               and grPlan = :sqPlan and grdltd = 'A'
029900180511               and :wDate between FrmDat and toDat
030000180509             Fetch first row only;
030100180719
030200180719          // Not Found.. Skip the Date..
030300180719          if sqlCod = 100;
030400180719          Exec Sql Select Group# into :hldGroup#
030500180719             From "F.GRATE"
030600180719             Where grTrst = :sqTrst and grSub# = :sqSub#
030700180719               and grPlan = :sqPlan and grdltd = 'A'
030800180719               order by toDat desc
030900180719             Fetch first row only;
031000180719          endif;
031100180719
031200180509          SqlCod = savSqlCod;
031300180509
031400180509          if hldGroup# <> cpCid1;
031500180509             cpCid1 = %Trim(hldGroup#);
031600180529             cpTxtA = 'Changed: ' + 'GBS0023R  ' + %Char(%Dec(%Date));
031700180509             update CarPlnr;
031800180509          endif;
031900180509
032000180509       Endsr;
032100180509
