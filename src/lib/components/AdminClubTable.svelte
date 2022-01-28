<script>
  import { supabase } from '$lib/db';
  import {
    DataTable,
    Toolbar,
    ToolbarBatchActions,
    ToolbarSearch,
    ToolbarContent,
    Button,
    TextInput,
  } from 'carbon-components-svelte';
  import Add16 from 'carbon-icons-svelte/lib/Add16';
  import TrashCan16 from 'carbon-icons-svelte/lib/TrashCan16';
  import Thumbnail from './Thumbnail.svelte';

  export let clubs, open;

  const headers = [
    { key: 'name', value: 'Name' },
    { key: 'desc', value: 'Description' },
    { key: 'thumbnail_path', value: 'Thumbnail' },
  ];

  let selectedRowIds = [];

  const updateValue = async (key, value, clubId) => {
    // prettier-ignore
    const { error } = await supabase
      .from('clubs')
      .update({ [key]: value })
      .eq('id', clubId)

    alert(error ? error.message : 'Value updated');
  };

  const remClubs = async () => {
    const copy = selectedRowIds;

    // prettier-ignore
    const { error } = await supabase
      .from('clubs')
      .delete()
      .in('id', selectedRowIds)

    selectedRowIds = [];
    clubs = clubs.filter((e) => !copy.includes(e.id));
    alert(error ? error.message : 'Clubs removed');
  };
</script>

<DataTable batchSelection sortable bind:selectedRowIds {headers} rows={clubs}>
  <Toolbar>
    <ToolbarBatchActions>
      <Button icon={TrashCan16} on:click={remClubs}>Delete</Button>
    </ToolbarBatchActions>
    <ToolbarContent>
      <ToolbarSearch />
      <Button icon={Add16} on:click={() => (open = true)}>Add club</Button>
    </ToolbarContent>
  </Toolbar>

  <span slot="cell" let:row let:cell>
    {#if cell.key === 'thumbnail_path'}
      <Thumbnail thumbnail_path={cell.value} name={row.name} />
    {:else}
      <TextInput
        value={cell.value}
        on:change={(e) => updateValue(cell.key, e.target.value, row.id)}
      />
    {/if}
  </span>
</DataTable>
