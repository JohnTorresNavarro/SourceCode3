0002009102150002 F******************************************************************
0003000412150003 F* fm071      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009102150004 F*                                                                *
0005000412150005 F*            WRITTEN BY - David Keterman                         *
0006000412150006 F*            DATE - 12/15/04                                     *
0007009102150007 F*                                                                *
0008000412150008 F*  DESCRIPTION - Display codes in seperate window in FM070.      *
0011020412150011  *                This program counts on the codes file being     *
0011030412150011  *                overridden to f.codes before calling it since   *
0011040412150011  *                there is no CL.                                 *
0011050412150011  *                                                                *
0011061012210011  * 12/21/10 dlk - add parm to make window position accross variable
0011071012210011  *                using a program to system field.
0011081012210011  *                This program is now used on 80 col screens only.
0011111012210011  *                Also add coverge type (T) to list of valid types
0011121107210011  * 07/21/11 dlk - add type "R" - relation codes. This pgm is now
0011131606220011  *                called from FM075 also. (FM075 no longer used)
0011141606210011  * 06/21/16 dlk - do not show acct term codes
0011151606220011  * 06/22/16 dlk - This program is now called from TR050 also to show
0011161606220011  *                member level term codes.
0011171705100011  * 05/10/17 dlk - Add 3rd column to show the action code for term codes
0011181705100011  *                which is the transmit Y/N field.
0012009102150012 F******************************************************************
0013009102150013 F*                                                                *
0014000412150014 Ffm071d    cf   e             WORKSTN
001401040803     F                                     SFILE(SF01:RRN)
0015000412150015 FCODES     IF A e           k DISK
001701040803     d rrn             s              5  0
001702041215     c     *entry        plist
001703041215     c                   parm                    ptype             1
001706101221     c                   parm                    pposition         3
016005040803
016006170510      * window position accross, if a position > 30 was passed, change it
016007170510      * to 30 so it will fit on 80 col screen.
016009101221     c                   move      pposition     position          3 0
016010170510     c                   if        position > 30
016011170510     c                   eval      position = 30
016012170510     c                   end
016013170510
016014170510     c                   clear                   col3
016015170510     c                   eval      *in98 = *off
016016101221
016017041215     c                   select
016018101221     c                   when      ptype = 'T'
016019101221     c                   eval      title = '  -- COVERAGE TYPE CODES --   '
016020101221     c                   when      ptype = 'E'
016021101221     c                   eval      title = '  -- REINSTATEMENT CODES --   '
016022041215     c                   when      ptype = 'D'
016023041215     c                   eval      title = ' ---- TERMINATION CODES ----  '
016024170510     c                   eval      col3  = 'TRANSMIT  '
016025170510     c                   eval      *in98 = *on                                  underline
016026110721     c                   when      ptype = 'R'
016027110721     c                   eval      title = '-- DEPENDENT RELATION CODES --'
016028041215     c                   other
016029041215     c                   eval      title = '  ---- UNKNOWN CODE -----     '
016030041215     c                   endsl
016031040803     C* CLEAR SUBFILE
016032040803     C                   MOVEA     '001'         *IN(40)
016033041215     C                   WRITE     SF01CTL
016034040803     C                   eval      *IN42 = *off
016035040803     C*
016036040803     C* BUILD SUBFILE
016037040803     C*
016038040803     C                   clear                   RRN
016039041215     C     ptype         SETLL     codes
016040041215     C                   dou       %eof(codes)
016041041215     C     ptype         READE     codes                                  41
016042041215     C                   if        not %eof(codes) and cddltd = 'A'
016043041215
016044041215      * reinstate acct not allowed
016045041215     c                   if        type = 'E' and code = 'RA'
016046041215     C                   iter
016047041215     C                   END
016048160621      * Do not show Acct level term codes
016049160621     c                   if        type = 'D' and actn2 = 'A'
016050160621     C                   iter
016051160621     C                   end
016052041215
016053040803     C                   ADD       1             RRN
016054041215     c                   move      code          x1
016055041215     c                   movel     ldescr        x2
016056170510     c                   if        type = 'D'
016057170510     c                   movel     action        x3
016058170510     c                   end
016059040803     C                   WRITE     SF01
016060040803     C                   iter
016061040803     C                   END
016062040803     C                   ENDDO
016063040803
016064040803     C* DISPLAY SUBFILE IN WINDOW
016065040803     C                   if        rrn > 0
016066040803     C                   eval      *in40 = *on
016067040803     C                   END
016068040803     C*
016069041215     C**                 WRITE     savscrn
016070041215     C                   WRITE     WINDOW
016071101221
016072040803     C                   EXFMT     SF01CTL
016073041215
016100041215     c                   eval      *inlr = *on
