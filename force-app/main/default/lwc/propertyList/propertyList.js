import { LightningElement, track, wire } from 'lwc';
import getProperties from '@salesforce/apex/PropertyController.getProperties';

export default class PropertyList extends LightningElement {
    @track properties;
    @track error;

    // Filter values
    statusFilter = '';
    typeFilter = '';
    minPrice;
    maxPrice;

    // Dropdown options
    statusOptions = [
    { label: 'All', value: '' },
    { label: 'Available', value: 'Available' },
    { label: 'Under Offer', value: 'Under Offer' }
];

typeOptions = [
    { label: 'All', value: '' },
    { label: 'Villa', value: 'Villa' },
    { label: 'Apartment', value: 'Apartment' },
    { label: 'Plot', value: 'Plot' }
];

    // Wire method to fetch properties
    @wire(getProperties, { statusVal: '$statusFilter', typeVal: '$typeFilter', minPrice: '$minPrice', maxPrice: '$maxPrice' })
    wiredProperties({ error, data }) {
        if (data) {
            this.properties = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.properties = undefined;
        }
    }

    // Handlers for filter changes
    handleStatusChange(event) {
        this.statusFilter = event.detail.value;
    }

    handleTypeChange(event) {
        this.typeFilter = event.detail.value;
    }

    handleMinPriceChange(event) {
        this.minPrice = event.target.value;
    }

    handleMaxPriceChange(event) {
        this.maxPrice = event.target.value;
    }
}