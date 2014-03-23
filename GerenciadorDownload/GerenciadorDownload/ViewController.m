//
//  ViewController.m
//  GerenciadorDownload
//
//  Created by Daniel Arndt Alves on 3/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *botaoIniciar;
@property (weak, nonatomic) IBOutlet UIProgressView *barraProgresso;
@property (weak, nonatomic) IBOutlet UILabel *nomeArquivo;
@property (weak, nonatomic) IBOutlet UILabel *avancoBytes;
@property (weak, nonatomic) IBOutlet UIImageView *foto;

- (IBAction)downloadClicado:(UIButton *)sender;

@property (assign, nonatomic) BOOL isDownloading;
@property (strong, nonatomic) NSURLSessionDownloadTask *tarefaDownload;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.isDownloading = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadClicado:(UIButton *)sender {
    
    // Altera o título do botão de download
    
    if (self.isDownloading) {
        [self.botaoIniciar setTitle:@"Download" forState:UIControlStateNormal];
        
        [self.tarefaDownload suspend];
    }
    else {
        [self.botaoIniciar setTitle:@"Parar" forState:UIControlStateNormal];
        
        // Início do processo
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *sessao = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        
        // Uma vez criada a sessão, posso associar várias tasks
        self.tarefaDownload = [sessao downloadTaskWithURL:[NSURL URLWithString:@"http://lh5.ggpht.com/-JjQBh3GX0xk/UHKpa9trXJI/AAAAAAAAkCw/vQvlspLOluM/s9000/2013-BMW-R-1200-GS-New-BMW-R-1200-GS-5.jpg"]];
        
        // Iniciar a tarefa
        [self.tarefaDownload resume];
    }
    
    self.isDownloading = !self.isDownloading;
    
}

#pragma mark NSURLSessionDelegate

#pragma mark NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // __block altera o escopo da variável para existir dentro do bloco da main thread
    // como o bloco está na main thread, a variável dadosImagem não será descartada enquanto a imagem for exibida
    __block NSData *dadosImagem = [NSData dataWithContentsOfURL:location];
    
    NSString *path = [[NSHomeDirectory() stringByAppendingString:@"/Documents/"] stringByAppendingString:downloadTask.response.suggestedFilename];
    
    [dadosImagem writeToFile:path atomically:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Recuperando os dados da imagem da URL temp
//        NSData *dadosImagem = [NSData dataWithContentsOfURL:location];
        
        self.foto.image = [UIImage imageWithData:dadosImagem];
        
        [self.botaoIniciar setTitle:@"Download" forState:UIControlStateNormal];
        self.isDownloading = NO;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    // Disparar processos em outras threads
    // Estamos em uma thread secundária
    // Mudar a barra de progresso na thread principal
    dispatch_async(dispatch_get_main_queue(), ^{
        // Aqui estamos executando na main thread
        self.avancoBytes.text = [NSString stringWithFormat:@"%lld / %lld", totalBytesWritten, totalBytesExpectedToWrite];
        
        self.barraProgresso.progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        
        if (![self.nomeArquivo.text isEqualToString:downloadTask.response.suggestedFilename]) {
            self.nomeArquivo.text = downloadTask.response.suggestedFilename;
        }
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

@end
