//
//  ViewController.m
//  ViewCoreGraphics
//
//  Created by Eduardo Lima on 11/30/13.
//  Copyright (c) 2013 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    Relogio *relogio = [[Relogio alloc] initWithFrame:CGRectMake(30, 30, 250, 250) andTimeDifference:0];
    relogio.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:relogio];
    
    
    Relogio *outroRelogio = [[Relogio alloc] initWithFrame:CGRectMake(30, 300, 250, 250) andTimeDifference:3];
    outroRelogio.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:outroRelogio];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
