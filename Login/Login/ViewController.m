//
//  ViewController.m
//  Login
//
//  Created by Daniel Arndt Alves on 3/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *campoUsuario;
@property (weak, nonatomic) IBOutlet UITextField *campoSenha;
- (IBAction)loginClicaco:(UIButton *)sender;
- (IBAction)cadastrarClicado:(UIButton *)sender;

// Variável que irá acumular todos os pacotes que chegarem através da conexão
@property (strong, nonatomic) NSMutableData *dadosRecebidos;

@property (strong, nonatomic) NSString *resultadoWeb;


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

- (IBAction)loginClicaco:(UIButton *)sender {
    // Preparar uma requisição
    // Body: usuario&senha
    NSURL *url = [NSURL URLWithString:@"http://fernandopastor.sitepessoal.com/aula/login.php"];
    
    NSString *body = [NSString stringWithFormat:@"usuario=%@&senha=%@",self.campoUsuario.text,self.campoSenha.text];
    
    NSMutableURLRequest *requisicao = [[NSMutableURLRequest alloc] initWithURL:url];
    requisicao.HTTPMethod = @"POST";
    requisicao.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // Enviar a requisição, via conexão
    [NSURLConnection connectionWithRequest:requisicao delegate:self];
}

- (IBAction)cadastrarClicado:(UIButton *)sender {
    // Preparar uma requisição
    // Body: usuario&senha
    NSURL *url = [NSURL URLWithString:@"http://fernandopastor.sitepessoal.com/aula/cadastrar.php"];
    
    NSString *body = [NSString stringWithFormat:@"usuario=%@&senha=%@",self.campoUsuario.text,self.campoSenha.text];
    
    NSMutableURLRequest *requisicao = [[NSMutableURLRequest alloc] initWithURL:url];
    requisicao.HTTPMethod = @"POST";
    requisicao.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // Enviar a requisição, via conexão
    [NSURLConnection connectionWithRequest:requisicao delegate:self];
    
}

// Chamado no início da conexão, quando o server inicia o envio de pacotes
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.dadosRecebidos = [NSMutableData new];
}

// Chamado para cada pacote recebido
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data.length > 0) {
        [self.dadosRecebidos appendData:data];
    }
}

// Chamado quando todos os pacotes foram recebidos. Conexão fecha
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *resposta = [[NSString alloc] initWithData:self.dadosRecebidos encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", resposta);
    
    if ([resposta isEqualToString:@"Usuario cadastrado"]) {
        [[[UIAlertView alloc] initWithTitle:@"Cadastro" message:@"Usuário cadastrado com sucesso!" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
    else if ([resposta isEqualToString:@"Erro ao cadastrar"]){
        [[[UIAlertView alloc] initWithTitle:@"Cadastro" message:@"Erro ao cadastrar usuário!" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
    else if ([resposta isEqualToString:@"OK"]){
        [self performSegueWithIdentifier:@"loginok" sender:nil];
    }
    else if ([resposta isEqualToString:@"Senha invalida"]){
        [[[UIAlertView alloc] initWithTitle:@"Login" message:@"Senha não confere!" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
    else if ([resposta isEqualToString:@"Usuario nao encontrado"]){
        [[[UIAlertView alloc] initWithTitle:@"Login" message:@"Usuário não cadastrado!" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
    else {
        
    }
    
    // resignFirstResponder para todas as views na tela
    [self.view endEditing:YES];
}


@end
