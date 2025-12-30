trigger PropertyVisitTrigger on Property_Visit__c (
    after insert
) {
    new PropertyVisitTriggerHandler().run();
}