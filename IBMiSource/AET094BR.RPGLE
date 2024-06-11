000100160203      *=========================================================================
000200160203     H option(*noDebugIo)
000300160203      *=========================================================================
000400160203
000500170526     Faetgen    if   e             disk    rename(aetgen:mainFile)
000600160203     F                                     prefix(d_)
000700160203
000800170526     Faet090wd  uf a e             disk    rename(aet090wdr:outFile)
000900160203     F                                     prefix(o_)
001000160203
001100160203      *=========================================================================
001200160203
001300160203     d pos             S              2  0
001400160203     d pos2            S              2  0
001500160208     d seq             S              7  0
001600160830     d $scan_data      s             10a   inz('''')
001700160830     d $replace_data   s             10a   inz(' ')
001800160830     d $pos            s              2  0
001900160203
002000160203     D ds@member     e ds                  ExtName(AETMEM)
002100160203
002200160203     D ds@benefit    e ds                  ExtName(AETBEN)
002300160203
002400160203     D ds@member2    e ds                  ExtName(AETMEM2)
002500160203
002600160203      *=========================================================================
002700160203
002800160203       setll 1 mainFile;
002900160203       read mainFile;
003000160203
003100160203       dow not %eof;
003200160203
003300170526       pos = %scan('MEMBER' : d_aetgen);
003400160203       if pos > 0;
003500170526        ds@member = d_aetgen;
003600160203         exsr writeMember;
003700160203       endif;
003800160203
003900170526       pos2 = %scan('BENEFIT' : d_aetgen);
004000160203       if pos2 > 0;
004100170526        ds@benefit = d_aetgen;
004200160203         exsr writeBenefit;
004300160203       endif;
004400160203
004500160203       read mainFile;
004600160203       enddo;
004700160203
004800160203       exsr cleanFile;
004900160203       exsr cleanFile2;
005000160204       exsr createKey;
005100160203
005200160203       *inlr = *on;
005300160203       return;
005400160203
005500160203       //=========================================
005600160203       // Write member
005700160203       //=========================================
005800160203
005900160203       begsr writeMember;
006000160203
006100160203        clear outfile;
006200160203
006300160203        o_@ss1f = %trim(@ss1f);
006400160203        o_@ss2f = %trim(@ss2f);
006500160830
006600160203        o_@fnf = %trim(@fnf);
006700160830        $pos = %scan(%trim($scan_data):o_@fnf);
006800160830        if ($pos > 0);
006900160830         o_@fnf = %replace(%trim($replace_data)
007000160830           : o_@fnf : $pos : %len(%trim($scan_data)));
007100160830        endif;
007200160830
007300160203        o_@mif = %trim(@mif);
007400160830
007500160203        o_@lnf = %trim(@lnf);
007600160830        $pos = %scan(%trim($scan_data):o_@lnf);
007700160830        if ($pos > 0);
007800160830         o_@lnf = %replace(%trim($replace_data)
007900160830           : o_@lnf : $pos : %len(%trim($scan_data)));
008000160830        endif;
008100160830
008200160203        o_@relf = %trim(@relf);
008300160203        o_@sexf = %trim(@sexf);
008400160203        o_@dobf = %trim(@dobf);
008500160203        o_@specf = %trim(@specf);
008600160203        //o_@zero = %trim('0');
008700160203        o_@cobf = %trim(@cobf);
008800160203        o_@cobcf = %trim(@cobcf);
008900160203        o_@cobnf = %trim(@cobnf);
009000160203        o_@ad1f = %trim(@ad1f);
009100160203        o_@ad2f = %trim(@ad2f);
009200160203        o_@ctyf = %trim(@ctyf);
009300160203        o_@stf = %trim(@stf);
009400160203        o_@zp5f = %trim(@zp5f);
009500160203        o_@phnf = %trim(@phnf);
009600160203        o_@zipf = %trim(@zipf);
009700160203        o_@empstf = %trim(@empstf);
009800160208        o_@hiref = %trim(@hiref);
009900160204
010000160204        o_e@tdate =  %char(%dec(%date: *iso));
010100160203
010200160203        write outfile;
010300160203
010400160203       endsr;
010500160830
010600160203       //=========================================
010700160203       // Write benefit
010800160203       //=========================================
010900160203
011000160203       begsr writeBenefit;
011100160203
011200160203        clear outfile;
011300160203
011400160203        o_x@elrf = %trim(x@elrf);
011500160203        o_h@c#f = %trim(h@c#f);
011600160203        o_e@sfxf = %trim(e@sfxf);
011700160203        o_e@acctf = %trim(e@acctf);
011800160203        o_e@planf = %trim(e@planf);
011900160203        o_x@efff = %trim(x@efff);
012000160203        o_x@trmf = %trim(x@trmf);
012100160203        o_e@clmf = %trim(e@clmf);
012200160203        o_e@pcpf = %trim(e@pcpf);
012300160203        //o_e@pcpf2 = %trim(e@pcpf2);
012400160203        //o_e@pcpf3 = %trim(e@pcpf3);
012500160203        //o_@zero = %trim('0');
012600160203        o_e@cbrexpf = %trim(e@cbrexpf);
012700160203        o_e@cbrevtf = %trim(e@cbrevtf);
012800160203        o_e@cbrlenf = %trim(e@cbrlenf);
012900160203
013000160204        o_e@tdate =  %char(%dec(%date: *iso));
013100160204
013200160301        o_e@prdct = blank22;
013300160301
013400160203        write outfile;
013500160203
013600160203       endsr;
013700160203
013800160203       //=========================================
013900160203       // Clean file
014000160203       //=========================================
014100160203
014200160203       begsr cleanFile;
014300160203
014400160203       setll 1 outFile;
014500160203       read outFile;
014600160203
014700160203       exsr saveRecord;
014800160203
014900160203       dow not %eof;
015000160203
015100160203        if o_@ss1f = ' ';
015200160203
015300160203         o_@ss1f = %trim(@ss1f2);
015400160203         o_@ss2f = %trim(@ss2f2);
015500160203         o_@fnf = %trim(@fnf2);
015600160203         o_@mif = %trim(@mif2);
015700160203         o_@lnf = %trim(@lnf2);
015800160203         o_@relf = %trim(@relf2);
015900160203         o_@sexf = %trim(@sexf2);
016000160203         o_@dobf = %trim(@dobf2);
016100160203         o_@specf = %trim(@specf2);
016200160203         //o_@zero = %trim('0');
016300160203         o_@cobf = %trim(@cobf2);
016400160203         o_@cobcf = %trim(@cobcf2);
016500160203         o_@cobnf = %trim(@cobnf2);
016600160203         o_@ad1f = %trim(@ad1f2);
016700160203         o_@ad2f = %trim(@ad2f2);
016800160203         o_@ctyf = %trim(@ctyf2);
016900160203         o_@stf = %trim(@stf2);
017000160203         o_@zp5f = %trim(@zp5f2);
017100160203         o_@phnf = %trim(@phnf2);
017200160203         o_@zipf = %trim(@zipf2);
017300160203         o_@empstf = %trim(@empstf2);
017400160208         o_@hiref = %trim(@hiref2);
017500160203
017600160203         update outFile;
017700160203        endif;
017800160203
017900160203       exsr saveRecord;
018000160203
018100160203       read outFile;
018200160203       enddo;
018300160203
018400160203       endsr;
018500160203
018600160203       //=========================================
018700160203       // Clean file 2
018800160203       //=========================================
018900160203
019000160203       begsr cleanFile2;
019100160203
019200160203       setll 1 outFile;
019300160203       read outFile;
019400160203
019500160203       dow not %eof;
019600160203
019700160203        if o_x@elrf = ' ';
019800160203         delete outFile;
019900160203        endif;
020000160203
020100160203       read outFile;
020200160203       enddo;
020300160203
020400160203       endsr;
020500160203
020600160203       //=========================================
020700160203       // Save Record
020800160203       //=========================================
020900160203
021000160203       begsr saveRecord;
021100160203
021200160203         @ss1f2 = %trim(o_@ss1f);
021300160203         @ss2f2 = %trim(o_@ss2f);
021400160203         @fnf2 = %trim(o_@fnf);
021500160203         @mif2 = %trim(o_@mif);
021600160203         @lnf2 = %trim(o_@lnf);
021700160203         @relf2 = %trim(o_@relf);
021800160203         @sexf2 = %trim(o_@sexf);
021900160203         @dobf2 = %trim(o_@dobf);
022000160203         @specf2 = %trim(o_@specf);
022100160203         //@zero2 = %trim('0');
022200160203         @cobf2 = %trim(o_@cobf);
022300160203         @cobcf2 = %trim(o_@cobcf);
022400160203         @cobnf2 = %trim(o_@cobnf);
022500160203         @ad1f2 = %trim(o_@ad1f);
022600160203         @ad2f2 = %trim(o_@ad2f);
022700160203         @ctyf2 = %trim(o_@ctyf);
022800160203         @stf2 = %trim(o_@stf);
022900160203         @zp5f2 = %trim(o_@zp5f);
023000160203         @phnf2 = %trim(o_@phnf);
023100160203         @zipf2 = %trim(o_@zipf);
023200160203         @empstf2 = %trim(o_@empstf);
023300160208         @hiref2 = %trim(o_@hiref);
023400160203
023500160203       endsr;
023600160203
023700160204       //=========================================
023800160204       // Create Key
023900160204       //=========================================
024000160204
024100160204       begsr createKey;
024200160204
024300160204       setll 1 outFile;
024400160204       read outFile;
024500160204
024600160204       dow not %eof;
024700160204
024800160830       // o_e@key = %trim(o_@ss1f) + %trim(o_@ss2f)
024900160830       //         + %trim(o_@relf) + %trim(o_@dobf)
025000160830       //         + %trim(o_x@elrf);
025100160428
025200160830       o_e@key = %trim(o_@ss1f) + %trim(o_@ss2f)
025300160830               + %trim(o_@relf) + %trim(o_@dobf)
025400160830               + %trim(o_x@elrf) + %trim(o_@fnf);
025500160830
025600160204       update outFile;
025700160204
025800160204       read outFile;
025900160204       enddo;
026000160204
026100160204       endsr;
026200160204
026300160203       //=========================================
