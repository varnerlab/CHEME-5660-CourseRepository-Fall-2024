# setup paths -
const _ROOT = @__DIR__;
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# make sure all is up to date -
using Pkg
# Pkg.add(path="https://github.com/varnerlab/VLQuantitativeFinancePackage.jl.git")
# Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.add(path="https://github.com/varnerlab/VLQuantitativeFinancePackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using VLQuantitativeFinancePackage
using DataFrames
using Statistics
using Plots
using Colors