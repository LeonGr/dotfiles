module Functionality where

import System.Process
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)

updateTheme :: FilePath -> String -> Int -> IO ()
updateTheme path backend alpha = do
    callWal path backend alpha
    updateParts

callWal :: FilePath -> String -> Int -> IO ()
callWal path backend alpha = do
    putStrLn "### Calling wal ###"
    callProcess "wal" ["-a", show alpha, "-i", path, "--backend", backend]

updateParts :: IO ()
updateParts = do
    putStrLn "### Updating bspwmrc ###"
    callCommand "sh /home/leon/dotfiles/bspwm/bspwmrc &"
    putStrLn "### Updating dunst ###"
    callCommand "sh ~/dotfiles/dunst/dunst_script.sh"
    callCommand "killall dunst"
    callCommand "dunst &"
    putStrLn "### Updating vis ###"
    callCommand "sh ~/dotfiles/vis/vis_script.sh"
    putStrLn "### Done ###"

-- ranger . --choosefile=output; update_theme $(cat output); rm output
startPicker :: IO ()
startPicker = do
    callCommand "ranger . --choosefile=/tmp/output"
    putStrLn "Pick a backend (wal, haishoku, colorthief):"
    backendInput <- getLine
    putStrLn "Opacity (leave empty for 100%):"
    alphaInput <- getLine
    alpha <- fromMaybe 100 (readMaybe alphaInput :: Maybe Int)
    putStrLn ("test" ++ show alpha)
