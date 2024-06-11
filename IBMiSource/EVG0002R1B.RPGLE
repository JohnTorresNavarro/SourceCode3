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
002100160804     Fevrgrenxplif   e           k disk    rename(evgxpts:sendFile)
002200151014     F                                     prefix(sn)
002300160804
002400160804     Fevrgrenxpeuf a e           k disk    rename(evgxpth:holdFile)
002500160804
002600160804     Fevrgrenxptif   e           k disk    rename(evgxpth:tempHold)
002700160804     F                                     prefix(th)
002800160804
002900150226      *-------------------------------------------------------------------------
003000160804
003100160804       setll *loval tempHold;
003200160804       read tempHold;
003300151015
003400160804       dow not %eof;
003500160804
003600160804        setll thevsubscr sendFile;
003700160804        reade thevsubscr sendFile;
003800160804        dow not %eof;
003900151015
004000160804         chain snevgrpseq holdFile;
004100160804         if not %found;
004200160804          exsr writeHold;
004300160804         endif;
004400160804
004500160804        reade thevsubscr sendFile;
004600160804        enddo;
004700160804
004800160804       read tempHold;
004900160804       enddo;
005000150812
005100150812         *inlr = *on;
005200150812
005300150812         //-------------------------------------------------------
005400160804
005500160804         Begsr writeHold;
005600150812
005700160804          EVSUBSCR = snEVSUBSCR;
005800160805           EVGRPSEQ = snEVGRPSEQ;
005900160805           EVSSNMBR = snEVSSNMBR;
006000160804          EVMBRDEP = snEVMBRDEP;
006100150813
006200160804          write holdFile;
006300150812
006400150812         Endsr;
006500160804
006600160804         //-------------------------------------------------------
