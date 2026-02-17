trigger SupportCaseTrigger on Support_case__c (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        CaseTriggerHandler.beforeInsertOrUpdate(Trigger.new);
    }
}