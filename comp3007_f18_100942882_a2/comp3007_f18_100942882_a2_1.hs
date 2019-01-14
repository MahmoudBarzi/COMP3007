-- Mahmoud Asadzadeh-Barzi
-- 100942882
import Codec.BMP
import GHC.Word
import Data.ByteString hiding (take,drop)
import Debug.Trace

-- For this code to work you will need to have installed the package "bmp-1.2.6.3"
-- You can do this using the cabal package manager (as demonstrated in class)
-- or you can follow a procedure similar to the one detailed below:
--
-- 1. Download bmp-1.2.6.3.tar.gz from http://hackage.haskell.org/package/bmp
-- 2. Extract the folder bmp-1.2.6.3
-- 3. Open a terminal (with administrator rights) and do the following:
--    a. cd into bmp-1.2.6.3
--    b. runhaskell Setup configure
--    c. runhaskell Setup build
--    d. runhaskell Setup install

loadBitmapIntoIt :: FilePath -> IO ([(Int, Int, Int)], Int, Int)
loadBitmapIntoIt filename = do
  (Right bmp) <- readBMP filename
  return ((parseIntoRGBVals (convertToIntList (unpack (unpackBMPToRGBA32 bmp)))), (fst (bmpDimensions bmp)), (snd (bmpDimensions bmp)))

convertToIntList :: [Word8] -> [Int]
convertToIntList [] = []
convertToIntList (h:t) = (fromIntegral (toInteger h)) : (convertToIntList t)

parseIntoRGBVals :: [Int] -> [(Int, Int, Int)]
parseIntoRGBVals [] = []
parseIntoRGBVals (h:i:j:_:t) = (h,i,j) : (parseIntoRGBVals t)

-- recursiveA :: ([(Int, Int, Int)], Int, Int) -> [[(Int, Int, Int)]]
-- recursiveA is the function I have written to address requirement(a)
recursiveA :: ([(Int, Int, Int)], Int, Int) -> [[(Int, Int, Int)]]
recursiveA ([],_,_) =  []
recursiveA (a,w,l) = take w a:recursiveA((drop w a) , w, l) 



helpRecursiveB':: [(Int, Int, Int)] -> [(Int, Int, Int)]
helpRecursiveB' [] = []
helpRecursiveB' (h:t)
   |not(h == (0,0,0) || h == (255,255,255)) = (255,255,255):helpRecursiveB' t
   |otherwise = h:helpRecursiveB' t


recursiveB' :: [[(Int, Int, Int)]] -> [[(Int, Int, Int)]]
recursiveB' [] = [] 
recursiveB' (h:t) = helpRecursiveB' h:recursiveB' t

-- recursiveB :: [[(Int, Int, Int)]] -> [[(Int, Int, Int)]]
--recursiveB is the function I have written to address requirement(b)
recursiveB :: [[(Int, Int, Int)]] -> [[(Int, Int, Int)]]
recursiveB x = invertImage(recursiveB' x)

helpShowAsASCIIArt'::[(Int, Int, Int)] -> [Char]
helpShowAsASCIIArt' [] = []
helpShowAsASCIIArt'(h:t)
   |(h == (0,0,0))= '#':helpShowAsASCIIArt' t
   |otherwise = '_':helpShowAsASCIIArt' t

showAsASCIIArt' :: [[(Int, Int, Int)]] -> [[Char]]
showAsASCIIArt' [] = []
showAsASCIIArt' (h:t)= helpShowAsASCIIArt' h : showAsASCIIArt' t
 
showAsASCIIArt :: [[(Int, Int, Int)]] -> IO ()
showAsASCIIArt pixels = Prelude.putStr (unlines (showAsASCIIArt' pixels))

invertImage ::[[(Int, Int, Int)]] -> [[(Int, Int, Int)]]
invertImage [] = []
invertImage (h:t) = (invertImage t) ++ [h]













