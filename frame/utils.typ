#import "config.typ": *

#let get-value(data, key, default: none) = {
  if key in data { data.at(key) } else { default }
}

#let frame-cell-text(cell, body) = context {
  text(
    font: ("ГОСТ тип А", "Times New Roman"),
    style: "italic",
    size: get-value(
      cell,
      "text-size",
      default:  3.5mm
    ),
    body
  )
}

#let draw-frame-cell(cell-data, table, fields, origin) = {
  let text-value = get-value(cell-data, "text", default: [])
  let body = if type(text-value) == str {
    if text-value.starts-with("_") and text-value in fields {
      fields.at(text-value)
    }
  } else {
    text-value
  }

  let cell-align = get-value(cell-data, "align", default: center)

  place(
    top + left,
    dx: origin.x + cell-data.x,
    dy: origin.y + cell-data.y,
    rect(
      width: cell-data.width,
      height: cell-data.height,
      stroke: get-value(cell-data, "stroke", default: thin-stroke),
      fill: none,
      inset: 1mm,
      align(horizon + cell-align, frame-cell-text(cell-data, body)),
    )
  )
}

#let draw-frame-line(line-data, table, origin) = {
  place(
    top + left,
    dx: origin.x,
    dy: origin.y,
    line(
      start: (line-data.x1, line-data.y1),
      end: (line-data.x2, line-data.y2),
      stroke: get-value(line-data, "stroke", default: 1pt),
    )
  )
}

#let draw-table(table, fields) = {
  let origin = (
    x: if page.flipped {
      page.height - table.width - 5mm
    } else {
      page.width - table.width - 5mm
    },
    y: if page.flipped {
      page.width - table.height - 5mm
    } else {
      page.height - table.height - 5mm
    },
  )

  for cell-data in table.cells {
    draw-frame-cell(cell-data, table, fields, origin)
  }

  for line-data in table.lines {
    draw-frame-line(line-data, table, origin)
  }
}

#let render-frame(fields) = context {
  let page-num = counter(page).get().first()
  if page-num <= 2 { return }

  place(
    top + left,
    dx: 20mm,
    dy: 5mm,
    rect(
      width: 
        if page.flipped {
          page.height - 25mm
        } else {
          page.width - 25mm
        },
      height:
        if page.flipped {
          page.width - 10mm
        } else {
          page.height - 10mm
        },
      stroke: thick-stroke,
      fill: none,
    )
  )

  let numbering = (
    _page: [#counter(page).display()],
    _pages: [#counter(page).final().first()],
  )
  if page-num == 3 {
    draw-table(tables.form-2, fields + numbering)
  } else {
    draw-table(tables.form-2a, fields + numbering)
  }
}
