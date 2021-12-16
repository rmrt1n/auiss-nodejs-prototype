<script context="module">
  export const load = async ({ session }) => {
    const { user } = session;
    if (user && !user.guest) return { props: { user: user } };
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  import { supabase } from '$lib/db';
  export let user;
  const signOut = async () => {
    await supabase.auth.signOut();
  };
</script>

<h1>Profile</h1>
<div style="white-space: pre-wrap">
  {JSON.stringify(user, null, 2)}
</div>
<button on:click={signOut}>sign out</button>
