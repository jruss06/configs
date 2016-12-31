import XMonad
import qualified Data.Map as M
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import XMonad.Layout.PerWorkspace
import Control.Monad (liftM2)

myManageHook = composeAll
    [ className =? "mpv"      --> doFloat
    , className =? "MuPDF" --> viewShift "5"
    , className =? "Lxappearance" --> doFloat
    , className =? "Geany" --> doShift "3"
    ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift


main = xmonad =<< xmobar myConfig

myConfig = defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod4Mask
    , borderWidth = 3
    , keys          = \c -> mykeys c `M.union` keys defaultConfig c
    , workspaces = myWorkspaces
    , logHook = dynamicLog
    , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  
                   onWorkspace "1" firstL $
                   onWorkspace "3" numTwo $
                   myLayout
    , handleEventHook = mconcat
                         [ docksEventHook
                         , handleEventHook defaultConfig ]   
    }
   where
    mykeys (XConfig {modMask = modm}) = M.fromList $
         [ ((modm , xK_x), kill) 
         , ((modm, xK_p), spawn "dmenu_run")
         , ((modm,               xK_a), sendMessage MirrorShrink)
         , ((modm,               xK_z), sendMessage MirrorExpand)
	 ]
         ++
         [((m .|. mod4Mask, k), windows $ f i) -- Replace 'mod1Mask' with your mod key of choice.
         | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]


myLayout =  (spacing 10 $ ResizableTall 1 (3/100) (1/2) []) ||| ( spacing 10 $ (Mirror $ ResizableTall 1 (3/100) (1/2) [])) ||| layoutHook defaultConfig
firstL = spacing 15 $ ResizableTall 1 (3/100) (1/2) []
numTwo = spacing 20 $ ResizableTall 1 (3/100) (1/2) []
