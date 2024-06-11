000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400151015      *  Description: Evergreen 834 Export. Create Incremential File.
000500151015      *  Programmer.: John Torres (cloned from Brian Rees - GBS0002R1)
000600151015      *  Date.......: 9/01/2015
000700150226      *
000800151015      *  Overview...: Evergreen had requested that we would send a incremential file
000900150812      *    instead of a full file.  A new database was setup to hold the sent
001000150812      *    records.
001100150812      *
001200150812      *
001300150226      *-------------------------------------------------------------------------
001400150807      * Modifications
001500150807      *
001600150807      * Date         Programmer    Mod      Description
001700150807      *-------------------------------------------------------------------------
001800150812      *
001900150812      *
002000150807      *-------------------------------------------------------------------------
002100160428     Faet080wd1 uf a e           k disk    rename(aet080wdr:actualFile)
002200160428     Faet080wh  uf a e           k disk    rename(aet080wdr:holdFile)
002300160429     Faet080wds2uf a e           k disk    rename(aet080wdr:sendFile)
002400151020     F                                     prefix(sn)
002500160803
002600160803      *-------------------------------------------------------------------------
002700160803
002800160803     D hold_@fnf       S             15
002900160803     D hold_@dobf      S              8
003000160803
003100150226      *-------------------------------------------------------------------------
003200151112
003300151020       setll *loval holdFile;
003400151020       read holdFile;
003500151015
003600151020       dow not %eof;
003700150812
003800160803       if @relf = '01';
003900160804       chain (e@key) actualFile;
004000160804        if %Found;
004100160804         exsr writeRecord;
004200160804        endif;
004300160803       endif;
004400160803
004500160803       if @relf <> '01';
004600160803        chain (e@key) actualFile;
004700160803        if %found;
004800160803         hold_@fnf = @fnf;
004900160803          hold_@dobf = @dobf;
005000160803         exsr getOthers;
005100160803        endif;
005200160803       endif;
005300151015
005400160428       read holdFile;
005500160428       enddo;
005600150812
005700160428       *inlr = *on;
005800150812
005900150812         //-------------------------------------------------------
006000160804
006100160804         Begsr WriteRecord;
006200160804
006300160804         setll (@ss1f) sendFile;
006400160804         reade (@ss1f) sendFile;
006500160804
006600160804         dow not %eof;
006700160804
006800160804         if @ss1F <> @ss2F;
006900160804
007000160804         if sne@key <> e@key and
007100160804            E@TRNCODE <> '021'      ;
007200160804
007300160804            @SS1F = sn@SS1F;
007400160804            @SS2F = sn@SS2F;
007500160804            @FNF = sn@FNF;
007600160804            @MIF = sn@MIF;
007700160804            @LNF = sn@LNF;
007800160804            @RELF = sn@RELF;
007900160804            @SEXF = sn@SEXF;
008000160804            @DOBF = sn@DOBF;
008100160804            @SPECF = sn@SPECF;
008200160804            @COBF = sn@COBF;
008300160804            @COBCF = sn@COBCF;
008400160804            @COBNF = sn@COBNF;
008500160804            @AD1F = sn@AD1F;
008600160804            @AD2F = sn@AD2F;
008700160804            @CTYF = sn@CTYF;
008800160804            @STF = sn@STF;
008900160804            @ZP5F = sn@ZP5F;
009000160804            @PHNF = sn@PHNF;
009100160804            @ZIPF = sn@ZIPF;
009200160804            @EMPSTF = sn@EMPSTF;
009300160804            @HIREF = sn@HIREF;
009400160804            X@ELRF = snX@ELRF;
009500160804            H@C#F = snH@C#F;
009600160804            E@SFXF = snE@SFXF;
009700160804            E@ACCTF = snE@ACCTF;
009800160804            E@PLANF= snE@PLANF;
009900160804            E@PRDCT = E@PRDCT;
010000160804            X@EFFF = snX@EFFF;
010100160804            X@TRMF = snX@TRMF;
010200160804            E@CLMF = snE@CLMF;
010300160804            E@PCPF = snE@PCPF;
010400160804            E@CBREXPF = snE@CBREXPF;
010500160804            E@CBREVTF = snE@CBREVTF;
010600160804            E@CBRLENF = E@CBRLENF;
010700160804            E@TRNCODE = E@TRNCODE;
010800160804            E@KEY = snE@KEY;
010900160804            E@TRNCODE = '030';
011000160804            E@REASONCD = ' ';
011100160804            E@TDATE =  %char(%dec(%date: *iso));
011200160804
011300160804            write actualFile;
011400160804
011500160804          endif;
011600160804
011700160804          endif;
011800160804
011900160804         reade (@ss1f) sendFile;
012000160804         enddo;
012100160804
012200160804         endsr;
012300151020
012400160803         //-------------------------------------------------------
012500160803
012600160803         Begsr getOthers;
012700160803
012800160803
012900160803         setll (@ss1f) sendFile;
013000160803         reade (@ss1f) sendFile;
013100160803
013200160803         dow not %eof;
013300160803
013400160803         if hold_@FNF <> sn@FNF;
013500160803          if hold_@DOBF <> sn@DOBF;
013600160803
013700160803            @SS1F = sn@SS1F;
013800160803            @SS2F = sn@SS2F;
013900160803            @FNF = sn@FNF;
014000160803            @MIF = sn@MIF;
014100160803            @LNF = sn@LNF;
014200160803            @RELF = sn@RELF;
014300160803            @SEXF = sn@SEXF;
014400160803            @DOBF = sn@DOBF;
014500160803            @SPECF = sn@SPECF;
014600160803            @COBF = sn@COBF;
014700160803            @COBCF = sn@COBCF;
014800160803            @COBNF = sn@COBNF;
014900160803            @AD1F = sn@AD1F;
015000160803            @AD2F = sn@AD2F;
015100160803            @CTYF = sn@CTYF;
015200160803            @STF = sn@STF;
015300160803            @ZP5F = sn@ZP5F;
015400160803            @PHNF = sn@PHNF;
015500160803            @ZIPF = sn@ZIPF;
015600160803            @EMPSTF = sn@EMPSTF;
015700160803            @HIREF = sn@HIREF;
015800160803            X@ELRF = snX@ELRF;
015900160803            H@C#F = snH@C#F;
016000160803            E@SFXF = snE@SFXF;
016100160803            E@ACCTF = snE@ACCTF;
016200160803            E@PLANF= snE@PLANF;
016300160803            E@PRDCT = snE@PRDCT;
016400160803            X@EFFF = snX@EFFF;
016500160803            X@TRMF = snX@TRMF;
016600160803            E@CLMF = snE@CLMF;
016700160803            E@PCPF = snE@PCPF;
016800160803            E@CBREXPF = snE@CBREXPF;
016900160803            E@CBREVTF = snE@CBREVTF;
017000160803            E@CBRLENF = E@CBRLENF;
017100160803            //E@TRNCODE = E@TRNCODE;
017200160803            E@KEY = snE@KEY;
017300160803            E@TRNCODE = '030';
017400160803            E@REASONCD = ' ';
017500160803            E@TDATE =  %char(%dec(%date: *iso));
017600160803
017700160803        chain (e@key) actualFile;
017800160803        if not %found;
017900160803         write actualFile;
018000160803        endif;
018100160803
018200160803          endif;
018300160803         endif;
018400160803
018500160803         reade (@ss1f) sendFile;
018600160803         enddo;
018700160803
018800160803         endsr;
018900160803
