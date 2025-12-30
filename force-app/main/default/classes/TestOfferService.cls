@IsTest
public with sharing class TestOfferService {

    @TestSetup
    static void setupTestData() {
        // Create a property
        Property__c prop = new Property__c(
            Name = 'Test Property',
            Price__c = 100000,
            Status__c = 'Available'
        );
        insert prop;

        // Create an account (buyer)
        Account buyer = new Account(
            Name = 'Test Buyer'
        );
        insert buyer;
    }

    @IsTest
    static void testOfferValidationAndPropertyStatus() {
        Property__c prop = [SELECT Id, Status__c, Price__c FROM Property__c LIMIT 1];
        Account buyer = [SELECT Id FROM Account LIMIT 1];

        // Test offer lower than property price → should fail
        Offer__c lowOffer = new Offer__c(
            Property__c = prop.Id,
            Buyer__c = buyer.Id,
            Offer_Amount__c = 50000,
            Offer_Date__c = Date.today(),
            Offer_Status__c = 'New'
        );

        try {
            insert lowOffer;
            System.assert(false, 'Expected error for low offer, but insert succeeded');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Offer must be at least the property price'));
        }

        // Test valid offer → should succeed
        Offer__c validOffer = new Offer__c(
            Property__c = prop.Id,
            Buyer__c = buyer.Id,
            Offer_Amount__c = 120000,
            Offer_Date__c = Date.today(),
            Offer_Status__c = 'New'
        );
        insert validOffer;

        // Check Property status updated
        prop = [SELECT Status__c FROM Property__c WHERE Id = :prop.Id];
        System.assertEquals('Under Offer', prop.Status__c, 'Property status should be Under Offer');
    }
}