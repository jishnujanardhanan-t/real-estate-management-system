public with sharing class PropertyVisitTriggerHandler extends TriggerHandler {

    public override void afterInsert() {
        PropertyVisitService.handleAfterInsert((List<Property_Visit__c>) Trigger.new);
    }
}