{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module XMonad.Config.SLB.Layout (layouts) where

import XMonad
import XMonad.Layout.PerWorkspace (onWorkspace)

layouts = onWorkspace "1" (primary ||| defaultLayouts) defaultLayouts
  where
    primary = Mirror $ Tall 3 delta 0.65
    defaultLayouts = tiledLayout ||| Mirror tiledLayout ||| Full
    tiledLayout = Tall 1 delta 0.5
    delta = 0.03
