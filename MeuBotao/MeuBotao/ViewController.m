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
@property (weak, nonatomic) IBOutlet UISlider *slider;

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
    self.label.text = @"Novo texto";
}

- (IBAction)mudouValor:(UISlider *)sender {
    self.label.alpha = (float)sender.value/100;
    
    float altura = sender.value;
    
    self.label.frame = CGRectMake(10, 32, 300, altura);
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:altura];
    
    NSLog(@"%d", (int)sender.value);
}
- (IBAction)escondeImagem:(UISwitch *)sender {
    self.label.hidden = !sender.isOn;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
