000100141209     Hoption(*nodebugio)
000200150213      *------------------------------------------------------------------
000300151223      * 12/23/2015  B.Rees:  New Parm Added. Send Error Message. Will
000400151223      *    display the error if anything other than 'N' is passed.
000500151223      *
000600151223      *------------------------------------------------------------------
000700151106     FPgmAuthl1 if   e           k disk
000800151106     FChkFncAutDcf   e             workstn
000900150213
001000150213     D pgmsts         sDS
001100170809     D @Name                         10    Overlay( PgmSts: 254 )
001200150213     D CurrentUser                   10    Overlay( PgmSts: 358 )
001300150213
001400170809     d User_40         S             40
001500150213      *------------------------------------------------------------------
001600150213      * Main Program
001700150213      *------------------------------------------------------------------
001800150213     C     *Entry        Plist
001900150213     C                   parm                    Program          10
002000151106     C                   parm                    Func             20
002100151223     C                   parm                    DspErrMsg         1
002200150213     C                   parm                    Continue          1
002300150213
002400150213      /free
002500150213
002600150213            Continue = 'N';
002700150213
002800170809            User_40 = CurrentUser;
002900170809
003000151106            chain (Program : Func : CurrentUser) PgmAuthl1;
003100151106            if %Found(PgmAuthl1);
003200150213               if Authorized = 'Y';
003300150213                  Continue = 'Y';
003400150213               endif;
003500150213            endif;
003600150213
003700150213
003800151223            //?Check Dates.. Start Date
003900150213            if Continue = 'Y' ;
004000150213              if StartDate > 0 ;
004100150213                 if StartDate > %Dec(%Date);
004200150213                    Continue = 'N';
004300150213                 endif;
004400150213              endif;
004500150213            endif;
004600150213
004700151223            //?End Date
004800150213            if Continue = 'Y' ;
004900150213              if EndDate > 0 ;
005000150213                 if  %Dec(%Date) > EndDate;
005100150213                    Continue = 'N';
005200150213                 endif;
005300150213              endif;
005400150213            endif;
005500150213
005600151223            //?Check Display Message Flag.
005700151223            //?If set to No. Leave.
005800151223            if DspErrMsg = 'N';
005900151223               *inlr = *on;
006000151223               return;
006100151223            endif;
006200151223
006300150213            if Continue = 'N';
006400150213              Dou *in03  = *on;
006500170809
006600170809                 s1Name = User_40;
006700170809
006800151223                 exfmt Error;
006900151223                 if *in03 = *on;
007000151223                   leave;
007100151223                 endif;
007200151223              Enddo;
007300151223            endif;
007400150213
007500150213             *inlr = *on;
