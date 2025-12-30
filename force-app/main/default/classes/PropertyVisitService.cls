public with sharing class PropertyVisitService {

    // Increment Total_Visits__c on Property__c for newly inserted visits
    public static void handleAfterInsert(List<Property_Visit__c> visits) {
        // Collect all related property IDs
        Set<Id> propertyIds = new Set<Id>();
        for (Property_Visit__c visit : visits) {
            if (visit.Property__c != null) propertyIds.add(visit.Property__c);
        }

        // Query all related properties
        Map<Id, Property__c> propertyMap = new Map<Id, Property__c>(
            [SELECT Id, Total_Visits__c FROM Property__c WHERE Id IN :propertyIds]
        );

        // Increment Total_Visits__c
        for (Property_Visit__c visit : visits) {
            Property__c prop = propertyMap.get(visit.Property__c);
            if (prop != null) {
                if (prop.Total_Visits__c == null) prop.Total_Visits__c = 0;
                prop.Total_Visits__c += 1;
            }
        }

        // Update properties
        update propertyMap.values();
    }
}