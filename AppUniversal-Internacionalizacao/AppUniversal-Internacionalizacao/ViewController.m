//
//  ViewController.m
//  AppUniversal-Internacionalizacao
//
//  Created by Daniel Arndt Alves on 3/16/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnAnimar;
@property (weak, nonatomic) IBOutlet UIView *minhaView;

- (IBAction)animar:(UIButton *)sender;

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

- (IBAction)animar:(UIButton *)sender {
    // Sempre quando se cria um app universal e precisamos mexer com posicionamento, precisamos sempre nos referenciar ao tamanho da view superior
    int duracao;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        duracao = 1;
    }
    else {
        duracao = 3;
    }
    
    [UIView animateWithDuration:duracao animations:^{
        self.minhaView.center = CGPointMake(self.view.frame.size.width - self.minhaView.frame.size.width/2, self.view.frame.size.height - self.minhaView.frame.size.height/2);
    }];
    
    // Self.storyboard...
    // Ao carregar uma tela do Story Board com um ID específico, lembrar que ambos os Story Boards devem contar a tela com o mesmo ID
    // [self.storyboard instantiateViewControllerWithIdentifier:@""];
}


@end
