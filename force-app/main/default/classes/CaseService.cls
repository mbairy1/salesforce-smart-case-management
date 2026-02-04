public with sharing class CaseService {
    public static void updatePriority(List<Support_Case__c> cases) {
        for (Support_Case__c sc : cases) {
            if (sc.SLA_Hours__c != null && sc.SLA_Hours__c <= 4) {
                sc.Priority__c = 'High';
            } else {
                sc.Priority__c = 'Medium';
            }
        }
    }
}