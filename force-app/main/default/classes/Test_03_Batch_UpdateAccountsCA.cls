@isTest
private class Test_03_Batch_UpdateAccountsCA {
    @TestSetup
    static void setup() {
    Test_01_DataGeneration.createData(700);
    }
    @isTest static void testBatch() {
        // Verify that the batch class correctly updates the 'CA' fields of 'Account' records by executing a batch of 700 records at the same time
        Test.startTest();
        Batch_UpdateAccountsCA account = new Batch_UpdateAccountsCA();
        ID idBatch = Database.executeBatch(account, 700);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        List<Account> updatedAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        for (Account acc : updatedAccounts) {
            System.assertEquals(21500, acc.Chiffre_d_affaire__c, 'le chiffre d\'affaire de chaque compte a été mis à jour');
        }
    }      
}