module XMonad.Config.SLB.Prompt (myShellPrompt) where

import XMonad.Core (X)
import XMonad.Prompt
import XMonad.Prompt.Shell (shellPrompt)

promptConfig :: XPConfig
promptConfig = defaultXPConfig
    { font = "xft:sans:size=8"
    , height = 30
    }

myShellPrompt :: X ()
myShellPrompt = shellPrompt promptConfig
