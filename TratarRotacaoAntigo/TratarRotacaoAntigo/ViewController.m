//
//  ViewController.m
//  TratarRotacaoAntigo
//
//  Created by Daniel Arndt Alves on 3/16/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *botao;

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


// Em cada ViewController precisamos definir para qual orientação ele vai rotacionar
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// Método acionado depois de rotacionar
// Recebemos pelo parâmetro a orientação da qual estamos vindo - fromInterfaceOrientation
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"Rotação ocorreu");
}

// Método acionado antes de rotacionar
// Recebemos pelo parâmetro a orientação para onde estamos indo
// Recebemos o tempo da rotação
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"Vai ocorrer rotação");
    
    // Verificar para qual orientação estamos indo
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [UIView animateWithDuration:duration animations:^{
            self.botao.center = CGPointMake(self.botao.center.x, self.botao.center.y - 80);
        }];
    }
    else {
        [UIView animateWithDuration:duration animations:^{
            self.botao.center = CGPointMake(self.botao.center.x, self.botao.center.y + 80);
        }];
    }
}

@end
