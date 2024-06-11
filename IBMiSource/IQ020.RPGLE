0001009602140002 F******************************************************************
0002000201170003 F* iq020      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009602140004 F*                                                                *
0004009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000112210006 F*            DATE - 12/21/01                                     *
0006009602140007 F*                                                                *
0006010201170007 F*            Plan / Rate inquiry -                               *
0006020202110007 F*                                                                *
0006030202110007 F* 02/08/02 dlk - change trust screen to display in trust name    *
0006040202110007 F*                order                                           *
0006060709260007 F* 09/26/07 dlk - change rate to 6 decimal. remove col 5 to make room
0011009602140013 F******************************************************************
001200020117     Fiq020d    CF   E             WORKSTN
001300961031     F                                     SFILE(SF01:RRN)
001301011221     F                                     SFILE(SF02:RRN)
001302011221     F                                     SFILE(SF03:RRN)
001500020208     Ftrsmsx    IF   E           K DISK    rename(trsmsr:trsmsrx)
001501020208     Ftrsmst    IF   E           K DISK
001502011220     Fsubmst    IF   E           K DISK
001503011221     Fplnmst    IF   E           K DISK
001504011221     Fgrate     IF   E           K DISK
0015050112210600 D                 DS
0015060112210601 D  symd                   1      8  0
0015070112210601 D  sy                     1      4  0
0015080112210601 D  sm                     5      6  0
0015090112210601 D  sd                     7      8  0 inz(01)
0015100112210600 D                UDS
0015110112210601 D  COMPNY               201    240
001512011221Y2K  D  UD8YMD               248    255  0
001513011221Y2K  D  UD8Y                 248    251  0
001514011221Y2K  D  UD8m                 252    253  0
002710011221     c     subkey        klist
002711011221     c                   kfld                    strust
002712011221     c                   kfld                    ssub
002713011221
002714011221     c     plnkey        klist
002715011221     c                   kfld                    strust
002716011221     c                   kfld                    ssub
002717011221     c                   kfld                    plplan
002718011221
002719011231     c* using "Starting PLAN" entered on screen
002720011231
002721011231     c     splankey      klist
002722011231     c                   kfld                    strust
002723011231     c                   kfld                    ssub
002724011231     c                   kfld                    splan
002725011231
002726011221     c     #start        tag
002727011221     c                   setoff                                       0107
002728011221     c                   clear                   strust
002729011221     c                   clear                   ssub
002730011231     c                   clear                   splan
002731011224
010400011224     C* Screen 1 - trust display
010500961031     C* CLEAR SUBFILE
010600961031     C*
010700961031     C                   MOVEA     '001'         *IN(90)
010800961031     C                   WRITE     SF01CTL
010900961031     C                   MOVE      '0'           *IN92
011000961031     C*
011100961031     C* BUILD SUBFILE
011200961031     C*
011300961031     C                   MOVE      *ZEROS        RRN               5 0
011301010330     c                   eval      *in91 = *off
011302020208     c     *loval        setll     trsmsx
011500010330     C                   dow       *in91 = *off
011600020208     C                   READ      trsmsx                                 91
011601010330
011700020102     C                   if        *in91 = *off and trdltd <> 'D'
011731011220     C                   MOVE      contdt        @DATIN
011732010330     C                   EXSR      #DATYM
011733011220     C                   MOVE      @DATOU        conmdy            8 0
011735011220     c                   move      tscode        cat
011800961031     C                   ADD       1             RRN
011900961031     C                   WRITE     SF01
012100010330     C                   end
012101011220
012102010330     c                   enddo
012400011231
012900011231     C* display subfile
012902010402
012903011231     C                   if        rrn > 0
012904011231     C                   eval      *in90 = *on
012905011231     C                   end
012906011231
013001011221     C                   WRITE     Sf01ctl
013002011220
013003011221     c                   dow       *in07 = *off
013100011221     C                   EXFMT     SF01cmdky
013103011221     c* validate trust
013104011221
013105011221     c                   if        strust <> 0
013106011221     c     strust        chain     trsmst
013107011221     c                   if        not %found(trsmst)
013108011221     c                   eval      *in11 = *on
013109011221     c                   else
013110011221     c                   eval      *in11 = *off
013112011221     c                   leave
013113011221     c                   end
013114011221     c                   end
013115011221
013116011221     c                   enddo
013118011221
013119011224     c     #subdsp       tag
013120011224
013121011221     c                   if        strust <> 0
013122011221     c                   exsr      #sub
013123011224     c                   if        *in01
013124011224     c                   goto      #start
013125011224     c                   end
013126011220     c                   end
013127011221
013128011224     c* if subdivision selected, display plans & rates
013129011221
013130011221     c                   if        ssub <> 0
013131011221     c                   exsr      #plans
013132011224     c                   if        *in01
013133011224     c                   eval      *in01 = *off
013134011224     c                   goto      #subdsp
013135011224     c                   end
013136011221     c                   end
013137011221
013138011224     c* f7 = end
013203011221     c                   if        *in07
013204011221     c                   seton                                        lr
013205011221     c                   end
015301011220     C**************************************************************
015302011221     C* display subdivisions                                       *
015303011220     C**************************************************************
015400011221     C     #sub          BEGSR
015502011220     C* CLEAR SUBFILE
015504011221     C                   MOVEA     '001'         *IN(90)
015505011220     C                   WRITE     SF02CTL
015507011220     C* BUILD SUBFILE
015509011221     C                   MOVE      '0'           *IN92
015510011221     C                   MOVE      *ZEROS        RRN               5 0
015511011220
015700011221     C     strust        SETLL     submst
015701010330
015801011221     C                   dow       *in91 = *off
015900011221     C     strust        READe     submst                                 91
015916020102     C                   if        *in91 = *off and sbdltd <> 'D'
015917011221     c                   movel     subdsc        subdsc20
015921011221     C                   ADD       1             RRN
015922011220     C                   WRITE     SF02
015923011220     C                   end
015925011220     c                   enddo
015932011231
015933011231     c* if no subdivisions, show * no subdivisions *
015934011231
015935011231     C                   if        rrn = 0
015936011231     c                   clear                   sf02
015937011231     c                   eval      subnam =   '* NO SUBDIVISIONS   '
015938011231     c                   eval      subdsc20 = 'IN THIS TRUST *     '
015940011231     c                   add       1             rrn
015941011231     c                   write     sf02
015942011231     C                   end
015943011231
015944011231     C                   eval      *in90 = *on
015945011231
015946011220
015947011231     C* display subfile
015948011221     c                   movel     ud8m          smy
015949011221     c                   move      ud8y          smy
015950011220
015951011221     C                   WRITE     Sf02Ctl
015952011221
015953011221     c                   dow       *in07 = *off and *in01 = *off
015954011221     C                   EXFMT     SF02cmdky
015955011221     c* validate sub
015956011221     c                   if        ssub <> 0
015957011221     c     subkey        chain     submst
015958011221     c                   if        not %found(submst)
015959011221     c                   eval      *in21 = *on
015960011221     c                   else
015961011221     c                   eval      *in21 = *off
015962011221     c                   leave
015963011221     c                   end
015964011221     c                   end
015965011221
015966011220     c                   enddo
017004010330
017400010330     C                   ENDSR
0175000112210107 C*
017501011221     C**************************************************************
017502011221     C* display plans & rates                                      *
017503011221     C**************************************************************
017504011221     C     #plans        BEGSR
017505011221     C* CLEAR SUBFILE
017506011221     C                   MOVEA     '001'         *IN(90)
017507011221     C                   WRITE     SF03CTL
017508011221     C* BUILD SUBFILE
017509011221     C                   MOVE      '0'           *IN92
017510011221     C                   MOVE      *ZEROS        RRN               5 0
017511011221
017512011231     c* set limits with trust/sub/"STARTING PLAN" entered on screen
017514011231     C     splankey      SETLL     plnmst
017515011221
017516011221     C                   dow       *in91 = *off
017518011231     c* read by partial key: trust/sub
017520011221     C     subkey        READe     plnmst                                 91
017521020102     C                   if        *in91 = *off and pldltd <> 'D'
017522011221     c                   movel     pdescr        pdescro
017523011221     c                   movel     plplan        plano
017524011221     c                   exsr      #rate
017525011221     C                   end
017526011221     c                   enddo
017527011231
017528011231     c* if no plans, show * no plans *
017529011231
017530011231     C                   if        rrn = 0
017531011231     c                   clear                   sf03
017532011231     c                   eval      pdescro = '* NO PLANS IN THIS SUBDIVISION *'
017533011231     c                   add       1             rrn
017534011231     c                   write     sf03
017535011221     C                   END
017536011231
017537011231     C                   eval      *in90 = *on
017538011221
017539011221     C                   WRITE     Sf03Ctl
017540011221
017541011231     C* DISPLAY SUBFILE
017542011221     c                   dow       *in07 = *off and *in01 = *off
017543011221     C                   EXFMT     SF03cmdky
017544011221     c                   enddo
017545011221
017546011221     C                   ENDSR
017547011221     C**************************************************************
017548070926     C* get rates and display as 4 columns on screen               *
017549011221     C**************************************************************
017550011221     C     #rate         BEGSR
017557011221
017558011221     c                   z-add     0             column            3 0
017559011221     c                   move      'F'           firstread         1
017560011221     c                   move      smy           sy
017561011221     c                   movel     smy           sm
017562011221
017563011221     c                   eval      *in60 = *off
017564011221     c                   exsr      #clearcol
017576011221
017577011221     C     plnkey        SETLL     grate
017578011221
017579011221     C                   dow       not *in60
017580011221     C     plnkey        READe     grate                                  60
017581011221     C                   if        (*in60 = *off) and (symd >= frmdat) and
017582071011     C                             (symd <= todat) and (grdltd = 'A')
017583011221     c                   move      ' '           firstread
017584011221     C                   add       1             column
017585011221     c                   select
017586011221     c                   when      column = 1
017587011221     c                   move      agebnd        ab1
017588011221     c                   move      typecd        ct1
017589011221     c                   move      bilrte        rate1
017590011221     c                   when      column = 2
017591011221     c                   move      agebnd        ab2
017592011221     c                   move      typecd        ct2
017593011221     c                   move      bilrte        rate2
017594011221     c                   when      column = 3
017595011221     c                   move      agebnd        ab3
017596011221     c                   move      typecd        ct3
017597011221     c                   move      bilrte        rate3
017598011221     c                   when      column = 4
017599011221     c                   move      agebnd        ab4
017600011221     c                   move      typecd        ct4
017601011221     c                   move      bilrte        rate4
017606011221     C                   endsl
017607011221     c                   end
017608011221
017609070926     c* write when all 4 columns are full
017610011221
017611070926     c                   if        column = 4
017612011221     C                   ADD       1             RRN
017613011221     C                   WRITE     SF03
017614011221     C                   clear                   column
017615011221     c                   clear                   plano
017616011221     c                   clear                   pdescro
017617011221     c                   exsr      #clearcol
017618011221     c                   end
017619011221
017620011221     c                   enddo
017621011221
017622011221     c* write final line (or line w/o rates if no rates were found)
017623011221
017624070926     c                   if        (column > 0 and column < 4) or
017625011221     c                             firstread = 'F'
017626011221     C                   ADD       1             RRN
017627011221     C                   WRITE     SF03
017628011221     C                   z-add     0             column
017629011221     c                   exsr      #clearcol
017630011221     c                   end
017641011221
017642011221     C                   ENDSR
0176430112210103 C***************************************************
0176440112210104 C* clear columns on subfile 03                     *
0176450112210105 C***************************************************
017646011221     C     #clearcol     begsr
017647011221     c                   clear                   ab1
017648011221     c                   clear                   ab2
017649011221     c                   clear                   ab3
017650011221     c                   clear                   ab4
017652011221     c                   clear                   ct1
017653011221     c                   clear                   ct2
017654011221     c                   clear                   ct3
017655011221     c                   clear                   ct4
017657011221     c                   clear                   rate1
017658011221     c                   clear                   rate2
017659011221     c                   clear                   rate3
017660011221     c                   clear                   rate4
017662011221     C                   ENDSR
0176630112210103 C***************************************************
0177000112210104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0178000112210105 C***************************************************
0179000112210107 C*
0180000112210107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0181000112210107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0182000112210107 C*
0183000112210106 C     #DATYM        BEGSR
018400011221     C                   MOVE      @DATIN        @MD               4 0
018500011221     C                   MOVEL     @DATIN        @Y                4 0
018600011221     C                   MOVEL     @MD           @DATOU            8 0
018700011221     C                   MOVE      @Y            @DATOU
018800011221     C                   MOVE      *ZEROS        @DATIN            8 0
0189000112210120 C                   ENDSR
