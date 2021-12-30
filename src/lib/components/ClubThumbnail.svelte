<script>
  import { supabase } from '$lib/db';
  import { SkeletonPlaceholder } from 'carbon-components-svelte';

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
</script>

{#if loading}
  <SkeletonPlaceholder />
{:else}
  <img {src} alt={name + ' thumbnail'} style="width: 80px; height: 80px;" />
{/if}
