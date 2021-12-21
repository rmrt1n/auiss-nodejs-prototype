<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session }) => {
    const { user, authenticated, role } = session;
    if (authenticated) {
      const { data } = await supabase.from('profiles').select().eq('id', user.id).single();
      return { props: { user, profile: data, role } };
    }
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  import ProfileForm from '$lib/components/ProfileForm.svelte';

  export let profile;
  export let role;

  const { tp_number } = profile;
</script>

{#if role === 'user'}
  <ProfileForm {tp_number} />
{:else}
  <h1>User</h1>
{/if}
