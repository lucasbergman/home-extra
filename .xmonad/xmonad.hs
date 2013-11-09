import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Layout.PerWorkspace

myLayout = onWorkspace "1" (Mirror unevenTiledLayout) defaultLayouts
  where
    defaultLayouts = evenTiledLayout ||| Mirror evenTiledLayout ||| Full
    unevenTiledLayout = tiledLayout $ 3/5
    evenTiledLayout = tiledLayout $ 1/2
    tiledLayout ratio = Tall nmaster delta ratio
    nmaster = 1
    delta = 3/100

main = xmonad =<< xmobar defaultConfig
  { modMask = mod4Mask
  , layoutHook = myLayout
  , startupHook = setWMName "LG3D"
  , terminal = "exec gnome-terminal"
  }
