<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session }) => {
    const { user, authenticated, role } = session;
    if (authenticated) {
      // prettier-ignore
      const { data: profile } = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

      return { props: { profile, role } };
    }
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  import ProfileForm from '$lib/components/ProfileForm.svelte';
  import Profile from '$lib/components/Profile.svelte';

  export let profile;
  export let role;

  const { tp_number } = profile;
</script>

{#if role === 'user'}
  <ProfileForm {tp_number} id={profile.id} bind:role />
{:else}
  <Profile {profile} />
{/if}
