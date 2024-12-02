# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# check: do we have the required packahes loaded??
using Pkg
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLQuantitativeFinancePackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using VLQuantitativeFinancePackage;
using Distributions
using DataFrames
using CSV
using JLD2
using FileIO
using Statistics
using StatsBase
using StatsPlots
using Colors
using PrettyTables
using LinearAlgebra
using Images

# load my codes -
include(joinpath(_PATH_TO_SRC, "Files.jl"));