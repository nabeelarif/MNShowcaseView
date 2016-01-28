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
    MNShowcaseItem *_currentShowcaseItem
;
}
@property (nonatomic,strong) UITapGestureRecognizer *gestureBackgroundTapped;
@property (nonatomic,strong) NSArray *arrayButtonConstraints;
@property (nonatomic,strong) NSArray *arrayTextViewConstraints;
@property CGRect selectedRect;

@end;

@implementation MNShowcaseView
@synthesize button = _button;
@synthesize tvDescription = _tvDescription;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _overlayBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame HoleRect:(CGRect)hole backgroundColor:(UIColor*)bkgColor
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedRect = hole;
        _overlayBackgroundColor = bkgColor;
        _tvDescription = [[UITextView alloc] init];
        [self addMNShowcaseTapGesture];
    }
    return self;
}
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
    CGRect holeRect = _selectedRect;
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
    return !CGRectContainsPoint(_selectedRect, point) || CGRectContainsPoint(_button.frame, point);
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
                                                                      constant:10.0]];
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
        self.tvDescription.backgroundColor = [UIColor yellowColor];
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
            CGFloat topMargin = CGRectGetMinY(_selectedRect);
            CGFloat bottomMargin = height - CGRectGetMaxY(_selectedRect);
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
                                                                        constant:CGRectGetMinY(_selectedRect)-8]];
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
                                                                        constant:CGRectGetMaxY(_selectedRect)+8]];
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
        if (_currentIndexOfView==_arrayShowcaseItems.count-1) {
            [self.button setTitle:@"Done" forState:UIControlStateNormal];
        }else{
            [self.button setTitle:@"Next" forState:UIControlStateNormal];
        }
        [self.button sizeToFit];
        UIView *view = [_arrayShowcaseItems objectAtIndex:_currentIndexOfView].viewToFocus;
        UIView *container = (UIView*)[UIApplication sharedApplication].keyWindow;
        _selectedRect = [container convertRect:view.frame fromView:view.superview];
        [self displayTextView:YES];
        [self displayButton:YES];
        [self setNeedsDisplay];
    }
}
-(void)addShowcaseView{
    if (!self.superview) {
        UIView *container = (UIView*)[UIApplication sharedApplication].keyWindow;
        self.frame = container.frame;
        [container addSubview:self];
        [self displayShowCaseView];
    }
}
-(void)removeShowcaseView{
    if (self.superview)
    {
        [self removeParentFrameObserver];
        [self removeFromSuperview];
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
#pragma mark - KVO
// Observe frame change
//http://stackoverflow.com/questions/4874288/use-key-value-observing-to-get-a-kvo-callback-on-a-uiviews-frame
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self removeParentFrameObserver];
}
-(void)didMoveToSuperview
{
    if (self.superview) {
        [self.superview addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
}
-(void)removeParentFrameObserver
{
    //Remove observer
    if (self.superview) {
        @try{
            [self.superview removeObserver:self forKeyPath:@"frame"];
        }@catch(id anException){
            //do nothing, obviously it wasn't attached because an exception was thrown
        }
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
            [self setNeedsDisplay];
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
    if (self.superview)
    {
        [self removeParentFrameObserver];
        [self removeFromSuperview];
    }
}
#pragma mark - dealloc
-(void)dealloc{
    _tvDescription = nil;
}

@end
