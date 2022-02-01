<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session, page }) => {
    const { user, authenticated, role } = session;
    if (authenticated) {
      const path = page.path.split('/');
      const slug = path[path.length - 1];
      const name = slug[0].toUpperCase() + slug.substr(1);

      // prettier-ignore
      const { data: club } = await supabase
        .from('clubs')
        .select()
        .eq('name', name)
        .single()

      // prettier-ignore
      const { data: userClubs } = await supabase
        .from('user_clubs')
        .select('club_id')
        .eq('user_id', user.id)

      return { props: { club, userClubs, role } };
    }
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  import { Button } from 'carbon-components-svelte';

  export let club, userClubs, role;
</script>

<h1>{club.name}</h1>
<img src={'../' + club.thumbnail_path} style="width: 300px" />
<p>{club.desc}</p>
{#if userClubs.includes(club.id)}
  <h2>You are a part of this club</h2>
{:else if role === 'student' || role === 'admin'}
  <Button>Join club</Button>
{/if}
