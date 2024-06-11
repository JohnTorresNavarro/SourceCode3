000100020419     hdatedit(*ymd)  DFTACTGRP( *YES )
0002000204170002  ******************************************************************
0003000204170003  * RPF070     GROUP BENEFIT SERVICES SOFTWARE           1990      *
0004000204170004  *                                                                *
0005000204170005  *            WRITTEN BY - DAVID KETTERMAN                        *
0006000204170006  *            DATE - 07/27/90                                     *
0007000204170007  *                                                                *
0008000204170008  *  DESCRIPTION - THIS PROGRAM WILL PRODUCE ALL ENROLLMENT AND    *
0009000204170009  *                BILLING LETTERS - WELCOME TO GROUP, URGENT,     *
0010000204170010  *                AND LATE NOTICE.                                *
0011000204170018  *                                                                *
0012000204170018  * DLK 10/21/91 - REMOVED LATE NOTICES AND CHANGED URGENT LETTER  *
0013000204170018  *                TO X-FOOT ARRAY AND LOOK FOR 75% OF PREM.       *
0014000204170018  * MLF 04/30/97 - PAGE BREAK WITH ACODE  FOR URGENT LET-          *
0015000204170018  *                TERS.                                           *
001600020417      * DMA 02.18.98 - Changed name from Wendy P. to Carol F/          *
001700020417      * DMA 04.02.98 - changed hardcoding of "welcome" letter to 1st   *
001800020417      *                of month instead on 22nd                        *
001900020417      * DMA 04.13.98 - Changed Urgent letter to print AA name instead  *
002000020417      *                of manager name                                 *
002100020417      * DMA 08.06.98 - Added 'hardcoded' MedChi letter                 *
0022000204170010  *  Y2K CONVERT - 1998                                            *
0023000204170018  * DLK  5/12/99 - CONVERT TO RPG AND USE SELECTION LOGIC FROM     *
0024000204170012  *                RP170 (ACCTS PENDING CANCELLATION) FOR URGENT   *
0025000204170012  *                LETTERS                                         *
002600020417      * DLK 08/09/99 - IF ACCT IS IN INVEXC FILE, ADD 1 TO COVER THRU  *
002700020417      *                MONTH SO EFFDT OF SEARCH IS CORRECT             *
002800020417      * DLK 03/16/00 - remove medchi lettter. they will now use the    *
002900020417      *                origional GBS version.                          *
003000020417      * DLK 03/21/00 - Change welcome letter wording and convert to    *
003100020417      *                external printer file. also add new letter -    *
0032000204170012  *                admin kit                                       *
003300020417      * DLK 04/27/00 - Change payment/credit search to catch credit    *
003400020417      *                transaction that occur after the invoice on     *
0035000204170012  *                the same day                                    *
0036000204170020  * DLK 07/26/00 - compare adjustment effdt and invoice effdt in   *
0037000204170012  *                history search based on Year/Month only to      *
0038000204170012  *                include prorated adjustments.                   *
0039000204170020  * DLK 01/28/02 - Change the way urgent letters select the        *
0040000204170012  *                date to compare payments with. Now              *
0041000204170012  *                the date entered on the screen will be used for *
0042000204170012  *                all accounts (instead of covtdt - grace period).*
0043000204170012  *                Also exclude non billable trusts (C) and add    *
0044000204170012  *                error report for no invsum found.               *
0045000204170020  * DLK 02/07/02 - Change urgent and admin letter to use begin     *
0046000204170012  *                admin date instead of enroll date.              *
0047000204170012  *                                                                *
0048000204190020  * TWP 04/19/02 - ADDED TWO LABELS FOR ADMIN KIT                  *
0049000204230020  * TWP 04/23/02 - ELLIMINATED DUPLICATE LABELS IN URGENT LETTERS
005000020524      *  5/24/02 szz - Recompiled over new AACODE file                 *
0051000207050020  * DLK 07/05/02 - Change diary note to unique codes based on      *
0052000207050012  *                urgent letter changes. Also add urgent letter   *
0053000207120012  *                exclude file and write a copy of the history    *
0054000207120012  *                record to HISTWK so a query can list the accts  *
0055000207120012  *                the just received an urgent letter.             *
0056000304100020  * TWP 03/10/03 - NEW URGENT LETTER FORMAT RPF070P3
0057000304100020  * TWP 04/10/03 - CHANGED URGLETAA TO URGLETAA3
0058000309150020  * DLK 09/15/03 - Add DBE payment calc                            *
0059000309170015  * dlk 09/16/03 - "ADP" transactions will be considered a payment *
0060000312110015  * KSJ 12/11/03 - Changed pgm to move LY instead of ACVTYY        *
0061000312110015  *                into URGYEAR to reflect Month/Year entered      *
0062000312110015  *                on input screen.  This allows the correct       *
0063000312110012  *                Month and Year to be printed in first paragraph *
0064000312110012  *                of urgent letter                                *
0065000704230015  * dlk 04/23/07 - update payment calc so all use same formula     *
0066000706120015  *              - if sum of payments > 0 then add to total due    *
0067000706120015  *                and clear payment amount before calc pct paid   *
0068000910130015  * dlk 10/13/09 - exclude senior dental trusts                    *
0069001107270015  * dlk 07/27/11 - remove cc: sman name on urgent letter per       *
0070001107270012  *                request from admin.                             *
0071001207230015  * dlk 07/23/12 - do not print urgent letters with a balance      *
0072001207230012  *                < 11.00 per Cindy / Deborah Clark.              *
0073001310100015  * sbt 10/10/13 - Hist file expansion project                     *
007400131112      * 11/12/13 dlk - remove credits from payment formula
0075001502020015  * dlk 02/02/15 - remove 11.00 minimum for urgent letter per
0076001502020012  *                Admin / Finance.
0077001503110015  * dlk 03/06/15 - update for new urgent letter
0078001504220015  * dlk 04/22/15 - put back cc: sman name on urgent letter per
0079001504220012  *                request from admin.
0080001504280015  * dlk 04/28/15 - add urgnet letter hist file for reprint use
0081001509220015  * dlk 09/22/15 - convert to use getpaid instead of internal payment
0082001509220012  *                check logic. Due to issues with the accmst file
0083001509220012  *                being used against a work file in rpf070cl a
0084001509220012  *                seperate getpaidcl was needed to be called from this
0085001509220012  *                pgm that has special options to avoid sharing the
0086001509220012  *                existing open path and use the real f.accmst file
0087001509220012  *                instead.
008800160418      * 04/18/16 dlk - add blank remit date parm to getpaidcl
0089001802070015  * dlk 02/08/18 - exclude Advanced Mobile trusts
0090002001080015  * dlk 01/08/20 - exclude Care Service Management trusts
0091002104300015  * dlk 04/28/21 - New page segments and overlay for rebranding as
0092002104300012  *                ACA
0093002105030015  * dlk 05/03/21 - Note that let1 (Welcome) and Let2 (Admin kit) are
0094002105030012  *                not used from this program anymore so they have been
0095002105030012  *                disable in the CL / DDS.
0096002105040015  * dlk 05/04/21 - remove cc: sman name on urgent letter per
0097002105040012  *                request from admin (Cindy / Shelly).
0098002105130015  * dlk 05/13/21 - exclude CT trusts from letter per Deborah Clark
0099002208030015  * dlk 11/30/21 - longer aa email
0100002208030015  * jva 08.03.22 - Print exculdes only on second run - X001
0101002105030012  *
0102002105030012  *
0103001505080012  *                Page segment for urgent letter :
0104002104300012  * I:\MIS\AS400PageSegments\Urgent letters - RPF070\4-28-21 Urgent
0105002104300012  * letter\Urgltcf.prn (care first) and \UrgltNCF.prn (non care first)
0106002104300012  *                Letterhead Overlay: RPF070OL
0107001505080012  *
0108001505080012  *   *** Note - any changes to the urgent letter will need to be
0109001505080012  *              replicated in the urgent letter history file
0110001505080012  *              (if any variables change) and RPM020* which is the
0111001505080012  *              Urgent letter reprint program.
0112001505080012  *
0113000204170020  ******************************************************************
0114001509220021 FACCMST    IP   e             DISK
0115001107280023 FSMAN      IF   e           k DISK
011600000321     FAACODE    IF   e           K DISK
0117001310100018 FHIST      IF A F  216    10AIDISK    KEYLOC(1)
011800020131     Ftrsmst    IF   e           K DISK
011900020705     Fulexcl    IF   e           K DISK
012000020708     Fcodes     IF   e           K DISK
012100150423     Fgratex    if   e           K DISK
012200150422     Fmcovx     if   e           K DISK
012300150422     Fplnmst    if   e           K DISK
012400150422     Fcarmst    if   e           K DISK
0125001310100018 FHISTwk    o  A F  216        DISK
0126001504280018 Fulhist    o  A e             DISK
0127000303050027 FRPF070P   O    e             PRINTER
0128001107270027 FRPF070P3  O    e             PRINTER
0129000204170018 FQPRINT    O    F  132        PRINTER OFLIND(*INOE)
0130000204170011 FQSYSPRT   O    F  132        PRINTER
013100020422     F                                     FORMLEN(6)
013200020422     F                                     FORMOFL(6)
0133000204170011 FLBLG      O    F  132        PRINTER
013400020418     F                                     FORMLEN(18)
013500020418     F                                     FORMOFL(18)
0136000204170018 FBRKRLBL   O    F  132        PRINTER
013700990514     F                                     FORMLEN(6)
013800990514     F                                     FORMOFL(6)
013900150422
0140001504240020 D GARCF           S             15    DIM(20)
0141001504220020 D GARNOTCF        S             15    DIM(20)
0142001504240020 D GARWK           S             15    DIM(20)
0143000204230037 D N2_HOLD         S                   LIKE(N2)
014400000329     D has             C                   CONST('has been assigned as your')
014500000329     D may             C                   CONST('may be reached by phone at')
0146009102150037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
0147000207080037 D trcodeout       S              3
0148000207080037 D reason          S             30
0149000207080037 D rcout           S              6
0150001310100056 Dzero7            s              7  0
0151001310100056 Dhstrtime         s              8t
015200131025     D thispgmname     S             10a   inz('RPF070    ')
0153001503250037 D addialc         S             12
015400150422     D USA_DATE        S               D   DATFMT(*USA)
015500150428     D ISO_DATE        S               D   DATFMT(*ISO)
0156002208030037 D cfcarrier       S              1
0157000003210050 D                 DS
0158000003210051 D  keyacc                 1     10  0
0159000003210054 D  actrst                 1      3  0
0160000003210052 D  acsub#                 4      6  0
0161000003210053 D  acacct                 7     10  0
0162000003210050 D                 DS
0163000003210051 D  acvtdt                 1      8  0
0164000003210054 D  acvtyy                 1      4  0
0165000003210052 D  acvtmm                 5      6  0
0166000003210053 D  acvtdd                 7      8  0
0167000202070050 D                 DS
0168000202070051 D  gbsbdt                 1      8  0
0169000202070054 D  gbsbym                 1      6  0
0170000003210055 D                 DS
0171000003210056 D  BAL                    1    108  2
017200000321     D                                     DIM(12)
0173000003210056 D  BAL1                   1      9  2
0174000003210056 D  BAL2                  10     18  2
0175000003210056 D  BAL3                  19     27  2
0176000003210056 D  BAL4                  28     36  2
0177000003210056 D  BAL5                  37     45  2
0178000003210056 D  BAL6                  46     54  2
0179000003210056 D  BAL7                  55     63  2
0180000003210056 D  BAL8                  64     72  2
0181000003210056 D  BAL9                  73     81  2
0182000003210056 D  BAL10                 82     90  2
0183000003210056 D  BAL11                 91     99  2
0184000003210056 D  BAL12                100    108  2
0185009102150083 D                UDS
0186009905140085 D  USERID                 1     10
0187000003220085 D  LETTYP3               15     15
0188000003220085 D  LETTYP2               16     16
0189000003220085 D  LETTYP1               17     17
0190009811250084 D  LMDY                  18     25  0
0191009811250084 D  LMM                   18     19  0
0192009811250084 D  LMD                   18     21  0
0193009811250084 D  LY                    22     25  0
0194009610220085 D  LLABEL                30     30
0195000201310057 D  CONAME               201    240
019600000321     Iaccmsr
019700000321     I              aacode                      acod          L2
019800000321     I                                          smancd        L1
0199009905130042 IHIST      NS
0200009905130044 I                                 17   19  TRCODE
0201009905130045 I                             P   20   24 2TRAMT
0202000004280044 I                                 97   97  excinv
0203009905130044 I                                 98  101  TRNSRC
0204009905130044 I                                129  136 0TRDATE
0205000004270044 I                                137  144 0hinvdt
0206009905130044 I                                153  160 0HISEFF
0207000007270044 I                                153  158 0HISEFFym
0208000204170087
020900020417      * get aa name
021000150325     c                   clear                   aaname
021100150325     c                   clear                   aacontact
021200150422     C     AAKEY         CHAIN     AACODE
021300150422     c                   if        %found(aacode)
021400000321     C                   movel     afnam         aaname           30
021500000321     c                   cat       alnam:1       aaname
021600150325      * AA email and phone # field (AACONTACT)
021700150325     C                   EVAL      ADDIALC = %EDITW(ADDIAL:'   -   -    ')
021800150325     c                   eval      aacontact = %trim(aemla)
021900150325     C                   CAT       'or':1        aacontact
022000150325     C                   CAT       addialc:1     aacontact
022100150325     C                   CAT       '.':0         aacontact
022200000321     c                   end
022300150422
0224000204170108  * WELCOME TO GROUP LETTERS
0225000204170109
0226000003220110 C     LETTYP1       IFNE      ' '
0227009102150111 C                   EXSR      LET1
0228009102150113 C                   END
022900020417
0230000204170108  * admin kit LETTERS
0231000204170109
0232000003220110 C     LETTYP2       IFNE      ' '
0233000003220111 C                   EXSR      LET2
0234000003220113 C                   END
0235000204170123
0236000204170122  * URGENT LETTERS
0237000204170123
0238000003220110 C     LETTYP3       IFNE      ' '
023900990517     C   L2              MOVE      'Y'           NEWAA             1
0240009610220124 C     LLABEL        IFEQ      'B'
024100990525     C   L1              MOVE      'Y'           NEWLAB            1
0242009610220127 C                   END
0243009905170125 C                   EXSR      LET3
0244009102150127 C                   END
0245000204170128
0246009102150129 C     #END          TAG
0247000204170130
0248000204170131  ********************************************************************
0249000204170132  * WELCOME TO GROUP LETTERS                                         *
0250000204170133  ********************************************************************
0251009102150134 C     LET1          BEGSR
0252000204170137
0253000204170138  * select begin admin date = DATE SELECTION  (year/month)
0254000204170139
0255000202070140 C     GBSBym        IFEQ      LYM
0256000204170143
025700020207     C                   MOVE      gbsbdt        @DATIN
025800981125     C                   EXSR      #DATYM
025900020207     C                   MOVE      @DATOU        gbsMDY            8 0
026000020417
026100020417      * get sman name
026200020417
0263000003210165 C     SMANCD        CHAIN     SMAN                               19
0264000003210166 C  N19              EXSR      #NAME2
026500020417
026600020417      * create account address
026700020417
0268000003210144 C                   EXSR      #ADDR
026900000329
027000000329     c                   move      *blanks       aalinew
027100000329     c                   movel     aaname        aalinew
027200000329     c                   cat       may:1         aalinew
027300000329
027400020417
027500020417      * print welcome letter
027600020417
0277000003210146 C                   write     wellethed
027800000321
027900000321     c                   if        acnam2 <> *blanks
0280000003210146 C                   write     welleta1
028100000321     c                   end
028200000321
0283000003210146 C                   write     welleta2
028400000321
028500000321     c                   if        aaddr2 <> *blanks
0286000003210146 C                   write     welleta3
028700000321     c                   end
028800000321
028900211130     c                   clear                   aemlaout
029000211130     c                   movel     aemla         aemlaout
029100211130
0292000003210146 C                   write     wellet
029300000321
029400020708     c                   eval      trcodeout = 'U30'
029500131010     c                   eval      hstrtime = %time
029600990514     C   U1              EXCEPT    ADDHIS
029700000321
0298000003210142 C                   END
029900000321
0300009102150174 C                   ENDSR
0301000204170130
0302000204170131  ********************************************************************
0303000204170132  * admin kit LETTERS                                                *
0304000204170133  ********************************************************************
0305000003220134 C     LET2          BEGSR
0306000204170137
0307000204170138  * select begin admin date = DATE SELECTION
0308000204170139
0309000202070140 C     gbsbym        IFEQ      LYM
0310000204170143
031100020207     C                   MOVE      gbsbdt        @DATIN
031200000322     C                   EXSR      #DATYM
031300020207     C                   MOVE      @DATOU        gbsMDY            8 0
031400020417
031500020417      * get sman name
031600020417
0317000003220165 C     SMANCD        CHAIN     SMAN                               19
0318000003220166 C  N19              EXSR      #NAME2
031900020417
032000020417      * create account address
032100020417
0322000003220144 C                   EXSR      #ADDR
032300020417
0324000204170172  * print admin letter
0325000204170172
032600000322     c                   exsr      #name
032700000329
032800000329     c                   move      *blanks       aaline
032900000329     c                   movel     aaname        aaline
033000000329     c                   cat       has:1         aaline
033100000329
0332000003220146 C                   write     admlethed
033300000322
033400000322     c                   if        acnam2 <> *blanks
0335000003220146 C                   write     admleta1
033600000322     c                   end
033700000322
0338000003220146 C                   write     admleta2
033900000322
034000000322     c                   if        aaddr2 <> *blanks
0341000003220146 C                   write     admleta3
034200000322     c                   end
034300000322
034400000331     c                   move      *blanks       aemlaout
034500000331     c     aemla         cat       '.':0         aemlaout
034600000331
0347000003220146 C                   write     admlet
0348000004030146 C                   write     admlet2
0349000204170172
035000020708     c                   eval      trcodeout = 'U31'
035100131010     c                   eval      hstrtime = %time
035200000322     C   U1              EXCEPT    ADDHIS
035300020418
035400020418      * PRINT LABEL ON BROKER
035500020418
035600020418     C                   EXSR      #LABELS
035700020418     C                   EXSR      #LABELA
035800000322
0359000003220142 C                   END
036000000322
0361000003220174 C                   ENDSR
0362000204170175
0363000204170235  ********************************************************************
0364000204170236  * URGENT LETTERS                                                   *
0365000204170237  ********************************************************************
0366009102150238 C     LET3          BEGSR
0367000204170263
036800020417      * 5/99 NEW SELECTION LOGIC (MATCHES RP170 - ACCTS PENDING CANCEL)
0369000204170109
0370000204170109  * "NEWYMD" will now be filled with the date entered on the screen.
0371000204170109
0372000201300113 C                   MOVE      lymd          newymd            8 0
0373000204170115
0374000204170116  * CHECK ACCOUNT TO SEE IF THEY HAVE BEEN ENROLLED LONG ENOUGH
0375000204170117  * IF NOT - SKIP
0376000204170121
0377000201300122 C     NEWYMD        IFLT      ENROLL
0378001509220123 C                   leavesr
0379000201300124 C                   END
0380000204170085
0381000204170086  * SKIP non billable trusts (dltcd = C) and deleted trusts
0382002105130086  * and senior dental trusts (O N)
0383002105130086  * and Advanced Mobile trusts (O M)
0384002105130086  * and Care Services Management (O D)
0385002105130086  * and CT / EDT trusts (O W)
0386000204170087
0387000201310088 C     actrst        CHAIN     TRSMST
0388000201310096 C                   if        not %found(trsmst) or
0389000910130089 C                             trdltd = 'C' or trdltd = 'D' or
0390002001080089 C                             tscode = 'O N' or tscode = 'O M' or
0391002105130089 C                             tscode = 'O D' or tscode = 'O W'
0392001509220090 C                   leavesr
0393000201310091 C                   end
039400150922
039500150922      * 09/22/15 - convert to use GETPAID instead of internal payment logic.
039600150922     c                   exsr      #getpaid
039700150922
039800150922      * if account has paid enough or an error occured in the payment pgm
039900150922      * then skip remainning calcs
0400001509220152 C                   if        paymnt = 'Y' or
040100150922     c                             parmerr <> *blanks
040200150922     c                   leavesr
040300150922     c                   end
040400020417
040500020708      * if acct is in urgent letter exclude file, skip printing but still
040600020708      * write exclude history rec, U28 = acct run exclude,
040700220804      * U29 = broker run exclude
040800220804X001  * U86 = Letter Printed but NOT MAILED (excluded)
040900220803
041000220803X001  * If normal run, else print exludes
041100220803X001 C                   if        exclude = ' '
041200220803     c     tsakey        chain     ulexcl
041300220803     c                   if        %found(ulexcl)
0414000207080124 C                   if        llabel = 'B'
041500020708     c                   eval      trcodeout = 'U29'
041600020708     c                   else
041700020708     c                   eval      trcodeout = 'U28'
041800020708     c                   end
041900020708      * get reason description
042000020708     c     codekey       chain     codes
042100020708     c                   if        %found(codes)
042200020708     c                   movel     ldescr        reason
042300020708     c                   end
042400020708     c                   eval      rcout = 'RC=' + ulrcp + ulrc
042500020708
042600020708     c                   eval      *in43 = *on
042700131010     c                   eval      hstrtime = %time
042800030310     c   U1              except    addhis
042900020708     c                   eval      *in43 = *off
043000020708     c                   clear                   reason
043100020708     c                   clear                   rcout
043200150922     c                   leavesr
043300220803     c                   end
043400220803X001 c                   else
043500220803X001 c     tsakey        chain     ulexcl
043600220803X001 c                   if        not %found(ulexcl)
043700220803X001 c                   leaveSR
043800220803X001 c                   end
043900220804      * get reason description
044000220804X001 c                   eval      trcodeout = 'U86'
044100220804 |   c     codekey       chain     codes
044200220804 |   c                   if        %found(codes)
044300220804 |   c                   movel     ldescr        reason
044400220804 |   c                   end
044500220804 |   c                   eval      rcout = 'RC=' + ulrcp + ulrc
044600220804 |
044700220804 |   c                   eval      *in43 = *on
044800220804 |   c                   eval      hstrtime = %time
044900220804 |   c   U1              except    addhis
045000220804 |   c                   eval      *in43 = *off
045100220804 |   c                   clear                   reason
045200220804 |   c                   clear                   rcout
045300220803X001 c                   end
045400020708
0455009808060144 C                   EXSR      #ADDR
045600020417
045700020417      * PRINT BLANK PAGE ON AA CHANGE FOR AA SORT ONLY
045800020417
045900990517     C     LLABEL        IFEQ      'A'
046000990517     C     NEWAA         ANDEQ     'Y'
046100030410     C                   write     URGletaa3
046200990517     C                   MOVE      'N'           NEWAA
046300990517     C                   END
0464000204170308
046500000322
046600150422      * get sman name
046700210504     c                   clear                   smanout          32
0468001504220165 C     SMANCD        CHAIN     SMAN
046900150422     c                   if        %found(sman)
047000150422     c     sfname        cat       slname:1      smanout
047100150422     c                   end
047200150422
047300150422      * get all active group #'s seperated by care first and non care first
047400150422      * because there is a different letter for cf vs. non cf
047500150422     c                   exsr      #group#
047600020417
0477001505010020  * set address output lines
047800150501     c                   exsr      #setaddr
047900150422
048000150422     C* grace period end date for Care First (31 days after payment due date)
048100150422     C* so add 30 days to the 1st of the month date in lmdy                 )
048200150422     C                   MOVEL     lmdy          usa_date
048300150422     C                   ADDDUR    30:*d         usa_date
048400150422     C                   MOVE      usa_date      gracendt
048500150428     C                   MOVE      usa_date      iso_date
048600150428     C                   MOVE      iso_date      gracendtymd       8 0
048700150422
048800150423      * prepare trcode for history record
0489001504230124 C                   if        llabel = 'B'
049000150423     c                   eval      trcodeout = 'U27'
049100150423     c                   else
049200150423     c                   eval      trcodeout = 'U26'
049300150423     c                   end
049400150423
049500150423      * print care first letter and write hist
049600150423     c                   if        garcf(1) <> *blanks
049700150424     c                   move      garcf         garwk
049800150424     c                   exsr      #moveg#out
0499001504220146 C                   WRITE     ULVARCF
0500001504220307 C                   WRITE     ULPSCF
050100150423     C                   SETON                                            43
050200150424     c                   eval      reason = 'CARE FIRST'
050300150423     c                   eval      hstrtime = %time
050400150423     C   U1              EXCEPT    ADDHIS
050500150423     c                   clear                   reason
050600150428     C                   SETOFF                                           43
050700150428      * add urgent letter hist file - Care first letter
050800150430     c                   clear                   ulhistr
050900150428     c                   move      'C'           uhlet
051000150430     c                   move      gracendtymd   uhgracedt
051100150428     c                   exsr      #addulhist
051200150422     c                   end
051300000322
051400150423      * print non care first letter and write hist
051500150423     c                   if        garNOTcf(1) <> *blanks
051600150424     c                   move      garNOTcf      garwk
051700150424     c                   exsr      #moveg#out
0518001504220146 C                   WRITE     ULVARNCF
0519001504220307 C                   WRITE     ULPSNCF
052000150423     C                   SETON                                            43
052100150424     c                   eval      reason = 'OTHER CARRIERS'
052200150423     c                   eval      hstrtime = %time
052300150423     C   U1              EXCEPT    ADDHIS
052400150423     c                   clear                   reason
052500150423     C                   SETOFF                                           43
052600150428      * add urgent letter hist file - Non-Care first letter
052700150430     c                   clear                   ulhistr
052800150428     c                   move      'N'           uhlet
052900150428     c                   exsr      #addulhist
053000150422     c                   end
053100020417
0532009102150320 C                   ENDSR
0533000204170355
0534001509220103 C*******************************************************************
0535001509220104 C* call getpaidCL to get payment status for this acct/effdt/carrier *
0536001509220104 C* This program calls the CL instead of the RPG directly becuase    *
0537001509220104 C* of file override / open data path sharing problems.              *
0538001509220103 C*******************************************************************
053900150922     c     #getpaid      begsr
054000150922
0541001509220128 C                   clear                   MONPAY           10 2
0542001509220128 C                   clear                   CREDIT           10 2
0543001509220128 C                   clear                   debit            10 2
0544001509220128 C                   clear                   totinv            9 2
0545001509220128 C                   clear                   outbal            9 2
0546001509220128 C                   clear                   paymnt            1
054700150922
054800150922     c     grplist       plist
054900150922     c                   parm                    parmkey          10
055000160418     c                   parm                    parmremymd        8
055100150922     c                   parm                    parmeffymd        8
055200150922     c                   parm                    parmcar           3
055300150922     c                   parm                    parmupdate        1
055400150922     c                   parm                    parmpaid          1
055500150922     c                   parm                    parmerr          35
055600150922     c                   parm                    parminveb        10 2
055700150922     c                   parm                    parmpayments     10 2
055800150922     c                   parm                    parmcredits      10 2
055900150922     c                   parm                    parmdebits       10 2
056000150922
056100150922     c                   movel     keyacc        parmkey
056200160418     c                   move      *blanks       parmremymd
056300150922     c                   move      newymd        parmeffymd
056400150922      * urgent letters use 100% payment required so this special carrier
056500150922      * code is used to tell getpaid 100% instead of a real carrier code
056600150922     c                   move      '<a>'         parmcar
056700150922     c                   move      'N'           parmupdate
056800150922     c                   clear                   parmpaid
056900150922     c                   clear                   parmerr
057000150922     c                   clear                   parminveb
057100150922     c                   clear                   parmpayments
057200150922     c                   clear                   parmcredits
057300150922     c                   clear                   parmdebits
057400150922
057500150922      * ** this proram (RPF070) must call getpaidcl which has special file
057600150922      *    overrides instead of calling getpaid directly because the accmst
057700150922      *    file had an override conflict with the accmst overide in
057800150922      *    rpf070cl
057900150922     c                   call      'GETPAIDCL'   grplist
058000150922
058100150922      * if any error returned, print it
0582001509220361 C                   if        parmerr <> *blanks
058300150922     C                   if        firste = ' '
058400150922     C                   EXCEPT    HEADE
058500150922     C                   MOVE      'N'           FIRSTE            1
058600150922     C                   END
058700150922     C   oe              EXCEPT    heade
058800150922     C                   EXCEPT    linee
058900150922     c                   leavesr
059000150922     C                   END
059100150922
059200150922      * this is the actual Y/N payment decision returned
059300150922     c                   move      parmpaid      paymnt
059400150922
059500150922      * values from get paid
059600150922     c                   z-add     parminveb     totinv
0597001509220137 c                   z-add     parmcredits   credit
0598001509220137 c                   z-add     parmdebits    debit
0599001509220137 c                   z-add     parmpayments  monpay
060000150922
060100150922      * calculated value needed for this program not returned from get paid
060200150922     c                   eval      outbal = totinv + monpay
060300150922
060400150922     c                   endsr
060500150922
0606001504220164 C*************************************************************
0607001505010164 C* set address lines for output
0608001504220164 C*************************************************************
060900150501     C     #setaddr      BEGSR
061000150501     c                   clear                   aline1
061100150501     c                   clear                   aline2
061200150501     c                   clear                   aline3
061300150501     c                   clear                   aline4
061400150501     c                   clear                   aline5
061500150501     c                   clear                   aline6
061600150501
061700150501     c                   if        ecntac <> *blanks
061800150501     c                   movel     ecntac        aline1
061900150501     c                   else
062000150501     c                   movel     contac        aline1
062100150501     c                   end
062200150501
062300150501     c                   movel     acnam1        aline2
062400150501      * no name2, no addr2
062500150501     c                   if        acnam2 = *blanks and aaddr2 = *blanks
062600150501     c                   movel     aaddr1        aline3
062700150501     c                   movel     al            aline4
062800150501     c                   end
062900150501      * no name2, yes addr2
063000150501     c                   if        acnam2 = *blanks and aaddr2 <> *blanks
063100150501     c                   movel     aaddr1        aline3
063200150501     c                   movel     aaddr2        aline4
063300150501     c                   movel     al            aline5
063400150501     c                   end
063500150501      * yes name2, no addr2
063600150501     c                   if        acnam2 <> *blanks and aaddr2 = *blanks
063700150501     c                   movel     acnam2        aline3
063800150501     c                   movel     aaddr1        aline4
063900150501     c                   movel     al            aline5
064000150501     c                   end
064100150501      * yes name2, yes addr2
064200150501     c                   if        acnam2 <> *blanks and aaddr2 <> *blanks
064300150501     c                   movel     acnam2        aline3
064400150501     c                   movel     aaddr1        aline4
064500150501     c                   movel     aaddr2        aline5
064600150501     c                   movel     al            aline6
064700150501     c                   end
064800220808
064900220808X001 C                   if        exclude = 'Y'
065000220812 |   C                   if        %trim(ALINE5) <> *blanks
065100220812 |   C                   eval      ALINE5 = %replace ( ' **': ALINE5 :38:3)
065200220812X001 C                   else
065300220812 |   C                   eval      ALINE4 = %replace ( ' **': ALINE4 :38:3)
065400220812X001 C                   end
065500220808X001 C                   end
065600150501
0657001505010320 C                   ENDSR
065800150501
0659001505010164 C*************************************************************
0660001505010164 C* add urgent letter hist file
0661001505010164 C*************************************************************
066200150501     C     #addulhist    BEGSR
066300150428     c                   move      actrst        uhtrust
066400150428     c                   move      acsub#        uhsub
066500150428     c                   move      acacct        uhacct
066600150428     c                   move      *date         uhtrdate
066700150428     c                   move      hstrtime      uhtrtime
066800150428     c                   movel     userid        uhuser
066900150428     c                   z-add     outbal        uhbal
067000150428     c                   movel     grp#out1      uhg#1
067100150428     c                   movel     grp#out2      uhg#2
067200150428     c                   move      lymd          uheffdt
067300150501     c                   movel     aline1        uhaline1
067400150501     c                   movel     aline2        uhaline2
067500150501     c                   movel     aline3        uhaline3
067600150501     c                   movel     aline4        uhaline4
067700150501     c                   movel     aline5        uhaline5
067800150501     c                   movel     aline6        uhaline6
067900150501     c                   movel     aacontact     uhaacon
068000150501     c                   movel     aaname        uhaaname
068100150501     c                   movel     smanout       uhsmanout
068200150501
068300150428     c                   write     ulhistr
068400150428     C                   endsr
068500150422
0686001504280164 C*************************************************************
0687001504280164 C* get all active group #'s for this acct and store them
0688001504280164 C*************************************************************
068900150428     C     #group#       BEGSR
069000150428
069100150422     c                   clear                   garcf
069200150422     c                   clear                   garnotcf
069300150422
069400150422      * read all active mcov
069500150422     c     tsakey        setll     mcovx
069600150422     c                   dou       %eof(mcovx)
069700150422     c     tsakey        reade     mcovx
069800150422     c                   if        not %eof(mcovx) and candt = 0
069900150422
070000150422      * get plnmst for carrier code
070100150422     c     tspkey        chain     plnmst
070200150422     c                   if        %found(plnmst)
070300150422      * get carmst to know if this is a care first carrier or not
070400150422     c                   eval      cfcarrier = 'N'
070500150422     c     pcarr         chain     carmst
070600150422     c                   if        %found(carmst)
070700150422     c                   if        carbc = 'D'
070800150422     c                   eval      cfcarrier = 'Y'
070900150422     c                   end
071000150422      * carrier not found - skip it
071100150422     c                   else
071200150422     c                   iter
071300150422     c                   end
071400150422
071500150422      * find group #
071600150422     c     tspackey      setll     gratex
071700150422     c                   dou       %eof(gratex)
071800150422     c     tspackey      reade     gratex
071900150422     c                   if        not %eof(gratex) and
072000150422     c                             (newymd >= frmdat and
072100150422     c                              newymd <= todat)
072200150422      * store group #
072300150422     c                   exsr      #storeg#
072400150422     c                   leave
072500150422     c                   end
072600150422     c                   enddo
072700150422
072800150422     c                   end
072900150422     c                   end
073000150422     c                   enddo
073100150422
073200150422     c                   endsr
073300150422
0734001504220164 C*************************************************************
0735001504220164 C* store this group #                                        *
0736001504220164 C*************************************************************
073700150422     C     #storeg#      BEGSR
073800150422
073900150422     C                   Z-ADD     1             X                 2 0
074000150422      * check each array value to see if this group# has already been
074100150422      * stored
074200150422     c                   if        cfcarrier <> 'Y'
074300150422     c                   goto      #notcf
074400150422     c                   end
074500150422
074600150422      **********************
074700150422      * care first group #
074800150422      **********************
074900150422     C                   dou       x > 20
075000150422      * if this arrary value is blank, add the group # and leave
075100150422     c                   if        garcf(x) = *blanks
075200150422     C                   MOVEL     GROUP#        garcf(X)
075300150422     C                   leave
075400150422     C                   ELSE
075500150422      * non blank value - group # is already there, leave
075600150422     c                   if        garcf(x) = group#
075700150422     C                   leave
075800150422     C                   ELSE
075900150422      * its not there, check next element of array
076000150422     C                   ADD       1             X
076100150422     C                   end
076200150422
076300150422     C                   end
076400150422     C                   enddo
076500150422
076600150422     c                   leavesr
076700150422
076800150422      **************************
076900150422      * non care first group #
077000150422      **************************
077100150422     c     #notcf        tag
077200150422     C                   dou       x > 20
077300150422      * if this arrary value is blank, add the group # and leave
077400150422     c                   if        garNOTcf(x) = *blanks
077500150422     C                   MOVEL     GROUP#        garNOTcf(X)
077600150422     C                   leave
077700150422     C                   ELSE
077800150422      * non blank value - group # is already there, leave
077900150422     c                   if        garNOTcf(x) = group#
078000150422     C                   leave
078100150422     C                   ELSE
078200150422      * its not there, check next element of array
078300150422     C                   ADD       1             X
078400150422     C                   end
078500150422
078600150422     C                   end
078700150422     C                   enddo
078800150422
078900150422     c                   endsr
079000150422
079100150422      ******************************************************************
079200150424      * move all group#'s to output fields
079300150422      ******************************************************************
0794001504240356 C     #moveg#out    BEGSR
079500150424
079600150424     c                   clear                   grp#out1
079700150424     c                   clear                   grp#out2
079800150424     c                   move      '1'           oneortwo          1
079900150424     c                   move      'Y'           firstone          1
080000150424     c                   clear                   lastpos           2 0
080100150424     c                   clear                   remain            2 0
080200150422
080300150424     c                   do        20            xx                2 0
080400150424     c                   if        garwk(xx) <> *blanks
080500150424
080600150424     C                   if        firstone = 'Y'
0807001504240066 C                   MOVEL     garwk(xx)     GRP#out1         70
0808001504240066 C                   clear                   firstone
080900150424     c                   iter
081000150424     c                   end
081100150424
081200150424      * first or second line
081300150424     c                   if        oneortwo = '1'
081400150424     c                   eval      lastpos = %checkr(' ':grp#out1)
081500150424     c                   else
081600150424     c                   eval      lastpos = %checkr(' ':grp#out2)
081700150424     c                   end
081800150424
081900150424     c                   eval      remain = 70 - (lastpos +2)
082000150422
082100150424      * add another group # if it will fit
082200150424     C                   if        remain >= %len(%trim(garwk(xx)))
082300150424     c                   if        oneortwo = '1'
082400150422     C                   CAT       ',':0         GRP#out1
082500150424     C                   CAT       garwk(xx):1   GRP#out1
082600150424     c                   else
082700150424     C                   CAT       ',':0         GRP#out2
082800150424     C                   CAT       garwk(xx):1   GRP#out2
082900150424     c                   end
083000150424
083100150424      * if there was not enough room in line 1 then fill first g# in
083200150424      * grp#out2
083300150424     c                   else
083400150424     c                   if        oneortwo = '1'
0835001504240066 C                   MOVEL     garwk(xx)     GRP#out2         70
083600150424     c                   move      '2'           oneortwo          1
083700150424     c                   end
083800150424
083900150424     c                   end
084000150422
084100150422     C                   end
084200150422     C                   enddo
084300150422
084400150422     c                   endsr
084500150422
084600150422
084700150422
0848000204170351  ****************************************************************
0849000204170352  *    AL = CITY, ST  ZIP+4                                      *
0850000204170354  ****************************************************************
0851000204170355
0852009102150356 C     #ADDR         BEGSR
085300000321
085400000321     C                   MOVE      *blanks       AL               31
085500000321     C                   MOVEL     acity         AL
085600000321     C                   CAT       ',':0         AL
085700000321     C                   CAT       aSTATE:1      AL
085800000321     C                   MOVEL     azip          ZIP5              5
085900000321     C                   MOVE      azip          ZIP4              4
086000000321     C                   CAT       ZIP5:1        AL
086100000321     C     ZIP4          IFNE      '0000'
086200000321     C                   CAT       '-':0         AL
086300000321     C                   CAT       ZIP4:0        AL
086400000321     C                   END
086500000321
0866000003210394 C                   ENDSR
0867000204170395  ****************************************************************
0868000204170396  * ROUTINE FOR NAME LINE  "DEAR XXXX XXXXX:"                    *
0869000204170397  ****************************************************************
0870009102150398 C     #NAME         BEGSR
0871000204170399
0872000003210402 C                   MOVE      *BLANKS       N                33
087300000321     c                   movel     contac        n
087400000321     c                   cat       ':':0         n
0875009102150416 C                   ENDSR
0876000204170417  ****************************************************************
0877000204170418  * ROUTINE FOR NAME LINE 2 - SALESMAN NAME                      *
0878000204170419  ****************************************************************
0879009102150420 C     #NAME2        BEGSR
088000000321
0881000003210424 C                   MOVE      *BLANKS       N2               31
0882000003210424 C                   MOVEl     sfname        N2
088300000321
0884009102150436 C     SMI           IFNE      ' '
088500000321     C                   CAT       sMI:1         N2
088600000321     C                   CAT       '.':0         N2
0887009102150441 C                   END
0888000204170442
088900000321     C                   CAT       sLNAME:1      N2
0890009102150445 C                   ENDSR
0891000204170647  ****************************************************************
0892000204170648  * ROUTINE FOR PRINTING LABELS - 1 PER BROKER                   *
0893000204170649  ****************************************************************
0894009610220650 C     #LABEL        BEGSR
0895000204170036
0896000204170037  * SET LEADER LABEL - FIRST TIME ONLY
0897000204170038
0898009610220039 C     FIRSTL        IFNE      'N'
0899009610220040 C                   MOVE      'N'           FIRSTL            1
0900009610220041 C                   EXCEPT    HEADER
0901009610220042 C                   END
090200000321
090300000321     C                   MOVE      *blanks       AL2              30
090400000321     C                   MOVEL     scity         AL2
090500000321     C                   CAT       ',':0         AL2
090600000321     C                   CAT       SSTATE:1      AL2
090700020417     C                   MOVEL     szipcd        ZIP5
090800020417     C                   MOVE      szipcd        ZIP4
090900000321     C                   CAT       ZIP5:1        AL2
091000000321     C     ZIP4          IFNE      '0000'
091100000321     C                   CAT       '-':0         AL2
091200000321     C                   CAT       ZIP4:0        AL2
091300000321     C                   END
091400000321
0915009905120052 C                   EXCEPT    LAB
0916000204170045
091700961022     C                   ENDSR
0918000204170649  ****************************************************************
0919000204170650 C     #LABELS       BEGSR
0920000204170036
0921000204170037  * SET LEADER LABEL - FIRST TIME ONLY
0922000204170038
0923000204180039 C     FIRSTLS       IFNE      'N'
0924000204180040 C                   MOVE      'N'           FIRSTLS           1
0925000204170041 C                   EXCEPT    HEADERS
0926000204170042 C                   END
092700020417
0928000204170424 C                   MOVE      *BLANKS       N2S              31
0929000204170424 C                   MOVEl     Sfname        N2S
093000020417
0931000204170436 C     SMI           IFNE      ' '
093200020417     C                   CAT       SMI:1         N2S
093300020417     C                   CAT       '.':0         N2S
0934000204170441 C                   END
0935000204170442
093600020417     C                   CAT       SLNAME:1      N2S
093700020417
093800020417     C                   MOVE      *blanks       AL2S             30
093900020417     C                   MOVEL     scity         AL2S
094000020417     C                   CAT       ',':0         AL2S
094100020417     C                   CAT       SSTATE:1      AL2S
094200020417     C                   MOVEL     szipcd        ZIP5S             5
094300020417     C                   MOVE      szipcd        ZIP4S             4
094400020417     C                   CAT       ZIP5S:1       AL2S
094500020417     C     ZIP4S         IFNE      '0000'
094600020417     C                   CAT       '-':0         AL2S
094700020417     C                   CAT       ZIP4S:0       AL2S
094800020417     C                   END
094900020417
0950000204170052 C                   EXCEPT    LABS
0951000204170045
095200020417     C                   ENDSR
0953000204170649  ****************************************************************
0954000204170650 C     #LABELA       BEGSR
0955000204170036
0956000204170037  * SET LEADER LABEL - FIRST TIME ONLY
0957000204170038
0958000204180039 C     FIRSTLA       IFNE      'N'
0959000204180040 C                   MOVE      'N'           FIRSTLA           1
0960000204170041 C                   EXCEPT    HEADERA
0961000204170042 C                   END
096200020417
0963000204170424 C                   MOVE      *BLANKS       N2A              31
0964000204170424 C                   MOVEl     ACNAM1        N2A
096500020417
096600020417     C                   MOVE      *blanks       AL2A             30
096700020417     C                   MOVEL     Acity         AL2A
096800020417     C                   CAT       ',':0         AL2A
096900020417     C                   CAT       ASTATE:1      AL2A
097000020417     C                   MOVEL     Azip          ZIP5A             5
097100020417     C                   MOVE      Azip          ZIP4A             4
097200020417     C                   CAT       ZIP5A:1       AL2A
097300020417     C     ZIP4A         IFNE      '0000'
097400020417     C                   CAT       '-':0         AL2A
097500020417     C                   CAT       ZIP4A:0       AL2A
097600020417     C                   END
097700020417
0978000204170052 C                   EXCEPT    LABA
0979000204170045
098000020417     C                   ENDSR
0981000204170107
0982000204170103  ***************************************************
0983000204170104  * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0984000204170105  ***************************************************
0985000204170107
0986000204170107  * DATE IN  = @DATIN (8.0) YYYYMMDD
0987000204170107  * DATE OUT = @DATOU (8.0) MMDDYYYY
0988000204170107
0989009811250106 C     #DATYM        BEGSR
099000981125     C                   MOVE      @DATIN        @MD               4 0
099100981125     C                   MOVEL     @DATIN        @Y                4 0
099200981125     C                   MOVEL     @MD           @DATOU            8 0
099300981125     C                   MOVE      @Y            @DATOU
099400981125     C                   MOVE      *ZEROS        @DATIN            8 0
0995009811250120 C                   ENDSR
099600020417
099700020417
0998001502180103  ***************************************************
099900990513     C     *INZSR        BEGSR
100000220803
100100220804X001 C     *Entry        plist
100200220804X001 C                   parm                    exclude           1
100300020417
1004000201310089 C                   time                    time              6 0
1005009905130089 C                   MOVE      'Y'           FIRST             1
100600990513     C                   Z-ADD     0             ZERO9             9 0
100700131112     C                   Z-ADD     0             ZERO8             8 0
100800000321     C                   Z-ADD     0             ZERO2             2 0
100900990513     C                   MOVEL     LY            LYMD              8 0
101000990513     C                   MOVE      LMD           LYMD
101100020207     C                   MOVEl     Lymd          LYM               6 0
1012001509220092
1013000204170323  * FIRST DATE LINE - LETTER DATE
101400000321
1015000003210329 C                   MOVE      *BLANKS       DL               19
1016000003210331 C                   MOVE      *MONTH        um                2 0
1017000003210331 C                   MOVE      *DAY          DAYC              2
1018000003210331 C                   MOVE      *YEAR         YEARC             4
1019000003210332 C                   MOVEL     YR(um)        DL
102000000321     C                   CAT       DAYC:1        DL
102100000321     C                   CAT       ',':0         DL
102200000321     C                   CAT       YEARC:1       DL
102300020417
102400000321     C     subkey        KLIST
102500000321     C                   KFLD                    actrst
102600000321     C                   KFLD                    acsub#
102700020417
102800020708     C     codekey       KLIST
102900020708     C                   KFLD                    ulrcp
103000020708     C                   KFLD                    ulrc
103100020417
103200030915     C     tsakey        KLIST
103300020708     C                   KFLD                    actrst
103400020708     C                   KFLD                    acsub#
103500020708     C                   KFLD                    acacct
103600030915
103700150422     C     tspkey        KLIST
103800150422     C                   KFLD                    MCTRST
103900150422     C                   KFLD                    MCSUB#
104000150422     C                   KFLD                    MCPLAN
104100150422
104200150422     C     tspackey      KLIST
104300150422     C                   KFLD                    MCTRST
104400150422     C                   KFLD                    MCSUB#
104500150422     C                   KFLD                    MCPLAN
104600150422     C                   KFLD                    MCageb
104700150422     C                   KFLD                    MCovtp
104800150422
104900150422
105000000321     C     AAKEY         KLIST
105100000321     C                   KFLD                    ACOD
105200000321     C                   KFLD                    ZERO2             2 0
105300020417
1054009905130120 C                   ENDSR
1055009705190278 OHIST      EADD         ADDHIS
1056009705190279 O                       KEYACC              10
1057000207080284 O                       trcodeout           19
1058009705190285 O                       ZERO9               24P
1059000207080286 O                       reason              55
1060000207080286 O               43                          59 'DUE:'
1061009905140286 O               43      OUTBAL        L     72
1062000207080286 O                       rcout               85
106300040615     O                                           90 '00'
106400131025     O                       thispgmname        107
106500131025     O                                          108 ' '
1066009705190292 O                       KEYACC             119
106700131112     o                       zero8              127
1068009705190294 O                                          128 'A'
1069000003220281 O                       *date              136
1070001311120281 O                       zero8              144
1071001311120281 O                       zero8              152
1072000201300289 O                       LYMD               160
1073001310100293 O                       zero9              184
1074001310100293 O                       zero7              191
1075001310100293 O                       hstrtime           199
1076001310100293 O                       zero7              206
1077001310140293 O                       userid             216
107800020712
107900020712      * copy of hist in qtemp for report of leters produced
1080000207120278 OHISTwk    EADD         ADDHIS
1081000207120279 O                       KEYACC              10
1082000207120284 O                       trcodeout           19
1083000207120285 O                       ZERO9               24P
1084000207120286 O                       reason              55
1085000207120286 O               43                          59 'DUE:'
1086000207120286 O               43      OUTBAL        L     72
1087000207120286 O                       rcout               85
108800040615     O                                           90 '00'
108900131025     O                       thispgmname        107
109000131025     O                                          108 ' '
1091000207120292 O                       KEYACC             119
109200131112     o                       zero8              127
1093000207120294 O                                          128 'A'
1094000207120281 O                       *date              136
1095001311120281 O                       zero8              144
1096001311120281 O                       zero8              152
1097000207120289 O                       LYMD               160
1098001310100293 O                       zero9              184
1099001310100293 O                       zero7              191
1100001310100293 O                       hstrtime           199
1101001310100293 O                       zero7              206
1102001310140293 O                       userid             216
1103000201310166 Oqprint    E            HEADE          2 03
1104000201310167 O                                           45 '*****'
1105000201310168 O                       CONAME              85
1106000201310169 O                                           91 '*****'
1107000201310170 O          E            HEADE          1
1108000201310171 O                                           73 'URGENT LETTER ERROR REPO'
1109000207080172 O                                           75 'RT'
1110000201310179 O          E            HEADE          1
1111000201310180 O                                           25 'PROGRAM NAME: RPF070'
1112000201310175 O                       lmdy                70 '  /  /    '
1113000201310181 O                                          120 'PAGE:'
1114000201310182 O                       PAGE          Z    128
1115000201310183 O          E            HEADE          1
1116000201310184 O                                           14 'RUN DATE:'
1117000201310185 O                       *month              17
1118000201310185 O                                           18 '/'
1119000201310185 O                       *day                20
1120000201310185 O                                           21 '/'
1121000201310185 O                       *year               25
1122000201310186 O                                          120 'TIME:'
1123000201310187 O                       TIME               128 '  :  :  '
1124000201310188 O          E            HEADE          1
1125000201310189 O                                           24 '""""""""""""""""""""""""'
1126000201310190 O                                           48 '""""""""""""""""""""""""'
1127000201310191 O                                           72 '""""""""""""""""""""""""'
1128000201310192 O                                           96 '""""""""""""""""""""""""'
1129000201310193 O                                          120 '""""""""""""""""""""""""'
1130000201310194 O                                          132 '""""""""""""'
1131000201310195 O          E            HEADE          1
1132000201310199 O                                           11 'ACCOUNT #'
1133000201310200 O                                           20 'ERROR'
1134000201310188 O          E            HEADE          2
1135000201310189 O                                           24 '""""""""""""""""""""""""'
1136000201310190 O                                           48 '""""""""""""""""""""""""'
1137000201310191 O                                           72 '""""""""""""""""""""""""'
1138000201310192 O                                           96 '""""""""""""""""""""""""'
1139000201310193 O                                          120 '""""""""""""""""""""""""'
1140000201310194 O                                          132 '""""""""""""'
114100150922      * getrate error
1142000201310213 O          E            LINEE          1
1143000201310214 O                       KEYACC              12 '   -   -    '
114400150922     O                       parmerr             50
114500150922     O                                           +2 'EFF-'
114600150922     O                       newymd              +1 '    /  /  '
114700150922     O                                           +2 'CAR-'
114800150922     O                       parmcar             +1
114900150922
115000020417     OQSYSPRT   E            HEADER         1 01
1151000204170105 O                                           26 '*'
1152000204170106 O                                           25 '************************'
1153000204170107 O                                           29 '****'
1154000204170108 O          E            HEADER         1
1155000204170109 O                                            3 '**'
1156000204170110 O                                           27 'URGENT LETTER LABELS    '
1157000204170111 O                                           29 '**'
1158000204170112 O          E            HEADER         1
1159000204170113 O                                            2 '*'
1160000204170114 O                       USERID              15
1161000204170115 O                                           26 'RPF070'
1162000204170116 O                                           29 '*'
1163000204170117 O          E            HEADER         1
1164000204170118 O                                           25 '************************'
1165000204170119 O                                           29 '****'
1166000204170120 O          E            LAB            1 01
1167000204170123 O                       N2                  31
1168000204170124 O          E            LAB            1
1169000204170125 O                       SADDR               30
1170000204170126 O          E            LAB            1
1171000204170127 O                       AL2                 30
117200020418     OLBLG      E            HEADERA        1 09
1173000204170105 O                                           26 '*'
1174000204170106 O                                           25 '************************'
1175000204170107 O                                           29 '****'
1176000204180108 O          E            HEADERA        1
1177000204170109 O                                            3 '**'
1178000204170110 O                                           27 'ADMIN KIT LABELS    '
1179000204170111 O                                           29 '**'
1180000204180112 O          E            HEADERA        1
1181000204170113 O                                            2 '*'
1182000204170114 O                       USERID              15
1183000204170115 O                                           26 'RPF070'
1184000204170116 O                                           29 '*'
1185000204180117 O          E            HEADERA        1
1186000204170118 O                                           25 '************************'
1187000204170119 O                                           29 '****'
1188000204180120 O          E            LABA           1 09
1189000204180123 O                       N2A                 31
1190000204180124 O          E            LABA           1
1191000204180125 O                       AADDR1              30
1192000204180126 O          E            LABA           1
1193000204180127 O                       AL2A                30
1194000204180126 O          E            LABA           1
1195000204180119 O                                           10 'ATTENTION:'
1196000204180126 O          E            LABA           1
1197000204180127 O                       CONTAC              30
119800020418     OBRKRLBL   E            HEADERS        1 01
1199000204170105 O                                           26 '*'
1200000204170106 O                                           25 '************************'
1201000204170107 O                                           29 '****'
1202000204180108 O          E            HEADERS        1
1203000204170109 O                                            3 '**'
1204000204170110 O                                           27 'ADMIN KIT BROKER LABELS '
1205000204170111 O                                           29 '**'
1206000204180112 O          E            HEADERS        1
1207000204170113 O                                            2 '*'
1208000204170114 O                       USERID              15
1209000204170115 O                                           26 'RPF070'
1210000204170116 O                                           29 '*'
1211000204180117 O          E            HEADERS        1
1212000204170118 O                                           25 '************************'
1213000204170119 O                                           29 '****'
1214000204180120 O          E            LABS           1 01
1215000204180123 O                       N2S                 31
1216000204180124 O          E            LABS           1
1217000204180125 O                       SADDR               30
1218000204180126 O          E            LABS           1
1219000204180127 O                       AL2S                30
122000910215**
122100910215January
122200910215February
122300910215March
122400910215April
122500910215May
122600910215June
122700910215July
122800910215August
122900910215September
123000910215October
123100910215November
123200910215December
