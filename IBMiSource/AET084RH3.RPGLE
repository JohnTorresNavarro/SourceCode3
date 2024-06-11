000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400151015      *  Description: Evergreen 834 Export. Create Incremential File.
000500151015      *  Programmer.: John Torres (cloned from Brian Rees - GBS0002R1)
000600161006      *  Date.......: 10/06/2016
000700150226      *
000800161006      *  Overview...: Send all recods for members and dep. when one record of the memger
000900161006      *    or dependent has changed.
001000150812      *
001100150812      *
001200150226      *-------------------------------------------------------------------------
001300150807      * Modifications
001400150807      *
001500150807      * Date         Programmer    Mod      Description
001600150807      *-------------------------------------------------------------------------
001700150812      *
001800150812      *
001900150807      *-------------------------------------------------------------------------
002000160428     Faet080wd1 uf a e           k disk    rename(aet080wdr:actualFile)
002100161006
002200160428     Faet080wh  uf a e           k disk    rename(aet080wdr:holdFile)
002300161006
002400160429     Faet080wds2uf a e           k disk    rename(aet080wdr:sendFile)
002500151020     F                                     prefix(sn)
002600160803
002700160803      *-------------------------------------------------------------------------
002800160803
002900160803     D hold_@fnf       S             15
003000160803     D hold_@dobf      S              8
003100160803
003200150226      *-------------------------------------------------------------------------
003300151112
003400151020       setll *loval holdFile;
003500151020       read holdFile;
003600151015
003700151020       dow not %eof;
003800150812
003900161005        exsr checkRecord;
004000151015
004100160428       read holdFile;
004200160428       enddo;
004300150812
004400160428       *inlr = *on;
004500150812
004600150812         //-------------------------------------------------------
004700161005
004800161005       begsr checkRecord;
004900160804
005000161005         setll (@ss1f) sendFile;
005100161005         reade (@ss1f) sendFile;
005200161005
005300161005         dow not %eof;
005400161005
005500161005          chain (snE@KEY) actualFile;
005600161005          if not %Found;
005700161005
005800161005            @SS1F = sn@SS1F;
005900161005            @SS2F = sn@SS2F;
006000161005            @FNF = sn@FNF;
006100161005            @MIF = sn@MIF;
006200161005            @LNF = sn@LNF;
006300161005            @RELF = sn@RELF;
006400161005            @SEXF = sn@SEXF;
006500161005            @DOBF = sn@DOBF;
006600161005            @SPECF = sn@SPECF;
006700161005            @COBF = sn@COBF;
006800161005            @COBCF = sn@COBCF;
006900161005            @COBNF = sn@COBNF;
007000161005            @AD1F = sn@AD1F;
007100161005            @AD2F = sn@AD2F;
007200161005            @CTYF = sn@CTYF;
007300161005            @STF = sn@STF;
007400161005            @ZP5F = sn@ZP5F;
007500161005            @PHNF = sn@PHNF;
007600161005            @ZIPF = sn@ZIPF;
007700161005            @EMPSTF = sn@EMPSTF;
007800161005            @HIREF = sn@HIREF;
007900161005            X@ELRF = snX@ELRF;
008000161005            H@C#F = snH@C#F;
008100161005            E@SFXF = snE@SFXF;
008200161005            E@ACCTF = snE@ACCTF;
008300161005            E@PLANF= snE@PLANF;
008400161006            E@PRDCT = snE@PRDCT;
008500161005            X@EFFF = snX@EFFF;
008600161005            X@TRMF = snX@TRMF;
008700161005            E@CLMF = snE@CLMF;
008800161005            E@PCPF = snE@PCPF;
008900161005            E@CBREXPF = snE@CBREXPF;
009000161005            E@CBREVTF = snE@CBREVTF;
009100161006            E@CBRLENF = snE@CBRLENF;
009200161005            E@KEY = snE@KEY;
009300161005            E@TRNCODE = '030';
009400161005            E@REASONCD = ' ';
009500161005            E@TDATE =  %char(%dec(%date: *iso));
009600161005
009700161005            write actualFile;
009800161005
009900161005          endif;
010000161005         reade (@ss1f) sendFile;
010100161005         enddo;
010200161005
010300161005         endsr;
010400160803
