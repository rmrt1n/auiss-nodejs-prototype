<script context="module">
  import { supabase } from '$lib/db';

  export const load = async () => {
    // prettier-ignore
    let { data: posts, error } = await supabase
      .from('blogpost_tags_aggr')
      .select();

    if (error) {
      console.log(error);
      return;
    }

    return { props: { posts } };
  };
</script>

<script>
  import { DataTable, TextInput } from 'carbon-components-svelte';
  import Thumbnail from '$lib/components/Thumbnail.svelte';

  export let posts;

  const headers = [
    { key: 'title', value: 'Title' },
    { key: 'slug', value: 'Slug' },
    { key: 'author', value: 'Author' },
    { key: 'desc', value: 'Description' },
    { key: 'thumbnail_path', value: 'Thumbnail' },
  ];

  const updateValue = async (key, value, club_id) => {
    // prettier-ignore
    const { error } = await supabase
      .from('blogposts')
      .update({[key]: value})
      .eq('id', club_id);

    if (error) {
      alert('An error occured!');
      console.log(error);
      return;
    }
    alert('Value successfully updated');
  };
</script>

<DataTable title="Blogposts" {headers} rows={posts}>
  <span slot="cell" let:row let:cell>
    {#if cell.key === 'thumbnail_path'}
      <Thumbnail thumbnail_path={cell.value} name={row.title} ratio="3x4" />
    {:else}
      <TextInput
        value={cell.value}
        on:change={(e) => updateValue(cell.key, e.target.value, row.id)}
      />
    {/if}
  </span>
</DataTable>
