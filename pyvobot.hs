import System.Environment (getArgs)

main = do
    name:_ <- getArgs
    putStrLn ("Hello " ++ name ++ "!")
