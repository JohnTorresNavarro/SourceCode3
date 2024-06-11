0001009102150002 F******************************************************************
0002000509150003 F* rpa091     GROUP BENEFIT SERVICES, INC.                        *
0003009102150004 F*                                                                *
0004000509150004 F*          David Ketterman 09/14/05                              *
0005009510040004 F*                                                                *
0007000712050014 F*          Create workfile by merging all CR130HS* files.        *
0017000712050015 F* 12/05/07 dlk - change cstat to cseq                            *
0017010802280015 F* 02/28/08 dlk - change design to use all seq#'s                 *
0018000304300015 F*                                                                *
0019009102150016 F******************************************************************
0020000509160018 FCR130HST  If   E           k DISK
0022000509160018 FCR130HSd  If   E           k DISK    rename(crhstr:crhsdr)
0022010509160018 FCR130HSo  If   E           k DISK    rename(crhstr:crhsor)
0029000509150027 Frpa091wk  O  a e             disk
0029010509150037 D workdt          S               d   datfmt(*iso)
0029020509150037 D nextmonth       S              8  0
002903050915     D                 DS
002904050915     D  cefiyymm               1      6  0
002905050915     D  cefiyy                 1      4  0
002906050915     D  cefimm                 5      6  0
002907050915     D                UDS
002908050915     D  ldateymd               1      8  0
002909050915     D  ldateym                1      6  0
003000010724
003100010724     c* do for CR130hst
003101050915
003102050915     c     ldateymd      setll     cr130hst
003103050915     c                   dou       %eof(cr130hst)
003104050915     C     ldateymd      reade     cr130hst
003105080228     c                   if        (not %eof(cr130hst))
003106050915     c                   write     rpa091wkr
003107050915     c                   end
004300010724     c                   enddo
004400010724
004401050915     c* do for CR130hso
004402050915
004403050915     c     ldateymd      setll     cr130hso
004404050915     c                   dou       %eof(cr130hso)
004405050915     C     ldateymd      reade     cr130hso
004406080228     c                   if        (not %eof(cr130hso))
004407050915     c                   write     rpa091wkr
004408050915     c                   end
004409050915     c                   enddo
004410050915
004411080228     c* do for CR130hsd
004412050915
004413050915     c     ldateymd      setll     cr130hsd
004414050915     c                   dou       %eof(cr130hsd)
004415050915     C     ldateymd      reade     cr130hsd
004416080228     c                   if        (not %eof(cr130hsd))
004418050915     c                   write     rpa091wkr
004419050915     c                   end
004420050915     c                   enddo
004436050915
008200010724     c                   eval      *inlr = *on
