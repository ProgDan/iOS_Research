//
//  ViewController.m
//  WebService
//
//  Created by Daniel Arndt Alves on 3/22/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoConversao;
- (IBAction)tipoConversaoMudouValor:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITextField *campoTemperatura;
@property (weak, nonatomic) IBOutlet UILabel *resultado;

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

- (IBAction)tipoConversaoMudouValor:(UISegmentedControl *)sender {
}

// Botão RETURN do teclado
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSURL *urlServico = [NSURL URLWithString:@"http://webservices.daehosting.com/services/TemperatureConversions.wso"];

    // Montar a requisição
    NSMutableURLRequest *requisicao = [[NSMutableURLRequest alloc]initWithURL:urlServico];
    
    requisicao.HTTPMethod=@"POST";
    
    // HEADER
    [requisicao setValue:@"webservices.daehosting.com" forHTTPHeaderField:@"Host"];
    [requisicao setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [requisicao setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    
    // BODY
    NSString *bodyRequisicao;
    
    if (self.tipoConversao.selectedSegmentIndex == 0) {
        // C => F
        bodyRequisicao = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n<soap:Body>\n<CelciusToFahrenheit xmlns=\"http://webservices.daehosting.com/temperature\">\n<nCelcius>%@</nCelcius>\n</CelciusToFahrenheit>\n</soap:Body>\n</soap:Envelope>", self.campoTemperatura.text];
    }
    else {
        // F => C
        bodyRequisicao = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n<soap:Body>\n<FahrenheitToCelcius xmlns=\"http://webservices.daehosting.com/temperature\">\n<nFahrenheit>%@</nFahrenheit>\n</FahrenheitToCelcius>\n</soap:Body>\n</soap:Envelope>", self.campoTemperatura.text];
    }
    
    requisicao.HTTPBody = [bodyRequisicao dataUsingEncoding:NSUTF8StringEncoding];
    
    // Enviar a requisição via conexão
    [NSURLConnection connectionWithRequest:requisicao delegate:self];
    
    // Aguardar a resposta por delegate
    
    
    return YES;
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
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.dadosRecebidos];
    parser.delegate = self;
    [parser parse];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"m:CelciusToFahrenheitResult"] ||
        [elementName isEqualToString:@"m:FahrenheitToCelciusResult"]) {
        self.resultado.text = nil;
        self.resultadoWeb = nil;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"m:CelciusToFahrenheitResult"] ||
        [elementName isEqualToString:@"m:FahrenheitToCelciusResult"]) {
        self.resultado.text = self.resultadoWeb;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.resultadoWeb = string;
    NSLog(@"Resultado: %@", self.resultadoWeb);
}

@end
