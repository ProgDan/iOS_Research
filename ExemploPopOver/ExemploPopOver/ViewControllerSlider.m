//
//  ViewControllerSlider.m
//  ExemploPopOver
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewControllerSlider.h"

@interface ViewControllerSlider ()

@property (weak, nonatomic) IBOutlet UISlider *sldRed;
@property (weak, nonatomic) IBOutlet UISlider *sldGreen;
@property (weak, nonatomic) IBOutlet UISlider *sldBlue;

- (IBAction)mexeuSlider:(id)sender;

@end

@implementation ViewControllerSlider

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

-(void)viewDidAppear:(BOOL)animated{
    NSArray *subViewSlider = self.sldBlue.subviews;
    NSLog(@"%d", subViewSlider.count);
    
    UIView *v = [subViewSlider objectAtIndex:2];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 15, 15)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"B";
    [v addSubview:lbl];
    
    subViewSlider = self.sldGreen.subviews;
    v = [subViewSlider objectAtIndex:2];
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 15, 15)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"G";
    [v addSubview:lbl];
    
    subViewSlider = self.sldRed.subviews;
    v = [subViewSlider objectAtIndex:2];
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 15, 15)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"R";
    [v addSubview:lbl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)mexeuSlider:(id)sender {
    // OCORREU UM EVENTO! Uma nova cor está sendo criada. Precisamos informar ao ViewController base a cor nova
    UIColor *cor = [[UIColor alloc]initWithRed:self.sldRed.value green:self.sldGreen.value blue:self.sldBlue.value alpha:1.0];
    
    [self.delegate acionaramSliderEACorMudouPara:cor];
}

@end
