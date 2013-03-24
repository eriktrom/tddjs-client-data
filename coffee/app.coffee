Date::strftime = (->
  strftime = (format) ->
    date = this
    (format + "").replace /%([a-zA-Z])/g, (m, f) ->
      formatter = Date.formats and Date.formats[f]
      if typeof formatter is "function"
        return formatter.call(Date.formats, date)
      else return date.strftime(formatter)  if typeof formatter is "string"
      f


  # Internal Helper
  zeroPad = (num) ->
    ((if +num < 10 then "0" else "")) + num
  Date.formats =

    # formatting methods
    d: (date) ->
      zeroPad date.getDate()

    m: (date) ->
      zeroPad date.getMonth() + 1

    y: (date) ->
      zeroPad date.getYear() % 100

    Y: (date) ->
      date.getFullYear()


    # Format shorthands
    F: "%Y-%m-%d"
    D: "%m/%d/%y"

  strftime
)()