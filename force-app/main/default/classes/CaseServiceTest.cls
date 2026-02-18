@IsTest
public class CaseServiceTest {

    @TestSetup
    static void setupData() {
        insert new List<Support_Case__c>{
            new Support_Case__c(SLA_Hours__c = 2, Status__c = 'New'),
            new Support_Case__c(SLA_Hours__c = 6, Status__c = 'New'),
            new Support_Case__c(SLA_Hours__c = 12, Status__c = 'New')
        };
    }

    @IsTest
    static void testPriorityAssignment() {

        List<Support_Case__c> cases = [
            SELECT SLA_Hours__c, Priority__c
            FROM Support_Case__c
        ];

        System.Test.startTest();
        update cases;
        System.Test.stopTest();

        for (Support_Case__c sc : cases) {
            if (sc.SLA_Hours__c <= 4) {
                System.assertEquals('High', sc.Priority__c);
            } else if (sc.SLA_Hours__c <= 8) {
                System.assertEquals('Medium', sc.Priority__c);
            } else {
                System.assertEquals('Low', sc.Priority__c);
            }
        }
    }
}
