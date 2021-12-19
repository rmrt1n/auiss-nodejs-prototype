<script context="module">
  import { supabase } from '$lib/db';
  export const load = async () => {
    const { data, error } = await supabase.from('club_t').select();

    if (error) {
      console.log(error.message);
      return {};
    }
    return { props: { clubs: data } };
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

<Grid padding>
  <h1 style="margin-bottom: 1.5rem">Clubs</h1>

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
