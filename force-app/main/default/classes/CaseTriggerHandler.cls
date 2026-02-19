// public with sharing class CaseTriggerHandler {

//     public static void beforeInsertOrUpdate(
//         List<Support_Case__c> newCases,
//         Map<Id, Support_Case__c> oldMap
//     ) {
//         List<Support_Case__c> casesToProcess = new List<Support_Case__c>();

//         System.debug('🔥 CaseTriggerHandler is executing');
        
//         for (Support_Case__c sc : newCases) {

//             System.debug('🔥 CaseTriggerHandler is executing');
//             // 🚫 BACKEND VALIDATION (always enforced)
//             if (sc.SLA_Hours__c == null || sc.SLA_Hours__c <= 0) {
//                 sc.SLA_Hours__c.addError(
//                     'SLA Hours must be greater than 0'
//                 );
//                 continue;
//             }

//             // INSERT → always calculate priority
//             if (oldMap == null) {
//                 casesToProcess.add(sc);
//             }
//             // UPDATE → only if SLA changed
//             else if (
//                 sc.SLA_Hours__c != oldMap.get(sc.Id).SLA_Hours__c
//             ) {
//                 casesToProcess.add(sc);
//             }
//         }

//         if (!casesToProcess.isEmpty()) {
//             CaseService.updatePriority(casesToProcess);
//         }
//     }
// }


public with sharing class CaseTriggerHandler {

    public static void beforeInsertOrUpdate(
        List<Support_Case__c> newCases,
        Map<Id, Support_Case__c> oldMap
    ) {
        for (Support_Case__c sc : newCases) {
            sc.addError('🔥 Trigger is firing');
        }
    }
}
