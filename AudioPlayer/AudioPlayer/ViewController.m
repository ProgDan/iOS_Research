//
//  ViewController.m
//  AudioPlayer
//
//  Created by Daniel Arndt Alves on 3/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)botaoCriarPlayerClicado:(UIButton *)sender;
- (IBAction)gravarNovoAudioClicado:(UIButton *)sender;
- (IBAction)reproduzirAudioClicado:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *botaoPlayer;
@property (weak, nonatomic) IBOutlet UIButton *botaoIniciarGravacao;
@property (weak, nonatomic) IBOutlet UIButton *botaoReproduzir;

// Representa o recurso de audio do iOS
@property (nonatomic, weak) AVAudioSession *sessaoAudio;

@property (nonatomic, strong) NSURL *urlGravacao;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Recuperando a referência a instância compartilhada
    self.sessaoAudio = [AVAudioSession sharedInstance];
    [self.sessaoAudio setActive:YES error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) criarNovoPlayerParaArquivo:(NSURL*)urlAudio{
    // Criando um novo player passando a url para o arquivo de audio que desejamos reproduzir
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlAudio error:nil];
    self.player.delegate = self;
    
    // Mudar o tipo da sessão
    [self.sessaoAudio setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [self.player play];
    
}

- (IBAction)botaoCriarPlayerClicado:(UIButton *)sender {
    
    if (self.player) {
        [self.player stop];
        self.player = nil;
        
        // Ajustes de interface
        self.botaoIniciarGravacao.hidden = NO;
        self.botaoReproduzir.hidden = NO;
        [self.botaoPlayer setTitle:@"Iniciar Player" forState:UIControlStateNormal];
        
        return;
    }
    
    // Localizar um arquivo dentro do projeto
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Do You" ofType:@"m4a"];
    
    // Criando uma URL a partir deste path
    NSURL *urlArquivo = [NSURL fileURLWithPath:path];
    
    [self criarNovoPlayerParaArquivo:urlArquivo];
    
    // Ajustes de interface
    self.botaoIniciarGravacao.hidden = YES;
    self.botaoReproduzir.hidden = YES;
    [self.botaoPlayer setTitle:@"Encerrar Player" forState:UIControlStateNormal];
}

#pragma mark Gravador de som

- (IBAction)gravarNovoAudioClicado:(UIButton *)sender {
    if(self.gravador){
        [self.gravador stop];
        self.gravador = nil;
        
        self.botaoReproduzir.hidden = NO;
        self.botaoPlayer.hidden = NO;
        [self.botaoIniciarGravacao setTitle:@"Gravar Novo Audio" forState:UIControlStateNormal];
        return;
    }
    
    // NSHomeDirectory() fornece o endereço raiz do app dentro do iOS
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/arquivoGravado.wav"];
    
    // Criando uma URL a partir do path home/Documents
    self.urlGravacao = [NSURL fileURLWithPath:path];
    
    self.gravador = [[AVAudioRecorder alloc] initWithURL:self.urlGravacao settings:nil error:nil];

    // Mudar o tipo da sessão
    [self.sessaoAudio setCategory:AVAudioSessionCategoryRecord error:nil];
    
    [self.gravador record];
    
    self.botaoReproduzir.hidden = YES;
    self.botaoPlayer.hidden = YES;
    [self.botaoIniciarGravacao setTitle:@"Parar Gravação" forState:UIControlStateNormal];
}

- (IBAction)reproduzirAudioClicado:(UIButton *)sender {
    if (self.urlGravacao && !self.player) {
        [self criarNovoPlayerParaArquivo:self.urlGravacao];
        
        self.botaoPlayer.hidden = YES;
        self.botaoIniciarGravacao.hidden = YES;
        [self.botaoReproduzir setTitle:@"Parar Reprodução" forState:UIControlStateNormal];
    }
    else {
        [self.player stop];
        self.player = nil;
        
        self.botaoPlayer.hidden = NO;
        self.botaoIniciarGravacao.hidden = NO;
        [self.botaoReproduzir setTitle:@"Reproduzir Gravação" forState:UIControlStateNormal];
    }
}

#pragma mark AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.botaoPlayer.hidden = NO;
    self.botaoIniciarGravacao.hidden = NO;
    self.botaoReproduzir.hidden = NO;
    [self.botaoReproduzir setTitle:@"Reproduzir Gravação" forState:UIControlStateNormal];
    [self.botaoPlayer setTitle:@"Iniciar Player" forState:UIControlStateNormal];
}

@end
