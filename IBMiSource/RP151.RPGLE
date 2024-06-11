000100130924     H DFTNAME(RP151) OPTION(*nodebugio) debug
000200990929      ******************************************************************
000300990930      * RP151      GROUP BENEFIT SERVICES SOFTWARE           1990      *
000400990929      *                                                                *
000500990929      *            MODIFIED BY - WALTER PICCININI                      *
000600990929      *            DATE - 01/90                                        *
000700990929      *                                                                *
000800000217      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A  FILE FOR DEPENDENTS*
000900990929      *                ATTAINING ?? YRS AGE. CHAIN TO MEMBER FILE      *
001000990929      *                TO GET TRUST #,SUBDIVISION #,ACCT. #,ETC....    *
001100990929      *                                                                *
001200990929      *  Y2K CONVERT - 1998                                            *
001300990929      *                                                                *
001400991014      *  10/99 - KSJ - COVERTED TO RPGLE                               *
001500070706      * 07/06/07 dlk - remove HU & WI exclusion per admin request      *
001600080227      * 02/27/08 szz - for CareFirst-only runs, include all cat codes  *
001700100301      * 03/01/10 szz - Exclude On-site Dental (Trust Category Code N)
001800100301      *                 per Shelly R. and Dave A.
001900120228      * 02/28/12 szz - Exclude HU/WI/PA only when not age 65.          *
002000120301      *                Age 23 & 25: Exclude any coverage with category
002100120301      *                code MM.  Exclude any member with a CFS product.
002200120301      *                Age 26: Include children with Medical,Dental,Vision.
002300140327      * 03/27/14 dpb - Ignore accts with Luminx flag in AC2MST.        *
002400180109      * 01/09/18 jt  - Added changes for Advanced Mobile
002500200110      * 01/09/18 jt  - Added changes for Advanced Mobile
002600210430      * 01/10/20 jt  - Added changes for CMS
002700210430      * 04/30/21 ja  - remove writeletters = N override for age 65
002800990929      ******************************************************************
002900991006     FDEPEND    IF   E           K DISK
003000991004     FMEMBER    IF   E           K DISK
003100991006     FDCOVC     IF   E           K DISK
003200991004     FPLNMST    IF   E           K DISK
003300100301     FTRSMST    IF   E           K DISK
003400120307     FCARMSTL   IF   E           K Disk
003500140327     Fac2mstl2  if   e           k disk
003600991004     FRP15XWK   O    E           K DISK
003700130531     F********RP15WWK   O    E           K Disk
003800130531     FRP15RWK   O    E           K Disk
003900990929
004000990929     D                 DS
004100990930     DDATE2                    1      8  0
004200990929     D  YYDTE                  1      4  0
004300990929     D  MMDTE                  5      6  0
004400990929     D  DDDTE                  7      8  0
004500990929
004600991001     D                 DS
004700991001     D UD8YMD                  1      8  0
004800991006     D   UD8Y                  5      8  0
004900991001
005000991004     D                 DS
005100991006     D DYYMM                   1      6  0
005200991004     D   DYY                   1      4  0
005300991004     D   DMM                   5      6  0
005400991004
005500990929     D                UDS
005600991001     D LTRUST                  3      5
005700991001     D LSUB                    6      8
005800991001     D LACC                    9     12
005900991001     D LFMMYY                 13     18  0
006000991001     D   LFMM                 13     14  0
006100991001     D   LFYY                 15     18  0
006200991001     D LTMMYY                 19     24  0
006300991001     D   LTMM                 19     20  0
006400991001     D   LTYY                 21     24  0
006500991008     D LAGE                   25     26  0
006600080227     D LCFYN                  29     29
006700990929
006800990930     DDAGE             S              3  0
006900991015     DXAGE             S              4  0
007000990930     DDTECMP           S              8  0
007100991004     DTRUSTC           S              3
007200991004     DSUBC             S              3
007300991004     DACCTC            S              4
007400991006     DVALID            S              1
007500991006     DCHKSS#           S              9  0
007600120307     D CF              S              2A   Inz('CF')
007700990929
007800990930     C     PLNKEY        KLIST
007900990930     C                   KFLD                    MBTRST
008000990930     C                   KFLD                    MBSUB#
008100991004     C                   KFLD                    DVPLAN
008200990930
008300991006     C     DEPKEY        KLIST
008400991006     C                   KFLD                    DSSNO
008500991006     C                   KFLD                    DPSEQ#
008600120307
008700120307     C     CarKey        Klist
008800120307     C                   Kfld                    CF
008900120307     C                   Kfld                    PCARR
009000991006
009100991001     C                   EVAL      UD8YMD = *DATE
009200991001
009300991001     C                   READ      DEPENR                                 99
009400991001     C                   DOW       *IN99 = *OFF
009500991015     C                   IF        DPDLTD <> 'D'
009600990929      *
009700990929      *  IF THE DATE TYPED IN IS ZERO  AND AGE IS 65 PRINT ALL PEOPLE
009800990929      *  WHO ARE 65 AND OLDER IF IT IS ANY AGE BUT 65 AND DATE IS
009900990929      *  ZERO PRINT ANYONE WHO IS THAT AGE.  IF THE DATE IS NOT ZERO
010000990929      *  PRINT ANYONE TURNING INPUT AGE
010100990929      *
010200991015     C                   MOVEL     DBIRTH        DYYMM
010300991015     C                   EVAL      DAGE = *ZEROS
010400991015     C                   EVAL      XAGE = *ZEROS
010500991004     C                   IF        LFMMYY <> *ZEROS
010600991006     C                   IF        DMM >= LFMM AND DMM <= LTMM
010700991015     C                   IF        DYY <> *ZEROS
010800991022     C                   EVAL      XAGE = LFYY - DYY
010900991015     C                   IF        XAGE > 999
011000991015     C                   EVAL      DAGE = 000
011100991015     C                   ELSE
011200060215     C                   z-add     XAGE          DAGE
011300991015     C                   ENDIF
011400991015     C                   ENDIF
011500991008     C                   IF        DAGE = LAGE
011600991006     C                   EVAL      VALID = 'Y'
011700990930     C                   ENDIF
011800991006     C                   ENDIF
011900930125     C                   ELSE
012000991008     C                   IF        LAGE = 65
012100991015     C                   IF        DYY <> *ZEROS
012200991022     C                   EVAL      XAGE = UD8Y - DYY
012300991015     C                   IF        XAGE > 999
012400991015     C                   EVAL      DAGE = 000
012500991015     C                   ELSE
012600060215     C                   z-add     XAGE          DAGE
012700991015     C                   ENDIF
012800991015     C                   ENDIF
012900991006     C                   IF        DAGE >= 65
013000991006     C                   EVAL      VALID = 'Y'
013100990930     C                   ENDIF
013200991006     C                   ELSE
013300991015     C                   IF        DYY <> *ZEROS
013400991015     C                   EVAL      XAGE = UD8Y - DYY
013500991015     C                   IF        XAGE > 999
013600991015     C                   EVAL      DAGE = 000
013700991015     C                   ELSE
013800060215     C                   z-add     XAGE          DAGE
013900991015     C                   ENDIF
014000991015     C                   ENDIF
014100991006     C                   IF        DAGE = 65
014200991006     C                   EVAL      VALID = 'Y'
014300990930     C                   ENDIF
014400991006     C                   ENDIF
014500991006     C                   ENDIF
014600990929
014700991006     C                   IF        VALID = 'Y'
014800991006     C     DSSNO         CHAIN     MEMBR                              50
014900991006     C                   IF        *IN50 = *OFF
015000990929
015100140327      /free
015200140327        chain (mbtrst:mbsub#:mbacct) ac2mstl2 ;
015300140327      /end-free
015400140327     C                   if        %found(ac2mstl2) and a2luminx <> 'Y'
015500140327
015600991004     C                   MOVE      MBTRST        TRUSTC
015700991004     C                   MOVE      MBSUB#        SUBC
015800991004     C                   MOVE      MBACCT        ACCTC
015900991004
016000991004     C                   IF        (LTRUST = 'ALL' OR LTRUST = TRUSTC) AND
016100991004     C                             (LSUB = 'ALL' OR LSUB = SUBC) AND
016200991004     C                             (LACC = 'ALL ' OR LACC = ACCTC)
016300990929
016400990929
016500930513     C                   IF        TERMDT <> *ZEROS
016600991004     C                   IF        LFMMYY <> *ZEROS
016700991004     C                   EVAL      MMDTE = LFMM
016800990930     C                   EVAL      DDDTE = 01
016900991004     C                   EVAL      YYDTE = LFYY
017000991004     C                   EVAL      DTECMP = DATE2
017100930513     C                   ELSE
017200990930     C                   EVAL      DTECMP = UD8YMD
017300991001     C                   ENDIF
017400990930     C                   ENDIF
017500990929      *
017600990929      *  ONLY TAKE PEOPLE WHO HAVE ACTIVE MEDICAL OR DENTAL PLANS
017700990929      *
017800991006     C                   IF        (TERMDT <> *ZEROS AND TERMDT > DTECMP) OR
017900991006     C                              TERMDT = *ZEROS
018000130524      *---
018100121106      * Age 65 can be medical, dental or vision
018200130524      *---
018300120308     C                   If        LAGE    = 26 Or LAGE = 65
018400121031     C                   If        LAGE = 65
018500130529     C                                   And     DAGE = LAGE
018600130524     C                   Movel     LAGE          WAge
018700130524     C                   Movel     DSSNO         WSSno
018800130529     C                   Movel     DPSEQ#        WSeq#
018900130529     C                   Movel     MBTRST        WTrust
019000130529     C                   Movel     MBSUB#        WSub
019100130524     C                   Call      'RP1519'
019200130524     C                   Parm                    WAge              2
019300130524     C                   Parm                    WSSno             9
019400130524     C                   Parm                    WSeq#             2
019500130524     C                   Parm                    WTrust            3
019600130524     C                   Parm                    WSub              3
019700130524     C                   Parm                    WriteLetter       1
019800121031     C                   End
019900121031      * Age 26 can be medical, dental or vision
020000121031      *---
020100210430     C****** 4.30.21     Move      'N'           WriteLetter
020200121031      *---
020300130524     C                   IF        DRELCD <> 'RWI' AND DRELCD <> 'RHU'  And
020400130524     C                             DRELCD <> 'RPA'
020500121031     C                   If        LAGE = 26
020600130529     C                                   And     DAGE = LAGE
020700130524     C                   Movel     LAGE          WAge
020800130524     C                   Movel     DSSNO         WSSno
020900130529     C                   Movel     DPSEQ#        WSeq#
021000130529     C                   Movel     MBTRST        WTrust
021100130529     C                   Movel     MBSUB#        WSub
021200130524     C                   Call      'RP1519'
021300130524     C                   Parm                    WAge              2
021400130524     C                   Parm                    WSSno             9
021500130524     C                   Parm                    WSeq#             2
021600130524     C                   Parm                    WTrust            3
021700130524     C                   Parm                    WSub              3
021800130524     C                   Parm                    WriteLetter       1
021900130524     C                   If        WriteLetter = 'N'
022000130524     C                   End
022100120308     C                   End
022200120308      *
022300120308     C                   End
022400121031     C                   End
022500130524      *---
022600121121      * Age 23 or 25 cannot have medical or a CF product to get a letter.
022700130524      *---
022800130924     C                   If        (LAGE = 23 Or LAGE = 25) and dage = lage
022900121121     C                   IF        DRELCD <> 'RWI' And DRELCD <> 'RHU'  And
023000121121     C                             DRELCD <> 'RPA'
023100121121      * Per Carol F:  If a member has any CFS or any medical, no letter.
023200130524     C                   Movel     LAGE          Wage
023300130523     C                   Movel     DSSNO         WSSno
023400130529     C                   Movel     DPSEQ#        WSeq#
023500130529     C                   Movel     MBTRST        WTrust
023600130529     C                   Movel     MBSUB#        WSub
023700130523     C                   Call      'RP1519'
023800130604     C                   Parm                    WAge              2
023900130604     C                   Parm                    WSSno             9
024000130604     C                   Parm                    WSeq#             2
024100130604     C                   Parm                    WTrust            3
024200130604     C                   Parm                    WSub              3
024300130604     C                   Parm                    WriteLetter       1
024400130523     C                   If        WriteLetter = 'N'
024500121121     C                   End
024600120308     C                   End
024700120308     C                   End
024800130524      *---
024900130524      * Per Carol F:  If a member has any CFS or any medical, no letter.
025000130524      *---
025100120308     C                   If        LAGE    = 19
025200130529     C                                   And     DAGE = LAGE
025300121121     C                   IF        DRELCD <> 'RWI' And DRELCD <> 'RHU'  And
025400121121     C                             DRELCD <> 'RPA'
025500130524     C                   Movel     LAGE          WAge
025600130523     C                   Movel     DSSNO         WSSno
025700130529     C                   Movel     DPSEQ#        WSeq#
025800130529     C                   Movel     MBTRST        WTrust
025900130529     C                   Movel     MBSUB#        WSub
026000130523     C                   Call      'RP1519'
026100130524     C                   Parm                    WAge              2
026200130523     C                   Parm                    WSSno             9
026300130523     C                   Parm                    WSeq#             2
026400130523     C                   Parm                    WTrust            3
026500130523     C                   Parm                    WSub              3
026600130523     C                   Parm                    WriteLetter       1
026700120308     C                   End
026800120308     C                   End
026900120308      *
027000121031      *------------------------------------------------------------------*
027100130524      *                                                                  *
027200130604     C                   IF        DPDLTD =  'A'
027300130604      *                                                                  *
027400130524      *                          R  E  P  O  R  T                        *
027500130524      *                                                                  *
027600121210      *  Letters are only printed for the special criteria but the report
027700121210      *  is printed for all dependents attaining age.
027800121210      *
027900130524     C                   IF        DAGE = LAGE
028000130529     C**???              IF        CHKSS# <> DEPSS#
028100121210     C     MBTRST        Chain     TRSMST
028200200110       if tscode <> 'O N'
028300200110        or tscode <> 'O M'
028400200110         or tscode <> 'O D';
028500130531      *---
028600130531      * Prep for Dependents Turning Age Report workfile
028700130531      *---
028800130531     C                   Eval      RSSNO     =   DSSNO
028900130531     C                   Eval      RSEQ#     =   DPSEQ#
029000130531     C                   Eval      RTRUSTC   =   TRUSTC
029100130531     C                   Eval      RSUBC     =   SUBC
029200130531     C                   Eval      RACCTC    =   ACCTC
029300130531     C                   Eval      RREPORT   =   'Y'
029400130531     C                   Eval      RDLNAME   =   DLNAME
029500130531     C                   Eval      RDFNAME   =   DFNAME
029600130531     C                   Eval      RDMI      =   DMI
029700130531     C                   Eval      RDSEX     =   DSEX
029800130531     C                   Eval      RDRELCD   =   DRELCD
029900130531     C                   Eval      RMBENRL   =   MBENRL
030000130531     C                   Eval      RDBIRTH   =   DBIRTH
030100130603     C                   Eval      RMFNAME   =   MFNAME
030200130603     C                   Eval      RMLNAME   =   MLNAME
030300130603     C                   Eval      RMMI      =   MMI
030400130531     C                   Write     RP15RR
030500130531     C                   Clear                   RP15RR
030600130531      *
030700130531     C*****              If        WTRUSTC <> *Zeros   AND
030800130531     C*****                        WSUBC   <> *Zeros   AND
030900130531     C*****                        WACCTC  <> *Zeros   AND
031000130531     C*****                        WMBSSNO <> *Zeros
031100130531     C*****              WRITE     RP15WR
031200130531     C*****              End                                                     record not blank
031300121210     C                   End
031400130604     C                   End
031500121210     C                   End
031600121031      *------------------------------------------------------------------*
031700130524      *                                                                  *
031800130524      *                          L  E  T  T  E  R  S                     *
031900210430      *                                                                  *
032000130103     C                   If        WriteLetter = 'Y'
032100130529     C***??              IF        CHKSS# <> DEPSS#
032200121031     C     MBTRST        Chain     TRSMST
032300200110       if tscode <> 'O N'
032400200110        or tscode <> 'O M'
032500200110         or tscode <> 'O D';
032600200110        write rp15xr;
032700200110       endif;
032800130524     C***************    EVAL      CHKSS# = DEPSS#
032900130529     C***??              ENDIF
033000991001     C                   ENDIF
033100130103     C                   End
033200130529     C                   ENDIF
033300140327
033400140327     C                   ENDIF
033500140327
033600991006     C                   ENDIF
033700140327
033800991006     C                   EVAL      VALID = 'N'
033900130524     C                   ENDIF
034000140327
034100130524     C                   ENDIF
034200991001     C                   READ      DEPENR                                 99
034300991001     C                   ENDDO
034400990929
034500991001     C                   EVAL      *INLR = *ON
