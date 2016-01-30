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
@property (weak, nonatomic) IBOutlet UITextField *tfTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnLarge;
@property (weak, nonatomic) IBOutlet UIView *viewView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scSegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *switchSwitch;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (nonatomic, strong) MNShowcaseView *showcaseView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnSave;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_btnLarge registerForShowcaseView];
    [_viewView registerForShowcaseView];
    [_btnLeft registerForShowcaseView];
    [_btnRight registerForShowcaseView];
    [_switchSwitch registerForShowcaseView];
    [_scSegmentedControl registerForShowcaseView];
    _showcaseView = [MNShowcaseView new];
    [_showcaseView setViewsToFocus:@[_btnLarge,_btnLeft,_btnRight] title:@[[NSNull null],@"Title", @"Title two"] description:@[@"One",[NSNull null], @"Two"]];
//    _showcaseView.selectionTypeDefault = MNSelection_FrameRowAroundView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_showcaseView showOnMainWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
