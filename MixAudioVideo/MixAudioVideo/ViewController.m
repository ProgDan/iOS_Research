//
//  ViewController.m
//  MixAudioVideo
//
//  Created by Daniel Arndt Alves on 3/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Objeto responsável por transformar a composition em um arquivo de video salvo
@property (strong, nonatomic) AVAssetExportSession *exportador;

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

- (IBAction)iniciarMixAudioVideo:(UIButton *)sender {
    [NSThread detachNewThreadSelector:@selector(realizarComposicao) toTarget:self withObject:nil];
}

- (void) realizarComposicao {
    // Tudo o que está aqui, ocorre em uma nova thread!
    // Cuidado! Instruções que alteram componentes visuais devem acontecer somente na MainThread.
    
    // Localizar os assets (recursos de audio e video)
    NSString *pathAudio = [[NSBundle mainBundle] pathForResource:@"Paradise" ofType:@"m4a"];
    NSString *pathVideo = [[NSBundle mainBundle] pathForResource:@"meuFilme" ofType:@"m4v"];
    
    // Montar a url de referência para estes recursos
    AVURLAsset *assetAudio = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:pathAudio] options:nil];
    AVURLAsset *assetVideo = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:pathVideo] options:nil];
    
    // Alocar a composição
    AVMutableComposition *composicao = [AVMutableComposition composition];
    
    // Montar as tracks
    AVMutableCompositionTrack *composicaoAudio = [composicao addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack *composicaoVideo = [composicao addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    AVAssetTrack *trilhaAudio = [[assetAudio tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    AVAssetTrack *trilhaVideo = [[assetVideo tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    [composicaoAudio insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetAudio.duration) ofTrack:trilhaAudio atTime:kCMTimeZero error:nil];
    
    [composicaoVideo insertTimeRange:CMTimeRangeMake(kCMTimeZero, assetVideo.duration) ofTrack:trilhaVideo atTime:kCMTimeZero error:nil];
    
    // Exportar
    // AVAssetExportPresetPassthrough - Assuma e configuração original do vídeo
    self.exportador = [[AVAssetExportSession alloc] initWithAsset:composicao presetName:AVAssetExportPresetPassthrough];
    self.exportador.outputFileType = AVFileTypeQuickTimeMovie;
    
    // Onde?
    NSString *pathDocuments = [NSHomeDirectory() stringByAppendingString:@"/Documents/minhaComposicao.mov"];
    
    // Gerar arquivo final!
    self.exportador.outputURL = [NSURL fileURLWithPath:pathDocuments];
    [self.exportador exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"Arquivo gerado!");
        [self performSelectorOnMainThread:@selector(executarVideoGerado:) withObject:self.exportador.outputURL waitUntilDone:NO];
    }];
    
}

-(void) executarVideoGerado: (NSURL*)url {
    // Alocar uma nova tela de exibição de vídeo
    MPMoviePlayerViewController *telaVideo = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    // Transição por modal
    [self presentViewController:telaVideo animated:YES completion:nil];
}

@end
