000100170623     H DFTACTGRP(*NO)
000200180326     H option(*SRCSTMT: *NODEBUGIO)
000300180326
000400170714      *_________________________________________________________________________
000500170714      *
000600170714      *  Description:  Manual Retirement Reason prompt
000700170714      *
000800170714      *  (c)Copyright 2017 by GBS, Inc.
000900170714      *
001000170714      *    Created by:  JALLEN - July 14, 2017
001100170714      *
001200170714      *  Modifications:
001300170714      *
001400170714      *_________________________________________________________________________
001500000000
001600170623     FDSH002D   CF   E             WorkStn
001700170623     F                                     handler('PROFOUNDUI(HANDLER)')
001800180221     FSLCMRDP   IF a E           K DISK
001900180221     FSLCMRDP2  UF   E           K DISK    prefix(F2)
002000000000
002100180221     D*SLFLAG          s              1a
002200180221     D*CheckBox1       s              1a
002300180221     D*TextBox1        s             30a
002400170621
002500170515     C     *entry        plist
002600170621     C                   parm                    oeretf            1
002700000000
002800000000      /FREE
002900000000
003000170621        // Initialize "named indicators.
003100170622        RETIRE = *Off;
003200170622        GOBACK = *Off;
003300170622        OERETF = *blanks;
003400170621
003500170622        Dow RETIRE = *Off and GOBACK = *Off;
003600170621          ExFmt SFLCTL;
003700170621
003800170621
003900170621       if RETIRE = *ON ;
004000180221       If Checkbox1 <> *blanks and TextBox1 <> *blanks;
004100180221       setll *loval SLCMRDP2 ;
004200180221       read  SLCMRDP2 ;
004300180221       if %found(SLCMRDP2) ;
004400180221       eval SLFLAG = F2SLFLAG;
004500180221       eval  SLDESC = TextBox1;
004600180221       eval  SLSORT = 99;
004700180221       write SLCMRDR;
004800180221       delete F2SLFLAG SLCMRDP2;
004900180221       endif;
005000180221       endif;
005100180221
005200170623       if SLFLAG <> *blanks ;
005300170621        oeretf = SLFLAG ;
005400170623        leave;
005500170623        else ;
005600170623          RETIRE = *OFF;
005700170623          ExFmt WARNING;
005800170623        endif;
005900170623        endif;
006000170621
006100170622       if GOBACK = *ON ;
006200170622        oeretf = *blanks;
006300170623        leave;
006400170622        endif;
006500000000
006600170623        EndDo;
006700170623
006800000000        *InLr = *On;
006900170621        return ;
007000000000
007100000000      /END-FREE
007200000000
