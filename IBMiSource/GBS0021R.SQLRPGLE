000100151217     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200141211    ? *-------------------------------------------------------------------------
000300000000    ? *
000400170802    ? *  Description: Guardian - New Account / Plan Auto Setup
000500170802    ? *  Programmer.: Brian Rees
000600170802    ? *  Date.......: 12/16/2015
000700141210    ? *
000800170802    ? *  Notes: This program will look at all active Guadian plans. It will then
000900170802    ? *         check to see if the
001000170802    ? *           (1) Account is setup in GuarTranp file.
001100170802    ? *               If not, it will send an email to Guardian and add the
001200170802    ? *               account to the file.
001300170802    ? *
001400170802    ? *           (2) Check to see if the plan is setup in the Carrier Plan
001500170802    ? *               file. If it is not, we will add the plan to the file,
001600170802    ? *               and send an email to Brian to review.
001700170802    ? *
001800170802    ? *         The only setup that we would have to do, is the File Requirements
001900170802    ? *         sent to us by Guardian.
002000170802    ? *
002001191212    ? *-------------------------------------------------------------------------
002002191212      * 12/12/2019   jt   Added call to "Do not Send" file
002003210110      * 01/10/2021   Br   Added to the Guardian Transmission Log File
002100141211    ? *-------------------------------------------------------------------------
002200170802    ?FGuarTranl1if a e           k Disk
002300170801     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
002400170802    ?FCarPlnx   if a e           k Disk
002500170802    ?FCarAccp   if a e           k Disk
002600170803     FClass     if   e           k disk    ExtDesc('F.CLASS') ExtFile(*extdesc)
002700170802    ?FGBS0021P  o    e           k Disk
002701210110
002702210110       dcl-f GuartLogp keyed usage(*output);
002800170801
002900170802
003000141211    ? *-------------------------------------------------------------------------
003100170802     D PGMD          ESDS                  EXTNAME(IOPGMD)
003200170802
003300170725     D @Data           ds
003400170801     D  sqTrst                        3s 0
003500170801     D  sqSub#                        3s 0
003600170801     D  sqAcct                        4s 0
003700170725     D  sqPlan                        4
003800170725     D  sqDescr                      40
003900170725     D  sqCat                         3
004000170725     D  sqGuarCode                   10
004100170725
004200170801     d NextId          s             10
004300170801     d UniqueID        S             10    inz
004400170801     d UniqueID#       S             10s 0 inz
004500170801     d UniqId          S              5s 0 inz
004600170801
004700170801     d savSqlCod       S                   like(SqlCod)
004800170801     d hldGroup#       S             15    inz
004900170802     d SavTSA          S             10    inz
005000170802     d CurrTSA         S             10    inz
005001191212     d option          s              1
005002191212     d incarrier       s              2  0
005100170801
005200151217      *--------------------------------------------
005300151217      *?Procedures
005400151217      *--------------------------------------------
005500170801     D zFill           PR           100
005600170801     D  Len                           3s 0 value
005700170801     D  text                        100    value
005800170801
005900170801
006000170802     d EmailGuardian   pr                  ExtPgm('GBS0021C1')
006100170801     d  oGroup                       40
006200170801     d  oGroupNbr                    30
006300170801
006301191212     d dltadd          pr                  ExtPgm('TROFF3')
006302191212     d  catrst                        3  0
006303191212     d  casub#                        3  0
006304191212     d  caacct                        4  0
006305191212     d  incarrier                     2  0
006306191212     d  option                        1
006400160701
006500141211    ? *-------------------------------------------------------------------------
006600151216      *?Mainline Program
006700141211    ? *-------------------------------------------------------------------------
006800170802     C     *entry        plist
006900170802     C                   parm                    pContinue         1
007000151216
007100151216
007200210110       pContinue = 'N';
007300170802
007400210110       //?This will automatically load all of the Guardian plans
007500210110       //?from the Commission control File.
007600170725
007700210110       Exec Sql
007800210110         Declare C1 Cursor For
007900210110           Select Cmtrst, Csubdv, Cmacct, Plplan, Pdescr, Plncat,
008000210110                  Case
008100210110                    When gcCode is not NULL then gcCode
008200210110                    Else 'Look me up'
008300210110                  End As Guardiancode
008400210110             From "F.PLNMST"
008500210110                  Join "F.COMCTX"
008600210110                    On Pltrst = Cmtrst and
008700210110                      Plsub# = Csubdv and
008800210110                      Plplan = Cmplan
008900210110                  Left Join GuarCatgp
009000210110                    on plnCat = gcPlnCat
009100210110             Where Pcarr In ('GAL', 'GAR', 'GAD') And
009200210110                   Pldltd = 'A' and
009201210110                   cmdltd = 'A'
009202210110             Order By Cmtrst, Csubdv, Cmacct;
009300170801
009400170725
009500210110       Exec Sql
009501210110         Open C1;
009600170725
009700210110       //?Read through the SQL
009800210110       Dou SqlCod <> *Zero;
009900210110         Exec Sql
009901210110           Fetch Next From C1
009902210110             Into :@data;
010000170725
010100210110         if SqlCod <> *Zero;
010200210110           leave;
010300210110         endif;
010400170725
010500170801
010600210110         //?Skip Town of Williamsport HOSP Plan
010700210110         if sqTrst = 3 and sqSub# = 1 and sqAcct = 1464 and
010800210110            sqPlan = 'NBEJ';
010900210110           iter;
011000210110         endif;
011100171204
011200171204
011300171204
011400171204
011500210110         //?Is This account setup yet?
011600210110         chain ( sqTrst : sqSub# : sqAcct ) GuarTranl1;
011700210110         if not %Found( GuarTranl1 );
011800210110           savTSA = %Editc(sqTrst:'X') + %Editc(sqSub#:'X') +
011900210110                    %Editc(sqAcct:'X');
012000210110           Exsr NewGrp_Setup;
012100210110         endif;
012200170725
012300170801
012400210110         //?Is This plan setup yet?
012500210110         chain ( sqTrst : sqSub# : sqAcct : sqPlan ) CarPlnx;
012600210110         if not %Found( CarPlnx );
012700210110           pContinue = 'Y';
012800210110           Exsr NewPlan_Setup;
012900210110         endif;
013000170802
013100170801
013200170801
013300210110       enddo;
013400170725
013500210110       Exec Sql
013501210110         Close C1;
013600170725
013700170725
013800170725
013900210110       *inlr = *on;
014000170801      *------------------------------------------------------------
014100170801       Begsr NewGrp_Setup;
014200170801
014300210110         chain (sqTrst: sqSub#: sqAcct) AccMst;
014400170801
014500210110         //?Get Group Number...
014600210110         savSqlCod = SqlCod;
014700210110         Exec Sql
014800210110           Select Group#
014900210110             into :hldGroup#
015000210110             From "F.GRATE"
015100210110             Where grTrst = :sqTrst and
015101210110                   grSub# = :sqSub# and
015102210110                   grPlan = :sqPlan and
015103210110                   grdltd = 'A'
015104210110             Fetch first row only;
015200170801
015300210110         //?Get Next Unique ID Number..
015400210110         Exec Sql
015500210110           Select Max(Cauniq)
015600210110             Into :Nextid
015700210110             From Caraccp
015701210110             Where Substring(Cauniq, 1, 1) = '0';
015800170801
015900210110         UniqId = %Dec(NextId:5:0) + 1;
016000210110         UniqueID# = UniqId;
016100210110         caUniq = %editc( UniqueId# : 'X');
016200170801
016300210110         caTrst = sqTrst;
016400210110         caSub# = sqSub#;
016500210110         caAcct = sqAcct;
016600170801
016700210110         CaTxt1 = 'Group Name';
016800210110         CaTxt2 = 'Group Number';
016900210110         CaTxt3 = 'Individual File Name';
017000210110         CaTxt4 = 'Class';
017100210110         CaTxt5 = 'Division';
017200170801
017300210110         caCid1 = %SubSt(acNam1:1:30);
017400210110         caCid2 = zFill(8 : %Trim(hldGroup#));
017500210110         caCid3 = %SubSt(acNam1:1:30);
017600210110         caCid3 = %ScanRpl( ' ' : '_' : caCid3 );
017700170802
017800170802
017900210110         caCid4 = *blanks;
018000210110         caCid5 = *blanks;
018100210110         caStatus = 'N';
018200180529
018300210110         caCidA = 'Created: ' + 'GBS0021R  ' + %Char(%Dec(%Date));
018400210110         caTxtA = '';
018500181012
018600210110         caCid9 = '';
018700210110         caTxt9 = 'Do not send';
018800180529
018900210110         Write CarAccr;
018901191212
018902210110         option = 'A';
018903210110         incarrier = 13;
018904210110         dltadd(catrst : casub# : caacct : incarrier : option);
019000170801
019100210110         //--------------------------------------
019200210110         //?Guardian Transmission File..
019300210110         //--------------------------------------
019400210110         Clear Guartranr;
019500170802
019600210110         gtUniq = caUniq;
019700170801
019800210110         gtTrst = caTrst;
019900210110         gtSub# = caSub#;
020000210110         gtAcct = caAcct;
020100170801
020200210110         GrpName  = %SubSt(acNam1:1:30);
020300170801
020400210110         gtCrtBy = WQUSRN;
020500210110         gtCrtDt = %Dec(%Date);
020600210110         gtCrtTm = %Dec(%Time);
020700170801
020800210110         Tst_FileDt = 0;
020900210110         Tst_FileTm = 0;
021000170801
021100210110         gtChgBy = *Blanks;
021200210110         gtChgDt = 0;
021300210110         gtChgTm = 0;
021400210110         write GuarTranr;
021500170801
021600170801
021601210110         //----------------------------------------------------
021602210110         //
021603210110         //  Guardian Transmission Log File.
021604210110         //
021605210110         //----------------------------------------------------
021606210110         glUniq = caUniq;
021607210110
021608210110         glTrst = caTrst;
021609210110         glSub# = caSub#;
021610210110         glAcct = caAcct;
021611210110
021613210110         glStatus = caStatus;
021614210110
021615210110         glNotes = 'Automatically added of New Group Setup';
021616210110         glDate = %Dec(%Date);
021617210110         glTime = %Dec(%Time);
021618210110         glPgm = 'GBS0021R';
021619210110         glUser = wqusrn;
021620210110
021628210110         write Guartlogr;
021629210110
021630210110
021631210110
021632210110
021700210110         //?Send the initial email to Guardian
021800210110         EmailGuardian( acNam1 : caCid2 );
021900170801
022000170801
022100170801
022200170801       Endsr;
022300170801
022400170802      *------------------------------------------------------------
022500170802       Begsr NewPlan_Setup;
022600210110         Clear Carplnr;
022700170802
022800210110         cpuniq = gtUniq;
022900210110         cpTrst = sqTrst;
023000210110         cpSub# = sqSub#;
023100210110         cpAcct = sqAcct;
023200210110         cpPlan = sqPlan;
023300170802
023400210110         cpTxt1 = 'Guardian Plan Type';
023500210110         cpTxt2 = 'Plan Type';
023600210110         cpTxt3 = 'Class Override';
023700210110         cpTxt4 = 'Election Override';
023800210110         cpTxt5 = 'Division Override';
023900170802
024000210110         cpCid1 = sqGuarCode;
024100170803
024200210110         //?Get the Class...
024300210110         cpCid3 = *blanks;
024400210110         chain ( sqTrst : sqSub# : sqPlan) Class;
024500210110         if %Found( Class );
024600210110           cpCid3 = clClass;
024700210110         endif;
024800170803
024900210110         cpCidA = 'Created: ' + 'GBS0021R  ' + %Char(%Dec(%Date));
025000210110         cpTxtA = '';
025100181012
025200210110         cpCid9 = '';
025300210110         cpTxt9 = 'Do not send';
025400180529
025500210110         Write CarPlnr;
025600170802
025700170802
025800210110         //--------------------------------------------
025900210110         //?Write the Plan information to the workfile.
026000210110         //--------------------------------------------
026100210110         chain (sqTrst: sqSub#: sqAcct) AccMst;
026200170802
026300210110         ngTrst = sqTrst;
026400210110         ngSub# = sqSub#;
026500210110         ngAcct = sqAcct;
026600210110         ngNam1 = acNam1;
026700210110         ngPlan = sqPlan;
026800210110         ngDescr = sqDescr;
026900210110         ngCat = sqCat;
027000210110         ngCode = sqGuarCode;
027100170802
027200210110         // Check to see if this record is for a new account
027300210110         // or just a new plan
027400210110         CurrTSA = %Editc(sqTrst:'X') + %Editc(sqSub#:'X') +
027500210110                   %Editc(sqAcct:'X');
027600170802
027700210110         if CurrTSA = SavTSA;
027800210110           ngType = 'New Acct';
027900210110         else;
028000210110           ngType = 'New Plan';
028100210110         endif;
028200170802
028300170802
028400210110         Write r_NewGuard;
028500170802
028600170802       Endsr;
028700170802
028800170801      *----------------------------------------------------------------
028900170801      * zFill Function
029000170801      *----------------------------------------------------------------
029100170801     P zFill           B                   export
029200170801     D Zfill           PI           100
029300170801     D   Len                          3S 0 value
029400170801     D   Text                       100    value
029500170801     D
029600170801     D ReturnText      s            100
029700170801     D Diff            s              3s 0
029800170801     D i               s              3s 0
029900170801     C
030000170801     C                   eval      Diff = Len - %Len(%Trim(Text))
030100170801     C                   for       i = 1 to Diff
030200170801     C                   eval      ReturnText = %Trim(ReturnText) + '0'
030300170801     C                   endfor
030400170801     C
030500170801     C                   eval      ReturnText = %Trim(ReturnText) +
030600170801     C                              %Trim(Text)
030700170801     C
030800170801     C                   Return    ReturnText
030900170801     P zFill           E
031000170801
