trigger OfferTrigger on Offer__c (
    before insert, before update,
    after insert, after update
) {
    new OfferTriggerHandler().run();
}