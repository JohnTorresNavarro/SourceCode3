000100030521     H DATEDIT(*YMD)
0002009707230002 F******************************************************************
0003001504300003 F* rpm020     GROUP BENEFIT SERVICES SOFTWARE                     *
0004009707230004 F*                                                                *
0005009707230005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006001504300006 F*            DATE - 04/30/15                                     *
0007009707230007 F*                                                                *
0008001504300008 F*  DESCRIPTION - This is the urgent letter reprint. Note that    *
000900150430SK   F*                any changes to the urgent letter (RPF070) will  *
001000150508SK   F*                need to be considered here also since both      *
001100150508SK   F*                programs use the same printer file.             *
0012002202110007 F*                                                                *
001300220211SK   F* 02/11/22 dlk - recompile to pick up rpf070p3 change using      *
001400220211SK   F*                larger AA contact field on letter that was      *
001500220211SK   F*                changed months ago for the larger aa email      *
001600220211SK   F*                project.                                        *
001700220211SK   F*                                                                *
0018009811190013 F******************************************************************
001900150430     Frpm020d   CF   E             WORKSTN
002000970812     F                                     SFILE(S02SFL:RR2)
002100150430     Faccmst    IF   E           K DISK
002200150508     Fgbsecure  IF   E           K DISK
002300150430     Fulhistl1  IF   E           K DISK
0024001504300027 FRPF070P3  O    e             PRINTER
0025001505060037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
002600150430SSK1 D #ISO            S               D   DATFMT(*ISO)
002700150430SSK1 D #USA            S               D   DATFMT(*USA)
002800150430SSK1 D h_trdate        S               d
002900150430SSK1 D h_trtime        S               t
0030001504300050 D                 DS
0031001504300051 D  s1tsa                  1     10  0 inz
0032001504300054 D  s1trust                1      3  0
0033001504300052 D  s1sub                  4      6  0
0034001504300053 D  s1acc                  7     10  0
0035001505060050 D                 DS
0036001505070051 D  wktrdate               1      8  0 inz
0037001505070054 D  wktryyyyc              1      4
0038001505070054 D  wktrmm                 5      6  0
0039001505070054 D  wktrddc                7      8
0040001504300600 D                UDS
0041001504300601 D  CONAME               201    240
004200150430
004300970812     C* DISPLAY FIRST SCREEN
004400090202     c                   dou       *inkg
004500970813     C                   EXFMT     S01
004600090203      * F7 - end
004700090203     c                   if        *inkg
004800090203     c                   leave
004900090203     c                   end
005000090203
005100150430     C* VALIDATE acct
005200150507     C     acckey        CHAIN     accmst
005300150430     C                   if        not %found(accmst)
005400090202     c                   eval      *in21 = *on
005500090202     c                   iter
005600090202     c                   else
005700090202     c                   eval      *in21 = *off
005800150430     c                   move      s1tsa         otsa
005900150430     c                   movel     acnam1        oname
006000090202     c                   end
006100090203
006200090203      * DSPLAY SCREEN 2
006300090202     C                   EXSR      #DSP02
006400090203
006500090202     C                   enddo
006600090202
006700090202     C* end program
006800970812     C                   MOVE      *ON           *INLR
006900970812     C*
007000970813     C*******************************************************
007100090203     C* SCREEN 2 SUBROUTINE                                 *
007200970813     C*******************************************************
007300970812     C*
007400970812     C     #DSP02        BEGSR
007500090203      * stay in this SR until F1 is pressed
007600090203     c                   dou       *inka
007700090203      * CLEAR SUBFILE
007800970813     C                   MOVEA     '0010'        *IN(60)
007900090203     C                   MOVE      ' '           s2sel
008000970812     C                   WRITE     S02CTL
008100970723     C                   MOVE      '0'           *IN62
008200090203
008300150430      * BUILD SUBFILE - LOAD ALL FOR THIS acct
008400970723     C                   Z-ADD     1             SFREC#
008500970812     C                   MOVE      *ZEROS        RR2               5 0
008600090203     C                   CLEAR                   S02SFL
008700150430      * get urgent letters
008800150507     C     acckey        setll     ulhistl1
008900150430     C                   dou       %eof(ulhistl1)
009000150507     C     acckey        READE     ulhistl1
009100150430     C                   if        not %eof(ulhistl1)
009200150430
009300150430     c                   if        uhtrdate <> d'0001-01-01'
009400150430     C                   move      uhtrdate      #usa
009500150430     C                   move      #usa          s2trdt
009600150430     c                   end
009700150430     C                   move      uhtrtime      s2time
009800150508
009900150508      * user name
010000150508     c                   clear                   s2user
010100150508     C     uhuser        chain     gbsecure
010200150508     c                   if        %found(gbsecure)
010300150508     c                   movel     scname        s2user
010400150508     c                   end
010500150508
010600150430     C                   z-add     uhbal         s2amt
010700150430     C                   move      uheffdt       #iso
010800150430     C                   move      #iso          #usa
010900150430     C                   move      #usa          s2effdt
011000150430      * what type of letter? C = care first, N = Non-Care First
011100150430     C                   move      uhlet         s2typeh
011200150430     c                   if        uhlet = 'C'
011300150430     c                   eval      s2type = 'CARE FIRST'
011400150430     c                   else
011500150430     c                   eval      s2type = 'NON-CF    '
011600150430     c                   end
011700150430     C                   ADD       1             RR2
011800150430     C                   WRITE     S02SFL
011900150430
012000150430     C                   end
012100150430     C                   enddo
012200150430
012300970723     C*
012400970723     C* DISPLAY SUBFILE
012500970723     C*
012600970723     C     #T0120        TAG
012700090203     C                   if        rr2 > 0
012800090203     C                   eval      *IN60 = *on
012900970813     C                   END
013000090203     C                   eval      *IN61 = *on
013100970813     C*
013200090203     C                   WRITE     S02FKY
013300970813     C                   EXFMT     S02CTL
013400090203     c                   clear                   s2err
013500090203     c                   clear                   *in90
013600090203
013700090203     C* F1 RETURN
013800090203     C                   if        *inka
013900090203     c                   leavesr
014000090203     c                   end
014100090203
014200090203     C* READ SUBFILE FOR SELECTION
014300090203     C                   if        *in60
014400150430     c                   dou       %eof(rpm020d)
014500090203     C                   READC     S02SFL
014600150430     c                   if        not %eof(rpm020d)
014700090203
014800150430      * process selected letters
014900150430     C                   if        s2sel <> ' '
015000150430     c                   exsr      #print
015100150430     C                   end
015200090203
015300090203     C                   END
015400090203     C                   enddo
015500090203     C                   END
015600090203
015700090203     c                   enddo                                                  end F1
015800090203
015900970812     C                   ENDSR
016000150430
016100150430     C*******************************************************
016200150430     C* print letter selected
016300150430     C*******************************************************
016400150430     C*
016500150430     C     #print        BEGSR
016600150430
016700150430     c                   move      s2trdt        #usa
016800150430     c                   move      #usa          #iso
016900150430     c                   move      #iso          h_trdate
017000150430
017100150430     c                   move      s2time        h_trtime
017200150430
017300150430     C     ulhistkey     chain     ulhistl1
017400150430     c                   if        %found(ulhistl1)
017500150506      * date line
017600150507     c                   move      uhtrdate      wktrdate
0177001505060329 C                   clear                   DL
0178001505070332 C                   MOVEL     YR(wktrmm)    DL
017900150507     C                   CAT       wktrddc:1     DL
018000150506     C                   CAT       ',':0         DL
018100150507     C                   CAT       wktryyyyc:1   DL
018200150506
018300150506     c                   movel     uhaline1      aline1
018400150506     c                   movel     uhaline2      aline2
018500150506     c                   movel     uhaline3      aline3
018600150506     c                   movel     uhaline4      aline4
018700150506     c                   movel     uhaline5      aline5
018800150506     c                   movel     uhaline6      aline6
018900150514     c                   z-add     uhbal         outbal
019000150506     c                   movel     uhg#1         grp#out1
019100150506     c                   movel     uhg#2         grp#out2
019200150507
019300150507     c                   movel     uheffdt       #iso
019400150507     c                   movel     #iso          #usa
019500150507     c                   movel     #usa          lmdy
019600150507
019700150507     c                   clear                   gracendt
019800150507     c                   if        uhgracedt <> 0
019900150507     c                   movel     uhgracedt     #iso
020000150507     c                   movel     #iso          #usa
020100150507     c                   movel     #usa          gracendt
020200150507     c                   end
020300150507
020400150506     c                   movel     uhaacon       aacontact
020500150506     c                   movel     uhaaname      aaname
020600150506     c                   move      s1tsa         keyacc
020700210520     c                   movel     uhsmanout     smanout          32
020800150430
020900150507      * print care first letter
021000150507     c                   if        uhlet = 'C'
0211001505070146 C                   WRITE     ULVARCF
0212001505070307 C                   WRITE     ULPSCF
021300150507     c                   else
021400150507      * print non care first letter
0215001505070146 C                   WRITE     ULVARNCF
0216001505070307 C                   WRITE     ULPSNCF
021700150430     c                   end
021800150507
021900150508     c                   eval      s2err = 'Letter has been submitted for +
022000150508     c                             printing'
022100210430     c                   eval      parmone = 'Y'
022200150507     c                   end
022300150430
022400150430     C                   ENDSR
022500090203
022600150506     C*******************************************************
022700150506     C* first cycle
022800150506     C*******************************************************
022900030521     C     *inzsr        begsr
023000090203
023100210430     c     *entry        plist
023200210430     c                   parm                    parmone           1
023300210430
023400150507     C     acckey        KLIST
023500150430     C                   KFLD                    s1trust
023600150430     C                   KFLD                    s1sub
023700150430     C                   KFLD                    s1acc
023800090203
023900150430     C     ulhistkey     KLIST
024000150430     C                   KFLD                    s1trust
024100150430     C                   KFLD                    s1sub
024200150430     C                   KFLD                    s1acc
024300150430     C                   KFLD                    h_trdate
024400150430     C                   KFLD                    h_trtime
024500150430     C                   KFLD                    s2typeh
024600150430
024700030521     C                   ENDSR
024800150506**
024900150506January
025000150506February
025100150506March
025200150506April
025300150506May
025400150506June
025500150506July
025600150506August
025700150506September
025800150506October
025900150506November
026000150506December
