<script>
  import { ClickableTile } from 'carbon-components-svelte';

  export let name;
  export let desc;
  export let thumbnail_path;

  const src = thumbnail_path;
</script>

<div class="club-tile">
  <ClickableTile>
    <img {src} alt={name + ' thumbnail'} style="width: 150px; height: 150px" />
    <h1>{name}</h1>
    <p>{desc}</p>
  </ClickableTile>
</div>

<style>
  img {
    margin-bottom: 1rem;
  }
</style>
