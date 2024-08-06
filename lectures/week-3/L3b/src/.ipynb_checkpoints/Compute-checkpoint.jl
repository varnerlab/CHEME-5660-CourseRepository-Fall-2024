# Shortcut methods
(compounding::DiscreteCompoundingModel)(model::MyUSTreasuryCouponSecurityModel) = _price_discrete_compounding(model::MyUSTreasuryCouponSecurityModel)
(compounding::ContinuousCompoundingModel)(model::MyUSTreasuryCouponSecurityModel) = _price_continuous_compounding(model::MyUSTreasuryCouponSecurityModel)