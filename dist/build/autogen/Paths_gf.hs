module Paths_gf (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [3,6,10], versionTags = ["darcs"]}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/Dani/Library/Haskell/ghc-7.8.4/lib/gf-3.6.10/bin"
libdir     = "/Users/Dani/Library/Haskell/ghc-7.8.4/lib/gf-3.6.10/lib"
datadir    = "/Users/Dani/Library/Haskell/ghc-7.8.4/lib/gf-3.6.10/share"
libexecdir = "/Users/Dani/Library/Haskell/ghc-7.8.4/lib/gf-3.6.10/libexec"
sysconfdir = "/Users/Dani/Library/Haskell/ghc-7.8.4/lib/gf-3.6.10/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "gf_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "gf_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "gf_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "gf_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "gf_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
