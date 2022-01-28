<script>
  import { supabase } from '$lib/db';
  import { Modal, Form, FormGroup, TextInput, FileUploader } from 'carbon-components-svelte';

  export let clubs, open;

  let name = '';
  let desc = '';

  const addClub = async () => {
    if (name.trim() === '' || desc.trim() === '') return;

    // prettier-ignore
    const { data, error } = await supabase
      .from('clubs')
      .insert({ name, desc })
      .single()

    if (error) {
      alert(error.message);
      open = false;
      return;
    }

    name = desc = '';
    clubs = [...clubs, data];
    open = false;
  };
</script>

<Modal
  hasForm
  bind:open
  modalHeading="Add club"
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
        labelDescription="Accepted file types: .jpg, .png, .bmp"
        accept={['.jpg', '.jpeg', '.png', '.bmp']}
      />
    </FormGroup>
  </Form>
</Modal>
