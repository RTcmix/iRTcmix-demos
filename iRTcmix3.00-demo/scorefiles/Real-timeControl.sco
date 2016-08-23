time = 0
dur  = .15
for (time = 0; time < 6;  time += dur)
{
	note = pickrand(7.10, 8.00, 8.03, 8.05, 8.06, 8.07, 8.10, 8.00, 9.03)
	pitch = cpspch(note) * pitchShift
	STRUM2(time, dur * 4, 12000, pitch, .2, dur * 4, random())
}