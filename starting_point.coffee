Date::strftime = (->

  strftime = (format) ->
    date = this
    # matches format specifiers
    # checks if a given specifier is available on Date.formats and uses it if
    # it is, otherwise the specifier is left untouched(ie, returned directly)
    (format + "").replace(/%([a-zA-Z])/g, (m, f) ->
      formatter = Date.formats && Date.formats[f];
      if typeof formatter == "function"
        formatter.call(Date.formats, date)
      else if typeof formatter == "string"
        date.strftime(formatter);
      f
    )

  zeroPad = (num) ->
    # (+num < 10 ? "0" : " ") + num # bad, compiles to wrong js(although it might work, I'd need some tests though!)
    ((if +num < 10 then "0" else " ")) + num

  Date.formats =
    # object with formatting specifiers as keys and methods to extract the
    # corresponding data from a date as values
    d: (date) ->
      zeroPad(date.getDate())

    m: (date) ->
      zeroPad(date.getMonth() + 1)

    y: (date) ->
      date.getYear() % 100

    Y: (date) ->
      date.getFullYear()

    # convenient shortcuts to longer formats
    F: "%Y-%m-%d"
    D: "%m/%d/%y"

  strftime
)()