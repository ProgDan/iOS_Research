//
//  TecladoViewController.m
//  TecladoCustomizado
//
//  Created by Eduardo Lima on 4/6/14.
//  Copyright (c) 2014 personal. All rights reserved.
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


- (IBAction)teclaPressionada:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            [self.delegate inserirTextoNoCampoTexto:@"A"];
            break;
            
        case 1:
            [self.delegate inserirTextoNoCampoTexto:@"E"];
            break;
            
        case 2:
            [self.delegate inserirTextoNoCampoTexto:@"I"];
            break;
            
        case 3:
            [self.delegate inserirTextoNoCampoTexto:@"O"];
            break;
            
        case 4:
            [self.delegate inserirTextoNoCampoTexto:@"U"];
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
    
}
@end
