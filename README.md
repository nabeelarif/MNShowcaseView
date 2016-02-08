# MNShowcaseView
MNShowcaseView can highlight particular view of your app and describe about it as a guided tutorial. It can be used as guided tutorial in your app where you can tell new user's how they can use different items in your app.


<img src="https://github.com/nabeelarif100/MNShowcaseView/blob/master/MNShowcaseView.gif" alt="alt text" width="308" height="550">

## Requirements

* Xcode 7 or higher
* iOS 7.0 or higher
* ARC
* Objective-C

## Installation

####CocoaPods


```ruby
use_frameworks!
pod "MNShowcaseView"
```

####Manual

## Usage
Simple with one view to focus on with title +info
```Objective-C
MNShowcaseView *showcaseViwe = [[MNShowcaseView alloc] initWithViewToFocus:self.button
         title:@"Title String" description:@"Description String"];
[showcaseViwe showOnMainWindow];
```
OR MNShowcaseView with multiple views and their title+info
```Objective-C
MNShowcaseView *showcaseViwe = [[MNShowcaseView alloc] initWithViewsToFocus:@[slef.view1,self.view2]
         title:@[@"Title 1",@"Title 2"] description:@[@"Description 1",@"Description 2"]];
// Add showcase view in current view controller.
[showcaseViwe showOnView:viewController.view];
```
OR MNShowcaseView with detailed settings about View to focus
```Objective-C
// Create MNShowcaseItem
MNShowcaseItem *item = [[MNShowcaseItem alloc] initWithViewToFocus:self.button
                                                             title:@"Title String" description:@"Description String"];
item.highlightedColor = [UIColor greenColor];
item.buttonTitle = @"DONE";
item.selectionType = MNSelection_Rectangle;
item.buttonPosition = MNButtonPosition_TopRight;
item.titleColor = [UIColor greenColor];
item.titleFont = [UIFont boldSystemFontOfSize:22];
item.descriptionColor = [UIColor yellowColor];
item.descriptionFont = [UIFont systemFontOfSize:18];
item.textViewPosition = MNTextViewPosition_Below;

// Create MNShowcaseView with MNShowcaseItem
MNShowcaseView *showcaseViwe = [[MNShowcaseView alloc] initWithShowcaseItem:item];
[showcaseViwe showOnMainWindow];
```
OR MNShowcaseView with multiple MNShowcaseItems
```Objective-C
// Create MNShowcaseView with multiple MNShowcaseItem
MNShowcaseView *showcaseViwe = [[MNShowcaseView alloc] initWithShowcaseItems:@[item1,item2,item3]];
[showcaseViwe showOnMainWindow];
```
## Delegate
To handle and get events about MNShowcaseView you can implement follwoing protocol. You can also customize an MNShowcaseItem when it is about to be shown in showView:willShowItem: delegate method.
```Objective-C
@protocol MNShowcaseViewDelegate <NSObject>
@optional
-(void)showcaseView:(MNShowcaseView*)showcaseView willShowItem:(MNShowcaseItem*)showcaseItem;
-(void)showcaseViewWillDismiss:(MNShowcaseView*)showcaseView;
-(void)showcaseView:(MNShowcaseView *)showcaseView isTappedAtPoint:(CGPoint)point isInsideSelectedArea:(BOOL)isInside;
@end
```

## Todo
1. Build category for UIView to present MNShowcaseView on long press on any view
2. Testing

## Author
Muhammad Nabeel Arif

## License

MNShowcaseView is available under the MIT license. See the LICENSE file for more info.
