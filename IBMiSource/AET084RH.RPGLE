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
002500150226      *-------------------------------------------------------------------------
002600151112
002700151020       setll *loval holdFile;
002800151020       read holdFile;
002900151015
003000151020       dow not %eof;
003100150812
003200160428       chain (e@key) actualFile;
003300151020        if %Found;
003400151020         exsr writeRecord;
003500151020        endif;
003600151015
003700160428       read holdFile;
003800160428       enddo;
003900150812
004000160428       *inlr = *on;
004100150812
004200150812         //-------------------------------------------------------
004300151020
004400151020         Begsr WriteRecord;
004500151020
004600160429         setll (@ss1f) sendFile;
004700160429         reade (@ss1f) sendFile;
004800151020
004900151020         dow not %eof;
005000150812
005100160429         if @ss1F <> @ss2F;
005200160429
005300160428         if sne@key <> e@key and
005400160428            E@TRNCODE <> '021'      ;
005500151111
005600160428            @SS1F = sn@SS1F;
005700160428            @SS2F = sn@SS2F;
005800160428            @FNF = sn@FNF;
005900160428            @MIF = sn@MIF;
006000160428            @LNF = sn@LNF;
006100160428            @RELF = sn@RELF;
006200160428            @SEXF = sn@SEXF;
006300160428            @DOBF = sn@DOBF;
006400160428            @SPECF = sn@SPECF;
006500160428            @COBF = sn@COBF;
006600160428            @COBCF = sn@COBCF;
006700160428            @COBNF = sn@COBNF;
006800160428            @AD1F = sn@AD1F;
006900160428            @AD2F = sn@AD2F;
007000160428            @CTYF = sn@CTYF;
007100160428            @STF = sn@STF;
007200160428            @ZP5F = sn@ZP5F;
007300160428            @PHNF = sn@PHNF;
007400160428            @ZIPF = sn@ZIPF;
007500160428            @EMPSTF = sn@EMPSTF;
007600160428            @HIREF = sn@HIREF;
007700160428            X@ELRF = snX@ELRF;
007800160428            H@C#F = snH@C#F;
007900160428            E@SFXF = snE@SFXF;
008000160428            E@ACCTF = snE@ACCTF;
008100160428            E@PLANF= snE@PLANF;
008200160428            E@PRDCT = E@PRDCT;
008300160428            X@EFFF = snX@EFFF;
008400160428            X@TRMF = snX@TRMF;
008500160428            E@CLMF = snE@CLMF;
008600160428            E@PCPF = snE@PCPF;
008700160428            E@CBREXPF = snE@CBREXPF;
008800160428            E@CBREVTF = snE@CBREVTF;
008900160428            E@CBRLENF = E@CBRLENF;
009000160428            E@TRNCODE = E@TRNCODE;
009100160428            E@KEY = snE@KEY;
009200160428            E@TRNCODE = '030';
009300160428            E@REASONCD = ' ';
009400160428            E@TDATE =  %char(%dec(%date: *iso));
009500151020
009600151111            write actualFile;
009700151020
009800151020          endif;
009900160429
010000160429          endif;
010100150812
010200160429         reade (@ss1f) sendFile;
010300151020         enddo;
010400151020
010500160428         endsr;
010600151020
