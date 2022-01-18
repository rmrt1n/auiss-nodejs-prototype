<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session }) => {
    // prettier-ignore
    const { data: contacts, error } = await supabase
      .from('contacts')
      .select();

    if (error) return {};

    return { props: { contacts } };
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
  } from 'carbon-components-svelte';
  import Add16 from 'carbon-icons-svelte/lib/Add16';

  export let contacts;

  let open = false;
  let service, value;

  const headers = [
    { key: 'service', value: 'Service' },
    { key: 'value', value: 'Value' },
  ];

  const updateValue = async (key, value, contact_id) => {
    // prettier-ignore
    const { error } = await supabase
      .from('contacts')
      .update({[key]: value})
      .eq('id', contact_id);

    if (error) {
      alert('An error occured!');
      console.log(error);
      return;
    }
    alert('Value successfully updated');
  };

  const addContact = async () => {
    // prettier-ignore
    const { error } = await supabase
      .from('contacts')
      .insert([
        { service, value }
      ])
    alert(error ? error.message : 'Value successfully updated');
    open = false;
  };
</script>

<h1>Contacts</h1>

<DataTable {headers} rows={contacts}>
  <Toolbar>
    <ToolbarContent>
      <ToolbarSearch />
      <Button icon={Add16} on:click={() => (open = true)}>Add Contact</Button>
    </ToolbarContent>
  </Toolbar>

  <span slot="cell" let:row let:cell>
    <TextInput
      value={cell.value}
      on:change={(e) => updateValue(cell.key, e.target.value, row.id)}
    />
  </span>
</DataTable>

<Modal
  hasForm
  bind:open
  modalHeading="Add new contact"
  primaryButtonText="Confirm"
  size="sm"
  on:submit={addContact}
>
  <Form>
    <FormGroup>
      <TextInput required labelText="Service" bind:value={service} />
    </FormGroup>
    <FormGroup>
      <TextInput required labelText="Value" bind:value />
    </FormGroup>
  </Form>
</Modal>
