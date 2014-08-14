module XMonad.Config.SLB.GNOME (gnomeRegister) where

import XMonad (MonadIO, liftIO)
import XMonad.Core (whenJust)
import XMonad.Util.Run (safeSpawn)

import System.Environment (lookupEnv)
import System.IO (hPutStrLn, stderr)

-- | Register the current XMonad process with the GNOME session manager. This
-- requires that DESKTOP_AUTOSTART_ID has been set in the environment, which
-- is a thing that gnome-session is supposed to do.
gnomeRegister :: MonadIO m => m ()
gnomeRegister = liftIO $ do
    x <- lookupEnv "DESKTOP_AUTOSTART_ID"
    case x of
        Nothing -> do
            warn "No $DESKTOP_AUTOSTART_ID found in process environment."
            warn "Not registering with the GNOME session manager."
        Just sessionId -> do
            safeSpawn "dbus-send" $ dbusOptions sessionId
            -- TODO: Enable this when I get base >= 4.7.0.0
            -- unsetEnv "DESKTOP_AUTOSTART_ID"
  where
    warn = hPutStrLn stderr . ("warning: " ++)
    dbusOptions sessionId =
        [ "--session"
        , "--print-reply=literal"
        , "--dest=org.gnome.SessionManager"
        , "/org/gnome/SessionManager"
        , "org.gnome.SessionManager.RegisterClient"
        , "string:xmonad"
        , "string:" ++ sessionId
        ]
