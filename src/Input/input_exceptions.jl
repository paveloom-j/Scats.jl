# This file contains custom exceptions
# for functions related to input data

@exception(
    "Exception thrown when the file is not found.",
    "Input",
    "ScatsInputNotAFile",
    "The file is not found (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when the path is a directory.",
    "Input",
    "ScatsInputIsADir",
    "Specified path is a directory (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when an end of file occurred.",
    "Input",
    "ScatsInputEOF",
    "Unexpected end of file (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when an input for `N` is wrong.",
    "Input",
    "ScatsInputWR_N",
    "Wrong input: N (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when an input for `Δt` is wrong.",
    "Input",
    "ScatsInputWR_Δt",
    "Wrong input: Δt (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when an input for `q` is wrong.",
    "Input",
    "ScatsInputWR_q",
    "Wrong input: q (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when an input for `t` is wrong.",
    "Input",
    "ScatsInputWR_t",
    "Wrong input: t (\\\"\", e.file, \"\\\").",
)

@exception(
    "Exception thrown when an input for `x` is wrong.",
    "Input",
    "ScatsInputWR_x",
    "Wrong input: x (\\\"\", e.file, \"\\\").",
)
