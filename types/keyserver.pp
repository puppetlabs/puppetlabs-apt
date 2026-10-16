# @summary A keyserver host, or a URL to one using the hkp, hkps, http or https scheme
type Apt::Keyserver = Variant[
  Stdlib::Host,
  Pattern[/\A((hkp|hkps|http|https):\/\/)?([a-z\d])([a-z\d-]{0,61}\.)+[a-z\d]+(:\d{2,5})?(\/[a-zA-Z\d\-_.]+)*\/?$/],
]
