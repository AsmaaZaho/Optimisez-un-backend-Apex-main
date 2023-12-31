@isTest
private class Test_02_Handler_UpdateAccountCA {
    @TestSetup
    static void setup(){
    Test_01_DataGeneration.createData(4);
    }
    @isTest static void testAfterupdate() {
        //Test the behavior of an update to Order records and the corresponding update of fields 'totalAmount' and 'chiffre_d_affaire__c'
        Test.startTest(); 
        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        list<Order> orders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE AccountId IN :accounts];  
        update orders;
        Test.stopTest();
        List<Account> result = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        for (Order o : orders) {
        // Ensure that the 'totalAmount' field has been calculating correctly
            System.assertEquals(21500, o.TotalAmount, 'le champ totalAmount a été calculé');
        }
        // Ensure that the 'Chiffre_d_affaire__c' field has been updated correctly
        for(Account a : result){
            System.assertEquals(21500, a.Chiffre_d_affaire__c, 'le chiffre d\'affaire a été mis à jour');
        }
    }

}