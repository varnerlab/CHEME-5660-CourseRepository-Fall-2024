function _nodes(tree::MyBinomialEquityPriceTree, level::Int64)::Array{MyBiomialLatticeEquityNodeModel,1}

    # initialize -
    return tree.levels[level] .|> x-> tree.data[x]
end


(tree::MyBinomialEquityPriceTree)(level::Int64)::Array{MyBiomialLatticeEquityNodeModel,1} = _nodes(tree, level)