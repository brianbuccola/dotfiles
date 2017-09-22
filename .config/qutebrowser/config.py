# Don't load autoconfig.yml. Use only config.py + defaults
config.load_autoconfig = False

# General
c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.content.default_encoding = "utf-8"

# User interface
c.confirm_quit = ["downloads", "multiple-tabs"]
c.statusbar.padding = {"top": 4, "bottom": 4, "left": 0, "right": 0}
c.window.title_format = "{perc}{title}"

# Completion
c.completion.shrink = True

# Input
c.input.partial_timeout = 30000

# Tabs
c.tabs.show = "multiple"
c.tabs.width.indicator = 0
c.tabs.title.format = "{title}"
c.tabs.title.format_pinned = "{title}"
c.tabs.padding = {"top": 4, "bottom": 4, "left": 4, "right": 4}

# Storage
c.downloads.location.directory = "/tmp"
c.downloads.location.prompt = False

# Hints
c.hints.chars = "aoeuidhtns.pgc"

# Search engines
c.url.searchengines['rd'] = "https://www.reddit.com/r/{}"

# Colors
c.colors.completion.category.fg = "#ebdbb2"
c.colors.completion.even.bg = "#222222"
c.colors.completion.fg = "#a89984"
c.colors.completion.item.selected.bg = "#fabd2f"
c.colors.completion.item.selected.border.top = c.colors.completion.item.selected.bg
c.colors.completion.match.fg = "#fb4934"
c.colors.completion.odd.bg = "black"
c.colors.hints.match.fg = "#b8bb26"
c.colors.statusbar.caret.bg = "#b16286"
c.colors.statusbar.caret.selection.bg = "#d3869b"
c.colors.statusbar.insert.bg = "#98971a"
c.colors.statusbar.normal.fg = "#ebdbb2"
c.colors.statusbar.progress.bg = "#ebdbb2"
c.colors.statusbar.url.error.fg = "#d79921"
c.colors.statusbar.url.fg = "#ebdbb2"
c.colors.statusbar.url.hover.fg = "lightcoral"
c.colors.statusbar.url.success.http.fg = c.colors.statusbar.url.fg
c.colors.statusbar.url.success.https.fg = "#b8bb26"
c.colors.statusbar.url.warn.fg = "#fabd2f"
c.colors.tabs.bar.bg = "#a89984"
c.colors.tabs.odd.bg = "black"
c.colors.tabs.odd.fg = "#a89984"
c.colors.tabs.even.bg = c.colors.tabs.odd.bg
c.colors.tabs.even.fg = c.colors.tabs.odd.fg
c.colors.tabs.selected.odd.bg = "#a89984"
c.colors.tabs.selected.odd.fg = "#ebdbb2"
c.colors.tabs.selected.even.bg = c.colors.tabs.selected.odd.bg
c.colors.tabs.selected.even.fg = c.colors.tabs.selected.odd.fg
c.colors.downloads.error.bg = "#fb4934"
c.colors.downloads.error.fg = "#ebdbb2"
c.colors.downloads.start.fg = "#ebdbb2"
c.colors.messages.error.fg = c.colors.statusbar.normal.fg
c.colors.messages.warning.fg = c.colors.statusbar.normal.fg
c.colors.prompts.bg = "#cc241d"
c.colors.prompts.fg = c.colors.statusbar.normal.fg

# Fonts
c.fonts.monospace = "Fira Mono"
c.fonts.completion.entry = "10pt Fira Mono"
c.fonts.completion.category = "bold 10pt Fira Mono"
c.fonts.debug_console = "10pt Fira Mono"
c.fonts.downloads = "10pt Fira Mono"
c.fonts.hints = "bold 13px Fira Mono"
c.fonts.keyhint = "10pt Fira Mono"
c.fonts.messages.error = "10pt Fira Mono"
c.fonts.messages.info = "10pt Fira Mono"
c.fonts.messages.warning = "10pt Fira Mono"
c.fonts.prompts = "10pt Fira Sans"
c.fonts.statusbar = "10pt Fira Mono"
c.fonts.tabs = "10pt Fira Mono"
c.fonts.web.family.fixed = "Fira Mono"
c.fonts.web.family.serif = "DejaVu Serif"
c.fonts.web.family.sans_serif = "Fira Sans"

# Bindings
## normal mode
config.unbind('b', mode="normal")
config.bind('O', "set-cmd-text :open {url:pretty}", mode="normal", force=True)
config.bind('tO', "set-cmd-text :open -t {url:pretty}", mode="normal")
config.bind('bO', "set-cmd-text :open -b {url:pretty}", mode="normal")
config.bind('tt', "set-cmd-text --space :open -t", mode="normal")
config.bind('bb', "set-cmd-text --space :open -b", mode="normal")
config.bind('ww', "set-cmd-text --space :open -w", mode="normal")
config.bind('l', "tab-focus", mode="normal", force=True)
config.bind('h', "tab-prev", mode="normal", force=True)
config.bind('<backspace>', "tab-focus last", mode="normal", force=True)
config.bind('gh', "tab-move -", mode="normal")
config.bind('gl', "tab-move +", mode="normal", force=True)
config.bind('bh', "back -b", mode="normal")
config.bind('bl', "forward -b", mode="normal")
config.bind(';f', "hint all tab", mode="normal", force=True)
config.bind(';w', "hint all window", mode="normal", force=True)
config.bind('W', "hint all window", mode="normal", force=True)
config.bind('B', "hint all tab-bg", mode="normal", force=True)
config.bind('<ctrl-h>', "scroll left", mode="normal", force=True)
config.bind('<ctrl-l>', "scroll right", mode="normal", force=True)
config.bind('m', "enter-mode set_mark", mode="normal", force=True)
config.bind('`', "enter-mode jump_mark", mode="normal", force=True)
config.bind('<ctrl-c>', "stop", mode="normal")
config.bind('x', "spawn --detach mpv {url}", mode="normal")
config.bind('gb', "set statusbar.hide!", mode="normal", force=True)
config.bind('tH', "open -t about:blank ;; help", mode="normal")
config.bind('go', "download-open ;; download-clear", mode="normal", force=True)
config.bind('<ctrl-e>', "scroll-page 0 0.01", mode="normal")
config.bind('<ctrl-y>', "scroll-page 0 -0.01", mode="normal")
config.bind('cc', "tab-only ;; home", mode="normal")
config.bind('gC', "spawn --detach chromium {url}", mode="normal", force=True)
config.bind('M', "quickmark-save", mode="normal", force=True)
config.bind('ge', "edit-url", mode="normal")
config.bind(';x', "hint --add-history links spawn mpv {hint-url}", mode="normal")
config.bind('gG', "spawn --userscript ddg-to-google", mode="normal")
config.bind('gf', "spawn --userscript view-source", mode="normal", force=True)
config.bind('<space>', "scroll-page 0 0.9", mode="normal")
config.bind('<shift-space>', "scroll-page 0 -0.9", mode="normal")
config.bind('X', "spawn --userscript youtube-to-youpak", mode="normal")
config.bind(';?', "hint links userscript echo-url", mode="normal")
config.bind(';u', "spawn --userscript open-doi", mode="normal")

# command mode
config.bind('<ctrl-e>', "spawn --userscript edit-command", mode="command", force=True)