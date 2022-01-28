<script context="module">
  import { supabase } from '$lib/db';

  export const load = async () => {
    // prettier-ignore
    const { data: posts, error: error1 } = await supabase
      .from('blogpost_tags_aggr')
      .select();

    if (error1) {
      console.log(error1);
      return;
    }

    const { data: tags, error: error2 } = await supabase.from('blogtags').select();

    if (error2) {
      console.log(error1);
      return;
    }

    return { props: { posts, tags } };
  };
</script>

<script>
  import { Tabs, Tab, TabContent } from 'carbon-components-svelte';
  import AdminBlogPost from '$lib/components/AdminBlogPost.svelte';
  import AdminBlogTags from '$lib/components/AdminBlogTags.svelte';

  export let posts, tags;
</script>

<Tabs autowidth>
  <Tab label="Posts" />
  <Tab label="Tags" />

  <svelte:fragment slot="content">
    <TabContent>
      {#each posts as post}
        <AdminBlogPost bind:post bind:tags />
        <br />
      {/each}
    </TabContent>

    <TabContent>
      <AdminBlogTags bind:tags bind:posts />
    </TabContent>
  </svelte:fragment>
</Tabs>
