0001009408170002 F******************************************************************
0002000207010003 F* fm180      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000207010006 F*            DATE - 07/01/02                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008000207010009 F*            ULEXCL FILE (urgent letter exclude).                *
0009009408170010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012000207010013 Ffm180D    CF   E             WORKSTN
001300970401     F                                     SFILE(SF01:RRN)
001301020701     F                                     SFILE(SF02:RR2)
0014000207010015 Fulexcl    UF A E           K DISK
0015009703310015 FACCMST    IF   E           K DISK
0015010207010015 Fcodes     IF   E           K DISK
0015020207010015 Fgbsecure  IF   E           K DISK
001503020702     dv                s              1    inz('V')
001504020705     dY                s              1    inz('Y')
001505020702     dleave            s              1    inz('N')
001506020702     dleavescrn02      s              1
001507020702     dmsg1             s             60    inz('INVALID ACCOUNT NUMBER')
001508020702     dmsg2             s             60    inz('ACCOUNT EXISTS - PRESS F4 TO DE-
001509020702     d                                     LETE OR ENTER TO UPDATE')
001600950126     D COMPAN          DS
001700940921     D*  DATA AREA - COMPANY NAME
001800940921     D  COMP                   1     55
001900970401     D                 DS
002000970401     D  TSA                    1     10  0
002100020701     D  ultrust                1      3  0
002200020701     D  ulsub                  4      6  0
002300020702     D  ulacc                  7     10  0
002301020702     D                uDS
002302020702     D  luser                  1     10
003800020702     C                   clear                   ultrust
003900020702     C                   clear                   ulSUB
004000020702     C                   clear                   ulACC
004300020702
004301020702     c                   dou       leave = 'Y'
004302020702
004400020702     C                   eval      *in04 = *off
004401020702     C                   EXFMT     SCRN01
004402020702     c                   clear                   msg
0047000207020077 C*  f7 END
0049000207020079 C                   if        *in07
0050009409210080 C                   SETON                                        LR
0051000207020080 C                   eval      leave = 'Y'
0051010207020080 C                   iter
005200940921     C                   END
0053009704010076 C*
0054000207020077 C*  f5 DISPLAY SUBFILE OF ACCTS
0055009704010078 C*
0056000207020079 C                   if        *in05
0057009704010080 C                   EXSR      #DSPAC
0058000207020080 C                   iter
005900970401     C                   END
0059010207020078
0059020207020077 C*  f9 print report
0059030207020079 C                   if        *in09
0059040207020080 C                   call      'FM181CL'
005905020705     c                   parm                    Y
0059060207020080 C                   iter
005907020702     C                   END
0060009501260076 C*
006100020702     C     ulkey         CHAIN     ACCMST
006101020702     c                   if        not %found(accmst)
006102020702     c                   movel     msg1          msg
0062000207020168 C                   iter
006201020702     c                   end
0063000207020076 C*
006400020702     C     ulkey         CHAIN     ulexcl
0065009704010076 C*
006501020701     c                   clear                   ldescr
006502020701     c                   clear                   scname
006503020702     c                   clear                   excdes
006504020702
006505020702     c                   if        %found(ulexcl)
006506020702     c                   movel     msg2          msg
006507020702
006508020701     c     codkey        chain     codes
006509020702     C                   if        %found(codes)
006510020702     c                   move      ldescr        excdes
006511020702     c                   else
006512020702     c                   clear                   excdes
006513020702     c                   end
006514020702
006515020701     c     uluser        chain     gbsecure
006516020702
006517020702     c                   else
006518020702
006519020702     c                   clear                   ulrc
006520020702     c                   clear                   ultrdate
006521020702     c                   clear                   ultrtime
006522020702     c                   clear                   uluser
006523020702     c                   clear                   scname
006524020702     c                   end
006525020701
006528020702     c                   eval      leavescrn02 = 'N'
006529020702
006530020702     c                   dou       leavescrn02 = 'Y'
006531020701     c                   exfmt     scrn02
006532020702     c                   clear                   msg
006533020702     c                   eval      *in20 = *off
006534020702
006535020702     c* f1 - return to 1st screen
006536020702     c                   if        *in01
006537020702     c                   leave
006538020702     c                   end
0065390207020076
0065400207020077 C* f8 DISPLAY SUBFILE OF codes
0065410207020078
0065420207020079 C                   if        *in08
0065430207020080 C                   EXSR      #DSPcd
006544020702     c                   eval      *in08 = *off
006545020702     c                   iter
006546020702     C                   END
0065470207020076 C* f4 delete request
006548020702     C                   if        *in04 and %found(ulexcl)
006549020702     C                   DELETE    ulR
006551020702     c                   leave
006552020702     C                   END
006553020702
006554020702     c                   move      'V'           ulrcp
006555020702     c     codkey        chain     codes
006556020702     C                   if        not %found(codes)
006557020702     c                   eval      *in20 = *on
006558020702     c                   iter
006559020702     c                   else
006560020702     c                   eval      *in20 = *off
006561020702     c                   end
006562020702
006563020702      * update or add
006565020702     C                   if        %found(ulexcl)
006801020702     C                   update    ulR
007000970401     C                   ELSE
007101020702     c                   move      *date         ultrdate
007102020702     c                   time                    ultrtime
007103020702     c                   move      luser         uluser
007200020701     C                   WRITE     ulR
007300970401     C                   END
007301020702
007302020702     c                   leave
007303020702
007304020702     c                   enddo
007305020702
007500020702     C                   clear                   ultrust
007600020702     C                   clear                   ulSUB
007700020702     C                   clear                   ulACC
007801020702
0079000207020168 C                   enddo
008100970401     C************************************
008200970401     C* DISPLAY ACCTS IN SUBFILE WINDOW  *
008300970401     C************************************
008400970401     C     #DSPAC        BEGSR
008500970401     C*
008600970401     C* CLEAR SUBFILE
008700970401     C*
008800970401     C                   MOVEA     '001'         *IN(90)
008900970401     C                   WRITE     SF01CTL
009000970401     C                   MOVE      '0'           *IN92
009100970401     C*
009200970401     C* BUILD SUBFILE
009300970401     C*
009400970401     C                   MOVE      *ZEROS        RRN               5 0
009500020701     C     *LOVAL        SETLL     ulexcl
009501020702
009600020702     C                   dou       %eof(ulexcl)
009601020702
009700020701     C                   READ      ulexcl                                 91
009800020702     C                   if        *in91 = *off
009900020701     C     ulkey         CHAIN     ACCMST                             50
009901020702     c                   if        %found(accmst)
009902020702     C                   MOVEL     ACNAM1        NAME
009903020702     c                   else
010000020702     C                   clear                   NAME
010001020702     c                   end
010101020701
010102020701     c                   move      ulrc          rc
010103020701     c     codkey        chain     codes
010104020701     c                   if        %found(codes)
010105020701     c                   movel     ldescr        reason
010106020701     c                   else
010107020701     c                   clear                   reason
010108020701     c                   end
010109020702
010110020701     c     uluser        chain     gbsecure
010111020701     c                   if        %found(gbsecure)
010112020701     c                   movel     scname        user
010113020701     c                   else
010114020701     c                   clear                   user
010115020701     c                   end
010116020702
010117020702     c                   extrct    ultrdate:*d   da                2
010118020702     c                   extrct    ultrdate:*m   mo                2
010119020702     c                   extrct    ultrtime:*h   ho                2
010120020702     c                   extrct    ultrtime:*mn  mi                2
010121020702     c                   movel     mo            date
010122020702     c                   move      da            date
010123020702     c                   movel     ho            time
010124020702     c                   move      mi            time
010125020701
010200970401     C                   ADD       1             RRN
010300970401     C                   WRITE     SF01
010500970401     C                   END
010501020702
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
0115010207030077 C*  f9 print report
0115020207030079 C                   if        *in09
0115030207030080 C                   call      'FM181CL'
011504020708     c                   parm                    Y
011505020703     C                   END
0115070207030076 C*
011600970401     C                   MOVE      *ZEROS        TSA
011700970401     C*
011800970401     C                   ENDSR
011900020701
011901020701     C************************************
011902020701     C* DISPLAY codes in SUBFILE WINDOW  *
011903020701     C************************************
011904020702     C     #DSPcd        BEGSR
011905020701     C*
011906020701     C* CLEAR SUBFILE
011907020701     C*
011908020701     C                   MOVEA     '001'         *IN(80)
011909020702     C                   WRITE     SF02CTL
011910020701     C                   MOVE      '0'           *IN82
011911020701     C*
011912020701     C* BUILD SUBFILE
011913020701     C*
011914020701     C                   MOVE      *ZEROS        RR2               5 0
011915020702     C     v             SETLL     codes
011916020701     C                   dou       %eof(codes)
011917020702     C     v             READe     codes                                  81
011921020701
011922020701     c                   if        *in81 = *off
011923020701     c                   move      code          rc
011924020702     c                   movel     ldescr        desc
011939020701
011940020701     C                   ADD       1             RR2
011941020701     C                   WRITE     SF02
011943020701     C                   END
011944020701     C                   enddo
011945020701     C*
011946020701     C* DISPLAY SUBFILE IN WINDOW
011947020701     C*
011949020702     C                   if         RR2 > 0
011950020701     C                   MOVE      '1'           *IN80
011951020701     C                   END
011952020701     C*
011953020702     C                   WRITE     WINDOW2
011954020701     C                   EXFMT     SF02CTL
011956020701     C*
011957020701     C                   ENDSR
011958020701
011959020701
012000020701     C     *inzsr        BEGSR
012001020701     C*
012002020701     C* GET DATA AREA AND IMMEDIATELY RELEASE
012003020701     C*
012005020701     C     *DTAARA       DEFINE                  COMPAN
012006020701     C                   IN        COMPAN
012007020701     C                   MOVEL     COMP          COMPNY
012010020702     C     ulkey         KLIST
012011020702     C                   KFLD                    ultrust
012012020701     C                   KFLD                    ulSUB
012013020701     C                   KFLD                    ulACC
012014020701     C     codkey        KLIST
012015020701     C                   KFLD                    ulrcp
012016020701     C                   KFLD                    ulrc
012100020701     C                   ENDSR
