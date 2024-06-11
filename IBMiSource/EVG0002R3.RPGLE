000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400151030      *  Description: Evergreen 834 Export. Clean Incremential File.
000500151030      *  Programmer.: John Torres
000600151030      *  Date.......: 10/30/2015
000700150226      *
000800160822      *  Overview...: New Evergreen/Valence are mostly adds (transaction code '021'), however
000900151030      *    there are some instances where members are being created wrong so users will create a
001000151030      *    termination of coverage record. The issue is that we cannot send a trans code of '024'
001100160822      *    (coverage termination), because there was never a record at Valence to terminate, and
001200151030      *    the logic of the process creates a '021' because there was never a record sent. This
001300151030      *    program will clean those instances.
001400150812      *
001500150226      *-------------------------------------------------------------------------
001600150807      * Modifications
001700150807      *
001800150807      * Date         Programmer    Mod      Description
001900150807      *-------------------------------------------------------------------------
002000150812      *
002100150812      *
002200150807      *-------------------------------------------------------------------------
002300151030
002400151030     Fevrgrenxpnuf a e           k disk    rename(evgxptf:mainFile)
002500151030
002600150226      *-------------------------------------------------------------------------
002700151020
002800151030       setll *loval mainFile;
002900151030       read mainFile;
003000151015
003100151020       dow not %eof;
003200150812
003300160822        if evtrncode = '021';
003400160822         if evcoveff = evcovend;
003500160822          delete mainFile;
003600160822         endif;
003700151020        endif;
003800151015
003900151030       read mainFile;
004000151030       enddo;
004100150812
004200151030       *inlr = *on;
004300151030       return;
004400151020
004500151030      *-------------------------------------------------------------------------
