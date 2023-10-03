@isTest
private class Test_02_Handler_UpdateAccountCA {
    @TestSetup
    static void setup(){
    Test_01_DataGeneration.createData(4);
    }
    @isTest static void testAfterupdate() {
        Test.startTest(); 
        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c FROM Account];

        list<Order> orders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE AccountId IN :accounts];  
        //Handler_UpdateAccountCA.updateAccountCAForTrigger(orders);
        update orders;
        Test.stopTest();
        List<Account> result = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        for (Order o : orders) {
        // Assurez-vous que le champ totalAmount a été mis à jour correctement
        System.assertEquals(21500, o.TotalAmount, 'le champ totalAmount a été calculé');
        }
        for(Account a : result){
            System.assertEquals(21500, a.Chiffre_d_affaire__c, 'le chiffre d\'affaire a été recalculé');
        }
    }

}