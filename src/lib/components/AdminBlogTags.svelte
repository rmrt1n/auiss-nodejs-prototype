<script>
  import { Tag, Form, TextInput } from 'carbon-components-svelte';
  import { supabase } from '$lib/db';

  export let posts, tags;

  let name = '';

  const addTag = async () => {
    if (name === '') return;

    if (tags.filter((e) => e.name === name).length > 0) {
      alert('Tag exists');
      return;
    }

    /// prettier-ignore
    const { data, error } = await supabase.from('blogtags').insert([{ name }]).single();

    alert(error ? error.message : 'Tag added');

    name = '';
    tags = [...tags, data];
  };

  const remTag = async (tag) => {
    // prettier-ignore
    const { error: e1 } = await supabase
      .from('blogpost_tags')
      .delete()
      .match({ blogtag_id: tag.id })

    if (e1) alert(e1.message);

    // prettier-ignore
    const { error } = await supabase
      .from('blogtags')
      .delete()
      .match({ id: tag.id })

    alert(error ? error.message : 'Tag removed');
    tags = tags.filter((e) => e !== tag);
    // need to update the posts var
    posts = posts.map((e) => {
      const newTags = e.tags.filter((f) => f !== tag.name);
      return { ...e, tags: newTags };
    });
  };
</script>

{#each tags as tag}
  <Tag filter on:close={() => remTag(tag)}>{tag.name}</Tag>
{/each}

<Form on:submit={addTag}>
  <TextInput labelText="Add tag" bind:value={name} />
</Form>
