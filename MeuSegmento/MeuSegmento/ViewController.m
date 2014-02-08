//
//  ViewController.m
//  MeuSegmento
//
//  Created by Daniel Arndt Alves on 2/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)mudaImagem:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            UIImage *imgGS = [UIImage imageNamed:@"bmw_R1200GS"];
            self.myImageView.image = imgGS;
        }
            break;
        case 1:
            self.myImageView.image = [UIImage imageNamed:@"bmw_R1200GS2"];
            break;
        case 2:
            self.myImageView.image = [UIImage imageNamed:@"bmw_G650GS.jpg"];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
