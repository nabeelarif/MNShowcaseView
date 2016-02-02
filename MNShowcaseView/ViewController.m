//
//  ViewController.m
//  MNShowcaseView
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import "ViewController.h"
#import "MNShowcaseView.h"
#import "UIView+MNShowcase.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (nonatomic, strong) MNShowcaseView *showcaseView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonBottomRight;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonRefresh;
@property (weak, nonatomic) IBOutlet UIView *myView;
- (IBAction)actionRefresh:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _showcaseView = [MNShowcaseView new];
    _showcaseView.highlightedColorDefault = [UIColor redColor];
    _showcaseView.selectionTypeDefault = MNSelection_Rectangle;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [_showcaseView setViewsToFocus:@[_buttonLeft,_switchView,_slider,_imageView,_myView,_viewBottom,_textField,_buttonBottomRight] title:nil description:nil];
    [self setUpShowcaseView];
    [_showcaseView showOnMainWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpShowcaseView
{
    NSMutableArray<MNShowcaseItem*> *arrItems = [NSMutableArray new];
    // About left button
    MNShowcaseItem *item = [[MNShowcaseItem alloc] initWithViewToFocus:_buttonLeft title:@"UIButton" description:@"The button is selected square with highlighted color set to Green. Title of button is NEXT and is placed on Top Right position."];
    item.highlightedColor = [UIColor greenColor];
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_TopRight;
    [arrItems addObject:item];
    // Switch
    item = [[MNShowcaseItem alloc] initWithViewToFocus:_switchView title:@"UISwitch" description:@"Selection area of Switch is Ellipse outside. Selected area's interaction is Enabled i.e you can click on Switch to change its state. Highlighted color is white. Button NEXT is now placed Top Left."];
    item.highlightedColor = [UIColor whiteColor];
    item.selectionType = MNSelection_EllipseOutside;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_TopLeft;
    item.isInteractionEnabled = MNBOOL_YES;
    [arrItems addObject:item];
    // UISlider
    item = [[MNShowcaseItem alloc] initWithViewToFocus:_slider title:@"UISlider" description:@"Selection area type is set to Rectangle. Highlighted color is now set to Blue. Selection area's interaction is enabled i.e you can change slider's value. Button's title is NEXT and is placed Bottom Left."];
    item.highlightedColor = [UIColor blueColor];
    item.selectionType = MNSelection_Rectangle;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_BottomLeft;
    item.isInteractionEnabled = MNBOOL_YES;
    [arrItems addObject:item];
    
    // UIImageView
    item = [[MNShowcaseItem alloc] initWithViewToFocus:_imageView title:@"UIImageView" description:@"Selection area type is Ellipse outside. Highlighted color is white. Button's title is NEXT and is placed on Bottom Right."];
    item.highlightedColor = [UIColor whiteColor];
    item.selectionType = MNSelection_EllipseOutside;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_BottomRight;
    [arrItems addObject:item];
    
    // UIView
    item = [[MNShowcaseItem alloc] initWithViewToFocus:_myView title:@"UIView" description:@"Selection type is set to Ellipse inside, so it will draw an ellipse inside the view. As view is square so ellipse is a circle. Highlighted color is set to Green. Font and color of Title and description are set this time."];
    item.highlightedColor = [UIColor greenColor];
    item.selectionType = MNSelection_EllipseInside;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_TopRight;
    item.titleColor = [UIColor greenColor];
    item.titleFont = [UIFont boldSystemFontOfSize:22];
    item.descriptionColor = [UIColor yellowColor];
    item.descriptionFont = [UIFont systemFontOfSize:18];
    [arrItems addObject:item];
    
    // UIView container of UITextField & UIButton
    item = [[MNShowcaseItem alloc] initWithViewToFocus:_viewBottom title:@"UIView container of UITextField & UIButton" description:@"Rectangular Selection on Container of UITextField and UIButton with orange highlighted color."];
    item.highlightedColor = [UIColor orangeColor];
    item.selectionType = MNSelection_Rectangle;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_TopRight;
    [arrItems addObject:item];
    
    // UITextField
    item = [[MNShowcaseItem alloc] initWithViewToFocus:_textField title:@"UITextField" description:@"Rectangel selection area around Text Field. You can't interact with it because it is disabed, you can set interaction enabled by setting .isInteractionEnabled=MNBOOL_YES."];
    item.highlightedColor = [UIColor whiteColor];
    item.selectionType = MNSelection_Rectangle;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_TopRight;
    [arrItems addObject:item];
    
    // UIButton
    item = [[MNShowcaseItem alloc] initWithView:_buttonBottomRight];
    item.attributedDescription = [self getAttributedString];
    item.highlightedColor = [UIColor whiteColor];
    item.selectionType = MNSelection_EllipseOutside;
    item.buttonTitle = @"NEXT";
    item.buttonPosition = MNButtonPosition_TopRight;
    [arrItems addObject:item];
    
    // UIBarButtonItem
    item = [[MNShowcaseItem alloc] initWithViewToFocus:[_barButtonRefresh valueForKey:@"view"] title:@"UIBarButtonItem" description:@"Ellipse outside selection on UIBarButtonItem. You can't interact with this button as interaction is set to NO. By clicking this button you will be able to restart this guided tutorial again. This time button title is set to DONE. As this is Last item so Done will simply dismiss the showcaseView."];
    item.highlightedColor = [UIColor whiteColor];
    item.selectionType = MNSelection_EllipseOutside;
    item.buttonTitle = @"DONE";
    item.buttonPosition = MNButtonPosition_TopLeft;
    [arrItems addObject:item];

    
    
    [_showcaseView setShowcaseItems:arrItems];
    // Set button background
    _showcaseView.button.backgroundColor = [UIColor orangeColor];
}
-(NSAttributedString*)getAttributedString{
    NSDictionary *bigWhiteAttrib = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Italic" size:30], NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSDictionary *italicAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Italic" size:16], NSForegroundColorAttributeName : [UIColor yellowColor]};
    
    NSDictionary *defaultAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:16], NSForegroundColorAttributeName : [UIColor colorWithWhite:0.5f alpha:1.0f]};
    
    NSDictionary *bigBoldAttribs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:27], NSForegroundColorAttributeName : [UIColor greenColor]};
    
    NSDictionary *italicBlueAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Italic" size:16], NSForegroundColorAttributeName : [UIColor blueColor]};
    
    NSDictionary *redAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Italic" size:13], NSForegroundColorAttributeName : [UIColor redColor]};
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Title attributed string\n" attributes:bigWhiteAttrib]];
    
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Italic Attributed String" attributes:italicAttrs]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Text in normal shape " attributes:defaultAttrs]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Big Bold & Green" attributes:bigBoldAttribs]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Italic Blue" attributes:italicBlueAttrs]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Small Red Text" attributes:redAttrs]];
    return attributedString;
}
- (IBAction)actionRefresh:(id)sender {
    [self setUpShowcaseView];
    [_showcaseView showOnMainWindow];
}
@end
