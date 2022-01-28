<script>
  import { Tile, Form, TextInput, Tag } from 'carbon-components-svelte';
  import { supabase } from '$lib/db';
  import AdminBlogPostModal from './AdminBlogPostModal.svelte';

  export let post, tags;

  let open = false;

  const remPostTag = async (tagName) => {
    const { id: tagId } = tags.filter((e) => e.name === tagName)[0];

    // prettier-ignore
    const { error } = await supabase
      .from('blogpost_tags')
      .delete()
      .match({ blogpost_id: post.id, blogtag_id: tagId })

    if (error) {
      alert(error.message);
      return;
    }

    alert('Tag removed');

    post.tags = post.tags.filter((e) => e !== tagName);
    tags = tags; // to update modal again DONT REMOVE FOR NOW
  };
</script>

<Tile>
  <img src={'../' + post.thumbnail_path} alt="blog thumbnail" style="width: 30%;" />
  <Form>
    <TextInput labelText="Post Title" bind:value={post.title} />
    <TextInput labelText="Post Description" bind:value={post.desc} />
    <TextInput labelText="Post Slug" bind:value={post.slug} />
    <TextInput labelText="Post Author" bind:value={post.author} />
  </Form>
  <div style="margin-bottom: 1rem">
    {#if post.tags[0] !== null}
      {#each post.tags as tag}
        <Tag filter on:close={() => remPostTag(tag)}>{tag}</Tag>
      {/each}
    {/if}
    <Tag interactive type="green" on:click={() => (open = true)}>Add tag</Tag>
  </div>
</Tile>

<AdminBlogPostModal bind:open bind:post bind:tags />
