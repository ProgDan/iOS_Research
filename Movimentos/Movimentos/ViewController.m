//
//  ViewController.m
//  Movimentos
//
//  Created by Daniel Arndt Alves on 2/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgNave;
@property(strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.motionManager = [CMMotionManager new];
    self.motionManager.deviceMotionUpdateInterval = 0.001;
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue new] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        float newX = self.imgNave.center.x + motion.gravity.x*2.0f;
        float newY = self.imgNave.center.y - motion.gravity.y*2.0f;
        if ((newX <= self.imgNave.frame.size.width/2)||(newX >= self.view.bounds.size.width-(self.imgNave.frame.size.width/2))) {
            newX = self.imgNave.center.x;
        }
        if ((newY <= self.imgNave.frame.size.height/2)||(newY >= self.view.bounds.size.height-(self.imgNave.frame.size.height/2))) {
            newY = self.imgNave.center.y;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgNave.center = CGPointMake(newX, newY);
            
            if ([self.motionManager isGyroAvailable]) {
                self.imgNave.transform = CGAffineTransformMakeRotation(motion.attitude.roll);
            }
            
        });
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
