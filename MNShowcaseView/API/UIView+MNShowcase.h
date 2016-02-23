//
//  UIView+MNShowcase.h
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/13/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNShowcaseItem.h"

typedef void (^CongigureShowcaseItem)(MNShowcaseItem* showcaseItem);
/**
 This category makes it easy for you to register a UIView for MNShowcaseView.
 By registering a view for MNShowcaseView, it will show MNShowcaseView on long press.
 */
@interface UIView (MNShowcase)
/**
 Registers a view for MNShowcaseView. As no configurations are specified so when long pressed
 on view, it will just focus on the view and gray out the surrounding.
 */
-(void) registerForShowcaseView;
/**
 Registers a view for MNShowcaseView.
 @param tag This tag will be set with for MNShowcaseView which will be presented on long press, 
 so that you can distinguish between ShowcaseView's of different Views.
 */
-(void) registerForShowcaseViewWithTag:(NSInteger)tag;
/**
 Registers a view for MNShowcaseView.
 @param tag This tag will be set with for MNShowcaseView which will be presented on long press,
 so that you can distinguish between ShowcaseView's of different Views.
 @param block A block to allow you to provide further details for MNShowcaseItem.
 */
-(void) registerForShowcaseViewWithTag:(NSInteger)tag congigureShowcaseItem:(CongigureShowcaseItem) block;
/**
 Registers a view for MNShowcaseView.
 @param tag This tag will be set with for MNShowcaseView which will be presented on long press,
 so that you can distinguish between ShowcaseView's of different Views.
 @param title Title for current view on MNShowcaseView
 @param description Description text for current view on MNShowcaseView
 */
-(void) registerForShowcaseViewWithTag:(NSInteger)tag title:(NSString*)title description:(NSString*)description;
/**
 Registers a view for MNShowcaseView.
 @param tag This tag will be set with for MNShowcaseView which will be presented on long press,
 so that you can distinguish between ShowcaseView's of different Views.
 @param title Title for current view on MNShowcaseView
 @param description Description text for current view on MNShowcaseView
 @param block A block to allow you to provide further details for MNShowcaseItem.
 */
-(void) registerForShowcaseViewWithTag:(NSInteger)tag title:(NSString*)title description:(NSString*)description congigureShowcaseItem:(CongigureShowcaseItem) block;
/**
 Unregister current view for MNShowcaseView.
 */
-(void) unRegisterForShowcaseView;
/**
 Determine whether current view is registered for MNShowcaseView or not
 @return YES if view is registered otherwise NO
 */
-(BOOL) isRegisteredForShowcaseView;
/**
 @return MNShowcaseItem for current view. If current view is not registered for MNShowcaseView,
 this method will return nil.
 */
-(MNShowcaseItem*)showcaseItem;
/**
 Tag for MNShowcaseview
 */
-(NSInteger) showcaseViewTag;
/**
 Set Tag for MNShowcaseView
 */
-(void) setShowcaseViewTag:(NSInteger)tag;
  
@end
