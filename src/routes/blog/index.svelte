<script context="module">
  import { supabase } from '$lib/db';
  export const load = async () => {
    // prettier-ignore
    let { data: posts, error } = await supabase
      .from('blogpost_tags_aggr')
      .select();

    if (error) return {};

    return { props: { posts } };
  };
</script>

<script>
  import { Row, Column } from 'carbon-components-svelte';
  import BlogTile from '$lib/components/BlogTile.svelte';

  export let posts;

  const postRows = [];
  for (let i = 0; i < posts.length; i += 3) {
    postRows.push([posts[i], posts[i + 1], posts[i + 2]]);
  }
</script>

<h1 class="section-title">Blog</h1>
{#each postRows as row}
  <Row>
    {#each row as post}
      <Column>
        {#if post != undefined}
          <BlogTile blog={post} />
        {/if}
      </Column>
    {/each}
  </Row>
{/each}
