@isTest
private class Test_03_Batch_UpdateAccountsCA {
    @TestSetup
    static void setup() {
    Test_01_DataGeneration.createData(700);
    }
    @isTest static void testBatch() {
        Test.startTest();
        Batch_UpdateAccountsCA account = new Batch_UpdateAccountsCA();
        ID idBatch = Database.executeBatch(account, 700);
        //Database.executeBatch(account);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        //Account[] accUpdatedCA = [SELECT ID,Chiffre_d_affaire__c from Account WHERE ID= :idBatch];
        // System.assertEquals(21500, accUpdatedCA.Chiffre_d_affaire__c);
        List<Account> updatedAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        for (Account acc : updatedAccounts) {
            System.assertEquals(21500, acc.Chiffre_d_affaire__c, 'le chiffre d\'affaire de chaque compte a été mis à jour');
        }
    }      
}