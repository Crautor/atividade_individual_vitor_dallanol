# Guia de Sustentabilidade

**Autor:** Vitor Dallanol

## Descrição do App

O **Guia de Sustentabilidade** é um aplicativo que sugere práticas sustentáveis no dia a dia, adaptadas ao estilo de vida do usuário. Ele utiliza inteligência artificial para gerar recomendações personalizadas e oferece uma interface intuitiva para interação, incluindo reconhecimento de voz e suporte a markdown para formatação de mensagens.

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento do aplicativo.
- **flutter_markdown**: Renderização de mensagens com suporte a markdown.
- **HTTP**: Comunicação com a API de inteligência artificial.

## Instruções de Instalação e Execução

1. Clone este repositório:
   ```bash
   git clone https://github.com/Crautor/atividade_individual_vitor_dallanol.git
   ```
2. Navegue até o diretório do projeto:
   ```bash
   cd atividade_individual_vitor_dallanol
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o aplicativo:
   ```bash
   flutter run
   ```

## Explicação de como o LLM foi Utilizado

O aplicativo utiliza um modelo de linguagem (LLM) para gerar sugestões personalizadas de práticas sustentáveis. O prompt inicial define o contexto e as diretrizes para o modelo, garantindo que as respostas sejam relevantes e fundamentadas em boas práticas de sustentabilidade. A API processa as entradas do usuário e retorna recomendações adaptadas ao seu estilo de vida, que são exibidas no app com formatação markdown para melhor legibilidade.

### Prompt Base
Você é um assistente especializado em sustentabilidade que sugere práticas sustentáveis realistas e seguras para o dia a dia, adaptadas ao estilo de vida do usuário. Antes de responder, verifique se a entrada do usuário está relacionada a temas de sustentabilidade, como práticas ambientais, consumo consciente, mobilidade sustentável, energia, resíduos, hábitos ecológicos ou qualquer outro assunto vinculado à sustentabilidade. Caso esteja relacionada, prossiga normalmente com a sugestão de práticas sustentáveis personalizadas. Caso não esteja relacionada, responda corretamente à pergunta com base no seu conhecimento geral, mas informe de forma educada no início da resposta que sua especialidade é sustentabilidade e que você pode não oferecer o melhor desempenho fora desse tema.Quando a entrada for relevante para sustentabilidade, leve em consideração o contexto cultural, econômico e social do usuário com base nas informações fornecidas. Priorize recomendações éticas, seguras, acessíveis e viáveis dentro de uma rotina comum. Evite sugestões radicais, ilegais ou que possam comprometer a saúde, o bem-estar ou os direitos do usuário e de outras pessoas. Fundamente suas sugestões em boas práticas reconhecidas e, sempre que possível, aponte brevemente o benefício ambiental de cada uma.A resposta deve começar com um resumo do estilo de vida do usuário em até duas frases, seguido de três a cinco sugestões personalizadas, cada uma acompanhada de uma explicação concisa sobre o motivo da recomendação.Texto de entrada do usuário: <local onde será inserido o texto inputado pelo usuario>


## Imagens do App Funcionando

### Pedindo ajuda para LLM (mostrando loading)
![Screenshot from 2025-04-29 22-07-10](https://github.com/user-attachments/assets/c9f90e45-2df9-40be-82b6-24d44ece259f)

### Pedindo para o LLM um prompt sujerido por ela
![Screenshot from 2025-04-29 22-05-45](https://github.com/user-attachments/assets/54927e9d-766e-41d3-bc7a-e40419d5b514)

### Mostrando tratamento de erro (opção de retry para o ultimo prompt)
![Screenshot from 2025-04-29 22-07-23](https://github.com/user-attachments/assets/d0a5d037-c6da-4590-bac1-1160c8258498)

### Mostrando o prompt reutilizado pelo retry
![Screenshot from 2025-04-29 22-07-38](https://github.com/user-attachments/assets/2eac94cf-53cb-4d5f-a247-44e425f49c42)



