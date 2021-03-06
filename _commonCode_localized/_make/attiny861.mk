#/* mehPL:
# *    This is Open Source, but NOT GPL. I call it mehPL.
# *    I'm not too fond of long licenses at the top of the file.
# *    Please see the bottom.
# *    Enjoy!
# */
#
#
# Sample makefile 
# original by Eric B. Weddington, et al. for WinAVR
# modified for _common "libraries" and other goodies by Eric Hungerford
#
# Maybe someday to be released to the Public Domain
# Please read the make user manual!
#
#
# On command line:
# make = Make software.
# make clean = Clean out built project files.
#
# To rebuild project do "make clean" then "make".
#


# APPARENTLY ORDER-WRITTEN MATTERS
# (old message from another chip...)
# HOWEVER: writing FUSEX does not seem to work... 
# Keeps returning 0x01 which isn't even possible...
# Since the default value is 0xff
# However, all bits except bit0 are unused
# and the default value is fine.
#FUSEX = 0xff
FUSE_NEWCHIP_WARN = TRUE
ifndef FUSEH
FUSEH = 0xdf
endif
# ifndef because FUSEL = 0xe1 -> 16MHz via PLL (why not default this?)
ifndef FUSEL
FUSEL = 0xe2
endif
# Fuses:
# 1 = not-programmed (disabled)

# Fuse extended byte:
# 0xff = 1 1 1 1   1 1 1 1 <-- SELFPRGEN
#        \____unused___/

# Fuse high byte:
# 0xdf = 1 1 0 1   1 1 1 1 <-- BODLEVEL2
#        ^ ^ ^ ^   ^ ^ ^------ BODLEVEL1
#        | | | |   | +-------- BODLEVEL0
#        | | | |   + --------- EESAVE
#        | | | +-------------- WDTON
#        | | +---------------- SPIEN
#        | +------------------ DWEN
#        +-------------------- RSTDISBL

# Fuse low byte:
#        0 1 1 0   0 0 1 0 = DEFAULT (8Mhz internal RC oscillator / 8)
# 0xe2 = 1 1 1 0   0 0 1 0
#        ^ ^ \ /   \--+--/
#        | |  |       +------- CKSEL 3..0 (external clock NOT selected)
#        | |  |                   0001 -> 16MHz via PLL
#        | |  +--------------- SUT 1..0 (max start-up time)
#        | +------------------ CKOUT
#        +-------------------- CKDIV8 (Don't divide)



# My programming-header and its muxed defaults:
# (Your pin-numbers may vary)
#
#             Pin Name         Default Use
# 1 GND
# 2 V+
# 3 SCK       PB2              Rx0 (polled_uar)
# 4 MOSI      PB0              Tx0 (polled_uat)
# 5 /RST
# 6 MISO      PB1              HEARTBEAT


# THIS IS NYI
#These can be overridden in your project's makefile...
# (And, if your project doesn't have puar/t or heartbeat, these don't
#  matter)

# E.G. LCDdirectLVDS cannot use the defaults
#  as the programming-MOSI == OC1A, which is in use, so cannot be used for
#   polled_uat's Tx0
#   Similar for the other pins.
#  So the project makefile should name these as appropriate
#  (A/O LCDdirectLVDS70, it has yet to be implemented in this way)
#ifndef HEARTBEAT_PIN_NAME
#HEARTBEAT_PIN_NAME = PB1
#HEARTBEAT_PIN_PORT = PORTB
#endif

#ifndef PUAR_RX0_PIN_NAME
#PUAR_RX0_PIN_NAME = PB2
#PUAR_RX0_PIN_PORT = PORTB
#endif

#ifndef PUAT_TX0_PIN_NAME
#PUAT_TX0_PIN_NAME = PB0
#PUAT_TX0_PIN_PORT = PORTB
#endif

#/* mehPL:
# *    I would love to believe in a world where licensing shouldn't be
# *    necessary; where people would respect others' work and wishes, 
# *    and give credit where it's due. 
# *    A world where those who find people's work useful would at least 
# *    send positive vibes--if not an email.
# *    A world where we wouldn't have to think about the potential
# *    legal-loopholes that others may take advantage of.
# *
# *    Until that world exists:
# *
# *    This software and associated hardware design is free to use,
# *    modify, and even redistribute, etc. with only a few exceptions
# *    I've thought-up as-yet (this list may be appended-to, hopefully it
# *    doesn't have to be):
# * 
# *    1) Please do not change/remove this licensing info.
# *    2) Please do not change/remove others' credit/licensing/copyright 
# *         info, where noted. 
# *    3) If you find yourself profiting from my work, please send me a
# *         beer, a trinket, or cash is always handy as well.
# *         (Please be considerate. E.G. if you've reposted my work on a
# *          revenue-making (ad-based) website, please think of the
# *          years and years of hard work that went into this!)
# *    4) If you *intend* to profit from my work, you must get my
# *         permission, first. 
# *    5) No permission is given for my work to be used in Military, NSA,
# *         or other creepy-ass purposes. No exceptions. And if there's 
# *         any question in your mind as to whether your project qualifies
# *         under this category, you must get my explicit permission.
# *
# *    The open-sourced project this originated from is ~98% the work of
# *    the original author, except where otherwise noted.
# *    That includes the "commonCode" and makefiles.
# *    Thanks, of course, should be given to those who worked on the tools
# *    I've used: avr-dude, avr-gcc, gnu-make, vim, usb-tiny, and 
# *    I'm certain many others. 
# *    And, as well, to the countless coders who've taken time to post
# *    solutions to issues I couldn't solve, all over the internets.
# *
# *
# *    I'd love to hear of how this is being used, suggestions for
# *    improvements, etc!
# *         
# *    The creator of the original code and original hardware can be
# *    contacted at:
# *
# *        EricWazHung At Gmail Dotcom
# *
# *    This code's origin (and latest versions) can be found at:
# *
# *        https://code.google.com/u/ericwazhung/
# *
# *    The site associated with the original open-sourced project is at:
# *
# *        https://sites.google.com/site/geekattempts/
# *
# *    If any of that ever changes, I will be sure to note it here, 
# *    and add a link at the pages above.
# *
# * This license added to the original file located at:
# * /Users/meh/_avrProjects/LCDdirectLVDS/93-checkingProcessAgain/_commonCode_localized/_make/attiny861.mk
# *
# *    (Wow, that's a lot longer than I'd hoped).
# *
# *    Enjoy!
# */
