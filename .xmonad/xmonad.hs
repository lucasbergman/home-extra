module Main (main) where

import XMonad
import XMonad.Config.Desktop (desktopConfig, desktopLayoutModifiers)
import XMonad.Config.SLB.Prompt (myShellPrompt)
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.EZConfig (additionalKeysP)

myLayouts = onWorkspace "1" (primary ||| defaultLayouts) defaultLayouts
  where
    primary = Mirror $ Tall 3 delta 0.65
    defaultLayouts = tiledLayout ||| Mirror tiledLayout ||| Full
    tiledLayout = Tall 1 delta 0.5
    delta = 0.03

main = xmonad =<< xmobar config
  where
    config = myConfig `additionalKeysP` myKeys
    myConfig = desktopConfig
        { modMask = mod4Mask
        , borderWidth = 3
        , layoutHook = desktopLayoutModifiers myLayouts
        , terminal = "exec urxvt"
        }
    myKeys =
        [ ("C-M1-l", spawn "xscreensaver-command -lock")
        , ("C-M1-k", myShellPrompt)
        ]
