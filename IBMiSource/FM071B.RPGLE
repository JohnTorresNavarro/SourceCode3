0002009102150002 F******************************************************************
0003001012210003 F* fm071B     GROUP BENEFIT SERVICES SOFTWARE                     *
0004009102150004 F*                                                                *
0005000412150005 F*            WRITTEN BY - David Keterman                         *
0006001012210006 F*            DATE - 12/21/10                                     *
0007009102150007 F*                                                                *
0008000412150008 F*  DESCRIPTION - Display codes in seperate window in FM070.      *
0011020412150011  *                This program counts on the codes file being     *
0011030412150011  *                overridden to f.codes before calling it since   *
0011040412150011  *                there is no CL.                                 *
0011050412150011  *                                                                *
0011071012210011  * 12/21/10 DLK - This version was created for 132 column screens.*
0011081012210011  *                Add parm to make window position accross variable
0011091012210011  *                A program to system field was needed for this.  *
0011121012210011  *                Also add coverge type (T) to list of valid types*
0011131606210011  * 06/21/16 dlk - do not show acct term codes
0012009102150012 F******************************************************************
0013009102150013 F*                                                                *
0014001012210014 Ffm071bd   cf   e             WORKSTN
001401040803     F                                     SFILE(SF01:RRN)
0015000412150015 FCODES     IF A e           k DISK
001701040803     d rrn             s              5  0
001702041215     c     *entry        plist
001703041215     c                   parm                    ptype             1
001705101221     c                   parm                    pposition         3
016005040803
016007101221      * window position accross
016008101221     c                   move      pposition     position          3 0
016009101221
016010041215     c                   select
016011101221     c                   when      ptype = 'T'
016012101221     c                   eval      title = '  -- COVERAGE TYPE CODES --   '
016013101221     c                   when      ptype = 'E'
016014101221     c                   eval      title = '  -- REINSTATEMENT CODES --   '
016015041215     c                   when      ptype = 'D'
016016041215     c                   eval      title = ' ---- TERMINATION CODES ----  '
016017041215     c                   other
016018041215     c                   eval      title = '  ---- UNKNOWN CODE -----     '
016019041215     c                   endsl
016020040803     C* CLEAR SUBFILE
016021040803     C                   MOVEA     '001'         *IN(40)
016022041215     C                   WRITE     SF01CTL
016023040803     C                   eval      *IN42 = *off
016024040803     C*
016025040803     C* BUILD SUBFILE
016026040803     C*
016027040803     C                   clear                   RRN
016028041215     C     ptype         SETLL     codes
016029041215     C                   dou       %eof(codes)
016030041215     C     ptype         READE     codes                                  41
016031041215     C                   if        not %eof(codes) and cddltd = 'A'
016032041215
016033041215      * reinstate acct not allowed
016034041215     c                   if        type = 'E' and code = 'RA'
016035041215     C                   iter
016036041215     C                   END
016037160621      * Do not show Acct level term codes
016038160621     c                   if        type = 'D' and actn2 = 'A'
016039160621     C                   iter
016040160621     C                   end
016042041215
016043040803     C                   ADD       1             RRN
016044041215     c                   move      code          x1
016045041215     c                   movel     ldescr        x2
016046040803     C                   WRITE     SF01
016047040803     C                   iter
016048040803     C                   END
016049040803     C                   ENDDO
016050040803
016051040803     C* DISPLAY SUBFILE IN WINDOW
016052040803     C                   if        rrn > 0
016053040803     C                   eval      *in40 = *on
016054040803     C                   END
016055040803     C*
016056041215     C**                 WRITE     savscrn
016057041215     C                   WRITE     WINDOW
016058101221
016059040803     C                   EXFMT     SF01CTL
016060041215
016100041215     c                   eval      *inlr = *on
