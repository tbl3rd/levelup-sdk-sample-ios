LevelUp SDK iOS Sample
======================

This project is an example of how to use the LevelUp SDK to add the ability to pay using LevelUp to your iOS app.

The app demonstrates logging in, registering, and paying as well a sample of how to make network requests.

LevelUp works by providing a QR code to the user which can be scanned at participating merchants using a LevelUp-provided code scanner. The QR code (also known as the LevelUp Code) contains the Payment Token as well as some user preferences that the scanner can understand.

For complete documentation on using the LevelUp SDK, visit our [Developer Portal](http://developer.thelevelup.com/).

Getting Started
---------------

This demo uses [CocoaPods](http://cocoapods.org/). See also the [Getting Started: iOS](http://developer.thelevelup.com/mobile-sdks/getting-started/ios/) page on the LevelUp Developer site.

Once you've installed the app's dependencies, you'll need one more thing: an App ID and an API key. These are provided to you when you become a LevelUp developer. Once you have these values, update the `setupWithAppID:APIKey:` method in the App Delegate to pass in these values:

```objective-c
[LUAPIClient setupWithAppID:@"your-app-id" APIKey:@"your-api-key"];
```

Request Handling
----------------

The LevelUp SDK provides the `LUAPIClient` class for asynchronously performing API requests. The SDK will take care of turning on the network indicator in the status bar when a network request is running, but beyond that you may wish to display a custom loading message or perform your own error handling.

The sample app's `LURequestHandler` shows one way to do this. It accepts a request, a success block, and an optional failure block. When issuing the request, it wraps the success and failure blocks within its own blocks that show loading messages and display errors. In this app, [SVProgressHUD](https://github.com/samvermette/SVProgressHUD) is used to give feedback to the user.

Authentication Handling
-----------------------

When a user authenticates with LevelUp, you receive an instance of `LUAccessToken` which consists of an authentication token and the user's ID. These values need to be given to `LUAPIClient` so that they can be included in authenticated requests. `LUAPIClient` only stores these values in memory, so you are responsible for securely persisting these values across app launches.

In general, the most common way of persisting data in iOS apps is `NSUserDefaults`. However, `NSUserDefaults` stores values in plain text and shouldn't be used for sensitive data. The recommended way to securely store data in iOS is through [Keychain Services](https://developer.apple.com/library/ios/DOCUMENTATION/Security/Conceptual/keychainServConcepts/iPhoneTasks/iPhoneTasks.html).

The sample app uses a class called `LUAuthenticationHandler` as a wrapper around authentication actions. It stores the access token in the Keychain using [LUKeychainAccess](https://github.com/TheLevelUp/LUKeychainAccess), which is an open source project built by LevelUp to provide an Objective-C wrapper around the Keychain Services API.

In addition to storing and retrieving access tokens, `LUAuthenticationHandler` also provides methods `logInWithAccessToken:` and `logOut` which are used to log in and log out. These methods communicate with the app delegate to update the app's root view controller when a user logs in or out.
