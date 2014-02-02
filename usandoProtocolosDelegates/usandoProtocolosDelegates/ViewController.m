//
//  ViewController.m
//  usandoProtocolosDelegates
//
//  Created by Daniel Arndt Alves on 2/2/14.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Esconder o teclado
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"passou por aqui...");
    
    [textField resignFirstResponder];
    return TRUE;
}

// Filtrando a entrada
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"0"] ||
       [string isEqualToString:@"1"] ||
       [string isEqualToString:@"2"] ||
       [string isEqualToString:@"3"] ||
       [string isEqualToString:@"4"] ||
       [string isEqualToString:@"5"] ||
       [string isEqualToString:@"6"] ||
       [string isEqualToString:@"7"] ||
       [string isEqualToString:@"8"] ||
       [string isEqualToString:@"9"]){
        return TRUE;
    }
    return FALSE;
}

@end
