000100160406      *=========================================================================
000200160406     H option(*noDebugIo)
000300160406      *=========================================================================
000400160406
000500160406     Fshutoffcarif   e           k disk    rename(shtoffr:shtoffFile)
000600160406
000700160406     Fcaraccx   uf   e           k disk    rename(caraccr:acctFile)
000800160406
000900160505     Fdiaryhd1  o    e           k disk    extfile('F.DIARYHD1')
001000160505
001100160505     Fhistak    o    e           k disk    extfile('F.HISTAK')
001200160505
001300160406      *=========================================================================
001400160406
001500160406     D action          s              3
001600160406
001700160406      //========================================================================
001800160406
001900160406     C     *entry        plist
002000160406     C                   parm                    action
002100160406
002200160406       setll *loval shtoffFile;
002300160406       read shtoffFile;
002400160406
002500160406       dow not %eof;
002600160406
002700160406        setll (strust : ssub# : sacct) acctFile;
002800160406        reade (strust : ssub# : sacct) acctFile;
002900160406
003000160406        dow not %eof;
003100160406        if cauniq = '0000000114';
003200160406
003300160406         if action = 'ON ';
003400160406          castatus = 'Y';
003500160406         endif;
003600160406
003700160406         if action = 'OFF';
003800160406          castatus = 'N';
003900160406         endif;
004000160406
004100160406         update acctFile;
004200160505
004300160505         exsr diaryNote;
004400160406
004500160406        endif;
004600160406
004700160406        reade (strust : ssub# : sacct) acctFile;
004800160406        enddo;
004900160406
005000160406       read shtoffFile;
005100160406       enddo;
005200160406
005300160406       *inlr = *on;
005400160406       return;
005500160406
005600160505       //=======================================================================
005700160505       // Diary Note
005800160505       //=======================================================================
005900160505
006000160505       begsr diaryNote;
006100160505
006200160505        nhkey = %editc(strust: 'X') + %editc(ssub#: 'X') + %editc(sacct: 'X');
006300160505        nhcode = 'WFT';
006400160505
006500160505        if action = 'ON ';
006600160505         nhsubj = 'EVRGR-TRANSMISSION TURNED ON';
006700160505        endif;
006800160505
006900160505        if action = 'OFF';
007000160505         nhsubj = 'EVRGR-TRANSMISSION TURNED OFF';
007100160505        endif;
007200160505
007300160505        nhaddt = %dec(%date);
007400160505        nhadti = %dec(%time);
007500160505        nhadus = 'ROBOT';
007600160505
007700160505        write rdiaryhd;
007800160505
007900160505        clear histr;
008000160505        hkey = %editc(strust: 'X') + %editc(ssub#: 'X') + %editc(sacct: 'X');
008100160505        trcode = 'UHM';
008200160505
008300160505        if action = 'ON ';
008400160505         ck#not = 'EVRGR-TRANSMISSION TURNED ON';
008500160505        endif;
008600160505
008700160505        if action = 'OFF';
008800160505         ck#not = 'EVRGR-TRANSMISSION TURNED OFF';
008900160505        endif;
009000160505
009100160505        hprgnm = 'CARACTDACT';
009200160505        hstrst = catrst;
009300160505        hssub# = casub#;
009400160505        hsacct = caacct;
009500160505        hsdltd = 'A';
009600160505        trdate = %dec(%date);
009700160505        hstrtime = %time;
009800160505        hoper  = 'ROBOT';
009900160505
010000160505        write histr;
010100160505
010200160505       endsr;
010300160505
010400160406      //========================================================================
