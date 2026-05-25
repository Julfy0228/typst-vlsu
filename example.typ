#import "lib.typ": template
#import "frame/utils.typ": frame
#import "frame/config.typ": tables

#let frame-fields = (
  _title: [ ВлГУ.09.03.02.17.00.00 ],
  _description: [
    Информационная система\
    "..."\
    Пояснительная записка
  ],
  _group: [ИСТ-123],
  _developed: [И. И. Иванов],
  _checked: [Г. В. Проскурина],
  _technical_controlled: [],
  _standard_controlled: [],
  _approved: [],
)

#show: template.with(
  title: [ Пояснительная записка ],
  discipline: [
    к курсовому проекту по дисциплине \
    "Название дисциплины" \
    на тему
  ],
  theme: [ Проектирование и разработка информационной системы \ "Информационная система" ],
  students: (
    (
      name: "И. И. Иванов",
      group: "ИСТ-123",
      gender: "male"
    ),
    (
      name: "П. П. Петров",
      group: "ПРИ-123",
      gender: "male"
    )
  ),
  teacher: (
    name: "Г. В. Проскурина",
    position: "доц. каф. ИСПИ",
    gender: "female"
  ),
)

#heading([ Аннотация ], outlined: false)

Пояснительная записка содержит описание проектирования и разработки информационной системы "Информационная система" — ...

В документе представлены: анализ предметной области, ...

Система реализована на ...

Пояснительная записка содержит #context(counter(page).final().first()) страниц, #context(counter(image).final().first()) рисунков, #context(counter(table).final().first()) таблиц.

#heading([ Abstract ], outlined: false)

The explanatory note describes the design and development of the information system. "Information System" ...

The document presents: an analysis of the subject area, ...

The system is implemented using ...

The explanatory note contains #context(counter(page).final().first()) pages, #context(counter(image).final().first()) figures, #context(counter(table).final().first()) tables.
#pagebreak()

#show: frame.with(frame-fields, table: tables.form-2)
#outline(
  title: [Содержание],
  depth: 2
)
#pagebreak()

#show: frame.with(frame-fields, table: tables.form-2a)
= Введение
...

= Описание предметной области
...

= Заключение

В ходе выполнения курсового проекта была разработана информационная система "Информационная система", которая позволяет ...

= Список использованных источников

+ Книга: С. В. Иванов, "Название книги", Издательство, 2025.

+ Интернет-ресурс: "Название статьи". — URL: https://example.com/article (дата обращения: 01.01.2026).
