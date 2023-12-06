-- Function to convert a string to an integer.
stoi :: String -> Int
stoi s = read s :: Int

-- Parse a line that is like "Time:       1    2    3" into a list of [1,2,3].
parseNumbers :: String -> [Int]
parseNumbers = map stoi . drop 1 . words

-- Simulate how many ways we can destroy the distance record.
-- Arguments are timeLeft, distance, currentSpeed
simulate' :: Int -> Int -> Int -> Int
simulate' 0 _ _ = 0
simulate' time distance speed = res + simulate' (time - 1) distance (speed + 1)
    where res = if (time * speed) > distance then 1 else 0

-- Version of function with 2 arguments, just time and distance.
simulate :: Int -> Int -> Int
simulate time distance = simulate' time distance 0

-- Solution for part one is for how many ways we can destroy each game, multiplied together.
solvePartOne :: [Int] -> [Int] -> Int
solvePartOne time distance = product $ map (\(t, d) -> simulate t d) $ zip time distance

-- Function to join a list of integers into one big integer.
join :: [Int] -> Int
join = read . concatMap show

-- The numbers are actually concatenated together. Do the same thing but only one race.
solvePartTwo :: [Int] -> [Int] -> Int
solvePartTwo time distance = simulate actualTime actualDistance
    where 
        actualTime = join time
        actualDistance = join distance

main :: IO ()
main = do 
    contents <- readFile "input.txt"
    let input = lines contents
    let time = parseNumbers $ input !! 0
    let distance = parseNumbers $ input !! 1

    putStrLn $ "Part one: " ++ show (solvePartOne time distance)
    putStrLn $ "Part two: " ++ show (solvePartTwo time distance)
