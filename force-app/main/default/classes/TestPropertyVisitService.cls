@IsTest
public with sharing class TestPropertyVisitService {

    @TestSetup
    static void setupTestData() {
        // Create a property
        Property__c prop = new Property__c(
            Name = 'Visit Test Property',
            Price__c = 50000,
            Status__c = 'Available',
            Total_Visits__c = 0
        );
        insert prop;
    }

    @IsTest
    static void testPropertyVisitIncrement() {
        Property__c prop = [SELECT Id, Total_Visits__c FROM Property__c LIMIT 1];

        // Insert a single visit
        Property_Visit__c visit1 = new Property_Visit__c(
            Property__c = prop.Id,
            Visit_Date__c = Date.today()
        );
        insert visit1;

        prop = [SELECT Total_Visits__c FROM Property__c WHERE Id = :prop.Id];
        System.assertEquals(1, prop.Total_Visits__c, 'Total visits should increment by 1');

        // Insert multiple visits (bulk test)
        List<Property_Visit__c> visits = new List<Property_Visit__c>();
        for (Integer i = 0; i < 4; i++) {
            visits.add(new Property_Visit__c(
                Property__c = prop.Id,
                Visit_Date__c = Date.today().addDays(i)
            ));
        }
        insert visits;

        prop = [SELECT Total_Visits__c FROM Property__c WHERE Id = :prop.Id];
        System.assertEquals(5, prop.Total_Visits__c, 'Total visits should increment correctly for bulk insert');
    }
}