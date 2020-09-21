/**
 * @description       : 
 * @author            : santiagorqui@gmail.com
 * @group             : 
 * @last modified on  : 09-21-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   09-21-2020   santiagorqui@gmail.com               Initial Version
**/
@isTest
public with sharing class CaseTgrHandlerTst {

    public CaseTgrHandlerTst() {
    }

    /*
    ** Description: TestSetup Allows the creation of data for the use 
    *************** this way we don't depend of the data in the org
    */
    @TestSetup
    static void makeData(){
        Account ac = new Account();
        Case cs = new Case();
        ac.Name = 'TestData';
        Insert ac;
        cs.AccountId = ac.Id;
        cs.Product__c = 'GC1040';
        cs.Type = 'Mechanical';
    }
    
    /*
    ** Description: This Method Validates the functionality of the trigger and the handler
    */
    @IsTest
    static void methodName(){
        Case csCreated = [SELECT Id FROM Case LIMIT 1];//Get the case created in the setup
        csCreated.status = 'Cerrado';
        Test.startTest();
            //System.runAs(contextuser){No need to call the user since it's being done with the admin
            //}
            update csCreated;
        Test.stopTest();
        String CaseEval = [SELECT Id from Case WHERE RecordType.DeveloperName =:label.CaseEvaluacionRcType].RecordType.DeveloperName;
        System.assertEquals(label.CaseEvaluacionRcType,CaseEval);
        
    }
}
