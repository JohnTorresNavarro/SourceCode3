0001001410080002 F******************************************************************
0002001410080003 F* db121      GROUP BENEFIT SERVICES SOFTWARE                     *
0003001410080004 F*                                                                *
0004001410080005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005001410080006 F*            DATE - 10/08/14                                     *
0006009102150008 F*                                                                *
0007001410080013 F*  DESCRIPTION - THIS PROGRAM WILL SHOW OVERLAPPING MCOV BY      *
0008001410080014 F*            PLAN CATEGORY CODE (modified version of DB120)      *
0009001410090015 F*            so for some period there is more than 1 plan with   *
0010001410090015 F*            the same plan category code active.                 *
0010011411190015 F* 11/19/14 dlk - add acct cancel date per Shelly                 *
0010021604130015 F* 04/13/16 dlk - shelly request - exclude accts cancelled        *
0010031604130015 F*                more than 6 months ago and members cancelled    *
0010041604130015 F*                more then 12 months ago                         *
0010051604130015 F*                                                                *
0011001410080016 F******************************************************************
0012001410080017 F*
001300141008     Fdb121j    ip   e           k DISK
0014001410080017 FMEMBER    IF   e           k DISK
001500141008     FACCMST    IF   e           k DISK    prefix(a_)
001600141008     FAACODE    IF   e           k DISK
001601141008     Fcodesl1   IF   e           k DISK
0017011410080017 Fdb121xl   o  a e             DISK
0017021410080125 Dcsv              c                   const('","')
001800141008     D ERR             S             40    DIM(3) CTDATA PERRCD(1)
001801141008     D savpdes         S                   like(pdescr)
001802160413     D workdtiso       s               d   datfmt(*iso)
0018031604130037 D sysdateymd      s               d   datfmt(*iso)
0018041604130037 D num_mon         s              4s 0
0018051410080030 D                 DS
0018061410080031 D  tsa                    1     10  0
0018071410080031 D  mctrst                 1      3  0
0018081410080031 D  mcsub#                 4      6  0
0018091410080031 D  acc#                   7     10  0
0019001410080055 D                UDS
0020001410080056 D  CONAME               201    240
0021001410080058 D  HMS                  242    247  0
002200141008     idb121r
002300141008     i                                          mcssno        l1
002400141008     i                                          plncat        l1
005200910710     C*
005300141009     C* ENROLL DATE MUST BE >= PREVIOUS CANCEL DATE
005301141009     C* ON PLAN category CHANGE (L1) - SKIP CHECK
005400910829     C*
005401141009     c                   if        not *inl1 and enrldt < savcan
005600910829     C                   Z-ADD     2             X                 1 0
005701141008     C                   exsr      #error
005900910829     C                   END
006200910829     C*
006300141008     C* SAVE values
006400141008     C                   MOVE      enrldt        SAVENR            8 0
006401141008     C                   MOVE      candt         SAVCAN            8 0
006402141008     C                   MOVE      mcplan        SAVplan           4
006403141008     C                   MOVE      pdescr        SAVpdes
007400141008
007401141008      ***************************************************
007402141008      * error routine
007403141008      ***************************************************
007404141008     c     #error        begsr
007405141008     c                   clear                   aaname           20
007406141119     c                   clear                   atrmdt_h          8 0
007407141008     C     acckey        CHAIN     ACCMST
007408141008     c                   if        %found(accmst)
007409141119     c                   move      a_atrmdt      atrmdt_h
007410141008     C     a_aacode      CHAIN     AACODE
007411141008     c                   if        %found(aacode)
007412141008     c     afnam         cat       alnam:1       aaname
007413141008     c                   end
007414141008     c                   end
007415160413
007416160413      * 4/13/16 - skip accts cancelled > 6 months ago
007417160413       if atrmdt_h <> 0;
007418160413       workdtiso = %date(atrmdt_h);
007419160413       num_mon = %diff(sysdateymd:workdtiso:*months);
007420160413        if num_mon > 6;
007421160413        leavesr;
007422160413        endif;
007423160413       endif;
007424141008
007425141008     c                   move      plncat        plncat2           2
007426141008
007427141008     c                   clear                   pcatdes          30
007428141008     C     plncat        CHAIN     codesl1
007429141008     c                   if        %found(codesl1)
007430141008     c                   movel     ldescr        pcatdes
007431141008     c                   end
007432141008
007433141008     C                   MOVE      enrldt        @DATIN
007434141008     C                   EXSR      #DATYM
007435141008     C                   MOVE      @DATOU        enrmdy            8 0
007436141008
007437141008     C                   MOVE      candt         @DATIN
007438141008     C                   EXSR      #DATYM
007439141008     C                   MOVE      @DATOU        canmdy            8 0
007440141008
007441141008     C                   MOVE      savenr        @DATIN
007442141008     C                   EXSR      #DATYM
007443141008     C                   MOVE      @DATOU        savenrmdy         8 0
007444141008
007445141008     C                   MOVE      savcan        @DATIN
007446141008     C                   EXSR      #DATYM
007447141008     C                   MOVE      @DATOU        savcanmdy         8 0
007448141008
007449141119     C                   MOVE      atrmdt_h      @DATIN
007450141119     C                   EXSR      #DATYM
007451141119     C                   MOVE      @DATOU        atrmmdy           8 0
007452141119
007453141008     C                   clear                   termmdy           8 0
007454141008     C     mcssno        CHAIN     member
007455141008     c                   if        %found(member)
007459160413      * 4/13/16 - skip members cancelled > 12 months ago
007460160413       if termdt <> 0;
007461160413       workdtiso = %date(termdt);
007462160413       num_mon = %diff(sysdateymd:workdtiso:*months);
007463160413        if num_mon > 12;
007464160413        leavesr;
007465160413        endif;
007466160413       endif;
007467160413     C                   MOVE      termdt        @DATIN
007468160413     C                   EXSR      #DATYM
007469160413     C                   MOVE      @DATOU        termmdy
007470160413
007471141008     c                   end
007472141008
007473141008     C                   exsr      writexldet
007474141008
007475141008     c                   endsr
0074761410080164 C*************************************************************
0074771410080164 C* Write Spreadsheet Detail                                  *
0074781410080164 C*************************************************************
007479141008     C     Writexldet    BEGSR
007480141008
007481141008     c                   clear                   db121fld
007482141008     C                   Eval      db121fld  = '"' +
007483141008     C                             %trim(%editw(mcssno:'0   -  -    ')) + csv +
007484141119     C                             %trim(%editw(termmdy:'  /  /    '))  + csv +
007485141008     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
007486141119     C                             %trim(%editw(atrmmdy:'  /  /    '))  + csv +
007487141013     C                             PLNCAT2                              + csv +
007488141013     C                             %trim(pcatdes)                       + csv +
007489141008     C                             MCPLAN                               + csv +
007490141008     C                             %trim(pdescr)                        + csv +
007491141008     C                             %trim(%editw(enrmdy:'  /  /    '))   + csv +
007492141008     C                             %trim(%editw(canmdy:'  /  /    '))   + csv +
007493141008     C                             savplan                              + csv +
007494141008     C                             %trim(savpdes)                       + csv +
007495141008     C                             %trim(%editw(savenrmdy:'  /  /    ')) + csv +
007496141008     C                             %trim(%editw(savcanmdy:'  /  /    ')) + csv +
007497141008     C                             %trim(err(x))                        + csv +
007498141008     C                             %trim(aaname)                        + csv +
007499141008     C                             ' '                                  + '",'
007500141008     C*
007501141008     C                   Write     db121xr
0075021410080320 C                   ENDSR
007503141008     C*
007504141008     C/EJECT
007505141008     C*************************************************************
007506141008     C* Write Spreadsheet heading                                 *
007507141008     C*************************************************************
007508141008     C     Writexlhead   BEGSR
007509141008
007510141008     c                   clear                   db121fld
007511141008     C                   Eval      db121fld = '"' + 'SS #'              + csv +
007512141119     C                                              'MEM CANCEL'        + csv +
007513141119     C                                              'ACCT #'            + csv +
007514141119     C                                              'ACCT CANCEL'       + csv +
007515141119     C                                              'CATEGORY'          + csv +
007516141013     C                                      'CATEGORY DESCRIPTION'      + csv +
007517141008     C                                              'PLAN'              + csv +
007518141008     C                                              'PLAN DESCRIPTION'  + csv +
007519141008     C                                              'ENROLL DATE'       + csv +
007520141008     C                                              'CANCEL DATE'       + csv +
007521141008     C                                              'OVERLAP PLAN'      + csv +
007522141008     C                                            'OVERLAP DESCRIPTION' + csv +
007523141008     C                                            'OVERLAP ENROLL'      + csv +
007524141008     C                                              'OVERLAP CANCEL'    + csv +
007525141008     C                                              'ERROR'             + csv +
007526141008     C                                              'AA NAME'           + csv +
007527141008     C                                              ' '                 + '",'
007528141008     C                   Write     db121xr
007529141008     C*
0075301410080320 C                   ENDSR
007531141008
0075321410080103 C***************************************************
0075331410080104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0075341410080105 C***************************************************
0075351410080107 C*
0075361410080107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0075371410080107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0075381410080107 C*
0075391410080106 C     #DATYM        BEGSR
007540141008     C                   MOVE      @DATIN        @MD               4 0
007541141008     C                   MOVEL     @DATIN        @Y                4 0
007542141008     C                   MOVEL     @MD           @DATOU            8 0
007543141008     C                   MOVE      @Y            @DATOU
007544141008     C                   MOVE      *ZEROS        @DATIN            8 0
0075451410080120 C                   ENDSR
0075461410080107 C*
007547141008     c     *inzsr        begsr
007600160413      * current date
007601160413     C                   eval      sysdateymd = %date
007602160413
007700141008     c     acckey        klist
007800141008     c                   kfld                    mctrst
007900141008     c                   kfld                    mcsub#
008000141008     c                   kfld                    acc#
008100141008
008101141008     C                   Exsr      Writexlhead
008200141008     c                   endsr
015400920924** ERROR TABLE
015500141009ERROR 1
015600141008PLAN CATEGORY OVERLAPPING DATES
015700141009ERROR 3
