public with sharing class PropertySelector {

    public static List<Property__c> getByIds(Set<Id> propertyIds) {

        if (propertyIds == null || propertyIds.isEmpty()) {
            return new List<Property__c>();
        }

        return [
            SELECT Id,
                   Status__c,
                   Price__c,
                   Total_Visits__c
            FROM Property__c
            WHERE Id IN :propertyIds
        ];
    }
}