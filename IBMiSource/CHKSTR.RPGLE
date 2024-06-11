000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300111214    ? *  Description:  Start Date Calculation Tool
000400000000    ? *
000500111214    ? *  (c)Copyright 2011 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000601111214    ?FMEMBER    IF   E           K DISK
000602111214    ?FPLNMST    IF   E           K DISK
000603111214    ?FWEBPAYROLLIF   E           K DISK
000604111215     fPAYDEDL1  if   e           K disk
000605111215     fPAYDEDANL1if   e           K disk
000611110622
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100110901    ?D WTM             S             80    DIM(13) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001101110110    ? *
001102111214     D Today           s              8S 0 inz
001103111214     D w80date         s              8S 0 inz
001104111214
001105111214    ?D usatoday        S               D   datfmt(*usa)                         Input Request
001106111214    ?D isotoday        S               D   datfmt(*iso)                         Input Request
001107111215    ?D usappbdt        S               D   datfmt(*usa)                         Input Request
001108111215    ?D usastart        S               D   datfmt(*usa)                         Input Request
001109111214
001110111214     d weeks           s              2s 0 inz
001111111215     d days            s              3s 0 inz
001112111215     d mons            s              3s 0 inz
001113111215     d wrkdays         s              3s 0 inz
001114111215     d wrkrem          s              3s 0 inz
001115111220     d wd1             s              3s 0 inz
001116111220     d wd2             s              3s 0 inz
001117111220     d wm1             s              3s 0 inz
001118111220     d wm2             s              3s 0 inz
001119111220     d wswait          s              3s 0 inz
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500111214    ?D WUDTA         E DS                  EXTNAME(WEBSTARTP)
001600000810    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *___________________________________________________________________
002000000000    ? * Process check request
002100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002200000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002300000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002400000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002500000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002600000000    ?C                   Endcs                                                  END CASE
002700000000    ?C                   Return                                                 RETURN
002800000000    ? *___________________________________________________________________
002900000000    ? * Edit record
003000000000    ? *___________________________________________________________________
003100000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003200000810    ? *
003300000810    ? * Defualt Data
003400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003414110613    ? *
003415111214    ? * Validate SSN
003421111214     C     STSSN         Chain     MEMBER
003422110613     C                   If        not %found(MEMBER)
003423110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003424111214    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003425110613    ?C                   Exsr      SNDMSG                                       SEND MSG
003426111214     C                   LeaveSR
003433111019     C                   End
003442110613    ? *
003443110613    ? * Validate Plan
003444110613     C     PLNKEY        Klist
003445111214     C                   kfld                    STTRS
003446111214     C                   kfld                    STSUB
003447111214     C                   kfld                    STPLN
003450110613     C     PLNKEY        Chain     PLNMST
003451110613     C                   If        not %found(PLNMST)
003452110613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003453111214    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
003454110613    ?C                   Exsr      SNDMSG                                       SEND MSG
003455111214     C                   LeaveSR
003462110613     C                   End
003463111215    ? *
003464111215    ? * Pay Freq Override
003471111215     C                   Select
003472111215     C                   When      %trim(STPFQ) = 'WKY'
003473111215     C                   When      %trim(STPFQ) = 'BW1'
003474111215     C                   When      %trim(STPFQ) = 'SEM'
003475111215     C                   When      %trim(STPFQ) = 'MTH'
003476111215     C                   When      %trim(STPFQ) = 'QTR'
003477111215     C                   Other
003478111215    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003479111215    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
003480111215    ?C                   Exsr      SNDMSG                                       SEND MSG
003481111215     C                   LeaveSR
003482111215     C                   Endsl
003492110613    ? *
003493111214    ? * Validate Period Date
003496111214     C                   Movel     STPPBDT       Input_Date
003497110523     C                   Exsr      FMTDATE
003498110523     C                   If        Output_Error <> *Blanks
003499110523    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003500111214    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
003501110523    ?C                   Exsr      SNDMSG                                       SEND MSG
003502110523     C                   LeaveSR
003503110523     C                   End
003504111215    ? *
003505111215    ? * Validate Today Date Override
003506111215     C                   If        STTODAY > 0
003507111215     C                   Movel     STTODAY       Input_Date
003508111215     C                   Exsr      FMTDATE
003509111215     C                   If        Output_Error <> *Blanks
003510111215    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003511111215    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
003512111215    ?C                   Exsr      SNDMSG                                       SEND MSG
003513111215     C                   LeaveSR
003514111215     C                   End
003515111215     C                   End
003516111214
003517111214     C     PAYKEY        Klist
003518111214     C                   kfld                    STTRS
003519111214     C                   kfld                    STSUB
003520111214     C                   kfld                    STACT
003521111214     C                   kfld                    STSSN
003522111214     C     PAYKEY        Chain     WEBPAYROLL
003523111214     C                   If        not %found(WEBPAYROLL)
003524111214    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003525111215    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
003526111214    ?C                   Exsr      SNDMSG                                       SEND MSG
003527111214     C                   LeaveSR
003528111214     C                   End
003529111214    ? *
003530111214    ? * If still here calculate the Start Date
003531111220     C                   Clear                   usappbdt
003532111220     C                   Clear                   usatoday
003533111220     C                   Clear                   today
003534111220     C                   Clear                   w80date
003535111220     C                   Clear                   wswait
003536111215    ? *
003537111215     C     *usa          Move      STPPBDT       usappbdt
003538111215     C                   If        STTODAY > 0
003539111215     C     *usa          Move      STTODAY       usatoday
003540111215     C                   eval      Today = STTODAY
003541111215     C                   Else
003542111215     C                   eval      w80date = %int(%char(%date : *usa0))
003543111215     C     *usa          Move      w80date       usatoday
003544111215     C                   eval      sttoday = w80date
003545111215     C                   eval      Today = w80date
003546111215     C                   End
003547111220    ? *
003548111220    ? * Add Waiting Period
003549111220     C                   Exsr      GETPC
003550111220     C                   Select
003551111220     C                   When      wswait = 30
003552111220     C                   Adddur    1:*m          usatoday
003554111220     C                   When      wswait = 60
003555111220     C                   Adddur    2:*m          usatoday
003557111220     C                   When      wswait = 90
003558111220     C                   Adddur    3:*m          usatoday
003560111220     C                   When      wswait = 120
003561111220     C                   Adddur    4:*m          usatoday
003563111220     C                   When      wswait = 150
003564111220     C                   Adddur    5:*m          usatoday
003566111220     C                   When      wswait = 180
003567111220     C                   Adddur    6:*m          usatoday
003569111220     C                   When      wswait = 365
003570111220     C                   Adddur    12:*m         usatoday
003572111220     C                   When      wswait = 730
003573111220     C                   Adddur    24:*m         usatoday
003575111220     C                   When      wswait > 730
003576111220     C                   Adddur    24:*m         usatoday
003578111220     C                   Endsl
003579111220     C**   *usa          Move      usatoday      STTODAY
003580111220     C     *usa          Move      usatoday      Today
003581111215    ? *
003582111215     C                   If        %trim(STPFQ) <> *blanks
003583111215     C                   Eval      PYPFQ = STPFQ
003584111215     C                   End
003585111215    ? *
003586111214     C                   Select
003587111214     C                   When      %trim(PYPFQ) = 'WKY'
003588111214     C                   Eval      Days  = 07
003589111215     C                   Exsr      CLCWKY
003590111214     C                   When      %trim(PYPFQ) = 'BW1'
003591111214     C                   Eval      Days  = 14
003592111215     C                   Exsr      CLCBW1
003593111214     C                   When      %trim(PYPFQ) = 'SEM'
003594111215     C                   Eval      Mons  = 1
003595111215     C                   Exsr      CLCSEM
003596111214     C                   When      %trim(PYPFQ) = 'MTH'
003597111215     C                   Eval      Mons  = 1
003598111215     C                   Exsr      CLCMTH
003599111214     C                   When      %trim(PYPFQ) = 'QTR'
003600111215     C                   Eval      Mons  = 3
003601111215     C                   Exsr      CLCQTR
003602111214     C                   Endsl
003603110523    ? *
005800010913    ?C                   Endsr                                                  END DLT RQST
005900000000    ? *___________________________________________________________________
006000111214    ? * Calculate Weekly
006100000000    ? *___________________________________________________________________
006200111214    ?C     CLCWKY        Begsr                                                  EDIT DELETE RQS
006205111214    ? *
006206111214    ? * find number days between ppstart and today.
006207111214    ? * divide by weeks(7 days) to get the remaning days.
006208111214    ? * subtract the remainder to get the current pp begin date
006209111214    ? *
006210111215     C     usatoday      subdur    usappbdt      wrkdays:*d
006211111215     C                   eval      wrkrem  = %rem(wrkdays:days)
006212111215     C     usatoday      subdur    wrkrem:*d     usatoday
006213111214     C     *usa          Move      usatoday      ststart
006214111215    ? *
006215111215     C                   Exsr      GETPC
006216111215     C                   If        WWPCMT = 'P'
006217111215     C     *usa          Move      Today         usatoday
006218111215     C                   Subdur    1:*M          usatoday
006219111215     C     usatoday      subdur    usappbdt      wrkdays:*d
006220111215     C                   eval      wrkrem  = %rem(wrkdays:days)
006221111215     C     usatoday      subdur    wrkrem:*d     usatoday
006222111215     C     *usa          Move      usatoday      ststart
006223111215     C                   End
006224100617    ? *
006300000000    ?C                   Endsr                                                  END DLT RQST
006301111215    ? *___________________________________________________________________
006302111215    ? * Calculate Bi-Weekly
006303111215    ? *___________________________________________________________________
006304111215    ?C     CLCBW1        Begsr                                                  EDIT DELETE RQS
006309111215    ? *
006310111215    ? * find number days between ppstart and today.
006311111215    ? * divide by weeks(14 days) to get the remaning days.
006312111215    ? * subtract the remainder to get the current pp begin date
006313111215    ? *
006314111215     C     usatoday      subdur    usappbdt      wrkdays:*d
006315111215     C                   eval      wrkrem  = %rem(wrkdays:days)
006316111215     C     usatoday      subdur    wrkrem:*d     usatoday
006317111215     C     *usa          Move      usatoday      ststart
006318111215    ? *
006319111215     C                   Exsr      GETPC
006320111215     C                   If        WWPCMT = 'P'
006321111215     C     *usa          Move      Today         usatoday
006322111215     C                   Subdur    1:*M          usatoday
006323111215     C     usatoday      subdur    usappbdt      wrkdays:*d
006324111215     C                   eval      wrkrem  = %rem(wrkdays:days)
006325111215     C     usatoday      subdur    wrkrem:*d     usatoday
006326111215     C     *usa          Move      usatoday      ststart
006327111215     C                   End
006328111215    ? *
006329111215    ?C                   Endsr                                                  END DLT RQST
006330111215    ? *___________________________________________________________________
006331111215    ? * Calculate Sem-Monthly
006332111215    ? *___________________________________________________________________
006333111215    ?C     CLCSEM        Begsr                                                  EDIT DELETE RQS
006334111215    ? *
006335111215    ? * find number days between ppstart and today.
006336111215    ? * divide by weeks(14 days) to get the remaning days.
006337111215    ? * subtract the remainder to get the current pp begin date
006338111215    ? *
006339111215
006340111215     C                   Extrct    usatoday:*d   days
006341111219     C                   if        days <= 15
006342111215     C                   Eval      days = days - 1
006343111215     C     usatoday      Subdur    days:*d       usatoday
006344111219     C***  usatoday      adddur    1:*m          usatoday
006345111215     C                   Else
006346111215     C                   Eval      days = days - 1
006347111215     C     usatoday      Subdur    days:*d       usatoday
006348111215     C     usatoday      adddur    15:*d         usatoday
006349111215     C                   End
006350111215    ? *
006351111215     C     *usa          Move      usatoday      ststart
006352111215    ? *
006353111215     C                   Exsr      GETPC
006354111215     C                   If        WWPCMT = 'P'
006356111215     C                   Subdur    1:*M          usatoday
006360111215     C     *usa          Move      usatoday      ststart
006361111215     C                   End
006362111215    ? *
006363111215    ?C                   Endsr                                                  END DLT RQST
006364111215    ? *___________________________________________________________________
006365111215    ? * Calculate Monthly
006366111215    ? *___________________________________________________________________
006367111215    ?C     CLCMTH        Begsr                                                  EDIT DELETE RQS
006368111215    ? *
006369111215    ? * Add a month until PP date is greater or equal to today
006370111215    ? * Paid monthly on the same day of each month
006371111215    ? *
006372111220     C                   Extrct    usappbdt:*d   wd1
006373111215     C                   Dou       usappbdt >= usatoday
006374111215     C     usappbdt      adddur    Mons:*m       usappbdt
006375111215     C                   Enddo
006376111220    ? *
006377111220    ? * Always Keep Same Day
006378111220     C                   Extrct    usappbdt:*d   wd2
006379111220     C                   If        wd1 <> wd2
006380111220     C                   Eval      days = wd2 - 1
006381111220     C                   If        days <= 0
006382111220     C                   Eval      days = 1
006383111220     C                   End
006384111220     C                   Eval      wd1 = wd1 - 1
006385111220     C     usappbdt      Subdur    days:*d       usappbdt
006386111220     C     usappbdt      Adddur    wd1:*d        usappbdt
006387111220     C                   End
006388111220     C                   Extrct    usappbdt:*d   wd1
006389111220     C                   Extrct    usatoday:*d   wd2
006390111220     C**                 If        wd2 < wd1
006391111220     C     usappbdt      Subdur    1:*m          usappbdt
006392111220     C**                 End
006393111220    ? *
006394111220    ? * If not same month then we went over to next month, back up.
006395111220     C**                 Extrct    usappbdt:*m   wm1
006396111220     C**                 Extrct    usatoday:*m   wm2
006397111220     C**                 If        wm1 <> wm2
006398111220     C**   usappbdt      subdur    1:*m          usappbdt
006399111220     C**                 End
006400111215    ? *
006401111215     C     *usa          Move      usappbdt      ststart
006402111215    ? *
006403111215     C                   Exsr      GETPC
006404111215     C                   If        WWPCMT = 'P'
006405111215     C                   Subdur    1:*M          usappbdt
006406111215     C     *usa          Move      usappbdt      ststart
006407111215     C                   End
006408111215    ? *
006409111215    ?C                   Endsr                                                  END DLT RQST
006410111215    ? *___________________________________________________________________
006411111215    ? * Calculate Quarterly
006412111215    ? *___________________________________________________________________
006413111215    ?C     CLCQTR        Begsr                                                  EDIT DELETE RQS
006414111215    ? *
006415111215    ? * Add 3 months until PP date is greater or equal to today
006416111215    ? * Paid quarterly on the same day of each quarter
006417111215    ? *
006418111220     C                   Extrct    usappbdt:*d   wd1
006419111215     C                   Dou       usappbdt >= usatoday
006420111215     C     usappbdt      adddur    Mons:*m       usappbdt
006421111215     C                   Enddo
006422111220    ? *
006423111220    ? * Always Keep Same Day
006424111220     C                   Extrct    usappbdt:*d   wd2
006425111220     C                   If        wd1 <> wd2
006426111220     C                   Eval      days = wd2 - 1
006427111220     C                   If        days <= 0
006428111220     C                   Eval      days = 1
006429111220     C                   End
006430111220     C                   Eval      wd1 = wd1 - 1
006431111220     C     usappbdt      Subdur    days:*d       usappbdt
006432111220     C     usappbdt      Adddur    wd1:*d        usappbdt
006433111220     C                   End
006434111220    ? *
006435111220    ? * Adjust for "C" 1 month is good enough for the QTR start date
006436111220     C                   Subdur    1:*M          usappbdt
006437111215    ? *
006438111215     C     *usa          Move      usappbdt      ststart
006439111215    ? *
006440111215     C                   Exsr      GETPC
006441111215     C                   If        WWPCMT = 'P'
006442111215     C                   Subdur    1:*M          usappbdt
006443111215     C     *usa          Move      usappbdt      ststart
006444111215     C                   End
006445111215    ? *
006446111215    ?C                   Endsr                                                  END DLT RQST
006447111214    ? *___________________________________________________________________
006448111215    ? * Get P/C
006449111214    ? *___________________________________________________________________
006450111215    ?C     GETPC         Begsr                                                  EDIT DELETE RQS
006451111215
006452111220     C                   Eval      WSWAIT = *zeros
006453111215     C                   Eval      WWPCMT = *blanks
006454111220     C     Today         Mult      10000.0001    w80date
006455111215
006456111215      * Standard Payroll Deductions
006457111215     C     PDKEYAMT      Setll     PAYDEDL1
006458111215     C     PDKEYAMT      Reade     PAYDEDL1
006459111215     C                   Dow       not %eof(PAYDEDL1)
006460111215     C                   If        %trim(pybpc) = %trim(pdrule) and
006461111215     C                             'TIN' = %trim(pdcvtp)
006462111215     C                   If        w80date >= pdbedt and
006463111215     C                             w80date <= pdendt
006464111215     C                   Eval      WWPCMT = PDPCMT
006465111220     C                   Move      PDWAIT        WWAIT
006466111220     C                   Eval      WSWAIT = PDWAIT
006467111215     C                   LeaveSR
006468111215     C                   End
006469111215     C                   End
006470111215     C     PDKEYAMT      Reade     PAYDEDL1
006471111215     C                   Enddo
006472111215
006473111215      * Ancillary Payroll Deductions
006474111215     C     PDKEYAMT      Setll     PAYDEDANL1
006475111215     C     PDKEYAMT      Reade     PAYDEDANL1
006476111215     C                   Dow       not %eof(PAYDEDANL1)
006477111215     C                   If        %trim(pybpc) = %trim(parule)
006478111215     C                   If        w80date >= pabedt and
006479111215     C                             w80date <= paendt
006480111220     C                   Eval      WWPCMT = PAPCMT
006481111220     C                   Move      PAWAIT        WWAIT
006482111220     C                   Eval      WSWAIT = PAWAIT
006483111215     C                   leaveSR
006484111215     C                   End
006485111215     C                   End
006486111215     C     PDKEYAMT      Reade     PAYDEDANL1
006487111215     C                   Enddo
006488111215
006489111215     C     PDKEYAMT      Klist
006490111215     C                   Kfld                    STTRS
006491111215     C                   Kfld                    STSUB
006492111215     C                   Kfld                    STPLN
006493111215
006494111214    ?C                   Endsr                                                  END DLT RQST
006495111215    ? *___________________________________________________________________
006496111215    ? * Edit delete request
006497111215    ? *___________________________________________________________________
006498111215    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
006499111215    ? *
006500111215    ?C                   Endsr                                                  END DLT RQST
006501000000    ? *___________________________________________________________________
006502000000    ? * Default data
006600000000    ? *___________________________________________________________________
006700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
006800000000    ?C                   Endsr                                                  END DFT DATA
006900000000    ? *___________________________________________________________________
007000000000    ? * Send messages
007100000000    ? *___________________________________________________________________
007200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
007300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
007400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
007500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
007600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
007700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
007800000000    ?C                   Endsr                                                  END SND ERRMSG
007900000000    ? *___________________________________________________________________
008000000000    ? * Process error
008100000000    ? *___________________________________________________________________
008200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
008300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
008500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
008600000000    ?C                   Endsr                                                  END PRCERR
008700000000    ? *___________________________________________________________________
008800000000    ? * Parameter list
008900000000    ? *___________________________________________________________________
009000000000    ?C     PLIST         Begsr                                                  PARM LISTS
009100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
009200000000    ?C                   Parm                    WIRQS             8            REQUEST
009300000000    ?C                   Parm                    WORTN             8            RETURN CODE
009400000614    ?C                   Parm                    WUDTA                          DATA
009401111220    ?C                   Parm                    WWPCMT            1            RETURN CODE
009402111220    ?C                   Parm                    WWAIT             3            RETURN CODE
009500000000    ?C                   Endsr                                                  END PLIST
009600000000    ? *___________________________________________________________________
009700000000    ? * Define Variables and Key Lists
009800000000    ? *___________________________________________________________________
009900000000    ?C     DEFN          Begsr                                                  PARM LISTS
010000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
010100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
010200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010300000000    ?C                   Endsr                                                  END DEFN
010400010914    ? *___________________________________________________________________
010500010914    ? * Key lists
010600010914    ? *___________________________________________________________________
010700010914    ?C     KLIST         Begsr                                                  KEY LISTS
011200010914    ?C                   Endsr
011300000000    ? *___________________________________________________________________
011400000000    ? * Program error handler
011500000000    ? *___________________________________________________________________
011600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
011900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012300031215      *-------------------------------------------------------------------*
012400031215      * Format Date
012500031215      *-------------------------------------------------------------------*
012600031215     C     FMTDATE       Begsr
012700110523     C                   Eval      Input_Format  = 'MMDDYYYY'
012800031215     C                   Eval      Output_Format = 'MMDDYYYY'
012900031215     C                   Call      'FMTDATE'
013000031215     C                   Parm                    Input_Date       32
013100031215     C                   Parm                    Input_Format     32
013200031215     C                   Parm                    Output_Format    32
013300031215     C                   Parm                    Output_Date      32
013400031215     C                   Parm                    Output_Error     10
013500031215     C                   Endsr
013600000000    ? *___________________________________________________________________
013700000112** WTMP
01380000000000T-Record is not eligible for deletion.
01390011062100Request not supported by program CHKOND.
014000000117** WTM
01400211062162Member is invalid.
01400311061363Plan is invalid.
01400411121566Pay Period Start Date is invalid.
01410011121564Today Date Override is invalid.
01420011121462Member is missing screen 2.
01430011121565Pay Frequency is invalid.
