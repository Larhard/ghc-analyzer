{-# LANGUAGE OverloadedStrings #-}

module JSONPrint (jpr) where
import GhcPlugins
import Data.Aeson.Types
import Data.Aeson.Encode.Pretty
import CoreSyn
import Data.ByteString (ByteString)
import Data.ByteString.Lazy (toStrict, ByteString)
import Outputable
import Data.Text.Internal
import BasicPrelude (decodeUtf8, textToString)
import Var


instance ToJSON b => ToJSON (Bind b) where
    toJSON (NonRec binder expr) = object ["Class" .= ("Bind" :: String), "Constructor" .= ("NonRec" :: String), "Binder" .= binder, "Expression" .= expr]
    toJSON (Rec exprs) = object ["Class" .= ("Bind" :: String), "Constructor" .= ("Rec" :: String), "Expressions" .= (map (\ (binder, expr) -> object ["Binder" .= binder, "Expression" .= expr]) exprs)]

instance ToJSON Var where
    toJSON v = object ["Class" .= ("Var" :: String), "Name" .= (showSDocUnsafe $ ppr (varName v)), "Type" .= (showSDocUnsafe $ ppr (varType v))]

instance ToJSON b => ToJSON (Expr b) where
    toJSON (Var id) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Var" :: String), "Id" .= (showSDocUnsafe $ ppr id)]
    toJSON (Lit literal) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Lit" :: String), "Literal" .= (showSDocUnsafe $ ppr literal)]  -- TODO
    toJSON (App expression argument) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("App" :: String), "Expression" .= expression, "Argument" .= argument]
    toJSON (Lam binder expr) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Lam" :: String), "Expression" .= expr, "Binder" .= binder]
    toJSON (Let binder expr) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Let" :: String), "Binder" .= binder, "Expression" .= expr]
    toJSON (Case expr binder t alts) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Case" :: String), "Expression" .= expr, "Binder" .= binder, "Type" .= t, "Alternatives" .= map (\ (constructor, binders, expr) -> object ["Constructor" .= ("Alternative" :: String), "AlternativeConstructor" .= constructor, "Binders" .= binders, "Expression" .= expr]) alts]
    toJSON (Cast _ _) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Cast" :: String), "TODO" .= ("XXX" :: String)]
    toJSON (Tick _ _) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Tick" :: String), "TODO" .= ("XXX" :: String)]
    toJSON (Type t) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Type" :: String), "Type" .= (showSDocUnsafe $ ppr t)]
    toJSON (Coercion _) = object ["Class" .= ("Expr" :: String), "Constructor" .= ("Coercion" :: String), "TODO" .= ("XXX" :: String)]

instance ToJSON Type where
    toJSON t = object ["Class" .= ("Type" :: String), "Type" .= (showSDocUnsafe $ ppr t)]

instance ToJSON AltCon where
    toJSON (DataAlt _) = object ["Class" .= ("AltCon" :: String), "Constructor" .= ("DataAlt" :: String)]
    toJSON (LitAlt _) = object ["Class" .= ("AltCon" :: String), "Constructor" .= ("LitAlt" :: String)]
    toJSON DEFAULT = object ["Class" .= ("AltCon" :: String), "Constructor" .= ("DEFAULT" :: String)]


byteStringToString :: Data.ByteString.ByteString -> String
byteStringToString = textToString . decodeUtf8

jpr :: ToJSON a => a -> SDoc
jpr a = Outputable.text . byteStringToString . toStrict . encodePretty $ a
