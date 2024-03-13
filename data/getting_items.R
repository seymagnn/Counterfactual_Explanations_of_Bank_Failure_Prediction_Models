failureData <-
  getAllFinancialsLoop(
    as.numeric(failure_banklist$Cert),
    getAllFinancials,
    metrics = c("IDT1RWAJR", "ASSET", "ROE", "INTEXPYQ", "RBC1AAJ", "NIMY"),
    IDRSSD  = FALSE
  )

activeData <-
  getAllFinancialsLoop(
    as.numeric(bank_infos$FED_RSSD),
    getAllFinancials,
    metrics = c("IDT1RWAJR", "ASSET", "ROE", "INTEXPYQ", "RBC1AAJ", "NIMY")
  )

save(activeData,file="activeData.Rda")
save(failureData,file="failureData.Rda")