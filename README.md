# Point Pet

Mapa colaborativo de locais para pets: abrigos e pontos de doação, lojas de itens para pet e clínicas veterinárias. Qualquer pessoa pode cadastrar um local marcando-o no mapa. Quem cadastrou pode excluir o próprio cadastro. O site também mostra a rota de carro até o local, sem sair da página.

## Arquivos

- `index.html`: estrutura e lógica do site (mapa, lista, busca, filtros, cadastro, exclusão e rotas).
- `styles.css`: aparência (cores, tipografia, layout e versão para celular).
- `README.md`: este arquivo.

Não há o que instalar. As bibliotecas são carregadas pela internet:

- Leaflet 1.9.4 (mapa)
- Lucide 0.383.0 (ícones)
- Fontes Bricolage Grotesque e Figtree (Google Fonts)

## Como abrir

Extraia o zip numa pasta `point-pet` e, dentro dela, rode um servidor local simples. A localização do navegador só funciona em `http://localhost` ou em `https`:

```bash
cd point-pet
python3 -m http.server 8000
```

Depois abra `http://localhost:8000` no navegador.

## Como publicar

Envie os arquivos para qualquer hospedagem de site estático (GitHub Pages, Netlify, Vercel, Cloudflare Pages ou uma hospedagem comum). Não é preciso servidor de aplicação.

## Como funciona o cadastro

1. Toque em **Cadastrar local** no topo.
2. Preencha nome, tipo, endereço e, se quiser, telefone e horário.
3. Toque em **Marcar no mapa** e, em seguida, no ponto exato do local.
4. Toque em **Salvar cadastro**.

Para excluir, abra o local na lista ou no mapa e toque em **Excluir meu cadastro**. O botão só aparece para quem criou o cadastro e pede confirmação antes de apagar.

## Onde os dados ficam

**Os cadastros são salvos no próprio navegador** (`localStorage`). Isso significa:

- Um cadastro aparece apenas no navegador onde foi feito. Outras pessoas não o veem.
- Cada navegador recebe um identificador próprio. Só ele consegue excluir os cadastros que criou.
- Se o usuário limpar os dados do navegador, perde a lista de cadastros e a capacidade de excluí-los.

Para um mapa realmente compartilhado, é preciso um banco de dados com contas de usuário. Por exemplo, Supabase, Firebase ou um backend próprio. Nesse caso, a exclusão passaria a ser validada no servidor, e não no navegador.

## Serviços externos

- **Mapa:** tiles do OpenStreetMap (`tile.openstreetmap.org`). A atribuição já aparece no mapa, como exige a licença.
- **Rotas:** servidor público de demonstração do OSRM (`router.project-osrm.org`). É gratuito e não exige chave, mas não deve receber muito tráfego. Para produção, hospede o seu próprio OSRM ou contrate um provedor de rotas, e troque a URL na função `calcularRota` dentro de `index.html`.
- **Rotas disponíveis:** apenas de carro. O servidor público não oferece trajeto a pé.

## Limitações conhecidas

- **Cadastros locais.** Veja a seção acima. Esta versão não é compartilhada entre usuários.
- **Sem fotos.** O formulário não tem envio de imagem.
- **Sem edição.** Depois de salvo, o cadastro só pode ser excluído e recriado.
- **Sem moderação.** Qualquer pessoa pode cadastrar qualquer coisa. Em um site público, seria preciso revisar os cadastros antes de exibi-los.
- **Tempo de carro estimado pelo servidor de rotas.** Não considera trânsito.

## Licença e créditos

Mapa © colaboradores do OpenStreetMap. Ícones: Lucide (ISC). Fontes: Google Fonts (SIL OFL).
