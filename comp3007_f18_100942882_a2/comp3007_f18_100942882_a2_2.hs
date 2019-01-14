-- Mahmoud Asadzadeh-Barzi
-- 100942882
import GHC.Word
import Data.ByteString hiding (take,drop)
import Debug.Trace

data TVL = Tru | Unknown | Falz deriving (Show, Eq,Enum)

ternaryNOT:: TVL -> TVL
ternaryNOT Tru = Falz 
ternaryNOT Unknown = Unknown
ternaryNOT Falz = Tru

ternaryAND:: TVL -> TVL -> TVL
ternaryAND Falz _ = Falz
ternaryAND _ Falz = Falz
ternaryAND Tru Tru = Tru
ternaryAND _ _ = Unknown

ternaryOR:: TVL -> TVL -> TVL
ternaryOR Tru _ = Tru 
ternaryOR _ Tru = Tru 
ternaryOR Falz Falz = Falz
ternaryOR _ _ = Unknown

