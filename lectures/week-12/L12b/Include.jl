# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# download external packages
import Pkg; 
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLQuantitativeFinancePackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load packages -
using VLQuantitativeFinancePackage
using Plots
using Colors
using CSV
using DataFrames
using JLD2
using FileIO
using Statistics
using Dates
using LinearAlgebra
using StatsPlots
using Distributions
using HypothesisTests
using PrettyTables