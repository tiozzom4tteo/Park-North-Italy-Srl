#include "progetto.h"

PGconn *connection(char *conninfo)
{

    sprintf(conninfo, " user =%s password =%s dbname =%s hostaddr =%s port =%d", PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);

    PGconn *conn = PQconnectdb(conninfo);

    if (PQstatus(conn) != CONNECTION_OK)
    {
        cout << " Errore di connessione \n"
             << PQerrorMessage(conn);
        PQfinish(conn);
        exit(1);
    }

    cout << " Connessione avvenuta correttamente\n " << endl;

    return conn;
}

void checkResults(PGresult *res, const PGconn *conn)
{
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        cout << " Risultati inconsistenti\n " << PQerrorMessage(conn);
        PQclear(res);
        exit(1);
    }
}

void checkPrint(const PGconn *conn, PGresult *res)
{

    checkResults(res, conn);

    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    for (int i = 0; i < campi; ++i)
    {
        cout << left << setw(30) << PQfname(res, i);
    }
    cout << "\n\n";
    for (int i = 0; i < tuple; ++i)
    {
        for (int n = 0; n < campi; ++n)
        {
            cout << left << setw(30) << PQgetvalue(res, i, n);
        }
        cout << '\n';
    }
    cout << '\n'
         << endl;

    PQclear(res);
}

void elenco()
{
    cout << "\n Query possibili:\n\t"
         << "1) Liste delle entità principali\n\t"
         << "2) Conteggio del popolamento animale per eta'\n\t"
         << "3) Trova la dieta di un animale dato l'ID\n\t"
         << "4) Trova il fabbisogno idrico di una pianta dato l'ID\n\t"
         << "5) Trova la posizione, l'area e il parco dove si trova una pianta dato l'ID\n\t"
         << "6) Conteggio delle piante dato il tipo di foglie\n\t"
         << "7) Trova la lista dei clienti che partecipa ad un evento dato l'ID dell'organizzatore\n\t"
         << "8) Trova le guide dei tour guidati dato il tipo di tour interessato\n\t"
         << "9) Trova i dipendenti con stipendio superiore a quello dato, in ordine decrescente\n\t"
         << "10) Trova quanti biglietti (evento e tour) ridotti sono stati acquistati\n\t"
         << "11) Trova le piante trapiantate precedentemente una specifica data\n\t"
         << "12) Trova il nome latino di un'animale o di una painta dato l'ID\n\t"
         << "13) Calcola della media degli stipendi dei dipendenti di un dato parco\n\t"
         << "14) Calcola il totale dei soldi guadagnati dai biglietti suddivisi per tipo e la somma totale di un dato parco\n\t"
         << endl;
}

void chiamata(PGconn *conn, PGresult *res)
{
    int x;
    cout << "\n Quale query si vuole eseguire? ";
    cin >> x;

    switch (x)
    {
    case 1:
        listaEntita(conn, res);
        break;
    case 2:
        popolamentoEta(conn, res);
        break;
    case 3:
        dietaAnimale(conn, res);
        break;
    case 4:
        fabbisognoIdricoPianta(conn, res);
        break;
    case 5:
        posizionePianta(conn, res);
        break;
    case 6:
        countTipoFoglie(conn, res);
        break;
    case 7:
        clientiAllEvento(conn, res);
        break;
    case 8:
        guideTour(conn, res);
        break;
    case 9:
        guadagnoSup(conn, res);
        break;
    case 10:
        ridotti(conn, res);
        break;
    case 11:
        trapiantoData(conn, res);
        break;
    case 12:
        nomeLatino(conn, res);
        break;
    case 13:
        mediaStipendi(conn, res);
        break;
    case 14:
        soldi(conn, res);
        break;

    default:
        cout << "\n Valore inserito non presente."
             << endl;
        chiamata(conn, res);
        break;
    }
}

void listaFoglie(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT DISTINCT tipoFoglie FROM Pianta");
    checkPrint(conn, res);
}

void listaTour(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT DISTINCT tipoTour FROM TourGuidato");
    checkPrint(conn, res);
}

void listaDipendenti(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT DISTINCT tipoDipendente FROM Dipendente");
    checkPrint(conn, res);
}

void idAnimali(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT id AS id_animale FROM Animale");
    checkPrint(conn, res);
}

void idPiante(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT id AS id_pianta FROM Pianta");
    checkPrint(conn, res);
}

void idOrganizzatori(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT organizzatore FROM Evento");
    checkPrint(conn, res);
}

void nomiParchi(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT nome FROM Parco");
    checkPrint(conn, res);
}

void listaEntita(PGconn *conn, PGresult *res)
{
    int x;
    cout << "\n Scegliere di quale entita si vuole visualizzare la lista: \n\t1) Parchi\n\t2) Aree\n\t3) Animali\n\t4) Piante\n\t5) Evento\n\t6) Tour\n\t7) Clienti\n\t8) Dipendenti\n";
    cin >> x;

    switch (x)
    {
    case 1:
        res = PQexec(conn, "SELECT nome, luogo FROM Parco");
        break;
    case 2:
        res = PQexec(conn, "SELECT id, nome, parco FROM Area");
        break;
    case 3:
        res = PQexec(conn, "SELECT id, nomeLatino FROM Animale");
        break;
    case 4:
        res = PQexec(conn, "SELECT id, nomeLatino FROM Pianta");
        break;
    case 5:
        res = PQexec(conn, "SELECT id, data, tipoEvento FROM Evento");
        break;
    case 6:
        res = PQexec(conn, "SELECT id, data, tipoTour FROM TourGuidato");
        break;
    case 7:
        res = PQexec(conn, "SELECT codiceFiscale, cognome, nome FROM Cliente");
        break;
    case 8:
        res = PQexec(conn, "SELECT id, cognome, nome, tipoDipendente FROM Dipendente");
        break;
    default:
        cout << "\n Il numero selezionato non corrisponde a nessuna entita'\n"
             << endl;
        listaEntita(conn, res);
        break;
    }
    checkPrint(conn, res);
}

void popolamentoEta(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT età, COUNT(età) FROM Animale GROUP BY età ORDER BY count ASC");
    checkPrint(conn, res);
}

void dietaAnimale(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista degli id degli animali: \n"
         << endl;

    idAnimali(conn, res);

    string query = "SELECT id, nomeLatino, alimentazione FROM Animale WHERE (id= $1::varchar)";
    PGresult *stmt = PQprepare(conn, "Alimentazione", query.c_str(), 1, NULL);

    string id_animale;
    cout << "\n Inserisci l'ID dell'animale: ";
    cin >> id_animale;

    const char *par = id_animale.c_str();

    res = PQexecPrepared(conn, "Alimentazione", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void fabbisognoIdricoPianta(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista degli id delle piante:\n"
         << endl;

    idPiante(conn, res);

    string query = "SELECT id, nomeLatino, acquaNecessaria FROM Pianta WHERE (id= $1::varchar)";
    PGresult *stmt = PQprepare(conn, "Fabbisogno-Idrico", query.c_str(), 1, NULL);

    string id_pianta;
    cout << "\n Inserisci l'ID della pianta: ";
    cin >> id_pianta;

    const char *par = id_pianta.c_str();

    res = PQexecPrepared(conn, "Fabbisogno-Idrico", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void posizionePianta(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista degli id delle piante:\n"
         << endl;

    idPiante(conn, res);

    string query = "SELECT p.id, p.nomelatino, p.locazione, p.area, a.parco FROM Pianta AS p, Area AS a WHERE (p.area = a.id AND p.id = $1::varchar)";
    PGresult *stmt = PQprepare(conn, "Posizione-Pianta", query.c_str(), 1, NULL);

    string id_pianta;
    cout << "\n Inserisci l'ID della pianta: ";
    cin >> id_pianta;

    const char *par = id_pianta.c_str();

    res = PQexecPrepared(conn, "Posizione-Pianta", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void countTipoFoglie(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista dei tipi di foglie:\n"
         << endl;
    listaFoglie(conn, res);

    string query = "SELECT tipoFoglie, COUNT(id) as Numero_Piante FROM Pianta WHERE (tipoFoglie = $1::enumFoglie) GROUP BY tipoFoglie";
    PGresult *stmt = PQprepare(conn, "Conteggio-Tipo-Foglie", query.c_str(), 1, NULL);

    string tipo_foglia;
    cout << "\n Inserisci il tipo di foglie della pianta: ";
    cin >> tipo_foglia;

    const char *par = tipo_foglia.c_str();

    res = PQexecPrepared(conn, "Conteggio-Tipo-Foglie", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void clientiAllEvento(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista degli id degli organizzatori:\n"
         << endl;

    idOrganizzatori(conn, res);

    string query = "SELECT c.nome, c.cognome FROM Cliente AS c, BigliettoEvento AS b, Evento AS e WHERE (c.codiceFiscale = b.codiceFiscaleCliente AND b.evento = e.id AND e.organizzatore = $1::int)";
    PGresult *stmt = PQprepare(conn, "Clienti-Evento-Organizzatore", query.c_str(), 1, NULL);

    string id_organizzatore;
    cout << "\n Inserisci l'ID di un organizzatore: ";
    cin >> id_organizzatore;

    const char *par = id_organizzatore.c_str();

    res = PQexecPrepared(conn, "Clienti-Evento-Organizzatore", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void guideTour(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista dei tipi di Tour Guidato:\n"
         << endl;
    listaTour(conn, res);

    string query = "SELECT DISTINCT d.id, d.nome, d.cognome FROM Dipendente AS d, Spiega AS s, TourGuidato AS t WHERE (d.id = s.dipendente AND s.tour = t.id AND t.tipoTour = $1::enumTour)";
    PGresult *stmt = PQprepare(conn, "GuidaTour", query.c_str(), 1, NULL);

    string tipoTour;
    cout << "\n Inserisci il tipo di tour: ";
    cin >> tipoTour;

    const char *par = tipoTour.c_str();

    res = PQexecPrepared(conn, "GuidaTour", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void guadagnoSup(PGconn *conn, PGresult *res)
{
    string query = "SELECT id, nome, tipoDipendente, guadagno FROM Dipendente WHERE (guadagno > $1::int) ORDER BY guadagno DESC";
    PGresult *stmt = PQprepare(conn, "Guadagno-Superiore", query.c_str(), 1, NULL);

    string stipendio;
    cout << "\n Inserisci il valore dello stipendio: ";
    cin >> stipendio;

    const char *par = stipendio.c_str();

    res = PQexecPrepared(conn, "Guadagno-Superiore", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void ridotti(PGconn *conn, PGresult *res)
{
    res = PQexec(conn, "SELECT COUNT(*)AS Ridotti FROM (SELECT id FROM BigliettoEvento WHERE ridotto = true UNION SELECT id FROM BigliettoTour WHERE ridotto = true) AS r");
    checkPrint(conn, res);
}

void trapiantoData(PGconn *conn, PGresult *res)
{
    string query = "SELECT id, nomeLatino, locazione FROM Pianta WHERE (dataTrapianto < $1::timestamp)";
    PGresult *stmt = PQprepare(conn, "Trapianto-Data", query.c_str(), 1, NULL);

    string data;
    cout << "\n Inserisci una data [yyyy-mm-dd]: ";
    cin >> data;

    const char *par = data.c_str();

    res = PQexecPrepared(conn, "Trapianto-Data", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void nomeLatino(PGconn *conn, PGresult *res)
{

    cout << "\n Si vuole sapere il nome latino di un animale o di una pianta ";

    string query, id;
    cout << "\n Ecco la lista degli id degli animali e delle piante:\n"
         << endl;

    idAnimali(conn, res);
    cout << "\n";
    idPiante(conn, res);

    cout << "\n Inserisci un'ID: ";
    cin >> id;

    query = "SELECT nomeLatino FROM Animale WHERE (Animale.id = $1::varchar) UNION SELECT nomeLatino FROM Pianta WHERE (Pianta.id = $1::varchar)";

    PGresult *stmt = PQprepare(conn, "Nome-Latino", query.c_str(), 1, NULL);

    const char *par = id.c_str();

    res = PQexecPrepared(conn, "Nome-Latino", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void mediaStipendi(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista dei nomi dei parchi:\n"
         << endl;

    nomiParchi(conn, res);

    string query = "SELECT parco, AVG(guadagno) FROM Dipendente GROUP BY parco HAVING (parco = $1::varchar)";
    PGresult *stmt = PQprepare(conn, "Media-Stipendi", query.c_str(), 1, NULL);

    string nome;
    cout << "\n Inserisci il nome del parco d'interesse: ";
    getline(cin >> std::ws, nome);

    const char *par = nome.c_str();

    res = PQexecPrepared(conn, "Media-Stipendi", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}

void soldi(PGconn *conn, PGresult *res)
{
    cout << "\n Ecco la lista dei nomi dei parchi:\n"
         << endl;

    nomiParchi(conn, res);

    string nome;
    cout << "\n Inserisci il nome del parco d'interesse: ";
    getline(cin >> std::ws, nome);

    const char *par = nome.c_str();

    cout << "\n Tour Guidati: \n"
         << endl;

    string query = "SELECT tour, SUM(prezzo) AS somma FROM bigliettoTour WHERE (parco = $1::varchar) GROUP BY prezzo, tour ORDER BY somma DESC";
    PGresult *stmt = PQprepare(conn, "Soldi-Tour", query.c_str(), 1, NULL);

    res = PQexecPrepared(conn, "Soldi-Tour", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);

    cout << "\n Eventi: \n"
         << endl;

    query = "SELECT evento, SUM(prezzo) AS somma FROM bigliettoEvento WHERE (parco = $1::varchar) GROUP BY prezzo, evento ORDER BY somma DESC";
    stmt = PQprepare(conn, "Soldi-Evento", query.c_str(), 1, NULL);

    res = PQexecPrepared(conn, "Soldi-Evento", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);

    cout << "\n Totale: \n"
         << endl;

    query = "SELECT SUM(prezzo) AS totale FROM (SELECT prezzo FROM BigliettoTour WHERE parco = $1::varchar UNION ALL SELECT prezzo FROM BigliettoEvento WHERE parco = $1::varchar) AS u;";
    stmt = PQprepare(conn, "Soldi-Totali", query.c_str(), 1, NULL);

    res = PQexecPrepared(conn, "Soldi-Totali", 1, &par, NULL, 0, 0);
    checkPrint(conn, res);
}