<script>
  import { ClickableTile, SkeletonPlaceholder, Tag } from 'carbon-components-svelte';

  export let blog;
</script>

<div>
  <ClickableTile href={'blog/' + blog.slug}>
    <SkeletonPlaceholder />
    <h3>{blog.title}</h3>
    <p>{new Date(blog.last_updated).toDateString()}</p>
    <p>{blog.desc}</p>
    <p>{blog.author}</p>
    {#each blog.tags as tag}
      <Tag>{tag}</Tag>
    {/each}
  </ClickableTile>
</div>
