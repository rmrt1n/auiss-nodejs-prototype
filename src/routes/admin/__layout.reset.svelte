<script>
  import 'carbon-components-svelte/css/all.css';
  import '../../app.css';
  import { Content, Grid, Theme } from 'carbon-components-svelte';
  import AdminHeader from '$lib/components/AdminHeader.svelte';

  let theme = 'g10';
</script>

<Theme bind:theme persist>
  <AdminHeader bind:theme />

  <Content>
    <Grid>
      <slot />
    </Grid>
  </Content>
</Theme>
