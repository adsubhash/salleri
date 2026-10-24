-- thankot.com production schema (Supabase/Postgres)
create extension if not exists pgcrypto;
create table if not exists profiles (id uuid primary key references auth.users(id) on delete cascade, username text unique not null, display_name text not null, bio text default '', avatar_url text, created_at timestamptz default now());
create table if not exists posts (id uuid primary key default gen_random_uuid(), user_id uuid not null references profiles(id) on delete cascade, body text default '', media_url text, media_type text, created_at timestamptz default now(), constraint body_len check (char_length(body)<=500));
create table if not exists comments (id uuid primary key default gen_random_uuid(), post_id uuid not null references posts(id) on delete cascade, user_id uuid not null references profiles(id) on delete cascade, body text not null check(char_length(body)<=500), created_at timestamptz default now());
create table if not exists reactions (post_id uuid references posts(id) on delete cascade, user_id uuid references profiles(id) on delete cascade, kind text not null default 'like', created_at timestamptz default now(), primary key(post_id,user_id));
create table if not exists follows (follower_id uuid references profiles(id) on delete cascade, following_id uuid references profiles(id) on delete cascade, created_at timestamptz default now(), primary key(follower_id,following_id), check(follower_id<>following_id));
create table if not exists live_sessions (id uuid primary key default gen_random_uuid(), user_id uuid references profiles(id) on delete cascade, room_name text unique not null, title text default '', status text default 'live', started_at timestamptz default now(), ended_at timestamptz);
create index if not exists posts_created_at_idx on posts(created_at desc);
create index if not exists comments_post_idx on comments(post_id,created_at);
-- Production security: enable RLS and add policies per your auth rules before launch.
alter table profiles enable row level security; alter table posts enable row level security; alter table comments enable row level security; alter table reactions enable row level security; alter table follows enable row level security; alter table live_sessions enable row level security;
create policy "public profiles readable" on profiles for select using (true);
create policy "profiles self insert" on profiles for insert with check (auth.uid()=id);
create policy "profiles self update" on profiles for update using (auth.uid()=id);
create policy "public posts readable" on posts for select using (true);
create policy "users create posts" on posts for insert with check (auth.uid()=user_id);
create policy "users edit posts" on posts for update using (auth.uid()=user_id);
create policy "users delete posts" on posts for delete using (auth.uid()=user_id);
create policy "public comments readable" on comments for select using (true);
create policy "users create comments" on comments for insert with check (auth.uid()=user_id);
create policy "users delete comments" on comments for delete using (auth.uid()=user_id);
create policy "public reactions readable" on reactions for select using (true);
create policy "users manage reactions" on reactions for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "public follows readable" on follows for select using (true);
create policy "users manage follows" on follows for all using (auth.uid()=follower_id) with check (auth.uid()=follower_id);
create policy "public live readable" on live_sessions for select using (true);
create policy "users create live" on live_sessions for insert with check (auth.uid()=user_id);
create policy "users update live" on live_sessions for update using (auth.uid()=user_id);
