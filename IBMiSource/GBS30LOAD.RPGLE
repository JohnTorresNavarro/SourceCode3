000100210323       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no);
000200210323
000300210323      *-------------------------------------------------------------------------
000400210323      *
000500210323      *  Description: Take the inbound GBS30 data and populate the work fields.
000600210323      *  Programmer.: Brian Rees
000700210323      *  Date.......: 03/23/2021
000800210323      *
000900210323      *-------------------------------------------------------------------------
001000210323
001100210323      *-------------------------------------------------------------------------
001200210323      *
001300210323      * Declare Files
001400210323      *
001500210323      *-------------------------------------------------------------------------
001600210323       dcl-f gbs30p keyed;
001700210323       dcl-f gbs30Mbr keyed usage(*output);
001800210323       dcl-f gbs30MCov keyed usage(*output);
001900210323
002000210323       dcl-f gbs30Dep keyed usage(*output);
002100210323       dcl-f gbs30DCov keyed usage(*output);
002200210323
002300210323
002400210323      *-------------------------------------------------------------------------
002500210323      *
002600210323      * Mainline Program
002700210323      *
002800210323      *-------------------------------------------------------------------------
002900210323
003000210323
003100210323       Setll *Start gbs30p;
003200210323
003300210323       Dou %Eof(gbs30p);
003400210323         read gbs30p;
003500210323         if %eof(gbs30p);
003600210323           leave;
003700210323         endif;
003800210323
003900210323
004000210323         select;
004100210323         when g3RcdTyp = '1';
004200210323           load_Member();
004300210323
004400210323         when g3RcdTyp = '2';
004500210323           load_MCov();
004600210323
004700210323         when g3RcdTyp = '3';
004800210323           load_Dep();
004900210323
005000210323         when g3RcdTyp = '4';
005100210323           load_DCov();
005200210323
005300210323         EndSl;
005400210323
005500210323
005600210323
005700210323       Enddo;
005800210323
005900210323
006000210323       *inlr = *on;
006100210323
006200210323       // ----------------------------------------------------------------
006300210323       dcl-proc Load_Member;
006400210323
006500210513         //--------------------------------------------------------
006600210513         // The Data in the field is based on the spread sheet
006700210513         // in i:\mis\carrier_Inbound
006800210513         //--------------------------------------------------------
006900210323
007000210323         l1RcdTyp = g3RcdTyp;
007100210513         l1TSA    = g3tsa;
007200210323         L1_SSN   = g3ssn;
007300210323
007400210323         L1_FNAME = g3Field1;
007500210323         L1_MI    = g3Field2;
007600210323         L1_LNAME = g3Field3;
007700210323         L1_ADDR1 = g3Field4;
007800210323         L1_ADDR2 = g3Field5;
007900210323         L1_CITY  = g3Field6;
008000210323         L1_STATE = g3Field7;
008100210323         L1_ZIP   = g3Field8;
008200210407         L1_Country = g3Field9;
008300210407         L1_PHONE  = g3Field10;
008400210407         L1_GENDER = g3Field11;
008500210407         L1_DOB  = g3Field12;
008600210323
008700210407         L1_DOH = g3Field13;
008800210323         L1_MARSTS = g3Field14;
008900210323         L1_SAL   = g3Field15;
009000210323         L1_TERMDT = g3Field16;
009100210323         L1_DOC    = g3Field17;
009200210323         L1_COBRA  = g3Field18;
009300210323         L1_CLASS  = g3Field19;
009400210323         L1_TERMRSN = g3Field20;
009500210323         L1_QUALEVT = g3Field21;
009600210323         L1_EMAIL  = g3Field22;
009700210323         L1_SMOKER = g3Field23;
009800210323         L1_FULLLOC = g3Field24;
009900210323         L1_MEDENRL = g3Field25;
010000210323         L1_MEDICAR = g3Field26;
010100210323         L1_QEDATE = g3Field27;
010200210323         L1_MED_ADT = g3Field28;
010300210323         L1_MED_BDT = g3Field29;
010400210323         L1_MED_CDT = g3Field30;
010500210407         L1_MED_DDT = g3Field31;
010600210407         L1_CostCtr = g3Field32;
010700210802         L1_JobTitl = g3Field33;
010800210802         L1_Race    = g3Field34;
010900211220         L1_QEDescr = g3Field35;
011000220307         L1_PayFrq  = g3Field36;
011100220307         L1_PayPer  = g3Field37;
011200210323
011300211220
011400210323         write r_gbs30Mbr;
011500210323
011600210323       end-proc;
011700180524
011800210323       // ----------------------------------------------------------------
011900210323       dcl-proc Load_MCov;
012000210323
012100210323
012200210323         l2RcdTyp = g3RcdTyp;
012300210513         l2TSA    = g3tsa;
012400210323         L2_SSN   = g3ssn;
012500210323
012600210323         L2_PLAN  = g3Field1;
012700210323         L2_EFFDT = g3Field2;
012800210323         L2_TERMDT = g3Field3;
012900210323         L2_ENRL  = g3Field4;
013000210323         L2_FSA_ANN = g3Field5;
013100210323         L2_FSA_PP  = g3Field6;
013200210323         L2_VOLAMT  = g3Field7;
013300210323         L2_COVGTP  = g3Field8;
013400210323         L2_PCP#    = g3Field9;
013500210323         L2_PCPNAME = g3Field10;
013600210323         L2_PCPEFDT = g3Field11;
013700210323         L2_PCPTMDT = g3Field12;
013800220107
013900220107
014000210323         write rgbs30MCov;
014100210323
014200210323       end-proc;
014300210323
014400210323       // ----------------------------------------------------------------
014500210323       dcl-proc Load_Dep;
014600210323
014700210323
014800210323         l3RcdTyp = g3RcdTyp;
014900210513         l3TSA    = g3tsa;
015000210323         L3_PartSSN  = g3ssn;
015100210323
015200210323         L3_DEPSEQ# = g3Field1;
015300210323         L3_FNAME = g3Field2;
015400210323         L3_MI =  g3Field3;
015500210323         L3_LNAME = g3Field4;
015600210323         L3_ADDR1 = g3Field5;
015700210323         L3_ADDR2 = g3Field6;
015800210323         L3_CITY = g3Field7;
015900210323         L3_STATE = g3Field8;
016000210323         L3_ZIP  =  g3Field9;
016100210407         L3_Country =  g3Field10;
016200210407         L3_DEPSSN = g3Field11;
016300210407         L3_GENDER = g3Field12;
016400210407         L3_DOB = g3Field13;
016500210407         L3_RELCOD = g3Field14;
016600210407         L3_EFFDT = g3Field15;
016700210323         L3_COBRA = g3Field16;
016800210323         L3_QUALEVT = g3Field17;
016900210323         L3_DISABLD = g3Field18;
017000210407         L3_QEDATE = g3Field19;
017100210714         L3_STUDNT = g3Field20;
017200210714         L3_MEDENRL = g3Field21;
017300210714         L3_MEDICAR = g3Field22;
017400210714         L3_MED_ADT = g3Field23;
017500210714         L3_MED_BDT = g3Field24;
017600210714         L3_MED_CDT = g3Field25;
017700210714         L3_MED_DDT = g3Field26;
017800220107         L3_QEDESCR = g3Field27;
017900210714
018000210323         write r_Gbs30Dep;
018100210323
018200210323       end-proc;
018300210323
018400210323       // ----------------------------------------------------------------
018500210323       dcl-proc Load_DCov;
018600210323
018700210323
018800210323         l4RcdTyp = g3RcdTyp;
018900210513         l4TSA    = g3tsa;
019000210323         L4_PartSSN  = g3ssn;
019100210323
019200210323         L4_DEPSEQ# = g3Field1;
019300210323         L4_PLAN  = g3Field2;
019400210323         L4_EFFDT  = g3Field3;
019500210323         L4_TERMDT  = g3Field4;
019600210323         L4_COVGTYP  = g3Field5;
019700210323         L4_PCP#    = g3Field6;
019800210323         L4_PCPNAME = g3Field7;
019900210323         L4_PCPEFDT = g3Field8;
020000210323         L4_PCPTMDT  = g3Field9;
020100210323         L4_VOLAMT   = g3Field10;
020200210323         L4_TERMRSN  = g3Field11;
020300210323
020400210323         write rGbs30Dcov;
020500210323
020600210323       end-proc;
020700210323
