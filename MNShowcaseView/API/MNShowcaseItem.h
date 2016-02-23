//
//  MNShowcaseItem.h
//  MNShowcaseView
//
//  Created by Nabeel Arif on 2/23/16.
//  Copyright © 2016 Muhammad Nabeel Arif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 This enum indicates where to place the TextView relative to
 the view or selectedArea.
 */
typedef NS_ENUM(NSInteger, MNTextViewPosition){
    MNTextViewPosition_Default,
    MNTextViewPosition_Automatic,
    MNTextViewPosition_Above,
    MNTextViewPosition_Below
};
/**
 The button with text OK by default. You can set it's position using
 these enumerations.
 */
typedef NS_ENUM(NSInteger, MNButtonPosition){
    MNButtonPosition_Default,
    MNButtonPosition_TopLeft,
    MNButtonPosition_BottomLeft,
    MNButtonPosition_BottomRight,
    MNButtonPosition_TopRight
};
/**
 The selected area shape could be decided based on one of these values
 of enumerations.
 */
typedef NS_ENUM(NSInteger, MNSelectionType){
    MNSelection_Default,
    MNSelection_Rectangle,
    MNSelection_RectangleRow,
    MNSelection_CircleInside,
    MNSelection_EllipseInside,
    MNSelection_EllipseOutside
};

/**
 Specify what type of effect to show around Selected Area
 */
typedef NS_ENUM(NSInteger, MNSelectionEffect){
    MNSelectionEffect_Default,
    MNSelectionEffect_None,
    MNSelectionEffect_GlowBoundry
};
typedef NS_ENUM(NSInteger, MNBOOL) {
    MNBOOL_Default,
    MNBOOL_YES,
    MNBOOL_NO
};
/**
 The class represents an objects to be dsiplayed in showcase view. You can set multiple
 showcase items in ShowcaseView. And showcase view will iterate those items one by one.
 */
@interface MNShowcaseItem : NSObject
/**
 Initialize MNShowcaseItem
 @param view A view to be selected
 */
-(instancetype)initWithView:(UIView*)view;
/**
 Initialize MNShowcaseItem
 @param view A view to be selected
 @param title Title to be shown for the view
 @param description Description to be shown for the view
 */
-(instancetype)initWithViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description;
/**
 Setup MNShowcaseItem
 @param view A view to be selected
 @param title Title to be shown for the view
 @param description Description to be shown for the view
 */
-(void)setViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description;
/**
 A view to be shown as selected in MNShowcaseView. You can set this while initializing the
 MNShowcaseItem 'initWithView:' or 'initWithViewToFocus:title:description:'
 Or you can set it using 'setViewToFocus:title:description:'
 */
@property (nonatomic, weak, readonly) UIView *viewToFocus;
/**
 If YES, user will be able to interact with view under selected area. If NO, Views under selected area will not be responsive.
 */
@property (nonatomic) MNBOOL isInteractionEnabled;
/**
 Button position for current MNShowcaseItem. If user will not set 'buttonPosition'
 manually, 'MNShowcaseView.buttonPositionDefault'
 will be used to decide button position.
 buttonPosition is only useful if 'MNShowcaseView.shouldShowDefaultButton' is set to YES
 */
@property (nonatomic) MNButtonPosition buttonPosition;
/**
 TextView position for current MNShowcaseItem. If user will not set 'textViewPosition'
 manually, 'MNShowcaseView.textViewPositionDefault' will be used to decide position.
 */
@property (nonatomic) MNTextViewPosition textViewPosition;
/**
 Selection type for current MNShowcaseItem. If user will not set 'selectionType'
 manually, 'MNShowcaseView.selectionTypeDefault' will be used for selection type.
 */
@property (nonatomic) MNSelectionType selectionType;
/**
 Selection Effect for current MNShowcaseItem. If user will not set 'selectionEffect'
 manually, 'MNShowcaseView.selectionEffectDefault' will be used for selection type.
 */
@property (nonatomic) MNSelectionEffect selectionEffect;
/**
 Title of 'MNShowcaseView.button' for current MNSowcaseItem.
 */
@property (nonatomic,strong) NSString *buttonTitle;
/**
 Description for current MNShowcaseItem.
 */
@property (nonatomic,strong) NSAttributedString *attributedDescription;
/**
 Title for current MNShowcaseItem
 */
@property (nonatomic,strong) NSString *titleText;
/**
 Description for current MNShowcaseItem.
 */
@property (nonatomic,strong) NSString *descriptionText;
/**
 Font of title for current MNShowcaseItem.
 */
@property (nonatomic,strong) UIFont *titleFont;
/**
 Font of description for current MNShowcaseItem.
 */
@property (nonatomic,strong) UIFont *descriptionFont;
/**
 Color of title for current MNShowcaseItem.
 */
@property (nonatomic,strong) UIColor *titleColor;
/**
 Color of description for current MNShowcaseItem.
 */
@property (nonatomic,strong) UIColor *descriptionColor;
/**
 Color of selected area for current MNShowcaseItem.
 */
@property (nonatomic,strong) UIColor *selectedAreaFillColor;
/**
 Color to highlight selected area  for current MNShowcaseItem. This color
 will be only used if selectionEffect (of MNShowcaseItem) and
 selectionEffectDefault (of MNShowcaseView) is not set to MNSelectionEffect_None
 */
@property (nonatomic,strong) UIColor *highlightedColor;
/**
 Text alignment of title for current MNShowcaseItem.
 */
@property (nonatomic) NSTextAlignment titleTextAlignment;
/**
 Text alignment of description for current MNShowcaseItem.
 */
@property (nonatomic) NSTextAlignment descriptionTextAlignment;
/**
 Selected area for current MNShowcaseItem.
 */
@property (nonatomic) CGRect selectedRect;
@end
