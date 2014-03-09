//
//  ViewController.m
//  VideoPlayer
//
//  Created by Daniel Arndt Alves on 3/9/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *areaVideo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

// Objetio responsável por executar arquivos de vídeo
@property (strong, nonatomic) MPMoviePlayerController *playerVideo;

@property (strong, nonatomic) NSURL *urlGravacao;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Cadastrar a ViewController como ouvinte das mensagens do player de vídeo
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerVideoMudouEstado) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

- (void) playerVideoMudouEstado {
    if (self.playerVideo.loadState == MPMovieLoadStatePlayable || self.playerVideo.loadState == MPMovieLoadStatePlaythroughOK || self.playerVideo.loadState == MPMovieLoadStateUnknown) {
        self.spinner.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)criarNovoPlayer:(NSURL *)url {
    if (self.playerVideo) {
        [self.playerVideo stop];
        [self.playerVideo.view removeFromSuperview];
        self.playerVideo = nil;
    }
    
    self.playerVideo = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.playerVideo.view.frame = self.areaVideo.bounds;
    
    // adicionar na tela
    [self.areaVideo addSubview:self.playerVideo.view];
    
    [self.playerVideo play];
}

- (IBAction)abrirVideoRemoto:(UIButton *)sender {
    // Localizar o arquivo
    //NSURL *urlVideoRemoto = [NSURL URLWithString:@"http://tinyurl.com/aulavideoiai"];
    NSURL *urlVideoRemoto = [NSURL URLWithString:@"http://tinyurl.com/4zwzmf7"];
    //NSURL *urlVideoRemoto = [NSURL URLWithString:@"http://rokudev.roku.com/rokudev/testvideo/diggnation--0160--2008-07-24joshv--hd.h264.mov"];
    
    
    [self criarNovoPlayer:urlVideoRemoto];
    
    self.spinner.hidden = NO;
    
    // Trazendo a view do spinner para o topo das views
    [self.areaVideo bringSubviewToFront:self.spinner];
}

- (IBAction)abrirVideoLocal:(UIButton *)sender {
    // Localizar o arquivo
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meuFilme" ofType:@"m4v"];
    NSURL *urlVideoLocal = [NSURL fileURLWithPath:path];
    
    [self criarNovoPlayer:urlVideoLocal];
}

- (IBAction)gravarVideo:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *telaCamera = [UIImagePickerController new];
        telaCamera.delegate = self;
        telaCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        telaCamera.mediaTypes = @[@"public.movie"];
        
        [self presentViewController:telaCamera animated:YES completion:nil];
    }
}

- (IBAction)salvarVideo:(UIButton *)sender {
    UISaveVideoAtPathToSavedPhotosAlbum(self.urlGravacao.path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
}

- (void) video: (NSString *) videoPath didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (!error) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Vídeo salvo com sucesso" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Recuperar o local de gravação temporária do vídeo
    self.urlGravacao = [info objectForKey:UIImagePickerControllerMediaURL];
    
    [self criarNovoPlayer:self.urlGravacao];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
