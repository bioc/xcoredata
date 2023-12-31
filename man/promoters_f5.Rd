% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{promoters_f5}
\alias{promoters_f5}
\title{Promoters GenomicRanges object}
\format{
A \code{GenomicRanges} object of length 209911, with 11 metadata columns:
\describe{
  \item{name}{Promotor name.}
  \item{score}{Numeric vector.}
  \item{gene_type_gencode}{Gene type of associated gene as defined by GENCODE annotation.}
  \item{ENTREZID}{ENTREZ ID of associated gene as defined by all three annotation sources.
                  Prevalence of annotations: UCSC > GENCODE > FANTOM5.}
  \item{SYMBOL}{Gene symbol of associated gene as defined by all three annotation sources.
                Prevalence of annotations: UCSC > GENCODE > FANTOM5.}
}
}
\usage{
promoters_f5
}
\description{
FANTOM5's hg38 promoters annotated with nearest features in GENCODE ver.
38 annotation and UCSC hg38 knownGene annotation ver. 3.13.0.
}
\examples{
promoters_f5()

}
\keyword{datasets}
