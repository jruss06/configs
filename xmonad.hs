import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.ResizableTile
import Control.Monad (liftM2)
import Data.List 
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CycleWS
import XMonad.Layout.ToggleLayouts
import XMonad.Actions.FloatKeys

myManageHook = composeAll
   [ className =? "mpv"  --> doFloat  
   , isFullscreen --> doFullFloat 
   , manageDocks 
   ]
   --where viewShift = doF . liftM2 (.) W.greedyView W.shift 
  

main = do
     xmproc <- spawnPipe "xmobar"
     xmonad $ defaultConfig
        { manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts  ( myLayout ||| layoutHook defaultConfig) 
        ,handleEventHook = mconcat
                         [ docksEventHook
                         , handleEventHook defaultConfig ]
	,logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }        
        , modMask = mod4Mask
	,terminal = "urxvt"
        }`additionalKeys`
 	[  ((mod4Mask, xK_x), kill)
        , ((mod4Mask , xK_p), spawn "dmenu_extended_run")  
	, ((mod4Mask,               xK_a), sendMessage MirrorShrink)
 	, ((mod4Mask,               xK_z), sendMessage MirrorExpand)
        , ((mod4Mask,               xK_c), toggleWS)
        , ((mod4Mask, 		    xK_f), sendMessage (Toggle "Full")) 
        , ((mod4Mask, 		    xK_s), withFocused $ float)
        , ((mod4Mask,               xK_Down  ), withFocused (keysResizeWindow (-10,-10) (0,0)))
 	, ((mod4Mask,               xK_Up    ), withFocused (keysResizeWindow (20,20) (0,1)))
  	, ((mod4Mask .|. shiftMask, xK_Left  ), withFocused (keysMoveWindow (-10,0) ))
 	, ((mod4Mask .|. shiftMask, xK_Right    ), withFocused (keysMoveWindow (10,0) ))
	, ((mod4Mask .|. shiftMask, xK_Up  ), withFocused (keysMoveWindow (0,-10) ))
 	, ((mod4Mask .|. shiftMask, xK_Down    ), withFocused (keysMoveWindow (0,10) ))
	]
      
myLayout = toggleLayouts Full (ResizableTall 1 (3/100) (1/2) [] )  	

