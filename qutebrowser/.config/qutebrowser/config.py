import gruvbox

# Colorscheme
gruvbox.setup(c, "dark")

# Don't load autoconfig
config.load_autoconfig(False)

# General
c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.content.cookies.accept = "no-3rdparty"
c.content.default_encoding = "utf-8"
c.content.headers.do_not_track = False
c.content.notifications.enabled = False

# User interface
c.confirm_quit = ["downloads", "multiple-tabs"]
c.statusbar.padding = {"top": 4, "bottom": 4, "left": 0, "right": 0}
c.window.title_format = "{perc}{current_title}"
c.zoom.default = 125
# c.colors.webpage.darkmode.enabled = True

# Yanking URLs
c.url.yank_ignored_parameters += ["smid", "smtyp", "fbclid", "fb_news_token"]

# Completion
c.completion.shrink = True

# Input
c.input.partial_timeout = 30000

# Tabs
c.tabs.show = "multiple"
c.tabs.indicator.width = 0
c.tabs.title.format = "{current_title}"
c.tabs.title.format_pinned = ""
c.tabs.padding = {"top": 4, "bottom": 4, "left": 4, "right": 4}

# Content
c.content.autoplay = False
c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist-downloads.adblockplus.org/easylistdutch.txt', 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', 'https://www.i-dont-care-about-cookies.eu/abp/', 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']

# Website quirks
config.set("content.autoplay", True, "open.spotify.com")
config.set("content.blocking.enabled", False, "brulosophy.com")
config.set("content.blocking.enabled", False, "hoopladigital.com")
config.set("content.blocking.enabled", False, "nbcnews.com")
config.set("content.headers.user_agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/6.4.2 Chrome/102.0.5005.177 Safari/537.36", "twitter.com")
config.set("content.register_protocol_handler", False, "mail.google.com")
config.set("content.register_protocol_handler", False, "outlook.office.com")
config.set("content.register_protocol_handler", True, "calendar.google.com")
config.set("content.cookies.accept", "all", "teams.microsoft.com")
config.set("qt.args", ["disable-accelerated-2d-canvas"])

# Storage
c.downloads.location.directory = "/tmp"
c.downloads.location.prompt = False

# Hints
c.hints.chars = "aoeuidhtns.pgc"

# Search engines
c.url.searchengines['rd'] = "https://www.reddit.com/r/{}"
c.url.searchengines['sh'] = "https://sci-hub.tw/{}"

# Fonts
c.fonts.default_size = "12pt"
c.fonts.default_family = "Dina"

# Aliases
c.aliases['socks'] = "set content.proxy socks://localhost:8080/"
c.aliases['nosocks'] = "set content.proxy system"
c.aliases['cache'] = "open https://www.google.com/search?q=cache:{url}"

# Bindings
## normal mode
config.unbind('b', mode="normal")
config.bind('tt', "cmd-set-text --space :open -t", mode="normal")
config.bind('bb', "cmd-set-text --space :open -b", mode="normal")
config.bind('ww', "cmd-set-text --space :open -w", mode="normal")
config.bind('O', "cmd-set-text :open {url:pretty}", mode="normal")
config.bind('tO', "cmd-set-text :open -t {url:pretty}", mode="normal")
config.bind('bO', "cmd-set-text :open -b {url:pretty}", mode="normal")
config.bind('l', "tab-next", mode="normal")
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
config.bind('<ctrl-e>', "scroll-page 0 0.01", mode="normal")
config.bind('<ctrl-y>', "scroll-page 0 -0.01", mode="normal")
config.bind('<space>', "scroll-page 0 0.9", mode="normal")
config.bind('<shift-space>', "scroll-page 0 -0.9", mode="normal")
config.bind('m', "mode-enter set_mark", mode="normal")
config.bind('`', "mode-enter jump_mark", mode="normal")
config.bind('M', "quickmark-save", mode="normal")
config.bind('<ctrl-c>', "stop", mode="normal")
config.bind(';?', "hint links userscript echo-url", mode="normal")
config.bind(';u', "spawn --userscript open-doi", mode="normal")
config.bind(';p', "hint links run :open -p {hint-url}")
config.bind(';m', "hint links spawn st -e mutt {hint-url}", mode="normal")
config.bind(';x', "hint --add-history links spawn mpv {hint-url}", mode="normal")
config.bind(',b', "config-cycle statusbar.hide", mode="normal")
config.bind(',c', "tab-only ;; home", mode="normal")
config.bind(',e', "edit-url", mode="normal")
config.bind(',f', "fullscreen", mode="normal")
config.bind(',g', "spawn --userscript ddg-to-google", mode="normal")
config.bind(',h', "open -t about:blank ;; help", mode="normal")
config.bind(',m', "spawn --userscript msuify-url", mode="normal")
config.bind(',o', "download-open ;; download-clear", mode="normal")
config.bind(',s', "spawn --userscript view-source", mode="normal")
config.bind(',x', "spawn --detach mpv {url}", mode="normal")
config.bind(',F', "spawn --detach firefox {url}", mode="normal")
config.bind(',X', "spawn --userscript youtube-to-youpak", mode="normal")

## command mode
config.bind('<ctrl-e>', "edit-command --run", mode="command")
