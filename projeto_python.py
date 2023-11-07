<<<<<<< HEAD
def cadastro
=======
import psycopg2
import PySimpleGUI as sg



con = psycopg2.connect(host = 'localhost', database = 'projeto_integrador_g2', 
                       user = 'postgres', password = 'thor1234')


def limpar():
    window['-cod_cliente-'].update('')
    window['-nome_cliente-'].update('')
    window['-cpf_cliente-'].update('')
    window['-end_cliente-'].update('')
    window['-data_nasci_cliente-'].update('')
    window['-email_cliente-'].update('')
    window['-telefone_cliente-'].update('')
    window['-sexo_cliente-F-'].update(True)
    
    
def atualiza():
    if len(lista) == 0:
        limpar()
    else:
        window['-cod_cliente-'].update( lista[indice][0] )
        window['-nome_cliente-'].update( lista[indice][1] )
        window['-cpf_cliente-'].update( lista[indice][2] )
        window['-end_cliente-'].update( lista[indice][3] )
        window['-data_nasci_cliente-'].update( lista[indice][4] )
        window['-email_cliente-'].update( lista[indice][5] )
        window['-telefone_cliente-'].update( lista[indice][6] )
        if lista[indice][7]: 
            window['-sexo_cliente-M-'].update(True)
        else: 
            window['-sexo_cliente-F-'].update(True)
        

def todos():
    global indice
    global lista
    resposta = []
    with con:
        with con.cursor() as cursor:
            cursor.execute("SELECT * FROM cliente;")
            resposta = cursor.fetchall()
    lista.clear()
    for i in range(len(resposta)):
        lista.append( list(resposta[i]) )
        lista[i][7] = True if lista[i][7] == 'M' else False
        listaString += str(i+1) +') ' + resposta[i][1] + '\n'
        
    sg.popup('Quantidade de registros: ' + str(len(resposta)))
    indice = 0
    atualiza()

# Inicialização BD
con = psycopg2.connect(host = 'localhost', database = 'projeto_integrador_g2', 
                       user = 'postgres', password = 'thor1234')



# tirar isso aqui....
with con:
    with con.cursor() as cursor:
        cursor.execute("""CREATE TABLE IF NOT EXISTS cliente (
            Cod_cliente INTEGER PRIMARY KEY UNIQUE NOT NULL,
            Nome_cliente VARCHAR(50) NOT NULL,
            cpf_cliente NUMERIC(11) NOT NULL,
            data_nasci_cliente DATE NOT NULL,
            end_cliente VARCHAR(80),
            email_cliente VARCHAR(50),
            telefone_cliente NUMERIC(13),
            sexo_cliente CHAR(1) CHECK (sexo_cliente IN ('M','F')));
            """)

lista=[]
indice = 0

layout = [    
    [
        sg.Text("Cod_cliente:", size=(8, 1)),
        sg.InputText(size=(6, 1), key="-cod_cliente-", focus=False)
    ],
    [
        sg.Text("Nome_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-nome_cliente-", focus=True)
    ],
    [
        sg.Text("cpf_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-cpf_cliente-")
    ],
    [
        sg.Text("data_nasci_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-data_nasci_cliente-")
    ],
    [
        sg.Text("end_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-end_cliente-")
    ],
    [
        sg.Text("email_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-email_cliente-")
    ],
    [
        sg.Text("telefone_cliente:", size=(8, 1)),
        sg.InputText(size=(40, 1), key="-telefone_cliente-")
    ], 
    [
        sg.Text("sexo_cliente:", size=(8, 1)),
        sg.Radio('Masculino', 'GRUPO1', default=False, key="-sexo_cliente-M-"),
        sg.Radio('Feminino', 'GRUPO1', default=True, key="-sexo_cliente-F-")
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


    
window = sg.Window("Cadastro", layout, use_default_focus=False)

while True:
    event, values = window.read()

    if event == sg.WIN_CLOSED:
        break
    elif event == "-LIMPAR-":
        limpar()
    elif event == "-INSERIR-":    ### retirar  (cod_cliente, nome_cliente, cpf_cliente, data_nasci_cliente, end_cliente, email_cliente, telefone_cliente, sexo_cliente)
        with con:
            with con.cursor() as cursor:
                cursor.execute("INSERT INTO cliente (cod_cliente, nome_cliente, cpf_cliente, data_nasci_cliente, end_cliente, email_cliente, telefone_cliente, sexo_cliente) VALUES (%s, %s, %s, %s, %s, %s, %s, %s);",
                    (values['-cod_cliente-'], values['-nome_cliente-'], values['-cpf_cliente-'], values['-data_nasci_cliente-'], values['-end_cliente-'], values['-email_cliente-'], values['-telefone_cliente-'], ('M' if values['-sexo_cliente-M-'] else 'F')))
        limpar()
    elif event == "-ATUALIZAR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("UPDATE cliente SET nome_cliente = %s, cpf_cliente = %s, cpf_cliente = %s, cpf_cliente = %s, cpf_cliente = %s, cpf_cliente = %s WHERE cod_cliente = %s",
                    (values['-nome_cliente-'], values['-cpf_cliente-'], values['-data_nasci_cliente-'], values['-end_cliente-'], values['-email_cliente-'], values['-telefone_cliente-'], values['-genero-'], values['-cod_cliente-']))
        lista[indice] = [values['-cod_cliente-'], values['-nome_cliente-'], values['-cpf_cliente-'], values['-data_nasci_cliente-'], values['-end_cliente-'], values['-email_cliente-'], values['-telefone_cliente-'], ('M' if values['-sexo_cliente-M-'] else 'F')]  
       
    elif event == "-REMOVER-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("DELETE FROM cliente WHERE cod_cliente = %s", (values['-cod_cliente-'],))
        lista.pop(indice)
        indice -= 1
        atualiza()
    elif event == "-PROCURAR-":
        with con:
            with con.cursor() as cursor:
                cursor.execute("SELECT * FROM cliente WHERE cpf_cliente LIKE %s;",
                    ('%'+values['-cpf_cliente-']+'%',))
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
>>>>>>> 8a940b8b6bf632f1c40543e1d72a26e772c7ed8f
