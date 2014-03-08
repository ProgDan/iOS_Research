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

@property (nonatomic, strong) NSURL *urlGravacao;

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

-(void) criarNovoPlayerParaArquivo:(NSURL*)urlAudio{
    // Criando um novo player passando a url para o arquivo de audio que desejamos reproduzir
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlAudio error:nil];
    
    [self.player play];
    
}

- (IBAction)botaoCriarPlayerClicado:(UIButton *)sender {
    
    if (self.player) {
        [self.player stop];
        self.player = nil;
        
        return;
    }
    
    // Localizar um arquivo dentro do projeto
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Do You" ofType:@"m4a"];
    
    // Criando uma URL a partir deste path
    NSURL *urlArquivo = [NSURL fileURLWithPath:path];
    
    [self criarNovoPlayerParaArquivo:urlArquivo];
}

- (IBAction)gravarNovoAudioClicado:(UIButton *)sender {
    if(self.gravador){
        [self.gravador stop];
        self.gravador = nil;
        
        return;
    }
    
    // NSHomeDirectory() fornece o endereço raiz do app dentro do iOS
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/arquivoGravado.wav"];
    
    // Criando uma URL a partir do path home/Documents
    self.urlGravacao = [NSURL fileURLWithPath:path];
    
    self.gravador = [[AVAudioRecorder alloc] initWithURL:self.urlGravacao settings:nil error:nil];
    
    [self.gravador record];
}

- (IBAction)reproduzirAudioClicado:(UIButton *)sender {
    if (self.urlGravacao) {
        [self criarNovoPlayerParaArquivo:self.urlGravacao];
    }
}

@end
