#import "cover.typ": cover
#import "template.typ": *
#import "utils.typ": *

#show: project

#cover(title: "BLOOMIFY", authors: (
  (name: "Gonçalo Alves", number: "a104079"), 
  (name: "João Cunha", number: "a104611"), 
  (name: "João Sá", number: "a104612"),
  (name: "Rodrigo Ferreira", number: "a104531")), 
  "Novembro, 2024")

#set page(numbering: "i", number-align: center)
#counter(page).update(1)

#set par(
  first-line-indent: 0.65em,
  justify: true,
)

#heading(numbering: none, outlined: false)[Resumo]
#h(0.65em)Uma aplicação _software_ consiste num programa computacional desenvolvido para auxiliar o utilizador na gestão eficiente de processos produtivos, atendendo, assim, às suas necessidades específicas. Em comparação com métodos manuais de gestão, este software revela-se mais eficaz devido à sua capacidade de rápida procura e organização de informações.

O objetivo deste projeto é criar uma ferramenta que permita ao utilizador gerir o processo de produção de vasos auto-irrigáveis. A aplicação foi projetada para oferecer um acompanhamento detalhado das etapas de montagem, assegurando a fiabilidade na gestão de encomendas e na monitorização do progresso da produção. Além disso, a ferramenta facilita a identificação dos componentes necessários, contribuindo para uma montagem mais organizada e eficiente.

O sistema proporciona fácil acesso a informações sobre cada fase do processo produtivo, permitindo que os utilizadores acompanhem o estado dos produtos em tempo real. A interface intuitiva torna a utilização da aplicação acessível a todos, promovendo uma experiência eficaz na gestão da linha de montagem.  

\

*Área de Aplicação*: Desenvolvimento de um sistema auto-irrigável para as plantas.


*Palavras-Chave*: C\#, SQL Server, Microsoft, Bases de Dados Relacionais, Aplicação, Plantas, Vasos Auto-irrigáveis, Sistema de Software, Engenharia de Software, Bloomify, IDE Visual Studio.

#show outline: it => {
    show heading: set text(size: 18pt)
    it
}

#{
  show outline.entry.where(level: 1): it => {
    v(5pt)
    strong(it)
  }

  outline(
    title: [Índice], 
    indent: true,
    depth: 2
  )
}

#v(-0.4em)
#outline(
  title: none,
  target: figure.where(kind: "attachment"),
  indent: n => 1em,
)

#outline(
  title: [Lista de Figuras],
  target: figure.where(kind: image),
)

#outline(
  title: [Lista de Tabelas de Casos de Uso],
  target: figure.where(kind: "use-case")
)

#outline(
  title: [Lista de Tabelas SQL],
  target: figure.where(kind: "sql-table")
)

#outline(
  title: [Lista de outras Tabelas],
  target: figure.where(kind: table)
)

#outline(
  title: [Lista de Esboços],
  target: figure.where(kind: "mockup"),
)

// Make the page counter reset to 1
#set page(numbering: "1", number-align: center)
#counter(page).update(1)

= Introdução

== Contextualização

#h(0.65em)Nas últimas décadas, a automação industrial e a digitalização de processos de fabricação têm sido fatores determinantes para a melhoria da eficiência nas linhas de montagem. Esses avanços permitiram às indústrias não apenas otimizar a produção, mas também adaptar-se a um mercado em constante mudança, onde a personalização e a sustentabilidade dos produtos se tornaram essenciais.


No setor de jardinagem, observa-se um crescente interesse por soluções inovadoras que facilitem a manutenção das plantas, especialmente entre consumidores que procuram conveniência e práticas sustentáveis. Os *vasos auto-irrigáveis* surgem como uma dessas inovações, permitindo que as plantas recebam a quantidade adequada de água ao longo do tempo, sem intervenção constante do homem. Esse tipo de produto não só promove a conservação de recursos hídricos, como também oferece uma solução prática para pessoas com pouca disponibilidade para cuidar das suas plantas.

== Apresentação do Caso de Estudo
#h(0.65em)Este projeto foca-se na gestão de uma linha de montagem dedicada à produção de vasos, que possuem um sistema integrado de irrigação automática. A linha de montagem envolve várias etapas, como a preparação dos materiais, a instalação do sistema de irrigação e a montagem final do vaso.

A aplicação a ser desenvolvida irá gerir o processo de produção, acompanhando o progresso de cada fase, os componentes incorporados e os tempos de execução. As funcionalidades são projetadas para oferecer suporte direto aos funcionários que operam a linha de montagem, facilitando o acompanhamento detalhado das etapas produtivas. Já os clientes terão acesso ao status das encomendas e poderão consultar informações sobre os produtos e a montagem dos mesmos.

== Classificação do sistema

    
#figure(table(
  columns: (0.5fr, 1fr),
  inset: 7pt,
  fill: (c, v) => if c == 0 { rgb("#D9D9D9") },
  [*Nome*], [Bloomify],
  [*Categoria*], [Venda e montagem personalizada],
  [*Idiomas disponíveis*], [Português],
  [*Faixa Etária*], [18+]
),
caption: [Classificação do sistema])


#pagebreak()

== Motivação e Objetivos
#h(0.65em)A motivação surge da crescente demanda de soluções inovadoras e sustentáveis no setor da jardinagem. Estes vasos representam uma abordagem prática para a irrigação eficiente de plantas, oferecendo benefícios tanto para consumidores quanto para o meio ambiente. A necessidade de um sistema de produção eficaz para esses vasos, que garanta qualidade e eficiência, justifica a proposta deste trabalho.

Os principais objetivos do projeto incluem desenvolver uma aplicação web que permita a gestão integral da linha de montagem dos vasos. A aplicação será responsável por integrar os diferentes intervenientes no processo: os administradores, que configuram o sistema e gerem os recursos; os funcionários, que acompanham e realizam as etapas de montagem; e os clientes, que podem monitorizar o progresso das suas encomendas.

Além disso, o sistema deverá implementar um processo de controlo de qualidade que assegure que todos os produtos atendam aos padrões estabelecidos antes de serem finalizados, garantindo assim a otimização da produção

== Justificação, Viabilidade e Utilidade do Sistema
#h(0.65em)Para os funcionários, uma aplicação que facilite a gestão das etapas de montagem representa uma ferramenta indispensável para organizar as tarefas e evitar erros durante a produção. Já para os clientes, a possibilidade de acompanhar em tempo real o progresso das suas encomendas e a garantia de um produto final de alta qualidade são fatores essenciais que destacam a utilidade do sistema.

A ferramenta proposta permitirá que os funcionários realizem cada etapa do processo de forma eficiente e organizada, garantindo que as informações relevantes estejam sempre acessíveis. Essa eficiência contribuirá para a credibilidade do produto junto aos clientes e facilitará a adoção do sistema em contextos de produção variados.

Quanto à viabilidade, a aplicação foi concebida para ser de fácil uso, permitindo que os utilizadores a operem sem dificuldades. Além disso, a possibilidade de acompanhar cada etapa de montagem proporciona uma confiança de contar com um sistema robusto e eficaz, o que aumenta a credibilidade na qualidade dos produtos, facilitando a adoção do sistema em diferentes contextos de produção.

== Estabelecimento da Identidade do Projeto

#h(0.65em)O sistema a ser desenvolvido, denominado _Bloomify,_ atuará como um gestor automatizado da produção de vasos auto-irrigáveis. Este sistema incluirá as seguintes funcionalidades:

#list(
  indent: 1.3em,
  spacing: 1.3em,
  [Interface gráfica intuitiva;],
  [Gestão de entrada e verificação de pedidos de vasos auto-irrigáveis, com informações atualizadas sobre o status de cada encomenda;],
  [Ferramentas específicas para os funcionários realizarem cada etapa do processo de montagem, incluindo instruções detalhadas;],
  [Visualização detalhada do produto para os clientes, permitindo que consultem especificações técnicas e status da encomenda sem intervenção direta no processo de montagem;],
  [Controlo do administrador de _stock_ e _re-stock_ de componentes, assegurando que os funcionários tenham acesso imediato aos itens necessários;],
  [Sistema de notificações que informa os clientes sobre o progresso da montagem da encomenda e atualizações importantes.]
)

== Identificação dos recursos necessários

#h(0.65em)Para que o sistema _Bloomify_ funcione de maneira eficaz, é essencial que ele tenha acesso a informações detalhadas sobre a produção de vasos auto-irrigáveis. Para isso, a equipa decidiu consultar fontes fidedignas, como sites especializados em jardinagem e artigos de pesquisa sobre técnicas de cultivo e irrigação.

No que diz respeito ao ambiente de desenvolvimento, será utilizado o _IDE Microsoft Visual Studio_, juntamente com
maioritariamente _software Microsoft_, para facilitar a implementação das funcionalidades desejadas.

O projeto será desenvolvido por uma equipa de cinco alunos, sendo que o aluno João Sá será o coordenador do projeto. Ele será responsável por gerir o cronograma, identificar e resolver desafios que possam surgir durante o desenvolvimento, garantir a qualidade da solução proposta e realizar outras tarefas essenciais para o sucesso do projeto.

#pagebreak()

== Maqueta do sistema

#h(0.65em) O sistema será segmentado em três camadas: dados, negócio e interface.

A camada de dados será composta por uma base de dados relacional, desenvolvida em Microsoft SQL Server, que armazenará informações essenciais do sistema, como detalhes de encomendas, componentes utilizados, etapas do processo de montagem, gestão de stock e linhas de montagem. Cada módulo da interface comunicará diretamente com a base de dados para garantir a consistência e disponibilidade das informações.

A camada de negócio atuará como intermediária entre a base de dados e a interface gráfica do utilizador (UI), encapsulando a lógica do sistema. Será responsável por gerir operações relacionadas ao cliente (visualização de encomendas e acompanhamento da montagem), ao funcionário (gestão de etapas e componentes) e ao administrador (dashboard com funcionalidades de gestão de produtos, encomendas e linhas de montagem). Essa camada assegurará que todas as transações e operações sejam realizadas de forma segura e eficiente.

Por fim, a camada de interface representará o ponto de interação com os utilizadores do sistema. Será projetada para oferecer experiências específicas para cada perfil: clientes poderão acessar a loja e visualizar o progresso das suas encomendas; funcionários terão acesso a funcionalidades relacionadas ao processo de montagem; e administradores contarão com ferramentas para gestão de stock, produtos e encomendas. A interface será intuitiva e otimizada para facilitar a interação com os dados.

A maqueta apresentada ilustra a estrutura geral do sistema, destacando os diferentes módulos de interação (Cliente, Funcionário e Administrador), suas conexões com a base de dados e as funcionalidades específicas atribuídas a cada perfil.

\
\

#figure(
  image("images/Maqueta.drawio.png", width:80%),
  caption: [
    Maqueta do sistema
  ],
)

#pagebreak()
\
\
== Definição de um conjunto de medidas de sucesso

#h(0.65em)Um fator essencial para o sucesso de qualquer software é a sua qualidade. No caso do _Bloomify_, o sucesso será medido pelo seu nível de utilização e pela sua capacidade de gerir eficientemente a produção de vasos auto-irrigáveis. O sistema será considerado bem-sucedido se permitir otimizar o processo de montagem, reduzir erros, acompanhar cada fase da produção em tempo real e oferecer uma interface intuitiva, facilitando o uso até para os utilizadores menos experientes.

Além disso, o software deve ser eficiente em termos de recursos. Por fim, o sucesso será assegurado se todos os requisitos funcionais e técnicos forem cumpridos, permitindo que o sistema seja amplamente adotado e eficaz na produção de vasos.


== Plano de Desenvolvimento (_Diagrama de GANTT_)

\

#h(0.65em)Para garantir a organização e o sucesso deste projeto, foi elaborado um plano de desenvolvimento em formato de *_Diagrama de GANTT_*, que detalha todas as tarefas a serem executadas, bem como os prazos e responsáveis por cada etapa. Este diagrama serve como uma ferramenta essencial para monitorizar o progresso, identificar possíveis atrasos e garantir que os objetivos sejam alcançados dentro do cronograma estabelecido.

#h(-0.65em)O plano inclui:

#list(indent: 1.2em,
spacing: 1.2em,
[Divisão das tarefas em etapas específicas, facilitando a identificação de prioridades;],
[Datas de início e término de cada atividade, promovendo uma gestão eficaz do tempo;],
[Alocação de recursos e responsabilidades, garantindo que todos os envolvidos saibam suas funções e prazos.]
)

Existe ainda a possibilidade de ajustes em tempo real, caso sejam identificados desvios no cronograma.

Este diagrama foi desenvolvido com foco na transparência e na eficiência, servindo como uma base sólida para guiar todas as fases do projeto e minimizar riscos ao longo do desenvolvimento.

\
\
#figure(
  image("images/DiagramaDeGANTTLI4.jpg", width: 120%),
  caption: [Diagrama de Gantt do Projeto]
)


= Levantamento e Análise de Requisitos

== Apresentação da estratégia e método

O processo de levantamento e de análise de requisitos constitui uma das partes mais importantes (senão a mais importante) de um projeto de engenharia de software.

Primeiramente, realizámos uma reunião inicial, representada pela equipa da _Bloomify_. Nesta reunião, estiveram presentes membros-chave, como Gonçalo Ramos, Diretor-Geral da empresa, Ana Ferreira, Gestora de Produção, e Manuel Cunha, Responsável pela Inovação. Durante a reunião, foram discutidas as principais necessidades da empresa em relação aos vasos auto-irrigáveis, bem como os objetivos que desejam alcançar com a solução. A empresa destacou a importância de criar um produto sustentável, fácil de usar e capaz de se integrar ao mercado atual com um diferencial competitivo.

Posteriormente, a equipa realizou uma análise detalhada dos processos associados à manutenção de plantas em vasos tradicionais e dos desafios enfrentados pelos utilizadores, como a rega inadequada e o desperdício de água. Além disso, foram analisadas as melhores práticas no design e funcionamento de sistemas auto-irrigáveis existentes, com o intuito de identificar elementos que podem ser adaptados e melhorados no projeto.

Em seguida, foram analisados produtos semelhantes disponíveis no mercado, de marcas concorrentes, para identificar funcionalidades e características que poderiam ser incorporadas no projeto. Este estudo também ajudou a destacar falhas nos produtos atuais, permitindo que o sistema _Bloomify_ ofereça vantagens competitivas.

Adicionalmente, foram realizadas entrevistas com potenciais utilizadores, como jardineiros profissionais e pessoas com pouca experiência no cuidado de plantas, para compreender as suas necessidades e expectativas em relação aos vasos auto-irrigáveis. O objetivo foi identificar elementos como a autonomia de rega, facilidade de uso e design estético. Foram também consultados especialistas em eficiência hídrica para validar escolhas técnicas, assegurando que o produto final seja ecologicamente responsável.

O _feedback_ obtido foi crucial para entender as preferências dos utilizadores em termos de materiais, preços e funcionalidades adicionais, como indicadores de nível de água e opções de tamanhos variados. Essas informações foram integradas no planeamento para alinhar o desenvolvimento do sistema com as necessidades do público-alvo e dos funcionários responsáveis pelo processo de montagem.


#pagebreak()

\

== Requisitos Funcionais

Ao levantar estes requisitos, consideramos que os produtos, componentes, e linhas de montagem já estavam criados(as), e que nunca seriam removidos(as).

=== Registo na aplicação como cliente 

#set align(center)


#underline[Definição dos requisitos do utilizador]

#set align(start)

- O cliente deve registar-se na aplicação para puder aceder às funcionalidades, como o estado da encomenda e a realização da montagem do produto em questão.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- Durante o registo, o sistema deve solicitar os seguintes dados do utilizador: nome, email, password, NIF, Data de nascimento.
- O sistema não deve permitir o registo de utilizadores com o mesmo email.
- O sistema deve armazenar de forma segura os dados do utilizador na base de dados.

=== Início de sessão

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O cliente, administrador ou funcionário deverá introduzir o seu email e a password para o início de sessão.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema verifica o email e a password inseridos correspondem a algum cliente,administrador ou funcionário existente no sistema.

=== Terminar sessão

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O utilizador deve conseguir terminar sessão.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve terminar sessão do utilizador.

=== Criação de Encomendas

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O cliente deve conseguir registar encomendas de produtos na aplicação;
- O cliente deverá introduzir a morada do destino da encomenda;
- Caso exista um componente fora de _stock_, o Cliente não poderá realizar a encomenda.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve registar os dados da encomenda;
- O sistema deve validar a encomenda, atribuí-la a um funcionário e atualizar a base de dados em tempo real.

=== Alteração de Encomendas

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O administrador deve conseguir alterar o status das encomendas na aplicação.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve validar a alteração da encomenda e solicitar confirmação da mesma;
- O sistema deve atualizar os dados da encomenda em tempo real. 

=== Listagem de Encomendas

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- Um administrador deve conseguir listar e consultar todas as Encomendas no sistema;
- Um cliente deve conseguir listar e consultar as encomendas associados a ele mesmo,assim como os seus detalhes, e ser capaz de interagir com os produtos lá presentes;
- Um funcionário deve conseguir listar as encomendas que lhe foram atribuídas.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve apresentar a lista, com os detalhes relevantes dos produtos.

=== Listagem de Linhas de Montagem

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O administrador deve puder listar todas as linhas de montagem registadas no sistema, com os seus detalhes.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve apresentar uma lista ao administrador contendo todas as linhas de montagem, detalhando as etapas e outras informações associadas.

=== Alteração de Linhas de Montagem

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O administrador deve puder alterar todas as linhas de montagem registadas no sistema.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve realizar as atualizações desejada, após confirmação.

=== Listagem de Produtos

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O administrador deve puder listar todos os produtos do sistema.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)
 
- O sistema deve apresentar uma lista ao administrador de todos os produtos do sistema, com os seus detalhes.

=== Alteração de Produtos

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O administrador deve puder fazer alterações em qualquer produto do sistema.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)
 
- O sistema deve realizar as atualizações desejada, após confirmação.

=== Acesso à linha de montagem

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O funcionário deverá ter acesso às linhas de montagem dos produtos das encomendas que lhe foram atribuídas;
- O cliente deverá ter uma visão geral do progresso e dos detalhes da montagem das suas encomendas.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deverá permitir que o funcionário e/ou o cliente selecionem uma linha de montagem.

=== Processo de montagem

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)
- O funcionário deve poder visualizar, de forma clara, as etapas e instruções necessárias para a montagem do(s) produto(s);
- O funcionário deve ser capaz de alterar o status de uma etapa, e identificar os componentes já incorporados na montagem;
- O cliente de ser capaz de ver facilmente o progresso detalhado(tempo de montagem, componentes em falta, etc..) da montagem realizada pelo funcionário.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve apresentar uma lista ordenada das etapas para cada encomenda, com descrições, imagens, a instrução, o Nº da Etapa, o estado e o identificador da mesma;
- O sistema deve permitir que o funcionário selecione uma etapa como concluída;
- O sistema deve permitir ao funcionário voltar atrás nas etapas de montagem.
- O sistema deve contabilizar o tempo de montagem total dos produtos.


#pagebreak()

=== Gestão de componentes

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- O administrador deve ter uma vista geral relacionada ao _stock_ de peças do sistema;
- O administrador deverá conseguir atualizar o _stock_ de uma certa peça, conforme o reabastecimento da mesma.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)

- O sistema deve atualizar o estado do _stock_ na *Base de Dados* de cada componente conforme as encomendas dos utilizadores;
- O sistema deve exibir uma lista de todos os componentes, incluindo informações sobre o _stock_ atual dos mesmos;
- O sistema deverá dar a possibilidade de um administrador atualizar o stock de uma certa peça.

\

=== Notificações e alertas

#set align(center)

#underline[Definição dos requisitos de utilizador]

#set align(start)

- Se tiver as notificações estiverem ativadas, o cliente deve ser notificado sobre atualizações importantes relacionadas à sua encomenda, como alterações no prazo de entrega ou estado da mesma.

#set align(center)

#underline[Especificação dos requisitos do sistema]

#set align(start)
- O sistema deve enviar notificações automáticas para os clientes via email, com título e descrição, sobre as suas entregas.

#pagebreak()

\

== Requisitos não funcionais

- A aplicação deverá ser projetada com foco na simplicidade e acessibilidade, oferecendo uma interface intuitiva. O _design_ deverá ser minimalista, reduzindo distrações e priorizando a acessibilidade;

- O tempo de resposta da aplicação deve ser otimizado para garantir que os utilizadores não enfrentem atrasos, assegurando uma experiência fluida mesmo em cenários de alta carga;

- A aplicação deverá funcionar perfeitamente nos navegadores mais utilizados no mercado, incluindo _Google_ _Chrome_, Firefox, _Microsoft Edge_;

- A segurança deve ser uma prioridade, garantindo que os dados dos utilizadores sejam armazenados e processados com confidencialidade e integridade. A aplicação deve adotar medidas eficazes de proteção contra acessos não autorizados e violações de dados;

- O sistema deve permitir a expansão da sua capacidade para suportar um maior número de utilizadores e encomendas à medida que a demanda pelo serviço aumenta. Tanto a infraestrutura de processamento quanto o armazenamento deverão ser projetados para se adaptar a futuras necessidades.

== Validação dos requisitos estabelecidos

Após a definição dos requisitos funcionais e não funcionais, estes foram submetidos a uma validação junto da empresa _Bloomify_. Essa validação teve como objetivo garantir que os requisitos definidos atendiam às expectativas e necessidades. Para isso, foi realizada uma reunião com os representantes da empresa, durante a qual os requisitos foram apresentados com detalhe. Estes confirmaram que os mesmos, permitindo que o desenvolvimento do projeto avançasse.


= Especificação e Modelação do Software

== Apresentação geral da especificação

Durante esta fase do projeto, a notação _UML_ foi adotada como ferramenta para auxiliar na representação das estruturas e comportamentos do sistema de gestão de linha de montagem de vasos auto-irrigáveis.

No que diz respeito à estrutura, foi elaborado um modelo de domínio que descreve as principais entidades do sistema, como utilizadores, encomendas, componentes e linhas de montagem , além de suas respetivas relações. Este modelo oferece uma visão abrangente da organização e interação entre os elementos essenciais do sistema.

Em relação ao comportamento, iniciámos a definição das funções principais da aplicação através de _use cases_. Estes descrevem ações como a gestão de encomendas, as etapas de montagem e o controlo de componentes. Posteriormente, foi construído um diagrama de _use cases_ que mapeia os atores envolvidos (administradores, clientes e funcionários) e suas interações específicas com cada função. Além disso, foram feitos diagramas de atividades para detalhar o fluxo operacional da aplicação.


#pagebreak()

\

== Aspetos estruturais

Definir os aspetos estruturais do sistema exige identificar e compreender as entidades e as relações presentes no domínio para o qual o sistema é projetado.

Para isso, optamos por criar um modelo de domínio, que oferece uma representação visual clara das entidades e de como elas se relacionam. Esse modelo atua como um planeamento de alto nível para o sistema final, sendo essencial durante a implementação para garantir que a aplicação seja desenvolvida de acordo com o que foi idealizado.

A seguir, apresentamos o modelo de domínio criado:

#figure(
  image("images/ModeloDominioLI4.png", width: 110%),
  caption: [Modelo de Domínio do Projeto]
)

== Aspetos Comportamentais

#h(0.65em)A aplicação vai ser desenvolvida tendo em mente o atendimento apenas de um tipo de utilizador, o cliente, ou seja, os administradores serão responsáveis pela atualização do _stock_ de componentes e informações dos produtos, incluindo as respetivas linhas de montagem.
Os funcionários por sua vez estão encarregues de montar as encomendas feitas pelos clientes com a ajuda das linhas de montagem.

Tendo o que foi dito em mente, iremos representar alguns Casos de Uso descritos através dos diagramas que se seguem nos próximos capítulos.

Podemos encontrar uma lista completa das tabelas de Casos de Uso em @lista_use_cases.

=== Diagrama de Casos de Uso Geral

#figure(
  image("images/Diagrama de casos de uso geral.png", width: 100%),
  caption: [Diagrama de casos de uso geral]
)

#pagebreak()

#figure(
  image("images/Subdiagrama de gestao de produtos.png", width: 80%),
  caption: [Subdiagrama de casos de uso de gestão de produtos]
)

#figure(
  image("images/Subdiagrama da gestão de componentes.png", width: 80%),
  caption: [Subdiagrama de casos de uso de gestão de componentes]
)

#figure(
  image("images/Subdiagrama linha de montagem.png", width: 100%),
  caption: [Subdiagrama de casos de uso de gestão de linha de montagem]
)

#figure(
  image("images/SubdiagramaInteragirLinhaDeMontagem.png", width: 110%),
  caption: [Subdiagrama de casos de uso de gestão de linha de montagem]
)

#pagebreak()


=== Casos de Uso do Utilizador

#rerender(<use_case_autenticar>)

#rerender(<use_case_listagem_encomendas>)

#rerender(<use_case_terminar_sessao>)

=== Casos de Uso do Cliente

#rerender(<use_case_registar>)

#rerender(<use_case_ver_progresso_montagem>)

#rerender(<use_case_criar_encomenda>)

=== Casos de Uso do Funcionário

#rerender(<use_case_atualizar_etapa>)

#rerender(<use_case_incorporar_componentes>)


=== Casos de Uso do Administrador

#rerender(<use_case_listar_linhas_de_montagem>)

#rerender(<use_case_editar_linha_de_montagem>)

#rerender(<use_case_listar_componentes>)

#rerender(<use_case_editar_componentes>)
\
\
\
\
\
\
\
\
\
== Diagrama de atividades

O diagrama de atividades apresentado descreve o fluxo completo do processo de criação, produção e entrega de uma encomenda no sistema _Bloomify_. Este fluxo envolve diferentes atores e departamentos, cada um desempenhado um papel essencial na execução e conclusão da encomenda.

O processo inicia-se com o cliente a criar uma encomenda na plataforma. O sistema valida a disponibilidade dos componentes, notificando o cliente em caso de falta de stock. Caso todos os componentes estejam disponíveis, a encomenda é atribuída a um funcionário do departamento de produção, que segue um conjunto de etapas definidas na linha de montagem.

Após a conclusão da montagem, o produto passa por uma verificação de qualidade no Departamento de Garantia de Qualidade. Caso seja, aprovado, o pedido segue para o Departamento de Logística, onde é preparado para envio e, finalmente, entregue ao cliente. Caso o produto não seja aprovado na verificação de qualidade, ele retorna ao Departamento de Produção para revisão e correção.

Este diagrama representa as interações entre o cliente, sistema, produção, garantia de qualidade e logística. Esta estrutura permite identificar possíveis melhorias no processo e otimizar a eficiência operacional.
\
\
#figure(
  image("images/Processo de montagem.png", width: 90%),
  caption: [Diagrama de atividades sobre a criação, produção e entrega de uma encomenda]
)



= Conceção do Sistema de Dados

#h(0.65em)Como prevemos que esta aplicação terá uma grande adesão, ela deverá lidar com um volume significativo de dados relacionados a linhas de montagem, clientes, produtos, entre outros. Para armazenar estes dados de forma organizada e eficiente, torna-se essencial a implementação de uma base de dados. Essa solução permitirá não apenas organizar os dados, mas também proporcionar consultas rápidas, reduzir redundâncias e otimizar o armazenamento.

Além disso, a implementação de uma base de dados facilitará a recolha de estatísticas, que poderão ser utilizadas para melhorar a experiência do utilizador. Por fim, uma base de dados contribuirá para a redução de custos a longo prazo, ao diminuir a necessidade de uma gestão manual de dados e minimizar erros e falhas que possam resultar em desperdício de tempo e recursos.

== Apresentação geral da estrutura do sistema de dados

#h(0.65em)Após uma modelação do software e das suas funcionalidades, começamos a planear a estrutura de uma base de dados que se adaptasse ao mesmo. Através dos modelos apresentados acima e dos requisitos levantados, chegamos ao seguinte modelo lógico:

#figure(
  image("images/ModeloLogico.png", width: 85%),
  caption: [Modelo Lógico do Projeto]
)

\
 
== Descrição detalhada dos vários elementos de dados e seus relacionamentos

#h(0.65em)Para melhor compreensão dos vários elementos de dados e os seus relacionamentos, explicamos nas estruturas desenvolvidas abaixo cada campo das tabelas mais importantes.

Podemos, mais uma vez, encontrar uma lista de todas as tabelas SQL em @lista_tabelas_sql.

\

#rerender(<tabela_db_utilizador>)

#rerender(<tabela_db_cliente>)

#rerender(<tabela_db_funcionario>)

#rerender(<tabela_db_encomenda>)

#rerender(<tabela_db_estado_encomenda>)

#rerender(<tabela_db_produto_display>)

#rerender(<tabela_db_produto>)

#rerender(<tabela_db_linha_de_montagem>)

#rerender(<tabela_db_linha_produto>)

#rerender(<tabela_db_etapa>)

#rerender(<tabela_db_estado_montagem>)

#rerender(<tabela_db_notificacao>)

#rerender(<tabela_db_componente>)


= Esboço dos Interfaces do Sistema

Começámos por criar um logótipo original, estético e apelativo, que reflete a identidade visual do sistema. O _design_ final pode ser visualizado na imagem abaixo:

#figure(
    image("images/Logo.png", width: 80%), 
    caption: [Logótipo do Sistema] 
)

Além disso, desenvolvemos uma *palete de cores*, que representa minuciosamente a estética e funcionalidade do _website_ que iremos implementar:

\

#figure(
    image("images/Palete de cores.png", width: 90%), 
    caption: [Palete de cores do Sistema] 
)

\
Para complementar o nosso projeto, realizamos esboços das diferentes páginas a implementar.

Apresentaremos então os que consideramos ser o foco do _website_, como sempre podemos encontrar uma lista completa dos esboços em @lista_de_esboços.

\

#rerender(<esboço_landing_page>)
\
#rerender(<esboço_registo>)
\
#rerender(<esboço_perfil>)
\
#rerender(<esboço_destaques_sem_user>)
\
#rerender(<esboço_produtos>)
\
#rerender(<esboço_encomendas_funcionário>)
\
#rerender(<esboço_encomenda_especificada>)
\
#rerender(<esboço_linha_de_montagem>)
\
#rerender(<esboço_painel_de_admin_>)

= Implementação da aplicação

A aplicação Bloomify foi construída com base na _framework Blazor Web App_, uma decisão técnica que visa otimizar o desempenho e centralizar a lógica de negócio no servidor. Esta escolha permite uma comunicação eficiente entre o cliente e o servidor, eliminando a necessidade de múltiplas chamadas à API e reduzindo a complexidade no lado do cliente. Como resultado, os utilizadores desfrutam de uma experiência fluida e responsiva.

Nas secções seguintes, serão explorados os componentes desenvolvidos, a sua implementação das funcionalidades descritas e a forma como colaboram para garantir o correto funcionamento do sistema.

O diagrama abaixo representa a arquitetura do projeto e a interação entre os diversos sistemas envolvidos. Os utilizadores acedem ao _website_ através de um _browser_, e cada página interage com vários serviços para obter os dados necessários. Estes serviços, por sua vez, comunicam com a base de dados para fornecer a informação requerida para a renderização da página.

#figure(
image("images/Deployment Diagram1.jpg", width: 100%),
caption: [Diagrama de implantação do projeto]
)
\
\
\
\
\
\
\
\
\
\
A estrutura das páginas e serviços é detalhada no diagrama de componentes apresentado abaixo, que ilustra a organização e interligação dos diferentes elementos do sistema.

#figure(
image("images/Component Diagram1.jpg", width: 110%),
caption: [Diagrama de componentes do projeto]
)


== Serviços 

O _Blazor Web App_ utiliza o padrão de desenvolvimento por injeção de dependências, onde as dependências de uma classe são injetadas diretamente no seu construtor, em vez de serem instanciadas dentro da própria classe. Por exemplo, se uma classe necessita de um módulo de acesso à base de dados e um serviço de envio de emails, esses módulos são fornecidos no construtor da classe, permitindo uma maior modularidade e facilidade de teste.

No _Blazor Web App_, a injeção de dependências baseia-se na lógica de serviços. Os serviços são módulos de código aos quais as páginas podem aceder. Para que um serviço seja injetável, ele deve ser declarado no ficheiro Program.cs. O _Blazor Web App_ injeta automaticamente os serviços requisitados pelas páginas nos seus construtores. A seguir, detalham-se os principais serviços da aplicação.

=== SqlDataAcess
O serviço atua como uma camada de abstração para o acesso à base de dados. Ele facilita a interação com as diversas entidades presentes na base de dados, permitindo a execução de operações básicas de criação, leitura, atualização e remoção. Além disso, este módulo suporta a execução de consultas complexas, incluindo aquelas que envolvem relacionamentos do tipo 1:N (um-para-muitos) e N:M (muitos-para-muitos). Outra funcionalidade importante é a capacidade de realizar transações que afetam múltiplos dados simultaneamente, garantindo a consistência e integridade das operações.

A classe implementa a interface `ISqlDataAccess`, que define um conjunto de métodos utilizados por outros serviços mais específicos. Esses serviços, por sua vez, são responsáveis por tarefas mais granulares, como a gestão de encomendas, componentes, ou linhas de montagem, e dependem do `SqlDataAccess` para aceder e manipular os dados de forma eficiente e segura.
\
\
\
=== UserService
O serviço é responsável por gerir os utilizadores da aplicação. É possível operar sobre os dados de todos os utilizadores. Permite encontrar utilizadores que tenham um role específico: administradores, funcionários ou clientes.

=== ProductService
Este serviço é responsável por gerir os produtos da aplicação. Este serviço permite realizar operações sobre os dados dos produtos, como a leitura, atualização de produtos. Além disso, oferece funcionalidades específicas, como a obtenção de produtos associados a uma encomenda, o cálculo do valor total gasto numa encomenda e a identificação do produto mais popular numa encomenda.

=== OrderService

Este serviço é responsável por gerir as encomendas da aplicação. Este serviço permite realizar operações sobre os dados das encomendas, como leitura, atualização de encomendas. Além disso, oferece funcionalidades específicas, como a obtenção de encomendas associadas a um cliente ou funcionário, a consulta do estado de uma encomenda e a listagem de encomendas por estado. O serviço também interage com o `ProductService` para obter os produtos associados a cada encomenda.

=== LinhasDeMontagemService

Este serviço é responsável por gerir as linhas de montagem da aplicação. Este serviço permite realizar operações sobre os dados das linhas de montagem, como a leitura, atualização de linhas de montagem. Além disso, oferece funcionalidades específicas, como a obtenção de uma linha de montagem associada a um produto específico.

=== EtapaService

Este serviço é responsável por gerir as etapas de montagem da aplicação. Este serviço permite realizar operações sobre os dados das etapas, como a leitura, atualização remoção de etapas. Além disso, oferece funcionalidades específicas, como a obtenção de etapas associadas a uma linha de montagem e a consulta da etapa atual de uma linha de montagem.

=== ComponenteService
 É responsável por gerir os componentes utilizados na montagem dos produtos na aplicação. Este serviço permite realizar operações sobre os dados dos componentes, como a leitura, atualização de componentes. Além disso, oferece funcionalidades específicas, como a obtenção de componentes associados a um produto específico.

=== CartService
O `CartService` é responsável por gerir o carrinho de compras da aplicação. Este serviço permite adicionar produtos ao carrinho, remover produtos, obter a lista de produtos no carrinho, verificar a quantidade de um produto específico e limpar o carrinho. O carrinho é mantido em memória durante a sessão do utilizador, utilizando uma lista para armazenar os produtos e as suas quantidades.

=== NotificationService

O `NotificationService` é responsável por gerir as notificações da aplicação. Este serviço permite obter uma lista de notificações, buscar notificações específicas por ID, apagar notificações e criar notificações para administradores. 

== Autenticação e Autorização

O módulo de autenticação e autorização no projeto _Bloomify_ é implementado através da classe `AuthProvider`, que deriva da classe `AuthenticationStateProvider` disponível no _Blazor_. Esta classe é responsável por gerir o estado de autenticação do utilizador, armazenando e atualizando a sessão do utilizador durante o _login_ e _logout_. A sessão do utilizador é representada pela estrutura `UserSession`, que contém o nome, email e tipo (cargo) do utilizador autenticado.

== Segurança e Proteção de dados

A implementação de medidas robustas de segurança é fundamental no desenvolvimento de aplicações modernas. Uma das práticas essenciais é a proteção adequada das senhas dos utilizadores. Para atingir esse objetivo, tendo referido anteriormente como um requisito não funcional, implementamos um mecanismo de criptografia utilizando o algoritmo _Bcrypt_, que transforma as senhas em hashes antes do armazenamento na base de dados. Esta abordagem não apenas fortalece significativamente a segurança das credenciais dos utilizadores, como também assegura a conformidade com os regulamentos de proteção de dados em vigor.

== Exemplos concretos de processos implementados

=== Processo 1: Criação de encomenda

O processo de criação de uma encomenda começa quando o cliente seleciona os produtos desejados e os adiciona ao carrinho de compras.

#figure(
image("images/pages/carrinho2vasos.png", width: 90%),
caption: [Carrinho]
)

Uma vez que o utilizador cria uma encomenda com os produtos do carrinho, o sistema inicia uma verificação de stock através do `ProductService`, que confirma a disponibilidade dos componentes para os produtos selecionados. Se for possível montar os produtos selecionados, o `OrderService` cria uma nova encomenda na base de dados, associando os produtos selecionados ao pedido do cliente e ainda cria uma instância na linha de montagem para cada produto através da `LinhaDeMontagemService`. Após a criação da encomenda, o `ComponentService` atualiza o stock dos componentes utilizados, garantindo que as quantidades disponíveis sejam reduzidas de acordo com a compra realizada. Este processo garante que todas as etapas sejam realizadas de forma eficiente e segura, proporcionando uma experiência de compra fluida e transparente para o cliente. Caso não seja possível realizar uma encomenda, o `NotificationService` cria uma notificação para o Administrador, de modo a alertar acerca da falta de _stock_. 


=== Processo 2: Montagem de um produto

O processo de montagem de um produto inicia-se quando um funcionário acede à lista de encomendas atribuídas à sua responsabilidade.

#figure(
image("images/pages/asminhasencomendas.png", width: 90%),
caption: [Carrinho]
)

Após selecionar uma encomenda específica, o sistema utiliza o `ComponenteService` para obter a lista de componentes necessários para a montagem do produto em questão. Para além disso, ao clicar na linha de montagem associado ao produto específico com aqueles componentes, a `LinhaDeMontagemService` vai à base de dados buscar a linha de montagem relativa.

#figure(
image("images/pages/funcionarioEncomenda.png", width: 90%),
caption: [Carrinho]
)
\
\
\
\
Com os componentes nas mãos, o funcionário é guiado através das etapas de montagem pelo `EtapaService`, que fornece instruções detalhadas e atualiza o estado de cada etapa à medida que o trabalho do funcionário avança, registando também o progresso da montagem em questão.

#figure(
image("images/pages/linhamontagemfuncionario.png", width: 90%),
caption: [Carrinho]
)

Uma vez que todas as etapas de montagem são finalizadas, o `LinhaDeMontagemService` atualiza o estado da montagem para "Concluída", indicando que o produto está pronto para ser entregue ao cliente. O estado da encomenda apenas é atualizado quando o Administrador assim o fizer, através do `OrderService`. Este processo assegura que a montagem seja realizada de forma organizada e eficiente, permitindo que os funcionários e clientes acompanhem o progresso em tempo real.


= Análise e Avaliação da Aplicação Desenvolvida

Tendo em conta os requisitos funcionais e os casos de uso estabelecidos para a aplicação _Bloomify_, esta foi desenvolvida para ser capaz de atender a vários objetivos fundamentais.

A gestão por parte dos administradores foi implementada com sucesso, permitindo o controlo total sobre produtos, componentes, encomendas e linhas de montagem. Os administradores podem atualizar produtos e gerir os componentes necessários para a montagem dos vasos autoirrigáveis, incluindo a adição e remoção de quantidades. A gestão das linhas de montagem também foi contemplada, possibilitando a edição das etapas através da modificação de instruções e descrições.


Para os funcionários, a aplicação oferece funcionalidades que permitem acompanhar e executar as etapas de montagem de forma eficiente. Eles têm acesso direto às encomendas que lhes são atribuídas e podem atualizar o estado de cada etapa do processo de montagem, garantindo um fluxo de trabalho organizado e transparente.

No que diz respeito aos clientes, a plataforma permite o registo e a criação de encomendas de vasos autoirrigáveis de forma intuitiva. Os clientes podem acompanhar o estado da montagem em tempo real e têm acesso a informações detalhadas sobre os produtos e o progresso das suas encomendas, proporcionando uma experiência de compra transparente e satisfatória.

A interface foi desenvolvida com foco na simplicidade de uso, apresentando um design responsivo que segue fielmente os esboços iniciais. Esta abordagem resultou numa experiência fluida e agradável para todos os utilizadores, independentemente do seu papel na plataforma.

Considerámos que todas as funcionalidades essenciais para o funcionamento da aplicação foram implementadas com sucesso. A aplicação não só cumpre os requisitos definidos inicialmente, como também estabelece uma base sólida para futuras expansões e melhorias. A implementação visual mantém-se alinhada com os esboços iniciais, garantindo uma experiência consistente e intuitiva para todos os utilizadores.


= Conclusões e Trabalho Futuro

#h(0.65em)Neste projeto, percorremos todo o processo de conceção e desenvolvimento da aplicação _Bloomify_, desde o planeamento até à implementação das funcionalidades essenciais. 

Na primeira fase, focámo-nos no planeamento detalhado, definindo o propósito da aplicação, analisando a sua viabilidade e recolhendo requisitos funcionais e não funcionais. Desenvolvemos um modelo de domínio, diagramas de casos de uso e o modelo lógico da base de dados, além de esboços iniciais das interfaces, garantindo uma visão clara do sistema.


Na segunda fase, concretizámos as funcionalidades planeadas, desenvolvendo a gestão de produtos, encomendas e linhas de montagem. A interface foi projetada para ser intuitiva e alinhada com os esboços iniciais, proporcionando uma experiência fluida aos utilizadores. A metodologia adotada foi crucial para o sucesso do projeto, permitindo-nos evitar erros e conflitos ao termos uma visão clara do problema antes da implementação.
Embora tenhamos concluído as fases de planeamento e implementação, a futura manutenção e expansão serão igualmente importantes. A metodologia utilizada facilitará a adição de novas funcionalidades, garantindo que o _Bloomify_ continue a evoluir e a atender às necessidades da empresa e dos clientes.


O projeto _Bloomify_ foi desenvolvido com sucesso, cumprindo todos os requisitos estabelecidos. A aplicação é funcional, intuitiva e preparada para futuras expansões, como por exemplo, dar a oportunidade ao administrador poder alterar as imagens relativas a cada etapa/produto, atendendo às necessidades atuais e futuras. Implementamos medidas robustas de segurança, incluindo a criptografia das senhas dos utilizadores através do algoritmo _Bcrypt_, assegurando a proteção dos dados sensíveis e a conformidade com as normas vigentes. Estamos confiantes de que o _Bloomify_ será um sucesso, proporcionando uma solução robusta, segura e alinhada com as expectativas dos utilizadores e _stakeholders_.

#set heading(numbering: none)

#bibliography(full: true, "bibliografia.bib")

= Lista de Siglas e Acrónimos

/ BD: Base de Dados
/ LI4: Laboratórios de Informática IV
/ NIF: Número de Identificação Fiscal
/ UML: _Unified Modelling Language_
/ UI: _User Interface_
/ SQL: _Structured Query Language_


= Anexos

#attachment[Lista de Casos de Uso completa] <lista_use_cases>

\

#use_case_table(
  "Autenticar na plataforma",
  "Utilizador",
  "O Utilizador solicita ao sistema acesso à plataforma inserindo suas credenciais de autenticação.",
  "O Utilizador não deve estar autenticado.",
  "O sistema autentica o Utilizador e regista a sessão na plataforma.",
  (
    ("Fluxo Normal",
     "1. O utilizador fornece ao sistema suas credenciais (email e senha)",
     "2. O sistema verifica se o email está registado para algum tipo de Utilizador",
      "3. O sistema verifica se a senha fornecida corresponde à registada para aquele email.",
      "4. O sistema autentica o Utilizador no respetivo tipo de utilizador e inicia sessão.",
      ),
      ("Fluxo de exceção (1) (Utilizador fornece um email não registado)",
      "2.1 O sistema informa que o email fornecido não está registado."
    ),
    ("Fluxo de exceção (2) (Utilizador fornece uma senha não correspondente)",
      "3.1 O sistema informa que a senha fornecida está incorreta.",
    )
  )
)<use_case_autenticar>

#use_case_table(
  "Listar Encomendas",
  "Utilizador",
  "Utilizador solicita ao sistema uma lista de todas as encomedas associadas.",
  "O utilizador está autenticado e tem pelo menos uma encomenda em produção",
  "O sistema apresenta uma lista das encomendas associadas ao Utilizador, com seus respetivos status e informações relevantes.",
  (
    ("Fluxo Normal",
     "1. O Utilizador solicita ao sistema a lista de todas as encomendas associadas.(Em caso de admin, serão todas as encomendas do sistema)",
      "2. O sistema consulta na base de dados todas as encomendas associadas ao Utilizador.",
      "3. O sistema organiza as encomendas, onde lista informações como o ID, status.",
      "4. O sistema apresenta a lista ao Utilizador",
      ),
    ("Fluxo de exceção (1) (Utilizador não possui encomendas associadas)",
      "2.1 O sistema informa que não há encomendas associadas ao utilizador na plataforma.",
    )
  )
) <use_case_listagem_encomendas>

#use_case_table(
  "Terminar sessão",
  "Utilizador",
  "Utilizador autenticado termina a sessão na plataforma",
  "O Utilizador está autenticado",
  "O sistema encerra a sessão do utilizador",
  (
    ("Fluxo Normal",
     "1. Utilizador informa o sistema da sua intenção de terminar sessão",
     "2. Sistema termina a sessão e este deixa de estar autenticado"),
  )
) <use_case_terminar_sessao>


#use_case_table(
  "Registar-se na plataforma",
  "Utilizador",
  "Autenticação de um cliente na plataforma",
  "O Utilizador não deve estar autenticado",
  "O Utilizador fica autenticado na plataforma como Cliente",
  (
    ("Fluxo Normal",
     "1. Sistema pede email, palavra-passe, nome, NIF, Data de Nascimento e Nº telefone",
     "2. Utilizador introduz os dados necessários",
     "3. O sistema verifica se o email já está registado na plataforma",
     "4. O sistema valida os dados introduzidos",
     "5. O sistema regista e autentica o cliente"
    ),
    ("Fluxo de Exceção (1) (Email já existente)",
     "3.1. O sistema informa que já existe uma conta com aquele email"),
    ("Fluxo de Exceção (2) (Dados introduzidos inválidos)",
       "4.1. O sistema informa que existem dados inválidos"),
  )
)<use_case_registar>

#use_case_table(
  "Criar Encomenda",
  "Cliente",
  "Cliente solicita ao sistema a criação de uma nova encomenda com os produtos desejados",
  "O cliente está autenticado",
  "O sistema regista a encomenda, associando-a ao cliente",
  (
    ("Fluxo Normal",
      "1. O cliente solicita ao sistema a criação de uma nova encomenda.",
      "2. O cliente fornece as informações sobre a encomenda, como produtos desejados e as suas quantidades.",
      "3. O sistema verifica se as quantidades solicitadas de componentes associados aos produtos estão disponíveis em stock",
      "4. O sistema pede uma confirmação ao cliente",
      "5. O cliente confirma a realização da encomenda",
      "6. O sistema regista a encomenda com o status pendente, e associa-a a um funcionário.",
      "7. O sistema confirma que a encomenda foi criada com sucesso."
    ),    
      ("Fluxo alternativo (1) (Cliente não confirma a encomenda)",
      "5.1 O cliente não confirma a operação.",
      "5.2 Volta ao 2"
    ),
      ("Fluxo de exceção (1) (Quantidade indisponível)",
      "3.1 O sistema informa que um ou mais componentes não estão disponíveis na encomenda solicitada.",
      "3.2 O sistema propõe ajustar a quantidade ou selecionar produtos alternativos, se aplicável."
    ),
  )
)<use_case_criar_encomenda>

#use_case_table(
  "Ativar notificações",
  "Cliente",
  "Cliente ativa notificações para receber atualizações",
  "O cliente está autenticado",
  "As notificações ficam ativadas e o cliente começa a receber alertas relevantes",
  (
    ("Fluxo Normal",
     "1. O cliente solicita ao sistema a ativação das notificações.",
      "2. O sistema regista a ativação das notificações para o cliente na base de dados.",
      "3. O sistema confirma que as notificações foram ativadas."
      ),
  )
)

#use_case_table(
  "Consultar perfil",
  "Cliente",
  "Cliente solicita ao sistema informações detalhadas sobre seu perfil.",
  "O cliente está autenticado.",
  "O sistema apresenta as informações do perfil.",
  (
    ("Fluxo Normal",
     "1. O cliente solicita ao sistema as informações do seu perfil.",
      "2. O sistema recupera as informações do perfil do Cliente na base de dados.",
      "3. O sistema apresenta as informações do perfil ao Cliente, como nome, email e outras informações"
      ),
  )
) 

#use_case_table(
  "Ver Progresso de montagem",
  "Cliente",
  "Cliente solicita ao sistema informações relacionadas à linha de montagem associada a uma encomenda",
  "O cliente está autenticado e tem pelo menos uma encomenda em produção",
  "O sistema fornece as informações desejadas",
  (
    ("Fluxo Normal",
     "1. O cliente solicita informações da linha de montagem associada a uma encomenda.",
      "2. O sistema recupera as informações da linha de montagem, como o status da produção ou o progesso da encomenda.",
      "3. O sistema apresenta as informações solicitadas ao Cliente",
      ),
  )
)<use_case_ver_progresso_montagem>


#use_case_table(
  "Atualizar estado de etapas",
  "Funcionário",
  "O Funcionário atualiza o estado de uma etapa, pertencente a uma linha de montagem.",
  "O Funcionário deve estar autenticado na plataforma e ter encomendas associadas.",
  "O sistema atualiza as informações alteradas da etapa",
  (
    ("Fluxo Normal",
     "1. O Funcionário acede a uma linha de montagem presente numa encomenda associada.",
      "2. O Sistema apresenta as etapas associadas à linha de montagem solicitada.",
      "3. O Funcionário realiza uma alteração do estado de uma etapa",
      "4. O sistema regista as ações realizadas pelo funcionário na base de dados.",
      "5. O sistema confirma a execução das ações.",
      ),
      ("Fluxo de exceção (1) (A linha de montagem pertence a uma encomenda já entregue)",
      "2.1 O sistema informa que a encomenda já foi entregue, sendo impossível realizar as alterações desejadas",
    ),
  )
)<use_case_atualizar_etapa>

#use_case_table(
  "Inserir elementos incorporados",
  "Funcionário",
  "O Funcionário atualiza os componentes já incorporados na montagem de um produto.",
  "O Funcionário deve estar autenticado na plataforma e ter encomendas associadas.",
  "O sistema realiza as alterações desejadas",
  (
    ("Fluxo Normal",
      "1. O Funcionário acede a uma linha de montagem presente numa encomenda associada.",
      "2. O Sistema apresenta os detalhes da linha de montagem solicitada.",
      "3. O Funcionário seleciona um ou mais componentes como incorporados ",
      "4. O sistema regista as ações realizadas pelo funcionário na base de dados.",
      "5. O sistema confirma a execução das ações.",
    ),
    ("Fluxo de exceção (1) (A linha de montagem pertence a uma encomenda já entregue)",
      "2.1 O sistema informa que a encomenda já foi entregue, sendo impossível realizar as alterações desejadas",
    ),
  )
)<use_case_incorporar_componentes>

#use_case_table(
"Listar Linhas de montagem",
"Administrador",
"O administrador lista todos as linhas de montagem presentes no sistema.",
"O administrador deve estar autenticado na plataforma",
"O administrador tem acesso a uma lista de todas as linhas de montagem do sistema",
  (
    ("Fluxo Normal",
       "1. O administrador solicita ao sistema uma lista de todas as linhas de montagem existentes.",
       "2. O Sistema consulta na base de dados todas as linhas de montagem existentes.",
       "3. O Sistema apresenta a lista solicitada, com os respetivos detalhes necessáros"
    ),
  )
)<use_case_listar_linhas_de_montagem>

#use_case_table(
"Editar Linha de montagem",
"Administrador",
"O administrador edita informações sobre uma linha de montagem.",
"O administrador deve estar autenticado na plataforma",
"O Sistema realizou as alterações desejadas",
  (
    ("Fluxo Normal",
       "1. O administrador seleciona uma linha de montagem para editar.",
       "2. O Sistema apresenta as informações da linha de montagem, e dá a possibilidade ao administrador de alterar as mesmas.",
       "3. O administrador introduz as alterações desejadas.",
       "4. O Sistema pede uma confirmação ao administrador.",
       "5. O administrador confirma as alterações.",
       "6. O sistema realiza as alterações desejadas."
     ),
    ("Fluxo Alternativo (1) (Administrador não confirma as alterações)",
      "5.1 O administrador não confirma as alterações.",
      "5.2 Volta ao 2."
     ),
    ("Fluxo de Exceção (1) (Alterações inválidas)",
      "5.1 O Sistema informa o administrador que as alterações são inválidas."
     )
  )
)<use_case_editar_linha_de_montagem>

#use_case_table(
"Listar Componentes",
"Administrador",
"O administrador lista todos os componentes presentes no sistema.",
"O administrador deve estar autenticado na plataforma",
"O administrador tem acesso a uma lista de todos os componentes do sistema",
  (
    ("Fluxo Normal",
       "1. O administrador solicita ao sistema uma lista de todos os componentes existentes.",
       "2. O Sistema consulta na base de dados todos os componentes existentes.",
       "3. O Sistema apresenta a lista solicitada, com os respetivos detalhes necessáros"
    ),
  )
)<use_case_listar_componentes>

#use_case_table(
"Editar Componente",
"Administrador",
"O administrador edita informações sobre um componente.",
"O administrador deve estar autenticado na plataforma",
"O Sistema realizou as alterações desejadas",
  (
    ("Fluxo Normal",
       "1. O administrador seleciona um componente para editar.",
       "2. O Sistema apresenta as informações do componente, e dá a possibilidade ao administrador de alterar as mesmas.",
       "3. O administrador introduz as alterações desejadas.",
       "4. O Sistema pede uma confirmação ao administrador.",
       "5. O administrador confirma as alterações.",
       "6. O sistema realiza as alterações desejadas."
     ),
    ("Fluxo Alternativo (1) (Administrador não confirma as alterações)",
      "5.1 O administrador não confirma as alterações.",
      "5.2 Volta ao 2."
     ),
    ("Fluxo de Exceção (1) (Alterações inválidas)",
      "5.1 O Sistema informa o administrador que as alterações são inválidas."
     )
  )
)<use_case_editar_componentes>

#use_case_table(
"Gerir Encomendas",
"Administrador",
"O administrador edita o status de uma encomenda.",
"O administrador deve estar autenticado na plataforma",
"O Sistema realizou as alterações desejadas",
  (
    ("Fluxo Normal",
       "1. O administrador seleciona uma encomenda para editar.",
       "2. O Sistema apresenta as informações da encomenda, e dá a possibilidade ao administrador de alterar o status da mesma.",
       "3. O administrador introduz as alterações desejadas.",
       "4. O Sistema pede uma confirmação ao administrador.",
       "5. O administrador confirma as alterações.",
       "6. O sistema realiza as alterações desejadas."
     ),
    ("Fluxo Alternativo (1) (Administrador não confirma as alterações)",
      "5.1 O administrador não confirma as alterações.",
      "5.2 Volta ao 2."
     ),
    ("Fluxo de Exceção (1) (Alterações inválidas)",
      "5.1 O Sistema informa o administrador que as alterações são inválidas."
     )
  )
)

#use_case_table(
"Listar Produtos",
"Administrador",
"O administrador lista todos os produtos presentes no sistema.",
"O administrador deve estar autenticado na plataforma",
"O administrador tem acesso a uma lista de todos os produtos do sistema",
  (
    ("Fluxo Normal",
       "1. O administrador solicita ao sistema uma lista de todos os produtos existentes.",
       "2. O Sistema consulta na base de dados todos os produtos existentes.",
       "3. O Sistema apresenta a lista solicitada, com os respetivos detalhes necessáros"
    ),
  )
)

#use_case_table(
"Editar Produto",
"Administrador",
"O administrador edita informações sobre um produto.",
"O administrador deve estar autenticado na plataforma",
"O Sistema realizou as alterações desejadas",
  (
    ("Fluxo Normal",
       "1. O administrador seleciona um produto para editar.",
       "2. O Sistema apresenta as informações do produto, e dá a possibilidade ao administrador de alterar as mesmas.",
       "3. O administrador introduz as alterações desejadas.",
       "4. O Sistema pede uma confirmação ao administrador.",
       "5. O administrador confirma as alterações.",
       "6. O sistema realiza as alterações desejadas."
     ),
    ("Fluxo Alternativo (1) (Administrador não confirma as alterações)",
      "5.1 O administrador não confirma as alterações.",
      "5.2 Volta ao 2."
     ),
    ("Fluxo de Exceção (1) (Alterações inválidas)",
      "5.1 O Sistema informa o administrador que as alterações são inválidas."
     )
  )
)

#attachment[Lista de Tabelas SQL completa] <lista_tabelas_sql>

\

#db_table(
  "Tabela de Utilizador",
  (
    ("ID", "INT", "Identificador único do utilizador"),
    ("NOME", "VARCHAR(40)", "Nome completo do utilizador"),
    ("EMAIL", "VARCHAR(50)", "Endereço de e-mail do utilizador (único)"),
    ("PASSWORDHASH", "VARCHAR(200)", " Hash da password utilizada pelo utilizador para iniciar sessão"),
    ("TELEFONE", "CHAR(9)", "Número de telefone do utilizador (único)"),
    ("TIPO", "VARCHAR(11)", "Tipo do Utilizador")
  )
)<tabela_db_utilizador>


#db_table(
  "Tabela de Administrador",
  (
    ("AdminId", "INT", "Identificador único do administrador"),
    ("Utilizador_ID", "INT", "Relação que identifica um administrador como um utilizador")
  )
)<tabela_db_administrador>

#db_table(
  "Tabela de Cliente",
  (
    ("NIF", "VARCHAR(9)", "Identificador único do Cliente. NIF do cliente"),
    ("Data_Nascimento", "DATE", "Data de nascimento do cliente"),
    ("Utilizador_ID", "INT", "Relação que identifica um cliente como um utilizador")
  )
)<tabela_db_cliente>

#db_table(
  "Tabela de Funcionário",
  (
    ("ID", "INT", "Identificador único do Funcionário"),
    ("Utilizador_ID", "INT", "Relação que identifica um funcionário como um utilizador")
  )
)<tabela_db_funcionario>

#db_table(
  "Tabela de Encomenda",
  (
    ("ID", "INT", "Identificador único da Encomenda"),
    ("Data_Entrega", "DATE", "Data em que será entregue a encomenda(Opcional)"),
    ("Rua", "VARCHAR(45)", "Rua para a qual deverá ser enviada a encomenda"),
    ("Código_Postal", "CHAR(8)", "Código postal para o qual deverá ser enviada a encomenda"),
    ("Porta", "INT", "Número da porta da casa para a qual deverá ser enviada a encomenda"),
    ("Cliente_ID", "VARCHAR(9)", "Relação que identifica o cliente que realizou a encomenda"),
    ("Estado_ID", "INT", "Relação que identifica o estado no qual se encontra a encomenda"),
    ("Funcionário_ID", "INT", "Relação que identifica o funcionário responsável pela encomenda")
  )
)<tabela_db_encomenda>

#db_table(
  "Estado_Encomenda",
  (
    ("ID", "INT", "Identificador único do Estado da Encomenda"),
    ("Estado", "VARCHAR(20)", "Estado da encomenda")
  )
)<tabela_db_estado_encomenda>

#db_table(
  "Tabela de ProdutoDisplay",
  (
    ("ID", "INT", "Identificador único do ProdutoDisplay"),
    ("Nome", "VARCHAR(30)", "Nome do produto"),
    ("Titulo", "VARCHAR(100)", "Titulo do produto"),
    ("Descrição", "TEXT", "Descrição do produto"),
    ("Preço", "DECIMAL", "Preço do produto"),
    ("Imagem", "VARCHAR(100)", "Caminho  relativo à imagem do produto")
  )
)<tabela_db_produto_display>

#db_table(
  "Tabela de Produto",
  (
    ("ID", "INT", "Identificador único do produto"),
    ("Display_ID", "INT", "Relação que identifica o ProdutoDisplay associado ao produto"),
    ("Encomenda_ID", "INT", "Relação que identifica a encomenda à qual pertence o produto")
  )
)<tabela_db_produto>

#db_table(
  "Tabela da LinhaDeMontagem",
  (
    ("ID", "INT", "Identificador único da Linha de Montagem"),
    ("Nome", "VARCHAR(40)", "Nome da linha de montagem"),
    ("TempoEstimado", "TIME", "Tempo estimado que demorará a conclusão da montagem do produto")
  )
)<tabela_db_linha_de_montagem>

#db_table(
  "Tabela da Linha_Produto",
  (
    ("ID", "INT", "Identificador único da Linha do Produto"),
    ("Tempo_de_Montagem", "TIME", "Tempo decorrido na Linha do Produto"),
    ("Percentagem_Conclusao", "INT", "Percentagem do Produto que já se encontra montado"),
    ("Produto_ID", "INT", "Relação que identifica o produto ao qual a linha de montagem está associada"),
    ("Estado_Montagem_ID", "INT", "Relação que identifica o estado no qual se encontra a montagem"),
    ("Linha_ID", "INT", "Relação que identifica a Linha de Montagem à qual a Linha do Produto está associda")
  )
)<tabela_db_linha_produto>

#db_table(
  "Tabela da Etapa",
  (
    ("ID", "INT", "Identificador único da Etapa"),
    ("NumeroEtapa", "INT", "Número da etapa"),
    ("Instrução", "VARCHAR(100)", "Instrução que deve ser seguida na etapa"),
    ("Descrição", "VARCHAR(255)", "Descrição da etapa"),
    ("Imagem", "VARCHAR(100)", "Imagem da Etapa"),
    ("Linha_de_Montagem_ID", "INT", "Relação que identifica a Linha de Montagem à qual a etapa está associada")
  )
)<tabela_db_etapa>

#db_table(
  "Estado_Montagem",
  (
    ("ID", "INT", "Identificador único do Estado da Montagem"),
    ("Estado", "VARCHAR(20)", "Estado no qual se encontra a montagem")
  )
)<tabela_db_estado_montagem>

#db_table(
  "Tabela de Notificação",
  (
    ("ID", "INT", "Identificador único da Notificação"),
    ("Título", "VARCHAR(45)", "Título da Notificação"),
    ("Descrição", "TEXT", "Conteúdo da Notificação"),
    ("Utilizador_ID", "INT", "Relação que identifica o utilizador que recebe a notificação")
  )
)<tabela_db_notificacao>

#db_table(
  "Tabela da Componente",
  (
    ("ID", "INT", "Identificador único da Componente"),
    ("Nome_da_Componente", "VARCHAR(45)", "Nome da componente"),
    ("Quantidade", "INT", "Quantidade da componente disponível em stock"),
    ("Cor", "VARCHAR(25)", "Cor da componente(Opcional)")
  )
)<tabela_db_componente>

#db_table(
  "Tabela da Componente_Produto",
  (
    ("Componente_Id", "INT", "Relação que identifica a componente à qual o produto está associado, parte da Primary Key composta"),
    ("Produto_ID", "INT", "Relação que identifica o produto ao qual a componente pertence, parte da Primary Key composta"),
    ("Quantidade", "INT", "Quantidade da componente utilizada no produto associado")
  )
)<tabela_db_componente_produto>

#pagebreak()

#attachment[Lista de Esboços completa] <lista_de_esboços>

\

#mockup("Landing.png",caption: [Landing page]) <esboço_landing_page>

#mockup("Destaques - Normal.png",caption: [Página de Destaques]) <esboço_destaques_sem_user>

#mockup("Destaques - User Autenticado.png",caption: [Página de Destaques - Cliente Autenticado])

#mockup("Destaques - Admin Autenticado.png",caption: [Página de Destaques - Administrador Autenticado])

#mockup("Destaques - Funcionario Autenticado.png",caption: [Página de Destaques - Funcionário Autenticado])

#mockup("Perfil - user.png",caption: [Página de Perfil]) <esboço_perfil>

#mockup("Cliente - Encomendas (Ativas).png",caption: [Cliente - Encomendas Pendentes])

#mockup("Cliente - Encomenda Especificada.png",caption: [Cliente - Encomenda Especificada])

#mockup("Linha de montagem - etapa 0 - utilizador.png",caption: [Cliente - Linha de Montagem])

#mockup("Funcionario - encomendas.png",caption: [Funcionário - Encomendas em Andamento]) <esboço_encomendas_funcionário>

#mockup("Funcionario - encomendas entregues.png",caption: [Funcionário - Encomendas Entregues])

#mockup("Funcionario - encomenda especificada.png",caption: [Funcionário - Encomenda Especificada]) <esboço_encomenda_especificada>

#mockup("Linha de montagem - etapa 1.png",caption: [Funcionário - Linha de Montagem (estrutura)]) 

#mockup("Linha de montagem - etapa 2.png",caption: [Funcionário - Linha de Montagem (etapa 2)]) <esboço_linha_de_montagem>

#mockup("Linha de montagem - etapa final.png",caption: [Funcionário - Linha de Montagem (final)])

#mockup("Produto - VASO STANDARD.png",caption: [Produto (vaso standard)]) <esboço_produtos>

#mockup("PRODUTO - VASO DELUXE.png",caption: [Produto (vaso deluxe)])

#mockup("Painel de Administração.png",caption: [Página de Administração]) <esboço_painel_de_admin_>

#mockup("Painel de Administração - Encomendas.png",caption: [Página de gestão de encomendas (ativas)])

#mockup("Painel de Administração - Encomendas entregues.png",caption: [Página de gestão de encomendas (entregues)])

#mockup("Painel de Administração - Encomendas entregues.png",caption: [Página de gestão de encomendas])

#mockup("Painel de Administração - Produtos.png",caption: [Página de gestão de produtos])

#mockup("Painel de Administração - Produtos - editar.png",caption: [Página de gestão de produtos])

#mockup("Painel de Administração - Componentes.png",caption: [Página de gestão de componentes])

#mockup("Painel de Administração - Componentes - add.png",caption: [Página de gestão de componentes (adicionar stock)])

#mockup("Painel de Administração - Linha montagem.png",caption: [Página de gestão de linhas de montagem])

#mockup("Painel de Administração - Linha Montagem Espec.png",caption: [Página de gestão de linhas de montagem (especifica)])

#mockup("Painel de Administração - linha montagem - editar.png",caption: [Página de gestão de linhas de montagem (editar etapa)])

#mockup("Carrinho V2 - 2 produtos.png",caption: [Página do carrinho (2 produtos)])

#mockup("Carrinho V2 - 1 produto.png",caption: [Página do carrinho (1 produto)])

#mockup("Carrinho V2 - 0 produto.png",caption: [Página do carrinho (vazio)])

#mockup("Register Simples.png",caption: [Página de registo]) <esboço_registo>

#mockup("Register Simples - correto.png",caption: [Página de registo (correto)])

#mockup("Register Erro - EMAIL ERRADO.png",caption: [Página de registo (email errado)])

#mockup("Register Erro - EMAIL JA REGISTADO.png",caption: [Página de registo (email utilizado)])

#mockup("Register Erro - nif ERRADO.png",caption: [Página de registo (NIF errado)])

#mockup("Register Erro - Menor.png",caption: [Página de registo (utilizador menor)])

#mockup("Entrar.png",caption: [Página de inicio de sessão])

#mockup("Entrar Sucesso.png",caption: [Página de inicio de sessão (certo)])

#mockup("Entrar Erro - password inválida.png",caption: [Página de inicio de sessão (password errada)])

#mockup("Entrar Erro - conjunto errado.png",caption: [Página de inicio de sessão (conjunto errado)])

#attachment[Código SQL de inicialização do Sistema de Dados] <codigoSQL>

#raw(read("attachments/tables.sql"), lang: "sql")

#attachment[Lista exaustiva de páginas implementadas do sistema] <lista_exaustiva_paginas>

#let paginaFigure(name, caption: []) = figure(
  box(stroke: 1pt, image("images/pages/" + name)), 
  caption: caption, 
  kind: "page", 
  supplement: [Página]
)

#paginaFigure("paginainicial.png", caption: [Página Inicial implementada ]) <paginainicial>
\
\
#paginaFigure("destaques.png", caption: [Página de destaques implementada ]) <pagina_destaques>

#paginaFigure("displayVasoStandard.png", caption: [Página de display do Vaso Standard implementada não autenticado]) <pagina_display_vaso_standard>
\
\
#paginaFigure("displayVasoDeluxe.png", caption: [Página de display do Vaso Deluxe implementada não autenticado ]) <pagina_display_vaso_deluxe>

#paginaFigure("displayVasoStandardAutenticado.png", caption: [Página de display do Vaso Deluxe implementada autenticado ]) <pagina_display_vaso_deluxe>

#paginaFigure("asminhasencomendas.png", caption: [Página de encomendas pendentes associado a um cliente implementada  ]) <pagina_encomendas>

#paginaFigure("asminhasEncomendasConcluidas.png", caption: [Página de encomendas concluidas associado a um cliente implementada  ]) <pagina_encomendas_concluidas>

#paginaFigure("detalhesEncomendas.png", caption: [Página dos detalhes de uma encomenda associado a um cliente implementada  ]) <pagina_detalhes_encomenda>

#paginaFigure("detalhesLinhaMontagemCliente.png", caption: [Página dos detalhes de uma linha de montagem associado a um cliente implementada  ]) <pagina_detalhes_linha_montagem>

#paginaFigure("carrinho vazio.png", caption: [Página do carrinho vazio implementada  ]) <pagina_carrinho_vazio>

#paginaFigure("carrinhoComUmaEncomenda.png", caption: [Página do carrinho com uma encomenda e seus detalhes implementada  ]) <pagina_carrinho_encomenda1>

#paginaFigure("carrinho2vasos.png", caption: [Página do carrinho com duas encomenda e seus detalhes implementada  ]) <pagina_carrinho_encomenda2>

#paginaFigure("perfilCliente.png", caption: [Página do perfil do cliente implementada ]) <pagina_perfil_cliente>

#paginaFigure("notificacoes.png", caption: [Página de notificações do cliente implementada ]) <pagina_notificacoes_cliente>

#paginaFigure("iniciarSessao.png", caption: [Página de iniciar sessão implementada ]) <pagina_iniciar_sessao>

#paginaFigure("register.png", caption: [Página de registo implementada ]) <pagina_registo>

#paginaFigure("notificacoesAdmin.png", caption: [Página de notificações do Admininistrador implementada ]) <pagina_notificacoes_admin>

#paginaFigure("painelAdmin.png", caption: [Página de painel do Admininistrador implementada ]) <pagina_painel_admin>

#paginaFigure("gerirprodutos.png", caption: [Página de gerir produtos associado ao Admininistrador implementada ]) <pagina_gerir_produtos>

#paginaFigure("edicaoproduto.png", caption: [Página de editar produto 'Vaso Standard' associado ao Admininistrador implementada ]) <pagina_edicao_produto>

#paginaFigure("edicaoProdutoDeluxe.png", caption: [Página de editar produto 'Vaso Deluxe' associado ao Admininistrador implementada ]) <pagina_edicao_deluxe>

#paginaFigure("gerircomponentes.png", caption: [Página de gerir componentes associado ao Admininistrador implementada ]) <pagina_gerir_componentes>

#paginaFigure("adicionarStock.png", caption: [Página de adicionar stock associado ao Administrador implementada ]) <pagina_adicionar_stock>

#paginaFigure("gerirLinhaMontagem.png", caption: [Página de gerir uma linha de montagem associado ao Administrador implementada ]) <pagina_gerir_linha_montagem>

#paginaFigure("edicaoetapa.png", caption: [Página de escolher uma etapa para edição associado ao Administrador implementada ]) <pagina_escolher_etapa>

#paginaFigure("edição etapa.png", caption: [Página de edição de uma etapa associado ao Administrador implementada ]) <pagina_edicao_etapa>

#paginaFigure("gerirencomendas.png", caption: [Página de gerir encomendas pendentes associado ao Administrador implementada ]) <pagina_gerir_encomendas>

#paginaFigure("gerirencomendaentregue.png", caption: [Página de gerir encomendas entregues associado ao Administrador implementada ]) <pagina_gerir_encomenda_entregue>

#paginaFigure("funcionario.png", caption: [Página de encomendas associado ao funcionário implementada ]) <pagina_encomendas_funcionario>

#paginaFigure("funcionarioEncomenda.png", caption: [Página de uma encomenda associado a um funcionário implementada]) <pagina_encomenda_funcionario>

#paginaFigure("linhamontagemfuncionario.png", caption: [Página de uma linha de montagem associado a um funcionário implementada]) <pagina_linhamontagem_funcionario>























































