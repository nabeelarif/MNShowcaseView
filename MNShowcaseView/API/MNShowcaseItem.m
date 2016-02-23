//
//  MNShowcaseItem.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 2/23/16.
//  Copyright © 2016 Muhammad Nabeel Arif. All rights reserved.
//

#import "MNShowcaseItem.h"

@implementation MNShowcaseItem
-(instancetype)initWithView:(UIView *)view
{
    return [self initWithViewToFocus:view title:nil description:nil];
}
-(instancetype)initWithViewToFocus:(UIView *)view title:(NSString *)title description:(NSString *)description{
    self = [super init];
    if (self) {
        [self setViewToFocus:view title:title description:description];
    }
    return self;
}
-(void)setViewToFocus:(UIView *)view title:(NSString *)title description:(NSString *)description{
    _viewToFocus = view;
    _titleText = title;
    _descriptionText = description;
    // Setting both alighnments by default to -1 so that if they are not manually set by
    // user, we will use default alignment options which are set for ShowcaseView.
    _titleTextAlignment = -1;
    _descriptionTextAlignment = -1;
    _selectionEffect = MNSelectionEffect_Default;
    
}
@end
