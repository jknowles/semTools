\name{singleParamTest}
\alias{singleParamTest}
\title{
	Single Parameter Test Divided from Nested Model Comparison
}
\description{
	In comparing two nested models, chi-square test may indicate that two models are different. However, like other omnibus tests, researchers do not know which fixed parameters or constraints make these two models different. This function will help researchers identify the significant parameter.
}
\usage{
singleParamTest(model1, model2, return.fit = FALSE, 
  method = "satorra.bentler.2001")
}
\arguments{
  \item{model1}{
	Model 1.
}
  \item{model2}{
	Model 2. Note that two models must be nested models. Further, the order of parameters in their parameter tables are the same. That is, nested models with different scale identifications may not be able to test by this function.
  }
  \item{return.fit}{
	Return the submodels fitted by this function
  }
  \item{method}{The method used to calculate likelihood ratio test. See \code{\link[lavaan]{lavTestLRT}} for available options}
}
\details{
This function first identify the differences between these two models. The model with more free parameters is referred to as parent model and the model with less free parameters is referred to as nested model. Three tests are implemented here:

\enumerate{
  \item{\code{free}: The nested model is used as a template. Then, one parameter indicating the differences between two models is free. The new model is compared with the nested model. This process is repeated for all differences between two models.}
  \item{\code{fix}: The parent model is used as a template. Then, one parameter indicating the differences between two models is fixed or constrained to be equal to other parameters. The new model is then compared with the parent model. This process is repeated for all differences between two models.}
  \item{\code{mi}: No longer available because the test of modification indices is not consistent. For example, two parameters are equally constrained. The modification index from the first parameter is not equal to the second parameter.}
}

Note that this function does not adjust for the inflated Type I error rate from multiple tests.
}
\value{
	If \code{return.fit = FALSE}, the result tables are provided. Chi-square and p-value are provided for all methods. Note that the chi-square is all based on 1 degree of freedom. Expected parameter changes and their standardized forms are also provided. 
	
	If \code{return.fit = TRUE}, a list with two elements are provided. The first element is the tabular result. The second element is the submodels used in the \code{free} and \code{fix} methods. 
}
\author{
    Sunthud Pornprasertmanit (\email{psunthud@gmail.com})
}
\examples{
library(lavaan)

# Nested model comparison by hand
HS.model1 <- ' visual =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6'
HS.model2 <- ' visual =~ a*x1 + a*x2 + a*x3
              textual =~ b*x4 + b*x5 + b*x6'

m1 <- cfa(HS.model1, data = HolzingerSwineford1939, std.lv=TRUE, estimator="MLR")	   
m2 <- cfa(HS.model2, data = HolzingerSwineford1939, std.lv=TRUE, estimator="MLR")	 
anova(m1, m2)  
singleParamTest(m1, m2)

# Nested model comparison from the measurementInvariance function
HW.model <- ' visual =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed =~ x7 + x8 + x9 '

models <- measurementInvariance(HW.model, data=HolzingerSwineford1939, group="school")
singleParamTest(models[[1]], models[[2]])

# Note that the comparison between weak (Model 2) and scalar invariance (Model 3) cannot be done 
# by this function # because the weak invariance model fixes factor means as 0 in Group 2 but 
# the strong invariance model frees the factor means in Group 2. Users may try to compare 
# strong (Model 3) and means invariance models by this function.
}
