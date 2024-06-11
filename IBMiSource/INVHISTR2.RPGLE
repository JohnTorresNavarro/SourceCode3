000100230707      *=========================================================================
000200230707     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300230707      *=========================================================================
000400230707      * INVHISTR = Retrive Invoice Totals by T/S/A, Date
000500230707      *=========================================================================
000600230707      * Date         Int  Description
000700230707      * ----------   ---  ------------------------------------------------------
000800230707      * 07/07/2023   jt   Original Creation
000900230707      *=========================================================================
001000230707
001100230707     fhistaa    if   e           k disk    rename(histr:histfile)
001200230707     f                                     extfile('F.HISTAA')
001300230707
001400230707     finvsum    if   e           k disk    rename(invsmr:invFile)
001500230707     f                                     extfile('F.INVSUM')
001600230814
001700230814     d r0dates         s              8s 0 dim( 100 )
001800230814
001900230814     d pos             s              5  0
002000230814     d poc             s              5  0
002100230707
002200230707     d trust           s              3  0
002300230707     d sub             s              3  0
002400230707     d acct            s              4  0
002500230707     d date            s              8  0
002600230707     d dateISO         s               d
002700230707     d tsa             s             10
002800230706
002900230707     d invhistr2       pi
003000230707     d  inTrust                       3
003100230707     d  inSub                         3
003200230707     d  inAcc                         4
003300230707     d  inDate                        8
003400230814     d  outAMt                       12  2
003500230815     d  rvdates                      11    dim(13)
003600230707
003700230707      //========================================================================
003800230707      // mainline
003900230707      //========================================================================
004000230707
004100230707       exsr init;
004200230707       exsr main;
004300230707       exsr exit;
004400230707
004500230707      //========================================================================
004600230707      // main
004700230707      //========================================================================
004800230707
004900230707       begsr main;
005000230707
005100230707        chain (trust : sub : acct : date : 'KEB') invFile;
005200230707        if %found;
005300230707
005400230707         setll (tsa : 'BMP') histFile;
005500230707         reade (tsa : 'BMP') histFile;
005600230707         dow not %eof;
005700230707
005800230707          if hinvdt = date;
005900230707           outAmt = outAmt + tramt;
006000230814
006100230814            if RECVDT > 0;
006200230814            pos = %lookup( RECVDT : r0dates ) ;
006300230814            if pos = 0;
006400230814            pos = %lookup( 0 : r0dates ) ;
006500230814            if pos > 0;
006600230814            r0dates(pos) = RECVDT;
006700230814     C                   Movel     RECVDT        Input_Date
006800230814     C                   Eval      Input_Format  = 'YYYYMMDD'
006900230814     C                   Eval      Output_Format = 'MM/DD/YYYY'
007000230814     C                   Exsr      FormatDateSR
007100230814            if pos = 1;
007200230814     C                   Eval      rvdates(pos) = %trim(Output_Date)
007300230814            else;
007400230815            if pos > 13;
007500230815            leave;
007600230815            endif;
007700230815            if pos = 13;
007800230815     C                   Eval      poc = pos-1
007900230815     C                   Eval      rvdates(poc) = %trim(rvdates(poc)) + ','
008000230815     C                   Eval      rvdates(pos) = '**/**/****'
008100230814            leave;
008200230814            endif;
008300230814            if pos <= 0;
008400230814            leave;
008500230814            endif;
008600230814     C                   Eval      poc = pos-1
008700230814     C                   Eval      rvdates(poc) = %trim(rvdates(poc)) + ','
008800230814     C                   Eval      rvdates(pos) = %trim(Output_Date)
008900230814            endif;
009000230814            endif;
009100230814            endif;
009200230814            endif;
009300230814
009400230707          endif;
009500230707
009600230707         reade (tsa : 'BMP') histFile;
009700230707         enddo;
009800230707
009900230707        else;
010000230707
010100230707         setll (tsa : 'BMP') histFile;
010200230707         reade (tsa : 'BMP') histFile;
010300230707         dow not %eof;
010400230707
010500230707          if hinvdt = 0;
010600230707           outAmt = outAmt + tramt;
010700230814
010800230814            if RECVDT > 0;
010900230814            pos = %lookup( RECVDT : r0dates ) ;
011000230814            if pos = 0;
011100230814            pos = %lookup( 0 : r0dates ) ;
011200230814            if pos > 0;
011300230814            r0dates(pos) = RECVDT;
011400230814     C                   Movel     RECVDT        Input_Date
011500230814     C                   Eval      Input_Format  = 'YYYYMMDD'
011600230814     C                   Eval      Output_Format = 'MM/DD/YYYY'
011700230814     C                   Exsr      FormatDateSR
011800230814            if pos = 1;
011900230814     C                   Eval      rvdates(pos) = %trim(Output_Date)
012000230814            else;
012100230815            if pos <= 0;
012200230815            leave;
012300230815            endif;
012400230815            if pos > 13;
012500230814            leave;
012600230814            endif;
012700230815            if pos = 13;
012800230815     C                   Eval      poc = pos-1
012900230815     C                   Eval      rvdates(poc) = %trim(rvdates(poc)) + ','
013000230815     C                   Eval      rvdates(pos) = '**/**/****'
013100230815            leave;
013200230815            endif;
013300230814     C                   Eval      poc = pos-1
013400230814     C                   Eval      rvdates(poc) = %trim(rvdates(poc)) + ','
013500230814     C                   Eval      rvdates(pos) = %trim(Output_Date)
013600230814            endif;
013700230814            endif;
013800230814            endif;
013900230814            endif;
014000230814
014100230707          endif;
014200230707
014300230707         reade (tsa : 'BMP') histFile;
014400230707         enddo;
014500230707
014600230707        endif;
014700230707
014800230707       endsr;
014900230707
015000230706
015100230707      //========================================================================
015200230707      // exit
015300230707      //========================================================================
015400230707
015500230707       begsr exit;
015600230707
015700230707        *inlr = '1';
015800230707        return;
015900230707
016000230707       endsr;
016100230707
016200230707      //========================================================================
016300230707      // init
016400230707      //========================================================================
016500230707
016600230707       begsr init;
016700230707
016800230707        trust = %dec(inTrust:3:0);
016900230707        sub = %dec(inSub:3:0);
017000230707        acct = %dec(inAcc:4:0);
017100230707
017200230707        date = %dec(inDate:8:0);
017300230707        dateISO = %date(date) + %months(1);
017400230707        date = %dec(dateISO);
017500230707
017600230707        tsa = inTrust + inSub + inAcc;
017700230814
017800230814        clear  r0dates;
017900230814        clear  rvdates;
018000230707
018100230707        outAmt = 0;
018200230707
018300230707       endsr;
018400230814      *___________________________________________________________________
018500230814      * Format Date
018600230814      *___________________________________________________________________
018700230814     C     FormatDateSR  BEGSR
018800230814     C                   Call      'FMTDATE'
018900230814     C                   Parm                    Input_Date       32
019000230814     C                   Parm                    Input_Format     32
019100230814     C                   Parm                    Output_Format    32
019200230814     C                   Parm                    Output_Date      32
019300230814     C                   Parm                    Output_Error     10
019400230814     C                   Eval      Input_Date   = *blanks
019500230814     C                   Eval      Input_Format = *blanks
019600230814     C                   Eval      OutPut_Format = *blanks
019700230814     C                   ENDSR
019800230707
019900230707      //========================================================================
