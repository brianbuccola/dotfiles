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
c.tabs.indicator.width = 0
c.tabs.title.format = "{title}"
c.tabs.title.format_pinned = ""
c.tabs.padding = {"top": 4, "bottom": 4, "left": 4, "right": 4}

# Storage
c.downloads.location.directory = "/tmp"
c.downloads.location.prompt = False

# Hints
c.hints.chars = "aoeuidhtns.pgc"

# Search engines
c.url.searchengines['rd'] = "https://www.reddit.com/r/{}"

# Fonts
c.fonts.monospace = "xos4 Terminus"
c.fonts.web.family.fixed = "monospace"
c.fonts.web.family.serif = "DejaVu Serif"
c.fonts.web.family.sans_serif = "Fira Sans"

# Aliases
c.aliases['socks'] = "set content.proxy socks://localhost:8080/"
c.aliases['nosocks'] = "set content.proxy system"

# Bindings
## normal mode
config.unbind('b', mode="normal")
config.bind('O', "set-cmd-text :open {url:pretty}", mode="normal")
config.bind('tO', "set-cmd-text :open -t {url:pretty}", mode="normal")
config.bind('bO', "set-cmd-text :open -b {url:pretty}", mode="normal")
config.bind('tt', "set-cmd-text --space :open -t", mode="normal")
config.bind('bb', "set-cmd-text --space :open -b", mode="normal")
config.bind('ww', "set-cmd-text --space :open -w", mode="normal")
config.bind('l', "tab-focus", mode="normal")
config.bind('h', "tab-prev", mode="normal")
config.bind('<backspace>', "tab-focus last", mode="normal")
config.bind('gh', "tab-move -", mode="normal")
config.bind('gl', "tab-move +", mode="normal")
config.bind('bh', "back -b", mode="normal")
config.bind('bl', "forward -b", mode="normal")
config.bind(';f', "hint all tab", mode="normal")
config.bind(';w', "hint all window", mode="normal")
config.bind('W', "hint all window", mode="normal")
config.bind('B', "hint all tab-bg", mode="normal")
config.bind('<ctrl-h>', "scroll left", mode="normal")
config.bind('<ctrl-l>', "scroll right", mode="normal")
config.bind('m', "enter-mode set_mark", mode="normal")
config.bind('`', "enter-mode jump_mark", mode="normal")
config.bind('<ctrl-c>', "stop", mode="normal")
config.bind('x', "spawn --detach mpv {url}", mode="normal")
config.bind('gb', "config-cycle statusbar.hide", mode="normal")
config.bind('gf', "fullscreen", mode="normal")
config.bind('tH', "open -t about:blank ;; help", mode="normal")
config.bind('go', "download-open ;; download-clear", mode="normal")
config.bind('<ctrl-e>', "scroll-page 0 0.01", mode="normal")
config.bind('<ctrl-y>', "scroll-page 0 -0.01", mode="normal")
config.bind('cc', "tab-only ;; home", mode="normal")
config.bind('gC', "spawn --detach chromium {url}", mode="normal")
config.bind('M', "quickmark-save", mode="normal")
config.bind('ge', "edit-url", mode="normal")
config.bind(';x', "hint --add-history links spawn mpv {hint-url}", mode="normal")
config.bind('gG', "spawn --userscript ddg-to-google", mode="normal")
config.bind('gs', "spawn --userscript view-source", mode="normal")
config.bind('<space>', "scroll-page 0 0.9", mode="normal")
config.bind('<shift-space>', "scroll-page 0 -0.9", mode="normal")
config.bind('X', "spawn --userscript youtube-to-youpak", mode="normal")
config.bind(';?', "hint links userscript echo-url", mode="normal")
config.bind(';u', "spawn --userscript open-doi", mode="normal")
config.bind(';p', "hint links run :open -p {hint-url}")

## command mode
config.bind('<ctrl-e>', "edit-command --run", mode="command")

# Proxy
# c.content.proxy = "socks://localhost:8080/"

# Colors (gruvbox theme)
black          = "#000000"
red            = "#cc241d"
green          = "#98971a"
yellow         = "#d79921"
blue           = "#458588"
magenta        = "#b16286"
cyan           = "#689d6a"
white          = "#a89984"
bright_black   = "#928374"
bright_red     = "#fb4934"
bright_green   = "#b8bb26"
bright_yellow  = "#fabd2f"
bright_blue    = "#83a598"
bright_magenta = "#d3869b"
bright_cyan    = "#8ec07c"
bright_white   = "#ebdbb2"

c.colors.completion.category.bg                 = black
c.colors.completion.category.border.bottom      = black
c.colors.completion.category.border.top         = black
c.colors.completion.category.fg                 = bright_yellow
c.colors.completion.even.bg                     = black
c.colors.completion.fg                          = bright_white
c.colors.completion.item.selected.bg            = bright_yellow
c.colors.completion.item.selected.border.bottom = bright_yellow
c.colors.completion.item.selected.border.top    = bright_yellow
c.colors.completion.item.selected.fg            = bright_black
c.colors.completion.match.fg                    = bright_green
c.colors.completion.odd.bg                      = bright_black
c.colors.completion.scrollbar.bg                = black
c.colors.completion.scrollbar.fg                = bright_black
c.colors.downloads.bar.bg                       = black
c.colors.downloads.error.bg                     = red
c.colors.downloads.error.fg                     = bright_red
c.colors.downloads.start.bg                     = bright_blue
c.colors.downloads.start.fg                     = black
c.colors.downloads.stop.bg                      = bright_cyan
c.colors.downloads.stop.fg                      = black
c.colors.hints.bg                               = bright_yellow
c.colors.hints.fg                               = black
c.colors.hints.match.fg                         = yellow
c.colors.keyhint.bg                             = black
c.colors.keyhint.fg                             = bright_white
c.colors.keyhint.suffix.fg                      = bright_white
c.colors.messages.error.fg                      = black
c.colors.messages.error.bg                      = bright_red
c.colors.messages.error.border                  = bright_red
c.colors.messages.info.bg                       = black
c.colors.messages.info.border                   = black
c.colors.messages.info.fg                       = bright_white
c.colors.messages.warning.bg                    = bright_magenta
c.colors.messages.warning.border                = bright_magenta
c.colors.messages.warning.fg                    = black
c.colors.prompts.bg                             = black
c.colors.prompts.border                         = black
c.colors.prompts.fg                             = bright_white
c.colors.prompts.selected.bg                    = bright_yellow
c.colors.statusbar.caret.bg                     = bright_magenta
c.colors.statusbar.caret.fg                     = black
c.colors.statusbar.caret.selection.bg           = bright_blue
c.colors.statusbar.caret.selection.fg           = black
c.colors.statusbar.command.bg                   = black
c.colors.statusbar.command.fg                   = bright_white
c.colors.statusbar.command.private.bg           = black
c.colors.statusbar.command.private.fg           = bright_white
c.colors.statusbar.insert.bg                    = bright_green
c.colors.statusbar.insert.fg                    = black
c.colors.statusbar.normal.bg                    = black
c.colors.statusbar.normal.fg                    = bright_green
c.colors.statusbar.passthrough.bg               = bright_cyan
c.colors.statusbar.passthrough.fg               = black
c.colors.statusbar.private.bg                   = white
c.colors.statusbar.private.fg                   = black
c.colors.statusbar.progress.bg                  = bright_blue
c.colors.statusbar.url.error.fg                 = bright_red
c.colors.statusbar.url.fg                       = bright_white
c.colors.statusbar.url.hover.fg                 = bright_white
c.colors.statusbar.url.success.http.fg          = bright_cyan
c.colors.statusbar.url.success.https.fg         = bright_green
c.colors.statusbar.url.warn.fg                  = bright_magenta
c.colors.tabs.bar.bg                            = black
c.colors.tabs.even.bg                           = black
c.colors.tabs.even.fg                           = bright_white
c.colors.tabs.indicator.error                   = bright_red
c.colors.tabs.indicator.start                   = bright_blue
c.colors.tabs.indicator.stop                    = bright_cyan
c.colors.tabs.odd.bg                            = black
c.colors.tabs.odd.fg                            = bright_white
c.colors.tabs.selected.even.bg                  = bright_black
c.colors.tabs.selected.even.fg                  = bright_white
c.colors.tabs.selected.odd.bg                   = bright_black
c.colors.tabs.selected.odd.fg                   = bright_white
# c.colors.webpage.bg                           = black
