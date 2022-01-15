<script>
  import { FileUploaderButton } from 'carbon-components-svelte';

  export let thumbnail_path;
  export let name;

  let src = '../' + thumbnail_path;

  const uploadThumbnail = async (e) => {
    const f = e.target.files[0];
    src = URL.createObjectURL(f);
    // TODO: upload file func
    alert('not implemented yet');
  };
</script>

<div class="club-thumbnail">
  <div class="club-thumbnail-img">
    <img {src} alt={name + ' thumbnail'} style="width: 80px; height: 80px;" />
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
