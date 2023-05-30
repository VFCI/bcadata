install.packages("devtools")
require(devtools)
create_package("../bcadata")

(x <- "alfa,bravo,charlie,delta")
strsplit1(x, split = ",")
exists("strsplit1", where = globalenv(), inherits = FALSE)
