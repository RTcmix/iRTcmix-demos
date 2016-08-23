// the argument given to print_on() determines the types of messages that will be sent by the RTcmix parser
// 0 -- fatal errors
// 1 -- print() and printf()
// 2 -- rterrors
// 3 -- warn errors
// 4 -- advise notifications
// 5 -- all the rest

print_on(6)

srand()

// Waveforms for Boop and Bop
triWave = maketable("wave", 1000, "tri")
squareWave = maketable("wave", 1000, "square")

// Pfield input for Real-time Control
pitchShift = makeconnection("inlet", 1, 1.0) 



