
cleanup_colname!(ta::TimeArray) =
  rename!(s -> replace(s, r"[. -]" => ""), ta, String)
