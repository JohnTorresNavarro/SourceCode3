000100160523     H option(*noDebugIo)
000200160523      *-------------------------------------------------------------------------
000300160523      *
000400160523      *  Description: Track accounts having a Document Library Setup
000500160523      *  Programmer.: Brian Rees
000600160523      *  Date.......: 5/23/2016
000700160523      *
000800160523      *  Requested by Cindy Whitehead.
000900160523      *-------------------------------------------------------------------------
001000160523      * Modifications
001100160523      *
001200160523      * Date         Programmer    Mod      Description
001300160523      *-------------------------------------------------------------------------
001400160523      *
001500160523      *
001600160523      *-------------------------------------------------------------------------
001700160523     FGbs0009p  o    e           k disk
001800160523     Fcmct14    if   e           k disk     ExtDesc('F.CMCT14')
001900160523     F                                      ExtFile(*ExtDesc)
002000160523     Fplnmst    if   e           k disk     ExtDesc('F.PLNMST')
002100160523     F                                      ExtFile(*ExtDesc)
002200160523     Fcodesl1   if   e           k disk     ExtDesc('F.CODESL1')
002300160523     F                                      ExtFile(*ExtDesc)
002400160523     Fsman      if   e           k disk     ExtDesc('F.SMAN') ExtFile(*ExtDesc)
002500160523     FEmailAddr if   e           k disk
002600160523      *-------------------------------------------------------------------------
002700160523    ? * Program status data structure
002800160523    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002900160523     D  @pgmq            *proc
003000160523
003100160523     D @Data           ds
003200160523     D  sqTrust                       3  0
003300160523     D  sqSub#                        3  0
003400160523     D  sqAcct                        4  0
003500160523
003600160523     d Continue        s              1    inz
003700160523     d myMonth         s              2s 0 inz
003800160523     d ViewMonth       s              2s 0 inz
003900160523
004000160523    ? *-------------------------------------------------------------------------
004100160523      *?Mainline Program
004200160523    ? *-------------------------------------------------------------------------
004300160523     C     *entry        plist
004400160523     C                   parm                    eAddr            30
004500160523
004600160523      /Free
004700160523
004800160523         //?Run the SQL Commamnd and Loop through the results
004900160523         exsr $OpenC1;
005000160523         Dou SqlCod <> *Zero;
005100160523
005200160523            Exec Sql  Fetch Next From C1 Into :@data  ;
005300160523
005400160523            if SqlCod <> *Zero;
005500160523               leave;
005600160523            endif;
005700160523
005800160523
005900160523            Clear gbs0009r;
006000160523
006100160523
006200160523            //?Check Commission File for Plans.
006300160523            Setll (sqTrust: sqSub#: sqAcct) cmct14;
006400160523            dou %eof(cmct14);
006500160523               reade (sqTrust: sqSub#: sqAcct) cmct14;
006600160523
006700160523               if %eof(cmct14);
006800160523                  leave;
006900160523               endif;
007000160523
007100160523               if cmCan > 0 ;
007200160523                  iter;
007300160523               endif;
007400160523
007500160523               //?Get the Plan Category..
007600160523               chain (sqTrust: sqSub#: cmPlan) plnmst;
007700160523               if not %Found(plnmst);
007800160523                  iter;
007900160523               endif;
008000160523
008100160523               chain plncat codesl1;
008200160523               if action = 'M';
008300160523
008400160523                  //?Found Medical.. Get Renewal Month
008500160523                  g9Renew = prenew;
008600160523
008700160523                  //?Get Broker Name
008800160523                  chain slsman sman;
008900160523                  if %Found(sman);
009000160523                     g9lName = slname;
009100160523                     g9fName = sfname;
009200160523                     g9Addr  = sAddr;
009300160523                     g9City  = sCity;
009400160523                     g9State = sState;
009500160523                     g9Zip   = sZipCd;
009600160523
009700160523                     if sPhone > 0;
009800160523                        g9Phone = '(' + %Char(sArea) + ') ' +
009900160523                          %Editw(sPhone : '   -    ');
010000160523                     endif;
010100160523
010200160523                  endif;
010300160523
010400160523
010500160523                  exsr CheckMonth;
010600160523
010700160523                  if ViewMonth = g9renew;
010800160523
010900160523                     g9Trst = sqTrust;
011000160523                     g9Sub# = sqSub#;
011100160523                     g9Acct = sqAcct;
011200160523
011300160523                     write gbs0009r;
011400160523                     leave;
011500160523                  endif;
011600160523               endif;
011700160523
011800160523            enddo;      //cmct14
011900160523
012000160523
012100160523         enddo;
012200160523
012300160523         Exec Sql  Close C1;
012400160523
012500160523
012600160523         //?Get the Email Address of the user..
012700160523         chain wqusrn EmailAddr;
012800160523         if %Found(EmailAddr);
012900160523            eAddr = eaEmail;
013000160523         endif;
013100160523
013200160523
013300160523         *inlr = *on;
013400160523      // ----------------------------------------------------------------
013500160523
013600160523       begsr $OpenC1;
013700160523
013800160523          //----------------------------------------------------------------
013900160523          //?Collect all of the WebTran Records
014000160523          // Where the amPayr is not Blank and Not 'NPAY' and the
014100160523          // Dates was Yesterday.
014200160523          //----------------------------------------------------------------
014300160523          Exec Sql
014400160523             Declare C1 Cursor For
014500160523
014600160523             Select Distinct
014700160523                dlTrst, dlSub#, dlAcct
014800160523             From docliblst
014900160523             Join "F.ACCMST" on acTrst = dlTrst and
015000160523                                acSub# = dlSub# and
015100160523                                acAcct = dlacct
015200160523
015300160523             Where aTrmDt = 0
015400160523             Order by dlTrst, dlSub#, dlAcct;
015500160523
015600160523          Exec Sql    Open C1;
015700160523
015800160523
015900160523       endsr;
016000160523      // ----------------------------------------------------------------
016100160523
016200160523       begsr CheckMonth;
016300160523
016400160523          //?Only view 3rd Month in the future...
016500160523          // Jan .. View April.
016600160523
016700160523          myMonth = %Subdt(%Date: *Months);
016800160523
016900160523          if myMonth <= 9;
017000160523             ViewMonth = myMonth + 3;
017100160523          else;
017200160523
017300160523             Select;
017400160523             When myMonth = 10;
017500160523                ViewMonth = 1;
017600160523             When myMonth = 11;
017700160523                ViewMonth = 2;
017800160523             When myMonth = 12;
017900160523                ViewMonth = 3;
018000160523             endsl;
018100160523          endif;
018200160523
018300160523
018400160523       endsr;
