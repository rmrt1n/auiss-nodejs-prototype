<script context="module">
  import { supabase } from '$lib/db';
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
  import {
    DataTable,
    Toolbar,
    ToolbarContent,
    Modal,
    ToolbarSearch,
    Button,
    Form,
    FormGroup,
    TextInput,
    FileUploader,
  } from 'carbon-components-svelte';
  import Add16 from 'carbon-icons-svelte/lib/Add16';
  import Thumbnail from '$lib/components/Thumbnail.svelte';

  export let clubs;

  let open = false;
  let name, desc;

  const headers = [
    { key: 'name', value: 'Name' },
    { key: 'desc', value: 'Description' },
    { key: 'thumbnail_path', value: 'Thumbnail' },
  ];

  const updateValue = async (key, value, club_id) => {
    // prettier-ignore
    const { error } = await supabase
      .from('clubs')
      .update({[key]: value})
      .eq('id', club_id);

    if (error) {
      alert('An error occured!');
      console.log(error);
      return;
    }
    alert('Value successfully updated');
  };

  const addClub = async () => {
    console.log(name, desc);
  };
</script>

<h1>Clubs</h1>

<DataTable {headers} rows={clubs}>
  <Toolbar>
    <ToolbarContent>
      <ToolbarSearch />
      <Button icon={Add16} on:click={() => (open = true)}>Add Club</Button>
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

<Modal
  hasForm
  bind:open
  modalHeading="Add new club"
  primaryButtonText="Confirm"
  size="sm"
  on:submit={addClub}
>
  <Form>
    <FormGroup>
      <TextInput required labelText="Club name" bind:value={name} />
    </FormGroup>
    <FormGroup>
      <TextInput required labelText="Club description" bind:value={desc} />
    </FormGroup>
    <FormGroup>
      <FileUploader
        labelTitle="Upload logo"
        buttonLabel="Upload file"
        labelDescription="Accepted file types: .jpg/.jpeg, .png, .bmp"
        accept={['.jpg', '.jpeg', '.png', '.bmp']}
      />
    </FormGroup>
  </Form>
</Modal>
