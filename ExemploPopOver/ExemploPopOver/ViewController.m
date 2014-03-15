//
//  ViewController.m
//  ExemploPopOver
//
//  Created by Daniel Arndt Alves on 3/15/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    // É interessante instanciar o popOverController e o ViewControllerSlider no viewDidLoad
    ViewControllerSlider *vcs;
    UIPopoverController *popOverControllerSlider;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Instanciar ViewControllerSlider carregando sua interface do Story Board
    vcs = [self.storyboard instantiateViewControllerWithIdentifier:@"idVCS"];
    
    // vamos informar para o VCS que ele deve nos avisar quando algo ocorrer dentro dele
    vcs.delegate = self;
    
    // criando o PopOverController e já colocando o ViewControllerSlider dentro dele
    popOverControllerSlider = [[UIPopoverController alloc] initWithContentViewController:vcs];
    
    // dentro do PopOverController está acontecendo um evento que queremos captar dentro do ViewControllerBase
    // para o PopOverControllerSlider saber que ele precisa avisar o ViewControllerBase, iremos guardar a nossa instância dentro do PopOverControllerSlider
    popOverControllerSlider.delegate = self;
    
    // O espaço em memória onde guardamos a noossa instância para que ele possa nos avisar depois, normalmente se chama delegate
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mostrarPopOverMudarCor:(id)sender {
    UIButton *btn = (UIButton*)sender;
    
    // fazer aparecer um popOver com o ViewControllerSlider dentro
    [popOverControllerSlider presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

// Método acionado pelo PopOverControllerSlider no momento em que o PopOver vai sumir com a intenção de nos perguntar se ele deve sumir mesmo. Percebam que o retorno do método é um BOOL, que vai ser nossa resposta.
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    // Usamos este método para verificar se tem algum processo crítico ocorrendo. Se tiver, perguntamos para o usuário se ele deseja fechar o PopOver
    
    return YES;
}

// Método acionado pelo VCS quando o usuário mudar o valor de um slider
// Estamos recebendo o valor da nova cor pelo parâmetro
-(void)acionaramSliderEACorMudouPara:(UIColor *)novaCor{
    self.view.backgroundColor = novaCor;
}

@end
