/**
 * When sandboxes refresh, all users' email addresses have @example.com appended to them.
 * This is a safety feature to prevent unexpected or unwanted emails to be sent from sandbox to users.
 * This class reverts all active users' email addresses by removing the @example.com.
 * https://help.salesforce.com/HTViewSolution?id=000193090&language=en_US
 */
global class RevertUserEmailsSandboxPostCopy implements SandboxPostCopy {

    global void runApexClass( SandboxContext context ) {

        System.debug( 'Organization ID: ' + context.organizationId() );
        System.debug( 'Sandbox ID: ' + context.sandboxId() );
        System.debug( 'Sandbox Name: ' + context.sandboxName() );

        Database.executeBatch( new RevertUserEmailsBatchable() );

    }

}