public class CaseServiceTest {
    @TestSetup
    static void setupData() {
        List<Support_Case__c> cases = new List<Support_Case__c>();
        for (Integer i = 0; i < 5; i++) {
            cases.add(new Support_Case__c(
                Name = 'Test Case ' + i,
                SLA_Hours__c = i
            ));
        }
        insert cases;
    }

    @isTest
    static void testHighPriorityCases(){
        List<Support_Case__c> cases = [SELECT SLA_Hours__c, Priority__c FROM Support_Case__c WHERE SLA_Hours__c <=4];
        Test.startTest();
        update cases;
        Test.stopTest();

        for(Support_Case__c sc: cases){
            System.assertEquals('High', sc.Priority__c);
        }
    }

    @isTest
    static void testMediumPriorityCase() {
        Support_Case__c caseRecord = new Support_Case__c (
            Name = 'Medium Case',
            SLA_Hours__c = 8
        );

        insert sc;

        sc = [SELECT Priority__c FROM Support_Case__c WHERE Id = :sc.Id];
    }

}
