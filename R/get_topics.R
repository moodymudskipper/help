
get_topics <- function(package) {
  help_path <- system.file("help", package = package)

  file_path <- file.path(help_path, "AnIndex")
  if (length(readLines(file_path, n = 1)) < 1) {
    return(NULL)
  }

  topics <- read.table(
    file_path, sep = "\t", stringsAsFactors = FALSE, comment.char = "",
    quote = "", header = FALSE)

  names(topics) <- c("alias", "file")
  topics[complete.cases(topics), ]
}
