[![Travis build status](https://travis-ci.org/abifromr/biogridapi.svg?branch=master)](https://travis-ci.org/abifromr/biogridapi)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/abifromr/biogridapi?branch=master&svg=true)](https://ci.appveyor.com/project/abifromr/biogridapi)
[![Codecov test coverage](https://codecov.io/gh/abifromr/biogridapi/branch/master/graph/badge.svg)](https://codecov.io/gh/abifromr/biogridapi?branch=master)

# biogridapi

An R client for BIOGRID API

## Overview

Provide a set of functions to interact with the 
[BIOGRID](https://thebiogrid.org) API in R.

## Installing `biogridapi`

The package can be installed using `devtools`

```r
devtools::install_github('abifromr/biogridapi')
```

## Getting started

A simple example to show how the package works is to contrast with an example query using `curl`.

```bash
curl https://webservice.thebiogrid.org/interactions?searchNames=true&geneList=MDM2&includeInteractors=true&includeInteractorInteractions=false&taxId=9606&accesskey=[ACCESSKEY]

```

This would look like the following using `stringapi`

```r
accessKey=<'32 alphanumeric string'>
interactions(accessKey=accessKey,
             geneList = 'DM2',
             searchNames = TRUE,
             includeInteractors = TRUE,
             taxId = 9606)
```
For this example to work using either `curl` or `biogridapi` an `accessKey` is 
needed from [here](https://webservice.thebiogrid.org). 
## Acknowledgement

* This implementation is based on the BIOGRID API documentation, [here](https://wiki.thebiogrid.org/doku.php/biogridrest/).
* **Best practices for API packages** guide was a very useful resource,[here](https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html)
