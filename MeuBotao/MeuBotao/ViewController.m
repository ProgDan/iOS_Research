//
//  ViewController.m
//  MeuBotao
//
//  Created by Daniel Arndt Alves on 2/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Cria um label, via código, sem conexão com o Story Board
//@property(weak, nonatomic) UILabel *label;

@property(weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

/*
    // Criando um botão manualmente...
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 44)];
    [btn setTitle:@"Text" forState:UIControlStateNormal];
    
    // Adicionando o botão na tela
    [self.view addSubview:btn];
*/
    
}

-(IBAction)apertouBotao{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
