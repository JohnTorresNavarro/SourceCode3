0001000303170002  *?****************************************************************
0002000606270003  *
0003000606270008  *? N O T E !!! - EMAILS WILL BE MAILED WHEN THIS IS RUN!!!!!!    *
0004000606270003  *
0005000303180003  *?RP174R     GROUP BENEFIT SERVICES SOFTWARE
0006000303170004
0007000303170005  *?           WRITTEN BY - TPOWERS                                *
0008000303180006  *?           DATE - 03/18/03                                     *
0009000303170007
0010001502180008  *? DESCRIPTION - THIS PROGRAM WILL REPORT & EMAIL TO BROKERS THEIR
0011001502180009  *?      ACCOUNTS PENDING CANCELLATION DUE INSUFFICIENT PAYMENT   *
0012000303170010
001300030715      *  6/23/03 KSJ - Blank out Note2 before writing HIST record      *
001400030715      *  7/15/03 KSJ - Corrected problem re: some accounts not being   *
001500030721      *                printed on Broker Report                        *
001600051024      * 10/24/05 DLK - Fix aa name                                     *
001700060621      *  6/16/06 szz - Add Email-to-broker and print only if there's   *
001800060712      *                 NO ALTERNATE email address.                    *
001900060629      *                Per Cindy Whitehead:  Exclude accounts 559, 560,*
002000060629      *                 561 and 562.
002100060621      *                                                                *
002200060814      *  8/14/06 szz - Add DBE rule to accounts that have any DBE      *
002300060814      *                 plans. (DBE)                                   *
0024000704180015  * 04/18/07 dlk - update payment calc so all use same formula     *
0025000706120015  *              - if sum of payments > 0 then add to total due    *
0026000706120015  *                and clear payment amount before calc pct paid   *
0027000910130015  * 10/13/09 dlk - exclude senior dental trusts                    *
002800131011      * 10/11/13 sbt - hist file expansion project                     *
002900131112      * 11/12/13 dlk - remove credits from payment formula
003000150202      * 01/30/15 dlk - change payment % required to 90 for dbe
003100150424      * 02/16/15 dlk - remove hard coded dbe payment required percent
003200150424      * 04.24.15 jva - fix email selection logic
003300160418      * 09/23/15 dlk - convert to use GETPAIDCL
003400160622      * 04/18/16 dlk - add blank remit date parm to getpaidcl
003500160926      * 06/22/16 jva - change history note to generated
003600160926ja01  * 09/26/16 jva - omit AmWins trust 5(tscode = 'W')
003700160926ja01  * 09/26/16 jva - omit run date <= begin admin date (gbsbdt)
003800180109ja01  * 01/09/18 jt  -  Added changes for Advanced Mobile
003900200110ja01  * 01/10/20 jt  -  Added changes for CMS
0040000705250012  *                                                                *
0041000705250015  *        ** Any changes to the remittance % required MUST MATCH  *
0042000705250015  *           the ABR programs (DW160, DW260) and RP170 **         *
0043000705250012  *                                                                *
004400060814      *                                                                *
0045000303170012  *?****************************************************************
0046000403240013 FACCMST7   IF   E           K DISK    USROPN
0047000303170016 FTRSMST    IF   E           K DISK
0048000304040016 FULEXCL    IF   E           K DISK
0049000303180016 FAACODE    IF   E           K DISK
005000060814DBE  FPLNMST    IF   E           K DISK
005100060814DBE  FCARMST    IF   E           K DISK
005200060814DBE  FMEMAC#    IF   E           K DISK
005300060814DBE  FMCOV      IF   E           K DISK
0054000303190016 FSMAN      IF   E           K DISK
0055000606160016 FSMAN2L    IF   E           K DISK
0056001509230017 FHISTAA    IF A E           K DISK
005700060711     FBRKACON   IF   E           K Disk
005800060616     FRP174P    O    E           K Disk
0059000303180018 FRP174T    O    E             PRINTER OFLIND(*IN66)
0060000304240018 FBRKRLBL   O    F  132        PRINTER
006100030424     F                                     FORMLEN(6)
006200030424     F                                     FORMOFL(6)
0063001509240018 FQPRINT    O    F  132        PRINTER OFLIND(*INOE)
006400030317
0065000304070021 D MON_A           S              9    DIM(12) CTDATA PERRCD(1)
0066000304030021 D NEWYMD          S              8  0 INZ(*ZEROS)
0067000710300021 D EMLYMD          S              8  0 INZ(*ZEROS)
0068000304250021 D ZIP5S           S              5    INZ(*ZEROS)
0069000304250021 D ZIP4S           S              4
0070000303190021 D SMANCD_H        S                   LIKE(SMANCD)
0071000303200021 D LEAVEDO         S               N   INZ('0')
0072000304240021 D FIRSTLS         S               N   INZ('0')
0073000303190021 D HIST_KEY        S             10
0074000303280021 D KEB             S              3
0075000303280020 D DL              S             15
0076000304250020 D N2S             S             31
0077000304250020 D AL2S            S             30
0078000608140056 DPaypct           S             13  4
0079000705090056 Dpaypctreq        s                   like(cthresh)
0080000705090056 Dwkpct            s                   like(cthresh)
0081000705090056 Dholdpct          s                   like(cthresh)
0082001509230056 Dholdcarrier      s                   like(pcarr)
008300030425     D ISO_CURR        S               D   DATFMT(*ISO)
008400030425     D ISO_DATE        S               D   DATFMT(*ISO)
008500030317     D USA_DATE        S               D   DATFMT(*USA)
008600150923
0087001509230050 D                 DS
0088001509230051 D  keyacc                 1     10  0
0089001509230054 D  actrst                 1      3  0
0090001509230052 D  acsub#                 4      6  0
0091001509230053 D  acacct                 7     10  0
009200030425
009300030425     D                 DS
009400030425     D TIMEDATE_DS                   12  0 INZ(*ZEROS)
009500030425     D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
009600030425     D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
009700030319
0098000303190055 D                 DS
0099000303190055 D COVTDT
0100000303190056 D  COVTDT_YM                     6  0 OVERLAY(COVTDT)
010100030319
0102000303190055 D                 DS
0103000303190055 D INVCDT
0104000303190056 D  INVCDT_YM                     6  0 OVERLAY(INVCDT)
010500030319
0106000303190055 D                 DS
0107000303190055 D ACNAM1
0108000303190056 D  ACNM30                       30    OVERLAY(ACNAM1)
010900030319
0110000303190055 D                 DS
0111000303190055 D AANAM
0112000303190056 D  AANAM30                      30    OVERLAY(AANAM)
011300030317
0114000303190055 D                 DS
0115000303190055 D TSCODE
0116000303170056 D  TSCODE_DS                     1    OVERLAY(TSCODE:3)
011700030317
0118000307100055 D                 DS
0119000307100055 D TRDATE
0120000307100056 D  TRYEAR                        4  0 OVERLAY(TRDATE)
0121000307100056 D  TRMNTH                        2  0 OVERLAY(TRDATE:5)
012200030710
0123000303170055 D                UDS
0124000304070094 D  SMANCD                 1      3
0125001310140094 D  USERID                10     19
012600020128     D  LMDY                  38     45  0
012700020128     D  LM                    38     39  0
012800020128     D  LYCHAR                42     45
0129009102120057 D  CONAME               201    240
013000060616     D  EMAILFL              256    256
0131000303180060
013200030318     IACCMSR
013300030318     I              AACODE                      AACODE_I
013400060616
013500040324     C                   OPEN      ACCMST7
0136000304070089 C                   IF        SMANCD = 'ALL'
013700040324     C                   DOU       %EOF(ACCMST7)
013800040323     C                   READ      ACCMSR
013900040324     C                   IF        NOT %EOF(ACCMST7)
014000060629     C                   If        ACTRST  <> 559   And
014100060629     C                             ACTRST  <> 560   And
014200060629     C                             ACTRST  <> 561   And
014300060629     C                             ACTRST  <> 562
014400030407     C                   EXSR      PROCESS_SR
014500060629     C                   End
0146000304070459 C                   END
0147000304070462 C                   ENDDO
014800030407
014900030407     C                   ELSE
015000030407
015100040324     C     SMANCD        SETLL     ACCMSR
015200030407     C                   DOU       %EOF(ACCMST7)
015300040324     C     SMANCD        READE     ACCMSR
015400030407     C                   IF        NOT %EOF(ACCMST7)
015500060629     C                   If        ACTRST  <> 559   And
015600060629     C                             ACTRST  <> 560   And
015700060629     C                             ACTRST  <> 561   And
015800060629     C                             ACTRST  <> 562
015900030407     C                   EXSR      PROCESS_SR
016000060629     C                   End
0161000304070459 C                   END
0162000304070462 C                   ENDDO
0163000304070459 C                   END
016400060808TEST C     endpgm        Tag
016500030407     C                   EVAL      *INLR = *ON
016600040323     C                   CLOSE     ACCMST7
016700030407     C                   RETURN
016800030407
0169000304070105  *?*************************************************
0170000304030111
017100030407     C     PROCESS_SR    BEGSR
017200150923
017300150923      * skip this acct if it is in the exclusion file
0174001509230130 C     ULEXCL_KEY    chain     ulexcl
017500150923     C                   if        %found(ulexcl)
017600150923     c                   leavesr
017700150923     c                   end
017800150923
017900030317     C     *NOKEY        CLEAR     *ALL          TRSMSR
0180000303170088 C     ACTRST        CHAIN     TRSMSR
018100030317
018200150923      * skip cancelled, deleted and senior dental trusts. Also skip accts
018300160926      * not enrolled long enough. Skip AnWins trs 5.
018400200110       if tscode_DS = ' '
018500200110        or trdltd ='C'
018600200110         or trdltd = 'D'
018700200110          or tscode = 'O N'
018800200110           or newymd < enroll
018900200110            or tscode_ds = 'W'
019000200110           or newymd <= gbsbdt
019100200110          or tscode = 'O M'
019200200110         or tscode = 'O D';
019300200110         leavesr;
019400200110       endif;
019500200110
0196002001100089 C****               IF        TSCODE_DS = ' ' OR TRDLTD = 'C' OR
019700200110     C****                         TRDLTD = 'D' or tscode = 'O N' or
019800200110     C****                         NEWYMD < ENROLL or
019900200110ja01 C****                         tscode_ds = 'W' or NEWYMD <= GBSBDT
020000200110     C****                         or tscode = 'O M'
020100200110     C****                         or tscode = 'O D'
020200200110     c****               leavesr
020300200110     c****               end
0204000304040111
020500150923      * skip if there is an urgent letter exclude hist rec this month from
020600150923      * a previous run
020700150923DBE  C                   Movel     keyacc        k_hkey           10
020800150923DBE  C                   Movel     'U28'         k_trcode          3
020900150923
021000150923     c     keyhistaa     setll     histaa
021100150923     c                   dou       %eof(histaa)
021200150923     c     keyhistaa     reade     histaa
021300150923     c                   if        not %eof(histaa) and
021400150923     C                             TRYEAR = *YEAR AND TRMNTH = *MONTH
021500150923     c                   leavesr
021600150923     c                   end
021700150923     c                   enddo
021800150923
0219001509230142  * find out if acct has dbe business and carrier code for highest
0220001509230142  * threshold % that will be used in getpaid
022100150923     c                   exsr      #fnddbe
022200070418
0223001509230142  * if no active plans were found to use the carrier for the payment
0224001509230142  * percent required, use special override code of <a> for 100%
022500150923     c                   if        holdcarrier = *blanks
022600150923     c                   eval      holdcarrier = '<a>'
022700150923     C                   end
022800150923
022900150923      * 5/20/15 - convert to use GETPAID instead of internal payment logic.
023000150923      *           It will only be used for gathering the payments, credits
023100150923      *           debits and invoice ending balance...the yes/no decision
023200150923      *           will not be used here since admin wants to use
023300150923      *           different fields in their decision
023400150923     c                   exsr      #getpaid
023500150923
023600150923      * any error from payment pgm - skip remainning calcs
023700150923     c                   if        parmerr <> *blanks
023800150923     c                   leavesr
023900150923     c                   end
024000150923
024100150923      * if acct has not paid enough then print letter
024200150923     C                   if        paymnt = 'N'
024300150923      * baldue used in rp174p work file
024400150923     C     TOTINV        ADD       MONPAY        baldue            9 2
024500030319     C                   EXSR      ACCBRK_SR
024600030319     C                   END
024700150923
0248000304070124 C                   ENDSR
024900030317
0250000303190105  *?*************************************************
025100030319     C     ACCBRK_SR     BEGSR
025200030320
025300030320     C                   IF        SMANCD_H <> SMANCD
025400030320     C                   EVAL      SMANCD_H  = SMANCD
025500030320     C     *NOKEY        CLEAR     *ALL          SMANR
025600030320     C     SMANCD        CHAIN     SMANR
025700030320     C                   EVAL      SMAN40 = *BLANKS
025800030320     C                   MOVEL     SFNAME        SMAN40
025900030320     C                   CAT       SLNAME:1      SMAN40
026000060810     C                   EXSR      EMAIL_SR
026100060810     C                   If        %trim(EMAIL) = *Blanks
026200030320     C                   WRITE     HEAD
026300030424     C                   EXSR      #LABELS
026400060810     C                   End
026500030320     C                   END
026600030319     C     *NOKEY        CLEAR     *ALL          AACODR
026700030319     C     AACODE_KEY    CHAIN     AACODR
026800030319     C                   EVAL      AAPHN   = ADDIAL
026900030319     C                   EVAL      APHONE2 = APHONE
027000030320     C                   MOVEL     AAREA         APHONE2
027100051024     c                   clear                   aanam
027200030319     C                   MOVEL     AFNAM         AANAM
027300030319     C                   CAT       ALNAM:1       AANAM
027400030319     C                   EVAL      ACTSUB  = NOEMPL
027500060815DBE  C                   Movel     ACTRST        ACCOUNT#          6 0
027600060815DBE  C                   Move      ACSUB#        ACCOUNT#
027700060815DBE  C                   Movel     ACCOUNT#      ACCOUNTNBR       10 0
027800060815DBE  C                   Move      ACACCT        ACCOUNTNBR
027900060815DBE  C                   Z-Add     ACCOUNTNBR    ACCNBR
028000150923      * bilamt used in rp174p
028100150923     C                   EVAL      BILAMT  = totinv + monpay
028200150923      * rp174p still uses inendb so it must be filled here
028300150923     C                   z-add     totinv        inendb
028400060622      *---
028500060622      * Only authorized users can generate emails
028600060622      *---
028700060703     C                   Select
028800060810     C                   When      %trim(EMAIL) <> *blanks
0289000607030161 C                   Write     RP174PR
029000060810     C                   Eval      *IN66 = *OFF
029100060703     C                   Other
0292000607030161 C                   WRITE     LINE
029300060703     C                   Endsl
029400060616      *
029500030319     C                   IF        *IN66 = *ON
029600030319     C                   EVAL      *IN66 = *OFF
0297000303190161 C                   WRITE     HEAD
029800030319     C                   END
029900130523     C                   EXSR      HIST_SR
0300000303190462 C                   ENDSR
030100070509
030200070509      **********************************************************
030300150923      * Find carrier with highest payment % required
030400070509      **********************************************************
030500150923      * 09/23/15 - hold carrier code also for the highest threshold %
030600060814DBE  C     #FNDDBE       BEGSR
030700060814      *
030800070509     c                   clear                   wkpct
030900070509     c                   clear                   holdpct
031000150923     c                   clear                   holdcarrier
031100060814      *
031200150923DBE  C     key_memac#    Setll     MEMAC#
031300060814DBE  C                   Dou       %Eof(MEMAC#)
031400150923DBE  C     key_memac#    Reade     MEMAC#
031500060814DBE  C                   If        Not %Eof(MEMAC#) And (TERMDT = *Zeros Or
031600060814DBE  C                             TERMDT > NEWYMD) And (MBENRL <= NEWYMD)
031700060814      *
031800060814      * Read Coverages
031900060814DBE  C     MBSSNO        Setll     MCOV
032000060814DBE  C                   Dou       %Eof(MCOV)
032100060814DBE  C     MBSSNO        Reade     Mcov
032200060814DBE  c                   If        Not %Eof(MCOV) And (CANDT = *Zeros Or
032300060814DBE  c                             CANDT > NEWYMD) And (ENRLDT <= NEWYMD)
032400060814
032500060814DBE  C     PLNKEY        Chain     PLNMST
032600060814DBE  C                   If        %Found(PLNMST)
032700060814DBE  C     PCARR         Chain     CARMST
032800070509DBE  C                   If        %Found(CARMST)
032900070509      * find the % req
033000070509     c                   exsr      #chkpct
033100060814DBE  C                   End
033200060814DBE  C                   End
033300060814      *
033400060814DBE  C                   End
033500060814DBE  C                   Enddo
033600060814      *
033700060814DBE  C                   End
033800060814DBE  C                   Enddo
033900070509
0340000608140462 C                   ENDSR
034100070509
034200070509      **********************************************************
034300070509      * check payment %
034400070509      **********************************************************
0345000705090078 C     #chkpct       begsr
034600070509
034700070509     c                   z-add     cthresh       wkpct
034800150216
034900150923      * hold higest percent and carrier code
035000070509     c                   if        wkpct > holdpct
035100070509     c                   z-add     wkpct         holdpct
035200150923     c                   move      pcarr         holdcarrier
035300070509     c                   end
035400070509
0355000705090078 C                   endsr
0356000608100351  *?**************************************************************
035700060810     C     EMAIL_SR      BEGSR
035800071030     C                   MOVE      ISO_CURR      EMLYMD
035900060810     C                   Eval      *IN66 = *OFF
036000060810     C                   Eval      EMAIL   = *Blanks
036100060810     C                   If        USERID  = 'CINDY'       Or
036200060810     C                             USERID  = 'JASON'       Or
036300060810     C                             USERID  = 'LINDA'       Or
036400100422     C                             USERID  = 'JALLEN'      Or
036500100422     C                             USERID  = 'DAVEA'       Or
036600060810     C                             USERID  = 'GBSTEST'
036700060810     C     SGRP          Chain     SMAN2L
036800060810     C                   If        %Found(SMAN2L)
036900060810     C                   If        SAEMAIL       <> *Zeros
037000150424
037100150424     C     KAltEml       setll     BRKACON
037200150424     C     KAltEml       reade     BRKACON
037300150424     C                   dow       not %eof(BRKACON)
037400150424
037500071030     C                   If        %trim(BRAEML) <> *Blanks and
037600071030     C                             BRATMD  = 0              or
037700071030     C                             %trim(BRAEML) <> *Blanks and
037800071030     C                             BRATMD  >= EMLYMD
037900060810     C                   Eval      EMAIL   = %Trim(BRAEML)
038000150424     C                   Leave
038100150424     C                   End
038200150424     C     KAltEml       reade     BRKACON
038300150424     C                   Enddo
038400150424
038500060810     C                   Else
038600060810     C                   Eval      EMAIL   = %Trim(SBREML)
038700060810     C                   End
038800150424
038900150424     C                   If        %trim(email) =  *blanks
039000150424     C                   Eval      EMAIL   = %Trim(SBREML)
039100150424     C                   End
039200150424
039300150424     C                   End
039400060810     C                   End
039500150424
0396000608100462 C                   ENDSR
0397000303200351  *?**************************************************************
039800030320     C     HIST_SR       BEGSR
0399001310140284 C                   clear                   histr
040000060815DBE  C                   Movel     ACTRST        ACCOUNT#          6 0
040100060815DBE  C                   Move      ACSUB#        ACCOUNT#
040200060815DBE  C                   Movel     ACCOUNT#      ACCOUNTNBR       10 0
040300060815DBE  C                   Move      ACACCT        ACCOUNTNBR
040400060815DBE  C                   Movel     ACCOUNTNBR    HKEY
040500060815     C*************      MOVE      KEYACC        HKEY
0406000303200284 C                   EVAL      TRCODE =  'UHM'
0407001606220284 C                   EVAL      CK#NOT = 'BROKER DELINQUENCY GENERATED'
0408000608100284 C                   EVAL      NOTE2 = %trim(EMAIL)
040900030328     C                   EVAL      HPRGNM  = 'R174'
041000030320     C                   EVAL      HSTRST  = ACTRST
041100030320     C                   EVAL      HSSUB#  = ACSUB#
041200030320     C                   EVAL      HSACCT  = ACACCT
041300030425     C                   EVAL      HOPER   = USERID
041400030320     C                   EVAL      COVTDT  = NEWYMD
041500030320     C                   EVAL      RECVDT  = *ZEROS
041600030320     C                   EVAL      TRAMT   = *ZEROS
041700030320     C                   EVAL      HSDLTD  = 'A'
041800030425     C                   MOVE      ISO_CURR      TRDATE
041900131011     c                   eval      hstrtime = %time
042000030320     C                   WRITE     HISTR
042100030320     C                   ENDSR
0422000304240649  ****************************************************************
0423000304240650 C     #LABELS       BEGSR
0424000304240036
0425000304240037  * SET LEADER LABEL - FIRST TIME ONLY
0426000304240038
0427000304240039 C                   IF        FIRSTLS = *OFF
0428000304240040 C                   EVAL      FIRSTLS = *ON
0429000304240041 C                   EXCEPT    HEADERS
0430000304240042 C                   END
043100030424
0432000304250424 C                   MOVE      *BLANKS       N2S
0433000304240424 C                   MOVEl     Sfname        N2S
043400030424
0435000304250436 C                   IF        SMI <> ' '
043600030424     C                   CAT       SMI:1         N2S
043700030424     C                   CAT       '.':0         N2S
0438000304240441 C                   END
0439000304240442
044000030424     C                   CAT       SLNAME:1      N2S
044100030424
044200030425     C                   MOVE      *blanks       AL2S
044300030424     C                   MOVEL     scity         AL2S
044400030424     C                   CAT       ',':0         AL2S
044500030424     C                   CAT       SSTATE:1      AL2S
044600030425     C                   MOVEL     szipcd        ZIP5S
044700030425     C                   MOVE      szipcd        ZIP4S
044800030424     C                   CAT       ZIP5S:1       AL2S
044900030425     C                   IF        ZIP4S <> '0000'
045000030424     C                   CAT       '-':0         AL2S
045100030424     C                   CAT       ZIP4S:0       AL2S
045200030424     C                   END
045300030424
0454000304240052 C                   EXCEPT    LABS
0455000304240045
045600030424     C                   ENDSR
045700150923
0458001509230103 C*******************************************************************
0459001509230104 C* call getpaid to get payment status for this acct/effdt/carrier *
0460001509230103 C*******************************************************************
046100150923     c     #getpaid      begsr
046200150923
046300150923      * monpay is already defined as 11.2 in rp174p
0464001509230128 C****************   clear  ***************  MONPAY ********* 10 2
0465001509230128 C                   clear                   MONPAY
046600150923      * credit is already defined as 11.2 in rp174p
0467001509230128 C****************   clear  ***************  CREDIT ********* 10 2
0468001509230128 C                   clear                   CREDIT
0469001509230128 C                   clear                   debit            10 2
0470001509230128 C                   clear                   totinv            9 2
0471001509230128 C                   clear                   paymnt            1
047200150923
047300150923     c     grplist       plist
047400150923     c                   parm                    parmkey          10
047500160418     c                   parm                    parmremymd        8
047600150923     c                   parm                    parmeffymd        8
047700150923     c                   parm                    parmcar           3
047800150923     c                   parm                    parmupdate        1
047900150923     c                   parm                    parmpaid          1
048000150923     c                   parm                    parmerr          35
048100150923     c                   parm                    parminveb        10 2
048200150923     c                   parm                    parmpayments     10 2
048300150923     c                   parm                    parmcredits      10 2
048400150923     c                   parm                    parmdebits       10 2
048500150923
048600150923     c                   movel     keyacc        parmkey
048700160418     c                   move      *blanks       parmremymd
048800150923     c                   move      newymd        parmeffymd
048900150923     c                   move      holdcarrier   parmcar
049000150923     c                   move      'N'           parmupdate
049100150923     c                   clear                   parmpaid
049200150923     c                   clear                   parmerr
049300150923     c                   clear                   parminveb
049400150923     c                   clear                   parmpayments
049500150923     c                   clear                   parmcredits
049600150923     c                   clear                   parmdebits
049700150923
049800150923     c                   call      'GETPAIDCL'   grplist
049900150923
050000150923      * if any error returned, print it
0501001509230361 C                   if        parmerr <> *blanks
050200150923     C                   if        firste = ' '
050300150923     C                   EXCEPT    HEADE
050400150923     C                   MOVE      'N'           FIRSTE            1
050500150923     C                   END
050600150923     C   oe              EXCEPT    heade
050700150923      * set on 63 to show the error
050800150923     c                   eval      *in63 = *on
050900150923     C                   EXCEPT    linee
051000150923     c                   eval      *in63 = *off
051100150923     c                   leavesr
051200150923     C                   END
051300150923
051400150923      * this is the actual Y/N payment decision returned from get paid
051500150923     c                   move      parmpaid      paymnt
051600150923
051700150923      * move values from get paid to those needed by this program
051800150923     c                   z-add     parminveb     totinv
0519001509230137 c                   z-add     parmcredits   credit
0520001509230137 c                   z-add     parmdebits    debit
0521001509230137 c                   z-add     parmpayments  monpay
052200150923
052300150923     c                   endsr
052400150923
052500150923
0526000303170060
0527009908090106 C     *INZSR        BEGSR
052800030317
052900030319     C     INKEY         KLIST
053000030319     C                   KFLD                    ACTRST
053100030319     C                   KFLD                    ACSUB#
053200030319     C                   KFLD                    ACACCT
053300030319     C                   KFLD                    NEWYMD
053400030319     C                   KFLD                    KEB
053500030320
053600030404     C     ULEXCL_KEY    KLIST
053700030320     C                   KFLD                    ACTRST
053800030320     C                   KFLD                    ACSUB#
053900030320     C                   KFLD                    ACACCT
054000030319     C     AACODE_KEY    KLIST
054100030319     C                   KFLD                    AACODE_I
054200030319     C                   KFLD                    AAREC#
054300060814      *
054400060814DBE  C     PLNKEY        KLIST
054500060814DBE  C                   KFLD                    MCTRST
054600060814DBE  C                   KFLD                    MCSUB#
054700060814DBE  C                   KFLD                    MCPLAN
054800060814      *
054900060711     C     KAltEml       KLIST
055000060711     C                   KFLD                    SGRPCD
055100060711     C                   KFLD                    SAEMAIL
055200060815      *
0553001509230056 C     key_memac#    Klist
0554000608150056 C                   Kfld                    ACTRST
0555000608150056 C                   Kfld                    ACSUB#
0556000608150056 C                   Kfld                    ACACCT
055700150923
0558001509230056 C     KEYhistaa     Klist
0559001509230056 C                   Kfld                    k_hkey
0560001509230056 C                   Kfld                    k_trcode
056100060815      *
056200030425     C                   TIME                    TIMEDATE_DS
056300030425     C     *MDY          MOVE      DATE_DS       ISO_CURR
0564000303190062 C                   EVAL      AAREC# = *ZEROS
0565000303190109
0566000303190113 C     *USA          MOVE      LMDY          ISO_DATE
056700030328     C                   MOVE      ISO_DATE      NEWYMD
056800030317
0569000303280062 C                   MOVE      'KEB'         KEB
057000020128
0571000304070066 C                   MOVEL     MON_A(LM)     DL
057200020128     C                   CAT       LYCHAR:1      DL
057300030317
0574009908090078 C                   ENDSR
057500030424     OBRKRLBL   E            HEADERS        1 01
0576000304240105 O                                           26 '*'
0577000304240106 O                                           25 '************************'
0578000304240107 O                                           29 '****'
0579000304240108 O          E            HEADERS        1
0580000304240109 O                                            3 '**'
0581000304250110 O                                           27 'URGENT    BROKER LABELS '
0582000304240111 O                                           29 '**'
0583000304240112 O          E            HEADERS        1
0584000304240113 O                                            2 '*'
0585001310140114 O                       USERID              17
0586000304240115 O                                           26 'RPF070'
0587000304240116 O                                           29 '*'
0588000304240117 O          E            HEADERS        1
0589000304240118 O                                           25 '************************'
0590000304240119 O                                           29 '****'
0591000304240120 O          E            LABS           1 01
0592000304240123 O                       N2S                 31
0593000304240124 O          E            LABS           1
0594000304240125 O                       SADDR               30
0595000304240126 O          E            LABS           1
0596000304240127 O                       AL2S                30
0597001509230166 Oqprint    E            HEADE          2 03
0598001509230167 O                                           45 '*****'
0599001509230168 O                       CONAME              85
0600001509230169 O                                           91 '*****'
0601001509230170 O          E            HEADE          1
0602001509230171 O                                           70 'BROKER NOTIFICATION ERRO'
0603001509230172 O                                           78 'R REPORT'
0604001509230179 O          E            HEADE          1
0605001509230180 O                                           25 'PROGRAM NAME: RP174R'
0606001509230175 O                       lmdy                70 '  /  /    '
0607001509230181 O                                          120 'PAGE:'
0608001509230182 O                       PAGE          Z    128
0609001509230183 O          E            HEADE          1
0610001509230184 O                                           14 'RUN DATE:'
0611001509230185 O                       *month              17
0612001509230185 O                                           18 '/'
0613001509230185 O                       *day                20
0614001509230185 O                                           21 '/'
0615001509230185 O                       *year               25
0616001509230186 O                                          120 'TIME:'
0617001509230187 O                       TIME_ds            128 '  :  :  '
0618001509230188 O          E            HEADE          1
0619001509230189 O                                           24 '""""""""""""""""""""""""'
0620001509230190 O                                           48 '""""""""""""""""""""""""'
0621001509230191 O                                           72 '""""""""""""""""""""""""'
0622001509230192 O                                           96 '""""""""""""""""""""""""'
0623001509230193 O                                          120 '""""""""""""""""""""""""'
0624001509230194 O                                          132 '""""""""""""'
0625001509230195 O          E            HEADE          1
0626001509230199 O                                           11 'ACCOUNT #'
0627001509230200 O                                           20 'ERROR'
0628001509230188 O          E            HEADE          2
0629001509230189 O                                           24 '""""""""""""""""""""""""'
0630001509230190 O                                           48 '""""""""""""""""""""""""'
0631001509230191 O                                           72 '""""""""""""""""""""""""'
0632001509230192 O                                           96 '""""""""""""""""""""""""'
0633001509230193 O                                          120 '""""""""""""""""""""""""'
0634001509230194 O                                          132 '""""""""""""'
063500150923      * getrate error
0636001509230213 O          E            LINEE          1
0637001509230214 O                       KEYACC              12 '   -   -    '
063800150923     O                       parmerr             50
063900150923     O                                           +2 'EFF-'
064000150923     O                       newymd              +1 '    /  /  '
064100150923     O                                           +2 'CAR-'
064200150923     O                       parmcar             +1
064300150923
0644000303190672  *?***************************************************************
064500030319**
064600030319JANUARY
064700030319FEBRUARY
064800030319MARCH
064900030319APRIL
065000030319MAY
065100030319JUNE
065200030319JULY
065300030319AUGUST
065400030319SEPTEMBER
065500030319OCTOBER
065600030319NOVEMBER
065700030319DECEMBER
