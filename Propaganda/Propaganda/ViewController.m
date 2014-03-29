//
//  ViewController.m
//  Propaganda
//
//  Created by Daniel Arndt Alves on 3/29/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
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

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    banner.hidden = NO;
    banner.alpha = 1.0;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    banner.hidden = YES;
    banner.alpha = 0.0;
}

@end
