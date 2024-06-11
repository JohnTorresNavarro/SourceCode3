0001000210160015  ******************************************************************
000200160608      * dw302          Group Benefit Services, Inc.                    *
000300021016      *                                                                *
000400021016      *    WRITTEN BY - DAVID KETTERMAN                                *
000500160608      *    DATE       - 06/08/16                                       *
000600021016      *                                                                *
000700160608      * This program will read the dw300j join file and add the group #*
0009001606080015  * so dw300 can then read it with the group #.                    *
0009011606080015  *                                                                *
0034051605130015  *                                                                *
0035000210160015  ******************************************************************
0036001606100017 Fdw300j    up   E             DISK
0042000502160016 fgrate     IF   E           K DISK
0085000212030055 D                UDS
0086000212030056 D  LEFFDT                85     92  0
009600050419
017200050328     c                   exsr      #getgrp
017201160610     c                   update    dw300r
017300050328
0283000211120069 C**************************************************************
028400021112JGE01C*   get group # from grate                                   *
0285000211120069 C**************************************************************
028600021112JGE01C     #getgrp       BEGSR
029300060127
029301160608     c                   clear                   dw3group#
029302160608
029400021112     c     grkey         setll     grate
029500021112     c                   dou       %eof(grate)
029600021112     c     grkey         reade     grate
029700021113     c                   if        not %eof(grate) and (lefymd >= frmdat) and
029800021113     C                             (lefymd <= todat)
029900160608     c                   movel     group#        dw3group#
030100021112     c                   leave
030200021112     c                   end
030300021112     c                   enddo
030400021112
030500021112JGE01C                   ENDSR
030501160608JGE01C*****************************************************
030502160608JGE01C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY or      *
030503160608JGE01C*                 FROM mmddyyyy TO yyyymmdd         *
030504160608JGE01C*****************************************************
030505160608JGE01C     #DAT          BEGSR
030506160608JGE01C                   MOVE      @DATIN        @MD               4 0
030507160608JGE01C                   MOVEL     @DATIN        @Y                4 0
030508160608JGE01C                   MOVEL     @MD           @DATOU            8 0
030509160608JGE01C                   MOVE      @Y            @DATOU
030510160608JGE01C                   MOVE      *ZEROS        @DATIN            8 0
030511160608JGE01C                   ENDSR
030512160608
0483000211110069 C**************************************************************
0484000211110069 C* first time                                                 *
0485000211110069 C**************************************************************
048600021111     c     *inzsr        begsr
0500000211110111 C*
050100021111     C                   MOVE      LEFFDT        @DATIN
050200021111     C                   EXSR      #DAT
050300021111     C                   MOVE      @DATOU        LEFYMD            8 0
052500021112
052600021112     C     grkey         KLIST
052700021112     C                   KFLD                    mctrst
052800021112     C                   KFLD                    mcsub#
052900021112     C                   KFLD                    mcplan
053000021112     C                   KFLD                    mcageb
053100021112     C                   KFLD                    mcovtp
056000021111     c                   endsr
