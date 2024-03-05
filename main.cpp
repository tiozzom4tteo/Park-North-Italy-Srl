#include "progetto.h"

int main(int argc, char *argv[])
{

    cout << " Start " << endl;

    char conninfo[250];

    PGconn *conn = connection(conninfo);

    PGresult *res;

    int x = 0;

    while (x != 3)
    {
        cout << " Scegliere tra le seguenti opzioni:\n\t"
             << "1) Visualizzare l'elenco delle query possibili\n\t"
             << "2) Effettuare una query\n\t"
             << "3) Chiudere il programma\n\t"
             << "Opzione: ";
        cin >> x;

        if (x == 1)
        {
            elenco();
        }
        else if (x == 2)
        {
            chiamata(conn, res);
        }
        else if (x != 1 && x != 2 && x != 3)
        {
            cout << " Valore non valido.\n"
                 << endl;
        }
    }

    cout << " Thanks for use, goodbye! " << endl;

    PQfinish(conn);

    return 0;
}