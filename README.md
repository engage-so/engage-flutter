# Engage Flutter Plugin 

[Engage](https://engage.so/) is all you need to deliver personalized customer messaging and marketing automation through email, SMS and in-app messaging. This flutter plugin makes it easy to identify customers, sync customer data (attributes, events and device tokens) to the Engage dashboard and send in-app messages to the device.

## Features

- Identify customers
- Update customer attributes
- Track customer events
- Track device token

## Getting started

- [Create an Engage account](https://engage.so/) and set up an account to get your public API key.
- Learn about [connecting user data](https://engage.so/docs/guides/connecting-user-data) to Engage.
- Add the Engage Flutter Plugin to your project.   
`flutter pub add engage`

## Initializing the plugin

Import `package:engage/engage.dart` and initialize the plugin.

```dart
// ...
import 'package:engage/engage.dart';

void main() async {
  // Run this before you initialize the Engage plugin
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the plugin
  await Engage.init('publicKey');
  // ...
  runApp(const MyApp());
}
```

## Identifying users and updating attributes

The plugin uses your user's unique identifier (this is mostly the id field of the users' table) to update the user's attributes, track events and perform other user-related actions. Here is the code to update a set of user attributes for example:

```dart
Engage.addAttributes('uniqueUserId', {
  'plan': 'Pro'
});
```

`addAttributes` adds the attribute to the user profile if it doesn't exist and updates it if it does already. You will want to add that to parts of your application where user attributes are updated. For example, to add a `last_login` date attribute, you need to call `addAttributes` on successful login within your code.

```dart
void logIn() async {
  // ... 
  Engage.addAttributes('u1234', {
    'last_login': DateTime.now()
  });
}
```

To help you correctly "identify" the user beyond just the ID, we recommend you track a few additional user attributes. This can be anything depending on what properties you request from users on your product. Example: `location`, `gender`, `plan`. These are some we have standardized within Engage: `first_name`, `last_name`, `email`, `number` (user's phone number), `tz` (user's timezone). We call them standard attributes. However, remember you can track other attributes outside the standard ones. 

You only need to track an attribute once, unless they change and you use `addAttributes` to update them. We call this "identifying" the user.

```dart
// This maps the user ID u1234 to Opeyemi O.
Engage.identify('u1234', {
  'first_name': 'Opeyemi',
  'last_name': 'O.'
});
```

We recommend you do this in two places:
1. After login - this helps identify old users that have sent data to Engage but are yet to be identified.
2. On signup - this helps identify new users.

By default, Engage sets the signup date of a newly identified user to the current timestamp. This can be changed with the `created_at` parameter.

```dart
Engage.identify('u1234', {
  'first_name': 'Opeyemi',
  'last_name': 'O.',
  'created_at': '2021-09-14'
});
```

## Anonymous ID

Sometimes, you want to track user events before you identify them. For example, a user may download your app and explore some of the available features before they sign up and are assigned a unique ID. We call this an anonymous user. You can use any random ID (we call this an anonymous ID) to track events for the anonymous user and merge it with the actual user when identified.

If we need to track stuff before the user is identified:

```dart
// import 'package:uuid/uuid.dart';

// Generate a random unique ID
var id = uuid.v4()
Engage.trackEvents(id, 'Launched app');
// ...Somewhere else, using same id
Engage.trackEvents(id, 'Opened gallery');
```

Once user is identified:

```dart
void logIn() async {
  // ... 
  // User user = User.fromJson(result);
  // Merge the anonymous id to the identified user
  Engage.merge(id, user.id);
}
```

## Tracking events

To track user events, use `trackEvents`. Here it is in the most basic form.

```dart
Engage.trackEvents('u1234', 'Sign up');
```

Events can have a value:

```dart
Engage.trackEvents('u1234', 'Paid', 35);
Engage.trackEvents('u1234', 'Clicked', 'pro_course_3');
```

Or properties:

```dart
Engage.trackEvents('u1234', 'Transfer', {
  'to': 'u6789',
  'amount': 345.50,
  'deliver_on': DateTime.now()
});
```

By default, the events are stamped by your current timestamp. To use a custom date, add a date argument.

```dart
Engage.trackEvents('u1234', 'Sign up', DateTime.now());
```

## Push notifications and Setting device token

Finally, to use Engage for push notifications, we require you add your user's device token to their profile. To send this to Engage, get the token and call `setDeviceToken`. (You need to have installed and configured Firebase to get the device token).

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Engage.init('publicKey');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.instance
    .getToken()
    .then((String? token) {
      if (token != null) {
        Engage.setDeviceToken('u1334', token);
      }
    });
  runApp(const MyApp());
}
```

## Managing Accounts

The plugin has some additional methods to help you manage [Accounts](https://docs.engage.so/en-us/a/638b651db6bd27a330786c09-accounts).

They are:
- `addToAccount`: Add the Customer to an Account
- `removeFromAccount`: Remove the Customer from an Account
- `changeAccountRole`: Change the Customer's role in the Account
- `convertToAccount`: Convert the Customer profile to an Account
- `convertToCustomer`: convert the Account profile to a Customer