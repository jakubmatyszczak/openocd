
set RTTC_RTMR [expr $AT91C_BASE_RTTC + 0x00]
set RTTC_RTAR [expr $AT91C_BASE_RTTC + 0x04]
set RTTC_RTVR [expr $AT91C_BASE_RTTC + 0x08]
set RTTC_RTSR [expr $AT91C_BASE_RTTC + 0x0c]
global RTTC_RTMR
global RTTC_RTAR
global RTTC_RTVR
global RTTC_RTSR

proc show_RTTC_RTMR_helper { NAME ADDR VAL } {
    set rtpres [expr $VAL & 0x0ffff]
    global BIT16 BIT17
    if { $rtpres == 0 } {
	set rtpres 65536;
    } 
    global AT91C_SLOWOSC_FREQ
    set f [expr double($AT91C_SLOWOSC_FREQ) / double($rtpres)]
    puts [format "\tPrescale value: 0x%04x (%5d) => %f Hz" $rtpres $rtpres $f]
    if { $VAL & $BIT16 } {
	puts "\tBit16 -> Alarm IRQ Enabled"
    } else {
	puts "\tBit16 -> Alarm IRQ Disabled"
    }
    if { $VAL & $BIT17 } {
	puts "\tBit17 -> RTC Inc IRQ Enabled"
    } else {
	puts "\tBit17 -> RTC Inc IRQ Disabled"
    }
    # Bit 18 is write only.
}

proc show_RTTC_RTSR_helper { NAME ADDR VAL } {
    global BIT0 BIT1
    if { $VAL & $BIT0 } {
	puts "\tBit0 -> ALARM PENDING"
    } else {
	puts "\tBit0 -> alarm not pending"
    }
    if { $VAL & $BIT1 } {
	puts "\tBit0 -> RTINC PENDING"
    } else {
	puts "\tBit0 -> rtinc not pending"
    }
}

proc show_RTTC { } {
    
    show_mmr32_reg RTTC_RTMR
    show_mmr32_reg RTTC_RTAR
    show_mmr32_reg RTTC_RTVR
    show_mmr32_reg RTTC_RTSR
}

