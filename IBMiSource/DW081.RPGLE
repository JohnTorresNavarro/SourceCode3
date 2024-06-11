000100990111      *------------------------------------------------------------------------------------------*
000200191008      * dw081      GROUP BENEFIT SERVICES SOFTWARE                                               *
000201121004      *                                                                                          *
000500191008      *  DESCRIPTION - check for programs being used that are not allowed                        *
000700191009      *                during an invoice or bill file lockout. These are                         *
000701191009      *                controlled by the CHKABRCL program that prevents                          *
000702191009      *                new access but does not end those currently in                            *
000703191009      *                a restricted option.                                                      *
000704191009      *                This program will need to be updated if CHKABRCL                          *
000705191009      *                is added to additional programs.                                          *
000706191009      * 10/08/19 dlk - initial version created to help identify people                           *
000714191009      *                still using restricted options prior to the invoice                       *
000715191009      *                run but this same option can also be used for the                         *
000716191009      *                bill file lockout.                                                        *
000717191010      * 10/10/19 dlk - add notification option                                                   *
000718191009      *                                                                                          *
000900981030      *------------------------------------------------------------------------------------------*
0009011910080013 Fdw081d    CF   E             WORKSTN
000902191008     F                                     SFILE(SF01:RRN)
001001191008     Fdw081p    If   E             DISK
001002191009     Fgbsecure  If   E           k DISK
001011170118
001014191008     D x               S              2  0
001015191008     D pos             S              2  0
001017191008     D found           S              1
001018191009     D wpgm            S             14    DIM(18) CTDATA PERRCD(1)
001019191009     D wpgmdesc        S             30    DIM(18) ALT(wpgm)
001020191010     D*CMD             S            300A   INZ(*BLANKS)
001021191010     D msg             S            400A   INZ(*BLANKS)
001022191010     D*LENGTH          S             15P 5 INZ(0)
001023191010     D*#LEN            S              3P 0 INZ(0)
001024121004
001025191010      * only display once since this program will need to be restarted to
001026191010      * refresh the input file dw081p
0010271910080080 C                   EXSR      #DSPpgm
001029191010
001030191008     c                   eval      *inlr = *on
001031191008
001057191009     C*********************************************************
001058191009     C* DISPLAY active restricted programs in SUBFILE WINDOW  *
001059191009     C*********************************************************
001061191008     C     #DSPpgm       BEGSR
001062191008     C*
001063191008     C* CLEAR SUBFILE
001064191008     C*
001065191008     C                   MOVEA     '001'         *IN(90)
001066191008     C                   WRITE     SF01CTL
001067191008     C                   MOVE      '0'           *IN92
001068191008     C*
001069191008     C* BUILD SUBFILE
001070191008     C*
001071191008     C                   clear                   RRN               5 0
001087191008     C                   dou       %eof(dw081p)
001088191008     C                   READ      dw081p                                 91
001089191008     C                   if        *in91 = *off and wafnct <> *blanks
001091191008     c                   exsr      #chkfnct
001092191008     c                   if        found = 'Y'
001093191008     C                   ADD       1             RRN
001094191009      * get user name
001095191009     c     wausr         chain     gbsecure
001096191009     c                   if        %found(gbsecure)
001097191009     c                   movel     scname        sfuname
001098191011     c                   movel     scname        sfuname40
001099191009     c                   else
001100191009     c                   clear                   sfuname
001101191011     c                   clear                   sfuname40
001102191009     c                   end
001103191009
001104191008     c                   move      wausr         sfuser
001105191008     c                   move      wafnct        sfpgm
001106191008     c                   movea     wpgmdesc(x)   sfdesc
001107191008     C                   WRITE     SF01
001108191008     C                   END
001109191008
001110191008     C                   END
001111191008     C                   enddo
001112191008     C*
001113191008     C* DISPLAY SUBFILE IN WINDOW
001114191008     C* if no rec found, display not found msg
001115191008     C                   if        rrn = 0
001116191008     c                   clear                   sf01
001117191008     c                   eval      sfpgm     = '* NONE FOUND *'
001118191008     c                   add       1             rrn
001119191008     c                   write     sf01
001120191008     C                   end
001121191008
001122191008     C                   eval      *in90 = *on
001123191008     C*
001124191008     C                   WRITE     WINDOW
001125191008     C                   EXFMT     SF01CTL
001126191010
001127191010     c* if F2 pressed, notify all users selected
001129191010     c                   if        *in02
001130191010     c                   dow       not %eof(dw081d)
001131191010     c                   readc     sf01
001132191010     c                   if        not %eof(dw081d) and sfsel <> *blank
001133191010      * notifty using puisndmsg
001134191010     c                   exsr      #notify
001139191010     c                   end
001143191010     c                   enddo
001149191010     c                   end
001150191010
001151191008     C                   ENDSR
001152191008
001153191008     C*************************************************************
001154191010     C* Notify user
001155191008     C*************************************************************
001156191010       begsr #notify;
001157191010       msg = 'Please exit the ' + %trim(sfdesc) + ' application now! +
001158191010       A monthly process is about to begin that restricts you to +
001159191010       inquiry functions only. Thank you.';
001160191010
001161191010      *CMD = 'PUISNDMSG USERID(' + %trim(sfuser) + ') MESSAGE(' +
001162191010      *      %trim(msg) + ')';
001163191010     C*                  EVAL      #LEN = %LEN(%TRIM(CMD))
001164191010     C*                  Z-ADD     #LEN          LENGTH
001165191010     C*                  CALL      'QCMDEXC'
001166191010     C*                  PARM                    CMD
001167191010     C*                  PARM                    LENGTH
001168191010      * use CL instead
001169191010
001170191010     C                   CALL      'DW082CL'
001171191010     C                   PARM                    sfuser
001172191011     C                   PARM                    sfuname40
001173191011     C                   PARM                    sfdesc
001174191010     C                   PARM                    msg
001175191010
001176191010       endsr;
001177191010
001178191010     C*************************************************************
001179191010     C* check function to see if it is a program on the list
001180191010     C*************************************************************
001181191010       begsr #chkfnct;
001182191008       clear found;
001183191008       x=1;
001184191009       dow wpgm(x) <> '***END***';
001185191008        Pos = %scan(%trim(wpgm(x)):wafnct);
001186191008
001187191008      * match found
001188191008        if Pos <> 0;
001189191008        found = 'Y';
001190191008        leave;
001191191008        endif;
001192191008
001193191008       x=x+1;
001194191008       enddo;
001195191008
001196191008       endsr;
001197191008
001198191008**
001200191008PGM-DW21      Payment Download
001201191010PGM-FM04      Rate Maintenance
001300191008PGM-FM06      Account Maintenance
001400191008PGM-FM07      Member Enrollment
001500191008PGM-FM41      Smoke File Maintenance
001501191009PGM-TR01      Account Invoice
001502191009PGM-TR02      Account Invoice
001600191008PGM-TR04      Account Adjustments
001700191008PGM-TR05      Plan Change
001800191008PGM-TR07      Account Cancellation
001900191008PGM-TR10      Account Transfer
002000191008PGM-TR11      Account Reinstate
002001191009PGM-TR13      COBRA Invoice
002002191009PGM-TR14      COBRA Invoice
002003191009PGM-TR16      COBRA Adjustment & Void Inv
002100191008PGM-TR19      Account Void Invoice
002200191008PGM-UTL17     Mass Plan Add
002300191009***END***
