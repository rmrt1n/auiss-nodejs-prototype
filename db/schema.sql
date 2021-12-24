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

alter table public.profiles enable row level security;

create policy "Enable read access to all loggedin users" on public.profiles 
  for select using (auth.role() = 'authenticated');
create policy "Enable update access for users based on id" on public.profiles
  for update using (auth.uid() = id)
  with check (auth.uid() = id)


-- clubs
create table public.clubs (
  id uuid default uuid_generate_v4() primary key,
  name character not null,
  desc text not null,
  thumbnail_path character not null
);

alter table public.clubs enable row level security;

create policy "Enable clubs read to everyone" on public.clubs 
  for select using (true);


-- user roles
create table public.user_roles (
  user_id uuid primary key references public.profiles,
  role app_role not null
)
alter table public.user_roles enable row level security;

create policy "Enable read access to user only" on public.profiles 
  for select using (auth.uid() = id);
create policy "Enable update access for users based on id" on public.profiles
  for update using (auth.uid() = id)
  with check (auth.uid() = id)


-- user clubs
create table public.user_clubs (
  user_id uuid references public.profiles,
  club_id uuid references public.clubs,
  primary key (user_id, club_id)
)
alter table public.user_clubs enable row level security;


-- FUNCTIONS
create function public.handle_new_user() 
returns trigger 
language plpgsql 
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, tp_number)
  values (new.id, upper(split_part(new.email, '@', 1)));

  insert into public.user_roles (id, role)
  values (new.id, 'user'));

  return new;
end;
$$;

-- TRIGGERS
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
