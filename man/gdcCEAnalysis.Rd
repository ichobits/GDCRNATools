% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gdcCEAnalysis.R
\name{gdcCEAnalysis}
\alias{gdcCEAnalysis}
\title{Competing endogenous RNAs (ceRNAs) analysis}
\usage{
gdcCEAnalysis(lnc, pc, deMIR = NULL, lnc.targets = "starBase",
  pc.targets = "starBase", rna.expr, mir.expr)
}
\arguments{
\item{lnc}{a vector of Ensembl long non-coding gene ids}

\item{pc}{a vector of Ensembl protein coding gene ids}

\item{deMIR}{a vector of differentially expressed miRNAs. 
Default is \code{NULL}}

\item{lnc.targets}{a character string specifying the database 
of miRNA-lncRNA interactions.
Should be one of \code{'spongeScan'}, \code{'starBase'}, 
and \code{'miRcode'}. Default is \code{'starBase'}. \cr\cr
Or a \code{list} of miRNA-lncRNA interactions generated by users}

\item{pc.targets}{a character string specifying the database of 
miRNA-lncRNA interactions.
Should be one of \code{'spongeScan'}, \code{'starBase'}, 
and \code{'miRcode'}. Default is \code{'starBase'}. \cr\cr
Or a \code{list} of miRNA-lncRNA interactions generated by users}

\item{rna.expr}{\code{\link[limma]{voom}} 
transformed gene expression data}

\item{mir.expr}{\code{\link[limma]{voom}} 
transformed mature miRNA expression data}
}
\value{
A dataframe containing ceRNA pairs, expression correlation 
    between lncRNA and mRNA, the number and hypergeometric significance 
    of shared miRNAs, regulation similarity score, and the mean sensitity 
    correlation (the difference between Pearson correlation and partial 
    correlation) of multiple lncRNA-miRNA-mRNA triplets, etc.
}
\description{
Identify ceRNAs by 
    (1) number of shared miRNAs between lncRNA and mRNA; 
    (2) expression correlation of lncRNA and mRNA;
    (3) regulation similarity of shared miRNAs on lncRNA and mRNA;
    (4) sensitivity correlation
}
\examples{
####### ceRNA network analysis #######
deLNC <- c('ENSG00000260920','ENSG00000242125','ENSG00000261211')
dePC <- c('ENSG00000043355','ENSG00000109586','ENSG00000144355')
genes <- c(deLNC, dePC)
samples <- c('TCGA-2F-A9KO-01', 'TCGA-2F-A9KP-01', 
            'TCGA-2F-A9KQ-01', 'TCGA-2F-A9KR-01', 
            'TCGA-2F-A9KT-01', 'TCGA-2F-A9KW-01')
rnaExpr <- data.frame(matrix(c(2.7,7.0,4.9,6.9,4.6,2.5,
                    0.5,2.5,5.7,6.5,4.9,3.8,
                    2.1,2.9,5.9,5.7,4.5,3.5,
                    2.7,5.9,4.5,5.8,5.2,3.0,
                    2.5,2.2,5.3,4.4,4.4,2.9,
                    2.4,3.8,6.2,3.8,3.8,4.2),6,6), 
                    stringsAsFactors=FALSE)
rownames(rnaExpr) <- genes
colnames(rnaExpr) <- samples

mirExpr <- data.frame(matrix(c(7.7,7.4,7.9,8.9,8.6,9.5,
                    5.1,4.4,5.5,8.5,4.4,3.5,
                    4.9,5.5,6.9,6.1,5.5,4.1,
                    12.4,13.5,15.1,15.4,13.0,12.8,
                    2.5,2.2,5.3,4.4,4.4,2.9,
                    2.4,2.7,6.2,1.5,4.4,4.2),6,6),
                    stringsAsFactors=FALSE)
colnames(mirExpr) <- samples
rownames(mirExpr) <- c('hsa-miR-340-5p','hsa-miR-181b-5p',
                    'hsa-miR-181a-5p', 'hsa-miR-181c-5p',
                    'hsa-miR-199b-5p','hsa-miR-182-5p')

ceOutput <- gdcCEAnalysis(lnc       = deLNC, 
                        pc          = dePC, 
                        lnc.targets = 'starBase', 
                        pc.targets  = 'starBase', 
                        rna.expr    = rnaExpr, 
                        mir.expr    = mirExpr)
}
\references{
Paci P, Colombo T, Farina L. Computational analysis identifies 
    a sponge interaction network  between long non-coding RNAs and 
    messenger RNAs in human breast cancer.  BMC systems biology. 
    2014 Jul 17;8(1):83.
}
\author{
Ruidong Li and Han Qu
}
