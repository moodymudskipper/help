fetchRdDB <- getFromNamespace("fetchRdDB","tools")

#' get content of help file in a list
#'
#' @param topic function either in `fun` or `pkg::fun` form, or character
#' @param package oprtional character
#' @param simplify wether to simplify formatting
#'
#' @return a list
#' @export
#' @importFrom stats complete.cases
#' @importFrom stats setNames
#' @importFrom utils read.table
#' @examples
#' doc(mean)
doc <- function(topic, package = NULL, simplify = TRUE) {
  topic_lng <- substitute(topic)
  if(is.character(topic_lng)) {
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## char input
    topic_chr <- topic_lng
    if(is.null(package)) {
      pkg_chr <- getNamespaceName(environment(get(topic_chr)))
    } else {
      pkg_chr <- package
    }
    topic <- get(topic)
  } else if(is.call(topic_lng)){
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## call input
    if(identical(topic_lng[[1]], quote(`::`))){
      if (!is.null(package))
        stop("The `package` argument should not be used if pkg::fun form is used for topic")

      topic_chr <- as.character(topic_lng[[3]])
      pkg_chr <- as.character(topic_lng[[2]])
    } else {
      stop("wrong input")
    }
  } else if(is.symbol(topic_lng)){
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ## symbol input
    topic_chr <- as.character(topic_lng)
    if(is.null(package)) {
      pkg_chr <- getNamespaceName(environment(topic))
    } else {
      pkg_chr <- package
    }

  } else{
    stop("wrong input")
  }
  topics <- get_topics(pkg_chr)
  topic_page <- topics[topics$alias == topic_chr, "file"]

  if(length(topic_page) < 1)
    topic_page <- subset(topics, file == topic, select = file)$file

  stopifnot(length(topic_page) >= 1)
  file <- topic_page[1]

  rdb_path <- file.path(system.file("help", package = pkg_chr), pkg_chr)
  help <- fetchRdDB(rdb_path, file)
  help <- paste(as.character(help), collapse="")
  res <- split_help(help)

  if(simplify) {
    if("usage" %in% names(res)){
      res$usage <- gsub("\\\\dots","...", res$usage)
      res$usage <- gsub(
        "\\\\method\\{(.*?)\\}\\{default\\}",
        "## Default S3 method:\n\\1", res$usage)
      res$usage <- gsub(
        "\\\\method\\{(.*?)\\}\\{(.*?)\\}",
        "## S3 method for class '\\2':\n\\1", res$usage)

    }
    fun <- function(x) {
      x <- gsub("\\\\R","`R`", x)
      x <- gsub("\\\\link\\[(.*?)\\]\\{(.*?)}","\\2", x)
      x <- gsub("\\\\link\\{(.*?)}","\\1", x)
      x <- gsub("\\\\code\\{(.*?)}","`\\1`", x)
      x <- gsub("\\\\var\\{(.*?)}","\\1", x)
      x <- gsub("\\\\emph\\{(.*?)}","\\1", x)
      x <- gsub("\\\\strong\\{(.*?)}","\\1", x)
      x <- gsub("\\\\itemize\\{(.*?)} *","\\1\n", x)
      x <- gsub("\\\\item","\n* ", x)
      x <- gsub("\\\\dots","`...`", x)
      x <- gsub("\\n\\n +","\n\n", x)
      x <- gsub(" +"," ", x)
    }
    res <- rapply(res, fun,how = "replace")
    ind <- !names(res) %in% c("arguments","examples") & lengths(res) == 1
    res[ind] <-
      gsub("(?<!\\n)\\n *(?!\\n)"," ",res[ind], perl = TRUE)


  }
  res
}



