@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_O_HEADER as select from zsac_o_header
composition [0..*] of ZI_O_ITEM as _Item
{
    key order_number as OrderNumber,
    company_code as CompanyCode,
    vendor_number as VendorNumber,
    document_date as DocumentDate,
    status as Status,
    currency as Currency,
  @Semantics.amount.currencyCode : 'currency'
    total_value as TotalValue,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat,
    _Item
}

