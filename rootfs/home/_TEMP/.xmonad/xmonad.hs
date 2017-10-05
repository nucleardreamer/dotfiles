import XMonad
import System.Exit
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.ResizableTile
import XMonad.Layout.OneBig
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
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
     tiled1   = Tall nmaster delta ratio
     mtiled  = Mirror tiled1
     tiled   = spacingWithEdge 3  $ ResizableTall nmaster delta ratio []
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
  -- spawn "xrdb $HOME/.Xresources"
  return ()

-- to self: remember defaultConfig is being depricated
myConfig = ewmh defaultConfig
       { terminal           = "urxvt"
       , modMask            = myModMask
       , normalBorderColor  = "#6986A0"
       , focusedBorderColor = "#C1CAD0"
       , focusFollowsMouse  = True
       , manageHook         = myManageHook <+> manageDocks <+> manageSpawn
       , layoutHook         = myLayoutHook
       --  , handleEventHook    = fullscreenEventHook
       , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
       , logHook            = dynamicLogString xmobarPP >>= xmonadPropLog
       , startupHook        = myStartupHook
       , clickJustFocuses   = False
       }
       `additionalKeys`  -- see /usr/include/X11/keysymdef.h
       [
         ((myModMask, xK_grave), toggleWS)
         --take a screenshot of entire display, save and put in clipboard
         , ((myModMask , xK_Print ), spawn "scrot $HOME/last_screenshot.png -d 1 && xclip -selection c -t image/png $HOME/last_screenshot.png")
         --take a screenshot of focused window, save and put in clipboard
         , ((myModMask .|. shiftMask, xK_Print ), spawn "scrot $HOME/last_screenshot.png -d 1 -u && xclip -selection c -t image/png $HOME/last_screenshot.png")
       ]

main = xmonad myConfig
