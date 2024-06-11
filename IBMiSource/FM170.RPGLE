0001009408170002 F******************************************************************
0002000705140003 F* fm170      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000705140006 F*            DATE - 05/14/07                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008000705140009 F*            invpri FILE (invoice priority file).                *
0008011905240007 F* 05/24/19 dlk - add hist for add or delete - Brandon S request. *
0009009408170010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012000705140013 Ffm170D    CF   E             WORKSTN
001300970401     F                                     SFILE(SF01:RRN)
0014000705140015 Finvpri    UF A E           K DISK
0015009703310015 FACCMST    IF   E           K DISK
0015020207010015 Fgbsecure  IF   E           K DISK
0015031905240015 Fhist      o  a E           K DISK
001504020702     dv                s              1    inz('V')
001505020705     dY                s              1    inz('Y')
001506020702     dleave            s              1    inz('N')
001507020702     dleavescrn02      s              1
001508020702     dmsg1             s             60    inz('INVALID ACCOUNT NUMBER')
001509020702     dmsg2             s             60    inz('ACCOUNT EXISTS - PRESS F4 TO DE-
001510020702     d                                     LETE OR ENTER TO UPDATE')
001511190524     d action          s              6
0015121905240125 D workdtymd       s               d   datfmt(*iso)
001600950126     D COMPAN          DS
001700940921     D*  DATA AREA - COMPANY NAME
001800940921     D  COMP                   1     55
001900970401     D                 DS
002000970401     D  TSA                    1     10  0
002100070514     D  inptrust               1      3  0
002200070514     D  inpsub                 4      6  0
002300070514     D  inpacc                 7     10  0
002301020702     D                uDS
002302020702     D  luser                  1     10
003800070514     C                   clear                   inptrust
003900070514     C                   clear                   inpsub
004000070514     C                   clear                   inpacc
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
0059020705150077 C*  f9 email list of accts to yourself
0059030207020079 C                   if        *in09
0059040705140080 C                   call      'FM171CL'
0059060207020080 C                   iter
005907020702     C                   END
0060009501260076 C*
006100070514     C     inpkey        CHAIN     ACCMST
006101020702     c                   if        not %found(accmst)
006102020702     c                   movel     msg1          msg
0062000207020168 C                   iter
006201020702     c                   end
0063000207020076 C*
006400070514     C     inpkey        CHAIN     invpri
0065009704010076 C*
006502020701     c                   clear                   scname
006505070514     c                   if        %found(invpri)
006506020702     c                   movel     msg2          msg
006515070514     c     inpuser       chain     gbsecure
006516020702
006517020702     c                   else
006518020702
006519070514     c                   clear                   inpreas
006520070514     c                   clear                   inpdate
006521070514     c                   clear                   inptime
006522070514     c                   clear                   inpuser
006523020702     c                   clear                   scname
006524020702     c                   end
006525020701
006528020702     c                   eval      leavescrn02 = 'N'
006529020702
006530020702     c                   dou       leavescrn02 = 'Y'
006531020701     c                   exfmt     scrn02
006532020702     c                   clear                   msg
006534020702
006535070607     c* f1 - return to 1st screen (release rec if found)
006536020702     c                   if        *in01
006537070607     c                   if        %found(invpri)
006538070607     c                   unlock    invpri
006539070607     c                   end
006540020702     c                   leave
006541020702     c                   end
006542070529
0065430705290076 C* must enter reason
006544070529     C                   if        inpreas = *blanks
006545070529     C                   eval      msg = '* PLEASE ENTER A REASON *'
006546070529     c                   iter
006547070529     C                   END
006548070529
0065490207020076 C* f4 delete request
006550070514     C                   if        *in04 and %found(invpri)
006551070515     C                   DELETE    invprir
006552190524     c                   eval      action = 'REMOVE'
006553190524     c                   exsr      #hist
006554020702     c                   leave
006555020702     C                   END
006556020702
006563020702      * update or add
006565070514     C                   if        %found(invpri)
006801070515     C                   update    invprir
007000970401     C                   ELSE
007101070515     c                   move      *date         inpdate
007102070515     c                   time                    inptime
007103070515     c                   move      luser         inpuser
007200070515     C                   WRITE     invprir
007201190524     c                   eval      action = 'ADD   '
007202190524     c                   exsr      #hist
007300970401     C                   END
007301020702
007302020702     c                   leave
007303020702
007304020702     c                   enddo
007305020702
007500070514     C                   clear                   inptrust
007600070514     C                   clear                   inpsub
007700070514     C                   clear                   inpacc
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
009500070514     C     *LOVAL        SETLL     invpri
009501020702
009600070514     C                   dou       %eof(invpri)
009601020702
009700070607     C                   READ(n)   invpri                                 91
009800020702     C                   if        *in91 = *off
009900070514     C     inpkey        CHAIN     ACCMST                             50
009901020702     c                   if        %found(accmst)
009902020702     C                   MOVEL     ACNAM1        NAME
009903020702     c                   else
010000020702     C                   clear                   NAME
010001020702     c                   end
010101020701
010109020702
010110070515     c     inpuser       chain     gbsecure
010111020701     c                   if        %found(gbsecure)
010112020701     c                   movel     scname        user
010113020701     c                   else
010114020701     c                   clear                   user
010115020701     c                   end
010116020702
010117070514     c                   movel     inpreas       reason18
010118070515     c                   extrct    inpdate:*d    da                2
010119070515     c                   extrct    inpdate:*m    mo                2
010120070515     c                   extrct    inptime:*h    ho                2
010121070515     c                   extrct    inptime:*mn   mi                2
010122020702     c                   movel     mo            date
010123020702     c                   move      da            date
010124020702     c                   movel     ho            time
010125020702     c                   move      mi            time
010126020701
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
0115020705150077 C*  f9 email list of accts to yourself
0115030207030079 C                   if        *in09
0115040705140080 C                   call      'FM171CL'
011505020703     C                   END
0115070207030076 C*
011600970401     C                   MOVE      *ZEROS        TSA
011700970401     C*
011800970401     C                   ENDSR
011958020701
011959190524     C************************************************************
011960190524     C* ROUTINE FOR history record
011961190524     C************************************************************
011962190524     C*
011963190524     C     #hist         BEGSR
011964190524     C                   CLEAR                   HISTR
011965190524     C                   movel     tsa           hkey
011966190524     C                   MOVE      'UIP'         TRCODE
011967190524       ck#not = action;
011968190524       note2  = inpreas;
011969190524     C                   MOVEL     'FM170'       HPRGNM
011970190524     C                   move      inptrust      HSTRST
011971190524     C                   move      inpsub        HSSUB#
011972190524     C                   move      inpacc        HSACCT
011973190524     C                   MOVE      'A'           HSDLTD
011979190524     C                   eval      workdtymd = %date
011980190524     C                   MOVE      workdtymd     trdate
011982190524     c                   eval      hstrtime = %time
011983190524     C                   MOVEL     luser         HOPER
011985190524     C                   WRITE     HISTR
011986190524
0119871905240120 C                   ENDSR
011988190524
011989020701
012000020701     C     *inzsr        BEGSR
012001020701     C*
012002020701     C* GET DATA AREA AND IMMEDIATELY RELEASE
012003020701     C*
012005020701     C     *DTAARA       DEFINE                  COMPAN
012006020701     C                   IN        COMPAN
012007020701     C                   MOVEL     COMP          COMPNY
012010070514     C     inpkey        KLIST
012011070514     C                   KFLD                    inptrust
012012070514     C                   KFLD                    inpsub
012013070514     C                   KFLD                    inpacc
012100020701     C                   ENDSR
