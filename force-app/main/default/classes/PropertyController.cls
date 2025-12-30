public with sharing class PropertyController {
    @AuraEnabled(cacheable=true)
    public static List<Property__c> getProperties(String statusVal, String typeVal, Decimal minPrice, Decimal maxPrice) {
        String statusFilter = String.isBlank(statusVal) ? '%' : statusVal;
        String typeFilter = String.isBlank(typeVal) ? '%' : typeVal;

        String query = 'SELECT Id, Name, Address__c, Area_sq_ft__c, Listed_Date__c,' +
                       'Price__c, Seller__c, Seller__r.Name, Status__c, Total_Visits__c, Property_Type__c ' +
                       'FROM Property__c WHERE Status__c LIKE :statusFilter AND Property_Type__c LIKE :typeFilter';

        if (minPrice != null) query += ' AND Price__c >= :minPrice';
        if (maxPrice != null) query += ' AND Price__c <= :maxPrice';

        query += ' ORDER BY Listed_Date__c DESC';

        return Database.query(query);
    }
}