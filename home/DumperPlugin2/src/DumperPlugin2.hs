{-# LANGUAGE OverloadedStrings #-}

module DumperPlugin2 (plugin) where
import GhcPlugins
import JSONPrint


plugin :: Plugin
plugin = defaultPlugin {
    installCoreToDos = install
}

install :: [CommandLineOption] -> [CoreToDo] -> CoreM [CoreToDo]
install _ todo = do
    putMsgS $ "yay: init"
    putMsg $ ppr todo
    return $ CoreDoPluginPass "Dump Trees" pass : todo

processCoreBind :: CoreBind -> CoreM ()
processCoreBind bind = do
    putMsg $ ppr bind
    putMsg $ text "---------- BEGIN JSON DUMP ----------"
    putMsg $ jpr bind
    putMsg $ text "---------- END JSON DUMP ----------"

pass :: ModGuts -> CoreM ModGuts
pass guts = do
    -- putMsg $ ppr $ mg_rdr_env guts
    -- putMsg $ ppr $ mg_binds guts
    mapM processCoreBind $ mg_binds guts
    return guts
