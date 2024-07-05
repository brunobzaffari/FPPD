Projeto autoria de Bruno Bavaresco Zaffari e Leonardo Möllmann Schöller
Distributed computing game
Processamento Paralelo e Distribuído
Implementação de Jogo Multiplayer Usando Go e RPC
Professor: Marcelo Veiga Neves
Alunos: Bruno Bavaresco Zaffari e Leonardo Möllmann Schöller
Divisão dos arquivos:
 
O Programa se encontra dividido na seguinte forma:
Cmd: Contém o main de cliente e servidor
Internal/Cliente: Contém todas as funções relacionadas ao cliente
Internal/Server: Contém outras funções do servidor
Internal/Common:
•	Common.go: Contém as Elementos do mapa que serão usadas para ambos, clientes e servidor
•	Engine.go: Contem a lógica dos disparos usado pelo servidor
•	Rpc.go: Contem comandos RPC usados pelo servidor
Iniciar o programa:
1.	Altere o cliente para acessar o endereço correto do servidor, linha 108 em internal/cliente/cliente.go 
2.	Para iniciar o programa na pasta principal fppd-main rode o comando go run cmd/server.go e go run cmd/cliente.go
Programa:
Idempotencia: Para resolver essa questão de algum comando chegar antes de um enviado primeiro foi implementado a variável SequenceNumber. A cada envio de comando é acrecentado pelo cliente e serve para criar uma ordem de envio. Na parte do servidor o SendCommand confere com a última instancia e depois guarda, na representação da entidade que mandou o comando.
  
Interface:
Elementos estáticos da interface:
Para ambos os cliente e servidor, se supõem que eles têm uma versão do mapa guardada, disponível e igual. Pois ambos pegam e leem e dividem na variável mapa [][]Elementos, porem com finalidades diferentes. O servidor a utilizar para saber se as entidades (clientes e disparos) podem ou passar por elementos. O cliente usa o mapa para printar na tela.
Elementos dinâmicos da interface:
Para ter os elementos dinâmicos criamos na struct State(que contem mapa e elementos dinâmicos) um dicionário chamado Entidades que contem Entidade, cada entidade representa ou um personagem ou um projetil. Esse State.Entiries é passado para o cliente quando o cliente usa o comando GetState. Tanto no Cliente como no Servidor existem a Entities, contudo esta é criada no servidor à medida que personagens se registram e são efetuados disparos. Além disso, o uso é diferente, clientes usando para printar no mapa elementos dinâmicos, e o servidor usando para atualizar a posição dos elementos.
É importante salientar que o cliente induz a criação de sua Entity quando usa o comando RegisterClient, nesse momento também o servidor cria um ID único e retorna para o cliente. O ID será usado depois pelo cliente para saber como pintar o personagem do usuário, sendo azul para o user o seu personagem, e os que não tiverem o ID igual sendo retratados de vermelho(inimigo)
Projeteis:
Quando o cliente pressiona o ‘E’ é criado a Entity do projetil da mesma direção que o cliente se moveu pela ultima vez, pelo método PlayerFire. Para mover os projeteis a função SimulateShots() verifica a lista de entidades e quando for um projetil usa função MoveEntity() para os projeteis continuarem a mesma trajetória do que forem disparados, SimulateShots() também controla a colisão tanto de intersecção de projetos como com colisão de outros objetos

