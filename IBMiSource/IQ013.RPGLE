000100180112
000200180112     H option(*NodebugIo)
000300180112
0004009602140002 F******************************************************************
0005000506160003 F* iq013      GROUP BENEFIT SERVICES, INC.
0006009602140004 F*                                                                *
0007009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0008000506100006 F*            DATE - 06/10/05                                     *
0009009602140007 F*                                                                *
0010000506160007 F* alt id lookup called from iq010                                *
0011000801210007 F* 01/21/08 dlk - change "return" to set on LR because memalt     *
0012000801210007 F*                needs to be free for clear every day.           *
0013000801210007 F*                                                                *
0014009602140013 F******************************************************************
001500050610     Fiq013d    CF   E             WORKSTN
001600961031     F                                     SFILE(SF01:RRN)
001700050610     Fmemalt    IF   E           K DISK
001800050610     Fmemaltl1  IF   E           K DISK    rename(memaltr:memaltrl1)
001900050610     Falttyp    IF   E           K DISK
002000050610     Fmember    IF   E           K DISK
002100050610     D DIGITS          C                   CONST('0123456789')
0022000506100600 D                UDS
0023000506100601 D  COname               201    240
002400050613     c     *ENTRY        plist
002500050613     C                   parm                    parmssn           9
002600010330
002700050616     c                   eval      *in01 = *off
002800050616     C                   clear                   RRN
002900050616     C                   clear                   memid
003000050616
003100050613     c                   dow       *in01 = *off
003200050610
003300050610     C* CLEAR SUBFILE
003400050610     C                   MOVEA     '001'         *IN(90)
003500050610     C                   WRITE     SF01CTL
003600050610     C                   MOVE      '0'           *IN92
003700050616     C                   clear                   RRN               5 0
003800050616
003900050610      * check memid input field
004000050610     C                   move      'Y'           numeric           1
004100050610     c                   movel     memid         memid9            9
004200050610     c                   move      memid         memid11          11
004300050610     C     DIGITS        CHECK     memid9                                 99
004400050610     C   99              MOVE      'N'           numeric
004500050610
004600050610     c                   if        numeric = 'Y' and memid11 = *blanks
004700050610     c                   move      memid9        memid9num         9 0
004800050610     c     memid9num     chain     member
004900050616      * add member to subfile
005000050616     c                   if        %found(member)
005100050610     c                   clear                   sf01
005200010402
005300050610     c                   move      mbssno        ssnout
005400050610     c                   eval      altdesout = 'GBS ID - SSN       '
0055000506100202 C                   MOVEl     mfname        nameout                                       SR#NA
005600050610     C                   CAT       mlname:1      nameout
005700010330
005800961031     C                   ADD       1             RRN
005900961031     C                   WRITE     SF01
006000050610     c                   clear                   sf01
006100050610     C                   end
006200050610
006300050610      * look for SSN in alt id file
006400050610     C     memid9num     SETLL     memalt
006500050610     C                   dou       %eof(memalt)
006600050610     C     memid9num     reade     memalt
006700050610     C                   if        not %eof(memalt)
006800050610     c                   move      mamemid       ssnout
006900050610     c                   move      maaltid       altidout
007000050610     c     maalttp       chain     alttyp
007100050610     c                   if        %found(alttyp)
0072000506100202 C                   MOVEl     atdes         altdesout                                     SR#NA
007300050610     c                   end
0074000506100202 C                   MOVEl     mafname       nameout                                       SR#NA
007500050610     C                   CAT       malname:1     nameout
007600050610     C                   move      macrtdt       @datin
007700050610     C                   exsr      #datym
007800050610     C                   move      @datou        dateout
007900050610     C                   ADD       1             RRN
008000050610     C                   WRITE     SF01
008100050610     c                   clear                   sf01
008200050610     C                   END
008300050610     C                   enddo
008400050610
008500010330     C                   end
008600050610
008700050610      * look for id in alt id file
008800050610
008900050610     C     memid         SETLL     memaltl1
009000050610     C                   dou       %eof(memaltl1)
009100050610     C     memid         reade     memaltl1
009200050610     C                   if        not %eof(memaltl1)
009300050610     c                   move      mamemid       ssnout
009400050610     c                   move      maaltid       altidout
009500050610     c     maalttp       chain     alttyp
009600050610     c                   if        %found(alttyp)
0097000506100202 C                   MOVEl     atdes         altdesout                                     SR#NA
009800050610     c                   end
0099000506100202 C                   MOVEl     mafname       nameout                                       SR#NA
010000050610     C                   CAT       malname:1     nameout
010100050610     C                   move      macrtdt       @datin
010200050610     C                   exsr      #datym
010300050610     C                   move      @datou        dateout
010400050610     C                   ADD       1             RRN
010500050610     C                   WRITE     SF01
010600050610     c                   clear                   sf01
010700050610     C                   END
010800050610     C                   enddo
010900050616
011000020226     C* DISPLAY SUBFILE
011100020226     C                   if        rrn = 0
011200020226     c                   clear                   sf01
011300050614     c                   if        memid <> *blanks
011400050610     c                   eval      altidout = '* NO MATCH FOUND *'
011500050614     c                   end
011600020226     c                   add       1             rrn
011700050614     c                   write     sf01
011800020226     C                   end
011900020226
012000020226     C                   eval      *in90 = *on
012100050610     C                   eval      *in91 = *on
012200020226
012300010402     C* display subfile with text at bottom
012400010402     C                   WRITE     Sf01CMDKY
012500961031     C                   EXFMT     SF01CTL
012600050610
012700050616     c* find what line (if any) has been selected
012800050613     c                   eval      *in33 = *off
012900050613     c                   dow       *in33 = *off
013000050613     c                   readc     sf01                                   33
013100050613     c                   if        *in33 = *off and sel <> *blank
013200050613     c                   move      ssnout        parmssn
013300050613     c                   leave
013400050613     c                   end
013500050613     c                   enddo
013600050613
013700050613     c* if line was selected, leave do group and pass parm back to
013800050613     c* calling pgm
013900050613     c                   if        parmssn <> *blanks
014000050613     c                   leave
014100050613     c                   end
014200050613
014300050610     c                   enddo
014400050610
014500080121     c***                return
014600080121     c                   eval      *inlr = *on
014700050610
0148000103300103 C***************************************************
0149000103300104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0150000103300105 C***************************************************
0151000103300107 C*
0152000103300107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0153000103300107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0154000103300107 C*
0155000103300106 C     #DATYM        BEGSR
015600010330     C                   MOVE      @DATIN        @MD               4 0
015700010330     C                   MOVEL     @DATIN        @Y                4 0
015800010330     C                   MOVEL     @MD           @DATOU            8 0
015900010330     C                   MOVE      @Y            @DATOU
016000010330     C                   MOVE      *ZEROS        @DATIN            8 0
0161000103300120 C                   ENDSR
