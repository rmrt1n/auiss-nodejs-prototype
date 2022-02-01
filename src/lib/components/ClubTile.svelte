<script>
  import { ClickableTile } from 'carbon-components-svelte';

  export let club;

  const { name, desc, thumbnail_path: src } = club;
</script>

<div class="club-tile">
  <ClickableTile href={`/clubs/${name.toLowerCase()}`}>
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
