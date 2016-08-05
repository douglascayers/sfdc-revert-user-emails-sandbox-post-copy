@isTest
private class RevertUserEmailsSandboxPostCopyTest {

    // https://developer.salesforce.com/forums/?id=906F0000000kAQfIAM

    @isTest
    static void test_post_copy() {

        Profile p = [ SELECT id FROM Profile WHERE name = 'Standard User' ];

        User user1;

        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_tools_runas.htm
        System.runAs( new User( id = UserInfo.getUserId() ) ) {

            user1 = newUser( p.id, 'Alpha', 'User 1', 'user_1=salesforce.com@example.com' );

            insert user1;

        }

        Test.startTest();

        Test.testSandboxPostCopyScript(
            new RevertUserEmailsSandboxPostCopy(), // apex class to run
            '00D1a000040BlpQ', // org id
            '00D90000000KY45', // sandbox id
            'My Sandbox' // sandbox name
        );

        Test.stopTest();

        user1 = [ SELECT id, email FROM User WHERE id = :user1.id ];

        System.assertEquals( 'user_1@salesforce.com', user1.email );

    }

    private static User newUser( ID profileId, String firstName, String lastName, String email ) {
        Integer rand = Math.round( Math.random() * 1000 );
        return new User(
            isActive = true,
            profileId = profileId,
            alias = firstName.substring(0,1) + lastName.substring(1,5),
            firstName = firstName,
            lastName = lastName,
            email = email,
            username = rand + email,
            emailEncodingKey = 'UTF-8',
            languageLocaleKey = 'en_US',
            localeSidKey = 'en_US',
            timeZoneSidKey = 'America/Chicago'
        );
    }

}