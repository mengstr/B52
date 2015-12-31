#B52

##January 1 - 2016
### Finding some contemporary parts
The Z8671 is the oldest of the two MCUs and seems rather easy to use as well.  The BASIC interpreter is fit into only 2K ROM insteat of the 4K that the P8052 is using so it will be a lot more limited in functionality, but that will only add to the authenticity of the time period. ;-)

The Z8 (as the Z8671 is a part of) are using a muxed Data/Address bus for Address[0..7] so a latch is required to capture the lower address. 

Then it also reads the 0xFFFD memory location and uses the three least sigificant bits of the data there to set the baudrate of the serial console port, so I need a three-state buffer to handle that.

And the Address[8..15] bus must be decoded into chip-select signals for the external RAM and the baudrate-buffer.

So I rummages around in more junk boxes looking for old TTL chips that I could use and was able to find all I currrently think I need and they are dated between 1982-1985.  I even found an old used  7.3728 MHz crystal that is required for getting the correct baud rates.

No early 80'es computer can be without cheesy sound effects using something like a AY3-series sound effect generator. Unfortunately I couldn't find an old version of the chip, but I had some that seems to be made in 2006(?) so that have to be an half-anachronistic part in my design.

[![Parts](https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671-parts.jpg =400x)]


##December 30 - 2015
###Intro
While rummanging around in my old junkboxes I found two diffrent ancient MCUs both with a built-in BASIC interpreters.

The first I found was the Intel P8052-BASIC the second was the Zilog Z8671 BASIC/DEBUG. Both was rather popular back in 1983 and a few years onwards.

[![BASIC chips](https://github.com/SmallRoomLabs/B52/raw/master/images/Z8671_P8052-BASIC.jpg =400x)]

Just a few days earlier I saw a tweet about the [Retrochallenge Competition](http://www.wickensonline.co.uk/retrochallenge-2012sc/) so I decided that to join the compatition and build someting with one of the MCUs. 

