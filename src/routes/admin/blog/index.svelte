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
  import {
    Tile,
    TextInput,
    Tag,
    Form,
    Modal,
    Button,
    Tabs,
    Tab,
    TabContent,
  } from 'carbon-components-svelte';

  export let posts, tags;

  let tagOpen = false;
  let blogpost_id = '';
  let newTag = '',
    curTags = [];

  const addTag = async () => {
    console.log(newTag);
    if (newTag === '') return;
    if (tags.filter((e) => e.name === newTag).length > 0) {
      alert('Tag exists');
      return;
    }
    // prettier-ignore
    const { error } = await supabase
      .from('blogtags') 
      .insert([{ name: newTag }])

    alert(error ? error.message : 'Tag added');

    newTag = '';
    tagOpen = false;
  };

  const addPostTag = async () => {
    if (curTags.length === 0) return;

    curTags.map(async (tag) => {
      // prettier-ignore
      const { error } = await supabase
        .from('blogpost_tags')
        .insert([{ blogpost_id, blogtag_id: tag.id }])

      alert(error ? error.message : 'Tag added');

      curTags = [];
      tagOpen = false;
    });
  };

  const isPostTag = (tagName) => {
    return (
      posts.filter((e) => e.id === blogpost_id && e.tags.filter((f) => f === tagName).length > 0)
        .length > 0
    );
  };

  const addCurTag = (tag) => {
    if (curTags.filter((e) => e.id === tag.id && e.name === tag.name).length > 0) return;
    curTags = [...curTags, tag];
  };
</script>

<Tabs autowidth>
  <Tab label="Posts" />
  <Tab label="Tags" />

  <svelte:fragment slot="content">
    <TabContent>
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
            <Tag
              interactive
              type="green"
              on:click={() => ((tagOpen = true), (blogpost_id = post.id))}>Add tag</Tag
            >
          </div>
          <Button href={`/admin/blog/${post.slug}`}>Edit post</Button>
        </Tile>
        <br />
      {/each}
    </TabContent>

    <TabContent>
      {#each tags as tag}
        <Tag filter on:close>{tag.name}</Tag>
      {/each}
      <Form on:submit={addTag}>
        <TextInput labelText="Add tag" bind:value={newTag} />
      </Form>
    </TabContent>
  </svelte:fragment>
</Tabs>

<Modal
  bind:open={tagOpen}
  modalHeading="Add tag"
  primaryButtonText="Confirm"
  size="xs"
  on:submit={addPostTag}
>
  <p>Add tag</p>
  {#if blogpost_id !== ''}
    {#each tags as tag}
      {#if !isPostTag(tag.name)}
        <Tag interactive on:click={() => addCurTag(tag)}>
          {tag.name}
        </Tag>
      {/if}
    {/each}
  {/if}
  <br />
  {#each curTags as tag}
    <Tag filter on:close={() => (curTags = curTags.filter((e) => e.name !== tag.name))}>
      {tag.name}
    </Tag>
  {/each}
</Modal>
