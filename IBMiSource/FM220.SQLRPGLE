000100040730     H
0002009102150002 F******************************************************************
0003000004140003 F* FM220      GROUP BENEFIT SERVICES SOFTWARE           1988      *
0004009102150004 F*                                                                *
0005009102150005 F*            WRITTEN BY - MICHAEL C. DUNPHY                      *
0006009102150006 F*            DATE - 06/02/88                                     *
0007009102150007 F*                                                                *
0008009102150008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE      *
0009009102150009 F*            CODES FILE (ADD CHANGE DELETE). THE TYPE AND        *
0010009102150010 F*            DESCRIPTION FOR THE CODE TYPE ARE IN LDA.           *
0011009102150011 F*                                                                *
0012000408030011  * 08/03/04 dlk - convert to RPGLE and add plan category type     *
0013000602100011  * 02/10/06 dlk - add plan cat seq for excel inv                  *
0014000603290011  * 03/29/06 SSK - ADDED "KTYPE = 'P'" TO FILTER OUT NON-P TRANSX  *
0015001409240011  * 09/24/14 dpb - resequence file PCSEQ (in intervals of 50) if   *
0016001409240011  *                any changes made to PLNCAT code records.        *
0016011606200011  * 06/20/16 dlk - add maintenance of action 2 field (ACTN2) for   *
0016021606200011  *                use as the acct or member indicator for term    *
0016031606200011  *                codes to begin with, but can be used for other  *
0016041606210011  *                codes. Also add code display window SF03.       *
0017009102150012 F******************************************************************
0018009102150013 F*                                                                *
0019001409240014 Ffm220fm   cf   e             WORKSTN infds(dspf_infds)
002000040803     F                                     SFILE(SF01:RRN)
002100060210     F                                     SFILE(SF02:RR2)
002101160621     F                                     SFILE(SF03:RR3)
0022000407300015 FCODES     UF A e           k DISK
0023000602130015 FCODESl1   iF   e           k DISK    rename(codesr:codesrl1) prefix(z)
0024000407300015 Fpctmst    if   e           k DISK
0025001409240015 Fpcseq     uf a e           k DISK
0026001409240015 Fpcseql1   uf   e           k DISK    rename(pcseqr:pcsseql1r) prefix(x)
002700140924
002800140924     D quilngtx        PR                  ExtPgm('QUILNGTX')
002900140924     D  text                        500a   const options(*Varsize)
003000140924     D  length                       10i 0 const
003100140924     D  msgid                         7a   const
003200140924     D  qualmsgf                     20a   const
003300140924     D  errorCode                     8a   const
003400140924
003500140924     D errorcode       s              8
003600140924     D text            s            500
003700140924     D msgid           s              7
003800140924     D msgdta          s            100
003900140924
0040001606200016 D MSG             S             45    DIM(8) CTDATA PERRCD(1)              ERROR MESSAGE ARRAY
004100040803     d rrn             s              5  0
004200060210     d rr2             s              5  0
004201160621     d rr3             s              5  0
004300140924     D resequence_flg  s              1
004400140924     D start_seq       s                   like(pcsseq)
004401160621     D code_h          s                   like(code)
004500140924
004600140924      *?File Information data structures
004700140924     d dspf_infds      ds
004800140924     d  stdfil                83     92
004900140924     d  function_key         369    369
005000140924
0051000602100045 D                 DS
0052000602100046 D  pcskey                 1      3
0053000602100046 D  ktype                  1      1
0054000602100046 D  code                   2      3
005500140924
0056000602100044 D* LDA CODE TYPE AND DESCRIPTION
0057000602100045 D                UDS
0058001606210046 D  ltype                  1      1
0059009102150047 D  TYPDSC                 2     31
0060009102150048 D  ACTDSC                32     51
0061009102150049 D  LCOMP1                52     52
0062009102150050 D  LCOMP2                53     53
0063009102150051 D  LCOMP3                54     54
0064009102150052 D  LCOMP4                55     55
0065009102150053 D  LCOMP5                56     56
0065021606200048 D  ACT2DES               60     79
0065031606200049 D  L2COMP1               80     80
0065041606200050 D  L2COMP2               81     81
0065051606200051 D  L2COMP3               82     82
0065061606200052 D  L2COMP4               83     83
0065071606200053 D  L2COMP5               84     84
0066009102150054 D  TITLE                201    240
006700140924
006800140924      /copy qcpysrc,FKEYS_ILE
006900040730
007000140924     c                   dow       *inkg = *off and function_key <> #f3
0071009102150063 C*
0072009102150064 C*  SET OF OUTPUT AND FIELD HIGHLIGHT INDICATORS
0073000602140065 C                   clear                   msgout2
007400040730     c                   exfmt     io01
007500040730
0076000407300066 C                   SETOFF                                       711231
0077000407300067 C                   SETOFF                                       816162
0078001606210068 C                   SETOFF                                       648983
0079000407300071
0080000407300070 C*  ON CMD 7 END
008100140924     c                   if        *inkg or function_key = #f3
0082000407300073 C                   SETON                                        LR
008300040803     c                   leave
008400040730     c                   end
008401160621
0084021606210070 C* F6 - display codes window
008403160621     c                   if        *inkf
0084041606210073 C                   exsr      #dspcodes
008405160621     c                   iter
008406160621     c                   end
008407160621
008500040730
0086000407300092 C*  CHECK TO SEE IF CODE # IS BLANK
0087000407300094 C                   if        code = *blanks
0088000407300095 C                   seton                                        71
008900040730     c                   move      msg(1)        msgout1
009000040730     c                   iter
009100040730     c                   end
009200040730
009300040730     c                   clear                   deleted           1
009400040803     c                   move      code          codehld           2
009500040803
0096000407300098 C*  GET RECORD IF IT IS ON FILE  - BLANK FIELDS IF NOT ON FILE
0097000407300100 C     codkey        CHAIN     CODES
009800040730     c                   if        not %found(codes)
0099000407300101 C                   clear                   codesr
010000040803     c                   move      codehld       code
010100040730
010200040730     c                   else
0103000407300106 C*  CHECK FOR DELETED RECORD - 89 ON BLOCKS UPDATE OF deleted rec
0104000407300108 C                   if        cddltd = 'D'
010500040730     c                   eval      *in89 = *on
010600040730     c                   eval      deleted = 'Y'
0107000407300109 C                   Z-ADD     3             X                 1 081
010800040803     c                   move      msg(x)        msgout2
010900040730     c                   end
011000040730     c                   end
011100060210
011200060210      * if plan cat = 'P', get seq
011300060210     c                   clear                   scolseq
011400060210     c                   if        ktype = 'P'
0115000602100100 C     pcskey        CHAIN     pcseq
011600060210     c                   if        %found(pcseq)
011700060210     c                   move      pcsseq        scolseq
011800060210     c                   end
011900060210     c                   end
012000040730
012100040730     c     #t0020        tag
012200040730
012300040803      * display plan cat input
012400040803     c                   if        ktype = 'P'
012500040803     c                   eval      *in91 = *off
012600040803     c                   eval      *in92 = *on
012700060213      * 96 = f8 - show type window, f9 - show seq window, show seq
012800040803     c                   eval      *in96 = *on
012900040803     c                   else
013000040803     c                   eval      *in96 = *off
013100040803     c                   end
013200040803
013300040803      * show screen 2
013400040730     c                   exfmt     io02
013500040803     c                   setoff                                       81
0136000407300070 C*  ON CMD 1 return
013700040730     c                   if        *inka
013800040730     c                   unlock    codes
013900040730     c                   setoff                                       81
014000060329     c                   if        %found(pcseq) AND KTYPE = 'P'
014100060210     c                   unlock    pcseq
014200060210     c                   end
014300040730     c                   iter
014400040730     c                   end
0145000408030070 C*  ON CMD 7 END
014600140924     c                   if        *inkg or function_key = #f3
0147000408030073 C                   SETON                                        LR
014800040803     c                   leave
014900040803     c                   end
015000040730
0151000408030070 C* F8 - display type window
015200040803     c                   if        *inkh
0153000408030073 C                   exsr      #dsptyp
015400040803     c                   goto      #t0020
015500040803     c                   end
015600040803
0157000602100070 C* F9 - display seq window
015800060210     c                   if        *inki
0159000602100073 C                   exsr      #dspseq
016000060210     c                   goto      #t0020
016100060210     c                   end
016200060210
0163000407300128 C* can not update deleted rec
016400040803     c                   if        deleted = 'Y' and *inkf = *off
016500040730     c                   goto      #t0020
016600040730     c                   end
016700040730
0168000407300128 C* EXECUTE EDIT ROUTINE
0169000407300130 C                   EXSR      #EDIT
017000040730
017100040730     c                   clear                   msgout2
0172000407300132 C* REDISPLAY SCREEN IF ERROR
017300040730     c                   if        *in81 = *on
017400040730     c                   move      msg(x)        msgout2
017500040730     c                   goto      #t0020
017600040730     c                   end
017700040730
017800040730      * update / add
017900040730      * F4 - delete
018000040730      * F6 - reinstate
018100040730     c                   if        %found(codes)
018200040730     c   kd              move      'D'           cddltd
018300040730     c   kf              move      'A'           cddltd
018400040730     c                   update    codesr
018500040730     c                   else
018600040730     c                   move      'A'           cddltd
018700040803     c                   move      ktype         type
018800040730     c                   write     codesr
018900040730     c                   end
0190000602100079 C* update seq file
019100060329     c                   if        KTYPE = 'P'
019200140924     C                   eval      resequence_flg = 'Y'
019300140924      * if user is deactivating a plan category record - delete the
019400140924      * sequence record from PCSEQ.....they will be forced to create a new
019500140924      * one if they reactivate the plan cat.
019600140924     C                   if        function_key = #f4
019700140924     C                   delete    pcseqr
019800140924     C                   else
019900060210     c                   move      scolseq       pcsseq
020000060210     c                   if        %found(pcseq)
020100060210     c                   update    pcseqr
020200060210     c                   else
020300060210     c                   move      pcskey        pcspcat
020400060210     c                   write     pcseqr
020500140924     c                   endif
020600140924     c                   endif
020700140924     c                   endif
020800060210
020900040730     c                   enddo
021000040730
021100140924       if resequence_flg = 'Y' ;
021200140924        exsr resequence ;
021300140924       endif ;
021400140924
0215009102150144 C****************************************************************
0216009102150145 C*
0217009102150146 C*----------------------- EDIT ---------------------------------*
0218001606200147 C*                                                                    +
0219009102150148 C     #EDIT         BEGSR
022000060214     c                   eval      *in81 = *off
0221009102150149 C*
0222009102150150 C* VALIDATE ACTION FLAG IF U1 IS ON
0223009102150151 C*
022400040730     c                   if        *inu1 and
022500160620     c                             (action <> lcomp1 and action <> lcomp2 and
022600160620     c                              action <> lcomp3 and action <> lcomp4 and
022700160620     c                              action <> lcomp5)
0228000407300157 C                   Z-ADD     4             X                    81
022900040730     c                   end
0229011606200149 C*
0229021606200150 C* VALIDATE ACTION 2 FLAG IF U2 IS ON
0229031606200151 C*
022904160620     c                   if        *inu2 and
022905160620     c                             (actn2 <> l2comp1 and actn2 <> l2comp2
022906160620     c                              and actn2 <> l2comp3 and actn2 <> l2comp4
022907160620     c                              and actn2 <> l2comp5)
0229081606200157 C                   Z-ADD     8             X                    81
022909160621      * 83 = position cursor and reverse image
0229101606210157 C                   eval      *in83 = *on
022911160620     c                   end
0230009102150158 C*
0231009102150159 C* CHECK FOR REQUIRED FIELDS LEFT BLANK
0232009102150160 C*
023300040730     c                   if        sdescr = *blanks
0234000407300163 C                   SETON                                        61
0235000407300162 C                   Z-ADD     2             X                    81
023600040730     c                   end
023700040730
023800040730     c                   if        ldescr = *blanks
0239000407300163 C                   SETON                                        62
0240000407300165 C                   Z-ADD     2             X                    81
024100040730     c                   end
0242009102150166 C*
0243000602100166 C* edit plan category type and seq when "P" prefix
0244000407300166 C*
024500040730     c                   if        ktype = 'P'
0246000407300100 C     action        chain     pctmst
024700040730     c                   if        not %found(pctmst)
0248000407300162 C                   Z-ADD     5             X                    81
0249000602100162 C                   leavesr
025000040730     c                   end
0251000602100100 C                   if        scolseq = *zeros
0252000602100162 C                   Z-ADD     6             X                    81
0253000602100162 C                   leavesr
025400060210     c                   end
025500060210      * look for dup seq
0256001409240100 C     scolseq       chain(n)  pcseql1
025700060210     c                   if        %found(pcseql1) and xpcspcat <> pcskey
0258000602100162 C                   Z-ADD     7             X                    81
0259000602100162 C                   leavesr
026000060210     c                   end
026100060210
026200040730     c                   end
026300040730
0264009102150167 C                   ENDSR
0265000408030147  *********************************
0266000408030147  * display category type window
0267000408030147  *********************************
0268000408030148 C     #dsptyp       BEGSR
026900040803
027000040803     C* CLEAR SUBFILE
027100040803     C                   MOVEA     '001'         *IN(40)
027200040803     C                   WRITE     SF01CTL
027300040803     C                   eval      *IN42 = *off
027400040803     C*
027500040803     C* BUILD SUBFILE
027600040803     C*
027700040803     C                   clear                   RRN
027800040803     C     *loval        SETLL     pctmst
027900040803     C                   dou       %eof(pctmst)
028000040803     C                   READ      pctmst                                 41
028100040803     C                   if        not %eof(pctmst)
028200040803     C                   ADD       1             RRN
028300040803     c                   move      pccode        x1
028400040803     c                   movel     pcdes         x2
028500040803     C                   WRITE     SF01
028600040803     C                   iter
028700040803     C                   END
028800040803     C                   ENDDO
028900040803
029000040803     C* DISPLAY SUBFILE IN WINDOW
029100040803     C                   if        rrn > 0
029200040803     C                   eval      *in40 = *on
029300040803     C                   END
029400040803     C*
029500040803     C                   WRITE     WINDOW
029600040803     C                   EXFMT     SF01CTL
029700040803
0298000408030167 C                   ENDSR
029900060210
0299011606210147  *********************************
0299021606210147  * display codes window
0299031606210147  *********************************
0299041606210148 C     #dspcodes     BEGSR
029905160621
029906160621      * hold code
029907160621     c                   move      code          code_h
029908160621
029909160621     C* CLEAR SUBFILE
029910160621     C                   MOVEA     '001'         *IN(30)
029911160621     C                   WRITE     SF03CTL
029912160621     C                   eval      *IN32 = *off
029913160621     C*
029914160621     C* BUILD SUBFILE
029915160621     C*
029916160621     C                   clear                   RR3
029917160621     C     ktype         SETLL     codes
029918160621     C                   dou       %eof(codes)
029919160621     C     ktype         READe(n)  codes                                  31
029920160621     C                   if        not %eof(codes)
029921160621     C                   ADD       1             RR3
029922160621     c                   move      code          x3
029923160621     c                   movel     ldescr        x3d
029924160621     c                   movel     cddltd        x3stat
029925160621     C                   WRITE     SF03
029926160621     C                   iter
029927160621     C                   END
029928160621     C                   ENDDO
029929160621
029930160621     C* DISPLAY SUBFILE IN WINDOW
029931160621     C                   if        rr3 > 0
029932160621     C                   eval      *in30 = *on
029933160621     C                   END
029934160621     C*
029935160621     C                   WRITE     WINDOW3
029936160621     C                   EXFMT     SF03CTL
029937160621
029938160621     c                   move      code_h        code
0299391606210167 C                   ENDSR
029940160621
030000060210
0301000602100147  *********************************
0302000602100147  * display existing sequence set up
0303000602100147  *********************************
0304000602100148 C     #dspseq       BEGSR
030500060210
030600060210     C* CLEAR SUBFILE
030700060210     C                   MOVEA     '001'         *IN(50)
030800060210     C                   WRITE     SF02CTL
030900060210     C                   eval      *IN52 = *off
031000060210     C*
031100060210     C* BUILD SUBFILE
031200060210     C*
031300060210     C                   clear                   rr2
031400060210     C     *loval        SETLL     pcseql1
031500060210     C                   dou       %eof(pcseql1)
031600140924     C                   READ(n)   pcseql1                                51
031700060210     C                   if        not %eof(pcseql1)
031800060213     c                   clear                   x20
031900060210     C                   ADD       1             rr2
032000060210     c                   move      xpcsseq       x10
032100060213     c                   move      xpcspcat      work2             2
032200060213     c                   movel     work2         x20
0323000602130100 C     xpcspcat      CHAIN     codesl1
032400060213     c                   if        %found(codesl1)
032500060213     c                   cat       '-':0         x20
032600060213     c                   cat       zldescr:0     x20
032700060213     c                   end
032800060210     C                   WRITE     SF02
032900060210     C                   iter
033000060210     C                   END
033100060210     C                   ENDDO
033200060210
033300060210     C* DISPLAY SUBFILE IN WINDOW
033400060210     C                   if        rr2  > 0
033500060210     C                   eval      *in50 = *on
033600060210     C                   END
033700060210     C*
033800060210     C                   WRITE     WINDOW2
033900060210     C                   EXFMT     SF02CTL
034000060210
0341000602100167 C                   ENDSR
034200040803
0343000408030147  *********************************
0344000407300148 C     *inzsr        BEGSR
034500040730
0346001606210059 C                   MOVE      ltype         KTYPE             1
0347000407300060 C   U1              SETON                                        1192
0348000407300061 C  NU1              SETON                                        1191
034801160620
034802160620      * u2 / 82 = action 2 field is used - show on screen and edit
034803160620      * (*in82 off protects the field from entry)
034804160620     c                   if        *inu2 = *on
034805160620     c                   eval      *in82 = *on
034806160620     c                   end
034900040803
035000040730     c     codkey        klist
035100040730     c                   kfld                    ktype
035200040730     c                   kfld                    code
0353000407300167 C                   ENDSR
035400140924       //-------------------------------------------------------------------
035500140924       // resequence:  resequence records so that each record is a multiple
035600140924       // of 10.  Initially set the current sequence to it's negative value
035700140924       // so that we won't re-read the record when giving it a true seq #.
035800140924       //-------------------------------------------------------------------
035900140924       begsr resequence ;
036000140924
036100140924        text ='Please wait while plan categories are re-sequenced ' +
036200140924              '(in multiples of 50)' ;
036300140924        quilngtx(text:%len(text):*blanks:*blanks:errorcode) ;
036400140924
036500140924        exec sql update pcseql1 set pcsseq = -pcsseq with nc ;
036600140924
036700140924        start_seq = 50 ;
036800140924        setll *hival pcseql1 ;
036900140924
037000140924        dou %eof(pcseql1) ;
037100140924         readp pcseql1 ;
037200140924
037300140924         if %eof (pcseql1) ;
037400140924          leave ;
037500140924         endif ;
037600140924
037700140924         xpcsseq = start_seq ;
037800140924         update pcsseql1r %fields(xpcsseq) ;
037900140924         start_seq += 50 ;
038000140924
038100140924        enddo ;
038200140924
038300140924       endsr ;
038400140924
038500910215**
038600910215 ** BLANK CODE IS INVALID               - **
038700910215 ** ENTER REQUIRED DESCRIPTIONS           **
038800910215 ** DELETED RECORD - CMD6 TO REACTIVATE - **
038900910215 ** INVALID SELECTION                     **
039000040730 ** INVALID PLAN CATEGORY TYPE
039100060210 ** INVALID EXCEL INVOICE COLUMN SEQUENCE
039200060210 ** INVOICE COLUMN SEQUENCE ALREADY EXISTS
039300160621 ** PLEASE ENTER A VALID VALUE            **
