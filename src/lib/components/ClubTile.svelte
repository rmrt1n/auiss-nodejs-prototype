<script>
  import { supabase } from '$lib/db';
  import { ClickableTile, SkeletonPlaceholder } from 'carbon-components-svelte';

  export let name;
  export let desc;
  export let thumbnail_path;

  let loading = true;
  let src;

  const getThumbnail = async () => {
    try {
      const { data, error } = await supabase.storage.from('bucket').download(thumbnail_path);

      if (error) throw error;
      src = URL.createObjectURL(data);
      loading = false;
    } catch (error) {
      // this runs in the server but doesn't affect client
      // can ignore for now
      // console.error('error: cannot download thumbnail')
    }
  };
  getThumbnail();
</script>

<div class="club-tile">
  <ClickableTile>
    <div id="club-thumbnail">
      {#if loading}
        <SkeletonPlaceholder />
      {:else}
        <img {src} alt={name + ' thumbnail'} style="width: 150px; height: 150px" />
      {/if}
    </div>
    <h1>{name}</h1>
    <p>{desc}</p>
  </ClickableTile>
</div>

<style>
  #club-thumbnail {
    margin-bottom: 1rem;
  }
</style>
