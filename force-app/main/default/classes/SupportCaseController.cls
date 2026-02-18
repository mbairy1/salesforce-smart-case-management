public with sharing class SupportCaseController {

    @AuraEnabled
    public static Id createSupportCase (
        String subject,
        Decimal slaHours,
        String status){
            Support_Case__c sc = new Support_Case__c(
                Name = subject,
                SLA_Hours__c = slaHours,
                Status__c = status
            );

            insert sc; // This will trigger the CaseTriggerHandler and update the Priority__c field based on SLA_Hours__c
            return sc.Id;
        }

        @AuraEnabled
        public static List<Support_Case__c> getCases() {
            return [
                SELECT Name, SLA_Hours__c, Status__c, Priority__c
                FROM Support_Case__c
                ORDER BY CreatedDate DESC
                LIMIT 10
            ];
        }
    }
 
