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
    callCommand "killall dunst"
    callCommand "dunst &"
    putStrLn "### Updating vis ###"
    callCommand "sh ~/dotfiles/vis/vis_script.sh"
    putStrLn "### Done ###"

-- ranger . --choosefile=output; update_theme $(cat output); rm output
startPicker :: IO ()
startPicker = do
    callCommand "ranger . --choosefile=/tmp/output"
    path <- readFile "/tmp/output"
    callCommand "rm /tmp/output"
    putStrLn ("Image path: " ++ path)

    putStrLn "Pick a backend [1,2,3] (1: wal, 2: haishoku, 3: colorthief):"
    backendInput <- getLine
    let backend = case readMaybe backendInput :: Maybe Int of
          Just 1 -> "wal"
          Just 2 -> "haishoku"
          Just 3 -> "colorthief"
          _      -> "none"

    if backend == "none"
       then do { let backend = "wal"
               ; putStrLn "Backend choice not in [1,2,3], picked 'wal' as default" }
    else putStrLn ("Backend: " ++ backend)

    putStrLn "Opacity [0-100] (leave empty for 100%):"
    alphaInput <- getLine
    let alphaParsed = case readMaybe alphaInput :: Maybe Int of
                  Just num -> num
                  Nothing -> -1

    let alpha = case alphaParsed of
                  -1 -> 100
                  _ -> alphaParsed

    if alphaParsed < 0 || alphaParsed > 100
       then putStrLn "Opacity not in range [0,100], picked '100' as default"
    else putStrLn ("Opacity: " ++ show alpha)

    updateTheme path backend alpha
