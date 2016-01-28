//
//  MNShowcaseView.h
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNShowcaseView;

typedef enum{
    MNTextViewPosition_Default,
    MNTextViewPosition_Automatic,
    MNTextViewPosition_Above,
    MNTextViewPosition_Below
}MNTextViewPosition;

typedef enum{
    MNButtonPosition_TopLeft,
    MNButtonPosition_BottomLeft,
    MNButtonPosition_BottomRight,
    MNButtonPosition_TopRight
}MNButtonPosition;

@interface MNShowcaseItem : NSObject
@property (nonatomic, weak, readonly) UIView *viewToFocus;
@property (nonatomic) MNButtonPosition buttonPosition;
@property (nonatomic) MNTextViewPosition textViewPosition;
@property (nonatomic,strong) NSString *textButtonTitle;
@property (nonatomic,strong) NSString *textDescription;
@property (nonatomic,strong) NSAttributedString *attributedDescription;
@end

@protocol MNShowcaseViewDelegate <NSObject>

-(void)showcaseView:(MNShowcaseView*)showcase willShowItem:(MNShowcaseItem*)showcaseItem;

@end

@interface MNShowcaseView : UIView
@property (nonatomic,retain) UIColor *overlayBackgroundColor;
@property (nonatomic,strong) NSArray<UIView*> *arrayViews;
@property (nonatomic,strong) NSArray<MNShowcaseItem*> *arrayShowcaseItems;
@property (nonatomic, strong, readonly) UITextView *tvDescription;
@property (nonatomic,setter=displayButton:) BOOL displayButton;
@property (nonatomic) MNButtonPosition buttonPosition;
@property (nonatomic) MNTextViewPosition textViewPosition;
-(void)addShowcaseView;
-(void)removeShowcaseView;
@property (nonatomic, strong, readonly) UIButton *button;
-(instancetype)initWithFrame:(CGRect)frame HoleRect:(CGRect)hole backgroundColor:(UIColor*)bkgColor;

@end
