000100151217     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200141211    ? *-------------------------------------------------------------------------
000300000000    ? *
000400170803    ? *  Description: VSP - New Account / Plan Auto Setup
000500170802    ? *  Programmer.: Brian Rees
000600170803    ? *  Date.......: 08/03/2017
000700141210    ? *
000800170803    ? *  Notes: This program will look at all active VSP plans. It will then
000900170803    ? *           (1) Check to see if the plan is setup in the Carrier Plan
001000170802    ? *               file. If it is not, we will add the plan to the file,
001100170802    ? *               and send an email to Brian to review.
001200170802    ? *
001300170803    ? *         The only setup that we would have to do, is the Division Code
001400170803    ? *         that sent to us by VSP.
001500170802    ? *
001600141211    ? *-------------------------------------------------------------------------
001700170801     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
001800170802    ?FCarPlnx   if a e           k Disk
001900170802    ?FCarAccp   if a e           k Disk
002000170803    ?FGbs0022p  o    e           k Disk
002100170801
002200170802
002300141211    ? *-------------------------------------------------------------------------
002400170802     D PGMD          ESDS                  EXTNAME(IOPGMD)
002500170802
002600170725     D @Data           ds
002700170801     D  sqTrst                        3s 0
002800170801     D  sqSub#                        3s 0
002900170801     D  sqAcct                        4s 0
003000170725     D  sqPlan                        4
003100170725     D  sqDescr                      40
003200190723     D  sqCarr                        3
003300170725
003400170801     d UniqueID        S             10    inz
003500170801
003600170801     d savSqlCod       S                   like(SqlCod)
003700170801     d hldGroup#       S             15    inz
003800170802     d SavTSA          S             10    inz
003900170802     d CurrTSA         S             10    inz
004000170801
004100151217      *--------------------------------------------
004200151217      *?Procedures
004300151217      *--------------------------------------------
004400170803     d EmailVSP        pr                  ExtPgm('GBS0022C1')
004500170801     d  oGroup                       40
004600170803     d  oGroupNbr                    15
004700170801
004800160701
004900141211    ? *-------------------------------------------------------------------------
005000151216      *?Mainline Program
005100141211    ? *-------------------------------------------------------------------------
005200170802     C     *entry        plist
005300170802     C                   parm                    pContinue         1
005400151216
005500170803        UniqueID = '0000000092';
005600170802        pContinue = 'N';
005700170802
005800170725          //?This will automatically load all of the Guardian plans
005900170725          //?from the Commission control File.
006000170725
006100170801          Exec Sql   Declare C1 Cursor For
006200190723              Select Cmtrst, Csubdv, Cmacct, Plplan, Pdescr, pCarr
006300170801              From "F.PLNMST"
006400170801              Join "F.COMCTX" On Pltrst = Cmtrst
006500170801                             and Plsub# = Csubdv
006600170801                             and Plplan = Cmplan
006700170801              Where
006800170803                  Pcarr In ('VSP', 'EVT', 'VIS')  And
006900170801                  Pldltd = 'A' and cmdltd = 'A'
007000170801
007100170801              Order By Cmtrst, Csubdv, Cmacct;
007200170801
007300170725
007400170801          Exec Sql    Open C1;
007500170725
007600170801          //?Read through the SQL
007700170725          Dou SqlCod <> *Zero;
007800170801             Exec Sql  Fetch Next From C1 Into :@data  ;
007900170725
008000170725             if SqlCod <> *Zero;
008100170725                leave;
008200170725             endif;
008300170725
008400170801
008500170801             //?Is This account setup yet?
008600170803             chain ( UniqueID : sqTrst : sqSub# : sqAcct ) CarAccp;
008700170803             if not %Found( CarAccp );
008800170802                savTSA = %Editc(sqTrst:'X') + %Editc(sqSub#:'X') +
008900170802                         %Editc(sqAcct:'X');
009000190927            //    if sqCarr <> 'EVT';
009100190723                   Exsr NewGrp_Setup;
009200190927            //    endif;
009300170725             endif;
009400170725
009500170801
009600170802             //?Is This plan setup yet?
009700170802             chain ( sqTrst : sqSub# : sqAcct : sqPlan ) CarPlnx;
009800170802             if not %Found( CarPlnx );
009900170802                pContinue = 'Y';
010000170802                Exsr NewPlan_Setup;
010100170802             endif;
010200170802
010300170725          enddo;
010400170725          Exec Sql   Close C1;
010500170725
010600170725
010700170801          *inlr = *on;
010800170801      *------------------------------------------------------------
010900170801       Begsr NewGrp_Setup;
011000170801
011100170801           chain (sqTrst: sqSub#: sqAcct) AccMst;
011200170801
011300170801           //?Get Group Number...
011400170801           savSqlCod = SqlCod;
011500170801           Exec Sql Select Group# into :hldGroup#
011600170801             From "F.GRATE"
011700170801             Where grTrst = :sqTrst and grSub# = :sqSub#
011800170801               and grPlan = :sqPlan and grdltd = 'A'
011900170801             Fetch first row only;
012000170801
012100170803           caUniq = UniqueId;
012200170801           caTrst = sqTrst;
012300170801           caSub# = sqSub#;
012400170801           caAcct = sqAcct;
012500170801
012600170803           CaTxt1 = 'Account Name';
012700170801           caCid1 = %SubSt(acNam1:1:30);
012800180324           caStatus = 'Y';
012900170803
013000180529           caCidA = 'Created: ' + 'GBS0022R  ' + %Char(%Dec(%Date));
013100180529           caTxtA = '';
013200180529
013300170803           Write CarAccr;
013400170801
013500170801
013600170803           //?Send the initial email to VSP
013700190927            if sqCarr <> 'EVT';
013800170803           EmailVSP( acNam1 : hldGroup# );
013900190927           endif;
014000170801
014100170801
014200170801       Endsr;
014300170801
014400170802      *------------------------------------------------------------
014500170802       Begsr NewPlan_Setup;
014600170802          Clear Carplnr;
014700170802
014800170803          cpuniq = UniqueId;
014900170802          cpTrst = sqTrst;
015000170802          cpSub# = sqSub#;
015100170802          cpAcct = sqAcct;
015200170802          cpPlan = sqPlan;
015300170802
015400170803          cpTxt1 = 'Division Code';
015500170803          cpTxt2 = 'Division Code - Cobra';
015600170802
015700170803
015800170803          // Get Group Number...
015900170803          savSqlCod = SqlCod;
016000170803          Exec Sql Select Group# into :hldGroup#
016100170803             From "F.GRATE"
016200170803             Where grTrst = :sqTrst and grSub# = :sqSub#
016300170803               and grPlan = :sqPlan and grdltd = 'A'
016400170803             Fetch first row only;
016500180719
016600180719          // Not Found.. Skip the Date..
016700180719          if sqlCod = 100;
016800180719          Exec Sql Select Group# into :hldGroup#
016900180719             From "F.GRATE"
017000180719             Where grTrst = :sqTrst and grSub# = :sqSub#
017100180719               and grPlan = :sqPlan and grdltd = 'A'
017200180719               order by toDat desc
017300180719             Fetch first row only;
017400180719          endif;
017500180719
017600170803          SqlCod = savSqlCod;
017700170803
017800170803          cpCid1 = %Trim(hldGroup#) + '-0001-0001';
017900170803          cpCid2 = %Trim(hldGroup#) + '-0002-0002';
018000170803
018100180529          cpCidA = 'Created: ' + 'GBS0022R  ' + %Char(%Dec(%Date));
018200180529          cpTxtA = '';
018300180529
018400170803          Write CarPlnr;
018500170802
018600170802
018700170802          //--------------------------------------------
018800170802          //?Write the Plan information to the workfile.
018900170802          //--------------------------------------------
019000170802          chain (sqTrst: sqSub#: sqAcct) AccMst;
019100170802
019200170803          nvTrst = sqTrst;
019300170803          nvSub# = sqSub#;
019400170803          nvAcct = sqAcct;
019500170803          nvNam1 = acNam1;
019600170803          nvPlan = sqPlan;
019700170803          nvDescr = sqDescr;
019800170802
019900170802          // Check to see if this record is for a new account
020000170802          // or just a new plan
020100170802          CurrTSA = %Editc(sqTrst:'X') + %Editc(sqSub#:'X') +
020200170802                    %Editc(sqAcct:'X');
020300170802
020400170802          if CurrTSA = SavTSA;
020500170803             nvType = 'New Acct';
020600170802          else;
020700170803             nvType = 'New Plan';
020800170802          endif;
020900170802
021000170802
021100170803          Write r_NewVSP;
021200170802
021300170802       Endsr;
021400170802
