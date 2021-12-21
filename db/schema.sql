-- TYPES
create type public.app_role as enum ('admin', 'user', 'student', 'alumni')

-- TABLES
-- user profiles
create table public.profiles (
  id uuid primary key references auth.users,
  name character,
  tp_number character not null,
  gender character,
  birthdate date default now() not null,
  course character,
  intake_year smallint,
  intake_month smallint
);

-- clubs
create table public.clubs (
  id uuid default uuid_generate_v4() primary key,
  name character not null,
  desc text not null,
  thumbnail_path character not null
);

-- user roles
create table public.user_roles (
  id uuid primary key references public.profiles,
  role app_role not null
)

-- ROW LEVEL SECURITY
alter table public.profiles enable row level security;
alter table public.clubs enable row level security;
alter table public.user_roles enable row level security;
create policy "Enable profile read to everyone" on public.profiles for select using (true);
create policy "Enable clubs read to everyone" on public.clubs for select using (true);

-- FUNCTIONS
create function public.handle_new_user() 
returns trigger 
language plpgsql 
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, tp_number)
  values (new.id, split_part(new.email, '@', 1));

  insert into public.user_roles (id, role)
  values (new.id, 'user'));

  return new;
end;
$$;

-- TRIGGERS
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
