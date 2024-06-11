0002009102150002 F******************************************************************
0003001606010003 F* PASS2      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009102150004 F*                                                                *
0006011606010005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006021606010006 F*            DATE - 06/01/16                                     *
0007009102150007 F*                                                                *
0008001606010008 F*  DESCRIPTION - THIS PROGRAM WILL VALIDATE THE PASSWORD ENTERED *
0010001606010010 F*                IT WILL BE CALLED FROM THE NEW PASS OCL SINCE   *
0010011606010010 F*                THERE ARE 37 PROGRAMS THAT CURRENTLY USE THE    *
0010021606010010 F*                PASS OCL.                                       *
0010031606010010 F*                                                                *
0010041606010010 F*                                                                *
0016009102150011 F******************************************************************
0017009102150012 F*                                                                *
0018001606010013 Fpass2d    Cf   e             WORKSTN
0019011606010015 Fpassmst   iF   E           K DISK
001902160602      ******************************************************************
001903160602      **** DO NOT CHANGE THIS KEY ***
001904160601     d key             s             20    inz('qTbiDL9@.iD-P#bU\Wj}')
001905160602      ******************************************************************
001906160601     d cryptin         s             20
001907160601     d cryptout        s             20
001908160602     d msg1            s             60    inz('Password entered does not -
001909160602     d                                     match, please try again')
0033011606010054 D                UDS
0033081606020060 D  LOK                  200    200
0033101606020054 D  CONAME               201    240
003311160602
003402160602     c                   clear                   lok
003409160601     C     parmcode      CHAIN     passmst
003410160602      * if not found or not active, skip password check
003412160602     c                   if        not %found(passmst) or pastat <> 'A'
003414160602     c                   eval      lok = 'X'
003415160602     c                   goto      #end
003416160602     c                   end
003417160602
003418160602      * decrypt pw from file
003419160602     c                   movel     pavalue       cryptin
003420160602     c                   exsr      #crypt
003421160601      * ask for password
003422160602     c                   dou       *in07 = *on
003425160601     C                   EXFMT     SCRN01
003426160602     c                   eval      *in50 = *off
003427160602     c                   clear                   msg
003428160602      * if user entered valid pw, allow access
003429160601     c                   if        password = cryptout
003430160602     c                   eval      lok = 'X'
003431160602     c                   leave
003432160602     c                   else
003433160602     c                   eval      msg = msg1
003434160602     c                   eval      *in50 = *on
003435160602     c                   clear                   password
003436160602     c                   end
003437160602     c                   enddo
003438160601
003439160601
003440160602     c     #end          tag
003441160601     c                   eval      *inlr = *on
003442160601
003443160601     C************************************
003444160601     C* encrypt / decrypt
003445160601     C************************************
003446160601       begsr #crypt;
003447160601       clear cryptout;
003448160601       cryptout = %bitxor(cryptin: key);
003449160601       endsr;
003450160601
003500160601     C     PLIST         Begsr
003600160601     C     *ENTRY        Plist
003700160601     C                   Parm                    parmcode          1
003900160601     C                   Endsr
