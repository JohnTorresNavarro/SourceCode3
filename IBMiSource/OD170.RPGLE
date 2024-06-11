0001009102120002 F******************************************************************
0002001007010003 F* OD170      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102120004 F*                                                                *
000400100630     F*   This is a clone of RP170 which was                           *
0005001006300005 F*   originally WRITTEN BY - DAVID KETTERMAN                      *
0006009102120007 F*                                                                *
0007009102120008 F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE A LIST OF ACCOUNTS    *
0008009102120009 F*                PENDING CANCELLATION DUE TO NON PAYMENT.        *
000900100714     F*  The cloned version generates a file, OD170OUT, which is used  *
001000100714     F*  to drive the Senior Dental Collections Letter process using   *
001100100714     F*  RPG_WORD programs.                                            *
0012009102120010 F*                                                                *
001300110222      *                R E V I S I O N    H I S T O R Y                *
001400110222      *  Date                                                          *
001500110222      *  Revised   Initials    Revision                                *
001600110222      *  --------  --------    --------------------------------------  *
001700110222      *  2/22/2011   szz       Add Archive File for reprinting letters.*
001800110717      *  7/17/2011   szz       Exclude generated letters for accounts in
001900110717      *                         the exclusion file for the exclusion month.
002000130118      *  1/18/2013   szz       Change the total amount formula calculation
002100130118      *                         per Cindy W./Shelly.
002200130218      *  2/18/2013   szz       Per Angie, ARP contact should be based on
002300130218      *                         heading date.
002400131010      * 10/10/2013   sbt       Hist file expansion project
002500131112      * 11/12/13 dlk - remove credits from payment formula
002600150202      * 01/30/2015   dlk       change payment % required to 90 for dbe
002700150216      * 02/16/15 dlk - remove hard coded dbe payment required percent
002800150522      * 05/22/15 dlk - remove care first withhold care letters since they
002900150522      *                are not needed here
003000150714      * 07/14/15 dlk - remove "skip courtesy letter if printed last month"
003100150714      *                logic - per Shelly R.
003200150721      * 07/21/15 dlk - make letter amount due the same as the standard      nt
003300150721      *                payment calculation amount so letters are only
003400150721      *                produced for accts that have a real balance. Also
003500150721      *                remove printed pending cancel report since they use
003600150721      *                the csv output.
003700150904      * 09/04/15 dlk - if no RP found, use acct address (per Shelly)        nt
003800160418      * 09/23/15 dlk - convert to use GETPAIDCL
003900160418      * 04/18/16 dlk - add blank remit date parm to getpaidcl
004000180111      * 01/11/18 jt  - added changes for Advanced Mobil
004100200120      * 01/20/20 jt  - added changes for CSM
0042009102120012 F******************************************************************
0043009812090013 FACCMST    IP   F  560        DISK
0044009812090016 FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
0045001310100017 FHIST      IF A F  216    10AIDISK    KEYLOC(1)
004600030625     FHISTL4    IF   E           K DISK
004700030703     FHISTL5    IF   E           K DISK    Prefix(L5) Rename(HISTR:HISTR5)
0048009805290016 FINVSUM    IF   E           K DISK
0049009812030016 FPLNMST    IF   E           K DISK
0050009812030016 FCARMST    IF   E           K DISK
0051009812090014 FMEMAC#    IF   F  648    10AIDISK    KEYLOC(136)
0052009812090016 FMCOV      IF   F   88     9AIDISK    KEYLOC(1)
005300100701     FMCOVX     IF   E           K Disk    Rename(MCOVR:XR) Prefix(X)
005400030625     FSMAN      IF   E           K DISK
005500030625     FAACODE    IF   E           K DISK
005600050810     FACCBSP    IF   E           K Disk
005700100719     FODFACP    IF   E           K Disk
005800091015     Fodcntcp   IF   E           K Disk
005900110707     Fsubmst    IF   E           K Disk
006000110717     FSDEXCL    UF   E           K Disk
006100110725     FSDEXWK    UF A E           K Disk
006200110707     Fod170arcl1IF   E           K Disk    RENAME(ODRA:ODRAL1) Prefix(X)
0063001006290021 Fod170out  o  a e             DISK
006400110222     FOD170ARC  O  A E             Disk
006500100629     Fod170CSV  O  A E             DISK
006600110718     FOD170EXC  O  A E             DISK
0067000910230018 Frp170pe   O    F  132        PRINTER OFLIND(*INOE)
0068009702270020 D GAR             S             15    DIM(8)
0069000311100020 D GAR2            S             15    DIM(8)
0070009702270020 D MAR             S             15    DIM(8)
0071009912200020 D PAR             S             15    DIM(8)
0072009102120021 D YR              S              9    DIM(12) CTDATA PERRCD(1)
007300991220     D INDEX           S              4  0
007400991220     D PHN             S              3
007500020627     D rpgdate         S               d
007600020627     D rpgtime         S               t
007700030506     D NEWMDY2         S              8  0 INZ(*ZEROS)
007800030925     D NEWYMD2         S              8  0 INZ(*ZEROS)
007900030506     D USA_DATE        S               D   DATFMT(*USA)
0080000309120056 Dpaypct           s             13  4
0081000705030056 Dpaypcto          s             13  2
0082000705110056 Dinitinv          s              1
0083000905220056 Dsubsidymem       s              1
0084000705020056 Dpaypctreq        s                   like(cthresh)
0085000705020056 Dwkpct            s                   like(cthresh)
0086000705020056 Dholdpct          s                   like(cthresh)
0087001509230056 Dholdcarrier      s                   like(pcarr)
008800030916     DWORD1            C                   CONST('remains')
008900030916     DWORD4            C                   CONST('if payment has not')
0090000402110056 DNEWAA            S              3
0091000402260056 DHSTKEY           S             10
0092000402260056 DHNOTE            S             30
0093001107190056 DHNOTE2           S             30
009400040226     DNOTEA            C                   CONST('CLIENT NOTICE OF POTENTIAL W/-
009500040810     D                                     C')
009600040226     DNOTEM            C                   CONST('NOTICE OF W/C TO MBR/CFS/PHN')
0097000402260056 DFIRSTAAM         S              1
0098000402260056 DFIRSTAAA         S              1
0099000403090056 DWRTACCREC        S              1
010000091015     D wkasphfl        S                   LIKE(asphfl)
010100091015     D wkacnam2        S                   LIKE(acnam2)
010200091015     D wkaphone        S             13
010300091015     D wkfaccontac     S             50
010400091015     D wkfacphon       S             13
010500180417     D wkfacname       S                   like(subdsc)
010600091015     D bom             S              3    inz('BOM')
010700100630     D arp             S              3    inz('ARP')
010800100701     D sad             S              3    inz('SAD')
010900091015     D zero4           S              4s 0 inz
011000131010     D zero7           S              7s 0 inz
011100131010     D zero8           S              8s 0 inz
011200131010     D zero92          S              9s 2 inz
011300131010     D hstrtime        S              8t
0114001007010050 D BAL             S              9  2 DIM(12)
011500110717     D Exclude         S              1    Inz(*Off)
011600110707
011700110707     D wmonth1         S              2s 0 inz
011800110707     D wmonth2         S              2s 0 inz
011900110707     D ISO_DATE        S               D   DATFMT(*ISO)
012000131025     D thispgmname     S             10a   inz('OD170     ')
012100150716
012200150716     D wktrust         S              3s 0 inz
012300150716     D WKSUB           S              3s 0 inz
012400150716     D WKACC           S              4s 0 inz
012500150716     D WKACNAM         S             40
012600150716     D WKTDUE          S              9s 2 inz
012700150716     D WKCRED          S              9s 2 inz
012800150716     D WKPAY           S              9s 2 inz
012900150716     D WKBAL           S              9s 2 inz
013000150716     D WKCOVTDT        S              8s 0 inz
013100150716     D WKAEMP          S              7s 0 inz
013200150716     D WKSMAN          S              3
013300150716     D WKAA            S              3
013400150716     D WKBENEFL        S              1
013500110707
013600150716
0137001302180050 D                 DS
0138001302180051 D  ArpCmpDate             1      8  0 Inz
0139001302180052 D  YArp                   1      4  0 Inz
0140001302180053 D  MArp                   5      6  0 Inz
0141001302180054 D  DArp                   7      8  0 Inz
0142000201280050 D                 DS
0143000201280051 D  NEWMDY                 1      8  0
0144000201280052 D  M                      1      2  0
0145000201280053 D  D                      3      4  0
0146000201280054 D  Y                      5      8  0
0147000910150050 D                 DS
0148000910150051 D  ocphn1                 1     10
0149000910150052 D  ocphn1a                1      3
0150000910150053 D  ocphn1b                4      6
0151000910150054 D  ocphn1c                7     10
0152000910150050 D                 DS
0153000910150051 D  workaphone             1     10  0
0154000910150052 D  aarea                  1      3  0
0155000910150053 D  aphone                 4     10  0
0156009102120055 D                UDS
0157009102120056 D  LTRUST                 1      3
0158009503130056 D  LSORT                  4      4
0159001310140094 D  USERID                10     19
016000011011     D  MO##                  30     31S 0
016100011011     D  DD##                  32     33A
016200011011     D  YY##                  34     37A
016300020128     D  lmdy                  38     45  0
016400020128     D  lm                    38     39  0
016500030910     D  lmc                   38     39
016600110717     D  ly                    42     45  0
016700020128     D  lychar                42     45
016800020627     D  lsave                 46     46
016900091014     D  ldonly                47     47
017000100630     D  LLETC                 48     48
017100100630     D  LLETW                 49     49
017200100630     D  LLETF                 50     50
017300100630     D  PAYF                  51     51
017400100630     D  CONAME               201    240
017500020627
017600011025     D #ISO            S               D   DATFMT(*ISO)
017700011025     D #USA            S               D   DATFMT(*USA)
017800011025     D #PHNDATE        S              8S 0
0179009102120023 IACCMST    NS  01
0180009102120024 I*  ACCOUNT MASTER FILE
0181009102120025 I                                  1   10 0KEYACC
0182009102120026 I                                  1    3 0TRUST#
0183009805290026 I                                  4    6 0SUB#
0184009805290026 I                                  7   10 0ACC#
0185009102120027 I                                  1    6 0KEYSUB
0186009102120028 I                                 11   50  ACNAM1
0187000910150028 I                                 51   90  ACNAM2
0188009805290028 I                                 11   45  ACNM35
0189009702260045 I                                 91  120  AADDR1
0190009702260046 I                                121  150  AADDR2                  41
0191009702260047 I                                151  165  ACITY
0192009702260048 I                                166  167  ASTATE
0193009702260049 I                             P  168  172 0AZIP
0194000910150049 I                             P  173  174 0Aarea
0195000910150049 I                             P  175  178 0Aphone
0196009201170029 I                             P  210  213 0NOEMPL
019700070511     I                                222  229 0GBSBDT
0198000910150050 I                                247  247  asphfl
019900100701     I                             P  361  420 2BAL
0200000910150050 I                                425  454  ECNTAC
0201000306300034 I                                480  482  A_AACODE
0202009503100034 I                                483  485  SMANCD
020300011025     I                                513  520 0#ACVTDT
0204009812090031 I                                513  516 0COVTYY
0205009812090030 I                                517  518 0CM
0206009908090030 I                                519  520 0CD
020700030630     I                                513  520 0COVTDT
0208009812090030 I                                517  520 0COVTMD
0209001007010312 I                                517  518 0AM
0210009812090036 I                                545  552 0ENROLL
0211009102120039 ITRSMST    NS
0212009102120040 I*  TRUST MASTER FILE
0213009102120041 I                                255  255  TSCODE
0214000201310041 I                                256  256  trdltd
0215009805290042 IHIST      NS
0216009805290044 I                                 17   19  TRCODE
0217009806290045 I                             P   20   24 2TRAMT
0218000004280044 I                                 97   97  excinv
0219000004280044 I                                 98  101  TRNSRC
0220000309250044 I                                129  136 0TRDATE
0221000004270044 I                                137  144 0hinvdt
0222000309250044 I                                153  160 0HISEFF
0223000309250044 I                                153  158 0HISEFFym
0224009702200040 IMEMAC#    NS
0225009702200041 I*  MEMBER FILE
0226009702200042 I                                  1    9 0SSNO
0227009702200043 I                                 10   27  LNAME
0228009702200044 I                                 28   39  FNAME
0229009702200045 I                                 40   40  MI
0230009702200046 I                                 41   70  ADDR1
0231009702200047 I                                 71  100  ADDR2                   41
0232009702200048 I                                101  115  CITY
0233009702200049 I                                116  117  STATE
0234009702200050 I                             P  118  122 0ZIP
0235000309150053 I                                561  568 0mbenrl
0236009812090053 I                                577  584 0TERMDT
0237000905220053 I                                625  632 0cexpdt
0238009702270042 IMCOV      NS
0239009812030079 I                                 12   14 0MCTRST
0240009812030079 I                                 15   17 0MCSUB
0241009812090079 I                                 18   21  MCPLAN
0242009812030079 I                                 12   26  RATKEY
0243000309150045 I                                 65   72 0enrldt
0244000309150045 I                                 73   80 0CANDT
0245009102120059 I/EJECT
0246009503130085 C*
0247009503130086 C* FILL MANUAL CONTROL BREAK FIELDS
0248009503130087 C*
024900130118     C     *DATE         Mult      10000.0001    Today             8 0
025000100709     C                   Move      Today         MMDD              4 0
025100100709     C                   Movel     MMDD          CurrentMonth      2 0
025200150721
025300100706     C                   If        ASPHFL  =     PAYF
025400100706     C                               OR
025500100706     C                             (PAYF    =    'A'   And
025600100706     C                             (ASPHFL  =     'F'   Or
025700100706     C                             ASPHFL   =     'D'   Or
025800100706     C                             ASPHFL   =     'P'))
025900100706      *
026000100706     C                   Else
026100100630     C                   goto      #end
026200100630     C                   End
0263009102120085 C*
0264000201310086 C* SKIP non billable trusts (dltcd = C) and deleted trusts
0265009102120087 C*
0266009806020088 C     TRUST#        CHAIN     TRSMST                             21
0267009806020096 C     *IN21         IFEQ      *ON
026800980602     C     FIRSTE        IFEQ      ' '
026900980602     C                   EXCEPT    HEADE
027000980602     C                   MOVE      'N'           FIRSTE            1
027100980602     C                   END
027200980603     C                   EXCEPT    LINEE
027300000201     C   OE              EXCEPT    HEADE
0274009806020096 C                   GOTO      #END
027500980602     C                   END
027600980602     C*
0277000201310089 C                   if        tscode = ' ' or trdltd = 'C' or
027800091014     c                             trdltd = 'D'
0279009411160090 C                   GOTO      #END
0280009411160091 C                   END
028100091014
0282000910140092  * select dental only or all other
028300180111     c****               if        (ldonly = 'D' and tscode <> 'N') or
028400180111     c****                         (ldonly <> 'D' and tscode = 'N')
0285001801110090 C****               GOTO      #END
0286001801110091 C****               END
028700091014
028800180111     c                   if        (ldonly = 'D' and tscode = 'N') or
028900200120     c                             (ldonly = 'A' and tscode = 'M') or
029000200120     c                             (ldonly = 'C' and tscode = 'D')
0291001801110090 C                   GOTO      #stay
029200180111     c                   else
0293001801110090 C                   GOTO      #END
0294001801110091 C                   endif
029500180111
029600180111     c     #stay         tag
0297009908090107 C*
0298000201280109 C* "NEWMDY" will now be filled with the date entered on the screen.
0299000201280109 C*
0300000201280113 C                   MOVE      lmdy          newmdy
030100030506     C                   MOVEL     NEWMDY        USA_DATE
030200100915     C                   ADDDUR    1:*M          USA_DATE
030300030506     C                   MOVEL     USA_DATE      NEWMDY2
0304009908090109 C*
0305009102120116 C* CHECK ACCOUNT TO SEE IF THEY HAVE BEEN ENROLLED LONG ENOUGH
0306009102120117 C* IF NOT - SKIP
0307009102120118 C*
0308009812090111 C*
030900981209     C                   MOVE      NEWMDY        @DATIN
031000981209     C                   EXSR      #DATMY
031100981209     C                   MOVE      @DATOU        NEWYMD            8 0
0312009812090111 C*
0313009812090122 C     NEWYMD        IFLT      ENROLL
0314009102120123 C                   GOTO      #END
0315009102120124 C                   END
0316000110250121 C*
031700011025     C                   MOVE      NEWYMD        #ISO
031800100915     C                   ADDDUR    1:*M          #ISO
031900011025     C                   MOVE      #ISO          #USA
032000011025     C                   MOVE      #USA          #PHNDATE
032100030506     C                   MOVE      #ISO          NEWYMD2
032200100915     C     LMDY          Mult      10000.0001    NEWYMD2
0323000309120151
0324001509230142  * find out if acct has dbe business and carrier code for highest
0325001509230142  * threshold % that will be used in getpaid
032600070417     c                   exsr      #fnddbe
032700070417
0328001509230142  * if no active plans were found to use the carrier for the payment
0329001509230142  * percent required, use special override code of <a> for 100%
033000150923     c                   if        holdcarrier = *blanks
033100150923     c                   eval      holdcarrier = '<a>'
033200150923     C                   end
033300150923
033400150923      * 5/20/15 - convert to use GETPAID instead of internal payment logic.
033500150923      *           It will only be used for gathering the payments, credits
033600150923      *           debits and invoice ending balance...the yes/no decision
033700150923      *           will not be used here since admin wants to use
033800150923      *           different fields in their decision
033900150923     c                   exsr      #getpaid
034000150923
034100150923      * any error from payment pgm - skip remainning calcs
034200150923     c                   if        parmerr <> *blanks
034300150923     c                   goto      #end
034400150923     c                   end
034500150923
0346001509230125 C* credit ending balance...nothing due
0347001509230096 C                   if        totinv <= 0
034800150923     c                   goto      #end
034900150923     C                   end
035000150923
035100150923      * balance = inv + payments only (no credits)
035200150923     C     TOTINV        ADD       MONPAY        OUTBAL            9 2
035300070417
035400131112     c                   z-add     monpay        paycrd            9 2
035500070612
035600131112     c                   clear                   abspay            9 2
035700070417     c                   eval      abspay = %abs(paycrd)
035800030912     c     abspay        div       totinv        paypct
035900030912     c                   mult      100           paypct
036000070503     c                   z-add     paypct        paypcto
036100070615
036200070615      * if paid enough, not subject to cancellation but we still want to
036300070615      * show them on the spreadsheet if they paid < 100%
036400070615
0365000309120152 C                   if        paypct >= paypctreq
036600070618     c                   move      'NO '         pendcancel        3
036700070615     c                   else
036800070618     c                   move      'YES'         pendcancel
036900030912     c                   end
037000030912
0371000706150158 C*
0372001507160158 C* Senior dental letters (sort = 4)
0373000706150158 C*
037400100629     c                   if        lsort =  '4'
037500070615     c                   move      trust#        wktrust
037600070615     c                   move      sub#          wksub
037700070615     c                   move      acc#          wkacc
037800070615     c                   move      acnam1        wkacnam
037900150721
038000100701     C                   XFOOT     BAL           TOTBAL            9 2
038100150721
038200150721      *
038300150721      * 7/21/15 - use outstanding balance amount from payment check for the
038400150721      *           letters
038500150721     C                   Eval      O7TDUE = outbal
038600150721      *
038700150721
0388001007011075 C     AM            SUB       1             AX                2 0
0389001007011076 C     AX            IFEQ      0
0390001007011077 C                   Z-ADD     12            AX
0391001007011078 C                   END
0392001007011079 C     TOTBAL        SUB       BAL(AM)       APRBAL            9 2
0393001007011080 C     APRBAL        SUB       BAL(AX)       APRBA2            9 2
0394001007021081 C                   Z-ADD     BAL(AX)       APRBA1            9 2
039500100702      *
039600100707      *--- Prior Month(s) Due: per Shelly =  (Previous Bal)
039700100707     C                   Eval      O7PBAL   =    APRBA2
039800100702      *---
039900100707      *--- Month Past Due: per Shelly = IQ101 Prior Month Balance.
0400001007071081 C                   Z-ADD     BAL(AX)       O7CDUE
040100100702      *---
040200100706      *
040300100915      * Only generate letters if there is a total balance due.
040400100915     C                   If        O7TDUE   <=    1
040500100706     C                   GOTO      #END
040600100706     C                   End
040700110719      *---
040800110719      * If account is in exclusion file for delinquent month/year, skip.
040900110719      *---
041000110719     C                   Eval      Exclude  =   *Off
041100110719     C     ExcKey        Chain     SDEXCL
041200110719     C                   If        %Found(SDEXCL)
041300110719     C                   Eval      Exclude  =   *On
041400110719     C                   GOTO      #END
041500110719     C                   End
0416001007011083 C*
041700091015
041800091015      * senior dental fields
041900091015     c                   clear                   wkacnam2
042000091015     c                   clear                   wkaphone
042100091015     c                   clear                   wkasphfl
042200091015     c                   move      acnam2        wkacnam2
042300091015     c                   eval      wkaphone = %editw(workaphone:'0   -   -    ')
042400091015     c                   move      asphfl        wkasphfl
042500091019      * get facility contact if the acct is a facility acct and the report
042600091019      * is run for senior dental
042700091015     c                   clear                   wkfaccontac
042800091015     c                   clear                   wkfacphon
042900091019     c                   clear                   wkfacname
043000100719     C                   Clear                   O7BOM
043100100715     c**************     if        ldonly = 'D' and asphfl = 'F'
043200180111     c****               if        ldonly = 'D' and (asphfl = 'F' or
043300200120     c                   if        (ldonly = 'D' or ldonly = 'A' or ldonly =
043400200120     c                             'C') and (asphfl = 'F' or asphfl = 'D' or
043500180111     C                              asphfl = 'P')
043600091019      * get facility name
043700091019     c     subkey        chain     submst
043800091019     c                   if        %found(submst)
043900180417     c                   movel     subdsc        wkfacname
044000180417     c                   Eval      O7NHNM  =  %Trim(SUBDSC)
044100091019     c                   end
044200091019
044300091015     c     odkey         setll     odcntcp
044400091015     c                   dou       %eof(odcntcp)
044500091015     c     odkey         reade     odcntcp
044600100719     c********           if        not %eof(odcntcp) and newymd >= oceff and
044700100719     c********                     (octrm = 0 or octrm > newymd)
044800100719     c                   if        not %eof(odcntcp) and Today  >= oceff and
044900100719     c                             (octrm = 0 or octrm > Today)
045000091015     c     ocfnam        cat       oclnam:1      wkfaccontac
045100100630szz  c                   Eval      O7BOM   =  wkfaccontac
045200100719     c                   Eval      O7NHA1  =  %Trim(OCADD1)
045300100719     c                   Eval      O7NHA2  =  %Trim(OCADD2)
045400100719     c                   Eval      O7NHCZ  =  %Trim(OCCITY) + ', ' +
045500100719     C                                        %Trim(OCST)   + '  ' +
045600100719     C                                        %TRim(OCZIP)
045700091015     c                   eval      wkfacphon = ocphn1a + '-' + ocphn1b + '-' +
045800091015     c                                         ocphn1c
045900091015     c                   cat       wkfacphon:1   wkfaccontac
046000091015     c                   leave
046100091015     c                   end
046200091015     c                   enddo
046300091015     c                   end
046400091015
046500070615     c                   move      totinv        wktdue
046600070615     c                   move      credit        wkcred
046700070615     c                   move      monpay        wkpay
046800070615     c                   move      outbal        wkbal
046900070615     c                   movel     covtmd        wkcovtdt
047000070615     c                   move      covtyy        wkcovtdt
047100070615     c                   move      noempl        wkaemp
047200070615     c                   move      smancd        wksman
047300070615     c                   move      A_aacode      wkaa
047400150716
047500070615      * write spreadsheet if paypct < 100%
047600070615     c                   if        paypct < 100
047700070615     C                   Exsr      WriteSpread
047800070615     c                   end
047900070615     c                   end
048000150716
048100100630      *Load the data to the file that will be used in RPG_WORD
048200100630     c                   Eval      O7TRST  =  wktrust
048300100630     c                   Eval      O7SUB#  =  wksub
048400100630     c                   Eval      O7ACCT  =  wkacc
048500100706     c                   Eval      O7PYFL  =  ASPHFL
048600100630     C                   Select
048700100630     C                   When      LLETC   =  'Y'
048800100630     c                   Eval      O7LTYP  =  'C'
048900100630     C                   When      LLETW   =  'Y'
049000100630     c                   Eval      O7LTYP  =  'W'
049100100630     C                   When      LLETF   =  'Y'
049200100630     c                   Eval      O7LTYP  =  'F'
049300100630     C                   EndSl
049400100707      * For Facility
049500100914     C***** Per Angie    If        O7PYFL  =  'F'
049600100707     C                   Eval      HNOTE   =     ' DUE:  ' +
049700100707     C                                           %Editc(O7TDUE:'P')
049800100914     C*****              End
049900100707      * For Direct & Private
050000100914     C**** Per Angie     If        O7PYFL  =  'D'  Or  O7PYFL = 'P'
050100100914     C**** had us com-outEval      HNOTE   =     ' DUE:  ' +
050200100914     C**** to all use                            %Editc(OUTBAL:'P')
050300100914     C**** O7TDUE        End
050400110707      *
050500150714      * courtesy letter
050600100702     C                   If        O7LTYP  =     'C'
050700100702     C                   Movel     'U68'         ODTRCD            3
050800100702     C                   End
050900110707      *
051000150714      * withhold care letter
051100100702     C                   If        O7LTYP  =     'W'
051200100702     C                   Eval      ODTRCD  =     'U69'
051300100702     C                   End
051400150714
051500100706     C                   Move      wktrust       wktrsta           3
051600100706     C                   Move      wksub         wksub#a           3
051700100706     C                   Move      wkacc         wkaccta           4
051800100706     C                   Move      *blanks       wktsaa           10
051900100706     C                   Eval      wktsaa  =  wktrsta + wksub#a + wkaccta
052000100706     C                   Move      wktsaa        O7TSA
052100150716
052200150716      * write history record
052300100706     C                   Movel     KEYACC        HSTKEY
052400131010     c                   eval      hstrtime = %time
052500130118     C                   EXCEPT    ADDHIS
052600100709      *
052700100709      * Get Responsible Party aka Family Representative aka Authorized Rep
052800100709      *
052900130218      * Per Angie, use heading date to compare if ARP contact is active
053000130218     C                   Move      MO##          MArp
053100130218     C                   Move      DD##          DArp
053200130218     C                   Move      YY##          YArp
053300150904
053400150904     c                   clear                   o7rpnm
053500150904     c                   clear                   o7add1
053600150904     c                   clear                   o7add2
053700150904     c                   clear                   o7csz
053800150904
053900100709     C     odarpkey      Setll     ODCNTCP
054000100709     c                   Dou       %eof(odcntcp)
054100100709     C     odarpkey      Reade     ODCNTCP
054200100709     C                   If        Not %Eof(ODCNTCP)   And
054300130218     c                                 ArpCmpDate >= oceff and
054400130218     c                             (octrm = 0 or octrm > ArpCmpDate)
054500100630     c                   Eval      O7RPNM  =  %Trim(OCFNAM) + ' ' +
054600100630     C                                        %Trim(OCLNAM)
054700100630     c                   Eval      O7ADD1  =  %Trim(OCADD1)
054800100630     c                   Eval      O7ADD2  =  %Trim(OCADD2)
054900100630     c                   Eval      O7CSZ   =  %Trim(OCCITY) + ', ' +
055000100630     C                                        %Trim(OCST)   + '  ' +
055100100630     C                                        %TRim(OCZIP)
055200100709     C                   Leave
055300100630     C                   End
055400100709     C                   EndDo
055500150904
055600150904      * if no RP found, use act address per Shelly 9/4/15
055700150904     c                   if        o7rpnm = *blanks
055800150904     C                   Eval      O7RPNM = 'Attn: Responsible Party'
055900150904     c                   Eval      O7ADD1  =  %Trim(aaddr1)
056000150904     c                   Eval      O7ADD2  =  %Trim(aaddr2)
056100150904     C                   clear                   ZIPout           10
056200150904     C                   MOVEL     azip          ZIP5              5
056300150904     C                   MOVE      azip          ZIP4              4
056400150904     C                   MOVEL     zip5          ZIPout
056500150904     C                   IF        ZIP4 <> '0000'
056600150904     c                   cat       '-':0         zipout
056700150904     c                   cat       zip4:0        zipout
056800150904     C                   END
056900150904     c                   Eval      O7CSZ   =  %Trim(acity) + ', ' +
057000150904     C                                        %Trim(astate)   + '  ' +
057100150904     C                                        %TRim(zipout)
057200150904     c                   end
057300150904
057400100702     C                   Eval      noacct  =  *Zeros
057500100709      *
057600100709      * Get Nursing Home Administrator
057700100709      *
057800100709     C     odsadkey      Setll     ODCNTCP
057900100709     c                   Dou       %eof(odcntcp)
058000100709     C     odsadkey      Reade     ODCNTCP
058100100709     C                   If        Not %Eof(ODCNTCP)   And
058200130218     c                                 ArpCmpDate >= oceff and
058300130218     c                             (octrm = 0 or octrm > ArpCmpDate)
058400100701     c                   Eval      O7NHAD  =  %Trim(OCFNAM) + ' ' +
058500100701     C                                        %Trim(OCLNAM)
058600100719     c                   Eval      O7NHA1  =  %Trim(OCADD1)
058700100719     c                   Eval      O7NHA2  =  %Trim(OCADD2)
058800100719     c                   Eval      O7NHCZ  =  %Trim(OCCITY) + ', ' +
058900100719     C                                        %Trim(OCST)   + '  ' +
059000100719     C                                        %TRim(OCZIP)
059100100719     C                   Eval      O7TITL  =  %Trim(OCTITL)
059200100709     C                   Leave
059300100719      * No SAD on file
059400100719     C                   Else
059500100719     C                   Eval      O7NHAD  =  'Attn: Nursing Home Administrator'
059600100719     C     SubKey        Chain     ODFACP
059700100719     C                   If        %Found(ODFACP)
059800100719     c                   Eval      O7NHA1  =  %Trim(S2ADD1)
059900100719     c                   Eval      O7NHA2  =  %Trim(S2ADD2)
060000100719     c                   Eval      O7NHCZ  =  %Trim(S2CITY) + ', ' +
060100100719     C                                        %Trim(S2ST)   + '  ' +
060200100719     C                                        %TRim(S2ZIP)
060300100719     C                   End
060400100701     C                   End
060500100709     C                   EndDo
060600100709      *
060700100630     c                   Eval      O7RENM  =  %Trim(ACNAM1)
060800100630     c                   Eval      O7TSA   =  KEYACC
060900100701     C     INEXKY        Chain     MCOVX
061000100701     C                   If        %Found(MCOVX)
061100100701     C                   Eval      O7SSNO  =  XMCSSNO
061200100701     C                   Else
061300100701     C                   Clear                   O7SSNO
061400100701     C                   End
061500100701      * format letter date
061600100701     C                   Select
061700100701     C                   When      MO##       =  01
061800100701     C                   Eval      O7DATE     = 'January ' + DD## + ', ' + YY##
061900100707     C                   Eval      O7PDMO     = %Trim('January')
062000100701     C                   When      MO##       =  02
062100100701     C                   Eval      O7DATE     = 'February ' + DD## + ', ' + YY##
062200100707     C                   Eval      O7PDMO     = %Trim('February')
062300100701     C                   When      MO##       =  03
062400100701     C                   Eval      O7DATE     = 'March ' + DD## + ', ' + YY##
062500100707     C                   Eval      O7PDMO     = %Trim('March')
062600100701     C                   When      MO##       =  04
062700100701     C                   Eval      O7DATE     = 'April ' + DD## + ', ' + YY##
062800100707     C                   Eval      O7PDMO     = %Trim('April')
062900100701     C                   When      MO##       =  05
063000100701     C                   Eval      O7DATE     = 'May '   + DD## + ', ' + YY##
063100100707     C                   Eval      O7PDMO     = %Trim('May')
063200100701     C                   When      MO##       =  06
063300100701     C                   Eval      O7DATE     = 'June '  + DD## + ', ' + YY##
063400100707     C                   Eval      O7PDMO     = %Trim('June')
063500100701     C                   When      MO##       =  07
063600100701     C                   Eval      O7DATE     = 'July '  + DD## + ', ' + YY##
063700100707     C                   Eval      O7PDMO     = %Trim('July')
063800100701     C                   When      MO##       =  08
063900100701     C                   Eval      O7DATE     = 'August ' + DD## + ', ' + YY##
064000100707     C                   Eval      O7PDMO     = %Trim('August')
064100100701     C                   When      MO##       =  09
064200100701     C                   Eval      O7DATE     = 'September ' + DD## + ', ' +
064300100701     C                                                         YY##
064400100707     C                   Eval      O7PDMO     = %Trim('September')
064500100701     C                   When      MO##       =  10
064600100701     C                   Eval      O7DATE     = 'October ' + DD## + ', ' + YY##
064700100707     C                   Eval      O7PDMO     = %Trim('October')
064800100701     C                   When      MO##       =  11
064900100701     C                   Eval      O7DATE     = 'November ' + DD## + ', ' + YY##
065000100707     C                   Eval      O7PDMO     = %Trim('November')
065100100701     C                   When      MO##       =  12
065200100701     C                   Eval      O7DATE     = 'December ' + DD## + ', ' + YY##
065300100707     C                   Eval      O7PDMO     = %Trim('December')
065400100701     C                   Endsl
065500100701      * format Month/Year
065600100630     C                   Select
065700100630     C                   When      %trim(lmc) = '01'
065800100706     C                   Eval      O7MMYY     = 'January' + ' ' + lychar
065900100707     C                   Eval      O7PDMO     = %Trim('January')
066000100630     C                   When      %trim(lmc) = '02'
066100100706     C                   Eval      O7MMYY     = 'February' + ' ' + lychar
066200100707     C                   Eval      O7PDMO     = %Trim('February')
066300100630     C                   When      %trim(lmc) = '03'
066400100706     C                   Eval      O7MMYY     = 'March' + ' ' + lychar
066500100707     C                   Eval      O7PDMO     = %Trim('March')
066600100630     C                   When      %trim(lmc) = '04'
066700100706     C                   Eval      O7MMYY     = 'April' + ' ' + lychar
066800100707     C                   Eval      O7PDMO     = %Trim('April')
066900100630     C                   When      %trim(lmc) = '05'
067000100706     C                   Eval      O7MMYY     = 'May'   + ' ' + lychar
067100100707     C                   Eval      O7PDMO     = %Trim('May')
067200100630     C                   When      %trim(lmc) = '06'
067300100706     C                   Eval      O7MMYY     = 'June'  + ' ' + lychar
067400100707     C                   Eval      O7PDMO     = %Trim('June')
067500100630     C                   When      %trim(lmc) = '07'
067600100706     C                   Eval      O7MMYY     = 'July'  + ' ' + lychar
067700100707     C                   Eval      O7PDMO     = %Trim('July')
067800100630     C                   When      %trim(lmc) = '08'
067900100706     C                   Eval      O7MMYY     = 'August' + ' ' + lychar
068000100707     C                   Eval      O7PDMO     = %Trim('August')
068100100630     C                   When      %trim(lmc) = '09'
068200100706     C                   Eval      O7MMYY     = 'September' + ' ' + lychar
068300100707     C                   Eval      O7PDMO     = %Trim('September')
068400100630     C                   When      %trim(lmc) = '10'
068500100706     C                   Eval      O7MMYY     = 'October' + ' ' + lychar
068600100707     C                   Eval      O7PDMO     = %Trim('October')
068700100630     C                   When      %trim(lmc) = '11'
068800100706     C                   Eval      O7MMYY     = 'November' + ' ' + lychar
068900100707     C                   Eval      O7PDMO     = %Trim('November')
069000100630     C                   When      %trim(lmc) = '12'
069100100706     C                   Eval      O7MMYY     = 'December' + ' ' + lychar
069200100707     C                   Eval      O7PDMO     = %Trim('December')
069300100630     C                   Endsl
069400100709      * format Current Month
069500100709     C                   Select
069600100709     C                   When      CurrentMonth =  01
069700100709     C                   Eval      O7CUMO     = 'January'
069800100709     C                   When      CurrentMonth =  02
069900100709     C                   Eval      O7CUMO     = 'February'
070000100709     C                   When      CurrentMonth =  03
070100100709     C                   Eval      O7CUMO     = 'March'
070200100709     C                   When      CurrentMonth =  04
070300100709     C                   Eval      O7CUMO     = 'April'
070400100709     C                   When      CurrentMonth =  05
070500100709     C                   Eval      O7CUMO     = 'May'
070600100709     C                   When      CurrentMonth =  06
070700100709     C                   Eval      O7CUMO     = 'June'
070800100709     C                   When      CurrentMonth =  07
070900100709     C                   Eval      O7CUMO     = 'July'
071000100709     C                   When      CurrentMonth =  08
071100100709     C                   Eval      O7CUMO     = 'August'
071200100709     C                   When      CurrentMonth =  09
071300100709     C                   Eval      O7CUMO     = 'September'
071400100709     C                   When      CurrentMonth =  10
071500100709     C                   Eval      O7CUMO     = 'October'
071600100709     C                   When      CurrentMonth =  11
071700100709     C                   Eval      O7CUMO     = 'November'
071800100709     C                   When      CurrentMonth =  12
071900100709     C                   Eval      O7CUMO     = 'December'
072000100709     C                   Endsl
072100150716      *
072200150716      * write to OD170OUT workfile that will be used to print letter
072300100629     C                   Write     ODR
072400150716
072500150716      * write to letter archive file
072600110222     C                   Exsr      WriteArchive
072700150716
072800070615      * skip all remaining calcs if this acct is not pending cancel
072900070618     c                   if        pendcancel = 'NO '
073000070615     c                   goto      #end
073100070615     c                   end
0732009102120164 C*
0733001505220164 C* Withhold care code not needed in this program for senior dental
0734001507210164 C* so it has been removed from here
073500150522
073600150522
073700150522
073800150522
073900970219     C*
0740000311180165 C     #END          TAG
074100110718     C                   If        Exclude    =  *On
074200110718     C                   Move      wktrust       wktrsta
074300110718     C                   Move      wksub         wksub#a
074400110718     C                   Move      wkacc         wkaccta
074500110718     C                   Move      *blanks       wktsaa
074600110718     C                   Eval      wktsaa     =  wktrsta + wksub#a + wkaccta
074700110718     C                   Move      wktsaa        O7TSA
074800110718     C                   Movel     KEYACC        HSTKEY
074900110719     C                   Eval      HNOTE      =  SLNOTE
075000110719     C                   Eval      HNOTE2  =     ' DUE:  ' +
075100110719     C                                           %Editc(O7TDUE:'P')
075200110718     C                   Select
075300110718     C                   When      O7LTYP     =   'C'
075400110718     C                   Eval      ODTRCD     =   'U72'
075500110718     C                   When      O7LTYP     =   'W'
075600110718     C                   Eval      ODTRCD     =   'U73'
075700110726     C                   When      LLETC      =   'Y'
075800110726     C                   Eval      ODTRCD     =   'U72'
075900110726     C                   When      LLETW      =   'Y'
076000110726     C                   Eval      ODTRCD     =   'U73'
076100110718     C                   EndSl
076200110725     C                   Exsr      WriteExcl
076300131010     c                   eval      hstrtime = %time
076400120815     C*****************  EXCEPT    ADDHIS
076500130118     C                   EXCEPT    ADDHIS
076600110824     C                   Clear                   HNOTE2
076700110725      *---
076800110725      * Delete Exclusion Month/Year for account from Exclusion file.
076900110725      *---
077000110725      * Only delete from exclusion file if Withhold Care has run.
077100110725     C                   If        LLETW    =   'Y'
077200110720     C     ExcKey        Chain     SDEXCL
077300110720     C                   If        %Found(SDEXCL)   And
077400110720     C                             Exclude  =   *On
077500110717     C                   Delete    SDEXCLR
077600110725     C                   End
077700110720     C                   End
077800110717     C                   End
077900110720     C                   Eval      Exclude  =   *Off
078000970228     C*
078100150721     C* write exclusion spreadsheet
078200110725     CLR                 Exsr      WriteExSp
078300150923
0784001509230103 C*******************************************************************
0785001509230104 C* call getpaid to get payment status for this acct/effdt/carrier *
0786001509230103 C*******************************************************************
078700150923     c     #getpaid      begsr
078800150923
0789001509230128 C                   clear                   MONPAY           10 2
0790001509230128 C                   clear                   CREDIT           10 2
0791001509230128 C                   clear                   debit            10 2
0792001509230128 C                   clear                   totinv            9 2
0793001509230128 C                   clear                   paymnt            1
079400150923
079500150923     c     grplist       plist
079600150923     c                   parm                    parmkey          10
079700160418     c                   parm                    parmremymd        8
079800150923     c                   parm                    parmeffymd        8
079900150923     c                   parm                    parmcar           3
080000150923     c                   parm                    parmupdate        1
080100150923     c                   parm                    parmpaid          1
080200150923     c                   parm                    parmerr          35
080300150923     c                   parm                    parminveb        10 2
080400150923     c                   parm                    parmpayments     10 2
080500150923     c                   parm                    parmcredits      10 2
080600150923     c                   parm                    parmdebits       10 2
080700150923
080800150923     c                   movel     keyacc        parmkey
080900160418     c                   move      *blanks       parmremymd
081000150923     c                   move      newymd        parmeffymd
081100150923     c                   move      holdcarrier   parmcar
081200150923     c                   move      'N'           parmupdate
081300150923     c                   clear                   parmpaid
081400150923     c                   clear                   parmerr
081500150923     c                   clear                   parminveb
081600150923     c                   clear                   parmpayments
081700150923     c                   clear                   parmcredits
081800150923     c                   clear                   parmdebits
081900150923
082000150923     c                   call      'GETPAIDCL'   grplist
082100150923
082200150923      * if any error returned, print it
0823001509230361 C                   if        parmerr <> *blanks
082400150923     C                   if        firste = ' '
082500150923     C                   EXCEPT    HEADE
082600150923     C                   MOVE      'N'           FIRSTE
082700150923     C                   END
082800150923     C   oe              EXCEPT    heade
082900150923      * set on 63 to show the error
083000150923     c                   eval      *in63 = *on
083100150923     C                   EXCEPT    linee
083200150923     c                   eval      *in63 = *off
083300150923     c                   leavesr
083400150923     C                   END
083500150923
083600150923      * the actual Y/N payment decision returned will not be used in this
083700150923      * program since Admin wants to make the decision based on other values
083800150923      * but it will be stored in the "paymnt" field in case it is needed
083900150923      * later
084000150923     c                   move      parmpaid      paymnt
084100150923
084200150923      * move values from get paid to those needed by this program
084300150923     c                   z-add     parminveb     totinv
0844001509230137 c                   z-add     parmcredits   credit
0845001509230137 c                   z-add     parmdebits    debit
0846001509230137 c                   z-add     parmpayments  monpay
084700150923
084800150923     c                   endsr
084900150923
085000150721
085100030630     C/EJECT
085200110718     C*************************************************************
085300110718     C*                                                           *
085400110718     C* Write to CSV file for Excel Spreadsheet Letter Exclusions *
085500110718     C*                                                           *
085600110718     C*************************************************************
085700110718     C     WriteExSp     BEGSR
085800110804
085900110804     C                   If        LTRUST = 'ALL'
086000110804     C     *Loval        Setll     SDEXWK
086100110804     C                   Read      SDEXWK
086200110804     C                   Else
086300110804     C     TRUST#        Setll     SDEXWK
086400110804     C     TRUST#        Reade     SDEXWK
086500110804     C                   End
086600110804
086700110725     C                   Dou       %Eof(SDEXWK)
086800110725     C                   If        Not %Eof(SDEXWK)
086900110718     C                   Eval      EXRECORD  =   '"' +
087000110725     C                              %Trim(%Editc(WLTRST:'P'))   + '","' +
087100110725     C                              %Trim(%Editc(WLSUB#:'P'))   + '","' +
087200110725     C                              %Trim(%Editc(WLACCT:'P'))   + '","' +
087300110725     C                              %Trim(WLNAM1)               + '","' +
087400110725     C                              %Trim(WLNAM2)               + '","' +
087500110725     C                              %Trim(WLSPHFL)              + '","' +
087600110725     C                              %Trim(%Editc(WLDEMM:'P'))   + '","' +
087700110725     C                              %Trim(%Editc(WLDEYY:'P'))   + '","' +
087800110725     C                              %Trim(WLNOTE)               +   '",'
087900110725     C                   End
088000110718     C                   Write     OD170EXR
088100110804
088200110804     C                   If        LTRUST = 'ALL'
088300110804     C                   Read      SDEXWK
088400110804     C                   Else
088500110804     C     TRUST#        Reade     SDEXWK
088600110804     C                   End
088700110804
088800110725     C                   EndDo
088900110718
089000110718     C                   ENDSR
0891000306300164 C*************************************************************
089200110725     C     WriteExcl     BEGSR
089300110725     C                   Eval      WLTRST    =   SLTRST
089400110725     C                   Eval      WLSUB#    =   SLSUB#
089500110725     C                   Eval      WLACCT    =   SLACCT
089600110725     C                   Eval      WLTSA     =   SLTSA
089700110725     C                   Eval      WLDEYY    =   SLDEYY
089800110725     C                   Eval      WLDEMM    =   SLDEMM
089900110725     C                   Eval      WLNAM1    =   ACNAM1
090000110725     C                   Eval      WLNAM2    =   ACNAM2
090100110725     C                   Eval      WLSPHFL   =   ASPHFL
090200110725     C                   Eval      WLNOTE    =   SLNOTE
090300110725
090400110804     C     ExcKey        Chain     SDEXWK
090500110804     C                   If        %Found(SDEXWK)
090600110726     C                   Update    SDEXWKR
090700110726     C                   Else
090800110725     C                   Write     SDEXWKR
090900110726     C                   End
091000110725
091100110725     C                   ENDSR
0912001107250164 C*************************************************************
0913000306300164 C*                                                           *
0914000306300164 C* Write to CSV file for Excel Spreadsheet                   *
0915000306300164 C*                                                           *
0916000306300164 C*************************************************************
091700030630     C     WriteSpread   BEGSR
091800070502
091900030630     C                   Move      'N'           WKPRINV           1
092000150923
092100150923      * get invoice transaction date
092200150923     C                   clear                   WKDTINV           8 0
0923001509230088 C     INKEY         CHAIN     INVSUM
092400150923     c                   if        %found(invsum)
092500150923     C     INVDTE        Mult      10000.0001    WKDTINV
092600150923     c                   end
092700150923
092800030630     C     SMANCD        CHAIN     SMAN
092900030630     C                   If        %Found(SMAN)
093000030630     C                   Eval      WKSLNM   =    SLNAME
093100030630     C                   Eval      WKSFNM   =    SFNAME
093200030630     C                   Else
093300030630     C                   Movel     *Blanks       WKSLNM           18
093400030630     C                   Eval      WKSLNM   =    'Not on File '
093500030630     C                   Movel     *Blanks       WKSFNM           12
093600030630     C                   End
093700030630     C     A_AACODE      CHAIN     AACODR
093800030630     C                   If        %Found(AACODE)
093900030630     C                   Eval      WKALNM   =    ALNAM
094000030630     C                   Eval      WKAFNM   =    AFNAM
094100150522     c**                 clear                   aaname
094200150522     C**                 movel     afnam         aaname
094300150522     c**                 cat       alnam:1       aaname
094400030630     C                   Else
094500030630     C                   Movel     *Blanks       WKALNM           20
094600030630     C                   Eval      WKALNM   =    'Not on File      '
094700030630     C                   Movel     *Blanks       WKAFNM           20
094800030630     C                   End
094900030804     C     LMDY          Mult      10000.0001    KeyDate           8 0
095000030630     C     HisKey        CHAIN     HISTL4
095100030630     C                   If        %Found(HISTL4)
095200030630     C                   Eval      WKPRINV  =    'Y'
095300030630     C                   Else
095400030630     C                   Eval      WKPRINV  =    'N'
095500030630     C                   End
095600030730     C                   Movel     KEYACC        Alpha_KeyAcc     10
095700030805     C     HisKey5p      SETLL     HISTL5
095800030805     C     HisKey5       READE     HISTL5
095900030805     C                   If        %Eof(HISTL5)
096000030703     C                   Eval      L5TRAMT  =    *Zeros
096100030703     C                   End
096200070511
096300070511      * initial invoice?
096400070511     c                   clear                   initinv
096500070511     c                   if        gbsbdt = newymd
096600070511     c                   eval      initinv = 'Y'
096700070511     c                   end
096800070511
096900091020      * Senior dental version
097000091020     C                   Eval      WKRECORD  =   '"' +
097100091020     C                              %Trim(wkasphfl)             + '","' +
097200091020     C                              %Trim(%Editc(WKTRUST:'P'))  + '","' +
097300091020     C                              %Trim(%Editc(WKSUB:'P'))    + '","' +
097400091020     C                              %Trim(%Editc(WKACC:'P'))    + '","' +
097500091020     C                                          %Trim(WKACNAM)  + '","' +
097600091020     C                              %Trim(wkacnam2)             + '","' +
097700091020     C                              %Trim(wkaphone)             + '","' +
097800091020     C                              %Trim(wkfacname)            + '","' +
097900091020     C                              %Trim(wkfaccontac)          + '","' +
098000091020     C                              %Trim(%Editc(WKTDUE:'P'))   + '","' +
098100091020     C                              %Trim(%Editc(WKCRED:'P'))   + '","' +
098200091020     C                              %Trim(%Editc(WKPAY:'P'))    + '","' +
098300091020     C                              %Trim(%Editc(WKBAL:'P'))    + '","' +
098400091020     C                              %Trim(%Editc(L5TRAMT:'P'))  + '","' +
098500091020     C                             %Trim(%Editc(paypcto:'P'))   + '","' +
098600091020     C                             %Trim(%Editc(paypctreq:'P')) + '","' +
098700091020     C                                             pendcancel   + '","' +
098800091020     C                              %Trim(%Editc(WKCOVTDT:'P')) + '","' +
098900091020     C                              %Trim(%Editc(WKAEMP:'P'))   + '","' +
099000091020     C                                           %Trim(WKSLNM)  + '","' +
099100091020     C                                           %Trim(WKSFNM)  + '","' +
099200091020     C                                           %Trim(WKALNM)  + '","' +
099300091020     C                                           %Trim(WKAFNM)  + '","' +
099400091020     C                              %Trim(%Editc(WKDTINV:'P'))  + '","' +
099500091020     C                                                initinv   +   '",'
099600091020
099700150716      * write record to OD170CSV file
099800100629     C                   Write     OD170CSR
099900070615
100000100629     C                   ENDSR
100100030630     C*
100200970220     C/EJECT
100300030630     C*************************************************************
100400030630     C*                                                           *
100500030630     C* Write to CSV file for Excel Spreadsheet Title             *
100600030630     C*                                                           *
100700030630     C*************************************************************
100800030630     C     WriteSpTitle  BEGSR
100900030630     C*
101000091020      * Senior dental version
101100091020     C                   Eval      WKRECORD  =   '"' +
101200091020     C                                                 'Spc handl' + '","' +
101300091020     C                                                 'Trust'     + '","' +
101400091020     C                                                 'Sub'       + '","' +
101500091020     C                                                 'Acct'      + '","' +
101600091020     C                                                 'Acct Name' + '","' +
101700091020     C                                                'Acct Name2' + '","' +
101800091020     C                                                'Acct Phone' + '","' +
101900091020     C                                               'Facil. name' + '","' +
102000091020     C                                            'Facil. contact' + '","' +
102100091020     C                                                 'Total Due' + '","' +
102200091020     C                                                 'Credits'   + '","' +
102300091020     C                                                  'Payments' + '","' +
102400091020     C                                                 'Outs Bal'  + '","' +
102500091020     C                                              'Current Amt'  + '","' +
102600091020     C                                                   '% Paid'  + '","' +
102700091020     C                                               '% Required'  + '","' +
102800091020     C                                           'Pending Cancel'  + '","' +
102900091020     C                                                 'Inv Thru'  + '","' +
103000091020     C                                                 'Act Empl'  + '","' +
103100091020     C                                              'Broker Last'  + '","' +
103200091020     C                                             'Broker First'  + '","' +
103300091020     C                                                  'AA Last'  + '","' +
103400091020     C                                                 'AA First'  + '","' +
103500091020     C                                                 'Date Inv'  + '","' +
103600091020     C                                              'Initial Inv'  + '",'
103700100629     C                   Write     OD170CSR
103800030630     C*
103900110718      * Title for Exclusions spreadsheet
104000110718     C                   Eval      EXRECORD  =   '"' +
104100110725     C                                                     'Trust' + '","' +
104200110725     C                                                       'Sub' + '","' +
104300110725     C                                                      'Acct' + '","' +
104400110718     C                                                 'Acct Name' + '","' +
104500110718     C                                                'Acct Name2' + '","' +
104600110725     C                                                  'Pay Flag' + '","' +
104700110726     C                                             'Exclusion MM/' + '","' +
104800110726     C                                                        'YY' + '","' +
104900110725     C                                                      'Note' + '",'
105000110718     C                   Write     OD170EXR
105100110725     C                   Clear                   OD170EXR
1052000306300320 C                   ENDSR
105300981209     C*
1054009812090103 C***************************************************
1055009812090104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
1056009812090105 C***************************************************
1057009812090107 C*
1058009812090107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
1059009812090107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
1060009812090107 C*
1061009812090106 C     #DATMY        BEGSR
106200981209     C                   MOVEL     @DATIN        @MD               4 0
106300981209     C                   MOVE      @DATIN        @Y                4 0
106400981209     C                   MOVE      @MD           @DATOU            8 0
106500981209     C                   MOVEL     @Y            @DATOU
106600981209     C                   MOVE      *ZEROS        @DATIN            8 0
1067009812090120 C                   ENDSR
106800981209     C*
1069009908090103 C***************************************************
1070009908090104 C* FIRST CYCLE                                     *
1071009908090105 C***************************************************
1072009908090060 C*
1073009908090106 C     *INZSR        BEGSR
1074009908090060 C*
107500030630     C                   Exsr      WriteSpTitle
107600990809     C*
107700110717     C     ExcKey        Klist
107800110717     C                   Kfld                    TRUST#
107900110717     C                   Kfld                    SUB#
108000110717     C                   Kfld                    ACC#
108100110717     C                   Kfld                    LY
108200110717     C                   Kfld                    LM
108300110717     C*
108400990809     C     INKEY         KLIST
108500990809     C                   KFLD                    TRUST#
108600990809     C                   KFLD                    SUB#
108700990809     C                   KFLD                    ACC#
108800990809     C                   KFLD                    NEWYMD
108900990809     C                   KFLD                    KEB
109000990809     C*
109100990809     C     INEXKY        KLIST
109200990809     C                   KFLD                    TRUST#
109300990809     C                   KFLD                    SUB#
109400990809     C                   KFLD                    ACC#
109500091019
109600091019     C     subkey        KLIST
109700091019     C                   KFLD                    TRUST#
109800091019     C                   KFLD                    SUB#
109900990809     C*
110000091015     C     odkey         KLIST
110100091015     C                   KFLD                    TRUST#
110200091015     C                   KFLD                    SUB#
110300091015     C                   KFLD                    zero4
110400091015     C                   KFLD                    bom
110500100630     C*
110600100630     C     odarpkey      KLIST
110700100630     C                   KFLD                    TRUST#
110800100630     C                   KFLD                    SUB#
110900100630     C                   KFLD                    ACC#
111000100630     C                   KFLD                    arp
111100100701     C*
111200100701     C     odsadkey      KLIST
111300100701     C                   KFLD                    TRUST#
111400100701     C                   KFLD                    SUB#
111500100702     C                   KFLD                    noacct            4 0
111600100701     C                   KFLD                    sad
111700091015     C*
111800990809     C     PLNKEY        KLIST
111900990809     C                   KFLD                    MCTRST
112000990809     C                   KFLD                    MCSUB
112100990809     C                   KFLD                    MCPLAN
112200030625     C*
112300030625     C     HisKey        KLIST
112400030625     C                   KFLD                    TRUST#
112500030625     C                   KFLD                    SUB#
112600030625     C                   KFLD                    ACC#
112700030804     C                   KFLD                    KeyDate
112800030730     C*
112900030730     C     HisKey5       KLIST
113000030730     C                   KFLD                    Alpha_KeyAcc
113100030804     C                   KFLD                    KeyDate
113200030703     C*
113300030805     C     HisKey5P      KLIST
113400030805     C                   KFLD                    Alpha_KeyAcc
113500030805     C                   KFLD                    KeyDate
113600030805     C                   KFLD                    HighDate
113700030805     C*
113800030805     C                   Z-add     99999999      HighDate          8 0
1139000307030062 C                   MOVE      'BMB'         BMB               3
1140009908090062 C                   MOVE      'KEB'         KEB               3
114100030925     C                   Z-ADD     0             ZERO9             9 0
114200020128
114300030506     C                   MOVEL     LMDY          USA_DATE
114400030506     C                   ADDDUR    1:*M          USA_DATE
114500030506     C                   EXTRCT    USA_DATE:*M   MDL               2 0
114600030506     C                   EXTRCT    USA_DATE:*Y   YDL               4
114700030910
114800030910     C* DL4 = Withhold Care Letter (One month after effdt of cancel)
114900030910     C                   MOVEl     YR(MDL)       DL4              19
115000030910     c                   cat       '1,':1        dl4
115100030910     c                   cat       YDL:1         dl4
115200030916
115300030910     *********
115400020128     C* M/D/Y heading DATE LINE -
115500020128
115600011025     C                   IF        MO## > 0
115700011025     C                   MOVEA     YR(MO##)      @9                9
115800011025     C                   MOVE      *BLANKS       @19              19
115900011025     C                   EVAL      @19 = %TRIMR(@9) + ' ' + DD## + ',' + ' ' +
116000011011     C                             YY##
116100020128     C                   MOVEl     @19           DL2              19
116200011025     C                   ELSE
1163000201280066 C                   MOVEl     YR(lm)        DL2
116400020128JGE01C                   move      *day          dayc              2
116500020128JGE01C                   move      *year         yearc             4
116600020128     c                   cat       dayc:1        dl2
116700020128     c                   cat       ',':0         dl2
1168000201280075 C                   cat       YEARC:1       dl2
116900011025     C                   ENDIF
117000011011    ***
117100020627     C                   MOVE      *date         rpgdate
117200020627     C                   time                    rpgtime
1173009908090078 C                   ENDSR
117400030912
117500030912      **********************************************************
117600070502      * Find DBE and payment % required
117700030912      **********************************************************
117800070502      * 05/02/07 - add code to find payment % required         *
117900090522      * 05/22/09 - add code to find subsidy members billed to the acct
118000150923      * 09/23/15 - hold carrier code also for the highest threshold %
1181000309120078 C     #fnddbe       begsr
118200030912
118300030912     c                   clear                   dberule           1
118400070502     c                   clear                   paypctreq
118500070503     c                   clear                   paypcto
118600070502     c                   clear                   wkpct
118700070502     c                   clear                   holdpct
118800090522     c                   clear                   subsidymem
118900150923     c                   clear                   holdcarrier
119000030912
119100030912     C     keyacc        setll     memac#
119200030912     C                   dou       %eof(memac#)
119300030912     C     keyacc        reade     memac#
119400030912     c                   if        not %eof(memac#) and (termdt = 0 or
119500030915     c                             termdt > newymd) and (mbenrl <= newymd)
119600030912
119700030912     C* READ COVERAGES
119800030912     C     ssno          setll     mcov
119900030912     C                   dou       %eof(mcov)
120000030912     C     ssno          reade     mcov
120100030912     c                   if        not %eof(mcov) and (candt = 0 or
120200030915     c                             candt > newymd) and (enrldt <= newymd)
120300030912
120400030912     C     plnkey        chain     plnmst
1205000309120096 C                   if        %found(plnmst)
120600090522
120700090522      * is this a subsidy plan billed to the acct?
120800090522     c                   if        sfadm = 'Y' and cexpdt <> 0
120900090522     c                   eval      subsidymem = 'Y'
121000090522     c                   end
121100090522
121200030912     C     pcarr         chain     carmst
1213000705020096 C                   if        %found(carmst)
121400070502      * find the % req
121500070502     c                   exsr      #chkpct
121600070502     c                   end
121700030912     c                   end
121800030912
121900030912     c                   end
122000030912     c                   enddo
122100030912
122200030912     c                   end
122300030912     c                   enddo
122400070502
122500070502      * after all members processed, finalize payment percent required.
122600070502      * if for some reason the % was not found then default to 100%
122700070502
122800070502     c                   if        holdpct <> 0
122900070502     c                   z-add     holdpct       paypctreq
123000070502     c                   else
123100070502     c                   z-add     100           paypctreq
123200070502     c                   end
123300030912
1234000309120078 C                   ENDSR
123500070502
123600110222      * ? _____________________________________________________________
123700110222      *? *                                                             *
123800110222      *? * Write all data fields to the COURTESY letter Archive         *
123900110222      *? *_____________________________________________________________*
124000110222     C     WriteArchive  BEGSR
124100110222      *
124200110222     C                   Eval      A7TRST = O7TRST
124300110222     C                   Eval      A7SUB# = O7SUB#
124400110222     C                   Eval      A7ACCT = O7ACCT
124500110222     C                   Eval      A7LTYP = O7LTYP
124600110222     C                   Eval      A7PYFL = O7PYFL
124700110222     C                   Eval      A7RPNM = O7RPNM
124800110222     C                   Eval      A7ADD1 = O7ADD1
124900110222     C                   Eval      A7ADD2 = O7ADD2
125000110222     C                   Eval      A7CSZ  = O7CSZ
125100110222     C                   Eval      A7RENM = O7RENM
125200110222     C                   Eval      A7TSA  = O7TSA
125300110222     C                   Eval      A7BOM  = O7BOM
125400110222     C                   Eval      A7TITL = O7TITL
125500110222     C                   Eval      A7NHNM = O7NHNM
125600110222     C                   Eval      A7NHA1 = O7NHA1
125700110222     C                   Eval      A7NHA2 = O7NHA2
125800110222     C                   Eval      A7NHCZ = O7NHCZ
125900110222     C                   Eval      AUTBAL = OUTBAL
126000110222     C                   Eval      A7DATE = O7DATE
126100110222     C                   Eval      A7MMYY = O7MMYY
126200110222     C                   Eval      A7NHAD = O7NHAD
126300110222     C                   Eval      A7SSNO = O7SSNO
126400110222     C                   Eval      A7PBAL = O7PBAL
126500110222     C                   Eval      A7CDUE = O7CDUE
126600110222     C                   Eval      A7TDUE = O7TDUE
126700110222     C                   Eval      A7PDMO = O7PDMO
126800110222     C                   Eval      A7CUMO = O7CUMO
126900110222     C                   Select
127000110222     C                   When      O7LTYP = 'C'
127100110222     C                   Eval      A7DESC =  %Trim('COURTESY Letter')
127200110222     C                   When      O7LTYP = 'W'
127300110222     C                   Eval      A7DESC =  %Trim('WITHHOLD CARE Letter')
127400110222     C                   EndSl
127500110222     C     *Date         Mult      10000.0001    A7LDT
127600110222     C                   Write     ODRA
127700110222     C                   Clear                   ODRA
127800110222      *
127900110222     C                   EndSr
128000070502      **********************************************************
128100070502      * check payment %
128200070502      **********************************************************
1283000705020078 C     #chkpct       begsr
128400070502
128500070502     c                   z-add     cthresh       wkpct
128600150218      * Set DBE indicator
128700150218     c                   if        carbc = 'D'
128800150218     c                   eval      dberule = 'Y'
128900150218     c                   end
129000150216
129100150923      * hold higest percent and carrier code
129200070502     c                   if        wkpct > holdpct
129300070502     c                   z-add     wkpct         holdpct
129400150923     c                   move      pcarr         holdcarrier
129500070502     c                   end
129600070502
1297000705020078 C                   endsr
1298009805290278 OHIST      EADD         ADDHIS
1299000402260279 O                       HSTKEY              10
1300001007020284 O                       ODTRCD              19
1301000309250285 O                       ZERO9               24P
130200040226     O                       HNOTE               55
130300110719     O                       HNOTE2              85
130400040615     O                                           90 '00'
130500131025     O                       thispgmname        107
130600131025     O                                          108 ' '
1307009702190292 O                       KEYACC             119
1308001310100285 O                       ZERO8              127
1309009702190294 O                                          128 'A'
1310009812090281 O                       *YEAR              132
1311009812090282 O                       *MONTH             134
1312009812090283 O                       *DAY               136
1313000406150288 O                                          144 '00000000'
1314009812090288 O                                          152 '00000000'
1315000305060289 O                       NEWYMD2            160
1316001310100285 O                       ZERO92             184
1317001310100285 O                       ZERO7              191
1318001310100285 O                       hstrtime           199
1319001310100285 O                       ZERO7              206
1320001310140293 O                       USERID             216
132100970228     O*
1322000910230166 Orp170pe   E            HEADE          2 03
1323009806020167 O                                           45 '*****'
1324009806020168 O                       CONAME              85
1325009806020169 O                                           91 '*****'
1326009806020170 O          E            HEADE          1
1327009806020171 O                                           61 'ACCOUNTS PENDING CANCELL'
1328009806020172 O                                           85 'ATION ERROR REPORT      '
1329009806020174 O          E            HEADE          1
1330000910230175 O                       newmdy              73 '0  /  /    '
1331009806020176 O          E            HEADE          1
1332009806020177 O                                           67 'TRUST :'
1333009806020178 O                       LTRUST              71
1334009806020179 O          E            HEADE          1
1335001505220180 O                                           25 'PROGRAM NAME: OD170 '
1336009806020181 O                                          120 'PAGE:'
1337000002010182 O                       PAGE3         Z    128
1338009806020183 O          E            HEADE          1
1339009806020184 O                                           14 'RUN DATE:'
1340009806020185 O                       UDATE         Y     25
1341009806020186 O                                          120 'TIME:'
1342000206270187 O                       rpgtime            128
1343009806020188 O          E            HEADE          1
1344009806020189 O                                           24 '""""""""""""""""""""""""'
1345009806020190 O                                           48 '""""""""""""""""""""""""'
1346009806020191 O                                           72 '""""""""""""""""""""""""'
1347009806020192 O                                           96 '""""""""""""""""""""""""'
1348009806020193 O                                          120 '""""""""""""""""""""""""'
1349009806020194 O                                          132 '""""""""""""'
1350009806020195 O          E            HEADE          1
1351009806020199 O                                           11 'ACCOUNT #'
1352009806020200 O                                           20 'ERROR'
1353009806030188 O          E            HEADE          2
1354009806030189 O                                           24 '""""""""""""""""""""""""'
1355009806030190 O                                           48 '""""""""""""""""""""""""'
1356009806030191 O                                           72 '""""""""""""""""""""""""'
1357009806030192 O                                           96 '""""""""""""""""""""""""'
1358009806030193 O                                          120 '""""""""""""""""""""""""'
1359009806030194 O                                          132 '""""""""""""'
1360009806020213 O          E            LINEE          1
1361009806020214 O                       KEYACC              12 '   -   -    '
1362009806020215 O               21                          34 'INVALID TRUST      '
136300150923
136400150923      * getrate error
1365001509230215 O               63      parmerr             50
1366001509230215 O               63                          +2 'EFF-'
1367001509230215 O               63      newymd              +1 '    /  /  '
1368001509230215 O               63                          +2 'CAR-'
1369001509230215 O               63      parmcar             +1
137000150923
137100011025000000*0011111111112222222222333333333344444444445555555555666666666677777777778
137200011025123456*8901234567890123456789012345678901234567890123456789012345678901234567890
137300980226**
137400011025January
137500011025February
137600011025March
137700011025April
137800011025May
137900011025June
138000011025July
138100011025August
138200011026September
138300011025October
138400011025November
138500011025December
