#BASIC-MCU-GAME

__This is the blog and repo for my entry in the [Retrochallenge Competition](http://www.wickensonline.co.uk/retrochallenge-2012sc/). I will design, build and write a game for an old MCU with a built-in BASIC interpreter.__

##Index

1. [Intro](#Intro)
2. [Finding some contemporary parts](#Finding-some-contemporary-parts)
3. [Hacking into a Dallas NVRAM](#Hacking-into-a-Dallas-NVRAM)
4. [Bare Z8671 is alive](#Bare-Z8671-is-alive)
5. [Soldering perfboard 1](#Soldering-perfboard-1)
6. [The game](#The-game)
7. [Game test](#Game-test-in-PBASIC)
8. [Soldering displays](#Soldering displays)
9. [Bending acrylic](#Bending-acrylic)
10. [Console layout](#Console-layout)
11. [Consoleworks](#Consoleworks)
12. [Console is done](#Console-is-done)
13. [Finalised PCB](#Finalised-PCB)

##January 31

### Finalised PCB
All parts of the PCB is wired up and all connections are buzzed out to test for shorts and bad connections.

Going from left to right on the PCB there are a screw terminal for 5 volts and a power-on LED and above that the reset button and its support circuity (including a very colorful red/yellow 1980's-era capacitor).

Then a standard FTDI-style pin header for TTL-level serial comms. The Z8671 supports using baud rates from 110 baud up to 19200.

A 74LS138 for address decoding, followed by the Z8671 MCU itself and a 8 kilobyte SRAM and the DALLAS DS1235 Non-volatile SRAM with a internal backup battery. The battery is by long dead but I dug out the innards and was able to hook up wires for attaching an external battery to it - which currently is not mounted on the PCB.

Finally the 74LS373 Address-latch that splits up the lower 8 address bits from the combined Adress/Data-bus the Z8671 is using as a pin-saving feature.  Without that feature 16 pins for address and 8 pins for data (=24 pins) would be required on the 40-pin chip. Now "only" 16 is used leaving more pins for I/O.

The three resistors at the far end are for forcing the lower bits of the data bus to 010. This is used by the initialisation routines of the Z8671 to determine the desired baud rate. 010 gives 9600 baud. Actually this is an ugly hack since the Z8671 is really reading the address 0xFFFD to get the baud rate, and to properly handle that I'd need a lot of address decoding and also a three-state buffer. So this is easier - whenever an unused address is read the data buss will just be floating and these three resistors will gently pull the bits to the desired state.
  
<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/PCB2.jpg width=500 />


### Console is done
Attaching the displays to the console was not easy. My first plan was to just use a hot glue gun, but that turned out to be not so good since the "chrome" spray paint has a rather loose surface so the glue  is just ripping off the top layer of the paint as soon as some force is applied to it. And the blue didn't stick particularly well to the plastic of the displays either.

So after hotsnotting them into place I used a liberal amount of silicon sealant all over the place.  I hope that if I'm careful enough when handling the panel the displays will stay there.

This is what the front of the console looks like.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/FullControlPanel.jpg width=500 />


##January 30
### Consoleworks
I attached the transparency to the acrylics using spray glue.  It was a hard to fit it at the first try and it ended up slightly crooked, but not too bad. The glue did make the unpainted "windows" for the displays slightly cloudy but that have to do  for the time being. If I make another panel like this I need to come up with an easier solution.

For the thruster control I needed a potentiometer with a lever mounted in 90-degree angle to the pot axis. I simply drilled a hole straight through it and attached a spare Dremel spindle to it. Problem solved.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/PotAxis90.jpg width=500 />

The pot what then epoxied to a piece of scrap PCB that is securely held to the acrylic by two of the push buttons.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/ControlsBack.jpg width=500 />

For the thruster handle I used a piece of a "touchscreen pen" that I glued to the end of the Dremel rod.  All in all I think it looks fully acceptable for something done without any proper equipment.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/ControlsFront.jpg width=500 />

 
##January 29
### Console layout
I printed the layout of the panel onto transparent film and covered the areas for the displays with sticky tape on the backside of the film.  Then I spray painted the back with "chrome" paint.  It ended up more silver grey than a shiny chrome. It also "developed" my fingerprints that I got on the transparency so there are ugly dark tarnished areas on it. Not so nice, but I'll keep it anyways.

The transparency also got slightly wrinkled after being laser printed, I hope that it will not be a problem when I glue it to the acrylic.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/BackAfterSpraying.jpg width=500 />
<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/FrontAfterSpraying.jpg width=500 />


##January 28
### Bending acrylic
I need a nice retro looking console to mount the displays on. So I took a A4-sized piece of acrylics and bent it using a small blowtorch.  It was the first time I've evert tried bending acrylics and it was rather easy.  I think it turned out quite well if I'm allowed to say that myself. ^_^

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/BentAcrylics.jpg width=500 />


### Soldering displays
I spent feeling the deadline rapidly approaching I spend a couple of hours soldering up all the required displays. I need 10 displays each made out of a pair of 2-digit displays that I found in a bag I bought from Electronic Goldmine about 15 years ago.

I epoxied the displays together in pairs and then sat them up on my desk on a long line so I could easily wire them up with 0.2mm insulated wire point-to-point style.  The insulation on the wire is quite easily solderable using a soldering iron set to 400C instead of my usual 290C.  After the soldering I just cut the sites between the modules as required.

The shift registers and the resistors was just tacked onto the displays in dead bug style. Really ugly but it got the job done.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/DisplaysBeingSoldered.jpg width=500 />

The 4-digit modules are driven by a HC595 shift register with 82 ohm resistors connected to the cathodes. So each module have 4 Anodes, VCC/GND and DataIn/Clock/Latch/DataOut that needs to be hooked to to the other modules.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/SolderedDisplays.jpg width=500 />

The GND wire is a bit thicker that the rest of the wiring since it needs to carry quite a lot of current in total.


##January 20
### Game test in PBASIC
I've been very busy with work and an upcoming overseas move so unfortunately the work on my #RetroChallenge entry has been mostly neglected.

But for some basic (pun intended) testing of the game logic I hacked up a quick test in PC-BASIC. If is an excellent open source implementation of the classic GW-BASIC from back in the good old days. For more info and download of the PC-BASIC go to [robhagemans.github.io/pcbasic](https://robhagemans.github.io/pcbasic/)

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/GameInPcBASIC.png width=500 />


##January 7
### The game

I've been thinking for a bit of some games that could be suitable for a rather limited system like this.  Any video graphics is out of the questions except for a something like a matrix of 16x32 LEDS as a playing field for a Pong- or Breakout-like game.  Hooking up a VT100 terminal to it I could make an 80's text adventure game or something like "Hunt the Wumpus" or, as another contestant already does, port the StarTrek game to it.

But I wanted to have this a self-contained unit with no PC or terminal required, so I came up with a variant of the Lunar Lander game but without the graphics part. Normally on lunar lander the current data of the ship like Descent Rate and Remaining Fuel is shown in numbers on the screen together with the graphics of the ship and the lunar surface.  I use four-digit 7-segment displays for all the flight data required to safely navigate and land the ship.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/EarthLander-Console1.jpg width=500 />

I plan to take a A4-sheet sized piece of acrylics and bend the bottom 1/4-part of it so it ends up like a console where I can have the displays on the top part and the game controls on the lower (horizontal) part. Something like this...

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/ConsoleExample.jpg />

Having analog gauges like on this image would be even cooler!  Maybe for revision two of the game, but for the time being I'll stick to digital readouts.

##January 6  
### Soldering perfboard 1

Today I took a perfboard and soldered up power and the data/address busses of the MCU, SRAM, NVRAM and the address bus latch.

I did't really care about the exact order of the bits when wiring them up, I just went for the easiest layout.  I'm not really sure why the manufacturers even care about designating the D0..D7 on a SRAM, the order is irrelevant as long as you don't move the chip to another system with live data on it. Same thing with the address bus.  On a (EE)PROM it's required to carefully keep track of the A's and D's of course.

This is how the layout and connections ended up:


    Z8671                                                      HEADER
    ---------                                                 --------
    VCC   P36                                                         
    X2    P31                                                    RW
    X1    P27                                                    /E
    TX    P26                                                    a7
    RX    P25         6264          DS1235                       a6    
    /RES  P24        -------       ---------                     a5    
    R/W   P23        NC  VCC        A   VCC                      a4    
    /DS   P22        A   /WE        A   /WE                      a3    
    /AS   P21        A   CS2        A     A         LS373        a2    
    P35   P20        A     A        A     A        -------       a1    
    GND   P33        A    a6        A    a6        /OE VCC       a0    
    P32   P34        a4   a7        a4   a7        a7   a6       d7    
    A8     d7        a5  /OE        a5  /OE        d7   d6       d6    
    A9     d6        a3   a2        a3   a2        d5   d4       d5    
    A10    d5        a0 /CS1        a0  /CE        a5   a4       d4    
    A11    d4        a1   d7        a1   d7        a3   a2       d3    
    A12    d3        d5   d6        d5   d6        d3   d2       d2    
    A13    d2        d3   d4        d3   d4        d1   d0       d1    
    A14    d1        d1   d2        d1   d2        a1   a0       d0    
    A15    d0        GND  d0        GND  d0        GND  LE      GND
    
<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/PCB1.jpg width=800 />


##January 2 

### Bare Z8671 is alive
I didn't know if the processor was still working after all this time on a disintegrating piece of antistatic foam so I wired up the simplest possible test circuit on a solderless breadboard.

Just the CPU plus a 100nF cap and the crystal with its 20pF load caps is required. And three 1K resistors that pulls up the lower three bits of data bus to force the baudrate to be set to 300 baud.

It's hooked up to a Adafruit FTDI adapter which also supplies the 5 volts power for it.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671-Test1.jpg width=800 />

Seems like it works rather well as can be seen on the terminal above. It complains about a syntax error at line 24950, but I guess that is because the BASIC firmware gets confused when databus is flowing while it probing the memory ranges. At least I hope it is so or else the BASIC ROM has succumbed to bitrot over the years. :-(

### Hacking into a Dallas NVRAM
Since my EPROM burner is so old it connect via a parallel port I needed to find another solution for that.  I found an old but never used Dallas DS1235 32Kx8 NVRAM module that I got in a goodie bag  at some electronics seminar I attended way back in the past.

It's dated 1988 and looking at the data sheet the internal battery should last at least 10 years. Considering it's almost 20 years past the expiry date I wanted to make sure that the batteries wasn't dead.

The module consists of a SRAM with a DS1210 Nonvolatile Controller Chip and two lithium batteries potted in epoxy.

Luckily the top of the DS1210 was exposed at the bottom so it was rather easy to just use a hot soldering iron to scrape off the epoxy layer by layer to get down to the legs of the DS1210 so I could measure the voltages of VBAT1 and VBAT2.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/DS1235.jpg width=800 />

It was dead...  VBAT1 had just a few millivolts and VBAT2 had fared batter and was at 250mV.

I will dig out some more of the epoxy so I can cut one of the battery leads and attach an external battery to keep the module alive without VCC.  

I'm not sure if I can use a single 3 volt coin cell battery and expect the SRAM to be within data retention limits since the DS1210 have a voltage drop of up to 0.3 volts.  But the maximum voltage of VBAT1/2 on the DS1210 is 4.0 volts so I can't just series two coin cells.

So I have three choices. Either run it on a single standard 3v cell, get a 3.6 volt Li-ion coin cell or series two 3 volt cells and then hook it up with some diodes to drop off the extra voltage. But at nano amps the Vf of a diode is not much so I'd need a lot of them. Maybe I can use a LED instead....
 

##January 1 
### Finding some contemporary parts
The Z8671 is the oldest of the two MCUs and seems rather easy to use as well. The BASIC interpreter is fit into only 2K ROM instead of the 4K that the P8052 is using so it will be a lot more limited in functionality, but that will only add to the authenticity of the time period. ;-)

The Z8 (as the Z8671 is a part of) are using a muxed Data/Address bus for Address[0..7] so a latch is required to capture the lower address.

Then it also reads the 0xFFFD memory location and uses the three least significant bits of the data there to set the baudrate of the serial console port, so I need a three-state buffer to handle that.
And the Address[8..15] bus must be decoded into chip-select signals for the external RAM and the baudrate-buffer.

So I rummaged around in more junk boxes looking for old TTL chips that I could use and was able to find all I currently think I need and they are dated between 1982-1984. I even found an old used 7.3728 MHz crystal that is required for getting the correct baud rates.

No early 80'es computer can be without cheesy sound effects using something like a AY3-series sound effect generator. Unfortunately I couldn't find an old version of the chip, but I had some that seems to be made in 2006(?) so that have to be an half-anachronistic part in my design.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671-parts.jpg width=400 />


##December 30 
###Intro
While rummaging around in my old junkboxes I found two different ancient MCUs both with a built-in BASIC interpreters.

The first I found was the Intel P8052-BASIC the second was the Zilog Z8671 BASIC/DEBUG. Both was rather popular back in 1983 and a few years onwards.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671_P8052-BASIC.jpg width=400 />


Just a few days earlier I saw a tweet about the [Retrochallenge Competition](http://www.wickensonline.co.uk/retrochallenge-2012sc/) so I decided that to join the compatition and build someting with one of the MCUs. 


