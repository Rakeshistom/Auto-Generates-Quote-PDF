@istest
private class generateQuotePdfDocumentTest {
    
    @testSetup
    static void setup() {
    
        //Adjust the record type based on yoru setting
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND developerName = 'Manufacturing'];
        
        Product2 product = new Product2();
        product.Name = 'Test Product ';
        product.ProductCode = '123';
        product.IsActive = true;
        insert product;
        
        PricebookEntry pbe = new PricebookEntry();
        pbe.Pricebook2Id = Test.getStandardPricebookId();
        pbe.Product2Id = product.Id;
        pbe.IsActive = true;
        pbe.UnitPrice = 10;
        insert pbe;
        
        Opportunity op = new Opportunity();
        op.Name = 'Test';
        op.RecordTypeId = rt.Id;
        op.Type = 'Value Proposition';
        op.CloseDate = Date.today().addDays(2);
        op.StageName = 'Created';
        
        insert op;
                
        Quote quote = new Quote();
        quote.OpportunityId = op.Id;
        quote.Name = 'TestQuote';
        quote.ExpirationDate = Date.today().addDays(5);
        quote.Status = 'Draft';
        quote.Pricebook2Id = Test.getStandardPricebookId();
        insert quote;
        
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = quote.Id;
        qli.Quantity = 2;
        qli.PricebookEntryId = pbe.Id;
        qli.UnitPrice = 20;
        insert qli;
    }
    
    @isTest
    static void generateQuotePdfTest() {
        
        Quote quote = [SELECT Id, Status FROM Quote LIMIT 1];
        
        quote.Status = 'Draft';
        update quote;
    }
    

}