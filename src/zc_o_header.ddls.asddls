@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header composition'
@Metadata.allowExtensions: true

define root view entity Zc_O_Header as projection on ZR_O_HEADER
{
        key OrderNumber,
    CompanyCode,
    VendorNumber,
    DocumentDate,
    Status,
    Currency,
@Semantics.amount.currencyCode: 'Currency'
    TotalValue,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _Item : redirected to composition child ZC_O_ITEM
}
