0001009102150002 F******************************************************************
0002000004140003 F* RP430      GROUP BENEFIT SERVICES SOFTWARE           1990      *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009102150006 F*            DATE - 08/23/90                                     *
0006009102150007 F*                                                                *
0007009102150008 F*  DESCRIPTION - THIS PROGRAM SELECTS MEMBER RECORDS THAT BECAME *
0008009102150009 F*                ELIGIBLE FOR COBRA AND UPDATES NON-ELIGIBLE     *
0009009102150010 F*                RECORDS WITH UDATE AND 'CNN'-NOT ELIGIBLE.      *
0010009201270011 F*                                                                *
0011009201270011 F* DLK  1/27/92 - ADD VISION TO ELIGIBLE PLANS.                   *
0012009811190014 F*                                                                *
0013009811190010 F*  Y2K CONVERT - 1998                                            *
0014009903300011 F* DLK  3/30/99 - ADD DECEASED MEMBER CHECK                       *
0015000002280011 F* DLK  2/28/00 - ADD FSA TO LIST OF PLANS AND CONVERT TO RPGLE   *
0016000003080011 F* DLK  3/08/00 - remove FSA from LIST OF PLANS                   *
0017000004100011 F* DLK  4/10/00 - FSA will product seperate letter. add 2 columns *
0018000004100015 F*                to show med or fsa.                             *
0019000005050011 F* DLK  5/05/00 - ADD Transferred member check, add invalid ss#   *
0020000005050015 F*                check                                           *
0021000103290011 F* DLK  3/28/01 - create histout file for cob370 to use as        *
0022000103290015 F*                input after rp430 runs in rp430cl.              *
0023000111080011 F* DLK 11/08/01 - add column to show "DF" cov type (Magellan use) *
002400020724     F* DMA 07.24.02 - treat code DDD the same as D5   per Lisa K      *
0025000408110017  * DLK 08/11/04 - convert plan category selection to new plan     *
002600040811      *                category type. remove fsa and magellan code     *
0027000410040017  * DLK 10/04/04 - cobra lite modifications                        *
0028001008270017  * DLK 08/27/10 - add DGM - gross misconduct code                 *
0029001103110011  * DLK 03/11/11 - Exclude plans OPTM & OPTD even though they are a cat
0030001312060011  *                type "M" (like we did in DB430). - Per Dave A and Shelly
0031001103310011  * DLK 03/31/11 - add FSA plan category type to list of eligible  *
0032001103310011  *                plans                                           *
0033001201310011  * DLK 01/31/12 - remove billing only, non-cobra and cancelled
0034001201310011  *                accounts messages from the report.
0035001206250011  * DLK 06/25/12 - make "DECEASED" first priority error msg
0036001212060011  * DLK 12/06/12 - add single member selection
0037001302250011  * DLK 02/25/13 - add edit for state account not in MD
003800131005      * dlk 10/05/13 - history expansion project - recompile only
0039001312060011  * DLK 12/06/13 - Hard coded exclusion of plans WAVM, WAVD, WAVV due
0040001312060011  *                to a design flaw in OLE. - Per Dave A.
004100140106      * rlj 01/06/14 - Add ACA flag to report
004200140521      * rlj 05/21/14 - Adjust ACA flag date logic
0043001510230011  * DLK 10/23/15 - Hard coded exclusion of plans DECD, DECM and DECV
0044001510230011  *                since no other soultion has been accepted yet
0045001609290011 F* DLK  9/29/16 - ADD additional deceased codes DEP,DED,DEE
0046001702020007 F* DLK 02/02/17 - add acct state column
0047001809250011  * DLK 09/20/18 - add EAP plan category type (C) to list of
0048001809250011  *                eligible plans for FEDERAL COBRA ONLY.
0049001812100011  * DLK 12/10/18 - Hard code Humana med and den carriers in md state
0050001812100011  *                accts as ineligible. Humana does not allow state
0051001812100011  *                extension.
0052002002040011  * DLK 02/04/20 - Identify EBS members
0053002007170011  * DLK 07/16/20 - Add state of residence with addendum note for
0054002007170011  *                California and convert to CSV
0055002110070011  * DLK 10/07/21 - remove ssn parm from lda, not needed
0056002007170011  *
0057009102150013 F******************************************************************
0058000002280014 FMEMBER    UP   e             DISK
0059000002280016 FMCOV      IF   e           k DISK
0060000002280017 FACCMST    IF   e           k DISK
006100130225     fac2mst    IF   E           K Disk
0062000002280018 FPLNMST    IF   e           k DISK
0063001401060018 FPLNAUXP   IF   E           K DISK
0064000103280014 Fhistak    if   e           k DISK
006500040811     Fcodesl1   IF   E           K DISK
0066000103280014 Fhistout   o  a e             DISK    rename(histr:histrout) prefix(h)
0067002007160017 Frp430xl   o  a e             DISK
0068001302250023 D RARR            S             32    DIM(10) CTDATA PERRCD(1)
0069000410040023 D srvdes          S              7
0070001702020037 D acc_comp_st     S                   like(astate)
0071001702020037 D acc_st_out      S              2
007200200204     D ebsacct         S              1
007300200205     D parmebsyn       S              1
007400200205     D parmebstsa      S             10
007500200716     D state_o         S             25
0076002007160037 D acname_o        S                   like(acnam1)
0077002007160125 D csv             c                   const('","')
0078009102150049 D                 DS
0079009811190050 D  CYMD                   1      8  0
0080009811190051 D  CYY                    1      4  0
0081009811190052 D  CMM                    5      6  0
0082002007160049 D                 DS
0083002007160050 D  tsa                    1     10  0
0084002007160051 D  mbtrst                 1      3  0
0085002007160051 D  mbsub#                 4      6  0
0086002007160051 D  mbacct                 7     10  0
0087000103280055 D                 DS
0088000103280056 D  trcode                 1      3
0089000103280056 D  tr1                    1      1
0090009102150053 D                UDS
0091002110070054 D**lssn                   1      9
0092001212060054 D  CONAME               201    240
0093001302250056 D  lprefix              241    241
0094009102150055 D  TIME                 242    247  0
0095009811190157 D  UD8YMD               248    255  0
009600000228     imembr
009700000228     i                                          mbtrst        l1
009800000228     i                                          mbsub#        l1
009900000228     i                                          mbacct        l1
010000010328     c* write every member to histout for COB370 run
010100010328
0102000103280137 C                   exsr      #gettrm
010300180925     C                   MOVE      TERMDT        @DATIN
010400180925     C                   EXSR      #DATYM
010500180925     C                   MOVE      @DATOU        TERMDY            8 0
010600180925
010700010328
0108001809250064 C                   clear                   REASON           32
0109002007160064 C                   clear                   acname_o
0110001809250065 C     acckey        CHAIN     ACCMST
011100180925     c                   if        not %found(accmst)
0112001809250135 C                   eval      REASON = '** INVALID ACCOUNT # **'
0113002007160137 C                   EXsr      writexldet
0114001809250086 C                   exsr      #notelg
0115001809250072 C                   GOTO      #END
011600200716     c                   else
011700200716     c                   eval      acname_o = acnam1
011800180925     c                   end
011900180925
012000200204      * check for EBS acct
012100200204     c                   exsr      #chkebs
012200200204
0123009104190076 C                   EXSR      #NAME
012400981119     C*
012500170202      * account state compare field -
012600170202      * get acct physical address if one exists, otherwise use the mailing
012700170202      * address.
012800170202
0129001702020234 C     ac2key        CHAIN     ac2mst
013000170202     c                   if        %found(ac2mst) and a2state <> *blanks
013100170202     c                   move      a2state       acc_comp_st
013200170202     c                   else
013300170202     c                   move      astate        acc_comp_st
013400170202     c                   end
013500170202
013600170202      * if state account, fill the account state output field that will
013700170202      * print on the report
013800170202     c                   clear                   acc_st_out
0139001702020092 C                   if        fcstfl = 'S'
014000170202     c                   move      acc_comp_st   acc_st_out
014100170202     c                   end
014200170202
0143009102150066 C*
0144000002280067 C* IF ACCOUNT CANCELLED  - NOT ELIG.
0145001201310068 C* 01/31/12 - stop showing this message
0146009104160071 C     ATRMDT        IFNE      0
0147001201310084 C**                 MOVE      RARR(5)       REASON
014800120201     c** of              except    head
0149001201310085 C**                 EXCEPT    LINE
0150000002280086 C                   exsr      #notelg
0151009102150072 C                   GOTO      #END
0152009102150074 C                   END
0153001201310066 C*
0154001201310067 C* IF ACCOUNT HAS BILLING ONLY SERVICE - NOT ELIG, don't show msg
0155001201310071 C                   if        acobsrv = 'B'
0156001201310086 C                   exsr      #notelg
0157001201310072 C                   GOTO      #END
0158001201310074 C                   END
0159009102150078 C*
0160000410040079 C* IF MEMBER SELECTED IS FROM AN ACCOUNT WHICH HAS NOT SELECTED
0161000410040080 C* COBRA SERVICE, WRITE TODAYS DATE AND REASON OUT FOR NOT NOTIFIED
0162001201310081 C* 01/31/12 - stop showing this on the report
0163009102150082 C     FCSTFL        IFEQ      'N'
0164001201310084 C**                 MOVE      RARR(1)       REASON
016500120201     c** of              except    head
0166001201310085 C**                 EXCEPT    LINE
0167000002280086 C                   EXsr      #notelg
0168009102150087 C                   GOTO      #END
0169009102150088 C                   END
017000120625
0171001206250131 C*
0172001609290129 C* CHECK TERM CODE. IF DECEASED (D5 or DDD) - NOT ELIG
0173001206250131 C* 06/25/12 - make this error the top priority to print above all
0174001206250131 C*            others
0175001609290131 C* 09/29/16 - add DEP, DED, DEE
017600160929     c                   if        termcd = 'D5 ' or termcd = 'DDD' or
017700160929     c                             termcd = 'DEP' or termcd = 'DED' or
017800160929     c                             termcd = 'DEE'
0179001206250135 C                   MOVE      RARR(6)       REASON
0180001401170132 C                   EXSR      FNDPLN
0181002007160137 C                   EXsr      writexldet
0182002007160137 C                   EXsr      #notelg
0183001206250138 C                   GOTO      #END
0184001206250139 C                   END
018500120625
0186009102150089 C*
0187002007170090 C* IF STATE ACCOUNT AND LIVES OUTSIDE MD - NOT ELIGIBLE
0188009102150091 C*
0189009102150092 C     FCSTFL        IFEQ      'S'
0190009102150093 C     STATE         IFNE      'MD'
0191009903300095 C                   MOVE      RARR(2)       REASON
0192001401170132 C                   EXSR      FNDPLN
0193002007160137 C                   EXsr      writexldet
0194000002280097 C                   EXsr      #notelg
0195009102150098 C                   GOTO      #END
0196009102150099 C                   END
0197009102150100 C                   END
0198001302250089
0199002007170090  * IF STATE ACCOUNT AND ACCT IS OUTSIDE MD - NOT ELIGIBLE
020000130225
0201001702020092 C                   if        fcstfl = 'S' and acc_comp_st <> 'MD'
0202001302250095 C                   MOVE      RARR(10)      REASON
0203001401170132 C                   EXSR      FNDPLN
0204002007160137 C                   EXsr      writexldet
0205001302250097 C                   EXSR      #notelg
0206001302250098 C                   GOTO      #END
0207001302250100 C                   END
0208009102150101 C*
0209002007170102 C* IF COVERAGE WAS NOT ACTIVE LONG ENOUGH - NOT ELIGIBLE
0210009102150103 C*  MIN TIME - FEDERAL 1 MONTH,  STATE 3 MONTHS
0211009102150104 C*
0212009102150105 C*
0213000002280106 C                   Z-ADD     mbenrl        CYMD
0214009102150107 C     FCSTFL        IFEQ      'S'
0215009102150108 C                   ADD       3             CMM
0216009102150109 C                   ELSE
0217009102150110 C                   ADD       1             CMM
0218009102150111 C                   END
0219009102150112 C*
0220009102150113 C     CMM           IFGT      12
0221009102150114 C                   ADD       1             CYY
0222009102150115 C                   SUB       12            CMM
0223009102150116 C                   END
0224009102150120 C*
0225009811190121 C     TERMDT        IFLT      CYMD
0226009903300123 C                   MOVE      RARR(3)       REASON
0227001401170132 C                   EXSR      FNDPLN
0228002007160137 C                   EXsr      writexldet
0229000002280125 C                   EXsr      #notelg
0230009102150126 C                   GOTO      #END
0231009102150127 C                   END
0232009102150128 C*
0233001103310129 C* FIND PLANS SUBSCRIBER HAS. IF NO HEALTH, DENTAL, VISION, RX, FSA
0234001103310130 C* - NOT ELIGIBLE
0235009102150131 C*
0236009102150132 C                   EXSR      FNDPLN
023700000410
0238000408110133 C                   if        medflg <> 'Y'
0239009903300135 C                   MOVE      RARR(4)       REASON
0240002007160137 C                   EXsr      writexldet
0241000002280137 C                   EXsr      #notelg
0242009102150138 C                   GOTO      #END
0243009102150139 C                   END
0244001008270131 C*
0245001008270129 C* CHECK TERM CODE. IF Gross misconduct (DM) - NOT ELIG
0246001008270131 C*
0247001008270133 C     TERMCD        IFEQ      'DGM'
0248001008270135 C                   MOVE      RARR(9)       REASON
0249002007160137 C                   EXsr      writexldet
0250001008270137 C                   EXsr      #notelg
0251001008270138 C                   GOTO      #END
0252001008270139 C                   END
0253000005050131 C*
0254000005050129 C* CHECK TERM CODE. IF transfer (DMT) - NOT ELIG
0255000005050131 C*
0256000005050133 C     TERMCD        IFEQ      'DMT'
0257000005050135 C                   MOVE      RARR(7)       REASON
0258002007160137 C                   EXsr      writexldet
0259000005050137 C                   EXsr      #notelg
0260000005050138 C                   GOTO      #END
0261000005050139 C                   END
0262000005050131 C*
0263000005050129 C* CHECK TERM CODE. IF invalid ssn (DIS) - NOT ELIG
0264000005050131 C*
0265000005050133 C     TERMCD        IFEQ      'DIS'
0266000005050135 C                   MOVE      RARR(8)       REASON
0267002007160137 C                   EXsr      writexldet
0268000005050137 C                   EXsr      #notelg
0269000005050138 C                   GOTO      #END
0270000005050139 C                   END
0271009102150140 C*
0272009102150141 C* IF MEMBER HAS MADE IT PAST ALL ABOVE CHECKS, HE IS ELIGIBLE
0273009102150142 C* FOR COBRA
0274009102150143 C*
0275009102150144 C                   ADD       1             TOTMEM            4 0
0276002007160137 C                   EXsr      writexldet
027700000323
027800000410     c* what letters will be printed
027900000410
028000040811     c                   if        medflg <> ' '
028100040811     c                   move      'M'           delf
028200000410     c                   end
028300000410
0284000002280146 C                   update    membr
0285009102150147 C     #END          TAG
028600120201
028700200716     clr                 exsr      writexllr
0288001202010148
0289009102150149 C****************************************************************
0290009102150150 C* ROUTINE FOR FINDING WHICH PLANS EACH SUBSCRIBER HAS          *
0291009102150151 C****************************************************************
0292009102150152 C     FNDPLN        BEGSR
0293000004100153 C                   MOVE      *BLANK        medflg            1
0294001401060153 C                   MOVE      *BLANK        acaflg            1
0295009102150154 C                   SETOFF                                       70
0296000002280155 C     mbssno        SETLL     MCOV
0297009102150156 C*
0298009102150157 C* READ MCOV FOR ALL PLANS SUBSCRIBER HAS AND CHAIN TO
0299009102150158 C* PLNMST TO DETERMINE WHAT KIND OF PLAN IT IS
0300009102150159 C*
0301009102150160 C     LOOP          TAG
0302000002280161 C     mbssno        READE     MCOV                                   70
0303009102150162 C   70              GOTO      ENDFND
0304009102150163 C*
0305009102150164 C* CHECK MCOV CANCEL DATE - DID SUBSCRIBER HAVE PLAN WHEN
0306009102150165 C* HE WAS CANCELED? IF NOT, SKIP
0307009102150166 C*
0308001103110167 C                   if        termdt <> CANDT or
030900110311      * 03/11/11 exclude opt out payroll plans
031000131206      * 12/06/13 exclude opt out waiver plans per Dave A
031100151023      * 10/23/15 exclude decline plans
031200151023     c                             (mcplan = 'OPTM' or mcplan = 'OPTD' or
031300131206     c                              mcplan = 'WAVM' or mcplan = 'WAVD' or
031400151023     c                              mcplan = 'WAVV' or
031500151023     c                              mcplan = 'DECM' or mcplan = 'DECD' or
031600151023     c                              mcplan = 'DECV')
0317009102150168 C                   GOTO      LOOP
0318009102150169 C                   END
0319001405210170  * Mbr Term date = Plan Cancel Date
0320000408110171 C     PLNKEY        CHAIN     PLNMST
032100040811     c                   if        %found(plnmst)
032200181210
032300181210      * 12/10/18 - Skip Humana med & den in state accounts since they are
032400181210      *            not elig for state extension
032500181210     c                   if        (pcarr = 'HUM' or pcarr = 'HUD')
032600181210     c                             and fcstfl = 'S'
032700181210     c                   goto      loop
032800181210     c                   end
032900181210
033000180925      * only include medical, dental, vision, rx, fsa and
033100180925      * eap (eap is for Federal COBRA only)
033200181210     c     plncat        chain     codesl1
033300040811     c                   if        %found(codesl1) and
033400040811     c                             (action = 'M' or action = 'D' or
033500110331     c                             action = 'V' or action = 'R' or
033600180925     c                             action = 'F' or
033700180925     c                             (action = 'C' and fcstfl = 'F'))
033800040811     c                   eval      medflg = 'Y'
033900180920
0340001401060170  *        Check to see if Med Plan is ACA
034100140106     c                   if        action = 'M'
0342001401060171 C     PLNKEY        CHAIN     PLNAUXP
034300140106     c                   if        %found(plnauxp) and pxacar = 'Y'
034400140106     c                   eval      acaflg = 'Y'
0345001401060184 c                   endif
034600140521      *
034700140521     c                   if        %found(plnauxp) and pxacar = 'N' and
034800140521     c                             enrldt = candt
034900140521     c                   eval      acaflg = ' '
0350001405210184 c                   endif
035100140521      *
0352001401060184 c                   endif
035300140106      *
0354001401060184 c                   end
0355000408110184 c                   end
035600011108
0357009102150187 C                   GOTO      LOOP
0358009102150188 C*
0359009102150189 C     ENDFND        ENDSR
0360009102150190 C/SPACE
0361009102150191 C****************************************************************    SR#NAM
0362009102150192 C*   FIELD= LAST, FIRST MI.                                          SR#NAM
0363009102150193 C*------------------- COMPRESS NAME FIELDS ---------------------*    SR#NAM
0364009102150194 C*                                                                   SR#NAM
0365009102150195 C****************************************************************    SR#NAM
0366009102150196 C     #NAME         BEGSR
0367009102150197 C*                                                                   SR#NAM
0368000002280200 C                   MOVE      *BLANKS       N                35
0369000002280202 C                   MOVEl     mlname        N
037000000228     C                   CAT       ',':0         N
037100000228     C                   CAT       mfname:1      N
037200000228     C*
037300000228     C     MMI           IFNE      ' '
037400000228     C                   CAT       MMI:1         N
037500000228     C                   CAT       '.':0         N
037600000228     C                   END
0377000410040235
0378000410040235  * cobra service description
0379000410040235
038000041004     c                   clear                   srvdes
038100041004
038200041004     c                   select
038300041004     c                   when      acobsrv = 'L'
038400041004     c                   eval      srvdes = 'LETTER '
038500041004     c                   when      acobsrv = 'B'
038600041004     c                   eval      srvdes = 'BILLING'
038700041004     c                   when      acobsrv = 'F'
038800041004     c                   eval      srvdes = 'FULL   '
038900041004     c                   when      acobsrv = ' '
039000041004     c                   eval      srvdes = 'NONE   '
039100041004     c                   endsl
039200041004
0393000002280236 C                   ENDSR
0394000002280191 C****************************************************************    SR#NAM
0395000002280194 C*  not eligible                                                     SR#NAM
0396000002280195 C****************************************************************    SR#NAM
0397000002280196 C     #notelg       BEGSR
0398000002280200 C                   eval      ntfycd = 'CNN'
0399000002280200 C                   eval      delf   = ' '
0400000002280200 C                   eval      ntfydt = ud8ymd
0401000002280200 C                   update    membr
0402000002280236 C                   ENDSR
0403009811190107 C*
0404000103280103 C****************************************************************
0405000103280104 C* get hist term rec and pass to workfile for COB370 to use     *
0406000103280105 C****************************************************************
0407000103280196 C     #gettrm       BEGSR
040800010328     c                   move      mbssno        ssn10            10
040900010328     c                   eval      *in22 = *off
041000010328     c     hiskey        setll     histak
041100010328
041200010328     c                   dow       *in22 = *off
041300010328     c                   readp     histak                                 22
041400010328     c                   if        *in22 or hkey <> ssn10
041500010328     c                   leave
041600010328     c                   end
041700010328
041800010328     c* move fields to histout (copy of hist) that will be used in
041900010328     c* cob370
042000010328     c* if member cancel transaction
042100010328     c                   if        tr1 = 'D'
042200010328     c                   move      hkey          hhkey
042300010328     c                   move      ck#not        hck#not
042400010328     c                   move      hstrst        hhstrst
042500010328     c                   move      hssub#        hhssub#
042600010328     c                   move      hsacct        hhsacct
042700010328     c                   move      trdate        htrdate
042800010328     c                   move      covtdt        hcovtdt
042900010328     c                   write     histrout
043000010328     c                   leave
043100010328     c                   end
043200010328
043300010328     c                   enddo
043400010328
0435000103280236 C                   ENDSR
0436000103280107 C*
0437009811190103 C***************************************************
0438009811190104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0439009811190105 C***************************************************
0440009811190107 C*
0441009811190107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0442009811190107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0443009811190107 C*
0444009811190106 C     #DATYM        BEGSR
044500981119     C                   MOVE      @DATIN        @MD               4 0
044600981119     C                   MOVEL     @DATIN        @Y                4 0
044700981119     C                   MOVEL     @MD           @DATOU            8 0
044800981119     C                   MOVE      @Y            @DATOU
044900981119     C                   MOVE      *ZEROS        @DATIN            8 0
0450009811190120 C                   ENDSR
0451000002280107 C*
0452002002040103  ***************************************************
0453002002040104  * check for EBS account.
0454002002040105  ***************************************************
0455002002040106   begsr #chkebs;
045600200204
045700200204
045800200205       clear ebsacct;
045900200204
046000200205       parmebstsa = %editc(actrst:'X') + %editc(acsub#:'X') +
046100200205                    %editc(acacct:'X');
046200200205       clear parmebsyn;
046300200205
046400200205     c                   call      'GETEBSCL'
046500200205     c                   parm                    parmebstsa
046600200205     c                   parm                    parmebsyn
046700200205       if parmebsyn = 'Y';
046800200205        ebsacct = 'Y';
046900200205       endif;
047000200204
0471002002040106   endsr;
047200200204
047300200204
0474002007160164 C*************************************************************
0475002007160164 C* Write Spreadsheet Detail                                  *
0476002007160164 C*************************************************************
047700200716     C     Writexldet    BEGSR
047800200716
047900200716      * identify California addendum needed
048000200716
048100200716       clear state_o;
048200200716       state_o = state;
048300200716       if state = 'CA';
048400200716        state_o = state + ' - Addendum needed';
048500200716       endif;
048600200716
048700200716     c                   clear                   rp430fld
048800200716     C                   Eval      rp430fld  = '"' +
048900200717     C                             %trim(%editw(mbssno:'0   -  -    ')) + csv +
049000200716     C                             %trim(N)                             + csv +
049100200716     C                             %trim(state_o)                       + csv +
049200200716     C                             %trim(%editw(termdy:'  /  /    '))   + csv +
049300200716     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
049400200716     C                             %trim(acname_o)                      + csv +
049500200716     C                             %trim(fcstfl)                        + csv +
049600200716     C                             %trim(acc_st_out)                    + csv +
049700200716     C                             %trim(srvdes)                        + csv +
049800200716     C                             %trim(medflg)                        + csv +
049900200716     C                             %trim(acaflg)                        + csv +
050000200716     C                             %trim(ebsacct)                       + csv +
050100200716     C                             %trim(REASON)                        + csv +
050200200716     C                             ' '                          +
050300200716     C                             '",'
050400200716     C*
050500200716     C                   Write     rp430xr
0506002007160320 C                   ENDSR
050700200716     C*
050800200716
0509002007160164 C*************************************************************
0510002007160164 C* Write Spreadsheet total                                   *
0511002007160164 C*************************************************************
051200200716     C     Writexllr     BEGSR
051300200716
051400200716     c                   clear                   rp430fld
051500200716     c                   clear                   totmsg           35
051600200717       totmsg = 'Eligible Members = ' + %trim(%editc(totmem:'1'));
051700200716     C                   Eval      rp430fld  = '"' +
051800200716     C                             %trim(totmsg)                        + csv +
051900200716     C                             ' '                                  + csv +
052000200716     C                             ' '                                  + csv +
052100200716     C                             ' '                                  + csv +
052200200716     C                             ' '                                  + csv +
052300200716     C                             ' '                                  + csv +
052400200716     C                             ' '                                  + csv +
052500200716     C                             ' '                                  + csv +
052600200716     C                             ' '                                  + csv +
052700200716     C                             ' '                                  + csv +
052800200716     C                             ' '                                  + csv +
052900200716     C                             ' '                                  + csv +
053000200716     C                             ' '                                  + csv +
053100200716     C                             ' '                          +
053200200716     C                             '",'
053300200716     C*
053400200716     C                   Write     rp430xr
0535002007160320 C                   ENDSR
053600200716     C*
053700200716     C*************************************************************
053800200716     C* Write Spreadsheet heading                                 *
053900200716     C*************************************************************
054000200716     C     Writexlhead   BEGSR
054100200716     c                   clear                   rp430fld
054200200716     C                   Eval      rp430fld = '"' +
054300200716     C                             'SSN'                             + csv +
054400200716     C                             'MEMBER NAME'                     + csv +
054500200716     C                             'MEM STATE'                       + csv +
054600200716     C                             'TERM DATE'                       + csv +
054700200716     C                             'ACCT #'                          + csv +
054800200716     C                             'ACCT NAME'                       + csv +
054900200716     C                             'FED/STATE'                       + csv +
055000200716     C                             'ACCT STATE'                      + csv +
055100200716     C                             'COBRA SERV'                      + csv +
055200200716     C                             'MED'                             + csv +
055300200716     C                             'ACA'                             + csv +
055400200716     C                             'EBS'                             + csv +
055500200716     C                             'NOT ELIG REASON'                 + csv +
055600200717     C                             'NOTES'                           +
055700200716     C                             '",'
055800200716     C                   Write     rp430xr
0559002007160320 C                   ENDSR
056000200716
0561000002280106 C     *inzsr        BEGSR
056200000228     c     acckey        klist
056300000228     c                   kfld                    mbtrst
056400000228     c                   kfld                    mbsub#
056500000228     c                   kfld                    mbacct
056600130225
056700130225     C     ac2key        KLIST
056800130225     C                   KFLD                    lprefix
056900130225     C                   KFLD                    mbtrst
057000130225     C                   KFLD                    mbsub#
057100130225     C                   KFLD                    mbacct
057200130225
057300000228     c     plnkey        klist
057400000228     c                   kfld                    mctrst
057500000228     c                   kfld                    mcsub#
057600000228     c                   kfld                    mcplan
057700010328     c     hiskey        klist
057800010328     c                   kfld                    ssn10
057900010328     c                   kfld                    all9
058000010328     c                   move      99999999      all9              8 0
058100120201
058200200716     C                   exsr      Writexlhead
058300120201
0584000002280120 C                   ENDSR
058500990330** REASON ARRAY
058600041004NO COBRA SERVICE FOR THIS ACCT
058700000410STATE ACCT, LIVES OUTSIDE MD.
058800000410COVERAGE NOT ACTIVE LONG ENOUGH
058900180920NO MED, DEN, RX, VIS, FSA, EAP
059000000410ACCOUNT CANCELLED
059100000410DECEASED MEMBER
059200000505MEMBER TRANSFER
059300000505INVALID SOCIAL SECURITY #
059400100827GROSS MISCONDUCT
059500130225STATE ACCT, ACCT NOT IN MD
