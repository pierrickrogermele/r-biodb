% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BiodbPersistentCache.R
\name{BiodbPersistentCache}
\alias{BiodbPersistentCache}
\title{The abstract class for handling file caching.}
\description{
The abstract class for handling file caching.

The abstract class for handling file caching.
}
\details{
This abstract class is the mother class of concrete classes that manage
cache systems for saving downloaded files and request results.

It is designed for internal use, but you can still access some of
the read-only methods if you wish.
}
\examples{
# Create an instance with default settings:
mybiodb <- biodb::newInst()

# Get a compound CSV file database
chebi.tsv <- system.file("extdata", "chebi_extract.tsv", package='biodb')

# Get a connector instance:
conn <- mybiodb$getFactory()$createConn('comp.csv.file', url=chebi.tsv)

# Get all entries
entries <- conn$getEntry(conn$getEntryIds())

# Get the cache instance:
cache <- mybiodb$getPersistentCache()

# Get list of files inside the cache:
files <- cache$listFiles(conn$getCacheId())

# Delete files inside the cache:
cache$deleteAllFiles(conn$getCacheId())

# Terminate instance.
mybiodb$terminate()

}
\seealso{
\code{\link{BiodbMain}}, \code{\link{BiodbBiocPersistentCache}},
\code{\link{BiodbBiocPersistentCache}}.
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{BiodbPersistentCache$new()}}
\item \href{#method-isReadable}{\code{BiodbPersistentCache$isReadable()}}
\item \href{#method-isWritable}{\code{BiodbPersistentCache$isWritable()}}
\item \href{#method-getDir}{\code{BiodbPersistentCache$getDir()}}
\item \href{#method-getFolderPath}{\code{BiodbPersistentCache$getFolderPath()}}
\item \href{#method-folderExists}{\code{BiodbPersistentCache$folderExists()}}
\item \href{#method-getFilePath}{\code{BiodbPersistentCache$getFilePath()}}
\item \href{#method-filesExist}{\code{BiodbPersistentCache$filesExist()}}
\item \href{#method-fileExist}{\code{BiodbPersistentCache$fileExist()}}
\item \href{#method-fileExists}{\code{BiodbPersistentCache$fileExists()}}
\item \href{#method-markerExist}{\code{BiodbPersistentCache$markerExist()}}
\item \href{#method-markerExists}{\code{BiodbPersistentCache$markerExists()}}
\item \href{#method-setMarker}{\code{BiodbPersistentCache$setMarker()}}
\item \href{#method-getTmpFolderPath}{\code{BiodbPersistentCache$getTmpFolderPath()}}
\item \href{#method-getUsedCacheIds}{\code{BiodbPersistentCache$getUsedCacheIds()}}
\item \href{#method-loadFileContent}{\code{BiodbPersistentCache$loadFileContent()}}
\item \href{#method-saveContentToFile}{\code{BiodbPersistentCache$saveContentToFile()}}
\item \href{#method-addFilesToCache}{\code{BiodbPersistentCache$addFilesToCache()}}
\item \href{#method-copyFilesIntoCache}{\code{BiodbPersistentCache$copyFilesIntoCache()}}
\item \href{#method-moveFilesIntoCache}{\code{BiodbPersistentCache$moveFilesIntoCache()}}
\item \href{#method-erase}{\code{BiodbPersistentCache$erase()}}
\item \href{#method-deleteFile}{\code{BiodbPersistentCache$deleteFile()}}
\item \href{#method-deleteAllFiles}{\code{BiodbPersistentCache$deleteAllFiles()}}
\item \href{#method-deleteFiles}{\code{BiodbPersistentCache$deleteFiles()}}
\item \href{#method-listFiles}{\code{BiodbPersistentCache$listFiles()}}
\item \href{#method-print}{\code{BiodbPersistentCache$print()}}
\item \href{#method-enabled}{\code{BiodbPersistentCache$enabled()}}
\item \href{#method-enable}{\code{BiodbPersistentCache$enable()}}
\item \href{#method-disable}{\code{BiodbPersistentCache$disable()}}
\item \href{#method-clone}{\code{BiodbPersistentCache$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
New instance initializer. Persistent cache objects must not be created
directly.
Instead, access the cache instance through the BiodbMain instance using the
getPersistentCache() method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$new(cfg, bdb = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cfg}}{An instance of the BiodbConfig class.}

\item{\code{bdb}}{An instance of the BiodbMain class.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-isReadable"></a>}}
\if{latex}{\out{\hypertarget{method-isReadable}{}}}
\subsection{Method \code{isReadable()}}{
Checks if the cache system is readable.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$isReadable(conn = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{conn}}{If not \\code{NULL}, checks if the cache system is readable for
this particular connector.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\\code{TRUE} if the cache system is readable,
\\code{FALSE} otherwise.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-isWritable"></a>}}
\if{latex}{\out{\hypertarget{method-isWritable}{}}}
\subsection{Method \code{isWritable()}}{
Checks if the cache system is writable.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$isWritable(conn = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{conn}}{If not \\code{NULL}, checks if the cache system is writable for
this particular connector.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\\code{TRUE} if the cache system is writable,
\\code{FALSE} otherwise.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getDir"></a>}}
\if{latex}{\out{\hypertarget{method-getDir}{}}}
\subsection{Method \code{getDir()}}{
Gets the path to the persistent cache folder.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$getDir()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
The path to the cache folder as a character value.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getFolderPath"></a>}}
\if{latex}{\out{\hypertarget{method-getFolderPath}{}}}
\subsection{Method \code{getFolderPath()}}{
Gets path to the cache system sub-folder dedicated to this cache ID.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$getFolderPath(cache.id, create = TRUE, fail = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{create}}{If set to TRUE and the folder does not exist, creates it.}

\item{\code{fail}}{If set to TRUE, throws a warning if the folder does not exist.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A string containing the path to the folder.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-folderExists"></a>}}
\if{latex}{\out{\hypertarget{method-folderExists}{}}}
\subsection{Method \code{folderExists()}}{
Tests if a cache folder exists for this cache ID.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$folderExists(cache.id)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
TRUE if a cache folder exists.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getFilePath"></a>}}
\if{latex}{\out{\hypertarget{method-getFilePath}{}}}
\subsection{Method \code{getFilePath()}}{
Gets path of file in cache system.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$getFilePath(cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A character vector, the same size as \\code{names},
containing the paths to the files.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-filesExist"></a>}}
\if{latex}{\out{\hypertarget{method-filesExist}{}}}
\subsection{Method \code{filesExist()}}{
Tests if at least one cache file exist for the specified cache ID.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$filesExist(cache.id)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A single boolean value.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fileExist"></a>}}
\if{latex}{\out{\hypertarget{method-fileExist}{}}}
\subsection{Method \code{fileExist()}}{
DEPRECATED. Use fileExists().
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$fileExist(cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files, without the dot (\"html\", \"xml\",
etc).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A logical vector, the same size as \\code{name}, with \\code{TRUE}
value if the file exists in the cache, or \\code{FALSE} otherwise.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fileExists"></a>}}
\if{latex}{\out{\hypertarget{method-fileExists}{}}}
\subsection{Method \code{fileExists()}}{
Tests if a particular file exist in the cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$fileExists(cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files, without the dot (\"html\", \"xml\",
etc).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A logical vector, the same size as \\code{name}, with \\code{TRUE}
value if the file exists in the cache, or \\code{FALSE} otherwise.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-markerExist"></a>}}
\if{latex}{\out{\hypertarget{method-markerExist}{}}}
\subsection{Method \code{markerExist()}}{
DEPRECATED. Use markerExists().
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$markerExist(cache.id, name)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing marker names.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A logical vector, the same size as \\code{name}, with
\\code{TRUE} value if the marker file exists in the cache, or \\code{FALSE}
otherwise.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-markerExists"></a>}}
\if{latex}{\out{\hypertarget{method-markerExists}{}}}
\subsection{Method \code{markerExists()}}{
Tests if markers exist in the cache. Markers are used, for instance,
by biodb to remember that a downloaded zip file from a database has been
extracted correctly.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$markerExists(cache.id, name)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing marker names.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A logical vector, the same size as \\code{name}, with
\\code{TRUE} value if the marker file exists in the cache, or \\code{FALSE}
otherwise.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-setMarker"></a>}}
\if{latex}{\out{\hypertarget{method-setMarker}{}}}
\subsection{Method \code{setMarker()}}{
Sets a marker.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$setMarker(cache.id, name)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing marker names.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getTmpFolderPath"></a>}}
\if{latex}{\out{\hypertarget{method-getTmpFolderPath}{}}}
\subsection{Method \code{getTmpFolderPath()}}{
Gets path to the cache system temporary folder.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$getTmpFolderPath()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
A string containing the path to the folder.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getUsedCacheIds"></a>}}
\if{latex}{\out{\hypertarget{method-getUsedCacheIds}{}}}
\subsection{Method \code{getUsedCacheIds()}}{
Returns a list of cache IDs actually used to store cache files.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$getUsedCacheIds()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
A character vector containing all the cache IDs actually
used inside the cache system.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-loadFileContent"></a>}}
\if{latex}{\out{\hypertarget{method-loadFileContent}{}}}
\subsection{Method \code{loadFileContent()}}{
Loads content of files from the cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$loadFileContent(
  cache.id,
  name,
  ext,
  output.vector = FALSE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files.}

\item{\code{output.vector}}{If set to \\code{TRUE}, force output to be a
\\code{vector} instead of a \\code{list}. Where the list contains a
\\code{NULL}, the \\code{vector} will contain an \\code{NA} value.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A list (or a vector if \\code{output.vector} is set to
\\code{TRUE}), the same size as \\code{name}, containing the contents of the
files. If some file does not exist, a \\code{NULL} value is inserted inside
the list.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-saveContentToFile"></a>}}
\if{latex}{\out{\hypertarget{method-saveContentToFile}{}}}
\subsection{Method \code{saveContentToFile()}}{
Saves content to files into the cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$saveContentToFile(content, cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{content}}{A list or a character vector containing the contents of the
files. It must have the same length as \\code{name}.}

\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-addFilesToCache"></a>}}
\if{latex}{\out{\hypertarget{method-addFilesToCache}{}}}
\subsection{Method \code{addFilesToCache()}}{
Adds exisiting files into the cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$addFilesToCache(
  src.file.paths,
  cache.id,
  name,
  ext,
  action = c("copy", "move")
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{src.file.paths}}{The current paths of the source files, as a character
vector.}

\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files.}

\item{\code{action}}{Specifies if files have to be moved or copied into the cache.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-copyFilesIntoCache"></a>}}
\if{latex}{\out{\hypertarget{method-copyFilesIntoCache}{}}}
\subsection{Method \code{copyFilesIntoCache()}}{
Copies exisiting files into the cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$copyFilesIntoCache(src.file.paths, cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{src.file.paths}}{The current paths of the source files, as a character
vector.}

\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-moveFilesIntoCache"></a>}}
\if{latex}{\out{\hypertarget{method-moveFilesIntoCache}{}}}
\subsection{Method \code{moveFilesIntoCache()}}{
Moves exisiting files into the cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$moveFilesIntoCache(src.file.paths, cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{src.file.paths}}{The current paths of the source files, as a character
vector.}

\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-erase"></a>}}
\if{latex}{\out{\hypertarget{method-erase}{}}}
\subsection{Method \code{erase()}}{
Erases the whole cache.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$erase()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-deleteFile"></a>}}
\if{latex}{\out{\hypertarget{method-deleteFile}{}}}
\subsection{Method \code{deleteFile()}}{
Deletes a list of files inside the cache system.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$deleteFile(cache.id, name, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{name}}{A character vector containing file names.}

\item{\code{ext}}{The extension of the files, without the dot (\"html\", \"xml\",
etc).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-deleteAllFiles"></a>}}
\if{latex}{\out{\hypertarget{method-deleteAllFiles}{}}}
\subsection{Method \code{deleteAllFiles()}}{
Deletes, in the cache system, all files associated with this cache ID.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$deleteAllFiles(cache.id, fail = FALSE, prefix = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{fail}}{If set to TRUE, a warning will be emitted if no cache files
exist for this cache ID.}

\item{\code{prefix}}{DEPRECATED If set to TRUE, use cache.id as a prefix, deleting
all files whose cache.id starts with this prefix.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-deleteFiles"></a>}}
\if{latex}{\out{\hypertarget{method-deleteFiles}{}}}
\subsection{Method \code{deleteFiles()}}{
Deletes all files with the specific extension of the cache ID in the
cache system.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$deleteFiles(cache.id, ext)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{ext}}{The extension of the files, without the dot (\"html\", \"xml\",
etc).  Only files having this extension will be deleted.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Nothing.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-listFiles"></a>}}
\if{latex}{\out{\hypertarget{method-listFiles}{}}}
\subsection{Method \code{listFiles()}}{
Lists files present in the cache system.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$listFiles(
  cache.id,
  ext = NULL,
  extract.name = FALSE,
  full.path = FALSE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cache.id}}{The cache ID to use.}

\item{\code{ext}}{The extension of the files, without the dot (\"html\", \"xml\",
etc).}

\item{\code{extract.name}}{If set to \\code{TRUE}, instead of returning the file
paths, returns the list of names used to construct the file name:
[cache_folder]/[cache.id]/[name].[ext].}

\item{\code{full.path}}{If set to \\code{TRUE}, returns full path for files.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
The files of found files, or the names of the files if
\\code{extract.name} is set to \\code{TRUE}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-print"></a>}}
\if{latex}{\out{\hypertarget{method-print}{}}}
\subsection{Method \code{print()}}{
Displays information about this object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$print()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-enabled"></a>}}
\if{latex}{\out{\hypertarget{method-enabled}{}}}
\subsection{Method \code{enabled()}}{
DEPRECATED method. Use now
\\code{BiodbConfig :isEnabled('cache.system')}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$enabled()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-enable"></a>}}
\if{latex}{\out{\hypertarget{method-enable}{}}}
\subsection{Method \code{enable()}}{
DEPRECATED method. Use now
\\code{BiodbConfig :enable('cache.system')}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$enable()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-disable"></a>}}
\if{latex}{\out{\hypertarget{method-disable}{}}}
\subsection{Method \code{disable()}}{
DEPRECATED method. Use now
\\code{BiodbConfig :disable('cache.system')}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$disable()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{BiodbPersistentCache$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
