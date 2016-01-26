//
//  MNShowcaseView.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//
//http://stackoverflow.com/questions/9711248/cut-transparent-hole-in-uiview

#import "MNShowcaseView.h"
@interface MNShowcaseView()

@property (nonatomic,strong) UITapGestureRecognizer *gestureBackgroundTapped;
@end;

@implementation MNShowcaseView
-(instancetype)initWithFrame:(CGRect)frame HoleRect:(CGRect)hole backgroundColor:(UIColor*)bkgColor
{
    self = [super initWithFrame:frame];
    if (self) {
        _holeArea = hole;
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
    CGRect holeRect = _holeArea;
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
