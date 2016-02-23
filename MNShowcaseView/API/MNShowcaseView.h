//
//  MNShowcaseView.h
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNShowcaseItem.h"

@class MNShowcaseView;


/**
 It is a delegate associated with MNShowcaseView. By using these delegate, you can customize
 MNShowcaseItem at runtime.
 */
@protocol MNShowcaseViewDelegate <NSObject>
@optional
-(void)showcaseView:(MNShowcaseView*)showcaseView willShowItem:(MNShowcaseItem*)showcaseItem;
-(void)showcaseViewWillDismiss:(MNShowcaseView*)showcaseView;
-(void)showcaseViewDidDismiss:(MNShowcaseView*)showcaseView;
-(void)showcaseView:(MNShowcaseView *)showcaseView showItem:(MNShowcaseItem*)showcaseItem  isTappedAtPoint:(CGPoint)point isInsideSelectedArea:(BOOL)isInside;
/**
 Default button is clicked, 
 @return YES indicates button can carray on its task, i.e present next ShowcaseItem if there is 
 more or dismiss if there is no next item. NO indicates that button will not process its action further and will ignore click.
 */
-(BOOL)showcaseView:(MNShowcaseView *)showcaseView showItem:(MNShowcaseItem*)showcaseItem canContinueActionOnButton:(UIButton*)button;

@end
/**
 MNShowcaseView can highlight particular view of your app and describe about it as a guided tutorial.
 It can be used as guided tutorial in your app where you can tell new user's how they can use 
 different items in your app.
 */
@interface MNShowcaseView : UIView
// Initialization methods
/**
 Initialize MNShowcaseView
 @param view A view to be selected
 @param title Title to be shown for the view
 @param description Description to be shown for the view
 */
-(instancetype)initWithViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description;
/**
 Initialize MNShowcaseView
 @param views An array of view to be selected
 @param titles Titles to be shown for the views
 @param descriptions Descriptions to be shown for the views
 */
-(instancetype)initWithViewsToFocus:(NSArray<UIView*>*)views title:(NSArray<NSString*>*)titles description:(NSArray<NSString*>*)descriptions;
/**
 Initialize MNShowcaseView
 @param showcaseItem An MNShowcaseItem to be shown
 */
-(instancetype)initWithShowcaseItem:(MNShowcaseItem*)showcaseItem;
/**
 Initialize MNShowcaseView
 @param showcaseItems An array of MNShowcaseItem to be shown
 */
-(instancetype)initWithShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems;

//Set views or showcaseItems

// Initialization methods
/**
 Initialize MNShowcaseView
 @param view A view to be selected
 @param title Title to be shown for the view
 @param description Description to be shown for the view
 */
-(void)setViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description;
/**
 setup MNShowcaseView
 @param views An array of view to be selected
 @param titles Titles to be shown for the views
 @param descriptions Descriptions to be shown for the views
 */
-(void)setViewsToFocus:(NSArray<UIView*>*)views title:(NSArray<NSString*>*)titles description:(NSArray<NSString*>*)descriptions;
/**
 Setup MNShowcaseView
 @param showcaseItem An MNShowcaseItem to be shown
 */
-(void)setShowcaseItem:(MNShowcaseItem*)showcaseItem;
/**
 setup MNShowcaseView
 @param showcaseItems An array of MNShowcaseItem to be shown
 */
-(void)setShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems;

@property (nonatomic, weak) id<MNShowcaseViewDelegate> delegate;
/**
 Background color for MNShowcaseView
 */
@property (nonatomic,strong) UIColor *showcaseBackgroundColor;
/**
 A button on MNShowcaseView. You can use this butto to move to Next showcase item OR
 dismiss MNShowcaseView. You can hide or show this button using 'shouldShowDefaultButton' 
 property of MNShowcaseView.
 */
@property (nonatomic, strong, readonly) UIButton *button;
/**
 Container view which holds MNShowcaseView. You can set this while showing MNShowcaseView
 with method 'showOnView:'. If showing MNShowcaseView with method 'showOnMainWindow' 
 viwContainer will be set current main window automatically.
 */
@property (nonatomic,weak, readonly) UIView *viewContainer;
/**
 Show or Hide 'button' of MNShowcaseView by setting shouldShowDefaultButton.
 */
@property (nonatomic) BOOL shouldShowDefaultButton;
/**
 If YES, user will be able to interact with view under selected area. If NO, Views under selected area will not be responsive.
 */
@property (nonatomic) MNBOOL isInteractionEnabledDefault;
/**
 If YES, MNShowcaseView will be dismissed if it is tapped.
 */
@property (nonatomic) BOOL shouldDismissOnBackgroundClick;
/**
 Indicates the visibilityh of MNShowcaseView
 */
@property (nonatomic, readonly) BOOL isVisible;
/**
 Button title applicable to all MNShowcaseItems. This value will be used if
 MNShowcaseItem.buttonTitle is set to nil.
 'buttonTitleDefault' is only usefull if shouldShowDefaultButton is set to YES.
 If user do not set any value buttonTitleDefault=MNButtonPosition_TopRight
 */
@property (nonatomic,strong) NSString *buttonTitleDefault;
//Default attributes applicable on all showcase items
/**
.Button position applicable to all MNShowcaseItems. This value will be used if
 MNShowcaseItem.buttonPosition is set to Default.
 'buttonPositionDefault' is only usefull if shouldShowDefaultButton is set to YES.
 If user do not set any value buttonPositionDefault=MNButtonPosition_TopRight
 */
@property (nonatomic) MNButtonPosition buttonPositionDefault;
/**
 TextView position applicable to all MNShowcaseItems. This value will be used if
 MNShowcaseItem.textViewPosition is set to Default.
 If user do not set any value textViewPositionDefault=MNTextViewPosition_Automatic
 */
@property (nonatomic) MNTextViewPosition textViewPositionDefault;
/**
 Selection type applicable to all MNShowcaseItems. This value will be used if
 MNShowcaseItem.selectionType is set to Default.
 If user do not set any value selectionTypeDefault=MNSelection_Rectangle
 */
@property (nonatomic) MNSelectionType selectionTypeDefault;
/**
 Effect around selected area applicable to all MNShowcaseItems. This value will be used if
 MNShowcaseItem.selectionEffectDefault is set to Default.
 If user do not set any value selectionEffectDefault=MNSelectionEffect_GlowBoundry
 */
@property (nonatomic) MNSelectionEffect selectionEffectDefault;
/**
 Default font for title. It will be applicable if MNShowcaseItem do not have its 
 titleFont value set.
 */
@property (nonatomic,strong) UIFont *titleFontDefault;
/**
 Default font for description. It will be applicable if MNShowcaseItem do not have its
 descriptionFont value set.
 */
@property (nonatomic,strong) UIFont *descriptionFontDefault;
/**
 Default color for title. It will be applicable if MNShowcaseItem do not have its
 titleColor value set.
 */
@property (nonatomic,strong) UIColor *titleColorDefault;
/**
 Default color for description. It will be applicable if MNShowcaseItem do not have its
 descriptionColor value set.
 */
@property (nonatomic,strong) UIColor *descriptionColorDefault;
/**
 Default color to fill Selected Area. It will be applicable if MNShowcaseItem do not have its
 selectedAreaFillColor value set.
 */
@property (nonatomic,strong) UIColor *selectedAreaFillColorDefault;
/**
 Default color for highlightedColor. It will be applicable if MNShowcaseItem do not have its
 highlightedColor value set.
 */
@property (nonatomic,strong) UIColor *highlightedColorDefault;
/**
 Default text alignment for title. It will be applicable if MNShowcaseItem do not have its
 titleTextAlignment value set.
 */
@property (nonatomic) NSTextAlignment titleTextAlignmentDefault;
/**
 Default text alignment for description. It will be applicable if MNShowcaseItem do not have its
 descriptionTextAlignment value set.
 */
@property (nonatomic) NSTextAlignment descriptionTextAlignmentDefault;
// Show and hide methods
/**
 Show MNShowcaseView inside a particular view
 @param viewContainer A view on which MNShowcaseView will be displayed.
 */
-(void)showOnView:(UIView*)viewContainer;
/**
 Show MNShowcaseView inside a particular view
 @param viewContainer A view on which MNShowcaseView will be displayed.
 @param animated Show showcaseview with or without animation based on this boolean
 */
-(void)showOnView:(UIView *)viewContainer animated:(BOOL)animated;
/**
 Show MNShowcaseView inside main Window
 */
-(void)showOnMainWindow;
/**
 Dismiss current MNShowcaseView
 */
-(void)dismiss;
/**
 Dismiss current MNShowcaseView
 @param animated Hide showcaseview with or without animation based on this boolean
 */
-(void)dismissAnimated:(BOOL)animated;

@end
