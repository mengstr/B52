#BASIC-MCU-GAME

__This is the blog and repo for my entry in the [Retrochallenge Competition](http://www.wickensonline.co.uk/retrochallenge-2012sc/). I will design, build and write a game for an old MCU with a built-in BASIC interpreter.__

##Index

1. [Intro](#Intro)
2. [Finding some contemporary parts](#Finding-some-contemporary-parts)
3. [Hacking into a Dallas NVRAM](#Hacking-into-a-Dallas-NVRAM)
4. [Bare Z8671 is alive](#Bare-Z8671-is-alive)
5. [Soldering perfboard 1](#Soldering-perfboard-1)


##January 6 - 2016 
### Soldering perfboard 1

Today I took a perfboard and soldered up power and the data/address busses of the MCU, SRAM, NVRAM and the address bus latch.

I did't really care about the exact order of the bits when wiring them up, I just went for the easiest layout.  I'm not really sure why the manufacturers even care about designating the D0..D7 on a SRAM, the order is irrelevant as long as you don't move the chip to another system with live data on it. Same thing with the address bus.  On a (EE)PROM it's required to carefully keep track of the A's and D's of course.

This is how the layout and connections ended up:


`  Z8671                                                    HEADER
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
`

##January 2 - 2016

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
 

##January 1 - 2016
### Finding some contemporary parts
The Z8671 is the oldest of the two MCUs and seems rather easy to use as well. The BASIC interpreter is fit into only 2K ROM instead of the 4K that the P8052 is using so it will be a lot more limited in functionality, but that will only add to the authenticity of the time period. ;-)

The Z8 (as the Z8671 is a part of) are using a muxed Data/Address bus for Address[0..7] so a latch is required to capture the lower address.

Then it also reads the 0xFFFD memory location and uses the three least significant bits of the data there to set the baudrate of the serial console port, so I need a three-state buffer to handle that.
And the Address[8..15] bus must be decoded into chip-select signals for the external RAM and the baudrate-buffer.

So I rummaged around in more junk boxes looking for old TTL chips that I could use and was able to find all I currently think I need and they are dated between 1982-1984. I even found an old used 7.3728 MHz crystal that is required for getting the correct baud rates.

No early 80'es computer can be without cheesy sound effects using something like a AY3-series sound effect generator. Unfortunately I couldn't find an old version of the chip, but I had some that seems to be made in 2006(?) so that have to be an half-anachronistic part in my design.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671-parts.jpg width=400 />


##December 30 - 2015
###Intro
While rummaging around in my old junkboxes I found two different ancient MCUs both with a built-in BASIC interpreters.

The first I found was the Intel P8052-BASIC the second was the Zilog Z8671 BASIC/DEBUG. Both was rather popular back in 1983 and a few years onwards.

<img src=https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671_P8052-BASIC.jpg width=400 />


Just a few days earlier I saw a tweet about the [Retrochallenge Competition](http://www.wickensonline.co.uk/retrochallenge-2012sc/) so I decided that to join the compatition and build someting with one of the MCUs. 


