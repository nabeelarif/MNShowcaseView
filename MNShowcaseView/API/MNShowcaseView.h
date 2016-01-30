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
-(instancetype)initWithView:(UIView*)view;
@property (nonatomic, weak, readonly) UIView *viewToFocus;
@property (nonatomic) MNButtonPosition buttonPosition;
@property (nonatomic) MNTextViewPosition textViewPosition;
@property (nonatomic,strong) NSString *textButtonTitle;
@property (nonatomic,strong) NSString *textDescription;
@property (nonatomic,strong) NSAttributedString *attributedDescription;
@property (nonatomic) CGRect selectedRect;
@end

@protocol MNShowcaseViewDelegate <NSObject>
@optional
-(void)showcaseView:(MNShowcaseView*)showcaseView willShowItem:(MNShowcaseItem*)showcaseItem;
-(void)showcaseViewWillDismiss:(MNShowcaseView*)showcaseView;
-(void)showcaseView:(MNShowcaseView *)showcaseView isTappedAtPoint:(CGPoint)point isInsideSelectedArea:(BOOL)isInside;

@end

@interface MNShowcaseView : UIView
// Initialization methods
-(instancetype)initWithViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description;
-(instancetype)initWithViewsToFocus:(NSArray<UIView*>*)views title:(NSArray<NSString*>*)titles description:(NSArray<NSString*>*)descriptions;
-(instancetype)initWithShowcaseItem:(MNShowcaseItem*)showcaseItem;
-(instancetype)initWithShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems;

//Set views or showcaseItems

-(void)setViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description;
-(void)setViewsToFocus:(NSArray<UIView*>*)views title:(NSArray<NSString*>*)titles description:(NSArray<NSString*>*)descriptions;
-(void)setShowcaseItem:(MNShowcaseItem*)showcaseItem;
-(void)setShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems;

@property (nonatomic, weak) id<MNShowcaseViewDelegate> delegate;
@property (nonatomic,retain) UIColor *overlayBackgroundColor;
@property (nonatomic, strong, readonly) UITextView *tvDescription;
@property (nonatomic,setter=displayButton:) BOOL displayButton;
@property (nonatomic) BOOL isSelectedAreaUserInteractionEnabled;
@property (nonatomic) BOOL shouldDismissOnBackgroundClick;
@property (nonatomic, readonly) BOOL isVisible;
@property (nonatomic) MNButtonPosition buttonPosition;
@property (nonatomic) MNTextViewPosition textViewPosition;
@property (nonatomic,weak, readonly) UIView *viewContainer;
-(void)showOnView:(UIView*)viewContainer;
-(void)showOnMainWindow;
-(void)dismiss;
@property (nonatomic, strong, readonly) UIButton *button;

@end
