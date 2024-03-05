#include "dependencies/include/libpq-fe.h"
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <iomanip>

#define PG_HOST "127.0.0.1"
#define PG_USER "postgres"
#define PG_DB "Progetto"
#define PG_PASS "ciao"
#define PG_PORT 5432

using std::cin;
using std::cout;
using std::endl;
using std::left;
using std::setw;
using std::string;

PGconn *connection(char *conninfo);

void printIntestazione(int campi, PGresult *res);

void printValue(int tuple, int campi, PGresult *res);

void checkResults(PGresult *res, const PGconn *conn);

void checkPrint(const PGconn *conn, PGresult *res);

void elenco();

void chiamata(PGconn *conn, PGresult *res);

void listaFoglie(PGconn *conn, PGresult *res);

void listaTour(PGconn *conn, PGresult *res);

void listaDipendenti(PGconn *conn, PGresult *res);

void idAnimali(PGconn *conn, PGresult *res);

void idPiante(PGconn *conn, PGresult *res);

void idOrganizzatori(PGconn *conn, PGresult *res);

void nomiParchi(PGconn *conn, PGresult *res);

void listaEntita(PGconn *conn, PGresult *res);

void popolamentoEta(PGconn *conn, PGresult *res);

void dietaAnimale(PGconn *conn, PGresult *res);

void fabbisognoIdricoPianta(PGconn *conn, PGresult *res);

void posizionePianta(PGconn *conn, PGresult *res);

void countTipoFoglie(PGconn *conn, PGresult *res);

void clientiAllEvento(PGconn *conn, PGresult *res);

void guideTour(PGconn *conn, PGresult *res);

void guadagnoSup(PGconn *conn, PGresult *res);

void ridotti(PGconn *conn, PGresult *res);

void trapiantoData(PGconn *conn, PGresult *res);

void nomeLatino(PGconn *conn, PGresult *res);

void mediaStipendi(PGconn *conn, PGresult *res);

void soldi(PGconn *conn, PGresult *res);

void caratteristica(PGconn *conn, PGresult *res);