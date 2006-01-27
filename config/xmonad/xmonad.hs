-------------------------------------------------------------------------------
-- |
-- Module      :  xmonad.hs
-- Copyright   :  (c) Patrick Brisbin 2010 
-- License     :  as-is
--
-- Maintainer  :  pbrisbin@gmail.com
-- Stability   :  unstable
-- Portability :  unportable
--
-- Now available in git http://github.com/pbrisbin/xmonad-config
--
-------------------------------------------------------------------------------

-- Imports {{{

-- my lib
import Dzen           -- http://pbrisbin.com/xmonad/docs/Dzen.html
import ScratchPadKeys -- http://pbrisbin.com/xmonad/docs/ScratchPadKeys.html
import SendFile       -- http://pbrisbin.com/xmonad/docs/SendFile.html
--import RssReader      -- http://pbrisbin.com/xmonad/docs/RssReader.html

-- xmonad
import XMonad hiding ((|||))
import qualified XMonad.StackSet as W

-- xmonad-contrib
import XMonad.Actions.CycleWS            (toggleWS)
import XMonad.Actions.FindEmptyWorkspace (tagToEmptyWorkspace, viewEmptyWorkspace)
import XMonad.Actions.GroupNavigation    (Direction(..), historyHook, nextMatch)
import XMonad.Actions.Warp               (Corner(..), banishScreen)
import XMonad.Actions.WithAll            (killAll)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops         (ewmh)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

-- Layouts
import XMonad.Layout.IM                  (Property(..), withIM)
import XMonad.Layout.LayoutCombinators   ((|||), JumpToLayout(..))
import XMonad.Layout.LayoutHints         (layoutHintsWithPlacement)
import XMonad.Layout.NoBorders           (Ambiguity(..), With(..), lessBorders)
import XMonad.Layout.PerWorkspace        (onWorkspace)
import XMonad.Layout.ResizableTile       (ResizableTall(..), MirrorResize(..))

import XMonad.Layout.Tabbed
import XMonad.Layout.DragPane
import XMonad.Layout.DecorationMadness
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.Grid
import XMonad.Layout.Reflect
import XMonad.Layout.DwmStyle
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Spacing

import XMonad.Util.EZConfig              (additionalKeysP)
import XMonad.Util.Loggers               (Logger, logCmd, battery, date, dzenColorL, wrapL, shortenL)
import XMonad.Util.Run                   (spawnPipe)
import XMonad.Util.WindowProperties      (getProp32s)
import XMonad.Actions.GridSelect
--import XMonad.Util.WorkspaceCompare      (getSortByXineramaRule)

import qualified XMonad.Prompt as P

-- general haskell stuff
import Data.List             (isPrefixOf)
import System.IO             (Handle, hPutStrLn, hGetContents)
import System.Process        (runInteractiveCommand)
import System.FilePath.Posix (splitFileName)

-- }}}

-- Main {{{
main :: IO ()
main = do
    d <- spawnDzen myLeftBar

    --spawn "conky"
    --spawn $ "conky -c ~/.dzen_conkyrc | " ++ show myRightBar
	--spawnDzen myRssBar >>= spawnReader myReaderConf
	--spawnDzen myRtopBar >>= "~/Scripts/dzen/rtop.sh"

    -- ewmh just makes wmctrl work
    xmonad $ ewmh $ withUrgencyHookC myUrgencyHook myUrgencyConfig $ defaultConfig
        { terminal           = myTerminal
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , logHook            = myLogHook d
        } `additionalKeysP` myKeys

-- }}}

-- Options {{{
myTerminal           = "urxvtc"
myBorderWidth        = 3
myNormalBorderColor  = colorFG5
myFocusedBorderColor = colorFG4

-- if you change workspace names, be sure to update them throughout
myWorkspaces = ["1-main","2-web","3-chat"] ++ map show [4..9]
--myWorkspaces   = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι"]

-- aur/dzen2-svn is required for an xft font
--myFont = "Verdana-8"
--myFont = "Envy Code R-8"
myFont = "montecarlo-10"
--myFont = "Droid Sans Mono Slashed-08"

-- background/foreground and various levels of emphasis
colorBG  = "#303030"
colorFG  = "#616161"
colorFG2 = "#909090"
colorFG3 = "#c4df90"
colorFG4 = "#cc896d"
colorFG5 = "#c4df90"
colorFG6 = "#ffffba"
--colorFG7 = "#b65def"
colorFG7 = "#6c3d8a"

-- Bitmap dir
myBitmapDir	 = "/home/ricardo/Scripts/dzen/xbm"

-- }}}

-- Layouts {{{
--
-- See http://pbrisbin.com/posts/xmonads_im_layout/
--
myLayout = avoidStruts $ onWorkspace "3-chat" imLayout standardLayouts

    where
        -- use standardLayouts just like any other workspace
        imLayout = withIM (1/10) (Role "roster") standardLayouts

        -- a simple Tall, Wide, Full setup but hinted, resizable, and
        -- with smarter borders
        standardLayouts = smart $ tiled ||| Mirror tiled ||| full

        tiled = hinted $ ResizableTall 1 (1/100) golden []
        full  = hinted Full

        -- master:slave set at the golden ratio
        golden = toRational $ 2/(1 + sqrt 5 :: Double)

        -- just like smartBorders but better for a xinerama setup
        smart = lessBorders $ Combine Union OnlyFloat OtherIndicated

        -- like hintedTile but applicable to any layout
        hinted l = layoutHintsWithPlacement (0,0) l

-- }}}

-- ManageHook {{{
myManageHook :: ManageHook
myManageHook = mainManageHook <+> manageDocks <+> manageFullScreen <+> manageScratchPads scratchPadList

    where
        -- the main managehook
        mainManageHook = composeAll $ concat
            [ [ resource  =? r     --> doIgnore         |  r    <- myIgnores ]
            , [ className =? c     --> doShift "2-web"  |  c    <- myWebs    ]
            , [ title     =? t     --> doShift "3-chat" |  t    <- myChats   ]
            , [ className =? c     --> doShift "3-chat" | (c,_) <- myIMs     ]
            , [ className =? c     --> doFloat          |  c    <- myFloats  ]
            , [ className =? c     --> doCenterFloat    |  c    <- myCFloats ]
            , [ name      =? n     --> doCenterFloat    |  n    <- myCNames  ]
            , [ classNotRole (c,r) --> doFloat          | (c,r) <- myIMs     ]
            , [ isDialog           --> doCenterFloat                         ]
            ]

        -- fullscreen but still allow focusing of other WSs
        manageFullScreen = isFullscreen --> doF W.focusDown <+> doFullFloat

        -- a special query to find an im window that's not my buddy list
        classNotRole :: (String,String) -> Query Bool
        classNotRole (c,r) = className =? c <&&> role /=? r

        role = stringProperty "WM_WINDOW_ROLE"
        name = stringProperty "WM_NAME"

        myIMs     = [("emesene","roster")]
        myIgnores = ["desktop","desktop_window","stalonetray"]
        myChats   = ["irssi","mutt" ]
        myWebs    = ["Uzbl","Uzbl-core","Jumanji","Chromium","Namoroka","Firefox","Vimperator"]
        myFloats  = ["MPlayer","Zenity","VirtualBox","rdesktop","Sonata","Nitrogen","Eclipse","Eclipse SDK"]
        myCFloats = ["Xmessage","Save As...","XFontSel"]
        myCNames  = ["bashrun"]

-- }}}

-- StatusBars {{{
--
-- See http://pbrisbin.com/xmonad/docs/Dzen.html
--
myLeftBar :: DzenConf
myLeftBar = defaultDzen
    { width       = 1000
    , height    = 16
    , font        = myFont
    , fg_color    = colorFG
    , bg_color    = "#111111"
    }

--myLbottomBar :: DzenConf
--mLbottomBar = defaultDzen
    --{ width       = 1000
    --, height      = 20
    --, font        = myFont
    --, fg_color    = colorFG
    --, bg_color    = "#111111"
    --}
-- }}}

-- Prompt {{{
promptConfig :: P.XPConfig
promptConfig = P.defaultXPConfig 
    { P.font        = myFont
    , P.bgColor     = colorBG
    , P.fgColor     = colorFG2
    , P.fgHLight    = colorFG4
    , P.bgHLight    = colorBG
    , P.borderColor = colorFG
    }

-- }}}

-- LogHook {{{
myLogHook :: Handle -> X ()
myLogHook h = do
    -- the main logHook
    dynamicLogWithPP $ defaultPP
        { ppCurrent         = dzenBG colorFG4 . dzenFG "#000000" . pad
        --, ppVisible         = dzenBG colorFG2 . noScratchPad
        , ppHidden          = dzenBG colorBG . dzenFG colorFG4 . noScratchPad
        , ppHiddenNoWindows = namedOnly
        , ppUrgent          = dzenBG "#FF0000" . dzenFG colorBG . pad . dzenStrip
        , ppSep             = replicate 4 ' '
        , ppWsSep           = []
        , ppTitle           = dzenFG colorFG4 . shorten 100
        , ppLayout          = dzenFG colorFG2 . renameLayouts . stripIM
        --, ppSort            = getSortByXineramaRule
        , ppExtras          = [myLoad, myBat, myWifi]
        , ppOutput          = hPutStrLn h
        }

    -- update window focus history
    historyHook

    where
        -- don't show 4-9 if they're empty, never show NSP
        namedOnly    ws = if any (`elem` ws) ['a'..'z'] then pad ws else ""
        noScratchPad ws = if ws /= "NSP"                then pad ws else ""

        -- if the title appears to be a filename, highlight the basename
        highlightBase c s = 
            case splitFileName s of
                ("", baseName)      -> s
                (dirName, baseName) -> dirName ++ dzenFG c baseName

        -- L needed for loggers
        dzenFBG c1 c2 = dzenColor c1 c2
        dzenBG  c = dzenColor "" c
        dzenFG  c = dzenColor  c ""
        dzenFGL c = dzenColorL c "" 

        -- custom loggers
        myLoad    = wrapL "Load: "    "" . dzenFGL colorFG4 $ logCmd "perl ~/Scripts/dzen/load.pl"
        myBat     = wrapL "Bat: "     "" . dzenFGL colorFG4 $ battery
        --myUpdates = wrapL "Updates: " "" . dzenFGL colorFG4 $ logCmd "cat ~/Scripts/pacman_updates"
		--shit
		--myWifi    = wrapL "Wifi: "    "" . dzenFGL colorFG6 $ logCmd "cat ~/Scripts/dzen/wifi.sh"
        myWifi    = wrapL "Wifi: "    "" . dzenFGL colorFG5 $ logCmd "sh ~/Scripts/dzen/wifi.sh"
        myRtop    = wrapL ""    "" . dzenFGL colorFG5 $ logCmd "zsh ~/Scripts/dzen/newRtop.sh"
        myVol     = wrapL "Vol: "    "" . dzenFGL colorFG5$ logCmd "sh ~/Scripts/dzen/vol.sh"
        myMpc     = wrapL "Mpc: "    "" . dzenFGL colorFG5$ logCmd "sh ~/Scripts/dzen/mpc.sh"
        myDate    = wrapL "Time: "    "" . dzenFGL colorFG5 $ date "%H:%M"
        
        -- count the lines of output of an arbitary command
        countOutputLines :: String -> Logger
        countOutputLines c = io $ do
            (_, out, _, _) <- runInteractiveCommand c
            doCount out `catch` const (return Nothing)
        
            where
                -- 0 returns nothing
                doCount h = hGetContents h >>= \c ->
                    case length $ lines c of
                        0 -> return Nothing
                        n -> return $ Just $ show n

        renameLayouts s = case s of
            "Hinted ResizableTall"			-> "^i(" ++ myBitmapDir ++ "/tall.xbm)"
            "Mirror Hinted ResizableTall"   -> "^i(" ++ myBitmapDir ++ "/mtall.xbm)"
            "Hinted Full"                   -> "^i(" ++ myBitmapDir ++ "/full.xbm)"
            _                               -> s

        stripIM s = if "IM " `isPrefixOf` s then drop (length "IM ") s else s
-- }}}

-- SpawnHook {{{
--
-- Spawn any arbitrary command on urgent
--
data MySpawnHook = MySpawnHook String deriving (Read, Show)

instance UrgencyHook MySpawnHook where
    urgencyHook (MySpawnHook s) _ = spawn s

myUrgencyHook :: MySpawnHook
myUrgencyHook = MySpawnHook "mplayer /home/ricardo/Downloads/newmail.wav"

myUrgencyConfig :: UrgencyConfig
myUrgencyConfig = UrgencyConfig OnScreen (Repeatedly 3 30)

-- }}}

-- KeyBindings {{{
myKeys :: [(String, X())]
myKeys = [ ("M-p"                   , spawn "dmenu_launch.sh"               ) -- dmenu app launcher
         , ("M-<F2>"                 , spawn "dmenu_launch.sh"                ) -- gmrun replacement
         , ("M4-f"                  , sendFile                       ) -- prompt for and send a file via mutt
         , ("M4-m"                  , myMail                         ) -- open mail client
         , ("M4-b"                  , myBrowser                      ) -- open web client
         , ("M4-e"                  , myFM                        ) -- open/close tray 
         , ("M4-l"                  , myLock                         ) -- W-l to lock screen
         , ("M4-i"                  , myIRC                          ) -- open/attach IRC client in screen
         , ("M4-r"                  , myTorrents                     ) -- open/attach rtorrent in screen 
         , ("M-j"                   , spawn "dmenu-mpc-search.sh"            ) -- search current playlist via dmenu
		 , ("M4-<Tab>", spawnSelected defaultGSConfig ["urxvtc -e tmux attach","urxvtd", "sonata","nitrogen","gvim", "dropboxd"])
         , ("<Print>"               , spawn "scrot"                  ) -- take a screenshot

         -- extended workspace navigations
         , ("M-`"                   , toggleWS                       ) -- switch to the most recently viewed ws
         , ("M-<Backspace>"         , focusUrgent                    ) -- focus most recently urgent window
         , ("M-S-<Backspace>"       , clearUrgents                   ) -- make urgents go away
         , ("M-0"                   , viewEmptyWorkspace             ) -- go to next empty workspace
         , ("M-S-0"                 , tagToEmptyWorkspace            ) -- send window to empty workspace and view it

         -- extended window movements
         , ("M-o"                   , mirrorShrink                   ) -- shink slave panes vertically
         , ("M-i"                   , mirrorExpand                   ) -- expand slave panes vertically
         , ("M-f"                   , jumpToFull                     ) -- jump to full layout
         , ("M-b"                   , banishScreen LowerLeft        ) -- banish the mouse
         --, ("M-<Tab>"               , nextMatch History (return True)) -- recreates a "normal" Alt-Tab
         , ("M-S-<Tab>"               , goToSelected defaultGSConfig   ) -- grid select 

         -- non-standard screen navigation
         , ("M-h"                 , shrink                         ) -- shrink master (was M-h)
         , ("M-l"                 , expand                         ) -- expand master (was M-l)

         -- media keys
         , ("<XF86HomePage>"        , myBrowser                      ) -- open web client
         , ("<XF86MailForward>"     , spawn "rfkill.sh"            ) -- use wpa_auto to reconnect
         , ("<XF86Mail>"            , spawn "thunderbird"            ) -- open mail client
         , ("<XF86AudioPlay>"       , spawn "/usr/bin/mpc -q toggle"          ) -- play/pause mpd
         , ("<XF86AudioStop>"       , spawn "/usr/bin/mpc -q stop"            ) -- stop mpd
         , ("<XF86AudioPrev>"       , spawn "/usr/bin/mpc -q prev"            ) -- prev song
         , ("<XF86AudioNext>"       , spawn "/usr/bin/mpc -q next"            ) -- next song
         , ("<XF86AudioMute>"       , spawn "amixer -q set Master toggle" ) -- toggle mute
         , ("<XF86AudioLowerVolume>", spawn "amixer -q set PCM 10- unmute"            ) -- volume down 
         , ("<XF86AudioRaiseVolume>", spawn "amixer -q set PCM 10+ unmute"            ) -- volume up
         --, ("M-<XF86AudioPlay>"     , mplayer "pause"                ) -- play/pause mplayer
--         , ("M-<XF86AudioStop>"     , mplayer "stop"                 ) -- stop mplayer
         --, ("M-<XF86AudioPrev>"     , mplayer "seek -10"             ) -- seek back 10s
         --, ("M-<XF86AudioNext>"     , mplayer "seek 10"              ) -- seek forward 10s
         , ("<XF86PowerOff>"		, spawn "shutdown-dialog.py"     ) -- Log off
		 , ("<XF86Sleep>"			, spawn "sudo pm-suspend"		 ) -- Stand by

         -- kill, reconfigure, exit
         , ("M4-S-c"                , killAll                        ) -- close all windows on this ws
         , ("M-<F4>"                , kill							 ) -- close current window
         , ("M-q"                   , myRestart                      ) -- restart xmonad
         , ("M-S-q"                 , spawn "leave"                  ) -- logout menu

         -- See http://pbrisbin.com/xmonad/docs/ScratchPadKeys.html
         ] ++ scratchPadKeys scratchPadList

    where

        shrink = sendMessage Shrink
        expand = sendMessage Expand

        mirrorShrink = sendMessage MirrorShrink
        mirrorExpand = sendMessage MirrorExpand

        focusScreen n = screenWorkspace n >>= flip whenJust (windows . W.view)
        jumpToFull    = sendMessage $ JumpToLayout "Hinted Full"

        myBrowser  = spawn "$BROWSER"
        --myLock     = spawn "alock -auth=pam -bg ~ricardo/Walls/brb.jpg"
        myLock     = spawn "lockx"
        myFM    = spawn "pcmanfm"
        myMail     = spawn $ myTerminal ++ " -e mutt"

        -- see http://pbrisbin.com/xmonad/docs/SendFile.html
        sendFile   = sendFilePrompt promptConfig "~/.mutt/alias"

        -- see http://pbrisbin.com/posts/screen_tricks/
        myIRC      = spawnInScreen "irssi"
        myTorrents = spawnInScreen "rtorrent"

        spawnInScreen s = spawn $ unwords [ myTerminal, "-title", s, "-e bash -cl", command s ]

            where
                -- a quoted command to pass off to bash -cl
                --command s = ("\""++) . (++"\"") $ unwords ["SCREEN_CONF=" ++ s, "screen -S", s, "-R -D", s]
                command s = ("\""++) . (++"\"") $ unwords ["SCREEN_CONF=" ++ s, "tmux -S", s, "-R -D", s]

        -- see http://pbrisbin.com/posts/controlling_mplayer/
        mplayer s = spawn $ unwords [ "echo", s, "> $HOME/.mplayer/mplayer.fifo" ]

        -- kill all conky/dzen2 before executing default restart command
        myRestart = spawn $ "for pid in `pgrep conky`; do kill -9 $pid; done && " ++
                            "for pid in `pgrep dzen2`; do kill -9 $pid; done && " ++
                            "xmonad --recompile && xmonad --restart"

-- }}}
