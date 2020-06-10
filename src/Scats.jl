__precompile__()

# Этот файл содержит описание
# внешнего интерфейса модуля Scats

baremodule Scats

"""
A module containing all inner parts of this package.

Is not advisable to be used directly, although precisions of integer ([`internal.prec.IT`](@ref)) and real ([`internal.prec.RT`](@ref)) numbers and also the format of real numbers ([`internal.prec.RF`](@ref)) can be altered if needed.

"""
module internal
include("prec.jl")          # Точность входных данных
include("extras/extras.jl") # Вспомогательные функции
include("input/input.jl")   # Входные данные
include("result/result.jl") # Результат
include("gen/gen.jl")       # Генератор временного ряда
using .prec
using .input
using .result
using .gen
using .extras
end

using .internal: InputStruct, ResultStruct, GenStruct
import Base.!, Base.!==, Base.println

"""
    api()

Instantiate an instance of Scats API to get access to the public interface.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()

# output

Scats.api(Scats.internal.input.InputStruct(0, 0.0, 0.0, Float64[], Float64[], Scats.internal.input.var"#1#5"{Scats.internal.input.InputStruct}(Scats.internal.input.InputStruct(#= circular reference @-2 =#)), Scats.internal.input.var"#2#6"{Scats.internal.input.InputStruct}(Scats.internal.input.InputStruct(#= circular reference @-2 =#)), Scats.internal.input.var"#3#7"(), Scats.internal.input.var"#4#8"{Scats.internal.input.InputStruct}(Scats.internal.input.InputStruct(#= circular reference @-2 =#))), Scats.var"#1#8"{Scats.api}(Scats.api(#= circular reference @-2 =#)), Scats.var"#2#9"{Scats.api}(Scats.api(#= circular reference @-2 =#)), Scats.var"#3#10"{Scats.api}(Scats.api(#= circular reference @-2 =#)), Scats.internal.gen.GenStruct(0, 0.0, 0.0, 0.0, 0.0, 0, Float64[], Float64[], Float64[], 0.0, Scats.internal.gen.var"#1#5"{Scats.internal.gen.GenStruct}(Scats.internal.gen.GenStruct(#= circular reference @-2 =#)), Scats.internal.gen.var"#2#6"(), Scats.internal.gen.var"#3#7"{Scats.internal.gen.GenStruct}(Scats.internal.gen.GenStruct(#= circular reference @-2 =#)), Scats.internal.gen.var"#4#8"{Scats.internal.gen.GenStruct}(Scats.internal.gen.GenStruct(#= circular reference @-2 =#))), Scats.var"#4#11"{Scats.api}(Scats.api(#= circular reference @-2 =#)), Scats.var"#5#12"{Scats.api}(Scats.api(#= circular reference @-2 =#)), Scats.var"#6#13"{Scats.api}(Scats.api(#= circular reference @-2 =#)), Scats.internal.result.ResultStruct(0.0, Float64[], Float64[], 0.0, 0.0, Float64[], Float64[], Float64[], Float64[], Float64[], #undef, Scats.internal.result.var"#1#2"{Scats.internal.result.ResultStruct}(Scats.internal.result.ResultStruct(#= circular reference @-2 =#))), Scats.var"#7#14"{Scats.api}(Scats.api(#= circular reference @-2 =#)))
```
"""
mutable struct api

    input::InputStruct
    read_input!::Function
    write_input::Function
    input_example::Function

    gen::GenStruct
    read_gen!::Function
    gen!::Function
    gen_example::Function

    result::ResultStruct

    reset!::Function

    function api()

        this = new()

        this.input = InputStruct()
        this.read_input! = this.input.read!
        this.write_input = this.input.write
        this.input_example = this.input.example

        this.gen = GenStruct()
        this.read_gen! = this.gen.read!
        this.gen! = function() this.gen.gen!(this.gen, this.input) end
        this.gen_example = this.gen.example

        this.result = ResultStruct()

        this.reset! = function() this.input.reset!(), this.result.reset!(), this.gen.reset!() end

        this

    end

end

end