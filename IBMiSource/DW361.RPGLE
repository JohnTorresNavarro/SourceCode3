000100180927     h option(*noDebugIo)
0002009102150002 F******************************************************************
0003000503160003 F* dw361      GROUP BENEFIT SERVICES SOFTWARE                     *
0004000503160004 F*               David Ketterman - 03/16/2005                     *
0005009102150013 F*                                                                *
0006000503160014 F*  DESCRIPTION - THIS PROGRAM WILL READ "TRNMIT" & CREATE term   *
0007000503160015 F*                TRANSACTIONs for the dentaquest file.           *
0008000405250017 F*                                                                *
0009000803140017 F* 03/14/08 dlk - change to skip "AC" / cancelled account terms   *
001000000113     F*                                                                *
0011000810290017 F* 10/29/08 jon - trnmit update (recompile)                       *
001200110324      * 03/24/11 dlk - Add coverage type P2 to the xref so it is       *
001300110324      *                converted to the same DQ coverage as PC.        *
001400110324      *                This was a request by Carol F because Kelly     *
001500110324      *                Dixon sold something not available to DQ.       *
001600140613      * 06/13/14 dlk - request from Deborah Clark & Brandon - omit account
001700140613      *                591-7-359 group # 0260405401 from the file
001800140703      * 07/03/14 dlk - skip of certain term codes changed from hard coded
001900140703      *                list to use action code in codes file.
002000150420      * 04/20/15 DLK - add new shop carrier group code to selection
002100150512      * 05/12/15 DLK - skip trust 888 (test trust) and flag trnmit rec
002200150512      *                as not processed
002300161214      * 12/14/16 DLK - Add carrier group codes DO and S3
002400180927      * 09/25/18 J.Torres - Eliminated hardcoding of accounts not to send.
002500180927      *                     Please call program TROFFCL to add or remove
002600180927      *                     Accounts not to send.
002700210421      * 04/21/21 DLK - Skip Subsidy plans
002800161214      *
002900161214      *  ****************************************************************
003000161214      *  *         **** IMPORTANT NOTE ***                              *
003100161214      *  * Any changes to the carrier group codes MUST also be made     *
003200161214      *  * in DW360CL.                                                  *
003300161214      *  ****************************************************************
0034009102150018 F******************************************************************
0035000503160019 Ftrnmitl2  up   E             DISK
0036000203260024 Fmember    IF   E           K DISK    prefix(m_)
0037000503160024 Fcarmst    IF   E           K DISK    prefix(c_)
0038000503170020 Fdqmeml1   if   e           k DISK    prefix(d_) rename(dqmemr:dqrl1)
0039001407030024 Fcodes     If   e           k disk    prefix(co_)
0040002104210024 Fplnmst    If   e           k disk    prefix(p_)
0041000503170020 Fdqmem     O  A e             DISK
004200180927     ftransoff1 if   e           k disk    rename(transr:transFile)
0043000203010025
0044000405260037 D workdt          S               d   datfmt(*iso)                         YMD
004500050316     D POS             S              2  0
004600050316     D grpcod15        S             15
004700050316     D grpcod10        S             10
004800050316     D workdt80        S              8  0
004900050316     D goodl1          S              1
005000050317     D skipthisrec     S              1
005100050316     D h_cancdt        S                   like(cancdt)
005200050316     D h_enrldt        S                   like(enrldt)
005300050316     D h_mcvtyp        S                   like(mcvtyp)
005400140703     d codetype        s              1    inz('D')
005500040806
0056009102150029 I*
0057009709220030 ITRNMIR
005800970917     I              COB                         COB2
005900970922     I              SOCSOC                      SSN
006000050316     I                                          ssn           l1
006100050316     I                                          group#        l1
0062000203010313
006300050316     c                   if        *inl1
006400050316     c                   clear                   goodl1
006500050316     c                   clear                   h_cancdt
006600050316     c                   clear                   h_enrldt
006700050316     c                   clear                   h_mcvtyp
006800050316     c                   end
006900050316
007000150420      * select dentaquest carrier group codes
007100161215      * *****************************************************************
007200161215      * ** Any changes to the carrier group codes MUST also be made     *
007300161215      *    in DW360CL.                                                  *
007400161215      * *****************************************************************
007500050316     c     carcod        chain     carmst
007600050316     c                   if        not %found(carmst) or
007700161214     c                             (c_cgrpcd <> 'DQ' and c_cgrpcd <> 'SD' and
007800161214     c                              c_cgrpcd <> 'DO' and c_cgrpcd <> 'S3')
007900050316     c                   goto      #end
008000050316     c                   end
008100050316
008200080314      * process member terms
008300080314     c                   if        actcod = 'MT'
008400080314
008500140703      * see if this transaction should be skipped (action code in codes
008600140703      * file for term codes = N when it should not be sent)
008700140703     c                   clear                   skipthisterm      1
008800140703     c                   if        termin <> *blanks
008900140703     c     codekey       chain     codes
009000140703     c                   if        %found(codes) and co_action = 'N'
009100140703     c                   eval      skipthisterm = 'Y'
009200140703     c                   end
009300140703     c                   end
009400150512
009500150512      * 5/12/15 - skip trust 888 (test trust)
009600150512     c                   if        trust = 888
009700150512     c                   eval      skipthisterm = 'Y'
009800150512     c                   end
009900140703
010000210421      * skip Subsidy plans
010100210421     c     plankey       chain     plnmst
010200210421     c                   if        %found(plnmst) and p_sfadm = 'Y'
010300210421     c                   eval      skipthisterm = 'Y'
010400210421     c                   end
010500210421
010600140703     c                   if        skipthisterm <> 'Y'
010700050316     c                   eval      goodl1 = 'Y'
010800050316     c                   move      cancdt        h_cancdt
010900050316     c                   move      enrldt        h_enrldt
011000050316     c                   move      mcvtyp        h_mcvtyp
011100050317     C                   MOVE      UD8YMD        TXMTDT
011200050317     C                   MOVE      'X'           DLTCOD
011300050318      *** nu1 = testing (no trnmit update)
011400050318     c   u1              update    trnmir
011500150512      * this term code was not transmittable or the trust is 888 - do NOT
011600150512      * process and flag as such
011700080314     c                   else
011800080314     C                   MOVE      *zeros        TXMTDT
011900080314     C                   MOVE      'D'           DLTCOD
012000080314     c   u1              update    trnmir
012100050316     c                   end
012200080314
012300080314     c                   end
012400050316
012500050316     c     #end          tag
012600050316     cl1                 if        goodl1 = 'Y'
012700050316     cl1                 exsr      #l1tot
012800050316     cl1                 end
012900050316
0130000503161118  *******************************************************************
013100050316      *
0132000503161118  *******************************************************************
0133000503161120 C     #l1tot        BEGSR
0134000503160289 C* clear output fields
013500050316     c                   clear                   dqmemr
013600050316
013700050316     c                   exsr      #memfields
013800050316
013900050317      * write term if ssn/group was not found in dqmeml1
014000050317
014100050317     c                   if        skipthisrec = ' '
014200050316     C                   write     dqmemr
014300050317     c                   end
014400050317
014500050316     c                   clear                   dqmemr
014600050316
0147000503161120 C                   endsr
014800040526
0149000405261118 C*******************************************************************
0150000503161119 C* fill member fields
0151000405261117
0152000405261120 C     #memfields    BEGSR
015300040526
015400050317     c                   clear                   skipthisrec
015500050317
015600050316     c     ssn           chain     member
015700050316     c                   if        not %found(member)
015800050317     c                   eval      skipthisrec = 'Y'
015900050317     c                   leavesr
016000050316     c                   end
016100140613
016200140613     ***********************************************
016300140613      * 6/13/14 - request by deb C and brandon - skip acct 591-7-359
016400180927       exsr checkTransmission;
016500180927       if skipthisrec = 'Y';
016600180927        leavesr;
016700180927       endif;
016800180927     c****               if        m_mbtrst = 591 and m_mbsub# = 7 and
016900180927     c****                         m_mbacct = 359
017000180927     c****               eval      skipthisrec = 'Y'
017100180927     c****               leavesr
017200180927     c****               end
017300140613     ***********************************************
017400140613
0175000503160606 C                   MOVE      SSN           dqmsubid
0176000503160411 C                   MOVEL     GROUP#        grpcod15
017700050316     c                   exsr      #group
017800050317
017900050317      * if this ssn/group exists in the active member file it has been
018000050317      * reinstated since the term so we do not want to send the term
018100050317
018200050317     c     dqmkey        chain     dqmeml1
018300050317     c                   if        %found(dqmeml1)
018400050317     c                   eval      skipthisrec = 'Y'
018500050317     c                   leavesr
018600050317     c                   end
018700050317
018800050316      * coverage type
018900110324      * 03/24/11 add P2 cov same as PC
019000050316     C                   SELECT
019100050316     C                   WHEN      h_mcvtyp = 'TIN'
019200050316     C                   EVAL      dqmcov = '1'
019300050316     C                   WHEN      h_mcvtyp = 'THW'
019400050316     C                   EVAL      dqmcov = '2'
019500110324     C                   WHEN      h_mcvtyp = 'TPC' or h_mcvtyp = 'TP2'
019600050316     C                   EVAL      dqmcov = '3'
019700050316     C                   WHEN      h_mcvtyp = 'TFA'
019800050316     C                   EVAL      dqmcov = '4'
019900050316     C                   ENDSL
020000050316
020100050316      * use most current info (from member file)
020200050316
0203000503160445 C                   MOVEL     m_ADDR1       dqmaddr1
0204000503160445 C                   MOVEL     m_ADDR2       dqmaddr2
0205000503160446 C                   MOVEL     m_CITY        dqmcity
0206000503160447 C                   MOVE      m_STATE       dqmst
0207000503160448 C                   MOVEL     m_ZIP         ZIP5              5 0
0208000503160448 C                   MOVE      m_ZIP         ZIP4              4 0
020900050316     c                   if        zip4 = 0
021000050316     c                   movel     zip5          dqmzip
021100050316     c                   else
021200050316     c                   movel     m_zip         dqmzip
021300050316     c                   end
021400050316
0215000503160414 C                   MOVEL     m_mFNAME      dqmfname
0216000503160415 C                   MOVEL     m_mLNAME      dqmlname
0217000503160416 C                   MOVE      m_mMI         dqmmi
021800050316     C                   MOVE      m_SEX         dqmsex
021900040526
022000050316     C                   move      m_birth       dqmdob
022100040526
022200050316     c                   move      m_empdt       dqmdoh
022300050316     C                   MOVE      h_ENRLDT      dqmeff
022400040526
022500040826      * minus 1 day
022600040827     C                   clear                   workdt
022700050316     C                   clear                   workdt80
022800050316     C                   clear                   dqmcan
022900050316     c                   if        h_cancdt <> 0
023000050316     C                   move      h_cancdt      workdt
023100050316     c                   if        h_cancdt <> h_enrldt
023200040826     c                   exsr      #minus1day
023300040826     c                   end
023400050316     C                   MOVE      workdt        workdt80
023500050316     C                   MOVE      workdt80      dqmcan                         MDY
023600040526     c                   end
023700040526
023800050316     c* relation code : 1 = subscriber
023900050316     c                   move      '1'           dqmrel
024000050317     c                   move      'X'           dqmfil1
024100050316
0242000405261120 C                   endsr
024300040526
0244000212160819 C*******************************************************************
0245000212160820 C* subtract 1 day
0246000212160819 C*******************************************************************
0247000408260821 C     #minus1day    BEGSR
024800040826     c                   subdur    1:*d          workdt
0249000408260831 C                   ENDSR
0250000212161117
0251000503160103 C***************************************************
0252000503160104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0253000503160104 C* or FROM MMDDYYYY TO YYYYMMDD                    *
0254000503160105 C***************************************************
0255000503160107 C* DATE IN  = @DATIN (8.0)
0256000503160107 C* DATE OUT = @DATOU (8.0)
0257000503160107
0258000503160106 C     #DATYM        BEGSR
025900050316     C                   MOVE      @DATIN        @MD               4 0
026000050316     C                   MOVEL     @DATIN        @Y                4 0
026100050316     C                   MOVEL     @MD           @DATOU            8 0
026200050316     C                   MOVE      @Y            @DATOU
026300050316     C                   MOVE      *ZEROS        @DATIN            8 0
0264000503160120 C                   ENDSR
026500050316
0266000503160103 C***************************************************
026700050316     c* remove dash from group # if one exists          *
0268000503160105 C***************************************************
026900050316     C     #group        begsr
0270000405260107
027100050316     c                   Eval      pos = %scan('-':grpcod15)
027200050316
027300050316     c                   if        pos = 0
027400050316     c                   eval      grpcod10 = %trim(grpcod15)
027500050316     c                   else
027600050316     C                   eval      grpcod10 = (%subst(grpcod15:1:pos-1)) +
027700050316     C                             (%subst(grpcod15:pos+1:15-pos))
027800050316     C                   end
027900050316
028000050316     C                   eval      dqmgrp = (%subst(grpcod10:1:6))
028100050316     C                   eval      dqmsec = (%subst(grpcod10:7:4))
028200050316
028300050316     c                   endsr
028400180927      //========================================================================
028500180927      // check for transmission
028600180927      //========================================================================
028700180927
028800180927       begsr checkTransmission;
028900180927
029000180927        chain (14 : m_mbtrst : m_mbsub# : m_mbacct) transFile;
029100180927        if %found;
029200180927         skipthisrec = 'Y';
029300180927        endif;
029400180927
029500180927       endsr;
029600180927
029700180927      //========================================================================
0298000503161279 C*---------- FIRST CYCLE  --------------------------------------*
0299000503161280
030000050316     C     *INZSR        BEGSR
0301000503160271
030200050316     C                   MOVE      *DATE         @DATIN
030300050316     C                   EXSR      #DATYM
030400050316     C                   MOVE      @DATOU        UD8YMD            8 0
030500050317
030600050317     c     dqmkey        klist
030700050317     c                   kfld                    dqmsubid
030800050317     c                   kfld                    dqmgrp
030900050317     c                   kfld                    dqmsec
031000140703
031100140703     C     codekey       KLIST
031200140703     C                   KFLD                    codetype
031300140703     C                   KFLD                    termin
031400140703
031500210421     C     plankey       KLIST
031600210421     C                   KFLD                    trust
031700210421     C                   KFLD                    subno
031800210421     C                   KFLD                    plan#
031900050316
032000050316     C                   ENDSR
