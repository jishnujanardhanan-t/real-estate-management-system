public with sharing class OfferTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        OfferService.validateOfferAmount((List<Offer__c>) Trigger.new);
    }

    public override void beforeUpdate() {
        OfferService.validateOfferAmount((List<Offer__c>) Trigger.new);
    }

    public override void afterInsert() {
        OfferService.handleAfterInsert((List<Offer__c>) Trigger.new);
    }

    public override void afterUpdate() {
        // No logic needed here for now
    }
}