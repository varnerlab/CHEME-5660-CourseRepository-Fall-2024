# setup paths -
const _ROOT = @__DIR__
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
using LinearAlgebra;
using Statistics;
using Distributions;
using DataFrames;
using JLD2;
using FileIO;
using Plots;
using Colors;
using StatsPlots;
using HypothesisTests;
using CSV
using StatsBase
using Distances

# include my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Files.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));