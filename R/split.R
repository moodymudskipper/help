split_help <- function(txt){
  chrs <- strsplit(txt,"")[[1]]
  content <- character(0) # vector of characters of current built key/value
  keys    <- character(0) #
  values  <- character(0) #
  depth <- 0
  for (chr in chrs){
    if (chr == "{"){
      if(depth == 0) {
        keys <- c(keys, paste(content, collapse = ""))
        content <- character(0)
      } else {
        content <- c(content, chr)
      }
      depth <- depth + 1
    } else if (chr == "}") {
      depth <- depth - 1
      if(depth == 0) {
        values <- c(values, paste(content, collapse = ""))
        content <- character(0)
      } else {
        content <- c(content, chr)
      }
    } else {
      content <- c(content, chr)
    }
  }
  keys <- gsub("^\\\\","",keys)
  values <- trimws(values)
  res <- tapply(values, keys, list)
  res[lengths(res)>1] <- lapply(res[lengths(res)>1], as.list)
  if("arguments" %in% names(res)) {
    res$arguments <- split_arguments(res$arguments)
  }
  res
}

split_arguments <- function(txt){
  chrs <- strsplit(txt,"")[[1]]
  content <- character(0) # vector of characters of current built key/value
  values  <- character(0) #
  depth <- 0
  for (chr in chrs){
    if (chr == "{"){
      if(depth == 0) {
        content <- character(0)
      } else {
        content <- c(content, chr)
      }
      depth <- depth + 1
    } else if (chr == "}") {
      depth <- depth - 1
      if(depth == 0) {
        values <- c(values, paste(content, collapse = ""))
        content <- character(0)
      } else {
        content <- c(content, chr)
      }
    } else {
      content <- c(content, chr)
    }
  }
  values <- trimws(values)
  values <- gsub("\\n"," ", values)
  values <- gsub("\\s+"," ", values)
  keys <- values[c(TRUE,FALSE)]
  values <- values[c(FALSE, TRUE)]
  as.list(setNames(values, keys))
}

