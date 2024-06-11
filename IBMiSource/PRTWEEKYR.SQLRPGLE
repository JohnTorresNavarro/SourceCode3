000100160520     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBDIR')
000200160406      *-------------------------------------------------------------------------
000300160406      *
000400210831      *  Description: Online Enrollment Weekly Summary Report
000500191015      *  Programmer.: Jon Allen
000600210831      *  Date.......: 08/31/2021
000700160406      *
000800160406      *-------------------------------------------------------------------------
000900160406      * Modifications
001000160406      *
001100160406      * Date         Programmer    Mod      Description
001200160406      *-------------------------------------------------------------------------
001300181121      *
001400181121      *
001500181121      *
001600160406      *-------------------------------------------------------------------------
001700210831     FPRTWEEKYP O  A E           K Disk
001800191015     FAACODE    IF   E           K Disk
001900191015     FACCMST    IF   E           K Disk    extfile('F.ACCMST')
002000191015     F                                     prefix('A_')
002100191015     FMEMBER    IF   E           K Disk    extfile('F.MEMBER')
002200191015
002300160406      *?Program status data structure
002400160406     D PGMD          ESDS                  EXTNAME(IOPGMD)
002500160406     D  @pgmq            *proc
002600160406
002700160406      *?Variables
002800191029     D Today           s              8s 0 inz
002900191029     D wwtr            s              3s 0 inz
003000191029     D wwsu            s              3s 0 inz
003100191029     D wwac            s              4s 0 inz
003200191029     D wwfr            s              8s 0 inz
003300191029     D wwto            s              8s 0 inz
003400191015
003500191015     D mainds        e ds                  extname(webtran) inz
003600191015
003700191015     D @Data           ds
003800210831     D  sqgrpv                       10
003900191015     D  sqtrst                        3  0
004000191015     D  sqSub#                        3  0
004100191015     D  sqAcct                        4  0
004200160406
004300160406      *-------------------------------------------------------------------------
004400160406      *?Mainline Program
004500160406      *-------------------------------------------------------------------------
004600191029
004700191029     C     *entry        Plist
004800191029     C                   Parm                    wifr              8
004900210903     C                   Parm                    wito              8
005000210903     C                   Parm                    wisys            10
005100191029
005200191029     C                   move      wifr          wwfr
005300191029     C                   move      wito          wwto
005400191029
005500191015         Today = %int(%char(%date : *iso0)) ;
005600191029
005700161014         exsr $OpenC1;
005800191029
005900161014         *inlr = *on;
006000161014       //-----------------------------------------------------------------
006100161014       begsr $OpenC1;
006200161014
006300161014         Exec Sql
006400161014            Declare C1 Cursor For
006500161014
006600210831            Select Distinct oegrpv, oetrst, oesub#, oeacct
006700161018            From WebTran
006800191029            Where oeaddd >= :wwfr and oeaddd <= :wwto;
006900161018
007000161014         Exec Sql    Open C1;
007100191029
007200191029         Dou SqlCod <> *Zero;
007300191029
007400191029           Exec Sql  Fetch Next From C1 Into :@data ;                       sno ;
007500191029
007600191029           if SqlCod <> *Zero;
007700191029             leave;
007800191029           endif;
007900191029
008000210831         wkTRST = sqTRST;
008100210831         wkSUB# = sqSUB#;
008200210831         wkACCT = sqACCT;
008300210903         wkgrpv = sqgrpv;
008400210903         wksys  = wisys;
008500191029
008600191029         chain (sqtrst:sqsub#:sqacct) ACCMST;
008700191029         if %Found(ACCMST);
008800210831         WKACNAME = %trim(A_ACNAM1);
008900191029         endif;
009000191029
009100191029         chain (A_AACODE) AACODE;
009200191029         if %Found(AACODE);
009300210831         WKAACOD = A_AACODE;
009400210831         WKAANAME = %trim(AFNAM) + ' ' + %trim(ALNAM) ;
009500191029         endif;
009600210831
009700210831         select;
009800210831         when   wkaacod = 'EDT';
009900210901         when   wkaacod = 'EVT';
010000210901         when   wkgrpv  = 'DECLINED';
010100210901         when   wkgrpv  = 'KEEP';
010200210831         other;
010300210831         write  prtweekyr;
010400210831         endsl;
010500191029
010600191029         enddo;
010700191029
010800191029         Exec Sql  Close C1;
010900191029
011000161014
011100161014         endsr;
011200191029       //-----------------------------------------------------------------
