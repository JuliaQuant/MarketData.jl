import TimeSeries.TimeArray


struct APIResponse
    data::String
    http_resp::HTTP.Messages.Response
end


"""
Description

    The yahoo() method is a wrapper for downloading historical stock prices from Yahoo.

Usage

    AAPL = yahoo("AAPL)
    SPX = yahoo()

Method Signature(s)

    yahoo(data::ASCIIString="^GSPC")

Details

    The yahoo method takes a stock name in the form of a string and returns a TimeSeries.TimeArray data structure
    corresponding to the Yahoo Finance ticker. With no argument, the default historical time series is the S&P 500.

References

    http://www.finance.yahoo.com

See Also

    fred() which accesses the St. Louis Federal Reserve financial and economic data sets.
"""
function yahoo(data::String="^GSPC")
    Base.depwarn("Yahoo Finance API changed, this function may not work anymore", :yahoo)
    url = "http://ichart.yahoo.com/table.csv?s=$data"
    http_resp = HTTP.request("GET", url)
    resp = APIResponse(data, http_resp)
    TimeArray(resp)
end

"""
Description

    The fred() method is a wrapper to download financial and economic time series data from the St. Louis Federal Reserve (FRED).

Usage

    DGS = fred("DGS10")
    CPI = fred()

Method Signature(s)

    fred(data::String="CPIAUCNS")

Details

    The fred() method takes a string argument that corresponds to a series code from the St. Louis Federal
    Reserve (FRED) database. It returns the data in the TimeSeries.TimeArray data structure.  When no argument
    is provided, the default data set is the Consumer Price Index for All Urban Consumers: All Items (CPIAUCNS).

References

    https://research.stlouisfed.org/fred2

See Also

    yahoo() which is a wrapper from downloading financial time series for stocks from Yahoo Finance.
"""
function fred(data::String="CPIAUCNS")
    url = "http://research.stlouisfed.org/fred2/series/$data/downloaddata/$data.csv"
    http_resp = HTTP.request("GET", url)
    resp = APIResponse(data, http_resp)
    TimeArray(resp)
end


function TimeArray(resp::APIResponse)
    #This function transform the Response object into a TimeArray
    # Split the data on every "\n"
    raw_data = String(resp.http_resp.body)
    data = split(raw_data, "\n")
    # Extract the head and body of the data
    head = strip(data[1])
    body = data[2:end]
    # Parse body
    body[end] == "" ? pop!(body) : nothing # remove trailing empty string if it's there
    body      = [split(line, ",") for line in body] # split on comma
    ######### Timestamp
    # take the first row (assuming it's date)
    # TODO: regex query needed to catch edge cases
    dates     = [line[1] for line in body]
    timestamp = Date[Date(d) for d in dates] # parse dates
    ######### Values
    svals = [line[2:end] for line in body] # get rows 2 to the end
    fvals = zeros(length(svals),length(svals[1]))
    for r in 1:size(fvals,1)
        for c in 1:size(fvals,2)
            # is not empty and is not equal to FRED's iconic "." sentinel for missingness
            if ~isempty(svals[r][c]) && ~isequal(svals[r][c],".\r")
            fvals[r,c] = parse(Float64, svals[r][c])
            else
            # captures FRED's "." sentinel
            fvals[r,c] = NaN
            end
        end
    end
    ######### Column names
    names = split(head, ",")[2:end] # Won't need the Date name (fist column) for TimeArray
    names = String[name for name in names]
    return TimeArray(timestamp, fvals, names, resp.data)
end

