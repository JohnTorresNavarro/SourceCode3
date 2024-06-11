0002009102150002 F******************************************************************
0003000606300003 F* fm072      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009102150004 F*                                                                *
0005000606300005 F*            WRITTEN BY - David Ketterman                        *
0006000606300006 F*            DATE - 06/30/06                                     *
0007009102150007 F*                                                                *
0008000606300008 F*  DESCRIPTION - Display Plans for this account in a seperate    *
0011020606300011  *                window from the member coverage window of FM070.*
0011030606300011  *                This program counts on the files being          *
0011040606300011  *                overridden before calling it since there is no  *
0011050606300011  *                CL.                                             *
0011061012210011  * 12/21/10 DLK - add valid variable benefit values               *
0011091103250011  * 03/25/11 DLK - add date parm so the webnot and grate search can*
0011101103250011  *                use an effdt if one is passed.                  *
0011111211270011  * 11/27/12 DLK - use date passed for comctx search. this will
0011121211270011  *                match the new edit in fm070.                    *
0011131211270011  *                                                                *
0012009102150012 F******************************************************************
0013009102150013 F*                                                                *
0014000606300014 Ffm072d    cf   e             WORKSTN
001401040803     F                                     SFILE(SF01:RRN)
0015000811140015 Fcmct14    IF   e           k DISK
0015010811140015 Fplnmst    IF   e           k DISK
0015020811140015 Fgrate     IF   e           k DISK
0015031012210015 Fwebnotl1  IF   e           k DISK
001701040803     d rrn             s              5  0
001702060630     d ratefound       s              1
001703110325     d dattouse        s              8  0
001704110325     d dattousemdy     s              8  0
0017051103250037 D workdtymd       S               d   datfmt(*iso)
0017061103250037 D workdtmdy       S               d   datfmt(*usa)
0017070606300484 D  parmacc        DS
0017080606300486 D  tsa                    1     10  0
0017090606300486 D  t                      1      3  0
0017100606300487 D  S                      4      6  0
0017110606300488 D  A                      7     10  0
0017121103250484 D  parmdat        DS
0017131103250486 D  parmdatn               1      8  0
001714041215     c     *entry        plist
001715060630     c                   parm                    parmacc          10
001716110325     c                   parm                    parmdat           8
016005040803
016006060630     c                   eval      title = 'Plans available to' +
016007110325     c                             (%editw(tsa:'0   -   -    ')) + ' on ' +
016008110325     c                             (%editc(dattousemdy:'Y'))
016015040803     C* CLEAR SUBFILE
016016040803     C                   MOVEA     '001'         *IN(40)
016017041215     C                   WRITE     SF01CTL
016018040803     C                   eval      *IN42 = *off
016019040803     C*
016020060630     C* BUILD SUBFILE - only show active plans
016021040803     C*
016022040803     C                   clear                   RRN
0160230606300200 C                   clear                   savplan
016024060630     C     comkey        SETLL     cmct14
016025060630     C                   dou       %eof(cmct14)
016026060630     C     comkey        READE     cmct14                                 41
016027060630     C                   if        not %eof(cmct14)
016033060630
016034121127     c*****              if        cmplan <> savplan and cmcan = 0
016035121127     c                   if        cmplan <> savplan and
016036121127     c                             (dattouse >= effdat and
016037121127     c                             (cmcan = 0 or (cmcan <> 0 and
016038121129     c                             dattouse <= cmcan))) and
016039121129     c                             (effdat <> cmcan)
016040121127
016041060630
016042060630      * if rates active, show plan
016043060630
016044060630     c                   exsr      #findrate
016045060630     c                   if        ratefound = 'Y'
016046060630     c     plnkey        chain     plnmst
016047060630     c                   if        %found(plnmst)
016048040803     C                   ADD       1             RRN
016049060630     c                   move      cmplan        x1
016050060630     c                   movel     pdescr        x2
016051060630     c                   move      cmplan        savplan           4
016052040803     C                   WRITE     SF01
016053101221      * add valid variable benefit values as a second line if they exist
016054101221     c                   exsr      #chkvarben
016055060630     c                   end
016056060630     c                   end
016057060630
016058060630     c                   end
016059060630
016060040803     C                   iter
016061040803     C                   END
016062040803     C                   ENDDO
016063040803
016064040803     C* DISPLAY SUBFILE IN WINDOW
016065040803     C                   if        rrn > 0
016066040803     C                   eval      *in40 = *on
016067040803     C                   END
016068040803     C*
016069041215     C                   WRITE     WINDOW
016070040803     C                   EXFMT     SF01CTL
016071041215
016100041215     c                   eval      *inlr = *on
016200060630
016201060630      ******************************************
016202060630     C* are rates active?
016205060630      ******************************************
016206060630     C     #findrate     BEGSR
016207060630     C*
016208060630     C                   eval      ratefound = ' '
016209060630     C     ratekey       SETLL     grate
016210060630
016211060630     C                   dou       %eof(grate)
016212060630     C     ratekey       READe     grate
016217110325     C                   if        (not %eof(grate)) and (grdltd = 'A')
016218110325     C                             and (dattouse >= frmdat)
016219110325     C                             and (dattouse <= todat)
016220101221     C                   eval      ratefound = 'Y'
016221060630     C                   leave
016222060630     C                   END
016223060630     C                   enddo
016224060630
016225060630     C                   ENDSR
016226060630
016227101221      ******************************************
016228101221     C* check for variable benefit and show as a second line
016229101221      * todays date is used to find a date range of valid benefits
016230101221      ******************************************
016231101221     C     #chkvarben    BEGSR
016232101221     C*
016233101221
016234101221     c     webnotkey     setll     webnotl1
016235101221     c                   dou       %eof(webnotl1)
016236101221     c     webnotkey     reade     webnotl1
016237110325     c                   if        not %eof(webnotl1) and dattouse >= cnbeg
016238101221     c                             and (cnend = 0 or
016239110325     c                             (cnend <> 0 and dattouse <= cnend))
016240110208      * write from - to and increment
016241101221     C                   ADD       1             RRN
016242101221     c                   clear                   x1
016243101221     c                   eval      x2 = 'Valid Ben ' +
016244101221     C                             %trim(%editc(cnmin:'4')) + '-' +
016245101221     C                             %trim(%editc(cnmax:'4')) + ' inc.' +
016246101221     C                             %trim(%editc(cninc:'4'))
016247101221     C                   WRITE     SF01
016248110208      * write GI amount
016249110208     C                   ADD       1             RRN
016250110208     c                   clear                   x2
016251110208     c                   eval      x2 = 'GI Amt ' +
016252110208     C                             %trim(%editc(cngia:'4'))
016253110208     C                   WRITE     SF01
016254101221     c                   leave
016255101221     c                   end
016256101221     c                   enddo
016257101221
016258101221     C                   ENDSR
016259060630
016300060630     c     *inzsr        begsr
016400060630     c     comkey        klist
016500060630     c                   kfld                    t
016600060630     c                   kfld                    s
016700060630     c                   kfld                    a
016701060630
016800060630     c     plnkey        klist
016900060630     c                   kfld                    t
017000060630     c                   kfld                    s
017200060630     c                   kfld                    cmplan
017201060630
017202060630     c     ratekey       klist
017203060630     c                   kfld                    t
017204060630     c                   kfld                    s
017206060630     c                   kfld                    cmplan
017207060630
017208101221     c     webnotkey     klist
017209101221     c                   kfld                    t
017210101221     c                   kfld                    s
017211101221     c                   kfld                    a
017212101221     c                   kfld                    cmplan
017213101221
017216110325      * use todays date for search unless one a valid date is passed as
017217110325      * a parm then use the parm date
017400060630     c                   movel     *year         runymd            8 0
017401060630     c                   movel     *month        md                4 0
017402060630     c                   move      *day          md
017403060630     c                   move      md            runymd
017406110325     c                   move      runymd        dattouse
017407110325
017408110325     c                   if        parmdatn <> 0
017409110325      * validate date
017410110325     C     *ISO          TEST (DE)               parmdatn
017411110325     C                   IF        not %ERROR
017412110325     C                   move      parmdatn      dattouse
017413110325     C                   end
017414110325     C                   end
017415110325
017416110325      * ymd to mdy for display
017417110325     c                   move      dattouse      workdtymd
017418110325     c                   move      workdtymd     workdtmdy
017419110325     c                   move      workdtmdy     dattousemdy
017500060630     c                   endsr
