# This file contains the definition of a function
# to generate an example of the input/output file

"""
    example(file::AbstractString)

Generate an example of the input/output file.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.input.example(file)

# output


```

See: [`InputStruct`](@ref).
"""
function example(file::AbstractString)

    # Strip the string
    file = strip(file)

    # Check if it's a directory
    if isdir(file)
        throw(ScatsInputIsADir(file))
    end

    # Print
    open(file, "w") do f

        println(f, "Sample size")
        println(f, "230")
        println(f)
        println(f, "Sample step")
        println(f, "0.100000000000000E+01")
        println(f)
        println(f, "Significance level")
        println(f, "0.100000000000000E-01")
        println(f)
        println(f, "Time array")
        println(f, "0.000000000000000E+00    0.100000000000000E+01    0.200000000000000E+01    0.300000000000000E+01    0.400000000000000E+01    0.500000000000000E+01    0.600000000000000E+01    0.700000000000000E+01    0.800000000000000E+01    0.900000000000000E+01    0.100000000000000E+02    0.110000000000000E+02    0.120000000000000E+02    0.130000000000000E+02    0.140000000000000E+02    0.150000000000000E+02    0.160000000000000E+02    0.170000000000000E+02    0.180000000000000E+02    0.190000000000000E+02    0.200000000000000E+02    0.210000000000000E+02    0.220000000000000E+02    0.230000000000000E+02    0.240000000000000E+02    0.250000000000000E+02    0.260000000000000E+02    0.270000000000000E+02    0.280000000000000E+02    0.290000000000000E+02    0.300000000000000E+02    0.310000000000000E+02    0.320000000000000E+02    0.330000000000000E+02    0.340000000000000E+02    0.350000000000000E+02    0.360000000000000E+02    0.370000000000000E+02    0.380000000000000E+02    0.390000000000000E+02    0.400000000000000E+02    0.410000000000000E+02    0.420000000000000E+02    0.430000000000000E+02    0.440000000000000E+02    0.450000000000000E+02    0.460000000000000E+02    0.470000000000000E+02    0.480000000000000E+02    0.490000000000000E+02    0.500000000000000E+02    0.510000000000000E+02    0.520000000000000E+02    0.530000000000000E+02    0.540000000000000E+02    0.550000000000000E+02    0.560000000000000E+02    0.570000000000000E+02    0.580000000000000E+02    0.590000000000000E+02    0.600000000000000E+02    0.610000000000000E+02    0.620000000000000E+02    0.630000000000000E+02    0.640000000000000E+02    0.650000000000000E+02    0.660000000000000E+02    0.670000000000000E+02    0.680000000000000E+02    0.690000000000000E+02    0.700000000000000E+02    0.710000000000000E+02    0.720000000000000E+02    0.730000000000000E+02    0.740000000000000E+02    0.750000000000000E+02    0.760000000000000E+02    0.770000000000000E+02    0.780000000000000E+02    0.790000000000000E+02    0.800000000000000E+02    0.810000000000000E+02    0.820000000000000E+02    0.830000000000000E+02    0.840000000000000E+02    0.850000000000000E+02    0.860000000000000E+02    0.870000000000000E+02    0.880000000000000E+02    0.890000000000000E+02    0.900000000000000E+02    0.910000000000000E+02    0.920000000000000E+02    0.930000000000000E+02    0.940000000000000E+02    0.950000000000000E+02    0.960000000000000E+02    0.970000000000000E+02    0.980000000000000E+02    0.990000000000000E+02    0.100000000000000E+03    0.101000000000000E+03    0.102000000000000E+03    0.103000000000000E+03    0.104000000000000E+03    0.105000000000000E+03    0.106000000000000E+03    0.107000000000000E+03    0.108000000000000E+03    0.109000000000000E+03    0.110000000000000E+03    0.111000000000000E+03    0.112000000000000E+03    0.113000000000000E+03    0.114000000000000E+03    0.115000000000000E+03    0.116000000000000E+03    0.117000000000000E+03    0.118000000000000E+03    0.119000000000000E+03    0.120000000000000E+03    0.121000000000000E+03    0.122000000000000E+03    0.123000000000000E+03    0.124000000000000E+03    0.125000000000000E+03    0.126000000000000E+03    0.127000000000000E+03    0.128000000000000E+03    0.129000000000000E+03    0.130000000000000E+03    0.131000000000000E+03    0.132000000000000E+03    0.133000000000000E+03    0.134000000000000E+03    0.135000000000000E+03    0.136000000000000E+03    0.137000000000000E+03    0.138000000000000E+03    0.139000000000000E+03    0.140000000000000E+03    0.141000000000000E+03    0.142000000000000E+03    0.143000000000000E+03    0.144000000000000E+03    0.145000000000000E+03    0.146000000000000E+03    0.147000000000000E+03    0.148000000000000E+03    0.149000000000000E+03    0.150000000000000E+03    0.151000000000000E+03    0.152000000000000E+03    0.153000000000000E+03    0.154000000000000E+03    0.155000000000000E+03    0.156000000000000E+03    0.157000000000000E+03    0.158000000000000E+03    0.159000000000000E+03    0.160000000000000E+03    0.161000000000000E+03    0.162000000000000E+03    0.163000000000000E+03    0.164000000000000E+03    0.165000000000000E+03    0.166000000000000E+03    0.167000000000000E+03    0.168000000000000E+03    0.169000000000000E+03    0.170000000000000E+03    0.171000000000000E+03    0.172000000000000E+03    0.173000000000000E+03    0.174000000000000E+03    0.175000000000000E+03    0.176000000000000E+03    0.177000000000000E+03    0.178000000000000E+03    0.179000000000000E+03    0.180000000000000E+03    0.181000000000000E+03    0.182000000000000E+03    0.183000000000000E+03    0.184000000000000E+03    0.185000000000000E+03    0.186000000000000E+03    0.187000000000000E+03    0.188000000000000E+03    0.189000000000000E+03    0.190000000000000E+03    0.191000000000000E+03    0.192000000000000E+03    0.193000000000000E+03    0.194000000000000E+03    0.195000000000000E+03    0.196000000000000E+03    0.197000000000000E+03    0.198000000000000E+03    0.199000000000000E+03    0.200000000000000E+03    0.201000000000000E+03    0.202000000000000E+03    0.203000000000000E+03    0.204000000000000E+03    0.205000000000000E+03    0.206000000000000E+03    0.207000000000000E+03    0.208000000000000E+03    0.209000000000000E+03    0.210000000000000E+03    0.211000000000000E+03    0.212000000000000E+03    0.213000000000000E+03    0.214000000000000E+03    0.215000000000000E+03    0.216000000000000E+03    0.217000000000000E+03    0.218000000000000E+03    0.219000000000000E+03    0.220000000000000E+03    0.221000000000000E+03    0.222000000000000E+03    0.223000000000000E+03    0.224000000000000E+03    0.225000000000000E+03    0.226000000000000E+03    0.227000000000000E+03    0.228000000000000E+03    0.229000000000000E+03")
        println(f)
        println(f, "Values array")
        println(f, "0.000000000000000E+00    0.100000000000000E+01    0.200000000000000E+01    0.300000000000000E+01    0.400000000000000E+01    0.500000000000000E+01    0.600000000000000E+01    0.700000000000000E+01    0.800000000000000E+01    0.900000000000000E+01    0.100000000000000E+02    0.110000000000000E+02    0.120000000000000E+02    0.130000000000000E+02    0.140000000000000E+02    0.150000000000000E+02    0.160000000000000E+02    0.170000000000000E+02    0.180000000000000E+02    0.190000000000000E+02    0.200000000000000E+02    0.210000000000000E+02    0.220000000000000E+02    0.230000000000000E+02    0.240000000000000E+02    0.250000000000000E+02    0.260000000000000E+02    0.270000000000000E+02    0.280000000000000E+02    0.290000000000000E+02    0.300000000000000E+02    0.310000000000000E+02    0.320000000000000E+02    0.330000000000000E+02    0.340000000000000E+02    0.350000000000000E+02    0.360000000000000E+02    0.370000000000000E+02    0.380000000000000E+02    0.390000000000000E+02    0.400000000000000E+02    0.410000000000000E+02    0.420000000000000E+02    0.430000000000000E+02    0.440000000000000E+02    0.450000000000000E+02    0.460000000000000E+02    0.470000000000000E+02    0.480000000000000E+02    0.490000000000000E+02    0.500000000000000E+02    0.510000000000000E+02    0.520000000000000E+02    0.530000000000000E+02    0.540000000000000E+02    0.550000000000000E+02    0.560000000000000E+02    0.570000000000000E+02    0.580000000000000E+02    0.590000000000000E+02    0.600000000000000E+02    0.610000000000000E+02    0.620000000000000E+02    0.630000000000000E+02    0.640000000000000E+02    0.650000000000000E+02    0.660000000000000E+02    0.670000000000000E+02    0.680000000000000E+02    0.690000000000000E+02    0.700000000000000E+02    0.710000000000000E+02    0.720000000000000E+02    0.730000000000000E+02    0.740000000000000E+02    0.750000000000000E+02    0.760000000000000E+02    0.770000000000000E+02    0.780000000000000E+02    0.790000000000000E+02    0.800000000000000E+02    0.810000000000000E+02    0.820000000000000E+02    0.830000000000000E+02    0.840000000000000E+02    0.850000000000000E+02    0.860000000000000E+02    0.870000000000000E+02    0.880000000000000E+02    0.890000000000000E+02    0.900000000000000E+02    0.910000000000000E+02    0.920000000000000E+02    0.930000000000000E+02    0.940000000000000E+02    0.950000000000000E+02    0.960000000000000E+02    0.970000000000000E+02    0.980000000000000E+02    0.990000000000000E+02    0.100000000000000E+03    0.101000000000000E+03    0.102000000000000E+03    0.103000000000000E+03    0.104000000000000E+03    0.105000000000000E+03    0.106000000000000E+03    0.107000000000000E+03    0.108000000000000E+03    0.109000000000000E+03    0.110000000000000E+03    0.111000000000000E+03    0.112000000000000E+03    0.113000000000000E+03    0.114000000000000E+03    0.115000000000000E+03    0.116000000000000E+03    0.117000000000000E+03    0.118000000000000E+03    0.119000000000000E+03    0.120000000000000E+03    0.121000000000000E+03    0.122000000000000E+03    0.123000000000000E+03    0.124000000000000E+03    0.125000000000000E+03    0.126000000000000E+03    0.127000000000000E+03    0.128000000000000E+03    0.129000000000000E+03    0.130000000000000E+03    0.131000000000000E+03    0.132000000000000E+03    0.133000000000000E+03    0.134000000000000E+03    0.135000000000000E+03    0.136000000000000E+03    0.137000000000000E+03    0.138000000000000E+03    0.139000000000000E+03    0.140000000000000E+03    0.141000000000000E+03    0.142000000000000E+03    0.143000000000000E+03    0.144000000000000E+03    0.145000000000000E+03    0.146000000000000E+03    0.147000000000000E+03    0.148000000000000E+03    0.149000000000000E+03    0.150000000000000E+03    0.151000000000000E+03    0.152000000000000E+03    0.153000000000000E+03    0.154000000000000E+03    0.155000000000000E+03    0.156000000000000E+03    0.157000000000000E+03    0.158000000000000E+03    0.159000000000000E+03    0.160000000000000E+03    0.161000000000000E+03    0.162000000000000E+03    0.163000000000000E+03    0.164000000000000E+03    0.165000000000000E+03    0.166000000000000E+03    0.167000000000000E+03    0.168000000000000E+03    0.169000000000000E+03    0.170000000000000E+03    0.171000000000000E+03    0.172000000000000E+03    0.173000000000000E+03    0.174000000000000E+03    0.175000000000000E+03    0.176000000000000E+03    0.177000000000000E+03    0.178000000000000E+03    0.179000000000000E+03    0.180000000000000E+03    0.181000000000000E+03    0.182000000000000E+03    0.183000000000000E+03    0.184000000000000E+03    0.185000000000000E+03    0.186000000000000E+03    0.187000000000000E+03    0.188000000000000E+03    0.189000000000000E+03    0.190000000000000E+03    0.191000000000000E+03    0.192000000000000E+03    0.193000000000000E+03    0.194000000000000E+03    0.195000000000000E+03    0.196000000000000E+03    0.197000000000000E+03    0.198000000000000E+03    0.199000000000000E+03    0.200000000000000E+03    0.201000000000000E+03    0.202000000000000E+03    0.203000000000000E+03    0.204000000000000E+03    0.205000000000000E+03    0.206000000000000E+03    0.207000000000000E+03    0.208000000000000E+03    0.209000000000000E+03    0.210000000000000E+03    0.211000000000000E+03    0.212000000000000E+03    0.213000000000000E+03    0.214000000000000E+03    0.215000000000000E+03    0.216000000000000E+03    0.217000000000000E+03    0.218000000000000E+03    0.219000000000000E+03    0.220000000000000E+03    0.221000000000000E+03    0.222000000000000E+03    0.223000000000000E+03    0.224000000000000E+03    0.225000000000000E+03    0.226000000000000E+03    0.227000000000000E+03    0.228000000000000E+03    0.229000000000000E+03")

    end

end