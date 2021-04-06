with open("entrada.txt","r") as arquivo:
    linhas = arquivo.readlines()

# print(linhas)
disciplinas = []
frequencias = []
revisoes = []
tabela = ''

for linha in linhas:
    linha = linha.replace('\n', '')
    # print(repr(linha))
    if (linha == 'Disciplinas'):
        tabela = linha
        continue
    elif(linha == 'Frequencias'):
        tabela = linha
        continue
    elif(linha == 'Revisoes'):
        tabela = linha
        continue
    elif(linha == 'Logs'):
        tabela = linha
        continue

    # print(tabela)
    if (tabela == 'Disciplinas'):
        disciplinas.append(linha)
    elif(tabela == 'Frequencias'):
        frequencias.append(linha)
    elif(tabela == 'Revisoes'):
        # print(linha.split(','))
        revisoes.append(linha.split(';'))


json_tabelas = '[["disciplina","frequencia","revisao","logRevisao"],'

id = 1
json_disciplinas = ''
for disc in disciplinas:
    # print(json_disciplinas)
    json_disciplinas += '{"id": ' + str(id) + ',"nome":"' + disc + '"},'
    id += 1
json_disciplinas = json_disciplinas[:-1]

id = 1
json_frequencias = ''
for freq in frequencias:
    # print(json_frequencias)
    json_frequencias += '{"id": ' + str(id) + ',"valorFrequencia":"' + freq + '"},'
    id += 1
json_frequencias = json_frequencias[:-1]

id = 1
json_revisoes = ''
for rev in revisoes :
    # print(json_revisoes)
    # print(rev)
    idDisciplina = disciplinas.index(rev[0]) + 1
    idFrequencia = frequencias.index(rev[1]) + 1
    json_revisoes += '{"id":' + str(id) + ',"idDisciplina":' + str(idDisciplina) + ',"idFrequencia":' + str(idFrequencia) + ',"nome":"' + rev[2] + '","vezesRevisadas":' + rev[3] + ',"dataCadastro":"' + rev[4] + '","proxRevisao":"' + rev[5] + '","isArchived":0},'
    id += 1
json_revisoes = json_revisoes[:-1]


# print(json_tabelas)
# print(json_disciplinas)
# print(json_frequencias)
# print(json_revisoes)

json_entradas = json_tabelas + '[[' + json_disciplinas + '],' + '[' + json_frequencias + '],' + '[' + json_revisoes + '],[]]]'


with open("saida.txt","w") as arquivo:
    arquivo.write(json_entradas)
