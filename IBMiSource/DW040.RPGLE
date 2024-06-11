0001001509280015  ******************************************************************
000200150928      * DW040          Group Benefit Services, Inc.
000300150928      *
000400150928      *    WRITTEN BY - DAVID KETTERMAN
000500150928      *    DATE       - 07/21/00
000600150928      *
000700150928      * This is the carrier remittance for all carriers (as of 9/28/15).
000800150928      * There are no longer seperate remittance programs for DBE & Alt
000900150928      * carriers. DW260 was retired since it was mostly identical to DW040
001000150928      * with the only difference being which invdetl3 file it reads and
001100150928      * which bcrec file it writes to. The seperate CL's (DW260CL and
001200150928      * DW040CL will override these files to the ones needed for each
001300150928      * run.
001400970620     F*
001500000721     F* 07/21/00 DLK - Create new ABR process for Other carriers. This
001600000721     F*                version differs in the payment calculation in that
001700000919     F*                the % paid by the account must meet the % determined
001800000919     F*                for each carrier. The same formula as acct
001900000727     F*                cancel / withhold care and urgent letter is used
002000000919     F*                for the payment %. No output file is created for this
002100000727     F*                run of Other carriers.
002200000919     F*                Change sort / break so carrier comes after idcvdt
002300000915     F*                (only YYYYMM part of idcvdt) to support different
002400000919     F*                percents of payment per carrier. OPNQRYF would not
002500000919     F*                work so a logical was created and is used as
002600000919     F*                input that already does selection of IDBCCC = "O"
002700000919     F*                and IDPAID = 0.
002800001011     F*                Change group # in invdet to 15
002900001011     F*
003000010119     F* 01/19/01 SSK - CHANGE RECORD LENGTH FROM 64 TO 91 FOR CMCT14
003100010212     F* 01/31/01 DLK - add output to invdwk, this will be used in the  *
0032000101310015 F*                commission run                                  *
003300010212     F* 02/12/01 DLk - add another override to the payment check...    *
003400010212     F*                if acct is cancelled and has a 0 or credit      *
003500010212     F*                balance consider it paid                        *
003600010309     F* 03/08/01 KSJ - Added IDBAMT to CR132                           *
003700010410     F* 04/09/01 DLK - add day compare to member count to fix mid      *
003800010410     F*                month cancel calculation.                       *
003900010417     F* 04/17/01 DLK - change member count calc again.                 *
004000010823     F* 08/23/01 DLK - change Kaiser (KP ) to 100% payment required    *
004100010823     F*                (finance request).                              *
004200010906     F* 09/06/01 DLK - change ALL carriers except MF & KP to 85%       *
004300010906     F*                payment required.                               *
004400020201     F* 02/01/02 DLK - add market size to cr132                        *
004500030409     F* 04/09/03 DLK - add sman relid to cr132                         *
004600030430     F* 04/30/03 DLK - add code to support new commisison method...    *
004700030430     F*                (write to otrec file).                          *
004800030814     F* 08/14/03 DLK - exclude tr50 (plan change) credits from payment *
004900030814     F*                calc                                            *
0050000407070015  * 07/07/04 dlk - change cmct14 search to use actual transaction   *
0051000407070015  *                effective date instead of the 1st of the month   *
005200050620      * 06/20/05 DLK - change carrier BEN and BG  to 100% payment      *
005300050622      * 06/22/05 DLK - change carrier HR  to 100% payment              *
005400051017      * 10/17/05 DLK - change carrier BEN to 80% payment               *
0055000603020015  * 03/02/06 dlk - Add life volume (benefit amt) to OTREC          *
0056000607180015  * 07/18/06 dlk - change hard coded payment % to new field in     *
0057000607180015  *                carrier master file.                            *
0058000704160015  * 04/16/07 dlk - add ADP trcode to payment calc to match DBE     *
0059000704170015  *              - remove "pay first month" rule  to match DBE     *
0060000706120015  *              - if sum of payments > 0 then add to total due    *
0061000706120015  *                and clear payment amount before calc pct paid   *
0062000708280015  * 08/28/07 dlk - change to find market size by transaction       *
0063000708280015  *                effdt instead of run effdt.                     *
0064000801220015  * 01/22/08 dlk - change nseq# to start at 4 million instead of 3 *
0065000802050015  * 02/05/08 dlk - changes to allow new transactions in the late   *
0066000802050015  *                pay (all will run as an original run now)       *
0067000807180015  * 07/18/08 dlk - convert non pay report to use npayhis file      *
0068000808130015  * 08/13/08 dlk - write all accts to rpayhis file (not just non   *
0069000808130015  *                pays)                                           *
0070000901020015  * 01/02/09 dlk - find primary broker instead of the 1st broker   *
0071000812150015  *                (when there is a split)                         *
0072000905140015  * 05/14/09 dlk - do not include employer billed subsidy plans in *
0073000905140035  *                the contract count.                             *
0074000906150015  * 06/15/09 dlk - add abrcode "S" (starting seq#)                 *
0075001007130015  * 07/13/10 dlk - increase field sizes for payment calc           *
007600131003      * 10/03/13 dlk - hist file expansion project
007700131111      * 11/11/13 dlk - remove credits from payment formula
007800140103      * 01/03/14 dlk - dependent transactions will not affect member cnt
007900140228      * 02/28/14 dlk - bday change will not affect member cnt
008000140506      * 04/09/14 dlk - tobacco adjustments will not affect member cnt
008100140905      * 09/05/14 dlk - idtrmd is now the record effective date, this is
0082001409050015  *                the inv effdt for inv rec (*CE), and the adj effdt
0083001409050015  *                for adjustments (*MA). Selection and payment calc
0084001409050015  *                is still done on IDCVDT but compensation is
0085001409050015  *                calculated on IDTRMD.
008600141204      * 12/04/14 dlk - add new payment rule to find when enough payment
0087001412040015  *                is already included on the invoice that we should
0088001412040015  *                pay the carrier. This should eliminate the need
0089001412040015  *                for admin to reverse and repost payments so
0090001412040015  *                often. This change required significant changes
0091001412120015  *                to the payment logic so I moved all payment
0092001412110015  *                logic to GETPAID and removed it from this program.
0093001412110015  *                GETPAID will now be used everywhere we need to know
0094001412110015  *                the remittance payment status.
0095001412120015  *                * Since GETPAID is used, the following files
0096001412120015  *                  need to be overriden in the CL: HIST, HISTAA,
0097001412120015  *                  ACCMST, CARMST, INVSUM.
009800150225      * 02/24/15 dlk - add new parms to getpaid
009900150928      * 09/28/15 dlk - This program will now be used for all remittance runs
0100001509280015  *                (dbe & alternate carriers) so the CL will just have
0101001509280015  *                different file overrides depending on what is being
0102001509280015  *                run.
0103001509280015  *                - DBE (DW260CL) will use INVDETL3D and DBREC
0104001509280015  *                - ALT (DW040CL) will use INVDETL3N and NTREC
0105001509280015  *                - ALT (DW040CL) will use INVDETL3O and OTREC
0106001509280015  *                - ALT (DW040CL) will use INVDETL3D and SDREC
010700160222      * 02/22/16 dlk - change to use getpaidcl instead of getpaid
010800160418      * 04/18/16 dlk - add remit date parm to getpaidcl
010900161214      * 12/14/16 dlk - add new fields to OTREC and CR132 based on new
0110001612140015  *                GPR requirements (will be added to CR130HS*)
011100171018      * 10/18/17 dlk - change qsysprt to dw040p so it can be emailed
0112001710180015  *                without concern for overlapping another qsysprt
011300191031      * 10/31/19 dlk - change to only show benefit amount / life volume
0114001910310015  *                when the record is paid.                        *
011500210513      * 05/13/21 dlk - Documentation update only - The Federal COBRA
0116002105130015  *                subsidy plans (SFADM = 'Y') will be use for the
0117002105130015  *                member count so there is no skip of them here.
0118002105130015  *                The members real coverage plan will have zero
0119002105130015  *                premium so it will not be counted (fed and state).
012000210520      * 05/20/21 dlk - Check COBRA transactions for payment separate from
0121002105200015  *                account transactions using the new cobra paid
0122002105200015  *                through date program.
012300210528      * 05/28/21 dlk - Check COBRAPR file for COBRA payment recovery
0124002105280015  *                invoice that will be forced to be paid. This will
0125002105280015  *                only be needed until all invoices in this file
0126002105280015  *                are completely paid in invdet. Once that happens
0127002105280015  *                this logic and the file can be removed from this
0128002105280015  *                program.
012900211001      * 10/01/21 dlk - add 2 new parms to getptc
0130002105280015  *
0131002105200015  *
0132002005190015  *  ************************************************************   *
0133002005190015  *  * * NOTE - Logic in this program was copied to RPA421.     *   *
0134002005190015  *  *          Any changes here should be considered there also*
0135002105280015  *  *          - RPA421 no longer used since paydfr is over.   *   *
0136002105200015  *  *                                                          *   *
0137002005190015  *  ************************************************************   *
013800200519      *
0139000704160015  *        ** Any changes to the payment rules must be updated in  *
0140000704160015  *           I:\mis\Carrier Remittance Payment Rules **           *
0141002105200015  *           I:\mis\COBRA Remittance Payment Rules **             *
0142000603280015  *                                                                *
0143000101310015 F******************************************************************
0144000009180017 FINVDETl3  uf   E           k DISK
0145001412110019 FACCMST    IF   E           K DISK
0146001412110019 FCARMST    IF   E           K DISK
0147000304090019 FCMCT14    IF   e           k DISK
0148000202010014 Fmktcara1  IF   e           k DISK
0149002105200030 Frpayhisc  if A E           k DISK
0150002105280030 Fcobrapr   if   E           k DISK
0151001612140030 FCR132     O  A F  150        DISK
0152000101310030 Finvdwk    O  A E             DISK    rename(invdr:invdrwk)
0153000306040030 Fotrec     O  A E             DISK    rename(bcrecr:otrecr)
0154001710180030 Fdw040p    O    F  132        PRINTER OFLIND(*INOg)
015500161214
015600161214     d  wkcnt          s                   like(bcmcnt)
015700191031     d  lifev70        s              7s 0
015800210520     d  paymnt_wk      s                   like(paymnt)
015900210520     d  rphckey1       s               d   datfmt(*iso)
0160009606050055 D                 DS
0161001412110056 D  TSAchar                1     10
0162009606050056 D  IDTRST                 1      3  0
0163009606030056 D  IDSUBD                 4      6  0
0164009606030056 D  IDACCT                 7     10  0
0165009910230055 D                 DS
0166009910230056 D  IDCVDT                 1      8  0
0167009910230056 D  IDcym                  1      6  0
0168000104090056 D  IDcday                 7      8  0
0169001409050055 D                 DS
0170001409050056 D  IDTRMD                 1      8  0
0171001409050056 D  IDTRMDday              7      8  0
0172000104170055 D                 DS
0173000104170056 D  IDRC                   1      3
0174000104170056 D  IDRC2                  2      3
0175009910230055 D                 DS
0176000009150056 D  level2                 1     16
0177000009150056 D  l2trst                 1      3  0
0178000009150056 D  l2subd                 4      6  0
0179000009150056 D  l2acct                 7     10  0
0180000009150056 D  l2cym                 11     16  0
0181000304300055 D                 DS
0182000906170056 D  KEY19                  1     19
0183000304300056 D   KDATE                 1      8
0184000906170056 D   kseq#                 9     16  0 INZ(1)
0185000906170056 D   kabrcode             17     17
0186000906170056 D   kabrseq              18     19
0187000304300055 D                 DS
0188000304300056 D  bcefdt                 1      8  0
0189000304300056 D   bcefyy                1      4  0
0190000304300056 D   bcefmm                5      6  0
0191000304300056 D   bcefdd                7      8  0
019200081215
019300081215      * primary broker field from CMCT14
019400081215     D                 DS
019500081215     D  free5                  1      5
019600081215     D  cmprib                 1      1
019700081215
0198009606030055 D                UDS
0199000807180056 D  Lseq                  21     22  0
0200000009180056 D  LEFFDT                85     92  0
0201000807180056 D  labrcode             200    200
0202002106100056 D  lconame              201    240
0203000802050056 D  rundatout            400    407
0204009910230053 I*NVDR
020500000915     I*                                         IDTRST        L2
020600000915     I*                                         IDSUBD        L2
020700000915     I*                                         IDACCT        L2
020800000918     I*                                         IDCYRM        L2
020900000915     I*                                         IDCAR         L1
021000000918     c     *loval        setll     invdetl3
021100000918     c                   dow       not(%eof(invdetl3))
021200000918     c                   read      invdr
021300000918     c                   if        %eof(invdetl3)
021400000918     c                   leave
021500000918     c                   end
021600000918
021700000918     c* record selection. idbccc = "O" and idpaid = 0 already in dds for
021800080205     c* logical file invdetl3.
021900080205     c* record selection. idbccc = "N" and idpaid = 0 already in dds for
022000080205     c* logical file invdetl3n (override in CL when "N" carriers run )
022100150928     c* record selection. idbccc = "D" and idpaid = 0 already in dds for
022200150928     c* logical file invdetl3d (override in CL when DBE carriers run )
022300080205     c* select idcvdt <= run effdt (only compare ym)
022400000918
022500080205     c                   if        idcyrm > lefym
022600000918     c                   iter
022700000918     c                   end
022800000918
022900000807     C*
023000000807     C* idcvdt (effective date) as day 01
023100000807     c                   move      idcvdt        idcvdt01          8 0
023200000807     c                   move      01            idcvdt01
023300140905     C* idtrmd (rec effective date) as day 01
023400140905     c                   move      idtrmd        idtrmd01          8 0
023500140905     c                   move      01            idtrmd01
023600000807     C*
023700000915     C* manual control break because only part of idcvdt is used for break
023800000807     C*
023900991023     c                   move      *off          *inl1
024000000915     c                   move      *off          *inl2
024100000915     c                   move      idtrst        l2trst
024200000915     c                   move      idsubd        l2subd
024300000915     c                   move      idacct        l2acct
024400000915     c                   move      idcym         l2cym
024500000915     c                   move      idcar         l1car             3
024600000915
024700000915     c     level2        ifne      holdl2
024800991023     c                   move      *on           *inl1
024900000915     c                   move      *on           *inl2
025000991023     c                   endif
025100000915     c     l1car         ifne      holdl1
025200000915     c                   move      *on           *inl1
025300000915     c                   endif
025400000915
025500000915     c                   move      l1car         holdl1            3
025600000915     c                   move      level2        holdl2           16
025700141205
025800141211     C* ON NEW ACCT/ INVOICE EFFDT get account rec
025900000915     C                   if        *inl2
026000141211     C     ACKEY         CHAIN     ACCMST
026100141211     C                   if        not %found(accmst)
026200141211     C   OG              EXCEPT    HEAD2
026300141211     C                   EXCEPT    ERROR2
026400141211     C                   end
026500000728     C                   end
026600000918
026700141211     C* ON NEW acct/eff/carrier determine if account payment meets carrier
026800141211     C* threshold
026900000915     C                   if        *inl1
027000141211     c                   exsr      #getpaid
027100000915     C                   end
027200141204
027300141212      * process this transaction
027400210520     c                   eval      paymnt_wk = paymnt
027500141212     c                   exsr      #process
027600141212
027700000918     c                   enddo
027800141212
027900000918     c                   eval      *inlr = *on
028000141212
028100141212     C**************************************************************
028200141212     C*   Process this transaction -                               *
028300141212     C*   WHAT IS SENT AS BILLED AND PAID                          *
028400141212     C**************************************************************
028500141212     c     #process      begsr
028600141212     C*
028700141212     C* IF IDTRND = 0 THIS IS A NEW RECORD NOT PREVIOUSLY TRANSMITTED.
028800210520     C* IF PAYMNT_WK = Y WE HAVE A PAYMENT FOR THIS RECORD
028900141212     C*
029000141212     c                   clear                   paid
029100141212     c                   clear                   bil
029200141212
029300210528      * check COBRA payment
029400210520     c                   if        idcob <> *blank
029500210528     c                   exsr      #chkcobra
029600210520     c                   end
029700210520
029800210520
029900141212     C     IDTRND        IFEQ      0
030000141212     C                   MOVE      LEFYMD        IDEDT
030100210520     C     paymnt_wk     IFEQ      'Y'
030200141212     C*
030300141212     C* SEND RECORD AS A PAYMENT WITH BILLED AMOUNT
030400141212     C*
030500141212     C                   MOVE      IDTRAM        BIL               8 2
030600141212     C                   MOVE      IDTRAM        PAID              8 2
030700141212     C   U1              MOVE      UYMD          IDPAID
030800141212     C   U1              MOVE      UYMD          IDTRND
030900141212     C*
031000141212     C                   ELSE
031100141212     C*
031200141212     C* WE DO NOT HAVE A PAYMENT FOR THIS NEW RECORD
031300141212     C* SEND RECORD AS BILLED BUT NO PAYMENT
031400141212     C*
031500141212     C                   MOVE      IDTRAM        BIL
031600141212     C                   MOVE      0             PAID
031700141212     C   U1              MOVE      0             IDPAID
031800141212     C   U1              MOVE      UYMD          IDTRND
031900141212     C                   END
032000141212     C*
032100141212     C                   ELSE
032200141212     C* IF IDTRND WAS NOT 0 THIS IS A PREVIOUSLY TRANSMITTED RECORD
032300141212     C* BUT WE DID NOT HAVE A PAYMENT FOR.
032400141212     C* IF WE HAVE A PAYMENT THIS TIME
032500141212     C* SEND RECORD AS A PAYMENT WITH NO BILLED AMOUNT
032600141212     C*
032700210520     C     paymnt_wk     IFEQ      'Y'
032800141212     C                   MOVE      0             BIL
032900141212     C                   MOVE      IDTRAM        PAID
033000141212     C   U1              MOVE      UYMD          IDPAID
033100141212     C*
033200141212     C                   ELSE
033300141212     C* IF WE STILL DO NOT HAVE A PAYMENT THIS TIME
033400141212     C* SKIP THIS RECORD (IT WAS ALREADY SENT AS A BILL WITHOUT
033500141212     C* A PAYMENT
033600141212     C*
033700141212     C                   leavesr
033800141212     C                   END
033900141212     C*
034000141212     C                   END
034100141212     C*
034200141212     C***************************************************************
034300141212
034400141212     C*
034500141212     C* SET UP  BILL / ADJ / PAID AMOUNTS FOR CR130 REPORT
034600141212     C*
034700141212     C                   MOVE      PAID          PADAMT            9 2
034800141212     C     IDRC2         IFEQ      'CE'
034900141212     C                   MOVE      BIL           BILAMT            9 2
035000141212     C                   ELSE
035100141212     C                   MOVE      BIL           ADJAMT            9 2
035200141212     C                   END
035300141212     c*
035400141212     c* fill seq#
035500141212     c*
035600141212     C                   ADD       1             kseq#
035700141212     C                   MOVEL     KEY19         IDDTSQ
035800141212
035900141212     C   U1              UPDATE    INVDR
036000141212     C*
036100141212     C                   MOVE      *ZEROS        BIL
036200141212     C                   MOVE      *ZEROS        PAID
036300141212     C*
036400141212     C**********
036500141212     C*
036600141212     C*  CREATE WORKFILE FOR CR130 TO USE
036700141212      *
036800141212      * read all comctx that are active for this plan / record type
036900141212      * effective date (idtrmd) and find the 1st active relation
037000141212     C                   clear                   SLSOUT            3
037100141212     C                   clear                   relout            8
0372001412120197  *
037300141212  93 C     cmkey         setll     cmct14
037400141212     c                   dou       %eof(cmct14)
0375001412120195 C     cmkey         reade     cmct14
037600141212     c                   if        (not %eof(cmct14)) and (idtrmd >= effdat)
037700141212     c                             and (cmcan = 0 or cmcan >= idtrmd)
037800141212     c                             and (cmcan <> effdat)
037900141212      * hold 1st active
038000141212     c                   if        relout  = *blanks
038100141212     C                   MOVE      SLSMAN        SLSOUT
038200141212     C                   MOVE      cmrelid       relout
038300141212     c                   end
038400141212      * if this rec is the primary broker, use it
038500141212     c                   if        cmprib = 'Y'
038600141212     C                   MOVE      SLSMAN        SLSOUT
038700141212     C                   MOVE      cmrelid       relout
038800141212     c                   leave
0389001412120201 C                   end
039000141212
039100141212     c                   end
039200141212     c                   enddo
039300141212     C*
039400141212     C*
039500141212     C* write invoice detail record to work file for commissions to use
039600141212     C*
039700141212     C                   WRITE     invdrwk
039800141212     C*
039900141212     C* write OTREC for CR130HSO creation later
040000141212     C*
040100141212     C                   MOVEL     iddtsq        BCNKEY
040200141212     c                   move      idss#         bcss
040300141212     c                   movel     idgrp#        bcgn
040400141212     C                   z-add     idtrst        bctrst
040500141212     C                   z-add     idsubd        bcsub
040600141212     C                   z-add     idacct        bcacct
040700141212     C                   movel     idcar         bccar
040800141212     C                   movel     idplan        bcplan
040900141212     C                   movel     acnam1        bcanam
041000141212     C                   movel     cgrpcd        bcgrpc
041100141212     C                   z-add     bilamt        bcbila
041200141212     C                   z-add     adjamt        bcadja
041300141212     C                   z-add     padamt        bcpada
041400141212     C                   movel     slsout        bcsman
041500141212     C                   z-add     idtrmd01      bcefdt
041600141212     C                   movel     relout        bcrelid
041700191031     c                   clear                   bclifev
041800191031     c                   clear                   lifev70
041900191031     c                   if        padamt <> 0
042000141212     C                   z-add     idbamt        bclifev
042100191031     C                   z-add     idbamt        lifev70
042200191031     c                   end
042300141212
042400141212     C                   if        comsch = '1'
042500141212     C                   move      'P'           bccmth
042600141212     c                   end
042700141212
042800141212     c* get member count and market size
042900141212     c                   exsr      #mcnt
043000161214     c                   exsr      #mksz
043100141212
043200141212     C                   WRITE     otrecr
043300141212     C*
043400161214     C* ADD REC TO CR132 WORKFILE for old schedule commission
043500141212     C*
043600141212     C     SLSOUT        IFEQ      *BLANKS
043700141212     C   OG              EXCEPT    HEAD2
043800141212     C                   EXCEPT    ERROR
043900141212     C                   END
044000141212
044100141212     C                   IF        COMSCH = '1'
044200141212     C                   EXCEPT    ADDCR
044300141212     C                   END
044400141212     C*
044500141212     c                   clear                   otrecr
044600141212
044700141212     c                   clear                   bilamt
044800141212     c                   clear                   adjamt
044900141212     c                   clear                   padamt
045000141212     c                   clear                   slsout
045100141212     c                   clear                   relout
045200141212     c                   clear                   bil
045300141212     c                   clear                   paid
045400191031     c                   clear                   lifev70
045500141212
045600141212     c                   endsr
045700141212
0458001412110103 C*******************************************************************
0459001412110104 C* call get paid to get payment status for this acct/effdt/carrier *
0460001412110103 C*******************************************************************
046100141211     c     #getpaid      begsr
046200141211
046300141211      * get carrier master for use elsewhere
046400141211     C     IDCAR         CHAIN     CARMST
046500141211
046600141211     c     grplist       plist
046700141211     c                   parm                    parmkey          10
046800160418     c                   parm                    parmremymd        8
046900160418     c                   parm                    parmeffymd        8
047000141211     c                   parm                    parmcar           3
047100141211     c                   parm                    parmupdate        1
047200141211     c                   parm                    parmpaid          1
047300141211     c                   parm                    parmerr          35
047400150224     c                   parm                    parminveb        10 2
047500150224     c                   parm                    parmpayments     10 2
047600150224     c                   parm                    parmcredits      10 2
047700150224     c                   parm                    parmdebits       10 2
047800141211
047900141211     c                   movel     tsachar       parmkey
048000160418     c                   move      lefymd        parmremymd
048100160418     c                   move      idcvdt01      parmeffymd
048200141211     c                   move      idcar         parmcar
048300141211     c                   move      'Y'           parmupdate
048400141211     c                   clear                   parmpaid
048500141211     c                   clear                   parmerr
048600150224     c                   clear                   parminveb
048700150224     c                   clear                   parmpayments
048800150224     c                   clear                   parmcredits
048900150224     c                   clear                   parmdebits
049000141211
049100160222     c                   call      'GETPAIDCL'   grplist
049200141211
049300141211      * if any error returned, print it
0494001412110361 C                   if        parmerr <> *blanks
049500141211     C   og              EXCEPT    head2
049600141211     C                   EXCEPT    error3
049700141211     C                   END
049800141211
049900141211     c                   move      parmpaid      paymnt            1
050000141211
050100141211     c                   endsr
050200141211
0503009808170103 C***************************************************
0504009808170104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0505009808170105 C***************************************************
0506009808170107 C*
0507009808170107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0508009808170107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0509009808170107 C*
0510009808170106 C     #DATMY        BEGSR
051100980817     C                   MOVEL     @DATIN        @MD               4 0
051200980817     C                   MOVE      @DATIN        @Y                4 0
051300980817     C                   MOVE      @MD           @DATOU            8 0
051400980817     C                   MOVEL     @Y            @DATOU
051500980817     C                   MOVE      *ZEROS        @DATIN            8 0
0516009808170120 C                   ENDSR
051700161214
0518001612140069  **************************************************************
0519001612140069  * get member count
0520001612150069 C*   **********************************************************
0521001612150069 C*   **** ANY changes to this member count logic must also be *
0522001612150069 C*   *    made in RPA401. ***                                 *
0523001612150069 C*   **********************************************************
0524001612140069  **************************************************************
052500161214       begsr #mcnt;
0526001612140408  *
0527001612140408  * calculate member count for this record (0,1,-1)
0528001612140408  * -change transactions are 0 (MCC,MCA,MCB,M10,M51,M41)
0529001612140408  * -midmonth records are 0 except invoices and adds
0530001612140408  * -smoke rate transactions are 0 (MSM,MSK)
0531001612140408  *
0532001612140408  * all others: +1 for positive amount paid and -1 for negative amt paid
053300161214      *
0534001612140408  * 5/14/09 - employer billed subsidy plans have a 0 member count
0535001612140408  *           (SFADM = Y)
0536001612140408  * 9/05/14 - change to use record type effective date (IDTRMD)
0537001612140408  * 12/14/16 - changes for new GPR - show if the contract is
0538001612140408  *            for an invoice or adjustment. Admin also requested we
0539001612140408  *            track dependent counts. Also remove cobra subsidy check
0540001612140408  *            (sfadm = 'Y') since it ended years ago.
0541002105130408  * 05/13/21 - cobra subsidy is back but subsidy planc are not omitted
0542002105130408  *            from the count this time since they are the only ones
0543002105130408  *            with a premium billed that will use a member count.
0544002105130408  *
054500090514
054600161214       clear bcmcnt;   // net member cnt
054700161214       clear bcBmcnt;  // billed member cnt
054800161214       clear bcAmcnt;  // adjustment member cnt
054900161214       clear bcdcnt;   // net depend cnt
055000161214       clear bcBdcnt;  // billed depend cnt
055100161214       clear bcAdcnt;  // adjustment depend cnt
055200161214       clear wkcnt;    // work count
055300010203
0554001612140408  * skip all transactions that do not affect the count
055500161214
055600161214       if padamt = 0 or
055700161214          (idtrmdday <> 01 and idrc2 <> 'CE' and
055800161214           idtrcd <> 'MAC' and idtrcd <> 'MDA') or
055900161214          idtrcd = 'MCC' or idtrcd = 'MCA' or idtrcd = 'MCB' or
056000161214          idtrcd = 'M10' or idtrcd = 'MSM' or idtrcd = 'MSK' or
056100161214          idtrcd = 'M41' or idtrcd = 'M51';
056200161214        leavesr;
056300161214       endif;
056400010417
0565001612140408  * set +1 or -1 count for this transaction (zero paid transactions
0566001612140408  * have already been skipped above)
056700161214
056800161214       if padamt > 0;
056900161214        wkcnt = 1;
057000161214       else;
057100161214        wkcnt = -1;
057200161214       endif;
057300010417
0574001612140408  * member transaction
057500161214       if idseq = 0;
057600161214        bcmcnt = wkcnt;
0577001612140408  * count this as an invoice or adj ?
057800161214        if idrc2 = 'CE';
057900161214          bcBmcnt = wkcnt;  // billed / invoice rec
058000161214        else;
058100161214          bcAmcnt = wkcnt;  // adjustment rec
058200161214        endif;
058300161214
0584001612140408  * dependent transaction
058500161214       else;
058600161214        bcdcnt = wkcnt;
0587001612140408  * count this as an invoice or adj ?
058800161214        if idrc2 = 'CE';
058900161214          bcBdcnt = wkcnt;  // billed / invoice rec
059000161214        else;
059100161214          bcAdcnt = wkcnt;  // adjustment rec
059200161214        endif;
059300161214       endif;
059400161214
059500161214       endsr;
059600020201
0597001612140069 C**************************************************************
0598001612140069 C* get market size
0599001612140069 C**************************************************************
060000161214     c     #mksz         begsr
060100020201     c* get market size - defalut to 50 for comm sched 2 and default to
060200020201     c* 1 for comm sched 1, also fill method with "P" for sched 1
060300020201
060400020201     c                   if        comsch = '2'
060500020201     c                   movel     '50   '       bcmksz            5
060600020201     c                   else
060700020201     c                   movel     '1    '       bcmksz
060800030430     c                   move      'P'           bccmth
060900020201     c                   end
061000020201
061100020201     c                   eval      *in67 = *off
061200020201     c     mkcaky        setll     mktcara1
061300020201     C                   dow       *in67 = *off
061400020201     c     mkcaky        reade     mktcara1                               67
0615000202010133 C   67              leave
061600140905     c                   if        idtrmd < mafrdt or (matodt <> 0 and
061700140905     c                             idtrmd > matodt) or (mafrdt = matodt)
061800020201     c                   iter
061900020201     c                   endif
062000020201     c                   movel     maszcd        bcmksz
062100020201     c                   enddo
062200020201
062300010203     c                   endsr
062400210520
0625002105200103  ******************************************************
0626002105280104  * check COBRA record for payment
0627002105200105  ******************************************************
0628002105280106 C     #chkcobra     BEGSR
062900210528
063000210528     c                   eval      paymnt_wk = 'N'
063100210528       parmssn = %editc(idss#:'X');
063200210528       parmcptdate = *blanks;
063300210528       parmcitdate = *blanks;
063400211001       parmcinv    = *zeros;
063500211001       parmcadj    = *zeros;
063600211001       parmcpay    = *zeros;
063700210528       parmcpayovr = *blank;
0638002105280694 c                   call      'GETPTCCL'
063900210528     c                   parm                    parmssn           9
064000210528     c                   parm                    parmcptdate       8
064100210528     c                   parm                    parmcitdate       8
064200211001     c                   parm                    parmcinv         11 2
064300211001     c                   parm                    parmcadj         11 2
064400211001     c                   parm                    parmcpay         11 2
064500210528     c                   parm                    parmcpayovr       1
064600210528
064700210528      * if cobra paid through date >= effdt of transaction
064800210528      * or payment override is used then this rec is paid.
064900210528     c                   move      parmcptdate   cptdateN          8 0
065000210528     c                   if        (cptdateN <> 0 and cptdateN >= idcvdt01)
065100210528     c                             or
065200210528     c                             parmcpayovr <> *blank
065300210528     c                   eval      paymnt_wk = 'Y'
065400210528     c                   end
065500210528
065600210528      * record the cobra payment values in rpayhisc file
065700210528     c                   exsr      #writerphc
065800210528
065900210528      * 05/28/21 -
066000210528      * Check the COBRAPR file to see if this transactions invoice # is
066100210528      * part of the special COBRA Payment recovery. These records will be
066200210528      * considered "Paid" regardless of the above payment decision so the
066300210528      * credits (they are all void invoice transactions) take the money
066400210528      * back we incorrectly advanced based on the employers payment under
066500210528      * the old payment rules.
066600210528      *
066700210528     c                   if        paymnt_wk <> 'Y'
066800210528     c     cobraprkey    chain     cobrapr
066900210528     c                   if        %found(cobrapr)
067000210528     c                   eval      paymnt_wk = 'Y'
067100210528     c                   end
067200210528     c                   end
067300210528
067400210528     c                   endsr
067500210528
0676002105280103  ******************************************************
0677002105280104  * write to remittance payment history file for cobra *
0678002105280105  ******************************************************
0679002105280107  *
0680002105280106 C     #writerphc    BEGSR
068100210520
068200210520      * if this member has already been written this run then skip it
068300210520
068400210520     C                   move      lefymd        rphckey1
068500210520     c     rphckey       chain     rpayhisc
068600210520     c                   if        not %found(rpayhisc)
068700210520      * write to rpayhisc
068800210520     c                   clear                   rpayhiscr
068900210520     C                   move      lefymd        rycrdt
069000210520     c                   move      labrcode      rycacar
069100210520     c                   move      lseq          rycseq
069200210520     C                   EVAL      rycrundt  = %date
069300210520     C                   EVAL      rycrunti  = %time
069400210520     c                   eval      rycssn    = idss#
069500210520     c                   move      parmcptdate   rycptd
069600210520     c                   move      parmcitdate   rycitd
069700210520     c                   eval      rycpay    = parmcpay
069800210520     c                   eval      rycpayovr = parmcpayovr
069900210520     c                   write     rpayhiscr
070000210520     c                   end
070100210520
0702002105200120 C                   ENDSR
070300210520
070400080718      *
0705000007210103 C***************************************************
0706000007210104 C* first cycle
0707000007210105 C***************************************************
0708000007210107 C*
0709000007210120 C     *inzsr        begsr
071000000721     C                   TIME                    HTIME             6 0
071100000721     C*
071200000721     C                   MOVE      *DATE         @DATIN
071300000721     C                   EXSR      #DATMY
071400000721     C                   MOVE      @DATOU        UYMD              8 0
071500030430     C                   MOVE      @DATOU        KDATE
071600080205     C                   MOVE      @DATOU        rundatout
0717000007210111 C*
071800000721     C                   MOVE      LEFFDT        @DATIN
071900000721     C                   EXSR      #DATMY
072000000721     C                   MOVE      @DATOU        LEFYMD            8 0
072100000918     C                   MOVEl     @DATOU        LEFYM             6
0722000007210111 C*
072300000920     C                   EXCEPT    HEAD2
072400090617
072500090617     c                   move      labrcode      kabrcode
072600090617     c                   move      lseq          kabrseq
072700081021
072800000721     C     ACKEY         KLIST
072900000721     C                   KFLD                    IDTRST
073000000721     C                   KFLD                    IDSUBD
073100000721     C                   KFLD                    IDACCT
073200000727     C*
073300020201     c     mkcaky        klist
073400020201     c                   kfld                    idtrst
073500020201     c                   kfld                    idsubd
073600020201     c                   kfld                    idacct
073700020201     c                   kfld                    idcar
073800000727     C*
073900030409     c     cmkey         klist
074000030409     c                   kfld                    idtrst
074100030409     c                   kfld                    idsubd
074200030409     c                   kfld                    idacct
074300030409     c                   kfld                    idplan
074400210520     C*
074500210520     c     rphckey       klist
074600210520     c                   kfld                    rphckey1
074700210520     c                   kfld                    labrcode
074800210520     c                   kfld                    lseq
074900210520     c                   kfld                    idss#
075000090514
075100210528     c     cobraprkey    klist
075200210528     c                   kfld                    idss#
075300210528     c                   kfld                    idinv#
075400210528
0755000007210120 C                   ENDSR
075600000830
075700980204     O*
075800960625     OCR132     EADD         ADDCR
075900960625     O                       IDCAR                3
076000960625     O                       IDTRST               6
076100960625     O                       IDSUBD               9
076200960625     O                       IDACCT              13
076300001011     O                       IDGRP#              28
076400960625     O                       ACNAM1              69
076500960625     O                       CGRPCD              71
076600960625     O                       BILAMT         B    80
076700960625     O                       ADJAMT         B    89
076800960625     O                       PADAMT         B    98
076900960625     O                       SLSOUT         B   101
077000140905     O                       idtrmd01           109
077100000801     O                       IDPLAN             113
077200010203     O                       bcmcnt             114
077300191031     O                       lifev70            121
077400020201     O                       bcmksz             126
077500030409     O                       relout         b   134
077600161214     O                       bcBmcnt            135
077700161214     O                       bcAmcnt            136
077800161214     O                       bcdcnt             137
077900161214     O                       bcBdcnt            138
078000161214     O                       bcAdcnt            139
078100161214
0782001710180237 Odw040p    E            head2          2 03
0783002106100092 O                       lconame             87
0784000009200242 O          E            head2          1
0785001509280244 O                                           63 'ABR RUN ('
0786001509280244 O                       labrcode            64
0787001509280244 O                                           78 ') ERROR REPORT'
0788000009200242 O          E            head2          1
078900000920 244 O                                           65 'FOR :'
079000000920 244 O                       LEFFDT              76 '  /  /    '
0791000009200242 O          E            head2          1
0792000009200248 O                                           24 'PROGRAM NAME: DW040'
0793000009200249 O                                          122 'PAGE :'
0794000009200250 O                       PAGE2         Z    131
0795000009200242 O          E            head2          1
0796000009200253 O                                           14 'RUN DATE:'
0797000009200254 O                       UDATE         Y     25
0798000009200255 O                                          122 'TIME :'
0799000009200256 O                       HTIME              131 '  :  :  '
0800000009200242 O          E            head2          1
0801000009200259 O                                           24 '------------------------'
0802000009200260 O                                           48 '------------------------'
0803000009200261 O                                           72 '------------------------'
0804000009200262 O                                           96 '------------------------'
0805000009200263 O                                          120 '------------------------'
0806000009200286 O                                          132 '------------'
0807000009200242 O          E            head2          1
0808000009200267 O                                            9 'ACCOUNT #'
0809000009200268 O                                          104 'ERROR'
0810000009200242 O          E            head2          2
0811000009200259 O                                           24 '------------------------'
0812000009200260 O                                           48 '------------------------'
0813000009200261 O                                           72 '------------------------'
0814000009200262 O                                           96 '------------------------'
0815000009200263 O                                          120 '------------------------'
0816000009200286 O                                          132 '------------'
0817000009200287 O          E            ERROR          1
0818000009200288 O                       IDTRST               3
0819000009200288 O                                            4 '-'
0820000009200288 O                       IDSUBD               7
0821000009200288 O                                            8 '-'
0822000009200288 O                       IDACCT              12
0823000009200288 O                       IDPLAN              19
0824001409050288 O                       idtrmd              69 '    /  /  '
0825000009200288 O                       IDSS#               83
0826000009200288 O                                          125 'NO COMMISSION CONTROL     '
0827000009200287 O          E            ERROR2         1
0828000009200288 O                       IDTRST               3
0829000009200288 O                                            4 '-'
0830000009200288 O                       IDSUBD               7
0831000009200288 O                                            8 '-'
0832000009200288 O                       IDACCT              12
0833000009200288 O                                          125 'NO ACCOUNT MASTER         '
0834000009200287 O          E            error3         1
0835000009200288 O                       IDTRST               3
0836000009200288 O                                            4 '-'
0837000009200288 O                       IDSUBD               7
0838000009200288 O                                            8 '-'
0839000009200288 O                       IDACCT              12
0840000009200288 O                       ACNAM1              54
0841001412120288 O                                           +2 'EFF-'
0842001412120288 O                       idcvdt01            +1 '    /  /  '
0843001412120288 O                                           +2 'CAR-'
0844001412120288 O                       idcar               +1
0845001412110288 O                       parmerr            132
