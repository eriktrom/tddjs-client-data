Date::strftime = (->
  strftime = (format) ->
    date = this
    (format + "").replace(/%([a-zA-Z])/g, (m, f) ->
      formatter = Date.formats and Date.formats[f]
      if typeof formatter is "function"
        return formatter.call(Date.formats, date)
      else if typeof formatter is "string"
        return date.strftime(formatter)
      f
    )
  zeroPad = (num) ->
    ((if +num < 10 then "0" else "")) + num

  Date.formats =
    d: (date) ->
      zeroPad(date.getDate())

    m: (date) ->
      zeroPad(date.getMonth() + 1)

    y: (date) ->
      zeroPad(date.getYear() % 100)

    Y: (date) ->
      date.getFullYear()

    F: "%Y-%m-%d"
    D: "%m/%d/%y"

  strftime
)()