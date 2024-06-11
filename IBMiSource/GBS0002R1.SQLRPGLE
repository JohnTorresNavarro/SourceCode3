000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400150812      *  Description: Aetna SHOP 834 Export  Create Incremential File.
000500150812      *  Programmer.: Brian Rees
000600150812      *  Date.......: 8/12/2015
000700150226      *
000800150812      *  Overview...: Aetna had requested that we would send a incremential file
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
002100150812     Fae8010wf  uf   e           k disk
002200150812     Fae8010Snt uf a e           k disk
002300150226      *-------------------------------------------------------------------------
002400150812     D SendData        s              1A
002500150812     D Mode            s             10A
002600150226      *-------------------------------------------------------------------------
002700150812      /Free
002800150812
002900150812         dou %Eof(ae8010wf);
003000150812            read ae8010wf;
003100150812
003200150812            if %eof(ae8010wf);
003300150812               leave;
003400150812            endif;
003500150812
003600150812            SendData = 'Y';
003700150812            Mode = 'ADD';
003800150812
003900150812            chain a8GrpSeq ae8010Snt;
004000150812            if %Found(ae8010Snt);
004100150812               Exsr CompareData;
004200150812            endif;
004300150812
004400150812
004500150812            if SendData = 'Y';
004600150812               exsr WriteRcd;
004700150813               a8RcdSts = snRcdSts;         // Update with Record Status.
004800150813               update ae801F;
004900150812            else;
005000150812               delete ae801F;
005100150812            endif;
005200150812         enddo;
005300150812
005400150812         *inlr = *on;
005500150812
005600150812         //-------------------------------------------------------
005700150812         Begsr CompareData;
005800150812            SendData = 'N' ;
005900150812
006000150813
006100150812            if  a8GrpSeq  <> snGrpSeq   or
006200150812                a8GrpName <> snGrpName  or
006300150812                a8GrpNbr  <> snGrpNbr   or
006400150812                a8MbrDep  <> snMbrDep   or
006500150812                a8RelCode <> snRelCode  or
006600150812                a8EmpSts  <> snEmpSts   or
006700150812                a8MedInd  <> snMedInd   or
006800150812                a8Medirsn <> snMedirsn  or
006900150812                a8Acreter <> snAcreter  or
007000150812                a8Stud    <> snStud     or
007100150812                a8HndCp   <> snHndCp    or
007200150812                a8ssnMbr  <> snssnMbr   or
007300150812                a8ssnDep  <> snssnDep   or
007400150812                a8Hire    <> snHire     or
007500150812                a8Term    <> snTerm     or
007600150812                a8qedt    <> snqedt     or
007700150812                a8Cbgndt  <> snCbgndt   or
007800150812                a8Ctrmdt  <> snCtrmdt   or
007900150812                a8enrl    <> snenrl     or
008000150812                a8CovEff  <> snCovEff   or
008100150812                a8CovEnd  <> snCovEnd   or
008200150812                a8LNam    <> snLNam     or
008300150812                a8FNam    <> snFNam     or
008400150812                a8MNam    <> snMNam     or
008500150812                a8Phone   <> snPhone    or
008600150812                a8Addr1   <> snAddr1    or
008700150812                a8Addr2   <> snAddr2    or
008800150812                a8City    <> snCity     or
008900150812                a8State   <> snState    or
009000150812                a8Zip     <> snZip      or
009100150812                a8Dob     <> snDob      or
009200150812                a8Gendr   <> snGendr    or
009300150812                a8Salry   <> snSalry    or
009400150812                a8WrkZip  <> snWrkZip   or
009500150812                a8Smoke   <> snSmoke    or
009600150812                a8Hndate  <> snHndate   or
009700150812                a8PlnTyp  <> snPlnTyp   or
009800150812                a8Plncod  <> snPlncod   or
009900150812                a8Covlvl  <> snCovlvl   or
010000150812                a8pcid    <> snpcid     or
010100150812                a8Exist   <> snExist    or
010200150812                a8PLNam   <> snPLNam    or
010300150812                a8PFNam   <> snPFNam    or
010400150812                a8PMNam   <> snPMNam    or
010500150812                a8DAddr1  <> snDAddr1   or
010600150812                a8DAddr2  <> snDAddr2   or
010700150812                a8DCity   <> snDCity    or
010800150812                a8DState  <> snDState   or
010900150812                a8DZip    <> snDZip     or
011000150812                a8Taxid   <> snTaxid  ;
011100150812
011200150813
011300150813                //?Something has changed...
011400150813                Mode = 'CHANGE';
011500150813
011600150813                //?Check to see if the Member was Termed.
011700150813                if a8Term > '0' ;
011800150813                  Mode = 'TERMED';
011900150813                endif;
012000150813
012100150813                //?Check to see if the Member was Reinstated.
012200150813                if a8Term = '0'  and snTerm <> '0';
012300150813                  Mode = 'REINSTATE';
012400150813                endif;
012500150813
012600150813
012700150812                Delete ae8010_r;
012800150812                SendData = 'Y';
012900150812
013000150812            endif;
013100150812
013200150812         EndSr;
013300150812         //-------------------------------------------------------
013400150812         Begsr WriteRcd;
013500150812
013600150812            snGrpSeq  = a8GrpSeq;
013700150812            snGrpName = a8GrpName;
013800150812            snGrpNbr  = a8GrpNbr ;
013900150812            snMbrDep  = a8MbrDep ;
014000150812            snRelCode = a8RelCode;
014100150812            snEmpSts  = a8EmpSts ;
014200150812            snMedInd  = a8MedInd ;
014300150812            snMedirsn = a8Medirsn;
014400150812            snAcreter = a8Acreter;
014500150812            snStud    = a8Stud   ;
014600150812            snHndCp   = a8HndCp  ;
014700150812            snssnMbr  = a8ssnMbr ;
014800150812            snssnDep  = a8ssnDep ;
014900150812            snHire    = a8Hire   ;
015000150812            snTerm    = a8Term   ;
015100150812            snqedt    = a8qedt   ;
015200150812            snCbgndt  = a8Cbgndt ;
015300150812            snCtrmdt  = a8Ctrmdt ;
015400150812            snenrl    = a8enrl ;
015500150812            snCovEff  = a8CovEff;
015600150812            snCovEnd  = a8CovEnd;
015700150812            snLNam    = a8LNam ;
015800150812            snFNam    = a8FNam ;
015900150812            snMNam    = a8MNam ;
016000150812            snPhone   = a8Phone;
016100150812            snAddr1   = a8Addr1;
016200150812            snAddr2   = a8Addr2;
016300150812            snCity    = a8City ;
016400150812            snState   = a8State;
016500150812            snZip     = a8Zip  ;
016600150812            snDob     = a8Dob  ;
016700150812            snGendr   = a8Gendr;
016800150812            snSalry   = a8Salry;
016900150812            snWrkZip  = a8WrkZip;
017000150812            snSmoke   = a8Smoke ;
017100150812            snHndate  = a8Hndate;
017200150812            snPlnTyp  = a8PlnTyp;
017300150812            snPlncod  = a8Plncod;
017400150812            snCovlvl  = a8Covlvl;
017500150812            snpcid    = a8pcid  ;
017600150812            snExist   = a8Exist;
017700150812            snPLNam   = a8PLNam ;
017800150812            snPFNam   = a8PFNam ;
017900150812            snPMNam   = a8PMNam ;
018000150812            snDAddr1  = a8DAddr1;
018100150812            snDAddr2  = a8DAddr2;
018200150812            snDCity   = a8DCity ;
018300150812            snDState  = a8DState;
018400150812            snDZip    = a8DZip  ;
018500150812            snTaxid   = a8Taxid  ;
018600150812
018700150812            snCrtDate = %Dec(%Date);
018800150812            snCrtTime = %Dec(%Time);
018900150813
019000150813
019100150813            //?Write Record Status.
019200150813            Select;
019300150813            when Mode = 'ADD';
019400150813               snRcdSts = '021';
019500150813            when Mode = 'CHANGE';
019600150813               snRcdSts = '001';
019700150813            when Mode = 'TERMED';
019800150813               snRcdSts = '024';
019900150813            when Mode = 'REINSTATE';
020000150813               snRcdSts = '025';
020100150813            EndSl;
020200150813
020300150812            Write ae8010_r;
020400150812
020500150812         Endsr;
