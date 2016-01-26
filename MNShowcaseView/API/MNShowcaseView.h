//
//  MNShowcaseView.h
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNShowcaseView : UIView
@property CGRect holeArea;
@property (nonatomic,retain) UIColor *overlayBackgroundColor;
@property (nonatomic, strong) UITextView *tvDescription;
-(instancetype)initWithFrame:(CGRect)frame HoleRect:(CGRect)hole backgroundColor:(UIColor*)bkgColor;

@end
