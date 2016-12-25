import XMonad
import System.Exit
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.OneBig
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutHints
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Window
import XMonad.Prompt.XMonad
import XMonad.Util.Cursor
import XMonad.Util.Run
import XMonad.Util.EZConfig

import Control.Applicative
import Control.Monad
import Data.Char (toLower)
import Data.List (isPrefixOf, filter)
import Data.Maybe
import Data.Monoid
import Data.Ratio

import qualified Codec.Binary.UTF8.String as UTF8
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myModMask = mod1Mask

myLayoutHook = commonManagers $
           tiled |||
           Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 4/100
     commonManagers = smartBorders . avoidStruts

myManageHook = composeAll
    [ manageHook gnomeConfig
    , isFullscreen --> doFullFloat -- make full-screen windows work
    , title     =? "float" --> doFloat
    , className =? "Xfce4-notifyd" --> doIgnore
    ]

myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn "xrdb $HOME/.Xresources"
  spawn "xrandr -s 1920x1080"
  spawn "xscreensaver -nosplash"
  spawn "unclutter --idle 2"
  spawn "xmobar $HOME/.xmonad/mobar.conf"
  return ()

myConfig = ewmh defaultConfig
       { terminal           = "urxvt"
       , focusFollowsMouse  = True
       , modMask            = myModMask
       , normalBorderColor  = "dim grey"
       , focusedBorderColor = "firebrick"
       , layoutHook         = myLayoutHook
       , manageHook         = myManageHook <+> manageDocks <+> manageSpawn
       , startupHook        = myStartupHook
       , logHook            = dynamicLogString xmobarPP >>= xmonadPropLog
       , handleEventHook    = fullscreenEventHook
       , clickJustFocuses   = False
       }
       `additionalKeys`  -- see /usr/include/X11/keysymdef.h
       [
         ((myModMask, xK_grave), toggleWS)
         --take a screenshot of entire display 
         , ((myModMask , xK_Print ), spawn "scrot $HOME/last_screenshot.png -d 1")
         --take a screenshot of focused window 
         , ((myModMask .|. controlMask, xK_Print ), spawn "scrot $HOME/last_screenshot.png -d 1-u")
       ]

main = xmonad myConfig
