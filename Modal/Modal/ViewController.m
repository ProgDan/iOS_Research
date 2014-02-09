//
//  ViewController.m
//  Modal
//
//  Created by Daniel Arndt Alves on 2/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import "NovaTelaViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)modalCodigo:(UIButton *)sender {
    // Acessando o Story Board
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    // Acessando a nova tela
    NovaTelaViewController *tela = [story instantiateViewControllerWithIdentifier:@"novaTela"];
    
    tela.strTexto = @"Qualquer texto";
    
    // Modificando a animação
    tela.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Apresentando a nova tela
    [self presentViewController:tela animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
