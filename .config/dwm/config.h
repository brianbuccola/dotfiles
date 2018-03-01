/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h> /* for media keys */
#include "movestack.c"      /* for movestack patch */

/* appearance */
static const char *fonts[]          = { "xos4 Terminus:size=9" };
static const char dmenufont[]       = "xos4 Terminus:size=9";
static const char normbordercolor[] = "#3e3e3e";
static const char normbgcolor[]     = "#000000";
static const char normfgcolor[]     = "#a89984";
static const char selbordercolor[]  = "#d79921";
static const char selbgcolor[]      = "#000000";
static const char selfgcolor[]      = "#fabd2f";
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, 0: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

/* tagging */
static const char *tags[] = { "q", "m", "d", "t", "n", "v", "w", "y", "z" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance        title       tags mask   isfloating  monitor */
	{ "qutebrowser",    NULL,           NULL,       1 << 0,     0,          -1 },
	{ NULL,             NULL,           "mutt",     1 << 1,     0,          -1 },
	{ "MuPDF",          NULL,           NULL,       1 << 2,     0,          -1 },
	{ NULL,             NULL,           "newsboat", 1 << 4,     0,          -1 },
	{ NULL,             NULL,           "mpv",      1 << 5,     0,          -1 },
	{ NULL,             "scratchpad",   NULL,       1 << 3,     0,          -1 },
	{ "Pinentry",       NULL,           NULL,       0,          1,          -1 },
	{ "Xmessage",       NULL,           NULL,       0,          1,          -1 },
};

/* layout(s) */
static const float mfact     = 0.60; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *manmenucmd[]  = { "manmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", "#fb4934", NULL };
static const char *passmenucmd[] = { "passmenu2", "--typeboth", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", "#b8bb26", NULL };
static const char *volmenucmd[]  = { "volmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", "#d3869b", NULL };
static const char *termcmd[]     = { "st", "-e", "tmux", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_slash,  spawn,          {.v = manmenucmd } },
	{ MODKEY,                       XK_p,      spawn,          {.v = passmenucmd } },
	{ MODKEY,                       XK_u,      spawn,          {.v = volmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_Escape, spawn,          SHCMD("mouse-warp") },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_period, incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_comma,  incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_BackSpace, view,        {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_a,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_e,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_asterisk, view,         {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_asterisk, tag,          {.ui = ~0 } },
	{ MODKEY|ControlMask,           XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY|ControlMask,           XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_parenleft,              0)
	TAGKEYS(                        XK_parenright,             1)
	TAGKEYS(                        XK_braceright,             2)
	TAGKEYS(                        XK_plus,                   3)
	TAGKEYS(                        XK_braceleft,              4)
	TAGKEYS(                        XK_bracketright,           5)
	TAGKEYS(                        XK_bracketleft,            6)
	TAGKEYS(                        XK_exclam,                 7)
	TAGKEYS(                        XK_equal,                  8)
	TAGKEYS(                        XK_q,                      0)
	TAGKEYS(                        XK_m,                      1)
	TAGKEYS(                        XK_d,                      2)
	TAGKEYS(                        XK_t,                      3)
	TAGKEYS(                        XK_n,                      4)
	TAGKEYS(                        XK_v,                      5)
	TAGKEYS(                        XK_w,                      6)
	TAGKEYS(                        XK_y,                      7)
	TAGKEYS(                        XK_z,                      8)
	{ MODKEY,                       XK_s,                      spawn, SHCMD("") }, /* NOP */
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ 0,                            XK_Print,                spawn, SHCMD("import -silent -window root \"/tmp/$(date '+%Y-%m-%d-%T')-screenshot.png\"") },
	{ ShiftMask,                    XK_Print,                spawn, SHCMD("import -silent \"/tmp/$(date '+%Y-%m-%d-%T')-screenshot.png\"") },
	{ 0,                            XF86XK_AudioRaiseVolume, spawn, SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5%") },
	{ 0,                            XF86XK_AudioLowerVolume, spawn, SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5%") },
	{ 0,                            XF86XK_AudioMute,        spawn, SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle") },
	{ 0,                            XF86XK_AudioMicMute,     spawn, SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle") },
	{ 0,                            XF86XK_AudioPlay,        spawn, SHCMD("mpc toggle") },
	{ 0,                            XF86XK_AudioNext,        spawn, SHCMD("mpc next") },
	{ 0,                            XF86XK_AudioPrev,        spawn, SHCMD("mpc prev") },
	{ 0,                            XF86XK_AudioStop,        spawn, SHCMD("mpc stop") },
	{ 0,                            XF86XK_Display,          spawn, SHCMD("display-adjust && keyboard-adjust && ~/.fehbg") },
	{ 0,                            XF86XK_ScreenSaver,      spawn, SHCMD("slock") },
	{ 0,                            XF86XK_TouchpadToggle,   spawn, SHCMD("touchpad-toggle") },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

