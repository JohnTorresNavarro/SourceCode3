000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Create empty PAYDED for reference plans
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - May 06, 2015
000800000000      *_________________________________________________________________________
000900150506    ?FPAYDEDL1  UF A E           K DISK
001000150506     Fcomctuniq IF   E           K Disk
001100150506     FPLNMST    IF   E           K Disk    extfile('F.PLNMST')
001200150506     FCODESL1   IF   E           K Disk    extfile('F.CODESL1')
001300150506     FGRAT24    IF   E           K Disk    extfile('F.GRAT24')
001400150506     FPDREFPLP  if   e           K disk
001500150506     FWEBPAYCHP IF   E           K Disk
001600150506
001700150506     D  p#             s              3s 0 inz
001800150506     D  p_pdacct       s              4s 0
001900150506     D  x_pdacct       s              4a
002000150506
002100150506    ?D WDDTA         E DS                  EXTNAME(PAYDED) prefix(p_)
002200150506
002300000000      * Program status data structure
002400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000      *
002600150506     C     *Entry        Plist
002700150506     C                   Parm                    WDDTA
002800150506     C                   Parm                    x_PDACCT
002900150506
003000150506     C                   movel     x_pdacct      p_pdacct
003100150506
003200150506
003300150506
003400150506     C                   eval      PCGRPR = 'RULE'
003500150506     C     CHPKEY        Setll     WEBPAYCHP
003600150506     C     CHPKEY        Reade     WEBPAYCHP
003700150506     C                   dow       not %eof(WEBPAYCHP)
003800150506     C                   eval      P_PDRULE = %trim(PCCODE)
003900150506     C                   Exsr      CRTDED
004000150506     C     CHPKEY        Reade     WEBPAYCHP
004100150506     C                   enddo
004200150506
004300150506     C                   Return
004400000000      *___________________________________________________________________
004500150506      * Create DED
004600000000      *___________________________________________________________________
004700150506     C     CRTDED        BEGSR
004800150506
004900150506     C     comkey        Setll     comctuniq
005000150506     C     comkey        Reade     comctuniq
005100150506     C                   Dow       not %eof(comctuniq)
005200150506
005300150506     C                   If        P_PDBEDT >= EFFDAT and
005400150506     C                             P_PDENDT <= CMCAN  or
005500150506     C                             P_PDBEDT >= EFFDAT and
005600150506     C                             CMCAN  = 0
005700150506
005800150506     C     plnkey        Chain     PLNMST
005900150506     C                   If        %found(plnmst)
006000150506     C     plncat        Chain     CODESL1
006100150506     C                   If        %found(codesl1)
006200150506     C                   If        %trim(action) = 'M'
006300150506
006400150506    ? *
006500150506    ? * Only Create a set on entry if none exists.
006600150506     C     KEYNEW        Chain(n)  PAYDEDL1
006700150506     C                   If        not %found(PAYDEDL1)
006800150506     C     PKey          Setll     GRAT24
006900150506     C     PKey          Reade     GRAT24
007000150506     C                   Dow       not %eof(GRAT24)
007100150506     C                   If        GRDLTD = 'A'
007200150522     C                   If        P_PDBEDT >= FRMDAT and
007300150522     C                             P_PDENDT <= TODAT
007400150506     C     PRDKEY        Chain     PAYDEDL1
007500150506     C                   If        not %found(PAYDEDL1)
007600150506     C                   Eval      PDCHGU  =  WQUSRN
007700150506     C                   Eval      PDCHDT  =  Today
007800150506
007900150506     C                   Exsr      CHKREFP
008000150506
008100150506     C                   Eval      PD$AMT  =  *Zeros
008200150506     C                   Eval      PDWAIT  =  *Zeros
008300150506     C                   Eval      PDPYFR  =  *Zeros
008400150506     C                   Eval      PDENDT  =  P_PDENDT
008500150506     C                   Eval      PDBEDT  =  P_PDBEDT
008600150506     C                   Eval      PDCVTP  =  TYPECD
008700150506     C                   Eval      PDRULE  =  P_PDRULE
008800150506     C                   Eval      PDPLAN  =  PLPLAN
008900150506     C                   Eval      PDSUB#  =  P_PDSUB#
009000150506     C                   Eval      PDTRST  =  P_PDTRST
009100150506     C                   Write     PAYDEDR
009200150506     C                   End
009300150506     C                   End
009400150506     C                   End
009500150506     C     PKey          Reade     GRAT24
009600150506     C                   EndDo
009700150506     C                   End
009800150506
009900150506
010000150506     C                   End
010100150506     C                   End
010200150506     C                   End
010300150506     C                   End
010400150506     C     comkey        Reade     comctuniq
010500150506     C                   Enddo
010600150506      *
010700000000     C                   ENDSR
010800150506      *___________________________________________________________________
010900150506      * Check the Reference plan
011000150506      *___________________________________________________________________
011100150506     C     CHKREFP       BEGSR
011200150506
011300150506     C                   clear                   PRTYPE
011400150506     C     refkey        setll     pdrefplp
011500150506     C     refkey        reade     pdrefplp
011600150506     C                   dow       not %eof(pdrefplp)
011700150506     C                   If        p_pdbedt >= prefdt  and
011800150506     C                             p_pdendt <= prterm
011900150506     C                   Leave
012000150506     C                   end
012100150506     C     refkey        reade     pdrefplp
012200150506     C                   enddo
012300150506
012400150506     C                   Eval      PDPAMT  =  *Zeros
012500150506     C                   Eval      PDPDEP  =  *Zeros
012600150603     C                   Eval      PD$AMT  =  *Zeros
012700150506     C                   Eval      PDDAMT  =  *Zeros
012800150506
012900150506     C                   Select
013000150506     C                   when      %trim(PRTYPE) = 'P'
013100150506     C                   Eval      PDPAMT  =  1
013200150506     C                   when      %trim(PRTYPE) = 'D'
013300150603     C                   Eval      PD$AMT  =  1
013400150506     C                   Endsl
013500150506     C
013600150506     C                   ENDSR
013700000000      *___________________________________________________________________
013800000000      * Program open
013900000000      *___________________________________________________________________
014000000000     C     *INZSR        BEGSR
014100150506     C     *DATE         Mult      10000.0001    Today             8 0
014200150506    ?C     KEYNEW        Klist                                                  ACKCTL
014300150506    ?C                   Kfld                    P_PDTRST
014400150506    ?C                   Kfld                    P_PDSUB#
014500150506    ?C                   Kfld                    PLPLAN
014600150506     C                   Kfld                    P_PDBEDT
014700150506     C                   Kfld                    P_PDENDT
014800150506    ?C     PrdKey        Klist                                                  ACKCTL
014900150506    ?C                   Kfld                    P_PDTRST
015000150506    ?C                   Kfld                    P_PDSUB#
015100150506    ?C                   Kfld                    PLPLAN
015200150506     C                   Kfld                    P_PDBEDT
015300150506     C                   Kfld                    P_PDENDT
015400150506     C                   Kfld                    P_PDRULE
015500150506     C                   Kfld                    TYPECD
015600150506    ?C     PKey          Klist                                                  ACKCTL
015700150506    ?C                   Kfld                    P_PDTRST
015800150506    ?C                   Kfld                    P_PDSUB#
015900150506    ?C                   Kfld                    PLPLAN                         POSITION TO 1
016000150506    ?C     Plnkey        Klist                                                  ACKCTL
016100150506    ?C                   Kfld                    CMTRST
016200150506    ?C                   Kfld                    CSUBDV
016300150506    ?C                   Kfld                    CMPLAN                         POSITION TO 1
016400150506    ?C     comkey        Klist                                                  ACKCTL
016500150506    ?C                   Kfld                    P_PDTRST
016600150506    ?C                   Kfld                    P_PDSUB#
016700150506    ?C                   Kfld                    P_PDACCT                       POSITION TO 1
016800150506    ?C     REFKEY        Klist                                                  ACKCTL
016900150506    ?C                   Kfld                    P_PDTRST
017000150506    ?C                   Kfld                    P_PDSUB#
017100150506    ?C                   Kfld                    P_PDACCT                       POSITION TO 1
017200150506    ?C     chpkey        Klist                                                  ACKCTL
017300150506    ?C                   Kfld                    P_PDTRST
017400150506    ?C                   Kfld                    P_PDSUB#
017500150506    ?C                   Kfld                    P_PDACCT                       POSITION TO 1
017600150506    ?C                   Kfld                    PCGRPR                         POSITION TO 1
017700000000     C                   ENDSR
017800000000      *___________________________________________________________________
017900000000      * Program error handler
018000000000      *___________________________________________________________________
018100000000     C     *PSSR         BEGSR
018200000000     C                   CALL      'SNDRPGM'                            50
018300000000     C                   PARM                    WQPGMN
018400000000     C                   PARM                    WQSTSC
018500000000     C                   PARM                    WQRPGS
018600000000     C                   PARM                    WQMSG
018700000000     C                   ENDSR     '*CANCL'
