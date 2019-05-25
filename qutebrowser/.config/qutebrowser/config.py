# General
c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.content.default_encoding = "utf-8"
c.content.headers.do_not_track = False

# User interface
c.confirm_quit = ["downloads", "multiple-tabs"]
c.statusbar.padding = {"top": 4, "bottom": 4, "left": 0, "right": 0}
c.window.title_format = "{perc}{title}"

# Yanking URLs
c.url.yank_ignored_parameters += ["smid", "smtyp", "fbclid"]

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

# Content
c.content.autoplay = False

# Website quirks
config.set("content.headers.user_agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36", "web.whatsapp.com")
config.set("content.register_protocol_handler", False, "mail.google.com")
config.set("content.register_protocol_handler", True, "calendar.google.com")

# Storage
c.downloads.location.directory = "/tmp"
c.downloads.location.prompt = False

# Hints
c.hints.chars = "aoeuidhtns.pgc"

# Search engines
c.url.searchengines['rd'] = "https://www.reddit.com/r/{}"
c.url.searchengines['sh'] = "https://sci-hub.tw/{}"

# Fonts
c.fonts.monospace = "Misc Tamsyn"
c.fonts.completion.category = "bold 12pt monospace"
c.fonts.completion.entry = "12pt monospace"
c.fonts.debug_console = "12pt monospace"
c.fonts.downloads = "12pt monospace"
c.fonts.hints = "bold 12pt monospace"
c.fonts.keyhint = "12pt monospace"
c.fonts.messages.error = "12pt monospace"
c.fonts.messages.info = "12pt monospace"
c.fonts.messages.warning = "12pt monospace"
c.fonts.prompts = "12pt Noto Sans"
c.fonts.statusbar = "12pt monospace"
c.fonts.tabs = "12pt monospace"
c.fonts.web.family.fixed = "Fira Mono"
c.fonts.web.family.fixed = "Noto Sans Mono"
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.sans_serif = "Noto Sans"
c.fonts.web.family.standard = "Noto Serif"

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
config.bind(';m', "hint links spawn st -e mutt {hint-url}", mode="normal")

## command mode
config.bind('<ctrl-e>', "edit-command --run", mode="command")

# Proxy
# c.content.proxy = "socks://localhost:8080/"

# Colors

# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova

# Gruvbox dark, hard scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
base00 = "#000000"
base01 = "#3c3836"
base02 = "#504945"
base03 = "#665c54"
base04 = "#bdae93"
base05 = "#d5c4a1"
base06 = "#ebdbb2"
base07 = "#fbf1c7"
base08 = "#fb4934"
base09 = "#fe8019"
base0A = "#fabd2f"
base0B = "#b8bb26"
base0C = "#8ec07c"
base0D = "#83a598"
base0E = "#d3869b"
base0F = "#d65d0e"

# # Gruvbox light, medium scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
# base00 = "#fbf1c7"
# base01 = "#ebdbb2"
# base02 = "#d5c4a1"
# base03 = "#bdae93"
# base04 = "#665c54"
# base05 = "#504945"
# base06 = "#3c3836"
# base07 = "#282828"
# base08 = "#9d0006"
# base09 = "#af3a03"
# base0A = "#b57614"
# base0B = "#79740e"
# base0C = "#427b58"
# base0D = "#076678"
# base0E = "#8f3f71"
# base0F = "#d65d0e"

# set qutebrowser colors

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = base05

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base03

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = base00

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base0A

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base00

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base00

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base01

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = base0A

# Top border color of the completion widget category headers.
c.colors.completion.item.selected.border.top = base0A

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = base0A

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0B

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color for the download bar.
c.colors.downloads.bar.bg = base00

# Color gradient start for download text.
c.colors.downloads.start.fg = base00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = base00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

# Font color for hints.
c.colors.hints.fg = base00

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = base0A

# Font color for the matched part of hints.
c.colors.hints.match.fg = base05

# Text color for the keyhint widget.
c.colors.keyhint.fg = base05

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = base05

# Background color of the keyhint widget.
c.colors.keyhint.bg = base00

# Foreground color of an error message.
c.colors.messages.error.fg = base00

# Background color of an error message.
c.colors.messages.error.bg = base08

# Border color of an error message.
c.colors.messages.error.border = base08

# Foreground color of a warning message.
c.colors.messages.warning.fg = base00

# Background color of a warning message.
c.colors.messages.warning.bg = base0E

# Border color of a warning message.
c.colors.messages.warning.border = base0E

# Foreground color of an info message.
c.colors.messages.info.fg = base05

# Background color of an info message.
c.colors.messages.info.bg = base00

# Border color of an info message.
c.colors.messages.info.border = base00

# Foreground color for prompts.
c.colors.prompts.fg = base05

# Border used around UI elements in prompts.
c.colors.prompts.border = base00

# Background color for prompts.
c.colors.prompts.bg = base00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base0A

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base0B

# Background color of the statusbar.
c.colors.statusbar.normal.bg = base00

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = base00

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = base0D

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base00

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = base0C

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base03

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = base05

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = base00

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = base05

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base00

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = base00

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base0E

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = base00

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base0D

# Background color of the progress bar.
c.colors.statusbar.progress.bg = base0D

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = base05

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = base08

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = base05

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = base0C

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = base0B

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = base0E

# Background color of the tab bar.
c.colors.tabs.bar.bg = base00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = base00

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = base05

# Background color of unselected even tabs.
c.colors.tabs.even.bg = base00

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base00

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base05

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base00

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base05

# Background color for webpages if unset (or empty to use the theme's
# color).
# c.colors.webpage.bg = base00
