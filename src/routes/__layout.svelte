<script>
  import 'carbon-components-svelte/css/all.css';
  import '../app.css';
  import { Content, Grid, Theme } from 'carbon-components-svelte';
  import Header from '$lib/components/Header.svelte';
  import { session } from '$app/stores';
  import { goto } from '$app/navigation';
  import { supabase } from '$lib/db';
  import { setAuthCookie, unsetAuthCookie } from '$lib/utils/session';

  supabase.auth.onAuthStateChange(async (event, _session) => {
    if (event !== 'SIGNED_OUT') {
      // THIS CAUSES COOKIE TO NOT BE SET FOR SOME REASON
      // CAUSES GOTRUE API ERROR BUT DOESN'T EFFECT ANYTHING PROBABLY
      // TODO: FIND FIX FOR THIS
      session.set({ user: _session.user });
      await setAuthCookie(_session);
      goto('/profile');
    } else {
      session.set({ user: { guest: true } });
      await unsetAuthCookie(_session);
      goto('/signin');
    }
  });

  let theme = 'g10';
</script>

<Theme bind:theme persist>
  <Header bind:theme bind:user={$session.user} />

  <Content>
    <Grid>
      <slot />
    </Grid>
  </Content>
</Theme>
