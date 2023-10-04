@isTest
public class Test_01_DataGeneration {
    public static void createData(Integer nbAccounts) {
    
    List<Account> accounts = new List<Account>();
    List<Order> orders = new List<Order>();
    List<OrderItem> items = new List<OrderItem>();
    
    for(Integer i=0; i<nbAccounts; i++){    // Create n accounts and add them into the list of accounts inserted 
        Account acc = new Account(Name = 'Test Account '+ i);
        accounts.add(acc);
    }
    insert accounts;
    
    // give each account an order
    for(Account acc : accounts){
        Order order = new Order(AccountId = acc.Id, EffectiveDate=System.today(), Status='Ordered', Pricebook2Id= Test.getStandardPricebookId(), ShipmentCost__c=50);
        orders.add(order);
    }
    insert orders;

    Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
    Insert pd1;

    //Create the PricebookEntry
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = Test.getStandardPricebookId(),
        Product2Id = pd1.Id,
        UnitPrice = 1020,
        IsActive = true
    );
    Insert pbe;

    // It is used to create records of the OrderItem object associated with specific Order records 
    // using data from the orders list and insert them into Salesforce
    for(Order o : orders){
    OrderItem oi1 = new OrderItem (OrderId = o.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
    items.add(oi1);
    OrderItem oi2 = new OrderItem (OrderId = o.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
    items.add(oi2);
    }
    insert items;
}
}