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

import XMonad.Actions.WindowGo
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Util.EZConfig

import Control.OldException
import Control.Monad
--import DBus
--import DBus.Connection
--import DBus.Message
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.WorkspaceCompare
import System.IO
import Data.List -- isPrefixOf,isSuffixOf,isInfixOfを使用可能に
import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Layout.Named

import XMonad.ManageHook
import XMonad.Util.NamedScratchpad

import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks


import XMonad.Util.Run(spawnPipe)

myModMask       = mod4Mask

main = do 
        xmproc <- spawnPipe "xmobar"
        xmonad $ defaultConfig
            { manageHook = manageDocks <+> manageHook defaultConfig <+> namedScratchpadManageHook scratchpads
            , layoutHook = myLayout
         --   , layoutHook = avoidStruts $ layoutHook defaultConfig
            , logHook = dynamicLogWithPP $ xmobarPP
                            { ppOutput = hPutStrLn xmproc
                            , ppTitle = xmobarColor "green" "" . shorten 50
                            }
            , terminal           = "mlterm"
            , borderWidth        = 2
            , normalBorderColor  = "#333333"
            , focusedBorderColor = "#cd8b00"
            , modMask = myModMask 
            , keys               = myKeys
            , workspaces = myWorkspaces
            }


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "mlterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
-- modキーをWindowsに
-- myModMask       = mod1Mask


-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-- ここからポップアップさせるウィンドウの設定
-- scratchpad settings
scratchpads = [
  -- mltermでhtopを実行して、それをデフォルトのフローティングウィンドウで表示させます。
  -- ここではタイトル一致( title =? )を利用しています。
  -- run htop in xterm, find it by title, use default floating window placement
  --NS "htop" "mlterm -T 'htop' -e htop" (title =? "htop") defaultFloating ,
  NS "mlterm" "mlterm" (className =? "mlterm")
    (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)), 
-- smplayerをフローティングウィンドウで管理します。smplayerは、クラス一致を
  -- 利用しています。
  -- customFloatingで、表示する基準をディスプレイの高さの1/6、幅の1/6として、
  -- フローティングウィンドウ自体の幅と高さを、それぞれディスプレイの幅/高さの2/3にしています。
  -- run smplayer, find it by class name, place it in the floating window
  -- 1/6 of screen width from the left, 1/6 of screen height
  -- from the top, 2/3 of screen width by 2/3 of screen height
  NS "smplayer" "smplayer" (className =? "Smplayer")
  (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))

  ] where role = stringProperty "WM_WINDOW_ROLE"

-- ここまでがポップアップさせるウィンドウの設定

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. controlMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

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
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    ,((modm, xK_f), sendMessage (Toggle FULL)) 
    , ((modm, xK_z), namedScratchpadAction scratchpads "mlterm") 
    , ((modm, xK_e), runOrRaiseNext "emacs" (className =? "Emacs")) 
    , ((modm, xK_a), runOrRaise "nautilus" (className =? "Nautilus")) 
    , ((modm, xK_w), runOrRaise "firefox" (className =? "Firefox")) 
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    -- --
    -- -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    -- --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


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

tall = ResizableTall 1 (3/100) (1/2) []
myLayout =  smartBorders $ mkToggle1 FULL $ gaps [(U,24)] $ tall ||| Mirror tall

-- myLayout = tiled ||| Mirror tiled ||| Full
--   where
--      -- default tiling algorithm partitions the screen into two panes
--      tiled   = Tall nmaster delta ratio

--      -- The default number of windows in the master pane
--      nmaster = 1

--      -- Default proportion of screen occupied by master pane
--      ratio   = 1/2

--      -- Percent of screen to increment by when resizing panes
--      delta   = 3/100

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
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        numlockMask        = myNumlockMask,
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


--spawn "xset r rate 300 60"



