//
//  MNShowcaseView.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import "MNShowcaseView.h"

@implementation MNShowcaseItem
-(instancetype)initWithView:(UIView*)view
{
    self = [super init];
    if (self) {
        _viewToFocus = view;
    }
    return self;
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
@property (nonatomic,strong) NSArray<UIView*> *arrayViews;
@property (nonatomic,strong) NSArray<MNShowcaseItem*> *arrayShowcaseItems;
//@property CGRect selectedRect;

@end;

@implementation MNShowcaseView
@synthesize button = _button;
@synthesize tvDescription = _tvDescription;
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
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
            if (title && [title isKindOfClass:[NSString class]] && title.length>0) {
                NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
                paragraphStyle.alignment                = NSTextAlignmentCenter;
                NSDictionary *attrib = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName:paragraphStyle};
                [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n\n",title] attributes:attrib]];
            }
            if (description && [description isKindOfClass:[NSString class]] && title.length>0) {
                
                NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
                paragraphStyle.alignment                = NSTextAlignmentCenter;
                NSDictionary *attrib = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle};
                [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:description attributes:attrib]];
            }
            MNShowcaseItem *item = [[MNShowcaseItem alloc] initWithView:view];
            item.textDescription = view.description;
            if (attributedString.length>0) {
                item.attributedDescription = attributedString;
            }
            [arrayShowcaseItems addObject:item];
        }
        [self setShowcaseItems:[NSArray arrayWithArray:arrayShowcaseItems]];
    }
}
-(void)setShowcaseItem:(MNShowcaseItem*)showcaseItem{
    [self setShowcaseItems:@[showcaseItem]];
}
-(void)setShowcaseItems:(NSArray<MNShowcaseItem *>*)showcaseItems{
    self.arrayShowcaseItems = showcaseItems;
}
#pragma mark - Overridden methods
//http://stackoverflow.com/questions/9711248/cut-transparent-hole-in-uiview
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
    _tvDescription = nil;
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMNShowcaseView:)];
    [self addGestureRecognizer:tap];
}
-(void)dismissMNShowcaseView:(UITapGestureRecognizer*)sender
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
    }
    return _button;
}
-(void)displayButton:(BOOL)displayButton
{
    _displayButton = displayButton;
    if (_displayButton  ) {
        if (self.button.superview==nil) {
            [self addSubview:self.button];
            UIButton *myBtn = self.button;
            [myBtn sizeToFit];
            if (_arrayButtonConstraints) {
                [self removeConstraints:_arrayButtonConstraints];
            }
            myBtn.translatesAutoresizingMaskIntoConstraints = NO;
            _arrayButtonConstraints = @[[NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:myBtn
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:-25.0],
                                        [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:myBtn
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:16.0]];
            [self addConstraints:_arrayButtonConstraints];
        }
    }else{
        [self.button removeFromSuperview];
    }
}
-(void)actionButtonClicked:(UIButton*)button{
    if (_currentIndexOfView==_arrayShowcaseItems.count-1) {
        [self removeFromSuperview];
    }else{
        _currentIndexOfView++;
        _currentShowcaseItem = [_arrayShowcaseItems objectAtIndex:_currentIndexOfView];
        [self displayShowCaseView];
    }
}
-(UITextView *)tvDescription{
    if (!_tvDescription) {
        _tvDescription = [[UITextView alloc] init];
        _tvDescription.textContainer.maximumNumberOfLines = 0;
        _tvDescription.scrollEnabled = NO;
        _tvDescription.userInteractionEnabled = NO;
        _tvDescription.textColor = [UIColor whiteColor];
        _tvDescription.textAlignment = NSTextAlignmentCenter;
        _tvDescription.font = [UIFont systemFontOfSize:14];
        _tvDescription.backgroundColor = [UIColor clearColor];
    }
    return _tvDescription;
}
-(void)displayTextView:(BOOL)display{
    if (display && (_currentShowcaseItem.textDescription || _currentShowcaseItem.attributedDescription)) {
        if (_currentShowcaseItem.attributedDescription) {
            self.tvDescription.attributedText = _currentShowcaseItem.attributedDescription;
        }else{
            self.tvDescription.text = _currentShowcaseItem.textDescription;
        }
        if (self.tvDescription.superview==nil) {
            [self addSubview:self.tvDescription];
            
            UIView *myView = self.tvDescription;
            myView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addConstraints:[NSLayoutConstraint
                                       constraintsWithVisualFormat:@"H:|-(20)-[myView]-(20)-|"
                                       options:NSLayoutFormatDirectionLeadingToTrailing
                                       metrics:nil
                                  views:NSDictionaryOfVariableBindings(myView)]];
        }
        MNTextViewPosition position = MNTextViewPosition_Automatic;
        if (_currentShowcaseItem.textViewPosition==MNTextViewPosition_Default) {
            if (_textViewPosition!=MNTextViewPosition_Default) {
                position = _textViewPosition;
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
        if (position==MNTextViewPosition_Above) {
            if (_arrayTextViewConstraints) {
                [self removeConstraints:_arrayTextViewConstraints];
            }
            _arrayTextViewConstraints = @[[NSLayoutConstraint constraintWithItem:self.tvDescription
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:CGRectGetMinY(_currentShowcaseItem.selectedRect)-8]];
            [self addConstraints:_arrayTextViewConstraints];
        }else if (position==MNTextViewPosition_Below) {
            if (_arrayTextViewConstraints) {
                [self removeConstraints:_arrayTextViewConstraints];
            }
            _arrayTextViewConstraints = @[[NSLayoutConstraint constraintWithItem:self.tvDescription
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:CGRectGetMaxY(_currentShowcaseItem.selectedRect)+8]];
            [self addConstraints:_arrayTextViewConstraints];
        }
        [self.tvDescription sizeToFit];
    }else{
        [self.tvDescription removeFromSuperview];
    }
}
-(void)displayShowCaseView
{
    if (_arrayShowcaseItems.count>0) {
        
        UIView *view = [_arrayShowcaseItems objectAtIndex:_currentIndexOfView].viewToFocus;
        _currentShowcaseItem.selectedRect = [_viewContainer convertRect:view.frame fromView:view.superview];
        if (_delegate && [_delegate respondsToSelector:@selector(showcaseView:willShowItem:)]) {
            [_delegate showcaseView:self willShowItem:_currentShowcaseItem];
        }
        if (_currentIndexOfView==_arrayShowcaseItems.count-1) {
            [self.button setTitle:@"Done" forState:UIControlStateNormal];
        }else{
            [self.button setTitle:@"Next" forState:UIControlStateNormal];
        }
        [self.button sizeToFit];
        if (!_viewContainer) {
            _viewContainer = (UIView*)[UIApplication sharedApplication].keyWindow;
        }
        [self displayTextView:YES];
        [self displayButton:_displayButton];
        [self setNeedsDisplay];
    }
}
-(void)showOnView:(UIView *)viewContainer{
    _viewContainer = viewContainer;
    if (!self.superview) {
        [self removeFromSuperview];
    }
    self.frame = _viewContainer.bounds;
    [_viewContainer addSubview:self];
    _isVisible = YES;
    [self displayShowCaseView];
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
#pragma mark - array viwes
-(void)setArrayViews:(NSArray<UIView *> *)arrayViews{
    if (arrayViews && arrayViews.count>0) {
        _arrayViews = arrayViews;
        NSMutableArray *tempArr = [NSMutableArray new];
        for (UIView *view in _arrayViews) {
            MNShowcaseItem *option = [[MNShowcaseItem alloc] initWithView:view];
            option.textDescription = view.description;
            [tempArr addObject:option];
        }
        _arrayShowcaseItems = [NSArray arrayWithArray:tempArr];
        _currentIndexOfView = 0;
        _currentShowcaseItem = [_arrayShowcaseItems objectAtIndex:_currentIndexOfView];
    }
}
-(void)setArrayShowcaseItems:(NSArray<MNShowcaseItem *> *)arrayShowcaseItems{
    _arrayShowcaseItems = arrayShowcaseItems;
    if (_arrayShowcaseItems && _arrayShowcaseItems.count) {
        _currentIndexOfView = 0;
        _currentShowcaseItem = [_arrayShowcaseItems objectAtIndex:_currentIndexOfView];
    }
}

@end
