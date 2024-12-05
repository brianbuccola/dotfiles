-- file:   ~/.xmonad/xmonad.hs
-- author: Brian Buccola <brian.buccola@gmail.com>

-- =========
--  Imports
-- =========

import XMonad
import System.Exit                    -- provides exitWith to exit xmonad
import qualified XMonad.StackSet as W -- provides greedyView and RationalRect
import XMonad.Actions.CopyWindow      -- copy window to all WSs
import XMonad.Actions.CycleWS         -- cycle through WSs, toggle last WS
import XMonad.Actions.DynamicProjects -- make WSs projects, dynamically create, rename, move projects
import XMonad.Actions.FloatSnap       -- snap floats to corners of the screen etc.
import XMonad.Actions.Warp            -- banish mouse pointer
import XMonad.Hooks.EwmhDesktops      -- use EWMH hints
import XMonad.Hooks.ManageDocks       -- automatically manage dock-type programs
import XMonad.Hooks.ManageHelpers     -- provides isDialog
import XMonad.Hooks.StatusBar         -- add status bar such as xmobar
import XMonad.Hooks.StatusBar.PP      -- configure status bar printing printing
import XMonad.Hooks.UrgencyHook       -- colorize urgent WSs
import XMonad.Layout.NoBorders        -- provides smartBorders, noBorders
import XMonad.Layout.Renamed          -- custom layout names
import XMonad.Layout.Spacing          -- pad windows with some spacing
import XMonad.Layout.Tabbed           -- tabbed windows layout
import XMonad.Prompt                  -- customize prompts
import XMonad.Util.Cursor             -- set cursor
import XMonad.Util.EZConfig           -- easily configure keybindings
import Graphics.X11.ExtraTypes.XF86   -- bind media keys
import Colors.GruvboxDark             -- personal colors, defined in Colors/GruvboxDark.hs
-- import Colors.GruvboxLight            -- personal colors, defined in Colors/GruvboxLight.hs

-- ======
--  Main
-- ======

main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB mySB defToggleStrutsKey
     . docks
     $ dynamicProjects projects myConfig

-- ========
--  Basics
-- ========

mySB = statusBarProp "xmobar" (pure myPP)

myPP = xmobarPP
    { ppCurrent = xmobarColor myBrightYellow "" . wrap "<box type=Bottom width=2 mb=1> " " </box>"
    , ppHidden  = pad
    , ppUrgent  = xmobarColor myBrightYellow myRed . wrap " " " "
    , ppSep     = ""
    , ppWsSep   = ""
    , ppTitle   = xmobarColor myBrightGreen "" . pad
    , ppLayout  = xmobarColor myBrightMagenta ""
    }

myConfig = withUrgencyHook NoUrgencyHook def
    { terminal           = "st -e tmux"
    , modMask            = mod1Mask
    , borderWidth        = 2
    , normalBorderColor  = myBrightBlack
    , focusedBorderColor = myYellow
    , workspaces         = [ "q", "m", "d", "t", "n", "s", "v", "w", "x", "y", "z" ]
    , startupHook        = myStartupHook
    , manageHook         = myManageHook
    , layoutHook         = myLayoutHook
    }
    `additionalKeysP` myKeys
    `additionalMouseBindings` myButtons

myFont = "xft:Dina:size=12"

-- ==========
--  Projects
-- ==========

projects =
    [ Project { projectName = "m"
              , projectDirectory = "~/"
              , projectStartHook = Just $ do spawn "tmux has-session -t neomutt || st -c neomutt -e tmux new -s neomutt neomutt"
              }

    , Project { projectName = "t"
              , projectDirectory = "~/"
              , projectStartHook = Just $ do spawn "tmux has-session -t scratchpad || st -c scratchpad -e tmux new -s scratchpad"
              }

    , Project { projectName = "w"
              , projectDirectory = "~/"
              , projectStartHook = Just $ do spawn "tmux has-session -t work || st -c work -e tmux new -s work"
              }

    , Project { projectName = "n"
              , projectDirectory = "~/"
              , projectStartHook = Just $ do spawn "st -e newsboat"
              }
    ]

-- =============
--  Keybindings
-- =============

myButtons =
    [
      ((mod1Mask,               button1), (\w -> focus w >> mouseMoveWindow w >> ifClick (snapMagicMove (Just 50) (Just 50) w)))
    , ((mod1Mask .|. shiftMask, button1), (\w -> focus w >> mouseMoveWindow w >> ifClick (snapMagicResize [L,R,U,D] (Just 50) (Just 50) w)))
    , ((mod1Mask,               button3), (\w -> focus w >> mouseResizeWindow w >> ifClick (snapMagicResize [R,D] (Just 50) (Just 50) w)))
    ]

myKeys =
    [
    -- Basics
      ( "M-<Backspace>"          , toggleWS                                              )
    , ( "M-<Escape>"             , banish LowerRight                                     )
    , ( "M-g"                    , switchProjectPrompt myXPConfig                        )
    , ( "M-S-g"                  , shiftToProjectPrompt myXPConfig                       )
    , ( "M-C-g"                  , renameProjectPrompt myXPConfig                        )
    , ( "M-q"                    , windows $ W.greedyView "q"                            )
    , ( "M-m"                    , windows $ W.greedyView "m"                            )
    , ( "M-d"                    , windows $ W.greedyView "d"                            )
    , ( "M-t"                    , windows $ W.greedyView "t"                            )
    , ( "M-n"                    , windows $ W.greedyView "n"                            )
    , ( "M-s"                    , windows $ W.greedyView "s"                            )
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
    , ( "M-S-s"                  , windows $ W.shift "s"                                 )
    , ( "M-S-v"                  , windows $ W.shift "v"                                 )
    , ( "M-S-w"                  , windows $ W.shift "w"                                 )
    , ( "M-S-x"                  , windows $ W.shift "x"                                 )
    , ( "M-S-y"                  , windows $ W.shift "y"                                 )
    , ( "M-S-z"                  , windows $ W.shift "z"                                 )
    , ( "M-C-m"                  , windows W.focusMaster                                 )
    , ( "M-C-t"                  , withFocused $ windows . W.sink                        ) -- Push window back into tiling.
    , ( "M-C-v"                  , windows copyToAll                                     )
    , ( "M-S-C-v"                , killAllOtherCopies                                    )
    , ( "M-S-r"                  , spawn "xmonad --recompile && xmonad --restart"        )
    , ( "M-C-!"                  , io (exitWith ExitSuccess)                             )

    -- Screenshots
    , ( "<Print>"                , unGrab >> spawn myScreenshotCmd                       )
    , ( "S-<Print>"              , unGrab >> spawn myScreenShotCmdSel                    )
    , ( "C-<Print>"              , unGrab >> spawn myScreenShotCmdSelCopy                )

    -- Media keys, etc.
    , ( "<XF86AudioRaiseVolume>" , spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"      )
    , ( "<XF86AudioLowerVolume>" , spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"      )
    , ( "<XF86AudioMute>"        , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"     )
    , ( "<XF86AudioMicMute>"     , spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle" )
    , ( "<XF86AudioPlay>"        , spawn "playerctl play-pause"                          )
    , ( "<XF86AudioNext>"        , spawn "playerctl next"                                )
    , ( "<XF86AudioPrev>"        , spawn "playerctl previous"                            )
    , ( "<XF86AudioStop>"        , spawn "playerctl stop"                                )
    , ( "<XF86Display>"          , spawn "display-adjust && keyboard-adjust && ~/.fehbg" )
    , ( "<XF86ScreenSaver>"      , spawn "slock"                                         )
    , ( "<XF86TouchpadToggle>"   , spawn "touchpad-toggle"                               )

    -- Prompts
    , ( "M-r"                    , spawn myDmenuCmd                                      )
    , ( "M-c"                    , spawn myDocmenuCmd                                    )
    , ( "M-/"                    , spawn myManmenuCmd                                    )
    , ( "M-p"                    , spawn myPassmenuCmdBoth                               )
    , ( "M-S-p"                  , spawn myPassmenuCmdPass                               )
    , ( "M-C-p"                  , spawn myPassmenuCmdUser                               )
    , ( "M-u"                    , spawn myVolmenuCmd                                    )
    ]

myXPConfig = def
    { font        = myFont
    , bgColor     = myBlack
    , fgColor     = myBrightCyan
    , bgHLight    = myBrightCyan
    , fgHLight    = myBlack
    , borderColor = myBrightCyan
    , position    = CenteredAt 0.5 0.5
    , height      = 24
    }

myScreenshotCmd        = "import -silent -window root \"/tmp/screenshot-$(date '+%Y-%m-%d-%T').png\""
myScreenShotCmdSel     = "import -silent \"/tmp/screenshot-$(date '+%Y-%m-%d-%T').png\""
myScreenShotCmdSelCopy = "import -silent png:- | xclip -selection clipboard -t image/png"

myDmenuCmd        = "dmenu_run" ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myCyan ++ "' -sf '" ++ myBrightWhite ++ "'"
myDocmenuCmd      = "docmenu" ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myBlue ++ "' -sf '" ++ myBrightWhite ++ "'"
myManmenuCmd      = "manmenu" ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myRed ++ "' -sf '" ++ myBrightWhite ++ "'"
myPassmenuCmdBoth = "passmenu2 --typeboth " ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myGreen ++ "' -sf '" ++ myBrightWhite ++ "'"
myPassmenuCmdPass = "passmenu2 --typepass " ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myGreen ++ "' -sf '" ++ myBrightWhite ++ "'"
myPassmenuCmdUser = "passmenu2 --typeuser " ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myGreen ++ "' -sf '" ++ myBrightWhite ++ "'"
myVolmenuCmd      = "volmenu" ++ " -nb '" ++ myBlack ++ "' -nf '" ++ myWhite ++ "' -sb '" ++ myMagenta ++ "' -sf '" ++ myBrightWhite ++ "'"

-- =============
--  startupHook
-- =============

myStartupHook = do
    setDefaultCursor xC_left_ptr

-- ============
--  manageHook
-- ============

myManageHook = composeAll . concat $
    [ [ className =? "qutebrowser" --> doShift "q"              ]
    , [ className =? "neomutt"     --> doShift "m"              ]
    , [ title     =? "neomutt"     --> doShift "m"              ]
    , [ className =? "MuPDF"       --> doShift "d"              ]
    , [ appName   =? "libreoffice" --> doShift "d"              ]
    , [ className =? "scratchpad"  --> doShift "t"              ]
    , [ title     =? "newsboat"    --> doShift "n"              ]
    , [ className =? "Signal"      --> doShift "s"              ]
    , [ className =? "mpv"         --> doShift "v"              ]
    , [ className =? "work"        --> doShift "w"              ]
    , [ isDialog                   --> doCenterFloat            ]
    , [ className =? c             --> doFloat | c <- myCFloats ]
    , [ title     =? t             --> doFloat | t <- myTFloats ]
    , [ resource  =? r             --> doFloat | r <- myRFloats ]
    ]
    where
        myCFloats = [ "Pinentry", "Xdialog", "Xmessage" ]
        myTFloats = []
        myRFloats = []

-- ============
--  layoutHook
-- ============

myLayoutHook = smartBorders $ avoidStruts $ myTiled ||| myTabbed ||| myFull
    where
        myTabbed = renamed [Replace " ___ "] $ tabbedBottom shrinkText def
            { fontName            = myFont
            , activeColor         = myBrightBlack
            , activeTextColor     = myBrightWhite
            , activeBorderColor   = myWhite
            , inactiveColor       = myBlack
            , inactiveTextColor   = myWhite
            , inactiveBorderColor = myBrightBlack
            , urgentColor         = myRed
            , urgentTextColor     = myBrightYellow
            , urgentBorderColor   = myBrightBlack
            , decoHeight          = 24
            }
        myTiled       = renamed [Replace " ||| "] $ smartSpacingWithEdge 2 $ Tall nmaster delta ratio
        nmaster       = 1     -- number of master windows
        ratio         = 3/5   -- master-to-slave window ratio
        delta         = 5/100 -- percent of screen to increment by when resizing
        myMirrorTiled = renamed [Replace " = "] $ Mirror myTiled
        myFull        = renamed [Replace " [ ] "] $ Full

-- vim: set ft=haskell tw=0 sw=4:
