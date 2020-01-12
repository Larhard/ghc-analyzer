--A.hs
--invoke: ghci -package ghc A.hs

{-# LANGUAGE CPP #-}
import GHC
import Outputable
import HscTypes ( mgModSummaries )
 
import GHC.Paths ( libdir )
--GHC.Paths is available via cabal install ghc-paths
 
import DynFlags
targetFile = "Example.hs"

ghcToString :: (GhcMonad m, Outputable a) => a -> m String
ghcToString k = do
    dflags <- getSessionDynFlags
    return $ showSDoc dflags $ ppr k

main :: IO ()
main = do
   res <- example
   str <- runGhc (Just libdir) $ ghcToString res
   putStrLn str
 
example = 
    defaultErrorHandler defaultFatalMessager defaultFlushOut $ do
      runGhc (Just libdir) $ do
        dflags <- getSessionDynFlags
        setSessionDynFlags dflags
        target <- guessTarget targetFile Nothing
        setTargets [target]
        load LoadAllTargets
        modSum <- getModSummary $ mkModuleName "Example"
        p <- parseModule modSum
        t <- typecheckModule p
        d <- desugarModule t
        l <- loadModule d
        n <- getNamesInScope
        c <- return $ coreModule d
 
        g <- getModuleGraph

        s <- return $ mgModSummaries g
        shown <- mapM showModule s
        return $ (parsedSource d, "/nTEST-/n", typecheckedSource d, "/n-----/n", shown)
