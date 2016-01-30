//
//  MNShowcaseView.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import "MNShowcaseView.h"

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
    
}
@end

@interface MNShowcaseView()
{
    int _currentIndexOfView;
    MNShowcaseItem *_currentShowcaseItem;
}
@property (nonatomic,strong) UITapGestureRecognizer *gestureBackgroundTapped;
@property (nonatomic,strong) NSArray *arrayButtonConstraints;
@property (nonatomic,strong) NSArray *arrayTextViewConstraints;
//@property (nonatomic,strong) NSArray<UIView*> *arrayViews;
@property (nonatomic,strong) NSArray<MNShowcaseItem*> *showcaseItems;
@property (nonatomic, strong, readonly) UITextView *textViewDescription;
//@property CGRect selectedRect;

@end;

@implementation MNShowcaseView
@synthesize button = _button;
@synthesize textViewDescription = _textViewDescription;
@synthesize viewContainer = _viewContainer;
#pragma mark - Initialization Methods
-(instancetype)init{
    
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(instancetype)initWithViewToFocus:(UIView*)view title:(NSString*)title description:(NSString*)description{
    
    self = [super init];
    if (self) {
        [self setUp];
        [self setViewToFocus:view title:title description:description];
    }
    return self;
}
-(instancetype)initWithViewsToFocus:(NSArray<UIView*>*)views title:(NSArray<NSString*>*)titles description:(NSArray<NSString*>*)descriptions
{
    
    self = [super init];
    if (self) {
        [self setUp];
        [self setViewsToFocus:views title:titles description:descriptions];
    }
    return self;
}
-(instancetype)initWithShowcaseItem:(MNShowcaseItem*)showcaseItem{
    
    self = [super init];
    if (self) {
        [self setUp];
        [self setShowcaseItem:showcaseItem];
    }
    return self;
}
-(instancetype)initWithShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems{
    
    self = [super init];
    if (self) {
        [self setUp];
        [self setShowcaseItems:showcaseItems];
    }
    return self;
}
-(void)setUp{
    _overlayBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self addMNShowcaseTapGesture];
    _shouldShowDefaultButton = YES;
    _buttonPositionDefault = MNButtonPosition_TopRight;
    _textViewPositionDefault = MNTextViewPosition_Automatic;
    _selectionTypeDefault = MNSelection_RectangleAroundView;
    _titleFontDefault = [UIFont boldSystemFontOfSize:16];
    _descriptionFontDefault = [UIFont systemFontOfSize:14];
    _titleColorDefault = [UIColor whiteColor];
    _descriptionColorDefault = [UIColor whiteColor];
    _titleTextAlignmentDefault = NSTextAlignmentCenter;
    _descriptionTextAlignmentDefault = NSTextAlignmentCenter;
}
#pragma mark - Methods to set Views or ShowcaseItems

-(void)setViewToFocus:(UIView*)view
                title:(NSString*)title
          description:(NSString*)description{
    [self setViewsToFocus:@[view] title:@[title?title:[NSNull null]] description:@[description?description:[NSNull null]]];
}
-(void)setViewsToFocus:(NSArray<UIView*>*)views
                 title:(NSArray<NSString*>*)titles
           description:(NSArray<NSString*>*)descriptions{
    if (views && views.count>0) {
        NSMutableArray *arrayShowcaseItems = [NSMutableArray new];
        for (int i=0;i<views.count;i++) {
            UIView *view = [views objectAtIndex:i];
            NSString *title = (i<titles.count)?[titles objectAtIndex:i]:nil;
            NSString *description = (i<descriptions.count)?[descriptions objectAtIndex:i]:nil;
            MNShowcaseItem *item = [[MNShowcaseItem alloc] initWithViewToFocus:view title:title description:description];
            [arrayShowcaseItems addObject:item];
        }
        [self setShowcaseItems:[NSArray arrayWithArray:arrayShowcaseItems]];
    }
}
-(void)setShowcaseItem:(MNShowcaseItem*)showcaseItem{
    [self setShowcaseItems:@[showcaseItem]];
}
-(void)setShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems{
    _showcaseItems = showcaseItems;
    if (_showcaseItems && _showcaseItems.count>0) {
        _currentIndexOfView = 0;
        _currentShowcaseItem = [_showcaseItems objectAtIndex:_currentIndexOfView];
    }
}
#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!_overlayBackgroundColor) {
        _overlayBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.9];
    }
    [_overlayBackgroundColor setFill];
    UIRectFill(rect);
    
    //    for (NSValue *holeRectValue in rectsArray) {
    CGRect holeRect = _currentShowcaseItem.selectedRect;
    CGRect holeRectIntersection = CGRectIntersection( holeRect, rect );
    [[UIColor clearColor] setFill];
    UIRectFill(holeRectIntersection);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        if( CGRectIntersectsRect( holeRectIntersection, rect ) )
//        {
//            CGContextAddEllipseInRect(context, holeRectIntersection);
//            CGContextClip(context);
//            CGContextClearRect(context, holeRectIntersection);
//            CGContextSetFillColorWithColor( context, [UIColor clearColor].CGColor );
//            CGContextFillRect( context, holeRectIntersection);
//        }
//    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (_isSelectedAreaUserInteractionEnabled) {
        BOOL isInside = CGRectContainsPoint(_currentShowcaseItem.selectedRect, point) || CGRectContainsPoint(_button.frame, point);
        return isInside;
    }
    return [super pointInside:point withEvent:event];
}
-(void)dealloc{
    _textViewDescription = nil;
}
#pragma mark - KVO To observe frame change
// Observe frame change
//http://stackoverflow.com/questions/4874288/use-key-value-observing-to-get-a-kvo-callback-on-a-uiviews-frame
//-(void)willMoveToSuperview:(UIView *)newSuperview
//{
//    [self removeParentFrameObserver];
//}

-(void)didMoveToSuperview{
    if (self.superview) {
        [self.superview addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
}
-(void)removeParentFrameObserver{
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:@"frame"];
    }
}
// Change frame if super view's frame changes
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        CGRect oldFrame = CGRectNull;
        CGRect newFrame = CGRectNull;
        if([change objectForKey:@"old"] != [NSNull null]) {
            oldFrame = [[change objectForKey:@"old"] CGRectValue];
        }
        if([object valueForKeyPath:keyPath] != [NSNull null]) {
            newFrame = [[object valueForKeyPath:keyPath] CGRectValue];
            self.frame = newFrame;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self showOnView:_viewContainer];
            });
        }
    }
}
#pragma mark - tap Gesture Recognizer
-(void)addMNShowcaseTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showcaseViewTappedByGesture:)];
    [self addGestureRecognizer:tap];
}
-(void)showcaseViewTappedByGesture:(UITapGestureRecognizer*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(showcaseView:isTappedAtPoint:isInsideSelectedArea:)]) {
        CGPoint point = [sender locationInView:self];
        BOOL isInside = CGRectContainsPoint(_currentShowcaseItem.selectedRect, point);
        [_delegate showcaseView:self isTappedAtPoint:point isInsideSelectedArea:isInside];
    }
    if (_shouldDismissOnBackgroundClick) {
        [self dismiss];
    }
}
#pragma mark - button
-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_button addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.button setTitle:@"OK" forState:UIControlStateNormal];
    }
    return _button;
}
-(void)shouldShowDefaultButton:(BOOL)shouldShowDefaultButton
{
    _shouldShowDefaultButton = shouldShowDefaultButton;
    if (_shouldShowDefaultButton  ) {
        if (self.button.superview==nil) {
            [self addSubview:self.button];
            UIButton *myBtn = self.button;
            [myBtn sizeToFit];
            if (_arrayButtonConstraints) {
                [self removeConstraints:_arrayButtonConstraints];
            }
            myBtn.translatesAutoresizingMaskIntoConstraints = NO;
            
            MNButtonPosition position = MNButtonPosition_TopRight;
            if (_currentShowcaseItem.buttonPosition==MNButtonPosition_Default) {
                if (_buttonPositionDefault!=MNButtonPosition_Default) {
                    position = _buttonPositionDefault;
                }
            }else{
                position = _currentShowcaseItem.buttonPosition;
            }
            
            NSMutableArray *arrConstraints = [[NSMutableArray alloc] init];
            if (position==MNButtonPosition_TopRight || position==MNButtonPosition_TopLeft) {
                
                [arrConstraints addObject:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:myBtn
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.0
                                           constant:-25.0]];
            }
            if (position==MNButtonPosition_TopRight || position==MNButtonPosition_BottomRight) {
                
                [arrConstraints addObject:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeRight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:myBtn
                                           attribute:NSLayoutAttributeRight
                                           multiplier:1.0
                                           constant:16.0]];
            }
            if (position==MNButtonPosition_BottomLeft || position==MNButtonPosition_TopLeft) {
                
                [arrConstraints addObject:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:myBtn
                                           attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                           constant:16.0]];
            }
            if (position==MNButtonPosition_BottomRight || position==MNButtonPosition_BottomLeft) {
                
                [arrConstraints addObject:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:myBtn
                                           attribute:NSLayoutAttributeBottom
                                           multiplier:1.0
                                           constant:16.0]];
            }
            _arrayButtonConstraints = [NSArray arrayWithArray:arrConstraints];
            [self addConstraints:_arrayButtonConstraints];
        }
    }else{
        [self.button removeFromSuperview];
    }
}
-(void)actionButtonClicked:(UIButton*)button{
    if (_currentIndexOfView==_showcaseItems.count-1) {
        [self removeFromSuperview];
    }else{
        _currentIndexOfView++;
        _currentShowcaseItem = [_showcaseItems objectAtIndex:_currentIndexOfView];
        [self displayShowCaseView];
    }
}
-(UITextView *)textViewDescription{
    if (!_textViewDescription) {
        _textViewDescription = [[UITextView alloc] init];
        _textViewDescription.textContainer.maximumNumberOfLines = 0;
        _textViewDescription.scrollEnabled = NO;
        _textViewDescription.userInteractionEnabled = NO;
        _textViewDescription.textColor = [UIColor whiteColor];
        _textViewDescription.textAlignment = NSTextAlignmentCenter;
        _textViewDescription.font = [UIFont systemFontOfSize:14];
        _textViewDescription.backgroundColor = [UIColor clearColor];
    }
    return _textViewDescription;
}
-(void)setupTextView:(BOOL)display{
    if (display && ([self generateAttributedString] || _currentShowcaseItem.attributedDescription)) {
        if (_currentShowcaseItem.attributedDescription) {
            self.textViewDescription.attributedText = _currentShowcaseItem.attributedDescription;
        }else{
            self.textViewDescription.attributedText = [self generateAttributedString];
        }
        if (self.textViewDescription.superview==nil) {
            [self addSubview:self.textViewDescription];
            
            UIView *myView = self.textViewDescription;
            myView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"H:|-(20)-[myView]-(20)-|"
                                       options:NSLayoutFormatDirectionLeadingToTrailing
                                       metrics:nil
                                  views:NSDictionaryOfVariableBindings(myView)]];
        }
        MNTextViewPosition position = MNTextViewPosition_Automatic;
        if (_currentShowcaseItem.textViewPosition==MNTextViewPosition_Default) {
            if (_textViewPositionDefault!=MNTextViewPosition_Default) {
                position = _textViewPositionDefault;
            }
        }else{
            position = _currentShowcaseItem.textViewPosition;
        }
        if (position==MNTextViewPosition_Automatic) {
            CGFloat height =  self.frame.size.height;
            CGFloat topMargin = CGRectGetMinY(_currentShowcaseItem.selectedRect);
            CGFloat bottomMargin = height - CGRectGetMaxY(_currentShowcaseItem.selectedRect);
            if (topMargin>bottomMargin) {
                 position = MNTextViewPosition_Above;
            }else{
                 position = MNTextViewPosition_Below;
            }
        }
        
        if (_arrayTextViewConstraints) {
            [self removeConstraints:_arrayTextViewConstraints];
        }
        if (position==MNTextViewPosition_Above) {
            _arrayTextViewConstraints = @[[NSLayoutConstraint
                                           constraintWithItem:self.textViewDescription
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.0
                                           constant:CGRectGetMinY(_currentShowcaseItem.selectedRect)-8]];
        }else if (position==MNTextViewPosition_Below) {
            _arrayTextViewConstraints = @[[NSLayoutConstraint
                                           constraintWithItem:self.textViewDescription
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                           attribute:NSLayoutAttributeTop
                                           multiplier:1.0
                                           constant:CGRectGetMaxY(_currentShowcaseItem.selectedRect)+8]];
        }
        [self addConstraints:_arrayTextViewConstraints];
        [self.textViewDescription sizeToFit];
    }else{
        [self.textViewDescription removeFromSuperview];
    }
}
-(void)displayShowCaseView
{
    if (_showcaseItems.count>0) {
        
        UIView *view = [_showcaseItems objectAtIndex:_currentIndexOfView].viewToFocus;
        
        // Get the applicable selection type
        MNSelectionType selectionType = MNSelection_RectangleAroundView;
        if (_currentShowcaseItem.selectionType==MNSelection_Default) {
            if (_selectionTypeDefault!=MNSelection_Default) {
                selectionType = _selectionTypeDefault;
            }
        }else{
            selectionType = _currentShowcaseItem.selectionType;
        }
        if (selectionType==MNSelection_RectangleAroundView) {
            _currentShowcaseItem.selectedRect = [_viewContainer convertRect:view.frame fromView:view.superview];

        }else if(selectionType==MNSelection_RectangleRowAroundView){
            CGRect selectionRect = [_viewContainer convertRect:view.frame fromView:view.superview];
            selectionRect.origin.x = 0;
            selectionRect.size.width = self.frame.size.width;
            _currentShowcaseItem.selectedRect = selectionRect;
        }
        if (_delegate && [_delegate respondsToSelector:@selector(showcaseView:willShowItem:)]) {
            [_delegate showcaseView:self willShowItem:_currentShowcaseItem];
        }
        [self.button sizeToFit];
        if (!_viewContainer) {
            _viewContainer = (UIView*)[UIApplication sharedApplication].keyWindow;
        }
        [self setupTextView:YES];
        [self shouldShowDefaultButton:_shouldShowDefaultButton];
        [self setNeedsDisplay];
    }
}
-(void)showOnView:(UIView *)viewContainer{
    if (_currentShowcaseItem) {
        
        _viewContainer = viewContainer;
        if (!self.superview) {
            [self removeFromSuperview];
        }
        self.frame = _viewContainer.bounds;
        [_viewContainer addSubview:self];
        _isVisible = YES;
        [self displayShowCaseView];
    }else{
        NSLog(@"No MNShowcaseItem set to display view around it.");
    }
}
-(void)showOnMainWindow{
    UIView *container = (UIView*)[UIApplication sharedApplication].keyWindow;
    [self showOnView:container];
}
-(void)dismiss{
    if (self.superview)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(showcaseViewWillDismiss:)]) {
            [_delegate showcaseViewWillDismiss:self];
        }
        [self removeParentFrameObserver];
        [self removeFromSuperview];
        _isVisible = NO;
    }
}
#pragma mark - Utility methods

-(NSAttributedString*)generateAttributedString
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    if (_currentShowcaseItem.titleText && [_currentShowcaseItem.titleText isKindOfClass:[NSString class]] && _currentShowcaseItem.titleText.length>0) {
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment                = _currentShowcaseItem.titleTextAlignment>=0?_currentShowcaseItem.titleTextAlignment:_titleTextAlignmentDefault;
        NSDictionary *attrib = @{NSFontAttributeName : _currentShowcaseItem.titleFont?_currentShowcaseItem.titleFont:_titleFontDefault,
                                 NSForegroundColorAttributeName : _currentShowcaseItem.titleColor?_currentShowcaseItem.titleColor:_titleColorDefault,
                                 NSParagraphStyleAttributeName:paragraphStyle};
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n",_currentShowcaseItem.titleText] attributes:attrib]];
    }
    if (_currentShowcaseItem.descriptionText && [_currentShowcaseItem.descriptionText isKindOfClass:[NSString class]] && _currentShowcaseItem.descriptionText.length>0) {
        
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment                = _currentShowcaseItem.descriptionTextAlignment>=0?_currentShowcaseItem.descriptionTextAlignment:_descriptionTextAlignmentDefault;
        NSDictionary *attrib = @{NSFontAttributeName : _currentShowcaseItem.descriptionFont?_currentShowcaseItem.descriptionFont:_descriptionFontDefault,
                                 NSForegroundColorAttributeName : _currentShowcaseItem.descriptionColor?_currentShowcaseItem.descriptionColor:_descriptionColorDefault,
                                 NSParagraphStyleAttributeName:paragraphStyle};
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:_currentShowcaseItem.descriptionText attributes:attrib]];
    }
    if(attributedString.length>0){
        return attributedString;
    }
    return nil;
}
@end
