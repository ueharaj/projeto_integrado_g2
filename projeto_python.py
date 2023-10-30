import psycopg2
import PySimpleGUI as sg



con = psycopg2.connect(host = 'localhost', database = 'thiago', 
                       user = 'postgres', password = 'Thor1234')


def limpar():
    window['-cod_cliente-'].update('')
    window['-nome_cliente-'].update('')
    window['-sobrenome_cliente-'].update('')
    

def atualiza():
    if len(lista) == 0:
        limpar()
    else:
        window['-cod_cliente-'].update( lista[indice][0] )
        window['-nome_cliente-'].update( lista[indice][1] )
        window['-sobrenome_cliente-'].update( lista[indice][2] )
        

def todos():
    global indice
    global lista
    resposta = []
    with con:
        with con.cursor() as cursor:
            cursor.execute("SELECT * FROM clientes;")
            resposta = cursor.fetchall()
    lista.clear()
    for i in range(len(resposta)):
        lista.append( list(resposta[i]) )

    sg.popup('Quantidade de registros: ' + str(len(resposta)))
    indice = 0
    atualiza()

# Inicialização BD
con = psycopg2.connect(host = 'localhost', database = 'thiago', 
                       user = 'postgres', password = 'Thor1234')
with con:
    with con.cursor() as cursor:
        cursor.execute("""CREATE TABLE IF NOT EXISTS clientes (
            cod_cliente INTEGER PRIMARY KEY UNIQUE NOT NULL,
            nome_cliente VARCHAR(20) NOT NULL,
            sobrenome_cliente VARCHAR(40) NOT NULL;""")

lista=[]
indice = 0

layout = [
    [
        sg.Text("cod_cliente:", size=(8, 1)),
        sg.InputText(size=(6, 1), key="-cod_cliente-", focus=False)
    ],
    [
        sg.Text("nome_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-nome_cliente-", focus=True)
    ],
    [
        sg.Text("sobrenome_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-sobrenome_cliente-")
    ],
    [
        sg.Button('Limpar', size=(8, 1), key="-LIMPAR-"),
        sg.Button('Inserir', size=(8, 1), key="-INSERIR-"),
        sg.Button('Atualizar', size=(8, 1), key="-ATUALIZAR-"),
        sg.Button('Remover', size=(8, 1), key="-REMOVER-")
    ],
    [
        sg.Button('<<', size=(8, 1), key="-<<-"),
        sg.Button('Procurar', size=(8, 1), key="-PROCURAR-"),
        sg.Button('Todos', size=(8, 1), key="-TODOS-"),
        sg.Button('>>', size=(8, 1), key="->>-")
    ]
]

window = sg.Window("thiago", layout, use_default_focus=False)

# Run the Event Loop
while True:
    event, values = window.read()

    if event == sg.WIN_CLOSED:
        break
    elif event == "-LIMPAR-":
        limpar()
    elif event == "-INSERIR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome_cliente) VALUES (%s, %s, %s);",
                    (values['-cod_cliente-'], values['-nome_cliente-'], values['-sobrenome_cliente-']))
        limpar()
    elif event == "-ATUALIZAR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("UPDATE clientes SET cod_cliente = %s, nome_cliente = %s, sobrenome_cliente = %s WHERE cod_cliente = %s",
                    (values['-cod_cliente-'], values['-nome_cliente-'], values['-sobrenome_cliente-']))
        lista[indice] = [values['-cod_cliente-'], values['-nome_cliente-'], values['-sobrenome_cliente-']]        
    elif event == "-REMOVER-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("DELETE FROM clientes WHERE cod_cliente = %s", (values['-cod_cliente-'],))
        lista.pop(indice)
        indice -= 1
        atualiza()
    elif event == "-PROCURAR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("SELECT * FROM clientes WHERE nome_cliente LIKE %s;",
                    ('%'+values['-nome_cliente-']+'%',))
                resposta = cursor.fetchall()
                lista.clear()
                for i in range(len(resposta)):
                    lista.append( list(resposta[i]) )
                sg.popup('Quantidade de registros: ' + str(len(resposta)))
                indice = 0
                atualiza()
    elif event == "-TODOS-":
        todos()
    elif event == "->>-":
        indice += 1
        if indice >= len(lista): indice = len(lista)-1
        atualiza()
    elif event == "-<<-":
        indice -= 1
        if indice <= 0: indice = 0
        atualiza()

window.close()
# Fazer as mudanças para a base persistente
con.commit()

# Fechar a comunicação com o servidor
cursor.close()
con.close()
