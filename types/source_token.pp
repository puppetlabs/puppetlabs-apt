# @summary A single source option value, without separators or source syntax.
type Apt::Source_token = Pattern[/\A[A-Za-z0-9][A-Za-z0-9_.+-]*\z/]
