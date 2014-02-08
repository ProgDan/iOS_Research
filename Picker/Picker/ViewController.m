//
//  ViewController.m
//  Picker
//
//  Created by Daniel Arndt Alves on 2/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *arrImagens;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgvImagem;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *img1 = @"foto1";
    NSString *img2 = @"foto2";
    NSString *img3 = @"foto3.jpg";
    arrImagens = [[NSArray alloc]initWithObjects:img1, img2, img3, nil];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return arrImagens.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [arrImagens objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *nome = [arrImagens objectAtIndex:row];
    UIImage *img = [UIImage imageNamed:nome];
    self.imgvImagem.image = img;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
