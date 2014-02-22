//
//  ViewController.m
//  Bussola
//
//  Created by Daniel Arndt Alves on 2/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bussola;
@property (strong, nonatomic) CLLocationManager *locManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locManager = [CLLocationManager new];
    self.locManager.delegate = self;
    
    // usa como referência o polo norte magnético da Terra
    [self.locManager startUpdatingHeading];
    
    // para usar o polo norte geográfico é preciso também usar o serviço de localização
    [self.locManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    double rotacao = newHeading.trueHeading;
    
    self.bussola.transform = CGAffineTransformMakeRotation(rotacao * (M_PI/180)*-1);
    
//    NSLog(@"angulo: %f", rotacao);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
