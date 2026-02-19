import { LightningElement, wire } from 'lwc';
import createSupportCase from '@salesforce/apex/SupportCaseController.createSupportCase';
import getCases from '@salesforce/apex/SupportCaseController.getCases';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SupportCaseManager extends LightningElement {

    subject;
    slaHours;
    status = 'New';

    statusOptions = [
        { label: 'New', value: 'New' },
        { label: 'In Progress', value: 'In Progress' },
        { label: 'Closed', value: 'Closed' }
    ];

    columns = [
        { label: 'Subject', fieldName: 'Name' },
        { label: 'SLA Hours', fieldName: 'SLA_Hours__c' },
        { label: 'Priority', fieldName: 'Priority__c' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    @wire(getCases)
    cases;

    handleSubject(e) {
        this.subject = e.target.value;
    }

    handleSla(e) {
        this.slaHours = e.target.value;
    }

    handleStatus(e) {
        this.status = e.target.value;
    }

    createCase() {

        if (!this.validateInputs()) {
            return; // ❌ Stop if validation fails
        }
        createSupportCase({
            subject: this.subject,
            slaHours: this.slaHours,
            status: this.status
        })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Support Case created',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.error(error);
            });
    }

    validateInputs() {
        let isValid = true;

        const slaInput = this.template.querySelector(
            'lightning-input[type="number"]'
        );

        if (!this.slaHours || this.slaHours <= 0) {
            slaInput.setCustomValidity(
                'SLA Hours must be greater than 0'
            );
            isValid = false;
        } else {
            slaInput.setCustomValidity('');
        }

        slaInput.reportValidity();
        return isValid;
    }

    handleError(error) {
        let message = 'Unknown error';

        if (error?.body?.message) {
            message = error.body.message;
        }

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message,
                variant: 'error'
            })
        );
    }


}
