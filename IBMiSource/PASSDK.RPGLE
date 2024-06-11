0001009408170002 F******************************************************************
0002001606020003 F* passdk     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005001605310006 F*            DATE - 05/31/16                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008001606020009 F*            PASSMST FILE. Note - this is the ONLY place that    *
0009001606020010 F*            can change the passwords (no DBU, DFU etc.) due     *
0009011606020010 F*            to encryption.                                      *
0009021606020010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012001606010013 Fpassdkd   CF   E             WORKSTN
001300970401     F                                     SFILE(SF01:RRN)
0014001605310015 Fpassmst   UF A E           K DISK
0015020207010015 Fgbsecure  IF   E           K DISK
001505020702     dleave            s              1    inz('N')
001506020702     dleavescrn02      s              1
001507160602      ******************************************************************
001508160602      **** DO NOT CHANGE THIS KEY ***
001509160601     d key             s             20    inz('qTbiDL9@.iD-P#bU\Wj}')
001510160602      ******************************************************************
001511160601     d cryptin         s             20
001512160601     d cryptout        s             20
001513160602     d value_h         s                   like(valueout)
001514160602     d stat_h          s                   like(pastat)
001600950126     D COMPAN          DS
001700940921     D*  DATA AREA - COMPANY NAME
001800940921     D  COMP                   1     55
002301020702     D                uDS
002302020702     D  luser                  1     10
003800160531     C                   clear                   code
004300020702
004301020702     c                   dou       leave = 'Y'
004401020702     C                   EXFMT     SCRN01
004402020702     c                   clear                   msg
0047000207020077 C*  f7 END
0049000207020079 C                   if        *in07
0050009409210080 C                   SETON                                        LR
0051000207020080 C                   eval      leave = 'Y'
0051010207020080 C                   iter
005200940921     C                   END
0053009704010076 C*
0054001605310077 C*  f5 DISPLAY SUBFILE OF codes
0055009704010078 C*
0056000207020079 C                   if        *in05
0057001605310080 C                   EXSR      #dspcodes
0058000207020080 C                   iter
005900970401     C                   END
0063001606010076
0063011606010077 C*  do not allow blank code
006303160601     c                   if        code = *blanks
006304160601     c                   iter
006305160601     c                   end
006306160602
006307160602     c                   clear                   value_h
006308160602     c                   clear                   stat_h
006309160601
006400160531     C     code          CHAIN     passmst
006502160531      * existing record
006505160531     c                   if        %found(passmst)
006515160531     c     pachgusr      chain     gbsecure
006516160531     c                   if        %found(gbsecure)
006517160531     c                   movel     scname        chgusrout
006523160531     c                   else
006524160531     c                   clear                   chgusrout
006525160531     c                   end
006526160601      * decrypt pw
006527160601     c                   movel     pavalue       cryptin
006528160601     c                   exsr      #crypt
006529160601     c                   movel     cryptout      valueout
006530160602     c                   movel     cryptout      value_h
006531160602
006532160602     c                   movel     pastat        stat_h
006533160601
006534160601     c                   movel     pachgdt       chgdtout
006535160601     c                   movel     pachgtim      chgtimout
006536160531
006537160531      * new record
006538020702     c                   else
006539160531     c                   clear                   passmsr
006540160601     c                   clear                   chgdtout
006541160601     c                   clear                   chgtimout
006542160601     c                   clear                   valueout
006543160531     c                   move      code          pacode
006544160601     c                   move      'A'           pastat
006545020702     c                   end
006546020701
006547020702     c                   eval      leavescrn02 = 'N'
006548020702
006549020702     c                   dou       leavescrn02 = 'Y'
006550020701     c                   exfmt     scrn02
006551160601     c                   eval      *in50 = *off
006552160601     c                   clear                   msg
006553020702
006554070607     c* f1 - return to 1st screen (release rec if found)
006555020702     c                   if        *in01
006556160531     c                   if        %found(passmst)
006557160531     c                   unlock    passmst
006558070607     c                   end
006559020702     c                   leave
006560020702     c                   end
006561070529
0065621605310076 C* must enter description and reason
006563160531     C                   if        padesc = *blanks
006564160531     C                   eval      msg = '* Description is required  *'
006565160601     c                   eval      *in50 = *on
006566070529     c                   iter
006567070529     C                   END
006568160601
006569160601     C                   if        valueout = *blanks
006570160531     C                   eval      msg = '* PW value is required  *'
006571160601     c                   eval      *in50 = *on
006572160531     c                   iter
006573160531     C                   END
006574160601
006575160601     C                   if        pastat <> 'A' and pastat <> 'D'
006576160601     C                   eval      msg = '* Status must be A or D    *'
006577160601     c                   eval      *in50 = *on
006578160601     c                   iter
006579160601     C                   end
006580020702
006581160602      * record user who changed the password or status
006582160602     c                   if        value_h <> valueout or
006583160602     c                             stat_h <> pastat
006584160531     c                   move      *date         pachgdt
006585160531     c                   time                    pachgtim
006586160531     c                   movel     luser         pachgusr
006587160602     c                   end
006588160601      * encrypt pw
006589160601     c                   movel     valueout      cryptin
006590160601     c                   exsr      #crypt
006591160601     c                   movel     cryptout      pavalue
006592160531
006593160602      * update or add
006594160531     C                   if        %found(passmst)
006801160531     C                   update    passmsr
007000970401     C                   ELSE
007200160531     C                   WRITE     passmsr
007300970401     C                   END
007301020702
007302020702     c                   leave
007304020702     c                   enddo
007305020702
007500160531     C                   clear                   code
007801020702
0079000207020168 C                   enddo
008100970401     C************************************
008200160601     C* encrypt / decrypt
008300970401     C************************************
008401160601       begsr #crypt;
008402160601       clear cryptout;
008403160601       cryptout = %bitxor(cryptin: key);
008405160601       endsr;
008407160601
008500970401     C*
008501160601     C************************************
008502160601     C* DISPLAY codes IN SUBFILE WINDOW  *
008503160601     C************************************
008504160601     C     #dspcodes     BEGSR
008505160601     C*
008600970401     C* CLEAR SUBFILE
008700970401     C*
008800970401     C                   MOVEA     '001'         *IN(90)
008900970401     C                   WRITE     SF01CTL
009000970401     C                   MOVE      '0'           *IN92
009100970401     C*
009200970401     C* BUILD SUBFILE
009300970401     C*
009400970401     C                   MOVE      *ZEROS        RRN               5 0
009500160531     C     *LOVAL        SETLL     passmst
009600160531     C                   dou       %eof(passmst)
009700160531     C                   READ(n)   passmst                                91
009800020702     C                   if        *in91 = *off
010200970401     C                   ADD       1             RRN
010201160601     c                   move      pacode        sfcode
010202160602     c                   movel     padesc        sfdesc
010204160601     c                   move      pastat        sfstat
010205160601      * decrypt pw
010206160601     c                   movel     pavalue       cryptin
010207160601     c                   exsr      #crypt
010208160601     c                   movel     cryptout      sfvalue
010209160601
010300970401     C                   WRITE     SF01
010500970401     C                   END
010502020702     c                   enddo
010600970401     C*
010700970401     C* DISPLAY SUBFILE IN WINDOW
010800970401     C*
011000020703     C                   if        rrn > 0
011100020703     C                   eval      *in90 = *on
011200020703     C                   end
011300970401     C*
011400970401     C                   WRITE     WINDOW
011500970401     C                   EXFMT     SF01CTL
011800970401     C                   ENDSR
011958020701
011959020701
012000020701     C     *inzsr        BEGSR
012001020701     C*
012002020701     C* GET DATA AREA AND IMMEDIATELY RELEASE
012003020701     C*
012005020701     C     *DTAARA       DEFINE                  COMPAN
012006020701     C                   IN        COMPAN
012007020701     C                   MOVEL     COMP          COMPNY
012100020701     C                   ENDSR
