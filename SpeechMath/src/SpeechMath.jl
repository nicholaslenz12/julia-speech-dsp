module SpeechMath

export hertztomel, meltohertz, trifilt, computemfcc, visualize

using FFTW, Plots, WAV, DSP

# http://www.practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/#computing-the-mel-filterbank
# https://www.gaussianwaves.com/2015/11/interpreting-fft-results-complex-dft-frequency-bins-and-fftshift/

const c = 1127.01048
hertztomel(f) = c * log(1 + f / 700)
meltohertz(m) = 700(ℯ^(m / c) - 1)

function trifilt(spectrum, center, spread)
    return nothing
end

function computepower(x, window = Windows.hanning)
    x .*= window(length(x))
    x̂ = fft(x)
    abs.(x̂) .^ 2
end

function visualize(x, samplerate; window = Windows.hanning, windowsize = 400)
    range = 1:windowsize:length(x)+1
    nyquistrate = samplerate ÷ 2
    nframes = length(range) - 1
    nposfreqs = windowsize ÷ 2 + 1

    powers = Matrix{Float64}(undef, nposfreqs, nframes)
    freqs = LinRange(0, nyquistrate, nposfreqs)

    # Lose the last frame if smaller than windowsize
    for (i, s) in enumerate(zip(range, range[2:end]))
        thestart, theend = s
        y = x[thestart:theend-1]
        Y = computepower(y)
        Y_real = Y[1:nposfreqs]
        powers[:, i] = log10.(Y_real) .+ 1e-6
    end

    heatmap(range[1:end-1], freqs, powers)
end

function computemfcc(x, window = Windows.hanning, ncoeffs = 26)
    powerspectrum = computepower(x)

    bins = zeros(ncoeffs)
    for (ibin, bin) in enumerate(bins)
        center = 1 # HARDCODED - UPDATE
        spread = 2 # HARDCODED - UPDATE
        bins[ibin] = trifilt(powerspectrum, center, spread)
    end

    bins = log.(bins)

    # DCT
    dct(bins)
end

end