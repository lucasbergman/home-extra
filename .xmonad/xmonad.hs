module Main (main) where

import XMonad
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Config.Gnome (gnomeConfig, gnomeRun)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)

myLayouts = onWorkspace "1" (primary ||| defaultLayouts) defaultLayouts
  where
    primary = Mirror $ Tall 3 delta 0.65
    defaultLayouts = tiledLayout ||| Mirror tiledLayout ||| Full
    tiledLayout = Tall 1 delta 0.5
    delta = 0.03

-- If we're using the mod4 as a modifier key, then move the binding for the
-- GNOME run-program dialog from mod-p to mod-shift-p. GNOME steals mod4-p
-- unconditionally and unconfigurably to reconfigure your displays, based on a
-- crazy recommendation from Microsoft:
-- https://bugs.launchpad.net/ubuntu/+source/gnome-settings-daemon/+bug/694910
fixGnomeRunKey :: XConfig l -> XConfig l
fixGnomeRunKey conf@XConfig { modMask = mod4Mask } =
    conf `removeKeysP` ["M-p"] `additionalKeysP` [("M-S-p", gnomeRun)]
fixGnomeRunKey conf = conf

main = xmonad $ fixGnomeRunKey gnomeConfig
  { modMask = mod4Mask
  , borderWidth = 3
  , layoutHook = desktopLayoutModifiers myLayouts
  , terminal = "exec urxvt"
  }
