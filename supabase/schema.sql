-- Point Pet: tabela de locais com regras de acesso (RLS).
-- Rode este arquivo no SQL Editor do Supabase.

create table if not exists public.locations (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  categoria   text not null check (categoria in ('doacao', 'loja', 'clinica')),
  nome        text not null check (char_length(nome) between 2 and 120),
  endereco    text not null check (char_length(endereco) between 5 and 200),
  telefone    text check (telefone is null or char_length(telefone) <= 30),
  horario     text check (horario is null or char_length(horario) <= 120),
  lat         double precision not null check (lat between -90 and 90),
  lng         double precision not null check (lng between -180 and 180),
  status      text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  created_at  timestamptz not null default now()
);

create index if not exists locations_status_idx on public.locations (status);

alter table public.locations enable row level security;

-- Todos veem os locais aprovados. O dono também vê os próprios, inclusive pendentes.
create policy "ver aprovados ou próprios" on public.locations
  for select to anon, authenticated
  using (status = 'approved' or user_id = auth.uid());

-- Só quem entrou cria, em seu próprio nome, e sempre como 'pending'.
-- Assim ninguém consegue aprovar o próprio cadastro.
create policy "criar próprio como pendente" on public.locations
  for insert to authenticated
  with check (user_id = auth.uid() and status = 'pending');

-- Só o dono exclui o próprio cadastro.
create policy "excluir próprio" on public.locations
  for delete to authenticated
  using (user_id = auth.uid());
