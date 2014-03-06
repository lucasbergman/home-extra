module Main (main) where

import XMonad
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Config.Gnome (gnomeConfig, gnomeRun)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)

myLayout = onWorkspace "1" (Mirror unevenTiledLayout) defaultLayouts
  where
    defaultLayouts = evenTiledLayout ||| Mirror evenTiledLayout ||| Full
    unevenTiledLayout = tiledLayout $ 3/5
    evenTiledLayout = tiledLayout $ 1/2
    tiledLayout = Tall nmaster delta
    nmaster = 1
    delta = 3/100

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
  , startupHook = setWMName "LG3D"
  , terminal = "exec gnome-terminal"
  , layoutHook = desktopLayoutModifiers myLayout
  }
