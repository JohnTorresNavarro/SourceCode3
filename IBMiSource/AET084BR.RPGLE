000100160203      *=========================================================================
000200160203     H option(*noDebugIo)
000300160203      *=========================================================================
000400160203
000500160203     Faet080wf  if   e             disk    rename(aet080wf:mainFile)
000600160203     F                                     prefix(d_)
000700160203
000800160203     Faet080wd  uf a e             disk    rename(aet080wdr:outFile)
000900160203     F                                     prefix(o_)
001000160203
001100160203      *=========================================================================
001200160203
001300160203     d pos             S              2  0
001400160203     d pos2            S              2  0
001500160208     d seq             S              7  0
001600160203
001700160203     D ds@member     e ds                  ExtName(AETMEM)
001800160203
001900160203     D ds@benefit    e ds                  ExtName(AETBEN)
002000160203
002100160203     D ds@member2    e ds                  ExtName(AETMEM2)
002200160203
002300160203      *=========================================================================
002400160203
002500160203       setll 1 mainFile;
002600160203       read mainFile;
002700160203
002800160203       dow not %eof;
002900160203
003000160203       pos = %scan('MEMBER' : d_aet080wf);
003100160203       if pos > 0;
003200160203        ds@member = d_aet080wf;
003300160203         exsr writeMember;
003400160203       endif;
003500160203
003600160203       pos2 = %scan('BENEFIT' : d_aet080wf);
003700160203       if pos2 > 0;
003800160203        ds@benefit = d_aet080wf;
003900160203         exsr writeBenefit;
004000160203       endif;
004100160203
004200160203       read mainFile;
004300160203       enddo;
004400160203
004500160203       exsr cleanFile;
004600160203       exsr cleanFile2;
004700160204       exsr createKey;
004800160203
004900160203       *inlr = *on;
005000160203       return;
005100160203
005200160203       //=========================================
005300160203       // Write member
005400160203       //=========================================
005500160203
005600160203       begsr writeMember;
005700160203
005800160203        clear outfile;
005900160203
006000160203        o_@ss1f = %trim(@ss1f);
006100160203        o_@ss2f = %trim(@ss2f);
006200160203        o_@fnf = %trim(@fnf);
006300160203        o_@mif = %trim(@mif);
006400160203        o_@lnf = %trim(@lnf);
006500160203        o_@relf = %trim(@relf);
006600160203        o_@sexf = %trim(@sexf);
006700160203        o_@dobf = %trim(@dobf);
006800160203        o_@specf = %trim(@specf);
006900160203        //o_@zero = %trim('0');
007000160203        o_@cobf = %trim(@cobf);
007100160203        o_@cobcf = %trim(@cobcf);
007200160203        o_@cobnf = %trim(@cobnf);
007300160203        o_@ad1f = %trim(@ad1f);
007400160203        o_@ad2f = %trim(@ad2f);
007500160203        o_@ctyf = %trim(@ctyf);
007600160203        o_@stf = %trim(@stf);
007700160203        o_@zp5f = %trim(@zp5f);
007800160203        o_@phnf = %trim(@phnf);
007900160203        o_@zipf = %trim(@zipf);
008000160203        o_@empstf = %trim(@empstf);
008100160208        o_@hiref = %trim(@hiref);
008200160204
008300160204        o_e@tdate =  %char(%dec(%date: *iso));
008400160203
008500160203        write outfile;
008600160203
008700160203       endsr;
008800160203
008900160203       //=========================================
009000160203       // Write benefit
009100160203       //=========================================
009200160203
009300160203       begsr writeBenefit;
009400160203
009500160203        clear outfile;
009600160203
009700160203        o_x@elrf = %trim(x@elrf);
009800160203        o_h@c#f = %trim(h@c#f);
009900160203        o_e@sfxf = %trim(e@sfxf);
010000160203        o_e@acctf = %trim(e@acctf);
010100160203        o_e@planf = %trim(e@planf);
010200160203        o_x@efff = %trim(x@efff);
010300160203        o_x@trmf = %trim(x@trmf);
010400160203        o_e@clmf = %trim(e@clmf);
010500160203        o_e@pcpf = %trim(e@pcpf);
010600160203        //o_e@pcpf2 = %trim(e@pcpf2);
010700160203        //o_e@pcpf3 = %trim(e@pcpf3);
010800160203        //o_@zero = %trim('0');
010900160203        o_e@cbrexpf = %trim(e@cbrexpf);
011000160203        o_e@cbrevtf = %trim(e@cbrevtf);
011100160203        o_e@cbrlenf = %trim(e@cbrlenf);
011200160203
011300160204        o_e@tdate =  %char(%dec(%date: *iso));
011400160204
011500160301        o_e@prdct = blank22;
011600160301
011700160203        write outfile;
011800160203
011900160203       endsr;
012000160203
012100160203       //=========================================
012200160203       // Clean file
012300160203       //=========================================
012400160203
012500160203       begsr cleanFile;
012600160203
012700160203       setll 1 outFile;
012800160203       read outFile;
012900160203
013000160203       exsr saveRecord;
013100160203
013200160203       dow not %eof;
013300160203
013400160203        if o_@ss1f = ' ';
013500160203
013600160203         o_@ss1f = %trim(@ss1f2);
013700160203         o_@ss2f = %trim(@ss2f2);
013800160203         o_@fnf = %trim(@fnf2);
013900160203         o_@mif = %trim(@mif2);
014000160203         o_@lnf = %trim(@lnf2);
014100160203         o_@relf = %trim(@relf2);
014200160203         o_@sexf = %trim(@sexf2);
014300160203         o_@dobf = %trim(@dobf2);
014400160203         o_@specf = %trim(@specf2);
014500160203         //o_@zero = %trim('0');
014600160203         o_@cobf = %trim(@cobf2);
014700160203         o_@cobcf = %trim(@cobcf2);
014800160203         o_@cobnf = %trim(@cobnf2);
014900160203         o_@ad1f = %trim(@ad1f2);
015000160203         o_@ad2f = %trim(@ad2f2);
015100160203         o_@ctyf = %trim(@ctyf2);
015200160203         o_@stf = %trim(@stf2);
015300160203         o_@zp5f = %trim(@zp5f2);
015400160203         o_@phnf = %trim(@phnf2);
015500160203         o_@zipf = %trim(@zipf2);
015600160203         o_@empstf = %trim(@empstf2);
015700160208         o_@hiref = %trim(@hiref2);
015800160203
015900160203         update outFile;
016000160203        endif;
016100160203
016200160203       exsr saveRecord;
016300160203
016400160203       read outFile;
016500160203       enddo;
016600160203
016700160203       endsr;
016800160203
016900160203       //=========================================
017000160203       // Clean file 2
017100160203       //=========================================
017200160203
017300160203       begsr cleanFile2;
017400160203
017500160203       setll 1 outFile;
017600160203       read outFile;
017700160203
017800160203       dow not %eof;
017900160203
018000160203        if o_x@elrf = ' ';
018100160203         delete outFile;
018200160203        endif;
018300160203
018400160203       read outFile;
018500160203       enddo;
018600160203
018700160203       endsr;
018800160203
018900160203       //=========================================
019000160203       // Save Record
019100160203       //=========================================
019200160203
019300160203       begsr saveRecord;
019400160203
019500160203         @ss1f2 = %trim(o_@ss1f);
019600160203         @ss2f2 = %trim(o_@ss2f);
019700160203         @fnf2 = %trim(o_@fnf);
019800160203         @mif2 = %trim(o_@mif);
019900160203         @lnf2 = %trim(o_@lnf);
020000160203         @relf2 = %trim(o_@relf);
020100160203         @sexf2 = %trim(o_@sexf);
020200160203         @dobf2 = %trim(o_@dobf);
020300160203         @specf2 = %trim(o_@specf);
020400160203         //@zero2 = %trim('0');
020500160203         @cobf2 = %trim(o_@cobf);
020600160203         @cobcf2 = %trim(o_@cobcf);
020700160203         @cobnf2 = %trim(o_@cobnf);
020800160203         @ad1f2 = %trim(o_@ad1f);
020900160203         @ad2f2 = %trim(o_@ad2f);
021000160203         @ctyf2 = %trim(o_@ctyf);
021100160203         @stf2 = %trim(o_@stf);
021200160203         @zp5f2 = %trim(o_@zp5f);
021300160203         @phnf2 = %trim(o_@phnf);
021400160203         @zipf2 = %trim(o_@zipf);
021500160203         @empstf2 = %trim(o_@empstf);
021600160208         @hiref2 = %trim(o_@hiref);
021700160203
021800160203       endsr;
021900160203
022000160204       //=========================================
022100160204       // Create Key
022200160204       //=========================================
022300160204
022400160204       begsr createKey;
022500160204
022600160204       setll 1 outFile;
022700160204       read outFile;
022800160204
022900160204       dow not %eof;
023000160204
023100160428       //seq = seq + 1;
023200160208
023300160428       //o_e@key = %trim(o_@ss1f) + %trim(o_@ss2f)
023400160428       //        + %trim(o_e@planf) + %trim(o_@relf)
023500160428       //        + %trim(o_@dobf) + %char(seq);
023600160204
023700160429       o_e@key = %trim(o_@ss1f) + %trim(o_@ss2f)
023800160429               + %trim(o_@relf) + %trim(o_@dobf)
023900160429               + %trim(o_x@elrf);
024000160428
024100160204       update outFile;
024200160204
024300160204       read outFile;
024400160204       enddo;
024500160204
024600160204       endsr;
024700160204
024800160203       //=========================================
