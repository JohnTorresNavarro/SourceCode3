0001009102120002 F******************************************************************
0002009908190003 F* RP170      GROUP BENEFIT SERVICES SOFTWARE           1990      *
0003009102120004 F*                                                                *
0004009102120005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009102120006 F*            DATE - 10/23/90                                     *
0006009102120007 F*                                                                *
0007009102120008 F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE A LIST OF ACCOUNTS    *
0008009102120009 F*                PENDING CANCELLATION DUE TO NON PAYMENT.        *
0009009102120010 F*                                                                *
001000980218     F* DMA 02.18.98  Changed name from Wendy P. to Carol F.           *
001100980602     F* DLK 06/98     CHANGE SELECTION LOGIC PER CINDY REQUEST         *
0012009806020011 F*               AND CONVERT TO RPG                               *
001300981203     F* DLK 12/98     CHANGE WITHHOLD CARE REPORT AND LETTERS TO ONLY  *
0014009812030011 F*               PRINT BLUE CROSS AND PHN GROUP#'S                *
001500990105     F* DLK 01/99     EXCLUDE BCP & BAC FROM CREDIT CALCULATION        *
0016009806020011 F*                                                                *
0017009812090014 F*                                                                *
0018009812090010 F*  Y2K CONVERT - 1998                                            *
0019009812090015 F*                                                                *
002000990222     F* DMA 02.22.99  Fixed omission of self funded trusts             *
002100990809     F* DLK 08/09/99 - IF ACCT IS IN INVEXC FILE, ADD 1 TO COVER THRU  *
002200990810     F*                MONTH SO EFFDT OF SEARCH IS CORRECT             *
002300000202     F* DLK 02/01/00 - fix page numbering                              *
002400000427     F* TWP 03/02/00 - MOVED TAG #ENST TO BEFORE PHN ARRAY BUILD ROUTINE
002500000427     F* TWP 03/03/00 - on LR ROUTINE ADDED PRINT TOTQ2
002600000428     F* DLK 04/27/00 - Change payment/credit search to catch credit    *
002700000428     F*                transaction that occur after the invoice on     *
0028000004280012 F*                the same day                                    *
002900000710     F* DLK 07/10/00 - member & mcov term date will now be compared    *
0030000007100012 F*                to the withhold care date instead of just 0     *
0031000007100012 F*                for Withhold care report / letters.             *
0032000007130020 F* DLK 07/13/00 - Change CARBC to look for BC or PHN, not just    *
0033000007130020 F*                "not equal blank". This is needed because other *
0034000007130020 F*                carriers will be set up that are not BC or PHN. *
0035000007260020 F* DLK 07/26/00 - compare adjustment effdt and invoice effdt in   *
0036000007260012 F*                history search based on Year/Month only to      *
0037000007260012 F*                include prorated adjustments.                   *
003800001030     F* DMA 10.30.00   Removed check for MedChi trusts; use reg letter *
003900010627     F* DMA 06.27.01  Changed name from Carol F. Jane S.               *
004000011011     F* SSK 10.11.01  ADD EFFECTIVE DATE FOR LETTERS AND TRY TO REORGANIZE CODE?
0041000201280020 F* DLK 01/28/02 - Change the way date of cancellation (date the   *
0042000201280012 F*                account must have paid for) is selected. Now    *
0043000201280012 F*                the date entered on the screen will be used for *
0044000201280012 F*                all accounts (instead of covtdt - grace period).*
0045000201310012 F*                Also exclude non billable trusts (C).           *
0046000206270020 F* DLK 06/27/02 - Add RP170OUT to hold accts on report. This file *
0047000206270012 F*                will be used as the input file to rpf070        *
0048000206270012 F*                Urgent Letters.                                 *
0049000304020020 F* TWP 03/31/03 - ADDED EXTIND ON RP170P TO SUPPRESS LETTERS
0050000304020012 F*                CHANGED DIARY NOTE
005100030506      *?  TWP: 05.06.03 CHANGED QPRINT NEWMDY2 AND DL2 TO REFLECT NEXT
005200030506      *?                   MONTHS DATE NEWYMD2 AND DL3
005300030506      *?  TWP: 05.06.03 CHANGED OPERID TO USERID FOR HIST
0054000306250020  * szz 06/25/03 - Per Cindy W. generate a spreadsheet with the    *
0055000306250012  *                same fields as report; no longer want report.   *
0056000306250012  *                Include names for salesperson and AA.  Add      *
0057000306250012  *                three new fields to the spreadsheet:            *
0058000306250012  *                1) % of outstanding balance -vs- total due      *
005900030625      *                    which is the %premium paid                  *
0060000306250012  *                2) Date invoice entered in the system           *
0061000306250012  *                3) Previous invoice voided, Y or N              *
0062000307020012  *                4) Transaction amount (current amount)          *
0063000309120020  * DLK 09/12/03 - Add DBE payment calc and add field to           *
0064000309120012  *                spreadsheet to show DBE accounts since they     *
0065000309120012  *                are held to the DBE payment rules.              *
0066000309160015  * 09/16/03 dlk - "ADP" transactions will be considered a payment *
0067000309260015  * KSJ 09/26/03 - New W/C Letter formats for Clients/Subscribers  *
0068000309260012  *                Client and Subscriber letters can be printed    *
0069000309260012  *                separately                                      *
0070000402100015  * KSJ 02/10/04 - Added Indicator (*in26) to print member diary   *
0071000402100012  *                note on acct level. (Per Jane Summerfield)      *
0072000503220015  * JON 03/22/05 - Print BALDUE and AA name                        *
0073000508100020  * szz 08/10/05 - Per Cindy W. add Benegap field to spreadsheet   *
0074000704170015  * dlk 04/17/07 - update payment calc so all use same formula     *
0075000705020015  * dlk 05/02/07 - change payment % required from hard coded 100%  *
0076000705020012  *                to a variable % based on the largest % required *
0077000705020012  *                for all carriers in the account (using the remit*
0078000705020012  *                percent).                                       *
0079000705250012  *                                                                *
0080000705250015  *        ** Any changes to the remittance % required MUST MATCH  *
0081000705250015  *           the ABR programs (DW160, DW260) and RP174R **        *
0082000705250012  *                                                                *
0083000705110015  * dlk 05/11/07 - add initial invoice field to XLS                *
0084000706120015  *              - if sum of payments > 0 then add to total due    *
0085000706120015  *                and clear payment amount before calc pct paid   *
0086000706190015  *              - change to show ALL accts who paid < 100% with   *
0087000706190012  *                a new field on the xls to indicate who is pend  *
0088000706190012  *                cancel and who is not.                          *
008900090522      * dlk 05/22/09 - add a column to the XLS to show when subsidy    *
0090000905220012  *                members billed to the acct are included.        *
009100091014      * dlk 06/12/09 - add carbc = "S" same as "N"                     *
009200091016      * dlk 10/14/09 - add selection for senior dental only and add    *
0093000910160012  *                new fields                                      *
009400131010      * 10/10/13 sbt - hist file expansion project                     *
009500131112      * 11/11/13 dlk - remove credits from payment formula, add new
009600131112      *                fields to xls, remove benegap and subsidy columns
009700141222      * 12/22/14 dlk - add list of group's xls to this report (was in
0098001412220012  *                seperate program)
009900150114      * 01/14/15 dlk - add column to show debits after the invoice - Shelly
0100001501140012  *                request so they can see what a void inv would do
0101001501140012  *                to the amount due. Also, remove printed report, only
0102001501140012  *                CSV will be produced.
010300150116      * 01/16/15 dlk - add aa name to group # report - Debora Clark request
010400150128      * 01/28/15 dlk - remove resorted print report (RP170WK), Okay by
010500150128      *                Cindy W and Carol F.
010600150202      * 01/30/15 dlk - change DBE payment threshold from 80% to 90% per
0107001502090012  *                Liliane
010800150209      * 02/09/15 dlk - second paid % column will now contain payments +
0109001502090012  *                credits + debits. Also add exchange column and
0110001502090012  *                relable sman heading to BOR. also add servicing
0111001502090012  *                broker column.
011200150216      * 02/16/15 dlk - remove hard coded dbe payment required percent
011300150306      * 03/06/15 dlk - new withhold care letter for acct. Also, remove
011400150306      *                member withhold care letter - per Cindy
011500150520      * 05/20/15 dlk - convert to use GETPAID
011600160222      * 02/22/16 dlk - convert to use GETPAIDCL instead which has the file
0117001602220012  *                overrides in it.
011800160418      * 04/18/16 dlk - add blank remit date parm to getpaidcl
011900180111      * 01/11/18 jt  - added changes for Advanced Mobil
012000190213      * 02/07/19 dlk - add PSF/BSF column to xls. Also remove exchange
0121001902130012  *                column
012200190906      * 09/06/2019  B.Rees   Added AutoDebit to XLS
012300190906      *  Mod id: BR01
012400191127      * 11/27/19 dlk - add check for gbs begin admin date
012500200120      * 01/20/20 jt  - added code for CSM
012600200428      * 04/28/20 dlk - add check for CF payment defer
012700210420      * 04/20/21 dlk - put subsidy column back
0128002208050015  * jva 08.03.22 - Print exculdes only on second run - X001
0129001911270012  *
0130001911270012  *
0131001911270012  *                page segment for withhold care letter:
0132001911270012  * I:\MIS\AS400PageSegments\GBS letters\Withhold care letters - RP170\
0133002105030012  * 5-3-21 letter\wcacct.prn
0134001911270012  *                                                                *
0135009102120012 F******************************************************************
0136009812090013 FACCMST    IP   F  560        DISK
0137009812090016 FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
0138001509210017 FHISTak    o  a F  216        DISK
013900030625     FHISTL4    IF   E           K DISK
014000030703     FHISTL5    IF   E           K DISK    Prefix(L5) Rename(HISTR:HISTR5)
0141009805290016 FWCLET     IF   F   32     3AIDISK    KEYLOC(1)
0142009805290016 FWCEXCL    IF   F   10    10AIDISK    KEYLOC(1)
0143001509210016 FINVSUM    IF   E           K DISK
0144009812030016 FPLNMST    IF   E           K DISK
0145009812030016 FCARMST    IF   E           K DISK
0146009812090014 FMEMAC#    IF   F  648    10AIDISK    KEYLOC(136)
0147009812090016 FMCOV      IF   F   88     9AIDISK    KEYLOC(1)
0148001412220016 FMCOVx     IF   e           k DISK    prefix(x_)
0149000206270021 FGRATE     IF   F   80    15AIDISK    KEYLOC(1)
015000030625     FSMAN      IF   E           K DISK
015100030625     FAACODE    IF   E           K DISK
015200091015     Fodcntcp   IF   E           K Disk
015300091019     Fsubmst    IF   E           K Disk
015400141217     Fcmct14    IF   E           K Disk
0155001412290017 Frp17gwk   uf a e           k DISK
015600141229     Fgratex    if   e           k Disk    prefix(gx_) rename(grater:gratexr)
015700150209     Fac2mstl2  if   e           k disk
015800150211     fsmanrlt   if   e           k disk
015900150211     fagency    if   e           k disk
016000150211     fspragxr2  if   e           k disk
016100190906br01 fsecach    if   e           k disk
016200200428br01 fpaydfrcpl1if   e           k disk
0163000206270021 Frp170out  o  a e             DISK
016400030630     FRP170CSV  O  A E             DISK
0165001412290021 Frp17gxl   o  a e             disk
0166000309120027 FRP170PA   O    E             PRINTER EXTIND(*INU2)
0167000910230018 Frp170pe   O    F  132        PRINTER OFLIND(*INOE)
0168001412220020 D GAR             S             15    DIM(8)
0169000311100020 D GAR2            S             15    DIM(8)
0170009102120021 D YR              S              9    DIM(12) CTDATA PERRCD(1)
017100020627     D rpgdate         S               d
017200020627     D rpgtime         S               t
017300030506     D NEWMDY2         S              8  0 INZ(*ZEROS)
017400030925     D NEWYMD2         S              8  0 INZ(*ZEROS)
017500030506     D USA_DATE        S               D   DATFMT(*USA)
0176001311110056 DpaypctWOcred     s             13  4
0177001311110056 DpaypctWOcredo    s             13  2
0178001502090056 DpaypctWcrdb      s             13  4
0179001502090056 DpaypctWcrdbo     s             13  2
0180001311110056 Dcredpct          s             13  4
0181001311110056 Dcredpctout       s             13  2
0182001502090056 Dtot_pcd          s             10  2
0183000705110056 Dinitinv          s              1
0184000705020056 Dpaypctreq        s                   like(cthresh)
0185000705020056 Dwkpct            s                   like(cthresh)
0186000705020056 Dholdpct          s                   like(cthresh)
0187001505200056 Dholdcarrier      s                   like(pcarr)
018800030916     DWORD1            C                   CONST('remains')
018900030916     DWORD4            C                   CONST('if payment has not')
0190000402110056 DNEWAA            S              3
0191000402260056 DHSTKEY           S             10
0192002211040056 DHNOTE            S             30
0193002211040056 DHNOTE2           S             30
019400040226     DNOTEA            C                   CONST('CLIENT NOTICE OF POTENTIAL W/-
019500040810     D                                     C')
019600220809     DNOTEM            C                   CONST('NOTICE OF W/C TO MBR/CFS/PHN')
019700221104     DNOTEX            C                   CONST('LATE PAYER')
019800221104     DNOTEX2           C                   CONST('PRINTED **')
0199000402260056 DFIRSTAAM         S              1
0200000402260056 DFIRSTAAA         S              1
020100091015     D wkasphfl        S                   LIKE(asphfl)
020200091015     D wkacnam2        S                   LIKE(acnam2)
020300091015     D wkaphone        S             13
020400091015     D wkfaccontac     S             50
020500091015     D wkfacphon       S             13
020600091019     D wkfacname       S                   like(subnam)
020700091015     D bom             S              3    inz('BOM')
020800091015     D zero4           S              4s 0 inz
020900131010     D zero7           S              7s 0 inz
021000131119     D zero8           S              8s 0 inz
021100131010     D hstrtime        S              8t
021200131025     D thispgmname     S             10a   inz('RP170     ')
0213001412290125 Dcsv              c                   const('","')
0214001502110056 Dholdagcode       S                   like(sxagcy)
0215001502110056 Dgt1agency        S              1
021600141222
0217001412290055 D                 DS
0218001412290056 D  g7tsa                  1     10  0
0219001412290056 D  G7TRUST                1      3  0
0220001412290056 D  G7SUB                  4      6  0
0221001412290056 D  G7ACC                  7     10  0
022200141229
022300141222      * group #'s from RP17Gwk
0224001412220055 D                 DS
0225001501020056 D  g7ar                   1    450
022600150102     D                                     DIM(30)
0227001412220056 D  g7g#1                  1     15
0228001412220056 D  g7g#2                 16     30
0229001412220056 D  g7g#3                 31     45
0230001412220056 D  g7g#4                 46     60
0231001412220056 D  g7g#5                 61     75
0232001412220056 D  g7g#6                 76     90
0233001412220056 D  g7g#7                 91    105
0234001412290056 D  g7g#8                106    120
0235001412220056 D  g7g#9                121    135
0236001412220056 D  g7g#10               136    150
0237001412220056 D  g7g#11               151    165
0238001412220056 D  g7g#12               166    180
0239001412220056 D  g7g#13               181    195
0240001412220056 D  g7g#14               196    210
0241001412220056 D  g7g#15               211    225
0242001501020056 D  g7g#16               226    240
0243001501020056 D  g7g#17               241    255
0244001501020056 D  g7g#18               256    270
0245001501020056 D  g7g#19               271    285
0246001501020056 D  g7g#20               286    300
0247001501020056 D  g7g#21               301    315
0248001501020056 D  g7g#22               316    330
0249001501020056 D  g7g#23               331    345
0250001501020056 D  g7g#24               346    360
0251001501020056 D  g7g#25               361    375
0252001501020056 D  g7g#26               376    390
0253001501020056 D  g7g#27               391    405
0254001501020056 D  g7g#28               406    420
0255001501020056 D  g7g#29               421    435
0256001501020056 D  g7g#30               436    450
0257000201280050 D                 DS
0258000201280051 D  NEWMDY                 1      8  0
0259000201280052 D  M                      1      2  0
0260000201280053 D  D                      3      4  0
0261000201280054 D  Y                      5      8  0
0262001911270050 D                 DS
0263001911270051 D  gbsbdt                 1      8  0
0264001911270052 D  gbsbdtym               1      6  0
0265001911270050 D                 DS
0266001911270051 D  enroll                 1      8  0
0267001911270052 D  enrollym               1      6  0
0268000910150050 D                 DS
0269000910150051 D  ocphn1                 1     10
0270000910150052 D  ocphn1a                1      3
0271000910150053 D  ocphn1b                4      6
0272000910150054 D  ocphn1c                7     10
0273000910150050 D                 DS
0274000910150051 D  workaphone             1     10  0
0275000910150052 D  aarea                  1      3  0
0276000910150053 D  aphone                 4     10  0
0277009102120055 D                UDS
0278009102120056 D  LTRUST                 1      3
0279009503130056 D  LSORT                  4      4
0280000308280056 D  LLETA                  5      5
0281001310140094 D  USERID                10     19
028200011011     D  MO##                  30     31S 0
028300011011     D  DD##                  32     33A
028400011011     D  YY##                  34     37A
028500020128     D  lmdy                  38     45  0
028600020128     D  lm                    38     39  0
028700030910     D  lmc                   38     39
028800020128     D  lychar                42     45
028900020627     D  lsave                 46     46
029000091014     D  ldonly                47     47
0291009102120057 D  CONAME               201    240
029200020627
029300190906br01    Dcl-s Count Zoned(3);
029400190906br01    Dcl-s Today Zoned(8);
029500190906
029600190906
029700190906
029800190906
029900011025     D #ISO            S               D   DATFMT(*ISO)
030000011025     D #USA            S               D   DATFMT(*USA)
0301009102120023 IACCMST    NS  01
0302009102120024 I*  ACCOUNT MASTER FILE
0303009102120025 I                                  1   10 0KEYACC
0304009102120026 I                                  1    3 0TRUST#
0305009805290026 I                                  4    6 0SUB#
0306009805290026 I                                  7   10 0ACC#
0307009102120027 I                                  1    6 0KEYSUB
0308009102120028 I                                 11   50  ACNAM1
0309000910150028 I                                 51   90  ACNAM2
0310009805290028 I                                 11   45  ACNM35
0311009702260045 I                                 91  120  AADDR1
0312009702260046 I                                121  150  AADDR2                  41
0313009702260047 I                                151  165  ACITY
0314009702260048 I                                166  167  ASTATE
0315009702260049 I                             P  168  172 0AZIP
0316000910150049 I                             P  173  174 0Aarea
0317000910150049 I                             P  175  178 0Aphone
0318009201170029 I                             P  210  213 0NOEMPL
031900070511     I                                222  229 0GBSBDT
0320000910150050 I                                247  247  asphfl
0321000910150050 I                                425  454  ECNTAC
0322000306300034 I                                480  482  A_AACODE
0323009503100034 I                                483  485  SMANCD
032400150128     I                                513  520 0acvtdt
0325009812090036 I                                545  552 0ENROLL
0326009102120039 ITRSMST    NS
0327009102120040 I*  TRUST MASTER FILE
0328009102120041 I                                255  255  TSCODE
0329000201310041 I                                256  256  trdltd
0330000007260042 IWCLET     NS
0331009704010042 IWCEXCL    NS
0332009702200040 IMEMAC#    NS
0333009702200041 I*  MEMBER FILE
0334009702200042 I                                  1    9 0SSNO
0335009702200043 I                                 10   27  LNAME
0336009702200044 I                                 28   39  FNAME
0337009702200045 I                                 40   40  MI
0338009702200046 I                                 41   70  ADDR1
0339009702200047 I                                 71  100  ADDR2                   41
0340009702200048 I                                101  115  CITY
0341009702200049 I                                116  117  STATE
0342009702200050 I                             P  118  122 0ZIP
0343000309150053 I                                561  568 0mbenrl
0344009812090053 I                                577  584 0TERMDT
0345000905220053 I                                625  632 0cexpdt
0346009702270058 IGRATE     NS
0347009702270060 I                                  1   15  GRTKEY
0348009702270059 I                                 24   38  GROUP#
0349009812090062 I                                 65   72 0FRCYMD
0350009812090063 I                                 73   80 0TOCYMD
0351009702270042 IMCOV      NS
0352009812030079 I                                 12   14 0MCTRST
0353009812030079 I                                 15   17 0MCSUB
0354009812090079 I                                 18   21  MCPLAN
0355009812030079 I                                 12   26  RATKEY
0356000309150045 I                                 65   72 0enrldt
0357000309150045 I                                 73   80 0CANDT
0358009102120059 I/EJECT
0359009102120085 C*
0360000201310086 C* SKIP non billable trusts (dltcd = C) and deleted trusts
0361000910140086 C* and senior dental trusts
0362009102120087 C*
0363009806020088 C     TRUST#        CHAIN     TRSMST                             21
0364009806020096 C     *IN21         IFEQ      *ON
036500980602     C     FIRSTE        IFEQ      ' '
036600980602     C                   EXCEPT    HEADE
036700980602     C                   MOVE      'N'           FIRSTE            1
036800980602     C                   END
036900980603     C                   EXCEPT    LINEE
037000000201     C   OE              EXCEPT    HEADE
0371009806020096 C                   GOTO      #END
037200980602     C                   END
037300980602     C*
0374000201310089 C                   if        tscode = ' ' or trdltd = 'C' or
037500091014     c                             trdltd = 'D'
0376009411160090 C                   GOTO      #END
0377009411160091 C                   END
037800091014
0379002001100092  * select dental only, Advanced Mobil, CMS or all other
038000180111     c****               if        (ldonly = 'D' and tscode <> 'N') or
038100180111     c****                         (ldonly <> 'D' and tscode = 'N')
0382001801110090 C****               GOTO      #END
0383001801110091 C****               END
038400180111
038500180111     c                   if        (ldonly = 'D' and tscode = 'N') or
038600180111     c                             (ldonly = 'A' and tscode = 'M') or
038700200110     c                             (ldonly = 'C' and tscode = 'D') or
038800190207     c                             (ldonly = 'O' and (tscode <> 'N' and
038900190207     c                              tscode <> 'M'))
0390001801110090 C                   GOTO      #stay
039100180111     c                   else
0392001801110090 C                   GOTO      #END
0393001801110091 C                   endif
039400091014
039500180111     c     #stay         tag
0396009908090107 C*
0397000201280109 C* "NEWMDY" will now be filled with the date entered on the screen.
0398000201280109 C*
0399000201280113 C                   MOVE      lmdy          newmdy
040000030506     C                   MOVEL     NEWMDY        USA_DATE
040100030506     C                   ADDDUR    1:*M          USA_DATE
040200030506     C                   MOVEL     USA_DATE      NEWMDY2
0403009908090109 C*
0404009102120116 C* CHECK ACCOUNT TO SEE IF THEY HAVE BEEN ENROLLED LONG ENOUGH
0405009102120117 C* IF NOT - SKIP
0406009102120118 C*
0407009812090111 C*
040800981209     C                   MOVE      NEWMDY        @DATIN
040900981209     C                   EXSR      #DATMY
041000981209     C                   MOVE      @DATOU        NEWYMD            8 0
041100191127     C                   MOVEl     @DATOU        NEWym             6 0
041200191127
0413001911270111 C* if enroll date or gbs begin admin date is after the report date
0414001911270111 C* then skip (year/month only compare to catch mid month dates)
041500191127     c                   if        enrollym > newym or gbsbdtym > newym
0416009102120123 C                   GOTO      #END
0417009102120124 C                   END
0418000110250121 C*
041900011025     C                   MOVE      NEWYMD        #ISO
042000011025     C                   ADDDUR    1:*M          #ISO
042100011025     C                   MOVE      #ISO          #USA
042200030506     C                   MOVE      #ISO          NEWYMD2
0423000309120151
0424001509210142  * find out if acct has dbe business and carrier code for highest
0425001509210142  * threshold % that will be used in getpaid
042600070417     c                   exsr      #fnddbe
042700150520
0428001509220142  * if no active plans were found to use the carrier for the payment
0429001509220142  * percent required, use special override code of <a> for 100%
043000150921     c                   if        holdcarrier = *blanks
043100150922     c                   eval      holdcarrier = '<a>'
043200150921     C                   end
043300150921
043400150921      * 5/20/15 - convert to use GETPAID instead of internal payment logic.
043500150921      *           It will only be used for gathering the payments, credits
043600150921      *           debits and invoice ending balance...the yes/no decision
043700150921      *           will not be used here since admin wants to use
043800150921      *           different fields in their decision
043900150918     c                   exsr      #getpaid
044000150520
044100150921      * any error from payment pgm - skip remainning calcs
044200150921     c                   if        parmerr <> *blanks
044300150921     c                   goto      #end
044400150921     c                   end
044500150520
0446000706140125 C* credit ending balance...nothing due
0447000706140096 C                   if        totinv <= 0
044800070614     c                   goto      #end
044900070614     C                   end
045000150921
045100150921      * balance = inv + payments only (no credits)
045200150921     C     TOTINV        ADD       MONPAY        OUTBAL            9 2
045300150921
045400131112      * payments without credits
045500131111     c                   z-add     monpay        payWOcrd         10 2
045600131111
045700131111      * calc paid percent w/o credits
045800131111     c                   clear                   abspayWOcrd      10 2
045900131111     c                   eval      abspayWOcrd = %abs(payWOcrd)
046000131111     c     abspayWOcrd   div       totinv        paypctWOcred
046100131111     c                   mult      100           paypctWOcred
046200131111     c                   z-add     paypctWOcred  paypctWOcredo
046300131112
046400131112
046500150209      * total payments + credits + debits for seperate display
046600150209     c                   eval      tot_pcd = monpay + credit + debit
046700131112
046800150209      * calc paid percent with credits and debits but if debits exceed
046900150209      * credits then skip the calc because the payment % would be zero
047000150209     c                   clear                   abstot_pcd       10 2
047100150209     c                   clear                   paypctWcrdbo
047200150209     c                   clear                   paypctWcrdb
047300150209     c                   if        tot_pcd < 0
047400150209     c                   eval      abstot_pcd  = %abs(tot_pcd)
047500150209     c     abstot_pcd    div       totinv        paypctWcrdb
047600150209     c                   mult      100           paypctWcrdb
047700150209     c                   z-add     paypctWcrdb   paypctWcrdbo
047800150209     c                   end
047900131111
048000131111      * calc credit percent
048100131111     c                   clear                   abscred          10 2
048200131111     c                   eval      abscred = %abs(credit)
048300131111     c     abscred       div       totinv        credpct
048400131111     c                   mult      100           credpct
048500131111     c                   z-add     credpct       credpctout
048600070615
048700070615      * if paid enough, not subject to cancellation but we still want to
048800070615      * show them on the spreadsheet if they paid < 100%
0489001311110152 C                   if        paypctWOcred >= paypctreq
049000070618     c                   move      'NO '         pendcancel        3
049100070615     c                   else
049200070618     c                   move      'YES'         pendcancel
049300030912     c                   end
049400091015
049500091015      * senior dental fields
049600091015     c                   clear                   wkacnam2
049700091015     c                   clear                   wkaphone
049800091015     c                   clear                   wkasphfl
049900091015     c                   move      acnam2        wkacnam2
050000091015     c                   eval      wkaphone = %editw(workaphone:'0   -   -    ')
050100091015     c                   move      asphfl        wkasphfl
050200091019      * get facility contact if the acct is a facility acct and the report
050300180111      * is run for senior dental and Advanced Mobil...
050400091015     c                   clear                   wkfaccontac
050500091015     c                   clear                   wkfacphon
050600091019     c                   clear                   wkfacname
050700180111     c                   if        (ldonly = 'D' and asphfl = 'F')
050800200110     c                             or (ldonly = 'A' and asphfl = 'F')
050900200110     c                             or (ldonly = 'C' and asphfl = 'F')
051000091019      * get facility name
051100091019     c     subkey        chain     submst
051200091019     c                   if        %found(submst)
051300091019     c                   movel     subnam        wkfacname
051400091019     c                   end
051500091019
051600091015     c     odkey         setll     odcntcp
051700091015     c                   dou       %eof(odcntcp)
051800091015     c     odkey         reade     odcntcp
051900091015     c                   if        not %eof(odcntcp) and newymd >= oceff and
052000091015     c                             (octrm = 0 or octrm > newymd)
052100091015     c     ocfnam        cat       oclnam:1      wkfaccontac
052200091015     c                   eval      wkfacphon = ocphn1a + '-' + ocphn1b + '-' +
052300091015     c                                         ocphn1c
052400091015     c                   cat       wkfacphon:1   wkfaccontac
052500091015     c                   leave
052600091015     c                   end
052700091015     c                   enddo
052800091015     c                   end
052900150128
053000150128     C                   MOVE      acvtdt        @DATIN
053100150128     C                   EXSR      #DATMY
053200150128     C                   MOVE      @DATOU        acvtdtmdy         8 0
053300150114
053400150114      * write spreadsheet if paypct < 100%
053500150114     c                   if        paypctWOcred < 100
053600150114     C                   Exsr      WriteSpread
053700150114     c                   end
053800070615
053900070615      * skip all remaining calcs if this acct is not pending cancel
054000070618     c                   if        pendcancel = 'NO '
054100070615     c                   goto      #end
054200070615     c                   end
0543009102120158 C*
0544000206270158 C* add this acct to RP170OUT if lsave = Y
0545000206270158 C*
054600020627     c                   if        lsave = 'Y'
054700020627     c                   move      trust#        rptrust
054800020627     c                   move      sub#          rpsub
054900020627     c                   move      acc#          rpacc
055000020627     c                   move      smancd        rpsman
055100030630     c                   move      A_aacode      rpaa
055200020627     c                   move      rpgdate       rptrdate
055300020627     c                   move      rpgtime       rptrtime
055400020627     c                   write     rpr
055500020627     c                   end
055600020627
055700141222      * find all active group #'s for report
055800141222     c                   exsr      #group#
055900141222
0560009102120164 C*
0561009702270164 C* IF SELECTED AND TRUST# IS IN FILE TO PRINT THE WITHHOLD CARE
0562009704010164 C* LETTERS (WCLET) THEN DO #LTR ROUTINE
0563009702270164 C*
0564009704010164 C* ALSO - CHECK WCEXCL FILE... THIS HOLDS ACCTS TO EXCLUDE (DO NOT
0565009704010164 C* PRINT LETTER) THESE ACCTS ARE SPECIAL EXCEPTIONS EACH MONTH
0566009704010164 C* THEY CAN ENTER INTO THIS FILE THEN IT IS CLEARED WHEN THIS
0567009704010164 C* PROGRAM IS COMPLETE
0568009704010164 C*
056900220805     C     LLETA         IFEQ      'Y'
057000220805X001 C     EXCLUDE       ANDEQ     ' '
057100970227     C     TRUST#        CHAIN     WCLET                              52
057200970401     C  N52KEYACC        CHAIN     WCEXCL                             53
057300970401     C  N52
057400970401     CAN 53              EXSR      #LTR
057500970219     C                   END
0576002208050164 C*
057700220805X001 C     LLETA         IFEQ      'Y'
057800220805 |   C     EXCLUDE       ANDEQ     'Y'
057900220805 |   C     TRUST#        CHAIN     WCLET                              52
058000220805 |   C  N52KEYACC        CHAIN     WCEXCL                             53
058100220805 |   C  N52
058200220805 |   CANN53              EXSR      #LTR
058300220805X001 C                   END
058400970219     C*
0585000311180165 C     #END          TAG
058600970228     C*
058700970228     C* IF LETTERS PRINTED... PRINT TOTAL
058800970228     C*
058900141229      * create group # csv file for email back to user
059000141229     CLR                 exsr      #crtg#csv
059100141222
0592001509180103 C*******************************************************************
0593001509180104 C* call getpaid to get payment status for this acct/effdt/carrier *
0594001509180103 C*******************************************************************
059500150918     c     #getpaid      begsr
059600150918
0597001509220128 C                   clear                   MONPAY           10 2
0598001509220128 C                   clear                   CREDIT           10 2
0599001509220128 C                   clear                   debit            10 2
0600001509220128 C                   clear                   totinv            9 2
0601001509220128 C                   clear                   paymnt            1
060200150922
060300150918     c     grplist       plist
060400150918     c                   parm                    parmkey          10
060500160418     c                   parm                    parmremymd        8
060600150918     c                   parm                    parmeffymd        8
060700150918     c                   parm                    parmcar           3
060800150918     c                   parm                    parmupdate        1
060900150918     c                   parm                    parmpaid          1
061000150918     c                   parm                    parmerr          35
061100150918     c                   parm                    parminveb        10 2
061200150918     c                   parm                    parmpayments     10 2
061300150918     c                   parm                    parmcredits      10 2
061400150918     c                   parm                    parmdebits       10 2
061500150918
061600150918     c                   movel     keyacc        parmkey
061700160418     c                   move      *blanks       parmremymd
061800160418     c                   move      newymd        parmeffymd
061900150918     c                   move      holdcarrier   parmcar
062000150918     c                   move      'N'           parmupdate
062100150918     c                   clear                   parmpaid
062200150918     c                   clear                   parmerr
062300150918     c                   clear                   parminveb
062400150918     c                   clear                   parmpayments
062500150918     c                   clear                   parmcredits
062600150918     c                   clear                   parmdebits
062700150918
062800160222     c                   call      'GETPAIDCL'   grplist
062900150918
063000150918      * if any error returned, print it
0631001509180361 C                   if        parmerr <> *blanks
063200150918     C                   if        firste = ' '
063300150918     C                   EXCEPT    HEADE
063400150918     C                   MOVE      'N'           FIRSTE
063500150918     C                   END
063600150918     C   oe              EXCEPT    heade
063700150921      * set on 63 to show the error
063800150918     c                   eval      *in63 = *on
063900150918     C                   EXCEPT    linee
064000150918     c                   eval      *in63 = *off
064100150922     c                   leavesr
064200150918     C                   END
064300150918
064400150921      * the actual Y/N payment decision returned will not be used in this
064500150921      * program since Admin wants to make the decision based on other values
064600150923      * but it will be stored in the "paymnt" field in case it is needed
064700150921      * later
064800150922     c                   move      parmpaid      paymnt
064900150922
065000150922      * move values from get paid to those needed by this program
065100150922     c                   z-add     parminveb     totinv
0652001509220137 c                   z-add     parmcredits   credit
0653001509220137 c                   z-add     parmdebits    debit
0654001509220137 c                   z-add     parmpayments  monpay
065500150921
065600150918     c                   endsr
065700150918
0658001902070103 C*******************************************************************
0659001902070104 C* call getpsf to see if this acct is subject to the PSF
0660001902070103 C*******************************************************************
066100190207     c     #getpsf       begsr
066200190207     c                   movel     keyacc        parmpsftsa
066300190207     c                   move      newymd        parmpsfeff
066400190213     c                   clear                   parmpsfelig
066500190213     c                   clear                   parmpsftype
066600190213     c                   clear                   psfout            1
066700190207
066800190207     c                   call      'GETPSFCL'
066900190207     c                   parm                    parmpsftsa       10
067000190207     c                   parm                    parmpsfeff        8
067100190213     c                   parm                    parmpsfelig       1
067200190213     c                   parm                    parmpsftype       1
067300190207
067400190213      * only show type if eligible (it would be invalid for a psf/bsf fee
067500190213      * to be set up if the acct is not eligible)
067600190213     c                   if        parmpsfelig = 'Y'
067700190213     c                   move      parmpsftype   psfout
067800190207     c                   end
067900190207
068000190207     c                   endsr
068100190207
0682002004280103 C*******************************************************************
0683002004280104 C* see if this acct has deferred the care first payment this month
0684002004280103 C*******************************************************************
068500200428     c     #getdfr       begsr
068600200428     c                   clear                   cfpaydfr          1
068700200428
068800200428     c     tsakey        setll     paydfrcpl1
068900200428     c                   dou       %eof(paydfrcpl1)
069000200428     c     tsakey        reade     paydfrcpl1
069100200428     c                   if        not %eof(paydfrcpl1) and
069200200428     c                             (newymd >= PFFRMDT) and
069300200428     c                             (newymd <= PFTODT)
069400200428     c                   eval      cfpaydfr = 'Y'
069500200428     c                   leave
069600200428     c                   end
069700200428     c                   enddo
069800200428
069900200428     c                   endsr
070000200428
0701000306300164 C*************************************************************
0702001412220164 C* find all active group #'s and write to output file for    *
0703001412220164 C* spreadsheet delivery back to user                         *
0704000306300164 C*************************************************************
070500141222     C     #group#       BEGSR
070600141222
070700141222      * read all active mcov
070800141229     c     tsakey        setll     mcovx
070900141229     c                   dou       %eof(mcovx)
071000141229     c     tsakey        reade     mcovx
071100141222     c                   if        not %eof(mcovx) and x_candt = 0
071200141222
071300141222      * get plnmst for carrier code
071400141222     c     xtspkey       chain     plnmst
071500141222     c                   if        %found(plnmst)
071600141222      * find group #
071700141229     c     xtspackey     setll     gratex
071800141229     c                   dou       %eof(gratex)
071900141229     c     xtspackey     reade     gratex
072000141229     c                   if        not %eof(gratex) and
072100141229     c                             (newymd >= gx_frmdat and
072200141229     c                              newymd <= gx_todat)
072300141222
072400141222      * if this t/s/a/carr is not already in the file then add it
072500141222     c     xtsacarkey    chain     rp17gwk
072600141222     c                   if        not %found(rp17gwk)
072700141222     c     pcarr         chain     carmst
072800141222     c                   if        %found(carmst)
072900141222     c                   clear                   rp17gwkr
073000141222     c                   move      trust#        G7TRUST
073100141222     c                   move      sub#          G7SUB
073200141222     c                   move      acc#          G7ACC
073300141222     c                   move      pcarr         G7CARR
073400141222     c                   movel     acnam1        g7acnam
073500141222     c                   movel     cname         g7cname
073600150116     c                   clear                   g7aalname
073700150116     c                   clear                   g7aafname
073800150309     c                   clear                   aadialc
073900150116     C     A_AACODE      CHAIN     AACODR
074000150116     C                   If        %Found(AACODE)
074100150309     C                   EVAL      AADIALC = %EDITW(ADDIAL:'   -   -    ')
074200150116     C                   movel     ALNAM         g7aalname
074300150116     C                   movel     AFNAM         g7aaFname
074400150116     c                   end
074500141222     c                   exsr      #checkg#
074600190906
074700190906br01                     exsr AutoDebit;
074800190906
074900190906     C
075000141222     c                   write     rp17gwkr
075100141222     c                   end
075200141229
075300141222      * this t/s/a/carrier was already in file, just add group # if it
075400141222      * does not already exist
075500141229     c                   else
075600141222     c                   exsr      #checkg#
075700141222     c                   if        g#added = 'Y'
075800141222     c                   update    rp17gwkr
075900141222     c                   end
076000141222     c                   end
076100141222
076200141222     c                   end
076300141222
076400141222     c                   enddo
076500141222
076600141222     c                   end
076700141222     c                   end
076800141222     c                   enddo
076900141222
077000141222     c                   endsr
077100141222
0772001412220164 C*************************************************************
0773001412220164 C* If this group # is not in file, add it                    *
0774001412220164 C*************************************************************
077500141222     C     #checkg#      BEGSR
077600141222
077700141222     c                   clear                   g#added           1
077800141222
077900150309     C                   Z-ADD     1             X                 2 0
078000141222
078100141229      * check each array value to see if this group# has already been
078200141229      * stored
078300150102     C                   dou       x > 30
078400141229      * if this arrary value is blank, add the group # and leave
078500141222     c                   if        g7ar(x) = *blanks
078600141229     C                   MOVEL     gx_GROUP#     G7AR(X)
078700141222     c                   eval      g#added = 'Y'
078800141222     C                   leave
078900141222     C                   ELSE
079000141229      * non blank value
079100141229      * group # is already there, leave
079200141229     c                   if        g7ar(x) = gx_group#
079300141222     C                   leave
079400141222     C                   ELSE
079500141229      * its not there, check next element of array
079600141229     C                   ADD       1             X
079700141222     C                   end
079800141229
079900141222     C                   end
080000141222     C                   enddo
080100141222
080200141222     c                   endsr
080300141229
0804001412290164 C*************************************************************
0805001412290164 C* greate group # csv file
0806001412290164 C*************************************************************
080700141229     C     #crtg#csv     BEGSR
080800141229
080900141229      * write headings
081000141229     c                   exsr      #writeg#xlhead
081100141229
081200141229      * read all records in workfile
081300141229     c     *loval        setll     rp17gwk
081400141229     c                   dou       %eof(rp17gwk)
081500141229     c                   read      rp17gwk
081600141229     c                   if        not %eof(rp17gwk)
081700141229     c                   exsr      #writeg#xldet
081800141229     c                   end
081900141229     c                   enddo
082000141229
082100141229     c                   endsr
082200141229
0823002104200164 C*************************************************************
0824002104200164 C* look for cobra subsidy plans                              *
0825002104200164 C*************************************************************
082600210420     C     #getsubsidy   BEGSR
082700210420
082800210420     c                   clear                   submem_o          1
082900210420      * read all active mcov
083000210420     c     tsakey        setll     mcovx
083100210420     c                   dou       %eof(mcovx)
083200210420     c     tsakey        reade     mcovx
083300210420     c                   if        not %eof(mcovx) and x_candt = 0
083400210420
083500210420      * get plnmst for subsidy field
083600210420     c     xtspkey       chain     plnmst
083700210420     c                   if        %found(plnmst) and sfadm = 'Y'
083800210420     c                   eval      submem_o = 'Y'
083900210420     c                   leave
084000210420     c                   end
084100210420
084200210420     c                   end
084300210420     c                   enddo
084400141229
084500210420     C                   endsr
084600141229     C*************************************************************
084700141229     C* Write group list XLS heading
084800141229     C*************************************************************
084900141229     C     #Writeg#xlheadBEGSR
085000141229
085100141229     c                   clear                   rp17gxlfld
085200141229     C                   Eval      rp17gxlfld  =                         '"' +
085300141229     C                                           'ACCOUNT #'           + csv +
085400141229     C                                           'ACCOUNT NAME'        + csv +
085500150116     C                                           'AA LAST'             + csv +
085600150116     C                                           'AA FIRST'            + csv +
085700141229     C                                           'CARRIER NAME'        + csv +
085800141229     C                                           'GROUP #1'            + csv +
085900141229     C                                           'GROUP #2'            + csv +
086000141229     C                                           'GROUP #3'            + csv +
086100141229     C                                           'GROUP #4'            + csv +
086200141229     C                                           'GROUP #5'            + csv +
086300141229     C                                           'GROUP #6'            + csv +
086400141229     C                                           'GROUP #7'            + csv +
086500141229     C                                           'GROUP #8'            + csv +
086600141229     C                                           'GROUP #9'            + csv +
086700141229     C                                           'GROUP #10'           + csv +
086800141229     C                                           'GROUP #11'           + csv +
086900141229     C                                           'GROUP #12'           + csv +
087000141229     C                                           'GROUP #13'           + csv +
087100141229     C                                           'GROUP #14'           + csv +
087200141229     C                                           'GROUP #15'           + csv +
087300190909br01 C                                           'AUTO DEBIT'          + csv +
087400141229     C                                           ' '                   + '",'
087500141229     C                   Write     rp17gxlr
087600141229
0877001412290320 C                   ENDSR
0878001412290164 C*************************************************************
0879001412290164 C* Write group # xls Detail
0880001412290164 C*************************************************************
088100141229     C     #Writeg#xldet BEGSR
088200141229
088300141229     c                   clear                   rp17gxlfld
088400141229     C                   Eval      rp17gxlfld  =                          '"' +
088500141229     C                             %trim(%editw(g7tsa:'0   -   -    ')) + csv +
088600141229     C                             %trim(g7acnam)                       + csv +
088700150116     C                             %trim(g7aalname)                     + csv +
088800150116     C                             %trim(g7aafname)                     + csv +
088900141229     C                             %trim(g7cname)                       + csv +
089000141229     C                             %trim(g7g#1)                         + csv +
089100141229     C                             %trim(g7g#2)                         + csv +
089200141229     C                             %trim(g7g#3)                         + csv +
089300141229     C                             %trim(g7g#4)                         + csv +
089400141229     C                             %trim(g7g#5)                         + csv +
089500141229     C                             %trim(g7g#6)                         + csv +
089600141229     C                             %trim(g7g#7)                         + csv +
089700141229     C                             %trim(g7g#8)                         + csv +
089800141229     C                             %trim(g7g#9)                         + csv +
089900141229     C                             %trim(g7g#10)                        + csv +
090000141229     C                             %trim(g7g#11)                        + csv +
090100141229     C                             %trim(g7g#12)                        + csv +
090200141229     C                             %trim(g7g#13)                        + csv +
090300141229     C                             %trim(g7g#14)                        + csv +
090400141229     C                             %trim(g7g#15)                        + csv +
090500190909br01 C                             %trim(G7AutoDbt)                     + csv +
090600141229     C                             ' '                                  + '",'
090700141229     C*
090800141229     C                   Write     rp17gxlr
090900141229
091000150102      * if more than 15 group #'s, write another line. The CSV file would
091100150102      * be too large with 30 group #'s on one line.
091200150102     c                   if        g7g#16 <> *blanks
091300150102     c                   clear                   rp17gxlfld
091400150102     C                   Eval      rp17gxlfld  =                          '"' +
091500150102     C                             %trim(%editw(g7tsa:'0   -   -    ')) + csv +
091600150102     C                             %trim(g7acnam)                       + csv +
091700150116     C                             %trim(g7aalname)                     + csv +
091800150116     C                             %trim(g7aafname)                     + csv +
091900150102     C                             %trim(g7cname)                       + csv +
092000150102     C                             %trim(g7g#16)                        + csv +
092100150102     C                             %trim(g7g#17)                        + csv +
092200150102     C                             %trim(g7g#18)                        + csv +
092300150102     C                             %trim(g7g#19)                        + csv +
092400150102     C                             %trim(g7g#20)                        + csv +
092500150102     C                             %trim(g7g#21)                        + csv +
092600150102     C                             %trim(g7g#22)                        + csv +
092700150102     C                             %trim(g7g#23)                        + csv +
092800150102     C                             %trim(g7g#24)                        + csv +
092900150102     C                             %trim(g7g#25)                        + csv +
093000150102     C                             %trim(g7g#26)                        + csv +
093100150102     C                             %trim(g7g#27)                        + csv +
093200150102     C                             %trim(g7g#28)                        + csv +
093300150102     C                             %trim(g7g#29)                        + csv +
093400150102     C                             %trim(g7g#30)                        + csv +
093500150102     C                             ' '                                  + '",'
093600150102     C*
093700150102     C                   Write     rp17gxlr
093800150102     c                   end
093900150102
0940001412290320 C                   ENDSR
094100141222
0942001412220164 C*************************************************************
0943001412220164 C*                                                           *
0944001412220164 C* Write to CSV file for Excel Spreadsheet                   *
0945001412220164 C*                                                           *
0946001412220164 C*************************************************************
094700141222     C     WriteSpread   BEGSR
094800070502
094900030630     C                   Move      'N'           WKPRINV           1
095000150921
095100150921      * get invoice transaction date
095200150921     C                   clear                   WKDTINV           8 0
0953001509210088 C     INKEY         CHAIN     INVSUM
095400150921     c                   if        %found(invsum)
095500150921     C     INVDTE        Mult      10000.0001    WKDTINV
095600150921     c                   end
095700150209
095800150209      * get BOR broker
095900150209     C                   clear                   wkborbkr         31
096000030630     C     SMANCD        CHAIN     SMAN
096100030630     C                   If        %Found(SMAN)
096200150209     C                   Eval      wkborbkr = %trim(sfname) + ' ' +
096300150209     C                             %trim(slname)
096400030630     C                   End
096500150209
096600150209      * get servicing broker
096700150209     c     tsakey        CHAIN     ac2mstl2
096800150209     C                   if        %found(ac2mstl2)
096900150209     C                   clear                   wksvcbkr         31
097000150209     C     a2code1       CHAIN     SMAN
097100150209     C                   If        %Found(SMAN)
097200150209     C                   Eval      wksvcbkr = %trim(sfname) + ' ' +
097300150209     C                             %trim(slname)
097400150209     C                   end
097500150209     C                   end
097600150209
097700150209     c                   clear                   wkaaname         41
097800030630     C     A_AACODE      CHAIN     AACODR
097900030630     C                   If        %Found(AACODE)
098000150209     C                   Eval      wkaaname = %trim(afnam) + ' ' +
098100150209     C                             %trim(alnam)
098200030630     C                   End
098300150209
098400030804     C     LMDY          Mult      10000.0001    KeyDate           8 0
098500030630     C     HisKey        CHAIN     HISTL4
098600030630     C                   If        %Found(HISTL4)
098700030630     C                   Eval      WKPRINV  =    'Y'
098800030630     C                   Else
098900030630     C                   Eval      WKPRINV  =    'N'
099000030630     C                   End
099100030730     C                   Movel     KEYACC        Alpha_KeyAcc     10
099200030805     C     HisKey5p      SETLL     HISTL5
099300030805     C     HisKey5       READE     HISTL5
099400030805     C                   If        %Eof(HISTL5)
099500030703     C                   Eval      L5TRAMT  =    *Zeros
099600030703     C                   End
099700070511
099800070511      * initial invoice?
099900070511     c                   clear                   initinv
100000191127     c                   if        gbsbdtym = newym
100100070511     c                   eval      initinv = 'Y'
100200070511     c                   end
100300150211
100400150211      * agency name
100500150211     c                   clear                   wkagname         40
100600150211     c                   if        holdagcode <> *blanks
100700150211     c                   if        gt1agency <> 'Y'
100800150211     C     holdagcode    chain     agency
100900150211     C                   if        %found(agency)
101000150211     C                   eval      wkagname = %trim(agnam1)
101100150211     C                   end
101200150211      * show "> 1" text
101300150211     c                   else
101400150211     C                   eval      wkagname = '** More than 1 Agency **'
101500150211     C                   end
101600150211     C                   end
101700150211
101800190211      * Is this acct subject to the Care First PSF?
101900190207     c                   exsr      #getpsf
102000070511
102100200428      * Is this a Care First payment deferral acct for this month?
102200200428     c                   exsr      #getdfr
102300200428
102400210420      * Are there any COBRA Subsidy plan active?
102500210420     c                   exsr      #getsubsidy
102600210420
102700091020      * non-dental version
102800180111     c****               if        ldonly <> 'D'
102900180111     c                   if        ldonly = 'O'
103000030630     C                   Eval      WKRECORD  =   '"' +
103100150128     C                              %Trim(%Editc(trust#:'P'))  + csv +
103200150128     C                              %Trim(%Editc(sub#:'P'))    + csv +
103300150128     C                              %Trim(%Editc(acc#:'P'))    + csv +
103400150128     C                                          %Trim(acnam1)  + csv +
103500150114     C                                                 dberule  + csv +
103600200428     C                                                cfpaydfr  + csv +
103700190213     C                                                 psfout   + csv +
103800150128     C                              %Trim(%Editc(totinv:'P'))   + csv +
103900150128     C                              %Trim(%Editc(credit:'P'))   + csv +
104000150114     C                             %Trim(%Editc(credpctout:'P'))+ csv +
104100150128     C                              %Trim(%Editc(debit:'P'))  + csv +
104200150128     C                              %Trim(%Editc(monpay:'P'))    + csv +
104300150128     C                              %Trim(%Editc(outbal:'P'))    + csv +
104400150114     C                              %Trim(%Editc(L5TRAMT:'P'))  + csv +
104500150114     C                             %Trim(%Editc(paypctWOcredo:'P')) + csv +
104600150209     C                             %Trim(%Editc(paypctWcrdbo:'P')) + csv +
104700150114     C                             %Trim(%Editc(paypctreq:'P')) + csv +
104800150114     C                                             pendcancel   + csv +
104900150928     C                                                 paymnt   + csv +
105000190207     C                              %Trim(%Editc(acvtdtmdy:'Y')) + csv +
105100150128     C                              %Trim(%Editc(noempl:'P'))   + csv +
105200150209     C                                         %Trim(wkborbkr)  + csv +
105300150211     C                                         %Trim(wkagname)  + csv +
105400150209     C                                         %Trim(wksvcbkr)  + csv +
105500150209     C                                          %Trim(wkaaname) + csv +
105600190207     C                              %Trim(%Editc(WKDTINV:'Y'))  + csv +
105700150114     C                                                 WKPRINV  + csv +
105800150114     C                                                initinv   + csv +
105900210420     C                                                submem_o  + csv +
106000131112     C                                                '",'
106100091020     c                   else
106200091020      * Senior dental version
106300091020     C                   Eval      WKRECORD  =   '"' +
106400150114     C                              %Trim(wkasphfl)             + csv +
106500150128     C                              %Trim(%Editc(trust#:'P'))  + csv +
106600150128     C                              %Trim(%Editc(sub#:'P'))    + csv +
106700150128     C                              %Trim(%Editc(acc#:'P'))    + csv +
106800150128     C                                          %Trim(acnam1)  + csv +
106900150128     C                              %Trim(acnam2)             + csv +
107000150114     C                              %Trim(wkaphone)             + csv +
107100150114     C                              %Trim(wkfacname)            + csv +
107200150114     C                              %Trim(wkfaccontac)          + csv +
107300150128     C                              %Trim(%Editc(totinv:'P'))   + csv +
107400150128     C                              %Trim(%Editc(credit:'P'))   + csv +
107500150114     C                             %Trim(%Editc(credpctout:'P')) + csv +
107600150128     C                              %Trim(%Editc(debit:'P'))   + csv +
107700150128     C                              %Trim(%Editc(monpay:'P'))    + csv +
107800150128     C                              %Trim(%Editc(outbal:'P'))    + csv +
107900150114     C                              %Trim(%Editc(L5TRAMT:'P'))  + csv +
108000150114     C                             %Trim(%Editc(paypctWOcredo:'P')) + csv +
108100150209     C                             %Trim(%Editc(paypctWcrdbo:'P')) + csv +
108200150114     C                             %Trim(%Editc(paypctreq:'P')) + csv +
108300150114     C                                             pendcancel   + csv +
108400150928     C                                                 paymnt   + csv +
108500150128     C                              %Trim(%Editc(acvtdtmdy:'P')) + csv +
108600150128     C                              %Trim(%Editc(noempl:'P'))   + csv +
108700150209     C                                         %Trim(wkborbkr)  + csv +
108800150209     C                                          %Trim(wkaaname) + csv +
108900150114     C                              %Trim(%Editc(WKDTINV:'P'))  + csv +
109000091020     C                                                initinv   +   '",'
109100091020     c                   end
109200091020
109300070615      * write record to file
109400070615     C                   Write     RP170CSR
109500070615
1096000306300320 C                   ENDSR
109700030630     C*
109800970220     C/EJECT
109900030630     C*************************************************************
110000030630     C*                                                           *
110100030630     C* Write to CSV file for Excel Spreadsheet Title             *
110200030630     C*                                                           *
110300030630     C*************************************************************
110400030630     C     WriteSpTitle  BEGSR
110500030630     C*
110600091020      * non-dental version
110700180111     c****               if        ldonly <> 'D'
110800180111     c                   if        ldonly = 'O'
110900150114     C                   Eval      WKRECORD  =   '"' + 'Trust'     + csv +
111000150114     C                                                 'Sub'       + csv +
111100150114     C                                                 'Acct'      + csv +
111200150114     C                                                 'Acct Name' + csv +
111300150114     C                                                 'CFS'       + csv +
111400200428     C                                                 'CF PAYDFR' + csv +
111500190213     C                                                 'PSF/BSF'   + csv +
111600150114     C                                                 'Total Due' + csv +
111700150114     C                                                 'Credits'   + csv +
111800150114     C                                                 'Credit %'  + csv +
111900150114     C                                                 'Debits'    + csv +
112000150114     C                                                  'Payments' + csv +
112100150114     C                                                 'Outs Bal'  + csv +
112200150114     C                                              'Current Amt'  + csv +
112300150209     C                                          '% Paid w/o cred'  + csv +
112400150209     C                                        '% Paid w/cred+deb'  + csv +
112500150114     C                                               '% Required'  + csv +
112600150114     C                                           'Pending Cancel'  + csv +
112700150928     C                                            'We will Remit'  + csv +
112800150114     C                                                 'Inv Thru'  + csv +
112900150114     C                                                 'Act Empl'  + csv +
113000150209     C                                               'BOR Broker'  + csv +
113100150211     C                                               'BOR Agency'  + csv +
113200150209     C                                         'Servicing Broker'  + csv +
113300150209     C                                                  'AA Name'  + csv +
113400150114     C                                                 'Date Inv'  + csv +
113500150114     C                                               'Void Exist'  + csv +
113600150114     C                                              'Initial Inv'  + csv +
113700210420     C                                              'Subsidy Mem'  + csv +
113800150114     C                                              '",'
113900091020     c                   else
114000091020      * Senior dental version
114100091020     C                   Eval      WKRECORD  =   '"' +
114200150114     C                                                 'Spc handl' + csv +
114300150114     C                                                 'Trust'     + csv +
114400150114     C                                                 'Sub'       + csv +
114500150114     C                                                 'Acct'      + csv +
114600150114     C                                                 'Acct Name' + csv +
114700150114     C                                                'Acct Name2' + csv +
114800150114     C                                                'Acct Phone' + csv +
114900150114     C                                               'Facil. name' + csv +
115000150114     C                                            'Facil. contact' + csv +
115100150114     C                                                 'Total Due' + csv +
115200150114     C                                                 'Credits'   + csv +
115300150114     C                                                 'Credit %'  + csv +
115400150114     C                                                 'Debits'    + csv +
115500150114     C                                                  'Payments' + csv +
115600150114     C                                                 'Outs Bal'  + csv +
115700150114     C                                              'Current Amt'  + csv +
115800150209     C                                           '% Paid w/o cred' + csv +
115900150209     C                                         '% Paid w/cred+deb' + csv +
116000150114     C                                               '% Required'  + csv +
116100150114     C                                           'Pending Cancel'  + csv +
116200150928     C                                            'We will Remit'  + csv +
116300150114     C                                                 'Inv Thru'  + csv +
116400150114     C                                                 'Act Empl'  + csv +
116500150209     C                                               'BOR Broker'  + csv +
116600150209     C                                                  'AA Name'  + csv +
116700150114     C                                                 'Date Inv'  + csv +
116800091020     C                                              'Initial Inv'  + '",'
116900091020     c                   end
117000091020
117100030630     C                   Write     RP170CSR
117200030630     C*
1173000306300320 C                   ENDSR
117400030630     C*
117500030630     C/EJECT
1176009702200164 C*************************************************************
1177009702200164 C*                                                           *
1178009702200164 C* PRINT WITHOLD CARE LETTERS                                *
1179009702200164 C*                                                           *
1180009702200164 C*************************************************************
118100970219     C     #LTR          BEGSR
118200050321     C*
118300220809     C*
118400050321     C* AA NAME
118500050321     c                   clear                   aaname
118600050321     C     A_AACODE      CHAIN     AACODR
118700050321     C                   If        %Found(AACODE)
118800050321     C                   movel     afnam         aaname
118900050321     c                   cat       alnam:1       aaname
119000050321     C                   Else
119100050321     C                   Eval      aaname   =    'Not on File'
119200050321     C                   End
119300980226     C*
119400980226     C*
119500981203     C                   MOVE      'N'           BCACC             1
1196009702200308 C*
1197001503090308 C* find group #'s for all active members in the account to print on
1198001503090308 C* letter
1199001503090308 C*
120000150309     c                   exsr      #fndg#ltr
1201000310150308 C*
1202000310150308 C* ACCOUNT LETTER
1203000310150308 C*
120400030903     C                   IF        LLETA = 'Y'
120500981203     C     BCACC         IFEQ      'Y'
1206009702270144 C                   EXSR      #ADDR
1207000309160147 C                   EXSR      #GROUPA
120800210503
120900210503      * AA page break (must run by aa sort(3) for this to work)
121000210503     C                   IF        FIRSTAAA = ' '
121100210503     C                   WRITE     NEWAAPAGA
121200210503     C                   EVAL      FIRSTAAA = 'N '
121300210503     C                   EVAL      NEWAA = a_aacode
121400210503     C                   end
121500210503     C                   IF        NEWAA <> a_aacode
121600210503     C                   WRITE     NEWAAPAGA
121700210503     C                   EVAL      NEWAA = a_aacode
121800210503     C                   ENDIF
121900210503
122000030912     C                   WRITE     ACCCOLL
122100030912     C                   WRITE     ACCPAGSEG
1222000309250066 C                   CLEAR                   GRPNBRS
122300040226     C*                  EVAL      *IN25 = *ON
122400040226     C                   MOVE      KEYACC        HSTKEY
122500220809
122600220809X001 C                   If        EXCLUDE = 'Y'
122700221104 |   C                   MOVEL     NOTEX         HNOTE
122800221104 |   C                   MOVEL     NOTEX2        HNOTE2
122900220809 |   C                   else
123000220809 |   C                   MOVE      NOTEA         HNOTE
123100221104     C                   MOVE      *blanks       HNOTE2
123200220809X001 C                   end
123300220809
1234009702270318 C* WRITE HIST REC
1235009702270318 C*  ***NOT USED IN TESTING ***
123600131010     c                   eval      hstrtime = %time
123700970227     C   U1              EXCEPT    ADDHIS
1238000309030320 C                   ENDIF
1239000309250320 C                   ENDIF
124000031021     C                   MOVE      *BLANKS       GAR
124100221104     C                   MOVE      *BLANKS       GAR2
124200221104     C                   MOVE      *BLANKS       HNOTE
124300221104     C                   MOVE      *BLANKS       HNOTE2
124400970228     C*
1245009702270320 C                   ENDSR
124600150309     C*
1247001503090351 C****************************************************************
1248001503090352 C* find all group #'s active for members in this acct for use   *
1249001503090352 C* in the acct letter.                                          *
1250001503090354 C****************************************************************
125100150309
125200150309     C     #fndg#ltr     BEGSR
125300150309
125400150309     C     KEYACC        SETLL     MEMAC#
125500150309     C                   dou       %eof(memac#)
125600150309     C     KEYACC        READE     MEMAC#
125700150309     C                   if        %eof(memac#)
125800150309     C                   leave
125900150309     C                   END
126000150309
126100150309     C                   if        termdt <> 0 and termdt <= newymd
126200150309     C                   iter
126300150309     C                   END
126400150309     C*
126500150309     C* READ COVERAGES
126600150309     C*
126700150309     C     SSNO          SETLL     MCOV
126800150309     C                   dou       %eof(mcov)
126900150309     C     SSNO          READE     MCOV
127000150309     C                   if        %eof(mcov)
127100150309     C                   leave
127200150309     C                   END
127300150309     C*
127400150309     C                   if        candt <> 0 and candt <= newymd
127500150309     C                   iter
127600150309     C                   END
127700150309
127800150309     C* get plan, if not found print error and read another mcov
127900150309     C     PLNKEY        CHAIN     PLNMST                             61
1280001503090096 C     *IN61         IFEQ      *ON
128100150309     C     FIRSTE        IFEQ      ' '
128200150309     C                   EXCEPT    HEADE
128300150309     C                   MOVE      'N'           FIRSTE
128400150309     C                   END
128500150309     C                   EXCEPT    LINEE
128600150309     C   OE              EXCEPT    HEADE
1287001503090096 C                   iter
128800150309     C                   END
128900150309     C*
129000150309     C* get carrier, if not found print error and read another mcov
129100150309     C     PCARR         CHAIN     CARMST                             62
1292001503090096 C     *IN62         IFEQ      *ON
129300150309     C     FIRSTE        IFEQ      ' '
129400150309     C                   EXCEPT    HEADE
129500150309     C                   MOVE      'N'           FIRSTE
129600150309     C                   END
129700150309     C                   EXCEPT    LINEE
129800150309     C   OE              EXCEPT    HEADE
1299001503090096 C                   iter
130000150309     C                   END
130100150309     C*
130200150309     C* ONLY DBE
130300150309     c                   if        carbc <> 'D'
130400150309     c                   iter
130500150309     c                   end
130600150309     C*
130700150309     C* GET GROUP#'S
130800150309     C*
1309001503090445 C                   SETOFF                                           60
1310001503090446 C                   Z-ADD     *ZEROS        GCOUNT
1311001503090447 C     RATKEY        SETLL     GRATE
1312001503090448 C*
1313001503090449 C     #READ         TAG
1314001503090450 C*
1315001503090451 C                   READ      GRATE                                  60
1316001503090452 C  N60RATKEY        COMP      GRTKEY                             6060
1317001503090453 C   60              GOTO      #SKIP1
1318001503090454 C*
1319001503090455 C     NEWYMD        IFGE      FRCYMD
1320001503090456 C     NEWYMD        IFLE      TOCYMD
1321001503090457 C                   ADD       1             GCOUNT            2 0
1322001503090458 C                   GOTO      #SKIP1
1323001503090459 C                   END
1324001503090460 C                   END
1325001503090461 C*
1326001503090462 C                   GOTO      #READ
1327001503090463 C*
1328001503090464 C     #SKIP1        TAG
1329001503090465 C*
1330001503090466 C     GCOUNT        IFNE      *ZERO
133100150309     C                   EXSR      #STORG
133200150309     C                   MOVE      'Y'           BCACC
1333001503090468 C                   END
133400150309
133500150309      * end of mcov loop
133600150309     C                   enddo
133700150309
133800150309      * end of mem loop
133900150309     C                   enddo
134000150309
1341001503090320 C                   ENDSR
134200150309
134300970227     C*
1344009702270351 C****************************************************************
1345009702270352 C*    STORE GROUP #                                             *
1346009702270354 C****************************************************************
134700970227     C*
134800970227     C     #STORG        BEGSR
134900970227     C*
135000031110     C* STORE GROUP# FOR ACCT  (W/C Report)
135100150309     C* (not for DBE)
135200031110     C                   IF        CARBC = 'D'
135300031110     C                   GOTO      #ENST
135400031110     C                   END
135500150306
135600970227     C                   Z-ADD     1             X
135700970227     C     #T0080        TAG
135800970227     C     GAR(X)        IFEQ      *BLANK
135900970227     C                   MOVE      GROUP#        GAR(X)
136000970227     C                   GOTO      #ENST
136100970227     C                   ELSE
136200970227     C*
136300970227     C     GAR(X)        IFEQ      GROUP#
136400970227     C                   GOTO      #ENST
136500970227     C*
136600970227     C                   ELSE
136700970227     C                   ADD       1             X
136800970227     C*
136900970227     C     X             IFLE      8
137000970227     C                   GOTO      #T0080
137100970227     C                   END
137200970227     C*
137300970227     C                   END
137400970227     C                   END
137500000427     C     #ENST         TAG
137600031110     ************************
137700031110     C*
137800031110     C* STORE GROUP# FOR ACCT  (Client Letters)
137900031110     C*
138000031110     C                   Z-ADD     1             X
138100031110     C     #T0090        TAG
138200031110     C     GAR2(X)       IFEQ      *BLANK
138300031110     C                   MOVE      GROUP#        GAR2(X)
138400031110     C                   GOTO      #ENST2
138500031110     C                   ELSE
138600031110     C*
138700031110     C     GAR2(X)       IFEQ      GROUP#
138800031110     C                   GOTO      #ENST2
138900031110     C*
139000031110     C                   ELSE
139100031110     C                   ADD       1             X
139200031110     C*
139300031110     C     X             IFLE      8
139400031110     C                   GOTO      #T0090
139500031110     C                   END
139600031110     C*
139700031110     C                   END
139800031110     C                   END
139900031110     C     #ENST2        TAG
140000991220
140100000427     C                   ENDSR
140200030916     C*
1403000309160351 C****************************************************************
1404000309160352 C*    GROUP#'S FOR ACCOUNT WITHHOLD CARE LETTERS                *
1405000309160354 C****************************************************************
140600030916     C*
140700030916     C     #GROUPA       BEGSR
140800030916     C
140900030916     C                   DO        8             X
141000031110     C                   IF        GAR2(X) = *BLANKS
141100030916     C                   LEAVE
141200030916     C                   ENDIF
141300030916     C                   IF        X = 1
1414000311100066 C                   MOVEL     GAR2(X)       GRPNBRS
141500030916     C                   ELSE
141600031014     C                   CAT       ', ':0        GRPNBRS
141700031110     C                   CAT       GAR2(X):1     GRPNBRS
141800030916     C                   ENDIF
141900030916     C                   ENDDO
142000030916     C
142100030916     C                   ENDSR
142200030916     C*
1423009702200351 C****************************************************************
1424009702200352 C*    AL = CITY, ST  ZIP+4                                      *
1425009702200353 C*------------------- COMPRESS CITY/STATE/ZIP ------------------*
1426009702200354 C****************************************************************
1427009702200355 C*
1428009702200355 C* ACCT ADDR
1429009702200355 C*
1430009702200356 C     #ADDR         BEGSR
1431009702200359 C*
1432000201280360 C                   MOVE      *BLANKS       AL               30
143300020128     C                   MOVEl     ACITY         AL
143400020128     c                   cat       ',':0         al
143500020128     c                   cat       astate:1      al
143600030910     c*                  cat       '.':0         al
143700020128     C*                                                                   RPF140
143800020128     C                   MOVEL     AZIP          ZIP5              5
143900020128     C                   MOVE      AZIP          ZIP4              4
144000020128     c                   cat       zip5:1        al
144100020128     C     ZIP4          IFNE      '0000'
144200020128     c                   cat       '-':0         al
144300020128     c                   cat       zip4:0        al
144400020128     C                   END
1445009702200393 C*
144600030912     C                   IF        AADDR2  = *BLANKS
144700030912     C                   EVAL      AADDR2  = AL
144800030912     C                   EVAL      AADDR3  = *BLANKS
144900030912     C                   ELSE
145000030912     C                   EVAL      AADDR3  = AL
145100030912     C                   END
145200220809
145300220809X001 C                   If        EXCLUDE = 'Y'
145400220809 |   C                   if        %trim(AADDR3) <> *blanks
145500220812 |   C                   eval      AADDR3 = %replace ( ' **': AADDR3 :29:3)
145600220812X001 C                   else
145700220812 |   C                   eval      AADDR2 = %replace ( ' **': AADDR2 :28:3)
145800220809 |   C                   end
145900220809X001 C                   end
146000220809
1461000201280394 C                   ENDSR
146200150309
1463009702200647 C****************************************************************
1464000201280648 C* ROUTINE FOR NAME LINE - FIRST MI. LAST                       *
1465009702200649 C****************************************************************
1466009702200650 C     #NAME         BEGSR
1467009702200653 C*
1468000201280654 C                   MOVE      *BLANKS       N                31
146900020128     C                   MOVEL     fname         N
147000020128     C     mi            IFNE      ' '
147100020128     C                   CAT       MI:1          N
147200020128     C                   CAT       '.':0         N
147300020128     C                   END
147400020128     C                   CAT       LNAME:1       N
147500020128
1476009702200675 C                   ENDSR
147700981209     C*
1478009812090103 C***************************************************
1479009812090104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
1480009812090105 C***************************************************
1481009812090107 C*
1482009812090107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
1483009812090107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
1484009812090107 C*
1485009812090106 C     #DATMY        BEGSR
148600981209     C                   MOVEL     @DATIN        @MD               4 0
148700981209     C                   MOVE      @DATIN        @Y                4 0
148800981209     C                   MOVE      @MD           @DATOU            8 0
148900981209     C                   MOVEL     @Y            @DATOU
149000981209     C                   MOVE      *ZEROS        @DATIN            8 0
1491009812090120 C                   ENDSR
149200981209     C*
1493009908090103 C***************************************************
1494009908090104 C* FIRST CYCLE                                     *
1495009908090105 C***************************************************
1496009908090060 C*
1497009908090106 C     *INZSR        BEGSR
149800220805
149900220805X001 C     *Entry        plist
150000220805X001 C                   parm                    exclude           1
150100220805
150200990809     C                   MOVE      'ACC #  '     OSORT             7
150300990809     C     LSORT         IFEQ      '2'
150400990809     C                   MOVE      'BROKER '     OSORT
150500990809     C                   ELSE
150600990809     C     LSORT         IFEQ      '3'
150700990809     C                   MOVE      'AA CODE'     OSORT
150800091020     C                   ELSE
150900091020     C     LSORT         IFEQ      '4'
151000091020     C                   MOVE      'SPC HAN'     OSORT
151100990809     C                   END
151200091020     C                   END
151300990809     C                   END
151400150114      * write headings to csv file
151500150114     C                   Exsr      WriteSpTitle
151600990809     C*
151700990809     C     INKEY         KLIST
151800990809     C                   KFLD                    TRUST#
151900990809     C                   KFLD                    SUB#
152000990809     C                   KFLD                    ACC#
152100990809     C                   KFLD                    NEWYMD
152200990809     C                   KFLD                    KEB
152300990809     C*
152400141217     C     TSAKEY        KLIST
152500990809     C                   KFLD                    TRUST#
152600990809     C                   KFLD                    SUB#
152700990809     C                   KFLD                    ACC#
152800091019
152900091019     C     subkey        KLIST
153000091019     C                   KFLD                    TRUST#
153100091019     C                   KFLD                    SUB#
153200990809     C*
153300091015     C     odkey         KLIST
153400091015     C                   KFLD                    TRUST#
153500091015     C                   KFLD                    SUB#
153600091015     C                   KFLD                    zero4
153700091015     C                   KFLD                    bom
153800091015     C*
153900990809     C     PLNKEY        KLIST
154000990809     C                   KFLD                    MCTRST
154100990809     C                   KFLD                    MCSUB
154200990809     C                   KFLD                    MCPLAN
154300141217
154400141222     C     xtspackey     KLIST
154500141229     C                   KFLD                    x_MCTRST
154600141229     C                   KFLD                    x_MCSUB#
154700141229     C                   KFLD                    x_MCPLAN
154800141222     C                   KFLD                    x_MCageb
154900141222     C                   KFLD                    x_MCovtp
155000141222
155100141222     C     xtsacarkey    KLIST
155200141222     C                   KFLD                    x_MCTRST
155300141229     C                   KFLD                    x_MCSUB#
155400141222     C                   KFLD                    x_acc#
155500141229     C                   KFLD                    pcarr
155600141222
155700141222     C     xtspkey       KLIST
155800141222     C                   KFLD                    x_MCTRST
155900141229     C                   KFLD                    x_MCSUB#
156000141222     C                   KFLD                    x_MCPLAN
156100141222
156200141217     C     cmctxplnky    KLIST
156300141217     C                   KFLD                    CMTRST
156400141217     C                   KFLD                    CSUBDV
156500141217     C                   KFLD                    CMPLAN
156600030625     C*
156700030625     C     HisKey        KLIST
156800030625     C                   KFLD                    TRUST#
156900030625     C                   KFLD                    SUB#
157000030625     C                   KFLD                    ACC#
157100030804     C                   KFLD                    KeyDate
157200030730     C*
157300030730     C     HisKey5       KLIST
157400030730     C                   KFLD                    Alpha_KeyAcc
157500030804     C                   KFLD                    KeyDate
157600030703     C*
157700030805     C     HisKey5P      KLIST
157800030805     C                   KFLD                    Alpha_KeyAcc
157900030805     C                   KFLD                    KeyDate
158000030805     C                   KFLD                    HighDate
158100030805     C*
158200030805     C                   Z-add     99999999      HighDate          8 0
1583009908090062 C**                   MOVE 'BMP'     CODE
1584000307030062 C                   MOVE      'BMB'         BMB               3
1585009908090062 C                   MOVE      'KEB'         KEB               3
158600030925     C                   Z-ADD     0             ZERO9             9 0
1587009908090064 C*                    Z-SUB50.00     VALUE   42
158800020128
158900030910     C* DL3 = Report Month YYYY
159000030506     C                   MOVEL     LMDY          USA_DATE
159100030506     C                   ADDDUR    1:*M          USA_DATE
159200030506     C                   EXTRCT    USA_DATE:*M   MDL               2 0
1593000305060066 C                   MOVEl     YR(MDL)       DL3              15
159400030506     C                   EXTRCT    USA_DATE:*Y   YDL               4
159500030506     c                   cat       YDL:1         dl3
159600030910     *********
159700030910     C* DL = Withhold Care Letter (effdt of cancel)
159800030910
159900030910     C                   MOVEl     YR(lm)        DL               19
160000030915     c                   cat       '1,':1        dl
160100030910     c                   cat       lychar:1      dl
160200150309     *********
160300150309     C* Withhold Care Letter (grace period end date)
160400150309     C                   MOVEL     LMDY          USA_DATE
160500150309     C                   ADDDUR    30:*d         USA_DATE
160600150309     C                   MOVE      usa_date      gracendt
160700030916
160800030910     *********
160900020128     C* M/D/Y heading DATE LINE -
161000020128
161100011025     C                   IF        MO## > 0
161200011025     C                   MOVEA     YR(MO##)      @9                9
161300011025     C                   MOVE      *BLANKS       @19              19
161400011025     C                   EVAL      @19 = %TRIMR(@9) + ' ' + DD## + ',' + ' ' +
161500011011     C                             YY##
161600020128     C                   MOVEl     @19           DL2              19
161700011025     C                   ELSE
1618000201280066 C                   MOVEl     YR(lm)        DL2
161900020128JGE01C                   move      *day          dayc              2
162000020128JGE01C                   move      *year         yearc             4
162100020128     c                   cat       dayc:1        dl2
162200020128     c                   cat       ',':0         dl2
1623000201280075 C                   cat       YEARC:1       dl2
162400011025     C                   ENDIF
162500011011    ***
162600020627     C                   MOVE      *date         rpgdate
162700020627     C                   time                    rpgtime
162800031021     C*
1629009908090078 C                   ENDSR
163000030912
163100030912      **********************************************************
163200190207      * Find DBE, payment % required, agency name
163300030912      **********************************************************
163400070502      * 05/02/07 - add code to find payment % required         *
163500141217      * 12/17/14 - change to use commission instead of members and mcov
163600141217      *            to reduce run time
163700150520      * 02/25/15 - hold carrier code also for the highest threshold %
1638000309120078 C     #fnddbe       begsr
163900030912
164000030912     c                   clear                   dberule           1
164100070502     c                   clear                   paypctreq
164200131111     c                   clear                   paypctWOcredo
164300150209     c                   clear                   paypctWcrdbo
164400131111     c                   clear                   credpctout
164500070502     c                   clear                   wkpct
164600070502     c                   clear                   holdpct
164700150520     c                   clear                   holdcarrier
164800150211     c                   clear                   holdagcode
164900150211     c                   clear                   gt1agency
165000030912
165100141217     C     tsakey        setll     cmct14
165200141217     C                   dou       %eof(cmct14)
165300141217     C     tsakey        reade     cmct14
165400141217     c                   if        not %eof(cmct14) and (cmcan = 0 or
165500141217     c                             cmcan > newymd) and (effdat <= newymd)
165600141217      * get plan rec
165700141217     C     cmctxplnky    chain     plnmst
1658000309120096 C                   if        %found(plnmst)
165900150211      * find the % req
166000030912     C     pcarr         chain     carmst
1661000705020096 C                   if        %found(carmst)
166200070502     c                   exsr      #chkpct
166300070502     c                   end
166400150211
166500150211      * hold agency code if this comctx is for the BOR sman
166600150211     c     cmrelid       chain     smanrlt
166700150211     c                   if        %found(smanrlt) and srsman = smancd
166800150211     c                   exsr      #holdagency
166900030912     c                   end
167000150211
167100150211     c                   end
167200030912     c                   end
167300030912     c                   enddo
167400070502
167500150209      * after all plans processed, finalize payment percent required.
167600070502      * if for some reason the % was not found then default to 100%
167700070502
167800070502     c                   if        holdpct <> 0
167900070502     c                   z-add     holdpct       paypctreq
168000070502     c                   else
168100070502     c                   z-add     100           paypctreq
168200070502     c                   end
168300030912
1684000309120078 C                   ENDSR
168500070502
168600070502      **********************************************************
168700150211      * hold the agency code for this account, if there are more than 1
168800150211      * then no agency will be shown on the report
168900070502      **********************************************************
1690001502110078 C     #holdagency   begsr
169100150211
169200150211      * get xref for agency code
169300150211     c     srasid        chain     spragxr2
169400150211     c                   if        %found(spragxr2)
169500150211      * hold first agency code
169600150211     c                   if        holdagcode = *blanks
169700150211     c                   eval      holdagcode = sxagcy
169800150211     c                   end
169900150211      * if > 1 agency exists then no agency will be shown on the report
170000150211     c                   if        holdagcode <> sxagcy
170100150211     c                   eval      gt1agency = 'Y'
170200150211     c                   end
170300150211     c                   end
170400150211
170500150211     c                   endsr
170600150211
170700150211      **********************************************************
170800150211      * check payment %
170900150211      **********************************************************
1710001502110078 C     #chkpct       begsr
171100070502
171200070502     c                   z-add     cthresh       wkpct
171300150217      * Set DBE indicator
171400150217     c                   if        carbc = 'D'
171500150217     c                   eval      dberule = 'Y'
171600150217     c                   end
171700150216
171800150520      * hold higest percent and carrier code
171900070502     c                   if        wkpct > holdpct
172000070502     c                   z-add     wkpct         holdpct
172100150520     c                   move      pcarr         holdcarrier
172200070502     c                   end
172300070502
1724000705020078 C                   endsr
172500190906
172600190906br01  **********************************************************
172700190906      * Auto Debit
172800190906      **********************************************************
172900190906
173000190906       begsr AutoDebit;
173100190906
173200190906
173300190906
173400190906         //----------------------------------------------------
173500190906         //
173600190906         //   Read through the Auto Debit File
173700190906         //
173800190906         //----------------------------------------------------
173900190906         Setll (G7TRUST : g7Sub : g7Acc ) SecAch;
174000190906
174100190906
174200190906          G7AutoDbt = '';
174300190906
174400190906         Dou %Eof(SecAch);
174500190906         reade (G7TRUST : g7Sub : g7Acc ) SecAch;
174600190906           if %eof(SecAch);
174700190906             leave;
174800190906           endif;
174900190906
175000190906           if ahDebit = '';
175100190906             iter;
175200190906           EndIf;
175300190906
175400190906           if ahEndt = 0 or ahEndt >= %Dec(%Date);
175500190906             G7AutoDbt = 'Enrolled';
175600190906           endif;
175700190906         Enddo;
175800190906
175900190906
176000190906
176100190906         // If not in SECACH File - Check ACCACH
176200190906         if G7AutoDbt = '';
176300190906
176400190906             today = %Dec(%Date);
176500190906             Count = 0;
176600190906             Exec Sql
176700190906                Select Count(*)
176800190906                   Into :count
176900190906                   From accach
177000190906                   Where (ahendt = 0
177100190906                         Or ahendt > :today )
177200190906                         And ahtrst = :g7Trust
177300190906                         And ahsub# = :g7Sub
177400190906                         And ahacct = :g7Acc;
177500190906
177600190906             if Count > 0;
177700190906               G7AutoDbt = 'ACH File';
177800190906             EndIf;
177900190906
178000190906           Endif;
178100190906
178200190906
178300190906       Endsr;
178400190906
178500190906
178600190906
178700190906
178800190906
178900190906
179000190906
179100190906
1792001509210278 OHISTak    EADD         ADDHIS
1793000402260279 O                       HSTKEY              10
1794009702190284 O                                           19 'UHM'
1795000309250285 O                       ZERO9               24P
179600221104     O                       HNOTE               55
179700221104     O                       HNOTE2              85
179800040615     O                                           90 '00'
179900131025     O                       thispgmname        107
180000131025     O                                          108 ' '
1801009702190292 O                       KEYACC             119
1802001311190285 O                       ZERO8              127
1803009702190294 O                                          128 'A'
1804009812090281 O                       *YEAR              132
1805009812090282 O                       *MONTH             134
1806009812090283 O                       *DAY               136
1807000406150288 O                                          144 '00000000'
1808009812090288 O                                          152 '00000000'
1809000305060289 O                       NEWYMD2            160
1810001310100285 O                       ZERO9              184
1811001310100285 O                       ZERO7              191
1812001310100285 O                       hstrtime           199
1813001310100285 O                       ZERO7              206
1814001310140293 O                       USERID             216
181500970228     O*
181600970228     O* WITHHOLD CARE REPORT
181700970228     O*
1818000910230166 Orp170pe   E            HEADE          2 03
1819009806020167 O                                           45 '*****'
1820009806020168 O                       CONAME              85
1821009806020169 O                                           91 '*****'
1822009806020170 O          E            HEADE          1
1823009806020171 O                                           61 'ACCOUNTS PENDING CANCELL'
1824009806020172 O                                           85 'ATION ERROR REPORT      '
1825009806020174 O          E            HEADE          1
1826000910230175 O***                    DL3                 73
1827000910230175 O***                    DL                  73
1828000910230175 O                       newmdy              73 '0  /  /    '
1829009806020176 O          E            HEADE          1
1830009806020177 O                                           67 'TRUST :'
1831009806020178 O                       LTRUST              71
1832009806020179 O          E            HEADE          1
1833009806020180 O                                           25 'PROGRAM NAME: RP170 '
1834009806020177 O                                           67 'SORT BY:'
1835009806020178 O                       OSORT               75
1836009806020181 O                                          120 'PAGE:'
1837000002010182 O                       PAGE3         Z    128
1838009806020183 O          E            HEADE          1
1839009806020184 O                                           14 'RUN DATE:'
1840009806020185 O                       UDATE         Y     25
184100030904     O                                           65 'PRINT WITHHOLD CARE ACCOUN'
184200150306     O                                           75 'T LETTERS:'
184300150306     O                       LLETA               77
1844009806020186 O                                          120 'TIME:'
1845000206270187 O                       rpgtime            128
1846009806020188 O          E            HEADE          1
1847009806020189 O                                           24 '""""""""""""""""""""""""'
1848009806020190 O                                           48 '""""""""""""""""""""""""'
1849009806020191 O                                           72 '""""""""""""""""""""""""'
1850009806020192 O                                           96 '""""""""""""""""""""""""'
1851009806020193 O                                          120 '""""""""""""""""""""""""'
1852009806020194 O                                          132 '""""""""""""'
1853009806020195 O          E            HEADE          1
1854009806020199 O                                           11 'ACCOUNT #'
1855009806020200 O                                           20 'ERROR'
1856009806030188 O          E            HEADE          2
1857009806030189 O                                           24 '""""""""""""""""""""""""'
1858009806030190 O                                           48 '""""""""""""""""""""""""'
1859009806030191 O                                           72 '""""""""""""""""""""""""'
1860009806030192 O                                           96 '""""""""""""""""""""""""'
1861009806030193 O                                          120 '""""""""""""""""""""""""'
1862009806030194 O                                          132 '""""""""""""'
1863009806020213 O          E            LINEE          1
1864009806020214 O                       KEYACC              12 '   -   -    '
1865009806020215 O               21                          34 'INVALID TRUST      '
186600150918
1867009812030215 O               61                          34 'INVALID PLAN       '
1868009812030215 O               61      MCPLAN              45
186900150918
1870009812030215 O               62                          34 'INVALID CARRIER    '
1871009812030215 O               62      PCARR               45
187200150918      * getrate error
1873001509220215 O               63      parmerr             50
1874001509180215 O               63                          +2 'EFF-'
1875001509210215 O               63      newymd              +1 '    /  /  '
1876001509180215 O               63                          +2 'CAR-'
1877001509180215 O               63      parmcar             +1
187800150921      * missing carrier
1879001509220215 O*              64                          41 'NO ACTIVE PLANS TO FIND CA'
1880001509220215 O*              64                          +0 'RRIER % REQUIRED, ACCOUNT '
1881001509220215 O*              64                          +0 'SKIPPED.'
1882001509220215 O*              64                          +2 'EFFDT='
1883001509220215 O*              64      newymd              +1 '    /  /  '
188400011025000000*0011111111112222222222333333333344444444445555555555666666666677777777778
188500011025123456*8901234567890123456789012345678901234567890123456789012345678901234567890
188600980226**
188700011025January
188800011025February
188900011025March
189000011025April
189100011025May
189200011025June
189300011025July
189400011025August
189500011026September
189600011025October
189700011025November
189800011025December
