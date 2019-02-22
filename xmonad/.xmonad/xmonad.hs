-- file:   ~/.xmonad/xmonad.hs
-- author: Brian Buccola <brian.buccola@gmail.com>

-- =========
--  Imports
-- =========

import XMonad
import System.Exit
import qualified XMonad.StackSet as W -- provides greedyView and RationalRect
import XMonad.Actions.CycleWS         -- cycle through WSs, toggle last WS
import XMonad.Actions.Warp            -- banish mouse pointer
import XMonad.Hooks.DynamicLog        -- for xmobar; provides statusBar, pad, etc.
import XMonad.Hooks.EwmhDesktops      -- use EWMH hints
import XMonad.Hooks.ManageDocks       -- automatically manage dock-type programs
import XMonad.Hooks.ManageHelpers     -- provides isDialog
import XMonad.Hooks.UrgencyHook       -- colorize urgent WSs
import XMonad.Util.EZConfig           -- easily configure keybindings
import XMonad.Layout.Spacing          -- pad windows with some spacing
import XMonad.Layout.NoBorders        -- provides smartBorders, noBorders
import XMonad.Layout.Tabbed           -- tabbed windows layout
import XMonad.Layout.Renamed          -- custom layout names
import Graphics.X11.ExtraTypes.XF86   -- bind media keys
import Colors.GruvboxDark             -- personal colors, defined in Colors/GruvboxDark.hs

-- ======
--  Main
-- ======

main = xmonad =<< statusBar myBar myPP myToggleBarKey (docks $ ewmh myConfig)

-- ========
--  Basics
-- ========

myBar = "xmobar"

myPP = xmobarPP
    { ppCurrent = xmobarColor myBrightYellow "" . wrap "<" ">"
    , ppHidden  = pad
    , ppUrgent  = xmobarColor myBrightRed myRed . pad
    , ppSep     = ""
    , ppWsSep   = ""
    , ppTitle   = xmobarColor myBrightGreen "" . pad
    , ppLayout  = xmobarColor myBrightMagenta ""
    }

myToggleBarKey XConfig {modMask = modMask} = (modMask, xK_b) -- "M-b" to toggle xmobar visibility

myConfig = withUrgencyHook NoUrgencyHook def
    { terminal           =  "st -e tmux"
    , modMask            =  mod1Mask
    , borderWidth        =  2
    , normalBorderColor  =  myBrightBlack
    , focusedBorderColor =  myYellow
    , workspaces         =  [ "q", "m", "d", "t", "n", "v", "w", "x", "y", "z" ]
    , startupHook        =  myStartupHook
    , manageHook         =  myManageHook
    , layoutHook         =  myLayoutHook
    , handleEventHook    =  handleEventHook def <+> fullscreenEventHook
    }
    `additionalKeysP` myKeys

myFont      = "xft:Dina:size=8"
myDmenuFont = "Dina:size=8"

-- =============
--  Keybindings
-- =============

myKeys =
    [
    -- Basics
      ( "M-<Backspace>"          , toggleWS                                              )
    , ( "M-<Escape>"             , banish LowerRight                                     )
    , ( "M-S-<Return>"           , spawn "st -e tmux"                                    )
    , ( "M-q"                    , windows $ W.greedyView "q"                            )
    , ( "M-m"                    , windows $ W.greedyView "m"                            )
    , ( "M-d"                    , windows $ W.greedyView "d"                            )
    , ( "M-t"                    , windows $ W.greedyView "t"                            )
    , ( "M-n"                    , windows $ W.greedyView "n"                            )
    , ( "M-v"                    , windows $ W.greedyView "v"                            )
    , ( "M-w"                    , windows $ W.greedyView "w"                            )
    , ( "M-x"                    , windows $ W.greedyView "x"                            )
    , ( "M-y"                    , windows $ W.greedyView "y"                            )
    , ( "M-z"                    , windows $ W.greedyView "z"                            )
    , ( "M-S-q"                  , windows $ W.shift "q"                                 )
    , ( "M-S-m"                  , windows $ W.shift "m"                                 )
    , ( "M-S-d"                  , windows $ W.shift "d"                                 )
    , ( "M-S-t"                  , windows $ W.shift "t"                                 )
    , ( "M-S-n"                  , windows $ W.shift "n"                                 )
    , ( "M-S-v"                  , windows $ W.shift "v"                                 )
    , ( "M-S-w"                  , windows $ W.shift "w"                                 )
    , ( "M-S-x"                  , windows $ W.shift "x"                                 )
    , ( "M-S-y"                  , windows $ W.shift "y"                                 )
    , ( "M-S-z"                  , windows $ W.shift "z"                                 )
    , ( "M-C-m"                  , windows W.focusMaster                                 )
    , ( "M-C-t"                  , withFocused $ windows . W.sink                        ) -- Push window back into tiling.
    , ( "M-S-r"                  , spawn "xmonad --recompile && xmonad --restart"        )
    , ( "M-S-C-q"                , io (exitWith ExitSuccess)                             )

    -- Screenshots
    , ( "<Print>"                , spawn myScreenshotCmd                                 )
    , ( "S-<Print>"              , spawn myScreenShotCmdSel                              )

    -- Media keys, etc.
    , ( "<XF86AudioRaiseVolume>" , spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"      )
    , ( "<XF86AudioLowerVolume>" , spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"      )
    , ( "<XF86AudioMute>"        , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"     )
    , ( "<XF86AudioMicMute>"     , spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle" )
    , ( "<XF86AudioPlay>"        , spawn "mpc toggle"                                    )
    , ( "<XF86AudioNext>"        , spawn "mpc next"                                      )
    , ( "<XF86AudioPrev>"        , spawn "mpc prev"                                      )
    , ( "<XF86AudioStop>"        , spawn "mpc stop"                                      )
    , ( "<XF86Display>"          , spawn "display-adjust && keyboard-adjust && ~/.fehbg" )
    , ( "<XF86ScreenSaver>"      , spawn "slock"                                         )
    , ( "<XF86TouchpadToggle>"   , spawn "touchpad-toggle"                               )

    -- Prompts
    , ( "M-r"                    , spawn myDmenuCmd                                      )
    , ( "M-/"                    , spawn myManmenuCmd                                    )
    , ( "M-p"                    , spawn myPassmenuCmdBoth                               )
    , ( "M-S-p"                  , spawn myPassmenuCmdPass                               )
    , ( "M-C-p"                  , spawn myPassmenuCmdUser                               )
    , ( "M-u"                    , spawn myVolmenuCmd                                 )
    ]

myScreenshotCmd    = "import -silent -window root \"/tmp/screenshot-$(date '+%Y-%m-%d-%T').png\""
myScreenShotCmdSel = "import -silent \"/tmp/screenshot-$(date '+%Y-%m-%d-%T').png\""

myDmenuCmd        = "dmenu_run" ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++ myBlack ++ "' -nf '" ++ myBrightBlack ++ "' -sb '" ++ myBlack ++ "' -sf '" ++ myBrightYellow ++ "'"
myManmenuCmd      = "manmenu" ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++ myBlack ++ "' -nf '" ++ myBrightBlack ++ "' -sb '" ++ myBlack ++ "' -sf '" ++ myBrightRed ++ "'"
myPassmenuCmdBoth = "passmenu2 --typeboth " ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++ myBlack ++ "' -nf '" ++ myBrightBlack ++ "' -sb '" ++ myBlack ++ "' -sf '" ++ myBrightGreen ++ "'"
myPassmenuCmdPass = "passmenu2 --typepass " ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++ myBlack ++ "' -nf '" ++ myBrightBlack ++ "' -sb '" ++ myBlack ++ "' -sf '" ++ myBrightGreen ++ "'"
myPassmenuCmdUser = "passmenu2 --typeuser " ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++ myBlack ++ "' -nf '" ++ myBrightBlack ++ "' -sb '" ++ myBlack ++ "' -sf '" ++ myBrightGreen ++ "'"
myVolmenuCmd      = "volmenu" ++ " -fn '" ++ myDmenuFont ++ "' -nb '" ++ myBlack ++ "' -nf '" ++myBrightBlack ++ "' -sb '" ++ myBlack ++ "' -sf '" ++ myBrightMagenta ++ "'"

-- =============
--  StartupHook
-- =============

myStartupHook = do
    spawn "tmux has-session -t scratchpad || st -c scratchpad -e tmux new -s scratchpad"
    spawn "tmux has-session -t work || st -c work -e tmux new -s work"

-- ============
--  manageHook
-- ============

myManageHook = composeAll . concat $
    [ [ className =? "qutebrowser" --> doShift "q"              ]
    , [ title     =? "mutt"        --> doShift "m"              ]
    , [ className =? "MuPDF"       --> doShift "d"              ]
    , [ className =? "libreoffice" --> doShift "d"              ]
    , [ className =? "Zathura"     --> doShift "d"              ]
    , [ className =? "scratchpad"  --> doShift "t"              ]
    , [ title     =? "newsboat"    --> doShift "n"              ]
    , [ className =? "mpv"         --> doShift "v"              ]
    , [ className =? "work"        --> doShift "w"              ]
    , [ isDialog                   --> doCenterFloat            ]
    , [ className =? c             --> doFloat | c <- myCFloats ]
    , [ title     =? t             --> doFloat | t <- myTFloats ]
    , [ resource  =? r             --> doFloat | r <- myRFloats ]
    ]
    where
        myCFloats = [ "Pinentry", "Xmessage" ]
        myTFloats = []
        myRFloats = []

-- ============
--  layoutHook
-- ============

myLayoutHook = smartBorders $ avoidStruts $ myTiled ||| myTabbed ||| myFull
    where
        myTabbed = renamed [Replace "___"] $ tabbedBottom shrinkText def
            { fontName            = myFont
            , activeColor         = myBrightBlack
            , activeTextColor     = myBrightWhite
            , activeBorderColor   = myWhite
            , inactiveColor       = myBlack
            , inactiveTextColor   = myWhite
            , inactiveBorderColor = myBrightBlack
            , urgentColor         = myRed
            , urgentTextColor     = myBrightRed
            , urgentBorderColor   = myBrightBlack
            }
        myTiled       = renamed [Replace "|||"] $ spacingRaw True (Border 2 2 2 2) True (Border 2 2 2 2) True $ Tall nmaster delta ratio
        nmaster       = 1     -- number of master windows
        ratio         = 1/2   -- master-to-slave window ratio
        delta         = 5/100 -- percent of screen to increment by when resizing
        myMirrorTiled = renamed [Replace "="] $ Mirror myTiled
        myFull        = renamed [Replace "[ ]"] $ Full

-- vim: set ft=haskell tw=0 sw=4:
