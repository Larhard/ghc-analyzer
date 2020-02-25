-- ghc -package ghc Parser.hs

import HsSyn (HsModule)
import RdrName (RdrName)
import System.Environment (getArgs)

main :: IO ()
main = do
    [filename] <- getArgs
    print $ filename
    parsed <- parseHaskell filename
    case parsed of
        Nothing -> putStrLn "Parsing error"
        Just p  -> print $ p

parseHaskell :: FilePath -> IO (Maybe (HsModule RdrName))
parseHaskell = do
    return Nothing
