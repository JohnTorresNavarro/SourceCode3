000100050920     H DFTNAME(RP130) FIXNBR(*ZONED)
000200000000      ****************************************************************
000300000000      *                                                              *
000400000414      * RP130      GROUP BENEFIT SERVICES SOFTWARE           1988    *
000500000000      *                                                              *
000600000000      *            WRITTEN BY - MICHAEL C. DUNPHY                    *
000700000000      *            DATE - 01/20/89                                   *
000800000000      *                                                              *
000900000000      *  DESCRIPTION - THIS PROGRAM WILL PRINT A SELECTED HISTORY    *
001000000000      *                LIST BY TRANSACTION CODE                      *
001100000000      *                                                              *
001200050920      * 09/20/05 dlk- add mask ssn option and convert to RPGLE       *
001300070109      * 01/09/07 dlk- fix trcode desc bug                            *
001400110124      * 01/24/11 dlk- add exclude senior dental code                 *
001500140103      * 10/10/13 sbt - hist file expansion project                   *
001600140103      * 01/01/14 rlj - Added ACA - Y/N to report                     *
001700140108      * 01/08/14 rlj - Added workfile RP13WKP output                 *
001800180111      * 01/09/18 jt  - Added changes for Advanced Mobile
001900200110      * 01/09/18 jt  - Added changes for CMS
002000201112      * 11/10/20 dlk - add ebs only selection - Cindy W request
002100201112      * 11/12/20 dlk - add carrier for member trans to xls - Cindy W request
002200220127      * 12/30/21 dlk - add transaction time to xls
002300220128      * 01/27/22 dlk - add plan description to xls - Cindy W request. Also
002400220128      *                always show member last name on xls (member and acct
002500220128      *                transactions that support it).
002600220426      * 04/26/22 dlk - change ebs only selection to any agency selection
002700990119      *                                                              *
002800000000      ****************************************************************
002900131010     FHIST      IP   F  216        DISK
003000050920     FCODES     IF   F   64     3AIDISK    KEYLOC(1)
003100050920     FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
003200050920     FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
003300110124     Ftrsmst    IF   E           k DISK
003400140103     Fplnauxp   IF   E           k DISK
003500201112     Fplnmst    IF   E           k DISK
003600201112     Fcarmst    IF   E           k DISK
003700140109     FRP13WKP   O    E             DISK
003800220105     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
0039000509200037 D ssnoout         S             12
0040000509200037 D ck#notout       S                   like(ck#not)
0041000509210037 D note2out        S                   like(note2)
0042000509210037 D lssnoout        S              9
0043001401030037 D acaflg          S              1
0044002011120037 D cnameout        S                   like(cname)
0045002201040037 D acnam1_out      S                   like(acnam1)
0046002201040037 D ldescr_out      S                   like(ldescr)
0047002201270037 D pdescr_out      S                   like(pdescr)
0048002201270037 D plan_out        S                   like(plplan)
0049002201280037 D lname_out       S                   like(lname)
005000140109      *
005100140115     D                 DS
005200140115     D  rp13clr1               1     52
005300140116     D  rwpacc                 1     12
005400140115     D   rtrust#               1      3
005500140115     D   rwd1                  4      4    INZ('-')
005600140115     D   rsub#                 5      7
005700140115     D   rwd2                  8      8    INZ('-')
005800140115     D   raccno                9     12
005900140116     D  rwacnm                13     52
006000140115      *
006100140109     D                 DS
006200220127     D  rp13clr2               1    273
006300140110     D   rwssno                1     12
006400140110     D   rwtrdt               13     22
006500140110     D   rwtran               23     52
006600140110     D   rwtram               53     64
006700140110     D   rwabal               65     76
006800140110     D   rwefdt               77     86
006900140110     D   rwrecd               87     96
007000140110     D   rwck#m               97    126
007100140110     D   rwck#2              127    156
007200140110     D   rwacaf              157    157
007300140110     D   rwuser              158    167
007400180405     D   rwlnam              168    185
007500211230     D   rwtrtime            186    193
007600220127     D   rwpdescr            194    233
007700220127     D   rwcarr              234    273
007800140115      *
007900140109     D                 DS
008000140109     D  SSNDS                  1      9
008100140109     D  SSN1                   1      3
008200140109     D  SSN2                   4      5
008300140109     D  SSN3                   6      9
008400050920     D* LDA
008500000000     D                UDS
008600050920     D  LFDATE                 1      8  0
008700000000     D  LTRUST                13     15
008800000000     D  LSUB                  16     18
008900000000     D  LACCT                 19     22
009000050920     D  LSSNO                 24     32
009100000000     D  SORT                  33     33
009200000000     D  TRCOD                 34     34
009300000000     D  TRNSAC                35     35
009400000000     D  COD                   44     73
009500000000     D                                     DIM(10)
009600000000     D  SORL                  74     74
009700050920     D  LTDATE                75     82  0
009800050920     D  LMASK                 83     83
009900110124     D  LXSD                  84     84
010000131016     D  OPER                  85     94
010100220426     D  lagency               95     97
010200220426     D  lprionly              98     98
010300131016     D***SER                 100    107
010400000000     D  RETRO                108    108
010500050920     D  RTDTE                109    116  0
010600050920     D  RTDMD                109    112  0
010700050920     D  RTDY                 113    116  0
010800000000     D  CONAME               201    240
010900000000     D  STIME                242    253  0
011000000000     D  HMS                  242    247  0
011100000000     IHIST      NS  01
011200000000     I*  TRANSACTION HISTORY FILE
011300000000     I                                  1    1  HTYPE
011400000000     I                                  2   10 0SS#
011500000000     I                                 18   19  TRCOD2
011600000000     I                                 17   19  TRCODE        L1
011700000000     I                             P   20   24 2TRAMT
011800000000     I                                 25   25  CM$FLG                  25
011900000000     I                                 26   55  CK#NOT
012000140103     I                                 26   29  CK#PLN
012100140107     I                                 26   33  CK#PL3X
012200140107     I                                 34   37  CK#PL3
012300140107     I                                 39   41  CK#P#
012400140107     I                                 42   45  CK#PL2
012500000000     I                                 27   29  SSN1
012600050920     I                                 30   30  dash1
012700000000     I                                 31   32  SSN2
012800050920     I                                 33   33  dash2
012900000000     I                                 34   37  SSN3
013000000000     I                                 56   85  NOTE2                   22
013100000000     I                                110  119 0ACC#
013200000000     I                                110  112 0TRUST#        L5
013300000000     I                                113  115 0SUB#          L4
013400000000     I                                116  119 0ACCNO         L3
013500050920     I                                129  136 0TRDATE        L2
013600050920     I                                145  152 0RECVDT                  23
013700050920     I                                153  160 0COVTDT                  24
013800211230     I                                192  199  hstrtime
013900131010     I                                207  216  hoper
014000000000     I***
014100000000     ICODES     NS
014200000000     I*  CODES
014300000000     I                                 14   43  LDESCR
014400000000     I***
014500000000     IACCMST    NS
014600000000     I*  ACCOUNT MASTER FILE
014700000000     I                                 11   50  ACNAM1
014800000000     I***
014900000000     IMEMBER    NS
015000000000      *  MEMBER MASTER FILE
015100000000     I                                 10   18  LNAM9
015200000000     I                                 10   27  LNAME
015300000000     I                                 28   39  FNAME
015400000000     I                                 28   28  FI
015500000000     I                                 40   40  MI
015600140103      * Plan Aux key
015700140103     C     plxkey        KLIST
015800140103     C                   kfld                    trust#
015900140103     C                   kfld                    sub#
016000140107     C                   kfld                    planx             4
016100140103      *
016200180111      * exclude senior dental ans Advanced Mobil...
016300110124     c                   if        *inl5
016400110124     c                   clear                   l5ok              1
016500110124     c                   if        lxsd = 'Y'
016600110124     C     trust#        CHAIN     trsmst
016700180109     c                   if        %found(trsmst) and tscode = 'O N'
016800180109     c                             or %found(trsmst) and tscode = 'O M'
016900200110     c                             or %found(trsmst) and tscode = 'O D'
017000110124     c                   eval      l5ok = 'N'
017100180109     c                   endif
017200110124     c                   end
017300110124     c                   end
017400110124
017500110124     c                   if        l5ok = 'N'
017600110124     c                   goto      #endall
017700110124     c                   end
017800110124
017900990119     C                   MOVE      TRDATE        @DATIN
018000990119     C                   EXSR      #DATYM
018100990119     C                   MOVE      @DATOU        TRDMDY            8 0
018200990119     C*
018300990119     C                   MOVE      COVTDT        @DATIN
018400990119     C                   EXSR      #DATYM
018500990119     C                   MOVE      @DATOU        COVMDY            8 0
018600990119     C*
018700990119     C                   MOVE      RECVDT        @DATIN
018800990119     C                   EXSR      #DATYM
018900990119     C                   MOVE      @DATOU        RECMDY            8 0
019000050921
0191000509200261 C                   movel     ck#not        ck#notout
0192001401070111  * Check for Plan type transaction
019300140107     C                   eval      planx = *blanks
019400140103     C                   eval      acaflg = ' '
0195001401070261 C                   if        ck#p# = 'P#-'
019600140107     C                   eval      planx = ck#pl2
019700140107     C                   else
0198001401070261 C                   if        ck#pl3x = 'PLAN# - '
019900140107     C                   eval      planx = ck#pl3
020000140107     C                   else
0201001401070261 C                   if        ck#pln <> '    '
020200140107     C                   eval      planx = ck#pln
020300140107     C                   endif
020400140107     C                   endif
020500140107     C                   endif
0206001401070111  * Check for ACA
020700140107     C                   if        planx <> *blanks
0208001401030261 C     plxkey        chain     plnauxp                            55
0209001401030261 C                   if        *in55 = '0' and pxacar = 'Y'
021000140103     C                   eval      acaflg = 'Y'
021100140103     C                   endif
021200140103     C                   endif
0213001401030111  *
0214000509210261 C                   movel     note2         note2out
021500050920     c                   eval      ssnoout = (%editw(ss#:'0   -  -    '))
021600050921
0217000509210111  *********************
0218000509210111  * mask SSN
0219000509200261 C                   if        lmask = 'Y'
0220000509200261 C                   movel     ' XXX-XX'     ssnoout
022100050921
022200050921      * std SSN for adjustments
022300050920     c                   if        dash1 = '-' and dash2 = '-' and
022400050920     c                             (ssn3 >= '0000' and ssn3 <= '9999')
0225000509200261 C                   movel     ' XXX-XX'     ck#notout
0226000509200261 C                   end
022700050921
022800050921      * chg dep ss# transaction
022900050921     c                   if        trcode = 'M54'
0230000509210261 C                   movel     'XXXXX'       ck#notout
0231000509210261 C                   movel     'XXXXX'       note2out
0232000509210261 C                   end
023300050921
023400050921      * Diary notes can have SSN in any format, do not show note fields
023500050921     c                   if        trcode = 'UHM'
0236000509210261 C                   clear                   ck#notout
0237000509210261 C                   clear                   note2out
0238000509210261 C                   end
023900050921
0240000509200261 C                   end
0241000509210111  *********************
024200050921
024300000000     C*
024400000000     C* GET NEW ACCONNT NAME ON ACC# CHANGE
024500000000     C*
024600050922     c                   if        *inl3
024700110124     C                   clear                   oneline
024800110124     C                   MOVE      *BLANKS       T                 1
024900220104
025000220104     c                   clear                   acnam1_out
025100220104     C     ACC#          CHAIN     ACCMST
025200220104     c                   if        %found(accmst)
025300220104     c                   movel     acnam1        acnam1_out
025400220104     c                   end
025500220104
025600220104      * U2 = select single member only
025700220104     c                   if        *inu2
025800220104     c                   clear                   n
025900220104     C     SS#           CHAIN     MEMBER
026000220104     c                   if        %found(member)
026100220104     C                   EXSR      #NAME
026200220104     c                   end
026300220104     c                   end
026400220104
026500050922     C                   Z-ADD     0             Y                 3 0
026600050922     c                   end
026700000000      *
026800000000      *  IF RETROACTIVE REPORT COVTDT LT TRDATE
026900000000      *
027000050922     c                   if        *inu3 and
027100050922     c                             ((covtdt = 0) or (covtdt >= rtdymd))
027200000000     C                   SETOFF                                       01
027300000000     C                   GOTO      #END
027400050922     C                   end
027500000000     C*
027600000000     C*  IF WANT TO CHOOSE TRANSACTION CODES
027700000000     C*
027800000000     C     TRCOD         IFEQ      'Y'
027900000000     C                   Z-ADD     1             X                 2 0
028000000000     C     X             DOUGT     10
028100000000     C     TRCODE        IFEQ      COD(X)
028200000000     C                   GOTO      #SKIP
028300000000     C                   ELSE
028400000000     C                   ADD       1             X
028500000000     C                   END
028600000000     C                   END
028700000000     C                   SETOFF                                       01
028800000000     C                   GOTO      #END
028900000000     C                   END
029000000000     C*
029100000000     C     #SKIP         TAG
029200000000     C*
029300000000     C* CHECK FOR ACCOUNT / MEMBER TRANSACTION
029400000000     C*
029500000000     C     HTYPE         COMP      ' '                                2121
029600000000     C*
029700000000     C* IF LAST NAME IS SELECTED FOR REPORT (U4), GET MEMBER REC
029800050920     C* FROM SS# IN NOTE FIELD. (FOR ACCT TRANSACTIONS ONLY)
029900000000     C*
030000000000     C   U4              SETOFF                                       30
030100000000     C   21
030200000000     CAN U4SSNDS         CHAIN     MEMBER                             30
030300000000     C*
030400070109     C* GET CODE DESCRIPTION
030500000000     C*
030600220104     c                   clear                   ldescr_out
030700220104     C     TRCODE        CHAIN     CODES
030800220104     c                   if        %found(codes)
030900220104     c                   movel     ldescr        ldescr_out
031000220104     c                   end
031100000000     C*
031200000000     C                   ADD       1             Y
031300000000     C     T             IFNE      'Y'
031400000000     C                   MOVE      *BLANKS       ACCFLG            1
031500000000     C                   MOVE      'Y'           T
031600000000     C                   END
031700000000     C*
031800000000     C*  WHEN NEW ACCOUNT PRINT ACCOUNT NUMBER
031900000000     C*
032000000000     C     ACCFLG        IFNE      'Y'
032100000000     C                   EXCEPT    ACHEAD
032200000000     C   U2              EXCEPT    ACHED2
032300000000     C                   MOVE      'Y'           ACCFLG
032400000000     C                   END
032500000000     C*
032600000000     C* ACUMULATE TRAMT
032700000000     C*
032800000000     C                   ADD       TRAMT         TAMT              9 2
032900000000     C                   ADD       TRAMT         FAMT              9 2
033000110124     C                   ADD       TRAMT         LRAMT            12 2
033100981123      ***
033200000000     C     #END          TAG
033300050920
033400050920     c                   if        *inof
033500050920     C                   ADD       1             CNT
033600050920     C                   EXCEPT    HEAD
033700050920     c                   if        *inu2
033800050920     C                   EXCEPT    ached2
033900050920     c                   end
034000050920     c                   end
034100110124
034200110124     c   01              except    detail
034300140109     c   01              exsr      wrtwrk
034400110124     c   01              move      'Y'           oneline           1
034500110124
034600110124     C     #endall       TAG
034700050920
034800140109      *
034900110124     CL3                 if        oneline = 'Y'
035000110124     CL3   Y             IFGE      1
035100000000     CL3                 EXCEPT    TOTACC
035200140109     CL3                 EXCEPT    TOTACC
035300000000     CL3                 Z-ADD     0             Y
035400000000     CL3                 END
035500110124     CL3                 END
035600140109      *
035700140109     CLR                 call      'RP131C'
035800140109     C                   PARM                    rwfrom
035900140109     C                   PARM                    rwtodt
036000140109     C                   PARM                    rwtrst
036100140109     C                   PARM                    rwsub#
036200140109     C                   PARM                    rwacct
036300140109     C                   PARM                    rwsssn
036400050922      ***************************************************************888
036500050922      *   FIELD= FIRST MI. LAST
036600000000      *----------------- COMPRESS NAME FIELDS -------------------*
036700050922      ***************************************************************888
036800050922
036900000000      * INITIALIZE ARRAY AND COUNTER
037000000000      *
037100000000     C     #NAME         BEGSR
037200050922     C                   clear                   N                31
037300050922     C                   MOVEL     fname         N
037400050922     C                   IF        mi <> ' '
037500050922     C                   CAT       mi:1          N
037600050922     C                   CAT       '.':0         N
037700050922     C                   END
037800050922     C                   CAT       lname:1       N
037900050922
038000000000     C                   ENDSR
0381009901190107 C*
0382009901190103 C***************************************************
0383009901190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0384009901190105 C***************************************************
0385009901190107 C*
0386009901190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0387009901190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0388009901190107 C*
0389009901190106 C     #DATYM        BEGSR
039000990119     C                   MOVE      @DATIN        @MD               4 0
039100990119     C                   MOVEL     @DATIN        @Y                4 0
039200990119     C                   MOVEL     @MD           @DATOU            8 0
039300990119     C                   MOVE      @Y            @DATOU
039400990119     C                   MOVE      *ZEROS        @DATIN            8 0
0395009901190120 C                   ENDSR
039600050920
0397001401090103  ***************************************************
0398001401090104  * Write Work FIle                                 *
0399001401090105  ***************************************************
0400001401090107  *
0401001401090106 C     wrtwrk        begsr
040200201112      *
040300201112      * get carrier name if this trcode is a member level code that uses
040400201112      * a plan
040500201112      *
040600201112     c                   exsr      #getcar
040700201112
040800220128      * get member name again here so it shows for all transactions
040900220128      * possible regardless of what option was seleted on the screen
041000220128      * (that option only applies to the printed report).
041100220128
041200220128       clear lname_out;
041300220128
041400220128      * acct transaction (use ssn in note field of adj)
041500220128      * "G" prefix trcode = auto adjustment (these are the only
041600220128      *                     transactions that use the ssnds values)
041700220201       if htype <> ' ' and %subst(trcode:1:1) = 'G' and
041800220201         not (trcode in %list('GIF':'GAF':'GDI'));
041900220128        chain ssnds member;
042000220128        if %found(member);
042100220128         lname_out = lname;
042200220128        endif;
042300220128       endif;
042400220128
042500220128      * member transaction (use ssn from hkey)
042600220128       if htype = ' ';
042700220128        chain ss#   member;
042800220128        if %found(member);
042900220128         lname_out = lname;
043000220128        endif;
043100220128       endif;
043200220128
043300140116     C                   eval      rp13clr1 = *blanks
043400140116     C                   movel     trust#        rtrust#
043500140116     C                   eval      rwd1 = '-'
043600140116     C                   movel     sub#          rsub#
043700140116     C                   eval      rwd2 = '-'
043800140116     C                   movel     accno         raccno
043900220104     C                   eval      rwacnm = acnam1_out
044000140116     C                   eval      rp13clr2 = *blanks
044100140110     C  N21              eval      rwssno = ssnoout
044200220128     C                   eval      rwlnam = lname_out
044300180406     C                   eval      lname = *blanks
044400140109     C                   eval      rwtrdt = %editw(trdmdy:'0 /  /    ')
044500211230     C                   eval      rwtrtime = hstrtime
044600220104     C                   eval      rwtran = ldescr_out
044700140109     C                   eval      rwtram = %editc(tramt:'P')
044800140109     C                   eval      rwabal = %editc(tamt:'P')
044900140109     c                   if        covmdy <> 0
045000140109     C                   eval      rwefdt = %editw(covmdy:'0 /  /    ')
0451001401090120 C                   endif
045200140109     c                   if        recmdy <> 0
045300140109     C                   eval      rwrecd = %editw(recmdy:'0 /  /    ')
0454001401090120 C                   endif
045500140109     C                   eval      rwck#n = ck#notout
045600140109     C                   eval      rwck#2 = note2out
045700140109     C                   eval      rwacaf = acaflg
045800140109     C                   eval      rwuser = hoper
045900220127     C                   eval      rwplan = plan_out
046000220127     C                   eval      rwpdescr = %trim(pdescr_out)
046100220127     C                   eval      rwcarr = %trim(cnameout)
046200140109     C                   write     rp13wkr
0463001401090120 C                   ENDSR
046400140109
0465002011120103  *****************************************************************
0466002011120104  * get carrier if this is a member transaction that uses plan    *
0467002011120103  *****************************************************************
0468002011120107  *
0469002011120106 C     #getcar       begsr
047000201112      *
047100201112      * get carrier name if this trcode is a member level code that uses
047200201112      * a plan. These codes come from TR260 (auto adj)
047300201112      *
047400201112       clear cnameout;
047500220127       clear plan_out;
047600220127       clear pdescr_out;
047700220127
047800201112       if (trcode = 'MAC' or trcode = 'MDC' or trcode = 'MRC' or
047900201112           trcode = 'MCC' or trcode = 'MCB' or trcode = 'MCA' or
048000201112           trcode = 'MDD' or trcode = 'MDA' or trcode = 'MDX' or
048100201112           trcode = 'MDR' or trcode = 'MDU' or trcode = 'MCX' or
048200201112           trcode = 'MCE') and
048300201112           ck#pln <> *blanks;
048400220127        plan_out = ck#pln;
048500220127        chain (trust#:sub#:ck#pln) plnmst;
048600220127        if %found(plnmst);
048700220127          pdescr_out = pdescr;
048800220127          chain pcarr carmst;
048900220127          if %found(carmst);
049000220127           cnameout = cname;
049100220127          endif;
049200220127        endif;
049300201112       endif;
049400201112
0495002011120120 C                   ENDSR
049600201112
049700050920     C***********************
049800050920     C* first cycle
049900050920     C***********************
0500000509200120 C     *inzsr        begsr
050100050921     c                   movel     lssno         lssnoout
050200050921     c                   if        lmask = 'Y' and lssnoout <> *blanks
050300050921     c                   movel     'XXXXX'       lssnoout
050400050921     c                   end
050500050921
050600050920     C                   EXCEPT    CRTRIA
050700140109      *       Set key fields for work file
050800140109     C                   clear                   rp13wkr
050900140109     C                   movel     lfdate        rwfrom
051000140109     C                   movel     ltdate        rwtodt
051100140109     C                   eval      rwtrst = ltrust
051200140109     C                   eval      rwsub# = lsub
051300140109     C                   eval      rwacct = lacct
051400140109     C                   eval      rwsssn = lssnoout
051500140109      *
051600140109     C                   Z-ADD     1             CNT               7 0
051700050920     C                   EXCEPT    HEAD
051800050920     C                   MOVEL     RTDY          RTDYMD            8 0
051900050920     C                   MOVE      RTDMD         RTDYMD
052000050920     C     SORL          IFEQ      'L'
052100050920     C                   SETON                                        U4
052200050920     C                   END
052300050920     C*
0524000509200120 C                   ENDSR
052500050920     C*
052600000000     C/EJECT
052700000000      ******************************************************
052800000000      *  OUTPUT SPECIFICATIONS                             *
052900000000      ******************************************************
053000000000     O***
053100000000     OREPORT    E            CRTRIA         2  3
053200000000     O                       CONAME             110
053300220105     O          E            CRTRIA         2
053400000000     O***
053500000000     O                                           98 'Transaction Listing'
053600220105     O          E            CRTRIA         1
053700000000     O***
053800220105     O                                          107 '1. Select Date Range......-
053900220105     O                                              ...........................'
054000220105     O                                          118 '-'
054100220105     O                       LFDATE             116
054200220105     O                       LTDATE             127
054300220105     O          E            CRTRIA         1
054400220105     O                                          107 '2. Select Trust-Sub-Acct..-
054500220105     O                                              ...........................'
054600220105     O                                          113 '-'
054700220105     O                                          119 '-'
054800220105     O                       LTRUST             111
054900220105     O                       LSUB               117
055000220105     O                       LACCT              124
055100220105     O          E            CRTRIA         1
055200220105     O                                          107 'Or Select a SSN...........-
055300220105     O                                              ........................'
055400220105     O                       LSSNOOUT           118
055500220105     O          E            CRTRIA         1
055600000000     O***
055700000000     O***
055800220105     O                                          115 '3. Sort in Arrival,Transac-
055900220105     O                                              tion Code,or Audit Order? (-
056000220105     O                                              A,T,D)..'
056100220105     O                       SORT               118
056200220105     O          E            CRTRIA         1
056300000000     O***
056400220105     O                                          115 '4. Include All,Financial,M-
056500220105     O                                              ember,Cobra Transactions (A-
056600220105     O                                              ,F,M,C).'
056700220105     O                       TRNSAC             118
056800220105     O          E            CRTRIA         1
056900000000     O***
057000220105     O                                          101 'Select a Transaction Code -
057100220105     O                                              (Y/N)..............'
057200220105     O                       TRCOD              104
057300220105     O                                          114 'CODES: '
057400220105     O                       COD(1)             117                             000003
057500220105     O                       COD(2)             121                             000003
057600220105     O                       COD(3)             125                             000003
057700220105     O                       COD(4)             129                             000003
057800220105     O                       COD(5)             133                             000003
057900220105     O                       COD(6)             137                             000003
058000220105     O                       COD(7)             141                             000003
058100220105     O                       COD(8)             145                             000003
058200220105     O                       COD(9)             149                             000003
058300220105     O                       COD(10)            153                             000003
058400220105     O          E            CRTRIA         1
058500000000     O***
058600220105     O                                          115 '5. Retroactive report (Y/N-
058700220105     O                                              )..........................-
058800220105     O                                              ........'
058900220105     O                       RETRO              118
059000220105     O          E            CRTRIA         1
059100220105     O                                          101 'If Yes Enter Comparison Da-
059200220105     O                                              te.................'
059300220105     O                       RTDTE              113 '0 /  /    '
059400220105     O          E            CRTRIA         1
059500000000     O***
059600220105     O                                          115 '6. User Id or All.........-
059700220105     O                                              ...........................-
059800220105     O                                              ........'
059900220105     O                       OPER               127
060000220105     O          E            CRTRIA         1
060100000000     O***
060200220105     O                                          115 '7. Print (S)sn or (L)ast n-
060300220128     O                                              ame on printed report .....-
060400220105     O                                              ........'
060500220105     O                       SORL               118
060600220105     O          E            CRTRIA         1
060700000000     O***
060800220105     O                                          115 '8. Mask SSN (XXX-XX-1234) -
060900220105     O                                              (Y/N)......................-
061000220105     O                                              ........'
061100220105     O                       LMASK              118
061200220105     O          E            CRTRIA         1
061300220105     O                                          115 '9.  Exclude Senior Dental,-
061400220105     O                                               Adv. Mobile and CSMI......-
061500220105     O                                              ........'
061600220105     O                       LXSD               118
061700220105     O          E            CRTRIA         1
061800220426     O                                          115 '10. Select Agency.........-
061900220105     O                                              ...........................-
062000220105     O                                              ........'
062100220426     O                       Lagency            120
062200220105     O          E            CRTRIA        14
062300220105     O                                          115 '11. Select Principal carri-
062400220105     O                                              er only....................-
062500220105     O                                              ........'
062600220105     O                       LPRIONLY           118
062700220105     O          E            HEAD           2  3
062800000000     O***
062900000000     O                       CONAME             119
063000220105     O          E            HEAD           1
063100000000     O***
063200000000     O                       UDATE         Y     14
063300000000     O                                          109 'TRANSACTION HISTORY'
063400000000     O               U1                         149 '*** COBRA MEMBERS ***'
063500000000     O                                          188 'PAGE :'
063600000000     O                       CNT           Z    196
063700220105     O          E            HEAD           1
063800000000     O***
063900000000     O                                           17 'PROG: RP130'
064000000000     O               U3                         108 'RETROACTIVE REPORT'
064100000000     O                                          188 'TIME :'
064200000000     O                       HMS                196 '  :  :  '
064300220105     O          E            HEAD           1
064400000000     O***
064500000000     O                                           83 'FROM -'
064600050920     O                       LFDATE              95 '0 /  /    '
064700000000     O                                          104 'TO -'
064800050920     O                       LTDATE             115 '0 /  /    '
064900220105     O          E            HEAD           1
065000000000     O***
065100000000     O                                           63 'TRUST -'
065200000000     O                       LTRUST              67
065300000000     O                                           87 'SUBDIVISION -'
065400000000     O                       LSUB                91
065500000000     O                                          113 'ACCOUNT -'
065600000000     O                       LACCT              118
065700220105     O          E            HEAD           1
065800000000     O***
065900000000     O                                           24 '------------------------'
066000000000     O                                           48 '------------------------'
066100000000     O                                           72 '------------------------'
066200000000     O                                           96 '------------------------'
066300000000     O                                          120 '------------------------'
066400000000     O                                          144 '------------------------'
066500000000     O                                          168 '------------------------'
066600000000     O                                          192 '------------------------'
066700000000     O                                          198 '------'
066800220105     O          E            HEAD           1
066900000000     O***
067000000000     O                                            8 'ACCT #'
067100000000     O                                           23 'TR DATE'
067200000000     O                                           38 'TRANSACTION'
067300000000     O                                           73 'TRANS. AMOUNT'
067400000000     O                                           91 'ACCOUNT BALANCE'
067500000000     O                                          104 'EFF. DATE'
067600000000     O                                          116 'REC. DATE'
067700000000     O                                          136 'NOTE 1'
067800140103     O                                          169 'NOTE 2'
067900140103     O                                          187 'ACA'
068000050921     O                                          198 'USER   '
068100220105     O          E            HEAD           1
068200000000     O***
068300000000     O                                           24 '------------------------'
068400000000     O                                           48 '------------------------'
068500000000     O                                           72 '------------------------'
068600000000     O                                           96 '------------------------'
068700000000     O                                          120 '------------------------'
068800000000     O                                          144 '------------------------'
068900000000     O                                          168 '------------------------'
069000000000     O                                          192 '------------------------'
069100000000     O                                          198 '------'
069200220105     O          E            ACHEAD      1  1
069300000000     O***
069400000000     O                       TRUST#               3
069500000000     O                                            4 '-'
069600000000     O                       SUB#                 7
069700000000     O                                            8 '-'
069800000000     O                       ACCNO               12
069900220104     O                       ACNAM1_OUT          54
070000220105     O          E            ACHED2      1  2
070100000000     O***
070200050920     O               U2      SSNOOUT             12
070300000000     O               U2      N                   45
070400220105     O          E            DETAIL         1
070500000000     O***
070600050920     O              N21      SSNOOUT             12
070700050920     O                       TRDMDY              24 '  /  /    '
070800220104     O                       LDESCR_OUT          57
070900000000     O                       TRAMT         C     73
071000000000     O                       TAMT          C     91
071100050920     O              N24      COVMDY             103 '0 /  /    '
071200050920     O              N23      RECMDY             115 '0 /  /    '
071300000000     O                       CM$FLG             118
071400000000     O              N25                         119 '-'
071500050920     O                       CK#NOTOUT          149
071600000000     O*
071700050920     O* PRINT THE NAME IN PLACE OF THE SSN IN THE NOTE FIELD
071800000000     O* U4=SELECTED FROM SCREEN, 21=ACCT TYPE HIST, N30=HIT ON MEMBER
071900000000     O*
072000000000     O               21 U4N30FI             B   121
072100000000     O               21 U4N30                   122 '.'
072200000000     O               21 U4N30LNAM9          B   131
072300140103     O              N22      NOTE2OUT           183
072400140103     O                       ACAFLG             186
072500131010     O                       HOPER              198
072600220105     O          E            TOTACC      1  1
072700000000     O***
072800110124     O                                           56 '*** ACCOUNT TOTAL:'
072900110124     O                       TAMT          CB    73
073000220105     O          T    LR                  2
073100000000     O***
073200110124     O                                           56 '*** FINAL TOTAL:'
073300110124     O                       LRAMT         CB    73
