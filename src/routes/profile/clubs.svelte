<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session }) => {
    const { user, authenticated, role } = session;
    if (authenticated) {
      const { data: clubs } = await supabase.from('user_clubs').select().eq('user_id', user.id);
      return { props: { clubs, role } };
    }
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  export let clubs;
  console.log(clubs);
</script>

{#if clubs.length === 0}
  <h1>You are currently not in any clubs</h1>
  <p>Join one <a href="/clubs">here</a></p>
{:else}
  <h1>Your clubs:</h1>
  {#each clubs as club}
    <p>{club.club_id}</p>
  {/each}
{/if}
