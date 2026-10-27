# Point Pet

Mapa colaborativo de locais para pets: abrigos e pontos de doação, lojas de itens para pet e clínicas veterinárias. Qualquer pessoa vê os locais aprovados. Para cadastrar ou excluir um local, a pessoa entra na conta (e-mail e senha, Google ou telefone). Cada um só exclui os próprios cadastros. O site também mostra a rota de carro até o local.

## Arquivos

- `index.html`: estrutura, mapa, lista, cadastro, login e rotas.
- `styles.css`: aparência e versão para celular.
- `supabase/schema.sql`: tabela de locais e regras de acesso do banco.
- `README.md`: este arquivo.

## 1. Criar o banco e as contas (Supabase, gratuito)

1. Crie um projeto em [supabase.com](https://supabase.com).
2. Em **SQL Editor**, cole o conteúdo de `supabase/schema.sql` e execute.
3. Em **Project Settings > API**, copie a **Project URL** e a chave **anon public**. Cole as duas no início do script de `index.html`, nas constantes `SUPABASE_URL` e `SUPABASE_ANON_KEY`. A chave anon pode ficar pública. A segurança está nas regras do banco.
4. Em **Authentication > URL Configuration**, adicione o endereço do site (ex.: `https://pontpet.com.br`) e `http://localhost:8000` nas **Redirect URLs**.

### Login por e-mail e senha

Já vem ativo. Em **Authentication > Providers > Email**, escolha se o e-mail precisa de confirmação.

### Login com Google

1. No Google Cloud Console, crie um **ID do cliente OAuth** do tipo *Aplicativo da Web*.
2. Em *URIs de redirecionamento autorizados*, adicione `https://SEU-PROJETO.supabase.co/auth/v1/callback`.
3. No Supabase, em **Authentication > Providers > Google**, ative o provedor e cole o Client ID e o Client Secret.

### Login por telefone (SMS)

Em **Authentication > Providers > Phone**, ative o provedor e escolha um serviço de SMS, como o Twilio. Você informa a conta e o token desse serviço no Supabase. O envio de SMS é cobrado pelo provedor escolhido.

## 2. Aprovação dos locais

Cadastros novos entram como **pendentes**. O dono já vê o próprio cadastro, mas o público só vê depois de aprovado. Para aprovar, abra **Table Editor > locations** e mude `status` para `approved`.

Se preferir publicar na hora, troque `'pending'` por `'approved'` no `default` da coluna `status` e na regra "criar próprio como pendente" do `schema.sql`.

## 3. Como publicar

O site continua estático. Envie os arquivos para GitHub Pages, Netlify, Vercel, Cloudflare Pages ou outra hospedagem comum. Não é preciso servidor de aplicação.

Para testar localmente, rode `python3 -m http.server 8000` dentro da pasta e abra `http://localhost:8000`. A localização do navegador só funciona em `localhost` ou em `https`.

## Serviços externos

- **Mapa:** tiles do OpenStreetMap. A atribuição já aparece no mapa, como exige a licença.
- **Rotas:** servidor público de demonstração do OSRM. Não deve receber muito tráfego. Para produção, hospede o seu próprio OSRM ou contrate um provedor e troque a URL na função `calcularRota`.
- **Rotas disponíveis:** apenas de carro. Não considera trânsito.

## Limitações conhecidas

- **Sem fotos** e **sem edição**. Depois de salvo, o cadastro só pode ser excluído e recriado.
- **Sem painel de moderação.** A aprovação é feita no Table Editor do Supabase.
- **Cadastros antigos** feitos no navegador (versão anterior) não são migrados automaticamente.

## Licença e créditos

Mapa © colaboradores do OpenStreetMap. Ícones: Lucide (ISC). Fontes: Google Fonts (SIL OFL). Banco e contas: Supabase.
