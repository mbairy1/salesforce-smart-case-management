public with sharing class CaseTriggerHandler {
    public static void beforeInsertOrUpdate(List<Support_Case__c> cases) {
        CaseService.updatePriority(cases);
    }
}   