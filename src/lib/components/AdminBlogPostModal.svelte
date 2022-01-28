<script>
  import { Modal, Tag } from 'carbon-components-svelte';
  import { supabase } from '$lib/db';

  export let post, tags, open;

  let curTags = [];

  const addPostTag = async () => {
    if (curTags.length === 0) return;

    const newRows = curTags.map((e) => ({ blogpost_id: post.id, blogtag_id: e.id }));
    // prettier-ignore
    const { error } = await supabase
      .from('blogpost_tags')
      .insert(newRows)

    if (error) {
      alert(error.message);
      return;
    }

    alert('Tags added');

    post.tags = [...post.tags, ...curTags.map((e) => e.name)];
    curTags = [];
    open = false;
  };

  const isPostTag = (tagName) => {
    return post.tags.filter((e) => e === tagName).length > 0;
  };

  const addCurTag = (tag) => {
    if (curTags.filter((e) => e.id === tag.id).length > 0) return;
    curTags = [...curTags, tag];
  };
</script>

<Modal
  bind:open
  modalHeading="Add tag"
  primaryButtonText="Confirm"
  size="xs"
  on:submit={addPostTag}
>
  <p>Add tag</p>
  {#each tags as tag}
    {#if !isPostTag(tag.name) && !curTags.includes(tag)}
      <Tag interactive on:click={() => addCurTag(tag)}>
        {tag.name}
      </Tag>
    {/if}
  {/each}
  <br />
  {#each curTags as tag}
    <Tag filter on:close={() => (curTags = curTags.filter((e) => e.id !== tag.id))}>
      {tag.name}
    </Tag>
  {/each}
</Modal>
