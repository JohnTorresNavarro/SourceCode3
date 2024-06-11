0001000907210002  ******************************************************************
0002002108110003  * getpaid2   GROUP BENEFIT SERVICES                              *
0003000907210004  *                                                                *
0004000907210005  *            WRITTEN BY - DAVID KETTERMAN                        *
0005002108110006  *            DATE - 08/11/21                                     *
0006000907210007  *                                                                *
0007000907210013  *  DESCRIPTION - Get paid status for the acct/effdt/carr parm.   *
0008002108110007  *                WITHOUT Payment override # 6. This was needed   *
0009002108170007  *                to avoid recursivly calling GETPAID. It is a    *
0010002108170007  *                copy of GETPAID without override 6 and the      *
0011002108170007  *                RPAYHIS update. It is only intended to be used  *
0012002108170007  *                from GETPAID and it is called from GETPAID2CL   *
0013002108170007  *                (for file override and clean up purposes).      *
0014002108170007  *                                                                *
0015002108110007  *                                                                *
0016002108110007  *                ** Any changes to GETPAID payment logic MUST be *
0017002108110007  *                   duplicated in this program.                  *
0018002108110007  *                                                                *
0019000907210004  *                parameters to pass:                             *
0020000907210007  *                -------------------                             *
0021000907210004  *                1. Trust/sub/acct                               *
0022001604190004  *                2. remittance effdt (YYYYMMDD)-only used for remit
0023001604180004  *                3. payment effdt (YYYYMMDD)                     *
0024001604180004  *                4. carrier                                      *
0025001604180004  *                5. update (Y = Bill file run (DW040)       and  *
0026001502240004  *                           N for all other places that call this)
0027001604180004  *                6. return - paid Y/N                            *
0028001604180004  *                7. return - error message                       *
0029001604180004  *                8. return - invoice ending balance              *
0030001604180004  *                9. return - total payment after invoice         *
0031001604180004  *               10. return - total credits after invoice         *
0032001604180004  *               11. return - total debits after invoice          *
0033000907210004  *                                                                *
0034001412110004  *                                                                *
0035001412110004  *                                                                *
0036002108170015  * 08/11/21 dlk - Created this program to be used to check the    *
0037002108110015  *                account paid status for payment override #6.    *
0038002108170015  *                It does NOT have override 6 (next month check)  *
0039002108110015  *                and it avoids a recursive call.                 *
0040002108110015  *                                                                *
0041002108170015  *                                                                *
0042002108110015  *        ** Any changes to the payment rules must be updated in  *
0043002108110015  *           I:\mis\Carrier Remittance Payment Rules **           *
0044002108110015  *                                                                *
0045002108110007  *        ** Any changes to GETPAID payment logic MUST be         *
0046002108110007  *           duplicated in this program.                          *
0047002108110015  *                                                                *
0048002108110035  *  ** This progam is used in GETPAID2CL which is called in       *
0049002108110004  *     GETPAID.                                                   *
0050002108110004  *                                                                *
0051009908180016 F******************************************************************
0052000907200019 Fhist      IF   E           K DISK
0053000907200019 FHISTAA    IF   E           K DISK    rename(histr:histraa)
0054001602220019 Fhistinv   IF   E           K DISK    rename(histr:histrin) prefix(hi_)
0055001509220019 FACCMST    IF   E           K DISK
0056000907200019 FCARMST    IF   E           K DISK
0057000907200016 Finvsum    IF   E           K DISK
0058001604120016 Finvdet    IF   E           K DISK
0059002108110030 ***Frpayhis   O  A E             DISK
006000141212
0061000907200056 Dpaypct           s             13  4
0062001602220056 Dtotbal           s             10  2
0063001710200056 Dworkbal          s                   like(totbal)
0064001602220056 Duninvtrn         s              1
0065001710200056 Dfuturetrn        s              1
0066001604180037 D workdtmdy       S               d   datfmt(*usa)
0067001710200152 D                 DS
0068001710200153 D  acvtdt                 1      8  0 inz
0069001710200154 D  acvm                   5      6  0
0070000907200152 D                 DS
0071000907200153 D  parmtsa                1     10
0072000907200154 D  Ptrust                 1      3  0
0073000907200154 D  Psub                   4      6  0
0074000907200154 D  Pacct                  7     10  0
0075000907200055 D                 DS
0076000907200056 D  BAL                    1    108  2
007700090720     D                                     DIM(12)
0078000907200056 D  BAL1                   1      9  2
0079000907200056 D  BAL2                  10     18  2
0080000907200056 D  BAL3                  19     27  2
0081000907200056 D  BAL4                  28     36  2
0082000907200056 D  BAL5                  37     45  2
0083000907200056 D  BAL6                  46     54  2
0084000907200056 D  BAL7                  55     63  2
0085000907200056 D  BAL8                  64     72  2
0086000907200056 D  BAL9                  73     81  2
0087000907200056 D  BAL10                 82     90  2
0088000907200056 D  BAL11                 91     99  2
0089000907200056 D  BAL12                100    108  2
009000141211
009100141212      * These values from LDA are used when the update parm is set to "Y"
009200141212      * to write the RPAYHIS record
0093001412110055 D                UDS
0094001412110056 D  lseq                  21     22
0095001604180056 D**LEFFDT                85     92
0096001412110056 D  labrcode             200    200
009700141211
009800001107     c     *entry        plist
009900090720     c                   parm                    parmkey          10
010000160418     c                   parm                    parmremymd        8
010100160418     c                   parm                    parmeffymd        8
010200090720     c                   parm                    parmcar           3
010300141211     c                   parm                    parmupdate        1
010400090720     c                   parm                    parmpaid          1
010500090721     c                   parm                    parmerr          35
010600150224     c                   parm                    parminveb        10 2
010700150224     c                   parm                    parmpayments     10 2
010800150224     c                   parm                    parmcredits      10 2
010900150224     c                   parm                    parmdebits       10 2
011000001107
011100150925     C                   clear                   pay_ovr           1
011200150925     c                   clear                   payments
011300090720     c                   clear                   paypct
011400090720     c                   clear                   paypcto
011500131111     C                   clear                   TOTINV           10 2
011600141209     C                   clear                   TOTINVSAV        10 2
011700090721     C                   clear                   parmerr
011800150224     C                   clear                   parminveb
011900150224     C                   clear                   parmpayments
012000150224     C                   clear                   parmcredits
012100150224     C                   clear                   parmdebits
012200090720
012300150925     c                   move      'N'           paid_yn           1
012400090720
012500141211     c* check for missing information
012600090720     c                   if        parmcar = *blanks or parmkey = *blanks or
012700090720     c                             parmeffymd = *blanks
012800090721     C                   eval      parmerr = 'CARR, ACCT OR EFFDT MISSING'
012900090721     C                   goto      #skpay
013000090720     c                   end
013100090720
013200090720     c                   move      parmkey       parmtsa
013300090720     c                   move      parmeffymd    effymd            8 0
0134001502240136 C                   movel     effymd        effymdym          6 0
013500090721
013600141209     c* calc amount paid
013700141209     c                   exsr      #calcamtpaid
013800141209     c* is it paid?
013900141209     c                   exsr      #isitpaid
014000090720
014100090720     c     #skpay        tag
014200141211
014300141211      * if any error occured, clear field to avoid confusion since
014400141211      * the payment calc would not be completed.
014500141211     c                   if        parmerr <> *blanks
014600150925     C                   clear                   paid_yn
014700141211     c                   end
014800141211
014900071001      * set up parms to be passed back
015000150925     c                   move      paid_yn       parmpaid
015100071001
015200071001   9 C                   return
015300141209
015400141209     C*
0155001412090103 C***************************************************
0156001412090104 C* calculate amount paid                           *
0157001412090105 C***************************************************
0158001412090107 C*
0159001412090106 C     #calcamtpaid  BEGSR
016000141209
016100141209     C     acckey        CHAIN     ACCMST
016200141209     C                   if        not %found(accmst)
016300141209     C                   eval      parmerr = 'ACCT # NOT VALID'
016400141209     C                   leavesr
016500141209     C                   end
016600141209
0167001602220085
016800160222      * calc current account balance
0169001602220144 C                   XFOOT     BAL           TOTBAL
017000141209
017100171020      * see if there are any un-invoiced or future remit month transactions
017200160222     c                   exsr      #chkuninv
017300160222
0174001602220086 C* consider account paid when cancelled with zero or credit balance
0175001710200087 C* and there are no un-invoiced or future remit month transactions
0176001602220160  * Payment Override reason 1
017700171020     c                   if        atrmdt <> 0 and totbal <= 0 and
017800171020     c                             uninvtrn <> 'Y' and futuretrn <> 'Y'
017900150925     c                   eval      pay_ovr = '1'
018000141209     c                   leavesr
018100141209     c                   end
018200141209
0183001412090085 C*
0184001412090086 C* GET INVSUM FOR ENDING BALANCE, IF NO REC - check for credit
0185001412090087 C* balance or payment for effdt of run.
0186001412090087 C*
0187001412090128 C                   MOVE      'KEB'         key_rc            3
0188001412090088 C     INKEY         CHAIN     INVSUM
0189001412090096 C                   if        not %found(invsum)
019000141209     c                   exsr      #noinv
019100141209     c                   leavesr
019200141209     C                   END
019300141209     C*
019400141209     C                   Z-ADD     INENDB        TOTINV
019500141209     C                   Z-ADD     INENDB        TOTINVSAV
0196001412090125 C*
0197001412090126 C* CHECK HISTORY FOR CREDITS & PAYMENTS that occured after the invoice
0198001412090127 C* 11/11/13 - stop including credits in the payment percent
0199001412090127 C*
0200001509250128 C                   clear                   payments         10 2
0201001502240128 C                   clear                   CREDIT           10 2
0202001502240128 C                   clear                   debit            10 2
020300141209
0204001412090130 C     parmtsa       SETLL     HIST
0205001602220131 C                   dou       %eof(hist)
0206001412090132 C     parmtsa       READE     HIST
020700141209     c                   if        %eof(hist)
0208001412090133 C                   leave
020900141209     c                   end
021000141209
0211001412090134 C* skip zero amounts and dates before the invoice
021200141209     c                   if        tramt = 0 or trdate < invdte
021300141209     c                   iter
021400141209     c                   end
021500141209
021600141209     c* if the transaction was done on the same day of the invoice and
021700141209     c* meets this test, it was included on the invoice so skip it.
021800141209     c* else it occured after the invoice the same day so include it
021900141209     c                   if        hinvdt <> 0 and hinvdt <= effymd
0220001412090139 C                   iter
0221001412090138 C                   end
022200141209
022300141209     C*
022400141209     C* ACCUMULATE ALL PAYMENTS (including "ADP" trans) after the invoice
022500141209     C                   if        trcode = 'BMP' or trcode = 'ADP'
0226001509250137 C                   ADD       TRAMT         payments
0227001412090139 C                   iter
0228001412090138 C                   END
022900141209     C*
023000141209     C* ACCUMULATE ALL CREDIT TRANSACTIONS AFTER INVOICE with the
023100141209     C* effective year/month <= the invoice year/month
023200141209     C*
023300141209     C*  6/29/98
023400141209     C*  * BECAUSE CANCEL / REINSTATE ADJUSTMENTS NORMALLY
023500141209     C*    BALANCE TO ZERO, BUT WE ONLY INCLUDE CREDIT
023600141209     C*    TRANSACTIONS IN THE FORMULA, REINSTATED ACCOUNTS
023700141209     C*    WOULD BE MISSED. SO WHEN AN ACCOUNT IS REINSTATED,
023800141209     C*    THE ADJUSTMENTS PREVIOUSLY MADE FROM THE CANCELLATION
023900141209     C*    PROGRAM WILL BE SKIPPED IN THE CALCULATION OF OUTSTANDING
024000141209     C*    BALANCE.
024100141209     C*
024200141209     C* skip all transactions from void invoice
024300141209     C* skip all transactions not on the invoice (because they were
024400141209     C* reversed)
024500141209     C*
024600141209     C*  1/5/99
024700141209     C*  * BECAUSE "PREVIOUS CREDIT APPLIED" & "PREVIOUS CREDIT
024800141209     C*    TRANSFER" NET TO ZERO BUT WE ONLY INCLUDE CREDITS, THE
024900141209     C*    CREDIT WAS INCORRECTLY CALCULATED SO THEY ARE NOW
025000141209     C*    EXCLUDED FROM THE CALCULATION
025100141209
025200141209     C*  8/14/03 - finance request - exclude tr50 credits (plan change)
025300141209     c                   if        hprgnm = 'TR70      ' or
025400141209     c                             hprgnm = 'T190      ' or
025500141209     c                             hprgnm = 'TR50      ' or
025600141209     c                             excinv = 'X' or trcode = 'BCP' or
025700141209     c                             trcode = 'BAC'
025800141209     c                   iter
025900141209     c                   end
026000141209
026100141209     C*
026200141209     C* all transactions compare on year/month only to include prorated
026300141209     C* adjustments
026400141209     C*
0265001412090136 C                   movel     covtdt        hiseffym          6 0
026600141209
026700150224      * credits and debits
026800150224     c                   if        hiseffym <= effymdym
026900150224     c                   if        tramt < 0
0270001412090137 C                   ADD       TRAMT         CREDIT
027100150224     c                   else
0272001502240137 C                   ADD       TRAMT         debit
0273001502240138 C                   end
0274001412090138 C                   END
027500150925
0276001412090139 C                   enddo
027700141209
0278001502240151  * return these values to caller
027900150224     c                   z-add     totinv        parminveb
028000150925     c                   z-add     payments      parmpayments
028100150224     c                   z-add     credit        parmcredits
028200150224     c                   z-add     debit         parmdebits
028300150224
0284001412090151 C* calculate % paid
0285001412090151 C* if the sum of all payments is > 0 (reversals are positive)
0286001412090151 C* then add the amount to the total due and clear the payment
0287001412090151 C* amount before calculating the percent
028800141209
028900150925     c                   if        payments > 0
029000150925     c                   add       payments      totinv
029100150925     c                   clear                   payments
029200141209     c                   end
0293001412090125
0294001412090125  * credit ending balance means nothing due
0295001412090160  * Payment Override reason 2
0296001412090096 C                   if        totinv <= 0
029700150925     C                   eval      pay_ovr = '2'
029800141209     c                   leavesr
029900141209     C                   end
030000141209
030100150925      * 11/11/13 - stop including credits in the payment percent
030200141209     c                   clear                   abspay           10 2
030300150925     c                   eval      abspay = %abs(payments)
030400141209     c     abspay        div       totinv        paypct
030500141209
030600141209     c                   mult      100           paypct
030700141209     c                   z-add     paypct        paypcto          13 2
030800141209      *
030900141209      * Gather info needed to check for enough payment on the invoice
031000141209      *
031100141209      * get current enrollment total on invoice
0312001412090128 C                   clear                   totcurenr
0313001412090128 C                   MOVE      'KCE'         key_rc
0314001412090088 C     INKEY         CHAIN     INVSUM
031500141209     c                   if        %found(invsum)
031600141209     c                   z-add     intot         totcurenr        10 2
031700141209     c                   end
031800141209
031900141215      * get payment total on invoice, only use the amount if it is
032000141215      * negative since a positive amt would indicate a payment reversal
032100141215      * and not an actual credit / payment
0322001412090128 C                   clear                   payoninv         10 2
0323001412090128 C                   MOVE      'KMA'         key_rc
032400141209  93 C     inkey         setll     invsum
032500141209     c                   dou       %eof(invsum)
0326001412090195 C     inkey         reade     invsum
032700141209     c                   if        (not %eof(invsum)) and (intrcd = 'BMP')
032800141215     c                             and (intot < 0)
032900141209     c                   add       intot         payoninv
033000141209      * there is only one payment rec per inv
033100141209     c                   leave
033200141209     c                   end
033300141209     c                   enddo
033400141209
033500141215      * change total to positive
033600141215     c                   eval      payoninv = %abs(payoninv)
033700141215
0338001412090106 C                   endsr
033900141209
0340001412090103 C******************************************************************
0341001412090104 C* determine if this account meets the carrier payment threshold  *
0342001412090105 C******************************************************************
0343001412090107
0344001412090106 C     #isitpaid     BEGSR
034500141209
034600141211      *skip if there is already an error
034700141211     c                   if        parmerr <> *blanks
034800141211     C                   leavesr
034900141211     c                   end
035000141211
035100150925     C                   clear                   paid_yn           1
035200150922     c                   clear                   cpayp
035300150922
035400150922     C* 9/22/15 - special override code <a> = 100% payment required
035500150922     c                   if        parmcar = '<a>'
035600150922     c                   z-add     100           cpayp
035700150922     c                   else
035800150922      * get carrier payment percent
035900141209     C     parmcar       CHAIN     CARMST
036000141209     c                   if        not %found(carmst)
036100141209     C                   eval      parmerr = 'CARRIER NOT VALID'
036200141209     C                   leavesr
036300141209     c                   end
036400141209     c                   z-add     cthresh       cpayp             6 2
036500150922     c                   end
036600150922
036700141209     c* if payment was granted because of an override, write to payment
0368001412090160 C* history file as paid with override reason and skip % check
0369001412090160  *
0370001601280160  * Payment Override Reasons: (if these change, need to update payment
0371001601280107  * -------------------------  rules document in I:/mis/carrier...)
037200160128      *
0373001412090160  * 1 = Cancelled account with zero or credit balance
0374001412090160  * 2 = Credit ending balance (invoice)
0375001710200160  * 3 = Missing invoice - Credit account balance (w/o future inv amt)
0376001412090160  * 4 = Missing invoice - Payment for effective date of bill file run
0377001412090160  * 5 = Payment on invoice reduced ending balance due
0378002108110160  * 6 = Payment for later month found (Not included in this program)
0379001412090160  *
0380001509250152 C                   if        pay_ovr <> *blank
038100150925     C                   eval      paid_yn  = 'Y'
038200210811     c**                 exsr      #writerph
038300141209     C                   leavesr
038400141209     C                   end
038500141209
0386001412090160 C* check payment % required per carrier
0387001412090160 C* if paid % is ge carriers payment % minimum then consider it paid
0388001412090160 C* write to payment history file as paid
038900141209
0390001412090152 C                   if        paypct >= cpayp
039100150925     C                   eval      paid_yn = 'Y'
039200210811     c**                 exsr      #writerph
039300141209     C                   leavesr
0394001412090154 C                   end
0395001412090160
0396001412090160  * 12/4/14 - new rule - was there enough payment on the invoice
0397001412090160  * (that reduced the ending balance) that we should pay the carrier.
0398001412090160  *
0399001412090160  * calcualte threshhold balance
040000141215     c                   clear                   threshpctbal      8 4
040100141209     c                   clear                   threshenrbal     10 2
0402001412090160  *
0403001412090160  * If Ending Balance Due on the invoice (TOTINVSAV) is <=
0404001412090160  * the balance of the current enrollment total without the threshhold
0405001412090160  * percent (THRESHENRBAL)
0406001412090160  * AND a payment exists on the invoice >=
0407001412090160  * the balance of the current enrollment total without the threshhold
0408001412090160  * percent (THRESHENRBAL)
0409001412090160  * then consider this invoice paid due to an override.
0410001412090160  * Payment Override reason 5
0411001412090160  *
041200141209     c                   if        cpayp >= 0 and cpayp <= 100
041300141209     c                   eval      threshpctbal = 100 - cpayp
041400141215      * convert whole number to pct
041500141215     c                   eval      threshpctbal = threshpctbal * .01
041600141215
041700141209     c                   eval      threshenrbal = totcurenr * threshpctbal
041800141209     c                   if        (totinvsav <= threshenrbal) and
041900141209     c                             (payoninv  >= threshenrbal)
042000150925     C                   eval      paid_yn  = 'Y'
042100150925     c                   eval      pay_ovr  = '5'
042200210811     c**                 exsr      #writerph
042300141209     C                   leavesr
042400141209     c                   end
042500141209     c                   end
042600141209
0427002108110160  * Payment Override reason 6
0428002108110160  *  Check for payment for later month
0429002108110160  * 08/11/21 - This rule is not in GETPAID2 by design.
0430002108110160  *
0431002108110160  *
0432002108110160  *
0433002108110160  *
043400210811
043500210811
043600210811
0437001412090160 C* if all the above payment checks did not satisfy the payment rules
0438001412090160 C* then write to payment history file as non pay
043900150925     C                   eval      paid_yn  = 'N'
044000210811     c**                 exsr      #writerph
044100141209
0442001412090106 C                   endsr
044300141209
044400071001
044500090720     C*
0446000907200103 C***************************************************
0447000907200104 C* missing invsum
0448000907200105 C***************************************************
0449000907200120 C     #noinv        begsr
045000141209
0451001710200160  * account has zero or credit balance right now (less any month billed
0452001710200160  * after the remittance) and there are no un-invoiced transactions
0453001412090160  * Payment Override reason 3
045400171020
045500171020     c                   z-add     totbal        workbal
045600171020
045700171020      * if this is the remittance run and the account covered through date
045800171020      * is greater than the remittance date, then back out the covtdt month
045900171020      * bucket from bal since this amount is not due yet
046000171020     c                   if        remitymd <> 0 and acvtdt > remitymd and
046100171020     c                             (acvm > 0 and acvm <13)
046200171020     c                   sub       bal(acvm)     workbal
046300171020     c                   end
046400171020
0465001710200152 C                   if        workbal <= 0 and uninvtrn <> 'Y'
046600150925     C                   eval      pay_ovr = '3'
046700090720     c                   leavesr
046800090720     C                   END
046900090720
047000171002      * look for payment for payment effdt
0471001412090160  * Payment Override reason 4
047200090720
047300090720     C                   MOVE      'BMP'         trc
047400141209
0475001412090130 C     hiskey        SETLL     histaa
0476001412090131 C                   dou       %eof(histaa)
0477001412090132 C     hiskey        READE     histaa
0478001509250133 C                   if        not %eof(histaa) and
047900150925     C                             covtdt = effymd and tramt < 0
048000150925     C                   eval      pay_ovr = '4'
0481001412090139 C                   leave
0482001412090138 C                   end
048300141209     c                   enddo
048400090720
048500141209      * if no override was found at this point, then show error msg
048600141209      * upon return to calling program
048700150925     c                   if        pay_ovr = *blank
048800090721     C                   eval      parmerr = 'NO INVOICE FOR ENDING BAL'
048900141209     C                   END
049000141209
0491000907200120 C                   ENDSR
049200141211      *
0493001412110103  ***************************************************
0494001412110104  * write to remittance payment history file        *
0495001412110105  ***************************************************
0496001412110107  *
0497002108110106 C**   #writerph     BEGSR
049800141211
049900141211      * skip if this is not the bill file run that writes to rpayhis
050000210811     c**                 if        parmupdate <> 'Y'
050100210811     C**                 leavesr
050200210811     C**                 end
050300141211
050400210811     c**                 clear                   rypayovr
050500141211
050600210811     C**                 move      remitymd      ryrdt
050700210811     c**                 move      labrcode      ryacar
050800210811     c**                 move      lseq          ryseq
050900210811     C**                 EVAL      ryrundt  = %date
051000210811     C**                 EVAL      ryrunti  = %time
051100210811     c**                 eval      ryTRUST  = Ptrust
051200210811     c**                 eval      rySUB    = Psub
051300210811     c**                 eval      ryACC    = Pacct
051400210811     c**                 move      effymd        ryeffdt
051500210811     c**                 eval      ryCAR    = parmcar
051600210811     c**                 eval      ryREQPCT = cpayp
051700210811     c**                 eval      ryPAYCR  = payments
051800210811     c**                 eval      ryENDBAL = totinv
051900210811     c**                 eval      ryPAYPCT = paypcto
052000210811     c**                 eval      rypayovr = pay_ovr
052100210811     c**                 eval      rypayyn  = paid_yn
052200141211
052300210811     c**                 write     rpayhisr
052400141211
0525002108110120 C**                 ENDSR
052600090720
052700160222     C*
0528001602220103 C*********************************************************************
0529001602220104 C* check for any un-invocied acct adjustments. Read histinv which is
0530001602220104 C* the same logical file used in the invoice.
0531001604180104 C*
0532001604120104 C* 04/12/16 - add additional check to look for unpaid future remittance
0533001604120104 C* months transactions. This was needed to deal with Senior Dental
0534001604120104 C* accts that do not have the last invoice rerun when an acct is
0535001604120104 C* cancelled (because there are too many accts cancelled each month
0536001604120104 C* and it would take too much time) and the cancel credits end up on
0537001604120104 C* the next months invoice which is also next months remittance. With
0538001604150104 C* future months transactions not included in this remittance it is not
0539001604120104 C* valid to use the current acct balance so this check that finds
0540001604120104 C* future months transactions will allow the program to skip the
0541001604180104 C* acct bal check. This will only be used when getpaid is called
0542001604180104 C* from the remittance (remit date parm will be filled in).
0543001602220105 C*********************************************************************
0544001602220120 C     #chkuninv     begsr
054500160222
054600171020     C                   clear                   uninvtrn
054700171020     C                   clear                   futuretrn
054800171020
0549001604180104 C* look for un-invoiced transactions
0550001602220130 C     acckey        SETLL     histinv
0551001602220131 C                   dou       %eof(histinv)
0552001602220132 C     acckey        READE     histinv
0553001602220133 C                   if        not %eof(histinv) and hi_trcode <> 'BMP'
055400160222     C                   eval      uninvtrn = 'Y'
0555001604120139 C                   leavesr
0556001602220138 C                   end
055700160222     c                   enddo
055800160222
055900160418      * if this is the remittance run also check to see if there are any
056000160418      * future remittance months transactions
056100160418     c                   if        remitymd <> 0
056200160412     c     acckey        setgt     invdet
056300160412     c     acckey        readpe    invdet
056400160418     c                   if        %found(invdet) and idcvdt > remitymd
056500160412     c                             and idpaid = 0
056600171020     C                   eval      futuretrn = 'Y'
056700160412     c                   end
056800160418     c                   end
056900160412
0570001602220120 C                   ENDSR
057100160222      *
0572001412110103 C***************************************************
0573001412110104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0574001412110105 C***************************************************
0575001412110107 C*
0576001412110107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0577001412110107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0578001412110107 C*
0579001412110106 C     #DATMY        BEGSR
058000141211     C                   MOVEL     @DATIN        @MD               4 0
058100141211     C                   MOVE      @DATIN        @Y                4 0
058200141211     C                   MOVE      @MD           @DATOU            8 0
058300141211     C                   MOVEL     @Y            @DATOU
058400141211     C                   MOVE      *ZEROS        @DATIN            8 0
0585001412110120 C                   ENDSR
058600141211     C*
058700071001     c     *inzsr        begsr
058800090720     C     acckey        KLIST
058900071001     C                   KFLD                    Ptrust
059000071001     C                   KFLD                    Psub
059100090720     C                   KFLD                    Pacct
0592000710010215
059300090720     C     INKEY         KLIST
059400090720     C                   KFLD                    Ptrust
059500090720     C                   KFLD                    Psub
059600090720     C                   KFLD                    Pacct
059700090720     C                   KFLD                    effymd
059800141209     C                   KFLD                    key_rc
059900090720
060000090720
060100090720     C     HISKEY        KLIST
060200090720     C                   KFLD                    parmtsa
060300090720     C                   KFLD                    trc               3
0604000710010215
060500160418      * remittance run effective date (only filled during the remittance)
060600160418      * check for valid date
060700160418     C                   clear                   remitymd
060800160418     C                   MOVE      parmremymd    dateck            8 0
060900160418     c     *iso          test(de)                dateck
061000160418     c                   if        not %error
061100160418     C                   MOVE      parmremymd    remitymd          8 0
061200160418     c                   end
061300160418
061400071001   9 C                   ENDSR
