000001071127     hoption(*nodebugio)
0001009408170002 F******************************************************************
0002001001130003 F* rpa020     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005001001130006 F*            DATE - 01/13/10                                     *
0006009408170007 F*                                                                *
0007001001130008 F*  DESCRIPTION - prompt for account # and show begin admin date. *
0009021205310010 F* 05/30/12 dlk - add choice to run dbe only or all other carriers*
0009031207030010 F*                per request by Carol S. Also add choice of      *
0009041207030010 F*                carrier group.                                  *
0009051207030010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012001001130013 Frpa020d   CF   E             WORKSTN
0015001001130015 Faccmst    iF   E           K DISK
0015011207030015 Fhypercarr if   e           k DISK
0015030510260056 D  parmcancel     s              1
0015050510260056 D  error          s              1
0015091001130056 D  err1           c                   const('             *** ERROR - +
0015101001130056 D                                     ACCOUNT NUMBER NOT FOUND *** +
0015111001130056 D                                                   ')
0015121205300056 D  err2           c                   const('             *** ERROR - +
0015131205300056 D                                     CHOOSE D OR O FOR CARRIER ** +
0015141205300056 D                                                   ')
0015151207030056 D  err3           c                   const('             *** ERROR - +
0015161207030056 D                                     ENTER A VALID CARRIER GROUP CODE +
0015171207030056 D                                     **            ')
0015181001130055 D                 DS
0015191001130056 D  tsa                    1     10  0
0015201001130056 D  trust                  1      3  0
0015211001130056 D  sub                    4      6  0
0015221001130056 D  acc                    7     10  0
0015290510260055 D                uDS
0015301001130056 D  ltsa                   1     10
0015311205300056 D  lcarrier              11     11
0015321207030056 D  lcargrp               12     13
0015340510260601 D  CONAME               201    240
0015350510260601 D  luser               1000   1009
004300020702
008503051026
008504100113     c                   clear                   trust
008505100113     c                   clear                   sub
008506100113     c                   clear                   acc
008507120530     c                   move      'D'           carrier
008508100113
008509051026     c                   dou       *inlr = *on
008900051026     C                   exfmt     scrn01
008901051026
008902051026      * f7 - cancel
008903051026     c                   if        *in07 = *on
008904051026     c                   move      'Y'           parmcancel
008905051026     c                   goto      #end
008906051026     c                   end
008907051026
008908051026      * clear errors
008909051026     c                   clear                   error
008910100113     c                   clear                   errortxt
008911100113     c                   clear                   begadmmdy
008912100204     c                   clear                   canmdy
008913100113     c                   clear                   accname
008914051026     c                   eval      *in21 = *off
008915120703     c                   eval      *in22 = *off
008916100113     c                   eval      *in92 = *off
008917100204     c                   eval      *in30 = *off
009100051026
009101051026      * edits
009102120530
009103120530     c                   if        carrier <> 'D' and carrier <> 'O'
009104120530     c                   eval      *in21 = *on
009105120530     c                   eval      error = 'Y'
009106120530     c                   eval      errortxt = err2
009107120530     c                   iter
009109120530     c                   end
009110120530
009111100113     c     acckey        chain     accmst
009112100113     c                   if        not %found(accmst)
009113051026     c                   eval      *in21 = *on
009114051026     c                   eval      error = 'Y'
009115100113     c                   eval      errortxt = err1
009116051026     c                   iter
009117051026     c                   end
009118071127
009119100113     c                   movel     acnam1        accname
009142071127
009143100113     c                   move      gbsbdt        @datin
009144071127     c                   exsr      #datym
009145100113     c                   move      @datou        begadmmdy         8 0
009146100204
009147100204     c                   move      atrmdt        @datin
009148100204     c                   exsr      #datym
009149100204     c                   move      @datou        canmdy            8 0
0095020711270076 C*
009503100204      * is begin admin prior to 1/2004?
009504100204     c                   if        gbsbdt < 20040101
009505100204     c                   eval      *in30 = *on
009507100204     c                   end
009508120703
009509120703      * valid carrier group code?
009510120703     c                   if        cargrp <> *blanks
009511120703     c     cargrp        chain     hypercarr
009512120703     c                   if        not %found(hypercarr)
009513120703     c                   eval      *in22 = *on
009514120703     c                   eval      error = 'Y'
009515120703     c                   eval      errortxt = err3
009516120703     c                   iter
009517120703     c                   end
009518120703     c                   end
009519120703
009520120703
009521100113
010520051027      * if no errors display F2 - submit (92 = unhide text)
010521051027     c                   if        error = *blank
010522051026     c                   eval      *in92 = *on
010523051026     c                   end
010524051026
010525071127      * if no errors and user pressed F2- fill lda, write and continue
010526051027     c                   if        error = *blank and *in02
010527100113     c                   move      tsa           ltsa
010528120530     c                   move      carrier       lcarrier
010529120703     c                   move      cargrp        lcargrp
010549051026     c                   leave
010550051026     c                   end
010551051026
010552020702     c                   enddo
010553051026
010554051026     c     #end          tag
010555051026
011960020703     c                   eval      *inlr = *on
011961051028
012036051026
0120370510260103 C***************************************************
0120380510260104 C* CONVERT FIELD FROM YMD TO MDY or MDY TO YMD
0120390510260105 C***************************************************
0120400510260106 C     #DATYM        BEGSR
012041051026     C                   MOVE      @DATIN        @MD               4 0
012042051026     C                   MOVEL     @DATIN        @Y                4 0
012043051026     C                   MOVEL     @MD           @DATOU            8 0
012044051026     C                   MOVE      @Y            @DATOU
012045051026     C                   MOVE      *ZEROS        @DATIN            8 0
0120460510260120 C                   ENDSR
012047051026
012048020703
012049020701     C     *inzsr        BEGSR
012050051026     c     *ENTRY        plist
012051051026     C                   parm                    parmcancel
012053051026
012085100113     C     acckey        KLIST
012086100113     C                   KFLD                    trust
012087100113     C                   KFLD                    sub
012088100113     C                   KFLD                    acc
012100020701     C                   ENDSR
