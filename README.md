# Point Pet

Mapa colaborativo para encontrar e cadastrar pontos de doação, lojas e clínicas veterinárias.

**Site:** [point-pet-map.vercel.app](https://point-pet-map.vercel.app/)

## O que o site faz

- Exibe no mapa locais aprovados e os cadastros pendentes da própria pessoa.
- Filtra por doação, loja ou clínica e busca por nome ou endereço.
- Com a localização ativada, ordena os locais por distância e mostra a margem estimada de precisão no mapa.
- Abre detalhes com endereço, telefone, horário e distância em linha reta.
- Calcula rota de carro até o local selecionado.
- Permite que uma pessoa autenticada cadastre um local tocando no ponto do mapa e exclua os próprios cadastros.
- Mantém novos cadastros como pendentes até a aprovação da equipe.

## Contas e autenticação

A tela de conta oferece e-mail e senha, Google e telefone por SMS. Neste projeto, o provedor de e-mail está ativo e exige confirmação do endereço. Google e telefone aparecem na interface, mas ainda precisam ser habilitados e configurados no Supabase para funcionar.

O envio de confirmação de e-mail usa o serviço padrão do Supabase enquanto não houver SMTP próprio. Esse serviço tem limites e só envia para endereços da equipe do projeto; para permitir cadastro do público geral, configure um servidor SMTP em **Authentication → Emails**. Consulte o [guia de SMTP do Supabase](https://supabase.com/docs/guides/auth/auth-smtp).

### Ativar Google

1. Crie credenciais OAuth para um aplicativo Web no Google Cloud.
2. Cadastre no Google o callback do Supabase: `https://<project-ref>.supabase.co/auth/v1/callback`.
3. Em **Supabase → Authentication → Sign In / Providers → Google**, habilite o provedor e informe o Client ID e o Client Secret.

### Ativar telefone

Em **Supabase → Authentication → Sign In / Providers → Phone**, habilite o provedor e configure um serviço de SMS, como Twilio. A conta e as credenciais do provedor são necessárias; o envio de SMS pode ter custo.

## Configuração do Supabase

1. Crie um projeto Supabase e execute [`supabase/schema.sql`](supabase/schema.sql) no SQL Editor.
2. Copie a Project URL e a chave pública `anon`/publishable para as constantes `SUPABASE_URL` e `SUPABASE_ANON_KEY` no script de [`index.html`](index.html).
3. Em **Authentication → URL Configuration**, use `https://point-pet-map.vercel.app/` como Site URL e permita esse endereço em Redirect URLs. Para testar localmente, permita também a URL local completa.

A chave pública é usada no navegador. A proteção dos dados depende das políticas RLS do banco: qualquer visitante pode ler locais aprovados, cada usuário autenticado vê também os próprios pendentes, novos registros são criados como pendentes e somente o dono pode excluir seu cadastro.

## Rodar localmente

Na pasta do projeto, execute:

```bash
python3 -m http.server 8000
```

Abra `http://localhost:8000`. A geolocalização do navegador requer `localhost` ou uma conexão HTTPS. O endereço local usado no fluxo de autenticação também precisa estar permitido em Redirect URLs no Supabase.

## Publicação

O site é estático e não precisa de servidor de aplicação. A branch `main` do GitHub está conectada à Vercel; um `git push` nessa branch inicia a publicação em [point-pet-map.vercel.app](https://point-pet-map.vercel.app/).

## Serviços externos e limitações

- **Mapa:** Leaflet com tiles do OpenStreetMap.
- **Rotas:** serviço público de demonstração OSRM; rota apenas de carro e sem dados de trânsito. Não é recomendado para tráfego elevado.
- Não há upload de fotos nem edição de cadastros. Para corrigir um local, exclua e cadastre novamente.
- A aprovação de cadastros é feita manualmente em **Supabase → Table Editor → locations**, alterando `status` para `approved`.

Ícones: Lucide. Fontes: Google Fonts. Mapa © colaboradores do OpenStreetMap.
