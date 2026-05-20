---
name: bmstu-lab-report
description: Build BMSTU-style university laboratory work and reports from methodical PDFs, task statements, screenshots, and existing examples. Use when Codex must parse a lab, implement the practical work, collect validation artifacts, prepare screenshots, or create DOCX/PDF reports with GOST-like BMSTU formatting. Do not answer control questions unless explicitly requested.
---

# BMSTU Lab Report

Use this skill to complete university laboratory work end to end: understand the methodical PDF, implement the practical part, collect evidence, and assemble a polished BMSTU-style report.

## Core Rules

- Use the methodical materials as the source of truth. If an example report conflicts with the methodical PDF, follow the PDF unless the user says otherwise.
- Do not fabricate results. If a command, validator, screenshot, endpoint, or UI state was not actually observed, run it or ask the user for the missing artifact.
- Copy the lab goal and lab assignment exactly from the methodical PDF when they are present. If they are absent, formulate concise versions and say they were formulated manually.
- The last semantic section must be named `Вывод`, never `Заключение`.
- Before inserting a title page or assignment blank, ask whether the user wants that page inserted at all. If yes, ask whether it should be filled automatically.
- Ask for missing title-page data before report generation when it cannot be inferred: student full name, group, teacher full name, discipline, lab number, lab title, year, faculty/department, supervisor, and consultant if relevant.
- If stable title-page data is already known from prior project context, offer it as a proposed default and ask the user to confirm before writing it into a template. After confirmation, record the reusable data in the project notes or memory file when available; never hard-code personal data into this shared skill.
- Keep generated artifacts organized in a lab-specific folder.

## Self-Improvement Rule

When the user says the agent made a repeatable formatting, wording, workflow, or report-structure mistake, update this skill so the correction is remembered for future chats.

Follow this protocol:

1. Extract the durable rule from the correction. Store generalized formatting/workflow rules, not one-off content.
2. Edit this `SKILL.md` in the active installed skill folder when possible.
3. Apply the correction to the current report/code/artifacts if relevant.
4. Re-run the skill validator (`quick_validate.py`) after editing the skill.
5. Tell the user what rule was added or changed.

Examples of corrections that must update the skill:

- User: “`рисунок` надо всегда с большой буквы.” Add or reinforce: figure captions start with uppercase `Рисунок`.
- User: “Последний блок должен называться `Вывод`, а не `Заключение`.” Add or reinforce the final-section rule.
- User: “Листинг 1 пишется перед кодом, а при переносе нужна строка `Продолжение листинга 1`.” Add or reinforce the listing rule.
- User: “Перед каждым рисунком нужен вводный абзац.” Add or reinforce the figure-introduction rule.

If the installed skill folder is not writable, request permission to edit it or provide a patch the user can apply. Do not silently keep the correction only in conversation memory.

## Working Folder

Use a folder named after the lab and topic, for example:

```text
labN_topic/
├── src/ or server/              # source code, notebooks, local services
├── artifacts/
│   ├── raw_screenshots/         # original user screenshots
│   ├── report_images/           # cropped/processed images for report
│   └── validation/              # validator output, command logs, raw responses
├── report/
└── notes.md                     # exact goal/task, decisions, remaining gaps
```

Preserve raw user screenshots. Make cropped copies for the report.

## Intake Workflow

When the user provides a methodical PDF or asks to start a lab:

1. Identify lab number, title, discipline, goal, practical assignment, control questions, expected deliverables, and required tools.
2. Read provided example reports only for structure and formatting conventions, not for copying another student's content.
3. Tell the user what must be done and whether any user-side action is needed.
4. If no user-side action is needed and the user asked for automation, implement the lab, collect artifacts, and create the report in one pass.

Ask the user only when a required action cannot be done locally, such as authentication, GUI-only university software, manual Postman screenshots, browser DevTools screenshots that cannot be produced with available automation, or missing title-page data.

## Doing The Lab

- Do as much locally as possible: code, terminal commands, validation, generated terminal screenshots, image cropping, report assembly.
- For local servers, check whether the required port is free. If occupied, choose a nearby free port and use it consistently in screenshots, text, and the report.
- Record exact commands, URLs, inputs, outputs, and validation results in `notes.md` or raw artifacts.
- For code labs, run tests or at least representative executions. Save command output and include proof in the report.
- For web/HTML/CSS labs, validate generated HTML/CSS when applicable and save raw validator results.
- For HTTP/API labs, collect request and response evidence: method, URL, request headers/body when applicable, response status, response headers, and response body.

## Screenshots And Evidence

- Terminal screenshots may be generated by the agent if they faithfully reproduce actual command output.
- Browser screenshots may be generated by automation when possible. Ask the user only when manual GUI evidence is required.
- Crop away empty desktop space, unrelated sidebars, personal notifications, and repeated UI chrome unless it proves the action.
- Preserve enough context: URL, method, status code, selected tab, relevant request/response body, validator result, or command output.
- Do not insert redundant screenshots. Prefer fewer screenshots with clear explanatory text.

## Report Structure

Use this default order unless the methodical PDF or user-provided example clearly requires otherwise:

1. Title page.
2. `Цель работы`.
3. `Задание`.
4. Main execution sections with explanations, figures, tables, and listings.
5. Listings when useful or required.
6. `Вывод`.

Do not answer control questions in the report or final deliverable unless the user explicitly asks for answers; control questions may be listed as questions only or used internally for defense preparation.

The report must read as a continuous explanation, not as a pile of screenshots. Add a short introductory paragraph before every figure, table, and listing. Add a short interpretation after important figures when the result is not obvious or the page feels sparse.

## Coursework RПЗ Mode

Use this mode when the user asks for a `расчетно-пояснительная записка`, `РПЗ`, course work report, or course project explanatory note.

- Treat ГОСТ 7.32 and the user's example RПЗ files as formatting references. Prefer the university examples for title-page wording and local department conventions when they do not conflict with the assignment.
- Do not recreate the title page from scratch when a suitable example RПЗ is provided. Copy the first page/title section from the example document as an intact page and edit only the variable fields when necessary. Rebuilding the title page manually is a last resort.
- Use the typical structure: title page, `РЕФЕРАТ`, optional `ПЕРЕЧЕНЬ СОКРАЩЕНИЙ И ОБОЗНАЧЕНИЙ`, `СОДЕРЖАНИЕ`, `ВВЕДЕНИЕ`, numbered main sections, `ЗАКЛЮЧЕНИЕ`, `СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ`, optional appendices.
- For machine-learning course work, organize the main sections around: domain/problem analysis, data preparation and EDA, model/design implementation, testing and result analysis.
- The final semantic section for coursework is usually `ЗАКЛЮЧЕНИЕ`, not lab-style `Вывод`, unless the user's methodical material explicitly requires `Вывод`.
- In the abstract, include report volume, number of figures/tables/listings/sources, 5-15 uppercase keywords, object, goal, methods, results, and application area.
- Explain how the practical artifact works: data sources, feature table construction, validation scheme, model comparison, final model, metrics, and reproducibility.
- Do not overfill the RПЗ with notebook infrastructure details. Mention notebooks, scripts, caches, and runtime only when they matter for reproducibility or evaluation.
- Include source citations in the order of first mention. Use short, verifiable source titles and URLs where available.
- Make `СОДЕРЖАНИЕ` as a real Word table-of-contents block (`Оглавление`/TOC field), not a manually typed imitation, unless the user explicitly requests a static text contents page. The visible contents text should use Times New Roman 14 pt.
- Use Times New Roman 14 pt inside coursework RПЗ table cells unless the user explicitly allows a smaller table font or the provided department template uses another size.
- Prevent bad table page breaks: table caption and the table must stay on the same page; table rows must not split across pages; a table must not be left with only a few rows on one page and the rest on the next. If a table cannot fit in the remaining space, move the caption and whole table to a new page; if it cannot fit on a fresh page, split it deliberately into separate tables with repeated captions/headers.
- Never place two non-text elements back-to-back. Before every table, figure, or listing add a short lead-in paragraph; after every important table, figure, or listing add a short interpretation. This includes transitions between a table and a figure.
- Start a new major chapter on a new page only when the current page is already more than about two-thirds full or when the methodical/example document explicitly requires chapter page breaks. If the previous chapter ends around the first third or middle of a page, continue the next chapter on the same page instead of leaving a large blank area.

### Дополнительные сведения из ГОСТ 7.32-2017

Применяй эти правила как дополнительные для РПЗ, если они не конфликтуют с заданием, примером БМСТУ или явными правками пользователя. Если ГОСТ требует начинать каждый раздел с новой страницы, всё равно используй локальное правило про заполнение страницы больше чем на две трети, если только шаблон кафедры или пользователь не требуют строгого переноса.

- Формат: A4, односторонняя печать, черный текст, Times New Roman как предпочтительный шрифт основного текста, межстрочный интервал 1.5, поля 30 мм слева, 15 мм справа, 20 мм сверху и снизу, единый абзацный отступ 1.25 см.
- Титульный лист входит в общую нумерацию страниц, но номер на нем не печатается. Предпочитай копировать корректный шаблон титульного листа БМСТУ и менять только переменные поля.
- Полная структура может включать титульный лист, список исполнителей, реферат, содержание, термины и определения, сокращения и обозначения, введение, основную часть, заключение, список источников и приложения. Для студенческой РПЗ `СПИСОК ИСПОЛНИТЕЛЕЙ` обычно не нужен, если его не требует шаблон или преподаватель.
- Реферат должен содержать объем отчета, число рисунков/таблиц/листингов/источников/приложений, 5-15 ключевых слов прописными буквами и короткий текст про объект, цель, методы, результаты, область применения и значимость работы. Держи реферат в пределах одной страницы.
- `СОДЕРЖАНИЕ` включает введение, все именованные разделы и подразделы, заключение, источники и приложения с номерами начальных страниц. Записи оформляются отдельными абзацами, номера страниц выравниваются справа и соединяются с заголовками отточием.
- Во введении нужно обосновать актуальность, описать состояние вопроса или исходные данные, цель, задачи и необходимость работы. Не выдумывай патентные, метрологические или внедренческие детали, если они не относятся к курсовой.
- Основная часть должна показывать выбранное направление, методы, ход эксперимента или реализации, результаты, оценку полноты решения, сравнение с аналогами или существующими работами, а также отрицательные результаты, если они важны для выводов.
- Заключение содержит краткие итоги, оценку выполнения задач, рекомендации по использованию и сравнение или оценку эффективности, если это применимо. Не добавляй в заключение новые экспериментальные факты.
- Заголовки структурных элементов вроде `РЕФЕРАТ`, `СОДЕРЖАНИЕ`, `ВВЕДЕНИЕ`, `ЗАКЛЮЧЕНИЕ`, `СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ`, `ПРИЛОЖЕНИЕ` располагаются по центру, прописными буквами, без точки. Заголовки нумерованных разделов и подразделов начинаются с абзацного отступа, содержат номер, выделяются полужирным и не имеют точки в конце.
- Страницы нумеруются сквозной арабской нумерацией по центру нижней части страницы. Приложения входят в общую нумерацию, если не оформлены отдельным самостоятельным документом.
- Разделы нумеруются арабскими цифрами без точки в конце номера. Подразделы нумеруются внутри раздела, например `2.1`, также без точки после последней цифры. Если в разделе или подразделе только один пункт, не создавай единственный нумерованный пункт ради формальности.
- Перечисления можно оформлять через тире, строчные буквы со скобкой или арабские цифры со скобкой. Простые элементы допускается разделять запятыми, сложные лучше разделять точками с запятой. Формат списков должен быть единообразным.
- Рисунки размещаются после первого упоминания или на следующей странице, как можно ближе к связанному тексту. На каждый рисунок должна быть ссылка в тексте. Подпись идет под рисунком по центру в формате `Рисунок 1 - Название`, без точки в конце.
- Таблицы размещаются после первого упоминания или на следующей странице. На каждую таблицу должна быть ссылка в тексте. Подпись идет над таблицей слева без абзацного отступа в формате `Таблица 1 - Название`, без точки в конце.
- Если длинную таблицу действительно нужно разделить, над каждой продолженной частью пиши `Продолжение таблицы N` и повторяй или однозначно сохраняй структуру заголовков. Случайных разрывов избегай: переноси таблицу целиком на свежую страницу или дели ее на отдельные смысловые таблицы.
- Заголовки граф и строк таблицы начинаются с прописной буквы. Подзаголовки начинаются со строчной, если продолжают заголовок, и с прописной, если имеют самостоятельное значение. В конце заголовков и подзаголовков таблиц точки не ставятся.
- Примечания размещаются сразу после текста, таблицы или рисунка, к которым относятся. Одно примечание оформляется как `Примечание - ...`; несколько примечаний нумеруются. Сноски располагаются внизу той же страницы.
- Формулы и уравнения размещаются отдельными строками по центру с интервалами выше и ниже. Номера формул ставятся справа в круглых скобках. Пояснения идут ниже в порядке появления символов и начинаются со слова `где` без двоеточия.
- Ссылки на источники оформляются номерами в квадратных скобках, например `[1]` или `[1] - [4]`. Список источников располагается в порядке первого упоминания и нумеруется арабскими цифрами с точкой.
- Приложения должны иметь ссылки в тексте и располагаться в порядке этих ссылок. Каждое приложение начинается с новой страницы с центрированным `ПРИЛОЖЕНИЕ А`; заголовок приложения пишется отдельной центрированной полужирной строкой, с прописной буквы и без точки. Используй буквы кириллицы, кроме `Ё`, `З`, `Й`, `О`, `Ч`, `Ъ`, `Ы`, `Ь`; если приложение одно, называй его `ПРИЛОЖЕНИЕ А`.

## Title Page Assets

Prefer copying a known-good BMSTU title page as a whole page because logos, fonts, and layout can break if recreated manually. Do not rely on bundled title-page assets unless the repository explicitly includes a sanitized blank template. Never publish or reuse a title-page template that contains another student's personal data.

This repository includes sanitized blank templates:

- `assets/lab/title_lab_new.docx` - newer laboratory title-page template;
- `assets/lab/title_lab_old.docx` - older laboratory title-page template;
- `assets/coursework/rpz_title_no_consultant.docx` - coursework RПЗ title page without a consultant line;
- `assets/coursework/rpz_title_with_consultant.docx` - coursework RПЗ title page with a consultant line;
- `assets/coursework/coursework_assignment_blank_2026.docx` - 2026 coursework assignment blank.

For laboratory reports, if the user wants a title page inserted and did not specify the template, ask whether to use the old or new lab template. Explain briefly that both variants are usually accepted, the choice is minor, and the option exists only to match the preferred local style. Ask whether to fill the template; if yes, collect or confirm: student full name or initials format, group, discipline, teacher, lab number, lab title, year, faculty, department, and training direction when the selected template needs them.

For coursework RПЗ, ask whether there is a consultant. If yes, use `rpz_title_with_consultant.docx`; otherwise use `rpz_title_no_consultant.docx`. Ask separately whether to insert and fill the coursework assignment blank. If the user wants it filled, collect or confirm: course discipline, student group, student full name, topic, work type/direction, source of topic, technical assignment text, supervisor, consultant if any, issue date, and year. Use 2026 as the default year for the bundled templates unless the user gives another year.

When the user has already mentioned stable fields such as group, full name, department, discipline, or teacher in the current project, do not ask from scratch. Say which values were found, ask whether they are correct, and then reuse them. If the user confirms, store them in the project working notes when such a file exists.

If no safe bundled template exists for the needed document type, ask the user for a clean title-page template or a prior report they are allowed to reuse. When a user-provided template is available, copy the title page as an intact page and edit only the variable fields needed for the current report. Preserve stable faculty/department wording from the template unless the user provides replacements.

Before committing or sharing any template asset, inspect it for personal data: full names, signatures, group numbers, teacher names, emails, phone numbers, hidden comments, tracked changes, and document metadata. If it is not clearly sanitized, do not commit it.

Never commit filled title pages or filled assignment blanks to the public skill repository. Shared assets must remain blank templates.

## Formatting Rules

- Body text: Times New Roman, 14 pt, justified alignment, first-line indent about 1.25 cm, 1.5 line spacing unless the provided example requires otherwise.
- Headings: use heading styles, not the `Обычный` style. Make headings black, bold, left-aligned.
- Page numbers: centered at the bottom of the page.
- Figure captions: place below the image and start with uppercase `Рисунок`, preferably using a ГОСТ-style dash, for example `Рисунок 1 — результат GET-запроса`.
- Tables: add a short introduction before the table and put the table caption above it, for example `Таблица 1 — параметры эксперимента`. Use consistent borders and readable font size.
- Lists: before a generated list, add an introductory sentence ending with a colon. List items should start with lowercase letters. End each item with a semicolon except the last, which ends with a period.
- Methodical assignment text may preserve the PDF's original bullet style when copied verbatim.
- Avoid orphaned fragments and lonely trailing paragraphs. If a new major section would start near the bottom after the previous section fills most of the page, start the major section on a new page. Do not force every subsection onto a new page.

## Listings

- Put the listing title before the code, for example `Листинг 1`.
- If the listing continues on a new page, write `Продолжение листинга 1` (or the corresponding listing number) at the beginning of the continued fragment on that new page.
- Use a monospaced font and a smaller but readable size for code.
- Put code in a rectangular frame with a black border when the document tooling supports it reliably.
- If exact listing formatting is unknown, follow the closest provided example and mark the formatting as a point for later refinement.

## Writing Style

- Use formal Russian report style with simple sentences.
- Avoid filler such as “на рисунке можно увидеть” when a more meaningful explanation is possible.
- Make the practical narrative traceable: say what was run, what returned, what validator reported, and what result proves.
- For conclusions, summarize what was done and what skill/result was obtained. Do not introduce new facts in `Вывод`.

## DOCX/PDF Workflow

When creating or editing `.docx`, use the available document workflow:

1. Generate or update the `.docx`.
2. Render it to page images with the document renderer when available.
3. Inspect the rendered pages visually: title page, figure pages, listing pages, and conclusion page. Always check the page images after finishing the report and before delivery.
4. Iterate until layout issues are fixed.
5. Export `.pdf` only after the `.docx` render is acceptable.

If rendering fails because LibreOffice/`soffice` is missing, perform structural checks and Quick Look or equivalent fallback preview, then clearly disclose that full render QA could not be completed.

Before delivery, check:

- title page fields are correct;
- `Цель работы` and `Задание` match the methodical PDF;
- final section is `Вывод`;
- page numbers are centered;
- figure captions use uppercase `Рисунок`;
- each figure/table/listing has introductory text;
- listings have titles and continuation labels when split;
- screenshots are cropped cleanly and show relevant evidence;
- validation/test results are included when required;
- no temporary lock files are presented as deliverables.

## Common Lab Patterns

HTTP/API labs:

- explain DNS, URL, request/response structure, methods, headers, body, and status code classes;
- collect DNS output when required;
- include successful and failing local service cases;
- show request and response evidence.

HTML/CSS labs:

- extract mockups from PDF when present;
- build required structure before beautifying;
- use required HTML elements and form controls;
- validate HTML/CSS and save raw validator output;
- include mockup, rendered result, validation evidence, and listing.

JavaScript/Python/code labs:

- implement requirements directly from the methodical PDF;
- add representative tests or executions;
- save terminal logs;
- generate terminal screenshots from actual logs when useful;
- do not answer control questions in the report unless explicitly requested; if requested separately, answer them in easy-to-memorize language.

## Control Questions And Defense

When the practical part is complete, do not add answers to control questions by default. Prepare concise answers or a short defense script only when the user explicitly requests them.

Good answers:

- define the concept in one sentence;
- list the key parts;
- connect the concept to what was done in the lab;
- mention the observed result.

## Delivery

At the end, provide:

- final `.docx` path;
- final `.pdf` path if generated;
- short verification note;
- missing user screenshots or unresolved assumptions, if any.

Keep the final response concise. Do not dump raw logs unless the user asks.
