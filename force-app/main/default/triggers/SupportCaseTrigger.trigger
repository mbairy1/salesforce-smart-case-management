trigger SupportCaseTrigger on Support_Case__c (
    before insert,
    before update
) {
    CaseTriggerHandler.beforeInsertOrUpdate(
        Trigger.new,
        Trigger.oldMap
    );
}
