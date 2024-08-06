abstract type AbstractStochasticAssetPriceModel end
abstract type AbstractStochasticSolverModel end


function _nodes(tree::MyBinomialEquityPriceTree, level::Int64)::Array{MyBiomialLatticeEquityNodeModel,1}

    # initialize -
    return tree.levels[level] .|> x-> tree.data[x]
end

(tree::MyBinomialEquityPriceTree)(level::Int64)::Array{MyBiomialLatticeEquityNodeModel,1} = _nodes(tree, level)