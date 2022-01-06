-- TYPES
create type public.app_role as enum ('admin', 'user', 'student', 'alumni')

-- TABLES
-- profiles
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

-- blogposts
create table public.blogposts (
  id uuid default uuid_generate_v4() primary key,
  created_at default now() timestamptz,
  last_updated default now() timestamptz,
  title character not null,
  desc text,
  slug character not null,
  author character not null
);
alter table public.blogposts enable row level security;

-- blogtags
create table public.blogtags (
  id uuid default uuid_generate_v4() primary key,
  name character not null
);
alter table public.blogtags enable row level security;

-- blogpost_tags
create table public.blogpost_tags (
  blogpost_id uuid references public.blogposts,
  blogtag_id uuid references public.blogtags,
  primary key (blogpost_id, blogtag_id)
)
alter table public.blogpost_tags enable row level security;

-- VIEWS
-- blogpost_tags_aggr
create view blogpost_tags_aggr as
  select 
    post.*, 
    array_agg(tag.name) as tags
  from blogposts post
  left join blogpost_tags pt
  on post.id = pt.blogpost_id
  left join blogtags tag
  on tag.id = pt.blogtag_id
  group by post.id

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
