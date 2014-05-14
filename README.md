Informative
===========

iOS library for creating an information view positioned below the status bar, similar to the inbuilt iOS in-call status bar.

Compatible with iOS 6/7, iPhone & iPad.

* Appears on all UINavigationControllers automatically
* Supports tap handler
* Supports use of any UIView, `InformationView` provided (can be subclassed)
* No use of private APIs

![Informative Demo](./informative.gif)

### Installation

Add ```pod 'Informative', git: 'https://github.com/davidlawson/Informative'``` to your Podfile.

### Example Code

```objc
Informative *informative = [Informative singleton];

informative.tapInformationView = ^{
  [[[UIAlertView alloc] initWithTitle:@"Tapped Information View" message:@"Awesome!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
};

informative.createInformationView = ^UIView*
{
  InformationView *notReachableView = [[InformationView alloc] initWithScreenBounds];
  notReachableView.text = @"No Internet Connection";
  return notReachableView;
};

// Inside reachability handler
[Informative singleton].showInformation = !reachable;
```
