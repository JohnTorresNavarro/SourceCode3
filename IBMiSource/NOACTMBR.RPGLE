000001030813      ******************************************************************
000002030813      *                                                                *
000003030813      *  NOACTMBR        GROUP BENEFIT SERVICES              2003      *
000004030813      *                                                                *
000005030813      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000006030813      *            DATE - 08/13/2003                                   *
000007030813      *                                                                *
000008030813      *  DESCRIPTION - THIS PROGRAM CREATES A LISTING OF               *
000009030813      *                ACTIVE ACCOUNTS WITH MARYLAND CONTINUATION      *
000010030813      *                (FCSTFL = 'S') AND NO ACTIVE MEMBERS            *
000011030813      *                IN MARYLAND                                     *
000012030813      *                                                                *
000013030813      ******************************************************************
000100030813     FACCMST    IF   E           K DISK
000101030813     FMEMAC#    IF   E           K DISK
000102030813     FNOACTP    O    E             PRINTER OFLIND(*IN80)
000600990709
000601030813     D FOUND           S              1
000602030813
000603030813     C     ACCKEY        KLIST
000604030813     C                   KFLD                    ACTRST
000605030813     C                   KFLD                    ACSUB#
000606030813     C                   KFLD                    ACACCT
000607030813
000608030813     C                   EVAL      *IN80 = *ON
001100021212     C                   READ      ACCMSR                                 99
001200990709     C                   DOW       *IN99 = *OFF
001201030813     C                   IF        ATRMDT = *ZEROS AND FCSTFL = 'S'
001203030813     C
001205030813     C     ACCKEY        SETLL     MEMBR
001206030813     C     ACCKEY        READE     MEMBR                                  98
001207030813     C                   DOW       *IN98 = *OFF
001208030813     C                   IF        STATE = 'MD'
001209030813     C                   IF        TERMDT = *ZEROS
001210030813     C                   EVAL      FOUND = 'Y'
001211030813     C                   LEAVE
001212030813     C                   ELSE
001213030813     C                   EVAL      FOUND = 'N'
001214030813     C                   ENDIF
001215030813     C                   ENDIF
001216030813     C
001217030813     C     ACCKEY        READE     MEMBR                                  98
001218030813     C                   ENDDO
001219030813     C
001220030813     C                   IF        FOUND = 'N'
001221030813     C                   IF        *IN80 = *ON
001222030813     C                   WRITE     HDR1
001223030813     C                   EVAL      *IN80 = *OFF
001224030813     C                   ENDIF
001225030813     C                   EVAL      TRST1 = ACTRST
001226030813     C                   EVAL      SUB#1 = ACSUB#
001227030813     C                   EVAL      ACCT1 = ACACCT
001228030813     C                   EVAL      ACCTNAM = ACNAM1
001229030813     C                   WRITE     DTL1
001230030813     C                   EVAL      CNT1 = CNT1 + 1
001231030813     C                   CLEAR                   DTL1
001232030813     C                   ENDIF
001233030813     C
001234030813     C                   EVAL      FOUND = ' '
001235030813     C                   ENDIF
001236030813     C
001237030813     C                   READ      ACCMSR                                 99
001930000531     C                   ENDDO
001931030813     C                   WRITE     TOT1
001932000531
002000990709     C                   EVAL      *INLR = *ON
