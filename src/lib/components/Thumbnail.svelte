<script>
  import { FileUploaderButton } from 'carbon-components-svelte';

  export let thumbnail_path;
  export let name;
  export let ratio = '1x1';

  let src = '../' + thumbnail_path;

  const uploadThumbnail = async (e) => {
    const f = e.target.files[0];
    src = URL.createObjectURL(f);
    // TODO: upload file func
    alert('not implemented yet');
  };

  const wh = ratio === '1x1' ? 'width: 80px; height: 80px' : 'width: 120px; height: 80px';
</script>

<div class="thumbnail">
  <div class="thumbnail-img">
    <img {src} alt={name + ' thumbnail'} style={wh} />
  </div>
  <FileUploaderButton
    disableLabelChanges
    labelText="Upload image"
    accept={['.jpg', '.jpeg', '.png', '.bmp']}
    on:change={uploadThumbnail}
  />
</div>

<style>
  .thumbnail {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 10px;
  }

  .thumbnail-img {
    margin-bottom: 5px;
  }
</style>
