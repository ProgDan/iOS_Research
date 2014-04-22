//
//  ViewController.m
//  Propaganda
//
//  Created by Eduardo Lima on 3/29/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    banner.hidden = NO;
    banner.alpha = 1.0;
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    NSLog(@"ERROR %@", error.localizedFailureReason);
    
    //banner.hidden = YES;
    
    banner.alpha = 0.0;
    
}

@end
