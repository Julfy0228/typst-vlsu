#let get-value(data, key, default: none) = {
  if key in data { data.at(key) } else { default }
}

#let resolve-frame-mode(frame, page-num) = {
  if frame == false or frame == "none" {
    "none"
  } else if frame == true or frame == "frame" {
    "frame"
  } else if frame == "big" or frame == "big-table" {
    "big-table"
  } else if frame == "small" or frame == "small-table" {
    "small-table"
  } else if frame == "auto" {
    if page-num == 1 {
      "none"
    } else if page-num <= 3 {
      "big-table"
    } else {
      "small-table"
    }
  } else {
    frame
  }
}

#let should-draw-item(item, show-technical-control) = {
  let hidden-when = get-value(item, "hidden-when", default: none)
  if hidden-when == "technical-control" and not show-technical-control {
    false
  } else {
    true
  }
}

#let draw-frame-cell(cell, table, fields) = {
  let text-value = get-value(cell, "text", default: [])
  let body = if type(text-value) == str and text-value in fields {
    fields.at(text-value)
  } else {
    text-value
  }

  let cell-align = get-value(cell, "align", default: center)

  place(
    top + left,
    dx: table.x + cell.x,
    dy: table.y + cell.y,
    rect(
      width: cell.width,
      height: cell.height,
      stroke: get-value(cell, "stroke", default: 0.5pt),
      fill: none,
      inset: 1mm,
      align(horizon + cell-align, text(font: "ГОСТ тип А", style: "italic", size: get-value(cell, "text-size", default: table.text-size), body)),
    )
  )
}

#let draw-frame-line(line-data, table) = {
  place(
    top + left,
    dx: table.x,
    dy: table.y,
    line(
      start: (line-data.x1, line-data.y1),
      end: (line-data.x2, line-data.y2),
      stroke: get-value(line-data, "stroke", default: 1pt),
    )
  )
}

#let draw-frame-table(table, fields, show-technical-control) = {
  for cell in table.cells {
    if should-draw-item(cell, show-technical-control) {
      draw-frame-cell(cell, table, fields)
    }
  }

  for line-data in get-value(table, "lines", default: ()) {
    if should-draw-item(line-data, show-technical-control) {
      draw-frame-line(line-data, table)
    }
  }
}

#let draw-frame(mode, config, fields, show-technical-control) = {
  let outer = config.outer

  if mode != "none" {
    place(
      top + left,
      dx: outer.x,
      dy: outer.y,
      rect(
        width: outer.width,
        height: outer.height,
        stroke: outer.stroke,
        fill: none,
      )
    )
  }

  if mode == "big-table" {
    draw-frame-table(config.form-2, fields, show-technical-control)
  } else if mode == "small-table" {
    draw-frame-table(config.form-2a, fields, show-technical-control)
  }
}

#let render-frame(frame, config, fields, show-technical-control: false) = context {
  let page-num = counter(page).get().first()
  let mode = resolve-frame-mode(frame, page-num)
  let resolved-fields = fields + (
    page: [#counter(page).display()],
    pages: [#counter(page).final().first()],
  )
  draw-frame(mode, config, resolved-fields, show-technical-control)
}
