<script context="module">
  import { supabase } from '$lib/db';
  import ClubThumbnail from '$lib/components/ClubThumbnail.svelte';
  import { TextInput } from 'carbon-components-svelte';

  export const load = async ({ session }) => {
    // prettier-ignore
    const { data: clubs, error } = await supabase
      .from('clubs')
      .select();

    if (error) return {};

    const { user } = session;

    return { props: { clubs, user } };
  };
</script>

<script>
  import { DataTable } from 'carbon-components-svelte';
  export let clubs;

  const headers = [
    /* { key: 'id', value: 'ID' }, */
    { key: 'name', value: 'Name' },
    { key: 'desc', value: 'Description' },
    { key: 'thumbnail_path', value: 'Thumbnail' },
  ];

  const updateName = async (name, club_id) => {
    // prettier-ignore
    const { error } = await supabase
      .from('clubs')
      .update({ name: name })
      .eq('id', club_id);

    if (error) {
      console.log(error);
      return;
    }
    alert('Name successfully updated');
  };

  const updateDesc = async (desc, club_id) => {
    // prettier-ignore
    const { error } = await supabase
      .from('clubs')
      .update({ desc: desc })
      .eq('id', club_id);

    if (error) {
      console.log(error);
      return;
    }
    alert('Description successfully updated');
  };
</script>

<DataTable title="Clubs" {headers} rows={clubs}>
  <span slot="cell" let:row let:cell>
    {#if cell.key === 'thumbnail_path'}
      <ClubThumbnail thumbnail_path={cell.value} name={row.name} />
    {:else if cell.key === 'name'}
      <TextInput value={cell.value} on:change={(e) => updateName(e.target.value, row.id)} />
    {:else if cell.key === 'desc'}
      <TextInput value={cell.value} on:change={(e) => updateDesc(e.target.value, row.id)} />
    {:else}
      {cell.value}
    {/if}
  </span>
</DataTable>
