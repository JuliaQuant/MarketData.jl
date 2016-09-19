for (fn, name) in [(:o, "Open"), (:h, "High"), (:l, "Low"), (:c, "Close"), (:v, "Volume")]
    @eval begin
        function $fn(ta::TimeArray)
            ta[$name]
        end
    end
end
