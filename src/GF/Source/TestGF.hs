----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

-- automatically generated by BNF Converter
module Main where


import IO ( stdin, hGetContents )
import System ( getArgs, getProgName )

import LexGF
import ParGF
import SkelGF
import PrintGF
import AbsGF


import ErrM

type ParseFun a = [Token] -> Err a

myLLexer = myLexer

type Verbosity = Int

putStrV :: Verbosity -> String -> IO ()
putStrV v s = if v > 1 then putStrLn s else return ()

runFile :: (Print a, Show a) => Verbosity -> ParseFun a -> FilePath -> IO ()
runFile v p f = putStrLn f >> readFile f >>= run v p

run :: (Print a, Show a) => Verbosity -> ParseFun a -> String -> IO ()
run v p s = let ts = myLLexer s in case p ts of
           Bad s    -> do  putStrLn "\nParse              Failed...\n"
                           putStrV v "Tokens:"
                           putStrV v $ show ts
                           putStrLn s
           Ok  tree -> do putStrLn "\nParse Successful!"
                          putStrV v $ "\n[Abstract Syntax]\n\n" ++ show tree
                          putStrV v $ "\n[Linearized tree]\n\n" ++ printTree tree


main :: IO ()
main = do args <- getArgs
          case args of
            [] -> hGetContents stdin >>= run 2 pGrammar
            "-s":fs -> mapM_ (runFile 0 pGrammar) fs
            fs -> mapM_ (runFile 2 pGrammar) fs
