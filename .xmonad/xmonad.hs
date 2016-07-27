module Main (main) where

import XMonad
import XMonad.Config.Desktop (desktopConfig, desktopLayoutModifiers)
import XMonad.Config.SLB.Layout (layouts)
import XMonad.Config.SLB.Prompt (myShellPrompt)
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Util.EZConfig (additionalKeysP)

main :: IO ()
main = xmonad =<< xmobar c
  where
    c = myConfig `additionalKeysP` myKeys
    myConfig = desktopConfig
        { modMask = mod4Mask
        , borderWidth = 3
        , layoutHook = desktopLayoutModifiers layouts
        , terminal = "exec roxterm"
        , startupHook = setWMName "LG3D"
        }
    myKeys =
        [ ("C-M1-l", spawn "xscreensaver-command -lock")
        , ("C-M1-k", myShellPrompt)
        ]
