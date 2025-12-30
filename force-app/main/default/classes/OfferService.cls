public with sharing class OfferService {

    // Validate that offer amount >= property price
    public static void validateOfferAmount(List<Offer__c> offers) {
        Set<Id> propertyIds = new Set<Id>();
        for (Offer__c o : offers) {
            if (o.Property__c != null) propertyIds.add(o.Property__c);
        }

        Map<Id, Property__c> propertyMap = new Map<Id, Property__c>(
            PropertySelector.getByIds(propertyIds)
        );

        for (Offer__c o : offers) {
            Property__c p = propertyMap.get(o.Property__c);
            if (p != null && o.Offer_Amount__c < p.Price__c) {
                o.addError('Offer must be at least the property price.');
            }
        }
    }

    // Update Property status to 'Under Offer' after first offer
    public static void handleAfterInsert(List<Offer__c> offers) {
        Set<Id> propertyIds = new Set<Id>();
        for (Offer__c o : offers) propertyIds.add(o.Property__c);

        List<Property__c> properties = PropertySelector.getByIds(propertyIds);

        for (Property__c p : properties) {
            if (p.Status__c != 'Under Offer') p.Status__c = 'Under Offer';
        }

        update properties;
    }
}