//
//  ViewController.m
//  Cloud
//
//  Created by Eduardo Lima on 3/30/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)sincronizarClicado:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *campoAnotacao;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

@property (nonatomic, strong) NSMutableArray *anotacoes;

//Referencia à pasta do app na nuvem
@property (nonatomic, strong) NSURL *urlCloud;

//Para encontrar arquivos na nuvem
@property (nonatomic, strong) NSMetadataQuery *buscaCloud;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.anotacoes = [[NSMutableArray alloc] init];
    
    
    //recuperando a referencia para a pasta na nuvem
    self.urlCloud = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    if (self.urlCloud) {
        NSLog(@"CLOUD OK! %@", self.urlCloud);
        
        [self buscarArquivoAtualizado];
    }
    else{
        NSLog(@"Problemas na conexão com o iCloud");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sincronizarClicado:(id)sender {
    
    [self buscarArquivoAtualizado];
    
}


#pragma mark tabela

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.anotacoes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"minhaCelula"];
    
    celula.textLabel.text = self.anotacoes[indexPath.row][@"texto"];
    celula.detailTextLabel.text = self.anotacoes[indexPath.row][@"data"];
    
    return celula;
    
}

#pragma mark textfield

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    //Formatar a data como sendo texto
    NSDateFormatter *formatador = [[NSDateFormatter alloc] init];
    //Definindo o formato do texto
    [formatador setDateFormat:@"dd/MM/yyyy - hh:mm:ss"];
    
    //Extraindo um texto com as informações da data atual
    NSString *dataString = [formatador stringFromDate:[NSDate date]];
    
    NSDictionary *novaAnotacao = @{@"texto": self.campoAnotacao.text,
                                   @"data": dataString};
    
    
    //[self.anotacoes addObject:novaAnotacao];
    [self.anotacoes insertObject:novaAnotacao atIndex:0];
    
    [self.tabela reloadData];
    
    self.campoAnotacao.text = nil;
    
    [self atualizarAnotacoesCloud];
    
    return YES;
}

//Preparar um document e enviar para a nuvem
-(void)atualizarAnotacoesCloud{
    
    NSURL *urlRemota = [[self.urlCloud URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:@"anotacoes.plist"];
    
    
    DocumentoCloud *documento = [[DocumentoCloud alloc] initWithFileURL:urlRemota];
    documento.anotacoes = self.anotacoes;
    
    //Upload!
    [documento saveToURL:urlRemota forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        
        if (success) {
            NSLog(@"Arquivo atualizado!");
        }
        else{
            NSLog(@"Problemas na atualização do arquivo");
        }
        
    }];
}

//Download
-(void)buscarArquivoAtualizado{
    
    self.buscaCloud = [[NSMetadataQuery alloc] init];
    
    self.buscaCloud.searchScopes = @[NSMetadataQueryUbiquitousDocumentsScope];
    
    //Definir o criterio - nome do arquivo
    self.buscaCloud.predicate = [NSPredicate predicateWithFormat:@"%K == %@", NSMetadataItemFSNameKey, @"anotacoes.plist"];
    
    //Cadastrando a viewController para receber uma notificação quando a busca acabar
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buscaTerminou:) name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    
    //Iniciar a busca
    [self.buscaCloud startQuery];
    
    
}

-(void)buscaTerminou:(NSNotification*)notificacao{
    
    [self.buscaCloud stopQuery];
    [self.buscaCloud disableUpdates];
    
    //Remover! Caso a remoção não aconteça, ao fazer um novo addObserver, duplicamos a notificação!
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    
    
    NSURL *urlRemota = [[self.urlCloud URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:@"anotacoes.plist"];
    
    DocumentoCloud *documento = [[DocumentoCloud alloc] initWithFileURL:urlRemota];
    documento.anotacoes = self.anotacoes;
    
    //Encontrou o arquivo na nuvem?
    if (self.buscaCloud.resultCount == 1) {
        
        //Arquivo encontrado!
        [documento openWithCompletionHandler:^(BOOL success) {
           
            if (success) {
                NSLog(@"Documento aberto");
                
                self.anotacoes = documento.anotacoes;
                [self.tabela reloadData];
            }
        }];
        
    }
    else if(self.buscaCloud.resultCount > 1){
        
        NSLog(@"Encontrado mais de um arquivo");
        
    }
    else{
        
        //Arquivo não encontrado
        [documento saveToURL:urlRemota forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
           
            if (success) {
                NSLog(@"Arquivo criado!");
            }
            
        }];
        
        
    }
    
    
}





@end
