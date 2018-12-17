# Revert User Emails on Sandbox Post Copy

Salesforce adds `@example.com` or `.invalid` to users emails after sandbox refresh ([why?](https://help.salesforce.com/HTViewSolution?id=000193090&language=en_US)). This post script reverts the email addresses.

<a href="https://githubsfdeploy.herokuapp.com">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

# Inspiration

This project was inspired by [Beth Breisnes](https://twitter.com/bethbrains) who [asked on Twitter](https://twitter.com/bethbrains/status/761293965211545600) if someone had a [Sandbox Post Copy](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_interface_System_SandboxPostCopy.htm) script that would fix users' emails in a sandbox.

# Viability

I put together a simple proof-of-concept and test class that shows how to mass update all the users' email addresses. However, I have *not* tested this in a real sandbox. One concern is whether Salesforce will send an "email change verification" to all the users before the change takes effect as is protocol when changing user's emails via Setup. If yes then you likely spammed all your users -- that may or may not be what you were going for.

# Email Change Verification

[Daniel Peter](https://twitter.com/danieljpeter/status/761392217734811648) shared a thread on [Salesforce StackExchange](http://salesforce.stackexchange.com/questions/9878/how-to-mass-change-emails-with-sending-only-a-password-reset-mail-in-apex) about how some folks try to by-pass their users having to click the verification link themselves, which may or may not be applicable for Sandbox Post Copy (I'm just not sure!).

# Disable Email Change Verification

If email change verification *is* a problem (I'm not sure yet, I've not tested this in a real sandbox) and you still want to use this technique then you could contact Salesforce Support and [request that the verification step be disabled](http://help.salesforce.com/HTViewSolution?id=000003832).
