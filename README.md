# BMSTU Lab Report Skill

Скилл для Codex и Claude Code, который помогает готовить отчеты, лабораторные работы и расчетно-пояснительные записки в стиле МГТУ им. Н. Э. Баумана.

Скилл хранится как обычная папка с `SKILL.md` и дополнительными файлами. Такой формат удобен для Git: его можно клонировать, обновлять через `git pull` и шарить между одногруппниками.

## Что внутри

```text
bmstu-lab-report-skill/
├── SKILL.md
├── assets/
│   ├── coursework/
│   │   ├── coursework_assignment_blank_2026.docx
│   │   ├── rpz_title_no_consultant.docx
│   │   └── rpz_title_with_consultant.docx
│   └── lab/
│       ├── title_lab_new.docx
│       └── title_lab_old.docx
└── agents/
    └── openai.yaml
```

`SKILL.md` содержит основные правила работы. В `assets/` лежат обезличенные шаблоны титульных листов и бланк задания для курсача. Их можно использовать как основу, но заполненные титульники и задания не нужно коммитить обратно в этот публичный репозиторий.

Для лабораторных есть два варианта титульного листа: старый и новый. Обычно принимают оба, поэтому выбор не принципиальный; он нужен только для совпадения с привычным стилем кафедры или преподавателя.

Для РПЗ есть два титульника: с консультантом и без консультанта. Если у курсовой есть консультант, skill должен выбрать версию с дополнительной строкой.

Бланк задания 2026 года лежит отдельно. Его стоит вставлять и заполнять только если пользователь явно просит добавить задание к курсовой работе.

## Установка в Codex

OpenAI описывает skill как повторяемый workflow в Markdown-файле `SKILL.md`, который Codex может использовать как “playbook”. В Codex skill можно вызвать явно через `$` в чате или выбрать в интерфейсе Skills.

Практический вариант установки из этого репозитория:

```bash
mkdir -p ~/.codex/skills
git clone git@github.com:Rcinderblock/bmstu-lab-report-skill.git ~/.codex/skills/bmstu-lab-report
```

После установки перезапусти Codex, если skill не появился сразу.

Вызов:

```text
$bmstu-lab-report Сделай отчет по методичке ...
```

Обычно достаточно одного корректного расположения, где внутри папки skill лежит файл `SKILL.md`.

## Установка в Claude Code

По документации Claude Code пользовательские skills лежат в `~/.claude/skills/<skill-name>/SKILL.md` для персональной установки или в `.claude/skills/<skill-name>/SKILL.md` внутри проекта.

Персональная установка:

```bash
mkdir -p ~/.claude/skills
git clone git@github.com:Rcinderblock/bmstu-lab-report-skill.git ~/.claude/skills/bmstu-lab-report
```

После этого запусти Claude Code:

```bash
claude
```

Вызов skill:

```text
/bmstu-lab-report Сделай отчет по методичке ...
```

Claude Code также может подключить skill автоматически, если запрос совпадает с `description` в `SKILL.md`.

Проектная установка, если skill должен быть доступен только внутри одного репозитория:

```bash
mkdir -p .claude/skills
git clone git@github.com:Rcinderblock/bmstu-lab-report-skill.git .claude/skills/bmstu-lab-report
```

Если папка `.claude/skills` появилась уже после запуска Claude Code, лучше перезапустить `claude`, чтобы watcher точно увидел новую директорию.

## Установка в claude.ai

Для claude.ai custom skill обычно загружается как ZIP-архив. Важно, чтобы внутри архива корнем была папка skill, а не просто набор файлов.

Пример:

```bash
cd ~/.claude/skills
zip -r bmstu-lab-report.zip bmstu-lab-report
```

Дальше ZIP можно загрузить в Claude через настройки Skills, если аккаунт и тариф поддерживают custom skills.

## Обновление

Codex:

```bash
cd ~/.codex/skills/bmstu-lab-report
git pull
```

Claude Code:

```bash
cd ~/.claude/skills/bmstu-lab-report
git pull
```

Если skill установлен в нескольких местах, обновить нужно каждую копию.

## Проверка после установки

Проверь, что файл лежит именно здесь:

```text
~/.codex/skills/bmstu-lab-report/SKILL.md
~/.claude/skills/bmstu-lab-report/SKILL.md
```

Частые проблемы:

- файл называется не `SKILL.md`;
- репозиторий склонирован на один уровень глубже, например `~/.claude/skills/bmstu-lab-report/bmstu-lab-report-skill/SKILL.md`;
- Codex или Claude Code не были перезапущены после создания новой папки skills;
- у пользователя нет доступа к приватному GitHub-репозиторию;
- skill не вызывается автоматически, потому что запрос слишком общий. В таком случае вызови его явно через `$bmstu-lab-report` в Codex или `/bmstu-lab-report` в Claude Code.

## Источники

- OpenAI Academy: [Using skills](https://openai.com/academy/skills/)
- OpenAI Academy: [Plugins and skills](https://openai.com/academy/codex-plugins-and-skills/)
- Claude Code Docs: [Extend Claude with skills](https://code.claude.com/docs/en/skills)
- Claude API Docs: [Agent Skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
- Claude Help Center: [How to create custom Skills](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
