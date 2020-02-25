module DumperPlugin (plugin) where
import GhcPlugins

plugin :: Plugin
plugin = defaultPlugin {
    installCoreToDos = install
}

install :: [CommandLineOption] -> [CoreToDo] -> CoreM [CoreToDo]
install _ todo = do
    putMsg $ ppr todo
    -- return $ CoreDesugar :: todo
    -- return $ todo ++ todo
    -- return $ todo ++ [CoreDesugar]
    -- return $ todo ++ [CoreDoNothing]
    return $ []
