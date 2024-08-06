function _nodes(tree::MyBinomialEquityPriceTree, level::Int64)::Array{MyBiomialLatticeEquityNodeModel,1}

    # initialize -
    return tree.levels[level] .|> x-> random_test_model.data[x]
end


(tree::MyBinomialEquityPriceTree, level::Int64)::Array{Int64,1} = _nodes(tree, level)