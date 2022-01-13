<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ page }) => {
    const path = page.path.split('/');
    const slug = path[path.length - 1];

    // prettier-ignore
    const { data: meta, error } = await supabase
      .from('blogpost_tags_aggr')
      .select()
      .eq('slug', slug)
      .single()

    if (error) console.log(error);

    return {
      props: { meta },
    };
  };
</script>

<script>
  import { Tag, Tile, SkeletonPlaceholder } from 'carbon-components-svelte';

  export let meta;
</script>

<div id="blog-container">
  <h2>{meta.title}</h2>
  <p id="subtitle">Last updated: {new Date(meta.last_updated).toDateString()}</p>
  <div id="tags">
    {#each meta.tags as tag}
      <Tag>{tag}</Tag>
    {/each}
  </div>
  <SkeletonPlaceholder style="width: 100%; margin-bottom: 2rem;" />
  <Tile id="blog-content">
    <slot />
    <p id="author">- {meta.author}</p>
  </Tile>
</div>

<style>
  div {
    max-width: 750px;
  }

  #blog-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  #blog-content {
    max-width: 750px;
    padding: 3rem;
    margin-top: 1rem;
  }

  #tags {
    margin: 0.5rem 0;
  }

  #subtitle {
    color: grey;
  }

  #author {
    text-align: right;
  }
</style>
