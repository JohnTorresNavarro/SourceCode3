000100160203      *=========================================================================
000200160203     H option(*noDebugIo)
000300160203      *=========================================================================
000400160203
000500160914     Faet1050wfluf a e           k disk    rename(aet1050wlr:newFile)
000600160203
000700160914     Faet1050wf uf a e             disk    rename(aet1050wf:medFile)
000800160330     F                                     prefix(m_)
000900160203
001000160914     Faet1050wfvuf a e             disk    rename(aet1050wf:visFile)
001100160330     F                                     prefix(v_)
001200160330
001300160203      *=========================================================================
001400160203
001500160208     d seq             S              7  0
001600160916     d pos             S              2  0
001700160916     d pos2            S              2  0
001800160916     d recordCount     S             10  0 inz(0)
001900160926     d benefitCount    S             10  0 inz(0)
002000160916
002100160916     d trailer         ds
002200160916     d  trailerF               1      7
002300160916     d  reccountF              8     17
002400160916     d  dateTimeF             18     31
002500160926     d  bencountF             32     41
002600160921     d  blank                 42     68
002700160921     d  asteric               69     69
002800160916
002900160203      *=========================================================================
003000160916
003100160330       setll 1 medFile;
003200160330       read medFile;
003300160203
003400160203       dow not %eof;
003500160203
003600160914        @dataf = m_aet1050wf;
003700160330        @seq# = @seq# + 10;
003800160330
003900160330        write newFile;
004000160330
004100160330       read medFile;
004200160203       enddo;
004300160203
004400160330       exsr insert;
004500160330       exsr reCreate;
004600160916       exsr fixTrailer;
004700160330
004800160203       *inlr = *on;
004900160203       return;
005000160203
005100160203       //=========================================
005200160330       // insert
005300160203       //=========================================
005400160203
005500160330       begsr insert;
005600160330
005700160330       setll 1 visFile;
005800160330       read visFile;
005900160330
006000160330       dow not %eof;
006100160330
006200160330        setll *loval newFile;
006300160330        read newfile;
006400160330
006500160330        dow not %eof;
006600160330
006700160914        if @dataf = v_aet1050wf;
006800160330         delete visFile;
006900160330          setll 1 visFile;
007000160330          read visFile;
007100160914           @dataf = v_aet1050wf;
007200160330           @seq# = @seq# + 1;
007300160330           write newfile;
007400160330          delete visFile;
007500160330         leave;
007600160330        endif;
007700160330
007800160330        read newfile;
007900160330        enddo;
008000160330
008100160330       read visFile;
008200160330       enddo;
008300160330
008400160330       endsr;
008500160204
008600160330       //=========================================
008700160330       // reCreate
008800160330       //=========================================
008900160330
009000160330       begsr reCreate;
009100160330
009200160330       setll 1 medFile;
009300160330       read medFile;
009400160330
009500160330       dow not %eof;
009600160330
009700160330       delete medFile;
009800160330
009900160330       read medFile;
010000160330       enddo;
010100160330
010200160330       setll *loval newFile;
010300160330       read newFile;
010400160330
010500160330       dow not %eof;
010600160330
010700160914       m_aet1050wf = @dataF;
010800160330       write medFile;
010900160330
011000160330       read newFile;
011100160330       enddo;
011200160330
011300160330       endsr;
011400160330
011500160916       //=========================================
011600160916       // fixTrailer
011700160916       //=========================================
011800160916
011900160916       begsr fixTrailer;
012000160916
012100160916        setll 1 medFile;
012200160916        read medFile;
012300160916
012400160916        dow not %eof;
012500160916
012600160926         pos = %scan('BENEFIT' : m_aet1050wf);
012700160916         if pos > 0;
012800160926          benefitCount = benefitCount + 1;
012900160916         endif;
013000160916
013100160916         recordCount = recordCount + 1;
013200160916
013300160916         pos2 = %scan('TRAILER' : m_aet1050wf);
013400160916         if pos2 > 0;
013500160916          trailer = m_aet1050wf;
013600160920           reccountF = %editc(recordCount : 'X');
013700160926            bencountF = %editc(benefitCount : 'X');
013800160921            asteric = '*';
013900160920           m_aet1050wf = trailer;
014000160920          update medFile;
014100160916         endif;
014200160916
014300160916        read medFile;
014400160916        enddo;
014500160916
014600160916       endsr;
014700160916
014800160203       //=========================================
