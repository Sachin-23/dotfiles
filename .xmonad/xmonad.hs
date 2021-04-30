--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.WorkspaceCompare
import XMonad.Hooks.ManageHelpers
import XMonad.Util.NamedScratchpad

import XMonad.Hooks.SetWMName

import XMonad.Actions.SpawnOn
import XMonad.Actions.GridSelect

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#4c566a"
myFocusedBorderColor = "#5e81ac"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch pavucontrol 
    , ((modm .|. shiftMask, xK_p     ), namedScratchpadAction scratchpads "pavucontrol")

    -- open a terminal 
    , ((modm,               xK_Tab   ), namedScratchpadAction scratchpads "todo")

    -- open a terminal 
    , ((modm .|. shiftMask, xK_t    ), namedScratchpadAction scratchpads "thunar")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- GRIDSELECT keys
    --, ((modm, xK_g), goToSelected defaultGSConfig)
    , ((modm, xK_g), goToSelected def)
    --MULTIMEDIA KEYS

    -- Mute volume
    , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle")

    -- Decrease volume
    , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 5%-")

    -- Increase volume
    , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 5%+")

    -- Increase brightness
    , ((0, xF86XK_MonBrightnessUp),  spawn $ "xbacklight -inc 2")

    -- Decrease brightness
    , ((0, xF86XK_MonBrightnessDown), spawn $ "xbacklight -dec 2")

--    , ((0, xF86XK_AudioPlay), spawn $ "mpc toggle")
--    , ((0, xF86XK_AudioNext), spawn $ "mpc next")
--    , ((0, xF86XK_AudioPrev), spawn $ "mpc prev")
--    , ((0, xF86XK_AudioStop), spawn $ "mpc stop")

    , ((0, xF86XK_AudioPlay), spawn $ "playerctl play-pause")
    , ((0, xF86XK_AudioNext), spawn $ "playerctl next")
    , ((0, xF86XK_AudioPrev), spawn $ "playerctl previous")
    , ((0, xF86XK_AudioStop), spawn $ "playerctl stop")
--    , ((modm .|. mod1Mask,               xK_l     ), sendMessage $ ExpandTowards R)
--    , ((modm .|. mod1Mask,               xK_h     ), sendMessage $ ExpandTowards L)
--    , ((modm .|. mod1Mask,               xK_j     ), sendMessage $ ExpandTowards D)
--    , ((modm .|. mod1Mask,               xK_k     ), sendMessage $ ExpandTowards U)
--    , ((modm .|. mod1Mask .|.controlMask , xK_l     ), sendMessage $ ShrinkFrom R)
--    , ((modm .|. mod1Mask .|.controlMask , xK_h     ), sendMessage $ ShrinkFom L)
--    , ((modm .|. mod1Mask .|.controlMask , xK_j     ), sendMessage $ ShrinkFrom D)
--    , ((modm .|. mod1Mask .|.controlMask , xK_k     ), sendMessage $ ShrinkFrom U)
-------------------------------------------------------------------------------
    -- add flameshot and scrot
    , ((0, xK_Print), spawn "scrot '%Y-%m-%d-%T.png' -e 'mv $f ~/Pictures/Screenshots/'")
    , ((shiftMask, xK_Print), spawn "flameshot gui")
    , ((0, xK_Home), spawn "/home/s4ch1n/.local/bin/check_hdmi")
--    , ("M-M1-S-l", spawn "i3lock")
--    , ("M-M1-S-s", spawn "i3lock && systemctl suspend")
--    , ("M-M1-S-h", spawn "i3lock && systemctl hibernate")
--    , ("M1-<Tab>", nextMatch History (return True))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
--myManageHook = composeAll
--    [ className =? "MPlayer"        --> doFloat
--    , className =? "Gimp"           --> doFloat
--    , resource  =? "desktop_window" --> doIgnore
--    , resource  =? "kdesktop"       --> doIgnore ]
--
--  ]
myManageHook = composeAll 
  [ isFullscreen --> doFullFloat
  , className =? "chromium" --> doShift "1"
  , className =? "code-oss" --> doShift "2"
  , className =? "vmware" --> doShift "3"
  , className =? "VirtualBox Manager" --> doShift "3"
  , className =? "Discord" --> doShift "4"
  , className =? "Microsoft Teams - Preview" --> doShift "4"
  , className =? "Spotify" --> doShift "5"
  , className =? "Ghidra" --> doShift "2"
  , className =? "HardwareSimulatorMain" --> doFloat
  ]
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = ewmhDesktopsEventHook 
------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return ()
myPP = def { ppCurrent = xmobarColor "#1ABC9C" "" . wrap "[" "]"
           , ppTitle = xmobarColor "#1ABC9C" "" . shorten 60
           , ppVisible = wrap "(" ")"
           , ppUrgent  = xmobarColor "red" "yellow"
           , ppSort = getSortByXineramaPhysicalRule def
           }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "picom --experimental-backends &"
  spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --alpha 0 --tint 0x000000 --height 21 --monitor 1 &"
  spawnOnce "dunst &"
  spawnOnce "nitrogen --restore &"
  spawnOnce "xbanish &"
  spawnOnce "nm-applet &"
  spawnOnce "lxsession &"
  spawnOnce "xscreensaver -no-splash &"
  spawnOnce "xfce4-power-manager &"
  spawnOnce "redshift -O 4000"
  spawnOnce "/home/s4ch1n/.local/bin/check_wlo"
  spawnOn "1" "chromium"
  spawnOn "1" "alacritty"
  setWMName "LG3D"
--
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
main = do
  xmproc <- spawnPipe "xmobar /home/s4ch1n/.config/xmobar/xmobarrc"
  
  xmonad $ ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
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
        manageHook         = manageDocks <+> myManageHook <+> manageSpawn <+> namedScratchpadManageHook scratchpads <+> manageHook def,
        handleEventHook    = handleEventHook def <+> docksEventHook,
--        logHook            = myLogHook,
        logHook = dynamicLogWithPP myPP 
        {
          ppOutput  = hPutStrLn xmproc
        , ppTitle = xmobarColor "#c2c8d2" "" . shorten 50
        },
        startupHook        = myStartupHook
    }


-- 
scratchpads :: [NamedScratchpad]
scratchpads = [
--             NS "terminal" "alacritty -t scratchpad" (resource =? "scratchpad")
--                 (customFloating $ W.RationalRect (2/6) (2/6) (2/6) (2/6)),

--              NS "todo" "alacritty -t todo -e vi /home/s4ch1n/Study/todo" (resource =? "todo")
--                  (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)),

              NS "pavucontrol" "pavucontrol" (className =? "Pavucontrol")
                  (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)),

              NS "thunar" "thunar" (className =? "Thunar")
                  (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4))

--              NS "spotify" "spotify" (resource =? "Spotify")
--                (customFloating $ W.RationalRect (1/3) 0 (1/3) (2/3))
              ]


--scratchpads = [NS "terminal" spawnTerm  manageTerm]

--where
--spawnTerm  = myTerminal
---- ++ "-n scratchpad"
--findTerm   = resource =? "scratchpad"
--  manageTerm = customFloating $ W.RationalRect l t w h
--               where
--               h = 0.9
--               w = 0.9
--               t = 0.95 -h
--               l = 0.95 -w

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]

