atreplinit() do repl
    try
        @eval using OhMyREPL
        @eval using Traceur
        @eval using Rebugger
        @eval using Debugger
        @eval using ProgressMeter
        @eval using BenchmarkTools
        # @eval using ProfileView
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch e
        @warn(e.msg)
    end
end

#=
try
    @eval using Pkg
    haskey(Pkg.installed(), "OhMyREPL") || @eval Pkg.add("OhMyREPL")
    haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
    haskey(Pkg.installed(), "Traceur") || @eval Pkg.add("Traceur")
    haskey(Pkg.installed(), "Rebugger") || @eval Pkg.add("Rebugger")
    haskey(Pkg.installed(), "Debugger") || @eval Pkg.add("Debugger")
    haskey(Pkg.installed(), "ProgressMeter") || @eval Pkg.add("ProgressMeter")
    haskey(Pkg.installed(), "BenchmarkTools") || @eval Pkg.add("BenchmarkTools")
    # haskey(Pkg.installed(), "ProfileView") || @eval Pkg.add("ProfileView")
    haskey(Pkg.installed(), "LanguageServer") || @eval Pkg.add("LanguageServer")
    haskey(Pkg.installed(), "SymbolServer") || @eval Pkg.add("SymbolServer")
    haskey(Pkg.installed(), "StaticLint") || @eval Pkg.add("StaticLint")
    haskey(Pkg.installed(), "JuliaFormatter") || @eval Pkg.add("StaticLint")
catch
end
=#
