-- vim:    set ft=haskell tw=0 sw=4 fenc=utf-8 nu ai et:
-- file:   ~/.xmonad/xmonad.hs
-- author: Brian Buccola <brian.buccola@gmail.com>

-- =========
--  Imports
-- =========

import XMonad
import qualified XMonad.StackSet as W
import qualified Data.List as L     -- provides isInfixOf, used for mySearchPredicate
import qualified Data.Char as C     -- provides toLower, used for mySearchPredicate
import XMonad.Actions.CycleWS       -- cycle through WSs, toggle last WS
import XMonad.Actions.Warp          -- banish mouse pointer
import XMonad.Actions.WindowGo      -- provides runOrRaise
import XMonad.Hooks.DynamicLog      -- for xmobar
import XMonad.Hooks.ManageHelpers   -- provides isDialog
import XMonad.Hooks.UrgencyHook     -- colorize urgent WSs
import XMonad.Util.Run              -- provides spawnPipe, runInTerm, and hPutStrLn
import XMonad.Util.EZConfig         -- easily configure keybindings
import XMonad.Util.Scratchpad       -- scratchpad terminal
import XMonad.Layout.Spacing        -- pad windows with some spacing
import XMonad.Layout.NoBorders      -- provides smartBorders, noBorders
import XMonad.Layout.Tabbed         -- tabbed windows layout
import XMonad.Layout.Renamed        -- custom layout names
import XMonad.Prompt                -- prompts
import XMonad.Prompt.Man            -- man page prompt
import XMonad.Prompt.Shell          -- execute shell commands prompt
import XMonad.Prompt.Window         -- list and go to/bring window
import Graphics.X11.ExtraTypes.XF86 -- bind media keys
import Colors.Gruvbox               -- personal colors, defined in Colors/Gruvbox.hs

-- ======
--  Main
-- ======

main = xmonad =<< statusBar myBar myPP myToggleBarKey myConfig

-- ========
--  Basics
-- ========

myFont = "xft:Fira Mono:pixelsize=12"
myBar = "xmobar"
myToggleBarKey XConfig {XMonad.modMask = modMask} = (modMask .|. shiftMask, xK_x) -- "M-S-x" to toggle xmobar visibility

myPP = xmobarPP
    { ppTitle   = xmobarColor myLightGreen "" . pad
    , ppCurrent = xmobarColor myLightYellow "" . (\s -> "[" ++ s ++ "]")
    , ppUrgent  = xmobarColor myLightRed myDarkRed . pad
    , ppHidden  = pad . renameWS
    , ppSep     = ""
    , ppWsSep   = ""
    , ppLayout  = xmobarColor myLightMagenta ""
    }
    where
        renameWS ws
            | ws == "NSP" = "" -- don't print scatchpad WS name
            | otherwise   = ws

myConfig = withUrgencyHook NoUrgencyHook defaultConfig
    {   terminal           =  "urxvtc"
    ,   modMask            =  mod1Mask
    ,   borderWidth        =  1
    ,   normalBorderColor  =  myLightBlack
    ,   focusedBorderColor =  myDarkYellow
    ,   workspaces         =  [ "www", "mutt", "doc", "term", "chat", "rss", "ncmpcpp", "log", "misc", "NSP" ] -- NSP for scratchpad
    ,   startupHook        =  return() -- prefer .xinitrc
    ,   manageHook         =  myManageHook
    ,   layoutHook         =  myLayoutHook
    }
    `additionalKeysP` myKeys

-- =============
--  Keybindings
-- =============

myKeys =
    [
    -- Basics
      ( "M-S-n"         , nextWS                                 )
    , ( "M-S-p"         , prevWS                                 )
    , ( "M-<Backspace>" , toggleWS                               )
    , ( "M-<Escape>"    , banish LowerRight                      )
    , ( "M-<Return>"    , spawn "urxvtc"                         )
    , ( "M-s"           , scratchpadSpawnActionTerminal "urxvtc" )
    , ( "M-c"           , windows $ W.greedyView "chat"          ) -- go to WS "chat"
    , ( "M-d"           , windows $ W.greedyView "doc"           ) -- go to WS "doc"
    , ( "M-S-t"         , windows $ W.greedyView "term"          ) -- go to WS "term"
    , ( "M-S-l"         , windows $ W.greedyView "log"           ) -- go to WS "log"
    , ( "M-S-m"         , windows $ W.greedyView "misc"          ) -- go to WS "misc"

    -- Apps
    , ( "M-o"   , raiseMaybe ( spawn "chromium"          ) ( className =? "Chromium"         ) ) -- chr"o"mium
    , ( "M-v"   , raiseMaybe ( spawn "pavucontrol -t 3"  ) ( className =? "Pavucontrol"      ) ) -- "v"olume
    , ( "M-w"   , raiseMaybe ( spawn "qutebrowser --backend webengine" ) ( className =? "qutebrowser" ) ) -- "www"
    , ( "M-y"   , raiseMaybe ( spawn "skypeforlinux"     ) ( title =? "Skype for Linux Beta" ) ) -- sk"y"pe
    , ( "M-S-h" , raiseMaybe ( runInTerm "" "htop"       ) ( title =? "htop"                 ) ) -- "h"top
    , ( "M-m"   , raiseMaybe ( runInTerm "" "mutt"       ) ( title =? "mutt"                 ) ) -- "m"utt
    , ( "M-n"   , raiseMaybe ( runInTerm "" "ncmpcpp"    ) ( title =? "ncmpcpp"              ) ) -- "n"cmpcpp
    , ( "M-r"   , raiseMaybe ( runInTerm "" "newsbeuter" ) ( title =? "newsbeuter"           ) ) -- "r"ss

    -- Screenshots
    , ( "<Print>"   , spawn "scrot '%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/pictures/scrots/'" )
    , ( "M-<Print>" , spawn "scrot -s '%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/pictures/scrots/'"        )

    -- Media keys, etc.
    , ( "<XF86AudioLowerVolume>" , spawn "pactl set-sink-volume 0 -5%"     )
    , ( "<XF86AudioMute>"        , spawn "pactl set-sink-mute 0 toggle"    )
    , ( "<XF86AudioRaiseVolume>" , spawn "pactl set-sink-volume 0 +5%"     )
    , ( "<XF86AudioMicMute>"     , spawn "pactl set-source-mute 1 toggle"  )
    , ( "<XF86AudioPlay>"        , spawn "mpc toggle"                      )
    , ( "<XF86AudioNext>"        , spawn "mpc next"                        )
    , ( "<XF86AudioPrev>"        , spawn "mpc prev"                        )
    , ( "<XF86AudioStop>"        , spawn "mpc stop"                        )
    -- , ( "<XF86Display>"          , spawn "~/repos/scripts/display-adjust && keyboard-adjust && ~/.fehbg" )
    , ( "<XF86TouchpadToggle>"   , spawn "~/repos/scripts/touchpad-toggle" )

    -- Prompts
    , ( "M-g" , windowPrompt defaultXPConfig
        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightCyan
        , bgHLight = myLightCyan
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        } Goto allWindows
      )
    , ( "M-b" , windowPrompt defaultXPConfig
        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightMagenta
        , bgHLight = myLightMagenta
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        } Bring allWindows
      )
    , ( "M-/" , manPrompt defaultXPConfig
        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightRed
        , bgHLight = myLightRed
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        }
      )
    , ( "M-x" , shellPrompt defaultXPConfig
        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightGreen
        , bgHLight = myLightGreen
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        }
      )
    ]

mySearchPredicate x y = (L.isInfixOf . map C.toLower $ x) (map C.toLower y)

-- ============
--  manageHook
-- ============

myManageHook = composeAll . concat $
    [ [ className =? "qutebrowser"           --> doShift "www"            ]
    , [ title     =? "mutt"                  --> doShift "mutt"           ]
    , [ className =? "MuPDF"                 --> doShift "doc"            ]
    , [ className =? "Acroread"              --> doShift "doc"            ]
    , [ title     =? "Skype for Linux Beta"  --> doShift "chat"           ]
    , [ title     =? "newsbeuter"            --> doShift "rss"            ]
    , [ title     =? "ncmpcpp"               --> doShift "ncmpcpp"        ]
    , [ className =? "mpv"                   --> doShift "misc"           ]
    , [ className =? "transmission"          --> doShift "misc"           ]
    , [ isDialog                             --> doFloat                  ]
    , [ className =? c                       --> doFloat | c <- myCFloats ]
    , [ title     =? t                       --> doFloat | t <- myTFloats ]
    , [ resource  =? r                       --> doFloat | r <- myRFloats ]
    , [ scratchpadManageHook (W.RationalRect 0.1 0.1 0.8 0.8)             ]
    ]
    where
        myCFloats = [ "Xmessage", "Gimp" ]
        myTFloats = []
        myRFloats = []

-- ============
--  layoutHook
-- ============

myLayoutHook = smartBorders $ myTabbed ||| myTiled ||| myMirrorTiled ||| myFull
    where
        myTabbed = renamed [Replace "___"] $ tabbedBottom shrinkText defaultTheme
            { fontName            = myFont
            , activeColor         = myLightBlack
            , activeTextColor     = myLightWhite
            , activeBorderColor   = myDarkWhite
            , inactiveColor       = myDarkBlack
            , inactiveTextColor   = myDarkWhite
            , inactiveBorderColor = myLightBlack
            , urgentColor         = myDarkRed
            , urgentTextColor     = myLightRed
            , urgentBorderColor   = myLightBlack
            }
        myTiled = renamed [Replace "|||"] $ spacing 2 $ Tall nmaster delta ratio
        nmaster = 1     -- number of master windows
        ratio   = 1/2   -- master-to-slave window ratio
        delta   = 1/100 -- percent of screen to increment by when resizing
        myMirrorTiled = renamed [Replace "="] $ Mirror myTiled
        myFull = renamed [Replace "[ ]"] $ Full
