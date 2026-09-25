-- Aloba-IT — schéma PostgreSQL (Supabase)
-- À exécuter une seule fois dans SQL Editor > New query > Run

create table terms (
  id bigint generated always as identity primary key,
  t text not null,                    -- nom du terme
  c text not null,                    -- catégorie
  d text not null,                    -- définition
  install jsonb,                      -- tableau [{m, cmd}, ...] ou null
  created_at timestamptz default now()
);

create table posts (
  id bigint generated always as identity primary key,
  tag text not null,
  date text not null,
  title text not null,
  excerpt text not null,
  content text not null,
  created_at timestamptz default now()
);

-- Active la sécurité au niveau des lignes (obligatoire sur Supabase)
alter table terms enable row level security;
alter table posts enable row level security;

-- Le site public peut seulement LIRE les données
create policy "Lecture publique des termes" on terms for select using (true);
create policy "Lecture publique des articles" on posts for select using (true);

-- Personne ne peut écrire avec la clé publique (anon) : seul l'admin,
-- via la clé service_role (qui contourne la RLS), pourra ajouter/supprimer.
