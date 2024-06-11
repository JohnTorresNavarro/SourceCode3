0001000101310015 F******************************************************************
000200020322     F*                                                                *
0003000307230014 F* 07/23/03 DLK - new pgm : Read dbfbrwk, sort and break on      *
0004000307230015 F*                group #. If total < 0 then add this group #     *
0005000308290015 F*                to the file DBFBRNHS so later in dw260 we will  *
0006000309160015 F*                know who to exclude from payment (since they    *
0007000307230015 F*                end up with this negative payment amount).      *
0007010711300014 F* 11/30/07 DLK - change late indicator                          *
0007021605260014 F* 05/26/16 DLK - due to the change last september to seperate   *
0008001605260015 F*                non-shop from shop (exchange) group #'s into    *
0008011605260015 F*                seperate files that are sent to Care First      *
0008021605260015 F*                (their request) this program now needs to check *
0008031605260015 F*                to see if the g# is already in DBFBRNHS and if  *
0008041605260015 F*                if is there then update it with the $ amount    *
0008051605260015 F*                instead of just blindly adding a new record     *
0008061605260015 F*                in case there is ever a duplicate g# in both    *
0008071605260015 F*                the non-shop and shop workfiles.                *
0008081605260015 F*                                                                *
0008091605260015 F*                                                                *
0009000101310015 F******************************************************************
0010000210170017 Fdbfbrwk   iP   E           k DISK
0011001605260030 Fdbfbrnhs  uf a e           k DISK
0012000210170030 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
0013000203220055 D                UDS
0014000711300125 D  lseq                  21     22
0015000210170056 D  LEFFDT                85     92  0
0016000308060056 D  LEFFmd                85     88  0
0017000308060056 D  LEFFy                 89     92  0
0018000210170053 Idbfbrwkr
001900021017     I                                          dbwkgrp       L1
002000021017     I                                          dbwksg        L1
002100030723     C                   ADD       dbwkpaid      paid             10 2
002200020322
002300020322     cl1                 exsr      #l1sr
002400020322     clr                 exsr      #lrsr
002500020322
0026000210190103 C***************************************************
002700020322     c* total for group/subgroup
0028000210190103 C***************************************************
002900020322     c     #l1sr         begsr
003000021019
003001160526      * if positive amount, skip it
003100030723     c                   if        paid >= 0
003200021019     c                   clear                   paid
003300021019     c                   leavesr
003400021019     c                   end
003500021019
003600021019     C                   ADD       paid          totpay           13 2
003700031017     C                   ADD       1             totcnt            7 0
003800020322
003801160526     c                   clear                   ua                1
003802160526      * if record exists update it, else write a new rec
003803160526     c     nhskey        chain     dbfbrnhs
003804160526     c                   if        %found(dbfbrnhs)
003805160526     c                   add       paid          dnpaid
003807160526     C                   update    dbfbrnhr
003808160526     c                   move      'U'           ua
003809160526     c                   else
003900030806     c                   movel     leffymd       dneffdt
004000071130     c                   movel     lseq          dnseq
004100030723     c                   movel     dbwkgrp       dngrp
004200030723     c                   movel     dbwksg        dnsg
004300030723     c                   move      paid          dnpaid
004400030805     C                   write     dbfbrnhr
004401160526     c                   move      'A'           ua
004402160526     c                   end
004500021017
004600020327     c   of              except    head
004700020322     C                   EXCEPT    DETAIL
004800020322     C                   clear                   PAID
004900021019
005000020322     c                   endsr
005100020322
005200020322     c* final total
005300020322     c     #lrsr         begsr
005400020322     C                   EXCEPT    total
005500020322     c                   endsr
0056000210190107
005700021019
005800020322     c     *inzsr        begsr
005801160526
005802160526     c     nhskey        klist
005803160526     c                   kfld                    leffymd
005804160526     c                   kfld                    lseqnum
005805160526     c                   kfld                    dbwkgrp
005806160526     c                   kfld                    dbwksg
005808160526
005900021019     C                   TIME                    HTIME             6 0
006600030806
006700030806     c                   movel     leffy         leffymd           8 0
006800030806     c                   move      leffmd        leffymd
006801160526
006802160526     c                   move      lseq          lseqnum           2 0
006900030723
007000021019     C                   EXCEPT    HEAD
007100021017
007200020322     c                   endsr
007300010203
0074009606050237 OREPORT    E            HEAD           2 03
0075009606050239 O                                           73 '** GROUP BENEFIT SERVICE'
0076009606050241 O                                           77 'S **'
0077009606050242 O          E            HEAD           1
0078000307230244 O                                           74 'NEGATIVE FBR GROUPS'
0079009606050242 O          E            HEAD           1
008000030723 244 O                                           59 'FOR :'
008100030805 244 O                       LEFFDT              70 '  /  /    '
008200071130 244 O                                           +3 'RUN SEQUENCE:'
008300071130 244 O                       lseq                +2
0084009606050242 O          E            HEAD           1
0085000310020248 O                                           24 'PROGRAM NAME: DW262'
0086009606050249 O                                          122 'PAGE :'
0087009606050250 O                       PAGE          Z    131
0088009606050242 O          E            HEAD           1
0089009606050253 O                                           14 'RUN DATE:'
0090009606050254 O                       UDATE         Y     25
0091009606050255 O                                          122 'TIME :'
0092009606050256 O                       HTIME              131 '  :  :  '
0093009606050242 O          E            HEAD           1
0094009606050259 O                                           24 '------------------------'
0095009606050260 O                                           48 '------------------------'
0096009606050261 O                                           72 '------------------------'
0097009606050262 O                                           96 '------------------------'
0098009606050263 O                                          120 '------------------------'
0099009606050286 O                                          132 '------------'
0100009606050242 O          E            HEAD           1
0101000203220267 O                                            8 'GROUP'
0102000203220268 O                                           20 'SUBGROUP'
0103000203260268 O                                           46 'PAID'
0103011605260268 O                                           59 'UPDATE/ADD'
0104009606050242 O          E            HEAD           2
0105009606050259 O                                           24 '------------------------'
0106009606050260 O                                           48 '------------------------'
0107009606050261 O                                           72 '------------------------'
0108009606050262 O                                           96 '------------------------'
0109009606050263 O                                          120 '------------------------'
0110009606050286 O                                          132 '------------'
0111009606050287 O          E            DETAIL         1
0112000210170288 O                       dbwkgrp              8
0113000210170288 O                       dbwksg              20
0114000203260288 O                       paid          j     46
0114011605260288 O                       ua                  55
0115000203220287 O          e            total       1  1
0116000203220288 O                                            7 'TOTAL :'
0117000310170288 O                       totcnt        j     +2
0118000310170288 O                       TOTpay        j     46
