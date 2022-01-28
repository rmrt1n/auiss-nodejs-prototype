<script context="module">
  import { supabase } from '$lib/db';
  export const load = async ({ session }) => {
    // prettier-ignore
    const { data: clubs, error } = await supabase
      .from('clubs')
      .select();

    if (error) return {};

    return { props: { clubs } };
  };
</script>

<script>
  import AdminClubTable from '$lib/components/AdminClubTable.svelte';
  import AdminClubModal from '$lib/components/AdminClubModal.svelte';

  export let clubs;

  let open = false;
</script>

<h1>Clubs</h1>

<AdminClubTable bind:clubs bind:open />

<AdminClubModal bind:clubs bind:open />
