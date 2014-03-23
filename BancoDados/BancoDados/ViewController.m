//
//  ViewController.m
//  BancoDados
//
//  Created by Daniel Arndt Alves on 3/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseHandler.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *campoAutor;
@property (weak, nonatomic) IBOutlet UITextField *campoTitulo;
@property (weak, nonatomic) IBOutlet UITextField *campoPreco;
@property (weak, nonatomic) IBOutlet UITextField *campoAno;
@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (weak, nonatomic) IBOutlet UIButton *botaoEditar;

- (IBAction)cadastrarLivroClicado:(UIButton *)sender;
- (IBAction)ativarEdicao:(UIButton *)sender;

@property (strong, nonatomic) NSMutableArray *listaLivros;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self buscarTodosLivros];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cadastrarLivroClicado:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Livro (titulo, autor, ano, preco) VALUES ('%@', '%@', %@, %@);", self.campoTitulo.text, self.campoAutor.text, self.campoAno.text, self.campoPreco.text];
    
    int resultado = [[DatabaseHandler shared] adicionarConteudoComSQL:sql];
    
    if (resultado) {
        NSLog(@"Livro cadastrado");
        [self buscarTodosLivros];
        [self.tabela reloadData];
        
        // Limpar os campos
        self.campoPreco.text = nil;
        self.campoAutor.text = nil;
        self.campoTitulo.text = nil;
        self.campoAutor.text = nil;
    }
    else {
        NSLog(@"Erro na inserção");
    }
}

- (IBAction)ativarEdicao:(UIButton *)sender {
    // self.tabela.allowsMultipleSelectionDuringEditing = YES;
    
    self.tabela.editing = !self.tabela.editing;

    if (self.tabela.editing) {
        [self.botaoEditar setTitle: @"Terminar" forState:UIControlStateNormal];
    }
    else {
        [self.botaoEditar setTitle: @"Editar" forState:UIControlStateNormal];
    }
    
}

-(void) buscarTodosLivros
{
    NSString *sql = @"SELECT id, titulo, autor, preco, ano FROM Livro;";
    
    self.listaLivros = [[[DatabaseHandler shared] buscarConteudoComSQL:sql] mutableCopy];
    
    NSLog(@"%@", self.listaLivros);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listaLivros.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    celula.textLabel.text = self.listaLivros[indexPath.row][@"titulo"];
    celula.detailTextLabel.text = self.listaLivros[indexPath.row][@"autor"];
    
    return celula;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"DELETE");
        NSNumber *idLivro = self.listaLivros[indexPath.row][@"id"];
        
        // Apagar do Banco de Dados
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM Livro WHERE id=%d", idLivro.intValue];
        int resposta = [[DatabaseHandler shared] excluirConteudoComSQL:sql];
        
        if (resposta) {
            // Atualizar o vetor datasource
            [self buscarTodosLivros];
            
            // Remover visualmente da tabela
            [self.tabela deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        else {
            NSLog(@"Erro no delete");
        }
    }
}

@end
