var documenterSearchIndex = {"docs":
[{"location":"lib/Internals/Gen/#Gen-1","page":"Gen","title":"Gen","text":"","category":"section"},{"location":"lib/Internals/Gen/#","page":"Gen","title":"Gen","text":"Modules = [Scats.Internal.Gen]","category":"page"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen","page":"Gen","title":"Scats.Internal.Gen","text":"Module containing a type for interaction with the time series generator.\n\n\n\n\n\n","category":"module"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.GenStruct","page":"Gen","title":"Scats.Internal.Gen.GenStruct","text":"GenStruct()\n\nInstantiate this type to interact with the time series generator.\n\nData\n\nN::IT=0: sample size;\nΔt::RT=0: sample step;\nq::RT=0: significance level;\nα::RT=0: parameter α of a linear trend;\nβ::RT=0: parameter β of a linear trend;\nr::IT=0: number of harmonics;\nA::Vector{RT}=[]: amplitudes array;\nν::Vector{RT}=[]: frequencies array;\nϕ::Vector{RT}=[]: phase shifts array;\nγ::RT=0: «signal-to-noise» ratio.\n\nMethods\n\nread!(file::AbstractString): read generator parameters from a file;\nexample(file::AbstractString): generate an example of a file containing the generator parameters;\ngen!(): generate time series;\nreset!(): reset an instance to default values.\n\nNote\n\nData can be also read when calling an instance like so:\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Gen.example(file)\ns.Gen(file)\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.gen!-Tuple{Scats.Internal.Gen.GenStruct,Scats.Internal.Input.InputStruct}","page":"Gen","title":"Scats.Internal.Gen.gen!","text":"gen!(Gen::GenStruct, Input::InputStruct)\n\nGenerate time series for an instance of InputStruct using generator parameters from an instance of GenStruct.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Gen.example(file)\ns.gen!()\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenEOF","page":"Gen","title":"Scats.Internal.Gen.ScatsGenEOF","text":"ScatsGenEOF <: Exception\n\nException thrown when an end of file occurred.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenIsADir","page":"Gen","title":"Scats.Internal.Gen.ScatsGenIsADir","text":"ScatsGenIsADir <: Exception\n\nException thrown when the path is a directory.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenNotAFile","page":"Gen","title":"Scats.Internal.Gen.ScatsGenNotAFile","text":"ScatsGenNotAFile <: Exception\n\nException thrown when the file is not found.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_A","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_A","text":"ScatsGenWR_A <: Exception\n\nException thrown when an input for A is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_N","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_N","text":"ScatsGenWR_N <: Exception\n\nException thrown when an input for N is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_q","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_q","text":"ScatsGenWR_q <: Exception\n\nException thrown when an input for q is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_r","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_r","text":"ScatsGenWR_r <: Exception\n\nException thrown when an input for r is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_Δt","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_Δt","text":"ScatsGenWR_Δt <: Exception\n\nException thrown when an input for Δt is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_α","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_α","text":"ScatsGenWR_α <: Exception\n\nException thrown when an input for α is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_β","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_β","text":"ScatsGenWR_β <: Exception\n\nException thrown when an input for β is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_γ","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_γ","text":"ScatsGenWR_γ <: Exception\n\nException thrown when an input for γ is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_ν","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_ν","text":"ScatsGenWR_ν <: Exception\n\nException thrown when an input for ν is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.ScatsGenWR_ϕ","page":"Gen","title":"Scats.Internal.Gen.ScatsGenWR_ϕ","text":"ScatsGenWR_ϕ <: Exception\n\nException thrown when an input for ϕ is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.example-Tuple{AbstractString}","page":"Gen","title":"Scats.Internal.Gen.example","text":"example(file::AbstractString)\n\nGenerate an example of a file containing the generator parameters.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Gen.example(file)\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.read!-Tuple{Scats.Internal.Gen.GenStruct,AbstractString}","page":"Gen","title":"Scats.Internal.Gen.read!","text":"read!(Gen::GenStruct, file::AbstractString)\n\nRead generator parameters from a file to an instance of GenStruct.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Gen.example(file)\ns.Gen.read!(file)\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Gen/#Scats.Internal.Gen.reset!-Tuple{Scats.Internal.Gen.GenStruct}","page":"Gen","title":"Scats.Internal.Gen.reset!","text":"reset!(Gen::GenStruct)\n\nReset an instance of GenStruct to default values.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Gen.example(file)\ns.Gen.read!(file)\ns.Gen.reset!()\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Module/#Module-1","page":"Module","title":"Module","text":"","category":"section"},{"location":"lib/Internals/Module/#","page":"Module","title":"Module","text":"All inner parts of this package are conveniently hidden in the inner module Scats.Internal:","category":"page"},{"location":"lib/Internals/Module/#","page":"Module","title":"Module","text":"Scats.Internal","category":"page"},{"location":"lib/Internals/Module/#Scats.Internal","page":"Module","title":"Scats.Internal","text":"A module containing all inner parts of this package. Is not advisable to be used directly.\n\nSee documentation for more info about its contents.\n\n\n\n\n\n","category":"module"},{"location":"lib/Internals/Module/#","page":"Module","title":"Module","text":"The next section presents the module containing the precisions and the formats of numbers used in the package.","category":"page"},{"location":"lib/Internals/Module/#","page":"Module","title":"Module","text":"The following sections present the main types used inside the package which are appearing in an API instance:","category":"page"},{"location":"lib/Internals/Module/#","page":"Module","title":"Module","text":"Input: input data;\nGen: generator;\nResult: result data.","category":"page"},{"location":"lib/Internals/Module/#","page":"Module","title":"Module","text":"The last section shows what extras are developed for the usage inside the package.","category":"page"},{"location":"lib/Public/#Public-1","page":"Public","title":"Public","text":"","category":"section"},{"location":"lib/Public/#Main-Module-1","page":"Public","title":"Main Module","text":"","category":"section"},{"location":"lib/Public/#","page":"Public","title":"Public","text":"Scats","category":"page"},{"location":"lib/Public/#Scats","page":"Public","title":"Scats","text":"A package for completing spectral correlation analysis of time series.\n\nLinks:\n\nRepo: https://github.com/paveloom-j/Scats.jl\nDocs: https://paveloom-j.github.io/Scats.jl\n\nPlease, use the published docs instead of retrieving information from these docstrings manually.\n\n\n\n\n\n","category":"module"},{"location":"lib/Public/#API-1","page":"Public","title":"Interface","text":"","category":"section"},{"location":"lib/Public/#","page":"Public","title":"Public","text":"This part of the package is the only one supposed to be used by a regular user. All recommended for usage types and methods are accessible from an instance of Scats.API. For the inner parts one should consider reading the pages in the Internals section.","category":"page"},{"location":"lib/Public/#","page":"Public","title":"Public","text":"Scats.API","category":"page"},{"location":"lib/Public/#Scats.API","page":"Public","title":"Scats.API","text":"API()\n\nInstantiate an instance of Scats API to get access to the public interface.\n\nTypes\n\nInput: input data;\nGen: generator;\nResult: result data.\n\nMethods\n\nfor Input:\nread_input!(file::AbstractString):   read input data from a file;\nwrite_input(file::AbstractString):   write input data to a file;\ninput_example(file::AbstractString):   generate an example of the input/output file.\nfor Gen:\nread_gen!(file::AbstractString):   read generator parameters from a file;\ngen_example(file::AbstractString):   generate an example of a file containing the generator parameters;\ngen!():   generate time series.\n\nUsage\n\nusing Scats\ns = Scats.API()\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Input-1","page":"Input","title":"Input","text":"","category":"section"},{"location":"lib/Internals/Input/#","page":"Input","title":"Input","text":"Modules = [Scats.Internal.Input]","category":"page"},{"location":"lib/Internals/Input/#Scats.Internal.Input","page":"Input","title":"Scats.Internal.Input","text":"Module containing a type for storage and interaction with input data.\n\n\n\n\n\n","category":"module"},{"location":"lib/Internals/Input/#Scats.Internal.Input.InputStruct","page":"Input","title":"Scats.Internal.Input.InputStruct","text":"InputStruct()\n\nInstantiate this type to interact with input data.\n\nData\n\nN::IT=0: sample size;\nΔt::RT=0: sample step;\nq::RT=0: significance level;\nt::Vector{RT}=[]: time array;\nx::Vector{RT}=[]: values array.\n\nMethods\n\nread!(file::AbstractString): read input data from a file;\nwrite(file::AbstractString): write input data to a file;\nexample(file::AbstractString): generate an example of the input/output file;\nreset!(): reset an instance to default values.\n\nNote\n\nData can be also read when calling an instance like so:\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Input.example(file)\ns.Input(file)\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputEOF","page":"Input","title":"Scats.Internal.Input.ScatsInputEOF","text":"ScatsInputEOF <: Exception\n\nException thrown when an end of file occurred.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputIsADir","page":"Input","title":"Scats.Internal.Input.ScatsInputIsADir","text":"ScatsInputIsADir <: Exception\n\nException thrown when the path is a directory.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputNotAFile","page":"Input","title":"Scats.Internal.Input.ScatsInputNotAFile","text":"ScatsInputNotAFile <: Exception\n\nException thrown when the file is not found.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputWR_N","page":"Input","title":"Scats.Internal.Input.ScatsInputWR_N","text":"ScatsInputWR_N <: Exception\n\nException thrown when an input for N is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputWR_q","page":"Input","title":"Scats.Internal.Input.ScatsInputWR_q","text":"ScatsInputWR_q <: Exception\n\nException thrown when an input for q is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputWR_t","page":"Input","title":"Scats.Internal.Input.ScatsInputWR_t","text":"ScatsInputWR_t <: Exception\n\nException thrown when an input for t is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputWR_x","page":"Input","title":"Scats.Internal.Input.ScatsInputWR_x","text":"ScatsInputWR_x <: Exception\n\nException thrown when an input for x is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.ScatsInputWR_Δt","page":"Input","title":"Scats.Internal.Input.ScatsInputWR_Δt","text":"ScatsInputWR_Δt <: Exception\n\nException thrown when an input for Δt is wrong.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Input/#Scats.Internal.Input.example-Tuple{AbstractString}","page":"Input","title":"Scats.Internal.Input.example","text":"example(file::AbstractString)\n\nGenerate an example of the input/output file.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Input.example(file)\n\nSee: InputStruct.\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Input/#Scats.Internal.Input.read!-Tuple{Scats.Internal.Input.InputStruct,AbstractString}","page":"Input","title":"Scats.Internal.Input.read!","text":"read!(input::InputStruct, file::AbstractString)\n\nRead input data from a file to an instance of InputStruct.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Input.example(file)\ns.Input.read!(file)\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Input/#Scats.Internal.Input.reset!-Tuple{Scats.Internal.Input.InputStruct}","page":"Input","title":"Scats.Internal.Input.reset!","text":"reset!(input::InputStruct)\n\nReset an instance of InputStruct to default values.\n\nUsage\n\nusing Scats\ns = Scats.API()\ns.Input.reset!()\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Input/#Scats.Internal.Input.write-Tuple{Scats.Internal.Input.InputStruct,AbstractString}","page":"Input","title":"Scats.Internal.Input.write","text":"write(input::InputStruct, file::AbstractString)\n\nWrite input data from an instance of InputStruct to a file.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.Input.write(file)\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Result/#Result-1","page":"Result","title":"Result","text":"","category":"section"},{"location":"lib/Internals/Result/#","page":"Result","title":"Result","text":"Modules = [Scats.Internal.Result]","category":"page"},{"location":"lib/Internals/Result/#Scats.Internal.Result","page":"Result","title":"Scats.Internal.Result","text":"Module containing a type for interaction with result data.\n\n\n\n\n\n","category":"module"},{"location":"lib/Internals/Result/#Scats.Internal.Result.ResultStruct","page":"Result","title":"Scats.Internal.Result.ResultStruct","text":"ResultStruct()\n\nInstantiate this type to interact with result data.\n\nData\n\nΔt::RT=0: sample step;\nt::Vector{RT}=[]: time array;\nx::Vector{RT}=[]: values array;\nq::RT=0: significance level;\nthreshold::RT=0: signal threshold;\nX_FFT_ABS::Vector{RT}=[]: values array;\nν::Vector{RT}=[]: periodogram frequencies array;\nD::Vector{RT}=[]: periodogram values array;\nc::Vector{RT}=[]: correlogram values array;\ncw::Vector{RT}=[]: weighted correlogram values array;\nDw::Vector{RT}=[]: smoothed periodogram values array.\n\nMethods\n\nreset!(): reset an instance to default values.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Result/#Scats.Internal.Result.reset!-Tuple{Scats.Internal.Result.ResultStruct}","page":"Result","title":"Scats.Internal.Result.reset!","text":"reset!(Result::ResultStruct)\n\nReset an instance of ResultStruct to default values.\n\nUsage\n\nusing Scats\ns = Scats.API()\nfile, _ = mktemp()\ns.gen_example(file)\ns.Gen(file)\ns.gen!()\n# Generate result data\ns.Result.reset!()\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Extras/#Extras-1","page":"Extras","title":"Extras","text":"","category":"section"},{"location":"lib/Internals/Extras/#","page":"Extras","title":"Extras","text":"Modules = [Scats.Internal.Extras]","category":"page"},{"location":"lib/Internals/Extras/#Scats.Internal.Extras","page":"Extras","title":"Scats.Internal.Extras","text":"Module containing extras: auxiliary functions used within the package.\n\n\n\n\n\n","category":"module"},{"location":"lib/Internals/Extras/#Base.println-Tuple{IO,Array{Float64,1}}","page":"Extras","title":"Base.println","text":"println(io::IO, array::Array{RT, 1})\n\nPrint an array containing RT values.\n\nUsage\n\nusing Scats: Internal.Prec.RT, Internal.Extras.println\nx = Array{RT}([1.0, 2.0, 3.0])\nprintln(x)\n\n# output\n\n 1.000000000000000E+00    2.000000000000000E+00    3.000000000000000E+00\n\nNote: this doctest requires x64 architecture.\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Extras/#Base.println-Tuple{IO,Float64}","page":"Extras","title":"Base.println","text":"println(io::IO, value::RT)\n\nPrint an RT value.\n\nUsage\n\nusing Scats: Internal.Prec.RT, Internal.Extras.println\nx = RT(1.0)\nprintln(x)\n\n# output\n\n 1.000000000000000E+00\n\nNote: this doctest requires x64 architecture.\n\n\n\n\n\n","category":"method"},{"location":"lib/Internals/Prec/#Prec-1","page":"Prec","title":"Prec","text":"","category":"section"},{"location":"lib/Internals/Prec/#","page":"Prec","title":"Prec","text":"Modules = [Scats.Internal.Prec]","category":"page"},{"location":"lib/Internals/Prec/#Scats.Internal.Prec","page":"Prec","title":"Scats.Internal.Prec","text":"Module containing the types of numbers used in the package, and also their according formats.\n\n\n\n\n\n","category":"module"},{"location":"lib/Internals/Prec/#Scats.Internal.Prec.RF","page":"Prec","title":"Scats.Internal.Prec.RF","text":"Format of real values. Default values:\n\nfor RT = Float64: \"% .15E\";\nfor RT = Float32: \"% .6E\";\nfor RT = Float16: \"% .3E\".\n\n\n\n\n\n","category":"constant"},{"location":"lib/Internals/Prec/#Scats.Internal.Prec.IT","page":"Prec","title":"Scats.Internal.Prec.IT","text":"Type of integer values. Default value: Int.\n\n\n\n\n\n","category":"type"},{"location":"lib/Internals/Prec/#Scats.Internal.Prec.RT","page":"Prec","title":"Scats.Internal.Prec.RT","text":"Type of real values. Default value: typeof(1.0).\n\n\n\n\n\n","category":"type"},{"location":"#Scats.jl-1","page":"Home","title":"Scats.jl","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Realization of the SCATS library in Julia.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"A package for completing spectral correlation analysis of time series.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"note: Note\nThis package was developed primarily for learning purposes and is not advised to be used in production.","category":"page"},{"location":"#Features-1","page":"Home","title":"Features","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"generation of the uniform time series with custom number of harmonics;\neliminating a linear trend from time series;\nperiodogram and correlogram computations using FFT;\nweighted correlogram computation using Tukey weighting function;\nsmoothed periodogram computation using FFT.","category":"page"},{"location":"#Project-management-1","page":"Home","title":"Project management","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"ZenHub is being used for agile project management. Download the extension to see the board on the repository's landing page.","category":"page"},{"location":"#Library-1","page":"Home","title":"Library","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Pages = [\"lib/public.md\"]","category":"page"}]
}
