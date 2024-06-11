000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Has FSA XLS Report
000400000000      *
000500000000      *  (c)Copyright 2023 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - August 07, 2023
000800000000      *_________________________________________________________________________
000900230808       dcl-f gbs30hmbr   usage( *Input ) keyed;
001000230808       dcl-f gbs30hmcov  usage( *Input ) keyed;
001100230807       dcl-f easeplanl1 usage( *Input ) keyed;
001200230807       dcl-f hasfsap usage( *Output ) keyed;
001300230808
001400230808       dcl-f MCOVC15 keyed
001500230808          ExtDesc('F.MCOVC15') ExtFile(*extdesc)  ;
001600230808
001700230808       dcl-f PLNMST keyed
001800230808          ExtDesc('F.PLNMST') ExtFile(*extdesc)  ;
001900230808
002000230808       dcl-f ACCMST keyed
002100230808          ExtDesc('F.ACCMST') ExtFile(*extdesc)  ;
002200230808
002300230808       dcl-f DEPEND keyed
002400230808          ExtDesc('F.DEPEND') ExtFile(*extdesc)  ;
002500230808
002600230808       dcl-s wDPS   Zoned(3);
002700230808       dcl-s wSPS   Zoned(3);
002800230808       dcl-s wDep   Zoned(3);
002900230807       dcl-s wTRS   Zoned(3);
003000230807       dcl-s wSUB   Zoned(3);
003100230807       dcl-s wACC   Zoned(4);
003200230808       dcl-s  wFT   char(10);
003300230807
003400230807     d in_date         s             32
003500230807     d in_format       s             32
003600230807     d out_format      s             32
003700230807     d out_date        s             32
003800230807     d out_error       s             10
003900230807
004000230807     d fmtDate         pr                  extpgm('FMTDATE')
004100230807     d  in_date                      32    const
004200230807     d  in_format                    32    const
004300230807     d  out_format                   32    const
004400230807     d  out_date                     32    const
004500230807     d  out_error                    10    const
004600230807
004700000000      * Program status data structure
004800230807       dcl-ds pgmd
004900230807         ExtName('IOPGMD') PSDS;
005000230807         @pgmq *proc;
005100230807       end-ds;
005200230807
005300230807      *-------------------------------------------------------------------------
005400230807      * *Entry Procedure
005500230807      *-------------------------------------------------------------------------
005600230807       Dcl-pr Main ExtPgm;
005700230807         *N  Char(10);
005800230807       End-Pr;
005900230807
006000230807       dcl-pi Main;
006100230807         pTSA      Char(10);
006200230807       End-Pi;
006300230807
006400230807        in_format = 'YYYYMMDD';
006500230807        out_format = 'MM-DD-YYYY';
006600230807
006700230807          wTRS = %dec(%subst(pTSA:1:3):3:0);
006800230807          wSUB = %dec(%subst(pTSA:4:3):3:0);
006900230807          wACC = %dec(%subst(pTSA:7:4):4:0);
007000230808          clear  wFT;
007100230807
007200230808         Setll pTSA GBS30HMBR;
007300230808         dou %Eof(GBS30HMBR);
007400230808           reade(n) pTSA GBS30HMBR;
007500230807
007600230808           if %Eof(GBS30HMBR);
007700230807             leave;
007800230807           endif;
007900230807
008000230807            clear  HASFSA_R;
008100230807
008200230808            SUBSCRIBER =  H1_SSN;
008300230810            SSN   =  H1_SSN;
008400230810            NAME  =  %trim(H1_LNAME) + ', ' + %trim(H1_FNAME) + ' ' +
008500230808                       %trim(H1_MI);
008600230808            ADDRESS = %trim(H1_ADDR1) + ' ' + %trim(H1_ADDR2);
008700230808            CITY  = %trim(H1_CITY);
008800230808            STATE = %trim(H1_STATE);
008900230808            ZIP_CODE  = %trim(H1_ZIP);
009000230808            RELATION  = 'EMPLOYEE';
009100230807
009200230807           exsr check_fsa;
009300230807
009400230807           enddo;
009500230807
009600230807           *inlr = *on;
009700230807           return;
009800230807
009900230807      *-------------------------------------------------------------------------
010000230807       Begsr check_fsa;
010100230807
010200230808         Setll ( pTSA : wFT : H1_SSN ) GBS30HMCOV;
010300230808         dou %Eof(GBS30HMCOV);
010400230808           reade(n) ( pTSA : wFT : H1_SSN ) GBS30HMCOV;
010500230807
010600230808           if %Eof(GBS30HMCOV);
010700230807             leave;
010800230807           endif;
010900230807
011000230808           if  H2_FSA_ANN <> '000000.00' and H2_FSA_ANN <> ' ' or
011100230808               H2_FSA_PP  <> '000000.00' and H2_FSA_PP <> ' ';
011200230807
011300230808            PLAN_NAME = %trim(H2_PLAN);
011400230808            if %Subst(H2_PLAN : 1 : 9) = 'EASE_PLAN';
011500230808             chain ( wTrs : wSub : wAcc : H2_Plan ) EasePlanl1;
011600230807             if %Found( EasePlanl1 );
011700230808               PLAN_NAME = %trim( P_PlanName );
011800230807             EndIf;
011900230807           Endif;
012000230807
012100230808           clear  EFF_DATE;
012200230808           in_date = %trim(H2_EFFDT);
012300230807           fmtDate(in_date:in_format:out_format:out_date:out_error)         ;
012400230807           if out_error = *blanks;
012500230808           EFF_DATE = %trim(out_date);
012600230807           endif;
012700230807
012800230808           clear  TRM_DATE;
012900230808           in_date = %trim(H2_TERMDT);
013000230807           fmtDate(in_date:in_format:out_format:out_date:out_error)         ;
013100230807           if out_error = *blanks;
013200230808           TRM_DATE = %trim(out_date);
013300230807           endif;
013400230807
013500230810            COV_TIER = %trim(H2_ENRL);
013600230807
013700230808            ANNUAL_FSA = %trim(H2_FSA_ANN);
013800230808            if %trim(ANNUAL_FSA) = '000000.00';
013900230808            ANNUAL_FSA = *blanks;
014000230807            endif;
014100230807
014200230808            PERPAY_FSA = %trim(H2_FSA_PP);
014300230808            if %trim(PERPAY_FSA) = '000000.00';
014400230808            PERPAY_FSA = *blanks;
014500230807            endif;
014600230808
014700230808            ACC_NBR = pTSA;
014800230808            chain ( wTrs : wSub : wAcc ) ACCMST;
014900230808            if %Found( ACCMST );
015000230808            ACC_NAME = %trim(ACNAM1);
015100230808            endif;
015200230807
015300230810           exsr get_EE_enrollment;
015400230808
015500230807           write  HASFSA_R;
015600230807
015700230808           exsr check_dep;
015800230809
015900230810            SSN   =  H1_SSN;
016000230810            NAME  =  %trim(H1_LNAME) + ', ' + %trim(H1_FNAME) + ' ' +
016100230809                       %trim(H1_MI);
016200230809            ADDRESS = %trim(H1_ADDR1) + ' ' + %trim(H1_ADDR2);
016300230809            CITY  = %trim(H1_CITY);
016400230809            STATE = %trim(H1_STATE);
016500230809            ZIP_CODE  = %trim(H1_ZIP);
016600230809            RELATION  = 'EMPLOYEE';
016700230807
016800230807           endif;
016900230807
017000230807           enddo;
017100230807
017200230807       Endsr;
017300230808      *-------------------------------------------------------------------------
017400230808       Begsr check_dep;
017500230808
017600230809             if %scan('DEPENDENT CARE' : %upper(PLAN_NAME) ) > 0;
017700230809
017800230808         mcssno = %dec(H1_SSN:9:0);
017900230808
018000230808         Setll ( wTRS : wSUB: wACC: MCSSNO ) MCOVC15;
018100230808         dou %Eof(MCOVC15);
018200230808           reade(n) ( wTRS: wSUB: wACC : MCSSNO ) MCOVC15;
018300230808
018400230808           if %Eof(MCOVC15);
018500230808             leave;
018600230808           endif;
018700230808
018800230808           chain (MCTRST:MCSUB#:MCPLAN) PLNMST;
018900230808           if %found(PLNMST);
019000230808           if %trim(PLNCAT) = 'PFD';
019100230808
019200230808           exsr get_enrollment;
019300230808           exsr write_dep;
019400230808
019500230808           endif;
019600230808           endif;
019700230808
019800230808           enddo;
019900230808
020000230809           endif;
020100230808
020200230808       Endsr;
020300230808      *-------------------------------------------------------------------------
020400230808       Begsr write_dep;
020500230808
020600230808         Setll ( MCSSNO ) DEPEND;
020700230808         dou %Eof(DEPEND);
020800230808           reade(n) ( MCSSNO ) DEPEND;
020900230808
021000230808           if %Eof(DEPEND);
021100230808             leave;
021200230808           endif;
021300230808
021400230808           if %trim(DPDLTD) = 'A';
021500230808
021600230808           select;
021700230808           when  %trim(DRELCD) = 'RPA';
021800230808           RELATION = 'DOMESTIC PARTNER';
021900230808           when  %trim(DRELCD) = 'RHU';
022000230808           RELATION = 'SPOUSE';
022100230808           when  %trim(DRELCD) = 'RWI';
022200230808           RELATION = 'SPOUSE';
022300230808           other;
022400230808           RELATION = 'CHILD';
022500230808           endsl;
022600230808
022700230808           if DEPSS# > 0;
022800230810           SSN = %char(DEPSS#);
022900230808           endif;
023000230809
023100230810           NAME =  %trim(DLNAME) + ', ' + %trim(DFNAME) + ' ' +
023200230809                      %trim(DMI);
023300230809           ADDRESS = %trim(DADDR1) + ' ' + %trim(DADDR2);
023400230809           CITY    = %trim(DCITY) + ' *';
023500230809           STATE   = %trim(DSTATE);
023600230809           ZIP_CODE = %char(DZIP);
023700230808
023800230808           write  HASFSA_R;
023900230808
024000230808           endif;
024100230808
024200230808           enddo;
024300230808
024400230808       Endsr;
024500230808      *-------------------------------------------------------------------------
024600230808       Begsr get_enrollment;
024700230808
024800230808         mcssno = %dec(H1_SSN:9:0);
024900230808
025000230808         wDPS = 0;
025100230808         wSPS = 0;
025200230808         wDEP = 0;
025300230808
025400230808         Setll ( MCSSNO ) DEPEND;
025500230808         dou %Eof(DEPEND);
025600230808           reade(n) ( MCSSNO ) DEPEND;
025700230808
025800230808           if %Eof(DEPEND);
025900230808             leave;
026000230808           endif;
026100230808
026200230808           if %trim(DPDLTD) = 'A';
026300230808
026400230808           select;
026500230808           when  %trim(DRELCD) = 'RPA';
026600230808           wDPS = wDPS+1;
026700230808           when  %trim(DRELCD) = 'RHU';
026800230808           wSPS = wSPS+1;
026900230808           when  %trim(DRELCD) = 'RWI';
027000230808           wSPS = wSPS+1;
027100230808           other;
027200230808           wDEP = wDEP+1;
027300230808           endsl;
027400230808
027500230808           endif;
027600230808
027700230808           enddo;
027800230808
027900230810           Select;
028000230810           when     wDPS > 0 and WSPS = 0 and WDEP = 0;
028100230810           COV_TIER = 'HW';
028200230810           when     wSPS > 0 and WDPS = 0 and WDEP = 0;
028300230810           COV_TIER = 'HW';
028400230810           when     wSPS = 0 and WDPS = 0 and WDEP = 1;
028500230810           COV_TIER = 'PC';
028600230810           when     wSPS = 0 and WDPS = 0 and WDEP > 1;
028700230810           COV_TIER = 'P2';
028800230810           when     wSPS > 0 and WDPS = 0 and WDEP > 0;
028900230810           COV_TIER = 'FA';
029000230810           when     wSPS > 0 and WDPS > 0 and WDEP > 0;
029100230810           COV_TIER = 'FA';
029200230810           when     wSPS = 0 and WDPS = 0 and WDEP > 0;
029300230810           COV_TIER = 'FA';
029400230810           other;
029500230810           COV_TIER = 'IN';
029600230810           endsl;
029700230808
029800230808       Endsr;
029900230810      *-------------------------------------------------------------------------
030000230810       Begsr get_EE_enrollment;
030100230810
030200230810             if %scan('DEPENDENT CARE' : %upper(PLAN_NAME) ) > 0;
030300230810
030400230810         mcssno = %dec(H1_SSN:9:0);
030500230810
030600230810         wDPS = 0;
030700230810         wSPS = 0;
030800230810         wDEP = 0;
030900230810
031000230810         Setll ( MCSSNO ) DEPEND;
031100230810         dou %Eof(DEPEND);
031200230810           reade(n) ( MCSSNO ) DEPEND;
031300230810
031400230810           if %Eof(DEPEND);
031500230810             leave;
031600230810           endif;
031700230810
031800230810           if %trim(DPDLTD) = 'A';
031900230810
032000230810           select;
032100230810           when  %trim(DRELCD) = 'RPA';
032200230810           wDPS = wDPS+1;
032300230810           when  %trim(DRELCD) = 'RHU';
032400230810           wSPS = wSPS+1;
032500230810           when  %trim(DRELCD) = 'RWI';
032600230810           wSPS = wSPS+1;
032700230810           other;
032800230810           wDEP = wDEP+1;
032900230810           endsl;
033000230810
033100230810           endif;
033200230810
033300230810           enddo;
033400230810
033500230810           Select;
033600230810           when     wDPS > 0 and WSPS = 0 and WDEP = 0;
033700230810           COV_TIER = 'HW';
033800230810           when     wSPS > 0 and WDPS = 0 and WDEP = 0;
033900230810           COV_TIER = 'HW';
034000230810           when     wSPS = 0 and WDPS = 0 and WDEP = 1;
034100230810           COV_TIER = 'PC';
034200230810           when     wSPS = 0 and WDPS = 0 and WDEP > 1;
034300230810           COV_TIER = 'P2';
034400230810           when     wSPS > 0 and WDPS = 0 and WDEP > 0;
034500230810           COV_TIER = 'FA';
034600230810           when     wSPS > 0 and WDPS > 0 and WDEP > 0;
034700230810           COV_TIER = 'FA';
034800230810           when     wSPS = 0 and WDPS = 0 and WDEP > 0;
034900230810           COV_TIER = 'FA';
035000230810           other;
035100230810           COV_TIER = 'IN';
035200230810           endsl;
035300230810
035400230810         Endif;
035500230810
035600230810       Endsr;
