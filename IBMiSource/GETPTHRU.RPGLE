0001000907210002  ******************************************************************
0002001805010003  * getpthru   GROUP BENEFIT SERVICES, INC.                        *
0003000907210004  *                                                                *
0004000907210005  *            WRITTEN BY - DAVID KETTERMAN                        *
0005001805010006  *            DATE - 05/01/18                                     *
0006000907210007  *                                                                *
0007001805010013  *  DESCRIPTION - Get paid through date for an account. 100% paid *
0008001805150013  *                will be used. Shelly requested that the last    *
0009001805180007  *                day of the month be shown for active accts but  *
0010001805180007  *                cancelled accounts should not show a date >=    *
0011001805180007  *                the cancel date (1 day less or earlier) so      *
0012001807060007  *                a special overide is needed for cancelled accts.*
0013001805180007  *                                                                *
0014000907210004  *                parameters to pass:                             *
0015000907210007  *                -------------------                             *
0016000907210004  *                1. Trust/sub/acct                               *
0017001805150004  *                2. return - paid through date (last day of month) *
0018001412110004  *                                                                *
0019001412110004  *                                                                *
0020001805020015  *  Call getpthrucl that has the file overrides and clean up tasks*
0021001805220015  *  do not call this program directly.                            *
0022001805220004  *                                                                *
0023001806290035  *  ** This progam is used in: IQ010, stored procedure GETPTDSP   *
0024001806290004  *     which Oleg uses for Advanced Mobile reports,               *
0025001808230004  *                                                                *
0026001808230035  * 08/23/18 dlk - Shelly request - show zero for paid through     *
0027001808230004  *                date when enroll = termdt (same day cancel)     *
0028001809250035  * 09/25/18 dlk - Shelly request - only subtract 1 day from       *
0029001809250004  *                acct cancel date (to be shown as paid through)  *
0030001809250004  *                when cancel day = 01.                           *
0031001808230004  *                                                                *
0032009908180016 F******************************************************************
0033001509220019 FACCMST    IF   E           K DISK
003400141212
0035001805010037 D workdtymd       S               d   datfmt(*iso)
0036001805010037 D workdtnum       S              8s 0
0037000907200152 D                 DS
0038000907200153 D  parmtsa                1     10
0039001805010154 D  Ptrust                 1      3  0 inz
0040001805010154 D  Psub                   4      6  0 inz
0041001805010154 D  Pacct                  7     10  0 inz
004200141211
004300001107     c     *entry        plist
004400090720     c                   parm                    parmkey          10
004500180501     c                   parm                    parmptdate        8
004600090720
004700180515     c                   clear                   error            30
004800180515
004900141211     c* check for missing information
005000180501     c                   if        parmkey = *blanks
005100180515     C                   eval      error = 'MISSING ACCOUNT PARM'
005200180824     C                   goto      #return
005300090720     c                   end
005400090720
005500090720     c                   move      parmkey       parmtsa
005600090721
005700180501      * check acc#
005800180501     c     tsakey        chain     accmst
005900180501     c                   if        not %found(accmst)
006000180515     c                   eval      error = 'INVALID ACCOUNT #'
006100180824     c                   goto      #return
006200180501     c                   end
006300180824
006400180824      * Override for cancelled accounts - do not show a paid date for same
006500180824      * day terms - Shelly request 8/23/18
006600180824      *
006700180824     c                   if        atrmdt = enroll
006800180824     c                   clear                   workdtnum
006900180824     c                   goto      #return
007000180824     c                   end
007100180824
007200180501
007300180501      * starting with the account covered through date check each month
007400180502      * working backwards to the begin adm date until a month is found that
007500180501      * is paid. This is the paid through date. If no month is found paid
007600180501      * then the paid through date will be returned as zero.
007700180501      *
007800180501     c                   eval      workdtymd = %date(acvtdt)
007900180501     c                   eval      workdtnum = acvtdt
008000180501     c                   eval      paidyn   =  'N'
008100180515     c                   clear                   parmerr
008200180515
008300180502     c                   dou       paidyn = 'Y' or workdtnum < gbsbdt
008400180501     c                             or parmerr <> *blanks
008500180501     c* get paid through date using GETPAID program
008600180501     c                   exsr      #getpthrough
008700180501     c                   enddo
008800180501
008900180824
009000180501      * if any error occured, clear field to avoid confusion since
009100180501      * the payment calc would not be completed.
009200180501     c                   if        parmerr <> *blanks or
009300180515     c                             error <> *blanks or
009400180502     c                             workdtnum < gbsbdt
009500180501     C                   clear                   workdtymd
009600180501     C                   clear                   workdtnum
009700180515     c                   else
009800180515      * make it last day of month
009900180515     c                   adddur    1:*M          workdtymd
010000180515     c                   subdur    1:*D          workdtymd
010100180515     c                   move      workdtymd     workdtnum
010200180501     c                   end
010300180501
010400180518      *
010500180518      * Override for cancelled accounts - do not show a paid date past the
010600180522      * cancel date.
010700180522      *
010800180629      * If cancelled acct and paid Y/M  >= cancel Y/M then return date
010900180925      * as the cancel date.
011000180925
011100180522     c                   if        atrmdt <> 0 and workdtnum <> 0
011200180522     c                   movel     workdtnum     workdtnum_ym      6 0
011300180522     c                   movel     atrmdt        atrmdt_ym         6 0
011400180522     c                   if        workdtnum_ym >= atrmdt_ym
011500180522     c                   eval      workdtymd = %date(atrmdt)
011600180925
011700180925      * If cancel day is 01, then subtract 1 day.
011800180925     c                   if        %subdt(workdtymd:*days) = 1
011900180522     c                   subdur    1:*D          workdtymd
012000180925     c                   end
012100180925
012200180522     c                   move      workdtymd     workdtnum
012300180522     c                   end
012400180522     c                   end
012500180823
012600180824     c     #return       tag
012700180518      * pass back date found
012800180501     c                   move      workdtnum     parmptdate
012900071001
013000071001   9 C                   return
013100141209
013200141209
013300180501      ***********************************
013400180501      * get paid through date
013500180501      ***********************************
013600180501     c     #getpthrough  begsr
013700180501
013800180501     c                   eval      parmremymd = *zeros
013900180501     c                   eval      parmeffymd = %editc(workdtnum:'X')
014000180501      * use carrier <a> for 100% payment due
014100180501     c                   eval      parmcar = '<a>'
014200180501     c                   eval      parmupdate = 'N'
014300180501
014400180501     c                   clear                   parmpaid
014500180501     c                   clear                   parmerr
014600180501     c                   clear                   parminveb
014700180501     c                   clear                   parmpayments
014800180501     c                   clear                   parmcredits
014900180501     c                   clear                   parmdebits
015000180501     c                   clear                   errout           30
015100180501     c                   clear                   paidyn            1
015200180501
015300180501     c                   call      'GETPAIDCL'   grplist
015400180501
015500180501     c                   if        parmpaid = 'Y'
015600180501     c                   eval      paidyn = 'Y'
015700180501     c                   else
015800180501     c                   eval      paidyn = 'N'
015900180501     c                   subdur    1:*M          workdtymd
016000180501     c                   move      workdtymd     workdtnum
016100180501     c                   end
016200180501
016300180501     c                   endsr
016400160222      *
016500071001     c     *inzsr        begsr
016600180501
016700180501     c     grplist       plist
016800180501     c                   parm                    parmkey          10
016900180501     c                   parm                    parmremymd        8
017000180501     c                   parm                    parmeffymd        8
017100180501     c                   parm                    parmcar           3
017200180501     c                   parm                    parmupdate        1
017300180501     c                   parm                    parmpaid          1
017400180501     c                   parm                    parmerr          35
017500180501     c                   parm                    parminveb        10 2
017600180501     c                   parm                    parmpayments     10 2
017700180501     c                   parm                    parmcredits      10 2
017800180501     c                   parm                    parmdebits       10 2
017900180501
018000180501     c     tsakey        klist
018100071001     C                   KFLD                    Ptrust
018200071001     C                   KFLD                    Psub
018300090720     C                   KFLD                    Pacct
0184000710010215
018500071001   9 C                   ENDSR
