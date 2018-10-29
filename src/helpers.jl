for (fn, name) in [(:o, :Open), (:h, :High), (:l, :Low), (:c, :Close), (:v, :Volume)]
    @eval @deprecate $fn(ta::TimeArray) getindex(ta, $name)
end
