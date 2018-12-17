/**
 * When sandboxes refresh, all users' email addresses have @example.com appended to them,
 * after Spring '19 release, have .invalid appended to them.
 * This is a safety feature to prevent unexpected or unwanted emails to be sent from sandbox to users.
 * This class reverts all active users' email addresses by removing the @example.com.
 * https://help.salesforce.com/articleView?id=data_sandbox_implementation_tips.htm
 * https://help.salesforce.com/HTViewSolution?id=000193090&language=en_US
 * http://releasenotes.docs.salesforce.com/en-us/spring19/release-notes/rn_sandboxes_email_management.htm
 */
public with sharing class RevertUserEmailsBatchable implements Database.Batchable<SObject> {

    public Database.QueryLocator start( Database.BatchableContext context ) {
        return Database.getQueryLocator( 'SELECT id, email FROM User WHERE isActive = true' );
    }

    public void execute( Database.BatchableContext context, List<User> users ) {

        for ( User u : users ) {

            System.debug( 'user sandbox email: ' + u.email );

            u.email = u.email.replace('@example.com', '').replace('=', '@').removeEndIgnoreCase( '.invalid' );

            System.debug( 'user reverted email: ' + u.email );

        }

        update users;

    }

    public void finish( Database.BatchableContext context ) {

    }

}
