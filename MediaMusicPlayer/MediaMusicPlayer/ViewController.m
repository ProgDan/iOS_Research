//
//  ViewController.m
//  MediaMusicPlayer
//
//  Created by Daniel Arndt Alves on 3/8/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *capa;
@property (weak, nonatomic) IBOutlet UILabel *album;
@property (weak, nonatomic) IBOutlet UILabel *musica;
@property (weak, nonatomic) IBOutlet UILabel *artista;

@property (strong, nonatomic) NSArray *listaMusicas;
@property (weak, nonatomic) IBOutlet UITableView *playlist;

@property (strong, nonatomic) MPMusicPlayerController *iOSPlayer;

@end

// 1. Selecionar as músicas do device, montar a playlist
// 2. Passar a playlist para o player
// 3. atualizar a info de cada música executada


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Recuperando a referencia do player do aparelho
    self.iOSPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    [self.iOSPlayer beginGeneratingPlaybackNotifications];
    
    // Cadastrar a ViewController como ouvinte destas notificações
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerNotificouMudancaDeFaixa) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voltar:(UIButton *)sender {
    [self.iOSPlayer skipToPreviousItem];
}

- (IBAction)stop:(UIButton *)sender {
    [self.iOSPlayer stop];
}

- (IBAction)play:(UIButton *)sender {
    [self.iOSPlayer play];
}

- (IBAction)pause:(UIButton *)sender {
    [self.iOSPlayer pause];
}

- (IBAction)avancar:(UIButton *)sender {
    [self.iOSPlayer skipToNextItem];
}

- (IBAction)montarPlaylist:(UIButton *)sender {
    MPMediaPickerController *telaMusicas = [MPMediaPickerController new];
    
    // Permitir pegar várias músicas
    telaMusicas.allowsPickingMultipleItems = YES;
    telaMusicas.delegate = self;
    
    [self presentViewController:telaMusicas animated:YES completion:nil];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Selecionou %d musicas.", mediaItemCollection.items.count);
    
    // Salvando a coleção de músicas para a tabela
    self.listaMusicas = mediaItemCollection.items;
    
    // Atualização da tabela
    // Faz com que todos os métodos DataSource sejam executados novamente
    [self.playlist reloadData];
    
    // Passando a playlist para o player
    [self.iOSPlayer setQueueWithItemCollection:mediaItemCollection];
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"minhaCelula"];
    
    // ...configura o conteúdo
    // Nome da música
    // Nome do artista
    MPMediaItem *item = [self.listaMusicas objectAtIndex:indexPath.row];
    celula.textLabel.text = [item valueForProperty:MPMediaItemPropertyTitle];
    celula.detailTextLabel.text = [item valueForProperty:MPMediaItemPropertyArtist];
    
    return celula;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listaMusicas.count;
}

-(void) playerNotificouMudancaDeFaixa {
    NSLog(@"Mudou de faixa!");
    
    MPMediaItem *faixaAtual = self.iOSPlayer.nowPlayingItem;
    
    self.artista.text = [faixaAtual valueForProperty:MPMediaItemPropertyArtist];
    self.album.text = [faixaAtual valueForProperty:MPMediaItemPropertyAlbumTitle];
    self.musica.text = [faixaAtual valueForProperty:MPMediaItemPropertyTitle];
    
    MPMediaItemArtwork *capa = [faixaAtual valueForProperty:MPMediaItemPropertyArtwork];
    self.capa.image = [capa imageWithSize:self.capa.frame.size];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    MPMediaItem *novoItemSelecionado = self.listaMusicas[indexPath.row];
    self.iOSPlayer.nowPlayingItem = novoItemSelecionado;
    
    if(self.iOSPlayer.playbackState != MPMusicPlaybackStatePlaying)
        [self.iOSPlayer play];
}



@end
