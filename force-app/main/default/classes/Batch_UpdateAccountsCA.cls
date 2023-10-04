public class Batch_UpdateAccountsCA implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext info){ 
        //Query only the accounts that have at least one order with the status 'Ordered'
        return Database.getQueryLocator('SELECT ID,Chiffre_d_affaire__c FROM Account WHERE ID IN (SELECT AccountID FROM Order WHERE Status = \'Ordered\')');

   }
    
   public void execute(Database.BatchableContext info, List<Account> scope){
    //Update the field "chiffre_d_affaire__c" of the query accounts (scope, which is a list of accounts)
    Handler_UpdateAccountCA.updateAccountCA(scope);
   }    
    
      public void finish(Database.BatchableContext info){   
         
     } 
} 