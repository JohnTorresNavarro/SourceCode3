000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Has FSA XLS Report
000400000000      *
000500000000      *  (c)Copyright 2023 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - August 07, 2023
000800000000      *_________________________________________________________________________
000900230807       dcl-f gbs30mbr   usage( *Input ) keyed;
001000230807       dcl-f gbs30mcov  usage( *Input ) keyed;
001100230807       dcl-f easeplanl1 usage( *Input ) keyed;
001200230807       dcl-f hasfsap usage( *Output ) keyed;
001300230807
001400230808       dcl-f MCOVC15 keyed
001500230808          ExtDesc('F.MCOVC15') ExtFile(*extdesc)  ;
001600230808
001700230808       dcl-f PLNMST keyed
001800230808          ExtDesc('F.PLNMST') ExtFile(*extdesc)  ;
001900230808
002000230808       dcl-f DEPEND keyed
002100230808          ExtDesc('F.DEPEND') ExtFile(*extdesc)  ;
002200230808
002300230808       dcl-f ACCMST keyed
002400230808          ExtDesc('F.ACCMST') ExtFile(*extdesc)  ;
002500230808
002600230808       dcl-s wDPS   Zoned(3);
002700230808       dcl-s wSPS   Zoned(3);
002800230808       dcl-s wDep   Zoned(3);
002900230807       dcl-s wTRS   Zoned(3);
003000230807       dcl-s wSUB   Zoned(3);
003100230807       dcl-s wACC   Zoned(4);
003200230807
003300230807     d in_date         s             32
003400230807     d in_format       s             32
003500230807     d out_format      s             32
003600230807     d out_date        s             32
003700230807     d out_error       s             10
003800230807
003900230807     d fmtDate         pr                  extpgm('FMTDATE')
004000230807     d  in_date                      32    const
004100230807     d  in_format                    32    const
004200230807     d  out_format                   32    const
004300230807     d  out_date                     32    const
004400230807     d  out_error                    10    const
004500230807
004600000000      * Program status data structure
004700230807       dcl-ds pgmd
004800230807         ExtName('IOPGMD') PSDS;
004900230807         @pgmq *proc;
005000230807       end-ds;
005100230807
005200230807      *-------------------------------------------------------------------------
005300230807      * *Entry Procedure
005400230807      *-------------------------------------------------------------------------
005500230807       Dcl-pr Main ExtPgm;
005600230807         *N  Char(10);
005700230807       End-Pr;
005800230807
005900230807       dcl-pi Main;
006000230807         pTSA      Char(10);
006100230807       End-Pi;
006200230807
006300230807        in_format = 'YYYYMMDD';
006400230807        out_format = 'MM-DD-YYYY';
006500230807
006600230807          wTRS = %dec(%subst(pTSA:1:3):3:0);
006700230807          wSUB = %dec(%subst(pTSA:4:3):3:0);
006800230807          wACC = %dec(%subst(pTSA:7:4):4:0);
006900230807
007000230807         Setll *loval GBS30MBR;
007100230807         dou %Eof(GBS30MBR);
007200230807           read(n) GBS30MBR;
007300230807
007400230807           if %Eof(GBS30MBR);
007500230807             leave;
007600230807           endif;
007700230807
007800230807            clear  HASFSA_R;
007900230807
008000230808            SUBSCRIBER =  L1_SSN;
008100230810            SSN  =  L1_SSN;
008200230810            NAME =  %trim(L1_LNAME) + ', ' + %trim(L1_FNAME) + ' ' +
008300230807                       %trim(L1_MI);
008400230808            ADDRESS = %trim(L1_ADDR1) + ' ' + %trim(L1_ADDR2);
008500230808            CITY    = %trim(L1_CITY);
008600230808            STATE   = %trim(L1_STATE);
008700230808            ZIP_CODE = %trim(L1_ZIP);
008800230808            RELATION = 'EMPLOYEE';
008900230807
009000230807           exsr check_fsa;
009100230807
009200230807           enddo;
009300230807
009400230807           *inlr = *on;
009500230807           return;
009600230807
009700230807      *-------------------------------------------------------------------------
009800230807       Begsr check_fsa;
009900230807
010000230807         Setll ( L1_SSN ) GBS30MCOV;
010100230807         dou %Eof(GBS30MCOV);
010200230807           reade(n) ( L1_SSN ) GBS30MCOV;
010300230807
010400230807           if %Eof(GBS30MCOV);
010500230807             leave;
010600230807           endif;
010700230807
010800230807           if  L2_FSA_ANN <> '000000.00' and L2_FSA_ANN <> ' ' or
010900230807               L2_FSA_PP  <> '000000.00' and L2_FSA_PP <> ' ';
011000230807
011100230808            PLAN_NAME = %trim(L2_PLAN);
011200230807            if %Subst(L2_PLAN : 1 : 9) = 'EASE_PLAN';
011300230807             chain ( wTrs : wSub : wAcc : L2_Plan ) EasePlanl1;
011400230807             if %Found( EasePlanl1 );
011500230808               PLAN_NAME = %trim( P_PlanName );
011600230807             EndIf;
011700230807           Endif;
011800230807
011900230808           clear  EFF_DATE;
012000230807           in_date = %trim(L2_EFFDT);
012100230807           fmtDate(in_date:in_format:out_format:out_date:out_error)         ;
012200230807           if out_error = *blanks;
012300230808           EFF_DATE = %trim(out_date);
012400230807           endif;
012500230807
012600230808           clear  TRM_DATE;
012700230807           in_date = %trim(L2_TERMDT);
012800230807           fmtDate(in_date:in_format:out_format:out_date:out_error)         ;
012900230807           if out_error = *blanks;
013000230808           TRM_DATE = %trim(out_date);
013100230807           endif;
013200230807
013300230810            COV_TIER = %trim(L2_ENRL);
013400230807
013500230808            ANNUAL_FSA = %trim(L2_FSA_ANN);
013600230808            if %trim(ANNUAL_FSA) = '000000.00';
013700230808            ANNUAL_FSA = *blanks;
013800230807            endif;
013900230807
014000230808            PERPAY_FSA = %trim(L2_FSA_PP);
014100230808            if %trim(PERPAY_FSA) = '000000.00';
014200230808            PERPAY_FSA = *blanks;
014300230807            endif;
014400230808
014500230808            ACC_NBR = pTSA;
014600230808            chain ( wTrs : wSub : wAcc ) ACCMST;
014700230808            if %Found( ACCMST );
014800230808            ACC_NAME = %trim(ACNAM1);
014900230808            endif;
015000230808
015100230810           exsr get_EE_enrollment;
015200230807
015300230807           write  HASFSA_R;
015400230807
015500230808           exsr check_dep;
015600230809
015700230810            SSN   =  L1_SSN;
015800230810            NAME  =  %trim(L1_LNAME) + ', ' + %trim(L1_FNAME) + ' ' +
015900230809                       %trim(L1_MI);
016000230809            ADDRESS = %trim(L1_ADDR1) + ' ' + %trim(L1_ADDR2);
016100230809            CITY  = %trim(L1_CITY);
016200230809            STATE = %trim(L1_STATE);
016300230809            ZIP_CODE  = %trim(L1_ZIP);
016400230809            RELATION  = 'EMPLOYEE';
016500230807
016600230807           endif;
016700230807
016800230807           enddo;
016900230807
017000230807       Endsr;
017100230807      *-------------------------------------------------------------------------
017200230807       Begsr check_dep;
017300230809
017400230809             if %scan('DEPENDENT CARE' : %upper(PLAN_NAME) ) > 0;
017500230808
017600230808         mcssno = %dec(L1_SSN:9:0);
017700230808
017800230808         Setll ( wTRS : wSUB: wACC: MCSSNO ) MCOVC15;
017900230808         dou %Eof(MCOVC15);
018000230808           reade(n) ( wTRS: wSUB: wACC : MCSSNO ) MCOVC15;
018100230808
018200230808           if %Eof(MCOVC15);
018300230808             leave;
018400230808           endif;
018500230808
018600230808           chain (MCTRST:MCSUB#:MCPLAN) PLNMST;
018700230808           if %found(PLNMST);
018800230808           if %trim(PLNCAT) = 'PFD';
018900230808
019000230808           exsr get_enrollment;
019100230808           exsr write_dep;
019200230808
019300230808           endif;
019400230808           endif;
019500230808
019600230808           enddo;
019700230809
019800230809           endif;
019900230808
020000230807       Endsr;
020100230808      *-------------------------------------------------------------------------
020200230808       Begsr write_dep;
020300230808
020400230808         Setll ( MCSSNO ) DEPEND;
020500230808         dou %Eof(DEPEND);
020600230808           reade(n) ( MCSSNO ) DEPEND;
020700230808
020800230808           if %Eof(DEPEND);
020900230808             leave;
021000230808           endif;
021100230808
021200230808           if %trim(DPDLTD) = 'A';
021300230808
021400230808           select;
021500230808           when  %trim(DRELCD) = 'RPA';
021600230808           RELATION = 'DOMESTIC PARTNER';
021700230808           when  %trim(DRELCD) = 'RHU';
021800230808           RELATION = 'SPOUSE';
021900230808           when  %trim(DRELCD) = 'RWI';
022000230808           RELATION = 'SPOUSE';
022100230808           other;
022200230808           RELATION = 'CHILD';
022300230808           endsl;
022400230808
022500230808           if DEPSS# > 0;
022600230810           SSN = %char(DEPSS#);
022700230808           endif;
022800230809
022900230810           NAME =  %trim(DLNAME) + ', ' + %trim(DFNAME) + ' ' +
023000230809                      %trim(DMI);
023100230809           ADDRESS = %trim(DADDR1) + ' ' + %trim(DADDR2);
023200230809           CITY    = %trim(DCITY);
023300230809           STATE   = %trim(DSTATE);
023400230809           ZIP_CODE = %char(DZIP);
023500230808
023600230808           write  HASFSA_R;
023700230808
023800230808           endif;
023900230808
024000230808           enddo;
024100230808
024200230808       Endsr;
024300230808      *-------------------------------------------------------------------------
024400230808       Begsr get_enrollment;
024500230808
024600230808         mcssno = %dec(L1_SSN:9:0);
024700230808
024800230808         wDPS = 0;
024900230808         wSPS = 0;
025000230808         wDEP = 0;
025100230808
025200230808         Setll ( MCSSNO ) DEPEND;
025300230808         dou %Eof(DEPEND);
025400230808           reade(n) ( MCSSNO ) DEPEND;
025500230808
025600230808           if %Eof(DEPEND);
025700230808             leave;
025800230808           endif;
025900230808
026000230808           if %trim(DPDLTD) = 'A';
026100230808
026200230808           select;
026300230808           when  %trim(DRELCD) = 'RPA';
026400230808           wDPS = wDPS+1;
026500230808           when  %trim(DRELCD) = 'RHU';
026600230808           wSPS = wSPS+1;
026700230808           when  %trim(DRELCD) = 'RWI';
026800230808           wSPS = wSPS+1;
026900230808           other;
027000230808           wDEP = wDEP+1;
027100230808           endsl;
027200230808
027300230808           endif;
027400230808
027500230808           enddo;
027600230808
027700230808           Select;
027800230808           when     wDPS > 0 and WSPS = 0 and WDEP = 0;
027900230810           COV_TIER = 'HW';
028000230808           when     wSPS > 0 and WDPS = 0 and WDEP = 0;
028100230810           COV_TIER = 'HW';
028200230810           when     wSPS = 0 and WDPS = 0 and WDEP = 1;
028300230810           COV_TIER = 'PC';
028400230810           when     wSPS = 0 and WDPS = 0 and WDEP > 1;
028500230810           COV_TIER = 'P2';
028600230808           when     wSPS > 0 and WDPS = 0 and WDEP > 0;
028700230810           COV_TIER = 'FA';
028800230808           when     wSPS > 0 and WDPS > 0 and WDEP > 0;
028900230810           COV_TIER = 'FA';
029000230808           when     wSPS = 0 and WDPS = 0 and WDEP > 0;
029100230810           COV_TIER = 'FA';
029200230808           other;
029300230810           COV_TIER = 'IN';
029400230808           endsl;
029500230808
029600230808       Endsr;
029700230810      *-------------------------------------------------------------------------
029800230810       Begsr get_EE_enrollment;
029900230810
030000230810             if %scan('DEPENDENT CARE' : %upper(PLAN_NAME) ) > 0;
030100230810
030200230810         mcssno = %dec(L1_SSN:9:0);
030300230810
030400230810         wDPS = 0;
030500230810         wSPS = 0;
030600230810         wDEP = 0;
030700230810
030800230810         Setll ( MCSSNO ) DEPEND;
030900230810         dou %Eof(DEPEND);
031000230810           reade(n) ( MCSSNO ) DEPEND;
031100230810
031200230810           if %Eof(DEPEND);
031300230810             leave;
031400230810           endif;
031500230810
031600230810           if %trim(DPDLTD) = 'A';
031700230810
031800230810           select;
031900230810           when  %trim(DRELCD) = 'RPA';
032000230810           wDPS = wDPS+1;
032100230810           when  %trim(DRELCD) = 'RHU';
032200230810           wSPS = wSPS+1;
032300230810           when  %trim(DRELCD) = 'RWI';
032400230810           wSPS = wSPS+1;
032500230810           other;
032600230810           wDEP = wDEP+1;
032700230810           endsl;
032800230810
032900230810           endif;
033000230810
033100230810           enddo;
033200230810
033300230810           Select;
033400230810           when     wDPS > 0 and WSPS = 0 and WDEP = 0;
033500230810           COV_TIER = 'HW';
033600230810           when     wSPS > 0 and WDPS = 0 and WDEP = 0;
033700230810           COV_TIER = 'HW';
033800230810           when     wSPS = 0 and WDPS = 0 and WDEP = 1;
033900230810           COV_TIER = 'PC';
034000230810           when     wSPS = 0 and WDPS = 0 and WDEP > 1;
034100230810           COV_TIER = 'P2';
034200230810           when     wSPS > 0 and WDPS = 0 and WDEP > 0;
034300230810           COV_TIER = 'FA';
034400230810           when     wSPS > 0 and WDPS > 0 and WDEP > 0;
034500230810           COV_TIER = 'FA';
034600230810           when     wSPS = 0 and WDPS = 0 and WDEP > 0;
034700230810           COV_TIER = 'FA';
034800230810           other;
034900230810           COV_TIER = 'IN';
035000230810           endsl;
035100230810
035200230810         Endif;
035300230810
035400230810       Endsr;
