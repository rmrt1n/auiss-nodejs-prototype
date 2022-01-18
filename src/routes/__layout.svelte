<script>
  import 'carbon-components-svelte/css/all.css';
  import '../app.css';
  import { Content, Grid, Theme } from 'carbon-components-svelte';
  import Header from '$lib/components/Header.svelte';
  import { session } from '$app/stores';
  /* import { goto } from '$app/navigation'; */
  import { supabase } from '$lib/db';
  import { setAuthCookie, unsetAuthCookie } from '$lib/utils/session';

  supabase.auth.onAuthStateChange(async (event, _session) => {
    if (event !== 'SIGNED_OUT') {
      session.set({ user: _session.user });
      await setAuthCookie(_session);
      /* goto('/profile'); */
    } else {
      session.set({ user: { guest: true } });
      await unsetAuthCookie(_session);
      /* goto('/signin'); */
    }
  });

  let theme = 'g10';
  let { authenticated } = $session;
  const role = $session.role;
</script>

<Theme bind:theme persist>
  <Header bind:theme bind:authenticated {role} />

  <Content>
    <Grid>
      <slot />
    </Grid>
  </Content>
</Theme>
