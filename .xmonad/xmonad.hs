{-# OPTIONS -fno-warn-missing-signatures #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.Minimize
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.BoringWindows (boringWindows, focusUp, focusDown)
import XMonad.Layout.Grid
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Actions.CycleWS
import XMonad.Util.Scratchpad
import Data.Monoid
import Data.Word
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

------------------------------------------------------------------------
-- Some general settings
------------------------------------------------------------------------

-- The preferred terminal program
myTerminal :: String
myTerminal = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
myBorderWidth :: Word32
myBorderWidth = 2

-- "Windows key" is usually mod4Mask.
myModMask :: KeyMask
myModMask = mod4Mask

-- Workspaces and their names
myWorkspaces :: [String]
myWorkspaces = ["1","2","3","4","5","6","7","8","9","0","A","B"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor :: String
myNormalBorderColor = "#000000"
myFocusedBorderColor :: String
myFocusedBorderColor = "#3732C7" --blue

------------------------------------------------------------------------
-- Key bindings
------------------------------------------------------------------------

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm, xK_Return),           spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ((modm, xK_r),    spawn "dmenu_yeganesh")   
    -- , ((modm, xK_r),    spawn "exe=`dmenu_run -b -nb black -nf grey -sf yellow` && eval \"exec $exe\"")   
    , ((modm, xK_r),    spawn "dmenu_run -b -nb black -nf grey -sf yellow")

    -- Lock the screen
    , ((modm,           xK_z),      spawn "xautolock -locknow")
    --, ((modm,           xK_z),      spawn "light-locker-command -l")

    -- Take a screenshot
    --, ((0,              xK_Print),  spawn "scrot ~/Desktop/TEMP/%Y-%m-%d-%T-screenshot.png")
    , ((modm,           xK_p),      spawn "scrot ~/Desktop/TEMP/%Y-%m-%d-%T-screenshot.png")

    -- Show scratchpad
    , ((modm, xK_BackSpace),        scratchpadSpawnActionTerminal myTerminal)

    -- Screen brightness
    , ((0, xF86XK_MonBrightnessUp),         spawn "light -A 10")
    , ((0, xF86XK_MonBrightnessDown),       spawn "light -U 10")

    -- Volume
    --, ((0, xF86XK_AudioRaiseVolume),        spawn "amixer -c 1 sset Master 3%+")
    , ((0, xF86XK_AudioRaiseVolume),        spawn "amixer sset Master 3%+")
    , ((0, xF86XK_AudioLowerVolume),        spawn "amixer sset Master 3%-")
    , ((0, xF86XK_AudioMute),               spawn "amixer sset Master toggle")

    -- close focused window
    , ((modm .|. shiftMask, xK_c),          kill)

     -- Rotate through the available layouts
    , ((modm,               xK_space),      sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space),      setLayout $ XMonad.layoutHook conf)

    -- Cycle workspaces
    , ((modm,               xK_Right),      nextWS)
    , ((modm,               xK_Page_Up),    nextWS)
    , ((modm .|. shiftMask, xK_l),          nextWS)
    , ((modm,               xK_Left),       prevWS)
    , ((modm,               xK_Page_Down),  prevWS)
    , ((modm .|. shiftMask, xK_h),          prevWS)
    , ((modm .|. shiftMask, xK_Right),      shiftToNext)
    , ((modm .|. shiftMask, xK_Page_Up),    shiftToNext)
    , ((modm .|. shiftMask, xK_Left),       shiftToPrev)
    , ((modm .|. shiftMask, xK_Page_Down),  shiftToPrev)
    , ((modm,               xK_Tab),        toggleWS' ["NSP"])
    , ((modm              , xK_n),          moveTo Next EmptyWS)
    , ((modm .|. shiftMask, xK_n),          shiftTo Next EmptyWS)

    -- Minimize/unminimize window
    , ((modm,               xK_m),      withFocused minimizeWindow)
    , ((modm .|. shiftMask, xK_m),      sendMessage RestoreNextMinimizedWin)

    -- Move focus to the next/previous non-minimized window
    , ((modm,               xK_j     ), focusDown)
    , ((modm,               xK_k     ), focusUp  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Shrink a window vertically
    , ((modm,               xK_Down  ), sendMessage MirrorShrink)
    , ((modm,               xK_i     ), sendMessage MirrorShrink)
    -- Expand a window vertically
    , ((modm,               xK_Up    ), sendMessage MirrorExpand)
    , ((modm,               xK_u     ), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0, xK_minus, xK_equal]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Key binding to toggle the status bar.
toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modkey} = (modkey, xK_b)


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
------------------------------------------------------------------------

myMouseBindings :: XConfig t -> M.Map (KeyMask, Button) (Window -> X())
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList
    -- Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
            >> windows W.shiftMaster)
    -- Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
            >> windows W.shiftMaster)
    ]

------------------------------------------------------------------------
-- Layouts:
------------------------------------------------------------------------

-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.

-- signature missing
myLayout = boringWindows $ smartBorders $ tall ||| grid ||| threecol ||| full ||| floating
  where
     -- default tiling algorithm partitions the screen into two panes
     tall       = renamed [Replace "|="]    $ smartSpacing s $ minimize (ResizableTall nmaster delta ratio [])
     -- tall       = renamed [Replace "|="]    $ smartSpacing s $ minimize (Tall nmaster delta ratio)
     grid       = renamed [Replace "+"]     $ smartSpacing s $ minimize Grid
     threecol   = renamed [Replace "|||"]   $ smartSpacing s $ minimize (ThreeCol 1 (3/100) (1/5))
     full       = renamed [Replace "■"]     $ smartSpacing s $ minimize Full
     floating   = renamed [Replace ":"]     $ smartSpacing s $ minimize simplestFloat
     -- The default number of windows in the master pane
     nmaster    = 1
     -- Default proportion of screen occupied by master pane
     ratio      = 1/2
     -- Percent of screen to increment by when resizing panes
     delta      = 3/100
     -- Spacing in pixels around each window
     s          = 3

------------------------------------------------------------------------
-- Window rules:
------------------------------------------------------------------------

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.

myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [  title    =? "Float"  --> doFloat
    -- className =? "Pidgin"         --> doShift "3"
    --, className =? "Skype"          --> doShift "3"
    --, className =? "Firefox"        --> doShift "1"
    --, stringProperty "WM_NAME" =? "turses"                      --> doShift "3" 
    --, stringProperty "WM_NAME" =? "ncmpcpp ver. 0.5.10"         --> doShift "2"
    --, className                =? "ncmpcpp"                     --> doShift "2"
    --, title                    =? "ncmpcpp"                     --> doShift "2"
    --, stringProperty "WM_NAME" =? "ranger:~/Desktop"       --> doShift "2"
    --, stringProperty "WM_ICON_NAME" =? "todo (~/Desktop) - VIM" --> doShift "1"
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen                  --> doFullFloat]
    <+> manageScratchPad

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
    where
        h = 0.5
        w = 0.5
        t = 0.25
        l = 0.25

------------------------------------------------------------------------
-- Event handling
------------------------------------------------------------------------

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = minimizeEventHook

------------------------------------------------------------------------
-- Status bars and logging
------------------------------------------------------------------------

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.

myLogHook :: X ()
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook
------------------------------------------------------------------------

-- Perform an arbitrary action each time xmonad starts or is restarted

myStartupHook :: X ()
myStartupHook = setWMName "LG3D"
    --do setWMName "LG3D"
    --raiseMaybe (runInTerm "" "turses") (stringProperty "WM_NAME" =? "turses")
    ----raiseMaybe (runInTerm "" "ncmpcpp") (stringProperty "WM_NAME" =? "ncmpcpp ver. 0.5.10")
    ----raiseMaybe (runInTerm "-name ncmpcpp" "ncmpcpp") (stringProperty "WM_COMMAND" =? "ncmpcpp")
    --raiseMaybe (runInTerm "-name ncmpcpp" "ncmpcpp") (className =? "ncmpcpp")
    --raiseMaybe (runInTerm "" "ranger ~/Desktop") (stringProperty "WM_NAME" =? "ranger:~/Desktop")
    --raiseMaybe (runInTerm "" "vim ~/Desktop/todo") (stringProperty "WM_ICON_NAME" =? "todo (~/Desktop) - VIM")

------------------------------------------------------------------------
-- Pretty print to the status bar
------------------------------------------------------------------------

myPP :: PP
myPP = defaultPP { ppCurrent = xmobarColor "#ffffff" "#006C82" . wrap " " " "
                 , ppUrgent  = xmobarColor "#ffffff" "#FF0000" . wrap " " " "
                 , ppLayout  = xmobarColor "#429942" "" 
                 , ppHidden  = noScratchPad
                 , ppTitle   = xmobarColor "#7094FF" "" . shorten 80
                 --, ppTitle   = xmobarColor "#ee9a00" "" . shorten 80
                 , ppSep     = xmobarColor "#429942" "" "   "
                 }
                 -- filter out scratchpad workspace
                 where noScratchPad ws = if ws == "NSP" then "" else ws

------------------------------------------------------------------------
-- Run xmonad with specified settings
------------------------------------------------------------------------

main :: IO ()
main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey defaults

-- signature missing
defaults = withUrgencyHook NoUrgencyHook defaultConfig {
        -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
