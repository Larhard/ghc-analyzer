module DumperPlugin (plugin) where
import GhcPlugins

plugin :: Plugin
plugin = defaultPlugin {
    installCoreToDos = install
}

install :: [CommandLineOption] -> [CoreToDo] -> CoreM [CoreToDo]
install _ todo = do
    putMsgS $ "yay: init"
    putMsg $ ppr todo
    return $ CoreDoPluginPass "Dump Trees" pass : todo

pass :: ModGuts -> CoreM ModGuts
pass guts = do
    putMsg $ ppr $ mg_rdr_env guts
    return guts
