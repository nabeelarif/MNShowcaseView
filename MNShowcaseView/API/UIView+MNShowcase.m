//
//  UIView+MNShowcase.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/13/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import "UIView+MNShowcase.h"
#import "MNShowcaseView.h"
#import <objc/runtime.h>

NSString const *kShowcaseItem = @"kShowcaseItem";
NSString const *kTagShowcaseView = @"kTagShowcaseView";
NSString const *kMNLongPressGesture  = @"kMNLongPressGesture";


@interface MNShowcaseLongPressGestureRecognizer : UILongPressGestureRecognizer
@end

@implementation MNShowcaseLongPressGestureRecognizer
@end

@interface UIView (Internal)

-(MNShowcaseLongPressGestureRecognizer*)mnLongpressGesture;
-(void)setMNLongPressGesture:(MNShowcaseLongPressGestureRecognizer*)mnLongpressGesture;

@end
@implementation UIView (MNShowcase)


-(void) registerForShowcaseView
{
    [self registerForShowcaseViewWithTag:0 title:nil description:nil congigureShowcaseItem:nil];
}
-(void) registerForShowcaseViewWithTag:(NSInteger)tag
{
    [self registerForShowcaseViewWithTag:tag title:nil description:nil congigureShowcaseItem:nil];
}
-(void) registerForShowcaseViewWithTag:(NSInteger)tag congigureShowcaseItem:(CongigureShowcaseItem) block
{
    [self registerForShowcaseViewWithTag:tag title:nil description:nil congigureShowcaseItem:block];
}
-(void) registerForShowcaseViewWithTag:(NSInteger)tag title:(NSString*)title description:(NSString*)description
{
    [self registerForShowcaseViewWithTag:tag title:title description:description congigureShowcaseItem:nil];
}
-(void) registerForShowcaseViewWithTag:(NSInteger)tag title:(NSString*)title description:(NSString*)description congigureShowcaseItem:(CongigureShowcaseItem) block;
{
    //Set the tag, this tag will be associated with MNShowcaseView when presented on long press
    [self setShowcaseViewTag:tag];
    
    // Set ShowcaseView item for this View
    MNShowcaseItem *item = [self showcaseItem];
    if (!item) {
        item = [[MNShowcaseItem alloc] initWithViewToFocus:self title:title description:description];
    }else{
        item.titleText = title;
        item.descriptionText = description;
    }
    [self setShowcaseItem:item];
    
    //Determine if long press listener is already registered? If not register one.
    MNShowcaseLongPressGestureRecognizer *longPress = [self mnLongpressGesture];
    if (!longPress) {
        //Register for long press listener, we will show MNShowcaseView on long press
        longPress = [[MNShowcaseLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionDisplayShowCase:)];
        [self addGestureRecognizer:longPress];
        [self setMNLongPressGesture:longPress];
    }
    
    //Call the block so that user can further configure the ShowcaseItem
    if (block) {
        block(item);
    }
}
-(void)unRegisterForShowcaseView
{
    if ([self isRegisteredForShowcaseView]) {
        MNShowcaseLongPressGestureRecognizer *longPress = [self mnLongpressGesture];
        [self removeGestureRecognizer:longPress];
        [self setMNLongPressGesture:nil];
        [self setShowcaseItem:nil];
        [self setShowcaseViewTag:0];
    }
}
-(BOOL)isRegisteredForShowcaseView{
    if ([self mnLongpressGesture]) {
        return YES;
    }else{
        return NO;
    }
}
-(void)actionDisplayShowCase:(MNShowcaseLongPressGestureRecognizer*)sender
{
    if ([sender isKindOfClass:[MNShowcaseLongPressGestureRecognizer class]]) {
        
        if (sender.state == UIGestureRecognizerStateBegan)
        {
            MNShowcaseItem *item = [self showcaseItem];
            MNShowcaseView *showcaseView = [[MNShowcaseView alloc] initWithShowcaseItem:item];
            showcaseView.shouldDismissOnBackgroundClick = YES;
            showcaseView.shouldShowDefaultButton = NO;
            showcaseView.tag = [self showcaseViewTag];
            [showcaseView showOnMainWindow];
        }
    }
}

-(MNShowcaseItem*)showcaseItem
{
    MNShowcaseItem *item = objc_getAssociatedObject(self, &kShowcaseItem);
    return item;
}
-(void) setShowcaseItem:(MNShowcaseItem*)showcaseItem
{
    objc_setAssociatedObject(self, &kShowcaseItem, showcaseItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger) showcaseViewTag{
    NSNumber *number = objc_getAssociatedObject(self, &kTagShowcaseView);
    return number.integerValue;
}
-(void) setShowcaseViewTag:(NSInteger)tag{
    NSNumber *number = [NSNumber numberWithUnsignedInteger:tag];
    objc_setAssociatedObject(self, &kTagShowcaseView, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MNShowcaseLongPressGestureRecognizer*)mnLongpressGesture{
    MNShowcaseLongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kMNLongPressGesture);
    return gesture;
}
-(void)setMNLongPressGesture:(MNShowcaseLongPressGestureRecognizer*)mnLongpressGesture{
    objc_setAssociatedObject(self, &kMNLongPressGesture, mnLongpressGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
