should_precompile =  false


# Don't edit the following! Instead change the script for `snoop_bot`.
ismultios = true
ismultiversion = true
# precompile_enclosure
@static if !should_precompile
    # nothing
elseif !ismultios && !ismultiversion
    include("../deps/SnoopCompile/precompile/precompile_Scats.jl")
    _precompile_()
else
    @static if Sys.islinux() 
    @static if v"1.5.0-DEV" <= VERSION <= v"1.5.9" 
    include("../deps/SnoopCompile/precompile/linux/1.5/precompile_Scats.jl")
    _precompile_()
else 
    end

elseif Sys.iswindows() 
    @static if v"1.5.0-DEV" <= VERSION <= v"1.5.9" 
    include("../deps/SnoopCompile/precompile/windows/1.5/precompile_Scats.jl")
    _precompile_()
else 
    end

elseif Sys.isapple() 
    @static if v"1.5.0-DEV" <= VERSION <= v"1.5.9" 
    include("../deps/SnoopCompile/precompile/apple/1.5/precompile_Scats.jl")
    _precompile_()
else 
    end

else 
    end

end # precompile_enclosure
