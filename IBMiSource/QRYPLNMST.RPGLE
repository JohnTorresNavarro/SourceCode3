000100051006    ?FPLNMST    IF   E           K DISK
000200051110     FGRAT25    IF   E           K Disk
000300051010    ?FOEPLAN    UF A E           K DISK
000400051006      *
000500051006     C                   Dow       Not %Eof(PLNMST)
000600051115     C                   Read      PLNMST
000700051115     C                   Z-add     *Zero         WriteCtr          1 0
000800051115     C                   Z-add     *Zero         PosX
000900051115     C                   Eval      PosX    =     %Scan('CVNTRY':PDESCR)
001000051115     C                   If        PosX    >     *Zeros
001100051115     C                   Iter
001200051115     C                   End
001300051115     C                   Eval      PosX    =     %Scan('CVTRY':PDESCR)
001400051115     C                   If        PosX    >     *Zeros
001500051115     C                   Iter
001600051115     C                   End
001700051115     C                   Eval      PosX    =     %Scan('COVENTRY':PDESCR)
001800051115     C                   If        PosX    >     *Zeros
001900051115     C                   Iter
002000051115     C                   End
002100051115     C                   Eval      PosX    =     %Scan('FREESTATE':PDESCR)
002200051115     C                   If        PosX    >     *Zeros
002300051115     C                   Iter
002400051115     C                   End
002500051115     C                   Eval      PosX    =     %Scan('MD044BW':PDESCR)
002600051115     C                   If        PosX    >     *Zeros
002700051115     C                   Iter
002800051115     C                   End
002900051115     C                   Eval      PosX    =     %Scan('MD044BZ':PDESCR)
003000051115     C                   If        PosX    >     *Zeros
003100051115     C                   Iter
003200051115     C                   End
003300051115     C                   Eval      PosX    =     %Scan('MD04S80':PDESCR)
003400051115     C                   If        PosX    >     *Zeros
003500051115     C                   Iter
003600051115     C                   End
003700051115     C                   Eval      PosX    =     %Scan('MD04S81':PDESCR)
003800051115     C                   If        PosX    >     *Zeros
003900051115     C                   Iter
004000051115     C                   End
004100051110     C     GRKey         Setgt     GRAT25
004200051110     C     GRKey         Readpe    GRAT25
004300051114     C                   If        TODAT  >= Today  Or
004400051114     C                             TODAT   = *Zeros
004500051011     C                   Select
004600051011     C                   When      PLDLTD =  'A'      And
004700051006     C                             PLNCAT =  'PMM'
004800051110     C                   Move      *Blanks       Owz              11
004900051110     C                   Move      *Blanks       Blues             8
005000051115     C
005100051007     C                   Eval      Blues  =      %Trim('BLUE CHOICE')
005200051011     C                   Exsr      BlueSR3
005300051006     C                   Eval      Blues  =      %Trim('BLUECHOICE')
005400051011     C                   Exsr      BlueSR3
005500051006     C                   Eval      Blues  =      %Trim('BLCHOICE')
005600051011     C                   Exsr      BlueSR3
005700051006     C                   Eval      Blues  =      %Trim('Blue Choice')
005800051011     C                   Exsr      BlueSR3
005900051006     C                   Eval      Blues  =      %Trim('BLUE CHCE')
006000051011     C                   Exsr      BlueSR3
006100051006     C                   Eval      Blues  =      %Trim('BLCH')
006200051011     C                   Exsr      BlueSR3
006300051011     C                   Eval      Blues  =      %Trim('BL CHOICE')
006400051011     C                   Exsr      BlueSR3
006500051011     C                   Eval      Blues  =      %Trim('B CHOICE')
006600051011     C                   Exsr      BlueSR3
006700051006     C                   Eval      Blues  =      %Trim('BLUCHOICE')
006800051011     C                   Exsr      BlueSR3
006900051006     C                   Eval      Blues  =      %Trim('BLCHCE')
007000051011     C                   Exsr      BlueSR3
007100051011     C                   Eval      Blues  =      %Trim('BL CHCE')
007200051011     C                   Exsr      BlueSR3
007300051007     C                   Eval      Blues  =      %Trim('BLUECHCE')
007400051011     C                   Exsr      BlueSR3
007500051110      *
007600051115     C                   Eval      Owz    =      %Trim('COREHMO')
007700051115     C                   Exsr      OwzSR3
007800051115     C                   If        WriteCtr >    *Zero
007900051115     C                   Iter
008000051115     C                   End
008100051115     C                   Eval      Owz    =      %Trim('CORE HMO')
008200051115     C                   Exsr      OwzSR3
008300051115     C                   If        WriteCtr >    *Zero
008400051115     C                   Iter
008500051115     C                   End
008501051117     C                   Eval      Owz    =      %Trim('CORE')
008502051117     C                   Exsr      OwzSR3
008503051117     C                   If        WriteCtr >    *Zero
008504051117     C                   Iter
008505051117     C                   End
008600051116     C                   Eval      Owz    =      %Trim('HMOCORE')
008700051116     C                   Exsr      OwzSR3
008800051116     C                   If        WriteCtr >    *Zero
008900051116     C                   Iter
009000051116     C                   End
009100051114     C                   Eval      Owz    =      %Trim('HMO')
009200051114     C                   Exsr      OwzSR3
009300051117     C******             Eval      Owz    =      %Trim('CAP CARE')
009400051117     C******             Exsr      OwzSR3
009500051110     C                   Eval      Owz    =      %Trim('OOOA')
009600051110     C                   Exsr      OwzSR3
009700051115     C                   If        WriteCtr >    *Zero
009800051115     C                   Iter
009900051115     C                   End
010000051110     C                   Eval      Owz    =      %Trim('OPEN ACCESS')
010100051110     C                   Exsr      OwzSR3
010200051115     C                   Eval      Owz    =      %Trim('OOPOA')
010300051115     C                   Exsr      OwzSR3
010400051115     C                   If        WriteCtr >    *Zero
010500051115     C                   Iter
010600051115     C                   End
010700051115     C                   Eval      Owz    =      %Trim('OOP/OA')
010800051115     C                   Exsr      OwzSR3
010900051115     C                   If        WriteCtr >    *Zero
011000051115     C                   Iter
011100051115     C                   End
011200051115     C                   Eval      Owz    =      %Trim('OO OA')
011300051115     C                   Exsr      OwzSR3
011400051115     C                   If        WriteCtr >    *Zero
011500051115     C                   Iter
011600051115     C                   End
011700051115     C                   Eval      Owz    =      %Trim('OO_OA')
011800051115     C                   Exsr      OwzSR3
011900051115     C                   Eval      Owz    =      ' OA '
012000051115     C                   Exsr      OwzSR3
012100051115     C                   If        WriteCtr >    *Zero
012200051115     C                   Iter
012300051115     C                   End
012400051114     C                   Eval      Owz    =      ' OOP '
012500051110     C                   Exsr      OwzSR3
012501051117     C                   Eval      Owz    =      ' OO+ '
012502051117     C                   Exsr      OwzSR3
012600051011     C                   Exsr      BuildDescA
012700051011     C                   Exsr      BuildDescB
012800051011      *
012900051115     C                   When      PLDLTD =  'A'    And
013000051011     C                             (PLNCAT =  'PVR'   Or PLNCAT = 'PVS')
013100051011     C                   Z-add     *Zeros        PosX
013200051011     C                   Eval      PosX   = %Scan('AVESIS VISION':PDESCR)
013300051011     C                   If        PosX   > *Zero
013400051011     C     OEKey         Chain     OEPLAN
013500051115     C                   Eval      ODESC  = PDESCR
013600051011     C                   If        %Found(OEPLAN)
013700051011     C                   Update    OEPLANR
013800051011     C                   Else
013900051011     C                   Eval      OTRST = PLTRST
014000051011     C                   Eval      OSUB# = PLSUB#
014100051011     C                   Eval      OPLAN = PLPLAN
014200051011     C                   Write     OEPLANR
014300051011     C                   End
014400051011     C                   End
014500051012     C                   Z-add     *Zeros        PosX              2 0
014600051014     C                   Eval      PosX   = %Scan('BLUE VISION':PDESCR)
014700051012     C                   If        PosX   > *Zero
014800051012     C                   Z-add     *Zeros        PosX
014900051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
015000051012     C                   If        PosX   > *Zero
015100051012     C                   Exsr      BuildOEP5
015200051012     C                   End
015300051012     C                   End
015400051012     C                   Z-add     *Zeros        PosX              2 0
015500051014     C                   Eval      PosX   = %Scan('BLUEVISION':PDESCR)
015600051012     C                   If        PosX   > *Zero
015700051012     C                   Z-add     *Zeros        PosX
015800051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
015900051012     C                   If        PosX   > *Zero
016000051012     C                   Exsr      BuildOEP5
016100051012     C                   End
016200051012     C                   End
016300051014     C                   Z-add     *Zeros        PosX              2 0
016400051011     C                   Eval      PosX   = %Scan('CONSUMER VISION':PDESCR)
016500051011     C                   If        PosX   > *Zero
016600051011     C     OEKey         Chain     OEPLAN
016700051011     C                   Eval      ODESC  = %Trim('CONSUMER VISION')
016800051011     C                   If        %Found(OEPLAN)
016900051011     C                   Update    OEPLANR
017000051011     C                   Else
017100051011     C                   Eval      OTRST = PLTRST
017200051011     C                   Eval      OSUB# = PLSUB#
017300051011     C                   Eval      OPLAN = PLPLAN
017400051011     C                   Write     OEPLANR
017500051011     C                   End
017600051011     C                   End
017700051011     C                   Z-add     *Zeros        PosX
017800051011     C                   Eval      PosX   = %Scan('SPECTERA':PDESCR)
017900051011     C                   If        PosX   > *Zero
018000051011     C     OEKey         Chain     OEPLAN
018100051115     C                   Eval      ODESC  = PDESCR
018200051011     C                   If        %Found(OEPLAN)
018300051011     C                   Update    OEPLANR
018400051011     C                   Else
018500051011     C                   Eval      OTRST = PLTRST
018600051011     C                   Eval      OSUB# = PLSUB#
018700051011     C                   Eval      OPLAN = PLPLAN
018800051011     C                   Write     OEPLANR
018900051011     C                   End
019000051011     C                   End
019100051011     C                   When      PLDLTD =  'A'      And
019200051011     C                             (PLNCAT =  'PDN' Or PLNCAT = 'PDR' Or
019300051011     C                              PLNCAT =  'PDE' Or PLNCAT = 'PDU')
019400051011     C                   Z-add     *Zeros        PosX
019500051011     C                   Eval      PosX   = %Scan('DENTAQUEST':PDESCR)
019600051011     C                   If        PosX   > *Zero
019700051011     C     OEKey         Chain     OEPLAN
019800051115     C                   Eval      ODESC  = PDESCR
019900051011     C                   If        %Found(OEPLAN)
020000051011     C                   Update    OEPLANR
020100051011     C                   Else
020200051011     C                   Eval      OTRST = PLTRST
020300051011     C                   Eval      OSUB# = PLSUB#
020400051011     C                   Eval      OPLAN = PLPLAN
020500051011     C                   Write     OEPLANR
020600051011     C                   End
020700051011     C                   End
020800051011     C                   EndSl
020900051110     C                   End
021000051115     C**************     Read      PLNMST
021100051006     C                   Enddo
021200051006     C                   Eval      *INLR  =  *On
021300051011      *
021400051110     C     OwzSR3        Begsr
021500051115      * showme field is just for debugging purposes (next 10 lines)
021600051011     C                   Z-add     *Zeros        PosX              2 0
021700051114     C                   Eval      PosX   = %Scan('OOPOA':PDESCR)
021800051114     C                   If        PosX   > *Zero
021900051114     C                   Movel     PDESCR        showme           40
022000051114     C                   End
022100051115     C                   Z-add     *Zeros        PosX
022200051115     C                   Eval      PosX   = %Scan('OOP/OA':PDESCR)
022300051115     C                   If        PosX   > *Zero
022400051115     C                   Movel     PDESCR        showme
022500051115     C                   End
022600051115      * end of debugging
022700051114     C                   Select
022800051115     C                   When      Owz    = ' OOP '   Or
022900051115     C                             Owz    = 'OO+'     Or
023000051115     C                             Owz    = 'OPT OUT PLUS'
023100051114     C                   Eval      PosX   = %Scan(' OOP ':PDESCR)
023200051114     C                   When      Owz    = ' OA '
023300051110     C                   Eval      PosX   = %Scan(' OA ':PDESCR)
023400051116     C                   When      Owz    = 'CAP CARE'
023500051116     C                   Eval      PosX   = %Scan(' HMO ':PDESCR)
023600051114     C                   Other
023700051110     C                   Eval      PosX   = %Scan(%Trim(Owz):PDESCR)
023800051114     C                   EndSl
023900051011     C                   If        PosX   > *Zero
024000051110     C                   Exsr      BuildOwzP3
024100051011     C                   End
024200051011     C                   EndSR
024300051010      *
024400051110     C     BlueSR3       Begsr
024500051110     C                   Z-add     *Zeros        PosX              2 0
024600051110     C                   Eval      PosX   = %Scan(%Trim(Blues):PDESCR)
024700051110     C                   If        PosX   > *Zero
024800051110     C                   Exsr      BuildOEP3
024900051110     C                   End
025000051110     C                   EndSR
025100051110      *
025200051011     C     BuildDescA    Begsr
025300051010     C                   Z-add     *Zeros        PosX              2 0
025400051011     C                   Eval      PosX   = %Scan('BLUE PREF':PDESCR)
025500051010     C                   If        PosX   > *Zero
025600051010     C                   Z-add     *Zeros        PosX
025700051010     C                   Eval      PosX   = %Scan('OPT':PDESCR)
025800051010     C                   If        PosX   > *Zero
025900051011     C                   Exsr      BuildOEP1
026000051010     C                   End
026100051010     C                   End
026200051012     C                   Z-add     *Zeros        PosX              2 0
026300051012     C                   Eval      PosX   = %Scan('BL PREFERRED':PDESCR)
026400051012     C                   If        PosX   > *Zero
026500051012     C                   Z-add     *Zeros        PosX
026600051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
026700051012     C                   If        PosX   > *Zero
026800051012     C                   Exsr      BuildOEP1
026900051012     C                   End
027000051012     C                   End
027100051012     C                   Z-add     *Zeros        PosX              2 0
027200051012     C                   Eval      PosX   = %Scan('BLPREFERRED':PDESCR)
027300051012     C                   If        PosX   > *Zero
027400051012     C                   Z-add     *Zeros        PosX
027500051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
027600051012     C                   If        PosX   > *Zero
027700051012     C                   Exsr      BuildOEP1
027800051012     C                   End
027900051012     C                   End
028000051012     C                   Z-add     *Zeros        PosX              2 0
028100051012     C                   Eval      PosX   = %Scan('BL PRFRRED':PDESCR)
028200051012     C                   If        PosX   > *Zero
028300051012     C                   Z-add     *Zeros        PosX
028400051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
028500051012     C                   If        PosX   > *Zero
028600051012     C                   Exsr      BuildOEP1
028700051012     C                   End
028800051012     C                   End
028900051012     C                   Z-add     *Zeros        PosX              2 0
029000051012     C                   Eval      PosX   = %Scan('BLUE PRFERRD':PDESCR)
029100051012     C                   If        PosX   > *Zero
029200051012     C                   Z-add     *Zeros        PosX
029300051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
029400051012     C                   If        PosX   > *Zero
029500051012     C                   Exsr      BuildOEP1
029600051012     C                   End
029700051012     C                   End
029800051012     C                   Z-add     *Zeros        PosX              2 0
029900051012     C                   Eval      PosX   = %Scan('BLUE PRFRD':PDESCR)
030000051012     C                   If        PosX   > *Zero
030100051012     C                   Z-add     *Zeros        PosX
030200051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
030300051012     C                   If        PosX   > *Zero
030400051012     C                   Exsr      BuildOEP1
030500051012     C                   End
030600051012     C                   End
030700051011     C                   Z-add     *Zeros        PosX              2 0
030800051011     C                   Eval      PosX   = %Scan('BLUEPREF':PDESCR)
030900051011     C                   If        PosX   > *Zero
031000051011     C                   Z-add     *Zeros        PosX
031100051011     C                   Eval      PosX   = %Scan('OPT':PDESCR)
031200051011     C                   If        PosX   > *Zero
031300051011     C                   Exsr      BuildOEP1
031400051011     C                   End
031500051011     C                   End
031600051012     C                   Z-add     *Zeros        PosX              2 0
031700051012     C                   Eval      PosX   = %Scan('BLUPREF':PDESCR)
031800051012     C                   If        PosX   > *Zero
031900051012     C                   Z-add     *Zeros        PosX
032000051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
032100051012     C                   If        PosX   > *Zero
032200051012     C                   Exsr      BuildOEP1
032300051012     C                   End
032400051012     C                   End
032500051011     C                   Z-add     *Zeros        PosX              2 0
032600051011     C                   Eval      PosX   = %Scan('B PREF':PDESCR)
032700051011     C                   If        PosX   > *Zero
032800051011     C                   Z-add     *Zeros        PosX
032900051011     C                   Eval      PosX   = %Scan('OPT':PDESCR)
033000051011     C                   If        PosX   > *Zero
033100051011     C                   Exsr      BuildOEP1
033200051011     C                   End
033300051011     C                   End
033400051012     C                   Z-add     *Zeros        PosX              2 0
033500051012     C                   Eval      PosX   = %Scan('BLPREF':PDESCR)
033600051012     C                   If        PosX   > *Zero
033700051012     C                   Z-add     *Zeros        PosX
033800051012     C                   Eval      PosX   = %Scan('OPT':PDESCR)
033900051012     C                   If        PosX   > *Zero
034000051012     C                   Exsr      BuildOEP1
034100051012     C                   End
034200051012     C                   End
034300051010     C                   EndSR
034400051011      *
034500051011     C     BuildDescB    Begsr
034600051011     C                   Z-add     *Zeros        PosX
034700051011     C                   Eval      PosX   = %Scan('SELECT PREF':PDESCR)
034800051011     C                   If        PosX   > *Zero
034900051011     C                   Z-add     *Zeros        PosX
035000051011     C                   Eval      PosX   = %Scan('OPT':PDESCR)
035100051011     C                   If        PosX   > *Zero
035200051011     C                   Exsr      BuildOEPB
035300051011     C                   End
035400051011     C                   End
035500051011      *
035600051011     C                   Z-add     *Zeros        PosX
035700051011     C                   Eval      PosX   = %Scan('SPP':PDESCR)
035800051011     C                   If        PosX   > *Zero
035900051011     C                   Z-add     *Zeros        PosX
036000051011     C                   Eval      PosX   = %Scan('OPT':PDESCR)
036100051011     C                   If        PosX   > *Zero
036200051011     C                   Exsr      BuildOEPB
036300051011     C                   End
036400051011     C                   End
036500051011     C                   EndSR
036600051006      *
036700051010     C     BuildOEP1     Begsr
036800051010     C                   Clear                   OPT#              6
036900051010     C                   Z-add     *Zeros        PosX
037000051116     C                   Eval      PosX   = %Scan('#1 ':PDESCR)
037100051010     C                   Eval      OPT#   =      'OPT 1'
037200051010     C                   Exsr      BuildOEP2
037300051010      *
037400051116     C                   Z-add     *Zeros        PosX
037500051116     C                   Eval      PosX   = %Scan('OPT1 ':PDESCR)
037600051116     C                   Eval      OPT#   =      'OPT 1'
037700051116     C                   Exsr      BuildOEP2
037800051116      *
037900051011     C                   Z-add     *Zeros        PosX
038000051011     C                   Eval      PosX   = %Scan('OPT1':PDESCR)
038100051011     C                   Eval      OPT#   =      'OPT 1'
038200051011     C                   Exsr      BuildOEP2
038300051011      *
038400051010     C                   Z-add     *Zeros        PosX
038500051010     C                   Eval      PosX   = %Scan('OPT#1':PDESCR)
038600051010     C                   Eval      OPT#   =     'OPT 1'
038700051010     C                   Exsr      BuildOEP2
038800051012      *
038900051012     C                   Z-add     *Zeros        PosX
039000051012     C                   Eval      PosX   = %Scan('OPT# 1':PDESCR)
039100051012     C                   Eval      OPT#   =     'OPT 1'
039200051012     C                   Exsr      BuildOEP2
039300051010      *
039400051010     C                   Z-add     *Zeros        PosX
039500051010     C                   Eval      PosX   = %Scan('OPT 1':PDESCR)
039600051010     C                   Eval      OPT#   =     'OPT 1'
039700051010     C                   Exsr      BuildOEP2
039800051011      *
039900051011     C                   Z-add     *Zeros        PosX
040000051011     C                   Eval      PosX   = %Scan('OPTION 1':PDESCR)
040100051011     C                   Eval      OPT#   =     'OPT 1'
040200051011     C                   Exsr      BuildOEP2
040300051012      *
040400051012     C                   Z-add     *Zeros        PosX
040500051012     C                   Eval      PosX   = %Scan('OPT#2':PDESCR)
040600051012     C                   Eval      OPT#   =     'OPT 2'
040700051012     C                   Exsr      BuildOEP2
040800051010      *
040900051010     C                   Z-add     *Zeros        PosX
041000051010     C                   Eval      PosX   = %Scan('OPT2 ':PDESCR)
041100051010     C                   Eval      OPT#   =     'OPT 2'
041200051010     C                   Exsr      BuildOEP2
041300051012      *
041400051012     C                   Z-add     *Zeros        PosX
041500051012     C                   Eval      PosX   = %Scan('OP2 ':PDESCR)
041600051012     C                   Eval      OPT#   =     'OPT 2'
041700051012     C                   Exsr      BuildOEP2
041800051012      *
041900051012     C                   Z-add     *Zeros        PosX
042000051012     C                   Eval      PosX   = %Scan('#2':PDESCR)
042100051012     C                   Eval      OPT#   =      'OPT 2'
042200051012     C                   Exsr      BuildOEP2
042300051010      *
042400051010     C                   Z-add     *Zeros        PosX
042500051010     C                   Eval      PosX   = %Scan('OPT2#':PDESCR)
042600051010     C                   Eval      OPT#   =     'OPT 2'
042700051010     C                   Exsr      BuildOEP2
042800051010      *
042900051011     C                   Z-add     *Zeros        PosX
043000051011     C                   Eval      PosX   = %Scan('OPT2':PDESCR)
043100051011     C                   Eval      OPT#   =      'OPT 2'
043200051011     C                   Exsr      BuildOEP2
043300051011      *
043400051010     C                   Z-add     *Zeros        PosX
043500051010     C                   Eval      PosX   = %Scan('OPT 2':PDESCR)
043600051010     C                   Eval      OPT#   =     'OPT 2'
043700051010     C                   Exsr      BuildOEP2
043800051010      *
043900051011     C                   Z-add     *Zeros        PosX
044000051011     C                   Eval      PosX   = %Scan('OPTION 2':PDESCR)
044100051011     C                   Eval      OPT#   =     'OPT 2'
044200051011     C                   Exsr      BuildOEP2
044300051011      *
044400051010     C                   Z-add     *Zeros        PosX
044500051010     C                   Eval      PosX   = %Scan('OPT3':PDESCR)
044600051010     C                   Eval      OPT#   =     'OPT 3'
044700051010     C                   Exsr      BuildOEP2
044800051011      *
044900051011     C                   Z-add     *Zeros        PosX
045000051011     C                   Eval      PosX   = %Scan('OPT3':PDESCR)
045100051011     C                   Eval      OPT#   =      'OPT 3'
045200051011     C                   Exsr      BuildOEP2
045300051010      *
045400051012     C                   Z-add     *Zeros        PosX
045500051012     C                   Eval      PosX   = %Scan('#3':PDESCR)
045600051012     C                   Eval      OPT#   =      'OPT 3'
045700051012     C                   Exsr      BuildOEP2
045800051012      *
045900051010     C                   Z-add     *Zeros        PosX
046000051010     C                   Eval      PosX   = %Scan('OPT3#':PDESCR)
046100051010     C                   Eval      OPT#   =     'OPT 3'
046200051010     C                   Exsr      BuildOEP2
046300051010      *
046400051010     C                   Z-add     *Zeros        PosX
046500051010     C                   Eval      PosX   = %Scan('OPT 3':PDESCR)
046600051010     C                   Eval      OPT#   =     'OPT 3'
046700051010     C                   Exsr      BuildOEP2
046800051011      *
046900051011     C                   Z-add     *Zeros        PosX
047000051011     C                   Eval      PosX   = %Scan('OPTION 3':PDESCR)
047100051011     C                   Eval      OPT#   =     'OPT 3'
047200051011     C                   Exsr      BuildOEP2
047300051012      *
047400051012     C                   Z-add     *Zeros        PosX
047500051012     C                   Eval      PosX   = %Scan('OPITON 3':PDESCR)
047600051012     C                   Eval      OPT#   =     'OPT 3'
047700051012     C                   Exsr      BuildOEP2
047800051010      *
047900051010     C                   Z-add     *Zeros        PosX
048000051010     C                   Eval      PosX   = %Scan('OPT4 ':PDESCR)
048100051010     C                   Eval      OPT#   =     'OPT 4'
048200051010     C                   Exsr      BuildOEP2
048300051014      *
048400051014     C                   Z-add     *Zeros        PosX
048500051014     C                   Eval      PosX   = %Scan('opt4 ':PDESCR)
048600051014     C                   Eval      OPT#   =     'OPT 4'
048700051014     C                   Exsr      BuildOEP2
048800051011      *
048900051011     C                   Z-add     *Zeros        PosX
049000051012     C                   Eval      PosX   = %Scan('OPT#4':PDESCR)
049100051011     C                   Eval      OPT#   =      'OPT 4'
049200051011     C                   Exsr      BuildOEP2
049300051012      *
049400051012     C                   Z-add     *Zeros        PosX
049500051012     C                   Eval      PosX   = %Scan('#4':PDESCR)
049600051012     C                   Eval      OPT#   =      'OPT 4'
049700051012     C                   Exsr      BuildOEP2
049800051012      *
049900051012     C                   Z-add     *Zeros        PosX
050000051012     C                   Eval      PosX   = %Scan('OPT4':PDESCR)
050100051012     C                   Eval      OPT#   =      'OPT 4'
050200051012     C                   Exsr      BuildOEP2
050300051010      *
050400051010     C                   Z-add     *Zeros        PosX
050500051010     C                   Eval      PosX   = %Scan('OPT4#':PDESCR)
050600051010     C                   Eval      OPT#   =     'OPT 4'
050700051010     C                   Exsr      BuildOEP2
050800051010      *
050900051010     C                   Z-add     *Zeros        PosX
051000051010     C                   Eval      PosX   = %Scan('OPT 4':PDESCR)
051100051010     C                   Eval      OPT#   =     'OPT 4'
051200051010     C                   Exsr      BuildOEP2
051300051010      *
051400051011     C                   Z-add     *Zeros        PosX
051500051011     C                   Eval      PosX   = %Scan('OPTION 4':PDESCR)
051600051011     C                   Eval      OPT#   =     'OPT 4'
051700051011     C                   Exsr      BuildOEP2
051800051014      *
051900051014     C                   Z-add     *Zeros        PosX
052000051014     C                   Eval      PosX   = %Scan('OPTION4':PDESCR)
052100051014     C                   Eval      OPT#   =     'OPT 4'
052200051014     C                   Exsr      BuildOEP2
052300051011      *
052400051010     C                   Z-add     *Zeros        PosX
052500051010     C                   Eval      PosX   = %Scan('OPT5 ':PDESCR)
052600051010     C                   Eval      OPT#   =     'OPT 5'
052700051010     C                   Exsr      BuildOEP2
052800051012      *
052900051012     C                   Z-add     *Zeros        PosX
053000051012     C                   Eval      PosX   = %Scan('#5':PDESCR)
053100051012     C                   Eval      OPT#   =      'OPT 5'
053200051012     C                   Exsr      BuildOEP2
053300051011      *
053400051011     C                   Z-add     *Zeros        PosX
053500051011     C                   Eval      PosX   = %Scan('OPT5':PDESCR)
053600051011     C                   Eval      OPT#   =      'OPT 5'
053700051011     C                   Exsr      BuildOEP2
053800051010      *
053900051010     C                   Z-add     *Zeros        PosX
054000051010     C                   Eval      PosX   = %Scan('OPT5#':PDESCR)
054100051010     C                   Eval      OPT#   =     'OPT 5'
054200051010     C                   Exsr      BuildOEP2
054300051010      *
054400051010     C                   Z-add     *Zeros        PosX
054500051010     C                   Eval      PosX   = %Scan('OPT 5':PDESCR)
054600051010     C                   Eval      OPT#   =     'OPT 5'
054700051010     C                   Exsr      BuildOEP2
054800051011      *
054900051011     C                   Z-add     *Zeros        PosX
055000051011     C                   Eval      PosX   = %Scan('OPTION 5':PDESCR)
055100051011     C                   Eval      OPT#   =     'OPT 5'
055200051011     C                   Exsr      BuildOEP2
055300051010      *
055400051010     C                   Z-add     *Zeros        PosX
055500051010     C                   Eval      PosX   = %Scan('OPT6 ':PDESCR)
055600051010     C                   Eval      OPT#   =     'OPT 6'
055700051010     C                   Exsr      BuildOEP2
055800051011      *
055900051011     C                   Z-add     *Zeros        PosX
056000051011     C                   Eval      PosX   = %Scan('OPT6':PDESCR)
056100051011     C                   Eval      OPT#   =      'OPT 6'
056200051011     C                   Exsr      BuildOEP2
056300051010      *
056400051010     C                   Z-add     *Zeros        PosX
056500051010     C                   Eval      PosX   = %Scan('OPT6#':PDESCR)
056600051010     C                   Eval      OPT#   =     'OPT 6'
056700051010     C                   Exsr      BuildOEP2
056800051012      *
056900051012     C                   Z-add     *Zeros        PosX
057000051012     C                   Eval      PosX   = %Scan('OPT#6':PDESCR)
057100051012     C                   Eval      OPT#   =     'OPT 6'
057200051012     C                   Exsr      BuildOEP2
057300051010      *
057400051010     C                   Z-add     *Zeros        PosX
057500051010     C                   Eval      PosX   = %Scan('OPT 6':PDESCR)
057600051010     C                   Eval      OPT#   =     'OPT 6'
057700051010     C                   Exsr      BuildOEP2
057800051012      *
057900051012     C                   Z-add     *Zeros        PosX
058000051012     C                   Eval      PosX   = %Scan('opt 6':PDESCR)
058100051012     C                   Eval      OPT#   =     'OPT 6'
058200051012     C                   Exsr      BuildOEP2
058300051010      *
058400051011     C                   Z-add     *Zeros        PosX
058500051011     C                   Eval      PosX   = %Scan('OPTION 6':PDESCR)
058600051011     C                   Eval      OPT#   =     'OPT 6'
058700051011     C                   Exsr      BuildOEP2
058800051012      *
058900051012     C                   Z-add     *Zeros        PosX
059000051012     C                   Eval      PosX   = %Scan('OPTTON 6':PDESCR)
059100051012     C                   Eval      OPT#   =     'OPT 6'
059200051012     C                   Exsr      BuildOEP2
059300051012      *
059400051012     C                   Z-add     *Zeros        PosX
059500051012     C                   Eval      PosX   = %Scan('#6':PDESCR)
059600051012     C                   Eval      OPT#   =     'OPT 6'
059700051012     C                   Exsr      BuildOEP2
059800051011      *
059900051010     C                   Z-add     *Zeros        PosX
060000051010     C                   Eval      PosX   = %Scan('OPT7 ':PDESCR)
060100051010     C                   Eval      OPT#   =     'OPT 7'
060200051010     C                   Exsr      BuildOEP2
060300051011      *
060400051011     C                   Z-add     *Zeros        PosX
060500051011     C                   Eval      PosX   = %Scan('OPT7':PDESCR)
060600051011     C                   Eval      OPT#   =      'OPT 7'
060700051011     C                   Exsr      BuildOEP2
060800051010      *
060900051010     C                   Z-add     *Zeros        PosX
061000051010     C                   Eval      PosX   = %Scan('OPT7#':PDESCR)
061100051010     C                   Eval      OPT#   =     'OPT 7'
061200051010     C                   Exsr      BuildOEP2
061300051012      *
061400051012     C                   Z-add     *Zeros        PosX
061500051012     C                   Eval      PosX   = %Scan('#7':PDESCR)
061600051012     C                   Eval      OPT#   =      'OPT 7'
061700051012     C                   Exsr      BuildOEP2
061800051010      *
061900051010     C                   Z-add     *Zeros        PosX
062000051010     C                   Eval      PosX   = %Scan('OPT 7':PDESCR)
062100051010     C                   Eval      OPT#   =     'OPT 7'
062200051010     C                   Exsr      BuildOEP2
062300051011      *
062400051011     C                   Z-add     *Zeros        PosX
062500051011     C                   Eval      PosX   = %Scan('OPTION 7':PDESCR)
062600051011     C                   Eval      OPT#   =     'OPT 7'
062700051011     C                   Exsr      BuildOEP2
062800051010      *
062900051010     C                   Z-add     *Zeros        PosX
063000051010     C                   Eval      PosX   = %Scan('OPT8 ':PDESCR)
063100051010     C                   Eval      OPT#   =     'OPT 8'
063200051010     C                   Exsr      BuildOEP2
063300051011      *
063400051011     C                   Z-add     *Zeros        PosX
063500051011     C                   Eval      PosX   = %Scan('OPT8':PDESCR)
063600051011     C                   Eval      OPT#   =      'OPT 8'
063700051011     C                   Exsr      BuildOEP2
063800051010      *
063900051010     C                   Z-add     *Zeros        PosX
064000051010     C                   Eval      PosX   = %Scan('OPT8#':PDESCR)
064100051010     C                   Eval      OPT#   =     'OPT 8'
064200051010     C                   Exsr      BuildOEP2
064300051010      *
064400051010     C                   Z-add     *Zeros        PosX
064500051010     C                   Eval      PosX   = %Scan('OPT 8':PDESCR)
064600051010     C                   Eval      OPT#   =     'OPT 8'
064700051010     C                   Exsr      BuildOEP2
064800051011      *
064900051011     C                   Z-add     *Zeros        PosX
065000051011     C                   Eval      PosX   = %Scan('OPTION 8':PDESCR)
065100051011     C                   Eval      OPT#   =     'OPT 8'
065200051011     C                   Exsr      BuildOEP2
065300051010      *
065400051010     C                   Z-add     *Zeros        PosX
065500051010     C                   Eval      PosX   = %Scan('OPT9 ':PDESCR)
065600051010     C                   Eval      OPT#   =     'OPT 9'
065700051010     C                   Exsr      BuildOEP2
065800051011      *
065900051011     C                   Z-add     *Zeros        PosX
066000051011     C                   Eval      PosX   = %Scan('OPT9':PDESCR)
066100051011     C                   Eval      OPT#   =      'OPT 9'
066200051011     C                   Exsr      BuildOEP2
066300051010      *
066400051010     C                   Z-add     *Zeros        PosX
066500051010     C                   Eval      PosX   = %Scan('OPT9#':PDESCR)
066600051010     C                   Eval      OPT#   =     'OPT 9'
066700051010     C                   Exsr      BuildOEP2
066800051010      *
066900051010     C                   Z-add     *Zeros        PosX
067000051010     C                   Eval      PosX   = %Scan('OPT 9':PDESCR)
067100051010     C                   Eval      OPT#   =     'OPT 9'
067200051010     C                   Exsr      BuildOEP2
067300051011      *
067400051011     C                   Z-add     *Zeros        PosX
067500051011     C                   Eval      PosX   = %Scan('OPTION 9':PDESCR)
067600051011     C                   Eval      OPT#   =     'OPT 9'
067700051011     C                   Exsr      BuildOEP2
067800051010      *
067900051010     C                   Z-add     *Zeros        PosX
068000051010     C                   Eval      PosX   = %Scan('OPT10 ':PDESCR)
068100051010     C                   Eval      OPT#   =     'OPT 10'
068200051010     C                   Exsr      BuildOEP2
068300051011      *
068400051011     C                   Z-add     *Zeros        PosX
068500051011     C                   Eval      PosX   = %Scan('OPT10':PDESCR)
068600051011     C                   Eval      OPT#   =      'OPT 10'
068700051011     C                   Exsr      BuildOEP2
068800051010      *
068900051010     C                   Z-add     *Zeros        PosX
069000051010     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
069100051010     C                   Eval      OPT#   =     'OPT 10'
069200051010     C                   Exsr      BuildOEP2
069300051010      *
069400051010     C                   Z-add     *Zeros        PosX
069500051010     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
069600051010     C                   Eval      OPT#   =     'OPT 10'
069700051010     C                   Exsr      BuildOEP2
069800051011      *
069900051011     C                   Z-add     *Zeros        PosX
070000051011     C                   Eval      PosX   = %Scan('OPTION 10':PDESCR)
070100051011     C                   Eval      OPT#   =     'OPT 10'
070200051011     C                   Exsr      BuildOEP2
070300051010      *
070400051010     C                   Z-add     *Zeros        PosX
070500051114     C                   Eval      PosX   = %Scan('#11':PDESCR)
070600051010     C                   Eval      OPT#   =     'OPT 11'
070700051114     C                   Exsr      BuildOEP2
070800051010      *
070900051114     C                   Z-add     *Zeros        PosX
071000051114     C                   Eval      PosX   = %Scan('OPT11 ':PDESCR)
071100051114     C                   Eval      OPT#   =     'OPT 11'
071200051114     C                   Exsr      BuildOEP2
071300051114      *
071400051010     C                   Z-add     *Zeros        PosX
071500051010     C                   Eval      PosX   = %Scan('OPT11#':PDESCR)
071600051010     C                   Eval      OPT#   =     'OPT 11'
071700051010     C                   Exsr      BuildOEP2
071800051010      *
071900051010     C                   Z-add     *Zeros        PosX
072000051010     C                   Eval      PosX   = %Scan('OPT 11':PDESCR)
072100051010     C                   Eval      OPT#   =     'OPT 11'
072200051010     C                   Exsr      BuildOEP2
072300051010      *
072400051010     C                   Z-add     *Zeros        PosX
072500051010     C                   Eval      PosX   = %Scan('OPT12 ':PDESCR)
072600051010     C                   Eval      OPT#   =     'OPT 12'
072700051010     C                   Exsr      BuildOEP2
072800051012      *
072900051012     C                   Z-add     *Zeros        PosX
073000051012     C                   Eval      PosX   = %Scan('OPT12':PDESCR)
073100051012     C                   Eval      OPT#   =     'OPT 12'
073200051012     C                   Exsr      BuildOEP2
073300051010      *
073400051010     C                   Z-add     *Zeros        PosX
073500051010     C                   Eval      PosX   = %Scan('OPT12#':PDESCR)
073600051010     C                   Eval      OPT#   =     'OPT 12'
073700051010     C                   Exsr      BuildOEP2
073800051010      *
073900051010     C                   Z-add     *Zeros        PosX
074000051010     C                   Eval      PosX   = %Scan('OPT 12':PDESCR)
074100051010     C                   Eval      OPT#   =     'OPT 12'
074200051010     C                   Exsr      BuildOEP2
074300051010      *
074400051010     C                   Z-add     *Zeros        PosX
074500051010     C                   Eval      PosX   = %Scan('OPT13 ':PDESCR)
074600051010     C                   Eval      OPT#   =     'OPT 13'
074700051010     C                   Exsr      BuildOEP2
074800051010      *
074900051010     C                   Z-add     *Zeros        PosX
075000051010     C                   Eval      PosX   = %Scan('OPT13#':PDESCR)
075100051010     C                   Eval      OPT#   =     'OPT 13'
075200051010     C                   Exsr      BuildOEP2
075300051010      *
075400051010     C                   Z-add     *Zeros        PosX
075500051010     C                   Eval      PosX   = %Scan('OPT 13':PDESCR)
075600051010     C                   Eval      OPT#   =     'OPT 13'
075700051010     C                   Exsr      BuildOEP2
075800051010      *
075900051010     C                   Z-add     *Zeros        PosX
076000051010     C                   Eval      PosX   = %Scan('OPT14 ':PDESCR)
076100051115     C                   Eval      OPT#   =     'OPT 14'
076200051010     C                   Exsr      BuildOEP2
076300051010      *
076400051010     C                   Z-add     *Zeros        PosX
076500051010     C                   Eval      PosX   = %Scan('OPT14#':PDESCR)
076600051010     C                   Eval      OPT#   =     'OPT 14'
076700051010     C                   Exsr      BuildOEP2
076800051010      *
076900051010     C                   Z-add     *Zeros        PosX
077000051010     C                   Eval      PosX   = %Scan('OPT 14':PDESCR)
077100051010     C                   Eval      OPT#   =     'OPT 14'
077200051010     C                   Exsr      BuildOEP2
077300051012      *
077400051012     C                   Z-add     *Zeros        PosX
077500051012     C                   Eval      PosX   = %Scan('OPTION 14':PDESCR)
077600051012     C                   Eval      OPT#   =     'OPT 14'
077700051012     C                   Exsr      BuildOEP2
077800051010      *
077900051010     C                   Z-add     *Zeros        PosX
078000051010     C                   Eval      PosX   = %Scan('OPT15 ':PDESCR)
078100051010     C                   Eval      OPT#   =     'OPT 15'
078200051010     C                   Exsr      BuildOEP2
078300051010      *
078400051010     C                   Z-add     *Zeros        PosX
078500051010     C                   Eval      PosX   = %Scan('OPT15#':PDESCR)
078600051010     C                   Eval      OPT#   =     'OPT 15'
078700051010     C                   Exsr      BuildOEP2
078800051010      *
078900051010     C                   Z-add     *Zeros        PosX
079000051010     C                   Eval      PosX   = %Scan('OPT 15':PDESCR)
079100051010     C                   Eval      OPT#   =     'OPT 15'
079200051010     C                   Exsr      BuildOEP2
079300051010      *
079400051010     C                   Z-add     *Zeros        PosX
079500051010     C                   Eval      PosX   = %Scan('OPT16 ':PDESCR)
079600051010     C                   Eval      OPT#   =     'OPT 16'
079700051010     C                   Exsr      BuildOEP2
079800051010      *
079900051010     C                   Z-add     *Zeros        PosX
080000051010     C                   Eval      PosX   = %Scan('OPT16#':PDESCR)
080100051010     C                   Eval      OPT#   =     'OPT 16'
080200051010     C                   Exsr      BuildOEP2
080300051010      *
080400051010     C                   Z-add     *Zeros        PosX
080500051010     C                   Eval      PosX   = %Scan('OPT 16':PDESCR)
080600051010     C                   Eval      OPT#   =     'OPT 16'
080700051010     C                   Exsr      BuildOEP2
080800051010      *
080900051010     C                   Z-add     *Zeros        PosX
081000051010     C                   Eval      PosX   = %Scan('OPT17 ':PDESCR)
081100051010     C                   Eval      OPT#   =     'OPT 17'
081200051010     C                   Exsr      BuildOEP2
081300051010      *
081400051010     C                   Z-add     *Zeros        PosX
081500051010     C                   Eval      PosX   = %Scan('OPT17#':PDESCR)
081600051010     C                   Eval      OPT#   =     'OPT 17'
081700051010     C                   Exsr      BuildOEP2
081800051010      *
081900051010     C                   Z-add     *Zeros        PosX
082000051010     C                   Eval      PosX   = %Scan('OPT 17':PDESCR)
082100051010     C                   Eval      OPT#   =     'OPT 17'
082200051010     C                   Exsr      BuildOEP2
082300051010     C                   EndSR
082400051011      *
082500051011     C     BuildOEP3     Begsr
082600051011     C                   Clear                   OPT#
082700051011     C                   Z-add     *Zeros        PosX
082800051011     C                   Eval      PosX   = %Scan('OPT1 ':PDESCR)
082900051011     C                   Eval      OPT#   =      'OPT 1'
083000051011     C                   Exsr      BuildOEP3A
083100051012      *
083200051012     C                   Z-add     *Zeros        PosX
083300051012     C                   Eval      PosX   = %Scan('OPT# 1':PDESCR)
083400051012     C                   Eval      OPT#   =     'OPT 1'
083500051012     C                   Exsr      BuildOEP3A
083600051012      *
083700051012     C                   Z-add     *Zeros        PosX
083800051116     C                   Eval      PosX   = %Scan('#1 ':PDESCR)
083900051012     C                   Eval      OPT#   =      'OPT 1'
084000051012     C                   Exsr      BuildOEP3A
084100051011      *
084200051011     C                   Z-add     *Zeros        PosX
084300051011     C                   Eval      PosX   = %Scan('OPT#1':PDESCR)
084400051116     C                   Eval      OPT#   =     'OPT 1 '
084500051011     C                   Exsr      BuildOEP3A
084600051011      *
084700051011     C                   Z-add     *Zeros        PosX
084800051011     C                   Eval      PosX   = %Scan('OPT 1':PDESCR)
084900051116     C                   Eval      OPT#   =     'OPT 1 '
085000051011     C                   Exsr      BuildOEP3A
085100051011      *
085200051011     C                   Z-add     *Zeros        PosX
085300051116     C                   Eval      PosX   = %Scan('OPTION 1 ':PDESCR)
085400051011     C                   Eval      OPT#   =     'OPT 1'
085500051011     C                   Exsr      BuildOEP3A
085600051011      *
085700051011     C                   Z-add     *Zeros        PosX
085800051011     C                   Eval      PosX   = %Scan('OPT2 ':PDESCR)
085900051011     C                   Eval      OPT#   =     'OPT 2'
086000051011     C                   Exsr      BuildOEP3A
086100051012      *
086200051012     C                   Z-add     *Zeros        PosX
086300051012     C                   Eval      PosX   = %Scan('OP2 ':PDESCR)
086400051012     C                   Eval      OPT#   =     'OPT 2'
086500051012     C                   Exsr      BuildOEP3A
086600051012      *
086700051012     C                   Z-add     *Zeros        PosX
086800051012     C                   Eval      PosX   = %Scan('OPT#2':PDESCR)
086900051012     C                   Eval      OPT#   =     'OPT 2'
087000051012     C                   Exsr      BuildOEP3A
087100051012      *
087200051012     C                   Z-add     *Zeros        PosX
087300051012     C                   Eval      PosX   = %Scan('#2':PDESCR)
087400051012     C                   Eval      OPT#   =      'OPT 2'
087500051012     C                   Exsr      BuildOEP3A
087600051011      *
087700051011     C                   Z-add     *Zeros        PosX
087800051011     C                   Eval      PosX   = %Scan('OPT2#':PDESCR)
087900051011     C                   Eval      OPT#   =     'OPT 2'
088000051011     C                   Exsr      BuildOEP3A
088100051011      *
088200051011     C                   Z-add     *Zeros        PosX
088300051011     C                   Eval      PosX   = %Scan('OPT 2':PDESCR)
088400051011     C                   Eval      OPT#   =     'OPT 2'
088500051011     C                   Exsr      BuildOEP3A
088600051011      *
088700051011     C                   Z-add     *Zeros        PosX
088800051011     C                   Eval      PosX   = %Scan('OPTION 2':PDESCR)
088900051011     C                   Eval      OPT#   =     'OPT 2'
089000051011     C                   Exsr      BuildOEP3A
089100051012      *
089200051012     C                   Z-add     *Zeros        PosX
089300051012     C                   Eval      PosX   = %Scan('opt 2':PDESCR)
089400051012     C                   Eval      OPT#   =     'OPT 2'
089500051012     C                   Exsr      BuildOEP3A
089600051012      *
089700051012     C                   Z-add     *Zeros        PosX
089800051012     C                   Eval      PosX   = %Scan('opt2':PDESCR)
089900051012     C                   Eval      OPT#   =     'OPT 2'
090000051012     C                   Exsr      BuildOEP3A
090100051011      *
090200051011     C                   Z-add     *Zeros        PosX
090300051011     C                   Eval      PosX   = %Scan('OPT3':PDESCR)
090400051011     C                   Eval      OPT#   =     'OPT 3'
090500051011     C                   Exsr      BuildOEP3A
090600051011      *
090700051011     C                   Z-add     *Zeros        PosX
090800051011     C                   Eval      PosX   = %Scan('OPT3#':PDESCR)
090900051011     C                   Eval      OPT#   =     'OPT 3'
091000051011     C                   Exsr      BuildOEP3A
091100051012      *
091200051012     C                   Z-add     *Zeros        PosX
091300051012     C                   Eval      PosX   = %Scan('#3':PDESCR)
091400051012     C                   Eval      OPT#   =      'OPT 3'
091500051012     C                   Exsr      BuildOEP3A
091600051011      *
091700051011     C                   Z-add     *Zeros        PosX
091800051011     C                   Eval      PosX   = %Scan('OPT 3':PDESCR)
091900051011     C                   Eval      OPT#   =     'OPT 3'
092000051011     C                   Exsr      BuildOEP3A
092100051011      *
092200051011     C                   Z-add     *Zeros        PosX
092300051011     C                   Eval      PosX   = %Scan('OPTION 3':PDESCR)
092400051011     C                   Eval      OPT#   =     'OPT 3'
092500051011     C                   Exsr      BuildOEP3A
092600051012      *
092700051012     C                   Z-add     *Zeros        PosX
092800051012     C                   Eval      PosX   = %Scan('opt 3':PDESCR)
092900051012     C                   Eval      OPT#   =     'OPT 3'
093000051012     C                   Exsr      BuildOEP3A
093100051012      *
093200051012     C                   Z-add     *Zeros        PosX
093300051012     C                   Eval      PosX   = %Scan('opt3':PDESCR)
093400051012     C                   Eval      OPT#   =     'OPT 3'
093500051012     C                   Exsr      BuildOEP3A
093600051012      *
093700051012     C                   Z-add     *Zeros        PosX
093800051012     C                   Eval      PosX   = %Scan('OPITON 3':PDESCR)
093900051012     C                   Eval      OPT#   =     'OPT 3'
094000051012     C                   Exsr      BuildOEP3A
094100051011      *
094200051011     C                   Z-add     *Zeros        PosX
094300051011     C                   Eval      PosX   = %Scan('OPT4 ':PDESCR)
094400051011     C                   Eval      OPT#   =     'OPT 4'
094500051011     C                   Exsr      BuildOEP3A
094600051014      *
094700051014     C                   Z-add     *Zeros        PosX
094800051014     C                   Eval      PosX   = %Scan('opt4 ':PDESCR)
094900051014     C                   Eval      OPT#   =     'OPT 4'
095000051014     C                   Exsr      BuildOEP3A
095100051012      *
095200051012     C                   Z-add     *Zeros        PosX
095300051012     C                   Eval      PosX   = %Scan('#4':PDESCR)
095400051012     C                   Eval      OPT#   =      'OPT 4'
095500051012     C                   Exsr      BuildOEP3A
095600051012      *
095700051011     C                   Z-add     *Zeros        PosX
095800051011     C                   Eval      PosX   = %Scan('OPT4#':PDESCR)
095900051011     C                   Eval      OPT#   =     'OPT 4'
096000051011     C                   Exsr      BuildOEP3A
096100051012      *
096200051012     C                   Z-add     *Zeros        PosX
096300051012     C                   Eval      PosX   = %Scan('OPT#4':PDESCR)
096400051012     C                   Eval      OPT#   =     'OPT 4'
096500051012     C                   Exsr      BuildOEP3A
096600051011      *
096700051011     C                   Z-add     *Zeros        PosX
096800051011     C                   Eval      PosX   = %Scan('OPT 4':PDESCR)
096900051011     C                   Eval      OPT#   =     'OPT 4'
097000051011     C                   Exsr      BuildOEP3A
097100051011      *
097200051011     C                   Z-add     *Zeros        PosX
097300051011     C                   Eval      PosX   = %Scan('OPTION 4':PDESCR)
097400051011     C                   Eval      OPT#   =     'OPT 4'
097500051011     C                   Exsr      BuildOEP3A
097600051014      *
097700051014     C                   Z-add     *Zeros        PosX
097800051014     C                   Eval      PosX   = %Scan('OPTION4':PDESCR)
097900051014     C                   Eval      OPT#   =     'OPT 4'
098000051014     C                   Exsr      BuildOEP3A
098100051011      *
098200051011     C                   Z-add     *Zeros        PosX
098300051011     C                   Eval      PosX   = %Scan('OPT5 ':PDESCR)
098400051011     C                   Eval      OPT#   =     'OPT 5'
098500051011     C                   Exsr      BuildOEP3A
098600051012      *
098700051012     C                   Z-add     *Zeros        PosX
098800051012     C                   Eval      PosX   = %Scan('#5':PDESCR)
098900051012     C                   Eval      OPT#   =      'OPT 5'
099000051012     C                   Exsr      BuildOEP3A
099100051011      *
099200051011     C                   Z-add     *Zeros        PosX
099300051011     C                   Eval      PosX   = %Scan('OPT5#':PDESCR)
099400051011     C                   Eval      OPT#   =     'OPT 5'
099500051011     C                   Exsr      BuildOEP3A
099600051011      *
099700051011     C                   Z-add     *Zeros        PosX
099800051011     C                   Eval      PosX   = %Scan('OPT 5':PDESCR)
099900051011     C                   Eval      OPT#   =     'OPT 5'
100000051011     C                   Exsr      BuildOEP3A
100100051011      *
100200051011     C                   Z-add     *Zeros        PosX
100300051011     C                   Eval      PosX   = %Scan('OPTION 5':PDESCR)
100400051011     C                   Eval      OPT#   =     'OPT 5'
100500051011     C                   Exsr      BuildOEP3A
100600051011      *
100700051011     C                   Z-add     *Zeros        PosX
100800051011     C                   Eval      PosX   = %Scan('OPT6 ':PDESCR)
100900051011     C                   Eval      OPT#   =     'OPT 6'
101000051011     C                   Exsr      BuildOEP3A
101100051012      *
101200051012     C                   Z-add     *Zeros        PosX
101300051012     C                   Eval      PosX   = %Scan('opt 6':PDESCR)
101400051012     C                   Eval      OPT#   =     'OPT 6'
101500051012     C                   Exsr      BuildOEP3A
101600051012      *
101700051012     C                   Z-add     *Zeros        PosX
101800051012     C                   Eval      PosX   = %Scan('opt6':PDESCR)
101900051012     C                   Eval      OPT#   =     'OPT 6'
102000051012     C                   Exsr      BuildOEP3A
102100051011      *
102200051011     C                   Z-add     *Zeros        PosX
102300051011     C                   Eval      PosX   = %Scan('OPT6#':PDESCR)
102400051011     C                   Eval      OPT#   =     'OPT 6'
102500051011     C                   Exsr      BuildOEP3A
102600051012      *
102700051012     C                   Z-add     *Zeros        PosX
102800051012     C                   Eval      PosX   = %Scan('OPT#6':PDESCR)
102900051012     C                   Eval      OPT#   =     'OPT 6'
103000051012     C                   Exsr      BuildOEP3A
103100051012      *
103200051011     C                   Z-add     *Zeros        PosX
103300051011     C                   Eval      PosX   = %Scan('OPT 6':PDESCR)
103400051011     C                   Eval      OPT#   =     'OPT 6'
103500051011     C                   Exsr      BuildOEP3A
103600051012      *
103700051012     C                   Z-add     *Zeros        PosX
103800051012     C                   Eval      PosX   = %Scan('OPTTON 6':PDESCR)
103900051012     C                   Eval      OPT#   =     'OPT 6'
104000051012     C                   Exsr      BuildOEP3A
104100051012      *
104200051012     C                   Z-add     *Zeros        PosX
104300051012     C                   Eval      PosX   = %Scan('#6':PDESCR)
104400051012     C                   Eval      OPT#   =     'OPT 6'
104500051012     C                   Exsr      BuildOEP3A
104600051012      *
104700051011     C                   Z-add     *Zeros        PosX
104800051011     C                   Eval      PosX   = %Scan('OPTION 6':PDESCR)
104900051011     C                   Eval      OPT#   =     'OPT 6'
105000051011     C                   Exsr      BuildOEP3A
105100051011      *
105200051011     C                   Z-add     *Zeros        PosX
105300051011     C                   Eval      PosX   = %Scan('OPT7 ':PDESCR)
105400051011     C                   Eval      OPT#   =     'OPT 7'
105500051011     C                   Exsr      BuildOEP3A
105600051012      *
105700051012     C                   Z-add     *Zeros        PosX
105800051012     C                   Eval      PosX   = %Scan('#7':PDESCR)
105900051012     C                   Eval      OPT#   =      'OPT 7'
106000051012     C                   Exsr      BuildOEP3A
106100051011      *
106200051011     C                   Z-add     *Zeros        PosX
106300051011     C                   Eval      PosX   = %Scan('OPT7#':PDESCR)
106400051011     C                   Eval      OPT#   =     'OPT 7'
106500051011     C                   Exsr      BuildOEP3A
106600051011      *
106700051011     C                   Z-add     *Zeros        PosX
106800051011     C                   Eval      PosX   = %Scan('OPT 7':PDESCR)
106900051011     C                   Eval      OPT#   =     'OPT 7'
107000051011     C                   Exsr      BuildOEP3A
107100051011      *
107200051011     C                   Z-add     *Zeros        PosX
107300051011     C                   Eval      PosX   = %Scan('OPTION 7':PDESCR)
107400051011     C                   Eval      OPT#   =     'OPT 7'
107500051011     C                   Exsr      BuildOEP3A
107600051011      *
107700051011     C                   Z-add     *Zeros        PosX
107800051011     C                   Eval      PosX   = %Scan('OPT8 ':PDESCR)
107900051011     C                   Eval      OPT#   =     'OPT 8'
108000051011     C                   Exsr      BuildOEP3A
108100051011      *
108200051011     C                   Z-add     *Zeros        PosX
108300051011     C                   Eval      PosX   = %Scan('OPT8#':PDESCR)
108400051011     C                   Eval      OPT#   =     'OPT 8'
108500051011     C                   Exsr      BuildOEP3A
108600051011      *
108700051011     C                   Z-add     *Zeros        PosX
108800051011     C                   Eval      PosX   = %Scan('OPT 8':PDESCR)
108900051011     C                   Eval      OPT#   =     'OPT 8'
109000051011     C                   Exsr      BuildOEP3A
109100051011      *
109200051011     C                   Z-add     *Zeros        PosX
109300051011     C                   Eval      PosX   = %Scan('OPTION 8':PDESCR)
109400051011     C                   Eval      OPT#   =     'OPT 8'
109500051011     C                   Exsr      BuildOEP3A
109600051011      *
109700051011     C                   Z-add     *Zeros        PosX
109800051011     C                   Eval      PosX   = %Scan('OPT9 ':PDESCR)
109900051011     C                   Eval      OPT#   =     'OPT 9'
110000051011     C                   Exsr      BuildOEP3A
110100051011      *
110200051011     C                   Z-add     *Zeros        PosX
110300051011     C                   Eval      PosX   = %Scan('OPT9#':PDESCR)
110400051011     C                   Eval      OPT#   =     'OPT 9'
110500051011     C                   Exsr      BuildOEP3A
110600051011      *
110700051011     C                   Z-add     *Zeros        PosX
110800051011     C                   Eval      PosX   = %Scan('OPT 9':PDESCR)
110900051011     C                   Eval      OPT#   =     'OPT 9'
111000051011     C                   Exsr      BuildOEP3A
111100051011      *
111200051011     C                   Z-add     *Zeros        PosX
111300051011     C                   Eval      PosX   = %Scan('OPTION 9':PDESCR)
111400051011     C                   Eval      OPT#   =     'OPT 9'
111500051011     C                   Exsr      BuildOEP3A
111600051011      *
111700051011     C                   Z-add     *Zeros        PosX
111800051011     C                   Eval      PosX   = %Scan('OPT10 ':PDESCR)
111900051011     C                   Eval      OPT#   =     'OPT 10'
112000051011     C                   Exsr      BuildOEP3A
112100051011      *
112200051011     C                   Z-add     *Zeros        PosX
112300051011     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
112400051011     C                   Eval      OPT#   =     'OPT 10'
112500051011     C                   Exsr      BuildOEP3A
112600051011      *
112700051011     C                   Z-add     *Zeros        PosX
112800051011     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
112900051011     C                   Eval      OPT#   =     'OPT 10'
113000051011     C                   Exsr      BuildOEP3A
113100051114      *
113200051114     C                   Z-add     *Zeros        PosX
113300051114     C                   Eval      PosX   = %Scan('#11':PDESCR)
113400051114     C                   Eval      OPT#   =     'OPT 11'
113500051114     C                   Exsr      BuildOEP3A
113600051011      *
113700051011     C                   Z-add     *Zeros        PosX
113800051011     C                   Eval      PosX   = %Scan('OPT11 ':PDESCR)
113900051011     C                   Eval      OPT#   =     'OPT 11'
114000051011     C                   Exsr      BuildOEP3A
114100051011      *
114200051011     C                   Z-add     *Zeros        PosX
114300051011     C                   Eval      PosX   = %Scan('OPT11#':PDESCR)
114400051011     C                   Eval      OPT#   =     'OPT 11'
114500051011     C                   Exsr      BuildOEP3A
114600051011      *
114700051011     C                   Z-add     *Zeros        PosX
114800051011     C                   Eval      PosX   = %Scan('OPT 11':PDESCR)
114900051011     C                   Eval      OPT#   =     'OPT 11'
115000051011     C                   Exsr      BuildOEP3A
115100051011      *
115200051011     C                   Z-add     *Zeros        PosX
115300051011     C                   Eval      PosX   = %Scan('OPT12 ':PDESCR)
115400051011     C                   Eval      OPT#   =     'OPT 12'
115500051011     C                   Exsr      BuildOEP3A
115600051012      *
115700051012     C                   Z-add     *Zeros        PosX
115800051012     C                   Eval      PosX   = %Scan('OPT12':PDESCR)
115900051012     C                   Eval      OPT#   =     'OPT 12'
116000051012     C                   Exsr      BuildOEP3A
116100051011      *
116200051011     C                   Z-add     *Zeros        PosX
116300051011     C                   Eval      PosX   = %Scan('OPT12#':PDESCR)
116400051011     C                   Eval      OPT#   =     'OPT 12'
116500051011     C                   Exsr      BuildOEP3A
116600051011      *
116700051011     C                   Z-add     *Zeros        PosX
116800051011     C                   Eval      PosX   = %Scan('OPT 12':PDESCR)
116900051011     C                   Eval      OPT#   =     'OPT 12'
117000051011     C                   Exsr      BuildOEP3A
117100051011      *
117200051011     C                   Z-add     *Zeros        PosX
117300051011     C                   Eval      PosX   = %Scan('OPT13 ':PDESCR)
117400051011     C                   Eval      OPT#   =     'OPT 13'
117500051011     C                   Exsr      BuildOEP3A
117600051011      *
117700051011     C                   Z-add     *Zeros        PosX
117800051011     C                   Eval      PosX   = %Scan('OPT13#':PDESCR)
117900051011     C                   Eval      OPT#   =     'OPT 13'
118000051011     C                   Exsr      BuildOEP3A
118100051011      *
118200051011     C                   Z-add     *Zeros        PosX
118300051011     C                   Eval      PosX   = %Scan('OPT 13':PDESCR)
118400051011     C                   Eval      OPT#   =     'OPT 13'
118500051011     C                   Exsr      BuildOEP3A
118600051011      *
118700051011     C                   Z-add     *Zeros        PosX
118800051011     C                   Eval      PosX   = %Scan('OPT14 ':PDESCR)
118900051012     C                   Eval      OPT#   =     'OPT 14'
119000051011     C                   Exsr      BuildOEP3A
119100051011      *
119200051011     C                   Z-add     *Zeros        PosX
119300051011     C                   Eval      PosX   = %Scan('OPT14#':PDESCR)
119400051011     C                   Eval      OPT#   =     'OPT 14'
119500051011     C                   Exsr      BuildOEP3A
119600051011      *
119700051011     C                   Z-add     *Zeros        PosX
119800051011     C                   Eval      PosX   = %Scan('OPT 14':PDESCR)
119900051011     C                   Eval      OPT#   =     'OPT 14'
120000051011     C                   Exsr      BuildOEP3A
120100051012      *
120200051012     C                   Z-add     *Zeros        PosX
120300051012     C                   Eval      PosX   = %Scan('OPTION 14':PDESCR)
120400051012     C                   Eval      OPT#   =     'OPT 14'
120500051012     C                   Exsr      BuildOEP3A
120600051011      *
120700051011     C                   Z-add     *Zeros        PosX
120800051011     C                   Eval      PosX   = %Scan('OPT15 ':PDESCR)
120900051011     C                   Eval      OPT#   =     'OPT 15'
121000051011     C                   Exsr      BuildOEP3A
121100051011      *
121200051011     C                   Z-add     *Zeros        PosX
121300051011     C                   Eval      PosX   = %Scan('OPT15#':PDESCR)
121400051011     C                   Eval      OPT#   =     'OPT 15'
121500051011     C                   Exsr      BuildOEP3A
121600051011      *
121700051011     C                   Z-add     *Zeros        PosX
121800051011     C                   Eval      PosX   = %Scan('OPT 15':PDESCR)
121900051011     C                   Eval      OPT#   =     'OPT 15'
122000051011     C                   Exsr      BuildOEP3A
122100051011      *
122200051011     C                   Z-add     *Zeros        PosX
122300051011     C                   Eval      PosX   = %Scan('OPT16 ':PDESCR)
122400051011     C                   Eval      OPT#   =     'OPT 16'
122500051011     C                   Exsr      BuildOEP3A
122600051011      *
122700051011     C                   Z-add     *Zeros        PosX
122800051011     C                   Eval      PosX   = %Scan('OPT16#':PDESCR)
122900051011     C                   Eval      OPT#   =     'OPT 16'
123000051011     C                   Exsr      BuildOEP3A
123100051011      *
123200051011     C                   Z-add     *Zeros        PosX
123300051011     C                   Eval      PosX   = %Scan('OPT 16':PDESCR)
123400051011     C                   Eval      OPT#   =     'OPT 16'
123500051011     C                   Exsr      BuildOEP3A
123600051011      *
123700051011     C                   Z-add     *Zeros        PosX
123800051011     C                   Eval      PosX   = %Scan('OPT17 ':PDESCR)
123900051011     C                   Eval      OPT#   =     'OPT 17'
124000051011     C                   Exsr      BuildOEP3A
124100051011      *
124200051011     C                   Z-add     *Zeros        PosX
124300051011     C                   Eval      PosX   = %Scan('OPT17#':PDESCR)
124400051011     C                   Eval      OPT#   =     'OPT 17'
124500051011     C                   Exsr      BuildOEP3A
124600051011      *
124700051011     C                   Z-add     *Zeros        PosX
124800051011     C                   Eval      PosX   = %Scan('OPT 17':PDESCR)
124900051011     C                   Eval      OPT#   =     'OPT 17'
125000051011     C                   Exsr      BuildOEP3A
125100051011     C                   EndSR
125200051011      *
125300051110      *
125400051110     C     BuildOwzP3    Begsr
125500051110     C                   Clear                   OPT#
125600051110     C                   Z-add     *Zeros        PosX
125700051110     C                   Eval      PosX   = %Scan('OPT1 ':PDESCR)
125800051110     C                   Eval      OPT#   =      'OPT 1'
125900051110     C                   Exsr      BuildOwzP3A
126000051110      *
126100051110     C                   Z-add     *Zeros        PosX
126200051110     C                   Eval      PosX   = %Scan('OPT# 1':PDESCR)
126300051110     C                   Eval      OPT#   =     'OPT 1'
126400051110     C                   Exsr      BuildOwzP3A
126500051110      *
126600051110     C                   Z-add     *Zeros        PosX
126700051116     C                   Eval      PosX   = %Scan('#1 ':PDESCR)
126800051110     C                   Eval      OPT#   =      'OPT 1'
126900051110     C                   Exsr      BuildOwzP3A
127000051110      *
127100051110     C                   Z-add     *Zeros        PosX
127200051116     C                   Eval      PosX   = %Scan('OPT#1 ':PDESCR)
127300051110     C                   Eval      OPT#   =     'OPT 1'
127400051110     C                   Exsr      BuildOwzP3A
127500051110      *
127600051110     C                   Z-add     *Zeros        PosX
127700051116     C                   Eval      PosX   = %Scan('OPT 1 ':PDESCR)
127800051110     C                   Eval      OPT#   =     'OPT 1'
127900051110     C                   Exsr      BuildOwzP3A
128000051110      *
128100051110     C                   Z-add     *Zeros        PosX
128200051116     C                   Eval      PosX   = %Scan('OPTION 1 ':PDESCR)
128300051110     C                   Eval      OPT#   =     'OPT 1'
128400051110     C                   Exsr      BuildOwzP3A
128500051110      *
128600051110     C                   Z-add     *Zeros        PosX
128700051110     C                   Eval      PosX   = %Scan('OPT2 ':PDESCR)
128800051110     C                   Eval      OPT#   =     'OPT 2'
128900051110     C                   Exsr      BuildOwzP3A
129000051110      *
129100051110     C                   Z-add     *Zeros        PosX
129200051110     C                   Eval      PosX   = %Scan('OP2 ':PDESCR)
129300051110     C                   Eval      OPT#   =     'OPT 2'
129400051110     C                   Exsr      BuildOwzP3A
129500051110      *
129600051110     C                   Z-add     *Zeros        PosX
129700051110     C                   Eval      PosX   = %Scan('OPT#2':PDESCR)
129800051110     C                   Eval      OPT#   =     'OPT 2'
129900051110     C                   Exsr      BuildOwzP3A
130000051110      *
130100051110     C                   Z-add     *Zeros        PosX
130200051110     C                   Eval      PosX   = %Scan('#2':PDESCR)
130300051110     C                   Eval      OPT#   =      'OPT 2'
130400051110     C                   Exsr      BuildOwzP3A
130500051110      *
130600051110     C                   Z-add     *Zeros        PosX
130700051110     C                   Eval      PosX   = %Scan('OPT2#':PDESCR)
130800051110     C                   Eval      OPT#   =     'OPT 2'
130900051110     C                   Exsr      BuildOwzP3A
131000051110      *
131100051110     C                   Z-add     *Zeros        PosX
131200051110     C                   Eval      PosX   = %Scan('OPT 2':PDESCR)
131300051110     C                   Eval      OPT#   =     'OPT 2'
131400051110     C                   Exsr      BuildOwzP3A
131500051110      *
131600051110     C                   Z-add     *Zeros        PosX
131700051110     C                   Eval      PosX   = %Scan('OPTION 2':PDESCR)
131800051110     C                   Eval      OPT#   =     'OPT 2'
131900051110     C                   Exsr      BuildOwzP3A
132000051110      *
132100051110     C                   Z-add     *Zeros        PosX
132200051110     C                   Eval      PosX   = %Scan('opt 2':PDESCR)
132300051110     C                   Eval      OPT#   =     'OPT 2'
132400051110     C                   Exsr      BuildOwzP3A
132500051110      *
132600051110     C                   Z-add     *Zeros        PosX
132700051110     C                   Eval      PosX   = %Scan('opt2':PDESCR)
132800051110     C                   Eval      OPT#   =     'OPT 2'
132900051110     C                   Exsr      BuildOwzP3A
133000051110      *
133100051110     C                   Z-add     *Zeros        PosX
133200051110     C                   Eval      PosX   = %Scan('OPT3':PDESCR)
133300051110     C                   Eval      OPT#   =     'OPT 3'
133400051110     C                   Exsr      BuildOwzP3A
133500051110      *
133600051110     C                   Z-add     *Zeros        PosX
133700051110     C                   Eval      PosX   = %Scan('OPT3#':PDESCR)
133800051110     C                   Eval      OPT#   =     'OPT 3'
133900051110     C                   Exsr      BuildOwzP3A
134000051110      *
134100051110     C                   Z-add     *Zeros        PosX
134200051110     C                   Eval      PosX   = %Scan('#3':PDESCR)
134300051110     C                   Eval      OPT#   =      'OPT 3'
134400051110     C                   Exsr      BuildOwzP3A
134500051110      *
134600051110     C                   Z-add     *Zeros        PosX
134700051110     C                   Eval      PosX   = %Scan('OPT 3':PDESCR)
134800051110     C                   Eval      OPT#   =     'OPT 3'
134900051110     C                   Exsr      BuildOwzP3A
135000051110      *
135100051110     C                   Z-add     *Zeros        PosX
135200051110     C                   Eval      PosX   = %Scan('OPTION 3':PDESCR)
135300051110     C                   Eval      OPT#   =     'OPT 3'
135400051110     C                   Exsr      BuildOwzP3A
135500051110      *
135600051110     C                   Z-add     *Zeros        PosX
135700051110     C                   Eval      PosX   = %Scan('opt 3':PDESCR)
135800051110     C                   Eval      OPT#   =     'OPT 3'
135900051110     C                   Exsr      BuildOwzP3A
136000051110      *
136100051110     C                   Z-add     *Zeros        PosX
136200051110     C                   Eval      PosX   = %Scan('opt3':PDESCR)
136300051110     C                   Eval      OPT#   =     'OPT 3'
136400051110     C                   Exsr      BuildOwzP3A
136500051110      *
136600051110     C                   Z-add     *Zeros        PosX
136700051110     C                   Eval      PosX   = %Scan('OPITON 3':PDESCR)
136800051110     C                   Eval      OPT#   =     'OPT 3'
136900051110     C                   Exsr      BuildOwzP3A
137000051110      *
137100051110     C                   Z-add     *Zeros        PosX
137200051110     C                   Eval      PosX   = %Scan('OPT4 ':PDESCR)
137300051110     C                   Eval      OPT#   =     'OPT 4'
137400051110     C                   Exsr      BuildOwzP3A
137500051110      *
137600051110     C                   Z-add     *Zeros        PosX
137700051110     C                   Eval      PosX   = %Scan('opt4 ':PDESCR)
137800051110     C                   Eval      OPT#   =     'OPT 4'
137900051110     C                   Exsr      BuildOwzP3A
138000051110      *
138100051110     C                   Z-add     *Zeros        PosX
138200051110     C                   Eval      PosX   = %Scan('#4':PDESCR)
138300051110     C                   Eval      OPT#   =      'OPT 4'
138400051110     C                   Exsr      BuildOwzP3A
138500051110      *
138600051110     C                   Z-add     *Zeros        PosX
138700051110     C                   Eval      PosX   = %Scan('OPT4#':PDESCR)
138800051110     C                   Eval      OPT#   =     'OPT 4'
138900051110     C                   Exsr      BuildOwzP3A
139000051110      *
139100051110     C                   Z-add     *Zeros        PosX
139200051110     C                   Eval      PosX   = %Scan('OPT#4':PDESCR)
139300051110     C                   Eval      OPT#   =     'OPT 4'
139400051110     C                   Exsr      BuildOwzP3A
139500051110      *
139600051110     C                   Z-add     *Zeros        PosX
139700051110     C                   Eval      PosX   = %Scan('OPT 4':PDESCR)
139800051110     C                   Eval      OPT#   =     'OPT 4'
139900051110     C                   Exsr      BuildOwzP3A
140000051110      *
140100051110     C                   Z-add     *Zeros        PosX
140200051110     C                   Eval      PosX   = %Scan('OPTION 4':PDESCR)
140300051110     C                   Eval      OPT#   =     'OPT 4'
140400051110     C                   Exsr      BuildOwzP3A
140500051110      *
140600051110     C                   Z-add     *Zeros        PosX
140700051110     C                   Eval      PosX   = %Scan('OPTION4':PDESCR)
140800051110     C                   Eval      OPT#   =     'OPT 4'
140900051110     C                   Exsr      BuildOwzP3A
141000051110      *
141100051110     C                   Z-add     *Zeros        PosX
141200051110     C                   Eval      PosX   = %Scan('OPT5 ':PDESCR)
141300051110     C                   Eval      OPT#   =     'OPT 5'
141400051110     C                   Exsr      BuildOwzP3A
141500051110      *
141600051110     C                   Z-add     *Zeros        PosX
141700051110     C                   Eval      PosX   = %Scan('#5':PDESCR)
141800051110     C                   Eval      OPT#   =      'OPT 5'
141900051110     C                   Exsr      BuildOwzP3A
142000051110      *
142100051110     C                   Z-add     *Zeros        PosX
142200051110     C                   Eval      PosX   = %Scan('OPT5#':PDESCR)
142300051110     C                   Eval      OPT#   =     'OPT 5'
142400051110     C                   Exsr      BuildOwzP3A
142500051110      *
142600051110     C                   Z-add     *Zeros        PosX
142700051110     C                   Eval      PosX   = %Scan('OPT 5':PDESCR)
142800051110     C                   Eval      OPT#   =     'OPT 5'
142900051110     C                   Exsr      BuildOwzP3A
143000051110      *
143100051110     C                   Z-add     *Zeros        PosX
143200051110     C                   Eval      PosX   = %Scan('OPTION 5':PDESCR)
143300051110     C                   Eval      OPT#   =     'OPT 5'
143400051110     C                   Exsr      BuildOwzP3A
143500051110      *
143600051110     C                   Z-add     *Zeros        PosX
143700051110     C                   Eval      PosX   = %Scan('OPT6 ':PDESCR)
143800051110     C                   Eval      OPT#   =     'OPT 6'
143900051110     C                   Exsr      BuildOwzP3A
144000051110      *
144100051110     C                   Z-add     *Zeros        PosX
144200051110     C                   Eval      PosX   = %Scan('opt 6':PDESCR)
144300051110     C                   Eval      OPT#   =     'OPT 6'
144400051110     C                   Exsr      BuildOwzP3A
144500051110      *
144600051110     C                   Z-add     *Zeros        PosX
144700051110     C                   Eval      PosX   = %Scan('opt6':PDESCR)
144800051110     C                   Eval      OPT#   =     'OPT 6'
144900051110     C                   Exsr      BuildOwzP3A
145000051110      *
145100051110     C                   Z-add     *Zeros        PosX
145200051110     C                   Eval      PosX   = %Scan('OPT6#':PDESCR)
145300051110     C                   Eval      OPT#   =     'OPT 6'
145400051110     C                   Exsr      BuildOwzP3A
145500051110      *
145600051110     C                   Z-add     *Zeros        PosX
145700051110     C                   Eval      PosX   = %Scan('OPT#6':PDESCR)
145800051110     C                   Eval      OPT#   =     'OPT 6'
145900051110     C                   Exsr      BuildOwzP3A
146000051110      *
146100051110     C                   Z-add     *Zeros        PosX
146200051110     C                   Eval      PosX   = %Scan('OPT 6':PDESCR)
146300051110     C                   Eval      OPT#   =     'OPT 6'
146400051110     C                   Exsr      BuildOwzP3A
146500051110      *
146600051110     C                   Z-add     *Zeros        PosX
146700051110     C                   Eval      PosX   = %Scan('OPTTON 6':PDESCR)
146800051110     C                   Eval      OPT#   =     'OPT 6'
146900051110     C                   Exsr      BuildOwzP3A
147000051110      *
147100051110     C                   Z-add     *Zeros        PosX
147200051110     C                   Eval      PosX   = %Scan('#6':PDESCR)
147300051110     C                   Eval      OPT#   =     'OPT 6'
147400051110     C                   Exsr      BuildOwzP3A
147500051110      *
147600051110     C                   Z-add     *Zeros        PosX
147700051110     C                   Eval      PosX   = %Scan('OPTION 6':PDESCR)
147800051110     C                   Eval      OPT#   =     'OPT 6'
147900051110     C                   Exsr      BuildOwzP3A
148000051110      *
148100051110     C                   Z-add     *Zeros        PosX
148200051110     C                   Eval      PosX   = %Scan('OPT7 ':PDESCR)
148300051110     C                   Eval      OPT#   =     'OPT 7'
148400051110     C                   Exsr      BuildOwzP3A
148500051110      *
148600051110     C                   Z-add     *Zeros        PosX
148700051110     C                   Eval      PosX   = %Scan('#7':PDESCR)
148800051110     C                   Eval      OPT#   =      'OPT 7'
148900051110     C                   Exsr      BuildOwzP3A
149000051110      *
149100051110     C                   Z-add     *Zeros        PosX
149200051110     C                   Eval      PosX   = %Scan('OPT7#':PDESCR)
149300051110     C                   Eval      OPT#   =     'OPT 7'
149400051110     C                   Exsr      BuildOwzP3A
149500051110      *
149600051110     C                   Z-add     *Zeros        PosX
149700051110     C                   Eval      PosX   = %Scan('OPT 7':PDESCR)
149800051110     C                   Eval      OPT#   =     'OPT 7'
149900051110     C                   Exsr      BuildOwzP3A
150000051110      *
150100051110     C                   Z-add     *Zeros        PosX
150200051110     C                   Eval      PosX   = %Scan('OPTION 7':PDESCR)
150300051110     C                   Eval      OPT#   =     'OPT 7'
150400051110     C                   Exsr      BuildOwzP3A
150500051110      *
150600051110     C                   Z-add     *Zeros        PosX
150700051110     C                   Eval      PosX   = %Scan('OPT8 ':PDESCR)
150800051110     C                   Eval      OPT#   =     'OPT 8'
150900051110     C                   Exsr      BuildOwzP3A
151000051110      *
151100051110     C                   Z-add     *Zeros        PosX
151200051110     C                   Eval      PosX   = %Scan('OPT8#':PDESCR)
151300051110     C                   Eval      OPT#   =     'OPT 8'
151400051110     C                   Exsr      BuildOwzP3A
151500051110      *
151600051110     C                   Z-add     *Zeros        PosX
151700051110     C                   Eval      PosX   = %Scan('OPT 8':PDESCR)
151800051110     C                   Eval      OPT#   =     'OPT 8'
151900051110     C                   Exsr      BuildOwzP3A
152000051110      *
152100051110     C                   Z-add     *Zeros        PosX
152200051110     C                   Eval      PosX   = %Scan('OPTION 8':PDESCR)
152300051110     C                   Eval      OPT#   =     'OPT 8'
152400051110     C                   Exsr      BuildOwzP3A
152500051110      *
152600051110     C                   Z-add     *Zeros        PosX
152700051110     C                   Eval      PosX   = %Scan('OPT9 ':PDESCR)
152800051110     C                   Eval      OPT#   =     'OPT 9'
152900051110     C                   Exsr      BuildOwzP3A
153000051110      *
153100051110     C                   Z-add     *Zeros        PosX
153200051110     C                   Eval      PosX   = %Scan('OPT9#':PDESCR)
153300051110     C                   Eval      OPT#   =     'OPT 9'
153400051110     C                   Exsr      BuildOwzP3A
153500051110      *
153600051110     C                   Z-add     *Zeros        PosX
153700051110     C                   Eval      PosX   = %Scan('OPT 9':PDESCR)
153800051110     C                   Eval      OPT#   =     'OPT 9'
153900051110     C                   Exsr      BuildOwzP3A
154000051110      *
154100051110     C                   Z-add     *Zeros        PosX
154200051110     C                   Eval      PosX   = %Scan('OPTION 9':PDESCR)
154300051110     C                   Eval      OPT#   =     'OPT 9'
154400051110     C                   Exsr      BuildOwzP3A
154500051110      *
154600051110     C                   Z-add     *Zeros        PosX
154700051110     C                   Eval      PosX   = %Scan('OPT10 ':PDESCR)
154800051110     C                   Eval      OPT#   =     'OPT 10'
154900051110     C                   Exsr      BuildOwzP3A
155000051110      *
155100051110     C                   Z-add     *Zeros        PosX
155200051110     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
155300051110     C                   Eval      OPT#   =     'OPT 10'
155400051110     C                   Exsr      BuildOwzP3A
155500051110      *
155600051110     C                   Z-add     *Zeros        PosX
155700051110     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
155800051110     C                   Eval      OPT#   =     'OPT 10'
155900051110     C                   Exsr      BuildOwzP3A
156000051110      *
156100051110     C                   Z-add     *Zeros        PosX
156200051110     C                   Eval      PosX   = %Scan('OPT11 ':PDESCR)
156300051110     C                   Eval      OPT#   =     'OPT 11'
156400051110     C                   Exsr      BuildOwzP3A
156500051110      *
156600051110     C                   Z-add     *Zeros        PosX
156700051110     C                   Eval      PosX   = %Scan('OPT11#':PDESCR)
156800051110     C                   Eval      OPT#   =     'OPT 11'
156900051110     C                   Exsr      BuildOwzP3A
157000051110      *
157100051110     C                   Z-add     *Zeros        PosX
157200051110     C                   Eval      PosX   = %Scan('OPT 11':PDESCR)
157300051110     C                   Eval      OPT#   =     'OPT 11'
157400051110     C                   Exsr      BuildOwzP3A
157500051110      *
157600051110     C                   Z-add     *Zeros        PosX
157700051110     C                   Eval      PosX   = %Scan('OPT12 ':PDESCR)
157800051110     C                   Eval      OPT#   =     'OPT 12'
157900051110     C                   Exsr      BuildOwzP3A
158000051110      *
158100051110     C                   Z-add     *Zeros        PosX
158200051110     C                   Eval      PosX   = %Scan('OPT12':PDESCR)
158300051110     C                   Eval      OPT#   =     'OPT 12'
158400051110     C                   Exsr      BuildOwzP3A
158500051110      *
158600051110     C                   Z-add     *Zeros        PosX
158700051110     C                   Eval      PosX   = %Scan('OPT12#':PDESCR)
158800051110     C                   Eval      OPT#   =     'OPT 12'
158900051110     C                   Exsr      BuildOwzP3A
159000051110      *
159100051110     C                   Z-add     *Zeros        PosX
159200051110     C                   Eval      PosX   = %Scan('OPT 12':PDESCR)
159300051110     C                   Eval      OPT#   =     'OPT 12'
159400051110     C                   Exsr      BuildOwzP3A
159500051110      *
159600051110     C                   Z-add     *Zeros        PosX
159700051110     C                   Eval      PosX   = %Scan('OPT13 ':PDESCR)
159800051110     C                   Eval      OPT#   =     'OPT 13'
159900051110     C                   Exsr      BuildOwzP3A
160000051110      *
160100051110     C                   Z-add     *Zeros        PosX
160200051110     C                   Eval      PosX   = %Scan('OPT13#':PDESCR)
160300051110     C                   Eval      OPT#   =     'OPT 13'
160400051110     C                   Exsr      BuildOwzP3A
160500051110      *
160600051110     C                   Z-add     *Zeros        PosX
160700051110     C                   Eval      PosX   = %Scan('OPT 13':PDESCR)
160800051110     C                   Eval      OPT#   =     'OPT 13'
160900051110     C                   Exsr      BuildOwzP3A
161000051110      *
161100051110     C                   Z-add     *Zeros        PosX
161200051110     C                   Eval      PosX   = %Scan('OPT14 ':PDESCR)
161300051110     C                   Eval      OPT#   =     'OPT 14'
161400051110     C                   Exsr      BuildOwzP3A
161500051110      *
161600051110     C                   Z-add     *Zeros        PosX
161700051110     C                   Eval      PosX   = %Scan('OPT14#':PDESCR)
161800051110     C                   Eval      OPT#   =     'OPT 14'
161900051110     C                   Exsr      BuildOwzP3A
162000051110      *
162100051110     C                   Z-add     *Zeros        PosX
162200051110     C                   Eval      PosX   = %Scan('OPT 14':PDESCR)
162300051110     C                   Eval      OPT#   =     'OPT 14'
162400051110     C                   Exsr      BuildOwzP3A
162500051110      *
162600051110     C                   Z-add     *Zeros        PosX
162700051110     C                   Eval      PosX   = %Scan('OPTION 14':PDESCR)
162800051110     C                   Eval      OPT#   =     'OPT 14'
162900051110     C                   Exsr      BuildOwzP3A
163000051110      *
163100051110     C                   Z-add     *Zeros        PosX
163200051110     C                   Eval      PosX   = %Scan('OPT15 ':PDESCR)
163300051110     C                   Eval      OPT#   =     'OPT 15'
163400051110     C                   Exsr      BuildOwzP3A
163500051110      *
163600051110     C                   Z-add     *Zeros        PosX
163700051110     C                   Eval      PosX   = %Scan('OPT15#':PDESCR)
163800051110     C                   Eval      OPT#   =     'OPT 15'
163900051110     C                   Exsr      BuildOwzP3A
164000051110      *
164100051110     C                   Z-add     *Zeros        PosX
164200051110     C                   Eval      PosX   = %Scan('OPT 15':PDESCR)
164300051110     C                   Eval      OPT#   =     'OPT 15'
164400051110     C                   Exsr      BuildOwzP3A
164500051110      *
164600051110     C                   Z-add     *Zeros        PosX
164700051110     C                   Eval      PosX   = %Scan('OPT16 ':PDESCR)
164800051110     C                   Eval      OPT#   =     'OPT 16'
164900051110     C                   Exsr      BuildOwzP3A
165000051110      *
165100051110     C                   Z-add     *Zeros        PosX
165200051110     C                   Eval      PosX   = %Scan('OPT16#':PDESCR)
165300051110     C                   Eval      OPT#   =     'OPT 16'
165400051110     C                   Exsr      BuildOwzP3A
165500051110      *
165600051110     C                   Z-add     *Zeros        PosX
165700051110     C                   Eval      PosX   = %Scan('OPT 16':PDESCR)
165800051110     C                   Eval      OPT#   =     'OPT 16'
165900051110     C                   Exsr      BuildOwzP3A
166000051110      *
166100051110     C                   Z-add     *Zeros        PosX
166200051110     C                   Eval      PosX   = %Scan('OPT17 ':PDESCR)
166300051110     C                   Eval      OPT#   =     'OPT 17'
166400051110     C                   Exsr      BuildOwzP3A
166500051110      *
166600051110     C                   Z-add     *Zeros        PosX
166700051110     C                   Eval      PosX   = %Scan('OPT17#':PDESCR)
166800051110     C                   Eval      OPT#   =     'OPT 17'
166900051110     C                   Exsr      BuildOwzP3A
167000051110      *
167100051110     C                   Z-add     *Zeros        PosX
167200051110     C                   Eval      PosX   = %Scan('OPT 17':PDESCR)
167300051110     C                   Eval      OPT#   =     'OPT 17'
167400051110     C                   Exsr      BuildOwzP3A
167500051110     C                   EndSR
167600051110      *
167700051012     C     BuildOEP5     Begsr
167800051012     C                   Clear                   OPT#              6
167900051012     C                   Z-add     *Zeros        PosX
168000051012     C                   Eval      PosX   = %Scan('OPT1 ':PDESCR)
168100051012     C                   Eval      OPT#   =      'OPT 1'
168200051012     C                   Exsr      BuildOEP5A
168300051012      *
168400051012     C                   Z-add     *Zeros        PosX
168500051012     C                   Eval      PosX   = %Scan('OPT1':PDESCR)
168600051012     C                   Eval      OPT#   =      'OPT 1'
168700051012     C                   Exsr      BuildOEP5A
168800051012      *
168900051012     C                   Z-add     *Zeros        PosX
169000051012     C                   Eval      PosX   = %Scan('OPT#1':PDESCR)
169100051012     C                   Eval      OPT#   =     'OPT 1'
169200051012     C                   Exsr      BuildOEP5A
169300051012      *
169400051012     C                   Z-add     *Zeros        PosX
169500051012     C                   Eval      PosX   = %Scan('OPT# 1':PDESCR)
169600051012     C                   Eval      OPT#   =     'OPT 1'
169700051012     C                   Exsr      BuildOEP5A
169800051012      *
169900051012     C                   Z-add     *Zeros        PosX
170000051012     C                   Eval      PosX   = %Scan('OPT 1':PDESCR)
170100051012     C                   Eval      OPT#   =     'OPT 1'
170200051012     C                   Exsr      BuildOEP5A
170300051012      *
170400051012     C                   Z-add     *Zeros        PosX
170500051012     C                   Eval      PosX   = %Scan('OPTION 1':PDESCR)
170600051012     C                   Eval      OPT#   =     'OPT 1'
170700051012     C                   Exsr      BuildOEP5A
170800051012      *
170900051012     C                   Z-add     *Zeros        PosX
171000051012     C                   Eval      PosX   = %Scan('OPT#2':PDESCR)
171100051012     C                   Eval      OPT#   =     'OPT 2'
171200051012     C                   Exsr      BuildOEP5A
171300051012      *
171400051012     C                   Z-add     *Zeros        PosX
171500051012     C                   Eval      PosX   = %Scan('OPT2 ':PDESCR)
171600051012     C                   Eval      OPT#   =     'OPT 2'
171700051012     C                   Exsr      BuildOEP5A
171800051012      *
171900051012     C                   Z-add     *Zeros        PosX
172000051012     C                   Eval      PosX   = %Scan('OP2 ':PDESCR)
172100051012     C                   Eval      OPT#   =     'OPT 2'
172200051012     C                   Exsr      BuildOEP5A
172300051012      *
172400051012     C                   Z-add     *Zeros        PosX
172500051012     C                   Eval      PosX   = %Scan('#2':PDESCR)
172600051012     C                   Eval      OPT#   =      'OPT 2'
172700051012     C                   Exsr      BuildOEP5A
172800051012      *
172900051012     C                   Z-add     *Zeros        PosX
173000051012     C                   Eval      PosX   = %Scan('OPT2#':PDESCR)
173100051012     C                   Eval      OPT#   =     'OPT 2'
173200051012     C                   Exsr      BuildOEP5A
173300051012      *
173400051012     C                   Z-add     *Zeros        PosX
173500051012     C                   Eval      PosX   = %Scan('OPT2':PDESCR)
173600051012     C                   Eval      OPT#   =      'OPT 2'
173700051012     C                   Exsr      BuildOEP5A
173800051012      *
173900051012     C                   Z-add     *Zeros        PosX
174000051012     C                   Eval      PosX   = %Scan('OPT 2':PDESCR)
174100051012     C                   Eval      OPT#   =     'OPT 2'
174200051012     C                   Exsr      BuildOEP5A
174300051012      *
174400051012     C                   Z-add     *Zeros        PosX
174500051012     C                   Eval      PosX   = %Scan('OPTION 2':PDESCR)
174600051012     C                   Eval      OPT#   =     'OPT 2'
174700051012     C                   Exsr      BuildOEP5A
174800051012      *
174900051012     C                   Z-add     *Zeros        PosX
175000051012     C                   Eval      PosX   = %Scan('OPT3':PDESCR)
175100051012     C                   Eval      OPT#   =     'OPT 3'
175200051012     C                   Exsr      BuildOEP5A
175300051012      *
175400051012     C                   Z-add     *Zeros        PosX
175500051012     C                   Eval      PosX   = %Scan('OPT3':PDESCR)
175600051012     C                   Eval      OPT#   =      'OPT 3'
175700051012     C                   Exsr      BuildOEP5A
175800051012      *
175900051012     C                   Z-add     *Zeros        PosX
176000051012     C                   Eval      PosX   = %Scan('#3':PDESCR)
176100051012     C                   Eval      OPT#   =      'OPT 3'
176200051012     C                   Exsr      BuildOEP5A
176300051012      *
176400051012     C                   Z-add     *Zeros        PosX
176500051012     C                   Eval      PosX   = %Scan('OPT3#':PDESCR)
176600051012     C                   Eval      OPT#   =     'OPT 3'
176700051012     C                   Exsr      BuildOEP5A
176800051012      *
176900051012     C                   Z-add     *Zeros        PosX
177000051012     C                   Eval      PosX   = %Scan('OPT 3':PDESCR)
177100051012     C                   Eval      OPT#   =     'OPT 3'
177200051012     C                   Exsr      BuildOEP5A
177300051012      *
177400051012     C                   Z-add     *Zeros        PosX
177500051012     C                   Eval      PosX   = %Scan('OPTION 3':PDESCR)
177600051012     C                   Eval      OPT#   =     'OPT 3'
177700051012     C                   Exsr      BuildOEP5A
177800051012      *
177900051012     C                   Z-add     *Zeros        PosX
178000051012     C                   Eval      PosX   = %Scan('OPITON 3':PDESCR)
178100051012     C                   Eval      OPT#   =     'OPT 3'
178200051012     C                   Exsr      BuildOEP5A
178300051012      *
178400051012     C                   Z-add     *Zeros        PosX
178500051012     C                   Eval      PosX   = %Scan('OPT4 ':PDESCR)
178600051012     C                   Eval      OPT#   =     'OPT 4'
178700051012     C                   Exsr      BuildOEP5A
178800051014      *
178900051014     C                   Z-add     *Zeros        PosX
179000051014     C                   Eval      PosX   = %Scan('opt4 ':PDESCR)
179100051014     C                   Eval      OPT#   =     'OPT 4'
179200051014     C                   Exsr      BuildOEP5A
179300051012      *
179400051012     C                   Z-add     *Zeros        PosX
179500051012     C                   Eval      PosX   = %Scan('OPT#4':PDESCR)
179600051012     C                   Eval      OPT#   =      'OPT 4'
179700051012     C                   Exsr      BuildOEP5A
179800051012      *
179900051012     C                   Z-add     *Zeros        PosX
180000051012     C                   Eval      PosX   = %Scan('#4':PDESCR)
180100051012     C                   Eval      OPT#   =      'OPT 4'
180200051012     C                   Exsr      BuildOEP5A
180300051012      *
180400051012     C                   Z-add     *Zeros        PosX
180500051012     C                   Eval      PosX   = %Scan('OPT4':PDESCR)
180600051012     C                   Eval      OPT#   =      'OPT 4'
180700051012     C                   Exsr      BuildOEP5A
180800051012      *
180900051012     C                   Z-add     *Zeros        PosX
181000051012     C                   Eval      PosX   = %Scan('OPT4#':PDESCR)
181100051012     C                   Eval      OPT#   =     'OPT 4'
181200051012     C                   Exsr      BuildOEP5A
181300051012      *
181400051012     C                   Z-add     *Zeros        PosX
181500051012     C                   Eval      PosX   = %Scan('OPT 4':PDESCR)
181600051012     C                   Eval      OPT#   =     'OPT 4'
181700051012     C                   Exsr      BuildOEP5A
181800051012      *
181900051012     C                   Z-add     *Zeros        PosX
182000051012     C                   Eval      PosX   = %Scan('OPTION 4':PDESCR)
182100051012     C                   Eval      OPT#   =     'OPT 4'
182200051012     C                   Exsr      BuildOEP5A
182300051014      *
182400051014     C                   Z-add     *Zeros        PosX
182500051014     C                   Eval      PosX   = %Scan('OPTION4':PDESCR)
182600051014     C                   Eval      OPT#   =     'OPT 4'
182700051014     C                   Exsr      BuildOEP5A
182800051012      *
182900051012     C                   Z-add     *Zeros        PosX
183000051012     C                   Eval      PosX   = %Scan('OPT5 ':PDESCR)
183100051012     C                   Eval      OPT#   =     'OPT 5'
183200051012     C                   Exsr      BuildOEP5A
183300051012      *
183400051012     C                   Z-add     *Zeros        PosX
183500051012     C                   Eval      PosX   = %Scan('#5':PDESCR)
183600051012     C                   Eval      OPT#   =      'OPT 5'
183700051012     C                   Exsr      BuildOEP5A
183800051012      *
183900051012     C                   Z-add     *Zeros        PosX
184000051012     C                   Eval      PosX   = %Scan('OPT5':PDESCR)
184100051012     C                   Eval      OPT#   =      'OPT 5'
184200051012     C                   Exsr      BuildOEP5A
184300051012      *
184400051012     C                   Z-add     *Zeros        PosX
184500051012     C                   Eval      PosX   = %Scan('OPT5#':PDESCR)
184600051012     C                   Eval      OPT#   =     'OPT 5'
184700051012     C                   Exsr      BuildOEP5A
184800051012      *
184900051012     C                   Z-add     *Zeros        PosX
185000051012     C                   Eval      PosX   = %Scan('OPT 5':PDESCR)
185100051012     C                   Eval      OPT#   =     'OPT 5'
185200051012     C                   Exsr      BuildOEP5A
185300051012      *
185400051012     C                   Z-add     *Zeros        PosX
185500051012     C                   Eval      PosX   = %Scan('OPTION 5':PDESCR)
185600051012     C                   Eval      OPT#   =     'OPT 5'
185700051012     C                   Exsr      BuildOEP5A
185800051012      *
185900051012     C                   Z-add     *Zeros        PosX
186000051012     C                   Eval      PosX   = %Scan('OPT6 ':PDESCR)
186100051012     C                   Eval      OPT#   =     'OPT 6'
186200051012     C                   Exsr      BuildOEP5A
186300051012      *
186400051012     C                   Z-add     *Zeros        PosX
186500051012     C                   Eval      PosX   = %Scan('OPT6':PDESCR)
186600051012     C                   Eval      OPT#   =      'OPT 6'
186700051012     C                   Exsr      BuildOEP5A
186800051012      *
186900051012     C                   Z-add     *Zeros        PosX
187000051012     C                   Eval      PosX   = %Scan('OPT6#':PDESCR)
187100051012     C                   Eval      OPT#   =     'OPT 6'
187200051012     C                   Exsr      BuildOEP5A
187300051012      *
187400051012     C                   Z-add     *Zeros        PosX
187500051012     C                   Eval      PosX   = %Scan('OPT#6':PDESCR)
187600051012     C                   Eval      OPT#   =     'OPT 6'
187700051012     C                   Exsr      BuildOEP5A
187800051012      *
187900051012     C                   Z-add     *Zeros        PosX
188000051012     C                   Eval      PosX   = %Scan('OPT 6':PDESCR)
188100051012     C                   Eval      OPT#   =     'OPT 6'
188200051012     C                   Exsr      BuildOEP5A
188300051012      *
188400051012     C                   Z-add     *Zeros        PosX
188500051012     C                   Eval      PosX   = %Scan('opt 6':PDESCR)
188600051012     C                   Eval      OPT#   =     'OPT 6'
188700051012     C                   Exsr      BuildOEP5A
188800051012      *
188900051012     C                   Z-add     *Zeros        PosX
189000051012     C                   Eval      PosX   = %Scan('OPTION 6':PDESCR)
189100051012     C                   Eval      OPT#   =     'OPT 6'
189200051012     C                   Exsr      BuildOEP5A
189300051012      *
189400051012     C                   Z-add     *Zeros        PosX
189500051012     C                   Eval      PosX   = %Scan('OPTTON 6':PDESCR)
189600051012     C                   Eval      OPT#   =     'OPT 6'
189700051012     C                   Exsr      BuildOEP5A
189800051012      *
189900051012     C                   Z-add     *Zeros        PosX
190000051012     C                   Eval      PosX   = %Scan('#6':PDESCR)
190100051012     C                   Eval      OPT#   =     'OPT 6'
190200051012     C                   Exsr      BuildOEP5A
190300051012      *
190400051012     C                   Z-add     *Zeros        PosX
190500051012     C                   Eval      PosX   = %Scan('OPT7 ':PDESCR)
190600051012     C                   Eval      OPT#   =     'OPT 7'
190700051012     C                   Exsr      BuildOEP5A
190800051012      *
190900051012     C                   Z-add     *Zeros        PosX
191000051012     C                   Eval      PosX   = %Scan('OPT7':PDESCR)
191100051012     C                   Eval      OPT#   =      'OPT 7'
191200051012     C                   Exsr      BuildOEP5A
191300051012      *
191400051012     C                   Z-add     *Zeros        PosX
191500051012     C                   Eval      PosX   = %Scan('OPT7#':PDESCR)
191600051012     C                   Eval      OPT#   =     'OPT 7'
191700051012     C                   Exsr      BuildOEP5A
191800051012      *
191900051012     C                   Z-add     *Zeros        PosX
192000051012     C                   Eval      PosX   = %Scan('#7':PDESCR)
192100051012     C                   Eval      OPT#   =      'OPT 7'
192200051012     C                   Exsr      BuildOEP5A
192300051012      *
192400051012     C                   Z-add     *Zeros        PosX
192500051012     C                   Eval      PosX   = %Scan('OPT 7':PDESCR)
192600051012     C                   Eval      OPT#   =     'OPT 7'
192700051012     C                   Exsr      BuildOEP5A
192800051012      *
192900051012     C                   Z-add     *Zeros        PosX
193000051012     C                   Eval      PosX   = %Scan('OPTION 7':PDESCR)
193100051012     C                   Eval      OPT#   =     'OPT 7'
193200051012     C                   Exsr      BuildOEP5A
193300051012      *
193400051012     C                   Z-add     *Zeros        PosX
193500051012     C                   Eval      PosX   = %Scan('OPT8 ':PDESCR)
193600051012     C                   Eval      OPT#   =     'OPT 8'
193700051012     C                   Exsr      BuildOEP5A
193800051012      *
193900051012     C                   Z-add     *Zeros        PosX
194000051012     C                   Eval      PosX   = %Scan('OPT8':PDESCR)
194100051012     C                   Eval      OPT#   =      'OPT 8'
194200051012     C                   Exsr      BuildOEP5A
194300051012      *
194400051012     C                   Z-add     *Zeros        PosX
194500051012     C                   Eval      PosX   = %Scan('OPT8#':PDESCR)
194600051012     C                   Eval      OPT#   =     'OPT 8'
194700051012     C                   Exsr      BuildOEP5A
194800051012      *
194900051012     C                   Z-add     *Zeros        PosX
195000051012     C                   Eval      PosX   = %Scan('OPT 8':PDESCR)
195100051012     C                   Eval      OPT#   =     'OPT 8'
195200051012     C                   Exsr      BuildOEP5A
195300051012      *
195400051012     C                   Z-add     *Zeros        PosX
195500051012     C                   Eval      PosX   = %Scan('OPTION 8':PDESCR)
195600051012     C                   Eval      OPT#   =     'OPT 8'
195700051012     C                   Exsr      BuildOEP5A
195800051012      *
195900051012     C                   Z-add     *Zeros        PosX
196000051012     C                   Eval      PosX   = %Scan('OPT9 ':PDESCR)
196100051012     C                   Eval      OPT#   =     'OPT 9'
196200051012     C                   Exsr      BuildOEP5A
196300051012      *
196400051012     C                   Z-add     *Zeros        PosX
196500051012     C                   Eval      PosX   = %Scan('OPT9':PDESCR)
196600051012     C                   Eval      OPT#   =      'OPT 9'
196700051012     C                   Exsr      BuildOEP5A
196800051012      *
196900051012     C                   Z-add     *Zeros        PosX
197000051012     C                   Eval      PosX   = %Scan('OPT9#':PDESCR)
197100051012     C                   Eval      OPT#   =     'OPT 9'
197200051012     C                   Exsr      BuildOEP5A
197300051012      *
197400051012     C                   Z-add     *Zeros        PosX
197500051012     C                   Eval      PosX   = %Scan('OPT 9':PDESCR)
197600051012     C                   Eval      OPT#   =     'OPT 9'
197700051012     C                   Exsr      BuildOEP5A
197800051012      *
197900051012     C                   Z-add     *Zeros        PosX
198000051012     C                   Eval      PosX   = %Scan('OPTION 9':PDESCR)
198100051012     C                   Eval      OPT#   =     'OPT 9'
198200051012     C                   Exsr      BuildOEP5A
198300051012      *
198400051012     C                   Z-add     *Zeros        PosX
198500051012     C                   Eval      PosX   = %Scan('OPT10 ':PDESCR)
198600051012     C                   Eval      OPT#   =     'OPT 10'
198700051012     C                   Exsr      BuildOEP5A
198800051012      *
198900051012     C                   Z-add     *Zeros        PosX
199000051012     C                   Eval      PosX   = %Scan('OPT10':PDESCR)
199100051012     C                   Eval      OPT#   =      'OPT 10'
199200051012     C                   Exsr      BuildOEP5A
199300051012      *
199400051012     C                   Z-add     *Zeros        PosX
199500051012     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
199600051012     C                   Eval      OPT#   =     'OPT 10'
199700051012     C                   Exsr      BuildOEP5A
199800051012      *
199900051012     C                   Z-add     *Zeros        PosX
200000051012     C                   Eval      PosX   = %Scan('OPT 10':PDESCR)
200100051012     C                   Eval      OPT#   =     'OPT 10'
200200051012     C                   Exsr      BuildOEP5A
200300051012      *
200400051012     C                   Z-add     *Zeros        PosX
200500051012     C                   Eval      PosX   = %Scan('OPTION 10':PDESCR)
200600051012     C                   Eval      OPT#   =     'OPT 10'
200700051012     C                   Exsr      BuildOEP5A
200800051114      *
200900051114     C                   Z-add     *Zeros        PosX
201000051114     C                   Eval      PosX   = %Scan('#11':PDESCR)
201100051114     C                   Eval      OPT#   =     'OPT 11'
201200051114     C                   Exsr      BuildOEP5A
201300051012      *
201400051012     C                   Z-add     *Zeros        PosX
201500051012     C                   Eval      PosX   = %Scan('OPT11 ':PDESCR)
201600051012     C                   Eval      OPT#   =     'OPT 11'
201700051012     C                   Exsr      BuildOEP5A
201800051012      *
201900051012     C                   Z-add     *Zeros        PosX
202000051012     C                   Eval      PosX   = %Scan('OPT11#':PDESCR)
202100051012     C                   Eval      OPT#   =     'OPT 11'
202200051012     C                   Exsr      BuildOEP5A
202300051012      *
202400051012     C                   Z-add     *Zeros        PosX
202500051012     C                   Eval      PosX   = %Scan('OPT 11':PDESCR)
202600051012     C                   Eval      OPT#   =     'OPT 11'
202700051012     C                   Exsr      BuildOEP5A
202800051012      *
202900051012     C                   Z-add     *Zeros        PosX
203000051012     C                   Eval      PosX   = %Scan('OPT12 ':PDESCR)
203100051012     C                   Eval      OPT#   =     'OPT 12'
203200051012     C                   Exsr      BuildOEP5A
203300051012      *
203400051012     C                   Z-add     *Zeros        PosX
203500051012     C                   Eval      PosX   = %Scan('OPT12':PDESCR)
203600051012     C                   Eval      OPT#   =     'OPT 12'
203700051012     C                   Exsr      BuildOEP5A
203800051012      *
203900051012     C                   Z-add     *Zeros        PosX
204000051012     C                   Eval      PosX   = %Scan('OPT12#':PDESCR)
204100051012     C                   Eval      OPT#   =     'OPT 12'
204200051012     C                   Exsr      BuildOEP5A
204300051012      *
204400051012     C                   Z-add     *Zeros        PosX
204500051012     C                   Eval      PosX   = %Scan('OPT 12':PDESCR)
204600051012     C                   Eval      OPT#   =     'OPT 12'
204700051012     C                   Exsr      BuildOEP5A
204800051012      *
204900051012     C                   Z-add     *Zeros        PosX
205000051012     C                   Eval      PosX   = %Scan('OPT13 ':PDESCR)
205100051012     C                   Eval      OPT#   =     'OPT 13'
205200051012     C                   Exsr      BuildOEP5A
205300051012      *
205400051012     C                   Z-add     *Zeros        PosX
205500051012     C                   Eval      PosX   = %Scan('OPT13#':PDESCR)
205600051012     C                   Eval      OPT#   =     'OPT 13'
205700051012     C                   Exsr      BuildOEP5A
205800051012      *
205900051012     C                   Z-add     *Zeros        PosX
206000051012     C                   Eval      PosX   = %Scan('OPT 13':PDESCR)
206100051012     C                   Eval      OPT#   =     'OPT 13'
206200051012     C                   Exsr      BuildOEP5A
206300051012      *
206400051012     C                   Z-add     *Zeros        PosX
206500051012     C                   Eval      PosX   = %Scan('OPT14 ':PDESCR)
206600051012     C                   Eval      OPT#   =     'OPT 13'
206700051012     C                   Exsr      BuildOEP5A
206800051012      *
206900051012     C                   Z-add     *Zeros        PosX
207000051012     C                   Eval      PosX   = %Scan('OPT14#':PDESCR)
207100051012     C                   Eval      OPT#   =     'OPT 14'
207200051012     C                   Exsr      BuildOEP5A
207300051012      *
207400051012     C                   Z-add     *Zeros        PosX
207500051012     C                   Eval      PosX   = %Scan('OPT 14':PDESCR)
207600051012     C                   Eval      OPT#   =     'OPT 14'
207700051012     C                   Exsr      BuildOEP5A
207800051012      *
207900051012     C                   Z-add     *Zeros        PosX
208000051012     C                   Eval      PosX   = %Scan('OPTION 14':PDESCR)
208100051012     C                   Eval      OPT#   =     'OPT 14'
208200051012     C                   Exsr      BuildOEP5A
208300051012      *
208400051012     C                   Z-add     *Zeros        PosX
208500051012     C                   Eval      PosX   = %Scan('OPT15 ':PDESCR)
208600051012     C                   Eval      OPT#   =     'OPT 15'
208700051012     C                   Exsr      BuildOEP5A
208800051012      *
208900051012     C                   Z-add     *Zeros        PosX
209000051012     C                   Eval      PosX   = %Scan('OPT15#':PDESCR)
209100051012     C                   Eval      OPT#   =     'OPT 15'
209200051012     C                   Exsr      BuildOEP5A
209300051012      *
209400051012     C                   Z-add     *Zeros        PosX
209500051012     C                   Eval      PosX   = %Scan('OPT 15':PDESCR)
209600051012     C                   Eval      OPT#   =     'OPT 15'
209700051012     C                   Exsr      BuildOEP5A
209800051012      *
209900051012     C                   Z-add     *Zeros        PosX
210000051012     C                   Eval      PosX   = %Scan('OPT16 ':PDESCR)
210100051012     C                   Eval      OPT#   =     'OPT 16'
210200051012     C                   Exsr      BuildOEP5A
210300051012      *
210400051012     C                   Z-add     *Zeros        PosX
210500051012     C                   Eval      PosX   = %Scan('OPT16#':PDESCR)
210600051012     C                   Eval      OPT#   =     'OPT 16'
210700051012     C                   Exsr      BuildOEP5A
210800051012      *
210900051012     C                   Z-add     *Zeros        PosX
211000051012     C                   Eval      PosX   = %Scan('OPT 16':PDESCR)
211100051012     C                   Eval      OPT#   =     'OPT 16'
211200051012     C                   Exsr      BuildOEP5A
211300051012      *
211400051012     C                   Z-add     *Zeros        PosX
211500051012     C                   Eval      PosX   = %Scan('OPT17 ':PDESCR)
211600051012     C                   Eval      OPT#   =     'OPT 17'
211700051012     C                   Exsr      BuildOEP5A
211800051012      *
211900051012     C                   Z-add     *Zeros        PosX
212000051012     C                   Eval      PosX   = %Scan('OPT17#':PDESCR)
212100051012     C                   Eval      OPT#   =     'OPT 17'
212200051012     C                   Exsr      BuildOEP5A
212300051012      *
212400051012     C                   Z-add     *Zeros        PosX
212500051012     C                   Eval      PosX   = %Scan('OPT 17':PDESCR)
212600051012     C                   Eval      OPT#   =     'OPT 17'
212700051012     C                   Exsr      BuildOEP5A
212800051012     C                   EndSR
212900051012      *
213000051011     C     BuildOEPB     Begsr
213100051011     C                   Clear                   OPT#
213200051011     C                   Z-add     *Zeros        PosX
213300051011     C                   Eval      PosX   = %Scan('OPTA ':PDESCR)
213400051011     C                   Eval      OPT#   =      'OPT A'
213500051011     C                   Exsr      BuildOEPB1
213600051011      *
213700051011     C                   Z-add     *Zeros        PosX
213800051011     C                   Eval      PosX   = %Scan('OPT A':PDESCR)
213900051011     C                   Eval      OPT#   =      'OPT A'
214000051011     C                   Exsr      BuildOEPB1
214100051010      *
214200051011     C                   Z-add     *Zeros        PosX
214300051011     C                   Eval      PosX   = %Scan('OPT-A':PDESCR)
214400051011     C                   Eval      OPT#   =      'OPT A'
214500051011     C                   Exsr      BuildOEPB1
214600051011      *
214700051011     C                   Z-add     *Zeros        PosX
214800051011     C                   Eval      PosX   = %Scan('OPT#A':PDESCR)
214900051011     C                   Eval      OPT#   =      'OPT A'
215000051011     C                   Exsr      BuildOEPB1
215100051011      *
215200051011     C                   Z-add     *Zeros        PosX
215300051011     C                   Eval      PosX   = %Scan('OPTB ':PDESCR)
215400051011     C                   Eval      OPT#   =      'OPT B'
215500051011     C                   Exsr      BuildOEPB1
215600051011      *
215700051011     C                   Z-add     *Zeros        PosX
215800051011     C                   Eval      PosX   = %Scan('OPT B':PDESCR)
215900051011     C                   Eval      OPT#   =      'OPT B'
216000051011     C                   Exsr      BuildOEPB1
216100051011      *
216200051011     C                   Z-add     *Zeros        PosX
216300051011     C                   Eval      PosX   = %Scan('OPT-B':PDESCR)
216400051011     C                   Eval      OPT#   =      'OPT B'
216500051011     C                   Exsr      BuildOEPB1
216600051011      *
216700051011     C                   Z-add     *Zeros        PosX
216800051011     C                   Eval      PosX   = %Scan('OPT#B':PDESCR)
216900051011     C                   Eval      OPT#   =      'OPT B'
217000051011     C                   Exsr      BuildOEPB1
217100051011      *
217200051011     C                   Z-add     *Zeros        PosX
217300051011     C                   Eval      PosX   = %Scan('OPTC ':PDESCR)
217400051011     C                   Eval      OPT#   =      'OPT C'
217500051011     C                   Exsr      BuildOEPB1
217600051011      *
217700051011     C                   Z-add     *Zeros        PosX
217800051011     C                   Eval      PosX   = %Scan('OPT C':PDESCR)
217900051011     C                   Eval      OPT#   =      'OPT C'
218000051011     C                   Exsr      BuildOEPB1
218100051011      *
218200051011     C                   Z-add     *Zeros        PosX
218300051011     C                   Eval      PosX   = %Scan('OPT-C':PDESCR)
218400051011     C                   Eval      OPT#   =      'OPT C'
218500051011     C                   Exsr      BuildOEPB1
218600051011      *
218700051011     C                   Z-add     *Zeros        PosX
218800051011     C                   Eval      PosX   = %Scan('OPT#C':PDESCR)
218900051011     C                   Eval      OPT#   =      'OPT C'
219000051011     C                   Exsr      BuildOEPB1
219100051011      *
219200051011     C                   Z-add     *Zeros        PosX
219300051011     C                   Eval      PosX   = %Scan('OPTD ':PDESCR)
219400051011     C                   Eval      OPT#   =      'OPT D'
219500051011     C                   Exsr      BuildOEPB1
219600051011      *
219700051011     C                   Z-add     *Zeros        PosX
219800051011     C                   Eval      PosX   = %Scan('OPT D':PDESCR)
219900051011     C                   Eval      OPT#   =      'OPT D'
220000051011     C                   Exsr      BuildOEPB1
220100051011      *
220200051011     C                   Z-add     *Zeros        PosX
220300051011     C                   Eval      PosX   = %Scan('OPT-D':PDESCR)
220400051011     C                   Eval      OPT#   =      'OPT D'
220500051011     C                   Exsr      BuildOEPB1
220600051011      *
220700051011     C                   Z-add     *Zeros        PosX
220800051011     C                   Eval      PosX   = %Scan('OPT#D':PDESCR)
220900051011     C                   Eval      OPT#   =      'OPT D'
221000051011     C                   Exsr      BuildOEPB1
221100051011      *
221200051011     C                   EndSR
221300051011      *
221400051011     C     BuildOEP3A    Begsr
221500051010     C                   If        PosX   > *Zero
221600051010     C     OEKey         Chain     OEPLAN
221700051114     C                   Eval      ODESC  = %Trim('BLUE CHOICE ' +
221800051110     C                                                 OPT#)
221900051010     C                   If        %Found(OEPLAN)
222000051010     C                   Update    OEPLANR
222100051010     C                   Else
222200051010     C                   Eval      OTRST = PLTRST
222300051010     C                   Eval      OSUB# = PLSUB#
222400051010     C                   Eval      OPLAN = PLPLAN
222500051010     C                   Write     OEPLANR
222600051010     C                   End
222700051010     C                   End
222800051010     C                   EndSR
222900051110      *
223000051110     C     BuildOwzP3A   Begsr
223100051110     C                   If        PosX   > *Zero
223200051110     C     OEKey         Chain     OEPLAN
223300051114     C                   Eval      ODESC  = %Trim('BLUE CHOICE ' +
223400051110     C                                  %Trim(Owz) + ' ' + OPT#)
223500051110     C                   If        %Found(OEPLAN)
223600051110     C                   Update    OEPLANR
223700051115     C                   Z-add     1             WriteCtr
223800051110     C                   Else
223900051110     C                   Eval      OTRST = PLTRST
224000051110     C                   Eval      OSUB# = PLSUB#
224100051110     C                   Eval      OPLAN = PLPLAN
224200051110     C                   Write     OEPLANR
224300051115     C                   Z-add     1             WriteCtr
224400051110     C                   End
224500051110     C                   End
224600051110     C                   EndSR
224700051011      *
224800051011     C     BuildOEP2     Begsr
224900051011     C                   If        PosX   > *Zero
225000051011     C     OEKey         Chain     OEPLAN
225100051011     C                   Eval      ODESC  = %Trim('BLUE PREFERRED ' +
225200051011     C                                        OPT#)
225300051011     C                   If        %Found(OEPLAN)
225400051011     C                   Update    OEPLANR
225500051011     C                   Else
225600051011     C                   Eval      OTRST = PLTRST
225700051011     C                   Eval      OSUB# = PLSUB#
225800051011     C                   Eval      OPLAN = PLPLAN
225900051011     C                   Write     OEPLANR
226000051011     C                   End
226100051011     C                   End
226200051011     C                   EndSR
226300051012      *
226400051011     C     BuildOEPB1    Begsr
226500051011     C                   If        PosX   > *Zero
226600051011     C     OEKey         Chain     OEPLAN
226700051011     C                   Eval      ODESC  = %Trim('SELECT PREF PROV ' +
226800051011     C                                        OPT#)
226900051011     C                   If        %Found(OEPLAN)
227000051011     C                   Update    OEPLANR
227100051011     C                   Else
227200051011     C                   Eval      OTRST = PLTRST
227300051011     C                   Eval      OSUB# = PLSUB#
227400051011     C                   Eval      OPLAN = PLPLAN
227500051011     C                   Write     OEPLANR
227600051011     C                   End
227700051011     C                   End
227800051011     C                   EndSR
227900051010      *
228000051012      *
228100051012     C     BuildOEP5A    Begsr
228200051012     C                   If        PosX   > *Zero
228300051012     C     OEKey         Chain     OEPLAN
228400051012     C                   Eval      ODESC  = %Trim('BLUE VISION PLUS ' +
228500051012     C                                        OPT#)
228600051012     C                   If        %Found(OEPLAN)
228700051012     C                   Update    OEPLANR
228800051012     C                   Else
228900051012     C                   Eval      OTRST = PLTRST
229000051012     C                   Eval      OSUB# = PLSUB#
229100051115     C                   Eval      OPLAN = PLPLAN
229200051115     C                   Write     OEPLANR
229300051012     C                   End
229400051012     C                   End
229500051012     C                   EndSR
229600051012      *
229700051010     C     Klist         Begsr
229800051010    ?C     OEKey         Klist
229900051010    ?C                   Kfld                    PLTRST
230000051010    ?C                   Kfld                    PLSUB#
230100051010    ?C                   Kfld                    PLPLAN
230200051110      *
230300051110    ?C     GRKey         Klist
230400051110    ?C                   Kfld                    PLTRST
230500051110    ?C                   Kfld                    PLSUB#
230600051110    ?C                   Kfld                    PLPLAN
230700051110     C                   Kfld                    Today
230800051010     C                   EndSR
230900051110      *
231000051110    ?C     *INZSR        Begsr
231100051110     C     *DATE         Mult      10000.0001    Today             8 0
231200051110     C                   EndSR
