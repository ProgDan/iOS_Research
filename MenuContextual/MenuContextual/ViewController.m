//
//  ViewController.m
//  MenuContextual
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// Por padrão, o menu só pode aparecer em objetos com foco
// Por padrão, o ViewController não pode ser foco, impossibilitando usar o menu. Para que o ViewController possa ser foco, devemos implementar o método abaixo
-(BOOL)canBecomeFirstResponder{
    return YES;
}

// Método acionado quando um toque ocorre na tela
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Vamos fazer o menu aparecer no local do toque
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // Vamos captar onde o toque foi dado na tela
    UITouch *toque = [touches anyObject];
    
    CGPoint toqueNatela = [toque locationInView:self.view];
    
    // Vamos criar os botões que serão colocados no menu
    UIMenuItem *btn1 = [[UIMenuItem alloc]initWithTitle:@"Amarelo" action:@selector(mudarParaAmarelo)];
    UIMenuItem *btn2 = [[UIMenuItem alloc]initWithTitle:@"Branco" action:@selector(mudarParaBranco)];
    
    // Colocar o botão no menu
    [menu setMenuItems:@[btn1, btn2]];
    
    // Para o menu aparecer, o ViewController deve ser o foco
    [self becomeFirstResponder];
    
    // Definir o local onde vai aparecer
    [menu setTargetRect:CGRectMake(toqueNatela.x, toqueNatela.y, 1, 1) inView:self.view];
    
    [menu setArrowDirection:UIMenuControllerArrowDefault];
    
    [menu setMenuVisible:YES animated:YES];
}

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

-(void) mudarParaAmarelo{
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void) mudarParaBranco{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
