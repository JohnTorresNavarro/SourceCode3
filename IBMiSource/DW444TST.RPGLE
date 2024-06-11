0001000711080111  *
0002000910080029  *   Format Output Records
0003000910080250 D                 DS
0004000910130251 D   iblnme                1     25    INZ('12345678                ')
0005000910130251 D   ibfnme               26     43    INZ('                  ')
0006000910130251 D   ibmi                 44     44    INZ('L')
0007000910130111  *
0008000910130251 D  cntf           S              2  0 INZ(0)
0009000910130251 D  cntt           S              2  0 INZ(0)
0010000910130251 D  cntl           S              2  0 INZ(0)
0011000910130251 D  fnm1           S              1
0012000803270291  *
0013000910130296 C                   exsr      namrtn
001400091013      *
0015000910130297 C                   movel     '1'           *inlr
0016000910130297 C                   return
0017000910130291  *
0018000910130296 C     namrtn        begsr
0019000910130296 C                   eval      cntl = %scan('  ':iblnme:2)
0020000910130296 C                   if        cntl = 0
0021000910130296 C                   eval      cntl = 25
0022000910130296 C                   else
0023000910130296 C                   eval      cntl = cntl - 1
0024000910130296 C                   endif
0025000910130291  *      If LNAM is GT 18 - Just use last name
0026000910130296 C                   if        cntl > 18
0027000910130296 C                   movel     *blanks       ibfnme
0028000910130296 C                   movel     *blanks       ibmi
0029000910130296 C                   leavesr
0030000910130296 C                   endif
0031000910130291  *
0032000910130296 C                   eval      cntf = %scan('  ':ibfnme:2)
0033000910130296 C                   if        cntf = 0
0034000910130296 C                   eval      cntf = 18
0035000910130296 C                   else
0036000910130296 C                   eval      cntf = cntf - 1
0037000910130296 C                   endif
0038000910130291  *   If LNAM + FNAM + 1 > 18 - remove MI
0039000910130296 C                   eval      cntt = cntl + cntf + 1
0040000910130296 C                   if        cntt > 18
0041000910130296 C                   eval      ibmi = ' '
0042000910130296 C                   endif
0043000910130291  *   If LNAM + FNAM + 1 > 20 - remove MI and use 1 char FNAM
0044000910130291  *
0045000910130296 C                   if        cntt > 20
0046000910130296 C                   movel     ibfnme        fnm1
0047000910130296 C                   movel(P)  fnm1          ibfnme
0048000910130296 C                   endif
0049000910130296 C                   endsr
