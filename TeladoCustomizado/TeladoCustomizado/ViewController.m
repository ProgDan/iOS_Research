//
//  ViewController.m
//  TeladoCustomizado
//
//  Created by Daniel Arndt Alves on 4/6/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *campoTexto;
@property (strong, nonatomic) TecladoViewController *teclado;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.teclado = [self.storyboard instantiateViewControllerWithIdentifier:@"teclado"];
    
    self.teclado.view.frame = CGRectMake(0, 0, 320, 200);
    self.teclado.delegate = self;
    
    self.campoTexto.inputView = self.teclado.view;
}

// Toque na self.view
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.campoTexto resignFirstResponder];
}

-(void)inserirTextoNoCampoTexto:(NSString *)novoTexto {
    self.campoTexto.text = [self.campoTexto.text stringByAppendingString:novoTexto];
}

@end
