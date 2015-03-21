{-# LINE 1 "src/runtime/haskell-bind/PGF2.hsc" #-}
{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable, ScopedTypeVariables #-}
{-# LINE 2 "src/runtime/haskell-bind/PGF2.hsc" #-}
-------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : stable
-- Portability : portable
--
-- This is the Haskell binding to the C run-time system for
-- loading and interpreting grammars compiled in Portable Grammar Format (PGF).
-------------------------------------------------

{-# LINE 12 "src/runtime/haskell-bind/PGF2.hsc" #-}

{-# LINE 13 "src/runtime/haskell-bind/PGF2.hsc" #-}

{-# LINE 14 "src/runtime/haskell-bind/PGF2.hsc" #-}

module PGF2 (-- * CId
             CId,
             -- * PGF
             PGF,readPGF,AbsName,abstractName,startCat,
             -- * Concrete syntax
             ConcName,Concr,languages,parse,parseWithHeuristics,
             hasLinearization,linearize,alignWords,
             -- * Types
             Type(..), Hypo, functionType,
             -- * Trees
             Expr,Fun,readExpr,showExpr,mkApp,unApp,mkStr,
             -- * Morphology
             MorphoAnalysis, lookupMorpho, fullFormLexicon,
             -- * Exceptions
             PGFError(..),
             -- * Grammar specific callbacks
             LiteralCallback,literalCallbacks
            ) where

import Prelude hiding (fromEnum)
import Control.Exception(Exception,throwIO)
import Control.Monad(forM_)
import System.IO.Unsafe(unsafePerformIO,unsafeInterleaveIO)
import PGF2.FFI

import Foreign hiding ( Pool, newPool, unsafePerformIO )
import Foreign.C
import Data.Typeable
import qualified Data.Map as Map
import Data.IORef
import Data.Char(isUpper,isSpace)
import Data.List(isSuffixOf,maximumBy)
import Data.Function(on)
--import Debug.Trace

type CId = String
 
-----------------------------------------------------------------------
-- Functions that take a PGF.
-- PGF has many Concrs.
--
-- A Concr retains its PGF in a field in order to retain a reference to
-- the foreign pointer in case if the application still has a reference
-- to Concr but has lost its reference to PGF.

data PGF = PGF {pgf :: Ptr PgfPGF, pgfMaster :: ForeignPtr GuPool}
data Concr = Concr {concr :: Ptr PgfConcr, concrMaster :: PGF}

type AbsName = String -- ^ Name of abstract syntax
type ConcName = String -- ^ Name of concrete syntax
type Cat = String -- ^ Name of syntactic category
type Fun = String -- ^ Name of function

readPGF :: FilePath -> IO PGF
readPGF fpath =
  do pool <- gu_new_pool
     pgf  <- withCString fpath $ \c_fpath ->
               withGuPool $ \tmpPl -> do
                 exn <- gu_new_exn tmpPl
                 pgf <- pgf_read c_fpath pool exn
                 failed <- gu_exn_is_raised exn
                 if failed
                   then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
                           if is_errno
                             then do perrno <- ((\hsc_ptr -> peekByteOff hsc_ptr 24)) exn
{-# LINE 80 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                     errno  <- peek perrno
                                     gu_pool_free pool
                                     ioError (errnoToIOError "readPGF" (Errno errno) Nothing (Just fpath))
                             else do gu_pool_free pool
                                     throwIO (PGFError "The grammar cannot be loaded")
                   else return pgf
     master <- newForeignPtr gu_pool_finalizer pool
     return PGF {pgf = pgf, pgfMaster = master}

languages :: PGF -> Map.Map ConcName Concr
languages p =
  unsafePerformIO $
    do ref <- newIORef Map.empty
       allocaBytes ((8)) $ \itor ->
{-# LINE 94 "src/runtime/haskell-bind/PGF2.hsc" #-}
                   do fptr <- wrapMapItorCallback (getLanguages ref)
                      ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) itor fptr
{-# LINE 96 "src/runtime/haskell-bind/PGF2.hsc" #-}
                      pgf_iter_languages (pgf p) itor nullPtr
                      freeHaskellFunPtr fptr
       readIORef ref
  where
    getLanguages :: IORef (Map.Map String Concr) -> MapItorCallback
    getLanguages ref itor key value exn = do
      langs <- readIORef ref
      name  <- peekCString (castPtr key)
      concr <- fmap (\ptr -> Concr ptr p) $ peek (castPtr value)
      writeIORef ref $! Map.insert name concr langs

generateAll :: PGF -> Cat -> [(Expr,Float)]
generateAll p cat =
  unsafePerformIO $
    do genPl  <- gu_new_pool
       exprPl <- gu_new_pool
       enum   <- withCString cat $ \cat ->
                   pgf_generate_all (pgf p) cat genPl
       genFPl  <- newForeignPtr gu_pool_finalizer genPl
       exprFPl <- newForeignPtr gu_pool_finalizer exprPl
       fromPgfExprEnum enum genFPl (p,exprFPl)

abstractName :: PGF -> AbsName
abstractName p = unsafePerformIO (peekCString =<< pgf_abstract_name (pgf p))

startCat :: PGF -> Cat
startCat p = unsafePerformIO (peekCString =<< pgf_start_cat (pgf p))

loadConcr :: Concr -> FilePath -> IO ()
loadConcr c fpath =
  withCString fpath $ \c_fpath ->
  withCString "rb" $ \c_mode ->
  withGuPool $ \tmpPl -> do
    file <- fopen c_fpath c_mode
    inp <- gu_file_in file tmpPl
    exn <- gu_new_exn tmpPl
    pgf_concrete_load (concr c) inp exn
    failed <- gu_exn_is_raised exn
    if failed
      then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
              if is_errno
                then do perrno <- ((\hsc_ptr -> peekByteOff hsc_ptr 24)) exn
{-# LINE 138 "src/runtime/haskell-bind/PGF2.hsc" #-}
                        errno  <- peek perrno
                        ioError (errnoToIOError "loadConcr" (Errno errno) Nothing (Just fpath))
                else do throwIO (PGFError "The language cannot be loaded")
      else return ()

unloadConcr :: Concr -> IO ()
unloadConcr c = pgf_concrete_unload (concr c)

-----------------------------------------------------------------------------
-- Types

data Type =
   DTyp [Hypo] CId [Expr]
  deriving Show

data BindType = 
    Explicit
  | Implicit
  deriving Show

-- | 'Hypo' represents a hypothesis in a type i.e. in the type A -> B, A is the hypothesis
type Hypo = (BindType,CId,Type)

functionType :: PGF -> CId -> Type
functionType p fn =
  unsafePerformIO $
  withCString fn $ \c_fn -> do
    c_type <- pgf_function_type (pgf p) c_fn
    peekType c_type
  where
    peekType c_type = do
      cid <- ((\hsc_ptr -> peekByteOff hsc_ptr 8)) c_type >>= peekCString
{-# LINE 170 "src/runtime/haskell-bind/PGF2.hsc" #-}
      c_hypos <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) c_type
{-# LINE 171 "src/runtime/haskell-bind/PGF2.hsc" #-}
      n_hypos <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) c_hypos
{-# LINE 172 "src/runtime/haskell-bind/PGF2.hsc" #-}
      hs <- peekHypos (c_hypos `plusPtr` ((8))) 0 n_hypos
{-# LINE 173 "src/runtime/haskell-bind/PGF2.hsc" #-}
      n_exprs <- ((\hsc_ptr -> peekByteOff hsc_ptr 16)) c_type
{-# LINE 174 "src/runtime/haskell-bind/PGF2.hsc" #-}
      es <- peekExprs (c_type `plusPtr` ((24))) 0 n_exprs
{-# LINE 175 "src/runtime/haskell-bind/PGF2.hsc" #-}
      return (DTyp hs cid es)

    peekHypos :: Ptr a -> Int -> Int -> IO [Hypo]
    peekHypos c_hypo i n
      | i < n     = do cid <- ((\hsc_ptr -> peekByteOff hsc_ptr 8)) c_hypo >>= peekCString
{-# LINE 180 "src/runtime/haskell-bind/PGF2.hsc" #-}
                       ty  <- ((\hsc_ptr -> peekByteOff hsc_ptr 16)) c_hypo >>= peekType
{-# LINE 181 "src/runtime/haskell-bind/PGF2.hsc" #-}
                       bt  <- fmap toBindType (((\hsc_ptr -> peekByteOff hsc_ptr 0)) c_hypo)
{-# LINE 182 "src/runtime/haskell-bind/PGF2.hsc" #-}
                       hs <- peekHypos (plusPtr c_hypo ((24))) (i+1) n
{-# LINE 183 "src/runtime/haskell-bind/PGF2.hsc" #-}
                       return ((bt,cid,ty) : hs)
      | otherwise = return []

    toBindType :: Int -> BindType
    toBindType (0) = Explicit
{-# LINE 188 "src/runtime/haskell-bind/PGF2.hsc" #-}
    toBindType (1) = Implicit
{-# LINE 189 "src/runtime/haskell-bind/PGF2.hsc" #-}

    peekExprs ptr i n
      | i < n     = do e  <- peekElemOff ptr i
                       es <- peekExprs ptr (i+1) n
                       return (Expr e p : es)
      | otherwise = return []


-----------------------------------------------------------------------------
-- Expressions

-- The C structure for the expression may point to other structures
-- which are allocated from other pools. In order to ensure that
-- they are not released prematurely we use the exprMaster to
-- store references to other Haskell objects

data Expr = forall a . Expr {expr :: PgfExpr, exprMaster :: a}

instance Show Expr where
  show = showExpr

mkApp :: Fun -> [Expr] -> Expr
mkApp fun args =
  unsafePerformIO $
    withCString fun $ \cfun ->
    allocaBytes (((16)) + len * sizeOf (undefined :: PgfExpr)) $ \papp -> do
{-# LINE 215 "src/runtime/haskell-bind/PGF2.hsc" #-}
      ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) papp cfun
{-# LINE 216 "src/runtime/haskell-bind/PGF2.hsc" #-}
      ((\hsc_ptr -> pokeByteOff hsc_ptr 8)) papp len
{-# LINE 217 "src/runtime/haskell-bind/PGF2.hsc" #-}
      pokeArray (papp `plusPtr` ((16))) (map expr args)
{-# LINE 218 "src/runtime/haskell-bind/PGF2.hsc" #-}
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_apply papp exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (exprFPl,args))
  where
    len = length args

unApp :: Expr -> Maybe (Fun,[Expr])
unApp (Expr expr master) =
  unsafePerformIO $
    withGuPool $ \pl -> do
      appl <- pgf_expr_unapply expr pl
      if appl == nullPtr
        then return Nothing
        else do 
           fun <- peekCString =<< ((\hsc_ptr -> peekByteOff hsc_ptr 0)) appl
{-# LINE 234 "src/runtime/haskell-bind/PGF2.hsc" #-}
           arity <- ((\hsc_ptr -> peekByteOff hsc_ptr 8)) appl :: IO CInt 
{-# LINE 235 "src/runtime/haskell-bind/PGF2.hsc" #-}
           c_args <- peekArray (fromIntegral arity) (appl `plusPtr` ((16)))
{-# LINE 236 "src/runtime/haskell-bind/PGF2.hsc" #-}
           return $ Just (fun, [Expr c_arg master | c_arg <- c_args])

mkStr :: String -> Expr
mkStr str =
  unsafePerformIO $
    withCString str $ \cstr -> do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_string cstr exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr exprFPl)

readExpr :: String -> Maybe Expr
readExpr str =
  unsafePerformIO $
    do exprPl <- gu_new_pool
       withGuPool $ \tmpPl ->
         withCString str $ \c_str ->
           do guin <- gu_string_in c_str tmpPl
              exn <- gu_new_exn tmpPl
              c_expr <- pgf_read_expr guin exprPl exn
              status <- gu_exn_is_raised exn
              if (not status && c_expr /= nullPtr)
                then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
                        return $ Just (Expr c_expr exprFPl)
                else do gu_pool_free exprPl
                        return Nothing

showExpr :: Expr -> String
showExpr e = 
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         let printCtxt = nullPtr
         exn <- gu_new_exn tmpPl
         pgf_print_expr (expr e) printCtxt 1 out exn
         s <- gu_string_buf_freeze sb tmpPl
         peekCString s


-----------------------------------------------------------------------------
-- Functions using Concr
-- Morpho analyses, parsing & linearization

type MorphoAnalysis = (Fun,String,Float)

lookupMorpho :: Concr -> String -> [MorphoAnalysis]
lookupMorpho (Concr concr master) sent = unsafePerformIO $
  do ref <- newIORef []
     allocaBytes ((8)) $ \cback -> 
{-# LINE 285 "src/runtime/haskell-bind/PGF2.hsc" #-}
                        do fptr <- wrapLookupMorphoCallback (getAnalysis ref)
                           ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) cback fptr
{-# LINE 287 "src/runtime/haskell-bind/PGF2.hsc" #-}
                           withCString sent $ \c_sent ->
                             pgf_lookup_morpho concr c_sent cback nullPtr
                           freeHaskellFunPtr fptr
     readIORef ref

fullFormLexicon :: Concr -> [(String, [MorphoAnalysis])]
fullFormLexicon lang =
  unsafePerformIO $
    do pl <- gu_new_pool
       enum <- pgf_fullform_lexicon (concr lang) pl
       fpl <- newForeignPtr gu_pool_finalizer pl
       fromFullFormEntry enum fpl
  where
    fromFullFormEntry :: Ptr GuEnum -> ForeignPtr GuPool -> IO [(String, [MorphoAnalysis])]
    fromFullFormEntry enum fpl =
      do ffEntry <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
         if ffEntry == nullPtr
           then do finalizeForeignPtr fpl
                   return []
           else do tok  <- peekCString =<< pgf_fullform_get_string ffEntry
                   ref  <- newIORef []
                   allocaBytes ((8)) $ \cback ->
{-# LINE 312 "src/runtime/haskell-bind/PGF2.hsc" #-}
                        do fptr <- wrapLookupMorphoCallback (getAnalysis ref)
                           ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) cback fptr
{-# LINE 314 "src/runtime/haskell-bind/PGF2.hsc" #-}
                           pgf_fullform_get_analyses ffEntry cback nullPtr
                   ans  <- readIORef ref
                   toks <- unsafeInterleaveIO (fromFullFormEntry enum fpl)
                   return ((tok,ans) : toks)

getAnalysis :: IORef [MorphoAnalysis] -> LookupMorphoCallback
getAnalysis ref self c_lemma c_anal prob exn = do
  ans <- readIORef ref
  lemma <- peekCString c_lemma
  anal  <- peekCString c_anal
  writeIORef ref ((lemma, anal, prob):ans)

parse :: Concr -> Cat -> String -> Either String [(Expr,Float)]
parse lang cat sent = parseWithHeuristics lang cat sent (-1.0) []

parseWithHeuristics :: Concr      -- ^ the language with which we parse
                    -> Cat        -- ^ the start category
                    -> String     -- ^ the input sentence
                    -> Double     -- ^ the heuristic factor. 
                                  -- A negative value tells the parser 
                                  -- to lookup up the default from 
                                  -- the grammar flags
                    -> [(Cat, Int -> String -> Int -> Maybe (Expr,Float,Int))]
                                  -- ^ a list of callbacks for literal categories.
                                  -- The arguments of the callback are:
                                  -- the index of the constituent for the literal category;
                                  -- the input sentence; the current offset in the sentence.
                                  -- If a literal has been recognized then the output should
                                  -- be Just (expr,probability,end_offset)
                    -> Either String [(Expr,Float)]
parseWithHeuristics lang cat sent heuristic callbacks =
  unsafePerformIO $
    do parsePl <- gu_new_pool
       exprPl  <- gu_new_pool
       exn     <- gu_new_exn parsePl
       enum    <- withCString cat $ \cat ->
                    withCString sent $ \sent -> do
                      callbacks_map <- mkCallbacksMap (concr lang) callbacks parsePl
                      pgf_parse_with_heuristics (concr lang) cat sent heuristic callbacks_map exn parsePl exprPl
       failed  <- gu_exn_is_raised exn
       if failed
         then do is_parse_error <- gu_exn_caught exn gu_exn_type_PgfParseError
                 if is_parse_error
                   then do c_tok <- ((\hsc_ptr -> peekByteOff hsc_ptr 24)) exn
{-# LINE 358 "src/runtime/haskell-bind/PGF2.hsc" #-}
                           tok <- peekCString c_tok
                           gu_pool_free parsePl
                           gu_pool_free exprPl
                           return (Left tok)
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- ((\hsc_ptr -> peekByteOff hsc_ptr 24)) exn
{-# LINE 365 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                     msg <- peekCString c_msg
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError msg)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError "Parsing failed")
         else do parseFPl <- newForeignPtr gu_pool_finalizer parsePl
                 exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
                 exprs    <- fromPgfExprEnum enum parseFPl (lang,exprFPl)
                 return (Right exprs)

mkCallbacksMap :: Ptr PgfConcr -> [(String, Int -> String -> Int -> Maybe (Expr,Float,Int))] -> Ptr GuPool -> IO (Ptr PgfCallbacksMap)
mkCallbacksMap concr callbacks pool = do
  callbacks_map <- pgf_new_callbacks_map concr pool
  forM_ callbacks $ \(cat,match) ->
    withCString cat $ \ccat -> do
      match    <- wrapLiteralMatchCallback (match_callback match)
      predict  <- wrapLiteralPredictCallback predict_callback
      hspgf_callbacks_map_add_literal concr callbacks_map ccat match predict pool
  return callbacks_map
  where
    match_callback match _ clin_idx csentence poffset out_pool = do
      sentence <- peekCString csentence
      coffset <- peek poffset
      case match (fromIntegral clin_idx) sentence (fromIntegral coffset) of
        Nothing               -> return nullPtr
        Just (e,prob,offset') -> do poke poffset (fromIntegral offset')

                                    -- here we copy the expression to out_pool
                                    c_e <- withGuPool $ \tmpPl -> do
                                             exn <- gu_new_exn tmpPl
        
                                             (sb,out) <- newOut tmpPl
                                             let printCtxt = nullPtr
                                             pgf_print_expr (expr e) printCtxt 1 out exn
                                             c_str <- gu_string_buf_freeze sb tmpPl

                                             guin <- gu_string_in c_str tmpPl
                                             pgf_read_expr guin out_pool exn

                                    ep <- gu_malloc out_pool ((16))
{-# LINE 407 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                    ((\hsc_ptr -> pokeByteOff hsc_ptr 8)) ep c_e
{-# LINE 408 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                    ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) ep prob
{-# LINE 409 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                    return ep

    predict_callback _ _ _ _ = return nullPtr

hasLinearization :: Concr -> Fun -> Bool
hasLinearization lang id = unsafePerformIO $
  withCString id (pgf_has_linearization (concr lang))

linearize :: Concr -> Expr -> String
linearize lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do (sb,out) <- newOut pl
       exn <- gu_new_exn pl
       pgf_linearize (concr lang) (expr e) out exn
       failed <- gu_exn_is_raised exn
       if failed
         then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                 if is_nonexist
                   then return ""
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- ((\hsc_ptr -> peekByteOff hsc_ptr 24)) exn
{-# LINE 431 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                     msg <- peekCString c_msg
                                     throwIO (PGFError msg)
                             else throwIO (PGFError "The abstract tree cannot be linearized")
         else do lin <- gu_string_buf_freeze sb pl
                 peekCString lin

alignWords :: Concr -> Expr -> [(String, [Int])]
alignWords lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do exn <- gu_new_exn pl
       seq <- pgf_align_words (concr lang) (expr e) exn pl
       failed <- gu_exn_is_raised exn
       if failed
         then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                 if is_nonexist
                   then return []
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- ((\hsc_ptr -> peekByteOff hsc_ptr 24)) exn
{-# LINE 450 "src/runtime/haskell-bind/PGF2.hsc" #-}
                                     msg <- peekCString c_msg
                                     throwIO (PGFError msg)
                             else throwIO (PGFError "The abstract tree cannot be linearized")
         else do len <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) seq
{-# LINE 454 "src/runtime/haskell-bind/PGF2.hsc" #-}
                 arr <- peekArray (fromIntegral (len :: CInt)) (seq `plusPtr` ((8)))
{-# LINE 455 "src/runtime/haskell-bind/PGF2.hsc" #-}
                 mapM peekAlignmentPhrase arr
  where
    peekAlignmentPhrase :: Ptr () -> IO (String, [Int])
    peekAlignmentPhrase ptr = do
      c_phrase <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) ptr
{-# LINE 460 "src/runtime/haskell-bind/PGF2.hsc" #-}
      phrase <- peekCString c_phrase
      n_fids <- ((\hsc_ptr -> peekByteOff hsc_ptr 8)) ptr
{-# LINE 462 "src/runtime/haskell-bind/PGF2.hsc" #-}
      (fids :: [CInt]) <- peekArray (fromIntegral (n_fids :: CInt)) (ptr `plusPtr` ((16)))
{-# LINE 463 "src/runtime/haskell-bind/PGF2.hsc" #-}
      return (phrase, map fromIntegral fids)

-----------------------------------------------------------------------------
-- Helper functions

newOut :: Ptr GuPool -> IO (Ptr GuStringBuf, Ptr GuOut)
newOut pool =
   do sb <- gu_string_buf pool
      out <- gu_string_buf_out sb
      return (sb,out)

fromPgfExprEnum :: Ptr GuEnum -> ForeignPtr GuPool -> a -> IO [(Expr, Float)]
fromPgfExprEnum enum fpl master =
  do pgfExprProb <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
     if pgfExprProb == nullPtr
       then do finalizeForeignPtr fpl
               return []
       else do expr <- ((\hsc_ptr -> peekByteOff hsc_ptr 8)) pgfExprProb
{-# LINE 484 "src/runtime/haskell-bind/PGF2.hsc" #-}
               ts <- unsafeInterleaveIO (fromPgfExprEnum enum fpl master)
               prob <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) pgfExprProb
{-# LINE 486 "src/runtime/haskell-bind/PGF2.hsc" #-}
               return ((Expr expr master,prob) : ts)

-----------------------------------------------------------------------
-- Exceptions

newtype PGFError = PGFError String
     deriving (Show, Typeable)

instance Exception PGFError

-----------------------------------------------------------------------

type LiteralCallback =
       PGF -> (ConcName,Concr) -> Int -> String -> Int -> Maybe (Expr,Float,Int)

-- | Callbacks for the App grammar
literalCallbacks :: [(AbsName,[(Cat,LiteralCallback)])]
literalCallbacks = [("App",[("PN",nerc),("Symb",chunk)])]

-- | Named entity recognition for the App grammar 
-- (based on ../java/org/grammaticalframework/pgf/NercLiteralCallback.java)
nerc :: LiteralCallback
nerc pgf (lang,concr) lin_idx sentence offset =
  case consume capitalized (drop offset sentence) of
    (capwords@(_:_),rest) |
       not ("Eng" `isSuffixOf` lang && name `elem` ["I","I'm"]) ->
        if null ls
        then pn
        else case cat of
              "PN" -> retLit (mkApp lemma [])
              "WeekDay" -> retLit (mkApp "weekdayPN" [mkApp lemma []])
              "Month" -> retLit (mkApp "monthPN" [mkApp lemma []])
              "Language" -> Nothing
              _ -> pn
      where
        retLit e = --traceShow (name,e,drop end_offset sentence) $
                   Just (e,0,end_offset)
          where end_offset = offset+length name
        pn = retLit (mkApp "SymbPN" [mkApp "MkSymb" [mkStr name]])
        ((lemma,cat),_) = maximumBy (compare `on` snd) (reverse ls)
        ls = [((fun,cat),p)
              |(fun,_,p)<-lookupMorpho concr name,
                let cat=functionCat fun,
                cat/="Nationality"]
        name = trimRight (concat capwords)
    _ -> Nothing
  where
    -- | Variant of unfoldr
    consume munch xs =
      case munch xs of
        Nothing -> ([],xs)
        Just (y,xs') -> (y:ys,xs'')
          where (ys,xs'') = consume munch xs'

    functionCat f = case functionType pgf f of DTyp _ cat _ -> cat

-- | Callback to parse arbitrary words as chunks (from
-- ../java/org/grammaticalframework/pgf/UnknownLiteralCallback.java)
chunk :: LiteralCallback
chunk _ (_,concr) lin_idx sentence offset =
  case uncapitalized (drop offset sentence) of
    Just (word0@(_:_),rest) | null (lookupMorpho concr word) ->
        Just (expr,0,offset+length word)
      where
        word = trimRight word0
        expr = mkApp "MkSymb" [mkStr word]
    _ -> Nothing


-- More helper functions

trimRight = reverse . dropWhile isSpace . reverse

capitalized = capitalized' isUpper
uncapitalized = capitalized' (not.isUpper)

capitalized' test s@(c:_) | test c =
  case span (not.isSpace) s of
    (name,rest1) ->
      case span isSpace rest1 of
        (space,rest2) -> Just (name++space,rest2)
capitalized' not s = Nothing
