-- Cole no Supabase: SQL Editor > New query > Run
create table if not exists public.checklists (
  user_id uuid primary key references auth.users(id) on delete cascade,
  dados jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.checklists enable row level security;
create policy "cada usuario le o proprio" on public.checklists for select using (auth.uid() = user_id);
create policy "cada usuario insere o proprio" on public.checklists for insert with check (auth.uid() = user_id);
create policy "cada usuario altera o proprio" on public.checklists for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
