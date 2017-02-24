exchangerate <- function(Currency, Date) {
    Date <- Date
    theurl <- paste("http://www.xe.com/currencytables/?date=", Date, sep = "")
    theurl <- paste(theurl, "&from=", sep = "")
    theurl <- paste(theurl, Currency, sep = "")
    file <- read_html(theurl)
    tables <- html_nodes(file, "table")
    table1 <- html_table(tables[1], fill = TRUE, header = T, trim = T)
    table1 <- as.data.frame(table1[1])[, -1]
    table1 <- head(table1[2], 1)
    query <- paste("insert into ExchangeRate values ('", Currency, "','", Date, "',", table1, ")", sep = "")
    dataSQLQuery <- sqlQuery(cn, query)
}
cn <- odbcDriverConnect(connection = "Driver={SQL Server Native Client 11.0};server=cirsql-01;database=FerreroPricing;trusted_connection=yes;")
dataSQLQuery <- sqlQuery(cn, "TRUNCATE TABLE ExchangeRate")
Date <- as.Date("2016-10-01") # Set Start Date here
while (Date != Sys.Date()) {
    res <- exchangerate("AED", Date) # Manually list all currencies you want 
    res <- exchangerate("EUR", Date) # Rewrite this to get them from Database
    res <- exchangerate("USD", Date)
    res <- exchangerate("SGD", Date)
    res <- exchangerate("NOK", Date)
    res <- exchangerate("DKK", Date)
    res <- exchangerate("THB", Date)
    res <- exchangerate("HKD", Date)
    res <- exchangerate("MYR", Date)
    res <- exchangerate("PHP", Date)
    Date <- Date + 1
}
View("Finished")