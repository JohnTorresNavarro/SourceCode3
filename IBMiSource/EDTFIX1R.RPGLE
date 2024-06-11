000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *_________________________________________________________________________
000400160810     FMCOV19    UF   E           K Disk    extfile('F.MCOV19')
000500160810     FCODESL1   IF   E           K Disk    extfile('F.CODESL1')
000600160809
000700160810     D  trs            s              3s 0 inz(005)
000800160725     D  pos            s              3s 0 inz
000900160809     D w80date         S              8S 0
001000160809
001100000000      * Program status data structure
001200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001300160725
001400160810     C     trs           setll     MCOV19
001500160810     C     trs           reade     MCOV19
001600160810     C                   dow       not %eof(MCOV19)
001700160810     C                   if        cactfl = 0
001800160810     C     mcovtp        chain     CODESL1
001900160810     C                   if        %found(CODESL1)
002000160810
002100160810     C                   move      action        cactfl
002200160810     C                   update    mcovr
002300160725
002400160810     C                   end
002500160809     C                   end
002600160810     C     trs           reade     MCOV19
002700160725     C                   enddo
002800160725
002900160725     C                   eval      *inlr = *on
003000160725     C                   return
