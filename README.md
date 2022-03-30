# Engage Flutter Plugin 

[Engage](https://engage.so/) is all you need to deliver personalized customer messaging and marketing automation through email, SMS and in-app messaging. This flutter plugin makes it easy to identify customers, sync customer data (attributes, events and device tokens) to the Engage dashboard and send in-app messages to the device.

## Features

- Track device token
- Identify customers
- Update customer attributes
- Track customer events

## Getting started

- [Create an Engage account](https://engage.so/) and set up an account to get your public API key.
- Learn about [connecting customer data](https://engage.so/docs/guides/connecting-user-data) to Engage.
- Add the Engage Flutter Plugin to your project.   
`flutter pub add engage`

## Usage

Import `package:engage/engage.dart` and initialize the plugin.

```dart
// ...
import 'package:engage/engage.dart';

void main() async {
  Engage.init('publicKey');
  // ...
  runApp(const MyApp());
}
```

Engage uses your customer's unique identifier (this is mostly the id field of the users' table) to update the customer's attributes and track events. Here is the code to update a set of customer attributes for example:

```dart
Engage.addAttributes'uniqueUserId', {
  'plan': 'Pro'
});
```

`addAttributes` adds the attribute to the customer profile if it doesn't exist and updates it if it does already. You will want to add that to parts of your application where customer attributes are updated. For example, to add a `last_login` date attribute, you need to call `addAttributes` on successful login within your code.

```dart
void logIn() async {
  // ... 
  Engage.addAttributes('u1234', {
    'last_login': DateTime.now()
  });
}
```

To help you correctly "identify" the user beyond just the ID, we recommend you track a few additional attributes. They are `first_name`, `last_name`, `email`, `number` (customer's phone number). We call them standard attributes. They help you identify the customer on the Engage dashboard. Depending on the ones supported by your platform, you can track one or more.

You only need to track a standard attribute once, unless they change and you use `addAttributes` to update them. We call this "identifying" the customer.

```dart
Engage.identify('u1234', {
  'first_name': 'Opeyemi',
  'last_name': 'O.'
});
```

We recommend you do this in two places:
1. After login - this helps identify old customers that have sent data to Engage but are yet to be identified.
2. On signup - this helps identify new customers.

In the background, `identify` and `addAttributes` do the same thing. The truth is that you can use them interchangeably.

To track customer events, use `trackEvents`. Here it is in the most basic form.

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

Finally, to use Engage for push notifications, we require you add your customer's device token to their profile. To send this to Engage, get the token and call `setDeviceToken`. (You need to have installed and configured Firebase to get the device token).

```dart
void main() async {
  Engage.init('publicKey');
  WidgetsFlutterBinding.ensureInitialized();
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

