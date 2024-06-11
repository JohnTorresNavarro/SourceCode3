000100170516      * 05/16/17 - check emailaddr file for any records that do not use
000200170516      *            @gbsio.net email addresses. This would allow reports
000300170516      *            to be automatically sent outside the company without
000400170516      *            our knowledge and they likely contain PHI.
000500210122      * 01/22/21 - add amwins.com
000600220119      * 01/19/22 dlk - change email to 60
000700220321      * 03/21/22 - add lisibroker.com (another amwins company with direct
000800220321      *            access to the system)
000900220321      *
0010001705160005 Femailaddr ip   e           k disk
0011001705160008 Fqde01p    O    F  132        PRINTER OFLIND(*INOF)
001200170516     D Pos             s              2S 0 inz
001300170516     D toterr          s              4S 0 inz
001400170516     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
001500170516     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
001600170516     D firste          s              1
001700170516     D                UDS
001800170516     D  CONAME               201    240
001900170516     D  LTIME                242    247  0
002000161010
002100170516      * look for the @ sign, the domain that follows must be GBSIO.NET
002200170516
002300170516       Pos = %scan('@':EAEMAIL);
002400170516       if Pos <> 0;
002500210122        if (%subst(%xlate(lo:up:eaemail):pos:10) <> '@GBSIO.NET') and
002600220321           (%subst(%xlate(lo:up:eaemail):pos:11) <> '@AMWINS.COM') and
002700220322           (%subst(%xlate(lo:up:eaemail):pos:15) <> '@LISIBROKER.COM') ;
002800170516         if firste = *blank or *inof;
002900170516         except head;
003000170516         firste = 'N';
003100170516         endif;
003200170516        except prt;
003300170516        toterr += 1;
003400170516        endif;
003500170516       endif;
003600170516
003700170516     clr                 if        toterr <> 0
003800170516     clr                 except    prtlr
003900170516     clr                 end
004000170516
0041001705160036 Oqde01p    e            head           2 03
0042001705160240 O                       CONAME              85
0043001705160367 O          e            head           1
0044001705160378 O                                            9 'RUN DATE:'
0045001705160113 O                       *DATE         Y     20
0046001705160369 O                                           70 'INVALID DOMAIN IN EMAIL'
0047001705160369 O                                           83 ' ADDRESS FILE'
0048001705160374 O                                          123 'PAGE :'
0049001705160375 O                       PAGE          Z    132
0050001705160367 O          e            head           1
0051001705160373 O                                           15 'PROGRAM : QDE01'
0052001705160120 O                                          123 'TIME :'
0053001705160121 O                       ltime              132 '  :  :  '
0054001705160367 O          e            head           1
0055001705160382 O                                           24 '""""""""""""""""""""""""'
0056001705160383 O                                           48 '""""""""""""""""""""""""'
0057001705160384 O                                           72 '""""""""""""""""""""""""'
0058001705160385 O                                           96 '""""""""""""""""""""""""'
0059001705160386 O                                          120 '""""""""""""""""""""""""'
0060001705160387 O                                          132 '""""""""""""'
0061001705160367 O          e            head           1
006200170516     O                                            4 'USER'
006300170516     O                                           25 'EMAIL ADDRESS'
0064001705160367 O          e            head           2
0065001705160382 O                                           24 '""""""""""""""""""""""""'
0066001705160383 O                                           48 '""""""""""""""""""""""""'
0067001705160384 O                                           72 '""""""""""""""""""""""""'
0068001705160385 O                                           96 '""""""""""""""""""""""""'
0069001705160386 O                                          120 '""""""""""""""""""""""""'
0070001705160387 O                                          132 '""""""""""""'
0071001705160380 O          E            PRT            1
007200170516     O                       EAUSRPRF            10
007300220119     O                       EAEMAIL             74
0074001705160380 O          E            PRTlr          1
007500170516     O                                              'TOTAL ERRORS:'
007600170516     O                       toterr        j     +2
