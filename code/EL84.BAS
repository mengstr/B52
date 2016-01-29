10 REM Earth Lander 84 - Rev 0.1
20 REM Copyright (c) 2016 Mats Engstrom mats@smallroomlabs.com
30 REM Licensed under the MIT licence

40 GOSUB 9000
41 GOSUB 8000

100 REM --- GAME IN PROGRESS LOOP
110 KY$=INKEY$
120 IF KY$=" " THEN BURN=0
121 IF KY$="1" THEN BURN=GRAVITY*0.2
122 IF KY$="2" THEN BURN=GRAVITY*0.4
123 IF KY$="3" THEN BURN=GRAVITY*0.6
124 IF KY$="4" THEN BURN=GRAVITY*0.8
125 IF KY$="5" THEN BURN=GRAVITY
126 IF KY$="6" THEN BURN=GRAVITY*1.2
127 IF KY$="7" THEN BURN=GRAVITY*1.4
128 IF KY$="8" THEN BURN=GRAVITY*1.6
129 IF KY$="9" THEN BURN=GRAVITY*1.8
180 FUEL=FUEL-(BURN*10)
190 IF FUEL<=0 THEN FUEL=0:BURN=0
195 DELTA=(GRAVITY-BURN)/10
200 DESCENT=DESCENT+DELTA
210 CALTI=CALTI-(DESCENT/10)
220 IF CALTI<0 THEN CALTI=0:DESCENT=0: BURN=0
230 IF CALTI>9999 THEN CALTI=9999: BURN=0
900 GOSUB 8100
910 GOSUB 9500
920 GOTO 100

8000 REM --- REDRAW FULL SCREEN
8010 CLS
8020 LOCATE 1,24: PRINT STRING$(31,"=")
8021 LOCATE 2,26: PRINT "E A R T H  L A N D E R  8 4"
8022 LOCATE 3,24: PRINT STRING$(31,"=")
8030 LOCATE 5,15: PRINT "Remaining fuel                         Score"
8031 LOCATE 6,15: PRINT "+-------------+                   +-------------+"
8032 LOCATE 7,15: PRINT "|             |                   |             |"
8033 LOCATE 8,15: PRINT "+-------------+                   +-------------+"
8034 LOCATE 10,15: PRINT "  Ship angle                         Wind speed"
8035 LOCATE 11,15: PRINT "+-------------+                   +-------------+"
8036 LOCATE 12,15: PRINT "|             |                   |             |"
8037 LOCATE 13,15: PRINT "+-------------+                   +-------------+"
8038 LOCATE 15,15: PRINT " Ground speed        Latitude     Target latitude"
8039 LOCATE 16,15: PRINT "+-------------+  +-------------+  +-------------+"
8040 LOCATE 17,15: PRINT "|             |  |             |  |             |"
8041 LOCATE 18,15: PRINT "+-------------+  +-------------+  +-------------+"
8042 LOCATE 20,15: PRINT " Descent rate        Altitude     Target altitude"
8043 LOCATE 21,15: PRINT "+-------------+  +-------------+  +-------------+"
8044 LOCATE 22,15: PRINT "|             |  |             |  |             |"
8045 LOCATE 23,15: PRINT "+-------------+  +-------------+  +-------------+"

8100 REM --- REDRAW NUMBERS
8110 LOCATE 7,20: PRINT USING "####";FUEL;
8111 LOCATE 7,54: PRINT USING "####";SCORE;
8112 LOCATE 12,20: PRINT USING "###.#";ANGLE;
8113 LOCATE 12,54: PRINT USING "###.#";WIND;
8114 LOCATE 17,20: PRINT USING "###.#";GSPEED;
8115 LOCATE 17,37: PRINT USING "####";CLAT;
8116 LOCATE 17,54: PRINT USING "####";TLAT;
8117 LOCATE 22,20: PRINT USING "###.#";DESCENT;
8118 LOCATE 22,37: PRINT USING "####";CALTI
8119 LOCATE 22,54: PRINT USING "####";TALTI;
8999 RETURN

9000 REM --- INIT ALL VARIABLES
9030 FUEL=9999
9040 WIND=0
9050 ANGLE=0
9060 GSPEED=0
9070 CLAT=500
9080 TLAT=500
9090 DESCENT=0
9100 CALTI=1500
9110 TALTI=0
9120 SCORE=0
9130 BURN=0
9140 GRAVITY=1
9199 RETURN

9500 REM --- WAIT UNTIL NEXT TICK
9510 IF TIMER= LASTTIMER GOTO 9510
9520 LASTTIMER=TIMER
9530 RETURN 
