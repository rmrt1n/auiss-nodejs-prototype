<script>
  import { supabase } from '$lib/db';
  import { FileUploaderButton, SkeletonPlaceholder } from 'carbon-components-svelte';

  export let thumbnail_path;
  export let name;

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

  const uploadThumbnail = async (e) => {
    const f = e.target.files[0];
    src = URL.createObjectURL(f);
    console.log(f, thumbnail_path);
    const { error } = await supabase.storage.from('bucket').update(thumbnail_path, f, {
      cacheControl: '3600',
      upsert: false,
    });
    if (error) console.log(error);
  };
</script>

<div class="club-thumbnail">
  <div class="club-thumbnail-img">
    {#if loading}
      <SkeletonPlaceholder />
    {:else}
      <img {src} alt={name + ' thumbnail'} style="width: 80px; height: 80px;" />
    {/if}
  </div>
  <FileUploaderButton
    disableLabelChanges
    labelText="Upload image"
    accept={['.jpg', '.jpeg', '.png', '.bmp']}
    on:change={uploadThumbnail}
  />
</div>

<style>
  .club-thumbnail {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
  }

  .club-thumbnail-img {
    margin-bottom: 5px;
  }
</style>
