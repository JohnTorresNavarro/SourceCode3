0011011410090002 F******************************************************************  UTL001
0011021410090003 F* DB120      GROUP BENEFIT SERVICES SOFTWARE           1991      *  UTL001
0011031410090004 F*                                                                *  UTL001
0011041410090005 F*            WRITTEN BY - DAVID KETTERMAN                        *  UTL001
0011051410090006 F*            DATE - 08/29/91                                     *  UTL001
001106141009     F*  DMA 02.02.98  Added Account Administrator name to report
0011071410090007 F*                                                                *  UTL001
0011091410090013 F*  DESCRIPTION - THIS PROGRAM WILL PRINT ANY MCOV RECORDS        *  UTL001
0011101410090014 F*            WITH INVALID ENROLL/CANCEL DATE COMBINATIONS.       *  UTL001
0011111410090015 F*                                                                *  UTL001
0011131410090010 F*  Y2K CONVERT - 1998                                            *
001114141009     F*  DMA 05.10.99  Fixed Y2K bug.  ENRLDT defined in 2 files       *
0011151410090015 F* 03/14/01 DLK - add account # to report                         *
001116141009     F*  5/24/02 szz - Recompiled over new AACODE file                 *
0011171410090015 F* 10/19/14 DLK - convert to csv output                           *
0011181410090015 F*                                                                *
0011191410090016 F******************************************************************  UTL001
0012001410080017 F*
001300141009     Fdb121j    ip   e           k DISK
0014001410080017 FMEMBER    IF   e           k DISK
001500141008     FACCMST    IF   e           k DISK    prefix(a_)
001600141008     FAACODE    IF   e           k DISK
001601141008     Fcodesl1   IF   e           k DISK
0017011410090017 Fdb120xl   o  a e             DISK
0017021410080125 Dcsv              c                   const('","')
001800141009     D ERR             S             45    DIM(3) CTDATA PERRCD(1)
001801141008     D savpdes         S                   like(pdescr)
0018021410080030 D                 DS
0018031410080031 D  tsa                    1     10  0
0018041410080031 D  mctrst                 1      3  0
0018051410080031 D  mcsub#                 4      6  0
0018061410080031 D  acc#                   7     10  0
0019001410080055 D                UDS
0020001410080056 D  CONAME               201    240
0021001410080058 D  HMS                  242    247  0
002200141009     idb121r
002300141008     i                                          mcssno        l1
002400141009     i                                          mcplan        l1
002401141009      * check for enroll prior to cancel date
002402141009     c                   if        candt <> 0
002403141009     c                   if        candt < enrldt
002404141009     C                   Z-ADD     1             X
002405141009     C                   ADD       1             CNT
002409141009     C                   exsr      #error
002410141009     C                   END
002411141009     C                   else
002412141009     C                   ADD       1             NUMACT            2 0
002413141009     C                   END
003500141008
005300141009     C* ENROLL DATE MUST BE >= PREVIOUS CANCEL DATE
005301141009     C* ON PLAN category CHANGE (L1) - SKIP CHECK
005400910829     C*
005401141009     c                   if        not *inl1 and enrldt < savcan
005600910829     C                   Z-ADD     2             X                 1 0
005700910829     C                   ADD       1             CNT               5 0
005701141008     C                   exsr      #error
005900910829     C                   END
006300141009      * SAVE values
006400141008     C                   MOVE      enrldt        SAVENR            8 0
006401141008     C                   MOVE      candt         SAVCAN            8 0
006402141008     C                   MOVE      mcplan        SAVplan           4
006403141009     C                   MOVE      pdescr        SAVpdes
007400141008
007401141009     C*
007402141009     C* ONLY 1 RECORD PER PLAN CAN BE ACTIVE AT ONCE
007403141009     C*
007404141009     CL1                 if        numact > 1
007405141009     CL1                 Z-ADD     3             X
007406141009     CL1                 ADD       1             CNT
007408141009     Cl1                 exsr      #error
007409141009     CL1                 END
007410141009     CL1                 clear                   NUMACT
007411141008      ***************************************************
007412141008      * error routine
007413141008      ***************************************************
007414141008     c     #error        begsr
007415141009
007416141009     c                   if        x = 1 or x = 3
007417141009     C                   clear                   SAVENR
007418141009     C                   clear                   SAVCAN
007419141009     C                   clear                   SAVplan
007420141009     C                   clear                   SAVpdes
007421141009     c                   end
007422141009
007423141008     c                   clear                   aaname           20
007424141008     C     acckey        CHAIN     ACCMST
007425141008     c                   if        %found(accmst)
007426141008     C     a_aacode      CHAIN     AACODE
007427141008     c                   if        %found(aacode)
007428141008     c     afnam         cat       alnam:1       aaname
007429141008     c                   end
007430141008     c                   end
007431141008
007432141008     c                   move      plncat        plncat2           2
007433141008
007434141008     c                   clear                   pcatdes          30
007435141008     C     plncat        CHAIN     codesl1
007436141008     c                   if        %found(codesl1)
007437141008     c                   movel     ldescr        pcatdes
007438141008     c                   end
007439141008
007440141008     C                   MOVE      enrldt        @DATIN
007441141008     C                   EXSR      #DATYM
007442141008     C                   MOVE      @DATOU        enrmdy            8 0
007443141008
007444141008     C                   MOVE      candt         @DATIN
007445141008     C                   EXSR      #DATYM
007446141008     C                   MOVE      @DATOU        canmdy            8 0
007447141008
007448141008     C                   MOVE      savenr        @DATIN
007449141008     C                   EXSR      #DATYM
007450141008     C                   MOVE      @DATOU        savenrmdy         8 0
007451141008
007452141008     C                   MOVE      savcan        @DATIN
007453141008     C                   EXSR      #DATYM
007454141008     C                   MOVE      @DATOU        savcanmdy         8 0
007455141008
007456141008     C                   clear                   termmdy           8 0
007457141008     C     mcssno        CHAIN     member
007458141008     c                   if        %found(member)
007459141008     C                   MOVE      termdt        @DATIN
007460141008     C                   EXSR      #DATYM
007461141008     C                   MOVE      @DATOU        termmdy
007462141008     c                   end
007463141008
007464141008     C                   exsr      writexldet
007465141008
007466141008     c                   endsr
0074671410080164 C*************************************************************
0074681410080164 C* Write Spreadsheet Detail                                  *
0074691410080164 C*************************************************************
007470141008     C     Writexldet    BEGSR
007471141008
007472141009     c                   clear                   db120fld
007473141009     C                   Eval      db120fld  = '"' +
007474141008     C                             %trim(%editw(mcssno:'0   -  -    ')) + csv +
007475141008     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
007476141008     C                             MCPLAN                               + csv +
007477141008     C                             %trim(pdescr)                        + csv +
007478141009     C                             PLNCAT2                              + csv +
007479141009     C                             %trim(pcatdes)                       + csv +
007480141008     C                             %trim(%editw(enrmdy:'  /  /    '))   + csv +
007481141008     C                             %trim(%editw(canmdy:'  /  /    '))   + csv +
007482141008     C                             savplan                              + csv +
007483141008     C                             %trim(savpdes)                       + csv +
007484141008     C                             %trim(%editw(savenrmdy:'  /  /    ')) + csv +
007485141008     C                             %trim(%editw(savcanmdy:'  /  /    ')) + csv +
007486141008     C                             %trim(%editw(termmdy:'  /  /    '))  + csv +
007487141008     C                             %trim(err(x))                        + csv +
007488141008     C                             %trim(aaname)                        + csv +
007489141008     C                             ' '                                  + '",'
007490141008     C*
007491141009     C                   Write     db120xr
0074921410080320 C                   ENDSR
007493141008     C*
007494141008     C/EJECT
007495141008     C*************************************************************
007496141008     C* Write Spreadsheet heading                                 *
007497141008     C*************************************************************
007498141008     C     Writexlhead   BEGSR
007499141008
007500141009     c                   clear                   db120fld
007501141009     C                   Eval      db120fld = '"' + 'SS #'              + csv +
007502141008     C                                              'ACCOUNT'           + csv +
007503141008     C                                              'PLAN'              + csv +
007504141008     C                                              'PLAN DESCRIPTION'  + csv +
007505141009     C                                              'CATEGORY'          + csv +
007506141009     C                                      'CATEGORY DESCRIPTION'      + csv +
007507141008     C                                              'ENROLL DATE'       + csv +
007508141008     C                                              'CANCEL DATE'       + csv +
007509141008     C                                              'OVERLAP PLAN'      + csv +
007510141008     C                                            'OVERLAP DESCRIPTION' + csv +
007511141008     C                                            'OVERLAP ENROLL'      + csv +
007512141008     C                                              'OVERLAP CANCEL'    + csv +
007513141008     C                                              'MEM CANCEL DATE'   + csv +
007514141008     C                                              'ERROR'             + csv +
007515141008     C                                              'AA NAME'           + csv +
007516141008     C                                              ' '                 + '",'
007517141009     C                   Write     db120xr
007518141008     C*
0075191410080320 C                   ENDSR
007520141008
0075211410080103 C***************************************************
0075221410080104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0075231410080105 C***************************************************
0075241410080107 C*
0075251410080107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0075261410080107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0075271410080107 C*
0075281410080106 C     #DATYM        BEGSR
007529141008     C                   MOVE      @DATIN        @MD               4 0
007530141008     C                   MOVEL     @DATIN        @Y                4 0
007531141008     C                   MOVEL     @MD           @DATOU            8 0
007532141008     C                   MOVE      @Y            @DATOU
007533141008     C                   MOVE      *ZEROS        @DATIN            8 0
0075341410080120 C                   ENDSR
0075351410080107 C*
007536141008     c     *inzsr        begsr
007600141008
007700141008     c     acckey        klist
007800141008     c                   kfld                    mctrst
007900141008     c                   kfld                    mcsub#
008000141008     c                   kfld                    acc#
008100141008
008101141008     C                   Exsr      Writexlhead
008200141008     c                   endsr
015400920924** ERROR TABLE
015500141009ENROLL DATE GREATER THAN CANCEL DATE
015600141009ENROLL DATE LESS THAN PREVIOUS CANCEL DATE
015700141009PLAN HAS MULTIPLE ACTIVE RECORDS
