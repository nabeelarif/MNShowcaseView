//
//  UIView+MNShowcase.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/13/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import "UIView+MNShowcase.h"
#import "MNShowcaseLongPressGestureRecognizer.h"
#import "MNShowcaseView.h"

@implementation UIView (MNShowcase)

-(void) registerForShowcaseView
{
    MNShowcaseLongPressGestureRecognizer *longPress = [[MNShowcaseLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionDisplayShowCase:)];
    [self addGestureRecognizer:longPress];
}
-(void)actionDisplayShowCase:(MNShowcaseLongPressGestureRecognizer*)sender
{
    if ([sender isKindOfClass:[MNShowcaseLongPressGestureRecognizer class]]) {
        
        if (sender.state == UIGestureRecognizerStateBegan)
        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Gestures" message:@"Long Gesture Detected" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alertView show];
            UIView *container = (UIView*)[UIApplication sharedApplication].keyWindow;
            CGRect frame = [container convertRect:self.frame fromView:self.superview];
            MNShowcaseView *overlayView = [[MNShowcaseView alloc] initWithFrame:container.bounds HoleRect:frame backgroundColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
            [container addSubview:overlayView];
        }
    }
}
@end
