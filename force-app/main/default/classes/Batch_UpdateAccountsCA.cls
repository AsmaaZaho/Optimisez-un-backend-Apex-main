public class Batch_UpdateAccountsCA implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator('SELECT ID,Chiffre_d_affaire__c FROM Account WHERE ID IN (SELECT AccountID FROM Order WHERE Status = \'Ordered\')');

   }
    
   public void execute(Database.BatchableContext info, List<Account> scope){
       //Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
       Handler_UpdateAccountCA.updateAccountCA(scope);
   }    
    
      public void finish(Database.BatchableContext info){   
         
     } 
} 