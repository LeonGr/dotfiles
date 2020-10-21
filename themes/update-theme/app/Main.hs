module Main where

import Functionality
import Options.Applicative

data Options = Options
    { path    :: FilePath
    , opacity :: Int
    , backend :: String }

main :: IO ()
main = do
    args <- execParser $
            info
                ( optional optionInput )
                ( fullDesc <> progDesc "Theme updater" )
    case args of
      Just options -> putStrLn (path options ++ " " ++ backend options ++ " " ++ show (opacity options))
      Nothing -> putStrLn "Picker"

optionInput :: Parser Options
optionInput = Options
    <$> strOption (
        long "path" <>
        short 'p' <>
        metavar "<PATH>" <>
        help "Path to background image" )
    <*> option auto (
        long "alpha" <>
        short 'a' <>
        metavar "<0-100>" <>
        help "Terminal background transparency" <>
        value 100 )
    <*> option str (
        long "backend" <>
        short 'b' <>
        metavar "<wal|colorthief|haishoku>" <>
        help "Which color backend to use" )
    <* abortOption ShowHelpText (
        long "help" <>
        short 'h' <>
        help "Display this message")
