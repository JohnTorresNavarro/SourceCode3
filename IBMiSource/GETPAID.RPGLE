0001000907210002  ******************************************************************
0002000907210003  * getpaid    GROUP BENEFIT SERVICES                              *
0003000907210004  *                                                                *
0004000907210005  *            WRITTEN BY - DAVID KETTERMAN                        *
0005000907210006  *            DATE - 07/20/09                                     *
0006000907210007  *                                                                *
0007000907210013  *  DESCRIPTION - Get paid status for the acct/effdt/carr parm.   *
0008000907210007  *                                                                *
0009000907210004  *                parameters to pass:                             *
0010000907210007  *                -------------------                             *
0011000907210004  *                1. Trust/sub/acct                               *
0012001604190004  *                2. remittance effdt (YYYYMMDD)-only used for remit
0013001604180004  *                3. payment effdt (YYYYMMDD)                     *
0014001604180004  *                4. carrier                                      *
0015001604180004  *                5. update (Y = Bill file run (DW040)       and  *
0016001502240004  *                           N for all other places that call this)
0017001604180004  *                6. return - paid Y/N                            *
0018001604180004  *                7. return - error message                       *
0019001604180004  *                8. return - invoice ending balance              *
0020001604180004  *                9. return - total payment after invoice         *
0021001604180004  *               10. return - total credits after invoice         *
0022001604180004  *               11. return - total debits after invoice          *
0023000907210004  *                                                                *
0024000907210004  *  * Make sure the files used in this program are overridden to  *
0025001509220004  *    F. in the program that calls it or call GETPAIDCL that      *
0026001509220004  *    already has the overrides. Also, when this program          *
0027001412110004  *    is called from the bill file run the update parm will be    *
0028001412110004  *    set to "Y" and the ABR code/seq will be taken from the LDA  *
0029001412110004  *    since they are already there. This avoids having to pass    *
0030001412110004  *    those 2 additional values needed for the rpayhis file.      *
0031001412110004  *                                                                *
0032001412110004  *                                                                *
003300131003      * 09/24/13 dlk - history expansion project
003400131111      * 11/11/13 dlk - remove credits from payment formula
003500141209      * 12/09/14 dlk - update this program to use the new payment
0036001412090015  *                rule (is there enough payment already on the inv)
0037001412150015  *                and prepare it to become the one place
0038001412090015  *                that holds the payment rule logic. I will then
0039001412090015  *                change every place that currently calcualtes
0040001412090015  *                payment and have it call this program instead.
0041001502020015  * 01/30/15 dlk - Liliane request - change DBE payment required to 90%
0042001502160015  * 02/16/15 dlk - remove hard coded pay pct required for DBE, all
0043001502160015  *                carriers will use cthresh from carrier master now
0044001502240015  * 02/24/15 dlk - add 4 new parms to pass back for use in RP170,
0045001502240015  *                RPF070, and RP174
0046001509220015  * 09/22/15 dlk - add special carrier override "<a>" to represent
0047001509220015  *                100% payment required. RPF070 (urgent letters
0048001509220015  *                require 100% payment for all accounts)
0049001509220015  * 09/22/15 dlk - create GETPAIDCL that has the file overrides in it
0050001509250015  *                to protect getpaid from previous overrides. This
0051001509250015  *                CL can be called instead of getpaid directly when
0052001509250015  *                files used in getpaid are also used in the pgm
0053001509250015  *                calling it.
0054001602220015  * 02/22/16 dlk - add additional check to override rules 1 & 3
0055001602220015  *                '...and no un-invoiced transactions' because the
0056001602220015  *                acct balance check is only valid now when all
0057001602220015  *                adjustments have been on an invoice and thus in
0058001602220015  *                the remittance.
0059001604120015  * 04/12/16 dlk - add additional check to override rules 1 & 3
0060001604120015  *                '...and no un-paid future remittance months
0061001604120015  *                 transactions' to catch cancelled senior dental
0062001604120015  *                 accounts that do not have the last invoice rerun
0063001604150015  *                 to capture all un-invoiced adjustments in the
0064001604120015  *                 current invoice / remittance.  This way the
0065001604120015  *                 check for the acct balance of zero will not be
0066001604120015  *                 used since it does not reflect what the remittance
0067001604120015  *                 sees.
0068001604180015  * 04/18/16 dlk - add additional parm for remittance effdt since the
0069001604180015  *                new "look ahead for future remittance transactions"
0070001604180015  *                rule will only be used in the remittance run.
0071001710200015  * 10/20/17 dlk - change override 3 to omit balance/bucket after
0072001710200015  *                remittance month since this amount is not due yet
0073001710200015  *                but an invoice would increase the amount due. This
0074001710200015  *                was needed primarily for senior dental accounts
0075001710200015  *                that change effective date and leave the old month
0076001710200015  *                without an invoice causing it to stay on the error
0077001710200015  *                report as "no inv for ending bal". Also seperate
0078001710200015  *                the check for future remit transactions from the
0079001710200015  *                check for uninvoiced transactions because override
0080001710200015  *                3 will only look for uninvoiced transactions.
0081001710200015  *                                                                 *
0082000907210015  *        ** Any changes to the payment rules must be updated in   *
0083000907210015  *           I:\mis\Carrier Remittance Payment Rules **            *
0084000907210015  *                                                                 *
0085001602220035  *  ** This progam is used in DW040, DW042, RP170, RPF070,        *
0086001806290004  *     OD170, RP174R, GETPTHRU.                                   *
0087001412120004  *                                                                *
0088009908180016 F******************************************************************
0089000907200019 Fhist      IF   E           K DISK
0090000907200019 FHISTAA    IF   E           K DISK    rename(histr:histraa)
0091001602220019 Fhistinv   IF   E           K DISK    rename(histr:histrin) prefix(hi_)
0092001509220019 FACCMST    IF   E           K DISK
0093000907200019 FCARMST    IF   E           K DISK
0094000907200016 Finvsum    IF   E           K DISK
0095001604120016 Finvdet    IF   E           K DISK
0096001412110030 Frpayhis   O  A E             DISK
009700141212
0098000907200056 Dpaypct           s             13  4
0099001602220056 Dtotbal           s             10  2
0100001710200056 Dworkbal          s                   like(totbal)
0101001602220056 Duninvtrn         s              1
0102001710200056 Dfuturetrn        s              1
0103001604180037 D workdtmdy       S               d   datfmt(*usa)
0104001710200152 D                 DS
0105001710200153 D  acvtdt                 1      8  0 inz
0106001710200154 D  acvm                   5      6  0
0107000907200152 D                 DS
0108000907200153 D  parmtsa                1     10
0109000907200154 D  Ptrust                 1      3  0
0110000907200154 D  Psub                   4      6  0
0111000907200154 D  Pacct                  7     10  0
0112000907200055 D                 DS
0113000907200056 D  BAL                    1    108  2
011400090720     D                                     DIM(12)
0115000907200056 D  BAL1                   1      9  2
0116000907200056 D  BAL2                  10     18  2
0117000907200056 D  BAL3                  19     27  2
0118000907200056 D  BAL4                  28     36  2
0119000907200056 D  BAL5                  37     45  2
0120000907200056 D  BAL6                  46     54  2
0121000907200056 D  BAL7                  55     63  2
0122000907200056 D  BAL8                  64     72  2
0123000907200056 D  BAL9                  73     81  2
0124000907200056 D  BAL10                 82     90  2
0125000907200056 D  BAL11                 91     99  2
0126000907200056 D  BAL12                100    108  2
012700141211
012800141212      * These values from LDA are used when the update parm is set to "Y"
012900141212      * to write the RPAYHIS record
0130001412110055 D                UDS
0131001412110056 D  lseq                  21     22
0132001604180056 D**LEFFDT                85     92
0133001412110056 D  labrcode             200    200
013400141211
013500001107     c     *entry        plist
013600090720     c                   parm                    parmkey          10
013700160418     c                   parm                    parmremymd        8
013800160418     c                   parm                    parmeffymd        8
013900090720     c                   parm                    parmcar           3
014000141211     c                   parm                    parmupdate        1
014100090720     c                   parm                    parmpaid          1
014200090721     c                   parm                    parmerr          35
014300150224     c                   parm                    parminveb        10 2
014400150224     c                   parm                    parmpayments     10 2
014500150224     c                   parm                    parmcredits      10 2
014600150224     c                   parm                    parmdebits       10 2
014700001107
014800150925     C                   clear                   pay_ovr           1
014900150925     c                   clear                   payments
015000090720     c                   clear                   paypct
015100090720     c                   clear                   paypcto
015200131111     C                   clear                   TOTINV           10 2
015300141209     C                   clear                   TOTINVSAV        10 2
015400090721     C                   clear                   parmerr
015500150224     C                   clear                   parminveb
015600150224     C                   clear                   parmpayments
015700150224     C                   clear                   parmcredits
015800150224     C                   clear                   parmdebits
015900090720
016000150925     c                   move      'N'           paid_yn           1
016100090720
016200141211     c* check for missing information
016300090720     c                   if        parmcar = *blanks or parmkey = *blanks or
016400090720     c                             parmeffymd = *blanks
016500090721     C                   eval      parmerr = 'CARR, ACCT OR EFFDT MISSING'
016600090721     C                   goto      #skpay
016700090720     c                   end
016800090720
016900090720     c                   move      parmkey       parmtsa
017000090720     c                   move      parmeffymd    effymd            8 0
0171001502240136 C                   movel     effymd        effymdym          6 0
017200090721
017300141209     c* calc amount paid
017400141209     c                   exsr      #calcamtpaid
017500141209     c* is it paid?
017600141209     c                   exsr      #isitpaid
017700090720
017800090720     c     #skpay        tag
017900141211
018000141211      * if any error occured, clear field to avoid confusion since
018100141211      * the payment calc would not be completed.
018200141211     c                   if        parmerr <> *blanks
018300150925     C                   clear                   paid_yn
018400141211     c                   end
018500141211
018600071001      * set up parms to be passed back
018700150925     c                   move      paid_yn       parmpaid
018800071001
018900071001   9 C                   return
019000141209
019100141209     C*
0192001412090103 C***************************************************
0193001412090104 C* calculate amount paid                           *
0194001412090105 C***************************************************
0195001412090107 C*
0196001412090106 C     #calcamtpaid  BEGSR
019700141209
019800141209     C     acckey        CHAIN     ACCMST
019900141209     C                   if        not %found(accmst)
020000141209     C                   eval      parmerr = 'ACCT # NOT VALID'
020100141209     C                   leavesr
020200141209     C                   end
020300141209
0204001602220085
020500160222      * calc current account balance
0206001602220144 C                   XFOOT     BAL           TOTBAL
020700141209
020800171020      * see if there are any un-invoiced or future remit month transactions
020900160222     c                   exsr      #chkuninv
021000160222
0211001602220086 C* consider account paid when cancelled with zero or credit balance
0212001710200087 C* and there are no un-invoiced or future remit month transactions
0213001602220160  * Payment Override reason 1
021400171020     c                   if        atrmdt <> 0 and totbal <= 0 and
021500171020     c                             uninvtrn <> 'Y' and futuretrn <> 'Y'
021600150925     c                   eval      pay_ovr = '1'
021700141209     c                   leavesr
021800141209     c                   end
021900141209
0220001412090085 C*
0221001412090086 C* GET INVSUM FOR ENDING BALANCE, IF NO REC - check for credit
0222001412090087 C* balance or payment for effdt of run.
0223001412090087 C*
0224001412090128 C                   MOVE      'KEB'         key_rc            3
0225001412090088 C     INKEY         CHAIN     INVSUM
0226001412090096 C                   if        not %found(invsum)
022700141209     c                   exsr      #noinv
022800141209     c                   leavesr
022900141209     C                   END
023000141209     C*
023100141209     C                   Z-ADD     INENDB        TOTINV
023200141209     C                   Z-ADD     INENDB        TOTINVSAV
0233001412090125 C*
0234001412090126 C* CHECK HISTORY FOR CREDITS & PAYMENTS that occured after the invoice
0235001412090127 C* 11/11/13 - stop including credits in the payment percent
0236001412090127 C*
0237001509250128 C                   clear                   payments         10 2
0238001502240128 C                   clear                   CREDIT           10 2
0239001502240128 C                   clear                   debit            10 2
024000141209
0241001412090130 C     parmtsa       SETLL     HIST
0242001602220131 C                   dou       %eof(hist)
0243001412090132 C     parmtsa       READE     HIST
024400141209     c                   if        %eof(hist)
0245001412090133 C                   leave
024600141209     c                   end
024700141209
0248001412090134 C* skip zero amounts and dates before the invoice
024900141209     c                   if        tramt = 0 or trdate < invdte
025000141209     c                   iter
025100141209     c                   end
025200141209
025300141209     c* if the transaction was done on the same day of the invoice and
025400141209     c* meets this test, it was included on the invoice so skip it.
025500141209     c* else it occured after the invoice the same day so include it
025600141209     c                   if        hinvdt <> 0 and hinvdt <= effymd
0257001412090139 C                   iter
0258001412090138 C                   end
025900141209
026000141209     C*
026100141209     C* ACCUMULATE ALL PAYMENTS (including "ADP" trans) after the invoice
026200141209     C                   if        trcode = 'BMP' or trcode = 'ADP'
0263001509250137 C                   ADD       TRAMT         payments
0264001412090139 C                   iter
0265001412090138 C                   END
026600141209     C*
026700141209     C* ACCUMULATE ALL CREDIT TRANSACTIONS AFTER INVOICE with the
026800141209     C* effective year/month <= the invoice year/month
026900141209     C*
027000141209     C*  6/29/98
027100141209     C*  * BECAUSE CANCEL / REINSTATE ADJUSTMENTS NORMALLY
027200141209     C*    BALANCE TO ZERO, BUT WE ONLY INCLUDE CREDIT
027300141209     C*    TRANSACTIONS IN THE FORMULA, REINSTATED ACCOUNTS
027400141209     C*    WOULD BE MISSED. SO WHEN AN ACCOUNT IS REINSTATED,
027500141209     C*    THE ADJUSTMENTS PREVIOUSLY MADE FROM THE CANCELLATION
027600141209     C*    PROGRAM WILL BE SKIPPED IN THE CALCULATION OF OUTSTANDING
027700141209     C*    BALANCE.
027800141209     C*
027900141209     C* skip all transactions from void invoice
028000141209     C* skip all transactions not on the invoice (because they were
028100141209     C* reversed)
028200141209     C*
028300141209     C*  1/5/99
028400141209     C*  * BECAUSE "PREVIOUS CREDIT APPLIED" & "PREVIOUS CREDIT
028500141209     C*    TRANSFER" NET TO ZERO BUT WE ONLY INCLUDE CREDITS, THE
028600141209     C*    CREDIT WAS INCORRECTLY CALCULATED SO THEY ARE NOW
028700141209     C*    EXCLUDED FROM THE CALCULATION
028800141209
028900141209     C*  8/14/03 - finance request - exclude tr50 credits (plan change)
029000141209     c                   if        hprgnm = 'TR70      ' or
029100141209     c                             hprgnm = 'T190      ' or
029200141209     c                             hprgnm = 'TR50      ' or
029300141209     c                             excinv = 'X' or trcode = 'BCP' or
029400141209     c                             trcode = 'BAC'
029500141209     c                   iter
029600141209     c                   end
029700141209
029800141209     C*
029900141209     C* all transactions compare on year/month only to include prorated
030000141209     C* adjustments
030100141209     C*
0302001412090136 C                   movel     covtdt        hiseffym          6 0
030300141209
030400150224      * credits and debits
030500150224     c                   if        hiseffym <= effymdym
030600150224     c                   if        tramt < 0
0307001412090137 C                   ADD       TRAMT         CREDIT
030800150224     c                   else
0309001502240137 C                   ADD       TRAMT         debit
0310001502240138 C                   end
0311001412090138 C                   END
031200150925
0313001412090139 C                   enddo
031400141209
0315001502240151  * return these values to caller
031600150224     c                   z-add     totinv        parminveb
031700150925     c                   z-add     payments      parmpayments
031800150224     c                   z-add     credit        parmcredits
031900150224     c                   z-add     debit         parmdebits
032000150224
0321001412090151 C* calculate % paid
0322001412090151 C* if the sum of all payments is > 0 (reversals are positive)
0323001412090151 C* then add the amount to the total due and clear the payment
0324001412090151 C* amount before calculating the percent
032500141209
032600150925     c                   if        payments > 0
032700150925     c                   add       payments      totinv
032800150925     c                   clear                   payments
032900141209     c                   end
0330001412090125
0331001412090125  * credit ending balance means nothing due
0332001412090160  * Payment Override reason 2
0333001412090096 C                   if        totinv <= 0
033400150925     C                   eval      pay_ovr = '2'
033500141209     c                   leavesr
033600141209     C                   end
033700141209
033800150925      * 11/11/13 - stop including credits in the payment percent
033900141209     c                   clear                   abspay           10 2
034000150925     c                   eval      abspay = %abs(payments)
034100141209     c     abspay        div       totinv        paypct
034200141209
034300141209     c                   mult      100           paypct
034400141209     c                   z-add     paypct        paypcto          13 2
034500141209      *
034600141209      * Gather info needed to check for enough payment on the invoice
034700141209      *
034800141209      * get current enrollment total on invoice
0349001412090128 C                   clear                   totcurenr
0350001412090128 C                   MOVE      'KCE'         key_rc
0351001412090088 C     INKEY         CHAIN     INVSUM
035200141209     c                   if        %found(invsum)
035300141209     c                   z-add     intot         totcurenr        10 2
035400141209     c                   end
035500141209
035600141215      * get payment total on invoice, only use the amount if it is
035700141215      * negative since a positive amt would indicate a payment reversal
035800141215      * and not an actual credit / payment
0359001412090128 C                   clear                   payoninv         10 2
0360001412090128 C                   MOVE      'KMA'         key_rc
036100141209  93 C     inkey         setll     invsum
036200141209     c                   dou       %eof(invsum)
0363001412090195 C     inkey         reade     invsum
036400141209     c                   if        (not %eof(invsum)) and (intrcd = 'BMP')
036500141215     c                             and (intot < 0)
036600141209     c                   add       intot         payoninv
036700141209      * there is only one payment rec per inv
036800141209     c                   leave
036900141209     c                   end
037000141209     c                   enddo
037100141209
037200141215      * change total to positive
037300141215     c                   eval      payoninv = %abs(payoninv)
037400141215
0375001412090106 C                   endsr
037600141209
0377001412090103 C******************************************************************
0378001412090104 C* determine if this account meets the carrier payment threshold  *
0379001412090105 C******************************************************************
0380001412090107
0381001412090106 C     #isitpaid     BEGSR
038200141209
038300141211      *skip if there is already an error
038400141211     c                   if        parmerr <> *blanks
038500141211     C                   leavesr
038600141211     c                   end
038700141211
038800150925     C                   clear                   paid_yn           1
038900150922     c                   clear                   cpayp
039000150922
039100150922     C* 9/22/15 - special override code <a> = 100% payment required
039200150922     c                   if        parmcar = '<a>'
039300150922     c                   z-add     100           cpayp
039400150922     c                   else
039500150922      * get carrier payment percent
039600141209     C     parmcar       CHAIN     CARMST
039700141209     c                   if        not %found(carmst)
039800141209     C                   eval      parmerr = 'CARRIER NOT VALID'
039900141209     C                   leavesr
040000141209     c                   end
040100141209     c                   z-add     cthresh       cpayp             6 2
040200150922     c                   end
040300150922
040400141209     c* if payment was granted because of an override, write to payment
0405001412090160 C* history file as paid with override reason and skip % check
0406001412090160  *
0407001601280160  * Payment Override Reasons: (if these change, need to update payment
0408001601280107  * -------------------------  rules document in I:/mis/carrier...)
040900160128      *
0410001412090160  * 1 = Cancelled account with zero or credit balance
0411001412090160  * 2 = Credit ending balance (invoice)
0412001710200160  * 3 = Missing invoice - Credit account balance (w/o future inv amt)
0413001412090160  * 4 = Missing invoice - Payment for effective date of bill file run
0414001412090160  * 5 = Payment on invoice reduced ending balance due
0415001412090160  *
0416001509250152 C                   if        pay_ovr <> *blank
041700150925     C                   eval      paid_yn  = 'Y'
041800141211     c                   exsr      #writerph
041900141209     C                   leavesr
042000141209     C                   end
042100141209
0422001412090160 C* check payment % required per carrier
0423001412090160 C* if paid % is ge carriers payment % minimum then consider it paid
0424001412090160 C* write to payment history file as paid
042500141209
0426001412090152 C                   if        paypct >= cpayp
042700150925     C                   eval      paid_yn = 'Y'
042800141211     c                   exsr      #writerph
042900141209     C                   leavesr
0430001412090154 C                   end
0431001412090160
0432001412090160  * 12/4/14 - new rule - was there enough payment on the invoice
0433001412090160  * (that reduced the ending balance) that we should pay the carrier.
0434001412090160  *
0435001412090160  * calcualte threshhold balance
043600141215     c                   clear                   threshpctbal      8 4
043700141209     c                   clear                   threshenrbal     10 2
0438001412090160  *
0439001412090160  * If Ending Balance Due on the invoice (TOTINVSAV) is <=
0440001412090160  * the balance of the current enrollment total without the threshhold
0441001412090160  * percent (THRESHENRBAL)
0442001412090160  * AND a payment exists on the invoice >=
0443001412090160  * the balance of the current enrollment total without the threshhold
0444001412090160  * percent (THRESHENRBAL)
0445001412090160  * then consider this invoice paid due to an override.
0446001412090160  * Payment Override reason 5
0447001412090160  *
044800141209     c                   if        cpayp >= 0 and cpayp <= 100
044900141209     c                   eval      threshpctbal = 100 - cpayp
045000141215      * convert whole number to pct
045100141215     c                   eval      threshpctbal = threshpctbal * .01
045200141215
045300141209     c                   eval      threshenrbal = totcurenr * threshpctbal
045400141209     c                   if        (totinvsav <= threshenrbal) and
045500141209     c                             (payoninv  >= threshenrbal)
045600150925     C                   eval      paid_yn  = 'Y'
045700150925     c                   eval      pay_ovr  = '5'
045800141211     c                   exsr      #writerph
045900141209     C                   leavesr
046000141209     c                   end
046100141209     c                   end
046200141209
0463001412090160 C* if all the above payment checks did not satisfy the payment rules
0464001412090160 C* then write to payment history file as non pay
046500150925     C                   eval      paid_yn  = 'N'
046600141211     c                   exsr      #writerph
046700141209
0468001412090106 C                   endsr
046900141209
047000071001
047100090720     C*
0472000907200103 C***************************************************
0473000907200104 C* missing invsum
0474000907200105 C***************************************************
0475000907200120 C     #noinv        begsr
047600141209
0477001710200160  * account has zero or credit balance right now (less any month billed
0478001710200160  * after the remittance) and there are no un-invoiced transactions
0479001412090160  * Payment Override reason 3
048000171020
048100171020     c                   z-add     totbal        workbal
048200171020
048300171020      * if this is the remittance run and the account covered through date
048400171020      * is greater than the remittance date, then back out the covtdt month
048500171020      * bucket from bal since this amount is not due yet
048600171020     c                   if        remitymd <> 0 and acvtdt > remitymd and
048700171020     c                             (acvm > 0 and acvm <13)
048800171020     c                   sub       bal(acvm)     workbal
048900171020     c                   end
049000171020
0491001710200152 C                   if        workbal <= 0 and uninvtrn <> 'Y'
049200150925     C                   eval      pay_ovr = '3'
049300090720     c                   leavesr
049400090720     C                   END
049500090720
049600171002      * look for payment for payment effdt
0497001412090160  * Payment Override reason 4
049800090720
049900090720     C                   MOVE      'BMP'         trc
050000141209
0501001412090130 C     hiskey        SETLL     histaa
0502001412090131 C                   dou       %eof(histaa)
0503001412090132 C     hiskey        READE     histaa
0504001509250133 C                   if        not %eof(histaa) and
050500150925     C                             covtdt = effymd and tramt < 0
050600150925     C                   eval      pay_ovr = '4'
0507001412090139 C                   leave
0508001412090138 C                   end
050900141209     c                   enddo
051000090720
051100141209      * if no override was found at this point, then show error msg
051200141209      * upon return to calling program
051300150925     c                   if        pay_ovr = *blank
051400090721     C                   eval      parmerr = 'NO INVOICE FOR ENDING BAL'
051500141209     C                   END
051600141209
0517000907200120 C                   ENDSR
051800141211      *
0519001412110103  ***************************************************
0520001412110104  * write to remittance payment history file        *
0521001412110105  ***************************************************
0522001412110107  *
0523001412110106 C     #writerph     BEGSR
052400141211
052500141211      * skip if this is not the bill file run that writes to rpayhis
052600141211     c                   if        parmupdate <> 'Y'
052700141211     C                   leavesr
052800141211     C                   end
052900141211
053000141211     c                   clear                   rypayovr
053100141211
053200160418     C                   move      remitymd      ryrdt
053300141211     c                   move      labrcode      ryacar
053400141211     c                   move      lseq          ryseq
053500141211     C                   EVAL      ryrundt  = %date
053600141211     C                   EVAL      ryrunti  = %time
053700141211     c                   eval      ryTRUST  = Ptrust
053800141211     c                   eval      rySUB    = Psub
053900141211     c                   eval      ryACC    = Pacct
054000141211     c                   move      effymd        ryeffdt
054100141211     c                   eval      ryCAR    = parmcar
054200141211     c                   eval      ryREQPCT = cpayp
054300150925     c                   eval      ryPAYCR  = payments
054400141211     c                   eval      ryENDBAL = totinv
054500141211     c                   eval      ryPAYPCT = paypcto
054600150925     c                   eval      rypayovr = pay_ovr
054700150925     c                   eval      rypayyn  = paid_yn
054800141211
054900141211     c                   write     rpayhisr
055000141211
0551001412110120 C                   ENDSR
055200090720
055300160222     C*
0554001602220103 C*********************************************************************
0555001602220104 C* check for any un-invocied acct adjustments. Read histinv which is
0556001602220104 C* the same logical file used in the invoice.
0557001604180104 C*
0558001604120104 C* 04/12/16 - add additional check to look for unpaid future remittance
0559001604120104 C* months transactions. This was needed to deal with Senior Dental
0560001604120104 C* accts that do not have the last invoice rerun when an acct is
0561001604120104 C* cancelled (because there are too many accts cancelled each month
0562001604120104 C* and it would take too much time) and the cancel credits end up on
0563001604120104 C* the next months invoice which is also next months remittance. With
0564001604150104 C* future months transactions not included in this remittance it is not
0565001604120104 C* valid to use the current acct balance so this check that finds
0566001604120104 C* future months transactions will allow the program to skip the
0567001604180104 C* acct bal check. This will only be used when getpaid is called
0568001604180104 C* from the remittance (remit date parm will be filled in).
0569001602220105 C*********************************************************************
0570001602220120 C     #chkuninv     begsr
057100160222
057200171020     C                   clear                   uninvtrn
057300171020     C                   clear                   futuretrn
057400171020
0575001604180104 C* look for un-invoiced transactions
0576001602220130 C     acckey        SETLL     histinv
0577001602220131 C                   dou       %eof(histinv)
0578001602220132 C     acckey        READE     histinv
0579001602220133 C                   if        not %eof(histinv) and hi_trcode <> 'BMP'
058000160222     C                   eval      uninvtrn = 'Y'
0581001604120139 C                   leavesr
0582001602220138 C                   end
058300160222     c                   enddo
058400160222
058500160418      * if this is the remittance run also check to see if there are any
058600160418      * future remittance months transactions
058700160418     c                   if        remitymd <> 0
058800160412     c     acckey        setgt     invdet
058900160412     c     acckey        readpe    invdet
059000160418     c                   if        %found(invdet) and idcvdt > remitymd
059100160412     c                             and idpaid = 0
059200171020     C                   eval      futuretrn = 'Y'
059300160412     c                   end
059400160418     c                   end
059500160412
0596001602220120 C                   ENDSR
059700160222      *
0598001412110103 C***************************************************
0599001412110104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0600001412110105 C***************************************************
0601001412110107 C*
0602001412110107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0603001412110107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0604001412110107 C*
0605001412110106 C     #DATMY        BEGSR
060600141211     C                   MOVEL     @DATIN        @MD               4 0
060700141211     C                   MOVE      @DATIN        @Y                4 0
060800141211     C                   MOVE      @MD           @DATOU            8 0
060900141211     C                   MOVEL     @Y            @DATOU
061000141211     C                   MOVE      *ZEROS        @DATIN            8 0
0611001412110120 C                   ENDSR
061200141211     C*
061300071001     c     *inzsr        begsr
061400090720     C     acckey        KLIST
061500071001     C                   KFLD                    Ptrust
061600071001     C                   KFLD                    Psub
061700090720     C                   KFLD                    Pacct
0618000710010215
061900090720     C     INKEY         KLIST
062000090720     C                   KFLD                    Ptrust
062100090720     C                   KFLD                    Psub
062200090720     C                   KFLD                    Pacct
062300090720     C                   KFLD                    effymd
062400141209     C                   KFLD                    key_rc
062500090720
062600090720
062700090720     C     HISKEY        KLIST
062800090720     C                   KFLD                    parmtsa
062900090720     C                   KFLD                    trc               3
0630000710010215
063100160418      * remittance run effective date (only filled during the remittance)
063200160418      * check for valid date
063300160418     C                   clear                   remitymd
063400160418     C                   MOVE      parmremymd    dateck            8 0
063500160418     c     *iso          test(de)                dateck
063600160418     c                   if        not %error
063700160418     C                   MOVE      parmremymd    remitymd          8 0
063800160418     c                   end
063900160418
064000071001   9 C                   ENDSR
