-- import GHC ( defaultErrorHandler, runGhc, getSessionDynFlags, setSessionDynFlags, guessTarget, setTargets, load, LoadHowMuch ( LoadAllTargets ) )
import GHC
import GHC.Paths ( libdir )
import DynFlags ( defaultFatalMessager, defaultFlushOut )

import Outputable

main = do
    res <- solve
    print $ showSDoc ( ppr res )

solve =
    defaultErrorHandler defaultFatalMessager defaultFlushOut $ do
        runGhc ( Just libdir ) $ do
            dflags <- getSessionDynFlags
            setSessionDynFlags dflags
            target <- guessTarget "example.hs" Nothing
            setTargets [target]
            load LoadAllTargets

            modSum <- getModSummary $ mkModuleName "Example"

            return $ ()
