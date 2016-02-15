-- vim:     set ft=haskell tw=0 sw=4 fenc=utf-8 nu ai et:
-- file:    ~/.xmonad/xmonad.hs
-- author:  Brian Buccola

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

import Colors.ConsoleVGA            -- personal colors, defined in Colors.hs

-- ======
--  Main
-- ======

main = do

    xmobarPipe <- spawnPipe "/home/brian/.cabal/bin/xmobar /home/brian/.xmobarrc"
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

myTerminal = "urxvtc"

myModMask = mod1Mask

myBorderWidth        = 1
myNormalBorderColor  = myLightBlack -- see below for colors
myFocusedBorderColor = myDarkYellow

myWorkspaces = [ "www"
               , "mutt"
               , "doc"
               , "term"
               , "chat"
               , "rss"
               , "log"
               , "misc"
               , "K"        -- for keepassx
               , "NSP"      -- for scratchpad
               ]

myStartupHook = return()    -- prefer .xinitrc

myFont = "-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"
-- myFont = "xft:Inconsolata:pixelsize=14"

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
    -- , ( "M-w"           , windows $ W.greedyView "www" ) -- go to WS "www"
    , ( "M-c"           , windows $ W.greedyView "chat" ) -- go to WS "chat"
    , ( "M-d"           , windows $ W.greedyView "doc"  ) -- go to WS "doc"
    , ( "M-S-t"         , windows $ W.greedyView "term" ) -- go to WS "term"
    , ( "M-S-l"         , windows $ W.greedyView "log" )  -- go to WS "log"
    , ( "M-S-m"         , windows $ W.greedyView "misc" ) -- go to WS "misc"

    -- Apps, etc.
    , ( "M-f"   , raiseMaybe (spawn "firefox"              ) (className =? "Firefox"   ) ) -- "f"irefox
    , ( "M-w"   , raiseMaybe (spawn "qutebrowser"          ) (className =? "qutebrowser"  ) ) -- "www"
    , ( "M-o"   , raiseMaybe (spawn "chromium"             ) (className =? "Chromium"  ) ) -- chr"o"mium
    -- , ( "M-d"   , raiseMaybe (spawn "dwb -r"               ) (className =? "Dwb"       ) ) -- "d"wb
    -- , ( "M-d"   , raiseMaybe (spawn ""                     ) (className =? "MuPDF"     ) ) -- mup"d"f
    , ( "M-p"   , raiseMaybe (spawn "keepassx"             ) (className =? "Keepassx"  ) ) -- "k"eepassx
    , ( "M-y"   , raiseMaybe (spawn "skype"                ) (className =? "Skype"     ) ) -- sk"y"pe
    -- , ( "M-p"   , raiseMaybe (spawn "pidgin"               ) (className =? "Pidgin"    ) ) -- "p"idgin
    -- , ( "M-g"   , raiseMaybe (spawn "gajim"                ) (className =? "Gajim"     ) ) -- "g"ajim
    -- , ( "M-z"   , raiseMaybe (spawn "zathura"              ) (className =? "Zathura"   ) ) -- "z"athura
    , ( "M-n"   , raiseMaybe (runInTerm "" "ncmpcpp"       ) (className =? "ncmpcpp"   ) ) -- "n"cmpcpp
    , ( "M-m"   , raiseMaybe (runInTerm "" "mutt"          ) (title =? "mutt"          ) ) -- "m"utt
    , ( "M-r"   , raiseMaybe (runInTerm "" "newsbeuter"    ) (title =? "newsbeuter"    ) ) -- "r"ss
    -- , ( "M-w"   , raiseMaybe (runInTerm "" "weechat-curses") (title =? "WeeChat 0.4.4-dev" ) ) -- "w"eechat
    , ( "M-v"   , raiseMaybe (spawn "pavucontrol"          ) (className =? "Pavucontrol" ) ) -- "v"olume
    , ( "M-S-h" , raiseMaybe (runInTerm "" "htop"          ) (title =? "htop"          ) ) -- "h"top

    , ( "M-S-x" , sendMessage ToggleStruts )

    -- Screenshots
    , ( "<Print>"   , spawn "scrot --delay 1 '%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/pictures/scrots/'" )
    , ( "M-<Print>" , spawn "scrot -s '%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/pictures/scrots/'" )

    -- Keyboard
    -- , ( "M-<F9>" , spawn "~/scripts/keyboard-adjust.sh" )

    -- Media
    , ( "<XF86AudioLowerVolume>" , spawn "amixer -q set Master 1- unmute" )
    , ( "<XF86AudioMute>"        , spawn "amixer -q set Master toggle"    )
    , ( "<XF86AudioRaiseVolume>" , spawn "amixer -q set Master 1+ unmute" )
    , ( "<XF86AudioPlay>"        , spawn "ncmpcpp toggle"                 )

    -- Display
    , ( "<XF86MonBrightnessDown>" , spawn "~/scripts/brightness-dec.sh" )
    , ( "<XF86MonBrightnessUp>"   , spawn "~/scripts/brightness-inc.sh" )
    , ( "<XF86Display>"           , spawn "~/scripts/display-adjust.sh" )
    , ( "M-<F7>"                  , spawn "display-adjust.sh && keyboard-adjust.sh && ~/.fehbg")

    -- Scratchpad
    , ( "M-s" , scratchpadSpawnActionTerminal myTerminal )

    -- Prompts
    , ( "M-a" , appendFilePrompt defaultXPConfig

        { font    = myFont
        , bgColor = "black"
        , fgColor = myLightMagenta
        }
        "/home/brian/Dropbox/todo.txt" )

    , ( "M-g" , windowPromptGoto defaultXPConfig

        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightCyan
        , bgHLight = myLightCyan
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        } )

    , ( "M-b" , windowPromptBring defaultXPConfig

        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightMagenta
        , bgHLight = myLightMagenta
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        } )

    , ( "M-/" , manPrompt defaultXPConfig

        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightRed
        , bgHLight = myLightRed
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        } )

    , ( "M-x" , shellPrompt defaultXPConfig

        { font     = myFont
        , bgColor  = "black"
        , fgColor  = myLightGreen
        , bgHLight = myLightGreen
        , fgHLight = "black"
        , searchPredicate = mySearchPredicate
        } )

    ] ++

    -- Switch WS's with F1-F9 (required for Dvorak Programmer kbd layout).
    --
    -- Basic syntax example:
    -- ( "<F4>", windows $ W.greedyView "term" )
    --
    -- The following is a list of (keys, actions) to be appended to myKeys above.
    -- Uses list comprehension.
    [ ( otherModMasks ++ "<F" ++ [key] ++ ">", action tag )
      | (tag, key)                <- zip myWorkspaces "123456789"
      , (otherModMasks, action)   <- [ ( "", windows . W.greedyView )
                                     , ( "S-", windows . W.shift )
                                     ]
    ]

mySearchPredicate = L.isInfixOf . map C.toLower

-- ================
--  Hooks, layouts
-- ================

-- -------------
--  ManageHooks
-- -------------

myManageHook = composeAll . concat $

    [ [ className =? "qutebrowser"    --> doShift "www"            ]
    -- , [ className =? "Firefox"        --> doShift "www"            ]
    , [ title     =? "mutt"           --> doShift "mutt"           ]
    , [ className =? "Zathura"        --> doShift "doc"            ]
    , [ className =? "MuPDF"          --> doShift "doc"            ]
    , [ className =? "Djview"         --> doShift "doc"            ]
    , [ className =? "Xpdf"           --> doShift "doc"            ]
    , [ title     =? "weechat-curses" --> doShift "chat"           ]
    , [ className =? "Skype"          --> doShift "chat"           ]
    , [ className =? "Pidgin"         --> doShift "chat"           ]
    , [ className =? "Gajim"          --> doShift "chat"           ]
    , [ title     =? "newsbeuter"     --> doShift "rss"            ]
    , [ title     =? "Transmission"   --> doShift "misc"           ]
    , [ className =? "mpv"            --> doShift "misc"           ]
    , [ className =? "Keepassx"       --> doShift "K"              ]
    , [ isDialog                      --> doFloat                  ]
    , [ className =? c                --> doFloat | c <- myCFloats ]
    , [ title     =? t                --> doFloat | t <- myTFloats ]
    , [ resource  =? r                --> doFloat | r <- myRFloats ]
    , [ manageDocks                                                ]
    , [ myScratchpadManageHook                                     ]
    ]

    where

        myCFloats = [ "Xmessage", "MPlayer", "Gimp", "Wicd-client.py" ]
        myTFloats = [ "Firefox Preferences", "Hangouts" ]
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
            | ws == "K"   = xmobarColor myLightRed "" $ ws
            | otherwise   = ws
