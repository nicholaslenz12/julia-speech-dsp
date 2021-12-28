using Test, SpeechMath

@testset "Testing SpeechMath" begin
    # http://www.homepages.ucl.ac.uk/~sslyjjt/speech/Mel2Hz.html
    @testset "Mel <=> Hz Conversions" begin
        # Mel => Hz
        @test isapprox(meltohertz(100), 64.950139, rtol = 1e-6)
        @test isapprox(meltohertz(0), 0.0, rtol = 1e-6)

        # Hz => Mel
        @test isapprox(hertztomel(100), 150.491278, rtol = 1e-6)
        @test isapprox(hertztomel(0), 0.0, rtol = 1e-6)
    end

    @testset "Test triangle filtering" begin
        @test trifilt(nothing, nothing, nothing) === nothing
    end
end