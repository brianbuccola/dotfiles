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
import XMonad.Hooks.ManageDocks     -- provides avoidStruts
import XMonad.Hooks.ManageHelpers   -- provides isDialog
import XMonad.Hooks.UrgencyHook     -- colorize urgent WSs

import XMonad.Util.Run              -- provides spawnPipe, runInTerm, and hPutStrLn
import XMonad.Util.EZConfig         -- easily configure keybindings
import XMonad.Util.Scratchpad       -- scratchpad terminal

import XMonad.Layout.Spacing        -- pad windows with some spacing
import XMonad.Layout.NoBorders      -- provides smartBorders, noBorders
import XMonad.Layout.Tabbed         -- tabbed windows layout
import XMonad.Layout.Renamed        -- custom layout names

import XMonad.Prompt
import XMonad.Prompt.AppendFile     -- append single line to a file (notetaking)
import XMonad.Prompt.Man            -- man page prompt
import XMonad.Prompt.Shell          -- execute shell commands prompt
import XMonad.Prompt.Window         -- list and go to/bring window
import XMonad.Prompt.Workspace      -- list and go to WS

import Graphics.X11.ExtraTypes.XF86 -- bind media keys

import Colors.Gruvbox               -- personal colors, defined in Colors.hs

-- ======
--  Main
-- ======

main = do

    xmobarPipe <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook defaultConfig

        {   terminal           =  myTerminal
        ,   modMask            =  myModMask
        ,   borderWidth        =  myBorderWidth
        ,   normalBorderColor  =  myNormalBorderColor
        ,   focusedBorderColor =  myFocusedBorderColor
        ,   workspaces         =  myWorkspaces
        ,   startupHook        =  myStartupHook
        ,   manageHook         =  myManageHook
        ,   layoutHook         =  avoidStruts $ myLayout
        ,   logHook            =  myLogHook xmobarPipe
        }

        `additionalKeysP` myKeys

-- ========
--  Basics
-- ========

myTerminal           = "urxvtc"
myModMask            = mod1Mask
myBorderWidth        = 1
myNormalBorderColor  = myLightBlack -- see below for colors
myFocusedBorderColor = myDarkYellow
myWorkspaces         = [ "www"
                       , "mutt"
                       , "doc"
                       , "term"
                       , "chat"
                       , "rss"
                       , "log"
                       , "misc"
                       , "NSP" -- for scratchpad
                       ]
myStartupHook        = return() -- prefer .xinitrc
myFont               = "-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"

-- =============
--  Keybindings
-- =============

myKeys =

    [

    -- Basics
      ( "M-S-n"         , nextWS                        )
    , ( "M-S-p"         , prevWS                        )
    , ( "M-<Backspace>" , toggleWS                      )
    , ( "M-<Escape>"    , banish LowerRight             )
    , ( "M-<Return>"    , spawn myTerminal              )
    , ( "M-c"           , windows $ W.greedyView "chat" ) -- go to WS "chat"
    , ( "M-d"           , windows $ W.greedyView "doc"  ) -- go to WS "doc"
    , ( "M-S-t"         , windows $ W.greedyView "term" ) -- go to WS "term"
    , ( "M-S-l"         , windows $ W.greedyView "log"  ) -- go to WS "log"
    , ( "M-S-m"         , windows $ W.greedyView "misc" ) -- go to WS "misc"
    , ( "M-S-x"         , sendMessage ToggleStruts      ) -- toggle xmobar visibility

    -- Apps, etc.
    , ( "M-o"   , raiseMaybe ( spawn "chromium"          ) ( className =? "Chromium"    ) ) -- chr"o"mium
    , ( "M-v"   , raiseMaybe ( spawn "pavucontrol"       ) ( className =? "Pavucontrol" ) ) -- "v"olume
    , ( "M-w"   , raiseMaybe ( spawn "qutebrowser"       ) ( className =? "qutebrowser" ) ) -- "www"
    , ( "M-y"   , raiseMaybe ( spawn "skype"             ) ( className =? "Skype"       ) ) -- sk"y"pe
    , ( "M-S-h" , raiseMaybe ( runInTerm "" "htop"       ) ( title =? "htop"            ) ) -- "h"top
    , ( "M-m"   , raiseMaybe ( runInTerm "" "mutt"       ) ( title =? "mutt"            ) ) -- "m"utt
    , ( "M-n"   , raiseMaybe ( runInTerm "" "ncmpcpp"    ) ( title =? "ncmpcpp"         ) ) -- "n"cmpcpp
    , ( "M-r"   , raiseMaybe ( runInTerm "" "newsbeuter" ) ( title =? "newsbeuter"      ) ) -- "r"ss

    -- Screenshots
    , ( "<Print>"   , spawn "scrot --delay 1 '%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/pictures/scrots/'" )
    , ( "M-<Print>" , spawn "scrot -s '%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/pictures/scrots/'"        )

    -- Media
    , ( "<XF86AudioLowerVolume>" , spawn "pactl set-sink-volume 0 -5%"    )
    , ( "<XF86AudioMute>"        , spawn "pactl set-sink-mute 0 toggle"   )
    , ( "<XF86AudioRaiseVolume>" , spawn "pactl set-sink-volume 0 +5%"    )
    , ( "<XF86AudioMicMute>"     , spawn "pactl set-source-mute 1 toggle" )
    -- , ( "<XF86AudioPlay>"        , spawn "ncmpcpp toggle"               )

    -- Display
    , ( "<XF86Display>" , spawn "~/repos/scripts/display-adjust.sh && keyboard-adjust.sh && ~/.fehbg" )

    -- Scratchpad
    , ( "M-s" , scratchpadSpawnActionTerminal myTerminal )

    -- Prompts
    , ( "M-g" , windowPromptGoto defaultXPConfig
        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightCyan
        , bgHLight = myLightCyan
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        }
      )

    , ( "M-b" , windowPromptBring defaultXPConfig
        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightMagenta
        , bgHLight = myLightMagenta
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        }
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

mySearchPredicate = L.isInfixOf . map C.toLower

-- ================
--  Hooks, layouts
-- ================

-- -------------
--  ManageHooks
-- -------------

myManageHook = composeAll . concat $

    [ [ className =? "qutebrowser"  --> doShift "www"            ]
    , [ title     =? "mutt"         --> doShift "mutt"           ]
    , [ className =? "MuPDF"        --> doShift "doc"            ]
    , [ className =? "Acroread"     --> doShift "doc"            ]
    , [ className =? "Skype"        --> doShift "chat"           ]
    , [ title     =? "newsbeuter"   --> doShift "rss"            ]
    , [ className =? "mpv"          --> doShift "misc"           ]
    , [ className =? "transmission" --> doShift "misc"           ]
    , [ isDialog                    --> doFloat                  ]
    , [ className =? c              --> doFloat | c <- myCFloats ]
    , [ title     =? t              --> doFloat | t <- myTFloats ]
    , [ resource  =? r              --> doFloat | r <- myRFloats ]
    , [ manageDocks                                              ]
    , [ myScratchpadManageHook                                   ]
    ]

    where

        myCFloats = [ "Xmessage", "Gimp" ]
        myTFloats = []
        myRFloats = []

        myScratchpadManageHook = scratchpadManageHook (W.RationalRect 0.1 0.1 0.8 0.8)

-- ---------
--  Layouts
-- ---------

myLayout = smartBorders $ myTabbed ||| myTiled ||| myMirrorTiled ||| myFull

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
        ratio   = 3/4   -- master-to-slave window ratio
        delta   = 1/100 -- percent of screen to increment by when resizing

        myMirrorTiled = renamed [Replace "="] $ Mirror myTiled

        myFull = renamed [Replace "[ ]"] $ Full

-- -----------------------
--  LogHooks (for xmobar)
-- -----------------------

myLogHook xmobarPipe = dynamicLogWithPP xmobarPP

    { ppOutput          = hPutStrLn xmobarPipe
    , ppTitle           = xmobarColor myLightGreen "" . pad
    , ppCurrent         = xmobarColor myLightWhite "" . pad
    , ppUrgent          = xmobarColor myLightRed myDarkRed . pad
    , ppHidden          = pad . renameWS
    , ppSep             = ""
    , ppWsSep           = ""
    , ppLayout          = xmobarColor myLightMagenta ""
    }

    where

        renameWS ws
            | ws == "NSP" = ""
            | otherwise   = ws
