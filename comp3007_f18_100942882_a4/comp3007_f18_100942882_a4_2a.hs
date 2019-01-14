-- Mahmoud Asadzadeh-Barzi
-- 100942882

countInRange::[Int]->Int->Int->Int
countInRange l r1 r2 = helpCountInRange l r1 r2 0 

helpCountInRange::[Int]->Int->Int->Int->Int
helpCountInRange [] _ _ c = c
helpCountInRange (h:t) r1 r2 c 
                | ((r1<=h) && (h<=r2)) = helpCountInRange t r1 r2 c+1
                | otherwise = helpCountInRange t r1 r2 c
