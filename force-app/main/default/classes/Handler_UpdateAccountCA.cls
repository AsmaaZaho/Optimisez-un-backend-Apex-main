public with sharing class Handler_UpdateAccountCA {

    public static void updateAccountCA(List<Account> listAccounts) {
        //mettre à jour le chiffre d'affaire de chaque compte de la liste listAccounts 
        //en fonction des montants totaux des ORDERS associées
        list<Account> listOfAccountToUpdate = new List<Account>();
        Map<Id,AggregateResult> sumOfTotalAmount = new Map<Id,AggregateResult>([SELECT AccountId Id, SUM(TotalAmount) total FROM Order WHERE AccountId In :listAccounts GROUP BY AccountId]);

        for(Account a : listAccounts){
            Decimal totalAmount =(decimal)sumOfTotalAmount.get(a.Id).get('total');
            
            a.Chiffre_d_affaire__c = (a.Chiffre_d_affaire__c != null) ? a.Chiffre_d_affaire__c + totalAmount :totalAmount;
            listOfAccountToUpdate.add(a);
        }
        if (Account.SObjectType.getDescribe().isUpdateable() == false) {
             throw new DmlException('No permissions to update');
         }
        update listAccounts;
    }

    public static void updateAccountCAForTrigger(list<Order> orders, Map<Id, sObject> oldMap){

        // Cette méthode est destinée à être appelée depuis un déclencheur (trigger) lorsqu'une commande est insérée ou mise à jour
        list<Account> listOfAccountToUpdate = new List<Account>();
        list<Account> acc = new list<Account>();
        Map<ID, Decimal> amounts = new Map<ID, Decimal>();

        for(Order o : orders){
            Decimal newTotalAmount = o.TotalAmount - (decimal)oldMap.get(o.Id).get('TotalAmount');
            amounts.put(o.AccountId, newTotalAmount);
        }

        acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :amounts.keySet()];

        //Itérer sur les comptes récupérés, met à jour leur CA en fonction des montants stockés dans la Map amounts, 
        // en veillant à ce que le CA ne devienne pas négatif.
        for(Account a : acc){
            Decimal ca = (a.Chiffre_d_affaire__c != null)? a.Chiffre_d_affaire__c + amounts.get(a.ID): amounts.get(a.ID);
            a.Chiffre_d_affaire__c = (ca<0)?0:ca;
            listOfAccountToUpdate.add(a);
        }
        update listOfAccountToUpdate;
                
   }
}