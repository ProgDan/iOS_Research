//
//  ChatViewController.m
//  Chat
//
//  Created by Daniel Arndt Alves on 3/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UITextField *campoMensagem;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

// Info de quem está conectado
@property (strong, nonatomic) MCSession *sessao;

// Anunciar a disponibilidade para se conectar
@property (strong, nonatomic) MCNearbyServiceAdvertiser *meuAdvertiser;
// Procurar alguém disponível para conexão
@property (strong, nonatomic) MCNearbyServiceBrowser *meuBrowser;

// Lista de mensagens
@property (strong, nonatomic) NSMutableArray *listaMensagens;

@end

@implementation ChatViewController

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
    
    self.listaMensagens = [NSMutableArray new];
    self.navigationItem.title = self.apelido;
    
    [self configurarSessaoChat];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.meuBrowser stopBrowsingForPeers];
    [self.meuAdvertiser stopAdvertisingPeer];
    
    self.meuAdvertiser = nil;
    self.meuAdvertiser = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listaMensagens.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    celula.textLabel.text = self.listaMensagens[indexPath.row][@"texto"];
    celula.detailTextLabel.text = self.listaMensagens[indexPath.row][@"remetente"];
    
    return celula;
}

-(void) configurarSessaoChat
{
    // Criando a Sessão
    MCPeerID *meuID = [[MCPeerID alloc] initWithDisplayName:self.apelido];
    self.sessao = [[MCSession alloc] initWithPeer:meuID];
    self.sessao.delegate = self;
    
    // Objeto que anuncia na rede que vc quer se conectar
    self.meuAdvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:meuID discoveryInfo:nil serviceType:@"chatiai"];
    
    // Objeto que procura na rede quem está disponível
    self.meuBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:meuID serviceType:@"chatiai"];
    
    self.meuAdvertiser.delegate = self;
    self.meuBrowser.delegate = self;
    
    [self.meuAdvertiser startAdvertisingPeer];
    [self.meuBrowser startBrowsingForPeers];
}

// Envio/Recebimento de Mensagens
-(void) salvarMensagem: (NSString*)mensagem paraApelido:(NSString*)apelido
{
    // Agrupando as informações em um dicionário
    NSDictionary *infoMensagem = @{@"texto": mensagem,
                                   @"remetente": apelido};
    // Salvando no vetor
    [self.listaMensagens addObject:infoMensagem];
    
    // Atualizar tabela
    [self.tabela reloadData];
    
    // Rolar para o final
    NSIndexPath *ultimaLinha = [NSIndexPath indexPathForRow:self.listaMensagens.count-1 inSection:0];
    
    [self.tabela scrollToRowAtIndexPath:ultimaLinha atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    // Salvando minha própria mensagem para manter o histórico
    [self salvarMensagem:self.campoMensagem.text paraApelido:@"Eu"];
    
    if (self.sessao.connectedPeers.count > 0) {
        NSData *dadosTexto = [self.campoMensagem.text dataUsingEncoding:NSUTF8StringEncoding];
        NSError *meuErro;
        
        [self.sessao sendData:dadosTexto toPeers:self.sessao.connectedPeers withMode:MCSessionSendDataReliable error:&meuErro];
        if (meuErro) {
            NSLog(@"Erro no envio: %@", meuErro.localizedFailureReason);
        }
    }
    self.campoMensagem.text = nil;
    
    return YES;
}

#pragma mark Advertiser/Browser
-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
    // Fui encontrado!
    // Posso ou não aceitar o convite!
    invitationHandler(YES, self.sessao);
    [self salvarMensagem:@"Entrou na sala..." paraApelido:peerID.displayName];
}

-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    // Encontramos alguém! Vamos convidar...
    [browser invitePeer:peerID toSession:self.sessao withContext:nil timeout:100];
}

-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    [self salvarMensagem:@"Saiu da sala..." paraApelido:peerID.displayName];
}

#pragma mark Session
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    NSString *mensagem = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self salvarMensagem:mensagem paraApelido:peerID.displayName];
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    
}



@end
