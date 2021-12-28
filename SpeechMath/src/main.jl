using SpeechMath, WAV

filename = "speech.wav"
y, SAMPLE_RATE = wavread(filename)
y = vec(y)
# wavplay(y, SAMPLE_RATE)

visualize(y, SAMPLE_RATE; windowsize = 100)