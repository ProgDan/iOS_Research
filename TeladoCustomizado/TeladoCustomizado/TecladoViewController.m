//
//  TecladoViewController.m
//  TeladoCustomizado
//
//  Created by Daniel Arndt Alves on 4/6/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "TecladoViewController.h"

@interface TecladoViewController ()

- (IBAction)teclaPressionada:(UIButton *)sender;

@end

@implementation TecladoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)teclaPressionada:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            NSLog(@"A");
            break;
        case 1:
            NSLog(@"E");
            break;
        case 2:
            NSLog(@"I");
            break;
        case 3:
            NSLog(@"O");
            break;
        case 4:
            NSLog(@"U");
            break;
            
        default:
            break;
    }
    
}
@end
