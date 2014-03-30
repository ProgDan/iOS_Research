//
//  ViewController.m
//  iCloud
//
//  Created by Daniel Arndt Alves on 3/30/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (weak, nonatomic) IBOutlet UITextField *campoAnotacao;

- (IBAction)sincronizarClicado:(UIButton *)sender;

@property (strong, nonatomic) NSMutableArray *anotacoes;

// Referência à pasta do app na nuvem
@property (nonatomic, strong) NSURL *urlCloud;

// Para encontrar arquivos na nuvem
@property (nonatomic, strong) NSMetadataQuery *buscaCloud;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.anotacoes = [NSMutableArray new];
    
    // recuperando a referência para a pasta na nuvem
    self.urlCloud = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    if (self.urlCloud) {
        NSLog(@"iCloud OK! %@", self.urlCloud);
        
        [self buscarArquivoAtualizado];
    }
    else {
        NSLog(@"Problemas na conexão com o iCloud!");
    }
}

- (IBAction)sincronizarClicado:(UIButton *)sender {
    [self buscarArquivoAtualizado];
}

#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"minhaCelula"];
    
    celula.textLabel.text = self.anotacoes[indexPath.row][@"texto"];
    celula.detailTextLabel.text = self.anotacoes[indexPath.row][@"data"];
    
    return celula;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.anotacoes.count;
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    // Formatar a data como sendo texto
    NSDateFormatter *formatador = [NSDateFormatter new];
    // Definindo o formado do texto
    [formatador setDateFormat:@"dd/MM/yyyy - HH:mm:ss"];
    // Extraindo um texto com as informações da data atual
    NSString *dataString = [formatador stringFromDate:[NSDate date]];
    
    NSDictionary *novaAnotacao = @{@"texto": textField.text, @"data": dataString};
    
    [self.anotacoes addObject:novaAnotacao];
    //[self.anotacoes insertObject:novaAnotacao atIndex:0];
    
    self.campoAnotacao.text = nil;
    
    [self.tabela reloadData];
    
    [self atualizarAnotacoesCloud];
    
    return YES;
}

// Preparar um document e enviar para a nuvem
-(void) atualizarAnotacoesCloud {
    NSURL *urlRemota = [[self.urlCloud URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:@"anotacoes.plist"];
    
    DocumentoCloud *documento = [[DocumentoCloud alloc] initWithFileURL:urlRemota];
    
    documento.anotacoes = self.anotacoes;
    
    // Upload
    [documento saveToURL:urlRemota forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Arquivo atualizado!");
        }
        else {
            NSLog(@"Problemas na atualização do arquivo!");
        }
    }];
}

// Download
-(void) buscarArquivoAtualizado {
    self.buscaCloud = [NSMetadataQuery new];
    
    self.buscaCloud.searchScopes = @[NSMetadataQueryUbiquitousDocumentsScope];
    
    // Definir o critério - nome do arquivo
    self.buscaCloud.predicate = [NSPredicate predicateWithFormat:@"%K == %@", NSMetadataItemFSNameKey, @"anotacoes.plist"];
    
    // Cadastrando a viewController para receber uma notificação quando a busca acabar
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buscaTerminou:) name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    
    // Iniciar a busca
    [self.buscaCloud startQuery];
}

-(void) buscaTerminou: (NSNotification *)notificacao {
    
    [self.buscaCloud stopQuery];
    [self.buscaCloud disableUpdates];
    
    // Remover!
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    
    NSURL *urlRemota = [[self.urlCloud URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:@"anotacoes.plist"];
    
    DocumentoCloud *documento = [[DocumentoCloud alloc] initWithFileURL:urlRemota];
    
    documento.anotacoes = self.anotacoes;
    
    // Encontrou o arquivo na nuvem?
    if (self.buscaCloud.resultCount == 1) {
        // Arquivo encontrado
        [documento openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Documento aberto!");
                self.anotacoes = documento.anotacoes;
                [self.tabela reloadData];
            }
        }];
        

    }
    else if (self.buscaCloud.resultCount > 1){
        NSLog(@"Encontrado mais de um arquiivo!");
    }
    else {
        // Arquivo não encontrado
        NSLog(@"Arquivo não encontrado!");
        
        [documento saveToURL:urlRemota forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Arquivo criado!");
            }
        }];
    }
}

@end
