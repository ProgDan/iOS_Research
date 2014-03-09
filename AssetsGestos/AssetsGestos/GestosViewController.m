//
//  GestosViewController.m
//  AssetsGestos
//
//  Created by Daniel Arndt Alves on 3/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "GestosViewController.h"

@interface GestosViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *foto;

@property (assign, nonatomic) float escala;
@property (assign, nonatomic) float rotacao;

@end

@implementation GestosViewController

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
    
    self.escala = 1.0;
    self.rotacao = 0.0;
    
    self.foto.image = self.imagemSelecionada;
    [self adicionarGestosNaImagem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) adicionarGestosNaImagem {
    // Criar um recognizer
    // Configurar quando o gesto é reconhecido
    // Definir qual o método será disparado quando o gesto acontecer
    
    // Algumas views não possuem interação com o usuário por padrão
    // Vamos habilitar o nosso UIImageView
    self.foto.userInteractionEnabled = YES;
    
    // TAP Gesture
    UITapGestureRecognizer *gestoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestoTapReconhecido:)];
    gestoTap.numberOfTapsRequired = 2;
    gestoTap.numberOfTouchesRequired = 1;
    
    // Escolher a view onde o gesto será reconhecido
    [self.foto addGestureRecognizer:gestoTap];
    
    UITapGestureRecognizer *gestoTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestoTap3Reconhecido:)];
    gestoTap3.numberOfTapsRequired = 3;
    [self.foto addGestureRecognizer:gestoTap3];
    
    // Para quando houver conflito de gestos, definimos prioridades
    [gestoTap requireGestureRecognizerToFail:gestoTap3];
    
    // Pinch
    UIPinchGestureRecognizer *gestoPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gestoPinchReconhecido:)];
    gestoPinch.delegate = self;
    [self.foto addGestureRecognizer:gestoPinch];
    
    // Rotate
    UIRotationGestureRecognizer *gestoRotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(gestoRotationReconhecido:)];
    gestoRotation.delegate = self;
    [self.foto addGestureRecognizer:gestoRotation];
    
    // Pan
    UIPanGestureRecognizer *gestoPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestoPanReconhecido:)];
    gestoPan.delegate = self;
    [self.foto addGestureRecognizer:gestoPan];
    
}

- (void) gestoTap3Reconhecido: (UITapGestureRecognizer *)gesto {
    NSLog(@"Gesto Tap 3 Toques");
}

- (void) gestoTapReconhecido: (UITapGestureRecognizer *)gesto {
    self.escala = 1.0;
    self.rotacao = 0.0;

    self.foto.center = self.view.center;
    
    [self alterarEscalaRotacaoImagem];
    
    NSLog(@"Gesto Tap");
}
- (void) gestoPinchReconhecido: (UIPinchGestureRecognizer *)gesto{
    if (gesto.state == UIGestureRecognizerStateBegan) {
        gesto.scale = self.escala;
    }
    else {
        self.escala = gesto.scale;
        
        if (self.escala < 0.7) {
            self.escala = 0.7;
        }
        
        [self alterarEscalaRotacaoImagem];
    }
    NSLog(@"Gesto Pinch %.2f", gesto.scale);
}
- (void) alterarEscalaRotacaoImagem {
    CGAffineTransform transformRotacao = CGAffineTransformMakeRotation(self.rotacao);
    self.foto.transform = CGAffineTransformScale(transformRotacao, self.escala, self.escala);
}

- (void) gestoRotationReconhecido: (UIRotationGestureRecognizer *)gesto{
    if (gesto.state == UIGestureRecognizerStateBegan) {
        gesto.rotation = self.rotacao;
    }
    else {
        self.rotacao = gesto.rotation;
        [self alterarEscalaRotacaoImagem];
    }
    
    NSLog(@"Gesto Rotation %.2f", gesto.rotation);
}
- (void) gestoPanReconhecido: (UIPanGestureRecognizer *)gesto{
    // Onde aconteceu o toque?
    // Para onde foi?
    // Deslocamento
   CGPoint pontoTranslacao = [gesto translationInView:self.view];
    
     CGPoint novoCentroImagem = CGPointMake(self.foto.center.x + pontoTranslacao.x, self.foto.center.y + pontoTranslacao.y);
    
    self.foto.center = novoCentroImagem;
    
    // Zerando a leitura para o próximo gesto
    [gesto setTranslation:CGPointZero inView:self.view];
    
    NSLog(@"Gesto Pan");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
