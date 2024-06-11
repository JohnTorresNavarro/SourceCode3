000100000000      *_________________________________________________________________________
000200000000      *
000300220204      *  Description:  Group Number error clean up
000400000000      *
000500220204      *  (c)Copyright 2022 by Amwins
000600000000      *
000700220204      *    Created by:  JALLEN - Feb 04, 2022
000800000000      *_________________________________________________________________________
000900220204     FDBEDTL834EIP A E             DISK
001000220204     FDBEDTL834MUF   E           K DISK       PREFIX(M_)
001100220204
001200220204    ?D WEDTA         E DS                  EXTNAME(DBEDTL834E)
001300220204    ?D WMDTA         E DS                  EXTNAME(DBEDTL834M) PREFIX(M_)
001400220204
001500220204     IDTLERR        01
001600220204
001700220204     C   01D3SUB         setll     DBEDTL834M
001800220204     C     D3SUB         reade     DBEDTL834M
001900220204     C                   dow       not %eof(DBEDTL834M)
002000220204     C                   if        D3BIRSQ <> M_D3BIRSQ
002100220204     C                   move      WMDTA         WEDTA
002200220204     C                   write     DTLERR
002300220204     C                   end
002400220204     C                   delete    DBEDTLR
002500220204     C     D3SUB         reade     DBEDTL834M
002600220204     C                   enddo
002700220204
