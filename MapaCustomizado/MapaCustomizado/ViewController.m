//
//  ViewController.m
//  MapaCustomizado
//
//  Created by Daniel Arndt Alves on 3/16/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MKPointAnnotation *pino = [MKPointAnnotation new];
    pino.coordinate = CLLocationCoordinate2DMake(-23.581410, -46.683736);
    
    pino.title = @"iai?";
    pino.subtitle = @"Instituto de Artes Interativas";
    
    [self.mapa addAnnotation:pino];
    
    [self.mapa setRegion:MKCoordinateRegionMake(pino.coordinate, MKCoordinateSpanMake(0.0001, 0.0001))];
    
    // Overlay - Círculos, Linhas e Polígonos
    
    // Círculo
    MKCircle *circulo = [MKCircle circleWithCenterCoordinate:pino.coordinate radius:50];
    [self.mapa addOverlay:circulo];
    
    // Linha
    CLLocationCoordinate2D arrayPontosLinha[2];
    arrayPontosLinha[0] = CLLocationCoordinate2DMake(-23.581786, -46.683993);
    arrayPontosLinha[1] = CLLocationCoordinate2DMake(-23.580640, -46.682287);
    
    MKPolyline *linha = [MKPolyline polylineWithCoordinates:arrayPontosLinha count:2];
    [self.mapa addOverlay:linha];
    
    // Polígono
    CLLocationCoordinate2D arrayPontosPoligono[3];
    arrayPontosPoligono[0] = CLLocationCoordinate2DMake(-23.582054, -46.683853);
    arrayPontosPoligono[1] = CLLocationCoordinate2DMake(-23.582740, -46.683770);
    arrayPontosPoligono[2] = CLLocationCoordinate2DMake(-23.582604, -46.683480);
    
    MKPolygon *poligono = [MKPolygon polygonWithCoordinates:arrayPontosPoligono count:3];
    [self.mapa addOverlay:poligono];
    
    
    // Como traçar rota no mapa
    CLLocationCoordinate2D minhaCasa = CLLocationCoordinate2DMake(-23.553686, -46.551188);
    MKPlacemark *iaiPlace = [[MKPlacemark alloc] initWithCoordinate:pino.coordinate addressDictionary:nil];
    MKPlacemark *casaPlace = [[MKPlacemark alloc] initWithCoordinate:minhaCasa addressDictionary:nil];
    
    // criando a requisição de busca
    MKDirectionsRequest *requisicao = [MKDirectionsRequest new];
    
    // setando a origem
    requisicao.source = [[MKMapItem alloc] initWithPlacemark:iaiPlace];
    
    // setando o destino
    requisicao.destination = [[MKMapItem alloc] initWithPlacemark:casaPlace];
    
    // Configurando o tipo de transporte
    requisicao.transportType = MKDirectionsTransportTypeWalking;
    
    MKDirections *roteador = [[MKDirections alloc] initWithRequest:requisicao];
    
    // Mandar calcular a rota e quando terminar, executar o bloco
    [roteador calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            // dentro do parâmetro response, temos a rota em questão
            MKRoute *rota = [response.routes firstObject];
            [self.mapa addOverlay:rota.polyline];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Método acionado quando um pino é adicionado no mapa com a intenção de nos possibilitar mudar o layout do pino
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // Devemos retornar um MKLayoutView que representa o layoute do pino. Percebam que recebemos um MKAnnotation pelo parâmetro, que são os dados de onde o pino foi colocado
    MKAnnotationView *pinoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil
                                  ];
    pinoView.image = [UIImage imageNamed:@"pin"];
    
    // Quando customizamos o pino, as informações deixam de aparecer
    pinoView.canShowCallout = YES;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    imgv.image = [UIImage imageNamed:@"casa_bola.jpeg"];
    
    pinoView.leftCalloutAccessoryView = imgv;
    
    UIButton *botaoAcessorio = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [botaoAcessorio addTarget:self action:@selector(irParaDetalhe) forControlEvents:UIControlEventTouchUpInside];
    
    pinoView.rightCalloutAccessoryView = botaoAcessorio;
    
    return pinoView;
}

-(void) irParaDetalhe {
    // disparar o segue
    [self performSegueWithIdentifier:@"segueDetalhe" sender:nil];
}

// Método adicionado para definir o layout do overlay que vai ser exibido
// Estamos recebendo um overlay que não sabemos se é círculo, linha ou polígono
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        // Circulo
        MKCircleRenderer *circulo = [[MKCircleRenderer alloc]initWithOverlay:overlay];
        circulo.lineWidth = 3;
        circulo.strokeColor = [UIColor redColor];
        circulo.fillColor = [UIColor redColor];
        circulo.alpha = 0.3;
        return circulo;
    }
    else if ([overlay isKindOfClass:[MKPolyline class]]) {
        // Linha
        MKPolylineRenderer *linha = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        linha.lineWidth = 3;
        linha.strokeColor = [UIColor blueColor];
        
        return linha;
    }
    else if ([overlay isKindOfClass:[MKPolygon class]]) {
        // Polígono
        MKPolygonRenderer *poligono = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        poligono.lineWidth = 3;
        poligono.strokeColor = [UIColor orangeColor];
        poligono.fillColor = [UIColor orangeColor];
        poligono.alpha = 0.3;
        
        return poligono;
    }
    return nil;
}

@end
