<script context="module">
  import { supabase } from '$lib/db';

  export const load = async () => {
    // prettier-ignore
    const { data: posts, error: error1 } = await supabase
      .from('blogpost_tags_aggr')
      .select();

    if (error1) {
      console.log(error1);
      return;
    }

    const { data: tags, error: error2 } = await supabase.from('blogtags').select();

    if (error2) {
      console.log(error1);
      return;
    }

    return { props: { posts, tags } };
  };
</script>

<script>
  import { Tile, TextInput, Tag, Form, Modal, Button } from 'carbon-components-svelte';

  export let posts, tags;

  let tagOpen = false;

  /* const updateValue = async (key, value, club_id) => { */
  /* // prettier-ignore */
  /* const { error } = await supabase */
  /* .from('blogposts') */
  /* .update({[key]: value}) */
  /* .eq('id', club_id); */

  /* if (error) { */
  /* alert('An error occured!'); */
  /* console.log(error); */
  /* return; */
  /* } */
  /* alert('Value successfully updated'); */
  /* }; */
</script>

{#each posts as post}
  <Tile>
    <img src={'../' + post.thumbnail_path} alt="blog thumbnail" style="width: 30%;" />
    <Form>
      <TextInput labelText="Post Title" bind:value={post.title} />
      <TextInput labelText="Post Description" bind:value={post.desc} />
      <TextInput labelText="Post Slug" bind:value={post.slug} />
      <TextInput labelText="Post Author" bind:value={post.author} />
    </Form>
    <div style="margin-bottom: 1rem">
      {#each post.tags as tag}
        <Tag filter on:close>{tag}</Tag>
      {/each}
      <Tag interactive type="green" on:click={() => (tagOpen = true)}>Add tag</Tag>
    </div>
    <Button href={`/admin/blog/${post.slug}`}>Edit post</Button>
  </Tile>
{/each}

<Modal hasForm bind:open={tagOpen} modalHeading="Add tag" primaryButtonText="Confirm" size="xs">
  <p>Add tag</p>
  {#each tags as tag}
    <Tag interactive>{tag.name}</Tag>
  {/each}
  <TextInput labelText="Add new tag" />
</Modal>
