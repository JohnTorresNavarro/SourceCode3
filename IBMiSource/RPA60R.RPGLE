000100130110   X***X EDIT ADJUSTMENT CSV LOAD TO WORK FILE
000200130109   X***X
000300130110   X***X READ THE CLEAN LOAD FILE AND SPIT OUT FORMATTED RECS
000400130122   X***X
000500130122   X***X EVAL      RPDUM    = 'C'
000600130122   X***X    THIS MEANS IT CAME FROM THE CSV LOADER PROGRAM
000700130122   X***X
000800130122   X***X
000900130110   X***X SSK 01/10/13
001000130109   X***X
001100130122     FRPA60WF   IPE  E             DISK
001200130109    ***
001300130110     FRPA060WK  O  A E             DISK
001400130109    ***
001500130109     FACMUNIQUE IF   E           K DISK
001600130109     FCARUNIQUE IF   E           K DISK
001700130109     FPLNUNIQUE IF   E           K DISK
001800130110     FSMANSP    IF   E           K DISK
0019001301090014 FMKTCARA1  IF   e           k DISK
002000130109    ***
002100130109   X***X
002200130110    ***
002300130110     D parmrel         s                   like(rprelid)
002400130110     D parmcar         s                   like(rppcar)
002500130110     D parmmksz        s                   like(rpmaszcd)
002600130110     D parmeffymd      s                   like(rpefdt)
002700130110     D parmcomamt      s                   like(rppcom)
002800130110     D parmprem        s                   like(rppprm)
002900130110     D parmmcnt        s                   like(rpmcnt)
003000130110     D parmmethod      s                   like(rpaomthd)
003100130110     D parmrate        s                   like(rpaorate)
003200130110     D parmovramt      s                   like(rpaoamt)
003300130110     D parmfound       s              1
003400130110     D mksz            s                   like(rpmaszcd)
003500130110    ***
003600130110     D @@@PARMS        S            142A
003700130110    ***
003800130110     D                 DS
003900130110     D PRMS                    1    142A
004000130110     D P@SMAN                  1      3A
004100130110     D P@SNAME                 4     36A
004200130110     D P@AGCY                 37     39A
004300130110     D P@ANAME                40     79A
004400130110     D P@SUPER                80     82A
004500130110     D P@UNAME                83    132A
004600130110     D P@RELID               133    140A
004700130110     D P@RESULT              141    141A
004800130110     D P@REQUEST             142    142A
004900130110    ***
005000130109   X***X
005100130110     C                   CLEAR                   RPA60R
005200130110    ***
005300130110     C     KL#TSA        CHAIN     ACCMSR
005400130110    ***
005500130110     C     KL#TSP        CHAIN     PLNMSR
005600130110    ***
005700130110     C     PCARR         CHAIN     CARMSR
005800130110    ***
005900130110     C                   EVAL      PRMS = *BLANKS
006000130110     C                   EVAL      @@@PARMS = *BLANKS
006100130122     C                   EVAL      P@RELID = R6RELID
006200130110     C                   EVAL      P@REQUEST = 'R'
006300130116     C                   EVAL      @@@PARMS = PRMS
006400130116     C                   CALL      'GAC900'
006500130116     C                   PARM                    @@@PARMS
006600130116     C                   EVAL      PRMS = @@@PARMS
006700130110    ***
006800130110     C     P@SMAN        CHAIN     SMANR
006900130110    ***
007000130122     C                   EVAL      RPCDAT   = R6CDAT
007100130110    ***
007200130110     C                   EVAL      RPSMCD   = P@SMAN
007300130110     C                   EVAL      RPSLNM   = SLNAME
007400130110     C                   EVAL      RPSFNM   = SFNAME
007500130110     C                   EVAL      RPSMI    = SMI
007600130110     C                   EVAL      RPCCDE   = P@AGCY
007700130110    ***
007800130122     C                   EVAL      RPTRST   = R6TRS
007900130122     C                   EVAL      RPSUB    = R6SUB
008000130122     C                   EVAL      RPACC    = R6ACC
008100130110     C                   EVAL      RPANM    = ACNAM1
008200130110    ***
008300130122     C                   EVAL      RPGRP    = R6GRP
008400130110     C                   EVAL      RPPCAR   = PCARR
008500130110     C                   EVAL      RPCNAM   = CNAME
008600130122     C                   EVAL      RPPLAN   = R6PLN
008700130110     C                   EVAL      RPPDSC   = PDESCR
008800130110    ***
008900130122     C                   EVAL      RPCMRT   = R6CMRT
009000130122     C                   EVAL      RPMCNT   = R6MCNT
009100130122     C                   EVAL      RPPPRM   = R6PPRM
009200130122     C                   EVAL      RPMTHD   = R6MTHD
009300130110    ***
009400130110     C                   IF        RPMTHD = 'G ' OR RPMTHD = 'C ' or
009500130110     C                             RPMTHD = 'F '
009600130110     C     RPMCNT        MULT(H)   RPCMRT        RPPCOM
009700130110     C                   ELSE
009800130110     C     RPPPRM        MULT(H)   RPCMRT        RPPCOM
009900130110     C     RPPCOM        DIV(H)    100           RPPCOM
010000130110     C                   ENDIF                                                  RPMTHD = 'G '
010100130110    ***
010200130122     C                   EVAL      RPNOTE   = R6NOTE
010300130110     C                   EVAL      RPCHG    = 'A'
010400130122     C                   EVAL      RPDUM    = 'C'
010500130110    ***
010600130122     C                   MOVE      R6EFDT        @8                8
010700130110     C                   MOVEL     @8            @6                6
010800130110     C                   MOVE      @6            RPEDAT
010900130122     C                   EVAL      RPEFDT   = R6EFDT
011000130110    ***
011100130122     C                   EVAL      RPPSPL   = R6PSPL
011200130122     C                   EVAL      RPSEQ#   = R6SEQ
011300130122     C                   EVAL      RPRELID  = R6RELID
011400130110    ***
011500130122     C                   EVAL      RPCPDDT  = R6CPDDT
011600130122     C                   EVAL      RPPAID   = R6PAID
011700130110    ***
0118001301100456  * Get Acct Mkt size - default to 50 if not found
011900130110    ***
012000130110     c                   clear                   mksz
012100130110    ***
012200130110     c     mkcaky        setll     RMKTCARA
012300130110     C                   dou       %eof(mktcara1)
012400130110     c     mkcaky        reade     RMKTCARA
012500130110     c                   if        (not %eof(mktcara1)) and (mafrdt <> matodt)
012600130110     c                             and (mafrdt <= RPefdt) and
012700130110     c                             ((matodt >= RPefdt) or (matodt = 0))
012800130110     c                   movel     maszcd        mksz
012900130110     c                   leave
013000130110     c                   endif
013100130110     c                   enddo
013200130110    ***
013300130110     c                   if        mksz = *blanks
013400130110     c                   movel     '50'          mksz
013500130110     c                   endif
013600130110    ***
013700130110     c                   EVAL      RPMASZCD = MKSZ
013800130110    ***
013900130110      * calc agency override
014000130110    ***
014100130110     c     grplist       plist
014200130110     c                   parm                    parmrel
014300130110     c                   parm                    parmcar
014400130110     c                   parm                    parmmksz
014500130110     c                   parm                    parmeffymd
014600130110     c                   parm                    parmcomamt
014700130110     c                   parm                    parmprem
014800130110     c                   parm                    parmmcnt
014900130110     c                   parm                    parmmethod
015000130110     c                   parm                    parmrate
015100130110     c                   parm                    parmovramt
015200130110     c                   parm                    parmfound
015300130110
015400130110      * set parameter values
015500130110     c                   move      RPRELID       parmrel
015600130110     c                   move      RPPCAR        parmcar
015700130110     c                   move      RPMASZCD      parmmksz
015800130110     c                   move      RPefdt        parmeffymd
015900130110     c                   move      RPPCOM        parmcomamt
016000130110     c                   move      RPPPRM        parmprem
016100130110     c                   move      RPMCNT        parmmcnt
016200130110     c                   clear                   parmmethod
016300130110     c                   clear                   parmrate
016400130110     c                   clear                   parmovramt
016500130110     c                   clear                   parmfound
016600130110
016700130204     c                   call      'GETAOCL'     grplist
016800130110
016900130110      * if a valid agency override was found then move the calculated
017000130110      * retun values to the screen
017100130110     c                   if        parmfound = 'Y'
017200130110     c                   move      parmmethod    RPaomthd
017300130110     c                   move      parmrate      RPaorate
017400130110     c                   move      parmovramt    RPaoamt
017500130110     c                   endIF
017600130110
017700130110      * clear agency override values if the record is not "paid"
017800130110     c                   IF        RPPAID <> 'Y'
017900130110     c                   clear                   RPaomthd
018000130110     c                   clear                   RPaorate
018100130110     c                   clear                   RPaoamt
018200130110     C                   ENDIF
018300130110    ***
018400130110     C                   WRITE     RPA60R
018500130109    ***
018600130109    ***
018700130109   S***S
018800130110     C     *INZSR        BEGSR
018900130109    ***
019000130110     C     KL#TSA        KLIST
019100130122     C                   KFLD                    R6TRS
019200130122     C                   KFLD                    R6SUB
019300130122     C                   KFLD                    R6ACC
019400130109    ***
019500130110     C     KL#TSP        KLIST
019600130122     C                   KFLD                    R6TRS
019700130122     C                   KFLD                    R6SUB
019800130122     C                   KFLD                    R6PLN
019900130110    ***
020000130110     c     mkcaky        klist
020100130122     C                   KFLD                    R6TRS
020200130122     C                   KFLD                    R6SUB
020300130122     C                   KFLD                    R6ACC
020400130110     C                   KFLD                    PCARR
020500130110    ***
020600130109     C                   ENDSR
020700130109   S***S
