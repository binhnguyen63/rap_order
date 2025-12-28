@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header composition'
@Metadata.allowExtensions: true
define view entity ZC_O_HISTORY as projection on ZI_O_HISTORY
{
    key ItemNumber,
    key OrderNumber,
    key HistId,
    MovementType,
    PostingDate,
    MovQty,
        Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _Item : redirected to parent ZC_O_ITEM,
    _Header : redirected to Zc_O_Header
}
