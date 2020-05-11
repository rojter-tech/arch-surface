import System.IO
import System.Exit

import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.CenteredMaster(centerMaster)
import XMonad.Actions.OnScreen
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import qualified Codec.Binary.UTF8.String as UTF8
import qualified DBus as D
import qualified DBus.Client as D

import Graphics.X11.ExtraTypes.XF86
import Control.Monad (liftM2)

myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"
    spawnOn "1" "firefox"
    spawnOn "2" "firefox-developer-edition"
    spawnOn "9" "code"
    spawnOn "12" "urxvt"
    spawnOn "12" "urxvt"
    spawnOn "12" "teams"

normBordColor = "#4c566a"
focdBordColor = "#5e81ac"
backColor     = "#282c34"

myModMask = mod4Mask
myFocusFollowsMouse = True
myBorderWidth = 2
myTerminal    = "urxvt"
--myWorkspaces    = ["\61612","\61899","\61947","\61635","\61502","\61501","\61705","\61564","\62150","\61872", "-", "="]
myWorkspaces    = ["1","2","3","4","5","6","7","8","9","10","11","12"]
myBaseConfig = desktopConfig

myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    ]
    where
    myCFloats = ["Arandr", "Galculator", "Oblogout", "feh", "mpv"]
    myTFloats = ["Downloads", "Save As..."]
    myRFloats = []
    myIgnores = ["desktop_window"]

myLayout = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $
    avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ 
    smartBorders tiled |||
    smartBorders (Mirror tiled) |||
    spiral (6/7)  |||
    ThreeColMid 1 (3/100) (1/2) |||
    noBorders Full
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2

myMouseBindings XConfig {XMonad.modMask = modMask} = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)

    ]

myKeys conf@XConfig {XMonad.modMask = modMask} = M.fromList $
  ----------------------------------------------------------------------

  [
  -- SUPER + FUNCTION KEYS
    ((modMask, xK_d), spawn "dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=14'")
  , ((modMask, xK_f), sendMessage $ Toggle NBFULL)
  , ((modMask, xK_h), spawn "urxvt 'htop task manager' -e htop" )
  , ((modMask, xK_l), spawn "slimlock" )
  , ((modMask, xK_q), kill )
  , ((modMask, xK_r), spawn "xfce4-appfinder" )
  , ((modMask, xK_t), spawn "urxvt" )
  , ((modMask, xK_v), spawn "pavucontrol" )
  , ((modMask, xK_w), spawn ".config/polybar/launch.sh" )
  , ((modMask, xK_y), spawn "polybar-msg cmd toggle" )
  , ((modMask, xK_x), spawn "oblogout" )
  , ((modMask, xK_Escape), spawn "xkill" )
  , ((modMask, xK_Return), spawn "urxvt" )
  , ((modMask, xK_F1), spawn ".config/polybar/launch.sh" )
  , ((modMask, xK_F2), spawn "code" )
  , ((modMask, xK_F3), spawn "inkscape" )
  , ((modMask, xK_F4), spawn "gimp" )
  , ((modMask, xK_F5), spawn "meld" )
  , ((modMask, xK_F6), spawn "vlc --video-on-top" )
  , ((modMask, xK_F7), spawn "virtualbox" )
  , ((modMask, xK_F8), spawn "thunar" )
  , ((modMask, xK_F9), spawn "evolution" )
  , ((modMask, xK_F10), spawn "spotify" )
  , ((modMask, xK_F11), spawn "rofi -show run -fullscreen" )
  , ((modMask, xK_F12), spawn "rofi -show run" )
  , ((modMask, xK_a), spawn "setxkbmap -option 'grp:alt_shift_toggle' -layout us,se -variant qwerty" )
  , ((modMask, xK_s), spawn "setxkbmap -option 'grp:alt_shift_toggle' -layout se,us -variant qwerty" )

  -- SUPER + SHIFT KEYS
  , ((modMask .|. shiftMask , xK_Return ), spawn "thunar")
  , ((modMask .|. shiftMask , xK_r ), spawn "xmonad --recompile && xmonad --restart")
  , ((modMask .|. shiftMask , xK_q ), kill)
  , ((modMask .|. shiftMask , xK_x ), io (exitWith ExitSuccess))
  , ((modMask .|. shiftMask , xK_w ), spawn "sudo killall polybar" )

  -- CONTROL + SUPER KEYS
  , ((controlMask .|. modMask, xK_0 ), spawn "filelight")
  , ((controlMask .|. modMask, xK_9 ), spawn "vmware")
  , ((controlMask .|. modMask, xK_c ), spawn "code")
  , ((controlMask .|. modMask, xK_d ), spawn "firefox-developer-edition")
  , ((controlMask .|. modMask, xK_f ), spawn "firefox")
  , ((controlMask .|. modMask, xK_g ), spawn "google-chrome-stable")
  , ((controlMask .|. modMask, xK_h ), spawn "chromium -no-default-browser-check")
  , ((controlMask .|. modMask, xK_j ), spawn "urxvt hold -e julia -p 8 --project=/home/dreuter/Github/julia-paths")
  , ((controlMask .|. modMask, xK_n ), spawn "firefox-nightly")
  , ((controlMask .|. modMask, xK_s ), spawn "spotify")
  , ((controlMask .|. modMask, xK_t ), spawn "urxvt")
  , ((controlMask .|. modMask, xK_v ), spawn "urxvt hold -e sudo openvpn /home/dreuter/.client.ovpn")
  , ((controlMask .|. modMask, xK_Return ), spawn "thunar")
  
  -- CONTROL + ALT KEYS
  , ((controlMask .|. mod1Mask , xK_a ), spawn "xfce4-appfinder")
  , ((controlMask .|. mod1Mask , xK_b ), spawn "thunar")
  , ((controlMask .|. mod1Mask , xK_c ), spawn "code")
  , ((controlMask .|. mod1Mask , xK_e ), spawn "evolution")
  , ((controlMask .|. mod1Mask , xK_f ), spawn "firefox")
  , ((controlMask .|. mod1Mask , xK_d ), spawn "firefox-developer-edition")
  , ((controlMask .|. mod1Mask , xK_h ), spawn "chromium -no-default-browser-check")
  , ((controlMask .|. mod1Mask , xK_g ), spawn "google-chrome-stable")
  , ((controlMask .|. mod1Mask , xK_i ), spawn "nitrogen")
  , ((controlMask .|. mod1Mask , xK_k ), spawn "slimlock")
  , ((controlMask .|. mod1Mask , xK_m ), spawn "xfce4-settings-manager")
  , ((controlMask .|. mod1Mask , xK_o ), spawn "$HOME/.xmonad/scripts/compton-toggle.sh")
  , ((controlMask .|. mod1Mask , xK_s ), spawn "spotify")
  , ((controlMask .|. mod1Mask , xK_t ), spawn "urxvt")
  , ((controlMask .|. mod1Mask , xK_u ), spawn "pavucontrol")
  , ((controlMask .|. mod1Mask , xK_v ), spawn "urxvt hold -e sudo openvpn /home/dreuter/.client.ovpn")
  , ((controlMask .|. mod1Mask , xK_w ), spawn "catfish")
  , ((controlMask .|. mod1Mask , xK_Return ), spawn "urxvt")

  -- ALT + ... KEYS
  , ((mod1Mask, xK_F2), spawn "gmrun" )
  , ((mod1Mask, xK_F3), spawn "xfce4-appfinder" )
  , ((mod1Mask, xK_s), spawn "setxkbmap se")
  , ((mod1Mask, xK_a), spawn "setxkbmap us")

  --CONTROL + SHIFT KEYS
  , ((controlMask .|. shiftMask , xK_Escape ), spawn "xfce4-taskmanager")
  , ((controlMask .|. shiftMask , xK_j ), spawn "urxvt hold -e julia -p 8 --project=/home/dreuter/Github/julia-paths")
  , ((controlMask .|. shiftMask , xK_m ), spawn "urxvt hold -e matlab -nojvm -nodisplay -nosplash")
  , ((controlMask .|. shiftMask , xK_h ), spawn "urxvt hold -e ghci")
  , ((controlMask .|. shiftMask , xK_i ), spawn "urxvt hold -e jshell")
  , ((controlMask .|. shiftMask , xK_r ), spawn "urxvt hold -e R")

  --SCREENSHOTS
  , ((0, xK_Print), spawn "import png:- | xclip -selection clipboard -t image/png")
  , ((controlMask, xK_Print), spawn "gnome-screenshot -i")
  , ((controlMask .|. shiftMask , xK_Print ), spawn "scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots'")

  --MULTIMEDIA KEYS
  -- Mute volume
  , ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
  -- Decrease volume
  , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 5%-")
  -- Increase volume
  , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 5%+")
  -- Increase brightness
  , ((0, xF86XK_MonBrightnessUp),  spawn "xbackColorlight -inc 5")
  -- Decrease brightness
  , ((0, xF86XK_MonBrightnessDown), spawn "xbackColorlight -dec 5")
  , ((0, xF86XK_AudioPlay), spawn "mpc toggle")
  , ((0, xF86XK_AudioNext), spawn "mpc next")
  , ((0, xF86XK_AudioPrev), spawn "mpc prev")
  , ((0, xF86XK_AudioStop), spawn "mpc stop")

  --------------------------------------------------------------------
  --  XMONAD LAYOUT KEYS
  -- mod$->Super
  -- mod1$->Alt
  -- xK_([A-Z]|Keyword}

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space), sendMessage NextLayout)
  --Focus selected desktop
  , ((mod1Mask, xK_Tab), nextWS)
  --Focus selected desktop
  , ((modMask, xK_Tab), nextWS)
  --Focus selected desktop
  , ((controlMask .|. mod1Mask , xK_Left ), prevWS)
  --Focus selected desktop
  , ((controlMask .|. mod1Mask , xK_Right ), nextWS)
  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
  -- Move focus to the next window.
  , ((modMask, xK_j), windows W.focusDown)
  -- Move focus to the previous window.
  , ((modMask, xK_k), windows W.focusUp)
  -- Move focus to the next window.
  , ((modMask, xK_Right), windows W.focusDown)
  -- Move focus to the previous window.
  , ((modMask, xK_Left), windows W.focusUp)
  -- Move focus to the master window.
  , ((modMask .|. shiftMask, xK_m), windows W.focusMaster)
  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
  -- Shrink the master area.
  , ((controlMask .|. shiftMask , xK_Left), sendMessage Shrink)
  -- Expand the master area.
  , ((controlMask .|. shiftMask , xK_Right), sendMessage Expand)
  -- Push window backColor into tiling.
  , ((controlMask .|. shiftMask , xK_Return), withFocused $ windows . W.sink)
  -- Swap the focused window with the previous window.
  , ((controlMask .|. modMask, xK_Left), windows W.swapUp)
  -- Swap the focused window with the next window.
  , ((controlMask .|. modMask, xK_Right), windows W.swapDown)
  -- Increment the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Up), sendMessage (IncMasterN 1))
  -- Decrement the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Down), sendMessage (IncMasterN (-1)))
  
  ]
  
  ++

  [((m .|. modMask, k), windows $ f i)
   | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0,xK_minus,xK_equal]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)
      , (\i -> W.greedyView i . W.shift i, shiftMask)]]

  
  ++

  [((m .|. controlMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


main :: IO ()
main = do
    dbus <- D.connectSession

    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad . ewmh $
            myBaseConfig{
  startupHook = myStartupHook
, layoutHook = gaps [(U,35), (D,5), (R,5), (L,5)] $ myLayout ||| layoutHook myBaseConfig
, manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig
, modMask = myModMask
, borderWidth = myBorderWidth
, handleEventHook    = handleEventHook myBaseConfig <+> fullscreenEventHook
, focusFollowsMouse = myFocusFollowsMouse
, workspaces = myWorkspaces
, focusedBorderColor = focdBordColor
, normalBorderColor = normBordColor
, keys = myKeys
, mouseBindings = myMouseBindings
, terminal    = myTerminal
}