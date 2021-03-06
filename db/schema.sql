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

-- not working in load functions
-- atm this is set to (true)
create policy "Enable read for logged in users" on public.profiles 
  for select using (auth.role() = 'authenticated');

create policy "Enable update for users based on id" on public.profiles
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

create policy "Enable read for everyone" on public.clubs 
  for select using (true);

create policy "Enable insert for users with admin role" on public.clubs
  for insert with check (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )

create policy "Enable delete for users with admin role" on public.clubs
  for delete using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )

create policy "Enable update for users with admin role" on public.clubs
  for update using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  ) with check (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )


-- user roles
create table public.user_roles (
  user_id uuid primary key references public.profiles,
  role app_role not null
)

alter table public.user_roles enable row level security;

-- same issue as public.profiles 
create policy "Enable read for everyone" on public.user_roles
  for select using (true);

create policy "Enable update for user based on id" on public.user_roles
  for update using (
    auth.uid() = user_id
  ) with check (
    role <> 'admin'::app_role
  )


-- user clubs
create table public.user_clubs (
  user_id uuid references public.profiles,
  club_id uuid references public.clubs,
  primary key (user_id, club_id)
)

alter table public.user_clubs enable row level security;

-- same issue as public.profiles 
create policy "Enable read for user based on id" on public.user_clubs
  for select using (true);


-- blogposts
create table public.blogposts (
  id uuid default uuid_generate_v4() primary key,
  created_at default now() timestamptz,
  last_updated default now() timestamptz,
  title character not null,
  desc text,
  slug character not null,
  author character not null,
  thumbnail_path character
);

alter table public.blogposts enable row level security;

create policy "Enable read for everyone" on public.blogposts
  for select using (true);

-- NOT TESTED
create policy "Enable update for users with admin role" on public.blogposts
  for update using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  ) with check (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )


-- blogtags
create table public.blogtags (
  id uuid default uuid_generate_v4() primary key,
  name character not null
);

alter table public.blogtags enable row level security;

create policy "Enable read for everyone" on public.blogtags
  for select using (true);

create policy "Enable insert for users with admin role" on public.blogtags
  for insert with check (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )

create policy "Enable delete for users with admin role" on public.blogtags
  for delete using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )


-- blogpost_tags
create table public.blogpost_tags (
  blogpost_id uuid references public.blogposts,
  blogtag_id uuid references public.blogtags,
  primary key (blogpost_id, blogtag_id)
)

alter table public.blogpost_tags enable row level security;

-- needed for insert & delete
create policy "Enable read for users with admin role" on public.blogpost_tags
  for select using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )

create policy "Enable insert for users with admin role" on public.blogpost_tags
  for insert with check (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )

create policy "Enable delete for users with admin role" on public.blogpost_tags
  for delete using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )


-- contacts
create table public.contacts (
  id uuid default uuid_generate_v4() primary key,
  service character not null,
  value character
)

alter table public.contacts enable row level security;

create policy "Enable read for everyone" on public.contacts
  for select using (true)

create policy "Enable update for users with admin role" on public.contacts
  for update using (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  ) with check (
    auth.uid() in (
      select user_id
      from public.user_roles
      where role = 'admin'::app_role
    )
  )


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
create or replace function public.handle_new_user() 
returns trigger as $$
begin
  insert into public.profiles (id, tp_number)
  values (new.id, upper(split_part(new.email, '@', 1)));

  insert into public.user_roles (user_id, role)
  values (new.id, 'user');

  return new;
end;
$$ language plpgsql security definer;


-- TRIGGERS
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
