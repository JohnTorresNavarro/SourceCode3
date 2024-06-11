0001000907210002  ******************************************************************
0002002105180003  * getptc     GROUP BENEFIT SERVICES, INC.                        *
0003000907210004  *                                                                *
0004000907210005  *            WRITTEN BY - DAVID KETTERMAN                        *
0005002105180006  *            DATE - 05/18/21                                     *
0006000907210007  *                                                                *
0007002105180013  *  DESCRIPTION - Get paid through date for a COBRA member.       *
0008001805180007  *                                                                *
0009000907210004  *                parameters to pass:                             *
0010000907210007  *                -------------------                             *
0011002105180004  *                1. Member SSN                                   *
0012002105180004  *                2. return - paid through date (YYYYMMDD)        *
0013002105200004  *                3. return - invoiced through date (YYYYMMDD)    *
0014002105200004  *                4. return - total payments                      *
0015002105200004  *                5. return - payment override                    *
0016001412110004  *                                                                *
0017001412110004  *                                                                *
0018002105180015  *  Call getptccl that has the file overrides and clean up tasks  *
0019001805220015  *  do not call this program directly.                            *
0020001805220004  *                                                                *
0021002109300035  *  ** This progam is used in: IQ010, DW040, COB030               *
0022002105180004  *                                                                *
0023002105270004  * 05/27/21 - subtract 1 month from cobra begin date for use      *
0024002105270004  *            as payment search begin date since a member can     *
0025002105270004  *            be set up and a payment posted prior to the         *
0026002105270004  *            effective date of extension.                        *
0027002106230004  * 06/23/21 - skip calcs if member is not cobra at this time and  *
0028002106230004  *            return an override code '2'.                        *
0029002106240004  * 06/24/21 - add date check to avoid date conversion error       *
0030002109300004  * 09/30/21 - do invoice serach using begin admin date as 1st     *
0031002109300004  *            of the month to catch first month invoice when      *
0032002109300004  *            begin admin is not the 1st of the month.            *
0033002109300004  *                                                                *
0034009908180016 F******************************************************************
0035002105180019 Fmember    IF   E           K DISK
0036002105180019 Finvcobl1  IF   E           K DISK
0037002105180019 Fhistaa    IF   E           K DISK
003800141212
0039001805010037 D workdtymd       S               d   datfmt(*iso)
0040001805010037 D workdtnum       S              8s 0
0041002105180037 D ssn_hkey        S             10
0042002105180037 D ssn_num         S              9s 0
0043002105200037 D totpay          S             11s 2
0044002105180037 D wkpay           S                   like(totpay)
0045002105180037 D ptdate          S              8s 0
0046002105200037 D itdate          S              8s 0
0047002109300037 D gbscdt_less1m   S              8s 0
0048002105200037 D payovr          S                   like(parmpayovr)
004900141211
005000001107     c     *entry        plist
005100210518     c                   parm                    parmssn           9
005200180501     c                   parm                    parmptdate        8
005300210520     c                   parm                    parmitdate        8
005400210520     c                   parm                    parmpayments     11 2
005500210520     c                   parm                    parmpayovr        1
005600090720
005700180515     c                   clear                   error            30
005800210518     c                   clear                   ptdate
005900210520     c                   clear                   itdate
006000210520     c                   clear                   totpay
006100210520     c                   clear                   payovr
006200180515
006300141211     c* check for missing information
006400210518     c                   if        parmssn = *blanks
006500210518     C                   eval      error = 'MISSING SSN PARM'
006600180824     C                   goto      #return
006700090720     c                   end
006800090720
006900210518     c                   move      parmssn       ssn_hkey
007000210518     c                   move      parmssn       ssn_num
007100090721
007200210518      * check member
007300210518     c     ssn_num       chain     member
007400210518     c                   if        not %found(member)
007500210518     c                   eval      error = 'INVALID SSN'
007600180824     c                   goto      #return
007700180501     c                   end
007800210520
007900210520      * invoiced through date
008000210520     c                   move      cvthdt        itdate
008100180824
008200210520      * payment override:
008300210520      * 1 = cancelled member with zero or credit balance
008400210623      * 2 = member not COBRA at this time
008500210520
008600210623     c                   if        cexpdt = 0 or gbscdt = 0
008700210623     c                   eval      payovr = '2'
008800210623     C                   goto      #return
008900210623     c                   end
009000210623
009100210520     c                   if        termdt <> 0 and
009200210520     c                             (curbal + prvbal) <= 0
009300210520     c                   eval      payovr = '1'
009400210520     c                   end
009500210623
009600210624      *
009700210624      * cobra begin date - 1 month
009800210624      * if an invalid begin date then use 1980 as the start and all payments
009900210624      * will be used from the beginning of time
010000210624
010100210624        monitor;
010200210624         workdtymd = %date(gbscdt:*iso) - %months(1);
010300210624        on-error;
010400210624          workdtymd = d'1980-01-01';
010500210624        endmon;
010600210624
010700210930        gbscdt_less1m = %dec(workdtymd:*ISO);
010800210624        clear workdtymd;
010900210527
011000210624      *
011100210624      * Count all payments during this extension period (cobra begin admin
011200210624      * date - 1 month in case a payment is posted before cobra begins).
011300210624      * No stop date used because payment can come in after cobra ends.
011400210624      *
0115002105180130 C     ssn_hkey      SETLL     HISTaa
0116002105180131 C                   dou       %eof(histaa)
0117002105180132 C     ssn_hkey      READE     HISTaa
011800210518     c                   if        not %eof(histaa) and
0119002105180133 c                             (trcode = 'BMP' or trcode = 'BPP') and
012000210930     c                             (trdate >= gbscdt_less1m)
012100210518     c                   add       tramt         totpay
012200210518     c                   end
012300210518     c                   enddo
012400210518
012500210518      * Next, read all invoices in order and apply the payments to each
012600210518      * invoice unitl all money is used up. The last invoice with the full
012700210518      * total paid is the paid through month
012800210518
012900210518     c                   z-add     totpay        wkpay
013000210518
013100210930      * if payment total is > 0 then there are more reversals than payments
013200210519      * so skip the check
013300210519     c                   if        wkpay > 0
013400210518     c                   goto      #return
013500210518     c                   end
013600210518
013700210930      * search using 1st of month to catch those that do not have a begin
013800210930      * admin of the 1st
013900210930     c                   move      gbscdt        gbscdt01          8 0
014000210930     c                   move      01            gbscdt01
014100210930
0142002105180130 C     ssn_num       SETLL     invcobl1
0143002105180131 C                   dou       %eof(invcobl1) or wkpay > 0
0144002105180132 C     ssn_num       READE     invcobl1
014500210518     c                   if        not %eof(invcobl1) and
014600210930     c                             iceffdt >= gbscdt01
014700210518      * reduce payment total by amount invoiced
014800210518     c                   add       ictramt       wkpay
014900210518      * if still money left, save this effedt and check next invoice
015000210518     c                   if        wkpay <= 0
015100210518     c                   move      iceffdt       ptdate
015200210518     c                   end
015300210518
015400210518     c                   end
015500210518     c                   enddo
015600210519
015700210519      * if a paid through date was found then make it the last day of
015800210519      * the month
015900210519     c                   if        ptdate <> 0
016000210519     c                   eval      workdtymd = %date(ptdate)
016100210519     c                   adddur    1:*M          workdtymd
016200210519     c                   subdur    1:*D          workdtymd
016300210519     c                   move      workdtymd     ptdate
016400210519     c                   end
016500210519
016600210519
016700180824     c     #return       tag
016800210520      * pass back values found
016900210518     c                   move      ptdate        parmptdate
017000210520     c                   move      itdate        parmitdate
017100210520     c                   move      totpay        parmpayments
017200210520     c                   move      payovr        parmpayovr
017300071001
017400071001   9 C                   return
