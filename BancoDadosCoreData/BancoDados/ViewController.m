//
//  ViewController.m
//  BancoDados
//
//  Created by Eduardo Lima on 3/23/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *campoAutor;
@property (weak, nonatomic) IBOutlet UITextField *campoTitulo;
@property (weak, nonatomic) IBOutlet UITextField *campoPreco;
@property (weak, nonatomic) IBOutlet UITextField *campoAno;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

@property (nonatomic, strong) NSMutableArray *listaLivros;

- (IBAction)deleteTabela:(id)sender;
- (IBAction)cadastrarLivroClicado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buscarTodosLivros) name:@"CoreDataAbriuBanco" object:nil];
    
}

- (IBAction)deleteTabela:(id)sender {

    if (self.tabela.isEditing) {
  
        [self apagarRegistrosBancoParaIndexPaths:self.tabela.indexPathsForSelectedRows];
        
        [self.tabela deleteRowsAtIndexPaths:self.tabela.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationMiddle];
        
    }
    
    self.tabela.allowsMultipleSelectionDuringEditing = !self.tabela.allowsMultipleSelectionDuringEditing;
    self.tabela.editing = !self.tabela.editing;
    
}

- (IBAction)cadastrarLivroClicado:(id)sender {
    //Esconder o teclado
    [self.view endEditing:YES];
    
    NSDictionary *infoLivro = @{@"titulo": self.campoTitulo.text,
                                @"autor": self.campoAutor.text,
                                @"preco": self.campoPreco.text,
                                @"ano": self.campoAno.text};
    
    [[CoreDataHandler shared] inserirNovoLivro:infoLivro];
    
    self.campoTitulo.text = nil;
    self.campoAutor.text = nil;
    self.campoPreco.text = nil;
    self.campoAno.text = nil;
    
    [self buscarTodosLivros];
}

-(void)buscarTodosLivros{
    
    self.listaLivros = [[[CoreDataHandler shared] buscarTodosLivros] mutableCopy];
    [self.tabela reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listaLivros.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Livro *livro = self.listaLivros[indexPath.row];
    
    celula.textLabel.text = livro.titulo;
    celula.detailTextLabel.text = livro.autor;
    
    return celula;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSLog(@"DELETE!");
        
        [self apagarRegistrosBancoParaIndexPaths:@[indexPath]];
    }
    
    
}

-(void)apagarRegistrosBancoParaIndexPaths:(NSArray*)indexPaths{
    
    
    for (NSIndexPath *indexPath in indexPaths) {
        [[CoreDataHandler shared] removerLivro:self.listaLivros[indexPath.row]];
    }
    
    self.listaLivros = [[[CoreDataHandler shared] buscarTodosLivros] mutableCopy];
    
    [self.tabela deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}


@end
