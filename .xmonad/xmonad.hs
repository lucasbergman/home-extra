module Main (main) where

import XMonad
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Config.Gnome (gnomeConfig)
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
    config = myGnomeConfig `additionalKeysP` myKeys
    myGnomeConfig = gnomeConfig
        { modMask = mod4Mask
        , borderWidth = 3
        , layoutHook = desktopLayoutModifiers myLayouts
        , terminal = "exec gnome-terminal"
        }
    myKeys =
        [ ("C-M1-l", spawn "gnome-screensaver-command --lock")
        , ("M-S-q", spawn "gnome-session-quit")
        ]
