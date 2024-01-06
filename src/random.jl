function random_cl(rng::AbstractRNG = Random.GLOBAL_RNG;
    start = Dates.DateTime(2020, 1, 1),
    step = Dates.Minute(1),
    length = 500,
    price_init = nothing,
    price_init_min = 1.00,
    price_init_step = 0.01,
    price_init_max = 1000.00,
    price_var_min = -1.0,
    price_var_step = 0.01,
    price_var_max = 1.0,
)
    idx = range(start, length = length, step = step)
    if isnothing(price_init)
        price_init = rand(rng, price_init_min:price_init_step:price_init_max)
    end
    return TimeArray(
        collect(idx),
        price_init .+ cumsum(rand(rng, price_var_min:price_var_step:price_var_max, length)),
        [:Close],
    )
end

function random_vol(rng::AbstractRNG = Random.GLOBAL_RNG;
    start = Dates.DateTime(2020, 1, 1),
    step = Dates.Minute(1),
    length = 500,
    vol_init_min = 0.0,
    vol_init_step = 0.1,
    vol_init_max = 100.0,
)
    idx = range(start, length = length, step = step)
    return TimeArray(
        collect(idx),
        rand(rng, vol_init_min:vol_init_step:vol_init_max, length),
        [:Volume],
    )
end

function random_ohlc(rng::AbstractRNG = Random.GLOBAL_RNG;
    start = Dates.DateTime(2020, 1, 1),
    step = Dates.Hour(1),
    sub_step = Dates.Minute(1),
    length = 500,
    price_init = nothing,
    price_init_min = 1.00,
    price_init_step = 0.01,
    price_init_max = 1000.00,
    price_var_min = -1.0,
    price_var_step = 0.01,
    price_var_max = 1.0
)
    nsub = ceil(Int, step / sub_step)
    price = random_cl(rng,
        start = start,
        step = sub_step,
        length = length * nsub,
        price_init = price_init,
        price_init_min = price_init_min,
        price_init_step = price_init_step,
        price_init_max = price_init_max,
        price_var_min = price_var_min,
        price_var_step = price_var_step,
        price_var_max = price_var_max,
    )
    ta_o = collapse(price, step, first, first)
    ta_h = collapse(price, step, first, maximum)
    ta_l = collapse(price, step, first, minimum)
    ta_c = collapse(price, step, first, last)
    a_ohlc = hcat(values(ta_o), values(ta_h), values(ta_l), values(ta_c))
    return TimeArray(timestamp(ta_o), a_ohlc, [:Open, :High, :Low, :Close])
end


function random_ohlcv(rng::AbstractRNG = Random.GLOBAL_RNG;
    start = Dates.DateTime(2020, 1, 1),
    step = Dates.Hour(1),
    sub_step = Dates.Minute(1),
    length = 500,
    price_init = nothing,
    price_init_min = 1.00,
    price_init_step = 0.01,
    price_init_max = 1000.00,
    price_var_min = -1.0,
    price_var_step = 0.01,
    price_var_max = 1.0,
    vol_init_min = 0.0,
    vol_init_step = 0.1,
    vol_init_max = 100.0,
)
    ta_ohlc = random_ohlc(rng;
        start = start,
        step = step,
        sub_step = sub_step,
        length = length,
        price_init = price_init,
        price_init_min = price_init_min,
        price_init_step = price_init_step,
        price_init_max = price_init_max,
        price_var_min = price_var_min,
        price_var_step = price_var_step,
        price_var_max = price_var_max
    )
    ta_vol = random_vol(rng;
        start = start,
        step = step,
        length = Base.length(ta_ohlc),
        vol_init_min = vol_init_min,
        vol_init_step = vol_init_step,
        vol_init_max = vol_init_max,
    )
    hcat(ta_ohlc, ta_vol)
end
