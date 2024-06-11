0002009102150002 F******************************************************************
0003001212100003 F* iq014      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009102150004 F*                                                                *
0005000606300005 F*            WRITTEN BY - David Ketterman                        *
0006001212100006 F*            DATE - 12/10/12                                     *
0007009102150007 F*                                                                *
0008001212100008 F*  DESCRIPTION - Display DCOV plans for a dependent in a seperate*
0011021212120011  *                window within IQ010.                            *
0011111103250011  *                                                                *
0012009102150012 F******************************************************************
0013009102150013 F*                                                                *
0014001212100014 Fiq014d    cf   e             WORKSTN
001401040803     F                                     SFILE(SF01:RRN)
0015001212110015 Fdcovl1    IF   e           k DISK
0015011212100015 Fdepndc    IF   e           k DISK
0015021212100015 Fdepend2   IF   e           k DISK
0015031212100015 Fplnmst    IF   e           k DISK
001701040803     d rrn             s              5  0
0017121212100484 D  parmssn        DS
0017131212100486 D  parmssnn               1      9  0
0017141212100484 D  parmseq        DS
0017151212100486 D  parmseqn               1      2  0
001716041215     c     *entry        plist
001717121210     c                   parm                    parmssn           9
001718121210     c                   parm                    parmseq           2
016005040803
016015040803     C* CLEAR SUBFILE
016016040803     C                   MOVEA     '001'         *IN(40)
016017041215     C                   WRITE     SF01CTL
016018040803     C                   eval      *IN42 = *off
016019121210
016020121210     c     dckey         chain     depndc
016021121210     c                   if        %found(depndc)
016022121214      * ssn
016023121214     c                   if        depss# <> 0
016024121214     c                   eval      depss#out = %editw(depss#:'0   -  -    ')
016025121214     c                   end
016027121214      * name
016028121210     c                   movel     dfname        depnam
016029121210     c                   if        dmi <> *blank
016030121210     c                   cat       dmi:1         depnam
016031121210     c                   end
016032121210     c                   cat       dlname:1      depnam
016033121212
016034121212      * city / state / zip
016035121212     c                   movel     DCITY         dcsz
016036121212     c                   cat       dstate:1      dcsz
016037121212     c                   movel     dzip          dzip5             5
016038121212     c                   move      dzip          dzip4             4
016039121212     c                   cat       dzip5:1       dcsz
016040121212     c                   if        dzip4 <> '0000'
016041121212     c                   cat       '-':0         dcsz
016042121212     c                   cat       dzip4:0       dcsz
016043121212     c                   end
016044121212
016045121210      * medicare a
016046121210     C                   if        dmedad <> 0
016047121210     C                   MOVE      DMEDAD        @DATIN
016048121210     C                   EXSR      #DATYM
016049121210     C                   MOVE      @DATOU        DMEDADout
016050121210     C                   END
016051121210      * medicare b
016052121210     C                   if        dmedbd <> 0
016053121210     C                   MOVE      DMEDBD        @DATIN
016054121210     C                   EXSR      #DATYM
016055121210     C                   MOVE      @DATOU        DMEDBDout
016056121210     C                   END
016057121210
016058121212      * status
016059121212     c                   if        dpdltd = 'A'
016060121212     c                   eval      status = 'ACTIVE   '
016061121212     c                   else
016062121212     c                   eval      status = 'CANCELLED'
016063121212     c                   end
016064121212
016065121210     c                   end
016066121210      * get depend 2 record
0160671212100750 C                   clear                   d2emailout       65
0160681212100753 C     dckey         CHAIN     DEPEND2
016069121210     c                   if        %found(depend2)
0160701212100750 C                   MOVEL     d2email       d2emailout
016071121210     c                   end
016072121210
016073040803     C*
016074121210     C* BUILD SUBFILE - Dcov
016075040803     C*
016076040803     C                   clear                   RRN
016077121211     C     dckey         SETLL     dcovl1
016078121211     C                   dou       %eof(dcovl1)
016079121211     C     dckey         READE     dcovl1                                 41
016080121211     C                   if        not %eof(dcovl1)
016081040803     C                   ADD       1             RRN
016082121210     c                   movel     dvplan        x1
016083121210
016084121210     C                   MOVE      denrdt        @DATIN
016085121210     C                   EXSR      #DATYM
016086121210     C                   MOVE      @DATOU        x3
016087121210
016088121210     C                   clear                   x4
016089121210     c                   if        ccandt <> 0
016090121210     C                   MOVE      ccandt        @DATIN
016091121210     C                   EXSR      #DATYM
016092121210     C                   MOVE      @DATOU        x4
016093121210     c                   end
016094121210
016095121210     C                   clear                   x2
016096121210     c     plnkey        chain     plnmst
016097121210     c                   if        %found(plnmst)
016098121210     c                   movel     pdescr        x2
016099121210     c                   end
016100121210
016101040803     C                   WRITE     SF01
016102060630     c                   end
016103060630
016104040803     C                   ENDDO
016105121219
016106121219      * after last rec add ending mesage to subfile
016107121219     C                   ADD       1             RRN
016108121219     c                   clear                   x1
016109121219     c                   clear                   x2
016110121219     c                   eval      x2 = '          *** End of plans *** '
016111121219     c                   clear                   x3
016112121219     c                   clear                   x4
016113121219     C                   WRITE     SF01
016114040803
016115040803     C* DISPLAY SUBFILE IN WINDOW
016116040803     C                   if        rrn > 0
016117040803     C                   eval      *in40 = *on
016118040803     C                   END
016119040803     C*
016120041215     C                   WRITE     WINDOW
016121040803     C                   EXFMT     SF01CTL
016122041215
016123121220      * pressing enter will end the program and return control back to
016124121220      * IQ010 dependent screen
016125121220
016126041215     c                   eval      *inlr = *on
016259060630
0162601212100103 C***************************************************
0162611212100104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0162621212100105 C***************************************************
0162631212100107 C*
0162641212100107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0162651212100107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0162661212100107 C*
0162671212100106 C     #DATYM        BEGSR
016268121210     C                   MOVE      @DATIN        @MD               4 0
016269121210     C                   MOVEL     @DATIN        @Y                4 0
016270121210     C                   MOVEL     @MD           @DATOU            8 0
016271121210     C                   MOVE      @Y            @DATOU
016272121210     C                   MOVE      *ZEROS        @DATIN            8 0
0162731212100120 C                   ENDSR
0162741212100107 C*
016300060630     c     *inzsr        begsr
016400121210     c     dckey         klist
016500121210     c                   kfld                    parmssnn
016600121210     c                   kfld                    parmseqn
016701060630
016702121210     c     plnkey        klist
016703121210     c                   kfld                    dvtrst
016704121210     c                   kfld                    dvsub#
016705121210     c                   kfld                    dvplan
016706121210
017401121214     c                   movel     parmseqn      depseqout
017500060630     c                   endsr
