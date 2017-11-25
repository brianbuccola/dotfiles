/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h> /* for media keys */

/* appearance */
static const char *fonts[]          = { "Fira Mono:pixelsize=12" };
static const char dmenufont[]       = "Fira Mono:pixelsize=12";
static const char normbordercolor[] = "#454545";
static const char normbgcolor[]     = "#000000";
static const char normfgcolor[]     = "#a89984";
static const char selbordercolor[]  = "#458588";
static const char selbgcolor[]      = "#454545";
static const char selfgcolor[]      = "#ebdbb2";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

/* tagging */
static const char *tags[] = { "q", "m", "d", "t", "r", "v", "y", "z", "s" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance        title       tags mask   isfloating  monitor */
	/* { "qutebrowser",    NULL,           NULL,       1 << 0,     0,          -1 }, */
	{ NULL,             NULL,           "mutt",     1 << 1,     0,          -1 },
	{ "MuPDF",          NULL,           NULL,       1 << 2,     0,          -1 },
	{ NULL,             NULL,           "newsboat", 1 << 4,     0,          -1 },
	{ NULL,             NULL,           "mpv",      1 << 5,     0,          -1 },
	{ NULL,             NULL,           "Netflix",  1 << 5,     0,          -1 },
	{ NULL,             "scratchpad",   NULL,       1 << 8,     0,          -1 },
	{ "Pinentry",       NULL,           NULL,       0,          1,          -1 },
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
static const char *dmenucmd[]      = { "dmenu_run",          "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *manmenucmd[]    = { "manmenu",            "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *passmenucmd[]   = { "passmenu", "--type", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]       = { "st", "-e", "tmux", NULL };
static const char *volupcmd[]      = { "amixer", "-q", "sset", "Master", "5%+", NULL };
static const char *voldowncmd[]    = { "amixer", "-q", "sset", "Master", "5%-", NULL };
static const char *volmutecmd[]    = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *volmicmutecmd[] = { "amixer", "-q", "sset", "Capture", "toggle", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_slash,  spawn,          {.v = manmenucmd } },
	{ MODKEY,                       XK_p,      spawn,          {.v = passmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_BackSpace, view,        {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_asterisk, view,         {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_asterisk, tag,          {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
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
	TAGKEYS(                        XK_s,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ 0,                            XF86XK_AudioRaiseVolume, spawn, {.v = volupcmd } },
	{ 0,                            XF86XK_AudioLowerVolume, spawn, {.v = voldowncmd } },
	{ 0,                            XF86XK_AudioMute,        spawn, {.v = volmutecmd } },
	{ 0,                            XF86XK_AudioMicMute,     spawn, {.v = volmicmutecmd } },
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
