0001000210160015  ******************************************************************
000200030306      * cr230          Group Benefit Services, Inc.                    *
000300021016      *                                                                *
000400021016      *    WRITTEN BY - DAVID KETTERMAN                                *
000500030306      *    DATE       - 03/06/03                                       *
000600021016      *                                                                *
000700021108      * This program will produce the Delegated Billing PEAR file      *
000800030306      * on demand for enrollment info only.                            *
0009000303210015  * 03/21/03 dlk - since CFS will not have their program fixed     *
0010000303210015  *                til 7/03, I will send the enrollment date       *
0011000303210015  *                to avoid all the errors. When they fix their    *
0012000303210015  *                program, we will need to stop sending the       *
0013000303210015  *                enrollment date again.                          *
0013010507120015  * 07/12/05 dlk - PEAR file changes - new fields                  *
0014000303210015  *                                                                *
0015000210160015  ******************************************************************
0016000211080017 Fdw300j    iP   E             DISK
001601050712     Fcodesl1   IF   E           K DISK
001602050712     Faccmst    IF   E           K DISK
0017000211110016 fclass     IF   E           K DISK
0018000211120016 fmember    IF   E           K DISK
0019000211120016 fdepend    IF   E           K DISK
0020000211120016 fdcovc     IF   E           K DISK
0021000211120016 fgrate     IF   E           K DISK
0022000211080030 Fdbpearh   O  A E             DISK
0023000211120030 Fdbpears   O  A E             DISK
0024000211120030 Fdbpeard   O  A E             DISK
0025000211120030 Fdbpeart   O  A E             DISK
002600021017
0027000211110056 D tna             s              3    inz('TNA')
0028000211110056 D memclass        s                   like(clclass)
0028010507120056 D wkcovtp         s                   like(mcovtp)
0028020507120056 D covlevel        s              1
0029000211130056 D holdmedcov      s              1
0029010507120056 D holdrxcov       s              1
0029020507120056 D holddencov      s              1
0029030507120056 D holdviscov      s              1
0030000211120056 D deprel          s              1
0031000211110056 DKEB              s              3    inz('KEB')
0032000211110056 Dbilldate         s              8
0033000211120056 Ddlname8          s              8
0034000211120056 Ddcovenr          s                   like(denrdt)
0035000211130056 Dtotbil           s              8  2
0036000211130056 Dtotpay           s              8  2
0037000211120056 Dtotrec           s              7  0
0038000211120056 Dtotgrp           s              7  0
0038010507120056 Dparallel         s              1
0039000211120056 Ddbkey            s              9
0040000507120056 D**holdmedpln       s                   like(mcplan)
0041000507120056 D**holdmedenr       s                   like(enrldt)
0042000211120056 Dholdmedgrp       s                   like(psgrp)
0042010507120056 Dholdmedsg        s                   like(pssg)
004300021203
0043010507120055 D                 DS
0043020507120056 D  group#                 1     15
0043030507120056 D** groupid               1      8
0043040507120056 D   group_sg              9     12
0044000212030055 D                 DS
0045000212030056 D  bcefymd                1      8  0
0046000212030056 D  bcefyy                 1      4  0
0047000212030056 D  bcefmm                 5      6  0
0048000212030056 D  bcefdd                 7      8  0
0049000212030055 D                UDS
0050000212030056 D  LEFFDT                85     92  0
0051000211110056 D  LEFmm                 85     86
0052000211110056 D  LEFyy                 89     92
0053000211120053 Idw300r
005400021111     I                                          mcTRST        L2
005500021111     I                                          mcSUB#        L2
005600021112     I                                          acc#          L2
005700021111     I                                          mcssno        L1
0058010507120086 C* on acct change get invoiced date and parallel flag
005900021111     c                   if        *inl2
006000021112     c                   add       1             totgrp
006002050712     c                   clear                   parallel
0060030507120088 C     acckey        chain     accmst
0060040507120096 C                   if        %found(accmst)
006005050712     c                   movel     aprefx        parallel
006006050712     C                   END
006100021111     C                   END
006200021111
0063000211130086 C* on ssn change get member info
006400021111     c                   if        *inl1
006500021113
006600021113     c                   clear                   holdmedcov
006601050712     c                   clear                   holdrxcov
006602050712     c                   clear                   holddencov
006603050712     c                   clear                   holdviscov
006700050712     c**                 clear                   holdmedpln
006800050712     c**                 clear                   holdmedenr
0069000211110088 C     mcssno        chain     member
0070000211110096 c                   if        not %found(member)
007100021112     c                   goto      #end
007200021111     C                   END
007300021113
007400021113     c* get class (all plans should have same class)
007500021113     c                   clear                   memclass
0076000211130088 C     clskey        chain     class
0077000211130096 c                   if        %found(class)
007800021113     c                   move      clclass       memclass
007900021113     C                   end
008000021113
008100021112     C                   END
008200021112
008300021113
0084000211120096 c                   if        not %found(member)
008500021112     c                   goto      #end
008600021112     C                   END
008700021111
008701050712
008702050712      * get Care First coverage level for each plan category
008703050712
008704050712     c     plncat        chain     codesl1
008705050712     c                   if        %found(codesl1)
008706050712
008707050712     c                   move      mcovtp        wkcovtp
008708050712     c                   exsr      #covlevel
008709050712
008710050712     c                   select
008711050712     c                   when      action = 'M'
008712050712     c**                 move      mcplan        holdmedpln
008713050712     c**                 move      enrldt        holdmedenr
008714050712     c                   move      covlevel      holdmedcov
008715050712     c                   exsr      #getgrp
008716050712
008717050712     c                   when      action = 'R'
008718050712     c                   move      covlevel      holdrxcov
008719050712
008720050712     c                   when      action = 'D'
008721050712     c                   move      covlevel      holddencov
008722050712
008723050712     c                   when      action = 'V'
008724050712     c                   move      covlevel      holdviscov
008725050712     c                   endsl
008726050712
008727050712     c                   end
010800021111
010900021112     c     #end          tag
011000021112
011100021112     cL1                 exsr      #L1
011200021112     cLR                 exsr      #LR
011300021113
011301050712
011302050712JGE01C*****************************************************
011303050712      * find coverage level for this coverage type
011304050712JGE01C*****************************************************
011305050712     c     #covlevel     begsr
011306050712
011307050712     c                   clear                   covlevel
011308050712     c                   select
011309050712     c                   when      wkcovtp = 'TFA'
011310050712     c                   move      'A'           covlevel
011311050712     c                   when      wkcovtp = 'THW'
011312050712     c                   move      'B'           covlevel
011313050712     c                   when      wkcovtp = 'TIN'
011314050712     c                   move      'C'           covlevel
011315050712     c                   when      wkcovtp = 'TPC'
011316050712     c                   move      'D'           covlevel
011317050712     c                   other
011318050712     c                   move      'O'           covlevel
011319050712     c                   endsl
011320050712
011321050712     c                   endsr
011322050712
011400021111JGE01C*****************************************************
011500021111JGE01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY or      *
011600021111JGE01C*                 FROM mmddyyyy TO yyyymmdd         *
011700021111JGE01C*****************************************************
011800021111JGE01C     #DAT          BEGSR
011900021111JGE01C                   MOVE      @DATIN        @MD               4 0
012000021111JGE01C                   MOVEL     @DATIN        @Y                4 0
012100021111JGE01C                   MOVEL     @MD           @DATOU            8 0
012200021111JGE01C                   MOVE      @Y            @DATOU
012300021111JGE01C                   MOVE      *ZEROS        @DATIN            8 0
012400021111JGE01C                   ENDSR
012500021111
0126000211120069 C**************************************************************
012700021112JGE01C*   get group # from grate                                   *
0128000211120069 C**************************************************************
012900021112JGE01C     #getgrp       BEGSR
013000021112     c                   clear                   holdmedgrp
013001050712     c                   clear                   holdmedsg
013100021112
013200021112     c     grkey         setll     grate
013300021112     c                   dou       %eof(grate)
013400021112     c     grkey         reade     grate
013500021113     c                   if        not %eof(grate) and (lefymd >= frmdat) and
013600021113     C                             (lefymd <= todat)
013700021112     c                   movel     group#        holdmedgrp
013701050712     c                   movel     group_sg      holdmedsg
013800021112     c                   leave
013900021112     c                   end
014000021112     c                   enddo
014100021112
014200021112JGE01C                   ENDSR
0143000211120069 C**************************************************************
0144000211120069 C* get dependents                                             *
0145000211120069 C**************************************************************
014600021112JGE01C     #getdep       BEGSR
014700021112
014800021112     c     mcssno        setll     depend
014900021112
015000021112     c                   dou       %eof(depend)
015100021112     c     mcssno        reade     depend
015200021112     c                   if        not %eof(depend) and dpdltd = 'A'
015300021112
015400021112     c                   eval      pdrtype = '03'
015500021113     c                   eval      pdgrp   = holdmedgrp
015501050712     c**                 eval      pdsg    = holdmedsg
015502050712
015503050712      * do not send family indicator for parallel groups
015504050712
015505050712     c                   if        parallel = 'Y'
015506050712     c                   clear                   pdfim
015507050712     c                   clear                   pdfir
015508050712     c                   clear                   pdfid
015509050712     c                   clear                   pdfiv
015510050712     c                   else
015511050712     c                   eval      pdfim   = holdmedcov
015512050712     c                   eval      pdfir   = holdrxcov
015513050712     c                   eval      pdfid   = holddencov
015514050712     c                   eval      pdfiv   = holdviscov
015515050712     c                   end
015516050712
015600021112     c                   move      mcssno        pdsid
015700021112     c                   move      depss#        pddid
015800021112     c                   select
015900021112     c                   when      drelcd = 'RWI'
016000021112     c                   move      'W'           deprel
016100021112     c                   when      drelcd = 'RHU'
016200021112     c                   move      'H'           deprel
016300021112     c                   when      drelcd = 'RSO'
016400021112     c                   move      'S'           deprel
016500021112     c                   when      drelcd = 'RDA'
016600021112     c                   move      'D'           deprel
016700021112     c                   other
016800021112     c                   move      'O'           deprel
016900021112     c                   endsl
017000021112     c                   eval      pdrel   = deprel
017100021112
017200021112     c                   movel     dlname        dlname8
017300021112     c                   if        dlname8 = 'SAME    '
0174000211120415 C                   eval      pdlname = mlname
017500021112     c                   else
017600021112     c                   eval      pdlname = dlname
017700021112     c                   end
017800021112
017900021112     c                   eval      pdfname = dfname
018000021112     c                   eval      pdmi    = dmi
018100021112     c                   eval      pdsex   = dsex
018200021112
018300021112     c                   move      dbirth        @datin
018400021112     c                   exsr      #dat
018500021112     c                   move      @datou        pdbirdt
018600021112
019200050712     c**                 exsr      #getdcov
019300050712     c**                 move      dcovenr       @datin
019400050712     c**                 exsr      #dat
019500050712     c**                 move      @datou        pdeffdt
019600050712     c                   clear                   pdeffdt
019700021112
019800050712     c                   eval      pdfill1  = *blanks
019801050712     c                   eval      pdfill2  = *blanks
019802050712     c                   eval      pdfill3  = *blanks
019900021112     c                   eval      pdhold  = 'X'
020000021112
020100021112     c                   write     dbpeardr
020200021112     c                   add       1             totrec
020300021113     c                   clear                   dbpeardr
020400021112
020500021112     c                   end
020600021112
020700021112     c                   enddo
020800021112
020900021112JGE01C                   ENDSR
0210000211120069 C**************************************************************
0211000211120069 C* get dcov enrollment date for medical coverage              *
0212000211120069 C**************************************************************
021300050712JGE01C*    #getdcov      BEGSR
021400021112
021500050712     c*                  clear                   dcovenr
021600050712     c*    depkey        setll     dcovc
021700021112
021800050712     c*                  dou       %eof(dcovc)
021900050712     c*    depkey        reade     dcovc
022000050712     c*                  if        not %eof(dcovc) and ccandt = 0
022100050712     c*                            and dvplan = holdmedpln
022200050712     c*                  eval      dcovenr = denrdt
022300050712     c*                  end
022400050712     c*                  enddo
022500021112
022600050712JGE01C*                  ENDSR
0227000211120069 C**************************************************************
0228000211120069 C* L1 routine                                                 *
0229000211120069 C**************************************************************
023000021112     c     #l1           begsr
023100021113
0232000211130096 c                   if        not %found(member)
023300021113     c                   leavesr
023400021113     C                   end
023500021113
023600021113      * create subscriber reocrd
023700021113     c                   eval      psrtype = '02'
023800021113     c                   eval      psgrp   = holdmedgrp
023801050712     c                   eval      pssg    = holdmedsg
023900021113     c                   move      mcssno        pssid
024000021113     c                   eval      psfill1 = *blanks
024100021113     c                   eval      pslname = mlname
024200021113     c                   eval      psfname = mfname
024300021113     c                   eval      psmi    = mmi
024400021113     c                   eval      pssex   = sex
024500021113     c                   move      birth         @datin
024600021113     c                   exsr      #dat
024700021113     c                   move      @datou        psbirdt
024800021113
024900021113      * enroll date of med plan
025300030321
025400050712     c**                 move      holdmedenr    @datin
025500050712     c**                 exsr      #dat
025600050712     c**                 move      @datou        pseffdt
025700050712     c                   clear                   pseffdt
025800021113
025900021113     c                   eval      psclass = memclass
026000050712     c                   eval      psfim   = holdmedcov
026001050712     c                   eval      psfir   = holdrxcov
026002050712     c                   eval      psfid   = holddencov
026003050712     c                   eval      psfiv   = holdviscov
026100021113     c                   eval      psfill2 = *blanks
026200021113     c                   eval      pshold  = 'X'
026300021113
026400021112     c                   write     dbpearsr
026500021112     c                   add       1             totrec
026600021113     c                   clear                   dbpearsr
026700021113
026800021113      * dependent records
026900021113     c                   exsr      #getdep
027000021113
027100021112JGE01C                   ENDSR
0272000211120069 C**************************************************************
0273000211120069 C* LR routine                                                 *
0274000211120069 C**************************************************************
027500021112     c     #LR           begsr
027600021112      * trailer rec
027700021112     c                   eval      ptrtype  = '04'
027800021112     c                   eval      ptfill   = *blanks
027900021112     c                   eval      pthold   = 'X'
028000021121     c**                 add       1             totrec
028100021112     c                   eval      pttotrec = %editc(totrec : '3')
028200021112     c                   eval      pttotgrp = %editc(totgrp : '3')
028300021112     c                   write     dbpeartr
028400021112
028500021112JGE01C                   ENDSR
0286000211110069 C**************************************************************
0287000211110069 C* first time                                                 *
0288000211110069 C**************************************************************
028900021111     c     *inzsr        begsr
029000030325     c     *ENTRY        plist
029100030325     C                   parm                    batchid
029200030325
029300021111     C                   TIME                    HTIME             6 0
029400021113     c                   move      htime         fulltime         14 0
029500021113     C                   movel     *date         fulltime
029600021111     c* create batch id - YYMMDDHHMM
029700021112     C                   movel     htime         HTIMEhm           4 0
029800021112     C                   MOVE      *date         @DATIN
029900021112     C                   EXSR      #DAT
030000021112     C                   MOVE      @DATOU        ud8ymd            8 0
030100021111     c                   move      ud8ymd        ud6ymd            6 0
030200021111     c                   movel     ud6ymd        batchid          10
030300021111     c                   move      htimehm       batchid
0304000211110111 C*
030500021111     C                   MOVE      LEFFDT        @DATIN
030600021111     C                   EXSR      #DAT
030700021111     C                   MOVE      @DATOU        LEFYMD            8 0
030800021111
030900021111     C     INKEY         KLIST
031000021111     C                   KFLD                    mctrst
031100021111     C                   KFLD                    mcsub#
031200021112     C                   KFLD                    acc#
031300021111     C                   KFLD                    lefymd
031400021111     C                   KFLD                    KEB
031401050712
031402050712     C     acckey        KLIST
031403050712     C                   KFLD                    mctrst
031404050712     C                   KFLD                    mcsub#
031405050712     C                   KFLD                    acc#
031500021111
031600021112     C     depkey        KLIST
031700021112     C                   KFLD                    mcssno
031800021112     C                   KFLD                    dpseq#
031900021112
032000021112     C     plnkey        KLIST
032100021112     C                   KFLD                    mctrst
032200021112     C                   KFLD                    mcsub#
032300021112     C                   KFLD                    mcplan
032400021112
032500021112     C     grkey         KLIST
032600021112     C                   KFLD                    mctrst
032700021112     C                   KFLD                    mcsub#
032800021112     C                   KFLD                    mcplan
032900021112     C                   KFLD                    mcageb
033000021112     C                   KFLD                    mcovtp
033100021112
033200021112     C     clskey        KLIST
033300021111     C                   KFLD                    mctrst
033400021111     C                   KFLD                    mcsub#
033500021111     C                   KFLD                    mcplan
033600021111     C                   KFLD                    tna
033700021111
033800021111      * create header record
033900021111
034000021111     c                   eval      phrtype = '01'
034100021111     c                   eval      phver   = '001'
034200021112     c                   movel     fulltime      phcdt
034300021111     c                   eval      phdbid  = '521200892'
034400021111     c                   eval      phdbnm  = 'GBS, INC.'
034500021111     c                   eval      phbatch = batchid
034600021112     c                   eval      phbp    = lefmm + lefyy
034700030306     c                   eval      phtype  = 'G'
034800021111     c                   eval      phfill  = *blanks
034900021111     c                   eval      phhold  = 'X'
035000021111     c                   write     dbpearhr
035100021121     c**                 add       1             totrec
035200021111
035300021111     c                   endsr
