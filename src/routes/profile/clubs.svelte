<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session }) => {
    const { user, authenticated, role } = session;
    if (authenticated) {
      // prettier-ignore
      const { data } = await supabase
        .from('user_clubs')
        .select('clubs:club_id(*)')
        .eq('user_id', user.id);

      const clubs = [...data].map((e) => e.clubs);
      return { props: { clubs, role } };
    }
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  import { Grid, Row, Column } from 'carbon-components-svelte';
  import ClubTile from '$lib/components/ClubTile.svelte';

  export let clubs;

  const clubRows = [];
  for (let i = 0; i < clubs.length; i += 3) {
    clubRows.push([clubs[i], clubs[i + 1], clubs[i + 2]]);
  }
</script>

{#if clubs.length === 0}
  <h1>You are currently not in any clubs</h1>
  <p>Join one <a href="/clubs">here</a></p>
{:else}
  <Grid padding>
    <h1>Your clubs:</h1>

    {#each clubRows as row}
      <Row>
        {#each row as club}
          <Column>
            {#if club != undefined}
              <ClubTile name={club.name} desc={club.desc} thumbnail_path={club.thumbnail_path} />
            {/if}
          </Column>
        {/each}
      </Row>
    {/each}
  </Grid>
{/if}
