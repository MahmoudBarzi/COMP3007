-- Mahmoud Asadzadeh-Barzi
-- 100942882
import Data.Maybe
----------------------------------------------------------------------------------------------------------------------------
--Question1
lcg:: Float -> Float--call this function in the command prompt for example try lcg 0.1
lcg x = (fromIntegral (lcg'(toInt(x*97))))/97

lcg':: Int -> Int
lcg' x = mod(4 * x + 19) 97

toInt :: Float -> Int--converting float to Int
toInt i = round i



----------------------------------------------------------------------------------------------------------------------------
--Question2
data Expr  = U
           | Val Float   
           | Add (Expr) (Expr) 
           | Sub (Expr) (Expr)
           | Mul (Expr) (Expr)
           | Div (Expr) (Expr) deriving (Show, Eq)

----------------------------------------------------------------------------------------------------------------------------
--Question3
--Note: my data type Expression for this question3 is generic, so it can handle Strings, Floats, etc... 
data Expression g = Unknown 
                  | Value g 
                  | Addition (Expression g) (Expression g)
                  | Subtraction (Expression g) (Expression g)
                  | Multiplication (Expression g) (Expression g)
                  | Division (Expression g) (Expression g) deriving (Show, Eq)

toFloat :: Maybe Float-> Float
toFloat  (Just f) = f

x::Expression Float
x = Unknown

evaluate :: Expression Float -> Float ->Maybe Float
evaluate (Value n) _ = Just n
evaluate Unknown c = Just c
evaluate (Addition lc rc) s 
        |((evaluate lc s) == Nothing || (evaluate rc s) == Nothing) = Nothing
        | otherwise = Just (toFloat(evaluate (lc) s) + toFloat(evaluate (rc) s))
evaluate (Subtraction lc rc) s 
        |((evaluate lc s) == Nothing || (evaluate lc s) == Nothing) = Nothing
        |otherwise = Just (toFloat(evaluate (lc) s) - toFloat(evaluate (rc) s))
evaluate (Multiplication lc rc) s
        |((evaluate lc s) == Nothing || (evaluate lc s) == Nothing) = Nothing
        |otherwise = Just (toFloat(evaluate (lc) s) * toFloat(evaluate (rc) s))
evaluate (Division lc rc) s
        |(toFloat(evaluate rc s) == 0||(evaluate lc s) == Nothing || (evaluate lc s) == Nothing) = Nothing
        |otherwise = Just (toFloat(evaluate (lc) s) / toFloat(evaluate (rc) s))



-- here's some trees for you to try
-- Note: x must be called by itself in this question, if you try (Value x) the program will
-- give you an error, if you look at the examples below you will have an idea of what I mean.

-- evaluate(Division((Division(Value 100)(Value 10)))(x)) 0
-- evaluate (Addition  (Value 4) (Addition  (x) (Value 6)) ) 2
-- evaluate(Division(Multiplication (Value 3) (Value 2))(Subtraction(x)(Value 31))) 33


evaluateString :: Expression String -> String
evaluateString (Value n) = n
evaluateString (Addition lc rc) = "(" ++ evaluateString(lc) ++" + "++ evaluateString (rc)++")"
evaluateString (Subtraction lc rc) = "(" ++ evaluateString(lc) ++" - "++ evaluateString (rc)++")"
evaluateString (Multiplication lc rc) = "(" ++ evaluateString(lc) ++" * "++ evaluateString (rc)++")"
evaluateString (Division lc rc) = "(" ++ evaluateString(lc) ++" / "++ evaluateString (rc)++")"


-- evaluateString(Addition (Value "2")(Value "3"))
-- evaluateString(Division(Multiplication (Value "3") (Value "2"))(Subtraction(Value "x")(Value "31")))



drawTree :: Expression String -> [String]
drawTree (Value n) = ["    -----"++n]
drawTree (Addition lc rc) = ["( + )"] ++ (drawTree (rc))++ ["   |"] ++(drawTree(lc))
drawTree (Subtraction lc rc) = ["( - )"] ++ (drawTree (rc))++ ["   |"] ++(drawTree(lc))
drawTree (Division lc rc) = ["( / )"] ++ (drawTree (rc))++ ["   |"] ++(drawTree(lc))
drawTree (Multiplication lc rc) = ["( * )"] ++ (drawTree (rc))++ ["   |"] ++(drawTree(lc))

--here's an example:
--drawTree(Multiplication (Value "2")(Value "3"))
--then run this:   putStr(unlines  it)
--------------------------------------------------------------------------------------------------------------------------
--Question4
-- eval is a helper function for treeMutation and all it does it computes the 
-- expression and returns you the results in Floats
eval :: Expression Float-> Float
eval(Value n)= n
eval(Addition lc rc) = (eval (lc)) + (eval (rc))
eval(Subtraction lc rc) = (eval (lc)) - (eval (rc))
eval(Multiplication lc rc) = (eval (lc)) * (eval (rc))

--lcg'' takes a float that is bigger than 1 inclusively and generates a sudorandom number
lcg'':: Float -> Float
lcg'' x = (fromIntegral (lcg'(toInt(x))))


treeMutation:: Expression Float -> Expression Float
-- if the user gives you  this --> (Addition (Value l) (Value r))
-- you will either shrink it or expand it depending on the input 
-- of the user, and this is how its gonna be random 
-- for example if the user gives you (Addition (Value 2) (Value 3))
-- evaluate that expression takes the results of that divide by 97
-- (Note: if you look back at lcg you'll understand why I am dividing by 97)
-- so you can get a number between 0-1 then put it inside of lcg. 
-- If your result is between 0 - 0.5 then shrink the expression
-- otherwise exapnd it. 
treeMutation (Addition (Value l) (Value r))
                        |(lcg((eval(Addition (Value l) (Value r)))/97) > 0.5) = (Addition (Value l) (Value(lcg''(eval(Value r)))))
                        |otherwise = (Addition (Value l) (Subtraction (Value(lcg''(eval(Value l)))) (Value(lcg''(eval(Value r))))))
-- if the user gives you  this --> (Addition Expression Expression)
-- in other words if you have a sub expression shrink it, in a sense
-- that your gonna keep the first expression as is and then you will
-- evaluate the second expression put that result in lcg'' (so its 
-- gonna be random) then return it.                 
treeMutation (Addition lc rc) = (Addition (Value (eval(lc)))  (Value (lcg''(eval(rc)))))



-- this will shrink (it will behave exactly like the example given in part a)
-- treeMutation(Addition (Value 5)(Value 4))

-- this tree will expand (it will behave exactly like the example given in part b)
-- treeMutation(Addition (Value 1)(Value 2))

-- this will shrink (it will behave exactly like the example given in part c) 
-- treeMutation(Addition (Value 1)(Subtraction (Value 3)(Value 4))) 

































