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
}
